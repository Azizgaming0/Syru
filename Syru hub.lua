local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Syru Script",
    Icon = 0,
    LoadingTitle = "Syru hub loading",
    LoadingSubtitle = "by can't tell my name sry😜",
    ShowText = "Syru hub",
    Theme = "Default",
    ToggleUIKeybind = "K",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "Syru Hub"
    },
    Discord = {
        Enabled = true,
        Invite = "bcEkn3mhRD",
        RememberJoins = true
    },
    KeySystem = true,
    KeySettings = {
        Title = "Grow a Garden Key",
        Subtitle = "Link in Discord server",
        Note = "Join the server from misc tab",
        FileName = "Syru Hub key",
        SaveKey = true,
        GrabKeyFromSite = true,
        Key = {"https://pastebin.com/raw/xTh1piDh"}
    }
})

local MainTab = Window:CreateTab("Main", nil)
local MainSection = MainTab:CreateSection("Main")

Rayfield:Notify({
    Title = "Script executed",
    Content = "Thanks for using Syru Hub!",
    Duration = 4,
    Actions = {
        yes = {Name = "Yes!", Callback = function() print("Yes clicked") end},
        no = {Name = "No!", Callback = function() print("No clicked") end}
    }
})

-- Infinite Jump toggle
local infiniteJumpEnabled = false
local Player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local jumpConnection

MainTab:CreateButton({
    Name = "Toggle Infinite Jump",
    Callback = function()
        infiniteJumpEnabled = not infiniteJumpEnabled

        if infiniteJumpEnabled then
            jumpConnection = UserInputService.JumpRequest:Connect(function()
                local char = Player.Character
                if char then
                    local humanoid = char:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            end)
            print("Infinite Jump Enabled!")
        else
            if jumpConnection then
                jumpConnection:Disconnect()
                jumpConnection = nil
            end
            print("Infinite Jump Disabled!")
        end
    end
})

-- WalkSpeed Slider
MainTab:CreateSlider({
   Name = "Walk Speed",
   Range = {0, 300},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 20,
   Flag = "WalkSpeed",
   Callback = function(Value)
        local char = Player.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char.Humanoid.WalkSpeed = Value
        end
   end,
})

-- Teleport locations
local teleportLocations = {
    ["Seeds"] = Vector3.new(88, 2.9, -26),
    ["Gears"] = Vector3.new(-286, 2.9, -13),
}

-- Teleport Dropdown
MainTab:CreateDropdown({
    Name = "Teleport Shop",
    Options = {"Seeds","Gears"},
    CurrentOption = {"Seeds"},
    MultipleOptions = false,
    Flag = "TeleportShop",
    Callback = function(Option)
        local char = Player.Character or Player.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")
        local coords = teleportLocations[tostring(Option)]
        if coords then
            hrp.CFrame = CFrame.new(coords)
            print("Teleported to " .. Option .. " at:", coords)
        else
            warn("No teleport coordinates found for:", Option)
        end
    end
})
