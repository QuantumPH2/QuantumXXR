local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("KeySystem") then
    playerGui.KeySystem:Destroy()
end

local C = {
    neonGreen = Color3.fromRGB(0, 255, 128),
    neonBright = Color3.fromRGB(60, 255, 170),
    neonGlow = Color3.fromRGB(0, 255, 100),
    white = Color3.fromRGB(255, 255, 255),
    offWhite = Color3.fromRGB(220, 255, 235),
    muted = Color3.fromRGB(150, 190, 165),
    panelBase = Color3.fromRGB(18, 45, 26),
    inputBg = Color3.fromRGB(12, 35, 18),
    toggleBgOff = Color3.fromRGB(30, 30, 33)
}

local ASSETS = {
    user = "rbxassetid://3944679652",
    lock = "rbxassetid://3944680095",
    star = "rbxassetid://3944679678",
    key = "rbxassetid://3944680114",
    check = "rbxassetid://3944679795"
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
    return new("UIStroke", {Color = color or C.neonGreen, Thickness = thickness or 1.5, Transparency = transparency or 0.25, Parent = parent})
end

local function censor(name)
    if #name <= 4 then
        return name:sub(1, 1) .. string.rep("*", #name - 1)
    end
    return name:sub(1, 1) .. string.rep("*", 2) .. string.rep("·", math.max(1, #name - 6)) .. string.rep("*", 2) .. name:sub(-1, -1)
end

local screenGui = new("ScreenGui", {
    Name = "KeySystem",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    Parent = playerGui
})

local function makePanel(name, xOff, w, rot)
    local cont = new("Frame", {
        Name = name .. "Cont",
        Size = UDim2.new(0, w, 0, 0),
        Position = UDim2.new(0.5, xOff, 0.5, -125),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Parent = screenGui
    })

    local panel = new("Frame", {
        Name = name,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = C.panelBase,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = cont
    })
    corner(panel, 18)
    stroke(panel, C.neonGreen, 1.5, 0.3)

    local g = new("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, C.neonGreen),
            ColorSequenceKeypoint.new(0.45, Color3.fromRGB(140, 255, 200)),
            ColorSequenceKeypoint.new(1, C.white)
        }),
        Rotation = rot,
        Parent = panel
    })

    g.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.1),
        NumberSequenceKeypoint.new(0.5, 0.3),
        NumberSequenceKeypoint.new(1, 0.5)
    })

    return cont, panel, g
end

local leftCont, leftPanel, leftGrad = makePanel("Left", -310, 180, 135)
local centerCont, centerPanel, centerGrad = makePanel("Center", -110, 230, 90)
local rightCont, rightPanel, rightGrad = makePanel("Right", 140, 180, 45)


local userIcon = new("ImageLabel", {
    Size = UDim2.new(0, 50, 0, 50),
    Position = UDim2.new(0.5, -25, 0, 22),
    BackgroundTransparency = 1,
    Image = ASSETS.user,
    ImageColor3 = C.neonGreen,
    ScaleType = Enum.ScaleType.Fit,
    Parent = leftPanel
})
corner(userIcon, 25)

new("TextLabel", {
    Size = UDim2.new(1, -16, 0, 16),
    Position = UDim2.new(0, 8, 0, 82),
    BackgroundTransparency = 1,
    Text = "Welcome Back,",
    TextColor3 = C.muted,
    TextSize = 11,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Center,
    Parent = leftPanel
})

new("TextLabel", {
    Size = UDim2.new(1, -16, 0, 24),
    Position = UDim2.new(0, 8, 0, 100),
    BackgroundTransparency = 1,
    Text = censor(player.Name),
    TextColor3 = C.white,
    TextSize = 16,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Center,
    TextTruncate = Enum.TextTruncate.AtEnd,
    Parent = leftPanel
})

local line1 = new("Frame", {
    Size = UDim2.new(0, 50, 0, 2),
    Position = UDim2.new(0.5, -25, 0, 134),
    BackgroundColor3 = C.neonGreen,
    BackgroundTransparency = 0.4,
    BorderSizePixel = 0,
    Parent = leftPanel
})
corner(line1, 1)

