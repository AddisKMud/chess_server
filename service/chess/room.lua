local Tab = require "tab"
local Utils = require "utils"

Utils.print(Table)

local M = {}

M.__index = M

function M.new()
	local o = {
		players = {},
		tables = {}
	}
	setmetatable(o, M)
	return o
end

function M:init(id)
	for i=1,10 do
		local t = Tab.new()
		t:init()
		table.insert(self.tables, t)
	end
end

function M:enter(info)
	local old = self.players[info.id]
    if old then
		return false
	end

	self.players[info.id] = info
	return true
end

function M:leave(id)
	self.players[id] = nil
end

return M
