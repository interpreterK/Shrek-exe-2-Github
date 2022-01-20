--[[
	interpreterK
	Shrek exe 2, Callbacks Module handles what the bind assignments do
    https://github.com/interpreterK/Shrek-exe-2-Github
]]

local Callbacks = {
	ReadyDelay = 1, --(Seconds)
	CactusDebounce = .30 --(Seconds)
}
Callbacks.__index = Callbacks

local TS = game:GetService("TweenService")

local BaseType = TweenInfo.new(1, Enum.EasingStyle.Linear)
local CactusHitDebounce = false

function Callbacks:CarMove_Down(Player, Object, Clicker)
	local Button = Clicker.Parent
	local Button2 = Object.MoveUp
	local Under = Object.ButtonUnder
	local Over = Object.Over
	local Car = Object.Car
	local Seat = Object.Seat
	local Chair = Object.Chair

	if Car.move.Value and not Car.moving.Value then
		Car.move.Value = false
		Car.moving.Value = true
		Button.Material = Enum.Material.Neon
		Button.Press:Play()
		Car.Creak:Play()

		local Parts = {Object.MoveDown, Button2, Under, Over, Car, Seat, Chair}
		for i,v in next, Parts do
			local Tween = TS:Create(v, TweenInfo.new(5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Position = v.Position - Vector3.new(0, 0, -210)})
			Tween:Play()
			if i == #Parts then
				Tween.Completed:Wait()
			end
		end
		Car.Creak:Stop()
		Car.Slam:Play()
		wait(self.ReadyDelay)

		Button.Recharge:Play()
		Button.Material = Enum.Material.Glass
		Car.moving.Value = false
	end
end

function Callbacks:CarMove_Up(Player, Object, Clicker)
	local Button = Clicker.Parent
	local Button2 = Object.MoveUp
	local Under = Object.ButtonUnder
	local Over = Object.Over
	local Car = Object.Car
	local Seat = Object.Seat
	local Chair = Object.Chair

	if not Car.move.Value and not Car.moving.Value then
		Car.move.Value = true
		Car.moving.Value = true
		Button.Material = Enum.Material.Neon
		Button.Press:Play()
		Car.Creak:Play()

		local Parts = {Object.MoveDown, Button2, Under, Over, Car, Seat, Chair}
		for i,v in next, Parts do
			local Tween = TS:Create(v, TweenInfo.new(5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Position = v.Position + Vector3.new(0, 0, -210)})
			Tween:Play()
			if i == #Parts then
				Tween.Completed:Wait()
			end
		end
		Car.Creak:Stop()
		Car.Slam:Play()
		wait(self.ReadyDelay)

		Button.Recharge:Play()
		Button.Material = Enum.Material.Glass
		Car.moving.Value = false
	end
end

function Callbacks:SlideDoor_Open(Player, Object, Clicker)
	local Door = Clicker.Parent.Parent.Door
	local Button = Clicker.Parent

	if not Door.open.Value and not Door.opening.Value then
		Door.open.Value = true
		Door.opening.Value = true
		Button.Material = Enum.Material.Neon
		Button.Press:Play()
		Door.Creak:Play()

		local Tween = TS:Create(Door, BaseType, {Position = Door.Position + Vector3.new(0, 0, 7.5)})
		Tween:Play()
		Tween.Completed:Wait()

		Door.Creak:Stop()
		Door.Slam:Play()
		wait(self.ReadyDelay)

		Button.Recharge:Play()
		Button.Material = Enum.Material.Glass
		Door.opening.Value = false
	end
end

function Callbacks:SlideDoor_Close(Player, Object, Clicker)
	local Door = Clicker.Parent.Parent.Door
	local Button = Clicker.Parent
	local Smoke = Clicker.Parent.Parent.Smoke.Hit

	if Door.open.Value and not Door.opening.Value then
		Door.open.Value = false
		Door.opening.Value = true
		Button.Material = Enum.Material.Neon
		Button.Press:Play()
		Door.Creak2:Play()

		local Tween = TS:Create(Door, BaseType, {Position = Door.Position + Vector3.new(0, 0, -7.5)})
		Tween:Play()
		Tween.Completed:Wait()

		Door.Creak2:Stop()
		Door.Slam:Play()
		Smoke:Emit(250)
		wait(self.ReadyDelay)

		Button.Recharge:Play()
		Button.Material = Enum.Material.Glass
		Door.opening.Value = false
	end
