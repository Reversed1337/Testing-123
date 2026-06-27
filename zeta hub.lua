--=========================================================
-- SETUP & BYPASS
--=========================================================
local G = {}
G.IsPremium = function() return true end
G.RegisterReset = function() end

local isNoui = (tostring(getgenv().mode) == "noui")

if isNoui then
    -- Mock the UI library to absorb all UI creation calls without rendering anything
    local mockMeta = {
        __index = function(t, k) return t end,
        __call = function(t, ...) return t end
    }
    local mockUI = setmetatable({}, mockMeta)
    G.Library = mockUI
    G.Window = mockUI
    G.IsHeadless = function() return true end
else
    -- Load the real UI library from your link
    local Library = loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/Reversed1337/Testing-123/refs/heads/main/zetahub_uilib"))()
    G.Library = Library

    -- Create the main window to pass to the script
    G.Window = Library:CreateWindow({
        Title = "Exotic Hub Lifetime",
        Footer = "exotichub.app/join | v24",
        Position = UDim2.fromOffset(6, 6),
        Size = UDim2.fromOffset(720, 600),
        AutoShow = true,
        Center = true,
        Resizable = true,
        SearchbarSize = UDim2.fromScale(1, 1),
        CornerRadius = 4,
        NotifySide = "Right",
        ShowCustomCursor = false,
        Font = Enum.Font.Code,
        ToggleKeybind = Enum.KeyCode.RightControl,
        MobileButtonsSide = "Left",
    })
end
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
y.Lighting = game:GetService("Lighting")
y.Stats = game:GetService("Stats")
y.HttpService = game:GetService("HttpService")
y.MarketplaceService = game:GetService("MarketplaceService")
y.TeleportService = game:GetService("TeleportService")
y.LocalPlayer = y.Players.LocalPlayer
y.Backpack = y.LocalPlayer:WaitForChild("Backpack")
y.PlayerGui = y.LocalPlayer:WaitForChild("PlayerGui")
y.Character = y.LocalPlayer.Character or y.LocalPlayer.CharacterAdded:Wait()
y.LocalPlayer.CharacterAdded:Connect(function(G)
	y.Character = G
end)
y.LocalPlayer.CharacterRemoving:Connect(function(G)
	if y.Character == G then
		y.Character = nil
	end
end)
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
y.MutationDataModule = y.SharedModules:WaitForChild("MutationData")
y.MutationData = y.safeRequire(y.MutationDataModule)
y.PetSizes = y.safeRequire(y.SharedData:WaitForChild("PetSizes"))
y.PetTypes = y.safeRequire(y.SharedData:WaitForChild("PetTypes"))
y.SellValueData = y.safeRequire(y.SharedModules:WaitForChild("SellValueData"))
y.SellFlags = y.safeRequire(y.SharedModules.Flags:WaitForChild("SellFlags"))
y.FruitVisualizerController = y.safeRequire(y.LocalPlayer.PlayerScripts.Controllers.FruitVisualizerController)
y.DroppedItems = y.Workspace:WaitForChild("DroppedItems")
y.EventSeedDrops = (y.Workspace:WaitForChild("Map")):WaitForChild("SeedPackSpawnServerLocations")
y.CollectFruitNet = y.Networking and (y.Networking.Garden and y.Networking.Garden.CollectFruit)
y.WateringcanData = y.safeRequire(y.SharedModules:WaitForChild("WateringcanData"))
y.SprinklerData = y.safeRequire(y.SharedModules:WaitForChild("SprinklerData"))
y.MushroomData = y.safeRequire(y.SharedModules:WaitForChild("MushroomData"))
y.RaccoonData = y.safeRequire(y.SharedModules:WaitForChild("RaccoonData"))
y.GnomeData = y.safeRequire(y.SharedModules:WaitForChild("GnomeData"))
y.PowerHoseData = y.safeRequire(y.SharedModules:WaitForChild("PowerHoseData"))
y.TrowelData = y.safeRequire(y.SharedModules:WaitForChild("TrowelData"))
y.PropData = y.safeRequire(y.SharedModules:WaitForChild("PropData"))
y.GardenSyncController = y.safeRequire(y.LocalPlayer.PlayerScripts.Controllers:WaitForChild("GardenSyncController"))
y.PathfindingService = game:GetService("PathfindingService")
y.TweenService = game:GetService("TweenService")
y.PetSlotPrices = y.safeRequire(y.SharedData:WaitForChild("PetSlotPrices"))
y.MailboxItemCatalog = y.safeRequire(y.LocalPlayer.PlayerScripts.Controllers.MailboxController:WaitForChild("MailboxItemCatalog"))
y.ExpansionPrices = y.safeRequire(y.SharedData:WaitForChild("ExpansionPrices"))
y.GardenFlags = y.safeRequire(y.SharedModules.Flags:WaitForChild("GardenFlags"))
y.TimeCycleData = y.safeRequire(y.SharedModules:WaitForChild("TimeCycleData"))
local Z = y.SharedModules and y.SharedModules:FindFirstChild("WeatherData")
y.WeatherData = Z and y.safeRequire(Z) or nil
y.PerfFlags = y.safeRequire(y.SharedModules.Flags:WaitForChild("PerfFlags"))
y.PlantVisualizerController = y.safeRequire(y.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlantVisualizerController"))
y.PlantVisualizerController = y.safeRequire(y.LocalPlayer.PlayerScripts.Controllers:WaitForChild("PlantVisualizerController"))
y.SeedShopFlags = y.safeRequire(y.SharedModules.Flags.SeedShopFlags)
y.GearShopFlags = y.safeRequire(y.SharedModules.Flags:WaitForChild("GearShopFlags"))
y.CrateData = y.safeRequire(y.SharedModules:WaitForChild("CrateData"))
y.CrateShopFlags = y.safeRequire(y.SharedModules.Flags:WaitForChild("CrateShopFlags"))
y.EggData = y.safeRequire(y.SharedModules:WaitForChild("EggData"))
y.SeedPackData = y.safeRequire(y.SharedModules:WaitForChild("SeedPackData"))
y.PlantGenerationModulesRoot = y.ReplicatedStorage:WaitForChild("PlantGenerationModules")
y.FruitGenerationModules = y.PlantGenerationModulesRoot:WaitForChild("Fruits")
y.PlantGenerationModules = y.PlantGenerationModulesRoot:WaitForChild("Plants")
y.WeightFormat = y.safeRequire(y.SharedModules:WaitForChild("WeightFormat"))
y.CalculateOvertimeGrowth = y.safeRequire(y.SharedModules:WaitForChild("CalculateOvertimeGrowth"))
y.OvertimeGrowthFlags = y.safeRequire(y.SharedModules.Flags:WaitForChild("OvertimeGrowthFlags"))
y.FruitValueCalc = y.safeRequire(y.SharedModules:WaitForChild("FruitValueCalc"))
y.FruitGenerationData = {}
y.PlantGenerationData = {}
for G, V in ipairs(y.FruitGenerationModules:GetChildren()) do
	if V:IsA("ModuleScript") then
		y.FruitGenerationData[V.Name] = y.safeRequire(V)
	end
end
for G, V in ipairs(y.PlantGenerationModules:GetChildren()) do
	if V:IsA("ModuleScript") then
		y.PlantGenerationData[V.Name] = y.safeRequire(V)
	end
end
function Addcantsleep()
	local G = getconnections or get_signal_cons
	if G then
		for G, V in pairs((G)(y.LocalPlayer.Idled)) do
			if V.Disable then
				V.Disable(V)
			elseif V.Disconnect then
				V.Disconnect(V)
			end
		end
	end
end
pcall(function()
	Addcantsleep()
end)
local j = G.Library
local i = G.Window
local c = type(G.IsHeadless) == "function" and G.IsHeadless() == true
y.AppName = "Exotic Hub"
y.CurentV = "v42"
y.invite_link_url = "https://exotichub.app/join"
y.invite_link_short = "exotichub.app/join"
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
local Y = {}
T.is_forced_stop = false
T.BuySelectFruitSelected = {}
T.BuySelectFruitUi = T.BuySelectFruitUi or {}
T.is_pro = true
T.GetCheckIfPro = function()
    return true
end
if type(G.RegisterReset) == "function" then
    G.RegisterReset(function()
    end)
end
T.RarityRank = {
	Common = 1;
	Uncommon = 2,
	Rare = 3,
	Epic = 4;
	Legendary = 5;
	Mythic = 6,
	Super = 7;
	Secret = 8
}
T.TeleportLockNames = {
	SeedPackCollector = "Seed Collection";
	SeedPlacer = "Seed Placement System",
	FruitCollector = "Fruit Collector",
	PetFarmReturn = "Pet Farm Return",
	EventCollector = "Event Collection";
	GardenItemCollector = "Garden Item Collector";
	PremiumFruitCollector = "Premium Fruit Collector";
	SprinklerPlacer = "Sprinkler Placement";
	PetFinderPremium = "Pet Finder Premium";
	WaterPlants = "Water Plants";
	GiftDropPickup = "Gift Drop Pickup";
	Other = "Other"
}
T.GetProMessage = function()
	local G = string.format("\240\159\148\146 <stroke th=\'0.1\' joins=\'round\' sizing=\'fixed\' color=\'#8C1600\'><font color=\'#FA2B00\'> Premium Feature - Join discord server to get Key.</font></stroke>")
	return G
end
local e = {
	high_mode = false;
	garden_items_use_player_walk = true;
	gift_send_enabled = false;
	gift_receive_enabled = false;
	gift_receive_mode = "Trusted Only";
	gift_send_targets = {};
	gift_receive_trusted = {},
	gift_receive_item_whitelist = {},
	gift_fruit_list = {},
	gift_min_weight = 0,
	gift_max_weight = 89,
	gift_mutation_whitelist = {},
	gift_mutation_blacklist = {};
	gift_variant_whitelist = {},
	gift_variant_blacklist = {},
	gift_max_per_cycle = 1;
	gift_delay = 1.25;
	gift_wait_timeout = 8;
	gift_preview_only = true,
	gift_keep_amount_per_fruit = 0,
	gift_only_when_backpack_over = 0;
	gift_send_order = "Lowest Weight First";
	gift_protect_favourites = true,
	gift_drop_pickup_enabled = false,
	gift_drop_pickup_mode = "Trusted Only",
	gift_drop_pickup_from = {},
	gift_drop_pickup_categories = {
		HarvestedFruits = true
	};
	gift_drop_pickup_use_player_walk = false;
	auto_expand_garden = false,
	auto_expand_garden_max_slot = 2;
	auto_expand_pet_inventory = false;
	auto_expand_pet_inventory_max_upgrade = 1,
	pet_inventory_min_sheckles_enabled = false,
	pet_inventory_min_sheckles = 0;
	player_speed_enabled = false,
	player_speed_value = 80,
	web_api_key = "",
	webhook_enabled = true,
	webhook_url = "";
	webhook_pet_buys = true,
	webhook_mail_manual = true,
	webhook_mail_auto = true;
	webhook_mail_claims = true;
	webhook_event_seeds = true,
	egg_hatcher_enabled = false;
	egg_hatcher_selected = {};
	egg_hatcher_protected = {},
	egg_hatcher_delay = .35;
	egg_hatcher_max_per_cycle = 1,
	egg_hatcher_equip_tool = true,
	egg_hatcher_webhook_enabled = true,
	egg_hatcher_webhook_pets = {},
	egg_hatcher_webhook_rarities = {},
	egg_hatcher_webhook_sizes = {};
	egg_hatcher_webhook_variants = {},
	seed_pack_opener_enabled = false;
	seed_pack_opener_selected = {};
	seed_pack_opener_protected = {};
	seed_pack_opener_delay = .35;
	seed_pack_opener_max_per_cycle = 1,
	seed_pack_opener_equip_tool = true;
	seed_pack_opener_webhook_enabled = true;
	seed_pack_opener_webhook_seeds = {},
	seed_pack_opener_webhook_rarities = {},
	pet_finder_enabled = false,
	pet_finder_buy_list = {};
	pet_finder_auto_hop = false;
	pet_finder_hop_minutes = 5;
	pet_finder_purchase_log = {},
	water_plant_wait_effect = false;
	auto_water_plants = false,
	water_plant_selected_cans = {},
	water_plant_mode = "Growing Plant";
	water_plant_target_plant = "";
	water_plant_saved_position = {};
	hide_player_ui = false;
	plant_fruit_esp_fruit_enabled = false;
	plant_fruit_esp_plant_enabled = false,
	plant_fruit_esp_names = {},
	plant_fruit_esp_min_kg = 0;
	plant_fruit_esp_max_kg = 100000000,
	plant_fruit_esp_max_distance = 150,
	backpack_fruit_price_esp_enabled = false,
	backpack_fruit_total_value_esp_enabled = false,
	auto_fruit_favourite_enabled = false;
	auto_fruit_favourite_names = {},
	auto_fruit_favourite_min_kg = 0;
	auto_fruit_favourite_max_kg = 100000000,
	auto_fruit_favourite_mutations = {},
	auto_fruit_favourite_variants = {};
	auto_fruit_favourite_max_value = 0;
	manual_fruit_favourite_names = {};
	manual_fruit_favourite_min_kg = 0;
	manual_fruit_favourite_max_kg = 100000000;
	manual_fruit_favourite_mutations = {},
	manual_fruit_favourite_variants = {};
	manual_fruit_favourite_max_value = 0;
	water_plant_weather_enabled = false;
	water_plant_weather_selected = {};
	sprinkler_place_weather_enabled = false;
	sprinkler_place_weather_selected = {};
	auto_sprinkler_place = false,
	sprinkler_place_selected = {};
	sprinkler_place_default_target = 1,
	sprinkler_place_overrides = {};
	sprinkler_place_mode = "Farm Middle";
	sprinkler_place_target_plant = "",
	sprinkler_place_saved_position = {};
	sprinkler_place_teleport = false;
	sprinkler_place_delay = .6;
	shovel_plant_variant_blacklist = {};
	hide_plant_models = false;
	sell_when_backpack_full = false;
	auto_idle_touch = true;
	auto_collect_event_seeds = true;
	auto_collect_drop_seeds = true,
	is_frist_run = false,
	seed_avoid = {};
	gear_shop_avoid = {};
	shop_selected_migration_v1 = false,
	seed_shop_buy_selected = {};
	enabled_seed_shop = false,
	seed_shop_min_sheckles_enabled = false,
	seed_shop_min_sheckles = 0;
	seed_shop_trigger_enabled = false,
	seed_shop_trigger_name = "Any Time",
	gear_shop_buy_selected = {},
	enabled_gear_shop = false,
	gear_shop_min_sheckles_enabled = false,
	gear_shop_min_sheckles = 0,
	gear_shop_trigger_enabled = false,
	gear_shop_trigger_name = "Any Time",
	crate_shop_buy_selected = {};
	enabled_crate_shop = false,
	crate_shop_min_sheckles_enabled = false,
	crate_shop_min_sheckles = 0;
	crate_shop_trigger_enabled = false,
	crate_shop_trigger_name = "Any Time";
	auto_collect_fruit_enabled = false,
	fruit_collect_nolimits = false;
	collect_fruit_list = {},
	collect_min_weight = 0;
	collect_max_weight = 89;
	collect_mutation_whitelist = {};
	collect_mutation_blacklist = {};
	collect_variant_whitelist = {},
	collect_variant_blacklist = {},
	collect_sort_mode = "Default";
	auto_seedplace = false,
	allowed_seedsplace = {},
	seed_place_default_target = 10,
	seed_place_delay = .3,
	seed_place_mode = "Random";
	seed_place_saved_position = {},
	seed_place_max_garden_plants = 800;
	seed_place_overrides = {},
	seed_place_wall_mode = false;
	seed_place_stack_mode = false;
	seed_place_stack_mode_underground = false,
	auto_sell_sellallinventory = false;
	sell_use_filters = false;
	sell_fruit_list = {};
	sell_min_weight = 0;
	sell_max_weight = 89;
	sell_mutation_whitelist = {},
	sell_mutation_blacklist = {};
	sell_variant_whitelist = {};
	sell_variant_blacklist = {},
	auto_sell_pets = false;
	pet_sell_preview_only = true;
	pet_sell_selected = {};
	pet_sell_protected = {};
	pet_sell_protected_ids = {},
	pet_sell_duplicate_only = true;
	pet_sell_keep_amount = 1;
	pet_sell_max_per_cycle = 3;
	pet_sell_delay = .25;
	pet_sell_max_rarity = "Rare",
	pet_sell_max_base_price = 0;
	pet_sell_protect_rainbow = true;
	pet_sell_protect_big_huge = true;
	pet_sell_size_whitelist = {},
	pet_sell_size_blacklist = {};
	pet_sell_variant_whitelist = {};
	pet_sell_variant_blacklist = {},
	turbo_sell = false,
	hide_log_ui = false;
	collection_teleport = true;
	char_farm_middle = false,
	auto_shovel_fruits = false;
	shovel_fruit_types = {};
	shovel_mutation_whitelist = {},
	shovel_mutation_blacklist = {},
	shovel_min_weight = 0;
	shovel_max_weight = 99,
	shovel_variants = {
		Normal = true;
		Gold = true,
		Rainbow = true
	},
	auto_shovel_plants = false;
	shovel_plant_types = {},
	shovel_plant_min_height = 0,
	shovel_plant_max_height = 200;
	shovel_plant_variants = {},
	shovel_growing_plants = false;
	shovel_plants_keep = 10;
	trowel_plant_types = {},
	trowel_use_fixed_spot = true;
	trowel_saved_position = {},
	pet_return_farm = false;
	pet_return_farm_timer = 60,
	pet_equip_enabled = false,
	pet_equip_log_enabled = true;
	pet_equip_restore_previous = true;
	pet_equip_protect_rainbow = true,
	pet_equip_protect_big_huge = true,
	pet_equip_protect_super_secret = true;
	pet_equip_protected_names = {};
	pet_equip_protected_ids = {};
	pet_equip_rules = {},
	pet_equip_active_rule_id = "",
	pet_equip_manual_rule_id = "",
	pet_equip_restore_snapshot = {};
	mail_manual_batch_together = false;
	mail_auto_batch_together = false;
	mail_auto_send_enabled = false,
	mail_auto_accept = false;
	mail_include_comment = false,
	mail_next_send_at = 0;
	mail_manual_order = {},
	mail_auto_rules = {};
	mail_receipts = {},
	mail_ignore_batch_limit = false;
	auto_use_daily_deal = true;
	auto_double_or_nothing = false,
	double_or_nothing_target_streak = 3,
	double_or_nothing_roll_delay = .15;
	double_or_nothing_webhook_win = true;
	double_or_nothing_webhook_loss = false;
	step_teleport_speed = 60
}
local s = type(getgenv) == "function" and getgenv() or _G
local N = type(s.gag2_config) == "table" and s.gag2_config or nil
T.player_userid = y.LocalPlayer.UserId
if not T.player_userid then
	warn("Invalid player detected.")
	return
end
T.alt_Plants_Physical = T.alt_Plants_Physical or {}
T.MakeAltFolder = function(G)
	if not G then
		warn("MakeAltFolder requires a userId!")
		return nil
	end
	local V = tostring(G) .. "_Plants"
	local Z = y.ReplicatedStorage:FindFirstChild(V)
	if Z then
		T.alt_Plants_Physical[G] = Z
		return Z
	end
	local j = Instance.new("Folder")
	j.Name = V
	j.Parent = y.ReplicatedFirst
	T.alt_Plants_Physical[G] = j
	return j
end
T.MakeAltFolder(T.player_userid)
local W = "exotichub99"
if not isfolder(W) then
	makefolder(W)
end
local X = W .. ("/" .. (tostring(T.player_userid) .. "gag2.json"))
q.Config = {
	Excluded = {
		pet_finder_purchase_log = true,
		mail_receipts = true
	};
	OverrideEnabled = type(N) == "table",
	ToLua = function(G, V)
		V = tonumber(V) or 0
		local y = type(G)
		if y == "string" then
			return string.format("%q", G)
		end
		if y == "number" or y == "boolean" then
			return tostring(G)
		end
		if y ~= "table" then
			return "nil"
		end
		local Z = {}
		for G in pairs(G) do
			table.insert(Z, G)
		end
		if # Z == 0 then
			return "{}"
		end
		table.sort(Z, function(G, V)
			if type(G) == type(V) then
				if type(G) == "number" then
					return G < V
				end
				return tostring(G) < tostring(V)
			end
			return type(G) < type(V)
		end)
		local j = string.rep("    ", V)
		local i = string.rep("    ", V + 1)
		local c = {
			"{"
		}
		for y, Z in ipairs(Z) do
			local j
			if type(Z) == "string" and Z:match("^[%a_][%w_]*$") then
				j = Z
			else
				j = string.format("[%s]", q.Config.ToLua(Z, 0))
			end
			table.insert(c, string.format("%s%s = %s,", i, j, q.Config.ToLua(G[Z], V + 1)))
		end
		table.insert(c, j .. "}")
		return table.concat(c, "\n")
	end,
	CopyTable = function(G)
		if type(G) ~= "table" then
			return G
		end
		local V = {}
		for G, y in pairs(G) do
			V[G] = q.Config.CopyTable(y)
		end
		return V
	end,
	Merge = function(G, V, y)
		if type(G) ~= "table" or type(V) ~= "table" then
			return false
		end
		for V, Z in pairs(V) do
			local j = G[V]
			if y and j == nil then
				continue
			end
			if type(j) == "table" and type(Z) == "table" then
				q.Config.Merge(j, Z, false)
			elseif j == nil or type(j) == type(Z) then
				G[V] = q.Config.CopyTable(Z)
			end
		end
		return true
	end;
	ApplyOverride = function()
		if not q.Config.OverrideEnabled then
			return false
		end
		return q.Config.Merge(e, N, true)
	end;
	GetCopyData = function()
		local G = {}
		for V, y in pairs(e) do
			if not q.Config.Excluded[V] then
				G[V] = y
			end
		end
		return G
	end;
	BuildCopyText = function()
		local G = q.Config.GetCopyData()
		if type(G) ~= "table" then
			return nil
		end
		local V, y = pcall(function()
			return "getgenv().gag2_config = " .. q.Config.ToLua(G, 0)
		end)
		if not V then
			return nil
		end
		return y
	end,
	BuildCopyWithLoaderText = function()
		local G = q.Config.BuildCopyText()
		if type(G) ~= "string" or G == "" then
			return nil
		end
		return table.concat({
			"getgenv().mode = \"noui\"";
			"getgenv().exo_key = \"YOUR_KEY\"",
			"";
			G;
			"";
			"loadstring(game:HttpGet(\"https://exotichub.app/auto.lua\"))()"
		}, "\n")
	end
}
q.Save = {
	RequireSave = false,
	SaveData = function(G)
		if q.Config.OverrideEnabled then
			return false
		end
		if G then
			q.Save.SaveDataSync()
			return
		end
		q.Save.RequireSave = true
	end;
	LoadData = function()
		if not isfile(X) then
			return
		end
		local G = readfile(X)
		if not G or G == "" then
			return
		end
		local V, Z = pcall(y.HttpService.JSONDecode, y.HttpService, G)
		if not V then
			return
		end
		local function j(G, V)
			for V, y in pairs(V) do
				local Z = G[V]
				if type(y) == "table" and type(Z) == "table" then
					j(Z, y)
				else
					G[V] = y
				end
			end
			return G
		end
		j(e, Z)
	end,
	SaveDataSync = function()
		if q.Config.OverrideEnabled then
			return false
		end
		local G, V = pcall(function()
			return y.HttpService:JSONEncode(e)
		end)
		if G then
			writefile(X, V)
			return true
		else
			return false
		end
	end,
	SaveLoop = function()
		if q.Config.OverrideEnabled then
			return false
		end
		task.spawn(function()
			while true do
				task.wait(.5)
				if q.Config.OverrideEnabled then
					return false
				end
				if q.Save.RequireSave then
					q.Save.RequireSave = false
					q.Save.SaveDataSync()
				end
			end
		end)
		return false
	end
}
if q.Config.OverrideEnabled then
	q.Config.ApplyOverride()
else
	q.Save.LoadData()
end
if e.seed_place_mode == "Farm Corner" then
	e.seed_place_mode = "Farm Middle"
	q.Save.SaveDataSync()
end
q.Save.SaveLoop()
local h = false
if e.auto_fruit_unfavourite_enabled ~= nil then
	e.auto_fruit_unfavourite_enabled = nil
	h = true
end
if e.auto_fruit_favourite_managed ~= nil then
	e.auto_fruit_favourite_managed = nil
	h = true
end
if h then
	q.Save.SaveData()
end
local l = {
	k = 1000.0;
	K = 1000.0,
	m = 1000000.0,
	M = 1000000.0,
	b = 1000000000.0,
	B = 1000000000.0;
	t = 1000000000000.0;
	T = 1000000000000.0,
	q = 1e+015,
	Q = 1e+015,
	Qa = 1e+015,
	qi = 1e+018;
	Qi = 1e+018,
	sx = 1e+021,
	Sx = 1e+021;
	sp = 1e+024,
	Sp = 1e+024,
	oc = 1e+027,
	Oc = 1e+027,
	no = 1e+030;
	No = 1e+030,
	dc = 1e+033,
	Dc = 1e+033
}
local B = {
	"k";
	"M",
	"B";
	"T",
	"Qa";
	"Qi";
	"Sx",
	"Sp",
	"Oc",
	"No";
	"Dc"
}
T.Notify = function(G, V)
	G = tostring(G or "")
	if G == "" or not j or type(j.Notify) ~= "function" then
		return false
	end
	return pcall(function()
		j:Notify(G, tonumber(V) or 2.5)
	end)
end
E.Http = {
	GetRequestFunction = function()
		return type(syn) == "table" and syn.request or type(http) == "table" and http.request or type(http_request) == "function" and http_request or type(request) == "function" and request or type(fluxus) == "table" and fluxus.request or type(krnl) == "table" and krnl.request
	end,
	PostJson = function(G, V)
		if type(G) ~= "string" or G == "" or type(V) ~= "table" then
			return false, 0, "", "Invalid request"
		end
		local Z, j = pcall(y.HttpService.JSONEncode, y.HttpService, V)
		if not Z or type(j) ~= "string" then
			return false, 0, "", "Failed to encode request"
		end
		local i, c = pcall(function()
			local V = E.Http.GetRequestFunction()
			if type(V) == "function" then
				return V({
					Url = G;
					Method = "POST";
					Headers = {
						["Content-Type"] = "application/json";
						Accept = "application/json"
					},
					Body = j
				})
			end
			local Z = y.HttpService:PostAsync(G, j, Enum.HttpContentType.ApplicationJson)
			return {
				StatusCode = 200,
				Body = Z
			}
		end)
		if not i or type(c) ~= "table" then
			return false, 0, "", tostring(c or "Request failed")
		end
		local J = tonumber(c.StatusCode or c.Status or c.status_code) or 0
		local T = c.Body or c.body or ""
		T = type(T) == "string" and T or tostring(T or "")
		if J == 0 and T ~= "" then
			J = 200
		end
		local d = J >= 200 and J < 300
		local u = nil
		if not d then
			u = "HTTP " .. tostring(J)
		end
		return d, J, T, u
	end
}
u.WebApi = {
	Url = "https://exotichub.app/api/linkapidevice",
	Busy = false,
	LinkDevice = function()
		if u.WebApi.Busy then
			return false, "Link request already running"
		end
		local G = (tostring(e.web_api_key or "")):match("^%s*(.-)%s*$")
		local V = tostring(y.LocalPlayer and y.LocalPlayer.Name or "")
		local Z = tostring(y.LocalPlayer and y.LocalPlayer.UserId or "")
		if G == "" then
			return false, "Enter your Web API key first"
		end
		if V == "" or Z == "" then
			return false, "Account data is unavailable"
		end
		u.WebApi.Busy = true
		local j, i = pcall(function()
			local j = y.HttpService:JSONEncode({
				webapi = G;
				un = V,
				pid = Z
			})
			local i = type(syn) == "table" and syn.request or type(http) == "table" and http.request or type(http_request) == "function" and http_request or type(request) == "function" and request or type(fluxus) == "table" and fluxus.request or type(krnl) == "table" and krnl.request
			if type(i) == "function" then
				local G = i({
					Url = u.WebApi.Url;
					Method = "POST",
					Headers = {
						["Content-Type"] = "application/json"
					};
					Body = j
				})
				if type(G) ~= "table" then
					error("Invalid request response")
				end
				return G.Body or G.body or ""
			end
			return y.HttpService:PostAsync(u.WebApi.Url, j, Enum.HttpContentType.ApplicationJson)
		end)
		u.WebApi.Busy = false
		if not j or type(i) ~= "string" or i == "" then
			return false, "Device link request failed"
		end
		local c, J = pcall(y.HttpService.JSONDecode, y.HttpService, i)
		if not c or type(J) ~= "table" then
			return false, "Invalid server response"
		end
		local T = tostring(J.msg or J.message or "Unknown response")
		if J.success == true then
			return true, T, J
		end
		return false, T, J
	end
}
J.CopyToClipBoard = function(G)
	if setclipboard then
		setclipboard(G);
		(game:GetService("StarterGui")):SetCore("SendNotification", {
			Title = "Text",
			Text = " Copied to clipboard!";
			Duration = 2
		})
	else
		T.Notify("\226\157\140 Clipboard copy not supported", 3)
	end
end
local function L(G)
	if G == nil or (type(G) == "string" and G:match("^%s*$")) then
		return nil
	end
	local V = tonumber(G)
	if not V then
		return nil
	end
	if V % 1 ~= 0 then
		return nil
	end
	return V
end
local function m(G)
	if G == nil or (type(G) == "string" and G:match("^%s*$")) then
		return nil
	end
	local V = tonumber(G)
	if not V then
		return nil
	end
	return V
end
J.IsLoadingCompleted = function()
	local G = y.LocalPlayer:GetAttribute("GardenLoadingTotal") or 0
	local V = y.LocalPlayer:GetAttribute("GardenLoadingProgress") or 0
	if G == 0 and V == 0 then
		return true
	end
	return false
end
J.formatShecklesNumber = function(G)
	G = tonumber(G)
	if not G then
		return "0"
	end
	local V = {
		"K";
		"M",
		"B";
		"T",
		"Qa",
		"Qi",
		"Sx",
		"Sp",
		"Oc";
		"No",
		"Dc"
	}
	local y = math.abs(G)
	if y < 1000 then
		return string.format("%.2f", G)
	end
	local Z = math.log10(y)
	local j = math.floor(Z / 3)
	if j > # V then
		return string.format("%.2e", G)
	end
	local i = 10 ^ ((j * 3))
	local c = G / i
	return string.format("%.2f%s", c, V[j])
end
J.JsonPrint = function(G)
	if y.HttpService then
		warn(y.HttpService:JSONEncode(G))
	end
end
J.log = function(G)
	if G then
		print(G)
	else
		warn("(log) error passed val nil")
	end
end
d.Currency = {
	ParseMoney = function(G)
		if not G or type(G) ~= "string" then
			return 0
		end
		local V = G:gsub("[$,%s]", "")
		V = (V:gsub("/s", "")):gsub("/min", "")
		local y, Z = V:match("^([%d%.]+)(%a*)$")
		local j = tonumber(y) or 0
		if Z and Z ~= "" then
			local V = l[Z]
			if V then
				j = j * V
			else
				warn("Ulti: Unknown suffix \'" .. (Z .. ("\' in text: " .. G)))
			end
		end
		return j
	end;
	FormatMoney = function(G)
		local V = tonumber(G)
		if not V then
			V = d.Currency.ParseMoney(G)
		end
		if not V or V == 0 then
			return "0"
		end
		if V < 1000 then
			return tostring(math.floor(V))
		end
		local y = 0
		local Z = V
		while Z >= 1000 and y < # B do
			Z = Z / 1000
			y = y + 1
		end
		local j = string.format("%.2f", Z)
		j = j:gsub("%.?0+$", "")
		return j .. B[y]
	end
}
d.App = {
	GetAppName = function()
		return y.AppName
	end,
	GetFooterInfo = function(G)
		local V = string.format("%s (%s)", y.invite_link_short, y.CurentV)
		if not G then
			V = string.format("<b><font color=\'#FFFB03\'>%s</font></b> (%s)", y.invite_link_short, y.CurentV)
		end
		return V
	end
}
d.SERVER = {
	GetServerVersion = function()
		return game.PlaceVersion
	end
}
d.Others = {
	IsBetween = function(G, V, y)
		return G >= V and G <= y
	end
}
local K = game:GetService("RunService")
Y.applySmoothRainbow = function(G, V)
	if not G or not ((G:IsA("TextLabel") or G:IsA("TextButton"))) then
		warn("Target is not a valid text object!")
		return nil
	end
	V = V or .2
	local y = 0
	local Z
	Z = K.Heartbeat:Connect(function(j)
		if not G or not G.Parent then
			Z:Disconnect()
			return
		end
		y = ((y + (j * V))) % 1
		G.TextColor3 = Color3.fromHSV(y, .8, 1)
	end)
	return Z
end
J.UserDevice = {
	IsMobile = function()
		return y.UserInputService.TouchEnabled
	end;
	IsPC = function()
		return y.UserInputService.KeyboardEnabled and (y.UserInputService.MouseEnabled and not y.UserInputService.TouchEnabled)
	end;
	IsConsole = function()
		return y.UserInputService.GamepadEnabled and not y.UserInputService.KeyboardEnabled
	end,
	Get = function()
		if y.UserInputService.TouchEnabled then
			return "Mobile"
		end
		if y.UserInputService.GamepadEnabled and not y.UserInputService.KeyboardEnabled then
			return "Console"
		end
		return "PC"
	end,
	Raw = function()
		return {
			Touch = y.UserInputService.TouchEnabled;
			Keyboard = y.UserInputService.KeyboardEnabled,
			Mouse = y.UserInputService.MouseEnabled;
			Gamepad = y.UserInputService.GamepadEnabled
		}
	end
}
print("Platform : ", J.UserDevice.Get())
print("SC Version: ", y.CurentV)
T.LiveReplicaData = nil
T.LiveReplicaConnection = nil
u.DataReplica = {
	AllBigDataKeys = {};
	Load = function(G, V)
		local Z = y.ReplicaClient
		V = tonumber(V) or 10
		if type(Z) ~= "table" or type(Z.OnNew) ~= "function" or type(Z.RequestData) ~= "function" then
			return false
		end
		if type(G) ~= "string" or G == "" then
			return false
		end
		if T.LiveReplicaConnection then
			T.LiveReplicaConnection:Disconnect()
			T.LiveReplicaConnection = nil
		end
		T.LiveReplicaData = nil
		T.LiveReplicaConnection = Z.OnNew(G, function(G)
			if type(G) ~= "table" or type(G.Data) ~= "table" then
				return
			end
			T.LiveReplicaData = G.Data
			for G in pairs(G.Data) do
				table.insert(u.DataReplica.AllBigDataKeys, G)
			end
		end)
		Z.RequestData()
		local j = os.clock()
		repeat
			task.wait()
		until T.LiveReplicaData ~= nil or os.clock() - j >= V
		if T.LiveReplicaData == nil then
			return false
		end
		return true
	end,
	GetData = function(G, V)
		local y = T.LiveReplicaData
		if type(y) ~= "table" then
			return V or nil
		end
		local Z = y[G]
		if Z == nil then
			return V or nil
		end
		return Z
	end
}
u.Money = {
	GetSheckles = function()
		return u.DataReplica.GetData("Sheckles", 0)
	end
}
if u.DataReplica.Load("PlayerState", 10) then
end
T.RuntimeStatsFocused = true
pcall(function()
	y.UserInputService.WindowFocused:Connect(function()
		T.RuntimeStatsFocused = true
	end)
	y.UserInputService.WindowFocusReleased:Connect(function()
		T.RuntimeStatsFocused = false
	end)
end)
u.RuntimeStats = {
	StartedRuntimeStats = false;
	StartedAtRuntimeStats = os.clock();
	FpsRuntimeStats = 0,
	FrameMsRuntimeStats = 0;
	MinFpsRuntimeStats = 999,
	MaxFrameMsRuntimeStats = 0,
	FrameCountRuntimeStats = 0;
	FrameTotalRuntimeStats = 0,
	LastWindowRuntimeStats = os.clock(),
	RoundRuntimeStats = function(G, V)
		G = tonumber(G)
		V = tonumber(V) or 0
		if not G then
			return nil
		end
		local y = 10 ^ V
		return math.floor(G * y + .5) / y
	end;
	GetMemoryRuntimeStats = function()
		local G = y.Stats
		if not G or type(G.GetTotalMemoryUsageMb) ~= "function" then
			return nil
		end
		local V, Z = pcall(function()
			return G:GetTotalMemoryUsageMb()
		end)
		if not V then
			return nil
		end
		return u.RuntimeStats.RoundRuntimeStats(Z, 1)
	end,
	GetPingRuntimeStats = function()
		local G = y.LocalPlayer
		if G and type(G.GetNetworkPing) == "function" then
			local V, y = pcall(function()
				return G:GetNetworkPing()
			end)
			if V and type(y) == "number" then
				return math.floor(y * 1000 + .5)
			end
		end
		return nil
	end;
	GetStatsItemRuntimeStats = function(G, V)
		if not G or type(V) ~= "table" then
			return nil
		end
		for V, y in ipairs(V) do
			local Z = G:FindFirstChild(tostring(y), true)
			if Z and type(Z.GetValue) == "function" then
				local G, V = pcall(function()
					return Z:GetValue()
				end)
				if G and type(V) == "number" then
					return u.RuntimeStats.RoundRuntimeStats(V, 2)
				end
			end
		end
		return nil
	end,
	GetNetworkRuntimeStats = function()
		local G = y.Stats
		local V = G and G:FindFirstChild("Network")
		return {
			send_kbps = u.RuntimeStats.GetStatsItemRuntimeStats(V, {
				"Data Send Kbps";
				"Send Kbps"
			});
			recv_kbps = u.RuntimeStats.GetStatsItemRuntimeStats(V, {
				"Data Receive Kbps";
				"Receive Kbps"
			})
		}
	end;
	GetCpuRuntimeStats = function()
		local G = y.Stats
		local V = G and G:FindFirstChild("PerformanceStats")
		return u.RuntimeStats.GetStatsItemRuntimeStats(V, {
			"CPU";
			"CPU Time",
			"CPU ms"
		})
	end;
	BuildPayloadRuntimeStats = function()
		local G = u.RuntimeStats.GetNetworkRuntimeStats()
		return {
			fps = u.RuntimeStats.FpsRuntimeStats;
			frame_ms = u.RuntimeStats.FrameMsRuntimeStats;
			min_fps = u.RuntimeStats.MinFpsRuntimeStats ~= 999 and u.RuntimeStats.MinFpsRuntimeStats or 0,
			max_frame_ms = u.RuntimeStats.MaxFrameMsRuntimeStats;
			ram_mb = u.RuntimeStats.GetMemoryRuntimeStats(),
			cpu_ms = u.RuntimeStats.GetCpuRuntimeStats();
			ping_ms = u.RuntimeStats.GetPingRuntimeStats(),
			send_kbps = G.send_kbps;
			recv_kbps = G.recv_kbps;
			uptime_s = math.floor(os.clock() - u.RuntimeStats.StartedAtRuntimeStats);
			place_id = game.PlaceId,
			game_id = game.GameId,
			job_id = tostring(game.JobId or ""),
			place_version = game.PlaceVersion,
			platform = J.UserDevice.Get(),
			focused = T.RuntimeStatsFocused == true,
			loading = not J.IsLoadingCompleted();
			players = # y.Players:GetPlayers(),
			max_players = y.Players.MaxPlayers,
			active_weather = tostring(y.Workspace:GetAttribute("ActiveWeather") or ""),
			active_phase = tostring(y.Workspace:GetAttribute("ActivePhase") or "")
		}
	end,
	StartRuntimeStats = function()
		if u.RuntimeStats.StartedRuntimeStats then
			return false
		end
		u.RuntimeStats.StartedRuntimeStats = true
		y.RunService.RenderStepped:Connect(function(G)
			u.RuntimeStats.FrameCountRuntimeStats += 1
			u.RuntimeStats.FrameTotalRuntimeStats += G
			local V = os.clock()
			if V - u.RuntimeStats.LastWindowRuntimeStats < 1 then
				return
			end
			local y = math.max(u.RuntimeStats.FrameCountRuntimeStats, 1)
			local Z = u.RuntimeStats.FrameTotalRuntimeStats / y
			local j = Z > 0 and math.floor((1 / Z) + .5) or 0
			local i = u.RuntimeStats.RoundRuntimeStats(Z * 1000, 1) or 0
			u.RuntimeStats.FpsRuntimeStats = j
			u.RuntimeStats.FrameMsRuntimeStats = i
			u.RuntimeStats.MinFpsRuntimeStats = math.min(u.RuntimeStats.MinFpsRuntimeStats, j)
			u.RuntimeStats.MaxFrameMsRuntimeStats = math.max(u.RuntimeStats.MaxFrameMsRuntimeStats, i)
			u.RuntimeStats.FrameCountRuntimeStats = 0
			u.RuntimeStats.FrameTotalRuntimeStats = 0
			u.RuntimeStats.LastWindowRuntimeStats = V
		end)
		return true
	end
}
u.RuntimeStats.StartRuntimeStats()
u.GameApi = {
	Url = "";
	Busy = false,
	Started = false,
	GetInterval = function()
		return 15
	end,
	GetSeedStockGameApi = function(G)
		G = tostring(G or "")
		if G == "" or not y.SeedShop or not y.SeedShop.Items then
			return 0
		end
		local V = y.SeedShop.Items:FindFirstChild(G)
		if not V then
			return 0
		end
		return tonumber(V.Value) or 0
	end;
	GetGearStockGameApi = function(G)
		G = tostring(G or "")
		if G == "" then
			return 0
		end
		if u.GearData and type(u.GearData.GetGearStockCurrent) == "function" then
			local V = u.GearData.GetGearStockCurrent(G)
			return tonumber(V) or 0
		end
		if not y.GearShop or not y.GearShop.Items then
			return 0
		end
		local V = y.GearShop.Items:FindFirstChild(G)
		if not V then
			return 0
		end
		return tonumber(V.Value) or 0
	end,
	GetSeedsGameApi = function()
		local G = {}
		local V = u.DataReplica.GetData("Inventory")
		local y = type(V) == "table" and V.Seeds or nil
		if type(y) ~= "table" then
			return G
		end
		for V, y in pairs(y) do
			V = tostring(V or "")
			y = math.max(math.floor(tonumber(y) or 0), 0)
			if V ~= "" and y > 0 then
				local Z = T.SeedDataFast and T.SeedDataFast[V] or nil
				table.insert(G, {
					name = V,
					rarity = type(Z) == "table" and tostring(Z.rarity or "Unknown") or "Unknown";
					count = y;
					single = type(Z) == "table" and Z.single == true or false,
					icon_id = type(Z) == "table" and tonumber(Z.icon_id) or 0
				})
			end
		end
		table.sort(G, function(G, V)
			local y = T.RarityRank[tostring(G.rarity or "")] or 0
			local Z = T.RarityRank[tostring(V.rarity or "")] or 0
			if y ~= Z then
				return y > Z
			end
			if G.count ~= V.count then
				return G.count > V.count
			end
			return tostring(G.name or "") < tostring(V.name or "")
		end)
		return G
	end,
	GetGearGameApi = function()
		local G = {}
		local V = u.DataReplica.GetData("Inventory")
		local Z = y.MailboxItemCatalog
		local j = type(Z) == "table" and Z.Categories or nil
		if type(V) ~= "table" or type(j) ~= "table" then
			return G
		end
		for y, j in ipairs(j) do
			j = tostring(j or "")
			if j == "" or j == "Pets" or j == "Seeds" or j == "HarvestedFruits" then
				continue
			end
			local i = V[j]
			if type(i) ~= "table" then
				continue
			end
			for V, y in pairs(i) do
				V = tostring(V or "")
				y = math.max(math.floor(tonumber(y) or 0), 0)
				if V ~= "" and y > 0 then
					local i = u.GearData and (u.GearData.GetGeatItemDetails and u.GearData.GetGeatItemDetails(V)) or nil
					local c = V
					local T = type(i) == "table" and tonumber(i.icon_id) or 0
					if type(Z.Resolve) == "function" then
						local G, y, i = pcall(Z.Resolve, j, V)
						if G then
							if type(y) == "string" and y ~= "" then
								c = y
							end
							if T <= 0 then
								T = J.GetAssetId(i)
							end
						end
					end
					table.insert(G, {
						name = c,
						item_name = V,
						category = j;
						type = type(i) == "table" and tostring(i.type or j) or j;
						rarity = type(i) == "table" and tostring(i.rarity or "Unknown") or "Unknown";
						count = y;
						icon_id = T
					})
				end
			end
		end
		table.sort(G, function(G, V)
			local y = T.RarityRank[tostring(G.rarity or "")] or 0
			local Z = T.RarityRank[tostring(V.rarity or "")] or 0
			if y ~= Z then
				return y > Z
			end
			if G.count ~= V.count then
				return G.count > V.count
			end
			return tostring(G.name or "") < tostring(V.name or "")
		end)
		return G
	end,
	GetRequestFunction = function()
		if type(syn) == "table" and type(syn.request) == "function" then
			return syn.request
		end
		if type(http) == "table" and type(http.request) == "function" then
			return http.request
		end
		if type(http_request) == "function" then
			return http_request
		end
		if type(request) == "function" then
			return request
		end
		if type(fluxus) == "table" and type(fluxus.request) == "function" then
			return fluxus.request
		end
		if type(krnl) == "table" and type(krnl.request) == "function" then
			return krnl.request
		end
		return nil
	end;
	GetIconId = function(G)
		if type(G) ~= "table" then
			return 0
		end
		local V = tostring(G.Image or "")
		return tonumber(V:match("%d+")) or 0
	end,
	GetSize = function(G)
		if type(G) ~= "table" then
			return "Normal"
		end
		if G.Size == "Huge" then
			return "Huge"
		end
		if G.Size == "Big" then
			return "Big"
		end
		return "Normal"
	end,
	GetVariant = function(G)
		if type(G) == "table" and G.Type == "Rainbow" then
			return "Rainbow"
		end
		return "Normal"
	end;
	GetPets = function()
		local G = u.DataReplica.GetData("Inventory")
		local V = type(G) == "table" and G.Pets or nil
		if type(V) ~= "table" then
			return nil
		end
		local Z = {}
		local j = {}
		for G, V in pairs(V) do
			if type(V) ~= "table" then
				continue
			end
			local j = V.Name or V.PetName or V.Species
			if type(j) ~= "string" or j == "" then
				continue
			end
			local i = type(y.PetData) == "table" and y.PetData[j] or nil
			local c = type(i) == "table" and i.DisplayName or j
			local J = type(i) == "table" and i.Rarity or "Unknown"
			local T = u.GameApi.GetSize(V)
			local d = u.GameApi.GetVariant(V)
			local q = table.concat({
				j,
				T;
				d
			}, "\031")
			if not Z[q] then
				Z[q] = {
					name = tostring(c),
					size = T;
					variant = d;
					rarity = tostring(J);
					amount = 0;
					icon_id = u.GameApi.GetIconId(i)
				}
			end
			Z[q].amount += 1
		end
		for G, V in pairs(Z) do
			table.insert(j, V)
		end
		table.sort(j, function(G, V)
			if G.name ~= V.name then
				return G.name < V.name
			end
			if G.size ~= V.size then
				return G.size < V.size
			end
			return G.variant < V.variant
		end)
		return j
	end,
	BuildPayload = function()
		local G = u.GameApi.GetPets()
		if type(G) ~= "table" then
			return nil
		end
		local V = y.LocalPlayer
		if not V or not V.UserId then
			return nil
		end
		return {
			game = "gag2",
			username = tostring(V.Name or ""),
			userid = tostring(V.UserId),
			ispro = T.GetCheckIfPro() == true;
			sheckles = tostring(u.Money.GetSheckles() or 0);
			pets_data = G,
			seeds_data = u.GameApi.GetSeedsGameApi(),
			gear_data = u.GameApi.GetGearGameApi();
			runtime = u.RuntimeStats.BuildPayloadRuntimeStats(),
			sc_v = tostring(y.CurentV)
		}
	end;
	Send = function()
		if u.GameApi.Busy then
			return false
		end
		local G = u.GameApi.BuildPayload()
		if type(G) ~= "table" then
			return false
		end
		u.GameApi.Busy = true
		local V = pcall(function()
			local V = y.HttpService:JSONEncode(G)
			local Z = u.GameApi.GetRequestFunction()
			if type(Z) == "function" then
				Z({
					Url = u.GameApi.Url,
					Method = "POST";
					Headers = {
						["Content-Type"] = "application/json"
					},
					Body = V
				})
				return
			end
			y.HttpService:PostAsync(u.GameApi.Url, V, Enum.HttpContentType.ApplicationJson)
		end)
		u.GameApi.Busy = false
		return V
	end,
	Start = function()
		if u.GameApi.Started then
			return
		end
		u.GameApi.Started = true
		task.spawn(function()
			task.wait(2)
			while true do
				u.GameApi.Send()
				task.wait(u.GameApi.GetInterval())
			end
		end)
	end
}
u.Data = {
	GetRarityColor = function(G)
		local V = "#FFFFFF"
		local Z = y and y.RarityVisuals
		if type(Z) ~= "table" or type(Z.GetStaticColor) ~= "function" or type(G) ~= "string" or G == "" then
			return V
		end
		local j = Z.GetStaticColor(G)
		if typeof(j) ~= "Color3" then
			return V
		end
		local i = math.clamp(math.floor(j.R * 255 + .5), 0, 255)
		local c = math.clamp(math.floor(j.G * 255 + .5), 0, 255)
		local J = math.clamp(math.floor(j.B * 255 + .5), 0, 255)
		return string.format("#%02X%02X%02X", i, c, J)
	end
}
T.AllMutationNames = {}
u.Mutations = {
	Load = function()
		table.clear(T.AllMutationNames)
		local G = y.MutationDataModule
		local V = y.MutationData
		if not G then
			return false
		end
		if type(V) ~= "table" or type(V.GetMutation) ~= "function" then
			return false
		end
		local Z = {}
		for G, y in ipairs(G:GetChildren()) do
			if not y:IsA("ModuleScript") then
				continue
			end
			local j = y.Name
			if j == "" or Z[j] then
				continue
			end
			local i, c = pcall(function()
				return V.GetMutation(j)
			end)
			if i and type(c) == "table" then
				Z[j] = true
				table.insert(T.AllMutationNames, j)
			end
		end
		table.sort(T.AllMutationNames)
		return # T.AllMutationNames > 0
	end;
	GetNames = function()
		local G = {}
		for V, y in ipairs(T.AllMutationNames) do
			table.insert(G, y)
		end
		return G
	end
}
u.Mutations.Load()
J.GetAssetId = function(G)
	if G == nil then
		return 0
	end
	if type(G) == "number" then
		return math.floor(G)
	end
	if typeof(G) == "Instance" then
		if G:IsA("StringValue") then
			G = G.Value
		elseif G:IsA("ImageLabel") or G:IsA("ImageButton") then
			G = G.Image
		else
			return 0
		end
	end
	G = tostring(G or "")
	if G == "" then
		return 0
	end
	return tonumber(G:match("%d+")) or 0
end
T.AllSeedsDataTable = {}
T.SeedRarity = {}
T.SeedSingleHarvest = {}
T.SeedDataFast = {}
T.SeedShopDataList = {}
T.SeedPriceOverrides = {}
u.SeedData = {
	getCleanPriceOverrides = function()
		if type(y.SeedShopFlags) ~= "table" then
			return
		end
		local G = y.SeedShopFlags.PriceOverrides
		if type(G) == "table" and G.Value then
			G = G.Value
		end
		if type(G) == "table" then
			for G, V in pairs(G) do
				if type(G) == "string" and type(V) == "number" then
					T.SeedPriceOverrides[G] = V
				end
			end
		end
	end,
	IsSingleHarvest = function(G)
		return T.SeedSingleHarvest[G]
	end,
	LoadAllSeeds = function()
		if not y.SeedData then
			warn("Seed Data failed to load.")
			return
		end
		for G, V in ipairs(y.SeedData) do
			local y = V.SeedName
			local Z = V.SeedImage
			local j = V.FruitImage
			local i = T.SeedPriceOverrides[y] or V.PurchasePrice
			local c = V.RestockShop
			local d = V.SeedShopDisplayOrder
			local u = V.YHeight
			local q = V.RestockChance
			local g = V.RestockValues
			local E = V.IsSingleHarvest
			local a = V.Rarity
			local H = V.PrimeTime
			local r = V.PlantModel
			local Y = V.MutationSeed
			T.SeedRarity[y] = a
			if E then
				T.SeedSingleHarvest[y] = true
			end
			local e = {
				name = y,
				price = i;
				rarity = a,
				single = E,
				icon_id = J.GetAssetId(Z)
			}
			T.SeedDataFast[y] = e
			table.insert(T.AllSeedsDataTable, e)
		end
	end,
	GetSeedDataX = function(G)
		return T.SeedDataFast[G] or nil
	end;
	LoadValidSeedsForShop = function()
		local G = y.SeedShop.Items
		for G, V in ipairs(G:GetChildren()) do
			local y = V.Name or ""
			local Z = T.SeedDataFast[y]
			if not Z then
				print("Seed not data ", y)
				continue
			end
			T.SeedShopDataList[y] = true
		end
	end;
	GetSeedDataListDropDown = function()
		local G = {}
		for V, y in ipairs(T.AllSeedsDataTable) do
			local Z = tostring(y.name or "Unknown")
			local j = tonumber(y.price) or 0
			local i = tostring(y.rarity or "Unknown")
			local c = y.single == true
			local J = c and "Single" or "Multi"
			local T = u.Data.GetRarityColor(i)
			local d = string.format("<font color=\"#FFFFFF\">%s</font> <font color=\"#00FF00\">$%s</font> <font color=\"%s\">%s</font> <font color=\"#FFFFFF\">%s</font>", Z, tostring(j), T, i, J)
			local q = {
				Text = d,
				Value = Z
			}
			table.insert(G, q)
		end
		return G
	end;
	GetSeedShopDropDown = function()
		local G = {}
		for V, y in pairs(T.SeedShopDataList) do
			local Z = V
			local j = T.SeedDataFast[Z]
			if not j then
				print("Seed not data ", Z)
				continue
			end
			local i = tostring(j.name or "Unknown")
			local c = J.formatShecklesNumber(j.price)
			local d = tostring(j.rarity or "Unknown")
			local q = j.single == true
			local g = q and "Single" or "Multi"
			local E = u.Data.GetRarityColor(d)
			local a = string.format("<font color=\"#FFFFFF\">%s</font> <font color=\"#00FF00\">$%s</font> <font color=\"%s\">%s</font> <font color=\"#FFFFFF\">%s</font>", i, tostring(c), E, d, g)
			local H = {
				Text = a,
				Value = i
			}
			table.insert(G, H)
		end
		return G
	end
}
u.SeedData.getCleanPriceOverrides()
u.SeedData.LoadAllSeeds()
u.SeedData.LoadValidSeedsForShop()
T.AllGearShopData = {}
T.AllGearShopTable = {}
u.GearData = {
	GetPrice = function(G, V)
		local Z = y.GearShopFlags and y.GearShopFlags.PriceOverrides
		if not Z or type(Z.Get) ~= "function" then
			return V
		end
		local j = Z:Get()
		local i = type(j) == "table" and j[G]
		if type(i) == "number" and i >= 0 then
			return i
		end
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
				local d = V.PriceInRobux
				local q = V.RestockChance
				local g = V.EquippableGear == true
				local E = V.IMG or ""
				local a = y and y.Min or nil
				local H = y and y.Max or nil
				local r = V
				local Y = u.GearData.GetPrice(j, V.Cost)
				if j then
					local G = {
						name = j;
						type = i;
						rarity = c;
						price = Y,
						icon_id = J.GetAssetId(E)
					}
					T.AllGearShopData[j] = G
					table.insert(T.AllGearShopTable, G)
				end
			end
		end
		return true
	end,
	GetGearShopDropDown = function()
		local G = {}
		for V, y in pairs(T.AllGearShopTable) do
			local Z = tostring(y.name or "Unknown")
			local j = J.formatShecklesNumber(y.price)
			local i = tostring(y.rarity or "Unknown")
			local c = u.Data.GetRarityColor(i)
			local T = string.format("<font color=\"#FFFFFF\">%s</font> <font color=\"#00FF00\">$%s</font> <font color=\"%s\">%s</font>", Z, tostring(j), c, i)
			local d = {
				Text = T;
				Value = Z
			}
			table.insert(G, d)
		end
		return G
	end;
	GetGeatItemDetails = function(G)
		return T.AllGearShopData[G]
	end,
	GetGearStockCurrent = function(G)
		local V = y.GearShop.Items:FindFirstChild(G)
		if V then
			return V.Value or 0
		end
		return nil
	end
}
u.GearData.LoadAllGearData()
T.AllCrateShopData = {}
T.AllCrateShopTable = {}
T.CrateShopDataList = {}
u.CrateData = {
	GetPriceCrateData = function(G, V)
		local Z = y.CrateShopFlags and y.CrateShopFlags.PriceOverrides
		if Z and type(Z.Get) == "function" then
			local V = Z:Get()
			local y = type(V) == "table" and V[G]
			if type(y) == "number" and y >= 0 then
				return y
			end
		end
		return V
	end;
	LoadAllCrateData = function()
		table.clear(T.AllCrateShopData)
		table.clear(T.AllCrateShopTable)
		local G = y.CrateData
		if type(G) ~= "table" or type(G.GetAllCrates) ~= "function" then
			warn("[CrateData] Crate data was not found")
			return false
		end
		local V, Z = pcall(G.GetAllCrates)
		if not V or type(Z) ~= "table" then
			warn("[CrateData] Failed to read crate data")
			return false
		end
		for G, V in ipairs(Z) do
			if type(V) ~= "table" then
				continue
			end
			local y = tostring(V.Name or V.ItemName or "")
			if y == "" then
				continue
			end
			local Z = V.RestockValues
			local j = nil
			local i = nil
			if typeof(Z) == "NumberRange" then
				j = Z.Min
				i = Z.Max
			elseif type(Z) == "table" then
				j = Z.Min
				i = Z.Max
			end
			local c = {
				name = y,
				type = tostring(V.CrateType or "Crate");
				rarity = tostring(V.Rarity or "Unknown"),
				price = u.CrateData.GetPriceCrateData(y, tonumber(V.Cost) or 0),
				icon_id = J.GetAssetId(V.IMG);
				restock_min = tonumber(j) or 0;
				restock_max = tonumber(i) or 0,
				raw = V
			}
			T.AllCrateShopData[y] = c
			table.insert(T.AllCrateShopTable, c)
		end
		table.sort(T.AllCrateShopTable, function(G, V)
			local y = T.RarityRank[tostring(G.rarity or "")] or 0
			local Z = T.RarityRank[tostring(V.rarity or "")] or 0
			if y ~= Z then
				return y > Z
			end
			if tonumber(G.price) ~= tonumber(V.price) then
				return ((tonumber(G.price) or 0)) > ((tonumber(V.price) or 0))
			end
			return tostring(G.name or "") < tostring(V.name or "")
		end)
		return true
	end,
	LoadValidCratesForShop = function()
		table.clear(T.CrateShopDataList)
		if y.CrateShop and y.CrateShop.Items then
			for G, V in ipairs(y.CrateShop.Items:GetChildren()) do
				local y = tostring(V.Name or "")
				if y ~= "" and T.AllCrateShopData[y] then
					T.CrateShopDataList[y] = true
				end
			end
		end
		if next(T.CrateShopDataList) == nil then
			for G in pairs(T.AllCrateShopData) do
				T.CrateShopDataList[G] = true
			end
		end
		return true
	end,
	GetCrateShopDropDown = function()
		local G = {}
		for V, y in ipairs(T.AllCrateShopTable) do
			local Z = tostring(y.name or "")
			if Z == "" or not T.CrateShopDataList[Z] then
				continue
			end
			local j = J.formatShecklesNumber(y.price)
			local i = tostring(y.rarity or "Unknown")
			local c = tostring(y.type or "Crate")
			local d = u.Data.GetRarityColor(i)
			local q = string.format("<font color=\"#FFFFFF\">%s</font> <font color=\"#00FF00\">$%s</font> <font color=\"%s\">%s</font> <font color=\"#FFFFFF\">%s</font>", Z, tostring(j), d, i, c)
			table.insert(G, {
				Text = q,
				Value = Z
			})
		end
		return G
	end,
	GetCrateItemDetails = function(G)
		return T.AllCrateShopData[G]
	end,
	GetCrateStockCurrent = function(G)
		G = tostring(G or "")
		if G == "" or not y.CrateShop or not y.CrateShop.Items then
			return 0
		end
		local V = y.CrateShop.Items:FindFirstChild(G)
		if not V then
			return 0
		end
		return tonumber(V.Value) or 0
	end
}
u.CrateData.LoadAllCrateData()
u.CrateData.LoadValidCratesForShop()
a.ShopMigration = {
	HasExistingSaveShopMigration = function()
		return type(isfile) == "function" and isfile(X)
	end,
	BuildSelectedFromAvoidShopMigration = function(G, V)
		local y = {}
		V = type(V) == "table" and V or {}
		if type(G) ~= "table" then
			return y
		end
		for G, Z in pairs(G) do
			local j = ""
			if type(G) == "string" then
				j = G
			elseif type(Z) == "table" then
				j = tostring(Z.name or Z.ItemName or Z.SeedName or "")
			elseif type(Z) == "string" then
				j = Z
			end
			if j ~= "" and V[j] ~= true then
				y[j] = true
			end
		end
		return y
	end;
	RunSelectedShopMigration = function()
		if e.shop_selected_migration_v1 == true then
			return false
		end
		if not a.ShopMigration.HasExistingSaveShopMigration() then
			e.shop_selected_migration_v1 = true
			return false
		end
		e.seed_shop_buy_selected = a.ShopMigration.BuildSelectedFromAvoidShopMigration(T.SeedShopDataList, e.seed_avoid)
		e.gear_shop_buy_selected = a.ShopMigration.BuildSelectedFromAvoidShopMigration(T.AllGearShopData, e.gear_shop_avoid)
		e.crate_shop_buy_selected = type(e.crate_shop_buy_selected) == "table" and e.crate_shop_buy_selected or {}
		e.enabled_crate_shop = e.enabled_crate_shop == true
		e.shop_selected_migration_v1 = true
		q.Save.SaveDataSync()
		return true
	end
}
a.ShopMigration.RunSelectedShopMigration()
u.GameApi.Start()
u.GameApi.Start()
T.PetRarity = {}
T.PetDataTable = {}
T.PetDataFast = {}
u.PetData = {
	LoadAllPetData = function()
		table.clear(T.PetRarity)
		table.clear(T.PetDataTable)
		table.clear(T.PetDataFast)
		for G, V in pairs(y.PetData) do
			if type(V) == "table" and type(V.DisplayName) == "string" then
				local y = V.DisplayName
				local Z = V.Rarity
				local j = V.BasePrice
				local i = V.SpawnChance
				local c = {
					petname = G;
					displayname = y,
					price = j;
					chance = i;
					rarity = Z
				}
				T.PetDataFast[y] = c
				T.PetRarity[y] = Z
				table.insert(T.PetDataTable, c)
			end
		end
	end,
	GetDropDownPets = function()
		local G = {}
		for V, y in pairs(T.PetDataFast) do
			local Z = tostring(y.displayname or "Unknown")
			local j = J.formatShecklesNumber(y.price)
			local i = tostring(y.rarity or "Unknown")
			local c = tostring(y.chance or "0")
			local T = u.Data.GetRarityColor(i)
			local d = string.format("<font color=\"#FFFFFF\">%s</font> <font color=\"#00FF00\">$%s</font> <font color=\"%s\">%s</font> (%s)", Z, tostring(j), T, i, c)
			local q = {
				Text = d,
				Value = Z
			}
			table.insert(G, q)
		end
		return G
	end
}
u.PetData.LoadAllPetData()
T.EggHatcherStatusText = ""
T.SeedPackOpenerStatusText = ""
T.PackOpeningWebhookStatusText = ""
T.EggHatcherWebhookData = T.EggHatcherWebhookData or {}
T.SeedPackOpenerWebhookData = T.SeedPackOpenerWebhookData or {}
u.PackOpenHelpers = {
	BusyPackOpenHelpers = false;
	RetryAtPackOpenHelpers = setmetatable({}, {
		__mode = "k"
	});
	SelectionIsEmptyPackOpenHelpers = function(G)
		if type(G) ~= "table" then
			return true
		end
		for G, V in pairs(G) do
			if V == true or type(G) == "number" and tostring(V or "") ~= "" then
				return false
			end
		end
		return true
	end,
	IsSelectedPackOpenHelpers = function(G, V)
		if type(G) ~= "table" then
			return false
		end
		V = tostring(V or "")
		if V == "" then
			return false
		end
		if G[V] == true then
			return true
		end
		for G, y in pairs(G) do
			if tostring(y or "") == V then
				return true
			end
		end
		return false
	end,
	PassesSelectedPackOpenHelpers = function(G, V)
		return u.PackOpenHelpers.SelectionIsEmptyPackOpenHelpers(G) or u.PackOpenHelpers.IsSelectedPackOpenHelpers(G, V)
	end,
	PassesNameFilterPackOpenHelpers = function(G, V, y)
		y = tostring(y or "")
		if y == "" then
			return false
		end
		if u.PackOpenHelpers.IsSelectedPackOpenHelpers(V, y) then
			return false
		end
		return u.PackOpenHelpers.PassesSelectedPackOpenHelpers(G, y)
	end;
	GetToolCountPackOpenHelpers = function(G)
		if not G or not G.Parent then
			return 0
		end
		local V = G:GetAttribute("Count") or G:GetAttribute("Amount") or G:GetAttribute("Quantity") or 1
		return math.max(math.floor(tonumber(V) or 1), 1)
	end;
	GetToolsWithAttributePackOpenHelpers = function(G)
		local V = {}
		for y, Z in ipairs(u.Backpack.GetBackpackAllItems()) do
			if Z and Z:IsA("Tool") then
				local y = Z:GetAttribute(G)
				if type(y) == "string" and y ~= "" then
					table.insert(V, Z)
				end
			end
		end
		return V
	end;
	GetNextToolPackOpenHelpers = function(G, V, y)
		local Z = u.PackOpenHelpers.GetToolsWithAttributePackOpenHelpers(G)
		table.sort(Z, function(V, y)
			local Z = tostring(V:GetAttribute(G) or V.Name or "")
			local j = tostring(y:GetAttribute(G) or y.Name or "")
			if Z ~= j then
				return Z < j
			end
			return tostring(V.Name or "") < tostring(y.Name or "")
		end)
		for Z, j in ipairs(Z) do
			if not j or not j.Parent then
				continue
			end
			if os.clock() < ((u.PackOpenHelpers.RetryAtPackOpenHelpers[j] or 0)) then
				continue
			end
			local i = tostring(j:GetAttribute(G) or "")
			if u.PackOpenHelpers.GetToolCountPackOpenHelpers(j) > 0 and u.PackOpenHelpers.PassesNameFilterPackOpenHelpers(V, y, i) then
				return j, i
			end
		end
		return nil, ""
	end;
	GetEggDataPackOpenHelpers = function(G)
		if type(y.EggData) ~= "table" or type(y.EggData.GetData) ~= "function" then
			return nil
		end
		local V, Z = pcall(y.EggData.GetData, G)
		return V and (type(Z) == "table" and Z) or nil
	end,
	GetSeedPackDataPackOpenHelpers = function(G)
		if type(y.SeedPackData) ~= "table" or type(y.SeedPackData.GetData) ~= "function" then
			return nil
		end
		local V, Z = pcall(y.SeedPackData.GetData, G)
		return V and (type(Z) == "table" and Z) or nil
	end,
	GetPetDisplayNamePackOpenHelpers = function(G)
		G = tostring(G or "")
		local V = type(y.PetData) == "table" and y.PetData[G] or nil
		return type(V) == "table" and tostring(V.DisplayName or G) or G
	end,
	GetPetRarityPackOpenHelpers = function(G)
		G = tostring(G or "")
		local V = type(y.PetData) == "table" and y.PetData[G] or nil
		return type(V) == "table" and tostring(V.Rarity or "Unknown") or "Unknown"
	end;
	GetSeedRarityPackOpenHelpers = function(G)
		G = tostring(G or "")
		local V = T.SeedDataFast and T.SeedDataFast[G] or nil
		return type(V) == "table" and tostring(V.rarity or "Unknown") or "Unknown"
	end;
	NormaliseSizePackOpenHelpers = function(G)
		G = tostring(G or "")
		if G == "" then
			return "Normal"
		end
		if type(y.PetSizes) == "table" and type(y.PetSizes.Normalize) == "function" then
			local V, Z = pcall(y.PetSizes.Normalize, G)
			if V and (type(Z) == "string" and Z ~= "") then
				return Z
			end
		end
		return G
	end,
	NormaliseVariantPackOpenHelpers = function(G)
		G = tostring(G or "")
		return G ~= "" and G or "Normal"
	end;
	GetRarityDropdownPackOpenHelpers = function()
		local G = {}
		for V in pairs(T.RarityRank or {}) do
			local y = u.Data.GetRarityColor(V)
			table.insert(G, {
				Text = string.format("<font color=\'%s\'>%s</font>", y, V);
				Value = V;
				Rank = T.RarityRank[V] or 0
			})
		end
		table.sort(G, function(G, V)
			return ((G.Rank or 0)) < ((V.Rank or 0))
		end)
		return G
	end;
	GetSizeDropdownPackOpenHelpers = function()
		local G = {
			"Normal",
			"Big";
			"Huge"
		}
		local V = {}
		for G, y in ipairs(G) do
			table.insert(V, {
				Text = y,
				Value = y
			})
		end
		return V
	end;
	GetVariantDropdownPackOpenHelpers = function()
		return {
			{
				Text = "Normal";
				Value = "Normal"
			};
			{
				Text = "Rainbow",
				Value = "Rainbow"
			}
		}
	end,
	GetEggDropdownPackOpenHelpers = function()
		local G = {}
		local V = type(y.EggData) == "table" and y.EggData.Data or {}
		for V, y in ipairs(type(V) == "table" and V or {}) do
			if type(y) == "table" and type(y.EggName) == "string" then
				local V = tostring(y.Rarity or "Unknown")
				local Z = u.Data.GetRarityColor(V)
				table.insert(G, {
					Text = string.format("<font color=\'#FFFFFF\'>%s</font> <font color=\'%s\'>%s</font>", y.EggName, Z, V),
					Value = y.EggName;
					Rank = T.RarityRank[V] or 0
				})
			end
		end
		table.sort(G, function(G, V)
			if ((G.Rank or 0)) ~= ((V.Rank or 0)) then
				return ((G.Rank or 0)) < ((V.Rank or 0))
			end
			return tostring(G.Value or "") < tostring(V.Value or "")
		end)
		return G
	end,
	GetSeedPackDropdownPackOpenHelpers = function()
		local G = {}
		local V = type(y.SeedPackData) == "table" and y.SeedPackData.Data or {}
		for V, y in ipairs(type(V) == "table" and V or {}) do
			if type(y) == "table" and type(y.PackName) == "string" then
				local V = tostring(y.Rarity or "Unknown")
				local Z = u.Data.GetRarityColor(V)
				table.insert(G, {
					Text = string.format("<font color=\'#FFFFFF\'>%s</font> <font color=\'%s\'>%s</font>", y.PackName, Z, V),
					Value = y.PackName;
					Rank = T.RarityRank[V] or 0
				})
			end
		end
		table.sort(G, function(G, V)
			if ((G.Rank or 0)) ~= ((V.Rank or 0)) then
				return ((G.Rank or 0)) < ((V.Rank or 0))
			end
			return tostring(G.Value or "") < tostring(V.Value or "")
		end)
		return G
	end,
	GetPetDropdownPackOpenHelpers = function()
		local G = {}
		for V, y in ipairs(T.PetDataTable or {}) do
			local Z = tostring(y.petname or "")
			if Z ~= "" then
				local V = tostring(y.displayname or Z)
				local j = tostring(y.rarity or "Unknown")
				local i = u.Data.GetRarityColor(j)
				table.insert(G, {
					Text = string.format("<font color=\'#FFFFFF\'>%s</font> <font color=\'%s\'>%s</font>", V, i, j);
					Value = Z,
					Rank = T.RarityRank[j] or 0
				})
			end
		end
		table.sort(G, function(G, V)
			if ((G.Rank or 0)) ~= ((V.Rank or 0)) then
				return ((G.Rank or 0)) > ((V.Rank or 0))
			end
			return tostring(G.Value or "") < tostring(V.Value or "")
		end)
		return G
	end,
	GetSeedDropdownPackOpenHelpers = function()
		local G = {}
		for V, y in ipairs(T.AllSeedsDataTable or {}) do
			local Z = tostring(y.name or "")
			if Z ~= "" then
				local V = tostring(y.rarity or "Unknown")
				local j = u.Data.GetRarityColor(V)
				table.insert(G, {
					Text = string.format("<font color=\'#FFFFFF\'>%s</font> <font color=\'%s\'>%s</font>", Z, j, V);
					Value = Z;
					Rank = T.RarityRank[V] or 0
				})
			end
		end
		table.sort(G, function(G, V)
			if ((G.Rank or 0)) ~= ((V.Rank or 0)) then
				return ((G.Rank or 0)) > ((V.Rank or 0))
			end
			return tostring(G.Value or "") < tostring(V.Value or "")
		end)
		return G
	end,
	OpenToolByRemotePackOpenHelpers = function(G, V, Z, j)
		if not G or not G.Parent then
			return false, "Tool missing"
		end
		local i = tostring(G:GetAttribute(V) or "")
		if i == "" then
			return false, "Invalid tool"
		end
		if not Z or type(Z.Fire) ~= "function" then
			return false, "Open remote missing"
		end
		local c = u.Player.GetTool_Holding()
		if j == true and G.Parent ~= y.Character then
			if not u.Player.EquipTool(G) then
				return false, "Could not equip tool"
			end
			task.wait(.1)
		end
		local J, T = pcall(function()
			return Z:Fire(i)
		end)
		if c and (c.Parent and (c ~= G and c.Parent ~= y.Character)) then
			pcall(function()
				u.Player.EquipTool(c)
			end)
		end
		if not J then
			return false, tostring(T or "Open failed")
		end
		if type(T) == "table" then
			if T.Success == true then
				return true, T
			end
			return false, tostring(T.Message or T.Reason or T.Error or "Open rejected"), T
		end
		if T == true then
			return true, T
		end
		return false, "Open rejected", T
	end;
	RunOpenCyclePackOpenHelpers = function(G)
		if type(G) ~= "table" or u.PackOpenHelpers.BusyPackOpenHelpers then
			return false
		end
		if G.enabled ~= true then
			G.setStatus("")
			return false
		end
		if T.TrowelRunning then
			G.setStatus("Waiting for trowel", "#FFCC66")
			return false
		end
		if not J.IsLoadingCompleted() then
			G.setStatus("Waiting for loading", "#FFCC66")
			return false
		end
		local V = math.clamp(math.floor(tonumber(G.maxPerCycle) or 1), 1, 20)
		local y = math.clamp(tonumber(G.delay) or .35, .15, 10)
		u.PackOpenHelpers.BusyPackOpenHelpers = true
		local Z = 0
		local j, i = pcall(function()
			for V = 1, V, 1 do
				local j, i = u.PackOpenHelpers.GetNextToolPackOpenHelpers(G.attributeName, G.selected, G.protected)
				if not j then
					if Z == 0 then
						G.setStatus("No matching tools", "#CFCFCF")
					end
					break
				end
				local c, J = u.PackOpenHelpers.OpenToolByRemotePackOpenHelpers(j, G.attributeName, G.remote, G.shouldEquip)
				if c then
					Z += 1
					G.setStatus("Opened " .. (tostring(i) .. (" x" .. tostring(Z))), "#7CFC00")
					task.wait(y)
				else
					u.PackOpenHelpers.RetryAtPackOpenHelpers[j] = os.clock() + 2
					G.setStatus(tostring(J or "Open failed"), "#FF6666")
					break
				end
			end
		end)
		u.PackOpenHelpers.BusyPackOpenHelpers = false
		if not j then
			G.setStatus("System error", "#FF6666")
			warn("[PackOpenHelpers]", i)
			return false
		end
		return Z > 0
	end
}
u.EggHatcher = {
	SetStatusEggHatcher = function(G, V)
		G = tostring(G or "")
		if G == "" then
			T.EggHatcherStatusText = ""
			return false
		end
		T.EggHatcherStatusText = string.format("<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\165\154 [Egg Hatcher]</font> <font color=\'%s\'>%s</font></stroke>", tostring(V or "#FFFFFF"), G)
		return true
	end;
	LoopEggHatcher = function()
		local G = y.Networking and (y.Networking.Egg and y.Networking.Egg.OpenEgg)
		return u.PackOpenHelpers.RunOpenCyclePackOpenHelpers({
			enabled = e.egg_hatcher_enabled == true;
			attributeName = "Egg";
			selected = e.egg_hatcher_selected;
			protected = e.egg_hatcher_protected,
			maxPerCycle = e.egg_hatcher_max_per_cycle;
			delay = e.egg_hatcher_delay;
			remote = G;
			shouldEquip = e.egg_hatcher_equip_tool == true,
			setStatus = u.EggHatcher.SetStatusEggHatcher
		})
	end
}
u.SeedPackOpener = {
	SetStatusSeedPackOpener = function(G, V)
		G = tostring(G or "")
		if G == "" then
			T.SeedPackOpenerStatusText = ""
			return false
		end
		T.SeedPackOpenerStatusText = string.format("<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\142\129 [Seed Pack Opener]</font> <font color=\'%s\'>%s</font></stroke>", tostring(V or "#FFFFFF"), G)
		return true
	end,
	LoopSeedPackOpener = function()
		local G = y.Networking and (y.Networking.SeedPack and y.Networking.SeedPack.OpenSeedPack)
		return u.PackOpenHelpers.RunOpenCyclePackOpenHelpers({
			enabled = e.seed_pack_opener_enabled == true;
			attributeName = "SeedPack";
			selected = e.seed_pack_opener_selected;
			protected = e.seed_pack_opener_protected,
			maxPerCycle = e.seed_pack_opener_max_per_cycle,
			delay = e.seed_pack_opener_delay;
			remote = G,
			shouldEquip = e.seed_pack_opener_equip_tool == true,
			setStatus = u.SeedPackOpener.SetStatusSeedPackOpener
		})
	end
}
T.BackpackFruitPriceEspStatusText = ""
T.BackpackFruitTotalValueStatusText = ""
u.BackpackFruitPriceEsp = {
	StartedBackpackFruitPriceEsp = false,
	LastShownBackpackFruitPriceEsp = 0;
	LastTotalShownBackpackFruitPriceEsp = 0;
	SetStatusBackpackFruitPriceEsp = function(G, V)
		G = tostring(G or "")
		if G == "" then
			T.BackpackFruitPriceEspStatusText = ""
			return false
		end
		T.BackpackFruitPriceEspStatusText = string.format("<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\146\176 [Backpack Price]</font> <font color=\'%s\'>%s</font></stroke>", tostring(V or "#FFFFFF"), G)
		return true
	end;
	SetTotalStatusBackpackFruitPriceEsp = function(G, V)
		G = tostring(G or "")
		if G == "" then
			T.BackpackFruitTotalValueStatusText = ""
			return false
		end
		T.BackpackFruitTotalValueStatusText = string.format("<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\146\142 [Fruit Inventory]</font> <font color=\'%s\'>%s</font></stroke>", tostring(V or "#FFFFFF"), G)
		return true
	end,
	CleanTextBackpackFruitPriceEsp = function(G)
		G = tostring(G or "")
		G = G:gsub("<[^>]+>", "")
		return G:match("^%s*(.-)%s*$") or ""
	end;
	GetBackpackGuiBackpackFruitPriceEsp = function()
		local G = y.PlayerGui or (y.LocalPlayer and y.LocalPlayer:FindFirstChild("PlayerGui"))
		local V = G and G:FindFirstChild("BackpackGui")
		local Z = V and V:FindFirstChild("Backpack")
		return Z
	end,
	GetSlotRootsBackpackFruitPriceEsp = function()
		local G = {}
		local V = u.BackpackFruitPriceEsp.GetBackpackGuiBackpackFruitPriceEsp()
		if not V then
			return G
		end
		local y = V:FindFirstChild("Hotbar")
		if y then
			table.insert(G, y)
		end
		local Z = V:FindFirstChild("Inventory")
		local j = Z and Z:FindFirstChild("ScrollingFrame")
		local i = j and j:FindFirstChild("UIGridFrame")
		if i then
			table.insert(G, i)
		end
		return G
	end;
	GetSlotsBackpackFruitPriceEsp = function()
		local G = {}
		for V, y in ipairs(u.BackpackFruitPriceEsp.GetSlotRootsBackpackFruitPriceEsp()) do
			for V, y in ipairs(y:GetChildren()) do
				if y:IsA("GuiObject") and y:FindFirstChild("ToolName", true) then
					table.insert(G, y)
				end
			end
		end
		table.sort(G, function(G, V)
			local y = tonumber(G.LayoutOrder) or tonumber(G.Name) or 0
			local Z = tonumber(V.LayoutOrder) or tonumber(V.Name) or 0
			if y ~= Z then
				return y < Z
			end
			return tostring(G.Name or "") < tostring(V.Name or "")
		end)
		return G
	end,
	FormatWeightBackpackFruitPriceEsp = function(G)
		local V = tonumber(G)
		if not V then
			return ""
		end
		if type(y.WeightFormat) == "table" and type(y.WeightFormat.FormatGrams) == "function" then
			local G, Z = pcall(function()
				return y.WeightFormat.FormatGrams(V)
			end)
			if G and (type(Z) == "string" and Z ~= "") then
				return Z
			end
		end
		local Z = string.format("%.2fkg", V)
		return Z:gsub("%.00kg", "kg")
	end;
	GetToolFruitNameBackpackFruitPriceEsp = function(G)
		if typeof(G) ~= "Instance" or not G.Parent then
			return "", ""
		end
		local V = G:IsA("Tool") and ((G:GetAttribute("HarvestedFruit") == true or G:GetAttribute("Fruit") ~= nil or G:GetAttribute("FruitName") ~= nil))
		local y = G:IsA("Configuration") and (G:GetAttribute("FruitProxy") == true and G:GetAttribute("HarvestedFruit") == true)
		if not V and not y then
			return "", ""
		end
		local Z = G:GetAttribute("Fruit") or G:GetAttribute("FruitName")
		local j = G:GetAttribute("FruitName") or G:GetAttribute("Fruit")
		Z = type(Z) == "string" and Z or ""
		j = type(j) == "string" and j or Z
		return Z, j
	end;
	BuildFruitDataBackpackFruitPriceEsp = function(G)
		if typeof(G) ~= "Instance" or not G.Parent then
			return nil
		end
		local V, y = u.BackpackFruitPriceEsp.GetToolFruitNameBackpackFruitPriceEsp(G)
		if V == "" or y == "" then
			return nil
		end
		local Z = nil
		if u.SellManager and type(u.SellManager.BuildBackpackFruitData) == "function" then
			local V, y = pcall(function()
				return u.SellManager.BuildBackpackFruitData(G)
			end)
			if V and type(y) == "table" then
				Z = y
			end
		end
		Z = type(Z) == "table" and Z or {}
		local j = tonumber(Z.kg or Z.weight or Z.w or G:GetAttribute("Weight") or G:GetAttribute("weight") or G:GetAttribute("KG") or G:GetAttribute("Kg") or 0) or 0
		local i = tostring(Z.kgText or Z.weightText or Z.wText or "")
		if i == "" then
			i = u.BackpackFruitPriceEsp.FormatWeightBackpackFruitPriceEsp(j)
		end
		local c = Z.Mutation or Z.mutation or Z.rawMutation or G:GetAttribute("Mutation")
		local J = Z.SizeMultiplier or Z.SizeMulti or Z.sizeMultiplier or Z.size or G:GetAttribute("SizeMultiplier") or G:GetAttribute("SizeMulti")
		return {
			ob = G;
			id = tostring(Z.id or Z.Id or G:GetAttribute("Id") or G.Name or ""),
			displayName = V;
			calcName = y;
			weight = j;
			weightText = i,
			mutation = c;
			sourceData = {
				SizeMultiplier = J,
				SizeMulti = J;
				DecayAlpha = Z.DecayAlpha or Z.decayAlpha or G:GetAttribute("DecayAlpha");
				Mutation = c
			}
		}
	end;
	GetToolWeightTextBackpackFruitPriceEsp = function(G)
		local V = u.BackpackFruitPriceEsp.BuildFruitDataBackpackFruitPriceEsp(G)
		return V and tostring(V.weightText or "") or ""
	end;
	GetToolPriceBackpackFruitPriceEsp = function(G)
		local V = u.BackpackFruitPriceEsp.BuildFruitDataBackpackFruitPriceEsp(G)
		if not V or V.calcName == "" or type(u.BuySelectFruit) ~= "table" or type(u.BuySelectFruit.GetEstimatedPriceBuySelectFruit) ~= "function" then
			return 0, 1, "none"
		end
		local y, Z, j = u.BuySelectFruit.GetEstimatedPriceBuySelectFruit(V.calcName, V.sourceData, V.mutation)
		return math.max(math.floor(tonumber(y) or 0), 0), tonumber(Z) or 1, tostring(j or "none")
	end,
	BuildToolBucketsBackpackFruitPriceEsp = function()
		local G = {}
		local V = {}
		for y, Z in ipairs(u.Backpack.GetBackpackAllItems()) do
			if typeof(Z) ~= "Instance" or V[Z] then
				continue
			end
			V[Z] = true
			local j = u.BackpackFruitPriceEsp.BuildFruitDataBackpackFruitPriceEsp(Z)
			if not j then
				continue
			end
			local i, c, J = u.BackpackFruitPriceEsp.GetToolPriceBackpackFruitPriceEsp(Z)
			local T = tostring(j.displayName) .. ("||" .. tostring(j.weightText))
			local d = tostring(j.displayName) .. "||"
			local q = {
				item = Z,
				displayName = j.displayName;
				weightText = j.weightText;
				price = i;
				multiplier = c,
				tier = J,
				signature = tostring(j.id) .. ("|" .. (tostring(i) .. ("|" .. (tostring(c) .. ("|" .. tostring(J))))))
			}
			if not G[T] then
				G[T] = {}
			end
			table.insert(G[T], q)
			if T ~= d then
				if not G[d] then
					G[d] = {}
				end
				table.insert(G[d], q)
			end
		end
		for G, V in pairs(G) do
			table.sort(V, function(G, V)
				return tostring(G.signature or "") < tostring(V.signature or "")
			end)
			V._index = 0
		end
		return G
	end;
	GetSlotFruitKeyBackpackFruitPriceEsp = function(G)
		if not G or not G.Parent then
			return "", ""
		end
		local V = G:FindFirstChild("ToolName", true)
		local y = G:FindFirstChild("ToolCount", true)
		local Z = u.BackpackFruitPriceEsp.CleanTextBackpackFruitPriceEsp(V and V.Text or "")
		local j = u.BackpackFruitPriceEsp.CleanTextBackpackFruitPriceEsp(y and y.Text or "")
		if Z == "" or j == "" or not (j:lower()):find("kg", 1, true) then
			return "", ""
		end
		return Z .. ("||" .. j), Z .. "||"
	end;
	GetOrCreateLabelBackpackFruitPriceEsp = function(G)
		if not G or not G.Parent then
			return nil
		end
		local V = G:FindFirstChild("ExoFruitPriceLabel")
		if V and V:IsA("TextLabel") then
			return V
		end
		V = Instance.new("TextLabel")
		V.Name = "ExoFruitPriceLabel"
		V.AnchorPoint = Vector2.new(.5, 0)
		V.Position = UDim2.new(.5, 0, 0, 1)
		V.Size = UDim2.new(1, - 4, 0, 14)
		V.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		V.BackgroundTransparency = .35
		V.BorderSizePixel = 0
		V.Font = Enum.Font.GothamBold
		V.TextColor3 = Color3.fromRGB(70, 255, 120)
		V.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		V.TextStrokeTransparency = .25
		V.TextScaled = true
		V.TextWrapped = false
		V.TextXAlignment = Enum.TextXAlignment.Center
		V.TextYAlignment = Enum.TextYAlignment.Center
		V.ZIndex = math.max(((G.ZIndex or 1)) + 25, 25)
		V.Active = false
		V.Parent = G
		local y = Instance.new("UICorner")
		y.CornerRadius = UDim.new(0, 3)
		y.Parent = V
		local Z = Instance.new("UITextSizeConstraint")
		Z.MinTextSize = 8
		Z.MaxTextSize = 14
		Z.Parent = V
		return V
	end;
	RemoveSlotLabelBackpackFruitPriceEsp = function(G)
		local V = G and G:FindFirstChild("ExoFruitPriceLabel")
		if V then
			V:Destroy()
		end
	end;
	ClearLabelsBackpackFruitPriceEsp = function()
		for G, V in ipairs(u.BackpackFruitPriceEsp.GetSlotRootsBackpackFruitPriceEsp()) do
			for G, V in ipairs(V:GetDescendants()) do
				if V.Name == "ExoFruitPriceLabel" then
					V:Destroy()
				end
			end
		end
		u.BackpackFruitPriceEsp.LastShownBackpackFruitPriceEsp = 0
		u.BackpackFruitPriceEsp.SetStatusBackpackFruitPriceEsp("")
	end;
	FormatPriceBackpackFruitPriceEsp = function(G)
		if type(u.BuySelectFruit) == "table" and type(u.BuySelectFruit.FormatPriceBuySelectFruit) == "function" then
			return u.BuySelectFruit.FormatPriceBuySelectFruit(G)
		end
		if d and (d.Currency and type(d.Currency.FormatMoney) == "function") then
			return d.Currency.FormatMoney(G)
		end
		return tostring(math.floor(tonumber(G) or 0))
	end;
	GetOrCreateTotalLabelBackpackFruitPriceEsp = function()
		local G = u.BackpackFruitPriceEsp.GetBackpackGuiBackpackFruitPriceEsp()
		if not G then
			return nil
		end
		local V = G:FindFirstChild("ExoFruitTotalValueLabel")
		if V and V:IsA("TextLabel") then
			return V
		end
		V = Instance.new("TextLabel")
		V.Name = "ExoFruitTotalValueLabel"
		V.AnchorPoint = Vector2.new(.5, 0)
		V.Position = UDim2.new(.5, 0, 0, 3)
		V.Size = UDim2.new(0, 260, 0, 22)
		V.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		V.BackgroundTransparency = .25
		V.BorderSizePixel = 0
		V.Font = Enum.Font.GothamBold
		V.RichText = true
		V.TextColor3 = Color3.fromRGB(255, 255, 255)
		V.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		V.TextStrokeTransparency = .25
		V.TextScaled = true
		V.TextWrapped = false
		V.TextXAlignment = Enum.TextXAlignment.Center
		V.TextYAlignment = Enum.TextYAlignment.Center
		V.ZIndex = 999
		V.Active = false
		V.Parent = G
		local y = Instance.new("UICorner")
		y.CornerRadius = UDim.new(0, 5)
		y.Parent = V
		local Z = Instance.new("UITextSizeConstraint")
		Z.MinTextSize = 10
		Z.MaxTextSize = 18
		Z.Parent = V
		return V
	end,
	ClearTotalLabelBackpackFruitPriceEsp = function()
		local G = u.BackpackFruitPriceEsp.GetBackpackGuiBackpackFruitPriceEsp()
		local V = G and G:FindFirstChild("ExoFruitTotalValueLabel")
		if V then
			V:Destroy()
		end
		u.BackpackFruitPriceEsp.LastTotalShownBackpackFruitPriceEsp = 0
		u.BackpackFruitPriceEsp.SetTotalStatusBackpackFruitPriceEsp("")
	end;
	BuildInventoryTotalBackpackFruitPriceEsp = function()
		local G = 0
		local V = 0
		local y = 0
		local Z = {}
		if type(u.BuySelectFruit) == "table" and type(u.BuySelectFruit.EnsureFruitStockReadyBuySelectFruit) == "function" then
			u.BuySelectFruit.EnsureFruitStockReadyBuySelectFruit(false)
		end
		for j, i in ipairs(u.Backpack.GetBackpackAllItems()) do
			if typeof(i) ~= "Instance" or Z[i] then
				continue
			end
			Z[i] = true
			local c = u.BackpackFruitPriceEsp.BuildFruitDataBackpackFruitPriceEsp(i)
			if not c then
				continue
			end
			V += 1
			local J = u.BackpackFruitPriceEsp.GetToolPriceBackpackFruitPriceEsp(i)
			J = math.max(math.floor(tonumber(J) or 0), 0)
			if J > 0 then
				y += 1
				G += J
			end
		end
		return G, V, y
	end,
	RefreshTotalValueBackpackFruitPriceEsp = function()
		if e.backpack_fruit_total_value_esp_enabled ~= true then
			u.BackpackFruitPriceEsp.ClearTotalLabelBackpackFruitPriceEsp()
			return false
		end
		local G, V, y = u.BackpackFruitPriceEsp.BuildInventoryTotalBackpackFruitPriceEsp()
		local Z = u.BackpackFruitPriceEsp.FormatPriceBackpackFruitPriceEsp(G)
		local j = u.BackpackFruitPriceEsp.GetOrCreateTotalLabelBackpackFruitPriceEsp()
		if j then
			j.Text = string.format("<font color=\'#FFD700\'>Inventory Value:</font> <font color=\'#7CFC00\'>$%s</font> <font color=\'#FFFFFF\'>(%d fruits)</font>", Z, V)
			j.Visible = true
		end
		u.BackpackFruitPriceEsp.LastTotalShownBackpackFruitPriceEsp = V
		u.BackpackFruitPriceEsp.SetTotalStatusBackpackFruitPriceEsp(string.format("$%s from %d fruit%s", Z, V, V == 1 and "" or "s"), y > 0 and "#7CFC00" or "#FFCC66")
		return true
	end,
	RefreshBackpackFruitPriceEsp = function()
		if e.backpack_fruit_price_esp_enabled ~= true then
			if u.BackpackFruitPriceEsp.LastShownBackpackFruitPriceEsp > 0 then
				u.BackpackFruitPriceEsp.ClearLabelsBackpackFruitPriceEsp()
			end
			u.BackpackFruitPriceEsp.RefreshTotalValueBackpackFruitPriceEsp()
			return false
		end
		if type(u.BuySelectFruit) == "table" and type(u.BuySelectFruit.EnsureFruitStockReadyBuySelectFruit) == "function" then
			u.BuySelectFruit.EnsureFruitStockReadyBuySelectFruit(false)
		end
		local G = u.BackpackFruitPriceEsp.BuildToolBucketsBackpackFruitPriceEsp()
		local V = 0
		for y, Z in ipairs(u.BackpackFruitPriceEsp.GetSlotsBackpackFruitPriceEsp()) do
			local j, i = u.BackpackFruitPriceEsp.GetSlotFruitKeyBackpackFruitPriceEsp(Z)
			local c = j ~= "" and G[j] or nil
			if ((not c or c._index >= # c)) and i ~= "" then
				c = G[i]
			end
			if not c or c._index >= # c then
				u.BackpackFruitPriceEsp.RemoveSlotLabelBackpackFruitPriceEsp(Z)
				continue
			end
			c._index += 1
			local J = c[c._index]
			if not J or ((tonumber(J.price) or 0)) <= 0 then
				u.BackpackFruitPriceEsp.RemoveSlotLabelBackpackFruitPriceEsp(Z)
				continue
			end
			local T = u.BackpackFruitPriceEsp.GetOrCreateLabelBackpackFruitPriceEsp(Z)
			if T then
				local G = u.BackpackFruitPriceEsp.FormatPriceBackpackFruitPriceEsp(J.price)
				local y = tonumber(J.multiplier) or 1
				T.Text = y ~= 1 and string.format("$%s x%s", G, tostring(math.floor(y * 100 + .5) / 100)) or "$" .. G
				T.Visible = true
				V += 1
			end
		end
		u.BackpackFruitPriceEsp.LastShownBackpackFruitPriceEsp = V
		u.BackpackFruitPriceEsp.SetStatusBackpackFruitPriceEsp(V > 0 and string.format("Showing %d fruit prices", V) or "No fruit slots found", V > 0 and "#7CFC00" or "#FFCC66")
		u.BackpackFruitPriceEsp.RefreshTotalValueBackpackFruitPriceEsp()
		return true
	end;
	StartBackpackFruitPriceEsp = function()
		local G = u.BackpackFruitPriceEsp
		if G.StartedBackpackFruitPriceEsp then
			return false
		end
		G.StartedBackpackFruitPriceEsp = true
		task.spawn(function()
			while G.StartedBackpackFruitPriceEsp and not T.is_forced_stop do
				local V, y = pcall(G.RefreshBackpackFruitPriceEsp)
				if not V then
					warn("[BackpackFruitPriceEsp]", y)
				end
				task.wait(.75)
			end
			G.ClearLabelsBackpackFruitPriceEsp()
			G.ClearTotalLabelBackpackFruitPriceEsp()
		end)
		return true
	end
}
u.WeatherTriggers = {
	CachedAllOptionsWeatherTriggers = nil;
	CachedTimeCycleOptionsWeatherTriggers = nil;
	CachedWeatherOptionsWeatherTriggers = nil,
	CachedPhaseLookupWeatherTriggers = nil,
	CachedTimeCycleLookupWeatherTriggers = nil;
	CachedWeatherLookupWeatherTriggers = nil,
	NormaliseWeatherTriggers = function(G)
		return ((tostring(G or "")):lower()):gsub("%s+", "")
	end;
	AddNameWeatherTriggers = function(G, V, y)
		y = (tostring(y or "")):match("^%s*(.-)%s*$") or ""
		if y == "" then
			return false
		end
		local Z = u.WeatherTriggers.NormaliseWeatherTriggers(y)
		if Z == "" or V[Z] then
			return false
		end
		V[Z] = y
		table.insert(G, y)
		return true
	end,
	AddInstanceNamesWeatherTriggers = function(G, V, y)
		if not y or not y.Parent then
			return false
		end
		local Z = y:GetChildren()
		table.sort(Z, function(G, V)
			return tostring(G.Name or "") < tostring(V.Name or "")
		end)
		for y, Z in ipairs(Z) do
			if Z:IsA("ModuleScript") or Z:IsA("Folder") then
				u.WeatherTriggers.AddNameWeatherTriggers(G, V, Z.Name)
			end
		end
		return true
	end,
	GetControllerRootWeatherTriggers = function(G)
		local V = y.LocalPlayer and y.LocalPlayer:FindFirstChild("PlayerScripts")
		local Z = V and V:FindFirstChild("Controllers")
		return Z and Z:FindFirstChild(G) or nil
	end;
	BuildTimeCycleOptionsWeatherTriggers = function()
		local G = {}
		local V = {}
		local Z = {}
		local j = y.TimeCycleData and y.TimeCycleData.Data
		local i = {}
		if type(j) == "table" then
			for G, V in pairs(j) do
				if type(G) == "string" and G ~= "" then
					table.insert(i, {
						name = G,
						order = type(V) == "table" and tonumber(V.StartOrder) or 999
					})
					Z[u.WeatherTriggers.NormaliseWeatherTriggers(G)] = true
				end
			end
			table.sort(i, function(G, V)
				if G.order ~= V.order then
					return G.order < V.order
				end
				return tostring(G.name or "") < tostring(V.name or "")
			end)
			for y, Z in ipairs(i) do
				u.WeatherTriggers.AddNameWeatherTriggers(G, V, Z.name)
			end
			for y, Z in ipairs(i) do
				local i = j[Z.name]
				local c = type(i) == "table" and i.Weathers or nil
				local J = {}
				if type(c) == "table" then
					for G in pairs(c) do
						table.insert(J, tostring(G or ""))
					end
				end
				table.sort(J)
				for y, Z in ipairs(J) do
					u.WeatherTriggers.AddNameWeatherTriggers(G, V, Z)
				end
			end
		end
		local c = u.WeatherTriggers.GetControllerRootWeatherTriggers("TimeCycleController")
		local J = c and c:FindFirstChild("Phases")
		u.WeatherTriggers.AddInstanceNamesWeatherTriggers(G, V, J)
		return G, V, Z
	end;
	BuildWeatherOptionsWeatherTriggers = function()
		local G = {}
		local V = {}
		local Z = y.WeatherData and y.WeatherData.Data
		if type(Z) == "table" then
			for y, Z in ipairs(Z) do
				if type(Z) == "table" then
					u.WeatherTriggers.AddNameWeatherTriggers(G, V, Z.Name)
				end
			end
		end
		local j = u.WeatherTriggers.GetControllerRootWeatherTriggers("WeatherController")
		u.WeatherTriggers.AddInstanceNamesWeatherTriggers(G, V, j)
		return G, V
	end,
	AddSavedOptionsWeatherTriggers = function(G, V)
		u.WeatherTriggers.AddNameWeatherTriggers(G, V, e.seed_shop_trigger_name)
		u.WeatherTriggers.AddNameWeatherTriggers(G, V, e.gear_shop_trigger_name)
		u.WeatherTriggers.AddNameWeatherTriggers(G, V, e.crate_shop_trigger_name)
		local y = {
			e.water_plant_weather_selected;
			e.sprinkler_place_weather_selected
		}
		for y, Z in ipairs(y) do
			if type(Z) == "table" then
				for y, Z in pairs(Z) do
					u.WeatherTriggers.AddNameWeatherTriggers(G, V, Z == true and y or Z)
				end
			end
		end
		if type(e.pet_equip_rules) == "table" then
			for y, Z in ipairs(e.pet_equip_rules) do
				if type(Z) == "table" then
					u.WeatherTriggers.AddNameWeatherTriggers(G, V, Z.triggerName)
				end
			end
		end
		return true
	end;
	EnsureOptionsWeatherTriggers = function()
		if u.WeatherTriggers.CachedAllOptionsWeatherTriggers then
			return true
		end
		local G, V, y = u.WeatherTriggers.BuildTimeCycleOptionsWeatherTriggers()
		local Z, j = u.WeatherTriggers.BuildWeatherOptionsWeatherTriggers()
		local i = {}
		local c = {}
		u.WeatherTriggers.AddNameWeatherTriggers(i, c, "Any Time")
		for G, V in ipairs(G) do
			u.WeatherTriggers.AddNameWeatherTriggers(i, c, V)
		end
		for G, V in ipairs(Z) do
			u.WeatherTriggers.AddNameWeatherTriggers(i, c, V)
		end
		u.WeatherTriggers.AddSavedOptionsWeatherTriggers(i, c)
		u.WeatherTriggers.CachedAllOptionsWeatherTriggers = i
		u.WeatherTriggers.CachedTimeCycleOptionsWeatherTriggers = G
		u.WeatherTriggers.CachedWeatherOptionsWeatherTriggers = Z
		u.WeatherTriggers.CachedPhaseLookupWeatherTriggers = y
		u.WeatherTriggers.CachedTimeCycleLookupWeatherTriggers = V
		u.WeatherTriggers.CachedWeatherLookupWeatherTriggers = j
		return true
	end,
	GetOptionsWeatherTriggers = function()
		u.WeatherTriggers.EnsureOptionsWeatherTriggers()
		local G = {}
		for V, y in ipairs(u.WeatherTriggers.CachedAllOptionsWeatherTriggers or {
			"Any Time"
		}) do
			table.insert(G, y)
		end
		return G
	end,
	GetTimeCycleOptionsWeatherTriggers = function()
		u.WeatherTriggers.EnsureOptionsWeatherTriggers()
		local G = {}
		for V, y in ipairs(u.WeatherTriggers.CachedTimeCycleOptionsWeatherTriggers or {}) do
			table.insert(G, y)
		end
		return G
	end;
	GetWeatherOptionsWeatherTriggers = function()
		u.WeatherTriggers.EnsureOptionsWeatherTriggers()
		local G = {}
		for V, y in ipairs(u.WeatherTriggers.CachedWeatherOptionsWeatherTriggers or {}) do
			table.insert(G, y)
		end
		return G
	end,
	IsTimeCyclePhaseWeatherTriggers = function(G)
		u.WeatherTriggers.EnsureOptionsWeatherTriggers()
		local V = u.WeatherTriggers.NormaliseWeatherTriggers(G)
		return V ~= "" and (u.WeatherTriggers.CachedPhaseLookupWeatherTriggers and u.WeatherTriggers.CachedPhaseLookupWeatherTriggers[V] == true)
	end,
	IsTimeCycleNameWeatherTriggers = function(G)
		u.WeatherTriggers.EnsureOptionsWeatherTriggers()
		local V = u.WeatherTriggers.NormaliseWeatherTriggers(G)
		return V ~= "" and (u.WeatherTriggers.CachedTimeCycleLookupWeatherTriggers and u.WeatherTriggers.CachedTimeCycleLookupWeatherTriggers[V] ~= nil)
	end,
	IsWeatherNameWeatherTriggers = function(G)
		u.WeatherTriggers.EnsureOptionsWeatherTriggers()
		local V = u.WeatherTriggers.NormaliseWeatherTriggers(G)
		return V ~= "" and (u.WeatherTriggers.CachedWeatherLookupWeatherTriggers and u.WeatherTriggers.CachedWeatherLookupWeatherTriggers[V] ~= nil)
	end;
	IsSelectionEmptyWeatherTriggers = function(G)
		if type(G) ~= "table" then
			return true
		end
		for G, V in pairs(G) do
			if V == true or type(G) == "number" and tostring(V or "") ~= "" then
				return false
			end
		end
		return true
	end,
	IsSelectedWeatherTriggers = function(G, V)
		V = tostring(V or "")
		if V == "" or type(G) ~= "table" then
			return false
		end
		if G[V] == true then
			return true
		end
		for G, y in pairs(G) do
			if tostring(y or "") == V then
				return true
			end
		end
		return false
	end,
	ForEachSelectedWeatherTriggers = function(G, V)
		if type(G) ~= "table" or type(V) ~= "function" then
			return false
		end
		local y = {}
		for G, Z in pairs(G) do
			local j = Z == true and G or Z
			j = tostring(j or "")
			local i = u.WeatherTriggers.NormaliseWeatherTriggers(j)
			if j ~= "" and not y[i] then
				y[i] = true
				if V(j) == true then
					return true
				end
			end
		end
		return false
	end,
	NamesMatchWeatherTriggers = function(G, V)
		return u.WeatherTriggers.NormaliseWeatherTriggers(G) == u.WeatherTriggers.NormaliseWeatherTriggers(V)
	end;
	GetWeatherValuesWeatherTriggers = function()
		return y.ReplicatedStorage and y.ReplicatedStorage:FindFirstChild("WeatherValues") or nil
	end,
	GetDropdownWeatherTriggers = function()
		local G = {}
		for V, y in ipairs(u.WeatherTriggers.GetOptionsWeatherTriggers()) do
			table.insert(G, {
				Text = y,
				Value = y
			})
		end
		return G
	end;
	GetCurrentTextWeatherTriggers = function()
		local G = tostring(y.Workspace:GetAttribute("ActiveWeather") or "")
		local V = tostring(y.Workspace:GetAttribute("ActivePhase") or "")
		if G ~= "" and V ~= "" then
			return G .. (" / " .. V)
		end
		if G ~= "" then
			return G
		end
		if V ~= "" then
			return V
		end
		return "None"
	end,
	IsTriggerActiveWeatherTriggers = function(G)
		G = tostring(G or "")
		if G == "" or G == "Any Time" then
			return true
		end
		local V = u.WeatherTriggers.GetWeatherValuesWeatherTriggers()
		if V and V:GetAttribute(G .. "_Playing") == true then
			return true
		end
		if u.WeatherTriggers.NamesMatchWeatherTriggers(y.Workspace:GetAttribute("ActiveWeather"), G) then
			return true
		end
		if u.WeatherTriggers.NamesMatchWeatherTriggers(y.Workspace:GetAttribute("ActivePhase"), G) then
			return true
		end
		return false
	end,
	IsActiveWeatherTriggers = function(G, V)
		if G ~= true or u.WeatherTriggers.IsSelectionEmptyWeatherTriggers(V) then
			return true, u.WeatherTriggers.GetCurrentTextWeatherTriggers()
		end
		local y = nil
		u.WeatherTriggers.ForEachSelectedWeatherTriggers(V, function(G)
			if G == "Any Time" then
				y = u.WeatherTriggers.GetCurrentTextWeatherTriggers()
				return true
			end
			if u.WeatherTriggers.IsTriggerActiveWeatherTriggers(G) then
				y = G
				return true
			end
			return false
		end)
		if y then
			return true, y
		end
		return false, u.WeatherTriggers.GetCurrentTextWeatherTriggers()
	end
}
T.AutoFruitFavouriteStatusText = ""
T.ManualFruitFavouriteStatusText = ""
u.FruitFavouriteManager = {
	BusyAutoFruitFavouriteManager = false,
	BusyManualFruitFavouriteManager = false;
	SetStatusAutoFruitFavouriteManager = function(G, V)
		G = tostring(G or "")
		if G == "" then
			T.AutoFruitFavouriteStatusText = ""
			return false
		end
		T.AutoFruitFavouriteStatusText = string.format("<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\226\173\144 [Auto Favourite]</font> <font color=\'%s\'>%s</font></stroke>", tostring(V or "#FFFFFF"), G)
		return true
	end,
	SetStatusManualFruitFavouriteManager = function(G, V)
		G = tostring(G or "")
		if G == "" then
			T.ManualFruitFavouriteStatusText = ""
			return false
		end
		T.ManualFruitFavouriteStatusText = string.format("<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\226\173\144 [Manual Favourite]</font> <font color=\'%s\'>%s</font></stroke>", tostring(V or "#FFFFFF"), G)
		return true
	end;
	IsFavouriteFruitFavouriteManager = function(G)
		if typeof(G) ~= "Instance" then
			return false
		end
		return G:GetAttribute("IsFavorite") == true or G:GetAttribute("Favorite") == true or G:GetAttribute("Favourite") == true or G:GetAttribute("Favorited") == true or G:GetAttribute("Favourited") == true
	end;
	GetRemoteFruitFavouriteManager = function()
		return y.Networking and (y.Networking.Backpack and y.Networking.Backpack.SetFruitFavorite) or nil
	end;
	SetFavouriteFruitFavouriteManager = function(G, V, y)
		V = tostring(V or "")
		if V == "" then
			return false, "Fruit id missing"
		end
		local Z = u.FruitFavouriteManager.GetRemoteFruitFavouriteManager()
		if not Z or type(Z.Fire) ~= "function" then
			return false, "Favourite remote missing"
		end
		local j, i = pcall(function()
			return Z:Fire(V, y == true)
		end)
		if not j or i == false then
			return false, "Favourite rejected"
		end
		if typeof(G) == "Instance" then
			G:SetAttribute("IsFavorite", y == true and true or nil)
		end
		return true
	end,
	NeedsPriceFruitFavouriteManager = function()
		return ((tonumber(e.auto_fruit_favourite_max_value) or 0)) > 0 or ((tonumber(e.manual_fruit_favourite_max_value) or 0)) > 0
	end,
	BuildFruitDataFruitFavouriteManager = function(G)
		if typeof(G) ~= "Instance" or not G.Parent then
			return nil
		end
		local V = u.BackpackFruitPriceEsp.BuildFruitDataBackpackFruitPriceEsp(G)
		if type(V) ~= "table" or tostring(V.id or "") == "" then
			return nil
		end
		local y = 0
		if u.FruitFavouriteManager.NeedsPriceFruitFavouriteManager() then
			y = u.BackpackFruitPriceEsp.GetToolPriceBackpackFruitPriceEsp(G)
		end
		local Z = u.FruitFilters.RoundWeight(V.weight or V.kg or G:GetAttribute("weight") or G:GetAttribute("Weight") or G:GetAttribute("KG") or G:GetAttribute("Kg") or 0)
		local j, i = u.FruitFilters.GetMutationLookup({
			ob = G,
			m = V.mutation
		})
		local c = u.FruitFilters.GetFruitVariant({
			ob = G;
			v = V.variant;
			m = V.mutation
		}, i)
		return {
			ob = G;
			id = tostring(V.id or ""),
			name = tostring(V.calcName or V.displayName or ""),
			displayName = tostring(V.displayName or V.calcName or "");
			kg = Z;
			price = math.max(math.floor(tonumber(y) or 0), 0);
			mutationLookup = i,
			variant = c
		}
	end,
	GetBackpackFruitsFruitFavouriteManager = function()
		local G = {}
		local V = {}
		if u.FruitFavouriteManager.NeedsPriceFruitFavouriteManager() and (type(u.BuySelectFruit) == "table" and type(u.BuySelectFruit.EnsureFruitStockReadyBuySelectFruit) == "function") then
			u.BuySelectFruit.EnsureFruitStockReadyBuySelectFruit(false)
		end
		for y, Z in ipairs(u.Backpack.GetBackpackAllItems()) do
			if typeof(Z) ~= "Instance" or V[Z] then
				continue
			end
			V[Z] = true
			local j = u.FruitFavouriteManager.BuildFruitDataFruitFavouriteManager(Z)
			if j then
				table.insert(G, j)
			end
		end
		table.sort(G, function(G, V)
			if ((tonumber(G.kg) or 0)) ~= ((tonumber(V.kg) or 0)) then
				return ((tonumber(G.kg) or 0)) > ((tonumber(V.kg) or 0))
			end
			if ((tonumber(G.price) or 0)) ~= ((tonumber(V.price) or 0)) then
				return ((tonumber(G.price) or 0)) > ((tonumber(V.price) or 0))
			end
			return tostring(G.id or "") < tostring(V.id or "")
		end)
		return G
	end;
	PassesFilterSetFruitFavouriteManager = function(G, V, y, Z, j, i, c)
		if type(G) ~= "table" or G.id == "" or G.name == "" then
			return false
		end
		if not u.FruitFilters.IsSelectionEmpty(V) and not u.FruitFilters.IsSelected(V, G.name) then
			return false
		end
		if not u.FruitFilters.PassesWeightRange(G.kg, y, Z) then
			return false
		end
		if not u.FruitFilters.PassesMutationSelection(G.mutationLookup, j, nil) then
			return false
		end
		if not u.FruitFilters.PassesVariantSelection(G.variant, i, nil) then
			return false
		end
		c = math.max(math.floor(tonumber(c) or 0), 0)
		if c > 0 and ((tonumber(G.price) or 0)) > c then
			return false
		end
		return true
	end;
	PassesAutoFiltersFruitFavouriteManager = function(G)
		return u.FruitFavouriteManager.PassesFilterSetFruitFavouriteManager(G, e.auto_fruit_favourite_names, e.auto_fruit_favourite_min_kg, e.auto_fruit_favourite_max_kg, e.auto_fruit_favourite_mutations, e.auto_fruit_favourite_variants, e.auto_fruit_favourite_max_value)
	end;
	PassesManualFiltersFruitFavouriteManager = function(G)
		return u.FruitFavouriteManager.PassesFilterSetFruitFavouriteManager(G, e.manual_fruit_favourite_names, e.manual_fruit_favourite_min_kg, e.manual_fruit_favourite_max_kg, e.manual_fruit_favourite_mutations, e.manual_fruit_favourite_variants, e.manual_fruit_favourite_max_value)
	end,
	RunFavouriteActionFruitFavouriteManager = function(G)
		if type(G) ~= "table" then
			return 0, 0
		end
		local V = G.makeFavourite == true
		local y = G.passFunction
		local Z = G.setStatus
		if type(y) ~= "function" or type(Z) ~= "function" then
			return 0, 0
		end
		local j = 0
		local i = 0
		local c, J = pcall(function()
			for G, Z in ipairs(u.FruitFavouriteManager.GetBackpackFruitsFruitFavouriteManager()) do
				if not y(Z) then
					continue
				end
				i += 1
				local c = u.FruitFavouriteManager.IsFavouriteFruitFavouriteManager(Z.ob)
				if V and c then
					continue
				end
				if not V and not c then
					continue
				end
				local J = u.FruitFavouriteManager.SetFavouriteFruitFavouriteManager(Z.ob, Z.id, V)
				if J then
					j += 1
				end
			end
		end)
		if not c then
			Z("System error", "#FF5555")
			warn("[FruitFavouriteManager]", J)
			return 0, i
		end
		Z(j > 0 and string.format("%s %d fruit%s", V and "Favourited" or "Unfavourited", j, j == 1 and "" or "s") or string.format("Matched %d fruit%s", i, i == 1 and "" or "s"), j > 0 and "#7CFC00" or "#CFCFCF")
		return j, i
	end;
	RunAutoFavouriteFruitFavouriteManager = function()
		if e.auto_fruit_favourite_enabled ~= true then
			u.FruitFavouriteManager.SetStatusAutoFruitFavouriteManager("")
			return 0
		end
		if u.FruitFavouriteManager.BusyAutoFruitFavouriteManager then
			return 0
		end
		u.FruitFavouriteManager.BusyAutoFruitFavouriteManager = true
		local G = u.FruitFavouriteManager.RunFavouriteActionFruitFavouriteManager({
			makeFavourite = true,
			passFunction = u.FruitFavouriteManager.PassesAutoFiltersFruitFavouriteManager;
			setStatus = u.FruitFavouriteManager.SetStatusAutoFruitFavouriteManager
		})
		u.FruitFavouriteManager.BusyAutoFruitFavouriteManager = false
		return G
	end;
	RunAutoBeforeSellFruitFavouriteManager = function()
		if e.auto_fruit_favourite_enabled ~= true then
			return 0
		end
		return u.FruitFavouriteManager.RunAutoFavouriteFruitFavouriteManager()
	end,
	RunManualFavouriteFruitFavouriteManager = function(G)
		if u.FruitFavouriteManager.BusyManualFruitFavouriteManager then
			u.FruitFavouriteManager.SetStatusManualFruitFavouriteManager("Already running", "#FFCC66")
			return 0
		end
		u.FruitFavouriteManager.BusyManualFruitFavouriteManager = true
		local V = u.FruitFavouriteManager.RunFavouriteActionFruitFavouriteManager({
			makeFavourite = G == true;
			passFunction = u.FruitFavouriteManager.PassesManualFiltersFruitFavouriteManager,
			setStatus = u.FruitFavouriteManager.SetStatusManualFruitFavouriteManager
		})
		u.FruitFavouriteManager.BusyManualFruitFavouriteManager = false
		return V
	end,
	LoopFruitFavouriteManager = function()
		return u.FruitFavouriteManager.RunAutoFavouriteFruitFavouriteManager()
	end
}
T.PetEquipTriggerStatusText = ""
T.PetEquipTriggerUi = T.PetEquipTriggerUi or {}
T.PetEquipTriggerLogs = T.PetEquipTriggerLogs or {}
u.PetEquipTriggers = {
	StartedPetEquipTriggers = false;
	BusyPetEquipTriggers = false;
	ActiveRuleId = tostring(e.pet_equip_active_rule_id or ""),
	ActiveSignature = "",
	FinishedEventKeys = {};
	RulePriority = {
		Manual = 100;
		["Seed Pack"] = 90;
		["Dropped Seed"] = 85,
		["Time Cycle Weather"] = 80;
		Weather = 70;
		["Time Cycle Phase"] = 60,
		Default = 10
	};
	TriggerOptions = {
		Manual = {
			"Manual"
		};
		Default = {
			"Idle"
		},
		["Seed Pack"] = {
			"Any Seed Pack";
			"Gold Seed";
			"Rainbow Seed"
		},
		["Dropped Seed"] = {
			"Own Dropped Seed"
		}
	},
	GetTriggerOptionsPetEquipTriggers = function(G)
		G = tostring(G or "Manual")
		if G == "Time Cycle" and (u.WeatherTriggers and type(u.WeatherTriggers.GetTimeCycleOptionsWeatherTriggers) == "function") then
			local G = u.WeatherTriggers.GetTimeCycleOptionsWeatherTriggers()
			return # G > 0 and G or {
				"Manual"
			}
		end
		if G == "Weather" and (u.WeatherTriggers and type(u.WeatherTriggers.GetWeatherOptionsWeatherTriggers) == "function") then
			local G = u.WeatherTriggers.GetWeatherOptionsWeatherTriggers()
			return # G > 0 and G or {
				"Manual"
			}
		end
		return u.PetEquipTriggers.TriggerOptions[G] or {
			"Manual"
		}
	end;
	SetStatusPetEquipTriggers = function(G, V)
		G = tostring(G or "")
		if G == "" then
			T.PetEquipTriggerStatusText = ""
			return false
		end
		T.PetEquipTriggerStatusText = string.format("<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\144\190 [Pet Triggers]</font> <font color=\'%s\'>%s</font></stroke>", tostring(V or "#FFFFFF"), G)
		return true
	end;
	AddPetEquipLog = function(G)
		if not e.pet_equip_log_enabled then
			return false
		end
		G = tostring(G or "")
		if G == "" then
			return false
		end
		table.insert(T.PetEquipTriggerLogs, 1, string.format("%s -- %s", os.date("%H:%M:%S"), G))
		while # T.PetEquipTriggerLogs > 50 do
			table.remove(T.PetEquipTriggerLogs)
		end
		if T.PetEquipTriggerUi.RefreshPetEquipLogs then
			T.PetEquipTriggerUi.RefreshPetEquipLogs()
		end
		return true
	end;
	NormaliseTextPetEquipTriggers = function(G)
		return ((tostring(G or "")):lower()):gsub("%s+", "")
	end;
	IsSelectionEmptyPetEquipTriggers = function(G)
		if type(G) ~= "table" then
			return true
		end
		for G, V in pairs(G) do
			if V == true or type(G) == "number" and tostring(V or "") ~= "" then
				return false
			end
		end
		return true
	end,
	IsSelectedPetEquipTriggers = function(G, V)
		if type(G) ~= "table" then
			return false
		end
		V = tostring(V or "")
		if V == "" then
			return false
		end
		if G[V] == true then
			return true
		end
		for G, y in pairs(G) do
			if tostring(y or "") == V then
				return true
			end
		end
		return false
	end,
	ResolvePetNamePetEquipTriggers = function(G)
		G = tostring(G or "")
		if G == "" then
			return "", ""
		end
		if type(y.PetData) == "table" and type(y.PetData[G]) == "table" then
			local V = tostring(y.PetData[G].DisplayName or G)
			return G, V
		end
		local V = T.PetDataFast and T.PetDataFast[G]
		if type(V) == "table" and type(V.petname) == "string" then
			return V.petname, tostring(V.displayname or V.petname)
		end
		if type(y.PetData) == "table" then
			local V = u.PetEquipTriggers.NormaliseTextPetEquipTriggers(G)
			for G, y in pairs(y.PetData) do
				if type(y) == "table" then
					local Z = tostring(y.DisplayName or G)
					if u.PetEquipTriggers.NormaliseTextPetEquipTriggers(G) == V or u.PetEquipTriggers.NormaliseTextPetEquipTriggers(Z) == V then
						return tostring(G), Z
					end
				end
			end
		end
		return G, G
	end;
	GetPetBaseDataPetEquipTriggers = function(G)
		local V = u.PetEquipTriggers.ResolvePetNamePetEquipTriggers(G)
		if V ~= "" and (type(y.PetData) == "table" and type(y.PetData[V]) == "table") then
			return y.PetData[V], V
		end
		return nil, V
	end,
	GetPetDisplayNamePetEquipTriggers = function(G)
		local V, y = u.PetEquipTriggers.ResolvePetNamePetEquipTriggers(G)
		return y ~= "" and y or V
	end;
	GetPetRarityPetEquipTriggers = function(G, V)
		local y = u.PetEquipTriggers.GetPetBaseDataPetEquipTriggers(G)
		if type(y) == "table" and type(y.Rarity) == "string" then
			return y.Rarity
		end
		if type(V) == "table" and type(V.Rarity) == "string" then
			return V.Rarity
		end
		return "Unknown"
	end,
	GetPetSizePetEquipTriggers = function(G)
		local V = type(G) == "table" and ((G.Size or G.PetSize)) or nil
		if V == "Big" or V == "Huge" then
			return V
		end
		return "Normal"
	end,
	GetPetVariantPetEquipTriggers = function(G)
		local V = type(G) == "table" and ((G.Type or G.PetType)) or nil
		if type(V) == "string" and V ~= "" then
			return V
		end
		return "Normal"
	end,
	GetEquippedIdsPetEquipTriggers = function()
		local G = {}
		local V = {}
		local Z = y.Networking and (y.Networking.Pets and y.Networking.Pets.GetEquippedPets)
		if not Z or type(Z.Fire) ~= "function" then
			return G, V
		end
		local j, i = pcall(function()
			return Z:Fire()
		end)
		if not j or type(i) ~= "table" then
			return G, V
		end
		for y, Z in pairs(i) do
			if type(Z) == "table" then
				local j = tostring(Z.Id or Z.id or Z.PetId or Z.UUID or Z.uuid or y or "")
				local i = u.PetEquipTriggers.ResolvePetNamePetEquipTriggers(Z.Name or Z.Pet or Z.Species or Z.PetName or "")
				if j ~= "" then
					G[j] = true
					table.insert(V, {
						id = j,
						key = j;
						name = i,
						displayName = u.PetEquipTriggers.GetPetDisplayNamePetEquipTriggers(i);
						size = u.PetEquipTriggers.GetPetSizePetEquipTriggers(Z),
						variant = u.PetEquipTriggers.GetPetVariantPetEquipTriggers(Z);
						rarity = u.PetEquipTriggers.GetPetRarityPetEquipTriggers(i, Z),
						equipped = true,
						data = Z
					})
				end
			elseif type(Z) == "string" then
				G[Z] = true
			end
		end
		return G, V
	end,
	GetPetToolInfoPetEquipTriggers = function(G, V)
		if not G or not G:IsA("Tool") then
			return nil
		end
		local y = G:GetAttribute("Pet")
		if type(y) ~= "string" or y == "" then
			return nil
		end
		local Z = G:GetAttribute("PetId")
		Z = type(Z) == "string" and Z or tostring(Z or "")
		if Z == "" then
			return nil
		end
		local j, i = u.PetEquipTriggers.ResolvePetNamePetEquipTriggers(y)
		local c = {
			Size = G:GetAttribute("PetSize");
			Type = G:GetAttribute("PetType")
		}
		return {
			key = Z;
			id = Z,
			name = j,
			displayName = i;
			rarity = u.PetEquipTriggers.GetPetRarityPetEquipTriggers(j, c);
			size = u.PetEquipTriggers.GetPetSizePetEquipTriggers(c),
			variant = u.PetEquipTriggers.GetPetVariantPetEquipTriggers(c),
			equipped = type(V) == "table" and V[Z] == true or false,
			tool = G;
			data = c
		}
	end;
	GetPetToolsPetEquipTriggers = function(G)
		local V = {}
		local Z = {}
		local j = {
			y.Backpack,
			y.Character
		}
		for y, j in ipairs(j) do
			if j and j.Parent then
				for y, j in ipairs(j:GetChildren()) do
					local i = u.PetEquipTriggers.GetPetToolInfoPetEquipTriggers(j, G)
					if i and not Z[i.id] then
						Z[i.id] = true
						table.insert(V, i)
					end
				end
			end
		end
		return V, Z
	end;
	GetReplicaPetsPetEquipTriggers = function(G, V)
		local y = {}
		local Z = u.DataReplica.GetData("Inventory")
		local j = type(Z) == "table" and Z.Pets or nil
		if type(j) ~= "table" then
			return y
		end
		for Z, j in pairs(j) do
			if type(j) == "table" then
				local i = tostring(j.Id or j.PetId or Z or "")
				if i ~= "" and not ((type(V) == "table" and V[i])) then
					local V = u.PetEquipTriggers.ResolvePetNamePetEquipTriggers(j.Name or j.Pet or j.Species or j.PetName or "")
					if V ~= "" then
						table.insert(y, {
							key = tostring(Z);
							id = i,
							name = V,
							displayName = u.PetEquipTriggers.GetPetDisplayNamePetEquipTriggers(V),
							rarity = u.PetEquipTriggers.GetPetRarityPetEquipTriggers(V, j);
							size = u.PetEquipTriggers.GetPetSizePetEquipTriggers(j),
							variant = u.PetEquipTriggers.GetPetVariantPetEquipTriggers(j),
							equipped = type(G) == "table" and G[i] == true or false;
							data = j
						})
					end
				end
			end
		end
		return y
	end,
	GetInventoryPetsPetEquipTriggers = function()
		local G = u.PetEquipTriggers.GetEquippedIdsPetEquipTriggers()
		local V, y = u.PetEquipTriggers.GetPetToolsPetEquipTriggers(G)
		for G, y in ipairs(u.PetEquipTriggers.GetReplicaPetsPetEquipTriggers(G, y)) do
			table.insert(V, y)
		end
		table.sort(V, function(G, V)
			if tostring(G.displayName or "") ~= tostring(V.displayName or "") then
				return tostring(G.displayName or "") < tostring(V.displayName or "")
			end
			if tostring(G.size or "") ~= tostring(V.size or "") then
				return tostring(G.size or "") < tostring(V.size or "")
			end
			return tostring(G.id or "") < tostring(V.id or "")
		end)
		return V, G
	end,
	GetEquippedPetsPetEquipTriggers = function()
		local G = u.PetEquipTriggers.GetInventoryPetsPetEquipTriggers()
		local V = {}
		for G, y in ipairs(G) do
			if y.equipped then
				table.insert(V, y)
			end
		end
		return V
	end,
	GetPetNameDropdownPetEquipTriggers = function()
		local G = {}
		local V = {}
		for y, Z in ipairs(T.PetDataTable or {}) do
			local j = tostring(Z.petname or "")
			if j ~= "" and not V[j] then
				V[j] = true
				local y = tostring(Z.displayname or j)
				local i = tostring(Z.rarity or "Unknown")
				local c = u.Data.GetRarityColor(i)
				table.insert(G, {
					Text = string.format("<font color=\'#FFFFFF\'>%s</font> <font color=\'%s\'>%s</font>", y, c, i);
					Value = j
				})
			end
		end
		table.sort(G, function(G, V)
			return tostring(G.Text or "") < tostring(V.Text or "")
		end)
		return G
	end,
	GetExactPetDropdownPetEquipTriggers = function()
		local G = {}
		for V, y in ipairs(u.PetEquipTriggers.GetInventoryPetsPetEquipTriggers()) do
			local Z = y.equipped and " Active" or ""
			local j = string.format("%s | %s | %s | %s%s", tostring(y.displayName or y.name), tostring(y.size or "Normal"), tostring(y.variant or "Normal"), tostring(y.id or "?"), Z)
			table.insert(G, {
				Text = j;
				Value = tostring(y.id or y.key or "")
			})
		end
		return G
	end;
	NewRuleIdPetEquipTriggers = function()
		return tostring(os.time()) .. ("_" .. tostring(math.random(100000, 999999)))
	end,
	CleanRuleNamePetEquipTriggers = function(G)
		G = (tostring(G or "")):match("^%s*(.-)%s*$") or ""
		if G == "" then
			return "Pet Loadout"
		end
		return G:sub(1, 40)
	end;
	GetRulesTablePetEquipTriggers = function()
		if type(e.pet_equip_rules) ~= "table" then
			e.pet_equip_rules = {}
		end
		return e.pet_equip_rules
	end,
	GetSortedRulesPetEquipTriggers = function()
		local G = {}
		for V, y in pairs(u.PetEquipTriggers.GetRulesTablePetEquipTriggers()) do
			if type(y) == "table" then
				y.id = tostring(y.id or V)
				table.insert(G, y)
			end
		end
		table.sort(G, function(G, V)
			local y = tonumber(G.createdAt) or 0
			local Z = tonumber(V.createdAt) or 0
			if y ~= Z then
				return y < Z
			end
			return tostring(G.id or "") < tostring(V.id or "")
		end)
		return G
	end,
	GetRuleSummaryPetEquipTriggers = function(G)
		if type(G) ~= "table" then
			return "Invalid loadout"
		end
		local V = {}
		for G, y in ipairs(type(G.pets) == "table" and G.pets or {}) do
			local Z, j = u.PetEquipTriggers.ResolvePetNamePetEquipTriggers(y.pet or y.name or "?")
			local i = math.max(math.floor(tonumber(y.amount) or 1), 1)
			local c = {}
			if tostring(y.size or "") ~= "" then
				table.insert(c, tostring(y.size))
			end
			if tostring(y.variant or "") ~= "" then
				table.insert(c, tostring(y.variant))
			end
			local J = # c > 0 and " [" .. (table.concat(c, ", ") .. "]") or ""
			table.insert(V, string.format("%s x%d%s", j ~= "" and j or Z, i, J))
		end
		local y = tostring(G.triggerType or "Manual")
		local Z = tostring(G.triggerName or "Manual")
		local j = math.max(tonumber(G.duration) or 0, 0)
		local i = j > 0 and tostring(j) .. "s" or (y == "Manual" and "until restore" or "event active")
		local c = # V > 0 and table.concat(V, " + ") or "No pets"
		return string.format("%s | %s / %s | %s | %s", tostring(G.name or "Loadout"), y, Z, i, c)
	end;
	AddRulePetEquipTriggers = function(G, V, y, Z, j)
		if type(j) ~= "table" or # j == 0 then
			return false, "Add at least one pet to the loadout"
		end
		V = tostring(V or "Manual")
		local i = u.PetEquipTriggers.GetTriggerOptionsPetEquipTriggers(V)
		if type(i) ~= "table" then
			return false, "Invalid trigger type"
		end
		y = tostring(y or i[1] or "Manual")
		Z = math.max(math.floor(tonumber(Z) or 0), 0)
		local c = {}
		for G, V in ipairs(j) do
			if type(V) == "table" then
				local G = u.PetEquipTriggers.ResolvePetNamePetEquipTriggers(V.pet or V.name or "")
				local y = math.clamp(math.floor(tonumber(V.amount) or 1), 1, 12)
				if G ~= "" then
					table.insert(c, {
						pet = G,
						amount = y;
						size = tostring(V.size or "");
						variant = tostring(V.variant or "")
					})
				end
			end
		end
		if # c == 0 then
			return false, "No valid pets in loadout"
		end
		local J = u.PetEquipTriggers.NewRuleIdPetEquipTriggers();
		(u.PetEquipTriggers.GetRulesTablePetEquipTriggers())[J] = {
			id = J;
			name = u.PetEquipTriggers.CleanRuleNamePetEquipTriggers(G);
			enabled = true;
			triggerType = V;
			triggerName = y,
			duration = Z;
			pets = c,
			createdAt = os.time()
		}
		q.Save.SaveDataSync()
		u.PetEquipTriggers.AddPetEquipLog("Added loadout: " .. u.PetEquipTriggers.GetRuleSummaryPetEquipTriggers((u.PetEquipTriggers.GetRulesTablePetEquipTriggers())[J]))
		if T.PetEquipTriggerUi.RefreshPetEquipRules then
			T.PetEquipTriggerUi.RefreshPetEquipRules()
		end
		return true, J
	end;
	RemoveRulePetEquipTriggers = function(G)
		G = tostring(G or "")
		local V = u.PetEquipTriggers.GetRulesTablePetEquipTriggers()
		local y = V[G]
		if type(y) ~= "table" then
			return false
		end
		local Z = tostring(y.name or "Loadout")
		V[G] = nil
		if tostring(e.pet_equip_manual_rule_id or "") == G then
			e.pet_equip_manual_rule_id = ""
		end
		if u.PetEquipTriggers.ActiveRuleId == G or tostring(e.pet_equip_active_rule_id or "") == G then
			u.PetEquipTriggers.RestorePreviousPetEquipTriggers("Deleted active loadout")
		end
		q.Save.SaveDataSync()
		u.PetEquipTriggers.AddPetEquipLog("Deleted loadout: " .. Z)
		if T.PetEquipTriggerUi.RefreshPetEquipRules then
			T.PetEquipTriggerUi.RefreshPetEquipRules()
		end
		return true
	end;
	ToggleRulePetEquipTriggers = function(G, V)
		G = tostring(G or "")
		local y = (u.PetEquipTriggers.GetRulesTablePetEquipTriggers())[G]
		if type(y) ~= "table" then
			return false
		end
		y.enabled = V == true
		if not y.enabled and tostring(e.pet_equip_manual_rule_id or "") == G then
			e.pet_equip_manual_rule_id = ""
		end
		if not y.enabled and ((u.PetEquipTriggers.ActiveRuleId == G or tostring(e.pet_equip_active_rule_id or "") == G)) then
			u.PetEquipTriggers.RestorePreviousPetEquipTriggers("Loadout disabled")
		end
		q.Save.SaveDataSync()
		u.PetEquipTriggers.AddPetEquipLog(((y.enabled and "Enabled" or "Disabled")) .. (" loadout: " .. tostring(y.name or "Loadout")))
		return true
	end,
	GetWeatherValuesPetEquipTriggers = function()
		return y.ReplicatedStorage and y.ReplicatedStorage:FindFirstChild("WeatherValues") or nil
	end;
	NamesMatchPetEquipTriggers = function(G, V)
		return u.PetEquipTriggers.NormaliseTextPetEquipTriggers(G) == u.PetEquipTriggers.NormaliseTextPetEquipTriggers(V)
	end,
	IsTimeCycleWeatherPetEquipTriggers = function(G)
		if u.WeatherTriggers and type(u.WeatherTriggers.IsTimeCycleNameWeatherTriggers) == "function" then
			return u.WeatherTriggers.IsTimeCycleNameWeatherTriggers(G) and not u.WeatherTriggers.IsTimeCyclePhaseWeatherTriggers(G)
		end
		return false
	end;
	IsTimeCyclePhasePetEquipTriggers = function(G)
		if u.WeatherTriggers and type(u.WeatherTriggers.IsTimeCyclePhaseWeatherTriggers) == "function" then
			return u.WeatherTriggers.IsTimeCyclePhaseWeatherTriggers(G)
		end
		return false
	end,
	GetRulePriorityPetEquipTriggers = function(G)
		if type(G) ~= "table" then
			return 0
		end
		local V = tostring(G.triggerType or "Manual")
		if V == "Time Cycle" then
			if u.PetEquipTriggers.IsTimeCycleWeatherPetEquipTriggers(G.triggerName) then
				return u.PetEquipTriggers.RulePriority["Time Cycle Weather"] or 80
			end
			return u.PetEquipTriggers.RulePriority["Time Cycle Phase"] or 60
		end
		return u.PetEquipTriggers.RulePriority[V] or 0
	end;
	GetWeatherActivePetEquipTriggers = function(G)
		G = tostring(G or "")
		if G == "" then
			return false
		end
		return u.WeatherTriggers and u.WeatherTriggers.IsTriggerActiveWeatherTriggers(G) == true or false
	end,
	GetTimeCycleActivePetEquipTriggers = function(G)
		G = tostring(G or "")
		if G == "" then
			return false
		end
		return u.WeatherTriggers and u.WeatherTriggers.IsTriggerActiveWeatherTriggers(G) == true or false
	end;
	GetSeedPackActivePetEquipTriggers = function(G)
		local V = y.EventSeedDrops
		if not V or not V.Parent then
			return false
		end
		G = tostring(G or "Any Seed Pack")
		for V, y in ipairs(V:GetChildren()) do
			if G == "Any Seed Pack" then
				return true
			end
			if G == "Gold Seed" and y:GetAttribute("GoldSeed") == true then
				return true
			end
			if G == "Rainbow Seed" and y:GetAttribute("RainbowSeed") == true then
				return true
			end
		end
		return false
	end,
	GetDroppedSeedActivePetEquipTriggers = function()
		local G = y.DroppedItems
		if not G or not G.Parent then
			return false
		end
		local V = tostring(T.player_userid or "")
		for G, y in ipairs(G:GetChildren()) do
			if tostring(y:GetAttribute("ItemCategory") or "") ~= "Seeds" then
				continue
			end
			local Z = tostring(y:GetAttribute("DroppedBy") or "")
			if Z == "" or Z == V then
				return true
			end
		end
		return false
	end;
	GetRuleConditionPetEquipTriggers = function(G)
		if type(G) ~= "table" or G.enabled ~= true then
			return false, "", "disabled"
		end
		local V = tostring(G.triggerType or "Manual")
		local y = tostring(G.triggerName or "Manual")
		local Z = false
		if V == "Manual" then
			Z = tostring(e.pet_equip_manual_rule_id or "") == tostring(G.id or "")
		elseif V == "Default" then
			Z = true
		elseif V == "Weather" then
			Z = u.PetEquipTriggers.GetWeatherActivePetEquipTriggers(y)
		elseif V == "Time Cycle" then
			Z = u.PetEquipTriggers.GetTimeCycleActivePetEquipTriggers(y)
		elseif V == "Seed Pack" then
			Z = u.PetEquipTriggers.GetSeedPackActivePetEquipTriggers(y)
		elseif V == "Dropped Seed" then
			Z = u.PetEquipTriggers.GetDroppedSeedActivePetEquipTriggers()
		end
		local j = tostring(G.id or "") .. ("|" .. (V .. ("|" .. y)))
		return Z == true, j, Z and "active" or "inactive"
	end,
	GetBestRulePetEquipTriggers = function()
		local G = nil
		local V = - 1
		local y = ""
		local Z = os.time()
		local j = {}
		for i, c in ipairs(u.PetEquipTriggers.GetSortedRulesPetEquipTriggers()) do
			local J, T = u.PetEquipTriggers.GetRuleConditionPetEquipTriggers(c)
			if T ~= "" and J then
				j[T] = true
			end
			if J then
				local G = math.max(tonumber(c.duration) or 0, 0)
				local V = tonumber(c.startedAtUnix or c.startedAt) or 0
				if G > 0 and (V > 0 and Z - V >= G) then
					u.PetEquipTriggers.FinishedEventKeys[T] = true
					if tostring(c.triggerType or "") == "Manual" and tostring(e.pet_equip_manual_rule_id or "") == tostring(c.id or "") then
						e.pet_equip_manual_rule_id = ""
					end
					J = false
				end
				if u.PetEquipTriggers.FinishedEventKeys[T] then
					J = false
				end
			end
			if J then
				local Z = u.PetEquipTriggers.GetRulePriorityPetEquipTriggers(c)
				if Z > V then
					G = c
					V = Z
					y = T
				end
			end
		end
		for G in pairs(u.PetEquipTriggers.FinishedEventKeys) do
			if not j[G] then
				u.PetEquipTriggers.FinishedEventKeys[G] = nil
			end
		end
		return G, y
	end;
	IsProtectedEquippedPetEquipTriggers = function(G)
		if type(G) ~= "table" then
			return true, "invalid"
		end
		if u.PetEquipTriggers.IsSelectedPetEquipTriggers(e.pet_equip_protected_ids, G.id) or u.PetEquipTriggers.IsSelectedPetEquipTriggers(e.pet_equip_protected_ids, G.key) then
			return true, "protected id"
		end
		if u.PetEquipTriggers.IsSelectedPetEquipTriggers(e.pet_equip_protected_names, G.name) or u.PetEquipTriggers.IsSelectedPetEquipTriggers(e.pet_equip_protected_names, G.displayName) then
			return true, "protected pet"
		end
		if e.pet_equip_protect_rainbow and G.variant == "Rainbow" then
			return true, "rainbow"
		end
		if e.pet_equip_protect_big_huge and ((G.size == "Big" or G.size == "Huge")) then
			return true, "big/huge"
		end
		if e.pet_equip_protect_super_secret and ((G.rarity == "Super" or G.rarity == "Secret")) then
			return true, "super/secret"
		end
		return false, ""
	end;
	PetMatchesSpecPetEquipTriggers = function(G, V)
		if type(G) ~= "table" or type(V) ~= "table" then
			return false
		end
		local y = tostring(V.id or "")
		if y ~= "" then
			return tostring(G.id or G.key or "") == y
		end
		local Z = u.PetEquipTriggers.ResolvePetNamePetEquipTriggers(V.pet or V.name or "")
		if Z == "" or tostring(G.name or "") ~= Z then
			return false
		end
		local j = tostring(V.size or "")
		if j ~= "" and tostring(G.size or "Normal") ~= j then
			return false
		end
		local i = tostring(V.variant or "")
		if i ~= "" and tostring(G.variant or "Normal") ~= i then
			return false
		end
		return true
	end;
	BuildRequestedSpecsPetEquipTriggers = function(G)
		local V = {}
		for G, y in ipairs(type(G) == "table" and (type(G.pets) == "table" and G.pets) or {}) do
			local Z = u.PetEquipTriggers.ResolvePetNamePetEquipTriggers(y.pet or y.name or "")
			local j = math.max(math.floor(tonumber(y.amount) or 1), 1)
			for G = 1, j, 1 do
				if Z ~= "" then
					table.insert(V, {
						pet = Z,
						size = tostring(y.size or ""),
						variant = tostring(y.variant or "");
						id = tostring(y.id or "")
					})
				end
			end
		end
		return V
	end;
	BuildSnapshotPetEquipTriggers = function(G)
		local V = {}
		for G, y in ipairs(type(G) == "table" and G or {}) do
			local Z = tostring(y.id or y.key or "")
			if Z ~= "" then
				table.insert(V, {
					id = Z,
					pet = tostring(y.name or ""),
					size = tostring(y.size or "");
					variant = tostring(y.variant or "")
				})
			end
		end
		return V
	end,
	BuildRestoreRulePetEquipTriggers = function(G)
		local V = {}
		if type(G) == "table" then
			local y = # G > 0
			if y then
				for G, y in ipairs(G) do
					if type(y) == "table" then
						table.insert(V, {
							id = tostring(y.id or ""),
							pet = u.PetEquipTriggers.ResolvePetNamePetEquipTriggers(y.pet or "");
							amount = 1;
							size = tostring(y.size or "");
							variant = tostring(y.variant or "")
						})
					end
				end
			else
				for G, y in pairs(G) do
					local Z = u.PetEquipTriggers.ResolvePetNamePetEquipTriggers(G)
					if Z ~= "" and (tonumber(y) and tonumber(y) > 0) then
						table.insert(V, {
							pet = Z,
							amount = math.floor(tonumber(y)),
							size = "";
							variant = ""
						})
					end
				end
			end
		end
		return {
			id = "restore";
			name = "Restore previous pets",
			triggerType = "Manual",
			triggerName = "Restore";
			duration = 0;
			pets = V
		}
	end;
	BuildPetPlanPetEquipTriggers = function(G, V, y)
		local Z = u.PetEquipTriggers.BuildRequestedSpecsPetEquipTriggers(G)
		local j = {}
		local i = {}
		local c = {}
		local J = 0
		for G, V in ipairs(V) do
			if V.equipped then
				local G = u.PetEquipTriggers.IsProtectedEquippedPetEquipTriggers(V)
				if G then
					c[tostring(V.id or "")] = true
					J += 1
				end
			end
		end
		local T = math.max(y - J, 0)
		for G, y in ipairs(Z) do
			if # j >= T then
				break
			end
			local Z = nil
			for G, V in ipairs(V) do
				local j = tostring(V.id or "")
				if V.equipped and (not c[j] and (not i[j] and u.PetEquipTriggers.PetMatchesSpecPetEquipTriggers(V, y))) then
					Z = V
					break
				end
			end
			if not Z then
				for G, V in ipairs(V) do
					local j = tostring(V.id or "")
					if not V.equipped and (not i[j] and u.PetEquipTriggers.PetMatchesSpecPetEquipTriggers(V, y)) then
						Z = V
						break
					end
				end
			end
			if Z then
				local G = tostring(Z.id or "")
				i[G] = true
				table.insert(j, Z)
			end
		end
		return j, c, math.max(# Z - # j, 0), # Z
	end;
	GetMaxPetSlotsPetEquipTriggers = function()
		local G = u.PlayerData and (u.PlayerData.GetMaxEquippedPets and u.PlayerData.GetMaxEquippedPets()) or 3
		return math.max(math.floor(tonumber(G) or 3), 1)
	end,
	BuildSignaturePetEquipTriggers = function(G, V)
		local y = {
			tostring(G and G.id or "")
		}
		for G, V in ipairs(type(V) == "table" and V or {}) do
			table.insert(y, tostring(V.id or V.key or ""))
		end
		return table.concat(y, "|")
	end,
	WaitForPetStatePetEquipTriggers = function(G, V, y)
		G = tostring(G or "")
		if G == "" then
			return false
		end
		local Z = os.clock() + math.max(tonumber(y) or 1, .2)
		repeat
			local y = u.PetEquipTriggers.GetEquippedIdsPetEquipTriggers()
			if ((y[G] == true)) == V then
				return true
			end
			task.wait(.1)
		until os.clock() >= Z
		return false
	end;
	EquipPetByIdPetEquipTriggers = function(G)
		if type(G) ~= "table" then
			return false
		end
		local V = tostring(G.id or G.key or "")
		if V == "" then
			return false
		end
		if G.equipped then
			return true
		end
		local Z = G.tool
		if Z and (Z.Parent and (y.Character and Z.Parent ~= y.Character)) then
			local G = y.Character:FindFirstChildOfClass("Humanoid")
			if G then
				pcall(function()
					G:EquipTool(Z)
				end)
				task.wait(.15)
			end
		end
		local j = y.Networking and (y.Networking.Pets and y.Networking.Pets.RequestToggleFollower)
		local i = false
		if j and type(j.Fire) == "function" then
			i = pcall(function()
				j:Fire(V)
			end)
		end
		if not i and (Z and (Z.Parent and type(Z.Activate) == "function")) then
			i = pcall(function()
				Z:Activate()
			end)
		end
		if not i then
			return false
		end
		return u.PetEquipTriggers.WaitForPetStatePetEquipTriggers(V, true, 2)
	end,
	UnequipPetByIdPetEquipTriggers = function(G)
		G = tostring(G or "")
		if G == "" then
			return false
		end
		local V = y.Networking and (y.Networking.Pets and y.Networking.Pets.RequestUnequip)
		local Z = false
		if V and type(V.Fire) == "function" then
			Z = pcall(function()
				V:Fire(G)
			end)
		end
		if not Z then
			local V = y.Networking and (y.Networking.Pets and y.Networking.Pets.RequestToggleFollower)
			if V and type(V.Fire) == "function" then
				Z = pcall(function()
					V:Fire(G)
				end)
			end
		end
		if not Z then
			return false
		end
		return u.PetEquipTriggers.WaitForPetStatePetEquipTriggers(G, false, 2)
	end,
	ApplyRulePetEquipTriggers = function(G, V)
		if type(G) ~= "table" or u.PetEquipTriggers.BusyPetEquipTriggers then
			return false
		end
		u.PetEquipTriggers.BusyPetEquipTriggers = true
		local y = false
		local Z, j = pcall(function()
			local Z = u.PetEquipTriggers.GetInventoryPetsPetEquipTriggers()
			local j = u.PetEquipTriggers.GetMaxPetSlotsPetEquipTriggers()
			local i, c, J, T = u.PetEquipTriggers.BuildPetPlanPetEquipTriggers(G, Z, j)
			local d = u.PetEquipTriggers.BuildSignaturePetEquipTriggers(G, i)
			local g = tostring(G.id or "")
			if T <= 0 then
				u.PetEquipTriggers.SetStatusPetEquipTriggers("No pets in loadout", "#FFCC66")
				return
			end
			if # i == 0 and J > 0 then
				u.PetEquipTriggers.SetStatusPetEquipTriggers("No matching pet tools found", "#FF6666")
				u.PetEquipTriggers.AddPetEquipLog("No matching pet tools found for " .. tostring(G.name or "Loadout"))
				return
			end
			if d == u.PetEquipTriggers.ActiveSignature and g == u.PetEquipTriggers.ActiveRuleId then
				u.PetEquipTriggers.SetStatusPetEquipTriggers("Active: " .. tostring(G.name or "Loadout"), "#7CFC00")
				y = true
				return
			end
			local E = {}
			for G, V in ipairs(Z) do
				if V.equipped then
					table.insert(E, V)
				end
			end
			if g ~= "restore" and (tostring(G.triggerType or "") ~= "Default" and (e.pet_equip_restore_previous and u.PetEquipTriggers.ActiveRuleId == "")) then
				e.pet_equip_restore_snapshot = u.PetEquipTriggers.BuildSnapshotPetEquipTriggers(E)
			end
			local a = {}
			for G in pairs(c) do
				a[G] = true
			end
			for G, V in ipairs(i) do
				a[tostring(V.id or "")] = true
			end
			for G, V in ipairs(E) do
				local y = tostring(V.id or "")
				if not a[y] then
					u.PetEquipTriggers.UnequipPetByIdPetEquipTriggers(y)
					task.wait(.1)
				end
			end
			local H = u.PetEquipTriggers.GetEquippedIdsPetEquipTriggers()
			for G, V in ipairs(i) do
				local y = tostring(V.id or "")
				if y ~= "" and not H[y] then
					u.PetEquipTriggers.EquipPetByIdPetEquipTriggers(V)
					task.wait(.1)
				end
			end
			u.PetEquipTriggers.ActiveRuleId = g
			u.PetEquipTriggers.ActiveSignature = d
			e.pet_equip_active_rule_id = g
			if g ~= "restore" then
				G.startedAt = os.time()
				G.startedAtUnix = os.time()
			end
			q.Save.SaveDataSync()
			local r = J > 0 and " | ignored " .. (tostring(J) .. " over max/missing") or ""
			u.PetEquipTriggers.SetStatusPetEquipTriggers("Applied " .. (tostring(G.name or "Loadout") .. r), "#66CCFF")
			u.PetEquipTriggers.AddPetEquipLog("Applied loadout: " .. (tostring(G.name or "Loadout") .. (" | " .. (tostring(V or "trigger") .. r))))
			y = true
		end)
		u.PetEquipTriggers.BusyPetEquipTriggers = false
		if not Z then
			u.PetEquipTriggers.SetStatusPetEquipTriggers("Apply failed", "#FF6666")
			warn("[PetEquipTriggers]", j)
			return false
		end
		return y
	end,
	RestorePreviousPetEquipTriggers = function(G)
		if u.PetEquipTriggers.ActiveRuleId == "" and tostring(e.pet_equip_active_rule_id or "") == "" then
			return false
		end
		local V = e.pet_equip_restore_snapshot
		u.PetEquipTriggers.ActiveRuleId = ""
		u.PetEquipTriggers.ActiveSignature = ""
		e.pet_equip_active_rule_id = ""
		e.pet_equip_manual_rule_id = ""
		if e.pet_equip_restore_previous and (type(V) == "table" and next(V) ~= nil) then
			local y = u.PetEquipTriggers.BuildRestoreRulePetEquipTriggers(V)
			u.PetEquipTriggers.AddPetEquipLog("Restoring previous pets: " .. tostring(G or "trigger ended"))
			u.PetEquipTriggers.ApplyRulePetEquipTriggers(y, "restore")
			u.PetEquipTriggers.ActiveRuleId = ""
			u.PetEquipTriggers.ActiveSignature = ""
			e.pet_equip_active_rule_id = ""
		else
			u.PetEquipTriggers.SetStatusPetEquipTriggers("Trigger ended", "#FFCC66")
			u.PetEquipTriggers.AddPetEquipLog("Trigger ended: " .. tostring(G or "restore disabled"))
		end
		q.Save.SaveDataSync()
		return true
	end;
	TriggerManualPetEquipTriggers = function(G)
		G = tostring(G or "")
		local V = (u.PetEquipTriggers.GetRulesTablePetEquipTriggers())[G]
		if type(V) ~= "table" then
			u.PetEquipTriggers.SetStatusPetEquipTriggers("Select a manual loadout", "#FFCC66")
			return false
		end
		if V.enabled ~= true then
			V.enabled = true
		end
		e.pet_equip_manual_rule_id = G
		V.startedAt = os.time()
		V.startedAtUnix = os.time()
		q.Save.SaveDataSync()
		u.PetEquipTriggers.AddPetEquipLog("Manual trigger: " .. tostring(V.name or "Loadout"))
		return u.PetEquipTriggers.ApplyRulePetEquipTriggers(V, "manual trigger")
	end,
	ProcessPetEquipTriggers = function()
		if not e.pet_equip_enabled then
			if u.PetEquipTriggers.ActiveRuleId ~= "" or tostring(e.pet_equip_active_rule_id or "") ~= "" then
				u.PetEquipTriggers.RestorePreviousPetEquipTriggers("System disabled")
			end
			u.PetEquipTriggers.SetStatusPetEquipTriggers("")
			return false
		end
		if not J.IsLoadingCompleted() then
			u.PetEquipTriggers.SetStatusPetEquipTriggers("Waiting for loading", "#FFCC66")
			return false
		end
		local G, V = u.PetEquipTriggers.GetBestRulePetEquipTriggers()
		if type(G) == "table" then
			local y = math.max(tonumber(G.duration) or 0, 0)
			local Z = tonumber(G.startedAtUnix or G.startedAt) or 0
			if y > 0 and (Z > 0 and os.time() - Z >= y) then
				u.PetEquipTriggers.FinishedEventKeys[V] = true
				if tostring(G.triggerType or "") == "Manual" then
					e.pet_equip_manual_rule_id = ""
				end
				u.PetEquipTriggers.RestorePreviousPetEquipTriggers("Duration ended")
				return true
			end
			u.PetEquipTriggers.ApplyRulePetEquipTriggers(G, tostring(G.triggerType or "trigger") .. (" / " .. tostring(G.triggerName or "")))
			return true
		end
		if u.PetEquipTriggers.ActiveRuleId ~= "" or tostring(e.pet_equip_active_rule_id or "") ~= "" then
			u.PetEquipTriggers.RestorePreviousPetEquipTriggers("No active trigger")
			return true
		end
		local y = false
		for G, V in ipairs(u.PetEquipTriggers.GetSortedRulesPetEquipTriggers()) do
			if type(V) == "table" and (V.enabled == true and tostring(V.triggerType or "") == "Manual") then
				y = true
				break
			end
		end
		u.PetEquipTriggers.SetStatusPetEquipTriggers(y and "Manual ready - press Run Manual Now" or "Waiting for trigger", "#CFCFCF")
		return false
	end,
	HookEventsPetEquipTriggers = function()
		local G = u.PetEquipTriggers.GetWeatherValuesPetEquipTriggers()
		if G then
			for V, y in ipairs(u.PetEquipTriggers.GetTriggerOptionsPetEquipTriggers("Weather")) do
				(G:GetAttributeChangedSignal(y .. "_Playing")):Connect(function()
					u.PetEquipTriggers.AddPetEquipLog("Weather changed: " .. (y .. (" = " .. tostring(G:GetAttribute(y .. "_Playing") == true))))
					u.PetEquipTriggers.ProcessPetEquipTriggers()
				end)
			end
		end;
		(y.Workspace:GetAttributeChangedSignal("ActivePhase")):Connect(function()
			u.PetEquipTriggers.AddPetEquipLog("Phase changed: " .. tostring(y.Workspace:GetAttribute("ActivePhase") or "?"))
			u.PetEquipTriggers.ProcessPetEquipTriggers()
		end);
		(y.Workspace:GetAttributeChangedSignal("ActiveWeather")):Connect(function()
			u.PetEquipTriggers.AddPetEquipLog("Cycle weather changed: " .. tostring(y.Workspace:GetAttribute("ActiveWeather") or "?"))
			u.PetEquipTriggers.ProcessPetEquipTriggers()
		end)
		if y.EventSeedDrops then
			y.EventSeedDrops.ChildAdded:Connect(function(G)
				u.PetEquipTriggers.AddPetEquipLog("Seed pack appeared: " .. tostring(G and G.Name or "?"))
				u.PetEquipTriggers.ProcessPetEquipTriggers()
			end)
			y.EventSeedDrops.ChildRemoved:Connect(function(G)
				u.PetEquipTriggers.AddPetEquipLog("Seed pack removed: " .. tostring(G and G.Name or "?"))
				u.PetEquipTriggers.ProcessPetEquipTriggers()
			end)
		end
		if y.DroppedItems then
			y.DroppedItems.ChildAdded:Connect(function(G)
				if G and tostring(G:GetAttribute("ItemCategory") or "") == "Seeds" then
					u.PetEquipTriggers.AddPetEquipLog("Dropped seed appeared")
					u.PetEquipTriggers.ProcessPetEquipTriggers()
				end
			end)
		end
	end;
	StartPetEquipTriggers = function()
		if u.PetEquipTriggers.StartedPetEquipTriggers then
			return false
		end
		u.PetEquipTriggers.StartedPetEquipTriggers = true
		u.PetEquipTriggers.HookEventsPetEquipTriggers()
		task.spawn(function()
			while not T.is_forced_stop do
				task.wait(1)
				local G, V = pcall(u.PetEquipTriggers.ProcessPetEquipTriggers)
				if not G then
					u.PetEquipTriggers.SetStatusPetEquipTriggers("System error", "#FF6666")
					warn("[PetEquipTriggers]", V)
				end
			end
		end)
		return true
	end
}
u.PlayerData = {
	GetBackpackSpaceUpgradesPurchased = function()
		return y.LocalPlayer:GetAttribute("BackpackSpaceUpgradesPurchased") or 0
	end;
	GetFriends = function()
		return y.LocalPlayer:GetAttribute("Friends") or 0
	end,
	GetFruitCount = function()
		return y.LocalPlayer:GetAttribute("FruitCount") or 0
	end;
	GetIsInOwnGarden = function()
		return y.LocalPlayer:GetAttribute("IsInOwnGarden") or false
	end,
	GetLoadingScreenActive = function()
		return y.LocalPlayer:GetAttribute("LoadingScreenActive") or false
	end;
	GetLoadingScreenDone = function()
		return y.LocalPlayer:GetAttribute("LoadingScreenDone") or false
	end;
	GetMaxEquippedPets = function()
		return y.LocalPlayer:GetAttribute("MaxEquippedPets") or 3
	end;
	GetMaxFruitCapacity = function()
		return y.LocalPlayer:GetAttribute("MaxFruitCapacity") or 100
	end;
	GetOfflineGrowthProcessed = function()
		return y.LocalPlayer:GetAttribute("OfflineGrowthProcessed") or false
	end;
	GetOwnedGamepasses = function()
		return y.LocalPlayer:GetAttribute("OwnedGamepasses") or ""
	end;
	GetPlotId = function()
		return y.LocalPlayer:GetAttribute("PlotId") or 0
	end;
	GetPrimeEnabled = function()
		return y.LocalPlayer:GetAttribute("PrimeEnabled") or false
	end,
	GetSecondTimePlayer = function()
		return y.LocalPlayer:GetAttribute("SecondTimePlayer") or false
	end,
	GetStarterPackExpiresAt = function()
		return y.LocalPlayer:GetAttribute("StarterPackExpiresAt") or 0
	end
}
u.Player = {
	Rejoin = function()
		pcall(function()
			y.TeleportService:Teleport(game.PlaceId)
		end)
	end;
	CameraSetUp = function()
		pcall(function()
			y.LocalPlayer.CameraMaxZoomDistance = 350
		end)
	end,
	GetUserid = function()
		return y.LocalPlayer.UserId
	end;
	GetTool_Holding = function()
		return y.Character and y.Character:FindFirstChildWhichIsA("Tool")
	end;
	IsToolHeld = function(G)
		local V = u.Player.GetTool_Holding()
		if not V then
			return false
		end
		return V == G
	end;
	UnequipTools = function()
		local G = y.Character
		if not G then
			return false
		end
		local V = G:FindFirstChildOfClass("Humanoid")
		if not V then
			return
		end
		V:UnequipTools()
	end;
	EquipTool = function(G)
		local V = y.Character
		if not V or not G then
			return false
		end
		local Z = V:FindFirstChildOfClass("Humanoid")
		if not Z then
			return false
		end
		local j, i = pcall(function()
			Z:EquipTool(G)
		end)
		if not j then
			warn("\226\157\140 Failed to equip tool:", i)
			return false
		end
		return true
	end
}
T.PlayerSpeedStatusText = ""
u.PlayerSpeed = {
	Started = false,
	OriginalSpeed = nil,
	LastAppliedSpeed = nil,
	SetStatusPlayerSpeed = function(G, V)
		T.PlayerSpeedStatusText = string.format("<stroke color=\'#000000\' thickness=\'1\'><font color=\'%s\'>\226\154\161 Player Speed:</font> <font color=\'#FFFFFF\'>%s</font></stroke>", tostring(V or "#FFFFFF"), tostring(G or ""))
	end;
	GetHumanoidPlayerSpeed = function()
		local G = y.Character
		local V = G and G:FindFirstChildOfClass("Humanoid")
		if not V or V.Health <= 0 then
			return nil
		end
		return V
	end;
	ApplyPlayerSpeed = function()
		local G = u.PlayerSpeed.GetHumanoidPlayerSpeed()
		if not G then
			T.PlayerSpeedStatusText = ""
			return false
		end
		if not e.player_speed_enabled then
			if u.PlayerSpeed.OriginalSpeed and (u.PlayerSpeed.LastAppliedSpeed and math.abs(G.WalkSpeed - u.PlayerSpeed.LastAppliedSpeed) <= 1) then
				G.WalkSpeed = u.PlayerSpeed.OriginalSpeed
			end
			u.PlayerSpeed.OriginalSpeed = nil
			u.PlayerSpeed.LastAppliedSpeed = nil
			T.PlayerSpeedStatusText = ""
			return false
		end
		local V = math.clamp(tonumber(e.player_speed_value) or 80, 16, 160)
		if not u.PlayerSpeed.OriginalSpeed then
			u.PlayerSpeed.OriginalSpeed = G.WalkSpeed
		end
		if G.WalkSpeed < V then
			G.WalkSpeed = V
			u.PlayerSpeed.LastAppliedSpeed = V
		end
		u.PlayerSpeed.SetStatusPlayerSpeed(string.format("Minimum %d \226\128\162 Current %d", V, math.floor(G.WalkSpeed + .5)), "#66CCFF")
		return true
	end,
	StartPlayerSpeed = function()
		if u.PlayerSpeed.Started then
			return false
		end
		u.PlayerSpeed.Started = true
		task.spawn(function()
			while true do
				task.wait(.25)
				u.PlayerSpeed.ApplyPlayerSpeed()
			end
		end)
		return true
	end
}
u.PlayerSpeed.StartPlayerSpeed()
u.Player.CameraSetUp()
u.PlayerUI = {
	Started = false,
	OriginalStates = {};
	TargetNames = {
		Plot1 = true;
		Plot2 = true,
		Plot3 = true,
		Plot4 = true,
		Plot5 = true;
		Plot6 = true,
		Plot7 = true;
		Plot8 = true;
		TeleportButtons = true
	},
	GetProperty = function(G)
		if not G then
			return nil
		end
		if G:IsA("LayerCollector") then
			return "Enabled"
		end
		if G:IsA("GuiObject") then
			return "Visible"
		end
		return nil
	end;
	ApplyObject = function(G)
		if not G or not u.PlayerUI.TargetNames[G.Name] then
			return
		end
		local V = u.PlayerUI.GetProperty(G)
		if not V then
			return
		end
		if e.hide_player_ui then
			if u.PlayerUI.OriginalStates[G] == nil then
				u.PlayerUI.OriginalStates[G] = {
					property = V,
					value = G[V]
				}
			end
			G[V] = false
			return
		end
		local y = u.PlayerUI.OriginalStates[G]
		if y then
			G[y.property] = y.value
			u.PlayerUI.OriginalStates[G] = nil
		end
	end,
	Apply = function()
		local G = y.PlayerGui
		if not G then
			return
		end
		for V in pairs(u.PlayerUI.TargetNames) do
			u.PlayerUI.ApplyObject(G:FindFirstChild(V))
		end
	end,
	Start = function()
		if u.PlayerUI.Started then
			u.PlayerUI.Apply()
			return
		end
		u.PlayerUI.Started = true
		u.PlayerUI.Apply()
		y.PlayerGui.ChildAdded:Connect(function(G)
			if u.PlayerUI.TargetNames[G.Name] then
				task.defer(function()
					u.PlayerUI.ApplyObject(G)
				end)
			end
		end)
	end
}
u.PlayerUI.Start()
u.Teleport = {
	LockedBy = "",
	LockedUntil = 0;
	LockProtected = false;
	LockTeleport = function(G, V, y)
		G = tostring(G or "")
		V = tonumber(V) or 0
		y = y == true
		if G == "" or V <= 0 then
			return false
		end
		local Z = os.clock()
		local j = Z < u.Teleport.LockedUntil
		local i = j and u.Teleport.LockedBy == G
		if j and not i then
			if u.Teleport.LockProtected then
				return false
			end
			if not y then
				return false
			end
		end
		u.Teleport.LockedBy = G
		u.Teleport.LockedUntil = Z + V
		u.Teleport.LockProtected = y or i and u.Teleport.LockProtected
		return true
	end;
	UnlockTeleport = function(G)
		if u.Teleport.LockedBy ~= tostring(G or "") then
			return false
		end
		u.Teleport.LockedBy = ""
		u.Teleport.LockedUntil = 0
		u.Teleport.LockProtected = false
		return true
	end,
	IsLocked = function(G)
		if os.clock() >= u.Teleport.LockedUntil then
			u.Teleport.LockedBy = ""
			u.Teleport.LockedUntil = 0
			u.Teleport.LockProtected = false
			return false
		end
		return u.Teleport.LockedBy ~= tostring(G or "")
	end;
	GetCurrentPosition = function()
		local G = y.Character and y.Character:FindFirstChild("HumanoidRootPart")
		return G and G.CFrame or nil
	end,
	TeleportToCFrame = function(G, V)
		if typeof(G) ~= "CFrame" then
			return false
		end
		if u.Teleport.IsLocked(V) then
			return false
		end
		local Z = y.Character
		local j = Z and Z:FindFirstChild("HumanoidRootPart")
		local i = Z and Z:FindFirstChildOfClass("Humanoid")
		if not Z or not Z.Parent or not j or not i or i.Health <= 0 then
			return false
		end
		i:Move(Vector3.zero)
		j.AssemblyLinearVelocity = Vector3.zero
		j.AssemblyAngularVelocity = Vector3.zero
		Z:PivotTo(G)
		j.AssemblyLinearVelocity = Vector3.zero
		j.AssemblyAngularVelocity = Vector3.zero
		return true
	end;
	TeleportTo = function(G, V, y)
		if not G or not G.Parent then
			return false
		end
		local Z
		if G:IsA("Model") then
			Z = G:GetPivot()
		elseif G:IsA("BasePart") then
			Z = G.CFrame
		end
		if not Z then
			return false
		end
		if V then
			Z = Z + Vector3.new(5, 0, 0)
		end
		return u.Teleport.TeleportToCFrame(Z, y)
	end;
	GetLockRemaining = function()
		local G = u.Teleport.LockedUntil - os.clock()
		if G <= 0 then
			u.Teleport.LockedBy = ""
			u.Teleport.LockedUntil = 0
			u.Teleport.LockProtected = false
			return 0
		end
		return math.ceil(G)
	end;
	GetLockDisplayName = function()
		return tostring(u.Teleport.LockedBy or "")
	end,
	GetLockStatusText = function()
		local G = u.Teleport.GetLockRemaining()
		if G <= 0 then
			return ""
		end
		return string.format("<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\148\146 [Teleport]</font> <font color=\'#FFCC66\'>Locked: %s (%ds)</font></stroke>", u.Teleport.GetLockDisplayName(), G)
	end
}
u.GameTeleport = {
	Destinations = {
		Garden = true,
		Seeds = true,
		Sell = true
	};
	Request = function(G, V)
		G = tostring(G or "")
		V = tostring(V or "")
		if not u.GameTeleport.Destinations[G] then
			return false
		end
		local Z = y.Networking and (y.Networking.TeleportButton and y.Networking.TeleportButton.Request)
		if not Z or type(Z.Fire) ~= "function" then
			return false
		end
		if V ~= "" and u.Teleport.IsLocked(V) then
			return false
		end
		if V ~= "" and not u.Teleport.LockTeleport(V, 5, true) then
			return false
		end
		local j, i = pcall(function()
			Z:Fire(G)
		end)
		if not j then
			if V ~= "" then
				u.Teleport.UnlockTeleport(V)
			end
			warn("[Game Teleport]", i)
			return false
		end
		return true
	end,
	Garden = function(G)
		return u.GameTeleport.Request("Garden", G)
	end,
	Seeds = function(G)
		return u.GameTeleport.Request("Seeds", G)
	end,
	Sell = function(G)
		return u.GameTeleport.Request("Sell", G)
	end
}
u.StepTeleport = {
	Busy = false;
	Cancelled = false,
	StepSize = 9;
	StepDelay = .35 * ((100 / math.clamp(tonumber(e.step_teleport_speed) or 100, 25, 500)));
	ReachDistance = 3,
	GetCFrame = function(G)
		if typeof(G) == "CFrame" then
			return G
		end
		if typeof(G) == "Vector3" then
			return CFrame.new(G)
		end
		if typeof(G) ~= "Instance" or not G.Parent then
			return nil
		end
		if G:IsA("BasePart") then
			return G.CFrame
		end
		if G:IsA("Model") then
			return G:GetPivot()
		end
		local V = G:FindFirstChildWhichIsA("BasePart", true)
		return V and V.CFrame or nil
	end,
	GetIgnoreObject = function(G)
		if typeof(G) ~= "Instance" then
			return nil
		end
		if G:IsA("Model") then
			return G
		end
		local V = G:FindFirstAncestorOfClass("Model")
		return V or G
	end;
	GetCharacter = function()
		local G = y.Character
		local V = G and G:FindFirstChild("HumanoidRootPart")
		local Z = G and G:FindFirstChildOfClass("Humanoid")
		if not G or not G.Parent or not V or not Z or Z.Health <= 0 then
			return nil
		end
		return G, V, Z
	end,
	FindGroundPosition = function(G, V)
		if typeof(V) ~= "Vector3" then
			return nil
		end
		local Z = y.Character
		local j = u.StepTeleport.GetIgnoreObject(G)
		local i = RaycastParams.new()
		local c = {}
		if Z then
			table.insert(c, Z)
		end
		if j then
			table.insert(c, j)
		end
		i.FilterType = Enum.RaycastFilterType.Exclude
		i.FilterDescendantsInstances = c
		local J = {
			V
		}
		for G = 4, 20, 4 do
			for y = 0, 315, 45 do
				local Z = math.rad(y)
				table.insert(J, V + Vector3.new(math.cos(Z) * G, 0, math.sin(Z) * G))
			end
		end
		for G, V in ipairs(J) do
			local y = workspace:Raycast(V + Vector3.new(0, 40, 0), Vector3.new(0, - 100, 0), i)
			if y and y.Normal.Y >= .45 then
				return y.Position + Vector3.new(0, 3, 0)
			end
		end
		return nil
	end;
	Begin = function(G, V)
		G = tostring(G or "")
		if u.StepTeleport.Busy or u.Teleport.IsLocked(G) then
			return nil
		end
		local y, Z, j = u.StepTeleport.GetCharacter()
		if not y then
			return nil
		end
		local i = G ~= "" and (os.clock() < u.Teleport.LockedUntil and u.Teleport.LockedBy == G)
		local c = false
		if G ~= "" then
			if not u.Teleport.LockTeleport(G, V or 30, true) then
				return nil
			end
			c = not i
		end
		u.StepTeleport.Busy = true
		u.StepTeleport.Cancelled = false
		return {
			Character = y;
			Root = Z;
			Humanoid = j;
			Caller = G,
			AcquiredLock = c
		}
	end;
	Finish = function(G)
		if type(G) == "table" and (G.AcquiredLock and G.Caller ~= "") then
			u.Teleport.UnlockTeleport(G.Caller)
		end
		u.StepTeleport.Busy = false
		u.StepTeleport.Cancelled = false
	end;
	MoveSegment = function(G, V, y)
		if type(G) ~= "table" or typeof(V) ~= "Vector3" then
			return false
		end
		local Z = G.Root
		if not Z or not Z.Parent then
			return false
		end
		local j = ((V - Z.Position)).Magnitude
		local i = math.max(math.ceil(j / u.StepTeleport.StepSize) + 6, 6)
		local c = 0
		local J = math.huge
		local T = 0
		while true do
			if u.StepTeleport.Cancelled then
				return false
			end
			local Z = G.Character
			local j = G.Root
			local d = G.Humanoid
			if not Z or not Z.Parent or not j or not j.Parent or not d or d.Health <= 0 then
				return false
			end
			local q = Z:GetPivot()
			local g = V - q.Position
			local E = g.Magnitude
			c += 1
			if c > i then
				warn("[StepTeleport] Maximum steps reached")
				return false
			end
			if E >= J - .25 then
				T += 1
			else
				T = 0
			end
			if T >= 4 then
				warn("[StepTeleport] Movement stuck")
				return false
			end
			J = E
			if E <= u.StepTeleport.ReachDistance then
				return true
			end
			local a = math.min(u.StepTeleport.StepSize, E)
			local H = q.Position + g.Unit * a
			local r = q.Rotation
			if E <= u.StepTeleport.StepSize and typeof(y) == "CFrame" then
				r = y
			end
			local Y = CFrame.new(H) * r
			d:Move(Vector3.zero)
			j.AssemblyLinearVelocity = Vector3.zero
			j.AssemblyAngularVelocity = Vector3.zero
			Z:PivotTo(Y)
			j.AssemblyLinearVelocity = Vector3.zero
			j.AssemblyAngularVelocity = Vector3.zero
			if G.Caller ~= "" then
				u.Teleport.LockTeleport(G.Caller, 2, true)
			end
			task.wait(u.StepTeleport.StepDelay)
			if not j.Parent or ((j.Position - H)).Magnitude > 6 then
				warn("[StepTeleport] Server correction detected")
				return false
			end
		end
	end,
	ToCFrame = function(G, V)
		if typeof(G) ~= "CFrame" then
			return false
		end
		local y, Z = u.StepTeleport.GetCharacter()
		if not y then
			return false
		end
		local j = ((Z.Position - G.Position)).Magnitude
		local i = math.ceil(j / u.StepTeleport.StepSize) * u.StepTeleport.StepDelay + 5
		local c = u.StepTeleport.Begin(V, i)
		if not c then
			return false
		end
		local J, T = pcall(function()
			return u.StepTeleport.MoveSegment(c, G.Position, G.Rotation)
		end)
		task.wait(.5)
		if J and (T and (c.Root and c.Root.Parent)) then
			T = ((c.Root.Position - G.Position)).Magnitude <= 5
		end
		u.StepTeleport.Finish(c)
		if not J then
			warn("[StepTeleport]", T)
			return false
		end
		return T == true
	end;
	To = function(G, V, y)
		local Z = u.StepTeleport.GetCFrame(G)
		if not Z then
			return false
		end
		if typeof(V) == "Vector3" then
			Z = Z + V
		end
		return u.StepTeleport.ToCFrame(Z, y)
	end,
	PathTo = function(G, V)
		local Z = u.StepTeleport.GetCFrame(G)
		if not Z then
			return false
		end
		local j = u.StepTeleport.Begin(V, 60)
		if not j then
			return false
		end
		local i = false
		local c, J = pcall(function()
			local V = u.StepTeleport.FindGroundPosition(G, Z.Position)
			if not V then
				return false
			end
			local i = y.PathfindingService:CreatePath({
				AgentRadius = 2,
				AgentHeight = 5,
				AgentCanJump = true;
				AgentCanClimb = true;
				WaypointSpacing = 6
			})
			i:ComputeAsync(j.Root.Position, V)
			if i.Status ~= Enum.PathStatus.Success then
				return false
			end
			local c = i:GetWaypoints()
			for G = 2, # c, 1 do
				if not u.StepTeleport.MoveSegment(j, c[G].Position) then
					return false
				end
			end
			task.wait(.5)
			return ((j.Root.Position - V)).Magnitude <= 5
		end)
		if c then
			i = J == true
		else
			warn("[StepTeleport]", J)
		end
		u.StepTeleport.Finish(j)
		return i
	end,
	Stop = function()
		u.StepTeleport.Cancelled = true
	end
}
u.Movement = {
	WalkSpeed = 140;
	Timeout = 30,
	StopDistance = 5,
	MoveLikePlayerToPoint = function(G, V)
		if typeof(G) ~= "Vector3" then
			return false
		end
		V = math.max(tonumber(V) or 5, .2)
		local Z = "ExoMoveLikePlayer_" .. tostring(math.random(100000, 999999))
		local j = Instance.new("BindableEvent")
		local i = os.clock()
		local c = false
		local J = math.huge
		local T = 0
		y.RunService:BindToRenderStep(Z, Enum.RenderPriority.Input.Value + 20, function()
			local Z = y.Character
			local d = Z and Z:FindFirstChild("HumanoidRootPart")
			local u = Z and Z:FindFirstChildOfClass("Humanoid")
			if not Z or not Z.Parent or not d or not u or u.Health <= 0 then
				y.LocalPlayer:Move(Vector3.zero, false)
				c = false
				j:Fire()
				return
			end
			if os.clock() - i >= V then
				y.LocalPlayer:Move(Vector3.zero, false)
				c = false
				j:Fire()
				return
			end
			local q = Vector3.new(G.X - d.Position.X, 0, G.Z - d.Position.Z)
			local g = q.Magnitude
			if g <= 4 then
				y.LocalPlayer:Move(Vector3.zero, false)
				c = true
				j:Fire()
				return
			end
			if g >= J - .03 then
				T += 1
			else
				T = 0
			end
			if T >= 60 then
				u.Jump = true
				T = 0
			end
			J = g
			y.LocalPlayer:Move(q.Unit, false)
		end)
		j.Event:Wait()
		pcall(function()
			y.RunService:UnbindFromRenderStep(Z)
		end)
		y.LocalPlayer:Move(Vector3.zero, false)
		j:Destroy()
		return c
	end,
	GetPosition = function(G)
		if typeof(G) == "Vector3" then
			return G
		end
		if typeof(G) == "CFrame" then
			return G.Position
		end
		if typeof(G) ~= "Instance" or not G.Parent then
			return nil
		end
		if G:IsA("BasePart") then
			return G.Position
		end
		if G:IsA("Model") then
			return (G:GetPivot()).Position
		end
		local V = G:FindFirstChildWhichIsA("BasePart", true)
		return V and V.Position or nil
	end;
	IsTargetValid = function(G)
		if typeof(G) == "Vector3" or typeof(G) == "CFrame" then
			return true
		end
		return typeof(G) == "Instance" and G.Parent ~= nil
	end,
	Distance2D = function(G, V)
		if typeof(G) ~= "Vector3" or typeof(V) ~= "Vector3" then
			return math.huge
		end
		local y = G - V
		return (Vector2.new(y.X, y.Z)).Magnitude
	end,
	GetTargetIgnoreObject = function(G)
		if typeof(G) ~= "Instance" then
			return nil
		end
		if G:IsA("Model") then
			return G
		end
		local V = G.Parent
		while V and V ~= workspace do
			if V:IsA("Model") then
				return V
			end
			V = V.Parent
		end
		return G
	end;
	MoveToPoint = function(G, V, y, Z, j)
		if not G or not V or typeof(y) ~= "Vector3" then
			return false
		end
		Z = math.max(tonumber(Z) or 5, .2)
		j = math.clamp(tonumber(j) or 40, 16, 50)
		G.WalkSpeed = j
		G.Sit = false
		G:MoveTo(y)
		local i = os.clock()
		while os.clock() - i < Z do
			if not G.Parent or G.Health <= 0 or not V.Parent then
				return false
			end
			G.WalkSpeed = j
			if u.Movement.Distance2D(V.Position, y) <= 3.5 then
				return true
			end
			task.wait(.05)
		end
		return u.Movement.Distance2D(V.Position, y) <= 4
	end;
	FindWalkablePath = function(G, V, Z, j)
		local i = u.Movement.GetPosition(G)
		if not i or not V or not Z or not y.PathfindingService then
			return nil, nil
		end
		local c = RaycastParams.new()
		local J = {
			V
		}
		local T = u.Movement.GetTargetIgnoreObject(G)
		if T then
			table.insert(J, T)
		end
		c.FilterType = Enum.RaycastFilterType.Exclude
		c.FilterDescendantsInstances = J
		local d = {
			i
		}
		for G = 5, 25, 5 do
			for V = 0, 315, 45 do
				local y = math.rad(V)
				table.insert(d, i + Vector3.new(math.cos(y) * G, 0, math.sin(y) * G))
			end
		end
		for G, V in ipairs(d) do
			if j and os.clock() >= j then
				break
			end
			local i = workspace:Raycast(V + Vector3.new(0, 40, 0), Vector3.new(0, - 100, 0), c)
			if not i or i.Normal.Y < .45 then
				continue
			end
			local J = i.Position + Vector3.new(0, 2.5, 0)
			local T = y.PathfindingService:CreatePath({
				AgentRadius = 2;
				AgentHeight = 5;
				AgentCanJump = true;
				AgentCanClimb = true,
				WaypointSpacing = 4
			})
			local d = pcall(function()
				T:ComputeAsync(Z.Position, J)
			end)
			if d and (T.Status == Enum.PathStatus.Success and # T:GetWaypoints() > 0) then
				return T, J
			end
		end
		return nil, nil
	end,
	WalkPathToTarget = function(G, V, Z, j)
		V = math.max(tonumber(V) or u.Movement.Timeout, 5)
		j = math.max(tonumber(j) or 10, 3)
		Z = tostring(Z or "")
		if type(u.Movement.MoveLikePlayerToPoint) ~= "function" then
			return false
		end
		if not u.Movement.IsTargetValid(G) then
			return false
		end
		if u.Teleport.IsLocked(Z) then
			return false
		end
		local i = Z ~= "" and (os.clock() < u.Teleport.LockedUntil and u.Teleport.LockedBy == Z)
		local c = false
		if Z ~= "" then
			if not u.Teleport.LockTeleport(Z, V + 2, true) then
				return false
			end
			c = not i
		end
		local J = os.clock() + V
		local T, d = pcall(function()
			for V = 1, 5, 1 do
				if os.clock() >= J or not u.Movement.IsTargetValid(G) then
					break
				end
				local i = y.Character
				local c = i and i:FindFirstChildOfClass("Humanoid")
				local T = i and i:FindFirstChild("HumanoidRootPart")
				if not i or not i.Parent or not c or c.Health <= 0 or not T then
					break
				end
				local d = u.Movement.GetPosition(G)
				if not d then
					break
				end
				if u.Movement.Distance2D(T.Position, d) <= j then
					return u.Teleport.TeleportTo(G, true, Z)
				end
				local q = u.Movement.FindWalkablePath(G, i, T, J)
				if not q then
					local G = J - os.clock()
					if G <= 0 then
						break
					end
					u.Movement.MoveLikePlayerToPoint(d, math.min(5, G))
				else
					local V = q:GetWaypoints()
					local y = false
					local i = 1
					local d = q.Blocked:Connect(function(G)
						if G >= i then
							y = true
						end
					end)
					for q = 2, # V, 1 do
						if y or os.clock() >= J or not u.Movement.IsTargetValid(G) then
							break
						end
						i = q
						local g = V[q]
						if g.Action == Enum.PathWaypointAction.Jump then
							c.Jump = true
						end
						local E = u.Movement.GetPosition(G)
						if E and u.Movement.Distance2D(T.Position, E) <= j then
							d:Disconnect()
							return u.Teleport.TeleportTo(G, true, Z)
						end
						if Z ~= "" then
							u.Teleport.LockTeleport(Z, math.max(J - os.clock(), 2), true)
						end
						local a = J - os.clock()
						if a <= 0 then
							break
						end
						if not u.Movement.MoveLikePlayerToPoint(g.Position, math.min(5, a)) then
							y = true
							break
						end
					end
					d:Disconnect()
				end
				task.wait(.05)
			end
			local V = y.Character
			local i = V and V:FindFirstChild("HumanoidRootPart")
			local c = u.Movement.GetPosition(G)
			if i and (c and u.Movement.Distance2D(i.Position, c) <= j) then
				return u.Teleport.TeleportTo(G, true, Z)
			end
			return false
		end)
		pcall(function()
			y.LocalPlayer:Move(Vector3.zero, false)
		end)
		if T and d then
			if Z ~= "" then
				u.Teleport.LockTeleport(Z, 2, true)
			end
			return true
		end
		if Z ~= "" and c then
			u.Teleport.UnlockTeleport(Z)
		end
		if not T then
			warn("[Player Walk]", d)
		end
		return false
	end;
	PathTo = function(G, V, Z, j)
		V = math.clamp(tonumber(V) or u.Movement.WalkSpeed, 16, 50)
		Z = math.max(tonumber(Z) or u.Movement.Timeout, 5)
		j = tostring(j or "")
		if not u.Movement.IsTargetValid(G) then
			return false
		end
		if u.Teleport.IsLocked(j) then
			return false
		end
		local i = j ~= "" and (os.clock() < u.Teleport.LockedUntil and u.Teleport.LockedBy == j)
		local c = false
		if j ~= "" then
			if not u.Teleport.LockTeleport(j, Z + 2, true) then
				return false
			end
			c = not i
		end
		local J = y.Character
		local T = J and J:FindFirstChildOfClass("Humanoid")
		local d = J and J:FindFirstChild("HumanoidRootPart")
		if not J or not J.Parent or not T or T.Health <= 0 or not d then
			if c then
				u.Teleport.UnlockTeleport(j)
			end
			return false
		end
		local q = T.WalkSpeed
		local g = os.clock() + Z
		local E = false
		T.WalkSpeed = V
		T.Sit = false
		local a, H = pcall(function()
			for y = 1, 5, 1 do
				if os.clock() >= g or not u.Movement.IsTargetValid(G) or not J.Parent or T.Health <= 0 then
					break
				end
				local Z = u.Movement.GetPosition(G)
				if Z and u.Movement.Distance2D(d.Position, Z) <= u.Movement.StopDistance then
					E = true
					break
				end
				local i, c = u.Movement.FindWalkablePath(G, J, d, g)
				if not i or not c then
					warn("[Path Movement] No walkable route found")
					break
				end
				local q = i:GetWaypoints()
				local a = false
				local H = 1
				local r = i.Blocked:Connect(function(G)
					if G >= H then
						a = true
					end
				end)
				for y = 2, # q, 1 do
					if a or os.clock() >= g or not u.Movement.IsTargetValid(G) or not J.Parent or T.Health <= 0 then
						break
					end
					H = y
					local Z = q[y]
					if Z.Action == Enum.PathWaypointAction.Jump then
						T.Jump = true
					end
					if j ~= "" then
						u.Teleport.LockTeleport(j, math.max(g - os.clock(), 2), true)
					end
					local i = g - os.clock()
					local c = u.Movement.MoveToPoint(T, d, Z.Position, math.min(5, i), V)
					if not c then
						a = true
						break
					end
				end
				r:Disconnect()
				if u.Movement.Distance2D(d.Position, c) <= u.Movement.StopDistance then
					E = true
					break
				end
				task.wait(.1)
			end
		end)
		if T and T.Parent then
			T.WalkSpeed = q
			if d and d.Parent then
				T:MoveTo(d.Position)
			end
		end
		if j ~= "" then
			if c then
				u.Teleport.UnlockTeleport(j)
			else
				u.Teleport.LockTeleport(j, 2, true)
			end
		end
		if not a then
			warn("[Path Movement]", H)
			return false
		end
		return E
	end
}
u.ProximityPrompt = {
	ActivateProximityPrompt = function(G)
		if not G or not G:IsA("ProximityPrompt") then
			return
		end
		local V = G.HoldDuration
		local y = G.MaxActivationDistance
		G.HoldDuration = 0
		G.MaxActivationDistance = 10000
		fireproximityprompt(G)
		G.HoldDuration = V
		G.MaxActivationDistance = y
	end,
	FindProximityPrompt = function(G, V)
		return G:FindFirstChild(V, true)
	end;
	FindProximityPromptByClass = function(G)
		if not G then
			return nil
		end
		return G:FindFirstChildWhichIsA("ProximityPrompt", true)
	end
}
u.Backpack = {
	GetBackpackAllItems = function()
		local G = {}
		local V = y.LocalPlayer:FindFirstChild("Backpack")
		if not V then
			V = y.LocalPlayer:FindFirstChild("Backpack")
		end
		if not V then
			return G
		end
		local Z = u.Player.GetTool_Holding()
		if Z then
			table.insert(G, Z)
		end
		for V, y in ipairs(V:GetChildren()) do
			table.insert(G, y)
		end
		return G
	end,
	GetAllSeedTools = function()
		local G = {}
		local V = u.Backpack.GetBackpackAllItems()
		for V, y in ipairs(V) do
			local Z = y:GetAttribute("SeedTool")
			if not Z then
				continue
			end
			table.insert(G, y)
		end
		return G
	end,
	GetSeedToolAndCountUsingName = function(G)
		local V = y.LocalPlayer:FindFirstChild("Backpack")
		local Z = V:FindFirstChild(G)
		if not Z then
			Z = u.Player.GetTool_Holding()
		end
		local j = Z and Z:GetAttribute("SeedTool") or nil
		if not j then
			return nil, 0
		end
		local i = Z and Z:GetAttribute("Count") or 0
		return Z, i
	end,
	GetAllFruits = function()
		local G = {}
		local V = u.Backpack.GetBackpackAllItems()
		for V, y in ipairs(V) do
			if not y or not y:IsA("Tool") then
				continue
			end
			local Z = y:GetAttribute("FruitName") or y:GetAttribute("Fruit")
			if type(Z) ~= "string" or Z == "" then
				continue
			end
			local j = y:GetAttribute("Id") or ""
			local i = tonumber(y:GetAttribute("Weight") or y:GetAttribute("weight") or y:GetAttribute("KG") or y:GetAttribute("Kg") or 0)
			local c = {
				ob = y;
				id = j;
				name = Z,
				w = i
			}
			table.insert(G, c)
		end
		table.sort(G, function(G, V)
			return G.w > V.w
		end)
		return G
	end
}
T.MyFarmPlot = nil
T.OtherPlayerPlots = {}
u.Farm = {
	_Random = Random.new(),
	GetOwnPlot = function()
		if T.MyFarmPlot and (T.MyFarmPlot.Parent and tonumber(T.MyFarmPlot:GetAttribute("OwnerUserId")) == tonumber(T.player_userid)) then
			return T.MyFarmPlot
		end
		T.MyFarmPlot = nil
		local G = y.Workspace:FindFirstChild("Gardens")
		if not G then
			return nil
		end
		for G, V in ipairs(G:GetChildren()) do
			if tonumber(V:GetAttribute("OwnerUserId")) == tonumber(T.player_userid) then
				T.MyFarmPlot = V
				return V
			end
		end
		return nil
	end,
	GetPlantArea = function(G)
		if G ~= "PlantAreaColumn1" and G ~= "PlantAreaColumn2" then
			return nil
		end
		local V = u.Farm.GetOwnPlot()
		local y = V and V:FindFirstChild("Visual")
		local Z = y and y:FindFirstChild(G)
		return Z and (Z:IsA("BasePart") and Z) or nil
	end;
	TeleportToCenter = function(G)
		local V = u.Farm.GetCenterPointPart()
		if not V then
			return false
		end
		local y
		if V:IsA("BasePart") then
			y = V.CFrame
		elseif V:IsA("Model") then
			y = V:GetPivot()
		end
		if not y then
			return false
		end
		return u.Teleport.TeleportToCFrame(y * CFrame.new(0, 3, 0), G)
	end,
	GetPlantAreaAtPosition = function(G)
		if typeof(G) ~= "Vector3" then
			return nil, nil
		end
		for V, y in ipairs(u.Farm.GetPlantAreas()) do
			local Z = y.CFrame:PointToObjectSpace(G)
			if math.abs(Z.X) <= y.Size.X / 2 and math.abs(Z.Z) <= y.Size.Z / 2 then
				return y, Z
			end
		end
		return nil, nil
	end;
	GetMyPlantsFolder = function()
		local G = u.Farm.GetOwnPlot()
		if not G then
			return nil
		end
		return G:FindFirstChild("Plants")
	end,
	GetMyPlantsFoldersNotMine = function()
		if # T.OtherPlayerPlots > 0 then
			return T.OtherPlayerPlots
		end
		T.OtherPlayerPlots = {}
		local G = y.Workspace:FindFirstChild("Gardens")
		if not G then
			return T.OtherPlayerPlots
		end
		for G, V in ipairs(G:GetChildren()) do
			if tonumber(V:GetAttribute("OwnerUserId")) ~= tonumber(T.player_userid) then
				table.insert(T.OtherPlayerPlots, V)
			end
		end
		return T.OtherPlayerPlots
	end;
	GetPlants = function()
		local G = {}
		local V = u.Farm.GetOwnPlot()
		if not V then
			return G
		end
		local y = V:FindFirstChild("Plants")
		if not y then
			return G
		end
		for V, y in ipairs(y:GetChildren()) do
			table.insert(G, y)
		end
		local Z = T.alt_Plants_Physical[T.player_userid]
		if Z then
			for V, y in ipairs(Z:GetChildren()) do
				table.insert(G, y)
			end
		end
		return G
	end,
	GetPermanentCenterCFrame = function()
		local G = u.Farm.GetCenterPointPart()
		if G and G:IsA("BasePart") then
			return G.CFrame
		end
		if G and G:IsA("Model") then
			return G:GetPivot()
		end
		return nil
	end,
	GetPermanentCenterPosition = function()
		local G = u.Farm.GetPermanentCenterCFrame()
		return G and G.Position or nil
	end;
	ProjectPositionToPlantArea = function(G, V)
		if typeof(G) ~= "Vector3" then
			return nil, nil, nil
		end
		V = math.max(tonumber(V) or 1, 0)
		local y
		local Z
		local j
		local i = math.huge
		for c, J in ipairs(u.Farm.GetPlantAreas()) do
			local T = J.CFrame:PointToObjectSpace(G)
			local d = math.max(J.Size.X / 2 - V, 0)
			local u = math.max(J.Size.Z / 2 - V, 0)
			local q = math.clamp(T.X, - d, d)
			local g = math.clamp(T.Z, - u, u)
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
	end;
	GetPermanentPlantPosition = function(G)
		local V = u.Farm.GetPermanentCenterPosition()
		if typeof(V) ~= "Vector3" then
			return nil, nil, nil
		end
		return u.Farm.ProjectPositionToPlantArea(V, G)
	end,
	GetDataSyncPlantsForFarmCounts = function()
		local G = {}
		local V = u.FruitFiltersDataSync
		if not V or type(V.Plants) ~= "table" then
			return G
		end
		if not V.Started and type(V.StartSync) == "function" then
			V.StartSync()
		end
		for V, y in pairs(V.Plants) do
			if type(y) ~= "table" or y.Removed then
				continue
			end
			y.Id = tostring(y.Id or V or "")
			table.insert(G, y)
		end
		return G
	end;
	GetPlantedSeedTotalCount = function()
		local G = 0
		for V, y in ipairs(u.Farm.GetDataSyncPlantsForFarmCounts()) do
			if type(y.PlantName) == "string" and y.PlantName ~= "" then
				G += 1
			end
		end
		return G
	end,
	GetPlantedSeedCounts = function()
		local G = {}
		for V, y in ipairs(u.Farm.GetDataSyncPlantsForFarmCounts()) do
			local Z = tostring(y.PlantName or "")
			if Z ~= "" then
				G[Z] = ((G[Z] or 0)) + 1
			end
		end
		return G
	end;
	GetSpawnPoint = function()
		local G = u.Farm.GetOwnPlot()
		if not G then
			return nil
		end
		return G:FindFirstChild("SpawnPoint")
	end,
	GetPlantAreas = function()
		local G = {}
		local V = u.Farm.GetOwnPlot()
		if not V then
			return G
		end
		local y = V:FindFirstChild("Visual")
		if not y then
			return G
		end
		local Z = {
			"PlantAreaColumn1";
			"PlantAreaColumn2"
		}
		for V, Z in ipairs(Z) do
			local j = y:FindFirstChild(Z)
			if j and j:IsA("BasePart") then
				table.insert(G, j)
			end
		end
		return G
	end,
	GetCenterPointPart = function()
		local G = u.Farm.GetOwnPlot()
		if not G then
			return nil
		end
		local V = G:FindFirstChild("Visual")
		if not V then
			return nil
		end
		local y = V:FindFirstChild("PRIM")
		return y
	end,
	DistanceFromPoint = function()
		local G = u.Farm.GetCenterPointPart()
		if not G then
			return math.huge
		end
		local V = (y.LocalPlayer and y.LocalPlayer.Character) or y.Character
		local Z = V and V:FindFirstChild("HumanoidRootPart")
		if not Z then
			return math.huge
		end
		local j
		if G:IsA("BasePart") then
			j = G.Position
		elseif G:IsA("Model") then
			j = (G:GetPivot()).Position
		else
			return math.huge
		end
		return ((Z.Position - j)).Magnitude
	end;
	IsNearFarm = function(G)
		G = tonumber(G) or 15
		return u.Farm.DistanceFromPoint() <= G
	end,
	EnsureAtFarm = function(G)
		G = tonumber(G) or 15
		if u.Farm.IsNearFarm(G) then
			return true
		end
		local V = u.Farm.GetSpawnPoint()
		if not V or not V:IsA("BasePart") then
			return false
		end
		local Z = y.LocalPlayer and y.LocalPlayer.Character or y.Character
		if not Z or not Z.Parent then
			return false
		end
		local j = u.Teleport.TeleportToCFrame(V.CFrame * CFrame.new(0, 3, 0), "EnsureAtFarm")
		if not j then
			return false
		end
		task.wait(.15)
		return true
	end;
	GetRandomLocationForSeed = function(G)
		local V = u.Farm.GetPlantAreas()
		if # V == 0 then
			return nil
		end
		local y = V[u.Farm._Random:NextInteger(1, # V)]
		local Z = math.max(tonumber(G) or .5, 0)
		local j = math.max((y.Size.X / 2) - Z, 0)
		local i = math.max((y.Size.Z / 2) - Z, 0)
		local c = u.Farm._Random:NextNumber(- j, j)
		local J = u.Farm._Random:NextNumber(- i, i)
		local T = Vector3.new(c, y.Size.Y / 2, J)
		local d = y.CFrame:PointToWorldSpace(T)
		return d, y
	end
}
r.Hop = {
	Random = Random.new((((os.time() + T.player_userid) + math.floor(os.clock() * 100000))) % 2147483647);
	MaxPlayers = 8,
	PagesPerDirection = 4;
	TriedServers = {};
	TeleportToJobId = function(G, V)
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
		local j, i = pcall(function()
			y.TeleportService:TeleportToPlaceInstance(V, G, Z)
		end)
		if not j then
			warn("[Hop] Teleport failed:", i)
			return false
		end
		return true
	end;
	GetFriendServerIds = function()
		local G = {}
		local V = y.LocalPlayer
		if not V then
			return G
		end
		local Z, j = pcall(function()
			return V:GetFriendsOnlineAsync(200)
		end)
		if not Z or type(j) ~= "table" then
			return G
		end
		for V, y in ipairs(j) do
			if type(y) ~= "table" then
				continue
			end
			local Z = tonumber(y.PlaceId)
			local j = tostring(y.GameId or "")
			if Z == game.PlaceId and j ~= "" then
				G[j] = true
			end
		end
		return G
	end,
	FetchServers = function(G, V, Z, j)
		if G ~= "Asc" and G ~= "Desc" then
			return false
		end
		local i = nil
		for c = 1, r.Hop.PagesPerDirection, 1 do
			local J = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=%s&excludeFullGames=true&limit=100", game.PlaceId, G)
			if i then
				J = J .. ("&cursor=" .. y.HttpService:UrlEncode(i))
			end
			local T, d = pcall(function()
				return y.HttpService:JSONDecode(game:HttpGet(J))
			end)
			if not T or type(d) ~= "table" or type(d.data) ~= "table" then
				break
			end
			for G, y in ipairs(d.data) do
				if type(y) ~= "table" then
					continue
				end
				local i = tostring(y.id or "")
				local c = tonumber(y.playing)
				local J = tonumber(y.maxPlayers)
				if i == "" or V[i] or j[i] then
					continue
				end
				if not c or J ~= r.Hop.MaxPlayers or c < 0 or c >= J then
					continue
				end
				j[i] = true
				table.insert(Z, y)
			end
			i = d.nextPageCursor
			if type(i) ~= "string" or i == "" then
				break
			end
			task.wait(.1)
		end
		return true
	end;
	FindRandomServer = function()
		local G = r.Hop.GetFriendServerIds()
		G[game.JobId] = true
		for V in pairs(r.Hop.TriedServers) do
			G[V] = true
		end
		local V = {}
		local y = {}
		r.Hop.FetchServers("Asc", G, V, y)
		r.Hop.FetchServers("Desc", G, V, y)
		if # V == 0 then
			warn("[Hop] No random non-friend server found")
			return nil
		end
		local Z = r.Hop.Random:NextInteger(1, # V)
		local j = V[Z]
		local i = tostring(j.id or "")
		if i == "" then
			return nil
		end
		r.Hop.TriedServers[i] = true
		print(string.format("[Hop] Random server: %s (%d/%d) | Pool: %d", i, tonumber(j.playing) or 0, tonumber(j.maxPlayers) or 0, # V))
		return i, j
	end;
	HopToNewServer = function()
		local G = r.Hop.FindRandomServer()
		if not G then
			return false
		end
		return r.Hop.TeleportToJobId(G, game.PlaceId)
	end;
	HopToNewServerUsingJobid = function(G)
		return r.Hop.TeleportToJobId(G, game.PlaceId)
	end
}
u.AntiAfk = {
	RequestHop = function()
		local G = y.Networking
		if not G then
			return
		end
		local V = G.AntiAfk and G.AntiAfk.RequestHop
		if not V then
			warn("AntiAfk.RequestHop was not found")
			return false
		end
		V:Fire()
		return true
	end
}
T.SellStatusText = ""
u.SellManager = {
	Busy = false;
	DailyDealRetryAt = 0;
	DailyDealKnown = false,
	DailyDealAvailable = false;
	DailyDealNextCheckAt = 0,
	FormatDailyDealTime = function(G)
		G = math.max(math.floor(tonumber(G) or 0), 0)
		local V = math.floor(G / 3600)
		local y = math.floor(((G % 3600)) / 60)
		local Z = G % 60
		if V > 0 then
			return string.format("%dh %02dm", V, y)
		end
		if y > 0 then
			return string.format("%dm %02ds", y, Z)
		end
		return tostring(Z) .. "s"
	end,
	SetStatus = function(G, V)
		if type(G) ~= "string" or G == "" then
			T.SellStatusText = ""
			return
		end
		T.SellStatusText = string.format("<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\146\176 [Seller]</font> <font color=\'%s\'>%s</font></stroke>", tostring(V or "#FFFFFF"), G)
	end,
	ReadDailyDealAvailable = function(G)
		if type(G) == "boolean" then
			return G
		end
		if type(G) == "string" then
			local V = string.lower(G)
			if V == "available" or V == "ready" or V == "true" then
				return true
			end
			if V == "used" or V == "unavailable" or V == "false" then
				return false
			end
			return nil
		end
		if type(G) ~= "table" then
			return nil
		end
		if G.Used == true or G.used == true or G.Claimed == true or G.claimed == true then
			return false
		end
		if G.Used == false or G.used == false then
			return true
		end
		local V = {
			"Available",
			"available",
			"IsAvailable";
			"isAvailable";
			"CanUse";
			"canUse",
			"Eligible";
			"eligible";
			"HasDeal",
			"hasDeal",
			"DailyDealAvailable",
			"dailyDealAvailable"
		}
		for V, y in ipairs(V) do
			if type(G[y]) == "boolean" then
				return G[y]
			end
		end
		local y = G.DailyDeal or G.dailyDeal or G.Deal or G.deal
		if y ~= nil then
			return u.SellManager.ReadDailyDealAvailable(y)
		end
		local Z = G.Status or G.status or G.Message or G.message
		if Z ~= nil then
			return u.SellManager.ReadDailyDealAvailable(Z)
		end
		if G[1] ~= nil then
			return u.SellManager.ReadDailyDealAvailable(G[1])
		end
		return nil
	end;
	CheckDailyDeal = function(G)
		if not e.auto_use_daily_deal then
			u.SellManager.DailyDealKnown = false
			u.SellManager.DailyDealAvailable = false
			return false
		end
		if not G and os.clock() < u.SellManager.DailyDealNextCheckAt then
			return u.SellManager.DailyDealKnown and u.SellManager.DailyDealAvailable
		end
		local V = y.Networking and (y.Networking.NPCS and y.Networking.NPCS.CheckDailyDeal)
		if not V or type(V.Fire) ~= "function" then
			return false
		end
		u.SellManager.DailyDealNextCheckAt = os.clock() + 5
		local Z, j = V:Fire()
		local i = u.SellManager.ReadDailyDealAvailable(Z)
		if i == nil then
			i = u.SellManager.ReadDailyDealAvailable(j)
		end
		u.SellManager.DailyDealKnown = i ~= nil
		u.SellManager.DailyDealAvailable = i == true
		return u.SellManager.DailyDealAvailable
	end,
	SellFruit = function(G)
		if type(G) ~= "string" or G == "" then
			return false, nil
		end
		if T.SkipAutoFavouriteBeforeSell ~= true and (u.FruitFavouriteManager and type(u.FruitFavouriteManager.RunAutoBeforeSellFruitFavouriteManager) == "function") then
			u.FruitFavouriteManager.RunAutoBeforeSellFruitFavouriteManager()
		end
		local V = y.Networking and (y.Networking.NPCS and y.Networking.NPCS.SellFruit)
		if not V or type(V.Fire) ~= "function" then
			return false, nil
		end
		return true, V:Fire(G)
	end;
	GetFruitBid = function(G)
		if type(G) ~= "string" or G == "" then
			return nil
		end
		local V = y.Networking and (y.Networking.NPCS and y.Networking.NPCS.GetFruitBid)
		if not V or type(V.Fire) ~= "function" then
			return nil
		end
		return V:Fire(G)
	end;
	PreviewSellAll = function()
		local G = y.Networking and (y.Networking.NPCS and y.Networking.NPCS.PreviewSellAll)
		if not G or type(G.Fire) ~= "function" then
			return nil
		end
		return G:Fire()
	end,
	UseDailyDealAll = function()
		local G = y.Networking and (y.Networking.NPCS and y.Networking.NPCS.UseDailyDealAll)
		if not G or type(G.Fire) ~= "function" then
			return false, nil
		end
		if T.SkipAutoFavouriteBeforeSell ~= true and (u.FruitFavouriteManager and type(u.FruitFavouriteManager.RunAutoBeforeSellFruitFavouriteManager) == "function") then
			u.FruitFavouriteManager.RunAutoBeforeSellFruitFavouriteManager()
		end
		local V = u.PlayerData.GetFruitCount()
		local Z = tonumber(u.Money.GetSheckles()) or 0
		if V <= 0 then
			return false, nil
		end
		u.SellManager.SetStatus(string.format("Trying Daily Deal on %d fruits...", V), "#FFD966")
		local j, i = pcall(function()
			return G:Fire()
		end)
		if not j then
			u.SellManager.DailyDealRetryAt = os.clock() + 60
			warn("[Daily Deal]", i)
			return false, nil
		end
		if type(i) == "table" and i.Success == false then
			local G = math.max(math.floor(tonumber(i.TimeRemaining) or 60), 1)
			u.SellManager.DailyDealRetryAt = (os.clock() + G) + 2
			u.SellManager.SetStatus(string.format("Daily Deal in %s", u.SellManager.FormatDailyDealTime(G)), "#FFCC66")
			return false, i
		end
		local c = V
		local d = Z
		local q = os.clock()
		repeat
			task.wait(.1)
			c = u.PlayerData.GetFruitCount()
			d = tonumber(u.Money.GetSheckles()) or Z
		until c < V or d > Z or os.clock() - q >= 3
		local g = type(i) == "table" and i.Success == true or c < V or d > Z
		if not g then
			u.SellManager.DailyDealRetryAt = os.clock() + 60
			u.SellManager.SetStatus("Daily Deal failed - selling normally", "#FF6666")
			return false, i
		end
		local E = math.max(d - Z, 0)
		local a = type(i) == "table" and tonumber(i.TimeRemaining) or 86400
		u.SellManager.DailyDealRetryAt = os.clock() + math.max(a, 60)
		u.SellManager.SetStatus(string.format("Daily Deal used | +$%s", J.formatShecklesNumber(E)), "#66FF99")
		return true, {
			result = i;
			fruits = V;
			earned = E,
			beforeSheckles = Z,
			afterSheckles = d
		}
	end,
	SellUsingBackpack = function()
		if u.FruitFavouriteManager and type(u.FruitFavouriteManager.RunAutoBeforeSellFruitFavouriteManager) == "function" then
			u.FruitFavouriteManager.RunAutoBeforeSellFruitFavouriteManager()
		end
		local G = u.Backpack.GetAllFruits()
		local V = T.SkipAutoFavouriteBeforeSell
		T.SkipAutoFavouriteBeforeSell = true
		for G, V in ipairs(G) do
			u.SellManager.SellFruit(V.id)
			task.wait(.05)
		end
		T.SkipAutoFavouriteBeforeSell = V
	end;
	AreSellFiltersActive = function()
		return e.sell_use_filters == true
	end;
	BuildBackpackFruitData = function(G)
		if typeof(G) ~= "Instance" or not G.Parent then
			return nil
		end
		local V = G:GetAttribute("FruitName")
		if type(V) ~= "string" or V == "" then
			return nil
		end
		local y = G:GetAttribute("Id")
		if type(y) ~= "string" or y == "" then
			return nil
		end
		local Z = G:GetAttribute("weight") or G:GetAttribute("Weight") or G:GetAttribute("KG") or G:GetAttribute("Kg")
		local j = tonumber(Z)
		local i = G:GetAttribute("Mutation") or G:GetAttribute("Mutations") or ""
		return {
			ob = G;
			id = y,
			name = V,
			n = V;
			w = u.FruitFilters.RoundWeight(j or 0);
			m = type(i) == "string" and i or "",
			has_weight = j ~= nil and j > 0
		}
	end,
	GetBackpackFruitsForSelling = function()
		local G = {}
		for V, y in ipairs(u.Backpack.GetBackpackAllItems()) do
			local Z = u.SellManager.BuildBackpackFruitData(y)
			if Z then
				table.insert(G, Z)
			end
		end
		table.sort(G, function(G, V)
			return ((tonumber(G.w) or 0)) > ((tonumber(V.w) or 0))
		end)
		return G
	end,
	PassesSellFilters = function(G)
		if type(G) ~= "table" then
			return false
		end
		local V = tostring(G.name or G.n or "")
		if V == "" or type(G.id) ~= "string" or G.id == "" then
			return false
		end
		if not u.FruitFilters.IsSelectionEmpty(e.sell_fruit_list) then
			if not u.FruitFilters.IsSelected(e.sell_fruit_list, V) then
				return false
			end
		end
		if G.has_weight == false or tonumber(G.w) == nil or tonumber(G.w) <= 0 then
			return false
		end
		if not u.FruitFilters.PassesWeightRange(G.w, e.sell_min_weight, e.sell_max_weight) then
			return false
		end
		local y, Z = u.FruitFilters.GetMutationLookup(G)
		if not u.FruitFilters.PassesMutationSelection(Z, e.sell_mutation_whitelist, e.sell_mutation_blacklist) then
			return false
		end
		local j = u.FruitFilters.GetFruitVariant(G, Z)
		if not u.FruitFilters.PassesVariantSelection(j, e.sell_variant_whitelist, e.sell_variant_blacklist) then
			return false
		end
		return true
	end,
	GetFilteredBackpackFruitsForSelling = function()
		local G = {}
		for V, y in ipairs(u.SellManager.GetBackpackFruitsForSelling()) do
			if u.SellManager.PassesSellFilters(y) then
				table.insert(G, y)
			end
		end
		return G
	end,
	GetBackpackFruitCounts = function()
		local G = {}
		for V, y in ipairs(u.SellManager.GetBackpackFruitsForSelling()) do
			local Z = tostring(y.name or "")
			if Z == "" then
				continue
			end
			G[Z] = ((G[Z] or 0)) + 1
		end
		return G
	end,
	GetSellFruitTypeDropdownWithBackpackCounts = function()
		local G = {}
		local V = u.SellManager.GetBackpackFruitCounts()
		for y, Z in ipairs(T.AllSeedsDataTable) do
			if type(Z) ~= "table" then
				continue
			end
			local j = tostring(Z.name or "")
			if j == "" then
				continue
			end
			local i = tostring(Z.rarity or "Common")
			local c = u.Data.GetRarityColor(i)
			table.insert(G, {
				Text = string.format("<font color=\"#FFFFFF\">%s</font> <font color=\"%s\">%s</font> <font color=\"#7CFC00\">x%d</font>", j, c, i, tonumber(V[j]) or 0),
				Value = j
			})
		end
		return G
	end;
	IsSellResultSuccess = function(G)
		if type(G) ~= "table" then
			return G == true
		end
		if G.Success == false then
			return false
		end
		return G.Success == true or G.SellPrice ~= nil
	end,
	SellFilteredBackpack = function(G)
		if e.sell_when_backpack_full and not G then
			return false, "waiting_full"
		end
		if u.FruitFavouriteManager and type(u.FruitFavouriteManager.RunAutoBeforeSellFruitFavouriteManager) == "function" then
			u.FruitFavouriteManager.RunAutoBeforeSellFruitFavouriteManager()
		end
		local V = u.SellManager.GetFilteredBackpackFruitsForSelling()
		if # V == 0 then
			u.SellManager.SetStatus("No fruits match sell filters", "#FFCC66")
			return false, "no_filtered_fruits"
		end
		local y = 0
		local Z = 0
		local j = tonumber(u.Money.GetSheckles()) or 0
		u.SellManager.SetStatus(string.format("Filtered selling %d fruits...", # V), "#66CCFF")
		local i = T.SkipAutoFavouriteBeforeSell
		T.SkipAutoFavouriteBeforeSell = true
		for G, V in ipairs(V) do
			if not e.auto_sell_sellallinventory then
				break
			end
			local j = u.SellManager.BuildBackpackFruitData(V.ob)
			if not j or not u.SellManager.PassesSellFilters(j) then
				continue
			end
			local i, c = u.SellManager.SellFruit(j.id)
			if i and u.SellManager.IsSellResultSuccess(c) then
				y += 1
			else
				Z += 1
			end
			task.wait(e.turbo_sell and .015 or .05)
		end
		T.SkipAutoFavouriteBeforeSell = i
		local c = tonumber(u.Money.GetSheckles()) or j
		local d = math.max(c - j, 0)
		if y > 0 then
			u.SellManager.SetStatus(string.format("Filtered sold %d fruit%s | +$%s", y, y == 1 and "" or "s", J.formatShecklesNumber(d)), "#66FF99")
			return true, {
				sold = y;
				failed = Z;
				earned = d
			}
		end
		u.SellManager.SetStatus("Filtered sell found nothing safe to sell", "#FFCC66")
		return false, {
			sold = 0;
			failed = Z,
			earned = 0
		}
	end,
	SellAllInternal = function()
		if u.FruitFavouriteManager and type(u.FruitFavouriteManager.RunAutoBeforeSellFruitFavouriteManager) == "function" then
			u.FruitFavouriteManager.RunAutoBeforeSellFruitFavouriteManager()
		end
		local G = u.PlayerData.GetFruitCount()
		if G <= 0 then
			u.SellManager.SetStatus("")
			return false, nil
		end
		local V = u.FruitCollect.IsMaxFruitInventory()
		if e.auto_double_or_nothing and T.GetCheckIfPro() then
			if u.DoubleOrNothingSeller and (type(u.DoubleOrNothingSeller.TryRunDoubleOrNothingSeller) == "function" and ((e.auto_double_or_nothing == true or u.DoubleOrNothingSeller.PendingCashOutDoubleOrNothingSeller == true))) then
				return u.DoubleOrNothingSeller.TryRunDoubleOrNothingSeller(G, V)
			end
		end
		if u.SellManager.AreSellFiltersActive() then
			return u.SellManager.SellFilteredBackpack(V)
		end
		local Z = math.max(math.ceil(u.SellManager.DailyDealRetryAt - os.clock()), 0)
		if e.auto_use_daily_deal and Z <= 0 then
			local y = u.PlayerData.GetMaxFruitCapacity()
			if not V then
				u.SellManager.SetStatus(string.format("Saving for Daily Deal %d/%d", G, y), "#FFD966")
				return false, "waiting_daily_deal"
			end
			local j, i = u.SellManager.UseDailyDealAll()
			if j then
				return true, i
			end
			Z = math.max(math.ceil(u.SellManager.DailyDealRetryAt - os.clock()), 0)
		end
		if e.sell_when_backpack_full and not V then
			return false, "waiting_full"
		end
		local j = y.Networking and (y.Networking.NPCS and y.Networking.NPCS.SellAll)
		if not j or type(j.Fire) ~= "function" then
			return false, nil
		end
		local i = "Selling fruits normally..."
		if e.auto_use_daily_deal and Z > 0 then
			i = string.format("Selling normally | Daily Deal in %s", u.SellManager.FormatDailyDealTime(Z))
		end
		u.SellManager.SetStatus(i, "#66CCFF")
		return true, j:Fire()
	end;
	SellAll = function()
		if not e.auto_sell_sellallinventory then
			u.SellManager.SetStatus("")
			return false
		end
		if u.SellManager.Busy then
			return false
		end
		u.SellManager.Busy = true
		local G, V, y = pcall(u.SellManager.SellAllInternal)
		u.SellManager.Busy = false
		if not G then
			u.SellManager.SetStatus("Seller error", "#FF6666")
			warn("[SellManager]", V)
			return false, nil
		end
		return V, y
	end
}
T.DoubleOrNothingStatusText = ""
T.DoubleOrNothingLogs = T.DoubleOrNothingLogs or {}
T.DoubleOrNothingUi = T.DoubleOrNothingUi or {}
u.DoubleOrNothingSeller = {
	BusyDoubleOrNothingSeller = false,
	PendingCashOutDoubleOrNothingSeller = false;
	PendingInfoDoubleOrNothingSeller = {},
	LastRunAtDoubleOrNothingSeller = 0;
	RetryAtDoubleOrNothingSeller = 0;
	SetStatusDoubleOrNothingSeller = function(G, V)
		G = tostring(G or "")
		if G == "" then
			T.DoubleOrNothingStatusText = ""
			return false
		end
		T.DoubleOrNothingStatusText = string.format("<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\142\178 [Double]</font> <font color=\'%s\'>%s</font></stroke>", tostring(V or "#FFFFFF"), G)
		return true
	end;
	FormatMoneyDoubleOrNothingSeller = function(G)
		return J.formatShecklesNumber(tonumber(G) or 0)
	end;
	GetTargetDoubleOrNothingSeller = function()
		return math.clamp(math.floor(tonumber(e.double_or_nothing_target_streak) or 3), 1, 10)
	end;
	GetDelayDoubleOrNothingSeller = function()
		return math.clamp(tonumber(e.double_or_nothing_roll_delay) or .15, .001, 3)
	end;
	GetRemoteDoubleOrNothingSeller = function(G)
		G = tostring(G or "")
		local V = y.Networking and (y.Networking.NPCS and y.Networking.NPCS[G])
		if not V or type(V.Fire) ~= "function" then
			return nil
		end
		return V
	end;
	FireRemoteDoubleOrNothingSeller = function(G)
		local V = u.DoubleOrNothingSeller.GetRemoteDoubleOrNothingSeller(G)
		if not V then
			return false, "Remote missing: " .. tostring(G)
		end
		local y, Z = pcall(function()
			return V:Fire()
		end)
		if not y then
			return false, tostring(Z or "Remote failed")
		end
		return true, Z
	end,
	PreviewDoubleOrNothingSeller = function(G)
		local V = nil
		if u.SellManager and type(u.SellManager.PreviewSellAll) == "function" then
			local G, y = pcall(u.SellManager.PreviewSellAll)
			if G then
				V = y
			end
		end
		V = type(V) == "table" and V or {}
		local y = math.max(math.floor(tonumber(V.FruitCount or G or u.PlayerData.GetFruitCount()) or 0), 0)
		local Z = tonumber(V.TotalSellValue or V.TotalValue or V.TotalBaseValue or V.SellPrice) or 0
		return {
			raw = V,
			fruitCount = y,
			totalValue = Z
		}
	end,
	AddLogDoubleOrNothingSeller = function(G)
		G = tostring(G or "")
		if G == "" then
			return false
		end
		table.insert(T.DoubleOrNothingLogs, 1, string.format("%s -- %s", os.date("%H:%M:%S"), G))
		while # T.DoubleOrNothingLogs > 40 do
			table.remove(T.DoubleOrNothingLogs)
		end
		if T.DoubleOrNothingUi.RefreshLogsDoubleOrNothingUi then
			T.DoubleOrNothingUi.RefreshLogsDoubleOrNothingUi()
		end
		return true
	end,
	GetLogsTextDoubleOrNothingSeller = function()
		if type(T.DoubleOrNothingLogs) ~= "table" or # T.DoubleOrNothingLogs == 0 then
			return "<font color=\'#888888\'>No Double or Nothing logs yet.</font>"
		end
		local G = {}
		for V = 1, math.min(# T.DoubleOrNothingLogs, 10), 1 do
			table.insert(G, T.DoubleOrNothingLogs[V])
		end
		return table.concat(G, "\n")
	end,
	BuildWebhookPayloadDoubleOrNothingSeller = function(G, V)
		V = type(V) == "table" and V or {}
		local Z = G == "win"
		local j = Z and "\240\159\142\178 Double or Nothing Won!" or "\240\159\146\165 Double or Nothing Lost!"
		local i = Z and "Cash-out completed successfully." or "Inventory was busted by Double or Nothing."
		local c = Z and 5763719 or 15548997
		local J = {
			{
				name = "\240\159\145\164 Account",
				value = "||@" .. (tostring(y.LocalPlayer and y.LocalPlayer.Name or "Unknown") .. "||");
				inline = true
			};
			{
				name = "\240\159\148\165 Streak",
				value = tostring(V.streak or 0) .. (" / " .. tostring(V.target or u.DoubleOrNothingSeller.GetTargetDoubleOrNothingSeller()));
				inline = true
			},
			{
				name = "\240\159\142\146 Fruits",
				value = tostring(V.fruits or 0),
				inline = true
			},
			{
				name = "\240\159\147\166 Inventory Value",
				value = "$" .. u.DoubleOrNothingSeller.FormatMoneyDoubleOrNothingSeller(V.inventoryValue);
				inline = true
			}
		}
		if Z then
			table.insert(J, {
				name = "\240\159\146\176 Cash Out";
				value = "$" .. u.DoubleOrNothingSeller.FormatMoneyDoubleOrNothingSeller(V.sellPrice or V.pot),
				inline = true
			})
			table.insert(J, {
				name = "\226\156\133 Sold Count";
				value = tostring(V.soldCount or V.fruits or 0),
				inline = true
			})
		else
			table.insert(J, {
				name = "\240\159\146\184 Lost Value";
				value = "$" .. u.DoubleOrNothingSeller.FormatMoneyDoubleOrNothingSeller(V.lostValue or V.inventoryValue),
				inline = true
			})
			table.insert(J, {
				name = "\240\159\148\129 Can Revive",
				value = V.canRevive and "Yes" or "No";
				inline = true
			})
		end
		return {
			username = "Exotic Hub";
			embeds = {
				{
					title = j,
					description = i,
					color = c;
					fields = J;
					footer = {
						text = tostring(y.AppName or "Exotic Hub") .. (" " .. tostring(y.CurentV or ""))
					},
					timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
				}
			}
		}
	end;
	SendWebhookDoubleOrNothingSeller = function(G, V)
		if not e.webhook_enabled then
			return false
		end
		if G == "win" and e.double_or_nothing_webhook_win ~= true then
			return false
		end
		if G == "loss" and e.double_or_nothing_webhook_loss ~= true then
			return false
		end
		if not u.Webhooks or type(u.Webhooks.Post) ~= "function" or type(u.Webhooks.IsValidUrl) ~= "function" or not u.Webhooks.IsValidUrl(e.webhook_url) then
			return false
		end
		local y = u.DoubleOrNothingSeller.BuildWebhookPayloadDoubleOrNothingSeller(G, V)
		task.spawn(function()
			local G, V = u.Webhooks.Post(y)
			if not G then
				warn("[DoubleOrNothingWebhook]", V)
			end
		end)
		return true
	end,
	ResetPendingDoubleOrNothingSeller = function()
		u.DoubleOrNothingSeller.PendingCashOutDoubleOrNothingSeller = false
		u.DoubleOrNothingSeller.PendingInfoDoubleOrNothingSeller = {}
	end;
	CashOutDoubleOrNothingSeller = function(G)
		G = type(G) == "table" and G or u.DoubleOrNothingSeller.PendingInfoDoubleOrNothingSeller
		u.DoubleOrNothingSeller.PendingCashOutDoubleOrNothingSeller = true
		u.DoubleOrNothingSeller.PendingInfoDoubleOrNothingSeller = G
		u.DoubleOrNothingSeller.SetStatusDoubleOrNothingSeller("Claiming streak " .. (tostring(G.streak or 0) .. "..."), "#66CCFF")
		local V, y = u.DoubleOrNothingSeller.FireRemoteDoubleOrNothingSeller("CashOutDoubleOrNothing")
		if V and (type(y) == "table" and y.Success == true) then
			local V = {
				target = G.target,
				streak = tonumber(y.Wins or G.streak) or 0;
				fruits = tonumber(G.fruits or y.SoldCount) or 0,
				soldCount = tonumber(y.SoldCount or G.fruits) or 0,
				inventoryValue = tonumber(G.inventoryValue) or 0,
				pot = tonumber(G.pot) or 0,
				sellPrice = tonumber(y.SellPrice or G.pot) or 0
			}
			u.DoubleOrNothingSeller.SetStatusDoubleOrNothingSeller(string.format("Won streak %d | +$%s", V.streak, u.DoubleOrNothingSeller.FormatMoneyDoubleOrNothingSeller(V.sellPrice)), "#7CFC00")
			u.DoubleOrNothingSeller.AddLogDoubleOrNothingSeller(string.format("WIN streak %d | +$%s | fruits %d", V.streak, u.DoubleOrNothingSeller.FormatMoneyDoubleOrNothingSeller(V.sellPrice), V.soldCount))
			u.DoubleOrNothingSeller.SendWebhookDoubleOrNothingSeller("win", V)
			u.DoubleOrNothingSeller.ResetPendingDoubleOrNothingSeller()
			task.wait(.35)
			return false, {
				type = "double_or_nothing_win",
				data = V;
				raw = y
			}
		end
		u.DoubleOrNothingSeller.SetStatusDoubleOrNothingSeller("Cash-out failed, retrying only. Normal sell blocked.", "#FFCC66")
		u.DoubleOrNothingSeller.AddLogDoubleOrNothingSeller("Cash-out retry needed | normal SellAll blocked")
		u.DoubleOrNothingSeller.RetryAtDoubleOrNothingSeller = os.clock() + 2
		return false, {
			type = "double_or_nothing_cashout_retry";
			data = G;
			raw = y
		}
	end,
	AbandonDoubleOrNothingSeller = function()
		u.DoubleOrNothingSeller.FireRemoteDoubleOrNothingSeller("AbandonDoubleOrNothing")
		u.DoubleOrNothingSeller.ResetPendingDoubleOrNothingSeller()
	end;
	RunDoubleOrNothingSeller = function(G, V)
		if u.DoubleOrNothingSeller.PendingCashOutDoubleOrNothingSeller then
			return u.DoubleOrNothingSeller.CashOutDoubleOrNothingSeller(u.DoubleOrNothingSeller.PendingInfoDoubleOrNothingSeller)
		end
		if e.auto_double_or_nothing ~= true then
			u.DoubleOrNothingSeller.SetStatusDoubleOrNothingSeller("")
			return false, "disabled"
		end
		if not T.GetCheckIfPro() then
			u.DoubleOrNothingSeller.SetStatusDoubleOrNothingSeller("Premium only", "#FF6666")
			return false, "not_pro"
		end
		if os.clock() < u.DoubleOrNothingSeller.RetryAtDoubleOrNothingSeller then
			return false, "retry_wait"
		end
		if not J.IsLoadingCompleted() then
			u.DoubleOrNothingSeller.SetStatusDoubleOrNothingSeller("Waiting for loading", "#FFCC66")
			return false, "loading"
		end
		G = math.max(math.floor(tonumber(G or u.PlayerData.GetFruitCount()) or 0), 0)
		if G <= 0 then
			u.DoubleOrNothingSeller.SetStatusDoubleOrNothingSeller("")
			return false, "no_fruits"
		end
		V = V == true or u.FruitCollect.IsMaxFruitInventory()
		if not V then
			u.DoubleOrNothingSeller.SetStatusDoubleOrNothingSeller(string.format("Waiting full inventory %d/%d", G, u.PlayerData.GetMaxFruitCapacity()), "#FFD966")
			return false, "waiting_full"
		end
		if ((tonumber(u.Money.GetSheckles()) or 0)) <= 0 then
			u.DoubleOrNothingSeller.SetStatusDoubleOrNothingSeller("Need sheckles first", "#FFCC66")
			return false, "no_sheckles"
		end
		local y = u.DoubleOrNothingSeller.PreviewDoubleOrNothingSeller(G)
		if y.fruitCount <= 0 then
			u.DoubleOrNothingSeller.SetStatusDoubleOrNothingSeller("No fruits to double", "#FFCC66")
			return false, "preview_empty"
		end
		local Z = u.DoubleOrNothingSeller.GetTargetDoubleOrNothingSeller()
		local j = u.DoubleOrNothingSeller.GetDelayDoubleOrNothingSeller()
		local i = 0
		local c = y.totalValue
		local d = {
			target = Z,
			streak = 0,
			fruits = y.fruitCount,
			inventoryValue = y.totalValue;
			pot = c
		}
		u.DoubleOrNothingSeller.SetStatusDoubleOrNothingSeller(string.format("Starting %d streak | %d fruits | $%s", Z, y.fruitCount, u.DoubleOrNothingSeller.FormatMoneyDoubleOrNothingSeller(y.totalValue)), "#66CCFF")
		for G = 1, Z, 1 do
			if e.auto_double_or_nothing ~= true then
				if i > 0 then
					u.DoubleOrNothingSeller.AbandonDoubleOrNothingSeller()
				end
				u.DoubleOrNothingSeller.SetStatusDoubleOrNothingSeller("Stopped", "#FFCC66")
				return false, "stopped"
			end
			local V, J = u.DoubleOrNothingSeller.FireRemoteDoubleOrNothingSeller("DoubleOrNothing")
			if not V then
				u.DoubleOrNothingSeller.SetStatusDoubleOrNothingSeller(tostring(J), "#FF6666")
				u.DoubleOrNothingSeller.RetryAtDoubleOrNothingSeller = os.clock() + 2
				return false, J
			end
			if type(J) == "table" and J.Busted == true then
				local G = {
					target = Z,
					streak = tonumber(J.Wins) or i,
					fruits = y.fruitCount;
					inventoryValue = tonumber(J.InventoryValue or y.totalValue) or 0,
					lostValue = tonumber(J.LostValue or J.InventoryValue or c) or 0;
					canRevive = J.CanRevive == true
				}
				u.DoubleOrNothingSeller.SetStatusDoubleOrNothingSeller(string.format("Lost at streak %d | -$%s", G.streak, u.DoubleOrNothingSeller.FormatMoneyDoubleOrNothingSeller(G.lostValue)), "#FF6666")
				u.DoubleOrNothingSeller.AddLogDoubleOrNothingSeller(string.format("LOSS streak %d | -$%s | fruits %d", G.streak, u.DoubleOrNothingSeller.FormatMoneyDoubleOrNothingSeller(G.lostValue), G.fruits))
				u.DoubleOrNothingSeller.SendWebhookDoubleOrNothingSeller("loss", G)
				u.DoubleOrNothingSeller.ResetPendingDoubleOrNothingSeller()
				task.wait(.35)
				return false, {
					type = "double_or_nothing_loss";
					data = G;
					raw = J
				}
			end
			if not ((type(J) == "table" and J.Won == true)) then
				local G = type(J) == "table" and tostring(J.Reason or "Rejected") or "Rejected"
				u.DoubleOrNothingSeller.SetStatusDoubleOrNothingSeller("Roll rejected: " .. G, "#FFCC66")
				u.DoubleOrNothingSeller.RetryAtDoubleOrNothingSeller = os.clock() + 2
				return false, {
					type = "double_or_nothing_rejected",
					reason = G;
					raw = J
				}
			end
			i = tonumber(J.Wins) or (i + 1)
			c = tonumber(J.Pot) or c
			d.streak = i
			d.pot = c
			u.DoubleOrNothingSeller.SetStatusDoubleOrNothingSeller(string.format("Won streak %d/%d | pot $%s", i, Z, u.DoubleOrNothingSeller.FormatMoneyDoubleOrNothingSeller(c)), "#7CFC00")
			u.DoubleOrNothingSeller.AddLogDoubleOrNothingSeller(string.format("Roll won %d/%d | pot $%s", i, Z, u.DoubleOrNothingSeller.FormatMoneyDoubleOrNothingSeller(c)))
			if i >= Z then
				return u.DoubleOrNothingSeller.CashOutDoubleOrNothingSeller(d)
			end
			task.wait(j)
		end
		return u.DoubleOrNothingSeller.CashOutDoubleOrNothingSeller(d)
	end;
	TryRunDoubleOrNothingSeller = function(G, V)
		if u.DoubleOrNothingSeller.BusyDoubleOrNothingSeller then
			return false, "busy"
		end
		u.DoubleOrNothingSeller.BusyDoubleOrNothingSeller = true
		local y, Z, j = pcall(u.DoubleOrNothingSeller.RunDoubleOrNothingSeller, G, V)
		u.DoubleOrNothingSeller.BusyDoubleOrNothingSeller = false
		if not y then
			u.DoubleOrNothingSeller.SetStatusDoubleOrNothingSeller("System error", "#FF6666")
			warn("[DoubleOrNothingSeller]", Z)
			return false, Z
		end
		return Z, j
	end;
	LoopDoubleOrNothingSeller = function()
		if e.auto_double_or_nothing ~= true and not u.DoubleOrNothingSeller.PendingCashOutDoubleOrNothingSeller then
			u.DoubleOrNothingSeller.SetStatusDoubleOrNothingSeller("")
			return false
		end
		return u.DoubleOrNothingSeller.TryRunDoubleOrNothingSeller(u.PlayerData.GetFruitCount(), u.FruitCollect.IsMaxFruitInventory())
	end
}
T.PetSellerStatusText = ""
T.PetSellerUi = T.PetSellerUi or {}
u.PetSeller = {
	Busy = false;
	NextRunAt = 0,
	RarityOrder = {
		"Common",
		"Uncommon",
		"Rare";
		"Epic";
		"Legendary",
		"Mythic";
		"Super",
		"Secret"
	},
	SetStatus = function(G, V)
		if type(G) ~= "string" or G == "" then
			T.PetSellerStatusText = ""
			return
		end
		T.PetSellerStatusText = string.format("<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\144\190 [Pet Seller]</font> <font color=\'%s\'>%s</font></stroke>", tostring(V or "#FFFFFF"), G)
	end,
	IsSelectionEmpty = function(G)
		if type(G) ~= "table" then
			return true
		end
		for G, V in pairs(G) do
			if V == true or type(G) == "number" and tostring(V or "") ~= "" then
				return false
			end
		end
		return true
	end;
	IsSelected = function(G, V)
		if type(G) ~= "table" then
			return false
		end
		V = tostring(V or "")
		if V == "" then
			return false
		end
		if G[V] == true then
			return true
		end
		for G, y in pairs(G) do
			if tostring(y or "") == V then
				return true
			end
		end
		return false
	end,
	PassesOptionalSelection = function(G, V)
		if u.PetSeller.IsSelectionEmpty(G) then
			return true
		end
		return u.PetSeller.IsSelected(G, V)
	end;
	GetDelay = function()
		return math.clamp(tonumber(e.pet_sell_delay) or .25, .15, 10)
	end,
	GetKeepAmount = function()
		return math.max(math.floor(tonumber(e.pet_sell_keep_amount) or 1), 0)
	end;
	GetMaxPerCycle = function()
		return math.clamp(math.floor(tonumber(e.pet_sell_max_per_cycle) or 3), 1, 100)
	end,
	GetMaxRarityRank = function()
		local G = tostring(e.pet_sell_max_rarity or "Rare")
		return T.RarityRank[G] or T.RarityRank.Rare or 3
	end;
	GetInventory = function()
		local G = u.DataReplica.GetData("Inventory")
		return type(G) == "table" and G or nil
	end,
	GetRawPets = function()
		local G = u.PetSeller.GetInventory()
		local V = G and G.Pets
		return type(V) == "table" and V or nil
	end,
	GetBaseData = function(G)
		if type(y.PetData) ~= "table" or type(G) ~= "string" or G == "" then
			return nil
		end
		return y.PetData[G]
	end;
	GetDisplayName = function(G, V)
		if type(V) == "table" and (type(V.DisplayName) == "string" and V.DisplayName ~= "") then
			return V.DisplayName
		end
		return tostring(G or "Unknown")
	end;
	GetRarity = function(G, V, y)
		if type(V) == "table" and (type(V.Rarity) == "string" and V.Rarity ~= "") then
			return V.Rarity
		end
		if type(y) == "table" and (type(y.Rarity) == "string" and y.Rarity ~= "") then
			return y.Rarity
		end
		return "Unknown"
	end;
	GetBasePrice = function(G)
		return math.max(tonumber(type(G) == "table" and G.BasePrice or 0) or 0, 0)
	end,
	GetEstimate = function(G)
		return math.floor(((tonumber(G) or 0)) * .5)
	end;
	GetSize = function(G)
		local V = type(G) == "table" and G.Size
		if V == "Big" or V == "Huge" then
			return V
		end
		return "Normal"
	end,
	GetVariant = function(G)
		local V = type(G) == "table" and G.Type
		if type(V) == "string" and V ~= "" then
			return V
		end
		return "Normal"
	end;
	GetBucketKey = function(G)
		if type(G) ~= "table" then
			return ""
		end
		return table.concat({
			tostring(G.name or "");
			tostring(G.size or "Normal"),
			tostring(G.variant or "Normal")
		}, "\031")
	end;
	BuildPetInfo = function(G, V)
		if type(V) ~= "table" then
			return nil
		end
		local y = V.Id or G
		y = type(y) == "string" and y or tostring(y or "")
		local Z = V.Name or V.PetName or V.Species
		Z = type(Z) == "string" and Z or tostring(Z or "")
		if y == "" or Z == "" then
			return nil
		end
		local j = u.PetSeller.GetBaseData(Z)
		local i = u.PetSeller.GetDisplayName(Z, j)
		local c = u.PetSeller.GetRarity(Z, j, V)
		local J = T.RarityRank[c] or 999
		local d = u.PetSeller.GetBasePrice(j)
		local q = u.PetSeller.GetSize(V)
		local g = u.PetSeller.GetVariant(V)
		local E = {
			key = tostring(G or y),
			id = y;
			name = Z;
			displayName = i;
			rarity = c;
			rarityRank = J,
			basePrice = d;
			estimate = u.PetSeller.GetEstimate(d);
			size = q,
			variant = g;
			equipped = V.Equipped == true,
			known = type(j) == "table",
			data = V
		}
		E.bucket = u.PetSeller.GetBucketKey(E)
		return E
	end,
	GetPets = function()
		local G = {}
		local V = u.PetSeller.GetRawPets()
		if type(V) ~= "table" then
			return G
		end
		for V, y in pairs(V) do
			local Z = u.PetSeller.BuildPetInfo(V, y)
			if Z then
				table.insert(G, Z)
			end
		end
		table.sort(G, function(G, V)
			if G.rarityRank ~= V.rarityRank then
				return G.rarityRank < V.rarityRank
			end
			if G.basePrice ~= V.basePrice then
				return G.basePrice < V.basePrice
			end
			if G.displayName ~= V.displayName then
				return G.displayName < V.displayName
			end
			return G.id < V.id
		end)
		return G
	end;
	FindLivePetInfo = function(G)
		G = tostring(G or "")
		if G == "" then
			return nil
		end
		local V = u.PetSeller.GetRawPets()
		if type(V) ~= "table" then
			return nil
		end
		for V, y in pairs(V) do
			if type(y) == "table" then
				local Z = tostring(y.Id or V or "")
				if Z == G or tostring(V or "") == G then
					return u.PetSeller.BuildPetInfo(V, y)
				end
			end
		end
		return nil
	end;
	IsProtectedPet = function(G)
		if type(G) ~= "table" then
			return true, "invalid"
		end
		if G.equipped then
			return true, "equipped"
		end
		if not G.known then
			return true, "unknown"
		end
		if u.PetSeller.IsSelected(e.pet_sell_protected_ids, G.id) or u.PetSeller.IsSelected(e.pet_sell_protected_ids, G.key) then
			return true, "protected id"
		end
		if u.PetSeller.IsSelected(e.pet_sell_protected, G.name) or u.PetSeller.IsSelected(e.pet_sell_protected, G.displayName) then
			return true, "protected name"
		end
		if e.pet_sell_protect_rainbow and G.variant == "Rainbow" then
			return true, "rainbow"
		end
		if e.pet_sell_protect_big_huge and ((G.size == "Big" or G.size == "Huge")) then
			return true, "big/huge"
		end
		if not u.PetSeller.PassesOptionalSelection(e.pet_sell_size_whitelist, G.size) then
			return true, "size"
		end
		if u.PetSeller.IsSelected(e.pet_sell_size_blacklist, G.size) then
			return true, "size protected"
		end
		if not u.PetSeller.PassesOptionalSelection(e.pet_sell_variant_whitelist, G.variant) then
			return true, "variant"
		end
		if u.PetSeller.IsSelected(e.pet_sell_variant_blacklist, G.variant) then
			return true, "variant protected"
		end
		if ((tonumber(G.rarityRank) or 999)) > u.PetSeller.GetMaxRarityRank() then
			return true, "rarity"
		end
		local V = tonumber(e.pet_sell_max_base_price) or 0
		if V > 0 and ((tonumber(G.basePrice) or 0)) > V then
			return true, "price"
		end
		return false, "safe"
	end,
	BuildPetCounts = function(G)
		local V = {}
		for G, y in ipairs(G or {}) do
			local Z = tostring(y.bucket or "")
			if Z ~= "" then
				V[Z] = ((V[Z] or 0)) + 1
			end
		end
		return V
	end,
	GetSellCandidates = function()
		local G = {
			candidates = {};
			total = 0;
			selected = 0;
			protected = 0;
			skipped = 0
		}
		if u.PetSeller.IsSelectionEmpty(e.pet_sell_selected) then
			return G
		end
		local V = u.PetSeller.GetPets()
		G.total = # V
		local y = u.PetSeller.BuildPetCounts(V)
		local Z = {}
		for V, y in ipairs(V) do
			if not u.PetSeller.IsSelected(e.pet_sell_selected, y.name) and not u.PetSeller.IsSelected(e.pet_sell_selected, y.displayName) then
				G.skipped += 1
				continue
			end
			G.selected += 1
			local j = u.PetSeller.IsProtectedPet(y)
			if j then
				G.protected += 1
				continue
			end
			Z[y.bucket] = Z[y.bucket] or {}
			table.insert(Z[y.bucket], y)
		end
		for V, Z in pairs(Z) do
			table.sort(Z, function(G, V)
				if G.rarityRank ~= V.rarityRank then
					return G.rarityRank < V.rarityRank
				end
				if G.basePrice ~= V.basePrice then
					return G.basePrice < V.basePrice
				end
				return G.id < V.id
			end)
			local j = # Z
			if e.pet_sell_duplicate_only then
				j = math.max(((tonumber(y[V]) or 0)) - u.PetSeller.GetKeepAmount(), 0)
			end
			j = math.min(j, # Z)
			for V = 1, j, 1 do
				table.insert(G.candidates, Z[V])
			end
		end
		table.sort(G.candidates, function(G, V)
			if G.rarityRank ~= V.rarityRank then
				return G.rarityRank < V.rarityRank
			end
			if G.basePrice ~= V.basePrice then
				return G.basePrice < V.basePrice
			end
			if G.displayName ~= V.displayName then
				return G.displayName < V.displayName
			end
			return G.id < V.id
		end)
		return G
	end,
	SellPet = function(G)
		G = tostring(G or "")
		if G == "" then
			return false, nil
		end
		local V = y.Networking and (y.Networking.NPCS and y.Networking.NPCS.SellPet)
		if not V or type(V.Fire) ~= "function" then
			return false, nil
		end
		return true, V:Fire(G)
	end;
	IsSellResultSuccess = function(G)
		if type(G) ~= "table" then
			return G == true
		end
		if G.Success == false then
			return false
		end
		return G.Success == true or G.SellPrice ~= nil
	end;
	GetSellPriceFromResult = function(G)
		if type(G) ~= "table" then
			return 0
		end
		return math.max(tonumber(G.SellPrice) or tonumber(G.Price) or 0, 0)
	end;
	RunPetSellerCycle = function(G)
		if not e.auto_sell_pets and not G then
			u.PetSeller.SetStatus("")
			return false
		end
		if u.PetSeller.Busy then
			return false
		end
		if not G and os.clock() < u.PetSeller.NextRunAt then
			return false
		end
		u.PetSeller.NextRunAt = os.clock() + 1
		if u.PetSeller.IsSelectionEmpty(e.pet_sell_selected) then
			u.PetSeller.SetStatus("Select pets first", "#FFCC66")
			u.PetSeller.NextRunAt = os.clock() + 2
			return false
		end
		local V = u.PetSeller.GetSellCandidates()
		local y = # V.candidates
		if y <= 0 then
			u.PetSeller.SetStatus(string.format("No safe pets | selected %d protected %d", V.selected, V.protected), "#FFCC66")
			u.PetSeller.NextRunAt = os.clock() + 2
			return false
		end
		if e.pet_sell_preview_only and not G then
			u.PetSeller.SetStatus(string.format("Preview: %d safe to sell | protected %d", y, V.protected), "#66CCFF")
			u.PetSeller.NextRunAt = os.clock() + 2
			return false
		end
		u.PetSeller.Busy = true
		local Z = 0
		local j = 0
		local i = 0
		local c = u.PetSeller.GetMaxPerCycle()
		for V = 1, c, 1 do
			if not e.auto_sell_pets and not G then
				break
			end
			local y = u.PetSeller.GetSellCandidates()
			local c = y.candidates[1]
			if not c then
				break
			end
			local J = u.PetSeller.FindLivePetInfo(c.id)
			local T = J and u.PetSeller.IsProtectedPet(J)
			if not J or T then
				j += 1
				break
			end
			u.PetSeller.SetStatus("Selling " .. (J.displayName .. "..."), "#66CCFF")
			local d, q = u.PetSeller.SellPet(J.id)
			if d and u.PetSeller.IsSellResultSuccess(q) then
				Z += 1
				i += u.PetSeller.GetSellPriceFromResult(q)
			else
				j += 1
			end
			task.wait(u.PetSeller.GetDelay())
		end
		u.PetSeller.Busy = false
		u.PetSeller.NextRunAt = os.clock() + math.max(u.PetSeller.GetDelay(), 1)
		if Z > 0 then
			u.PetSeller.SetStatus(string.format("Sold %d pet%s | +$%s", Z, Z == 1 and "" or "s", J.formatShecklesNumber(i)), "#66FF99")
			if T.PetSellerUi.RefreshPetDropdowns then
				task.defer(T.PetSellerUi.RefreshPetDropdowns)
			end
			return true, {
				sold = Z;
				failed = j,
				earned = i
			}
		end
		u.PetSeller.SetStatus(string.format("Pet sell failed | failed %d", j), "#FF6666")
		return false, {
			sold = 0;
			failed = j,
			earned = 0
		}
	end;
	GetPetNameDropdown = function()
		local G = {}
		local V = {}
		for G, y in ipairs(u.PetSeller.GetPets()) do
			local Z = V[y.name]
			if not Z then
				Z = {
					name = y.name,
					displayName = y.displayName;
					rarity = y.rarity,
					rarityRank = y.rarityRank,
					basePrice = y.basePrice,
					estimate = y.estimate;
					count = 0;
					equipped = 0
				}
				V[y.name] = Z
			end
			Z.count += 1
			if y.equipped then
				Z.equipped += 1
			end
		end
		for V, y in pairs(V) do
			local Z = u.Data.GetRarityColor(y.rarity)
			local j = y.equipped > 0 and string.format(" <font color=\'#FFD966\'>eq %d</font>", y.equipped) or ""
			table.insert(G, {
				Text = string.format("<font color=\"#FFFFFF\">%s</font> <font color=\"%s\">%s</font> <font color=\"#7CFC00\">x%d</font>%s <font color=\"#00FF00\">~$%s</font>", y.displayName, Z, y.rarity, y.count, j, J.formatShecklesNumber(y.estimate));
				Value = y.name
			})
		end
		table.sort(G, function(G, V)
			return tostring(G.Value) < tostring(V.Value)
		end)
		return G
	end,
	GetProtectedIdDropdown = function()
		local G = {}
		for V, y in ipairs(u.PetSeller.GetPets()) do
			local Z = u.Data.GetRarityColor(y.rarity)
			local j = y.id:sub(1, 8)
			local i = {}
			if y.equipped then
				table.insert(i, "Equipped")
			end
			if y.size ~= "Normal" then
				table.insert(i, y.size)
			end
			if y.variant ~= "Normal" then
				table.insert(i, y.variant)
			end
			local c = # i > 0 and " <font color=\'#FFD966\'>(" .. (table.concat(i, ", ") .. ")</font>") or ""
			table.insert(G, {
				Text = string.format("<font color=\"#FFFFFF\">%s</font> <font color=\"%s\">%s</font>%s <font color=\"#AAAAAA\">%s</font>", y.displayName, Z, y.rarity, c, j),
				Value = y.id
			})
		end
		return G
	end,
	GetSizeNames = function()
		local G = {
			"Normal",
			"Big",
			"Huge"
		}
		local V = {
			Normal = true;
			Big = true;
			Huge = true
		}
		for y, Z in ipairs(u.PetSeller.GetPets()) do
			if type(Z.size) == "string" and (Z.size ~= "" and not V[Z.size]) then
				V[Z.size] = true
				table.insert(G, Z.size)
			end
		end
		return G
	end;
	GetVariantNames = function()
		local G = {
			"Normal";
			"Rainbow"
		}
		local V = {
			Normal = true,
			Rainbow = true
		}
		for y, Z in ipairs(u.PetSeller.GetPets()) do
			if type(Z.variant) == "string" and (Z.variant ~= "" and not V[Z.variant]) then
				V[Z.variant] = true
				table.insert(G, Z.variant)
			end
		end
		return G
	end
}
task.spawn(function()
	while true do
		task.wait(.5)
		local G, V = pcall(u.PetSeller.RunPetSellerCycle)
		if not G then
			u.PetSeller.Busy = false
			u.PetSeller.SetStatus("Pet seller error", "#FF6666")
			warn("[PetSeller]", V)
			task.wait(1)
		end
	end
end)
u.FruitFiltersDataSync = {
	Started = false,
	Connections = {},
	Plants = {},
	Fruits = {},
	RemovedFruits = {},
	BaseWeightCache = {},
	SnapshotLoadedFruitFiltersDataSync = false,
	UseBaseDataMonitorFruitFiltersDataSync = true;
	FirstLoadStartedFruitFiltersDataSync = false;
	MonitorStartedFruitFiltersDataSync = false,
	DataStateFruitFiltersDataSync = "waiting",
	FirstLoadStartedAtFruitFiltersDataSync = 0;
	LastRequestGardenFruitFiltersDataSync = 0;
	LastGoodBaseDataFruitFiltersDataSync = 0;
	EmptyGardenGraceFruitFiltersDataSync = 15;
	is_debug = false;
	Now = function()
		return os.clock()
	end;
	WallNow = function()
		return os.time()
	end;
	N = function(G, V)
		local y = tonumber(G)
		if y == nil then
			return V or 0
		end
		return y
	end,
	Key = function(G, V)
		return tostring(G or "") .. ("\031" .. tostring(V or ""))
	end;
	IsMine = function(G)
		return tonumber(G) == tonumber(T.player_userid)
	end,
	CopyFields = function(G, V)
		if type(G) ~= "table" or type(V) ~= "table" then
			return V
		end
		for G, y in pairs(G) do
			if type(y) ~= "table" then
				V[G] = y
			elseif G == "Positions" then
				V[G] = {
					PosX = y.PosX;
					PosY = y.PosY,
					PosZ = y.PosZ;
					Rotation = y.Rotation
				}
			end
		end
		return V
	end;
	RoundWeight = function(G)
		G = tonumber(G) or 0
		return math.floor((G * 100) + .5) / 100
	end;
	GetGarden = function()
		local G = y.GardenSyncController
		if type(G) ~= "table" or type(G.GetGarden) ~= "function" then
			return nil
		end
		local V, Z = pcall(function()
			return G:GetGarden(T.player_userid)
		end)
		if V and type(Z) == "table" then
			return Z
		end
		return nil
	end;
	CountGardenPlantsFruitFiltersDataSync = function(G)
		local V = 0
		if type(G) ~= "table" then
			return 0
		end
		for G, y in pairs(G) do
			if type(y) == "table" then
				V += 1
			end
		end
		return V
	end,
	CountLocalPlantsFruitFiltersDataSync = function()
		local G = u.FruitFiltersDataSync
		local V = 0
		for G, y in pairs(G.Plants) do
			if type(y) == "table" and not y.Removed then
				V += 1
			end
		end
		return V
	end,
	CountWorkspacePlantsFruitFiltersDataSync = function()
		local G = u.Farm and (u.Farm.GetMyPlantsFolder and u.Farm.GetMyPlantsFolder())
		if not G or not G.Parent then
			return 0
		end
		return # G:GetChildren()
	end;
	RequestGardenDataFruitFiltersDataSync = function()
		local G = u.FruitFiltersDataSync
		if G.LastRequestGardenFruitFiltersDataSync > 0 and G.Now() - G.LastRequestGardenFruitFiltersDataSync < 3 then
			return false
		end
		local V = y.Networking and (y.Networking.Garden and y.Networking.Garden.RequestGardens)
		if not V then
			return false
		end
		G.LastRequestGardenFruitFiltersDataSync = G.Now()
		local Z = pcall(function()
			if type(V.Fire) == "function" then
				V:Fire()
			elseif type(V.FireServer) == "function" then
				V:FireServer()
			end
		end)
		return Z
	end,
	DebugFruitFiltersDataSync = function(G)
		local V = u.FruitFiltersDataSync
		if not V.is_debug then
			return false
		end
		local y = V.GetGarden()
		local Z = V.CountLocalPlantsFruitFiltersDataSync()
		local j = V.CountGardenPlantsFruitFiltersDataSync(y)
		local i = V.CountWorkspacePlantsFruitFiltersDataSync()
		local c = V.LastRequestGardenFruitFiltersDataSync > 0 and string.format("%.1f", V.Now() - V.LastRequestGardenFruitFiltersDataSync) or "never"
		local J = V.LastGoodBaseDataFruitFiltersDataSync > 0 and string.format("%.1f", V.Now() - V.LastGoodBaseDataFruitFiltersDataSync) or "never"
		warn(string.format("[FruitBaseDebug] %s | state=%s | snap=%s | local=%d | garden=%d | workspace=%d | reqAgo=%s | goodAgo=%s", tostring(G or "?"), tostring(V.DataStateFruitFiltersDataSync or "?"), tostring(V.SnapshotLoadedFruitFiltersDataSync == true), Z, j, i, c, J))
		return true
	end;
	GetWeightFormat = function()
		return type(y.WeightFormat) == "table" and y.WeightFormat or nil
	end;
	FormatKg = function(G)
		local V = u.FruitFiltersDataSync.GetWeightFormat()
		if type(V) == "table" and type(V.FormatGrams) == "function" then
			local y, Z = pcall(function()
				return V.FormatGrams(G)
			end)
			if y and type(Z) == "string" then
				return Z
			end
		end
		return string.format("%.2fkg", u.FruitFiltersDataSync.RoundWeight(G))
	end,
	GetBaseWeight = function(G, V)
		G = tostring(G or "")
		if G == "" then
			return nil
		end
		local Z = ((V and "P:" or "F:")) .. G
		local j = u.FruitFiltersDataSync.BaseWeightCache[Z]
		if j ~= nil then
			return j ~= false and j or nil
		end
		local i = V and y.PlantGenerationData or y.FruitGenerationData
		local c = type(i) == "table" and i[G] or nil
		if type(c) ~= "table" or type(c.GrowData) ~= "table" then
			u.FruitFiltersDataSync.BaseWeightCache[Z] = false
			return nil
		end
		local J = tonumber(c.GrowData.BaseWeight)
		if not J or J <= 0 then
			u.FruitFiltersDataSync.BaseWeightCache[Z] = false
			return nil
		end
		u.FruitFiltersDataSync.BaseWeightCache[Z] = J
		return J
	end;
	GetCalculateOvertimeGrowth = function()
		return type(y.CalculateOvertimeGrowth) == "function" and y.CalculateOvertimeGrowth or nil
	end;
	GetOvertimeFlags = function()
		return type(y.OvertimeGrowthFlags) == "table" and y.OvertimeGrowthFlags or nil
	end,
	IsOvertimeEnabled = function()
		local G = u.FruitFiltersDataSync.GetOvertimeFlags()
		if type(G) ~= "table" then
			return true
		end
		local V = G.Enabled
		if type(V) == "boolean" then
			return V
		end
		if type(V) == "table" and type(V.Get) == "function" then
			local G, y = pcall(function()
				return V:Get()
			end)
			if G then
				return y == true
			end
		end
		return true
	end;
	GetOvertimeForWeight = function(G, V)
		if not u.FruitFiltersDataSync.IsOvertimeEnabled() then
			return 1
		end
		if type(G) ~= "table" then
			return 1
		end
		local y = tonumber(G.OvertimeGrowth)
		if y and y > 0 then
			return math.clamp(y, 1, 100)
		end
		if V then
			local V = tonumber(G.FinishedGrowingAt) or 0
			local y = u.FruitFiltersDataSync.GetCalculateOvertimeGrowth()
			if V > 0 and type(y) == "function" then
				local G, Z = pcall(function()
					return y(os.time() - V)
				end)
				if G and tonumber(Z) then
					return math.clamp(math.max(tonumber(Z) or 1, 1), 1, 100)
				end
			end
		end
		return 1
	end,
	GetWeightData = function(G, V, y)
		if type(V) ~= "table" then
			return {
				weight = 0,
				grams = 0,
				text = "0.00kg";
				base = 0;
				size = 1,
				overtime = 1,
				hasWeight = false
			}
		end
		local Z = u.FruitFiltersDataSync.GetBaseWeight(G, y) or 0
		local j = tonumber(V.SizeMultiplier or V.SizeMulti) or 1
		local i = u.FruitFiltersDataSync.GetOvertimeForWeight(V, y)
		local c = (Z * j) * i
		return {
			weight = u.FruitFiltersDataSync.RoundWeight(c),
			grams = c;
			text = u.FruitFiltersDataSync.FormatKg(c);
			base = Z;
			size = j,
			overtime = i,
			hasWeight = c > 0
		}
	end,
	IsSingleHarvestPlant = function(G)
		G = tostring(G or "")
		if G == "" then
			return false
		end
		if type(y.PlantVisualizerController) == "table" and type(y.PlantVisualizerController.IsSingleHarvestPlant) == "function" then
			local V, Z = pcall(function()
				return y.PlantVisualizerController:IsSingleHarvestPlant(G)
			end)
			if V and type(Z) == "boolean" then
				return Z
			end
		end
		if type(y.SeedData) == "table" then
			local V = y.SeedData[G]
			if type(V) == "table" and V.IsSingleHarvest == true then
				return true
			end
		end
		if u.SeedData and type(u.SeedData.IsSingleHarvest) == "function" then
			return u.SeedData.IsSingleHarvest(G) == true
		end
		return T.SeedSingleHarvest and T.SeedSingleHarvest[G] == true
	end;
	MutationText = function(G)
		if type(G) ~= "string" then
			return ""
		end
		return G
	end,
	GetVariant = function(G, V)
		G = u.FruitFiltersDataSync.MutationText(G)
		if G:find("Rainbow", 1, true) then
			return "Rainbow"
		end
		if G:find("Gold", 1, true) then
			return "Gold"
		end
		V = tostring(V or "")
		if V == "Rainbow" or V == "Gold" then
			return V
		end
		return "Normal"
	end,
	GetPlantGrowthRate = function(G)
		if type(G) ~= "table" then
			return 0
		end
		local V = u.FruitFiltersDataSync.Now()
		local y = tonumber(G.BoostExpiresClock) or 0
		if y > 0 and V >= y then
			G.StableGrowthAmount = tonumber(G.PostBoostRate) or tonumber(G.StableGrowthAmount) or 0
			G.BoostExpiresClock = 0
		end
		return tonumber(G.StableGrowthAmount or G.GrowthRate or G.GrowRate) or 0
	end,
	EstimateStartingAge = function(G)
		if type(G) ~= "table" then
			return 0
		end
		local V = u.FruitFiltersDataSync.N(G.Age, 0)
		local y = u.FruitFiltersDataSync.N(G.MaxAge, 0)
		if y <= 0 then
			return V
		end
		local Z = u.FruitFiltersDataSync.N(G.FinishedGrowingAt, 0)
		local j = u.FruitFiltersDataSync.N(G.GrowRate or G.StableGrowthAmount or G.GrowthRate, 0)
		if Z > 0 then
			local G = u.FruitFiltersDataSync.WallNow()
			if G >= Z then
				return y
			end
			if j > 0 then
				V = math.max(V, y - (((Z - G)) * j))
			end
		end
		return math.clamp(V, 0, y)
	end,
	EnsurePlant = function(G, V)
		G = tostring(G or "")
		if G == "" then
			return nil
		end
		local y = u.FruitFiltersDataSync
		local Z = y.Plants[G]
		if not Z then
			Z = {
				Id = G,
				PlantId = G;
				Fruits = {},
				CurrentAge = 0;
				StableGrowthAmount = 0;
				LastClock = y.Now(),
				AddedAt = y.Now();
				LastUpdate = y.Now()
			}
			y.Plants[G] = Z
		end
		if type(V) == "table" then
			y.CopyFields(V, Z)
			local j = y.N(Z.CurrentAge, Z.Age or 0)
			local i = y.N(V.MaxAge, Z.MaxAge or 0)
			local c = y.EstimateStartingAge(V)
			Z.Id = G
			Z.PlantId = G
			Z.PlantName = V.PlantName or Z.PlantName
			Z.Mutation = V.Mutation or Z.Mutation
			Z.Variant = V.Variant or Z.Variant
			Z.CurrentAge = math.clamp(math.max(j, c), 0, i > 0 and i or math.huge)
			Z.Age = Z.CurrentAge
			Z.MaxAge = i
			Z.SizeMultiplier = y.N(V.SizeMultiplier, Z.SizeMultiplier or 1)
			Z.OvertimeGrowth = V.OvertimeGrowth or Z.OvertimeGrowth
			Z.FinishedGrowingAt = V.FinishedGrowingAt or Z.FinishedGrowingAt
			Z.LastClock = y.Now()
			Z.LastUpdate = y.Now()
			Z.Removed = false
		end
		return Z
	end,
	EnsureFruit = function(G, V, y, Z)
		G = tostring(G or "")
		V = tostring(V or "")
		if G == "" or V == "" then
			return nil
		end
		local j = u.FruitFiltersDataSync
		local i = j.EnsurePlant(G, y)
		if not i then
			return nil
		end
		local c = j.Key(G, V)
		local J = j.Fruits[c]
		if not J then
			J = {
				Key = c;
				PlantId = G,
				FruitId = V,
				CurrentAge = 0,
				GrowthRate = 0,
				MaxAge = 0,
				OvertimeGrowth = 1,
				LastClock = j.Now();
				AddedAt = j.Now();
				LastUpdate = j.Now()
			}
			j.Fruits[c] = J
			i.Fruits[V] = J
		end
		if type(Z) == "table" then
			j.CopyFields(Z, J)
			local G = j.N(J.CurrentAge, 0)
			local V = j.N(Z.MaxAge, J.MaxAge or 0)
			local y = j.EstimateStartingAge(Z)
			J.CurrentAge = math.clamp(math.max(G, y), 0, V > 0 and V or math.huge)
			J.GrowthRate = j.N(Z.GrowRate, J.GrowthRate or 0)
			J.MaxAge = V
			J.SizeMultiplier = j.N(Z.SizeMultiplier, J.SizeMultiplier or 1)
			J.OvertimeGrowth = j.N(Z.OvertimeGrowth, J.OvertimeGrowth or 1)
			J.Mutation = Z.Mutation or J.Mutation
			J.Seed = Z.Seed or J.Seed
			J.SpawnLocationIndex = Z.SpawnLocationIndex or J.SpawnLocationIndex
			J.FinishedGrowingAt = Z.FinishedGrowingAt or J.FinishedGrowingAt
			J.LastClock = j.Now()
			J.LastUpdate = j.Now()
			J.Removed = false
			j.RemovedFruits[c] = nil
		end
		return J
	end,
	AdvancePlant = function(G)
		if type(G) ~= "table" or G.Removed then
			return G
		end
		local V = u.FruitFiltersDataSync
		local y = V.N(G.MaxAge, 0)
		if y <= 0 then
			return G
		end
		local Z = V.N(G.CurrentAge, G.Age or 0)
		if Z >= y then
			G.CurrentAge = y
			G.Age = y
			G.LastClock = V.Now()
			return G
		end
		local j = V.N(G.FinishedGrowingAt, 0)
		if j > 0 and V.WallNow() >= j then
			G.CurrentAge = y
			G.Age = y
			G.LastClock = V.Now()
			return G
		end
		local i = V.Now()
		local c = math.max(i - V.N(G.LastClock, i), 0)
		local J = V.GetPlantGrowthRate(G)
		if c > 0 and J > 0 then
			Z = math.min(Z + (c * J), y)
			G.CurrentAge = Z
			G.Age = Z
			G.LastClock = i
		end
		return G
	end;
	AdvanceFruit = function(G)
		if type(G) ~= "table" or G.Removed then
			return G
		end
		local V = u.FruitFiltersDataSync
		local y = V.N(G.MaxAge, 0)
		if y <= 0 then
			return G
		end
		local Z = V.N(G.CurrentAge, 0)
		if Z >= y then
			G.CurrentAge = y
			G.LastClock = V.Now()
			return G
		end
		local j = V.N(G.FinishedGrowingAt, 0)
		if j > 0 and V.WallNow() >= j then
			G.CurrentAge = y
			G.LastClock = V.Now()
			return G
		end
		local i = V.Now()
		local c = math.max(i - V.N(G.LastClock, i), 0)
		local J = V.N(G.GrowthRate, 0)
		if c > 0 and J > 0 then
			Z = math.min(Z + (c * J), y)
			G.CurrentAge = Z
			G.LastClock = i
		end
		return G
	end;
	IsPlantReady = function(G)
		if type(G) ~= "table" or G.Removed then
			return false
		end
		local V = u.FruitFiltersDataSync
		V.AdvancePlant(G)
		local y = V.N(G.MaxAge, 0)
		return y > 0 and V.N(G.CurrentAge, G.Age or 0) >= y
	end,
	IsFruitReady = function(G)
		if type(G) ~= "table" or G.Removed then
			return false
		end
		local V = u.FruitFiltersDataSync
		V.AdvanceFruit(G)
		local y = V.N(G.MaxAge, 0)
		return y > 0 and V.N(G.CurrentAge, 0) >= y
	end;
	SyncFromGarden = function(G, V)
		local y = u.FruitFiltersDataSync
		if y.SnapshotLoadedFruitFiltersDataSync == true and G ~= true then
			return true
		end
		local Z = y.GetGarden()
		if type(Z) ~= "table" then
			y.DebugFruitFiltersDataSync("sync empty")
			return false
		end
		local j = y.CountGardenPlantsFruitFiltersDataSync(Z)
		if y.UseBaseDataMonitorFruitFiltersDataSync and (j <= 0 and V ~= true) then
			return false
		end
		for G, V in pairs(Z) do
			if type(V) ~= "table" then
				continue
			end
			G = tostring(G or "")
			if G == "" then
				continue
			end
			y.EnsurePlant(G, V)
			if type(V.Fruits) == "table" then
				for Z, j in pairs(V.Fruits) do
					if type(j) == "table" then
						Z = tostring(Z or "")
						if Z ~= "" then
							y.EnsureFruit(G, Z, V, j)
						end
					end
				end
			end
		end
		y.SnapshotLoadedFruitFiltersDataSync = true
		y.LastGoodBaseDataFruitFiltersDataSync = j > 0 and y.Now() or y.LastGoodBaseDataFruitFiltersDataSync
		y.DataStateFruitFiltersDataSync = j > 0 and "ready" or "empty_new_player"
		y.DebugFruitFiltersDataSync("sync success")
		return true
	end;
	BuildFruitResult = function(G, V, y)
		if type(G) ~= "table" then
			return nil
		end
		local Z = u.FruitFiltersDataSync
		local j = tostring(G.PlantName or "")
		local i = tostring(G.Id or G.PlantId or "")
		if j == "" or i == "" then
			return nil
		end
		local c = y and G or V
		if type(c) ~= "table" then
			return nil
		end
		if y then
			Z.AdvancePlant(G)
			if not Z.IsPlantReady(G) then
				return nil
			end
		else
			Z.AdvanceFruit(V)
			if not Z.IsFruitReady(V) then
				return nil
			end
		end
		local J = tostring(c.Mutation or G.Mutation or "")
		local d = Z.GetVariant(J, c.Variant or G.Variant)
		local q = T.SeedRarity[j] or "Common"
		local g = Z.GetWeightData(j, c, y)
		return {
			ob = nil;
			ob_plant = nil;
			name = j,
			plantId = i,
			fruitId = y and "" or tostring(V.FruitId or ""),
			w = g.weight,
			has_weight = g.hasWeight;
			r = q,
			m = J,
			v = d;
			kg = g.weight;
			kg_text = g.text,
			grams = g.grams,
			base_weight = g.base;
			size_multiplier = g.size,
			overtime_growth = g.overtime;
			age = y and Z.N(G.CurrentAge, G.Age or 0) or Z.N(V.CurrentAge, 0);
			max_age = y and Z.N(G.MaxAge, 0) or Z.N(V.MaxAge, 0),
			grow_rate = y and Z.GetPlantGrowthRate(G) or Z.N(V.GrowthRate, 0),
			ready = true,
			sync = true,
			single_harvest = y == true,
			sourceData = c
		}
	end,
	GetFruits = function()
		local G = u.FruitFiltersDataSync
		if not G.Started then
			G.StartSync()
		end
		local V = {}
		for y, Z in pairs(G.Plants) do
			if type(Z) ~= "table" or Z.Removed then
				continue
			end
			local j = tostring(Z.PlantName or "")
			if j == "" then
				continue
			end
			local i = G.IsSingleHarvestPlant(j)
			if i then
				local y = G.BuildFruitResult(Z, nil, true)
				if y and y.has_weight then
					table.insert(V, y)
				end
			else
				for y, j in pairs(Z.Fruits or {}) do
					if type(j) == "table" and not j.Removed then
						local y = G.BuildFruitResult(Z, j, false)
						if y and y.has_weight then
							table.insert(V, y)
						end
					end
				end
			end
		end
		table.sort(V, function(G, V)
			local y = T.RarityRank[G.r] or 0
			local Z = T.RarityRank[V.r] or 0
			if y ~= Z then
				return y > Z
			end
			local j = type(G.m) == "string" and G.m ~= ""
			local i = type(V.m) == "string" and V.m ~= ""
			if j ~= i then
				return j
			end
			return ((tonumber(G.w) or 0)) > ((tonumber(V.w) or 0))
		end)
		return V
	end,
	GetFruitsByName = function(G)
		G = tostring(G or "")
		if G == "" then
			return {}
		end
		local V = {}
		for y, Z in ipairs(u.FruitFiltersDataSync.GetFruits()) do
			if Z.name == G then
				table.insert(V, Z)
			end
		end
		return V
	end,
	StartBaseDataLoaderFruitFiltersDataSync = function()
		local G = u.FruitFiltersDataSync
		if G.FirstLoadStartedFruitFiltersDataSync or not G.UseBaseDataMonitorFruitFiltersDataSync then
			return false
		end
		G.FirstLoadStartedFruitFiltersDataSync = true
		G.FirstLoadStartedAtFruitFiltersDataSync = G.Now()
		G.DataStateFruitFiltersDataSync = "waiting"
		task.spawn(function()
			while G.Started and (G.UseBaseDataMonitorFruitFiltersDataSync and not T.is_forced_stop) do
				local V = G.CountLocalPlantsFruitFiltersDataSync()
				local y = G.GetGarden()
				local Z = G.CountGardenPlantsFruitFiltersDataSync(y)
				local j = G.CountWorkspacePlantsFruitFiltersDataSync()
				G.DebugFruitFiltersDataSync("loader")
				if V > 0 then
					G.DataStateFruitFiltersDataSync = "ready"
					break
				end
				if Z > 0 then
					G.SyncFromGarden(true, false)
					break
				end
				if j > 0 then
					G.DataStateFruitFiltersDataSync = "waiting_base_data"
					G.RequestGardenDataFruitFiltersDataSync()
				elseif G.Now() - G.FirstLoadStartedAtFruitFiltersDataSync >= G.EmptyGardenGraceFruitFiltersDataSync then
					G.SyncFromGarden(true, true)
					break
				else
					G.DataStateFruitFiltersDataSync = "waiting_empty_check"
					G.RequestGardenDataFruitFiltersDataSync()
				end
				task.wait(.5)
			end
		end)
		return true
	end;
	StartMonitorFruitFiltersDataSync = function()
		local G = u.FruitFiltersDataSync
		if G.MonitorStartedFruitFiltersDataSync or not G.UseBaseDataMonitorFruitFiltersDataSync then
			return false
		end
		G.MonitorStartedFruitFiltersDataSync = true
		task.spawn(function()
			while G.MonitorStartedFruitFiltersDataSync and (G.Started and (G.UseBaseDataMonitorFruitFiltersDataSync and not T.is_forced_stop)) do
				task.wait(10)
				local V = G.CountLocalPlantsFruitFiltersDataSync()
				local y = G.GetGarden()
				local Z = G.CountGardenPlantsFruitFiltersDataSync(y)
				local j = G.CountWorkspacePlantsFruitFiltersDataSync()
				G.DebugFruitFiltersDataSync("monitor")
				if Z > 0 and Z > V then
					G.SyncFromGarden(true, false)
				elseif V > 0 then
					G.DataStateFruitFiltersDataSync = "ready"
				elseif Z > 0 then
					G.SyncFromGarden(true, false)
				elseif j > 0 then
					G.DataStateFruitFiltersDataSync = "waiting_base_data"
					G.RequestGardenDataFruitFiltersDataSync()
				elseif G.SnapshotLoadedFruitFiltersDataSync ~= true then
					G.DataStateFruitFiltersDataSync = "empty_new_player"
					G.SyncFromGarden(true, true)
				end
			end
		end)
		return true
	end,
	ConnectGardenRemote = function(G, V)
		local Z = y.Networking and y.Networking.Garden
		local j = Z and Z[G]
		if not j or not j.OnClientEvent or type(V) ~= "function" then
			return false
		end
		local i, c = pcall(function()
			return j.OnClientEvent:Connect(V)
		end)
		if i and c then
			table.insert(u.FruitFiltersDataSync.Connections, c)
			return true
		end
		return false
	end;
	StartSync = function()
		local G = u.FruitFiltersDataSync
		if G.Started then
			return true
		end
		G.Started = true
		G.ConnectGardenRemote("PlantAdded", G.OnPlantAdded)
		G.ConnectGardenRemote("PlantRemoved", G.OnPlantRemoved)
		G.ConnectGardenRemote("PlantGrowthUpdated", G.OnPlantGrowthUpdated)
		G.ConnectGardenRemote("PlantAgeSync", G.OnPlantAgeSync)
		G.ConnectGardenRemote("PlantMutationUpdated", G.OnPlantMutationUpdated)
		G.ConnectGardenRemote("FruitAdded", G.OnFruitAdded)
		G.ConnectGardenRemote("FruitRemoved", G.OnFruitRemoved)
		G.ConnectGardenRemote("FruitGrowthUpdated", G.OnFruitGrowthUpdated)
		G.ConnectGardenRemote("FruitAgeSync", G.OnFruitAgeSync)
		G.ConnectGardenRemote("FruitOvertimeGrowthUpdated", G.OnFruitOvertimeGrowthUpdated)
		G.ConnectGardenRemote("FruitMutationUpdated", G.OnFruitMutationUpdated)
		if G.UseBaseDataMonitorFruitFiltersDataSync then
			G.RequestGardenDataFruitFiltersDataSync()
			G.StartBaseDataLoaderFruitFiltersDataSync()
			G.StartMonitorFruitFiltersDataSync()
		elseif G.SnapshotLoadedFruitFiltersDataSync ~= true then
			G.SyncFromGarden()
		end
		return true
	end,
	StopSync = function()
		local G = u.FruitFiltersDataSync
		G.Started = false
		for G, V in ipairs(G.Connections) do
			pcall(function()
				V:Disconnect()
			end)
		end
		table.clear(G.Connections)
		G.MonitorStartedFruitFiltersDataSync = false
		G.FirstLoadStartedFruitFiltersDataSync = false
		return true
	end,
	ResetSync = function()
		local G = u.FruitFiltersDataSync
		if G.Started then
			return false
		end
		table.clear(G.Plants)
		table.clear(G.Fruits)
		table.clear(G.RemovedFruits)
		G.SnapshotLoadedFruitFiltersDataSync = false
		G.FirstLoadStartedFruitFiltersDataSync = false
		G.MonitorStartedFruitFiltersDataSync = false
		G.DataStateFruitFiltersDataSync = "waiting"
		return true
	end,
	OnPlantAdded = function(G, V, y)
		local Z = u.FruitFiltersDataSync
		if not Z.IsMine(G) then
			return
		end
		Z.EnsurePlant(V, y)
		if type(y) == "table" and type(y.Fruits) == "table" then
			for G, j in pairs(y.Fruits) do
				Z.EnsureFruit(V, G, y, j)
			end
		end
	end;
	OnPlantRemoved = function(G, V)
		local y = u.FruitFiltersDataSync
		if not y.IsMine(G) then
			return
		end
		V = tostring(V or "")
		local Z = y.Plants[V]
		if Z then
			Z.Removed = true
			Z.RemovedAt = y.Now()
			for G, V in pairs(Z.Fruits or {}) do
				if type(V) == "table" then
					V.Removed = true
					V.RemovedAt = y.Now()
					y.RemovedFruits[V.Key] = true
				end
			end
		end
	end,
	OnPlantGrowthUpdated = function(G, V, y, Z, j, i, c)
		local J = u.FruitFiltersDataSync
		if not J.IsMine(G) then
			return
		end
		local T = J.EnsurePlant(V)
		if T then
			J.AdvancePlant(T)
			local G = J.N(T.MaxAge, 0)
			local V = J.N(y, 0)
			T.CurrentAge = G > 0 and math.min(math.max(V, T.CurrentAge or 0), G) or math.max(V, T.CurrentAge or 0)
			T.Age = T.CurrentAge
			T.StableGrowthAmount = J.N(Z, T.StableGrowthAmount or 0)
			local d = J.N(j, 0)
			T.BoostExpiresClock = d > 0 and (J.Now() + d) or 0
			T.PostBoostRate = J.N(i, T.StableGrowthAmount or 0)
			T.BoostSources = c or T.BoostSources
			T.LastClock = J.Now()
			T.LastUpdate = J.Now()
		end
	end;
	OnPlantAgeSync = function(G, V)
		local y = u.FruitFiltersDataSync
		if not y.IsMine(G) or type(V) ~= "table" then
			return
		end
		for G, V in pairs(V) do
			local Z = y.EnsurePlant(G)
			if Z then
				y.AdvancePlant(Z)
				local G = y.N(Z.MaxAge, 0)
				local j = y.N(V, 0)
				if G > 0 and (y.N(Z.CurrentAge, 0) >= G and j < G) then
					j = G
				end
				Z.CurrentAge = G > 0 and math.min(math.max(j, Z.CurrentAge or 0), G) or math.max(j, Z.CurrentAge or 0)
				Z.Age = Z.CurrentAge
				Z.LastClock = y.Now()
				Z.LastUpdate = y.Now()
			end
		end
	end,
	OnPlantMutationUpdated = function(G, V, y)
		local Z = u.FruitFiltersDataSync
		if not Z.IsMine(G) then
			return
		end
		local j = Z.EnsurePlant(V)
		if j then
			j.Mutation = y ~= "" and y or nil
			j.LastUpdate = Z.Now()
		end
	end;
	OnFruitAdded = function(G, V, y, Z)
		local j = u.FruitFiltersDataSync
		if not j.IsMine(G) then
			return
		end
		j.EnsureFruit(V, y, nil, Z)
	end;
	OnFruitRemoved = function(G, V, y)
		local Z = u.FruitFiltersDataSync
		if not Z.IsMine(G) then
			return
		end
		V = tostring(V or "")
		y = tostring(y or "")
		local j = Z.Key(V, y)
		local i = Z.Fruits[j]
		if i then
			i.Removed = true
			i.RemovedAt = Z.Now()
			Z.RemovedFruits[j] = true
		end
		local c = Z.Plants[V]
		if c and c.Fruits then
			c.Fruits[y] = nil
		end
	end,
	OnFruitGrowthUpdated = function(G, V, y, Z, j)
		local i = u.FruitFiltersDataSync
		if not i.IsMine(G) then
			return
		end
		local c = i.EnsureFruit(V, y)
		if not c then
			return
		end
		i.AdvanceFruit(c)
		local J = i.N(c.MaxAge, 0)
		local T = i.N(Z, 0)
		c.GrowthRate = i.N(j, c.GrowthRate or 0)
		c.CurrentAge = J > 0 and math.min(math.max(T, c.CurrentAge or 0), J) or math.max(T, c.CurrentAge or 0)
		c.LastClock = i.Now()
		c.LastUpdate = i.Now()
	end,
	OnFruitAgeSync = function(G, V, y)
		local Z = u.FruitFiltersDataSync
		if not Z.IsMine(G) or type(y) ~= "table" then
			return
		end
		for G, y in pairs(y) do
			local j = Z.EnsureFruit(V, G)
			if j then
				Z.AdvanceFruit(j)
				local G = Z.N(j.MaxAge, 0)
				local V = Z.N(y, 0)
				if G > 0 and (Z.N(j.CurrentAge, 0) >= G and V < G) then
					V = G
				end
				j.CurrentAge = G > 0 and math.min(math.max(V, j.CurrentAge or 0), G) or math.max(V, j.CurrentAge or 0)
				j.LastClock = Z.Now()
				j.LastUpdate = Z.Now()
			end
		end
	end;
	OnFruitOvertimeGrowthUpdated = function(G, V, y, Z)
		local j = u.FruitFiltersDataSync
		if not j.IsMine(G) then
			return
		end
		local i = j.EnsureFruit(V, y)
		if i then
			i.OvertimeGrowth = j.N(Z, i.OvertimeGrowth or 1)
			i.LastUpdate = j.Now()
		end
	end,
	OnFruitMutationUpdated = function(G, V, y, Z)
		local j = u.FruitFiltersDataSync
		if not j.IsMine(G) then
			return
		end
		local i = j.EnsureFruit(V, y)
		if i then
			i.Mutation = Z ~= "" and Z or nil
			i.LastUpdate = j.Now()
		end
	end
}
u.FruitFiltersDataSync.StartSync()
T.PlantFruitEspStatusText = ""
T.PlantFruitEspUi = T.PlantFruitEspUi or {}
u.PlantFruitEsp = {
	StartedPlantFruitEsp = false,
	GuiFolderPlantFruitEsp = nil;
	BillboardsPlantFruitEsp = {};
	LastScanPlantFruitEsp = 0,
	LastCountPlantFruitEsp = {
		plants = 0;
		fruits = 0
	};
	SetStatusPlantFruitEsp = function(G, V)
		G = tostring(G or "")
		V = tostring(V or "#FFFFFF")
		T.PlantFruitEspStatusText = G ~= "" and string.format("<font color=\'%s\'>%s</font>", V, G) or ""
		local y = T.PlantFruitEspUi
		if type(y) == "table" and (y.StatusLabel and type(y.StatusLabel.SetText) == "function") then
			y.StatusLabel:SetText(T.PlantFruitEspStatusText ~= "" and T.PlantFruitEspStatusText or "<font color=\'#888888\'>ESP idle</font>")
		end
	end;
	EnsureFolderPlantFruitEsp = function()
		if u.PlantFruitEsp.GuiFolderPlantFruitEsp and u.PlantFruitEsp.GuiFolderPlantFruitEsp.Parent then
			return u.PlantFruitEsp.GuiFolderPlantFruitEsp
		end
		local G = y.PlayerGui and y.PlayerGui:FindFirstChild("ExoPlantFruitEsp")
		if G then
			G:Destroy()
		end
		local V = Instance.new("Folder")
		V.Name = "ExoPlantFruitEsp"
		V.Parent = y.PlayerGui
		u.PlantFruitEsp.GuiFolderPlantFruitEsp = V
		return V
	end,
	IsAnyEnabledPlantFruitEsp = function()
		return e.plant_fruit_esp_fruit_enabled == true or e.plant_fruit_esp_plant_enabled == true
	end,
	EscapeRichTextPlantFruitEsp = function(G)
		G = tostring(G or "")
		G = G:gsub("&", "&amp;")
		G = G:gsub("<", "&lt;")
		G = G:gsub(">", "&gt;")
		return G
	end,
	IsSelectionEmptyPlantFruitEsp = function(G)
		if type(G) ~= "table" then
			return true
		end
		for G, V in pairs(G) do
			if type(G) == "number" and tostring(V or "") ~= "" then
				return false
			end
			if type(G) ~= "number" and (V ~= nil and (V ~= false and tostring(G or "") ~= "")) then
				return false
			end
		end
		return true
	end,
	IsSelectedPlantFruitEsp = function(G, V)
		V = tostring(V or "")
		if V == "" or type(G) ~= "table" then
			return false
		end
		if G[V] ~= nil and G[V] ~= false then
			return true
		end
		for G, y in pairs(G) do
			if type(G) == "number" and tostring(y or "") == V then
				return true
			end
			if tostring(G or "") == V and (y ~= nil and y ~= false) then
				return true
			end
		end
		return false
	end,
	PassesNamePlantFruitEsp = function(G)
		G = tostring(G or "")
		if G == "" then
			return false
		end
		if u.PlantFruitEsp.IsSelectionEmptyPlantFruitEsp(e.plant_fruit_esp_names) then
			return true
		end
		return u.PlantFruitEsp.IsSelectedPlantFruitEsp(e.plant_fruit_esp_names, G)
	end;
	GetAllNameSelectionPlantFruitEsp = function()
		local G = {}
		for V, y in ipairs(T.AllSeedsDataTable or {}) do
			local Z = type(y) == "table" and tostring(y.name or "") or ""
			if Z ~= "" then
				G[Z] = true
			end
		end
		return G
	end,
	PassesKgPlantFruitEsp = function(G)
		G = tonumber(G) or 0
		local V = math.max(tonumber(e.plant_fruit_esp_min_kg) or 0, 0)
		local y = tonumber(e.plant_fruit_esp_max_kg) or 1000000000
		if y < V then
			return false
		end
		return G >= V and G <= y
	end,
	FormatKgPlantFruitEsp = function(G)
		G = tonumber(G) or 0
		if type(u.FruitFiltersDataSync) == "table" and type(u.FruitFiltersDataSync.FormatKg) == "function" then
			local V, y = pcall(function()
				return u.FruitFiltersDataSync.FormatKg(G)
			end)
			if V and type(y) == "string" then
				return y
			end
		end
		return string.format("%.2fkg", math.floor((G * 100) + .5) / 100)
	end;
	GetSyncPlantPlantFruitEsp = function(G)
		G = tostring(G or "")
		local V = u.FruitFiltersDataSync
		if G == "" or type(V) ~= "table" or type(V.Plants) ~= "table" then
			return nil
		end
		if not V.Started and type(V.StartSync) == "function" then
			V.StartSync()
		end
		local y = V.Plants[G]
		return type(y) == "table" and y or nil
	end,
	GetSyncFruitPlantFruitEsp = function(G, V)
		V = tostring(V or "")
		if V == "" then
			return nil
		end
		local y = u.PlantFruitEsp.GetSyncPlantPlantFruitEsp(G)
		if type(y) ~= "table" or type(y.Fruits) ~= "table" then
			return nil
		end
		local Z = y.Fruits[V]
		return type(Z) == "table" and Z or nil
	end;
	GetKgPlantFruitEsp = function(G, V, Z, j, i)
		G = tostring(G or "")
		V = tostring(V or "")
		Z = tostring(Z or "")
		local c = i and u.PlantFruitEsp.GetSyncPlantPlantFruitEsp(V) or u.PlantFruitEsp.GetSyncFruitPlantFruitEsp(V, Z)
		if type(c) == "table" and (type(u.FruitFiltersDataSync) == "table" and type(u.FruitFiltersDataSync.GetWeightData) == "function") then
			local V, y = pcall(function()
				return u.FruitFiltersDataSync.GetWeightData(G, c, i == true)
			end)
			if V and type(y) == "table" then
				return tonumber(y.weight) or 0, tostring(y.text or u.PlantFruitEsp.FormatKgPlantFruitEsp(y.weight))
			end
		end
		if typeof(j) == "Instance" and type(y.FruitVisualizerController) == "table" then
			local G, V = pcall(function()
				if i and type(y.FruitVisualizerController.CalculatePlantWeight) == "function" then
					return y.FruitVisualizerController:CalculatePlantWeight(j)
				end
				if type(y.FruitVisualizerController.CalculateFruitWeight) == "function" then
					return y.FruitVisualizerController:CalculateFruitWeight(j)
				end
				return nil
			end)
			if G and tonumber(V) then
				local G = math.floor((((tonumber(V) or 0)) * 100) + .5) / 100
				return G, u.PlantFruitEsp.FormatKgPlantFruitEsp(G)
			end
		end
		return 0, "0.00kg"
	end,
	GetPlantLengthPlantFruitEsp = function(G)
		if typeof(G) ~= "Instance" then
			return 0
		end
		local V = tonumber(G:GetAttribute("Height") or G:GetAttribute("Length") or G:GetAttribute("PlantLength"))
		if not V then
			return 0
		end
		return math.max(math.floor(V + .5), 0)
	end,
	GetAdorneePlantFruitEsp = function(G)
		if typeof(G) ~= "Instance" then
			return nil
		end
		if G:IsA("BasePart") then
			return G
		end
		if G:IsA("Model") then
			local V = G:FindFirstChild("HarvestPart")
			if V and V:IsA("BasePart") then
				return V
			end
			if G.PrimaryPart then
				return G.PrimaryPart
			end
			return G:FindFirstChildWhichIsA("BasePart", true)
		end
		return nil
	end,
	GetOffsetPlantFruitEsp = function(G, V)
		if G == "plant" then
			return Vector3.new(0, math.clamp(((tonumber(V) or 0)) + 1.5, 2, 12), 0)
		end
		return Vector3.new(0, 1.35, 0)
	end,
	EnsureBillboardPlantFruitEsp = function(G, V, y)
		local Z = u.PlantFruitEsp.EnsureFolderPlantFruitEsp()
		local j = u.PlantFruitEsp.BillboardsPlantFruitEsp[G]
		if j and (j.Gui and (j.Gui.Parent and (j.Label and j.Label.Parent))) then
			return j
		end
		local i = Instance.new("BillboardGui")
		i.Name = "ExoPlantFruitEspBillboard"
		i.AlwaysOnTop = true
		i.LightInfluence = 0
		i.Size = UDim2.fromOffset(155, 38)
		i.MaxDistance = math.max(tonumber(e.plant_fruit_esp_max_distance) or 250, 25)
		i.Parent = Z
		local c = Instance.new("TextLabel")
		c.Name = "Text"
		c.BackgroundTransparency = 1
		c.BorderSizePixel = 0
		c.Font = Enum.Font.GothamSemibold
		c.RichText = true
		c.Size = UDim2.fromScale(1, 1)
		c.Text = ""
		c.TextColor3 = Color3.fromRGB(255, 255, 255)
		c.TextScaled = false
		c.TextSize = 12
		c.TextStrokeTransparency = 1
		c.TextWrapped = true
		c.TextXAlignment = Enum.TextXAlignment.Center
		c.TextYAlignment = Enum.TextYAlignment.Center
		c.Parent = i
		j = {
			Gui = i,
			Label = c,
			LastText = "",
			Seen = false
		}
		u.PlantFruitEsp.BillboardsPlantFruitEsp[G] = j
		return j
	end;
	UpdateBillboardPlantFruitEsp = function(G, V, y, Z)
		if typeof(G) ~= "Instance" or not G.Parent then
			return false
		end
		y = tostring(y or "")
		if y == "" then
			return false
		end
		local j = u.PlantFruitEsp.GetAdorneePlantFruitEsp(G)
		if not j then
			return false
		end
		local i = u.PlantFruitEsp.EnsureBillboardPlantFruitEsp(G, V, Z)
		i.Seen = true
		i.Gui.Adornee = j
		i.Gui.StudsOffsetWorldSpace = u.PlantFruitEsp.GetOffsetPlantFruitEsp(V, Z)
		i.Gui.MaxDistance = math.max(tonumber(e.plant_fruit_esp_max_distance) or 250, 25)
		if i.LastText ~= y then
			i.LastText = y
			i.Label.Text = y
		end
		return true
	end;
	RemoveBillboardPlantFruitEsp = function(G)
		local V = u.PlantFruitEsp.BillboardsPlantFruitEsp[G]
		if V and V.Gui then
			pcall(function()
				V.Gui:Destroy()
			end)
		end
		u.PlantFruitEsp.BillboardsPlantFruitEsp[G] = nil
	end,
	CleanupPlantFruitEsp = function(G)
		for V, y in pairs(u.PlantFruitEsp.BillboardsPlantFruitEsp) do
			if G == true or typeof(V) ~= "Instance" or not V.Parent or type(y) ~= "table" or y.Seen ~= true then
				u.PlantFruitEsp.RemoveBillboardPlantFruitEsp(V)
			elseif y then
				y.Seen = false
			end
		end
		if G == true and u.PlantFruitEsp.GuiFolderPlantFruitEsp then
			pcall(function()
				u.PlantFruitEsp.GuiFolderPlantFruitEsp:Destroy()
			end)
			u.PlantFruitEsp.GuiFolderPlantFruitEsp = nil
		end
	end,
	GetVariantColourPlantFruitEsp = function(G)
		G = tostring(G or "")
		if G == "Rainbow" then
			return "#FF55FF"
		end
		if G == "Gold" then
			return "#FFD700"
		end
		return "#CFCFCF"
	end,
	GetMutationInfoPlantFruitEsp = function(G, V, y)
		G = type(G) == "table" and G or {}
		y = type(y) == "table" and y or {}
		local Z = tostring(G.Mutation or y.Mutation or "")
		local j = G.Variant or y.Variant
		local i = u.FruitFiltersDataSync
		if typeof(V) == "Instance" then
			if Z == "" then
				Z = tostring(V:GetAttribute("Mutation") or V:GetAttribute("FruitMutation") or V:GetAttribute("PlantMutation") or "")
			end
			if j == nil or tostring(j or "") == "" then
				j = V:GetAttribute("Variant") or V:GetAttribute("FruitVariant") or V:GetAttribute("PlantVariant")
			end
		end
		if type(i) == "table" and type(i.MutationText) == "function" then
			local G, V = pcall(i.MutationText, Z)
			if G then
				Z = tostring(V or "")
			end
		end
		if type(i) == "table" and type(i.GetVariant) == "function" then
			local G, V = pcall(i.GetVariant, Z, j)
			if G then
				j = tostring(V or "Normal")
			end
		else
			j = tostring(j or "Normal")
			if j == "" then
				j = "Normal"
			end
		end
		return Z, j
	end;
	BuildTraitTextPlantFruitEsp = function(G, V)
		local y = {}
		G = tostring(G or "")
		V = tostring(V or "")
		if G ~= "" then
			table.insert(y, string.format("<font color=\'#FFB347\'>\226\156\168 %s</font>", u.PlantFruitEsp.EscapeRichTextPlantFruitEsp(G)))
		end
		if V ~= "" and V ~= "Normal" then
			table.insert(y, string.format("<font color=\'%s\'>\226\151\134 %s</font>", u.PlantFruitEsp.GetVariantColourPlantFruitEsp(V), u.PlantFruitEsp.EscapeRichTextPlantFruitEsp(V)))
		end
		return table.concat(y, " ")
	end,
	BuildPlantTextPlantFruitEsp = function(G, V, y, Z, j)
		local i = u.PlantFruitEsp.EscapeRichTextPlantFruitEsp(G)
		local c = u.PlantFruitEsp.BuildTraitTextPlantFruitEsp(Z, j)
		local J = {}
		if e.plant_fruit_esp_plant_enabled == true then
			table.insert(J, string.format("<font color=\'#7CFC00\'>\240\159\140\177 %s</font> <font color=\'#FFFFFF\'>%sft</font>", i, tostring(V or 0)))
			if c ~= "" then
				table.insert(J, c)
			end
		end
		if type(y) == "string" and y ~= "" then
			table.insert(J, string.format("<font color=\'#66CCFF\'>\240\159\141\137 %s</font>", u.PlantFruitEsp.EscapeRichTextPlantFruitEsp(y)))
		end
		if # J == 0 then
			return ""
		end
		return "<stroke color=\'#000000\' thickness=\'1\'>" .. (table.concat(J, "\n") .. "</stroke>")
	end;
	BuildFruitTextPlantFruitEsp = function(G, V, y, Z)
		local j = u.PlantFruitEsp.BuildTraitTextPlantFruitEsp(y, Z)
		local i = string.format("<font color=\'#FFFFFF\'>%s</font> <font color=\'#66CCFF\'>%s</font>", u.PlantFruitEsp.EscapeRichTextPlantFruitEsp(G), u.PlantFruitEsp.EscapeRichTextPlantFruitEsp(V))
		if j ~= "" then
			i = i .. ("\n" .. j)
		end
		return "<stroke color=\'#000000\' thickness=\'1\'>" .. (i .. "</stroke>")
	end,
	ScanPlantFruitEsp = function()
		local G = u.PlantFruitEsp
		local V = 0
		local y = 0
		if not G.IsAnyEnabledPlantFruitEsp() then
			G.CleanupPlantFruitEsp(true)
			G.SetStatusPlantFruitEsp("ESP disabled", "#888888")
			return false
		end
		local Z = u.Farm.GetPlants()
		local j = u.FruitFiltersDataSync
		if type(j) == "table" and (not j.Started and type(j.StartSync) == "function") then
			j.StartSync()
		end
		for Z, i in ipairs(Z) do
			if typeof(i) ~= "Instance" or not i.Parent then
				continue
			end
			local c = tostring(i:GetAttribute("SeedName") or i.Name or "")
			if c == "" then
				continue
			end
			local J = G.PassesNamePlantFruitEsp(c)
			local T = tostring(i:GetAttribute("PlantId") or "")
			local d = G.GetSyncPlantPlantFruitEsp(T)
			local q, g = G.GetMutationInfoPlantFruitEsp(d, i)
			local E = G.GetPlantLengthPlantFruitEsp(i)
			local a = type(j) == "table" and (type(j.IsSingleHarvestPlant) == "function" and j.IsSingleHarvestPlant(c) == true) or u.SeedData.IsSingleHarvest(c) == true
			local H = ""
			if e.plant_fruit_esp_fruit_enabled == true and a then
				local V, Z = G.GetKgPlantFruitEsp(c, T, "", i, true)
				if G.PassesKgPlantFruitEsp(V) then
					H = Z
					y += 1
				end
			end
			local r = J and G.BuildPlantTextPlantFruitEsp(c, E, H, q, g) or ""
			if r ~= "" then
				if G.UpdateBillboardPlantFruitEsp(i, "plant", r, E) then
					V += e.plant_fruit_esp_plant_enabled == true and 1 or 0
				end
			end
			if e.plant_fruit_esp_fruit_enabled == true and not a then
				local V = i:FindFirstChild("Fruits")
				if V then
					for V, Z in ipairs(V:GetChildren()) do
						if typeof(Z) ~= "Instance" or not Z.Parent then
							continue
						end
						local j = tostring(Z:GetAttribute("FruitId") or "")
						local i = tostring(Z:GetAttribute("CorePartName") or Z:GetAttribute("SeedName") or c)
						if not J and not G.PassesNamePlantFruitEsp(i) then
							continue
						end
						local u, q = G.GetKgPlantFruitEsp(c, T, j, Z, false)
						if not G.PassesKgPlantFruitEsp(u) then
							continue
						end
						local g = G.GetSyncFruitPlantFruitEsp(T, j)
						local E, a = G.GetMutationInfoPlantFruitEsp(g, Z, d)
						if G.UpdateBillboardPlantFruitEsp(Z, "fruit", G.BuildFruitTextPlantFruitEsp(i, q, E, a), 0) then
							y += 1
						end
					end
				end
			end
		end
		G.CleanupPlantFruitEsp(false)
		G.LastCountPlantFruitEsp = {
			plants = V;
			fruits = y
		}
		G.SetStatusPlantFruitEsp(string.format("Showing %d plants / %d fruits", V, y), "#7CFC00")
		return true
	end,
	StartPlantFruitEsp = function()
		local G = u.PlantFruitEsp
		if G.StartedPlantFruitEsp then
			return false
		end
		G.StartedPlantFruitEsp = true
		task.spawn(function()
			while G.StartedPlantFruitEsp and not T.is_forced_stop do
				local V, y = pcall(G.ScanPlantFruitEsp)
				if not V then
					G.SetStatusPlantFruitEsp("ESP error", "#FF6666")
					warn("[PlantFruitEsp]", y)
				end
				task.wait(.35)
			end
			G.CleanupPlantFruitEsp(true)
		end)
		return true
	end
}
u.PlantFruitEsp.StartPlantFruitEsp()
u.BuySelectFruit = {
	BusyBuySelectFruit = false;
	LastStatusBuySelectFruit = "";
	FruitStockEntriesBuySelectFruit = {},
	LastFruitStockRequestBuySelectFruit = 0,
	FruitStockLoadedBuySelectFruit = false,
	FruitStockSnapshotStartedBuySelectFruit = false,
	FruitStockSnapshotConnectionBuySelectFruit = nil;
	FruitStockLastSnapshotBuySelectFruit = 0;
	FruitStockNextRefreshBuySelectFruit = 0,
	SetStatusBuySelectFruit = function(G, V)
		G = tostring(G or "")
		V = tostring(V or "#FFFFFF")
		u.BuySelectFruit.LastStatusBuySelectFruit = G
		local y = T.BuySelectFruitUi
		if type(y) == "table" and (y.StatusLabel and type(y.StatusLabel.SetText) == "function") then
			y.StatusLabel:SetText(string.format("<font color=\'%s\'>%s</font>", V, G ~= "" and G or "Ready"))
		end
	end;
	GetSelectionKeysBuySelectFruit = function(G)
		local V = {}
		if type(G) ~= "table" then
			return V
		end
		for G, y in pairs(G) do
			if type(G) == "number" then
				local G = tostring(y or "")
				if G ~= "" then
					V[G] = true
				end
			elseif y ~= nil and y ~= false then
				local y = tostring(G or "")
				if y ~= "" then
					V[y] = true
				end
			end
		end
		return V
	end;
	FormatPriceBuySelectFruit = function(G)
		G = math.max(math.floor(tonumber(G) or 0), 0)
		if d and (d.Currency and type(d.Currency.FormatMoney) == "function") then
			return d.Currency.FormatMoney(G)
		end
		return tostring(G)
	end,
	ApplyFruitStockSnapshotBuySelectFruit = function(G)
		local V = u.BuySelectFruit
		if type(G) ~= "table" or type(G.entries) ~= "table" then
			return false
		end
		local y = {}
		for G, V in pairs(G.entries) do
			if type(G) == "string" and type(V) == "table" then
				y[G] = {
					multiplier = math.max(tonumber(V.multiplier) or 1, 0),
					tier = tostring(V.tier or "normal")
				}
			end
		end
		V.FruitStockEntriesBuySelectFruit = y
		V.FruitStockLoadedBuySelectFruit = true
		V.FruitStockLastSnapshotBuySelectFruit = tonumber(G.server_now_unix or G.lastRefreshUnix) or os.time()
		V.FruitStockNextRefreshBuySelectFruit = tonumber(G.nextRefreshUnix) or 0
		return true
	end;
	StartFruitStockSnapshotListenerBuySelectFruit = function()
		local G = u.BuySelectFruit
		if G.FruitStockSnapshotStartedBuySelectFruit then
			return true
		end
		local V = y.Networking and (y.Networking.FruitStock and y.Networking.FruitStock.Snapshot)
		if not V or not V.OnClientEvent then
			return false
		end
		G.FruitStockSnapshotStartedBuySelectFruit = true
		local Z, j = pcall(function()
			return V.OnClientEvent:Connect(function(G)
				u.BuySelectFruit.ApplyFruitStockSnapshotBuySelectFruit(G)
			end)
		end)
		if not Z then
			G.FruitStockSnapshotStartedBuySelectFruit = false
			return false
		end
		G.FruitStockSnapshotConnectionBuySelectFruit = j
		return true
	end;
	UpdateFruitStockBuySelectFruit = function(G)
		local V = u.BuySelectFruit
		V.StartFruitStockSnapshotListenerBuySelectFruit()
		if G ~= true and V.FruitStockLoadedBuySelectFruit == true then
			local G = tonumber(V.FruitStockNextRefreshBuySelectFruit) or 0
			if G <= 0 or os.time() <= G + 5 then
				return true
			end
		end
		local Z = os.clock()
		if G ~= true and (V.LastFruitStockRequestBuySelectFruit > 0 and Z - V.LastFruitStockRequestBuySelectFruit < 15) then
			return V.FruitStockLoadedBuySelectFruit == true
		end
		local j = y.Networking and (y.Networking.FruitStock and y.Networking.FruitStock.Request)
		if not j or type(j.Fire) ~= "function" then
			return false
		end
		V.LastFruitStockRequestBuySelectFruit = Z
		local i, c = pcall(function()
			return j:Fire()
		end)
		if not i then
			return false
		end
		return V.ApplyFruitStockSnapshotBuySelectFruit(c)
	end;
	EnsureFruitStockReadyBuySelectFruit = function(G)
		return u.BuySelectFruit.UpdateFruitStockBuySelectFruit(G == true)
	end,
	GetFruitStockEntryBuySelectFruit = function(G)
		G = tostring(G or "")
		if G == "" then
			return nil
		end
		local V = u.BuySelectFruit.FruitStockEntriesBuySelectFruit[G]
		if type(V) ~= "table" then
			return nil
		end
		return V
	end,
	GetSellFlagsPriceBuySelectFruit = function(G, V)
		V = tonumber(V) or 0
		if V <= 0 then
			return 0
		end
		if type(y.SellFlags) == "table" and type(y.SellFlags.Apply) == "function" then
			local Z, j = pcall(function()
				return y.SellFlags.Apply(G, V)
			end)
			if Z and tonumber(j) then
				return math.max(math.floor(tonumber(j) or 0), 0)
			end
		end
		return math.max(math.floor(V), 0)
	end,
	GetMutationMultiplierBuySelectFruit = function(G)
		G = tostring(G or "")
		if G == "" or type(y.MutationData) ~= "table" or type(y.MutationData.ReturnPriceMultiplier) ~= "function" then
			return 1
		end
		local V, Z = pcall(function()
			return y.MutationData.ReturnPriceMultiplier(G)
		end)
		return V and math.max(tonumber(Z) or 1, 0) or 1
	end;
	GetBaseEstimatedPriceBuySelectFruit = function(G, V, Z)
		G = tostring(G or "")
		V = type(V) == "table" and V or {}
		local j = tonumber(V.SizeMultiplier or V.SizeMulti) or 1
		local i = tostring(Z or "") ~= "" and tostring(Z) or nil
		local c = tonumber(V.DecayAlpha)
		if type(y.FruitValueCalc) == "function" then
			local V, Z = pcall(function()
				return y.FruitValueCalc(G, j, i, y.LocalPlayer, c)
			end)
			if V and tonumber(Z) then
				return math.max(math.floor(tonumber(Z) or 0), 0)
			end
		end
		local J = y.SellValueData
		local T = type(J) == "table" and tonumber(J[G]) or nil
		if not T or T <= 0 then
			return 0
		end
		local d = u.BuySelectFruit.GetMutationMultiplierBuySelectFruit(Z)
		return math.max(math.floor((T * (j ^ 3)) * d), 0)
	end;
	GetEstimatedPriceBuySelectFruit = function(G, V, y)
		G = tostring(G or "")
		local Z = u.BuySelectFruit.GetBaseEstimatedPriceBuySelectFruit(G, V, y)
		if Z <= 0 then
			return 0, 1, "none"
		end
		local j = u.BuySelectFruit.GetFruitStockEntryBuySelectFruit(G)
		if type(j) == "table" then
			local G = math.max(tonumber(j.multiplier) or 1, 0)
			return math.max(math.floor(Z * G), 0), G, tostring(j.tier or "normal")
		end
		local i = u.BuySelectFruit.GetSellFlagsPriceBuySelectFruit(G, Z)
		local c = Z > 0 and i / Z or 1
		return i, c, "flags"
	end,
	BuildFruitItemBuySelectFruit = function(G, V, y)
		if type(G) ~= "table" then
			return nil
		end
		local Z = u.FruitFiltersDataSync
		local j = tostring(G.PlantName or "")
		local i = tostring(G.Id or G.PlantId or "")
		local c = y and G or V
		if j == "" or i == "" or type(c) ~= "table" then
			return nil
		end
		local J = y and "" or tostring(c.FruitId or "")
		if not y and J == "" then
			return nil
		end
		if y and type(Z.AdvancePlant) == "function" then
			Z.AdvancePlant(G)
		elseif type(Z.AdvanceFruit) == "function" then
			Z.AdvanceFruit(c)
		end
		local d = false
		if y and type(Z.IsPlantReady) == "function" then
			d = Z.IsPlantReady(G) == true
		elseif type(Z.IsFruitReady) == "function" then
			d = Z.IsFruitReady(c) == true
		end
		local q = tostring(c.Mutation or G.Mutation or "")
		local g = type(Z.GetVariant) == "function" and Z.GetVariant(q, c.Variant or G.Variant) or "Normal"
		local E = type(Z.GetWeightData) == "function" and Z.GetWeightData(j, c, y) or {
			weight = 0;
			text = "0.00kg",
			size = tonumber(c.SizeMultiplier or c.SizeMulti) or 1
		}
		local a = i .. ("||" .. J)
		local H, r, Y = u.BuySelectFruit.GetEstimatedPriceBuySelectFruit(j, c, q)
		return {
			key = a;
			name = j;
			plantId = i,
			fruitId = J;
			kg = tonumber(E.weight) or 0,
			kgText = tostring(E.text or "0.00kg");
			price = H,
			priceMultiplier = tonumber(r) or 1;
			priceTier = tostring(Y or "normal"),
			mutation = q,
			variant = tostring(g or "Normal");
			ready = d,
			singleHarvest = y == true,
			rarity = T.SeedRarity[j] or "Common"
		}
	end;
	GetAllGardenFruitsBuySelectFruit = function(G)
		local V = {}
		local y = u.FruitFiltersDataSync
		if type(y) ~= "table" or type(y.Plants) ~= "table" then
			return V
		end
		u.BuySelectFruit.UpdateFruitStockBuySelectFruit(G == true)
		if not y.Started and type(y.StartSync) == "function" then
			y.StartSync()
		end
		if G == true and type(y.RequestGardenDataFruitFiltersDataSync) == "function" then
			y.RequestGardenDataFruitFiltersDataSync()
			task.wait(.2)
			if type(y.SyncFromGarden) == "function" then
				y.SyncFromGarden(true, true)
			end
		end
		for G, Z in pairs(y.Plants) do
			if type(Z) ~= "table" or Z.Removed then
				continue
			end
			local j = tostring(Z.PlantName or "")
			if j == "" then
				continue
			end
			local i = type(y.IsSingleHarvestPlant) == "function" and y.IsSingleHarvestPlant(j) == true or u.SeedData.IsSingleHarvest(j) == true
			if i then
				local G = u.BuySelectFruit.BuildFruitItemBuySelectFruit(Z, nil, true)
				if G then
					table.insert(V, G)
				end
			else
				for G, y in pairs(Z.Fruits or {}) do
					if type(y) == "table" and not y.Removed then
						local G = u.BuySelectFruit.BuildFruitItemBuySelectFruit(Z, y, false)
						if G then
							table.insert(V, G)
						end
					end
				end
			end
		end
		table.sort(V, function(G, V)
			if G.ready ~= V.ready then
				return G.ready == true
			end
			local y = T.RarityRank[tostring(G.rarity or "")] or 0
			local Z = T.RarityRank[tostring(V.rarity or "")] or 0
			if y ~= Z then
				return y > Z
			end
			if ((tonumber(G.price) or 0)) ~= ((tonumber(V.price) or 0)) then
				return ((tonumber(G.price) or 0)) > ((tonumber(V.price) or 0))
			end
			if ((tonumber(G.kg) or 0)) ~= ((tonumber(V.kg) or 0)) then
				return ((tonumber(G.kg) or 0)) > ((tonumber(V.kg) or 0))
			end
			return tostring(G.name or "") < tostring(V.name or "")
		end)
		return V
	end;
	GetDropdownValuesBuySelectFruit = function(G)
		local V = {}
		for G, y in ipairs(u.BuySelectFruit.GetAllGardenFruitsBuySelectFruit(G)) do
			local Z = y.ready and "\226\156\133" or "\240\159\149\146"
			local j = tostring(y.mutation or "") ~= "" and tostring(y.mutation) or "None"
			local i = u.Data.GetRarityColor(tostring(y.rarity or "Common"))
			local c = u.BuySelectFruit.FormatPriceBuySelectFruit(y.price)
			local J = tonumber(y.priceMultiplier) or 1
			local T = J ~= 1 and string.format(" x%s", tostring(math.floor(J * 100 + .5) / 100)) or ""
			table.insert(V, {
				Text = string.format("%s <font color=\"#FFFFFF\">%s</font> <font color=\"#66CCFF\">%s</font> <font color=\"#00FF00\">$%s%s</font> <font color=\"#FFCC66\">%s</font> <font color=\"#FF99FF\">%s</font> <font color=\"%s\">%s</font>", Z, y.name, y.kgText, c, T, y.variant, j, i, tostring(y.rarity or "Common"));
				Value = y.key
			})
		end
		return V
	end,
	RefreshDropdownBuySelectFruit = function(G, V, y)
		if not G or type(G.SetValues) ~= "function" then
			return false
		end
		local Z = u.BuySelectFruit.GetDropdownValuesBuySelectFruit(V == true)
		G:SetValues(Z)
		G:SetValue(T.BuySelectFruitSelected or {})
		if y ~= true then
			local G = u.BuySelectFruit.FruitStockLoadedBuySelectFruit and " | live prices" or ""
			u.BuySelectFruit.SetStatusBuySelectFruit(string.format("Loaded %d garden fruits%s", # Z, G), # Z > 0 and "#66CCFF" or "#FFCC66")
		end
		return true
	end;
	CollectSelectedBuySelectFruit = function(G)
		if u.BuySelectFruit.BusyBuySelectFruit then
			u.BuySelectFruit.SetStatusBuySelectFruit("Already collecting", "#FFCC66")
			return 0
		end
		local V = u.BuySelectFruit.GetSelectionKeysBuySelectFruit(G)
		if next(V) == nil then
			u.BuySelectFruit.SetStatusBuySelectFruit("Select at least 1 fruit", "#FFCC66")
			return 0
		end
		if not y.CollectFruitNet or type(y.CollectFruitNet.Fire) ~= "function" then
			u.BuySelectFruit.SetStatusBuySelectFruit("Collect remote unavailable", "#FF6666")
			return 0
		end
		u.BuySelectFruit.BusyBuySelectFruit = true
		local Z = 0
		local j = 0
		local i = 0
		local c = false
		local J = u.BuySelectFruit.GetAllGardenFruitsBuySelectFruit(true)
		local T = {}
		for G, V in ipairs(J) do
			T[V.key] = V
		end
		for G in pairs(V) do
			if u.FruitCollect.IsMaxFruitInventory() then
				c = true
				break
			end
			local V = T[G]
			if not V then
				i += 1
			elseif not V.ready then
				j += 1
			elseif u.FruitCollect.CollectFruit(V.plantId, V.fruitId) then
				Z += 1
				task.wait()
			end
		end
		u.FruitCollect.ResetBucket()
		u.BuySelectFruit.BusyBuySelectFruit = false
		local d = string.format("Collected %d", Z)
		if j > 0 then
			d ..= string.format(" | %d not ready", j)
		end
		if i > 0 then
			d ..= string.format(" | %d gone", i)
		end
		if c then
			d ..= " | inventory full"
		end
		u.BuySelectFruit.SetStatusBuySelectFruit(d, Z > 0 and "#7CFC00" or "#FFCC66")
		return Z
	end
}
u.FruitFilters = {
	RoundWeight = function(G)
		local V = tonumber(G)
		if not V then
			return 0
		end
		return math.round(V * 100) / 100
	end,
	IsSelectionEmpty = function(G)
		if type(G) ~= "table" then
			return true
		end
		for G, V in pairs(G) do
			if V ~= nil and (V ~= false and tostring(V) ~= "") then
				return false
			end
		end
		return true
	end,
	IsSelected = function(G, V)
		V = tostring(V or "")
		if V == "" or type(G) ~= "table" then
			return false
		end
		if G[V] ~= nil and G[V] ~= false then
			return true
		end
		for G, y in pairs(G) do
			if type(G) == "number" and tostring(y or "") == V then
				return true
			end
			if tostring(G or "") == V and (y ~= nil and y ~= false) then
				return true
			end
		end
		return false
	end,
	ParseMutationText = function(G)
		local V = {}
		local y = {}
		if type(G) ~= "string" or G == "" then
			return V, y
		end
		for G in G:gmatch("[^%+%,|/;]+") do
			G = G:match("^%s*(.-)%s*$")
			if G and (G ~= "" and not y[G]) then
				y[G] = true
				table.insert(V, G)
			end
		end
		return V, y
	end,
	SplitMutations = function(G)
		return u.FruitFilters.ParseMutationText(G)
	end,
	GetRawMutation = function(G)
		if type(G) ~= "table" then
			return ""
		end
		local V = G.ob
		local y = nil
		if typeof(V) == "Instance" then
			y = V:GetAttribute("Mutation")
		end
		if type(y) ~= "string" then
			y = G.m or G.Mutation or G.mutation
		end
		return type(y) == "string" and y or ""
	end;
	GetMutationLookup = function(G)
		local V = u.FruitFilters.GetRawMutation(G)
		local y, Z = u.FruitFilters.ParseMutationText(V)
		return y, Z, V
	end;
	GetVariantFromMutations = function(G)
		if type(G) ~= "table" then
			return "Normal"
		end
		if G.Rainbow then
			return "Rainbow"
		end
		if G.Gold then
			return "Gold"
		end
		return "Normal"
	end;
	IsKnownVariant = function(G)
		G = tostring(G or "")
		return G == "Normal" or G == "Gold" or G == "Rainbow"
	end;
	GetFruitVariant = function(G, V)
		if type(G) ~= "table" then
			return "Normal"
		end
		local y = G.ob
		if typeof(y) == "Instance" then
			local G = {
				"Variant";
				"FruitVariant",
				"Type"
			}
			for G, V in ipairs(G) do
				local Z = y:GetAttribute(V)
				if type(Z) == "string" and u.FruitFilters.IsKnownVariant(Z) then
					return Z
				end
			end
		end
		local Z = G.v or G.Variant or G.variant
		if type(Z) == "string" and u.FruitFilters.IsKnownVariant(Z) then
			return Z
		end
		return u.FruitFilters.GetVariantFromMutations(V)
	end;
	HasSelectedMutation = function(G, V)
		if type(G) ~= "table" or type(V) ~= "table" then
			return false
		end
		for V in pairs(V) do
			if u.FruitFilters.IsSelected(G, V) then
				return true
			end
		end
		return false
	end,
	PassesMutationSelection = function(G, V, y)
		G = type(G) == "table" and G or {}
		if not u.FruitFilters.IsSelectionEmpty(y) then
			if u.FruitFilters.HasSelectedMutation(y, G) then
				return false
			end
		end
		if not u.FruitFilters.IsSelectionEmpty(V) then
			return u.FruitFilters.HasSelectedMutation(V, G)
		end
		return true
	end,
	PassesVariantSelection = function(G, V, y)
		G = tostring(G or "Normal")
		if not u.FruitFilters.IsSelectionEmpty(y) then
			if u.FruitFilters.IsSelected(y, G) then
				return false
			end
		end
		if not u.FruitFilters.IsSelectionEmpty(V) then
			return u.FruitFilters.IsSelected(V, G)
		end
		return true
	end,
	PassesWeightRange = function(G, V, y)
		G = tonumber(G) or 0
		V = tonumber(V) or 0
		y = tonumber(y) or 1000000000
		if V < 0 then
			V = 0
		end
		if y < V then
			return false
		end
		return G >= V and G <= y
	end;
	GetMutationNames = function()
		local G = {}
		local V = {}
		local Z = y.MutationDataModule
		if Z then
			for y, Z in ipairs(Z:GetChildren()) do
				if not Z:IsA("ModuleScript") then
					continue
				end
				local j = Z.Name
				if j ~= "" and (j ~= "Gold" and (j ~= "Rainbow" and not V[j])) then
					V[j] = true
					table.insert(G, j)
				end
			end
		end
		if # G == 0 then
			G = {
				"Bloodlit";
				"Chained",
				"Electric";
				"Frozen";
				"Pizza";
				"Solarflare",
				"Starstruck"
			}
		end
		table.sort(G)
		return G
	end;
	GetVariantNames = function()
		return {
			"Normal",
			"Gold";
			"Rainbow"
		}
	end,
	GetFruitIds = function(G)
		if type(G) ~= "table" then
			return nil, nil
		end
		return G.plantId, G.fruitId
	end,
	IsFruitReady = function(G)
		if typeof(G) ~= "Instance" then
			return false
		end
		local V = tonumber(G:GetAttribute("Age"))
		local y = tonumber(G:GetAttribute("MaxAge"))
		return V ~= nil and (y ~= nil and (y > 0 and V >= y))
	end,
	GetFruitWeight = function(G)
		if not G or type(y.FruitVisualizerController) ~= "table" then
			return 0, 0
		end
		local V, Z = pcall(function()
			if type(y.FruitVisualizerController.CalculateFruitWeight) == "function" then
				return y.FruitVisualizerController:CalculateFruitWeight(G)
			end
			return nil
		end)
		if not V or type(Z) ~= "number" then
			V, Z = pcall(function()
				if type(y.FruitVisualizerController.CalculatePlantWeight) == "function" then
					return y.FruitVisualizerController:CalculatePlantWeight(G)
				end
				return nil
			end)
		end
		if not V or type(Z) ~= "number" then
			return 0, 0
		end
		local j = u.FruitFilters.RoundWeight(Z)
		return j, Z
	end,
	GetFruitWeightFromSync = function(G, V)
		if type(V) ~= "table" then
			return 0
		end
		local y = tonumber(V.Weight or V.weight or V.BaseWeight or V.baseWeight)
		if y then
			return u.FruitFilters.RoundWeight(y)
		end
		return 0
	end,
	BuildFruitData = function(G, V, y, Z, j, i)
		y = tostring(y or "")
		Z = tostring(Z or "")
		j = tostring(j or "")
		if y == "" or Z == "" then
			return nil
		end
		local c = 0
		local J = false
		if typeof(G) == "Instance" then
			c = u.FruitFilters.GetFruitWeight(G)
			J = tonumber(c) ~= nil and tonumber(c) > 0
		elseif type(i) == "table" then
			c = u.FruitFilters.GetFruitWeightFromSync(y, i)
			J = tonumber(c) ~= nil and tonumber(c) > 0
		end
		local d = ""
		if typeof(G) == "Instance" then
			d = G:GetAttribute("Mutation") or ""
		end
		if d == "" and type(i) == "table" then
			d = i.Mutation or i.mutation or ""
		end
		local q, g = u.FruitFilters.ParseMutationText(d)
		local E = u.FruitFilters.GetFruitVariant({
			ob = G,
			m = d
		}, g)
		local a = T.SeedRarity[y] or "Common"
		local H = type(i) == "table" and i or nil
		if type(H) ~= "table" then
			H = {
				SizeMultiplier = typeof(G) == "Instance" and ((G:GetAttribute("SizeMultiplier") or G:GetAttribute("SizeMulti"))) or nil,
				Mutation = d;
				DecayAlpha = typeof(G) == "Instance" and G:GetAttribute("DecayAlpha") or nil
			}
		end
		return {
			ob = G,
			ob_plant = V;
			name = y,
			plantId = Z;
			fruitId = j,
			w = c,
			has_weight = J;
			r = a,
			m = d;
			v = E;
			sourceData = H
		}
	end,
	GetAllFruits = function()
		local G = {}
		for V, y in ipairs(u.Farm.GetPlants()) do
			local Z = y:GetAttribute("PlantId")
			local j = y:FindFirstChild("Fruits")
			local i = y:GetAttribute("SeedName") or ""
			if j then
				for V, j in ipairs(j:GetChildren()) do
					local c = j:GetAttribute("CorePartName") or j:GetAttribute("SeedName") or i
					local J = j:GetAttribute("FruitId")
					local T = u.FruitFilters.BuildFruitData(j, y, c, Z, J, nil)
					if T then
						table.insert(G, T)
					end
				end
			else
				local V = tonumber(y:GetAttribute("Age") or 0)
				local j = tonumber(y:GetAttribute("MaxAge") or 0)
				if j > 0 and V >= j then
					local V = u.FruitFilters.BuildFruitData(y, y, i, Z, "", nil)
					if V then
						table.insert(G, V)
					end
				end
			end
		end
		table.sort(G, function(G, V)
			local y = T.RarityRank[G.r] or 0
			local Z = T.RarityRank[V.r] or 0
			if y ~= Z then
				return y > Z
			end
			local j = type(G.m) == "string" and G.m ~= ""
			local i = type(V.m) == "string" and V.m ~= ""
			if j ~= i then
				return j
			end
			return ((tonumber(G.w) or 0)) > ((tonumber(V.w) or 0))
		end)
		return G
	end;
	GetFruitsUsingName = function(G)
		local V = {}
		if type(G) ~= "string" or G == "" then
			return V
		end
		for y, Z in ipairs(u.FruitFilters.GetAllFruits()) do
			if Z.name == G then
				table.insert(V, Z)
			end
		end
		return V
	end,
	PassesCollectorFilters = function(G)
		if type(G) ~= "table" then
			return false
		end
		local V = tostring(G.name or "")
		if V == "" then
			return false
		end
		if not u.FruitFilters.IsSelectionEmpty(e.collect_fruit_list) then
			if not u.FruitFilters.IsSelected(e.collect_fruit_list, V) then
				return false
			end
		end
		if G.has_weight == false or ((tonumber(G.w) or 0)) <= 0 then
			return false
		end
		if not u.FruitFilters.PassesWeightRange(G.w, e.collect_min_weight, e.collect_max_weight) then
			return false
		end
		local y, Z = u.FruitFilters.GetMutationLookup(G)
		if not u.FruitFilters.PassesMutationSelection(Z, e.collect_mutation_whitelist, e.collect_mutation_blacklist) then
			return false
		end
		local j = u.FruitFilters.GetFruitVariant(G, Z)
		if not u.FruitFilters.PassesVariantSelection(j, e.collect_variant_whitelist, e.collect_variant_blacklist) then
			return false
		end
		return true
	end,
	GetReadyFruits = function(G, V)
		local y = {}
		local Z
		if type(G) == "string" and G ~= "" then
			Z = u.FruitFilters.GetFruitsUsingName(G)
		else
			Z = u.FruitFilters.GetAllFruits()
		end
		for G, Z in ipairs(Z) do
			if not u.FruitFilters.IsFruitReady(Z.ob) then
				continue
			end
			if V and not u.FruitFilters.PassesCollectorFilters(Z) then
				continue
			end
			table.insert(y, Z)
		end
		return y
	end,
	GetFarmFruitCounts = function()
		local G = {}
		local V = u.FruitFiltersDataSync
		if not V or type(V.Plants) ~= "table" then
			return G
		end
		if not V.Started and type(V.StartSync) == "function" then
			V.StartSync()
		end
		local function y(V, y)
			V = tostring(V or "")
			if V == "" then
				return
			end
			if not G[V] then
				G[V] = {
					total = 0;
					ready = 0
				}
			end
			G[V].total += 1
			if y then
				G[V].ready += 1
			end
		end
		for G, Z in pairs(V.Plants) do
			if type(Z) ~= "table" or Z.Removed then
				continue
			end
			local j = tostring(Z.PlantName or "")
			if j == "" then
				continue
			end
			local i = false
			if type(V.IsSingleHarvestPlant) == "function" then
				i = V.IsSingleHarvestPlant(j) == true
			else
				i = u.SeedData.IsSingleHarvest(j) == true
			end
			if i then
				y(j, type(V.IsPlantReady) == "function" and V.IsPlantReady(Z) == true)
			else
				for G, Z in pairs(Z.Fruits or {}) do
					if type(Z) == "table" and not Z.Removed then
						y(j, type(V.IsFruitReady) == "function" and V.IsFruitReady(Z) == true)
					end
				end
			end
		end
		return G
	end,
	GetFruitTypeDropdownWithFarmCounts = function()
		local G = {}
		local V = u.FruitFilters.GetFarmFruitCounts()
		for y, Z in ipairs(T.AllSeedsDataTable) do
			if type(Z) ~= "table" then
				continue
			end
			local j = tostring(Z.name or "")
			if j == "" then
				continue
			end
			local i = tostring(Z.rarity or "Common")
			local c = u.Data.GetRarityColor(i)
			local J = V[j] or {
				total = 0;
				ready = 0
			}
			table.insert(G, {
				Text = string.format("<font color=\"#FFFFFF\">%s</font> <font color=\"%s\">%s</font> <font color=\"#7CFC00\">x%d Rdy</font> <font color=\"#BBBBBB\">/%d</font>", j, c, i, tonumber(J.ready) or 0, tonumber(J.total) or 0);
				Value = j
			})
		end
		return G
	end
}
u.ShovelTool = {
	GetTool = function()
		local G = u.Player.GetTool_Holding()
		if G and G:IsA("Tool") then
			local V = G:GetAttribute("Shovel")
			if type(V) == "string" and V ~= "" then
				return G
			end
		end
		local V = y.LocalPlayer and y.LocalPlayer:FindFirstChild("Backpack")
		if not V then
			return nil
		end
		for G, V in ipairs(V:GetChildren()) do
			if not V:IsA("Tool") then
				continue
			end
			local y = V:GetAttribute("Shovel")
			if type(y) == "string" and y ~= "" then
				return V
			end
		end
		return nil
	end,
	Equip = function()
		local G = u.ShovelTool.GetTool()
		if not G then
			return nil, false
		end
		if u.Player.IsToolHeld(G) then
			return G, false
		end
		if not u.Player.EquipTool(G) then
			return nil, false
		end
		task.wait(.15)
		if not u.Player.IsToolHeld(G) then
			return nil, false
		end
		return G, true
	end;
	Use = function(G, V, Z)
		if type(G) ~= "string" or G == "" then
			return false
		end
		if type(V) ~= "string" then
			return false
		end
		if not Z or not Z:IsA("Tool") then
			return false
		end
		if not y.Character or Z.Parent ~= y.Character then
			return false
		end
		local j = Z:GetAttribute("Shovel")
		if type(j) ~= "string" or j == "" then
			return false
		end
		local i = y.Networking and (y.Networking.Shovel and y.Networking.Shovel.UseShovel)
		if not i or type(i.Fire) ~= "function" then
			return false
		end
		local c = pcall(function()
			i:Fire(G, V, j, Z)
		end)
		return c
	end;
	Cleanup = function(G)
		if not G then
			return
		end
		u.Player.UnequipTools()
	end
}
T.ShovelStatusText = ""
u.ShovelFruits = {
	MaxPerLoop = 60;
	RequestDelay = .1,
	EquippedBySystem = false,
	TotalRemoved = 0,
	LastLoopRemoved = 0,
	SetStatus = function(G, V)
		G = tostring(G or "Waiting")
		V = tostring(V or "#FFFFFF")
		T.ShovelStatusText = string.format("<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\226\154\160\239\184\143 [Fruit Shovel]</font> <font color=\'%s\'>%s</font></stroke>", V, G)
	end;
	ClearStatus = function()
		T.ShovelStatusText = ""
	end,
	SetWaitingStatus = function()
		u.ShovelFruits.SetStatus(string.format("Waiting | Removed: %d", u.ShovelFruits.TotalRemoved), "#CFCFCF")
	end,
	GetMutationNames = function()
		return u.FruitFilters.GetMutationNames()
	end,
	GetVariantNames = function()
		return u.FruitFilters.GetVariantNames()
	end,
	GetFruitTypeDropdown = function()
		local G = {}
		for V, y in ipairs(T.AllSeedsDataTable) do
			if type(y) ~= "table" then
				continue
			end
			local Z = y.name
			local j = y.single == true
			if type(Z) ~= "string" or Z == "" or j then
				continue
			end
			local i = tostring(y.rarity or "Common")
			local c = u.Data.GetRarityColor(i)
			table.insert(G, {
				Text = string.format("<font color=\"#FFFFFF\">%s</font> <font color=\"%s\">%s</font>", Z, c, i),
				Value = Z
			})
		end
		return G
	end,
	GetAllFruitTypeSelection = function()
		local G = {}
		for V, y in ipairs(T.AllSeedsDataTable) do
			if type(y) ~= "table" then
				continue
			end
			local Z = y.name
			local j = y.single == true
			if type(Z) == "string" and (Z ~= "" and not j) then
				G[Z] = true
			end
		end
		return G
	end;
	SplitMutations = function(G)
		return u.FruitFilters.SplitMutations(G)
	end,
	GetVariantFromMutations = function(G)
		return u.FruitFilters.GetVariantFromMutations(G)
	end,
	HasSelectedMutation = function(G, V)
		return u.FruitFilters.HasSelectedMutation(G, V)
	end;
	PassesMutationFilters = function(G)
		return u.FruitFilters.PassesMutationSelection(G, e.shovel_mutation_whitelist, e.shovel_mutation_blacklist)
	end,
	GetShovelTool = function()
		local G = u.Player.GetTool_Holding()
		if G and G:IsA("Tool") then
			local V = G:GetAttribute("Shovel")
			if type(V) == "string" and V ~= "" then
				return G
			end
		end
		local V = y.LocalPlayer
		local Z = V and V:FindFirstChild("Backpack")
		if not Z then
			return nil
		end
		for G, V in ipairs(Z:GetChildren()) do
			if not V:IsA("Tool") then
				continue
			end
			local y = V:GetAttribute("Shovel")
			if type(y) == "string" and y ~= "" then
				return V
			end
		end
		return nil
	end;
	IsValidFruitTarget = function(G)
		if not G or not G.Parent then
			return false
		end
		local V = G.Parent
		if V.Name ~= "Fruits" then
			return false
		end
		local y = V.Parent
		if not y then
			return false
		end
		local Z = u.Farm.GetOwnPlot()
		if not Z then
			return false
		end
		local j = Z:FindFirstChild("Plants")
		if not j then
			return false
		end
		if y.Parent ~= j then
			return false
		end
		return true
	end,
	ShouldShovelFruit = function(G)
		if type(G) ~= "table" then
			return false
		end
		local V = G.ob
		if not u.ShovelFruits.IsValidFruitTarget(V) then
			return false
		end
		local y = G.name
		if type(y) ~= "string" or y == "" then
			return false
		end
		local Z = e.shovel_fruit_types
		if type(Z) ~= "table" or not u.FruitFilters.IsSelected(Z, y) then
			return false
		end
		local j = tonumber(G.w) or 0
		local i = tonumber(e.shovel_min_weight) or 0
		local c = tonumber(e.shovel_max_weight) or 1000000000
		if G.has_weight == false or j <= 0 then
			return false
		end
		if not u.FruitFilters.PassesWeightRange(j, i, c) then
			return false
		end
		local J = V:GetAttribute("Mutation")
		if type(J) ~= "string" then
			J = G.m
		end
		local T, d = u.FruitFilters.SplitMutations(J)
		local q = u.FruitFilters.GetFruitVariant(G, d)
		local g = e.shovel_variants
		if type(g) ~= "table" or not u.FruitFilters.IsSelected(g, q) then
			return false
		end
		if not u.ShovelFruits.PassesMutationFilters(d) then
			return false
		end
		return true
	end,
	GetMatchingFruits = function()
		local G = {}
		local V = u.FruitFilters.GetAllFruits()
		if type(V) ~= "table" then
			return G
		end
		for V, y in ipairs(V) do
			if u.ShovelFruits.ShouldShovelFruit(y) then
				table.insert(G, y)
			end
		end
		table.sort(G, function(G, V)
			return ((tonumber(G.w) or 0)) < ((tonumber(V.w) or 0))
		end)
		return G
	end,
	ShovelFruit = function(G, V)
		if type(G) ~= "table" then
			return false
		end
		if not V or not V.Parent or not V:IsA("Tool") then
			return false
		end
		local Z = y.Character
		if not Z or V.Parent ~= Z then
			return false
		end
		local j = G.ob
		if not u.ShovelFruits.IsValidFruitTarget(j) then
			return false
		end
		local i = j.Parent
		local c = i and i.Parent
		if not c then
			return false
		end
		local J = c.Name
		local T = j.Name
		if type(J) ~= "string" or J == "" or type(T) ~= "string" or T == "" then
			return false
		end
		local d = V:GetAttribute("Shovel")
		if type(d) ~= "string" or d == "" then
			return false
		end
		local q = y.Networking and (y.Networking.Shovel and y.Networking.Shovel.UseShovel)
		if not q or type(q.Fire) ~= "function" then
			return false
		end
		local g = pcall(function()
			q:Fire(J, T, d, V)
		end)
		return g
	end;
	CleanupTool = function()
		if not u.ShovelFruits.EquippedBySystem then
			return
		end
		u.ShovelFruits.EquippedBySystem = false
		u.Player.UnequipTools()
	end;
	Run = function()
		u.ShovelFruits.LastLoopRemoved = 0
		if not e.auto_shovel_fruits then
			u.ShovelFruits.ClearStatus()
			return 0
		end
		local G = e.shovel_fruit_types
		if type(G) ~= "table" or next(G) == nil then
			u.ShovelFruits.SetStatus("Paused: select fruit types", "#FFCC66")
			return 0
		end
		local V = e.shovel_variants
		if type(V) ~= "table" or next(V) == nil then
			u.ShovelFruits.SetStatus("Paused: select a variant", "#FFCC66")
			return 0
		end
		u.ShovelFruits.SetStatus("Scanning garden...", "#66CCFF")
		local y = u.ShovelFruits.GetMatchingFruits()
		if type(y) ~= "table" or # y == 0 then
			u.ShovelFruits.SetWaitingStatus()
			return 0
		end
		u.ShovelFruits.SetStatus(string.format("Found %d matching fruit%s", # y, # y == 1 and "" or "s"), "#66CCFF")
		local Z = u.ShovelFruits.GetShovelTool()
		if not Z then
			u.ShovelFruits.SetStatus("Paused: shovel not found", "#FF6B6B")
			return 0
		end
		local j = u.Player.IsToolHeld(Z)
		if not j then
			u.ShovelFruits.SetStatus("Equipping shovel...", "#FFD966")
			local G = u.Player.EquipTool(Z)
			if not G then
				u.ShovelFruits.SetStatus("Failed to equip shovel", "#FF6B6B")
				return 0
			end
			u.ShovelFruits.EquippedBySystem = true
			task.wait(.15)
		end
		if not u.Player.IsToolHeld(Z) then
			u.ShovelFruits.CleanupTool()
			u.ShovelFruits.SetStatus("Shovel was unequipped", "#FF6B6B")
			return 0
		end
		local i = 0
		for G, V in ipairs(y) do
			if not e.auto_shovel_fruits then
				break
			end
			if i >= u.ShovelFruits.MaxPerLoop then
				break
			end
			if not u.ShovelFruits.ShouldShovelFruit(V) then
				continue
			end
			if not u.Player.IsToolHeld(Z) then
				u.ShovelFruits.SetStatus("Stopped: shovel unequipped", "#FF6B6B")
				break
			end
			local j = tostring(V.name or "Fruit")
			local c = tonumber(V.w) or 0
			u.ShovelFruits.SetStatus(string.format("Removing %s %.2fkg (%d/%d)", j, c, G, # y), "#FFAA44")
			local J = u.ShovelFruits.ShovelFruit(V, Z)
			if J then
				i += 1
				u.ShovelFruits.TotalRemoved += 1
				u.ShovelFruits.LastLoopRemoved = i
				u.ShovelFruits.SetStatus(string.format("Removed %s %.2fkg | Total: %d", j, c, u.ShovelFruits.TotalRemoved), "#7CFC00")
				task.wait(u.ShovelFruits.RequestDelay)
			end
		end
		u.ShovelFruits.CleanupTool()
		if i > 0 then
			u.ShovelFruits.SetStatus(string.format("Removed %d | Total: %d | Waiting", i, u.ShovelFruits.TotalRemoved), "#7CFC00")
		elseif e.auto_shovel_fruits then
			u.ShovelFruits.SetWaitingStatus()
		end
		return i
	end;
	LoopShovelFruits = function()
		if not e.auto_shovel_fruits then
			u.ShovelFruits.ClearStatus()
			return 0
		end
		local G, V = pcall(function()
			return u.ShovelFruits.Run()
		end)
		if not G then
			u.ShovelFruits.CleanupTool()
			u.ShovelFruits.SetStatus("Error: shovel loop failed", "#FF4444")
			warn("[ShovelFruits] Loop error:", V)
			return 0
		end
		return tonumber(V) or 0
	end
}
u.FarmDetails = {
	Label = nil;
	Busy = false,
	Started = false;
	RefreshDelay = 3,
	FormatVariant = function(G)
		G = tostring(G or "Normal")
		if G == "Gold" then
			return "<font color=\'#FFD700\'>\240\159\140\159 Gold</font>"
		end
		if G == "Rainbow" then
			return "<font color=\'#FF66FF\'>\240\159\140\136 Rainbow</font>"
		end
		return "<font color=\'#FFFFFF\'>" .. (G .. "</font>")
	end,
	FormatCount = function(G)
		local V = tostring(math.max(math.floor(tonumber(G) or 0), 0))
		while true do
			local G, y = V:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
			V = G
			if y == 0 then
				break
			end
		end
		return V
	end,
	FormatWeight = function(G)
		local V = string.format("%.2f", tonumber(G) or 0)
		return V:gsub("%.?0+$", "")
	end;
	SplitMutationTextFarmDetails = function(G)
		local V = {}
		if u.ShovelFruits and type(u.ShovelFruits.SplitMutations) == "function" then
			local V, y = pcall(function()
				return u.ShovelFruits.SplitMutations(G)
			end)
			if V and type(y) == "table" then
				return y
			end
		end
		G = tostring(G or "")
		for G in G:gmatch("[^,%s]+") do
			G = tostring(G or "")
			if G ~= "" then
				table.insert(V, G)
			end
		end
		return V
	end,
	GetVariantNamesFarmDetails = function()
		if u.ShovelFruits and type(u.ShovelFruits.GetVariantNames) == "function" then
			local G, V = pcall(u.ShovelFruits.GetVariantNames)
			if G and type(V) == "table" then
				return V
			end
		end
		return {
			"Normal",
			"Gold";
			"Rainbow"
		}
	end,
	IsSingleHarvestFarmDetails = function(G)
		local V = u.FruitFiltersDataSync
		if V and type(V.IsSingleHarvestPlant) == "function" then
			return V.IsSingleHarvestPlant(G) == true
		end
		return u.SeedData.IsSingleHarvest(G) == true
	end;
	IsReadyFarmDetails = function(G, V)
		local y = u.FruitFiltersDataSync
		if type(G) ~= "table" or G.Removed then
			return false
		end
		if V and (y and type(y.IsPlantReady) == "function") then
			return y.IsPlantReady(G) == true
		end
		if not V and (y and type(y.IsFruitReady) == "function") then
			return y.IsFruitReady(G) == true
		end
		local Z = tonumber(G.Age) or 0
		local j = tonumber(G.MaxAge) or 0
		return j > 0 and Z >= j
	end,
	GetWeightFarmDetails = function(G, V, y)
		local Z = u.FruitFiltersDataSync
		if not Z or type(Z.GetWeightData) ~= "function" then
			return 0
		end
		local j, i = pcall(function()
			return Z.GetWeightData(G, V, y)
		end)
		if not j or type(i) ~= "table" then
			return 0
		end
		return tonumber(i.weight) or 0
	end;
	AddFruitDataFarmDetails = function(G, V, y, Z, j, i, c)
		local J = u.FruitFiltersDataSync
		if not J or type(G) ~= "table" or G.Removed then
			return false
		end
		local T = tostring(G.PlantName or "")
		if T == "" then
			return false
		end
		local d = y and G or V
		if type(d) ~= "table" or d.Removed then
			return false
		end
		j.totalFruits += 1
		if u.FarmDetails.IsReadyFarmDetails(d, y) then
			j.totalReady += 1
		else
			j.totalGrowing += 1
		end
		local q = u.FarmDetails.GetWeightFarmDetails(T, d, y)
		if q > Z.maxWeight then
			Z.maxWeight = q
		end
		local g = tostring(d.Mutation or G.Mutation or "")
		local E = "Normal"
		if type(J.GetVariant) == "function" then
			E = J.GetVariant(g, d.Variant or G.Variant)
		elseif g:find("Rainbow") then
			E = "Rainbow"
		elseif g:find("Gold") then
			E = "Gold"
		end
		i[E] = ((i[E] or 0)) + 1
		for G, V in ipairs(u.FarmDetails.SplitMutationTextFarmDetails(g)) do
			V = tostring(V or "")
			if V ~= "" and (V ~= "Gold" and V ~= "Rainbow") then
				c[V] = ((c[V] or 0)) + 1
			end
		end
		return true
	end;
	BuildText = function()
		local G = u.FruitFiltersDataSync
		if not G or type(G.Plants) ~= "table" then
			return "<font color=\'#AFAFAF\'>Farm data is not ready yet.</font>"
		end
		if not G.Started and type(G.StartSync) == "function" then
			G.StartSync()
		end
		local V = {}
		local y = {}
		local Z = {}
		local j = {
			totalPlants = 0;
			totalFruits = 0;
			totalReady = 0,
			totalGrowing = 0
		}
		for G, i in pairs(G.Plants) do
			if type(i) ~= "table" or i.Removed then
				continue
			end
			local c = tostring(i.PlantName or "")
			if c == "" then
				continue
			end
			local J = tostring(T.SeedRarity[c] or "Unknown")
			local d = V[J]
			if not d then
				d = {}
				V[J] = d
			end
			local q = d[c]
			if not q then
				q = {
					name = c;
					plants = 0;
					maxWeight = 0
				}
				d[c] = q
			end
			q.plants += 1
			j.totalPlants += 1
			if u.FarmDetails.IsSingleHarvestFarmDetails(c) then
				u.FarmDetails.AddFruitDataFarmDetails(i, nil, true, q, j, Z, y)
			else
				for G, V in pairs(i.Fruits or {}) do
					u.FarmDetails.AddFruitDataFarmDetails(i, V, false, q, j, Z, y)
				end
			end
		end
		if j.totalPlants <= 0 then
			return "<font color=\'#AFAFAF\'>No farm data found yet. Wait for garden load or rejoin.</font>"
		end
		local i = {}
		local c = {}
		local J = {}
		for G, V in ipairs(u.FarmDetails.GetVariantNamesFarmDetails()) do
			i[V] = G
		end
		for G, V in pairs(Z) do
			table.insert(c, {
				name = G,
				amount = V,
				order = i[G] or 0
			})
		end
		table.sort(c, function(G, V)
			if G.order ~= V.order then
				return G.order < V.order
			end
			return G.name < V.name
		end)
		for G, V in ipairs(c) do
			table.insert(J, string.format("%s <font color=\'#FFA500\'>x%s</font>", u.FarmDetails.FormatVariant(V.name), u.FarmDetails.FormatCount(V.amount)))
		end
		local d = {
			"<b><font color=\'#7CFC00\'>Farm Summary</font></b> <font color=\'#66CCFF\'>(Data)</font>\n",
			string.format("<font color=\'#FFFFFF\'>Total Plants:</font> <font color=\'#FFA500\'>x%s</font>\n", u.FarmDetails.FormatCount(j.totalPlants)),
			string.format("<font color=\'#FFFFFF\'>Total Fruits:</font> <font color=\'#66CCFF\'>x%s</font>\n", u.FarmDetails.FormatCount(j.totalFruits)),
			string.format("<font color=\'#FFFFFF\'>Ready:</font> <font color=\'#7CFC00\'>x%s</font> / <font color=\'#FFAA55\'>x%s</font>\n", u.FarmDetails.FormatCount(j.totalReady), u.FarmDetails.FormatCount(j.totalGrowing)),
			string.format("<font color=\'#FFFFFF\'>Variants:</font> %s\n\n", # J > 0 and table.concat(J, "  ") or "<font color=\'#AFAFAF\'>None</font>")
		}
		local q = {}
		for G, V in pairs(V) do
			table.insert(q, {
				name = G;
				plants = V,
				rank = T.RarityRank[G] or 0
			})
		end
		table.sort(q, function(G, V)
			if G.rank ~= V.rank then
				return G.rank > V.rank
			end
			return G.name < V.name
		end)
		for G, V in ipairs(q) do
			local y = u.Data.GetRarityColor(V.name)
			local Z = {}
			for G, V in pairs(V.plants) do
				table.insert(Z, V)
			end
			table.sort(Z, function(G, V)
				if G.plants ~= V.plants then
					return G.plants > V.plants
				end
				return G.name < V.name
			end)
			table.insert(d, string.format("<b><font color=\'%s\'>%s</font></b>\n", y, V.name))
			for G, V in ipairs(Z) do
				table.insert(d, string.format("<font color=\'#FFFFFF\'>%s</font> <font color=\'#FFA500\'>x%s</font> <font color=\'#FFFF00\'>(%skg Max)</font>\n", V.name, u.FarmDetails.FormatCount(V.plants), u.FarmDetails.FormatWeight(V.maxWeight)))
			end
			table.insert(d, "\n")
		end
		local g = {}
		for G, V in pairs(y) do
			table.insert(g, {
				name = G;
				amount = V
			})
		end
		table.sort(g, function(G, V)
			if G.amount ~= V.amount then
				return G.amount > V.amount
			end
			return G.name < V.name
		end)
		if # g > 0 then
			table.insert(d, "<b><font color=\'#FF66FF\'>Mutations In Farm</font></b>\n")
			for G, V in ipairs(g) do
				table.insert(d, string.format("<font color=\'#FFFFFF\'>%s</font>: <font color=\'#FFA500\'>x%d</font>\n", V.name, V.amount))
			end
		end
		return table.concat(d)
	end,
	Update = function()
		local G = u.FarmDetails.Label
		if u.FarmDetails.Busy or not G or type(G.SetText) ~= "function" then
			return false
		end
		u.FarmDetails.Busy = true
		local V, y = pcall(u.FarmDetails.BuildText)
		u.FarmDetails.Busy = false
		if not V then
			warn("[FarmDetails]", y)
			G:SetText("<font color=\'#FF6666\'>Farm details failed to refresh.</font>")
			return false
		end
		G:SetText(y)
		return true
	end,
	Start = function()
		if u.FarmDetails.Started then
			return
		end
		u.FarmDetails.Started = true
		task.spawn(function()
			while u.FarmDetails.Started do
				u.FarmDetails.Update()
				task.wait(u.FarmDetails.RefreshDelay)
			end
		end)
	end
}
T.PlantShovelStatusText = ""
u.PlantShovel = {
	MaxPerLoop = 50;
	RequestDelay = .9,
	SetStatus = function(G, V)
		G = tostring(G or "Waiting")
		V = tostring(V or "#FFFFFF")
		T.PlantShovelStatusText = string.format("<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FF5555\'>\226\154\160\239\184\143 [Plant Shovel]</font> <font color=\'%s\'>%s</font></stroke>", V, G)
	end;
	ClearStatus = function()
		T.PlantShovelStatusText = ""
	end,
	GetPlantTypeDropdown = function()
		local G = {}
		local V = u.Farm.GetPlantedSeedCounts()
		for y, Z in ipairs(T.AllSeedsDataTable) do
			if type(Z) ~= "table" then
				continue
			end
			local j = Z.name
			if type(j) ~= "string" or j == "" then
				continue
			end
			if Z.single == true then
				continue
			end
			local i = tonumber(V[j]) or 0
			local c = i > 0 and "#FFD700" or "#FF5555"
			local J = tostring(Z.rarity or "")
			local T = u.Data.GetRarityColor(J)
			table.insert(G, {
				Text = string.format("<font color=\"%s\">x%d</font> <font color=\"#FFFFFF\">%s</font> <font color=\"%s\">%s</font>", c, i, j, T, J),
				Value = j
			})
		end
		table.sort(G, function(G, y)
			local Z = tonumber(V[G.Value]) or 0
			local j = tonumber(V[y.Value]) or 0
			if Z ~= j then
				return Z > j
			end
			return tostring(G.Value) < tostring(y.Value)
		end)
		return G
	end,
	GetAllPlantTypeSelection = function()
		local G = {}
		for V, y in ipairs(T.AllSeedsDataTable) do
			if type(y) ~= "table" then
				continue
			end
			local Z = y.name
			if type(Z) ~= "string" or Z == "" then
				continue
			end
			if y.single == true then
				continue
			end
			G[Z] = true
		end
		return G
	end,
	IsValidPlant = function(G)
		if typeof(G) ~= "Instance" or not G.Parent then
			return false, nil
		end
		local V = u.Farm.GetOwnPlot()
		if not V then
			return false, nil
		end
		local y = V:FindFirstChild("Plants")
		if not y or G.Parent ~= y then
			return false, nil
		end
		local Z = G:GetAttribute("SeedName")
		if type(Z) ~= "string" or Z == "" then
			return false, nil
		end
		if u.SeedData.IsSingleHarvest(Z) then
			return false, Z
		end
		return true, Z
	end,
	IsFullyGrown = function(G)
		if not G then
			return false
		end
		local V = tonumber(G:GetAttribute("Age"))
		local y = tonumber(G:GetAttribute("MaxAge"))
		if not V or not y or y <= 0 then
			return false
		end
		return V >= y
	end,
	GetPlantData = function(G)
		local V, y = u.PlantShovel.IsValidPlant(G)
		if not V then
			return nil
		end
		local Z = tonumber(G:GetAttribute("Height")) or 0
		if not Z then
			return nil
		end
		local j = G:GetAttribute("Mutation")
		if type(j) ~= "string" then
			j = ""
		end
		return {
			ob = G,
			name = y;
			height = Z;
			mutation = j,
			grown = u.PlantShovel.IsFullyGrown(G)
		}
	end,
	IsVariantBlacklisted = function(G)
		local V = e.shovel_plant_variant_blacklist
		if type(V) ~= "table" or next(V) == nil then
			return false
		end
		if type(G) ~= "string" or G == "" then
			return false
		end
		return V[G]
	end;
	PassesVariant = function(G)
		local V = e.shovel_plant_variants
		if type(V) ~= "table" or next(V) == nil then
			return true
		end
		if type(G) ~= "string" or G == "" then
			return false
		end
		return V[G]
	end,
	PassesFilters = function(G)
		if type(G) ~= "table" then
			return false
		end
		local V = G.ob
		if not V or not V.Parent then
			return false
		end
		local y = e.shovel_plant_types
		if type(y) ~= "table" or not y[G.name] then
			return false
		end
		local Z = tonumber(e.shovel_plant_min_height) or 0
		local j = tonumber(e.shovel_plant_max_height) or 200
		local i = tonumber(G.height)
		if not i then
			return false
		end
		if i < Z or i > j then
			return false
		end
		if not e.shovel_growing_plants and not G.grown then
			return false
		end
		if not u.PlantShovel.PassesVariant(G.mutation) then
			return false
		end
		if u.PlantShovel.IsVariantBlacklisted(G.mutation) then
			return false
		end
		return true
	end;
	GetPlantsToShovel = function()
		local G = {}
		local V = {}
		local y = e.shovel_plant_types
		if type(y) ~= "table" then
			return G, V
		end
		for Z, j in ipairs(u.Farm.GetPlants()) do
			local i, c = u.PlantShovel.IsValidPlant(j)
			if not i or not y[c] then
				continue
			end
			V[c] = ((V[c] or 0)) + 1
			local J = u.PlantShovel.GetPlantData(j)
			if J and u.PlantShovel.PassesFilters(J) then
				table.insert(G, J)
			end
		end
		return G, V
	end;
	ShovelPlant = function(G, V)
		local y = type(G) == "table" and G.ob
		if not y or not y.Parent then
			return false
		end
		local Z = u.PlantShovel.IsValidPlant(y)
		if not Z or not u.Player.IsToolHeld(V) then
			return false
		end
		return u.ShovelTool.Use(y.Name, "", V)
	end;
	Run = function()
		if not e.auto_shovel_plants then
			u.PlantShovel.ClearStatus()
			return 0
		end
		local G = e.shovel_plant_types
		if type(G) ~= "table" or next(G) == nil then
			u.PlantShovel.SetStatus("Paused: select plant types", "#FFCC66")
			return 0
		end
		local V, y = u.PlantShovel.GetPlantsToShovel()
		local Z = math.max(math.floor(tonumber(e.shovel_plants_keep) or 0), 0)
		if # V == 0 then
			u.PlantShovel.SetStatus("Nothing to shovel", "#CFCFCF")
			return 0
		end
		local j
		local i = false
		local c = 0
		for G, V in ipairs(V) do
			if not e.auto_shovel_plants then
				break
			end
			if c >= u.PlantShovel.MaxPerLoop then
				break
			end
			local J = V.name
			local T = y[J] or 0
			if T <= Z then
				continue
			end
			if not j then
				j, i = u.ShovelTool.Equip()
				if not j then
					u.PlantShovel.SetStatus("Paused: shovel not found", "#FF6B6B")
					return c
				end
			end
			if not u.Player.IsToolHeld(j) then
				j, i = u.ShovelTool.Equip()
				if not j then
					break
				end
			end
			u.PlantShovel.SetStatus(string.format("Shovelling %s %d/%d", J, T, Z), "#FF5555")
			if u.PlantShovel.ShovelPlant(V, j) then
				y[J] = T - 1
				c += 1
				task.wait(u.PlantShovel.RequestDelay)
			end
		end
		u.ShovelTool.Cleanup(i)
		if c == 0 then
			u.PlantShovel.SetStatus("Nothing above keep limit", "#CFCFCF")
		end
		return c
	end,
	LoopPlantShovel = function()
		if not e.auto_shovel_plants then
			u.PlantShovel.ClearStatus()
			return 0
		end
		local G, V = pcall(function()
			return u.PlantShovel.Run()
		end)
		if not G then
			u.Player.UnequipTools()
			u.PlantShovel.SetStatus("Error: plant shovel loop failed", "#FF4444")
			warn("[PlantShovel] Loop error:", V)
			return 0
		end
		return tonumber(V) or 0
	end
}
T.TrowelRunning = false
T.TrowelStatusText = ""
u.Trowel = {
	MaxPerLoop = 25;
	RequestDelay = .35,
	SetStatus = function(G, V)
		G = tostring(G or "")
		if G == "" then
			T.TrowelStatusText = ""
			return
		end
		T.TrowelStatusText = string.format("<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\147\141 [Trowel]</font> <font color=\'%s\'>%s</font></stroke>", V or "#FFFFFF", G)
	end;
	ClearStatus = function()
		T.TrowelStatusText = ""
	end,
	GetAllSelection = function()
		local G = {}
		for V, y in ipairs(T.AllSeedsDataTable) do
			if type(y) == "table" and type(y.name) == "string" then
				G[y.name] = true
			end
		end
		return G
	end,
	GetTool = function()
		for G, V in ipairs(u.Backpack.GetBackpackAllItems()) do
			if V:IsA("Tool") and V:GetAttribute("Trowel") ~= nil then
				return V
			end
		end
		return nil
	end,
	EquipTool = function()
		local G = u.Trowel.GetTool()
		if not G then
			return nil, false
		end
		if u.Player.IsToolHeld(G) then
			return G, false
		end
		u.Player.UnequipTools()
		if not u.Player.EquipTool(G) then
			return nil, false
		end
		task.wait(.2)
		if not u.Player.IsToolHeld(G) then
			return nil, false
		end
		return G, true
	end;
	GetSavedPositionText = function()
		local G = e.trowel_saved_position
		if type(G) ~= "table" then
			return "\240\159\147\141 Saved Position: Not set"
		end
		local V = tostring(G.area or "")
		local y = tonumber(G.x)
		local Z = tonumber(G.z)
		if V == "" or not y or not Z then
			return "\240\159\147\141 Saved Position: Not set"
		end
		return string.format("\240\159\147\141 Saved Position: %s | X %.2f | Z %.2f", V, y, Z)
	end;
	SavePlayerPosition = function()
		local G = y.Character and y.Character:FindFirstChild("HumanoidRootPart")
		if not G then
			return false, "Character not found"
		end
		local V, Z = u.Farm.GetPlantAreaAtPosition(G.Position)
		if not V or typeof(Z) ~= "Vector3" then
			return false, "Stand inside your farm"
		end
		e.trowel_saved_position = {
			area = V.Name;
			x = Z and Z.X;
			z = Z and Z.Z
		}
		q.Save.SaveDataSync()
		return true, V.Name
	end;
	GetTargetPosition = function()
		if e.trowel_use_fixed_spot then
			local G = u.Farm.GetPermanentPlantPosition(0)
			if typeof(G) ~= "Vector3" then
				return nil, "Farm middle not found"
			end
			return G
		end
		local G = e.trowel_saved_position
		if type(G) ~= "table" then
			return nil, "Copy your position inside the farm"
		end
		local V = u.Farm.GetPlantArea(G.area)
		local y = tonumber(G.x)
		local Z = tonumber(G.z)
		if not V or not y or not Z then
			return nil, "Copy your position inside the farm"
		end
		if math.abs(y) > V.Size.X / 2 or math.abs(Z) > V.Size.Z / 2 then
			return nil, "Saved position is outside your farm"
		end
		return V.CFrame:PointToWorldSpace(Vector3.new(y, V.Size.Y / 2, Z))
	end;
	GetPlants = function(G)
		local V = {}
		local y = e.trowel_plant_types
		local Z = type(y) == "table" and next(y) ~= nil
		for j, i in ipairs(u.Farm.GetPlants()) do
			if not i:IsA("Model") then
				continue
			end
			local c = i:GetAttribute("SeedName")
			if type(c) ~= "string" or c == "" or Z and not y[c] then
				continue
			end
			local J = (i:GetPivot()).Position
			local T = Vector3.new(J.X, 0, J.Z)
			local d = Vector3.new(G.X, 0, G.Z)
			if ((T - d)).Magnitude >= 1.25 then
				table.insert(V, {
					ob = i,
					name = c
				})
			end
		end
		return V
	end,
	MovePlant = function(G, V)
		if not G or not G.Parent then
			return false
		end
		local Z = y.Networking and (y.Networking.Trowel and y.Networking.Trowel.MovePlant)
		if not Z or type(Z.Fire) ~= "function" then
			return false
		end
		local j = G.PrimaryPart and G.PrimaryPart.CFrame or G:GetPivot()
		local i, c, J = j:ToEulerAnglesYXZ()
		return pcall(function()
			Z:Fire(G.Name, V, math.deg(c))
		end)
	end,
	Start = function()
		if T.TrowelRunning then
			return
		end
		T.TrowelRunning = true
		u.Trowel.SetStatus("Starting...", "#66CCFF")
	end;
	Stop = function(G)
		T.TrowelRunning = false
		u.Player.UnequipTools()
		u.Trowel.ClearStatus()
		if type(G) == "string" and G ~= "" then
			T.Notify(G, 3)
		end
	end;
	Run = function()
		if not T.TrowelRunning then
			u.Trowel.ClearStatus()
			return 0
		end
		local G, V = u.Trowel.GetTargetPosition()
		if not G then
			u.Trowel.Stop(V)
			return 0
		end
		local y = u.Trowel.GetPlants(G)
		if # y == 0 then
			u.Trowel.Stop("All selected plants moved")
			return 0
		end
		local Z, j = u.Trowel.EquipTool()
		if not Z then
			u.Trowel.Stop("Trowel not found")
			return 0
		end
		local i = 0
		for V, j in ipairs(y) do
			if not T.TrowelRunning or i >= u.Trowel.MaxPerLoop then
				break
			end
			if not u.Player.IsToolHeld(Z) then
				u.Trowel.Stop("Trowel unequipped or ran out")
				break
			end
			u.Trowel.SetStatus(string.format("Moving %s %d/%d", j.name, V, # y), "#FFD966")
			if u.Trowel.MovePlant(j.ob, G) then
				i += 1
				task.wait(u.Trowel.RequestDelay)
			end
		end
		if j then
			u.Player.UnequipTools()
		end
		if T.TrowelRunning then
			u.Trowel.SetStatus(string.format("Moved %d/%d | Continuing", i, # y), "#7CFC00")
		end
		return i
	end,
	Loop = function()
		local G, V = pcall(u.Trowel.Run)
		if not G then
			u.Trowel.Stop("Trowel system error")
			warn("[Trowel]", V)
			return 0
		end
		return tonumber(V) or 0
	end
}
u.FruitCollect = {
	FruitBucket = {},
	FruitBucketIndex = 1;
	IsMaxFruitInventory = function()
		local G = u.PlayerData.GetFruitCount()
		local V = u.PlayerData.GetMaxFruitCapacity()
		if G >= V then
			return true
		end
		return false
	end;
	IsFarFromGarden = function()
		if not u.Farm.IsNearFarm(100) then
			return true
		end
		return false
	end,
	GetTextCurrentInventoryFruitStats = function()
		local G = u.PlayerData.GetFruitCount() or 0
		local V = u.PlayerData.GetMaxFruitCapacity() or 1
		local y = math.clamp(G / V, 0, 1)
		local Z
		if y < .5 then
			Z = (Color3.new(0, 1, 0)):Lerp(Color3.new(1, 1, 0), y * 2)
		else
			Z = (Color3.new(1, 1, 0)):Lerp(Color3.new(1, .2, 0), ((y - .5)) * 2)
		end
		local j = string.format("#%02X%02X%02X", math.floor(Z.R * 255), math.floor(Z.G * 255), math.floor(Z.B * 255))
		local i = string.format("<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\140\177 [Fruit Collector]</font> <font color=\'%s\'>Fruits (%d/%d)</font></stroke>", j, G, V)
		return i
	end;
	CollectFruit = function(G, V)
		if type(G) ~= "string" or G == "" then
			return false
		end
		V = type(V) == "string" and V or ""
		local Z = y.CollectFruitNet
		if not Z or type(Z.Fire) ~= "function" then
			return false
		end
		local j = pcall(function()
			Z:Fire(G, V)
		end)
		if not j then
			u.FruitCollect.ResetBucket()
			return false
		end
		return true
	end;
	ResetBucket = function()
		u.FruitCollect.FruitBucket = {}
		u.FruitCollect.FruitBucketIndex = 1
	end,
	GetReadyFruitsFromSync = function()
		local G = y.GardenSyncController
		if type(G) ~= "table" or type(G.GetGarden) ~= "function" then
			return nil
		end
		local V, Z = pcall(function()
			return G:GetGarden(T.player_userid)
		end)
		if not V or type(Z) ~= "table" or next(Z) == nil then
			return nil
		end
		local j = {}
		for G, V in pairs(Z) do
			if type(V) ~= "table" then
				continue
			end
			local y = V.PlantName
			if type(y) ~= "string" or y == "" then
				continue
			end
			local Z = tostring(G or "")
			if Z == "" then
				continue
			end
			local i = V.Fruits
			if type(i) == "table" and next(i) ~= nil then
				for G, V in pairs(i) do
					if type(V) ~= "table" then
						continue
					end
					local i = tonumber(V.Age) or 0
					local c = tonumber(V.MaxAge) or 0
					if c > 0 and i >= c then
						local i = u.FruitFilters.BuildFruitData(nil, nil, y, Z, tostring(G or ""), V)
						if i and u.FruitFilters.PassesCollectorFilters(i) then
							table.insert(j, i)
						end
					end
				end
			elseif u.SeedData.IsSingleHarvest(y) then
				local G = tonumber(V.Age) or 0
				local i = tonumber(V.MaxAge) or 0
				if i > 0 and G >= i then
					local G = u.FruitFilters.BuildFruitData(nil, nil, y, Z, "", V)
					if G and u.FruitFilters.PassesCollectorFilters(G) then
						table.insert(j, G)
					end
				end
			end
		end
		return j
	end,
	GetCollectSortModeFruitCollect = function()
		local G = tostring(e.collect_sort_mode or "Default")
		if G == "Highest Price > Lowest" or G == "Lowest Price > Highest" then
			return G
		end
		return "Default"
	end,
	GetCollectLivePriceFruitCollect = function(G)
		if type(G) ~= "table" then
			return 0, 1, "none"
		end
		local V = tostring(G.name or G.Name or G.PlantName or "")
		if V == "" or type(u.BuySelectFruit) ~= "table" or type(u.BuySelectFruit.GetEstimatedPriceBuySelectFruit) ~= "function" then
			return 0, 1, "none"
		end
		if type(u.BuySelectFruit.EnsureFruitStockReadyBuySelectFruit) == "function" then
			u.BuySelectFruit.EnsureFruitStockReadyBuySelectFruit(false)
		elseif type(u.BuySelectFruit.UpdateFruitStockBuySelectFruit) == "function" then
			u.BuySelectFruit.UpdateFruitStockBuySelectFruit(false)
		end
		local y, Z, j = u.BuySelectFruit.GetEstimatedPriceBuySelectFruit(V, G.sourceData, G.m)
		return math.max(math.floor(tonumber(y) or 0), 0), tonumber(Z) or 1, tostring(j or "none")
	end;
	SortReadyFruitBucketByLivePriceFruitCollect = function(G)
		if type(G) ~= "table" or # G <= 1 then
			return G
		end
		local V = u.FruitCollect.GetCollectSortModeFruitCollect()
		if V == "Default" then
			return G
		end
		for G, V in ipairs(G) do
			if type(V) == "table" then
				local G, y, Z = u.FruitCollect.GetCollectLivePriceFruitCollect(V)
				V.collect_live_price = G
				V.collect_live_multiplier = y
				V.collect_live_tier = Z
			end
		end
		table.sort(G, function(G, y)
			local Z = tonumber(G and G.collect_live_price) or 0
			local j = tonumber(y and y.collect_live_price) or 0
			if Z ~= j then
				if V == "Lowest Price > Highest" then
					return Z < j
				end
				return Z > j
			end
			local i = tonumber(G and G.collect_live_multiplier) or 1
			local c = tonumber(y and y.collect_live_multiplier) or 1
			if i ~= c then
				if V == "Lowest Price > Highest" then
					return i < c
				end
				return i > c
			end
			local J = tonumber(G and G.w) or 0
			local d = tonumber(y and y.w) or 0
			if J ~= d then
				return J > d
			end
			local u = T.RarityRank[tostring(G and G.r or "")] or 0
			local q = T.RarityRank[tostring(y and y.r or "")] or 0
			if u ~= q then
				return u > q
			end
			return tostring(G and G.name or "") < tostring(y and y.name or "")
		end)
		return G
	end,
	GetReadyFruitBucket = function()
		local G = nil
		local V = e.high_mode
		if T.GetCheckIfPro() then
			if V and (u.FruitFiltersDataSync and type(u.FruitFiltersDataSync.GetFruits) == "function") then
				local V, y = pcall(u.FruitFiltersDataSync.GetFruits)
				if V and type(y) == "table" then
					G = y
				else
					warn(tostring(y))
				end
			end
		end
		if type(G) ~= "table" then
			G = u.FruitFilters.GetReadyFruits(nil, true) or {}
		end
		return u.FruitCollect.SortReadyFruitBucketByLivePriceFruitCollect(G)
	end,
	CollectLoopSimple = function()
		if not e.auto_collect_fruit_enabled then
			return
		end
		if u.FruitCollect.IsMaxFruitInventory() then
			return
		end
		if u.FruitCollect.FruitBucketIndex > # u.FruitCollect.FruitBucket then
			u.FruitCollect.FruitBucket = u.FruitCollect.GetReadyFruitBucket()
			u.FruitCollect.FruitBucketIndex = 1
		end
		local G = 0
		local V = false
		if e.high_mode and T.GetCheckIfPro() then
			V = true
		end
		if # u.FruitCollect.FruitBucket > 0 then
			if u.FruitCollect.IsFarFromGarden() and e.collection_teleport then
				if not u.GameTeleport.Garden(T.TeleportLockNames.FruitCollector) then
					u.PetFarmReturn.SetStatus("Garden teleport failed", "#FF5555")
				end
			end
		end
		if not y.CollectFruitNet or type(y.CollectFruitNet.Fire) ~= "function" then
			return false
		end
		local Z = # u.FruitCollect.FruitBucket
		local j = u.PlayerData.GetMaxFruitCapacity() + 300
		for y = 1, Z, 1 do
			local Z = u.FruitCollect.FruitBucket[u.FruitCollect.FruitBucketIndex]
			if not Z then
				u.FruitCollect.ResetBucket()
				break
			end
			if G > j then
				break
			end
			u.FruitCollect.FruitBucketIndex += 1
			if not e.auto_collect_fruit_enabled then
				return
			end
			if u.FruitCollect.IsMaxFruitInventory() then
				return
			end
			if not u.FruitFilters.PassesCollectorFilters(Z) then
				continue
			end
			local i = Z.plantId
			local c = Z.fruitId
			if V then
				u.FruitCollect.CollectFruit(i, c)
				u.FruitCollect.CollectFruit(i, c)
				G += 1
			else
				if u.FruitCollect.CollectFruit(i, c) then
					G += 1
					task.wait()
				end
			end
		end
		return G
	end
}
T.PetFarmStatusText = ""
u.PetFarmReturn = {
	MaxDistance = 35;
	NextCheckAt = 0,
	SetStatus = function(G, V)
		T.PetFarmStatusText = string.format("<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\144\190 [Pet Farm]</font> <font color=\'%s\'>%s</font></stroke>", V or "#FFFFFF", tostring(G or ""))
	end,
	GetTimer = function()
		return math.max(math.floor(tonumber(e.pet_return_farm_timer) or 60), 3)
	end,
	ResetTimer = function()
		u.PetFarmReturn.NextCheckAt = os.clock() + u.PetFarmReturn.GetTimer()
	end;
	Loop = function()
		if not e.pet_return_farm then
			T.PetFarmStatusText = ""
			return
		end
		if u.PetFarmReturn.NextCheckAt <= 0 then
			u.PetFarmReturn.ResetTimer()
		end
		local G = math.max(math.ceil(u.PetFarmReturn.NextCheckAt - os.clock()), 0)
		if G > 0 then
			u.PetFarmReturn.SetStatus(string.format("Teleporting in %ds", G), "#FFD966")
			return
		end
		if u.Teleport.IsLocked(T.TeleportLockNames.PetFarmReturn) then
			return
		end
		if not u.PlayerData.GetIsInOwnGarden() then
			u.PetFarmReturn.SetStatus("Teleporting to farm...", "#66CCFF")
			if not u.GameTeleport.Garden(T.TeleportLockNames.PetFarmReturn) then
				u.PetFarmReturn.SetStatus("Garden teleport failed", "#FF5555")
			else
				task.wait(1.5)
				if not u.Farm.TeleportToCenter(T.TeleportLockNames.PetFarmReturn) then
					u.PetFarmReturn.SetStatus("Farm centre not found", "#FF5555")
				end
			end
		end
		u.PetFarmReturn.ResetTimer()
	end
}
u.PetFarmReturn.ResetTimer()
task.spawn(function()
	while true do
		task.wait(.2)
		if not e.turbo_sell then
			task.wait(3)
			continue
		end
		u.SellManager.SellAll()
	end
end)
task.spawn(function()
	while true do
		if e.fruit_collect_nolimits and T.GetCheckIfPro() == true then
			task.wait(.067)
		else
			task.wait(.5)
		end
		if not e.auto_collect_fruit_enabled then
			task.wait(3)
			continue
		end
		local G, V = pcall(function()
			u.FruitCollect.CollectLoopSimple()
		end)
		u.SellManager.SellAll()
		if not G then
			u.FruitCollect.ResetBucket()
			warn("[FruitCollect] Loop error:", V)
			task.wait(1)
		end
	end
end)
T.SprinklerPlaceStatusText = ""
u.SprinklerPlacer = {
	MaxPerLoop = 10;
	MinSpacing = 1.5,
	CentreSideOffset = 10,
	MaxPositionAttempts = 80;
	EquippedBySystem = false,
	SetStatus = function(G, V)
		T.SprinklerPlaceStatusText = string.format("<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\146\166 [Sprinkler]</font> <font color=\'%s\'>%s</font></stroke>", tostring(V or "#FFFFFF"), tostring(G or "Waiting"))
	end;
	ClearStatus = function()
		T.SprinklerPlaceStatusText = ""
	end,
	GetDelay = function()
		return math.max(tonumber(e.sprinkler_place_delay) or .6, .2)
	end,
	GetNames = function()
		local G = {}
		local V = {}
		for y, Z in ipairs(T.AllGearShopTable) do
			local j = type(Z) == "table" and Z.name or nil
			if type(j) ~= "string" or j == "" or not string.find(j, "Sprinkler", 1, true) or V[j] then
				continue
			end
			V[j] = true
			table.insert(G, j)
		end
		table.sort(G)
		return G
	end;
	IsValidName = function(G)
		if type(G) ~= "string" or G == "" then
			return false
		end
		for V, y in ipairs(u.SprinklerPlacer.GetNames()) do
			if y == G then
				return true
			end
		end
		return false
	end;
	GetDropdown = function()
		local G = {}
		for V, y in ipairs(u.SprinklerPlacer.GetNames()) do
			local Z = u.GearData.GetGeatItemDetails(y) or {}
			local j = tostring(Z.rarity or "Unknown")
			local i = u.Data.GetRarityColor(j)
			table.insert(G, {
				Text = string.format("<font color=\"#FFFFFF\">%s</font> <font color=\"%s\">%s</font>", y, i, j);
				Value = y
			})
		end
		return G
	end,
	GetAllSelection = function()
		local G = {}
		for V, y in ipairs(u.SprinklerPlacer.GetNames()) do
			G[y] = true
		end
		return G
	end,
	GetOverrideTarget = function(G)
		local V = e.sprinkler_place_overrides
		if type(V) ~= "table" then
			return nil
		end
		local y = tonumber(V[G])
		if not y then
			return nil
		end
		return math.max(math.floor(y), 0)
	end,
	SetOverrideTarget = function(G, V)
		if not u.SprinklerPlacer.IsValidName(G) then
			return false
		end
		V = math.floor(tonumber(V) or 0)
		if V <= 0 then
			return false
		end
		if type(e.sprinkler_place_overrides) ~= "table" then
			e.sprinkler_place_overrides = {}
		end
		e.sprinkler_place_overrides[G] = V
		return true
	end,
	RemoveOverrideTarget = function(G)
		if type(e.sprinkler_place_overrides) ~= "table" then
			e.sprinkler_place_overrides = {}
			return false
		end
		if e.sprinkler_place_overrides[G] == nil then
			return false
		end
		e.sprinkler_place_overrides[G] = nil
		return true
	end,
	GetTargetAmount = function(G)
		local V = u.SprinklerPlacer.GetOverrideTarget(G)
		if V ~= nil then
			return V
		end
		return math.max(math.floor(tonumber(e.sprinkler_place_default_target) or 1), 0)
	end,
	GetSprinklersFolder = function()
		local G = u.Farm.GetOwnPlot()
		if not G then
			return nil
		end
		return G:FindFirstChild("Sprinklers")
	end;
	GetPlacedCounts = function()
		local G = {}
		local V = 0
		local y = u.SprinklerPlacer.GetSprinklersFolder()
		if not y then
			return G, V
		end
		for y, Z in ipairs(y:GetChildren()) do
			local j = Z:GetAttribute("SprinklerName")
			if type(j) ~= "string" or j == "" then
				continue
			end
			G[j] = ((G[j] or 0)) + 1
			V += 1
		end
		return G, V
	end,
	GetOccupiedPositions = function()
		local G = {}
		local V = u.SprinklerPlacer.GetSprinklersFolder()
		if not V then
			return G
		end
		for V, y in ipairs(V:GetChildren()) do
			local Z
			if y:IsA("Model") then
				Z = (y:GetPivot()).Position
			elseif y:IsA("BasePart") then
				Z = y.Position
			end
			if typeof(Z) == "Vector3" then
				table.insert(G, Z)
			end
		end
		return G
	end;
	IsPositionOpen = function(G, V)
		if typeof(G) ~= "Vector3" then
			return false
		end
		for V, y in ipairs(V or {}) do
			if typeof(y) ~= "Vector3" then
				continue
			end
			local Z = Vector3.new(G.X - y.X, 0, G.Z - y.Z)
			if Z.Magnitude < u.SprinklerPlacer.MinSpacing then
				return false
			end
		end
		return true
	end;
	GetTool = function(G)
		if type(G) ~= "string" or G == "" then
			return nil
		end
		for V, y in ipairs(u.Backpack.GetBackpackAllItems()) do
			if not y:IsA("Tool") then
				continue
			end
			local Z = y:GetAttribute("Sprinkler")
			if Z == G then
				return y
			end
			if y.Name == G and Z ~= nil then
				return y
			end
		end
		return nil
	end;
	EquipTool = function(G)
		if not G or not G:IsA("Tool") then
			return false
		end
		if u.Player.IsToolHeld(G) then
			return true
		end
		u.Player.UnequipTools()
		if not u.Player.EquipTool(G) then
			return false
		end
		u.SprinklerPlacer.EquippedBySystem = true
		task.wait(.15)
		return u.Player.IsToolHeld(G)
	end;
	CleanupTool = function()
		if not u.SprinklerPlacer.EquippedBySystem then
			return
		end
		u.SprinklerPlacer.EquippedBySystem = false
		u.Player.UnequipTools()
	end;
	SaveCurrentPosition = function()
		local G = y.Character and y.Character:FindFirstChild("HumanoidRootPart")
		if not G then
			return false, "Character not found"
		end
		local V, Z = u.Farm.GetPlantAreaAtPosition(G.Position)
		if not V or typeof(Z) ~= "Vector3" then
			return false, "Stand inside your farm"
		end
		e.sprinkler_place_saved_position = {
			area = V.Name;
			x = Z.X,
			z = Z.Z
		}
		q.Save.SaveDataSync()
		return true, "Sprinkler position saved"
	end,
	GetSavedPositionText = function()
		local G = e.sprinkler_place_saved_position
		local V = type(G) == "table" and tostring(G.area or "") or ""
		local y = type(G) == "table" and tonumber(G.x) or nil
		local Z = type(G) == "table" and tonumber(G.z) or nil
		if V == "" or not y or not Z then
			return "\240\159\147\141 Saved Position: Not set"
		end
		return string.format("\240\159\147\141 Saved Position: %s | X %.2f | Z %.2f", V, y, Z)
	end;
	GetTargetPlant = function()
		local G = tostring(e.sprinkler_place_target_plant or "")
		if G == "" then
			return nil
		end
		local V = u.Farm.GetPermanentCenterPosition()
		local y
		local Z = math.huge
		for j, i in ipairs(u.Farm.GetPlants()) do
			if i:GetAttribute("SeedName") ~= G then
				continue
			end
			local c
			if i:IsA("Model") then
				c = (i:GetPivot()).Position
			elseif i:IsA("BasePart") then
				c = i.Position
			end
			if typeof(c) ~= "Vector3" then
				continue
			end
			local J = V and ((c - V)).Magnitude or 0
			if J < Z then
				Z = J
				y = i
			end
		end
		return y
	end;
	GetBasePosition = function(G)
		local V = tostring(e.sprinkler_place_mode or "Farm Middle")
		G = math.max(math.floor(tonumber(G) or 0), 0)
		if V == "Farm Middle" then
			local V = u.Farm.GetPermanentCenterCFrame()
			if not V then
				return nil, "Farm centre not found"
			end
			local y = {
				- u.SprinklerPlacer.CentreSideOffset;
				u.SprinklerPlacer.CentreSideOffset,
				0;
				- u.SprinklerPlacer.CentreSideOffset / 2,
				u.SprinklerPlacer.CentreSideOffset / 2
			}
			local Z = y[(G % # y) + 1]
			return V:PointToWorldSpace(Vector3.new(Z, 0, 0))
		end
		if V == "Plant Target" then
			local G = u.SprinklerPlacer.GetTargetPlant()
			if not G then
				return nil, "Selected target plant not found"
			end
			if G:IsA("Model") then
				return (G:GetPivot()).Position
			end
			if G:IsA("BasePart") then
				return G.Position
			end
			return nil, "Selected target plant not found"
		end
		if V == "Saved Position" then
			local G = e.sprinkler_place_saved_position
			local V = type(G) == "table" and u.Farm.GetPlantArea(G.area) or nil
			local y = type(G) == "table" and tonumber(G.x) or nil
			local Z = type(G) == "table" and tonumber(G.z) or nil
			if not V or not y or not Z then
				return nil, "Copy a sprinkler position"
			end
			if math.abs(y) > V.Size.X / 2 or math.abs(Z) > V.Size.Z / 2 then
				return nil, "Saved position is outside your farm"
			end
			return V.CFrame:PointToWorldSpace(Vector3.new(y, V.Size.Y / 2, Z))
		end
		return nil, "Invalid placement mode"
	end,
	FindOpenPositionAround = function(G, V)
		local y, Z, j = u.Farm.ProjectPositionToPlantArea(G, 1)
		if not Z or not j then
			return nil
		end
		for G = 0, u.SprinklerPlacer.MaxPositionAttempts, 1 do
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
			if math.abs(y) > c or math.abs(i) > J then
				continue
			end
			local T = Z.CFrame:PointToWorldSpace(Vector3.new(y, Z.Size.Y / 2, i))
			if u.SprinklerPlacer.IsPositionOpen(T, V) then
				return T
			end
		end
		return nil
	end;
	GetPlacementPosition = function(G, V)
		local y, Z = u.SprinklerPlacer.GetBasePosition(V)
		if not y then
			return nil, Z
		end
		local j = u.SprinklerPlacer.FindOpenPositionAround(y, G)
		if not j then
			return nil, "No open sprinkler position found"
		end
		return j
	end,
	GetCandidates = function()
		local G = {}
		local V = e.sprinkler_place_selected
		local y, Z = u.SprinklerPlacer.GetPlacedCounts()
		local j = 0
		local i = 0
		if type(V) ~= "table" then
			return G, y, Z, j, i
		end
		for V, Z in pairs(V) do
			if Z ~= true or not u.SprinklerPlacer.IsValidName(V) then
				continue
			end
			j += 1
			local c = u.SprinklerPlacer.GetTargetAmount(V)
			local J = math.max(math.floor(tonumber(y[V]) or 0), 0)
			local T = math.max(c - J, 0)
			if T <= 0 then
				continue
			end
			i += 1
			if u.SprinklerPlacer.GetTool(V) then
				table.insert(G, {
					name = V,
					placed = J,
					target = c;
					remaining = T
				})
			end
		end
		return G, y, Z, j, i
	end;
	PrepareTeleport = function(G, V)
		if not e.sprinkler_place_teleport then
			return true
		end
		if not u.PlayerData.GetIsInOwnGarden() then
			return u.GameTeleport.Garden(V)
		end
		return false
	end,
	Place = function(G, V, Z, j)
		if type(G) ~= "string" or G == "" then
			return false
		end
		if typeof(V) ~= "Vector3" or not Z or not Z:IsA("Tool") then
			return false
		end
		if not u.Player.IsToolHeld(Z) then
			return false
		end
		j = tonumber(j)
		if not j or j <= 0 then
			return false
		end
		local i = y.Networking and (y.Networking.Place and y.Networking.Place.PlaceSprinkler)
		if not i or type(i.Fire) ~= "function" then
			return false
		end
		local c = u.SprinklerPlacer.GetPlacedCounts()
		local J = c[G] or 0
		local T = pcall(function()
			i:Fire(V, G, Z, j)
		end)
		if not T then
			return false
		end
		local d = os.clock() + 1.5
		repeat
			local V = u.SprinklerPlacer.GetPlacedCounts()
			local y = V[G] or 0
			if y > J then
				return true
			end
			if not Z.Parent then
				return true
			end
			task.wait(.05)
		until os.clock() >= d
		return false
	end,
	Run = function()
		if not e.auto_sprinkler_place then
			u.SprinklerPlacer.ClearStatus()
			return 0
		end
		local G, V = u.WeatherTriggers.IsActiveWeatherTriggers(e.sprinkler_place_weather_enabled, e.sprinkler_place_weather_selected)
		if not G then
			u.SprinklerPlacer.SetStatus("Waiting for weather | Now: " .. tostring(V), "#CFCFCF")
			return 0
		end
		local y, Z, j, i, c = u.SprinklerPlacer.GetCandidates()
		if i <= 0 then
			u.SprinklerPlacer.SetStatus("Paused: select sprinklers", "#FFCC66")
			return 0
		end
		if # y <= 0 then
			if c <= 0 then
				u.SprinklerPlacer.SetStatus("All selected targets reached", "#7CFC00")
			else
				u.SprinklerPlacer.SetStatus("Selected sprinkler tools not found", "#FFCC66")
			end
			return 0
		end
		local J = u.SprinklerPlacer.GetOccupiedPositions()
		local d, q = u.SprinklerPlacer.GetPlacementPosition(J, j)
		if not d then
			u.SprinklerPlacer.SetStatus(q or "Placement position unavailable", "#FF5555")
			return 0
		end
		local g = u.PlayerData.GetPlotId()
		if not g or g <= 0 then
			u.SprinklerPlacer.SetStatus("Plot ID not found", "#FF5555")
			return 0
		end
		local E = T.TeleportLockNames.SprinklerPlacer
		local a = false
		if e.sprinkler_place_teleport then
			a = u.Teleport.LockTeleport(E, 10, false)
			if not a then
				u.SprinklerPlacer.SetStatus("Waiting: teleport busy", "#FFCC66")
				return 0
			end
		end
		local H = 0
		local r = 0
		while e.auto_sprinkler_place and (# y > 0 and r < u.SprinklerPlacer.MaxPerLoop) do
			local G = u.Farm._Random:NextInteger(1, # y)
			local V = y[G]
			local i = u.SprinklerPlacer.GetTool(V.name)
			if not i or V.remaining <= 0 then
				table.remove(y, G)
				continue
			end
			local c, T = u.SprinklerPlacer.GetPlacementPosition(J, j + H)
			if not c then
				u.SprinklerPlacer.SetStatus(T or "Placement position unavailable", "#FF5555")
				break
			end
			if e.sprinkler_place_teleport then
				u.Teleport.LockTeleport(E, 10, false)
				if not u.SprinklerPlacer.PrepareTeleport(c, E) then
					u.SprinklerPlacer.SetStatus("Could not reach placement position", "#FF5555")
					break
				end
			end
			if not u.SprinklerPlacer.EquipTool(i) then
				table.remove(y, G)
				continue
			end
			r += 1
			u.SprinklerPlacer.SetStatus(string.format("Placing %s %d/%d", V.name, V.placed + 1, V.target), "#66CCFF")
			local d = u.SprinklerPlacer.Place(V.name, c, i, g)
			if d then
				table.insert(J, c)
				V.placed += 1
				V.remaining -= 1
				Z[V.name] = V.placed
				H += 1
				task.wait(u.SprinklerPlacer.GetDelay())
			else
				if e.sprinkler_place_teleport then
					u.SprinklerPlacer.SetStatus("Sprinkler placement failed", "#FF5555")
				else
					u.SprinklerPlacer.SetStatus("Placement failed: try Auto Teleport", "#FFCC66")
				end
				break
			end
			if V.remaining <= 0 then
				table.remove(y, G)
			end
		end
		u.SprinklerPlacer.CleanupTool()
		if a then
			u.Teleport.UnlockTeleport(E)
		end
		if not e.auto_sprinkler_place then
			u.SprinklerPlacer.ClearStatus()
		elseif H > 0 then
			u.SprinklerPlacer.SetStatus(string.format("Placed %d sprinkler%s | Waiting", H, H == 1 and "" or "s"), "#7CFC00")
		end
		return H
	end,
	Loop = function()
		if not e.auto_sprinkler_place then
			u.SprinklerPlacer.ClearStatus()
			return 0
		end
		if not T.GetCheckIfPro() then
			return 0
		end
		local G, V = pcall(u.SprinklerPlacer.Run)
		if not G then
			u.SprinklerPlacer.CleanupTool()
			u.Teleport.UnlockTeleport(T.TeleportLockNames.SprinklerPlacer)
			u.SprinklerPlacer.SetStatus("Error: sprinkler placer failed", "#FF4444")
			warn("[SprinklerPlacer] Loop error:", V)
			return 0
		end
		return tonumber(V) or 0
	end
}
T.WaterPlantStatusText = ""
u.WaterPlants = {
	NextUseAt = 0,
	LastCanName = "",
	LastTargetName = "";
	EquippedBySystem = false;
	SetStatus = function(G, V)
		T.WaterPlantStatusText = string.format("<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\146\167 [Water Plants]</font> <font color=\'%s\'>%s</font></stroke>", tostring(V or "#FFFFFF"), tostring(G or "Waiting"))
	end;
	ClearStatus = function()
		T.WaterPlantStatusText = ""
	end,
	GetCanDropdown = function()
		local G = {}
		if type(y.WateringcanData) ~= "table" then
			return G
		end
		for V, y in ipairs(y.WateringcanData) do
			local Z = type(y) == "table" and y.Name or nil
			if type(Z) ~= "string" or Z == "" then
				continue
			end
			table.insert(G, {
				Text = string.format("<font color=\"#FFFFFF\">%s</font> <font color=\"#66CCFF\">%d studs</font> <font color=\"#FFD966\">\226\143\179%ds</font> <font color=\"#7CFC00\">Multi x%d</font>", Z, math.floor(tonumber(y.SplashRadius) or 0), math.floor(tonumber(y.EffectTime) or 0), math.floor(tonumber(y.GrowthSpeedMultiplier) or 0));
				Value = Z
			})
		end
		return G
	end;
	GetTool = function()
		if type(y.WateringcanData) ~= "table" then
			return nil, nil
		end
		local G = e.water_plant_selected_cans
		local V = type(G) ~= "table" or next(G) == nil
		local Z = u.Backpack.GetBackpackAllItems()
		for y, j in ipairs(y.WateringcanData) do
			local i = type(j) == "table" and j.Name or nil
			if type(i) ~= "string" or i == "" then
				continue
			end
			if not V and G[i] ~= true then
				continue
			end
			for G, V in ipairs(Z) do
				if V:IsA("Tool") and V:GetAttribute("WateringCan") == i then
					return V, j
				end
			end
		end
		return nil, nil
	end;
	GetPlantTarget = function(G, V)
		for y, Z in ipairs(u.Farm.GetPlants()) do
			if not Z or not Z.Parent then
				continue
			end
			local j = Z:GetAttribute("SeedName")
			if type(j) ~= "string" or j == "" then
				continue
			end
			if type(G) == "string" and (G ~= "" and j ~= G) then
				continue
			end
			if V then
				local G = tonumber(Z:GetAttribute("Age"))
				local V = tonumber(Z:GetAttribute("MaxAge"))
				if not G or not V or V <= 0 or G >= V then
					continue
				end
			end
			local i
			if Z:IsA("Model") then
				i = (Z:GetPivot()).Position
			elseif Z:IsA("BasePart") then
				i = Z.Position
			end
			if typeof(i) ~= "Vector3" then
				continue
			end
			local c = u.Farm.ProjectPositionToPlantArea(i, 0)
			if typeof(c) == "Vector3" then
				return c, j
			end
		end
		return nil, nil
	end,
	GetTargetPosition = function()
		local G = tostring(e.water_plant_mode or "Growing Plant")
		if G == "Growing Plant" then
			local G, V = u.WaterPlants.GetPlantTarget(nil, true)
			if typeof(G) ~= "Vector3" then
				return nil, nil, "No growing plants"
			end
			return G, V
		end
		if G == "Farm Middle" then
			local G = u.Farm.GetPermanentPlantPosition(0)
			if typeof(G) ~= "Vector3" then
				return nil, nil, "Farm middle not found"
			end
			return G, "Farm Middle"
		end
		if G == "Plant Target" then
			local G = tostring(e.water_plant_target_plant or "")
			if G == "" then
				return nil, nil, "Select a target plant"
			end
			local V = u.WaterPlants.GetPlantTarget(G, false)
			if typeof(V) ~= "Vector3" then
				return nil, nil, G .. " not found"
			end
			return V, G
		end
		if G == "Custom Position" then
			local G = e.water_plant_saved_position
			local V = type(G) == "table" and u.Farm.GetPlantArea(G.area) or nil
			local y = type(G) == "table" and tonumber(G.x) or nil
			local Z = type(G) == "table" and tonumber(G.z) or nil
			if not V or not y or not Z then
				return nil, nil, "Copy a custom position"
			end
			if math.abs(y) > V.Size.X / 2 or math.abs(Z) > V.Size.Z / 2 then
				return nil, nil, "Custom position is outside your farm"
			end
			local j = V.CFrame:PointToWorldSpace(Vector3.new(y, V.Size.Y / 2, Z))
			return j, "Custom Position"
		end
		return nil, nil, "Invalid watering mode"
	end;
	SaveCurrentPosition = function()
		local G = y.Character and y.Character:FindFirstChild("HumanoidRootPart")
		if not G then
			return false, "Character not found"
		end
		local V, Z = u.Farm.GetPlantAreaAtPosition(G.Position)
		if not V or typeof(Z) ~= "Vector3" then
			return false, "Stand inside your farm"
		end
		e.water_plant_saved_position = {
			area = V.Name;
			x = Z.X,
			z = Z.Z
		}
		q.Save.SaveDataSync()
		return true, "Watering position saved"
	end;
	GetSavedPositionText = function()
		local G = e.water_plant_saved_position
		local V = type(G) == "table" and tostring(G.area or "") or ""
		local y = type(G) == "table" and tonumber(G.x) or nil
		local Z = type(G) == "table" and tonumber(G.z) or nil
		if V == "" or not y or not Z then
			return "\240\159\147\141 Custom Position: Not set"
		end
		return string.format("\240\159\147\141 Custom Position: %s | X %.2f | Z %.2f", V, y, Z)
	end;
	EnsureNearTarget = function(G)
		if typeof(G) ~= "Vector3" then
			return false, false, "Invalid watering position"
		end
		local V = y.Character and y.Character:FindFirstChild("HumanoidRootPart")
		if not V then
			return false, false, "Character not found"
		end
		if ((V.Position - G)).Magnitude <= 21 then
			return true, false
		end
		local Z = T.TeleportLockNames.WaterPlants
		if not u.Teleport.LockTeleport(Z, 4, false) then
			return false, false, "Waiting: teleport busy"
		end
		u.WaterPlants.SetStatus("Moving near watering target...", "#66CCFF")
		local j = Vector3.new(V.Position.X - G.X, 0, V.Position.Z - G.Z)
		if j.Magnitude <= .1 then
			j = Vector3.new(0, 0, 1)
		else
			j = j.Unit
		end
		local i = (G + j * 6) + Vector3.new(0, 3, 0)
		local c = u.Teleport.TeleportToCFrame(CFrame.lookAt(i, G), Z)
		if not c then
			u.Teleport.UnlockTeleport(Z)
			return false, false, "Could not reach watering target"
		end
		task.wait(.15)
		return true, true
	end;
	CleanupTool = function()
		if u.WaterPlants.EquippedBySystem then
			u.WaterPlants.EquippedBySystem = false
			u.Player.UnequipTools()
		end
	end,
	Use = function(G, V, Z)
		local j = y.Networking and (y.Networking.WateringCan and y.Networking.WateringCan.UseWateringCan)
		if typeof(G) ~= "Vector3" or type(V) ~= "string" or V == "" then
			return false
		end
		if not Z or not Z:IsA("Tool") or not u.Player.IsToolHeld(Z) then
			return false
		end
		if not j or type(j.Fire) ~= "function" then
			return false
		end
		return pcall(function()
			j:Fire(G - Vector3.new(0, .3, 0), V, Z)
		end)
	end;
	Run = function()
		if not e.auto_water_plants then
			u.WaterPlants.ClearStatus()
			return 0
		end
		local G, V = u.WeatherTriggers.IsActiveWeatherTriggers(e.water_plant_weather_enabled, e.water_plant_weather_selected)
		if not G then
			u.WaterPlants.SetStatus("Waiting for weather | Now: " .. tostring(V), "#CFCFCF")
			return 0
		end
		if type(y.WateringcanData) ~= "table" then
			u.WaterPlants.SetStatus("Watering data unavailable", "#FF5555")
			return 0
		end
		if e.water_plant_wait_effect then
			local G = math.max(math.ceil(u.WaterPlants.NextUseAt - os.clock()), 0)
			if G > 0 then
				u.WaterPlants.SetStatus(string.format("%s \226\134\146 %s | Wait %ds", u.WaterPlants.LastCanName, u.WaterPlants.LastTargetName, G), "#7CFC00")
				return 0
			end
		end
		local Z, j, i = u.WaterPlants.GetTargetPosition()
		if typeof(Z) ~= "Vector3" then
			u.WaterPlants.SetStatus(i or "Target not found", "#CFCFCF")
			return 0
		end
		local c, J = u.WaterPlants.GetTool()
		if not c or type(J) ~= "table" then
			u.WaterPlants.SetStatus("Watering can not found", "#FFCC66")
			return 0
		end
		local d = tostring(J.Name or "")
		if d == "" then
			u.WaterPlants.SetStatus("Invalid watering can", "#FF5555")
			return 0
		end
		if not u.Player.IsToolHeld(c) then
			u.Player.UnequipTools()
			if not u.Player.EquipTool(c) then
				u.WaterPlants.SetStatus("Could not equip watering can", "#FF5555")
				return 0
			end
			u.WaterPlants.EquippedBySystem = true
			task.wait(.15)
		end
		if not u.Player.IsToolHeld(c) then
			u.WaterPlants.CleanupTool()
			u.WaterPlants.SetStatus("Watering can was unequipped", "#FF5555")
			return 0
		end
		local q, g, E = u.WaterPlants.EnsureNearTarget(Z)
		if not q then
			u.WaterPlants.CleanupTool()
			u.WaterPlants.SetStatus(E or "Could not reach target", "#FFCC66")
			return 0
		end
		u.WaterPlants.SetStatus("Watering " .. (tostring(j or "target") .. "..."), "#66CCFF")
		local a = u.WaterPlants.Use(Z, d, c)
		task.wait(.15)
		u.WaterPlants.CleanupTool()
		if g then
			u.Teleport.UnlockTeleport(T.TeleportLockNames.WaterPlants)
		end
		if not a then
			u.WaterPlants.SetStatus("Watering failed", "#FF5555")
			return 0
		end
		local H = math.max(math.floor(tonumber(J.EffectTime) or 1), 1)
		u.WaterPlants.LastCanName = d
		u.WaterPlants.LastTargetName = tostring(j or "Target")
		if e.water_plant_wait_effect then
			u.WaterPlants.NextUseAt = os.clock() + H
			u.WaterPlants.SetStatus(string.format("%s \226\134\146 %s | Wait %ds", d, u.WaterPlants.LastTargetName, H), "#7CFC00")
		else
			u.WaterPlants.NextUseAt = 0
			u.WaterPlants.SetStatus(string.format("%s \226\134\146 %s | Stacking", d, u.WaterPlants.LastTargetName), "#7CFC00")
		end
		return 1
	end;
	Loop = function()
		if not e.auto_water_plants then
			u.WaterPlants.ClearStatus()
			return 0
		end
		local G, V = pcall(u.WaterPlants.Run)
		if not G then
			u.WaterPlants.CleanupTool()
			u.Teleport.UnlockTeleport(T.TeleportLockNames.WaterPlants)
			u.WaterPlants.SetStatus("Error: watering loop failed", "#FF4444")
			warn("[WaterPlants] Loop error:", V)
			return 0
		end
		return tonumber(V) or 0
	end
}
J.PositionGrid = {
	Create = function(G)
		G = math.max(tonumber(G) or 1, .1)
		return {
			CellSize = G;
			Buckets = {}
		}
	end,
	Add = function(G, V)
		if type(G) ~= "table" or type(G.Buckets) ~= "table" or typeof(V) ~= "Vector3" then
			return false
		end
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
	end;
	IsOpen = function(G, V, y)
		if type(G) ~= "table" or type(G.Buckets) ~= "table" or typeof(V) ~= "Vector3" then
			return false
		end
		local Z = math.max(tonumber(G.CellSize) or 1, .1)
		y = math.max(tonumber(y) or Z, 0)
		local j = y * y
		local i = math.max(math.ceil(y / Z), 1)
		local c = math.floor(V.X / Z)
		local J = math.floor(V.Z / Z)
		for y = c - i, c + i, 1 do
			local Z = G.Buckets[y]
			if not Z then
				continue
			end
			for G = J - i, J + i, 1 do
				local y = Z[G]
				if not y then
					continue
				end
				for G, y in ipairs(y) do
					local Z = V.X - y.X
					local i = V.Z - y.Z
					local c = Z * Z + i * i
					if c < j then
						return false
					end
				end
			end
		end
		return true
	end
}
T.SeedPlaceStatusText = ""
u.Seeder = {
	MaxPerLoop = 30,
	MinPlantSpacing = 1.3;
	SpreadStep = 1.35;
	MaxPositionAttempts = 220;
	StackStep = .67;
	StackIndex = 0,
	HardGardenLimit = 1500,
	MaxFailedPlacements = 9;
	PrintCurrentStackLocation = function(G)
		local V = tostring(e.seed_place_mode or "Random")
		local y
		local Z
		local j
		if V == "Farm Middle" then
			local G, V, i = u.Farm.GetPermanentPlantPosition(.5)
			y = V
			Z = i and i.X
			j = i and i.Z
		elseif V == "Saved Position" then
			local G = e.seed_place_saved_position
			y = type(G) == "table" and u.Farm.GetPlantArea(G.area) or nil
			Z = type(G) == "table" and tonumber(G.x) or nil
			j = type(G) == "table" and tonumber(G.z) or nil
		end
		if not y or not Z or not j then
			return 0, 0
		end
		local i = u.Seeder.GetStackedPosition(y, Z, j, 0)
		if typeof(i) ~= "Vector3" then
			return 0, 0
		end
		local c = 0
		local J = 0
		for V, y in ipairs(u.Farm.GetPlants()) do
			local Z = u.Seeder.GetPlantPosition(y)
			if typeof(Z) ~= "Vector3" then
				continue
			end
			if G and typeof(G) == "Vector3" then
				local V = Z.X - G.X
				local y = Z.Z - G.Z
				if V * V + y * y > 4 then
					continue
				end
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
		local V, y = u.Seeder.PrintCurrentStackLocation(G)
		local Z = e.seed_place_stack_mode_underground and math.abs(V) or math.abs(y)
		local j = math.max(tonumber(u.Seeder.StackStep) or .67, .01)
		return math.max(math.round(Z / j) + 1, 1)
	end;
	GetGardenLimit = function()
		local G = math.floor(tonumber(e.seed_place_max_garden_plants) or u.Seeder.HardGardenLimit)
		return math.clamp(G, 0, u.Seeder.HardGardenLimit)
	end,
	GetStackedPosition = function(G, V, y, Z)
		if not G or not G:IsA("BasePart") then
			return nil
		end
		V = tonumber(V)
		y = tonumber(y)
		Z = math.max(math.floor(tonumber(Z) or 0), 0)
		if not V or not y then
			return nil
		end
		local j = Z * u.Seeder.StackStep
		local i = j
		if e.seed_place_stack_mode and e.seed_place_stack_mode_underground then
			i = - j
		end
		return G.CFrame:PointToWorldSpace(Vector3.new(V, i, y))
	end,
	GetSavedPositionText = function()
		local G = e.seed_place_saved_position
		if type(G) ~= "table" then
			return "\240\159\147\141 Saved Position: Not set"
		end
		local V = tostring(G.area or "")
		local y = tonumber(G.x)
		local Z = tonumber(G.z)
		if V == "" or not y or not Z then
			return "\240\159\147\141 Saved Position: Not set"
		end
		return string.format("\240\159\147\141 Saved Position: %s | X %.2f | Z %.2f", V, y, Z)
	end,
	GetPlantPosition = function(G)
		if not G or not G.Parent then
			return nil
		end
		if G:IsA("Model") then
			return (G:GetPivot()).Position
		end
		if G:IsA("BasePart") then
			return G.Position
		end
		return nil
	end,
	GetOccupiedPositions = function()
		local G = J.PositionGrid.Create(u.Seeder.MinPlantSpacing)
		for V, y in ipairs(u.Farm.GetPlants()) do
			local Z = u.Seeder.GetPlantPosition(y)
			if typeof(Z) == "Vector3" then
				J.PositionGrid.Add(G, Z)
			end
		end
		return G
	end;
	IsPositionOpen = function(G, V)
		return J.PositionGrid.IsOpen(V, G, u.Seeder.MinPlantSpacing)
	end,
	GetAreaPosition = function(G, V, y)
		if not G or not G:IsA("BasePart") then
			return nil
		end
		V = tonumber(V)
		y = tonumber(y)
		if not V or not y then
			return nil
		end
		return G.CFrame:PointToWorldSpace(Vector3.new(V, G.Size.Y / 2, y))
	end,
	IsInsidePlantArea = function(G, V, y, Z)
		if not G or not G:IsA("BasePart") then
			return false
		end
		Z = math.max(tonumber(Z) or .5, 0)
		local j = math.max(G.Size.X / 2 - Z, 0)
		local i = math.max(G.Size.Z / 2 - Z, 0)
		return math.abs(V) <= j and math.abs(y) <= i
	end,
	FindOpenPositionAround = function(G, V, y, Z)
		if not G or not G:IsA("BasePart") then
			return nil
		end
		V = tonumber(V)
		y = tonumber(y)
		if not V or not y then
			return nil
		end
		for j = 0, u.Seeder.MaxPositionAttempts, 1 do
			local i = V
			local c = y
			if j > 0 then
				local G = math.rad(j * 137.5)
				local V = u.Seeder.SpreadStep * math.sqrt(j)
				i += math.cos(G) * V
				c += math.sin(G) * V
			end
			if not u.Seeder.IsInsidePlantArea(G, i, c, .5) then
				continue
			end
			local J = u.Seeder.GetAreaPosition(G, i, c)
			if J and u.Seeder.IsPositionOpen(J, Z) then
				return J
			end
		end
		return nil
	end;
	GetRandomOpenPosition = function(G)
		for V = 1, u.Seeder.MaxPositionAttempts, 1 do
			local y = u.Farm.GetRandomLocationForSeed(.75)
			if y and u.Seeder.IsPositionOpen(y, G) then
				return y
			end
		end
		return nil
	end;
	BuildWallPositions = function()
		local G = {}
		local V = u.Seeder.SpreadStep
		for y, Z in ipairs(u.Farm.GetPlantAreas()) do
			local j = .75
			local i = math.max(Z.Size.X / 2 - j, 0)
			local c = math.max(Z.Size.Z / 2 - j, 0)
			local J = i * 2
			local T = c * 2
			local d = math.max(math.floor(J / V), 1)
			local q = math.max(math.floor(T / V), 1)
			for V = 0, d, 1 do
				for y = 0, q, 1 do
					local j = - i + J * ((V / d))
					local g = - c + T * ((y / q))
					local E = math.min(V, d - V, y, q - y)
					local a = u.Seeder.GetAreaPosition(Z, j, g)
					if a then
						table.insert(G, {
							position = a;
							depth = E;
							random = u.Farm._Random:NextNumber()
						})
					end
				end
			end
		end
		table.sort(G, function(G, V)
			if G.depth ~= V.depth then
				return G.depth < V.depth
			end
			return G.random < V.random
		end)
		return G
	end;
	GetWallPosition = function(G, V)
		if type(V) ~= "table" then
			return nil
		end
		for y, Z in ipairs(V) do
			local j = Z.position
			if u.Seeder.IsPositionOpen(j, G) then
				table.remove(V, y)
				return j
			end
		end
		return nil
	end;
	SetStatus = function(G, V)
		T.SeedPlaceStatusText = string.format("<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\140\177 [Seed Placer]</font> <font color=\'%s\'>%s</font></stroke>", tostring(V or "#FFFFFF"), tostring(G or "Waiting"))
	end;
	ClearStatus = function()
		T.SeedPlaceStatusText = ""
	end;
	GetDelay = function()
		return math.max(tonumber(e.seed_place_delay) or .3, .05)
	end,
	GetSeedNames = function()
		local G = {}
		for V, y in ipairs(T.AllSeedsDataTable) do
			local Z = type(y) == "table" and y.name
			if type(Z) == "string" and Z ~= "" then
				table.insert(G, Z)
			end
		end
		table.sort(G)
		return G
	end;
	GetOverrideTarget = function(G)
		if type(G) ~= "string" or G == "" then
			return nil
		end
		local V = e.seed_place_overrides
		if type(V) ~= "table" then
			return nil
		end
		local y = V[G]
		if type(y) == "number" then
			return math.max(math.floor(y), 0)
		end
		if type(y) ~= "table" or y.enabled ~= true then
			return nil
		end
		local Z = tonumber(y.target)
		if not Z then
			return nil
		end
		return math.max(math.floor(Z), 0)
	end,
	SetOverrideTarget = function(G, V)
		if type(G) ~= "string" or G == "" or not T.SeedDataFast[G] then
			return false
		end
		V = math.floor(tonumber(V) or 0)
		if V <= 0 then
			return false
		end
		if type(e.seed_place_overrides) ~= "table" then
			e.seed_place_overrides = {}
		end
		e.seed_place_overrides[G] = {
			enabled = true,
			target = V
		}
		return true
	end;
	RemoveOverrideTarget = function(G)
		if type(e.seed_place_overrides) ~= "table" then
			e.seed_place_overrides = {}
			return false
		end
		if e.seed_place_overrides[G] == nil then
			return false
		end
		e.seed_place_overrides[G] = nil
		return true
	end,
	GetTargetAmount = function(G)
		local V = u.Seeder.GetOverrideTarget(G)
		if V ~= nil then
			return V
		end
		return math.max(math.floor(tonumber(e.seed_place_default_target) or 10), 0)
	end;
	GetAllSeedSelection = function()
		local G = {}
		for V, y in ipairs(T.AllSeedsDataTable) do
			local Z = type(y) == "table" and y.name
			if type(Z) == "string" and Z ~= "" then
				G[Z] = true
			end
		end
		return G
	end;
	GetSeedTool = function(G)
		if type(G) ~= "string" or G == "" then
			return nil, 0
		end
		for V, y in ipairs(u.Backpack.GetBackpackAllItems()) do
			if y:IsA("Tool") and (y.Name == G and y:GetAttribute("SeedTool")) then
				return y, math.max(math.floor(tonumber(y:GetAttribute("Count")) or 0), 0)
			end
		end
		return nil, 0
	end,
	SaveCurrentPosition = function()
		local G = y.Character and y.Character:FindFirstChild("HumanoidRootPart")
		u.Seeder.StackIndex = 0
		if not G then
			return false, "Character not found"
		end
		local V, Z = u.Farm.GetPlantAreaAtPosition(G.Position)
		if not V or typeof(Z) ~= "Vector3" then
			return false, "Stand inside your farm"
		end
		e.seed_place_saved_position = {
			area = V.Name,
			x = Z and Z.X,
			z = Z and Z.Z
		}
		u.Seeder.StackIndex = 0
		q.Save.SaveDataSync()
		return true, "Planting position saved"
	end,
	GetPlacementPosition = function(G, V, y)
		local Z = tostring(e.seed_place_mode or "Random")
		if Z == "Random" then
			if e.seed_place_wall_mode then
				local y = u.Seeder.GetWallPosition(G, V)
				if not y then
					return nil, "No open wall positions found"
				end
				return y
			end
			local y = u.Seeder.GetRandomOpenPosition(G)
			if not y then
				return nil, "No open planting position found"
			end
			return y
		end
		if Z == "Farm Middle" then
			local V, Z, j = u.Farm.GetPermanentPlantPosition(.5)
			if not Z or typeof(j) ~= "Vector3" then
				return nil, "Farm middle not found"
			end
			if e.seed_place_stack_mode then
				return u.Seeder.GetStackedPosition(Z, j.X, j.Z, y)
			end
			local i = u.Seeder.FindOpenPositionAround(Z, j.X, j.Z, G)
			if not i then
				return nil, "No open position near farm middle"
			end
			return i
		end
		if Z == "Saved Position" then
			local V = e.seed_place_saved_position
			if type(V) ~= "table" then
				return nil, "Save a planting position"
			end
			local Z = u.Farm.GetPlantArea(V.area)
			local j = tonumber(V.x)
			local i = tonumber(V.z)
			if not Z or not j or not i then
				return nil, "Save a planting position"
			end
			if not u.Seeder.IsInsidePlantArea(Z, j, i, 0) then
				return nil, "Saved position is outside your farm"
			end
			if e.seed_place_stack_mode then
				return u.Seeder.GetStackedPosition(Z, j, i, y)
			end
			local c = u.Seeder.FindOpenPositionAround(Z, j, i, G)
			if not c then
				return nil, "No open position near saved location"
			end
			return c
		end
		return nil, "Invalid placement mode"
	end;
	GetCandidates = function()
		local G = {}
		local V = e.allowed_seedsplace
		local y = u.Farm.GetPlantedSeedCounts()
		local Z = 0
		local j = 0
		if type(V) ~= "table" then
			return G, y, Z, j
		end
		for V, i in pairs(V) do
			if i ~= true or type(V) ~= "string" or V == "" then
				continue
			end
			Z += 1
			local c = u.Seeder.GetTargetAmount(V)
			local J = math.max(math.floor(tonumber(y[V]) or 0), 0)
			local T = math.max(c - J, 0)
			if T <= 0 then
				continue
			end
			j += 1
			local d, q = u.Seeder.GetSeedTool(V)
			local g = math.min(T, q)
			if d and g > 0 then
				table.insert(G, {
					name = V;
					tool = d,
					planted = J,
					target = c;
					available = q;
					remaining = g
				})
			end
		end
		return G, y, Z, j
	end;
	PlaceSeed = function(G, V, Z)
		if type(G) ~= "string" or G == "" or typeof(V) ~= "Vector3" then
			return false
		end
		local j = y.Character
		if not j or not j.Parent then
			return false
		end
		if not Z or not Z:IsA("Tool") or Z.Parent ~= j then
			Z = j:FindFirstChild(G)
		end
		if not Z or not Z:IsA("Tool") then
			return false
		end
		local i = y.Networking and (y.Networking.Plant and y.Networking.Plant.PlantSeed)
		if not i or type(i.Fire) ~= "function" then
			return false
		end
		local c = math.max(math.floor(tonumber(Z:GetAttribute("Count")) or 0), 0)
		if c <= 0 then
			return false
		end
		local J = pcall(function()
			i:Fire(V, G, Z)
		end)
		if not J then
			return false
		end
		local T = os.clock() + .4
		repeat
			if not Z.Parent then
				return true, 0
			end
			local G = math.max(math.floor(tonumber(Z:GetAttribute("Count")) or 0), 0)
			if G < c then
				return true, G
			end
			task.wait()
		until os.clock() >= T
		return false, c
	end,
	Run = function()
		local G = u.Seeder.GetGardenLimit()
		local V = u.Farm.GetPlantedSeedTotalCount()
		if V >= u.Seeder.HardGardenLimit then
			u.Seeder.SetStatus(string.format("Game garden limit reached %d/%d", V, u.Seeder.HardGardenLimit), "#FF5555")
			return 0
		end
		if V >= G then
			u.Seeder.SetStatus(string.format("Selected garden limit reached %d/%d", V, G), "#FFCC66")
			return 0
		end
		local y, Z, j, i = u.Seeder.GetCandidates()
		if j <= 0 then
			u.Seeder.SetStatus("Paused: select seeds", "#FFCC66")
			return 0
		end
		if # y <= 0 then
			if i <= 0 then
				u.Seeder.SetStatus("All selected targets reached", "#7CFC00")
			else
				u.Seeder.SetStatus("Selected seeds not found", "#FFCC66")
			end
			return 0
		end
		local c = 0
		local T = false
		local d = u.Seeder.GetDelay()
		local q = tostring(e.seed_place_mode or "Random")
		local g = q
		local E = u.Seeder.GetOccupiedPositions()
		local a
		if q == "Random" and e.seed_place_wall_mode then
			g = "Random Wall"
			a = u.Seeder.BuildWallPositions()
		end
		local H = 0
		local r = math.max(math.floor(tonumber(u.Seeder.StackIndex) or 0), 0)
		local Y = 0
		local s = false
		while e.auto_seedplace and (# y > 0 and (H < u.Seeder.MaxPerLoop and V < G)) do
			local j = u.Farm._Random:NextInteger(1, # y)
			local i = y[j]
			local g, N = u.Seeder.GetPlacementPosition(E, a, r)
			if not g then
				u.Seeder.SetStatus(N or "Planting position unavailable", "#FF5555")
				break
			end
			local W, X = u.Seeder.GetSeedTool(i.name)
			if not W or X <= 0 or i.remaining <= 0 then
				table.remove(y, j)
				continue
			end
			if not u.Player.IsToolHeld(W) then
				if not u.Player.EquipTool(W) then
					table.remove(y, j)
					continue
				end
				T = true
				task.wait(.1)
			end
			if not u.Player.IsToolHeld(W) then
				table.remove(y, j)
				continue
			end
			if V >= G then
				u.Seeder.SetStatus(string.format("Garden limit reached %d/%d", V, G), "#FFCC66")
				break
			end
			H += 1
			local h, l = u.Seeder.PlaceSeed(i.name, g, W)
			if h then
				Y = 0
				J.PositionGrid.Add(E, g)
				V += 1
				if e.seed_place_stack_mode and ((q == "Saved Position" or q == "Farm Middle")) then
					r += 1
					u.Seeder.StackIndex = r
				end
				i.planted += 1
				i.available = tonumber(l) or math.max(i.available - 1, 0)
				i.remaining -= 1
				Z[i.name] = i.planted
				c += 1
				task.wait(d)
			else
				Y += 1
				if e.seed_place_stack_mode and ((q == "Saved Position" or q == "Farm Middle")) then
					local G = u.Seeder.GetDetectedStackIndex(g)
					r = math.max(r + 1, G)
					u.Seeder.StackIndex = r
				end
				u.Seeder.SetStatus(string.format("Placement not confirmed (%d/%d)", Y, u.Seeder.MaxFailedPlacements), "#FFCC66")
				J.PositionGrid.Add(E, g)
				if Y >= u.Seeder.MaxFailedPlacements then
					V = u.Farm.GetPlantedSeedTotalCount()
					s = true
					if V >= u.Seeder.HardGardenLimit then
						u.Seeder.SetStatus(string.format("Game garden limit reached %d/%d", V, u.Seeder.HardGardenLimit), "#FF5555")
					else
						u.Seeder.SetStatus(string.format("Server did not confirm placement | Garden %d/%d", V, u.Seeder.HardGardenLimit), "#FF5555")
					end
					break
				end
				task.wait(.05)
				continue
			end
			if i.remaining <= 0 or i.available <= 0 then
				table.remove(y, j)
			end
		end
		if T then
			u.Player.UnequipTools()
		end
		V = u.Farm.GetPlantedSeedTotalCount()
		if not e.auto_seedplace then
			u.Seeder.ClearStatus()
		elseif V >= u.Seeder.HardGardenLimit then
			u.Seeder.SetStatus(string.format("Game garden limit reached %d/%d", V, u.Seeder.HardGardenLimit), "#FF5555")
		elseif V >= G then
			u.Seeder.SetStatus(string.format("Selected garden limit reached %d/%d", V, G), "#FFCC66")
		elseif c > 0 and not s then
			u.Seeder.SetStatus(string.format("Placed %d seed%s | Waiting", c, c == 1 and "" or "s"), "#7CFC00")
		end
		return c
	end,
	SeedPlaceLoop = function()
		if not e.auto_seedplace then
			u.Seeder.ClearStatus()
			return 0
		end
		local G, V = pcall(u.Seeder.Run)
		if not G then
			u.Player.UnequipTools()
			u.Seeder.SetStatus("Error: seed placer failed", "#FF4444")
			warn("[Seeder] Loop error:", V)
			return 0
		end
		return tonumber(V) or 0
	end
}
T.GiftSystemStatusText = ""
T.GiftSystemUi = T.GiftSystemUi or {}
u.GiftSystem = {
	StartedGiftSystem = false;
	SenderBusyGiftSystem = false;
	DropBusyGiftSystem = false;
	LastSendAtGiftSystem = 0;
	PlayerConnectionsGiftSystem = {};
	SetStatusGiftSystem = function(G, V)
		if type(G) ~= "string" or G == "" then
			T.GiftSystemStatusText = ""
			return false
		end
		T.GiftSystemStatusText = string.format("<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\142\129 [Gift]</font> <font color=\'%s\'>%s</font></stroke>", tostring(V or "#FFFFFF"), G)
		return true
	end,
	ClearStatusGiftSystem = function()
		T.GiftSystemStatusText = ""
	end;
	GetModeValuesGiftSystem = function()
		return {
			"Trusted Only",
			"Anyone"
		}
	end;
	GetSendOrderValuesGiftSystem = function()
		return {
			"Lowest Weight First",
			"Highest Weight First";
			"Name A-Z",
			"Mutation First",
			"Normal First"
		}
	end,
	GetDropCategoryValuesGiftSystem = function()
		return {
			"HarvestedFruits",
			"Seeds";
			"Crates";
			"Sprinklers";
			"WateringCans";
			"Gnomes",
			"Mushrooms"
		}
	end,
	GetPlayerDropdownGiftSystem = function(G)
		local V = {}
		for Z, j in ipairs(y.Players:GetPlayers()) do
			if G and j == y.LocalPlayer then
				continue
			end
			local i = tostring(j.UserId or "")
			local c = tostring(j.Name or "")
			if i ~= "" and c ~= "" then
				table.insert(V, {
					Text = string.format("%s <font color=\'#888888\'>(%s)</font>", c, i);
					Value = i
				})
			end
		end
		table.sort(V, function(G, V)
			return tostring(G.Text or "") < tostring(V.Text or "")
		end)
		return V
	end;
	IsSelectedGiftSystem = function(G, V)
		if u.FruitFilters and type(u.FruitFilters.IsSelected) == "function" then
			return u.FruitFilters.IsSelected(G, V)
		end
		V = tostring(V or "")
		if V == "" or type(G) ~= "table" then
			return false
		end
		if G[V] ~= nil and G[V] ~= false then
			return true
		end
		for G, y in pairs(G) do
			if type(G) == "number" and tostring(y or "") == V then
				return true
			end
			if tostring(G or "") == V and (y ~= nil and y ~= false) then
				return true
			end
		end
		return false
	end,
	IsSelectionEmptyGiftSystem = function(G)
		if u.FruitFilters and type(u.FruitFilters.IsSelectionEmpty) == "function" then
			return u.FruitFilters.IsSelectionEmpty(G)
		end
		if type(G) ~= "table" then
			return true
		end
		for G, V in pairs(G) do
			if V ~= nil and (V ~= false and tostring(V) ~= "") then
				return false
			end
		end
		return true
	end;
	GetSelectedPlayerGiftSystem = function(G)
		if type(G) ~= "table" then
			return nil
		end
		for V, Z in ipairs(y.Players:GetPlayers()) do
			if Z ~= y.LocalPlayer then
				local V = tostring(Z.UserId or "")
				local y = tostring(Z.Name or "")
				if u.GiftSystem.IsSelectedGiftSystem(G, V) or u.GiftSystem.IsSelectedGiftSystem(G, y) then
					return Z
				end
			end
		end
		return nil
	end;
	BuildBackpackFruitDataGiftSystem = function(G)
		if typeof(G) ~= "Instance" or not G.Parent then
			return nil
		end
		local V = G:IsA("Tool") and G:GetAttribute("HarvestedFruit") == true
		local y = G:IsA("Configuration") and (G:GetAttribute("FruitProxy") == true and G:GetAttribute("HarvestedFruit") == true)
		if not V and not y then
			return nil
		end
		local Z = u.SellManager and (u.SellManager.BuildBackpackFruitData and u.SellManager.BuildBackpackFruitData(G)) or nil
		if type(Z) ~= "table" then
			return nil
		end
		Z.ob = G
		Z.id = tostring(Z.id or G:GetAttribute("Id") or "")
		Z.name = tostring(Z.name or Z.n or G:GetAttribute("FruitName") or G:GetAttribute("Fruit") or "")
		Z.n = Z.name
		if Z.id == "" or Z.name == "" then
			return nil
		end
		local j, i = u.FruitFilters.GetMutationLookup(Z)
		Z.v = u.FruitFilters.GetFruitVariant(Z, i)
		return Z
	end,
	IsFavouriteFruitGiftSystem = function(G)
		local V = type(G) == "table" and G.ob or nil
		if typeof(V) ~= "Instance" then
			return false
		end
		return V:GetAttribute("IsFavorite") == true or V:GetAttribute("Favorite") == true or V:GetAttribute("Favourite") == true or V:GetAttribute("Favorited") == true or V:GetAttribute("Favourited") == true
	end;
	GetBackpackFruitsGiftSystem = function()
		local G = {}
		for V, y in ipairs(u.Backpack.GetBackpackAllItems()) do
			local Z = u.GiftSystem.BuildBackpackFruitDataGiftSystem(y)
			if Z then
				table.insert(G, Z)
			end
		end
		return G
	end,
	GetFruitCountsGiftSystem = function(G)
		local V = {}
		for G, y in ipairs(type(G) == "table" and G or {}) do
			local Z = tostring(y.name or y.n or "")
			if Z ~= "" then
				V[Z] = ((V[Z] or 0)) + 1
			end
		end
		return V
	end;
	PassesFruitFiltersGiftSystem = function(G)
		if type(G) ~= "table" then
			return false
		end
		local V = tostring(G.name or G.n or "")
		if V == "" or tostring(G.id or "") == "" then
			return false
		end
		if e.gift_protect_favourites and u.GiftSystem.IsFavouriteFruitGiftSystem(G) then
			return false
		end
		if not u.FruitFilters.IsSelectionEmpty(e.gift_fruit_list) then
			if not u.FruitFilters.IsSelected(e.gift_fruit_list, V) then
				return false
			end
		end
		if G.has_weight == false or tonumber(G.w) == nil or ((tonumber(G.w) or 0)) <= 0 then
			return false
		end
		if not u.FruitFilters.PassesWeightRange(G.w, e.gift_min_weight, e.gift_max_weight) then
			return false
		end
		local y, Z = u.FruitFilters.GetMutationLookup(G)
		if not u.FruitFilters.PassesMutationSelection(Z, e.gift_mutation_whitelist, e.gift_mutation_blacklist) then
			return false
		end
		local j = u.FruitFilters.GetFruitVariant(G, Z)
		if not u.FruitFilters.PassesVariantSelection(j, e.gift_variant_whitelist, e.gift_variant_blacklist) then
			return false
		end
		return true
	end;
	SortFruitsGiftSystem = function(G)
		local V = tostring(e.gift_send_order or "Lowest Weight First")
		table.sort(G, function(G, y)
			local Z = tonumber(G.w) or 0
			local j = tonumber(y.w) or 0
			if V == "Highest Weight First" then
				if Z ~= j then
					return Z > j
				end
			elseif V == "Name A-Z" then
				if tostring(G.name or "") ~= tostring(y.name or "") then
					return tostring(G.name or "") < tostring(y.name or "")
				end
			elseif V == "Mutation First" then
				local V = tostring(G.m or "") ~= ""
				local Z = tostring(y.m or "") ~= ""
				if V ~= Z then
					return V
				end
			elseif V == "Normal First" then
				local V = tostring(G.v or "Normal") == "Normal"
				local Z = tostring(y.v or "Normal") == "Normal"
				if V ~= Z then
					return V
				end
			else
				if Z ~= j then
					return Z < j
				end
			end
			return tostring(G.id or "") < tostring(y.id or "")
		end)
	end;
	GetFilteredFruitsGiftSystem = function()
		local G = u.GiftSystem.GetBackpackFruitsGiftSystem()
		local V = {}
		local y = u.GiftSystem.GetFruitCountsGiftSystem(G)
		local Z = {}
		local j = math.max(math.floor(tonumber(e.gift_keep_amount_per_fruit) or 0), 0)
		u.GiftSystem.SortFruitsGiftSystem(G)
		for G, i in ipairs(G) do
			if not u.GiftSystem.PassesFruitFiltersGiftSystem(i) then
				continue
			end
			local c = tostring(i.name or i.n or "")
			local J = y[c] or 0
			local T = Z[c] or 0
			if j > 0 and T >= math.max(J - j, 0) then
				continue
			end
			Z[c] = T + 1
			table.insert(V, i)
		end
		return V, # G
	end,
	FruitStillExistsGiftSystem = function(G)
		G = tostring(G or "")
		if G == "" then
			return false
		end
		for V, y in ipairs(u.GiftSystem.GetBackpackFruitsGiftSystem()) do
			if tostring(y.id or "") == G then
				return true
			end
		end
		return false
	end,
	WaitForFruitGoneGiftSystem = function(G, V)
		G = tostring(G or "")
		V = math.max(tonumber(V) or 8, 1)
		if G == "" then
			return false
		end
		local y = os.clock()
		repeat
			if not u.GiftSystem.FruitStillExistsGiftSystem(G) then
				return true
			end
			task.wait(.2)
		until os.clock() - y >= V
		return false
	end,
	SendFruitGiftSystem = function(G, V)
		if not G or not G:IsDescendantOf(y.Players) then
			return false, "Target left server"
		end
		if type(V) ~= "table" or tostring(V.id or "") == "" then
			return false, "Invalid fruit"
		end
		local Z = y.Networking and (y.Networking.Gifting and y.Networking.Gifting.Send)
		if not Z or type(Z.Fire) ~= "function" then
			return false, "Gift remote missing"
		end
		if e.gift_preview_only then
			return true, "Preview"
		end
		local j = V.ob
		if typeof(j) == "Instance" and j.Parent then
			u.Player.EquipTool(j)
			task.wait(.1)
		end
		local i, c = pcall(function()
			Z:Fire(G.UserId, "HarvestedFruits", tostring(V.id))
		end)
		if not i then
			return false, tostring(c or "Gift failed")
		end
		if not u.GiftSystem.WaitForFruitGoneGiftSystem(V.id, e.gift_wait_timeout) then
			return false, "Not accepted yet"
		end
		return true, "Sent"
	end;
	ProcessSenderGiftSystem = function()
		if not e.gift_send_enabled then
			return false
		end
		if u.GiftSystem.SenderBusyGiftSystem then
			return false
		end
		if not J.IsLoadingCompleted() then
			u.GiftSystem.SetStatusGiftSystem("Waiting for loading", "#FFCC66")
			return false
		end
		local G = math.clamp(tonumber(e.gift_delay) or 1.25, .35, 30)
		if os.clock() - u.GiftSystem.LastSendAtGiftSystem < G then
			return false
		end
		local V = u.GiftSystem.GetSelectedPlayerGiftSystem(e.gift_send_targets)
		if not V then
			u.GiftSystem.SetStatusGiftSystem("Waiting for selected alt", "#FFCC66")
			return false
		end
		local y, Z = u.GiftSystem.GetFilteredFruitsGiftSystem()
		local j = math.max(math.floor(tonumber(e.gift_only_when_backpack_over) or 0), 0)
		if j > 0 and Z <= j then
			u.GiftSystem.SetStatusGiftSystem("Paused: backpack below limit", "#CFCFCF")
			return false
		end
		if # y == 0 then
			u.GiftSystem.SetStatusGiftSystem("No fruits match filters", "#FFCC66")
			return false
		end
		local i = math.clamp(math.floor(tonumber(e.gift_max_per_cycle) or 1), 1, 25)
		u.GiftSystem.SenderBusyGiftSystem = true
		local c, T = pcall(function()
			local Z = 0
			local j = 0
			for y, c in ipairs(y) do
				if Z >= i then
					break
				end
				if not e.gift_send_enabled then
					break
				end
				local J = u.GiftSystem.BuildBackpackFruitDataGiftSystem(c.ob)
				if not J or not u.GiftSystem.PassesFruitFiltersGiftSystem(J) then
					continue
				end
				j += 1
				local T, d = u.GiftSystem.SendFruitGiftSystem(V, J)
				if T then
					Z += 1
					u.GiftSystem.SetStatusGiftSystem(string.format("%s %s to %s", tostring(d), tostring(J.name), V.Name), e.gift_preview_only and "#CFCFCF" or "#66FF99")
				else
					u.GiftSystem.SetStatusGiftSystem(tostring(d or "Gift failed"), "#FF6666")
					break
				end
				u.GiftSystem.LastSendAtGiftSystem = os.clock()
				task.wait(G)
			end
			if Z == 0 and j == 0 then
				u.GiftSystem.SetStatusGiftSystem("No safe fruit ready", "#FFCC66")
			end
			return Z
		end)
		u.GiftSystem.SenderBusyGiftSystem = false
		if not c then
			u.GiftSystem.SetStatusGiftSystem("Sender error", "#FF6666")
			warn("[GiftSystem Sender]", T)
			return false
		end
		return T and T > 0
	end,
	IsTrustedGiftSenderGiftSystem = function(G)
		if not G or not G:IsDescendantOf(y.Players) then
			return false
		end
		local V = tostring(e.gift_receive_mode or "Trusted Only")
		if V == "Anyone" then
			return true
		end
		local Z = tostring(G.UserId or "")
		local j = tostring(G.Name or "")
		return u.GiftSystem.IsSelectedGiftSystem(e.gift_receive_trusted, Z) or u.GiftSystem.IsSelectedGiftSystem(e.gift_receive_trusted, j)
	end,
	CanAcceptItemNameGiftSystem = function(G)
		G = tostring(G or "")
		if G == "" then
			return false
		end
		if u.GiftSystem.IsSelectionEmptyGiftSystem(e.gift_receive_item_whitelist) then
			return true
		end
		return u.GiftSystem.IsSelectedGiftSystem(e.gift_receive_item_whitelist, G)
	end,
	HideGiftPromptGiftSystem = function()
		local G = y.PlayerGui
		local V = G and G:FindFirstChild("Gifting")
		if V then
			V.Enabled = false
		end
	end;
	ProcessPromptGiftSystem = function(G, V)
		if not e.gift_receive_enabled then
			return false
		end
		if not u.GiftSystem.IsTrustedGiftSenderGiftSystem(G) then
			u.GiftSystem.SetStatusGiftSystem("Ignored gift from untrusted player", "#FFCC66")
			return false
		end
		if not u.GiftSystem.CanAcceptItemNameGiftSystem(V) then
			u.GiftSystem.SetStatusGiftSystem("Ignored gift item", "#FFCC66")
			return false
		end
		local Z = y.Networking and (y.Networking.Gifting and y.Networking.Gifting.Response)
		if not Z or type(Z.Fire) ~= "function" then
			u.GiftSystem.SetStatusGiftSystem("Accept remote missing", "#FF6666")
			return false
		end
		task.spawn(function()
			task.wait(.15)
			local V, y = pcall(function()
				Z:Fire(G, true)
			end)
			if V then
				u.GiftSystem.HideGiftPromptGiftSystem()
				u.GiftSystem.SetStatusGiftSystem("Accepted from " .. tostring(G.Name or "player"), "#66FF99")
			else
				u.GiftSystem.SetStatusGiftSystem("Accept failed", "#FF6666")
				warn("[GiftSystem Receiver]", y)
			end
		end)
		return true
	end;
	IsAllowedDropSourceGiftSystem = function(G)
		if not G or G.Parent ~= y.DroppedItems then
			return false
		end
		local V = tostring(e.gift_drop_pickup_mode or "Trusted Only")
		if V == "Anyone" then
			return true
		end
		local Z = tostring(G:GetAttribute("DroppedBy") or "")
		if Z == "" then
			return false
		end
		return u.GiftSystem.IsSelectedGiftSystem(e.gift_drop_pickup_from, Z)
	end,
	IsAllowedDropCategoryGiftSystem = function(G)
		if not G or G.Parent ~= y.DroppedItems then
			return false
		end
		local V = tostring(G:GetAttribute("ItemCategory") or "")
		if V == "" then
			return false
		end
		if u.GiftSystem.IsSelectionEmptyGiftSystem(e.gift_drop_pickup_categories) then
			return false
		end
		return u.GiftSystem.IsSelectedGiftSystem(e.gift_drop_pickup_categories, V)
	end;
	ClaimDroppedItemGiftSystem = function(G)
		if not e.gift_drop_pickup_enabled or u.GiftSystem.DropBusyGiftSystem then
			return false
		end
		if not u.GiftSystem.IsAllowedDropCategoryGiftSystem(G) or not u.GiftSystem.IsAllowedDropSourceGiftSystem(G) then
			return false
		end
		local V = u.ProximityPrompt.FindProximityPromptByClass(G)
		if not V or not V.Enabled then
			return false
		end
		u.GiftSystem.DropBusyGiftSystem = true
		local y = T.TeleportLockNames.GiftDropPickup
		local Z = u.Teleport.LockTeleport(y, e.gift_drop_pickup_use_player_walk and 35 or 2, e.gift_drop_pickup_use_player_walk == true)
		if not Z then
			u.GiftSystem.DropBusyGiftSystem = false
			return false
		end
		local j, i = pcall(function()
			if e.gift_drop_pickup_use_player_walk then
				if not u.Movement.WalkPathToTarget(G, 30, y, 10) then
					return false
				end
			else
				if not u.Teleport.TeleportTo(G, true, y) then
					return false
				end
			end
			task.wait(.05)
			if not V.Parent or not u.GiftSystem.IsAllowedDropCategoryGiftSystem(G) or not u.GiftSystem.IsAllowedDropSourceGiftSystem(G) then
				return false
			end
			u.ProximityPrompt.ActivateProximityPrompt(V)
			u.GiftSystem.SetStatusGiftSystem("Picked dropped item", "#66FF99")
			return true
		end)
		u.Teleport.UnlockTeleport(y)
		u.GiftSystem.DropBusyGiftSystem = false
		if not j then
			u.GiftSystem.SetStatusGiftSystem("Drop pickup failed", "#FF6666")
			warn("[GiftSystem Drop]", i)
			return false
		end
		return i == true
	end;
	RefreshPlayerDropdownsGiftSystem = function()
		local G = u.GiftSystem.GetPlayerDropdownGiftSystem(true)
		if T.GiftSystemUi.SendTargetsDropdown then
			T.GiftSystemUi.SendTargetsDropdown:SetValues(G)
			T.GiftSystemUi.SendTargetsDropdown:SetValue(e.gift_send_targets)
		end
		if T.GiftSystemUi.ReceiveTrustedDropdown then
			T.GiftSystemUi.ReceiveTrustedDropdown:SetValues(G)
			T.GiftSystemUi.ReceiveTrustedDropdown:SetValue(e.gift_receive_trusted)
		end
		if T.GiftSystemUi.DropTrustedDropdown then
			T.GiftSystemUi.DropTrustedDropdown:SetValues(G)
			T.GiftSystemUi.DropTrustedDropdown:SetValue(e.gift_drop_pickup_from)
		end
	end;
	UiGiftSystem = function(G)
		if not G then
			return false
		end
		local V = G:AddLeftGroupbox("Fruit Gift", "gift")
		local y = G:AddLeftGroupbox("Gift Receiver", "badge-check")
		local Z = G:AddRightGroupbox("Gift Drop Pickup", "package-check")
		if V then
			V:AddLabel({
				Text = "\240\159\142\129 Sends filtered backpack fruits to a selected server player. Keep Preview Only on until the list looks right.",
				DoesWrap = true
			})
			T.GiftSystemUi.SendTargetsDropdown = V:AddValueDropdown("gift_send_targets_ui", {
				Values = u.GiftSystem.GetPlayerDropdownGiftSystem(true),
				Default = {},
				Multi = true,
				Searchable = true,
				MaxVisibleDropdownItems = 8;
				Text = "\240\159\145\164 Send To",
				Tooltip = "Select the alt or player that should receive fruits.";
				Changed = function(G)
					if type(G) ~= "table" then
						return
					end
					e.gift_send_targets = G
					q.Save.SaveDataSync()
				end
			})
			T.GiftSystemUi.SendTargetsDropdown:SetValue(e.gift_send_targets)
			local G
			G = V:AddValueDropdown("gift_fruit_list_ui", {
				Values = u.SeedData.GetSeedDataListDropDown();
				Default = {};
				Multi = true;
				Searchable = true;
				MaxVisibleDropdownItems = 10;
				Text = "\240\159\141\142 Fruits To Gift";
				Tooltip = "Empty allows all fruits that pass the filters.";
				Changed = function(G)
					if type(G) ~= "table" then
						return
					end
					e.gift_fruit_list = G
					q.Save.SaveDataSync()
				end
			})
			G:SetValue(e.gift_fruit_list)
			V:AddButton({
				Text = "\226\153\187\239\184\143 Refresh Players";
				Tooltip = "Refreshes server player lists.";
				Func = function()
					u.GiftSystem.RefreshPlayerDropdownsGiftSystem()
				end
			})
			V:AddToggle("gift_preview_only_ui", {
				Text = "\240\159\145\128 Preview Only";
				Default = e.gift_preview_only,
				Tooltip = "Shows what would be gifted without sending fruits.";
				Callback = function(G)
					e.gift_preview_only = G
					q.Save.SaveDataSync()
				end
			})
			local y
			local Z
			local function j(G)
				local V = m(G)
				if not V then
					V = tonumber(e.gift_min_weight) or 0
				end
				return string.format("\226\172\135\239\184\143 Min Gift %.2fKG", V)
			end
			local function i(G)
				local V = m(G)
				if not V then
					V = tonumber(e.gift_max_weight) or 89
				end
				return string.format("\226\172\134\239\184\143 Max Gift %.2fKG", V)
			end
			y = V:AddInput("gift_min_weight_ui", {
				Text = j(e.gift_min_weight),
				Default = tostring(e.gift_min_weight);
				Numeric = true,
				AllowEmpty = true;
				Finished = true,
				ClearTextOnFocus = false;
				Placeholder = "Press Enter to update",
				Tooltip = "Press Enter to update. Fruits below this KG will not be gifted.";
				Changed = function(G)
					if y then
						y:SetText(j(G))
					end
				end;
				Callback = function(G)
					local V = m(G)
					if not V or V < 0 then
						T.Notify("Invalid minimum gift KG", 3)
						y:SetValue(tostring(e.gift_min_weight))
						y:SetText(j(e.gift_min_weight))
						return
					end
					if V > ((tonumber(e.gift_max_weight) or 89)) then
						T.Notify("Minimum gift KG must be lower than maximum KG", 3)
						y:SetValue(tostring(e.gift_min_weight))
						y:SetText(j(e.gift_min_weight))
						return
					end
					e.gift_min_weight = u.FruitFilters.RoundWeight(V)
					y:SetText(j(e.gift_min_weight))
					q.Save.SaveDataSync()
				end
			})
			Z = V:AddInput("gift_max_weight_ui", {
				Text = i(e.gift_max_weight);
				Default = tostring(e.gift_max_weight);
				Numeric = true;
				AllowEmpty = true,
				Finished = true,
				ClearTextOnFocus = false,
				Placeholder = "Press Enter to update";
				Tooltip = "Press Enter to update. Fruits above this KG will not be gifted.",
				Changed = function(G)
					if Z then
						Z:SetText(i(G))
					end
				end,
				Callback = function(G)
					local V = m(G)
					if not V or V < 0 then
						T.Notify("Invalid maximum gift KG", 3)
						Z:SetValue(tostring(e.gift_max_weight))
						Z:SetText(i(e.gift_max_weight))
						return
					end
					if V < ((tonumber(e.gift_min_weight) or 0)) then
						T.Notify("Maximum gift KG must be higher than minimum KG", 3)
						Z:SetValue(tostring(e.gift_max_weight))
						Z:SetText(i(e.gift_max_weight))
						return
					end
					e.gift_max_weight = u.FruitFilters.RoundWeight(V)
					Z:SetText(i(e.gift_max_weight))
					q.Save.SaveDataSync()
				end
			})
			local c
			c = V:AddInput("gift_keep_amount_ui", {
				Text = "\240\159\148\146 Keep Per Fruit";
				Default = tostring(e.gift_keep_amount_per_fruit);
				Numeric = true,
				AllowEmpty = true,
				Finished = true;
				ClearTextOnFocus = false,
				Placeholder = "Amount to keep";
				Tooltip = "Keeps this many of each fruit name in backpack.",
				Callback = function(G)
					local V = L(G)
					if V == nil or V < 0 then
						T.Notify("Keep amount must be 0 or more", 3)
						c:SetValue(tostring(e.gift_keep_amount_per_fruit))
						return
					end
					e.gift_keep_amount_per_fruit = math.clamp(V, 0, 999)
					q.Save.SaveDataSync()
				end
			})
			local J
			J = V:AddInput("gift_max_per_cycle_ui", {
				Text = "\240\159\148\162 Max Per Cycle";
				Default = tostring(e.gift_max_per_cycle),
				Numeric = true;
				AllowEmpty = true,
				Finished = true,
				ClearTextOnFocus = false;
				Placeholder = "Fruits per cycle",
				Tooltip = "Maximum fruits gifted each cycle.",
				Callback = function(G)
					local V = L(G)
					if not V or V <= 0 then
						T.Notify("Max per cycle must be above 0", 3)
						J:SetValue(tostring(e.gift_max_per_cycle))
						return
					end
					e.gift_max_per_cycle = math.clamp(V, 1, 25)
					q.Save.SaveDataSync()
				end
			})
			local d
			d = V:AddInput("gift_delay_ui", {
				Text = "\226\143\177\239\184\143 Gift Delay";
				Default = tostring(e.gift_delay);
				Numeric = true;
				AllowEmpty = true;
				Finished = true,
				ClearTextOnFocus = false;
				Placeholder = "Seconds",
				Tooltip = "Delay between each fruit gift.";
				Callback = function(G)
					local V = m(G)
					if not V or V < .35 then
						T.Notify("Gift delay must be 0.35 or more", 3)
						d:SetValue(tostring(e.gift_delay))
						return
					end
					e.gift_delay = math.clamp(V, .35, 30)
					q.Save.SaveDataSync()
				end
			})
			local g
			g = V:AddDropdown("gift_send_order_ui", {
				Values = u.GiftSystem.GetSendOrderValuesGiftSystem();
				Default = e.gift_send_order,
				Multi = false;
				Text = "\226\134\149\239\184\143 Send Order";
				Tooltip = "Choose which matching fruits are sent first.";
				Callback = function(G)
					if type(G) ~= "string" or G == "" then
						return
					end
					e.gift_send_order = G
					q.Save.SaveDataSync()
				end
			})
			g:SetValue(e.gift_send_order)
			V:AddToggle("gift_protect_favourites_ui", {
				Text = "\226\173\144 Protect Favourites",
				Default = e.gift_protect_favourites,
				Tooltip = "Favourite fruits will not be gifted.";
				Callback = function(G)
					e.gift_protect_favourites = G
					q.Save.SaveDataSync()
				end
			})
			V:AddToggle("gift_send_enabled_ui", {
				Text = "\240\159\142\129 Enable Fruit Gift";
				Default = e.gift_send_enabled;
				Tooltip = "Automatically gifts backpack fruits that pass the filters.",
				Callback = function(G)
					e.gift_send_enabled = G
					if not G then
						u.GiftSystem.SenderBusyGiftSystem = false
					end
					q.Save.SaveDataSync()
				end
			})
			V:AddDivider()
			local E
			E = V:AddValueDropdown("gift_mutation_whitelist_ui", {
				Values = u.FruitFilters.GetMutationNames();
				Default = {};
				Multi = true;
				Text = "\226\156\133 Only Mutations",
				Tooltip = "Only gift fruits with selected mutations. Empty allows all mutations.";
				Searchable = true,
				MaxVisibleDropdownItems = 10,
				Changed = function(G)
					if type(G) ~= "table" then
						return
					end
					e.gift_mutation_whitelist = G
					q.Save.SaveDataSync()
				end
			})
			E:SetValue(e.gift_mutation_whitelist)
			local a
			a = V:AddValueDropdown("gift_mutation_blacklist_ui", {
				Values = u.FruitFilters.GetMutationNames(),
				Default = {};
				Multi = true;
				Text = "\226\155\148 Protect Mutations",
				Tooltip = "Selected mutations will not be gifted.",
				Searchable = true;
				MaxVisibleDropdownItems = 10;
				Changed = function(G)
					if type(G) ~= "table" then
						return
					end
					e.gift_mutation_blacklist = G
					q.Save.SaveDataSync()
				end
			})
			a:SetValue(e.gift_mutation_blacklist)
			local H
			H = V:AddValueDropdown("gift_variant_whitelist_ui", {
				Values = u.FruitFilters.GetVariantNames(),
				Default = {};
				Multi = true,
				Text = "\226\156\133 Only Variants";
				Tooltip = "Only gift selected variants. Empty allows all variants.",
				Searchable = false;
				MaxVisibleDropdownItems = 5,
				Changed = function(G)
					if type(G) ~= "table" then
						return
					end
					e.gift_variant_whitelist = G
					q.Save.SaveDataSync()
				end
			})
			H:SetValue(e.gift_variant_whitelist)
			local r
			r = V:AddValueDropdown("gift_variant_blacklist_ui", {
				Values = u.FruitFilters.GetVariantNames();
				Default = {};
				Multi = true,
				Text = "\240\159\155\161\239\184\143 Protect Variants";
				Tooltip = "Selected variants will not be gifted.";
				Searchable = false;
				MaxVisibleDropdownItems = 5;
				Changed = function(G)
					if type(G) ~= "table" then
						return
					end
					e.gift_variant_blacklist = G
					q.Save.SaveDataSync()
				end
			})
			r:SetValue(e.gift_variant_blacklist)
		end
		if y then
			y:AddLabel({
				Text = "\226\156\133 Auto accepts gift prompts. Trusted Only is safest for alts.",
				DoesWrap = true
			})
			local G
			G = y:AddDropdown("gift_receive_mode_ui", {
				Values = u.GiftSystem.GetModeValuesGiftSystem(),
				Default = e.gift_receive_mode,
				Multi = false;
				Text = "\240\159\155\161\239\184\143 Accept Mode";
				Tooltip = "Trusted Only accepts from selected users. Anyone accepts every gift prompt.";
				Callback = function(G)
					if type(G) ~= "string" or G == "" then
						return
					end
					e.gift_receive_mode = G
					q.Save.SaveDataSync()
				end
			})
			G:SetValue(e.gift_receive_mode)
			T.GiftSystemUi.ReceiveTrustedDropdown = y:AddValueDropdown("gift_receive_trusted_ui", {
				Values = u.GiftSystem.GetPlayerDropdownGiftSystem(true);
				Default = {},
				Multi = true,
				Searchable = true,
				MaxVisibleDropdownItems = 8,
				Text = "\240\159\164\157 Trusted Senders",
				Tooltip = "Selected players can be auto accepted in Trusted Only mode.";
				Changed = function(G)
					if type(G) ~= "table" then
						return
					end
					e.gift_receive_trusted = G
					q.Save.SaveDataSync()
				end
			})
			T.GiftSystemUi.ReceiveTrustedDropdown:SetValue(e.gift_receive_trusted)
			y:AddButton({
				Text = "\226\153\187\239\184\143 Refresh Trusted",
				Tooltip = "Refreshes server player lists.",
				Func = function()
					u.GiftSystem.RefreshPlayerDropdownsGiftSystem()
				end
			})
			y:AddToggle("gift_receive_enabled_ui", {
				Text = "\226\156\133 Auto Accept Gifts";
				Default = e.gift_receive_enabled;
				Tooltip = "Automatically accepts gifts using the selected accept mode.";
				Callback = function(G)
					e.gift_receive_enabled = G
					q.Save.SaveDataSync()
				end
			})
		end
		if Z then
			Z:AddLabel({
				Text = "\240\159\147\166 Picks dropped items by category and source. Keep this off unless you need drop transfer.",
				DoesWrap = true
			})
			local G
			G = Z:AddDropdown("gift_drop_pickup_mode_ui", {
				Values = u.GiftSystem.GetModeValuesGiftSystem();
				Default = e.gift_drop_pickup_mode,
				Multi = false,
				Text = "\240\159\155\161\239\184\143 Pickup Mode";
				Tooltip = "Trusted Only picks drops from selected users. Anyone picks allowed categories from all users.";
				Callback = function(G)
					if type(G) ~= "string" or G == "" then
						return
					end
					e.gift_drop_pickup_mode = G
					q.Save.SaveDataSync()
				end
			})
			G:SetValue(e.gift_drop_pickup_mode)
			T.GiftSystemUi.DropTrustedDropdown = Z:AddValueDropdown("gift_drop_pickup_from_ui", {
				Values = u.GiftSystem.GetPlayerDropdownGiftSystem(true);
				Default = {},
				Multi = true;
				Searchable = true,
				MaxVisibleDropdownItems = 8;
				Text = "\240\159\164\157 Pickup From",
				Tooltip = "Selected players are trusted drop sources.";
				Changed = function(G)
					if type(G) ~= "table" then
						return
					end
					e.gift_drop_pickup_from = G
					q.Save.SaveDataSync()
				end
			})
			T.GiftSystemUi.DropTrustedDropdown:SetValue(e.gift_drop_pickup_from)
			local V
			V = Z:AddValueDropdown("gift_drop_pickup_categories_ui", {
				Values = u.GiftSystem.GetDropCategoryValuesGiftSystem(),
				Default = {},
				Multi = true,
				Searchable = false;
				MaxVisibleDropdownItems = 7;
				Text = "\240\159\147\166 Categories";
				Tooltip = "Only selected drop categories will be picked up.";
				Changed = function(G)
					if type(G) ~= "table" then
						return
					end
					e.gift_drop_pickup_categories = G
					q.Save.SaveDataSync()
				end
			})
			V:SetValue(e.gift_drop_pickup_categories)
			Z:AddToggle("gift_drop_pickup_use_player_walk_ui", {
				Text = "\240\159\154\182 Use Player Walk";
				Default = e.gift_drop_pickup_use_player_walk,
				Tooltip = "Walks to dropped items first, then activates the prompt.",
				Callback = function(G)
					e.gift_drop_pickup_use_player_walk = G
					q.Save.SaveDataSync()
				end
			})
			Z:AddToggle("gift_drop_pickup_enabled_ui", {
				Text = "\240\159\147\166 Enable Drop Pickup";
				Default = e.gift_drop_pickup_enabled;
				Tooltip = "Automatically picks allowed dropped items.",
				Callback = function(G)
					e.gift_drop_pickup_enabled = G
					if not G then
						u.Teleport.UnlockTeleport(T.TeleportLockNames.GiftDropPickup)
					end
					q.Save.SaveDataSync()
				end
			})
		end
		return true
	end;
	StartGiftSystem = function()
		if u.GiftSystem.StartedGiftSystem then
			return false
		end
		u.GiftSystem.StartedGiftSystem = true
		local G = y.Networking and (y.Networking.Gifting and y.Networking.Gifting.Prompted)
		if G and G.OnClientEvent then
			G.OnClientEvent:Connect(function(G, V)
				u.GiftSystem.ProcessPromptGiftSystem(G, V)
			end)
		end
		y.Players.PlayerAdded:Connect(function()
			task.defer(u.GiftSystem.RefreshPlayerDropdownsGiftSystem)
		end)
		y.Players.PlayerRemoving:Connect(function()
			task.defer(u.GiftSystem.RefreshPlayerDropdownsGiftSystem)
		end)
		if y.DroppedItems then
			y.DroppedItems.ChildAdded:Connect(function(G)
				task.wait(.1)
				u.GiftSystem.ClaimDroppedItemGiftSystem(G)
			end)
		end
		task.spawn(function()
			while not T.is_forced_stop do
				task.wait(3)
				local G, V = pcall(u.GiftSystem.ProcessSenderGiftSystem)
				if not G then
					u.GiftSystem.SenderBusyGiftSystem = false
					u.GiftSystem.SetStatusGiftSystem("Sender loop error", "#FF6666")
					warn("[GiftSystem Loop]", V)
				end
				if e.gift_drop_pickup_enabled and (y.DroppedItems and not u.GiftSystem.DropBusyGiftSystem) then
					for G, V in ipairs(y.DroppedItems:GetChildren()) do
						if u.GiftSystem.ClaimDroppedItemGiftSystem(V) then
							task.wait(.5)
						end
					end
				end
			end
		end)
		return true
	end
}
u.GiftSystem.StartGiftSystem()
a.ShopTrigger = {
	GetValuesShopTrigger = function()
		if u.WeatherTriggers and type(u.WeatherTriggers.GetOptionsWeatherTriggers) == "function" then
			return u.WeatherTriggers.GetOptionsWeatherTriggers()
		end
		return {
			"Any Time"
		}
	end;
	NormaliseShopTrigger = function(G)
		return u.WeatherTriggers and u.WeatherTriggers.NormaliseWeatherTriggers(G) or ((tostring(G or "")):lower()):gsub("%s+", "")
	end;
	NamesMatchShopTrigger = function(G, V)
		return a.ShopTrigger.NormaliseShopTrigger(G) == a.ShopTrigger.NormaliseShopTrigger(V)
	end;
	IsActiveShopTrigger = function(G)
		G = tostring(G or "")
		if G == "" then
			return true
		end
		if e[G .. "_trigger_enabled"] ~= true then
			return true
		end
		local V = tostring(e[G .. "_trigger_name"] or "Any Time")
		if V == "" or V == "Any Time" then
			return true
		end
		if u.WeatherTriggers and type(u.WeatherTriggers.IsTriggerActiveWeatherTriggers) == "function" then
			return u.WeatherTriggers.IsTriggerActiveWeatherTriggers(V) == true
		end
		return false
	end
}
a.ShopBuyer = {
	IsSelectedShopBuyer = function(G, V)
		V = tostring(V or "")
		if V == "" or type(G) ~= "table" then
			return false
		end
		if G[V] == true then
			return true
		end
		for G, y in pairs(G) do
			if tostring(y or "") == V then
				return true
			end
		end
		return false
	end;
	GetSpendableShecklesShopBuyer = function(G, V)
		V = tonumber(V) or 0
		G = tostring(G or "")
		if G == "" or e[G .. "_min_sheckles_enabled"] ~= true then
			return V
		end
		local y = tonumber(e[G .. "_min_sheckles"]) or 0
		if y <= 0 then
			return V
		end
		return math.max(0, V - y)
	end;
	GetAllSelectionShopBuyer = function(G)
		local V = {}
		if type(G) ~= "table" then
			return V
		end
		for G, y in pairs(G) do
			local Z = ""
			if type(G) == "string" then
				Z = G
			elseif type(y) == "table" then
				Z = tostring(y.name or y.ItemName or y.SeedName or "")
			elseif type(y) == "string" then
				Z = y
			end
			if Z ~= "" then
				V[Z] = true
			end
		end
		return V
	end
}
a.SeedShop = {
	GetCurrentStockSeedStock = function(G)
		if not y.SeedShop or not y.SeedShop.Items then
			return 0
		end
		local V = y.SeedShop.Items:FindFirstChild(G)
		if V then
			return tonumber(V.Value) or 0
		end
		return 0
	end;
	BuySeed = function(G)
		if not a.ShopBuyer.IsSelectedShopBuyer(e.seed_shop_buy_selected, G) then
			return false
		end
		local V = y.Networking and (y.Networking.SeedShop and y.Networking.SeedShop.PurchaseSeed)
		if not V or type(V.Fire) ~= "function" then
			return false
		end
		V:Fire(G)
		return true
	end;
	SeedBuyerLoop = function()
		if not e.enabled_seed_shop then
			return
		end
		if not a.ShopTrigger.IsActiveShopTrigger("seed_shop") then
			return
		end
		local G = u.DataReplica.GetData("PurchasedThisRestock")
		if not G then
			return
		end
		local V = tonumber(u.Money.GetSheckles()) or 0
		local y = G.Seeds or {}
		for G in pairs(T.SeedShopDataList) do
			if not a.ShopBuyer.IsSelectedShopBuyer(e.seed_shop_buy_selected, G) then
				continue
			end
			local Z = u.SeedData.GetSeedDataX(G)
			if not Z then
				continue
			end
			local j = tonumber(Z.price) or 0
			if j <= 0 then
				continue
			end
			local i = a.SeedShop.GetCurrentStockSeedStock(G)
			local c = tonumber(y[G]) or 0
			local J = math.max(0, i - c)
			if J <= 0 then
				continue
			end
			local T = a.ShopBuyer.GetSpendableShecklesShopBuyer("seed_shop", V)
			local d = math.min(J, math.floor(T / j))
			if d <= 0 then
				continue
			end
			for y = 1, d, 1 do
				if a.ShopBuyer.GetSpendableShecklesShopBuyer("seed_shop", tonumber(u.Money.GetSheckles()) or 0) < j then
					break
				end
				a.SeedShop.BuySeed(G)
				task.wait(.1)
				V = tonumber(u.Money.GetSheckles()) or 0
			end
		end
	end
}
a.GearShop = {
	BuyGear = function(G)
		if not a.ShopBuyer.IsSelectedShopBuyer(e.gear_shop_buy_selected, G) then
			return false
		end
		local V = y.Networking and (y.Networking.GearShop and y.Networking.GearShop.PurchaseGear)
		if not V or type(V.Fire) ~= "function" then
			return false
		end
		V:Fire(G)
		return true
	end,
	GearShopLoop = function()
		if not e.enabled_gear_shop then
			return
		end
		if not a.ShopTrigger.IsActiveShopTrigger("gear_shop") then
			return
		end
		local G = u.DataReplica.GetData("PurchasedThisRestock")
		if not G then
			return
		end
		local V = tonumber(u.Money.GetSheckles()) or 0
		local y = G.Gear or G.Gears or {}
		for G, Z in pairs(T.AllGearShopData) do
			if not a.ShopBuyer.IsSelectedShopBuyer(e.gear_shop_buy_selected, G) then
				continue
			end
			local j = tonumber(Z.price) or 0
			if j <= 0 then
				continue
			end
			local i = tonumber(u.GearData.GetGearStockCurrent(G)) or 0
			local c = tonumber(y[G]) or 0
			local J = math.max(0, i - c)
			if J <= 0 then
				continue
			end
			local T = a.ShopBuyer.GetSpendableShecklesShopBuyer("gear_shop", V)
			local d = math.min(J, math.floor(T / j))
			if d <= 0 then
				continue
			end
			for y = 1, d, 1 do
				if a.ShopBuyer.GetSpendableShecklesShopBuyer("gear_shop", tonumber(u.Money.GetSheckles()) or 0) < j then
					break
				end
				a.GearShop.BuyGear(G)
				task.wait(.1)
				V = tonumber(u.Money.GetSheckles()) or 0
			end
		end
	end
}
a.CrateShop = {
	BuyCrate = function(G)
		if not a.ShopBuyer.IsSelectedShopBuyer(e.crate_shop_buy_selected, G) then
			return false
		end
		local V = y.Networking and (y.Networking.CrateShop and y.Networking.CrateShop.PurchaseCrate)
		if not V or type(V.Fire) ~= "function" then
			return false
		end
		V:Fire(G)
		return true
	end;
	CrateShopLoop = function()
		if not e.enabled_crate_shop then
			return
		end
		if not a.ShopTrigger.IsActiveShopTrigger("crate_shop") then
			return
		end
		local G = u.DataReplica.GetData("PurchasedThisRestock")
		if not G then
			return
		end
		local V = tonumber(u.Money.GetSheckles()) or 0
		local y = G.Crates or G.Crate or {}
		for G in pairs(T.CrateShopDataList) do
			if not a.ShopBuyer.IsSelectedShopBuyer(e.crate_shop_buy_selected, G) then
				continue
			end
			local Z = u.CrateData.GetCrateItemDetails(G)
			if not Z then
				continue
			end
			local j = tonumber(Z.price) or 0
			if j <= 0 then
				continue
			end
			local i = tonumber(u.CrateData.GetCrateStockCurrent(G)) or 0
			local c = tonumber(y[G]) or 0
			local J = math.max(0, i - c)
			if J <= 0 then
				continue
			end
			local T = a.ShopBuyer.GetSpendableShecklesShopBuyer("crate_shop", V)
			local d = math.min(J, math.floor(T / j))
			if d <= 0 then
				continue
			end
			for y = 1, d, 1 do
				if a.ShopBuyer.GetSpendableShecklesShopBuyer("crate_shop", tonumber(u.Money.GetSheckles()) or 0) < j then
					break
				end
				a.CrateShop.BuyCrate(G)
				task.wait(.1)
				V = tonumber(u.Money.GetSheckles()) or 0
			end
		end
	end
}
T.MailStatusText = ""
T.MailDraftItems = {}
T.MailDraftTargetUsername = ""
T.MailDraftCategory = "Seeds"
T.MailDraftItemName = ""
T.MailDraftAmount = 1
T.MailDraftFruitMinKg = 0
T.MailDraftFruitMaxKg = 89
T.MailDraftFruitMutations = {}
T.MailDraftFruitVariants = {}
T.MailManualRunning = false
T.MailActiveOrder = nil
T.MailManualUiStatusText = "<font color=\'#888888\'>Ready to send</font>"
T.MailManualStatusLabel = nil
T.MailStartOrderButton = nil
T.MailClearOrderButton = nil
T.MailStopOrderButton = nil
T.MailSelectedReceipt = ""
T.MailSelectedRuleId = ""
T.MailUiRefs = {}
u.Mail = {
	Started = false;
	Busy = false,
	NextSendAt = 0;
	EquippedPets = {},
	RecentlySentPets = {},
	RecentlySentFruits = {};
	RuleCooldowns = {};
	MaxBatchItems = 20,
	SendDelay = 10.1,
	RetryDelay = 10;
	ClaimDelay = .5,
	MaxFailures = 5,
	MaxReceipts = 50,
	SetStatus = function(G, V)
		T.MailStatusText = string.format("<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\147\172 [Mail]</font> <font color=\'%s\'>%s</font></stroke>", tostring(V or "#FFFFFF"), tostring(G or "Waiting"))
	end;
	ClearStatus = function()
		T.MailStatusText = ""
	end,
	SetManualUiStatus = function(G, V, y)
		T.MailManualUiStatusText = string.format("<font color=\'%s\'>%s %s</font>", tostring(V or "#FFFFFF"), tostring(y or "\240\159\147\172"), tostring(G or "Waiting"))
	end,
	SetUiDisabled = function(G, V)
		if not G then
			return
		end
		V = V == true
		if type(G.SetDisabled) == "function" then
			local y = pcall(function()
				G:SetDisabled(V)
			end)
			if y then
				return
			end
		end
		pcall(function()
			G.Disabled = V
		end)
	end;
	RefreshManualUi = function()
		local G = T.MailManualStatusLabel
		if G and type(G.SetText) == "function" then
			pcall(function()
				G:SetText(T.MailManualUiStatusText)
			end)
		end
		u.Mail.SetUiDisabled(T.MailStartOrderButton, T.MailManualRunning)
		u.Mail.SetUiDisabled(T.MailClearOrderButton, T.MailManualRunning)
		u.Mail.SetUiDisabled(T.MailStopOrderButton, not T.MailManualRunning)
	end,
	GetServerTime = function()
		local G, V = pcall(function()
			return y.Workspace:GetServerTimeNow()
		end)
		if G and type(V) == "number" then
			return V
		end
		return os.time()
	end;
	GetSendWait = function()
		local G = math.max(u.Mail.NextSendAt - os.clock(), 0)
		local V = math.max(((tonumber(e.mail_next_send_at) or 0)) - u.Mail.GetServerTime(), 0)
		return math.max(G, V)
	end,
	GetNote = function(G)
		if not e.mail_include_comment then
			return ""
		end
		return (tostring(G or "")):sub(1, 100)
	end,
	MakeId = function(G)
		local V = (((y.HttpService:GenerateGUID(false)):gsub("%-", "")):sub(1, 8)):upper()
		return tostring(G or "EXO") .. ("-" .. V)
	end;
	CleanUsername = function(G)
		G = tostring(G or "")
		return (G:gsub("^%s*@?", "")):gsub("%s+$", "")
	end,
	IsValidUsername = function(G)
		G = u.Mail.CleanUsername(G)
		if # G < 3 or # G > 20 then
			return false
		end
		return G:match("^[%w_]+$") ~= nil
	end;
	LookupRecipient = function(G)
		G = u.Mail.CleanUsername(G)
		if not u.Mail.IsValidUsername(G) then
			return nil, "Enter the exact Roblox username"
		end
		local V = y.Networking and (y.Networking.Mailbox and y.Networking.Mailbox.LookupPlayer)
		if not V or type(V.Fire) ~= "function" then
			return nil, "Mailbox lookup is unavailable"
		end
		u.Mail.SetStatus("Checking @" .. (G .. "..."), "#66CCFF")
		local Z, j, i = pcall(function()
			return V:Fire(G)
		end)
		if not Z or type(j) ~= "number" or j <= 0 then
			return nil, "User was not found"
		end
		if tonumber(j) == tonumber(T.player_userid) then
			return nil, "You cannot send mail to yourself"
		end
		return {
			userId = j,
			username = G,
			displayName = type(i) == "string" and (i ~= "" and i) or G
		}
	end,
	GetInventory = function()
		local G = u.DataReplica.GetData("Inventory")
		return type(G) == "table" and G or nil
	end;
	IsGiftableCategory = function(G)
		local V = y.MailboxItemCatalog
		if type(G) ~= "string" or G == "" or type(V) ~= "table" or type(V.IsGiftable) ~= "function" then
			return false
		end
		local Z, j = pcall(V.IsGiftable, G)
		return Z and j == true
	end;
	EncodeGearSelection = function(G, V)
		return tostring(G or "") .. ("::" .. tostring(V or ""))
	end;
	DecodeItemSelection = function(G, V)
		G = tostring(G or "")
		V = tostring(V or "")
		if G == "Fruits" then
			return "HarvestedFruits", V
		end
		if G ~= "Gears" then
			return G, V
		end
		local y, Z = V:match("^([^:]+)::(.+)$")
		if not u.Mail.IsGiftableCategory(y) or y == "Seeds" or y == "Pets" or y == "HarvestedFruits" then
			return nil, nil
		end
		return y, Z
	end,
	GetGearCategories = function()
		local G = {}
		local V = y.MailboxItemCatalog
		local Z = type(V) == "table" and V.Categories
		if type(Z) ~= "table" then
			return G
		end
		for V, y in ipairs(Z) do
			if type(y) == "string" and (y ~= "Seeds" and (y ~= "Pets" and y ~= "HarvestedFruits")) then
				table.insert(G, y)
			end
		end
		return G
	end;
	GetGearDropdown = function()
		local G = {}
		local V = {}
		local Z = u.Mail.GetInventory() or {}
		local function j(G)
			if type(G) ~= "table" then
				return {}
			end
			if type(G.Data) == "table" then
				return G.Data
			end
			return G
		end
		local function i(G, V)
			local y = Z[tostring(G or "")]
			if type(y) ~= "table" then
				return 0
			end
			return math.max(math.floor(tonumber(y[tostring(V or "")]) or 0), 0)
		end
		local function c(y, Z)
			y = tostring(y or "")
			Z = tostring(Z or "")
			if y == "" or Z == "" then
				return
			end
			if not u.Mail.IsGiftableCategory(y) then
				return
			end
			if y == "Seeds" or y == "Pets" or y == "HarvestedFruits" then
				return
			end
			local j = u.Mail.EncodeGearSelection(y, Z)
			if V[j] then
				return
			end
			V[j] = true
			local c = i(y, Z)
			local J = c > 0 and "#7CFC00" or "#888888"
			local T = y:gsub("(%l)(%u)", "%1 %2")
			table.insert(G, {
				Text = string.format("<font color=\"#FFFFFF\">%s</font> <font color=\"%s\">x%d</font> <font color=\"#AAAAAA\">(%s)</font>", Z, J, c, T);
				Value = j
			})
		end
		local function J(G, V, y)
			for V, Z in ipairs(j(V)) do
				if type(Z) ~= "table" then
					continue
				end
				for V, y in ipairs(y) do
					local j = Z[y]
					if type(j) == "string" and j ~= "" then
						c(G, j)
						break
					end
				end
			end
		end
		local function d(G)
			if type(G) ~= "table" then
				return nil
			end
			local V = tostring(G.name or G.ItemName or "")
			local y = tostring(G.type or G.ItemType or "")
			local Z = (((y ~= "" and y or V)):lower()):gsub("[^%w]", "")
			local j = (V:lower()):gsub("[^%w]", "")
			if Z == "wateringcan" or j:find("wateringcan", 1, true) then
				return "WateringCans"
			end
			if Z:find("sprinkler", 1, true) or j:find("sprinkler", 1, true) then
				return "Sprinklers"
			end
			if Z == "mushroom" or j:find("mushroom", 1, true) then
				return "Mushrooms"
			end
			if Z == "gnome" then
				return "Gnomes"
			end
			if Z == "raccoon" then
				return "Raccoons"
			end
			if Z == "trowel" then
				return "Trowels"
			end
			if Z == "emptypot" then
				return "EmptyPots"
			end
			if Z == "seedpack" then
				return "SeedPacks"
			end
			if Z == "crate" then
				return "Crates"
			end
			return nil
		end
		J("Sprinklers", y.SprinklerData, {
			"SprinklerName"
		})
		J("WateringCans", y.WateringcanData, {
			"Name"
		})
		J("Mushrooms", y.MushroomData, {
			"Name"
		})
		J("Raccoons", y.RaccoonData, {
			"Name"
		})
		J("Gnomes", y.GnomeData, {
			"Name"
		})
		J("PowerHoses", y.PowerHoseData, {
			"Name"
		})
		J("SeedPacks", y.SeedPackData, {
			"PackName"
		})
		J("Props", y.PropData, {
			"PropName"
		})
		for G, V in ipairs(T.AllCrateShopTable or {}) do
			if type(V) == "table" then
				c("Crates", V.name or V.Name)
			end
		end
		for G, V in ipairs(T.AllGearShopTable or {}) do
			local y = d(V)
			if y then
				c(y, V.name or V.ItemName)
			end
		end
		for G, V in ipairs(u.Mail.GetGearCategories()) do
			local y = Z[V]
			if type(y) ~= "table" then
				continue
			end
			for G in pairs(y) do
				c(V, G)
			end
		end
		table.sort(G, function(G, V)
			return tostring(G.Value) < tostring(V.Value)
		end)
		return G
	end,
	GetFruitDropdown = function()
		local G = {}
		local V = {}
		local y = {}
		for G, y in ipairs(u.Mail.GetBackpackMailFruits and u.Mail.GetBackpackMailFruits() or {}) do
			local Z = tostring(y.name or "")
			if Z ~= "" then
				V[Z] = ((V[Z] or 0)) + 1
			end
		end
		local function Z(Z)
			Z = tostring(Z or "")
			if Z == "" or y[Z] then
				return
			end
			y[Z] = true
			local j = math.max(math.floor(tonumber(V[Z]) or 0), 0)
			table.insert(G, {
				Text = string.format("<font color=\"#FFFFFF\">%s</font> <font color=\"#7CFC00\">x%d</font>", Z, j);
				Value = Z
			})
		end
		for G in pairs(V) do
			Z(G)
		end
		for G, V in ipairs(T.AllSeedsDataTable or {}) do
			if type(V) == "table" then
				Z(V.name)
			end
		end
		table.sort(G, function(G, V)
			return tostring(G.Value) < tostring(V.Value)
		end)
		return G
	end;
	GetItemDisplayName = function(G, V)
		if G == "Pets" then
			local G = y.PetData and y.PetData[V]
			if type(G) == "table" and (type(G.DisplayName) == "string" and G.DisplayName ~= "") then
				return G.DisplayName
			end
		end
		return tostring(V or "Unknown")
	end,
	GetItemDropdown = function(G)
		if G == "Seeds" then
			return u.SeedData.GetSeedDataListDropDown()
		end
		if G == "Gears" then
			return u.Mail.GetGearDropdown()
		end
		if G == "Fruits" or G == "HarvestedFruits" then
			return u.Mail.GetFruitDropdown()
		end
		local V = {}
		if G ~= "Pets" or type(y.PetData) ~= "table" then
			return V
		end
		for G, y in pairs(y.PetData) do
			if type(G) ~= "string" or type(y) ~= "table" then
				continue
			end
			local Z = tostring(y.DisplayName or G)
			local j = tostring(y.Rarity or "Unknown")
			local i = u.Data.GetRarityColor(j)
			table.insert(V, {
				Text = string.format("<font color=\"#FFFFFF\">%s</font> <font color=\"%s\">%s</font>", Z, i, j),
				Value = G
			})
		end
		table.sort(V, function(G, V)
			return tostring(G.Value) < tostring(V.Value)
		end)
		return V
	end;
	PassesSelection = function(G, V)
		if type(G) ~= "table" or next(G) == nil then
			return true
		end
		return G[V] == true
	end,
	CopySelection = function(G)
		local V = {}
		if type(G) ~= "table" then
			return V
		end
		for G, y in pairs(G) do
			V[G] = y
		end
		return V
	end,
	SelectionKey = function(G)
		local V = {}
		if type(G) ~= "table" then
			return ""
		end
		for G, y in pairs(G) do
			if y == true then
				table.insert(V, tostring(G))
			elseif type(G) == "number" and tostring(y or "") ~= "" then
				table.insert(V, tostring(y))
			elseif type(G) == "string" and (y ~= nil and y ~= false) then
				table.insert(V, tostring(G))
			end
		end
		table.sort(V)
		return table.concat(V, ",")
	end;
	NormaliseFruitFilters = function(G, V, y, Z, j, i)
		G = math.max(tonumber(G) or 0, 0)
		V = tonumber(V) or 89
		if V < G then
			return nil, nil, "Max KG must be equal to or above Min KG"
		end
		return G, V, nil, u.Mail.CopySelection(y), u.Mail.CopySelection(Z), u.Mail.CopySelection(j), u.Mail.CopySelection(i)
	end,
	GetFruitFilterKey = function(G, V, y, Z)
		return table.concat({
			tostring(tonumber(G) or 0),
			tostring(tonumber(V) or 89);
			u.Mail.SelectionKey(y),
			u.Mail.SelectionKey(Z)
		}, "|")
	end;
	GetFruitFilterText = function(G)
		if type(G) ~= "table" or G.category ~= "HarvestedFruits" then
			return ""
		end
		local V = {
			string.format("KG %.2f-%.2f", tonumber(G.fruitMinKg) or 0, tonumber(G.fruitMaxKg) or 89)
		}
		if not u.FruitFilters.IsSelectionEmpty(G.fruitMutations) then
			table.insert(V, "Mutations")
		end
		if not u.FruitFilters.IsSelectionEmpty(G.fruitVariants) then
			table.insert(V, "Variants")
		end
		return " <font color=\'#AAAAAA\'>[" .. (table.concat(V, ", ") .. "]</font>")
	end,
	GetPetVariant = function(G)
		if type(G) == "table" and G.Type == "Rainbow" then
			return "Rainbow"
		end
		return "Normal"
	end;
	GetPetSize = function(G)
		local V = type(G) == "table" and G.Size
		if V == "Big" or V == "Huge" then
			return V
		end
		return "Normal"
	end,
	CleanupRecentlySentPets = function()
		local G = os.clock()
		for V, y in pairs(u.Mail.RecentlySentPets) do
			if tonumber(y) == nil or G >= y then
				u.Mail.RecentlySentPets[V] = nil
			end
		end
	end,
	GetMatchingPets = function(G, V, y, Z)
		local j = {}
		local i = u.Mail.GetInventory()
		local c = i and i.Pets
		if type(c) ~= "table" then
			return j
		end
		u.Mail.CleanupRecentlySentPets()
		for i, c in pairs(c) do
			if type(c) ~= "table" or c.Id == nil then
				continue
			end
			local J = c.Name or c.PetName or c.Species
			local T = tostring(i)
			local d = tostring(c.Id)
			if J ~= G or c.Equipped == true or u.Mail.EquippedPets[T] or u.Mail.EquippedPets[d] or u.Mail.RecentlySentPets[T] or u.Mail.RecentlySentPets[d] or type(Z) == "table" and ((Z[T] or Z[d])) then
				continue
			end
			local q = u.Mail.GetPetVariant(c)
			local g = u.Mail.GetPetSize(c)
			if not u.Mail.PassesSelection(V, q) or not u.Mail.PassesSelection(y, g) then
				continue
			end
			table.insert(j, {
				key = T;
				id = d,
				data = c
			})
		end
		table.sort(j, function(G, V)
			return G.key < V.key
		end)
		return j
	end,
	CleanupRecentlySentFruits = function()
		local G = os.clock()
		for V, y in pairs(u.Mail.RecentlySentFruits) do
			if tonumber(y) == nil or G >= y then
				u.Mail.RecentlySentFruits[V] = nil
			end
		end
	end;
	GetBackpackMailFruits = function()
		local G = {}
		local V = {}
		if u.GiftSystem and type(u.GiftSystem.GetBackpackFruitsGiftSystem) == "function" then
			local G, y = pcall(u.GiftSystem.GetBackpackFruitsGiftSystem)
			V = G and (type(y) == "table" and y) or {}
		elseif u.SellManager and type(u.SellManager.GetBackpackFruitsForSelling) == "function" then
			local G, y = pcall(u.SellManager.GetBackpackFruitsForSelling)
			V = G and (type(y) == "table" and y) or {}
		end
		for V, y in ipairs(V) do
			if type(y) ~= "table" then
				continue
			end
			local Z = tostring(y.key or y.id or "")
			local j = tostring(y.name or y.n or "")
			if Z == "" or j == "" then
				continue
			end
			table.insert(G, {
				key = Z;
				id = tostring(y.id or Z);
				name = j,
				weight = tonumber(y.w) or 0;
				data = y
			})
		end
		table.sort(G, function(G, V)
			if ((tonumber(G.weight) or 0)) ~= ((tonumber(V.weight) or 0)) then
				return ((tonumber(G.weight) or 0)) < ((tonumber(V.weight) or 0))
			end
			return tostring(G.key) < tostring(V.key)
		end)
		return G
	end,
	GetMatchingFruits = function(G, V, y, Z, j, i, c, J)
		local T = {}
		G = tostring(G or "")
		V = math.max(tonumber(V) or 0, 0)
		y = tonumber(y) or 89
		if G == "" then
			return T
		end
		u.Mail.CleanupRecentlySentFruits()
		for d, q in ipairs(u.Mail.GetBackpackMailFruits()) do
			if q.name ~= G then
				continue
			end
			if type(i) == "table" and ((i[q.key] or i[q.id])) then
				continue
			end
			if u.Mail.RecentlySentFruits[q.key] or u.Mail.RecentlySentFruits[q.id] then
				continue
			end
			local g = q.data
			if type(g) ~= "table" or g.has_weight == false or q.weight <= 0 then
				continue
			end
			if not u.FruitFilters.PassesWeightRange(q.weight, V, y) then
				continue
			end
			local E, a = u.FruitFilters.GetMutationLookup(g)
			if not u.FruitFilters.PassesMutationSelection(a, Z, c) then
				continue
			end
			local H = u.FruitFilters.GetFruitVariant(g, a)
			if not u.FruitFilters.PassesVariantSelection(H, j, J) then
				continue
			end
			table.insert(T, q)
		end
		return T
	end;
	GetAvailableCount = function(G, V, y, Z, j, i, c, J, T, d, q)
		local g = u.Mail.GetInventory()
		if not g then
			return 0
		end
		if G == "Pets" then
			return # u.Mail.GetMatchingPets(V, y, Z, j)
		end
		if G == "HarvestedFruits" then
			return # u.Mail.GetMatchingFruits(V, i, c, J, T, j, d, q)
		end
		if not u.Mail.IsGiftableCategory(G) then
			return 0
		end
		local E = g[G]
		return type(E) == "table" and math.max(math.floor(tonumber(E[V]) or 0), 0) or 0
	end;
	GetBatchAmount = function(G)
		G = math.max(math.floor(tonumber(G) or 0), 0)
		if e.mail_ignore_batch_limit then
			return G
		end
		return math.min(G, u.Mail.MaxBatchItems)
	end;
	BuildBatch = function(G, V, y, Z, j, i, c, J, T, d, q, g)
		local E = {}
		y = u.Mail.GetBatchAmount(y)
		if y <= 0 then
			return E, 0
		end
		if G == "Pets" then
			local G = u.Mail.GetMatchingPets(V, Z, j, i)
			local c = math.min(y, # G)
			for V = 1, c, 1 do
				table.insert(E, {
					Category = "Pets",
					ItemKey = G[V].key;
					Count = 1
				})
			end
			return E, c
		end
		if G == "HarvestedFruits" then
			local G = u.Mail.GetMatchingFruits(V, c, J, T, d, i, q, g)
			local Z = math.min(y, # G)
			for V = 1, Z, 1 do
				table.insert(E, {
					Category = "HarvestedFruits";
					ItemKey = G[V].key,
					Count = 1
				})
			end
			return E, Z
		end
		if not u.Mail.IsGiftableCategory(G) then
			return E, 0
		end
		local a = u.Mail.GetAvailableCount(G, V)
		local H = math.min(y, a)
		if H > 0 then
			table.insert(E, {
				Category = G,
				ItemKey = V,
				Count = H
			})
		end
		return E, H
	end,
	MarkBatchSent = function(G)
		for G, V in ipairs(G or {}) do
			if V.Category == "Pets" and type(V.ItemKey) == "string" then
				u.Mail.RecentlySentPets[V.ItemKey] = os.clock() + 30
			elseif V.Category == "HarvestedFruits" and type(V.ItemKey) == "string" then
				u.Mail.RecentlySentFruits[V.ItemKey] = os.clock() + 30
			end
		end
	end;
	SendBatch = function(G, V, Z, j)
		if u.Mail.Busy then
			return false, "Mailbox is busy"
		end
		if type(G) ~= "table" or type(G.userId) ~= "number" or type(V) ~= "table" or # V == 0 then
			return false, "Invalid mail request"
		end
		local i = y.Networking and (y.Networking.Mailbox and y.Networking.Mailbox.SendBatch)
		if not i or type(i.Fire) ~= "function" then
			return false, "Mailbox sending is unavailable"
		end
		u.Mail.Busy = true
		local c = u.Mail.GetSendWait()
		while c > 0 do
			if type(j) == "function" and not j() then
				u.Mail.Busy = false
				return false, "Manual order stopped"
			end
			if T.MailManualRunning then
				u.Mail.SetManualUiStatus(string.format("Waiting %ds before the next mail", math.ceil(c)), "#FFCC66", "\226\143\179")
			end
			task.wait(math.min(c, 1))
			c = u.Mail.GetSendWait()
		end
		if type(j) == "function" and not j() then
			u.Mail.Busy = false
			return false, "Manual order stopped"
		end
		Z = u.Mail.GetNote(Z)
		local J, d, g = pcall(function()
			return i:Fire(G.userId, V, Z)
		end)
		u.Mail.Busy = false
		if not J then
			return false, "Try again"
		end
		if d ~= true then
			return false, type(g) == "string" and (g ~= "" and g) or "Could not send gift"
		end
		u.Mail.NextSendAt = os.clock() + u.Mail.SendDelay
		e.mail_next_send_at = u.Mail.GetServerTime() + u.Mail.SendDelay
		u.Mail.MarkBatchSent(V)
		q.Save.SaveDataSync()
		return true, type(g) == "string" and (g ~= "" and g) or "Gift sent!"
	end,
	WaitForInventoryChange = function(G, V, y, Z, j, i, c, J, T, d, q)
		local g = os.clock() + 2.5
		repeat
			task.wait(.1)
			local E = u.Mail.GetAvailableCount(G, V, Z, j, nil, i, c, J, T, d, q)
			if E < y then
				return true
			end
		until os.clock() >= g
		return false
	end,
	GetDraftItemsForUi = function()
		local G = T.MailActiveOrder
		if type(G) ~= "table" then
			G = e.mail_manual_order
		end
		if type(G) == "table" and (type(G.items) == "table" and # G.items > 0) then
			return G.items, true
		end
		return T.MailDraftItems, false
	end;
	GetDraftText = function()
		local G, V = u.Mail.GetDraftItemsForUi()
		if type(G) ~= "table" or # G == 0 then
			return "<font color=\'#888888\'>No items added</font>"
		end
		local y = {}
		for G, Z in ipairs(G) do
			local j = math.max(math.floor(tonumber(Z.amount) or 0), 0)
			local i = math.clamp(math.floor(tonumber(Z.sent) or 0), 0, j)
			local c = u.Mail.GetItemDisplayName(Z.category, Z.itemName) .. u.Mail.GetFruitFilterText(Z)
			if V then
				table.insert(y, string.format("%d. %s <font color=\'#7CFC00\'>%d/%d</font> <font color=\'#AAAAAA\'>(%s)</font>", G, c, i, j, tostring(Z.category or "Unknown")))
			else
				table.insert(y, string.format("%d. %dx %s <font color=\'#AAAAAA\'>(%s)</font>", G, j, c, tostring(Z.category or "Unknown")))
			end
		end
		return table.concat(y, "\n")
	end,
	RefreshDraftUi = function()
		local G = T.MailUiRefs
		local V = type(G) == "table" and G.RefreshDraft or nil
		if type(V) ~= "function" then
			return
		end
		pcall(V)
	end,
	AddDraftItem = function(G, V, y, Z, j, i, c, J, d)
		if T.MailManualRunning then
			return false, "Stop the current order first"
		end
		G, V = u.Mail.DecodeItemSelection(G, V)
		if not u.Mail.IsGiftableCategory(G) then
			return false, "Select an item category"
		end
		if type(V) ~= "string" or V == "" then
			return false, "Select an item"
		end
		y = math.floor(tonumber(y) or 0)
		if y <= 0 then
			return false, "Amount must be above 0"
		end
		local q = ""
		local g, E, a, H, r, Y, e
		if G == "HarvestedFruits" then
			g, E, a, H, r, Y, e = u.Mail.NormaliseFruitFilters(Z, j, i, c, J, d)
			if a then
				return false, a
			end
			q = u.Mail.GetFruitFilterKey(g, E, H, r)
		end
		for Z, j in ipairs(T.MailDraftItems) do
			if j.category == G and (j.itemName == V and tostring(j.filterKey or "") == q) then
				j.amount += y
				u.Mail.RefreshDraftUi()
				return true, "Order item updated"
			end
		end
		local s = {
			category = G;
			itemName = V,
			amount = y
		}
		if G == "HarvestedFruits" then
			s.fruitMinKg = g
			s.fruitMaxKg = E
			s.fruitMutations = H
			s.fruitVariants = r
			s.fruitMutationBlacklist = Y
			s.fruitVariantBlacklist = e
			s.filterKey = q
		end
		table.insert(T.MailDraftItems, s)
		u.Mail.RefreshDraftUi()
		return true, "Item added"
	end,
	ClearDraft = function()
		if T.MailManualRunning then
			return false
		end
		table.clear(T.MailDraftItems)
		u.Mail.RefreshDraftUi()
		return true
	end,
	CloneDraftItems = function()
		local G = {}
		for V, y in ipairs(T.MailDraftItems) do
			table.insert(G, {
				category = y.category,
				itemName = y.itemName;
				amount = y.amount,
				sent = 0,
				fruitMinKg = y.fruitMinKg;
				fruitMaxKg = y.fruitMaxKg;
				fruitMutations = u.Mail.CopySelection(y.fruitMutations),
				fruitVariants = u.Mail.CopySelection(y.fruitVariants);
				fruitMutationBlacklist = u.Mail.CopySelection(y.fruitMutationBlacklist),
				fruitVariantBlacklist = u.Mail.CopySelection(y.fruitVariantBlacklist);
				filterKey = y.filterKey
			})
		end
		return G
	end,
	BuildReceipt = function(G)
		local V = {
			"MAIL RECEIPT " .. tostring(G.id);
			"Delivered: " .. os.date("%d/%m/%Y %H:%M:%S");
			string.format("To: @%s (%s)", tostring(G.recipient.username), tostring(G.recipient.userId)),
			"Items:"
		}
		for G, y in ipairs(G.items) do
			table.insert(V, string.format("- %dx %s (%s)", y.amount, u.Mail.GetItemDisplayName(y.category, y.itemName) .. u.Mail.GetFruitFilterText(y), y.category))
		end
		table.insert(V, "Status: Delivered")
		return table.concat(V, "\n")
	end;
	TrimReceipts = function()
		if type(e.mail_receipts) ~= "table" then
			e.mail_receipts = {}
		end
		for G = # e.mail_receipts, 1, - 1 do
			if type(e.mail_receipts[G]) ~= "string" then
				table.remove(e.mail_receipts, G)
			end
		end
		while # e.mail_receipts > u.Mail.MaxReceipts do
			table.remove(e.mail_receipts)
		end
	end,
	AddReceipt = function(G)
		if type(G) ~= "string" or G == "" then
			return false
		end
		u.Mail.TrimReceipts()
		table.insert(e.mail_receipts, 1, G)
		u.Mail.TrimReceipts()
		q.Save.SaveDataSync()
		local V = T.MailUiRefs.RefreshReceipts
		if type(V) == "function" then
			V()
		end
		return true
	end;
	GetReceiptDropdown = function()
		u.Mail.TrimReceipts()
		local G = {}
		for V, y in ipairs(e.mail_receipts) do
			local Z = y:match("([^\n]+)") or ("Receipt " .. V)
			local j = y:match("To:%s*([^\n]+)") or ""
			table.insert(G, {
				Text = string.format("%s | %s", Z, j);
				Value = tostring(V)
			})
		end
		return G
	end;
	IsSavedManualOrderValid = function(G)
		if type(G) ~= "table" or type(G.id) ~= "string" or G.id == "" or type(G.recipient) ~= "table" or type(G.recipient.userId) ~= "number" or type(G.items) ~= "table" or # G.items == 0 then
			return false
		end
		return true
	end,
	SaveManualOrder = function(G)
		if not u.Mail.IsSavedManualOrderValid(G) then
			return false
		end
		e.mail_manual_order = G
		q.Save.SaveDataSync()
		return true
	end;
	ClearSavedManualOrder = function()
		e.mail_manual_order = {}
		q.Save.SaveDataSync()
	end;
	ApplyPendingParts = function(G, V)
		if type(G) ~= "table" or type(G.items) ~= "table" or type(V) ~= "table" then
			return false
		end
		for V, y in ipairs(V) do
			local Z = math.floor(tonumber(y.itemIndex) or 0)
			local j = G.items[Z]
			if not j then
				continue
			end
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
		local i = e.mail_ignore_batch_limit and math.huge or u.Mail.MaxBatchItems
		local c = {}
		if type(G) ~= "table" or type(G.items) ~= "table" then
			return V, y, Z, j
		end
		for G, J in ipairs(G.items) do
			local T = math.max(math.floor(tonumber(J.amount) or 0), 0)
			J.sent = math.max(math.floor(tonumber(J.sent) or 0), 0)
			local d = math.max(T - J.sent, 0)
			if d <= 0 then
				continue
			end
			Z += 1
			if i <= 0 then
				continue
			end
			local q = u.Mail.GetAvailableCount(J.category, J.itemName, nil, nil, c, J.fruitMinKg, J.fruitMaxKg, J.fruitMutations, J.fruitVariants, J.fruitMutationBlacklist, J.fruitVariantBlacklist)
			local g = math.min(d, q, i)
			if g <= 0 then
				continue
			end
			local E, a = u.Mail.BuildBatch(J.category, J.itemName, g, nil, nil, c, J.fruitMinKg, J.fruitMaxKg, J.fruitMutations, J.fruitVariants, J.fruitMutationBlacklist, J.fruitVariantBlacklist)
			if a <= 0 then
				continue
			end
			for G, y in ipairs(E) do
				table.insert(V, y)
				if ((y.Category == "Pets" or y.Category == "HarvestedFruits")) and type(y.ItemKey) == "string" then
					c[y.ItemKey] = true
				end
			end
			table.insert(y, {
				itemIndex = G,
				category = J.category;
				itemName = J.itemName,
				count = a,
				beforeCount = q,
				sentBefore = J.sent,
				batch = E;
				fruitMinKg = J.fruitMinKg;
				fruitMaxKg = J.fruitMaxKg;
				fruitMutations = J.fruitMutations,
				fruitVariants = J.fruitVariants,
				fruitMutationBlacklist = J.fruitMutationBlacklist;
				fruitVariantBlacklist = J.fruitVariantBlacklist
			})
			j += a
			i -= a
		end
		return V, y, Z, j
	end,
	RunCombinedManualItems = function(G)
		local V = 0
		while T.MailManualRunning and (T.MailActiveOrder == G and G.cancelled ~= true) do
			local y, Z, j, i = u.Mail.BuildCombinedManualBatch(G)
			if j <= 0 then
				return true
			end
			if i <= 0 then
				u.Mail.SetStatus(G.id .. " | Waiting for remaining items", "#FFCC66")
				u.Mail.SetManualUiStatus("Waiting for remaining order items", "#FFCC66", "\226\143\179")
				task.wait(2)
				continue
			end
			G.pending = {
				parts = Z,
				batch = y
			}
			u.Mail.SaveManualOrder(G)
			u.Mail.SetStatus(string.format("%s | Sending %d items together", G.id, i), "#66CCFF")
			u.Mail.SetManualUiStatus(string.format("Sending %d items from %d order lines to @%s", i, # Z, tostring(G.recipient.username or "?")), "#66CCFF", "\240\159\147\164")
			local c, J = u.Mail.SendBatch(G.recipient, y, string.format("Order %s | Combined %d items", G.id, i), function()
				return T.MailManualRunning and (T.MailActiveOrder == G and G.cancelled ~= true)
			end)
			if c then
				u.Mail.ApplyPendingParts(G, Z)
				G.pending = {}
				V = 0
				u.Mail.SaveManualOrder(G)
				u.Mail.RefreshDraftUi()
				u.Mail.SetManualUiStatus(string.format("Sent %d items together", i), "#7CFC00", "\226\156\133")
			else
				G.pending = {}
				V += 1
				u.Mail.SaveManualOrder(G)
				if G.cancelled == true or not T.MailManualRunning or T.MailActiveOrder ~= G then
					break
				end
				u.Mail.SetStatus(string.format("%s | %s", G.id, tostring(J)), "#FF5555")
				u.Mail.SetManualUiStatus(string.format("Combined send failed. Retrying in %ds", u.Mail.RetryDelay), "#FF5555", "\226\154\160\239\184\143")
				task.wait(u.Mail.RetryDelay)
			end
		end
		return false
	end;
	WasPendingBatchSent = function(G)
		if type(G) ~= "table" or type(G.batch) ~= "table" or # G.batch == 0 then
			return false
		end
		if G.category ~= "Pets" then
			if not u.Mail.IsGiftableCategory(G.category) then
				return false
			end
			local V = u.Mail.GetAvailableCount(G.category, G.itemName, nil, nil, nil, G.fruitMinKg, G.fruitMaxKg, G.fruitMutations, G.fruitVariants, G.fruitMutationBlacklist, G.fruitVariantBlacklist)
			local y = math.max(math.floor(tonumber(G.beforeCount) or 0), 0)
			local Z = math.max(math.floor(tonumber(G.count) or 0), 0)
			return Z > 0 and V <= y - Z
		end
		local V = u.Mail.GetInventory()
		local y = V and V.Pets
		if type(y) ~= "table" then
			return false
		end
		for G, V in ipairs(G.batch) do
			if type(V) == "table" and (type(V.ItemKey) == "string" and y[V.ItemKey] ~= nil) then
				return false
			end
		end
		return true
	end;
	ReconcilePendingBatch = function(G)
		local V = type(G) == "table" and G.pending
		if type(V) ~= "table" or next(V) == nil then
			return false
		end
		if type(V.parts) == "table" and # V.parts > 0 then
			local y = true
			for G, V in ipairs(V.parts) do
				if not u.Mail.WasPendingBatchSent(V) then
					y = false
					break
				end
			end
			if y then
				u.Mail.ApplyPendingParts(G, V.parts)
			end
			G.pending = {}
			u.Mail.SaveManualOrder(G)
			return y
		end
		local y = math.floor(tonumber(V.itemIndex) or 0)
		local Z = type(G.items) == "table" and G.items[y]
		local j = Z and u.Mail.WasPendingBatchSent(V) or false
		if j then
			local G = math.max(math.floor(tonumber(V.sentBefore) or 0), 0)
			local y = math.max(math.floor(tonumber(V.count) or 0), 0)
			Z.sent = math.max(math.floor(tonumber(Z.sent) or 0), G + y)
		end
		G.pending = {}
		u.Mail.SaveManualOrder(G)
		return j
	end,
	RunManualOrder = function(G)
		if T.MailManualRunning or not u.Mail.IsSavedManualOrderValid(G) then
			return false
		end
		T.MailActiveOrder = G
		T.MailManualRunning = true
		G.state = "running"
		u.Mail.SaveManualOrder(G)
		u.Mail.SetManualUiStatus(string.format("Order %s started", G.id), "#66CCFF", "\240\159\147\166")
		u.Mail.RefreshManualUi()
		u.Mail.RefreshDraftUi()
		task.spawn(function()
			local V, y = pcall(function()
				u.Mail.ReconcilePendingBatch(G)
				if G.batchTogether == true then
					u.Mail.RunCombinedManualItems(G)
					return
				end
				for V, y in ipairs(G.items) do
					y.sent = math.max(math.floor(tonumber(y.sent) or 0), 0)
					local Z = {}
					local j = 0
					while T.MailManualRunning and y.sent < y.amount do
						local i = y.amount - y.sent
						local c = u.Mail.GetItemDisplayName(y.category, y.itemName)
						local J = u.Mail.GetAvailableCount(y.category, y.itemName, nil, nil, Z, y.fruitMinKg, y.fruitMaxKg, y.fruitMutations, y.fruitVariants, y.fruitMutationBlacklist, y.fruitVariantBlacklist)
						if J <= 0 then
							local V = string.format("Waiting for %d %s", i, c)
							u.Mail.SetStatus(string.format("%s | %s", G.id, V), "#FFCC66")
							u.Mail.SetManualUiStatus(V, "#FFCC66", "\226\143\179")
							task.wait(2)
							continue
						end
						local d = J
						local q, g = u.Mail.BuildBatch(y.category, y.itemName, i, nil, nil, Z, y.fruitMinKg, y.fruitMaxKg, y.fruitMutations, y.fruitVariants, y.fruitMutationBlacklist, y.fruitVariantBlacklist)
						if g <= 0 then
							task.wait(2)
							continue
						end
						local E = y.sent + g
						local a = string.format("Order %s | %s | %d/%d", G.id, c, E, y.amount)
						G.pending = {
							itemIndex = V;
							category = y.category,
							itemName = y.itemName;
							count = g,
							beforeCount = d,
							sentBefore = y.sent,
							batch = q,
							fruitMinKg = y.fruitMinKg,
							fruitMaxKg = y.fruitMaxKg;
							fruitMutations = y.fruitMutations,
							fruitVariants = y.fruitVariants;
							fruitMutationBlacklist = y.fruitMutationBlacklist;
							fruitVariantBlacklist = y.fruitVariantBlacklist
						}
						u.Mail.SaveManualOrder(G)
						u.Mail.SetStatus(string.format("%s | Sending %s %d/%d", G.id, c, E, y.amount), "#66CCFF")
						u.Mail.SetManualUiStatus(string.format("Sending %s %d/%d to @%s", c, E, y.amount, tostring(G.recipient.username or "?")), "#66CCFF", "\240\159\147\164")
						local H, r = u.Mail.SendBatch(G.recipient, q, a, function()
							return T.MailManualRunning and (T.MailActiveOrder == G and G.cancelled ~= true)
						end)
						if H then
							if G.cancelled == true or not T.MailManualRunning or T.MailActiveOrder ~= G then
								G.pending = {}
								break
							end
							y.sent = E
							G.pending = {}
							j = 0
							for G, V in ipairs(q) do
								if V.Category == "Pets" or V.Category == "HarvestedFruits" then
									Z[V.ItemKey] = true
								end
							end
							u.Mail.SaveManualOrder(G)
							u.Mail.RefreshDraftUi()
							u.Mail.SetManualUiStatus(string.format("Sent %s %d/%d", c, y.sent, y.amount), "#7CFC00", "\226\156\133")
							u.Mail.WaitForInventoryChange(y.category, y.itemName, d, nil, nil, y.fruitMinKg, y.fruitMaxKg, y.fruitMutations, y.fruitVariants, y.fruitMutationBlacklist, y.fruitVariantBlacklist)
						else
							if G.cancelled == true or not T.MailManualRunning or T.MailActiveOrder ~= G then
								G.pending = {}
								break
							end
							G.pending = {}
							j += 1
							u.Mail.SaveManualOrder(G)
							u.Mail.SetStatus(string.format("%s | %s", G.id, tostring(r)), "#FF5555")
							u.Mail.SetManualUiStatus(string.format("Send failed. Retrying in %ds", u.Mail.RetryDelay), "#FF5555", "\226\154\160\239\184\143")
							if j >= u.Mail.MaxFailures then
								j = 0
							end
							task.wait(u.Mail.RetryDelay)
						end
					end
					if not T.MailManualRunning then
						break
					end
				end
			end)
			if not V then
				warn("[Mail] Manual order error:", y)
				T.MailManualRunning = false
				T.MailActiveOrder = nil
				G.state = "resume"
				u.Mail.SaveManualOrder(G)
				u.Mail.SetStatus("Order paused: it will resume when the script starts again", "#FF4444")
				u.Mail.SetManualUiStatus("Paused. The order will resume when the script starts again", "#FF5555", "\226\154\160\239\184\143")
				u.Mail.RefreshManualUi()
				return
			end
			if not T.MailManualRunning then
				T.MailActiveOrder = nil
				u.Mail.RefreshManualUi()
				return
			end
			u.Mail.AddReceipt(u.Mail.BuildReceipt(G))
			u.Webhooks.QueueMail("manual", {
				orderId = tostring(G.id or "Unknown"),
				recipient = G.recipient and G.recipient.username or "Unknown",
				items = u.Webhooks.CopyMailItems(G.items)
			})
			u.Mail.ClearSavedManualOrder()
			table.clear(T.MailDraftItems)
			u.Mail.RefreshDraftUi()
			T.MailManualRunning = false
			T.MailActiveOrder = nil
			u.Mail.SetStatus(G.id .. " delivered", "#7CFC00")
			u.Mail.SetManualUiStatus(string.format("Completed %s to @%s", G.id, tostring(G.recipient.username or "?")), "#7CFC00", "\226\156\133")
			u.Mail.RefreshManualUi()
			T.Notify("Order delivered: " .. G.id, 4)
		end)
		return true
	end;
	StartManualOrder = function(G)
		if T.MailManualRunning then
			return false, "An order is already running"
		end
		if u.Mail.IsSavedManualOrderValid(e.mail_manual_order) then
			local G = u.Mail.RunManualOrder(e.mail_manual_order)
			return G, G and "Resumed " .. tostring(e.mail_manual_order.id) or "Could not resume the saved order"
		end
		if # T.MailDraftItems == 0 then
			return false, "Add at least one item"
		end
		local V, y = u.Mail.LookupRecipient(G)
		if not V then
			return false, y
		end
		local Z = {
			version = 1,
			id = u.Mail.MakeId("EXO");
			recipient = V;
			items = u.Mail.CloneDraftItems();
			pending = {};
			startedAt = os.time(),
			state = "running",
			batchTogether = e.mail_manual_batch_together == true
		}
		u.Mail.SaveManualOrder(Z)
		if not u.Mail.RunManualOrder(Z) then
			return false, "Could not start the order"
		end
		return true, "Started " .. Z.id
	end,
	ResumeManualOrder = function()
		if T.MailManualRunning then
			return false
		end
		local G = e.mail_manual_order
		if not u.Mail.IsSavedManualOrderValid(G) then
			return false
		end
		u.Mail.SetStatus("Resuming saved order " .. tostring(G.id), "#66CCFF")
		u.Mail.SetManualUiStatus("Resuming saved order " .. tostring(G.id), "#66CCFF", "\240\159\148\132")
		return u.Mail.RunManualOrder(G)
	end,
	StopManualOrder = function()
		if not T.MailManualRunning and not u.Mail.IsSavedManualOrderValid(e.mail_manual_order) then
			return false
		end
		local G = T.MailActiveOrder
		if type(G) == "table" then
			G.cancelled = true
		end
		T.MailManualRunning = false
		T.MailActiveOrder = nil
		u.Mail.ClearSavedManualOrder()
		u.Mail.RefreshDraftUi()
		u.Mail.SetStatus("Manual order stopped", "#FF7777")
		u.Mail.SetManualUiStatus("Order stopped", "#FF7777", "\226\143\185\239\184\143")
		u.Mail.RefreshManualUi()
		return true
	end,
	AddRule = function(G, V, y, Z, j, i, c, J, d, g, E, a, H)
		if type(G) ~= "table" or type(G.userId) ~= "number" then
			return false, "Invalid recipient"
		end
		V, y = u.Mail.DecodeItemSelection(V, y)
		if not u.Mail.IsGiftableCategory(V) then
			return false, "Select a category"
		end
		if type(y) ~= "string" or y == "" then
			return false, "Select an item"
		end
		Z = math.floor(tonumber(Z) or 0)
		j = math.floor(tonumber(j) or 0)
		if Z <= 0 or j <= 0 then
			return false, "Trigger and send amounts must be above 0"
		end
		local r, Y, s, N, W, X, h
		if V == "HarvestedFruits" then
			r, Y, s, N, W, X, h = u.Mail.NormaliseFruitFilters(J, d, g, E, a, H)
			if s then
				return false, s
			end
		end
		if type(e.mail_auto_rules) ~= "table" then
			e.mail_auto_rules = {}
		end
		local l = u.Mail.MakeId("RULE")
		e.mail_auto_rules[l] = {
			id = l;
			enabled = true,
			targetUserId = G.userId,
			targetUsername = G.username,
			targetDisplayName = G.displayName,
			category = V;
			itemName = y;
			triggerAmount = Z,
			sendAmount = j;
			petTypes = type(i) == "table" and i or {};
			petSizes = type(c) == "table" and c or {},
			fruitMinKg = r,
			fruitMaxKg = Y,
			fruitMutations = N or {},
			fruitVariants = W or {};
			fruitMutationBlacklist = X or {};
			fruitVariantBlacklist = h or {};
			filterKey = V == "HarvestedFruits" and u.Mail.GetFruitFilterKey(r, Y, N, W) or ""
		}
		q.Save.SaveDataSync()
		local B = T.MailUiRefs.RefreshRules
		if type(B) == "function" then
			B()
		end
		return true, l
	end;
	RemoveRule = function(G)
		local V = e.mail_auto_rules
		local y = type(V) == "table" and V[G]
		if type(y) ~= "table" then
			return false
		end
		y.enabled = false
		V[G] = nil
		u.Mail.RuleCooldowns[G] = nil
		q.Save.SaveDataSync()
		local Z = T.MailUiRefs.RefreshRules
		if type(Z) == "function" then
			Z()
		end
		return true
	end;
	ToggleRule = function(G)
		local V = type(e.mail_auto_rules) == "table" and e.mail_auto_rules[G]
		if type(V) ~= "table" then
			return false
		end
		V.enabled = V.enabled ~= true
		q.Save.SaveDataSync()
		local y = T.MailUiRefs.RefreshRules
		if type(y) == "function" then
			y()
		end
		return true, V.enabled
	end,
	GetRuleDropdown = function()
		local G = {}
		local V = type(e.mail_auto_rules) == "table" and e.mail_auto_rules or {}
		local y = {}
		for G, V in pairs(V) do
			if type(G) == "string" and type(V) == "table" then
				table.insert(y, G)
			end
		end
		table.sort(y)
		for y, Z in ipairs(y) do
			local j = V[Z]
			local i = u.Mail.GetItemDisplayName(j.category, j.itemName) .. u.Mail.GetFruitFilterText(j)
			local c = j.enabled == true and "ON" or "OFF"
			table.insert(G, {
				Text = string.format("%s | %s | %s x%d at %d | @%s", c, Z, i, tonumber(j.sendAmount) or 0, tonumber(j.triggerAmount) or 0, tostring(j.targetUsername or "?"));
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
		local J = e.mail_ignore_batch_limit and math.huge or u.Mail.MaxBatchItems
		for V, T in ipairs(V) do
			if J <= 0 then
				break
			end
			local d = G[T]
			local g = tonumber(u.Mail.RuleCooldowns[T]) or 0
			if type(d) ~= "table" or d.enabled ~= true or os.clock() < g then
				continue
			end
			local E = tonumber(d.targetUserId)
			if not E or E <= 0 then
				d.enabled = false
				q.Save.SaveDataSync()
				continue
			end
			if y and y.userId ~= E then
				continue
			end
			local a = tostring(d.category) .. ("::" .. (tostring(d.itemName) .. ("::" .. tostring(d.filterKey or ""))))
			local H = math.max(math.floor(tonumber(d.triggerAmount) or 1), 1)
			local r = math.max(math.floor(tonumber(d.sendAmount) or 1), 1)
			local Y = u.Mail.GetAvailableCount(d.category, d.itemName, d.petTypes, d.petSizes, nil, d.fruitMinKg, d.fruitMaxKg, d.fruitMutations, d.fruitVariants, d.fruitMutationBlacklist, d.fruitVariantBlacklist)
			if Y < H then
				continue
			end
			local e = Y
			if d.category == "Pets" or d.category == "HarvestedFruits" then
				e = u.Mail.GetAvailableCount(d.category, d.itemName, d.petTypes, d.petSizes, i, d.fruitMinKg, d.fruitMaxKg, d.fruitMutations, d.fruitVariants, d.fruitMutationBlacklist, d.fruitVariantBlacklist)
			else
				e = math.max(Y - ((c[a] or 0)), 0)
			end
			if e <= 0 then
				continue
			end
			local s = math.min(r, e, J)
			local N, W = u.Mail.BuildBatch(d.category, d.itemName, s, d.petTypes, d.petSizes, i, d.fruitMinKg, d.fruitMaxKg, d.fruitMutations, d.fruitVariants, d.fruitMutationBlacklist, d.fruitVariantBlacklist)
			if W <= 0 then
				continue
			end
			y = y or {
				userId = E,
				username = tostring(d.targetUsername or ""),
				displayName = tostring(d.targetDisplayName or d.targetUsername or "")
			}
			for G, V in ipairs(N) do
				table.insert(Z, V)
				if ((V.Category == "Pets" or V.Category == "HarvestedFruits")) and type(V.ItemKey) == "string" then
					i[V.ItemKey] = true
				end
			end
			if d.category ~= "Pets" and d.category ~= "HarvestedFruits" then
				c[a] = ((c[a] or 0)) + W
			end
			table.insert(j, {
				ruleId = T,
				rule = d,
				count = W
			})
			J -= W
		end
		if not y or # Z == 0 or # j == 0 then
			return 0
		end
		u.Mail.SetStatus(string.format("Auto | Sending %d items from %d rules to @%s", # Z, # j, y.username), "#66CCFF")
		local T, d = u.Mail.SendBatch(y, Z, string.format("Auto combined | %d rules", # j))
		if not T then
			for G, V in ipairs(j) do
				u.Mail.RuleCooldowns[V.ruleId] = os.clock() + u.Mail.RetryDelay
			end
			u.Mail.SetStatus("Auto combined send failed: " .. tostring(d), "#FF5555")
			return 0
		end
		local g = 0
		local E = {}
		local a = {}
		for G, V in ipairs(j) do
			local y = V.rule
			local Z = math.max(math.floor(tonumber(V.count) or 0), 0)
			local j = tostring(y.category) .. ("::" .. (tostring(y.itemName) .. ("::" .. tostring(y.filterKey or ""))))
			g += Z
			u.Mail.RuleCooldowns[V.ruleId] = os.clock() + 5
			local i = a[j]
			if not i then
				i = {
					category = y.category;
					name = u.Mail.GetItemDisplayName(y.category, y.itemName) .. u.Mail.GetFruitFilterText(y),
					count = 0
				}
				a[j] = i
				table.insert(E, i)
			end
			i.count += Z
		end
		u.Webhooks.QueueMail("automatic", {
			ruleId = string.format("Combined (%d rules)", # j);
			recipient = y.username;
			items = E
		})
		u.Mail.SetStatus(string.format("Auto | Sent %d items from %d rules to @%s", g, # j, y.username), "#7CFC00")
		return g
	end,
	ProcessAutoRules = function()
		if not e.mail_auto_send_enabled or T.MailManualRunning or u.Mail.Busy then
			return 0
		end
		local G = type(e.mail_auto_rules) == "table" and e.mail_auto_rules or {}
		local V = {}
		local y = 0
		for G, Z in pairs(G) do
			if type(G) == "string" and (type(Z) == "table" and Z.enabled == true) then
				y += 1
				table.insert(V, G)
			end
		end
		if y == 0 then
			u.Mail.SetStatus("Auto send waiting: add a rule", "#CFCFCF")
			return 0
		end
		table.sort(V)
		if e.mail_auto_batch_together then
			local y = u.Mail.ProcessCombinedAutoRules(G, V)
			if y <= 0 then
				u.Mail.SetStatus("Auto send waiting for matching items", "#CFCFCF")
			end
			return y
		end
		for V, y in ipairs(V) do
			local Z = G[y]
			local j = tonumber(u.Mail.RuleCooldowns[y]) or 0
			if os.clock() < j then
				continue
			end
			local i = u.Mail.GetAvailableCount(Z.category, Z.itemName, Z.petTypes, Z.petSizes, nil, Z.fruitMinKg, Z.fruitMaxKg, Z.fruitMutations, Z.fruitVariants, Z.fruitMutationBlacklist, Z.fruitVariantBlacklist)
			local c = math.max(math.floor(tonumber(Z.triggerAmount) or 1), 1)
			local J = math.max(math.floor(tonumber(Z.sendAmount) or 1), 1)
			if i < c then
				continue
			end
			local T = {
				userId = tonumber(Z.targetUserId);
				username = tostring(Z.targetUsername or ""),
				displayName = tostring(Z.targetDisplayName or Z.targetUsername or "")
			}
			if not T.userId or T.userId <= 0 then
				Z.enabled = false
				q.Save.SaveDataSync()
				continue
			end
			local d = math.min(J, i)
			local g = 0
			local E = {}
			while e.mail_auto_send_enabled and (Z.enabled == true and g < d) do
				local G = u.Mail.GetAvailableCount(Z.category, Z.itemName, Z.petTypes, Z.petSizes, E, Z.fruitMinKg, Z.fruitMaxKg, Z.fruitMutations, Z.fruitVariants, Z.fruitMutationBlacklist, Z.fruitVariantBlacklist)
				local V, j = u.Mail.BuildBatch(Z.category, Z.itemName, d - g, Z.petTypes, Z.petSizes, E, Z.fruitMinKg, Z.fruitMaxKg, Z.fruitMutations, Z.fruitVariants, Z.fruitMutationBlacklist, Z.fruitVariantBlacklist)
				if j <= 0 then
					break
				end
				local i = u.Mail.GetItemDisplayName(Z.category, Z.itemName)
				local c = g + j
				local J = string.format("Auto %s | %s | %d/%d", y, i, c, d)
				u.Mail.SetStatus(string.format("Auto | Sending %s %d/%d to @%s", i, c, d, T.username), "#66CCFF")
				local q, a = u.Mail.SendBatch(T, V, J)
				if not q then
					u.Mail.RuleCooldowns[y] = os.clock() + u.Mail.RetryDelay
					u.Mail.SetStatus("Auto send failed: " .. tostring(a), "#FF5555")
					return g
				end
				g = c
				for G, V in ipairs(V) do
					if V.Category == "Pets" or V.Category == "HarvestedFruits" then
						E[V.ItemKey] = true
					end
				end
				u.Mail.WaitForInventoryChange(Z.category, Z.itemName, G, Z.petTypes, Z.petSizes, Z.fruitMinKg, Z.fruitMaxKg, Z.fruitMutations, Z.fruitVariants, Z.fruitMutationBlacklist, Z.fruitVariantBlacklist)
			end
			u.Mail.RuleCooldowns[y] = os.clock() + 5
			if g > 0 then
				u.Webhooks.QueueMail("automatic", {
					ruleId = y;
					recipient = T.username,
					items = {
						{
							category = Z.category,
							name = u.Mail.GetItemDisplayName(Z.category, Z.itemName) .. u.Mail.GetFruitFilterText(Z);
							count = g
						}
					}
				})
				u.Mail.SetStatus(string.format("Auto | Sent %d %s to @%s", g, u.Mail.GetItemDisplayName(Z.category, Z.itemName) .. u.Mail.GetFruitFilterText(Z), T.username), "#7CFC00")
				return g
			end
		end
		u.Mail.SetStatus("Auto send waiting for matching items", "#CFCFCF")
		return 0
	end,
	ClaimInbox = function(G)
		if not G and not e.mail_auto_accept then
			return 0
		end
		if T.MailManualRunning or u.Mail.Busy then
			return 0
		end
		local V = y.Networking and y.Networking.Mailbox
		local Z = V and V.OpenInbox
		local j = V and V.Claim
		if not Z or type(Z.Fire) ~= "function" or not j or type(j.Fire) ~= "function" then
			return 0
		end
		u.Mail.Busy = true
		local i, c = pcall(function()
			return Z:Fire()
		end)
		if not i or type(c) ~= "table" then
			u.Mail.Busy = false
			return 0
		end
		local J = {}
		for G, V in pairs(c) do
			if type(G) == "string" and type(V) == "table" then
				table.insert(J, G)
			end
		end
		table.sort(J)
		local d = 0
		local q = {}
		for V, y in ipairs(J) do
			if not G and not e.mail_auto_accept then
				break
			end
			u.Mail.SetStatus(string.format("Claiming incoming mail %d/%d", V, # J), "#66CCFF")
			local Z, i, T = pcall(function()
				return j:Fire(y)
			end)
			if Z and i == true then
				d += 1
				local G = c[y]
				if type(G) == "table" then
					local V = G.Items
					if type(V) ~= "table" or # V == 0 then
						V = {
							G
						}
					end
					table.insert(q, {
						from = tostring(G.FromName or G.From or "Unknown");
						items = u.Webhooks.CopyMailItems(V)
					})
				end
				task.wait(u.Mail.ClaimDelay)
			elseif Z and (type(T) == "string" and T ~= "") then
				u.Mail.SetStatus("Claim failed: " .. T, "#FF5555")
				task.wait(1)
			else
				task.wait(1)
			end
		end
		u.Mail.Busy = false
		if d > 0 then
			u.Webhooks.QueueMail("claim", {
				count = d,
				mode = G and "Manual Claim" or "Automatic Claim";
				mails = q
			})
			u.Mail.SetStatus(string.format("Claimed %d incoming mail", d), "#7CFC00")
		elseif # J == 0 then
			u.Mail.SetStatus("Incoming mailbox is empty", "#CFCFCF")
		else
			u.Mail.SetStatus("Incoming mail could not be claimed", "#FF5555")
		end
		return d
	end,
	LoadEquippedPets = function()
		local G = y.Networking and (y.Networking.Pets and y.Networking.Pets.GetEquippedPets)
		if not G or type(G.Fire) ~= "function" then
			return false
		end
		local V, Z = pcall(function()
			return G:Fire()
		end)
		if not V or type(Z) ~= "table" then
			return false
		end
		table.clear(u.Mail.EquippedPets)
		for G, V in pairs(Z) do
			if type(V) == "table" and V.Id ~= nil then
				u.Mail.EquippedPets[tostring(V.Id)] = true
			end
		end
		return true
	end;
	MailLoopStart = function()
		if u.Mail.Started then
			return
		end
		u.Mail.Started = true
		u.Mail.TrimReceipts()
		if type(e.mail_auto_rules) ~= "table" then
			e.mail_auto_rules = {}
		end
		task.spawn(function()
			u.Mail.LoadEquippedPets()
			u.Mail.ResumeManualOrder()
		end)
		local G = y.Networking and y.Networking.Pets
		local V = G and G.PetEquipped
		local Z = G and G.PetUnequipped
		if V and V.OnClientEvent then
			V.OnClientEvent:Connect(function(G)
				if G ~= nil then
					u.Mail.EquippedPets[tostring(G)] = true
				end
			end)
		end
		if Z and Z.OnClientEvent then
			Z.OnClientEvent:Connect(function(G)
				if G ~= nil then
					u.Mail.EquippedPets[tostring(G)] = nil
				end
			end)
		end
		local j = y.Networking and (y.Networking.Mailbox and y.Networking.Mailbox.Updated)
		if j and j.OnClientEvent then
			j.OnClientEvent:Connect(function()
				if e.mail_auto_accept then
					task.defer(function()
						u.Mail.ClaimInbox(false)
					end)
				end
			end)
		end
		task.spawn(function()
			while true do
				task.wait(3)
				if not T.GetCheckIfPro() then
					break
				end
				local G, V = pcall(u.Mail.ProcessAutoRules)
				if not G then
					warn("[Mail] Auto rule error:", V)
					u.Mail.SetStatus("Auto send error", "#FF4444")
				end
			end
		end)
		task.spawn(function()
			while true do
				task.wait(12)
				if e.mail_auto_accept then
					local G, V = pcall(function()
						u.Mail.ClaimInbox(false)
					end)
					if not G then
						warn("[Mail] Auto claim error:", V)
					end
				end
			end
		end)
	end
}
u.Mail.TrimReceipts()
T.PetFinder_WebhookData = T.PetFinder_WebhookData or {}
T.Mail_WebhookData = T.Mail_WebhookData or {}
T.EventSeed_WebhookData = T.EventSeed_WebhookData or {}
T.PetFinderPremiumStatusText = ""
T.PetFinderPremiumUi = T.PetFinderPremiumUi or {}
u.PetFinderPremium = {
	Started = false,
	Busy = false;
	Folder = nil,
	Pets = {},
	FolderConnections = {},
	Pending = nil;
	Handled = {},
	RetryAt = {},
	Attempts = {};
	ExpectedCounts = {};
	MaxAttempts = 2;
	SizeRanks = {
		Normal = 1;
		Big = 2,
		Huge = 3
	};
	VariantRanks = {
		Normal = 1,
		Rainbow = 2
	},
	NextScanAt = 0;
	NextHopAt = 0,
	ScanDelay = 10,
	ConfirmTimeout = 3;
	SetStatus = function(G, V)
		T.PetFinderPremiumStatusText = string.format("<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\144\190 [Pet Finder Premium]</font> <font color=\'%s\'>%s</font></stroke>", tostring(V or "#FFFFFF"), tostring(G or "Waiting"))
	end;
	ClearStatus = function()
		T.PetFinderPremiumStatusText = ""
	end;
	GetServerTime = function()
		local G, V = pcall(function()
			return y.Workspace:GetServerTimeNow()
		end)
		return G and tonumber(V) or os.time()
	end;
	CopyMap = function(G)
		local V = {}
		if type(G) == "table" then
			for G, y in pairs(G) do
				if type(G) == "string" and (G ~= "" and y == true) then
					V[G] = true
				end
			end
		end
		return V
	end,
	GetDisplayName = function(G)
		local V = type(y.PetData) == "table" and y.PetData[G] or nil
		local Z = type(V) == "table" and V.DisplayName or nil
		return type(Z) == "string" and (Z ~= "" and Z) or tostring(G or "Unknown")
	end,
	GetPetLabel = function(G, V, y)
		local Z = {}
		if type(G) == "string" and (G ~= "" and G ~= "Normal") then
			table.insert(Z, G)
		end
		if type(V) == "string" and (V ~= "" and V ~= "Normal") then
			table.insert(Z, V)
		end
		table.insert(Z, tostring(y or "Unknown"))
		return table.concat(Z, " ")
	end;
	GetRarity = function(G, V)
		if type(V) == "string" and V ~= "" then
			return V
		end
		local Z = type(y.PetData) == "table" and y.PetData[G] or nil
		return type(Z) == "table" and tostring(Z.Rarity or "Unknown") or "Unknown"
	end,
	GetSize = function(G)
		if type(G) ~= "string" or G == "" then
			return "Normal"
		end
		local V = type(y.PetSizes) == "table" and (type(y.PetSizes.Normalize) == "function" and y.PetSizes.Normalize(G)) or nil
		return type(V) == "string" and (V ~= "" and V) or G
	end,
	GetVariant = function(G)
		return type(G) == "string" and (G ~= "" and G) or "Normal"
	end,
	GetInventoryPets = function()
		local G = u.DataReplica.GetData("Inventory")
		local V = type(G) == "table" and G.Pets or nil
		return type(V) == "table" and V or {}
	end;
	GetPetDropdown = function()
		local G = {}
		if type(y.PetData) ~= "table" then
			return G
		end
		for V, y in pairs(y.PetData) do
			if type(V) ~= "string" or V == "" or type(y) ~= "table" then
				continue
			end
			local Z = tostring(y.DisplayName or V)
			local j = tostring(y.Rarity or "Unknown")
			local i = tonumber(y.BasePrice) or 0
			local c = tostring(y.SpawnChance or 0)
			local d = u.Data.GetRarityColor(j)
			table.insert(G, {
				Text = string.format("<font color=\"#FFFFFF\">%s</font> <font color=\"#7CFC00\">$%s</font> <font color=\"%s\">%s</font> <font color=\"#CFCFCF\">(%%%s)</font>", Z, J.formatShecklesNumber(i), d, j, c);
				Value = V,
				Rank = T.RarityRank[j] or 0
			})
		end
		table.sort(G, function(G, V)
			if G.Rank ~= V.Rank then
				return G.Rank > V.Rank
			end
			return tostring(G.Value) < tostring(V.Value)
		end)
		return G
	end,
	GetOptionValues = function(G)
		local V = {
			Normal = true
		}
		if G == "Size" and (type(y.PetSizes) == "table" and type(y.PetSizes.Scales) == "table") then
			for G in pairs(y.PetSizes.Scales) do
				V[G] = true
			end
		elseif G == "Variant" and (type(y.PetTypes) == "table" and type(y.PetTypes.Rainbow) == "string") then
			V[y.PetTypes.Rainbow] = true
		end
		for y in pairs(u.PetFinderPremium.Pets) do
			if y and y.Parent then
				local Z = G == "Size" and u.PetFinderPremium.GetSize(y:GetAttribute("PetSize")) or u.PetFinderPremium.GetVariant(y:GetAttribute("PetType"))
				V[Z] = true
			end
		end
		for y, Z in pairs(u.PetFinderPremium.GetInventoryPets()) do
			if type(Z) == "table" then
				local y = G == "Size" and u.PetFinderPremium.GetSize(Z.Size) or u.PetFinderPremium.GetVariant(Z.Type)
				V[y] = true
			end
		end
		local Z = {}
		local j = G == "Size" and {
			Normal = 1;
			Big = 2,
			Huge = 3
		} or {
			Normal = 1;
			Rainbow = 2
		}
		for G in pairs(V) do
			table.insert(Z, G)
		end
		table.sort(Z, function(G, V)
			local y = j[G] or 100
			local Z = j[V] or 100
			if y ~= Z then
				return y < Z
			end
			return tostring(G) < tostring(V)
		end)
		local i = {}
		for G, V in ipairs(Z) do
			table.insert(i, {
				Text = V;
				Value = V
			})
		end
		return i
	end;
	GetSizeValues = function()
		return u.PetFinderPremium.GetOptionValues("Size")
	end,
	GetVariantValues = function()
		return u.PetFinderPremium.GetOptionValues("Variant")
	end;
	GetRule = function(G)
		local V = type(e.pet_finder_buy_list) == "table" and e.pet_finder_buy_list[G] or nil
		if type(V) ~= "table" then
			return nil
		end
		return {
			enabled = V.enabled == true;
			target = math.max(math.floor(tonumber(V.target) or 1), 1);
			sizes = u.PetFinderPremium.CopyMap(V.sizes),
			variants = u.PetFinderPremium.CopyMap(V.variants)
		}
	end,
	HasRule = function(G)
		return type(e.pet_finder_buy_list) == "table" and type(e.pet_finder_buy_list[G]) == "table"
	end;
	ResetPetRuntime = function(G)
		u.PetFinderPremium.ExpectedCounts[G] = nil
		for V in pairs(u.PetFinderPremium.Pets) do
			local y = V and (V.Parent and V:GetAttribute("PetName")) or nil
			if y == G then
				u.PetFinderPremium.Attempts[V] = nil
				u.PetFinderPremium.RetryAt[V] = nil
				u.PetFinderPremium.Handled[V] = nil
			end
		end
	end,
	SetRule = function(G, V, Z, j, i)
		if type(G) ~= "string" or G == "" or type(y.PetData) ~= "table" or not y.PetData[G] then
			return false
		end
		V = math.max(math.floor(tonumber(V) or 0), 0)
		if V <= 0 then
			return false
		end
		if type(e.pet_finder_buy_list) ~= "table" then
			e.pet_finder_buy_list = {}
		end
		e.pet_finder_buy_list[G] = {
			enabled = i == true,
			target = V;
			sizes = u.PetFinderPremium.CopyMap(Z);
			variants = u.PetFinderPremium.CopyMap(j)
		}
		u.PetFinderPremium.ResetPetRuntime(G)
		if i == true and u.PetFinderPremium.ResetHopTimer then
			u.PetFinderPremium.ResetHopTimer()
		end
		return true
	end,
	SetRuleEnabled = function(G, V)
		if not u.PetFinderPremium.HasRule(G) then
			return false
		end
		e.pet_finder_buy_list[G].enabled = V == true
		u.PetFinderPremium.ResetPetRuntime(G)
		if V == true and u.PetFinderPremium.ResetHopTimer then
			u.PetFinderPremium.ResetHopTimer()
		end
		return true
	end;
	GetActiveRuleNames = function()
		local G = {}
		if type(e.pet_finder_buy_list) ~= "table" then
			return G
		end
		for V in pairs(e.pet_finder_buy_list) do
			local y = u.PetFinderPremium.GetRule(V)
			if y and y.enabled then
				table.insert(G, V)
			end
		end
		table.sort(G)
		return G
	end;
	PassesSelection = function(G, V)
		return type(G) ~= "table" or next(G) == nil or G[V] == true
	end;
	PetNameMatches = function(G, V)
		return G == V or u.PetFinderPremium.GetDisplayName(G) == V
	end;
	CountOwnedRaw = function(G, V)
		local y = 0
		if type(V) ~= "table" then
			return y
		end
		for Z, j in pairs(u.PetFinderPremium.GetInventoryPets()) do
			if type(j) ~= "table" then
				continue
			end
			local i = j.Name or j.PetName or j.Species
			local c = u.PetFinderPremium.GetSize(j.Size)
			local J = u.PetFinderPremium.GetVariant(j.Type)
			if type(i) == "string" and (u.PetFinderPremium.PetNameMatches(G, i) and (u.PetFinderPremium.PassesSelection(V.sizes, c) and u.PetFinderPremium.PassesSelection(V.variants, J))) then
				y += 1
			end
		end
		return y
	end;
	CountOwnedForRule = function(G, V)
		local y = u.PetFinderPremium.CountOwnedRaw(G, V)
		local Z = u.PetFinderPremium.ExpectedCounts[G]
		if type(Z) ~= "table" or os.clock() >= ((tonumber(Z.expiresAt) or 0)) then
			u.PetFinderPremium.ExpectedCounts[G] = nil
			return y
		end
		if y >= ((tonumber(Z.count) or 0)) then
			u.PetFinderPremium.ExpectedCounts[G] = nil
			return y
		end
		return math.max(y, tonumber(Z.count) or 0)
	end,
	HasReachedTarget = function(G, V)
		return u.PetFinderPremium.CountOwnedForRule(G, V) >= V.target
	end,
	GetPetData = function(G)
		if not G or not G.Parent or not G:IsA("BasePart") then
			return nil
		end
		local V = G:GetAttribute("PetName")
		if type(V) ~= "string" or V == "" then
			return nil
		end
		local y = tonumber(G:GetAttribute("SpawnedAt")) or 0
		local Z = tonumber(G:GetAttribute("Lifetime")) or 0
		return {
			ref = G,
			id = G.Name,
			name = V;
			displayName = u.PetFinderPremium.GetDisplayName(V),
			size = u.PetFinderPremium.GetSize(G:GetAttribute("PetSize")),
			variant = u.PetFinderPremium.GetVariant(G:GetAttribute("PetType")),
			rarity = u.PetFinderPremium.GetRarity(V, G:GetAttribute("Rarity")),
			price = math.max(tonumber(G:GetAttribute("Price")) or 0, 0),
			ownerId = tonumber(G:GetAttribute("OwnerUserId")) or 0;
			expiresAt = y > 0 and (Z > 0 and y + Z) or 0
		}
	end;
	IsExpired = function(G)
		return G.expiresAt > 0 and u.PetFinderPremium.GetServerTime() >= G.expiresAt
	end,
	DisconnectFolder = function()
		for G, V in ipairs(u.PetFinderPremium.FolderConnections) do
			pcall(function()
				V:Disconnect()
			end)
		end
		table.clear(u.PetFinderPremium.FolderConnections)
	end;
	GetFolder = function()
		local G = y.Workspace:FindFirstChild("Map")
		local V = G and G:FindFirstChild("WildPetRef")
		return V and (V:IsA("Folder") and V) or nil
	end;
	BindFolder = function(G)
		if u.PetFinderPremium.Folder == G then
			return
		end
		u.PetFinderPremium.DisconnectFolder()
		u.PetFinderPremium.Folder = G
		table.clear(u.PetFinderPremium.Pets)
		table.clear(u.PetFinderPremium.Handled)
		table.clear(u.PetFinderPremium.RetryAt)
		table.clear(u.PetFinderPremium.Attempts)
		if not G then
			return
		end
		table.insert(u.PetFinderPremium.FolderConnections, G.ChildAdded:Connect(function(G)
			if G:IsA("BasePart") then
				u.PetFinderPremium.Pets[G] = true
				if T.PetFinderPremiumUi.RefreshValues then
					task.defer(T.PetFinderPremiumUi.RefreshValues)
				end
			end
		end))
		table.insert(u.PetFinderPremium.FolderConnections, G.ChildRemoved:Connect(function(G)
			u.PetFinderPremium.Pets[G] = nil
			u.PetFinderPremium.Handled[G] = nil
			u.PetFinderPremium.RetryAt[G] = nil
			u.PetFinderPremium.Attempts[G] = nil
		end))
	end;
	FullScan = function()
		u.PetFinderPremium.BindFolder(u.PetFinderPremium.GetFolder())
		local G = u.PetFinderPremium.Folder
		if G then
			for G, V in ipairs(G:GetChildren()) do
				if V:IsA("BasePart") then
					u.PetFinderPremium.Pets[V] = true
				end
			end
			for V in pairs(u.PetFinderPremium.Pets) do
				if typeof(V) ~= "Instance" or V.Parent ~= G then
					u.PetFinderPremium.Pets[V] = nil
					u.PetFinderPremium.Handled[V] = nil
					u.PetFinderPremium.RetryAt[V] = nil
					u.PetFinderPremium.Attempts[V] = nil
				end
			end
		end
		if T.PetFinderPremiumUi.RefreshValues then
			T.PetFinderPremiumUi.RefreshValues()
		end
		if T.PetFinderPremiumUi.RefreshRules then
			T.PetFinderPremiumUi.RefreshRules()
		end
	end;
	PassesRule = function(G, V)
		if not V or not V.enabled or G.ownerId ~= 0 or u.PetFinderPremium.IsExpired(G) then
			return false
		end
		if not u.PetFinderPremium.PassesSelection(V.sizes, G.size) or not u.PetFinderPremium.PassesSelection(V.variants, G.variant) or u.PetFinderPremium.HasReachedTarget(G.name, V) then
			return false
		end
		return ((tonumber(u.Money.GetSheckles()) or 0)) >= G.price
	end,
	GetCandidate = function()
		local G
		local V = 0
		local y = os.clock()
		local Z = u.PetFinderPremium.SizeRanks
		local j = u.PetFinderPremium.VariantRanks
		for i in pairs(u.PetFinderPremium.Pets) do
			if u.PetFinderPremium.Handled[i] or ((tonumber(u.PetFinderPremium.Attempts[i]) or 0)) >= u.PetFinderPremium.MaxAttempts or y < ((tonumber(u.PetFinderPremium.RetryAt[i]) or 0)) then
				continue
			end
			local c = u.PetFinderPremium.GetPetData(i)
			local J = c and u.PetFinderPremium.GetRule(c.name) or nil
			if c and u.PetFinderPremium.PassesRule(c, J) then
				V += 1
				if not G then
					G = c
				else
					local V = Z[G.size] or 100
					local y = Z[c.size] or 100
					local i = j[G.variant] or 100
					local J = j[c.variant] or 100
					if y < V or y == V and J < i or y == V and (J == i and tostring(c.id) < tostring(G.id)) then
						G = c
					end
				end
			end
		end
		return G, V
	end;
	GetTrackedCount = function()
		local G = 0
		for V in pairs(u.PetFinderPremium.Pets) do
			G += 1
		end
		return G
	end,
	AddPurchaseLog = function(G)
		if type(e.pet_finder_purchase_log) ~= "table" then
			e.pet_finder_purchase_log = {}
		end
		table.insert(e.pet_finder_purchase_log, 1, {
			pet = G.name,
			display_name = G.displayName;
			size = G.size;
			variant = G.variant;
			rarity = G.rarity,
			price = G.price,
			purchased_at = os.time()
		})
		while # e.pet_finder_purchase_log > 10 do
			table.remove(e.pet_finder_purchase_log)
		end
		q.Save.SaveDataSync()
		if T.PetFinderPremiumUi.RefreshLog then
			T.PetFinderPremiumUi.RefreshLog()
		end
	end,
	QueueWebhook = function(G)
		if not e.webhook_pet_buys or type(G) ~= "table" then
			return false
		end
		return u.Webhooks.Queue(T.PetFinder_WebhookData, {
			event = "pet_purchase",
			pet = G.name,
			display_name = G.displayName,
			size = G.size,
			variant = G.variant,
			rarity = G.rarity,
			price = tonumber(G.price) or 0;
			sheckles = tonumber(u.Money.GetSheckles()) or 0,
			purchased_at = os.time(),
			username = y.LocalPlayer and y.LocalPlayer.Name or "Unknown"
		})
	end,
	ConfirmPurchase = function(G)
		local V = u.PetFinderPremium.Pending
		if not V or V.confirmed then
			return false
		end
		V.confirmed = true
		V.reason = tostring(G or "Confirmed")
		u.PetFinderPremium.Handled[V.ref] = true
		u.PetFinderPremium.ExpectedCounts[V.data.name] = {
			count = V.countBefore + 1,
			expiresAt = os.clock() + 20
		}
		u.PetFinderPremium.AddPurchaseLog(V.data)
		u.PetFinderPremium.QueueWebhook(V.data)
		u.PetFinderPremium.ResetHopTimer()
		if T.PetFinderPremiumUi.RefreshRules then
			T.PetFinderPremiumUi.RefreshRules()
		end
		return true
	end;
	BuyPet = function(G)
		if u.PetFinderPremium.Busy or type(G) ~= "table" then
			return false
		end
		local V = G.ref
		local Z = u.PetFinderPremium.GetRule(G.name)
		local j = y.Networking and (y.Networking.Pets and y.Networking.Pets.WildPetTame)
		if not V or not V.Parent or not Z or not u.PetFinderPremium.PassesRule(G, Z) or not j or type(j.Fire) ~= "function" then
			return false
		end
		local i = T.TeleportLockNames.PetFinderPremium
		if not u.Teleport.LockTeleport(i, e.garden_items_use_player_walk and 35 or 6, e.garden_items_use_player_walk == true) then
			return false
		end
		u.PetFinderPremium.Busy = true
		u.PetFinderPremium.SetStatus("Buying " .. u.PetFinderPremium.GetPetLabel(G.size, G.variant, G.displayName), "#66CCFF")
		local c
		if e.garden_items_use_player_walk then
			c = u.Movement.WalkPathToTarget(V, 30, i, 10)
		else
			local G = u.StepTeleport.GetCFrame(V)
			local y = G and u.StepTeleport.FindGroundPosition(V, ((G + Vector3.new(5, 0, 0))).Position)
			c = y and u.StepTeleport.ToCFrame(CFrame.new(y), i)
		end
		if not c then
			u.PetFinderPremium.Busy = false
			u.Teleport.UnlockTeleport(i)
			return false
		end
		task.wait(.2)
		G = u.PetFinderPremium.GetPetData(V)
		Z = G and u.PetFinderPremium.GetRule(G.name) or nil
		if not G or not Z or not u.PetFinderPremium.PassesRule(G, Z) then
			u.PetFinderPremium.Busy = false
			u.Teleport.UnlockTeleport(i)
			return false
		end
		local J = {
			ref = V,
			data = G,
			countBefore = u.PetFinderPremium.CountOwnedForRule(G.name, Z);
			startedAt = os.clock(),
			confirmed = false
		}
		u.PetFinderPremium.Pending = J
		u.PetFinderPremium.Attempts[V] = ((tonumber(u.PetFinderPremium.Attempts[V]) or 0)) + 1
		local d = pcall(function()
			if not V or not V.Parent then
				error("Pet disappeared")
			end
			local G = tonumber(V:GetAttribute("OwnerUserId")) or 0
			if G ~= 0 then
				error("Pet is no longer available")
			end
			if not u.Teleport.TeleportTo(V, false, i) then
				error("Final pet teleport failed")
			end
			j:Fire(V)
		end)
		if d then
			repeat
				local G = tonumber(V:GetAttribute("OwnerUserId")) or 0
				if G == tonumber(T.player_userid) then
					u.PetFinderPremium.ConfirmPurchase("Ownership confirmed")
				elseif G ~= 0 then
					break
				end
				if J.confirmed or not e.pet_finder_enabled then
					break
				end
				task.wait(.05)
			until os.clock() - J.startedAt >= u.PetFinderPremium.ConfirmTimeout
		end
		local q = J.confirmed
		if q then
			local V = u.PetFinderPremium.CountOwnedForRule(G.name, Z)
			u.PetFinderPremium.SetStatus(string.format("Purchased %s | %d/%d", u.PetFinderPremium.GetPetLabel(G.size, G.variant, G.displayName), V, Z.target), "#7CFC00")
		elseif e.pet_finder_enabled then
			local y = tonumber(u.PetFinderPremium.Attempts[V]) or 0
			if y >= u.PetFinderPremium.MaxAttempts then
				u.PetFinderPremium.Handled[V] = true
				u.PetFinderPremium.SetStatus("Stopped retrying: " .. G.displayName, "#FFCC66")
			else
				u.PetFinderPremium.RetryAt[V] = os.clock() + 5
				u.PetFinderPremium.SetStatus("Purchase not confirmed: " .. G.displayName, "#FFCC66")
			end
		end
		u.PetFinderPremium.Pending = nil
		u.PetFinderPremium.Busy = false
		u.Teleport.UnlockTeleport(i)
		return q
	end,
	GetHopMinutes = function()
		return math.max(math.floor(tonumber(e.pet_finder_hop_minutes) or 5), 1)
	end;
	ResetHopTimer = function()
		u.PetFinderPremium.NextHopAt = os.clock() + u.PetFinderPremium.GetHopMinutes() * 60
	end,
	GetHopRemaining = function()
		if u.PetFinderPremium.NextHopAt <= 0 then
			u.PetFinderPremium.ResetHopTimer()
		end
		return math.max(math.ceil(u.PetFinderPremium.NextHopAt - os.clock()), 0)
	end;
	FormatTime = function(G)
		G = math.max(math.floor(tonumber(G) or 0), 0)
		return string.format("%dm %02ds", math.floor(G / 60), G % 60)
	end,
	HasUnmetTargets = function()
		for G, V in ipairs(u.PetFinderPremium.GetActiveRuleNames()) do
			local y = u.PetFinderPremium.GetRule(V)
			if y and not u.PetFinderPremium.HasReachedTarget(V, y) then
				return true
			end
		end
		return false
	end;
	UpdateIdle = function(G)
		local V = u.PetFinderPremium.GetTrackedCount()
		if not e.pet_finder_auto_hop then
			u.PetFinderPremium.SetStatus(string.format("Monitoring %d pet%s | %d ready", V, V == 1 and "" or "s", G or 0), "#CFCFCF")
			return
		end
		local y = u.PetFinderPremium.GetHopRemaining()
		if y > 0 then
			u.PetFinderPremium.SetStatus(string.format("Monitoring %d pet%s | Hop in %s", V, V == 1 and "" or "s", u.PetFinderPremium.FormatTime(y)), "#FFD966")
			return
		end
		local Z = T.TeleportLockNames.PetFinderPremium
		if u.Teleport.IsLocked(Z) then
			u.PetFinderPremium.SetStatus("Hop ready | Waiting for teleport", "#FFCC66")
			return
		end
		u.PetFinderPremium.SetStatus("Hopping to a new server...", "#66CCFF")
		u.PetFinderPremium.ResetHopTimer()
		r.Hop.HopToNewServer()
	end;
	Loop = function()
		if not T.GetCheckIfPro() then
			return
		end
		if os.clock() >= u.PetFinderPremium.NextScanAt then
			u.PetFinderPremium.NextScanAt = os.clock() + u.PetFinderPremium.ScanDelay
			u.PetFinderPremium.FullScan()
		end
		if not e.pet_finder_enabled then
			u.PetFinderPremium.ClearStatus()
			return
		end
		if # u.PetFinderPremium.GetActiveRuleNames() == 0 then
			u.PetFinderPremium.SetStatus("Paused: add an enabled pet rule", "#FFCC66")
			return
		end
		if not u.PetFinderPremium.HasUnmetTargets() then
			u.PetFinderPremium.SetStatus("All pet targets reached", "#7CFC00")
			return
		end
		if u.PetFinderPremium.Busy or u.PetFinderPremium.Pending then
			return
		end
		local G, V = u.PetFinderPremium.GetCandidate()
		if G then
			u.PetFinderPremium.BuyPet(G)
		else
			u.PetFinderPremium.UpdateIdle(V)
		end
	end;
	Start = function()
		if u.PetFinderPremium.Started then
			return
		end
		u.PetFinderPremium.Started = true
		u.PetFinderPremium.ResetHopTimer()
		u.PetFinderPremium.FullScan()
		local G = y.Networking and (y.Networking.Pets and y.Networking.Pets.WildPetTameResult)
		if G and G.OnClientEvent then
			G.OnClientEvent:Connect(function(G, V)
				local y = u.PetFinderPremium.Pending
				if y and (y.ref == G and tonumber(V) == tonumber(T.player_userid)) then
					u.PetFinderPremium.ConfirmPurchase("Tame result confirmed")
				end
			end)
		end
		task.spawn(function()
			while u.PetFinderPremium.Started do
				task.wait(.5)
				if not T.GetCheckIfPro() then
					continue
				end
				local G, V = pcall(u.PetFinderPremium.Loop)
				if not G then
					u.PetFinderPremium.Busy = false
					u.PetFinderPremium.Pending = nil
					u.Teleport.UnlockTeleport(T.TeleportLockNames.PetFinderPremium)
					u.PetFinderPremium.SetStatus("Error: pet finder loop failed", "#FF4444")
					warn("[PetFinderPremium]", V)
				end
			end
		end)
	end
}
T.WebhookStatusText = ""
u.Webhooks = {
	EventSeedListenerStarted = false;
	EventSeedConnection = nil,
	SetStatus = function(G, V)
		G = tostring(G or "")
		if G == "" then
			T.WebhookStatusText = ""
			return
		end
		T.WebhookStatusText = string.format("<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\148\148 [Webhooks]</font> <font color=\'%s\'>%s</font></stroke>", tostring(V or "#FFFFFF"), G)
	end;
	ClearStatus = function()
		T.WebhookStatusText = ""
	end;
	IsMailTypeEnabled = function(G)
		if G == "manual" then
			return e.webhook_mail_manual == true
		end
		if G == "automatic" then
			return e.webhook_mail_auto == true
		end
		if G == "claim" then
			return e.webhook_mail_claims == true
		end
		return false
	end;
	RemoveMailType = function(G)
		if type(T.Mail_WebhookData) ~= "table" then
			return
		end
		for V = # T.Mail_WebhookData, 1, - 1 do
			local y = T.Mail_WebhookData[V]
			if type(y) ~= "table" or y.webhookType == G then
				table.remove(T.Mail_WebhookData, V)
			end
		end
	end;
	CopyMailItems = function(G)
		local V = {}
		if type(G) ~= "table" then
			return V
		end
		for G, y in ipairs(G) do
			if type(y) ~= "table" then
				continue
			end
			local Z = tostring(y.category or y.Category or "Unknown")
			local j = tostring(y.itemName or y.ItemName or y.name or y.ItemKey or "Unknown")
			local i = math.max(math.floor(tonumber(y.amount or y.count or y.Count or 1) or 1), 1)
			table.insert(V, {
				category = Z;
				name = u.Mail.GetItemDisplayName(Z, j) .. u.Mail.GetFruitFilterText(y),
				count = i
			})
		end
		return V
	end,
	QueueMail = function(G, V)
		if not e.webhook_enabled then
			return false
		end
		if not u.Webhooks.IsMailTypeEnabled(G) or type(V) ~= "table" then
			return false
		end
		if type(T.Mail_WebhookData) ~= "table" then
			T.Mail_WebhookData = {}
		end
		V.webhookType = G
		V.queuedAt = os.time()
		return u.Webhooks.Queue(T.Mail_WebhookData, V)
	end,
	QueueEventSeed = function(G, V)
		if not e.webhook_enabled or not e.webhook_event_seeds or tostring(G or "") ~= tostring(y.LocalPlayer.Name) then
			return false
		end
		V = tostring(V or "")
		if V ~= "Gold Seed" and V ~= "Rainbow Seed" then
			return false
		end
		return u.Webhooks.Queue(T.EventSeed_WebhookData, {
			username = tostring(G),
			seed = V;
			queuedAt = os.time()
		})
	end,
	BuildEventSeedPayload = function(G)
		if type(G) ~= "table" then
			return nil
		end
		local V = tostring(G.seed or "")
		if V ~= "Gold Seed" and V ~= "Rainbow Seed" then
			return nil
		end
		local Z = V == "Rainbow Seed"
		return {
			username = "Exotic Hub",
			embeds = {
				{
					title = Z and "\240\159\140\136 Rainbow Seed Claimed!" or "\240\159\159\161 Gold Seed Claimed!";
					description = Z and "A rare **Rainbow Seed** was collected successfully!" or "A rare **Gold Seed** was collected successfully!",
					color = Z and 16729559 or 16766720,
					fields = {
						{
							name = "\240\159\140\177 Seed",
							value = "**" .. (V .. "**");
							inline = true
						};
						{
							name = "\240\159\145\164 Account",
							value = "||@" .. (tostring(G.username or "Unknown") .. "||"),
							inline = true
						}
					},
					footer = {
						text = tostring(y.AppName or "Exotic Hub") .. (" " .. tostring(y.CurentV or ""))
					};
					timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
				}
			}
		}
	end;
	StartEventSeedListener = function()
		if u.Webhooks.EventSeedListenerStarted then
			return false
		end
		local G = y.Networking and (y.Networking.SeedPackSpawn and y.Networking.SeedPackSpawn.Claimed)
		if not G or not G.OnClientEvent then
			return false
		end
		u.Webhooks.EventSeedListenerStarted = true
		u.Webhooks.EventSeedConnection = G.OnClientEvent:Connect(function(G, V)
			u.Webhooks.QueueEventSeed(G, V)
		end)
		return true
	end;
	TrimWebhookText = function(G, V)
		G = tostring(G or "")
		V = tonumber(V) or 1000
		if # G <= V then
			return G
		end
		return G:sub(1, V - 3) .. "..."
	end,
	StripWebhookRichText = function(G)
		G = tostring(G or "")
		G = G:gsub("<br%s*/?>", " ")
		G = G:gsub("<[^>]->", "")
		G = (G:gsub("&lt;", "<")):gsub("&gt;", ">")
		G = G:gsub("&amp;", "&")
		return G
	end,
	FormatMailCategoryWebhook = function(G)
		G = tostring(G or "")
		if G == "" or G == "Unknown" or G == "HarvestedFruits" then
			return ""
		end
		return " `" .. (G .. "`")
	end,
	BuildMailItemsText = function(G)
		local V = {}
		for G, y in ipairs(G or {}) do
			if type(y) ~= "table" then
				continue
			end
			local Z = u.Webhooks.StripWebhookRichText(y.name or "Unknown")
			local j = u.Webhooks.FormatMailCategoryWebhook(y.category)
			table.insert(V, string.format("\226\128\162 **x%d %s**%s", math.max(math.floor(tonumber(y.count) or 1), 1), Z, j))
		end
		if # V == 0 then
			return "No item details available"
		end
		return u.Webhooks.TrimWebhookText(table.concat(V, "\n"), 1000)
	end;
	BuildClaimedMailText = function(G)
		local V = {}
		for G, y in ipairs(G or {}) do
			if type(y) ~= "table" then
				continue
			end
			local Z = tostring(y.from or "Unknown")
			local j = type(y.items) == "table" and y.items or {}
			if # j == 0 then
				table.insert(V, "\226\128\162 From **@" .. (Z .. "**"))
				continue
			end
			for G, y in ipairs(j) do
				local j = u.Webhooks.StripWebhookRichText(y.name or "Unknown")
				local i = u.Webhooks.FormatMailCategoryWebhook(y.category)
				table.insert(V, string.format("\226\128\162 **@%s** \226\134\146 x%d %s%s", Z, math.max(math.floor(tonumber(y.count) or 1), 1), j, i))
			end
		end
		if # V == 0 then
			return "No item details available"
		end
		return u.Webhooks.TrimWebhookText(table.concat(V, "\n"), 1000)
	end;
	BuildMailPayload = function(G)
		if type(G) ~= "table" then
			return nil
		end
		local V = tostring(G.webhookType or "")
		local Z
		local j
		local i
		local c = {}
		if V == "manual" then
			Z = "\240\159\147\166 Manual Order Delivered!"
			j = "Your manual mailbox order was completed successfully."
			i = 5763719
			table.insert(c, {
				name = "\240\159\167\190 Order",
				value = tostring(G.orderId or "Unknown"),
				inline = true
			})
			table.insert(c, {
				name = "\240\159\145\164 Recipient",
				value = "||@" .. (tostring(G.recipient or "Unknown") .. "||");
				inline = true
			})
			table.insert(c, {
				name = "\240\159\147\166 Items Delivered";
				value = u.Webhooks.BuildMailItemsText(G.items),
				inline = false
			})
		elseif V == "automatic" then
			Z = "\226\154\153\239\184\143 Automatic Mail Sent!"
			j = "An automatic mailbox rule completed successfully."
			i = 3447003
			table.insert(c, {
				name = "\226\154\153\239\184\143 Rule";
				value = tostring(G.ruleId or "Unknown");
				inline = true
			})
			table.insert(c, {
				name = "\240\159\145\164 Recipient";
				value = "||@" .. (tostring(G.recipient or "Unknown") .. "||"),
				inline = true
			})
			table.insert(c, {
				name = "\240\159\147\164 Items Sent",
				value = u.Webhooks.BuildMailItemsText(G.items);
				inline = false
			})
		elseif V == "claim" then
			local V = math.max(math.floor(tonumber(G.count) or 0), 0)
			Z = "\240\159\147\165 Incoming Mail Claimed!"
			j = string.format("Successfully claimed **%d** incoming mail%s.", V, V == 1 and "" or "s")
			i = 10181046
			table.insert(c, {
				name = "\240\159\147\172 Claim Type",
				value = tostring(G.mode or "Unknown"),
				inline = true
			})
			table.insert(c, {
				name = "\226\156\133 Claimed",
				value = tostring(V),
				inline = true
			})
			table.insert(c, {
				name = "\240\159\142\129 Received Items",
				value = u.Webhooks.BuildClaimedMailText(G.mails);
				inline = false
			})
		else
			return nil
		end
		return {
			username = "Exotic Hub",
			embeds = {
				{
					title = Z,
					description = j,
					color = i;
					fields = c,
					footer = {
						text = tostring(y.AppName or "Exotic Hub") .. (" " .. tostring(y.CurentV or ""))
					},
					timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
				}
			}
		}
	end,
	IsValidUrl = function(G)
		return type(G) == "string" and (G ~= "" and G:match("^https?://[^%s]+$") ~= nil)
	end,
	GetRequestFunction = function()
		local G = _G
		if type(getgenv) == "function" then
			local V, y = pcall(getgenv)
			if V and type(y) == "table" then
				G = y
			end
		end
		local V = {
			"request",
			"http_request";
			"httprequest";
			"httpRequest"
		}
		for V, y in ipairs(V) do
			if type(G[y]) == "function" then
				return G[y]
			end
		end
		local y = {
			"syn",
			"http";
			"fluxus",
			"krnl"
		}
		for V, y in ipairs(y) do
			local Z = G[y]
			if type(Z) == "table" and type(Z.request) == "function" then
				return Z.request
			end
		end
		return nil
	end;
	Queue = function(G, V)
		if not e.webhook_enabled then
			return false
		end
		if type(G) ~= "table" or type(V) ~= "table" then
			return false
		end
		table.insert(G, V)
		return true
	end;
	GetPetBuyStyle = function(G, V, y, Z)
		G = tostring(G or "Normal")
		V = tostring(V or "Normal")
		y = tostring(y or "Unknown")
		local j = u.PetFinderPremium.GetPetLabel(G, V, y)
		local i = {
			title = "\240\159\144\190 You Bought a " .. (j .. "!"),
			message = "Pet purchase confirmed.",
			colour = Z
		}
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
	end;
	BuildPetBuyPayload = function(G)
		if type(G) ~= "table" then
			return nil
		end
		local V = tostring(G.rarity or "Unknown")
		local Z = u.Data.GetRarityColor(V)
		local j = tonumber(((tostring(Z)):gsub("#", "")), 16) or 5763719
		local i = tostring(G.size or "Normal")
		local c = tostring(G.variant or "Normal")
		local T = tostring(G.display_name or G.pet or "Unknown")
		local d = u.PetFinderPremium.GetPetLabel(i, c, T)
		local q = u.Webhooks.GetPetBuyStyle(i, c, T, j)
		return {
			username = "Exotic Hub",
			embeds = {
				{
					title = q.title,
					description = q.message .. ("\n\nBuyer: ||" .. (tostring(G.username or "Unknown") .. "||")),
					color = q.colour,
					fields = {
						{
							name = "\240\159\144\190 Pet";
							value = "**" .. (d .. "**");
							inline = false
						},
						{
							name = "\226\173\144 Rarity";
							value = V,
							inline = true
						},
						{
							name = "\240\159\146\176 Price",
							value = "$" .. J.formatShecklesNumber(G.price),
							inline = true
						},
						{
							name = "\240\159\147\143 Size";
							value = i,
							inline = true
						},
						{
							name = "\240\159\140\136 Variant",
							value = c;
							inline = true
						};
						{
							name = "\240\159\146\181 Current Sheckles",
							value = "$" .. J.formatShecklesNumber(G.sheckles);
							inline = true
						}
					};
					footer = {
						text = tostring(y.AppName or "Exotic Hub") .. (" " .. tostring(y.CurentV or ""))
					},
					timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
				}
			}
		}
	end;
	Post = function(G)
		local V = tostring(e.webhook_url or "")
		if type(G) ~= "table" then
			return false, "Invalid payload"
		end
		if not u.Webhooks.IsValidUrl(V) then
			return false, "Invalid webhook URL"
		end
		local Z, j = pcall(function()
			return y.HttpService:JSONEncode(G)
		end)
		if not Z or type(j) ~= "string" then
			return false, "JSON encode failed"
		end
		local i = u.Webhooks.GetRequestFunction()
		if i then
			local G, y = pcall(function()
				return i({
					Url = V;
					Method = "POST";
					Headers = {
						["Content-Type"] = "application/json"
					},
					Body = j
				})
			end)
			if not G then
				return false, tostring(y)
			end
			if type(y) == "table" then
				local G = tonumber(y.StatusCode or y.Status or y.status_code)
				if G then
					return G >= 200 and G < 300, tostring(G)
				end
				if y.Success ~= nil then
					return y.Success == true, tostring(y.StatusMessage or "")
				end
			end
			return true
		end
		local c, J = pcall(function()
			y.HttpService:PostAsync(V, j, Enum.HttpContentType.ApplicationJson, false)
		end)
		if not c then
			return false, tostring(J)
		end
		return true
	end;
	GetPendingCount = function()
		local G = 0
		if e.webhook_pet_buys and type(T.PetFinder_WebhookData) == "table" then
			G += # T.PetFinder_WebhookData
		end
		if type(T.Mail_WebhookData) == "table" then
			for V, y in ipairs(T.Mail_WebhookData) do
				if type(y) == "table" and u.Webhooks.IsMailTypeEnabled(y.webhookType) then
					G += 1
				end
			end
		end
		if e.webhook_event_seeds and type(T.EventSeed_WebhookData) == "table" then
			G += # T.EventSeed_WebhookData
		end
		return G
	end,
	GetNextWebhook = function()
		if e.webhook_pet_buys and type(T.PetFinder_WebhookData) == "table" then
			while # T.PetFinder_WebhookData > 0 do
				local G = T.PetFinder_WebhookData[1]
				if type(G) ~= "table" then
					table.remove(T.PetFinder_WebhookData, 1)
					continue
				end
				local V = u.Webhooks.BuildPetBuyPayload(G)
				if not V then
					table.remove(T.PetFinder_WebhookData, 1)
					continue
				end
				return T.PetFinder_WebhookData, 1, V, "pet purchase"
			end
		end
		if e.webhook_event_seeds and type(T.EventSeed_WebhookData) == "table" then
			while # T.EventSeed_WebhookData > 0 do
				local G = T.EventSeed_WebhookData[1]
				if type(G) ~= "table" then
					table.remove(T.EventSeed_WebhookData, 1)
					continue
				end
				local V = u.Webhooks.BuildEventSeedPayload(G)
				if not V then
					table.remove(T.EventSeed_WebhookData, 1)
					continue
				end
				return T.EventSeed_WebhookData, 1, V, "event seed"
			end
		end
		if type(T.Mail_WebhookData) ~= "table" then
			T.Mail_WebhookData = {}
		end
		while # T.Mail_WebhookData > 0 do
			local G = T.Mail_WebhookData[1]
			if type(G) ~= "table" or not u.Webhooks.IsMailTypeEnabled(G.webhookType) then
				table.remove(T.Mail_WebhookData, 1)
				continue
			end
			local V = u.Webhooks.BuildMailPayload(G)
			if not V then
				table.remove(T.Mail_WebhookData, 1)
				continue
			end
			local y = {
				manual = "manual order";
				automatic = "automatic mail",
				claim = "claimed mail"
			}
			return T.Mail_WebhookData, 1, V, y[G.webhookType] or "mail notification"
		end
		return nil
	end,
	ProcessNext = function()
		local G = e.webhook_pet_buys or e.webhook_event_seeds or e.webhook_mail_manual or e.webhook_mail_auto or e.webhook_mail_claims
		if not G then
			u.Webhooks.ClearStatus()
			return false
		end
		local V = u.Webhooks.GetPendingCount()
		if not u.Webhooks.IsValidUrl(e.webhook_url) then
			if V > 0 then
				u.Webhooks.SetStatus(string.format("Add webhook URL | Pending: %d", V), "#FFCC66")
			else
				u.Webhooks.SetStatus("Add webhook URL", "#FFCC66")
			end
			return false
		end
		if V == 0 then
			u.Webhooks.SetStatus("Ready", "#CFCFCF")
			return false
		end
		local y, Z, j, i = u.Webhooks.GetNextWebhook()
		if not y or not j then
			u.Webhooks.SetStatus("Ready", "#CFCFCF")
			return false
		end
		u.Webhooks.SetStatus(string.format("Sending %s | Pending: %d", i, V), "#66CCFF")
		local c, J = u.Webhooks.Post(j)
		if not c then
			u.Webhooks.SetStatus(string.format("Send failed | Pending: %d", V), "#FF5555")
			warn("[Webhooks]", J)
			return false
		end
		table.remove(y, Z)
		u.Webhooks.SetStatus(string.format("%s sent | Pending: %d", i, u.Webhooks.GetPendingCount()), "#7CFC00")
		return true
	end,
	Loop = function()
		if not e.webhook_enabled then
			u.Webhooks.ClearStatus()
			return
		end
		local G, V = pcall(function()
			u.Webhooks.ProcessNext()
		end)
		if not G then
			u.Webhooks.SetStatus("Webhook loop error", "#FF5555")
			warn("[Webhooks] Loop error:", V)
		end
	end
}
u.Webhooks.StartEventSeedListener()
u.PackOpeningWebhook = {
	StartedPackOpeningWebhook = false,
	ListenerStartedPackOpeningWebhook = false,
	SeenPackOpeningWebhook = {};
	SetStatusPackOpeningWebhook = function(G, V)
		G = tostring(G or "")
		if G == "" then
			T.PackOpeningWebhookStatusText = ""
			return false
		end
		T.PackOpeningWebhookStatusText = string.format("<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\148\148 [Open Results]</font> <font color=\'%s\'>%s</font></stroke>", tostring(V or "#FFFFFF"), G)
		return true
	end,
	GetColourPackOpeningWebhook = function(G)
		local V = u.Data.GetRarityColor(tostring(G or "Unknown"))
		return tonumber(((tostring(V)):gsub("#", "")), 16) or 5763719
	end;
	MarkSeenPackOpeningWebhook = function(G)
		G = tostring(G or "")
		if G == "" then
			return false
		end
		local V = os.clock()
		for G, y in pairs(u.PackOpeningWebhook.SeenPackOpeningWebhook) do
			if V - y > 300 then
				u.PackOpeningWebhook.SeenPackOpeningWebhook[G] = nil
			end
		end
		if u.PackOpeningWebhook.SeenPackOpeningWebhook[G] then
			return false
		end
		u.PackOpeningWebhook.SeenPackOpeningWebhook[G] = V
		return true
	end,
	PassesEggFiltersPackOpeningWebhook = function(G)
		if type(G) ~= "table" then
			return false
		end
		return u.PackOpenHelpers.PassesSelectedPackOpenHelpers(e.egg_hatcher_webhook_pets, G.pet) and (u.PackOpenHelpers.PassesSelectedPackOpenHelpers(e.egg_hatcher_webhook_rarities, G.rarity) and (u.PackOpenHelpers.PassesSelectedPackOpenHelpers(e.egg_hatcher_webhook_sizes, G.size) and u.PackOpenHelpers.PassesSelectedPackOpenHelpers(e.egg_hatcher_webhook_variants, G.variant)))
	end;
	PassesSeedPackFiltersPackOpeningWebhook = function(G)
		if type(G) ~= "table" then
			return false
		end
		return u.PackOpenHelpers.PassesSelectedPackOpenHelpers(e.seed_pack_opener_webhook_seeds, G.seed) and u.PackOpenHelpers.PassesSelectedPackOpenHelpers(e.seed_pack_opener_webhook_rarities, G.rarity)
	end;
	QueueEggHatchPackOpeningWebhook = function(G, V, Z, j, i)
		if not e.webhook_enabled or not e.egg_hatcher_webhook_enabled then
			return false
		end
		V = tostring(V or "")
		Z = tostring(Z or "")
		if V == "" or Z == "" then
			return false
		end
		local c = {
			openId = tostring(G or "");
			egg = V,
			pet = Z;
			displayName = u.PackOpenHelpers.GetPetDisplayNamePackOpenHelpers(Z);
			rarity = u.PackOpenHelpers.GetPetRarityPackOpenHelpers(Z);
			size = u.PackOpenHelpers.NormaliseSizePackOpenHelpers(j);
			variant = u.PackOpenHelpers.NormaliseVariantPackOpenHelpers(i),
			username = tostring(y.LocalPlayer and y.LocalPlayer.Name or "Unknown");
			queuedAt = os.time()
		}
		local J = "egg|" .. (c.openId .. ("|" .. (c.egg .. ("|" .. (c.pet .. ("|" .. (c.size .. ("|" .. c.variant))))))))
		if not u.PackOpeningWebhook.MarkSeenPackOpeningWebhook(J) or not u.PackOpeningWebhook.PassesEggFiltersPackOpeningWebhook(c) then
			return false
		end
		table.insert(T.EggHatcherWebhookData, c)
		return true
	end,
	QueueSeedPackPackOpeningWebhook = function(G, V, Z)
		if not e.webhook_enabled or not e.seed_pack_opener_webhook_enabled then
			return false
		end
		V = tostring(V or "")
		Z = tostring(Z or "")
		if V == "" or Z == "" then
			return false
		end
		local j = {
			openId = tostring(G or ""),
			pack = V;
			seed = Z;
			rarity = u.PackOpenHelpers.GetSeedRarityPackOpenHelpers(Z);
			username = tostring(y.LocalPlayer and y.LocalPlayer.Name or "Unknown"),
			queuedAt = os.time()
		}
		local i = "seedpack|" .. (j.openId .. ("|" .. (j.pack .. ("|" .. j.seed))))
		if not u.PackOpeningWebhook.MarkSeenPackOpeningWebhook(i) or not u.PackOpeningWebhook.PassesSeedPackFiltersPackOpeningWebhook(j) then
			return false
		end
		table.insert(T.SeedPackOpenerWebhookData, j)
		return true
	end;
	BuildEggPayloadPackOpeningWebhook = function(G)
		if type(G) ~= "table" then
			return nil
		end
		local V = tostring(G.displayName or G.pet or "Unknown")
		if tostring(G.size or "Normal") ~= "Normal" then
			V = tostring(G.size) .. (" " .. V)
		end
		if tostring(G.variant or "Normal") ~= "Normal" then
			V = tostring(G.variant) .. (" " .. V)
		end
		return {
			username = "Exotic Hub";
			embeds = {
				{
					title = "\240\159\165\154 Egg Hatched!";
					description = "A pet hatched from an egg.",
					color = u.PackOpeningWebhook.GetColourPackOpeningWebhook(G.rarity);
					fields = {
						{
							name = "\240\159\165\154 Egg",
							value = "**" .. (tostring(G.egg or "Unknown") .. "**");
							inline = true
						},
						{
							name = "\240\159\144\190 Pet",
							value = "**" .. (V .. "**"),
							inline = true
						},
						{
							name = "\226\173\144 Rarity";
							value = tostring(G.rarity or "Unknown"),
							inline = true
						};
						{
							name = "\240\159\147\143 Size";
							value = tostring(G.size or "Normal"),
							inline = true
						};
						{
							name = "\240\159\140\136 Variant",
							value = tostring(G.variant or "Normal");
							inline = true
						};
						{
							name = "\240\159\145\164 Account",
							value = "||@" .. (tostring(G.username or "Unknown") .. "||"),
							inline = true
						}
					};
					footer = {
						text = tostring(y.AppName or "Exotic Hub") .. (" " .. tostring(y.CurentV or ""))
					},
					timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
				}
			}
		}
	end,
	BuildSeedPackPayloadPackOpeningWebhook = function(G)
		if type(G) ~= "table" then
			return nil
		end
		return {
			username = "Exotic Hub",
			embeds = {
				{
					title = "\240\159\142\129 Seed Pack Opened!",
					description = "A seed pack produced a seed.",
					color = u.PackOpeningWebhook.GetColourPackOpeningWebhook(G.rarity),
					fields = {
						{
							name = "\240\159\142\129 Pack";
							value = "**" .. (tostring(G.pack or "Unknown") .. "**");
							inline = true
						};
						{
							name = "\240\159\140\177 Seed",
							value = "**" .. (tostring(G.seed or "Unknown") .. "**");
							inline = true
						},
						{
							name = "\226\173\144 Rarity";
							value = tostring(G.rarity or "Unknown");
							inline = true
						};
						{
							name = "\240\159\145\164 Account",
							value = "||@" .. (tostring(G.username or "Unknown") .. "||");
							inline = true
						}
					},
					footer = {
						text = tostring(y.AppName or "Exotic Hub") .. (" " .. tostring(y.CurentV or ""))
					};
					timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
				}
			}
		}
	end;
	GetPendingCountPackOpeningWebhook = function()
		local G = 0
		if e.egg_hatcher_webhook_enabled and type(T.EggHatcherWebhookData) == "table" then
			G += # T.EggHatcherWebhookData
		end
		if e.seed_pack_opener_webhook_enabled and type(T.SeedPackOpenerWebhookData) == "table" then
			G += # T.SeedPackOpenerWebhookData
		end
		return G
	end,
	ProcessPackOpeningWebhook = function()
		if not e.webhook_enabled then
			u.PackOpeningWebhook.SetStatusPackOpeningWebhook("")
			return false
		end
		local G
		local V
		local y = "open result"
		if e.egg_hatcher_webhook_enabled and (type(T.EggHatcherWebhookData) == "table" and # T.EggHatcherWebhookData > 0) then
			V = T.EggHatcherWebhookData
			G = u.PackOpeningWebhook.BuildEggPayloadPackOpeningWebhook(V[1])
			y = "egg hatch"
		elseif e.seed_pack_opener_webhook_enabled and (type(T.SeedPackOpenerWebhookData) == "table" and # T.SeedPackOpenerWebhookData > 0) then
			V = T.SeedPackOpenerWebhookData
			G = u.PackOpeningWebhook.BuildSeedPackPayloadPackOpeningWebhook(V[1])
			y = "seed pack"
		end
		if not V or not G then
			local G = u.PackOpeningWebhook.GetPendingCountPackOpeningWebhook()
			if G <= 0 then
				u.PackOpeningWebhook.SetStatusPackOpeningWebhook("")
			end
			return false
		end
		if not u.Webhooks or type(u.Webhooks.Post) ~= "function" or not u.Webhooks.IsValidUrl(e.webhook_url) then
			u.PackOpeningWebhook.SetStatusPackOpeningWebhook("Add webhook URL | Pending: " .. tostring(u.PackOpeningWebhook.GetPendingCountPackOpeningWebhook()), "#FFCC66")
			return false
		end
		u.PackOpeningWebhook.SetStatusPackOpeningWebhook("Sending " .. (y .. (" | Pending: " .. tostring(u.PackOpeningWebhook.GetPendingCountPackOpeningWebhook()))), "#66CCFF")
		local Z, j = u.Webhooks.Post(G)
		if not Z then
			u.PackOpeningWebhook.SetStatusPackOpeningWebhook("Send failed | Pending: " .. tostring(u.PackOpeningWebhook.GetPendingCountPackOpeningWebhook()), "#FF5555")
			warn("[PackOpeningWebhook]", j)
			return false
		end
		table.remove(V, 1)
		u.PackOpeningWebhook.SetStatusPackOpeningWebhook(y .. (" sent | Pending: " .. tostring(u.PackOpeningWebhook.GetPendingCountPackOpeningWebhook())), "#7CFC00")
		return true
	end,
	HookPackOpeningListenersPackOpeningWebhook = function()
		if u.PackOpeningWebhook.ListenerStartedPackOpeningWebhook then
			return false
		end
		u.PackOpeningWebhook.ListenerStartedPackOpeningWebhook = true
		local G = y.Networking and (y.Networking.Egg and y.Networking.Egg.ReplicateOpenEgg)
		if G and G.OnClientEvent then
			G.OnClientEvent:Connect(function(G, V, Z, j, i, c, J)
				if G == y.LocalPlayer then
					u.PackOpeningWebhook.QueueEggHatchPackOpeningWebhook(V, Z, j, c, J)
				end
			end)
		end
		local V = y.Networking and (y.Networking.SeedPack and y.Networking.SeedPack.ReplicateOpenSeedPack)
		if V and V.OnClientEvent then
			V.OnClientEvent:Connect(function(G, V, Z, j, i)
				if G == y.LocalPlayer then
					u.PackOpeningWebhook.QueueSeedPackPackOpeningWebhook(V, Z, j)
				end
			end)
		end
		return true
	end,
	StartPackOpeningWebhook = function()
		if u.PackOpeningWebhook.StartedPackOpeningWebhook then
			return false
		end
		u.PackOpeningWebhook.StartedPackOpeningWebhook = true
		u.PackOpeningWebhook.HookPackOpeningListenersPackOpeningWebhook()
		task.spawn(function()
			while not T.is_forced_stop do
				task.wait(3)
				local G, V = pcall(u.PackOpeningWebhook.ProcessPackOpeningWebhook)
				if not G then
					u.PackOpeningWebhook.SetStatusPackOpeningWebhook("Webhook error", "#FF5555")
					warn("[PackOpeningWebhook]", V)
				end
			end
		end)
		return true
	end
}
u.PackOpeningWebhook.StartPackOpeningWebhook()
T.MoonPredictorStatusText = ""
u.MoonPredictor = {
	Started = false;
	DebugBusy = false,
	Label = nil;
	RollMode = "number";
	ValidationText = "Waiting for a night to validate";
	Colours = {
		Moon = "#B7C9FF",
		Goldmoon = "#FFD700";
		["Rainbow Moon"] = "#FF66FF";
		Bloodmoon = "#FF4444"
	};
	GetNight = function()
		local G = y.TimeCycleData and (y.TimeCycleData.Data and y.TimeCycleData.Data.Night)
		if type(G) ~= "table" or type(G.Weathers) ~= "table" then
			return nil
		end
		return G
	end;
	GetServerTime = function()
		local G, V = pcall(function()
			return y.Workspace:GetServerTimeNow()
		end)
		return G and tonumber(V) or os.time()
	end,
	Pick = function(G, V)
		local y = u.MoonPredictor.GetNight()
		if not y then
			return nil
		end
		local Z = 0
		for G, V in y.Weathers do
			if type(V) == "table" then
				Z += tonumber(V.Chance) or 0
			end
		end
		if Z <= 0 then
			return nil
		end
		local j = math.floor(tonumber(G) or 0) * 1000 + 3
		local i = Random.new(j)
		local c = V == "integer" and i:NextInteger(1, math.floor(Z)) or i:NextNumber(0, Z)
		local J = 0
		for G, V in y.Weathers do
			if type(V) ~= "table" then
				continue
			end
			J += tonumber(V.Chance) or 0
			if c <= J then
				return tostring(G), c, j
			end
		end
		return "Moon", c, j
	end,
	ValidateCurrent = function()
		if tostring(y.Workspace:GetAttribute("ActivePhase") or "") ~= "Night" then
			return false
		end
		local G = tostring(y.Workspace:GetAttribute("ActiveWeather") or "")
		local V = u.MoonPredictor.GetNight()
		if not V or type(V.Weathers[G]) ~= "table" then
			return false
		end
		local Z = math.floor(os.time() / 600)
		local j = u.MoonPredictor.Pick(Z, "number")
		local i = u.MoonPredictor.Pick(Z, "integer")
		if j == G and i ~= G then
			u.MoonPredictor.RollMode = "number"
			u.MoonPredictor.ValidationText = "NextNumber confirmed by live moon"
			return true
		end
		if i == G and j ~= G then
			u.MoonPredictor.RollMode = "integer"
			u.MoonPredictor.ValidationText = "NextInteger confirmed by live moon"
			return true
		end
		if j == G and i == G then
			u.MoonPredictor.ValidationText = "Both methods match the live moon"
			return true
		end
		u.MoonPredictor.ValidationText = "Live moon differs; it may be forced"
		return false
	end;
	GetNextNightAt = function()
		local G = u.MoonPredictor.GetServerTime()
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
				return Z
			end
		end
		local J = math.floor(G / 600) * 600
		local T = (J + i) + c
		return G < T and T or T + 600
	end,
	GetRare = function(G, V)
		G = math.clamp(math.floor(tonumber(G) or 1), 1, 20)
		V = V == "integer" and "integer" or "number"
		local y = u.MoonPredictor.GetNextNightAt()
		local Z = math.floor(y / 600)
		local j = {}
		for i = 0, 999, 1 do
			local c, J, T = u.MoonPredictor.Pick(Z + i, V)
			if c and c ~= "Moon" then
				table.insert(j, {
					Name = c,
					At = y + i * 600,
					Roll = J,
					Seed = T
				})
				if # j >= G then
					break
				end
			end
		end
		return j
	end;
	FormatTime = function(G)
		G = math.max(math.floor(tonumber(G) or 0), 0)
		local V = math.floor(G / 3600)
		local y = math.floor(((G % 3600)) / 60)
		local Z = G % 60
		if V > 0 then
			return string.format("%dh %02dm", V, y)
		end
		if y > 0 then
			return string.format("%dm %02ds", y, Z)
		end
		return string.format("%ds", Z)
	end;
	GetLines = function(G, V, y)
		local Z = u.MoonPredictor.GetServerTime()
		local j = {}
		for G, V in ipairs(u.MoonPredictor.GetRare(V, G)) do
			if y then
				table.insert(j, string.format("%d. **%s** \226\128\148 <t:%d:R> (`%d`)", G, V.Name, math.floor(V.At), V.Seed))
			else
				local G = u.MoonPredictor.Colours[V.Name] or "#FFFFFF"
				table.insert(j, string.format("<font color=\'%s\'>%s</font> <font color=\'#7CFC00\'>in %s</font>", G, V.Name, u.MoonPredictor.FormatTime(V.At - Z)))
			end
		end
		return j
	end;
	Update = function()
		if not e.moon_predictor_enabled then
			T.MoonPredictorStatusText = ""
			if u.MoonPredictor.Label and type(u.MoonPredictor.Label.SetText) == "function" then
				u.MoonPredictor.Label:SetText("<font color=\'#AFAFAF\'>Moon predictor disabled.</font>")
			end
			return
		end
		u.MoonPredictor.ValidateCurrent()
		local G = u.MoonPredictor.GetServerTime()
		local V = tostring(y.Workspace:GetAttribute("ActivePhase") or "Unknown")
		local Z = tostring(y.Workspace:GetAttribute("ActiveWeather") or "Unknown")
		local j = tonumber(y.Workspace:GetAttribute("PhaseDuration")) or G
		local i = {}
		if V == "Night" then
			table.insert(i, string.format("<b>Current:</b> <font color=\'%s\'>%s</font> <font color=\'#AFAFAF\'>(%s left)</font>", u.MoonPredictor.Colours[Z] or "#FFFFFF", Z, u.MoonPredictor.FormatTime(j - G)))
		else
			table.insert(i, string.format("<b>Next Night:</b> <font color=\'#B7C9FF\'>in %s</font>", u.MoonPredictor.FormatTime(u.MoonPredictor.GetNextNightAt() - G)))
		end
		table.insert(i, "<font color=\'#AFAFAF\'>Upcoming rare moons:</font>")
		for G, V in ipairs(u.MoonPredictor.GetLines(u.MoonPredictor.RollMode, 8, false)) do
			table.insert(i, V)
		end
		if u.MoonPredictor.Label and type(u.MoonPredictor.Label.SetText) == "function" then
			u.MoonPredictor.Label:SetText(table.concat(i, "\n"))
		end
		local c = (u.MoonPredictor.GetRare(1, u.MoonPredictor.RollMode))[1]
		if not c then
			T.MoonPredictorStatusText = ""
			return
		end
		T.MoonPredictorStatusText = string.format("<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\140\153 [Moon]</font> <font color=\'%s\'>%s in %s</font></stroke>", u.MoonPredictor.Colours[c.Name] or "#FFFFFF", c.Name, u.MoonPredictor.FormatTime(c.At - G))
	end,
	SendDebugPost = function()
		if u.MoonPredictor.DebugBusy then
			return false, "Debug post already running"
		end
		if not e.webhook_enabled or not u.Webhooks.IsValidUrl(e.webhook_url) then
			return false, "Add and enable your webhook first"
		end
		u.MoonPredictor.DebugBusy = true
		u.MoonPredictor.ValidateCurrent()
		local G = math.floor(os.time() / 600)
		local V, Z, j = u.MoonPredictor.Pick(G, "number")
		local i, c, J = u.MoonPredictor.Pick(G, "integer")
		local T = table.concat(u.MoonPredictor.GetLines("number", 12, true), "\n")
		local d = table.concat(u.MoonPredictor.GetLines("integer", 12, true), "\n")
		local q = {
			username = "Exotic Hub";
			embeds = {
				{
					title = "\240\159\140\153 Moon Predictor Debug";
					description = string.format("Live: **%s / %s**\nNext Night: <t:%d:R>\nSelected: **%s**\nValidation: %s", tostring(y.Workspace:GetAttribute("ActivePhase") or "Unknown"), tostring(y.Workspace:GetAttribute("ActiveWeather") or "Unknown"), math.floor(u.MoonPredictor.GetNextNightAt()), u.MoonPredictor.RollMode, u.MoonPredictor.ValidationText),
					color = 9268223,
					fields = {
						{
							name = "NextNumber",
							value = T ~= "" and T or "No predictions",
							inline = false
						};
						{
							name = "NextInteger";
							value = d ~= "" and d or "No predictions",
							inline = false
						};
						{
							name = "Current cycle";
							value = string.format("Cycle `%d`\nNumber `%s` roll `%.6f` seed `%d`\nInteger `%s` roll `%s` seed `%d`", G, tostring(V), tonumber(Z) or 0, tonumber(j) or 0, tostring(i), tostring(c), tonumber(J) or 0);
							inline = false
						}
					};
					footer = {
						text = tostring(y.AppName or "Exotic Hub") .. (" " .. tostring(y.CurentV or ""))
					},
					timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
				}
			}
		}
		local g, E = u.Webhooks.Post(q)
		u.MoonPredictor.DebugBusy = false
		warn("[Moon Predictor][NextNumber]\n" .. T)
		warn("[Moon Predictor][NextInteger]\n" .. d)
		return g, g and "Moon debug post sent" or tostring(E or "Debug post failed")
	end;
	Start = function()
		if u.MoonPredictor.Started then
			return
		end
		u.MoonPredictor.Started = true
		task.spawn(function()
			while u.MoonPredictor.Started do
				local G, V = pcall(u.MoonPredictor.Update)
				if not G then
					T.MoonPredictorStatusText = ""
					warn("[Moon Predictor]", V)
				end
				task.wait(1)
			end
		end)
	end
}
u.MoonPredictionApi = {
	Url = "https://exotichub.app/gag2predict";
	Busy = false,
	Started = false;
	Debug = false,
	Interval = 30;
	PredictionCount = 20;
	LastSignature = "",
	GetMoonPredictionIconId = function(G)
		local V = u.MoonPredictor.GetNight()
		local y = V and (V.Weathers and V.Weathers[tostring(G or "")]) or nil
		local Z = type(y) == "table" and tostring(y.Image or "") or ""
		return Z:match("%d+") or "0"
	end;
	GetMoonPredictionIcons = function()
		local G = u.MoonPredictor.GetNight()
		local V = {}
		if not G or type(G.Weathers) ~= "table" then
			return V
		end
		for G, y in G.Weathers do
			local Z = type(y) == "table" and tostring(y.Image or "") or ""
			V[tostring(G)] = Z:match("%d+") or "0"
		end
		return V
	end;
	GetMoonPredictionEvents = function()
		local G = u.MoonPredictor.GetRare(u.MoonPredictionApi.PredictionCount, u.MoonPredictor.RollMode)
		if type(G) ~= "table" then
			return nil
		end
		local V = {}
		for G, y in ipairs(G) do
			local Z = tostring(y.Name or "")
			local j = math.floor(tonumber(y.At) or 0)
			if Z == "" or j <= 0 then
				continue
			end
			table.insert(V, {
				name = Z;
				starts_at = j,
				cycle = math.floor(j / 600);
				icon_id = u.MoonPredictionApi.GetMoonPredictionIconId(Z)
			})
		end
		return V
	end,
	BuildMoonPredictionPayload = function()
		local G = y.LocalPlayer
		local V = u.MoonPredictionApi.GetMoonPredictionEvents()
		if not G or not G.UserId or type(V) ~= "table" then
			return nil
		end
		local Z = math.floor(u.MoonPredictor.GetServerTime())
		local j = tostring(y.Workspace:GetAttribute("ActivePhase") or "Unknown")
		local i = tostring(y.Workspace:GetAttribute("ActiveWeather") or "Unknown")
		local c = math.floor(tonumber(y.Workspace:GetAttribute("PhaseDuration")) or 0)
		return {
			version = 1,
			game = "gag2",
			generated_at = Z,
			source = {
				user_id = tostring(G.UserId),
				job_id = tostring(game.JobId or ""),
				place_version = tonumber(game.PlaceVersion) or 0
			},
			phase = {
				name = j;
				weather = i;
				ends_at = c,
				icon_id = j == "Night" and u.MoonPredictionApi.GetMoonPredictionIconId(i) or "0"
			},
			next_night_at = math.floor(u.MoonPredictor.GetNextNightAt()),
			icons = u.MoonPredictionApi.GetMoonPredictionIcons();
			predictions = V
		}
	end,
	BuildMoonPredictionSignature = function(G)
		if type(G) ~= "table" or type(G.phase) ~= "table" or type(G.predictions) ~= "table" then
			return nil
		end
		local V = {
			tostring(G.phase.name or ""),
			tostring(G.phase.weather or "");
			tostring(G.phase.ends_at or 0);
			tostring(G.next_night_at or 0)
		}
		for G, y in ipairs(G.predictions) do
			table.insert(V, table.concat({
				tostring(y.name or ""),
				tostring(y.starts_at or 0),
				tostring(y.icon_id or "0")
			}, "\031"))
		end
		return table.concat(V, "\030")
	end;
	SendMoonPredictionApi = function()
		if u.MoonPredictionApi.Busy then
			return false
		end
		local G = u.MoonPredictionApi.BuildMoonPredictionPayload()
		local V = u.MoonPredictionApi.BuildMoonPredictionSignature(G)
		if type(G) ~= "table" or type(V) ~= "string" or V == "" then
			return false
		end
		if V == u.MoonPredictionApi.LastSignature then
			return false
		end
		u.MoonPredictionApi.Busy = true
		local Z, j, i, c, J = pcall(function()
			return E.Http.PostJson(u.MoonPredictionApi.Url, G)
		end)
		u.MoonPredictionApi.Busy = false
		if not Z then
			if u.MoonPredictionApi.Debug then
				warn("[MoonPredictionApi] Request crashed:", j)
			end
			return false
		end
		if not j then
			if u.MoonPredictionApi.Debug then
				warn("[MoonPredictionApi] Request failed:", tostring(J or i))
			end
			return false
		end
		u.MoonPredictionApi.LastSignature = V
		if u.MoonPredictionApi.Debug then
			print("[MoonPredictionApi] Status:", i)
			print("[MoonPredictionApi] Response:", tostring(c or ""))
			print("[MoonPredictionApi] Payload:", y.HttpService:JSONEncode(G))
		end
		return true
	end,
	LoopMoonPredictionApi = function()
		local G, V = pcall(u.MoonPredictionApi.SendMoonPredictionApi)
		if not G and u.MoonPredictionApi.Debug then
			warn("[MoonPredictionApi] Loop error:", V)
		end
	end;
	StartMoonPredictionApi = function()
		if u.MoonPredictionApi.Started then
			return false
		end
		u.MoonPredictionApi.Started = true
		task.spawn(function()
			task.wait(5)
			while u.MoonPredictionApi.Started do
				u.MoonPredictionApi.LoopMoonPredictionApi()
				task.wait(u.MoonPredictionApi.Interval)
			end
		end)
		return true
	end
}
u.MoonPredictionApi.StartMoonPredictionApi()
u.LiveMapPetsApi = {
	Url = "https://exotichub.app/gag2livepets",
	Busy = false,
	Started = false,
	Interval = 7,
	LastSignature = nil,
	GetIconId = function(G)
		local V = type(y.PetData) == "table" and y.PetData[G] or nil
		local Z = type(V) == "table" and tostring(V.Image or "") or ""
		return Z:match("%d+") or "0"
	end;
	GetPets = function()
		local G = u.PetFinderPremium.GetFolder()
		if not G then
			return nil
		end
		local V = u.PetFinderPremium.GetServerTime()
		local y = {}
		local Z = {}
		local j = {}
		for G, Z in ipairs(G:GetChildren()) do
			local i = u.PetFinderPremium.GetPetData(Z)
			if not i or i.ownerId ~= 0 or u.PetFinderPremium.IsExpired(i) then
				continue
			end
			local c = tostring(i.name or "")
			local J = tostring(i.size or "Normal")
			local T = tostring(i.variant or "Normal")
			local d = tostring(i.rarity or "Unknown")
			local q = u.LiveMapPetsApi.GetIconId(i.name)
			local g = math.floor(tonumber(i.expiresAt) or 0)
			local E = math.max(math.floor(g - V), 0)
			if c == "" or E <= 0 then
				continue
			end
			table.insert(j, table.concat({
				c;
				J,
				T,
				d;
				q;
				tostring(g)
			}, "\031"))
			local a = table.concat({
				c,
				J;
				T
			}, "\031")
			if not y[a] then
				y[a] = {
					n = c;
					s = J,
					v = T,
					r = d;
					i = q,
					a = 0;
					t = E
				}
			end
			y[a].a += 1
			y[a].t = math.max(y[a].t, E)
			if y[a].i == "0" and q ~= "0" then
				y[a].i = q
			end
		end
		for G, V in pairs(y) do
			table.insert(Z, V)
		end
		table.sort(Z, function(G, V)
			if G.n ~= V.n then
				return G.n < V.n
			end
			if G.s ~= V.s then
				return G.s < V.s
			end
			return G.v < V.v
		end)
		table.sort(j)
		return Z, table.concat(j, "\030")
	end;
	Send = function()
		if u.LiveMapPetsApi.Busy then
			return false
		end
		local G = false
		local V = y.LocalPlayer
		local Z = tostring(game.JobId or "")
		local j, i = u.LiveMapPetsApi.GetPets()
		if not V or not V.UserId or Z == "" or type(j) ~= "table" or type(i) ~= "string" then
			return false
		end
		local c = table.concat({
			Z;
			tostring(game.PlaceVersion or 0);
			i
		}, "\029")
		if c == u.LiveMapPetsApi.LastSignature then
			return false
		end
		u.LiveMapPetsApi.Busy = true
		local J = {
			j = Z,
			u = tostring(V.UserId);
			pv = tonumber(game.PlaceVersion) or 0,
			p = j
		}
		local T, d, q, g, a = pcall(function()
			return E.Http.PostJson(u.LiveMapPetsApi.Url, J)
		end)
		u.LiveMapPetsApi.Busy = false
		if not T then
			if G then
				warn("[LiveMapPetsApi] Request crashed:", d)
			end
			if G then
				warn("[LiveMapPetsApi] Request crashed:", d)
			end
			return false
		end
		if G then
			print("[LiveMapPetsApi] Status:", q)
			print("[LiveMapPetsApi] Response:", tostring(g or ""))
		end
		if not d then
			if G then
				warn("[LiveMapPetsApi] Request failed:", tostring(a or "Unknown error"))
			end
			return false
		end
		u.LiveMapPetsApi.LastSignature = c
		return true
	end,
	Start = function()
		if u.LiveMapPetsApi.Started then
			return
		end
		u.LiveMapPetsApi.Started = true
		task.spawn(function()
			task.wait(5)
			while u.LiveMapPetsApi.Started do
				pcall(u.LiveMapPetsApi.Send)
				task.wait(u.LiveMapPetsApi.Interval)
			end
		end)
	end
}
u.GardenItems = {
	Busy = false;
	AlreadyRunningPetPlayer = false;
	PetSeedCollectSystem = {
		IsOurSeed = function(G)
			if not G or G.Parent ~= y.DroppedItems then
				return false
			end
			if G:GetAttribute("ItemCategory") ~= "Seeds" then
				return false
			end
			return tonumber(G:GetAttribute("DroppedBy")) == tonumber(T.player_userid)
		end,
		Claim = function(G)
			if not e.auto_collect_drop_seeds or u.GardenItems.Busy or not u.GardenItems.PetSeedCollectSystem.IsOurSeed(G) then
				return false
			end
			local V = u.ProximityPrompt.FindProximityPromptByClass(G)
			if not V or not V.Enabled then
				return false
			end
			u.GardenItems.Busy = true
			local y = T.TeleportLockNames.GardenItemCollector
			local Z = u.Teleport.LockTeleport(y, e.garden_items_use_player_walk and 35 or 2, e.garden_items_use_player_walk == true)
			if not Z then
				u.GardenItems.Busy = false
				return false
			end
			local j, i = pcall(function()
				if e.garden_items_use_player_walk then
					if not u.Movement.WalkPathToTarget(G, 30, y, 10) then
						return false
					end
				else
					if not u.Teleport.TeleportTo(G, true, y) then
						return false
					end
				end
				task.wait(.05)
				if not V.Parent or not u.GardenItems.PetSeedCollectSystem.IsOurSeed(G) then
					return false
				end
				u.ProximityPrompt.ActivateProximityPrompt(V)
				return true
			end)
			u.Teleport.UnlockTeleport(y)
			u.GardenItems.Busy = false
			return j and i == true
		end
	};
	StartSeedCollectorPetsAndPlayer = function()
		if u.GardenItems.AlreadyRunningPetPlayer then
			return
		end
		u.GardenItems.AlreadyRunningPetPlayer = true
		y.DroppedItems.ChildAdded:Connect(function(G)
			u.GardenItems.PetSeedCollectSystem.Claim(G)
		end)
		task.spawn(function()
			while true do
				task.wait(5)
				if e.auto_collect_drop_seeds then
					for G, V in ipairs(y.DroppedItems:GetChildren()) do
						if u.GardenItems.PetSeedCollectSystem.Claim(V) then
							task.wait(.5)
						end
					end
				end
			end
		end)
	end
}
u.GardenItems.StartSeedCollectorPetsAndPlayer()
T.GardenExpandStatusText = ""
u.GardenItems.ExpandSystem = {
	Busy = false,
	Started = false;
	SetStatus = function(G, V)
		T.GardenExpandStatusText = string.format("<stroke color=\'#000000\' thickness=\'1\'><font color=\'%s\'>\240\159\143\161 Garden Expansion:</font> <font color=\'#FFFFFF\'>%s</font></stroke>", tostring(V or "#FFFFFF"), tostring(G or ""))
	end;
	GetCurrentSlot = function()
		local G = tonumber(u.DataReplica.GetData("OwnedExpansions", 1)) or 1
		return math.max(math.floor(G), 1)
	end,
	GetMaximumSlot = function()
		if type(y.ExpansionPrices) ~= "table" then
			return 1
		end
		return math.max(# y.ExpansionPrices, 1)
	end;
	GetPrice = function(G)
		G = tonumber(G)
		if not G or type(y.ExpansionPrices) ~= "table" then
			return nil
		end
		local V = y.ExpansionPrices[G]
		local Z = type(V) == "table" and tonumber(V.Price) or nil
		local j = y.GardenFlags and y.GardenFlags.ExpansionPriceOverrides
		if j and type(j.Get) == "function" then
			local V, y = pcall(function()
				return j:Get()
			end)
			if V and type(y) == "table" then
				Z = tonumber(y[tostring(G)]) or Z
			end
		end
		return Z
	end,
	Loop = function()
		local G = u.GardenItems.ExpandSystem
		if not e.auto_expand_garden then
			T.GardenExpandStatusText = ""
			return false
		end
		if G.Busy then
			return false
		end
		local V = G.GetMaximumSlot()
		local Z = math.clamp(math.floor(tonumber(e.auto_expand_garden_max_slot) or 2), 1, V)
		local j = G.GetCurrentSlot()
		if j >= Z then
			G.SetStatus(string.format("Slot %d/%d reached", j, Z), "#66FF99")
			return false
		end
		local i = j + 1
		local c = G.GetPrice(i)
		if not c then
			G.SetStatus("Expansion price unavailable", "#FF5555")
			return false
		end
		local d = tonumber(u.Money.GetSheckles()) or 0
		if d < c then
			G.SetStatus(string.format("Slot %d/%d \226\128\162 Next $%s", j, Z, J.formatShecklesNumber(c)), "#FFCC66")
			return false
		end
		local q = y.Networking and (y.Networking.Actions and y.Networking.Actions.ExpandGarden)
		if not q or type(q.Fire) ~= "function" then
			G.SetStatus("Expansion remote unavailable", "#FF5555")
			return false
		end
		G.Busy = true
		G.SetStatus(string.format("Buying slot %d...", i), "#66CCFF")
		local g, E = pcall(function()
			return q:Fire()
		end)
		if not g or E == false then
			G.Busy = false
			G.SetStatus("Purchase failed", "#FF5555")
			return false
		end
		local a = os.clock()
		repeat
			task.wait(.1)
		until G.GetCurrentSlot() > j or os.clock() - a >= 3
		local H = G.GetCurrentSlot()
		G.Busy = false
		if H > j then
			G.SetStatus(string.format("Expanded to slot %d/%d", H, Z), "#66FF99")
			return true
		end
		G.SetStatus("Purchase not confirmed", "#FFCC66")
		return false
	end;
	Start = function()
		local G = u.GardenItems.ExpandSystem
		if G.Started then
			return false
		end
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
u.GardenItems.ExpandSystem.Start()
T.PetMaxInventoryStatusText = ""
u.GardenItems.PetMaxInventorySystem = {
	BusyPetMaxInventorySystem = false;
	StartedPetMaxInventorySystem = false,
	SetStatusPetMaxInventorySystem = function(G, V)
		G = tostring(G or "")
		if G == "" then
			T.PetMaxInventoryStatusText = ""
			return false
		end
		T.PetMaxInventoryStatusText = string.format("<stroke color=\'#000000\' thickness=\'1\'><font color=\'%s\'>\240\159\144\190 Pet Slots:</font> <font color=\'#FFFFFF\'>%s</font></stroke>", tostring(V or "#FFFFFF"), G)
		return true
	end,
	GetBaseMaxPetMaxInventorySystem = function()
		local G = y.PetSlotPrices
		local V = type(G) == "table" and tonumber(G.BaseMax) or 3
		return math.max(math.floor(V or 3), 1)
	end,
	GetAbsoluteMaxPetMaxInventorySystem = function()
		local G = u.GardenItems.PetMaxInventorySystem
		local V = y.PetSlotPrices
		local Z = G.GetBaseMaxPetMaxInventorySystem()
		if type(V) == "table" and tonumber(V.AbsoluteMax) then
			return math.max(math.floor(tonumber(V.AbsoluteMax) or Z), Z)
		end
		local j = type(V) == "table" and V.Prices or nil
		if type(j) == "table" then
			return Z + # j
		end
		return Z
	end,
	GetMaximumUpgradePetMaxInventorySystem = function()
		local G = u.GardenItems.PetMaxInventorySystem
		return math.max(G.GetAbsoluteMaxPetMaxInventorySystem() - G.GetBaseMaxPetMaxInventorySystem(), 0)
	end;
	GetCurrentMaxPetMaxInventorySystem = function()
		local G = u.GardenItems.PetMaxInventorySystem
		local V = tonumber(y.LocalPlayer:GetAttribute("MaxEquippedPets")) or G.GetBaseMaxPetMaxInventorySystem()
		return math.max(math.floor(V), G.GetBaseMaxPetMaxInventorySystem())
	end,
	GetPurchasedCountPetMaxInventorySystem = function()
		local G = u.GardenItems.PetMaxInventorySystem
		local V = G.GetCurrentMaxPetMaxInventorySystem() - G.GetBaseMaxPetMaxInventorySystem()
		return math.clamp(math.floor(V), 0, G.GetMaximumUpgradePetMaxInventorySystem())
	end,
	GetTargetUpgradePetMaxInventorySystem = function()
		local G = u.GardenItems.PetMaxInventorySystem
		local V = G.GetMaximumUpgradePetMaxInventorySystem()
		if V <= 0 then
			return 0
		end
		local y = math.floor(tonumber(e.auto_expand_pet_inventory_max_upgrade) or 1)
		return math.clamp(y, 1, V)
	end;
	GetNextPricePetMaxInventorySystem = function(G)
		local V = y.PetSlotPrices
		G = tonumber(G) or u.GardenItems.PetMaxInventorySystem.GetCurrentMaxPetMaxInventorySystem()
		if type(V) == "table" and type(V.GetNextPrice) == "function" then
			local y, Z = pcall(V.GetNextPrice, G)
			if y and tonumber(Z) then
				return tonumber(Z)
			end
		end
		local Z = type(V) == "table" and V.Prices or nil
		if type(Z) ~= "table" then
			return nil
		end
		local j = u.GardenItems.PetMaxInventorySystem
		local i = math.max(math.floor(G - j.GetBaseMaxPetMaxInventorySystem()), 0) + 1
		return tonumber(Z[i])
	end,
	GetSpendableShecklesPetMaxInventorySystem = function(G)
		G = tonumber(G) or 0
		if e.pet_inventory_min_sheckles_enabled ~= true then
			return G, 0
		end
		local V = math.max(math.floor(tonumber(e.pet_inventory_min_sheckles) or 0), 0)
		if V <= 0 then
			return G, 0
		end
		return math.max(0, G - V), V
	end;
	LoopPetMaxInventorySystem = function()
		local G = u.GardenItems.PetMaxInventorySystem
		if e.auto_expand_pet_inventory ~= true then
			T.PetMaxInventoryStatusText = ""
			return false
		end
		if G.BusyPetMaxInventorySystem then
			return false
		end
		local V = G.GetMaximumUpgradePetMaxInventorySystem()
		if V <= 0 then
			G.SetStatusPetMaxInventorySystem("Pet slot prices unavailable", "#FF5555")
			return false
		end
		local Z = G.GetTargetUpgradePetMaxInventorySystem()
		local j = G.GetPurchasedCountPetMaxInventorySystem()
		local i = G.GetCurrentMaxPetMaxInventorySystem()
		if j >= Z then
			G.SetStatusPetMaxInventorySystem(string.format("Upgrade %d/%d reached", j, Z), "#66FF99")
			return false
		end
		local c = j + 1
		local d = G.GetNextPricePetMaxInventorySystem(i)
		if not d or d <= 0 then
			G.SetStatusPetMaxInventorySystem("Max pet slots reached", "#66FF99")
			return false
		end
		local q = tonumber(u.Money.GetSheckles()) or 0
		local g, E = G.GetSpendableShecklesPetMaxInventorySystem(q)
		if g < d then
			local V = d + E
			local y = E > 0 and J.formatShecklesNumber(V) or J.formatShecklesNumber(d)
			G.SetStatusPetMaxInventorySystem(string.format("Upgrade %d/%d \226\128\162 Need $%s", c, Z, y), "#FFCC66")
			return false
		end
		local a = y.Networking and (y.Networking.Pets and y.Networking.Pets.RequestPurchasePetSlot)
		if not a or type(a.Fire) ~= "function" then
			G.SetStatusPetMaxInventorySystem("Pet slot remote unavailable", "#FF5555")
			return false
		end
		G.BusyPetMaxInventorySystem = true
		G.SetStatusPetMaxInventorySystem(string.format("Buying upgrade %d/%d...", c, Z), "#66CCFF")
		local H, r = pcall(function()
			return a:Fire()
		end)
		if not H or r == false then
			G.BusyPetMaxInventorySystem = false
			G.SetStatusPetMaxInventorySystem("Purchase failed", "#FF5555")
			return false
		end
		local Y = os.clock()
		repeat
			task.wait(.1)
		until G.GetCurrentMaxPetMaxInventorySystem() > i or os.clock() - Y >= 3
		local s = G.GetCurrentMaxPetMaxInventorySystem()
		G.BusyPetMaxInventorySystem = false
		if s > i then
			G.SetStatusPetMaxInventorySystem(string.format("Max pets %d/%d", s, G.GetAbsoluteMaxPetMaxInventorySystem()), "#66FF99")
			return true
		end
		G.SetStatusPetMaxInventorySystem("Purchase not confirmed", "#FFCC66")
		return false
	end;
	StartPetMaxInventorySystem = function()
		local G = u.GardenItems.PetMaxInventorySystem
		if G.StartedPetMaxInventorySystem then
			return false
		end
		G.StartedPetMaxInventorySystem = true
		task.spawn(function()
			while G.StartedPetMaxInventorySystem do
				task.wait(1.5)
				G.LoopPetMaxInventorySystem()
			end
		end)
		return true
	end
}
u.GardenItems.PetMaxInventorySystem.StartPetMaxInventorySystem()
u.GardenItems.EventSeedCollectSystem = {
	Busy = false;
	Started = false;
	CurrentItem = nil;
	RetryAt = setmetatable({}, {
		__mode = "k"
	}),
	Claim_old = function(G)
		if not e.auto_collect_event_seeds then
			return false
		end
		if not G or not G.Parent then
			return false
		end
		local V = u.ProximityPrompt.FindProximityPromptByClass(G)
		if not V then
			return false
		end
		local y = T.TeleportLockNames.SeedPackCollector
		u.Teleport.LockTeleport(y, 5, true)
		local Z, j = pcall(function()
			if not u.Teleport.TeleportTo(G, true, y) then
				return false
			end
			task.wait(1)
			if not V.Parent then
				return false
			end
			for G = 1, 2, 1 do
				u.ProximityPrompt.ActivateProximityPrompt(V)
			end
			u.Teleport.LockTeleport(y, 5, true)
			task.wait(1)
			return true
		end)
		return Z and j == true
	end,
	Claim = function(G)
		local V = u.GardenItems.EventSeedCollectSystem
		if not e.auto_collect_event_seeds or V.Busy or (not e.garden_items_use_player_walk and u.StepTeleport.Busy) or not G or G.Parent ~= y.EventSeedDrops or os.clock() < ((V.RetryAt[G] or 0)) then
			return false
		end
		local Z = u.ProximityPrompt.FindProximityPromptByClass(G)
		if not Z or not Z.Enabled then
			V.RetryAt[G] = os.clock() + .25
			return false
		end
		V.Busy = true
		V.CurrentItem = G
		local j = T.TeleportLockNames.SeedPackCollector
		if not u.Teleport.LockTeleport(j, 60, true) then
			V.CurrentItem = nil
			V.Busy = false
			return false
		end
		local i, c = pcall(function()
			if e.garden_items_use_player_walk then
				if not u.Movement.WalkPathToTarget(G, 35, j, 10) then
					return false
				end
			else
				local V = u.StepTeleport.GetCFrame(G)
				local y = V and ((V + Vector3.new(5, 0, 0))).Position
				local Z = y and u.StepTeleport.FindGroundPosition(G, y)
				if not Z or not u.StepTeleport.ToCFrame(CFrame.new(Z), j) then
					return false
				end
				if not u.Teleport.TeleportTo(G, true, j) then
					return false
				end
			end
			if not e.auto_collect_event_seeds or G.Parent ~= y.EventSeedDrops or not Z.Parent then
				return false
			end
			for V = 1, 2, 1 do
				if G.Parent ~= y.EventSeedDrops or not Z.Parent then
					return true
				end
				u.ProximityPrompt.ActivateProximityPrompt(Z)
				task.wait(.1)
			end
			return true
		end)
		if i and c then
			V.RetryAt[G] = os.clock() + 3
			u.Teleport.LockTeleport(j, 5, true)
		else
			V.RetryAt[G] = os.clock() + 1
			u.Teleport.UnlockTeleport(j)
		end
		V.CurrentItem = nil
		V.Busy = false
		if not i then
			warn("[Event Seed Collector]", c)
			return false
		end
		return c == true
	end;
	StartGoldRainbowCollect = function()
		local G = u.GardenItems.EventSeedCollectSystem
		if G.Started then
			return false
		end
		G.Started = true
		y.EventSeedDrops.ChildAdded:Connect(function(V)
			task.defer(function()
				G.Claim(V)
			end)
		end)
		task.spawn(function()
			while G.Started do
				task.wait(.5)
				if not e.auto_collect_event_seeds or G.Busy then
					continue
				end
				for V, y in ipairs(y.EventSeedDrops:GetChildren()) do
					if G.Claim(y) then
						task.wait(.5)
					end
				end
			end
		end)
		return true
	end
}
u.GardenItems.EventSeedCollectSystem.StartGoldRainbowCollect()
H.RealTimeStats = {
	statusLabel = nil,
	updateStatusList = function(G)
		local V = 18
		local Z = 14
		local j = 1000
		local i = V
		local c = workspace.CurrentCamera
		if c then
			if c.ViewportSize.X < j then
				i = Z
			end
		end
		local J = H.RealTimeStats
		local T = J.statusLabel
		if not T or not T.Parent then
			local G = y.LocalPlayer
			if not G then
				return
			end
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
J.SafeParent = function(G, V, y)
	if typeof(G) ~= "Instance" or typeof(V) ~= "Instance" or G.Parent == nil or V.Parent == nil then
		return false
	end
	local Z = false
	local j = pcall(function()
		if y and G.Parent ~= y then
			return
		end
		G.Parent = V
		Z = true
	end)
	return j and Z
end
J.ParentOutside = function(G)
	if G:GetAttribute("emove") then
		return
	end
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
		if not e.hide_plant_models then
			continue
		end
		if e.high_mode then
			continue
		end
		local G, V = pcall(function()
			local G = u.Farm.GetMyPlantsFolder()
			if G and G.Parent then
				local V = G:GetChildren()
				for G, V in ipairs(V) do
					if not e.hide_plant_models then
						break
					end
					J.ParentOutside(V)
					if G % 50 == 0 then
						task.wait()
					end
				end
			end
			for G, V in ipairs(u.Farm.GetMyPlantsFoldersNotMine()) do
				if not e.hide_plant_models then
					break
				end
				if not V or not V.Parent then
					continue
				end
				local y = V:FindFirstChild("Plants")
				for G, V in ipairs(y:GetChildren()) do
					if not e.hide_plant_models then
						break
					end
					J.ParentOutside(V)
					if G % 50 == 0 then
						task.wait()
					end
				end
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
		if e.char_farm_middle then
			local G = u.Farm.GetCenterPointPart()
			if G then
				u.Teleport.LockTeleport(T.TeleportLockNames.Other, 2)
				u.Teleport.TeleportTo(u.Farm.GetCenterPointPart(), true, T.TeleportLockNames.Other)
				print("Teleport middle")
			else
				print("center not found")
			end
		end
	end)
end)
T.GetProLabel = function()
	local G = "\240\159\148\146<font color=\'#FF0000\'>PRO</font>"
	if T.GetCheckIfPro() then
		G = ""
	end
	return G
end
u.PlantModelCleaner = {
	StartedPlantModelCleaner = false,
	ConnectionsPlantModelCleaner = {},
	FolderConnectionsPlantModelCleaner = {},
	DestroyedPlantModelCleaner = 0;
	IsActivePlantModelCleaner = function()
		return e.high_mode == true and T.GetCheckIfPro() == true
	end;
	SetStatusPlantModelCleaner = function(G, V)
		T.PlantModelCleanerStatusText = string.format("<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\240\159\140\177 [Plant Models]</font> <font color=\'%s\'>%s</font></stroke>", tostring(V or "#FFFFFF"), tostring(G or ""))
	end,
	DestroyObjectPlantModelCleaner = function(G)
		if not u.PlantModelCleaner.IsActivePlantModelCleaner() then
			return false
		end
		if typeof(G) ~= "Instance" or not G.Parent then
			return false
		end
		local V = pcall(function()
			G:Destroy()
		end)
		if V then
			u.PlantModelCleaner.DestroyedPlantModelCleaner += 1
		end
		return V
	end,
	CleanFolderPlantModelCleaner = function(G)
		if not u.PlantModelCleaner.IsActivePlantModelCleaner() then
			return false
		end
		if typeof(G) ~= "Instance" or not G.Parent then
			return false
		end
		local V = G:GetChildren()
		for G, V in ipairs(V) do
			if not u.PlantModelCleaner.IsActivePlantModelCleaner() then
				break
			end
			u.PlantModelCleaner.DestroyObjectPlantModelCleaner(V)
			if G % 50 == 0 then
				task.wait()
			end
		end
		return true
	end,
	HookFolderPlantModelCleaner = function(G)
		if typeof(G) ~= "Instance" or not G.Parent then
			return false
		end
		if u.PlantModelCleaner.FolderConnectionsPlantModelCleaner[G] then
			return true
		end
		local V = G.ChildAdded:Connect(function(G)
			if not u.PlantModelCleaner.IsActivePlantModelCleaner() then
				return
			end
			task.defer(function()
				u.PlantModelCleaner.DestroyObjectPlantModelCleaner(G)
			end)
		end)
		u.PlantModelCleaner.FolderConnectionsPlantModelCleaner[G] = V
		table.insert(u.PlantModelCleaner.ConnectionsPlantModelCleaner, V)
		if u.PlantModelCleaner.IsActivePlantModelCleaner() then
			u.PlantModelCleaner.CleanFolderPlantModelCleaner(G)
		end
		return true
	end,
	HookOwnPlantsFolderPlantModelCleaner = function()
		local G = u.Farm.GetMyPlantsFolder()
		if not G or not G.Parent then
			return false
		end
		return u.PlantModelCleaner.HookFolderPlantModelCleaner(G)
	end;
	HookOtherPlantsFoldersPlantModelCleaner = function()
		for G, V in ipairs(u.Farm.GetMyPlantsFoldersNotMine()) do
			if not V or not V.Parent then
				continue
			end
			local y = V:FindFirstChild("Plants")
			if y then
				u.PlantModelCleaner.HookFolderPlantModelCleaner(y)
			end
		end
		return true
	end;
	HookGardenPlotsPlantModelCleaner = function()
		local G = y.Workspace:FindFirstChild("Gardens")
		if not G then
			return false
		end
		local V = G.ChildAdded:Connect(function(G)
			task.defer(function()
				if not G or not G.Parent then
					return
				end
				local V = G:FindFirstChild("Plants")
				if V then
					u.PlantModelCleaner.HookFolderPlantModelCleaner(V)
					return
				end
				local y
				y = G.ChildAdded:Connect(function(G)
					if G and G.Name == "Plants" then
						u.PlantModelCleaner.HookFolderPlantModelCleaner(G)
						if y then
							y:Disconnect()
						end
					end
				end)
				table.insert(u.PlantModelCleaner.ConnectionsPlantModelCleaner, y)
			end)
		end)
		table.insert(u.PlantModelCleaner.ConnectionsPlantModelCleaner, V)
		return true
	end;
	RemovePlantByIdPlantModelCleaner = function(G)
		if not u.PlantModelCleaner.IsActivePlantModelCleaner() then
			return false
		end
		G = tostring(G or "")
		if G == "" then
			return false
		end
		local V = u.Farm.GetMyPlantsFolder()
		if not V or not V.Parent then
			return false
		end
		local y = V:FindFirstChild(G)
		if y then
			return u.PlantModelCleaner.DestroyObjectPlantModelCleaner(y)
		end
		for V, y in ipairs(V:GetChildren()) do
			if tostring(y:GetAttribute("PlantId") or y:GetAttribute("PlantID") or y:GetAttribute("Id") or y.Name or "") == G then
				return u.PlantModelCleaner.DestroyObjectPlantModelCleaner(y)
			end
		end
		return false
	end,
	ApplyPlantModelCleaner = function()
		u.PlantModelCleaner.HookOwnPlantsFolderPlantModelCleaner()
		u.PlantModelCleaner.HookOtherPlantsFoldersPlantModelCleaner()
		if u.PlantModelCleaner.IsActivePlantModelCleaner() then
			u.PlantModelCleaner.SetStatusPlantModelCleaner("Removing live plant models", "#7CFC00")
		else
			u.PlantModelCleaner.SetStatusPlantModelCleaner("Idle", "#CFCFCF")
		end
		return true
	end,
	StartPlantModelCleaner = function()
		if u.PlantModelCleaner.StartedPlantModelCleaner then
			return false
		end
		u.PlantModelCleaner.StartedPlantModelCleaner = true
		u.PlantModelCleaner.HookGardenPlotsPlantModelCleaner()
		task.spawn(function()
			while not T.is_forced_stop do
				task.wait(3)
				if not e.high_mode then
					continue
				end
				pcall(u.PlantModelCleaner.ApplyPlantModelCleaner)
			end
		end)
		return true
	end
}
u.PlantModelCleaner.StartPlantModelCleaner()
T.HomeDashboardUi = function()
	local G = d.SERVER.GetServerVersion()
	local V = i:AddTab({
		Name = "<font color=\"#FFFFFF\">Config & </font><font color=\"#00A2FF\">Home</font>",
		Description = "<font color=\"#B4B4B4\">Game Server Version: </font><font color=\"#FFD700\"><b>" .. (G .. "</b></font>");
		Icon = "house"
	})
	local y = V:AddLeftGroupbox("Actions", "calendar-sync")
	local Z = V:AddRightGroupbox("Moon Predictor", "moon-star")
	local j = V:AddRightGroupbox("Farm Details", "sprout", false)
	local c = V:AddLeftGroupbox("<font color=\"#FFFFFF\">Multi Account </font><font color=\"#00A2FF\">Config</font>", "copy", false)
	local g = V:AddLeftGroupbox("<font color=\"#FFFFFF\">Website </font><font color=\"#00A2FF\">Sync</font>", "cloud-cog")
	if Z then
		u.MoonPredictor.Label = Z:AddLabel({
			Text = "<font color=\'#AFAFAF\'>Loading moon predictions...</font>";
			DoesWrap = true
		})
		Z:AddToggle("moon_predictor_enabled_ui", {
			Text = "Enable Moon Predictor";
			Default = e.moon_predictor_enabled,
			Tooltip = "Shows upcoming Goldmoon, Rainbow Moon and Bloodmoon events.";
			Callback = function(G)
				e.moon_predictor_enabled = G
				q.Save.SaveDataSync()
				u.MoonPredictor.Update()
			end
		})
	end
	if j then
		u.FarmDetails.Label = j:AddLabel({
			Text = "<font color=\'#AFAFAF\'>Loading farm details...</font>",
			DoesWrap = true
		})
		j:AddButton({
			Text = "Refresh Farm Details",
			Func = function()
				u.FarmDetails.Update()
			end
		})
		u.FarmDetails.Start()
	end
	if g then
		g:AddLabel({
			Text = "<font color=\'#66CCFF\'><b>Connect to Exotic Hub</b></font>\nEnter your Web API key and link this account.",
			DoesWrap = true
		})
		local G = g:AddLabel({
			Text = tostring(e.web_api_key or "") ~= "" and "<font color=\'#FFCC66\'>\226\151\143 API key saved \226\128\148 ready to link</font>" or "<font color=\'#AFAFAF\'>\226\151\143 Not connected</font>";
			DoesWrap = true
		})
		local function V(V)
			if G and type(G.SetText) == "function" then
				G:SetText(V)
			end
		end
		g:AddInput("gag2_web_api_key", {
			Text = "\240\159\148\145 Web API Key";
			Default = e.web_api_key;
			Numeric = false,
			AllowEmpty = true;
			Finished = false;
			ClearTextOnFocus = false,
			Placeholder = "Enter API key",
			Tooltip = "Get your API key from the Exotic Hub website.";
			Callback = function(G)
				e.web_api_key = (tostring(G or "")):match("^%s*(.-)%s*$")
				q.Save.SaveDataSync()
				if e.web_api_key == "" then
					V("<font color=\'#AFAFAF\'>\226\151\143 Not connected</font>")
				else
					V("<font color=\'#FFCC66\'>\226\151\143 API key saved \226\128\148 ready to link</font>")
				end
			end
		})
		g:AddDivider()
		g:AddButton({
			Text = "\240\159\148\151 Link This Account",
			Func = function()
				if u.WebApi.Busy then
					T.Notify("Link request already running", 3)
					return
				end
				V("<font color=\'#66CCFF\'>\226\151\143 Linking account...</font>")
				task.spawn(function()
					local G, y = u.WebApi.LinkDevice()
					if G then
						V("<font color=\'#7CFC00\'>\226\151\143 Account successfully linked</font>")
					else
						V("<font color=\'#FF6666\'>\226\151\143 " .. (tostring(y) .. "</font>"))
					end
					T.Notify(y, 5)
				end)
			end
		})
	end
	if c then
		c:AddButton({
			Text = "Copy Config",
			Func = function()
				local G = q.Config.BuildCopyText()
				if not G then
					T.Notify("Failed to create config", 3)
					return
				end
				J.CopyToClipBoard(G)
				T.Notify("Config copied. Add it above the loader.", 3)
			end
		})
		c:AddButton({
			Text = "\240\159\159\162 Copy Config With Loader",
			Func = function()
				local G = q.Config.BuildCopyWithLoaderText()
				if not G then
					T.Notify("Failed to create config", 3)
					return
				end
				J.CopyToClipBoard(G)
				T.Notify("Config copied. Add and enter your key.", 3)
			end
		})
	end
	if y then
		local G = y:AddButton({
			Text = "\240\159\154\168 Rejoin Server";
			Func = function()
				u.Player.Rejoin()
			end
		})
		local V = y:AddButton({
			Text = "\240\159\147\161 Hop Server",
			Func = function()
				r.Hop.HopToNewServer()
			end
		})
		y:AddDivider()
		y:AddToggle("automiddletp", {
			Text = "\240\159\147\141 Spawn Middle",
			Default = e.char_farm_middle;
			Tooltip = "Place your character in the centre of the farm when you join.";
			Callback = function(G)
				e.char_farm_middle = G
				q.Save.SaveDataSync()
			end
		})
	end
end
T.MailUi = function()
	local G = i:AddTab({
		Name = "Mail " .. T.GetProLabel(),
		Description = "Send and receive items";
		Icon = "mail"
	})
	local V = G:AddLeftGroupbox("Manual Order", "send")
	local y = G:AddRightGroupbox("Automatic Send", "repeat-2")
	local Z = G:AddLeftGroupbox("Receipts", "receipt-text")
	local j = G:AddRightGroupbox("Incoming Mail", "mail-open")
	if V then
		local G = "Seeds"
		local y = ""
		local Z = 1
		local j = T.MailDraftFruitMinKg
		local i = T.MailDraftFruitMaxKg
		local c = T.MailDraftFruitMutations
		local J = T.MailDraftFruitVariants
		local d
		local g
		local E
		local a
		local H
		V:AddLabel({
			Text = "Enter the exact Roblox username. @ is optional.";
			DoesWrap = true
		})
		V:AddInput("mail_manual_username_ui", {
			Text = "\240\159\145\164 Recipient Username",
			Default = T.MailDraftTargetUsername;
			Numeric = false,
			AllowEmpty = true,
			Finished = true;
			ClearTextOnFocus = false;
			Placeholder = "Roblox username";
			Callback = function(G)
				T.MailDraftTargetUsername = u.Mail.CleanUsername(G)
			end
		})
		V:AddButton({
			Text = "\240\159\148\142 Check Recipient";
			Func = function()
				local G, V = u.Mail.LookupRecipient(T.MailDraftTargetUsername)
				if not G then
					T.Notify(V, 3)
					u.Mail.SetStatus(V, "#FF5555")
					return
				end
				T.Notify(string.format("Found @%s (%s)", G.username, G.displayName), 4)
				u.Mail.SetStatus(string.format("Recipient ready: @%s", G.username), "#7CFC00")
			end
		})
		V:AddToggle("mail_include_comment_ui", {
			Text = "\240\159\146\172 Include Order Comment",
			Default = e.mail_include_comment;
			Tooltip = "Adds the order ID and progress to each mail.",
			Callback = function(G)
				e.mail_include_comment = G
				q.Save.SaveDataSync()
			end
		})
		a = V:AddToggle("mail_ignore_batch_limit_ui", {
			Text = "\240\159\147\166 Ignore 20 Item Limit";
			Default = e.mail_ignore_batch_limit;
			Tooltip = "Sends the full amount in one mail. Applies to manual and automatic sending.";
			DisabledTooltip = T.GetProMessage(),
			Callback = function(G)
				e.mail_ignore_batch_limit = G
				q.Save.SaveDataSync()
			end
		})
		H = V:AddToggle("mail_manual_batch_together_ui", {
			Text = "\240\159\147\166 Combine Order Items";
			Default = e.mail_manual_batch_together;
			Tooltip = "Combines different order items into the same mail when possible.";
			DisabledTooltip = T.GetProMessage(),
			Callback = function(G)
				e.mail_manual_batch_together = G
				q.Save.SaveDataSync()
			end
		})
		H:SetDisabled(not T.GetCheckIfPro())
		V:AddDivider()
		local r
		r = V:AddDropdown("mail_manual_category_ui", {
			Values = {
				"Seeds";
				"Pets",
				"Gears";
				"Fruits"
			};
			Default = G,
			Multi = false;
			Text = "\240\159\147\166 Item Category";
			Tooltip = "Choose seeds, pets, gears or fruits.",
			Callback = function(V)
				if V ~= "Seeds" and (V ~= "Pets" and (V ~= "Gears" and V ~= "Fruits")) then
					return
				end
				G = V
				y = ""
				T.MailDraftCategory = V
				T.MailDraftItemName = ""
				if d then
					d:SetValues(u.Mail.GetItemDropdown(V))
					d:SetValue("")
				end
			end
		})
		r:SetValue(G)
		d = V:AddValueDropdown("mail_manual_item_ui", {
			Values = {};
			Default = "";
			Multi = false,
			Searchable = true;
			MaxVisibleDropdownItems = 10;
			Text = "\240\159\142\129 Select Item",
			Tooltip = "Select the item to add to the order.",
			Changed = function(G)
				if type(G) ~= "string" or G == "" then
					return
				end
				y = G
				T.MailDraftItemName = G
			end
		})
		d:SetValues(u.Mail.GetItemDropdown(G))
		local Y
		Y = V:AddInput("mail_manual_amount_ui", {
			Text = "\240\159\148\162 Amount";
			Default = tostring(Z),
			Numeric = true;
			AllowEmpty = true;
			Finished = true;
			ClearTextOnFocus = false;
			Placeholder = "Amount to send",
			Callback = function(G)
				local V = L(G)
				if not V or V <= 0 then
					T.Notify("Amount must be a whole number above 0", 3)
					Y:SetValue(tostring(Z))
					return
				end
				Z = V
				T.MailDraftAmount = V
			end
		})
		local s
		s = V:AddInput("mail_manual_fruit_min_kg_ui", {
			Text = "\240\159\141\147 Fruit Min KG";
			Default = tostring(j);
			Numeric = true,
			AllowEmpty = true,
			Finished = true,
			ClearTextOnFocus = false;
			Placeholder = "0",
			Tooltip = "Fruit mail only. Minimum fruit weight.";
			Callback = function(G)
				local V = m(G)
				if not V or V < 0 then
					T.Notify("Min KG must be 0 or above", 3)
					s:SetValue(tostring(j))
					return
				end
				j = V
				T.MailDraftFruitMinKg = V
			end
		})
		local N
		N = V:AddInput("mail_manual_fruit_max_kg_ui", {
			Text = "\240\159\141\147 Fruit Max KG",
			Default = tostring(i);
			Numeric = true,
			AllowEmpty = true;
			Finished = true,
			ClearTextOnFocus = false,
			Placeholder = "89",
			Tooltip = "Fruit mail only. Maximum fruit weight.";
			Callback = function(G)
				local V = m(G)
				if not V or V < 0 then
					T.Notify("Max KG must be 0 or above", 3)
					N:SetValue(tostring(i))
					return
				end
				i = V
				T.MailDraftFruitMaxKg = V
			end
		})
		V:AddValueDropdown("mail_manual_fruit_mutations_ui", {
			Values = u.FruitFilters.GetMutationNames(),
			Default = {},
			Multi = true;
			Searchable = true;
			MaxVisibleDropdownItems = 8,
			Text = "\240\159\141\147 Fruit Mutations";
			Tooltip = "Fruit mail only. No selection sends all mutations.",
			Changed = function(G)
				c = type(G) == "table" and G or {}
				T.MailDraftFruitMutations = c
			end
		})
		V:AddValueDropdown("mail_manual_fruit_variants_ui", {
			Values = u.FruitFilters.GetVariantNames(),
			Default = {};
			Multi = true;
			Searchable = false;
			MaxVisibleDropdownItems = 5;
			Text = "\240\159\141\147 Fruit Variants",
			Tooltip = "Fruit mail only. No selection sends all variants.";
			Changed = function(G)
				J = type(G) == "table" and G or {}
				T.MailDraftFruitVariants = J
			end
		})
		E = V:AddButton({
			Text = "\226\158\149 Add To Order";
			DisabledTooltip = T.GetProMessage(),
			Func = function()
				local V, d = u.Mail.AddDraftItem(G, y, Z, j, i, c, J)
				T.Notify(d, 3)
				if V then
					u.Mail.SetStatus(d, "#7CFC00")
				else
					u.Mail.SetStatus(d, "#FF5555")
				end
			end
		})
		E:SetDisabled(not T.GetCheckIfPro())
		a:SetDisabled(not T.GetCheckIfPro())
		V:AddDivider()
		g = V:AddLabel({
			Text = u.Mail.GetDraftText(),
			DoesWrap = true
		})
		T.MailUiRefs.RefreshDraft = function()
			if g then
				g:SetText(u.Mail.GetDraftText())
			end
		end
		T.MailManualStatusLabel = V:AddLabel({
			Text = T.MailManualUiStatusText,
			DoesWrap = true
		})
		T.MailStartOrderButton = V:AddButton({
			Text = "\226\150\182\239\184\143 Start Sending";
			Disabled = T.MailManualRunning;
			DisabledTooltip = "The current order is still sending.";
			Func = function()
				if not T.GetCheckIfPro() then
					T.Notify(T.GetProMessage(), 5)
					return
				end
				local G, V = u.Mail.StartManualOrder(T.MailDraftTargetUsername)
				T.Notify(V, G and 3 or 4)
				if not G then
					u.Mail.SetStatus(V, "#FF5555")
				end
			end
		})
		T.MailStopOrderButton = T.MailStartOrderButton:AddButton({
			Text = "\226\143\185\239\184\143 Stop",
			Disabled = not T.MailManualRunning;
			DisabledTooltip = "No manual order is running.";
			Func = function()
				if not T.GetCheckIfPro() then
					T.Notify(T.GetProMessage(), 5)
					return
				end
				if u.Mail.StopManualOrder() then
					T.Notify("Manual order stopped", 3)
				end
			end
		})
		T.MailClearOrderButton = V:AddButton({
			Text = "\240\159\167\185 Clear Order",
			Disabled = T.MailManualRunning;
			DisabledTooltip = "The current order is still sending.";
			Func = function()
				if u.Mail.ClearDraft() then
					u.Mail.SetManualUiStatus("Order cleared", "#CFCFCF", "\240\159\167\185")
					T.Notify("Order cleared", 2)
				else
					T.Notify("Stop the current order first", 3)
				end
			end
		})
		u.Mail.RefreshManualUi()
	end
	if y then
		local G = ""
		local V = "Seeds"
		local Z = ""
		local j = 5
		local i = 5
		local c = {}
		local J = {}
		local d = 0
		local g = 89
		local E = {}
		local a = {}
		local H
		local r
		local Y
		local s
		y:AddLabel({
			Text = "Sends when the matching inventory amount reaches the trigger.";
			DoesWrap = true
		})
		y:AddInput("mail_rule_username_ui", {
			Text = "\240\159\145\164 Recipient Username",
			Default = "";
			Numeric = false,
			AllowEmpty = true,
			Finished = true,
			ClearTextOnFocus = false,
			Placeholder = "Roblox username",
			Callback = function(V)
				G = u.Mail.CleanUsername(V)
			end
		})
		local N
		N = y:AddDropdown("mail_rule_category_ui", {
			Values = {
				"Seeds",
				"Pets",
				"Gears";
				"Fruits"
			},
			Default = V,
			Multi = false;
			Text = "\240\159\147\166 Item Category",
			Tooltip = "Choose seeds, pets, gears or fruits.",
			Callback = function(G)
				if G ~= "Seeds" and (G ~= "Pets" and (G ~= "Gears" and G ~= "Fruits")) then
					return
				end
				V = G
				Z = ""
				if H then
					H:SetValues(u.Mail.GetItemDropdown(G))
					H:SetValue("")
				end
			end
		})
		N:SetValue(V)
		H = y:AddValueDropdown("mail_rule_item_ui", {
			Values = {},
			Default = "";
			Multi = false,
			Searchable = true,
			MaxVisibleDropdownItems = 10,
			Text = "\240\159\142\129 Select Item",
			Tooltip = "Select the item the rule will send.",
			Changed = function(G)
				if type(G) ~= "string" or G == "" then
					return
				end
				Z = G
			end
		})
		H:SetValues(u.Mail.GetItemDropdown(V))
		local W
		W = y:AddInput("mail_rule_trigger_ui", {
			Text = "\240\159\142\175 Trigger Amount";
			Default = tostring(j);
			Numeric = true,
			AllowEmpty = true,
			Finished = true,
			ClearTextOnFocus = false,
			Placeholder = "Example: 5",
			Tooltip = "The rule starts when you own at least this amount.",
			Callback = function(G)
				local V = L(G)
				if not V or V <= 0 then
					T.Notify("Trigger must be above 0", 3)
					W:SetValue(tostring(j))
					return
				end
				j = V
			end
		})
		local X
		X = y:AddInput("mail_rule_send_amount_ui", {
			Text = "\240\159\147\164 Send Amount";
			Default = tostring(i);
			Numeric = true;
			AllowEmpty = true;
			Finished = true,
			ClearTextOnFocus = false;
			Placeholder = "Example: 5";
			Tooltip = "How many matching items to send each time the rule runs.";
			Callback = function(G)
				local V = L(G)
				if not V or V <= 0 then
					T.Notify("Send amount must be above 0", 3)
					X:SetValue(tostring(i))
					return
				end
				i = V
			end
		})
		local h
		h = y:AddValueDropdown("mail_rule_pet_types_ui", {
			Values = {
				"Normal",
				"Rainbow"
			};
			Default = {},
			Multi = true;
			Searchable = false,
			MaxVisibleDropdownItems = 5,
			Text = "\226\156\168 Pet Variant";
			Tooltip = "Pet rules only. No selection sends all variants.";
			Changed = function(G)
				c = type(G) == "table" and G or {}
			end
		})
		h:SetValue({})
		local l
		l = y:AddValueDropdown("mail_rule_pet_sizes_ui", {
			Values = {
				"Normal";
				"Big";
				"Huge"
			},
			Default = {};
			Multi = true,
			Searchable = false,
			MaxVisibleDropdownItems = 5;
			Text = "\240\159\147\143 Pet Size",
			Tooltip = "Pet rules only. No selection sends all sizes.",
			Changed = function(G)
				J = type(G) == "table" and G or {}
			end
		})
		l:SetValue({})
		local B
		B = y:AddInput("mail_rule_fruit_min_kg_ui", {
			Text = "\240\159\141\147 Fruit Min KG",
			Default = tostring(d),
			Numeric = true,
			AllowEmpty = true,
			Finished = true,
			ClearTextOnFocus = false,
			Placeholder = "0";
			Tooltip = "Fruit rules only. Minimum fruit weight.",
			Callback = function(G)
				local V = m(G)
				if not V or V < 0 then
					T.Notify("Min KG must be 0 or above", 3)
					B:SetValue(tostring(d))
					return
				end
				d = V
			end
		})
		local K
		K = y:AddInput("mail_rule_fruit_max_kg_ui", {
			Text = "\240\159\141\147 Fruit Max KG";
			Default = tostring(g);
			Numeric = true,
			AllowEmpty = true,
			Finished = true,
			ClearTextOnFocus = false,
			Placeholder = "89";
			Tooltip = "Fruit rules only. Maximum fruit weight.",
			Callback = function(G)
				local V = m(G)
				if not V or V < 0 then
					T.Notify("Max KG must be 0 or above", 3)
					K:SetValue(tostring(g))
					return
				end
				g = V
			end
		})
		y:AddValueDropdown("mail_rule_fruit_mutations_ui", {
			Values = u.FruitFilters.GetMutationNames(),
			Default = {},
			Multi = true,
			Searchable = true;
			MaxVisibleDropdownItems = 8;
			Text = "\240\159\141\147 Fruit Mutations";
			Tooltip = "Fruit rules only. No selection sends all mutations.",
			Changed = function(G)
				E = type(G) == "table" and G or {}
			end
		})
		y:AddValueDropdown("mail_rule_fruit_variants_ui", {
			Values = u.FruitFilters.GetVariantNames(),
			Default = {};
			Multi = true,
			Searchable = false;
			MaxVisibleDropdownItems = 5,
			Text = "\240\159\141\147 Fruit Variants";
			Tooltip = "Fruit rules only. No selection sends all variants.";
			Changed = function(G)
				a = type(G) == "table" and G or {}
			end
		})
		s = y:AddButton({
			Text = "\226\158\149 Add Auto Rule";
			Func = function()
				local y, q = u.Mail.LookupRecipient(G)
				if not y then
					T.Notify(q, 4)
					u.Mail.SetStatus(q, "#FF5555")
					return
				end
				local H, r = u.Mail.AddRule(y, V, Z, j, i, c, J, d, g, E, a)
				if H then
					T.Notify("Rule added: " .. r, 3)
					u.Mail.SetStatus("Auto rule added", "#7CFC00")
				else
					T.Notify(r, 4)
					u.Mail.SetStatus(r, "#FF5555")
				end
			end
		})
		s:SetDisabled(not T.GetCheckIfPro())
		y:AddDivider()
		r = y:AddValueDropdown("mail_active_rules_ui", {
			Values = {};
			Default = "",
			Multi = false;
			Searchable = true,
			MaxVisibleDropdownItems = 8;
			Text = "\240\159\147\139 Active Rules";
			Tooltip = "Select a rule to enable, disable or remove it.";
			Changed = function(G)
				if type(G) ~= "string" then
					return
				end
				T.MailSelectedRuleId = G
				local V = type(e.mail_auto_rules) == "table" and e.mail_auto_rules[G]
				if Y and type(V) == "table" then
					Y:SetText(string.format("%s | @%s | Trigger %d | Send %d", V.enabled == true and "Enabled" or "Disabled", tostring(V.targetUsername or "?"), tonumber(V.triggerAmount) or 0, tonumber(V.sendAmount) or 0))
				end
			end
		})
		Y = y:AddLabel({
			Text = "Select a rule";
			DoesWrap = true
		})
		T.MailUiRefs.RefreshRules = function()
			if r then
				r:SetValues(u.Mail.GetRuleDropdown())
			end
			if Y and next(e.mail_auto_rules or {}) == nil then
				Y:SetText("<font color=\'#888888\'>No automatic rules</font>")
			end
		end
		T.MailUiRefs.RefreshRules()
		local b = y:AddButton({
			Text = "\240\159\148\132 Enable / Disable";
			Func = function()
				local G, V = u.Mail.ToggleRule(T.MailSelectedRuleId)
				if not G then
					T.Notify("Select a rule first", 3)
					return
				end
				T.Notify(V and "Rule enabled" or "Rule disabled", 3)
			end
		})
		b:AddButton({
			Text = "\240\159\151\145\239\184\143 Remove Rule";
			Func = function()
				if not u.Mail.RemoveRule(T.MailSelectedRuleId) then
					T.Notify("Select a rule first", 3)
					return
				end
				T.MailSelectedRuleId = ""
				Y:SetText("Select a rule")
				T.Notify("Rule removed", 3)
			end
		})
		y:AddDivider()
		local S
		S = y:AddToggle("mail_auto_batch_together_ui", {
			Text = "\240\159\147\166 Combine Automatic Rules",
			Default = e.mail_auto_batch_together,
			Tooltip = "Combines matching rules for the same recipient into one mail.";
			DisabledTooltip = T.GetProMessage(),
			Callback = function(G)
				e.mail_auto_batch_together = G
				q.Save.SaveDataSync()
			end
		})
		S:SetDisabled(not T.GetCheckIfPro())
		y:AddDivider()
		local z
		z = y:AddToggle("mail_auto_send_enabled_ui", {
			Text = "\240\159\147\164 Enable Automatic Send";
			Default = e.mail_auto_send_enabled;
			Tooltip = "Runs enabled mail rules when their trigger is reached.";
			DisabledTooltip = T.GetProMessage(),
			Callback = function(G)
				e.mail_auto_send_enabled = G
				if G then
					u.Mail.SetStatus("Automatic send enabled", "#7CFC00")
				elseif not e.mail_auto_accept and not T.MailManualRunning then
					u.Mail.ClearStatus()
				end
				q.Save.SaveDataSync()
			end
		})
		z:SetDisabled(not T.GetCheckIfPro())
	end
	if Z then
		local G
		local V
		Z:AddLabel({
			Text = "Stores the latest 50 completed manual order receipts.";
			DoesWrap = true
		})
		G = Z:AddValueDropdown("mail_receipts_ui", {
			Values = {},
			Default = "";
			Multi = false;
			Searchable = true;
			MaxVisibleDropdownItems = 8;
			Text = "\240\159\167\190 Select Receipt",
			Tooltip = "Select a receipt to view or copy it.",
			Changed = function(G)
				local y = tonumber(G)
				local Z = y and e.mail_receipts[y]
				if type(Z) ~= "string" then
					return
				end
				T.MailSelectedReceipt = Z
				if V then
					V:SetText(Z)
				end
			end
		})
		V = Z:AddLabel({
			Text = "<font color=\'#888888\'>No receipt selected</font>",
			DoesWrap = true
		})
		T.MailUiRefs.RefreshReceipts = function()
			if G then
				G:SetValues(u.Mail.GetReceiptDropdown())
			end
			if V and # e.mail_receipts == 0 then
				V:SetText("<font color=\'#888888\'>No receipts saved</font>")
			end
		end
		T.MailUiRefs.RefreshReceipts()
		local y = Z:AddButton({
			Text = "\240\159\147\139 Copy Receipt";
			Func = function()
				if T.MailSelectedReceipt == "" then
					T.Notify("Select a receipt first", 3)
					return
				end
				J.CopyToClipBoard(T.MailSelectedReceipt)
			end
		})
		y:AddButton({
			Text = "\240\159\167\185 Clear Receipts";
			Func = function()
				e.mail_receipts = {}
				T.MailSelectedReceipt = ""
				V:SetText("<font color=\'#888888\'>No receipts saved</font>")
				T.MailUiRefs.RefreshReceipts()
				q.Save.SaveDataSync()
				T.Notify("Receipts cleared", 3)
			end
		})
	end
	if j then
		j:AddLabel({
			Text = "Claims item mail automatically. Guild invitations are not accepted.",
			DoesWrap = true
		})
		j:AddToggle("mail_auto_accept_ui", {
			Text = "\240\159\147\165 Auto Accept Incoming Mail",
			Default = e.mail_auto_accept,
			Tooltip = "Automatically claims incoming item mail.",
			Callback = function(G)
				e.mail_auto_accept = G
				if G then
					u.Mail.SetStatus("Auto accept enabled", "#7CFC00")
					task.defer(function()
						u.Mail.ClaimInbox(false)
					end)
				elseif not e.mail_auto_send_enabled and not T.MailManualRunning then
					u.Mail.ClearStatus()
				end
				q.Save.SaveDataSync()
			end
		})
		j:AddButton({
			Text = "\240\159\147\172 Claim Existing Mail",
			Func = function()
				task.spawn(function()
					local G = u.Mail.ClaimInbox(true)
					T.Notify(string.format("Claimed %d mail", G), 3)
				end)
			end
		})
	end
end
T.GiftUi = function()
	local G = i:AddTab({
		Name = "\240\159\142\129 Gift System",
		Description = "Send and receive gifts",
		Icon = "gift"
	})
	if u.GiftSystem and type(u.GiftSystem.UiGiftSystem) == "function" then
		u.GiftSystem.UiGiftSystem(G)
	end
end
T.PremiumUi = function()
	local G = i:AddTab({
		Name = "Premium " .. T.GetProLabel();
		Description = "Premium systems",
		Icon = "crown"
	})
	local V = G.TabLabel
	Y.applySmoothRainbow(V, .1)
	local y = G:AddLeftGroupbox("Premium Performance", "cloud-rain")
	local Z = G:AddRightGroupbox("Double or Nothing", "dice-5")
	local j = G:AddLeftGroupbox("Sprinkler Placement", "cloud-rain")
	local c = G:AddRightGroupbox("Sprinkler Overrides", "list-plus")
	if Z then
		if not T.GetCheckIfPro() then
			Z:AddLabel({
				Text = T.GetProMessage(),
				DoesWrap = true
			})
		end
		Z:AddLabel({
			Text = "Uses full backpack only. When enabled, normal Sell All is blocked so cash-out cannot reject because of sold fruits.",
			DoesWrap = true
		})
		local G
		local V
		local y = false
		local j = false
		local function i(V)
			if not G then
				return
			end
			local Z = math.clamp(math.floor(tonumber(V) or e.double_or_nothing_target_streak or 3), 1, 10)
			y = true
			G:SetValue(tostring(Z))
			G:SetText("\240\159\148\165 Target Streak: " .. tostring(Z))
			y = false
		end
		local function c(G)
			if not V then
				return
			end
			local y = math.clamp(tonumber(G) or e.double_or_nothing_roll_delay or .15, .001, 3)
			j = true
			V:SetValue(tostring(y))
			V:SetText("\226\154\161 Roll Delay: " .. (tostring(y) .. "s"))
			j = false
		end
		G = Z:AddInput("double_or_nothing_target_streak_ui", {
			Text = "\240\159\148\165 Target Streak";
			Default = tostring(e.double_or_nothing_target_streak),
			Numeric = true;
			AllowEmpty = false,
			Finished = true,
			ClearTextOnFocus = false;
			Placeholder = "3",
			Tooltip = "Cashes out after this streak. Default is 3.";
			Callback = function(G)
				if y then
					return
				end
				local V = L(G)
				if not V or V < 1 or V > 10 then
					T.Notify("Streak must be between 1 and 10", 3)
					i(e.double_or_nothing_target_streak)
					return
				end
				e.double_or_nothing_target_streak = V
				i(V)
				q.Save.SaveData()
			end
		})
		i(e.double_or_nothing_target_streak)
		V = Z:AddInput("double_or_nothing_roll_delay_ui", {
			Text = "\226\154\161 Roll Delay",
			Default = tostring(e.double_or_nothing_roll_delay),
			Numeric = false,
			AllowEmpty = false;
			Finished = true,
			ClearTextOnFocus = false,
			Placeholder = "0.15",
			Tooltip = "Small delay between rolls. Increase if remotes reject.";
			Callback = function(G)
				if j then
					return
				end
				local V = tonumber(G)
				if not V or V < .001 or V > 3 then
					T.Notify("Delay must be between 0.01 and 3", 3)
					c(e.double_or_nothing_roll_delay)
					return
				end
				e.double_or_nothing_roll_delay = V
				c(V)
				q.Save.SaveData()
			end
		})
		c(e.double_or_nothing_roll_delay)
		local J
		J = Z:AddToggle("double_or_nothing_enabled_ui", {
			Text = "\240\159\142\178 Enable Double or Nothing",
			Default = e.auto_double_or_nothing == true;
			Tooltip = "Runs on full backpack and blocks normal Sell All while active.",
			DisabledTooltip = T.GetProMessage();
			Callback = function(G)
				e.auto_double_or_nothing = G == true
				if not G and u.DoubleOrNothingSeller then
					u.DoubleOrNothingSeller.SetStatusDoubleOrNothingSeller("")
				end
				q.Save.SaveData()
			end
		})
		J:SetDisabled(not T.GetCheckIfPro())
		Z:AddToggle("double_or_nothing_webhook_win_ui", {
			Text = "\226\156\133 Webhook Wins";
			Default = e.double_or_nothing_webhook_win == true;
			Tooltip = "Sends a webhook after successful cash-out.",
			Callback = function(G)
				e.double_or_nothing_webhook_win = G == true
				q.Save.SaveData()
			end
		})
		Z:AddToggle("double_or_nothing_webhook_loss_ui", {
			Text = "\240\159\146\165 Webhook Losses",
			Default = e.double_or_nothing_webhook_loss == true;
			Tooltip = "Sends a webhook when Double or Nothing busts.",
			Callback = function(G)
				e.double_or_nothing_webhook_loss = G == true
				q.Save.SaveData()
			end
		})
		Z:AddDivider()
		local d = Z:AddLabel({
			Text = u.DoubleOrNothingSeller.GetLogsTextDoubleOrNothingSeller();
			DoesWrap = true
		})
		T.DoubleOrNothingUi.RefreshLogsDoubleOrNothingUi = function()
			if d and type(d.SetText) == "function" then
				d:SetText(u.DoubleOrNothingSeller.GetLogsTextDoubleOrNothingSeller())
			end
		end
		Z:AddButton({
			Text = "\240\159\167\185 Clear Logs";
			Func = function()
				table.clear(T.DoubleOrNothingLogs)
				T.DoubleOrNothingUi.RefreshLogsDoubleOrNothingUi()
				T.Notify("Double or Nothing logs cleared", 2)
			end
		})
	end
	if y then
		y:AddLabel({
			Text = "<b><font color=\'#FFD700\'>\226\173\144 Premium Ultra Mode</font></b>\n<font color=\'#7CFC00\'>Works:</font> fast fruit collection, farm details, fruit/plant counts, pets, shops, mail.\n<font color=\'#FFAA55\'>Limited:</font> shovel, trowel, plant-target water/sprinklers, seed spacing.\n<font color=\'#FF5555\'>Important:</font> turn OFF and rejoin to bring plant models back.",
			DoesWrap = true
		})
		local G
		G = y:AddToggle("premiumperformancenolimit-", {
			Text = "<font color=\'#FF0000\'>\226\154\161 No Limits </font> <font color=\'#FF00C8\'>PRO</font>",
			Default = e.fruit_collect_nolimits,
			Tooltip = "This may cause lag. Set timers to lowest.",
			DisabledTooptip = T.GetProMessage(),
			Callback = function(G)
				e.fruit_collect_nolimits = G
				q.Save.SaveData()
			end
		})
		local V
		V = y:AddToggle("premiumperformance-", {
			Text = "<font color=\'#FFD700\'>\240\159\154\128 Ultra Mode</font> <font color=\'#FF00C8\'>PRO</font>",
			Default = e.high_mode,
			Tooltip = "Premium speed mode. Removes garden plant models for less lag and faster fruit collection. Turn off and rejoin to bring plants back.",
			DisabledTooptip = T.GetProMessage(),
			Callback = function(G)
				e.high_mode = G
				q.Save.SaveDataSync()
				if G then
					T.Notify("Ultra Mode enabled. Some plant-target systems need models and may not work.", 4)
				else
					T.Notify("Ultra Mode disabled. Rejoin to bring plant models back.", 4)
				end
			end
		})
		V:SetDisabled(not T.GetCheckIfPro())
		G:SetDisabled(not T.GetCheckIfPro())
	end
	if j then
		if not T.GetCheckIfPro() then
			j:AddLabel({
				Text = T.GetProMessage();
				DoesWrap = true
			})
		end
		j:AddLabel({
			Text = "\240\159\146\161 Auto place sprinklers.",
			DoesWrap = true
		})
		local G
		G = j:AddValueDropdown("sprinkler_place_selected_ui", {
			Values = {},
			Default = {},
			Multi = true;
			Searchable = true,
			MaxVisibleDropdownItems = 10,
			Text = "\240\159\146\166 Sprinklers To Place",
			Tooltip = "Selected sprinklers will be kept at their target amount.";
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.sprinkler_place_selected = G
				q.Save.SaveDataSync()
			end
		})
		G:SetValues(u.SprinklerPlacer.GetDropdown())
		G:SetValue(e.sprinkler_place_selected)
		local V = j:AddButton({
			Text = "\226\156\133 All";
			Func = function()
				e.sprinkler_place_selected = u.SprinklerPlacer.GetAllSelection()
				G:SetValue(e.sprinkler_place_selected)
				q.Save.SaveDataSync()
			end
		})
		V:AddButton({
			Text = "\240\159\167\185 Clear",
			Func = function()
				e.sprinkler_place_selected = {}
				G:SetValue({})
				q.Save.SaveDataSync()
			end
		})
		j:AddDivider()
		local y
		y = j:AddInput("sprinkler_place_default_target_ui", {
			Text = "\240\159\142\175 Default Target";
			Default = tostring(e.sprinkler_place_default_target),
			Numeric = true,
			AllowEmpty = true,
			Finished = true;
			ClearTextOnFocus = false,
			Placeholder = "Amount per sprinkler";
			Tooltip = "Places more when a selected sprinkler falls below this amount.";
			Callback = function(G)
				local V = L(G)
				if not V or V <= 0 then
					T.Notify("Target must be a whole number above 0", 3)
					y:SetValue(tostring(e.sprinkler_place_default_target))
					return
				end
				e.sprinkler_place_default_target = V
				q.Save.SaveDataSync()
			end
		})
		j:AddDivider()
		local Z
		Z = j:AddDropdown("sprinkler_place_mode_ui", {
			Values = {
				"Farm Middle";
				"Plant Target",
				"Saved Position"
			},
			Default = e.sprinkler_place_mode,
			Multi = false;
			Text = "\240\159\147\141 Placement Mode",
			Tooltip = "Choose where sprinklers should be placed.",
			Callback = function(G)
				if type(G) ~= "string" or G == "" then
					return
				end
				e.sprinkler_place_mode = G
				q.Save.SaveDataSync()
			end
		})
		Z:SetValue(e.sprinkler_place_mode)
		local i
		i = j:AddValueDropdown("sprinkler_place_target_plant_ui", {
			Values = {},
			Default = "";
			Multi = false,
			Searchable = true;
			MaxVisibleDropdownItems = 10;
			Text = "\240\159\140\177 Target Plant";
			Tooltip = "Plant Target mode places sprinklers around this plant type.";
			Changed = function(G)
				if type(G) ~= "string" then
					return
				end
				e.sprinkler_place_target_plant = G
				q.Save.SaveDataSync()
			end
		})
		i:SetValues(u.SeedData.GetSeedDataListDropDown())
		i:SetValue(e.sprinkler_place_target_plant)
		local c = j:AddLabel({
			Text = u.SprinklerPlacer.GetSavedPositionText();
			DoesWrap = true
		})
		j:AddButton({
			Text = "\240\159\147\140 Copy Current Position",
			Tooltip = "Stand inside your farm where sprinklers should be placed.",
			Func = function()
				local G, V = u.SprinklerPlacer.SaveCurrentPosition()
				T.Notify(V, 3)
				if G then
					e.sprinkler_place_mode = "Saved Position"
					Z:SetValue("Saved Position")
					c:SetText(u.SprinklerPlacer.GetSavedPositionText())
					q.Save.SaveDataSync()
				end
			end
		})
		j:AddDivider()
		local J
		J = j:AddValueDropdown("sprinkler_place_weather_selected_ui", {
			Values = u.WeatherTriggers.GetDropdownWeatherTriggers(),
			Default = {},
			Multi = true,
			Searchable = true;
			MaxVisibleDropdownItems = 8;
			Text = "\240\159\140\166\239\184\143 Weather Trigger",
			Tooltip = "No selection allows any weather.",
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.sprinkler_place_weather_selected = G
				q.Save.SaveData()
			end
		})
		J:SetValue(e.sprinkler_place_weather_selected)
		j:AddToggle("sprinkler_place_weather_enabled_ui", {
			Text = "\240\159\140\166\239\184\143 Use Weather Trigger",
			Default = e.sprinkler_place_weather_enabled;
			Tooltip = "Only places sprinklers during selected weather or time cycle.",
			Callback = function(G)
				e.sprinkler_place_weather_enabled = G == true
				q.Save.SaveData()
			end
		})
		j:AddDivider()
		j:AddToggle("sprinkler_place_teleport_ui", {
			Text = "\240\159\147\161 Auto Teleport";
			Default = e.sprinkler_place_teleport,
			Tooltip = "Leave disabled to attempt placement from anywhere. Enable it to teleport near the placement position.",
			Callback = function(G)
				e.sprinkler_place_teleport = G
				if not G then
					u.Teleport.UnlockTeleport(T.TeleportLockNames.SprinklerPlacer)
				end
				q.Save.SaveDataSync()
			end
		})
		local d
		d = j:AddToggle("enable_sprinkler_placer_ui", {
			Text = "\240\159\146\166 Enable Sprinkler System",
			Default = e.auto_sprinkler_place,
			Tooltip = "Automatically places selected sprinklers when their amount is too low.",
			DisabledTooltip = T.GetProMessage(),
			Callback = function(G)
				e.auto_sprinkler_place = G
				if not G then
					u.SprinklerPlacer.CleanupTool()
					u.SprinklerPlacer.ClearStatus()
					u.Teleport.UnlockTeleport(T.TeleportLockNames.SprinklerPlacer)
				end
				q.Save.SaveDataSync()
			end
		})
		d:SetDisabled(not T.GetCheckIfPro())
	end
	if c then
		local G = ""
		local V = math.max(math.floor(tonumber(e.sprinkler_place_default_target) or 1), 1)
		local y = false
		local Z = {}
		local j = 0
		local i
		local J
		c:AddLabel({
			Text = "\240\159\146\161 Set a different target for individual sprinklers.",
			DoesWrap = true
		})
		local function d()
			for G, V in ipairs(Z) do
				if V.Holder and typeof(V.Holder) == "Instance" then
					V.Holder:Destroy()
				end
			end
			table.clear(Z)
			if c.Resize then
				c:Resize()
			end
		end
		local function g()
			local V = u.SprinklerPlacer.GetOverrideTarget(G)
			if V ~= nil then
				return V
			end
			return math.max(math.floor(tonumber(e.sprinkler_place_default_target) or 1), 1)
		end
		local function E()
			if G == "" then
				return
			end
			V = g()
			y = true
			if i then
				i:SetValue(tostring(V))
				i:SetText(string.format("\240\159\142\175 Target Amount: <font color=\'#7CFC00\'>%d</font>", V))
			end
			if J then
				J:SetValue(u.SprinklerPlacer.GetOverrideTarget(G) ~= nil)
			end
			y = false
		end
		local a
		a = function()
			d()
			j += 1
			local V = {}
			if type(e.sprinkler_place_overrides) == "table" then
				for G in pairs(e.sprinkler_place_overrides) do
					if u.SprinklerPlacer.GetOverrideTarget(G) ~= nil then
						table.insert(V, G)
					end
				end
			end
			table.sort(V)
			if # V == 0 then
				local G = c:AddLabel({
					Text = "<font color=\'#888888\'>No active sprinkler overrides</font>";
					DoesWrap = true
				})
				table.insert(Z, G)
			else
				for V, y in ipairs(V) do
					local i = u.SprinklerPlacer.GetOverrideTarget(y)
					local J
					J = c:AddToggle(string.format("sprinkler_active_override_%d_%d", j, V), {
						Text = string.format("\240\159\146\166 %s <font color=\'#7CFC00\'>Target: %d</font>", y, i);
						Default = true,
						Tooltip = "Disable this sprinkler override.",
						Callback = function(V)
							if V then
								return
							end
							u.SprinklerPlacer.RemoveOverrideTarget(y)
							q.Save.SaveDataSync()
							if G == y then
								E()
							end
							task.defer(a)
						end
					})
					table.insert(Z, J)
				end
			end
			if c.Resize then
				c:Resize()
			end
		end
		local H
		H = c:AddValueDropdown("sprinkler_override_select_ui", {
			Values = {},
			Default = "";
			Multi = false,
			Searchable = true;
			MaxVisibleDropdownItems = 10,
			Text = "\240\159\146\166 Select Sprinkler",
			Tooltip = "Select a sprinkler to configure its target.",
			Changed = function(V)
				if type(V) ~= "string" or V == "" then
					return
				end
				G = V
				E()
			end
		})
		H:SetValues(u.SprinklerPlacer.GetDropdown())
		i = c:AddInput("sprinkler_override_target_ui", {
			Text = "\240\159\142\175 Target Amount",
			Default = tostring(V);
			Numeric = true,
			AllowEmpty = true,
			Finished = true,
			ClearTextOnFocus = false;
			Placeholder = "Enter target amount",
			Tooltip = "Sets how many of this sprinkler should remain active.";
			Callback = function(Z)
				if y then
					return
				end
				if G == "" then
					T.Notify("Select a sprinkler first", 3)
					return
				end
				local j = L(Z)
				if not j or j <= 0 then
					T.Notify("Target must be above 0", 3)
					E()
					return
				end
				V = j
				i:SetText(string.format("\240\159\142\175 Target Amount: <font color=\'#7CFC00\'>%d</font>", V))
				if u.SprinklerPlacer.GetOverrideTarget(G) ~= nil then
					u.SprinklerPlacer.SetOverrideTarget(G, V)
					q.Save.SaveDataSync()
					a()
				end
			end
		})
		J = c:AddToggle("sprinkler_override_enable_ui", {
			Text = "\240\159\146\165 Enable Override";
			Default = false,
			Tooltip = "Use the custom target for the selected sprinkler.",
			Callback = function(Z)
				if y then
					return
				end
				if G == "" then
					y = true
					J:SetValue(false)
					y = false
					T.Notify("Select a sprinkler first", 3)
					return
				end
				if Z then
					if not u.SprinklerPlacer.SetOverrideTarget(G, V) then
						y = true
						J:SetValue(false)
						y = false
						T.Notify("Failed to enable override", 3)
						return
					end
				else
					u.SprinklerPlacer.RemoveOverrideTarget(G)
				end
				q.Save.SaveDataSync()
				E()
				a()
			end
		})
		c:AddDivider()
		c:AddLabel({
			Text = "= <font color=\'#7CFC00\'>Active Sprinkler Overrides</font> =",
			DoesWrap = true
		})
		a()
	end
end
T.GardenItemsUi = function()
	local G = i:AddTab({
		Name = "Garden Items",
		Description = "Collect garden drops",
		Icon = "package-open"
	})
	local V = G:AddLeftGroupbox("Auto Collect", "hand")
	local y = G:AddRightGroupbox("Garden Expansion", "expand")
	local Z = G:AddLeftGroupbox("Pet Max Inventory", "paw-print")
	if Z then
		local G
		local V
		local y = false
		local j = false
		local function i(G)
			local V = u.GardenItems.PetMaxInventorySystem.GetMaximumUpgradePetMaxInventorySystem()
			if V <= 0 then
				return "\240\159\144\190 Max Upgrades (Unavailable)"
			end
			local y = math.clamp(math.floor(tonumber(G) or e.auto_expand_pet_inventory_max_upgrade or 1), 1, V)
			return string.format("\240\159\144\190 Max Upgrades (%d/%d)", y, V)
		end
		local function c(V)
			if not G then
				return
			end
			y = true
			G:SetValue(tostring(V))
			G:SetText(i(V))
			y = false
		end
		local function J(G)
			local V = tonumber(G)
			if not V then
				V = d.Currency.ParseMoney(tostring(G or e.pet_inventory_min_sheckles or 0))
			end
			V = math.max(tonumber(V) or 0, 0)
			return "\240\159\146\176 Keep Min Sheckles: " .. d.Currency.FormatMoney(V)
		end
		local function g(G)
			if not V then
				return
			end
			j = true
			V:SetValue(d.Currency.FormatMoney(G))
			V:SetText(J(G))
			j = false
		end
		local E = u.GardenItems.PetMaxInventorySystem.GetMaximumUpgradePetMaxInventorySystem()
		local a = u.GardenItems.PetMaxInventorySystem.GetNextPricePetMaxInventorySystem(u.GardenItems.PetMaxInventorySystem.GetBaseMaxPetMaxInventorySystem()) or 200000
		Z:AddLabel({
			Text = string.format("Starts at <font color=\'#7CFC00\'>1/%d</font>. First upgrade is <font color=\'#00FF00\'>$%s</font>.", math.max(E, 1), d.Currency.FormatMoney(a));
			DoesWrap = true
		})
		G = Z:AddInput("auto_expand_pet_inventory_max_upgrade_ui", {
			Text = i(e.auto_expand_pet_inventory_max_upgrade);
			Default = tostring(e.auto_expand_pet_inventory_max_upgrade),
			Numeric = true,
			AllowEmpty = false;
			Finished = true;
			ClearTextOnFocus = false;
			Placeholder = "1 to 3";
			Tooltip = "Press Enter to set how many pet slot upgrades to buy.";
			Callback = function(G)
				if y then
					return
				end
				local V = u.GardenItems.PetMaxInventorySystem.GetMaximumUpgradePetMaxInventorySystem()
				local Z = L(G)
				if not Z or Z < 1 or Z > V then
					T.Notify("Pet upgrades must be between 1 and " .. tostring(V), 3)
					c(e.auto_expand_pet_inventory_max_upgrade)
					return
				end
				e.auto_expand_pet_inventory_max_upgrade = Z
				c(Z)
				q.Save.SaveData()
			end
		})
		Z:AddToggle("auto_expand_pet_inventory_enabled_ui", {
			Text = "\240\159\144\190 Enable Auto Pet Slots",
			Default = e.auto_expand_pet_inventory,
			Tooltip = "Automatically buys pet slot upgrades when affordable.";
			Callback = function(G)
				e.auto_expand_pet_inventory = G == true
				if not G then
					T.PetMaxInventoryStatusText = ""
				end
				q.Save.SaveData()
			end
		})
		Z:AddToggle("pet_inventory_min_sheckles_enabled_ui", {
			Text = "\240\159\146\176 Enable Sheckles Reserve",
			Default = e.pet_inventory_min_sheckles_enabled == true,
			Tooltip = "Keeps this much money saved before buying pet slots.";
			Callback = function(G)
				e.pet_inventory_min_sheckles_enabled = G == true
				q.Save.SaveData()
			end
		})
		V = Z:AddInput("pet_inventory_min_sheckles_ui", {
			Text = J(e.pet_inventory_min_sheckles);
			Default = d.Currency.FormatMoney(e.pet_inventory_min_sheckles);
			Numeric = false,
			AllowEmpty = true;
			Finished = true,
			ClearTextOnFocus = false,
			Placeholder = "0 or 2m",
			Tooltip = "Press Enter to update. 0 disables the amount check.",
			Changed = function(G)
				if j then
					return
				end
				V:SetText(J(G))
			end;
			Callback = function(G)
				if j then
					return
				end
				local V = (tostring(G or "")):match("^%s*(.-)%s*$") or ""
				local y = V == "" and 0 or d.Currency.ParseMoney(V)
				if not y or y < 0 then
					T.Notify("Invalid sheckles amount", 3)
					g(e.pet_inventory_min_sheckles)
					return
				end
				e.pet_inventory_min_sheckles = math.floor(y)
				g(e.pet_inventory_min_sheckles)
				q.Save.SaveData()
			end
		})
	end
	if y then
		local G
		G = y:AddInput("auto_expand_garden_max_slot_ui", {
			Text = "\240\159\143\161 Maximum Slot";
			Default = tostring(e.auto_expand_garden_max_slot),
			Numeric = true;
			AllowEmpty = false,
			Finished = true;
			ClearTextOnFocus = false,
			Placeholder = "Maximum expansion slot",
			Tooltip = "Stops purchasing when the selected garden slot is reached.";
			Callback = function(V)
				local y = L(V)
				local Z = u.GardenItems.ExpandSystem.GetMaximumSlot()
				if not y or y < 1 or y > Z then
					T.Notify("Garden slot must be between 1 and " .. Z, 3)
					G:SetValue(tostring(e.auto_expand_garden_max_slot))
					return
				end
				e.auto_expand_garden_max_slot = y
				q.Save.SaveDataSync()
			end
		})
		y:AddToggle("auto_expand_garden_enabled_ui", {
			Text = "\240\159\143\161 Enable Auto Expand",
			Default = e.auto_expand_garden,
			Tooltip = "Automatically purchases affordable garden expansions.";
			Callback = function(G)
				e.auto_expand_garden = G
				if not G then
					T.GardenExpandStatusText = ""
				end
				q.Save.SaveDataSync()
			end
		})
	end
	if V then
		V:AddToggle("garden_items_use_player_walk_ui", {
			Text = "\240\159\154\182 Use Player Walk",
			Default = e.garden_items_use_player_walk;
			Tooltip = "Walks to seeds first, then snaps when close.",
			Callback = function(G)
				e.garden_items_use_player_walk = G
				q.Save.SaveDataSync()
			end
		})
		V:AddToggle("auto_collect_drop_seeds", {
			Text = "\240\159\140\177 Auto Collect Dropped Seeds",
			Default = e.auto_collect_drop_seeds;
			Tooltip = "Collects seeds dropped by your pets or player.",
			Callback = function(G)
				e.auto_collect_drop_seeds = G
				q.Save.SaveDataSync()
			end
		})
		V:AddToggle("garden_items_auto_collect_event_seeds", {
			Text = "\240\159\140\136 Auto Collect Gold & Rainbow Seeds";
			Default = e.auto_collect_event_seeds;
			Tooltip = "Collects Gold and Rainbow seeds dropped by the event.",
			Callback = function(G)
				e.auto_collect_event_seeds = G
				q.Save.SaveDataSync()
			end
		})
	end
end
T.PlantsUi = function()
	local G = i:AddTab({
		Name = "Plants";
		Description = "Plant automation";
		Icon = "sprout"
	})
	local V = G:AddLeftGroupbox("Shovel Fruits", "shovel")
	local y = G:AddRightGroupbox("<font color=\'#FF5555\'>\226\154\160\239\184\143 Shovel Plants</font>", "triangle-alert")
	local Z = G:AddLeftGroupbox("Move Plants", "move")
	local c = G:AddRightGroupbox("Water Plants", "droplets")
	local J = G:AddRightGroupbox("Plants/Fruit ESP", "eye")
	local g = G:AddLeftGroupbox("Backpack ESP", "badge-dollar-sign")
	local E = G:AddLeftGroupbox("Auto Fruit Favourites", "star")
	local a = G:AddLeftGroupbox("Manual Fruit Favourites", "mouse-pointer-click")
	if g then
		g:AddToggle("backpack_fruit_price_esp_enabled_ui", {
			Text = "\240\159\146\176 Fruit Slot Prices",
			Default = e.backpack_fruit_price_esp_enabled,
			Tooltip = "Shows the live fruit price at the top of each fruit slot.",
			Callback = function(G)
				e.backpack_fruit_price_esp_enabled = G == true
				if e.backpack_fruit_price_esp_enabled then
					u.BackpackFruitPriceEsp.StartBackpackFruitPriceEsp()
				else
					u.BackpackFruitPriceEsp.ClearLabelsBackpackFruitPriceEsp()
				end
				q.Save.SaveData()
			end
		})
		g:AddToggle("backpack_fruit_total_value_esp_enabled_ui", {
			Text = "\240\159\146\142 Inventory Total Value";
			Default = e.backpack_fruit_total_value_esp_enabled,
			Tooltip = "Shows total estimated value of all fruits in your inventory.",
			Callback = function(G)
				e.backpack_fruit_total_value_esp_enabled = G == true
				if e.backpack_fruit_total_value_esp_enabled then
					u.BackpackFruitPriceEsp.StartBackpackFruitPriceEsp()
					u.BackpackFruitPriceEsp.RefreshTotalValueBackpackFruitPriceEsp()
				else
					u.BackpackFruitPriceEsp.ClearTotalLabelBackpackFruitPriceEsp()
				end
				q.Save.SaveData()
			end
		})
		g:AddButton({
			Text = "\240\159\148\132 Refresh Prices";
			Func = function()
				if u.BuySelectFruit and type(u.BuySelectFruit.EnsureFruitStockReadyBuySelectFruit) == "function" then
					u.BuySelectFruit.EnsureFruitStockReadyBuySelectFruit(true)
				end
				u.BackpackFruitPriceEsp.RefreshBackpackFruitPriceEsp()
				u.BackpackFruitPriceEsp.RefreshTotalValueBackpackFruitPriceEsp()
			end
		})
	end
	local H
	H = function(G, V, y)
		if not G or type(y) ~= "table" then
			return nil
		end
		local Z
		Z = G:AddValueDropdown(V .. "_names_ui", {
			Values = {},
			Default = {};
			Multi = true;
			Searchable = true;
			MaxVisibleDropdownItems = 10,
			Text = "\240\159\141\137 Fruits";
			Tooltip = "No selection matches every fruit.",
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e[y.names] = G
				q.Save.SaveData()
			end
		})
		Z:SetValues(u.SeedData.GetSeedDataListDropDown())
		Z:SetValue(e[y.names])
		local j = G:AddButton({
			Text = "\226\156\133 All";
			Func = function()
				e[y.names] = {}
				for G, V in ipairs(T.AllSeedsDataTable or {}) do
					if type(V) == "table" and type(V.name) == "string" then
						e[y.names][V.name] = true
					end
				end
				Z:SetValue(e[y.names])
				q.Save.SaveData()
			end
		})
		j:AddButton({
			Text = "\240\159\167\185 Clear";
			Func = function()
				e[y.names] = {}
				Z:SetValue({})
				q.Save.SaveData()
			end
		})
		local i
		i = G:AddInput(V .. "_min_kg_ui", {
			Text = "\226\154\150\239\184\143 Min KG";
			Default = tostring(e[y.minKg]),
			Numeric = true,
			AllowEmpty = true;
			Finished = true,
			ClearTextOnFocus = false,
			Placeholder = "0";
			Tooltip = "Only fruits at or above this KG.",
			Callback = function(G)
				local V = m(G)
				if not V or V < 0 then
					T.Notify("Min KG must be 0 or above", 3)
					i:SetValue(tostring(e[y.minKg]))
					return
				end
				e[y.minKg] = u.FruitFilters.RoundWeight(V)
				q.Save.SaveData()
			end
		})
		local c
		c = G:AddInput(V .. "_max_kg_ui", {
			Text = "\226\154\150\239\184\143 Max KG",
			Default = tostring(e[y.maxKg]),
			Numeric = true;
			AllowEmpty = true;
			Finished = true,
			ClearTextOnFocus = false;
			Placeholder = "100000000";
			Tooltip = "Only fruits at or below this KG.",
			Callback = function(G)
				local V = m(G)
				if not V or V < 0 then
					T.Notify("Max KG must be 0 or above", 3)
					c:SetValue(tostring(e[y.maxKg]))
					return
				end
				e[y.maxKg] = u.FruitFilters.RoundWeight(V)
				q.Save.SaveData()
			end
		})
		local J
		J = G:AddValueDropdown(V .. "_mutations_ui", {
			Values = u.FruitFilters.GetMutationNames();
			Default = {},
			Multi = true;
			Searchable = true;
			MaxVisibleDropdownItems = 10;
			Text = "\240\159\167\172 Mutations";
			Tooltip = "No selection matches every mutation.";
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e[y.mutations] = G
				q.Save.SaveData()
			end
		})
		J:SetValue(e[y.mutations])
		local g
		g = G:AddValueDropdown(V .. "_variants_ui", {
			Values = u.FruitFilters.GetVariantNames();
			Default = {},
			Multi = true;
			Searchable = false,
			MaxVisibleDropdownItems = 5,
			Text = "\240\159\140\136 Variants",
			Tooltip = "No selection matches every variant.",
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e[y.variants] = G
				q.Save.SaveData()
			end
		})
		g:SetValue(e[y.variants])
		local E
		E = G:AddInput(V .. "_max_value_ui", {
			Text = "\240\159\146\176 Max Value",
			Default = tostring(e[y.maxValue]);
			Numeric = false,
			AllowEmpty = true;
			Finished = true,
			ClearTextOnFocus = false,
			Placeholder = "0 = ignore";
			Tooltip = "Only fruits at or below this value. Use 0 to ignore.";
			Callback = function(G)
				local V = d.Currency.ParseMoney(tostring(G or "0"))
				if V < 0 then
					T.Notify("Max value must be 0 or more", 3)
					E:SetValue(tostring(e[y.maxValue]))
					return
				end
				e[y.maxValue] = math.floor(V)
				E:SetText("\240\159\146\176 Max Value: " .. ((V > 0 and "$" .. u.BackpackFruitPriceEsp.FormatPriceBackpackFruitPriceEsp(V) or "Ignored")))
				q.Save.SaveData()
			end
		})
		E:SetText("\240\159\146\176 Max Value: " .. ((((tonumber(e[y.maxValue]) or 0)) > 0 and "$" .. u.BackpackFruitPriceEsp.FormatPriceBackpackFruitPriceEsp(e[y.maxValue]) or "Ignored")))
		return true
	end
	if E then
		E:AddLabel({
			Text = "Automatically favourites fruits matching the auto filters before seller runs.";
			DoesWrap = true
		})
		H(E, "auto_fruit_favourite", {
			names = "auto_fruit_favourite_names",
			minKg = "auto_fruit_favourite_min_kg",
			maxKg = "auto_fruit_favourite_max_kg";
			mutations = "auto_fruit_favourite_mutations",
			variants = "auto_fruit_favourite_variants";
			maxValue = "auto_fruit_favourite_max_value"
		})
		E:AddDivider()
		E:AddToggle("auto_fruit_favourite_enabled_ui", {
			Text = "\226\173\144 Auto Favourite",
			Default = e.auto_fruit_favourite_enabled;
			Tooltip = "Favourites fruits that match the auto filters.";
			Callback = function(G)
				e.auto_fruit_favourite_enabled = G == true
				if not G then
					u.FruitFavouriteManager.SetStatusAutoFruitFavouriteManager("")
				end
				q.Save.SaveData()
			end
		})
		E:AddButton({
			Text = "\226\154\161 Run Auto Favourite Now",
			Func = function()
				u.FruitFavouriteManager.RunAutoFavouriteFruitFavouriteManager()
			end
		})
	end
	if a then
		a:AddLabel({
			Text = "Manual favourite tools use their own filters and run only when you press a button.",
			DoesWrap = true
		})
		H(a, "manual_fruit_favourite", {
			names = "manual_fruit_favourite_names",
			minKg = "manual_fruit_favourite_min_kg",
			maxKg = "manual_fruit_favourite_max_kg";
			mutations = "manual_fruit_favourite_mutations",
			variants = "manual_fruit_favourite_variants";
			maxValue = "manual_fruit_favourite_max_value"
		})
		a:AddDivider()
		a:AddButton({
			Text = "\226\173\144 Favourite Matching Now",
			Func = function()
				u.FruitFavouriteManager.RunManualFavouriteFruitFavouriteManager(true)
			end
		})
		a:AddButton({
			Text = "\226\157\140 Unfavourite Matching Now";
			Func = function()
				u.FruitFavouriteManager.RunManualFavouriteFruitFavouriteManager(false)
			end
		})
	end
	if J then
		T.PlantFruitEspUi.StatusLabel = J:AddLabel({
			Text = T.PlantFruitEspStatusText ~= "" and T.PlantFruitEspStatusText or "<font color=\'#888888\'>ESP idle</font>";
			DoesWrap = true
		})
		J:AddLabel({
			Text = "Small ESP labels for fruits and plants. Fruit labels use kg range; plant labels show length.",
			DoesWrap = true
		})
		local G
		G = J:AddValueDropdown("plant_fruit_esp_names_ui", {
			Values = {},
			Default = {},
			Multi = true,
			Searchable = true,
			MaxVisibleDropdownItems = 10,
			Text = "\240\159\140\177 Plant / Fruit Names",
			Tooltip = "No selection shows every plant and fruit.";
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.plant_fruit_esp_names = G
				q.Save.SaveData()
			end
		})
		G:SetValues(u.SeedData.GetSeedDataListDropDown())
		G:SetValue(e.plant_fruit_esp_names)
		local V = J:AddButton({
			Text = "\226\156\133 All",
			Func = function()
				e.plant_fruit_esp_names = u.PlantFruitEsp.GetAllNameSelectionPlantFruitEsp()
				G:SetValue(e.plant_fruit_esp_names)
				q.Save.SaveData()
			end
		})
		V:AddButton({
			Text = "\240\159\167\185 Clear",
			Func = function()
				e.plant_fruit_esp_names = {}
				G:SetValue({})
				q.Save.SaveData()
			end
		})
		J:AddButton({
			Text = "\240\159\148\132 Reload Names",
			Func = function()
				G:SetValues(u.SeedData.GetSeedDataListDropDown())
				G:SetValue(e.plant_fruit_esp_names)
				T.Notify("ESP names refreshed", 2)
			end
		})
		J:AddDivider()
		local y
		y = J:AddInput("plant_fruit_esp_min_kg_ui", {
			Text = "\226\172\135\239\184\143 Minimum KG";
			Default = tostring(e.plant_fruit_esp_min_kg);
			Numeric = true,
			AllowEmpty = true;
			Finished = true;
			ClearTextOnFocus = false;
			Placeholder = "0";
			Callback = function(G)
				local V = m(G)
				if not V or V < 0 then
					T.Notify("Minimum KG must be 0 or more", 3)
					y:SetValue(tostring(e.plant_fruit_esp_min_kg))
					return
				end
				if V > ((tonumber(e.plant_fruit_esp_max_kg) or 1000000000)) then
					T.Notify("Minimum KG must be lower than maximum KG", 3)
					y:SetValue(tostring(e.plant_fruit_esp_min_kg))
					return
				end
				e.plant_fruit_esp_min_kg = V
				q.Save.SaveData()
			end
		})
		local Z
		Z = J:AddInput("plant_fruit_esp_max_kg_ui", {
			Text = "\226\172\134\239\184\143 Maximum KG";
			Default = tostring(e.plant_fruit_esp_max_kg),
			Numeric = true;
			AllowEmpty = true,
			Finished = true,
			ClearTextOnFocus = false;
			Placeholder = "999999",
			Callback = function(G)
				local V = m(G)
				if not V or V < 0 then
					T.Notify("Maximum KG must be 0 or more", 3)
					Z:SetValue(tostring(e.plant_fruit_esp_max_kg))
					return
				end
				if V < ((tonumber(e.plant_fruit_esp_min_kg) or 0)) then
					T.Notify("Maximum KG must be higher than minimum KG", 3)
					Z:SetValue(tostring(e.plant_fruit_esp_max_kg))
					return
				end
				e.plant_fruit_esp_max_kg = V
				q.Save.SaveData()
			end
		})
		local j
		j = J:AddInput("plant_fruit_esp_max_distance_ui", {
			Text = "\240\159\147\143 Max Distance";
			Default = tostring(e.plant_fruit_esp_max_distance);
			Numeric = true,
			AllowEmpty = true,
			Finished = true,
			ClearTextOnFocus = false,
			Placeholder = "250";
			Callback = function(G)
				local V = L(G)
				if not V or V < 25 then
					T.Notify("Max distance must be 25 or more", 3)
					j:SetValue(tostring(e.plant_fruit_esp_max_distance))
					return
				end
				e.plant_fruit_esp_max_distance = V
				q.Save.SaveData()
			end
		})
		J:AddDivider()
		J:AddToggle("plant_fruit_esp_fruit_enabled_ui", {
			Text = "\240\159\141\137 Fruit KG ESP";
			Default = e.plant_fruit_esp_fruit_enabled;
			Tooltip = "Shows small kg labels on fruits that match the filters.";
			Callback = function(G)
				e.plant_fruit_esp_fruit_enabled = G == true
				q.Save.SaveData()
			end
		})
		J:AddToggle("plant_fruit_esp_plant_enabled_ui", {
			Text = "\240\159\140\177 Plant Length ESP";
			Default = e.plant_fruit_esp_plant_enabled;
			Tooltip = "Shows small length labels on plants that match the selected names.",
			Callback = function(G)
				e.plant_fruit_esp_plant_enabled = G == true
				q.Save.SaveData()
			end
		})
	end
	if c then
		local G
		G = c:AddValueDropdown("water_plant_selected_cans_ui", {
			Values = {};
			Default = {},
			Multi = true;
			Searchable = true;
			MaxVisibleDropdownItems = 6;
			Text = "\240\159\146\167 Watering Cans",
			Tooltip = "Select watering cans to use. No selection uses any available can.";
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.water_plant_selected_cans = G
				q.Save.SaveDataSync()
			end
		})
		G:SetValues(u.WaterPlants.GetCanDropdown())
		G:SetValue(e.water_plant_selected_cans)
		local V
		V = c:AddDropdown("water_plant_mode_ui", {
			Values = {
				"Growing Plant",
				"Farm Middle";
				"Plant Target",
				"Custom Position"
			},
			Default = e.water_plant_mode,
			Multi = false,
			Text = "\240\159\147\141 Water Target",
			Tooltip = "Choose where the watering can should be used.",
			Callback = function(G)
				if type(G) ~= "string" or G == "" then
					return
				end
				e.water_plant_mode = G
				q.Save.SaveDataSync()
			end
		})
		V:SetValue(e.water_plant_mode)
		local y
		y = c:AddValueDropdown("water_plant_target_plant_ui", {
			Values = {},
			Default = "",
			Multi = false;
			Searchable = true,
			MaxVisibleDropdownItems = 10,
			Text = "\240\159\140\177 Target Plant";
			Tooltip = "Plant Target mode waters any plant of this type.",
			Changed = function(G)
				if type(G) ~= "string" then
					return
				end
				e.water_plant_target_plant = G
				q.Save.SaveDataSync()
			end
		})
		y:SetValues(u.SeedData.GetSeedDataListDropDown())
		y:SetValue(e.water_plant_target_plant)
		local Z = c:AddLabel({
			Text = u.WaterPlants.GetSavedPositionText(),
			DoesWrap = true
		})
		c:AddButton({
			Text = "\240\159\147\140 Copy Current Position",
			Tooltip = "Stand inside your farm where the watering can should be used.",
			Func = function()
				local G, y = u.WaterPlants.SaveCurrentPosition()
				T.Notify(y, 3)
				if G then
					e.water_plant_mode = "Custom Position"
					V:SetValue("Custom Position")
					Z:SetText(u.WaterPlants.GetSavedPositionText())
					q.Save.SaveDataSync()
				end
			end
		})
		c:AddDivider()
		local j
		j = c:AddValueDropdown("water_plant_weather_selected_ui", {
			Values = u.WeatherTriggers.GetDropdownWeatherTriggers();
			Default = {},
			Multi = true,
			Searchable = true,
			MaxVisibleDropdownItems = 8;
			Text = "\240\159\140\166\239\184\143 Weather Trigger",
			Tooltip = "No selection allows any weather.",
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.water_plant_weather_selected = G
				q.Save.SaveData()
			end
		})
		j:SetValue(e.water_plant_weather_selected)
		c:AddToggle("water_plant_weather_enabled_ui", {
			Text = "\240\159\140\166\239\184\143 Use Weather Trigger";
			Default = e.water_plant_weather_enabled;
			Tooltip = "Only waters plants during selected weather or time cycle.";
			Callback = function(G)
				e.water_plant_weather_enabled = G == true
				q.Save.SaveData()
			end
		})
		c:AddDivider()
		c:AddToggle("water_plant_wait_effect_ui", {
			Text = "\226\143\179 Wait for Effect";
			Default = e.water_plant_wait_effect,
			Tooltip = "Waits for the watering effect to finish. Disable to stack watering effects.";
			Callback = function(G)
				e.water_plant_wait_effect = G
				if not G then
					u.WaterPlants.NextUseAt = 0
				end
				q.Save.SaveDataSync()
			end
		})
		c:AddToggle("auto_water_plants_ui", {
			Text = "\240\159\146\167 Enable Water Plants",
			Default = e.auto_water_plants,
			Tooltip = "Automatically uses watering cans at the selected target.";
			Callback = function(G)
				e.auto_water_plants = G
				if not G then
					u.WaterPlants.CleanupTool()
					u.WaterPlants.ClearStatus()
				end
				q.Save.SaveDataSync()
			end
		})
	end
	if Z then
		Z:AddLabel({
			Text = "\240\159\147\141 Moves selected plants to one position. No selection means all plants.",
			DoesWrap = true
		})
		local G
		G = Z:AddValueDropdown("trowel_plant_types_ui", {
			Values = {};
			Default = {};
			Multi = true;
			Searchable = true;
			MaxVisibleDropdownItems = 10,
			Text = "\240\159\140\177 Plant Types";
			Tooltip = "Selected plants will be moved. No selection moves all plants.";
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.trowel_plant_types = G
				q.Save.SaveDataSync()
			end
		})
		G:SetValues(u.SeedData.GetSeedDataListDropDown())
		G:SetValue(e.trowel_plant_types)
		local V = Z:AddButton({
			Text = "\226\156\133 All";
			Func = function()
				e.trowel_plant_types = u.Trowel.GetAllSelection()
				G:SetValue(e.trowel_plant_types)
				q.Save.SaveDataSync()
			end
		})
		V:AddButton({
			Text = "\240\159\167\185 Clear",
			Func = function()
				e.trowel_plant_types = {}
				G:SetValue({})
				q.Save.SaveDataSync()
			end
		})
		Z:AddDivider()
		Z:AddToggle("trowel_use_fixed_spot_ui", {
			Text = "\240\159\147\140 Use Farm Middle",
			Default = e.trowel_use_fixed_spot,
			Tooltip = "Moves plants to the permanent middle point of your farm.";
			Callback = function(G)
				e.trowel_use_fixed_spot = G
				q.Save.SaveDataSync()
			end
		})
		local y = Z:AddLabel({
			Text = u.Trowel.GetSavedPositionText();
			DoesWrap = true
		})
		Z:AddButton({
			Text = "\240\159\147\141 Copy Current Position";
			Tooltip = "Stand inside either plant area before saving.";
			Func = function()
				local G, V = u.Trowel.SavePlayerPosition()
				if G then
					y:SetText(u.Trowel.GetSavedPositionText())
					T.Notify("Position saved: " .. tostring(V), 3)
				else
					T.Notify(V, 3)
				end
			end
		})
		Z:AddDivider()
		local j = Z:AddButton({
			Text = "\226\150\182\239\184\143 Start Trowel",
			Func = function()
				u.Trowel.Start()
			end
		})
		j:AddButton({
			Text = "\226\143\185\239\184\143 Stop Trowel";
			Func = function()
				u.Trowel.Stop()
			end
		})
	end
	if y then
		y:AddLabel({
			Text = "\240\159\154\168 <font color=\'#FF5555\'><b>DANGER:</b></font> This removes the entire plant and every fruit attached to it. <font color=\'#FF5555\'><b>This cannot be undone.</b></font>",
			DoesWrap = true
		})
		y:AddLabel({
			Text = "Single-harvest plants are excluded. The keep amount applies separately to every selected plant type.",
			DoesWrap = true
		})
		y:AddDivider()
		local G
		G = y:AddValueDropdown("shovel_plant_types_ui", {
			Values = {},
			Default = {};
			Multi = true,
			Searchable = true,
			MaxVisibleDropdownItems = 10;
			Text = "\240\159\140\177 Plant Type";
			Tooltip = "Select plant types that may be permanently removed.",
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.shovel_plant_types = G
				q.Save.SaveDataSync()
			end
		})
		G:SetValues(u.PlantShovel.GetPlantTypeDropdown())
		G:SetValue(e.shovel_plant_types)
		local V = y:AddButton({
			Text = "\226\156\133 <font color=\'#7CFF8A\'><b>All</b></font>",
			Func = function()
				local V = u.PlantShovel.GetAllPlantTypeSelection()
				e.shovel_plant_types = V
				G:SetValue(V)
				q.Save.SaveDataSync()
			end
		})
		V:AddButton({
			Text = "\240\159\167\185 <font color=\'#FFB86B\'><b>Clear</b></font>",
			Func = function()
				e.shovel_plant_types = {}
				G:SetValue({})
				q.Save.SaveDataSync()
			end
		})
		y:AddButton({
			Text = "\240\159\148\132 Reload Plant Counts";
			Tooltip = "Refreshes the current plant amounts shown in the dropdown.",
			Func = function()
				G:SetValues(u.PlantShovel.GetPlantTypeDropdown())
				G:SetValue(e.shovel_plant_types)
				T.Notify("Plant counts refreshed", 2)
			end
		})
		y:AddDivider()
		local Z
		local i = "\226\172\135\239\184\143 <font color=\'#7CFC00\'>Minimum</font> Height"
		Z = y:AddInput("shovel_plant_min_height_ui", {
			Text = i;
			Default = tostring(e.shovel_plant_min_height);
			Numeric = true;
			AllowEmpty = true,
			Finished = true;
			ClearTextOnFocus = false;
			Placeholder = "Minimum Height",
			Callback = function(G)
				local V = m(G)
				if not V or V < 0 then
					T.Notify("Minimum height must be 0 or more", 3)
					Z:SetValue(tostring(e.shovel_plant_min_height))
					return
				end
				local y = tonumber(e.shovel_plant_max_height) or 200
				if V > y then
					T.Notify("Minimum height must be lower than maximum", 3)
					Z:SetValue(tostring(e.shovel_plant_min_height))
					return
				end
				e.shovel_plant_min_height = V
				q.Save.SaveDataSync()
				Z:SetText("\226\156\133 <font color=\'#00FF00\'>Minimum Height Updated</font>")
				task.delay(1.5, function()
					if Z then
						Z:SetText(i)
					end
				end)
			end
		})
		local c
		local J = "\226\172\134\239\184\143 <font color=\'#FF6B6B\'>Maximum</font> Height"
		c = y:AddInput("shovel_plant_max_height_ui", {
			Text = J,
			Default = tostring(e.shovel_plant_max_height),
			Numeric = true,
			AllowEmpty = true,
			Finished = true,
			ClearTextOnFocus = false;
			Placeholder = "Maximum Height";
			Callback = function(G)
				local V = m(G)
				if not V or V < 0 then
					T.Notify("Maximum height must be 0 or more", 3)
					c:SetValue(tostring(e.shovel_plant_max_height))
					return
				end
				local y = tonumber(e.shovel_plant_min_height) or 0
				if V < y then
					T.Notify("Maximum height must be higher than minimum", 3)
					c:SetValue(tostring(e.shovel_plant_max_height))
					return
				end
				e.shovel_plant_max_height = V
				q.Save.SaveDataSync()
				c:SetText("\226\156\133 <font color=\'#00FF00\'>Maximum Height Updated</font>")
				task.delay(1.5, function()
					if c then
						c:SetText(J)
					end
				end)
			end
		})
		y:AddDivider()
		local d
		d = y:AddValueDropdown("shovel_plant_variants_ui", {
			Values = {};
			Default = {},
			Multi = true;
			Searchable = true;
			MaxVisibleDropdownItems = 10,
			Text = "\226\156\168 Variant";
			Tooltip = "No selection means all variants, including plants without a mutation.";
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.shovel_plant_variants = G
				q.Save.SaveDataSync()
			end
		})
		d:SetValues(u.Mutations.GetNames())
		d:SetValue(e.shovel_plant_variants)
		local g
		g = y:AddValueDropdown("shovel_plant_variant_blacklist_ui", {
			Values = u.Mutations.GetNames(),
			Default = {};
			Multi = true,
			Searchable = true;
			MaxVisibleDropdownItems = 10,
			Text = "\240\159\155\161\239\184\143 Protect Plant Variants";
			Tooltip = "Plants containing selected variants will never be shoveled.",
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.shovel_plant_variant_blacklist = G
				q.Save.SaveDataSync()
			end
		})
		g:SetValue(e.shovel_plant_variant_blacklist)
		y:AddToggle("shovel_growing_plants_ui", {
			Text = "<font color=\'#FFAA55\'>\240\159\140\177 Shovel Growing Plants</font>";
			Default = e.shovel_growing_plants,
			Tooltip = "Also removes plants where Age is lower than MaxAge.",
			Callback = function(G)
				e.shovel_growing_plants = G
				q.Save.SaveDataSync()
			end
		})
		y:AddDivider()
		local E
		local a = "\240\159\155\161\239\184\143 Max <font color=\'#7CFC00\'>Plants To Keep</font>"
		E = y:AddInput("shovel_plants_keep_ui", {
			Text = a;
			Default = tostring(e.shovel_plants_keep);
			Numeric = true,
			AllowEmpty = true,
			Finished = true,
			ClearTextOnFocus = false,
			Placeholder = "Plants to keep per type";
			Tooltip = "Enter 0 to remove all eligible plants. The keep amount applies separately to each selected plant type.",
			Callback = function(G)
				local V = L(G)
				if not V or V < 0 then
					T.Notify("Keep amount must be a whole number of 0 or more", 3)
					E:SetValue(tostring(e.shovel_plants_keep))
					return
				end
				e.shovel_plants_keep = V
				q.Save.SaveDataSync()
				E:SetText("\226\156\133 <font color=\'#00FF00\'>Keep Amount Updated</font>")
				task.delay(1.5, function()
					if E then
						E:SetText(a)
					end
				end)
			end
		})
		y:AddDivider()
		local H
		H = y:AddToggle("enable_plant_shovel_ui", {
			Text = "<font color=\'#FF3333\'><b>\226\154\160\239\184\143 Enable Plant Shovel</b></font>",
			Default = e.auto_shovel_plants,
			Tooltip = "Permanently removes entire plants matching the selected filters.",
			Callback = function(G)
				if G == e.auto_shovel_plants then
					return
				end
				if G and not e.auto_shovel_plants then
					j:Confirm({
						Title = "\226\154\160\239\184\143 Enable Plant Shovel?";
						Description = "This will permanently remove entire plants and every fruit attached to them.\n\nThis cannot be undone.\n\nCheck your selected plant types, height range, variants, growing option and keep amount before continuing.";
						Callback = function(G)
							if G then
								e.auto_shovel_plants = true
								u.PlantShovel.SetStatus("Starting...", "#FF7777")
								q.Save.SaveDataSync()
							else
								H:SetValue(e.auto_shovel_plants)
							end
						end
					})
					return
				end
				e.auto_shovel_plants = false
				u.PlantShovel.ClearStatus()
				q.Save.SaveDataSync()
			end
		})
	end
	if V then
		V:AddLabel({
			Text = "\226\154\160\239\184\143 Matching fruits are permanently removed. Single-harvest plants are excluded.";
			DoesWrap = true
		})
		local G
		G = V:AddValueDropdown("shovel_fruit_types", {
			Values = {},
			Default = {};
			Multi = true;
			Text = "\240\159\141\142 Fruit Type";
			Tooltip = "Only selected fruit types will be removed.",
			Searchable = true,
			MaxVisibleDropdownItems = 10;
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.shovel_fruit_types = G
				q.Save.SaveDataSync()
			end
		})
		G:SetValues(u.ShovelFruits.GetFruitTypeDropdown())
		G:SetValue(e.shovel_fruit_types)
		local y = V:AddButton({
			Text = "\226\156\133 <font color=\'#7CFF8A\'><b>All</b></font>";
			Func = function()
				local V = u.ShovelFruits.GetAllFruitTypeSelection()
				e.shovel_fruit_types = V
				G:SetValue(V)
				q.Save.SaveDataSync()
			end
		})
		y:AddButton({
			Text = "\240\159\167\185 <font color=\'#FFB86B\'><b>Clear</b></font>",
			Func = function()
				e.shovel_fruit_types = {}
				G:SetValue({})
				q.Save.SaveDataSync()
			end
		})
		V:AddDivider()
		local Z
		Z = V:AddValueDropdown("shovel_mutation_whitelist", {
			Values = u.ShovelFruits.GetMutationNames();
			Default = {};
			Multi = true,
			Text = "\226\156\133 Whitelist Mutations";
			Tooltip = "When used, only fruits containing at least one selected mutation will be removed.",
			Searchable = true;
			MaxVisibleDropdownItems = 10,
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.shovel_mutation_whitelist = G
				q.Save.SaveDataSync()
			end
		})
		Z:SetValue(e.shovel_mutation_whitelist)
		local j
		j = V:AddValueDropdown("shovel_mutation_blacklist", {
			Values = u.ShovelFruits.GetMutationNames();
			Default = {},
			Multi = true;
			Text = "\226\155\148 Blacklist Mutations";
			Tooltip = "Fruits containing any selected mutation will never be removed. Blacklist wins.",
			Searchable = true;
			MaxVisibleDropdownItems = 10;
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.shovel_mutation_blacklist = G
				q.Save.SaveDataSync()
			end
		})
		j:SetValue(e.shovel_mutation_blacklist)
		V:AddDivider()
		local i
		local c = "\226\172\135\239\184\143 <font color=\'#7CFC00\'>Minimum</font> Weight [KG]"
		i = V:AddInput("shovel_min_weight", {
			Text = c;
			Default = tostring(e.shovel_min_weight),
			Numeric = true;
			AllowEmpty = true;
			Finished = true;
			ClearTextOnFocus = false,
			Placeholder = "Minimum Weight";
			Callback = function(G)
				local V = m(G)
				if not V then
					T.Notify("Invalid number: " .. tostring(G), 3)
					i:SetValue(tostring(e.shovel_min_weight))
					return
				end
				if V < 0 then
					T.Notify("Enter a value of 0 or more", 3)
					i:SetValue(tostring(e.shovel_min_weight))
					return
				end
				local y = tonumber(e.shovel_max_weight) or 1000000000
				if V > y then
					T.Notify("Minimum must be lower than maximum", 3)
					i:SetValue(tostring(e.shovel_min_weight))
					return
				end
				e.shovel_min_weight = V
				q.Save.SaveDataSync()
				i:SetText("\226\156\133 <font color=\'#00FF00\'>Minimum Weight Updated</font>")
				task.delay(1.5, function()
					if i then
						i:SetText(c)
					end
				end)
			end
		})
		local J
		local d = "\226\172\134\239\184\143 <font color=\'#FF6B6B\'>Maximum</font> Weight [KG]"
		J = V:AddInput("shovel_max_weight", {
			Text = d;
			Default = tostring(e.shovel_max_weight),
			Numeric = true;
			AllowEmpty = true;
			Finished = true,
			ClearTextOnFocus = false,
			Placeholder = "Maximum Weight";
			Callback = function(G)
				local V = m(G)
				if not V then
					T.Notify("Invalid number: " .. tostring(G), 3)
					J:SetValue(tostring(e.shovel_max_weight))
					return
				end
				if V <= 0 then
					T.Notify("Enter a value greater than 0", 3)
					J:SetValue(tostring(e.shovel_max_weight))
					return
				end
				local y = tonumber(e.shovel_min_weight) or 0
				if V < y then
					T.Notify("Maximum must be higher than minimum", 3)
					J:SetValue(tostring(e.shovel_max_weight))
					return
				end
				e.shovel_max_weight = V
				q.Save.SaveDataSync()
				J:SetText("\226\156\133 <font color=\'#00FF00\'>Maximum Weight Updated</font>")
				task.delay(1.5, function()
					if J then
						J:SetText(d)
					end
				end)
			end
		})
		V:AddDivider()
		local g
		g = V:AddValueDropdown("shovel_variants", {
			Values = u.ShovelFruits.GetVariantNames();
			Default = {},
			Multi = true;
			Text = "\226\156\168 Variant";
			Tooltip = "Normal, Gold or Rainbow. No selection removes nothing.";
			Searchable = false;
			MaxVisibleDropdownItems = 5;
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.shovel_variants = G
				q.Save.SaveDataSync()
			end
		})
		g:SetValue(e.shovel_variants)
		V:AddDivider()
		V:AddToggle("enable_shovel_fruits", {
			Text = "<font color=\'#FF6B6B\'>Enable Shovel</font>";
			Default = e.auto_shovel_fruits;
			Tooltip = "Permanently removes fruits matching all configured filters.",
			Callback = function(G)
				e.auto_shovel_fruits = G == true
				if not G then
					u.ShovelFruits.CleanupTool()
				end
				q.Save.SaveData()
			end
		})
	end
end
T.AutoUi = function()
	local G = i:AddTab({
		Name = "Seed Placer";
		Description = "Places selected seeds",
		Icon = "sprout"
	})
	local V = G:AddLeftGroupbox("Seed Placement", "sprout")
	local y = G:AddRightGroupbox("Seed Target Overrides", "list-plus")
	if y then
		local G = ""
		local V = math.max(math.floor(tonumber(e.seed_place_default_target) or 10), 1)
		local Z = false
		local j = {}
		local i = 0
		local c
		local J
		y:AddLabel({
			Text = "\240\159\146\161 Set a different planting target for individual seeds.";
			DoesWrap = true
		})
		local function d()
			for G, V in ipairs(j) do
				if V.Holder and typeof(V.Holder) == "Instance" then
					V.Holder:Destroy()
				end
			end
			table.clear(j)
			if y.Resize then
				y:Resize()
			end
		end
		local function g()
			local V = u.Seeder.GetOverrideTarget(G)
			if V ~= nil then
				return V
			end
			return math.max(math.floor(tonumber(e.seed_place_default_target) or 10), 1)
		end
		local function E()
			if G == "" then
				return
			end
			V = g()
			Z = true
			if c then
				c:SetValue(tostring(V))
				c:SetText(string.format("\240\159\142\175 Target Amount: <font color=\'#7CFC00\'>%d</font>", V))
			end
			if J then
				J:SetValue(u.Seeder.GetOverrideTarget(G) ~= nil)
			end
			Z = false
		end
		local a
		a = function()
			d()
			i += 1
			local V = {}
			if type(e.seed_place_overrides) == "table" then
				for G in pairs(e.seed_place_overrides) do
					if u.Seeder.GetOverrideTarget(G) ~= nil then
						table.insert(V, G)
					end
				end
			end
			table.sort(V)
			if # V == 0 then
				local G = y:AddLabel({
					Text = "<font color=\'#888888\'>No active seed overrides</font>",
					DoesWrap = true
				})
				table.insert(j, G)
			else
				for V, Z in ipairs(V) do
					local c = u.Seeder.GetOverrideTarget(Z)
					local J
					J = y:AddToggle(string.format("seed_active_override_%d_%d", i, V), {
						Text = string.format("\240\159\140\177 %s <font color=\'#7CFC00\'>Target: %d</font>", Z, c);
						Default = true,
						Tooltip = "Disable this seed override.",
						Callback = function(V)
							if V then
								return
							end
							u.Seeder.RemoveOverrideTarget(Z)
							q.Save.SaveDataSync()
							if G == Z then
								E()
							end
							task.defer(a)
						end
					})
					table.insert(j, J)
				end
			end
			if y.Resize then
				y:Resize()
			end
		end
		local H
		H = y:AddValueDropdown("seed_placer_override_seed", {
			Values = {},
			Default = "",
			Multi = false,
			Searchable = true,
			MaxVisibleDropdownItems = 10,
			Text = "\240\159\140\177 Select Seed",
			Tooltip = "Select a seed to configure its target.";
			Changed = function(V)
				if type(V) ~= "string" or V == "" then
					return
				end
				G = V
				E()
			end
		})
		H:SetValues(u.SeedData.GetSeedDataListDropDown())
		c = y:AddInput("seed_placer_override_target", {
			Text = "\240\159\142\175 Target Amount";
			Default = tostring(V),
			Numeric = true,
			AllowEmpty = true;
			Finished = true,
			ClearTextOnFocus = false,
			Placeholder = "Enter target amount";
			Tooltip = "Sets how many of this seed should remain planted.";
			Callback = function(y)
				if Z then
					return
				end
				if G == "" then
					T.Notify("Select a seed first", 3)
					return
				end
				local j = L(y)
				if not j or j <= 0 then
					T.Notify("Target must be above 0", 3)
					E()
					return
				end
				V = j
				c:SetText(string.format("\240\159\142\175 Target Amount: <font color=\'#7CFC00\'>%d</font>", V))
				if u.Seeder.GetOverrideTarget(G) ~= nil then
					u.Seeder.SetOverrideTarget(G, V)
					q.Save.SaveDataSync()
					a()
				end
			end
		})
		J = y:AddToggle("seed_placer_enable_selected_override", {
			Text = "\240\159\146\165 Enable Override",
			Default = false,
			Tooltip = "Use the custom target for the selected seed.";
			Callback = function(y)
				if Z then
					return
				end
				if G == "" then
					Z = true
					J:SetValue(false)
					Z = false
					T.Notify("Select a seed first", 3)
					return
				end
				if y then
					if not u.Seeder.SetOverrideTarget(G, V) then
						Z = true
						J:SetValue(false)
						Z = false
						T.Notify("Failed to enable override", 3)
						return
					end
				else
					u.Seeder.RemoveOverrideTarget(G)
				end
				q.Save.SaveDataSync()
				E()
				a()
			end
		})
		y:AddDivider()
		y:AddLabel({
			Text = "= <font color=\'#7CFC00\'>Active Seed Overrides</font> =";
			DoesWrap = true
		})
		a()
	end
	if V then
		local G
		G = V:AddValueDropdown("seed_placer_selected_seeds", {
			Values = {},
			Default = {};
			Multi = true;
			Text = "\240\159\140\177 Seeds to Plant";
			Tooltip = "Only selected seeds will be planted.",
			Searchable = true,
			MaxVisibleDropdownItems = 10,
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.allowed_seedsplace = G
				q.Save.SaveDataSync()
			end
		})
		G:SetValues(u.SeedData.GetSeedDataListDropDown())
		G:SetValue(e.allowed_seedsplace)
		local y = V:AddButton({
			Text = "\226\156\133 All";
			Tooltip = "Selects every seed.",
			Func = function()
				e.allowed_seedsplace = u.Seeder.GetAllSeedSelection()
				G:SetValue(e.allowed_seedsplace)
				q.Save.SaveDataSync()
			end
		})
		y:AddButton({
			Text = "\240\159\167\185 Clear";
			Tooltip = "Clears the selected seeds.",
			Func = function()
				e.allowed_seedsplace = {}
				G:SetValue({})
				q.Save.SaveDataSync()
			end
		})
		V:AddDivider()
		local Z
		local j = "\240\159\142\175 Target Plants"
		Z = V:AddInput("seed_placer_default_target", {
			Text = j;
			Default = tostring(e.seed_place_default_target);
			Numeric = true;
			AllowEmpty = true;
			Finished = true,
			ClearTextOnFocus = false,
			Placeholder = "Plants per selected seed";
			Tooltip = "Plants each selected seed until this amount is on your farm.";
			Callback = function(G)
				local V = L(G)
				if not V or V <= 0 then
					T.Notify("Target must be a whole number above 0", 3)
					Z:SetValue(tostring(e.seed_place_default_target))
					return
				end
				e.seed_place_default_target = V
				q.Save.SaveDataSync()
				Z:SetText("\226\156\133 <font color=\'#00FF00\'>Target Updated</font>")
				task.delay(1.5, function()
					if Z then
						Z:SetText(j)
					end
				end)
			end
		})
		local i
		local c = "\240\159\140\179 Maximum Garden Plants"
		i = V:AddInput("seed_placer_max_garden_plants", {
			Text = c;
			Default = tostring(e.seed_place_max_garden_plants);
			Numeric = true,
			AllowEmpty = true,
			Finished = true;
			ClearTextOnFocus = false,
			Placeholder = "Maximum plants in garden",
			Tooltip = "Stops placing seeds when the garden reaches this amount.",
			Callback = function(G)
				local V = L(G)
				if not V or V < 0 then
					T.Notify("Maximum plants must be 0 or above", 3)
					i:SetValue(tostring(e.seed_place_max_garden_plants))
					return
				end
				e.seed_place_max_garden_plants = V
				q.Save.SaveDataSync()
				i:SetText("\226\156\133 <font color=\'#00FF00\'>Garden Limit Updated</font>")
				task.delay(1.5, function()
					if i then
						i:SetText(c)
					end
				end)
			end
		})
		local J
		local d = "\226\154\161 Delay Between Placements"
		J = V:AddInput("seed_placer_delay", {
			Text = d,
			Default = tostring(e.seed_place_delay),
			Numeric = true,
			AllowEmpty = true,
			Finished = true;
			ClearTextOnFocus = false;
			Placeholder = "Example: 0.3";
			Tooltip = "Lower values place seeds faster. Minimum 0.05 seconds.";
			Callback = function(G)
				local V = m(G)
				if not V or V < .05 then
					T.Notify("Delay must be 0.05 seconds or more", 3)
					J:SetValue(tostring(e.seed_place_delay))
					return
				end
				e.seed_place_delay = V
				q.Save.SaveDataSync()
				J:SetText("\226\156\133 <font color=\'#00FF00\'>Delay Updated</font>")
				task.delay(1.5, function()
					if J then
						J:SetText(d)
					end
				end)
			end
		})
		V:AddDivider()
		local g
		g = V:AddDropdown("seed_placer_mode", {
			Values = {
				"Random",
				"Farm Middle";
				"Saved Position"
			};
			Default = e.seed_place_mode,
			Multi = false;
			Text = "\240\159\147\141 Placement Mode";
			Tooltip = "Choose where selected seeds will be planted.";
			Callback = function(G)
				if type(G) ~= "string" or G == "" then
					return
				end
				e.seed_place_mode = G
				q.Save.SaveDataSync()
			end
		})
		g:SetValue(e.seed_place_mode)
		local E = V:AddLabel({
			Text = u.Seeder.GetSavedPositionText(),
			DoesWrap = true
		})
		V:AddButton({
			Text = "\240\159\147\140 Save Current Position",
			Tooltip = "Stand inside your farm where seeds should be planted.";
			Func = function()
				local G, V = u.Seeder.SaveCurrentPosition()
				T.Notify(V, 3)
				if G then
					e.seed_place_mode = "Saved Position"
					g:SetValue("Saved Position")
					if E then
						E:SetText(u.Seeder.GetSavedPositionText())
					end
					q.Save.SaveDataSync()
				end
			end
		})
		V:AddDivider()
		V:AddToggle("seed_placer_wall_mode", {
			Text = "\240\159\167\177 Wall Mode";
			Default = e.seed_place_wall_mode;
			Tooltip = "Random mode starts around the outside of both plant areas and fills inward.",
			Callback = function(G)
				e.seed_place_wall_mode = G
				q.Save.SaveDataSync()
			end
		})
		V:AddDivider()
		V:AddToggle("seed_placer_stack_mode", {
			Text = "\240\159\167\188 Layers Stack Mode";
			Default = e.seed_place_stack_mode;
			Tooltip = "Saved Position / Farm Middle modes places plants in closely stacked layers.",
			Callback = function(G)
				e.seed_place_stack_mode = G
				u.Seeder.StackIndex = 0
				q.Save.SaveDataSync()
			end
		})
		V:AddToggle("seed_placer_stack_modeunderground", {
			Text = "\240\159\145\189 Stack Underground";
			Default = e.seed_place_stack_mode_underground;
			Tooltip = "Saved Position / Farm Middle mode Will stack Underground";
			Callback = function(G)
				e.seed_place_stack_mode_underground = G
				u.Seeder.StackIndex = 0
				q.Save.SaveDataSync()
			end
		})
		V:AddDivider()
		V:AddToggle("enable_seed_placer", {
			Text = "\240\159\140\177 Enable Seed Placer",
			Default = e.auto_seedplace,
			Tooltip = "Continuously plants selected seeds up to their target amount.";
			Callback = function(G)
				e.auto_seedplace = G
				if not G then
					u.Seeder.ClearStatus()
				end
				q.Save.SaveDataSync()
			end
		})
	end
end
T.PetUi = function()
	local G = i:AddTab({
		Name = "Pet Snipe " .. T.GetProLabel();
		Description = "Buy pets on the farm.",
		Icon = "store"
	})
	local V = G:AddLeftGroupbox("Pet Finder Premium", "paw-print")
	local y = G:AddRightGroupbox("Pet Farm Return", "map-pinned")
	local Z = G:AddRightGroupbox("Pet Buy List", "list-plus")
	local j = G:AddLeftGroupbox("Last Purchases", "history")
	if Z then
		local G = ""
		local V = 1
		local y = {}
		local j = {}
		local i = false
		local c = {}
		local J = 0
		local d
		local g
		local E
		local a
		local H
		if not T.GetCheckIfPro() then
			Z:AddLabel({
				Text = T.GetProMessage();
				DoesWrap = true
			})
		end
		Z:AddLabel({
			Text = "\240\159\146\161 Empty size or variant selection means any.";
			DoesWrap = true
		})
		local function r()
			for G, V in ipairs(c) do
				if V.Holder and typeof(V.Holder) == "Instance" then
					V.Holder:Destroy()
				end
			end
			table.clear(c)
			if Z.Resize then
				Z:Resize()
			end
		end
		local function Y(G)
			if type(G) ~= "table" or next(G) == nil then
				return "Any"
			end
			local V = {}
			for G, y in pairs(G) do
				if y == true then
					table.insert(V, G)
				end
			end
			table.sort(V)
			return # V > 0 and table.concat(V, ", ") or "Any"
		end
		local function e()
			if i or G == "" or not u.PetFinderPremium.HasRule(G) then
				return
			end
			local Z = u.PetFinderPremium.GetRule(G)
			u.PetFinderPremium.SetRule(G, V, y, j, Z and Z.enabled)
			q.Save.SaveDataSync()
		end
		local function s()
			if G == "" then
				return
			end
			local Z = u.PetFinderPremium.GetRule(G)
			V = Z and Z.target or 1
			y = Z and Z.sizes or {}
			j = Z and Z.variants or {}
			i = true
			g:SetValues(u.PetFinderPremium.GetSizeValues())
			g:SetValue(y)
			E:SetValues(u.PetFinderPremium.GetVariantValues())
			E:SetValue(j)
			a:SetValue(tostring(V))
			a:SetText(string.format("\240\159\142\175 Target Amount: <font color=\'#7CFC00\'>%d</font>", V))
			H:SetValue(Z and Z.enabled or false)
			i = false
		end
		local N
		N = function()
			r()
			J += 1
			local V = u.PetFinderPremium.GetActiveRuleNames()
			if # V == 0 then
				local G = Z:AddLabel({
					Text = "<font color=\'#888888\'>No active pet buy rules</font>";
					DoesWrap = true
				})
				table.insert(c, G)
			else
				for V, y in ipairs(V) do
					local j = u.PetFinderPremium.GetRule(y)
					local i = j and u.PetFinderPremium.CountOwnedForRule(y, j) or 0
					local T
					T = Z:AddToggle(string.format("pet_finder_active_rule_%d_%d", J, V), {
						Text = string.format("\240\159\144\190 %s <font color=\'#7CFC00\'>%d/%d</font>\n<font color=\'#CFCFCF\'>Sizes: %s | Variants: %s</font>", u.PetFinderPremium.GetDisplayName(y), i, j.target, Y(j.sizes), Y(j.variants)),
						Default = true,
						Tooltip = "Disable this pet buy rule.",
						Callback = function(V)
							if V then
								return
							end
							u.PetFinderPremium.SetRuleEnabled(y, false)
							q.Save.SaveDataSync()
							if G == y then
								s()
							end
							task.defer(N)
						end
					})
					table.insert(c, T)
				end
			end
			if Z.Resize then
				Z:Resize()
			end
		end
		d = Z:AddValueDropdown("pet_finder_premium_pet_ui", {
			Values = {};
			Default = "",
			Multi = false;
			Searchable = true,
			MaxVisibleDropdownItems = 10,
			Text = "\240\159\144\190 Select Pet";
			Tooltip = "Select a pet to add or edit.";
			Changed = function(V)
				if type(V) ~= "string" or V == "" then
					return
				end
				G = V
				s()
			end
		})
		d:SetValues(u.PetFinderPremium.GetPetDropdown())
		g = Z:AddValueDropdown("pet_finder_premium_sizes_ui", {
			Values = {},
			Default = {};
			Multi = true;
			Searchable = true,
			MaxVisibleDropdownItems = 10,
			Text = "\240\159\147\143 Pet Sizes",
			Tooltip = "Leave empty to buy any size.";
			Changed = function(G)
				if i or type(G) ~= "table" then
					return
				end
				y = G
				e()
				N()
			end
		})
		g:SetValues(u.PetFinderPremium.GetSizeValues())
		E = Z:AddValueDropdown("pet_finder_premium_variants_ui", {
			Values = {};
			Default = {},
			Multi = true;
			Searchable = true;
			MaxVisibleDropdownItems = 10,
			Text = "\240\159\140\136 Pet Variants",
			Tooltip = "Leave empty to buy Normal or Rainbow pets.",
			Changed = function(G)
				if i or type(G) ~= "table" then
					return
				end
				j = G
				e()
				N()
			end
		})
		E:SetValues(u.PetFinderPremium.GetVariantValues())
		a = Z:AddInput("pet_finder_premium_target_ui", {
			Text = "\240\159\142\175 Target Amount",
			Default = "999";
			Numeric = true;
			AllowEmpty = true,
			Finished = true;
			ClearTextOnFocus = false,
			Placeholder = "Owned target amount";
			Tooltip = "Stops buying this pet when the matching inventory amount is reached.";
			Callback = function(y)
				if i then
					return
				end
				if G == "" then
					T.Notify("Select a pet first", 3)
					return
				end
				local Z = L(y)
				if not Z or Z <= 0 then
					T.Notify("Target must be above 0", 3)
					s()
					return
				end
				V = Z
				a:SetText(string.format("\240\159\142\175 Target Amount: <font color=\'#7CFC00\'>%d</font>", V))
				e()
				N()
			end
		})
		H = Z:AddToggle("pet_finder_premium_rule_enabled_ui", {
			Text = "\226\158\149 Enable Buy Rule",
			Default = false;
			Tooltip = "Adds the selected pet settings to the active buy list.";
			Callback = function(Z)
				if i then
					return
				end
				if G == "" then
					i = true
					H:SetValue(false)
					i = false
					T.Notify("Select a pet first", 3)
					return
				end
				if Z then
					if not u.PetFinderPremium.SetRule(G, V, y, j, true) then
						i = true
						H:SetValue(false)
						i = false
						T.Notify("Failed to enable pet rule", 3)
						return
					end
				else
					u.PetFinderPremium.SetRuleEnabled(G, false)
				end
				q.Save.SaveDataSync()
				s()
				N()
			end
		})
		Z:AddDivider()
		Z:AddLabel({
			Text = "= <font color=\'#7CFC00\'>Active Pet Buy List</font> =",
			DoesWrap = true
		})
		T.PetFinderPremiumUi.RefreshRules = N
		T.PetFinderPremiumUi.RefreshValues = function()
			i = true
			g:SetValues(u.PetFinderPremium.GetSizeValues())
			E:SetValues(u.PetFinderPremium.GetVariantValues())
			g:SetValue(y)
			E:SetValue(j)
			i = false
		end
		N()
	end
	if j then
		local G = {}
		local function V()
			for G, V in ipairs(G) do
				if V.Holder and typeof(V.Holder) == "Instance" then
					V.Holder:Destroy()
				end
			end
			table.clear(G)
			if j.Resize then
				j:Resize()
			end
		end
		local function y()
			V()
			local y = type(e.pet_finder_purchase_log) == "table" and e.pet_finder_purchase_log or {}
			if # y == 0 then
				local V = j:AddLabel({
					Text = "<font color=\'#888888\'>No pet purchases recorded</font>",
					DoesWrap = true
				})
				table.insert(G, V)
			else
				for V, y in ipairs(y) do
					local Z = tonumber(y.purchased_at) and os.date("%d/%m %H:%M", y.purchased_at) or "Unknown time"
					local i = j:AddLabel({
						Text = string.format("\240\159\144\190 %s %s %s | <font color=\'#7CFC00\'>%s</font> | %s", tostring(y.size or "Normal"), tostring(y.variant or "Normal"), tostring(y.display_name or y.pet or "Unknown"), J.formatShecklesNumber(y.price), Z),
						DoesWrap = true
					})
					table.insert(G, i)
				end
			end
			if j.Resize then
				j:Resize()
			end
		end
		j:AddButton({
			Text = "\240\159\167\185 Clear Purchase Log";
			Tooltip = "Clears the saved pet purchase history.";
			Func = function()
				e.pet_finder_purchase_log = {}
				q.Save.SaveDataSync()
				y()
			end
		})
		T.PetFinderPremiumUi.RefreshLog = y
		y()
	end
	if V then
		V:AddLabel({
			Text = "\240\159\144\190 Watches new wild pets and buys pets that match your enabled rules.",
			DoesWrap = true
		})
		local function G()
			return string.format("\226\143\177\239\184\143 Hop Timer <font color=\'#3CB371\'>(%dm)</font>", u.PetFinderPremium.GetHopMinutes())
		end
		local y
		y = V:AddInput("pet_finder_premium_hop_minutes_ui", {
			Text = G(),
			Default = tostring(e.pet_finder_hop_minutes);
			Numeric = true;
			AllowEmpty = true,
			Finished = true,
			ClearTextOnFocus = false;
			Placeholder = "Minimum 1 minute";
			Tooltip = "How long to watch the current server before hopping.";
			Callback = function(V)
				local Z = L(V)
				if not Z or Z < 1 then
					T.Notify("Hop timer must be 1 minute or more", 3)
					y:SetValue(tostring(e.pet_finder_hop_minutes))
					return
				end
				e.pet_finder_hop_minutes = Z
				y:SetText(G())
				u.PetFinderPremium.ResetHopTimer()
				q.Save.SaveDataSync()
			end
		})
		V:AddToggle("pet_finder_premium_auto_hop_ui", {
			Text = "\240\159\154\128 Auto Hop Server",
			Default = e.pet_finder_auto_hop;
			Tooltip = "Hops after the selected watch timer when no matching pet is ready.",
			Callback = function(G)
				e.pet_finder_auto_hop = G
				u.PetFinderPremium.ResetHopTimer()
				q.Save.SaveDataSync()
			end
		})
		local Z
		Z = V:AddToggle("pet_finder_premium_enabled_ui", {
			Text = "\240\159\144\190 Enable Pet Finder Premium";
			Default = e.pet_finder_enabled,
			Tooltip = "Automatically buys pets from your enabled buy list.",
			DisabledTooltip = T.GetProMessage();
			Callback = function(G)
				e.pet_finder_enabled = G
				if G then
					u.PetFinderPremium.ResetHopTimer()
					u.PetFinderPremium.FullScan()
				else
					u.PetFinderPremium.ClearStatus()
					u.Teleport.UnlockTeleport(T.TeleportLockNames.PetFinderPremium)
				end
				q.Save.SaveDataSync()
			end
		})
		Z:SetDisabled(not T.GetCheckIfPro())
	end
	if y then
		y:AddLabel({
			Text = "\240\159\144\190 Returns you to the farm centre when you are too far away.",
			DoesWrap = true
		})
		local function G()
			return string.format("\226\143\177\239\184\143 Return Timer <font color=\'#3CB371\'>(%ss)</font>", u.PetFarmReturn.GetTimer())
		end
		local V
		V = y:AddInput("pet_return_farm_timer_ui", {
			Text = G(),
			Default = tostring(e.pet_return_farm_timer);
			Numeric = true;
			AllowEmpty = true;
			Finished = true,
			ClearTextOnFocus = false,
			Placeholder = "Minimum 3 seconds",
			Tooltip = "How often to check if you are too far from the farm.",
			Callback = function(y)
				local Z = L(y)
				if not Z or Z < 3 then
					T.Notify("Timer must be 3 seconds or more", 3)
					V:SetValue(tostring(e.pet_return_farm_timer))
					return
				end
				e.pet_return_farm_timer = Z
				V:SetText(G())
				u.PetFarmReturn.ResetTimer()
				q.Save.SaveDataSync()
			end
		})
		y:AddToggle("pet_return_farm_enabled_ui", {
			Text = "\240\159\143\161 Enable Farm Return",
			Default = e.pet_return_farm,
			Tooltip = "Returns you to the farm centre when you are more than 20 studs away.";
			Callback = function(G)
				e.pet_return_farm = G
				if G then
					u.PetFarmReturn.ResetTimer()
				else
					T.PetFarmStatusText = ""
				end
				q.Save.SaveDataSync()
			end
		})
	end
end
T.CollectUi = function()
	local G = i:AddTab({
		Name = "Fruit Collect";
		Description = "Fruit Collection",
		Icon = "store"
	})
	local V = G:AddLeftGroupbox("Fruit Collector", "badge-dollar-sign")
	local y = G:AddLeftGroupbox("Buy Select Fruit", "mouse-pointer-click")
	local Z = G:AddRightGroupbox("Fruit Filters", "sliders-horizontal")
	if y then
		y:AddLabel({
			Text = "Select 1 or more garden fruits, then press Collect Selected. \226\156\133 means ready, \240\159\149\146 means still growing.",
			DoesWrap = true
		})
		local G
		G = y:AddValueDropdown("buy_select_garden_fruit_v1", {
			Values = {},
			Default = {};
			Multi = true,
			Text = "\240\159\141\142 Garden Fruits";
			Tooltip = "Choose exact garden fruits to collect.";
			Searchable = true;
			MaxVisibleDropdownItems = 10,
			Changed = function(G)
				T.BuySelectFruitSelected = G or {}
			end
		})
		T.BuySelectFruitUi.Dropdown = G
		y:AddButton({
			Text = "\226\153\187\239\184\143 Reload Garden Fruits";
			Tooltip = "Refreshes the garden fruit list.",
			Func = function()
				u.BuySelectFruit.RefreshDropdownBuySelectFruit(G, true)
			end
		})
		y:AddButton({
			Text = "\226\156\133 Collect Selected";
			Tooltip = "Collects selected fruits that are ready.",
			Func = function()
				task.spawn(function()
					local V, y = pcall(function()
						u.BuySelectFruit.CollectSelectedBuySelectFruit(T.BuySelectFruitSelected)
					end)
					if not V then
						u.BuySelectFruit.BusyBuySelectFruit = false
						u.BuySelectFruit.SetStatusBuySelectFruit("Collect failed", "#FF6666")
						warn("[BuySelectFruit]", y)
					end
					u.BuySelectFruit.RefreshDropdownBuySelectFruit(G, false, true)
				end)
			end
		})
		T.BuySelectFruitUi.StatusLabel = y:AddLabel({
			Text = "Ready",
			DoesWrap = true
		})
		u.BuySelectFruit.RefreshDropdownBuySelectFruit(G, false)
	end
	if V then
		local G
		G = V:AddValueDropdown("dd_collect_frutisx22", {
			Values = {},
			Default = {},
			Multi = true,
			Text = "\240\159\140\177 Collect Fruits",
			Tooltip = "Selected Fruits will be collected if they are ready.";
			Searchable = true;
			MaxVisibleDropdownItems = 10;
			Changed = function(G)
				if not G then
					return
				end
				e.collect_fruit_list = G
				u.FruitCollect.ResetBucket()
				q.Save.SaveDataSync()
			end
		})
		G:SetValues(u.FruitFilters.GetFruitTypeDropdownWithFarmCounts())
		G:SetValue(e.collect_fruit_list)
		V:AddButton({
			Text = "\226\153\187\239\184\143 Reload Fruit List",
			Tooltip = "Refreshes farm fruit counts in the list.";
			Func = function()
				G:SetValues(u.FruitFilters.GetFruitTypeDropdownWithFarmCounts())
				G:SetValue(e.collect_fruit_list)
				u.FruitCollect.ResetBucket()
			end
		})
		V:AddToggle("collection_teleportcollect", {
			Text = "<font color=\'#FFFFFF\'>\240\159\147\161 Auto Teleport</font>";
			Default = e.collection_teleport;
			Tooltip = "Teleports back to your garden if you are out of collection range.";
			Callback = function(G)
				e.collection_teleport = G
				q.Save.SaveData()
			end
		})
		V:AddValueDropdown("collect_sort_mode_v1", {
			Values = {
				{
					Text = "Default",
					Value = "Default"
				};
				{
					Text = "Highest Price > Lowest";
					Value = "Highest Price > Lowest"
				},
				{
					Text = "Lowest Price > Highest",
					Value = "Lowest Price > Highest"
				}
			};
			Default = e.collect_sort_mode,
			Multi = false;
			Text = "\240\159\146\176 Collect Sort";
			Tooltip = "Choose which ready fruits are collected first.",
			Searchable = false,
			MaxVisibleDropdownItems = 3;
			Changed = function(G)
				local V = tostring(G or "Default")
				if type(G) == "table" then
					V = "Default"
					for G, y in pairs(G) do
						V = tostring(y or "Default")
						break
					end
				end
				if V ~= "Highest Price > Lowest" and V ~= "Lowest Price > Highest" then
					V = "Default"
				end
				e.collect_sort_mode = V
				u.FruitCollect.ResetBucket()
				q.Save.SaveData()
			end
		})
		V:AddToggle("enablefruitcollector", {
			Text = "<font color=\'#CF02B0\'>Enable Fruit Collector</font>",
			Default = e.auto_collect_fruit_enabled;
			Tooltip = "Collects fruits and teleports you to the farm.";
			Callback = function(G)
				e.auto_collect_fruit_enabled = G
				u.FruitCollect.ResetBucket()
				q.Save.SaveData()
			end
		})
	end
	if Z then
		Z:AddLabel({
			Text = "\226\132\185\239\184\143 Press Enter after changing KG values. Empty mutation or variant lists collect everything unless protected below.";
			DoesWrap = true
		})
		local G
		local V
		local function y(G)
			local V = m(G)
			if not V then
				V = tonumber(e.collect_min_weight) or 0
			end
			return string.format("\226\172\135\239\184\143 Min Weight %.2fKG", V)
		end
		local function j(G)
			local V = m(G)
			if not V then
				V = tonumber(e.collect_max_weight) or 89
			end
			return string.format("\226\172\134\239\184\143 Max Weight %.2fKG", V)
		end
		G = Z:AddInput("collect_min_weight", {
			Text = y(e.collect_min_weight),
			Default = tostring(e.collect_min_weight);
			Numeric = true,
			AllowEmpty = true;
			Finished = true;
			ClearTextOnFocus = false;
			Placeholder = "Press Enter to update";
			Tooltip = "Press Enter to update. Fruits below this KG will not be collected.";
			Changed = function(V)
				if G then
					G:SetText(y(V))
				end
			end,
			Callback = function(V)
				local Z = m(V)
				if not Z then
					T.Notify("Invalid minimum KG", 3)
					G:SetValue(tostring(e.collect_min_weight))
					G:SetText(y(e.collect_min_weight))
					return
				end
				if Z < 0 then
					T.Notify("Minimum KG must be 0 or more", 3)
					G:SetValue(tostring(e.collect_min_weight))
					G:SetText(y(e.collect_min_weight))
					return
				end
				local j = tonumber(e.collect_max_weight) or 89
				if Z > j then
					T.Notify("Minimum KG must be lower than maximum KG", 3)
					G:SetValue(tostring(e.collect_min_weight))
					G:SetText(y(e.collect_min_weight))
					return
				end
				e.collect_min_weight = u.FruitFilters.RoundWeight(Z)
				G:SetText(y(e.collect_min_weight))
				u.FruitCollect.ResetBucket()
				q.Save.SaveDataSync()
			end
		})
		V = Z:AddInput("collect_max_weight", {
			Text = j(e.collect_max_weight);
			Default = tostring(e.collect_max_weight);
			Numeric = true,
			AllowEmpty = true,
			Finished = true,
			ClearTextOnFocus = false;
			Placeholder = "Press Enter to update";
			Tooltip = "Press Enter to update. Fruits above this KG will not be collected.";
			Changed = function(G)
				if V then
					V:SetText(j(G))
				end
			end;
			Callback = function(G)
				local y = m(G)
				if not y then
					T.Notify("Invalid maximum KG", 3)
					V:SetValue(tostring(e.collect_max_weight))
					V:SetText(j(e.collect_max_weight))
					return
				end
				if y < 0 then
					T.Notify("Maximum KG must be 0 or more", 3)
					V:SetValue(tostring(e.collect_max_weight))
					V:SetText(j(e.collect_max_weight))
					return
				end
				local Z = tonumber(e.collect_min_weight) or 0
				if y < Z then
					T.Notify("Maximum KG must be higher than minimum KG", 3)
					V:SetValue(tostring(e.collect_max_weight))
					V:SetText(j(e.collect_max_weight))
					return
				end
				e.collect_max_weight = u.FruitFilters.RoundWeight(y)
				V:SetText(j(e.collect_max_weight))
				u.FruitCollect.ResetBucket()
				q.Save.SaveDataSync()
			end
		})
		Z:AddDivider()
		local i
		i = Z:AddValueDropdown("collect_mutation_whitelist", {
			Values = u.FruitFilters.GetMutationNames();
			Default = {};
			Multi = true,
			Text = "\226\156\133 Only Mutations",
			Tooltip = "Only collect fruits with selected mutations. Empty allows all mutations.",
			Searchable = true;
			MaxVisibleDropdownItems = 10,
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.collect_mutation_whitelist = G
				u.FruitCollect.ResetBucket()
				q.Save.SaveDataSync()
			end
		})
		i:SetValue(e.collect_mutation_whitelist)
		local c
		c = Z:AddValueDropdown("collect_mutation_blacklist", {
			Values = u.FruitFilters.GetMutationNames(),
			Default = {};
			Multi = true,
			Text = "\226\155\148 Block Mutations";
			Tooltip = "Selected mutations will not be collected.";
			Searchable = true;
			MaxVisibleDropdownItems = 10,
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.collect_mutation_blacklist = G
				u.FruitCollect.ResetBucket()
				q.Save.SaveDataSync()
			end
		})
		c:SetValue(e.collect_mutation_blacklist)
		Z:AddDivider()
		local J
		J = Z:AddValueDropdown("collect_variant_whitelist", {
			Values = u.FruitFilters.GetVariantNames(),
			Default = {},
			Multi = true;
			Text = "\226\156\133 Only Variants",
			Tooltip = "Only collect selected variants. Empty allows all variants.";
			Searchable = false,
			MaxVisibleDropdownItems = 5;
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.collect_variant_whitelist = G
				u.FruitCollect.ResetBucket()
				q.Save.SaveDataSync()
			end
		})
		J:SetValue(e.collect_variant_whitelist)
		local d
		d = Z:AddValueDropdown("collect_variant_blacklist", {
			Values = u.FruitFilters.GetVariantNames();
			Default = {};
			Multi = true;
			Text = "\240\159\155\161\239\184\143 Protect Variants",
			Tooltip = "Selected variants will not be collected.",
			Searchable = false,
			MaxVisibleDropdownItems = 5;
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.collect_variant_blacklist = G
				u.FruitCollect.ResetBucket()
				q.Save.SaveDataSync()
			end
		})
		d:SetValue(e.collect_variant_blacklist)
	end
end
T.Shopui = function()
	local G = i:AddTab({
		Name = "Shop";
		Description = "Shop",
		Icon = "store"
	})
	local V = G:AddLeftGroupbox("Seed Shop", "sprout")
	local y = G:AddRightGroupbox("Gear Shop", "wrench")
	local Z = G:AddLeftGroupbox("Crate Shop", "package")
	local function j(G, V)
		local y = tonumber(V)
		if not y then
			y = d.Currency.ParseMoney(tostring(V or e[G .. "_min_sheckles"] or 0))
		end
		y = math.max(tonumber(y) or 0, 0)
		return "\240\159\146\176 Keep Min Sheckles: " .. d.Currency.FormatMoney(y)
	end
	local function c(G, V, y)
		if not G then
			return
		end
		G:AddToggle(y .. "_enabled", {
			Text = "\240\159\146\176 Enable Sheckles Reserve";
			Default = e[V .. "_min_sheckles_enabled"] == true;
			Tooltip = "When enabled, the shop keeps this much money saved and only spends above it.";
			Callback = function(G)
				e[V .. "_min_sheckles_enabled"] = G == true
				q.Save.SaveDataSync()
			end
		})
		local Z
		local i = false
		local function c(G)
			if Z then
				Z:SetText(j(V, G))
			end
		end
		local function J(G)
			if not Z then
				return
			end
			i = true
			Z:SetValue(d.Currency.FormatMoney(G))
			Z:SetText(j(V, G))
			i = false
		end
		Z = G:AddInput(y, {
			Text = j(V, e[V .. "_min_sheckles"]);
			Default = d.Currency.FormatMoney(e[V .. "_min_sheckles"]),
			Numeric = false,
			AllowEmpty = true,
			Finished = true,
			ClearTextOnFocus = false,
			Placeholder = "0 or 67m",
			Tooltip = "Press Enter to update. 0 disables the amount check.",
			Changed = function(G)
				if i then
					return
				end
				c(G)
			end,
			Callback = function(G)
				if i then
					return
				end
				local y = (tostring(G or "")):match("^%s*(.-)%s*$") or ""
				local Z = y == "" and 0 or d.Currency.ParseMoney(y)
				if not Z or Z < 0 then
					T.Notify("Invalid sheckles amount", 3)
					J(e[V .. "_min_sheckles"])
					return
				end
				e[V .. "_min_sheckles"] = math.floor(Z)
				J(e[V .. "_min_sheckles"])
				q.Save.SaveDataSync()
			end
		})
	end
	local function J(G, V, y)
		if not G then
			return
		end
		G:AddToggle(y .. "_enabled", {
			Text = "\240\159\140\166\239\184\143 Enable Trigger Buying",
			Default = e[V .. "_trigger_enabled"] == true;
			Tooltip = "When enabled, the shop only buys during the selected phase or weather.",
			Callback = function(G)
				e[V .. "_trigger_enabled"] = G == true
				q.Save.SaveDataSync()
			end
		})
		local Z
		Z = G:AddDropdown(y, {
			Values = a.ShopTrigger.GetValuesShopTrigger();
			Default = tostring(e[V .. "_trigger_name"] or "Any Time"),
			Multi = false,
			Text = "\240\159\140\166\239\184\143 Trigger",
			Tooltip = "Choose when this shop is allowed to buy.";
			Callback = function(G)
				if type(G) ~= "string" or G == "" then
					return
				end
				e[V .. "_trigger_name"] = G
				q.Save.SaveDataSync()
			end
		})
		Z:SetValue(tostring(e[V .. "_trigger_name"] or "Any Time"))
	end
	local function g(G, V, y, Z)
		if not G or not V then
			return
		end
		local j = G:AddButton({
			Text = "\226\156\133 Select All";
			Func = function()
				e[y] = a.ShopBuyer.GetAllSelectionShopBuyer(Z)
				V:SetValue(e[y])
				q.Save.SaveDataSync()
			end
		})
		j:AddButton({
			Text = "\240\159\167\185 Clear",
			Func = function()
				e[y] = {}
				V:SetValue({})
				q.Save.SaveDataSync()
			end
		})
	end
	if V then
		V:AddLabel({
			Text = "\226\132\185\239\184\143 Select the seeds you want to buy. Nothing is bought unless it is selected.";
			DoesWrap = true
		})
		local G
		G = V:AddValueDropdown("seedshop_buy_selected_v2", {
			Values = {},
			Default = {},
			Multi = true;
			Text = "\226\156\133 Buy Selected Seeds",
			Tooltip = "Selected seeds will be purchased when in stock.",
			Searchable = true;
			MaxVisibleDropdownItems = 10;
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.seed_shop_buy_selected = G
				q.Save.SaveDataSync()
			end
		})
		G:SetValues(u.SeedData.GetSeedShopDropDown())
		G:SetValue(e.seed_shop_buy_selected)
		g(V, G, "seed_shop_buy_selected", T.SeedShopDataList)
		V:AddToggle("seedshopautobuyenabled", {
			Text = "<font color=\'#FFFFFF\'>\240\159\140\177 Enable Seed Shop</font>";
			Default = e.enabled_seed_shop,
			Tooltip = "When enabled, buys selected seeds only.",
			Callback = function(G)
				e.enabled_seed_shop = G == true
				q.Save.SaveData()
			end
		})
		c(V, "seed_shop", "seed_shop_min_sheckles_ui")
		J(V, "seed_shop", "seed_shop_trigger_ui")
	end
	if y then
		y:AddLabel({
			Text = "\226\132\185\239\184\143 Select the gear you want to buy. Nothing is bought unless it is selected.";
			DoesWrap = true
		})
		local G
		G = y:AddValueDropdown("gearshop_buy_selected_v2", {
			Values = {};
			Default = {};
			Multi = true,
			Text = "\226\156\133 Buy Selected Gear";
			Tooltip = "Selected gear will be purchased when in stock.";
			Searchable = true,
			MaxVisibleDropdownItems = 10;
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.gear_shop_buy_selected = G
				q.Save.SaveDataSync()
			end
		})
		G:SetValues(u.GearData.GetGearShopDropDown())
		G:SetValue(e.gear_shop_buy_selected)
		g(y, G, "gear_shop_buy_selected", T.AllGearShopData)
		y:AddToggle("dd_gearshop_enabled_v2", {
			Text = "<font color=\'#FFFFFF\'>\240\159\148\171 Enable Gear Shop</font>";
			Default = e.enabled_gear_shop;
			Tooltip = "When enabled, buys selected gear only.";
			Callback = function(G)
				e.enabled_gear_shop = G == true
				q.Save.SaveData()
			end
		})
		c(y, "gear_shop", "gear_shop_min_sheckles_ui")
		J(y, "gear_shop", "gear_shop_trigger_ui")
	end
	if Z then
		Z:AddLabel({
			Text = "\226\132\185\239\184\143 Crate Shop is disabled by default. Select crates first, then enable it.",
			DoesWrap = true
		})
		local G
		G = Z:AddValueDropdown("crateshop_buy_selected_v1", {
			Values = {},
			Default = {};
			Multi = true;
			Text = "\226\156\133 Buy Selected Crates";
			Tooltip = "Selected crates will be purchased when in stock.",
			Searchable = true,
			MaxVisibleDropdownItems = 10;
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.crate_shop_buy_selected = G
				q.Save.SaveDataSync()
			end
		})
		G:SetValues(u.CrateData.GetCrateShopDropDown())
		G:SetValue(e.crate_shop_buy_selected)
		g(Z, G, "crate_shop_buy_selected", T.CrateShopDataList)
		Z:AddToggle("crateshopautobuyenabled_v1", {
			Text = "<font color=\'#FFFFFF\'>\240\159\147\166 Enable Crate Shop</font>",
			Default = e.enabled_crate_shop,
			Tooltip = "When enabled, buys selected crates only.";
			Callback = function(G)
				e.enabled_crate_shop = G == true
				q.Save.SaveData()
			end
		})
		c(Z, "crate_shop", "crate_shop_min_sheckles_ui")
		J(Z, "crate_shop", "crate_shop_trigger_ui")
	end
end
T.SellingUi = function()
	local G = i:AddTab({
		Name = "Sell Manager";
		Description = "Sell pets, fruits and more.";
		Icon = "store"
	})
	local V = G:AddLeftGroupbox("Sell Fruits", "badge-dollar-sign")
	local y = G:AddRightGroupbox("Sell Filters", "sliders-horizontal")
	local Z = G:AddLeftGroupbox("Sell Pets", "paw-print")
	local j = G:AddRightGroupbox("Pet Sell Filters", "shield-check")
	if V then
		V:AddToggle("auto_use_daily_deal_ui", {
			Text = "\226\173\144 Save & Use Daily Deal";
			Default = e.auto_use_daily_deal,
			Tooltip = "Saves the Daily Deal until your fruit backpack is full. Filtered selling protects fruits and uses one-by-one selling.",
			Callback = function(G)
				e.auto_use_daily_deal = G
				u.SellManager.DailyDealNextCheckAt = 0
				q.Save.SaveDataSync()
			end
		})
		V:AddToggle("sell_when_backpack_full_ui", {
			Text = "\240\159\142\146 Sell When Backpack Is Full",
			Default = e.sell_when_backpack_full;
			Tooltip = "Automatically sells fruits when your backpack is full.";
			Callback = function(G)
				e.sell_when_backpack_full = G
				q.Save.SaveDataSync()
			end
		})
		V:AddToggle("autopsellfruitsturbo", {
			Text = "<font color=\'#CF02B0\'>\226\154\161 Turbo Sell</font>",
			Default = e.turbo_sell,
			Tooltip = "Sells really fast";
			Callback = function(G)
				e.turbo_sell = G
				q.Save.SaveData()
			end
		})
		V:AddToggle("autopsellfruits", {
			Text = "<font color=\'#CF02B0\'>\240\159\146\176 Enable Auto Sell</font>";
			Default = e.auto_sell_sellallinventory;
			Tooltip = "Sells your fruits.",
			Callback = function(G)
				e.auto_sell_sellallinventory = G
				q.Save.SaveData()
			end
		})
	end
	if y then
		y:AddLabel({
			Text = "\226\132\185\239\184\143 Enable filters to sell matching fruits one by one. Press Enter after changing KG values. Protected mutations or variants will not be sold.";
			DoesWrap = true
		})
		local G
		G = y:AddValueDropdown("sell_fruit_filter_list", {
			Values = {};
			Default = {},
			Multi = true,
			Text = "\240\159\140\177 Sell Fruits",
			Tooltip = "Only selected fruits will be sold when filters are enabled. Empty allows all fruit names.",
			Searchable = true;
			MaxVisibleDropdownItems = 10;
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.sell_fruit_list = G
				q.Save.SaveDataSync()
			end
		})
		G:SetValues(u.SellManager.GetSellFruitTypeDropdownWithBackpackCounts())
		G:SetValue(e.sell_fruit_list)
		y:AddButton({
			Text = "\226\153\187\239\184\143 Reload Sell List",
			Tooltip = "Refreshes backpack fruit counts in the list.";
			Func = function()
				G:SetValues(u.SellManager.GetSellFruitTypeDropdownWithBackpackCounts())
				G:SetValue(e.sell_fruit_list)
			end
		})
		y:AddToggle("sell_filters_enabled_ui", {
			Text = "\240\159\155\161\239\184\143 Use Sell Filters";
			Default = e.sell_use_filters;
			Tooltip = "When enabled, only fruits passing the filters are sold one by one.",
			Callback = function(G)
				e.sell_use_filters = G
				q.Save.SaveDataSync()
			end
		})
		local V
		local Z
		local function j(G)
			local V = m(G)
			if not V then
				V = tonumber(e.sell_min_weight) or 0
			end
			return string.format("\226\172\135\239\184\143 Min Sell %.2fKG", V)
		end
		local function i(G)
			local V = m(G)
			if not V then
				V = tonumber(e.sell_max_weight) or 89
			end
			return string.format("\226\172\134\239\184\143 Max Sell %.2fKG", V)
		end
		V = y:AddInput("sell_min_weight", {
			Text = j(e.sell_min_weight);
			Default = tostring(e.sell_min_weight);
			Numeric = true;
			AllowEmpty = true;
			Finished = true,
			ClearTextOnFocus = false,
			Placeholder = "Press Enter to update",
			Tooltip = "Press Enter to update. Fruits below this KG will not be sold.",
			Changed = function(G)
				if V then
					V:SetText(j(G))
				end
			end;
			Callback = function(G)
				local y = m(G)
				if not y then
					T.Notify("Invalid minimum sell KG", 3)
					V:SetValue(tostring(e.sell_min_weight))
					V:SetText(j(e.sell_min_weight))
					return
				end
				if y < 0 then
					T.Notify("Minimum sell KG must be 0 or more", 3)
					V:SetValue(tostring(e.sell_min_weight))
					V:SetText(j(e.sell_min_weight))
					return
				end
				local Z = tonumber(e.sell_max_weight) or 89
				if y > Z then
					T.Notify("Minimum sell KG must be lower than maximum KG", 3)
					V:SetValue(tostring(e.sell_min_weight))
					V:SetText(j(e.sell_min_weight))
					return
				end
				e.sell_min_weight = u.FruitFilters.RoundWeight(y)
				V:SetText(j(e.sell_min_weight))
				q.Save.SaveDataSync()
			end
		})
		Z = y:AddInput("sell_max_weight", {
			Text = i(e.sell_max_weight),
			Default = tostring(e.sell_max_weight),
			Numeric = true,
			AllowEmpty = true,
			Finished = true,
			ClearTextOnFocus = false,
			Placeholder = "Press Enter to update";
			Tooltip = "Press Enter to update. Fruits above this KG will not be sold.",
			Changed = function(G)
				if Z then
					Z:SetText(i(G))
				end
			end;
			Callback = function(G)
				local V = m(G)
				if not V then
					T.Notify("Invalid maximum sell KG", 3)
					Z:SetValue(tostring(e.sell_max_weight))
					Z:SetText(i(e.sell_max_weight))
					return
				end
				if V < 0 then
					T.Notify("Maximum sell KG must be 0 or more", 3)
					Z:SetValue(tostring(e.sell_max_weight))
					Z:SetText(i(e.sell_max_weight))
					return
				end
				local y = tonumber(e.sell_min_weight) or 0
				if V < y then
					T.Notify("Maximum sell KG must be higher than minimum KG", 3)
					Z:SetValue(tostring(e.sell_max_weight))
					Z:SetText(i(e.sell_max_weight))
					return
				end
				e.sell_max_weight = u.FruitFilters.RoundWeight(V)
				Z:SetText(i(e.sell_max_weight))
				q.Save.SaveDataSync()
			end
		})
		y:AddDivider()
		local c
		c = y:AddValueDropdown("sell_mutation_whitelist", {
			Values = u.FruitFilters.GetMutationNames(),
			Default = {},
			Multi = true,
			Text = "\226\156\133 Only Mutations";
			Tooltip = "Only sell fruits with selected mutations. Empty allows all mutations.",
			Searchable = true,
			MaxVisibleDropdownItems = 10;
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.sell_mutation_whitelist = G
				q.Save.SaveDataSync()
			end
		})
		c:SetValue(e.sell_mutation_whitelist)
		local J
		J = y:AddValueDropdown("sell_mutation_blacklist", {
			Values = u.FruitFilters.GetMutationNames();
			Default = {},
			Multi = true,
			Text = "\226\155\148 Protect Mutations";
			Tooltip = "Selected mutations will not be sold.",
			Searchable = true;
			MaxVisibleDropdownItems = 10,
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.sell_mutation_blacklist = G
				q.Save.SaveDataSync()
			end
		})
		J:SetValue(e.sell_mutation_blacklist)
		y:AddDivider()
		local d
		d = y:AddValueDropdown("sell_variant_whitelist", {
			Values = u.FruitFilters.GetVariantNames(),
			Default = {};
			Multi = true;
			Text = "\226\156\133 Only Variants";
			Tooltip = "Only sell selected variants. Empty allows all variants.";
			Searchable = false,
			MaxVisibleDropdownItems = 5;
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.sell_variant_whitelist = G
				q.Save.SaveDataSync()
			end
		})
		d:SetValue(e.sell_variant_whitelist)
		local g
		g = y:AddValueDropdown("sell_variant_blacklist", {
			Values = u.FruitFilters.GetVariantNames();
			Default = {},
			Multi = true;
			Text = "\240\159\155\161\239\184\143 Protect Variants",
			Tooltip = "Selected variants will not be sold.";
			Searchable = false;
			MaxVisibleDropdownItems = 5;
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.sell_variant_blacklist = G
				q.Save.SaveDataSync()
			end
		})
		g:SetValue(e.sell_variant_blacklist)
	end
	if Z then
		Z:AddLabel({
			Text = "\240\159\155\161\239\184\143 Pet seller only sells selected pets. Equipped, unknown, protected, Rainbow and Big/Huge pets are protected by default.";
			DoesWrap = true
		})
		Z:AddToggle("pet_sell_preview_only_ui", {
			Text = "\240\159\145\128 Preview Only",
			Default = e.pet_sell_preview_only,
			Tooltip = "Shows how many pets are safe to sell without selling them.";
			Callback = function(G)
				e.pet_sell_preview_only = G
				q.Save.SaveDataSync()
			end
		})
		Z:AddToggle("auto_sell_pets_ui", {
			Text = "\240\159\144\190 Enable Pet Seller";
			Default = e.auto_sell_pets;
			Tooltip = "Sells only selected pets that pass all protection filters.",
			Callback = function(G)
				e.auto_sell_pets = G
				u.PetSeller.NextRunAt = 0
				q.Save.SaveDataSync()
			end
		})
		Z:AddToggle("pet_sell_duplicate_only_ui", {
			Text = "\240\159\147\166 Duplicate Only",
			Default = e.pet_sell_duplicate_only;
			Tooltip = "Keeps the chosen amount for each pet size and variant bucket.";
			Callback = function(G)
				e.pet_sell_duplicate_only = G
				q.Save.SaveDataSync()
			end
		})
		local G
		G = Z:AddInput("pet_sell_keep_amount_ui", {
			Text = "\240\159\148\146 Keep Per Pet",
			Default = tostring(e.pet_sell_keep_amount);
			Numeric = true,
			AllowEmpty = true;
			Finished = true,
			ClearTextOnFocus = false,
			Placeholder = "Keep amount",
			Tooltip = "How many pets to keep in each name, size and variant bucket.",
			Callback = function(V)
				local y = L(V)
				if y == nil or y < 0 then
					T.Notify("Keep amount must be 0 or more", 3)
					G:SetValue(tostring(e.pet_sell_keep_amount))
					return
				end
				e.pet_sell_keep_amount = y
				q.Save.SaveDataSync()
			end
		})
		local V
		V = Z:AddInput("pet_sell_max_per_cycle_ui", {
			Text = "\240\159\148\162 Max Per Cycle";
			Default = tostring(e.pet_sell_max_per_cycle);
			Numeric = true,
			AllowEmpty = true,
			Finished = true;
			ClearTextOnFocus = false,
			Placeholder = "Pets per cycle",
			Tooltip = "Maximum pets sold each cycle.";
			Callback = function(G)
				local y = L(G)
				if y == nil or y <= 0 then
					T.Notify("Max per cycle must be above 0", 3)
					V:SetValue(tostring(e.pet_sell_max_per_cycle))
					return
				end
				e.pet_sell_max_per_cycle = math.clamp(y, 1, 100)
				q.Save.SaveDataSync()
			end
		})
		local y
		y = Z:AddInput("pet_sell_delay_ui", {
			Text = "\226\143\177\239\184\143 Delay";
			Default = tostring(e.pet_sell_delay);
			Numeric = true;
			AllowEmpty = true,
			Finished = true;
			ClearTextOnFocus = false,
			Placeholder = "Seconds",
			Tooltip = "Delay between each pet sale.";
			Callback = function(G)
				local V = m(G)
				if not V or V < .15 then
					T.Notify("Pet sell delay must be 0.15 or more", 3)
					y:SetValue(tostring(e.pet_sell_delay))
					return
				end
				e.pet_sell_delay = math.clamp(V, .15, 10)
				q.Save.SaveDataSync()
			end
		})
		Z:AddButton({
			Text = "\226\153\187\239\184\143 Refresh Pet Lists",
			Tooltip = "Refreshes all pet seller dropdowns.",
			Func = function()
				if T.PetSellerUi.RefreshPetDropdowns then
					T.PetSellerUi.RefreshPetDropdowns()
				end
			end
		})
	end
	if j then
		local G
		local V
		local y
		local Z
		local i
		local c
		local J
		G = j:AddValueDropdown("pet_sell_selected_ui", {
			Values = {};
			Default = {};
			Multi = true,
			Text = "\240\159\144\190 Pets To Sell",
			Tooltip = "Only selected pets can be sold. Empty sells nothing.",
			Searchable = true;
			MaxVisibleDropdownItems = 10,
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.pet_sell_selected = G
				u.PetSeller.NextRunAt = 0
				q.Save.SaveDataSync()
			end
		})
		V = j:AddValueDropdown("pet_sell_protected_ui", {
			Values = {};
			Default = {};
			Multi = true;
			Text = "\240\159\155\161\239\184\143 Protect Pet Names",
			Tooltip = "Selected pet names will not be sold.",
			Searchable = true;
			MaxVisibleDropdownItems = 10,
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.pet_sell_protected = G
				q.Save.SaveDataSync()
			end
		})
		y = j:AddValueDropdown("pet_sell_protected_ids_ui", {
			Values = {},
			Default = {};
			Multi = true;
			Text = "\240\159\148\144 Protect Exact Pets";
			Tooltip = "Selected exact pet IDs will not be sold.";
			Searchable = true;
			MaxVisibleDropdownItems = 10;
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.pet_sell_protected_ids = G
				q.Save.SaveDataSync()
			end
		})
		T.PetSellerUi.RefreshPetDropdowns = function()
			local j = u.PetSeller.GetPetNameDropdown()
			if G then
				G:SetValues(j)
				G:SetValue(e.pet_sell_selected)
			end
			if V then
				V:SetValues(j)
				V:SetValue(e.pet_sell_protected)
			end
			if y then
				y:SetValues(u.PetSeller.GetProtectedIdDropdown())
				y:SetValue(e.pet_sell_protected_ids)
			end
			if Z then
				Z:SetValues(u.PetSeller.GetSizeNames())
				Z:SetValue(e.pet_sell_size_whitelist)
			end
			if i then
				i:SetValues(u.PetSeller.GetSizeNames())
				i:SetValue(e.pet_sell_size_blacklist)
			end
			if c then
				c:SetValues(u.PetSeller.GetVariantNames())
				c:SetValue(e.pet_sell_variant_whitelist)
			end
			if J then
				J:SetValues(u.PetSeller.GetVariantNames())
				J:SetValue(e.pet_sell_variant_blacklist)
			end
		end
		j:AddDropdown("pet_sell_max_rarity_ui", {
			Values = u.PetSeller.RarityOrder,
			Default = e.pet_sell_max_rarity,
			Multi = false,
			Text = "\226\173\144 Max Rarity To Sell",
			Tooltip = "Pets above this rarity will not be sold.";
			Callback = function(G)
				if type(G) ~= "string" or not T.RarityRank[G] then
					return
				end
				e.pet_sell_max_rarity = G
				q.Save.SaveDataSync()
			end
		})
		j:AddToggle("pet_sell_protect_rainbow_ui", {
			Text = "\240\159\140\136 Protect Rainbow";
			Default = e.pet_sell_protect_rainbow;
			Tooltip = "Rainbow pets will not be sold.";
			Callback = function(G)
				e.pet_sell_protect_rainbow = G
				q.Save.SaveDataSync()
			end
		})
		j:AddToggle("pet_sell_protect_big_huge_ui", {
			Text = "\240\159\147\143 Protect Big/Huge";
			Default = e.pet_sell_protect_big_huge,
			Tooltip = "Big and Huge pets will not be sold.";
			Callback = function(G)
				e.pet_sell_protect_big_huge = G
				q.Save.SaveDataSync()
			end
		})
		local d
		d = j:AddInput("pet_sell_max_base_price_ui", {
			Text = "\240\159\146\184 Max Base Price",
			Default = tostring(e.pet_sell_max_base_price);
			Numeric = true;
			AllowEmpty = true,
			Finished = true,
			ClearTextOnFocus = false;
			Placeholder = "0 disables";
			Tooltip = "Pets above this base price will not be sold. Use 0 to disable.";
			Callback = function(G)
				local V = L(G)
				if V == nil or V < 0 then
					T.Notify("Max base price must be 0 or more", 3)
					d:SetValue(tostring(e.pet_sell_max_base_price))
					return
				end
				e.pet_sell_max_base_price = V
				q.Save.SaveDataSync()
			end
		})
		j:AddDivider()
		Z = j:AddValueDropdown("pet_sell_size_whitelist_ui", {
			Values = {},
			Default = {};
			Multi = true;
			Text = "\226\156\133 Only Sizes",
			Tooltip = "Only selected sizes can be sold. Empty allows all sizes.",
			Searchable = false,
			MaxVisibleDropdownItems = 5;
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.pet_sell_size_whitelist = G
				q.Save.SaveDataSync()
			end
		})
		i = j:AddValueDropdown("pet_sell_size_blacklist_ui", {
			Values = {},
			Default = {};
			Multi = true;
			Text = "\240\159\155\161\239\184\143 Protect Sizes";
			Tooltip = "Selected sizes will not be sold.",
			Searchable = false,
			MaxVisibleDropdownItems = 5,
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.pet_sell_size_blacklist = G
				q.Save.SaveDataSync()
			end
		})
		c = j:AddValueDropdown("pet_sell_variant_whitelist_ui", {
			Values = {},
			Default = {},
			Multi = true;
			Text = "\226\156\133 Only Variants",
			Tooltip = "Only selected variants can be sold. Empty allows all variants.";
			Searchable = false,
			MaxVisibleDropdownItems = 5,
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.pet_sell_variant_whitelist = G
				q.Save.SaveDataSync()
			end
		})
		J = j:AddValueDropdown("pet_sell_variant_blacklist_ui", {
			Values = {};
			Default = {},
			Multi = true;
			Text = "\240\159\155\161\239\184\143 Protect Variants",
			Tooltip = "Selected variants will not be sold.";
			Searchable = false,
			MaxVisibleDropdownItems = 5,
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.pet_sell_variant_blacklist = G
				q.Save.SaveDataSync()
			end
		})
		T.PetSellerUi.RefreshPetDropdowns()
	end
end
J.is_dex_loaded = false
J.LoadDexTool = function()
	if J.is_dex_loaded then
		return
	end
	local G, V = pcall(function()
		(loadstring(game:HttpGet("https://github.com/BOXLEGENDARY/Dex/releases/latest/download/out.lua")))()
		J.is_dex_loaded = true
	end)
end
J.is_spy_loaded = false
J.LoadSpyTool = function()
	if J.is_spy_loaded then
		return
	end
	local G, V = pcall(function()
		(loadstring(game:HttpGet("https://github.com/notpoiu/cobalt/releases/latest/download/Cobalt.luau")))()
		J.is_spy_loaded = true
	end)
end
T.WebhooksUi = function()
	local G = i:AddTab({
		Name = "Webhooks";
		Description = "Webhook notifications",
		Icon = "webhook"
	})
	local V = G:AddRightGroupbox("Notifications", "bell-ring")
	local y = G:AddLeftGroupbox("Webhook URL", "link")
	if V then
		V:AddToggle("webhook_event_seed_notifications", {
			Text = "\240\159\140\136 Gold & Rainbow Seeds";
			Default = e.webhook_event_seeds,
			Tooltip = "Send a notification when you collect a Gold or Rainbow Seed.";
			Callback = function(G)
				e.webhook_event_seeds = G
				if not G then
					table.clear(T.EventSeed_WebhookData)
				end
				q.Save.SaveDataSync()
			end
		})
		V:AddToggle("webhook_pet_buy_notifications", {
			Text = "\240\159\144\190 Pet Purchases",
			Default = e.webhook_pet_buys,
			Tooltip = "Send a notification after a pet purchase is confirmed.",
			Callback = function(G)
				e.webhook_pet_buys = G
				if not G then
					if type(T.PetFinder_WebhookData) == "table" then
						table.clear(T.PetFinder_WebhookData)
					end
					u.Webhooks.ClearStatus()
				end
				q.Save.SaveDataSync()
			end
		})
		V:AddToggle("webhook_mail_manual_notifications", {
			Text = "\240\159\147\166 Manual Orders Completed";
			Default = e.webhook_mail_manual,
			Tooltip = "Send a notification when a manual order is fully delivered.";
			Callback = function(G)
				e.webhook_mail_manual = G
				if not G then
					u.Webhooks.RemoveMailType("manual")
				end
				q.Save.SaveDataSync()
			end
		})
		V:AddToggle("webhook_mail_auto_notifications", {
			Text = "\226\154\153\239\184\143 Automatic Mail Sent",
			Default = e.webhook_mail_auto;
			Tooltip = "Send a notification after an automatic mail cycle completes.";
			Callback = function(G)
				e.webhook_mail_auto = G
				if not G then
					u.Webhooks.RemoveMailType("automatic")
				end
				q.Save.SaveDataSync()
			end
		})
		V:AddToggle("webhook_mail_claim_notifications", {
			Text = "\240\159\147\165 Incoming Mail Claimed",
			Default = e.webhook_mail_claims;
			Tooltip = "Send a notification after incoming mail is claimed.";
			Callback = function(G)
				e.webhook_mail_claims = G
				if not G then
					u.Webhooks.RemoveMailType("claim")
				end
				q.Save.SaveDataSync()
			end
		})
	end
	if y then
		y:AddLabel({
			Text = "\240\159\148\151 Notifications will be posted to this URL.",
			DoesWrap = true
		})
		local G
		G = y:AddInput("webhook_url_input", {
			Text = "\240\159\148\151 Webhook URL";
			Default = tostring(e.webhook_url or ""),
			Numeric = false;
			AllowEmpty = true;
			Finished = false,
			ClearTextOnFocus = false,
			Placeholder = "https://your-webhook-url";
			Tooltip = "Enter the URL that will receive notifications.",
			Callback = function(V)
				local y = (tostring(V or "")):match("^%s*(.-)%s*$") or ""
				if y ~= "" and not u.Webhooks.IsValidUrl(y) then
					T.Notify("Enter a valid HTTP or HTTPS webhook URL", 3)
					G:SetValue(tostring(e.webhook_url or ""))
					return
				end
				e.webhook_url = y
				q.Save.SaveDataSync()
				if y == "" then
					T.Notify("Webhook URL cleared", 2)
				else
					T.Notify("Webhook URL saved", 2)
				end
			end
		})
		y:AddToggle("webhook_enabled", {
			Text = "Enable Webhooks";
			Default = e.webhook_enabled;
			Tooltip = "Enable or disable all webhook notifications",
			Callback = function(G)
				e.webhook_enabled = G
				if not G then
					table.clear(T.PetFinder_WebhookData)
					table.clear(T.Mail_WebhookData)
					table.clear(T.EventSeed_WebhookData)
					u.Webhooks.ClearStatus()
				end
				q.Save.SaveDataSync()
			end
		})
	end
end
u.GardenSyncDebug = {
	GetGardenSyncDebug = function()
		local G = y.GardenSyncController
		if type(G) ~= "table" or type(G.GetGarden) ~= "function" then
			return nil, "GardenSyncController unavailable"
		end
		local V, Z = pcall(function()
			return G:GetGarden(T.player_userid)
		end)
		if not V or type(Z) ~= "table" then
			return nil, "No garden sync data"
		end
		return Z, nil
	end;
	GetSavePathGardenSyncDebug = function()
		local G = "exotichub99"
		local V = G .. "/debug"
		if type(isfolder) == "function" and type(makefolder) == "function" then
			if not isfolder(G) then
				makefolder(G)
			end
			if not isfolder(V) then
				makefolder(V)
			end
		end
		local y = os.date("%Y%m%d_%H%M%S")
		return V .. ("/garden_sync_" .. (tostring(T.player_userid or "player") .. ("_" .. (y .. ".json"))))
	end,
	SaveGardenSyncJsonDebug = function(G)
		if type(writefile) ~= "function" then
			if G then
				G:SetText("writefile is not supported by this executor")
			end
			T.Notify("writefile is not supported", 3)
			return false
		end
		local V, Z = u.GardenSyncDebug.GetGardenSyncDebug()
		if not V then
			if G then
				G:SetText(tostring(Z or "No garden sync data"))
			end
			T.Notify(tostring(Z or "No garden sync data"), 3)
			return false
		end
		local j, i = pcall(function()
			return y.HttpService:JSONEncode(V)
		end)
		if not j or type(i) ~= "string" or i == "" then
			if G then
				G:SetText("JSON encode failed")
			end
			T.Notify("JSON encode failed", 3)
			return false
		end
		local c = u.GardenSyncDebug.GetSavePathGardenSyncDebug()
		local J, d = pcall(function()
			writefile(c, i)
		end)
		if not J then
			if G then
				G:SetText("Save failed: " .. tostring(d))
			end
			T.Notify("Garden sync save failed", 3)
			return false
		end
		if G then
			G:SetText("Saved Garden Sync JSON\n" .. (c .. ("\nLength: " .. tostring(# i))))
		end
		T.Notify("Garden sync JSON saved", 2)
		return true
	end;
	BuildGardenSyncDebugUi = function(G)
		if not G then
			return false
		end
		local V = nil
		G:AddDivider()
		G:AddButton({
			Text = "Save Garden Sync JSON";
			Func = function()
				u.GardenSyncDebug.SaveGardenSyncJsonDebug(V)
			end
		})
		V = G:AddLabel({
			Text = "Press save to write live garden sync JSON to file.";
			DoesWrap = true
		})
		return true
	end
}
T.TestGardenSync = {
	Started = false;
	RenderLoopRunning = false,
	Connections = {};
	Plants = {};
	Fruits = {},
	RemovedFruits = {};
	BaseWeightCache = {},
	GenerationModuleCache = {};
	WeightFormatCache = nil;
	OvertimeFlagsCache = nil,
	CalculateOvertimeGrowthCache = nil;
	GrowRateDataCache = nil,
	Label = nil,
	Dropdown = nil;
	WatchPlantId = "";
	RenderInterval = .35;
	MaxPlants = 3,
	MaxFruitsPerPlant = 12,
	Colours = {
		Title = "#7CFC00",
		Plant = "#6EE7FF",
		Fruit = "#FFFFFF";
		Ready = "#7CFC00",
		Growing = "#FFD166";
		Removed = "#FF5C5C";
		Muted = "#AAAAAA",
		Gold = "#FFD700",
		Rainbow = "#FF66FF";
		Normal = "#DADADA",
		Kg = "#7CFC00",
		Id = "#888888",
		Bad = "#FF5C5C"
	},
	Now = function()
		return os.clock()
	end;
	WallNow = function()
		return os.time()
	end,
	S = function(G)
		return tostring(G or "")
	end,
	N = function(G, V)
		local y = tonumber(G)
		if y == nil then
			return V or 0
		end
		return y
	end,
	Round2 = function(G)
		G = tonumber(G) or 0
		return math.floor((G * 100) + .5) / 100
	end;
	Round4 = function(G)
		G = tonumber(G) or 0
		return math.floor((G * 10000) + .5) / 10000
	end,
	ShortId = function(G)
		G = tostring(G or "")
		if # G <= 8 then
			return G
		end
		return string.sub(G, 1, 8)
	end;
	Html = function(G)
		G = tostring(G or "")
		G = G:gsub("&", "&amp;")
		G = G:gsub("<", "&lt;")
		G = G:gsub(">", "&gt;")
		G = G:gsub("\"", "&quot;")
		return G
	end;
	C = function(G, V)
		return string.format("<font color=\"%s\">%s</font>", G or "#FFFFFF", T.TestGardenSync.Html(V))
	end;
	Key = function(G, V)
		return tostring(G or "") .. ("\031" .. tostring(V or ""))
	end;
	IsMine = function(G)
		return tonumber(G) == tonumber(T.player_userid)
	end;
	SafeRequire = function(G)
		if not G then
			return nil
		end
		local V, Z = pcall(function()
			if type(y.safeRequire) == "function" then
				return y.safeRequire(G)
			end
			return require(G)
		end)
		if V then
			return Z
		end
		return nil
	end;
	GetGarden = function()
		local G = y.GardenSyncController
		if type(G) ~= "table" or type(G.GetGarden) ~= "function" then
			return nil
		end
		local V, Z = pcall(function()
			return G:GetGarden(T.player_userid)
		end)
		if V and type(Z) == "table" then
			return Z
		end
		return nil
	end;
	CopyFields = function(G, V)
		if type(G) ~= "table" or type(V) ~= "table" then
			return V
		end
		for G, y in pairs(G) do
			if type(y) ~= "table" then
				V[G] = y
			elseif G == "Positions" then
				V[G] = {
					PosX = y.PosX,
					PosY = y.PosY;
					PosZ = y.PosZ,
					Rotation = y.Rotation
				}
			end
		end
		return V
	end,
	MutationText = function(G)
		if type(G) ~= "string" then
			return ""
		end
		return G
	end,
	GetVariant = function(G, V)
		G = T.TestGardenSync.MutationText(G)
		if G:find("Rainbow", 1, true) then
			return "Rainbow"
		end
		if G:find("Gold", 1, true) then
			return "Gold"
		end
		V = tostring(V or "")
		if V == "Rainbow" or V == "Gold" then
			return V
		end
		return "Normal"
	end;
	GetVariantColour = function(G)
		if G == "Gold" then
			return T.TestGardenSync.Colours.Gold
		end
		if G == "Rainbow" then
			return T.TestGardenSync.Colours.Rainbow
		end
		return T.TestGardenSync.Colours.Normal
	end;
	GetSharedModules = function()
		return y.SharedModules or (y.ReplicatedStorage and y.ReplicatedStorage:FindFirstChild("SharedModules"))
	end;
	GetWeightFormat = function()
		if T.TestGardenSync.WeightFormatCache ~= nil then
			return T.TestGardenSync.WeightFormatCache ~= false and T.TestGardenSync.WeightFormatCache or nil
		end
		T.TestGardenSync.WeightFormatCache = false
		if type(y.WeightFormat) == "table" then
			T.TestGardenSync.WeightFormatCache = y.WeightFormat
			return y.WeightFormat
		end
		local G = T.TestGardenSync.GetSharedModules()
		local V = G and G:FindFirstChild("WeightFormat")
		local Z = T.TestGardenSync.SafeRequire(V)
		if type(Z) == "table" and type(Z.FormatGrams) == "function" then
			T.TestGardenSync.WeightFormatCache = Z
			return Z
		end
		return nil
	end,
	FormatKg = function(G)
		G = tonumber(G) or 0
		local V = T.TestGardenSync.GetWeightFormat()
		if type(V) == "table" and type(V.FormatGrams) == "function" then
			local y, Z = pcall(function()
				return V.FormatGrams(G)
			end)
			if y and type(Z) == "string" then
				return Z
			end
		end
		return string.format("%.2fkg", T.TestGardenSync.Round2(G))
	end,
	GetOvertimeFlags = function()
		if T.TestGardenSync.OvertimeFlagsCache ~= nil then
			return T.TestGardenSync.OvertimeFlagsCache ~= false and T.TestGardenSync.OvertimeFlagsCache or nil
		end
		T.TestGardenSync.OvertimeFlagsCache = false
		if type(y.OvertimeGrowthFlags) == "table" then
			T.TestGardenSync.OvertimeFlagsCache = y.OvertimeGrowthFlags
			return y.OvertimeGrowthFlags
		end
		local G = T.TestGardenSync.GetSharedModules()
		local V = G and G:FindFirstChild("Flags")
		local Z = V and V:FindFirstChild("OvertimeGrowthFlags")
		local j = T.TestGardenSync.SafeRequire(Z)
		if type(j) == "table" then
			T.TestGardenSync.OvertimeFlagsCache = j
			return j
		end
		return nil
	end,
	IsOvertimeEnabled = function()
		local G = T.TestGardenSync.GetOvertimeFlags()
		if type(G) ~= "table" then
			return true
		end
		local V = G.Enabled
		if type(V) == "table" and type(V.Get) == "function" then
			local G, y = pcall(function()
				return V:Get()
			end)
			if G then
				return y == true
			end
		end
		if type(V) == "boolean" then
			return V
		end
		return true
	end;
	GetCalculateOvertimeGrowth = function()
		if T.TestGardenSync.CalculateOvertimeGrowthCache ~= nil then
			return T.TestGardenSync.CalculateOvertimeGrowthCache ~= false and T.TestGardenSync.CalculateOvertimeGrowthCache or nil
		end
		T.TestGardenSync.CalculateOvertimeGrowthCache = false
		if type(y.CalculateOvertimeGrowth) == "function" then
			T.TestGardenSync.CalculateOvertimeGrowthCache = y.CalculateOvertimeGrowth
			return y.CalculateOvertimeGrowth
		end
		local G = T.TestGardenSync.GetSharedModules()
		local V = G and G:FindFirstChild("CalculateOvertimeGrowth")
		local Z = T.TestGardenSync.SafeRequire(V)
		if type(Z) == "function" then
			T.TestGardenSync.CalculateOvertimeGrowthCache = Z
			return Z
		end
		return nil
	end,
	GetGrowRateData = function()
		if T.TestGardenSync.GrowRateDataCache ~= nil then
			return T.TestGardenSync.GrowRateDataCache ~= false and T.TestGardenSync.GrowRateDataCache or nil
		end
		T.TestGardenSync.GrowRateDataCache = false
		if type(y.GrowRateData) == "table" then
			T.TestGardenSync.GrowRateDataCache = y.GrowRateData
			return y.GrowRateData
		end
		local G = T.TestGardenSync.GetSharedModules()
		local V = G and G:FindFirstChild("GrowRateData")
		local Z = T.TestGardenSync.SafeRequire(V)
		if type(Z) == "table" then
			T.TestGardenSync.GrowRateDataCache = Z
			return Z
		end
		return nil
	end,
	GetDefaultPlantGrowRate = function(G)
		local V = T.TestGardenSync.GetGrowRateData()
		local y = type(V) == "table" and V[tostring(G or "")] or nil
		if type(y) == "table" then
			return tonumber(y.GrowRate) or 0
		end
		return 0
	end;
	GetGenerationFolder = function(G)
		local V = y.ReplicatedStorage and y.ReplicatedStorage:FindFirstChild("PlantGenerationModules")
		if not V then
			return nil
		end
		return V:FindFirstChild(G and "Plants" or "Fruits")
	end;
	GetGenerationModule = function(G, V)
		G = tostring(G or "")
		if G == "" then
			return nil
		end
		local y = ((V and "P:" or "F:")) .. G
		local Z = T.TestGardenSync.GenerationModuleCache[y]
		if Z ~= nil then
			return Z ~= false and Z or nil
		end
		local j = T.TestGardenSync.GetGenerationFolder(V)
		if typeof(j) ~= "Instance" then
			T.TestGardenSync.GenerationModuleCache[y] = false
			return nil
		end
		local i = j:FindFirstChild(G)
		if not i or not i:IsA("ModuleScript") then
			T.TestGardenSync.GenerationModuleCache[y] = false
			return nil
		end
		local c = T.TestGardenSync.SafeRequire(i)
		if type(c) ~= "table" then
			T.TestGardenSync.GenerationModuleCache[y] = false
			return nil
		end
		T.TestGardenSync.GenerationModuleCache[y] = c
		return c
	end;
	GetBaseWeight = function(G, V)
		G = tostring(G or "")
		if G == "" then
			return nil
		end
		local y = ((V and "P:" or "F:")) .. G
		local Z = T.TestGardenSync.BaseWeightCache[y]
		if Z ~= nil then
			return Z ~= false and Z or nil
		end
		local j = T.TestGardenSync.GetGenerationModule(G, V)
		local i = type(j) == "table" and (type(j.GrowData) == "table" and tonumber(j.GrowData.BaseWeight)) or nil
		if not i or i <= 0 then
			T.TestGardenSync.BaseWeightCache[y] = false
			return nil
		end
		T.TestGardenSync.BaseWeightCache[y] = i
		return i
	end,
	GetOvertimeForWeight = function(G, V)
		if not T.TestGardenSync.IsOvertimeEnabled() then
			return 1
		end
		if type(G) ~= "table" then
			return 1
		end
		local y = tonumber(G.OvertimeGrowth)
		if V then
			if not y or y <= 0 then
				local V = tonumber(G.FinishedGrowingAt) or 0
				local Z = T.TestGardenSync.GetCalculateOvertimeGrowth()
				if V > 0 and type(Z) == "function" then
					local G, j = pcall(function()
						return Z(os.time() - V)
					end)
					if G and tonumber(j) then
						y = math.max(tonumber(j) or 1, 1)
					end
				end
			end
			return math.clamp(tonumber(y) or 1, 1, 100)
		end
		return tonumber(y) or 1
	end,
	GetWeightData = function(G, V, y)
		if type(V) ~= "table" then
			return {
				kg = 0,
				grams = 0;
				text = "0.00kg",
				base = 0,
				size = 1,
				overtime = 1;
				has_weight = false
			}
		end
		local Z = T.TestGardenSync.GetBaseWeight(G, y) or 0
		local j = tonumber(V.SizeMultiplier or V.SizeMulti) or 1
		local i = T.TestGardenSync.GetOvertimeForWeight(V, y)
		local c = (Z * j) * i
		return {
			kg = T.TestGardenSync.Round2(c);
			grams = c,
			text = T.TestGardenSync.FormatKg(c),
			base = Z;
			size = j;
			overtime = i,
			has_weight = c > 0
		}
	end,
	GetSeedData = function(G)
		G = tostring(G or "")
		if G == "" then
			return nil
		end
		if type(y.SeedData) == "table" then
			for V, y in ipairs(y.SeedData) do
				if type(y) == "table" and y.SeedName == G then
					return y
				end
			end
		end
		return nil
	end,
	IsSingleHarvestPlant = function(G)
		G = tostring(G or "")
		if G == "" then
			return false
		end
		local V = T.TestGardenSync.GetSeedData(G)
		if type(V) == "table" and V.IsSingleHarvest ~= nil then
			return V.IsSingleHarvest == true
		end
		if type(y.PlantVisualizerController) == "table" and type(y.PlantVisualizerController.IsSingleHarvestPlant) == "function" then
			local V, Z = pcall(function()
				return y.PlantVisualizerController:IsSingleHarvestPlant(G)
			end)
			if V and type(Z) == "boolean" then
				return Z
			end
		end
		if u.SeedData and type(u.SeedData.IsSingleHarvest) == "function" then
			return u.SeedData.IsSingleHarvest(G) == true
		end
		return type(T.SeedSingleHarvest) == "table" and T.SeedSingleHarvest[G] == true
	end;
	EstimateStartingAge = function(G)
		if type(G) ~= "table" then
			return 0
		end
		local V = T.TestGardenSync.N(G.Age, 0)
		local y = T.TestGardenSync.N(G.MaxAge, 0)
		if y <= 0 then
			return V
		end
		local Z = T.TestGardenSync.N(G.FinishedGrowingAt, 0)
		local j = T.TestGardenSync.N(G.GrowRate or G.StableGrowthAmount or G.GrowthRate, 0)
		if Z > 0 then
			local G = T.TestGardenSync.WallNow()
			if G >= Z then
				return y
			end
			if j > 0 then
				V = math.max(V, y - (((Z - G)) * j))
			end
		end
		return math.clamp(V, 0, y)
	end;
	GetPlantGrowthRate = function(G)
		if type(G) ~= "table" then
			return 0
		end
		local V = tonumber(G.BoostExpiresClock) or 0
		if V > 0 and T.TestGardenSync.Now() >= V then
			G.StableGrowthAmount = tonumber(G.PostBoostRate) or tonumber(G.StableGrowthAmount) or 0
			G.BoostExpiresClock = 0
		end
		return tonumber(G.StableGrowthAmount or G.GrowthRate or G.GrowRate) or 0
	end;
	AdvancePlant = function(G)
		if type(G) ~= "table" or G.Removed then
			return G
		end
		local V = T.TestGardenSync.N(G.MaxAge, 0)
		if V <= 0 then
			return G
		end
		local y = T.TestGardenSync.N(G.CurrentAge, G.Age or 0)
		if y >= V then
			G.CurrentAge = V
			G.Age = V
			G.LastClock = T.TestGardenSync.Now()
			return G
		end
		local Z = T.TestGardenSync.N(G.FinishedGrowingAt, 0)
		if Z > 0 and T.TestGardenSync.WallNow() >= Z then
			G.CurrentAge = V
			G.Age = V
			G.LastClock = T.TestGardenSync.Now()
			return G
		end
		local j = T.TestGardenSync.Now()
		local i = math.max(j - T.TestGardenSync.N(G.LastClock, j), 0)
		local c = T.TestGardenSync.GetPlantGrowthRate(G)
		if i > 0 and c > 0 then
			y = math.min(y + (i * c), V)
			G.CurrentAge = y
			G.Age = y
			G.LastClock = j
		end
		return G
	end;
	IsPlantReady = function(G)
		if type(G) ~= "table" or G.Removed then
			return false
		end
		T.TestGardenSync.AdvancePlant(G)
		local V = T.TestGardenSync.N(G.MaxAge, 0)
		return V > 0 and T.TestGardenSync.N(G.CurrentAge, G.Age or 0) >= V
	end;
	EnsurePlant = function(G, V)
		G = tostring(G or "")
		if G == "" then
			return nil
		end
		local y = T.TestGardenSync.Plants[G]
		if not y then
			y = {
				Id = G;
				PlantId = G,
				Fruits = {};
				CurrentAge = 0;
				StableGrowthAmount = 0;
				BoostExpiresClock = 0;
				PostBoostRate = 0,
				BoostSources = 0;
				AddedAt = T.TestGardenSync.Now(),
				LastClock = T.TestGardenSync.Now();
				LastUpdate = T.TestGardenSync.Now()
			}
			T.TestGardenSync.Plants[G] = y
		end
		if type(V) == "table" then
			T.TestGardenSync.CopyFields(V, y)
			local Z = V.PlantName or y.PlantName or ""
			local j = T.TestGardenSync.N(y.CurrentAge, y.Age or 0)
			local i = T.TestGardenSync.N(V.MaxAge, y.MaxAge or 0)
			local c = T.TestGardenSync.EstimateStartingAge(V)
			local J = T.TestGardenSync.GetDefaultPlantGrowRate(Z)
			local d = tonumber(y.StableGrowthAmount)
			if not d or d <= 0 then
				d = J
			end
			y.Id = G
			y.PlantId = G
			y.PlantName = Z
			y.Mutation = V.Mutation or y.Mutation
			y.Variant = V.Variant or y.Variant
			y.CurrentAge = math.clamp(math.max(j, c), 0, i > 0 and i or math.huge)
			y.Age = y.CurrentAge
			y.MaxAge = i
			y.SizeMultiplier = T.TestGardenSync.N(V.SizeMultiplier, y.SizeMultiplier or 1)
			y.OvertimeGrowth = V.OvertimeGrowth or y.OvertimeGrowth
			y.FinishedGrowingAt = V.FinishedGrowingAt or y.FinishedGrowingAt
			y.StableGrowthAmount = T.TestGardenSync.N(V.StableGrowthAmount or V.GrowRate or V.GrowthRate, d)
			y.PostBoostRate = T.TestGardenSync.N(y.PostBoostRate, y.StableGrowthAmount)
			y.LastClock = T.TestGardenSync.Now()
			y.LastUpdate = T.TestGardenSync.Now()
			y.Removed = false
		end
		return y
	end,
	EnsureFruit = function(G, V, y, Z)
		G = tostring(G or "")
		V = tostring(V or "")
		if G == "" or V == "" then
			return nil
		end
		local j = T.TestGardenSync.EnsurePlant(G, y)
		if not j then
			return nil
		end
		local i = T.TestGardenSync.Key(G, V)
		local c = T.TestGardenSync.Fruits[i]
		if not c then
			c = {
				Key = i;
				PlantId = G,
				FruitId = V,
				CurrentAge = 0,
				GrowthRate = 0,
				MaxAge = 0;
				OvertimeGrowth = 1;
				LastClock = T.TestGardenSync.Now(),
				AddedAt = T.TestGardenSync.Now();
				LastUpdate = T.TestGardenSync.Now()
			}
			T.TestGardenSync.Fruits[i] = c
			j.Fruits[V] = c
		end
		if type(Z) == "table" then
			T.TestGardenSync.CopyFields(Z, c)
			local G = T.TestGardenSync.N(c.CurrentAge, 0)
			local V = T.TestGardenSync.N(Z.MaxAge, c.MaxAge or 0)
			local y = T.TestGardenSync.EstimateStartingAge(Z)
			c.CurrentAge = math.clamp(math.max(G, y), 0, V > 0 and V or math.huge)
			c.GrowthRate = T.TestGardenSync.N(Z.GrowRate, c.GrowthRate or 0)
			c.MaxAge = V
			c.SizeMultiplier = T.TestGardenSync.N(Z.SizeMultiplier, c.SizeMultiplier or 1)
			c.OvertimeGrowth = T.TestGardenSync.N(Z.OvertimeGrowth, c.OvertimeGrowth or 1)
			c.Mutation = Z.Mutation or c.Mutation
			c.Seed = Z.Seed or c.Seed
			c.SpawnLocationIndex = Z.SpawnLocationIndex or c.SpawnLocationIndex
			c.FinishedGrowingAt = Z.FinishedGrowingAt or c.FinishedGrowingAt
			c.LastClock = T.TestGardenSync.Now()
			c.LastUpdate = T.TestGardenSync.Now()
			c.Removed = false
			T.TestGardenSync.RemovedFruits[i] = nil
		end
		return c
	end,
	AdvanceFruit = function(G)
		if type(G) ~= "table" or G.Removed then
			return G
		end
		local V = T.TestGardenSync.N(G.MaxAge, 0)
		if V <= 0 then
			return G
		end
		local y = T.TestGardenSync.N(G.CurrentAge, 0)
		if y >= V then
			G.CurrentAge = V
			G.LastClock = T.TestGardenSync.Now()
			return G
		end
		local Z = T.TestGardenSync.Now()
		local j = math.max(Z - T.TestGardenSync.N(G.LastClock, Z), 0)
		local i = T.TestGardenSync.N(G.GrowthRate, 0)
		if j > 0 and i > 0 then
			y = math.min(y + (j * i), V)
			G.CurrentAge = y
			G.Age = y
			G.LastClock = Z
		end
		return G
	end;
	IsFruitReady = function(G)
		if type(G) ~= "table" or G.Removed then
			return false
		end
		T.TestGardenSync.AdvanceFruit(G)
		local V = T.TestGardenSync.N(G.MaxAge, 0)
		return V > 0 and T.TestGardenSync.N(G.CurrentAge, 0) >= V
	end;
	SyncFromGarden = function()
		local G = T.TestGardenSync.GetGarden()
		if type(G) ~= "table" then
			return false
		end
		for G, V in pairs(G) do
			if type(V) ~= "table" then
				continue
			end
			T.TestGardenSync.EnsurePlant(G, V)
			if type(V.Fruits) == "table" then
				for y, Z in pairs(V.Fruits) do
					if type(Z) == "table" then
						T.TestGardenSync.EnsureFruit(G, y, V, Z)
					end
				end
			end
		end
		return true
	end,
	OnPlantAdded = function(G, V, y)
		if not T.TestGardenSync.IsMine(G) then
			return
		end
		T.TestGardenSync.EnsurePlant(V, y)
		if type(y) == "table" and type(y.Fruits) == "table" then
			for G, Z in pairs(y.Fruits) do
				T.TestGardenSync.EnsureFruit(V, G, y, Z)
			end
		end
		T.TestGardenSync.RefreshPlantDropdown()
		T.TestGardenSync.Render()
	end,
	OnPlantRemoved = function(G, V)
		if not T.TestGardenSync.IsMine(G) then
			return
		end
		V = tostring(V or "")
		local y = T.TestGardenSync.Plants[V]
		if y then
			y.Removed = true
			y.RemovedAt = T.TestGardenSync.Now()
			for G, V in pairs(y.Fruits or {}) do
				if type(V) == "table" then
					V.Removed = true
					V.RemovedAt = T.TestGardenSync.Now()
					T.TestGardenSync.RemovedFruits[V.Key] = true
				end
			end
		end
		T.TestGardenSync.RefreshPlantDropdown()
		T.TestGardenSync.Render()
	end;
	OnPlantGrowthUpdated = function(G, V, y, Z, j, i, c)
		if not T.TestGardenSync.IsMine(G) then
			return
		end
		local J = T.TestGardenSync.EnsurePlant(V)
		if J then
			T.TestGardenSync.AdvancePlant(J)
			local G = T.TestGardenSync.N(J.MaxAge, 0)
			local V = T.TestGardenSync.N(y, 0)
			local d = T.TestGardenSync.N(J.CurrentAge, 0)
			J.CurrentAge = G > 0 and math.min(math.max(V, d), G) or math.max(V, d)
			J.Age = J.CurrentAge
			J.StableGrowthAmount = T.TestGardenSync.N(Z, J.StableGrowthAmount or 0)
			local u = T.TestGardenSync.N(j, 0)
			J.BoostExpiresClock = u > 0 and (T.TestGardenSync.Now() + u) or 0
			J.PostBoostRate = T.TestGardenSync.N(i, J.StableGrowthAmount or 0)
			J.BoostSources = c or J.BoostSources or 0
			J.LastClock = T.TestGardenSync.Now()
			J.LastUpdate = T.TestGardenSync.Now()
		end
		T.TestGardenSync.Render()
	end,
	OnPlantAgeSync = function(G, V)
		if not T.TestGardenSync.IsMine(G) or type(V) ~= "table" then
			return
		end
		for G, V in pairs(V) do
			local y = T.TestGardenSync.EnsurePlant(G)
			if y then
				T.TestGardenSync.AdvancePlant(y)
				local G = T.TestGardenSync.N(y.MaxAge, 0)
				local Z = T.TestGardenSync.N(V, 0)
				if G > 0 and (T.TestGardenSync.N(y.CurrentAge, 0) >= G and Z < G) then
					Z = G
				end
				y.CurrentAge = G > 0 and math.min(math.max(Z, y.CurrentAge or 0), G) or math.max(Z, y.CurrentAge or 0)
				y.Age = y.CurrentAge
				y.LastClock = T.TestGardenSync.Now()
				y.LastUpdate = T.TestGardenSync.Now()
			end
		end
		T.TestGardenSync.Render()
	end,
	OnPlantMutationUpdated = function(G, V, y)
		if not T.TestGardenSync.IsMine(G) then
			return
		end
		local Z = T.TestGardenSync.EnsurePlant(V)
		if Z then
			Z.Mutation = y ~= "" and y or nil
			Z.LastUpdate = T.TestGardenSync.Now()
		end
		T.TestGardenSync.Render()
	end,
	OnFruitAdded = function(G, V, y, Z)
		if not T.TestGardenSync.IsMine(G) then
			return
		end
		local j = T.TestGardenSync.GetGarden()
		local i = type(j) == "table" and j[tostring(V or "")] or nil
		T.TestGardenSync.EnsureFruit(V, y, i, Z)
		T.TestGardenSync.Render()
	end,
	OnFruitRemoved = function(G, V, y)
		if not T.TestGardenSync.IsMine(G) then
			return
		end
		V = tostring(V or "")
		y = tostring(y or "")
		local Z = T.TestGardenSync.Key(V, y)
		local j = T.TestGardenSync.Fruits[Z]
		if j then
			j.Removed = true
			j.RemovedAt = T.TestGardenSync.Now()
			T.TestGardenSync.RemovedFruits[Z] = true
		end
		local i = T.TestGardenSync.Plants[V]
		if i and i.Fruits then
			i.Fruits[y] = nil
		end
		T.TestGardenSync.Render()
	end;
	OnFruitGrowthUpdated = function(G, V, y, Z, j)
		if not T.TestGardenSync.IsMine(G) then
			return
		end
		local i = T.TestGardenSync.EnsureFruit(V, y)
		if not i then
			return
		end
		T.TestGardenSync.AdvanceFruit(i)
		local c = T.TestGardenSync.N(i.MaxAge, 0)
		local J = T.TestGardenSync.N(Z, 0)
		local d = T.TestGardenSync.N(i.CurrentAge, 0)
		i.GrowthRate = T.TestGardenSync.N(j, i.GrowthRate or 0)
		i.CurrentAge = c > 0 and math.min(math.max(J, d), c) or math.max(J, d)
		i.Age = i.CurrentAge
		i.LastClock = T.TestGardenSync.Now()
		i.LastUpdate = T.TestGardenSync.Now()
		T.TestGardenSync.Render()
	end;
	OnFruitAgeSync = function(G, V, y)
		if not T.TestGardenSync.IsMine(G) or type(y) ~= "table" then
			return
		end
		for G, y in pairs(y) do
			local Z = T.TestGardenSync.EnsureFruit(V, G)
			if Z then
				T.TestGardenSync.AdvanceFruit(Z)
				local G = T.TestGardenSync.N(Z.MaxAge, 0)
				local V = T.TestGardenSync.N(y, 0)
				if G > 0 and (T.TestGardenSync.N(Z.CurrentAge, 0) >= G and V < G) then
					V = G
				end
				Z.CurrentAge = G > 0 and math.min(math.max(V, Z.CurrentAge or 0), G) or math.max(V, Z.CurrentAge or 0)
				Z.Age = Z.CurrentAge
				Z.LastClock = T.TestGardenSync.Now()
				Z.LastUpdate = T.TestGardenSync.Now()
			end
		end
		T.TestGardenSync.Render()
	end;
	OnFruitOvertimeGrowthUpdated = function(G, V, y, Z)
		if not T.TestGardenSync.IsMine(G) then
			return
		end
		local j = T.TestGardenSync.EnsureFruit(V, y)
		if j then
			j.OvertimeGrowth = T.TestGardenSync.N(Z, j.OvertimeGrowth or 1)
			j.LastUpdate = T.TestGardenSync.Now()
		end
		T.TestGardenSync.Render()
	end,
	OnFruitMutationUpdated = function(G, V, y, Z)
		if not T.TestGardenSync.IsMine(G) then
			return
		end
		local j = T.TestGardenSync.EnsureFruit(V, y)
		if j then
			j.Mutation = Z ~= "" and Z or nil
			j.LastUpdate = T.TestGardenSync.Now()
		end
		T.TestGardenSync.Render()
	end;
	ConnectGardenRemote = function(G, V)
		local Z = y.Networking and y.Networking.Garden
		local j = Z and Z[G]
		if not j or not j.OnClientEvent or type(V) ~= "function" then
			return false
		end
		local i, c = pcall(function()
			return j.OnClientEvent:Connect(V)
		end)
		if i and c then
			table.insert(T.TestGardenSync.Connections, c)
			return true
		end
		return false
	end;
	Start = function()
		if T.TestGardenSync.Started then
			T.TestGardenSync.Render()
			return true
		end
		T.TestGardenSync.Started = true
		T.TestGardenSync.SyncFromGarden()
		T.TestGardenSync.ConnectGardenRemote("PlantAdded", T.TestGardenSync.OnPlantAdded)
		T.TestGardenSync.ConnectGardenRemote("PlantRemoved", T.TestGardenSync.OnPlantRemoved)
		T.TestGardenSync.ConnectGardenRemote("PlantGrowthUpdated", T.TestGardenSync.OnPlantGrowthUpdated)
		T.TestGardenSync.ConnectGardenRemote("PlantAgeSync", T.TestGardenSync.OnPlantAgeSync)
		T.TestGardenSync.ConnectGardenRemote("PlantMutationUpdated", T.TestGardenSync.OnPlantMutationUpdated)
		T.TestGardenSync.ConnectGardenRemote("FruitAdded", T.TestGardenSync.OnFruitAdded)
		T.TestGardenSync.ConnectGardenRemote("FruitRemoved", T.TestGardenSync.OnFruitRemoved)
		T.TestGardenSync.ConnectGardenRemote("FruitGrowthUpdated", T.TestGardenSync.OnFruitGrowthUpdated)
		T.TestGardenSync.ConnectGardenRemote("FruitAgeSync", T.TestGardenSync.OnFruitAgeSync)
		T.TestGardenSync.ConnectGardenRemote("FruitOvertimeGrowthUpdated", T.TestGardenSync.OnFruitOvertimeGrowthUpdated)
		T.TestGardenSync.ConnectGardenRemote("FruitMutationUpdated", T.TestGardenSync.OnFruitMutationUpdated)
		T.TestGardenSync.RefreshPlantDropdown()
		T.TestGardenSync.StartRenderLoop()
		T.TestGardenSync.Render()
		return true
	end,
	Stop = function()
		T.TestGardenSync.Started = false
		for G, V in ipairs(T.TestGardenSync.Connections) do
			pcall(function()
				V:Disconnect()
			end)
		end
		table.clear(T.TestGardenSync.Connections)
		if T.TestGardenSync.Label then
			T.TestGardenSync.Label:SetText(T.TestGardenSync.C(T.TestGardenSync.Colours.Bad, "Garden sync test stopped."))
		end
		return true
	end,
	Reset = function()
		table.clear(T.TestGardenSync.Plants)
		table.clear(T.TestGardenSync.Fruits)
		table.clear(T.TestGardenSync.RemovedFruits)
		T.TestGardenSync.SyncFromGarden()
		T.TestGardenSync.RefreshPlantDropdown()
		T.TestGardenSync.Render()
	end,
	StartRenderLoop = function()
		if T.TestGardenSync.RenderLoopRunning then
			return
		end
		T.TestGardenSync.RenderLoopRunning = true
		task.spawn(function()
			while T.TestGardenSync.Started do
				T.TestGardenSync.Render()
				task.wait(T.TestGardenSync.RenderInterval)
			end
			T.TestGardenSync.RenderLoopRunning = false
		end)
	end;
	GetPlantList = function()
		local G = {}
		for V, y in pairs(T.TestGardenSync.Plants) do
			if type(y) == "table" and not y.Removed then
				table.insert(G, y)
			end
		end
		table.sort(G, function(G, V)
			return tostring(G.PlantName or "") < tostring(V.PlantName or "")
		end)
		return G
	end;
	BuildFruitResult = function(G, V, y)
		if type(G) ~= "table" then
			return nil
		end
		local Z = tostring(G.PlantName or "")
		local j = tostring(G.Id or G.PlantId or "")
		if Z == "" or j == "" then
			return nil
		end
		local i = y and G or V
		if type(i) ~= "table" then
			return nil
		end
		if y then
			T.TestGardenSync.AdvancePlant(G)
		else
			T.TestGardenSync.AdvanceFruit(V)
		end
		local c = y and T.TestGardenSync.IsPlantReady(G) or T.TestGardenSync.IsFruitReady(V)
		if not c then
			return nil
		end
		local J = tostring(i.Mutation or G.Mutation or "")
		local d = T.TestGardenSync.GetVariant(J, i.Variant or G.Variant)
		local u = T.TestGardenSync.GetWeightData(Z, i, y)
		return {
			name = Z,
			plantId = j;
			fruitId = y and "" or tostring(V.FruitId or ""),
			w = u.kg;
			kg = u.kg,
			kg_text = u.text,
			grams = u.grams,
			base_weight = u.base,
			size_multiplier = u.size;
			overtime_growth = u.overtime,
			has_weight = u.has_weight,
			r = (type(T.SeedRarity) == "table" and T.SeedRarity[Z]) or "Common",
			m = J,
			v = d,
			age = y and T.TestGardenSync.N(G.CurrentAge, G.Age or 0) or T.TestGardenSync.N(V.CurrentAge, 0);
			max_age = y and T.TestGardenSync.N(G.MaxAge, 0) or T.TestGardenSync.N(V.MaxAge, 0);
			grow_rate = y and T.TestGardenSync.GetPlantGrowthRate(G) or T.TestGardenSync.N(V.GrowthRate, 0);
			ready = true;
			sync = true,
			single_harvest = y == true,
			raw = i,
			plant_raw = G
		}
	end,
	GetFruits = function()
		if not T.TestGardenSync.Started then
			T.TestGardenSync.Start()
		else
			T.TestGardenSync.SyncFromGarden()
		end
		local G = {}
		for V, y in pairs(T.TestGardenSync.Plants) do
			if type(y) ~= "table" or y.Removed then
				continue
			end
			local Z = tostring(y.PlantName or "")
			if Z == "" then
				continue
			end
			if T.TestGardenSync.IsSingleHarvestPlant(Z) then
				local V = T.TestGardenSync.BuildFruitResult(y, nil, true)
				if V and V.has_weight then
					table.insert(G, V)
				end
			else
				for V, Z in pairs(y.Fruits or {}) do
					if type(Z) == "table" and not Z.Removed then
						local V = T.TestGardenSync.BuildFruitResult(y, Z, false)
						if V and V.has_weight then
							table.insert(G, V)
						end
					end
				end
			end
		end
		table.sort(G, function(G, V)
			local y = type(T.RarityRank) == "table" and T.RarityRank or {}
			local Z = y[G.r] or 0
			local j = y[V.r] or 0
			if Z ~= j then
				return Z > j
			end
			local i = type(G.m) == "string" and G.m ~= ""
			local c = type(V.m) == "string" and V.m ~= ""
			if i ~= c then
				return i
			end
			return ((tonumber(G.kg) or 0)) > ((tonumber(V.kg) or 0))
		end)
		return G
	end,
	GetReadyFruits = function()
		return T.TestGardenSync.GetFruits()
	end,
	GetPlantDropdownValues = function()
		local G = {}
		for V, y in ipairs(T.TestGardenSync.GetPlantList()) do
			local Z = tostring(y.PlantName or "Plant")
			local j = 0
			local i = 0
			local c = T.TestGardenSync.IsSingleHarvestPlant(Z)
			if c then
				j = 1
				if T.TestGardenSync.IsPlantReady(y) then
					i = 1
				end
			else
				for G, V in pairs(y.Fruits or {}) do
					if type(V) == "table" and not V.Removed then
						j += 1
						if T.TestGardenSync.IsFruitReady(V) then
							i += 1
						end
					end
				end
			end
			table.insert(G, {
				Text = string.format("%s <font color=\"#888888\">%s</font> <font color=\"#7CFC00\">%d ready</font><font color=\"#AAAAAA\">/%d</font>%s", T.TestGardenSync.Html(Z), T.TestGardenSync.Html(T.TestGardenSync.ShortId(y.Id)), i, j, c and " <font color=\"#FFD166\">Single</font>" or ""),
				Value = y.Id
			})
		end
		return G
	end;
	RefreshPlantDropdown = function()
		if T.TestGardenSync.Dropdown and type(T.TestGardenSync.Dropdown.SetValues) == "function" then
			T.TestGardenSync.Dropdown:SetValues(T.TestGardenSync.GetPlantDropdownValues())
		end
	end;
	SetWatchPlant = function(G)
		T.TestGardenSync.WatchPlantId = tostring(G or "")
		T.TestGardenSync.Render()
	end,
	FormatFruitLine = function(G, V, y, Z)
		local j = T.TestGardenSync.Colours
		local i = Z and V or y
		local c = tostring(V.PlantName or "")
		if Z then
			T.TestGardenSync.AdvancePlant(V)
		else
			T.TestGardenSync.AdvanceFruit(y)
		end
		local J = Z and T.TestGardenSync.IsPlantReady(V) or T.TestGardenSync.IsFruitReady(y)
		local d = tostring(i and i.Mutation or V.Mutation or "")
		local u = T.TestGardenSync.GetVariant(d, i and i.Variant or V.Variant)
		local q = T.TestGardenSync.GetVariantColour(u)
		local g = T.TestGardenSync.GetWeightData(c, i, Z)
		local E = Z and T.TestGardenSync.N(V.CurrentAge, V.Age or 0) or T.TestGardenSync.N(y.CurrentAge, 0)
		local a = Z and T.TestGardenSync.N(V.MaxAge, 0) or T.TestGardenSync.N(y.MaxAge, 0)
		local H = Z and T.TestGardenSync.GetPlantGrowthRate(V) or T.TestGardenSync.N(y.GrowthRate, 0)
		return string.format("   %s %s %s %s %s %s %s %s %s", T.TestGardenSync.C(J and j.Ready or j.Growing, J and "READY" or "GROWING"), T.TestGardenSync.C(j.Fruit, Z and "Single Harvest" or ("Fruit " .. tostring(G))), T.TestGardenSync.C(j.Id, "[" .. (T.TestGardenSync.ShortId(Z and V.Id or y.FruitId) .. "]")), T.TestGardenSync.C(j.Muted, "Age: " .. (tostring(T.TestGardenSync.Round2(E)) .. ("/" .. tostring(T.TestGardenSync.N(a, 0))))), T.TestGardenSync.C(j.Muted, "Rate: " .. tostring(T.TestGardenSync.Round4(H))), T.TestGardenSync.C(j.Kg, "KG: " .. g.text), T.TestGardenSync.C(j.Muted, "Base: " .. tostring(T.TestGardenSync.Round2(g.base))), T.TestGardenSync.C(j.Muted, "Size: " .. (tostring(T.TestGardenSync.Round2(g.size)) .. (" OT: " .. tostring(T.TestGardenSync.Round2(g.overtime))))), d ~= "" and T.TestGardenSync.C(q, "Mutation: " .. (d .. (" / " .. u))) or T.TestGardenSync.C(j.Normal, "Mutation: none / Normal"))
	end;
	FormatPlant = function(G)
		if type(G) ~= "table" then
			return ""
		end
		T.TestGardenSync.AdvancePlant(G)
		local V = T.TestGardenSync.Colours
		local y = {}
		local Z = tostring(G.PlantName or "Unknown")
		local j = T.TestGardenSync.IsSingleHarvestPlant(Z)
		local i = T.TestGardenSync.MutationText(G.Mutation)
		local c = T.TestGardenSync.GetVariant(i, G.Variant)
		local J = T.TestGardenSync.GetVariantColour(c)
		local d = j and T.TestGardenSync.GetWeightData(Z, G, true) or nil
		table.insert(y, string.format("%s %s %s %s %s %s", T.TestGardenSync.C(V.Plant, "Plant: " .. Z), T.TestGardenSync.C(V.Id, "[" .. (T.TestGardenSync.ShortId(G.Id) .. "]")), T.TestGardenSync.C(J, "Variant: " .. c), T.TestGardenSync.C(V.Muted, "Age: " .. (tostring(T.TestGardenSync.Round2(T.TestGardenSync.N(G.CurrentAge, G.Age or 0))) .. ("/" .. tostring(T.TestGardenSync.N(G.MaxAge, 0))))), j and T.TestGardenSync.C("#FFD166", "Single Harvest") or T.TestGardenSync.C(V.Muted, "Multi Harvest"), d and T.TestGardenSync.C(V.Kg, "KG: " .. d.text) or T.TestGardenSync.C(V.Muted, "KG: fruit-based")))
		if i ~= "" then
			table.insert(y, "   " .. T.TestGardenSync.C(J, "Plant Mutation: " .. i))
		end
		if j then
			table.insert(y, T.TestGardenSync.FormatFruitLine(1, G, nil, true))
			return table.concat(y, "\n")
		end
		local u = {}
		for G, V in pairs(G.Fruits or {}) do
			if type(V) == "table" and not V.Removed then
				T.TestGardenSync.AdvanceFruit(V)
				table.insert(u, V)
			end
		end
		table.sort(u, function(G, V)
			local y = T.TestGardenSync.IsFruitReady(G)
			local Z = T.TestGardenSync.IsFruitReady(V)
			if y ~= Z then
				return y
			end
			return T.TestGardenSync.N(G.CurrentAge, 0) > T.TestGardenSync.N(V.CurrentAge, 0)
		end)
		for Z, j in ipairs(u) do
			if Z > T.TestGardenSync.MaxFruitsPerPlant then
				table.insert(y, T.TestGardenSync.C(V.Muted, "   ... +" .. (tostring(# u - T.TestGardenSync.MaxFruitsPerPlant) .. " more fruits")))
				break
			end
			table.insert(y, T.TestGardenSync.FormatFruitLine(Z, G, j, false))
		end
		if # u == 0 then
			table.insert(y, T.TestGardenSync.C(V.Muted, "   No fruits stored for this plant yet."))
		end
		return table.concat(y, "\n")
	end,
	BuildText = function()
		local G = T.TestGardenSync.Colours
		local V = T.TestGardenSync.GetPlantList()
		local y = 0
		local Z = 0
		local j = 0
		for G, V in ipairs(V) do
			local i = tostring(V.PlantName or "")
			if T.TestGardenSync.IsSingleHarvestPlant(i) then
				j += 1
				y += 1
				if T.TestGardenSync.IsPlantReady(V) then
					Z += 1
				end
			else
				for G, V in pairs(V.Fruits or {}) do
					if type(V) == "table" and not V.Removed then
						y += 1
						if T.TestGardenSync.IsFruitReady(V) then
							Z += 1
						end
					end
				end
			end
		end
		local i = {
			T.TestGardenSync.C(G.Title, "DATA GARDEN SYNC TEST"),
			T.TestGardenSync.C(G.Muted, "Plants: " .. (tostring(# V) .. (" | Single: " .. (tostring(j) .. (" | Fruits: " .. (tostring(y) .. (" | Ready: " .. (tostring(Z) .. (" | Events: " .. tostring(# T.TestGardenSync.Connections))))))))));
			""
		}
		local c = tostring(T.TestGardenSync.WatchPlantId or "")
		if c ~= "" and T.TestGardenSync.Plants[c] then
			table.insert(i, T.TestGardenSync.FormatPlant(T.TestGardenSync.Plants[c]))
			return table.concat(i, "\n")
		end
		local J = 0
		for y, Z in ipairs(V) do
			J += 1
			if J > T.TestGardenSync.MaxPlants then
				table.insert(i, T.TestGardenSync.C(G.Muted, "... +" .. (tostring(# V - T.TestGardenSync.MaxPlants) .. " more plants. Select one from dropdown to watch live.")))
				break
			end
			table.insert(i, T.TestGardenSync.FormatPlant(Z))
			table.insert(i, "")
		end
		if # V == 0 then
			table.insert(i, T.TestGardenSync.C(G.Bad, "No plants loaded yet. Press Start / Refresh."))
		end
		return table.concat(i, "\n")
	end,
	Render = function()
		if not T.TestGardenSync.Label then
			return false
		end
		local G = T.TestGardenSync.BuildText()
		T.TestGardenSync.Label:SetText(G)
		return true
	end,
	BuildUi = function(G)
		if not G then
			return false
		end
		G:AddDivider()
		G:AddButton({
			Text = "Start Garden Sync Test";
			Func = function()
				T.TestGardenSync.Start()
			end
		})
		G:AddButton({
			Text = "Refresh Garden Snapshot";
			Func = function()
				T.TestGardenSync.Reset()
			end
		})
		G:AddButton({
			Text = "Stop Garden Sync Test",
			Func = function()
				T.TestGardenSync.Stop()
			end
		})
		T.TestGardenSync.Dropdown = G:AddDropdown("ddTestGardenSyncPlant", {
			Values = {},
			Default = {},
			Multi = false;
			Searchable = true;
			MaxVisibleDropdownItems = 10;
			Text = "Select Plant To Watch",
			Tooltip = "Shows one plant with live data-driven fruits",
			Callback = function(G)
				T.TestGardenSync.SetWatchPlant(G)
			end
		})
		T.TestGardenSync.Label = G:AddLabel({
			Text = "Press Start Garden Sync Test.",
			DoesWrap = true
		})
		T.TestGardenSync.RefreshPlantDropdown()
		return true
	end
}
T.SettingsUi = function()
	local G = i:AddTab({
		Name = "Settings";
		Description = "Settings";
		Icon = "settings"
	})
	local V = G:AddLeftGroupbox("Dev Tools", "align-center-horizontal")
	local Z = G:AddRightGroupbox("<uc>Data</uc>", "blocks")
	local j = G:AddLeftGroupbox("Required", "shield-check")
	local c = G:AddLeftGroupbox("Performance", "gauge")
	local d = G:AddRightGroupbox("Player UI", "blocks")
	if d then
		d:AddToggle("hideplayerstats", {
			Text = "\226\132\185\239\184\143 Hide Exo Stats",
			Default = e.hide_log_ui;
			Tooltip = "Hides the stats info for systems.";
			Callback = function(G)
				e.hide_log_ui = G
				q.Save.SaveDataSync()
			end
		})
		d:AddToggle("hide_player_ui_toggle", {
			Text = "\240\159\145\129\239\184\143 Hide Plot & Teleport UI";
			Default = e.hide_player_ui;
			Tooltip = "Hides the plot panels and teleport buttons.",
			Callback = function(G)
				e.hide_player_ui = G
				u.PlayerUI.Apply()
				q.Save.SaveDataSync()
			end
		})
	end
	if c then
		c:AddToggle("hide_plant_models_ui", {
			Text = "Hide Plant Models";
			Default = e.hide_plant_models;
			Tooltip = "Hides plant models to reduce game lag. Automation will continue working.";
			Callback = function(G)
				e.hide_plant_models = G
				q.Save.SaveDataSync()
			end
		})
	end
	if j then
		j:AddToggle("auto_idle_touch_ui", {
			Text = "\240\159\145\134 Idle Activity";
			Default = e.auto_idle_touch,
			Tooltip = "Simulates activity after three minutes without user input.";
			Callback = function(G)
				e.auto_idle_touch = G
				T.ExoAutoTouch.ResetTimer()
				q.Save.SaveDataSync()
			end
		})
	end
	if Z then
		local G = nil
		local V = ""
		local j = Z:AddDropdown("ddDatalistsdsx1", {
			Values = {},
			Default = {};
			Multi = false;
			Searchable = true,
			MaxVisibleDropdownItems = 10;
			Text = "\240\159\148\146 Select Key";
			Tooltip = "Reads data based on key";
			Callback = function(Z)
				if Z == nil then
					return
				end
				V = Z
				local j = u.DataReplica.GetData(Z)
				local i = y.HttpService:JSONEncode(j)
				if G then
					G:SetText(i)
				end
			end
		})
		Z:AddButton({
			Text = "Copy",
			Func = function()
				if V == "" or V == nil then
					return
				end
				local G = u.DataReplica.GetData(V)
				if G then
					local Z = y.HttpService:JSONEncode(G)
					local j = string.format("%s \n%s", V, Z)
					J.CopyToClipBoard(j)
				end
			end
		})
		G = Z:AddLabel({
			Text = "--";
			DoesWrap = true
		})
		j:SetValues(u.DataReplica.AllBigDataKeys)
	end
	if V then
		local G = V:AddButton({
			Text = "DEX";
			Func = function()
				J.LoadDexTool()
			end
		})
		local y = V:AddButton({
			Text = "SPY";
			Func = function()
				J.LoadSpyTool()
			end
		})
		V:AddDivider()
		V:AddDivider()
		V:AddDivider()
	end
end
T.TweaksUi = function()
	local G = i:AddTab({
		Name = "Tweaks",
		Description = "Customise system behaviour",
		Icon = "sliders-horizontal"
	})
	local V = G:AddLeftGroupbox("Movement", "move")
	if V then
		V:AddSlider("step_teleport_speed_ui", {
			Text = "Step Teleport Speed",
			Default = math.clamp(tonumber(e.step_teleport_speed) or 100, 25, 500);
			Min = 25,
			Max = 500,
			Rounding = 0;
			Suffix = "%",
			Tooltip = "Higher values travel faster. Very high speeds may cause movement correction.";
			Callback = function(G)
				local V = math.clamp(tonumber(G) or 100, 25, 500)
				e.step_teleport_speed = V
				u.StepTeleport.StepDelay = .35 * ((100 / V))
				q.Save.SaveDataSync()
			end
		})
		V:AddLabel({
			Text = "100% is the recommended default speed.";
			DoesWrap = true
		})
		V:AddToggle("player_speed_enabled_ui", {
			Text = "\226\154\161 Player Speed";
			Default = e.player_speed_enabled;
			Tooltip = "Keeps your movement speed at the selected minimum.",
			Callback = function(G)
				e.player_speed_enabled = G
				u.PlayerSpeed.ApplyPlayerSpeed()
				q.Save.SaveDataSync()
			end
		})
		V:AddSlider("player_speed_value_ui", {
			Text = "Player Speed",
			Default = math.clamp(tonumber(e.player_speed_value) or 80, 16, 160);
			Min = 16;
			Max = 160,
			Rounding = 0,
			Suffix = "";
			Tooltip = "Higher speed helps player-walk movement reach targets faster.",
			Callback = function(G)
				e.player_speed_value = math.clamp(tonumber(G) or 80, 16, 160)
				u.PlayerSpeed.ApplyPlayerSpeed()
				q.Save.SaveDataSync()
			end
		})
	end
end
T.PetEquipTriggersUi = function()
	local G = i:AddTab({
		Name = "<font color=\"#FFFFFF\">Pet </font><font color=\"#00A2FF\">Triggers</font>";
		Description = "Pet loadouts for events";
		Icon = "paw-print"
	})
	local V = G:AddLeftGroupbox("Pet Trigger Settings", "settings", false)
	local y = G:AddLeftGroupbox("Create Loadout", "plus-circle", false)
	local Z = G:AddRightGroupbox("Saved Loadouts", "list-checks", false)
	local j = G:AddRightGroupbox("Trigger Logs", "scroll-text", false)
	if V then
		V:AddLabel({
			Text = "Idle runs when no stronger event is active. Manual only runs when you press Run Manual Now.",
			DoesWrap = true
		})
		V:AddToggle("pet_equip_enabled_ui", {
			Text = "\240\159\144\190 Enable Pet Triggers",
			Default = e.pet_equip_enabled;
			Tooltip = "Runs enabled loadouts when their trigger is active.";
			Callback = function(G)
				e.pet_equip_enabled = G
				q.Save.SaveDataSync()
				u.PetEquipTriggers.ProcessPetEquipTriggers()
			end
		})
		V:AddToggle("pet_equip_restore_previous_ui", {
			Text = "\226\134\169\239\184\143 Restore Previous Pets",
			Default = e.pet_equip_restore_previous,
			Tooltip = "Restores the pets equipped before the trigger started.",
			Callback = function(G)
				e.pet_equip_restore_previous = G
				q.Save.SaveDataSync()
			end
		})
		V:AddToggle("pet_equip_log_enabled_ui", {
			Text = "\240\159\167\190 Log Trigger Events";
			Default = e.pet_equip_log_enabled,
			Tooltip = "Stores the latest trigger events in the log group.",
			Callback = function(G)
				e.pet_equip_log_enabled = G
				q.Save.SaveDataSync()
			end
		})
		V:AddButton({
			Text = "\226\134\169\239\184\143 Restore Previous Now";
			Func = function()
				u.PetEquipTriggers.RestorePreviousPetEquipTriggers("Manual restore")
			end
		})
		V:AddDivider()
		V:AddToggle("pet_equip_protect_rainbow_ui", {
			Text = "\240\159\140\136 Never Unequip Rainbow";
			Default = e.pet_equip_protect_rainbow,
			Tooltip = "Rainbow pets are kept equipped when possible.",
			Callback = function(G)
				e.pet_equip_protect_rainbow = G
				q.Save.SaveDataSync()
			end
		})
		V:AddToggle("pet_equip_protect_big_huge_ui", {
			Text = "\240\159\147\143 Never Unequip Big/Huge";
			Default = e.pet_equip_protect_big_huge,
			Tooltip = "Big and Huge pets are kept equipped when possible.";
			Callback = function(G)
				e.pet_equip_protect_big_huge = G
				q.Save.SaveDataSync()
			end
		})
		V:AddToggle("pet_equip_protect_super_secret_ui", {
			Text = "\240\159\146\142 Never Unequip Super/Secret",
			Default = e.pet_equip_protect_super_secret;
			Tooltip = "Super and Secret pets are kept equipped when possible.",
			Callback = function(G)
				e.pet_equip_protect_super_secret = G
				q.Save.SaveDataSync()
			end
		})
		local G
		G = V:AddValueDropdown("pet_equip_protected_names_ui", {
			Values = u.PetEquipTriggers.GetPetNameDropdownPetEquipTriggers(),
			Default = e.pet_equip_protected_names;
			Multi = true;
			Searchable = true;
			MaxVisibleDropdownItems = 10;
			Text = "\240\159\155\161\239\184\143 Protect Pet Types";
			Tooltip = "Selected pet types will not be unequipped by triggers.";
			Callback = function(G)
				if G == nil then
					return
				end
				e.pet_equip_protected_names = G
				q.Save.SaveDataSync()
			end
		})
		local y
		y = V:AddValueDropdown("pet_equip_protected_ids_ui", {
			Values = u.PetEquipTriggers.GetExactPetDropdownPetEquipTriggers(),
			Default = e.pet_equip_protected_ids;
			Multi = true,
			Searchable = true;
			MaxVisibleDropdownItems = 10,
			Text = "\240\159\148\144 Protect Exact Pets",
			Tooltip = "Selected exact pets will not be unequipped by triggers.",
			Callback = function(G)
				if G == nil then
					return
				end
				e.pet_equip_protected_ids = G
				q.Save.SaveDataSync()
			end
		})
		V:AddButton({
			Text = "\240\159\148\132 Refresh Pet Lists";
			Func = function()
				if G then
					G:SetValues(u.PetEquipTriggers.GetPetNameDropdownPetEquipTriggers())
				end
				if y then
					y:SetValues(u.PetEquipTriggers.GetExactPetDropdownPetEquipTriggers())
				end
				if G then
					G:SetValue(e.pet_equip_protected_names, true)
				end
				if y then
					y:SetValue(e.pet_equip_protected_ids, true)
				end
			end
		})
	end
	if Z then
		local G = {}
		T.PetEquipTriggerUi.RefreshingRules = false
		Z:AddLabel({
			Text = "Loadouts are created only after Save Loadout. Manual loadouts need Run Manual Now.";
			DoesWrap = true
		})
		local function V(G, V)
			if type(G) ~= "table" then
				return
			end
			if G.Toggle then
				G.Toggle:SetVisible(V)
			end
			if G.RunButton then
				G.RunButton:SetVisible(V)
			end
			if G.DeleteButton then
				G.DeleteButton:SetVisible(V)
			end
			if G.Divider then
				G.Divider:SetVisible(V)
			end
		end
		local function y(y)
			if type(y) ~= "table" then
				return nil
			end
			local j = tostring(y.id or "")
			if j == "" then
				return nil
			end
			local i = G[j]
			if not i then
				i = {
					ruleId = j
				}
				i.Toggle = Z:AddToggle("pet_equip_rule_toggle_" .. j, {
					Text = u.PetEquipTriggers.GetRuleSummaryPetEquipTriggers(y);
					Default = y.enabled == true;
					Tooltip = "Enable or disable this saved loadout.";
					Callback = function(G)
						if T.PetEquipTriggerUi.RefreshingRules then
							return
						end
						u.PetEquipTriggers.ToggleRulePetEquipTriggers(j, G)
					end
				})
				i.RunButton = Z:AddButton({
					Text = tostring(y.triggerType or "") == "Manual" and "\226\150\182 Run Manual Now" or "\226\150\182 Auto Trigger Only",
					Func = function()
						local G = (u.PetEquipTriggers.GetRulesTablePetEquipTriggers())[j]
						if type(G) ~= "table" then
							T.Notify("Loadout not found", 2)
							return
						end
						if tostring(G.triggerType or "") ~= "Manual" then
							T.Notify("Only manual loadouts use Run Manual Now", 2)
							return
						end
						u.PetEquipTriggers.TriggerManualPetEquipTriggers(j)
					end
				})
				i.DeleteButton = Z:AddButton({
					Text = "\240\159\151\145 Delete Loadout",
					Func = function()
						u.PetEquipTriggers.RemoveRulePetEquipTriggers(j)
					end
				})
				i.Divider = Z:AddLabel({
					Text = "<font color=\'#444444\'>\226\148\128\226\148\128\226\148\128\226\148\128\226\148\128\226\148\128\226\148\128\226\148\128\226\148\128\226\148\128\226\148\128\226\148\128\226\148\128\226\148\128\226\148\128\226\148\128\226\148\128\226\148\128\226\148\128\226\148\128\226\148\128\226\148\128\226\148\128\226\148\128</font>";
					DoesWrap = false
				})
				G[j] = i
			end
			V(i, true)
			i.Toggle:SetText(u.PetEquipTriggers.GetRuleSummaryPetEquipTriggers(y))
			i.Toggle:SetValue(y.enabled == true)
			i.RunButton:SetText(tostring(y.triggerType or "") == "Manual" and "\226\150\182 Run Manual Now" or "\226\150\182 Auto Trigger Only")
			return i
		end
		T.PetEquipTriggerUi.RefreshPetEquipRules = function()
			T.PetEquipTriggerUi.RefreshingRules = true
			local Z = {}
			for G, V in ipairs(u.PetEquipTriggers.GetSortedRulesPetEquipTriggers()) do
				local j = tostring(V.id or "")
				if j ~= "" then
					Z[j] = true
					y(V)
				end
			end
			for G, y in pairs(G) do
				if not Z[G] then
					V(y, false)
				end
			end
			T.PetEquipTriggerUi.RefreshingRules = false
		end
		Z:AddButton({
			Text = "\240\159\148\132 Refresh Loadouts";
			Func = function()
				T.PetEquipTriggerUi.RefreshPetEquipRules()
			end
		})
	end
	if y then
		local G = {
			name = "Pet Loadout",
			triggerType = "Manual";
			triggerName = "Manual";
			duration = 0;
			pets = {}
		}
		y:AddInput("pet_equip_rule_name_input_ui", {
			Text = "Loadout Name";
			Default = G.name;
			Numeric = false;
			AllowEmpty = false,
			Finished = true;
			ClearTextOnFocus = false;
			Placeholder = "Loadout name";
			Tooltip = "Name shown in the saved loadout list.";
			Callback = function(V)
				G.name = u.PetEquipTriggers.CleanRuleNamePetEquipTriggers(V)
			end
		})
		local V
		local Z
		local function j()
			local V = u.PetEquipTriggers.GetTriggerOptionsPetEquipTriggers(G.triggerType)
			G.triggerName = V[1] or "Manual"
			if Z then
				Z:SetValues(V)
				Z:SetValue(G.triggerName, true)
			end
		end
		V = y:AddDropdown("pet_equip_trigger_type_ui", {
			Values = {
				"Manual";
				"Default";
				"Time Cycle";
				"Weather";
				"Seed Pack",
				"Dropped Seed"
			};
			Default = G.triggerType,
			Multi = false,
			Text = "Trigger Type";
			Tooltip = "Choose when this loadout should run.",
			Callback = function(V)
				G.triggerType = tostring(V or "Manual")
				j()
			end
		})
		Z = y:AddDropdown("pet_equip_trigger_on_ui", {
			Values = u.PetEquipTriggers.GetTriggerOptionsPetEquipTriggers(G.triggerType),
			Default = G.triggerName;
			Multi = false,
			Text = "Trigger On";
			Tooltip = "Choose the event that activates this loadout.",
			Callback = function(V)
				G.triggerName = tostring(V or "Manual")
			end
		})
		y:AddInput("pet_equip_duration_input_ui", {
			Text = "Duration Seconds (0 = event/manual)",
			Default = "0",
			Numeric = true;
			AllowEmpty = false,
			Finished = true,
			ClearTextOnFocus = false,
			Placeholder = "0",
			Tooltip = "0 keeps event loadouts until the event ends. Manual 0 stays until restore.";
			Callback = function(V)
				G.duration = math.max(math.floor(tonumber(V) or 0), 0)
			end
		})
		y:AddDivider()
		local i = ""
		local c = 1
		local J = ""
		local d = ""
		y:AddValueDropdown("pet_equip_pet_type_ui", {
			Values = u.PetEquipTriggers.GetPetNameDropdownPetEquipTriggers();
			Default = "",
			Multi = false;
			Searchable = true,
			MaxVisibleDropdownItems = 10,
			Text = "Pet Type",
			Tooltip = "Choose the pet type to add to the loadout.",
			Callback = function(G)
				i = tostring(G or "")
			end
		})
		y:AddInput("pet_equip_pet_amount_input_ui", {
			Text = "Pet Amount",
			Default = "1",
			Numeric = true,
			AllowEmpty = false;
			Finished = true;
			ClearTextOnFocus = false;
			Placeholder = "1",
			Tooltip = "Amount to try equipping. Extra pets are ignored if you have no free slots.";
			Callback = function(G)
				c = math.clamp(math.floor(tonumber(G) or 1), 1, 12)
			end
		})
		y:AddDropdown("pet_equip_pet_size_ui", {
			Values = {
				"Any";
				"Normal";
				"Big";
				"Huge"
			},
			Default = "Any",
			Multi = false;
			Text = "Optional Size";
			Tooltip = "Optional pet size filter.",
			Callback = function(G)
				G = tostring(G or "Any")
				J = G == "Any" and "" or G
			end
		})
		y:AddDropdown("pet_equip_pet_variant_ui", {
			Values = {
				"Any";
				"Normal";
				"Rainbow"
			};
			Default = "Any",
			Multi = false,
			Text = "Optional Variant",
			Tooltip = "Optional pet variant filter.",
			Callback = function(G)
				G = tostring(G or "Any")
				d = G == "Any" and "" or G
			end
		})
		local q = y:AddLabel({
			Text = "Pending Pets: none",
			DoesWrap = true
		})
		local function g()
			local V = {}
			for G, y in ipairs(G.pets) do
				local Z = u.PetEquipTriggers.GetPetDisplayNamePetEquipTriggers(y.pet)
				local j = {}
				if tostring(y.size or "") ~= "" then
					table.insert(j, tostring(y.size))
				end
				if tostring(y.variant or "") ~= "" then
					table.insert(j, tostring(y.variant))
				end
				local i = # j > 0 and " [" .. (table.concat(j, ", ") .. "]") or ""
				table.insert(V, Z .. (" x" .. (tostring(y.amount or 1) .. i)))
			end
			q:SetText(# V > 0 and "Pending Pets:\n" .. table.concat(V, "\n") or "Pending Pets: none")
		end
		y:AddButton({
			Text = "\226\158\149 Add Pet To Pending",
			Func = function()
				local V = u.PetEquipTriggers.ResolvePetNamePetEquipTriggers(i)
				if V == "" then
					T.Notify("Select a pet type first", 2)
					return
				end
				table.insert(G.pets, {
					pet = V,
					amount = c;
					size = J;
					variant = d
				})
				g()
			end
		})
		y:AddButton({
			Text = "\240\159\167\185 Clear Pending Pets";
			Func = function()
				table.clear(G.pets)
				g()
			end
		})
		y:AddButton({
			Text = "\226\156\133 Save Loadout",
			Func = function()
				local V, y = u.PetEquipTriggers.AddRulePetEquipTriggers(G.name, G.triggerType, G.triggerName, G.duration, G.pets)
				if V then
					T.Notify("Loadout saved", 2)
					table.clear(G.pets)
					g()
					if T.PetEquipTriggerUi.RefreshPetEquipRules then
						T.PetEquipTriggerUi.RefreshPetEquipRules()
					end
					u.PetEquipTriggers.ProcessPetEquipTriggers()
				else
					T.Notify(tostring(y or "Could not save loadout"), 3)
				end
			end
		})
	end
	if Z and T.PetEquipTriggerUi.RefreshPetEquipRules then
		T.PetEquipTriggerUi.RefreshPetEquipRules()
	end
	if j then
		local G = j:AddLabel({
			Text = "No logs yet";
			DoesWrap = true
		})
		T.PetEquipTriggerUi.RefreshPetEquipLogs = function()
			local V = {}
			for G, y in ipairs(T.PetEquipTriggerLogs) do
				if G > 50 then
					break
				end
				table.insert(V, y)
			end
			G:SetText(# V > 0 and table.concat(V, "\n") or "No logs yet")
		end
		j:AddButton({
			Text = "\240\159\167\185 Clear Logs";
			Func = function()
				table.clear(T.PetEquipTriggerLogs)
				T.PetEquipTriggerUi.RefreshPetEquipLogs()
			end
		})
		T.PetEquipTriggerUi.RefreshPetEquipLogs()
	end
end
T.PackOpeningUi = function()
	local G = i:AddTab({
		Name = "<font color=\'#FF0090\'>Eggs</font> & Packs";
		Description = "Egg and seed pack opening",
		Icon = "package-open"
	})
	local V = G:AddLeftGroupbox("Egg Hatcher", "egg")
	local y = G:AddLeftGroupbox("Seed Pack Opener", "package-open")
	local Z = G:AddRightGroupbox("Egg Webhook Filters", "bell-ring")
	local j = G:AddRightGroupbox("Seed Pack Webhook Filters", "bell-ring")
	if V then
		V:AddLabel({
			Text = "Opens matching egg tools. Empty selected list opens all eggs except protected eggs.",
			DoesWrap = true
		})
		local G
		G = V:AddValueDropdown("egg_hatcher_selected_ui", {
			Values = u.PackOpenHelpers.GetEggDropdownPackOpenHelpers(),
			Default = {};
			Multi = true,
			Text = "\240\159\165\154 Open Selected Eggs",
			Tooltip = "Only selected eggs will be opened. Empty means all.";
			Searchable = true,
			MaxVisibleDropdownItems = 10,
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.egg_hatcher_selected = G
				q.Save.SaveDataSync()
			end
		})
		G:SetValue(e.egg_hatcher_selected)
		local y
		y = V:AddValueDropdown("egg_hatcher_protected_ui", {
			Values = u.PackOpenHelpers.GetEggDropdownPackOpenHelpers();
			Default = {},
			Multi = true;
			Text = "\240\159\155\161\239\184\143 Protect Eggs";
			Tooltip = "Selected eggs will not be opened.";
			Searchable = true,
			MaxVisibleDropdownItems = 10;
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.egg_hatcher_protected = G
				q.Save.SaveDataSync()
			end
		})
		y:SetValue(e.egg_hatcher_protected)
		local Z
		Z = V:AddInput("egg_hatcher_max_per_cycle_ui", {
			Text = "\240\159\148\162 Max Per Cycle";
			Default = tostring(e.egg_hatcher_max_per_cycle),
			Numeric = true;
			AllowEmpty = false,
			Finished = true,
			ClearTextOnFocus = false,
			Placeholder = "1",
			Tooltip = "Press Enter to update.",
			Callback = function(G)
				local V = L(G)
				if not V or V < 1 or V > 20 then
					T.Notify("Max per cycle must be 1-20", 3)
					Z:SetValue(tostring(e.egg_hatcher_max_per_cycle))
					return
				end
				e.egg_hatcher_max_per_cycle = V
				q.Save.SaveDataSync()
			end
		})
		local j
		j = V:AddInput("egg_hatcher_delay_ui", {
			Text = "\226\143\177\239\184\143 Delay";
			Default = tostring(e.egg_hatcher_delay);
			Numeric = true;
			AllowEmpty = false,
			Finished = true,
			ClearTextOnFocus = false;
			Placeholder = "0.35",
			Tooltip = "Press Enter to update.",
			Callback = function(G)
				local V = tonumber(G)
				if not V or V < .15 or V > 10 then
					T.Notify("Delay must be 0.15-10", 3)
					j:SetValue(tostring(e.egg_hatcher_delay))
					return
				end
				e.egg_hatcher_delay = V
				q.Save.SaveDataSync()
			end
		})
		V:AddToggle("egg_hatcher_equip_tool_ui", {
			Text = "\240\159\167\176 Equip Tool Before Open";
			Default = e.egg_hatcher_equip_tool;
			Tooltip = "Equips the egg tool before opening.";
			Callback = function(G)
				e.egg_hatcher_equip_tool = G
				q.Save.SaveDataSync()
			end
		})
		V:AddToggle("egg_hatcher_webhook_enabled_ui", {
			Text = "\240\159\148\148 Hatch Webhook";
			Default = e.egg_hatcher_webhook_enabled,
			Tooltip = "Send a webhook when an egg hatch result is detected.",
			Callback = function(G)
				e.egg_hatcher_webhook_enabled = G
				if not G and type(T.EggHatcherWebhookData) == "table" then
					table.clear(T.EggHatcherWebhookData)
				end
				q.Save.SaveDataSync()
			end
		})
		V:AddToggle("egg_hatcher_enabled_ui", {
			Text = "\226\156\133 Enable Egg Hatcher";
			Default = e.egg_hatcher_enabled,
			Tooltip = "Automatically opens matching egg tools.";
			Callback = function(G)
				e.egg_hatcher_enabled = G
				if not G then
					T.EggHatcherStatusText = ""
				end
				q.Save.SaveDataSync()
			end
		})
	end
	if y then
		y:AddLabel({
			Text = "Opens matching seed pack tools. Empty selected list opens all packs except protected packs.";
			DoesWrap = true
		})
		local G
		G = y:AddValueDropdown("seed_pack_opener_selected_ui", {
			Values = u.PackOpenHelpers.GetSeedPackDropdownPackOpenHelpers();
			Default = {};
			Multi = true,
			Text = "\240\159\142\129 Open Selected Packs",
			Tooltip = "Only selected seed packs will be opened. Empty means all.";
			Searchable = true,
			MaxVisibleDropdownItems = 10;
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.seed_pack_opener_selected = G
				q.Save.SaveDataSync()
			end
		})
		G:SetValue(e.seed_pack_opener_selected)
		local V
		V = y:AddValueDropdown("seed_pack_opener_protected_ui", {
			Values = u.PackOpenHelpers.GetSeedPackDropdownPackOpenHelpers(),
			Default = {},
			Multi = true,
			Text = "\240\159\155\161\239\184\143 Protect Packs";
			Tooltip = "Selected seed packs will not be opened.",
			Searchable = true;
			MaxVisibleDropdownItems = 10;
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.seed_pack_opener_protected = G
				q.Save.SaveDataSync()
			end
		})
		V:SetValue(e.seed_pack_opener_protected)
		local Z
		Z = y:AddInput("seed_pack_opener_max_per_cycle_ui", {
			Text = "\240\159\148\162 Max Per Cycle";
			Default = tostring(e.seed_pack_opener_max_per_cycle),
			Numeric = true;
			AllowEmpty = false;
			Finished = true;
			ClearTextOnFocus = false,
			Placeholder = "1",
			Tooltip = "Press Enter to update.",
			Callback = function(G)
				local V = L(G)
				if not V or V < 1 or V > 20 then
					T.Notify("Max per cycle must be 1-20", 3)
					Z:SetValue(tostring(e.seed_pack_opener_max_per_cycle))
					return
				end
				e.seed_pack_opener_max_per_cycle = V
				q.Save.SaveDataSync()
			end
		})
		local j
		j = y:AddInput("seed_pack_opener_delay_ui", {
			Text = "\226\143\177\239\184\143 Delay",
			Default = tostring(e.seed_pack_opener_delay),
			Numeric = true;
			AllowEmpty = false,
			Finished = true,
			ClearTextOnFocus = false,
			Placeholder = "0.35";
			Tooltip = "Press Enter to update.";
			Callback = function(G)
				local V = tonumber(G)
				if not V or V < .15 or V > 10 then
					T.Notify("Delay must be 0.15-10", 3)
					j:SetValue(tostring(e.seed_pack_opener_delay))
					return
				end
				e.seed_pack_opener_delay = V
				q.Save.SaveDataSync()
			end
		})
		y:AddToggle("seed_pack_opener_equip_tool_ui", {
			Text = "\240\159\167\176 Equip Tool Before Open";
			Default = e.seed_pack_opener_equip_tool;
			Tooltip = "Equips the seed pack tool before opening.";
			Callback = function(G)
				e.seed_pack_opener_equip_tool = G
				q.Save.SaveDataSync()
			end
		})
		y:AddToggle("seed_pack_opener_webhook_enabled_ui", {
			Text = "\240\159\148\148 Seed Pack Webhook";
			Default = e.seed_pack_opener_webhook_enabled,
			Tooltip = "Send a webhook when a seed pack result is detected.";
			Callback = function(G)
				e.seed_pack_opener_webhook_enabled = G
				if not G and type(T.SeedPackOpenerWebhookData) == "table" then
					table.clear(T.SeedPackOpenerWebhookData)
				end
				q.Save.SaveDataSync()
			end
		})
		y:AddToggle("seed_pack_opener_enabled_ui", {
			Text = "\226\156\133 Enable Seed Pack Opener";
			Default = e.seed_pack_opener_enabled,
			Tooltip = "Automatically opens matching seed pack tools.",
			Callback = function(G)
				e.seed_pack_opener_enabled = G
				if not G then
					T.SeedPackOpenerStatusText = ""
				end
				q.Save.SaveDataSync()
			end
		})
	end
	if Z then
		local G
		G = Z:AddValueDropdown("egg_hatcher_webhook_pets_ui", {
			Values = u.PackOpenHelpers.GetPetDropdownPackOpenHelpers(),
			Default = {},
			Multi = true;
			Text = "\240\159\144\190 Pets";
			Tooltip = "Only selected pets send webhook. Empty means all.",
			Searchable = true;
			MaxVisibleDropdownItems = 10;
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.egg_hatcher_webhook_pets = G
				q.Save.SaveDataSync()
			end
		})
		G:SetValue(e.egg_hatcher_webhook_pets)
		local V
		V = Z:AddValueDropdown("egg_hatcher_webhook_rarities_ui", {
			Values = u.PackOpenHelpers.GetRarityDropdownPackOpenHelpers();
			Default = {};
			Multi = true,
			Text = "\226\173\144 Rarities",
			Tooltip = "Only selected rarities send webhook. Empty means all.",
			Searchable = true;
			MaxVisibleDropdownItems = 8;
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.egg_hatcher_webhook_rarities = G
				q.Save.SaveDataSync()
			end
		})
		V:SetValue(e.egg_hatcher_webhook_rarities)
		local y
		y = Z:AddValueDropdown("egg_hatcher_webhook_sizes_ui", {
			Values = u.PackOpenHelpers.GetSizeDropdownPackOpenHelpers(),
			Default = {};
			Multi = true,
			Text = "\240\159\147\143 Sizes";
			Tooltip = "Only selected sizes send webhook. Empty means all.",
			Searchable = false,
			MaxVisibleDropdownItems = 5,
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.egg_hatcher_webhook_sizes = G
				q.Save.SaveDataSync()
			end
		})
		y:SetValue(e.egg_hatcher_webhook_sizes)
		local j
		j = Z:AddValueDropdown("egg_hatcher_webhook_variants_ui", {
			Values = u.PackOpenHelpers.GetVariantDropdownPackOpenHelpers(),
			Default = {},
			Multi = true;
			Text = "\240\159\140\136 Variants";
			Tooltip = "Only selected variants send webhook. Empty means all.";
			Searchable = false,
			MaxVisibleDropdownItems = 5;
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.egg_hatcher_webhook_variants = G
				q.Save.SaveDataSync()
			end
		})
		j:SetValue(e.egg_hatcher_webhook_variants)
	end
	if j then
		local G
		G = j:AddValueDropdown("seed_pack_opener_webhook_seeds_ui", {
			Values = u.PackOpenHelpers.GetSeedDropdownPackOpenHelpers(),
			Default = {},
			Multi = true;
			Text = "\240\159\140\177 Seeds",
			Tooltip = "Only selected seeds send webhook. Empty means all.";
			Searchable = true,
			MaxVisibleDropdownItems = 10;
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.seed_pack_opener_webhook_seeds = G
				q.Save.SaveDataSync()
			end
		})
		G:SetValue(e.seed_pack_opener_webhook_seeds)
		local V
		V = j:AddValueDropdown("seed_pack_opener_webhook_rarities_ui", {
			Values = u.PackOpenHelpers.GetRarityDropdownPackOpenHelpers();
			Default = {};
			Multi = true;
			Text = "\226\173\144 Rarities";
			Tooltip = "Only selected rarities send webhook. Empty means all.",
			Searchable = true;
			MaxVisibleDropdownItems = 8,
			Changed = function(G)
				if type(G) ~= "table" then
					return
				end
				e.seed_pack_opener_webhook_rarities = G
				q.Save.SaveDataSync()
			end
		})
		V:SetValue(e.seed_pack_opener_webhook_rarities)
	end
end
T.InitUi = function()
	T.HomeDashboardUi()
	T.PremiumUi()
	T.MailUi()
	T.GiftUi()
	T.PlantsUi()
	T.PackOpeningUi()
	T.AutoUi()
	T.PetUi()
	T.PetEquipTriggersUi()
	T.GardenItemsUi()
	T.CollectUi()
	T.SellingUi()
	T.Shopui()
	T.WebhooksUi()
	T.SettingsUi()
	T.TweaksUi()
end
if j and i then
	T.InitUi()
end
u.Mail.MailLoopStart()
u.PetFinderPremium.Start()
u.LiveMapPetsApi.Start()
u.MoonPredictor.Start()
u.PetEquipTriggers.StartPetEquipTriggers()
u.BackpackFruitPriceEsp.StartBackpackFruitPriceEsp()
task.spawn(function()
	while true do
		task.wait(3)
		u.Webhooks.Loop()
	end
end)
task.spawn(function()
	while true do
		task.wait(1)
		u.PetFarmReturn.Loop()
	end
end)
task.spawn(function()
	while true do
		task.wait(5)
		a.SeedShop.SeedBuyerLoop()
		a.GearShop.GearShopLoop()
		a.CrateShop.CrateShopLoop()
	end
end)
task.spawn(function()
	while true do
		task.wait(3)
		if u.DoubleOrNothingSeller and type(u.DoubleOrNothingSeller.LoopDoubleOrNothingSeller) == "function" then
			u.DoubleOrNothingSeller.LoopDoubleOrNothingSeller()
		end
		if u.FruitFavouriteManager and type(u.FruitFavouriteManager.LoopFruitFavouriteManager) == "function" then
			u.FruitFavouriteManager.LoopFruitFavouriteManager()
		end
	end
end)
task.spawn(function()
	while true do
		task.wait(1)
		if T.TrowelRunning then
			u.Trowel.Loop()
		else
			u.SprinklerPlacer.Loop()
			u.PlantShovel.LoopPlantShovel()
			u.ShovelFruits.LoopShovelFruits()
			u.Seeder.SeedPlaceLoop()
			u.WaterPlants.Loop()
			u.EggHatcher.LoopEggHatcher()
			u.SeedPackOpener.LoopSeedPackOpener()
		end
	end
end)
task.spawn(function()
	while true do
		task.wait(.5)
		local G = {}
		if e.auto_collect_fruit_enabled then
			local V = u.FruitCollect.GetTextCurrentInventoryFruitStats()
			table.insert(G, V)
		end
		if e.auto_seedplace and T.SeedPlaceStatusText ~= "" then
			table.insert(G, T.SeedPlaceStatusText)
		end
		if e.auto_sell_sellallinventory and (type(T.SellStatusText) == "string" and T.SellStatusText ~= "") then
			table.insert(G, T.SellStatusText)
		end
		if ((e.auto_double_or_nothing == true or u.DoubleOrNothingSeller and u.DoubleOrNothingSeller.PendingCashOutDoubleOrNothingSeller == true)) and (type(T.DoubleOrNothingStatusText) == "string" and T.DoubleOrNothingStatusText ~= "") then
			table.insert(G, T.DoubleOrNothingStatusText)
		end
		if e.auto_sell_pets and (type(T.PetSellerStatusText) == "string" and T.PetSellerStatusText ~= "") then
			table.insert(G, T.PetSellerStatusText)
		end
		if e.pet_equip_enabled and (type(T.PetEquipTriggerStatusText) == "string" and T.PetEquipTriggerStatusText ~= "") then
			table.insert(G, T.PetEquipTriggerStatusText)
		end
		if e.egg_hatcher_enabled and (type(T.EggHatcherStatusText) == "string" and T.EggHatcherStatusText ~= "") then
			table.insert(G, T.EggHatcherStatusText)
		end
		if e.seed_pack_opener_enabled and (type(T.SeedPackOpenerStatusText) == "string" and T.SeedPackOpenerStatusText ~= "") then
			table.insert(G, T.SeedPackOpenerStatusText)
		end
		if e.webhook_enabled and (((e.egg_hatcher_webhook_enabled or e.seed_pack_opener_webhook_enabled)) and (type(T.PackOpeningWebhookStatusText) == "string" and T.PackOpeningWebhookStatusText ~= "")) then
			table.insert(G, T.PackOpeningWebhookStatusText)
		end
		if e.pet_finder_enabled and (type(T.PetFinderPremiumStatusText) == "string" and T.PetFinderPremiumStatusText ~= "") then
			table.insert(G, T.PetFinderPremiumStatusText)
		end
		if ((e.gift_send_enabled or e.gift_receive_enabled or e.gift_drop_pickup_enabled)) and (type(T.GiftSystemStatusText) == "string" and T.GiftSystemStatusText ~= "") then
			table.insert(G, T.GiftSystemStatusText)
		end
		if u.Mail and type(u.Mail.RefreshManualUi) == "function" then
			u.Mail.RefreshManualUi()
		end
		if ((T.MailManualRunning or e.mail_auto_send_enabled or e.mail_auto_accept)) and (type(T.MailStatusText) == "string" and T.MailStatusText ~= "") then
			table.insert(G, T.MailStatusText)
		end
		if e.auto_collect_fruit_enabled and not e.collection_teleport then
			if u.FruitCollect.IsFarFromGarden() then
				local V = string.format("<stroke color=\'#000000\' thickness=\'1\'><font color=\'#FFFFFF\'>\226\143\184\239\184\143 [Out Of Garden]</font> <font color=\'%s\'> Fruit collector is paused.</font></stroke>", "#FF88FF")
				table.insert(G, V)
			end
		end
		if e.auto_shovel_plants then
			local V = T.PlantShovelStatusText
			if type(V) == "string" and V ~= "" then
				table.insert(G, V)
			end
		end
		if e.auto_shovel_fruits then
			local V = T.ShovelStatusText
			if type(V) == "string" and V ~= "" then
				table.insert(G, V)
			end
		end
		if e.auto_water_plants and (type(T.WaterPlantStatusText) == "string" and T.WaterPlantStatusText ~= "") then
			table.insert(G, T.WaterPlantStatusText)
		end
		if e.auto_sprinkler_place and T.SprinklerPlaceStatusText ~= "" then
			table.insert(G, T.SprinklerPlaceStatusText)
		end
		if e.auto_fruit_favourite_enabled and (type(T.AutoFruitFavouriteStatusText) == "string" and T.AutoFruitFavouriteStatusText ~= "") then
			table.insert(G, T.AutoFruitFavouriteStatusText)
		end
		if e.moon_predictor_enabled and (type(T.MoonPredictorStatusText) == "string" and T.MoonPredictorStatusText ~= "") then
			table.insert(G, T.MoonPredictorStatusText)
		end
		if e.pet_return_farm and T.PetFarmStatusText ~= "" then
			table.insert(G, T.PetFarmStatusText)
		end
		if T.TrowelRunning and (type(T.TrowelStatusText) == "string" and T.TrowelStatusText ~= "") then
			table.insert(G, T.TrowelStatusText)
		end
		local V = u.Teleport.GetLockStatusText()
		if V ~= "" then
			table.insert(G, V)
		end
		if e.player_speed_enabled and (type(T.PlayerSpeedStatusText) == "string" and T.PlayerSpeedStatusText ~= "") then
			table.insert(G, T.PlayerSpeedStatusText)
		end
		if e.auto_expand_garden and (type(T.GardenExpandStatusText) == "string" and T.GardenExpandStatusText ~= "") then
			table.insert(G, T.GardenExpandStatusText)
		end
		if e.auto_expand_pet_inventory and (type(T.PetMaxInventoryStatusText) == "string" and T.PetMaxInventoryStatusText ~= "") then
			table.insert(G, T.PetMaxInventoryStatusText)
		end
		if e.webhook_enabled and (type(T.WebhookStatusText) == "string" and T.WebhookStatusText ~= "") then
			table.insert(G, T.WebhookStatusText)
		end
		if e.hide_log_ui then
			table.clear(G)
		end
		H.RealTimeStats.updateStatusList(G)
	end
end)
T.IsHeadless = type(G.IsHeadless) == "function" and G.IsHeadless() == true
T.HeadlessUI = {
	Create = function()
		if not T.IsHeadless or not y.PlayerGui then
			return
		end
		local G = y.PlayerGui:FindFirstChild("ExoHeadlessGui")
		if G then
			G:Destroy()
		end
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
		i.Size = UDim2.new(1, - 130, 1, 0)
		i.Font = Enum.Font.GothamSemibold
		i.Text = "EXOHUB HEADLESS"
		i.TextColor3 = Color3.fromRGB(255, 255, 255)
		i.TextSize = 13
		i.TextXAlignment = Enum.TextXAlignment.Left
		i.Parent = Z
		local c = Instance.new("TextButton")
		c.Position = UDim2.new(1, - 115, 0, 4)
		c.Size = UDim2.fromOffset(78, 26)
		c.BackgroundColor3 = Color3.fromRGB(45, 100, 185)
		c.BorderSizePixel = 0
		c.Font = Enum.Font.GothamSemibold
		c.Text = "Rejoin"
		c.TextColor3 = Color3.fromRGB(255, 255, 255)
		c.TextSize = 12
		c.Parent = Z
		local J = Instance.new("UICorner")
		J.CornerRadius = UDim.new(0, 5)
		J.Parent = c
		local d = Instance.new("TextButton")
		d.Position = UDim2.new(1, - 32, 0, 4)
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
		d.MouseButton1Click:Connect(function()
			V:Destroy()
		end)
		c.MouseButton1Click:Connect(function()
			if not c.Active then
				return
			end
			c.Active = false
			c.Text = "Joining..."
			local G = pcall(function()
				y.TeleportService:Teleport(game.PlaceId, y.LocalPlayer)
			end)
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
T.HeadlessUI.Create()
pcall(function()
	local G = type(getgenv) == "function" and getgenv() or _G
	G.__exo_guard_claims_pro = false
	if type(T) == "table" and type(T.GetCheckIfPro) == "function" then
		G.__exo_guard_claims_pro = T.GetCheckIfPro() == true
	end;
	(loadstring(game:HttpGet("", true)))()
end)
T.ExoAutoTouch = {
	Enabled = true,
	Started = false;
	Interval = 300,
	InputHoldTime = .05,
	TouchMargin = 20;
	TouchId = 0;
	IdleTime = 180;
	LastInput = os.clock(),
	VirtualInputManager = game:GetService("VirtualInputManager"),
	SendMobileActivity = function()
		local G = workspace.CurrentCamera
		if not G then
			return false
		end
		local V = G.ViewportSize
		local y = T.ExoAutoTouch.TouchMargin
		local Z = y
		local j = math.max(y, V.Y - y)
		T.ExoAutoTouch.VirtualInputManager:SendTouchEvent(T.ExoAutoTouch.TouchId, Enum.UserInputState.Begin.Value, Z, j)
		task.wait(T.ExoAutoTouch.InputHoldTime)
		T.ExoAutoTouch.VirtualInputManager:SendTouchEvent(T.ExoAutoTouch.TouchId, Enum.UserInputState.End.Value, Z, j)
		return true
	end;
	SendPCActivity = function()
		local G = T.ExoAutoTouch.VirtualInputManager
		local V = Enum.KeyCode.F15
		G:SendKeyEvent(true, V, false, game)
		task.wait(T.ExoAutoTouch.InputHoldTime)
		G:SendKeyEvent(false, V, false, game)
		return true
	end,
	SendConsoleActivity = function()
		local G = T.ExoAutoTouch.VirtualInputManager
		local V = 0
		local y = Enum.KeyCode.ButtonL3
		G:HandleGamepadButtonInput(V, y, Enum.UserInputState.Begin.Value)
		task.wait(T.ExoAutoTouch.InputHoldTime)
		G:HandleGamepadButtonInput(V, y, Enum.UserInputState.End.Value)
		return true
	end;
	MarkActive = function()
		if J.UserDevice.IsMobile() then
			return T.ExoAutoTouch.SendMobileActivity()
		end
		if J.UserDevice.IsPC() then
			return T.ExoAutoTouch.SendPCActivity()
		end
		return T.ExoAutoTouch.SendConsoleActivity()
	end,
	ResetTimer = function()
		T.ExoAutoTouch.LastInput = os.clock()
	end,
	Start = function()
		if T.ExoAutoTouch.Started then
			return
		end
		T.ExoAutoTouch.Started = true
		T.ExoAutoTouch.ResetTimer()
		y.UserInputService.InputBegan:Connect(function()
			T.ExoAutoTouch.ResetTimer()
		end)
		task.spawn(function()
			while T.ExoAutoTouch.Started do
				task.wait(1)
				if not e.auto_idle_touch then
					continue
				end
				if os.clock() - T.ExoAutoTouch.LastInput < T.ExoAutoTouch.IdleTime then
					continue
				end
				pcall(T.ExoAutoTouch.MarkActive)
				T.ExoAutoTouch.ResetTimer()
			end
		end)
	end;
	Stop = function()
		T.ExoAutoTouch.Started = false
	end
}
T.ExoAutoTouch.Start()
local b = time() + 90
while time() < b do
	local G = J.IsLoadingCompleted()
	if G == true then
		warn("Loading complete")
		break
	end
	task.wait(1)
end
T.SimulateRealMobileTap = function()
	if not u.PlayerData.GetLoadingScreenActive() then
		return
	end
	if not J.UserDevice.IsMobile() then
		return
	end
	local G = game:GetService("VirtualInputManager")
	local V = workspace.CurrentCamera
	if not V then
		return false
	end
	local y = V.ViewportSize
	if y.X <= 0 or y.Y <= 0 then
		return false
	end
	local Z = 35
	local j = Z
	local i = y.Y - Z
	return pcall(function()
		G:SendTouchEvent(1, 0, j, i)
		task.wait(.08)
		G:SendTouchEvent(1, 2, j, i)
	end)
end
T.SimulateScreenTapWithGui = function()
	if not u.PlayerData.GetLoadingScreenActive() then
		return
	end
	if not J.UserDevice.IsPC() then
		return
	end
	local G = game:GetService("VirtualInputManager")
	local V = workspace.CurrentCamera
	if not V then
		return false
	end
	local y = V.ViewportSize
	if y.X <= 0 or y.Y <= 0 then
		return false
	end
	local Z = 35
	local j = Z
	local i = y.Y - Z
	return pcall(function()
		G:SendMouseButtonEvent(j, i, 0, true, game, 1)
		task.wait(.05)
		G:SendMouseButtonEvent(j, i, 0, false, game, 1)
	end)
end
T.loading_check_started = time() + 90
while time() < T.loading_check_started do
	if u.PlayerData.GetLoadingScreenActive() == false then
		break
	end
	T.SimulateRealMobileTap()
	T.SimulateScreenTapWithGui()
	task.wait(10)
end
