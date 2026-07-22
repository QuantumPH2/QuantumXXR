local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("PremiumKeySystem") then
    playerGui.PremiumKeySystem:Destroy()
end

local C = {
    bgDark = Color3.fromRGB(10, 18, 12),
    panelGreen = Color3.fromRGB(28, 55, 32),
    panelGreenLight = Color3.fromRGB(38, 72, 42),
    neonGreen = Color3.fromRGB(0, 255, 128),
    neonBright = Color3.fromRGB(100, 255, 180),
    neonGlow = Color3.fromRGB(0, 255, 100),
    white = Color3.fromRGB(245, 255, 248),
    muted = Color3.fromRGB(140, 180, 150),
    strokeNeon = Color3.fromRGB(0, 230, 110),
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
    return new("UIStroke", {Color = color or C.strokeNeon, Thickness = thickness or 1.5, Transparency = transparency or 0.25, Parent = parent})
end

local function gradient(parent, colors, rotation)
    return new("UIGradient", {Color = colors, Rotation = rotation or 0, Parent = parent})
end

local function censorName(name)
    if #name <= 3 then
        return name:sub(1, 1) .. string.rep("*", #name - 1)
    end
    local first = name:sub(1, 1)
    local last = name:sub(-1, -1)
    local midLen = math.max(1, #name - 4)
    return first .. string.rep("*", 2) .. string.rep("·", midLen) .. string.rep("*", 2) .. last
end

local screenGui = new("ScreenGui", {
    Name = "PremiumKeySystem",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    Parent = playerGui
})

local shadowMain = new("Frame", {
    Size = UDim2.new(0, 640, 0, 300),
    Position = UDim2.new(0.5, -320, 0.5, -150),
    BackgroundColor3 = C.shadow,
    BackgroundTransparency = 0.85,
    BorderSizePixel = 0,
    Parent = screenGui
})
corner(shadowMain, 24)

local function createPanel(name, xPos, width)
    local container = new("Frame", {
        Name = name .. "Container",
        Size = UDim2.new(0, width, 0, 260),
        Position = UDim2.new(0.5, xPos, 0.5, -130),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Parent = screenGui
    })

    local shadow = new("Frame", {
        Name = "Shadow",
        Size = UDim2.new(1, 16, 1, 16),
        Position = UDim2.new(0, -8, 0, -8),
        BackgroundColor3 = C.shadow,
        BackgroundTransparency = 0.8,
        BorderSizePixel = 0,
        Parent = container
    })
    corner(shadow, 20)

    local panel = new("Frame", {
        Name = name,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = C.panelGreen,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = container
    })
    corner(panel, 18)
    stroke(panel, C.strokeNeon, 2, 0.3)

    local panelGrad = gradient(panel, ColorSequence.new({
        ColorSequenceKeypoint.new(0, C.panelGreenLight),
        ColorSequenceKeypoint.new(0.5, C.panelGreen),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 48, 28))
    }), 45)

    return container, panel, panelGrad, shadow
end

local leftCont, leftPanel, leftGrad, leftShadow = createPanel("LeftPanel", -320, 190)
local centerCont, centerPanel, centerGrad, centerShadow = createPanel("CenterPanel", -110, 240)
local rightCont, rightPanel, rightGrad, rightShadow = createPanel("RightPanel", 150, 190)

local function iconUser(parent)
    local bg = new("Frame", {
        Size = UDim2.new(0, 56, 0, 56),
        Position = UDim2.new(0.5, -28, 0, 24),
        BackgroundColor3 = C.neonGreen,
        BackgroundTransparency = 0.15,
        BorderSizePixel = 0,
        Parent = parent
    })
    corner(bg, 28)
    stroke(bg, C.neonBright, 2, 0.2)

    local inner = new("Frame", {
        Size = UDim2.new(0, 44, 0, 44),
        Position = UDim2.new(0.5, -22, 0.5, -22),
        BackgroundColor3 = C.panelGreen,
        BorderSizePixel = 0,
        Parent = bg
    })
    corner(inner, 22)

    local head = new("Frame", {
        Size = UDim2.new(0, 18, 0, 18),
        Position = UDim2.new(0.5, -9, 0.5, -16),
        BackgroundColor3 = C.neonGreen,
        BorderSizePixel = 0,
        Parent = inner
    })
    corner(head, 9)

    local body = new("Frame", {
        Size = UDim2.new(0, 30, 0, 14),
        Position = UDim2.new(0.5, -15, 0.5, 2),
        BackgroundColor3 = C.neonGreen,
        BorderSizePixel = 0,
        Parent = inner
    })
    corner(body, 7)
end

iconUser(leftPanel)

new("TextLabel", {
    Size = UDim2.new(1, -20, 0, 18),
    Position = UDim2.new(0, 10, 0, 90),
    BackgroundTransparency = 1,
    Text = "Welcome Back,",
    TextColor3 = C.muted,
    TextSize = 12,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Center,
    Parent = leftPanel
})

new("TextLabel", {
    Size = UDim2.new(1, -20, 0, 26),
    Position = UDim2.new(0, 10, 0, 110),
    BackgroundTransparency = 1,
    Text = censorName(player.Name),
    TextColor3 = C.white,
    TextSize = 17,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Center,
    TextTruncate = Enum.TextTruncate.AtEnd,
    Parent = leftPanel
})

local line1 = new("Frame", {
    Size = UDim2.new(0, 50, 0, 2),
    Position = UDim2.new(0.5, -25, 0, 148),
    BackgroundColor3 = C.neonGreen,
    BackgroundTransparency = 0.4,
    BorderSizePixel = 0,
    Parent = leftPanel
})
corner(line1, 1)

local statusBg = new("Frame", {
    Size = UDim2.new(0, 110, 0, 30),
    Position = UDim2.new(0.5, -55, 0, 164),
    BackgroundColor3 = Color3.fromRGB(20, 45, 25),
    BorderSizePixel = 0,
    Parent = leftPanel
})
corner(statusBg, 8)
stroke(statusBg, C.neonGreen, 1, 0.4)

local dot = new("Frame", {
    Size = UDim2.new(0, 8, 0, 8),
    Position = UDim2.new(0, 12, 0.5, -4),
    BackgroundColor3 = C.neonGreen,
    BorderSizePixel = 0,
    Parent = statusBg
})
corner(dot, 4)

new("TextLabel", {
    Size = UDim2.new(1, -30, 1, 0),
    Position = UDim2.new(0, 26, 0, 0),
    BackgroundTransparency = 1,
    Text = "Online",
    TextColor3 = C.neonGreen,
    TextSize = 12,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = statusBg
})

local toggleBg = new("Frame", {
    Size = UDim2.new(0, 52, 0, 28),
    Position = UDim2.new(0.5, -26, 0, 210),
    BackgroundColor3 = Color3.fromRGB(20, 45, 25),
    BorderSizePixel = 0,
    Parent = leftPanel
})
corner(toggleBg, 14)
stroke(toggleBg, C.neonGreen, 1.5, 0.3)

local toggleKnob = new("Frame", {
    Size = UDim2.new(0, 22, 0, 22),
    Position = UDim2.new(0, 3, 0.5, -11),
    BackgroundColor3 = C.neonGreen,
    BorderSizePixel = 0,
    Parent = toggleBg
})
corner(toggleKnob, 11)

local toggleGlow = new("Frame", {
    Size = UDim2.new(0, 30, 0, 30),
    Position = UDim2.new(0.5, -15, 0.5, -15),
    BackgroundColor3 = C.neonGlow,
    BackgroundTransparency = 0.85,
    BorderSizePixel = 0,
    Parent = toggleKnob
})
corner(toggleGlow, 15)

new("TextLabel", {
    Size = UDim2.new(1, -20, 0, 16),
    Position = UDim2.new(0, 10, 0, 246),
    BackgroundTransparency = 1,
    Text = "Auto-Login",
    TextColor3 = C.muted,
    TextSize = 11,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Center,
    Parent = leftPanel
})

local function iconLock(parent)
    local bg = new("Frame", {
        Size = UDim2.new(0, 50, 0, 50),
        Position = UDim2.new(0.5, -25, 0, 22),
        BackgroundColor3 = C.neonGreen,
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        Parent = parent
    })
    corner(bg, 14)

    local body = new("Frame", {
        Size = UDim2.new(0, 22, 0, 16),
        Position = UDim2.new(0.5, -11, 0.5, -2),
        BackgroundColor3 = C.neonGreen,
        BorderSizePixel = 0,
        Parent = bg
    })
    corner(body, 4)

    local shackle = new("Frame", {
        Size = UDim2.new(0, 14, 0, 8),
        Position = UDim2.new(0.5, -7, 0.5, -13),
        BackgroundColor3 = C.neonGreen,
        BorderSizePixel = 0,
        Parent = bg
    })
    corner(shackle, 7)

    local hole = new("Frame", {
        Size = UDim2.new(0, 6, 0, 6),
        Position = UDim2.new(0.5, -3, 0.5, -7),
        BackgroundColor3 = C.panelGreen,
        BorderSizePixel = 0,
        Parent = bg
    })
    corner(hole, 3)
end

iconLock(centerPanel)

new("TextLabel", {
    Size = UDim2.new(1, -30, 0, 26),
    Position = UDim2.new(0, 15, 0, 82),
    BackgroundTransparency = 1,
    Text = "Key System",
    TextColor3 = C.white,
    TextSize = 20,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Center,
    Parent = centerPanel
})

new("TextLabel", {
    Size = UDim2.new(1, -30, 0, 16),
    Position = UDim2.new(0, 15, 0, 108),
    BackgroundTransparency = 1,
    Text = "Enter your access key",
    TextColor3 = C.muted,
    TextSize = 11,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Center,
    Parent = centerPanel
})

local inputBg = new("Frame", {
    Size = UDim2.new(1, -30, 0, 42),
    Position = UDim2.new(0, 15, 0, 138),
    BackgroundColor3 = Color3.fromRGB(20, 45, 25),
    BorderSizePixel = 0,
    Parent = centerPanel
})
corner(inputBg, 12)
stroke(inputBg, C.neonGreen, 1.5, 0.35)

local keyIcon = new("Frame", {
    Size = UDim2.new(0, 18, 0, 18),
    Position = UDim2.new(0, 12, 0.5, -9),
    BackgroundColor3 = C.neonGreen,
    BorderSizePixel = 0,
    Parent = inputBg
})
corner(keyIcon, 4)

new("Frame", {
    Size = UDim2.new(0, 8, 0, 3),
    Position = UDim2.new(0.5, -4, 0.5, -1),
    BackgroundColor3 = Color3.fromRGB(20, 45, 25),
    BorderSizePixel = 0,
    Parent = keyIcon
})

local keyInput = new("TextBox", {
    Size = UDim2.new(1, -44, 1, 0),
    Position = UDim2.new(0, 36, 0, 0),
    BackgroundTransparency = 1,
    Text = "",
    PlaceholderText = "Enter key here...",
    TextColor3 = C.white,
    PlaceholderColor3 = C.muted,
    TextSize = 13,
    Font = Enum.Font.Gotham,
    ClearTextOnFocus = false,
    Parent = inputBg
})

local btnContainer = new("Frame", {
    Size = UDim2.new(1, -30, 0, 44),
    Position = UDim2.new(0, 15, 0, 194),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Parent = centerPanel
})

local btnGlow = new("Frame", {
    Size = UDim2.new(1, 20, 1, 20),
    Position = UDim2.new(0, -10, 0, -10),
    BackgroundColor3 = C.neonGlow,
    BackgroundTransparency = 0.88,
    BorderSizePixel = 0,
    ZIndex = 1,
    Parent = btnContainer
})
corner(btnGlow, 18)

local glowGrad = gradient(btnGlow, ColorSequence.new({
    ColorSequenceKeypoint.new(0, C.neonGlow),
    ColorSequenceKeypoint.new(1, C.neonGreen)
}), 0)
glowGrad.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.88),
    NumberSequenceKeypoint.new(1, 1)
})

