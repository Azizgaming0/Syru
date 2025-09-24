--[[
    Syru Hub Final Script
    This script creates a custom UI with different tabs for various game features.
]]--

--// Services
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents")

--// UI Configuration
local FADE_TIME = 0.5
local LOGO_ASSET_ID = "rbxassetid://135658636515197"
local WINDOW_SIZE = UDim2.new(0.4, 0, 0.7, 0)
local WINDOW_COLOR = Color3.fromRGB(40, 44, 52)
local BUTTON_COLOR = Color3.fromRGB(60, 64, 72)
local TOGGLE_ON_COLOR = Color3.fromRGB(255, 20, 147)

--// UI Creation
local function createLoadingScreen()
    local loadingScreen = Instance.new("Frame")
    loadingScreen.Name = "LoadingScreen"
    loadingScreen.Size = UDim2.new(1, 0, 1, 0)
    loadingScreen.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    loadingScreen.BackgroundTransparency = 0.5
    loadingScreen.ZIndex = 10
    loadingScreen.Parent = PlayerGui

    local loadingText = Instance.new("TextLabel")
    loadingText.Name = "LoadingText"
    loadingText.Size = UDim2.new(0.5, 0, 0.1, 0)
    loadingText.Position = UDim2.new(0.5, 0, 0.5, 0)
    loadingText.AnchorPoint = Vector2.new(0.5, 0.5)
    loadingText.Text = "Loading Syru Hub..."
    loadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
    loadingText.BackgroundTransparency = 1
    loadingText.Font = Enum.Font.SourceSansBold
    loadingText.TextSize = 30
    loadingText.Parent = loadingScreen
    
    return loadingScreen
end

local function fadeOutLoadingScreen(loadingScreen)
    for i = 1, 10 do
        task.wait(FADE_TIME / 10)
        loadingScreen.BackgroundTransparency = 0.5 + (i/10) * 0.5
        loadingScreen.LoadingText.TextTransparency = i/10
    end
    loadingScreen:Destroy()
end

local loadingScreen = createLoadingScreen()

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CustomUIScreen"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Logo Button (Draggable)
local LogoButton = Instance.new("ImageButton")
LogoButton.Name = "LogoButton"
LogoButton.Parent = ScreenGui
LogoButton.Size = UDim2.new(0, 75, 0, 75)
LogoButton.Position = UDim2.new(0.05, 0, 0.05, 0)
LogoButton.BackgroundColor3 = WINDOW_COLOR
LogoButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
LogoButton.BorderSizePixel = 3
LogoButton.Image = LOGO_ASSET_ID

local UICorner_Logo = Instance.new("UICorner")
UICorner_Logo.CornerRadius = UDim.new(0.5, 0)
UICorner_Logo.Parent = LogoButton

-- Dragging Logic
local dragging = false
local dragStart = Vector3.new(0,0,0)
local startPos = UDim2.new(0,0,0,0)

LogoButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = LogoButton.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		LogoButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Main Window
local Window = Instance.new("Frame")
Window.Name = "SettingsWindow"
Window.Size = WINDOW_SIZE
Window.Position = UDim2.new(0.5, 0, 0.5, 0)
Window.AnchorPoint = Vector2.new(0.5, 0.5)
Window.BackgroundColor3 = WINDOW_COLOR
Window.BorderSizePixel = 0
Window.Visible = false
Window.Parent = ScreenGui

local UICorner_SettingsWindow = Instance.new("UICorner")
UICorner_SettingsWindow.CornerRadius = UDim.new(0, 12)
UICorner_SettingsWindow.Parent = Window

-- Title Bar
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Text = "Syru Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 24
Title.BackgroundColor3 = WINDOW_COLOR
Title.Parent = Window

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 20
CloseButton.CornerRadius = UDim.new(0.5, 0)
CloseButton.Parent = Window

CloseButton.MouseButton1Click:Connect(function()
    Window.Visible = false
end)

--// Tab System
local TabButtonsFrame = Instance.new("Frame")
TabButtonsFrame.Name = "TabButtons"
TabButtonsFrame.Size = UDim2.new(1, 0, 0, 40)
TabButtonsFrame.Position = UDim2.new(0, 0, 0, 40)
TabButtonsFrame.BackgroundColor3 = WINDOW_COLOR
TabButtonsFrame.Parent = Window

