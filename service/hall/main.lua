local skynet = require "skynet"
require "skynet.manager"

local rooms = {
    {id = 1, quick = true,  addr = nil, player_num=0},
    {id = 2, quick = false, addr = nil, player_num=0},
    {id = 3, quick = false, addr = nil, player_num=0},
    {id = 4, quick = false, addr = nil, player_num=0}
}

local CMD = {}

function CMD.start()
    log.log("starting hall... ")
    
    -- 生成四个房间
    for _,room in ipairs(rooms) do
        room.addr = skynet.newservice("room",room.id,room.quick)
        skynet.call(room.addr,"lua","start")
    end
end

function CMD.list()
    return rooms
end

function CMD.info(room_id)
    local info = rooms[room_id]
    if not info then
        return false
    end

    return info
end

skynet.start(function()
    skynet.dispatch("lua",function(session,source,cmd,...)
        print(session,source)
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
