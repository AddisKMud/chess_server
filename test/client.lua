package.cpath = "./skynet/luaclib/?.so"
package.path = "./skynet/lualib/?.lua"


local socket = require "clientsocket"

local fd = assert(socket.connect("127.0.0.1", 8888))

local function send(data)
	local package = string.pack(">s2",data)
	socket.send(fd, package)
end

send("hello")
socket.close(fd)
