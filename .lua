local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("PremiumKeySystem") then
    playerGui.PremiumKeySystem:Destroy()
end

local C = {
    bgMain = Color3.fromRGB(20, 26, 20),
    bgPanel = Color3.fromRGB(30, 38, 30),
    bgInner = Color3.fromRGB(38, 48, 38),
    lightGreen = Color3.fromRGB(130, 235, 155),
    midGreen = Color3.fromRGB(65, 185, 105),
    darkGreen = Color3.fromRGB(40, 125, 70),
    white = Color3.fromRGB(242, 255, 246),
    muted = Color3.fromRGB(148, 162, 148),
    stroke = Color3.fromRGB(82, 182, 112),
    strokeLight = Color3.fromRGB(118, 218, 148),
    glow = Color3.fromRGB(95, 255, 135),
    shadow = Color3.fromRGB(0, 0, 0)
}

local function new(class, props)
    local inst = Instance.new(class)
    for k, v in pairs(props) do
        inst[k] = v
    end
    return inst
end

local function corner(parent, radius)
    return new("UICorner", {CornerRadius = UDim.new(0, radius), Parent = parent})
end

local function stroke(parent, color, thickness, transparency)
    return new("UIStroke", {Color = color or C.stroke, Thickness = thickness or 1.5, Transparency = transparency or 0.3, Parent = parent})
end

local function gradient(parent, colors, rotation)
    return new("UIGradient", {Color = colors, Rotation = rotation or 0, Parent = parent})
end

local screenGui = new("ScreenGui", {
    Name = "PremiumKeySystem",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    Parent = playerGui
})

local shadow = new("Frame", {
    Name = "Shadow",
    Size = UDim2.new(0, 740, 0, 420),
    Position = UDim2.new(0.5, -370, 0.5, -210),
    BackgroundColor3 = C.shadow,
    BackgroundTransparency = 0.82,
    BorderSizePixel = 0,
    Parent = screenGui
})
corner(shadow, 28)

local mainFrame = new("Frame", {
    Name = "MainFrame",
    Size = UDim2.new(0, 700, 0, 380),
    Position = UDim2.new(0.5, -350, 0.5, -190),
    BackgroundColor3 = C.bgMain,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    Parent = screenGui
})
corner(mainFrame, 24)
stroke(mainFrame, C.stroke, 2, 0.2)

local mainGrad = gradient(mainFrame, ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(26, 34, 26)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(22, 30, 22)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 26, 18))
}), 45)

local content = new("Frame", {
    Name = "Content",
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Parent = mainFrame
})

local leftPanel = new("Frame", {
    Name = "LeftPanel",
    Size = UDim2.new(0, 170, 1, -40),
    Position = UDim2.new(0, 20, 0, 20),
    BackgroundColor3 = C.bgPanel,
    BorderSizePixel = 0,
    Parent = content
})
corner(leftPanel, 18)
stroke(leftPanel, C.stroke, 1.5, 0.35)

local leftGrad = gradient(leftPanel, ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(42, 54, 42)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(36, 46, 36)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 40, 30))
}), 90)

local userIconBg = new("Frame", {
    Size = UDim2.new(0, 64, 0, 64),
    Position = UDim2.new(0.5, -32, 0, 30),
    BackgroundColor3 = C.midGreen,
    BorderSizePixel = 0,
    Parent = leftPanel
})
corner(userIconBg, 32)

local userIconInner = new("Frame", {
    Size = UDim2.new(1, -8, 1, -8),
    Position = UDim2.new(0, 4, 0, 4),
    BackgroundColor3 = C.bgPanel,
    BorderSizePixel = 0,
    Parent = userIconBg
})
corner(userIconInner, 28)

local userHead = new("Frame", {
    Size = UDim2.new(0, 24, 0, 24),
    Position = UDim2.new(0.5, -12, 0.5, -16),
    BackgroundColor3 = C.lightGreen,
    BorderSizePixel = 0,
    Parent = userIconInner
})
corner(userHead, 12)

