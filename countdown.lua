-- Font Configuration
local fontRegular = Enum.Font.Montserrat
local fontBold = Enum.Font.MontserratBold

local p = game:GetService("Players").LocalPlayer or game:GetService("Players").PlayerAdded:Wait()
local pg = p:FindFirstChildOfClass("PlayerGui") or game:GetService("CoreGui")
local ts = game:GetService("TweenService")
local hs = game:GetService("HttpService")
local uis = game:GetService("UserInputService")
local u, col = UDim2.new, Color3.fromRGB

-- Theme Registry & Active Accent Color
local accentColor = col(127, 90, 240) -- Violet Default
local themeElements = {}

local function registerThemeElement(elem, prop)
    table.insert(themeElements, { elem = elem, prop = prop })
    if elem[prop] then elem[prop] = accentColor end
end

local function updateTheme(newColor)
    accentColor = newColor
    for _, t in ipairs(themeElements) do
        if t.elem and t.elem.Parent then
            t.elem[t.prop] = newColor
        end
    end
end

-- Helper to safely lighten color without non-native methods
local function lightenColor(cl, pct)
    local amount = pct / 100
    return Color3.new(
        math.clamp(cl.R + amount, 0, 1),
        math.clamp(cl.G + amount, 0, 1),
        math.clamp(cl.B + amount, 0, 1)
    )
end

local function c(cl, pr, prp)
    local o = Instance.new(cl)
    for k, v in pairs(prp or {}) do o[k] = v end
    o.Parent = pr
    return o
end

-- Hover Utility
local function applyHoverEffect(btn, baseCol, hoverCol)
    btn.MouseEnter:Connect(function()
        ts:Create(btn, TweenInfo.new(0.2), { BackgroundColor3 = hoverCol }):Play()
    end)
    btn.MouseLeave:Connect(function()
        ts:Create(btn, TweenInfo.new(0.2), { BackgroundColor3 = baseCol }):Play()
    end)
end

local sg = c("ScreenGui", pg, { ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling })

-- Global Toast Notification System Container
local notifContainer = c("Frame", sg, {
    Size = u(0, 220, 0, 300),
    Position = u(1, -240, 0, 20),
    BackgroundTransparency = 1
})
c("UIListLayout", notifContainer,
    { Padding = UDim.new(0, 8), VerticalAlignment = Enum.VerticalAlignment.Top, SortOrder = Enum.SortOrder.LayoutOrder })

local function showToast(msg, isSuccess)
    local card = c("Frame", notifContainer, {
        Size = u(1, 0, 0, 40),
        BackgroundColor3 = col(28, 28, 30),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        ClipsDescendants = true
    })
    c("UICorner", card, { CornerRadius = UDim.new(0, 6) })
    local stroke = c("UIStroke", card,
        { Color = isSuccess and col(46, 196, 182) or col(230, 57, 70), Thickness = 1, Transparency = 1 })

    local lbl = c("TextLabel", card, {
        Size = u(1, -20, 1, 0),
        Position = u(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = msg,
        TextColor3 = col(220, 220, 220),
        Font = fontRegular,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        TextTruncate = Enum.TextTruncate.AtEnd,
        TextTransparency = 1
    })

    ts:Create(card, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundTransparency = 0 })
        :Play()
    ts:Create(stroke, TweenInfo.new(0.3), { Transparency = 0 }):Play()
    ts:Create(lbl, TweenInfo.new(0.3), { TextTransparency = 0 }):Play()

    task.delay(3, function()
        if card.Parent then
            local out = ts:Create(card, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                { BackgroundTransparency = 1 })
            ts:Create(stroke, TweenInfo.new(0.3), { Transparency = 1 }):Play()
            ts:Create(lbl, TweenInfo.new(0.3), { TextTransparency = 1 }):Play()
            out:Play()
            out.Completed:Connect(function() card:Destroy() end)
        end
    end)
end

-- Globals Persistence Logic
local cfName, savedG = "script_hub_config.json", {}
local function saveCf() pcall(function() if writefile then writefile(cfName, hs:JSONEncode(savedG)) end end) end
local function loadCf()
    pcall(function()
        if readfile and isfile and isfile(cfName) then
            savedG = hs:JSONDecode(readfile(cfName)) or {}
            local env = getgenv and getgenv() or _G
            for k, v in pairs(savedG) do env[k] = v end
        end
    end)
end
loadCf()

-- Executor Identification
local execName = "Roblox Client"
pcall(function()
    execName = (identifyexecutor and select(1, identifyexecutor())) or
        (getexecutorname and getexecutorname()) or "Executor"
end)

-- Game Mailbox Networking Initialization
local sharedModules = game:GetService("ReplicatedStorage"):WaitForChild("SharedModules", 10)
local networking = sharedModules and require(sharedModules:WaitForChild("Networking"))
local mailbox = networking and networking.Mailbox

local function safeRequire(name)
    local module = sharedModules and sharedModules:FindFirstChild(name)
    if module then
        local success, result = pcall(require, module)
        if success then
            return result
        end
    end
    return nil
end

local fruitValueCalc = safeRequire("FruitValueCalc")
local mutationData = safeRequire("MutationData")
local sellFlags = safeRequire("SellFlags")

local currentMultiplierMode = "live"
local stockSnapshot = {}
local totalValueLabel = nil

local function fetchStock()
    return stockSnapshot
end

task.spawn(function()
    while true do
        pcall(function()
            local req = networking and networking.FruitStock and networking.FruitStock.Request
            if req and type(req.Fire) == "function" then
                local data = req:Fire()
                if type(data) == "table" and type(data.entries) == "table" then
                    local temp = {}
                    for k, v in pairs(data.entries) do
                        if type(k) == "string" and type(v) == "table" then
                            temp[k] = tonumber(v.multiplier) or 1
                        end
                    end
                    stockSnapshot = temp
                end
            end
        end)
        task.wait(10)
    end
end)

