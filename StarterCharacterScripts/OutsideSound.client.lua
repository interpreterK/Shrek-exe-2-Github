--[[
	interpreterK
	Shrek exe 2, OutsideSound Script for noises when outside
    https://github.com/interpreterK/Shrek-exe-2-Github
]]

local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local TS = game:GetService("TweenService")

local floor = math.floor

local Player = Players.LocalPlayer
local Character = Player.Character
local Root = Character:WaitForChild("HumanoidRootPart")
local Outside = script:WaitForChild("Outside")
local Map = workspace:WaitForChild("Map")

local Sandstorm = Map:FindFirstChild("Ambient")
if not Sandstorm then
	Sandstorm = Instance.new("Sound")
	Sandstorm.Name = "Ambient"
	Sandstorm.SoundId = 'rbxassetid://1298950649'
	Sandstorm.Volume = 0
	Sandstorm.Looped = true
	Sandstorm.Playing = true
	Sandstorm.Parent = workspace:WaitForChild("Map")
end

local function PlayAmbient()
	TS:Create(Sandstorm, TweenInfo.new(2), {Volume = 0.1}):Play()
end

local function StopAmbient()
	TS:Create(Sandstorm, TweenInfo.new(1), {Volume = 0}):Play()
end

Outside:GetPropertyChangedSignal("Value"):Connect(function()
	if Outside.Value then
		PlayAmbient()
	else
		StopAmbient()
	end
end)

RS.Heartbeat:Connect(function()
	if floor(Root.Position.Y) < 65 then
		-- Underground in area-51
		Outside.Value = false
	else
		-- Is above
		Outside.Value = true
	end
end)