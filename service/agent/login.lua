local env = require "env"
local dispatcher = env.dispatcher

local M = {}


function M.ready()
end

function M.register()
	dispatcher:register("Login.Ready", M.ready)
end

return M
