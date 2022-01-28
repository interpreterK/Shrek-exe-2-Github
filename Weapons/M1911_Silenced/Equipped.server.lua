--[[
	interpreterK
	Shrek exe 2, Equipped Script to toggle equipping animations
    https://github.com/interpreterK/Shrek-exe-2-Github
]]

local Tool = script.Parent

local Equip = Instance.new("Animation")
Equip.AnimationId = 'rbxassetid://8651305288'
local Unequip = Instance.new("Animation")
Unequip.AnimationId = 'rbxassetid://8658212299'

Tool.Equipped:Connect(function()
    local Character = Tool.Parent
    local Animator = Character.Humanoid.Animator
    local Animation = Animator:LoadAnimation(Equip)
    Animation:Play()
    Animation.Stopped:Wait()
    Animation:AdjustSpeed(0)
end)

Tool.Unequipped:Connect(function()
    local Character = Tool.Parent.Parent.Character
    local Animator = Character.Humanoid.Animator
    local Animation = Animator:LoadAnimation(Unequip)
    Animation:Play()
    Animation.Stopped:Wait()
    Animation:AdjustSpeed(0)
end)