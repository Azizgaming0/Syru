-- Load Orion
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Orion/main/source"))()

-- Window
local Window = OrionLib:MakeWindow({
    Name = "Syru Hub",
    HidePremium = true,
    SaveConfig = true,
    ConfigFolder = "SyruHubTest"
})

-- Key system
local Verified = false
local VALID_KEYS = {"JOINEDDISC"} -- Change these to your real keys
local DISCORD_LINK = "https://discord.gg/UXMRpQHnwG"

local function CheckKey(key)
    for _, v in ipairs(VALID_KEYS) do
        if key:upper() == v then
            Verified = true
            OrionLib:MakeNotification({
                Name = "Verified!",
                Content = "Features unlocked 🎉",
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
            Content = "Get a key in Discord (#verify).",
            Image = "rbxassetid://4483345998",
            Time = 5
        })
    end
end

-- Tabs
local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local DiscordTab = Window:MakeTab({
    Name = "Discord",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Discord Tab
DiscordTab:AddButton({
    Name = "Copy Discord Link",
    Callback = function()
        setclipboard(DISCORD_LINK)
        OrionLib:MakeNotification({
            Name = "Copied",
            Content = "Paste link in browser & get your key!",
            Image = "rbxassetid://4483345998",
            Time = 6
        })
    end
})

DiscordTab:AddTextbox({
    Name = "Enter Key",
    Default = "",
    TextDisappear = true,
    Callback = function(Text)
        if CheckKey(Text) then
            DiscordTab:AddLabel("✅ Verified")
        else
            DiscordTab:AddLabel("❌ Invalid Key")
        end
    end
})

-- MainTab features (locked until verified)
MainTab:AddButton({
    Name = "Teleport to End",
    Callback = function()
        LockFeature(function()
            print("Teleported to end!")
        end)
    end
})

MainTab:AddToggle({
    Name = "Fly",
    Default = false,
    Callback = function(v)
        LockFeature(function()
            print("Fly:", v)
        end)
    end
})

MainTab:AddSlider({
    Name = "Fly Speed",
    Min = 10,
    Max = 100,
    Default = 50,
    Increment = 1,
    Callback = function(v)
        LockFeature(function()
            print("Fly Speed:", v)
        end)
    end
})

MainTab:AddColorpicker({
    Name = "Theme Color",
    Default = Color3.fromRGB(255,105,180),
    Callback = function(c)
        print("Colorpicker:", c)
    end
})

OrionLib:Init()
