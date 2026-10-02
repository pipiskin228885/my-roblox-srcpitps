-- Флай скрипт с меню для Xeno Executor
local Player = game.Players.LocalPlayer
local Character = Player.Character
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- Настройки
local FlySpeed = 50
local FlyEnabled = false
local MenuVisible = false

-- GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local FlyButton = Instance.new("TextButton")
local SpeedSlider = Instance.new("Slider")
local CloseButton = Instance.new("TextButton")

-- Настройка GUI
ScreenGui.Parent = Player:WaitForChild("PlayerGui")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Size = UDim2.new(0, 200, 0, 150)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -75)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "Fly Menu"
Title.TextColor3 = Color3.new(1, 1, 1)

FlyButton.Parent = MainFrame
FlyButton.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
FlyButton.Size = UDim2.new(0.8, 0, 0, 30)
FlyButton.Position = UDim2.new(0.1, 0, 0.3, 0)
FlyButton.Text = "Fly: OFF"
FlyButton.TextColor3 = Color3.new(1, 1, 1)

SpeedSlider.Parent = MainFrame
SpeedSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
SpeedSlider.Size = UDim2.new(0.8, 0, 0, 20)
SpeedSlider.Position = UDim2.new(0.1, 0, 0.6, 0)

CloseButton.Parent = MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.Size = UDim2.new(0.3, 0, 0, 20)
CloseButton.Position = UDim2.new(0.35, 0, 0.85, 0)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.new(1, 1, 1)

-- Функция полета
local function UpdateFly()
    if FlyEnabled then
        Humanoid:ChangeState(Enum.HumanoidStateType.Flying)
        Humanoid.FlySpeed = FlySpeed
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Falling, false)
    else
        Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Falling, true)
    end
end

-- Кнопка полета
FlyButton.MouseButton1Click:Connect(function()
    FlyEnabled = not FlyEnabled
    FlyButton.Text = "Fly: " .. (FlyEnabled and "ON" or "OFF")
    UpdateFly()
end)

-- Слайдер скорости
SpeedSlider.Changed:Connect(function()
    FlySpeed = SpeedSlider.Value
end)

-- Закрытие меню
CloseButton.MouseButton1Click:Connect(function()
    MenuVisible = false
    MainFrame.Visible = false
end)

-- Открытие/закрытие меню на RightShift
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        MenuVisible = not MenuVisible
        MainFrame.Visible = MenuVisible
    end
end)

-- Обновление позиции при полете
game:GetService("RunService").RenderStepped:Connect(function()
    if FlyEnabled then
        local moveDirection = Vector3.new(0, 0, 0)
        local userInput = game:GetService("UserInputService")
        
        if userInput:IsKeyDown(Enum.KeyCode.W) then
            moveDirection = moveDirection + RootPart.CFrame.LookVector
        end
        if userInput:IsKeyDown(Enum.KeyCode.S) then
            moveDirection = moveDirection - RootPart.CFrame.LookVector
        end
        if userInput:IsKeyDown(Enum.KeyCode.A) then
            moveDirection = moveDirection - RootPart.CFrame.RightVector
        end
        if userInput:IsKeyDown(Enum.KeyCode.D) then
            moveDirection = moveDirection + RootPart.CFrame.RightVector
        end
        if userInput:IsKeyDown(Enum.KeyCode.Space) then
            moveDirection = moveDirection + Vector3.new(0, 1, 0)
        end
        if userInput:IsKeyDown(Enum.KeyCode.LeftControl) then
            moveDirection = moveDirection - Vector3.new(0, 1, 0)
        end
        
        RootPart.Velocity = moveDirection * FlySpeed
    end
end)
