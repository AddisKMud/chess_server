local sock_dispatch = require "sock_dispatch"

local M = {}

function M.login(msg)
	print(msg.account)
	print(msg.token)
	--send_msg("Login.Login", msg)
end

function M.register()
	sock_dispatch:register("Login.Login", M.login)	
end

return M