local statusBg = new("Frame", {
    Size = UDim2.new(0, 100, 0, 28),
    Position = UDim2.new(0.5, -50, 0, 148),
    BackgroundColor3 = C.inputBg,
    BorderSizePixel = 0,
    Parent = leftPanel
})
corner(statusBg, 8)
stroke(statusBg, C.neonGreen, 1, 0.4)

local dot = new("Frame", {
    Size = UDim2.new(0, 7, 0, 7),
    Position = UDim2.new(0, 10, 0.5, -3),
    BackgroundColor3 = C.neonGreen,
    BorderSizePixel = 0,
    Parent = statusBg
})
corner(dot, 4)

new("TextLabel", {
    Size = UDim2.new(1, -24, 1, 0),
    Position = UDim2.new(0, 22, 0, 0),
    BackgroundTransparency = 1,
    Text = "Online",
    TextColor3 = C.neonGreen,
    TextSize = 11,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = statusBg
})

local toggleBg = new("Frame", {
    Size = UDim2.new(0, 48, 0, 26),
    Position = UDim2.new(0.5, -24, 0, 192),
    BackgroundColor3 = C.inputBg,
    BorderSizePixel = 0,
    Parent = leftPanel
})
corner(toggleBg, 13)
stroke(toggleBg, C.neonGreen, 1.5, 0.35)

local toggleKnob = new("Frame", {
    Size = UDim2.new(0, 20, 0, 20),
    Position = UDim2.new(0, 3, 0.5, -10),
    BackgroundColor3 = C.neonGreen,
    BorderSizePixel = 0,
    Parent = toggleBg
})
corner(toggleKnob, 10)

local toggleGlow = new("Frame", {
    Size = UDim2.new(0, 28, 0, 28),
    Position = UDim2.new(0.5, -14, 0.5, -14),
    BackgroundColor3 = C.neonGlow,
    BackgroundTransparency = 0.85,
    BorderSizePixel = 0,
    Parent = toggleKnob
})
corner(toggleGlow, 14)

new("TextLabel", {
    Size = UDim2.new(1, -16, 0, 14),
    Position = UDim2.new(0, 8, 0, 226),
    BackgroundTransparency = 1,
    Text = "Auto-Login",
    TextColor3 = C.muted,
    TextSize = 10,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Center,
    Parent = leftPanel
})


local lockIcon = new("ImageLabel", {
    Size = UDim2.new(0, 46, 0, 46),
    Position = UDim2.new(0.5, -23, 0, 20),
    BackgroundTransparency = 1,
    Image = ASSETS.lock,
    ImageColor3 = C.neonGreen,
    ScaleType = Enum.ScaleType.Fit,
    Parent = centerPanel
})
corner(lockIcon, 12)

new("TextLabel", {
    Size = UDim2.new(1, -20, 0, 24),
    Position = UDim2.new(0, 10, 0, 74),
    BackgroundTransparency = 1,
    Text = "Key System",
    TextColor3 = C.white,
    TextSize = 19,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Center,
    Parent = centerPanel
})

new("TextLabel", {
    Size = UDim2.new(1, -20, 0, 14),
    Position = UDim2.new(0, 10, 0, 100),
    BackgroundTransparency = 1,
    Text = "Enter your access key",
    TextColor3 = C.muted,
    TextSize = 11,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Center,
    Parent = centerPanel
})

local inputBg = new("Frame", {
    Size = UDim2.new(1, -24, 0, 40),
    Position = UDim2.new(0, 12, 0, 126),
    BackgroundColor3 = C.inputBg,
    BorderSizePixel = 0,
    Parent = centerPanel
})
corner(inputBg, 10)
stroke(inputBg, C.neonGreen, 1.5, 0.35)

local keyIcon = new("ImageLabel", {
    Size = UDim2.new(0, 18, 0, 18),
    Position = UDim2.new(0, 10, 0.5, -9),
    BackgroundTransparency = 1,
    Image = ASSETS.key,
    ImageColor3 = C.neonGreen,
    ScaleType = Enum.ScaleType.Fit,
    Parent = inputBg
})

