--[[
	interpreterK
	Shrek exe 2, AI Script for the Shreks.
	https://github.com/interpreterK/Shrek-exe-2-Github
]]

local Pathfinding = game:GetService("PathfindingService")
local ChatService = game:GetService("Chat")
local Storage = game:GetService("ServerStorage")
local Players = game:GetService("Players")
local RS = game:GetService("RunService")

-- AI Configuration
local DetectRange = 100 --(Studs)
local SearchRate = .30 --(Seconds)
local WanderRate = 1 --(Seconds)
local DetectionDelay = {1, 2} --(Seconds)
local AngryWalkSpeed = 30
local WanderWalkSpeed = 16
local Damage = 30
local Health_Regen_Rate = 1/100
local Health_Regen_Steps = 1
local DamageDebounce = .10
local CorpseRemovalDelay = Players.RespawnTime --(Seconds)
local RespawnTime = {10, 60}
local Dialog = {
	"what are you doing in my swamp!",
	"Ogres!",
	"LAYERS!!!!!",
	"LLLLLLLLLLLLLLLLLLLLLAAAAAAAAAAAAAAAAAYYYYYYERS!!!",
	"ROOOOOOOOOOOOOOOOOOOOOOOOAR!",
	"GET OVER HERE!",
	"DONKEY?!",
	"FARQUAAD.",
	"get out of my swamp!!!",
	"this is my swamp!"
}
--

local Par = script.Parent
local Torso = Par:WaitForChild("Torso")
local SpawnPoint = Torso.CFrame

local Angry = script:WaitForChild("Angry")
local Jumpscare = script:WaitForChild("ONO")
local Humanoid = Par:WaitForChild("Humanoid")
local Head = Par:WaitForChild("Head")

local Target
local this
local HitDebounce = false

local floor = math.floor
local random = math.random
local min = math.min
local resume = coroutine.resume
local create = coroutine.create

local function Nthread(thread)
	local bool, err = resume(create(thread))
	if not bool then
		warn("thread error/warning @", script:GetFullName(), ":", err)
		print("thread trace:", debug.traceback())
	end
end

local function pseudorandom(min, max)
	return Random.new():NextNumber(min, max)
end

local function Pathfind_ChaseTarget()
	local TT = Target.Torso
	local TH = Target.Humanoid
	local Pos = TT.Position
	
	if this ~= Target then
		this = Target
		
		local Path = Pathfinding:FindPathAsync(Head.Position, Pos)
		local Ways = Path:GetWaypoints()
		Path.Blocked:Connect(function()
			warn("Pathway blocked for Shrek. start=", Head.Position, "goal=", Pos)
		end)

		if Ways.Status == Enum.PathStatus.NoPath then
			warn("No pathway available for Shrek. start=", Head.Position, "goal=", Pos)
			Humanoid:MoveTo(Pos, TT)
		else
			for i = 1, #Ways do
				if TH.Health < 1 then
					--Target died
					break
				end
				local Way = Ways[i]
				if Way.Action == Enum.PathWaypointAction.Jump then
					Humanoid.Jump = true
				end
				Humanoid:MoveTo(Way.Position)
				if i == #Ways then
					--Stop getting stuck on your own intelligence shrek!!
					Humanoid:MoveTo(Pos, TT)
					break
				end
				Humanoid.MoveToFinished:Wait()
			end
		end
	else
		--Cut the pathfinding and focus entirely on chasing the player as much as the ai can
		--print("Absolute following")
		Humanoid:MoveTo(Pos, TT)
	end
end

local function ScanForNearestTarget()
	local List = workspace:GetChildren()

	for i = 1, #List do
		local Inst = List[i]
		local nand = (Inst ~= Par) and Inst:IsA("Model")
		if nand then
			local Hum = Inst:FindFirstChild("Humanoid")
			local tarTorso = Inst:FindFirstChild("Torso")
			local FF = Inst:FindFirstChild("ForceField")

			local nand = (not FF) and (Hum and Hum.Health > 0)
			if nand then
				local Magnitude = (tarTorso.Position - Torso.Position).Magnitude
				if floor(Magnitude) <= DetectRange then
					Target = Inst
				else
					Target = nil
				end
				break --Break after finding a player or lets not nest or tie up detecting players
			else
				Target = nil
			end
		end
	end
