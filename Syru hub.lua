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
    Title = "grow a garden key",
    Subtitle = "link in discord server",
    Note = "join the server from misc tab",
    FileName = "Syru hub key",
    SaveKey = true,
    GrabKeyFromSite = true,
    Key = {"https://pastebin.com/raw/xTh1piDh"} -- manually put your key here
        }
})

local MainTab = Window:CreateTab("Main", nil)
local MainSection = MainTab:CreateSection("Main")

Rayfield:Notify({
    Title = "Script has been executed",
    Content = "Thank you very much for using Syru hub",
    Duration = 4,
    Image = nil,
    Actions = {
        yes = {
            Name = "Yes!",
            Callback = function() print("Yes clicked") end
        },
        no = {
            Name = "No!",
            Callback = function() print("No clicked") end
        }
    }
})

local Button = MainTab:CreateButton({
    Name = "Infinite Jump",
    Callback = function()
        local UserInputService = game:GetService("UserInputService")
        local Player = game:GetService("Players").LocalPlayer

        UserInputService.JumpRequest:Connect(function()
            local character = Player.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)

        print("Infinite Jump Activated!")
    end
})

local Slider = MainTab:CreateSlider({
   Name = "Walk Speed",
   Range = {0, 300},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 20,
   Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Value)
   end,
})

local Dropdown = MainTab:CreateDropdown({
    Name = "Teleport Shop",
    Options = {"Seeds","Gears"},
    CurrentOption = {"Seeds"},
    MultipleOptions = false,
    Flag = "TeleportShop",
    Callback = function(Option)
        local plr = game.Players.LocalPlayer
        local char = plr.Character or plr.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")

        if Option == "Seeds" then
            hrp.CFrame = CFrame.new(50, 5, 30) -- put correct coords here
        elseif Option == "Gears" then
            hrp.CFrame = CFrame.new(90, 5, 10) -- put correct coords here
        end
    end
})
