local skynet = require "skynet"
local Env = require "env"
local Room = require "room"
local Log = require "log"

local CMD = {}

function CMD.start(conf)
	Log.log("starting room %d", conf.id)
	Env.id = conf.id	
	Env.room = Room.new()
	Env.room:init()
	return true
end

function CMD.enter(info)
	if Env.room:enter(info) then
		return true
	else
		return false
	end
end

function CMD.leave(id)
	Env.room:leave(id)
end

skynet.start(function ()
	skynet.dispatch("lua", function (_, _, cmd, ...)
		local f = CMD[cmd]
		if f then
			skynet.ret(skynet.pack(f(...)))
		else
			skynet.ret(skynet.pack(nil, "cant find handle of "..cmd))
		end
	end)
end)