local enterBtn = new("TextButton", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundColor3 = C.neonGreen,
    BorderSizePixel = 0,
    Text = "Enter Key",
    TextColor3 = Color3.fromRGB(10, 30, 15),
    TextSize = 14,
    Font = Enum.Font.GothamBold,
    ZIndex = 2,
    Parent = btnContainer
})
corner(enterBtn, 14)

local btnGrad = gradient(enterBtn, ColorSequence.new({
    ColorSequenceKeypoint.new(0, C.neonBright),
    ColorSequenceKeypoint.new(0.5, C.neonGreen),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 200, 90))
}), 90)

stroke(enterBtn, C.neonBright, 1.5, 0.15)

local function iconStar(parent)
    local bg = new("Frame", {
        Size = UDim2.new(0, 56, 0, 56),
        Position = UDim2.new(0.5, -28, 0, 24),
        BackgroundColor3 = C.neonGreen,
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        Parent = parent
    })
    corner(bg, 28)

    local center = new("Frame", {
        Size = UDim2.new(0, 18, 0, 18),
        Position = UDim2.new(0.5, -9, 0.5, -9),
        BackgroundColor3 = C.neonGreen,
        BorderSizePixel = 0,
        Parent = bg
    })
    corner(center, 4)

    for _, pos in ipairs({
        {0.5, -3, 0, 2, 6, 8},
        {0.5, -3, 1, -10, 6, 8},
        {0, 2, 0.5, -3, 8, 6},
        {1, -10, 0.5, -3, 8, 6}
    }) do
        local f = new("Frame", {
            Size = UDim2.new(0, pos[5], 0, pos[6]),
            Position = UDim2.new(pos[1], pos[2], pos[3], pos[4]),
            BackgroundColor3 = C.neonGreen,
            BorderSizePixel = 0,
            Parent = bg
        })
        corner(f, 3)
    end
