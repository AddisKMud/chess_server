local skynet = require "skynet"
require "skynet.manager"
local player_mgr = require "player_mgr"


local CMD = {}

skynet.start(function()
    skynet.register("lua",function(session,source,cmd,...)
        local f = CMD[cmd]
        assert(f,"cmd not exist cmd="..(cmd or nil))

        if session == 0 then
            f(...)
        else
            skynet.ret(skynet.pack(f(...)))
        end
    end)
end)
