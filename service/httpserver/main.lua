local skynet = require "skynet"
local socket = require "skynet.socket"

local port,agentname,agentnum = ...

skynet.start(function()
    local agents = {}

    for i=1,agentnum do
        agents[i] = skynet.newservice(agentname) 
    end


    local balance = 1
    skynet.error("Listen web port "..port)

    local id = socket.listen("0.0.0.0",port)
    socket.start(id,function(_id,addr)
        skynet.send(agents[balance],"lua",_id)
        balance = balance + 1
        if balance > #agents then
            balance = 1
        end
    end)
end)
