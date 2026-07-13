-- Load the Orion UI Library
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

-- Create the main window
local Window = OrionLib:MakeWindow({
    Name = "Fruit Spawner", 
    HidePremium = true, 
    SaveConfig = false
})

-- Configuration data
local fruitsList = {
    "Werewolf", "Fiend", "Retro Soul", "Leopard", "Kitsune", "Spirit", 
    "Empyrean", "Yeti", "Tiger", "Dragon", "Shadow", "Dragon West"
}

local rarities = {
    ["Werewolf"] = "Exclusive",
    ["Fiend"] = "Exclusive",
    ["Retro Soul"] = "Exclusive",
    ["Leopard"] = "Secret",
    ["Kitsune"] = "Secret",
    ["Spirit"] = "Secret",
    ["Empyrean"] = "Exclusive",
    ["Yeti"] = "Secret",
    ["Tiger"] = "Secret",
    ["Dragon"] = "Secret",
    ["Shadow"] = "Secret",
    ["Dragon West"] = "Secret"
}

local selectedFruit = "Werewolf"
local selectedMutation = "Normal"
local collectingSlots = false -- State variable for auto-collect
local upgradingSlots = false  -- State variable for auto-upgrade

-- ==================== TAB 1: CLAIM PANEL ====================
local ClaimTab = Window:MakeTab({
    Name = "Claim Panel",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Dropdown to select the Fruit
ClaimTab:AddDropdown({
    Name = "Select Fruit",
    Default = "Werewolf",
    Options = fruitsList,
    Callback = function(Value)
        selectedFruit = Value
    end    
})

-- Dropdown to select the Mutation
ClaimTab:AddDropdown({
    Name = "Select Mutation",
    Default = "Normal",
    Options = {"Normal", "Neon", "Ruby", "Golden", "Diamond"},
    Callback = function(Value)
        selectedMutation = Value
    end    
})

-- Claim Button
ClaimTab:AddButton({
    Name = "Claim Fruit",
    Callback = function()
        local targetRarity = rarities[selectedFruit] or "Exclusive"
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local Event = ReplicatedStorage:FindFirstChild("Events") and ReplicatedStorage.Events:FindFirstChild("RewardEscape")
        
        if Event then
            Event:FireServer(selectedFruit, selectedMutation, targetRarity)
            OrionLib:MakeNotification({
                Name = "Success",
                Content = "Fired remote for " .. selectedFruit .. " (" .. selectedMutation .. ")",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
        else
            OrionLib:MakeNotification({
                Name = "Error",
                Content = "RewardEscape RemoteEvent not found!",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
        end
    end    
})

-- Auto Collect Slots Toggle
ClaimTab:AddToggle({
    Name = "Auto Collect Slots",
    Default = false,
    Callback = function(Value)
        collectingSlots = Value
        
        if collectingSlots then
            task.spawn(function()
                OrionLib:MakeNotification({
                    Name = "Auto Collect",
                    Content = "Started collecting slots.",
                    Image = "rbxassetid://4483345998",
                    Time = 2
                })
                
                while collectingSlots do
                    local player = game.Players.LocalPlayer
                    local character = player and player.Character
                    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
                    local plot = workspace:FindFirstChild("Plot_Xhabeka")
                    
                    if rootPart and plot then
                        local floors = {"Floor1", "Floor2", "Floor3"}
                        for _, floorName in ipairs(floors) do
                            if not collectingSlots then break end
                            
                            local floor = plot:FindFirstChild(floorName)
                            if floor then
                                local slotsFolder = floor:FindFirstChild("Slots")
                                if slotsFolder then
                                    for _, slot in ipairs(slotsFolder:GetChildren()) do
                                        if not collectingSlots then break end
                                        
                                        local collectTouch = slot:FindFirstChild("CollectTouch")
                                        if collectTouch then
                                            firetouchinterest(rootPart, collectTouch, 0)
                                            task.wait(0.02)
                                            firetouchinterest(rootPart, collectTouch, 1)
                                        end
                                    end
                                end
                            end
                        end
                    end
                    task.wait(1) 
                end
            end)
        else
            OrionLib:MakeNotification({
                Name = "Auto Collect",
                Content = "Stopped collecting slots.",
                Image = "rbxassetid://4483345998",
                Time = 2
            })
        end
    end    
})

-- ==================== TAB 2: UPGRADES PANEL ====================
local UpgradeTab = Window:MakeTab({
    Name = "Upgrades Panel",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Auto Upgrade Slots Toggle
UpgradeTab:AddToggle({
    Name = "Auto Upgrade Slots",
    Default = false,
    Callback = function(Value)
        upgradingSlots = Value
        
        if upgradingSlots then
            task.spawn(function()
                OrionLib:MakeNotification({
                    Name = "Auto Upgrade",
                    Content = "Started upgrading slots.",
                    Image = "rbxassetid://4483345998",
                    Time = 2
                })
                
                while upgradingSlots do
                    local plot = workspace:FindFirstChild("Plot_Xhabeka")
                    local ReplicatedStorage = game:GetService("ReplicatedStorage")
                    local UpgradeEvent = ReplicatedStorage:FindFirstChild("Events") and ReplicatedStorage.Events:FindFirstChild("RequestSlotUpgrade")
                    
                    if plot and UpgradeEvent then
                        local floors = {"Floor1", "Floor2", "Floor3"}
                        for _, floorName in ipairs(floors) do
                            if not upgradingSlots then break end
                            
                            local floor = plot:FindFirstChild(floorName)
                            if floor then
                                local slotsFolder = floor:FindFirstChild("Slots")
                                if slotsFolder then
                                    for _, slot in ipairs(slotsFolder:GetChildren()) do
                                        if not upgradingSlots then break end
                                        
                                        -- Fire upgrade event for this floor and slot name (e.g. Slot10)
                                        UpgradeEvent:FireServer(floorName, slot.Name)
                                        task.wait(0.1) -- small wait to avoid spamming the server too heavily
                                    end
                                end
                            end
                        end
                    end
                    task.wait(1) -- delay before the next full upgrade cycle sweep
                end
            end)
        else
            OrionLib:MakeNotification({
                Name = "Auto Upgrade",
                Content = "Stopped upgrading slots.",
                Image = "rbxassetid://4483345998",
                Time = 2
            })
        end
    end
})

OrionLib:Init()