local TabButtonsLayout = Instance.new("UIListLayout")
TabButtonsLayout.FillDirection = Enum.FillDirection.Horizontal
TabButtonsLayout.Padding = UDim.new(0, 5)
TabButtonsLayout.Parent = TabButtonsFrame

local TabContentFrame = Instance.new("Frame")
TabContentFrame.Name = "TabContent"
TabContentFrame.Size = UDim2.new(1, -20, 1, -100)
TabContentFrame.Position = UDim2.new(0.5, 0, 0, 85)
TabContentFrame.AnchorPoint = Vector2.new(0.5, 0)
TabContentFrame.BackgroundColor3 = Color3.fromRGB(50, 54, 62)
TabContentFrame.BorderSizePixel = 0
TabContentFrame.Parent = Window

local UIListLayout_TabContent = Instance.new("UIListLayout")
UIListLayout_TabContent.Name = "UIListLayout"
UIListLayout_TabContent.Padding = UDim.new(0, 5)
UIListLayout_TabContent.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_TabContent.Parent = TabContentFrame

local MainTab = Instance.new("TextButton")
MainTab.Name = "MainTab"
MainTab.Size = UDim2.new(0.5, 0, 1, 0)
MainTab.Text = "Main"
MainTab.TextColor3 = Color3.fromRGB(255, 255, 255)
MainTab.Font = Enum.Font.SourceSansBold
MainTab.TextSize = 18
MainTab.BackgroundColor3 = BUTTON_COLOR
MainTab.Parent = TabButtonsFrame

local AutofarmTab = Instance.new("TextButton")
AutofarmTab.Name = "AutofarmTab"
AutofarmTab.Size = UDim2.new(0.5, 0, 1, 0)
AutofarmTab.Text = "Autofarm"
AutofarmTab.TextColor3 = Color3.fromRGB(255, 255, 255)
AutofarmTab.Font = Enum.Font.SourceSansBold
AutofarmTab.TextSize = 18
AutofarmTab.BackgroundColor3 = BUTTON_COLOR
AutofarmTab.Parent = TabButtonsFrame

local MainFeaturesFrame = Instance.new("Frame")
MainFeaturesFrame.Name = "MainFeatures"
MainFeaturesFrame.Size = UDim2.new(1, 0, 1, 0)
MainFeaturesFrame.BackgroundTransparency = 1
MainFeaturesFrame.Visible = true
MainFeaturesFrame.Parent = TabContentFrame

local MainLayout = Instance.new("UIListLayout")
MainLayout.Padding = UDim.new(0, 5)
MainLayout.SortOrder = Enum.SortOrder.LayoutOrder
MainLayout.Parent = MainFeaturesFrame

local AutofarmFeaturesFrame = Instance.new("Frame")
AutofarmFeaturesFrame.Name = "AutofarmFeatures"
AutofarmFeaturesFrame.Size = UDim2.new(1, 0, 1, 0)
AutofarmFeaturesFrame.BackgroundTransparency = 1
AutofarmFeaturesFrame.Visible = false
AutofarmFeaturesFrame.Parent = TabContentFrame

local AutofarmLayout = Instance.new("UIListLayout")
AutofarmLayout.Padding = UDim.new(0, 5)
AutofarmLayout.SortOrder = Enum.SortOrder.LayoutOrder
AutofarmLayout.Parent = AutofarmFeaturesFrame

MainTab.MouseButton1Click:Connect(function()
    MainFeaturesFrame.Visible = true
    AutofarmFeaturesFrame.Visible = false
end)

AutofarmTab.MouseButton1Click:Connect(function()
    MainFeaturesFrame.Visible = false
    AutofarmFeaturesFrame.Visible = true
end)

--// Main Features
-- Infinite Jump Toggle
local InfiniteJumpToggle = Instance.new("TextButton")
InfiniteJumpToggle.Name = "InfiniteJumpToggle"
InfiniteJumpToggle.Size = UDim2.new(1, 0, 0, 40)
InfiniteJumpToggle.Text = "Infinite Jump: OFF"
InfiniteJumpToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
InfiniteJumpToggle.Font = Enum.Font.SourceSans
InfiniteJumpToggle.TextSize = 18
InfiniteJumpToggle.BackgroundColor3 = BUTTON_COLOR
InfiniteJumpToggle.Parent = MainFeaturesFrame
InfiniteJumpToggle.LayoutOrder = 1

local infiniteJumpEnabled = false
local jumpConnection

