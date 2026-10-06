-- =========================================================
-- ONE W - MAROON GUI
-- Section 1/12 : Load Library + Theme + Toggle C + Window
-- =========================================================

-- LOAD LIBRARY OBSIDIAN
local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

-- =========================================================
-- THEME MAROON
-- =========================================================
Library.Scheme.AccentColor     = Color3.fromRGB(180, 30, 40)
Library.Scheme.BackgroundColor = Color3.fromRGB(45, 8, 12)
Library.Scheme.MainColor       = Color3.fromRGB(60, 12, 18)
Library.Scheme.OutlineColor    = Color3.fromRGB(120, 30, 40)
Library.Scheme.FontColor       = Color3.fromRGB(240, 220, 220)

-- =========================================================
-- SERVICES
-- =========================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local Stats = game:GetService("Stats")
local GuiService = game:GetService("GuiService")
local SoundService = game:GetService("SoundService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

-- =========================================================
-- TOGGLE BUTTON "C" (Compact + Glow Effect)
-- =========================================================
local function CreateToggleMenu()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "OneWToggle"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local success = pcall(function()
        ScreenGui.Parent = game:GetService("CoreGui")
    end)
    if not success then
        ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end

    local MainButton = Instance.new("TextButton")
    MainButton.Name = "ToggleButton"
    MainButton.Text = "C"
    MainButton.TextColor3 = Color3.fromRGB(220, 50, 60)
    MainButton.TextSize = 18
    MainButton.Font = Enum.Font.GothamBlack
    MainButton.AutoButtonColor = false
    MainButton.Size = UDim2.fromOffset(34, 34)
    MainButton.Position = UDim2.fromOffset(15, 120)
    MainButton.BackgroundColor3 = Color3.fromRGB(45, 8, 12)
    MainButton.BackgroundTransparency = 0.05
    MainButton.Parent = ScreenGui

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(1, 0)
    Corner.Parent = MainButton

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(180, 30, 40)
    Stroke.Thickness = 1.5
    Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    Stroke.Parent = MainButton

    -- Glow Effect (pulse)
    local Glow = Instance.new("UIStroke")
    Glow.Color = Color3.fromRGB(220, 50, 60)
    Glow.Thickness = 4
    Glow.Transparency = 0.7
    Glow.Parent = MainButton

    -- Animasi glow
    task.spawn(function()
        local t = 0
        while MainButton.Parent do
            t = t + 0.04
            Glow.Transparency = 0.7 - math.abs(math.sin(t * 1.5)) * 0.35
            MainButton.TextColor3 = Color3.fromRGB(
                200 + math.sin(t) * 20,
                40 + math.sin(t * 1.2) * 15,
                50 + math.sin(t * 0.8) * 15
            )
            task.wait(0.04)
        end
    end)

    -- Hover effect
    MainButton.MouseEnter:Connect(function()
        TweenService:Create(MainButton, TweenInfo.new(.15), {
            BackgroundColor3 = Color3.fromRGB(60, 12, 18),
            Size = UDim2.fromOffset(36, 36)
        }):Play()
    end)

    MainButton.MouseLeave:Connect(function()
        TweenService:Create(MainButton, TweenInfo.new(.15), {
            BackgroundColor3 = Color3.fromRGB(45, 8, 12),
            Size = UDim2.fromOffset(34, 34)
        }):Play()
    end)

    -- Click animation
    MainButton.MouseButton1Click:Connect(function()
        TweenService:Create(MainButton, TweenInfo.new(.08), {
            Size = UDim2.fromOffset(30, 30)
        }):Play()

        task.wait(.08)

        TweenService:Create(MainButton, TweenInfo.new(.08), {
            Size = UDim2.fromOffset(34, 34)
        }):Play()

        Library:Toggle()
    end)

    Library:MakeDraggable(MainButton, MainButton, true)
end

CreateToggleMenu()

-- =========================================================
-- WINDOW (COMPACT)
-- =========================================================
local Window = Library:CreateWindow({
    Title = "One W",
    Footer = "One W",
    Icon = nil,
    IconSize = UDim2.fromOffset(0, 0),
    CornerRadius = 18,
    NotifySide = "Right",
    ShowCustomCursor = true,
    ShowMobileButtons = false,
    ToggleKeybind = Enum.KeyCode.LeftControl,
    Size = UDim2.fromOffset(480, 340),
    EnableSidebarResize = false,
    EnableCompacting = true,
    SidebarCompacted = true,
})

-- =========================================================
-- WATERMARK
-- =========================================================
local Watermark = Library:AddDraggableLabel("One W")

local FPS = 0
local Frames = 0
local LastTick = tick()

RunService.RenderStepped:Connect(function()
    Frames += 1
    if tick() - LastTick >= 1 then
        FPS = Frames
        Frames = 0
        LastTick = tick()
        local Ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        Watermark:SetText(string.format("One W | FPS: %d | PING: %d ms", FPS, Ping))
    end
end)

-- =========================================================
-- TABS
-- =========================================================
local Tabs = {
    ESP = Window:AddTab("ESP", "eye"),
    Combat = Window:AddTab("Combat", "swords"),
    Killer = Window:AddTab("Killer", "skull"),
    Survival = Window:AddTab("Survival", "heart"),
    Character = Window:AddTab("Character", "user"),
    Visual = Window:AddTab("Visual", "sparkles"),
    Misc = Window:AddTab("Misc", "sliders-horizontal"),
    Extras = Window:AddTab("Extras", "gift"),
    UISettings = Window:AddTab("UI Settings", "settings-2"),
}

-- =========================================================
-- GLOBAL CONFIG
-- =========================================================
local Config = {
    -- ESP
    ESP = {
        Enabled = false,
        Survivor = false,
        Killer = false,
        Generator = false,
        Pallet = false,
        Window = false,
        SCP = false,
        Distance = 200,
        Transparency = 7,
        NamePlayer = false,
        NameGenerator = false,
    },

    ESPColors = {
        Survivor = Color3.fromRGB(60, 255, 120),
        Killer = Color3.fromRGB(255, 60, 60),
        Generator = Color3.fromRGB(255, 220, 80),
        Pallet = Color3.fromRGB(60, 255, 120),
        Window = Color3.fromRGB(60, 150, 255),
        SCP = Color3.fromRGB(150, 80, 220),
    },
}

print("")
print("═══════════════════════════════════════════")
print("  🔴 ONE W - MAROON GUI")
print("  🎯 Klik tombol C buat buka menu")
print("  ⌨️  LeftCtrl buat toggle keyboard")
print("  📦 Section 1/12 Loaded")
print("═══════════════════════════════════════════")
print("")-- =========================================================
-- SECTION 2/12 : ESP SYSTEM + TAB ESP
-- =========================================================

-- =========================================================
-- ESP SYSTEM
-- =========================================================
local ESPObjects = {}
local Cached = { Generators = {}, Windows = {}, Pallets = {}, SCP = {} }

local function removeESP(obj)
    if ESPObjects[obj] then
        ESPObjects[obj]:Destroy()
        ESPObjects[obj] = nil
    end
end

local function createESP(obj, color, transparency)
    if not obj then return end
    transparency = transparency or 0.9
    if ESPObjects[obj] then
        ESPObjects[obj].FillColor = color
        ESPObjects[obj].OutlineColor = color
        ESPObjects[obj].FillTransparency = transparency
        return
    end
    local h = Instance.new("Highlight")
    h.FillColor = color
    h.OutlineColor = color
    h.FillTransparency = transparency
    h.OutlineTransparency = 0.3
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Parent = obj
    ESPObjects[obj] = h
end

-- Cache semua object
for _, obj in ipairs(workspace:GetDescendants()) do
    if obj.Name == "Generator" then Cached.Generators[obj] = true
    elseif obj.Name == "Window" then Cached.Windows[obj] = true
    elseif obj.Name == "Pallet" or obj.Name == "Palletwrong" then Cached.Pallets[obj] = true
    end
    if string.find(string.lower(obj.Name), "scp") then Cached.SCP[obj] = true end
end

workspace.DescendantAdded:Connect(function(obj)
    if obj.Name == "Generator" then Cached.Generators[obj] = true
    elseif obj.Name == "Window" then Cached.Windows[obj] = true
    elseif obj.Name == "Pallet" or obj.Name == "Palletwrong" then Cached.Pallets[obj] = true
    end
    if string.find(string.lower(obj.Name), "scp") then Cached.SCP[obj] = true end
end)

workspace.DescendantRemoving:Connect(function(obj)
    Cached.Generators[obj] = nil
    Cached.Windows[obj] = nil
    Cached.Pallets[obj] = nil
    Cached.SCP[obj] = nil
    removeESP(obj)
end)

-- =========================================================
-- STATUS ESP (Billboard Name/HP/Dist)
-- =========================================================
local StatusESP = {}

local function removeStatusESP(char)
    if StatusESP[char] then
        StatusESP[char]:Destroy()
        StatusESP[char] = nil
    end
end

local function createStatusESP(player, char, root)
    if not Config.ESP.NamePlayer and not Config.ESP.NameGenerator then
        removeStatusESP(char)
        return
    end

    if not root then return end

    local head = char:FindFirstChild("Head")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not head or not hum then return end

    local dist = (head.Position - root.Position).Magnitude
    if dist > Config.ESP.Distance then
        removeStatusESP(char)
        return
    end

    local text = ""
    if Config.ESP.NamePlayer then
        text = text .. player.Name .. "\n"
    end
    if Config.ESP.NameGenerator then
        text = text .. string.format("Dist: %.0f | HP: %.0f", dist, hum.Health)
    end

    if text == "" then
        removeStatusESP(char)
        return
    end

    local billboard = StatusESP[char]
    if not billboard then
        billboard = Instance.new("BillboardGui")
        billboard.Size = UDim2.new(0, 140, 0, 40)
        billboard.AlwaysOnTop = true
        billboard.StudsOffset = Vector3.new(0, 2.5, 0)

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.TextStrokeTransparency = 0
        label.Font = Enum.Font.GothamBold
        label.TextSize = 11
        label.Text = text
        label.Parent = billboard

        billboard.Adornee = head
        billboard.Parent = char
        StatusESP[char] = billboard
    else
        local label = billboard:FindFirstChildOfClass("TextLabel")
        if label then label.Text = text end
    end

    -- Warna team
    local label = billboard:FindFirstChildOfClass("TextLabel")
    if label then
        if player.Team and player.Team.Name == "Killer" then
            label.TextColor3 = Config.ESPColors.Killer
        elseif player.Team and player.Team.Name == "Survivors" then
            label.TextColor3 = Config.ESPColors.Survivor
        else
            label.TextColor3 = Color3.new(1, 1, 1)
        end
    end
end

-- =========================================================
-- ESP MAIN LOOP
-- =========================================================
task.spawn(function()
    while task.wait(0.15) do
        if not Config.ESP.Enabled then
            for obj in pairs(ESPObjects) do removeESP(obj) end
            for char in pairs(StatusESP) do removeStatusESP(char) end
            continue
        end

        local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not myRoot then continue end

        local transp = 1 - (Config.ESP.Transparency / 10)

        -- Player ESP
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local char = p.Character
                local hum = char:FindFirstChildOfClass("Humanoid")
                local hrp = char:FindFirstChild("HumanoidRootPart")

                if hum and hum.Health > 0 and hrp then
                    local dist = (hrp.Position - myRoot.Position).Magnitude
                    if dist <= Config.ESP.Distance then
                        if Config.ESP.Survivor and p.Team and p.Team.Name == "Survivors" then
                            createESP(char, Config.ESPColors.Survivor, transp)
                        elseif Config.ESP.Killer and p.Team and p.Team.Name == "Killer" then
                            createESP(char, Config.ESPColors.Killer, transp)
                        else
                            removeESP(char)
                        end
                    else
                        removeESP(char)
                    end
                    createStatusESP(p, char, myRoot)
                else
                    removeESP(char)
                    removeStatusESP(char)
                end
            end
        end

        -- Generator
        if Config.ESP.Generator then
            for gen in pairs(Cached.Generators) do
                if gen and gen.Parent then
                    local pos = gen:IsA("Model") and gen:GetPivot().Position or gen.Position
                    local dist = (pos - myRoot.Position).Magnitude
                    if dist <= Config.ESP.Distance then
                        createESP(gen, Config.ESPColors.Generator, transp)
                    else
                        removeESP(gen)
                    end
                end
            end
        else
            for gen in pairs(Cached.Generators) do removeESP(gen) end
        end

        -- Pallet
        if Config.ESP.Pallet then
            for obj in pairs(Cached.Pallets) do
                if obj and obj.Parent then
                    local pos = obj:IsA("Model") and obj:GetPivot().Position or obj.Position
                    local dist = (pos - myRoot.Position).Magnitude
                    if dist <= Config.ESP.Distance then
                        createESP(obj, Config.ESPColors.Pallet, transp)
                    else
                        removeESP(obj)
                    end
                end
            end
        else
            for obj in pairs(Cached.Pallets) do removeESP(obj) end
        end

        -- Window
        if Config.ESP.Window then
            for obj in pairs(Cached.Windows) do
                if obj and obj.Parent then
                    local pos = obj:IsA("Model") and obj:GetPivot().Position or obj.Position
                    local dist = (pos - myRoot.Position).Magnitude
                    if dist <= Config.ESP.Distance then
                        createESP(obj, Config.ESPColors.Window, transp)
                    else
                        removeESP(obj)
                    end
                end
            end
        else
            for obj in pairs(Cached.Windows) do removeESP(obj) end
        end

        -- SCP
        if Config.ESP.SCP then
            for obj in pairs(Cached.SCP) do
                if obj and obj.Parent then
                    local pos = obj:IsA("Model") and obj:GetPivot().Position or obj.Position
                    local dist = (pos - myRoot.Position).Magnitude
                    if dist <= Config.ESP.Distance then
                        createESP(obj, Config.ESPColors.SCP, transp)
                    else
                        removeESP(obj)
                    end
                end
            end
        else
            for obj in pairs(Cached.SCP) do removeESP(obj) end
        end
    end
end)

-- =========================================================
-- TAB ESP - UI
-- =========================================================
local ESPBox = Tabs.ESP:AddLeftGroupbox("ESP Control", "scan-eye")
local TargetBox = Tabs.ESP:AddRightGroupbox("Target", "target")

-- KIRI: ESP Control
ESPBox:AddCheckbox("ESP_Enabled", {
    Text = "Aktifkan ESP",
    Default = false,
    Callback = function(v) Config.ESP.Enabled = v end
})

ESPBox:AddSlider("ESP_Distance", {
    Text = "ESP Distance",
    Default = 200,
    Min = 10,
    Max = 500,
    Rounding = 0,
    Callback = function(v) Config.ESP.Distance = v end
})

ESPBox:AddSlider("ESP_Transparency", {
    Text = "ESP Transparency",
    Default = 7,
    Min = 0,
    Max = 10,
    Rounding = 0,
    Callback = function(v) Config.ESP.Transparency = v end
})

ESPBox:AddCheckbox("ESP_NamePlayer", {
    Text = "Name Player",
    Default = false,
    Callback = function(v) Config.ESP.NamePlayer = v end
})

ESPBox:AddCheckbox("ESP_NameGenerator", {
    Text = "Name Generator",
    Default = false,
    Callback = function(v) Config.ESP.NameGenerator = v end
})

-- KANAN: Target
TargetBox:AddCheckbox("ESP_Survivor", {
    Text = "Survivor",
    Default = false,
    Callback = function(v) Config.ESP.Survivor = v end
})

TargetBox:AddColorPicker("ESP_SurvivorColor", {
    Default = Config.ESPColors.Survivor,
    Title = "Survivor Color",
    Callback = function(c) Config.ESPColors.Survivor = c end
})

TargetBox:AddCheckbox("ESP_Killer", {
    Text = "Killer",
    Default = false,
    Callback = function(v) Config.ESP.Killer = v end
})

TargetBox:AddColorPicker("ESP_KillerColor", {
    Default = Config.ESPColors.Killer,
    Title = "Killer Color",
    Callback = function(c) Config.ESPColors.Killer = c end
})

TargetBox:AddCheckbox("ESP_Generator", {
    Text = "Generator",
    Default = false,
    Callback = function(v) Config.ESP.Generator = v end
})

TargetBox:AddColorPicker("ESP_GeneratorColor", {
    Default = Config.ESPColors.Generator,
    Title = "Generator Color",
    Callback = function(c) Config.ESPColors.Generator = c end
})

TargetBox:AddCheckbox("ESP_Pallet", {
    Text = "Pallet",
    Default = false,
    Callback = function(v) Config.ESP.Pallet = v end
})

TargetBox:AddColorPicker("ESP_PalletColor", {
    Default = Config.ESPColors.Pallet,
    Title = "Pallet Color",
    Callback = function(c) Config.ESPColors.Pallet = c end
})

TargetBox:AddCheckbox("ESP_Window", {
    Text = "Window / Vault",
    Default = false,
    Callback = function(v) Config.ESP.Window = v end
})

TargetBox:AddColorPicker("ESP_WindowColor", {
    Default = Config.ESPColors.Window,
    Title = "Window Color",
    Callback = function(c) Config.ESPColors.Window = c end
})

TargetBox:AddCheckbox("ESP_SCP", {
    Text = "SCP / Zombie",
    Default = false,
    Callback = function(v) Config.ESP.SCP = v end
})

TargetBox:AddColorPicker("ESP_SCPColor", {
    Default = Config.ESPColors.SCP,
    Title = "SCP Color",
    Callback = function(c) Config.ESPColors.SCP = c end
})

print("✅ [2/12] One W - ESP System + Tab ESP Loaded")-- =========================================================
-- SECTION 3/12 : COMBAT TAB
-- Auto Parry + Aimbot Senter + Skill Check + Wiggle
-- =========================================================

-- =========================================================
-- KILLER ANIMS LIST (buat Auto Parry)
-- =========================================================
local KillerAnims = {}
for _, id in ipairs({
    "105374834496520","113255068724446","118907603246885","129784271201071",
    "117042998468241","122812055447896","78935059863801","74968262036854",
    "78432063483146","132817836308238","133963973694098","111920872708571",
    "80411309607666","98163597193511","82666958311998","110355011987939",
    "139369275981139","135002183282873","121216847022485","130593238885843",
    "117070354890871","106871536134254","138720291317243"
}) do
    KillerAnims["rbxassetid://"..id] = true
end

local SkipAnims = {
    ["112166042383605"] = "Break Pallet",
    ["123047897844134"] = "Stun",
    ["126965695851149"] = "WalkCrouch",
    ["135084204086504"] = "WalkCrouch Injured",
    ["127096285501517"] = "Parry Anim",
}

-- =========================================================
-- AUTO PARRY SYSTEM
-- =========================================================
local AutoParry = {
    Enabled = false,
    ParryDistance = 15,
    Debounce = 0.05,
    FaceSensitivity = 0.3,
    ShowCircle = false,
    CircleColor = Color3.fromRGB(255, 80, 80),
    ParryCount = 0,
}

local lastParry = 0
local hookedKillers = {}

local function GetParryButton()
    local current = PlayerGui
    for segment in string.gmatch("Survivor-mob.Controls.Gui-mob", "[^%.]+") do
        current = current and current:FindFirstChild(segment)
    end
    return current
end

local function pressRightClick()
    VirtualInputManager:SendMouseButtonEvent(0, 0, 1, true, game, 0)
    task.wait(0.001)
    VirtualInputManager:SendMouseButtonEvent(0, 0, 1, false, game, 0)
end

local function pressParryButton()
    if UserInputService.TouchEnabled then
        local btn = GetParryButton()
        if btn and btn:IsA("GuiObject") then
            local pos = btn.AbsolutePosition
            local size = btn.AbsoluteSize
            local inset = GuiService:GetGuiInset()
            local x = pos.X + size.X/2 + inset.X
            local y = pos.Y + size.Y/2 + inset.Y
            VirtualInputManager:SendTouchEvent(8823, 0, x, y)
            task.wait(0.005)
            VirtualInputManager:SendTouchEvent(8823, 2, x, y)
            return
        end
    end
    pressRightClick()
end

local function doParry()
    local now = tick()
    if now - lastParry < AutoParry.Debounce then return end
    lastParry = now
    pressParryButton()
    AutoParry.ParryCount = AutoParry.ParryCount + 1
end

local function getRoot()
    local char = LocalPlayer.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function isInParryRange(killerChar)
    local myRoot = getRoot()
    if not myRoot or not killerChar then return false end
    local enemyRoot = killerChar:FindFirstChild("HumanoidRootPart")
    if not enemyRoot then return false end
    local dist = (enemyRoot.Position - myRoot.Position).Magnitude
    return dist <= AutoParry.ParryDistance
end

local function isFacingTarget(targetChar)
    if AutoParry.FaceSensitivity <= -1 then return true end
    local myChar = LocalPlayer.Character
    if not myChar then return false end
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    local enemyRoot = targetChar:FindFirstChild("HumanoidRootPart")
    if not myRoot or not enemyRoot then return false end

    local enemyForward = enemyRoot.CFrame.LookVector
    local directionToMe = (myRoot.Position - enemyRoot.Position).Unit
    local dot = enemyForward:Dot(directionToMe)
    return dot >= AutoParry.FaceSensitivity
end

local function hookKiller(char)
    if hookedKillers[char] then return end
    hookedKillers[char] = true

    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local animator = hum:FindFirstChildOfClass("Animator")
    if not animator then return end

    animator.AnimationPlayed:Connect(function(track)
        if not AutoParry.Enabled then return end
        local anim = track.Animation
        if not anim or not anim.AnimationId then return end
        local id = anim.AnimationId:match("%d+")
        if not id then return end
        if SkipAnims[id] then return end

        local fullId = "rbxassetid://" .. id
        if KillerAnims[fullId] then
            if not isInParryRange(char) then return end
            if not isFacingTarget(char) then return end
            doParry()
        end
    end)
end

-- Hook + scan
task.spawn(function()
    while task.wait(0.8) do
        if AutoParry.Enabled then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Team and p.Team.Name == "Killer" then
                    hookKiller(p.Character)
                end
            end
        end
    end
end)

-- Parry circle visual
local ParryCircle = nil
local function updateParryCircle()
    local root = getRoot()
    if not AutoParry.ShowCircle or not root then
        if ParryCircle then ParryCircle:Destroy(); ParryCircle = nil end
        return
    end

    if not ParryCircle then
        ParryCircle = Instance.new("Part")
        ParryCircle.Shape = Enum.PartType.Cylinder
        ParryCircle.Anchored = true
        ParryCircle.CanCollide = false
        ParryCircle.Material = Enum.Material.Neon
        ParryCircle.Name = "ParryRangeCircle"
        ParryCircle.Transparency = 0.9
        ParryCircle.Parent = workspace
    end

    local size = AutoParry.ParryDistance * 2
    ParryCircle.Size = Vector3.new(0.2, size, size)
    local yOffset = root.Size.Y / 2 + 1.5
    ParryCircle.CFrame = CFrame.new(root.Position - Vector3.new(0, yOffset, 0)) * CFrame.Angles(0, 0, math.rad(90))
    ParryCircle.Color = AutoParry.CircleColor
end

RunService.RenderStepped:Connect(function()
    updateParryCircle()
end)

-- =========================================================
-- AIMBOT SENTER (HOLD TO AIM)
-- =========================================================
local AimbotSenter = {
    Enabled = false,
    Holding = false,
    Radius = 99999,
    LockPart = "Head",
    Smoothness = 0.5,
    ShowLaser = true,
    LaserColor = Color3.fromRGB(255, 0, 0),
    CurrentTarget = nil,
}

local AimbotLaserLines = {}
local AimbotLaserGui = nil

local function getLaserGui()
    if AimbotLaserGui and AimbotLaserGui.Parent then return AimbotLaserGui end
    AimbotLaserGui = Instance.new("ScreenGui")
    AimbotLaserGui.Name = "OneWLaserESP"
    AimbotLaserGui.ResetOnSpawn = false
    AimbotLaserGui.IgnoreGuiInset = true
    AimbotLaserGui.Parent = PlayerGui
    return AimbotLaserGui
end

local function clearLaser()
    for _, line in pairs(AimbotLaserLines) do
        if line then line:Remove() end
    end
    AimbotLaserLines = {}
end

-- Hook tombol senter
local function HookSenterButton()
    for _, obj in pairs(PlayerGui:GetDescendants()) do
        if obj:IsA("GuiObject") and obj.Visible then
            local n = string.lower(obj.Name)
            if (n:find("dagger") or n:find("senter") or n:find("flashlight")
                or n:find("light") or n:find("torch") or n:find("knife")
                or n:find("blade"))
                and not obj:GetAttribute("OneWSenterHooked") then
                obj:SetAttribute("OneWSenterHooked", true)

                obj.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1
                        or input.UserInputType == Enum.UserInputType.Touch then
                        AimbotSenter.Holding = true
                    end
                end)

                obj.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1
                        or input.UserInputType == Enum.UserInputType.Touch then
                        AimbotSenter.Holding = false
                        AimbotSenter.CurrentTarget = nil
                    end
                end)

                obj.MouseLeave:Connect(function()
                    AimbotSenter.Holding = false
                    AimbotSenter.CurrentTarget = nil
                end)
            end
        end
    end