local function getFruitPrice(fruitName, itemInstance, multiplierMode)
    local basePrice = 0
    pcall(function()
        if fruitValueCalc and type(fruitValueCalc) == "function" then
            local sizeMulti = itemInstance:GetAttribute("SizeMultiplier") or itemInstance:GetAttribute("SizeMulti") or 1
            local mutation = itemInstance:GetAttribute("Mutation") or itemInstance:GetAttribute("Mutations") or nil
            if mutation == "None" then mutation = nil end
            local decayAlpha = itemInstance:GetAttribute("DecayAlpha")
            basePrice = fruitValueCalc(fruitName, sizeMulti, mutation, p, decayAlpha) or 0
        end
    end)

    if basePrice <= 0 then
        pcall(function()
            local sellValueData = sharedModules and require(sharedModules:WaitForChild("SellValueData"))
            local base = sellValueData and tonumber(sellValueData[fruitName]) or 0
            local sizeMulti = itemInstance:GetAttribute("SizeMultiplier") or itemInstance:GetAttribute("SizeMulti") or 1
            local mutation = itemInstance:GetAttribute("Mutation") or itemInstance:GetAttribute("Mutations") or ""
            local mutationMult = 1
            if mutationData and type(mutationData.ReturnPriceMultiplier) == "function" and mutation ~= "" and mutation ~= "None" then
                mutationMult = mutationData.ReturnPriceMultiplier(mutation) or 1
            end
            basePrice = math.max(math.floor((base * (sizeMulti ^ 3)) * mutationMult), 0)
        end)
    end

    if multiplierMode == "live" then
        local stock = fetchStock()
        local mult = stock and stock[fruitName]
        if mult then
            basePrice = math.max(math.floor(basePrice * mult), 0)
        else
            pcall(function()
                if sellFlags and type(sellFlags.Apply) == "function" then
                    basePrice = sellFlags.Apply(fruitName, basePrice) or basePrice
                end
            end)
        end
    end

    return basePrice
end

local function formatPrice(value)
    value = tonumber(value) or 0
    if value >= 1000000000 then
        local formatted = string.format("%.1f", value / 1000000000)
        return (formatted:gsub("%.0$", "")) .. "B"
    elseif value >= 1000000 then
        local formatted = string.format("%.1f", value / 1000000)
        return (formatted:gsub("%.0$", "")) .. "M"
    elseif value >= 1000 then
        local formatted = string.format("%.1f", value / 1000)
        return (formatted:gsub("%.0$", "")) .. "K"
    end
    return tostring(value)
end

local E = { Mail = {} }

E.Mail.CleanUsername = function(str)
    str = tostring(str or "")
    return (str:gsub("^%s*@?", "")):gsub("%s+$", "")
end

E.Mail.LookupRecipient = function(username)
    username = E.Mail.CleanUsername(username)
    if #username < 3 or #username > 20 then
        return nil, "Invalid username length"
    end
    if not mailbox or type(mailbox.LookupPlayer) ~= "table" then
        return nil, "Mailbox remote system is offline"
    end
    local success, userId, displayName = pcall(function()
        return mailbox.LookupPlayer:Fire(username)
    end)
    if not success or not userId or userId <= 0 then
        return nil, "Player was not found"
    end
    if userId == p.UserId then
        return nil, "You cannot send mail to yourself"
    end
    return {
        userId = userId,
        username = username,
        displayName = type(displayName) == "string" and displayName or username
    }
end

E.Mail.SendFruitBatch = function(recipient, fruits, note)
    if not mailbox or type(mailbox.SendBatch) ~= "table" then
        return false, "SendBatch remote is missing"
    end

    local batch = {}
    for _, fruit in ipairs(fruits) do
        table.insert(batch, {
            Category = "HarvestedFruits",
            ItemKey = fruit.id,
            Count = 1
        })
    end

    local success, isOk, errMsg = pcall(function()
        return mailbox.SendBatch:Fire(recipient.userId, batch, note or "")
    end)

    if not success then
        return false, "Network error during transmission"
    end

    if isOk ~= true then
        return false, type(errMsg) == "string" and errMsg or "Server rejected transmission"
    end

    return true, "Successfully sent!"
end

-- Main Window Container (No drop shadow)
local mainContainer = c("Frame", sg, {
    Size = u(0, 520, 0, 340),
    Position = u(0.5, -260, 0.5, -170),
    BackgroundTransparency = 1,
    ClipsDescendants = false
})

-- Side-by-Side Fruit Selection Panel (Configured on the Right Side of Main GUI)
-- Created before f so that f naturally renders on top of it when closed
local selectionPanel = c("Frame", mainContainer, {
    Size = u(0, 200, 1, -30),
    Position = u(0, 290, 0, 15), -- Slides right to 505px when opened
    BackgroundColor3 = col(23, 23, 23),
    BorderSizePixel = 0,
    Visible = false,
    ClipsDescendants = true
})
c("UICorner", selectionPanel, { CornerRadius = UDim.new(0, 8) })
local panelStroke = c("UIStroke", selectionPanel, { Color = col(40, 40, 40), Thickness = 1, Transparency = 0.5 })
registerThemeElement(panelStroke, "Color")

local panelTitle = c("TextLabel", selectionPanel, {
    Size = u(1, 0, 0, 24),
    Position = u(0, 0, 0, 8),
    BackgroundTransparency = 1,
    Text = "Select Fruits",
    TextColor3 = col(240, 240, 240),
    Font = fontBold,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Center
})

-- Multiplier Toggle Button
local multToggleBtn = c("TextButton", selectionPanel, {
    Size = u(1, -24, 0, 20),
    Position = u(0, 12, 0, 32),
    BackgroundColor3 = col(35, 35, 38),
    Text = "Mode: LIVE X",
    TextColor3 = col(220, 220, 220),
    Font = fontBold,
    TextSize = 9,
    AutoButtonColor = false
})
c("UICorner", multToggleBtn, { CornerRadius = UDim.new(0, 4) })
applyHoverEffect(multToggleBtn, col(35, 35, 38), col(45, 45, 48))

totalValueLabel = c("TextLabel", selectionPanel, {
    Size = u(1, -24, 0, 16),
    Position = u(0, 12, 0, 54),
    BackgroundTransparency = 1,
    Text = "Total Value: $0",
    TextColor3 = col(46, 196, 182),
    Font = fontBold,
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Center
})

multToggleBtn.MouseButton1Click:Connect(function()
    if currentMultiplierMode == "live" then
        currentMultiplierMode = "1x"
    else
        currentMultiplierMode = "live"
    end
    multToggleBtn.Text = "Mode: " .. currentMultiplierMode:upper()
    populateSelectionGrid()
    updateSelectedCounter()
end)

