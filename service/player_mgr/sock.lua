local protopack = require "protopack"

local M = {}

function M.send_msg (name, msg)
    local data = protopack.pack(name, msg)
    socket.write(CONF.fd, data)
end

local sock_dispatcher = dispatcher.new()
M.sock_dispatcher = sock_dispatcher

skynet.register_protocol {
    name = "client",
    id = skynet.PTYPE_CLIENT,
    unpack = function (data, sz)
        return skynet.tostring(data,sz)
    end,
    dispatch = function (_, _, str)
        local name, msg = protopack.unpack(str)
        M.sock_dispatcher:dispatch(name, msg)
    end
}

return M
