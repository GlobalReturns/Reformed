local Aiming = loadstring(game:HttpGet("https://raw.githubusercontent.com/GlobalReturns/Reformed/main/ReformedW.lua"))()

Aiming.TeamCheck(false)


local Workspace = game:GetService("Workspace")

local Players = game:GetService("Players")

local RunService = game:GetService("RunService")

local UserInputService = game:GetService("UserInputService")



local LocalPlayer = Players.LocalPlayer

local Mouse = LocalPlayer:GetMouse()

local CurrentCamera = Workspace.CurrentCamera



local DaHoodSettings = {

    SilentAim = true,

    AimLock = false,

    Prediction = 0.1537,

    AimLockKeybind = Enum.KeyCode.E,

    Resolver = false,

    AutoPrediction = true,

}

getgenv().DaHoodSettings = DaHoodSettings



local GunSettings = {

    ["Double-Barrel SG"] = { --// dh

        ["FOV"] = 25

    },

    ["Double Barrel SG"] = { --// dhm

        ["FOV"] = 26.5

    },

    ["DoubleBarrel"] = { --// hood customs

    ["FOV"] = 20

    },

    ["Revolver"] = {

        ["FOV"] = 14.5

    },

    ["TacticalShotgun"] = {
        
         ["FOV"] = 12.9
        
    },

    ["SMG"] = {

        ["FOV"] = 6.5

    },

    ["Shotgun"] = {

        ["FOV"] = 25

    }

}




function Aiming.Check()

    if not (Aiming.Enabled == true and Aiming.Selected ~= LocalPlayer and Aiming.SelectedPart ~= nil) then

        return false

    end

    local Character = Aiming.Character(Aiming.Selected)

    local KOd = Character:WaitForChild("BodyEffects")["K.O"].Value

    local Grabbed = Character:FindFirstChild("GRABBING_CONSTRAINT") ~= nil

    if (KOd or Grabbed) then

        return false

    end

    return true

end



task.spawn(function()

    while task.wait() do

        if DaHoodSettings.Resolver and Aiming.Selected ~= nil and (Aiming.Selected.Character)  then

            local oldVel = game.Players[Aiming.Selected.Name].Character.HumanoidRootPart.Velocity

            game.Players[Aiming.Selected.Name].Character.HumanoidRootPart.Velocity = Vector3.new(oldVel.X, -0, oldVel.Z)

        end 

    end

end)



local Script = {Functions = {}}



Script.Functions.getToolName = function(name)

    local split = string.split(string.split(name, "[")[2], "]")[1]

    return split

end



Script.Functions.getEquippedWeaponName = function(player)

   if (player.Character) and player.Character:FindFirstChildWhichIsA("Tool") then

      local Tool =  player.Character:FindFirstChildWhichIsA("Tool")

      if string.find(Tool.Name, "%[") and string.find(Tool.Name, "%]") and not string.find(Tool.Name, "Wallet") and not string.find(Tool.Name, "Phone") then 

         return Script.Functions.getToolName(Tool.Name)

      end

   end

   return nil

end



game:GetService("RunService").RenderStepped:Connect(function()

    if Script.Functions.getEquippedWeaponName(game.Players.LocalPlayer) ~= nil then

        local WeaponSettings = GunSettings[Script.Functions.getEquippedWeaponName(game.Players.LocalPlayer)]

        if WeaponSettings ~= nil then

            Aiming.FOV = WeaponSettings.FOV

        else

            Aiming.FOV = 5

        end

    end    

end)



local __index

__index = hookmetamethod(game, "__index", function(t, k)

    if (t:IsA("Mouse") and (k == "Hit" or k == "Target") and Aiming.Check()) then

        local SelectedPart = Aiming.SelectedPart

        if (DaHoodSettings.SilentAim and (k == "Hit" or k == "Target")) then

            local Hit = SelectedPart.CFrame + (SelectedPart.Velocity * DaHoodSettings.Prediction)

            return (k == "Hit" and Hit or SelectedPart)

        end

    end



    return __index(t, k)

end)