local gridScroller = c("ScrollingFrame", selectionPanel, {
    Size = u(1, -20, 1, -88),
    Position = u(0, 10, 0, 78),
    BackgroundTransparency = 1,
    CanvasSize = u(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ScrollBarThickness = 2,
    ScrollBarImageColor3 = col(60, 60, 60),
    CanvasPosition = Vector2.new(0, 0)
})
local gridLayout = c("UIGridLayout", gridScroller, {
    CellSize = u(0, 52, 0, 68),
    CellPadding = u(0, 8, 0, 8),
    HorizontalAlignment = Enum.HorizontalAlignment.Center,
    SortOrder = Enum.SortOrder.LayoutOrder
})

-- Sibling Frame f sits on top of selectionPanel
local f = c("Frame", mainContainer, {
    Size = u(1, -30, 1, -30),
    Position = u(0, 15, 0, 15),
    BackgroundColor3 = col(23, 23, 23),
    BorderSizePixel = 0,
    Active = true,
    ClipsDescendants = false
})
c("UICorner", f, { CornerRadius = UDim.new(0, 8) })
local frameStroke = c("UIStroke", f, { Color = col(40, 40, 40), Thickness = 1, Transparency = 0.5 })
registerThemeElement(frameStroke, "Color")

-- Top Navbar
local nb = c("Frame", f, {
    Size = u(1, 0, 0, 42),
    BackgroundColor3 = col(28, 28, 30),
    BorderSizePixel = 0
})
c("UICorner", nb, { CornerRadius = UDim.new(0, 8) })
c("Frame", nb,
    { Size = u(1, 0, 0, 8), Position = u(0, 0, 1, -8), BackgroundColor3 = col(28, 28, 30), BorderSizePixel = 0 })

local title = c("TextLabel", nb, {
    Size = u(0, 200, 1, 0),
    Position = u(0, 15, 0, 0),
    BackgroundTransparency = 1,
    Text = "Onyx Mailer",
    TextColor3 = col(240, 240, 240),
    Font = fontBold,
    TextSize = 15,
    TextXAlignment = Enum.TextXAlignment.Left
})

-- Dragging Functionality
local dragging, dragInput, dragStart, startPos
nb.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainContainer.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
nb.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
uis.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        mainContainer.Position = u(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale,
            startPos.Y.Offset + delta.Y)
    end
end)

-- Left Sidebar
local sbp = c("Frame", f, { Size = u(0, 120, 1, -42), Position = u(0, 0, 0, 42), BackgroundTransparency = 1 })
local sb = c("Frame", sbp, { Size = u(1, -20, 1, -60), Position = u(0, 10, 0, 10), BackgroundTransparency = 1 })
c("UIListLayout", sb,
    {
        Padding = UDim.new(0, 6),
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder
            .LayoutOrder
    })

-- User Profile Card
local profile = c("Frame", sbp, {
    Size = u(1, -20, 0, 48),
    Position = u(0, 10, 1, -58),
    BackgroundColor3 = col(28, 28, 30),
    BorderSizePixel = 0
})
c("UICorner", profile, { CornerRadius = UDim.new(0, 6) })

local avatar = c("ImageLabel", profile, {
    Size = u(0, 32, 0, 32),
    Position = u(0, 8, 0.5, -16),
    BackgroundTransparency = 1,
    Image = "rbxassetid://16823376787" -- standard fallback or custom profile
})
pcall(function()
    avatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. p.UserId .. "&w=150&h=150"
end)
c("UICorner", avatar, { CornerRadius = UDim.new(1, 0) })
c("UIStroke", avatar, { Color = col(50, 50, 50), Thickness = 1 })

local textLabel = c("TextLabel", profile, {
    Size = u(1, -48, 0, 14),
    Position = u(0, 46, 0, 10),
    BackgroundTransparency = 1,
    Text = p.DisplayName or p.Name,
    TextColor3 = col(220, 220, 220),
    Font = fontBold,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextTruncate = Enum.TextTruncate.AtEnd
})

local execTextLabel = c("TextLabel", profile, {
    Size = u(1, -48, 0, 12),
    Position = u(0, 46, 0, 26),
    BackgroundTransparency = 1,
    Text = execName,
    TextColor3 = col(140, 140, 140),
    Font = fontRegular,
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextTruncate = Enum.TextTruncate.AtEnd
})

c("Frame", f,
    { Size = u(0, 1, 1, -42), Position = u(0, 120, 0, 42), BackgroundColor3 = col(35, 35, 35), BorderSizePixel = 0 })

-- Right Content Area
local container = c("Frame", f, {
    Size = u(1, -130, 1, -42),
    Position = u(0, 130, 0, 42),
    BackgroundTransparency = 1
})
c("UIPadding", container,
    {
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),
        PaddingTop = UDim.new(0, 10),
        PaddingBottom = UDim
            .new(0, 10)
    })

-- UI Toggle Logic
local isUIOpen = true
local isPanelOpen = false
local normalPosition = u(0.5, -260, 0.5, -170)
local offscreenPosition = u(0.5, -260, 1.5, 0)

local function closeSelectionPanelInstant()
    isPanelOpen = false
    selectionPanel.Position = u(0, 290, 0, 15)
    selectionPanel.Visible = false
end

-- Floating Restore Button
local floatBtn = c("ImageButton", sg, {
    Size = u(0, 40, 0, 40),
    Position = u(0.02, 0, 0.4, 0),
    BackgroundColor3 = col(0, 0, 0),
    BorderSizePixel = 0,
    Image = "rbxassetid://10734885430", -- Mailer icon
    ImageColor3 = col(255, 255, 255),
    Visible = false,
    ZIndex = 10
})
c("UICorner", floatBtn, { CornerRadius = UDim.new(1, 0) })

-- Floating restore button drag logic
local fDragging, fDragInput, fDragStart, fStartPos
floatBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        fDragging = true
        fDragStart = input.Position
        fStartPos = floatBtn.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then fDragging = false end
        end)
    end
end)
floatBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        fDragInput = input
    end
end)
uis.InputChanged:Connect(function(input)
    if input == fDragInput and fDragging then
        local delta = input.Position - fDragStart
        floatBtn.Position = u(fStartPos.X.Scale, fStartPos.X.Offset + delta.X, fStartPos.Y.Scale,
            fStartPos.Y.Offset + delta.Y)
    end
end)

-- Hover/click logic for floating button
floatBtn.MouseEnter:Connect(function()
    ts:Create(floatBtn, TweenInfo.new(0.2), { BackgroundColor3 = col(28, 28, 30) }):Play()
end)
floatBtn.MouseLeave:Connect(function()
    ts:Create(floatBtn, TweenInfo.new(0.2), { BackgroundColor3 = col(23, 23, 23) }):Play()
end)