local userBody = new("Frame", {
    Size = UDim2.new(0, 36, 0, 16),
    Position = UDim2.new(0.5, -18, 0.5, 8),
    BackgroundColor3 = C.lightGreen,
    BorderSizePixel = 0,
    Parent = userIconInner
})
corner(userBody, 8)

new("TextLabel", {
    Size = UDim2.new(1, -20, 0, 20),
    Position = UDim2.new(0, 10, 0, 110),
    BackgroundTransparency = 1,
    Text = "Welcome Back,",
    TextColor3 = C.muted,
    TextSize = 13,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Center,
    Parent = leftPanel
})

new("TextLabel", {
    Size = UDim2.new(1, -20, 0, 28),
    Position = UDim2.new(0, 10, 0, 132),
    BackgroundTransparency = 1,
    Text = player.Name,
    TextColor3 = C.white,
    TextSize = 18,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Center,
    TextTruncate = Enum.TextTruncate.AtEnd,
    Parent = leftPanel
})

local decoLine1 = new("Frame", {
    Size = UDim2.new(0, 60, 0, 2),
    Position = UDim2.new(0.5, -30, 0, 175),
    BackgroundColor3 = C.stroke,
    BackgroundTransparency = 0.5,
    BorderSizePixel = 0,
    Parent = leftPanel
})
corner(decoLine1, 1)

local statusFrame = new("Frame", {
    Size = UDim2.new(0, 120, 0, 32),
    Position = UDim2.new(0.5, -60, 0, 195),
    BackgroundColor3 = C.bgInner,
    BorderSizePixel = 0,
    Parent = leftPanel
})
corner(statusFrame, 8)
stroke(statusFrame, C.darkGreen, 1, 0.5)

local statusDot = new("Frame", {
    Size = UDim2.new(0, 8, 0, 8),
    Position = UDim2.new(0, 12, 0.5, -4),
    BackgroundColor3 = C.lightGreen,
    BorderSizePixel = 0,
    Parent = statusFrame
})
corner(statusDot, 4)

new("TextLabel", {
    Size = UDim2.new(1, -30, 1, 0),
    Position = UDim2.new(0, 26, 0, 0),
    BackgroundTransparency = 1,
    Text = "Online",
    TextColor3 = C.lightGreen,
    TextSize = 12,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = statusFrame
})

local centerPanel = new("Frame", {
    Name = "CenterPanel",
    Size = UDim2.new(1, -400, 1, -40),
    Position = UDim2.new(0, 200, 0, 20),
    BackgroundColor3 = C.bgPanel,
    BorderSizePixel = 0,
    Parent = content
})
corner(centerPanel, 18)
stroke(centerPanel, C.stroke, 1.5, 0.35)

local centerGrad = gradient(centerPanel, ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(46, 58, 46)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(38, 48, 38)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(34, 44, 34))
}), 0)

local lockIconBg = new("Frame", {
    Size = UDim2.new(0, 56, 0, 56),
    Position = UDim2.new(0.5, -28, 0, 28),
    BackgroundColor3 = C.midGreen,
    BackgroundTransparency = 0.85,
    BorderSizePixel = 0,
    Parent = centerPanel
})
corner(lockIconBg, 16)

local lockBody = new("Frame", {
    Size = UDim2.new(0, 24, 0, 18),
    Position = UDim2.new(0.5, -12, 0.5, -2),
    BackgroundColor3 = C.lightGreen,
    BorderSizePixel = 0,
    Parent = lockIconBg
})
corner(lockBody, 4)

local lockShackle = new("Frame", {
    Size = UDim2.new(0, 16, 0, 10),
    Position = UDim2.new(0.5, -8, 0.5, -14),
    BackgroundColor3 = C.lightGreen,
    BorderSizePixel = 0,
    Parent = lockIconBg
})
corner(lockShackle, 8)

