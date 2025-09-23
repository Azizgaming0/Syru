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
    Window.Size = UDim2.new(0.3, 0, 0.5, 0)
    Window.Position = UDim2.new(0.5, -Window.Size.X.Offset/2, 0.5, -Window.Size.Y.Offset/2)
    Window.AnchorPoint = Vector2.new(0.5, 0.5)
    Window.BackgroundColor3 = Color3.fromRGB(40, 44, 52)
    Window.BorderSizePixel = 0
    Window.CornerRadius = UDim.new(0, 12)
    Window.Visible = false
    Window.Parent = ScreenGui
    
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
    
    local InfiniteJumpToggle = Instance.new("TextButton")
    InfiniteJumpToggle.Name = "InfiniteJumpToggle"
    InfiniteJumpToggle.Size = UDim2.new(1, -20, 0, 40)
    InfiniteJumpToggle.Position = UDim2.new(0.5, 0, 0.25, 0)
    InfiniteJumpToggle.AnchorPoint = Vector2.new(0.5, 0.5)
    InfiniteJumpToggle.Text = "Infinite Jump: OFF"
    InfiniteJumpToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    InfiniteJumpToggle.Font = Enum.Font.SourceSans
    InfiniteJumpToggle.TextSize = 18
    InfiniteJumpToggle.BackgroundColor3 = Color3.fromRGB(60, 64, 72)
    InfiniteJumpToggle.Parent = Window
    
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
    WalkSpeedSlider.Size = UDim2.new(1, -20, 0, 20)
    WalkSpeedSlider.Position = UDim2.new(0.5, 0, 0.45, 0)
    WalkSpeedSlider.AnchorPoint = Vector2.new(0.5, 0.5)
    WalkSpeedSlider.BackgroundColor3 = Color3.fromRGB(60, 64, 72)
    WalkSpeedSlider.Parent = Window
    
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
    
    OpenButton.MouseButton1Click:Connect(function()
        Window.Visible = not Window.Visible
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        Window.Visible = false
    end)
    
    fadeOutLoadingScreen(loadingScreen)
end
