local skynet = require "skynet"
require "skynet.manager"
local bsonlib = require "bson" 
local mongo = require "mongo"

local db_client
local db

local CMD = {}

function CMD.start(conf)
    db_client = mongo.client(conf)
    db_client:getDB(conf.db_name)
    db = db_client[conf.db_name]
end

function CMD.findOne(cname, selector, field_selector)
    return db[cname]:findOne(selector, field_selector)
end

function CMD.find(cname, selector, field_selector)
    return db[cname]:find(selector, field_selector)
end

function CMD.update(cname, ...)
    local collection = db[cname]
    collection:update(...)
    local r = db:runCommand("getLastError")
    if r.err ~= bsonlib.null then
        return false, r.err
    end

    if r.n <= 0 then
        skynet.error("mongodb update "..cname.." failed")
    end

    return ok, r.err
end

local ops = {'insert', 'batch_insert', 'delete'}
for _, v in ipairs(ops) do
    CMD[v] = function(self, cname, ...)
        local c = db[cname]
        c[v](c, ...)
        local r = db:runCommand('getLastError')
        local ok = r and r.ok == 1 and r.err == Bson.null
        if not ok then
            skynet.error(v.." failed: ", r.err, tname, ...)
        end
        return ok, r.err
    end
end

skynet.start(function()
    skynet.dispatch("lua", function (session, addr, cmd, ...)
        local f = CMD[cmd]
        assert(f)
        if session == 0 then
            f(...)
        else
            skynet.ret(skynet.pack(f(...)))
        end
    end)

    skynet.register("db")
end)
