local env = require "env"
local player = require "player"

local M = {}

function M.room_msg(msg)
	if not env.room then
		return
	end

	local resp = skynet.call(env.room, "lua", "client", msg)
	if resp then
		env.send_msg(resp.name, resp.msg)
	end
end

function M.register()
	env.dispatcher:register("Room.EnterReq", M.room_msg)
	env.dispatcher:register("Room.LeaveReq", M.room_msg)
	env.dispatcher:register("Room.SitdownReq", M.room_msg)
	env.dispatcher:register("Room.StandupReq", M.room_msg)
	env.dispatcher:register("Table.SitdownReq", M.room_msg)
	env.dispatcher:register("Table.StandupReq", M.room_msg)
	env.dispatcher:register("Table.StartReq", M.room_msg)
	env.dispatcher:register("Table.StartConformReq", M.room_msg)
	env.dispatcher:register("Table.MoveReq", M.room_msg)
end

return M