end

iconStar(rightPanel)

new("TextLabel", {
    Size = UDim2.new(1, -20, 0, 34),
    Position = UDim2.new(0, 10, 0, 88),
    BackgroundTransparency = 1,
    Text = "$4.99",
    TextColor3 = C.neonGreen,
    TextSize = 26,
    Font = Enum.Font.GothamBlack,
    TextXAlignment = Enum.TextXAlignment.Center,
    Parent = rightPanel
})

new("TextLabel", {
    Size = UDim2.new(1, -20, 0, 16),
    Position = UDim2.new(0, 10, 0, 122),
    BackgroundTransparency = 1,
    Text = "Lifetime Access",
    TextColor3 = C.muted,
    TextSize = 11,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Center,
    Parent = rightPanel
})

local line2 = new("Frame", {
    Size = UDim2.new(0, 50, 0, 2),
    Position = UDim2.new(0.5, -25, 0, 150),
    BackgroundColor3 = C.neonGreen,
    BackgroundTransparency = 0.4,
    BorderSizePixel = 0,
    Parent = rightPanel
})
corner(line2, 1)

local featList = new("Frame", {
    Size = UDim2.new(1, -20, 0, 80),
    Position = UDim2.new(0, 10, 0, 164),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Parent = rightPanel
})

local features = {"Premium Scripts", "Auto Updates", "24/7 Support"}
for i, feat in ipairs(features) do
    local row = new("Frame", {
        Size = UDim2.new(1, 0, 0, 22),
        Position = UDim2.new(0, 0, 0, (i - 1) * 26),
        BackgroundTransparency = 1,
        Parent = featList
    })

    local check = new("Frame", {
        Size = UDim2.new(0, 14, 0, 14),
        Position = UDim2.new(0, 8, 0.5, -7),
        BackgroundColor3 = C.neonGreen,
        BackgroundTransparency = 0.25,
        BorderSizePixel = 0,
        Parent = row
    })
    corner(check, 4)

    new("Frame", {
        Size = UDim2.new(0, 6, 0, 6),
        Position = UDim2.new(0.5, -3, 0.5, -3),
        BackgroundColor3 = C.neonGreen,
        BorderSizePixel = 0,
        Parent = check
    })

    new("TextLabel", {
        Size = UDim2.new(1, -34, 1, 0),
        Position = UDim2.new(0, 28, 0, 0),
        BackgroundTransparency = 1,
        Text = feat,
        TextColor3 = C.muted,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = row
    })
