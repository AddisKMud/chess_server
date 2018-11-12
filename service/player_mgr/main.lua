local skynet = require "skynet"
local socket = require "socket"
local dispatcher = require "dispatcher"
local login = require "handler.login"
local room = require "handler.room"
local table = require "handler.table"
local env = require "env"
local player = require "player"

local CONF

local CMD = {}

function CMD.start(conf)
    CONF = conf
    env.account = conf.account
    player:load()
    login.register()
    room.register()
    table.register()
    skynet.call(conf.gate, "lua", "forward", conf.fd)
end

function CMD.disconnect()
    skynet.exit()
end

function CMD.send(name, msg)
    env.send_msg(name, msg)
end

skynet.start(function()
    skynet.dispatch("lua", function(_,_, command, ...)
        local f = CMD[command]
        skynet.ret(skynet.pack(f(...)))
    end)
end)