end

-- Loop Aimbot Senter (HOLD TO AIM)
RunService.RenderStepped:Connect(function()
    if not AimbotSenter.Enabled then
        AimbotSenter.CurrentTarget = nil
        clearLaser()
        return
    end

    if not AimbotSenter.Holding then
        AimbotSenter.CurrentTarget = nil
        clearLaser()
        return
    end

    local myRoot = getRoot()
    if not myRoot then return end

    local closest = nil
    local shortest = math.huge

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Team and p.Team.Name == "Killer" then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            local targetPart = p.Character:FindFirstChild(AimbotSenter.LockPart)
            if hum and hum.Health > 0 and targetPart then
                local dist = (targetPart.Position - myRoot.Position).Magnitude
                if dist < shortest then
                    shortest = dist
                    closest = targetPart
                end
            end
        end
    end

    if not closest then
        AimbotSenter.CurrentTarget = nil
        clearLaser()
        return
    end

    AimbotSenter.CurrentTarget = closest

    local cam = workspace.CurrentCamera
    if cam then
        local newCFrame = CFrame.new(cam.CFrame.Position, closest.Position)
        cam.CFrame = cam.CFrame:Lerp(newCFrame, AimbotSenter.Smoothness)
    end

    if AimbotSenter.ShowLaser then
        local cam2 = workspace.CurrentCamera
        local screenPoint, onScreen = cam2:WorldToViewportPoint(closest.Position)
        if onScreen then
            clearLaser()
            local gui = getLaserGui()
            if gui then
                local line = Drawing.new("Line")
                line.Visible = true
                line.From = Vector2.new(cam2.ViewportSize.X / 2, cam2.ViewportSize.Y / 2)
                line.To = Vector2.new(screenPoint.X, screenPoint.Y)
                line.Color = AimbotSenter.LaserColor
                line.Thickness = 2
                line.Transparency = 0.5
                table.insert(AimbotLaserLines, line)
            end
        end
    end
end)

-- Auto-scan tombol senter
task.spawn(function()
    while task.wait(2) do
        if AimbotSenter.Enabled then
            pcall(HookSenterButton)
        end
    end
end)

-- =========================================================
-- AUTO SKILL CHECK
-- =========================================================
local AutoSkill = {
    Enabled = false,
    Mode = "Perfect",
    HideNeedle = false,
    Success = 0,
    Total = 0,
}

local function pressSpace()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
    task.wait()
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
end

local function GetActionTarget()
    local current = PlayerGui
    for segment in string.gmatch("Survivor-mob.Controls.action.check", "[^%.]+") do
        current = current and current:FindFirstChild(segment)
    end
    return current
end

local function TriggerMobileButton()
    local b = GetActionTarget()
    if b and b:IsA("GuiObject") then
        local p, s, i = b.AbsolutePosition, b.AbsoluteSize, GuiService:GetGuiInset()
        local cx, cy = p.X + (s.X/2) + i.X, p.Y + (s.Y/2) + i.Y
        pcall(function()
            VirtualInputManager:SendTouchEvent(8822, 0, cx, cy)
            task.wait(0.01)
            VirtualInputManager:SendTouchEvent(8822, 2, cx, cy)
        end)
    end
end

local skillBusy = false

task.spawn(function()
    while task.wait() do
        if not AutoSkill.Enabled or skillBusy then continue end

        local prompt = PlayerGui:FindFirstChild("SkillCheckPromptGui")
        if not prompt then continue end
        local check = prompt:FindFirstChild("Check")
        if not check or not check.Visible then continue end

        local line = check:FindFirstChild("Line")
        local goal = check:FindFirstChild("Goal")
        if not line or not goal then continue end

        local lr = line.Rotation % 360
        local gr = goal.Rotation % 360

        if AutoSkill.Mode == "Instant" then
            pcall(function() line.Rotation = (gr + 109) % 360 end)
            skillBusy = true
            task.spawn(function()
                if UserInputService.TouchEnabled then TriggerMobileButton() else pressSpace() end
                AutoSkill.Success += 1
                AutoSkill.Total += 1
                task.wait(0.05)
                skillBusy = false
            end)
            continue
        end

        -- Perfect mode
        local startRange = (gr + 102) % 360
        local endRange = (gr + 116) % 360
        local success = (startRange > endRange and (lr >= startRange or lr <= endRange))
            or (lr >= startRange and lr <= endRange)

        if success then
            skillBusy = true
            task.spawn(function()
                if UserInputService.TouchEnabled then TriggerMobileButton() else pressSpace() end
                AutoSkill.Success += 1
                AutoSkill.Total += 1
                task.wait(0.05)
                skillBusy = false
            end)
        end
    end
end)

-- =========================================================
-- AUTO WIGGLE
-- =========================================================
local AutoWiggle = {
    Enabled = false,
    Spam = 5,
}

task.spawn(function()
    while task.wait(1) do
        if not AutoWiggle.Enabled then continue end
        local char = LocalPlayer.Character
        if not char then continue end

        local carried = (char:FindFirstChild("IsCarried") and char.IsCarried.Value)
            or (char:FindFirstChild("IsCarrying") and char.IsCarrying.Value)
        if not carried then continue end

        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
        if not remotes then continue end
        local carry = remotes:FindFirstChild("Carry")
        if not carry then continue end
        local event = carry:FindFirstChild("SelfUnHookEvent")
        if not event then continue end

        for i = 1, AutoWiggle.Spam do
            pcall(function() event:FireServer() end)
        end
    end
end)

-- =========================================================
-- TAB COMBAT - UI
-- =========================================================
local ParryBox = Tabs.Combat:AddLeftGroupbox("Auto Parry", "swords")
local AimbotBox = Tabs.Combat:AddRightGroupbox("Aimbot Senter", "crosshair")

-- KIRI: Auto Parry
ParryBox:AddCheckbox("Parry_Enabled", {
    Text = "Enable Auto Parry",
    Default = false,
    Callback = function(v) AutoParry.Enabled = v end
})

ParryBox:AddSlider("Parry_Distance", {
    Text = "Parry Radius",
    Default = 15,
    Min = 5,
    Max = 40,
    Rounding = 0,
    Callback = function(v) AutoParry.ParryDistance = v end
})

ParryBox:AddSlider("Parry_Debounce", {
    Text = "Debounce",
    Default = 0.05,
    Min = 0.01,
    Max = 0.5,
    Rounding = 2,
    Callback = function(v) AutoParry.Debounce = v end
})

ParryBox:AddSlider("Parry_Face", {
    Text = "Face Sensitivity",
    Default = 0.3,
    Min = -1,
    Max = 1,
    Rounding = 2,
    Callback = function(v) AutoParry.FaceSensitivity = v end
})

ParryBox:AddCheckbox("Parry_ShowCircle", {
    Text = "Show Parry Circle",
    Default = false,
    Callback = function(v)
        AutoParry.ShowCircle = v
        if not v and ParryCircle then ParryCircle:Destroy(); ParryCircle = nil end
    end
})

ParryBox:AddColorPicker("Parry_CircleColor", {
    Default = Color3.fromRGB(255, 80, 80),
    Title = "Circle Color",
    Callback = function(c) AutoParry.CircleColor = c end
})

ParryBox:AddButton({
    Text = "Reset Parry Counter",
    Func = function() AutoParry.ParryCount = 0 end
})

-- KANAN: Aimbot Senter
AimbotBox:AddCheckbox("Aimbot_Enabled", {
    Text = "Enable Aimbot Senter",
    Default = false,
    Callback = function(v)
        AimbotSenter.Enabled = v
        if v then HookSenterButton() end
    end
})

AimbotBox:AddLabel("HOLD tombol senter = lock", true)
AimbotBox:AddLabel("LEPAS tombol = kamera bebas")

AimbotBox:AddSlider("Aimbot_Smooth", {
    Text = "Smoothness",
    Default = 0.5,
    Min = 0.1,
    Max = 1,
    Rounding = 2,
    Callback = function(v) AimbotSenter.Smoothness = v end
})

AimbotBox:AddDropdown("Aimbot_Part", {
    Values = {"Head", "HumanoidRootPart", "UpperTorso"},
    Default = 1,
    Multi = false,
    Text = "Lock Part",
    Callback = function(v) AimbotSenter.LockPart = v end
})

AimbotBox:AddCheckbox("Aimbot_Laser", {
    Text = "Show Laser",
    Default = true,
    Callback = function(v) AimbotSenter.ShowLaser = v end
})

AimbotBox:AddColorPicker("Aimbot_LaserColor", {
    Default = Color3.fromRGB(255, 0, 0),
    Title = "Laser Color",
    Callback = function(c) AimbotSenter.LaserColor = c end
})

-- =========================================================
-- SUB-TABS UNTUK SKILL CHECK + WIGGLE
-- =========================================================
local SkillTab = Tabs.Combat:AddLeftTabbox()
local SkillBox = SkillTab:AddTab("Skill Check", "zap")
local WiggleBox = SkillTab:AddTab("Auto Wiggle", "waves")

SkillBox:AddCheckbox("Skill_Enabled", {
    Text = "Enable Auto Skill Check",
    Default = false,
    Callback = function(v) AutoSkill.Enabled = v end
})

SkillBox:AddDropdown("Skill_Mode", {
    Values = {"Perfect", "Instant"},
    Default = 1,
    Multi = false,
    Text = "Mode",
    Callback = function(v) AutoSkill.Mode = v end
})

SkillBox:AddCheckbox("Skill_Hide", {
    Text = "Hide Needle",
    Default = false,
    Callback = function(v) AutoSkill.HideNeedle = v end
})

SkillBox:AddButton({
    Text = "Reset Counter",
    Func = function()
        AutoSkill.Success = 0
        AutoSkill.Total = 0
    end
})

