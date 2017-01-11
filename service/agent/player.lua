
local Player = {}

Player.__index = Player

function Player.new()
	local o = {}
	setmetatable(o, Player)
	return o
end

-- 数据库加载玩家数据
function Player:load(account)
	self.account = account
	self.name = "哈哈哈"
end

return Player
