--[[
	interpreterK
	Shrek exe 2, ShrekCount Script to update the Shrek Status
    https://github.com/interpreterK/Shrek-exe-2-Github
]]

local Storage = game:GetService("ReplicatedStorage")

local Values = Storage:WaitForChild("Values")
local ShreksAlive = Values:WaitForChild("ShreksAlive")
local MaxShreks = Values:WaitForChild("MaxShreks")
local ShreksKilled = Values:WaitForChild("ShreksKilled")

local Npc = workspace:WaitForChild("Npc")
local Spawned = Npc:GetChildren()

MaxShreks.Value = #Spawned
ShreksAlive.Value = MaxShreks.Value

local function TrackHumanoid(Model)
	local Humanoid = Model:WaitForChild("Humanoid", 3)
	if Humanoid then
		Humanoid.Died:Connect(function()
			ShreksAlive.Value -= 1
			ShreksKilled.Value += 1
		end)
		return true
	end
	return false
end

for i = 1, #Spawned do
	TrackHumanoid(Spawned[i])
end
Npc.ChildAdded:Connect(function(child)
	local Connected = TrackHumanoid(child)
	if Connected then
		ShreksAlive.Value += 1
	else
		warn("Unknown entity: \"", child.Name, "\" was added to the Npc's folder ")
	end
end)