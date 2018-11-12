local skynet = require "skynet"
local socket = require "skynet.socket"
local httpd = require "http.httpd"
local sockethelper = require "http.sockethelper"
local urllib = require "http.url"
local table = table
local string = string
local io = io

local cache = {}

local function get_file(path)
    local data = cache[path]
    if data then
        return 200,data
    end

    local full_path = "./client"..path
    local f = io.open(full_path,"r")
    if not f then
        return 404
    end

    data = f:read("*a")

    f:close()

    cache[path] = data

    return 200,data
end

local function response_error(id,code)
    local ok, err = httpd.write_response(sockethelper.writefunc(id),code,headers)
end

local function response(id,code,data)
    local headers = {["Content-Type"]="text/html;"}
    local ok, err = httpd.write_response(sockethelper.writefunc(id), code,data,headers)
    if not ok then
        -- if err == sockethelper.socket_error , that means socket closed.
        skynet.error(string.format("fd = %d, %s", id, err))
    end
end

skynet.start(function()
    skynet.dispatch("lua", function (_,_,id)
        socket.start(id)
        -- limit request body size to 8192 (you can pass nil to unlimit)
        local code, url, method, header, body = httpd.read_request(sockethelper.readfunc(id), 8192)
        if code then
            if code ~= 200 then
                response(id, code)
            else
                local path, query = urllib.parse(url)
                local code,data = get_file(path)
                if code ~= 200 then
                    response_error(id, code)
                else
                    response(id,200,data)
                end
            end
        else
            if url == sockethelper.socket_error then
                skynet.error("socket closed")
            else
                skynet.error(url)
            end
        end
        socket.close(id)
    end)
end)
