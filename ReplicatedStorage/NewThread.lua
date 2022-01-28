--[[
	interpreterK
	Shrek exe 2, NewThread Module
    https://github.com/interpreterK/Shrek-exe-2-Github
]]

local resume = coroutine.resume
local create = coroutine.create

return function(thread)
	local bool, err = resume(create(thread))
	if not bool then
		warn("thread error/warning @", script:GetFullName(), ":", err)
		print("thread trace:", debug.traceback())
	end
end