local function toggleUI(forceState)
    if forceState ~= nil then
        isUIOpen = forceState
    else
        isUIOpen = not isUIOpen
    end
    if isUIOpen then
        floatBtn.Visible = false
        mainContainer.Visible = true
        ts:Create(mainContainer, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
            { Position = normalPosition }):Play()
    else
        closeSelectionPanelInstant()
        local hideTween = ts:Create(mainContainer, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
            { Position = offscreenPosition })
        hideTween:Play()
        hideTween.Completed:Connect(function()
            if not isUIOpen then
                mainContainer.Visible = false
                floatBtn.Visible = true
            end
        end)
    end
end

floatBtn.MouseButton1Click:Connect(function()
    toggleUI(true)
end)

uis.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.RightControl then toggleUI() end
end)

local tabs = {
    {
        name = "Mailer",
        icon = "rbxassetid://10734885430",
        isMailerTab = true
    }
}

-- Close Transition
local function closeLoader()
    f.ClipsDescendants = true
    closeSelectionPanelInstant()
    local t1 = ts:Create(f, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        { Size = u(1, -30, 0, 0), BackgroundTransparency = 1 })
    local t3 = ts:Create(frameStroke, TweenInfo.new(0.3), { Transparency = 1 })
    t1:Play()
    t3:Play()
    t1.Completed:Wait()
    sg:Destroy()
end

-- Close Button
local clBtn = c("TextButton", nb, {
    Size = u(0, 26, 0, 26),
    Position = u(1, -34, 0.5, -13),
    BackgroundColor3 = col(35, 35, 38),
    Text = "×",
    TextColor3 = col(180, 180, 180),
    Font = fontBold,
    TextSize = 18,
    AutoButtonColor = false
})
c("UICorner", clBtn, { CornerRadius = UDim.new(1, 0) })
clBtn.MouseEnter:Connect(function()
    ts:Create(clBtn, TweenInfo.new(0.2), { BackgroundColor3 = col(230, 57, 70), TextColor3 = col(255, 255, 255) }):Play()
end)
clBtn.MouseLeave:Connect(function()
    ts:Create(clBtn, TweenInfo.new(0.2), { BackgroundColor3 = col(35, 35, 38), TextColor3 = col(180, 180, 180) }):Play()
end)
clBtn.MouseButton1Click:Connect(closeLoader)

-- Minimize Button
local minBtn = c("TextButton", nb, {
    Size = u(0, 26, 0, 26),
    Position = u(1, -66, 0.5, -13),
    BackgroundColor3 = col(35, 35, 38),
    Text = "−",
    TextColor3 = col(180, 180, 180),
    Font = fontBold,
    TextSize = 18,
    AutoButtonColor = false
})
c("UICorner", minBtn, { CornerRadius = UDim.new(1, 0) })
minBtn.MouseEnter:Connect(function()
    ts:Create(minBtn, TweenInfo.new(0.2), { BackgroundColor3 = col(50, 50, 53), TextColor3 = col(255, 255, 255) }):Play()
end)
minBtn.MouseLeave:Connect(function()
    ts:Create(minBtn, TweenInfo.new(0.2), { BackgroundColor3 = col(35, 35, 38), TextColor3 = col(180, 180, 180) }):Play()
end)
minBtn.MouseButton1Click:Connect(function()
    toggleUI(false)
end)

local activeFrame, activeBtn = nil, nil
local function getActiveBtn() return activeBtn end



-- Fruit Image URL Map (from growagardencalculator.com)
local FRUIT_IMAGE_BASE = "https://www.growagardencalculator.com/grow-a-garden-2/images/seeds/"
local FRUIT_IMAGE_MAP = {
    ["Acorn"] = "acorn",
    ["Apple"] = "apple",
    ["Baby Cactus"] = "babycactus",
    ["Bamboo"] = "bamboo",
    ["Banana"] = "banana",
    ["Blueberry"] = "blueberry",
    ["Cactus"] = "cactus",
    ["Carrot"] = "carrot",
    ["Cherry"] = "cherry",
    ["Coconut"] = "coconut",
    ["Corn"] = "corn",
    ["Dragon Fruit"] = "dragonfruit",
    ["Dragonfruit"] = "dragonfruit",
    ["Dragons Breath"] = "dragonsbreath",
    ["Dragon's Breath"] = "dragonsbreath",
    ["Dragonsbreath"] = "dragonsbreath",
    ["Fire Fern"] = "firefern",
    ["Firefern"] = "firefern",
    ["Ghost Pepper"] = "ghostpepper",
    ["Ghostpepper"] = "ghostpepper",
    ["Glow Mushroom"] = "glowmushroom",
    ["Glowmushroom"] = "glowmushroom",
    ["Grape"] = "grape",
    ["Green Bean"] = "greenbean",
    ["Greenbean"] = "greenbean",
    ["Horned Melon"] = "hornedmelon",
    ["Hornedmelon"] = "hornedmelon",
    ["Hypno Bloom"] = "hypnobloom",
    ["Hypnobloom"] = "hypnobloom",
    ["Mango"] = "mango",
    ["Moon Bloom"] = "moonbloom",
    ["Moonbloom"] = "moonbloom",
    ["Mushroom"] = "mushroom",
    ["Pineapple"] = "pineapple",
    ["Poison Apple"] = "poisonapple",
    ["Poisonapple"] = "poisonapple",
    ["Poison Ivy"] = "poisonivy",
    ["Poisonivy"] = "poisonivy",
    ["Pomegranate"] = "pomegranate",
    ["Rocket Pop"] = "rocketpop",
    ["Rocketpop"] = "rocketpop",
    ["Strawberry"] = "strawberry",
    ["Sunflower"] = "sunflower",
    ["Tomato"] = "tomato",
    ["Tulip"] = "tulip",
    ["Venom Spitter"] = "venomspitter",
    ["Venomspitter"] = "venomspitter",
    ["Venus Fly Trap"] = "venusflytrap",
    ["Venus Flytrap"] = "venusflytrap",
    ["Venusflytrap"] = "venusflytrap",
}

-- Downloaded image asset cache (avoids re-downloading)
local fruitAssetCache = {}

