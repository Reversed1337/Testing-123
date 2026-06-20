-- Server Hopper | Teleports to a random non-full server after 20 minutes
-- Works in executor environments (Delta, Synapse, etc.)

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local TIMER_DURATION = 20 * 60 -- 20 minutes in seconds

-- Remove existing GUI if re-running
local existing = PlayerGui:FindFirstChild("ServerHopperGui")
if existing then existing:Destroy() end

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ServerHopperGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 60)
Frame.Position = UDim2.new(1, -215, 0, 15)
Frame.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 8)
Corner.Parent = Frame

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(80, 80, 180)
Stroke.Thickness = 1.5
Stroke.Parent = Frame

local Label = Instance.new("TextLabel")
Label.Size = UDim2.new(1, 0, 0.45, 0)
Label.Position = UDim2.new(0, 0, 0.05, 0)
Label.BackgroundTransparency = 1
Label.Text = "⏱ SERVER HOP"
Label.TextColor3 = Color3.fromRGB(130, 130, 220)
Label.TextScaled = true
Label.Font = Enum.Font.GothamBold
Label.Parent = Frame

local TimerLabel = Instance.new("TextLabel")
TimerLabel.Size = UDim2.new(1, 0, 0.45, 0)
TimerLabel.Position = UDim2.new(0, 0, 0.52, 0)
TimerLabel.BackgroundTransparency = 1
TimerLabel.Text = "20:00"
TimerLabel.TextColor3 = Color3.fromRGB(230, 230, 255)
TimerLabel.TextScaled = true
TimerLabel.Font = Enum.Font.GothamSemibold
TimerLabel.Parent = Frame

-- Dragging
local dragging, dragInput, dragStart, startPos

Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- Fetch a random non-full server's jobId
local function getRandomOpenServer()
    local placeId = game.PlaceId
    local currentJobId = game.JobId
    local cursor = ""
    local attempts = 0
    local maxAttempts = 5

    repeat
        attempts += 1
        local url = string.format(
            "https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100",
            placeId
        )
        if cursor ~= "" then
            url = url .. "&cursor=" .. cursor
        end

        local success, response = pcall(function()
            return game:HttpGet(url)
        end)

        if not success then
            warn("[ServerHopper] HttpGet failed: " .. tostring(response))
            return nil
        end

        local parsed = HttpService:JSONDecode(response)
        local servers = parsed and parsed.data

        if not servers or #servers == 0 then
            warn("[ServerHopper] No servers found.")
            return nil
        end

        -- Filter: not full, not our current server
        local openServers = {}
        for _, server in ipairs(servers) do
            if server.playing ~= nil and server.maxPlayers ~= nil then
                if server.playing < server.maxPlayers and server.id ~= currentJobId then
                    table.insert(openServers, server)
                end
            end
        end

        if #openServers > 0 then
            local picked = openServers[math.random(1, #openServers)]
            return picked.id
        end

        -- Try next page if available
        cursor = parsed.nextPageCursor or ""

    until cursor == "" or attempts >= maxAttempts

    warn("[ServerHopper] Could not find an open server after " .. attempts .. " pages.")
    return nil
end

-- Countdown & Hop Logic
local timeLeft = TIMER_DURATION

local connection
connection = RunService.Heartbeat:Connect(function(dt)
    timeLeft = timeLeft - dt

    if timeLeft <= 0 then
        connection:Disconnect()
        TimerLabel.Text = "SEARCHING..."
        TimerLabel.TextColor3 = Color3.fromRGB(220, 200, 80)
        Label.Text = "🔍 FINDING"

        task.spawn(function()
            local jobId = getRandomOpenServer()

            if jobId then
                TimerLabel.Text = "HOPPING..."
                TimerLabel.TextColor3 = Color3.fromRGB(100, 220, 100)
                Label.Text = "✓ FOUND"
                task.wait(0.3)

                local ok, err = pcall(function()
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, jobId, LocalPlayer)
                end)

                if not ok then
                    warn("[ServerHopper] Teleport failed: " .. tostring(err))
                    TimerLabel.Text = "FAILED"
                    TimerLabel.TextColor3 = Color3.fromRGB(220, 80, 80)
                    Label.Text = "✗ ERROR"
                end
            else
                -- Fallback: just hop to any server if API fails
                TimerLabel.Text = "FALLBACK..."
                TimerLabel.TextColor3 = Color3.fromRGB(220, 150, 80)
                Label.Text = "⚠ FALLBACK"
                task.wait(0.3)
                pcall(function()
                    TeleportService:Teleport(game.PlaceId, LocalPlayer)
                end)
            end
        end)

        return
    end

    local mins = math.floor(timeLeft / 60)
    local secs = math.floor(timeLeft % 60)
    TimerLabel.Text = string.format("%02d:%02d", mins, secs)

    -- Turn red in last 60 seconds
    if timeLeft <= 60 then
        local t = timeLeft / 60
        TimerLabel.TextColor3 = Color3.fromRGB(220, 80 + math.floor(t * 150), 80)
    end
end)

print("[ServerHopper] Started — will hop to a non-full server in 20 minutes.")
