local skynet = require "skynet"
local netpack = require "netpack"
local socket = require "socket"
local sock_dispatch = require "sock_dispatch"
local protopack = require "protopack"

local WATCHDOG
local send_request

local CMD = {}
local REQUEST = {}
local client_fd

local function send_package(pack)
	local package = string.pack(">s2", pack)
	socket.write(client_fd, package)
end

skynet.register_protocol {
	name = "client",
	id = skynet.PTYPE_CLIENT,
	unpack = function (data, sz)
		local data_str = netpack.tostring(data, sz)
		local name, msg = protopack.unpack(data_str)
		return name, msg
	end,
	dispatch = function (_, _, name, msg)
		sock_dispatch:dispatch(name, msg)	
	end
}

function CMD.start(conf)
	local fd = conf.client
	local gate = conf.gate
	WATCHDOG = conf.watchdog
	client_fd = fd
	skynet.call(gate, "lua", "forward", fd)
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