WiggleBox:AddCheckbox("Wiggle_Enabled", {
    Text = "Enable Auto Wiggle",
    Default = false,
    Callback = function(v) AutoWiggle.Enabled = v end
})

WiggleBox:AddSlider("Wiggle_Spam", {
    Text = "Wiggle Spam",
    Default = 5,
    Min = 1,
    Max = 20,
    Rounding = 0,
    Callback = function(v) AutoWiggle.Spam = v end
})

print("✅ [3/12] One W - Combat Tab Loaded")-- =========================================================
-- SECTION 4/12 : KILLER TAB
-- Auto Attack + Auto Carry + Auto Hook + Masked Power + Kill All
-- =========================================================

-- =========================================================
-- REMOTES (Killer)
-- =========================================================
local CarryEvent, HookEvent, AttackEvent

pcall(function()
    local Remotes = ReplicatedStorage:WaitForChild("Remotes", 5)
    if Remotes then
        local Carry = Remotes:FindFirstChild("Carry")
        if Carry then
            CarryEvent = Carry:FindFirstChild("CarrySurvivorEvent")
            HookEvent = Carry:FindFirstChild("HookEvent")
        end
        local Attacks = Remotes:FindFirstChild("Attacks")
        if Attacks then
            AttackEvent = Attacks:FindFirstChild("BasicAttack")
        end
    end
end)

-- =========================================================
-- KILLER CONFIG
-- =========================================================
local Killer = {
    AutoAttack = false,
    AttackDelay = 0.35,
    KillAll = false,
    AutoCarry = false,
    AutoHook = false,
    CarryRange = 60,
}

local KillerBusy = false
local KillerTarget = nil
local lastKillerAtk = 0

-- =========================================================
-- HELPER FUNCTIONS
-- =========================================================
local function getRoot()
    local char = LocalPlayer.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function GetDownedSurvivor()
    local root = getRoot()
    if not root then return nil end

    local best, dist = nil, math.huge
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hum and hrp and hum.Health > 0 and hum.Health <= hum.MaxHealth * 0.25 then
                local d = (hrp.Position - root.Position).Magnitude
                if d < dist and d <= Killer.CarryRange then
                    dist = d
                    best = p.Character
                end
            end
        end
    end
    return best
end

local function GetHookPoint()
    local root = getRoot()
    if not root then return nil end

    local bestHook, shortest = nil, math.huge
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == "HookPoint" and obj:IsA("BasePart") then
            local dist = (obj.Position - root.Position).Magnitude
            if dist < shortest and dist < 400 then
                shortest = dist
                bestHook = obj
            end
        end
    end
    return bestHook
end

local function GetNearestAliveSurvivor()
    local root = getRoot()
    if not root then return nil end

    local closest, shortest = nil, math.huge
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character then
            local hum = plr.Character:FindFirstChildOfClass("Humanoid")
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            if hum and hrp and hum.Health > 30 then
                local d = (hrp.Position - root.Position).Magnitude
                if d < shortest then
                    shortest = d
                    closest = plr.Character
                end
            end
        end
    end
    return closest
end

-- =========================================================
-- AUTO ATTACK LOOP
-- =========================================================
task.spawn(function()
    while task.wait(0.05) do
        if not Killer.AutoAttack then continue end
        if not AttackEvent then continue end

        local now = tick()
        if now - lastKillerAtk >= Killer.AttackDelay then
            lastKillerAtk = now
            pcall(function()
                AttackEvent:FireServer(false)
            end)
        end
    end
end)

-- =========================================================
-- KILL ALL LOOP
-- =========================================================
task.spawn(function()
    while task.wait(0.05) do
        if not Killer.KillAll then continue end

        local root = getRoot()
        if not root then continue end

        if not KillerTarget
            or not KillerTarget:FindFirstChild("Humanoid")
            or KillerTarget.Humanoid.Health <= 35 then
            KillerTarget = GetNearestAliveSurvivor()
        end

        if KillerTarget then
            local targetHRP = KillerTarget:FindFirstChild("HumanoidRootPart")
            if targetHRP then
                local velocity = targetHRP.AssemblyLinearVelocity
                local predict = velocity * 0.15
                local targetPos = targetHRP.Position + predict
                local behind = targetHRP.CFrame.LookVector * -3
                pcall(function()
                    root.CFrame = CFrame.new(targetPos + behind, targetPos)
                end)
            end
            if AttackEvent then
                pcall(function() AttackEvent:FireServer(false) end)
            end
        end
    end
end)

-- =========================================================
-- AUTO CARRY + HOOK LOOP
-- =========================================================
task.spawn(function()
    while task.wait(0.2) do
        if not Killer.AutoCarry or KillerBusy then continue end
        if not CarryEvent or not HookEvent then continue end

        local target = GetDownedSurvivor()
        local root = getRoot()
        if not target or not root then continue end

        KillerBusy = true
        task.spawn(function()
            local tRoot = target:FindFirstChild("HumanoidRootPart")
            if tRoot then
                -- Approach target
                pcall(function()
                    root.CFrame = tRoot.CFrame * CFrame.new(0, 3, -2)
                end)
                task.wait(0.4)

                -- Fire carry event
                for i = 1, 4 do
                    pcall(function() CarryEvent:FireServer(target) end)
                    task.wait(0.2)
                end
                task.wait(0.6)

                -- Auto Hook
                if Killer.AutoHook then
                    local hook = GetHookPoint()
                    if hook then
                        pcall(function()
                            root.CFrame = hook.CFrame * CFrame.new(0, 4, -3)
                        end)
                        task.wait(0.7)
                        for i = 1, 6 do
                            pcall(function() HookEvent:FireServer(hook) end)
                            task.wait(0.15)
                        end
                    end
                end
            end
            task.delay(2, function() KillerBusy = false end)
        end)
    end
end)

-- =========================================================
-- MASKED POWER
-- =========================================================
local Masked = {
    CurrentPower = "Cobra",
}

local MaskedPowers = {"Cobra", "Richter", "Brandon", "Rabbit", "Alex"}

local function ActivateMaskedPower()
    local Event = ReplicatedStorage:FindFirstChild("Remotes", true)
        and ReplicatedStorage.Remotes:FindFirstChild("Killers", true)
        and ReplicatedStorage.Remotes.Killers:FindFirstChild("Masked", true)
        and ReplicatedStorage.Remotes.Killers.Masked:FindFirstChild("Activatepower")

    if Event then
        Event:FireServer(Masked.CurrentPower)
        Library:Notify({
            Title = "Masked Power: " .. Masked.CurrentPower,
            Duration = 2,
        })
    else
        Library:Notify({
            Title = "Masked Power not available",
            Duration = 2,
        })
    end
end

local function DeactivateMaskedPower()
    local Event = ReplicatedStorage:FindFirstChild("Remotes", true)
        and ReplicatedStorage.Remotes:FindFirstChild("Killers", true)
        and ReplicatedStorage.Remotes.Killers:FindFirstChild("Masked", true)
        and ReplicatedStorage.Remotes.Killers.Masked:FindFirstChild("Deactivatepower")

    if Event then
        Event:FireServer()
        Library:Notify({
            Title = "Masked Power: OFF",
            Duration = 2,
        })
    end
end

-- =========================================================
-- TAB KILLER - UI
-- =========================================================
local AttackBox = Tabs.Killer:AddLeftGroupbox("Auto Attack", "swords")
local CarryBox = Tabs.Killer:AddRightGroupbox("Auto Carry & Hook", "package")

-- KIRI: Auto Attack
AttackBox:AddCheckbox("Killer_AutoAttack", {
    Text = "Auto Attack",
    Default = false,
    Callback = function(v) Killer.AutoAttack = v end
})

AttackBox:AddSlider("Killer_AtkDelay", {
    Text = "Attack Delay",
    Default = 0.35,
    Min = 0.1,
    Max = 1,
    Rounding = 2,
    Callback = function(v) Killer.AttackDelay = v end
})

AttackBox:AddCheckbox("Killer_KillAll", {
    Text = "Auto Kill All",
    Default = false,
    Callback = function(v) Killer.KillAll = v end
})

AttackBox:AddLabel("Auto TP ke survivor + attack")

-- KANAN: Auto Carry
CarryBox:AddCheckbox("Killer_AutoCarry", {
    Text = "Auto Carry (Downed)",
    Default = false,
    Callback = function(v) Killer.AutoCarry = v end
})

CarryBox:AddCheckbox("Killer_AutoHook", {
    Text = "Auto Hook",
    Default = false,
    Callback = function(v) Killer.AutoHook = v end
})

CarryBox:AddSlider("Killer_CarryRange", {
    Text = "Carry Range",
    Default = 60,
    Min = 10,
    Max = 200,
    Rounding = 0,
    Callback = function(v) Killer.CarryRange = v end
})

-- =========================================================
-- SUB-TAB MASKED POWER
-- =========================================================
local MaskedTab = Tabs.Killer:AddLeftTabbox()
local MaskedBox = MaskedTab:AddTab("Masked Power", "user")

MaskedBox:AddDropdown("Masked_Power", {
    Values = MaskedPowers,
    Default = 1,
    Multi = false,
    Text = "Select Power",
    Callback = function(v) Masked.CurrentPower = v end
})

MaskedBox:AddButton({
    Text = "Activate Power",
    Func = function() ActivateMaskedPower() end
})

MaskedBox:AddButton({
    Text = "Deactivate Power",
    Func = function() DeactivateMaskedPower() end
})

print("✅ [4/12] One W - Killer Tab Loaded")-- =========================================================
-- SECTION 5/12 : SURVIVAL TAB
-- Auto Flee + Auto Escape + Moonwalk + Fast Vault
-- =========================================================

-- =========================================================
-- AUTO FLEE KILLER
-- =========================================================
local AutoFlee = {
    Enabled = false,
    DetectDistance = 50,
    Cooldown = 0.5,
    LastFlee = 0,
}

local function GetNearestKiller()
    local root = getRoot()
    if not root then return nil, math.huge end

    local closest, shortest = nil, math.huge
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Team and plr.Team.Name == "Killer" and plr.Character then
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local dist = (hrp.Position - root.Position).Magnitude
                if dist < shortest then
                    shortest = dist
                    closest = hrp
                end
            end
        end
    end
    return closest, shortest
end

local function GetFarthestGeneratorPoint(killerRoot)
    if not killerRoot then return nil end
    local bestPoint, farthestDistance = nil, 0

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and string.match(obj.Name, "^GeneratorPoint%d+$") then
            local dist = (obj.Position - killerRoot.Position).Magnitude
            if dist > farthestDistance then
                farthestDistance = dist
                bestPoint = obj
            end
        end
    end
    return bestPoint
end

task.spawn(function()
    while task.wait(0.2) do
        if not AutoFlee.Enabled then continue end
        local root = getRoot()
        if not root then continue end

        local killerRoot, distance = GetNearestKiller()
        if killerRoot and distance <= AutoFlee.DetectDistance
            and tick() - AutoFlee.LastFlee > AutoFlee.Cooldown then
            local point = GetFarthestGeneratorPoint(killerRoot)
            if point then
                AutoFlee.LastFlee = tick()
                pcall(function()
                    root.CFrame = point.CFrame + Vector3.new(0, 5, 0)
                end)
            end
        end
    end
end)

-- =========================================================
-- AUTO ESCAPE GATE
-- =========================================================
local AutoEscape = {
    Enabled = false,
    KillerRange = 50,
    TriggerKiller = true,
    TriggerGen = true,
}

local function getRootGlobal()
    local char = LocalPlayer.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

task.spawn(function()
    while task.wait(3) do
        if not AutoEscape.Enabled then continue end
        local root = getRootGlobal()
        if not root then continue end

        local killerNear = false
        if AutoEscape.TriggerKiller then
            local kRoot, kDist = GetNearestKiller()
            if kRoot and kDist <= AutoEscape.KillerRange then
                killerNear = true
            end
        end

        local genDone = false
        if AutoEscape.TriggerGen then
            local total, done = 0, 0
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj.Name == "Generator" then
                    total = total + 1
                    local p = obj:GetAttribute("RepairProgress")
                        or obj:GetAttribute("Progress") or 0
                    if p >= 100 then done = done + 1 end
                end
            end
            if total > 0 and done >= total then genDone = true end
        end

        if killerNear or genDone then
            local found = nil
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") then
                    local n = string.lower(obj.Name)
                    if n == "fininshline" or n == "finishline"
                        or n == "escape" or n == "escapegate"
                        or string.find(n, "escape") then
                        found = obj
                        break
                    end
                end
            end
            if found then
                pcall(function()
                    root.CFrame = found.CFrame + Vector3.new(0, 5, 0)
                end)
            end
        end
    end
end)

-- =========================================================
-- MOONWALK
-- =========================================================
local Moonwalk = {
    Enabled = false,
    Locked = false,
    SpamSpeed = 30,
    Intensity = 35,
    SlowSpeed = 13,
    UseSlow = true,
}

local mwBtnGui = nil
local mwBtn = nil
local mwLockBtn = nil

local function mwIsDowned()
    local char = LocalPlayer.Character
    if not char then return false end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return false end
    return hum.Health <= 0 or hum.Health < 2
end

local function mwResetSpeed()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = 16 end
end

local function setMoonwalk(state)
    if Moonwalk.Locked and state ~= Moonwalk.Enabled then
        return false
    end
    Moonwalk.Enabled = state
    if not state then mwResetSpeed() end
    return true
end

local function mwBtnUpdateUI()
    if not mwBtn then return end
    if Moonwalk.Enabled then
        mwBtn.Text = "MW ON"
        mwBtn.BackgroundColor3 = Color3.fromRGB(80, 20, 120)
    else
        mwBtn.Text = "MW"
        mwBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    end
    if mwLockBtn then
        if Moonwalk.Locked then
            mwLockBtn.Text = "LOCKED"
            mwLockBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        else
            mwLockBtn.Text = "UNLOCK"
            mwLockBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 65)
        end
    end
end

local function createMoonwalkButton()
    if mwBtnGui then mwBtnGui:Destroy() end

    mwBtnGui = Instance.new("ScreenGui")
    mwBtnGui.Name = "OneW_MWBtn"
    mwBtnGui.ResetOnSpawn = false
    mwBtnGui.Parent = PlayerGui

    mwBtn = Instance.new("TextButton")
    mwBtn.Size = UDim2.fromOffset(55, 55)
    mwBtn.Position = UDim2.new(0, 20, 1, -100)
    mwBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    mwBtn.Text = "MW"
    mwBtn.TextColor3 = Color3.new(1, 1, 1)
    mwBtn.TextSize = 15
    mwBtn.Font = Enum.Font.GothamBlack
    mwBtn.AutoButtonColor = false
    mwBtn.Active = true
    mwBtn.Draggable = true
    mwBtn.Parent = mwBtnGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = mwBtn

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Transparency = 0.5
    stroke.Parent = mwBtn

    mwLockBtn = Instance.new("TextButton")
    mwLockBtn.Size = UDim2.fromOffset(55, 20)
    mwLockBtn.Position = UDim2.new(0, 20, 1, -125)
    mwLockBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 65)
    mwLockBtn.Text = "UNLOCK"
    mwLockBtn.TextColor3 = Color3.new(1, 1, 1)
    mwLockBtn.TextSize = 9
    mwLockBtn.Font = Enum.Font.GothamBold
    mwLockBtn.AutoButtonColor = false
    mwLockBtn.Parent = mwBtnGui

    local lockCorner = Instance.new("UICorner")
    lockCorner.CornerRadius = UDim.new(1, 0)
    lockCorner.Parent = mwLockBtn

    mwBtn.MouseButton1Click:Connect(function()
        if Moonwalk.Locked then
            mwBtn.Text = "X"
            task.delay(0.8, mwBtnUpdateUI)
            return
        end
        setMoonwalk(not Moonwalk.Enabled)
        mwBtnUpdateUI()
    end)

    mwLockBtn.MouseButton1Click:Connect(function()
        Moonwalk.Locked = not Moonwalk.Locked
        mwBtnUpdateUI()
    end)

    mwBtnUpdateUI()
end

local function removeMoonwalkButton()
    if mwBtnGui then
        mwBtnGui:Destroy()
        mwBtnGui = nil
        mwBtn = nil
        mwLockBtn = nil
    end
end

-- Moonwalk loop
RunService.RenderStepped:Connect(function()
    if Moonwalk.Enabled and not mwIsDowned() then
        local char = LocalPlayer.Character
        if char and char.Parent then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local cam = workspace.CurrentCamera

            if humanoid and hrp and cam then
                if Moonwalk.UseSlow and humanoid.WalkSpeed ~= Moonwalk.SlowSpeed then
                    humanoid.WalkSpeed = Moonwalk.SlowSpeed
                end

                local look = cam.CFrame.LookVector
                local flatLook = Vector3.new(look.X, 0, look.Z)
                if flatLook.Magnitude > 0 then
                    flatLook = flatLook.Unit
                    local baseCF = CFrame.new(hrp.Position, hrp.Position + flatLook)
                    local angle = math.sin(tick() * Moonwalk.SpamSpeed) * Moonwalk.Intensity
                    hrp.CFrame = baseCF * CFrame.Angles(0, math.rad(angle), 0)
                    humanoid:Move(Vector3.new(0, 0, 1), true)
                end
            end
        end
    end
end)

-- =========================================================
-- FAST VAULT
-- =========================================================
local FastVault = {
    Enabled = false,
    Speed = 1.2,
    ReplaceMap = {
        ["rbxassetid://83873880822918"] = "rbxassetid://136962284480779",
    },
}

