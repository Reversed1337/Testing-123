-- Load the Orion UI Library
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

-- Font Configuration
local fontRegular = Enum.Font.Montserrat
local fontBold = Enum.Font.MontserratBold

local p = game:GetService("Players").LocalPlayer or game:GetService("Players").PlayerAdded:Wait()
local ts = game:GetService("TweenService")
local hs = game:GetService("HttpService")
local uis = game:GetService("UserInputService")
local u, col = UDim2.new, Color3.fromRGB

-- Helper to instantiate standard components
local function c(cl, pr, prp)
    local o = Instance.new(cl)
    for k, v in pairs(prp or {}) do o[k] = v end
    o.Parent = pr
    return o
end

local accentColor = col(127, 90, 240) -- Violet Theme

-- Theme Registry
local themeElements = {}
local function registerThemeElement(elem, prop)
    table.insert(themeElements, { elem = elem, prop = prop })
    if elem[prop] then elem[prop] = accentColor end
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

local function scanFruits()
    local fruits = {}
    local backpack = p:FindFirstChild("Backpack")
    local char = p.Character

    local function processItem(item)
        if typeof(item) == "Instance" then
            local name = item:GetAttribute("FruitName") or item:GetAttribute("Fruit")
            local id = item:GetAttribute("Id")
            if name and id then
                local weightAttr = item:GetAttribute("weight") or item:GetAttribute("Weight") or item:GetAttribute("KG") or item:GetAttribute("Kg") or 0
                local mutationAttr = item:GetAttribute("Mutation") or item:GetAttribute("Mutations") or "None"
                local numWeight = tonumber(weightAttr) or 0
                local roundedWeight = math.floor(numWeight * 100 + 0.5) / 100

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

    if backpack then for _, item in ipairs(backpack:GetChildren()) do processItem(item) end end
    if char then for _, item in ipairs(char:GetChildren()) do processItem(item) end end
    return fruits
end

-- Custom Selection Panel References
local orionGui = nil
local orionMain = nil
local selectionPanel = nil
local gridScroller = nil
local panelTitle = nil
local multToggleBtn = nil
local totalValueLabel = nil
local gridLayout = nil
local floatBtn = nil

local selectedFruitsMap = {}
local currentScannedFruits = {}
local selectedCounter = nil

local function showToast(msg, isSuccess)
    OrionLib:MakeNotification({
        Name = isSuccess and "Onyx Mailer" or "Mailer Error",
        Content = msg,
        Time = 3,
        Image = "rbxassetid://10734885430"
    })
end

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
    selectedCounter:Set("Fruits selected: " .. count .. " (" .. batches .. " batch" .. (batches == 1 and "" or "es") .. ")")
    
    if totalValueLabel then
        totalValueLabel.Text = "Total Value: $" .. formatPrice(totalVal)
    end
end

-- Cell caching limits layout overhead
local cellCache = {}

-- Fruit Image URL Map (from growagardencalculator.com)
local FRUIT_IMAGE_BASE = "https://www.growagardencalculator.com/grow-a-garden-2/images/seeds/"
local FRUIT_IMAGE_MAP = {
    ["Acorn"] = "acorn", ["Apple"] = "apple", ["Baby Cactus"] = "babycactus", ["Bamboo"] = "bamboo",
    ["Banana"] = "banana", ["Blueberry"] = "blueberry", ["Cactus"] = "cactus", ["Carrot"] = "carrot",
    ["Cherry"] = "cherry", ["Coconut"] = "coconut", ["Corn"] = "corn", ["Dragon Fruit"] = "dragonfruit",
    ["Dragonfruit"] = "dragonfruit", ["Dragons Breath"] = "dragonsbreath", ["Dragon's Breath"] = "dragonsbreath",
    ["Dragonsbreath"] = "dragonsbreath", ["Fire Fern"] = "firefern", ["Firefern"] = "firefern",
    ["Ghost Pepper"] = "ghostpepper", ["Ghostpepper"] = "ghostpepper", ["Glow Mushroom"] = "glowmushroom",
    ["Glowmushroom"] = "glowmushroom", ["Grape"] = "grape", ["Green Bean"] = "greenbean",
    ["Greenbean"] = "greenbean", ["Horned Melon"] = "hornedmelon", ["Hornedmelon"] = "hornedmelon",
    ["Hypno Bloom"] = "hypnobloom", ["Hypnobloom"] = "hypnobloom", ["Mango"] = "mango",
    ["Moon Bloom"] = "moonbloom", ["Moonbloom"] = "moonbloom", ["Mushroom"] = "mushroom",
    ["Pineapple"] = "pineapple", ["Poison Apple"] = "poisonapple", ["Poisonapple"] = "poisonapple",
    ["Poison Ivy"] = "poisonivy", ["Poisonivy"] = "poisonivy", ["Pomegranate"] = "pomegranate",
    ["Rocket Pop"] = "rocketpop", ["Rocketpop"] = "rocketpop", ["Strawberry"] = "strawberry",
    ["Sunflower"] = "sunflower", ["Tomato"] = "tomato", ["Tulip"] = "tulip", ["Venom Spitter"] = "venomspitter",
    ["Venomspitter"] = "venomspitter", ["Venus Fly Trap"] = "venusflytrap", ["Venus Flytrap"] = "venusflytrap",
    ["Venusflytrap"] = "venusflytrap"
}

