loadstring([[
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SyruCustomGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Draggable Logo
local LogoButton = Instance.new("ImageButton")
LogoButton.Name = "LogoButton"
LogoButton.Parent = ScreenGui
LogoButton.Size = UDim2.new(0, 50, 0, 50) -- smaller logo
LogoButton.Position = UDim2.new(0.05, 0, 0.05, 0)
LogoButton.BackgroundColor3 = Color3.fromRGB(255, 20, 147)
LogoButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
LogoButton.BorderSizePixel = 3
LogoButton.Image = "https://raw.githubusercontent.com/Azizgaming0/Logo/main/Gemini_Generated_Image_thn6svthn6svthn6.png"

-- Dragging Logic
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    LogoButton.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

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

LogoButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Main Window
local Window = Instance.new("Frame")
Window.Name = "MainWindow"
Window.Size = UDim2.new(0.35, 0, 0.6, 0)
Window.Position = UDim2.new(0.5, 0, 0.5, 0)
Window.AnchorPoint = Vector2.new(0.5, 0.5)
Window.BackgroundColor3 = Color3.fromRGB(40, 44, 52)
Window.BorderSizePixel = 0
Window.Visible = false
Window.Parent = ScreenGui

-- Click Logo to Toggle Window
LogoButton.MouseButton1Click:Connect(function()
    Window.Visible = not Window.Visible
end)

-- Title
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Text = "Syru Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.BackgroundColor3 = Color3.fromRGB(40, 44, 52)
Title.Parent = Window

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 20
CloseButton.Parent = Window

CloseButton.MouseButton1Click:Connect(function()
    Window.Visible = false
end)

-- Main Tab Frame
local MainTab = Instance.new("Frame")
MainTab.Size = UDim2.new(1, -20, 0.85, 0)
MainTab.Position = UDim2.new(0.5, 0, 0.55, 0)
MainTab.AnchorPoint = Vector2.new(0.5, 0.5)
MainTab.BackgroundColor3 = Color3.fromRGB(50, 54, 62)
MainTab.Parent = Window

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = MainTab

-- Infinite Jump Toggle
local InfiniteJumpToggle = Instance.new("TextButton")
InfiniteJumpToggle.Size = UDim2.new(1, 0, 0, 40)
InfiniteJumpToggle.Text = "Infinite Jump: OFF"
InfiniteJumpToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
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

-- Walk Speed Slider
local WalkSpeedSlider = Instance.new("Frame")
WalkSpeedSlider.Size = UDim2.new(1, 0, 0, 20)
WalkSpeedSlider.BackgroundColor3 = Color3.fromRGB(60, 64, 72)
WalkSpeedSlider.Parent = MainTab
WalkSpeedSlider.LayoutOrder = 2

local SliderKnob = Instance.new("TextButton") -- Changed to TextButton so MouseButton1Down works
SliderKnob.Size = UDim2.new(0.1, 0, 1.2, 0)
SliderKnob.Position = UDim2.new(0, 0, 0, 0)
SliderKnob.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
SliderKnob.Text = ""
SliderKnob.Parent = WalkSpeedSlider

local SliderLabel = Instance.new("TextLabel")
SliderLabel.Size = UDim2.new(1, 0, 0.5, 0)
SliderLabel.Position = UDim2.new(0, 0, -1.5, 0)
SliderLabel.Text = "Walk Speed: 20"
SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SliderLabel.BackgroundTransparency = 1
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

UserInputService.InputChanged:Connect(function(input)
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
]])()
