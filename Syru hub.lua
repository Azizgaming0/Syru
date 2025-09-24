-- Check game
if game.PlaceId == 126884695634066 then
    local CurrentVersion = "tutorial for grow a garden"
    
    -- Call the library
    local Mercury = loadstring(game:HttpGet("https://raw.githubusercontent.com/deeeity/mercury-lib/master/src.lua"))()

    -- Main frame
    local GUI = Mercury:Create{
        Name = CurrentVersion,
        Size = UDim2.fromOffset(600, 400),
        Theme = Mercury.Themes.Dark,
        Link = "https://github.com/deeeity/mercury-lib"
    }

    -- FarmTab Creation
    local FarmTab = GUI:Tab{
        Name = "auto farm (includes everything for auto",
        Icon = "rbxassetid://135658636515197"
    }

    -- Variables for seed selection
    local Seeds = {
        ["Carrot"] = false,
        ["Strawberry"] = false,
        ["Blueberry"] = false,
        ["Tomato"] = false
    }

    -- Checkbox for each seed
    for seedName,_ in pairs(Seeds) do
        FarmTab:Toggle{
            Name = seedName.." Seed",
            StartingState = false,
            Description = "Auto-buy "..seedName.." seed",
            Callback = function(state)
                Seeds[seedName] = state
            end
        }
    end

    -- Button to buy selected seeds
    FarmTab:Button{
        Name = "Auto buy Seeds",
        Description = "Buys all the seeds you have selected above",
        Callback = function()
            for seedName, state in pairs(Seeds) do
                if state then
                    local args = {
                        [1] = "Tier 1",
                        [2] = seedName
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuySeedStock"):FireServer(unpack(args))
                    task.wait(0.5) -- delay between purchases
                end
            end
        end
    }
end
