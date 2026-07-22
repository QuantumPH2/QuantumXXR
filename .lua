-- ========================================================
-- ELEGAN & MODERN LIGHT GREEN KEY SYSTEM UI (ROBLOX LUA)
-- ========================================================

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

-- Clean up UI lama jika sudah ada
local parentTarget = (gethui and gethui()) or LocalPlayer:WaitForChild("PlayerGui")
if parentTarget:FindFirstChild("PremiumKeySystemUI") then
    parentTarget.PremiumKeySystemUI:Destroy()
end

-- 1. Main ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PremiumKeySystemUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = parentTarget

-- Main Container (Panel Utama)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 0, 0, 0) -- Dimulai dari 0 untuk animasi intro scale
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 23, 18)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainUICorner = Instance.new("UICorner")
MainUICorner.CornerRadius = UDim.new(0, 16)
MainUICorner.Parent = MainFrame

local MainUIStroke = Instance.new("UIStroke")
MainUIStroke.Thickness = 1.5
MainUIStroke.Color = Color3.fromRGB(120, 220, 150)
MainUIStroke.Transparency = 0.4
MainUIStroke.Parent = MainFrame

local MainUIGradient = Instance.new("UIGradient")
MainUIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 32, 24)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(12, 20, 15)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 38, 28))
})
MainUIGradient.Rotation = 45
MainUIGradient.Parent = MainFrame

local MainPadding = Instance.new("UIPadding")
MainPadding.PaddingTop = UDim.new(0, 16)
MainPadding.PaddingBottom = UDim.new(0, 16)
MainPadding.PaddingLeft = UDim.new(0, 16)
MainPadding.PaddingRight = UDim.new(0, 16)
MainPadding.Parent = MainFrame

-- Layout 3 Panel
local ContentLayout = Instance.new("UIListLayout")
ContentLayout.FillDirection = Enum.FillDirection.Horizontal
ContentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ContentLayout.VerticalAlignment = Enum.VerticalAlignment.Center
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
ContentLayout.Padding = UDim.new(0, 12)
ContentLayout.Parent = MainFrame

-- Helper Function untuk style Panel
local function createPanel(name, size, layoutOrder)
    local panel = Instance.new("Frame")
    panel.Name = name
    panel.Size = size
    panel.BackgroundColor3 = Color3.fromRGB(25, 40, 30)
    panel.BorderSizePixel = 0
    panel.LayoutOrder = layoutOrder
    panel.Parent = MainFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = panel

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1
    stroke.Color = Color3.fromRGB(140, 240, 170)
    stroke.Transparency = 0.7
    stroke.Parent = panel

    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(28, 45, 34)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 28, 21))
    })
    gradient.Rotation = 90
    gradient.Parent = panel

    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, 12)
    padding.PaddingBottom = UDim.new(0, 12)
    padding.PaddingLeft = UDim.new(0, 12)
    padding.PaddingRight = UDim.new(0, 12)
    padding.Parent = panel

    return panel
end

-- ========================================================
-- PANEL KIRI: Player Profile
-- ========================================================
local LeftPanel = createPanel("LeftPanel", UDim2.new(0, 140, 1, 0), 1)

local LeftLayout = Instance.new("UIListLayout")
LeftLayout.FillDirection = Enum.FillDirection.Vertical
LeftLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
LeftLayout.VerticalAlignment = Enum.VerticalAlignment.Center
LeftLayout.Padding = UDim.new(0, 8)
LeftLayout.Parent = LeftPanel

-- Avatar Image
local AvatarIcon = Instance.new("ImageLabel")
AvatarIcon.Size = UDim2.new(0, 56, 0, 56)
AvatarIcon.BackgroundColor3 = Color3.fromRGB(40, 60, 48)
AvatarIcon.BorderSizePixel = 0
AvatarIcon.Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=150&h=150"
AvatarIcon.Parent = LeftPanel

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(1, 0)
AvatarCorner.Parent = AvatarIcon

local AvatarStroke = Instance.new("UIStroke")
AvatarStroke.Thickness = 2
AvatarStroke.Color = Color3.fromRGB(130, 245, 170)
AvatarStroke.Parent = AvatarIcon

local WelcomeLabel = Instance.new("TextLabel")
WelcomeLabel.Size = UDim2.new(1, 0, 0, 14)
WelcomeLabel.BackgroundTransparency = 1
WelcomeLabel.Font = Enum.Font.GothamMedium
WelcomeLabel.Text = "WELCOME"
WelcomeLabel.TextColor3 = Color3.fromRGB(140, 200, 160)
WelcomeLabel.TextSize = 10
WelcomeLabel.Parent = LeftPanel