local lockHole = new("Frame", {
    Size = UDim2.new(0, 8, 0, 8),
    Position = UDim2.new(0.5, -4, 0.5, -8),
    BackgroundColor3 = C.midGreen,
    BorderSizePixel = 0,
    Parent = lockIconBg
})
corner(lockHole, 4)

new("TextLabel", {
    Size = UDim2.new(1, -40, 0, 28),
    Position = UDim2.new(0, 20, 0, 95),
    BackgroundTransparency = 1,
    Text = "Key System",
    TextColor3 = C.white,
    TextSize = 22,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Center,
    Parent = centerPanel
})

new("TextLabel", {
    Size = UDim2.new(1, -40, 0, 18),
    Position = UDim2.new(0, 20, 0, 123),
    BackgroundTransparency = 1,
    Text = "Enter your access key below",
    TextColor3 = C.muted,
    TextSize = 12,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Center,
    Parent = centerPanel
})

local inputContainer = new("Frame", {
    Size = UDim2.new(1, -40, 0, 44),
    Position = UDim2.new(0, 20, 0, 160),
    BackgroundColor3 = C.bgInner,
    BorderSizePixel = 0,
    Parent = centerPanel
})
corner(inputContainer, 12)
stroke(inputContainer, C.stroke, 1, 0.4)

local keyIcon = new("Frame", {
    Size = UDim2.new(0, 20, 0, 20),
    Position = UDim2.new(0, 12, 0.5, -10),
    BackgroundColor3 = C.lightGreen,
    BorderSizePixel = 0,
    Parent = inputContainer
})
corner(keyIcon, 4)

new("Frame", {
    Size = UDim2.new(0, 10, 0, 3),
    Position = UDim2.new(0.5, -5, 0.5, -1),
    BackgroundColor3 = C.bgInner,
    BorderSizePixel = 0,
    Parent = keyIcon
})

local keyInput = new("TextBox", {
    Size = UDim2.new(1, -48, 1, 0),
    Position = UDim2.new(0, 40, 0, 0),
    BackgroundTransparency = 1,
    Text = "",
    PlaceholderText = "Enter key here...",
    TextColor3 = C.white,
    PlaceholderColor3 = C.muted,
    TextSize = 14,
    Font = Enum.Font.Gotham,
    ClearTextOnFocus = false,
    Parent = inputContainer
})

local buttonContainer = new("Frame", {
    Size = UDim2.new(1, -40, 0, 46),
    Position = UDim2.new(0, 20, 0, 220),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Parent = centerPanel
})

local buttonGlow = new("Frame", {
    Name = "Glow",
    Size = UDim2.new(1, 16, 1, 16),
    Position = UDim2.new(0, -8, 0, -8),
    BackgroundColor3 = C.glow,
    BackgroundTransparency = 0.9,
    BorderSizePixel = 0,
    ZIndex = 1,
    Parent = buttonContainer
})
corner(buttonGlow, 20)

local glowGrad = gradient(buttonGlow, ColorSequence.new({
    ColorSequenceKeypoint.new(0, C.glow),
    ColorSequenceKeypoint.new(1, C.midGreen)
}), 0)
glowGrad.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.85),
    NumberSequenceKeypoint.new(1, 1)
})

local enterButton = new("TextButton", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundColor3 = C.midGreen,
    BorderSizePixel = 0,
    Text = "Enter Key",
    TextColor3 = C.white,
    TextSize = 15,
    Font = Enum.Font.GothamBold,
    ZIndex = 2,
    Parent = buttonContainer
})
corner(enterButton, 14)

local btnGrad = gradient(enterButton, ColorSequence.new({
    ColorSequenceKeypoint.new(0, C.lightGreen),
    ColorSequenceKeypoint.new(0.5, C.midGreen),
    ColorSequenceKeypoint.new(1, C.darkGreen)
}), 90)

local btnStroke = stroke(enterButton, C.strokeLight, 1.5, 0.2)

