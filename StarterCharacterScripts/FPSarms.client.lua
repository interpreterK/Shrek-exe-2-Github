--[[
	interpreterK
	Shrek exe 2, FPSarms Script to have arms in 1st person
    https://github.com/interpreterK/Shrek-exe-2-Github
]]

local Character = script.Parent
local Arms = {
    Character:WaitForChild("Right Arm"),
    Character:WaitForChild("Left Arm")
}

for i = 1, #Arms do
    Arms[i].LocalTransparencyModifier = Arms[i].Transparency
    Arms[i]:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(function()
        Arms[i].LocalTransparencyModifier = Arms[i].Transparency
    end)
end