InfiniteJumpToggle.MouseButton1Click:Connect(function()
    infiniteJumpEnabled = not infiniteJumpEnabled
    if infiniteJumpEnabled then
        InfiniteJumpToggle.Text = "Infinite Jump: ON"
        InfiniteJumpToggle.BackgroundColor3 = TOGGLE_ON_COLOR
        jumpConnection = UserInputService.JumpRequest:Connect(function()
            local char = Player.Character
            if char then
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
    else
        InfiniteJumpToggle.Text = "Infinite Jump: OFF"
        InfiniteJumpToggle.BackgroundColor3 = BUTTON_COLOR
        if jumpConnection then
            jumpConnection:Disconnect()
            jumpConnection = nil
        end
    end
end)

-- Walk Speed Slider
local WalkSpeedSlider = Instance.new("Frame")
WalkSpeedSlider.Name = "WalkSpeedSlider"
WalkSpeedSlider.Size = UDim2.new(1, 0, 0, 20)
WalkSpeedSlider.BackgroundColor3 = BUTTON_COLOR
WalkSpeedSlider.Parent = MainFeaturesFrame
WalkSpeedSlider.LayoutOrder = 2

local SliderKnob = Instance.new("TextButton")
SliderKnob.Name = "SliderKnob"
SliderKnob.Size = UDim2.new(0.1, 0, 1.2, 0)
SliderKnob.Position = UDim2.new(0, 0, 0, 0)
SliderKnob.BackgroundColor3 = TOGGLE_ON_COLOR
SliderKnob.Text = ""
SliderKnob.TextTransparency = 1
SliderKnob.Parent = WalkSpeedSlider

local SliderLabel = Instance.new("TextLabel")
SliderLabel.Name = "SliderLabel"
SliderLabel.Size = UDim2.new(1, 0, 0.5, 0)
SliderLabel.Position = UDim2.new(0, 0, -1.5, 0)
SliderLabel.Text = "Walk Speed: 20"
SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SliderLabel.BackgroundTransparency = 1
SliderLabel.Font = Enum.Font.SourceSans
SliderLabel.TextSize = 16
SliderLabel.Parent = WalkSpeedSlider

local isDragging = false
local maxSpeed = 5000

SliderKnob.MouseButton1Down:Connect(function()
    isDragging = true
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = false
        end
    end)
end)

UserInputService.InputChanged:Connect(function(input, gameProcessed)
    if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mousePos = input.Position.X
        local sliderPos = WalkSpeedSlider.AbsolutePosition.X
        local sliderSize = WalkSpeedSlider.AbsoluteSize.X
        
        local newX = math.clamp((mousePos - sliderPos) / sliderSize, 0, 1)
        SliderKnob.Position = UDim2.new(newX, 0, 0, 0)
        
        local newSpeed = 20 + newX * (maxSpeed - 20)
        
        local char = Player.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char.Humanoid.WalkSpeed = newSpeed
        end
        SliderLabel.Text = string.format("Walk Speed: %.0f", newSpeed)
    end
end)

--// Autofarm Features
-- Auto Plant
local AutoPlantButton = Instance.new("TextButton")
AutoPlantButton.Name = "AutoPlantButton"
AutoPlantButton.Size = UDim2.new(1, 0, 0, 40)
AutoPlantButton.Text = "Auto Plant Carrot: OFF"
AutoPlantButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoPlantButton.Font = Enum.Font.SourceSans
AutoPlantButton.TextSize = 18
AutoPlantButton.BackgroundColor3 = BUTTON_COLOR
AutoPlantButton.Parent = AutofarmFeaturesFrame
AutoPlantButton.LayoutOrder = 1

local autoPlantingEnabled = false
local function autoPlant()
    local corners = {
        Vector3.new(-136.7954864501953, 0.1355266571044922, -75.99693298339844),
        Vector3.new(-136.87689208984375, 0.1355266571044922, -133.9423065185547),
        Vector3.new(-62.98185348510742, 0.13552570343017578, -134.20787048339844),
        Vector3.new(-63.09858703613281, 0.1355266571044922, -75.636474609375)
    }
    
    while autoPlantingEnabled do
        local minX = math.min(corners[1].X, corners[2].X, corners[3].X, corners[4].X)
        local maxX = math.max(corners[1].X, corners[2].X, corners[3].X, corners[4].X)
        local minZ = math.min(corners[1].Z, corners[2].Z, corners[3].Z, corners[4].Z)
        local maxZ = math.max(corners[1].Z, corners[2].Z, corners[3].Z, corners[4].Z)
        
        local randomX = math.random() * (maxX - minX) + minX
        local randomZ = math.random() * (maxZ - minZ) + minZ
        
        local position = Vector3.new(randomX, corners[1].Y, randomZ)
        local args = { position, "Carrot" }
        GameEvents:WaitForChild("Plant_RE"):FireServer(unpack(args))
        
        task.wait(1)
    end
