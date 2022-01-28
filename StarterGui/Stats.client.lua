--[[
	interpreterK
	Shrek exe 2, Status Script to show the active or alive Shreks
    https://github.com/interpreterK/Shrek-exe-2-Github
]]

local Storage = game:GetService("ReplicatedStorage")

local Values = Storage:WaitForChild("Values")
local ShreksAlive = Values:WaitForChild("ShreksAlive")
local MaxShreks = Values:WaitForChild("MaxShreks")
local ShreksKilled = Values:WaitForChild("ShreksKilled")

local TextLabel = script.Parent

local function UpdateText(Kills, Alive)
	TextLabel.Text = "Shreks Kills: "..Kills..". Shreks Alive: "..Alive.."/"..MaxShreks.Value.."."
end

UpdateText(ShreksKilled.Value, ShreksAlive.Value)
ShreksAlive:GetPropertyChangedSignal("Value"):Connect(function()
	UpdateText(ShreksKilled.Value, ShreksAlive.Value)
end)
MaxShreks:GetPropertyChangedSignal("Value"):Connect(function()
	UpdateText(ShreksKilled.Value, ShreksAlive.Value)
end)
ShreksKilled:GetPropertyChangedSignal("Value"):Connect(function()
	UpdateText(ShreksKilled.Value, ShreksAlive.Value)
end)