local function downloadFruitImage(fruitName)
    -- Check memory cache first
    if fruitAssetCache[fruitName] then
        return fruitAssetCache[fruitName]
    end

    -- Normalize: try exact name, then lowercase, then no-spaces lowercase
    local slug = FRUIT_IMAGE_MAP[fruitName]
    if not slug then
        -- Try case-insensitive match
        local lower = fruitName:lower()
        for key, val in pairs(FRUIT_IMAGE_MAP) do
            if key:lower() == lower then
                slug = val
                break
            end
        end
    end
    if not slug then
        -- Last resort: strip spaces and lowercase the name itself
        slug = fruitName:lower():gsub("%s+", "")
    end

    local url = FRUIT_IMAGE_BASE .. slug .. ".webp"
    local fileName = "fruit_cache_" .. slug .. ".webp"

    local ok, asset = pcall(function()
        -- Check if file already exists on disk from a previous session
        if isfile and isfile(fileName) and getcustomasset then
            return getcustomasset(fileName)
        end

        -- Download the image
        local imageData = game:HttpGet(url)
        if not imageData or #imageData < 100 then
            return nil -- Too small, likely a 404 response
        end

        -- Save to executor filesystem
        if writefile then
            writefile(fileName, imageData)
        end

        -- Convert to usable Roblox asset
        if getcustomasset then
            return getcustomasset(fileName)
        end

        return nil
    end)

    if ok and asset and asset ~= "" then
        fruitAssetCache[fruitName] = asset
        return asset
    end

    return nil
end

-- Active photography tracker local registry scan cache
local trackerCache = nil
local function findPhotographyTracker()
    if trackerCache and trackerCache.Parent then
        return trackerCache
    end
    local targetServices = { game:GetService("ReplicatedStorage"), game:GetService("ReplicatedFirst") }
    for _, parent in ipairs(targetServices) do
        local foundObj = parent:FindFirstChild("INTERNAL_PhotographyTracker", true)
        if foundObj then
            trackerCache = foundObj
            return foundObj
        end
    end
    return nil
end

-- Backpack Scanner Utility for Fruits (Natively maps visual texture data)
local function getFruitIcon(fruitName, toolInstance, cachedImage)
    -- 1) Web image download (highest priority - uses growagardencalculator.com)
    local webAsset = downloadFruitImage(fruitName)
    if webAsset then
        return webAsset
    end

    -- 2) Use the image attribute captured directly from the item
    if cachedImage and cachedImage ~= "" then
        local rawId = tostring(cachedImage):match("%d+")
        if rawId then
            return "rbxassetid://" .. rawId
        end
        if tostring(cachedImage):find("rbxassetid://") or tostring(cachedImage):find("rbxthumb://") then
            return tostring(cachedImage)
        end
    end

    -- 3) Check TextureId on any instance type (not just Tools)
    if toolInstance then
        pcall(function()
            if toolInstance:IsA("Tool") and toolInstance.TextureId ~= "" then
                cachedImage = toolInstance.TextureId
            end
        end)
        if cachedImage and cachedImage ~= "" then
            return cachedImage
        end

        -- Check for ImageLabel/Decal children inside the tool/item
        local imgChild = toolInstance:FindFirstChildWhichIsA("Decal", true)
            or toolInstance:FindFirstChildWhichIsA("ImageLabel", true)
        if imgChild then
            local img = imgChild:IsA("Decal") and imgChild.Texture or imgChild.Image
            if img and img ~= "" then
                return img
            end
        end
    end

    -- 4) Dynamic photography tracker database resolution
    local tracker = findPhotographyTracker()
    if tracker then
        local formattedName = "fruit_" .. tostring(fruitName):gsub("%s+", "_")
        local valueObj = tracker:FindFirstChild(formattedName)
        if valueObj and valueObj.Value then
            local rawId = tostring(valueObj.Value):match("%d+")
            if rawId then
                return "rbxassetid://" .. rawId
            end
        end
    end

    -- 5) SeedData module lookup (use pairs for dictionary support)
    local ok2, result = pcall(function()
        local shared = game:GetService("ReplicatedStorage"):FindFirstChild("SharedModules")
        local seedDataMod = shared and shared:FindFirstChild("SeedData")
        if seedDataMod then
            local success, seedData = pcall(require, seedDataMod)
            if success and type(seedData) == "table" then
                for key, data in pairs(seedData) do
                    local seedName = type(data) == "table" and (data.SeedName or data.Name or data.FruitName) or nil
                    if seedName == fruitName or tostring(key) == fruitName then
                        local img = type(data) == "table" and
                        (data.FruitImage or data.SeedImage or data.Icon or data.Image) or nil
                        if img then
                            if typeof(img) == "Instance" then
                                if img:IsA("ImageLabel") or img:IsA("ImageButton") then return img.Image end
                                if img:IsA("Decal") then return img.Texture end
                            end
                            local id = tostring(img):match("%d+")
                            if id then
                                return "rbxassetid://" .. id
                            end
                        end
                    end
                end
            end
        end
        return nil
    end)
    if ok2 and result then return result end

    -- 6) Fallback: no image found
    return ""
end

-- Scans both equipped hotbar tools and unequipped backpack tools/data proxies
local function scanFruits()
    local fruits = {}
    local backpack = p:FindFirstChild("Backpack")
    local char = p.Character

    local function processItem(item)
        if typeof(item) == "Instance" then
            local name = item:GetAttribute("FruitName") or item:GetAttribute("Fruit")
            local id = item:GetAttribute("Id")
            if name and id then
                local weightAttr = item:GetAttribute("weight") or item:GetAttribute("Weight") or item:GetAttribute("KG") or
                    item:GetAttribute("Kg") or 0
                local mutationAttr = item:GetAttribute("Mutation") or item:GetAttribute("Mutations") or "None"
                local numWeight = tonumber(weightAttr) or 0
                local roundedWeight = math.floor(numWeight * 100 + 0.5) / 100

                -- Capture image attribute directly from item if available
                local imageAttr = item:GetAttribute("Image") or item:GetAttribute("Icon")
                    or item:GetAttribute("FruitImage") or item:GetAttribute("TextureId")
                    or item:GetAttribute("Texture") or item:GetAttribute("SeedImage")

                table.insert(fruits, {
                    instance = item,
                    id = tostring(id),
                    name = tostring(name),
                    weight = roundedWeight,
                    mutation = tostring(mutationAttr),
                    image = imageAttr and tostring(imageAttr) or nil
                })
            end
        end
    end

    if backpack then
        for _, item in ipairs(backpack:GetChildren()) do
            processItem(item)
        end
    end
    if char then
        for _, item in ipairs(char:GetChildren()) do
            processItem(item)
        end
    end
    return fruits