local VaultTracks = {}

local function normalizeVaultId(id)
    local num = tostring(id):match("%d+")
    return num and ("rbxassetid://" .. num)
end

local function hookVault(char)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local animator = hum:FindFirstChildOfClass("Animator")
    if not animator then return end

    animator.AnimationPlayed:Connect(function(track)
        if not FastVault.Enabled then return end
        local anim = track.Animation
        if not anim or not anim.AnimationId then return end
        local id = normalizeVaultId(anim.AnimationId)
        if not id then return end
        local replaceId = FastVault.ReplaceMap[id]
        if not replaceId then return end
        if VaultTracks[track] then return end
        VaultTracks[track] = true

        track:Stop()
        local newAnim = Instance.new("Animation")
        newAnim.AnimationId = replaceId
        local newTrack = animator:LoadAnimation(newAnim)
        newTrack.Priority = Enum.AnimationPriority.Action
        newTrack:Play()
        newTrack:AdjustSpeed(FastVault.Speed)

        newTrack.Stopped:Connect(function()
            VaultTracks[track] = nil
        end)
    end)
end

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    hookVault(char)
end)

if LocalPlayer.Character then
    hookVault(LocalPlayer.Character)
end

-- =========================================================
-- TAB SURVIVAL - UI
-- =========================================================
local FleeBox = Tabs.Survival:AddLeftGroupbox("Auto Flee", "run")
local EscapeBox = Tabs.Survival:AddRightGroupbox("Auto Escape", "door-open")

-- KIRI: Auto Flee
FleeBox:AddCheckbox("Flee_Enabled", {
    Text = "Enable Auto Flee",
    Default = false,
    Callback = function(v) AutoFlee.Enabled = v end
})

FleeBox:AddSlider("Flee_Distance", {
    Text = "Detect Distance",
    Default = 50,
    Min = 10,
    Max = 150,
    Rounding = 0,
    Callback = function(v) AutoFlee.DetectDistance = v end
})

FleeBox:AddSlider("Flee_Cooldown", {
    Text = "Cooldown",
    Default = 0.5,
    Min = 0.1,
    Max = 5,
    Rounding = 2,
    Callback = function(v) AutoFlee.Cooldown = v end
})

FleeBox:AddLabel("TP ke generator terjauh kalau killer deket")

-- KANAN: Auto Escape
EscapeBox:AddCheckbox("Escape_Enabled", {
    Text = "Enable Auto Escape",
    Default = false,
    Callback = function(v) AutoEscape.Enabled = v end
})

EscapeBox:AddCheckbox("Escape_TriggerKiller", {
    Text = "Trigger: Killer Deket",
    Default = true,
    Callback = function(v) AutoEscape.TriggerKiller = v end
})

EscapeBox:AddCheckbox("Escape_TriggerGen", {
    Text = "Trigger: Generator Cukup",
    Default = true,
    Callback = function(v) AutoEscape.TriggerGen = v end
})

EscapeBox:AddSlider("Escape_KillerRange", {
    Text = "Killer Range",
    Default = 50,
    Min = 10,
    Max = 150,
    Rounding = 0,
    Callback = function(v) AutoEscape.KillerRange = v end
})

-- =========================================================
-- SUB-TAB MOONWALK + FAST VAULT
-- =========================================================
local SurvivalTab = Tabs.Survival:AddLeftTabbox()
local MWBox = SurvivalTab:AddTab("Moonwalk", "footprints")
local VaultBox = SurvivalTab:AddTab("Fast Vault", "wind")

MWBox:AddCheckbox("MW_Enabled", {
    Text = "Enable Moonwalk",
    Default = false,
    Callback = function(v)
        setMoonwalk(v)
        mwBtnUpdateUI()
    end
})

MWBox:AddCheckbox("MW_Locked", {
    Text = "Lock Moonwalk",
    Default = false,
    Callback = function(v)
        Moonwalk.Locked = v
        mwBtnUpdateUI()
    end
})

MWBox:AddCheckbox("MW_ShowBtn", {
    Text = "Show MW Button",
    Default = false,
    Callback = function(v)
        if v then createMoonwalkButton() else removeMoonwalkButton() end
    end
})

MWBox:AddSlider("MW_SpamSpeed", {
    Text = "Spam Speed",
    Default = 30,
    Min = 1,
    Max = 50,
    Rounding = 0,
    Callback = function(v) Moonwalk.SpamSpeed = v end
})

MWBox:AddSlider("MW_Intensity", {
    Text = "Intensity",
    Default = 35,
    Min = 1,
    Max = 50,
    Rounding = 0,
    Callback = function(v) Moonwalk.Intensity = v end
})

MWBox:AddSlider("MW_SlowSpeed", {
    Text = "Slow Speed",
    Default = 13,
    Min = 5,
    Max = 20,
    Rounding = 0,
    Callback = function(v) Moonwalk.SlowSpeed = v end
})

MWBox:AddCheckbox("MW_UseSlow", {
    Text = "Use Slow Speed",
    Default = true,
    Callback = function(v) Moonwalk.UseSlow = v end
})

VaultBox:AddCheckbox("Vault_Enabled", {
    Text = "Enable Fast Vault",
    Default = false,
    Callback = function(v)
        FastVault.Enabled = v
        if v and LocalPlayer.Character then
            hookVault(LocalPlayer.Character)
        end
    end
})

VaultBox:AddSlider("Vault_Speed", {
    Text = "Animation Speed",
    Default = 1.2,
    Min = 1,
    Max = 5,
    Rounding = 2,
    Callback = function(v) FastVault.Speed = v end
})

print("✅ [5/12] One W - Survival Tab Loaded")-- =========================================================
-- SECTION 6/12 : CHARACTER TAB
-- Korblox + Headless + 8-Bit Crown + Fire Effect
-- =========================================================

-- =========================================================
-- KORBLOX SYSTEM
-- =========================================================
local korbloxParts = {}
local korbloxOrigData = {}

local function clearKorblox()
    for _, part in pairs(korbloxParts) do
        if part and part.Parent then part:Destroy() end
    end
    korbloxParts = {}

    local char = LocalPlayer.Character
    if not char then return end
    for legName, data in pairs(korbloxOrigData) do
        local leg = char:FindFirstChild(legName)
        if leg then
            leg.Transparency = data.trans
            leg.CanCollide = data.collide
        end
    end
    korbloxOrigData = {}
end

local function applyKorblox(enable)
    clearKorblox()
    if not enable then return end

    local char = LocalPlayer.Character
    if not char then return end

    local rightLeg = char:FindFirstChild("Right Leg")
    if not rightLeg then return end

    korbloxOrigData["Right Leg"] = {
        trans = rightLeg.Transparency,
        collide = rightLeg.CanCollide,
    }

    rightLeg.Transparency = 1
    rightLeg.CanCollide = false

    local korbloxPart = Instance.new("Part")
    korbloxPart.Name = "OneWKorblox"
    korbloxPart.Size = Vector3.new(1, 2, 1)
    korbloxPart.CanCollide = false
    korbloxPart.Massless = true
    korbloxPart.Transparency = 0
    korbloxPart.Parent = char

    local mesh = Instance.new("SpecialMesh")
    mesh.MeshType = Enum.MeshType.FileMesh
    mesh.MeshId = "rbxassetid://902942096"
    mesh.TextureId = "rbxassetid://902843398"
    mesh.Scale = Vector3.new(1, 1, 1)
    mesh.Offset = Vector3.new(0, 0.80, 0)
    mesh.Parent = korbloxPart

    local weld = Instance.new("Weld")
    weld.Part0 = rightLeg
    weld.Part1 = korbloxPart
    weld.C0 = CFrame.new(0, 0, 0)
    weld.Parent = korbloxPart

    table.insert(korbloxParts, korbloxPart)
end