RunService:BindToRenderStep("AimLock", 0, function()

    if (DaHoodSettings.AimLock and Aiming.Check() and UserInputService:IsKeyDown(DaHoodSettings.AimLockKeybind)) then

        local SelectedPart = Aiming.SelectedPart

        local Hit = SelectedPart.CFrame + (SelectedPart.Velocity * DaHoodSettings.Prediction)

        CurrentCamera.CFrame = CFrame.lookAt(CurrentCamera.CFrame.Position, Hit.Position)

    end
 end)

local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.V then
        Aiming.Enabled = true
    end
    if input.KeyCode == Enum.KeyCode.C then
        Aiming.Enabled = false
    end
end)
-- autoprediction 
game:GetService('RunService').Heartbeat:connect(function()
    local Status = game:GetService("Stats")
local Average_Ping = Status.PerformanceStats.Ping:GetValue()
local ping = math.round(Average_Ping)

    if getgenv().DaHoodSettings.AutoPrediction == true then
        if tonumber(ping) < 10 then
            getgenv().DaHoodSettings.Prediction = 0.0225
        elseif tonumber(ping) < 20 then
            getgenv().DaHoodSettings.Prediction = 0.045
        elseif tonumber(ping) < 30 then
            getgenv().DaHoodSettings.Prediction = 0.0675
        elseif tonumber(ping) < 40 then
            getgenv().DaHoodSettings.Prediction = 0.09
        elseif tonumber(ping) < 50 then
            getgenv().DaHoodSettings.Prediction = 0.1125
        elseif tonumber(ping) < 60 then
            getgenv().DaHoodSettings.Prediction = 0.135
        elseif tonumber(ping) < 70 then
            getgenv().DaHoodSettings.Prediction = 0.1575
        elseif tonumber(ping) < 80 then
            getgenv().DaHoodSettings.Prediction = 0.18
        elseif tonumber(ping) < 90 then
            getgenv().DaHoodSettings.Prediction = 0.2025
        elseif tonumber(ping) < 100 then    
            Storage.AimlockSets.Prediction = 0.225
        elseif tonumber(ping) < 110 then
            getgenv().DaHoodSettings.Prediction = 0.2475
        elseif tonumber(ping) < 120 then
            Storage.AimlockSets.Prediction = 0.27
        elseif tonumber(ping) < 130 then
            getgenv().DaHoodSettings.Prediction = 0.2925
        elseif tonumber(ping) < 140 then
            getgenv().DaHoodSettings.Prediction = 0.315
        elseif tonumber(ping) < 150 then
            getgenv().DaHoodSettings.Prediction = 0.3375
        elseif tonumber(ping) < 160 then
            getgenv().DaHoodSettings.Prediction = 0.36
        elseif tonumber(ping) < 170 then
            getgenv().DaHoodSettings.Prediction = 0.3825
        elseif tonumber(ping) < 180 then
            getgenv().DaHoodSettings.Prediction = 0.405
        elseif tonumber(ping) < 190 then
            getgenv().DaHoodSettings.Prediction = 0.4275
        elseif tonumber(ping) < 200 then
            getgenv().DaHoodSettings.Prediction = 0.45
        elseif tonumber(ping) < 210 then
            getgenv().DaHoodSettings.Prediction = 0.4725
        elseif tonumber(ping) < 220 then
            getgenv().DaHoodSettings.Prediction = 0.495
        elseif tonumber(ping) < 230 then
            getgenv().DaHoodSettings.Prediction = 0.5175
        elseif tonumber(ping) < 240 then
            getgenv().DaHoodSettings.Prediction = 0.54
        elseif tonumber(ping) < 250 then
            getgenv().DaHoodSettings.Prediction = 0.5625
        end
    end
end)