local PlayerNameLabel = Instance.new("TextLabel")
PlayerNameLabel.Size = UDim2.new(1, 0, 0, 18)
PlayerNameLabel.BackgroundTransparency = 1
PlayerNameLabel.Font = Enum.Font.GothamBold
PlayerNameLabel.Text = LocalPlayer.DisplayName
PlayerNameLabel.TextColor3 = Color3.fromRGB(235, 255, 240)
PlayerNameLabel.TextSize = 13
PlayerNameLabel.TextTruncate = Enum.TextTruncate.AtEnd
PlayerNameLabel.Parent = LeftPanel

local StatusBadge = Instance.new("Frame")
StatusBadge.Size = UDim2.new(0, 80, 0, 20)
StatusBadge.BackgroundColor3 = Color3.fromRGB(35, 75, 48)
StatusBadge.BorderSizePixel = 0
StatusBadge.Parent = LeftPanel

local BadgeCorner = Instance.new("UICorner")
BadgeCorner.CornerRadius = UDim.new(0, 10)
BadgeCorner.Parent = StatusBadge

local BadgeText = Instance.new("TextLabel")
BadgeText.Size = UDim2.new(1, 0, 1, 0)
BadgeText.BackgroundTransparency = 1
BadgeText.Font = Enum.Font.GothamBold
BadgeText.Text = "• ONLINE"
BadgeText.TextColor3 = Color3.fromRGB(130, 255, 170)
BadgeText.TextSize = 10
BadgeText.Parent = StatusBadge

-- ========================================================
-- PANEL TENGAH: Key Verification System
-- ========================================================
local CenterPanel = createPanel("CenterPanel", UDim2.new(0, 220, 1, 0), 2)

local CenterLayout = Instance.new("UIListLayout")
CenterLayout.FillDirection = Enum.FillDirection.Vertical
CenterLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
CenterLayout.VerticalAlignment = Enum.VerticalAlignment.Center -- DIUBAH DARI SpaceBetween KE Center
CenterLayout.Padding = UDim.new(0, 12) -- MENAMBAHKAN PADDING RAPI
CenterLayout.Parent = CenterPanel

local TitleFrame = Instance.new("Frame")
TitleFrame.Size = UDim2.new(1, 0, 0, 32)
TitleFrame.BackgroundTransparency = 1
TitleFrame.Parent = CenterPanel

local KeyIcon = Instance.new("ImageLabel")
KeyIcon.Size = UDim2.new(0, 18, 0, 18)
KeyIcon.Position = UDim2.new(0, 8, 0, 7)
KeyIcon.BackgroundTransparency = 1
KeyIcon.Image = "rbxassetid://6031082533"
KeyIcon.ImageColor3 = Color3.fromRGB(140, 245, 170)
KeyIcon.Parent = TitleFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Position = UDim2.new(0, 32, 0, 0)
TitleLabel.Size = UDim2.new(1, -32, 1, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "KEY SYSTEM"
TitleLabel.TextColor3 = Color3.fromRGB(240, 255, 245)
TitleLabel.TextSize = 14
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleFrame

-- Textbox Input Key
local InputContainer = Instance.new("Frame")
InputContainer.Size = UDim2.new(1, 0, 0, 38)
InputContainer.BackgroundColor3 = Color3.fromRGB(16, 26, 20)
InputContainer.BorderSizePixel = 0
InputContainer.Parent = CenterPanel

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 8)
InputCorner.Parent = InputContainer

local InputStroke = Instance.new("UIStroke")
InputStroke.Thickness = 1
InputStroke.Color = Color3.fromRGB(70, 130, 90)
InputStroke.Parent = InputContainer

local KeyTextBox = Instance.new("TextBox")
KeyTextBox.Size = UDim2.new(1, -16, 1, 0)
KeyTextBox.Position = UDim2.new(0, 8, 0, 0)
KeyTextBox.BackgroundTransparency = 1
KeyTextBox.Font = Enum.Font.GothamMedium
KeyTextBox.PlaceholderText = "Enter Key Here..."
KeyTextBox.PlaceholderColor3 = Color3.fromRGB(90, 120, 100)
KeyTextBox.Text = ""
KeyTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTextBox.TextSize = 12
KeyTextBox.ClearTextOnFocus = false
KeyTextBox.Parent = InputContainer

-- Tombol Enter Key (Fokus Utama dengan Glow)
local EnterButton = Instance.new("TextButton")
EnterButton.Size = UDim2.new(1, 0, 0, 38)
EnterButton.BackgroundColor3 = Color3.fromRGB(45, 160, 95)
EnterButton.BorderSizePixel = 0
EnterButton.Font = Enum.Font.GothamBold
EnterButton.Text = "ENTER KEY"
EnterButton.TextColor3 = Color3.fromRGB(10, 30, 18)
EnterButton.TextSize = 12
EnterButton.AutoButtonColor = false
EnterButton.Parent = CenterPanel

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 8)
ButtonCorner.Parent = EnterButton

local ButtonStroke = Instance.new("UIStroke")
ButtonStroke.Thickness = 1.5
ButtonStroke.Color = Color3.fromRGB(150, 255, 180)
ButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
ButtonStroke.Parent = EnterButton

