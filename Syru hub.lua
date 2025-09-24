loadstring([[
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")

local FADE_TIME = 0.5

-- Loading Screen UI
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

-- Main ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CustomUIScreen"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Logo Button (Draggable)
local LogoButton = Instance.new("ImageButton")
LogoButton.Name = "LogoButton"
LogoButton.Parent = ScreenGui
LogoButton.Size = UDim2.new(0, 50, 0, 50)
LogoButton.Position = UDim2.new(0.05, 0, 0.05, 0)
LogoButton.BackgroundColor3 = Color3.fromRGB(255, 20, 147)
LogoButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
LogoButton.BorderSizePixel = 3
LogoButton.Image = "https://raw.githubusercontent.com/Azizgaming0/Logo/main/Gemini_Generated_Image_thn6svthn6svthn6.png"

local UICorner_Logo = Instance.new("UICorner")
UICorner_Logo.CornerRadius = UDim.new(0.5, 0)
UICorner_Logo.Parent = LogoButton

-- Dragging Logic
local dragging = false
local dragStart = Vector2.new(0,0)
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
Window.Size = UDim2.new(0.35, 0, 0.6, 0)
Window.Position = UDim2.new(0.5, 0, 0.5, 0)
Window.AnchorPoint = Vector2.new(0.5, 0.5)
Window.BackgroundColor3 = Color3.fromRGB(40, 44, 52)
Window.BorderSizePixel = 0
Window.Visible = false
Window.Parent = ScreenGui

local UICorner_SettingsWindow = Instance.new("UICorner")
UICorner_SettingsWindow.CornerRadius = UDim.new(0, 12)
UICorner_SettingsWindow.Parent = Window

-- Title
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Text = "Syru Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 24
Title.BackgroundColor3 = Color3.fromRGB(40, 44, 52)
Title.Parent = Window

-- Tab Buttons Frame
local TabButtonsFrame = Instance.new("Frame")
TabButtonsFrame.Name = "TabButtons"
TabButtonsFrame.Size = UDim2.new(1, 0, 0, 40)
TabButtonsFrame.Position = UDim2.new(0, 0, 0, 40)
TabButtonsFrame.BackgroundColor3 = Color3.fromRGB(40, 44, 52)
TabButtonsFrame.Parent = Window

local TabButtonsLayout = Instance.new("UIListLayout")
TabButtonsLayout.FillDirection = Enum.FillDirection.Horizontal
TabButtonsLayout.Padding = UDim.new(0, 5)
TabButtonsLayout.Parent = TabButtonsFrame

-- Tab Content Frame
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

local function createTab(tabName)
    local tabButton = Instance.new("TextButton")
    tabButton.Name = tabName .. "Tab"
    tabButton.Size = UDim2.new(0.5, 0, 1, 0)
    tabButton.Text = tabName
    tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabButton.Font = Enum.Font.SourceSansBold
    tabButton.TextSize = 18
    tabButton.BackgroundColor3 = Color3.fromRGB(60, 64, 72)
    tabButton.Parent = TabButtonsFrame

    local tabFrame = Instance.new("Frame")
    tabFrame.Name = tabName
    tabFrame.Size = UDim2.new(1, 0, 1, 0)
    tabFrame.BackgroundTransparency = 1
    tabFrame.Visible = false
    tabFrame.Parent = TabContentFrame

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.Padding = UDim.new(0, 5)
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Parent = tabFrame
    
    tabButton.MouseButton1Click:Connect(function()
        for i, v in ipairs(TabContentFrame:GetChildren()) do
            if v:IsA("Frame") and v ~= tabFrame then
                v.Visible = false
            end
        end
        tabFrame.Visible = true
    end)

    return tabFrame
end

local MainTab = createTab("Main")
local AutofarmTab = createTab("Autofarm")

-- Add features to Main Tab
local InfiniteJumpToggle = Instance.new("TextButton")
InfiniteJumpToggle.Name = "InfiniteJumpToggle"
InfiniteJumpToggle.Size = UDim2.new(1, 0, 0, 40)
InfiniteJumpToggle.Text = "Infinite Jump: OFF"
InfiniteJumpToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
InfiniteJumpToggle.Font = Enum.Font.SourceSans
InfiniteJumpToggle.TextSize = 18
InfiniteJumpToggle.BackgroundColor3 = Color3.fromRGB(60, 64, 72)
InfiniteJumpToggle.Parent = MainTab

local infiniteJumpEnabled = false
local jumpConnection

InfiniteJumpToggle.MouseButton1Click:Connect(function()
    infiniteJumpEnabled = not infiniteJumpEnabled
    if infiniteJumpEnabled then
        InfiniteJumpToggle.Text = "Infinite Jump: ON"
        InfiniteJumpToggle.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
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
        InfiniteJumpToggle.BackgroundColor3 = Color3.fromRGB(60, 64, 72)
        if jumpConnection then
            jumpConnection:Disconnect()
            jumpConnection = nil
        end
    end
end)

local WalkSpeedSlider = Instance.new("Frame")
WalkSpeedSlider.Name = "WalkSpeedSlider"
WalkSpeedSlider.Size = UDim2.new(1, 0, 0, 20)
WalkSpeedSlider.BackgroundColor3 = Color3.fromRGB(60, 64, 72)
WalkSpeedSlider.Parent = MainTab

local SliderKnob = Instance.new("Frame")
SliderKnob.Name = "SliderKnob"
SliderKnob.Size = UDim2.new(0.1, 0, 1.2, 0)
SliderKnob.Position = UDim2.new(0, 0, 0, 0)
SliderKnob.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
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

-- Add features to Autofarm Tab
local AutoPlantButton = Instance.new("TextButton")
AutoPlantButton.Name = "AutoPlantButton"
AutoPlantButton.Size = UDim2.new(1, 0, 0, 40)
AutoPlantButton.Text = "Auto Plant Carrot: OFF"
AutoPlantButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoPlantButton.Font = Enum.Font.SourceSans
AutoPlantButton.TextSize = 18
AutoPlantButton.BackgroundColor3 = Color3.fromRGB(60, 64, 72)
AutoPlantButton.Parent = AutofarmTab

local autoPlantingEnabled = false
local plantConnection

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
        game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("Plant_RE"):FireServer(unpack(args))
        
        task.wait(1)
    end
end

AutoPlantButton.MouseButton1Click:Connect(function()
    autoPlantingEnabled = not autoPlantingEnabled
    if autoPlantingEnabled then
        AutoPlantButton.Text = "Auto Plant Carrot: ON"
        AutoPlantButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        task.spawn(autoPlant)
    else
        AutoPlantButton.Text = "Auto Plant Carrot: OFF"
        AutoPlantButton.BackgroundColor3 = Color3.fromRGB(60, 64, 72)
    end
end)

local SeedShopButton = Instance.new("TextButton")
SeedShopButton.Name = "SeedShopButton"
SeedShopButton.Size = UDim2.new(1, 0, 0, 40)
SeedShopButton.Text = "Teleport to Seed Shop"
SeedShopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SeedShopButton.Font = Enum.Font.SourceSans
SeedShopButton.TextSize = 18
SeedShopButton.BackgroundColor3 = Color3.fromRGB(60, 64, 72)
SeedShopButton.Parent = AutofarmTab

SeedShopButton.MouseButton1Click:Connect(function()
    local args = { "Seed Shop" }
    game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("PlayerTeleportTriggered"):FireServer(unpack(args))
end)

local SellShopButton = Instance.new("TextButton")
SellShopButton.Name = "SellShopButton"
SellShopButton.Size = UDim2.new(1, 0, 0, 40)
SellShopButton.Text = "Teleport to Sell Shop"
SellShopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SellShopButton.Font = Enum.Font.SourceSans
SellShopButton.TextSize = 18
SellShopButton.BackgroundColor3 = Color3.fromRGB(60, 64, 72)
SellShopButton.Parent = AutofarmTab

SellShopButton.MouseButton1Click:Connect(function()
    local args = { "Sell Shop" }
    game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("PlayerTeleportTriggered"):FireServer(unpack(args))
end)

local SellInventoryButton = Instance.new("TextButton")
SellInventoryButton.Name = "SellInventoryButton"
SellInventoryButton.Size = UDim2.new(1, 0, 0, 40)
SellInventoryButton.Text = "Sell Inventory"
SellInventoryButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SellInventoryButton.Font = Enum.Font.SourceSans
SellInventoryButton.TextSize = 18
SellInventoryButton.BackgroundColor3 = Color3.fromRGB(60, 64, 72)
SellInventoryButton.Parent = AutofarmTab

SellInventoryButton.MouseButton1Click:Connect(function()
    game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("Sell_Inventory"):FireServer()
end)

-- Initial state
MainTab.Visible = true

-- Click Logo to Toggle Window
LogoButton.MouseButton1Click:Connect(function()
    Window.Visible = not Window.Visible
end)

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

fadeOutLoadingScreen(loadingScreen)
]])()
