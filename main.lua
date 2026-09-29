local OrionLib = loadstring(game:HttpGet(('https://githubusercontent.com')))()
local Window = OrionLib:MakeWindow({ Name = "Xeno Fly Menu",  HidePremium = true,  SaveConfig = false,  ConfigFolder = "XenoFlyConfig"
})
local MainTab = Window:MakeTab({
    Name = "угу",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})


local flying = false
local flySpeed = 50
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")
local BodyVelocity = nil
local BodyGyro = nil

player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    rootPart = character:WaitForChild("HumanoidRootPart")
    humanoid = character:WaitForChild("Humanoid")
end)


local function toggleFly()
    if flying then
       
        BodyGyro = Instance.new("BodyGyro")
        BodyVelocity = Instance.new("BodyVelocity")
        
        BodyGyro.P = 9e4
        BodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        BodyGyro.cframe = rootPart.CFrame
        BodyGyro.Parent = rootPart
        
        BodyVelocity.velocity = Vector3.new(0, 0.1, 0)
        BodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
        BodyVelocity.Parent = rootPart
        
        humanoid.PlatformStand = true -- 
        
        
        task.spawn(function()
            local Camera = workspace.CurrentCamera
            while flying and rootPart and BodyVelocity and BodyGyro do
                task.wait()
                
                local moveDirection = humanoid.MoveDirection
                
               
                if moveDirection.Magnitude > 0 then
                    BodyVelocity.velocity = Camera.CFrame.LookVector * flySpeed
                else
                    BodyVelocity.velocity = Vector3.new(0, 0, 0) -- Зависание на месте
                end
                
                BodyGyro.cframe = Camera.CFrame
            end
        end)
    else
       
        if BodyVelocity then BodyVelocity:Destroy() end
        if BodyGyro then BodyGyro:Destroy() end
        if humanoid then humanoid.PlatformStand = false end
    end
end

MainTab:AddToggle({
    Name = "Режим полета (Fly)",
    Default = false,
    Callback = function(Value)
        flying = Value
        toggleFly()
    end    
})


MainTab:AddSlider({
    Name = "Скорость полета",
    Min = 10,
    Max = 200,
    Default = 50,
    Color = Color3.fromRGB(255,255,255),
    Increment = 5,
    ValueName = "студий/сек",
    Callback = function(Value)
        flySpeed = Value
    end    
})

-- Инициализация меню при запуске
OrionLib:Init()
