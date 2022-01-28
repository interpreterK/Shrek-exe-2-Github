--[[
	interpreterK
	Shrek exe 2, Sprint Script to toggle sprint
    https://github.com/interpreterK/Shrek-exe-2-Github
]]

local TS = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local Humanoid = script.Parent:WaitForChild("Humanoid")
local CC = workspace.CurrentCamera
local FOV = CC.FieldOfView
local WS = Humanoid.WalkSpeed

local Time = TweenInfo.new(0.30)

local function Sprint()
	TS:Create(Humanoid, Time, {WalkSpeed = WS + 14}):Play()
	TS:Create(CC, Time, {FieldOfView = FOV + 9}):Play()
end

local function Walk()
	TS:Create(Humanoid, Time, {WalkSpeed = WS}):Play()
	TS:Create(CC, Time, {FieldOfView = FOV}):Play()
end

UIS.InputBegan:Connect(function(input, gameProcessedEvent)
	if not gameProcessedEvent then
		if input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.RightShift then
			Sprint()
		end
	end
end)
UIS.InputEnded:Connect(function(input, gameProcessedEvent)
	if not gameProcessedEvent then
		if input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.RightShift then
			Walk()
		end
	end
end)