local rightPanel = new("Frame", {
    Name = "RightPanel",
    Size = UDim2.new(0, 170, 1, -40),
    Position = UDim2.new(1, -190, 0, 20),
    BackgroundColor3 = C.bgPanel,
    BorderSizePixel = 0,
    Parent = content
})
corner(rightPanel, 18)
stroke(rightPanel, C.stroke, 1.5, 0.35)

local rightGrad = gradient(rightPanel, ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(42, 54, 42)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(36, 46, 36)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 40, 30))
}), 90)

local priceIconBg = new("Frame", {
    Size = UDim2.new(0, 64, 0, 64),
    Position = UDim2.new(0.5, -32, 0, 30),
    BackgroundColor3 = C.midGreen,
    BackgroundTransparency = 0.85,
    BorderSizePixel = 0,
    Parent = rightPanel
})
corner(priceIconBg, 32)

local starCenter = new("Frame", {
    Size = UDim2.new(0, 20, 0, 20),
    Position = UDim2.new(0.5, -10, 0.5, -10),
    BackgroundColor3 = C.lightGreen,
    BorderSizePixel = 0,
    Parent = priceIconBg
})
corner(starCenter, 4)

for _, pos in ipairs({
    {0.5, -4, 0, 2, 8, 10},
    {0.5, -4, 1, -12, 8, 10},
    {0, 2, 0.5, -4, 10, 8},
    {1, -12, 0.5, -4, 10, 8}
}) do
    local f = new("Frame", {
        Size = UDim2.new(0, pos[5], 0, pos[6]),
        Position = UDim2.new(pos[1], pos[2], pos[3], pos[4]),
        BackgroundColor3 = C.lightGreen,
        BorderSizePixel = 0,
        Parent = priceIconBg
    })
    corner(f, 4)
end

new("TextLabel", {
    Size = UDim2.new(1, -20, 0, 36),
    Position = UDim2.new(0, 10, 0, 108),
    BackgroundTransparency = 1,
    Text = "$4.99",
    TextColor3 = C.lightGreen,
    TextSize = 28,
    Font = Enum.Font.GothamBlack,
    TextXAlignment = Enum.TextXAlignment.Center,
    Parent = rightPanel
})

new("TextLabel", {
    Size = UDim2.new(1, -20, 0, 18),
    Position = UDim2.new(0, 10, 0, 144),
    BackgroundTransparency = 1,
    Text = "Lifetime Access",
    TextColor3 = C.muted,
    TextSize = 12,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Center,
    Parent = rightPanel
})

local decoLine2 = new("Frame", {
    Size = UDim2.new(0, 60, 0, 2),
    Position = UDim2.new(0.5, -30, 0, 175),
    BackgroundColor3 = C.stroke,
    BackgroundTransparency = 0.5,
    BorderSizePixel = 0,
    Parent = rightPanel
})
corner(decoLine2, 1)

local featureContainer = new("Frame", {
    Size = UDim2.new(1, -20, 0, 90),
    Position = UDim2.new(0, 10, 0, 190),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Parent = rightPanel
})

local features = {"Premium Scripts", "Auto Updates", "24/7 Support"}
for i, feat in ipairs(features) do
    local featFrame = new("Frame", {
        Size = UDim2.new(1, 0, 0, 24),
        Position = UDim2.new(0, 0, 0, (i-1) * 28),
        BackgroundTransparency = 1,
        Parent = featureContainer
    })

    local checkBg = new("Frame", {
        Size = UDim2.new(0, 16, 0, 16),
        Position = UDim2.new(0, 8, 0.5, -8),
        BackgroundColor3 = C.midGreen,
        BackgroundTransparency = 0.7,
        BorderSizePixel = 0,
        Parent = featFrame
    })
    corner(checkBg, 4)

    new("Frame", {
        Size = UDim2.new(0, 8, 0, 8),
        Position = UDim2.new(0.5, -4, 0.5, -4),
        BackgroundColor3 = C.lightGreen,
        BorderSizePixel = 0,
        Parent = checkBg
    })

    new("TextLabel", {
        Size = UDim2.new(1, -36, 1, 0),
        Position = UDim2.new(0, 30, 0, 0),
        BackgroundTransparency = 1,
        Text = feat,
        TextColor3 = C.muted,
        TextSize = 12,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = featFrame
    })