local keyInput = new("TextBox", {
    Size = UDim2.new(1, -40, 1, 0),
    Position = UDim2.new(0, 34, 0, 0),
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

local btnWrap = new("Frame", {
    Size = UDim2.new(1, -24, 0, 42),
    Position = UDim2.new(0, 12, 0, 180),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Parent = centerPanel
})

local btnGlow = new("Frame", {
    Size = UDim2.new(1, 18, 1, 18),
    Position = UDim2.new(0, -9, 0, -9),
    BackgroundColor3 = C.neonGlow,
    BackgroundTransparency = 0.9,
    BorderSizePixel = 0,
    ZIndex = 1,
    Parent = btnWrap
})
corner(btnGlow, 16)

local glowGrad = new("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, C.neonGlow),
        ColorSequenceKeypoint.new(1, C.neonGreen)
    }),
    Parent = btnGlow
})
glowGrad.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.9),
    NumberSequenceKeypoint.new(1, 1)
})

local enterBtn = new("TextButton", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundColor3 = C.neonGreen,
    BorderSizePixel = 0,
    Text = "Enter Key",
    TextColor3 = Color3.fromRGB(8, 25, 14),
    TextSize = 14,
    Font = Enum.Font.GothamBold,
    ZIndex = 2,
    Parent = btnWrap
})
corner(enterBtn, 12)

local btnGrad = new("UIGradient", {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, C.neonBright),
        ColorSequenceKeypoint.new(0.5, C.neonGreen),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 210, 100))
    }),
    Rotation = 90,
    Parent = enterBtn
})

stroke(enterBtn, C.neonBright, 1.5, 0.15)


local starIcon = new("ImageLabel", {
    Size = UDim2.new(0, 50, 0, 50),
    Position = UDim2.new(0.5, -25, 0, 22),
    BackgroundTransparency = 1,
    Image = ASSETS.star,
    ImageColor3 = C.neonGreen,
    ScaleType = Enum.ScaleType.Fit,
    Parent = rightPanel
})
corner(starIcon, 25)

new("TextLabel", {
    Size = UDim2.new(1, -16, 0, 32),
    Position = UDim2.new(0, 8, 0, 80),
    BackgroundTransparency = 1,
    Text = "$4.99",
    TextColor3 = C.neonGreen,
    TextSize = 24,
    Font = Enum.Font.GothamBlack,
    TextXAlignment = Enum.TextXAlignment.Center,
    Parent = rightPanel
})

new("TextLabel", {
    Size = UDim2.new(1, -16, 0, 14),
    Position = UDim2.new(0, 8, 0, 114),
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
    Position = UDim2.new(0.5, -25, 0, 138),
    BackgroundColor3 = C.neonGreen,
    BackgroundTransparency = 0.4,
    BorderSizePixel = 0,
    Parent = rightPanel
})
corner(line2, 1)

local featList = new("Frame", {
    Size = UDim2.new(1, -16, 0, 76),
    Position = UDim2.new(0, 8, 0, 152),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Parent = rightPanel
})

local features = {"Premium Scripts", "Auto Updates", "24/7 Support"}
for i, feat in ipairs(features) do
    local row = new("Frame", {
        Size = UDim2.new(1, 0, 0, 20),
        Position = UDim2.new(0, 0, 0, (i - 1) * 24),
        BackgroundTransparency = 1,
        Parent = featList
    })

    local check = new("ImageLabel", {
        Size = UDim2.new(0, 14, 0, 14),
        Position = UDim2.new(0, 6, 0.5, -7),
        BackgroundTransparency = 1,
        Image = ASSETS.check,
        ImageColor3 = C.neonGreen,
        ScaleType = Enum.ScaleType.Fit,
        Parent = row
    })

    new("TextLabel", {
        Size = UDim2.new(1, -28, 1, 0),
        Position = UDim2.new(0, 24, 0, 0),
        BackgroundTransparency = 1,
        Text = feat,
        TextColor3 = C.muted,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = row
    })
end


local panels = {leftCont, centerCont, rightCont}
local targetH = 250

for i, p in ipairs(panels) do
    task.delay((i - 1) * 0.1, function()
        TweenService:Create(p, TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, p.Size.X.Offset, 0, targetH)
        }):Play()
    end)
end