local ButtonGradient = Instance.new("UIGradient")
ButtonGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(130, 245, 170)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 170, 100))
})
ButtonGradient.Rotation = 90
ButtonGradient.Parent = EnterButton

-- ========================================================
-- PANEL KANAN: Pricing & Script Info
-- ========================================================
local RightPanel = createPanel("RightPanel", UDim2.new(0, 140, 1, 0), 3)

local RightLayout = Instance.new("UIListLayout")
RightLayout.FillDirection = Enum.FillDirection.Vertical
RightLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
RightLayout.VerticalAlignment = Enum.VerticalAlignment.Center
RightLayout.Padding = UDim.new(0, 6)
RightLayout.Parent = RightPanel

local CrownIcon = Instance.new("ImageLabel")
CrownIcon.Size = UDim2.new(0, 28, 0, 28)
CrownIcon.BackgroundTransparency = 1
CrownIcon.Image = "rbxassetid://6031068426"
CrownIcon.ImageColor3 = Color3.fromRGB(140, 245, 170)
CrownIcon.Parent = RightPanel

local PriceHeader = Instance.new("TextLabel")
PriceHeader.Size = UDim2.new(1, 0, 0, 14)
PriceHeader.BackgroundTransparency = 1
PriceHeader.Font = Enum.Font.GothamMedium
PriceHeader.Text = "SCRIPT TIER"
PriceHeader.TextColor3 = Color3.fromRGB(130, 190, 150)
PriceHeader.TextSize = 10
PriceHeader.Parent = RightPanel

local PriceValue = Instance.new("TextLabel")
PriceValue.Size = UDim2.new(1, 0, 0, 22)
PriceValue.BackgroundTransparency = 1
PriceValue.Font = Enum.Font.GothamBlack
PriceValue.Text = "$9.99 / Mo"
PriceValue.TextColor3 = Color3.fromRGB(240, 255, 245)
PriceValue.TextSize = 14
PriceValue.Parent = RightPanel

local FeatureTag = Instance.new("TextLabel")
FeatureTag.Size = UDim2.new(1, 0, 0, 14)
FeatureTag.BackgroundTransparency = 1
FeatureTag.Font = Enum.Font.Gotham
FeatureTag.Text = "★ VIP Access"
FeatureTag.TextColor3 = Color3.fromRGB(120, 220, 150)
FeatureTag.TextSize = 10
FeatureTag.Parent = RightPanel

-- ========================================================
-- INTERAKSI & ANIMASI
-- ========================================================

-- Animasi Intro (Fade + Scale)
local targetSize = UDim2.new(0, 540, 0, 210)
MainFrame.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(MainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = targetSize
}):Play()

-- Continuous UIGradient Animation
local gradientRotation = 0
RunService.RenderStepped:Connect(function(dt)
    gradientRotation = (gradientRotation + dt * 25) % 360
    MainUIGradient.Rotation = gradientRotation
    
    local pulse = (math.sin(tick() * 3) + 1) / 2
    MainUIStroke.Transparency = 0.3 + (pulse * 0.3)
end)

-- Hover & Click Effect
EnterButton.MouseEnter:Connect(function()
    TweenService:Create(EnterButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(60, 190, 115)
    }):Play()
    TweenService:Create(ButtonStroke, TweenInfo.new(0.2), {
        Transparency = 0
    }):Play()
end)

EnterButton.MouseLeave:Connect(function()
    TweenService:Create(EnterButton, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(45, 160, 95)
    }):Play()
    TweenService:Create(ButtonStroke, TweenInfo.new(0.2), {
        Transparency = 0.3
    }):Play()
end)

EnterButton.MouseButtonDown:Connect(function()
    TweenService:Create(EnterButton, TweenInfo.new(0.08), {
        Size = UDim2.new(0.95, 0, 0, 34)
    }):Play()
end)

EnterButton.MouseButtonUp:Connect(function()
    TweenService:Create(EnterButton, TweenInfo.new(0.08), {
        Size = UDim2.new(1, 0, 0, 38)
    }):Play()
end)

-- Logika Eksekusi Key
EnterButton.MouseButtonClick:Connect(function()
    local enteredKey = KeyTextBox.Text
    
    if enteredKey == "" then
        KeyTextBox.PlaceholderText = "Key cannot be empty!"
        return
    end

    EnterButton.Text = "CHECKING..."
    task.wait(0.6)

    if enteredKey == "PREMIUM123" or enteredKey ~= "" then
        EnterButton.Text = "VALID KEY!"
        EnterButton.BackgroundColor3 = Color3.fromRGB(40, 200, 100)
        
        task.wait(0.8)
        local closeTween = TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0)
        })
        closeTween:Play()
        closeTween.Completed:Connect(function()
            ScreenGui:Destroy()
            print("Key Accepted! Script Executed.")
        end)
    end
end)