end

local containers = {leftCont, centerCont, rightCont}
for _, c in ipairs(containers) do
    c.Size = UDim2.new(0, c.Size.X.Offset, 0, 0)
end

local function reveal()
    for i, c in ipairs(containers) do
        local targetH = 260
        local delayTime = (i - 1) * 0.12
        task.delay(delayTime, function()
            TweenService:Create(c, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, c.Size.X.Offset, 0, targetH)
            }):Play()
        end)
    end
end

reveal()

local function rotateGradient(grad, speed)
    local rot = grad.Rotation
    return RunService.Heartbeat:Connect(function(dt)
        rot = rot + dt * speed
        grad.Rotation = rot % 360
    end)
end

rotateGradient(leftGrad, 10)
rotateGradient(centerGrad, -8)
rotateGradient(rightGrad, 12)
rotateGradient(btnGrad, 18)
rotateGradient(glowGrad, 25)

local floatTime = 0
RunService.Heartbeat:Connect(function(dt)
    floatTime = floatTime + dt
    local baseY = -130
    leftCont.Position = UDim2.new(0.5, -320, 0.5, baseY + math.sin(floatTime * 1.4) * 6)
    centerCont.Position = UDim2.new(0.5, -110, 0.5, baseY + math.sin(floatTime * 1.4 + 1.0) * 6)
    rightCont.Position = UDim2.new(0.5, 150, 0.5, baseY + math.sin(floatTime * 1.4 + 2.0) * 6)

    leftShadow.Position = UDim2.new(0, -8, 0, -8 + math.sin(floatTime * 1.4) * 3)
    centerShadow.Position = UDim2.new(0, -8, 0, -8 + math.sin(floatTime * 1.4 + 1.0) * 3)
    rightShadow.Position = UDim2.new(0, -8, 0, -8 + math.sin(floatTime * 1.4 + 2.0) * 3)
end)

