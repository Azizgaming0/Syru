-- Load Orion
local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()

-- Create window with pink theme
local Window = OrionLib:MakeWindow({
    Name = "Syru Hub",
    HidePremium = true,
    IntroText = "Loading...",
    SaveConfig = true,
    ConfigFolder = "SyruHubTest",
    IntroEnabled = true,
    IntroIcon = "rbxassetid://4483345998" -- Pink-themed icon (replace with custom if desired)
})

-- Notification
OrionLib:MakeNotification({
    Name = "Hello!",
    Content = "Thanks for using Syru Hub. Check out our Discord too!",
    Image = "rbxassetid://4483345998", -- Valid default Roblox face; replace with custom pink-themed asset ID if desired
    Time = 7
})

-- Main Tab for game-specific features
local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998", -- Replace with pink-themed icon if available
    PremiumOnly = false
})

-- Main Tab Section
local MainSection = MainTab:AddSection({
    Name = "Teleport Options"
})

-- Teleport to End Button
MainTab:AddButton({
    Name = "Teleport to End",
    Callback = function()
        print("User has been teleported to end")
    end,
    Color = Color3.fromRGB(255, 105, 180) -- Hot pink
})

-- Teleport to Start Toggle
MainTab:AddToggle({
    Name = "Teleport to Start",
    Default = false,
    Callback = function(Value)
        print("User has been teleported to start")
        local RemoteEvent = game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services"):WaitForChild("BallService"):WaitForChild("RE"):WaitForChild("Shoot")
        local function FireFixedShot()
            local args = {
                220,
                nil,
                nil,
                Vector3.new(-0.7397774457931519, 0.07569416612386703, -0.6685804724693298)
            }
            RemoteEvent:FireServer(unpack(args))
        end
        if Value then FireFixedShot() end
    end,
    Color = Color3.fromRGB(255, 105, 180) -- Hot pink
})

-- Misc Tab for fly and other features
local MiscTab = Window:MakeTab({
    Name = "Misc",
    Icon = "rbxassetid://4483345998", -- Replace with pink-themed icon if available
    PremiumOnly = false
})

-- Misc Tab Section
local MiscSection = MiscTab:AddSection({
    Name = "Utility Features"
})

-- Fly Script Variables
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character
local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
local Flying = false
local FlySpeed = 50
local BodyVelocity, BodyGyro
local TouchInput = nil
local TouchStartPos = nil
local TouchMoveDir = Vector3.new(0, 0, 0)

-- Fly Function
local function StartFlying()
    if not Character or not HumanoidRootPart then
        OrionLib:MakeNotification({
            Name = "Error",
            Content = "Character or HumanoidRootPart not found!",
            Image = "rbxassetid://4483345998",
            Time = 5
        })
        return
    end
    Flying = true
    BodyVelocity = Instance.new("BodyVelocity")
    BodyGyro = Instance.new("BodyGyro")
    BodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
    BodyVelocity.Velocity = Vector3.new(0, 0, 0)
    BodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
    BodyGyro.CFrame = HumanoidRootPart.CFrame
    BodyVelocity.Parent = HumanoidRootPart
    BodyGyro.Parent = HumanoidRootPart

    while Flying do
        local MoveDirection = Vector3.new(0, 0, 0)
        -- PC controls (W, A, S, D, Space, Left Shift)
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            MoveDirection = MoveDirection + (workspace.CurrentCamera.CFrame.LookVector * FlySpeed)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            MoveDirection = MoveDirection - (workspace.CurrentCamera.CFrame.LookVector * FlySpeed)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            MoveDirection = MoveDirection - (workspace.CurrentCamera.CFrame.RightVector * FlySpeed)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            MoveDirection = MoveDirection + (workspace.CurrentCamera.CFrame.RightVector * FlySpeed)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            MoveDirection = MoveDirection + Vector3.new(0, FlySpeed, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            MoveDirection = MoveDirection - Vector3.new(0, FlySpeed, 0)
        end
        -- Mobile touch controls
        if TouchInput then
            MoveDirection = MoveDirection + (TouchMoveDir * FlySpeed)
        end
        BodyVelocity.Velocity = MoveDirection
        BodyGyro.CFrame = workspace.CurrentCamera.CFrame
        wait()
    end
end

local function StopFlying()
    Flying = false
    if BodyVelocity then BodyVelocity:Destroy() end
    if BodyGyro then BodyGyro:Destroy() end
    TouchInput = nil
    TouchStartPos = nil
    TouchMoveDir = Vector3.new(0, 0, 0)
end

-- Touch Input Handling for Mobile
UserInputService.TouchStarted:Connect(function(input)
    if Flying then
        TouchInput = input
        TouchStartPos = input.Position
    end
end)

UserInputService.TouchMoved:Connect(function(input)
    if Flying and TouchInput == input and TouchStartPos then
        local delta = (input.Position - TouchStartPos) / 100 -- Scale for sensitivity
        local camera = workspace.CurrentCamera
        local forward = camera.CFrame.LookVector
        local right = camera.CFrame.RightVector
        -- Map 2D touch delta to 3D movement
        TouchMoveDir = (forward * -delta.Y) + (right * delta.X) + (Vector3.new(0, delta.Y, 0) * 0.5)
    end
end)

UserInputService.TouchEnded:Connect(function(input)
    if TouchInput == input then
        TouchInput = nil
        TouchStartPos = nil
        TouchMoveDir = Vector3.new(0, 0, 0)
    end
end)

-- Fly Toggle
MiscTab:AddToggle({
    Name = "Fly",
    Default = false,
    Callback = function(Value)
        if Value then
            StartFlying()
        else
            StopFlying()
        end
        print("Fly Toggle:", Value)
    end,
    Color = Color3.fromRGB(255, 105, 180) -- Hot pink
})

-- Fly Speed Slider
MiscTab:AddSlider({
    Name = "Fly Speed",
    Min = 10,
    Max = 100,
    Default = 50,
    Color = Color3.fromRGB(255, 105, 180), -- Hot pink
    Increment = 1,
    ValueName = "Speed",
    Callback = function(Value)
        FlySpeed = Value
        print("Fly Speed:", Value)
    end
})

-- Sample Toggle
MiscTab:AddToggle({
    Name = "Sample Toggle",
    Default = false,
    Callback = function(Value)
        print("Toggle Value:", Value)
    end,
    Color = Color3.fromRGB(255, 105, 180) -- Hot pink
})

-- Colorpicker with pink default
MiscTab:AddColorpicker({
    Name = "Colorpicker",
    Default = Color3.fromRGB(255, 105, 180), -- Hot pink
    Callback = function(Value)
        print("Colorpicker Value:", Value)
    end
})

-- Speed Slider
MiscTab:AddSlider({
    Name = "Speed",
    Min = 0,
    Max = 120,
    Default = 5,
    Color = Color3.fromRGB(255, 105, 180), -- Hot pink
    Increment = 1,
    ValueName = "Speed",
    Callback = function(Value)
        print("Slider Value:", Value)
    end
})

-- Initialize Orion
OrionLib:Init()
