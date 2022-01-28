--[[
	interpreterK
	Shrek exe 2, Lighting Script to load the in game lighting esthetics on game start for ease of visiblity for the devs in studio.
    https://github.com/interpreterK/Shrek-exe-2-Github
]]

local Lighting = game:GetService("Lighting")
local Storage = game:GetService("ServerStorage")

local Esthetics = Storage:WaitForChild("Lighting")

for _, Mod in next, Esthetics:GetChildren() do
    if not Mod:IsA("Clouds") then
        Mod.Parent = Lighting
    else
        Mod.Parent = workspace:WaitForChild("Terrain")
    end
end

print(script.Name .. ".lua: Making the game look pretty with the lighting... (Init)")