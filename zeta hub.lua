local G = ... or {}
if type(G) ~= "table" then G = {} end
if type(G.IsPremium) ~= "function" then G.IsPremium = function() return true end end
if type(G.RegisterReset) ~= "function" then G.RegisterReset = function() end end

if type(G.IsHeadless) ~= "function" then 
    G.IsHeadless = function() 
        return (type(getgenv) == "function" and getgenv().mode == "noui") 
    end 
end
if type(G.Library) ~= "table" then G.Library = {} end
if type(G.Window) ~= "table" then G.Window = {} end
local V = game.GameId
if tostring(V) ~= "10200395747" then
    print("Exo: Invalid Game")
    return
end
if _G.is_running_gag2 then
    warn("Already running x")
    return
end
_G.is_running_gag2 = true
print("exo start > ")
print("Place Id ", game.PlaceId)
print("GameId: ", V)
local y = {}
y.CollectionService = game:GetService("CollectionService")
y.LocalizationService = game:GetService("LocalizationService")
y.UserInputService = game:GetService("UserInputService")
y.Players = game:GetService("Players")
y.ReplicatedStorage = game:GetService("ReplicatedStorage")
y.Workspace = game:GetService("Workspace")
y.RunService = game:GetService("RunService")
y.ReplicatedFirst = game:GetService("ReplicatedFirst")
y.HttpService = game:GetService("HttpService")
y.MarketplaceService = game:GetService("MarketplaceService")
y.TeleportService = game:GetService("TeleportService")
y.LocalPlayer = y.Players.LocalPlayer
y.Backpack = y.LocalPlayer:WaitForChild("Backpack")
y.PlayerGui = y.LocalPlayer:WaitForChild("PlayerGui")
y.Character = y.LocalPlayer.Character or y.LocalPlayer.CharacterAdded:Wait()
y.LocalPlayer.CharacterAdded:Connect(function(G) y.Character = G end)
y.LocalPlayer.CharacterRemoving:Connect(function(G) if y.Character == G then y.Character = nil end end)
y.SharedData = y.ReplicatedStorage:FindFirstChild("SharedData")
y.SharedModules = y.ReplicatedStorage:FindFirstChild("SharedModules")
y.StockValues = y.ReplicatedStorage:FindFirstChild("StockValues")
y.CrateShop = y.StockValues:FindFirstChild("CrateShop")
y.ExclusiveShop = y.StockValues:FindFirstChild("ExclusiveShop")
y.GearShop = y.StockValues:FindFirstChild("GearShop")
y.SeedShop = y.StockValues:FindFirstChild("SeedShop")
y.fails = 0
function y.safeRequire(G)
    local V, Z = pcall(require, G)
    if not V or Z == nil then
        warn("[SafeRequire] Failed to load:", G)
        y.fails = y.fails + 1
        return nil
    end
    return Z
end

y.Networking = y.safeRequire(y.SharedModules:WaitForChild("Networking"))
y.SeedData = y.safeRequire(y.SharedModules:WaitForChild("SeedData"))
y.GearShopData = y.safeRequire(y.SharedModules:WaitForChild("GearShopData"))
y.PetData = y.safeRequire(y.SharedData:WaitForChild("PetData"))
y.RarityVisuals = y.safeRequire(y.SharedModules:WaitForChild("RarityVisuals"))
y.ReplicaClient = y.safeRequire(y.ReplicatedStorage.ClientModules.ReplicaClient)
y.SeedShopFlags = y.safeRequire(y.SharedModules.Flags.SeedShopFlags)
y.GearShopFlags = y.safeRequire(y.SharedModules.Flags:WaitForChild("GearShopFlags"))
y.MutationDataModule = y.SharedModules:WaitForChild("MutationData")
y.MutationData = y.safeRequire(y.MutationDataModule)
y.PetSizes = y.safeRequire(y.SharedData:WaitForChild("PetSizes"))
y.PetTypes = y.safeRequire(y.SharedData:WaitForChild("PetTypes"))
y.FruitVisualizerController = y.safeRequire(y.LocalPlayer.PlayerScripts.Controllers.FruitVisualizerController)
y.DroppedItems = y.Workspace:WaitForChild("DroppedItems")
y.EventSeedDrops = (y.Workspace:WaitForChild("Map")):WaitForChild("SeedPackSpawnServerLocations")
y.CollectFruitNet = y.Networking and (y.Networking.Garden and y.Networking.Garden.CollectFruit)
y.WateringcanData = y.safeRequire(y.SharedModules:WaitForChild("WateringcanData"))
y.GardenSyncController = y.safeRequire(y.LocalPlayer.PlayerScripts.Controllers:WaitForChild("GardenSyncController"))
y.PathfindingService = game:GetService("PathfindingService")
y.TweenService = game:GetService("TweenService")
y.MailboxItemCatalog = y.safeRequire(y.LocalPlayer.PlayerScripts.Controllers.MailboxController:WaitForChild(
    "MailboxItemCatalog"))
y.ExpansionPrices = y.safeRequire(y.SharedData:WaitForChild("ExpansionPrices"))
y.GardenFlags = y.safeRequire(y.SharedModules.Flags:WaitForChild("GardenFlags"))
y.TimeCycleData = y.safeRequire(y.SharedModules:WaitForChild("TimeCycleData"))
function Addcantsleep()
    if (getconnections or get_signal_cons) then
        for G, V in pairs(((getconnections or get_signal_cons))(y.LocalPlayer.Idled)) do
            if V.Disable then
                V.Disable(V)
            elseif V.Disconnect then
                V.Disconnect(V)
            end
        end
    end
end

pcall(function() Addcantsleep() end)
-- Make sure the Obsidian library is loaded
local Z = G.Library
if not Z or type(Z.CreateWindow) ~= "function" then
    -- If G.Library is missing or broken, load Obsidian directly
    Z = loadstring(game:HttpGet("https://raw.githubusercontent.com/Reversed1337/Testing-123/refs/heads/main/zetahub_uilib"))()
    if not Z then
        warn("Failed to load Obsidian UI library – UI will not work")
        Z = {}  -- dummy table to avoid crashes
    end
    G.Library = Z
end

-- Create the main window
local j = Z:CreateWindow("Exotic Hub")
if not j or type(j.AddTab) ~= "function" then
    warn("Failed to create Obsidian window – UI will not work")
    j = {}  -- dummy table
end
G.Window = j
local i = type(G.IsHeadless) == "function" and G.IsHeadless() == true
y.AppName = "Exotic Hub"
y.CurentV = "v18"
y.invite_link_url = "https://exotichub.app/join"
y.invite_link_short = "exotichub.app/join"
local c = {}
local J = {}
local T = {}
local d = {}
local u = {}
local q = {}
local g = {}
local E = {}
local a = {}
local H = {}
local r = {}
J.is_pro = true
J.GetCheckIfPro = function() return true end
if type(G.RegisterReset) == "function" then G.RegisterReset(function() J.is_pro = false end) end
J.RarityRank = { Common = 1, Uncommon = 2, Rare = 3, Epic = 4, Legendary = 5, Mythic = 6, Super = 7, Secret = 8 }
J.TeleportLockNames = {
    SeedPackCollector = "Seed Collection",
    SeedPlacer = "Seed Placement System",
    FruitCollector =
    "Fruit Collector",
    PetFarmReturn = "Pet Farm Return",
    EventCollector = "Event Collection",
    GardenItemCollector =
    "Garden Item Collector",
    PremiumFruitCollector = "Premium Fruit Collector",
    SprinklerPlacer = "Sprinkler Placement",
    PetFinderPremium =
    "Pet Finder Premium",
    WaterPlants = "Water Plants",
    Other = "Other"
}
J.GetProMessage = function()
    local G = string.format(
        "\240\159\148\146 <stroke th=\'0.1\' joins=\'round\' sizing=\'fixed\' color=\'#8C1600\'><font color=\'#FA2B00\'> Premium Feature - Join discord server to get Key.</font></stroke>")
    return G
end
local Y = {
    auto_expand_garden = false,
    auto_expand_garden_max_slot = 2,
    web_api_key = "",
    webhook_enabled = true,
    webhook_url =
    "",
    webhook_pet_buys = true,
    webhook_mail_manual = true,
    webhook_mail_auto = true,
    webhook_mail_claims = true,
    webhook_event_seeds = true,
    pet_finder_enabled = false,
    pet_finder_buy_list = {},
    pet_finder_auto_hop = false,
    pet_finder_hop_minutes = 5,
    pet_finder_purchase_log = {},
    water_plant_wait_effect = false,
    auto_water_plants = false,
    water_plant_selected_cans = {},
    water_plant_mode =
    "Growing Plant",
    water_plant_target_plant = "",
    water_plant_saved_position = {},
    hide_player_ui = false,
    auto_sprinkler_place = false,
    sprinkler_place_selected = {},
    sprinkler_place_default_target = 1,
    sprinkler_place_overrides = {},
    sprinkler_place_mode =
    "Farm Middle",
    sprinkler_place_target_plant = "",
    sprinkler_place_saved_position = {},
    sprinkler_place_teleport = false,
    sprinkler_place_delay = .6,
    shovel_plant_variant_blacklist = {},
    hide_plant_models = false,
    sell_when_backpack_full = false,
    auto_idle_touch = true,
    auto_collect_event_seeds = true,
    auto_collect_drop_seeds = true,
    is_frist_run = false,
    seed_avoid = {},
    enabled_seed_shop = false,
    gear_shop_avoid = {},
    enabled_gear_shop = false,
    auto_collect_fruit_enabled = false,
    collect_fruit_list = {},
    auto_seedplace = false,
    allowed_seedsplace = {},
    seed_place_default_target = 10,
    seed_place_delay = .3,
    seed_place_mode =
    "Random",
    seed_place_saved_position = {},
    seed_place_max_garden_plants = 800,
    seed_place_overrides = {},
    seed_place_wall_mode = false,
    seed_place_stack_mode = false,
    seed_place_stack_mode_underground = false,
    auto_sell_sellallinventory = false,
    turbo_sell = false,
    hide_log_ui = false,
    collection_teleport = true,
    char_farm_middle = false,
    auto_shovel_fruits = false,
    shovel_fruit_types = {},
    shovel_mutation_whitelist = {},
    shovel_mutation_blacklist = {},
    shovel_min_weight = 0,
    shovel_max_weight = 99,
    shovel_variants = { Normal = true, Gold = true, Rainbow = true },
    auto_shovel_plants = false,
    shovel_plant_types = {},
    shovel_plant_min_height = 0,
    shovel_plant_max_height = 200,
    shovel_plant_variants = {},
    shovel_growing_plants = false,
    shovel_plants_keep = 10,
    trowel_plant_types = {},
    trowel_use_fixed_spot = true,
    trowel_saved_position = {},
    pet_return_farm = false,
    pet_return_farm_timer = 60,
    mail_manual_batch_together = false,
    mail_auto_batch_together = false,
    mail_auto_send_enabled = false,
    mail_auto_accept = false,
    mail_include_comment = false,
    mail_next_send_at = 0,
    mail_manual_order = {},
    mail_auto_rules = {},
    mail_receipts = {},
    mail_ignore_batch_limit = false,
    auto_use_daily_deal = true,
    step_teleport_speed = 60
}
local e = type(getgenv) == "function" and getgenv() or _G
local s = type(e.gag2_config) == "table" and e.gag2_config or nil
J.player_userid = y.LocalPlayer.UserId
if not J.player_userid then
    warn("Invalid player detected.")
    return
end
J.alt_Plants_Physical = J.alt_Plants_Physical or {}
J.MakeAltFolder = function(G)
    if not G then
        warn("MakeAltFolder requires a userId!")
        return nil
    end
    local V = tostring(G) .. "_Plants"
    local Z = y.ReplicatedStorage:FindFirstChild(V)
    if Z then
        J.alt_Plants_Physical[G] = Z
        return Z
    end
    local j = Instance.new("Folder")
    j.Name = V
    j.Parent = y.ReplicatedFirst
    J.alt_Plants_Physical[G] = j
    return j
end
J.MakeAltFolder(J.player_userid)
local N = "exotichub99"
if not isfolder(N) then makefolder(N) end
local W = N .. ("/" .. (tostring(J.player_userid) .. "gag2.json"))
u.Config = {
    Excluded = { pet_finder_purchase_log = true, mail_receipts = true },
    OverrideEnabled = type(s) == "table",
    ToLua = function(
        G, V)
        V = tonumber(V) or 0
        local y = type(G)
        if y == "string" then return string.format("%q", G) end
        if y == "number" or y == "boolean" then return tostring(G) end
        if y ~= "table" then return "nil" end
        local Z = {}
        for G in pairs(G) do table.insert(Z, G) end
        if #Z == 0 then return "{}" end
        table.sort(Z,
            function(G, V)
                if type(G) == type(V) then
                    if type(G) == "number" then return G < V end
                    return tostring(G) < tostring(V)
                end
                return type(G) < type(V)
            end)
        local j = string.rep("    ", V)
        local i = string.rep("    ", V + 1)
        local c = { "{" }
        for y, Z in ipairs(Z) do
            local j
            if type(Z) == "string" and Z:match("^[%a_][%w_]*$") then j = Z else j = string.format("[%s]",
                    u.Config.ToLua(Z, 0)) end
            table.insert(c, string.format("%s%s = %s,", i, j, u.Config.ToLua(G[Z], V + 1)))
        end
        table.insert(c, j .. "}")
        return table.concat(c, "\n")
    end,
    CopyTable = function(G)
        if type(G) ~= "table" then return G end
        local V = {}
        for G, y in pairs(G) do V[G] = u.Config.CopyTable(y) end
        return V
    end,
    Merge = function(G, V, y)
        if type(G) ~= "table" or type(V) ~= "table" then return false end
        for V, Z in pairs(V) do
            local j = G[V]
            if y and j == nil then continue end
            if type(j) == "table" and type(Z) == "table" then
                u.Config.Merge(j, Z, false)
            elseif j == nil or type(j) == type(Z) then
                G[V] =
                    u.Config.CopyTable(Z)
            end
        end
        return true
    end,
    ApplyOverride = function()
        if not u.Config.OverrideEnabled then return false end
        return u.Config.Merge(Y, s, true)
    end,
    GetCopyData = function()
        local G = {}
        for V, y in pairs(Y) do if not u.Config.Excluded[V] then G[V] = y end end
        return G
    end,
    BuildCopyText = function()
        local G = u.Config.GetCopyData()
        if type(G) ~= "table" then return nil end
        local V, y = pcall(function() return "getgenv().gag2_config = " .. u.Config.ToLua(G, 0) end)
        if not V then return nil end
        return y
    end,
    BuildCopyWithLoaderText = function()
        local G = u.Config.BuildCopyText()
        if type(G) ~= "string" or G == "" then return nil end
        return table.concat(
            { "getgenv().mode = \"noui\"", "getgenv().exo_key = \"YOUR_KEY\"", "", G, "",
                "loadstring(game:HttpGet(\"https://exotichub.app/auto.lua\"))()" }, "\n")
    end
}
u.Save = {
    RequireSave = false,
    SaveData = function(G)
        if u.Config.OverrideEnabled then return false end
        if G then
            u.Save.SaveDataSync()
            return
        end
        u.Save.RequireSave = true
    end,
    LoadData = function()
        if not isfile(W) then return end
        local G = readfile(W)
        if not G or G == "" then return end
        local V, Z = pcall(y.HttpService.JSONDecode, y.HttpService, G)
        if not V then return end
        local function j(G, V)
            for V, y in pairs(V) do
                local Z = G[V]
                if type(y) == "table" and type(Z) == "table" then j(Z, y) else G[V] = y end
            end
            return G
        end
        j(Y, Z)
    end,
    SaveDataSync = function()
        if u.Config.OverrideEnabled then return false end
        local G, V = pcall(function() return y.HttpService:JSONEncode(Y) end)
        if G then writefile(W, V) else end
    end,
    SaveLoop = function()
        if u.Config.OverrideEnabled then return false end
        task.spawn(function()
            while true do
                task.wait(.5)
                if u.Config.OverrideEnabled then return false end
                if u.Save.RequireSave then
                    u.Save.RequireSave = false
                    u.Save.SaveDataSync()
                end
            end
        end)
    end
}
if u.Config.OverrideEnabled then u.Config.ApplyOverride() else u.Save.LoadData() end
if Y.seed_place_mode == "Farm Corner" then
    Y.seed_place_mode = "Farm Middle"
    u.Save.SaveDataSync()
end
u.Save.SaveLoop()
local X = { k = 1000.0, K = 1000.0, m = 1000000.0, M = 1000000.0, b = 1000000000.0, B = 1000000000.0, t = 1000000000000.0, T = 1000000000000.0, q = 1e+015, Q = 1e+015, Qa = 1e+015, qi = 1e+018, Qi = 1e+018, sx = 1e+021, Sx = 1e+021, sp = 1e+024, Sp = 1e+024, oc = 1e+027, Oc = 1e+027, no = 1e+030, No = 1e+030, dc = 1e+033, Dc = 1e+033 }
local h = { "k", "M", "B", "T", "Qa", "Qi", "Sx", "Sp", "Oc", "No", "Dc" }
J.Notify = function(G, V)
    G = tostring(G or "")
    if G == "" or not Z or type(Z.Notify) ~= "function" then return false end
    return pcall(function() Z:Notify(G, tonumber(V) or 2.5) end)
end
g.Http = {
    GetRequestFunction = function()
        return type(syn) == "table" and syn.request or
            type(http) == "table" and http.request or type(http_request) == "function" and http_request or
            type(request) == "function" and request or type(fluxus) == "table" and fluxus.request or
            type(krnl) == "table" and krnl.request
    end,
    PostJson = function(G, V)
        if type(G) ~= "string" or G == "" or type(V) ~= "table" then return false, 0, "", "Invalid request" end
        local Z, j = pcall(y.HttpService.JSONEncode, y.HttpService, V)
        if not Z or type(j) ~= "string" then return false, 0, "", "Failed to encode request" end
        local i, c = pcall(function()
            local V = g.Http.GetRequestFunction()
            if type(V) == "function" then
                return V({
                    Url = G,
                    Method = "POST",
                    Headers = { ["Content-Type"] = "application/json", Accept = "application/json" },
                    Body =
                        j
                })
            end
            local Z = y.HttpService:PostAsync(G, j, Enum.HttpContentType.ApplicationJson)
            return { StatusCode = 200, Body = Z }
        end)
        if not i or type(c) ~= "table" then return false, 0, "", tostring(c or "Request failed") end
        local J = tonumber(c.StatusCode or c.Status or c.status_code) or 0
        local T = c.Body or c.body or ""
        T = type(T) == "string" and T or tostring(T or "")
        if J == 0 and T ~= "" then J = 200 end
        local d = J >= 200 and J < 300
        local u = nil
        if not d then u = "HTTP " .. tostring(J) end
        return d, J, T, u
    end
}
d.WebApi = {
    Url = "https://exotichub.app/api/linkapidevice",
    Busy = false,
    LinkDevice = function()
        if d.WebApi.Busy then return false, "Link request already running" end
        local G = (tostring(Y.web_api_key or "")):match("^%s*(.-)%s*$")
        local V = tostring(y.LocalPlayer and y.LocalPlayer.Name or "")
        local Z = tostring(y.LocalPlayer and y.LocalPlayer.UserId or "")
        if G == "" then return false, "Enter your Web API key first" end
        if V == "" or Z == "" then return false, "Account data is unavailable" end
        d.WebApi.Busy = true
        local j, i = pcall(function()
            local j = y.HttpService:JSONEncode({ webapi = G, un = V, pid = Z })
            local i = type(syn) == "table" and syn.request or type(http) == "table" and http.request or
                type(http_request) == "function" and http_request or type(request) == "function" and request or
                type(fluxus) == "table" and fluxus.request or type(krnl) == "table" and krnl.request
            if type(i) == "function" then
                local G = i({
                    Url = d.WebApi.Url,
                    Method = "POST",
                    Headers = { ["Content-Type"] = "application/json" },
                    Body =
                        j
                })
                if type(G) ~= "table" then error("Invalid request response") end
                return G.Body or G.body or ""
            end
            return y.HttpService:PostAsync(d.WebApi.Url, j, Enum.HttpContentType.ApplicationJson)
        end)
        d.WebApi.Busy = false
        if not j or type(i) ~= "string" or i == "" then return false, "Device link request failed" end
        local c, J = pcall(y.HttpService.JSONDecode, y.HttpService, i)
        if not c or type(J) ~= "table" then return false, "Invalid server response" end
        local T = tostring(J.msg or J.message or "Unknown response")
        if J.success == true then return true, T, J end
        return false, T, J
    end
}
c.CopyToClipBoard = function(G)
    if setclipboard then
        setclipboard(G); (game:GetService("StarterGui")):SetCore("SendNotification",
            { Title = "Text", Text = " Copied to clipboard!", Duration = 2 })
    else
        J.Notify("\226\157\140 Clipboard copy not supported", 3)
    end
end
local function l(G)
    if G == nil or (type(G) == "string" and G:match("^%s*$")) then return nil end
    local V = tonumber(G)
    if not V then return nil end
    if V % 1 ~= 0 then return nil end
    return V
end
local function B(G)
    if G == nil or (type(G) == "string" and G:match("^%s*$")) then return nil end
    local V = tonumber(G)
    if not V then return nil end
    return V
end
c.IsLoadingCompleted = function()
    local G = y.LocalPlayer:GetAttribute("GardenLoadingTotal") or 0
    local V = y.LocalPlayer:GetAttribute("GardenLoadingProgress") or 0
    if G == 0 and V == 0 then return true end
    return false
end
c.formatShecklesNumber = function(G)
    G = tonumber(G)
    if not G then return "0" end
    local V = { "K", "M", "B", "T", "Qa", "Qi", "Sx", "Sp", "Oc", "No", "Dc" }
    local y = math.abs(G)
    if y < 1000 then return string.format("%.2f", G) end
    local Z = math.log10(y)
    local j = math.floor(Z / 3)
    if j > #V then return string.format("%.2e", G) end
    local i = 10 ^ ((j * 3))
    local c = G / i
    return string.format("%.2f%s", c, V[j])
end
c.JsonPrint = function(G) if y.HttpService then warn(y.HttpService:JSONEncode(G)) end end
c.log = function(G) if G then print(G) else warn("(log) error passed val nil") end end
T.Currency = {
    ParseMoney = function(G)
        if not G or type(G) ~= "string" then return 0 end
        local V = G:gsub("[$,%s]", "")
        V = (V:gsub("/s", "")):gsub("/min", "")
        local y, Z = V:match("^([%d%.]+)(%a*)$")
        local j = tonumber(y) or 0
        if Z and Z ~= "" then
            local V = X[Z]
            if V then j = j * V else warn("Ulti: Unknown suffix \'" .. (Z .. ("\' in text: " .. G))) end
        end
        return j
    end,
    FormatMoney = function(G)
        local V = tonumber(G)
        if not V then V = T.Currency.ParseMoney(G) end
        if not V or V == 0 then return "0" end
        if V < 1000 then return tostring(math.floor(V)) end
        local y = 0
        local Z = V
        while Z >= 1000 and y < #h do
            Z = Z / 1000
            y = y + 1
        end
        local j = string.format("%.2f", Z)
        j = j:gsub("%.?0+$", "")
        return j .. h[y]
    end
}
T.App = {
    GetAppName = function() return y.AppName end,
    GetFooterInfo = function(G)
        local V = string.format("%s (%s)", y.invite_link_short, y.CurentV)
        if not G then V = string.format("<b><font color=\'#FFFB03\'>%s</font></b> (%s)", y.invite_link_short, y.CurentV) end
        return V
    end
}
T.SERVER = { GetServerVersion = function() return game.PlaceVersion end }
T.Others = { IsBetween = function(G, V, y) return G >= V and G <= y end }
local L = game:GetService("RunService")
r.applySmoothRainbow = function(G, V)
    if not G or not ((G:IsA("TextLabel") or G:IsA("TextButton"))) then
        warn("Target is not a valid text object!")
        return nil
    end
    V = V or .2
    local y = 0
    local Z
    Z = L.Heartbeat:Connect(function(j)
        if not G or not G.Parent then
            Z:Disconnect()
            return
        end
        y = ((y + (j * V))) % 1
        G.TextColor3 = Color3.fromHSV(y, .8, 1)
    end)
    return Z
end
c.UserDevice = {
    IsMobile = function() return y.UserInputService.TouchEnabled end,
    IsPC = function()
        return y
            .UserInputService.KeyboardEnabled and
            (y.UserInputService.MouseEnabled and not y.UserInputService.TouchEnabled)
    end,
    IsConsole = function()
        return
            y.UserInputService.GamepadEnabled and not y.UserInputService.KeyboardEnabled
    end,
    Get = function()
        if y.UserInputService.TouchEnabled then return "Mobile" end
        if y.UserInputService.GamepadEnabled and not y.UserInputService.KeyboardEnabled then return "Console" end
        return "PC"
    end,
    Raw = function()
        return {
            Touch = y.UserInputService.TouchEnabled,
            Keyboard = y.UserInputService.KeyboardEnabled,
            Mouse =
                y.UserInputService.MouseEnabled,
            Gamepad = y.UserInputService.GamepadEnabled
        }
    end
}
print("Platform : ", c.UserDevice.Get())
print("SC Version: ", y.CurentV)
J.LiveReplicaData = nil
J.LiveReplicaConnection = nil
d.DataReplica = {
    AllBigDataKeys = {},
    Load = function(G, V)
        local Z = y.ReplicaClient
        V = tonumber(V) or 10
        if type(Z) ~= "table" or type(Z.OnNew) ~= "function" or type(Z.RequestData) ~= "function" then return false end
        if type(G) ~= "string" or G == "" then return false end
        if J.LiveReplicaConnection then
            J.LiveReplicaConnection:Disconnect()
            J.LiveReplicaConnection = nil
        end
        J.LiveReplicaData = nil
        J.LiveReplicaConnection = Z.OnNew(G,
            function(G)
                if type(G) ~= "table" or type(G.Data) ~= "table" then return end
                J.LiveReplicaData = G.Data
                for G in pairs(G.Data) do table.insert(d.DataReplica.AllBigDataKeys, G) end
            end)
        Z.RequestData()
        local j = os.clock()
        repeat task.wait() until J.LiveReplicaData ~= nil or os.clock() - j >= V
        if J.LiveReplicaData == nil then return false end
        return true
    end,
    GetData = function(G, V)
        local y = J.LiveReplicaData
        if type(y) ~= "table" then return V or nil end
        local Z = y[G]
        if Z == nil then return V or nil end
        return Z
    end
}
d.Money = { GetSheckles = function() return d.DataReplica.GetData("Sheckles", 0) end }
if d.DataReplica.Load("PlayerState", 10) then end
d.GameApi = {
    Url = "https://exotichub.app/alivestats",
    Busy = false,
    Started = false,
    GetInterval = function() return 17 end,
    GetRequestFunction = function()
        if type(syn) == "table" and type(syn.request) == "function" then return syn.request end
        if type(http) == "table" and type(http.request) == "function" then return http.request end
        if type(http_request) == "function" then return http_request end
        if type(request) == "function" then return request end
        if type(fluxus) == "table" and type(fluxus.request) == "function" then return fluxus.request end
        if type(krnl) == "table" and type(krnl.request) == "function" then return krnl.request end
        return nil
    end,
    GetIconId = function(G)
        if type(G) ~= "table" then return 0 end
        local V = tostring(G.Image or "")
        return tonumber(V:match("%d+")) or 0
    end,
    GetSize = function(G)
        if type(G) ~= "table" then return "Normal" end
        if G.Size == "Huge" then return "Huge" end
        if G.Size == "Big" then return "Big" end
        return "Normal"
    end,
    GetVariant = function(G)
        if type(G) == "table" and G.Type == "Rainbow" then return "Rainbow" end
        return "Normal"
    end,
    GetPets = function()
        local G = d.DataReplica.GetData("Inventory")
        local V = type(G) == "table" and G.Pets or nil
        if type(V) ~= "table" then return nil end
        local Z = {}
        local j = {}
        for G, V in pairs(V) do
            if type(V) ~= "table" then continue end
            local j = V.Name or V.PetName or V.Species
            if type(j) ~= "string" or j == "" then continue end
            local i = type(y.PetData) == "table" and y.PetData[j] or nil
            local c = type(i) == "table" and i.DisplayName or j
            local J = type(i) == "table" and i.Rarity or "Unknown"
            local T = d.GameApi.GetSize(V)
            local u = d.GameApi.GetVariant(V)
            local q = table.concat({ j, T, u }, "\031")
            if not Z[q] then
                Z[q] = {
                    name = tostring(c),
                    size = T,
                    variant = u,
                    rarity = tostring(J),
                    amount = 0,
                    icon_id =
                        d.GameApi.GetIconId(i)
                }
            end
            Z[q].amount += 1
        end
        for G, V in pairs(Z) do table.insert(j, V) end
        table.sort(j,
            function(G, V)
                if G.name ~= V.name then return G.name < V.name end
                if G.size ~= V.size then return G.size < V.size end
                return G.variant < V.variant
            end)
        return j
    end,
    BuildPayload = function()
        local G = d.GameApi.GetPets()
        if type(G) ~= "table" then return nil end
        local V = y.LocalPlayer
        if not V or not V.UserId then return nil end
        return {
            game = "gag2",
            username = tostring(V.Name or ""),
            userid = tostring(V.UserId),
            ispro = J.GetCheckIfPro() ==
                true,
            sheckles = tostring(d.Money.GetSheckles() or 0),
            pets_data = G
        }
    end,
    Send = function()
        if d.GameApi.Busy then return false end
        local G = d.GameApi.BuildPayload()
        if type(G) ~= "table" then return false end
        d.GameApi.Busy = true
        local V = pcall(function()
            local V = y.HttpService:JSONEncode(G)
            local Z = d.GameApi.GetRequestFunction()
            if type(Z) == "function" then
                Z({ Url = d.GameApi.Url, Method = "POST", Headers = { ["Content-Type"] = "application/json" }, Body = V })
                return
            end
            y.HttpService:PostAsync(d.GameApi.Url, V, Enum.HttpContentType.ApplicationJson)
        end)
        d.GameApi.Busy = false
        return V
    end,
    Start = function()
        if d.GameApi.Started then return end
        d.GameApi.Started = true
        task.spawn(function()
            task.wait(2)
            while not J.is_forced_stop do
                d.GameApi.Send()
                task.wait(d.GameApi.GetInterval())
            end
        end)
    end
}
d.GameApi.Start()
d.Data = {
    GetRarityColor = function(G)
        local V = "#FFFFFF"
        local Z = y and y.RarityVisuals
        if type(Z) ~= "table" or type(Z.GetStaticColor) ~= "function" or type(G) ~= "string" or G == "" then return V end
        local j = Z.GetStaticColor(G)
        if typeof(j) ~= "Color3" then return V end
        local i = math.clamp(math.floor(j.R * 255 + .5), 0, 255)
        local c = math.clamp(math.floor(j.G * 255 + .5), 0, 255)
        local J = math.clamp(math.floor(j.B * 255 + .5), 0, 255)
        return string.format("#%02X%02X%02X", i, c, J)
    end
}
J.AllMutationNames = {}
d.Mutations = {
    Load = function()
        table.clear(J.AllMutationNames)
        local G = y.MutationDataModule
        local V = y.MutationData
        if not G then return false end
        if type(V) ~= "table" or type(V.GetMutation) ~= "function" then return false end
        local Z = {}
        for G, y in ipairs(G:GetChildren()) do
            if not y:IsA("ModuleScript") then continue end
            local j = y.Name
            if j == "" or Z[j] then continue end
            local i, c = pcall(function() return V.GetMutation(j) end)
            if i and type(c) == "table" then
                Z[j] = true
                table.insert(J.AllMutationNames, j)
            end
        end
        table.sort(J.AllMutationNames)
        return #J.AllMutationNames > 0
    end,
    GetNames = function()
        local G = {}
        for V, y in ipairs(J.AllMutationNames) do table.insert(G, y) end
        return G
    end
}
d.Mutations.Load()
J.AllSeedsDataTable = {}
J.SeedRarity = {}
J.SeedSingleHarvest = {}
J.SeedDataFast = {}
J.SeedShopDataList = {}
J.SeedPriceOverrides = {}
d.SeedData = {
    getCleanPriceOverrides = function()
        if type(y.SeedShopFlags) ~= "table" then return end
        local G = y.SeedShopFlags.PriceOverrides
        if type(G) == "table" and G.Value then G = G.Value end
        if type(G) == "table" then
            for G, V in pairs(G) do
                if type(G) == "string" and type(V) == "number" then
                    J.SeedPriceOverrides[G] =
                        V
                end
            end
        end
    end,
    IsSingleHarvest = function(G) return J.SeedSingleHarvest[G] end,
    LoadAllSeeds = function()
        if not y.SeedData then
            warn("Seed Data failed to load.")
            return
        end
        for G, V in ipairs(y.SeedData) do
            local y = V.SeedName
            local Z = V.SeedImage
            local j = V.FruitImage
            local i = J.SeedPriceOverrides[y] or V.PurchasePrice
            local c = V.RestockShop
            local T = V.SeedShopDisplayOrder
            local d = V.YHeight
            local u = V.RestockChance
            local q = V.RestockValues
            local g = V.IsSingleHarvest
            local E = V.Rarity
            local a = V.PrimeTime
            local H = V.PlantModel
            local r = V.MutationSeed
            J.SeedRarity[y] = E
            if g then J.SeedSingleHarvest[y] = true end
            local Y = { name = y, price = i, rarity = E, single = g }
            J.SeedDataFast[y] = Y
            table.insert(J.AllSeedsDataTable, Y)
        end
    end,
    GetSeedDataX = function(G) return J.SeedDataFast[G] or nil end,
    LoadValidSeedsForShop = function()
        local G = y.SeedShop.Items
        for G, V in ipairs(G:GetChildren()) do
            local y = V.Name or ""
            local Z = J.SeedDataFast[y]
            if not Z then
                print("Seed not data ", y)
                continue
            end
            J.SeedShopDataList[y] = true
        end
    end,
    GetSeedDataListDropDown = function()
        local G = {}
        for V, y in ipairs(J.AllSeedsDataTable) do
            local Z = tostring(y.name or "Unknown")
            local j = tonumber(y.price) or 0
            local i = tostring(y.rarity or "Unknown")
            local c = y.single == true
            local J = c and "Single" or "Multi"
            local T = d.Data.GetRarityColor(i)
            local u = string.format(
                "<font color=\"#FFFFFF\">%s</font> <font color=\"#00FF00\">$%s</font> <font color=\"%s\">%s</font> <font color=\"#FFFFFF\">%s</font>",
                Z, tostring(j), T, i, J)
            local q = { Text = u, Value = Z }
            table.insert(G, q)
        end
        return G
    end,
    GetSeedShopDropDown = function()
        local G = {}
        for V, y in pairs(J.SeedShopDataList) do
            local Z = V
            local j = J.SeedDataFast[Z]
            if not j then
                print("Seed not data ", Z)
                continue
            end
            local i = tostring(j.name or "Unknown")
            local T = c.formatShecklesNumber(j.price)
            local u = tostring(j.rarity or "Unknown")
            local q = j.single == true
            local g = q and "Single" or "Multi"
            local E = d.Data.GetRarityColor(u)
            local a = string.format(
                "<font color=\"#FFFFFF\">%s</font> <font color=\"#00FF00\">$%s</font> <font color=\"%s\">%s</font> <font color=\"#FFFFFF\">%s</font>",
                i, tostring(T), E, u, g)
            local H = { Text = a, Value = i }
            table.insert(G, H)
        end
        return G
    end
}
d.SeedData.getCleanPriceOverrides()
d.SeedData.LoadAllSeeds()
d.SeedData.LoadValidSeedsForShop()
J.AllGearShopData = {}
J.AllGearShopTable = {}
d.GearData = {
    GetPrice = function(G, V)
        local Z = y.GearShopFlags and y.GearShopFlags.PriceOverrides
        if not Z or type(Z.Get) ~= "function" then return V end
        local j = Z:Get()
        local i = type(j) == "table" and j[G]
        if type(i) == "number" and i >= 0 then return i end
        return V
    end,
    LoadAllGearData = function()
        local G = y.GearShopData
        local V = G and G.Data
        if type(V) ~= "table" then
            warn("[GearData] Gear shop data was not found")
            return false
        end
        for G, V in ipairs(V) do
            if type(V) == "table" then
                local y = V.RestockValues
                local Z = G
                local j = V.ItemName
                local i = V.ItemType
                local c = V.Rarity
                local T = V.PriceInRobux
                local u = V.RestockChance
                local q = V.EquippableGear == true
                local g = V.IMG or ""
                local E = y and y.Min or nil
                local a = y and y.Max or nil
                local H = V
                local r = d.GearData.GetPrice(j, V.Cost)
                if j then
                    local G = { name = j, type = i, rarity = c, price = r }
                    J.AllGearShopData[j] = G
                    table.insert(J.AllGearShopTable, G)
                end
            end
        end
        return true
    end,
    GetGearShopDropDown = function()
        local G = {}
        for V, y in pairs(J.AllGearShopTable) do
            local Z = tostring(y.name or "Unknown")
            local j = c.formatShecklesNumber(y.price)
            local i = tostring(y.rarity or "Unknown")
            local J = d.Data.GetRarityColor(i)
            local T = string.format(
                "<font color=\"#FFFFFF\">%s</font> <font color=\"#00FF00\">$%s</font> <font color=\"%s\">%s</font>", Z,
                tostring(j), J, i)
            local u = { Text = T, Value = Z }
            table.insert(G, u)
        end
        return G
    end,
    GetGeatItemDetails = function(G) return J.AllGearShopData[G] end,
    GetGearStockCurrent = function(G)
        local V = y.GearShop.Items:FindFirstChild(G)
        if V then return V.Value or 0 end
        return nil
    end
}
d.GearData.LoadAllGearData()
J.PetRarity = {}
J.PetDataTable = {}
J.PetDataFast = {}
d.PetData = {
    LoadAllPetData = function()
        table.clear(J.PetRarity)
        table.clear(J.PetDataTable)
        table.clear(J.PetDataFast)
        for G, V in pairs(y.PetData) do
            if type(V) == "table" and type(V.DisplayName) == "string" then
                local y = V.DisplayName
                local Z = V.Rarity
                local j = V.BasePrice
                local i = V.SpawnChance
                local c = { petname = G, displayname = y, price = j, chance = i, rarity = Z }
                J.PetDataFast[y] = c
                J.PetRarity[y] = Z
                table.insert(J.PetDataTable, c)
            end
        end
    end,
    GetDropDownPets = function()
        local G = {}
        for V, y in pairs(J.PetDataFast) do
            local Z = tostring(y.displayname or "Unknown")
            local j = c.formatShecklesNumber(y.price)
            local i = tostring(y.rarity or "Unknown")
            local J = tostring(y.chance or "0")
            local T = d.Data.GetRarityColor(i)
            local u = string.format(
                "<font color=\"#FFFFFF\">%s</font> <font color=\"#00FF00\">$%s</font> <font color=\"%s\">%s</font> (%s)",
                Z,
                tostring(j), T, i, J)
            local q = { Text = u, Value = Z }
            table.insert(G, q)
        end
        return G
    end
}
d.PetData.LoadAllPetData()
d.PlayerData = {
    GetBackpackSpaceUpgradesPurchased = function()
        return y.LocalPlayer:GetAttribute(
            "BackpackSpaceUpgradesPurchased") or 0
    end,
    GetFriends = function() return y.LocalPlayer:GetAttribute("Friends") or 0 end,
    GetFruitCount = function()
        return
            y.LocalPlayer:GetAttribute("FruitCount") or 0
    end,
    GetIsInOwnGarden = function()
        return y.LocalPlayer:GetAttribute(
            "IsInOwnGarden") or false
    end,
    GetLoadingScreenActive = function()
        return y.LocalPlayer:GetAttribute(
            "LoadingScreenActive") or false
    end,
    GetLoadingScreenDone = function()
        return y.LocalPlayer:GetAttribute(
            "LoadingScreenDone") or false
    end,
    GetMaxEquippedPets = function()
        return y.LocalPlayer:GetAttribute(
            "MaxEquippedPets") or 3
    end,
    GetMaxFruitCapacity = function()
        return y.LocalPlayer:GetAttribute("MaxFruitCapacity") or
            100
    end,
    GetOfflineGrowthProcessed = function() return y.LocalPlayer:GetAttribute("OfflineGrowthProcessed") or false end,
    GetOwnedGamepasses = function()
        return
            y.LocalPlayer:GetAttribute("OwnedGamepasses") or ""
    end,
    GetPlotId = function()
        return y.LocalPlayer:GetAttribute(
            "PlotId") or 0
    end,
    GetPrimeEnabled = function() return y.LocalPlayer:GetAttribute("PrimeEnabled") or false end,
    GetSecondTimePlayer = function()
        return
            y.LocalPlayer:GetAttribute("SecondTimePlayer") or false
    end,
    GetStarterPackExpiresAt = function()
        return y
            .LocalPlayer:GetAttribute("StarterPackExpiresAt") or 0
    end
}
d.Player = {
    Rejoin = function() pcall(function() y.TeleportService:Teleport(game.PlaceId) end) end,
    CameraSetUp = function()
        pcall(function() y.LocalPlayer.CameraMaxZoomDistance = 350 end)
    end,
    GetUserid = function()
        return y.LocalPlayer
            .UserId
    end,
    GetTool_Holding = function() return y.Character and y.Character:FindFirstChildWhichIsA("Tool") end,
    IsToolHeld = function(
        G)
        local V = d.Player.GetTool_Holding()
        if not V then return false end
        return V == G
    end,
    UnequipTools = function()
        local G = y.Character
        if not G then return false end
        local V = G:FindFirstChildOfClass("Humanoid")
        if not V then return end
        V:UnequipTools()
    end,
    EquipTool = function(G)
        local V = y.Character
        if not V or not G then return false end
        local Z = V:FindFirstChildOfClass("Humanoid")
        if not Z then return false end
        local j, i = pcall(function() Z:EquipTool(G) end)
        if not j then
            warn("\226\157\140 Failed to equip tool:", i)
            return false
        end
        return true
    end
}
d.Player.CameraSetUp()
d.PlayerUI = {
    Started = false,
    OriginalStates = {},
    TargetNames = { Plot1 = true, Plot2 = true, Plot3 = true, Plot4 = true, Plot5 = true, Plot6 = true, Plot7 = true, Plot8 = true, TeleportButtons = true },
    GetProperty = function(
        G)
        if not G then return nil end
        if G:IsA("LayerCollector") then return "Enabled" end
        if G:IsA("GuiObject") then return "Visible" end
        return nil
    end,
    ApplyObject = function(G)
        if not G or not d.PlayerUI.TargetNames[G.Name] then return end
        local V = d.PlayerUI.GetProperty(G)
        if not V then return end
        if Y.hide_player_ui then
            if d.PlayerUI.OriginalStates[G] == nil then d.PlayerUI.OriginalStates[G] = { property = V, value = G[V] } end
            G[V] = false
            return
        end
        local y = d.PlayerUI.OriginalStates[G]
        if y then
            G[y.property] = y.value
            d.PlayerUI.OriginalStates[G] = nil
        end
    end,
    Apply = function()
        local G = y.PlayerGui
        if not G then return end
        for V in pairs(d.PlayerUI.TargetNames) do d.PlayerUI.ApplyObject(G:FindFirstChild(V)) end
    end,
    Start = function()
        if d.PlayerUI.Started then
            d.PlayerUI.Apply()
            return
        end
        d.PlayerUI.Started = true
        d.PlayerUI.Apply()
        y.PlayerGui.ChildAdded:Connect(function(G)
            if d.PlayerUI.TargetNames[G.Name] then
                task.defer(function()
                    d.PlayerUI
                        .ApplyObject(G)
                end)
            end
        end)
    end
}
d.PlayerUI.Start()
d.Teleport = {
    LockedBy = "",
    LockedUntil = 0,
    LockProtected = false,
    LockTeleport = function(G, V, y)
        G = tostring(G or "")
        V = tonumber(V) or 0
        y = y == true
        if G == "" or V <= 0 then return false end
        local Z = os.clock()
        local j = Z < d.Teleport.LockedUntil
        local i = j and d.Teleport.LockedBy == G
        if j and not i then
            if d.Teleport.LockProtected then return false end
            if not y then return false end
        end
        d.Teleport.LockedBy = G
        d.Teleport.LockedUntil = Z + V
        d.Teleport.LockProtected = y or i and d.Teleport.LockProtected
        return true
    end,
    UnlockTeleport = function(G)
        if d.Teleport.LockedBy ~= tostring(G or "") then return false end
        d.Teleport.LockedBy = ""
        d.Teleport.LockedUntil = 0
        d.Teleport.LockProtected = false
        return true
    end,
    IsLocked = function(G)
        if os.clock() >= d.Teleport.LockedUntil then
            d.Teleport.LockedBy = ""
            d.Teleport.LockedUntil = 0
            d.Teleport.LockProtected = false
            return false
        end
        return d.Teleport.LockedBy ~= tostring(G or "")
    end,
    GetCurrentPosition = function()
        local G = y.Character and y.Character:FindFirstChild("HumanoidRootPart")
        return G and G.CFrame or nil
    end,
    TeleportToCFrame = function(G, V)
        if typeof(G) ~= "CFrame" then return false end
        if d.Teleport.IsLocked(V) then return false end
        local Z = y.Character
        local j = Z and Z:FindFirstChild("HumanoidRootPart")
        local i = Z and Z:FindFirstChildOfClass("Humanoid")
        if not Z or not Z.Parent or not j or not i or i.Health <= 0 then return false end
        i:Move(Vector3.zero)
        j.AssemblyLinearVelocity = Vector3.zero
        j.AssemblyAngularVelocity = Vector3.zero
        Z:PivotTo(G)
        j.AssemblyLinearVelocity = Vector3.zero
        j.AssemblyAngularVelocity = Vector3.zero
        return true
    end,
    TeleportTo = function(G, V, y)
        if not G or not G.Parent then return false end
        local Z
        if G:IsA("Model") then Z = G:GetPivot() elseif G:IsA("BasePart") then Z = G.CFrame end
        if not Z then return false end
        if V then Z = Z + Vector3.new(5, 0, 0) end
        return d.Teleport.TeleportToCFrame(Z, y)
    end,
    GetLockRemaining = function()
        local G = d.Teleport.LockedUntil - os.clock()
        if G <= 0 then
            d.Teleport.LockedBy = ""
            d.Teleport.LockedUntil = 0
            d.Teleport.LockProtected = false
            return 0
        end
        return math.ceil(G)
    end,
    GetLockDisplayName = function() return tostring(d.Teleport.LockedBy or "") end,
    GetLockStatusText = function()
        local G = d.Teleport.GetLockRemaining()
        if G <= 0 then return "" end
        return string.format(
            "<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\148\146 [Teleport]</font> <font color=\'#FFCC66\'>Locked: %s (%ds)</font></stroke>",
            d.Teleport.GetLockDisplayName(), G)
    end
}
d.GameTeleport = {
    Destinations = { Garden = true, Seeds = true, Sell = true },
    Request = function(G, V)
        G = tostring(G or "")
        V = tostring(V or "")
        if not d.GameTeleport.Destinations[G] then return false end
        local Z = y.Networking and (y.Networking.TeleportButton and y.Networking.TeleportButton.Request)
        if not Z or type(Z.Fire) ~= "function" then return false end
        if V ~= "" and d.Teleport.IsLocked(V) then return false end
        if V ~= "" and not d.Teleport.LockTeleport(V, 5, true) then return false end
        local j, i = pcall(function() Z:Fire(G) end)
        if not j then
            if V ~= "" then d.Teleport.UnlockTeleport(V) end
            warn("[Game Teleport]", i)
            return false
        end
        return true
    end,
    Garden = function(G) return d.GameTeleport.Request("Garden", G) end,
    Seeds = function(G)
        return d.GameTeleport
            .Request("Seeds", G)
    end,
    Sell = function(G) return d.GameTeleport.Request("Sell", G) end
}
d.StepTeleport = {
    Busy = false,
    Cancelled = false,
    StepSize = 9,
    StepDelay = .35 *
        ((100 / math.clamp(tonumber(Y.step_teleport_speed) or 100, 25, 500))),
    ReachDistance = 3,
    GetCFrame = function(G)
        if typeof(G) == "CFrame" then return G end
        if typeof(G) == "Vector3" then return CFrame.new(G) end
        if typeof(G) ~= "Instance" or not G.Parent then return nil end
        if G:IsA("BasePart") then return G.CFrame end
        if G:IsA("Model") then return G:GetPivot() end
        local V = G:FindFirstChildWhichIsA("BasePart", true)
        return V and V.CFrame or nil
    end,
    GetIgnoreObject = function(G)
        if typeof(G) ~= "Instance" then return nil end
        if G:IsA("Model") then return G end
        local V = G:FindFirstAncestorOfClass("Model")
        return V or G
    end,
    GetCharacter = function()
        local G = y.Character
        local V = G and G:FindFirstChild("HumanoidRootPart")
        local Z = G and G:FindFirstChildOfClass("Humanoid")
        if not G or not G.Parent or not V or not Z or Z.Health <= 0 then return nil end
        return G, V, Z
    end,
    FindGroundPosition = function(G, V)
        if typeof(V) ~= "Vector3" then return nil end
        local Z = y.Character
        local j = d.StepTeleport.GetIgnoreObject(G)
        local i = RaycastParams.new()
        local c = {}
        if Z then table.insert(c, Z) end
        if j then table.insert(c, j) end
        i.FilterType = Enum.RaycastFilterType.Exclude
        i.FilterDescendantsInstances = c
        local J = { V }
        for G = 4, 20, 4 do
            for y = 0, 315, 45 do
                local Z = math.rad(y)
                table.insert(J, V + Vector3.new(math.cos(Z) * G, 0, math.sin(Z) * G))
            end
        end
        for G, V in ipairs(J) do
            local y = workspace:Raycast(V + Vector3.new(0, 40, 0), Vector3.new(0, -100, 0), i)
            if y and y.Normal.Y >= .45 then return y.Position + Vector3.new(0, 3, 0) end
        end
        return nil
    end,
    Begin = function(G, V)
        G = tostring(G or "")
        if d.StepTeleport.Busy or d.Teleport.IsLocked(G) then return nil end
        local y, Z, j = d.StepTeleport.GetCharacter()
        if not y then return nil end
        local i = G ~= "" and (os.clock() < d.Teleport.LockedUntil and d.Teleport.LockedBy == G)
        local c = false
        if G ~= "" then
            if not d.Teleport.LockTeleport(G, V or 30, true) then return nil end
            c = not i
        end
        d.StepTeleport.Busy = true
        d.StepTeleport.Cancelled = false
        return { Character = y, Root = Z, Humanoid = j, Caller = G, AcquiredLock = c }
    end,
    Finish = function(G)
        if type(G) == "table" and (G.AcquiredLock and G.Caller ~= "") then d.Teleport.UnlockTeleport(G.Caller) end
        d.StepTeleport.Busy = false
        d.StepTeleport.Cancelled = false
    end,
    MoveSegment = function(G, V, y)
        if type(G) ~= "table" or typeof(V) ~= "Vector3" then return false end
        local Z = G.Root
        if not Z or not Z.Parent then return false end
        local j = ((V - Z.Position)).Magnitude
        local i = math.max(math.ceil(j / d.StepTeleport.StepSize) + 6, 6)
        local c = 0
        local J = math.huge
        local T = 0
        while true do
            if d.StepTeleport.Cancelled then return false end
            local Z = G.Character
            local j = G.Root
            local u = G.Humanoid
            if not Z or not Z.Parent or not j or not j.Parent or not u or u.Health <= 0 then return false end
            local q = Z:GetPivot()
            local g = V - q.Position
            local E = g.Magnitude
            c += 1
            if c > i then
                warn("[StepTeleport] Maximum steps reached")
                return false
            end
            if E >= J - .25 then T += 1 else T = 0 end
            if T >= 4 then
                warn("[StepTeleport] Movement stuck")
                return false
            end
            J = E
            if E <= d.StepTeleport.ReachDistance then return true end
            local a = math.min(d.StepTeleport.StepSize, E)
            local H = q.Position + g.Unit * a
            local r = q.Rotation
            if E <= d.StepTeleport.StepSize and typeof(y) == "CFrame" then r = y end
            local Y = CFrame.new(H) * r
            u:Move(Vector3.zero)
            j.AssemblyLinearVelocity = Vector3.zero
            j.AssemblyAngularVelocity = Vector3.zero
            Z:PivotTo(Y)
            j.AssemblyLinearVelocity = Vector3.zero
            j.AssemblyAngularVelocity = Vector3.zero
            if G.Caller ~= "" then d.Teleport.LockTeleport(G.Caller, 2, true) end
            task.wait(d.StepTeleport.StepDelay)
            if not j.Parent or ((j.Position - H)).Magnitude > 6 then
                warn("[StepTeleport] Server correction detected")
                return false
            end
        end
    end,
    ToCFrame = function(G, V)
        if typeof(G) ~= "CFrame" then return false end
        local y, Z = d.StepTeleport.GetCharacter()
        if not y then return false end
        local j = ((Z.Position - G.Position)).Magnitude
        local i = math.ceil(j / d.StepTeleport.StepSize) * d.StepTeleport.StepDelay + 5
        local c = d.StepTeleport.Begin(V, i)
        if not c then return false end
        local J, T = pcall(function() return d.StepTeleport.MoveSegment(c, G.Position, G.Rotation) end)
        task.wait(.5)
        if J and (T and (c.Root and c.Root.Parent)) then T = ((c.Root.Position - G.Position)).Magnitude <= 5 end
        d.StepTeleport.Finish(c)
        if not J then
            warn("[StepTeleport]", T)
            return false
        end
        return T == true
    end,
    To = function(G, V, y)
        local Z = d.StepTeleport.GetCFrame(G)
        if not Z then return false end
        if typeof(V) == "Vector3" then Z = Z + V end
        return d.StepTeleport.ToCFrame(Z, y)
    end,
    PathTo = function(G, V)
        local Z = d.StepTeleport.GetCFrame(G)
        if not Z then return false end
        local j = d.StepTeleport.Begin(V, 60)
        if not j then return false end
        local i = false
        local c, J = pcall(function()
            local V = d.StepTeleport.FindGroundPosition(G, Z.Position)
            if not V then return false end
            local i = y.PathfindingService:CreatePath({ AgentRadius = 2, AgentHeight = 5, AgentCanJump = true, AgentCanClimb = true, WaypointSpacing = 6 })
            i:ComputeAsync(j.Root.Position, V)
            if i.Status ~= Enum.PathStatus.Success then return false end
            local c = i:GetWaypoints()
            for G = 2, #c, 1 do if not d.StepTeleport.MoveSegment(j, c[G].Position) then return false end end
            task.wait(.5)
            return ((j.Root.Position - V)).Magnitude <= 5
        end)
        if c then i = J == true else warn("[StepTeleport]", J) end
        d.StepTeleport.Finish(j)
        return i
    end,
    Stop = function() d.StepTeleport.Cancelled = true end
}
d.Movement = {
    WalkSpeed = 140,
    Timeout = 30,
    StopDistance = 5,
    GetPosition = function(G)
        if typeof(G) == "Vector3" then return G end
        if typeof(G) == "CFrame" then return G.Position end
        if typeof(G) ~= "Instance" or not G.Parent then return nil end
        if G:IsA("BasePart") then return G.Position end
        if G:IsA("Model") then return (G:GetPivot()).Position end
        local V = G:FindFirstChildWhichIsA("BasePart", true)
        return V and V.Position or nil
    end,
    IsTargetValid = function(G)
        if typeof(G) == "Vector3" or typeof(G) == "CFrame" then return true end
        return typeof(G) == "Instance" and G.Parent ~= nil
    end,
    Distance2D = function(G, V)
        if typeof(G) ~= "Vector3" or typeof(V) ~= "Vector3" then return math.huge end
        local y = G - V
        return (Vector2.new(y.X, y.Z)).Magnitude
    end,
    GetTargetIgnoreObject = function(G)
        if typeof(G) ~= "Instance" then return nil end
        if G:IsA("Model") then return G end
        local V = G.Parent
        while V and V ~= workspace do
            if V:IsA("Model") then return V end
            V = V.Parent
        end
        return G
    end,
    MoveToPoint = function(G, V, y, Z, j)
        if not G or not V or typeof(y) ~= "Vector3" then return false end
        Z = math.max(tonumber(Z) or 5, .2)
        j = math.clamp(tonumber(j) or 40, 16, 50)
        G.WalkSpeed = j
        G.Sit = false
        G:MoveTo(y)
        local i = os.clock()
        while os.clock() - i < Z do
            if not G.Parent or G.Health <= 0 or not V.Parent then return false end
            G.WalkSpeed = j
            if d.Movement.Distance2D(V.Position, y) <= 3.5 then return true end
            task.wait(.05)
        end
        return d.Movement.Distance2D(V.Position, y) <= 4
    end,
    FindWalkablePath = function(G, V, Z, j)
        local i = d.Movement.GetPosition(G)
        if not i or not V or not Z or not y.PathfindingService then return nil, nil end
        local c = RaycastParams.new()
        local J = { V }
        local T = d.Movement.GetTargetIgnoreObject(G)
        if T then table.insert(J, T) end
        c.FilterType = Enum.RaycastFilterType.Exclude
        c.FilterDescendantsInstances = J
        local u = { i }
        for G = 5, 25, 5 do
            for V = 0, 315, 45 do
                local y = math.rad(V)
                table.insert(u, i + Vector3.new(math.cos(y) * G, 0, math.sin(y) * G))
            end
        end
        for G, V in ipairs(u) do
            if j and os.clock() >= j then break end
            local i = workspace:Raycast(V + Vector3.new(0, 40, 0), Vector3.new(0, -100, 0), c)
            if not i or i.Normal.Y < .45 then continue end
            local J = i.Position + Vector3.new(0, 2.5, 0)
            local T = y.PathfindingService:CreatePath({ AgentRadius = 2, AgentHeight = 5, AgentCanJump = true, AgentCanClimb = true, WaypointSpacing = 4 })
            local d = pcall(function() T:ComputeAsync(Z.Position, J) end)
            if d and (T.Status == Enum.PathStatus.Success and #T:GetWaypoints() > 0) then return T, J end
        end
        return nil, nil
    end,
    PathTo = function(G, V, Z, j)
        V = math.clamp(tonumber(V) or d.Movement.WalkSpeed, 16, 50)
        Z = math.max(tonumber(Z) or d.Movement.Timeout, 5)
        j = tostring(j or "")
        if not d.Movement.IsTargetValid(G) then return false end
        if d.Teleport.IsLocked(j) then return false end
        local i = j ~= "" and (os.clock() < d.Teleport.LockedUntil and d.Teleport.LockedBy == j)
        local c = false
        if j ~= "" then
            if not d.Teleport.LockTeleport(j, Z + 2, true) then return false end
            c = not i
        end
        local J = y.Character
        local T = J and J:FindFirstChildOfClass("Humanoid")
        local u = J and J:FindFirstChild("HumanoidRootPart")
        if not J or not J.Parent or not T or T.Health <= 0 or not u then
            if c then d.Teleport.UnlockTeleport(j) end
            return false
        end
        local q = T.WalkSpeed
        local g = os.clock() + Z
        local E = false
        T.WalkSpeed = V
        T.Sit = false
        local a, H = pcall(function()
            for y = 1, 5, 1 do
                if os.clock() >= g or not d.Movement.IsTargetValid(G) or not J.Parent or T.Health <= 0 then break end
                local Z = d.Movement.GetPosition(G)
                if Z and d.Movement.Distance2D(u.Position, Z) <= d.Movement.StopDistance then
                    E = true
                    break
                end
                local i, c = d.Movement.FindWalkablePath(G, J, u, g)
                if not i or not c then
                    warn("[Path Movement] No walkable route found")
                    break
                end
                local q = i:GetWaypoints()
                local a = false
                local H = 1
                local r = i.Blocked:Connect(function(G) if G >= H then a = true end end)
                for y = 2, #q, 1 do
                    if a or os.clock() >= g or not d.Movement.IsTargetValid(G) or not J.Parent or T.Health <= 0 then break end
                    H = y
                    local Z = q[y]
                    if Z.Action == Enum.PathWaypointAction.Jump then T.Jump = true end
                    if j ~= "" then d.Teleport.LockTeleport(j, math.max(g - os.clock(), 2), true) end
                    local i = g - os.clock()
                    local c = d.Movement.MoveToPoint(T, u, Z.Position, math.min(5, i), V)
                    if not c then
                        a = true
                        break
                    end
                end
                r:Disconnect()
                if d.Movement.Distance2D(u.Position, c) <= d.Movement.StopDistance then
                    E = true
                    break
                end
                task.wait(.1)
            end
        end)
        if T and T.Parent then
            T.WalkSpeed = q
            if u and u.Parent then T:MoveTo(u.Position) end
        end
        if j ~= "" then if c then d.Teleport.UnlockTeleport(j) else d.Teleport.LockTeleport(j, 2, true) end end
        if not a then
            warn("[Path Movement]", H)
            return false
        end
        return E
    end
}
d.ProximityPrompt = {
    ActivateProximityPrompt = function(G)
        if not G or not G:IsA("ProximityPrompt") then return end
        local V = G.HoldDuration
        local y = G.MaxActivationDistance
        G.HoldDuration = 0
        G.MaxActivationDistance = 10000
        fireproximityprompt(G)
        G.HoldDuration = V
        G.MaxActivationDistance = y
    end,
    FindProximityPrompt = function(G, V) return G:FindFirstChild(V, true) end,
    FindProximityPromptByClass = function(G)
        if not G then return nil end
        return G:FindFirstChildWhichIsA("ProximityPrompt", true)
    end
}
d.Backpack = {
    GetBackpackAllItems = function()
        local G = {}
        local V = y.LocalPlayer:FindFirstChild("Backpack")
        if not V then V = y.LocalPlayer:FindFirstChild("Backpack") end
        if not V then return G end
        local Z = d.Player.GetTool_Holding()
        if Z then table.insert(G, Z) end
        for V, y in ipairs(V:GetChildren()) do table.insert(G, y) end
        return G
    end,
    GetAllSeedTools = function()
        local G = {}
        local V = d.Backpack.GetBackpackAllItems()
        for V, y in ipairs(V) do
            local Z = y:GetAttribute("SeedTool")
            if not Z then continue end
            table.insert(G, y)
        end
        return G
    end,
    GetSeedToolAndCountUsingName = function(G)
        local V = y.LocalPlayer:FindFirstChild("Backpack")
        local Z = V:FindFirstChild(G)
        if not Z then Z = d.Player.GetTool_Holding() end
        local j = Z and Z:GetAttribute("SeedTool") or nil
        if not j then return nil, 0 end
        local i = Z and Z:GetAttribute("Count") or 0
        return Z, i
    end,
    GetAllFruits = function()
        local G = {}
        local V = d.Backpack.GetBackpackAllItems()
        for V, y in ipairs(V) do
            local Z = y:GetAttribute("Fruit")
            local j = y:GetAttribute("FruitName")
            if not j then continue end
            local i = y:GetAttribute("Id") or ""
            local c = tonumber(y:GetAttribute("weight") or 0)
            local J = { ob = y, id = i, w = c }
            table.insert(G, J)
        end
        table.sort(G, function(G, V) return G.w > V.w end)
        return G
    end
}
J.MyFarmPlot = nil
J.OtherPlayerPlots = {}
d.Farm = {
    _Random = Random.new(),
    GetOwnPlot = function()
        if J.MyFarmPlot and (J.MyFarmPlot.Parent and tonumber(J.MyFarmPlot:GetAttribute("OwnerUserId")) == tonumber(J.player_userid)) then
            return
                J.MyFarmPlot
        end
        J.MyFarmPlot = nil
        local G = y.Workspace:FindFirstChild("Gardens")
        if not G then return nil end
        for G, V in ipairs(G:GetChildren()) do
            if tonumber(V:GetAttribute("OwnerUserId")) == tonumber(J.player_userid) then
                J.MyFarmPlot = V
                return V
            end
        end
        return nil
    end,
    GetPlantArea = function(G)
        if G ~= "PlantAreaColumn1" and G ~= "PlantAreaColumn2" then return nil end
        local V = d.Farm.GetOwnPlot()
        local y = V and V:FindFirstChild("Visual")
        local Z = y and y:FindFirstChild(G)
        return Z and (Z:IsA("BasePart") and Z) or nil
    end,
    TeleportToCenter = function(G)
        local V = d.Farm.GetCenterPointPart()
        if not V then return false end
        local y
        if V:IsA("BasePart") then y = V.CFrame elseif V:IsA("Model") then y = V:GetPivot() end
        if not y then return false end
        return d.Teleport.TeleportToCFrame(y * CFrame.new(0, 3, 0), G)
    end,
    GetPlantAreaAtPosition = function(G)
        if typeof(G) ~= "Vector3" then return nil, nil end
        for V, y in ipairs(d.Farm.GetPlantAreas()) do
            local Z = y.CFrame:PointToObjectSpace(G)
            if math.abs(Z.X) <= y.Size.X / 2 and math.abs(Z.Z) <= y.Size.Z / 2 then return y, Z end
        end
        return nil, nil
    end,
    GetMyPlantsFolder = function()
        local G = d.Farm.GetOwnPlot()
        if not G then return nil end
        return G:FindFirstChild("Plants")
    end,
    GetMyPlantsFoldersNotMine = function()
        if #J.OtherPlayerPlots > 0 then return J.OtherPlayerPlots end
        J.OtherPlayerPlots = {}
        local G = y.Workspace:FindFirstChild("Gardens")
        if not G then return J.OtherPlayerPlots end
        for G, V in ipairs(G:GetChildren()) do
            if tonumber(V:GetAttribute("OwnerUserId")) ~= tonumber(J.player_userid) then
                table.insert(J.OtherPlayerPlots, V)
            end
        end
        return J.OtherPlayerPlots
    end,
    GetPlants = function()
        local G = {}
        local V = d.Farm.GetOwnPlot()
        if not V then return G end
        local y = V:FindFirstChild("Plants")
        if not y then return G end
        for V, y in ipairs(y:GetChildren()) do table.insert(G, y) end
        local Z = J.alt_Plants_Physical[J.player_userid]
        if Z then for V, y in ipairs(Z:GetChildren()) do table.insert(G, y) end end
        return G
    end,
    GetPermanentCenterCFrame = function()
        local G = d.Farm.GetCenterPointPart()
        if G and G:IsA("BasePart") then return G.CFrame end
        if G and G:IsA("Model") then return G:GetPivot() end
        return nil
    end,
    GetPermanentCenterPosition = function()
        local G = d.Farm.GetPermanentCenterCFrame()
        return G and G.Position or nil
    end,
    ProjectPositionToPlantArea = function(G, V)
        if typeof(G) ~= "Vector3" then return nil, nil, nil end
        V = math.max(tonumber(V) or 1, 0)
        local y
        local Z
        local j
        local i = math.huge
        for c, J in ipairs(d.Farm.GetPlantAreas()) do
            local T = J.CFrame:PointToObjectSpace(G)
            local d = math.max(J.Size.X / 2 - V, 0)
            local u = math.max(J.Size.Z / 2 - V, 0)
            local q = math.clamp(T.X, -d, d)
            local g = math.clamp(T.Z, -u, u)
            local E = Vector3.new(q, J.Size.Y / 2, g)
            local a = J.CFrame:PointToWorldSpace(E)
            local H = ((a - G)).Magnitude
            if H < i then
                i = H
                y = a
                Z = J
                j = E
            end
        end
        return y, Z, j
    end,
    GetPermanentPlantPosition = function(G)
        local V = d.Farm.GetPermanentCenterPosition()
        if typeof(V) ~= "Vector3" then return nil, nil, nil end
        return d.Farm.ProjectPositionToPlantArea(V, G)
    end,
    GetPlantedSeedCounts = function()
        local G = {}
        for V, y in ipairs(d.Farm.GetPlants()) do
            local Z = y:GetAttribute("SeedName")
            if Z then G[Z] = ((G[Z] or 0)) + 1 end
        end
        return G
    end,
    GetSpawnPoint = function()
        local G = d.Farm.GetOwnPlot()
        if not G then return nil end
        return G:FindFirstChild("SpawnPoint")
    end,
    GetPlantAreas = function()
        local G = {}
        local V = d.Farm.GetOwnPlot()
        if not V then return G end
        local y = V:FindFirstChild("Visual")
        if not y then return G end
        local Z = { "PlantAreaColumn1", "PlantAreaColumn2" }
        for V, Z in ipairs(Z) do
            local j = y:FindFirstChild(Z)
            if j and j:IsA("BasePart") then table.insert(G, j) end
        end
        return G
    end,
    GetCenterPointPart = function()
        local G = d.Farm.GetOwnPlot()
        if not G then return nil end
        local V = G:FindFirstChild("Visual")
        if not V then return nil end
        local y = V:FindFirstChild("PRIM")
        return y
    end,
    DistanceFromPoint = function()
        local G = d.Farm.GetCenterPointPart()
        if not G then return math.huge end
        local V = (y.LocalPlayer and y.LocalPlayer.Character) or y.Character
        local Z = V and V:FindFirstChild("HumanoidRootPart")
        if not Z then return math.huge end
        local j
        if G:IsA("BasePart") then
            j = G.Position
        elseif G:IsA("Model") then
            j = (G:GetPivot()).Position
        else
            return math
                .huge
        end
        return ((Z.Position - j)).Magnitude
    end,
    IsNearFarm = function(G)
        G = tonumber(G) or 15
        return d.Farm.DistanceFromPoint() <= G
    end,
    EnsureAtFarm = function(G)
        G = tonumber(G) or 15
        if d.Farm.IsNearFarm(G) then return true end
        local V = d.Farm.GetSpawnPoint()
        if not V or not V:IsA("BasePart") then return false end
        local Z = y.LocalPlayer and y.LocalPlayer.Character or y.Character
        if not Z or not Z.Parent then return false end
        local j = d.Teleport.TeleportToCFrame(V.CFrame * CFrame.new(0, 3, 0), "EnsureAtFarm")
        if not j then return false end
        task.wait(.15)
        return true
    end,
    GetRandomLocationForSeed = function(G)
        local V = d.Farm.GetPlantAreas()
        if #V == 0 then return nil end
        local y = V[d.Farm._Random:NextInteger(1, #V)]
        local Z = math.max(tonumber(G) or .5, 0)
        local j = math.max((y.Size.X / 2) - Z, 0)
        local i = math.max((y.Size.Z / 2) - Z, 0)
        local c = d.Farm._Random:NextNumber(-j, j)
        local J = d.Farm._Random:NextNumber(-i, i)
        local T = Vector3.new(c, y.Size.Y / 2, J)
        local u = y.CFrame:PointToWorldSpace(T)
        return u, y
    end
}
H.Hop = {
    Random = Random.new((((os.time() + J.player_userid) + math.floor(os.clock() * 100000))) % 2147483647),
    MaxPlayers = 8,
    PagesPerDirection = 4,
    TriedServers = {},
    TeleportToJobId = function(
        G, V)
        local Z = y.LocalPlayer
        G = tostring(G or "")
        V = tonumber(V) or game.PlaceId
        if not Z or G == "" then
            warn("[Hop] Missing player or JobId")
            return false
        end
        if not V or V <= 0 then
            warn("[Hop] Invalid PlaceId")
            return false
        end
        if G == game.JobId then
            warn("[Hop] Already in selected server")
            return false
        end
        local j, i = pcall(function() y.TeleportService:TeleportToPlaceInstance(V, G, Z) end)
        if not j then
            warn("[Hop] Teleport failed:", i)
            return false
        end
        return true
    end,
    GetFriendServerIds = function()
        local G = {}
        local V = y.LocalPlayer
        if not V then return G end
        local Z, j = pcall(function() return V:GetFriendsOnlineAsync(200) end)
        if not Z or type(j) ~= "table" then return G end
        for V, y in ipairs(j) do
            if type(y) ~= "table" then continue end
            local Z = tonumber(y.PlaceId)
            local j = tostring(y.GameId or "")
            if Z == game.PlaceId and j ~= "" then G[j] = true end
        end
        return G
    end,
    FetchServers = function(G, V, Z, j)
        if G ~= "Asc" and G ~= "Desc" then return false end
        local i = nil
        for c = 1, H.Hop.PagesPerDirection, 1 do
            local J = string.format(
                "https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=%s&excludeFullGames=true&limit=100",
                game.PlaceId,
                G)
            if i then J = J .. ("&cursor=" .. y.HttpService:UrlEncode(i)) end
            local T, d = pcall(function() return y.HttpService:JSONDecode(game:HttpGet(J)) end)
            if not T or type(d) ~= "table" or type(d.data) ~= "table" then break end
            for G, y in ipairs(d.data) do
                if type(y) ~= "table" then continue end
                local i = tostring(y.id or "")
                local c = tonumber(y.playing)
                local J = tonumber(y.maxPlayers)
                if i == "" or V[i] or j[i] then continue end
                if not c or J ~= H.Hop.MaxPlayers or c < 0 or c >= J then continue end
                j[i] = true
                table.insert(Z, y)
            end
            i = d.nextPageCursor
            if type(i) ~= "string" or i == "" then break end
            task.wait(.1)
        end
        return true
    end,
    FindRandomServer = function()
        local G = H.Hop.GetFriendServerIds()
        G[game.JobId] = true
        for V in pairs(H.Hop.TriedServers) do G[V] = true end
        local V = {}
        local y = {}
        H.Hop.FetchServers("Asc", G, V, y)
        H.Hop.FetchServers("Desc", G, V, y)
        if #V == 0 then
            warn("[Hop] No random non-friend server found")
            return nil
        end
        local Z = H.Hop.Random:NextInteger(1, #V)
        local j = V[Z]
        local i = tostring(j.id or "")
        if i == "" then return nil end
        H.Hop.TriedServers[i] = true
        print(string.format("[Hop] Random server: %s (%d/%d) | Pool: %d", i, tonumber(j.playing) or 0,
            tonumber(j.maxPlayers) or 0, #V))
        return i, j
    end,
    HopToNewServer = function()
        local G = H.Hop.FindRandomServer()
        if not G then return false end
        return H.Hop.TeleportToJobId(G, game.PlaceId)
    end,
    HopToNewServerUsingJobid = function(G) return H.Hop.TeleportToJobId(G, game.PlaceId) end
}
d.AntiAfk = {
    RequestHop = function()
        local G = y.Networking
        if not G then return end
        local V = G.AntiAfk and G.AntiAfk.RequestHop
        if not V then
            warn("AntiAfk.RequestHop was not found")
            return false
        end
        V:Fire()
        return true
    end
}
J.SellStatusText = ""
d.SellManager = {
    Busy = false,
    DailyDealRetryAt = 0,
    DailyDealKnown = false,
    DailyDealAvailable = false,
    DailyDealNextCheckAt = 0,
    FormatDailyDealTime = function(
        G)
        G = math.max(math.floor(tonumber(G) or 0), 0)
        local V = math.floor(G / 3600)
        local y = math.floor(((G % 3600)) / 60)
        local Z = G % 60
        if V > 0 then return string.format("%dh %02dm", V, y) end
        if y > 0 then return string.format("%dm %02ds", y, Z) end
        return tostring(Z) .. "s"
    end,
    SetStatus = function(G, V)
        if type(G) ~= "string" or G == "" then
            J.SellStatusText = ""
            return
        end
        J.SellStatusText = string.format(
            "<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\146\176 [Seller]</font> <font color=\'%s\'>%s</font></stroke>",
            tostring(V or "#FFFFFF"), G)
    end,
    ReadDailyDealAvailable = function(G)
        if type(G) == "boolean" then return G end
        if type(G) == "string" then
            local V = string.lower(G)
            if V == "available" or V == "ready" or V == "true" then return true end
            if V == "used" or V == "unavailable" or V == "false" then return false end
            return nil
        end
        if type(G) ~= "table" then return nil end
        if G.Used == true or G.used == true or G.Claimed == true or G.claimed == true then return false end
        if G.Used == false or G.used == false then return true end
        local V = { "Available", "available", "IsAvailable", "isAvailable", "CanUse", "canUse", "Eligible", "eligible",
            "HasDeal", "hasDeal", "DailyDealAvailable", "dailyDealAvailable" }
        for V, y in ipairs(V) do if type(G[y]) == "boolean" then return G[y] end end
        local y = G.DailyDeal or G.dailyDeal or G.Deal or G.deal
        if y ~= nil then return d.SellManager.ReadDailyDealAvailable(y) end
        local Z = G.Status or G.status or G.Message or G.message
        if Z ~= nil then return d.SellManager.ReadDailyDealAvailable(Z) end
        if G[1] ~= nil then return d.SellManager.ReadDailyDealAvailable(G[1]) end
        return nil
    end,
    CheckDailyDeal = function(G)
        if not Y.auto_use_daily_deal then
            d.SellManager.DailyDealKnown = false
            d.SellManager.DailyDealAvailable = false
            return false
        end
        if not G and os.clock() < d.SellManager.DailyDealNextCheckAt then
            return d.SellManager.DailyDealKnown and
                d.SellManager.DailyDealAvailable
        end
        local V = y.Networking and (y.Networking.NPCS and y.Networking.NPCS.CheckDailyDeal)
        if not V or type(V.Fire) ~= "function" then return false end
        d.SellManager.DailyDealNextCheckAt = os.clock() + 5
        local Z, j = V:Fire()
        local i = d.SellManager.ReadDailyDealAvailable(Z)
        if i == nil then i = d.SellManager.ReadDailyDealAvailable(j) end
        d.SellManager.DailyDealKnown = i ~= nil
        d.SellManager.DailyDealAvailable = i == true
        return d.SellManager.DailyDealAvailable
    end,
    SellFruit = function(G)
        if type(G) ~= "string" or G == "" then return false, nil end
        local V = y.Networking and (y.Networking.NPCS and y.Networking.NPCS.SellFruit)
        if not V or type(V.Fire) ~= "function" then return false, nil end
        return true, V:Fire(G)
    end,
    GetFruitBid = function(G)
        if type(G) ~= "string" or G == "" then return nil end
        local V = y.Networking and (y.Networking.NPCS and y.Networking.NPCS.GetFruitBid)
        if not V or type(V.Fire) ~= "function" then return nil end
        return V:Fire(G)
    end,
    PreviewSellAll = function()
        local G = y.Networking and (y.Networking.NPCS and y.Networking.NPCS.PreviewSellAll)
        if not G or type(G.Fire) ~= "function" then return nil end
        return G:Fire()
    end,
    UseDailyDealAll = function()
        local G = y.Networking and (y.Networking.NPCS and y.Networking.NPCS.UseDailyDealAll)
        if not G or type(G.Fire) ~= "function" then return false, nil end
        local V = d.PlayerData.GetFruitCount()
        local Z = tonumber(d.Money.GetSheckles()) or 0
        if V <= 0 then return false, nil end
        d.SellManager.SetStatus(string.format("Trying Daily Deal on %d fruits...", V), "#FFD966")
        local j, i = pcall(function() return G:Fire() end)
        if not j then
            d.SellManager.DailyDealRetryAt = os.clock() + 60
            warn("[Daily Deal]", i)
            return false, nil
        end
        if type(i) == "table" and i.Success == false then
            local G = math.max(math.floor(tonumber(i.TimeRemaining) or 60), 1)
            d.SellManager.DailyDealRetryAt = (os.clock() + G) + 2
            d.SellManager.SetStatus(string.format("Daily Deal in %s", d.SellManager.FormatDailyDealTime(G)), "#FFCC66")
            return false, i
        end
        local J = V
        local T = Z
        local u = os.clock()
        repeat
            task.wait(.1)
            J = d.PlayerData.GetFruitCount()
            T = tonumber(d.Money.GetSheckles()) or Z
        until J < V or T > Z or os.clock() - u >= 3
        local q = type(i) == "table" and i.Success == true or J < V or T > Z
        if not q then
            d.SellManager.DailyDealRetryAt = os.clock() + 60
            d.SellManager.SetStatus("Daily Deal failed - selling normally", "#FF6666")
            return false, i
        end
        local g = math.max(T - Z, 0)
        local E = type(i) == "table" and tonumber(i.TimeRemaining) or 86400
        d.SellManager.DailyDealRetryAt = os.clock() + math.max(E, 60)
        d.SellManager.SetStatus(string.format("Daily Deal used | +$%s", c.formatShecklesNumber(g)), "#66FF99")
        return true, { result = i, fruits = V, earned = g, beforeSheckles = Z, afterSheckles = T }
    end,
    SellUsingBackpack = function()
        local G = d.Backpack.GetAllFruits()
        for G, V in ipairs(G) do
            d.SellManager.SellFruit(V.id)
            task.wait(.05)
        end
    end,
    SellAllInternal = function()
        local G = d.PlayerData.GetFruitCount()
        if G <= 0 then
            d.SellManager.SetStatus("")
            return false, nil
        end
        local V = d.FruitCollect.IsMaxFruitInventory()
        local Z = math.max(math.ceil(d.SellManager.DailyDealRetryAt - os.clock()), 0)
        if Y.auto_use_daily_deal and Z <= 0 then
            local y = d.PlayerData.GetMaxFruitCapacity()
            if not V then
                d.SellManager.SetStatus(string.format("Saving for Daily Deal %d/%d", G, y), "#FFD966")
                return false, "waiting_daily_deal"
            end
            local j, i = d.SellManager.UseDailyDealAll()
            if j then return true, i end
            Z = math.max(math.ceil(d.SellManager.DailyDealRetryAt - os.clock()), 0)
        end
        if Y.sell_when_backpack_full and not V then return false, "waiting_full" end
        local j = y.Networking and (y.Networking.NPCS and y.Networking.NPCS.SellAll)
        if not j or type(j.Fire) ~= "function" then return false, nil end
        local i = "Selling fruits normally..."
        if Y.auto_use_daily_deal and Z > 0 then
            i = string.format("Selling normally | Daily Deal in %s",
                d.SellManager.FormatDailyDealTime(Z))
        end
        d.SellManager.SetStatus(i, "#66CCFF")
        return true, j:Fire()
    end,
    SellAll = function()
        if not Y.auto_sell_sellallinventory then
            d.SellManager.SetStatus("")
            return false
        end
        if d.SellManager.Busy then return false end
        d.SellManager.Busy = true
        local G, V, y = pcall(d.SellManager.SellAllInternal)
        d.SellManager.Busy = false
        if not G then
            d.SellManager.SetStatus("Seller error", "#FF6666")
            warn("[SellManager]", V)
            return false, nil
        end
        return V, y
    end
}
d.FruitFilters = {
    GetFruitIds = function(G)
        if type(G) ~= "table" then return nil, nil end
        return G.plantId, G.fruitId
    end,
    IsFruitReady = function(G)
        if typeof(G) ~= "Instance" then return false end
        local V = tonumber(G:GetAttribute("Age"))
        local y = tonumber(G:GetAttribute("MaxAge"))
        return V ~= nil and (y ~= nil and (y > 0 and V >= y))
    end,
    GetFruitWeight = function(G)
        if not G then return 0, 0 end
        local V = y.FruitVisualizerController:CalculateFruitWeight(G)
        if type(V) ~= "number" then V = y.FruitVisualizerController:CalculatePlantWeight(G) end
        if type(V) ~= "number" then return 0, 0 end
        local Z = math.round(V * 100) / 100
        return Z, V
    end,
    GetAllFruits = function()
        local G = {}
        for V, y in ipairs(d.Farm.GetPlants()) do
            local Z = y:GetAttribute("PlantId")
            local j = y:FindFirstChild("Fruits")
            local i = tonumber(y:GetAttribute("Age") or 0)
            local c = tonumber(y:GetAttribute("MaxAge") or 1)
            if i < c then continue end
            if j then
                for V, j in ipairs(j:GetChildren()) do
                    local i = j:GetAttribute("CorePartName") or j:GetAttribute("SeedName") or y:GetAttribute("SeedName")
                    local c = j:GetAttribute("FruitId")
                    local T = d.FruitFilters.GetFruitWeight(j)
                    local u = J.SeedRarity[i] or "Common"
                    local q = j:GetAttribute("Mutation") or ""
                    table.insert(G, { ob = j, ob_plant = y, name = i, plantId = Z, fruitId = c, w = T, r = u, m = q })
                end
            else
                local V = y:GetAttribute("SeedName") or ""
                local j = d.FruitFilters.GetFruitWeight(y)
                local i = J.SeedRarity[V] or "Common"
                local c = y:GetAttribute("Mutation") or ""
                table.insert(G, { ob = y, ob_plant = y, name = V, plantId = Z, fruitId = "", w = j, r = i, m = c })
            end
        end
        table.sort(G,
            function(G, V)
                local y = J.RarityRank[G.r] or 0
                local Z = J.RarityRank[V.r] or 0
                if y ~= Z then return y > Z end
                local j = type(G.m) == "string" and G.m ~= ""
                local i = type(V.m) == "string" and V.m ~= ""
                if j ~= i then return j end
                return G.w > V.w
            end)
        return G
    end,
    GetFruitsUsingName = function(G)
        local V = {}
        if type(G) ~= "string" or G == "" then return V end
        for y, Z in ipairs(d.FruitFilters.GetAllFruits()) do if Z.name == G then table.insert(V, Z) end end
        return V
    end,
    GetReadyFruits = function(G)
        local V = {}
        local y
        if type(G) == "string" and G ~= "" then
            y = d.FruitFilters.GetFruitsUsingName(G)
        else
            y = d.FruitFilters
                .GetAllFruits()
        end
        for G, y in ipairs(y) do if d.FruitFilters.IsFruitReady(y.ob) then table.insert(V, y) end end
        return V
    end
}
d.ShovelTool = {
    GetTool = function()
        local G = d.Player.GetTool_Holding()
        if G and G:IsA("Tool") then
            local V = G:GetAttribute("Shovel")
            if type(V) == "string" and V ~= "" then return G end
        end
        local V = y.LocalPlayer and y.LocalPlayer:FindFirstChild("Backpack")
        if not V then return nil end
        for G, V in ipairs(V:GetChildren()) do
            if not V:IsA("Tool") then continue end
            local y = V:GetAttribute("Shovel")
            if type(y) == "string" and y ~= "" then return V end
        end
        return nil
    end,
    Equip = function()
        local G = d.ShovelTool.GetTool()
        if not G then return nil, false end
        if d.Player.IsToolHeld(G) then return G, false end
        if not d.Player.EquipTool(G) then return nil, false end
        task.wait(.15)
        if not d.Player.IsToolHeld(G) then return nil, false end
        return G, true
    end,
    Use = function(G, V, Z)
        if type(G) ~= "string" or G == "" then return false end
        if type(V) ~= "string" then return false end
        if not Z or not Z:IsA("Tool") then return false end
        if not y.Character or Z.Parent ~= y.Character then return false end
        local j = Z:GetAttribute("Shovel")
        if type(j) ~= "string" or j == "" then return false end
        local i = y.Networking and (y.Networking.Shovel and y.Networking.Shovel.UseShovel)
        if not i or type(i.Fire) ~= "function" then return false end
        local c = pcall(function() i:Fire(G, V, j, Z) end)
        return c
    end,
    Cleanup = function(G)
        if not G then return end
        d.Player.UnequipTools()
    end
}
J.ShovelStatusText = ""
d.ShovelFruits = {
    MaxPerLoop = 60,
    RequestDelay = .1,
    EquippedBySystem = false,
    TotalRemoved = 0,
    LastLoopRemoved = 0,
    SetStatus = function(
        G, V)
        G = tostring(G or "Waiting")
        V = tostring(V or "#FFFFFF")
        J.ShovelStatusText = string.format(
            "<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\226\154\160\239\184\143 [Fruit Shovel]</font> <font color=\'%s\'>%s</font></stroke>",
            V, G)
    end,
    ClearStatus = function() J.ShovelStatusText = "" end,
    SetWaitingStatus = function()
        d.ShovelFruits.SetStatus(
            string.format("Waiting | Removed: %d", d.ShovelFruits.TotalRemoved), "#CFCFCF")
    end,
    GetMutationNames = function()
        local G = {}
        local V = {}
        local Z = y.SharedModules
        local j = Z and Z:FindFirstChild("MutationData")
        if j then
            for y, Z in ipairs(j:GetChildren()) do
                if Z:IsA("ModuleScript") then
                    local y = Z.Name
                    if y ~= "Gold" and (y ~= "Rainbow" and not V[y]) then
                        V[y] = true
                        table.insert(G, y)
                    end
                end
            end
        end
        if #G == 0 then G = { "Bloodlit", "Chained", "Electric", "Frozen", "Starstruck" } end
        table.sort(G)
        return G
    end,
    GetVariantNames = function() return { "Normal", "Gold", "Rainbow" } end,
    GetFruitTypeDropdown = function()
        local G = {}
        for V, y in ipairs(J.AllSeedsDataTable) do
            if type(y) ~= "table" then continue end
            local Z = y.name
            local j = y.single == true
            if type(Z) ~= "string" or Z == "" or j then continue end
            local i = tostring(y.rarity or "Common")
            local c = d.Data.GetRarityColor(i)
            table.insert(G,
                { Text = string.format("<font color=\"#FFFFFF\">%s</font> <font color=\"%s\">%s</font>", Z, c, i), Value =
                Z })
        end
        return G
    end,
    GetAllFruitTypeSelection = function()
        local G = {}
        for V, y in ipairs(J.AllSeedsDataTable) do
            if type(y) ~= "table" then continue end
            local Z = y.name
            local j = y.single == true
            if type(Z) == "string" and (Z ~= "" and not j) then G[Z] = true end
        end
        return G
    end,
    SplitMutations = function(G)
        local V = {}
        local y = {}
        if type(G) ~= "string" or G == "" then return V, y end
        for G in G:gmatch("[^%+%,]+") do
            G = G:match("^%s*(.-)%s*$")
            if G and (G ~= "" and not y[G]) then
                y[G] = true
                table.insert(V, G)
            end
        end
        return V, y
    end,
    GetVariantFromMutations = function(G)
        if type(G) ~= "table" then return "Normal" end
        if G.Rainbow then return "Rainbow" end
        if G.Gold then return "Gold" end
        return "Normal"
    end,
    HasSelectedMutation = function(G, V)
        if type(G) ~= "table" or type(V) ~= "table" then return false end
        for y in pairs(G) do if G[y] and V[y] then return true end end
        return false
    end,
    PassesMutationFilters = function(G)
        G = type(G) == "table" and G or {}
        local V = Y.shovel_mutation_whitelist
        local y = Y.shovel_mutation_blacklist
        if type(y) == "table" and (next(y) ~= nil and d.ShovelFruits.HasSelectedMutation(y, G)) then return false end
        if type(V) == "table" and next(V) ~= nil then return d.ShovelFruits.HasSelectedMutation(V, G) end
        return true
    end,
    GetShovelTool = function()
        local G = d.Player.GetTool_Holding()
        if G and G:IsA("Tool") then
            local V = G:GetAttribute("Shovel")
            if type(V) == "string" and V ~= "" then return G end
        end
        local V = y.LocalPlayer
        local Z = V and V:FindFirstChild("Backpack")
        if not Z then return nil end
        for G, V in ipairs(Z:GetChildren()) do
            if not V:IsA("Tool") then continue end
            local y = V:GetAttribute("Shovel")
            if type(y) == "string" and y ~= "" then return V end
        end
        return nil
    end,
    IsValidFruitTarget = function(G)
        if not G or not G.Parent then return false end
        local V = G.Parent
        if V.Name ~= "Fruits" then return false end
        local y = V.Parent
        if not y then return false end
        local Z = d.Farm.GetOwnPlot()
        if not Z then return false end
        local j = Z:FindFirstChild("Plants")
        if not j then return false end
        if y.Parent ~= j then return false end
        return true
    end,
    ShouldShovelFruit = function(G)
        if type(G) ~= "table" then return false end
        local V = G.ob
        if not d.ShovelFruits.IsValidFruitTarget(V) then return false end
        local y = G.name
        if type(y) ~= "string" or y == "" then return false end
        local Z = Y.shovel_fruit_types
        if type(Z) ~= "table" or not Z[y] then return false end
        local j = tonumber(G.w) or 0
        local i = tonumber(Y.shovel_min_weight) or 0
        local c = tonumber(Y.shovel_max_weight) or 1000000000
        if j < i or j > c then return false end
        local J = V:GetAttribute("Mutation")
        if type(J) ~= "string" then J = G.m end
        local T, u = d.ShovelFruits.SplitMutations(J)
        local q = d.ShovelFruits.GetVariantFromMutations(u)
        local g = Y.shovel_variants
        if type(g) ~= "table" or not g[q] then return false end
        if not d.ShovelFruits.PassesMutationFilters(u) then return false end
        return true
    end,
    GetMatchingFruits = function()
        local G = {}
        local V = d.FruitFilters.GetAllFruits()
        if type(V) ~= "table" then return G end
        for V, y in ipairs(V) do if d.ShovelFruits.ShouldShovelFruit(y) then table.insert(G, y) end end
        table.sort(G, function(G, V) return ((tonumber(G.w) or 0)) < ((tonumber(V.w) or 0)) end)
        return G
    end,
    ShovelFruit = function(G, V)
        if type(G) ~= "table" then return false end
        if not V or not V.Parent or not V:IsA("Tool") then return false end
        local Z = y.Character
        if not Z or V.Parent ~= Z then return false end
        local j = G.ob
        if not d.ShovelFruits.IsValidFruitTarget(j) then return false end
        local i = j.Parent
        local c = i and i.Parent
        if not c then return false end
        local J = c.Name
        local T = j.Name
        if type(J) ~= "string" or J == "" or type(T) ~= "string" or T == "" then return false end
        local u = V:GetAttribute("Shovel")
        if type(u) ~= "string" or u == "" then return false end
        local q = y.Networking and (y.Networking.Shovel and y.Networking.Shovel.UseShovel)
        if not q or type(q.Fire) ~= "function" then return false end
        local g = pcall(function() q:Fire(J, T, u, V) end)
        return g
    end,
    CleanupTool = function()
        if not d.ShovelFruits.EquippedBySystem then return end
        d.ShovelFruits.EquippedBySystem = false
        d.Player.UnequipTools()
    end,
    Run = function()
        d.ShovelFruits.LastLoopRemoved = 0
        if not Y.auto_shovel_fruits then
            d.ShovelFruits.ClearStatus()
            return 0
        end
        local G = Y.shovel_fruit_types
        if type(G) ~= "table" or next(G) == nil then
            d.ShovelFruits.SetStatus("Paused: select fruit types", "#FFCC66")
            return 0
        end
        local V = Y.shovel_variants
        if type(V) ~= "table" or next(V) == nil then
            d.ShovelFruits.SetStatus("Paused: select a variant", "#FFCC66")
            return 0
        end
        d.ShovelFruits.SetStatus("Scanning garden...", "#66CCFF")
        local y = d.ShovelFruits.GetMatchingFruits()
        if type(y) ~= "table" or #y == 0 then
            d.ShovelFruits.SetWaitingStatus()
            return 0
        end
        d.ShovelFruits.SetStatus(string.format("Found %d matching fruit%s", #y, #y == 1 and "" or "s"), "#66CCFF")
        local Z = d.ShovelFruits.GetShovelTool()
        if not Z then
            d.ShovelFruits.SetStatus("Paused: shovel not found", "#FF6B6B")
            return 0
        end
        local j = d.Player.IsToolHeld(Z)
        if not j then
            d.ShovelFruits.SetStatus("Equipping shovel...", "#FFD966")
            local G = d.Player.EquipTool(Z)
            if not G then
                d.ShovelFruits.SetStatus("Failed to equip shovel", "#FF6B6B")
                return 0
            end
            d.ShovelFruits.EquippedBySystem = true
            task.wait(.15)
        end
        if not d.Player.IsToolHeld(Z) then
            d.ShovelFruits.CleanupTool()
            d.ShovelFruits.SetStatus("Shovel was unequipped", "#FF6B6B")
            return 0
        end
        local i = 0
        for G, V in ipairs(y) do
            if not Y.auto_shovel_fruits then break end
            if i >= d.ShovelFruits.MaxPerLoop then break end
            if not d.ShovelFruits.ShouldShovelFruit(V) then continue end
            if not d.Player.IsToolHeld(Z) then
                d.ShovelFruits.SetStatus("Stopped: shovel unequipped", "#FF6B6B")
                break
            end
            local j = tostring(V.name or "Fruit")
            local c = tonumber(V.w) or 0
            d.ShovelFruits.SetStatus(string.format("Removing %s %.2fkg (%d/%d)", j, c, G, #y), "#FFAA44")
            local J = d.ShovelFruits.ShovelFruit(V, Z)
            if J then
                i += 1
                d.ShovelFruits.TotalRemoved += 1
                d.ShovelFruits.LastLoopRemoved = i
                d.ShovelFruits.SetStatus(
                    string.format("Removed %s %.2fkg | Total: %d", j, c, d.ShovelFruits.TotalRemoved),
                    "#7CFC00")
                task.wait(d.ShovelFruits.RequestDelay)
            end
        end
        d.ShovelFruits.CleanupTool()
        if i > 0 then
            d.ShovelFruits.SetStatus(
                string.format("Removed %d | Total: %d | Waiting", i, d.ShovelFruits.TotalRemoved), "#7CFC00")
        elseif Y.auto_shovel_fruits then
            d.ShovelFruits.SetWaitingStatus()
        end
        return i
    end,
    LoopShovelFruits = function()
        if not Y.auto_shovel_fruits then
            d.ShovelFruits.ClearStatus()
            return 0
        end
        local G, V = pcall(function() return d.ShovelFruits.Run() end)
        if not G then
            d.ShovelFruits.CleanupTool()
            d.ShovelFruits.SetStatus("Error: shovel loop failed", "#FF4444")
            warn("[ShovelFruits] Loop error:", V)
            return 0
        end
        return tonumber(V) or 0
    end
}
d.FarmDetails = {
    Label = nil,
    Busy = false,
    Started = false,
    RefreshDelay = 10,
    GetWeight = function(G)
        if typeof(G) ~= "Instance" then return 0 end
        local V, y = pcall(function() return d.FruitFilters.GetFruitWeight(G) end)
        return V and tonumber(y) or 0
    end,
    GetFruitObjects = function(G, V)
        local y = {}
        if typeof(G) ~= "Instance" then return y end
        local Z = G:FindFirstChild("Fruits")
        if Z then
            for G, V in ipairs(Z:GetChildren()) do table.insert(y, V) end
            return y
        end
        if d.SeedData.IsSingleHarvest(V) then table.insert(y, G) end
        return y
    end,
    FormatVariant = function(G)
        G = tostring(G or "Normal")
        if G == "Gold" then return "<font color=\'#FFD700\'>\240\159\140\159 Gold</font>" end
        if G == "Rainbow" then return "<font color=\'#FF66FF\'>\240\159\140\136 Rainbow</font>" end
        return "<font color=\'#FFFFFF\'>" .. (G .. "</font>")
    end,
    FormatCount = function(G)
        local V = tostring(math.max(math.floor(tonumber(G) or 0), 0))
        while true do
            local G, y = V:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
            V = G
            if y == 0 then break end
        end
        return V
    end,
    FormatWeight = function(G)
        local V = string.format("%.2f", tonumber(G) or 0)
        return V:gsub("%.?0+$", "")
    end,
    BuildText = function()
        local G = d.Farm.GetPlants()
        local V = {}
        local y = {}
        local Z = {}
        local j = 0
        local i = 0
        local c = 0
        local T = 0
        if type(G) ~= "table" or #G == 0 then return "<font color=\'#AFAFAF\'>No plants found in your farm.</font>" end
        for G, u in ipairs(G) do
            if typeof(u) ~= "Instance" or not u.Parent then continue end
            local q = tostring(u:GetAttribute("SeedName") or u.Name or "Unknown")
            local g = tostring(J.SeedRarity[q] or "Unknown")
            local E = V[g]
            if not E then
                E = {}
                V[g] = E
            end
            local a = E[q]
            if not a then
                a = { name = q, plants = 0, maxWeight = 0 }
                E[q] = a
            end
            a.plants += 1
            j += 1
            local H = d.FarmDetails.GetFruitObjects(u, q)
            for G, V in ipairs(H) do
                if typeof(V) ~= "Instance" or not V.Parent then continue end
                i += 1
                if d.FruitFilters.IsFruitReady(V) then c += 1 else T += 1 end
                local j = d.FarmDetails.GetWeight(V)
                if j > a.maxWeight then a.maxWeight = j end
                local J, u = d.ShovelFruits.SplitMutations(V:GetAttribute("Mutation"))
                local q = d.ShovelFruits.GetVariantFromMutations(u)
                Z[q] = ((Z[q] or 0)) + 1
                for G, V in ipairs(J) do if V ~= "Gold" and V ~= "Rainbow" then y[V] = ((y[V] or 0)) + 1 end end
            end
        end
        local u = {}
        local q = {}
        local g = {}
        for G, V in ipairs(d.ShovelFruits.GetVariantNames()) do u[V] = G end
        for G, V in pairs(Z) do table.insert(q, { name = G, amount = V, order = u[G] or 0 }) end
        table.sort(q, function(G, V)
            if G.order ~= V.order then return G.order < V.order end
            return G.name < V.name
        end)
        for G, V in ipairs(q) do
            table.insert(g,
                string.format("%s <font color=\'#FFA500\'>x%s</font>", d.FarmDetails.FormatVariant(V.name),
                    d.FarmDetails.FormatCount(V.amount)))
        end
        local E = { "<b><font color=\'#7CFC00\'>Farm Summary</font></b>\n", string.format(
            "<font color=\'#FFFFFF\'>Total Plants:</font> <font color=\'#FFA500\'>x%s</font>\n",
            d.FarmDetails.FormatCount(j)),
            string.format("<font color=\'#FFFFFF\'>Total Fruits:</font> <font color=\'#66CCFF\'>x%s</font>\n",
                d.FarmDetails.FormatCount(i)), string.format(
            "<font color=\'#FFFFFF\'>Ready:</font> <font color=\'#7CFC00\'>x%s</font> / <font color=\'#FFAA55\'>x%s</font>\n",
            d.FarmDetails.FormatCount(c), d.FarmDetails.FormatCount(T)), string.format(
            "<font color=\'#FFFFFF\'>Variants:</font> %s\n\n",
            #g > 0 and table.concat(g, "  ") or "<font color=\'#AFAFAF\'>None</font>") }
        local a = {}
        for G, V in pairs(V) do table.insert(a, { name = G, plants = V, rank = J.RarityRank[G] or 0 }) end
        table.sort(a, function(G, V)
            if G.rank ~= V.rank then return G.rank > V.rank end
            return G.name < V.name
        end)
        for G, V in ipairs(a) do
            local y = d.Data.GetRarityColor(V.name)
            local Z = {}
            for G, V in pairs(V.plants) do table.insert(Z, V) end
            table.sort(Z, function(G, V)
                if G.plants ~= V.plants then return G.plants > V.plants end
                return G.name < V.name
            end)
            table.insert(E, string.format("<b><font color=\'%s\'>%s</font></b>\n", y, V.name))
            for G, V in ipairs(Z) do
                table.insert(E,
                    string.format(
                        "<font color=\'#FFFFFF\'>%s</font> <font color=\'#FFA500\'>x%s</font> <font color=\'#FFFF00\'>(%skg Max)</font>\n",
                        V.name, d.FarmDetails.FormatCount(V.plants), d.FarmDetails.FormatWeight(V.maxWeight)))
            end
            table.insert(E, "\n")
        end
        local H = {}
        for G, V in pairs(y) do table.insert(H, { name = G, amount = V }) end
        table.sort(H, function(G, V)
            if G.amount ~= V.amount then return G.amount > V.amount end
            return G.name < V.name
        end)
        if #H > 0 then
            table.insert(E, "<b><font color=\'#FF66FF\'>Mutations In Farm</font></b>\n")
            for G, V in ipairs(H) do
                table.insert(E,
                    string.format("<font color=\'#FFFFFF\'>%s</font>: <font color=\'#FFA500\'>x%d</font>\n", V.name, V
                        .amount))
            end
        end
        return table.concat(E)
    end,
    Update = function()
        local G = d.FarmDetails.Label
        if d.FarmDetails.Busy or not G or type(G.SetText) ~= "function" then return false end
        d.FarmDetails.Busy = true
        local V, y = pcall(d.FarmDetails.BuildText)
        d.FarmDetails.Busy = false
        if not V then
            warn("[FarmDetails]", y)
            G:SetText("<font color=\'#FF6666\'>Farm details failed to refresh.</font>")
            return false
        end
        G:SetText(y)
        return true
    end,
    Start = function()
        if d.FarmDetails.Started then return end
        d.FarmDetails.Started = true
        task.spawn(function()
            while d.FarmDetails.Started do
                d.FarmDetails.Update()
                task.wait(d.FarmDetails.RefreshDelay)
            end
        end)
    end
}
J.PlantShovelStatusText = ""
d.PlantShovel = {
    MaxPerLoop = 50,
    RequestDelay = .9,
    SetStatus = function(G, V)
        G = tostring(G or "Waiting")
        V = tostring(V or "#FFFFFF")
        J.PlantShovelStatusText = string.format(
            "<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FF5555\'>\226\154\160\239\184\143 [Plant Shovel]</font> <font color=\'%s\'>%s</font></stroke>",
            V, G)
    end,
    ClearStatus = function() J.PlantShovelStatusText = "" end,
    GetPlantTypeDropdown = function()
        local G = {}
        local V = d.Farm.GetPlantedSeedCounts()
        for y, Z in ipairs(J.AllSeedsDataTable) do
            if type(Z) ~= "table" then continue end
            local j = Z.name
            if type(j) ~= "string" or j == "" then continue end
            if Z.single == true then continue end
            local i = tonumber(V[j]) or 0
            local c = i > 0 and "#FFD700" or "#FF5555"
            local J = tostring(Z.rarity or "")
            local T = d.Data.GetRarityColor(J)
            table.insert(G,
                {
                    Text = string.format(
                        "<font color=\"%s\">x%d</font> <font color=\"#FFFFFF\">%s</font> <font color=\"%s\">%s</font>", c,
                        i, j, T, J),
                    Value =
                        j
                })
        end
        table.sort(G,
            function(G, y)
                local Z = tonumber(V[G.Value]) or 0
                local j = tonumber(V[y.Value]) or 0
                if Z ~= j then return Z > j end
                return tostring(G.Value) < tostring(y.Value)
            end)
        return G
    end,
    GetAllPlantTypeSelection = function()
        local G = {}
        for V, y in ipairs(J.AllSeedsDataTable) do
            if type(y) ~= "table" then continue end
            local Z = y.name
            if type(Z) ~= "string" or Z == "" then continue end
            if y.single == true then continue end
            G[Z] = true
        end
        return G
    end,
    IsValidPlant = function(G)
        if typeof(G) ~= "Instance" or not G.Parent then return false, nil end
        local V = d.Farm.GetOwnPlot()
        if not V then return false, nil end
        local y = V:FindFirstChild("Plants")
        if not y or G.Parent ~= y then return false, nil end
        local Z = G:GetAttribute("SeedName")
        if type(Z) ~= "string" or Z == "" then return false, nil end
        if d.SeedData.IsSingleHarvest(Z) then return false, Z end
        return true, Z
    end,
    IsFullyGrown = function(G)
        if not G then return false end
        local V = tonumber(G:GetAttribute("Age"))
        local y = tonumber(G:GetAttribute("MaxAge"))
        if not V or not y or y <= 0 then return false end
        return V >= y
    end,
    GetPlantData = function(G)
        local V, y = d.PlantShovel.IsValidPlant(G)
        if not V then return nil end
        local Z = tonumber(G:GetAttribute("Height")) or 0
        if not Z then return nil end
        local j = G:GetAttribute("Mutation")
        if type(j) ~= "string" then j = "" end
        return { ob = G, name = y, height = Z, mutation = j, grown = d.PlantShovel.IsFullyGrown(G) }
    end,
    IsVariantBlacklisted = function(G)
        local V = Y.shovel_plant_variant_blacklist
        if type(V) ~= "table" or next(V) == nil then return false end
        if type(G) ~= "string" or G == "" then return false end
        return V[G]
    end,
    PassesVariant = function(G)
        local V = Y.shovel_plant_variants
        if type(V) ~= "table" or next(V) == nil then return true end
        if type(G) ~= "string" or G == "" then return false end
        return V[G]
    end,
    PassesFilters = function(G)
        if type(G) ~= "table" then return false end
        local V = G.ob
        if not V or not V.Parent then return false end
        local y = Y.shovel_plant_types
        if type(y) ~= "table" or not y[G.name] then return false end
        local Z = tonumber(Y.shovel_plant_min_height) or 0
        local j = tonumber(Y.shovel_plant_max_height) or 200
        local i = tonumber(G.height)
        if not i then return false end
        if i < Z or i > j then return false end
        if not Y.shovel_growing_plants and not G.grown then return false end
        if not d.PlantShovel.PassesVariant(G.mutation) then return false end
        if d.PlantShovel.IsVariantBlacklisted(G.mutation) then return false end
        return true
    end,
    GetPlantsToShovel = function()
        local G = {}
        local V = {}
        local y = Y.shovel_plant_types
        if type(y) ~= "table" then return G, V end
        for Z, j in ipairs(d.Farm.GetPlants()) do
            local i, c = d.PlantShovel.IsValidPlant(j)
            if not i or not y[c] then continue end
            V[c] = ((V[c] or 0)) + 1
            local J = d.PlantShovel.GetPlantData(j)
            if J and d.PlantShovel.PassesFilters(J) then table.insert(G, J) end
        end
        return G, V
    end,
    ShovelPlant = function(G, V)
        local y = type(G) == "table" and G.ob
        if not y or not y.Parent then return false end
        local Z = d.PlantShovel.IsValidPlant(y)
        if not Z or not d.Player.IsToolHeld(V) then return false end
        return d.ShovelTool.Use(y.Name, "", V)
    end,
    Run = function()
        if not Y.auto_shovel_plants then
            d.PlantShovel.ClearStatus()
            return 0
        end
        local G = Y.shovel_plant_types
        if type(G) ~= "table" or next(G) == nil then
            d.PlantShovel.SetStatus("Paused: select plant types", "#FFCC66")
            return 0
        end
        local V, y = d.PlantShovel.GetPlantsToShovel()
        local Z = math.max(math.floor(tonumber(Y.shovel_plants_keep) or 0), 0)
        if #V == 0 then
            d.PlantShovel.SetStatus("Nothing to shovel", "#CFCFCF")
            return 0
        end
        local j
        local i = false
        local c = 0
        for G, V in ipairs(V) do
            if not Y.auto_shovel_plants then break end
            if c >= d.PlantShovel.MaxPerLoop then break end
            local J = V.name
            local T = y[J] or 0
            if T <= Z then continue end
            if not j then
                j, i = d.ShovelTool.Equip()
                if not j then
                    d.PlantShovel.SetStatus("Paused: shovel not found", "#FF6B6B")
                    return c
                end
            end
            if not d.Player.IsToolHeld(j) then
                j, i = d.ShovelTool.Equip()
                if not j then break end
            end
            d.PlantShovel.SetStatus(string.format("Shovelling %s %d/%d", J, T, Z), "#FF5555")
            if d.PlantShovel.ShovelPlant(V, j) then
                y[J] = T - 1
                c += 1
                task.wait(d.PlantShovel.RequestDelay)
            end
        end
        d.ShovelTool.Cleanup(i)
        if c == 0 then d.PlantShovel.SetStatus("Nothing above keep limit", "#CFCFCF") end
        return c
    end,
    LoopPlantShovel = function()
        if not Y.auto_shovel_plants then
            d.PlantShovel.ClearStatus()
            return 0
        end
        local G, V = pcall(function() return d.PlantShovel.Run() end)
        if not G then
            d.Player.UnequipTools()
            d.PlantShovel.SetStatus("Error: plant shovel loop failed", "#FF4444")
            warn("[PlantShovel] Loop error:", V)
            return 0
        end
        return tonumber(V) or 0
    end
}
J.TrowelRunning = false
J.TrowelStatusText = ""
d.Trowel = {
    MaxPerLoop = 25,
    RequestDelay = .35,
    SetStatus = function(G, V)
        G = tostring(G or "")
        if G == "" then
            J.TrowelStatusText = ""
            return
        end
        J.TrowelStatusText = string.format(
            "<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\147\141 [Trowel]</font> <font color=\'%s\'>%s</font></stroke>",
            V or "#FFFFFF", G)
    end,
    ClearStatus = function() J.TrowelStatusText = "" end,
    GetAllSelection = function()
        local G = {}
        for V, y in ipairs(J.AllSeedsDataTable) do if type(y) == "table" and type(y.name) == "string" then G[y.name] = true end end
        return G
    end,
    GetTool = function()
        for G, V in ipairs(d.Backpack.GetBackpackAllItems()) do
            if V:IsA("Tool") and V:GetAttribute("Trowel") ~= nil then
                return
                    V
            end
        end
        return nil
    end,
    EquipTool = function()
        local G = d.Trowel.GetTool()
        if not G then return nil, false end
        if d.Player.IsToolHeld(G) then return G, false end
        d.Player.UnequipTools()
        if not d.Player.EquipTool(G) then return nil, false end
        task.wait(.2)
        if not d.Player.IsToolHeld(G) then return nil, false end
        return G, true
    end,
    GetSavedPositionText = function()
        local G = Y.trowel_saved_position
        if type(G) ~= "table" then return "\240\159\147\141 Saved Position: Not set" end
        local V = tostring(G.area or "")
        local y = tonumber(G.x)
        local Z = tonumber(G.z)
        if V == "" or not y or not Z then return "\240\159\147\141 Saved Position: Not set" end
        return string.format("\240\159\147\141 Saved Position: %s | X %.2f | Z %.2f", V, y, Z)
    end,
    SavePlayerPosition = function()
        local G = y.Character and y.Character:FindFirstChild("HumanoidRootPart")
        if not G then return false, "Character not found" end
        local V, Z = d.Farm.GetPlantAreaAtPosition(G.Position)
        if not V or typeof(Z) ~= "Vector3" then return false, "Stand inside your farm" end
        Y.trowel_saved_position = { area = V.Name, x = Z and Z.X, z = Z and Z.Z }
        u.Save.SaveDataSync()
        return true, V.Name
    end,
    GetTargetPosition = function()
        if Y.trowel_use_fixed_spot then
            local G = d.Farm.GetPermanentPlantPosition(0)
            if typeof(G) ~= "Vector3" then return nil, "Farm middle not found" end
            return G
        end
        local G = Y.trowel_saved_position
        if type(G) ~= "table" then return nil, "Copy your position inside the farm" end
        local V = d.Farm.GetPlantArea(G.area)
        local y = tonumber(G.x)
        local Z = tonumber(G.z)
        if not V or not y or not Z then return nil, "Copy your position inside the farm" end
        if math.abs(y) > V.Size.X / 2 or math.abs(Z) > V.Size.Z / 2 then return nil,
                "Saved position is outside your farm" end
        return V.CFrame:PointToWorldSpace(Vector3.new(y, V.Size.Y / 2, Z))
    end,
    GetPlants = function(G)
        local V = {}
        local y = Y.trowel_plant_types
        local Z = type(y) == "table" and next(y) ~= nil
        for j, i in ipairs(d.Farm.GetPlants()) do
            if not i:IsA("Model") then continue end
            local c = i:GetAttribute("SeedName")
            if type(c) ~= "string" or c == "" or Z and not y[c] then continue end
            local J = (i:GetPivot()).Position
            local T = Vector3.new(J.X, 0, J.Z)
            local d = Vector3.new(G.X, 0, G.Z)
            if ((T - d)).Magnitude >= 1.25 then table.insert(V, { ob = i, name = c }) end
        end
        return V
    end,
    MovePlant = function(G, V)
        if not G or not G.Parent then return false end
        local Z = y.Networking and (y.Networking.Trowel and y.Networking.Trowel.MovePlant)
        if not Z or type(Z.Fire) ~= "function" then return false end
        local j = G.PrimaryPart and G.PrimaryPart.CFrame or G:GetPivot()
        local i, c, J = j:ToEulerAnglesYXZ()
        return pcall(function() Z:Fire(G.Name, V, math.deg(c)) end)
    end,
    Start = function()
        if J.TrowelRunning then return end
        J.TrowelRunning = true
        d.Trowel.SetStatus("Starting...", "#66CCFF")
    end,
    Stop = function(G)
        J.TrowelRunning = false
        d.Player.UnequipTools()
        d.Trowel.ClearStatus()
        if type(G) == "string" and G ~= "" then J.Notify(G, 3) end
    end,
    Run = function()
        if not J.TrowelRunning then
            d.Trowel.ClearStatus()
            return 0
        end
        local G, V = d.Trowel.GetTargetPosition()
        if not G then
            d.Trowel.Stop(V)
            return 0
        end
        local y = d.Trowel.GetPlants(G)
        if #y == 0 then
            d.Trowel.Stop("All selected plants moved")
            return 0
        end
        local Z, j = d.Trowel.EquipTool()
        if not Z then
            d.Trowel.Stop("Trowel not found")
            return 0
        end
        local i = 0
        for V, j in ipairs(y) do
            if not J.TrowelRunning or i >= d.Trowel.MaxPerLoop then break end
            if not d.Player.IsToolHeld(Z) then
                d.Trowel.Stop("Trowel unequipped or ran out")
                break
            end
            d.Trowel.SetStatus(string.format("Moving %s %d/%d", j.name, V, #y), "#FFD966")
            if d.Trowel.MovePlant(j.ob, G) then
                i += 1
                task.wait(d.Trowel.RequestDelay)
            end
        end
        if j then d.Player.UnequipTools() end
        if J.TrowelRunning then d.Trowel.SetStatus(string.format("Moved %d/%d | Continuing", i, #y), "#7CFC00") end
        return i
    end,
    Loop = function()
        local G, V = pcall(d.Trowel.Run)
        if not G then
            d.Trowel.Stop("Trowel system error")
            warn("[Trowel]", V)
            return 0
        end
        return tonumber(V) or 0
    end
}
d.FruitCollect = {
    FruitBucket = {},
    FruitBucketIndex = 1,
    IsMaxFruitInventory = function()
        local G = d.PlayerData.GetFruitCount()
        local V = d.PlayerData.GetMaxFruitCapacity()
        if G >= V then return true end
        return false
    end,
    IsFarFromGarden = function()
        if not d.Farm.IsNearFarm(100) then return true end
        return false
    end,
    GetTextCurrentInventoryFruitStats = function()
        local G = d.PlayerData.GetFruitCount() or 0
        local V = d.PlayerData.GetMaxFruitCapacity() or 1
        local y = math.clamp(G / V, 0, 1)
        local Z
        if y < .5 then
            Z = (Color3.new(0, 1, 0)):Lerp(Color3.new(1, 1, 0), y * 2)
        else
            Z = (Color3.new(1, 1, 0)):Lerp(
                Color3.new(1, .2, 0), ((y - .5)) * 2)
        end
        local j = string.format("#%02X%02X%02X", math.floor(Z.R * 255), math.floor(Z.G * 255), math.floor(Z.B * 255))
        local i = string.format(
            "<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\140\177 [Fruit Collector]</font> <font color=\'%s\'>Fruits (%d/%d)</font></stroke>",
            j, G, V)
        return i
    end,
    CollectFruit = function(G, V)
        if type(G) ~= "string" or G == "" then return false end
        V = type(V) == "string" and V or ""
        local Z = y.CollectFruitNet
        if not Z or type(Z.Fire) ~= "function" then return false end
        local j = pcall(function() Z:Fire(G, V) end)
        if not j then
            d.FruitCollect.ResetBucket()
            return false
        end
        return true
    end,
    ResetBucket = function()
        d.FruitCollect.FruitBucket = {}
        d.FruitCollect.FruitBucketIndex = 1
    end,
    GetReadyFruitsFromSync = function()
        local G = y.GardenSyncController
        if type(G) ~= "table" or type(G.GetGarden) ~= "function" then return nil end
        local V, Z = pcall(function() return G:GetGarden(J.player_userid) end)
        if not V or type(Z) ~= "table" or next(Z) == nil then return nil end
        local j = {}
        for G, V in pairs(Z) do
            if type(V) ~= "table" then continue end
            local y = V.PlantName
            if type(y) ~= "string" or y == "" then continue end
            local Z = tostring(G or "")
            if Z == "" then continue end
            local i = V.Fruits
            if type(i) == "table" and next(i) ~= nil then
                for G, V in pairs(i) do
                    if type(V) ~= "table" then continue end
                    local i = tonumber(V.Age) or 0
                    local c = tonumber(V.MaxAge) or 0
                    if c > 0 and i >= c then table.insert(j, { name = y, plantId = Z, fruitId = tostring(G or "") }) end
                end
            elseif d.SeedData.IsSingleHarvest(y) then
                local G = tonumber(V.Age) or 0
                local i = tonumber(V.MaxAge) or 0
                if i > 0 and G >= i then table.insert(j, { name = y, plantId = Z, fruitId = "" }) end
            end
        end
        return j
    end,
    CollectLoopSimple = function()
        if not Y.auto_collect_fruit_enabled then return end
        if d.FruitCollect.IsMaxFruitInventory() then return end
        local G = false
        if next(Y.collect_fruit_list) then G = true end
        if d.FruitCollect.FruitBucketIndex > #d.FruitCollect.FruitBucket then
            d.FruitCollect.FruitBucket = d.FruitFilters.GetReadyFruits() or {}
            d.FruitCollect.FruitBucketIndex = 1
        end
        local V = 0
        if #d.FruitCollect.FruitBucket > 0 then
            if d.FruitCollect.IsFarFromGarden() and Y.collection_teleport then
                if not d.GameTeleport.Garden(J.TeleportLockNames.PetFarmReturn) then
                    d.PetFarmReturn.SetStatus("Garden teleport failed", "#FF5555")
                end
            end
        end
        if not y.CollectFruitNet or type(y.CollectFruitNet.Fire) ~= "function" then return false end
        for y = 1, 500, 1 do
            local Z = d.FruitCollect.FruitBucket[d.FruitCollect.FruitBucketIndex]
            if not Z then
                d.FruitCollect.ResetBucket()
                break
            end
            if V >= 500 then break end
            d.FruitCollect.FruitBucketIndex += 1
            if not Y.auto_collect_fruit_enabled then return end
            if d.FruitCollect.IsMaxFruitInventory() then return end
            local j = Z.name
            if G then if not Y.collect_fruit_list[j] then continue end end
            local i = Z.plantId
            local c = Z.fruitId
            if d.FruitCollect.CollectFruit(i, c) then
                V += 1
                task.wait()
            end
        end
        return V
    end
}
J.PetFarmStatusText = ""
d.PetFarmReturn = {
    MaxDistance = 35,
    NextCheckAt = 0,
    SetStatus = function(G, V)
        J.PetFarmStatusText = string.format(
            "<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\144\190 [Pet Farm]</font> <font color=\'%s\'>%s</font></stroke>",
            V or "#FFFFFF", tostring(G or ""))
    end,
    GetTimer = function()
        return math.max(
            math.floor(tonumber(Y.pet_return_farm_timer) or 60), 3)
    end,
    ResetTimer = function()
        d.PetFarmReturn.NextCheckAt = os
            .clock() + d.PetFarmReturn.GetTimer()
    end,
    Loop = function()
        if not Y.pet_return_farm then
            J.PetFarmStatusText = ""
            return
        end
        if d.PetFarmReturn.NextCheckAt <= 0 then d.PetFarmReturn.ResetTimer() end
        local G = math.max(math.ceil(d.PetFarmReturn.NextCheckAt - os.clock()), 0)
        if G > 0 then
            d.PetFarmReturn.SetStatus(string.format("Teleporting in %ds", G), "#FFD966")
            return
        end
        if d.Teleport.IsLocked(J.TeleportLockNames.PetFarmReturn) then return end
        if not d.PlayerData.GetIsInOwnGarden() then
            d.PetFarmReturn.SetStatus("Teleporting to farm...", "#66CCFF")
            if not d.GameTeleport.Garden(J.TeleportLockNames.PetFarmReturn) then
                d.PetFarmReturn.SetStatus(
                    "Garden teleport failed", "#FF5555")
            else
                task.wait(1.5)
                if not d.Farm.TeleportToCenter(J.TeleportLockNames.PetFarmReturn) then
                    d.PetFarmReturn.SetStatus(
                        "Farm centre not found", "#FF5555")
                end
            end
        end
        d.PetFarmReturn.ResetTimer()
    end
}
d.PetFarmReturn.ResetTimer()
task.spawn(function()
    while true do
        task.wait(.05)
        if not Y.turbo_sell then
            task.wait(3)
            continue
        end
        task.spawn(function() d.SellManager.SellAll() end)
    end
end)
task.spawn(function()
    while true do
        task.wait(.1)
        local G, V = pcall(function()
            d.FruitCollect.CollectLoopSimple()
            d.SellManager.SellAll()
        end)
        if not G then
            d.FruitCollect.ResetBucket()
            warn("[FruitCollect] Loop error:", V)
            task.wait(1)
        end
    end
end)
J.SprinklerPlaceStatusText = ""
d.SprinklerPlacer = {
    MaxPerLoop = 10,
    MinSpacing = 1.5,
    CentreSideOffset = 10,
    MaxPositionAttempts = 80,
    EquippedBySystem = false,
    SetStatus = function(
        G, V)
        J.SprinklerPlaceStatusText = string.format(
            "<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\146\166 [Sprinkler]</font> <font color=\'%s\'>%s</font></stroke>",
            tostring(V or "#FFFFFF"), tostring(G or "Waiting"))
    end,
    ClearStatus = function() J.SprinklerPlaceStatusText = "" end,
    GetDelay = function()
        return
            math.max(tonumber(Y.sprinkler_place_delay) or .6, .2)
    end,
    GetNames = function()
        local G = {}
        local V = {}
        for y, Z in ipairs(J.AllGearShopTable) do
            local j = type(Z) == "table" and Z.name or nil
            if type(j) ~= "string" or j == "" or not string.find(j, "Sprinkler", 1, true) or V[j] then continue end
            V[j] = true
            table.insert(G, j)
        end
        table.sort(G)
        return G
    end,
    IsValidName = function(G)
        if type(G) ~= "string" or G == "" then return false end
        for V, y in ipairs(d.SprinklerPlacer.GetNames()) do if y == G then return true end end
        return false
    end,
    GetDropdown = function()
        local G = {}
        for V, y in ipairs(d.SprinklerPlacer.GetNames()) do
            local Z = d.GearData.GetGeatItemDetails(y) or {}
            local j = tostring(Z.rarity or "Unknown")
            local i = d.Data.GetRarityColor(j)
            table.insert(G,
                { Text = string.format("<font color=\"#FFFFFF\">%s</font> <font color=\"%s\">%s</font>", y, i, j), Value =
                y })
        end
        return G
    end,
    GetAllSelection = function()
        local G = {}
        for V, y in ipairs(d.SprinklerPlacer.GetNames()) do G[y] = true end
        return G
    end,
    GetOverrideTarget = function(G)
        local V = Y.sprinkler_place_overrides
        if type(V) ~= "table" then return nil end
        local y = tonumber(V[G])
        if not y then return nil end
        return math.max(math.floor(y), 0)
    end,
    SetOverrideTarget = function(G, V)
        if not d.SprinklerPlacer.IsValidName(G) then return false end
        V = math.floor(tonumber(V) or 0)
        if V <= 0 then return false end
        if type(Y.sprinkler_place_overrides) ~= "table" then Y.sprinkler_place_overrides = {} end
        Y.sprinkler_place_overrides[G] = V
        return true
    end,
    RemoveOverrideTarget = function(G)
        if type(Y.sprinkler_place_overrides) ~= "table" then
            Y.sprinkler_place_overrides = {}
            return false
        end
        if Y.sprinkler_place_overrides[G] == nil then return false end
        Y.sprinkler_place_overrides[G] = nil
        return true
    end,
    GetTargetAmount = function(G)
        local V = d.SprinklerPlacer.GetOverrideTarget(G)
        if V ~= nil then return V end
        return math.max(math.floor(tonumber(Y.sprinkler_place_default_target) or 1), 0)
    end,
    GetSprinklersFolder = function()
        local G = d.Farm.GetOwnPlot()
        if not G then return nil end
        return G:FindFirstChild("Sprinklers")
    end,
    GetPlacedCounts = function()
        local G = {}
        local V = 0
        local y = d.SprinklerPlacer.GetSprinklersFolder()
        if not y then return G, V end
        for y, Z in ipairs(y:GetChildren()) do
            local j = Z:GetAttribute("SprinklerName")
            if type(j) ~= "string" or j == "" then continue end
            G[j] = ((G[j] or 0)) + 1
            V += 1
        end
        return G, V
    end,
    GetOccupiedPositions = function()
        local G = {}
        local V = d.SprinklerPlacer.GetSprinklersFolder()
        if not V then return G end
        for V, y in ipairs(V:GetChildren()) do
            local Z
            if y:IsA("Model") then Z = (y:GetPivot()).Position elseif y:IsA("BasePart") then Z = y.Position end
            if typeof(Z) == "Vector3" then table.insert(G, Z) end
        end
        return G
    end,
    IsPositionOpen = function(G, V)
        if typeof(G) ~= "Vector3" then return false end
        for V, y in ipairs(V or {}) do
            if typeof(y) ~= "Vector3" then continue end
            local Z = Vector3.new(G.X - y.X, 0, G.Z - y.Z)
            if Z.Magnitude < d.SprinklerPlacer.MinSpacing then return false end
        end
        return true
    end,
    GetTool = function(G)
        if type(G) ~= "string" or G == "" then return nil end
        for V, y in ipairs(d.Backpack.GetBackpackAllItems()) do
            if not y:IsA("Tool") then continue end
            local Z = y:GetAttribute("Sprinkler")
            if Z == G then return y end
            if y.Name == G and Z ~= nil then return y end
        end
        return nil
    end,
    EquipTool = function(G)
        if not G or not G:IsA("Tool") then return false end
        if d.Player.IsToolHeld(G) then return true end
        d.Player.UnequipTools()
        if not d.Player.EquipTool(G) then return false end
        d.SprinklerPlacer.EquippedBySystem = true
        task.wait(.15)
        return d.Player.IsToolHeld(G)
    end,
    CleanupTool = function()
        if not d.SprinklerPlacer.EquippedBySystem then return end
        d.SprinklerPlacer.EquippedBySystem = false
        d.Player.UnequipTools()
    end,
    SaveCurrentPosition = function()
        local G = y.Character and y.Character:FindFirstChild("HumanoidRootPart")
        if not G then return false, "Character not found" end
        local V, Z = d.Farm.GetPlantAreaAtPosition(G.Position)
        if not V or typeof(Z) ~= "Vector3" then return false, "Stand inside your farm" end
        Y.sprinkler_place_saved_position = { area = V.Name, x = Z.X, z = Z.Z }
        u.Save.SaveDataSync()
        return true, "Sprinkler position saved"
    end,
    GetSavedPositionText = function()
        local G = Y.sprinkler_place_saved_position
        local V = type(G) == "table" and tostring(G.area or "") or ""
        local y = type(G) == "table" and tonumber(G.x) or nil
        local Z = type(G) == "table" and tonumber(G.z) or nil
        if V == "" or not y or not Z then return "\240\159\147\141 Saved Position: Not set" end
        return string.format("\240\159\147\141 Saved Position: %s | X %.2f | Z %.2f", V, y, Z)
    end,
    GetTargetPlant = function()
        local G = tostring(Y.sprinkler_place_target_plant or "")
        if G == "" then return nil end
        local V = d.Farm.GetPermanentCenterPosition()
        local y
        local Z = math.huge
        for j, i in ipairs(d.Farm.GetPlants()) do
            if i:GetAttribute("SeedName") ~= G then continue end
            local c
            if i:IsA("Model") then c = (i:GetPivot()).Position elseif i:IsA("BasePart") then c = i.Position end
            if typeof(c) ~= "Vector3" then continue end
            local J = V and ((c - V)).Magnitude or 0
            if J < Z then
                Z = J
                y = i
            end
        end
        return y
    end,
    GetBasePosition = function(G)
        local V = tostring(Y.sprinkler_place_mode or "Farm Middle")
        G = math.max(math.floor(tonumber(G) or 0), 0)
        if V == "Farm Middle" then
            local V = d.Farm.GetPermanentCenterCFrame()
            if not V then return nil, "Farm centre not found" end
            local y = { -d.SprinklerPlacer.CentreSideOffset, d.SprinklerPlacer.CentreSideOffset, 0, -d.SprinklerPlacer
            .CentreSideOffset / 2, d.SprinklerPlacer.CentreSideOffset / 2 }
            local Z = y[(G % #y) + 1]
            return V:PointToWorldSpace(Vector3.new(Z, 0, 0))
        end
        if V == "Plant Target" then
            local G = d.SprinklerPlacer.GetTargetPlant()
            if not G then return nil, "Selected target plant not found" end
            if G:IsA("Model") then return (G:GetPivot()).Position end
            if G:IsA("BasePart") then return G.Position end
            return nil, "Selected target plant not found"
        end
        if V == "Saved Position" then
            local G = Y.sprinkler_place_saved_position
            local V = type(G) == "table" and d.Farm.GetPlantArea(G.area) or nil
            local y = type(G) == "table" and tonumber(G.x) or nil
            local Z = type(G) == "table" and tonumber(G.z) or nil
            if not V or not y or not Z then return nil, "Copy a sprinkler position" end
            if math.abs(y) > V.Size.X / 2 or math.abs(Z) > V.Size.Z / 2 then
                return nil,
                    "Saved position is outside your farm"
            end
            return V.CFrame:PointToWorldSpace(Vector3.new(y, V.Size.Y / 2, Z))
        end
        return nil, "Invalid placement mode"
    end,
    FindOpenPositionAround = function(G, V)
        local y, Z, j = d.Farm.ProjectPositionToPlantArea(G, 1)
        if not Z or not j then return nil end
        for G = 0, d.SprinklerPlacer.MaxPositionAttempts, 1 do
            local y = j.X
            local i = j.Z
            if G > 0 then
                local V = math.rad(G * 137.5)
                local Z = 1.75 * math.sqrt(G)
                y += math.cos(V) * Z
                i += math.sin(V) * Z
            end
            local c = math.max(Z.Size.X / 2 - 1, 0)
            local J = math.max(Z.Size.Z / 2 - 1, 0)
            if math.abs(y) > c or math.abs(i) > J then continue end
            local T = Z.CFrame:PointToWorldSpace(Vector3.new(y, Z.Size.Y / 2, i))
            if d.SprinklerPlacer.IsPositionOpen(T, V) then return T end
        end
        return nil
    end,
    GetPlacementPosition = function(G, V)
        local y, Z = d.SprinklerPlacer.GetBasePosition(V)
        if not y then return nil, Z end
        local j = d.SprinklerPlacer.FindOpenPositionAround(y, G)
        if not j then return nil, "No open sprinkler position found" end
        return j
    end,
    GetCandidates = function()
        local G = {}
        local V = Y.sprinkler_place_selected
        local y, Z = d.SprinklerPlacer.GetPlacedCounts()
        local j = 0
        local i = 0
        if type(V) ~= "table" then return G, y, Z, j, i end
        for V, Z in pairs(V) do
            if Z ~= true or not d.SprinklerPlacer.IsValidName(V) then continue end
            j += 1
            local c = d.SprinklerPlacer.GetTargetAmount(V)
            local J = math.max(math.floor(tonumber(y[V]) or 0), 0)
            local T = math.max(c - J, 0)
            if T <= 0 then continue end
            i += 1
            if d.SprinklerPlacer.GetTool(V) then table.insert(G, { name = V, placed = J, target = c, remaining = T }) end
        end
        return G, y, Z, j, i
    end,
    PrepareTeleport = function(G, V)
        if not Y.sprinkler_place_teleport then return true end
        if not d.PlayerData.GetIsInOwnGarden() then return d.GameTeleport.Garden(V) end
        return false
    end,
    Place = function(G, V, Z, j)
        if type(G) ~= "string" or G == "" then return false end
        if typeof(V) ~= "Vector3" or not Z or not Z:IsA("Tool") then return false end
        if not d.Player.IsToolHeld(Z) then return false end
        j = tonumber(j)
        if not j or j <= 0 then return false end
        local i = y.Networking and (y.Networking.Place and y.Networking.Place.PlaceSprinkler)
        if not i or type(i.Fire) ~= "function" then return false end
        local c = d.SprinklerPlacer.GetPlacedCounts()
        local J = c[G] or 0
        local T = pcall(function() i:Fire(V, G, Z, j) end)
        if not T then return false end
        local u = os.clock() + 1.5
        repeat
            local V = d.SprinklerPlacer.GetPlacedCounts()
            local y = V[G] or 0
            if y > J then return true end
            if not Z.Parent then return true end
            task.wait(.05)
        until os.clock() >= u
        return false
    end,
    Run = function()
        if not Y.auto_sprinkler_place then
            d.SprinklerPlacer.ClearStatus()
            return 0
        end
        local G, V, y, Z, j = d.SprinklerPlacer.GetCandidates()
        if Z <= 0 then
            d.SprinklerPlacer.SetStatus("Paused: select sprinklers", "#FFCC66")
            return 0
        end
        if #G <= 0 then
            if j <= 0 then
                d.SprinklerPlacer.SetStatus("All selected targets reached", "#7CFC00")
            else
                d.SprinklerPlacer
                    .SetStatus("Selected sprinkler tools not found", "#FFCC66")
            end
            return 0
        end
        local i = d.SprinklerPlacer.GetOccupiedPositions()
        local c, T = d.SprinklerPlacer.GetPlacementPosition(i, y)
        if not c then
            d.SprinklerPlacer.SetStatus(T or "Placement position unavailable", "#FF5555")
            return 0
        end
        local u = d.PlayerData.GetPlotId()
        if not u or u <= 0 then
            d.SprinklerPlacer.SetStatus("Plot ID not found", "#FF5555")
            return 0
        end
        local q = J.TeleportLockNames.SprinklerPlacer
        local g = false
        if Y.sprinkler_place_teleport then
            g = d.Teleport.LockTeleport(q, 10, false)
            if not g then
                d.SprinklerPlacer.SetStatus("Waiting: teleport busy", "#FFCC66")
                return 0
            end
        end
        local E = 0
        local a = 0
        while Y.auto_sprinkler_place and (#G > 0 and a < d.SprinklerPlacer.MaxPerLoop) do
            local Z = d.Farm._Random:NextInteger(1, #G)
            local j = G[Z]
            local c = d.SprinklerPlacer.GetTool(j.name)
            if not c or j.remaining <= 0 then
                table.remove(G, Z)
                continue
            end
            local J, T = d.SprinklerPlacer.GetPlacementPosition(i, y + E)
            if not J then
                d.SprinklerPlacer.SetStatus(T or "Placement position unavailable", "#FF5555")
                break
            end
            if Y.sprinkler_place_teleport then
                d.Teleport.LockTeleport(q, 10, false)
                if not d.SprinklerPlacer.PrepareTeleport(J, q) then
                    d.SprinklerPlacer.SetStatus("Could not reach placement position", "#FF5555")
                    break
                end
            end
            if not d.SprinklerPlacer.EquipTool(c) then
                table.remove(G, Z)
                continue
            end
            a += 1
            d.SprinklerPlacer.SetStatus(string.format("Placing %s %d/%d", j.name, j.placed + 1, j.target), "#66CCFF")
            local g = d.SprinklerPlacer.Place(j.name, J, c, u)
            if g then
                table.insert(i, J)
                j.placed += 1
                j.remaining -= 1
                V[j.name] = j.placed
                E += 1
                task.wait(d.SprinklerPlacer.GetDelay())
            else
                if Y.sprinkler_place_teleport then
                    d.SprinklerPlacer.SetStatus("Sprinkler placement failed", "#FF5555")
                else
                    d.SprinklerPlacer.SetStatus("Placement failed: try Auto Teleport", "#FFCC66")
                end
                break
            end
            if j.remaining <= 0 then table.remove(G, Z) end
        end
        d.SprinklerPlacer.CleanupTool()
        if g then d.Teleport.UnlockTeleport(q) end
        if not Y.auto_sprinkler_place then
            d.SprinklerPlacer.ClearStatus()
        elseif E > 0 then
            d.SprinklerPlacer.SetStatus(
                string.format("Placed %d sprinkler%s | Waiting", E, E == 1 and "" or "s"), "#7CFC00")
        end
        return E
    end,
    Loop = function()
        if not Y.auto_sprinkler_place then
            d.SprinklerPlacer.ClearStatus()
            return 0
        end
        if not J.GetCheckIfPro() then return 0 end
        local G, V = pcall(d.SprinklerPlacer.Run)
        if not G then
            d.SprinklerPlacer.CleanupTool()
            d.Teleport.UnlockTeleport(J.TeleportLockNames.SprinklerPlacer)
            d.SprinklerPlacer.SetStatus("Error: sprinkler placer failed", "#FF4444")
            warn("[SprinklerPlacer] Loop error:", V)
            return 0
        end
        return tonumber(V) or 0
    end
}
J.WaterPlantStatusText = ""
d.WaterPlants = {
    NextUseAt = 0,
    LastCanName = "",
    LastTargetName = "",
    EquippedBySystem = false,
    SetStatus = function(G,
                         V)
        J.WaterPlantStatusText =
            string.format(
                "<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\146\167 [Water Plants]</font> <font color=\'%s\'>%s</font></stroke>",
                tostring(V or "#FFFFFF"), tostring(G or "Waiting"))
    end,
    ClearStatus = function() J.WaterPlantStatusText = "" end,
    GetCanDropdown = function()
        local G = {}
        if type(y.WateringcanData) ~= "table" then return G end
        for V, y in ipairs(y.WateringcanData) do
            local Z = type(y) == "table" and y.Name or nil
            if type(Z) ~= "string" or Z == "" then continue end
            table.insert(G,
                {
                    Text = string.format(
                        "<font color=\"#FFFFFF\">%s</font> <font color=\"#66CCFF\">%d studs</font> <font color=\"#FFD966\">\226\143\179%ds</font> <font color=\"#7CFC00\">Multi x%d</font>",
                        Z, math.floor(tonumber(y.SplashRadius) or 0), math.floor(tonumber(y.EffectTime) or 0),
                        math.floor(tonumber(y.GrowthSpeedMultiplier) or 0)),
                    Value = Z
                })
        end
        return G
    end,
    GetTool = function()
        if type(y.WateringcanData) ~= "table" then return nil, nil end
        local G = Y.water_plant_selected_cans
        local V = type(G) ~= "table" or next(G) == nil
        local Z = d.Backpack.GetBackpackAllItems()
        for y, j in ipairs(y.WateringcanData) do
            local i = type(j) == "table" and j.Name or nil
            if type(i) ~= "string" or i == "" then continue end
            if not V and G[i] ~= true then continue end
            for G, V in ipairs(Z) do if V:IsA("Tool") and V:GetAttribute("WateringCan") == i then return V, j end end
        end
        return nil, nil
    end,
    GetPlantTarget = function(G, V)
        for y, Z in ipairs(d.Farm.GetPlants()) do
            if not Z or not Z.Parent then continue end
            local j = Z:GetAttribute("SeedName")
            if type(j) ~= "string" or j == "" then continue end
            if type(G) == "string" and (G ~= "" and j ~= G) then continue end
            if V then
                local G = tonumber(Z:GetAttribute("Age"))
                local V = tonumber(Z:GetAttribute("MaxAge"))
                if not G or not V or V <= 0 or G >= V then continue end
            end
            local i
            if Z:IsA("Model") then i = (Z:GetPivot()).Position elseif Z:IsA("BasePart") then i = Z.Position end
            if typeof(i) ~= "Vector3" then continue end
            local c = d.Farm.ProjectPositionToPlantArea(i, 0)
            if typeof(c) == "Vector3" then return c, j end
        end
        return nil, nil
    end,
    GetTargetPosition = function()
        local G = tostring(Y.water_plant_mode or "Growing Plant")
        if G == "Growing Plant" then
            local G, V = d.WaterPlants.GetPlantTarget(nil, true)
            if typeof(G) ~= "Vector3" then return nil, nil, "No growing plants" end
            return G, V
        end
        if G == "Farm Middle" then
            local G = d.Farm.GetPermanentPlantPosition(0)
            if typeof(G) ~= "Vector3" then return nil, nil, "Farm middle not found" end
            return G, "Farm Middle"
        end
        if G == "Plant Target" then
            local G = tostring(Y.water_plant_target_plant or "")
            if G == "" then return nil, nil, "Select a target plant" end
            local V = d.WaterPlants.GetPlantTarget(G, false)
            if typeof(V) ~= "Vector3" then return nil, nil, G .. " not found" end
            return V, G
        end
        if G == "Custom Position" then
            local G = Y.water_plant_saved_position
            local V = type(G) == "table" and d.Farm.GetPlantArea(G.area) or nil
            local y = type(G) == "table" and tonumber(G.x) or nil
            local Z = type(G) == "table" and tonumber(G.z) or nil
            if not V or not y or not Z then return nil, nil, "Copy a custom position" end
            if math.abs(y) > V.Size.X / 2 or math.abs(Z) > V.Size.Z / 2 then
                return nil, nil,
                    "Custom position is outside your farm"
            end
            local j = V.CFrame:PointToWorldSpace(Vector3.new(y, V.Size.Y / 2, Z))
            return j, "Custom Position"
        end
        return nil, nil, "Invalid watering mode"
    end,
    SaveCurrentPosition = function()
        local G = y.Character and y.Character:FindFirstChild("HumanoidRootPart")
        if not G then return false, "Character not found" end
        local V, Z = d.Farm.GetPlantAreaAtPosition(G.Position)
        if not V or typeof(Z) ~= "Vector3" then return false, "Stand inside your farm" end
        Y.water_plant_saved_position = { area = V.Name, x = Z.X, z = Z.Z }
        u.Save.SaveDataSync()
        return true, "Watering position saved"
    end,
    GetSavedPositionText = function()
        local G = Y.water_plant_saved_position
        local V = type(G) == "table" and tostring(G.area or "") or ""
        local y = type(G) == "table" and tonumber(G.x) or nil
        local Z = type(G) == "table" and tonumber(G.z) or nil
        if V == "" or not y or not Z then return "\240\159\147\141 Custom Position: Not set" end
        return string.format("\240\159\147\141 Custom Position: %s | X %.2f | Z %.2f", V, y, Z)
    end,
    EnsureNearTarget = function(G)
        if typeof(G) ~= "Vector3" then return false, false, "Invalid watering position" end
        local V = y.Character and y.Character:FindFirstChild("HumanoidRootPart")
        if not V then return false, false, "Character not found" end
        if ((V.Position - G)).Magnitude <= 21 then return true, false end
        local Z = J.TeleportLockNames.WaterPlants
        if not d.Teleport.LockTeleport(Z, 4, false) then return false, false, "Waiting: teleport busy" end
        d.WaterPlants.SetStatus("Moving near watering target...", "#66CCFF")
        local j = Vector3.new(V.Position.X - G.X, 0, V.Position.Z - G.Z)
        if j.Magnitude <= .1 then j = Vector3.new(0, 0, 1) else j = j.Unit end
        local i = (G + j * 6) + Vector3.new(0, 3, 0)
        local c = d.Teleport.TeleportToCFrame(CFrame.lookAt(i, G), Z)
        if not c then
            d.Teleport.UnlockTeleport(Z)
            return false, false, "Could not reach watering target"
        end
        task.wait(.15)
        return true, true
    end,
    CleanupTool = function()
        if d.WaterPlants.EquippedBySystem then
            d.WaterPlants.EquippedBySystem = false
            d.Player.UnequipTools()
        end
    end,
    Use = function(G, V, Z)
        local j = y.Networking and (y.Networking.WateringCan and y.Networking.WateringCan.UseWateringCan)
        if typeof(G) ~= "Vector3" or type(V) ~= "string" or V == "" then return false end
        if not Z or not Z:IsA("Tool") or not d.Player.IsToolHeld(Z) then return false end
        if not j or type(j.Fire) ~= "function" then return false end
        return pcall(function() j:Fire(G - Vector3.new(0, .3, 0), V, Z) end)
    end,
    Run = function()
        if not Y.auto_water_plants then
            d.WaterPlants.ClearStatus()
            return 0
        end
        if type(y.WateringcanData) ~= "table" then
            d.WaterPlants.SetStatus("Watering data unavailable", "#FF5555")
            return 0
        end
        if Y.water_plant_wait_effect then
            local G = math.max(math.ceil(d.WaterPlants.NextUseAt - os.clock()), 0)
            if G > 0 then
                d.WaterPlants.SetStatus(
                    string.format("%s \226\134\146 %s | Wait %ds", d.WaterPlants.LastCanName,
                        d.WaterPlants.LastTargetName, G),
                    "#7CFC00")
                return 0
            end
        end
        local G, V, Z = d.WaterPlants.GetTargetPosition()
        if typeof(G) ~= "Vector3" then
            d.WaterPlants.SetStatus(Z or "Target not found", "#CFCFCF")
            return 0
        end
        local j, i = d.WaterPlants.GetTool()
        if not j or type(i) ~= "table" then
            d.WaterPlants.SetStatus("Watering can not found", "#FFCC66")
            return 0
        end
        local c = tostring(i.Name or "")
        if c == "" then
            d.WaterPlants.SetStatus("Invalid watering can", "#FF5555")
            return 0
        end
        if not d.Player.IsToolHeld(j) then
            d.Player.UnequipTools()
            if not d.Player.EquipTool(j) then
                d.WaterPlants.SetStatus("Could not equip watering can", "#FF5555")
                return 0
            end
            d.WaterPlants.EquippedBySystem = true
            task.wait(.15)
        end
        if not d.Player.IsToolHeld(j) then
            d.WaterPlants.CleanupTool()
            d.WaterPlants.SetStatus("Watering can was unequipped", "#FF5555")
            return 0
        end
        local T, u, q = d.WaterPlants.EnsureNearTarget(G)
        if not T then
            d.WaterPlants.CleanupTool()
            d.WaterPlants.SetStatus(q or "Could not reach target", "#FFCC66")
            return 0
        end
        d.WaterPlants.SetStatus("Watering " .. (tostring(V or "target") .. "..."), "#66CCFF")
        local g = d.WaterPlants.Use(G, c, j)
        task.wait(.15)
        d.WaterPlants.CleanupTool()
        if u then d.Teleport.UnlockTeleport(J.TeleportLockNames.WaterPlants) end
        if not g then
            d.WaterPlants.SetStatus("Watering failed", "#FF5555")
            return 0
        end
        local E = math.max(math.floor(tonumber(i.EffectTime) or 1), 1)
        d.WaterPlants.LastCanName = c
        d.WaterPlants.LastTargetName = tostring(V or "Target")
        if Y.water_plant_wait_effect then
            d.WaterPlants.NextUseAt = os.clock() + E
            d.WaterPlants.SetStatus(string.format("%s \226\134\146 %s | Wait %ds", c, d.WaterPlants.LastTargetName, E),
                "#7CFC00")
        else
            d.WaterPlants.NextUseAt = 0
            d.WaterPlants.SetStatus(string.format("%s \226\134\146 %s | Stacking", c, d.WaterPlants.LastTargetName),
                "#7CFC00")
        end
        return 1
    end,
    Loop = function()
        if not Y.auto_water_plants then
            d.WaterPlants.ClearStatus()
            return 0
        end
        local G, V = pcall(d.WaterPlants.Run)
        if not G then
            d.WaterPlants.CleanupTool()
            d.Teleport.UnlockTeleport(J.TeleportLockNames.WaterPlants)
            d.WaterPlants.SetStatus("Error: watering loop failed", "#FF4444")
            warn("[WaterPlants] Loop error:", V)
            return 0
        end
        return tonumber(V) or 0
    end
}
c.PositionGrid = {
    Create = function(G)
        G = math.max(tonumber(G) or 1, .1)
        return { CellSize = G, Buckets = {} }
    end,
    Add = function(G, V)
        if type(G) ~= "table" or type(G.Buckets) ~= "table" or typeof(V) ~= "Vector3" then return false end
        local y = math.max(tonumber(G.CellSize) or 1, .1)
        local Z = math.floor(V.X / y)
        local j = math.floor(V.Z / y)
        local i = G.Buckets[Z]
        if not i then
            i = {}
            G.Buckets[Z] = i
        end
        local c = i[j]
        if not c then
            c = {}
            i[j] = c
        end
        table.insert(c, V)
        return true
    end,
    IsOpen = function(G, V, y)
        if type(G) ~= "table" or type(G.Buckets) ~= "table" or typeof(V) ~= "Vector3" then return false end
        local Z = math.max(tonumber(G.CellSize) or 1, .1)
        y = math.max(tonumber(y) or Z, 0)
        local j = y * y
        local i = math.max(math.ceil(y / Z), 1)
        local c = math.floor(V.X / Z)
        local J = math.floor(V.Z / Z)
        for y = c - i, c + i, 1 do
            local Z = G.Buckets[y]
            if not Z then continue end
            for G = J - i, J + i, 1 do
                local y = Z[G]
                if not y then continue end
                for G, y in ipairs(y) do
                    local Z = V.X - y.X
                    local i = V.Z - y.Z
                    local c = Z * Z + i * i
                    if c < j then return false end
                end
            end
        end
        return true
    end
}
J.SeedPlaceStatusText = ""
d.Seeder = {
    MaxPerLoop = 30,
    MinPlantSpacing = 1.3,
    SpreadStep = 1.35,
    MaxPositionAttempts = 220,
    StackStep = .67,
    StackIndex = 0,
    HardGardenLimit = 800,
    MaxFailedPlacements = 9,
    PrintCurrentStackLocation = function(
        G)
        local V = tostring(Y.seed_place_mode or "Random")
        local y
        local Z
        local j
        if V == "Farm Middle" then
            local G, V, i = d.Farm.GetPermanentPlantPosition(.5)
            y = V
            Z = i and i.X
            j = i and i.Z
        elseif V == "Saved Position" then
            local G = Y.seed_place_saved_position
            y = type(G) == "table" and d.Farm.GetPlantArea(G.area) or nil
            Z = type(G) == "table" and tonumber(G.x) or nil
            j = type(G) == "table" and tonumber(G.z) or nil
        end
        if not y or not Z or not j then return 0, 0 end
        local i = d.Seeder.GetStackedPosition(y, Z, j, 0)
        if typeof(i) ~= "Vector3" then return 0, 0 end
        local c = 0
        local J = 0
        for V, y in ipairs(d.Farm.GetPlants()) do
            local Z = d.Seeder.GetPlantPosition(y)
            if typeof(Z) ~= "Vector3" then continue end
            if G and typeof(G) == "Vector3" then
                local V = Z.X - G.X
                local y = Z.Z - G.Z
                if V * V + y * y > 4 then continue end
            end
            local j = Z.Y - i.Y
            c = math.max(c, j)
            J = math.min(J, j)
        end
        c = math.round(c)
        J = math.round(J)
        return J, c
    end,
    GetDetectedStackIndex = function(G)
        local V, y = d.Seeder.PrintCurrentStackLocation(G)
        local Z = Y.seed_place_stack_mode_underground and math.abs(V) or math.abs(y)
        local j = math.max(tonumber(d.Seeder.StackStep) or .67, .01)
        return math.max(math.round(Z / j) + 1, 1)
    end,
    GetGardenLimit = function()
        local G = math.floor(tonumber(Y.seed_place_max_garden_plants) or d.Seeder.HardGardenLimit)
        return math.clamp(G, 0, d.Seeder.HardGardenLimit)
    end,
    GetStackedPosition = function(G, V, y, Z)
        if not G or not G:IsA("BasePart") then return nil end
        V = tonumber(V)
        y = tonumber(y)
        Z = math.max(math.floor(tonumber(Z) or 0), 0)
        if not V or not y then return nil end
        local j = Z * d.Seeder.StackStep
        local i = j
        if Y.seed_place_stack_mode and Y.seed_place_stack_mode_underground then i = -j end
        return G.CFrame:PointToWorldSpace(Vector3.new(V, i, y))
    end,
    GetSavedPositionText = function()
        local G = Y.seed_place_saved_position
        if type(G) ~= "table" then return "\240\159\147\141 Saved Position: Not set" end
        local V = tostring(G.area or "")
        local y = tonumber(G.x)
        local Z = tonumber(G.z)
        if V == "" or not y or not Z then return "\240\159\147\141 Saved Position: Not set" end
        return string.format("\240\159\147\141 Saved Position: %s | X %.2f | Z %.2f", V, y, Z)
    end,
    GetPlantPosition = function(G)
        if not G or not G.Parent then return nil end
        if G:IsA("Model") then return (G:GetPivot()).Position end
        if G:IsA("BasePart") then return G.Position end
        return nil
    end,
    GetOccupiedPositions = function()
        local G = c.PositionGrid.Create(d.Seeder.MinPlantSpacing)
        for V, y in ipairs(d.Farm.GetPlants()) do
            local Z = d.Seeder.GetPlantPosition(y)
            if typeof(Z) == "Vector3" then c.PositionGrid.Add(G, Z) end
        end
        return G
    end,
    IsPositionOpen = function(G, V) return c.PositionGrid.IsOpen(V, G, d.Seeder.MinPlantSpacing) end,
    GetAreaPosition = function(
        G, V, y)
        if not G or not G:IsA("BasePart") then return nil end
        V = tonumber(V)
        y = tonumber(y)
        if not V or not y then return nil end
        return G.CFrame:PointToWorldSpace(Vector3.new(V, G.Size.Y / 2, y))
    end,
    IsInsidePlantArea = function(G, V, y, Z)
        if not G or not G:IsA("BasePart") then return false end
        Z = math.max(tonumber(Z) or .5, 0)
        local j = math.max(G.Size.X / 2 - Z, 0)
        local i = math.max(G.Size.Z / 2 - Z, 0)
        return math.abs(V) <= j and math.abs(y) <= i
    end,
    FindOpenPositionAround = function(G, V, y, Z)
        if not G or not G:IsA("BasePart") then return nil end
        V = tonumber(V)
        y = tonumber(y)
        if not V or not y then return nil end
        for j = 0, d.Seeder.MaxPositionAttempts, 1 do
            local i = V
            local c = y
            if j > 0 then
                local G = math.rad(j * 137.5)
                local V = d.Seeder.SpreadStep * math.sqrt(j)
                i += math.cos(G) * V
                c += math.sin(G) * V
            end
            if not d.Seeder.IsInsidePlantArea(G, i, c, .5) then continue end
            local J = d.Seeder.GetAreaPosition(G, i, c)
            if J and d.Seeder.IsPositionOpen(J, Z) then return J end
        end
        return nil
    end,
    GetRandomOpenPosition = function(G)
        for V = 1, d.Seeder.MaxPositionAttempts, 1 do
            local y = d.Farm.GetRandomLocationForSeed(.75)
            if y and d.Seeder.IsPositionOpen(y, G) then return y end
        end
        return nil
    end,
    BuildWallPositions = function()
        local G = {}
        local V = d.Seeder.SpreadStep
        for y, Z in ipairs(d.Farm.GetPlantAreas()) do
            local j = .75
            local i = math.max(Z.Size.X / 2 - j, 0)
            local c = math.max(Z.Size.Z / 2 - j, 0)
            local J = i * 2
            local T = c * 2
            local u = math.max(math.floor(J / V), 1)
            local q = math.max(math.floor(T / V), 1)
            for V = 0, u, 1 do
                for y = 0, q, 1 do
                    local j = -i + J * ((V / u))
                    local g = -c + T * ((y / q))
                    local E = math.min(V, u - V, y, q - y)
                    local a = d.Seeder.GetAreaPosition(Z, j, g)
                    if a then table.insert(G, { position = a, depth = E, random = d.Farm._Random:NextNumber() }) end
                end
            end
        end
        table.sort(G, function(G, V)
            if G.depth ~= V.depth then return G.depth < V.depth end
            return G.random < V.random
        end)
        return G
    end,
    GetWallPosition = function(G, V)
        if type(V) ~= "table" then return nil end
        for y, Z in ipairs(V) do
            local j = Z.position
            if d.Seeder.IsPositionOpen(j, G) then
                table.remove(V, y)
                return j
            end
        end
        return nil
    end,
    SetStatus = function(G, V)
        J.SeedPlaceStatusText = string.format(
            "<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\140\177 [Seed Placer]</font> <font color=\'%s\'>%s</font></stroke>",
            tostring(V or "#FFFFFF"), tostring(G or "Waiting"))
    end,
    ClearStatus = function() J.SeedPlaceStatusText = "" end,
    GetDelay = function()
        return
            math.max(tonumber(Y.seed_place_delay) or .3, .05)
    end,
    GetSeedNames = function()
        local G = {}
        for V, y in ipairs(J.AllSeedsDataTable) do
            local Z = type(y) == "table" and y.name
            if type(Z) == "string" and Z ~= "" then table.insert(G, Z) end
        end
        table.sort(G)
        return G
    end,
    GetOverrideTarget = function(G)
        if type(G) ~= "string" or G == "" then return nil end
        local V = Y.seed_place_overrides
        if type(V) ~= "table" then return nil end
        local y = V[G]
        if type(y) == "number" then return math.max(math.floor(y), 0) end
        if type(y) ~= "table" or y.enabled ~= true then return nil end
        local Z = tonumber(y.target)
        if not Z then return nil end
        return math.max(math.floor(Z), 0)
    end,
    SetOverrideTarget = function(G, V)
        if type(G) ~= "string" or G == "" or not J.SeedDataFast[G] then return false end
        V = math.floor(tonumber(V) or 0)
        if V <= 0 then return false end
        if type(Y.seed_place_overrides) ~= "table" then Y.seed_place_overrides = {} end
        Y.seed_place_overrides[G] = { enabled = true, target = V }
        return true
    end,
    RemoveOverrideTarget = function(G)
        if type(Y.seed_place_overrides) ~= "table" then
            Y.seed_place_overrides = {}
            return false
        end
        if Y.seed_place_overrides[G] == nil then return false end
        Y.seed_place_overrides[G] = nil
        return true
    end,
    GetTargetAmount = function(G)
        local V = d.Seeder.GetOverrideTarget(G)
        if V ~= nil then return V end
        return math.max(math.floor(tonumber(Y.seed_place_default_target) or 10), 0)
    end,
    GetAllSeedSelection = function()
        local G = {}
        for V, y in ipairs(J.AllSeedsDataTable) do
            local Z = type(y) == "table" and y.name
            if type(Z) == "string" and Z ~= "" then G[Z] = true end
        end
        return G
    end,
    GetSeedTool = function(G)
        if type(G) ~= "string" or G == "" then return nil, 0 end
        for V, y in ipairs(d.Backpack.GetBackpackAllItems()) do
            if y:IsA("Tool") and (y.Name == G and y:GetAttribute("SeedTool")) then
                return
                    y, math.max(math.floor(tonumber(y:GetAttribute("Count")) or 0), 0)
            end
        end
        return nil, 0
    end,
    SaveCurrentPosition = function()
        local G = y.Character and y.Character:FindFirstChild("HumanoidRootPart")
        d.Seeder.StackIndex = 0
        if not G then return false, "Character not found" end
        local V, Z = d.Farm.GetPlantAreaAtPosition(G.Position)
        if not V or typeof(Z) ~= "Vector3" then return false, "Stand inside your farm" end
        Y.seed_place_saved_position = { area = V.Name, x = Z and Z.X, z = Z and Z.Z }
        d.Seeder.StackIndex = 0
        u.Save.SaveDataSync()
        return true, "Planting position saved"
    end,
    GetPlacementPosition = function(G, V, y)
        local Z = tostring(Y.seed_place_mode or "Random")
        if Z == "Random" then
            if Y.seed_place_wall_mode then
                local y = d.Seeder.GetWallPosition(G, V)
                if not y then return nil, "No open wall positions found" end
                return y
            end
            local y = d.Seeder.GetRandomOpenPosition(G)
            if not y then return nil, "No open planting position found" end
            return y
        end
        if Z == "Farm Middle" then
            local V, Z, j = d.Farm.GetPermanentPlantPosition(.5)
            if not Z or typeof(j) ~= "Vector3" then return nil, "Farm middle not found" end
            if Y.seed_place_stack_mode then return d.Seeder.GetStackedPosition(Z, j.X, j.Z, y) end
            local i = d.Seeder.FindOpenPositionAround(Z, j.X, j.Z, G)
            if not i then return nil, "No open position near farm middle" end
            return i
        end
        if Z == "Saved Position" then
            local V = Y.seed_place_saved_position
            if type(V) ~= "table" then return nil, "Save a planting position" end
            local Z = d.Farm.GetPlantArea(V.area)
            local j = tonumber(V.x)
            local i = tonumber(V.z)
            if not Z or not j or not i then return nil, "Save a planting position" end
            if not d.Seeder.IsInsidePlantArea(Z, j, i, 0) then return nil, "Saved position is outside your farm" end
            if Y.seed_place_stack_mode then return d.Seeder.GetStackedPosition(Z, j, i, y) end
            local c = d.Seeder.FindOpenPositionAround(Z, j, i, G)
            if not c then return nil, "No open position near saved location" end
            return c
        end
        return nil, "Invalid placement mode"
    end,
    GetCandidates = function()
        local G = {}
        local V = Y.allowed_seedsplace
        local y = d.Farm.GetPlantedSeedCounts()
        local Z = 0
        local j = 0
        if type(V) ~= "table" then return G, y, Z, j end
        for V, i in pairs(V) do
            if i ~= true or type(V) ~= "string" or V == "" then continue end
            Z += 1
            local c = d.Seeder.GetTargetAmount(V)
            local J = math.max(math.floor(tonumber(y[V]) or 0), 0)
            local T = math.max(c - J, 0)
            if T <= 0 then continue end
            j += 1
            local u, q = d.Seeder.GetSeedTool(V)
            local g = math.min(T, q)
            if u and g > 0 then table.insert(G,
                    { name = V, tool = u, planted = J, target = c, available = q, remaining = g }) end
        end
        return G, y, Z, j
    end,
    PlaceSeed = function(G, V, Z)
        if type(G) ~= "string" or G == "" or typeof(V) ~= "Vector3" then return false end
        local j = y.Character
        if not j or not j.Parent then return false end
        if not Z or not Z:IsA("Tool") or Z.Parent ~= j then Z = j:FindFirstChild(G) end
        if not Z or not Z:IsA("Tool") then return false end
        local i = y.Networking and (y.Networking.Plant and y.Networking.Plant.PlantSeed)
        if not i or type(i.Fire) ~= "function" then return false end
        local c = math.max(math.floor(tonumber(Z:GetAttribute("Count")) or 0), 0)
        if c <= 0 then return false end
        local J = pcall(function() i:Fire(V, G, Z) end)
        if not J then return false end
        local T = os.clock() + .4
        repeat
            if not Z.Parent then return true, 0 end
            local G = math.max(math.floor(tonumber(Z:GetAttribute("Count")) or 0), 0)
            if G < c then return true, G end
            task.wait()
        until os.clock() >= T
        return false, c
    end,
    Run = function()
        local G = d.Seeder.GetGardenLimit()
        local V = #d.Farm.GetPlants()
        if V >= d.Seeder.HardGardenLimit then
            d.Seeder.SetStatus(string.format("Game garden limit reached %d/%d", V, d.Seeder.HardGardenLimit), "#FF5555")
            return 0
        end
        if V >= G then
            d.Seeder.SetStatus(string.format("Selected garden limit reached %d/%d", V, G), "#FFCC66")
            return 0
        end
        local y, Z, j, i = d.Seeder.GetCandidates()
        if j <= 0 then
            d.Seeder.SetStatus("Paused: select seeds", "#FFCC66")
            return 0
        end
        if #y <= 0 then
            if i <= 0 then
                d.Seeder.SetStatus("All selected targets reached", "#7CFC00")
            else
                d.Seeder.SetStatus(
                    "Selected seeds not found", "#FFCC66")
            end
            return 0
        end
        local J = 0
        local T = false
        local u = d.Seeder.GetDelay()
        local q = tostring(Y.seed_place_mode or "Random")
        local g = q
        local E = d.Seeder.GetOccupiedPositions()
        local a
        if q == "Random" and Y.seed_place_wall_mode then
            g = "Random Wall"
            a = d.Seeder.BuildWallPositions()
        end
        local H = 0
        local r = math.max(math.floor(tonumber(d.Seeder.StackIndex) or 0), 0)
        local e = 0
        local s = false
        while Y.auto_seedplace and (#y > 0 and (H < d.Seeder.MaxPerLoop and V < G)) do
            local j = d.Farm._Random:NextInteger(1, #y)
            local i = y[j]
            local g, N = d.Seeder.GetPlacementPosition(E, a, r)
            if not g then
                d.Seeder.SetStatus(N or "Planting position unavailable", "#FF5555")
                break
            end
            local W, X = d.Seeder.GetSeedTool(i.name)
            if not W or X <= 0 or i.remaining <= 0 then
                table.remove(y, j)
                continue
            end
            if not d.Player.IsToolHeld(W) then
                if not d.Player.EquipTool(W) then
                    table.remove(y, j)
                    continue
                end
                T = true
                task.wait(.1)
            end
            if not d.Player.IsToolHeld(W) then
                table.remove(y, j)
                continue
            end
            if V >= G then
                d.Seeder.SetStatus(string.format("Garden limit reached %d/%d", V, G), "#FFCC66")
                break
            end
            H += 1
            local h, l = d.Seeder.PlaceSeed(i.name, g, W)
            if h then
                e = 0
                c.PositionGrid.Add(E, g)
                V += 1
                if Y.seed_place_stack_mode and ((q == "Saved Position" or q == "Farm Middle")) then
                    r += 1
                    d.Seeder.StackIndex = r
                end
                i.planted += 1
                i.available = tonumber(l) or math.max(i.available - 1, 0)
                i.remaining -= 1
                Z[i.name] = i.planted
                J += 1
                task.wait(u)
            else
                e += 1
                if Y.seed_place_stack_mode and ((q == "Saved Position" or q == "Farm Middle")) then
                    local G = d.Seeder.GetDetectedStackIndex(g)
                    r = math.max(r + 1, G)
                    d.Seeder.StackIndex = r
                end
                d.Seeder.SetStatus(string.format("Placement not confirmed (%d/%d)", e, d.Seeder.MaxFailedPlacements),
                    "#FFCC66")
                c.PositionGrid.Add(E, g)
                if e >= d.Seeder.MaxFailedPlacements then
                    V = #d.Farm.GetPlants()
                    s = true
                    if V >= d.Seeder.HardGardenLimit then
                        d.Seeder.SetStatus(
                            string.format("Game garden limit reached %d/%d", V, d.Seeder.HardGardenLimit), "#FF5555")
                    else
                        d
                            .Seeder.SetStatus(
                            string.format("Server did not confirm placement | Garden %d/%d", V, d.Seeder.HardGardenLimit),
                            "#FF5555")
                    end
                    break
                end
                task.wait(.05)
                continue
            end
            if i.remaining <= 0 or i.available <= 0 then table.remove(y, j) end
        end
        if T then d.Player.UnequipTools() end
        V = #d.Farm.GetPlants()
        if not Y.auto_seedplace then
            d.Seeder.ClearStatus()
        elseif V >= d.Seeder.HardGardenLimit then
            d.Seeder.SetStatus(
                string.format("Game garden limit reached %d/%d", V, d.Seeder.HardGardenLimit), "#FF5555")
        elseif V >= G then
            d
                .Seeder.SetStatus(string.format("Selected garden limit reached %d/%d", V, G), "#FFCC66")
        elseif J > 0 and not s then
            d.Seeder.SetStatus(string.format("Placed %d seed%s | Waiting", J, J == 1 and "" or "s"), "#7CFC00")
        end
        return J
    end,
    SeedPlaceLoop = function()
        if not Y.auto_seedplace then
            d.Seeder.ClearStatus()
            return 0
        end
        local G, V = pcall(d.Seeder.Run)
        if not G then
            d.Player.UnequipTools()
            d.Seeder.SetStatus("Error: seed placer failed", "#FF4444")
            warn("[Seeder] Loop error:", V)
            return 0
        end
        return tonumber(V) or 0
    end
}
E.SeedShop = {
    GetCurrentStockSeedStock = function(G)
        local V = y.SeedShop.Items:FindFirstChild(G)
        if V then return tonumber(V.Value) or 0 end
        return 0
    end,
    BuySeed = function(G)
        if Y.seed_avoid[G] then return end
        y.Networking.SeedShop.PurchaseSeed:Fire(G)
    end,
    SeedBuyerLoop = function()
        if not Y.enabled_seed_shop then return end
        local G = d.DataReplica.GetData("PurchasedThisRestock")
        if not G then return end
        local V = tonumber(d.Money.GetSheckles()) or 0
        local y = G.Seeds or {}
        for G, Z in pairs(J.SeedShopDataList) do
            if Y.seed_avoid[G] then continue end
            local j = d.SeedData.GetSeedDataX(G)
            if not j then continue end
            local i = tonumber(j.price) or 0
            local c = E.SeedShop.GetCurrentStockSeedStock(G)
            local J = tonumber(y[G]) or 0
            local T = math.max(0, c - J)
            if T <= 0 then continue end
            if i <= 0 then continue end
            local u = math.floor(V / i)
            local q = math.min(T, u)
            if q <= 0 then continue end
            for y = 1, q, 1 do
                E.SeedShop.BuySeed(G)
                task.wait(.1)
                V = tonumber(d.Money.GetSheckles()) or 0
            end
        end
    end
}
E.GearShop = {
    BuyGear = function(G)
        if Y.gear_shop_avoid[G] then return end
        y.Networking.GearShop.PurchaseGear:Fire(G)
    end,
    GearShopLoop = function()
        if not Y.enabled_gear_shop then return end
        local G = false
        local V = d.DataReplica.GetData("PurchasedThisRestock")
        if not V then return end
        local y = tonumber(d.Money.GetSheckles()) or 0
        local Z = V.Gear or {}
        for V, j in pairs(J.AllGearShopData) do
            if Y.gear_shop_avoid[V] then continue end
            local i = tonumber(j.price) or 0
            local c = d.GearData.GetGearStockCurrent(V)
            local J = tonumber(Z[V]) or 0
            local T = math.max(0, c - J)
            if T <= 0 then
                if G then print("[GearShop] Already bought / no stock left:", V, J .. ("/" .. c)) end
                continue
            end
            if G then print("[GearShop] Have in stock:", V, T, "Price:", i) end
            if i <= 0 then continue end
            local u = math.floor(y / i)
            local q = math.min(T, u)
            if q <= 0 then
                if G then print("[GearShop] Not enough money:", V, "Need:", i, "Have:", y) end
                continue
            end
            for Z = 1, q, 1 do
                if G then print("[GearShop] Attempting to buy:", V, "Price:", i) end
                E.GearShop.BuyGear(V)
                task.wait(.1)
                y = tonumber(d.Money.GetSheckles()) or 0
            end
        end
    end
}
J.MailStatusText = ""
J.MailDraftItems = {}
J.MailDraftTargetUsername = ""
J.MailDraftCategory = "Seeds"
J.MailDraftItemName = ""
J.MailDraftAmount = 1
J.MailManualRunning = false
J.MailActiveOrder = nil
J.MailManualUiStatusText = "<font color=\'#888888\'>Ready to send</font>"
J.MailManualStatusLabel = nil
J.MailStartOrderButton = nil
J.MailClearOrderButton = nil
J.MailStopOrderButton = nil
J.MailSelectedReceipt = ""
J.MailSelectedRuleId = ""
J.MailUiRefs = {}
d.Mail = {
    Started = false,
    Busy = false,
    NextSendAt = 0,
    EquippedPets = {},
    RecentlySentPets = {},
    RuleCooldowns = {},
    MaxBatchItems = 20,
    SendDelay = 10.1,
    RetryDelay = 10,
    ClaimDelay = .5,
    MaxFailures = 5,
    MaxReceipts = 50,
    SetStatus = function(
        G, V)
        J.MailStatusText = string.format(
            "<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\147\172 [Mail]</font> <font color=\'%s\'>%s</font></stroke>",
            tostring(V or "#FFFFFF"), tostring(G or "Waiting"))
    end,
    ClearStatus = function() J.MailStatusText = "" end,
    SetManualUiStatus = function(
        G, V, y)
        J.MailManualUiStatusText = string.format("<font color=\'%s\'>%s %s</font>", tostring(V or "#FFFFFF"),
            tostring(y or "\240\159\147\172"), tostring(G or "Waiting"))
    end,
    SetUiDisabled = function(G, V)
        if not G then return end
        V = V == true
        if type(G.SetDisabled) == "function" then
            local y = pcall(function() G:SetDisabled(V) end)
            if y then return end
        end
        pcall(function() G.Disabled = V end)
    end,
    RefreshManualUi = function()
        local G = J.MailManualStatusLabel
        if G and type(G.SetText) == "function" then pcall(function() G:SetText(J.MailManualUiStatusText) end) end
        d.Mail.SetUiDisabled(J.MailStartOrderButton, J.MailManualRunning)
        d.Mail.SetUiDisabled(J.MailClearOrderButton, J.MailManualRunning)
        d.Mail.SetUiDisabled(J.MailStopOrderButton, not J.MailManualRunning)
    end,
    GetServerTime = function()
        local G, V = pcall(function() return y.Workspace:GetServerTimeNow() end)
        if G and type(V) == "number" then return V end
        return os.time()
    end,
    GetSendWait = function()
        local G = math.max(d.Mail.NextSendAt - os.clock(), 0)
        local V = math.max(((tonumber(Y.mail_next_send_at) or 0)) - d.Mail.GetServerTime(), 0)
        return math.max(G, V)
    end,
    GetNote = function(G)
        if not Y.mail_include_comment then return "" end
        return (tostring(G or "")):sub(1, 100)
    end,
    MakeId = function(G)
        local V = (((y.HttpService:GenerateGUID(false)):gsub("%-", "")):sub(1, 8)):upper()
        return tostring(G or "EXO") .. ("-" .. V)
    end,
    CleanUsername = function(G)
        G = tostring(G or "")
        return (G:gsub("^%s*@?", "")):gsub("%s+$", "")
    end,
    IsValidUsername = function(G)
        G = d.Mail.CleanUsername(G)
        if #G < 3 or #G > 20 then return false end
        return G:match("^[%w_]+$") ~= nil
    end,
    LookupRecipient = function(G)
        G = d.Mail.CleanUsername(G)
        if not d.Mail.IsValidUsername(G) then return nil, "Enter the exact Roblox username" end
        local V = y.Networking and (y.Networking.Mailbox and y.Networking.Mailbox.LookupPlayer)
        if not V or type(V.Fire) ~= "function" then return nil, "Mailbox lookup is unavailable" end
        d.Mail.SetStatus("Checking @" .. (G .. "..."), "#66CCFF")
        local Z, j, i = pcall(function() return V:Fire(G) end)
        if not Z or type(j) ~= "number" or j <= 0 then return nil, "User was not found" end
        if tonumber(j) == tonumber(J.player_userid) then return nil, "You cannot send mail to yourself" end
        return { userId = j, username = G, displayName = type(i) == "string" and (i ~= "" and i) or G }
    end,
    GetInventory = function()
        local G = d.DataReplica.GetData("Inventory")
        return type(G) == "table" and G or nil
    end,
    IsGiftableCategory = function(G)
        local V = y.MailboxItemCatalog
        if type(G) ~= "string" or G == "" or type(V) ~= "table" or type(V.IsGiftable) ~= "function" then return false end
        local Z, j = pcall(V.IsGiftable, G)
        return Z and j == true
    end,
    EncodeGearSelection = function(G, V) return tostring(G or "") .. ("::" .. tostring(V or "")) end,
    DecodeItemSelection = function(
        G, V)
        G = tostring(G or "")
        V = tostring(V or "")
        if G ~= "Gears" then return G, V end
        local y, Z = V:match("^([^:]+)::(.+)$")
        if not d.Mail.IsGiftableCategory(y) or y == "Seeds" or y == "Pets" or y == "HarvestedFruits" then return nil, nil end
        return y, Z
    end,
    GetGearCategories = function()
        local G = {}
        local V = y.MailboxItemCatalog
        local Z = type(V) == "table" and V.Categories
        if type(Z) ~= "table" then return G end
        for V, y in ipairs(Z) do
            if type(y) == "string" and (y ~= "Seeds" and (y ~= "Pets" and y ~= "HarvestedFruits")) then
                table.insert(G, y)
            end
        end
        return G
    end,
    GetGearDropdown = function()
        local G = {}
        local V = d.Mail.GetInventory()
        if type(V) ~= "table" then return G end
        for y, Z in ipairs(d.Mail.GetGearCategories()) do
            local j = V[Z]
            if type(j) ~= "table" then continue end
            local i = Z:gsub("(%l)(%u)", "%1 %2")
            for V, y in pairs(j) do
                y = math.max(math.floor(tonumber(y) or 0), 0)
                if type(V) ~= "string" or V == "" or y <= 0 then continue end
                table.insert(G,
                    {
                        Text = string.format(
                            "<font color=\"#FFFFFF\">%s</font> <font color=\"#7CFC00\">x%d</font> <font color=\"#AAAAAA\">(%s)</font>",
                            V, y, i),
                        Value = d.Mail.EncodeGearSelection(Z, V)
                    })
            end
        end
        table.sort(G, function(G, V) return tostring(G.Value) < tostring(V.Value) end)
        return G
    end,
    GetItemDisplayName = function(G, V)
        if G == "Pets" then
            local G = y.PetData and y.PetData[V]
            if type(G) == "table" and (type(G.DisplayName) == "string" and G.DisplayName ~= "") then return G
                .DisplayName end
        end
        return tostring(V or "Unknown")
    end,
    GetItemDropdown = function(G)
        if G == "Seeds" then return d.SeedData.GetSeedDataListDropDown() end
        if G == "Gears" then return d.Mail.GetGearDropdown() end
        local V = {}
        if G ~= "Pets" or type(y.PetData) ~= "table" then return V end
        for G, y in pairs(y.PetData) do
            if type(G) ~= "string" or type(y) ~= "table" then continue end
            local Z = tostring(y.DisplayName or G)
            local j = tostring(y.Rarity or "Unknown")
            local i = d.Data.GetRarityColor(j)
            table.insert(V,
                { Text = string.format("<font color=\"#FFFFFF\">%s</font> <font color=\"%s\">%s</font>", Z, i, j), Value =
                G })
        end
        table.sort(V, function(G, V) return tostring(G.Value) < tostring(V.Value) end)
        return V
    end,
    PassesSelection = function(G, V)
        if type(G) ~= "table" or next(G) == nil then return true end
        return G[V] == true
    end,
    GetPetVariant = function(G)
        if type(G) == "table" and G.Type == "Rainbow" then return "Rainbow" end
        return "Normal"
    end,
    GetPetSize = function(G)
        local V = type(G) == "table" and G.Size
        if V == "Big" or V == "Huge" then return V end
        return "Normal"
    end,
    CleanupRecentlySentPets = function()
        local G = os.clock()
        for V, y in pairs(d.Mail.RecentlySentPets) do if tonumber(y) == nil or G >= y then d.Mail.RecentlySentPets[V] = nil end end
    end,
    GetMatchingPets = function(G, V, y, Z)
        local j = {}
        local i = d.Mail.GetInventory()
        local c = i and i.Pets
        if type(c) ~= "table" then return j end
        d.Mail.CleanupRecentlySentPets()
        for i, c in pairs(c) do
            if type(c) ~= "table" or c.Id == nil then continue end
            local J = c.Name or c.PetName or c.Species
            local T = tostring(i)
            local u = tostring(c.Id)
            if J ~= G or c.Equipped == true or d.Mail.EquippedPets[T] or d.Mail.EquippedPets[u] or d.Mail.RecentlySentPets[T] or d.Mail.RecentlySentPets[u] or type(Z) == "table" and ((Z[T] or Z[u])) then continue end
            local q = d.Mail.GetPetVariant(c)
            local g = d.Mail.GetPetSize(c)
            if not d.Mail.PassesSelection(V, q) or not d.Mail.PassesSelection(y, g) then continue end
            table.insert(j, { key = T, id = u, data = c })
        end
        table.sort(j, function(G, V) return G.key < V.key end)
        return j
    end,
    GetAvailableCount = function(G, V, y, Z, j)
        local i = d.Mail.GetInventory()
        if not i then return 0 end
        if G == "Pets" then return #d.Mail.GetMatchingPets(V, y, Z, j) end
        if not d.Mail.IsGiftableCategory(G) or G == "HarvestedFruits" then return 0 end
        local c = i[G]
        return type(c) == "table" and math.max(math.floor(tonumber(c[V]) or 0), 0) or 0
    end,
    GetBatchAmount = function(G)
        G = math.max(math.floor(tonumber(G) or 0), 0)
        if Y.mail_ignore_batch_limit then return G end
        return math.min(G, d.Mail.MaxBatchItems)
    end,
    BuildBatch = function(G, V, y, Z, j, i)
        local c = {}
        y = d.Mail.GetBatchAmount(y)
        if y <= 0 then return c, 0 end
        if G == "Pets" then
            local G = d.Mail.GetMatchingPets(V, Z, j, i)
            local J = math.min(y, #G)
            for V = 1, J, 1 do table.insert(c, { Category = "Pets", ItemKey = G[V].key, Count = 1 }) end
            return c, J
        end
        if not d.Mail.IsGiftableCategory(G) or G == "HarvestedFruits" then return c, 0 end
        local J = d.Mail.GetAvailableCount(G, V)
        local T = math.min(y, J)
        if T > 0 then table.insert(c, { Category = G, ItemKey = V, Count = T }) end
        return c, T
    end,
    MarkBatchSent = function(G)
        for G, V in ipairs(G or {}) do
            if V.Category == "Pets" and type(V.ItemKey) == "string" then
                d.Mail.RecentlySentPets[V.ItemKey] =
                    os.clock() + 30
            end
        end
    end,
    SendBatch = function(G, V, Z, j)
        if d.Mail.Busy then return false, "Mailbox is busy" end
        if type(G) ~= "table" or type(G.userId) ~= "number" or type(V) ~= "table" or #V == 0 then
            return false,
                "Invalid mail request"
        end
        local i = y.Networking and (y.Networking.Mailbox and y.Networking.Mailbox.SendBatch)
        if not i or type(i.Fire) ~= "function" then return false, "Mailbox sending is unavailable" end
        d.Mail.Busy = true
        local c = d.Mail.GetSendWait()
        while c > 0 do
            if type(j) == "function" and not j() then
                d.Mail.Busy = false
                return false, "Manual order stopped"
            end
            if J.MailManualRunning then
                d.Mail.SetManualUiStatus(
                    string.format("Waiting %ds before the next mail", math.ceil(c)), "#FFCC66", "\226\143\179")
            end
            task.wait(math.min(c, 1))
            c = d.Mail.GetSendWait()
        end
        if type(j) == "function" and not j() then
            d.Mail.Busy = false
            return false, "Manual order stopped"
        end
        Z = d.Mail.GetNote(Z)
        local T, q, g = pcall(function() return i:Fire(G.userId, V, Z) end)
        d.Mail.Busy = false
        if not T then return false, "Try again" end
        if q ~= true then return false, type(g) == "string" and (g ~= "" and g) or "Could not send gift" end
        d.Mail.NextSendAt = os.clock() + d.Mail.SendDelay
        Y.mail_next_send_at = d.Mail.GetServerTime() + d.Mail.SendDelay
        d.Mail.MarkBatchSent(V)
        u.Save.SaveDataSync()
        return true, type(g) == "string" and (g ~= "" and g) or "Gift sent!"
    end,
    WaitForInventoryChange = function(G, V, y, Z, j)
        local i = os.clock() + 2.5
        repeat
            task.wait(.1)
            local c = d.Mail.GetAvailableCount(G, V, Z, j)
            if c < y then return true end
        until os.clock() >= i
        return false
    end,
    GetDraftItemsForUi = function()
        local G = J.MailActiveOrder
        if type(G) ~= "table" then G = Y.mail_manual_order end
        if type(G) == "table" and (type(G.items) == "table" and #G.items > 0) then return G.items, true end
        return J.MailDraftItems, false
    end,
    GetDraftText = function()
        local G, V = d.Mail.GetDraftItemsForUi()
        if type(G) ~= "table" or #G == 0 then return "<font color=\'#888888\'>No items added</font>" end
        local y = {}
        for G, Z in ipairs(G) do
            local j = math.max(math.floor(tonumber(Z.amount) or 0), 0)
            local i = math.clamp(math.floor(tonumber(Z.sent) or 0), 0, j)
            local c = d.Mail.GetItemDisplayName(Z.category, Z.itemName)
            if V then
                table.insert(y,
                    string.format("%d. %s <font color=\'#7CFC00\'>%d/%d</font> <font color=\'#AAAAAA\'>(%s)</font>", G, c,
                        i,
                        j, tostring(Z.category or "Unknown")))
            else
                table.insert(y,
                    string.format("%d. %dx %s <font color=\'#AAAAAA\'>(%s)</font>", G, j, c,
                        tostring(Z.category or "Unknown")))
            end
        end
        return table.concat(y, "\n")
    end,
    RefreshDraftUi = function()
        local G = J.MailUiRefs
        local V = type(G) == "table" and G.RefreshDraft or nil
        if type(V) ~= "function" then return end
        pcall(V)
    end,
    AddDraftItem = function(G, V, y)
        if J.MailManualRunning then return false, "Stop the current order first" end
        G, V = d.Mail.DecodeItemSelection(G, V)
        if not d.Mail.IsGiftableCategory(G) or G == "HarvestedFruits" then return false, "Select an item category" end
        if type(V) ~= "string" or V == "" then return false, "Select an item" end
        y = math.floor(tonumber(y) or 0)
        if y <= 0 then return false, "Amount must be above 0" end
        for Z, j in ipairs(J.MailDraftItems) do
            if j.category == G and j.itemName == V then
                j.amount += y
                d.Mail.RefreshDraftUi()
                return true, "Order item updated"
            end
        end
        table.insert(J.MailDraftItems, { category = G, itemName = V, amount = y })
        d.Mail.RefreshDraftUi()
        return true, "Item added"
    end,
    ClearDraft = function()
        if J.MailManualRunning then return false end
        table.clear(J.MailDraftItems)
        d.Mail.RefreshDraftUi()
        return true
    end,
    CloneDraftItems = function()
        local G = {}
        for V, y in ipairs(J.MailDraftItems) do
            table.insert(G,
                { category = y.category, itemName = y.itemName, amount = y.amount, sent = 0 })
        end
        return G
    end,
    BuildReceipt = function(G)
        local V = { "MAIL RECEIPT " .. tostring(G.id), "Delivered: " .. os.date("%d/%m/%Y %H:%M:%S"), string.format(
            "To: @%s (%s)", tostring(G.recipient.username), tostring(G.recipient.userId)), "Items:" }
        for G, y in ipairs(G.items) do
            table.insert(V,
                string.format("- %dx %s (%s)", y.amount, d.Mail.GetItemDisplayName(y.category, y.itemName), y.category))
        end
        table.insert(V, "Status: Delivered")
        return table.concat(V, "\n")
    end,
    TrimReceipts = function()
        if type(Y.mail_receipts) ~= "table" then Y.mail_receipts = {} end
        for G = #Y.mail_receipts, 1, -1 do if type(Y.mail_receipts[G]) ~= "string" then table.remove(Y.mail_receipts, G) end end
        while #Y.mail_receipts > d.Mail.MaxReceipts do table.remove(Y.mail_receipts) end
    end,
    AddReceipt = function(G)
        if type(G) ~= "string" or G == "" then return false end
        d.Mail.TrimReceipts()
        table.insert(Y.mail_receipts, 1, G)
        d.Mail.TrimReceipts()
        u.Save.SaveDataSync()
        local V = J.MailUiRefs.RefreshReceipts
        if type(V) == "function" then V() end
        return true
    end,
    GetReceiptDropdown = function()
        d.Mail.TrimReceipts()
        local G = {}
        for V, y in ipairs(Y.mail_receipts) do
            local Z = y:match("([^\n]+)") or ("Receipt " .. V)
            local j = y:match("To:%s*([^\n]+)") or ""
            table.insert(G, { Text = string.format("%s | %s", Z, j), Value = tostring(V) })
        end
        return G
    end,
    IsSavedManualOrderValid = function(G)
        if type(G) ~= "table" or type(G.id) ~= "string" or G.id == "" or type(G.recipient) ~= "table" or type(G.recipient.userId) ~= "number" or type(G.items) ~= "table" or #G.items == 0 then return false end
        return true
    end,
    SaveManualOrder = function(G)
        if not d.Mail.IsSavedManualOrderValid(G) then return false end
        Y.mail_manual_order = G
        u.Save.SaveDataSync()
        return true
    end,
    ClearSavedManualOrder = function()
        Y.mail_manual_order = {}
        u.Save.SaveDataSync()
    end,
    ApplyPendingParts = function(G, V)
        if type(G) ~= "table" or type(G.items) ~= "table" or type(V) ~= "table" then return false end
        for V, y in ipairs(V) do
            local Z = math.floor(tonumber(y.itemIndex) or 0)
            local j = G.items[Z]
            if not j then continue end
            local i = math.max(math.floor(tonumber(j.amount) or 0), 0)
            local c = math.max(math.floor(tonumber(y.sentBefore) or 0), 0)
            local J = math.max(math.floor(tonumber(y.count) or 0), 0)
            j.sent = math.min(math.max(math.floor(tonumber(j.sent) or 0), c + J), i)
        end
        return true
    end,
    BuildCombinedManualBatch = function(G)
        local V = {}
        local y = {}
        local Z = 0
        local j = 0
        local i = Y.mail_ignore_batch_limit and math.huge or d.Mail.MaxBatchItems
        if type(G) ~= "table" or type(G.items) ~= "table" then return V, y, Z, j end
        for G, c in ipairs(G.items) do
            local J = math.max(math.floor(tonumber(c.amount) or 0), 0)
            c.sent = math.max(math.floor(tonumber(c.sent) or 0), 0)
            local T = math.max(J - c.sent, 0)
            if T <= 0 then continue end
            Z += 1
            if i <= 0 then continue end
            local u = d.Mail.GetAvailableCount(c.category, c.itemName)
            local q = math.min(T, u, i)
            if q <= 0 then continue end
            local g, E = d.Mail.BuildBatch(c.category, c.itemName, q)
            if E <= 0 then continue end
            for G, y in ipairs(g) do table.insert(V, y) end
            table.insert(y,
                {
                    itemIndex = G,
                    category = c.category,
                    itemName = c.itemName,
                    count = E,
                    beforeCount = u,
                    sentBefore = c
                        .sent,
                    batch = g
                })
            j += E
            i -= E
        end
        return V, y, Z, j
    end,
    RunCombinedManualItems = function(G)
        local V = 0
        while J.MailManualRunning and (J.MailActiveOrder == G and G.cancelled ~= true) do
            local y, Z, j, i = d.Mail.BuildCombinedManualBatch(G)
            if j <= 0 then return true end
            if i <= 0 then
                d.Mail.SetStatus(G.id .. " | Waiting for remaining items", "#FFCC66")
                d.Mail.SetManualUiStatus("Waiting for remaining order items", "#FFCC66", "\226\143\179")
                task.wait(2)
                continue
            end
            G.pending = { parts = Z, batch = y }
            d.Mail.SaveManualOrder(G)
            d.Mail.SetStatus(string.format("%s | Sending %d items together", G.id, i), "#66CCFF")
            d.Mail.SetManualUiStatus(
                string.format("Sending %d items from %d order lines to @%s", i, #Z, tostring(G.recipient.username or "?")),
                "#66CCFF", "\240\159\147\164")
            local c, T = d.Mail.SendBatch(G.recipient, y, string.format("Order %s | Combined %d items", G.id, i),
                function() return J.MailManualRunning and (J.MailActiveOrder == G and G.cancelled ~= true) end)
            if c then
                d.Mail.ApplyPendingParts(G, Z)
                G.pending = {}
                V = 0
                d.Mail.SaveManualOrder(G)
                d.Mail.RefreshDraftUi()
                d.Mail.SetManualUiStatus(string.format("Sent %d items together", i), "#7CFC00", "\226\156\133")
            else
                G.pending = {}
                V += 1
                d.Mail.SaveManualOrder(G)
                if G.cancelled == true or not J.MailManualRunning or J.MailActiveOrder ~= G then break end
                d.Mail.SetStatus(string.format("%s | %s", G.id, tostring(T)), "#FF5555")
                d.Mail.SetManualUiStatus(string.format("Combined send failed. Retrying in %ds", d.Mail.RetryDelay),
                    "#FF5555",
                    "\226\154\160\239\184\143")
                task.wait(d.Mail.RetryDelay)
            end
        end
        return false
    end,
    WasPendingBatchSent = function(G)
        if type(G) ~= "table" or type(G.batch) ~= "table" or #G.batch == 0 then return false end
        if G.category ~= "Pets" then
            if not d.Mail.IsGiftableCategory(G.category) or G.category == "HarvestedFruits" then return false end
            local V = d.Mail.GetAvailableCount(G.category, G.itemName)
            local y = math.max(math.floor(tonumber(G.beforeCount) or 0), 0)
            local Z = math.max(math.floor(tonumber(G.count) or 0), 0)
            return Z > 0 and V <= y - Z
        end
        local V = d.Mail.GetInventory()
        local y = V and V.Pets
        if type(y) ~= "table" then return false end
        for G, V in ipairs(G.batch) do if type(V) == "table" and (type(V.ItemKey) == "string" and y[V.ItemKey] ~= nil) then return false end end
        return true
    end,
    ReconcilePendingBatch = function(G)
        local V = type(G) == "table" and G.pending
        if type(V) ~= "table" or next(V) == nil then return false end
        if type(V.parts) == "table" and #V.parts > 0 then
            local y = true
            for G, V in ipairs(V.parts) do
                if not d.Mail.WasPendingBatchSent(V) then
                    y = false
                    break
                end
            end
            if y then d.Mail.ApplyPendingParts(G, V.parts) end
            G.pending = {}
            d.Mail.SaveManualOrder(G)
            return y
        end
        local y = math.floor(tonumber(V.itemIndex) or 0)
        local Z = type(G.items) == "table" and G.items[y]
        local j = Z and d.Mail.WasPendingBatchSent(V) or false
        if j then
            local G = math.max(math.floor(tonumber(V.sentBefore) or 0), 0)
            local y = math.max(math.floor(tonumber(V.count) or 0), 0)
            Z.sent = math.max(math.floor(tonumber(Z.sent) or 0), G + y)
        end
        G.pending = {}
        d.Mail.SaveManualOrder(G)
        return j
    end,
    RunManualOrder = function(G)
        if J.MailManualRunning or not d.Mail.IsSavedManualOrderValid(G) then return false end
        J.MailActiveOrder = G
        J.MailManualRunning = true
        G.state = "running"
        d.Mail.SaveManualOrder(G)
        d.Mail.SetManualUiStatus(string.format("Order %s started", G.id), "#66CCFF", "\240\159\147\166")
        d.Mail.RefreshManualUi()
        d.Mail.RefreshDraftUi()
        task.spawn(function()
            local V, y = pcall(function()
                d.Mail.ReconcilePendingBatch(G)
                if G.batchTogether == true then
                    d.Mail.RunCombinedManualItems(G)
                    return
                end
                for V, y in ipairs(G.items) do
                    y.sent = math.max(math.floor(tonumber(y.sent) or 0), 0)
                    local Z = {}
                    local j = 0
                    while J.MailManualRunning and y.sent < y.amount do
                        local i = y.amount - y.sent
                        local c = d.Mail.GetItemDisplayName(y.category, y.itemName)
                        local T = d.Mail.GetAvailableCount(y.category, y.itemName, nil, nil, Z)
                        if T <= 0 then
                            local V = string.format("Waiting for %d %s", i, c)
                            d.Mail.SetStatus(string.format("%s | %s", G.id, V), "#FFCC66")
                            d.Mail.SetManualUiStatus(V, "#FFCC66", "\226\143\179")
                            task.wait(2)
                            continue
                        end
                        local u = T
                        local q, g = d.Mail.BuildBatch(y.category, y.itemName, i, nil, nil, Z)
                        if g <= 0 then
                            task.wait(2)
                            continue
                        end
                        local E = y.sent + g
                        local a = string.format("Order %s | %s | %d/%d", G.id, c, E, y.amount)
                        G.pending = {
                            itemIndex = V,
                            category = y.category,
                            itemName = y.itemName,
                            count = g,
                            beforeCount = u,
                            sentBefore =
                                y.sent,
                            batch = q
                        }
                        d.Mail.SaveManualOrder(G)
                        d.Mail.SetStatus(string.format("%s | Sending %s %d/%d", G.id, c, E, y.amount), "#66CCFF")
                        d.Mail.SetManualUiStatus(
                            string.format("Sending %s %d/%d to @%s", c, E, y.amount,
                                tostring(G.recipient.username or "?")),
                            "#66CCFF", "\240\159\147\164")
                        local H, r = d.Mail.SendBatch(G.recipient, q, a,
                            function() return J.MailManualRunning and (J.MailActiveOrder == G and G.cancelled ~= true) end)
                        if H then
                            if G.cancelled == true or not J.MailManualRunning or J.MailActiveOrder ~= G then
                                G.pending = {}
                                break
                            end
                            y.sent = E
                            G.pending = {}
                            j = 0
                            for G, V in ipairs(q) do if V.Category == "Pets" then Z[V.ItemKey] = true end end
                            d.Mail.SaveManualOrder(G)
                            d.Mail.RefreshDraftUi()
                            d.Mail.SetManualUiStatus(string.format("Sent %s %d/%d", c, y.sent, y.amount), "#7CFC00",
                                "\226\156\133")
                            d.Mail.WaitForInventoryChange(y.category, y.itemName, u)
                        else
                            if G.cancelled == true or not J.MailManualRunning or J.MailActiveOrder ~= G then
                                G.pending = {}
                                break
                            end
                            G.pending = {}
                            j += 1
                            d.Mail.SaveManualOrder(G)
                            d.Mail.SetStatus(string.format("%s | %s", G.id, tostring(r)), "#FF5555")
                            d.Mail.SetManualUiStatus(string.format("Send failed. Retrying in %ds", d.Mail.RetryDelay),
                                "#FF5555", "\226\154\160\239\184\143")
                            if j >= d.Mail.MaxFailures then j = 0 end
                            task.wait(d.Mail.RetryDelay)
                        end
                    end
                    if not J.MailManualRunning then break end
                end
            end)
            if not V then
                warn("[Mail] Manual order error:", y)
                J.MailManualRunning = false
                J.MailActiveOrder = nil
                G.state = "resume"
                d.Mail.SaveManualOrder(G)
                d.Mail.SetStatus("Order paused: it will resume when the script starts again", "#FF4444")
                d.Mail.SetManualUiStatus("Paused. The order will resume when the script starts again", "#FF5555",
                    "\226\154\160\239\184\143")
                d.Mail.RefreshManualUi()
                return
            end
            if not J.MailManualRunning then
                J.MailActiveOrder = nil
                d.Mail.RefreshManualUi()
                return
            end
            d.Mail.AddReceipt(d.Mail.BuildReceipt(G))
            d.Webhooks.QueueMail("manual",
                {
                    orderId = tostring(G.id or "Unknown"),
                    recipient = G.recipient and G.recipient.username or "Unknown",
                    items =
                        d.Webhooks.CopyMailItems(G.items)
                })
            d.Mail.ClearSavedManualOrder()
            table.clear(J.MailDraftItems)
            d.Mail.RefreshDraftUi()
            J.MailManualRunning = false
            J.MailActiveOrder = nil
            d.Mail.SetStatus(G.id .. " delivered", "#7CFC00")
            d.Mail.SetManualUiStatus(string.format("Completed %s to @%s", G.id, tostring(G.recipient.username or "?")),
                "#7CFC00", "\226\156\133")
            d.Mail.RefreshManualUi()
            J.Notify("Order delivered: " .. G.id, 4)
        end)
        return true
    end,
    StartManualOrder = function(G)
        if J.MailManualRunning then return false, "An order is already running" end
        if d.Mail.IsSavedManualOrderValid(Y.mail_manual_order) then
            local G = d.Mail.RunManualOrder(Y.mail_manual_order)
            return G, G and "Resumed " .. tostring(Y.mail_manual_order.id) or "Could not resume the saved order"
        end
        if #J.MailDraftItems == 0 then return false, "Add at least one item" end
        local V, y = d.Mail.LookupRecipient(G)
        if not V then return false, y end
        local Z = {
            version = 1,
            id = d.Mail.MakeId("EXO"),
            recipient = V,
            items = d.Mail.CloneDraftItems(),
            pending = {},
            startedAt =
                os.time(),
            state = "running",
            batchTogether = Y.mail_manual_batch_together == true
        }
        d.Mail.SaveManualOrder(Z)
        if not d.Mail.RunManualOrder(Z) then return false, "Could not start the order" end
        return true, "Started " .. Z.id
    end,
    ResumeManualOrder = function()
        if J.MailManualRunning then return false end
        local G = Y.mail_manual_order
        if not d.Mail.IsSavedManualOrderValid(G) then return false end
        d.Mail.SetStatus("Resuming saved order " .. tostring(G.id), "#66CCFF")
        d.Mail.SetManualUiStatus("Resuming saved order " .. tostring(G.id), "#66CCFF", "\240\159\148\132")
        return d.Mail.RunManualOrder(G)
    end,
    StopManualOrder = function()
        if not J.MailManualRunning and not d.Mail.IsSavedManualOrderValid(Y.mail_manual_order) then return false end
        local G = J.MailActiveOrder
        if type(G) == "table" then G.cancelled = true end
        J.MailManualRunning = false
        J.MailActiveOrder = nil
        d.Mail.ClearSavedManualOrder()
        d.Mail.RefreshDraftUi()
        d.Mail.SetStatus("Manual order stopped", "#FF7777")
        d.Mail.SetManualUiStatus("Order stopped", "#FF7777", "\226\143\185\239\184\143")
        d.Mail.RefreshManualUi()
        return true
    end,
    AddRule = function(G, V, y, Z, j, i, c)
        if type(G) ~= "table" or type(G.userId) ~= "number" then return false, "Invalid recipient" end
        V, y = d.Mail.DecodeItemSelection(V, y)
        if not d.Mail.IsGiftableCategory(V) or V == "HarvestedFruits" then return false, "Select a category" end
        if type(y) ~= "string" or y == "" then return false, "Select an item" end
        Z = math.floor(tonumber(Z) or 0)
        j = math.floor(tonumber(j) or 0)
        if Z <= 0 or j <= 0 then return false, "Trigger and send amounts must be above 0" end
        if type(Y.mail_auto_rules) ~= "table" then Y.mail_auto_rules = {} end
        local T = d.Mail.MakeId("RULE")
        Y.mail_auto_rules[T] = {
            id = T,
            enabled = true,
            targetUserId = G.userId,
            targetUsername = G.username,
            targetDisplayName =
                G.displayName,
            category = V,
            itemName = y,
            triggerAmount = Z,
            sendAmount = j,
            petTypes = type(i) == "table" and i or
                {},
            petSizes = type(c) == "table" and c or {}
        }
        u.Save.SaveDataSync()
        local q = J.MailUiRefs.RefreshRules
        if type(q) == "function" then q() end
        return true, T
    end,
    RemoveRule = function(G)
        local V = Y.mail_auto_rules
        local y = type(V) == "table" and V[G]
        if type(y) ~= "table" then return false end
        y.enabled = false
        V[G] = nil
        d.Mail.RuleCooldowns[G] = nil
        u.Save.SaveDataSync()
        local Z = J.MailUiRefs.RefreshRules
        if type(Z) == "function" then Z() end
        return true
    end,
    ToggleRule = function(G)
        local V = type(Y.mail_auto_rules) == "table" and Y.mail_auto_rules[G]
        if type(V) ~= "table" then return false end
        V.enabled = V.enabled ~= true
        u.Save.SaveDataSync()
        local y = J.MailUiRefs.RefreshRules
        if type(y) == "function" then y() end
        return true, V.enabled
    end,
    GetRuleDropdown = function()
        local G = {}
        local V = type(Y.mail_auto_rules) == "table" and Y.mail_auto_rules or {}
        local y = {}
        for G, V in pairs(V) do if type(G) == "string" and type(V) == "table" then table.insert(y, G) end end
        table.sort(y)
        for y, Z in ipairs(y) do
            local j = V[Z]
            local i = d.Mail.GetItemDisplayName(j.category, j.itemName)
            local c = j.enabled == true and "ON" or "OFF"
            table.insert(G,
                {
                    Text = string.format("%s | %s | %s x%d at %d | @%s", c, Z, i, tonumber(j.sendAmount) or 0,
                        tonumber(j.triggerAmount) or 0, tostring(j.targetUsername or "?")),
                    Value = Z
                })
        end
        return G
    end,
    ProcessCombinedAutoRules = function(G, V)
        local y
        local Z = {}
        local j = {}
        local i = {}
        local c = {}
        local J = Y.mail_ignore_batch_limit and math.huge or d.Mail.MaxBatchItems
        for V, T in ipairs(V) do
            if J <= 0 then break end
            local q = G[T]
            local g = tonumber(d.Mail.RuleCooldowns[T]) or 0
            if type(q) ~= "table" or q.enabled ~= true or os.clock() < g then continue end
            local E = tonumber(q.targetUserId)
            if not E or E <= 0 then
                q.enabled = false
                u.Save.SaveDataSync()
                continue
            end
            if y and y.userId ~= E then continue end
            local a = tostring(q.category) .. ("::" .. tostring(q.itemName))
            local H = math.max(math.floor(tonumber(q.triggerAmount) or 1), 1)
            local r = math.max(math.floor(tonumber(q.sendAmount) or 1), 1)
            local Y = d.Mail.GetAvailableCount(q.category, q.itemName, q.petTypes, q.petSizes)
            if Y < H then continue end
            local e = Y
            if q.category == "Pets" then
                e = d.Mail.GetAvailableCount(q.category, q.itemName, q.petTypes, q.petSizes, i)
            else
                e =
                    math.max(Y - ((c[a] or 0)), 0)
            end
            if e <= 0 then continue end
            local s = math.min(r, e, J)
            local N, W = d.Mail.BuildBatch(q.category, q.itemName, s, q.petTypes, q.petSizes, i)
            if W <= 0 then continue end
            y = y or
                {
                    userId = E,
                    username = tostring(q.targetUsername or ""),
                    displayName = tostring(q.targetDisplayName or
                        q.targetUsername or "")
                }
            for G, V in ipairs(N) do
                table.insert(Z, V)
                if V.Category == "Pets" and type(V.ItemKey) == "string" then i[V.ItemKey] = true end
            end
            if q.category ~= "Pets" then c[a] = ((c[a] or 0)) + W end
            table.insert(j, { ruleId = T, rule = q, count = W })
            J -= W
        end
        if not y or #Z == 0 or #j == 0 then return 0 end
        d.Mail.SetStatus(string.format("Auto | Sending %d items from %d rules to @%s", #Z, #j, y.username), "#66CCFF")
        local T, q = d.Mail.SendBatch(y, Z, string.format("Auto combined | %d rules", #j))
        if not T then
            for G, V in ipairs(j) do d.Mail.RuleCooldowns[V.ruleId] = os.clock() + d.Mail.RetryDelay end
            d.Mail.SetStatus("Auto combined send failed: " .. tostring(q), "#FF5555")
            return 0
        end
        local g = 0
        local E = {}
        local a = {}
        for G, V in ipairs(j) do
            local y = V.rule
            local Z = math.max(math.floor(tonumber(V.count) or 0), 0)
            local j = tostring(y.category) .. ("::" .. tostring(y.itemName))
            g += Z
            d.Mail.RuleCooldowns[V.ruleId] = os.clock() + 5
            local i = a[j]
            if not i then
                i = { category = y.category, name = d.Mail.GetItemDisplayName(y.category, y.itemName), count = 0 }
                a[j] = i
                table.insert(E, i)
            end
            i.count += Z
        end
        d.Webhooks.QueueMail("automatic",
            {
                ruleId = string.format("Combined (%d rules)", #j),
                recipient = y.username,
                items =
                    E
            })
        d.Mail.SetStatus(string.format("Auto | Sent %d items from %d rules to @%s", g, #j, y.username), "#7CFC00")
        return g
    end,
    ProcessAutoRules = function()
        if not Y.mail_auto_send_enabled or J.MailManualRunning or d.Mail.Busy then return 0 end
        local G = type(Y.mail_auto_rules) == "table" and Y.mail_auto_rules or {}
        local V = {}
        local y = 0
        for G, Z in pairs(G) do
            if type(G) == "string" and (type(Z) == "table" and Z.enabled == true) then
                y += 1
                table.insert(V, G)
            end
        end
        if y == 0 then
            d.Mail.SetStatus("Auto send waiting: add a rule", "#CFCFCF")
            return 0
        end
        table.sort(V)
        if Y.mail_auto_batch_together then
            local y = d.Mail.ProcessCombinedAutoRules(G, V)
            if y <= 0 then d.Mail.SetStatus("Auto send waiting for matching items", "#CFCFCF") end
            return y
        end
        for V, y in ipairs(V) do
            local Z = G[y]
            local j = tonumber(d.Mail.RuleCooldowns[y]) or 0
            if os.clock() < j then continue end
            local i = d.Mail.GetAvailableCount(Z.category, Z.itemName, Z.petTypes, Z.petSizes)
            local c = math.max(math.floor(tonumber(Z.triggerAmount) or 1), 1)
            local J = math.max(math.floor(tonumber(Z.sendAmount) or 1), 1)
            if i < c then continue end
            local T = {
                userId = tonumber(Z.targetUserId),
                username = tostring(Z.targetUsername or ""),
                displayName =
                    tostring(Z.targetDisplayName or Z.targetUsername or "")
            }
            if not T.userId or T.userId <= 0 then
                Z.enabled = false
                u.Save.SaveDataSync()
                continue
            end
            local q = math.min(J, i)
            local g = 0
            local E = {}
            while Y.mail_auto_send_enabled and (Z.enabled == true and g < q) do
                local G = d.Mail.GetAvailableCount(Z.category, Z.itemName, Z.petTypes, Z.petSizes, E)
                local V, j = d.Mail.BuildBatch(Z.category, Z.itemName, q - g, Z.petTypes, Z.petSizes, E)
                if j <= 0 then break end
                local i = d.Mail.GetItemDisplayName(Z.category, Z.itemName)
                local c = g + j
                local J = string.format("Auto %s | %s | %d/%d", y, i, c, q)
                d.Mail.SetStatus(string.format("Auto | Sending %s %d/%d to @%s", i, c, q, T.username), "#66CCFF")
                local u, a = d.Mail.SendBatch(T, V, J)
                if not u then
                    d.Mail.RuleCooldowns[y] = os.clock() + d.Mail.RetryDelay
                    d.Mail.SetStatus("Auto send failed: " .. tostring(a), "#FF5555")
                    return g
                end
                g = c
                for G, V in ipairs(V) do if V.Category == "Pets" then E[V.ItemKey] = true end end
                d.Mail.WaitForInventoryChange(Z.category, Z.itemName, G, Z.petTypes, Z.petSizes)
            end
            d.Mail.RuleCooldowns[y] = os.clock() + 5
            if g > 0 then
                d.Webhooks.QueueMail("automatic",
                    { ruleId = y, recipient = T.username, items = { { category = Z.category, name = d.Mail.GetItemDisplayName(Z.category, Z.itemName), count = g } } })
                d.Mail.SetStatus(
                    string.format("Auto | Sent %d %s to @%s", g, d.Mail.GetItemDisplayName(Z.category, Z.itemName),
                        T.username),
                    "#7CFC00")
                return g
            end
        end
        d.Mail.SetStatus("Auto send waiting for matching items", "#CFCFCF")
        return 0
    end,
    ClaimInbox = function(G)
        if not G and not Y.mail_auto_accept then return 0 end
        if J.MailManualRunning or d.Mail.Busy then return 0 end
        local V = y.Networking and y.Networking.Mailbox
        local Z = V and V.OpenInbox
        local j = V and V.Claim
        if not Z or type(Z.Fire) ~= "function" or not j or type(j.Fire) ~= "function" then return 0 end
        d.Mail.Busy = true
        local i, c = pcall(function() return Z:Fire() end)
        if not i or type(c) ~= "table" then
            d.Mail.Busy = false
            return 0
        end
        local T = {}
        for G, V in pairs(c) do if type(G) == "string" and type(V) == "table" then table.insert(T, G) end end
        table.sort(T)
        local u = 0
        local q = {}
        for V, y in ipairs(T) do
            if not G and not Y.mail_auto_accept then break end
            d.Mail.SetStatus(string.format("Claiming incoming mail %d/%d", V, #T), "#66CCFF")
            local Z, i, J = pcall(function() return j:Fire(y) end)
            if Z and i == true then
                u += 1
                local G = c[y]
                if type(G) == "table" then
                    local V = G.Items
                    if type(V) ~= "table" or #V == 0 then V = { G } end
                    table.insert(q,
                        { from = tostring(G.FromName or G.From or "Unknown"), items = d.Webhooks.CopyMailItems(V) })
                end
                task.wait(d.Mail.ClaimDelay)
            elseif Z and (type(J) == "string" and J ~= "") then
                d.Mail.SetStatus("Claim failed: " .. J, "#FF5555")
                task.wait(1)
            else
                task.wait(1)
            end
        end
        d.Mail.Busy = false
        if u > 0 then
            d.Webhooks.QueueMail("claim", { count = u, mode = G and "Manual Claim" or "Automatic Claim", mails = q })
            d.Mail.SetStatus(string.format("Claimed %d incoming mail", u), "#7CFC00")
        elseif #T == 0 then
            d.Mail.SetStatus("Incoming mailbox is empty", "#CFCFCF")
        else
            d.Mail.SetStatus(
                "Incoming mail could not be claimed", "#FF5555")
        end
        return u
    end,
    LoadEquippedPets = function()
        local G = y.Networking and (y.Networking.Pets and y.Networking.Pets.GetEquippedPets)
        if not G or type(G.Fire) ~= "function" then return false end
        local V, Z = pcall(function() return G:Fire() end)
        if not V or type(Z) ~= "table" then return false end
        table.clear(d.Mail.EquippedPets)
        for G, V in pairs(Z) do if type(V) == "table" and V.Id ~= nil then d.Mail.EquippedPets[tostring(V.Id)] = true end end
        return true
    end,
    MailLoopStart = function()
        if d.Mail.Started then return end
        d.Mail.Started = true
        d.Mail.TrimReceipts()
        if type(Y.mail_auto_rules) ~= "table" then Y.mail_auto_rules = {} end
        task.spawn(function()
            d.Mail.LoadEquippedPets()
            d.Mail.ResumeManualOrder()
        end)
        local G = y.Networking and y.Networking.Pets
        local V = G and G.PetEquipped
        local Z = G and G.PetUnequipped
        if V and V.OnClientEvent then V.OnClientEvent:Connect(function(G) if G ~= nil then d.Mail.EquippedPets[tostring(G)] = true end end) end
        if Z and Z.OnClientEvent then Z.OnClientEvent:Connect(function(G) if G ~= nil then d.Mail.EquippedPets[tostring(G)] = nil end end) end
        local j = y.Networking and (y.Networking.Mailbox and y.Networking.Mailbox.Updated)
        if j and j.OnClientEvent then
            j.OnClientEvent:Connect(function()
                if Y.mail_auto_accept then
                    task.defer(function()
                        d
                            .Mail.ClaimInbox(false)
                    end)
                end
            end)
        end
        task.spawn(function()
            while true do
                task.wait(3)
                if not J.GetCheckIfPro() then break end
                local G, V = pcall(d.Mail.ProcessAutoRules)
                if not G then
                    warn("[Mail] Auto rule error:", V)
                    d.Mail.SetStatus("Auto send error", "#FF4444")
                end
            end
        end)
        task.spawn(function()
            while true do
                task.wait(12)
                if Y.mail_auto_accept then
                    local G, V = pcall(function() d.Mail.ClaimInbox(false) end)
                    if not G then warn("[Mail] Auto claim error:", V) end
                end
            end
        end)
    end
}
d.Mail.TrimReceipts()
J.PetFinder_WebhookData = J.PetFinder_WebhookData or {}
J.Mail_WebhookData = J.Mail_WebhookData or {}
J.EventSeed_WebhookData = J.EventSeed_WebhookData or {}
J.PetFinderPremiumStatusText = ""
J.PetFinderPremiumUi = J.PetFinderPremiumUi or {}
d.PetFinderPremium = {
    Started = false,
    Busy = false,
    Folder = nil,
    Pets = {},
    FolderConnections = {},
    Pending = nil,
    Handled = {},
    RetryAt = {},
    Attempts = {},
    ExpectedCounts = {},
    MaxAttempts = 2,
    SizeRanks = { Normal = 1, Big = 2, Huge = 3 },
    VariantRanks = { Normal = 1, Rainbow = 2 },
    NextScanAt = 0,
    NextHopAt = 0,
    ScanDelay = 10,
    ConfirmTimeout = 3,
    SetStatus = function(
        G, V)
        J.PetFinderPremiumStatusText = string.format(
            "<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\144\190 [Pet Finder Premium]</font> <font color=\'%s\'>%s</font></stroke>",
            tostring(V or "#FFFFFF"), tostring(G or "Waiting"))
    end,
    ClearStatus = function()
        J.PetFinderPremiumStatusText =
        ""
    end,
    GetServerTime = function()
        local G, V = pcall(function() return y.Workspace:GetServerTimeNow() end)
        return G and tonumber(V) or os.time()
    end,
    CopyMap = function(G)
        local V = {}
        if type(G) == "table" then for G, y in pairs(G) do if type(G) == "string" and (G ~= "" and y == true) then V[G] = true end end end
        return V
    end,
    GetDisplayName = function(G)
        local V = type(y.PetData) == "table" and y.PetData[G] or nil
        local Z = type(V) == "table" and V.DisplayName or nil
        return type(Z) == "string" and (Z ~= "" and Z) or tostring(G or "Unknown")
    end,
    GetPetLabel = function(G, V, y)
        local Z = {}
        if type(G) == "string" and (G ~= "" and G ~= "Normal") then table.insert(Z, G) end
        if type(V) == "string" and (V ~= "" and V ~= "Normal") then table.insert(Z, V) end
        table.insert(Z, tostring(y or "Unknown"))
        return table.concat(Z, " ")
    end,
    GetRarity = function(G, V)
        if type(V) == "string" and V ~= "" then return V end
        local Z = type(y.PetData) == "table" and y.PetData[G] or nil
        return type(Z) == "table" and tostring(Z.Rarity or "Unknown") or "Unknown"
    end,
    GetSize = function(G)
        if type(G) ~= "string" or G == "" then return "Normal" end
        local V = type(y.PetSizes) == "table" and (type(y.PetSizes.Normalize) == "function" and y.PetSizes.Normalize(G)) or
            nil
        return type(V) == "string" and (V ~= "" and V) or G
    end,
    GetVariant = function(G) return type(G) == "string" and (G ~= "" and G) or "Normal" end,
    GetInventoryPets = function()
        local G = d.DataReplica.GetData("Inventory")
        local V = type(G) == "table" and G.Pets or nil
        return type(V) == "table" and V or {}
    end,
    GetPetDropdown = function()
        local G = {}
        if type(y.PetData) ~= "table" then return G end
        for V, y in pairs(y.PetData) do
            if type(V) ~= "string" or V == "" or type(y) ~= "table" then continue end
            local Z = tostring(y.DisplayName or V)
            local j = tostring(y.Rarity or "Unknown")
            local i = tonumber(y.BasePrice) or 0
            local T = tostring(y.SpawnChance or 0)
            local u = d.Data.GetRarityColor(j)
            table.insert(G,
                {
                    Text = string.format(
                        "<font color=\"#FFFFFF\">%s</font> <font color=\"#7CFC00\">$%s</font> <font color=\"%s\">%s</font> <font color=\"#CFCFCF\">(%%%s)</font>",
                        Z, c.formatShecklesNumber(i), u, j, T),
                    Value = V,
                    Rank = J.RarityRank[j] or 0
                })
        end
        table.sort(G,
            function(G, V)
                if G.Rank ~= V.Rank then return G.Rank > V.Rank end
                return tostring(G.Value) < tostring(V.Value)
            end)
        return G
    end,
    GetOptionValues = function(G)
        local V = { Normal = true }
        if G == "Size" and (type(y.PetSizes) == "table" and type(y.PetSizes.Scales) == "table") then for G in pairs(y.PetSizes.Scales) do V[G] = true end elseif G == "Variant" and (type(y.PetTypes) == "table" and type(y.PetTypes.Rainbow) == "string") then V[y.PetTypes.Rainbow] = true end
        for y in pairs(d.PetFinderPremium.Pets) do
            if y and y.Parent then
                local Z = G == "Size" and d.PetFinderPremium.GetSize(y:GetAttribute("PetSize")) or
                    d.PetFinderPremium.GetVariant(y:GetAttribute("PetType"))
                V[Z] = true
            end
        end
        for y, Z in pairs(d.PetFinderPremium.GetInventoryPets()) do
            if type(Z) == "table" then
                local y = G == "Size" and d.PetFinderPremium.GetSize(Z.Size) or d.PetFinderPremium.GetVariant(Z.Type)
                V[y] = true
            end
        end
        local Z = {}
        local j = G == "Size" and { Normal = 1, Big = 2, Huge = 3 } or { Normal = 1, Rainbow = 2 }
        for G in pairs(V) do table.insert(Z, G) end
        table.sort(Z,
            function(G, V)
                local y = j[G] or 100
                local Z = j[V] or 100
                if y ~= Z then return y < Z end
                return tostring(G) < tostring(V)
            end)
        local i = {}
        for G, V in ipairs(Z) do table.insert(i, { Text = V, Value = V }) end
        return i
    end,
    GetSizeValues = function() return d.PetFinderPremium.GetOptionValues("Size") end,
    GetVariantValues = function()
        return
            d.PetFinderPremium.GetOptionValues("Variant")
    end,
    GetRule = function(G)
        local V = type(Y.pet_finder_buy_list) == "table" and Y.pet_finder_buy_list[G] or nil
        if type(V) ~= "table" then return nil end
        return {
            enabled = V.enabled == true,
            target = math.max(math.floor(tonumber(V.target) or 1), 1),
            sizes = d
                .PetFinderPremium.CopyMap(V.sizes),
            variants = d.PetFinderPremium.CopyMap(V.variants)
        }
    end,
    HasRule = function(G) return type(Y.pet_finder_buy_list) == "table" and type(Y.pet_finder_buy_list[G]) == "table" end,
    ResetPetRuntime = function(
        G)
        d.PetFinderPremium.ExpectedCounts[G] = nil
        for V in pairs(d.PetFinderPremium.Pets) do
            local y = V and (V.Parent and V:GetAttribute("PetName")) or nil
            if y == G then
                d.PetFinderPremium.Attempts[V] = nil
                d.PetFinderPremium.RetryAt[V] = nil
                d.PetFinderPremium.Handled[V] = nil
            end
        end
    end,
    SetRule = function(G, V, Z, j, i)
        if type(G) ~= "string" or G == "" or type(y.PetData) ~= "table" or not y.PetData[G] then return false end
        V = math.max(math.floor(tonumber(V) or 0), 0)
        if V <= 0 then return false end
        if type(Y.pet_finder_buy_list) ~= "table" then Y.pet_finder_buy_list = {} end
        Y.pet_finder_buy_list[G] = {
            enabled = i == true,
            target = V,
            sizes = d.PetFinderPremium.CopyMap(Z),
            variants = d
                .PetFinderPremium.CopyMap(j)
        }
        d.PetFinderPremium.ResetPetRuntime(G)
        if i == true and d.PetFinderPremium.ResetHopTimer then d.PetFinderPremium.ResetHopTimer() end
        return true
    end,
    SetRuleEnabled = function(G, V)
        if not d.PetFinderPremium.HasRule(G) then return false end
        Y.pet_finder_buy_list[G].enabled = V == true
        d.PetFinderPremium.ResetPetRuntime(G)
        if V == true and d.PetFinderPremium.ResetHopTimer then d.PetFinderPremium.ResetHopTimer() end
        return true
    end,
    GetActiveRuleNames = function()
        local G = {}
        if type(Y.pet_finder_buy_list) ~= "table" then return G end
        for V in pairs(Y.pet_finder_buy_list) do
            local y = d.PetFinderPremium.GetRule(V)
            if y and y.enabled then table.insert(G, V) end
        end
        table.sort(G)
        return G
    end,
    PassesSelection = function(G, V) return type(G) ~= "table" or next(G) == nil or G[V] == true end,
    PetNameMatches = function(
        G, V)
        return G == V or d.PetFinderPremium.GetDisplayName(G) == V
    end,
    CountOwnedRaw = function(G, V)
        local y = 0
        if type(V) ~= "table" then return y end
        for Z, j in pairs(d.PetFinderPremium.GetInventoryPets()) do
            if type(j) ~= "table" then continue end
            local i = j.Name or j.PetName or j.Species
            local c = d.PetFinderPremium.GetSize(j.Size)
            local J = d.PetFinderPremium.GetVariant(j.Type)
            if type(i) == "string" and (d.PetFinderPremium.PetNameMatches(G, i) and (d.PetFinderPremium.PassesSelection(V.sizes, c) and d.PetFinderPremium.PassesSelection(V.variants, J))) then y += 1 end
        end
        return y
    end,
    CountOwnedForRule = function(G, V)
        local y = d.PetFinderPremium.CountOwnedRaw(G, V)
        local Z = d.PetFinderPremium.ExpectedCounts[G]
        if type(Z) ~= "table" or os.clock() >= ((tonumber(Z.expiresAt) or 0)) then
            d.PetFinderPremium.ExpectedCounts[G] = nil
            return y
        end
        if y >= ((tonumber(Z.count) or 0)) then
            d.PetFinderPremium.ExpectedCounts[G] = nil
            return y
        end
        return math.max(y, tonumber(Z.count) or 0)
    end,
    HasReachedTarget = function(G, V) return d.PetFinderPremium.CountOwnedForRule(G, V) >= V.target end,
    GetPetData = function(
        G)
        if not G or not G.Parent or not G:IsA("BasePart") then return nil end
        local V = G:GetAttribute("PetName")
        if type(V) ~= "string" or V == "" then return nil end
        local y = tonumber(G:GetAttribute("SpawnedAt")) or 0
        local Z = tonumber(G:GetAttribute("Lifetime")) or 0
        return {
            ref = G,
            id = G.Name,
            name = V,
            displayName = d.PetFinderPremium.GetDisplayName(V),
            size = d
                .PetFinderPremium.GetSize(G:GetAttribute("PetSize")),
            variant = d.PetFinderPremium.GetVariant(G:GetAttribute(
                "PetType")),
            rarity = d.PetFinderPremium.GetRarity(V, G:GetAttribute("Rarity")),
            price = math.max(
                tonumber(G:GetAttribute("Price")) or 0, 0),
            ownerId = tonumber(G:GetAttribute("OwnerUserId")) or 0,
            expiresAt = y > 0 and
                (Z > 0 and y + Z) or 0
        }
    end,
    IsExpired = function(G) return G.expiresAt > 0 and d.PetFinderPremium.GetServerTime() >= G.expiresAt end,
    DisconnectFolder = function()
        for G, V in ipairs(d.PetFinderPremium.FolderConnections) do pcall(function() V:Disconnect() end) end
        table.clear(d.PetFinderPremium.FolderConnections)
    end,
    GetFolder = function()
        local G = y.Workspace:FindFirstChild("Map")
        local V = G and G:FindFirstChild("WildPetRef")
        return V and (V:IsA("Folder") and V) or nil
    end,
    BindFolder = function(G)
        if d.PetFinderPremium.Folder == G then return end
        d.PetFinderPremium.DisconnectFolder()
        d.PetFinderPremium.Folder = G
        table.clear(d.PetFinderPremium.Pets)
        table.clear(d.PetFinderPremium.Handled)
        table.clear(d.PetFinderPremium.RetryAt)
        table.clear(d.PetFinderPremium.Attempts)
        if not G then return end
        table.insert(d.PetFinderPremium.FolderConnections,
            G.ChildAdded:Connect(function(G)
                if G:IsA("BasePart") then
                    d.PetFinderPremium.Pets[G] = true
                    if J.PetFinderPremiumUi.RefreshValues then task.defer(J.PetFinderPremiumUi.RefreshValues) end
                end
            end))
        table.insert(d.PetFinderPremium.FolderConnections,
            G.ChildRemoved:Connect(function(G)
                d.PetFinderPremium.Pets[G] = nil
                d.PetFinderPremium.Handled[G] = nil
                d.PetFinderPremium.RetryAt[G] = nil
                d.PetFinderPremium.Attempts[G] = nil
            end))
    end,
    FullScan = function()
        d.PetFinderPremium.BindFolder(d.PetFinderPremium.GetFolder())
        local G = d.PetFinderPremium.Folder
        if G then
            for G, V in ipairs(G:GetChildren()) do if V:IsA("BasePart") then d.PetFinderPremium.Pets[V] = true end end
            for V in pairs(d.PetFinderPremium.Pets) do
                if typeof(V) ~= "Instance" or V.Parent ~= G then
                    d.PetFinderPremium.Pets[V] = nil
                    d.PetFinderPremium.Handled[V] = nil
                    d.PetFinderPremium.RetryAt[V] = nil
                    d.PetFinderPremium.Attempts[V] = nil
                end
            end
        end
        if J.PetFinderPremiumUi.RefreshValues then J.PetFinderPremiumUi.RefreshValues() end
        if J.PetFinderPremiumUi.RefreshRules then J.PetFinderPremiumUi.RefreshRules() end
    end,
    PassesRule = function(G, V)
        if not V or not V.enabled or G.ownerId ~= 0 or d.PetFinderPremium.IsExpired(G) then return false end
        if not d.PetFinderPremium.PassesSelection(V.sizes, G.size) or not d.PetFinderPremium.PassesSelection(V.variants, G.variant) or d.PetFinderPremium.HasReachedTarget(G.name, V) then return false end
        return ((tonumber(d.Money.GetSheckles()) or 0)) >= G.price
    end,
    GetCandidate = function()
        local G
        local V = 0
        local y = os.clock()
        local Z = d.PetFinderPremium.SizeRanks
        local j = d.PetFinderPremium.VariantRanks
        for i in pairs(d.PetFinderPremium.Pets) do
            if d.PetFinderPremium.Handled[i] or ((tonumber(d.PetFinderPremium.Attempts[i]) or 0)) >= d.PetFinderPremium.MaxAttempts or y < ((tonumber(d.PetFinderPremium.RetryAt[i]) or 0)) then continue end
            local c = d.PetFinderPremium.GetPetData(i)
            local J = c and d.PetFinderPremium.GetRule(c.name) or nil
            if c and d.PetFinderPremium.PassesRule(c, J) then
                V += 1
                if not G then
                    G = c
                else
                    local V = Z[G.size] or 100
                    local y = Z[c.size] or 100
                    local i = j[G.variant] or 100
                    local J = j[c.variant] or 100
                    if y < V or y == V and J < i or y == V and (J == i and tostring(c.id) < tostring(G.id)) then G = c end
                end
            end
        end
        return G, V
    end,
    GetTrackedCount = function()
        local G = 0
        for V in pairs(d.PetFinderPremium.Pets) do G += 1 end
        return G
    end,
    AddPurchaseLog = function(G)
        if type(Y.pet_finder_purchase_log) ~= "table" then Y.pet_finder_purchase_log = {} end
        table.insert(Y.pet_finder_purchase_log, 1,
            {
                pet = G.name,
                display_name = G.displayName,
                size = G.size,
                variant = G.variant,
                rarity = G.rarity,
                price = G
                    .price,
                purchased_at = os.time()
            })
        while #Y.pet_finder_purchase_log > 10 do table.remove(Y.pet_finder_purchase_log) end
        u.Save.SaveDataSync()
        if J.PetFinderPremiumUi.RefreshLog then J.PetFinderPremiumUi.RefreshLog() end
    end,
    QueueWebhook = function(G)
        if not Y.webhook_pet_buys or type(G) ~= "table" then return false end
        return d.Webhooks.Queue(J.PetFinder_WebhookData,
            {
                event = "pet_purchase",
                pet = G.name,
                display_name = G.displayName,
                size = G.size,
                variant = G.variant,
                rarity =
                    G.rarity,
                price = tonumber(G.price) or 0,
                sheckles = tonumber(d.Money.GetSheckles()) or 0,
                purchased_at = os
                    .time(),
                username = y.LocalPlayer and y.LocalPlayer.Name or "Unknown"
            })
    end,
    ConfirmPurchase = function(G)
        local V = d.PetFinderPremium.Pending
        if not V or V.confirmed then return false end
        V.confirmed = true
        V.reason = tostring(G or "Confirmed")
        d.PetFinderPremium.Handled[V.ref] = true
        d.PetFinderPremium.ExpectedCounts[V.data.name] = { count = V.countBefore + 1, expiresAt = os.clock() + 20 }
        d.PetFinderPremium.AddPurchaseLog(V.data)
        d.PetFinderPremium.QueueWebhook(V.data)
        d.PetFinderPremium.ResetHopTimer()
        if J.PetFinderPremiumUi.RefreshRules then J.PetFinderPremiumUi.RefreshRules() end
        return true
    end,
    BuyPet = function(G)
        if d.PetFinderPremium.Busy or type(G) ~= "table" then return false end
        local V = G.ref
        local Z = d.PetFinderPremium.GetRule(G.name)
        local j = y.Networking and (y.Networking.Pets and y.Networking.Pets.WildPetTame)
        if not V or not V.Parent or not Z or not d.PetFinderPremium.PassesRule(G, Z) or not j or type(j.Fire) ~= "function" then return false end
        local i = J.TeleportLockNames.PetFinderPremium
        if not d.Teleport.LockTeleport(i, 6, false) then return false end
        d.PetFinderPremium.Busy = true
        d.PetFinderPremium.SetStatus("Buying " .. d.PetFinderPremium.GetPetLabel(G.size, G.variant, G.displayName),
            "#66CCFF")
        local c = d.StepTeleport.GetCFrame(V)
        local T = c and d.StepTeleport.FindGroundPosition(V, ((c + Vector3.new(5, 0, 0))).Position)
        if not T or not d.StepTeleport.ToCFrame(CFrame.new(T), i) then
            d.PetFinderPremium.Busy = false
            d.Teleport.UnlockTeleport(i)
            return false
        end
        task.wait(.2)
        G = d.PetFinderPremium.GetPetData(V)
        Z = G and d.PetFinderPremium.GetRule(G.name) or nil
        if not G or not Z or not d.PetFinderPremium.PassesRule(G, Z) then
            d.PetFinderPremium.Busy = false
            d.Teleport.UnlockTeleport(i)
            return false
        end
        local u = { ref = V, data = G, countBefore = d.PetFinderPremium.CountOwnedForRule(G.name, Z), startedAt = os
        .clock(), confirmed = false }
        d.PetFinderPremium.Pending = u
        d.PetFinderPremium.Attempts[V] = ((tonumber(d.PetFinderPremium.Attempts[V]) or 0)) + 1
        local q = pcall(function()
            if not V or not V.Parent then error("Pet disappeared") end
            local G = tonumber(V:GetAttribute("OwnerUserId")) or 0
            if G ~= 0 then error("Pet is no longer available") end
            if not d.Teleport.TeleportTo(V, false, i) then error("Final pet teleport failed") end
            j:Fire(V)
        end)
        if q then
            repeat
                local G = tonumber(V:GetAttribute("OwnerUserId")) or 0
                if G == tonumber(J.player_userid) then d.PetFinderPremium.ConfirmPurchase("Ownership confirmed") elseif G ~= 0 then break end
                if u.confirmed or not Y.pet_finder_enabled then break end
                task.wait(.05)
            until os.clock() - u.startedAt >= d.PetFinderPremium.ConfirmTimeout
        end
        local g = u.confirmed
        if g then
            local V = d.PetFinderPremium.CountOwnedForRule(G.name, Z)
            d.PetFinderPremium.SetStatus(
                string.format("Purchased %s | %d/%d", d.PetFinderPremium.GetPetLabel(G.size, G.variant, G.displayName), V,
                    Z.target), "#7CFC00")
        elseif Y.pet_finder_enabled then
            local y = tonumber(d.PetFinderPremium.Attempts[V]) or 0
            if y >= d.PetFinderPremium.MaxAttempts then
                d.PetFinderPremium.Handled[V] = true
                d.PetFinderPremium.SetStatus("Stopped retrying: " .. G.displayName, "#FFCC66")
            else
                d.PetFinderPremium.RetryAt[V] = os.clock() + 5
                d.PetFinderPremium.SetStatus("Purchase not confirmed: " .. G.displayName, "#FFCC66")
            end
        end
        d.PetFinderPremium.Pending = nil
        d.PetFinderPremium.Busy = false
        d.Teleport.UnlockTeleport(i)
        return g
    end,
    GetHopMinutes = function() return math.max(math.floor(tonumber(Y.pet_finder_hop_minutes) or 5), 1) end,
    ResetHopTimer = function()
        d.PetFinderPremium.NextHopAt =
            os.clock() + d.PetFinderPremium.GetHopMinutes() * 60
    end,
    GetHopRemaining = function()
        if d.PetFinderPremium.NextHopAt <= 0 then d.PetFinderPremium.ResetHopTimer() end
        return math.max(math.ceil(d.PetFinderPremium.NextHopAt - os.clock()), 0)
    end,
    FormatTime = function(G)
        G = math.max(math.floor(tonumber(G) or 0), 0)
        return string.format("%dm %02ds", math.floor(G / 60), G % 60)
    end,
    HasUnmetTargets = function()
        for G, V in ipairs(d.PetFinderPremium.GetActiveRuleNames()) do
            local y = d.PetFinderPremium.GetRule(V)
            if y and not d.PetFinderPremium.HasReachedTarget(V, y) then return true end
        end
        return false
    end,
    UpdateIdle = function(G)
        local V = d.PetFinderPremium.GetTrackedCount()
        if not Y.pet_finder_auto_hop then
            d.PetFinderPremium.SetStatus(
                string.format("Monitoring %d pet%s | %d ready", V, V == 1 and "" or "s", G or 0),
                "#CFCFCF")
            return
        end
        local y = d.PetFinderPremium.GetHopRemaining()
        if y > 0 then
            d.PetFinderPremium.SetStatus(
                string.format("Monitoring %d pet%s | Hop in %s", V, V == 1 and "" or "s",
                    d.PetFinderPremium.FormatTime(y)),
                "#FFD966")
            return
        end
        local Z = J.TeleportLockNames.PetFinderPremium
        if d.Teleport.IsLocked(Z) then
            d.PetFinderPremium.SetStatus("Hop ready | Waiting for teleport", "#FFCC66")
            return
        end
        d.PetFinderPremium.SetStatus("Hopping to a new server...", "#66CCFF")
        d.PetFinderPremium.ResetHopTimer()
        H.Hop.HopToNewServer()
    end,
    Loop = function()
        if not J.GetCheckIfPro() then return end
        if os.clock() >= d.PetFinderPremium.NextScanAt then
            d.PetFinderPremium.NextScanAt = os.clock() + d.PetFinderPremium.ScanDelay
            d.PetFinderPremium.FullScan()
        end
        if not Y.pet_finder_enabled then
            d.PetFinderPremium.ClearStatus()
            return
        end
        if #d.PetFinderPremium.GetActiveRuleNames() == 0 then
            d.PetFinderPremium.SetStatus("Paused: add an enabled pet rule", "#FFCC66")
            return
        end
        if not d.PetFinderPremium.HasUnmetTargets() then
            d.PetFinderPremium.SetStatus("All pet targets reached", "#7CFC00")
            return
        end
        if d.PetFinderPremium.Busy or d.PetFinderPremium.Pending then return end
        local G, V = d.PetFinderPremium.GetCandidate()
        if G then d.PetFinderPremium.BuyPet(G) else d.PetFinderPremium.UpdateIdle(V) end
    end,
    Start = function()
        if d.PetFinderPremium.Started then return end
        d.PetFinderPremium.Started = true
        d.PetFinderPremium.ResetHopTimer()
        d.PetFinderPremium.FullScan()
        local G = y.Networking and (y.Networking.Pets and y.Networking.Pets.WildPetTameResult)
        if G and G.OnClientEvent then
            G.OnClientEvent:Connect(function(G, V)
                local y = d.PetFinderPremium.Pending
                if y and (y.ref == G and tonumber(V) == tonumber(J.player_userid)) then
                    d.PetFinderPremium.ConfirmPurchase(
                        "Tame result confirmed")
                end
            end)
        end
        task.spawn(function()
            while d.PetFinderPremium.Started do
                task.wait(.5)
                if not J.GetCheckIfPro() then continue end
                local G, V = pcall(d.PetFinderPremium.Loop)
                if not G then
                    d.PetFinderPremium.Busy = false
                    d.PetFinderPremium.Pending = nil
                    d.Teleport.UnlockTeleport(J.TeleportLockNames.PetFinderPremium)
                    d.PetFinderPremium.SetStatus("Error: pet finder loop failed", "#FF4444")
                    warn("[PetFinderPremium]", V)
                end
            end
        end)
    end
}
J.WebhookStatusText = ""
d.Webhooks = {
    EventSeedListenerStarted = false,
    EventSeedConnection = nil,
    SetStatus = function(G, V)
        G = tostring(G or "")
        if G == "" then
            J.WebhookStatusText = ""
            return
        end
        J.WebhookStatusText = string.format(
            "<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\148\148 [Webhooks]</font> <font color=\'%s\'>%s</font></stroke>",
            tostring(V or "#FFFFFF"), G)
    end,
    ClearStatus = function() J.WebhookStatusText = "" end,
    IsMailTypeEnabled = function(G)
        if G == "manual" then return Y.webhook_mail_manual == true end
        if G == "automatic" then return Y.webhook_mail_auto == true end
        if G == "claim" then return Y.webhook_mail_claims == true end
        return false
    end,
    RemoveMailType = function(G)
        if type(J.Mail_WebhookData) ~= "table" then return end
        for V = #J.Mail_WebhookData, 1, -1 do
            local y = J.Mail_WebhookData[V]
            if type(y) ~= "table" or y.webhookType == G then table.remove(J.Mail_WebhookData, V) end
        end
    end,
    CopyMailItems = function(G)
        local V = {}
        if type(G) ~= "table" then return V end
        for G, y in ipairs(G) do
            if type(y) ~= "table" then continue end
            local Z = tostring(y.category or y.Category or "Unknown")
            local j = tostring(y.itemName or y.ItemName or y.name or y.ItemKey or "Unknown")
            local i = math.max(math.floor(tonumber(y.amount or y.count or y.Count or 1) or 1), 1)
            table.insert(V, { category = Z, name = d.Mail.GetItemDisplayName(Z, j), count = i })
        end
        return V
    end,
    QueueMail = function(G, V)
        if not Y.webhook_enabled then return false end
        if not d.Webhooks.IsMailTypeEnabled(G) or type(V) ~= "table" then return false end
        if type(J.Mail_WebhookData) ~= "table" then J.Mail_WebhookData = {} end
        V.webhookType = G
        V.queuedAt = os.time()
        return d.Webhooks.Queue(J.Mail_WebhookData, V)
    end,
    QueueEventSeed = function(G, V)
        if not Y.webhook_enabled or not Y.webhook_event_seeds or tostring(G or "") ~= tostring(y.LocalPlayer.Name) then return false end
        V = tostring(V or "")
        if V ~= "Gold Seed" and V ~= "Rainbow Seed" then return false end
        return d.Webhooks.Queue(J.EventSeed_WebhookData, { username = tostring(G), seed = V, queuedAt = os.time() })
    end,
    BuildEventSeedPayload = function(G)
        if type(G) ~= "table" then return nil end
        local V = tostring(G.seed or "")
        if V ~= "Gold Seed" and V ~= "Rainbow Seed" then return nil end
        local Z = V == "Rainbow Seed"
        return { username = "Exotic Hub", embeds = { { title = Z and "\240\159\140\136 Rainbow Seed Claimed!" or "\240\159\159\161 Gold Seed Claimed!", description = Z and "A rare **Rainbow Seed** was collected successfully!" or "A rare **Gold Seed** was collected successfully!", color = Z and 16729559 or 16766720, fields = { { name = "\240\159\140\177 Seed", value = "**" .. (V .. "**"), inline = true }, { name = "\240\159\145\164 Account", value = "||@" .. (tostring(G.username or "Unknown") .. "||"), inline = true } }, footer = { text = tostring(y.AppName or "Exotic Hub") .. (" " .. tostring(y.CurentV or "")) }, timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ") } } }
    end,
    StartEventSeedListener = function()
        if d.Webhooks.EventSeedListenerStarted then return false end
        local G = y.Networking and (y.Networking.SeedPackSpawn and y.Networking.SeedPackSpawn.Claimed)
        if not G or not G.OnClientEvent then return false end
        d.Webhooks.EventSeedListenerStarted = true
        d.Webhooks.EventSeedConnection = G.OnClientEvent:Connect(function(G, V) d.Webhooks.QueueEventSeed(G, V) end)
        return true
    end,
    TrimWebhookText = function(G, V)
        G = tostring(G or "")
        V = tonumber(V) or 1000
        if #G <= V then return G end
        return G:sub(1, V - 3) .. "..."
    end,
    BuildMailItemsText = function(G)
        local V = {}
        for G, y in ipairs(G or {}) do
            if type(y) ~= "table" then continue end
            table.insert(V,
                string.format("\226\128\162 **x%d %s** `%s`", math.max(math.floor(tonumber(y.count) or 1), 1),
                    tostring(y.name or "Unknown"), tostring(y.category or "Unknown")))
        end
        if #V == 0 then return "No item details available" end
        return d.Webhooks.TrimWebhookText(table.concat(V, "\n"), 1000)
    end,
    BuildClaimedMailText = function(G)
        local V = {}
        for G, y in ipairs(G or {}) do
            if type(y) ~= "table" then continue end
            local Z = tostring(y.from or "Unknown")
            local j = type(y.items) == "table" and y.items or {}
            if #j == 0 then
                table.insert(V, "\226\128\162 From **@" .. (Z .. "**"))
                continue
            end
            for G, y in ipairs(j) do
                table.insert(V,
                    string.format("\226\128\162 **@%s** \226\134\146 x%d %s `%s`", Z,
                        math.max(math.floor(tonumber(y.count) or 1), 1), tostring(y.name or "Unknown"),
                        tostring(y.category or "Unknown")))
            end
        end
        if #V == 0 then return "No item details available" end
        return d.Webhooks.TrimWebhookText(table.concat(V, "\n"), 1000)
    end,
    BuildMailPayload = function(G)
        if type(G) ~= "table" then return nil end
        local V = tostring(G.webhookType or "")
        local Z
        local j
        local i
        local c = {}
        if V == "manual" then
            Z = "\240\159\147\166 Manual Order Delivered!"
            j = "Your manual mailbox order was completed successfully."
            i = 5763719
            table.insert(c, { name = "\240\159\167\190 Order", value = tostring(G.orderId or "Unknown"), inline = true })
            table.insert(c,
                { name = "\240\159\145\164 Recipient", value = "||@" .. (tostring(G.recipient or "Unknown") .. "||"), inline = true })
            table.insert(c,
                { name = "\240\159\147\166 Items Delivered", value = d.Webhooks.BuildMailItemsText(G.items), inline = false })
        elseif V == "automatic" then
            Z = "\226\154\153\239\184\143 Automatic Mail Sent!"
            j = "An automatic mailbox rule completed successfully."
            i = 3447003
            table.insert(c,
                { name = "\226\154\153\239\184\143 Rule", value = tostring(G.ruleId or "Unknown"), inline = true })
            table.insert(c,
                { name = "\240\159\145\164 Recipient", value = "||@" .. (tostring(G.recipient or "Unknown") .. "||"), inline = true })
            table.insert(c,
                { name = "\240\159\147\164 Items Sent", value = d.Webhooks.BuildMailItemsText(G.items), inline = false })
        elseif V == "claim" then
            local V = math.max(math.floor(tonumber(G.count) or 0), 0)
            Z = "\240\159\147\165 Incoming Mail Claimed!"
            j = string.format("Successfully claimed **%d** incoming mail%s.", V, V == 1 and "" or "s")
            i = 10181046
            table.insert(c,
                { name = "\240\159\147\172 Claim Type", value = tostring(G.mode or "Unknown"), inline = true })
            table.insert(c, { name = "\226\156\133 Claimed", value = tostring(V), inline = true })
            table.insert(c,
                { name = "\240\159\142\129 Received Items", value = d.Webhooks.BuildClaimedMailText(G.mails), inline = false })
        else
            return nil
        end
        return { username = "Exotic Hub", embeds = { { title = Z, description = j, color = i, fields = c, footer = { text = tostring(y.AppName or "Exotic Hub") .. (" " .. tostring(y.CurentV or "")) }, timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ") } } }
    end,
    IsValidUrl = function(G) return type(G) == "string" and (G ~= "" and G:match("^https?://[^%s]+$") ~= nil) end,
    GetRequestFunction = function()
        local G = _G
        if type(getgenv) == "function" then
            local V, y = pcall(getgenv)
            if V and type(y) == "table" then G = y end
        end
        local V = { "request", "http_request", "httprequest", "httpRequest" }
        for V, y in ipairs(V) do if type(G[y]) == "function" then return G[y] end end
        local y = { "syn", "http", "fluxus", "krnl" }
        for V, y in ipairs(y) do
            local Z = G[y]
            if type(Z) == "table" and type(Z.request) == "function" then return Z.request end
        end
        return nil
    end,
    Queue = function(G, V)
        if not Y.webhook_enabled then return false end
        if type(G) ~= "table" or type(V) ~= "table" then return false end
        table.insert(G, V)
        return true
    end,
    GetPetBuyStyle = function(G, V, y, Z)
        G = tostring(G or "Normal")
        V = tostring(V or "Normal")
        y = tostring(y or "Unknown")
        local j = d.PetFinderPremium.GetPetLabel(G, V, y)
        local i = { title = "\240\159\144\190 You Bought a " .. (j .. "!"), message = "Pet purchase confirmed.", colour =
        Z }
        if V == "Rainbow" and G == "Huge" then
            i.title = "\240\159\140\136 YOU BOUGHT A " .. (string.upper(j) .. " \240\159\145\145!")
            i.message = "Incredible find! A Huge Rainbow pet has been secured!"
            i.colour = 16729559
        elseif V == "Rainbow" and G == "Big" then
            i.title = "\240\159\140\136 You Bought a " .. (j .. " \226\156\168!")
            i.message = "Amazing find! A Big Rainbow pet has been secured!"
            i.colour = 12865023
        elseif G == "Huge" then
            i.title = "\240\159\145\145 YOU BOUGHT A " .. (string.upper(j) .. " \240\159\148\165!")
            i.message = "Massive find! A Huge pet has been secured!"
            i.colour = 16766720
        elseif V == "Rainbow" then
            i.title = "\240\159\140\136 You Bought a " .. (j .. " \226\156\168!")
            i.message = "Lucky find! A Rainbow pet has been secured!"
            i.colour = 16729559
        elseif G == "Big" then
            i.title = "\240\159\148\165 You Bought a " .. (j .. "!")
            i.message = "Great find! A Big pet has been secured!"
            i.colour = 16747586
        end
        return i
    end,
    BuildPetBuyPayload = function(G)
        if type(G) ~= "table" then return nil end
        local V = tostring(G.rarity or "Unknown")
        local Z = d.Data.GetRarityColor(V)
        local j = tonumber(((tostring(Z)):gsub("#", "")), 16) or 5763719
        local i = tostring(G.size or "Normal")
        local J = tostring(G.variant or "Normal")
        local T = tostring(G.display_name or G.pet or "Unknown")
        local u = d.PetFinderPremium.GetPetLabel(i, J, T)
        local q = d.Webhooks.GetPetBuyStyle(i, J, T, j)
        return { username = "Exotic Hub", embeds = { { title = q.title, description = q.message .. ("\n\nBuyer: ||" .. (tostring(G.username or "Unknown") .. "||")), color = q.colour, fields = { { name = "\240\159\144\190 Pet", value = "**" .. (u .. "**"), inline = false }, { name = "\226\173\144 Rarity", value = V, inline = true }, { name = "\240\159\146\176 Price", value = "$" .. c.formatShecklesNumber(G.price), inline = true }, { name = "\240\159\147\143 Size", value = i, inline = true }, { name = "\240\159\140\136 Variant", value = J, inline = true }, { name = "\240\159\146\181 Current Sheckles", value = "$" .. c.formatShecklesNumber(G.sheckles), inline = true } }, footer = { text = tostring(y.AppName or "Exotic Hub") .. (" " .. tostring(y.CurentV or "")) }, timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ") } } }
    end,
    Post = function(G)
        local V = tostring(Y.webhook_url or "")
        if type(G) ~= "table" then return false, "Invalid payload" end
        if not d.Webhooks.IsValidUrl(V) then return false, "Invalid webhook URL" end
        local Z, j = pcall(function() return y.HttpService:JSONEncode(G) end)
        if not Z or type(j) ~= "string" then return false, "JSON encode failed" end
        local i = d.Webhooks.GetRequestFunction()
        if i then
            local G, y = pcall(function()
                return i({
                    Url = V,
                    Method = "POST",
                    Headers = { ["Content-Type"] = "application/json" },
                    Body =
                        j
                })
            end)
            if not G then return false, tostring(y) end
            if type(y) == "table" then
                local G = tonumber(y.StatusCode or y.Status or y.status_code)
                if G then return G >= 200 and G < 300, tostring(G) end
                if y.Success ~= nil then return y.Success == true, tostring(y.StatusMessage or "") end
            end
            return true
        end
        local c, J = pcall(function() y.HttpService:PostAsync(V, j, Enum.HttpContentType.ApplicationJson, false) end)
        if not c then return false, tostring(J) end
        return true
    end,
    GetPendingCount = function()
        local G = 0
        if Y.webhook_pet_buys and type(J.PetFinder_WebhookData) == "table" then G += #J.PetFinder_WebhookData end
        if type(J.Mail_WebhookData) == "table" then for V, y in ipairs(J.Mail_WebhookData) do if type(y) == "table" and d.Webhooks.IsMailTypeEnabled(y.webhookType) then G += 1 end end end
        if Y.webhook_event_seeds and type(J.EventSeed_WebhookData) == "table" then G += #J.EventSeed_WebhookData end
        return G
    end,
    GetNextWebhook = function()
        if Y.webhook_pet_buys and type(J.PetFinder_WebhookData) == "table" then
            while #J.PetFinder_WebhookData > 0 do
                local G = J.PetFinder_WebhookData[1]
                if type(G) ~= "table" then
                    table.remove(J.PetFinder_WebhookData, 1)
                    continue
                end
                local V = d.Webhooks.BuildPetBuyPayload(G)
                if not V then
                    table.remove(J.PetFinder_WebhookData, 1)
                    continue
                end
                return J.PetFinder_WebhookData, 1, V, "pet purchase"
            end
        end
        if Y.webhook_event_seeds and type(J.EventSeed_WebhookData) == "table" then
            while #J.EventSeed_WebhookData > 0 do
                local G = J.EventSeed_WebhookData[1]
                if type(G) ~= "table" then
                    table.remove(J.EventSeed_WebhookData, 1)
                    continue
                end
                local V = d.Webhooks.BuildEventSeedPayload(G)
                if not V then
                    table.remove(J.EventSeed_WebhookData, 1)
                    continue
                end
                return J.EventSeed_WebhookData, 1, V, "event seed"
            end
        end
        if type(J.Mail_WebhookData) ~= "table" then J.Mail_WebhookData = {} end
        while #J.Mail_WebhookData > 0 do
            local G = J.Mail_WebhookData[1]
            if type(G) ~= "table" or not d.Webhooks.IsMailTypeEnabled(G.webhookType) then
                table.remove(J.Mail_WebhookData, 1)
                continue
            end
            local V = d.Webhooks.BuildMailPayload(G)
            if not V then
                table.remove(J.Mail_WebhookData, 1)
                continue
            end
            local y = { manual = "manual order", automatic = "automatic mail", claim = "claimed mail" }
            return J.Mail_WebhookData, 1, V, y[G.webhookType] or "mail notification"
        end
        return nil
    end,
    ProcessNext = function()
        local G = Y.webhook_pet_buys or Y.webhook_event_seeds or Y.webhook_mail_manual or Y.webhook_mail_auto or
            Y.webhook_mail_claims
        if not G then
            d.Webhooks.ClearStatus()
            return false
        end
        local V = d.Webhooks.GetPendingCount()
        if not d.Webhooks.IsValidUrl(Y.webhook_url) then
            if V > 0 then
                d.Webhooks.SetStatus(string.format("Add webhook URL | Pending: %d", V), "#FFCC66")
            else
                d.Webhooks
                    .SetStatus("Add webhook URL", "#FFCC66")
            end
            return false
        end
        if V == 0 then
            d.Webhooks.SetStatus("Ready", "#CFCFCF")
            return false
        end
        local y, Z, j, i = d.Webhooks.GetNextWebhook()
        if not y or not j then
            d.Webhooks.SetStatus("Ready", "#CFCFCF")
            return false
        end
        d.Webhooks.SetStatus(string.format("Sending %s | Pending: %d", i, V), "#66CCFF")
        local c, J = d.Webhooks.Post(j)
        if not c then
            d.Webhooks.SetStatus(string.format("Send failed | Pending: %d", V), "#FF5555")
            warn("[Webhooks]", J)
            return false
        end
        table.remove(y, Z)
        d.Webhooks.SetStatus(string.format("%s sent | Pending: %d", i, d.Webhooks.GetPendingCount()), "#7CFC00")
        return true
    end,
    Loop = function()
        if not Y.webhook_enabled then
            d.Webhooks.ClearStatus()
            return
        end
        local G, V = pcall(function() d.Webhooks.ProcessNext() end)
        if not G then
            d.Webhooks.SetStatus("Webhook loop error", "#FF5555")
            warn("[Webhooks] Loop error:", V)
        end
    end
}
d.Webhooks.StartEventSeedListener()
J.MoonPredictorStatusText = ""
d.MoonPredictor = {
    Started = false,
    DebugBusy = false,
    Label = nil,
    RollMode = "number",
    ValidationText =
    "Waiting for a night to validate",
    Colours = { Moon = "#B7C9FF", Goldmoon = "#FFD700", ["Rainbow Moon"] = "#FF66FF", Bloodmoon = "#FF4444" },
    GetNight = function()
        local G = y.TimeCycleData and (y.TimeCycleData.Data and y.TimeCycleData.Data.Night)
        if type(G) ~= "table" or type(G.Weathers) ~= "table" then return nil end
        return G
    end,
    GetServerTime = function()
        local G, V = pcall(function() return y.Workspace:GetServerTimeNow() end)
        return G and tonumber(V) or os.time()
    end,
    Pick = function(G, V)
        local y = d.MoonPredictor.GetNight()
        if not y then return nil end
        local Z = 0
        for G, V in y.Weathers do if type(V) == "table" then Z += tonumber(V.Chance) or 0 end end
        if Z <= 0 then return nil end
        local j = math.floor(tonumber(G) or 0) * 1000 + 3
        local i = Random.new(j)
        local c = V == "integer" and i:NextInteger(1, math.floor(Z)) or i:NextNumber(0, Z)
        local J = 0
        for G, V in y.Weathers do
            if type(V) ~= "table" then continue end
            J += tonumber(V.Chance) or 0
            if c <= J then return tostring(G), c, j end
        end
        return "Moon", c, j
    end,
    ValidateCurrent = function()
        if tostring(y.Workspace:GetAttribute("ActivePhase") or "") ~= "Night" then return false end
        local G = tostring(y.Workspace:GetAttribute("ActiveWeather") or "")
        local V = d.MoonPredictor.GetNight()
        if not V or type(V.Weathers[G]) ~= "table" then return false end
        local Z = math.floor(os.time() / 600)
        local j = d.MoonPredictor.Pick(Z, "number")
        local i = d.MoonPredictor.Pick(Z, "integer")
        if j == G and i ~= G then
            d.MoonPredictor.RollMode = "number"
            d.MoonPredictor.ValidationText = "NextNumber confirmed by live moon"
            return true
        end
        if i == G and j ~= G then
            d.MoonPredictor.RollMode = "integer"
            d.MoonPredictor.ValidationText = "NextInteger confirmed by live moon"
            return true
        end
        if j == G and i == G then
            d.MoonPredictor.ValidationText = "Both methods match the live moon"
            return true
        end
        d.MoonPredictor.ValidationText = "Live moon differs; it may be forced"
        return false
    end,
    GetNextNightAt = function()
        local G = d.MoonPredictor.GetServerTime()
        local V = tostring(y.Workspace:GetAttribute("ActivePhase") or "")
        local Z = tonumber(y.Workspace:GetAttribute("PhaseDuration"))
        local j = y.TimeCycleData and y.TimeCycleData.Data
        local i = j and (j.Day and tonumber(j.Day.Lasts)) or 450
        local c = j and (j.Sunset and tonumber(j.Sunset.Lasts)) or 30
        if Z then
            if V == "Night" then
                return (Z + i) + c
            elseif V == "Day" then
                return Z + c
            elseif V == "Sunset" then
                return
                    Z
            end
        end
        local J = math.floor(G / 600) * 600
        local T = (J + i) + c
        return G < T and T or T + 600
    end,
    GetRare = function(G, V)
        G = math.clamp(math.floor(tonumber(G) or 1), 1, 20)
        V = V == "integer" and "integer" or "number"
        local y = d.MoonPredictor.GetNextNightAt()
        local Z = math.floor(y / 600)
        local j = {}
        for i = 0, 999, 1 do
            local c, J, T = d.MoonPredictor.Pick(Z + i, V)
            if c and c ~= "Moon" then
                table.insert(j, { Name = c, At = y + i * 600, Roll = J, Seed = T })
                if #j >= G then break end
            end
        end
        return j
    end,
    FormatTime = function(G)
        G = math.max(math.floor(tonumber(G) or 0), 0)
        local V = math.floor(G / 3600)
        local y = math.floor(((G % 3600)) / 60)
        local Z = G % 60
        if V > 0 then return string.format("%dh %02dm", V, y) end
        if y > 0 then return string.format("%dm %02ds", y, Z) end
        return string.format("%ds", Z)
    end,
    GetLines = function(G, V, y)
        local Z = d.MoonPredictor.GetServerTime()
        local j = {}
        for G, V in ipairs(d.MoonPredictor.GetRare(V, G)) do
            if y then
                table.insert(j,
                    string.format("%d. **%s** \226\128\148 <t:%d:R> (`%d`)", G, V.Name, math.floor(V.At), V.Seed))
            else
                local G = d.MoonPredictor.Colours[V.Name] or "#FFFFFF"
                table.insert(j,
                    string.format("<font color=\'%s\'>%s</font> <font color=\'#7CFC00\'>in %s</font>", G, V.Name,
                        d.MoonPredictor.FormatTime(V.At - Z)))
            end
        end
        return j
    end,
    Update = function()
        if not Y.moon_predictor_enabled then
            J.MoonPredictorStatusText = ""
            if d.MoonPredictor.Label and type(d.MoonPredictor.Label.SetText) == "function" then
                d.MoonPredictor.Label
                    :SetText("<font color=\'#AFAFAF\'>Moon predictor disabled.</font>")
            end
            return
        end
        d.MoonPredictor.ValidateCurrent()
        local G = d.MoonPredictor.GetServerTime()
        local V = tostring(y.Workspace:GetAttribute("ActivePhase") or "Unknown")
        local Z = tostring(y.Workspace:GetAttribute("ActiveWeather") or "Unknown")
        local j = tonumber(y.Workspace:GetAttribute("PhaseDuration")) or G
        local i = {}
        if V == "Night" then
            table.insert(i,
                string.format("<b>Current:</b> <font color=\'%s\'>%s</font> <font color=\'#AFAFAF\'>(%s left)</font>",
                    d.MoonPredictor.Colours[Z] or "#FFFFFF", Z, d.MoonPredictor.FormatTime(j - G)))
        else
            table.insert(i,
                string.format("<b>Next Night:</b> <font color=\'#B7C9FF\'>in %s</font>",
                    d.MoonPredictor.FormatTime(d.MoonPredictor.GetNextNightAt() - G)))
        end
        table.insert(i, "<font color=\'#AFAFAF\'>Upcoming rare moons:</font>")
        for G, V in ipairs(d.MoonPredictor.GetLines(d.MoonPredictor.RollMode, 8, false)) do table.insert(i, V) end
        if d.MoonPredictor.Label and type(d.MoonPredictor.Label.SetText) == "function" then
            d.MoonPredictor.Label:SetText(
                table.concat(i, "\n"))
        end
        local c = (d.MoonPredictor.GetRare(1, d.MoonPredictor.RollMode))[1]
        if not c then
            J.MoonPredictorStatusText = ""
            return
        end
        J.MoonPredictorStatusText = string.format(
            "<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\140\153 [Moon]</font> <font color=\'%s\'>%s in %s</font></stroke>",
            d.MoonPredictor.Colours[c.Name] or "#FFFFFF", c.Name, d.MoonPredictor.FormatTime(c.At - G))
    end,
    SendDebugPost = function()
        if d.MoonPredictor.DebugBusy then return false, "Debug post already running" end
        if not Y.webhook_enabled or not d.Webhooks.IsValidUrl(Y.webhook_url) then
            return false,
                "Add and enable your webhook first"
        end
        d.MoonPredictor.DebugBusy = true
        d.MoonPredictor.ValidateCurrent()
        local G = math.floor(os.time() / 600)
        local V, Z, j = d.MoonPredictor.Pick(G, "number")
        local i, c, J = d.MoonPredictor.Pick(G, "integer")
        local T = table.concat(d.MoonPredictor.GetLines("number", 12, true), "\n")
        local u = table.concat(d.MoonPredictor.GetLines("integer", 12, true), "\n")
        local q = { username = "Exotic Hub", embeds = { { title = "\240\159\140\153 Moon Predictor Debug", description = string.format("Live: **%s / %s**\nNext Night: <t:%d:R>\nSelected: **%s**\nValidation: %s", tostring(y.Workspace:GetAttribute("ActivePhase") or "Unknown"), tostring(y.Workspace:GetAttribute("ActiveWeather") or "Unknown"), math.floor(d.MoonPredictor.GetNextNightAt()), d.MoonPredictor.RollMode, d.MoonPredictor.ValidationText), color = 9268223, fields = { { name = "NextNumber", value = T ~= "" and T or "No predictions", inline = false }, { name = "NextInteger", value = u ~= "" and u or "No predictions", inline = false }, { name = "Current cycle", value = string.format("Cycle `%d`\nNumber `%s` roll `%.6f` seed `%d`\nInteger `%s` roll `%s` seed `%d`", G, tostring(V), tonumber(Z) or 0, tonumber(j) or 0, tostring(i), tostring(c), tonumber(J) or 0), inline = false } }, footer = { text = tostring(y.AppName or "Exotic Hub") .. (" " .. tostring(y.CurentV or "")) }, timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ") } } }
        local g, E = d.Webhooks.Post(q)
        d.MoonPredictor.DebugBusy = false
        warn("[Moon Predictor][NextNumber]\n" .. T)
        warn("[Moon Predictor][NextInteger]\n" .. u)
        return g, g and "Moon debug post sent" or tostring(E or "Debug post failed")
    end,
    Start = function()
        if d.MoonPredictor.Started then return end
        d.MoonPredictor.Started = true
        task.spawn(function()
            while d.MoonPredictor.Started do
                local G, V = pcall(d.MoonPredictor.Update)
                if not G then
                    J.MoonPredictorStatusText = ""
                    warn("[Moon Predictor]", V)
                end
                task.wait(1)
            end
        end)
    end
}
d.MoonPredictionApi = {
    Url = "https://exotichub.app/gag2predict",
    Busy = false,
    Started = false,
    Debug = false,
    Interval = 30,
    PredictionCount = 20,
    LastSignature =
    "",
    GetMoonPredictionIconId = function(G)
        local V = d.MoonPredictor.GetNight()
        local y = V and (V.Weathers and V.Weathers[tostring(G or "")]) or nil
        local Z = type(y) == "table" and tostring(y.Image or "") or ""
        return Z:match("%d+") or "0"
    end,
    GetMoonPredictionIcons = function()
        local G = d.MoonPredictor.GetNight()
        local V = {}
        if not G or type(G.Weathers) ~= "table" then return V end
        for G, y in G.Weathers do
            local Z = type(y) == "table" and tostring(y.Image or "") or ""
            V[tostring(G)] = Z:match("%d+") or "0"
        end
        return V
    end,
    GetMoonPredictionEvents = function()
        local G = d.MoonPredictor.GetRare(d.MoonPredictionApi.PredictionCount, d.MoonPredictor.RollMode)
        if type(G) ~= "table" then return nil end
        local V = {}
        for G, y in ipairs(G) do
            local Z = tostring(y.Name or "")
            local j = math.floor(tonumber(y.At) or 0)
            if Z == "" or j <= 0 then continue end
            table.insert(V,
                {
                    name = Z,
                    starts_at = j,
                    cycle = math.floor(j / 600),
                    icon_id = d.MoonPredictionApi
                        .GetMoonPredictionIconId(Z)
                })
        end
        return V
    end,
    BuildMoonPredictionPayload = function()
        local G = y.LocalPlayer
        local V = d.MoonPredictionApi.GetMoonPredictionEvents()
        if not G or not G.UserId or type(V) ~= "table" then return nil end
        local Z = math.floor(d.MoonPredictor.GetServerTime())
        local j = tostring(y.Workspace:GetAttribute("ActivePhase") or "Unknown")
        local i = tostring(y.Workspace:GetAttribute("ActiveWeather") or "Unknown")
        local c = math.floor(tonumber(y.Workspace:GetAttribute("PhaseDuration")) or 0)
        return {
            version = 1,
            game = "gag2",
            generated_at = Z,
            source = { user_id = tostring(G.UserId), job_id = tostring(game.JobId or ""), place_version = tonumber(game.PlaceVersion) or 0 },
            phase = { name = j, weather = i, ends_at = c, icon_id = j == "Night" and d.MoonPredictionApi.GetMoonPredictionIconId(i) or "0" },
            next_night_at =
                math.floor(d.MoonPredictor.GetNextNightAt()),
            icons = d.MoonPredictionApi.GetMoonPredictionIcons(),
            predictions = V
        }
    end,
    BuildMoonPredictionSignature = function(G)
        if type(G) ~= "table" or type(G.phase) ~= "table" or type(G.predictions) ~= "table" then return nil end
        local V = { tostring(G.phase.name or ""), tostring(G.phase.weather or ""), tostring(G.phase.ends_at or 0),
            tostring(
                G.next_night_at or 0) }
        for G, y in ipairs(G.predictions) do
            table.insert(V,
                table.concat({ tostring(y.name or ""), tostring(y.starts_at or 0), tostring(y.icon_id or "0") }, "\031"))
        end
        return table.concat(V, "\030")
    end,
    SendMoonPredictionApi = function()
        if d.MoonPredictionApi.Busy then return false end
        local G = d.MoonPredictionApi.BuildMoonPredictionPayload()
        local V = d.MoonPredictionApi.BuildMoonPredictionSignature(G)
        if type(G) ~= "table" or type(V) ~= "string" or V == "" then return false end
        if V == d.MoonPredictionApi.LastSignature then return false end
        d.MoonPredictionApi.Busy = true
        local Z, j, i, c, J = pcall(function() return g.Http.PostJson(d.MoonPredictionApi.Url, G) end)
        d.MoonPredictionApi.Busy = false
        if not Z then
            if d.MoonPredictionApi.Debug then warn("[MoonPredictionApi] Request crashed:", j) end
            return false
        end
        if not j then
            if d.MoonPredictionApi.Debug then warn("[MoonPredictionApi] Request failed:", tostring(J or i)) end
            return false
        end
        d.MoonPredictionApi.LastSignature = V
        if d.MoonPredictionApi.Debug then
            print("[MoonPredictionApi] Status:", i)
            print("[MoonPredictionApi] Response:", tostring(c or ""))
            print("[MoonPredictionApi] Payload:", y.HttpService:JSONEncode(G))
        end
        return true
    end,
    LoopMoonPredictionApi = function()
        local G, V = pcall(d.MoonPredictionApi.SendMoonPredictionApi)
        if not G and d.MoonPredictionApi.Debug then warn("[MoonPredictionApi] Loop error:", V) end
    end,
    StartMoonPredictionApi = function()
        if d.MoonPredictionApi.Started then return false end
        d.MoonPredictionApi.Started = true
        task.spawn(function()
            task.wait(5)
            while d.MoonPredictionApi.Started do
                d.MoonPredictionApi.LoopMoonPredictionApi()
                task.wait(d.MoonPredictionApi.Interval)
            end
        end)
        return true
    end
}
d.MoonPredictionApi.StartMoonPredictionApi()
d.LiveMapPetsApi = {
    Url = "https://exotichub.app/gag2livepets",
    Busy = false,
    Started = false,
    Interval = 7,
    LastSignature = nil,
    GetIconId = function(
        G)
        local V = type(y.PetData) == "table" and y.PetData[G] or nil
        local Z = type(V) == "table" and tostring(V.Image or "") or ""
        return Z:match("%d+") or "0"
    end,
    GetPets = function()
        local G = d.PetFinderPremium.GetFolder()
        if not G then return nil end
        local V = d.PetFinderPremium.GetServerTime()
        local y = {}
        local Z = {}
        local j = {}
        for G, Z in ipairs(G:GetChildren()) do
            local i = d.PetFinderPremium.GetPetData(Z)
            if not i or i.ownerId ~= 0 or d.PetFinderPremium.IsExpired(i) then continue end
            local c = tostring(i.name or "")
            local J = tostring(i.size or "Normal")
            local T = tostring(i.variant or "Normal")
            local u = tostring(i.rarity or "Unknown")
            local q = d.LiveMapPetsApi.GetIconId(i.name)
            local g = math.floor(tonumber(i.expiresAt) or 0)
            local E = math.max(math.floor(g - V), 0)
            if c == "" or E <= 0 then continue end
            table.insert(j, table.concat({ c, J, T, u, q, tostring(g) }, "\031"))
            local a = table.concat({ c, J, T }, "\031")
            if not y[a] then y[a] = { n = c, s = J, v = T, r = u, i = q, a = 0, t = E } end
            y[a].a += 1
            y[a].t = math.max(y[a].t, E)
            if y[a].i == "0" and q ~= "0" then y[a].i = q end
        end
        for G, V in pairs(y) do table.insert(Z, V) end
        table.sort(Z, function(G, V)
            if G.n ~= V.n then return G.n < V.n end
            if G.s ~= V.s then return G.s < V.s end
            return G.v < V.v
        end)
        table.sort(j)
        return Z, table.concat(j, "\030")
    end,
    Send = function()
        if d.LiveMapPetsApi.Busy then return false end
        local G = false
        local V = y.LocalPlayer
        local Z = tostring(game.JobId or "")
        local j, i = d.LiveMapPetsApi.GetPets()
        if not V or not V.UserId or Z == "" or type(j) ~= "table" or type(i) ~= "string" then return false end
        local c = table.concat({ Z, tostring(game.PlaceVersion or 0), i }, "\029")
        if c == d.LiveMapPetsApi.LastSignature then return false end
        d.LiveMapPetsApi.Busy = true
        local J = { j = Z, u = tostring(V.UserId), pv = tonumber(game.PlaceVersion) or 0, p = j }
        local T, u, q, E, a = pcall(function() return g.Http.PostJson(d.LiveMapPetsApi.Url, J) end)
        d.LiveMapPetsApi.Busy = false
        if not T then
            if G then warn("[LiveMapPetsApi] Request crashed:", u) end
            if G then warn("[LiveMapPetsApi] Request crashed:", u) end
            return false
        end
        if G then
            print("[LiveMapPetsApi] Status:", q)
            print("[LiveMapPetsApi] Response:", tostring(E or ""))
        end
        if not u then
            if G then warn("[LiveMapPetsApi] Request failed:", tostring(a or "Unknown error")) end
            return false
        end
        d.LiveMapPetsApi.LastSignature = c
        return true
    end,
    Start = function()
        if d.LiveMapPetsApi.Started then return end
        d.LiveMapPetsApi.Started = true
        task.spawn(function()
            task.wait(5)
            while d.LiveMapPetsApi.Started do
                pcall(d.LiveMapPetsApi.Send)
                task.wait(d.LiveMapPetsApi.Interval)
            end
        end)
    end
}
d.GardenItems = {
    Busy = false,
    AlreadyRunningPetPlayer = false,
    PetSeedCollectSystem = {
        IsOurSeed = function(G)
            if not G or G.Parent ~= y.DroppedItems then return false end
            if G:GetAttribute("ItemCategory") ~= "Seeds" then return false end
            return tonumber(G:GetAttribute("DroppedBy")) == tonumber(J.player_userid)
        end,
        Claim = function(G)
            if not Y.auto_collect_drop_seeds or d.GardenItems.Busy or not d.GardenItems.PetSeedCollectSystem.IsOurSeed(G) then return false end
            local V = d.ProximityPrompt.FindProximityPromptByClass(G)
            if not V or not V.Enabled then return false end
            d.GardenItems.Busy = true
            local y = J.TeleportLockNames.GardenItemCollector
            local Z = d.Teleport.LockTeleport(y, 2, false)
            if not Z then
                d.GardenItems.Busy = false
                return false
            end
            local j, i = pcall(function()
                if not d.Teleport.TeleportTo(G, true, y) then return false end
                task.wait(.1)
                if not V.Parent or not d.GardenItems.PetSeedCollectSystem.IsOurSeed(G) then return false end
                d.ProximityPrompt.ActivateProximityPrompt(V)
                return true
            end)
            d.Teleport.UnlockTeleport(y)
            d.GardenItems.Busy = false
            return j and i == true
        end
    },
    StartSeedCollectorPetsAndPlayer = function()
        if d.GardenItems.AlreadyRunningPetPlayer then return end
        d.GardenItems.AlreadyRunningPetPlayer = true
        y.DroppedItems.ChildAdded:Connect(function(G) d.GardenItems.PetSeedCollectSystem.Claim(G) end)
        task.spawn(function()
            while true do
                task.wait(5)
                if Y.auto_collect_drop_seeds then
                    for G, V in ipairs(y.DroppedItems:GetChildren()) do
                        if d.GardenItems.PetSeedCollectSystem.Claim(V) then
                            task.wait(.5)
                        end
                    end
                end
            end
        end)
    end
}
d.GardenItems.StartSeedCollectorPetsAndPlayer()
J.GardenExpandStatusText = ""
d.GardenItems.ExpandSystem = {
    Busy = false,
    Started = false,
    SetStatus = function(G, V)
        J.GardenExpandStatusText =
            string.format(
                "<stroke color=\'#000000\' thickness=\'1\'><font color=\'%s\'>\240\159\143\161 Garden Expansion:</font> <font color=\'#FFFFFF\'>%s</font></stroke>",
                tostring(V or "#FFFFFF"), tostring(G or ""))
    end,
    GetCurrentSlot = function()
        local G = tonumber(d.DataReplica.GetData("OwnedExpansions", 1)) or 1
        return math.max(math.floor(G), 1)
    end,
    GetMaximumSlot = function()
        if type(y.ExpansionPrices) ~= "table" then return 1 end
        return math.max(#y.ExpansionPrices, 1)
    end,
    GetPrice = function(G)
        G = tonumber(G)
        if not G or type(y.ExpansionPrices) ~= "table" then return nil end
        local V = y.ExpansionPrices[G]
        local Z = type(V) == "table" and tonumber(V.Price) or nil
        local j = y.GardenFlags and y.GardenFlags.ExpansionPriceOverrides
        if j and type(j.Get) == "function" then
            local V, y = pcall(function() return j:Get() end)
            if V and type(y) == "table" then Z = tonumber(y[tostring(G)]) or Z end
        end
        return Z
    end,
    Loop = function()
        local G = d.GardenItems.ExpandSystem
        if not Y.auto_expand_garden then
            J.GardenExpandStatusText = ""
            return false
        end
        if G.Busy then return false end
        local V = G.GetMaximumSlot()
        local Z = math.clamp(math.floor(tonumber(Y.auto_expand_garden_max_slot) or 2), 1, V)
        local j = G.GetCurrentSlot()
        if j >= Z then
            G.SetStatus(string.format("Slot %d/%d reached", j, Z), "#66FF99")
            return false
        end
        local i = j + 1
        local T = G.GetPrice(i)
        if not T then
            G.SetStatus("Expansion price unavailable", "#FF5555")
            return false
        end
        local u = tonumber(d.Money.GetSheckles()) or 0
        if u < T then
            G.SetStatus(string.format("Slot %d/%d \226\128\162 Next $%s", j, Z, c.formatShecklesNumber(T)), "#FFCC66")
            return false
        end
        local q = y.Networking and (y.Networking.Actions and y.Networking.Actions.ExpandGarden)
        if not q or type(q.Fire) ~= "function" then
            G.SetStatus("Expansion remote unavailable", "#FF5555")
            return false
        end
        G.Busy = true
        G.SetStatus(string.format("Buying slot %d...", i), "#66CCFF")
        local g, E = pcall(function() return q:Fire() end)
        if not g or E == false then
            G.Busy = false
            G.SetStatus("Purchase failed", "#FF5555")
            return false
        end
        local a = os.clock()
        repeat task.wait(.1) until G.GetCurrentSlot() > j or os.clock() - a >= 3
        local H = G.GetCurrentSlot()
        G.Busy = false
        if H > j then
            G.SetStatus(string.format("Expanded to slot %d/%d", H, Z), "#66FF99")
            return true
        end
        G.SetStatus("Purchase not confirmed", "#FFCC66")
        return false
    end,
    Start = function()
        local G = d.GardenItems.ExpandSystem
        if G.Started then return false end
        G.Started = true
        task.spawn(function()
            while G.Started do
                task.wait(1)
                G.Loop()
            end
        end)
        return true
    end
}
d.GardenItems.ExpandSystem.Start()
d.GardenItems.EventSeedCollectSystem = {
    Busy = false,
    Started = false,
    CurrentItem = nil,
    RetryAt = setmetatable({},
        { __mode = "k" }),
    Claim_old = function(G)
        if not Y.auto_collect_event_seeds then return false end
        if not G or not G.Parent then return false end
        local V = d.ProximityPrompt.FindProximityPromptByClass(G)
        if not V then return false end
        local y = J.TeleportLockNames.SeedPackCollector
        d.Teleport.LockTeleport(y, 5, true)
        local Z, j = pcall(function()
            if not d.Teleport.TeleportTo(G, true, y) then return false end
            task.wait(1)
            if not V.Parent then return false end
            for G = 1, 2, 1 do d.ProximityPrompt.ActivateProximityPrompt(V) end
            d.Teleport.LockTeleport(y, 5, true)
            task.wait(1)
            return true
        end)
        return Z and j == true
    end,
    Claim = function(G)
        local V = d.GardenItems.EventSeedCollectSystem
        if not Y.auto_collect_event_seeds or V.Busy or d.StepTeleport.Busy or not G or G.Parent ~= y.EventSeedDrops or os.clock() < ((V.RetryAt[G] or 0)) then return false end
        local Z = d.ProximityPrompt.FindProximityPromptByClass(G)
        if not Z or not Z.Enabled then
            V.RetryAt[G] = os.clock() + .25
            return false
        end
        V.Busy = true
        V.CurrentItem = G
        local j = J.TeleportLockNames.SeedPackCollector
        if not d.Teleport.LockTeleport(j, 60, true) then
            V.CurrentItem = nil
            V.Busy = false
            return false
        end
        local i, c = pcall(function()
            local V = d.StepTeleport.GetCFrame(G)
            local i = V and ((V + Vector3.new(5, 0, 0))).Position
            local c = i and d.StepTeleport.FindGroundPosition(G, i)
            if not c or not d.StepTeleport.ToCFrame(CFrame.new(c), j) then return false end
            if not Y.auto_collect_event_seeds or G.Parent ~= y.EventSeedDrops or not Z.Parent then return false end
            if not d.Teleport.TeleportTo(G, true, j) then return false end
            for V = 1, 2, 1 do
                if G.Parent ~= y.EventSeedDrops or not Z.Parent then return true end
                d.ProximityPrompt.ActivateProximityPrompt(Z)
                task.wait(.1)
            end
            return true
        end)
        if i and c then
            V.RetryAt[G] = os.clock() + 3
            d.Teleport.LockTeleport(j, 5, true)
        else
            V.RetryAt[G] = os.clock() + 1
            d.Teleport.UnlockTeleport(j)
        end
        V.CurrentItem = nil
        V.Busy = false
        if not i then
            warn("[Event Seed Collector]", c)
            return false
        end
        return c == true
    end,
    StartGoldRainbowCollect = function()
        local G = d.GardenItems.EventSeedCollectSystem
        if G.Started then return false end
        G.Started = true
        y.EventSeedDrops.ChildAdded:Connect(function(V) task.defer(function() G.Claim(V) end) end)
        task.spawn(function()
            while G.Started do
                task.wait(.5)
                if not Y.auto_collect_event_seeds or G.Busy then continue end
                for V, y in ipairs(y.EventSeedDrops:GetChildren()) do if G.Claim(y) then task.wait(.5) end end
            end
        end)
        return true
    end
}
d.GardenItems.EventSeedCollectSystem.StartGoldRainbowCollect()
a.RealTimeStats = {
    statusLabel = nil,
    updateStatusList = function(G)
        local V = 18
        local Z = 14
        local j = 1000
        local i = V
        local c = workspace.CurrentCamera
        if c then if c.ViewportSize.X < j then i = Z end end
        local J = a.RealTimeStats
        local T = J.statusLabel
        if not T or not T.Parent then
            local G = y.LocalPlayer
            if not G then return end
            local V = y.PlayerGui
            local Z = V:FindFirstChild("StatusGui")
            if not Z then
                Z = Instance.new("ScreenGui")
                Z.Name = "StatusGui"
                Z.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
                Z.ResetOnSpawn = false
                Z.Parent = V
                Z.DisplayOrder = 3
            end
            T = Z:FindFirstChild("StatusDisplay")
            if not T then
                T = Instance.new("TextLabel")
                T.Name = "StatusDisplay"
                T.Parent = Z
                T.Size = UDim2.new(.3, 0, .4, 0)
                T.AnchorPoint = Vector2.new(0, .5)
                T.Position = UDim2.new(0, 120, .65, 0)
                T.BackgroundTransparency = 1
                T.RichText = true
                T.Font = Enum.Font.SourceSansBold
                T.TextColor3 = Color3.new(1, 1, 1)
                T.TextStrokeTransparency = .5
                T.TextXAlignment = Enum.TextXAlignment.Left
                T.TextYAlignment = Enum.TextYAlignment.Top
            end
            J.statusLabel = T
        end
        if T then
            T.TextSize = i
            local V = table.concat(G, "\n")
            T.Text = V
        end
    end
}
c.SafeParent = function(G, V, y)
    if typeof(G) ~= "Instance" or typeof(V) ~= "Instance" or G.Parent == nil or V.Parent == nil then return false end
    local Z = false
    local j = pcall(function()
        if y and G.Parent ~= y then return end
        G.Parent = V
        Z = true
    end)
    return j and Z
end
c.ParentOutsidex = function(G, V) return true end
c.ParentOutside = function(G, V)
    if G:GetAttribute("emove") then return end
    if G:IsA("Model") then
        local V = G:GetPivot()
        local y = 1000000
        local Z = 1000000
        G:SetAttribute("emove", true)
        local j = CFrame.new(y, V.Position.Y, Z) * V.Rotation
        G:PivotTo(j)
    elseif G:IsA("BasePart") then
        local V = G.CFrame
        local y = 1000000
        local Z = 1000000
        G:SetAttribute("emove", true)
        G.CFrame = CFrame.new(y, V.Position.Y, Z) * V.Rotation
    end
    return true
end
task.spawn(function()
    while true do
        task.wait(2)
        if not Y.hide_plant_models then continue end
        local G, V = pcall(function()
            local G = d.Farm.GetMyPlantsFolder()
            if G and G.Parent then
                local V = G:GetChildren()
                for V, y in ipairs(V) do
                    if not Y.hide_plant_models then break end
                    c.ParentOutside(y, G)
                    if V % 50 == 0 then task.wait() end
                end
            end
            for G, V in ipairs(d.Farm.GetMyPlantsFoldersNotMine()) do
                if not Y.hide_plant_models then break end
                if not V or not V.Parent then continue end
                local Z = V:FindFirstChild("Plants")
                if Z then c.SafeParent(Z, y.ReplicatedFirst, V) end
            end
        end)
        if not G then
            warn("[PlantPerformance] Loop error:", V)
            task.wait(1)
        end
    end
end)
task.spawn(function()
    pcall(function()
        if Y.char_farm_middle then
            local G = d.Farm.GetCenterPointPart()
            if G then
                d.Teleport.LockTeleport(J.TeleportLockNames.Other, 2)
                d.Teleport.TeleportTo(d.Farm.GetCenterPointPart(), true, J.TeleportLockNames.Other)
                print("Teleport middle")
            else
                print("center not found")
            end
        end
    end)
end)
J.GetProLabel = function()
    local G = "\240\159\148\146<font color=\'#FF0000\'>PRO</font>"
    if J.GetCheckIfPro() then G = "" end
    return G
end
J.HomeDashboardUi = function()
    local G = T.SERVER.GetServerVersion()
    local V = j:AddTab({
        Name = "<font color=\"#FFFFFF\">Config & </font><font color=\"#00A2FF\">Home</font>",
        Description =
            "<font color=\"#B4B4B4\">Game Server Version: </font><font color=\"#FFD700\"><b>" .. (G .. "</b></font>"),
        Icon =
        "house"
    })
    local y = V:AddLeftGroupbox("Actions", "calendar-sync")
    local Z = V:AddRightGroupbox("Moon Predictor", "moon-star")
    local i = V:AddRightGroupbox("Farm Details", "sprout", false)
    local q = V:AddLeftGroupbox("<font color=\"#FFFFFF\">Multi Account </font><font color=\"#00A2FF\">Config</font>",
        "copy", false)
    local g = V:AddLeftGroupbox("<font color=\"#FFFFFF\">Website </font><font color=\"#00A2FF\">Sync</font>", "cloud-cog")
    if Z then
        d.MoonPredictor.Label = Z:AddLabel({ Text = "<font color=\'#AFAFAF\'>Loading moon predictions...</font>", DoesWrap = true })
        Z:AddToggle("moon_predictor_enabled_ui",
            {
                Text = "Enable Moon Predictor",
                Default = Y.moon_predictor_enabled,
                Tooltip =
                "Shows upcoming Goldmoon, Rainbow Moon and Bloodmoon events.",
                Callback = function(G)
                    Y.moon_predictor_enabled = G
                    u.Save.SaveDataSync()
                    d.MoonPredictor.Update()
                end
            })
    end
    if i then
        d.FarmDetails.Label = i:AddLabel({ Text = "<font color=\'#AFAFAF\'>Loading farm details...</font>", DoesWrap = true })
        i:AddButton({ Text = "Refresh Farm Details", Func = function() d.FarmDetails.Update() end })
        d.FarmDetails.Start()
    end
    if g then
        g:AddLabel({
            Text =
            "<font color=\'#66CCFF\'><b>Connect to Exotic Hub</b></font>\nEnter your Web API key and link this account.",
            DoesWrap = true
        })
        local G = g:AddLabel({
            Text = tostring(Y.web_api_key or "") ~= "" and
                "<font color=\'#FFCC66\'>\226\151\143 API key saved \226\128\148 ready to link</font>" or
                "<font color=\'#AFAFAF\'>\226\151\143 Not connected</font>",
            DoesWrap = true
        })
        local function V(V) if G and type(G.SetText) == "function" then G:SetText(V) end end
        g:AddInput("gag2_web_api_key",
            {
                Text = "\240\159\148\145 Web API Key",
                Default = Y.web_api_key,
                Numeric = false,
                AllowEmpty = true,
                Finished = false,
                ClearTextOnFocus = false,
                Placeholder =
                "Enter API key",
                Tooltip = "Get your API key from the Exotic Hub website.",
                Callback = function(G)
                    Y.web_api_key = (tostring(G or "")):match("^%s*(.-)%s*$")
                    u.Save.SaveData()
                    if Y.web_api_key == "" then
                        V("<font color=\'#AFAFAF\'>\226\151\143 Not connected</font>")
                    else
                        V(
                            "<font color=\'#FFCC66\'>\226\151\143 API key saved \226\128\148 ready to link</font>")
                    end
                end
            })
        g:AddDivider()
        g:AddButton({
            Text = "\240\159\148\151 Link This Account",
            Func = function()
                if d.WebApi.Busy then
                    J.Notify("Link request already running", 3)
                    return
                end
                V("<font color=\'#66CCFF\'>\226\151\143 Linking account...</font>")
                task.spawn(function()
                    local G, y = d.WebApi.LinkDevice()
                    if G then
                        V("<font color=\'#7CFC00\'>\226\151\143 Account successfully linked</font>")
                    else
                        V(
                            "<font color=\'#FF6666\'>\226\151\143 " .. (tostring(y) .. "</font>"))
                    end
                    J.Notify(y, 5)
                end)
            end
        })
    end
    if q then
        q:AddButton({
            Text = "Copy Config",
            Func = function()
                local G = u.Config.BuildCopyText()
                if not G then
                    J.Notify("Failed to create config", 3)
                    return
                end
                c.CopyToClipBoard(G)
                J.Notify("Config copied. Add it above the loader.", 3)
            end
        })
        q:AddButton({
            Text = "\240\159\159\162 Copy Config With Loader",
            Func = function()
                local G = u.Config.BuildCopyWithLoaderText()
                if not G then
                    J.Notify("Failed to create config", 3)
                    return
                end
                c.CopyToClipBoard(G)
                J.Notify("Config copied. Add and enter your key.", 3)
            end
        })
    end
    local E = y:AddButton({ Text = "\240\159\154\168 Rejoin Server", Func = function() d.Player.Rejoin() end })
    local a = y:AddButton({ Text = "\240\159\147\161 Hop Server", Func = function() H.Hop.HopToNewServer() end })
    y:AddDivider()
    y:AddToggle("automiddletp",
        {
            Text = "\240\159\147\141 Spawn Middle",
            Default = Y.char_farm_middle,
            Tooltip =
            "Place your character in the centre of the farm when you join.",
            Callback = function(G)
                Y.char_farm_middle = G
                u.Save.SaveDataSync()
            end
        })
end
J.MailUi = function()
    local G = j:AddTab({ Name = "Mail " .. J.GetProLabel(), Description = "Send and receive items", Icon = "mail" })
    local V = G:AddLeftGroupbox("Manual Order", "send")
    local y = G:AddRightGroupbox("Automatic Send", "repeat-2")
    local Z = G:AddLeftGroupbox("Receipts", "receipt-text")
    local i = G:AddRightGroupbox("Incoming Mail", "mail-open")
    if V then
        local G = "Seeds"
        local y = ""
        local Z = 1
        local j
        local i
        local c
        local T
        local q
        V:AddLabel({ Text = "Enter the exact Roblox username. @ is optional.", DoesWrap = true })
        V:AddInput("mail_manual_username_ui",
            {
                Text = "\240\159\145\164 Recipient Username",
                Default = J.MailDraftTargetUsername,
                Numeric = false,
                AllowEmpty = true,
                Finished = true,
                ClearTextOnFocus = false,
                Placeholder =
                "Roblox username",
                Callback = function(G) J.MailDraftTargetUsername = d.Mail.CleanUsername(G) end
            })
        V:AddButton({
            Text = "\240\159\148\142 Check Recipient",
            Func = function()
                local G, V = d.Mail.LookupRecipient(J.MailDraftTargetUsername)
                if not G then
                    J.Notify(V, 3)
                    d.Mail.SetStatus(V, "#FF5555")
                    return
                end
                J.Notify(string.format("Found @%s (%s)", G.username, G.displayName), 4)
                d.Mail.SetStatus(string.format("Recipient ready: @%s", G.username), "#7CFC00")
            end
        })
        V:AddToggle("mail_include_comment_ui",
            {
                Text = "\240\159\146\172 Include Order Comment",
                Default = Y.mail_include_comment,
                Tooltip =
                "Adds the order ID and progress to each mail.",
                Callback = function(G)
                    Y.mail_include_comment = G
                    u.Save.SaveDataSync()
                end
            })
        T = V:AddToggle("mail_ignore_batch_limit_ui",
            {
                Text = "\240\159\147\166 Ignore 20 Item Limit",
                Default = Y.mail_ignore_batch_limit,
                Tooltip =
                "Sends the full amount in one mail. Applies to manual and automatic sending.",
                DisabledTooltip = J
                    .GetProMessage(),
                Callback = function(G)
                    Y.mail_ignore_batch_limit = G
                    u.Save.SaveDataSync()
                end
            })
        q = V:AddToggle("mail_manual_batch_together_ui",
            {
                Text = "\240\159\147\166 Combine Order Items",
                Default = Y.mail_manual_batch_together,
                Tooltip =
                "Combines different order items into the same mail when possible.",
                DisabledTooltip = J.GetProMessage(),
                Callback = function(
                    G)
                    Y.mail_manual_batch_together = G
                    u.Save.SaveDataSync()
                end
            })
        q:SetDisabled(not J.GetCheckIfPro())
        V:AddDivider()
        local g
        g = V:AddDropdown("mail_manual_category_ui",
            {
                Values = { "Seeds", "Pets", "Gears" },
                Default = G,
                Multi = false,
                Text = "\240\159\147\166 Item Category",
                Tooltip =
                "Choose seeds, pets or gears.",
                Callback = function(V)
                    if V ~= "Seeds" and (V ~= "Pets" and V ~= "Gears") then return end
                    G = V
                    y = ""
                    J.MailDraftCategory = V
                    J.MailDraftItemName = ""
                    if j then
                        j:SetValues(d.Mail.GetItemDropdown(V))
                        j:SetValue("")
                    end
                end
            })
        g:SetValue(G)
        j = V:AddValueDropdown("mail_manual_item_ui",
            {
                Values = {},
                Default = "",
                Multi = false,
                Searchable = true,
                MaxVisibleDropdownItems = 10,
                Text =
                "\240\159\142\129 Select Item",
                Tooltip = "Select the item to add to the order.",
                Changed = function(G)
                    if type(G) ~= "string" or G == "" then return end
                    y = G
                    J.MailDraftItemName = G
                end
            })
        j:SetValues(d.Mail.GetItemDropdown(G))
        local E
        E = V:AddInput("mail_manual_amount_ui",
            {
                Text = "\240\159\148\162 Amount",
                Default = tostring(Z),
                Numeric = true,
                AllowEmpty = true,
                Finished = true,
                ClearTextOnFocus = false,
                Placeholder =
                "Amount to send",
                Callback = function(G)
                    local V = l(G)
                    if not V or V <= 0 then
                        J.Notify("Amount must be a whole number above 0", 3)
                        E:SetValue(tostring(Z))
                        return
                    end
                    Z = V
                    J.MailDraftAmount = V
                end
            })
        c = V:AddButton({
            Text = "\226\158\149 Add To Order",
            DisabledTooltip = J.GetProMessage(),
            Func = function()
                local V, j = d.Mail.AddDraftItem(G, y, Z)
                J.Notify(j, 3)
                if V then d.Mail.SetStatus(j, "#7CFC00") else d.Mail.SetStatus(j, "#FF5555") end
            end
        })
        c:SetDisabled(not J.GetCheckIfPro())
        T:SetDisabled(not J.GetCheckIfPro())
        V:AddDivider()
        i = V:AddLabel({ Text = d.Mail.GetDraftText(), DoesWrap = true })
        J.MailUiRefs.RefreshDraft = function() if i then i:SetText(d.Mail.GetDraftText()) end end
        J.MailManualStatusLabel = V:AddLabel({ Text = J.MailManualUiStatusText, DoesWrap = true })
        J.MailStartOrderButton = V:AddButton({
            Text = "\226\150\182\239\184\143 Start Sending",
            Disabled = J
                .MailManualRunning,
            DisabledTooltip = "The current order is still sending.",
            Func = function()
                if not J.GetCheckIfPro() then
                    J.Notify(J.GetProMessage(), 5)
                    return
                end
                local G, V = d.Mail.StartManualOrder(J.MailDraftTargetUsername)
                J.Notify(V, G and 3 or 4)
                if not G then d.Mail.SetStatus(V, "#FF5555") end
            end
        })
        J.MailStopOrderButton = J.MailStartOrderButton:AddButton({
            Text = "\226\143\185\239\184\143 Stop",
            Disabled = not
                J.MailManualRunning,
            DisabledTooltip = "No manual order is running.",
            Func = function()
                if not J.GetCheckIfPro() then
                    J.Notify(J.GetProMessage(), 5)
                    return
                end
                if d.Mail.StopManualOrder() then J.Notify("Manual order stopped", 3) end
            end
        })
        J.MailClearOrderButton = V:AddButton({
            Text = "\240\159\167\185 Clear Order",
            Disabled = J.MailManualRunning,
            DisabledTooltip =
            "The current order is still sending.",
            Func = function()
                if d.Mail.ClearDraft() then
                    d.Mail.SetManualUiStatus("Order cleared", "#CFCFCF", "\240\159\167\185")
                    J.Notify("Order cleared", 2)
                else
                    J.Notify("Stop the current order first", 3)
                end
            end
        })
        d.Mail.RefreshManualUi()
    end
    if y then
        local G = ""
        local V = "Seeds"
        local Z = ""
        local j = 5
        local i = 5
        local c = {}
        local T = {}
        local q
        local g
        local E
        local a
        y:AddLabel({ Text = "Sends when the matching inventory amount reaches the trigger.", DoesWrap = true })
        y:AddInput("mail_rule_username_ui",
            {
                Text = "\240\159\145\164 Recipient Username",
                Default = "",
                Numeric = false,
                AllowEmpty = true,
                Finished = true,
                ClearTextOnFocus = false,
                Placeholder =
                "Roblox username",
                Callback = function(V) G = d.Mail.CleanUsername(V) end
            })
        local H
        H = y:AddDropdown("mail_rule_category_ui",
            {
                Values = { "Seeds", "Pets", "Gears" },
                Default = V,
                Multi = false,
                Text = "\240\159\147\166 Item Category",
                Tooltip =
                "Choose seeds, pets or gears.",
                Callback = function(G)
                    if G ~= "Seeds" and (G ~= "Pets" and G ~= "Gears") then return end
                    V = G
                    Z = ""
                    if q then
                        q:SetValues(d.Mail.GetItemDropdown(G))
                        q:SetValue("")
                    end
                end
            })
        H:SetValue(V)
        q = y:AddValueDropdown("mail_rule_item_ui",
            {
                Values = {},
                Default = "",
                Multi = false,
                Searchable = true,
                MaxVisibleDropdownItems = 10,
                Text =
                "\240\159\142\129 Select Item",
                Tooltip = "Select the item the rule will send.",
                Changed = function(G)
                    if type(G) ~= "string" or G == "" then return end
                    Z = G
                end
            })
        q:SetValues(d.Mail.GetItemDropdown(V))
        local r
        r = y:AddInput("mail_rule_trigger_ui",
            {
                Text = "\240\159\142\175 Trigger Amount",
                Default = tostring(j),
                Numeric = true,
                AllowEmpty = true,
                Finished = true,
                ClearTextOnFocus = false,
                Placeholder =
                "Example: 5",
                Tooltip = "The rule starts when you own at least this amount.",
                Callback = function(G)
                    local V = l(G)
                    if not V or V <= 0 then
                        J.Notify("Trigger must be above 0", 3)
                        r:SetValue(tostring(j))
                        return
                    end
                    j = V
                end
            })
        local e
        e = y:AddInput("mail_rule_send_amount_ui",
            {
                Text = "\240\159\147\164 Send Amount",
                Default = tostring(i),
                Numeric = true,
                AllowEmpty = true,
                Finished = true,
                ClearTextOnFocus = false,
                Placeholder =
                "Example: 5",
                Tooltip = "How many matching items to send each time the rule runs.",
                Callback = function(G)
                    local V = l(G)
                    if not V or V <= 0 then
                        J.Notify("Send amount must be above 0", 3)
                        e:SetValue(tostring(i))
                        return
                    end
                    i = V
                end
            })
        local s
        s = y:AddValueDropdown("mail_rule_pet_types_ui",
            {
                Values = { "Normal", "Rainbow" },
                Default = {},
                Multi = true,
                Searchable = false,
                MaxVisibleDropdownItems = 5,
                Text =
                "\226\156\168 Pet Variant",
                Tooltip = "Pet rules only. No selection sends all variants.",
                Changed = function(
                    G)
                    c = type(G) == "table" and G or {}
                end
            })
        s:SetValue({})
        local N
        N = y:AddValueDropdown("mail_rule_pet_sizes_ui",
            {
                Values = { "Normal", "Big", "Huge" },
                Default = {},
                Multi = true,
                Searchable = false,
                MaxVisibleDropdownItems = 5,
                Text =
                "\240\159\147\143 Pet Size",
                Tooltip = "Pet rules only. No selection sends all sizes.",
                Changed = function(G)
                    T =
                        type(G) == "table" and G or {}
                end
            })
        N:SetValue({})
        a = y:AddButton({
            Text = "\226\158\149 Add Auto Rule",
            Func = function()
                local y, u = d.Mail.LookupRecipient(G)
                if not y then
                    J.Notify(u, 4)
                    d.Mail.SetStatus(u, "#FF5555")
                    return
                end
                local q, g = d.Mail.AddRule(y, V, Z, j, i, c, T)
                if q then
                    J.Notify("Rule added: " .. g, 3)
                    d.Mail.SetStatus("Auto rule added", "#7CFC00")
                else
                    J.Notify(g, 4)
                    d.Mail.SetStatus(g, "#FF5555")
                end
            end
        })
        a:SetDisabled(not J.GetCheckIfPro())
        y:AddDivider()
        g = y:AddValueDropdown("mail_active_rules_ui",
            {
                Values = {},
                Default = "",
                Multi = false,
                Searchable = true,
                MaxVisibleDropdownItems = 8,
                Text =
                "\240\159\147\139 Active Rules",
                Tooltip = "Select a rule to enable, disable or remove it.",
                Changed = function(
                    G)
                    if type(G) ~= "string" then return end
                    J.MailSelectedRuleId = G
                    local V = type(Y.mail_auto_rules) == "table" and Y.mail_auto_rules[G]
                    if E and type(V) == "table" then
                        E:SetText(string.format("%s | @%s | Trigger %d | Send %d",
                            V.enabled == true and "Enabled" or "Disabled", tostring(V.targetUsername or "?"),
                            tonumber(V.triggerAmount) or 0, tonumber(V.sendAmount) or 0))
                    end
                end
            })
        E = y:AddLabel({ Text = "Select a rule", DoesWrap = true })
        J.MailUiRefs.RefreshRules = function()
            if g then g:SetValues(d.Mail.GetRuleDropdown()) end
            if E and next(Y.mail_auto_rules or {}) == nil then
                E:SetText(
                    "<font color=\'#888888\'>No automatic rules</font>")
            end
        end
        J.MailUiRefs.RefreshRules()
        local W = y:AddButton({
            Text = "\240\159\148\132 Enable / Disable",
            Func = function()
                local G, V = d.Mail.ToggleRule(J.MailSelectedRuleId)
                if not G then
                    J.Notify("Select a rule first", 3)
                    return
                end
                J.Notify(V and "Rule enabled" or "Rule disabled", 3)
            end
        })
        W:AddButton({
            Text = "\240\159\151\145\239\184\143 Remove Rule",
            Func = function()
                if not d.Mail.RemoveRule(J.MailSelectedRuleId) then
                    J.Notify("Select a rule first", 3)
                    return
                end
                J.MailSelectedRuleId = ""
                E:SetText("Select a rule")
                J.Notify("Rule removed", 3)
            end
        })
        y:AddDivider()
        local X
        X = y:AddToggle("mail_auto_batch_together_ui",
            {
                Text = "\240\159\147\166 Combine Automatic Rules",
                Default = Y.mail_auto_batch_together,
                Tooltip =
                "Combines matching rules for the same recipient into one mail.",
                DisabledTooltip = J.GetProMessage(),
                Callback = function(
                    G)
                    Y.mail_auto_batch_together = G
                    u.Save.SaveDataSync()
                end
            })
        X:SetDisabled(not J.GetCheckIfPro())
        y:AddDivider()
        local h
        h = y:AddToggle("mail_auto_send_enabled_ui",
            {
                Text = "\240\159\147\164 Enable Automatic Send",
                Default = Y.mail_auto_send_enabled,
                Tooltip =
                "Runs enabled mail rules when their trigger is reached.",
                DisabledTooltip = J.GetProMessage(),
                Callback = function(
                    G)
                    Y.mail_auto_send_enabled = G
                    if G then
                        d.Mail.SetStatus("Automatic send enabled", "#7CFC00")
                    elseif not Y.mail_auto_accept and not J.MailManualRunning then
                        d.Mail.ClearStatus()
                    end
                    u.Save.SaveDataSync()
                end
            })
        h:SetDisabled(not J.GetCheckIfPro())
    end
    if Z then
        local G
        local V
        Z:AddLabel({ Text = "Stores the latest 50 completed manual order receipts.", DoesWrap = true })
        G = Z:AddValueDropdown("mail_receipts_ui",
            {
                Values = {},
                Default = "",
                Multi = false,
                Searchable = true,
                MaxVisibleDropdownItems = 8,
                Text =
                "\240\159\167\190 Select Receipt",
                Tooltip = "Select a receipt to view or copy it.",
                Changed = function(G)
                    local y = tonumber(G)
                    local Z = y and Y.mail_receipts[y]
                    if type(Z) ~= "string" then return end
                    J.MailSelectedReceipt = Z
                    if V then V:SetText(Z) end
                end
            })
        V = Z:AddLabel({ Text = "<font color=\'#888888\'>No receipt selected</font>", DoesWrap = true })
        J.MailUiRefs.RefreshReceipts = function()
            if G then G:SetValues(d.Mail.GetReceiptDropdown()) end
            if V and #Y.mail_receipts == 0 then V:SetText("<font color=\'#888888\'>No receipts saved</font>") end
        end
        J.MailUiRefs.RefreshReceipts()
        local y = Z:AddButton({
            Text = "\240\159\147\139 Copy Receipt",
            Func = function()
                if J.MailSelectedReceipt == "" then
                    J.Notify("Select a receipt first", 3)
                    return
                end
                c.CopyToClipBoard(J.MailSelectedReceipt)
            end
        })
        y:AddButton({
            Text = "\240\159\167\185 Clear Receipts",
            Func = function()
                Y.mail_receipts = {}
                J.MailSelectedReceipt = ""
                V:SetText("<font color=\'#888888\'>No receipts saved</font>")
                J.MailUiRefs.RefreshReceipts()
                u.Save.SaveDataSync()
                J.Notify("Receipts cleared", 3)
            end
        })
    end
    if i then
        i:AddLabel({ Text = "Claims item mail automatically. Guild invitations are not accepted.", DoesWrap = true })
        i:AddToggle("mail_auto_accept_ui",
            {
                Text = "\240\159\147\165 Auto Accept Incoming Mail",
                Default = Y.mail_auto_accept,
                Tooltip =
                "Automatically claims incoming item mail.",
                Callback = function(G)
                    Y.mail_auto_accept = G
                    if G then
                        d.Mail.SetStatus("Auto accept enabled", "#7CFC00")
                        task.defer(function() d.Mail.ClaimInbox(false) end)
                    elseif not Y.mail_auto_send_enabled and not J.MailManualRunning then
                        d.Mail.ClearStatus()
                    end
                    u.Save.SaveDataSync()
                end
            })
        i:AddButton({
            Text = "\240\159\147\172 Claim Existing Mail",
            Func = function()
                task.spawn(function()
                    local G = d.Mail.ClaimInbox(true)
                    J.Notify(string.format("Claimed %d mail", G), 3)
                end)
            end
        })
    end
end
J.PremiumUi = function()
    local G = j:AddTab({ Name = "Premium " .. J.GetProLabel(), Description = "Premium systems", Icon = "crown" })
    local V = G.TabLabel
    r.applySmoothRainbow(V, .1)
    local y = G:AddLeftGroupbox("Sprinkler Placement", "cloud-rain")
    local Z = G:AddRightGroupbox("Sprinkler Overrides", "list-plus")
    if y then
        if not J.GetCheckIfPro() then y:AddLabel({ Text = J.GetProMessage(), DoesWrap = true }) end
        y:AddLabel({ Text = "\240\159\146\161 Auto place sprinklers.", DoesWrap = true })
        local G
        G = y:AddValueDropdown("sprinkler_place_selected_ui",
            {
                Values = {},
                Default = {},
                Multi = true,
                Searchable = true,
                MaxVisibleDropdownItems = 10,
                Text =
                "\240\159\146\166 Sprinklers To Place",
                Tooltip = "Selected sprinklers will be kept at their target amount.",
                Changed = function(
                    G)
                    if type(G) ~= "table" then return end
                    Y.sprinkler_place_selected = G
                    u.Save.SaveDataSync()
                end
            })
        G:SetValues(d.SprinklerPlacer.GetDropdown())
        G:SetValue(Y.sprinkler_place_selected)
        local V = y:AddButton({
            Text = "\226\156\133 All",
            Func = function()
                Y.sprinkler_place_selected = d.SprinklerPlacer.GetAllSelection()
                G:SetValue(Y.sprinkler_place_selected)
                u.Save.SaveDataSync()
            end
        })
        V:AddButton({
            Text = "\240\159\167\185 Clear",
            Func = function()
                Y.sprinkler_place_selected = {}
                G:SetValue({})
                u.Save.SaveDataSync()
            end
        })
        y:AddDivider()
        local Z
        Z = y:AddInput("sprinkler_place_default_target_ui",
            {
                Text = "\240\159\142\175 Default Target",
                Default = tostring(Y.sprinkler_place_default_target),
                Numeric = true,
                AllowEmpty = true,
                Finished = true,
                ClearTextOnFocus = false,
                Placeholder =
                "Amount per sprinkler",
                Tooltip = "Places more when a selected sprinkler falls below this amount.",
                Callback = function(
                    G)
                    local V = l(G)
                    if not V or V <= 0 then
                        J.Notify("Target must be a whole number above 0", 3)
                        Z:SetValue(tostring(Y.sprinkler_place_default_target))
                        return
                    end
                    Y.sprinkler_place_default_target = V
                    u.Save.SaveDataSync()
                end
            })
        y:AddDivider()
        local j
        j = y:AddDropdown("sprinkler_place_mode_ui",
            {
                Values = { "Farm Middle", "Plant Target", "Saved Position" },
                Default = Y.sprinkler_place_mode,
                Multi = false,
                Text =
                "\240\159\147\141 Placement Mode",
                Tooltip = "Choose where sprinklers should be placed.",
                Callback = function(
                    G)
                    if type(G) ~= "string" or G == "" then return end
                    Y.sprinkler_place_mode = G
                    u.Save.SaveDataSync()
                end
            })
        j:SetValue(Y.sprinkler_place_mode)
        local i
        i = y:AddValueDropdown("sprinkler_place_target_plant_ui",
            {
                Values = {},
                Default = "",
                Multi = false,
                Searchable = true,
                MaxVisibleDropdownItems = 10,
                Text =
                "\240\159\140\177 Target Plant",
                Tooltip = "Plant Target mode places sprinklers around this plant type.",
                Changed = function(
                    G)
                    if type(G) ~= "string" then return end
                    Y.sprinkler_place_target_plant = G
                    u.Save.SaveDataSync()
                end
            })
        i:SetValues(d.SeedData.GetSeedDataListDropDown())
        i:SetValue(Y.sprinkler_place_target_plant)
        local c = y:AddLabel({ Text = d.SprinklerPlacer.GetSavedPositionText(), DoesWrap = true })
        y:AddButton({
            Text = "\240\159\147\140 Copy Current Position",
            Tooltip =
            "Stand inside your farm where sprinklers should be placed.",
            Func = function()
                local G, V = d.SprinklerPlacer.SaveCurrentPosition()
                J.Notify(V, 3)
                if G then
                    Y.sprinkler_place_mode = "Saved Position"
                    j:SetValue("Saved Position")
                    c:SetText(d.SprinklerPlacer.GetSavedPositionText())
                    u.Save.SaveDataSync()
                end
            end
        })
        y:AddDivider()
        y:AddToggle("sprinkler_place_teleport_ui",
            {
                Text = "\240\159\147\161 Auto Teleport",
                Default = Y.sprinkler_place_teleport,
                Tooltip =
                "Leave disabled to attempt placement from anywhere. Enable it to teleport near the placement position.",
                Callback = function(
                    G)
                    Y.sprinkler_place_teleport = G
                    if not G then d.Teleport.UnlockTeleport(J.TeleportLockNames.SprinklerPlacer) end
                    u.Save.SaveDataSync()
                end
            })
        local T
        T = y:AddToggle("enable_sprinkler_placer_ui",
            {
                Text = "\240\159\146\166 Enable Sprinkler System",
                Default = Y.auto_sprinkler_place,
                Tooltip =
                "Automatically places selected sprinklers when their amount is too low.",
                DisabledTooltip = J.GetProMessage(),
                Callback = function(
                    G)
                    Y.auto_sprinkler_place = G
                    if not G then
                        d.SprinklerPlacer.CleanupTool()
                        d.SprinklerPlacer.ClearStatus()
                        d.Teleport.UnlockTeleport(J.TeleportLockNames.SprinklerPlacer)
                    end
                    u.Save.SaveDataSync()
                end
            })
        T:SetDisabled(not J.GetCheckIfPro())
    end
    if Z then
        local G = ""
        local V = math.max(math.floor(tonumber(Y.sprinkler_place_default_target) or 1), 1)
        local y = false
        local j = {}
        local i = 0
        local c
        local T
        Z:AddLabel({ Text = "\240\159\146\161 Set a different target for individual sprinklers.", DoesWrap = true })
        local function q()
            for G, V in ipairs(j) do if V.Holder and typeof(V.Holder) == "Instance" then V.Holder:Destroy() end end
            table.clear(j)
            if Z.Resize then Z:Resize() end
        end
        local function g()
            local V = d.SprinklerPlacer.GetOverrideTarget(G)
            if V ~= nil then return V end
            return math.max(math.floor(tonumber(Y.sprinkler_place_default_target) or 1), 1)
        end
        local function E()
            if G == "" then return end
            V = g()
            y = true
            if c then
                c:SetValue(tostring(V))
                c:SetText(string.format("\240\159\142\175 Target Amount: <font color=\'#7CFC00\'>%d</font>", V))
            end
            if T then T:SetValue(d.SprinklerPlacer.GetOverrideTarget(G) ~= nil) end
            y = false
        end
        local a
        a = function()
            q()
            i += 1
            local V = {}
            if type(Y.sprinkler_place_overrides) == "table" then
                for G in pairs(Y.sprinkler_place_overrides) do
                    if d.SprinklerPlacer.GetOverrideTarget(G) ~= nil then
                        table.insert(V, G)
                    end
                end
            end
            table.sort(V)
            if #V == 0 then
                local G = Z:AddLabel({ Text = "<font color=\'#888888\'>No active sprinkler overrides</font>", DoesWrap = true })
                table.insert(j, G)
            else
                for V, y in ipairs(V) do
                    local c = d.SprinklerPlacer.GetOverrideTarget(y)
                    local J
                    J = Z:AddToggle(string.format("sprinkler_active_override_%d_%d", i, V),
                        {
                            Text = string.format("\240\159\146\166 %s <font color=\'#7CFC00\'>Target: %d</font>", y, c),
                            Default = true,
                            Tooltip =
                            "Disable this sprinkler override.",
                            Callback = function(V)
                                if V then return end
                                d.SprinklerPlacer.RemoveOverrideTarget(y)
                                u.Save.SaveDataSync()
                                if G == y then E() end
                                task.defer(a)
                            end
                        })
                    table.insert(j, J)
                end
            end
            if Z.Resize then Z:Resize() end
        end
        local H
        H = Z:AddValueDropdown("sprinkler_override_select_ui",
            {
                Values = {},
                Default = "",
                Multi = false,
                Searchable = true,
                MaxVisibleDropdownItems = 10,
                Text =
                "\240\159\146\166 Select Sprinkler",
                Tooltip = "Select a sprinkler to configure its target.",
                Changed = function(
                    V)
                    if type(V) ~= "string" or V == "" then return end
                    G = V
                    E()
                end
            })
        H:SetValues(d.SprinklerPlacer.GetDropdown())
        c = Z:AddInput("sprinkler_override_target_ui",
            {
                Text = "\240\159\142\175 Target Amount",
                Default = tostring(V),
                Numeric = true,
                AllowEmpty = true,
                Finished = true,
                ClearTextOnFocus = false,
                Placeholder =
                "Enter target amount",
                Tooltip = "Sets how many of this sprinkler should remain active.",
                Callback = function(
                    Z)
                    if y then return end
                    if G == "" then
                        J.Notify("Select a sprinkler first", 3)
                        return
                    end
                    local j = l(Z)
                    if not j or j <= 0 then
                        J.Notify("Target must be above 0", 3)
                        E()
                        return
                    end
                    V = j
                    c:SetText(string.format("\240\159\142\175 Target Amount: <font color=\'#7CFC00\'>%d</font>", V))
                    if d.SprinklerPlacer.GetOverrideTarget(G) ~= nil then
                        d.SprinklerPlacer.SetOverrideTarget(G, V)
                        u.Save.SaveDataSync()
                        a()
                    end
                end
            })
        T = Z:AddToggle("sprinkler_override_enable_ui",
            {
                Text = "\240\159\146\165 Enable Override",
                Default = false,
                Tooltip =
                "Use the custom target for the selected sprinkler.",
                Callback = function(Z)
                    if y then return end
                    if G == "" then
                        y = true
                        T:SetValue(false)
                        y = false
                        J.Notify("Select a sprinkler first", 3)
                        return
                    end
                    if Z then
                        if not d.SprinklerPlacer.SetOverrideTarget(G, V) then
                            y = true
                            T:SetValue(false)
                            y = false
                            J.Notify("Failed to enable override", 3)
                            return
                        end
                    else
                        d.SprinklerPlacer.RemoveOverrideTarget(G)
                    end
                    u.Save.SaveDataSync()
                    E()
                    a()
                end
            })
        Z:AddDivider()
        Z:AddLabel({ Text = "= <font color=\'#7CFC00\'>Active Sprinkler Overrides</font> =", DoesWrap = true })
        a()
    end
end
J.GardenItemsUi = function()
    local G = j:AddTab({ Name = "Garden Items", Description = "Collect garden drops", Icon = "package-open" })
    local V = G:AddLeftGroupbox("Auto Collect", "hand")
    local y = G:AddRightGroupbox("Garden Expansion", "expand")
    if y then
        local G
        G = y:AddInput("auto_expand_garden_max_slot_ui",
            {
                Text = "\240\159\143\161 Maximum Slot",
                Default = tostring(Y.auto_expand_garden_max_slot),
                Numeric = true,
                AllowEmpty = false,
                Finished = true,
                ClearTextOnFocus = false,
                Placeholder =
                "Maximum expansion slot",
                Tooltip = "Stops purchasing when the selected garden slot is reached.",
                Callback = function(
                    V)
                    local y = l(V)
                    local Z = d.GardenItems.ExpandSystem.GetMaximumSlot()
                    if not y or y < 1 or y > Z then
                        J.Notify("Garden slot must be between 1 and " .. Z, 3)
                        G:SetValue(tostring(Y.auto_expand_garden_max_slot))
                        return
                    end
                    Y.auto_expand_garden_max_slot = y
                    u.Save.SaveDataSync()
                end
            })
        y:AddToggle("auto_expand_garden_enabled_ui",
            {
                Text = "\240\159\143\161 Enable Auto Expand",
                Default = Y.auto_expand_garden,
                Tooltip =
                "Automatically purchases affordable garden expansions.",
                Callback = function(G)
                    Y.auto_expand_garden = G
                    if not G then J.GardenExpandStatusText = "" end
                    u.Save.SaveDataSync()
                end
            })
    end
    if V then
        V:AddToggle("auto_collect_drop_seeds",
            {
                Text = "\240\159\140\177 Auto Collect Dropped Seeds",
                Default = Y.auto_collect_drop_seeds,
                Tooltip =
                "Collects seeds dropped by your pets or player.",
                Callback = function(G)
                    Y.auto_collect_drop_seeds = G
                    u.Save.SaveDataSync()
                end
            })
        V:AddToggle("garden_items_auto_collect_event_seeds",
            {
                Text = "\240\159\140\136 Auto Collect Gold & Rainbow Seeds",
                Default = Y.auto_collect_event_seeds,
                Tooltip =
                "Collects Gold and Rainbow seeds dropped by the event.",
                Callback = function(G)
                    Y.auto_collect_event_seeds = G
                    u.Save.SaveDataSync()
                end
            })
    end
end
J.PlantsUi = function()
    local G = j:AddTab({ Name = "Plants", Description = "Plant automation", Icon = "sprout" })
    local V = G:AddLeftGroupbox("Shovel Fruits", "shovel")
    local y = G:AddRightGroupbox("<font color=\'#FF5555\'>\226\154\160\239\184\143 Shovel Plants</font>",
        "triangle-alert")
    local i = G:AddLeftGroupbox("Move Plants", "move")
    local c = G:AddRightGroupbox("Water Plants", "droplets")
    if c then
        local G
        G = c:AddValueDropdown("water_plant_selected_cans_ui",
            {
                Values = {},
                Default = {},
                Multi = true,
                Searchable = true,
                MaxVisibleDropdownItems = 6,
                Text =
                "\240\159\146\167 Watering Cans",
                Tooltip =
                "Select watering cans to use. No selection uses any available can.",
                Changed = function(G)
                    if type(G) ~= "table" then return end
                    Y.water_plant_selected_cans = G
                    u.Save.SaveDataSync()
                end
            })
        G:SetValues(d.WaterPlants.GetCanDropdown())
        G:SetValue(Y.water_plant_selected_cans)
        local V
        V = c:AddDropdown("water_plant_mode_ui",
            {
                Values = { "Growing Plant", "Farm Middle", "Plant Target", "Custom Position" },
                Default = Y
                    .water_plant_mode,
                Multi = false,
                Text = "\240\159\147\141 Water Target",
                Tooltip =
                "Choose where the watering can should be used.",
                Callback = function(G)
                    if type(G) ~= "string" or G == "" then return end
                    Y.water_plant_mode = G
                    u.Save.SaveDataSync()
                end
            })
        V:SetValue(Y.water_plant_mode)
        local y
        y = c:AddValueDropdown("water_plant_target_plant_ui",
            {
                Values = {},
                Default = "",
                Multi = false,
                Searchable = true,
                MaxVisibleDropdownItems = 10,
                Text =
                "\240\159\140\177 Target Plant",
                Tooltip = "Plant Target mode waters any plant of this type.",
                Changed = function(
                    G)
                    if type(G) ~= "string" then return end
                    Y.water_plant_target_plant = G
                    u.Save.SaveDataSync()
                end
            })
        y:SetValues(d.SeedData.GetSeedDataListDropDown())
        y:SetValue(Y.water_plant_target_plant)
        local Z = c:AddLabel({ Text = d.WaterPlants.GetSavedPositionText(), DoesWrap = true })
        c:AddButton({
            Text = "\240\159\147\140 Copy Current Position",
            Tooltip =
            "Stand inside your farm where the watering can should be used.",
            Func = function()
                local G, y = d.WaterPlants.SaveCurrentPosition()
                J.Notify(y, 3)
                if G then
                    Y.water_plant_mode = "Custom Position"
                    V:SetValue("Custom Position")
                    Z:SetText(d.WaterPlants.GetSavedPositionText())
                    u.Save.SaveDataSync()
                end
            end
        })
        c:AddDivider()
        c:AddToggle("water_plant_wait_effect_ui",
            {
                Text = "\226\143\179 Wait for Effect",
                Default = Y.water_plant_wait_effect,
                Tooltip =
                "Waits for the watering effect to finish. Disable to stack watering effects.",
                Callback = function(G)
                    Y.water_plant_wait_effect = G
                    if not G then d.WaterPlants.NextUseAt = 0 end
                    u.Save.SaveDataSync()
                end
            })
        c:AddToggle("auto_water_plants_ui",
            {
                Text = "\240\159\146\167 Enable Water Plants",
                Default = Y.auto_water_plants,
                Tooltip =
                "Automatically uses watering cans at the selected target.",
                Callback = function(G)
                    Y.auto_water_plants = G
                    if not G then
                        d.WaterPlants.CleanupTool()
                        d.WaterPlants.ClearStatus()
                    end
                    u.Save.SaveDataSync()
                end
            })
    end
    if i then
        i:AddLabel({ Text = "\240\159\147\141 Moves selected plants to one position. No selection means all plants.", DoesWrap = true })
        local G
        G = i:AddValueDropdown("trowel_plant_types_ui",
            {
                Values = {},
                Default = {},
                Multi = true,
                Searchable = true,
                MaxVisibleDropdownItems = 10,
                Text =
                "\240\159\140\177 Plant Types",
                Tooltip = "Selected plants will be moved. No selection moves all plants.",
                Changed = function(
                    G)
                    if type(G) ~= "table" then return end
                    Y.trowel_plant_types = G
                    u.Save.SaveDataSync()
                end
            })
        G:SetValues(d.SeedData.GetSeedDataListDropDown())
        G:SetValue(Y.trowel_plant_types)
        local V = i:AddButton({
            Text = "\226\156\133 All",
            Func = function()
                Y.trowel_plant_types = d.Trowel.GetAllSelection()
                G:SetValue(Y.trowel_plant_types)
                u.Save.SaveDataSync()
            end
        })
        V:AddButton({
            Text = "\240\159\167\185 Clear",
            Func = function()
                Y.trowel_plant_types = {}
                G:SetValue({})
                u.Save.SaveDataSync()
            end
        })
        i:AddDivider()
        i:AddToggle("trowel_use_fixed_spot_ui",
            {
                Text = "\240\159\147\140 Use Farm Middle",
                Default = Y.trowel_use_fixed_spot,
                Tooltip =
                "Moves plants to the permanent middle point of your farm.",
                Callback = function(G)
                    Y.trowel_use_fixed_spot = G
                    u.Save.SaveDataSync()
                end
            })
        local y = i:AddLabel({ Text = d.Trowel.GetSavedPositionText(), DoesWrap = true })
        i:AddButton({
            Text = "\240\159\147\141 Copy Current Position",
            Tooltip =
            "Stand inside either plant area before saving.",
            Func = function()
                local G, V = d.Trowel.SavePlayerPosition()
                if G then
                    y:SetText(d.Trowel.GetSavedPositionText())
                    J.Notify("Position saved: " .. tostring(V), 3)
                else
                    J.Notify(V, 3)
                end
            end
        })
        i:AddDivider()
        local Z = i:AddButton({ Text = "\226\150\182\239\184\143 Start Trowel", Func = function() d.Trowel.Start() end })
        Z:AddButton({ Text = "\226\143\185\239\184\143 Stop Trowel", Func = function() d.Trowel.Stop() end })
    end
    if y then
        y:AddLabel({
            Text =
            "\240\159\154\168 <font color=\'#FF5555\'><b>DANGER:</b></font> This removes the entire plant and every fruit attached to it. <font color=\'#FF5555\'><b>This cannot be undone.</b></font>",
            DoesWrap = true
        })
        y:AddLabel({
            Text =
            "Single-harvest plants are excluded. The keep amount applies separately to every selected plant type.",
            DoesWrap = true
        })
        y:AddDivider()
        local G
        G = y:AddValueDropdown("shovel_plant_types_ui",
            {
                Values = {},
                Default = {},
                Multi = true,
                Searchable = true,
                MaxVisibleDropdownItems = 10,
                Text =
                "\240\159\140\177 Plant Type",
                Tooltip = "Select plant types that may be permanently removed.",
                Changed = function(
                    G)
                    if type(G) ~= "table" then return end
                    Y.shovel_plant_types = G
                    u.Save.SaveDataSync()
                end
            })
        G:SetValues(d.PlantShovel.GetPlantTypeDropdown())
        G:SetValue(Y.shovel_plant_types)
        local V = y:AddButton({
            Text = "\226\156\133 <font color=\'#7CFF8A\'><b>All</b></font>",
            Func = function()
                local V = d.PlantShovel.GetAllPlantTypeSelection()
                Y.shovel_plant_types = V
                G:SetValue(V)
                u.Save.SaveDataSync()
            end
        })
        V:AddButton({
            Text = "\240\159\167\185 <font color=\'#FFB86B\'><b>Clear</b></font>",
            Func = function()
                Y.shovel_plant_types = {}
                G:SetValue({})
                u.Save.SaveDataSync()
            end
        })
        y:AddButton({
            Text = "\240\159\148\132 Reload Plant Counts",
            Tooltip =
            "Refreshes the current plant amounts shown in the dropdown.",
            Func = function()
                G:SetValues(d.PlantShovel.GetPlantTypeDropdown())
                G:SetValue(Y.shovel_plant_types)
                J.Notify("Plant counts refreshed", 2)
            end
        })
        y:AddDivider()
        local j
        local i = "\226\172\135\239\184\143 <font color=\'#7CFC00\'>Minimum</font> Height"
        j = y:AddInput("shovel_plant_min_height_ui",
            {
                Text = i,
                Default = tostring(Y.shovel_plant_min_height),
                Numeric = true,
                AllowEmpty = true,
                Finished = true,
                ClearTextOnFocus = false,
                Placeholder =
                "Minimum Height",
                Callback = function(G)
                    local V = B(G)
                    if not V or V < 0 then
                        J.Notify("Minimum height must be 0 or more", 3)
                        j:SetValue(tostring(Y.shovel_plant_min_height))
                        return
                    end
                    local y = tonumber(Y.shovel_plant_max_height) or 200
                    if V > y then
                        J.Notify("Minimum height must be lower than maximum", 3)
                        j:SetValue(tostring(Y.shovel_plant_min_height))
                        return
                    end
                    Y.shovel_plant_min_height = V
                    u.Save.SaveDataSync()
                    j:SetText("\226\156\133 <font color=\'#00FF00\'>Minimum Height Updated</font>")
                    task.delay(1.5, function() if j then j:SetText(i) end end)
                end
            })
        local c
        local T = "\226\172\134\239\184\143 <font color=\'#FF6B6B\'>Maximum</font> Height"
        c = y:AddInput("shovel_plant_max_height_ui",
            {
                Text = T,
                Default = tostring(Y.shovel_plant_max_height),
                Numeric = true,
                AllowEmpty = true,
                Finished = true,
                ClearTextOnFocus = false,
                Placeholder =
                "Maximum Height",
                Callback = function(G)
                    local V = B(G)
                    if not V or V < 0 then
                        J.Notify("Maximum height must be 0 or more", 3)
                        c:SetValue(tostring(Y.shovel_plant_max_height))
                        return
                    end
                    local y = tonumber(Y.shovel_plant_min_height) or 0
                    if V < y then
                        J.Notify("Maximum height must be higher than minimum", 3)
                        c:SetValue(tostring(Y.shovel_plant_max_height))
                        return
                    end
                    Y.shovel_plant_max_height = V
                    u.Save.SaveDataSync()
                    c:SetText("\226\156\133 <font color=\'#00FF00\'>Maximum Height Updated</font>")
                    task.delay(1.5, function() if c then c:SetText(T) end end)
                end
            })
        y:AddDivider()
        local q
        q = y:AddValueDropdown("shovel_plant_variants_ui",
            {
                Values = {},
                Default = {},
                Multi = true,
                Searchable = true,
                MaxVisibleDropdownItems = 10,
                Text =
                "\226\156\168 Variant",
                Tooltip = "No selection means all variants, including plants without a mutation.",
                Changed = function(
                    G)
                    if type(G) ~= "table" then return end
                    Y.shovel_plant_variants = G
                    u.Save.SaveDataSync()
                end
            })
        q:SetValues(d.Mutations.GetNames())
        q:SetValue(Y.shovel_plant_variants)
        local g
        g = y:AddValueDropdown("shovel_plant_variant_blacklist_ui",
            {
                Values = d.Mutations.GetNames(),
                Default = {},
                Multi = true,
                Searchable = true,
                MaxVisibleDropdownItems = 10,
                Text =
                "\240\159\155\161\239\184\143 Protect Plant Variants",
                Tooltip =
                "Plants containing selected variants will never be shoveled.",
                Changed = function(G)
                    if type(G) ~= "table" then return end
                    Y.shovel_plant_variant_blacklist = G
                    u.Save.SaveDataSync()
                end
            })
        g:SetValue(Y.shovel_plant_variant_blacklist)
        y:AddToggle("shovel_growing_plants_ui",
            {
                Text = "<font color=\'#FFAA55\'>\240\159\140\177 Shovel Growing Plants</font>",
                Default = Y
                    .shovel_growing_plants,
                Tooltip = "Also removes plants where Age is lower than MaxAge.",
                Callback = function(
                    G)
                    Y.shovel_growing_plants = G
                    u.Save.SaveDataSync()
                end
            })
        y:AddDivider()
        local E
        local a = "\240\159\155\161\239\184\143 Max <font color=\'#7CFC00\'>Plants To Keep</font>"
        E = y:AddInput("shovel_plants_keep_ui",
            {
                Text = a,
                Default = tostring(Y.shovel_plants_keep),
                Numeric = true,
                AllowEmpty = true,
                Finished = true,
                ClearTextOnFocus = false,
                Placeholder =
                "Plants to keep per type",
                Tooltip =
                "Enter 0 to remove all eligible plants. The keep amount applies separately to each selected plant type.",
                Callback = function(
                    G)
                    local V = l(G)
                    if not V or V < 0 then
                        J.Notify("Keep amount must be a whole number of 0 or more", 3)
                        E:SetValue(tostring(Y.shovel_plants_keep))
                        return
                    end
                    Y.shovel_plants_keep = V
                    u.Save.SaveDataSync()
                    E:SetText("\226\156\133 <font color=\'#00FF00\'>Keep Amount Updated</font>")
                    task.delay(1.5, function() if E then E:SetText(a) end end)
                end
            })
        y:AddDivider()
        local H
        H = y:AddToggle("enable_plant_shovel_ui",
            {
                Text = "<font color=\'#FF3333\'><b>\226\154\160\239\184\143 Enable Plant Shovel</b></font>",
                Default = Y
                    .auto_shovel_plants,
                Tooltip = "Permanently removes entire plants matching the selected filters.",
                Callback = function(
                    G)
                    if G == Y.auto_shovel_plants then return end
                    if G and not Y.auto_shovel_plants then
                        Z:Confirm({
                            Title = "\226\154\160\239\184\143 Enable Plant Shovel?",
                            Description =
                            "This will permanently remove entire plants and every fruit attached to them.\n\nThis cannot be undone.\n\nCheck your selected plant types, height range, variants, growing option and keep amount before continuing.",
                            Callback = function(
                                G)
                                if G then
                                    Y.auto_shovel_plants = true
                                    d.PlantShovel.SetStatus("Starting...", "#FF7777")
                                    u.Save.SaveDataSync()
                                else
                                    H:SetValue(Y.auto_shovel_plants)
                                end
                            end
                        })
                        return
                    end
                    Y.auto_shovel_plants = false
                    d.PlantShovel.ClearStatus()
                    u.Save.SaveDataSync()
                end
            })
    end
    if V then
        V:AddLabel({
            Text =
            "\226\154\160\239\184\143 Matching fruits are permanently removed. Single-harvest plants are excluded.",
            DoesWrap = true
        })
        local G
        G = V:AddValueDropdown("shovel_fruit_types",
            {
                Values = {},
                Default = {},
                Multi = true,
                Text = "\240\159\141\142 Fruit Type",
                Tooltip =
                "Only selected fruit types will be removed.",
                Searchable = true,
                MaxVisibleDropdownItems = 10,
                Changed = function(
                    G)
                    if type(G) ~= "table" then return end
                    Y.shovel_fruit_types = G
                    u.Save.SaveDataSync()
                end
            })
        G:SetValues(d.ShovelFruits.GetFruitTypeDropdown())
        G:SetValue(Y.shovel_fruit_types)
        local y = V:AddButton({
            Text = "\226\156\133 <font color=\'#7CFF8A\'><b>All</b></font>",
            Func = function()
                local V = d.ShovelFruits.GetAllFruitTypeSelection()
                Y.shovel_fruit_types = V
                G:SetValue(V)
                u.Save.SaveDataSync()
            end
        })
        y:AddButton({
            Text = "\240\159\167\185 <font color=\'#FFB86B\'><b>Clear</b></font>",
            Func = function()
                Y.shovel_fruit_types = {}
                G:SetValue({})
                u.Save.SaveDataSync()
            end
        })
        V:AddDivider()
        local Z
        Z = V:AddValueDropdown("shovel_mutation_whitelist",
            {
                Values = d.ShovelFruits.GetMutationNames(),
                Default = {},
                Multi = true,
                Text =
                "\226\156\133 Whitelist Mutations",
                Tooltip =
                "When used, only fruits containing at least one selected mutation will be removed.",
                Searchable = true,
                MaxVisibleDropdownItems = 10,
                Changed = function(
                    G)
                    if type(G) ~= "table" then return end
                    Y.shovel_mutation_whitelist = G
                    u.Save.SaveDataSync()
                end
            })
        Z:SetValue(Y.shovel_mutation_whitelist)
        local j
        j = V:AddValueDropdown("shovel_mutation_blacklist",
            {
                Values = d.ShovelFruits.GetMutationNames(),
                Default = {},
                Multi = true,
                Text =
                "\226\155\148 Blacklist Mutations",
                Tooltip =
                "Fruits containing any selected mutation will never be removed. Blacklist wins.",
                Searchable = true,
                MaxVisibleDropdownItems = 10,
                Changed = function(
                    G)
                    if type(G) ~= "table" then return end
                    Y.shovel_mutation_blacklist = G
                    u.Save.SaveDataSync()
                end
            })
        j:SetValue(Y.shovel_mutation_blacklist)
        V:AddDivider()
        local i
        local c = "\226\172\135\239\184\143 <font color=\'#7CFC00\'>Minimum</font> Weight [KG]"
        i = V:AddInput("shovel_min_weight",
            {
                Text = c,
                Default = tostring(Y.shovel_min_weight),
                Numeric = true,
                AllowEmpty = true,
                Finished = true,
                ClearTextOnFocus = false,
                Placeholder =
                "Minimum Weight",
                Callback = function(G)
                    local V = B(G)
                    if not V then
                        J.Notify("Invalid number: " .. tostring(G), 3)
                        i:SetValue(tostring(Y.shovel_min_weight))
                        return
                    end
                    if V < 0 then
                        J.Notify("Enter a value of 0 or more", 3)
                        i:SetValue(tostring(Y.shovel_min_weight))
                        return
                    end
                    local y = tonumber(Y.shovel_max_weight) or 1000000000
                    if V > y then
                        J.Notify("Minimum must be lower than maximum", 3)
                        i:SetValue(tostring(Y.shovel_min_weight))
                        return
                    end
                    Y.shovel_min_weight = V
                    u.Save.SaveDataSync()
                    i:SetText("\226\156\133 <font color=\'#00FF00\'>Minimum Weight Updated</font>")
                    task.delay(1.5, function() if i then i:SetText(c) end end)
                end
            })
        local T
        local q = "\226\172\134\239\184\143 <font color=\'#FF6B6B\'>Maximum</font> Weight [KG]"
        T = V:AddInput("shovel_max_weight",
            {
                Text = q,
                Default = tostring(Y.shovel_max_weight),
                Numeric = true,
                AllowEmpty = true,
                Finished = true,
                ClearTextOnFocus = false,
                Placeholder =
                "Maximum Weight",
                Callback = function(G)
                    local V = B(G)
                    if not V then
                        J.Notify("Invalid number: " .. tostring(G), 3)
                        T:SetValue(tostring(Y.shovel_max_weight))
                        return
                    end
                    if V <= 0 then
                        J.Notify("Enter a value greater than 0", 3)
                        T:SetValue(tostring(Y.shovel_max_weight))
                        return
                    end
                    local y = tonumber(Y.shovel_min_weight) or 0
                    if V < y then
                        J.Notify("Maximum must be higher than minimum", 3)
                        T:SetValue(tostring(Y.shovel_max_weight))
                        return
                    end
                    Y.shovel_max_weight = V
                    u.Save.SaveDataSync()
                    T:SetText("\226\156\133 <font color=\'#00FF00\'>Maximum Weight Updated</font>")
                    task.delay(1.5, function() if T then T:SetText(q) end end)
                end
            })
        V:AddDivider()
        local g
        g = V:AddValueDropdown("shovel_variants",
            {
                Values = d.ShovelFruits.GetVariantNames(),
                Default = {},
                Multi = true,
                Text = "\226\156\168 Variant",
                Tooltip =
                "Normal, Gold or Rainbow. No selection removes nothing.",
                Searchable = false,
                MaxVisibleDropdownItems = 5,
                Changed = function(
                    G)
                    if type(G) ~= "table" then return end
                    Y.shovel_variants = G
                    u.Save.SaveDataSync()
                end
            })
        g:SetValue(Y.shovel_variants)
        V:AddDivider()
        V:AddToggle("enable_shovel_fruits",
            {
                Text = "<font color=\'#FF6B6B\'>Enable Shovel</font>",
                Default = Y.auto_shovel_fruits,
                Tooltip =
                "Permanently removes fruits matching all configured filters.",
                Callback = function(G)
                    Y.auto_shovel_fruits = G == true
                    if not G then d.ShovelFruits.CleanupTool() end
                    u.Save.SaveData()
                end
            })
    end
end
J.AutoUi = function()
    local G = j:AddTab({ Name = "Seed Placer", Description = "Places selected seeds", Icon = "sprout" })
    local V = G:AddLeftGroupbox("Seed Placement", "sprout")
    local y = G:AddRightGroupbox("Seed Target Overrides", "list-plus")
    if y then
        local G = ""
        local V = math.max(math.floor(tonumber(Y.seed_place_default_target) or 10), 1)
        local Z = false
        local j = {}
        local i = 0
        local c
        local T
        y:AddLabel({ Text = "\240\159\146\161 Set a different planting target for individual seeds.", DoesWrap = true })
        local function q()
            for G, V in ipairs(j) do if V.Holder and typeof(V.Holder) == "Instance" then V.Holder:Destroy() end end
            table.clear(j)
            if y.Resize then y:Resize() end
        end
        local function g()
            local V = d.Seeder.GetOverrideTarget(G)
            if V ~= nil then return V end
            return math.max(math.floor(tonumber(Y.seed_place_default_target) or 10), 1)
        end
        local function E()
            if G == "" then return end
            V = g()
            Z = true
            if c then
                c:SetValue(tostring(V))
                c:SetText(string.format("\240\159\142\175 Target Amount: <font color=\'#7CFC00\'>%d</font>", V))
            end
            if T then T:SetValue(d.Seeder.GetOverrideTarget(G) ~= nil) end
            Z = false
        end
        local a
        a = function()
            q()
            i += 1
            local V = {}
            if type(Y.seed_place_overrides) == "table" then
                for G in pairs(Y.seed_place_overrides) do
                    if d.Seeder.GetOverrideTarget(G) ~= nil then
                        table.insert(V, G)
                    end
                end
            end
            table.sort(V)
            if #V == 0 then
                local G = y:AddLabel({ Text = "<font color=\'#888888\'>No active seed overrides</font>", DoesWrap = true })
                table.insert(j, G)
            else
                for V, Z in ipairs(V) do
                    local c = d.Seeder.GetOverrideTarget(Z)
                    local J
                    J = y:AddToggle(string.format("seed_active_override_%d_%d", i, V),
                        {
                            Text = string.format("\240\159\140\177 %s <font color=\'#7CFC00\'>Target: %d</font>", Z, c),
                            Default = true,
                            Tooltip =
                            "Disable this seed override.",
                            Callback = function(V)
                                if V then return end
                                d.Seeder.RemoveOverrideTarget(Z)
                                u.Save.SaveDataSync()
                                if G == Z then E() end
                                task.defer(a)
                            end
                        })
                    table.insert(j, J)
                end
            end
            if y.Resize then y:Resize() end
        end
        local H
        H = y:AddValueDropdown("seed_placer_override_seed",
            {
                Values = {},
                Default = "",
                Multi = false,
                Searchable = true,
                MaxVisibleDropdownItems = 10,
                Text =
                "\240\159\140\177 Select Seed",
                Tooltip = "Select a seed to configure its target.",
                Changed = function(V)
                    if type(V) ~= "string" or V == "" then return end
                    G = V
                    E()
                end
            })
        H:SetValues(d.SeedData.GetSeedDataListDropDown())
        c = y:AddInput("seed_placer_override_target",
            {
                Text = "\240\159\142\175 Target Amount",
                Default = tostring(V),
                Numeric = true,
                AllowEmpty = true,
                Finished = true,
                ClearTextOnFocus = false,
                Placeholder =
                "Enter target amount",
                Tooltip = "Sets how many of this seed should remain planted.",
                Callback = function(y)
                    if Z then return end
                    if G == "" then
                        J.Notify("Select a seed first", 3)
                        return
                    end
                    local j = l(y)
                    if not j or j <= 0 then
                        J.Notify("Target must be above 0", 3)
                        E()
                        return
                    end
                    V = j
                    c:SetText(string.format("\240\159\142\175 Target Amount: <font color=\'#7CFC00\'>%d</font>", V))
                    if d.Seeder.GetOverrideTarget(G) ~= nil then
                        d.Seeder.SetOverrideTarget(G, V)
                        u.Save.SaveDataSync()
                        a()
                    end
                end
            })
        T = y:AddToggle("seed_placer_enable_selected_override",
            {
                Text = "\240\159\146\165 Enable Override",
                Default = false,
                Tooltip =
                "Use the custom target for the selected seed.",
                Callback = function(y)
                    if Z then return end
                    if G == "" then
                        Z = true
                        T:SetValue(false)
                        Z = false
                        J.Notify("Select a seed first", 3)
                        return
                    end
                    if y then
                        if not d.Seeder.SetOverrideTarget(G, V) then
                            Z = true
                            T:SetValue(false)
                            Z = false
                            J.Notify("Failed to enable override", 3)
                            return
                        end
                    else
                        d.Seeder.RemoveOverrideTarget(G)
                    end
                    u.Save.SaveDataSync()
                    E()
                    a()
                end
            })
        y:AddDivider()
        y:AddLabel({ Text = "= <font color=\'#7CFC00\'>Active Seed Overrides</font> =", DoesWrap = true })
        a()
    end
    if V then
        local G
        G = V:AddValueDropdown("seed_placer_selected_seeds",
            {
                Values = {},
                Default = {},
                Multi = true,
                Text = "\240\159\140\177 Seeds to Plant",
                Tooltip =
                "Only selected seeds will be planted.",
                Searchable = true,
                MaxVisibleDropdownItems = 10,
                Changed = function(
                    G)
                    if type(G) ~= "table" then return end
                    Y.allowed_seedsplace = G
                    u.Save.SaveDataSync()
                end
            })
        G:SetValues(d.SeedData.GetSeedDataListDropDown())
        G:SetValue(Y.allowed_seedsplace)
        local y = V:AddButton({
            Text = "\226\156\133 All",
            Tooltip = "Selects every seed.",
            Func = function()
                Y.allowed_seedsplace = d.Seeder.GetAllSeedSelection()
                G:SetValue(Y.allowed_seedsplace)
                u.Save.SaveDataSync()
            end
        })
        y:AddButton({
            Text = "\240\159\167\185 Clear",
            Tooltip = "Clears the selected seeds.",
            Func = function()
                Y.allowed_seedsplace = {}
                G:SetValue({})
                u.Save.SaveDataSync()
            end
        })
        V:AddDivider()
        local Z
        local j = "\240\159\142\175 Target Plants"
        Z = V:AddInput("seed_placer_default_target",
            {
                Text = j,
                Default = tostring(Y.seed_place_default_target),
                Numeric = true,
                AllowEmpty = true,
                Finished = true,
                ClearTextOnFocus = false,
                Placeholder =
                "Plants per selected seed",
                Tooltip = "Plants each selected seed until this amount is on your farm.",
                Callback = function(
                    G)
                    local V = l(G)
                    if not V or V <= 0 then
                        J.Notify("Target must be a whole number above 0", 3)
                        Z:SetValue(tostring(Y.seed_place_default_target))
                        return
                    end
                    Y.seed_place_default_target = V
                    u.Save.SaveDataSync()
                    Z:SetText("\226\156\133 <font color=\'#00FF00\'>Target Updated</font>")
                    task.delay(1.5, function() if Z then Z:SetText(j) end end)
                end
            })
        local i
        local c = "\240\159\140\179 Maximum Garden Plants"
        i = V:AddInput("seed_placer_max_garden_plants",
            {
                Text = c,
                Default = tostring(Y.seed_place_max_garden_plants),
                Numeric = true,
                AllowEmpty = true,
                Finished = true,
                ClearTextOnFocus = false,
                Placeholder =
                "Maximum plants in garden",
                Tooltip = "Stops placing seeds when the garden reaches this amount.",
                Callback = function(
                    G)
                    local V = l(G)
                    if not V or V < 0 then
                        J.Notify("Maximum plants must be 0 or above", 3)
                        i:SetValue(tostring(Y.seed_place_max_garden_plants))
                        return
                    end
                    Y.seed_place_max_garden_plants = V
                    u.Save.SaveDataSync()
                    i:SetText("\226\156\133 <font color=\'#00FF00\'>Garden Limit Updated</font>")
                    task.delay(1.5, function() if i then i:SetText(c) end end)
                end
            })
        local T
        local q = "\226\154\161 Delay Between Placements"
        T = V:AddInput("seed_placer_delay",
            {
                Text = q,
                Default = tostring(Y.seed_place_delay),
                Numeric = true,
                AllowEmpty = true,
                Finished = true,
                ClearTextOnFocus = false,
                Placeholder =
                "Example: 0.3",
                Tooltip = "Lower values place seeds faster. Minimum 0.05 seconds.",
                Callback = function(G)
                    local V = B(G)
                    if not V or V < .05 then
                        J.Notify("Delay must be 0.05 seconds or more", 3)
                        T:SetValue(tostring(Y.seed_place_delay))
                        return
                    end
                    Y.seed_place_delay = V
                    u.Save.SaveDataSync()
                    T:SetText("\226\156\133 <font color=\'#00FF00\'>Delay Updated</font>")
                    task.delay(1.5, function() if T then T:SetText(q) end end)
                end
            })
        V:AddDivider()
        local g
        g = V:AddDropdown("seed_placer_mode",
            {
                Values = { "Random", "Farm Middle", "Saved Position" },
                Default = Y.seed_place_mode,
                Multi = false,
                Text =
                "\240\159\147\141 Placement Mode",
                Tooltip = "Choose where selected seeds will be planted.",
                Callback = function(
                    G)
                    if type(G) ~= "string" or G == "" then return end
                    Y.seed_place_mode = G
                    u.Save.SaveDataSync()
                end
            })
        g:SetValue(Y.seed_place_mode)
        local E = V:AddLabel({ Text = d.Seeder.GetSavedPositionText(), DoesWrap = true })
        V:AddButton({
            Text = "\240\159\147\140 Save Current Position",
            Tooltip =
            "Stand inside your farm where seeds should be planted.",
            Func = function()
                local G, V = d.Seeder.SaveCurrentPosition()
                J.Notify(V, 3)
                if G then
                    Y.seed_place_mode = "Saved Position"
                    g:SetValue("Saved Position")
                    if E then E:SetText(d.Seeder.GetSavedPositionText()) end
                    u.Save.SaveDataSync()
                end
            end
        })
        V:AddDivider()
        V:AddToggle("seed_placer_wall_mode",
            {
                Text = "\240\159\167\177 Wall Mode",
                Default = Y.seed_place_wall_mode,
                Tooltip =
                "Random mode starts around the outside of both plant areas and fills inward.",
                Callback = function(G)
                    Y.seed_place_wall_mode = G
                    u.Save.SaveDataSync()
                end
            })
        V:AddDivider()
        V:AddToggle("seed_placer_stack_mode",
            {
                Text = "\240\159\167\188 Layers Stack Mode",
                Default = Y.seed_place_stack_mode,
                Tooltip =
                "Saved Position / Farm Middle modes places plants in closely stacked layers.",
                Callback = function(G)
                    Y.seed_place_stack_mode = G
                    d.Seeder.StackIndex = 0
                    u.Save.SaveDataSync()
                end
            })
        V:AddToggle("seed_placer_stack_modeunderground",
            {
                Text = "\240\159\145\189 Stack Underground",
                Default = Y.seed_place_stack_mode_underground,
                Tooltip =
                "Saved Position / Farm Middle mode Will stack Underground",
                Callback = function(G)
                    Y.seed_place_stack_mode_underground = G
                    d.Seeder.StackIndex = 0
                    u.Save.SaveDataSync()
                end
            })
        V:AddDivider()
        V:AddToggle("enable_seed_placer",
            {
                Text = "\240\159\140\177 Enable Seed Placer",
                Default = Y.auto_seedplace,
                Tooltip =
                "Continuously plants selected seeds up to their target amount.",
                Callback = function(G)
                    Y.auto_seedplace = G
                    if not G then d.Seeder.ClearStatus() end
                    u.Save.SaveDataSync()
                end
            })
    end
end
J.PetUi = function()
    local G = j:AddTab({ Name = "Pet Snipe " .. J.GetProLabel(), Description = "Buy pets on the farm.", Icon = "store" })
    local V = G:AddLeftGroupbox("Pet Finder Premium", "paw-print")
    local y = G:AddRightGroupbox("Pet Farm Return", "map-pinned")
    local Z = G:AddRightGroupbox("Pet Buy List", "list-plus")
    local i = G:AddLeftGroupbox("Last Purchases", "history")
    if Z then
        local G = ""
        local V = 1
        local y = {}
        local j = {}
        local i = false
        local c = {}
        local T = 0
        local q
        local g
        local E
        local a
        local H
        if not J.GetCheckIfPro() then Z:AddLabel({ Text = J.GetProMessage(), DoesWrap = true }) end
        Z:AddLabel({ Text = "\240\159\146\161 Empty size or variant selection means any.", DoesWrap = true })
        local function r()
            for G, V in ipairs(c) do if V.Holder and typeof(V.Holder) == "Instance" then V.Holder:Destroy() end end
            table.clear(c)
            if Z.Resize then Z:Resize() end
        end
        local function Y(G)
            if type(G) ~= "table" or next(G) == nil then return "Any" end
            local V = {}
            for G, y in pairs(G) do if y == true then table.insert(V, G) end end
            table.sort(V)
            return #V > 0 and table.concat(V, ", ") or "Any"
        end
        local function e()
            if i or G == "" or not d.PetFinderPremium.HasRule(G) then return end
            local Z = d.PetFinderPremium.GetRule(G)
            d.PetFinderPremium.SetRule(G, V, y, j, Z and Z.enabled)
            u.Save.SaveDataSync()
        end
        local function s()
            if G == "" then return end
            local Z = d.PetFinderPremium.GetRule(G)
            V = Z and Z.target or 1
            y = Z and Z.sizes or {}
            j = Z and Z.variants or {}
            i = true
            g:SetValues(d.PetFinderPremium.GetSizeValues())
            g:SetValue(y)
            E:SetValues(d.PetFinderPremium.GetVariantValues())
            E:SetValue(j)
            a:SetValue(tostring(V))
            a:SetText(string.format("\240\159\142\175 Target Amount: <font color=\'#7CFC00\'>%d</font>", V))
            H:SetValue(Z and Z.enabled or false)
            i = false
        end
        local N
        N = function()
            r()
            T += 1
            local V = d.PetFinderPremium.GetActiveRuleNames()
            if #V == 0 then
                local G = Z:AddLabel({ Text = "<font color=\'#888888\'>No active pet buy rules</font>", DoesWrap = true })
                table.insert(c, G)
            else
                for V, y in ipairs(V) do
                    local j = d.PetFinderPremium.GetRule(y)
                    local i = j and d.PetFinderPremium.CountOwnedForRule(y, j) or 0
                    local J
                    J = Z:AddToggle(string.format("pet_finder_active_rule_%d_%d", T, V),
                        {
                            Text = string.format(
                                "\240\159\144\190 %s <font color=\'#7CFC00\'>%d/%d</font>\n<font color=\'#CFCFCF\'>Sizes: %s | Variants: %s</font>",
                                d.PetFinderPremium.GetDisplayName(y), i, j.target, Y(j.sizes), Y(j.variants)),
                            Default = true,
                            Tooltip =
                            "Disable this pet buy rule.",
                            Callback = function(V)
                                if V then return end
                                d.PetFinderPremium.SetRuleEnabled(y, false)
                                u.Save.SaveDataSync()
                                if G == y then s() end
                                task.defer(N)
                            end
                        })
                    table.insert(c, J)
                end
            end
            if Z.Resize then Z:Resize() end
        end
        q = Z:AddValueDropdown("pet_finder_premium_pet_ui",
            {
                Values = {},
                Default = "",
                Multi = false,
                Searchable = true,
                MaxVisibleDropdownItems = 10,
                Text =
                "\240\159\144\190 Select Pet",
                Tooltip = "Select a pet to add or edit.",
                Changed = function(V)
                    if type(V) ~= "string" or V == "" then return end
                    G = V
                    s()
                end
            })
        q:SetValues(d.PetFinderPremium.GetPetDropdown())
        g = Z:AddValueDropdown("pet_finder_premium_sizes_ui",
            {
                Values = {},
                Default = {},
                Multi = true,
                Searchable = true,
                MaxVisibleDropdownItems = 10,
                Text =
                "\240\159\147\143 Pet Sizes",
                Tooltip = "Leave empty to buy any size.",
                Changed = function(G)
                    if i or type(G) ~= "table" then return end
                    y = G
                    e()
                    N()
                end
            })
        g:SetValues(d.PetFinderPremium.GetSizeValues())
        E = Z:AddValueDropdown("pet_finder_premium_variants_ui",
            {
                Values = {},
                Default = {},
                Multi = true,
                Searchable = true,
                MaxVisibleDropdownItems = 10,
                Text =
                "\240\159\140\136 Pet Variants",
                Tooltip = "Leave empty to buy Normal or Rainbow pets.",
                Changed = function(
                    G)
                    if i or type(G) ~= "table" then return end
                    j = G
                    e()
                    N()
                end
            })
        E:SetValues(d.PetFinderPremium.GetVariantValues())
        a = Z:AddInput("pet_finder_premium_target_ui",
            {
                Text = "\240\159\142\175 Target Amount",
                Default = "999",
                Numeric = true,
                AllowEmpty = true,
                Finished = true,
                ClearTextOnFocus = false,
                Placeholder =
                "Owned target amount",
                Tooltip = "Stops buying this pet when the matching inventory amount is reached.",
                Callback = function(
                    y)
                    if i then return end
                    if G == "" then
                        J.Notify("Select a pet first", 3)
                        return
                    end
                    local Z = l(y)
                    if not Z or Z <= 0 then
                        J.Notify("Target must be above 0", 3)
                        s()
                        return
                    end
                    V = Z
                    a:SetText(string.format("\240\159\142\175 Target Amount: <font color=\'#7CFC00\'>%d</font>", V))
                    e()
                    N()
                end
            })
        H = Z:AddToggle("pet_finder_premium_rule_enabled_ui",
            {
                Text = "\226\158\149 Enable Buy Rule",
                Default = false,
                Tooltip =
                "Adds the selected pet settings to the active buy list.",
                Callback = function(Z)
                    if i then return end
                    if G == "" then
                        i = true
                        H:SetValue(false)
                        i = false
                        J.Notify("Select a pet first", 3)
                        return
                    end
                    if Z then
                        if not d.PetFinderPremium.SetRule(G, V, y, j, true) then
                            i = true
                            H:SetValue(false)
                            i = false
                            J.Notify("Failed to enable pet rule", 3)
                            return
                        end
                    else
                        d.PetFinderPremium.SetRuleEnabled(G, false)
                    end
                    u.Save.SaveDataSync()
                    s()
                    N()
                end
            })
        Z:AddDivider()
        Z:AddLabel({ Text = "= <font color=\'#7CFC00\'>Active Pet Buy List</font> =", DoesWrap = true })
        J.PetFinderPremiumUi.RefreshRules = N
        J.PetFinderPremiumUi.RefreshValues = function()
            i = true
            g:SetValues(d.PetFinderPremium.GetSizeValues())
            E:SetValues(d.PetFinderPremium.GetVariantValues())
            g:SetValue(y)
            E:SetValue(j)
            i = false
        end
        N()
    end
    if i then
        local G = {}
        local function V()
            for G, V in ipairs(G) do if V.Holder and typeof(V.Holder) == "Instance" then V.Holder:Destroy() end end
            table.clear(G)
            if i.Resize then i:Resize() end
        end
        local function y()
            V()
            local y = type(Y.pet_finder_purchase_log) == "table" and Y.pet_finder_purchase_log or {}
            if #y == 0 then
                local V = i:AddLabel({ Text = "<font color=\'#888888\'>No pet purchases recorded</font>", DoesWrap = true })
                table.insert(G, V)
            else
                for V, y in ipairs(y) do
                    local Z = tonumber(y.purchased_at) and os.date("%d/%m %H:%M", y.purchased_at) or "Unknown time"
                    local j = i:AddLabel({
                        Text = string.format(
                            "\240\159\144\190 %s %s %s | <font color=\'#7CFC00\'>%s</font> | %s",
                            tostring(y.size or "Normal"),
                            tostring(y.variant or "Normal"), tostring(y.display_name or y.pet or "Unknown"),
                            c.formatShecklesNumber(y.price), Z),
                        DoesWrap = true
                    })
                    table.insert(G, j)
                end
            end
            if i.Resize then i:Resize() end
        end
        i:AddButton({
            Text = "\240\159\167\185 Clear Purchase Log",
            Tooltip = "Clears the saved pet purchase history.",
            Func = function()
                Y.pet_finder_purchase_log = {}
                u.Save.SaveDataSync()
                y()
            end
        })
        J.PetFinderPremiumUi.RefreshLog = y
        y()
    end
    if V then
        V:AddLabel({ Text = "\240\159\144\190 Watches new wild pets and buys pets that match your enabled rules.", DoesWrap = true })
        local function G()
            return string.format(
                "\226\143\177\239\184\143 Hop Timer <font color=\'#3CB371\'>(%dm)</font>",
                d.PetFinderPremium.GetHopMinutes())
        end
        local y
        y = V:AddInput("pet_finder_premium_hop_minutes_ui",
            {
                Text = G(),
                Default = tostring(Y.pet_finder_hop_minutes),
                Numeric = true,
                AllowEmpty = true,
                Finished = true,
                ClearTextOnFocus = false,
                Placeholder =
                "Minimum 1 minute",
                Tooltip = "How long to watch the current server before hopping.",
                Callback = function(V)
                    local Z = l(V)
                    if not Z or Z < 1 then
                        J.Notify("Hop timer must be 1 minute or more", 3)
                        y:SetValue(tostring(Y.pet_finder_hop_minutes))
                        return
                    end
                    Y.pet_finder_hop_minutes = Z
                    y:SetText(G())
                    d.PetFinderPremium.ResetHopTimer()
                    u.Save.SaveDataSync()
                end
            })
        V:AddToggle("pet_finder_premium_auto_hop_ui",
            {
                Text = "\240\159\154\128 Auto Hop Server",
                Default = Y.pet_finder_auto_hop,
                Tooltip =
                "Hops after the selected watch timer when no matching pet is ready.",
                Callback = function(G)
                    Y.pet_finder_auto_hop = G
                    d.PetFinderPremium.ResetHopTimer()
                    u.Save.SaveDataSync()
                end
            })
        local Z
        Z = V:AddToggle("pet_finder_premium_enabled_ui",
            {
                Text = "\240\159\144\190 Enable Pet Finder Premium",
                Default = Y.pet_finder_enabled,
                Tooltip =
                "Automatically buys pets from your enabled buy list.",
                DisabledTooltip = J.GetProMessage(),
                Callback = function(
                    G)
                    Y.pet_finder_enabled = G
                    if G then
                        d.PetFinderPremium.ResetHopTimer()
                        d.PetFinderPremium.FullScan()
                    else
                        d.PetFinderPremium.ClearStatus()
                        d.Teleport.UnlockTeleport(J.TeleportLockNames.PetFinderPremium)
                    end
                    u.Save.SaveDataSync()
                end
            })
        Z:SetDisabled(not J.GetCheckIfPro())
    end
    if y then
        y:AddLabel({ Text = "\240\159\144\190 Returns you to the farm centre when you are too far away.", DoesWrap = true })
        local function G()
            return string.format(
                "\226\143\177\239\184\143 Return Timer <font color=\'#3CB371\'>(%ss)</font>", d.PetFarmReturn.GetTimer())
        end
        local V
        V = y:AddInput("pet_return_farm_timer_ui",
            {
                Text = G(),
                Default = tostring(Y.pet_return_farm_timer),
                Numeric = true,
                AllowEmpty = true,
                Finished = true,
                ClearTextOnFocus = false,
                Placeholder =
                "Minimum 3 seconds",
                Tooltip = "How often to check if you are too far from the farm.",
                Callback = function(y)
                    local Z = l(y)
                    if not Z or Z < 3 then
                        J.Notify("Timer must be 3 seconds or more", 3)
                        V:SetValue(tostring(Y.pet_return_farm_timer))
                        return
                    end
                    Y.pet_return_farm_timer = Z
                    V:SetText(G())
                    d.PetFarmReturn.ResetTimer()
                    u.Save.SaveDataSync()
                end
            })
        y:AddToggle("pet_return_farm_enabled_ui",
            {
                Text = "\240\159\143\161 Enable Farm Return",
                Default = Y.pet_return_farm,
                Tooltip =
                "Returns you to the farm centre when you are more than 20 studs away.",
                Callback = function(G)
                    Y.pet_return_farm = G
                    if G then d.PetFarmReturn.ResetTimer() else J.PetFarmStatusText = "" end
                    u.Save.SaveDataSync()
                end
            })
    end
end
J.CollectUi = function()
    local G = j:AddTab({ Name = "Fruit Collect", Description = "Fruit Collection", Icon = "store" })
    local V = G:AddLeftGroupbox("Fruit Collector", "badge-dollar-sign")
    if V then
        local G
        G = V:AddValueDropdown("dd_collect_frutisx22",
            {
                Values = {},
                Default = {},
                Multi = true,
                Text = "\240\159\140\177 Collect Fruits",
                Tooltip =
                "Selected Fruits will be collected if they are ready.",
                Searchable = true,
                MaxVisibleDropdownItems = 10,
                Changed = function(
                    G)
                    if not G then return end
                    Y.collect_fruit_list = G
                    d.FruitCollect.ResetBucket()
                    u.Save.SaveDataSync()
                end
            })
        G:SetValues(d.SeedData.GetSeedDataListDropDown())
        G:SetValue(Y.collect_fruit_list)
        V:AddToggle("collection_teleportcollect",
            {
                Text = "<font color=\'#FFFFFF\'>\240\159\147\161 Auto Teleport</font>",
                Default = Y.collection_teleport,
                Tooltip =
                "Teleports back to your garden if you are out of collection range.",
                Callback = function(G)
                    Y.collection_teleport = G
                    u.Save.SaveData()
                end
            })
        V:AddToggle("enablefruitcollector",
            {
                Text = "<font color=\'#CF02B0\'>Enable Fruit Collector</font>",
                Default = Y.auto_collect_fruit_enabled,
                Tooltip =
                "Collects frutis and teleports you to the farm.",
                Callback = function(G)
                    Y.auto_collect_fruit_enabled = G
                    d.FruitCollect.ResetBucket()
                    u.Save.SaveData()
                end
            })
    end
end
J.Shopui = function()
    local G = j:AddTab({ Name = "Shop", Description = "Shop", Icon = "store" })
    local V = G:AddLeftGroupbox("Seed Shop", "badge-dollar-sign")
    local y = G:AddLeftGroupbox("Gear Shop", "badge-dollar-sign")
    if y then
        y:AddLabel({
            Text =
            "\226\132\185\239\184\143 Auto buys all gear. If you don\'t want to buy a gear. Select it in the list below.",
            DoesWrap = true
        })
        local G
        G = y:AddValueDropdown("avoidgearshopbuy1",
            {
                Values = {},
                Default = {},
                Multi = true,
                Text = "\226\154\160\239\184\143 Don\'t Buy Selected",
                Tooltip =
                "Selected seeds will not be purchased.",
                Searchable = true,
                MaxVisibleDropdownItems = 10,
                Changed = function(
                    G)
                    if not G then return end
                    Y.gear_shop_avoid = G
                    u.Save.SaveDataSync()
                end
            })
        G:SetValues(d.GearData.GetGearShopDropDown())
        G:SetValue(Y.gear_shop_avoid)
        y:AddToggle("dd_gearshop-enabled",
            {
                Text = "<font color=\'#FFFFFF\'>\240\159\148\171 Enable Gear Shop</font>",
                Default = Y.enabled_gear_shop,
                Tooltip =
                "When enabled, buys from the gear shop.",
                Callback = function(G)
                    Y.enabled_gear_shop = G
                    u.Save.SaveData()
                end
            })
    end
    if V then
        V:AddLabel({
            Text =
            "\226\132\185\239\184\143 Auto buys all seeds. If you don\'t want to buy a seed. Select it in the list below.",
            DoesWrap = true
        })
        local G
        G = V:AddValueDropdown("avoidseeds_seedshop",
            {
                Values = {},
                Default = {},
                Multi = true,
                Text = "\226\154\160\239\184\143 Don\'t Buy Selected",
                Tooltip =
                "Selected seeds will not be purchased.",
                Searchable = true,
                MaxVisibleDropdownItems = 10,
                Changed = function(
                    G)
                    if not G then return end
                    Y.seed_avoid = G
                    u.Save.SaveDataSync()
                end
            })
        G:SetValues(d.SeedData.GetSeedShopDropDown())
        G:SetValue(Y.seed_avoid)
        V:AddToggle("seedshopautobuyenabled",
            {
                Text = "<font color=\'#FFFFFF\'>\240\159\140\177 Enable Seed Shop</font>",
                Default = Y.enabled_seed_shop,
                Tooltip =
                "If enabled buys the seed shop.",
                Callback = function(G)
                    Y.enabled_seed_shop = G
                    u.Save.SaveData()
                end
            })
    end
end
J.SellingUi = function()
    local G = j:AddTab({ Name = "Sell Fruits", Description = "Selling", Icon = "store" })
    local V = G:AddLeftGroupbox("Auto Sell", "badge-dollar-sign")
    if V then
        V:AddToggle("auto_use_daily_deal_ui",
            {
                Text = "\226\173\144 Save & Use Daily Deal",
                Default = Y.auto_use_daily_deal,
                Tooltip =
                "Saves the Daily Deal until your fruit backpack is full.",
                Callback = function(G)
                    Y.auto_use_daily_deal = G
                    d.SellManager.DailyDealNextCheckAt = 0
                    u.Save.SaveDataSync()
                end
            })
        V:AddToggle("sell_when_backpack_full_ui",
            {
                Text = "\240\159\142\146 Sell When Backpack Is Full",
                Default = Y.sell_when_backpack_full,
                Tooltip =
                "Automatically sells all fruits when your backpack is full.",
                Callback = function(G)
                    Y.sell_when_backpack_full = G
                    u.Save.SaveDataSync()
                end
            })
        V:AddToggle("autopsellfruitsturbo",
            {
                Text = "<font color=\'#CF02B0\'>\226\154\161 Turbo Sell</font>",
                Default = Y.turbo_sell,
                Tooltip =
                "Sells really fast",
                Callback = function(G)
                    Y.turbo_sell = G
                    u.Save.SaveData()
                end
            })
        V:AddToggle("autopsellfruits",
            {
                Text = "<font color=\'#CF02B0\'>\240\159\146\176 Enable Auto Sell</font>",
                Default = Y
                    .auto_sell_sellallinventory,
                Tooltip = "Sells all your fruits.",
                Callback = function(G)
                    Y.auto_sell_sellallinventory = G
                    u.Save.SaveData()
                end
            })
    end
end
c.is_dex_loaded = false
c.LoadDexTool = function()
    if c.is_dex_loaded then return end
    local G, V = pcall(function()
        (loadstring(game:HttpGet("https://github.com/BOXLEGENDARY/Dex/releases/latest/download/out.lua")))()
        c.is_dex_loaded = true
    end)
end
c.is_spy_loaded = false
c.LoadSpyTool = function()
    if c.is_spy_loaded then return end
    local G, V = pcall(function()
        (loadstring(game:HttpGet("https://github.com/notpoiu/cobalt/releases/latest/download/Cobalt.luau")))()
        c.is_spy_loaded = true
    end)
end
J.WebhooksUi = function()
    local G = j:AddTab({ Name = "Webhooks", Description = "Webhook notifications", Icon = "webhook" })
    local V = G:AddRightGroupbox("Notifications", "bell-ring")
    local y = G:AddLeftGroupbox("Webhook URL", "link")
    if V then
        V:AddToggle("webhook_event_seed_notifications",
            {
                Text = "\240\159\140\136 Gold & Rainbow Seeds",
                Default = Y.webhook_event_seeds,
                Tooltip =
                "Send a notification when you collect a Gold or Rainbow Seed.",
                Callback = function(G)
                    Y.webhook_event_seeds = G
                    if not G then table.clear(J.EventSeed_WebhookData) end
                    u.Save.SaveDataSync()
                end
            })
        V:AddToggle("webhook_pet_buy_notifications",
            {
                Text = "\240\159\144\190 Pet Purchases",
                Default = Y.webhook_pet_buys,
                Tooltip =
                "Send a notification after a pet purchase is confirmed.",
                Callback = function(G)
                    Y.webhook_pet_buys = G
                    if not G then
                        if type(J.PetFinder_WebhookData) == "table" then table.clear(J.PetFinder_WebhookData) end
                        d.Webhooks.ClearStatus()
                    end
                    u.Save.SaveDataSync()
                end
            })
        V:AddToggle("webhook_mail_manual_notifications",
            {
                Text = "\240\159\147\166 Manual Orders Completed",
                Default = Y.webhook_mail_manual,
                Tooltip =
                "Send a notification when a manual order is fully delivered.",
                Callback = function(G)
                    Y.webhook_mail_manual = G
                    if not G then d.Webhooks.RemoveMailType("manual") end
                    u.Save.SaveDataSync()
                end
            })
        V:AddToggle("webhook_mail_auto_notifications",
            {
                Text = "\226\154\153\239\184\143 Automatic Mail Sent",
                Default = Y.webhook_mail_auto,
                Tooltip =
                "Send a notification after an automatic mail cycle completes.",
                Callback = function(G)
                    Y.webhook_mail_auto = G
                    if not G then d.Webhooks.RemoveMailType("automatic") end
                    u.Save.SaveDataSync()
                end
            })
        V:AddToggle("webhook_mail_claim_notifications",
            {
                Text = "\240\159\147\165 Incoming Mail Claimed",
                Default = Y.webhook_mail_claims,
                Tooltip =
                "Send a notification after incoming mail is claimed.",
                Callback = function(G)
                    Y.webhook_mail_claims = G
                    if not G then d.Webhooks.RemoveMailType("claim") end
                    u.Save.SaveDataSync()
                end
            })
    end
    if y then
        y:AddLabel({ Text = "\240\159\148\151 Notifications will be posted to this URL.", DoesWrap = true })
        local G
        G = y:AddInput("webhook_url_input",
            {
                Text = "\240\159\148\151 Webhook URL",
                Default = tostring(Y.webhook_url or ""),
                Numeric = false,
                AllowEmpty = true,
                Finished = false,
                ClearTextOnFocus = false,
                Placeholder =
                "https://your-webhook-url",
                Tooltip = "Enter the URL that will receive notifications.",
                Callback = function(
                    V)
                    local y = (tostring(V or "")):match("^%s*(.-)%s*$") or ""
                    if y ~= "" and not d.Webhooks.IsValidUrl(y) then
                        J.Notify("Enter a valid HTTP or HTTPS webhook URL", 3)
                        G:SetValue(tostring(Y.webhook_url or ""))
                        return
                    end
                    Y.webhook_url = y
                    u.Save.SaveDataSync()
                    if y == "" then J.Notify("Webhook URL cleared", 2) else J.Notify("Webhook URL saved", 2) end
                end
            })
        y:AddToggle("webhook_enabled",
            {
                Text = "Enable Webhooks",
                Default = Y.webhook_enabled,
                Tooltip =
                "Enable or disable all webhook notifications",
                Callback = function(G)
                    Y.webhook_enabled = G
                    if not G then
                        table.clear(J.PetFinder_WebhookData)
                        table.clear(J.Mail_WebhookData)
                        table.clear(J.EventSeed_WebhookData)
                        d.Webhooks.ClearStatus()
                    end
                    u.Save.SaveDataSync()
                end
            })
    end
end
J.SettingsUi = function()
    local G = j:AddTab({ Name = "Settings", Description = "Settings", Icon = "settings" })
    local V = G:AddLeftGroupbox("Dev Tools", "align-center-horizontal")
    local Z = G:AddRightGroupbox("<uc>Data</uc>", "blocks")
    local i = G:AddLeftGroupbox("Required", "shield-check")
    local T = G:AddLeftGroupbox("Performance", "gauge")
    local q = G:AddRightGroupbox("Player UI", "blocks")
    if q then
        q:AddToggle("hideplayerstats",
            {
                Text = "\226\132\185\239\184\143 Hide Exo Stats",
                Default = Y.hide_log_ui,
                Tooltip =
                "Hides the stats info for systems.",
                Callback = function(G)
                    Y.hide_log_ui = G
                    u.Save.SaveDataSync()
                end
            })
        q:AddToggle("hide_player_ui_toggle",
            {
                Text = "\240\159\145\129\239\184\143 Hide Plot & Teleport UI",
                Default = Y.hide_player_ui,
                Tooltip =
                "Hides the plot panels and teleport buttons.",
                Callback = function(G)
                    Y.hide_player_ui = G
                    d.PlayerUI.Apply()
                    u.Save.SaveDataSync()
                end
            })
    end
    if T then
        T:AddToggle("hide_plant_models_ui",
            {
                Text = "Hide Plant Models",
                Default = Y.hide_plant_models,
                Tooltip =
                "Hides plant models to reduce game lag. Automation will continue working.",
                Callback = function(G)
                    Y.hide_plant_models = G
                    u.Save.SaveDataSync()
                end
            })
    end
    if i then
        i:AddToggle("auto_idle_touch_ui",
            {
                Text = "\240\159\145\134 Idle Activity",
                Default = Y.auto_idle_touch,
                Tooltip =
                "Simulates activity after three minutes without user input.",
                Callback = function(G)
                    Y.auto_idle_touch = G
                    J.ExoAutoTouch.ResetTimer()
                    u.Save.SaveDataSync()
                end
            })
    end
    if Z then
        local G = nil
        local V = ""
        local j = Z:AddDropdown("ddDatalistsdsx1",
            {
                Values = {},
                Default = {},
                Multi = false,
                Searchable = true,
                MaxVisibleDropdownItems = 10,
                Text =
                "\240\159\148\146 Select Key",
                Tooltip = "Reads data based on key",
                Callback = function(Z)
                    if Z == nil then return end
                    V = Z
                    local j = d.DataReplica.GetData(Z)
                    local i = y.HttpService:JSONEncode(j)
                    if G then G:SetText(i) end
                end
            })
        Z:AddButton({
            Text = "Copy",
            Func = function()
                if V == "" or V == nil then return end
                local G = d.DataReplica.GetData(V)
                if G then
                    local Z = y.HttpService:JSONEncode(G)
                    local j = string.format("%s \n%s", V, Z)
                    c.CopyToClipBoard(j)
                end
            end
        })
        G = Z:AddLabel({ Text = "--", DoesWrap = true })
        j:SetValues(d.DataReplica.AllBigDataKeys)
    end
    if V then
        local G = V:AddButton({ Text = "DEX", Func = function() c.LoadDexTool() end })
        local y = V:AddButton({ Text = "SPY", Func = function() c.LoadSpyTool() end })
        V:AddDivider()
        V:AddDivider()
        V:AddDivider()
    end
end
J.TweaksUi = function()
    local G = j:AddTab({ Name = "Tweaks", Description = "Customise system behaviour", Icon = "sliders-horizontal" })
    local V = G:AddLeftGroupbox("Movement", "move")
    if V then
        V:AddSlider("step_teleport_speed_ui",
            {
                Text = "Step Teleport Speed",
                Default = math.clamp(tonumber(Y.step_teleport_speed) or 100, 25, 500),
                Min = 25,
                Max = 500,
                Rounding = 0,
                Suffix =
                "%",
                Tooltip = "Higher values travel faster. Very high speeds may cause movement correction.",
                Callback = function(
                    G)
                    local V = math.clamp(tonumber(G) or 100, 25, 500)
                    Y.step_teleport_speed = V
                    d.StepTeleport.StepDelay = .35 * ((100 / V))
                    u.Save.SaveDataSync()
                end
            })
        V:AddLabel({ Text = "100% is the recommended default speed.", DoesWrap = true })
    end
end
J.InitUi = function()
    J.HomeDashboardUi()
    J.PremiumUi()
    J.MailUi()
    J.PlantsUi()
    J.AutoUi()
    J.PetUi()
    J.GardenItemsUi()
    J.CollectUi()
    J.SellingUi()
    J.Shopui()
    J.WebhooksUi()
    J.SettingsUi()
    J.TweaksUi()
end
if Z and j then J.InitUi() end
d.Mail.MailLoopStart()
d.PetFinderPremium.Start()
d.LiveMapPetsApi.Start()
d.MoonPredictor.Start()
task.spawn(function()
    while true do
        task.wait(3)
        d.Webhooks.Loop()
    end
end)
task.spawn(function()
    while true do
        task.wait(1)
        d.PetFarmReturn.Loop()
    end
end)
task.spawn(function()
    while true do
        task.wait(5)
        E.SeedShop.SeedBuyerLoop()
        E.GearShop.GearShopLoop()
    end
end)
task.spawn(function() while true do task.wait(3) end end)
task.spawn(function()
    while true do
        task.wait(1)
        if J.TrowelRunning then
            d.Trowel.Loop()
        else
            d.WaterPlants.Loop()
            d.SprinklerPlacer.Loop()
            d.PlantShovel.LoopPlantShovel()
            d.ShovelFruits.LoopShovelFruits()
            d.Seeder.SeedPlaceLoop()
        end
    end
end)
task.spawn(function()
    while true do
        task.wait(.5)
        local G = {}
        if Y.auto_collect_fruit_enabled then
            local V = d.FruitCollect.GetTextCurrentInventoryFruitStats()
            table.insert(G, V)
        end
        if Y.auto_seedplace and J.SeedPlaceStatusText ~= "" then table.insert(G, J.SeedPlaceStatusText) end
        if Y.auto_sell_sellallinventory and (type(J.SellStatusText) == "string" and J.SellStatusText ~= "") then
            table
                .insert(G, J.SellStatusText)
        end
        if Y.pet_finder_enabled and (type(J.PetFinderPremiumStatusText) == "string" and J.PetFinderPremiumStatusText ~= "") then
            table.insert(G, J.PetFinderPremiumStatusText)
        end
        if d.Mail and type(d.Mail.RefreshManualUi) == "function" then d.Mail.RefreshManualUi() end
        if ((J.MailManualRunning or Y.mail_auto_send_enabled or Y.mail_auto_accept)) and (type(J.MailStatusText) == "string" and J.MailStatusText ~= "") then
            table.insert(G, J.MailStatusText)
        end
        if Y.auto_collect_fruit_enabled and not Y.collection_teleport then
            if d.FruitCollect.IsFarFromGarden() then
                local V = string.format(
                    "<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\226\143\184\239\184\143 [Out Of Garden]</font> <font color=\'%s\'> Fruit collector is paused.</font></stroke>",
                    "#FF88FF")
                table.insert(G, V)
            end
        end
        if Y.auto_shovel_plants then
            local V = J.PlantShovelStatusText
            if type(V) == "string" and V ~= "" then table.insert(G, V) end
        end
        if Y.auto_shovel_fruits then
            local V = J.ShovelStatusText
            if type(V) == "string" and V ~= "" then table.insert(G, V) end
        end
        if Y.auto_water_plants and (type(J.WaterPlantStatusText) == "string" and J.WaterPlantStatusText ~= "") then
            table
                .insert(G, J.WaterPlantStatusText)
        end
        if Y.auto_sprinkler_place and J.SprinklerPlaceStatusText ~= "" then table.insert(G, J.SprinklerPlaceStatusText) end
        if Y.moon_predictor_enabled and (type(J.MoonPredictorStatusText) == "string" and J.MoonPredictorStatusText ~= "") then
            table.insert(G, J.MoonPredictorStatusText)
        end
        if Y.pet_return_farm and J.PetFarmStatusText ~= "" then table.insert(G, J.PetFarmStatusText) end
        if J.TrowelRunning and (type(J.TrowelStatusText) == "string" and J.TrowelStatusText ~= "") then
            table.insert(G,
                J.TrowelStatusText)
        end
        local V = d.Teleport.GetLockStatusText()
        if V ~= "" then table.insert(G, V) end
        if Y.auto_expand_garden and (type(J.GardenExpandStatusText) == "string" and J.GardenExpandStatusText ~= "") then
            table.insert(G, J.GardenExpandStatusText)
        end
        if Y.webhook_enabled and (type(J.WebhookStatusText) == "string" and J.WebhookStatusText ~= "") then
            table.insert(
                G, J.WebhookStatusText)
        end
        if Y.hide_log_ui then table.clear(G) end
        a.RealTimeStats.updateStatusList(G)
    end
end)
J.IsHeadless = type(G.IsHeadless) == "function" and G.IsHeadless() == true
J.HeadlessUI = {
    Create = function()
        if not J.IsHeadless or not y.PlayerGui then return end
        local G = y.PlayerGui:FindFirstChild("ExoHeadlessGui")
        if G then G:Destroy() end
        local V = Instance.new("ScreenGui")
        V.Name = "ExoHeadlessGui"
        V.ResetOnSpawn = false
        V.IgnoreGuiInset = true
        V.DisplayOrder = 999999
        V.Parent = y.PlayerGui
        local Z = Instance.new("Frame")
        Z.Name = "Main"
        Z.AnchorPoint = Vector2.new(.5, 0)
        Z.Position = UDim2.new(.5, 0, 0, 5)
        Z.Size = UDim2.fromOffset(260, 34)
        Z.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        Z.BorderSizePixel = 0
        Z.Parent = V
        local j = Instance.new("UICorner")
        j.CornerRadius = UDim.new(0, 6)
        j.Parent = Z
        local i = Instance.new("TextLabel")
        i.BackgroundTransparency = 1
        i.Position = UDim2.fromOffset(10, 0)
        i.Size = UDim2.new(1, -130, 1, 0)
        i.Font = Enum.Font.GothamSemibold
        i.Text = "EXOHUB HEADLESS"
        i.TextColor3 = Color3.fromRGB(255, 255, 255)
        i.TextSize = 13
        i.TextXAlignment = Enum.TextXAlignment.Left
        i.Parent = Z
        local c = Instance.new("TextButton")
        c.Position = UDim2.new(1, -115, 0, 4)
        c.Size = UDim2.fromOffset(78, 26)
        c.BackgroundColor3 = Color3.fromRGB(45, 100, 185)
        c.BorderSizePixel = 0
        c.Font = Enum.Font.GothamSemibold
        c.Text = "Rejoin"
        c.TextColor3 = Color3.fromRGB(255, 255, 255)
        c.TextSize = 12
        c.Parent = Z
        local T = Instance.new("UICorner")
        T.CornerRadius = UDim.new(0, 5)
        T.Parent = c
        local d = Instance.new("TextButton")
        d.Position = UDim2.new(1, -32, 0, 4)
        d.Size = UDim2.fromOffset(28, 26)
        d.BackgroundColor3 = Color3.fromRGB(145, 45, 45)
        d.BorderSizePixel = 0
        d.Font = Enum.Font.GothamBold
        d.Text = "\195\151"
        d.TextColor3 = Color3.fromRGB(255, 255, 255)
        d.TextSize = 16
        d.Parent = Z
        local u = Instance.new("UICorner")
        u.CornerRadius = UDim.new(0, 5)
        u.Parent = d
        d.MouseButton1Click:Connect(function() V:Destroy() end)
        c.MouseButton1Click:Connect(function()
            if not c.Active then return end
            c.Active = false
            c.Text = "Joining..."
            local G = pcall(function() y.TeleportService:Teleport(game.PlaceId, y.LocalPlayer) end)
            if not G then
                c.Text = "Failed"
                task.wait(2)
                if c.Parent then
                    c.Text = "Rejoin"
                    c.Active = true
                end
            end
        end)
    end
}
J.HeadlessUI.Create()
J.ExoAutoTouch = {
    Enabled = true,
    Started = false,
    Interval = 300,
    InputHoldTime = .05,
    TouchMargin = 20,
    TouchId = 0,
    IdleTime = 180,
    LastInput =
        os.clock(),
    VirtualInputManager = game:GetService("VirtualInputManager"),
    SendMobileActivity = function()
        local G = workspace.CurrentCamera
        if not G then return false end
        local V = G.ViewportSize
        local y = J.ExoAutoTouch.TouchMargin
        local Z = y
        local j = math.max(y, V.Y - y)
        J.ExoAutoTouch.VirtualInputManager:SendTouchEvent(J.ExoAutoTouch.TouchId, Enum.UserInputState.Begin.Value, Z, j)
        task.wait(J.ExoAutoTouch.InputHoldTime)
        J.ExoAutoTouch.VirtualInputManager:SendTouchEvent(J.ExoAutoTouch.TouchId, Enum.UserInputState.End.Value, Z, j)
        return true
    end,
    SendPCActivity = function()
        local G = J.ExoAutoTouch.VirtualInputManager
        local V = Enum.KeyCode.F15
        G:SendKeyEvent(true, V, false, game)
        task.wait(J.ExoAutoTouch.InputHoldTime)
        G:SendKeyEvent(false, V, false, game)
        return true
    end,
    SendConsoleActivity = function()
        local G = J.ExoAutoTouch.VirtualInputManager
        local V = 0
        local y = Enum.KeyCode.ButtonL3
        G:HandleGamepadButtonInput(V, y, Enum.UserInputState.Begin.Value)
        task.wait(J.ExoAutoTouch.InputHoldTime)
        G:HandleGamepadButtonInput(V, y, Enum.UserInputState.End.Value)
        return true
    end,
    MarkActive = function()
        if c.UserDevice.IsMobile() then return J.ExoAutoTouch.SendMobileActivity() end
        if c.UserDevice.IsPC() then return J.ExoAutoTouch.SendPCActivity() end
        return J.ExoAutoTouch.SendConsoleActivity()
    end,
    ResetTimer = function() J.ExoAutoTouch.LastInput = os.clock() end,
    Start = function()
        if J.ExoAutoTouch.Started then return end
        J.ExoAutoTouch.Started = true
        J.ExoAutoTouch.ResetTimer()
        y.UserInputService.InputBegan:Connect(function() J.ExoAutoTouch.ResetTimer() end)
        task.spawn(function()
            while J.ExoAutoTouch.Started do
                task.wait(1)
                if not Y.auto_idle_touch then continue end
                if os.clock() - J.ExoAutoTouch.LastInput < J.ExoAutoTouch.IdleTime then continue end
                pcall(J.ExoAutoTouch.MarkActive)
                J.ExoAutoTouch.ResetTimer()
            end
        end)
    end,
    Stop = function() J.ExoAutoTouch.Started = false end
}
J.ExoAutoTouch.Start()
local m = time() + 90
while time() < m do
    local G = c.IsLoadingCompleted()
    if G == true then
        warn("Loading complete")
        break
    end
    task.wait(1)
end
J.SimulateRealMobileTap = function()
    if not d.PlayerData.GetLoadingScreenActive() then return end
    if not c.UserDevice.IsMobile() then return end
    local G = game:GetService("VirtualInputManager")
    local V = workspace.CurrentCamera
    if not V then return false end
    local y = V.ViewportSize
    if y.X <= 0 or y.Y <= 0 then return false end
    local Z = 35
    local j = Z
    local i = y.Y - Z
    return pcall(function()
        G:SendTouchEvent(1, 0, j, i)
        task.wait(.08)
        G:SendTouchEvent(1, 2, j, i)
    end)
end
J.SimulateScreenTapWithGui = function()
    if not d.PlayerData.GetLoadingScreenActive() then return end
    if not c.UserDevice.IsPC() then return end
    local G = game:GetService("VirtualInputManager")
    local V = workspace.CurrentCamera
    if not V then return false end
    local y = V.ViewportSize
    if y.X <= 0 or y.Y <= 0 then return false end
    local Z = 35
    local j = Z
    local i = y.Y - Z
    return pcall(function()
        G:SendMouseButtonEvent(j, i, 0, true, game, 1)
        task.wait(.05)
        G:SendMouseButtonEvent(j, i, 0, false, game, 1)
    end)
end
J.loading_check_started = time() + 90
while time() < J.loading_check_started do
    if d.PlayerData.GetLoadingScreenActive() == false then break end
    J.SimulateRealMobileTap()
    J.SimulateScreenTapWithGui()
    task.wait(10)
end
d.AntiFling = { Enabled = false, _trackedParts = {}, _playerParts = {}, _playerConns = {}, _charConns = {}, _mainConns = {} }
local K = d.AntiFling
local b = y.Players.LocalPlayer
local function S(G, V)
    if V:IsA("BasePart") then
        K._trackedParts[V] = true
        if not K._playerParts[G] then K._playerParts[G] = {} end
        K._playerParts[G][V] = true
    end
end
local function z(G, V)
    K._trackedParts[V] = nil
    if K._playerParts[G] then K._playerParts[G][V] = nil end
end
local function f(G)
    if K._charConns[G] then
        for G, V in ipairs(K._charConns[G]) do V:Disconnect() end
        K._charConns[G] = nil
    end
    if K._playerParts[G] then
        for G in pairs(K._playerParts[G]) do K._trackedParts[G] = nil end
        K._playerParts[G] = nil
    end
end
local function t(G, V)
    f(G)
    K._charConns[G] = {}
    for V, y in ipairs(V:GetDescendants()) do S(G, y) end
    table.insert(K._charConns[G], V.DescendantAdded:Connect(function(V) S(G, V) end))
    table.insert(K._charConns[G], V.DescendantRemoving:Connect(function(V) z(G, V) end))
end
local function M(G)
    if G == b then return end
    if G.Character then t(G, G.Character) end
    if not K._playerConns[G] then K._playerConns[G] = G.CharacterAdded:Connect(function(V) t(G, V) end) end
end
local function A(G)
    if K._playerConns[G] then
        K._playerConns[G]:Disconnect()
        K._playerConns[G] = nil
    end
    f(G)
end
function d.AntiFling.Start()
    if K.Enabled then return end
    K.Enabled = true
    table.insert(K._mainConns, y.Players.PlayerAdded:Connect(M))
    table.insert(K._mainConns, y.Players.PlayerRemoving:Connect(A))
    table.insert(K._mainConns,
        y.RunService.PreSimulation:Connect(function() for G in pairs(K._trackedParts) do G.CanCollide = false end end))
    for G, V in ipairs(y.Players:GetPlayers()) do M(V) end
end

function d.AntiFling.Stop()
    if not K.Enabled then return end
    K.Enabled = false
    for G, V in ipairs(K._mainConns) do V:Disconnect() end
    K._mainConns = {}
    for G, V in pairs(K._playerConns) do V:Disconnect() end
    K._playerConns = {}
    for G, V in pairs(K._charConns) do for G, V in ipairs(V) do V:Disconnect() end end
    K._charConns = {}
    K._trackedParts = {}
    K._playerParts = {}
end

d.AntiFling.Start()
