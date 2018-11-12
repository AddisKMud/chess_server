local skynet = require "skynet"
require "skynet.manager"
local mgr = require "mgr"

local CMD = {}

-- 注册账号
function CMD.register()

end

-- 验证账号
function CMD.verify()

end





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

    skynet.register("hall")
end)