local pulseTime = 0
RunService.Heartbeat:Connect(function(dt)
    pulseTime = pulseTime + dt
    local s = 1 + math.sin(pulseTime * 3.5) * 0.35
    dot.Size = UDim2.new(0, 8 * s, 0, 8 * s)
    dot.Position = UDim2.new(0, 12 - 4 * (s - 1), 0.5, -4 * s)
end)

local btnHoverIn = TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local btnHoverOut = TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local btnClick = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

enterBtn.MouseEnter:Connect(function()
    TweenService:Create(enterBtn, btnHoverIn, {
        BackgroundColor3 = C.neonBright,
        Size = UDim2.new(1, 6, 1, 6),
        Position = UDim2.new(0, -3, 0, -3)
    }):Play()
    TweenService:Create(btnGlow, btnHoverIn, {
        BackgroundTransparency = 0.72,
        Size = UDim2.new(1, 28, 1, 28),
        Position = UDim2.new(0, -14, 0, -14)
    }):Play()
end)

enterBtn.MouseLeave:Connect(function()
    TweenService:Create(enterBtn, btnHoverOut, {
        BackgroundColor3 = C.neonGreen,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0)
    }):Play()
    TweenService:Create(btnGlow, btnHoverOut, {
        BackgroundTransparency = 0.88,
        Size = UDim2.new(1, 20, 1, 20),
        Position = UDim2.new(0, -10, 0, -10)
    }):Play()
end)

enterBtn.MouseButton1Down:Connect(function()
    TweenService:Create(enterBtn, btnClick, {
        Size = UDim2.new(1, -3, 1, -3),
        Position = UDim2.new(0, 1, 0, 1)
    }):Play()
end)

enterBtn.MouseButton1Up:Connect(function()
    TweenService:Create(enterBtn, btnClick, {
        Size = UDim2.new(1, 6, 1, 6),
        Position = UDim2.new(0, -3, 0, -3)
    }):Play()
end)

enterBtn.MouseButton1Click:Connect(function()
    local key = keyInput.Text
    if key and #key > 0 then
        enterBtn.Text = "Verifying..."
        task.wait(0.5)
        enterBtn.Text = "Success"
        task.wait(0.8)
        enterBtn.Text = "Enter Key"
    else
        local orig = inputBg.Position
        for i = 1, 8 do
            inputBg.Position = orig + UDim2.new(0, (i % 2 == 0 and 6 or -6), 0, 0)
            task.wait(0.025)
        end
        inputBg.Position = orig
    end
end)

keyInput.Focused:Connect(function()
    TweenService:Create(inputBg, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(30, 60, 35)
    }):Play()
    for _, child in ipairs(inputBg:GetChildren()) do
        if child:IsA("UIStroke") then
            TweenService:Create(child, TweenInfo.new(0.2), {
                Transparency = 0.1,
                Color = C.neonBright
            }):Play()
        end
    end
end)

keyInput.FocusLost:Connect(function()
    TweenService:Create(inputBg, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(20, 45, 25)
    }):Play()
    for _, child in ipairs(inputBg:GetChildren()) do
        if child:IsA("UIStroke") then
            TweenService:Create(child, TweenInfo.new(0.2), {
                Transparency = 0.35,
                Color = C.neonGreen
            }):Play()
        end
    end
end)

local toggleOn = true
local toggleConn

toggleBg.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        toggleOn = not toggleOn
        if toggleOn then
            TweenService:Create(toggleKnob, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.new(0, 3, 0.5, -11),
                BackgroundColor3 = C.neonGreen
            }):Play()
            TweenService:Create(toggleBg, TweenInfo.new(0.25), {
                BackgroundColor3 = Color3.fromRGB(20, 45, 25)
            }):Play()
            TweenService:Create(toggleGlow, TweenInfo.new(0.25), {
                BackgroundTransparency = 0.85
            }):Play()
        else
            TweenService:Create(toggleKnob, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Position = UDim2.new(0, 27, 0.5, -11),
                BackgroundColor3 = C.muted
            }):Play()
            TweenService:Create(toggleBg, TweenInfo.new(0.25), {
                BackgroundColor3 = Color3.fromRGB(35, 35, 38)
            }):Play()
            TweenService:Create(toggleGlow, TweenInfo.new(0.25), {
                BackgroundTransparency = 1
            }):Play()
        end
    end
end)
