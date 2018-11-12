local skynet = require "skynet"
local env = require "env"

local M = {}

M.__index = M

function M.new()
    local o = {
        id = env.room:get_tab_id()
    }
    setmetatable(o, M)
    return o
end

function M:init(p1, p2)
    self.red = p1
    self.black = p2
    self.status = "wait"


    local msg1 = {
        i_am_red = true,
        name = p2.name,
        lv = p2.lv,
        icon = p2.icon
    }

    skynet.send(p1.agent, "lua", "send", "Table.MatchResult", msg1)

    local msg2 = {
        i_am_red = false,
        name = p1.name,
        lv = p1.lv,
        icon = p1.icon
    }

    skynet.send(p2.agent, "lua", "send", "Table.MatchResult", msg2)
end

function M:move(info, msg)
    skynet.send(self.red.agent, "lua", "send", "Table.MoveNotify", msg)
    skynet.send(self.black.agent, "lua", "send", "Table.MoveNotify", msg)
end

return M
