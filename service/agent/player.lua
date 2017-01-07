
local Player = {
	account = nil
}

-- 数据库加载玩家数据
function Player:load(account)
	self.account = account

end

return Player
