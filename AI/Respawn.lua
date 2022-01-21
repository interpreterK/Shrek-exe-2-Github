--[[
	interpreterK
	Shrek exe 2, Respawn Script for the Shreks.
	https://github.com/interpreterK/Shrek-exe-2-Github
]]
--This doesn't wanna do its job most of the time in AI so why not just move it to another script/container

local Players = game:GetService("Players")

-- Respawn/AI Configuration
local CorpseRemovalDelay = Players.RespawnTime --(Seconds)
local RespawnTime = {10, 60}
--

--Wait for dependancies
script.Parent:WaitForChild("Respawn")
script.Parent:WaitForChild("AI")
script.Parent:WaitForChild("Animate")

local Humanoid = script.Parent:WaitForChild("Humanoid")
local RespawnShrek = script.Parent:Clone() --Have a stand by Shrek ready to spawn in once this one dies
RespawnShrek:WaitForChild("AI"):WaitForChild("Angry").Value = false

local function pseudorandom(min, max)
	return Random.new():NextNumber(min, max)
end

Humanoid.Died:Connect(function()
	local Shrek = script.Parent
    wait(CorpseRemovalDelay)
	Shrek.Parent = nil --Send the model to a place where its not visible for the time being
	wait(pseudorandom(unpack(RespawnTime)))
	RespawnShrek.Parent = workspace.Npc
	Shrek:Destroy() --Clean up garbage
end)