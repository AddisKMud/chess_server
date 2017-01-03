local skynet = require "skynet"

local CMD = {}

function CMD.init(conf)

end

function CMD.enter()

end

function CMD.leave()

end

skynet.start(function ()
	skynet.dispatch("lua", function(_, _, cmd, ...)
		
	end)
end)
	