end

-- Global Fruit Selection Maps
local selectedFruitsMap = {}
local currentScannedFruits = {}
local selectedCounter = nil

local function updateSelectedCounter()
    if not selectedCounter then return end
    local count = 0
    local totalVal = 0
    local scannedIds = {}
    for _, fruit in ipairs(currentScannedFruits) do
        scannedIds[fruit.id] = true
        if selectedFruitsMap[fruit.id] then
            count = count + 1
            totalVal = totalVal + getFruitPrice(fruit.name, fruit.instance, currentMultiplierMode)
        end
    end
    for id in pairs(selectedFruitsMap) do
        if not scannedIds[id] then
            selectedFruitsMap[id] = nil
        end
    end
    
    local batches = math.ceil(count / 20)
    selectedCounter.Text = "Fruits selected: " .. count .. " (" .. batches .. " batch" .. (batches == 1 and "" or "es") .. ")"
    
    if totalValueLabel then
        totalValueLabel.Text = "Total Value: $" .. formatPrice(totalVal)
    end
end

-- Cell Cache to avoid constant destruction/creation of UI elements
local cellCache = {}

-- Grid Population Function (Instantiates Squared Items with Texture Support)
local function populateSelectionGrid()
    currentScannedFruits = scanFruits()

    -- Hide all cached cells first
    for _, cell in pairs(cellCache) do
        cell.Visible = false
    end

    -- Handle empty state
    local emptyLbl = gridScroller:FindFirstChild("EmptyLabel")
    if #currentScannedFruits == 0 then
        if not emptyLbl then
            emptyLbl = c("TextLabel", gridScroller, {
                Name = "EmptyLabel",
                Size = u(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = "No fruits found",
                TextColor3 = col(140, 140, 140),
                Font = fontRegular,
                TextSize = 11,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center
            })
        end
        emptyLbl.Visible = true
        return
    else
        if emptyLbl then emptyLbl.Visible = false end
    end

    for _, fruit in ipairs(currentScannedFruits) do
        local cell = cellCache[fruit.id]
        local isSelected = selectedFruitsMap[fruit.id] == true
        local price = getFruitPrice(fruit.name, fruit.instance, currentMultiplierMode)

        if not cell or not cell.Parent then
            cell = c("TextButton", gridScroller, {
                Size = u(0, 52, 0, 68),
                BackgroundColor3 = col(28, 28, 30),
                Text = "",
                AutoButtonColor = false,
                Name = fruit.id
            })
            c("UICorner", cell, { CornerRadius = UDim.new(0, 6) })
            
            local cellStroke = c("UIStroke", cell, {
                Color = isSelected and accentColor or col(40, 40, 40),
                Thickness = isSelected and 2 or 1
            })
            if isSelected then
                registerThemeElement(cellStroke, "Color")
            end

            local imgId = getFruitIcon(fruit.name, fruit.instance, fruit.image)
            local imgLabel = c("ImageLabel", cell, {
                Size = u(0, 36, 0, 36),
                Position = u(0.5, -18, 0, 6),
                BackgroundTransparency = 1,
                Image = imgId,
                ScaleType = Enum.ScaleType.Fit
            })
            if imgId == "" then
                imgLabel.Visible = false
                c("TextLabel", cell, {
                    Size = u(0, 36, 0, 36),
                    Position = u(0.5, -18, 0, 6),
                    BackgroundTransparency = 1,
                    Text = string.sub(fruit.name, 1, 2):upper(),
                    TextColor3 = accentColor,
                    Font = fontBold,
                    TextSize = 16,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    TextYAlignment = Enum.TextYAlignment.Center
                })
            end

            local cellLbl = c("TextLabel", cell, {
                Size = u(1, -4, 0, 20),
                Position = u(0, 2, 1, -22),
                BackgroundTransparency = 1,
                Text = string.format("%s\n%.1fkg • $%s", fruit.name, fruit.weight, formatPrice(price)),
                TextColor3 = isSelected and col(255, 255, 255) or col(140, 140, 140),
                Font = fontRegular,
                TextSize = 8,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center,
                LineHeight = 0.95
            })

            cell.MouseEnter:Connect(function()
                if not selectedFruitsMap[fruit.id] then
                    ts:Create(cellStroke, TweenInfo.new(0.2), { Color = lightenColor(accentColor, -30) }):Play()
                end
            end)
            cell.MouseLeave:Connect(function()
                if not selectedFruitsMap[fruit.id] then
                    ts:Create(cellStroke, TweenInfo.new(0.2), { Color = col(40, 40, 40) }):Play()
                end
            end)

            cell.MouseButton1Click:Connect(function()
                local nowSelected = not selectedFruitsMap[fruit.id]
                if nowSelected then
                    selectedFruitsMap[fruit.id] = true
                    cellStroke.Color = accentColor
                    cellStroke.Thickness = 2
                    registerThemeElement(cellStroke, "Color")
                    cellLbl.TextColor3 = col(255, 255, 255)
                else
                    selectedFruitsMap[fruit.id] = nil
                    cellStroke.Color = col(40, 40, 40)
                    cellStroke.Thickness = 1
                    cellLbl.TextColor3 = col(140, 140, 140)
                end
                updateSelectedCounter()
            end)

            cellCache[fruit.id] = cell
        else
            local cellStroke = cell:FindFirstChildOfClass("UIStroke")
            if cellStroke then
                cellStroke.Color = isSelected and accentColor or col(40, 40, 40)
                cellStroke.Thickness = isSelected and 2 or 1
            end
            local cellLbl = cell:FindFirstChildOfClass("TextLabel")
            if cellLbl then
                cellLbl.Text = string.format("%s\n%.1fkg • $%s", fruit.name, fruit.weight, formatPrice(price))
                cellLbl.TextColor3 = isSelected and col(255, 255, 255) or col(140, 140, 140)
            end
        end
        cell.Visible = true
    end
end

-- Smooth Sliding Panel Toggle Mechanism
local function toggleSelectionPanel()
    isPanelOpen = not isPanelOpen
    if isPanelOpen then
        populateSelectionGrid()
        selectionPanel.Visible = true
        ts:Create(selectionPanel, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Position = u(0, 515, 0, 15) -- Moves side panel into visible view gap right of f (10px gap)
        }):Play()
    else
        local tween = ts:Create(selectionPanel, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
            Position = u(0, 290, 0, 15) -- slides back safe under main f
        })
        tween:Play()
        tween.Completed:Connect(function()
            if not isPanelOpen then
                selectionPanel.Visible = false
            end
        end)
    end