end

local shine = new("Frame", {
    Name = "Shine",
    Size = UDim2.new(0, 100, 1, 0),
    Position = UDim2.new(0, -150, 0, 0),
    BackgroundColor3 = C.white,
    BackgroundTransparency = 0.92,
    BorderSizePixel = 0,
    Rotation = 15,
    ZIndex = 10,
    Parent = mainFrame
})

local shineGrad = gradient(shine, ColorSequence.new({
    ColorSequenceKeypoint.new(0, C.white),
    ColorSequenceKeypoint.new(0.5, C.lightGreen),
    ColorSequenceKeypoint.new(1, C.white)
}), 0)
shineGrad.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 1),
    NumberSequenceKeypoint.new(0.3, 0.88),
    NumberSequenceKeypoint.new(0.7, 0.88),
    NumberSequenceKeypoint.new(1, 1)
})

local function setInvisible(obj)
    if obj:IsA("GuiObject") then
        if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
            obj.TextTransparency = 1
        end
        if obj:IsA("Frame") or obj:IsA("TextButton") then
            obj:SetAttribute("OrigTrans", obj.BackgroundTransparency)
            obj.BackgroundTransparency = 1
        end
    end
    if obj:IsA("UIStroke") then
        obj:SetAttribute("OrigTrans", obj.Transparency)
        obj.Transparency = 1
    end
    for _, child in ipairs(obj:GetDescendants()) do
        setInvisible(child)
    end
end

setInvisible(mainFrame)
mainFrame.BackgroundTransparency = 1
shadow.BackgroundTransparency = 1

local introTween = TweenService:Create(mainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 700, 0, 380),
    BackgroundTransparency = 0
})

local shadowTween = TweenService:Create(shadow, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    BackgroundTransparency = 0.82
})

introTween:Play()
shadowTween:Play()

introTween.Completed:Connect(function()
    for _, obj in ipairs(content:GetDescendants()) do
        if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
            TweenService:Create(obj, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                TextTransparency = 0
            }):Play()
        end
        if obj:IsA("Frame") and obj:GetAttribute("OrigTrans") ~= nil then
            TweenService:Create(obj, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = obj:GetAttribute("OrigTrans")
            }):Play()
        end
        if obj:IsA("UIStroke") and obj:GetAttribute("OrigTrans") ~= nil then
            TweenService:Create(obj, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = obj:GetAttribute("OrigTrans")
            }):Play()
        end
    end
end)

local function rotateGradient(grad, speed)
    local rot = grad.Rotation
    return RunService.Heartbeat:Connect(function(dt)
        rot = rot + dt * speed
        grad.Rotation = rot % 360
    end)
end

rotateGradient(mainGrad, 8)
rotateGradient(leftGrad, 12)
rotateGradient(centerGrad, -10)
rotateGradient(rightGrad, 12)
rotateGradient(btnGrad, 15)
rotateGradient(glowGrad, 20)

local floatTime = 0
RunService.Heartbeat:Connect(function(dt)
    floatTime = floatTime + dt
    leftPanel.Position = UDim2.new(0, 20, 0, 20 + math.sin(floatTime * 1.5) * 2)
    rightPanel.Position = UDim2.new(1, -190, 0, 20 + math.sin(floatTime * 1.5 + 1.2) * 2)
    centerPanel.Position = UDim2.new(0, 200, 0, 20 + math.sin(floatTime * 1.2 + 0.6) * 1.5)
end)

local btnHoverIn = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local btnHoverOut = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local btnClickInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