end

function Callbacks:ProtectiveDoor_Open(Player, Object, Clicker)
	local Door = Clicker.Parent.Parent.Door
	local Door2 = Clicker.Parent.Parent.Door2
	local Button = Clicker.Parent

	if not Door.open.Value and not Door.opening.Value then
		Door.open.Value = true
		Door.opening.Value = true
		Button.Material = Enum.Material.Neon
		Button.Press:Play()
		Door.Creak:Play()
		Door2.Creak:Play()

		local Tween = TS:Create(Door, BaseType, {Position = Door.Position - Vector3.new(0, 0, 8.5)})
		local Tween2 = TS:Create(Door2, BaseType, {Position = Door2.Position + Vector3.new(0, 0, 8.5)})
		Tween:Play()
		Tween2:Play()
		Tween2.Completed:Wait()

		Door.Creak:Stop()
		Door2.Creak:Stop()
		Door.Slam:Play()
		Door2.Slam:Play()
		wait(self.ReadyDelay)

		Button.Recharge:Play()
		Button.Material = Enum.Material.Glass
		Door.opening.Value = false
	end
end

function Callbacks:ProtectiveDoor_Close(Player, Object, Clicker)
	local Door = Clicker.Parent.Parent.Door
	local Door2 = Clicker.Parent.Parent.Door2
	local Button = Clicker.Parent
	local Smoke = Door.Parent.Smoke

	if Door.open.Value and not Door.opening.Value then
		Door.open.Value = false
		Door.opening.Value = true
		Button.Material = Enum.Material.Neon
		Button.Press:Play()
		Door.Creak:Play()
		Door2.Creak:Play()

		local Tween = TS:Create(Door, BaseType, {Position = Door.Position + Vector3.new(0, 0, 8.5)})
		local Tween2 = TS:Create(Door2, BaseType, {Position = Door2.Position - Vector3.new(0, 0, 8.5)})
		Tween:Play()
		Tween2:Play()
		Tween2.Completed:Wait()

		Door.Creak:Stop()
		Door2.Creak:Stop()
		Smoke.Slam:Play()
		Smoke.Hit:Emit(250)
		wait(self.ReadyDelay)

		Button.Recharge:Play()
		Button.Material = Enum.Material.Glass
		Door.opening.Value = false
	end
end

function Callbacks:GateDoor_Open(Player, Object, Clicker)
	local Door = Clicker.Parent.Parent.Door
	local Button = Clicker.Parent

	if not Door.open.Value and not Door.opening.Value then
		Door.open.Value = true
		Door.opening.Value = true
		Button.Material = Enum.Material.Neon
		Button.Press:Play()
		Door.Creak:Play()

		local Tween = TS:Create(Door, BaseType, {Position = Door.Position + Vector3.new(0, 10, 0)})
		Tween:Play()
		Tween.Completed:Wait()

		Door.Creak:Stop()
		Door.Slam:Play()
		wait(self.ReadyDelay)

		Button.Recharge:Play()
		Button.Material = Enum.Material.Glass
		Door.opening.Value = false
	end
end

function Callbacks:GateDoor_Close(Player, Object, Clicker)
	local Door = Clicker.Parent.Parent.Door
	local Button = Clicker.Parent
	local Smoke = Door.Parent.Smoke

	if Door.open.Value and not Door.opening.Value then
		Door.open.Value = false
		Door.opening.Value = true
		Button.Material = Enum.Material.Neon
		Button.Press:Play()
		Door.Creak:Play()

		local Tween = TS:Create(Door, BaseType, {Position = Door.Position - Vector3.new(0, 10, 0)})
		Tween:Play()
		Tween.Completed:Wait()

		Door.Creak:Stop()
		Door.Slam:Play()
		Smoke.Hit:Emit(250)
		wait(self.ReadyDelay)

		Button.Recharge:Play()
		Button.Material = Enum.Material.Glass
		Door.opening.Value = false
	end
end

function Callbacks:CactusTouch(Touch)
	local Humanoid = Touch.Parent:FindFirstChild("Humanoid")
	if Humanoid and not CactusHitDebounce then
		Humanoid:TakeDamage(10)
		CactusHitDebounce = true
		wait(self.CactusDebounce)
		CactusHitDebounce = false
	end
end

return Callbacks