end

AutoPlantButton.MouseButton1Click:Connect(function()
    autoPlantingEnabled = not autoPlantingEnabled
    if autoPlantingEnabled then
        AutoPlantButton.Text = "Auto Plant Carrot: ON"
        AutoPlantButton.BackgroundColor3 = TOGGLE_ON_COLOR
        task.spawn(autoPlant)
    else
        AutoPlantButton.Text = "Auto Plant Carrot: OFF"
        AutoPlantButton.BackgroundColor3 = BUTTON_COLOR
    end
end)

-- Auto Buy Tier 1 Carrot Seed
local AutoBuyButton = Instance.new("TextButton")
AutoBuyButton.Name = "AutoBuyButton"
AutoBuyButton.Size = UDim2.new(1, 0, 0, 40)
AutoBuyButton.Text = "Auto Buy Tier 1 Carrot Seed"
AutoBuyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoBuyButton.Font = Enum.Font.SourceSans
AutoBuyButton.TextSize = 18
AutoBuyButton.BackgroundColor3 = BUTTON_COLOR
AutoBuyButton.Parent = AutofarmFeaturesFrame
AutoBuyButton.LayoutOrder = 2

AutoBuyButton.MouseButton1Click:Connect(function()
    local args = {
        "Tier 1",
        "Carrot"
    }
    GameEvents:WaitForChild("BuySeedStock"):FireServer(unpack(args))
end)

-- Teleport to Seed Shop
local SeedShopButton = Instance.new("TextButton")
SeedShopButton.Name = "SeedShopButton"
SeedShopButton.Size = UDim2.new(1, 0, 0, 40)
SeedShopButton.Text = "Teleport to Seed Shop"
SeedShopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SeedShopButton.Font = Enum.Font.SourceSans
SeedShopButton.TextSize = 18
SeedShopButton.BackgroundColor3 = BUTTON_COLOR
SeedShopButton.Parent = AutofarmFeaturesFrame
SeedShopButton.LayoutOrder = 3

SeedShopButton.MouseButton1Click:Connect(function()
    local args = { "Seed Shop" }
    GameEvents:WaitForChild("PlayerTeleportTriggered"):FireServer(unpack(args))
end)

-- Teleport to Sell Shop
local SellShopButton = Instance.new("TextButton")
SellShopButton.Name = "SellShopButton"
SellShopButton.Size = UDim2.new(1, 0, 0, 40)
SellShopButton.Text = "Teleport to Sell Shop"
SellShopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SellShopButton.Font = Enum.Font.SourceSans
SellShopButton.TextSize = 18
SellShopButton.BackgroundColor3 = BUTTON_COLOR
SellShopButton.Parent = AutofarmFeaturesFrame
SellShopButton.LayoutOrder = 4

SellShopButton.MouseButton1Click:Connect(function()
    local args = { "Sell Shop" }
    GameEvents:WaitForChild("PlayerTeleportTriggered"):FireServer(unpack(args))
end)

-- Sell Inventory
local SellInventoryButton = Instance.new("TextButton")
SellInventoryButton.Name = "SellInventoryButton"
SellInventoryButton.Size = UDim2.new(1, 0, 0, 40)
SellInventoryButton.Text = "Sell Inventory"
SellInventoryButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SellInventoryButton.Font = Enum.Font.SourceSans
SellInventoryButton.TextSize = 18
SellInventoryButton.BackgroundColor3 = BUTTON_COLOR
SellInventoryButton.Parent = AutofarmFeaturesFrame
SellInventoryButton.LayoutOrder = 5

SellInventoryButton.MouseButton1Click:Connect(function()
    GameEvents:WaitForChild("Sell_Inventory"):FireServer()
end)

-- Initial state
MainFeaturesFrame.Visible = true

-- Click Logo to Toggle Window
LogoButton.MouseButton1Click:Connect(function()
    Window.Visible = not Window.Visible
end)

fadeOutLoadingScreen(loadingScreen)