enterButton.MouseEnter:Connect(function()
    TweenService:Create(enterButton, btnHoverIn, {
        BackgroundColor3 = C.lightGreen,
        Size = UDim2.new(1, 4, 1, 4),
        Position = UDim2.new(0, -2, 0, -2)
    }):Play()
    TweenService:Create(buttonGlow, btnHoverIn, {
        BackgroundTransparency = 0.75,
        Size = UDim2.new(1, 24, 1, 24),
        Position = UDim2.new(0, -12, 0, -12)
    }):Play()
    TweenService:Create(btnStroke, btnHoverIn, {
        Transparency = 0,
        Thickness = 2
    }):Play()
end)

enterButton.MouseLeave:Connect(function()
    TweenService:Create(enterButton, btnHoverOut, {
        BackgroundColor3 = C.midGreen,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0)
    }):Play()
    TweenService:Create(buttonGlow, btnHoverOut, {
        BackgroundTransparency = 0.9,
        Size = UDim2.new(1, 16, 1, 16),
        Position = UDim2.new(0, -8, 0, -8)
    }):Play()
    TweenService:Create(btnStroke, btnHoverOut, {
        Transparency = 0.2,
        Thickness = 1.5
    }):Play()
end)

enterButton.MouseButton1Down:Connect(function()
    TweenService:Create(enterButton, btnClickInfo, {
        Size = UDim2.new(1, -4, 1, -4),
        Position = UDim2.new(0, 2, 0, 2)
    }):Play()
end)

enterButton.MouseButton1Up:Connect(function()
    TweenService:Create(enterButton, btnClickInfo, {
        Size = UDim2.new(1, 4, 1, 4),
        Position = UDim2.new(0, -2, 0, -2)
    }):Play()
end)

enterButton.MouseButton1Click:Connect(function()
    local key = keyInput.Text
    if key and #key > 0 then
        TweenService:Create(enterButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(80, 200, 120)
        }):Play()
        enterButton.Text = "Verifying..."
        task.wait(0.5)
        enterButton.Text = "Key Entered: " .. key:sub(1, 3) .. "***"
        task.wait(1)
        enterButton.Text = "Enter Key"
        TweenService:Create(enterButton, TweenInfo.new(0.2), {
            BackgroundColor3 = C.midGreen
        }):Play()
    else
        local origPos = inputContainer.Position
        for i = 1, 6 do
            inputContainer.Position = origPos + UDim2.new(0, (i % 2 == 0 and 5 or -5), 0, 0)
            task.wait(0.03)
        end
        inputContainer.Position = origPos
    end
end)

keyInput.Focused:Connect(function()
    TweenService:Create(inputContainer, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(50, 62, 50)
    }):Play()
    for _, child in ipairs(inputContainer:GetChildren()) do
        if child:IsA("UIStroke") then
            TweenService:Create(child, TweenInfo.new(0.2), {
                Transparency = 0.1,
                Color = C.lightGreen
            }):Play()
        end
    end
end)

keyInput.FocusLost:Connect(function()
    TweenService:Create(inputContainer, TweenInfo.new(0.2), {
        BackgroundColor3 = C.bgInner
    }):Play()
    for _, child in ipairs(inputContainer:GetChildren()) do
        if child:IsA("UIStroke") then
            TweenService:Create(child, TweenInfo.new(0.2), {
                Transparency = 0.4,
                Color = C.stroke
            }):Play()
        end
    end
end)

local pulseTime = 0
RunService.Heartbeat:Connect(function(dt)
    pulseTime = pulseTime + dt
    local s = 1 + math.sin(pulseTime * 4) * 0.3
    statusDot.Size = UDim2.new(0, 8 * s, 0, 8 * s)
    statusDot.Position = UDim2.new(0, 12 - 4 * (s - 1), 0.5, -4 * s)
end)

local shinePos = -150
RunService.Heartbeat:Connect(function(dt)
    shinePos = shinePos + dt * 120
    if shinePos > 850 then
        shinePos = -150
    end
    shine.Position = UDim2.new(0, shinePos, 0, 0)
end)
