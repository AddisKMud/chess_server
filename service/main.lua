local skynet = require "skynet"
local utils = require "utils"

skynet.start(function()
    skynet.error("Server start")

    skynet.newservice("debug_console",skynet.getenv("debug_port"))


    skynet.newservice("httpserver",9999,"httpagent",10)

--[[    skynet.newservice("pbc")

    local service = skynet.newservice("db")
    skynet.send(service, "lua", "start",{
        host = skynet.getenv("mongo_host"),
        db_name = skynet.getenv("mongo_db")
    })

    service = skynet.newservice("hall")
    skynet.call(service, "lua", "start")

    local watchdog = skynet.newservice("watchdog")
    skynet.call(watchdog, "lua", "start", {
        port = tonumber(skynet.getenv("gate_port")),
        maxclient = tonumber(skynet.getenv("gate_max_client")),
        nodelay = true,
    })
]]--
    skynet.exit()
end)
