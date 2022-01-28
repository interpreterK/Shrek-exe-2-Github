--[[
	interpreterK
	Shrek exe 2, Players Script for managing data for incoming or leaving players.
    https://github.com/interpreterK/Shrek-exe-2-Github
]]

local Players = game:GetService("Players")

local function leaderstats(player)
    local Folder = Instance.new("Folder")
    local TweeningPoints = Instance.new("IntValue")
    local Points = Instance.new("IntValue") --The point of "Real" data types is so saving data wont overwrite old data with an on going tween leaving inaccurate saves
    local Kills = Instance.new("IntValue")
    local Deaths = Instance.new("IntValue")

    Folder.Name = "leaderstats"
    TweeningPoints.Name = "Points"
    Points.Name = "Real"
    Kills.Name = "Kills"
    Deaths.Name = "Deaths"

    TweeningPoints.Parent = Folder
    Points.Parent = TweeningPoints
    Kills.Parent = Folder
    Deaths.Parent = Folder
    Folder.Parent = player
end

Players.PlayerAdded:Connect(function(player)
    leaderstats(player)
end)