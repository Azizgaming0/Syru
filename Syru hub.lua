-- Load Orion
local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Orion/main/source'))()

-- Create window
local Window = OrionLib:MakeWindow({
    Name = "Syru Hub",
    HidePremium = true,
    IntroText = "Loading...",
    SaveConfig = true,
    ConfigFolder = "SyruHubTest",
    IntroEnabled = true,
    IntroIcon = "rbxassetid://4483345998"
})

-- Initial notification with Discord link
OrionLib:MakeNotification({
    Name = "Welcome!",
    Content = "Join the discord server, get key from #key",
    Image = "rbxassetid://4483345998",
    Time = 7
})

-- Key system
local Verified = OrionLib:LoadConfig("Verified") or false
local VALID_KEYS = {"SYRUKEY123", "HUBKEY2025", "JOINEDDISC"} -- Edit these (post in Discord)

local function CheckKey(key)
    for _, valid in pairs(VALID_KEYS) do
        if key:upper() == valid then
            Verified = true
            OrionLib:SaveConfig("Verified", true) -- Saves across runs
            OrionLib:MakeNotification({
                Name = "Verified!",
                Content = "Features unlocked! 🎉",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
            return true
        end
    end
    return false
end

local function LockFeature(callback)
    if Verified then
        callback()
    else
        OrionLib:MakeNotification({
            Name = "Locked",
            Content = "Enter key in Misc tab! Get it from https://discord.gg/UXMRpQHnwG",
            Image = "rbxassetid://4483345998",
            Time = 5
        })
    end
end

-- Main Tab
local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local MainSection = MainTab:AddSection({
    Name = "Teleport Options"
})

MainTab:AddButton({
    Name = "Teleport to End",
    Callback = function()
        LockFeature(function()
            print("User has been teleported to end")
        end)
    end,
    Color = Color3.fromRGB(255, 105, 180)
})

MainTab:AddToggle({
    Name = "Teleport to Start",
    Default = false,
    Callback = function(Value)
        LockFeature(function()
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
        end)
    end,
    Color = Color3.fromRGB(255, 105, 180)
})

-- Misc Tab
local MiscTab = Window:MakeTab({
    Name = "Misc",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local MiscSection = MiscTab:AddSection({
    Name = "Utility Features"
})

MiscTab:AddTextbox({
    Name = "Enter Key",
    Default = "",
    TextDisappear = true,
    PlaceholderText = "Paste key from Discord (e.g., SYRUKEY123)",
    Callback = function(Text)
        if CheckKey(Text) then
            MiscTab:AddLabel("Status: Verified ✅")
        else
            OrionLib:MakeNotification({
                Name = "Invalid Key",
                Content = "Get key from https://discord.gg/UXMRpQHnwG #verify channel",
                Image = "rbxassetid://4483345998",
                Time = 5
            })
            MiscTab:AddLabel("Status: Not Verified ❌")
        end
    end,
    Color = Color3.fromRGB(255, 105, 180)
})

MiscTab:AddButton({
    Name = "Join Discord for Key",
    Callback = function()
        OrionLib:MakeNotification({
            Name = "Join Discord",
            Content = "Visit https://discord.gg/UXMRpQHnwG, check #verify for key!",
            Image = "rbxassetid://4483345998",
            Time = 7
        })
    end,
    Color = Color3.fromRGB(255, 105, 180)
})

MiscTab:AddLabel("Status: " .. (Verified and "Verified ✅" or "Not Verified ❌"))

-- Fly Script
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

UserInputService.TouchStarted:Connect(function(input)
    if Flying then
        TouchInput = input
        TouchStartPos = input.Position
    end
end)

UserInputService.TouchMoved:Connect(function(input)
    if Flying and TouchInput == input and TouchStartPos then
        local delta = (input.Position - TouchStartPos) / 100
        local camera = workspace.CurrentCamera
        local forward = camera.CFrame.LookVector
        local right = camera.CFrame.RightVector
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

MiscTab:AddToggle({
    Name = "Fly",
    Default = false,
    Callback = function(Value)
        LockFeature(function()
            if Value then
                StartFlying()
            else
                StopFlying()
            end
            print("Fly Toggle:", Value)
        end)
    end,
    Color = Color3.fromRGB(255, 105, 180)
})

MiscTab:AddSlider({
    Name = "Fly Speed",
    Min = 10,
    Max = 100,
    Default = 50,
    Color = Color3.fromRGB(255, 105, 180),
    Increment = 1,
    ValueName = "Speed",
    Callback = function(Value)
        LockFeature(function()
            FlySpeed = Value
            print("Fly Speed:", Value)
        end)
    end
})

MiscTab:AddToggle({
    Name = "Sample Toggle",
    Default = false,
    Callback = function(Value)
        LockFeature(function()
            print("Toggle Value:", Value)
        end)
    end,
    Color = Color3.fromRGB(255, 105, 180)
})

MiscTab:AddColorpicker({
    Name = "Colorpicker",
    Default = Color3.fromRGB(255, 105, 180),
    Callback = function(Value)
        LockFeature(function()
            print("Colorpicker Value:", Value)
        end)
    end
})

MiscTab:AddSlider({
    Name = "Speed",
    Min = 0,
    Max = 120,
    Default = 5,
    Color = Color3.fromRGB(255, 105, 180),
    Increment = 1,
    ValueName = "Speed",
    Callback = function(Value)
        LockFeature(function()
            print("Slider Value:", Value)
        end)
    end
})

OrionLib:Init()