local fruitAssetCache = {}
local function downloadFruitImage(fruitName)
    if fruitAssetCache[fruitName] then return fruitAssetCache[fruitName] end
    local slug = FRUIT_IMAGE_MAP[fruitName]
    if not slug then
        local lower = fruitName:lower()
        for key, val in pairs(FRUIT_IMAGE_MAP) do
            if key:lower() == lower then slug = val break end
        end
    end
    if not slug then slug = fruitName:lower():gsub("%s+", "") end
    local url = FRUIT_IMAGE_BASE .. slug .. ".webp"
    local fileName = "fruit_cache_" .. slug .. ".webp"

    local ok, asset = pcall(function()
        if isfile and isfile(fileName) and getcustomasset then
            return getcustomasset(fileName)
        end
        local imageData = game:HttpGet(url)
        if not imageData or #imageData < 100 then return nil end
        if writefile then writefile(fileName, imageData) end
        if getcustomasset then return getcustomasset(fileName) end
        return nil
    end)
    if ok and asset and asset ~= "" then
        fruitAssetCache[fruitName] = asset
        return asset
    end
    return nil
end

local trackerCache = nil
local function findPhotographyTracker()
    if trackerCache and trackerCache.Parent then return trackerCache end
    local targetServices = { game:GetService("ReplicatedStorage"), game:GetService("ReplicatedFirst") }
    for _, parent in ipairs(targetServices) do
        local foundObj = parent:FindFirstChild("INTERNAL_PhotographyTracker", true)
        if foundObj then trackerCache = foundObj return foundObj end
    end
    return nil
end

local function getFruitIcon(fruitName, toolInstance, cachedImage)
    local webAsset = downloadFruitImage(fruitName)
    if webAsset then return webAsset end
    if cachedImage and cachedImage ~= "" then
        local rawId = tostring(cachedImage):match("%d+")
        if rawId then return "rbxassetid://" .. rawId end
        if tostring(cachedImage):find("rbxassetid://") or tostring(cachedImage):find("rbxthumb://") then
            return tostring(cachedImage)
        end
    end
    if toolInstance then
        pcall(function()
            if toolInstance:IsA("Tool") and toolInstance.TextureId ~= "" then
                cachedImage = toolInstance.TextureId
            end
        end)
        if cachedImage and cachedImage ~= "" then return cachedImage end
        local imgChild = toolInstance:FindFirstChildWhichIsA("Decal", true) or toolInstance:FindFirstChildWhichIsA("ImageLabel", true)
        if imgChild then
            local img = imgChild:IsA("Decal") and imgChild.Texture or imgChild.Image
            if img and img ~= "" then return img end
        end
    end
    local tracker = findPhotographyTracker()
    if tracker then
        local formattedName = "fruit_" .. tostring(fruitName):gsub("%s+", "_")
        local valueObj = tracker:FindFirstChild(formattedName)
        if valueObj and valueObj.Value then
            local rawId = tostring(valueObj.Value):match("%d+")
            if rawId then return "rbxassetid://" .. rawId end
        end
    end
    return ""
end

