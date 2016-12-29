local skynet = require "skynet"
local utils = require "utils"

local max_client = 64

skynet.start(function()
	skynet.error("Server start")

	skynet.newservice("console")
	skynet.newservice("debug_console",8000)

	local watchdog = skynet.newservice("watchdog")
	skynet.call(watchdog, "lua", "start", {
		port = 8888,
		maxclient = max_client,
		nodelay = true,
	})
	skynet.error("Watchdog listen on", 8888)

	local service = skynet.newservice("pbc")

	local msg = {account = "haha", token = "hehe"}
	local data = skynet.call(service, "lua", "encode", "Login.Login", msg)
	local de_msg = skynet.call(service, "lua", "decode", "Login.Login", data)
	utils.print(msg)
	utils.print(de_msg)

	service = skynet.newservice("mongodb")
	skynet.send(service, "lua", "init")

	skynet.exit()
end)
