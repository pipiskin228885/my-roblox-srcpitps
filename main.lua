-- Танец (анимация)
local Player = game.Players.LocalPlayer
local Character = Player.Character
local Humanoid = Character:WaitForChild("Humanoid")

local danceAnim = Instance.new("Animation")
danceAnim.AnimationId = "rbxassetid://3364876454" -- ID танца

local track = Humanoid:LoadAnimation(danceAnim)
track:Play()
