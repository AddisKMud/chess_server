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

function M:enter()

end

function M:leave()

end

return M