-- =========================================================
-- HEADLESS SYSTEM
-- =========================================================
local function applyHeadless(enable)
    local char = LocalPlayer.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end

    if enable then
        head.Transparency = 1
        head.CanCollide = false

        for _, v in pairs(head:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Transparency = 1
                v.CanCollide = false
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 1
            end
        end

        for _, obj in pairs(char:GetChildren()) do
            if obj:IsA("Accessory") then
                for _, part in pairs(obj:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Transparency = 1
                        part.CanCollide = false
                    end
                end
            end
        end
    else
        head.Transparency = 0
        head.CanCollide = true

        for _, v in pairs(head:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Transparency = 0
                v.CanCollide = true
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 0
            end
        end

        for _, obj in pairs(char:GetChildren()) do
            if obj:IsA("Accessory") then
                for _, part in pairs(obj:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Transparency = 0
                        part.CanCollide = true
                    end
                end
            end
        end
    end
end

-- =========================================================
-- 8-BIT ROYAL CROWN
-- =========================================================
local eightBitPart = nil

local function clear8Bit()
    if eightBitPart then
        eightBitPart:Destroy()
        eightBitPart = nil
    end
end

local function apply8Bit(enable, size, height)
    clear8Bit()
    if not enable then return end

    local char = LocalPlayer.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end

    size = size or 1.24
    height = height or 0.88

    eightBitPart = Instance.new("Part")
    eightBitPart.Name = "OneW_8Bit"
    eightBitPart.Size = Vector3.new(2, 2, 2) * size
    eightBitPart.CanCollide = false
    eightBitPart.Massless = true
    eightBitPart.Transparency = 0
    eightBitPart.Parent = head

    local mesh = Instance.new("SpecialMesh")
    mesh.MeshType = Enum.MeshType.FileMesh
    mesh.MeshId = "rbxassetid://10138606900"
    mesh.TextureId = "rbxassetid://10138606949"
    mesh.Scale = Vector3.new(1.5, 1.5, 1.5) * size
    mesh.Parent = eightBitPart

    local weld = Instance.new("Weld")
    weld.Part0 = head
    weld.Part1 = eightBitPart
    weld.C0 = CFrame.new(0, height * size, 0)
    weld.Parent = eightBitPart
end

-- =========================================================
-- FIRE EFFECT (60 TYPE)
-- =========================================================
local FireList = {
    "Classic","HellFire","IceFire","ToxicFire","VoidFire",
    "GoldenKing","SakuraFire","EmeraldFire","BloodFire","ShadowFire",
    "HolyFire","OceanFire","Firework","Lava","GhostFire",
    "CosmicFire","DragonFire","MysteryFire","RainbowFire","LightningFire",
    "GalaxyFire","NebulaFire","AuroraFire","PhoenixFire","DemonFire",
    "AngelFire","CrystalFire","NeonFire","PlasmaFire","QuantumFire",
    "LegendaryFire","MythicFire","DivineFire","CursedFire","AncientFire",
    "EternalFire","InfernoFire","BifrostFire","ChaosFire","OmegaFire",
    "SolarFire","LunarFire","EclipseFire","SolarFlare","VoidStorm",
    "StarFire","SupernovaFire","BlackHoleFire","MeteorFire","CometFire",
    "FrostFire","BlizzardFire","ThunderFire","StormFire","TornadoFire",
    "SoulFire","SpiritFire","PhantomFire","WraithFire","ReaperFire"
}

local FireConfig = {
    Classic = { c1 = Color3.fromRGB(120, 60, 255), c2 = Color3.fromRGB(0, 230, 255) },
    HellFire = { c1 = Color3.fromRGB(180, 0, 0), c2 = Color3.fromRGB(255, 80, 0), smoke = true },
    IceFire = { c1 = Color3.fromRGB(120, 200, 255), c2 = Color3.fromRGB(220, 240, 255), spark = true },
    ToxicFire = { c1 = Color3.fromRGB(0, 255, 50), c2 = Color3.fromRGB(180, 255, 0), smoke = true },
    VoidFire = { c1 = Color3.fromRGB(100, 0, 180), c2 = Color3.fromRGB(220, 50, 255), spark = true },
    GoldenKing = { c1 = Color3.fromRGB(255, 215, 0), c2 = Color3.fromRGB(255, 255, 120), spark = true },
    SakuraFire = { c1 = Color3.fromRGB(255, 150, 200), c2 = Color3.fromRGB(255, 220, 240), spark = true },
    EmeraldFire = { c1 = Color3.fromRGB(0, 220, 100), c2 = Color3.fromRGB(120, 255, 170) },
    BloodFire = { c1 = Color3.fromRGB(220, 0, 0), c2 = Color3.fromRGB(120, 0, 0), smoke = true },
    ShadowFire = { c1 = Color3.fromRGB(30, 30, 40), c2 = Color3.fromRGB(100, 0, 130), smoke = true },
    HolyFire = { c1 = Color3.fromRGB(255, 255, 255), c2 = Color3.fromRGB(255, 255, 220), spark = true },
    OceanFire = { c1 = Color3.fromRGB(0, 120, 255), c2 = Color3.fromRGB(120, 220, 255) },
    Firework = { c1 = Color3.fromRGB(255, 0, 120), c2 = Color3.fromRGB(255, 220, 50), rainbow = true, spark = true },
    Lava = { c1 = Color3.fromRGB(255, 100, 0), c2 = Color3.fromRGB(120, 30, 0), smoke = true },
    GhostFire = { c1 = Color3.fromRGB(200, 200, 255), c2 = Color3.fromRGB(255, 255, 255) },
    CosmicFire = { c1 = Color3.fromRGB(80, 0, 150), c2 = Color3.fromRGB(255, 120, 220), rainbow = true },
    DragonFire = { c1 = Color3.fromRGB(255, 80, 0), c2 = Color3.fromRGB(255, 220, 50), smoke = true },
    MysteryFire = { c1 = Color3.fromRGB(255, 0, 0), c2 = Color3.fromRGB(0, 255, 255), rainbow = true },
    RainbowFire = { c1 = Color3.fromRGB(255, 0, 0), c2 = Color3.fromRGB(0, 255, 255), rainbow = true, spark = true },
    LightningFire = { c1 = Color3.fromRGB(120, 220, 255), c2 = Color3.fromRGB(255, 255, 255), spark = true },
    GalaxyFire = { c1 = Color3.fromRGB(120, 60, 255), c2 = Color3.fromRGB(255, 200, 255), rainbow = true, spark = true },
    NebulaFire = { c1 = Color3.fromRGB(220, 80, 255), c2 = Color3.fromRGB(80, 220, 255), rainbow = true, spark = true },
    AuroraFire = { c1 = Color3.fromRGB(0, 255, 200), c2 = Color3.fromRGB(120, 255, 120), rainbow = true, spark = true },
    PhoenixFire = { c1 = Color3.fromRGB(255, 180, 0), c2 = Color3.fromRGB(255, 80, 0), smoke = true },
    DemonFire = { c1 = Color3.fromRGB(255, 0, 0), c2 = Color3.fromRGB(0, 0, 0), smoke = true },
    AngelFire = { c1 = Color3.fromRGB(255, 255, 220), c2 = Color3.fromRGB(255, 240, 255), spark = true },
    CrystalFire = { c1 = Color3.fromRGB(220, 255, 255), c2 = Color3.fromRGB(220, 220, 255), spark = true },
    NeonFire = { c1 = Color3.fromRGB(0, 255, 120), c2 = Color3.fromRGB(255, 0, 220), rainbow = true },
    PlasmaFire = { c1 = Color3.fromRGB(180, 0, 255), c2 = Color3.fromRGB(0, 220, 255), spark = true },
    QuantumFire = { c1 = Color3.fromRGB(0, 120, 255), c2 = Color3.fromRGB(255, 0, 120), rainbow = true },
    LegendaryFire = { c1 = Color3.fromRGB(255, 215, 0), c2 = Color3.fromRGB(255, 120, 0), spark = true },
    MythicFire = { c1 = Color3.fromRGB(220, 0, 255), c2 = Color3.fromRGB(255, 220, 0), rainbow = true },
    DivineFire = { c1 = Color3.fromRGB(255, 255, 255), c2 = Color3.fromRGB(255, 220, 120), spark = true },
    CursedFire = { c1 = Color3.fromRGB(100, 0, 0), c2 = Color3.fromRGB(220, 0, 220), smoke = true },
    AncientFire = { c1 = Color3.fromRGB(220, 180, 0), c2 = Color3.fromRGB(120, 60, 0), smoke = true },
    EternalFire = { c1 = Color3.fromRGB(255, 120, 220), c2 = Color3.fromRGB(120, 220, 255), rainbow = true },
    InfernoFire = { c1 = Color3.fromRGB(255, 40, 0), c2 = Color3.fromRGB(255, 220, 0), smoke = true },
    BifrostFire = { c1 = Color3.fromRGB(255, 120, 220), c2 = Color3.fromRGB(120, 255, 220), rainbow = true },
    ChaosFire = { c1 = Color3.fromRGB(255, 0, 0), c2 = Color3.fromRGB(0, 0, 255), rainbow = true },
    OmegaFire = { c1 = Color3.fromRGB(255, 215, 0), c2 = Color3.fromRGB(255, 0, 255), rainbow = true },
    SolarFire = { c1 = Color3.fromRGB(255, 180, 0), c2 = Color3.fromRGB(255, 255, 120), spark = true },
    LunarFire = { c1 = Color3.fromRGB(220, 220, 255), c2 = Color3.fromRGB(120, 170, 255), spark = true },
    EclipseFire = { c1 = Color3.fromRGB(80, 0, 120), c2 = Color3.fromRGB(255, 180, 0), spark = true },
    SolarFlare = { c1 = Color3.fromRGB(255, 120, 0), c2 = Color3.fromRGB(255, 255, 220), spark = true },
    VoidStorm = { c1 = Color3.fromRGB(80, 0, 120), c2 = Color3.fromRGB(220, 0, 255), rainbow = true, spark = true },
    StarFire = { c1 = Color3.fromRGB(255, 255, 220), c2 = Color3.fromRGB(255, 220, 120), spark = true },
    SupernovaFire = { c1 = Color3.fromRGB(255, 220, 0), c2 = Color3.fromRGB(255, 0, 220), rainbow = true, spark = true },
    BlackHoleFire = { c1 = Color3.fromRGB(0, 0, 0), c2 = Color3.fromRGB(120, 0, 180), smoke = true },
    MeteorFire = { c1 = Color3.fromRGB(255, 100, 0), c2 = Color3.fromRGB(220, 40, 0), smoke = true },
    CometFire = { c1 = Color3.fromRGB(120, 220, 255), c2 = Color3.fromRGB(220, 255, 255), spark = true },
    FrostFire = { c1 = Color3.fromRGB(220, 240, 255), c2 = Color3.fromRGB(120, 200, 255), spark = true },
    BlizzardFire = { c1 = Color3.fromRGB(240, 250, 255), c2 = Color3.fromRGB(170, 220, 255), spark = true, smoke = true },
    ThunderFire = { c1 = Color3.fromRGB(255, 255, 120), c2 = Color3.fromRGB(120, 120, 255), spark = true },
    StormFire = { c1 = Color3.fromRGB(100, 100, 180), c2 = Color3.fromRGB(220, 220, 255), spark = true, smoke = true },
    TornadoFire = { c1 = Color3.fromRGB(180, 180, 220), c2 = Color3.fromRGB(100, 100, 150), spark = true, smoke = true },
    SoulFire = { c1 = Color3.fromRGB(0, 255, 220), c2 = Color3.fromRGB(180, 255, 255), spark = true },
    SpiritFire = { c1 = Color3.fromRGB(220, 255, 255), c2 = Color3.fromRGB(180, 220, 255), spark = true },
    PhantomFire = { c1 = Color3.fromRGB(120, 0, 180), c2 = Color3.fromRGB(80, 0, 120), smoke = true },
    WraithFire = { c1 = Color3.fromRGB(50, 0, 80), c2 = Color3.fromRGB(180, 0, 220), smoke = true },
    ReaperFire = { c1 = Color3.fromRGB(0, 0, 0), c2 = Color3.fromRGB(255, 0, 0), smoke = true },
}

for _, name in ipairs(FireList) do
    if not FireConfig[name] then
        FireConfig[name] = FireConfig.Classic
    end
end

local FireState = {
    Enabled = false,
    Type = "CosmicFire",
    Size = 5,
}

local function clearFire()
    local char = LocalPlayer.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end
    for _, obj in pairs(head:GetChildren()) do
        if obj.Name == "OneWFire" or obj.Name == "OneWSmoke" or obj.Name == "OneWSparkles" then
            obj:Destroy()
        end
    end
end

local function applyFire()
    clearFire()
    if not FireState.Enabled then return end

    local char = LocalPlayer.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end

    local cfg = FireConfig[FireState.Type] or FireConfig.Classic

    local fire = Instance.new("Fire")
    fire.Name = "OneWFire"
    fire.Size = FireState.Size
    fire.Heat = 15
    fire.Color = cfg.c1
    fire.SecondaryColor = cfg.c2
    fire.Parent = head

    if cfg.smoke then
        local smoke = Instance.new("Smoke")
        smoke.Name = "OneWSmoke"
        smoke.Size = FireState.Size + 2
        smoke.RiseVelocity = 3
        smoke.Opacity = 0.4
        smoke.Color = cfg.c2
        smoke.Parent = head
    end

    if cfg.spark then
        local spark = Instance.new("Sparkles")
        spark.Name = "OneWSparkles"
        spark.SparkleColor = cfg.c2
        spark.SparkleSize = 1
        spark.Parent = head
    end
end

-- Fire rainbow loop
task.spawn(function()
    while task.wait(0.5) do
        if FireState.Enabled and LocalPlayer.Character then
            local head = LocalPlayer.Character:FindFirstChild("Head")
            local fire = head and head:FindFirstChild("OneWFire")
            if fire then
                local cfg = FireConfig[FireState.Type] or FireConfig.Classic
                if cfg.rainbow then
                    local t = tick()
                    fire.Color = Color3.fromHSV((t * 0.5) % 1, 1, 1)
                    fire.SecondaryColor = Color3.fromHSV(((t * 0.5) + 0.5) % 1, 1, 1)
                end
            end
        end
    end
end)

-- =========================================================
-- TAB CHARACTER - UI
-- =========================================================
local BodyBox = Tabs.Character:AddLeftGroupbox("Body", "user")
local FireBox = Tabs.Character:AddRightGroupbox("Fire Effect", "flame")

-- KIRI: Body
BodyBox:AddCheckbox("Korblox_Enabled", {
    Text = "Korblox Pencil",
    Default = false,
    Callback = function(v) applyKorblox(v) end
})

BodyBox:AddCheckbox("Headless_Enabled", {
    Text = "Headless (Full)",
    Default = false,
    Callback = function(v) applyHeadless(v) end
})

BodyBox:AddCheckbox("Crown_Enabled", {
    Text = "8-Bit Royal Crown",
    Default = false,
    Callback = function(v) apply8Bit(v, 1.24, 0.88) end
})

BodyBox:AddSlider("Crown_Size", {
    Text = "Crown Size",
    Default = 1.24,
    Min = 0.3,
    Max = 3,
    Rounding = 2,
    Callback = function(v)
        if eightBitPart then apply8Bit(true, v, 0.88) end
    end
})

BodyBox:AddSlider("Crown_Height", {
    Text = "Crown Height",
    Default = 0.88,
    Min = -1,
    Max = 4,
    Rounding = 2,
    Callback = function(v)
        if eightBitPart then apply8Bit(true, 1.24, v) end
    end
})

-- KANAN: Fire
FireBox:AddCheckbox("Fire_Enabled", {
    Text = "Enable Fire",
    Default = false,
    Callback = function(v)
        FireState.Enabled = v
        applyFire()
    end
})

FireBox:AddDropdown("Fire_Type", {
    Values = FireList,
    Default = 16,
    Multi = false,
    Text = "Fire Type (60)",
    Callback = function(v)
        FireState.Type = v
        applyFire()
    end
})

FireBox:AddSlider("Fire_Size", {
    Text = "Fire Size",
    Default = 5,
    Min = 1,
    Max = 15,
    Rounding = 0,
    Callback = function(v)
        FireState.Size = v
        applyFire()
    end
})

print("✅ [6/12] One W - Character Tab Loaded")-- =========================================================
-- SECTION 7/12 : VISUAL TAB
-- Fullbright + No Fog + HD Visual + Sky + Crosshair + FOV
-- =========================================================

-- =========================================================
-- ORIGINAL LIGHTING (buat reset)
-- =========================================================
local origLighting = {
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    Ambient = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient,
    GlobalShadows = Lighting.GlobalShadows,
    FogEnd = Lighting.FogEnd,
    FogStart = Lighting.FogStart,
}

local origSky = nil
for _, v in pairs(Lighting:GetChildren()) do
    if v:IsA("Sky") then
        origSky = v:Clone()
        break
    end
end

-- =========================================================
-- FULLBRIGHT
-- =========================================================
local Visual = {
    Fullbright = false,
    BrightnessVal = 100,
    NoFog = false,
    UltraHD = false,
    Contrast = false,
    ContrastVal = 0.3,
    SaturationVal = 0.2,
    HDSky = false,
    HDTexture = false,
    HDReflection = false,
    HDBloom = false,
    HDShadow = false,
    HDWater = false,
    HDSunRays = false,
    HDDepthField = false,
    HDAntiAliasing = false,
    SkyId = "Default",
    ZoomOut = false,
    ZoomOutValue = 500,
    FOVEnabled = false,
    FOV = 90,
}

local hdExtras = {}

local function applyFullbright(s)
    if s then
        local bright = math.clamp(Visual.BrightnessVal / 100, 0, 2)
        Lighting.Brightness = 0.5 + bright * 3
        Lighting.ClockTime = 14
        Lighting.Ambient = Color3.new(math.min(bright, 1), math.min(bright, 1), math.min(bright, 1))
        Lighting.OutdoorAmbient = Color3.new(math.min(bright, 1), math.min(bright, 1), math.min(bright, 1))
        Lighting.GlobalShadows = Visual.BrightnessVal < 100
        Lighting.FogEnd = 9e9
        Lighting.FogStart = 9e9
    else
        Lighting.Brightness = origLighting.Brightness
        Lighting.ClockTime = origLighting.ClockTime
        Lighting.Ambient = origLighting.Ambient
        Lighting.OutdoorAmbient = origLighting.OutdoorAmbient
        Lighting.GlobalShadows = origLighting.GlobalShadows
        Lighting.FogEnd = origLighting.FogEnd
        Lighting.FogStart = origLighting.FogStart
    end
end

-- =========================================================
-- NO FOG
-- =========================================================
local function applyNoFog(s)
    pcall(function()
        if s then
            for _, v in pairs(Lighting:GetChildren()) do
                if v:IsA("Atmosphere") then
                    v.Density = 0
                    v.Haze = 0
                    v.Glare = 0
                end
            end
            Lighting.FogEnd = 9e9
            Lighting.FogStart = 9e9
            Lighting.FogColor = Color3.fromRGB(255, 255, 255)
        else
            Lighting.FogEnd = origLighting.FogEnd or 100000
            Lighting.FogStart = origLighting.FogStart or 0
        end
    end)
end

-- =========================================================
-- ULTRA HD
-- =========================================================
local function applyUltraHD()
    if Visual.UltraHD then
        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level10
        end)
        Lighting.GlobalShadows = true
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
    end
end

-- =========================================================
-- CONTRAST
-- =========================================================
local function applyContrast()
    if Visual.Contrast then
        if not _G.OneWContrastFx then
            _G.OneWContrastFx = Instance.new("ColorCorrectionEffect")
            _G.OneWContrastFx.Parent = Lighting
        end
        _G.OneWContrastFx.Contrast = Visual.ContrastVal
        _G.OneWContrastFx.Saturation = Visual.SaturationVal
    else
        if _G.OneWContrastFx then
            _G.OneWContrastFx:Destroy()
            _G.OneWContrastFx = nil
        end
    end
end

-- =========================================================
-- HD VISUAL
-- =========================================================
local function applyHDSky(s)
    if s then
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("Atmosphere") then v:Destroy() end
        end
        pcall(function()
            Lighting.FogEnd = 100000
            Lighting.FogStart = 0
            Lighting.FogColor = Color3.fromRGB(200, 220, 255)
        end)
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("Sky") then v:Destroy() end
        end
        local cleanSky = Instance.new("Sky")
        cleanSky.Name = "OneWHDSky"
        cleanSky.SkyboxBk = "rbxassetid://159454299"
        cleanSky.SkyboxDn = "rbxassetid://159454296"
        cleanSky.SkyboxFt = "rbxassetid://159454293"
        cleanSky.SkyboxLf = "rbxassetid://159454286"
        cleanSky.SkyboxRt = "rbxassetid://159454300"
        cleanSky.SkyboxUp = "rbxassetid://159454288"
        cleanSky.Parent = Lighting

        local atmo = Instance.new("Atmosphere")
        atmo.Name = "OneWHDSkyAtmo"
        atmo.Density = 0.1
        atmo.Color = Color3.fromRGB(220, 230, 255)
        atmo.Decay = Color3.fromRGB(180, 200, 240)
        atmo.Parent = Lighting

        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.Ambient = Color3.fromRGB(150, 160, 180)
        Lighting.OutdoorAmbient = Color3.fromRGB(180, 190, 210)
    else
        local oldSky = Lighting:FindFirstChild("OneWHDSky")
        if oldSky then oldSky:Destroy() end
        local oldAtmo = Lighting:FindFirstChild("OneWHDSkyAtmo")
        if oldAtmo then oldAtmo:Destroy() end

        pcall(function()
            Lighting.FogEnd = origLighting.FogEnd
            Lighting.FogStart = origLighting.FogStart
            Lighting.Brightness = origLighting.Brightness
            Lighting.ClockTime = origLighting.ClockTime
        end)

        if origSky then
            local existing = Lighting:FindFirstChild("OneWOrigSky")
            if not existing then
                local c = origSky:Clone()
                c.Name = "OneWOrigSky"
                c.Parent = Lighting
            end
        end
    end
end

local function applyHDTexture(s)
    if s then
        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level10
        end)
    end
end

local function applyHDReflection(s)
    if s then
        if not hdExtras.Reflection then
            hdExtras.Reflection = Instance.new("ColorCorrectionEffect")
            hdExtras.Reflection.Name = "OneWReflection"
            hdExtras.Reflection.Brightness = 0.05
            hdExtras.Reflection.Contrast = 0.1
            hdExtras.Reflection.Parent = Lighting
        end
    else
        if hdExtras.Reflection then hdExtras.Reflection:Destroy(); hdExtras.Reflection = nil end
    end
end

local function applyHDBloom(s)
    if s then
        if not hdExtras.Bloom then
            hdExtras.Bloom = Instance.new("BloomEffect")
            hdExtras.Bloom.Name = "OneWBloom"
            hdExtras.Bloom.Intensity = 0.7
            hdExtras.Bloom.Size = 24
            hdExtras.Bloom.Threshold = 0.9
            hdExtras.Bloom.Parent = Lighting
        end
    else
        if hdExtras.Bloom then hdExtras.Bloom:Destroy(); hdExtras.Bloom = nil end
    end
end

local function applyHDShadow(s)
    if s then
        Lighting.GlobalShadows = true
    end
end

local function applyHDWater(s)
    if s then
        if not hdExtras.Water then
            hdExtras.Water = Instance.new("ColorCorrectionEffect")
            hdExtras.Water.Name = "OneWWater"
            hdExtras.Water.TintColor = Color3.fromRGB(180, 220, 255)
            hdExtras.Water.Parent = Lighting
        end
    else
        if hdExtras.Water then hdExtras.Water:Destroy(); hdExtras.Water = nil end
    end
end

local function applyHDSunRays(s)
    if s then
        if not hdExtras.SunRays then
            hdExtras.SunRays = Instance.new("SunRaysEffect")
            hdExtras.SunRays.Name = "OneWSunRays"
            hdExtras.SunRays.Intensity = 0.15
            hdExtras.SunRays.Spread = 1
            hdExtras.SunRays.Parent = Lighting
        end
    else
        if hdExtras.SunRays then hdExtras.SunRays:Destroy(); hdExtras.SunRays = nil end
    end
end

local function applyHDDepthField(s)
    if s then
        if not hdExtras.DepthField then
            hdExtras.DepthField = Instance.new("DepthOfFieldEffect")
            hdExtras.DepthField.Name = "OneWDOF"
            hdExtras.DepthField.FarIntensity = 0.15
            hdExtras.DepthField.FocusDistance = 20
            hdExtras.DepthField.InFocusRadius = 15
            hdExtras.DepthField.NearIntensity = 0.1
            hdExtras.DepthField.Parent = Lighting
        end
    else
        if hdExtras.DepthField then hdExtras.DepthField:Destroy(); hdExtras.DepthField = nil end
    end
end

local function applyHDAntiAliasing(s)
    if s then
        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level10
        end)
    end
end

-- =========================================================
-- SKY PRESET (18)
-- =========================================================
local SkyList = {
    "Default", "Sunset", "Night", "Space",
    "Alien", "Purple", "Galaxy", "Void",
    "GalaxyPurple", "GalaxyBlue", "GalaxyPink", "GalaxyMulticolor",
    "Nebula", "CosmicStorm", "Aurora",
    "SunsetHD", "NightHD", "DeepSpace",
}

local SkyIds = {
    Sunset = { Bk = "rbxassetid://169210149", Dn = "rbxassetid://169210108", Ft = "rbxassetid://169210121", Lf = "rbxassetid://169210133", Rt = "rbxassetid://169210143", Up = "rbxassetid://169210149" },
    Night = { Bk = "rbxassetid://18703245834", Dn = "rbxassetid://18703245834", Ft = "rbxassetid://18703245834", Lf = "rbxassetid://18703245834", Rt = "rbxassetid://18703245834", Up = "rbxassetid://18703245834" },
    Space = { Bk = "rbxassetid://17817511804", Dn = "rbxassetid://17817520184", Ft = "rbxassetid://17817511804", Lf = "rbxassetid://17817511804", Rt = "rbxassetid://17817511804", Up = "rbxassetid://17817511804" },
    Alien = { Bk = "rbxassetid://10253172001", Dn = "rbxassetid://10253172001", Ft = "rbxassetid://10253172001", Lf = "rbxassetid://10253172001", Rt = "rbxassetid://10253172001", Up = "rbxassetid://10253172001" },
    Purple = { Bk = "rbxassetid://6021017254", Dn = "rbxassetid://6021011228", Ft = "rbxassetid://6021017254", Lf = "rbxassetid://6021017254", Rt = "rbxassetid://6021017254", Up = "rbxassetid://6021017254" },
    Galaxy = { Bk = "rbxassetid://126146408999925", Dn = "rbxassetid://118112392224589", Ft = "rbxassetid://121253817183621", Lf = "rbxassetid://138429250948648", Rt = "rbxassetid://126146408999925", Up = "rbxassetid://126146408999925" },
    Void = { Bk = "rbxassetid://17817511804", Dn = "rbxassetid://17817520184", Ft = "rbxassetid://17817511804", Lf = "rbxassetid://17817511804", Rt = "rbxassetid://17817511804", Up = "rbxassetid://17817511804" },
    GalaxyPurple = { Bk = "rbxassetid://126146408999925", Dn = "rbxassetid://118112392224589", Ft = "rbxassetid://121253817183621", Lf = "rbxassetid://138429250948648", Rt = "rbxassetid://126146408999925", Up = "rbxassetid://126146408999925" },
    GalaxyBlue = { Bk = "rbxassetid://159454299", Dn = "rbxassetid://159454296", Ft = "rbxassetid://159454293", Lf = "rbxassetid://159454286", Rt = "rbxassetid://159454300", Up = "rbxassetid://159454288" },
    GalaxyPink = { Bk = "rbxassetid://6021017254", Dn = "rbxassetid://6021011228", Ft = "rbxassetid://6021017254", Lf = "rbxassetid://6021017254", Rt = "rbxassetid://6021017254", Up = "rbxassetid://6021017254" },
    GalaxyMulticolor = { Bk = "rbxassetid://126146408999925", Dn = "rbxassetid://118112392224589", Ft = "rbxassetid://121253817183621", Lf = "rbxassetid://138429250948648", Rt = "rbxassetid://126146408999925", Up = "rbxassetid://126146408999925" },
    Nebula = { Bk = "rbxassetid://126146408999925", Dn = "rbxassetid://118112392224589", Ft = "rbxassetid://121253817183621", Lf = "rbxassetid://138429250948648", Rt = "rbxassetid://126146408999925", Up = "rbxassetid://126146408999925" },
    CosmicStorm = { Bk = "rbxassetid://17817511804", Dn = "rbxassetid://17817520184", Ft = "rbxassetid://17817511804", Lf = "rbxassetid://17817511804", Rt = "rbxassetid://17817511804", Up = "rbxassetid://17817511804" },
    Aurora = { Bk = "rbxassetid://159454299", Dn = "rbxassetid://159454296", Ft = "rbxassetid://159454293", Lf = "rbxassetid://159454286", Rt = "rbxassetid://159454300", Up = "rbxassetid://159454288" },
    SunsetHD = { Bk = "rbxassetid://169210149", Dn = "rbxassetid://169210108", Ft = "rbxassetid://169210121", Lf = "rbxassetid://169210133", Rt = "rbxassetid://169210143", Up = "rbxassetid://169210149" },
    NightHD = { Bk = "rbxassetid://18703245834", Dn = "rbxassetid://18703245834", Ft = "rbxassetid://18703245834", Lf = "rbxassetid://18703245834", Rt = "rbxassetid://18703245834", Up = "rbxassetid://18703245834" },
    DeepSpace = { Bk = "rbxassetid://17817511804", Dn = "rbxassetid://17817520184", Ft = "rbxassetid://17817511804", Lf = "rbxassetid://17817511804", Rt = "rbxassetid://17817511804", Up = "rbxassetid://17817511804" },
}

local function applySky(skyName)
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("Sky") then v:Destroy() end
    end

    if not skyName or skyName == "Default" then
        if origSky then
            local c = origSky:Clone()
            c.Name = "OneWOrigSky"
            c.Parent = Lighting
        end
        return
    end

    local ids = SkyIds[skyName]
    if not ids then
        ids = SkyIds.SunsetHD
    end

    local sky = Instance.new("Sky")
    sky.Name = "OneWSky_" .. skyName
    sky.SkyboxBk = ids.Bk
    sky.SkyboxDn = ids.Dn or ids.Bk
    sky.SkyboxFt = ids.Ft or ids.Bk
    sky.SkyboxLf = ids.Lf or ids.Bk
    sky.SkyboxRt = ids.Rt or ids.Bk
    sky.SkyboxUp = ids.Up or ids.Bk
    sky.Parent = Lighting
end

-- =========================================================
-- CROSSHAIR
-- =========================================================
local Crosshair = {
    Enabled = false,
    Size = 8,
    Thickness = 2,
    Color = Color3.fromRGB(0, 220, 255),
    OffsetX = 0,
    OffsetY = 0,
}

local crosshairGui = nil
local crosshairParts = {}

local function clearCrosshair()
    if crosshairGui then
        crosshairGui:Destroy()
        crosshairGui = nil
    end
    crosshairParts = {}
end

local function applyCrosshair(enable)
    clearCrosshair()
    if not enable then return end

    crosshairGui = Instance.new("ScreenGui")
    crosshairGui.Name = "OneWCrosshair"
    crosshairGui.ResetOnSpawn = false
    crosshairGui.IgnoreGuiInset = true
    crosshairGui.Parent = PlayerGui

    local container = Instance.new("Frame")
    container.Size = UDim2.new(0, 0, 0, 0)
    container.Position = UDim2.new(0.5, Crosshair.OffsetX, 0.5, Crosshair.OffsetY)
    container.AnchorPoint = Vector2.new(0.5, 0.5)
    container.BackgroundTransparency = 1
    container.Parent = crosshairGui

    local size = Crosshair.Size
    local thickness = Crosshair.Thickness

    local function mkBar(w, h, x, y)
        local f = Instance.new("Frame")
        f.Size = UDim2.new(0, w, 0, h)
        f.Position = UDim2.new(0, x, 0, y)
        f.AnchorPoint = Vector2.new(0.5, 0.5)
        f.BackgroundColor3 = Crosshair.Color
        f.BorderSizePixel = 0
        f.Parent = container
        table.insert(crosshairParts, f)
    end

    mkBar(size, thickness, -size/2 - 2, 0)
    mkBar(size, thickness,  size/2 + 2, 0)
    mkBar(thickness, size, 0, -size/2 - 2)
    mkBar(thickness, size, 0,  size/2 + 2)
end

-- =========================================================
-- ZOOM OUT & FOV
-- =========================================================
local function applyZoomOut(enable, value)
    if enable then
        LocalPlayer.CameraMaxZoomDistance = value or 500
        LocalPlayer.CameraMinZoomDistance = 0.5
    else
        LocalPlayer.CameraMaxZoomDistance = 128
        LocalPlayer.CameraMinZoomDistance = 0.5
    end
end

local function applyFOV()
    local cam = workspace.CurrentCamera
    if cam then
        cam.FieldOfView = Visual.FOVEnabled and Visual.FOV or 90
    end
end

-- =========================================================
-- TAB VISUAL - UI
-- =========================================================
local LightBox = Tabs.Visual:AddLeftGroupbox("Lighting", "sun")
local SkyBox = Tabs.Visual:AddRightGroupbox("Sky & HD", "cloud")

-- KIRI: Lighting
LightBox:AddCheckbox("Fullbright", {
    Text = "Fullbright",
    Default = false,
    Callback = function(v)
        Visual.Fullbright = v
        applyFullbright(v)
    end
})

LightBox:AddSlider("BrightnessVal", {
    Text = "Brightness Level",
    Default = 100,
    Min = 10,
    Max = 200,
    Rounding = 0,
    Callback = function(v)
        Visual.BrightnessVal = v
        if Visual.Fullbright then applyFullbright(true) end
    end
})

LightBox:AddCheckbox("NoFog", {
    Text = "No Fog",
    Default = false,
    Callback = function(v)
        Visual.NoFog = v
        applyNoFog(v)
    end
})

LightBox:AddCheckbox("UltraHD", {
    Text = "Ultra HD",
    Default = false,
    Callback = function(v)
        Visual.UltraHD = v
        applyUltraHD()
    end
})

LightBox:AddCheckbox("Contrast", {
    Text = "Contrast Boost",
    Default = false,
    Callback = function(v)
        Visual.Contrast = v
        applyContrast()
    end
})

LightBox:AddSlider("ContrastVal", {
    Text = "Contrast",
    Default = 0.3,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(v)
        Visual.ContrastVal = v
        applyContrast()
    end
})

LightBox:AddSlider("SaturationVal", {
    Text = "Saturation",
    Default = 0.2,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Callback = function(v)
        Visual.SaturationVal = v
        applyContrast()
    end
})

-- KANAN: Sky & HD
SkyBox:AddDropdown("SkyPreset", {
    Values = SkyList,
    Default = 1,
    Multi = false,
    Text = "Sky Preset (18)",
    Callback = function(v)
        Visual.SkyId = v
        applySky(v)
    end
})

SkyBox:AddCheckbox("HDSky", {
    Text = "HD Sky (Clean)",
    Default = false,
    Callback = function(v)
        Visual.HDSky = v
        applyHDSky(v)
    end
})

SkyBox:AddCheckbox("HDTexture", {
    Text = "HD Texture",
    Default = false,
    Callback = function(v) Visual.HDTexture = v; applyHDTexture(v) end
})

SkyBox:AddCheckbox("HDReflection", {
    Text = "HD Reflection",
    Default = false,
    Callback = function(v) Visual.HDReflection = v; applyHDReflection(v) end
})

SkyBox:AddCheckbox("HDBloom", {
    Text = "HD Bloom",
    Default = false,
    Callback = function(v) Visual.HDBloom = v; applyHDBloom(v) end
})

SkyBox:AddCheckbox("HDShadow", {
    Text = "HD Shadow",
    Default = false,
    Callback = function(v) Visual.HDShadow = v; applyHDShadow(v) end
})

SkyBox:AddCheckbox("HDWater", {
    Text = "HD Water",
    Default = false,
    Callback = function(v) Visual.HDWater = v; applyHDWater(v) end
})

SkyBox:AddCheckbox("HDSunRays", {
    Text = "HD Sun Rays",
    Default = false,
    Callback = function(v) Visual.HDSunRays = v; applyHDSunRays(v) end
})

SkyBox:AddCheckbox("HDDepthField", {
    Text = "HD Depth of Field",
    Default = false,
    Callback = function(v) Visual.HDDepthField = v; applyHDDepthField(v) end
})

SkyBox:AddCheckbox("HDAntiAliasing", {
    Text = "HD Anti-Aliasing",
    Default = false,
    Callback = function(v) Visual.HDAntiAliasing = v; applyHDAntiAliasing(v) end
})

-- =========================================================
-- SUB-TAB CROSSHAIR + CAMERA
-- =========================================================
local VisualTab = Tabs.Visual:AddLeftTabbox()
local CrossBox = VisualTab:AddTab("Crosshair", "crosshair")
local CameraBox = VisualTab:AddTab("Camera", "camera")

CrossBox:AddCheckbox("Crosshair_Enabled", {
    Text = "Enable Crosshair",
    Default = false,
    Callback = function(v)
        Crosshair.Enabled = v
        applyCrosshair(v)
    end
})

CrossBox:AddSlider("Crosshair_Size", {
    Text = "Crosshair Size",
    Default = 8,
    Min = 4,
    Max = 30,
    Rounding = 0,
    Callback = function(v)
        Crosshair.Size = v
        if Crosshair.Enabled then applyCrosshair(true) end
    end
})

CrossBox:AddSlider("Crosshair_Thickness", {
    Text = "Crosshair Thickness",
    Default = 2,
    Min = 1,
    Max = 6,
    Rounding = 0,
    Callback = function(v)
        Crosshair.Thickness = v
        if Crosshair.Enabled then applyCrosshair(true) end
    end
})

CrossBox:AddColorPicker("Crosshair_Color", {
    Default = Color3.fromRGB(0, 220, 255),
    Title = "Crosshair Color",
    Callback = function(c)
        Crosshair.Color = c
        if Crosshair.Enabled then applyCrosshair(true) end
    end
})

CrossBox:AddSlider("Crosshair_OffX", {
    Text = "Offset X",
    Default = 0,
    Min = -200,
    Max = 200,
    Rounding = 0,
    Callback = function(v)
        Crosshair.OffsetX = v
        if Crosshair.Enabled then applyCrosshair(true) end
    end
})

CrossBox:AddSlider("Crosshair_OffY", {
    Text = "Offset Y",
    Default = 0,
    Min = -200,
    Max = 200,
    Rounding = 0,
    Callback = function(v)
        Crosshair.OffsetY = v
        if Crosshair.Enabled then applyCrosshair(true) end
    end
})

CameraBox:AddCheckbox("ZoomOut_Enabled", {
    Text = "Zoom Out",
    Default = false,
    Callback = function(v)
        Visual.ZoomOut = v
        applyZoomOut(v, Visual.ZoomOutValue)
    end
})

CameraBox:AddSlider("ZoomOut_Value", {
    Text = "Max Zoom Distance",
    Default = 500,
    Min = 100,
    Max = 1000,
    Rounding = 0,
    Callback = function(v)
        Visual.ZoomOutValue = v
        if Visual.ZoomOut then applyZoomOut(true, v) end
    end
})

CameraBox:AddCheckbox("FOV_Enabled", {
    Text = "Custom FOV",
    Default = false,
    Callback = function(v)
        Visual.FOVEnabled = v
        applyFOV()
    end
})

CameraBox:AddSlider("FOV_Value", {
    Text = "FOV Value",
    Default = 90,
    Min = 40,
    Max = 120,
    Rounding = 0,
    Callback = function(v)
        Visual.FOV = v
        if Visual.FOVEnabled then applyFOV() end
    end
})

print("✅ [7/12] One W - Visual Tab Loaded")-- =========================================================
-- SECTION 8/12 : MISC TAB
-- Walk Speed + Speed Hack + No Clip + Anti-AFK + Hitbox
-- =========================================================

-- =========================================================
-- MOVEMENT CONFIG
-- =========================================================
local Movement = {
    WalkSpeed = false,
    WalkSpeedVal = 16,
    SpeedHack = false,
    SpeedHackVal = 40,
    NoClip = false,
    NoClipCamera = false,
}

local NoClipConnection = nil

-- =========================================================
-- WALK SPEED
-- =========================================================
task.spawn(function()
    while task.wait(0.2) do
        if not Movement.WalkSpeed or Movement.SpeedHack then continue end
        local char = LocalPlayer.Character
        if not char then continue end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum and hum.WalkSpeed ~= Movement.WalkSpeedVal then
            hum.WalkSpeed = Movement.WalkSpeedVal
        end
    end
end)

-- =========================================================
-- SPEED HACK
-- =========================================================
task.spawn(function()
    while task.wait(0.2) do
        if not Movement.SpeedHack then continue end
        local char = LocalPlayer.Character
        if not char then continue end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum and hum.WalkSpeed ~= Movement.SpeedHackVal then
            hum.WalkSpeed = Movement.SpeedHackVal
        end
    end
end)

-- =========================================================
-- NO CLIP
-- =========================================================
local function applyNoClip()
    local char = LocalPlayer.Character
    if not char then return end
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("BasePart") and v.CanCollide then
            if Movement.NoClip then
                v.CanCollide = false
            else
                v.CanCollide = true
            end
        end
    end
end

local function toggleNoClip(state)
    Movement.NoClip = state
    if state then
        if NoClipConnection then NoClipConnection:Disconnect() end
        NoClipConnection = RunService.RenderStepped:Connect(function()
            if Movement.NoClip then applyNoClip() end
        end)
    else
        if NoClipConnection then
            NoClipConnection:Disconnect()
            NoClipConnection = nil
        end
        applyNoClip()
    end
end

-- =========================================================
-- NO CLIP CAMERA
-- =========================================================
task.spawn(function()
    while task.wait(0.2) do
        local cam = workspace.CurrentCamera
        if cam then
            cam.CanCollide = not Movement.NoClipCamera
        end
    end
end)

-- =========================================================
-- ANTI AFK
-- =========================================================
local AntiAFK = {
    Enabled = false,
}

task.spawn(function()
    while task.wait(120) do
        if AntiAFK.Enabled then
            pcall(function()
                local VirtualUser = game:GetService("VirtualUser")
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end
    end
end)

-- =========================================================
-- INSTANT INTERACT
-- =========================================================
local InstantInteract = {
    Enabled = false,
}

task.spawn(function()
    while task.wait(0.3) do
        if not InstantInteract.Enabled then continue end
        local char = LocalPlayer.Character
        if not char then continue end
        local myRoot = char:FindFirstChild("HumanoidRootPart")
        if not myRoot then continue end

        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("ProximityPrompt") then
                local parent = obj.Parent
                local pos
                if parent:IsA("BasePart") then pos = parent.Position
                elseif parent:IsA("Model") then pos = parent:GetPivot().Position end
                if pos and (pos - myRoot.Position).Magnitude <= 12 then
                    pcall(function()
                        obj:InputHoldBegin()
                        task.wait(0.05)
                        obj:InputHoldEnd()
                    end)
                end
            end
        end
    end
end)

-- =========================================================
-- HITBOX SYSTEM
-- =========================================================
local Hitbox = {
    Enabled = false,
    Size = 70,
    TextSize = 10,
    Mode = "Auto",
    WallBang = true,
    ColorKiller = Color3.fromRGB(255, 60, 60),
    ColorSurvivor = Color3.fromRGB(60, 255, 120),
}

local HitboxTextObjects = {}
local HitboxOriginalSizes = {}

local function hitboxCreateText(targetPart, sizeValue, color)
    if not targetPart then return end
    local char = targetPart.Parent
    if not char then return end

    local existing = char:FindFirstChild("OneWHitboxText")
    if existing then
        local lbl = existing:FindFirstChildOfClass("TextLabel")
        if lbl then
            lbl.Text = tostring(sizeValue)
            lbl.TextColor3 = color or Color3.fromRGB(255, 255, 255)
            lbl.TextSize = Hitbox.TextSize
        end
        return
    end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "OneWHitboxText"
    billboard.Size = UDim2.new(0, 60, 0, 30)
    billboard.AlwaysOnTop = true
    billboard.StudsOffset = Vector3.new(0, 3.5, 0)
    billboard.Adornee = targetPart
    billboard.Parent = char

    local lbl = Instance.new("TextLabel")
    lbl.Name = "HitboxLabel"
    lbl.Size = UDim2.new(1, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = tostring(sizeValue)
    lbl.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    lbl.TextStrokeTransparency = 0
    lbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = Hitbox.TextSize
    lbl.Parent = billboard

    HitboxTextObjects[targetPart] = billboard
end

local function hitboxRemoveText(targetPart)
    if not targetPart then return end
    local char = targetPart.Parent
    if char then
        local billboard = char:FindFirstChild("OneWHitboxText")
        if billboard then billboard:Destroy() end
    end
    HitboxTextObjects[targetPart] = nil
end

local function hitboxClearAll()
    for part, _ in pairs(HitboxTextObjects) do
        hitboxRemoveText(part)
    end
    HitboxTextObjects = {}
    for part, origSize in pairs(HitboxOriginalSizes) do
        if part and part.Parent then
            part.Size = origSize
            part.Transparency = 0
        end
    end
    HitboxOriginalSizes = {}
end

local function hitboxUpdateVisibility()
    for part, billboard in pairs(HitboxTextObjects) do
        if billboard and billboard.Parent then
            local lbl = billboard:FindFirstChildOfClass("TextLabel")
            if lbl then
                lbl.TextSize = Hitbox.TextSize
            end
        end
    end
end

task.spawn(function()
    while task.wait(0.3) do
        if not Hitbox.Enabled then
            hitboxClearAll()
            continue
        end

        local char = LocalPlayer.Character
        if not char then continue end
        local myRoot = char:FindFirstChild("HumanoidRootPart")
        if not myRoot then continue end
        local myTeam = LocalPlayer.Team and LocalPlayer.Team.Name or ""

        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local targetTeam = p.Team and p.Team.Name or ""
                local shouldHit = false

                if Hitbox.Mode == "Auto" then
                    if myTeam == "Survivors" and targetTeam == "Killer" then
                        shouldHit = true
                    elseif myTeam == "Killer" and targetTeam == "Survivors" then
                        shouldHit = true
                    end
                elseif Hitbox.Mode == "Killer" and targetTeam == "Killer" then
                    shouldHit = true
                elseif Hitbox.Mode == "Survivor" and targetTeam == "Survivors" then
                    shouldHit = true
                end

                if shouldHit then
                    local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                    local hum = p.Character:FindFirstChildOfClass("Humanoid")
                    if hrp and hum and hum.Health > 0 then
                        local dist = (hrp.Position - myRoot.Position).Magnitude
                        if not HitboxOriginalSizes[hrp] then
                            HitboxOriginalSizes[hrp] = hrp.Size
                        end
                        if dist <= Hitbox.Size then
                            hrp.Size = Vector3.new(Hitbox.Size, Hitbox.Size, Hitbox.Size)
                            hrp.Transparency = 1
                            hrp.CanCollide = not Hitbox.WallBang
                        end

                        local color = (targetTeam == "Killer")
                            and Hitbox.ColorKiller
                            or Hitbox.ColorSurvivor

                        hitboxCreateText(hrp, Hitbox.Size, color)
                    end
                end
            end
        end
    end
end)

-- =========================================================
-- FPS + PING COUNTER
-- =========================================================
local FPSState = {
    ShowFPS = false,
    ShowPing = false,
}

local fpsPingGui = nil
local fpsCounter = 0
local fpsLastTime = tick()
local currentFPS = 0
local currentPing = 0

local function createFPSPingGui()
    if fpsPingGui then fpsPingGui:Destroy() end
    fpsPingGui = Instance.new("ScreenGui")
    fpsPingGui.Name = "OneWFPSPing"
    fpsPingGui.ResetOnSpawn = false
    fpsPingGui.IgnoreGuiInset = true
    fpsPingGui.DisplayOrder = 999
    fpsPingGui.Parent = PlayerGui

    local frame = Instance.new("Frame")
    frame.Name = "MainFrame"
    frame.Size = UDim2.new(0, 110, 0, 20)
    frame.Position = UDim2.new(1, -120, 0, 5)
    frame.BackgroundColor3 = Color3.fromRGB(45, 8, 12)
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.Parent = fpsPingGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1
    stroke.Color = Color3.fromRGB(180, 30, 40)
    stroke.Transparency = 0.4
    stroke.Parent = frame

    local label = Instance.new("TextLabel")
    label.Name = "StatsLabel"
    label.Size = UDim2.new(1, -6, 1, 0)
    label.Position = UDim2.new(0, 3, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = "FPS: 0 | Ping: 0"
    label.TextColor3 = Color3.fromRGB(220, 80, 90)
    label.TextSize = 10
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.Parent = frame
end

task.spawn(function()
    task.wait(3)
    pcall(createFPSPingGui)
end)

RunService.RenderStepped:Connect(function()
    fpsCounter = fpsCounter + 1
    if tick() - fpsLastTime >= 1 then
        currentFPS = fpsCounter
        fpsCounter = 0
        fpsLastTime = tick()
        pcall(function()
            currentPing = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        end)
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        if not fpsPingGui or not fpsPingGui.Parent then
            pcall(createFPSPingGui)
        end
        if fpsPingGui then
            local frame = fpsPingGui:FindFirstChild("MainFrame")
            if frame then
                local label = frame:FindFirstChild("StatsLabel")
                if label then
                    local fpsText = FPSState.ShowFPS and tostring(currentFPS) or "OFF"
                    local pingText = FPSState.ShowPing and (tostring(currentPing) .. "ms") or "OFF"
                    label.Text = "FPS: " .. fpsText .. " | Ping: " .. pingText
                end
            end
        end
    end
end)

-- =========================================================
-- REJOIN
-- =========================================================
local function rejoinServer()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
end

-- =========================================================
-- TAB MISC - UI
-- =========================================================
local MoveBox = Tabs.Misc:AddLeftGroupbox("Movement", "move")
local UtilBox = Tabs.Misc:AddRightGroupbox("Utility", "wrench")

-- KIRI: Movement
MoveBox:AddCheckbox("Movement_WalkSpeed", {
    Text = "Walk Speed",
    Default = false,
    Callback = function(v) Movement.WalkSpeed = v end
})

MoveBox:AddSlider("Movement_WalkSpeedVal", {
    Text = "Walk Speed Value",
    Default = 16,
    Min = 16,
    Max = 100,
    Rounding = 0,
    Callback = function(v) Movement.WalkSpeedVal = v end
})

MoveBox:AddCheckbox("Movement_SpeedHack", {
    Text = "Speed Hack",
    Default = false,
    Callback = function(v) Movement.SpeedHack = v end
})

MoveBox:AddSlider("Movement_SpeedHackVal", {
    Text = "Speed Hack Value",
    Default = 40,
    Min = 20,
    Max = 200,
    Rounding = 0,
    Callback = function(v) Movement.SpeedHackVal = v end
})

MoveBox:AddCheckbox("Movement_NoClip", {
    Text = "No Clip",
    Default = false,
    Callback = function(v) toggleNoClip(v) end
})

MoveBox:AddCheckbox("Movement_NoClipCam", {
    Text = "No Clip Camera",
    Default = false,
    Callback = function(v) Movement.NoClipCamera = v end
})

-- KANAN: Utility
UtilBox:AddCheckbox("Utility_AntiAFK", {
    Text = "Anti-AFK",
    Default = false,
    Callback = function(v) AntiAFK.Enabled = v end
})

UtilBox:AddCheckbox("Utility_InstantInteract", {
    Text = "Instant Interact",
    Default = false,
    Callback = function(v) InstantInteract.Enabled = v end
})

UtilBox:AddCheckbox("Utility_ShowFPS", {
    Text = "Show FPS Counter",
    Default = false,
    Callback = function(v) FPSState.ShowFPS = v end
})

UtilBox:AddCheckbox("Utility_ShowPing", {
    Text = "Show Ping Counter",
    Default = false,
    Callback = function(v) FPSState.ShowPing = v end
})

UtilBox:AddButton({
    Text = "Rejoin Server",
    Func = function() rejoinServer() end
})

-- =========================================================
-- SUB-TAB HITBOX
-- =========================================================
local MiscTab = Tabs.Misc:AddLeftTabbox()
local HitboxBox = MiscTab:AddTab("Hitbox", "box")

HitboxBox:AddCheckbox("Hitbox_Enabled", {
    Text = "Enable Hitbox",
    Default = false,
    Callback = function(v)
        Hitbox.Enabled = v
        if not v then hitboxClearAll() end
    end
})

HitboxBox:AddSlider("Hitbox_Size", {
    Text = "Hitbox Size",
    Default = 70,
    Min = 10,
    Max = 70,
    Rounding = 0,
    Callback = function(v)
        Hitbox.Size = v
        hitboxUpdateVisibility()
    end
})

HitboxBox:AddSlider("Hitbox_TextSize", {
    Text = "Text Size",
    Default = 10,
    Min = 5,
    Max = 30,
    Rounding = 0,
    Callback = function(v)
        Hitbox.TextSize = v
        hitboxUpdateVisibility()
    end
})

HitboxBox:AddDropdown("Hitbox_Mode", {
    Values = {"Auto", "Killer", "Survivor"},
    Default = 1,
    Multi = false,
    Text = "Mode",
    Callback = function(v) Hitbox.Mode = v end
})

HitboxBox:AddColorPicker("Hitbox_KillerColor", {
    Default = Color3.fromRGB(255, 60, 60),
    Title = "Killer Text Color",
    Callback = function(c)
        Hitbox.ColorKiller = c
        hitboxUpdateVisibility()
    end
})

HitboxBox:AddColorPicker("Hitbox_SurvivorColor", {
    Default = Color3.fromRGB(60, 255, 120),
    Title = "Survivor Text Color",
    Callback = function(c)
        Hitbox.ColorSurvivor = c
        hitboxUpdateVisibility()
    end
})

HitboxBox:AddCheckbox("Hitbox_WallBang", {
    Text = "Wall Bang",
    Default = true,
    Callback = function(v) Hitbox.WallBang = v end
})

print("✅ [8/12] One W - Misc Tab Loaded")-- =========================================================
-- SECTION 9/12 : EXTRAS TAB
-- Kill Feed + Stun Notify + God Mode + Aimlock
-- =========================================================

-- =========================================================
-- GOD MODE
-- =========================================================
local GodMode = {
    Enabled = false,
}

local function applyGodMode()
    if not GodMode.Enabled then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end

    if hum.Health < hum.MaxHealth then
        pcall(function() hum.Health = hum.MaxHealth end)
    end

    local state = hum:GetState()
    if state == Enum.HumanoidStateType.Dead
        or state == Enum.HumanoidStateType.FallingDown
        or state == Enum.HumanoidStateType.Ragdoll then
        pcall(function() hum:ChangeState(Enum.HumanoidStateType.Running) end)
    end
end

task.spawn(function()
    while task.wait(0.1) do
        applyGodMode()
    end
end)

-- =========================================================
-- AIMLOCK (Aimbot Killer Hold to Aim)
-- =========================================================
local Aimlock = {
    Enabled = false,
    Holding = false,
    Radius = 80,
    AimPart = "HumanoidRootPart",
    Target = nil,
}

local function getAimTarget()
    local char = LocalPlayer.Character
    if not char then return nil end
    local myRoot = char:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end

    local closest, shortest = nil, Aimlock.Radius

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Team and p.Team.Name == "Survivors" then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            local targetPart = p.Character:FindFirstChild(Aimlock.AimPart)
            if hum and hum.Health > 0 and targetPart then
                local dist = (targetPart.Position - myRoot.Position).Magnitude
                if dist < shortest then
                    shortest = dist
                    closest = targetPart
                end
            end
        end
    end
    return closest
end

-- Hook tombol attack (untuk hold)
local attackHooked = false
local function hookAttackButtons()
    if attackHooked then return end
    for _, obj in pairs(PlayerGui:GetDescendants()) do
        if obj:IsA("GuiObject") and obj.Visible then
            local n = string.lower(obj.Name)
            if (n:find("attack") or n:find("slash") or n:find("swing"))
                and not obj:GetAttribute("OneWAimHook") then
                obj:SetAttribute("OneWAimHook", true)
                obj.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1
                        or input.UserInputType == Enum.UserInputType.Touch then
                        Aimlock.Holding = true
                    end
                end)
                obj.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1
                        or input.UserInputType == Enum.UserInputType.Touch then
                        Aimlock.Holding = false
                    end
                end)
            end
        end
    end
end

task.spawn(function()
    while task.wait(2) do
        if Aimlock.Enabled then
            pcall(hookAttackButtons)
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if not Aimlock.Enabled then return end
    if not Aimlock.Holding then
        Aimlock.Target = nil
        return
    end
    local target = getAimTarget()
    if not target then
        Aimlock.Target = nil
        return
    end
    Aimlock.Target = target
    local cam = workspace.CurrentCamera
    if cam then
        local camPos = cam.CFrame.Position
        cam.CFrame = CFrame.new(camPos, target.Position)
    end
end)

-- =========================================================
-- KILL FEED
-- =========================================================
local KillFeedState = {
    Enabled = false,
}

local killFeedGui = nil
local killFeedFrame = nil

local function createKillFeedGui()
    if killFeedGui then return end
    killFeedGui = Instance.new("ScreenGui")
    killFeedGui.Name = "OneWKillFeed"
    killFeedGui.ResetOnSpawn = false
    killFeedGui.IgnoreGuiInset = true
    killFeedGui.Parent = PlayerGui

    killFeedFrame = Instance.new("Frame")
    killFeedFrame.Size = UDim2.new(0, 250, 0, 200)
    killFeedFrame.Position = UDim2.new(1, -260, 0, 50)
    killFeedFrame.BackgroundTransparency = 1
    killFeedFrame.Parent = killFeedGui

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 4)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    layout.Parent = killFeedFrame
end

task.spawn(createKillFeedGui)

local function addKillFeed(killerName, survivorName)
    if not KillFeedState.Enabled or not killFeedFrame then return end

    local entry = Instance.new("Frame")
    entry.Size = UDim2.new(1, 0, 0, 28)
    entry.BackgroundColor3 = Color3.fromRGB(60, 12, 18)
    entry.BackgroundTransparency = 0.2
    entry.BorderSizePixel = 0
    entry.Parent = killFeedFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = entry

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(180, 30, 40)
    stroke.Thickness = 1
    stroke.Transparency = 0.5
    stroke.Parent = entry

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -10, 1, 0)
    lbl.Position = UDim2.new(0, 5, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = killerName .. " > " .. survivorName
    lbl.TextColor3 = Color3.fromRGB(220, 180, 180)
    lbl.TextSize = 11
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = entry

    task.spawn(function()
        task.wait(4)
        TweenService:Create(entry, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
        TweenService:Create(lbl, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
        task.wait(0.6)
        entry:Destroy()
    end)
end

task.spawn(function()
    local lastHealth = {}
    while task.wait(0.5) do
        if not KillFeedState.Enabled then continue end
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character then
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                if hum then
                    local prevHP = lastHealth[p] or hum.Health
                    if prevHP > 0 and hum.Health <= 0 then
                        local killerName = "???"
                        if p:GetAttribute("LastAttacker") then
                            killerName = p:GetAttribute("LastAttacker")
                        end
                        addKillFeed(killerName, p.Name)
                    end
                    lastHealth[p] = hum.Health
                end
            end
        end
    end
end)

-- =========================================================
-- STUN NOTIFY
-- =========================================================
local StunState = {
    Enabled = false,
}

local stunIcons = {}

local function createStunIcon(killerChar)
    if stunIcons[killerChar] then return end
    local head = killerChar:FindFirstChild("Head")
    if not head then return end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "OneWStunIcon"
    billboard.Size = UDim2.new(0, 60, 0, 60)
    billboard.AlwaysOnTop = true
    billboard.StudsOffset = Vector3.new(0, 4, 0)
    billboard.Adornee = head
    billboard.Parent = head

    local icon = Instance.new("TextLabel")
    icon.Size = UDim2.new(1, 0, 1, 0)
    icon.BackgroundTransparency = 1
    icon.Text = "STUN"
    icon.TextColor3 = Color3.fromRGB(255, 100, 100)
    icon.TextSize = 20
    icon.Font = Enum.Font.GothamBlack
    icon.TextStrokeTransparency = 0
    icon.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    icon.Parent = billboard

    task.spawn(function()
        while billboard.Parent do
            billboard.StudsOffset = Vector3.new(0, 4 + math.sin(tick() * 5) * 0.5, 0)
            icon.Rotation = math.sin(tick() * 8) * 20
            task.wait(0.08)
        end
    end)

    stunIcons[killerChar] = billboard
end

local function removeStunIcon(killerChar)
    if stunIcons[killerChar] then
        stunIcons[killerChar]:Destroy()
        stunIcons[killerChar] = nil
    end
end

task.spawn(function()
    while task.wait(0.3) do
        if not StunState.Enabled then continue end

        local char = LocalPlayer.Character
        if not char then continue end
        local myRoot = char:FindFirstChild("HumanoidRootPart")
        if not myRoot then continue end

        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Team and p.Team.Name == "Killer" then
                local krp = p.Character:FindFirstChild("HumanoidRootPart")
                if krp then
                    local dist = (krp.Position - myRoot.Position).Magnitude
                    if dist <= 80 then
                        local isStunned = false
                        local khum = p.Character:FindFirstChildOfClass("Humanoid")
                        if khum then
                            local animator = khum:FindFirstChildOfClass("Animator")
                            if animator then
                                for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
                                    local a = track.Animation
                                    if a and a.AnimationId then
                                        local id = a.AnimationId:match("%d+")
                                        if id == "123047897844134" then
                                            isStunned = true
                                            break
                                        end
                                    end
                                end
                            end
                        end
                        if isStunned then createStunIcon(p.Character)
                        else removeStunIcon(p.Character) end
                    else
                        removeStunIcon(p.Character)
                    end
                end
            end
        end
    end
end)

-- =========================================================
-- TAB EXTRAS - UI
-- =========================================================
local NotifyBox = Tabs.Extras:AddLeftGroupbox("Notifications", "bell")
local GodBox = Tabs.Extras:AddRightGroupbox("God & Aimlock", "shield")

-- KIRI: Notifications
NotifyBox:AddCheckbox("KillFeed_Enabled", {
    Text = "Kill Feed",
    Default = false,
    Callback = function(v) KillFeedState.Enabled = v end
})

NotifyBox:AddCheckbox("StunNotify_Enabled", {
    Text = "Stun Notify",
    Default = false,
    Callback = function(v) StunState.Enabled = v end
})

-- KANAN: God & Aimlock
GodBox:AddCheckbox("GodMode_Enabled", {
    Text = "God Mode",
    Default = false,
    Callback = function(v) GodMode.Enabled = v end
})

GodBox:AddCheckbox("Aimlock_Enabled", {
    Text = "Aimlock (Hold Attack)",
    Default = false,
    Callback = function(v)
        Aimlock.Enabled = v
        if v then hookAttackButtons() end
    end
})

GodBox:AddSlider("Aimlock_Radius", {
    Text = "Aimlock Radius",
    Default = 80,
    Min = 5,
    Max = 200,
    Rounding = 0,
    Callback = function(v) Aimlock.Radius = v end
})

GodBox:AddDropdown("Aimlock_Part", {
    Values = {"HumanoidRootPart", "Head", "UpperTorso"},
    Default = 1,
    Multi = false,
    Text = "Aim Part",
    Callback = function(v) Aimlock.AimPart = v end
})

print("✅ [9/12] One W - Extras Tab Loaded")-- =========================================================
-- SECTION 10/12 : UI SETTINGS TAB
-- Theme + Save + Notification + Cursor + DPI + Unload
-- =========================================================

-- =========================================================
-- THEME MANAGER & SAVE MANAGER
-- =========================================================
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})

ThemeManager:SetFolder("OneW")
SaveManager:SetFolder("OneW/configs")

SaveManager:BuildConfigSection(Tabs.UISettings)

-- =========================================================
-- SETTINGS GROUPBOX
-- =========================================================
local SettingBox = Tabs.UISettings:AddLeftGroupbox("Menu Settings", "wrench")

-- CUSTOM CURSOR
SettingBox:AddToggle("ShowCustomCursor", {
    Text = "Custom Cursor",
    Default = true,
    Callback = function(Value)
        Library.ShowCustomCursor = Value
    end,
})

-- NOTIFICATION SIDE
SettingBox:AddDropdown("NotificationSide", {
    Values = { "Left", "Right" },
    Default = "Right",
    Text = "Notification Side",
    Callback = function(Value)
        Library:SetNotifySide(Value)
    end,
})

-- DPI SCALE
SettingBox:AddDropdown("DPIDropdown", {
    Values = { "50%", "75%", "85%", "100%", "125%", "150%" },
    Default = "85%",
    Text = "DPI Scale",
    Callback = function(Value)
        Value = Value:gsub("%%", "")
        local DPI = tonumber(Value)
        Library:SetDPIScale(DPI)
    end,
})

-- CORNER RADIUS
SettingBox:AddSlider("UICornerSlider", {
    Text = "Corner Radius",
    Default = Library.CornerRadius or 18,
    Min = 0,
    Max = 20,
    Rounding = 0,
    Callback = function(value)
        Window:SetCornerRadius(value)
    end,
})

-- WATERMARK TOGGLE
SettingBox:AddToggle("WatermarkToggle", {
    Text = "Watermark",
    Default = true,
    Callback = function(Value)
        Watermark.Visible = Value
    end,
})

-- DIVIDER
SettingBox:AddDivider()

-- COPY DISCORD
SettingBox:AddButton("Copy Discord Link", function()
    setclipboard("https://discord.gg/3kmTx8Aeew")
    Library:Notify({
        Title = "Discord link copied!",
        Duration = 3,
    })
end)

-- UNLOAD
SettingBox:AddButton("Unload Script", function()
    Library:Unload()
end)

-- =========================================================
-- TOMBOL KEYBIND INFO
-- =========================================================
local InfoBox = Tabs.UISettings:AddRightGroupbox("Info", "info")

InfoBox:AddLabel("Script: One W")
InfoBox:AddLabel("Version: 1.0.0")
InfoBox:AddLabel("Theme: Maroon")
InfoBox:AddLabel("Toggle: LeftCtrl")
InfoBox:AddLabel("Button: C")

InfoBox:AddDivider()

InfoBox:AddLabel("Tab Count: 9")
InfoBox:AddLabel("Feature Count: 60+")
InfoBox:AddLabel("Background Loops: 4")

InfoBox:AddDivider()

InfoBox:AddLabel("Total fitur:")
InfoBox:AddLabel("• ESP (11)")
InfoBox:AddLabel("• Combat (13)")
InfoBox:AddLabel("• Killer (7)")
InfoBox:AddLabel("• Survival (12)")
InfoBox:AddLabel("• Character (5)")
InfoBox:AddLabel("• Visual (17)")
InfoBox:AddLabel("• Misc (15)")
InfoBox:AddLabel("• Extras (6)")
InfoBox:AddLabel("• UI Settings (7)")

print("✅ [10/12] One W - UI Settings Tab Loaded")-- =========================================================
-- SECTION 11/12 : BACKGROUND LOOPS
-- Camera Fix + Anti-Ilang + Auto-ON
-- =========================================================

-- =========================================================
-- CAMERA FIX (Anti-Lock setelah Parry/Gen/Stun)
-- =========================================================
local AP_LastCamFix = 0

task.spawn(function()
    while task.wait(0.05) do
        local cam = workspace.CurrentCamera
        local char = LocalPlayer.Character
        if not cam or not char then continue end

        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then continue end

        -- Skip kalau Aimbot Senter lagi HOLD
        if AimbotSenter and AimbotSenter.Enabled and AimbotSenter.Holding then
            continue
        end

        -- Skip kalau Aimlock lagi HOLD
        if Aimlock and Aimlock.Enabled and Aimlock.Holding then
            continue
        end

        -- Skip kalau GUI ada yang di-select
        if GuiService.SelectedObject then continue end

        local needFix = false

        if cam.CameraType ~= Enum.CameraType.Custom then
            needFix = true
        end
        if cam.CameraSubject ~= hum then
            needFix = true
        end

        local state = hum:GetState()
        if state == Enum.HumanoidStateType.FallingDown
            or state == Enum.HumanoidStateType.Ragdoll
            or state == Enum.HumanoidStateType.PlatformStanding then
            needFix = true
        end

        if needFix then
            local now = tick()
            if now - AP_LastCamFix > 0.05 then
                AP_LastCamFix = now
                pcall(function()
                    cam.CameraType = Enum.CameraType.Custom
                    cam.CameraSubject = hum
                    cam.CameraMode = Enum.CameraMode.Classic
                    cam.Focus = CFrame.new(cam.CFrame.Position)
                end)
            end
        end
    end
end)

-- =========================================================
-- CAMERA FIX SETELAH PARRY ANIM
-- =========================================================
local function hookKillerParryAnim(char)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local animator = hum:FindFirstChildOfClass("Animator")
    if not animator then return end

    animator.AnimationPlayed:Connect(function(track)
        local a = track.Animation
        if not a or not a.AnimationId then return end
        local id = a.AnimationId:match("%d+")
        if id == "127096285501517"
            or id == "123047897844134"
            or id == "112166042383605" then
            task.delay(0.1, function()
                local cam = workspace.CurrentCamera
                local myChar = LocalPlayer.Character
                if cam and myChar then
                    local myHum = myChar:FindFirstChildOfClass("Humanoid")
                    if myHum and not (AimbotSenter and AimbotSenter.Enabled and AimbotSenter.Holding) then
                        pcall(function()
                            cam.CameraType = Enum.CameraType.Custom
                            cam.CameraSubject = myHum
                        end)
                    end
                end
            end)
        end
    end)
end

-- Hook killer yang ada sekarang
for _, p in pairs(Players:GetPlayers()) do
    if p ~= LocalPlayer and p.Character and p.Team and p.Team.Name == "Killer" then
        task.spawn(function() hookKillerParryAnim(p.Character) end)
    end
    p.CharacterAdded:Connect(function(c)
        task.wait(1)
        if p.Team and p.Team.Name == "Killer" then
            hookKillerParryAnim(c)
        end
    end)
end

-- Hook killer baru
Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function(c)
        task.wait(1)
        if p.Team and p.Team.Name == "Killer" then
            hookKillerParryAnim(c)
        end
    end)
