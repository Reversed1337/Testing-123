-- Load the Orion UI Library
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

-- Font Configuration
local fontRegular = Enum.Font.Montserrat
local fontBold = Enum.Font.MontserratBold

local p = game:GetService("Players").LocalPlayer or game:GetService("Players").PlayerAdded:Wait()
local hs = game:GetService("HttpService")
local uis = game:GetService("UserInputService")

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
                local weightAttr = item:GetAttribute("weight") or item:GetAttribute("Weight") or item:GetAttribute("KG") or
                    item:GetAttribute("Kg") or 0
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

-- UI Elements Hook Setup
local Window = OrionLib:MakeWindow({Name = "Onyx Mailer", HidePremium = true, SaveConfig = false})
local MailerTab = Window:MakeTab({
    Name = "Mailer",
    Icon = "rbxassetid://10734885430",
    PremiumOnly = false
})

local function showToast(msg, isSuccess)
    OrionLib:MakeNotification({
        Name = isSuccess and "Success" or "Error",
        Content = msg,
        Time = 3
    })
end

-- Target Recipient Variables
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

MailerTab:AddSection({ Name = "Multiplier Settings" })

local modeDropdown = MailerTab:AddDropdown({
    Name = "Pricing Mode",
    Default = "LIVE",
    Options = {"LIVE", "1X"},
    Callback = function(Value)
        currentMultiplierMode = Value:lower()
        showToast("Multiplier Mode updated to: " .. Value, true)
    end
})

MailerTab:AddSection({ Name = "Fruit Selection" })

local statusLabel = MailerTab:AddLabel("Selected: 0 fruits | Total Value: $0")

local function updateSelectedCounter()
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
    local statusText = string.format("Selected: %d (%d batches) | Value: $%s", count, batches, formatPrice(totalVal))
    statusLabel:Set(statusText)
end

-- Dynamic list mapping
local fruitDropdownOptions = {}
local fruitDropdownMap = {}

local fruitSelectionDropdown = MailerTab:AddDropdown({
    Name = "Click to Toggle Selection",
    Default = "None",
    Options = {"Refresh to load"},
    Callback = function(Value)
        local fruit = fruitDropdownMap[Value]
        if fruit then
            if selectedFruitsMap[fruit.id] then
                selectedFruitsMap[fruit.id] = nil
                showToast("Removed " .. fruit.name .. " from selection", false)
            else
                selectedFruitsMap[fruit.id] = true
                showToast("Added " .. fruit.name .. " to selection", true)
            end
            updateSelectedCounter()
        end
    end
})

local function refreshInventoryDropdown()
    currentScannedFruits = scanFruits()
    fruitDropdownOptions = {}
    fruitDropdownMap = {}
    
    for _, fruit in ipairs(currentScannedFruits) do
        local price = getFruitPrice(fruit.name, fruit.instance, currentMultiplierMode)
        local displayString = string.format("%s (%.1fkg) - $%s", fruit.name, fruit.weight, formatPrice(price))
        table.insert(fruitDropdownOptions, displayString)
        fruitDropdownMap[displayString] = fruit
    end
    
    if #fruitDropdownOptions == 0 then
        table.insert(fruitDropdownOptions, "No fruits in inventory")
    end
    
    fruitSelectionDropdown:Refresh(fruitDropdownOptions, true)
    updateSelectedCounter()
end

MailerTab:AddButton({
    Name = "Refresh Inventory List",
    Callback = function()
        refreshInventoryDropdown()
        showToast("Inventory list updated.", true)
    end
})

MailerTab:AddButton({
    Name = "Select All Fruits",
    Callback = function()
        for _, fruit in ipairs(currentScannedFruits) do
            selectedFruitsMap[fruit.id] = true
        end
        updateSelectedCounter()
        showToast("Selected all fruits", true)
    end
})

MailerTab:AddButton({
    Name = "Clear Selection",
    Callback = function()
        table.clear(selectedFruitsMap)
        updateSelectedCounter()
        showToast("Selection cleared", false)
    end
})

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
                    showToast("Waiting 10s cooldown before next batch...", true)
                    task.wait(10)
                end
            end

            if overallSuccess then
                showToast("All batches sent successfully!", true)
            end

            task.wait(0.2)
            refreshInventoryDropdown()
        end)
    end
})

-- Background Sync Loop (Auto refreshes selections to stay accurate)
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            currentScannedFruits = scanFruits()
            updateSelectedCounter()
        end)
    end
end)

-- Initial run setup
refreshInventoryDropdown()
OrionLib:Init()
