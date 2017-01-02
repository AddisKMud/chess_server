local skynet = require "skynet"
local netpack = require "netpack"
local socket = require "socket"
local sock_dispatch = require "sock_dispatch"
local protopack = require "protopack"
local login = require "login"

local WATCHDOG
local send_request

local CMD = {}
local REQUEST = {}
local client_fd

function send_msg(name, msg)
	local data = protopack.pack(name, msg)
	print("send", #data)
	socket.write(client_fd, data)
end

local function send_package(pack)
	local package = string.pack(">s2", pack)
	socket.write(client_fd, package)
end

skynet.register_protocol {
	name = "client",
	id = skynet.PTYPE_CLIENT,
	unpack = function (data, sz)
		return skynet.tostring(data,sz)
	end,
	dispatch = function (_, _, str)
		local name, msg = protopack.unpack(str)
		sock_dispatch:dispatch(name, msg)	
	end
}

function CMD.start(conf)
	local fd = conf.client
	local gate = conf.gate
	WATCHDOG = conf.watchdog
	client_fd = fd
	skynet.call(gate, "lua", "forward", fd)

	login.register()
end

function CMD.disconnect()
	skynet.exit()
end

skynet.start(function()
	skynet.dispatch("lua", function(_,_, command, ...)
		local f = CMD[command]
		skynet.ret(skynet.pack(f(...)))
	end)
end)