end)

-- =========================================================
-- CAMERA FIX PAS RESPAWN
-- =========================================================
LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(1)
    local cam = workspace.CurrentCamera
    local hum = char:WaitForChild("Humanoid", 5)
    if cam and hum then
        pcall(function()
            cam.CameraType = Enum.CameraType.Custom
            cam.CameraSubject = hum
            cam.CameraMode = Enum.CameraMode.Classic
        end)
    end
end)

-- =========================================================
-- ANTI-ILANG MENU
-- =========================================================
local function forceAllGuiResetOnSpawnFalse()
    for _, g in ipairs(PlayerGui:GetChildren()) do
        if g:IsA("ScreenGui") then
            pcall(function()
                g.ResetOnSpawn = false
                g.Enabled = true
            end)
        end
    end
end

task.spawn(function()
    while task.wait(0.3) do
        pcall(forceAllGuiResetOnSpawnFalse)
    end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(0.5)
    pcall(forceAllGuiResetOnSpawnFalse)
end)

-- =========================================================
-- AUTO-ON FITUR PAS EXECUTE
-- =========================================================
task.spawn(function()
    task.wait(3)

    -- ESP
    Config.ESP.Enabled = true
    Config.ESP.Killer = true
    Config.ESP.Generator = true
    Config.ESP.Survivor = true

    -- Update GUI Toggle
    pcall(function()
        local flags = Library.Toggles or Library.Flags
        if flags then
            if flags.ESP_Enabled then flags.ESP_Enabled:SetValue(true) end
            if flags.ESP_Killer then flags.ESP_Killer:SetValue(true) end
            if flags.ESP_Generator then flags.ESP_Generator:SetValue(true) end
            if flags.ESP_Survivor then flags.ESP_Survivor:SetValue(true) end
        end
    end)

    -- Karakter
    task.wait(0.3)
    pcall(function() applyKorblox(true) end)
    task.wait(0.3)
    pcall(function() applyHeadless(true) end)

    print("[One W] ✅ Auto-ON fitur loaded")
    print("[One W] - ESP: ON")
    print("[One W] - Korblox: ON")
    print("[One W] - Headless: ON")
end)