local function populateSelectionGrid()
    if not gridScroller then return end
    currentScannedFruits = scanFruits()

    for _, cell in pairs(cellCache) do
        cell.Visible = false
    end

    local emptyLbl = gridScroller:FindFirstChild("EmptyLabel")
    if #currentScannedFruits == 0 then
        if not emptyLbl then
            emptyLbl = c("TextLabel", gridScroller, {
                Name = "EmptyLabel", Size = u(1, 0, 1, 0), BackgroundTransparency = 1,
                Text = "No fruits found", TextColor3 = col(140, 140, 140),
                Font = fontRegular, TextSize = 11, ZIndex = 2
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
                Size = u(0, 52, 0, 68), BackgroundColor3 = col(28, 28, 30),
                Text = "", AutoButtonColor = false, Name = fruit.id, ZIndex = 2
            })
            c("UICorner", cell, { CornerRadius = UDim.new(0, 6) })
            
            local cellStroke = c("UIStroke", cell, {
                Color = isSelected and accentColor or col(40, 40, 40),
                Thickness = isSelected and 2 or 1,
                ZIndex = 2
            })
            if isSelected then registerThemeElement(cellStroke, "Color") end

            local imgId = getFruitIcon(fruit.name, fruit.instance, fruit.image)
            local imgLabel = c("ImageLabel", cell, {
                Size = u(0, 36, 0, 36), Position = u(0.5, -18, 0, 6),
                BackgroundTransparency = 1, Image = imgId, ScaleType = Enum.ScaleType.Fit, ZIndex = 3
            })
            if imgId == "" then
                imgLabel.Visible = false
                c("TextLabel", cell, {
                    Size = u(0, 36, 0, 36), Position = u(0.5, -18, 0, 6),
                    BackgroundTransparency = 1, Text = string.sub(fruit.name, 1, 2):upper(),
                    TextColor3 = accentColor, Font = fontBold, TextSize = 16, ZIndex = 3
                })
            end

            local cellLbl = c("TextLabel", cell, {
                Size = u(1, -4, 0, 20), Position = u(0, 2, 1, -22),
                BackgroundTransparency = 1,
                Text = string.format("%s\n%.1fkg • $%s", fruit.name, fruit.weight, formatPrice(price)),
                TextColor3 = isSelected and col(255, 255, 255) or col(140, 140, 140),
                Font = fontRegular, TextSize = 8, ZIndex = 3, LineHeight = 0.95
            })

            local function applyHoverEffect(btn, baseCol, hoverCol)
                btn.MouseEnter:Connect(function()
                    ts:Create(btn, TweenInfo.new(0.2), { BackgroundColor3 = hoverCol }):Play()
                end)
                btn.MouseLeave:Connect(function()
                    ts:Create(btn, TweenInfo.new(0.2), { BackgroundColor3 = baseCol }):Play()
                end)
            end

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

-- Sliding Panel Animation Controls
local isPanelOpen = false
local function closeSelectionPanelInstant()
    isPanelOpen = false
    if selectionPanel then
        selectionPanel.Position = u(0.5, -100, 0, 0)
        selectionPanel.Visible = false
    end
end

local function toggleSelectionPanel()
    if not selectionPanel then return end
    isPanelOpen = not isPanelOpen
    if isPanelOpen then
        populateSelectionGrid()
        selectionPanel.Visible = true
        ts:Create(selectionPanel, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            Position = u(1, 10, 0, 0) -- Slides outside Orion frame borders cleanly
        }):Play()
    else
        local tween = ts:Create(selectionPanel, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
            Position = u(0.5, -100, 0, 0)
        })
        tween:Play()
        tween.Completed:Connect(function()
            if not isPanelOpen then
                selectionPanel.Visible = false
            end
        end)
    end
end

-- Initialize the Orion UI Window & Elements FIRST
local Window = OrionLib:MakeWindow({Name = "Onyx Mailer", HidePremium = true, SaveConfig = false})

local MailerTab = Window:MakeTab({
    Name = "Mailer",
    Icon = "rbxassetid://10734885430",
    PremiumOnly = false
})

-- Re-implement input fields and actions natively inside Orion's Tab structure
local recipientUsername = ""
local mailMessage = ""

MailerTab:AddSection({ Name = "Recipient Information" })

MailerTab:AddTextbox({
    Name = "Username",
    Default = "",
    TextDisappear = false,
    Callback = function(Value)
        recipientUsername = Value
    end
})

MailerTab:AddTextbox({
    Name = "Message (Optional)",
    Default = "",
    TextDisappear = false,
    Callback = function(Value)
        mailMessage = Value
    end
})

MailerTab:AddSection({ Name = "Fruit Selection Options" })

MailerTab:AddButton({
    Name = "Select Fruits",
    Callback = toggleSelectionPanel
})