end

local function AngryMode()
	wait(pseudorandom(unpack(DetectionDelay)))

	ChatService:Chat(Head, Dialog[random(1, #Dialog)])
	Nthread(function()
		while Angry.Value do
			wait(pseudorandom(10, 60))
			if Target then
				ChatService:Chat(Head, Dialog[random(1, #Dialog)])
			end
		end
	end)
	while Angry.Value do
		Humanoid.WalkSpeed = AngryWalkSpeed
		if Humanoid.Sit then
			wait(1)
			Humanoid.Sit = false
			Humanoid.Jump = true
		end
		Pathfind_ChaseTarget()
		RS.Heartbeat:Wait()
	end
end

local function WanderMode()
	this = nil
	local Wandering = false

	while not Angry.Value do
		Humanoid.WalkSpeed = WanderWalkSpeed
		if not Wandering then
			wait(pseudorandom(2, 6)) --Count down to start wandering around
			if not Angry.Value then
				Humanoid:MoveTo(Vector3.new(pseudorandom(-280, 280), 0, pseudorandom(-280, 280)), workspace.Terrain)
				Wandering = true
				wait(pseudorandom(2, 12)) --Count down to stop wandering around
			end
			Wandering = false
		end
		wait(WanderRate)
	end
end

local function JumpScare(Player)
	local Pgui = Player.PlayerGui
	if not Pgui:FindFirstChild("ONO") then
		Jumpscare:Clone().Parent = Player.PlayerGui
	end
end

local function HitAttack(Touch)
	if not HitDebounce then
		local TouchHum = Angry.Value and Touch.Parent:FindFirstChild("Humanoid")
		if TouchHum then
			local nand = (not Touch.Parent:IsDescendantOf(workspace.Npc)) and Humanoid.Health > 1
			if nand then
				TouchHum:TakeDamage(Damage)
				if TouchHum.Health < 1 then
					local Player = Players:GetPlayerFromCharacter(Touch.Parent)
					if Player then
						JumpScare(Player)
					end
				end
				HitDebounce = true
				wait(DamageDebounce)
				HitDebounce = false
			end
		end
	end
end

Head.Touched:Connect(HitAttack)
Torso.Touched:Connect(HitAttack)

Humanoid.Died:Connect(function()
	Angry.Value = false
	wait(CorpseRemovalDelay)
	script.Parent.Parent = Storage --Send the model to a place where its not visible for the time being

	local SpawningShrek = Storage.Npc.Shrek:Clone()
	SpawningShrek:WaitForChild("Torso").CFrame = SpawnPoint
	wait(pseudorandom(unpack(RespawnTime)))

	SpawningShrek.Parent = workspace.Npc
	script.Parent:Destroy() --Clean up garbage
end)

Angry:GetPropertyChangedSignal("Value"):Connect(function()
	if Angry.Value then
		Nthread(AngryMode)
	else
		Nthread(WanderMode)
	end
end)
Nthread(WanderMode)

Nthread(function()
	--Health regen
	while true do
		while Humanoid.Health < Humanoid.MaxHealth do
			local dt = wait(Health_Regen_Steps)
			local dh = dt*Health_Regen_Rate*Humanoid.MaxHealth
			Humanoid.Health = min(Humanoid.Health+dh, Humanoid.MaxHealth)
		end
		Humanoid.HealthChanged:Wait()
	end
end)
--Torso:SetNetworkOwner(nil)

while Humanoid.Health > 0 do
	ScanForNearestTarget()
	local xor = (not Target and false) or Target and true
	Angry.Value = xor
	wait(SearchRate)
end