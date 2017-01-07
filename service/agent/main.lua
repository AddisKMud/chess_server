local skynet = require "skynet"
local socket = require "socket"
local sock_dispatch = require "sock_dispatch"
local protopack = require "protopack"
local login = require "login"
local env = require "env"

local CONF

env.send_msg = function (name, msg)
	local data = protopack.pack(name, msg)
	socket.write(CONF.fd, data)
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

local CMD = {}

function CMD.start(conf)
	CONF = conf
	login.register()
	skynet.call(conf.gate, "lua", "forward", conf.fd)
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