-- =========================================================
-- FPS + PING AUTO-LOOP (biar tetep jalan)
-- =========================================================
task.spawn(function()
    while task.wait(0.5) do
        if not fpsPingGui or not fpsPingGui.Parent then
            pcall(createFPSPingGui)
        end
    end
end)

-- =========================================================
-- BACKGROUND: Auto-Wiggle, dll
-- =========================================================

-- Auto-Scan Tombol Senter (buat Aimbot Senter)
task.spawn(function()
    while task.wait(2) do
        if AimbotSenter and AimbotSenter.Enabled then
            pcall(HookSenterButton)
        end
    end
end)

-- Auto-Scan Attack Button (buat Aimlock)
task.spawn(function()
    while task.wait(2) do
        if Aimlock and Aimlock.Enabled then
            pcall(hookAttackButtons)
        end
    end
end)

-- Auto-Hook Killer buat Auto Parry
task.spawn(function()
    while task.wait(0.8) do
        if AutoParry and AutoParry.Enabled then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer and p.Character and p.Team and p.Team.Name == "Killer" then
                    pcall(function() hookKiller(p.Character) end)
                end
            end
        end
    end
end)

print("✅ [11/12] One W - Background Loops Loaded")
print("📷 Camera Fix: AKTIF")
print("🖥️  Anti-Ilang: AKTIF")
print("⚡ Auto-ON: ESP + Korblox + Headless")-- =========================================================
-- SECTION 12/12 : PRINT FINAL + LOADER INFO
-- =========================================================