local t = 0
RunService.Heartbeat:Connect(function(dt)
    t = t + dt

    local baseY = -125
    leftCont.Position = UDim2.new(0.5, -310, 0.5, baseY + math.sin(t * 1.1) * 5)
    centerCont.Position = UDim2.new(0.5, -110, 0.5, baseY + math.sin(t * 1.1 + 1.0) * 5)
    rightCont.Position = UDim2.new(0.5, 140, 0.5, baseY + math.sin(t * 1.1 + 2.0) * 5)

    leftGrad.Rotation = 135 + t * 6
    centerGrad.Rotation = 90 + t * 8
    rightGrad.Rotation = 45 + t * 6
    btnGrad.Rotation = 90 + t * 12
    glowGrad.Rotation = t * 15

    local s = 1 + math.sin(t * 3.5) * 0.3
    dot.Size = UDim2.new(0, 7 * s, 0, 7 * s)
    dot.Position = UDim2.new(0, 10 - 3.5 * (s - 1), 0.5, -3.5 * s)
end)


local hoverIn = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local hoverOut = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local click = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

enterBtn.MouseEnter:Connect(function()
    TweenService:Create(enterBtn, hoverIn, {
        BackgroundColor3 = C.neonBright,
        Size = UDim2.new(1, 6, 1, 6),
        Position = UDim2.new(0, -3, 0, -3)
    }):Play()
    TweenService:Create(btnGlow, hoverIn, {
        BackgroundTransparency = 0.78,
        Size = UDim2.new(1, 26, 1, 26),
        Position = UDim2.new(0, -13, 0, -13)
    }):Play()
end)

enterBtn.MouseLeave:Connect(function()
    TweenService:Create(enterBtn, hoverOut, {
        BackgroundColor3 = C.neonGreen,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0)
    }):Play()
    TweenService:Create(btnGlow, hoverOut, {
        BackgroundTransparency = 0.9,
        Size = UDim2.new(1, 18, 1, 18),
        Position = UDim2.new(0, -9, 0, -9)
    }):Play()
end)

enterBtn.MouseButton1Down:Connect(function()
    TweenService:Create(enterBtn, click, {
        Size = UDim2.new(1, -2, 1, -2),
        Position = UDim2.new(0, 1, 0, 1)
    }):Play()
end)

enterBtn.MouseButton1Up:Connect(function()
    TweenService:Create(enterBtn, click, {
        Size = UDim2.new(1, 6, 1, 6),
        Position = UDim2.new(0, -3, 0, -3)
    }):Play()
end)

enterBtn.MouseButton1Click:Connect(function()
    local key = keyInput.Text
    if key and #key > 0 then
        enterBtn.Text = "Verifying..."
        task.wait(0.5)
        enterBtn.Text = "Access Granted"
        task.wait(1)
        enterBtn.Text = "Enter Key"
    else
        local orig = inputBg.Position
        for i = 1, 8 do
            inputBg.Position = orig + UDim2.new(0, (i % 2 == 0 and 5 or -5), 0, 0)
            task.wait(0.025)
        end
        inputBg.Position = orig
    end
end)

keyInput.Focused:Connect(function()
    TweenService:Create(inputBg, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(25, 55, 32)
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
        BackgroundColor3 = C.inputBg
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

toggleBg.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        toggleOn = not toggleOn
        if toggleOn then
            TweenService:Create(toggleKnob, TweenInfo.new(0.22), {
                Position = UDim2.new(0, 3, 0.5, -10),
                BackgroundColor3 = C.neonGreen
            }):Play()
            TweenService:Create(toggleBg, TweenInfo.new(0.22), {
                BackgroundColor3 = C.inputBg
            }):Play()
            TweenService:Create(toggleGlow, TweenInfo.new(0.22), {
                BackgroundTransparency = 0.85
            }):Play()
        else
            TweenService:Create(toggleKnob, TweenInfo.new(0.22), {
                Position = UDim2.new(0, 25, 0.5, -10),
                BackgroundColor3 = C.muted
            }):Play()
            TweenService:Create(toggleBg, TweenInfo.new(0.22), {
                BackgroundColor3 = C.toggleBgOff
            }):Play()
            TweenService:Create(toggleGlow, TweenInfo.new(0.22), {
                BackgroundTransparency = 1
            }):Play()
        end
    end
end)