MailerTab:AddButton({
    Name = "Select All",
    Callback = function()
        for _, fruit in ipairs(currentScannedFruits) do
            selectedFruitsMap[fruit.id] = true
        end
        populateSelectionGrid()
        updateSelectedCounter()
        showToast("Selected all fruits", true)
    end
})

MailerTab:AddButton({
    Name = "Clear All",
    Callback = function()
        table.clear(selectedFruitsMap)
        populateSelectionGrid()
        updateSelectedCounter()
        showToast("Selection cleared", false)
    end
})

selectedCounter = MailerTab:AddLabel("Fruits selected: 0")

MailerTab:AddSection({ Name = "Transmission" })

MailerTab:AddButton({
    Name = "Send Selected Fruits",
    Callback = function()
        local username = E.Mail.CleanUsername(recipientUsername)

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
                
                local success, resultMessage = E.Mail.SendFruitBatch(recipient, chunk, mailMessage)
                if success then
                    for _, fruit in ipairs(chunk) do
                        selectedFruitsMap[fruit.id] = nil
                    end
                else
                    overallSuccess = false
                    showToast("Batch " .. index .. " failed: " .. tostring(resultMessage), false)
                    break
                end
                
                if index < totalBatches then
                    showToast("Waiting 10s cooldown...", true)
                    task.wait(10)
                end
            end

            if overallSuccess then
                showToast("All batches sent successfully!", true)
            end

            task.wait(0.2)
            populateSelectionGrid()
            updateSelectedCounter()
        end)
    end
})

-- Initialize the Orion Framework
OrionLib:Init()