task.wait(0.5)

print("")
print("╔══════════════════════════════════════════════╗")
print("║  ██████╗ ███╗   ██╗███████╗    ██╗    ██╗    ║")
print("║  ██╔═══██╗████╗  ██║██╔════╝    ██║    ██║    ║")
print("║  ██║   ██║██╔██╗ ██║█████╗      ██║ █╗ ██║    ║")
print("║  ██║   ██║██║╚██╗██║██╔══╝      ██║███╗██║    ║")
print("║  ╚██████╔╝██║ ╚████║███████╗    ╚███╔███╔╝    ║")
print("║   ╚═════╝ ╚═╝  ╚═══╝╚══════╝     ╚══╝╚══╝     ║")
print("║                                              ║")
print("║         MAROON EDITION - V1.0.0              ║")
print("╚══════════════════════════════════════════════╝")
print("")
print("═══════════════════════════════════════════════")
print("  🎨 THEME: Maroon Red")
print("  🎯 TOMBOL: C (bulat merah)")
print("  ⌨️  TOGGLE: LeftCtrl")
print("  📁 CONFIG: OneW/configs")
print("═══════════════════════════════════════════════")
print("")
print("  ✅ SEMUA FITUR LOADED:")
print("")
print("  👁️  ESP (11 fitur)")
print("     - ESP Survivor / Killer / Generator")
print("     - ESP Pallet / Window / SCP")
print("     - ESP Distance / Transparency")
print("     - Name Player / Generator")
print("")
print("  ⚔️  Combat (13 fitur)")
print("     - Auto Parry (Radius + Debounce + Face)")
print("     - Aimbot Senter (HOLD = lock)")
print("     - Auto Skill Check (Perfect/Instant)")
print("     - Auto Wiggle")
print("     - Reset Parry Counter")
print("     - Show Parry Circle")
print("")
print("  🔪 Killer (7 fitur)")
print("     - Auto Attack + Delay")
print("     - Auto Kill All")
print("     - Auto Carry (Downed)")
print("     - Auto Hook")
print("     - Carry Range")
print("     - Masked Power (5 mode)")
print("")
print("  🏃 Survival (12 fitur)")
print("     - Auto Flee + Distance + Cooldown")
print("     - Auto Escape + Trigger Killer/Gen")
print("     - Moonwalk (Spam/Intensity/Slow)")
print("     - Fast Vault + Speed")
print("")
print("  🎭 Character (5 fitur)")
print("     - Korblox Pencil")
print("     - Headless Full")
print("     - 8-Bit Royal Crown")
print("     - Fire Effect (60 type)")
print("     - Fire Size")
print("")
print("  ✨ Visual (17 fitur)")
print("     - Fullbright + Brightness")
print("     - No Fog / Ultra HD / Contrast")
print("     - Sky Preset (18)")
print("     - HD Sky/Texture/Reflection/Bloom")
print("     - HD Shadow/Water/SunRays/DOF/Anti-Aliasing")
print("     - Crosshair + Size/Thickness/Color")
print("     - Zoom Out + FOV")
print("")
print("  ⚙️  Misc (15 fitur)")
print("     - Walk Speed / Speed Hack")
print("     - No Clip / No Clip Camera")
print("     - Anti-AFK / Instant Interact")
print("     - Show FPS / Ping")
print("     - Rejoin Server")
print("     - Hitbox (Size + Text + Mode)")
print("")
print("  🎁 Extras (6 fitur)")
print("     - Kill Feed / Stun Notify")
print("     - God Mode")
print("     - Aimlock (Hold Attack)")
print("")
print("  🎨 UI Settings (7 fitur)")
print("     - Custom Cursor / Notif Side")
print("     - DPI Scale / Corner Radius")
print("     - Watermark / Copy Discord")
print("     - Unload Script")
print("")
print("  🔧 BACKGROUND LOOPS:")
print("     - Camera Fix (Anti-Lock)")
print("     - Anti-Ilang Menu")
print("     - Auto-Scan Tombol")
print("     - Auto-ON Fitur")
print("")
print("═══════════════════════════════════════════════")
print("  🎯 Klik tombol C untuk buka menu")
print("  ⌨️  Tekan LeftCtrl untuk toggle")
print("═══════════════════════════════════════════════")
print("")
print("✅ [12/12] ONE W - MAROON GUI FULLY LOADED!")
print("")

-- =========================================================
-- LOADER INFO
-- =========================================================
-- Cara pakai:
-- 1. Upload file main.lua ke GitHub
-- 2. Execute loader di bawah:
--
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/USERNAME/REPO/main/main.lua"))()
--
-- Ganti USERNAME dan REPO dengan punya lu
-- =========================================================