end

-- Background Sync Loop (Auto refreshes every 1 second to keep selections up-to-date)
task.spawn(function()
    while task.wait(1) do
        if isUIOpen then
            pcall(function()
                currentScannedFruits = scanFruits()
                updateSelectedCounter()
                if isPanelOpen then
                    populateSelectionGrid()
                end
            end)
        end
    end
end)

for i, tdata in ipairs(tabs) do
    local sf = c("ScrollingFrame", container, {
        Size = u(1, 0, 1, 0),
        BackgroundTransparency = 1,
        CanvasSize = u(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = col(60, 60, 60),
        Visible = (i == 1),
        CanvasPosition = Vector2.new(0, 0)
    })
    c("UIListLayout", sf, { Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder })
    c("UIPadding", sf, { PaddingRight = UDim.new(0, 4) })

    -- Tab Buttons
    local tb = c("TextButton", sb, {
        Size = u(1, 0, 0, 34),
        BackgroundColor3 = (i == 1) and col(35, 35, 38) or col(28, 28, 30),
        Text = "",
        BorderSizePixel = 0,
        AutoButtonColor = false
    })
    c("UICorner", tb, { CornerRadius = UDim.new(0, 6) })

    local indicator = c("Frame", tb, {
        Size = u(0, 3, 0, 14),
        Position = u(0, 6, 0.5, -7),
        BackgroundColor3 = accentColor,
        BorderSizePixel = 0,
        Visible = (i == 1)
    })
    c("UICorner", indicator, { CornerRadius = UDim.new(1, 0) })
    registerThemeElement(indicator, "BackgroundColor3")

    local iconImg = c("ImageLabel", tb, {
        Size = u(0, 16, 0, 16),
        Position = u(0, 14, 0.5, -8),
        BackgroundTransparency = 1,
        Image = tdata.icon,
        ImageColor3 = (i == 1) and col(255, 255, 255) or col(140, 140, 140)
    })

    local btnTxt = c("TextLabel", tb, {
        Size = u(1, -38, 1, 0),
        Position = u(0, 36, 0, 0),
        BackgroundTransparency = 1,
        Text = tdata.name,
        TextColor3 = (i == 1) and col(255, 255, 255) or col(140, 140, 140),
        Font = fontBold,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    tb.MouseEnter:Connect(function()
        if getActiveBtn() ~= tb then ts:Create(tb, TweenInfo.new(0.2), { BackgroundColor3 = col(38, 38, 42) }):Play() end
    end)
    tb.MouseLeave:Connect(function()
        if getActiveBtn() ~= tb then ts:Create(tb, TweenInfo.new(0.2), { BackgroundColor3 = col(28, 28, 30) }):Play() end
    end)

    tb.MouseButton1Click:Connect(function()
        if activeFrame then
            activeFrame.Visible = false
            ts:Create(activeBtn, TweenInfo.new(0.2), { BackgroundColor3 = col(28, 28, 30) }):Play()

            local prevInd = activeBtn:FindFirstChild("Frame")
            if prevInd then prevInd.Visible = false end

            local prevTxt = activeBtn:FindFirstChild("TextLabel")
            local prevImg = activeBtn:FindFirstChild("ImageLabel")
            if prevTxt then ts:Create(prevTxt, TweenInfo.new(0.2), { TextColor3 = col(140, 140, 140) }):Play() end
            if prevImg then ts:Create(prevImg, TweenInfo.new(0.2), { ImageColor3 = col(140, 140, 140) }):Play() end
        end
        sf.Visible = true
        ts:Create(tb, TweenInfo.new(0.2), { BackgroundColor3 = col(35, 35, 38) }):Play()

        local curInd = tb:FindFirstChild("Frame")
        if curInd then curInd.Visible = true end

        local curTxt = tb:FindFirstChild("TextLabel")
        local curImg = tb:FindFirstChild("ImageLabel")
        if curTxt then ts:Create(curTxt, TweenInfo.new(0.2), { TextColor3 = col(255, 255, 255) }):Play() end
        if curImg then ts:Create(curImg, TweenInfo.new(0.2), { ImageColor3 = col(255, 255, 255) }):Play() end

        activeFrame = sf
        activeBtn = tb

        closeSelectionPanelInstant()
    end)

    if tdata.isMailerTab then
        -- Recipient Info Section Header
        c("TextLabel", sf, {
            Size = u(1, 0, 0, 18),
            BackgroundTransparency = 1,
            Text = "Recipient Information",
            TextColor3 = col(150, 150, 150),
            Font = fontBold,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            LayoutOrder = 1
        })

        -- Recipient Username Input Box
        local userBox = c("TextBox", sf, {
            Size = u(1, 0, 0, 32),
            BackgroundColor3 = col(28, 28, 30),
            PlaceholderText = "Username",
            PlaceholderColor3 = col(100, 100, 100),
            Text = "",
            TextColor3 = col(230, 230, 230),
            Font = fontRegular,
            TextSize = 12,
            ClearTextOnFocus = false,
            BorderSizePixel = 0,
            LayoutOrder = 2
        })
        c("UICorner", userBox, { CornerRadius = UDim.new(0, 6) })
        c("UIStroke", userBox, { Color = col(40, 40, 40), Thickness = 1 })

        -- Optional Note Message
        local noteBox = c("TextBox", sf, {
            Size = u(1, 0, 0, 32),
            BackgroundColor3 = col(28, 28, 30),
            PlaceholderText = "Message (Optional)",
            PlaceholderColor3 = col(100, 100, 100),
            Text = "",
            TextColor3 = col(230, 230, 230),
            Font = fontRegular,
            TextSize = 12,
            ClearTextOnFocus = false,
            BorderSizePixel = 0,
            LayoutOrder = 3
        })
        c("UICorner", noteBox, { CornerRadius = UDim.new(0, 6) })
        c("UIStroke", noteBox, { Color = col(40, 40, 40), Thickness = 1 })

        -- Action Rows Container (Excluding refresh button)
        local actionRow = c("Frame", sf, {
            Size = u(1, 0, 0, 28),
            BackgroundTransparency = 1,
            LayoutOrder = 4
        })
        c("UIListLayout", actionRow, {
            FillDirection = Enum.FillDirection.Horizontal,
            Padding = UDim.new(0, 8),
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        })

        local selAllBtn = c("TextButton", actionRow, {
            Size = u(0, 100, 1, 0),
            BackgroundColor3 = col(35, 35, 38),
            Text = "Select All",
            TextColor3 = col(200, 200, 200),
            Font = fontBold,
            TextSize = 11,
            AutoButtonColor = false,
            LayoutOrder = 1
        })
        c("UICorner", selAllBtn, { CornerRadius = UDim.new(0, 4) })
        applyHoverEffect(selAllBtn, col(35, 35, 38), col(45, 45, 48))

        local deselAllBtn = c("TextButton", actionRow, {
            Size = u(0, 100, 1, 0),
            BackgroundColor3 = col(35, 35, 38),
            Text = "Clear All",
            TextColor3 = col(200, 200, 200),
            Font = fontBold,
            TextSize = 11,
            AutoButtonColor = false,
            LayoutOrder = 2
        })
        c("UICorner", deselAllBtn, { CornerRadius = UDim.new(0, 4) })
        applyHoverEffect(deselAllBtn, col(35, 35, 38), col(45, 45, 48))

        -- Inventory Selection Header
        c("TextLabel", sf, {
            Size = u(1, 0, 0, 18),
            BackgroundTransparency = 1,
            Text = "Fruit Selection",
            TextColor3 = col(150, 150, 150),
            Font = fontBold,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            LayoutOrder = 5
        })

        -- Dedicated Side Panel Toggle Button
        local selectFruitsBtn = c("TextButton", sf, {
            Size = u(1, 0, 0, 34),
            BackgroundColor3 = col(35, 35, 38),
            Text = "Select Fruits",
            TextColor3 = col(220, 220, 220),
            Font = fontBold,
            TextSize = 12,
            AutoButtonColor = false,
            LayoutOrder = 6
        })
        c("UICorner", selectFruitsBtn, { CornerRadius = UDim.new(0, 6) })
        applyHoverEffect(selectFruitsBtn, col(35, 35, 38), col(45, 45, 48))

        selectedCounter = c("TextLabel", sf, {
            Size = u(1, 0, 0, 20),
            BackgroundTransparency = 1,
            Text = "Fruits selected: 0",
            TextColor3 = col(150, 150, 150),
            Font = fontRegular,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            LayoutOrder = 7
        })

        -- Main Send Button
        local sendBtn = c("TextButton", sf, {
            Size = u(1, 0, 0, 36),
            BackgroundColor3 = accentColor,
            Text = "Send Selected Fruits",
            TextColor3 = col(255, 255, 255),
            Font = fontBold,
            TextSize = 12,
            BorderSizePixel = 0,
            AutoButtonColor = false,
            LayoutOrder = 8
        })
        c("UICorner", sendBtn, { CornerRadius = UDim.new(0, 6) })
        registerThemeElement(sendBtn, "BackgroundColor3")

        sendBtn.MouseEnter:Connect(function()
            ts:Create(sendBtn, TweenInfo.new(0.2), { BackgroundColor3 = lightenColor(accentColor, 15) }):Play()
        end)
        sendBtn.MouseLeave:Connect(function()
            ts:Create(sendBtn, TweenInfo.new(0.2), { BackgroundColor3 = accentColor }):Play()
        end)

        selectFruitsBtn.MouseButton1Click:Connect(toggleSelectionPanel)

        selAllBtn.MouseButton1Click:Connect(function()
            for _, fruit in ipairs(currentScannedFruits) do
                selectedFruitsMap[fruit.id] = true
            end
            populateSelectionGrid()
            updateSelectedCounter()
            showToast("Selected all fruits", true)
        end)

        deselAllBtn.MouseButton1Click:Connect(function()
            table.clear(selectedFruitsMap)
            populateSelectionGrid()
            updateSelectedCounter()
            showToast("Selection cleared", false)
        end)

        -- Initial scanner read
        populateSelectionGrid()

        -- Process batch send
        sendBtn.MouseButton1Click:Connect(function()
            local rawUser = userBox.Text
            local note = noteBox.Text
            local username = E.Mail.CleanUsername(rawUser)

            if username == "" then
                showToast("Error: No Username Entered", false)
                return
            end

            local fruitsToSend = {}
            for _, fruit in ipairs(currentScannedFruits) do
                if selectedFruitsMap[fruit.id] then
                    table.insert(fruitsToSend, fruit)
                end
            end

            if #fruitsToSend == 0 then
                showToast("Error: No fruits selected", false)
                return
            end

            showToast("Verifying Username...", true)

            task.spawn(function()
                local recipient, err = E.Mail.LookupRecipient(username)
                if not recipient then
                    showToast("Error: " .. tostring(err or "Player not found"), false)
                    return
                end

                -- Utility to split the fruits into groups of a specific size limit
                local function chunkTable(t, limit)
                    local chunks = {}
                    for i = 1, #t, limit do
                        local chunk = {}
                        for j = i, math.min(i + limit - 1, #t) do
                            table.insert(chunk, t[j])
                        end
                        table.insert(chunks, chunk)
                    end
                    return chunks
                end

                local fruitChunks = chunkTable(fruitsToSend, 20)
                local totalBatches = #fruitChunks

                showToast("Sending " .. #fruitsToSend .. " fruits in " .. totalBatches .. " batch(es)...", true)

                local overallSuccess = true
                for index, chunk in ipairs(fruitChunks) do
                    showToast("Mailing batch " .. index .. "/" .. totalBatches .. "...", true)
                    
                    local success, resultMessage = E.Mail.SendFruitBatch(recipient, chunk, note)
                    if success then
                        -- Remove successfully sent items from the local list
                        for _, fruit in ipairs(chunk) do
                            selectedFruitsMap[fruit.id] = nil
                        end
                    else
                        overallSuccess = false
                        showToast("Batch " .. index .. " failed: " .. tostring(resultMessage), false)
                        -- Stop executing subsequent batches on error to preserve remaining inventory
                        break
                    end
                    
                    -- A standard pause between network calls is applied to prevent server congestion
                    if index < totalBatches then
                        task.wait(0.8)
                    end
                end

                if overallSuccess then
                    showToast("All batches sent successfully!", true)
                end

                task.wait(0.2)
                populateSelectionGrid()
                updateSelectedCounter()
            end)
        end)
    end
end
