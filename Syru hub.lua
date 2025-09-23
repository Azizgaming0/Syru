local placeId = game.PlaceId

if placeId == 126884695634066 then
    local Player = game.Players.LocalPlayer
    local PlayerGui = Player:WaitForChild("PlayerGui")
    local UserInputService = game:GetService("UserInputService")
    
    local FADE_TIME = 0.5
    
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
    
    local Window = Instance.new("Frame")
    Window.Name = "SettingsWindow"
    Window.Size = UDim2.new(0.3, 0, 0.6, 0)
    Window.Position = UDim2.new(0.5, -Window.Size.X.Offset/2, 0.5, -Window.Size.Y.Offset/2)
    Window.AnchorPoint = Vector2.new(0.5, 0.5)
    Window.BackgroundColor3 = Color3.fromRGB(40, 44, 52)
    Window.BorderSizePixel = 0
    Window.CornerRadius = UDim.new(0, 12)
    Window.Visible = false
    Window.Parent = ScreenGui
    
    local MainTab = Instance.new("Frame")
    MainTab.Name = "Main"
    MainTab.Size = UDim2.new(1, -20, 0.85, 0)
    MainTab.Position = UDim2.new(0.5, 0, 0.5, 20)
    MainTab.AnchorPoint = Vector2.new(0.5, 0.5)
    MainTab.BackgroundColor3 = Color3.fromRGB(50, 54, 62)
    MainTab.BorderSizePixel = 0
    MainTab.CornerRadius = UDim.new(0, 12)
    MainTab.Parent = Window
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Name = "UIListLayout"
    UIListLayout.Padding = UDim.new(0, 5)
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Parent = MainTab
    
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
    
    local OpenButton = Instance.new("ImageButton")
    OpenButton.Name = "OpenButton"
    OpenButton.Size = UDim2.new(0, 50, 0, 50)
    OpenButton.Position = UDim2.new(1, -60, 1, -60)
    OpenButton.Image = "rbxassetid://6283731477"
    OpenButton.BackgroundTransparency = 1
    OpenButton.Parent = ScreenGui
    
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Position = UDim2.new(0, 0, 0, 0)
    Title.Text = "Syru Script"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 24
    Title.BackgroundColor3 = Color3.fromRGB(40, 44, 52)
    Title.Parent = Window
    
    local InfiniteJumpToggle = Instance.new("TextButton")
    InfiniteJumpToggle.Name = "InfiniteJumpToggle"
    InfiniteJumpToggle.Size = UDim2.new(1, 0, 0, 40)
    InfiniteJumpToggle.Text = "Infinite Jump: OFF"
    InfiniteJumpToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    InfiniteJumpToggle.Font = Enum.Font.SourceSans
    InfiniteJumpToggle.TextSize = 18
    InfiniteJumpToggle.BackgroundColor3 = Color3.fromRGB(60, 64, 72)
    InfiniteJumpToggle.Parent = MainTab
    InfiniteJumpToggle.LayoutOrder = 1
    
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
    WalkSpeedSlider.LayoutOrder = 2
    
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
    
    local AutoPlantButton = Instance.new("TextButton")
    AutoPlantButton.Name = "AutoPlantButton"
    AutoPlantButton.Size = UDim2.new(1, 0, 0, 40)
    AutoPlantButton.Text = "Auto Plant Carrot"
    AutoPlantButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    AutoPlantButton.Font = Enum.Font.SourceSans
    AutoPlantButton.TextSize = 18
    AutoPlantButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    AutoPlantButton.Parent = MainTab
    AutoPlantButton.LayoutOrder = 3
    
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
    SeedShopButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    SeedShopButton.Parent = MainTab
    SeedShopButton.LayoutOrder = 4
    
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
    SellShopButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    SellShopButton.Parent = MainTab
    SellShopButton.LayoutOrder = 5
    
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
    SellInventoryButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    SellInventoryButton.Parent = MainTab
    SellInventoryButton.LayoutOrder = 6
    
    SellInventoryButton.MouseButton1Click:Connect(function()
        game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("Sell_Inventory"):FireServer()
    end)
    
    OpenButton.MouseButton1Click:Connect(function()
        Window.Visible = not Window.Visible
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        Window.Visible = false
    end)
    
    fadeOutLoadingScreen(loadingScreen)
end
