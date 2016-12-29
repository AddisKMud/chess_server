local skynet = require "skynet"

local M = {}

function M.pack(name, msg)
	local buf = skynet.call("protobuf", "lua", "encode", name, msg)
	local len = 1 + #name + #data + 2
	return string.pack(">Hs1s2", len, name, data)
end

function M.unpack(data)
	local name, buf = string.unpack(">s1s2", data)
	local msg = skynet.call("protobuf", "lua", "decode", name, buf)
	return name, msg
end

return M
