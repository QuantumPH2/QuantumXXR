local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local KeySystem = {}
KeySystem.Config = {
    Key = "PREMIUM-2026-X7K9",
    Title = "Premium Key System",
    Subtitle = "Enter your premium key to continue.",
    GetKeyUrl = "https://discord.gg/example",
    Size = UDim2.new(0, 420, 0, 520),
    MainColor = Color3.fromHex("#22C55E"),
    BackgroundColor = Color3.fromHex("#0D1117"),
    ErrorColor = Color3.fromRGB(239, 68, 68),
    SuccessColor = Color3.fromRGB(34, 197, 94),
}

function KeySystem:Create()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "PremiumKeySystem"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = playerGui

    local blur = Instance.new("BlurEffect")
    blur.Size = 0
    blur.Parent = game:GetService("Lighting")
    TweenService:Create(blur, TweenInfo.new(0.6, Enum.EasingStyle.Quart), {Size = 12}):Play()

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = KeySystem.Config.Size
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.BackgroundColor3 = KeySystem.Config.BackgroundColor
    mainFrame.BackgroundTransparency = 0.15
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 18)
    corner.Parent = mainFrame

    local stroke = Instance.new("UIStroke")
    stroke.Color = KeySystem.Config.MainColor
    stroke.Thickness = 1.2
    stroke.Transparency = 0.7
    stroke.Parent = mainFrame

    local topGlow = Instance.new("Frame")
    topGlow.Name = "TopGlow"
    topGlow.Size = UDim2.new(1, 0, 0, 2)
    topGlow.Position = UDim2.new(0, 0, 0, 0)
    topGlow.BackgroundColor3 = KeySystem.Config.MainColor
    topGlow.BorderSizePixel = 0
    topGlow.Parent = mainFrame

    local topGlowGradient = Instance.new("UIGradient")
    topGlowGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, KeySystem.Config.MainColor),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 255, 150)),
        ColorSequenceKeypoint.new(1, KeySystem.Config.MainColor),
    })
    topGlowGradient.Parent = topGlow

    local ambientGlow = Instance.new("ImageLabel")
    ambientGlow.Name = "AmbientGlow"
    ambientGlow.Size = UDim2.new(1.5, 0, 1.5, 0)
    ambientGlow.Position = UDim2.new(0.5, 0, 0.3, 0)
    ambientGlow.AnchorPoint = Vector2.new(0.5, 0.5)
    ambientGlow.BackgroundTransparency = 1
    ambientGlow.Image = "rbxassetid://5028857084"
    ambientGlow.ImageColor3 = KeySystem.Config.MainColor
    ambientGlow.ImageTransparency = 0.92
    ambientGlow.ZIndex = 0
    ambientGlow.Parent = mainFrame

    local particleContainer = Instance.new("Frame")
    particleContainer.Name = "Particles"
    particleContainer.Size = UDim2.new(1, 0, 1, 0)
    particleContainer.BackgroundTransparency = 1
    particleContainer.ZIndex = 1
    particleContainer.Parent = mainFrame

    local particles = {}
    for i = 1, 12 do
        local p = Instance.new("Frame")
        p.Size = UDim2.new(0, math.random(2, 5), 0, math.random(2, 5))
        p.Position = UDim2.new(math.random(), 0, math.random(), 0)
        p.BackgroundColor3 = KeySystem.Config.MainColor
        p.BackgroundTransparency = math.random(30, 70) / 100
        p.BorderSizePixel = 0
        p.ZIndex = 1
        local pc = Instance.new("UICorner")
        pc.CornerRadius = UDim.new(1, 0)
        pc.Parent = p
        p.Parent = particleContainer
        table.insert(particles, {
            frame = p,
            speed = math.random(5, 15) / 100,
            offset = math.random() * 6.28,
        })
    end

    RunService.RenderStepped:Connect(function(dt)
        for _, p in ipairs(particles) do
            p.offset = p.offset + p.speed * dt
            local y = math.sin(p.offset) * 0.03
            local x = math.cos(p.offset * 0.7) * 0.01
            p.frame.Position = p.frame.Position + UDim2.new(x, 0, y, 0)
        end
    end)

    local content = Instance.new("Frame")
    content.Name = "Content"
    content.Size = UDim2.new(1, -48, 1, -48)
    content.Position = UDim2.new(0, 24, 0, 24)
    content.BackgroundTransparency = 1
    content.Parent = mainFrame

    local logoContainer = Instance.new("Frame")
    logoContainer.Name = "LogoContainer"
    logoContainer.Size = UDim2.new(0, 64, 0, 64)
    logoContainer.Position = UDim2.new(0.5, 0, 0, 0)
    logoContainer.AnchorPoint = Vector2.new(0.5, 0)
    logoContainer.BackgroundColor3 = KeySystem.Config.MainColor
    logoContainer.BackgroundTransparency = 0.85
    logoContainer.BorderSizePixel = 0
    logoContainer.Parent = content

    local logoCorner = Instance.new("UICorner")
    logoCorner.CornerRadius = UDim.new(1, 0)
    logoCorner.Parent = logoContainer

    local logoStroke = Instance.new("UIStroke")
    logoStroke.Color = KeySystem.Config.MainColor
    logoStroke.Thickness = 1.5
    logoStroke.Transparency = 0.4
    logoStroke.Parent = logoContainer

    local logoIcon = Instance.new("ImageLabel")
    logoIcon.Name = "LogoIcon"
    logoIcon.Size = UDim2.new(0, 32, 0, 32)
    logoIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
    logoIcon.AnchorPoint = Vector2.new(0.5, 0.5)
    logoIcon.BackgroundTransparency = 1
    logoIcon.Image = "rbxassetid://7733965386"
    logoIcon.ImageColor3 = KeySystem.Config.MainColor
    logoIcon.Parent = logoContainer

    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0, 32)
    title.Position = UDim2.new(0, 0, 0, 80)
    title.BackgroundTransparency = 1
    title.Text = KeySystem.Config.Title
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 26
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Center
    title.Parent = content

    local subtitle = Instance.new("TextLabel")
    subtitle.Name = "Subtitle"
    subtitle.Size = UDim2.new(1, 0, 0, 20)
    subtitle.Position = UDim2.new(0, 0, 0, 116)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = KeySystem.Config.Subtitle
    subtitle.TextColor3 = Color3.fromRGB(150, 160, 170)
    subtitle.TextSize = 14
    subtitle.Font = Enum.Font.Gotham
    subtitle.TextXAlignment = Enum.TextXAlignment.Center
    subtitle.Parent = content

    local inputContainer = Instance.new("Frame")
    inputContainer.Name = "InputContainer"
    inputContainer.Size = UDim2.new(1, 0, 0, 52)
    inputContainer.Position = UDim2.new(0, 0, 0, 170)
    inputContainer.BackgroundColor3 = Color3.fromRGB(20, 25, 32)
    inputContainer.BackgroundTransparency = 0.3
    inputContainer.BorderSizePixel = 0
    inputContainer.Parent = content

    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 14)
    inputCorner.Parent = inputContainer

    local inputStroke = Instance.new("UIStroke")
    inputStroke.Color = Color3.fromRGB(40, 50, 60)
    inputStroke.Thickness = 1.2
    inputStroke.Transparency = 0.5
    inputStroke.Parent = inputContainer

    local keyIcon = Instance.new("ImageLabel")
    keyIcon.Name = "KeyIcon"
    keyIcon.Size = UDim2.new(0, 20, 0, 20)
    keyIcon.Position = UDim2.new(0, 16, 0.5, 0)
    keyIcon.AnchorPoint = Vector2.new(0, 0.5)
    keyIcon.BackgroundTransparency = 1
    keyIcon.Image = "rbxassetid://7733955511"
    keyIcon.ImageColor3 = Color3.fromRGB(120, 130, 140)
    keyIcon.Parent = inputContainer

    local textBox = Instance.new("TextBox")
    textBox.Name = "KeyInput"
    textBox.Size = UDim2.new(1, -56, 1, 0)
    textBox.Position = UDim2.new(0, 44, 0, 0)
    textBox.BackgroundTransparency = 1
    textBox.Text = ""
    textBox.PlaceholderText = "Enter your key..."
    textBox.PlaceholderColor3 = Color3.fromRGB(100, 110, 120)
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.TextSize = 15
    textBox.Font = Enum.Font.Gotham
    textBox.ClearTextOnFocus = false
    textBox.TextXAlignment = Enum.TextXAlignment.Left
    textBox.Parent = inputContainer

    textBox.Focused:Connect(function()
        TweenService:Create(inputStroke, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {
            Color = KeySystem.Config.MainColor,
            Transparency = 0.3,
        }):Play()
        TweenService:Create(keyIcon, TweenInfo.new(0.25), {ImageColor3 = KeySystem.Config.MainColor}):Play()
    end)

    textBox.FocusLost:Connect(function()
        TweenService:Create(inputStroke, TweenInfo.new(0.25, Enum.EasingStyle.Quart), {
            Color = Color3.fromRGB(40, 50, 60),
            Transparency = 0.5,
        }):Play()
        TweenService:Create(keyIcon, TweenInfo.new(0.25), {ImageColor3 = Color3.fromRGB(120, 130, 140)}):Play()
    end)

    local verifyBtn = Instance.new("TextButton")
    verifyBtn.Name = "VerifyButton"
    verifyBtn.Size = UDim2.new(1, 0, 0, 48)
    verifyBtn.Position = UDim2.new(0, 0, 0, 242)
    verifyBtn.BackgroundColor3 = KeySystem.Config.MainColor
    verifyBtn.BorderSizePixel = 0
    verifyBtn.Text = "Verify Key"
    verifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    verifyBtn.TextSize = 15
    verifyBtn.Font = Enum.Font.GothamBold
    verifyBtn.AutoButtonColor = false
    verifyBtn.Parent = content

    local verifyCorner = Instance.new("UICorner")
    verifyCorner.CornerRadius = UDim.new(0, 14)
    verifyCorner.Parent = verifyBtn

    local verifyShadow = Instance.new("ImageLabel")
    verifyShadow.Name = "Shadow"
    verifyShadow.Size = UDim2.new(1, 16, 1, 16)
    verifyShadow.Position = UDim2.new(0.5, 0, 0.5, 4)
    verifyShadow.AnchorPoint = Vector2.new(0.5, 0.5)
    verifyShadow.BackgroundTransparency = 1
    verifyShadow.Image = "rbxassetid://5028857084"
    verifyShadow.ImageColor3 = KeySystem.Config.MainColor
    verifyShadow.ImageTransparency = 0.75
    verifyShadow.ZIndex = 0
    verifyShadow.Parent = verifyBtn

    local getKeyBtn = Instance.new("TextButton")
    getKeyBtn.Name = "GetKeyButton"
    getKeyBtn.Size = UDim2.new(1, 0, 0, 44)
    getKeyBtn.Position = UDim2.new(0, 0, 0, 302)
    getKeyBtn.BackgroundColor3 = Color3.fromRGB(20, 25, 32)
    getKeyBtn.BackgroundTransparency = 0.2
    getKeyBtn.BorderSizePixel = 0
    getKeyBtn.Text = "Get Key"
    getKeyBtn.TextColor3 = Color3.fromRGB(180, 190, 200)
    getKeyBtn.TextSize = 14
    getKeyBtn.Font = Enum.Font.GothamSemibold
    getKeyBtn.AutoButtonColor = false
    getKeyBtn.Parent = content

    local getKeyCorner = Instance.new("UICorner")
    getKeyCorner.CornerRadius = UDim.new(0, 14)
    getKeyCorner.Parent = getKeyBtn

    local getKeyStroke = Instance.new("UIStroke")
    getKeyStroke.Color = Color3.fromRGB(50, 60, 70)
    getKeyStroke.Thickness = 1
    getKeyStroke.Transparency = 0.6
    getKeyStroke.Parent = getKeyBtn

    local statusLabel = Instance.new("TextLabel")
    statusLabel.Name = "Status"
    statusLabel.Size = UDim2.new(1, 0, 0, 20)
    statusLabel.Position = UDim2.new(0, 0, 0, 366)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = ""
    statusLabel.TextColor3 = Color3.fromRGB(150, 160, 170)
    statusLabel.TextSize = 13
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextXAlignment = Enum.TextXAlignment.Center
    statusLabel.Parent = content

    local spinner = Instance.new("Frame")
    spinner.Name = "Spinner"
    spinner.Size = UDim2.new(0, 20, 0, 20)
    spinner.Position = UDim2.new(0.5, -40, 0.5, -10)
    spinner.BackgroundTransparency = 1
    spinner.Visible = false
    spinner.Parent = verifyBtn

    local spinnerCircle = Instance.new("ImageLabel")
    spinnerCircle.Size = UDim2.new(1, 0, 1, 0)
    spinnerCircle.BackgroundTransparency = 1
    spinnerCircle.Image = "rbxassetid://3926305904"
    spinnerCircle.ImageRectOffset = Vector2.new(404, 484)
    spinnerCircle.ImageRectSize = Vector2.new(36, 36)
    spinnerCircle.ImageColor3 = Color3.fromRGB(255, 255, 255)
    spinnerCircle.Parent = spinner

    local checkmark = Instance.new("Frame")
    checkmark.Name = "Checkmark"
    checkmark.Size = UDim2.new(0, 20, 0, 20)
    checkmark.Position = UDim2.new(0.5, -40, 0.5, -10)
    checkmark.BackgroundTransparency = 1
    checkmark.Visible = false
    checkmark.Parent = verifyBtn

    local checkmarkIcon = Instance.new("ImageLabel")
    checkmarkIcon.Size = UDim2.new(1, 0, 1, 0)
    checkmarkIcon.BackgroundTransparency = 1
    checkmarkIcon.Image = "rbxassetid://3926305904"
    checkmarkIcon.ImageRectOffset = Vector2.new(312, 4)
    checkmarkIcon.ImageRectSize = Vector2.new(24, 24)
    checkmarkIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
    checkmarkIcon.Parent = checkmark

    local function ripple(btn, x, y)
        local ripple = Instance.new("Frame")
        ripple.Size = UDim2.new(0, 0, 0, 0)
        ripple.Position = UDim2.new(0, x, 0, y)
        ripple.AnchorPoint = Vector2.new(0.5, 0.5)
        ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ripple.BackgroundTransparency = 0.7
        ripple.BorderSizePixel = 0
        ripple.ZIndex = 10
        local rc = Instance.new("UICorner")
        rc.CornerRadius = UDim.new(1, 0)
        rc.Parent = ripple
        ripple.Parent = btn
        local targetSize = math.max(btn.AbsoluteSize.X, btn.AbsoluteSize.Y) * 2.5
        TweenService:Create(ripple, TweenInfo.new(0.6, Enum.EasingStyle.Quart), {
            Size = UDim2.new(0, targetSize, 0, targetSize),
            BackgroundTransparency = 1,
        }):Play()
        task.delay(0.6, function()
            ripple:Destroy()
        end)
    end

    verifyBtn.MouseButton1Down:Connect(function(x, y)
        ripple(verifyBtn, x - verifyBtn.AbsolutePosition.X, y - verifyBtn.AbsolutePosition.Y)
    end)

    getKeyBtn.MouseButton1Down:Connect(function(x, y)
        ripple(getKeyBtn, x - getKeyBtn.AbsolutePosition.X, y - getKeyBtn.AbsolutePosition.Y)
    end)

    verifyBtn.MouseEnter:Connect(function()
        TweenService:Create(verifyBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {BackgroundColor3 = Color3.fromRGB(50, 210, 100)}):Play()
        TweenService:Create(verifyShadow, TweenInfo.new(0.2), {ImageTransparency = 0.6}):Play()
    end)

    verifyBtn.MouseLeave:Connect(function()
        TweenService:Create(verifyBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {BackgroundColor3 = KeySystem.Config.MainColor}):Play()
        TweenService:Create(verifyShadow, TweenInfo.new(0.2), {ImageTransparency = 0.75}):Play()
    end)

    getKeyBtn.MouseEnter:Connect(function()
        TweenService:Create(getKeyBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 40, 50)}):Play()
        TweenService:Create(getKeyStroke, TweenInfo.new(0.2), {Color = KeySystem.Config.MainColor, Transparency = 0.4}):Play()
        TweenService:Create(getKeyBtn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
    end)

    getKeyBtn.MouseLeave:Connect(function()
        TweenService:Create(getKeyBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(20, 25, 32)}):Play()
        TweenService:Create(getKeyStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(50, 60, 70), Transparency = 0.6}):Play()
        TweenService:Create(getKeyBtn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(180, 190, 200)}):Play()
    end)

    getKeyBtn.MouseButton1Click:Connect(function()
        pcall(function()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Get Key",
                Text = "Opening key page...",
                Duration = 3,
            })
        end)
    end)

    local isVerifying = false

    local function shakeFrame(frame)
        local original = frame.Position
        local shakeTween = TweenService:Create(frame, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {Position = original + UDim2.new(0, 8, 0, 0)})
        shakeTween:Play()
        shakeTween.Completed:Wait()
        local t2 = TweenService:Create(frame, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {Position = original + UDim2.new(0, -8, 0, 0)})
        t2:Play()
        t2.Completed:Wait()
        local t3 = TweenService:Create(frame, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {Position = original + UDim2.new(0, 5, 0, 0)})
        t3:Play()
        t3.Completed:Wait()
        local t4 = TweenService:Create(frame, TweenInfo.new(0.05, Enum.EasingStyle.Linear), {Position = original + UDim2.new(0, -5, 0, 0)})
        t4:Play()
        t4.Completed:Wait()
        TweenService:Create(frame, TweenInfo.new(0.15, Enum.EasingStyle.Quart), {Position = original}):Play()
    end

    local function showSuccess()
        verifyBtn.Text = ""
        spinner.Visible = false
        checkmark.Visible = true
        checkmarkIcon.ImageTransparency = 0
        statusLabel.Text = "Key verified successfully!"
        statusLabel.TextColor3 = KeySystem.Config.SuccessColor

        TweenService:Create(checkmarkIcon, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Size = UDim2.new(1.3, 0, 1.3, 0)}):Play()
        task.delay(0.15, function()
            TweenService:Create(checkmarkIcon, TweenInfo.new(0.2, Enum.EasingStyle.Quart), {Size = UDim2.new(1, 0, 1, 0)}):Play()
        end)

        TweenService:Create(mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {BackgroundTransparency = 1}):Play()
        TweenService:Create(content, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
        for _, child in ipairs(content:GetDescendants()) do
            if child:IsA("GuiObject") and child ~= checkmark and child ~= checkmarkIcon then
                TweenService:Create(child, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
                if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
                    TweenService:Create(child, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
                end
                if child:IsA("ImageLabel") or child:IsA("ImageButton") then
                    TweenService:Create(child, TweenInfo.new(0.3), {ImageTransparency = 1}):Play()
                end
                if child:IsA("UIStroke") then
                    TweenService:Create(child, TweenInfo.new(0.3), {Transparency = 1}):Play()
                end
            end
        end
        TweenService:Create(topGlow, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
        TweenService:Create(ambientGlow, TweenInfo.new(0.3), {ImageTransparency = 1}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.3), {Transparency = 1}):Play()
        TweenService:Create(blur, TweenInfo.new(0.5), {Size = 0}):Play()

        task.delay(0.6, function()
            screenGui:Destroy()
            blur:Destroy()
        end)
    end

    local function showError(msg)
        isVerifying = false
        spinner.Visible = false
        verifyBtn.Text = "Verify Key"
        statusLabel.Text = msg
        statusLabel.TextColor3 = KeySystem.Config.ErrorColor
        shakeFrame(mainFrame)
        TweenService:Create(inputStroke, TweenInfo.new(0.2), {Color = KeySystem.Config.ErrorColor}):Play()
        task.delay(1.5, function()
            if not isVerifying then
                TweenService:Create(inputStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(40, 50, 60)}):Play()
            end
        end)
    end

    verifyBtn.MouseButton1Click:Connect(function()
        if isVerifying then return end
        local key = textBox.Text:gsub("%s+", ""):gsub("^%s*", ""):gsub("%s*$", "")
        if key == "" then
            showError("Please enter a key.")
            return
        end
        isVerifying = true
        verifyBtn.Text = ""
        spinner.Visible = true
        statusLabel.Text = "Verifying key..."
        statusLabel.TextColor3 = Color3.fromRGB(150, 160, 170)

        local spinConnection
                local angle = 0
        spinConnection = RunService.RenderStepped:Connect(function(dt)
            angle = angle + dt * 400
            spinnerCircle.Rotation = angle
        end)

        task.delay(1.5, function()
            spinConnection:Disconnect()
            if key == KeySystem.Config.Key then
                showSuccess()
            else
                showError("Invalid key. Please try again.")
            end
        end)
    end)

    mainFrame.BackgroundTransparency = 1
    mainFrame.Size = UDim2.new(0, KeySystem.Config.Size.X.Offset - 40, 0, KeySystem.Config.Size.Y.Offset - 40)

    for _, child in ipairs(content:GetDescendants()) do
        if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
            child.TextTransparency = 1
        end
        if child:IsA("ImageLabel") or child:IsA("ImageButton") then
            if child ~= ambientGlow and child ~= verifyShadow then
                child.ImageTransparency = 1
            end
        end
    end
    title.TextTransparency = 1
    subtitle.TextTransparency = 1
    statusLabel.TextTransparency = 1
    verifyBtn.TextTransparency = 1
    getKeyBtn.TextTransparency = 1
    textBox.TextTransparency = 1

    local openTween = TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.15,
        Size = KeySystem.Config.Size,
    })
    openTween:Play()

    task.delay(0.1, function()
        TweenService:Create(ambientGlow, TweenInfo.new(0.6), {ImageTransparency = 0.92}):Play()
        TweenService:Create(stroke, TweenInfo.new(0.6), {Transparency = 0.7}):Play()
    end)

    local elements = {title, subtitle, verifyBtn, getKeyBtn, textBox, statusLabel, logoContainer, logoIcon, keyIcon}
    for i, el in ipairs(elements) do
        task.delay(0.1 + (i * 0.05), function()
            if el:IsA("TextLabel") or el:IsA("TextButton") or el:IsA("TextBox") then
                TweenService:Create(el, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {TextTransparency = 0}):Play()
            end
            if el:IsA("ImageLabel") or el:IsA("ImageButton") then
                TweenService:Create(el, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {ImageTransparency = 0}):Play()
            end
            if el == logoContainer then
                TweenService:Create(el, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {BackgroundTransparency = 0.85}):Play()
            end
        end)
    end

    task.delay(0.4, function()
        TweenService:Create(inputContainer, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {BackgroundTransparency = 0.3}):Play()
        TweenService:Create(inputStroke, TweenInfo.new(0.4), {Transparency = 0.5}):Play()
    end)

    return KeySystem
end

KeySystem:Create()
