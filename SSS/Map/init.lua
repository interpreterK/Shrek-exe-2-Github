--[[
	interpreterK
	Shrek exe 2, Map Script to bind all buttons to work
    https://github.com/interpreterK/Shrek-exe-2-Github
]]

local Callbacks = require(script:WaitForChild("Callbacks"))
local Map = workspace:WaitForChild("Map")

--Wait for dependancies
Map:WaitForChild("Area_51")
Map:WaitForChild("dominic123b")

--Init the map scripting
local Assignments = {
    ["Car"] = {
        BindClicks = {
            [1] = {"MoveDown", "MoveDown2"},
            [2] = {"MoveUp", "MoveUp2"}
        },
        Callback = function(...)
            Callbacks:CarMove_Down(...)
        end,
        Callback2 = function(...)
            Callbacks:CarMove_Up(...)
        end
    },
    ["SlideDoor"] = {
        BindClicks = {
            [1] = {"Open"},
            [2] = {"Close"}
        },
        Callback = function(...)
            Callbacks:SlideDoor_Open(...)
        end,
        Callback2 = function(...)
            Callbacks:SlideDoor_Close(...)
        end
    },
    ["ProtectiveDoor"] = {
        BindClicks = {
            [1] = {"Open"},
            [2] = {"Close"}
        },
        Callback = function(...)
            Callbacks:ProtectiveDoor_Open(...)
        end,
        Callback2 = function(...)
            Callbacks:ProtectiveDoor_Close(...)
        end
    },
    ["GateDoor"] = {
        BindClicks = {
            [1] = {"Open"},
            [2] = {"Close"}
        },
        Callback = function(...)
            Callbacks:GateDoor_Open(...)
        end,
        Callback2 = function(...)
            Callbacks:GateDoor_Close(...)
        end
    },
    ["GiantDoor"] = {
        BindClicks = {
            [1] = {"Open"},
            [2] = {"Close"}
        },
        Callback = function(...)
            Callbacks:GiantDoor_Open(...)
        end,
        Callback2 = function(...)
            Callbacks:GiantDoor_Close(...)
        end
    },
    ["Cacti"] = {
        Touches = {"Union"},
        Callback = function(...)
            Callbacks:CactusTouch(...)
        end
    },
    ["Toxic"] = {
        Touches = {"Toxic"},
        Callback = function(...)
            Callbacks:ToxicTouch(...)
        end
    }
}
local Areas = Map:GetDescendants()

local function BindClick(Inst, FoundInst, Opt, Area, Alt)
    local ClickDetector = Inst.Name == FoundInst and Inst:FindFirstChildOfClass("ClickDetector")
    if ClickDetector then
        if Alt then
            ClickDetector.MouseClick:Connect(function(Player)
                Opt.Callback2(Player, Area, ClickDetector)
            end)
        else
            ClickDetector.MouseClick:Connect(function(Player)
                Opt.Callback(Player, Area, ClickDetector)
            end)
        end
    end
end

local function TouchHit(Inst, TouchName, Opt)
    local Hitable = Inst:IsA("BasePart") and Inst.Name == TouchName and Inst.CanTouch
    if Hitable then
        Inst.Touched:Connect(Opt.Callback)
    end
end

local function CheckAndCreateBinder(Area, Opt)
    local D = Area:GetDescendants()
    for i = 1, #D do
        if Opt.BindClicks then
            local BindClicks = Opt.BindClicks
            for t = 1, #BindClicks[1] do
                BindClick(D[i], BindClicks[1][t], Opt, Area, false)
            end
            for t = 1, #BindClicks[2] do
                BindClick(D[i], BindClicks[2][t], Opt, Area, true)
            end
        elseif Opt.Touches then
            local Touches = Opt.Touches
            for t = 1, #Touches do
                TouchHit(D[i], Touches[t], Opt)
            end
        end
    end
end

for i = 1, #Areas do
    local Area = Areas[i]
    for indexName, Opt in next, Assignments do
        if Area.Name == indexName then
            CheckAndCreateBinder(Area, Opt)
        end
    end
end

print(script.Name .. ".lua: Map bindings created... (Init)")