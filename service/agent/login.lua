local sock_dispatch = require "sock_dispatch"
local env = require "env"
local M = {}

function M.login(msg)
	print(msg.account)
	print(msg.token)
	env.send_msg("Login.LoginRsp", msg)
end

function M.register()
	sock_dispatch:register("Login.Login", M.login)
end

return M