-- ASYNCHRONOUS INJECTION LOGIC (Starts after window initialized to avoid thread yields)
task.spawn(function()
    orionGui = game:GetService("CoreGui"):WaitForChild("Orion", 15) or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Orion", 15)
    if not orionGui then return end

    orionMain = orionGui:WaitForChild("Main", 15)
    if not orionMain then return end

    orionMain.ClipsDescendants = false

    -- Re-create the sliding fruit list panel as a child of Orion Main
    selectionPanel = c("Frame", orionMain, {
        Size = u(0, 200, 1, 0),
        Position = u(0.5, -100, 0, 0),
        BackgroundColor3 = col(23, 23, 23),
        BorderSizePixel = 0,
        Visible = false,
        ClipsDescendants = true,
        ZIndex = 0
    })
    c("UICorner", selectionPanel, { CornerRadius = UDim.new(0, 8) })
    local panelStroke = c("UIStroke", selectionPanel, { Color = col(40, 40, 40), Thickness = 1, Transparency = 0.5 })
    registerThemeElement(panelStroke, "Color")

    panelTitle = c("TextLabel", selectionPanel, {
        Size = u(1, 0, 0, 24),
        Position = u(0, 0, 0, 8),
        BackgroundTransparency = 1,
        Text = "Select Fruits",
        TextColor3 = col(240, 240, 240),
        Font = fontBold,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Center,
        ZIndex = 1
    })

    multToggleBtn = c("TextButton", selectionPanel, {
        Size = u(1, -24, 0, 20),
        Position = u(0, 12, 0, 32),
        BackgroundColor3 = col(35, 35, 38),
        Text = "Mode: LIVE X",
        TextColor3 = col(220, 220, 220),
        Font = fontBold,
        TextSize = 9,
        AutoButtonColor = false,
        ZIndex = 1
    })
    c("UICorner", multToggleBtn, { CornerRadius = UDim.new(0, 4) })
    
    local function applyHoverEffect(btn, baseCol, hoverCol)
        btn.MouseEnter:Connect(function()
            ts:Create(btn, TweenInfo.new(0.2), { BackgroundColor3 = hoverCol }):Play()
        end)
        btn.MouseLeave:Connect(function()
            ts:Create(btn, TweenInfo.new(0.2), { BackgroundColor3 = baseCol }):Play()
        end)
    end
    applyHoverEffect(multToggleBtn, col(35, 35, 38), col(45, 45, 48))

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

    totalValueLabel = c("TextLabel", selectionPanel, {
        Size = u(1, -24, 0, 16),
        Position = u(0, 12, 0, 54),
        BackgroundTransparency = 1,
        Text = "Total Value: $0",
        TextColor3 = col(46, 196, 182),
        Font = fontBold,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Center,
        ZIndex = 1
    })

    gridScroller = c("ScrollingFrame", selectionPanel, {
        Size = u(1, -20, 1, -88),
        Position = u(0, 10, 0, 78),
        BackgroundTransparency = 1,
        CanvasSize = u(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = col(60, 60, 60),
        CanvasPosition = Vector2.new(0, 0),
        ZIndex = 1
    })
    gridLayout = c("UIGridLayout", gridScroller, {
        CellSize = u(0, 52, 0, 68),
        CellPadding = u(0, 8, 0, 8),
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    -- Inject Avatar Profile Card at the bottom left of Orion Sidebar
    local navigation = orionMain:FindFirstChild("Navigation") or orionMain:FindFirstChildWhichIsA("Frame")
    if navigation then
        local profile = c("Frame", navigation, {
            Size = u(1, -20, 0, 48),
            Position = u(0, 10, 1, -58),
            BackgroundColor3 = col(28, 28, 30),
            BorderSizePixel = 0,
            ZIndex = 5
        })
        c("UICorner", profile, { CornerRadius = UDim.new(0, 6) })

        local avatar = c("ImageLabel", profile, {
            Size = u(0, 32, 0, 32),
            Position = u(0, 8, 0.5, -16),
            BackgroundTransparency = 1,
            Image = "rbxassetid://16823376787",
            ZIndex = 6
        })
        pcall(function()
            avatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. p.UserId .. "&w=150&h=150"
        end)
        c("UICorner", avatar, { CornerRadius = UDim.new(1, 0) })
        c("UIStroke", avatar, { Color = col(50, 50, 50), Thickness = 1, ZIndex = 6 })

        local textLabel = c("TextLabel", profile, {
            Size = u(1, -48, 0, 14),
            Position = u(0, 46, 0, 10),
            BackgroundTransparency = 1,
            Text = p.DisplayName or p.Name,
            TextColor3 = col(220, 220, 220),
            Font = fontBold,
            TextSize = 12,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            ZIndex = 6
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
            TextTruncate = Enum.TextTruncate.AtEnd,
            ZIndex = 6
        })
    end

    -- Floating Restore Toggle Button
    floatBtn = c("ImageButton", orionGui, {
        Size = u(0, 40, 0, 40),
        Position = u(0.02, 0, 0.4, 0),
        BackgroundColor3 = col(23, 23, 23),
        BorderSizePixel = 0,
        Image = "rbxassetid://10734885430",
        ImageColor3 = col(255, 255, 255),
        Visible = false,
        ZIndex = 10
    })
    c("UICorner", floatBtn, { CornerRadius = UDim.new(1, 0) })

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
            floatBtn.Position = u(fStartPos.X.Scale, fStartPos.X.Offset + delta.X, fStartPos.Y.Scale, fStartPos.Y.Offset + delta.Y)
        end
    end)

    applyHoverEffect(floatBtn, col(23, 23, 23), col(28, 28, 30))

    local isUIOpen = true
    local normalPosition = u(0.5, -260, 0.5, -170)
    local offscreenPosition = u(0.5, -260, 1.5, 0)

    local function toggleUI(forceState)
        if forceState ~= nil then
            isUIOpen = forceState
        else
            isUIOpen = not isUIOpen
        end
        if isUIOpen then
            floatBtn.Visible = false
            orionMain.Visible = true
            ts:Create(orionMain, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = normalPosition }):Play()
        else
            closeSelectionPanelInstant()
            local hideTween = ts:Create(orionMain, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.In), { Position = offscreenPosition })
            hideTween:Play()
            hideTween.Completed:Connect(function()
                if not isUIOpen then
                    orionMain.Visible = false
                    floatBtn.Visible = true
                end
            end)
        end
    end

    floatBtn.MouseButton1Click:Connect(function() toggleUI(true) end)

    uis.InputBegan:Connect(function(input, gpe)
        if not gpe and input.KeyCode == Enum.KeyCode.RightControl then toggleUI() end
    end)

    -- Override standard Orion close transitions safely
    local closeBtn = orionMain:FindFirstChild("Close", true) or orionMain:FindFirstChild("Exit", true)
    if closeBtn and closeBtn:IsA("TextButton") then
        closeBtn.MouseButton1Click:Connect(function()
            closeSelectionPanelInstant()
            task.wait(0.1)
            orionGui:Destroy()
        end)
    end

    populateSelectionGrid()
    updateSelectedCounter()
end)

-- Background Sync Loop (Keeps lists and counters accurately updated)
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            currentScannedFruits = scanFruits()
            updateSelectedCounter()
            if isPanelOpen then
                populateSelectionGrid()
            end
        end)
    end
end)
