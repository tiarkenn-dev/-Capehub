-- =========================================================
-- SECTION 1/15 : LOADING GALAXY + CONFIG + STATE (LENGKAP)
-- =========================================================

Players = game:GetService("Players")
UIS = game:GetService("UserInputService")
RunService = game:GetService("RunService")
TweenService = game:GetService("TweenService")
Lighting = game:GetService("Lighting")
ReplicatedStorage = game:GetService("ReplicatedStorage")
VirtualInputManager = game:GetService("VirtualInputManager")
Stats = game:GetService("Stats")
GuiService = game:GetService("GuiService")
SoundService = game:GetService("SoundService")
StarterGui = game:GetService("StarterGui")

LP = Players.LocalPlayer
PG = LP:WaitForChild("PlayerGui")

function getRoot()
    local c = LP.Character
    return c and c:FindFirstChild("HumanoidRootPart")
end

C = {
    BG = Color3.fromRGB(10, 5, 25),
    BG2 = Color3.fromRGB(20, 10, 45),
    PANEL = Color3.fromRGB(22, 12, 48),
    PANEL2 = Color3.fromRGB(35, 18, 75),
    ACC = Color3.fromRGB(140, 70, 255),
    ACC2 = Color3.fromRGB(0, 200, 255),
    ACC3 = Color3.fromRGB(255, 100, 200),
    ACC4 = Color3.fromRGB(255, 200, 80),
    GOLD = Color3.fromRGB(255, 215, 0),
    FIRE_BRIGHT = Color3.fromRGB(220, 180, 255),
    TXT = Color3.fromRGB(240, 240, 255),
    DIM = Color3.fromRGB(130, 120, 180),
    GRN = Color3.fromRGB(0, 255, 150),
    RED = Color3.fromRGB(255, 70, 100),
}

function rnd(o, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 10)
    c.Parent = o
end

function strk(o, col, t, tr)
    local s = Instance.new("UIStroke")
    s.Color = col or C.GOLD
    s.Thickness = t or 1.5
    s.Transparency = tr or 0
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = o
    return s
end

local ToggleSoundId = "rbxassetid://6073491164"
local _toggleSoundInstance = nil
function playToggleSound()
    task.spawn(function()
        pcall(function()
            if not _toggleSoundInstance or not _toggleSoundInstance.Parent then
                _toggleSoundInstance = Instance.new("Sound")
                _toggleSoundInstance.SoundId = ToggleSoundId
                _toggleSoundInstance.Volume = 0.5
                _toggleSoundInstance.Parent = SoundService
            end
            _toggleSoundInstance:Play()
        end)
    end)
end
_G.Roooor_playSound = playToggleSound

-- =========================================================
-- LOADING GALAXY
-- =========================================================
local loadingGui = Instance.new("ScreenGui")
loadingGui.Name = "CosmicLoading"
loadingGui.ResetOnSpawn = false
loadingGui.IgnoreGuiInset = true
loadingGui.DisplayOrder = 999999
loadingGui.Parent = PG

local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(5, 2, 15)
bg.BorderSizePixel = 0
bg.Parent = loadingGui

local nebula = Instance.new("Frame")
nebula.Size = UDim2.new(1, 0, 1, 0)
nebula.BackgroundColor3 = Color3.fromRGB(20, 5, 50)
nebula.BorderSizePixel = 0
nebula.BackgroundTransparency = 0.3
nebula.Parent = bg

local nebulaGrad = Instance.new("UIGradient")
nebulaGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(80, 20, 180)),
    ColorSequenceKeypoint.new(0.25, Color3.fromRGB(20, 5, 60)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 100, 180)),
    ColorSequenceKeypoint.new(0.75, Color3.fromRGB(40, 5, 90)),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(120, 20, 200)),
})
nebulaGrad.Rotation = 45
nebulaGrad.Parent = nebula

task.spawn(function()
    local t = 0
    while nebula.Parent do
        t = t + 0.005
        nebulaGrad.Rotation = (t * 20) % 360
        task.wait(0.08)
    end
end)

local starContainer = Instance.new("Frame")
starContainer.Size = UDim2.new(1, 0, 1, 0)
starContainer.BackgroundTransparency = 1
starContainer.Parent = bg

local stars = {}
for i = 1, 20 do
    local star = Instance.new("Frame")
    star.Size = UDim2.new(0, math.random(2, 4), 0, math.random(2, 4))
    star.Position = UDim2.new(math.random(), 0, math.random(), 0)
    star.BackgroundColor3 = Color3.fromRGB(math.random(180, 255), math.random(180, 255), 255)
    star.BorderSizePixel = 0
    star.BackgroundTransparency = math.random(20, 60) / 100
    star.Parent = starContainer
    rnd(star, 999)
    table.insert(stars, {
        obj = star,
        speed = math.random(10, 40) / 10000,
        twinkle = math.random() * math.pi * 2
    })
end

task.spawn(function()
    while starContainer.Parent do
        for _, s in ipairs(stars) do
            if s.obj and s.obj.Parent then
                local p = s.obj.Position
                local newY = p.Y.Scale + s.speed
                if newY > 1 then
                    newY = 0
                    s.obj.Position = UDim2.new(math.random(), 0, 0, 0)
                else
                    s.obj.Position = UDim2.new(p.X.Scale, 0, newY, 0)
                end
                s.twinkle = s.twinkle + 0.1
                s.obj.BackgroundTransparency = 0.4 + math.sin(s.twinkle) * 0.3
            end
        end
        task.wait(0.12)
    end
end)

local galaxyHolder = Instance.new("Frame")
galaxyHolder.Size = UDim2.new(0, 400, 0, 400)
galaxyHolder.Position = UDim2.new(0.5, -200, 0.5, -200)
galaxyHolder.BackgroundTransparency = 1
galaxyHolder.Parent = bg

local spiral1 = Instance.new("Frame")
spiral1.Size = UDim2.new(0, 300, 0, 300)
spiral1.Position = UDim2.new(0.5, -150, 0.5, -150)
spiral1.BackgroundTransparency = 1
spiral1.Parent = galaxyHolder

local spiral1Stroke = Instance.new("UIStroke")
spiral1Stroke.Thickness = 60
spiral1Stroke.Transparency = 0.85
spiral1Stroke.Color = Color3.fromRGB(140, 70, 255)
spiral1Stroke.Parent = spiral1
rnd(spiral1, 999)

local spiral1Grad = Instance.new("UIGradient")
spiral1Grad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(0, 200, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(140, 70, 255)),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(255, 100, 200)),
})
spiral1Grad.Parent = spiral1Stroke

local spiral2 = Instance.new("Frame")
spiral2.Size = UDim2.new(0, 260, 0, 260)
spiral2.Position = UDim2.new(0.5, -130, 0.5, -130)
spiral2.BackgroundTransparency = 1
spiral2.Parent = galaxyHolder

local spiral2Stroke = Instance.new("UIStroke")
spiral2Stroke.Thickness = 40
spiral2Stroke.Transparency = 0.88
spiral2Stroke.Color = Color3.fromRGB(255, 100, 200)
spiral2Stroke.Parent = spiral2
rnd(spiral2, 999)

local spiral2Grad = Instance.new("UIGradient")
spiral2Grad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 100, 200)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 200, 255)),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(140, 70, 255)),
})
spiral2Grad.Rotation = 180
spiral2Grad.Parent = spiral2Stroke

task.spawn(function()
    local t = 0
    while galaxyHolder.Parent do
        t = t + 1
        spiral1.Rotation = t * 0.8
        spiral2.Rotation = -t * 1.1
        spiral1Grad.Rotation = (t * 2) % 360
        spiral2Grad.Rotation = 180 + (t * 1.5) % 360
        task.wait(0.08)
    end
end)

local titleGlow = Instance.new("Frame")
titleGlow.Size = UDim2.new(0, 500, 0, 100)
titleGlow.Position = UDim2.new(0.5, -250, 0.42, -50)
titleGlow.BackgroundColor3 = Color3.fromRGB(140, 70, 255)
titleGlow.BackgroundTransparency = 0.85
titleGlow.BorderSizePixel = 0
titleGlow.Parent = bg
rnd(titleGlow, 999)

local glowGrad = Instance.new("UIGradient")
glowGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(0, 200, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 100, 200)),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(140, 70, 255)),
})
glowGrad.Parent = titleGlow

local welcomeTitle = Instance.new("TextLabel")
welcomeTitle.Size = UDim2.new(1, 0, 0, 90)
welcomeTitle.Position = UDim2.new(0, 0, 0.42, -20)
welcomeTitle.BackgroundTransparency = 1
welcomeTitle.Text = "COSMIC"
welcomeTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
welcomeTitle.TextSize = 0
welcomeTitle.Font = Enum.Font.GothamBlack
welcomeTitle.TextStrokeTransparency = 0.4
welcomeTitle.TextStrokeColor3 = Color3.fromRGB(140, 70, 255)
welcomeTitle.Parent = bg

local titleGrad = Instance.new("UIGradient")
titleGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(0, 200, 255)),
    ColorSequenceKeypoint.new(0.25, Color3.fromRGB(140, 70, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 100, 200)),
    ColorSequenceKeypoint.new(0.75, Color3.fromRGB(140, 70, 255)),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(0, 200, 255)),
})
titleGrad.Parent = welcomeTitle

task.spawn(function()
    local t = 0
    while welcomeTitle.Parent do
        t = t + 1
        titleGrad.Rotation = (t * 2) % 360
        task.wait(0.08)
    end
end)

TweenService:Create(welcomeTitle, TweenInfo.new(1.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    TextSize = 68,
    TextTransparency = 0
}):Play()

task.spawn(function()
    task.wait(1.2)
    while titleGlow.Parent do
        TweenService:Create(titleGlow, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            BackgroundTransparency = 0.6,
            Size = UDim2.new(0, 560, 0, 120),
            Position = UDim2.new(0.5, -280, 0.42, -60)
        }):Play()
        task.wait(1.3)
        TweenService:Create(titleGlow, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            BackgroundTransparency = 0.85,
            Size = UDim2.new(0, 500, 0, 100),
            Position = UDim2.new(0.5, -250, 0.42, -50)
        }):Play()
        task.wait(1.3)
    end
end)

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, 0, 0, 24)
subtitle.Position = UDim2.new(0, 0, 0.42, 70)
subtitle.BackgroundTransparency = 1
subtitle.Text = "L O A D I N G"
subtitle.TextColor3 = Color3.fromRGB(180, 220, 255)
subtitle.TextSize = 14
subtitle.Font = Enum.Font.GothamBold
subtitle.TextStrokeTransparency = 0.5
subtitle.TextStrokeColor3 = Color3.fromRGB(0, 100, 180)
subtitle.TextTransparency = 1
subtitle.Parent = bg

TweenService:Create(subtitle, TweenInfo.new(1), {TextTransparency = 0}):Play()

task.spawn(function()
    task.wait(1)
    while subtitle.Parent do
        TweenService:Create(subtitle, TweenInfo.new(0.8), {TextTransparency = 0.4}):Play()
        task.wait(0.9)
        TweenService:Create(subtitle, TweenInfo.new(0.8), {TextTransparency = 0}):Play()
        task.wait(0.9)
    end
end)

local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(0, 320, 0, 4)
barBg.Position = UDim2.new(0.5, -160, 0.42, 110)
barBg.BackgroundColor3 = Color3.fromRGB(30, 15, 60)
barBg.BorderSizePixel = 0
barBg.BackgroundTransparency = 0.4
barBg.Parent = bg
rnd(barBg, 999)

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0, 0, 1, 0)
barFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
barFill.BorderSizePixel = 0
barFill.Parent = barBg
rnd(barFill, 999)

local barFillGrad = Instance.new("UIGradient")
barFillGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(0, 200, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(140, 70, 255)),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(255, 100, 200)),
})
barFillGrad.Parent = barFill

TweenService:Create(barFill, TweenInfo.new(1.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Size = UDim2.new(1, 0, 1, 0)
}):Play()

local barGlow = Instance.new("Frame")
barGlow.Size = UDim2.new(1, 12, 2, 12)
barGlow.Position = UDim2.new(0, -6, 0, -6)
barGlow.BackgroundColor3 = Color3.fromRGB(140, 70, 255)
barGlow.BackgroundTransparency = 0.7
barGlow.BorderSizePixel = 0
barGlow.ZIndex = -1
barGlow.Parent = barBg
rnd(barGlow, 999)

task.delay(1.6, function()
    if not loadingGui then return end
    if bg and bg.Parent then
        TweenService:Create(bg, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 1}):Play()
    end
    if welcomeTitle and welcomeTitle.Parent then
        TweenService:Create(welcomeTitle, TweenInfo.new(0.5), {TextTransparency = 1, TextStrokeTransparency = 1}):Play()
    end
    if subtitle and subtitle.Parent then
        TweenService:Create(subtitle, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    end
    if nebula and nebula.Parent then
        TweenService:Create(nebula, TweenInfo.new(0.6), {BackgroundTransparency = 1}):Play()
    end
    if titleGlow and titleGlow.Parent then
        TweenService:Create(titleGlow, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    end
    if barBg and barBg.Parent then
        TweenService:Create(barBg, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    end
    if barGlow and barGlow.Parent then
        TweenService:Create(barGlow, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    end
    task.wait(0.8)
    if loadingGui then loadingGui:Destroy() end
end)

-- =========================================================
-- STATE LENGKAP
-- =========================================================
_G.RoooorSavedStates = _G.RoooorSavedStates or {}

_G.RoooorS = _G.RoooorS or {
    FireOn = false, FireType = "CosmicFire", FireSize = 5,
    ParryCircle = false, ParryCircleSize = 12,
    WalkSpeed = false, WalkSpeedVal = 16, WalkSpeedBoost = 0,
    SpeedHack = false, SpeedHackVal = 40,
    NoClip = false, NoClipCamera = false,
    Korblox = true, KorbloxType = "Pencil",
    KorbloxYOffset = 0.80, KorbloxScale = 1,
    Headless = true,
    EightBitOn = false, EightBitType = "Royal Crown",
    EightBitSize = 1.24, EightBitHeight = 0.88,
    Trail = false, TrailColor = Color3.fromRGB(120, 60, 255),
    Aura = false, AuraColor = Color3.fromRGB(120, 60, 255),
    KillEffect = false,
    Crosshair = false,
    CrosshairColor = Color3.fromRGB(0, 200, 255),
    CrosshairSize = 8, CrosshairThickness = 2,
    CrosshairStyle = "Plus", CrosshairColorMode = "Solid",
    CrosshairOffsetX = 0, CrosshairOffsetY = 0,
    ZoomOut = false, ZoomOutValue = 500,
    FOV = 90, FOVEnabled = false,
    Fullbright = false, FullbrightVal = 50,
    NoFog = false, UltraHD = false,
    Contrast = false, ContrastVal = 0.3, SaturationVal = 0.2,
    SkyId = "Default",
    SkyAutoApplied = false,
    NoScreenEffects = false, LowGraphics = false, CleanSky = false,
    HDSky = false,
    AntiAFK = false, ShowFPS = false, ShowPing = false,
    Killer_AutoAtk = false, Killer_AtkDelay = 0.35,
    Killer_KillAll = false, MaskedPower = "Cobra",
    InstantInteract = false,
    AutoCarry = false, AutoHook = false, CarryRange = 60,
    HDTexture = false, HDReflection = false, HDBloom = false,
    HDShadow = false, HDWater = false, HDSunRays = false,
    HDDepthField = false, HDAntiAliasing = false,
    FireBeamOn = false, FireBeamType = "Classic Beam",
    FireBeamColor = Color3.fromRGB(120, 60, 255),
    ESPNameMode = "Galaxy", ESPNameSize = 8,
    ESPGenMode = "Bar",
    ESPGenBarSize = 64, ESPGenBarHeight = 8, ESPGenBarTextSize = 10,
    KillFeed = false, StunNotify = false,
    AutoEscapeGate = false, AutoEscapeRange = 50,
    AutoEscapeUseKillerCheck = true, AutoEscapeUseGenCheck = true,
}
S = _G.RoooorS

FPSPingConfig = _G.Roooor_FPSPing or { Size = 1, X = 0, Y = 0 }
_G.Roooor_FPSPing = FPSPingConfig

_G.ToggleStates = _G.ToggleStates or {
    ["ESP Survivor"] = true,
    ["ESP Killer"] = true,
    ["ESP Generator"] = true,
    ["Enable Korblox"] = true,
    ["Headless"] = true,
}
_G.SliderStates = _G.SliderStates or {
    ["Name Size"] = 8,
    ["Bar Width"] = 64,
    ["Bar Height"] = 8,
}
_G.DropdownStates = _G.DropdownStates or {
    ["Generator Mode"] = 2,
    ["Name Mode"] = 2,
}

ESP = _G.Roooor_ESP or {
    Survivor = true, Killer = true, Generator = true,
    Pallet = false, Window = false, SCP = false, Distance = 1000,
}
_G.Roooor_ESP = ESP

ESPStatus = _G.Roooor_ESPStatus or {
    Enabled = false, ShowName = true, ShowDistance = true,
    ShowHealth = true, Radius = 1000,
}
_G.Roooor_ESPStatus = ESPStatus

TeamColors = _G.Roooor_TeamColors or {
    Killer = Color3.fromRGB(255, 60, 60),
    Survivor = Color3.fromRGB(0, 120, 255),
}
_G.Roooor_TeamColors = TeamColors

Hitbox = _G.Roooor_Hitbox or {
    Enabled = false, Size = 70, TextSize = 10,
    ColorKiller = Color3.fromRGB(255, 255, 255),
    ColorSurvivor = Color3.fromRGB(255, 255, 255),
    Mode = "Auto", WallBang = true,
}
_G.Roooor_Hitbox = Hitbox

AutoParry = _G.Roooor_AutoParry or {
    Enabled = false, ParryDistance = 20, ParryDelay = 0,
    Cooldown = 0.5, FaceSensitivity = 0.2, RequireFacing = true,
    Wiggle = false, WiggleSpam = 5,
}
_G.Roooor_AutoParry = AutoParry

AP_CameraFix = { Enabled = true }
AP_ESPCircle = {
    Enabled = false,
    ColorNormal = Color3.fromRGB(0, 255, 100),
    ColorDanger = Color3.fromRGB(255, 50, 50),
    Thickness = 0.4, Segments = 36, YOffset = -2.5
}
AP_PARRY_DEBOUNCE = 0.02
PARRY_DEBOUNCE = 0.1

AimbotSenter = _G.Roooor_AimbotSenter or {
    Enabled = false, Radius = 99999, LockPart = "Head",
    ShowLaser = true, LaserColor = Color3.fromRGB(255, 0, 0),
    Smoothness = 0.5, CurrentTarget = nil, HoldingSenter = false,
    _Hooked = {},
}
_G.Roooor_AimbotSenter = AimbotSenter

SkillCheck = _G.Roooor_SkillCheck or {
    Enabled = false, Mode = "Perfect", HideNeedle = false,
    Success = 0, Total = 0,
}
_G.Roooor_SkillCheck = SkillCheck

Moonwalk = _G.Roooor_Moonwalk or {
    Enabled = false, Locked = false, SpamSpeed = 30,
    Intensity = 35, SlowSpeed = 13, UseSlow = true, ShowButton = true,
}
_G.Roooor_Moonwalk = Moonwalk

FastVault = _G.Roooor_FastVault or {
    Enabled = false, Speed = 1.2,
    ReplaceMap = {
        ["rbxassetid://83873880822918"] = "rbxassetid://136962284480779",
    },
}
_G.Roooor_FastVault = FastVault
VaultTracks = {}

AutoFlee = _G.Roooor_AutoFlee or {
    Enabled = false, DetectDistance = 50, Cooldown = 0.1, LastFlee = 0,
}
_G.Roooor_AutoFlee = AutoFlee

EightBitList = { "Royal Crown" }
EightBitIds = { ["Royal Crown"] = 10138606900 }
KorbloxList = { "Pencil" }
KorbloxIds = { ["Pencil"] = 902942096 }

FireBeamList = {
    "Classic Beam", "Laser Beam", "Rainbow Beam",
    "Fire Wings", "Fire Halo", "Fire Hands",
    "Fire Foot Trail", "Fire Body Aura", "Fire Mouth", "Fire Eyes Glow",
}

GodMode = _G.Roooor_GodMode or { Enabled = false }
_G.Roooor_GodMode = GodMode

Aimlock = _G.RoooorAimlock or {
    Enabled = false, Radius = 80, TargetTeam = "Survivors",
    AimPart = "HumanoidRootPart", Holding = false, CurrentTarget = nil,
}
_G.RoooorAimlock = Aimlock
Aimlock_AttackButtons = {}

HitboxESPObjects = {}
HitboxOriginalSizes = {}

print("✅ [1/15] COSMIC - Base + State Loaded")
print("🔦 Aimbot Senter: PENCET = LOCK | GAK PENCET = BEBAS")-- =========================================================
-- SECTION 2/15 : FIRE CONFIG + SKY + KILLER ANIMS
-- =========================================================

FireList = {
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

FireConfig = {
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

SkyList = {
    "Default", "Sunset", "Night", "Space",
    "Alien", "Purple", "Galaxy", "Void",
    "GalaxyPurple", "GalaxyBlue", "GalaxyPink", "GalaxyMulticolor",
    "Nebula", "CosmicStorm", "Aurora",
    "SunsetHD", "NightHD", "DeepSpace",
}

SkyIds = {
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

-- KILLER ANIMS (28 ID)
KillerAnims = {}
for _, id in ipairs({
    "105374834496520","113255068724446","118907603246885","129784271201071",
    "117042998468241","122812055447896","78935059863801","74968262036854",
    "78432063483146","132817836308238","133963973694098","111920872708571",
    "80411309607666","98163597193511","82666958311998","110355011987939",
    "139369275981139","135002183282873","121216847022485","130593238885843",
    "117070354890871","106871536134254","138720291317243",
    "127096285501517","112166042383605","123047897844134",
    "126965695851149","135084204086504"
}) do
    KillerAnims["rbxassetid://"..id] = true
end

SkipAnims = {
    ["112166042383605"] = "Break Pallet",
    ["123047897844134"] = "Stun",
    ["126965695851149"] = "WalkCrouch",
    ["135084204086504"] = "WalkCrouch Injured",
    ["127096285501517"] = "Parry Anim",
}

print("✅ [2/15] COSMIC - Fire + Sky + KillerAnims Loaded")-- =========================================================
-- SECTION 3/15 : FUNGSI UTAMA + HD SKY + FPS/PING
-- =========================================================

function saveState(key, value)
    _G.RoooorSavedStates = _G.RoooorSavedStates or {}
    _G.RoooorSavedStates[key] = value
end

function loadState(key, default)
    _G.RoooorSavedStates = _G.RoooorSavedStates or {}
    return _G.RoooorSavedStates[key] or default
end

task.spawn(function()
    while task.wait(2) do
        _G.RoooorSavedStates = _G.RoooorSavedStates or {}
        _G.RoooorSavedStates.S = S
        _G.RoooorSavedStates.ESP = ESP
        _G.RoooorSavedStates.AutoParry = AutoParry
        _G.RoooorSavedStates.SkillCheck = SkillCheck
        _G.RoooorSavedStates.Moonwalk = Moonwalk
        _G.RoooorSavedStates.Hitbox = Hitbox
        _G.RoooorSavedStates.GodMode = GodMode
        _G.RoooorSavedStates.AutoFlee = AutoFlee
        _G.RoooorSavedStates.FastVault = FastVault
    end
end)

-- FIRE
function clearFire()
    if not LP.Character then return end
    local head = LP.Character:FindFirstChild("Head")
    if not head then return end
    for _, obj in pairs(head:GetChildren()) do
        if obj.Name == "RoooorFire" or obj.Name == "RoooorSmoke" or obj.Name == "RoooorSparkles" then
            obj:Destroy()
        end
    end
end

function applyFire()
    clearFire()
    if not S.FireOn then return end
    local char = LP.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end
    local cfg = FireConfig[S.FireType] or FireConfig.Classic

    local fire = Instance.new("Fire")
    fire.Name = "RoooorFire"
    fire.Size = S.FireSize
    fire.Heat = 15
    fire.Color = cfg.c1
    fire.SecondaryColor = cfg.c2
    fire.Parent = head

    if cfg.smoke then
        local smoke = Instance.new("Smoke")
        smoke.Name = "RoooorSmoke"
        smoke.Size = S.FireSize + 2
        smoke.RiseVelocity = 3
        smoke.Opacity = 0.4
        smoke.Color = cfg.c2
        smoke.Parent = head
    end

    if cfg.spark then
        local spark = Instance.new("Sparkles")
        spark.Name = "RoooorSparkles"
        spark.SparkleColor = cfg.c2
        spark.SparkleSize = 1
        spark.Parent = head
    end
end

task.spawn(function()
    while task.wait(0.8) do
        if S.FireOn and LP.Character then
            local head = LP.Character:FindFirstChild("Head")
            local fire = head and head:FindFirstChild("RoooorFire")
            if fire then
                local cfg = FireConfig[S.FireType] or FireConfig.Classic
                if cfg.rainbow then
                    local t = tick()
                    fire.Color = Color3.fromHSV((t * 0.5) % 1, 1, 1)
                    fire.SecondaryColor = Color3.fromHSV(((t * 0.5) + 0.5) % 1, 1, 1)
                end
            end
        end
    end
end)

-- 8-BIT ROYAL CROWN
eightBitPart = nil

function clear8Bit()
    if eightBitPart then
        eightBitPart:Destroy()
        eightBitPart = nil
    end
end

function apply8Bit(enable, itemName, size, height)
    clear8Bit()
    if not enable then return end

    local char = LP.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end

    size = size or S.EightBitSize or 1.24
    height = height or S.EightBitHeight or 0.88

    eightBitPart = Instance.new("Part")
    eightBitPart.Name = "Client8Bit"
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

-- KORBLOX PENCIL
korbloxParts = {}
korbloxOrigData = {}

function clearKorblox()
    for _, part in pairs(korbloxParts) do
        if part and part.Parent then
            part:Destroy()
        end
    end
    korbloxParts = {}

    local char = LP.Character
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

function applyKorblox(enable, mode, yOffset, scale)
    clearKorblox()
    if not enable then return end

    yOffset = 0.80
    scale = scale or S.KorbloxScale or 1

    local char = LP.Character
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
    korbloxPart.Name = "ClientKorblox"
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
    mesh.Offset = Vector3.new(0, yOffset, 0)
    mesh.Parent = korbloxPart

    local weld = Instance.new("Weld")
    weld.Part0 = rightLeg
    weld.Part1 = korbloxPart
    weld.C0 = CFrame.new(0, 0, 0)
    weld.Parent = korbloxPart

    table.insert(korbloxParts, korbloxPart)
end

-- HEADLESS (FULL)
function applyHeadless(s)
    local char = LP.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    if not head then return end

    if s then
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

-- HD VISUAL EXTRAS
hdExtras = {}

function applyHDSky(s)
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
        cleanSky.Name = "HDSky_Clean"
        cleanSky.SkyboxBk = "rbxassetid://159454299"
        cleanSky.SkyboxDn = "rbxassetid://159454296"
        cleanSky.SkyboxFt = "rbxassetid://159454293"
        cleanSky.SkyboxLf = "rbxassetid://159454286"
        cleanSky.SkyboxRt = "rbxassetid://159454300"
        cleanSky.SkyboxUp = "rbxassetid://159454288"
        cleanSky.Parent = Lighting

        local lightAtmo = Instance.new("Atmosphere")
        lightAtmo.Name = "HDSky_Light"
        lightAtmo.Density = 0.1
        lightAtmo.Offset = 0.1
        lightAtmo.Color = Color3.fromRGB(220, 230, 255)
        lightAtmo.Decay = Color3.fromRGB(180, 200, 240)
        lightAtmo.Glare = 0
        lightAtmo.Haze = 0
        lightAtmo.Parent = Lighting

        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.Ambient = Color3.fromRGB(150, 160, 180)
        Lighting.OutdoorAmbient = Color3.fromRGB(180, 190, 210)
    else
        local oldSky = Lighting:FindFirstChild("HDSky_Clean")
        if oldSky then oldSky:Destroy() end
        local oldAtmo = Lighting:FindFirstChild("HDSky_Light")
        if oldAtmo then oldAtmo:Destroy() end

        pcall(function()
            Lighting.FogEnd = origLighting.FogEnd or 100000
            Lighting.FogStart = origLighting.FogStart or 0
            Lighting.Brightness = origLighting.Brightness
            Lighting.ClockTime = origLighting.ClockTime
            Lighting.Ambient = origLighting.Ambient
            Lighting.OutdoorAmbient = origLighting.OutdoorAmbient
        end)

        if origSky then
            local existing = Lighting:FindFirstChild("OrigSky_Clone")
            if not existing then
                local c = origSky:Clone()
                c.Name = "OrigSky_Clone"
                c.Parent = Lighting
            end
        end
    end
end

function applyHDTexture(s)
    if s then
        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level10
        end)
    end
end

function applyHDReflection(s)
    if s then
        if not hdExtras.Reflection then
            hdExtras.Reflection = Instance.new("ColorCorrectionEffect")
            hdExtras.Reflection.Name = "CosmicReflection"
            hdExtras.Reflection.Brightness = 0.05
            hdExtras.Reflection.Contrast = 0.1
            hdExtras.Reflection.Parent = Lighting
        end
    else
        if hdExtras.Reflection then hdExtras.Reflection:Destroy(); hdExtras.Reflection = nil end
    end
end

function applyHDBloom(s)
    if s then
        if not hdExtras.Bloom then
            hdExtras.Bloom = Instance.new("BloomEffect")
            hdExtras.Bloom.Name = "CosmicHDBloom2"
            hdExtras.Bloom.Intensity = 0.7
            hdExtras.Bloom.Size = 24
            hdExtras.Bloom.Threshold = 0.9
            hdExtras.Bloom.Parent = Lighting
        end
    else
        if hdExtras.Bloom then hdExtras.Bloom:Destroy(); hdExtras.Bloom = nil end
    end
end

function applyHDShadow(s)
    if s then
        Lighting.GlobalShadows = true
    end
end

function applyHDWater(s)
    if s then
        if not hdExtras.Water then
            hdExtras.Water = Instance.new("ColorCorrectionEffect")
            hdExtras.Water.Name = "CosmicWater"
            hdExtras.Water.TintColor = Color3.fromRGB(180, 220, 255)
            hdExtras.Water.Parent = Lighting
        end
    else
        if hdExtras.Water then hdExtras.Water:Destroy(); hdExtras.Water = nil end
    end
end

function applyHDSunRays(s)
    if s then
        if not hdExtras.SunRays then
            hdExtras.SunRays = Instance.new("SunRaysEffect")
            hdExtras.SunRays.Name = "CosmicSunRays"
            hdExtras.SunRays.Intensity = 0.15
            hdExtras.SunRays.Spread = 1
            hdExtras.SunRays.Parent = Lighting
        end
    else
        if hdExtras.SunRays then hdExtras.SunRays:Destroy(); hdExtras.SunRays = nil end
    end
end

function applyHDDepthField(s)
    if s then
        if not hdExtras.DepthField then
            hdExtras.DepthField = Instance.new("DepthOfFieldEffect")
            hdExtras.DepthField.Name = "CosmicDOF"
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

function applyHDAntiAliasing(s)
    if s then
        pcall(function()
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level10
        end)
    end
end

function applySky(skyName)
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("Sky") then v:Destroy() end
    end

    if not skyName or skyName == "Default" then
        if origSky then
            local c = origSky:Clone()
            c.Name = "OrigSky_Clone"
            c.Parent = Lighting
        end
        return
    end

    local ids = SkyIds[skyName]
    if not ids then
        ids = SkyIds.SunsetHD
    end

    local sky = Instance.new("Sky")
    sky.Name = "CosmicSky_" .. skyName
    sky.SkyboxBk = ids.Bk
    sky.SkyboxDn = ids.Dn or ids.Bk
    sky.SkyboxFt = ids.Ft or ids.Bk
    sky.SkyboxLf = ids.Lf or ids.Bk
    sky.SkyboxRt = ids.Rt or ids.Bk
    sky.SkyboxUp = ids.Up or ids.Bk
    sky.Parent = Lighting
end

function applyAntiAFK(enable)
    S.AntiAFK = enable
end

function rejoinServer()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
end

-- FPS + PING GUI
fpsPingGui = nil
fpsCounter = 0
fpsLastTime = tick()
currentFPS = 0
currentPing = 0

function createFPSPingGui()
    if fpsPingGui then fpsPingGui:Destroy() end
    
    fpsPingGui = Instance.new("ScreenGui")
    fpsPingGui.Name = "CosmicFPSPing"
    fpsPingGui.ResetOnSpawn = false
    fpsPingGui.IgnoreGuiInset = true
    fpsPingGui.DisplayOrder = 999
    fpsPingGui.Parent = PG

    local frame = Instance.new("Frame")
    frame.Name = "MainFrame"
    frame.Size = UDim2.new(0, 100, 0, 20)
    frame.Position = UDim2.new(1, -110, 0, 5)
    frame.BackgroundColor3 = Color3.fromRGB(15, 10, 30)
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.Parent = fpsPingGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = frame
    
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1
    stroke.Color = Color3.fromRGB(140, 70, 255)
    stroke.Transparency = 0.4
    stroke.Parent = frame

    local label = Instance.new("TextLabel")
    label.Name = "StatsLabel"
    label.Size = UDim2.new(1, -6, 1, 0)
    label.Position = UDim2.new(0, 3, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = "FPS: 0 | Ping: 0"
    label.TextColor3 = Color3.fromRGB(0, 255, 150)
    label.TextSize = 10
    label.Font = Enum.Font.GothamBold
    label.TextXAlignment = Enum.TextXAlignment.Center
    label.TextStrokeTransparency = 0.5
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.Parent = frame
end

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
                    local fpsText = S.ShowFPS and tostring(currentFPS) or "OFF"
                    local pingText = S.ShowPing and (tostring(currentPing) .. "ms") or "OFF"
                    label.Text = "FPS: " .. fpsText .. " | Ping: " .. pingText
                    
                    if currentFPS >= 50 then
                        label.TextColor3 = Color3.fromRGB(0, 255, 150)
                    elseif currentFPS >= 30 then
                        label.TextColor3 = Color3.fromRGB(255, 200, 0)
                    else
                        label.TextColor3 = Color3.fromRGB(255, 70, 100)
                    end
                end
            end
        end
    end
end)

function updateFPSPing()
    if fpsPingGui then
        fpsPingGui:Destroy()
        fpsPingGui = nil
    end
    createFPSPingGui()
end
_G.Roooor_updateFPSPing = updateFPSPing

print("✅ [3/15] COSMIC - Fungsi Utama + HD Sky + FPS/Ping Loaded")-- =========================================================
-- SECTION 4/15 : ESP + AUTO PARRY + AIMBOT SENTER
-- =========================================================

ESPObjects = {}
StatusESP = {}
CachedSCP = {}
Cached = { Generators = {}, Windows = {}, Pallets = {} }
GeneratorColor = Color3.fromRGB(255, 170, 0)
PalletColor = Color3.fromRGB(74, 255, 181)
WindowColor = Color3.fromRGB(74, 255, 181)
SCPColor = Color3.fromRGB(255, 0, 0)

function cacheObject(obj)
    if obj.Name == "Generator" then
        Cached.Generators[obj] = true
    elseif obj.Name == "Window" then
        Cached.Windows[obj] = true
    elseif obj.Name == "Pallet" or obj.Name == "Palletwrong" then
        Cached.Pallets[obj] = true
    end
    local name = string.lower(obj.Name)
    if string.find(name, "scp") then
        CachedSCP[obj] = true
    end
end

function removeCache(obj)
    Cached.Generators[obj] = nil
    Cached.Windows[obj] = nil
    Cached.Pallets[obj] = nil
    CachedSCP[obj] = nil
    if ESPObjects[obj] then
        ESPObjects[obj]:Destroy()
        ESPObjects[obj] = nil
    end
end

for _, obj in ipairs(workspace:GetDescendants()) do cacheObject(obj) end
workspace.DescendantAdded:Connect(cacheObject)
workspace.DescendantRemoving:Connect(removeCache)

function createESP(obj, color)
    if not obj then return end
    if ESPObjects[obj] then
        if ESPObjects[obj].FillColor ~= color then
            ESPObjects[obj].FillColor = color
            ESPObjects[obj].OutlineColor = color
        end
        return
    end
    local h = Instance.new("Highlight")
    h.FillColor = color
    h.OutlineColor = color
    h.FillTransparency = 0.9
    h.OutlineTransparency = 0.3
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Parent = obj
    ESPObjects[obj] = h
    obj.AncestryChanged:Connect(function(_, parent)
        if not parent then
            if ESPObjects[obj] then
                ESPObjects[obj]:Destroy()
                ESPObjects[obj] = nil
            end
        end
    end)
end

function removeESP(obj)
    if ESPObjects[obj] then
        ESPObjects[obj]:Destroy()
        ESPObjects[obj] = nil
    end
end

function removeStatusESP(char)
    if StatusESP[char] then
        StatusESP[char]:Destroy()
        StatusESP[char] = nil
    end
end

function createStatusESP(player, char, root)
    if not ESPStatus.Enabled then
        removeStatusESP(char)
        return
    end
    if not root then return end

    local head = char:FindFirstChild("Head")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not head or not hum then return end

    local isDown = hum.Health <= 0 or hum.Health < 2
        or char:GetAttribute("Downed") == true
        or char:GetAttribute("IsDown") == true
        or char:GetAttribute("Knocked") == true

    local dist = (head.Position - root.Position).Magnitude
    if dist > ESPStatus.Radius then
        removeStatusESP(char)
        return
    end

    local text = ""
    if isDown then text = text .. "DOWN\n" end
    if ESPStatus.ShowName then text = text .. player.Name .. "\n" end
    if ESPStatus.ShowDistance then text = text .. string.format("Dist: %.0f\n", dist) end
    if ESPStatus.ShowHealth then text = text .. string.format("HP: %.0f\n", hum.Health) end
    if text == "" then
        removeStatusESP(char)
        return
    end

    local billboard = StatusESP[char]
    local teamColor = Color3.new(1, 1, 1)
    if player.Team then
        if player.Team.Name == "Killer" then
            teamColor = TeamColors.Killer
        elseif player.Team.Name == "Survivors" then
            teamColor = TeamColors.Survivor
        end
    end
    if isDown then teamColor = Color3.fromRGB(255, 0, 0) end

    local mode = S.ESPNameMode or "Text"
    local size = S.ESPNameSize or 12

    if not billboard then
        billboard = Instance.new("BillboardGui")
        billboard.Size = UDim2.new(0, 120, 0, 50)
        billboard.AlwaysOnTop = true
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, 0, 1, 0)
        label.BackgroundTransparency = 1
        label.TextColor3 = teamColor
        label.TextStrokeTransparency = 0
        label.Font = Enum.Font.GothamBold
        label.TextSize = size
        label.Text = text
        label.Parent = billboard
        billboard.Adornee = head
        billboard.StudsOffset = Vector3.new(0, 2.5, 0)
        billboard.Parent = char
        StatusESP[char] = billboard
    else
        local label = billboard:FindFirstChildOfClass("TextLabel")
        if label then
            if label.Text ~= text then label.Text = text end
            if label.TextColor3 ~= teamColor then label.TextColor3 = teamColor end
            if label.TextSize ~= size then label.TextSize = size end
        end
    end

    if mode ~= "Galaxy" then
        local label = billboard:FindFirstChildOfClass("TextLabel")
        if label then
            local grad = label:FindFirstChildOfClass("UIGradient")
            if grad then grad:Destroy() end
        end
    end
end

task.spawn(function()
    while task.wait(0.15) do
        if S.ESPNameMode == "Galaxy" then
            for char, billboard in pairs(StatusESP) do
                if not billboard or not billboard.Parent then
                    StatusESP[char] = nil
                    continue
                end
                local label = billboard:FindFirstChildOfClass("TextLabel")
                if label then
                    local grad = label:FindFirstChildOfClass("UIGradient")
                    if not grad then
                        grad = Instance.new("UIGradient")
                        grad.Parent = label
                    end
                    local t = tick()
                    grad.Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromHSV((t * 0.5) % 1, 1, 1)),
                        ColorSequenceKeypoint.new(0.33, Color3.fromHSV((t * 0.5 + 0.33) % 1, 1, 1)),
                        ColorSequenceKeypoint.new(0.66, Color3.fromHSV((t * 0.5 + 0.66) % 1, 1, 1)),
                        ColorSequenceKeypoint.new(1, Color3.fromHSV((t * 0.5) % 1, 1, 1)),
                    })
                    grad.Rotation = (t * 120) % 360
                end
            end
        end
    end
end)

function GetGameValue(obj, name)
    if not obj then return nil end
    local attr = obj:GetAttribute(name)
    if attr ~= nil then return attr end
    local child = obj:FindFirstChild(name)
    if child and child:IsA("ValueBase") then
        local ok, val = pcall(function() return child.Value end)
        if ok then return val end
    end
    return nil
end

function GetGeneratorProgress(gen)
    if not gen then return 0 end
    local names = {
        "RepairProgress", "Progress", "Value", "RepairValue",
        "ProgressValue", "GenProgress", "Repaired", "Repair",
        "Percent", "Percentage", "RepairPercent"
    }
    for _, n in ipairs(names) do
        local v = GetGameValue(gen, n)
        if v ~= nil and type(v) == "number" then return v end
    end
    for _, d in ipairs(gen:GetDescendants()) do
        if d:IsA("ValueBase") then
            local ln = string.lower(d.Name)
            if ln:find("progress") or ln:find("repair")
               or ln:find("percent") or ln:find("value") then
                local ok, val = pcall(function() return d.Value end)
                if ok and type(val) == "number" then return val end
            end
        end
    end
    for _, attrName in ipairs(gen:GetAttributes()) do
        local v = gen:GetAttribute(attrName)
        if type(v) == "number" and v >= 0 and v <= 100 then
            local lower = string.lower(attrName)
            if lower:find("progress") or lower:find("repair")
               or lower:find("value") or lower:find("percent") then
                return v
            end
        end
    end
    return 0
end

function ApplyGenHighlight(object, color)
    if not object then return end
    local h = object:FindFirstChild("GenHighlight") or Instance.new("Highlight")
    h.Name = "GenHighlight"
    h.Adornee = object
    h.FillColor = color
    h.OutlineColor = color
    h.FillTransparency = 0.9
    h.OutlineTransparency = 0.3
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Parent = object
end

function UpdateGenerator(generator)
    if not generator or not generator.Parent then return end

    if not ESP.Generator then
        local a = generator:FindFirstChild("GenESP")
        if a then a:Destroy() end
        local b = generator:FindFirstChild("GenESPBar")
        if b then b:Destroy() end
        local h = generator:FindFirstChild("GenHighlight")
        if h then h:Destroy() end
        return
    end

    local percent = GetGeneratorProgress(generator)
    local cp = math.clamp(percent, 0, 100)

    if S.ESPGenMode == "Classic" then
        local oldBar = generator:FindFirstChild("GenESPBar")
        if oldBar then oldBar:Destroy() end

        if percent >= 100 then
            local old = generator:FindFirstChild("GenESP")
            if old then old:Destroy() end
            local h = generator:FindFirstChild("GenHighlight")
            if h then h:Destroy() end
            return
        end

        local color = GeneratorColor:Lerp(Color3.fromRGB(0, 255, 120), cp / 100)
        local text = string.format("[%.0f%%]", percent)

        local billboard = generator:FindFirstChild("GenESP")
        if not billboard then
            billboard = Instance.new("BillboardGui")
            billboard.Name = "GenESP"
            billboard.Size = UDim2.new(0, 100, 0, 30)
            billboard.AlwaysOnTop = true

            local label = Instance.new("TextLabel")
            label.Name = "GenLabel"
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = text
            label.TextColor3 = color
            label.TextStrokeTransparency = 0
            label.Font = Enum.Font.GothamBold
            label.TextSize = 12
            label.Parent = billboard

            billboard.Adornee = generator
            billboard.Parent = generator
        else
            local lbl2 = billboard:FindFirstChild("GenLabel")
            if lbl2 then
                lbl2.Text = text
                lbl2.TextColor3 = color
            end
        end
        ApplyGenHighlight(generator, color)

    elseif S.ESPGenMode == "Bar" then
        local oldClassic = generator:FindFirstChild("GenESP")
        if oldClassic then oldClassic:Destroy() end

        if percent >= 100 then
            local old = generator:FindFirstChild("GenESPBar")
            if old then old:Destroy() end
            local h = generator:FindFirstChild("GenHighlight")
            if h then h:Destroy() end
            return
        end

        local barSize = S.ESPGenBarSize or 64
        local barHeight = S.ESPGenBarHeight or 8
        local textSize = S.ESPGenBarTextSize or 10

        local billboard = generator:FindFirstChild("GenESPBar")
        if not billboard then
            billboard = Instance.new("BillboardGui")
            billboard.Name = "GenESPBar"
            billboard.Size = UDim2.new(0, barSize, 0, barHeight)
            billboard.AlwaysOnTop = true
            billboard.StudsOffset = Vector3.new(0, 1.5, 0)
            billboard.Adornee = generator
            billboard.Parent = generator

            local barBg = Instance.new("Frame")
            barBg.Name = "BarBg"
            barBg.Size = UDim2.new(1, 0, 1, 0)
            barBg.BackgroundColor3 = Color3.fromRGB(15, 10, 30)
            barBg.BorderSizePixel = 0
            barBg.Parent = billboard

            local bbc = Instance.new("UICorner")
            bbc.CornerRadius = UDim.new(1, 0)
            bbc.Parent = barBg

            local barFill = Instance.new("Frame")
            barFill.Name = "BarFill"
            barFill.Size = UDim2.new(0, 0, 1, 0)
            barFill.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
            barFill.BorderSizePixel = 0
            barFill.Parent = barBg

            local bfc = Instance.new("UICorner")
            bfc.CornerRadius = UDim.new(1, 0)
            bfc.Parent = barFill

            local pctText = Instance.new("TextLabel")
            pctText.Name = "PctText"
            pctText.Size = UDim2.new(1, 0, 1, 0)
            pctText.BackgroundTransparency = 1
            pctText.Text = "0%"
            pctText.TextColor3 = Color3.fromRGB(255, 255, 255)
            pctText.TextSize = textSize
            pctText.Font = Enum.Font.GothamBold
            pctText.TextXAlignment = Enum.TextXAlignment.Center
            pctText.TextYAlignment = Enum.TextYAlignment.Center
            pctText.TextStrokeTransparency = 0.2
            pctText.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            pctText.ZIndex = 10
            pctText.Parent = barBg
        end

        local barBg = billboard:FindFirstChild("BarBg")
        if barBg then
            local barFill = barBg:FindFirstChild("BarFill")
            local pctText = barBg:FindFirstChild("PctText")
            if barFill then barFill.Size = UDim2.new(cp / 100, 0, 1, 0) end
            if pctText then
                pctText.Text = string.format("%.0f%%", percent)
                pctText.TextSize = textSize
            end
        end

        local color = GeneratorColor:Lerp(Color3.fromRGB(0, 255, 120), cp / 100)
        ApplyGenHighlight(generator, color)
    end
end

function UpdateMapESP(obj, root)
    if not obj or not root then return end
    local pos
    if obj:IsA("Model") then pos = obj:GetPivot().Position
    elseif obj:IsA("BasePart") then pos = obj.Position end
    if not pos then return end
    local distance = (pos - root.Position).Magnitude

    if obj.Name == "Window" then
        if ESP.Window and distance <= ESP.Distance then createESP(obj, WindowColor)
        else removeESP(obj) end
    end

    if obj.Name == "Pallet" or obj.Name == "Palletwrong" then
        if ESP.Pallet and distance <= ESP.Distance then createESP(obj, PalletColor)
        else removeESP(obj) end
    end
end

function UpdateSCPEsp(root)
    if not ESP.SCP then
        for obj in pairs(CachedSCP) do removeESP(obj) end
        return
    end
    for obj in pairs(CachedSCP) do
        if obj and obj.Parent then
            local pos
            if obj:IsA("Model") then pos = obj:GetPivot().Position
            elseif obj:IsA("BasePart") then pos = obj.Position end
            if pos then
                local dist = (pos - root.Position).Magnitude
                if dist <= ESP.Distance then createESP(obj, SCPColor)
                else removeESP(obj) end
            end
        end
    end
end

-- AUTO PARRY
AP_parryCount = 0
AP_hookedKillers = _G.AP_HookedKillers or {}
_G.AP_HookedKillers = AP_hookedKillers

AP_Config = {
    Debounce = 0.02,
    Radius = 20,
    FaceSensitivity = 0.2,
}

local function AP_GetKillerType(char, player)
    local charName = string.lower(char.Name)
    local displayName = string.lower(player and player.DisplayName or "")
    local isHidden = charName:find("hidden") or displayName:find("hidden") or charName:find("617") or displayName:find("617")
    local isAbyss = charName:find("abyss") or displayName:find("abyss") or charName:find("walker") or displayName:find("walker")
    local isMasked = charName:find("masked") or displayName:find("masked") or charName:find("jacket") or displayName:find("jacket")
    return isHidden, isAbyss, isMasked
end

local function AP_ShouldParry(char, player, killerRoot, myRoot, dist)
    local isHidden, isAbyss, isMasked = AP_GetKillerType(char, player)
    local velocity = killerRoot.AssemblyLinearVelocity
    local toMe = (myRoot.Position - killerRoot.Position).Unit
    local killerLook = killerRoot.CFrame.LookVector
    local faceDot = killerLook:Dot(toMe)
    
    if isHidden then
        if velocity.Magnitude > 20 or dist > 10 then return false, "HIDDEN MARK"
        else return true, "HIDDEN BASIC" end
    end
    if isAbyss then
        if velocity.Magnitude < 20 and dist < 12 and faceDot > 0.3 then return true, "ABYSS SLASH" end
        return false, nil
    end
    if isMasked then
        if velocity.Magnitude > 15 and dist < 15 then return true, "MASKED CHAINSAW" end
        return false, nil
    end
    if velocity.Magnitude < 25 and dist < 12 and faceDot > 0.2 then return true, "BASIC ATTACK" end
    return false, nil
end

local _AP_lastParry = 0
local function AP_TryParry(reason)
    local now = tick()
    local bypass = reason == "BASIC ATTACK" or reason == "ABYSS SLASH" or reason == "MASKED CHAINSAW" or reason == "HIDDEN BASIC" or reason == "PREDICTIVE"
    local debounce = bypass and 0.015 or AP_Config.Debounce
    if now - _AP_lastParry > debounce then
        _AP_lastParry = now
        AP_PressParryButton()
        AP_parryCount = AP_parryCount + 1
        return true
    end
    return false
end

function AP_GetParryButton()
    local current = PG
    for segment in string.gmatch("Survivor-mob.Controls.Gui-mob", "[^%.]+") do
        current = current and current:FindFirstChild(segment)
    end
    return current
end

function AP_FindParryButton()
    local btn = AP_GetParryButton()
    if btn and btn:IsA("GuiObject") and btn.Visible then return btn end
    for _, obj in pairs(PG:GetDescendants()) do
        if obj:IsA("GuiObject") and obj.Visible then
            local n = string.lower(obj.Name)
            if n:find("parry") or n:find("block") or n:find("guard") then
                return obj
            end
        end
    end
    return nil
end

function AP_PressRightClick()
    VirtualInputManager:SendMouseButtonEvent(0, 0, 1, true, game, 0)
    task.wait(0.001)
    VirtualInputManager:SendMouseButtonEvent(0, 0, 1, false, game, 0)
end

function AP_PressParryButton()
    for i = 1, 2 do
        AP_PressRightClick()
        task.wait(0.001)
    end
    
    if UIS.TouchEnabled then
        local btn = AP_FindParryButton()
        if btn and btn:IsA("GuiObject") then
            local pos = btn.AbsolutePosition
            local size = btn.AbsoluteSize
            local inset = GuiService:GetGuiInset()
            local x = pos.X + size.X / 2 + inset.X
            local y = pos.Y + size.Y / 2 + inset.Y
            for i = 1, 2 do
                VirtualInputManager:SendTouchEvent(8823 + i, 0, x, y)
                task.wait(0.001)
                VirtualInputManager:SendTouchEvent(8823 + i, 2, x, y)
                task.wait(0.001)
            end
        end
    end
end

function AP_HookKiller(char)
    if AP_hookedKillers[char] then return end
    AP_hookedKillers[char] = true
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local animator = hum:FindFirstChildOfClass("Animator")
    if not animator then return end
    animator.AnimationPlayed:Connect(function(track)
        if not AutoParry.Enabled then return end
        local a = track.Animation
        if not a or not a.AnimationId then return end
        local id = a.AnimationId:match("%d+")
        if not id then return end
        if SkipAnims and SkipAnims[id] then return end
        if not KillerAnims["rbxassetid://" .. id] then return end
        local myRoot = getRoot()
        local killerRoot = char:FindFirstChild("HumanoidRootPart")
        if not myRoot or not killerRoot then return end
        local dist = (killerRoot.Position - myRoot.Position).Magnitude
        if dist > AP_Config.Radius then return end
        local player = Players:GetPlayerFromCharacter(char)
        local shouldParry, reason = AP_ShouldParry(char, player, killerRoot, myRoot, dist)
        if shouldParry then AP_TryParry(reason) end
    end)
end

for _, p in pairs(Players:GetPlayers()) do
    if p ~= LP and p.Character and p.Team and p.Team.Name == "Killer" then
        task.spawn(function() AP_HookKiller(p.Character) end)
    end
    p.CharacterAdded:Connect(function(c)
        task.wait(1)
        if p.Team and p.Team.Name == "Killer" then AP_HookKiller(c) end
    end)
end

Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function(c)
        task.wait(1)
        if p.Team and p.Team.Name == "Killer" then AP_HookKiller(c) end
    end)
end)

-- AUTO PARRY LOOP (0.001s)
task.spawn(function()
    while task.wait(0.001) do
        if not AutoParry.Enabled then continue end
        local myRoot = getRoot()
        if not myRoot then continue end
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Team and p.Team.Name == "Killer" then
                local killerRoot = p.Character:FindFirstChild("HumanoidRootPart")
                local killerHum = p.Character:FindFirstChildOfClass("Humanoid")
                if killerRoot and killerHum and killerHum.Health > 0 then
                    local dist = (killerRoot.Position - myRoot.Position).Magnitude
                    if dist <= AP_Config.Radius then
                        local isAttacking = false
                        local skipReason = nil
                        local animator = killerHum:FindFirstChildOfClass("Animator")
                        if animator then
                            for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
                                local a = track.Animation
                                if a and a.AnimationId then
                                    local id = a.AnimationId:match("%d+")
                                    if SkipAnims and SkipAnims[id] then skipReason = SkipAnims[id] end
                                    if KillerAnims["rbxassetid://" .. id] and (not SkipAnims or not SkipAnims[id]) then isAttacking = true end
                                end
                            end
                        end
                        if skipReason then continue end
                        local velocity = killerRoot.AssemblyLinearVelocity
                        local prevVelocity = p.Character:GetAttribute("LastVelocity") or 0
                        p.Character:SetAttribute("LastVelocity", velocity.Magnitude)
                        local velocitySpike = math.abs(velocity.Magnitude - prevVelocity) > 6
                        if isAttacking or velocitySpike then
                            local shouldParry, reason = AP_ShouldParry(p.Character, p, killerRoot, myRoot, dist)
                            if velocitySpike and not reason then
                                reason = "PREDICTIVE"
                                shouldParry = true
                            end
                            if shouldParry then AP_TryParry(reason) end
                        end
                    end
                end
            end
        end
    end
end)

-- AIMBOT SENTER (PENCET = LOCK)
AimbotLaserGui = nil
AimbotLaserLines = {}

local function CreateLaserGui()
    if AimbotLaserGui then AimbotLaserGui:Destroy() end
    AimbotLaserGui = Instance.new("ScreenGui")
    AimbotLaserGui.Name = "AimbotLaserESP"
    AimbotLaserGui.ResetOnSpawn = false
    AimbotLaserGui.IgnoreGuiInset = true
    AimbotLaserGui.Parent = PG
end
CreateLaserGui()

function ScanSenterButtons()
    local buttons = {}
    for _, obj in pairs(PG:GetDescendants()) do
        if obj:IsA("GuiObject") and obj.Visible then
            local n = string.lower(obj.Name)
            if n:find("flashlight") or n:find("senter") or n:find("light") or n:find("torch") or n:find("flash")
               or n:find("dagger") or n:find("knife") or n:find("blade") then
                table.insert(buttons, obj)
            end
        end
    end
    return buttons
end

function HookSenterButtons()
    local buttons = ScanSenterButtons()
    print("[SENTER] Ketemu " .. #buttons .. " tombol")
    for _, obj in ipairs(buttons) do
        if AimbotSenter._Hooked[obj] then continue end
        AimbotSenter._Hooked[obj] = true
        print("[SENTER] Hook: " .. obj:GetFullName())
        obj.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                AimbotSenter.HoldingSenter = true
                print("[SENTER] HOLD = LOCK")
            end
        end)
        obj.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                AimbotSenter.HoldingSenter = false
                AimbotSenter.CurrentTarget = nil
                print("[SENTER] RELEASE = BEBAS")
            end
        end)
        obj.MouseLeave:Connect(function()
            AimbotSenter.HoldingSenter = false
            AimbotSenter.CurrentTarget = nil
        end)
    end
end

task.spawn(function()
    while task.wait() do
        if not AimbotSenter.Enabled then
            if AimbotLaserGui then
                for _, line in pairs(AimbotLaserLines) do if line then line:Remove() end end
                AimbotLaserLines = {}
            end
            continue
        end
        if not AimbotSenter.HoldingSenter then
            AimbotSenter.CurrentTarget = nil
            if AimbotLaserGui then
                for _, line in pairs(AimbotLaserLines) do if line then line:Remove() end end
                AimbotLaserLines = {}
            end
            continue
        end
        local myRoot = getRoot()
        if not myRoot then continue end
        local closest = nil
        local shortest = math.huge
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Team and p.Team.Name == "Killer" then
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                local targetPart = p.Character:FindFirstChild(AimbotSenter.LockPart or "Head")
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
            if AimbotLaserGui then
                for _, line in pairs(AimbotLaserLines) do if line then line:Remove() end end
                AimbotLaserLines = {}
            end
            continue
        end
        AimbotSenter.CurrentTarget = closest
        local cam = workspace.CurrentCamera
        if cam then
            local camPos = cam.CFrame.Position
            local targetPos = closest.Position
            local newCFrame = CFrame.new(camPos, targetPos)
            cam.CFrame = cam.CFrame:Lerp(newCFrame, AimbotSenter.Smoothness or 0.5)
        end
        if AimbotSenter.ShowLaser then
            local cam2 = workspace.CurrentCamera
            local screenPoint, onScreen = cam2:WorldToViewportPoint(closest.Position)
            if onScreen then
                if AimbotLaserGui then
                    for _, line in pairs(AimbotLaserLines) do if line then line:Remove() end end
                    AimbotLaserLines = {}
                end
                local centerX = cam2.ViewportSize.X / 2
                local centerY = cam2.ViewportSize.Y / 2
                local line = Drawing.new("Line")
                line.Visible = true
                line.From = Vector2.new(centerX, centerY)
                line.To = Vector2.new(screenPoint.X, screenPoint.Y)
                line.Color = AimbotSenter.LaserColor or Color3.fromRGB(255, 0, 0)
                line.Thickness = 2
                line.Transparency = 0.5
                table.insert(AimbotLaserLines, line)
            end
        end
    end
end)

task.spawn(function()
    while task.wait(2) do
        if AimbotSenter.Enabled then
            pcall(HookSenterButtons)
        end
    end
end)

-- AP CIRCLE
AP_parryCirclePart = nil
AP_parryCircleAttachments = {}
AP_parryCircleBeams = {}

function AP_ClearCircle()
    if AP_parryCirclePart then
        AP_parryCirclePart:Destroy()
        AP_parryCirclePart = nil
    end
    AP_parryCircleAttachments = {}
    AP_parryCircleBeams = {}
end

function AP_CreateCircle()
    AP_ClearCircle()
    AP_parryCirclePart = Instance.new("Part")
    AP_parryCirclePart.Name = "AP_ParryRingBeam"
    AP_parryCirclePart.Anchored = true
    AP_parryCirclePart.CanCollide = false
    AP_parryCirclePart.CanQuery = false
    AP_parryCirclePart.CanTouch = false
    AP_parryCirclePart.Transparency = 1
    AP_parryCirclePart.Size = Vector3.new(1, 0.1, 1)
    AP_parryCirclePart.Parent = workspace

    local segments = AP_ESPCircle.Segments
    for i = 1, segments do
        local angle = (i / segments) * math.pi * 2
        local att = Instance.new("Attachment")
        att.Position = Vector3.new(math.cos(angle), 0, math.sin(angle))
        att.Parent = AP_parryCirclePart
        table.insert(AP_parryCircleAttachments, att)
    end
    for i = 1, segments do
        local attA = AP_parryCircleAttachments[i]
        local attB = AP_parryCircleAttachments[(i % segments) + 1]
        local beam = Instance.new("Beam")
        beam.Attachment0 = attA
        beam.Attachment1 = attB
        beam.Width0 = AP_ESPCircle.Thickness
        beam.Width1 = AP_ESPCircle.Thickness
        beam.FaceCamera = true
        beam.LightEmission = 1
        beam.LightInfluence = 0
        beam.Segments = 1
        beam.Transparency = NumberSequence.new(0)
        beam.Color = ColorSequence.new(AP_ESPCircle.ColorNormal)
        beam.Parent = AP_parryCirclePart
        table.insert(AP_parryCircleBeams, beam)
    end
end

function AP_UpdateCircle()
    local root = getRoot()
    if not AP_ESPCircle.Enabled or not root then
        if AP_parryCirclePart then AP_ClearCircle() end
        return
    end
    if not AP_parryCirclePart or not AP_parryCirclePart.Parent then
        AP_CreateCircle()
    end

    local radius = AutoParry.ParryDistance
    local myPos = root.Position
    local yOffset = AP_ESPCircle.YOffset

    local killerInside = false
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Team and p.Team.Name == "Killer" then
            local eRoot = p.Character:FindFirstChild("HumanoidRootPart")
            if eRoot then
                local dist = (eRoot.Position - myPos).Magnitude
                if dist <= radius then
                    killerInside = true
                    break
                end
            end
        end
    end

    local ringColor = killerInside and AP_ESPCircle.ColorDanger or AP_ESPCircle.ColorNormal
    AP_parryCirclePart.Position = Vector3.new(myPos.X, myPos.Y + yOffset, myPos.Z)

    for i, att in ipairs(AP_parryCircleAttachments) do
        local angle = (i / AP_ESPCircle.Segments) * math.pi * 2
        att.Position = Vector3.new(math.cos(angle) * radius, 0, math.sin(angle) * radius)
    end
    for _, beam in ipairs(AP_parryCircleBeams) do
        beam.Width0 = AP_ESPCircle.Thickness
        beam.Width1 = AP_ESPCircle.Thickness
        beam.Color = ColorSequence.new(ringColor)
        beam.Transparency = NumberSequence.new(0)
    end
end

print("✅ [4/15] COSMIC - ESP + Auto Parry + Aimbot Senter")
print("🔦 Aimbot Senter: PENCET = LOCK | GAK PENCET = BEBAS")-- =========================================================
-- SECTION 5/15 : FITUR AKTIF + LOOP UTAMA
-- =========================================================

RunService.RenderStepped:Connect(function()
    if AutoParry.Enabled then
        pcall(AP_UpdateCircle)
    end

    if S.FOVEnabled then
        local cam = workspace.CurrentCamera
        if cam and math.abs(cam.FieldOfView - S.FOV) > 0.5 then
            pcall(function() cam.FieldOfView = S.FOV end)
        end
    end

    if Moonwalk.Enabled and not ParryActive and not mwIsDowned() then
        local char = LP.Character
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

-- MOONWALK FUNCTIONS
function mwIsDowned()
    local char = LP.Character
    if not char then return false end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return false end
    return hum.Health <= 0 or hum.Health < 2
end

function mwResetSpeed()
    local char = LP.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = 16 end
end

function setMoonwalk(state)
    if Moonwalk.Locked and state ~= Moonwalk.Enabled then
        return false
    end
    Moonwalk.Enabled = state
    if not state then mwResetSpeed() end
    return true
end

if PG:FindFirstChild("MW_BottomBtn") then
    PG.MW_BottomBtn:Destroy()
end

mwBtnGui = Instance.new("ScreenGui")
mwBtnGui.Name = "MW_BottomBtn"
mwBtnGui.ResetOnSpawn = false
mwBtnGui.IgnoreGuiInset = true
mwBtnGui.Parent = PG

mwBtn = Instance.new("TextButton")
mwBtn.Size = UDim2.fromOffset(60, 60)
mwBtn.Position = UDim2.new(0, 20, 1, -100)
mwBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mwBtn.Text = "MW"
mwBtn.TextColor3 = Color3.new(1, 1, 1)
mwBtn.TextSize = 16
mwBtn.Font = Enum.Font.GothamBlack
mwBtn.AutoButtonColor = false
mwBtn.Active = true
mwBtn.Draggable = true
mwBtn.Parent = mwBtnGui

local mwBtnCorner = Instance.new("UICorner")
mwBtnCorner.CornerRadius = UDim.new(1, 0)
mwBtnCorner.Parent = mwBtn

local mwBtnStroke = Instance.new("UIStroke")
mwBtnStroke.Thickness = 2
mwBtnStroke.Color = Color3.fromRGB(255, 255, 255)
mwBtnStroke.Transparency = 0.5
mwBtnStroke.Parent = mwBtn

mwLockBtn = Instance.new("TextButton")
mwLockBtn.Size = UDim2.fromOffset(60, 22)
mwLockBtn.Position = UDim2.new(0, 20, 1, -128)
mwLockBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 65)
mwLockBtn.Text = "UNLOCK"
mwLockBtn.TextColor3 = Color3.new(1, 1, 1)
mwLockBtn.TextSize = 10
mwLockBtn.Font = Enum.Font.GothamBold
mwLockBtn.AutoButtonColor = false
mwLockBtn.Parent = mwBtnGui

local mwLockCorner = Instance.new("UICorner")
mwLockCorner.CornerRadius = UDim.new(1, 0)
mwLockCorner.Parent = mwLockBtn

local mwLockStroke = Instance.new("UIStroke")
mwLockStroke.Thickness = 1.5
mwLockStroke.Color = Color3.fromRGB(255, 255, 255)
mwLockStroke.Transparency = 0.5
mwLockStroke.Parent = mwLockBtn

function mwBtnUpdateUI()
    if Moonwalk.Enabled then
        mwBtn.Text = "MW ON"
        mwBtnStroke.Color = Color3.fromRGB(170, 0, 255)
        mwBtn.BackgroundColor3 = Color3.fromRGB(80, 20, 120)
    else
        mwBtn.Text = "MW"
        mwBtnStroke.Color = Color3.fromRGB(255, 255, 255)
        mwBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    end
    if Moonwalk.Locked then
        mwLockBtn.Text = "LOCKED"
        mwLockBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    else
        mwLockBtn.Text = "UNLOCK"
        mwLockBtn.BackgroundColor3 = Color3.fromRGB(40, 45, 65)
    end
end

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
_G.Roooor_setMoonwalk = setMoonwalk
_G.Roooor_mwBtnUpdateUI = mwBtnUpdateUI

-- SKILL CHECK
function pressSpace()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
    task.wait()
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
end

TouchID = 8822
ActionPath = "Survivor-mob.Controls.action.check"
SkillHeartbeat = nil
busy = false

function GetActionTarget()
    local current = PG
    for segment in string.gmatch(ActionPath, "[^%.]+") do
        current = current and current:FindFirstChild(segment)
    end
    return current
end

function TriggerMobileButton()
    local b = GetActionTarget()
    if b and b:IsA("GuiObject") then
        local p, s, i = b.AbsolutePosition, b.AbsoluteSize, GuiService:GetGuiInset()
        local cx, cy = p.X + (s.X/2) + i.X, p.Y + (s.Y/2) + i.Y
        pcall(function()
            VirtualInputManager:SendTouchEvent(TouchID, 0, cx, cy)
            task.wait(0.01)
            VirtualInputManager:SendTouchEvent(TouchID, 2, cx, cy)
        end)
    end
end

function startSkillCheck()
    if SkillHeartbeat then SkillHeartbeat:Disconnect() end
    SkillHeartbeat = RunService.RenderStepped:Connect(function()
        if not SkillCheck.Enabled or busy then return end
        local prompt = PG:FindFirstChild("SkillCheckPromptGui")
        if not prompt then return end
        local check = prompt:FindFirstChild("Check")
        if not check or not check.Visible then return end
        local line = check:FindFirstChild("Line")
        local goal = check:FindFirstChild("Goal")
        if not line or not goal then return end
        local lr = line.Rotation % 360
        local gr = goal.Rotation % 360

        if SkillCheck.Mode == "Instant" then
            local targetRot = (gr + 109) % 360
            pcall(function() line.Rotation = targetRot end)
            busy = true
            task.spawn(function()
                if UIS.TouchEnabled then TriggerMobileButton() else pressSpace() end
                SkillCheck.Success += 1
                SkillCheck.Total += 1
                task.wait(0.05)
                busy = false
            end)
            return
        end

        if SkillCheck.Mode == "Perfect" then
            local startRange = (gr + 102) % 360
            local endRange   = (gr + 116) % 360
            local success = (startRange > endRange and (lr >= startRange or lr <= endRange)) or (lr >= startRange and lr <= endRange)
            if success then
                busy = true
                task.spawn(function()
                    if UIS.TouchEnabled then TriggerMobileButton() else pressSpace() end
                    SkillCheck.Success += 1
                    SkillCheck.Total += 1
                    task.wait(0.05)
                    busy = false
                end)
            end
            return
        end
    end)
end

task.spawn(function()
    task.wait(1)
    if SkillCheck.Enabled then startSkillCheck() end
end)

-- INSTANT INTERACT
task.spawn(function()
    while task.wait(0.3) do
        if S.InstantInteract and LP.Character then
            local myRoot = getRoot()
            if myRoot then
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
        end
    end
end)

-- SPEED HACK
task.spawn(function()
    while task.wait(0.2) do
        if S.SpeedHack and LP.Character then
            local hum = LP.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.WalkSpeed ~= S.SpeedHackVal then
                hum.WalkSpeed = S.SpeedHackVal
            end
        end
    end
end)

-- WALK SPEED
task.spawn(function()
    while task.wait(0.2) do
        if S.WalkSpeed and not S.SpeedHack and LP.Character then
            local hum = LP.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                local target = S.WalkSpeedVal + (S.WalkSpeedBoost or 0)
                if hum.WalkSpeed ~= target then
                    hum.WalkSpeed = target
                end
            end
        end
    end
end)

-- ANTI AFK
task.spawn(function()
    while task.wait(120) do
        if S.AntiAFK then
            pcall(function()
                local VirtualUser = game:GetService("VirtualUser")
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end
    end
end)

-- KILL FEED
killFeedGui = Instance.new("ScreenGui")
killFeedGui.Name = "CosmicKillFeed"
killFeedGui.ResetOnSpawn = false
killFeedGui.IgnoreGuiInset = true
killFeedGui.Parent = PG

local killFeedFrame = Instance.new("Frame")
killFeedFrame.Size = UDim2.new(0, 250, 0, 200)
killFeedFrame.Position = UDim2.new(1, -260, 0, 50)
killFeedFrame.BackgroundTransparency = 1
killFeedFrame.Parent = killFeedGui

local killFeedLayout = Instance.new("UIListLayout")
killFeedLayout.Padding = UDim.new(0, 4)
killFeedLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
killFeedLayout.Parent = killFeedFrame

function addKillFeed(killerName, survivorName)
    if not S.KillFeed then return end
    local entry = Instance.new("Frame")
    entry.Size = UDim2.new(1, 0, 0, 28)
    entry.BackgroundColor3 = Color3.fromRGB(30, 10, 45)
    entry.BackgroundTransparency = 0.2
    entry.BorderSizePixel = 0
    entry.Parent = killFeedFrame
    rnd(entry, 6)
    strk(entry, C.ACC, 1, 0.5)

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -10, 1, 0)
    lbl.Position = UDim2.new(0, 5, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = killerName .. " > " .. survivorName
    lbl.TextColor3 = Color3.fromRGB(220, 180, 255)
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
        if not S.KillFeed then continue end
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

-- STUN NOTIFY
stunIcons = {}

function createStunIcon(killerChar)
    if stunIcons[killerChar] then return stunIcons[killerChar] end
    local head = killerChar:FindFirstChild("Head")
    if not head then return end
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "CosmicStunIcon"
    billboard.Size = UDim2.new(0, 60, 0, 60)
    billboard.AlwaysOnTop = true
    billboard.StudsOffset = Vector3.new(0, 4, 0)
    billboard.Adornee = head
    billboard.Parent = head
    local icon = Instance.new("TextLabel")
    icon.Size = UDim2.new(1, 0, 1, 0)
    icon.BackgroundTransparency = 1
    icon.Text = "STUN"
    icon.TextColor3 = Color3.fromRGB(220, 180, 255)
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
    return billboard
end

function removeStunIcon(killerChar)
    if stunIcons[killerChar] then
        stunIcons[killerChar]:Destroy()
        stunIcons[killerChar] = nil
    end
end

task.spawn(function()
    while task.wait(0.3) do
        if not S.StunNotify then continue end
        local myRoot = getRoot()
        if not myRoot then continue end
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Team and p.Team.Name == "Killer" then
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

-- KILLER AUTO ATTACK
lastAtk = 0
task.spawn(function()
    while task.wait(0.2) do
        if S.Killer_AutoAtk then
            local now = tick()
            if now - lastAtk >= (S.Killer_AtkDelay or 0.35) then
                lastAtk = now
                pcall(function()
                    local r = ReplicatedStorage:FindFirstChild("Remotes")
                    if r then
                        local a = r:FindFirstChild("Attacks")
                        if a then
                            local atk = a:FindFirstChild("BasicAttack")
                            if atk then atk:FireServer(false) end
                        end
                    end
                end)
            end
        end
    end
end)

-- AUTO WIGGLE
task.spawn(function()
    while task.wait(1) do
        if not AutoParry.Wiggle then continue end
        local char = LP.Character
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
        for i = 1, (AutoParry.WiggleSpam or 5) do
            pcall(function() event:FireServer() end)
        end
    end
end)

-- AUTO FLEE
function GetNearestKillerForFlee()
    local root = getRoot()
    if not root then return nil, math.huge end
    local closest, shortest = nil, math.huge
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP and plr.Team and plr.Team.Name == "Killer" and plr.Character then
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

task.spawn(function()
    while task.wait(0.2) do
        if not AutoFlee.Enabled then continue end
        local root = getRoot()
        if not root then continue end
        local killerRoot, distance = GetNearestKillerForFlee()
        if killerRoot and distance <= AutoFlee.DetectDistance
           and tick() - AutoFlee.LastFlee > AutoFlee.Cooldown then
            local point = nil
            local farthest = 0
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and string.match(obj.Name, "^GeneratorPoint%d+$") then
                    local d = (obj.Position - killerRoot.Position).Magnitude
                    if d > farthest then
                        farthest = d
                        point = obj
                    end
                end
            end
            if point then
                AutoFlee.LastFlee = tick()
                pcall(function()
                    root.CFrame = point.CFrame + Vector3.new(0, 5, 0)
                end)
            end
        end
    end
end)

-- FPS BOOST
local ScreenEffectTypes = {
    "ColorCorrectionEffect", "DepthOfFieldEffect", "BlurEffect",
    "SunRaysEffect", "BloomEffect"
}
DisabledEffects = {}

function applyNoScreenEffects()
    if S.NoScreenEffects then
        for _, v in pairs(Lighting:GetChildren()) do
            for _, t in pairs(ScreenEffectTypes) do
                if v:IsA(t) then
                    DisabledEffects[v] = v.Enabled
                    v.Enabled = false
                end
            end
        end
    else
        for obj, state in pairs(DisabledEffects) do
            if obj and obj.Parent then obj.Enabled = state end
        end
        DisabledEffects = {}
    end
end

function applyLowGraphics()
    pcall(function()
        if S.LowGraphics then
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        else
            settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
        end
    end)
end

function applyCleanSky()
    if S.CleanSky then
        for _, v in ipairs(Lighting:GetChildren()) do
            if v:IsA("Sky") then v:Destroy() end
        end
    end
end

-- AUTO CARRY + HOOK
KillerBusy = false

function GetDownedSurvivor()
    local root = getRoot()
    if not root then return nil end
    local best, dist = nil, math.huge
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local hum = p.Character:FindFirstChildOfClass("Humanoid")
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hum and hrp and hum.Health > 0 and hum.Health <= hum.MaxHealth * 0.25 then
                local d = (hrp.Position - root.Position).Magnitude
                if d < dist and d <= S.CarryRange then
                    dist = d
                    best = p.Character
                end
            end
        end
    end
    return best
end

function GetHookPoint()
    local root = getRoot()
    if not root then return nil end
    local bestHook, shortestDistance = nil, math.huge
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == "HookPoint" and obj:IsA("BasePart") then
            local dist = (obj.Position - root.Position).Magnitude
            if dist < shortestDistance and dist < 400 then
                shortestDistance = dist
                bestHook = obj
            end
        end
    end
    return bestHook
end

task.spawn(function()
    while task.wait(0.2) do
        if not S.AutoCarry or KillerBusy then continue end
        local CarryEvent = ReplicatedStorage:FindFirstChild("Remotes", true)
            and ReplicatedStorage.Remotes:FindFirstChild("Carry", true)
            and ReplicatedStorage.Remotes.Carry:FindFirstChild("CarrySurvivorEvent")
        local HookEvent = ReplicatedStorage:FindFirstChild("Remotes", true)
            and ReplicatedStorage.Remotes:FindFirstChild("Carry", true)
            and ReplicatedStorage.Remotes.Carry:FindFirstChild("HookEvent")
        if not CarryEvent or not HookEvent then continue end
        local target = GetDownedSurvivor()
        local root = getRoot()
        if target and root then
            KillerBusy = true
            local tRoot = target:FindFirstChild("HumanoidRootPart")
            if tRoot then
                root.CFrame = tRoot.CFrame * CFrame.new(0, 3, -2)
                task.wait(0.4)
                for i = 1, 4 do
                    pcall(function() CarryEvent:FireServer(target) end)
                    task.wait(0.2)
                end
                task.wait(0.6)
                if S.AutoHook then
                    local hook = GetHookPoint()
                    if hook then
                        root.CFrame = hook.CFrame * CFrame.new(0, 4, -3)
                        task.wait(0.7)
                        for i = 1, 6 do
                            pcall(function() HookEvent:FireServer(hook) end)
                            task.wait(0.15)
                        end
                    end
                end
            end
            task.delay(2, function() KillerBusy = false end)
        end
    end
end)

-- AUTO ESCAPE GATE
task.spawn(function()
    while task.wait(3) do
        if not S.AutoEscapeGate then continue end
        local root = getRoot()
        if not root then continue end
        local killerNear = false
        if S.AutoEscapeUseKillerCheck then
            local kRoot, kDist = GetNearestKillerForFlee()
            if kRoot and kDist <= (S.AutoEscapeRange or 50) then
                killerNear = true
            end
        end
        local genDone = false
        if S.AutoEscapeUseGenCheck then
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

-- MAIN ESP LOOP
local lastESPUpdate = 0
RunService.Heartbeat:Connect(function()
    local root = getRoot()
    if not root then return end
    local now = tick()
    if now - lastESPUpdate >= 0.2 then
        lastESPUpdate = now
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character then
                local char = p.Character
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum and hum.Health > 0 then
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local distance = (hrp.Position - root.Position).Magnitude
                        if distance <= ESP.Distance then
                            if ESP.Survivor and p.Team and p.Team.Name == "Survivors" then
                                createESP(char, TeamColors.Survivor)
                            elseif ESP.Killer and p.Team and p.Team.Name == "Killer" then
                                createESP(char, TeamColors.Killer)
                            else
                                removeESP(char)
                            end
                        else
                            removeESP(char)
                        end
                    end
                    createStatusESP(p, char, root)
                else
                    removeESP(char)
                end
            end
        end
        if ESP.Generator then
            for gen in pairs(Cached.Generators) do
                UpdateGenerator(gen)
            end
        end
        for obj in pairs(Cached.Windows) do UpdateMapESP(obj, root) end
        for obj in pairs(Cached.Pallets) do UpdateMapESP(obj, root) end
        UpdateSCPEsp(root)
        if S.NoScreenEffects then applyNoScreenEffects() end
        if S.LowGraphics then applyLowGraphics() end
        if S.CleanSky then applyCleanSky() end
    end
end)

-- KILL EFFECT LOOP
task.spawn(function()
    while task.wait(2) do
        if S.KillEffect then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LP and p.Character then
                    local hum = p.Character:FindFirstChildOfClass("Humanoid")
                    if hum and hum.Health <= 0 then
                        local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                        if hrp and not p.Character:GetAttribute("CosmicKillEffect") then
                            p.Character:SetAttribute("CosmicKillEffect", true)
                            spawnKillEffect(hrp.Position)
                        end
                    else
                        if p.Character:GetAttribute("CosmicKillEffect") then
                            p.Character:SetAttribute("CosmicKillEffect", false)
                        end
                    end
                end
            end
        end
    end
end)

-- NO CLIP CAMERA
task.spawn(function()
    while task.wait(0.2) do
        local cam = workspace.CurrentCamera
        if cam then
            cam.CanCollide = not S.NoClipCamera
        end
    end
end)

print("✅ [5/15] COSMIC - Fitur Aktif + Loop Utama Loaded")-- =========================================================
-- SECTION 6/15 : GUI COSMIC + TOMBOL + PANEL
-- =========================================================

gui = Instance.new("ScreenGui")
gui.Name = "CosmicHub"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = PG

-- TOMBOL MENU COSMIC
btnContainer = Instance.new("Frame")
btnContainer.Size = UDim2.new(0, 32, 0, 32)
btnContainer.Position = UDim2.new(0, 15, 0.3, 0)
btnContainer.BackgroundTransparency = 1
btnContainer.Parent = gui

local outerGlow = Instance.new("Frame")
outerGlow.Size = UDim2.new(1, 14, 1, 14)
outerGlow.Position = UDim2.new(0, -7, 0, -7)
outerGlow.BackgroundColor3 = Color3.fromRGB(120, 60, 255)
outerGlow.BackgroundTransparency = 0.8
outerGlow.BorderSizePixel = 0
outerGlow.ZIndex = -1
outerGlow.Parent = btnContainer
rnd(outerGlow, 999)

local ringOuter = Instance.new("Frame")
ringOuter.Size = UDim2.new(1, 6, 1, 6)
ringOuter.Position = UDim2.new(0, -3, 0, -3)
ringOuter.BackgroundTransparency = 1
ringOuter.Parent = btnContainer

local ringOuterStroke = Instance.new("UIStroke")
ringOuterStroke.Thickness = 2
ringOuterStroke.Color = Color3.fromRGB(180, 100, 255)
ringOuterStroke.Transparency = 0.1
ringOuterStroke.Parent = ringOuter

local ringOuterGrad = Instance.new("UIGradient")
ringOuterGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 60, 255)),
    ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 230, 255)),
    ColorSequenceKeypoint.new(0.66, Color3.fromRGB(255, 80, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 60, 255)),
})
ringOuterGrad.Parent = ringOuterStroke

local ringInner = Instance.new("Frame")
ringInner.Size = UDim2.new(1, -2, 1, -2)
ringInner.Position = UDim2.new(0, 1, 0, 1)
ringInner.BackgroundTransparency = 1
ringInner.Parent = btnContainer

local ringInnerStroke = Instance.new("UIStroke")
ringInnerStroke.Thickness = 1
ringInnerStroke.Color = Color3.fromRGB(0, 230, 255)
ringInnerStroke.Transparency = 0.3
ringInnerStroke.Parent = ringInner

local mainBtn = Instance.new("TextButton")
mainBtn.Size = UDim2.new(1, -10, 1, -10)
mainBtn.Position = UDim2.new(0, 5, 0, 5)
mainBtn.BackgroundColor3 = Color3.fromRGB(25, 15, 50)
mainBtn.Text = "C"
mainBtn.TextColor3 = Color3.fromRGB(220, 180, 255)
mainBtn.TextSize = 14
mainBtn.Font = Enum.Font.GothamBlack
mainBtn.BorderSizePixel = 0
mainBtn.AutoButtonColor = false
mainBtn.Parent = btnContainer
rnd(mainBtn, 999)

local btnGrad = Instance.new("UIGradient")
btnGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(60, 30, 120)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(25, 15, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 30, 120)),
})
btnGrad.Rotation = 45
btnGrad.Parent = mainBtn

task.spawn(function()
    local t = 0
    while btnContainer.Parent do
        t = t + 0.05
        ringOuter.Rotation = t * 30
        ringOuterGrad.Rotation = t * 60
        ringInner.Rotation = -t * 50
        local pulse = (math.sin(t * 3) + 1) / 2
        outerGlow.BackgroundTransparency = 0.8 - pulse * 0.3
        outerGlow.Size = UDim2.new(1, 14 + pulse * 8, 1, 14 + pulse * 8)
        outerGlow.Position = UDim2.new(0, -7 - pulse * 4, 0, -7 - pulse * 4)
        btnGrad.Rotation = t * 30
        mainBtn.TextColor3 = Color3.fromHSV((t * 0.15) % 1, 0.5, 1)
        mainBtn.TextSize = 14 + math.sin(t * 4) * 1
        task.wait(0.05)
    end
end)

dragging = false
dragStart = nil
startPos = nil
wasDragged = false

btnContainer.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        wasDragged = false
        dragStart = input.Position
        startPos = btnContainer.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        if math.abs(delta.X) > 3 or math.abs(delta.Y) > 3 then
            wasDragged = true
        end
        btnContainer.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- PANEL MENU
panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 420, 0, 340)
panel.Position = UDim2.new(0.5, -210, 0.5, -170)
panel.BackgroundColor3 = C.BG
panel.BackgroundTransparency = 0.05
panel.BorderSizePixel = 0
panel.Visible = false
panel.Parent = gui
rnd(panel, 18)
strk(panel, C.ACC, 2, 0.3)

local panelGrad = Instance.new("UIGradient")
panelGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, C.BG),
    ColorSequenceKeypoint.new(0.5, C.BG2),
    ColorSequenceKeypoint.new(1, C.BG),
})
panelGrad.Rotation = 45
panelGrad.Parent = panel

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = C.PANEL
header.BackgroundTransparency = 0.1
header.BorderSizePixel = 0
header.Parent = panel
rnd(header, 18)

local hPatch = Instance.new("Frame")
hPatch.Size = UDim2.new(1, 0, 0, 20)
hPatch.Position = UDim2.new(0, 0, 1, -20)
hPatch.BackgroundColor3 = C.PANEL
hPatch.BackgroundTransparency = 0.1
hPatch.BorderSizePixel = 0
hPatch.Parent = header

local neonLine = Instance.new("Frame")
neonLine.Size = UDim2.new(1, -40, 0, 3)
neonLine.Position = UDim2.new(0, 20, 1, -1.5)
neonLine.BackgroundColor3 = C.ACC2
neonLine.BorderSizePixel = 0
neonLine.Parent = header

local neonGrad = Instance.new("UIGradient")
neonGrad.Color = ColorSequence.new(
    Color3.fromRGB(120, 60, 255),
    Color3.fromRGB(0, 230, 255),
    Color3.fromRGB(255, 80, 200)
)
neonGrad.Parent = neonLine

task.spawn(function()
    while neonLine.Parent do
        for i = 0, 1, 0.08 do
            if not neonLine.Parent then break end
            neonGrad.Rotation = i * 360
            task.wait(0.1)
        end
    end
end)

local hTitle = Instance.new("TextLabel")
hTitle.Size = UDim2.new(1, -80, 1, 0)
hTitle.Position = UDim2.new(0, 16, 0, 0)
hTitle.BackgroundTransparency = 1
hTitle.Text = "COSMIC"
hTitle.TextColor3 = C.FIRE_BRIGHT
hTitle.TextSize = 13
hTitle.Font = Enum.Font.GothamBlack
hTitle.TextXAlignment = Enum.TextXAlignment.Left
hTitle.TextStrokeTransparency = 0.2
hTitle.TextStrokeColor3 = C.ACC
hTitle.Parent = header

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 22, 0, 22)
closeBtn.Position = UDim2.new(1, -30, 0.5, -11)
closeBtn.BackgroundColor3 = C.PANEL2
closeBtn.Text = "X"
closeBtn.TextColor3 = C.RED
closeBtn.TextSize = 11
closeBtn.Font = Enum.Font.GothamBlack
closeBtn.BorderSizePixel = 0
closeBtn.AutoButtonColor = false
closeBtn.Parent = header
rnd(closeBtn, 7)
strk(closeBtn, C.RED, 1, 0.5)

sbFrame = Instance.new("Frame")
sbFrame.Size = UDim2.new(0, 105, 1, -58)
sbFrame.Position = UDim2.new(0, 10, 0, 50)
sbFrame.BackgroundColor3 = C.PANEL
sbFrame.BackgroundTransparency = 0.15
sbFrame.BorderSizePixel = 0
sbFrame.Parent = panel
rnd(sbFrame, 12)
strk(sbFrame, C.ACC, 1, 0.5)

sb = Instance.new("ScrollingFrame")
sb.Size = UDim2.new(1, -4, 1, -4)
sb.Position = UDim2.new(0, 2, 0, 2)
sb.BackgroundTransparency = 1
sb.BorderSizePixel = 0
sb.ScrollBarThickness = 3
sb.ScrollBarImageColor3 = C.ACC2
sb.CanvasSize = UDim2.new(0, 0, 0, 0)
sb.AutomaticCanvasSize = Enum.AutomaticSize.Y
sb.Parent = sbFrame

local sbL = Instance.new("UIListLayout")
sbL.Padding = UDim.new(0, 4)
sbL.Parent = sb

ct = Instance.new("Frame")
ct.Size = UDim2.new(1, -135, 1, -58)
ct.Position = UDim2.new(0, 122, 0, 50)
ct.BackgroundColor3 = C.PANEL
ct.BackgroundTransparency = 0.15
ct.BorderSizePixel = 0
ct.Parent = panel
rnd(ct, 12)
strk(ct, C.ACC, 1, 0.5)

cs = Instance.new("ScrollingFrame")
cs.Size = UDim2.new(1, -14, 1, -14)
cs.Position = UDim2.new(0, 7, 0, 7)
cs.BackgroundTransparency = 1
cs.BorderSizePixel = 0
cs.ScrollBarThickness = 3
cs.ScrollBarImageColor3 = C.ACC2
cs.CanvasSize = UDim2.new(0, 0, 0, 0)
cs.AutomaticCanvasSize = Enum.AutomaticSize.Y
cs.Parent = ct

local csL = Instance.new("UIListLayout")
csL.Padding = UDim.new(0, 5)
csL.Parent = cs

-- KOMPONEN UI
function sec(title, icon)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -4, 0, 22)
    f.BackgroundTransparency = 1
    f.Parent = cs

    local deco = Instance.new("Frame")
    deco.Size = UDim2.new(0, 4, 0, 14)
    deco.Position = UDim2.new(0, 4, 0.5, -7)
    deco.BackgroundColor3 = C.ACC
    deco.BorderSizePixel = 0
    deco.Parent = f
    rnd(deco, 2)

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -20, 1, 0)
    l.Position = UDim2.new(0, 14, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = icon .. " " .. string.upper(title)
    l.TextColor3 = C.FIRE_BRIGHT
    l.TextSize = 9
    l.Font = Enum.Font.GothamBlack
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f
end

function lbl(text, color)
    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -4, 0, 16)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = color or C.DIM
    l.TextSize = 8
    l.Font = Enum.Font.Gotham
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = cs
end

function tog(name, def, cb)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -4, 0, 28)
    f.BackgroundColor3 = C.BG
    f.BackgroundTransparency = 0.4
    f.BorderSizePixel = 0
    f.Parent = cs
    rnd(f, 8)
    local fStrk = strk(f, C.ACC, 1, 0.5)

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -50, 1, 0)
    l.Position = UDim2.new(0, 8, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = name
    l.TextColor3 = C.TXT
    l.TextSize = 9
    l.Font = Enum.Font.GothamMedium
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f

    local t = Instance.new("Frame")
    t.Size = UDim2.new(0, 32, 0, 16)
    t.Position = UDim2.new(1, -40, 0.5, -8)
    t.BorderSizePixel = 0
    t.Parent = f
    rnd(t, 9)

    local k = Instance.new("Frame")
    k.Size = UDim2.new(0, 11, 0, 11)
    k.BorderSizePixel = 0
    k.Parent = t
    rnd(k, 6)

    local saved = _G.ToggleStates[name]
    local state
    if saved ~= nil then state = saved else state = def end
    _G.ToggleStates[name] = state

    t.BackgroundColor3 = state and C.ACC or C.PANEL
    k.Position = state and UDim2.new(1, -14, 0.5, -5.5) or UDim2.new(0, 3, 0.5, -5.5)
    k.BackgroundColor3 = state and Color3.new(1, 1, 1) or C.DIM

    local cB = Instance.new("TextButton")
    cB.Size = UDim2.new(1, 0, 1, 0)
    cB.BackgroundTransparency = 1
    cB.Text = ""
    cB.Parent = t

    cB.MouseButton1Click:Connect(function()
        state = not state
        _G.ToggleStates[name] = state
        TweenService:Create(k, TweenInfo.new(0.2, Enum.EasingStyle.Back), {
            Position = state and UDim2.new(1, -14, 0.5, -5.5) or UDim2.new(0, 3, 0.5, -5.5),
            BackgroundColor3 = state and Color3.new(1, 1, 1) or C.DIM
        }):Play()
        TweenService:Create(t, TweenInfo.new(0.2), {
            BackgroundColor3 = state and C.ACC or C.PANEL
        }):Play()
        fStrk.Color = state and C.ACC2 or C.ACC
        playToggleSound()
        if cb then pcall(cb, state) end
    end)
end

function sl(name, min, max, def, cb)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -4, 0, 36)
    f.BackgroundColor3 = C.BG
    f.BackgroundTransparency = 0.4
    f.BorderSizePixel = 0
    f.Parent = cs
    rnd(f, 8)
    strk(f, C.ACC, 1, 0.5)

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -55, 0, 14)
    l.Position = UDim2.new(0, 8, 0, 4)
    l.BackgroundTransparency = 1
    l.Text = name
    l.TextColor3 = C.TXT
    l.TextSize = 9
    l.Font = Enum.Font.GothamMedium
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f

    local curVal = _G.SliderStates[name] or def
    _G.SliderStates[name] = curVal

    local v = Instance.new("TextLabel")
    v.Size = UDim2.new(0, 40, 0, 14)
    v.Position = UDim2.new(1, -48, 0, 4)
    v.BackgroundTransparency = 1
    v.Text = tostring(curVal)
    v.TextColor3 = C.ACC2
    v.TextSize = 9
    v.Font = Enum.Font.GothamBold
    v.TextXAlignment = Enum.TextXAlignment.Right
    v.Parent = f

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, -20, 0, 5)
    bg.Position = UDim2.new(0, 10, 1, -11)
    bg.BackgroundColor3 = C.PANEL
    bg.BorderSizePixel = 0
    bg.Parent = f
    rnd(bg, 3)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((curVal - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = C.ACC2
    fill.BorderSizePixel = 0
    fill.Parent = bg
    rnd(fill, 3)

    local kn = Instance.new("Frame")
    kn.Size = UDim2.new(0, 11, 0, 11)
    kn.Position = UDim2.new((curVal - min) / (max - min), -5.5, 0.5, -5.5)
    kn.BackgroundColor3 = Color3.new(1, 1, 1)
    kn.BorderSizePixel = 0
    kn.ZIndex = 2
    kn.Parent = bg
    rnd(kn, 6)
    strk(kn, C.ACC2, 2)

    local drag = false
    local function upd(input)
        local pos = math.clamp(
            (input.Position.X - bg.AbsolutePosition.X) / bg.AbsoluteSize.X,
            0, 1
        )
        local val = math.floor((min + (max - min) * pos) * 100 + 0.5) / 100
        _G.SliderStates[name] = val
        fill.Size = UDim2.new(pos, 0, 1, 0)
        kn.Position = UDim2.new(pos, -5.5, 0.5, -5.5)
        v.Text = tostring(val)
        if cb then pcall(cb, val) end
    end

    bg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            drag = true
            upd(input)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if drag and (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch) then
            upd(input)
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            drag = false
        end
    end)
end

function cpk(name, def, cb)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -4, 0, 28)
    f.BackgroundColor3 = C.BG
    f.BackgroundTransparency = 0.4
    f.BorderSizePixel = 0
    f.Parent = cs
    rnd(f, 8)
    strk(f, C.ACC, 1, 0.5)

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(1, -50, 1, 0)
    l.Position = UDim2.new(0, 8, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = name
    l.TextColor3 = C.TXT
    l.TextSize = 9
    l.Font = Enum.Font.GothamMedium
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f

    local cB = Instance.new("TextButton")
    cB.Size = UDim2.new(0, 30, 0, 15)
    cB.Position = UDim2.new(1, -38, 0.5, -7.5)
    cB.BackgroundColor3 = def
    cB.Text = ""
    cB.BorderSizePixel = 0
    cB.Parent = f
    rnd(cB, 4)
    strk(cB, C.ACC2, 1.5)

    local presets = {
        Color3.fromRGB(120, 60, 255), Color3.fromRGB(0, 230, 255),
        Color3.fromRGB(255, 80, 200), Color3.fromRGB(255, 60, 60),
        Color3.fromRGB(60, 255, 120), Color3.fromRGB(255, 170, 0),
        Color3.fromRGB(255, 255, 0), Color3.fromRGB(255, 255, 255),
        Color3.fromRGB(20, 20, 20),
    }
    local idx = 1

    cB.MouseButton1Click:Connect(function()
        idx = idx + 1
        if idx > #presets then idx = 1 end
        cB.BackgroundColor3 = presets[idx]
        if cb then pcall(cb, presets[idx]) end
    end)
end

function btn(name, cb)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -4, 0, 28)
    b.BackgroundColor3 = C.BG
    b.BackgroundTransparency = 0.4
    b.Text = name
    b.TextColor3 = C.TXT
    b.TextSize = 9
    b.Font = Enum.Font.GothamMedium
    b.BorderSizePixel = 0
    b.AutoButtonColor = false
    b.Parent = cs
    rnd(b, 8)
    strk(b, C.ACC2, 1, 0.5)

    b.MouseButton1Click:Connect(function()
        playToggleSound()
        if cb then pcall(cb) end
    end)
end

function drp(name, options, def, cb)
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1, -4, 0, 28)
    f.BackgroundColor3 = C.BG
    f.BackgroundTransparency = 0.4
    f.BorderSizePixel = 0
    f.Parent = cs
    rnd(f, 8)
    strk(f, C.ACC, 1, 0.5)

    local l = Instance.new("TextLabel")
    l.Size = UDim2.new(0.5, 0, 1, 0)
    l.Position = UDim2.new(0, 8, 0, 0)
    l.BackgroundTransparency = 1
    l.Text = name
    l.TextColor3 = C.TXT
    l.TextSize = 9
    l.Font = Enum.Font.GothamMedium
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.Parent = f

    _G.DropdownStates = _G.DropdownStates or {}
    local savedIdx = _G.DropdownStates[name]
    local idx = savedIdx or 1
    if not savedIdx then
        for i, o in ipairs(options) do
            if o == def then idx = i end
        end
        _G.DropdownStates[name] = idx
    end
    local cur = options[idx]

    local v = Instance.new("TextLabel")
    v.Size = UDim2.new(0.5, -24, 1, 0)
    v.Position = UDim2.new(0.5, 0, 0, 0)
    v.BackgroundTransparency = 1
    v.Text = tostring(cur) .. " >"
    v.TextColor3 = C.ACC2
    v.TextSize = 8
    v.Font = Enum.Font.GothamBold
    v.TextXAlignment = Enum.TextXAlignment.Right
    v.Parent = f

    local cB = Instance.new("TextButton")
    cB.Size = UDim2.new(1, 0, 1, 0)
    cB.BackgroundTransparency = 1
    cB.Text = ""
    cB.Parent = f

    cB.MouseButton1Click:Connect(function()
        idx = idx + 1
        if idx > #options then idx = 1 end
        cur = options[idx]
        _G.DropdownStates[name] = idx
        v.Text = tostring(cur) .. " >"
        if cb then pcall(cb, cur) end
    end)

    if cb and savedIdx then
        task.defer(function() pcall(cb, cur) end)
    end
end

activeTab = nil
function makeTab(name, icon, order, cb)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -8, 0, 32)
    b.BackgroundColor3 = C.BG
    b.BackgroundTransparency = 1
    b.Text = ""
    b.BorderSizePixel = 0
    b.LayoutOrder = order
    b.AutoButtonColor = false
    b.Parent = sb
    rnd(b, 7)

    local ind = Instance.new("Frame")
    ind.Size = UDim2.new(0, 3, 0, 0)
    ind.Position = UDim2.new(0, 0, 0.5, 0)
    ind.AnchorPoint = Vector2.new(0, 0.5)
    ind.BackgroundColor3 = C.ACC2
    ind.BorderSizePixel = 0
    ind.Parent = b
    rnd(ind, 2)

    local ico = Instance.new("TextLabel")
    ico.Size = UDim2.new(0, 24, 1, 0)
    ico.Position = UDim2.new(0, 4, 0, 0)
    ico.BackgroundTransparency = 1
    ico.Text = icon
    ico.TextColor3 = C.DIM
    ico.TextSize = 16
    ico.Font = Enum.Font.GothamBold
    ico.Parent = b

    local lblT = Instance.new("TextLabel")
    lblT.Size = UDim2.new(1, -30, 1, 0)
    lblT.Position = UDim2.new(0, 30, 0, 0)
    lblT.BackgroundTransparency = 1
    lblT.Text = string.upper(name)
    lblT.TextColor3 = C.DIM
    lblT.TextSize = 8
    lblT.Font = Enum.Font.GothamBlack
    lblT.TextXAlignment = Enum.TextXAlignment.Left
    lblT.Parent = b

    b.MouseButton1Click:Connect(function()
        if activeTab == b then return end
        if activeTab then
            activeTab.BackgroundTransparency = 1
            local oldInd = activeTab:FindFirstChildOfClass("Frame")
            if oldInd then
                TweenService:Create(oldInd, TweenInfo.new(0.2), {
                    Size = UDim2.new(0, 3, 0, 0)
                }):Play()
            end
            for _, c in pairs(activeTab:GetChildren()) do
                if c:IsA("TextLabel") then
                    TweenService:Create(c, TweenInfo.new(0.2), {TextColor3 = C.DIM}):Play()
                end
            end
        end

        activeTab = b
        TweenService:Create(b, TweenInfo.new(0.2), {BackgroundTransparency = 0.7}):Play()
        TweenService:Create(ind, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
            Size = UDim2.new(0, 3, 0, 18)
        }):Play()

        for _, c in pairs(b:GetChildren()) do
            if c:IsA("TextLabel") then
                TweenService:Create(c, TweenInfo.new(0.2), {TextColor3 = C.TXT}):Play()
            end
        end

        for _, c in pairs(cs:GetChildren()) do
            if not c:IsA("UIListLayout") then
                c:Destroy()
            end
        end

        if cb then pcall(cb) end
    end)
end

_G.Roooor_sec = sec
_G.Roooor_lbl = lbl
_G.Roooor_tog = tog
_G.Roooor_sl = sl
_G.Roooor_cpk = cpk
_G.Roooor_btn = btn
_G.Roooor_drp = drp
_G.Roooor_makeTab = makeTab
_G.Roooor_cs = cs

mainBtn.MouseButton1Click:Connect(function()
    if wasDragged then
        wasDragged = false
        return
    end
    panel.Visible = not panel.Visible
    playToggleSound()
end)

closeBtn.MouseButton1Click:Connect(function()
    panel.Visible = false
    playToggleSound()
end)

print("✅ [6/15] COSMIC - GUI + Tombol + Panel Loaded")-- =========================================================
-- SECTION 7/15 : TAB UI PART 1
-- =========================================================

sec = _G.Roooor_sec
lbl = _G.Roooor_lbl
tog = _G.Roooor_tog
sl = _G.Roooor_sl
cpk = _G.Roooor_cpk
btn = _G.Roooor_btn
drp = _G.Roooor_drp
makeTab = _G.Roooor_makeTab
cs = _G.Roooor_cs

-- TAB 1: SURVIVOR
makeTab("Survivor", "🏃", 1, function()
    sec("Auto Parry", "🛡️")
    tog("Enable Auto Parry", false, function(s)
        AutoParry.Enabled = s
        if s then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LP and p.Character and p.Team and p.Team.Name == "Killer" then
                    task.spawn(function() AP_HookKiller(p.Character) end)
                end
            end
        end
    end)
    lbl("Hybrid + Predictive + Double Tap", C.FIRE_BRIGHT)
    sl("Parry Radius", 5, 40, 20, function(v)
        AutoParry.ParryDistance = v
        AP_Config.Radius = v
    end)
    sl("Debounce", 0.01, 0.5, 0.02, function(v)
        AP_PARRY_DEBOUNCE = v
        AP_Config.Debounce = v
    end)
    sl("Circle Height", -5, 15, -2.5, function(v)
        AP_ESPCircle.YOffset = v
    end)
    tog("Show Circle", false, function(s)
        AP_ESPCircle.Enabled = s
        if not s then AP_ClearCircle() end
    end)
    btn("Reset Parry Counter", function()
        AP_parryCount = 0
    end)

    sec("Aimbot Senter (PENCET = LOCK)", "🔦")
    tog("Enable Aimbot Senter", false, function(s)
        AimbotSenter.Enabled = s
        if s then
            task.spawn(function() pcall(HookSenterButtons) end)
        else
            AimbotSenter.HoldingSenter = false
            AimbotSenter.CurrentTarget = nil
        end
    end)
    lbl("PENCET tombol senter = LOCK ke killer", C.FIRE_BRIGHT)
    lbl("LEPAS tombol = kamera bebas", C.GRN)
    lbl("GAK PENCET = gak lock", C.ACC2)
    sl("Smoothness", 0.1, 1, 0.5, function(v)
        AimbotSenter.Smoothness = v
    end)
    drp("Lock Part", {"Head", "HumanoidRootPart", "UpperTorso"}, "Head", function(v)
        AimbotSenter.LockPart = v
    end)
    tog("Show ESP Laser", true, function(s)
        AimbotSenter.ShowLaser = s
    end)
    cpk("Laser Color", Color3.fromRGB(255, 0, 0), function(c)
        AimbotSenter.LaserColor = c
    end)

    sec("Auto Skill Check (2 MODE)", "⚡")
    tog("Enable Auto Skill Check", false, function(s)
        SkillCheck.Enabled = s
        if s then startSkillCheck() end
    end)
    drp("Mode", {"Perfect", "Instant"}, "Perfect", function(v)
        SkillCheck.Mode = v
    end)
    lbl("Perfect = Fallens Style (102-116°)", C.FIRE_BRIGHT)
    tog("Hide Needle (Instant only)", false, function(s)
        SkillCheck.HideNeedle = s
    end)
    btn("Reset Counter", function()
        SkillCheck.Success = 0
        SkillCheck.Total = 0
    end)

    sec("Auto Wiggle (Anti Gendong)", "🔓")
    tog("Enable Auto Wiggle", false, function(s)
        AutoParry.Wiggle = s
    end)
    sl("Wiggle Spam", 1, 20, 5, function(v)
        AutoParry.WiggleSpam = v
    end)

    sec("Auto Flee Killer", "🏃‍♂️")
    tog("Enable Auto Flee", false, function(s)
        AutoFlee.Enabled = s
    end)
    lbl("TP ke generator terjauh kalau killer deket", C.FIRE_BRIGHT)
    sl("Detect Distance", 10, 150, 50, function(v)
        AutoFlee.DetectDistance = v
    end)
    sl("Cooldown", 0.1, 5, 0.5, function(v)
        AutoFlee.Cooldown = v
    end)

    sec("Fast Vault", "⚡")
    tog("Enable Fast Vault", false, function(s)
        FastVault.Enabled = s
        if s and LP.Character then hookVault(LP.Character) end
    end)
    sl("Animation Speed", 1, 5, 1.2, function(v)
        FastVault.Speed = v
    end)

    sec("Auto Escape Gate", "🚪")
    tog("Enable Auto Escape", false, function(s)
        S.AutoEscapeGate = s
    end)
    tog("Trigger: Killer Deket", true, function(s)
        S.AutoEscapeUseKillerCheck = s
    end)
    tog("Trigger: Generator Cukup", true, function(s)
        S.AutoEscapeUseGenCheck = s
    end)
    sl("Killer Range", 10, 150, 50, function(v)
        S.AutoEscapeRange = v
    end)

    sec("God Mode", "🛡️")
    tog("God Mode (Full)", false, function(s)
        GodMode.Enabled = s
    end)

    sec("Support", "💊")
    tog("Instant Interact", false, function(s) S.InstantInteract = s end)

    sec("Teleport", "🌀")
    btn("TP ke Finish Line", function()
        teleportToFinishLine()
    end)
end)

-- TAB 2: KILLER
makeTab("Killer", "🔪", 2, function()
    sec("Auto Attack", "⚔️")
    tog("Killer Auto Attack", false, function(s) S.Killer_AutoAtk = s end)
    sl("Attack Delay", 0.1, 1, 0.35, function(v) S.Killer_AtkDelay = v end)

    sec("Kill All", "💀")
    tog("Killer Kill All", false, function(s) S.Killer_KillAll = s end)

    sec("Auto Carry + Hook", "🎒")
    tog("Auto Carry (Downed)", false, function(s) S.AutoCarry = s end)
    tog("Auto Hook", false, function(s) S.AutoHook = s end)
    sl("Carry Range", 10, 200, 60, function(v) S.CarryRange = v end)

    sec("Masked Power", "🎭")
    drp("Select Power", {"Cobra", "Richter", "Brandon", "Rabbit", "Alex"}, "Cobra", function(v)
        S.MaskedPower = v
    end)
    btn("Activate Power", function()
        local Event = ReplicatedStorage:FindFirstChild("Remotes", true)
            and ReplicatedStorage.Remotes:FindFirstChild("Killers", true)
            and ReplicatedStorage.Remotes.Killers:FindFirstChild("Masked", true)
            and ReplicatedStorage.Remotes.Killers.Masked:FindFirstChild("Activatepower")
        if Event then Event:FireServer(S.MaskedPower) end
    end)
    btn("Deactivate Power", function()
        local Event = ReplicatedStorage:FindFirstChild("Remotes", true)
            and ReplicatedStorage.Remotes:FindFirstChild("Killers", true)
            and ReplicatedStorage.Remotes.Killers:FindFirstChild("Masked", true)
            and ReplicatedStorage.Remotes.Killers.Masked:FindFirstChild("Deactivatepower")
        if Event then Event:FireServer() end
    end)
end)

-- TAB 3: ESP
makeTab("ESP", "👁️", 3, function()
    sec("Player ESP", "🟢")
    tog("ESP Survivor", true, function(s) ESP.Survivor = s end)
    cpk("Survivor Color", TeamColors.Survivor, function(c) TeamColors.Survivor = c end)
    tog("ESP Killer", true, function(s) ESP.Killer = s end)
    cpk("Killer Color", TeamColors.Killer, function(c) TeamColors.Killer = c end)

    sec("Object ESP", "⚡")
    tog("ESP Generator", true, function(s) ESP.Generator = s end)
    cpk("Gen Color", GeneratorColor, function(c) GeneratorColor = c end)
    drp("Generator Mode", {"Classic", "Bar"}, "Bar", function(v)
        S.ESPGenMode = v
        for gen in pairs(Cached.Generators) do
            local a = gen:FindFirstChild("GenESP")
            if a then a:Destroy() end
            local b = gen:FindFirstChild("GenESPBar")
            if b then b:Destroy() end
        end
    end)
    sl("Bar Width", 40, 200, 64, function(v) S.ESPGenBarSize = v end)
    sl("Bar Height", 8, 40, 8, function(v) S.ESPGenBarHeight = v end)
    sl("Text Size", 6, 30, 10, function(v) S.ESPGenBarTextSize = v end)
    tog("ESP Pallet", false, function(s) ESP.Pallet = s end)
    cpk("Pallet Color", PalletColor, function(c) PalletColor = c end)
    tog("ESP Window", false, function(s) ESP.Window = s end)
    cpk("Window Color", WindowColor, function(c) WindowColor = c end)
    tog("ESP SCP", false, function(s) ESP.SCP = s end)
    cpk("SCP Color", SCPColor, function(c) SCPColor = c end)

    sec("ESP Distance", "📏")
    sl("ESP Radius", 10, 1000, 1000, function(v) ESP.Distance = v end)

    sec("Status ESP", "🟢")
    tog("Enable Status ESP", false, function(s) ESPStatus.Enabled = s end)
    tog("Show Name", true, function(s) ESPStatus.ShowName = s end)
    tog("Show Distance", true, function(s) ESPStatus.ShowDistance = s end)
    tog("Show Health", true, function(s) ESPStatus.ShowHealth = s end)
    sl("Status Radius", 20, 1000, 1000, function(v) ESPStatus.Radius = v end)

    sec("Nama Mode", "✨")
    drp("Name Mode", {"Text", "Galaxy"}, "Galaxy", function(v)
        S.ESPNameMode = v
    end)
    sl("Name Size", 8, 30, 8, function(v)
        S.ESPNameSize = v
    end)
end)

-- TAB 4: FIRE
makeTab("Fire", "🔥", 4, function()
    sec("Fire Control", "⚙️")
    tog("Enable Fire", false, function(s)
        S.FireOn = s
        applyFire()
    end)
    sl("Fire Size", 1, 15, 5, function(v)
        S.FireSize = v
        applyFire()
    end)

    sec("Pilih Efek Fire (60)", "🔥")
    for i, fireName in ipairs(FireList) do
        local btn2 = Instance.new("TextButton")
        btn2.Size = UDim2.new(1, -4, 0, 24)
        btn2.BackgroundColor3 = C.BG
        btn2.BackgroundTransparency = 0.4
        btn2.BorderSizePixel = 0
        btn2.Text = ""
        btn2.AutoButtonColor = false
        btn2.LayoutOrder = i + 100
        btn2.Parent = cs
        rnd(btn2, 7)
        strk(btn2, C.ACC, 1, 0.6)

        local btnLbl = Instance.new("TextLabel")
        btnLbl.Size = UDim2.new(1, -10, 1, 0)
        btnLbl.Position = UDim2.new(0, 8, 0, 0)
        btnLbl.BackgroundTransparency = 1
        btnLbl.Text = fireName
        btnLbl.TextColor3 = C.TXT
        btnLbl.TextSize = 9
        btnLbl.Font = Enum.Font.GothamMedium
        btnLbl.TextXAlignment = Enum.TextXAlignment.Left
        btnLbl.Parent = btn2

        if S.FireType == fireName then
            btn2.BackgroundColor3 = C.ACC
            btn2.BackgroundTransparency = 0
            btnLbl.TextColor3 = Color3.new(1, 1, 1)
        end

        btn2.MouseButton1Click:Connect(function()
            S.FireType = fireName
            applyFire()
            for _, c in pairs(cs:GetChildren()) do
                if c:IsA("TextButton") and c.LayoutOrder > 100 and c.LayoutOrder < 200 then
                    c.BackgroundColor3 = C.BG
                    c.BackgroundTransparency = 0.4
                    local l = c:FindFirstChildOfClass("TextLabel")
                    if l then l.TextColor3 = C.TXT end
                end
            end
            btn2.BackgroundColor3 = C.ACC
            btn2.BackgroundTransparency = 0
            btnLbl.TextColor3 = Color3.new(1, 1, 1)
        end)
    end
end)

-- TAB 5: MOONWALK
makeTab("Moonwalk", "🕺", 5, function()
    sec("Moonwalk (TOMBOL MW ONLY)", "🕺")
    lbl("Cukup tombol MW di pojok layar", C.FIRE_BRIGHT)
    tog("Enable Moonwalk", false, function(s)
        if setMoonwalk then setMoonwalk(s) else Moonwalk.Enabled = s end
        if _G.Roooor_mwBtnUpdateUI then pcall(_G.Roooor_mwBtnUpdateUI) end
    end)
    tog("Lock Moonwalk", false, function(s)
        Moonwalk.Locked = s
        if _G.Roooor_mwBtnUpdateUI then pcall(_G.Roooor_mwBtnUpdateUI) end
    end)
    tog("Show MW Button", true, function(s)
        Moonwalk.ShowButton = s
        if mwBtnGui then mwBtnGui.Enabled = s end
    end)
    btn("Reset Posisi Tombol MW", function()
        if mwBtn then mwBtn.Position = UDim2.new(0, 20, 1, -100) end
        if mwLockBtn then mwLockBtn.Position = UDim2.new(0, 20, 1, -128) end
    end)
    sl("Spam Speed", 1, 50, 30, function(v) Moonwalk.SpamSpeed = v end)
    sl("Intensity", 1, 50, 35, function(v) Moonwalk.Intensity = v end)
    sl("Slow Speed", 5, 20, 13, function(v) Moonwalk.SlowSpeed = v end)
    tog("Use Slow Speed", true, function(s) Moonwalk.UseSlow = s end)
end)

print("✅ [7/15] COSMIC - Tab UI Part 1 Loaded")-- =========================================================
-- SECTION 8/15 : TAB UI PART 2
-- =========================================================

sec = _G.Roooor_sec
lbl = _G.Roooor_lbl
tog = _G.Roooor_tog
sl = _G.Roooor_sl
cpk = _G.Roooor_cpk
btn = _G.Roooor_btn
drp = _G.Roooor_drp
makeTab = _G.Roooor_makeTab
cs = _G.Roooor_cs

-- TAB 7: MISC
makeTab("Misc", "⚙️", 7, function()
    sec("Movement", "🏃")
    tog("Walk Speed", false, function(s) S.WalkSpeed = s end)
    sl("Walk Speed Value", 16, 100, 16, function(v) S.WalkSpeedVal = v end)
    tog("Speed Hack", false, function(s) S.SpeedHack = s end)
    sl("Speed Hack Value", 20, 200, 40, function(v) S.SpeedHackVal = v end)
    tog("No Clip", false, function(s) S.NoClip = s end)
    tog("No Clip Camera", false, function(s) S.NoClipCamera = s end)

    sec("FOV (Default 90)", "🎥")
    local fov70 = Instance.new("TextButton")
    fov70.Size = UDim2.new(0.32, -3, 0, 30)
    fov70.Position = UDim2.new(0, 0, 0, 0)
    fov70.BackgroundColor3 = C.BG
    fov70.BackgroundTransparency = 0.4
    fov70.Text = "FOV 70"
    fov70.TextColor3 = C.TXT
    fov70.TextSize = 10
    fov70.Font = Enum.Font.GothamBold
    fov70.BorderSizePixel = 0
    fov70.AutoButtonColor = false
    fov70.Parent = cs
    rnd(fov70, 8)
    strk(fov70, C.ACC, 1, 0.5)

    local fov90 = Instance.new("TextButton")
    fov90.Size = UDim2.new(0.32, -3, 0, 30)
    fov90.Position = UDim2.new(0.34, 0, 0, 0)
    fov90.BackgroundColor3 = C.BG
    fov90.BackgroundTransparency = 0.4
    fov90.Text = "FOV 90"
    fov90.TextColor3 = C.GRN
    fov90.TextSize = 10
    fov90.Font = Enum.Font.GothamBold
    fov90.BorderSizePixel = 0
    fov90.AutoButtonColor = false
    fov90.Parent = cs
    rnd(fov90, 8)
    strk(fov90, C.GRN, 1.5, 0.2)

    local fov120 = Instance.new("TextButton")
    fov120.Size = UDim2.new(0.32, -3, 0, 30)
    fov120.Position = UDim2.new(0.68, 0, 0, 0)
    fov120.BackgroundColor3 = C.BG
    fov120.BackgroundTransparency = 0.4
    fov120.Text = "FOV 120"
    fov120.TextColor3 = C.TXT
    fov120.TextSize = 10
    fov120.Font = Enum.Font.GothamBold
    fov120.BorderSizePixel = 0
    fov120.AutoButtonColor = false
    fov120.Parent = cs
    rnd(fov120, 8)
    strk(fov120, C.ACC, 1, 0.5)

    fov70.MouseButton1Click:Connect(function()
        S.FOV = 70
        S.FOVEnabled = true
        applyFOV()
        playToggleSound()
    end)
    fov90.MouseButton1Click:Connect(function()
        S.FOV = 90
        S.FOVEnabled = true
        applyFOV()
        playToggleSound()
    end)
    fov120.MouseButton1Click:Connect(function()
        S.FOV = 120
        S.FOVEnabled = true
        applyFOV()
        playToggleSound()
    end)

    sec("Character", "🎭")
    tog("Headless", true, function(s)
        S.Headless = s
        applyHeadless(s)
    end)

    sec("Misc Utility", "🛠️")
    tog("Anti-AFK", false, function(s)
        S.AntiAFK = s
        applyAntiAFK(s)
    end)
    tog("Show FPS Counter", false, function(s) S.ShowFPS = s end)
    tog("Show Ping Counter", false, function(s) S.ShowPing = s end)
    btn("Rejoin Server", function() rejoinServer() end)
end)

-- TAB 9: VISUAL
makeTab("Visual", "✨", 9, function()
    sec("Fullbright & No Fog", "💡")
    tog("Fullbright", false, function(s)
        S.Fullbright = s
        applyFullbright(s)
    end)
    sl("Brightness Level", 10, 200, 100, function(v)
        S.FullbrightVal = v
        if S.Fullbright then applyFullbright(true) end
    end)
    tog("No Fog", false, function(s)
        S.NoFog = s
        applyNoFog(s)
    end)

    sec("HD Sky (Clean)", "🔷")
    tog("HD Sky (Clean)", false, function(s)
        S.HDSky = s
        applyHDSky(s)
    end)

    sec("HD Visual (Extra)", "🌟")
    tog("HD Texture", false, function(s) S.HDTexture = s; applyHDTexture(s) end)
    tog("HD Reflection", false, function(s) S.HDReflection = s; applyHDReflection(s) end)
    tog("HD Bloom", false, function(s) S.HDBloom = s; applyHDBloom(s) end)
    tog("HD Shadow", false, function(s) S.HDShadow = s; applyHDShadow(s) end)
    tog("HD Water", false, function(s) S.HDWater = s; applyHDWater(s) end)
    tog("HD Sun Rays", false, function(s) S.HDSunRays = s; applyHDSunRays(s) end)
    tog("HD Depth of Field", false, function(s) S.HDDepthField = s; applyHDDepthField(s) end)
    tog("HD Anti-Aliasing", false, function(s) S.HDAntiAliasing = s; applyHDAntiAliasing(s) end)

    sec("Lighting", "💡")
    tog("Ultra HD", false, function(s) S.UltraHD = s; applyUltraHD() end)
    tog("Contrast Boost", false, function(s) S.Contrast = s; applyContrast() end)
    sl("Contrast", 0, 1, 0.3, function(v) S.ContrastVal = v; applyContrast() end)
    sl("Saturation", 0, 1, 0.2, function(v) S.SaturationVal = v; applyContrast() end)

    sec("Sky (18 Preset)", "🌌")
    drp("Sky Preset", SkyList, "Default", function(v)
        S.SkyId = v
        applySky(v)
    end)

    sec("Camera", "🎥")
    tog("Zoom Out", false, function(s) S.ZoomOut = s; applyZoomOut(s, S.ZoomOutValue) end)
    sl("Max Zoom Distance", 100, 1000, 500, function(v)
        S.ZoomOutValue = v
        if S.ZoomOut then applyZoomOut(true, v) end
    end)

    sec("8-Bit Royal Crown", "👑")
    tog("Enable 8-Bit Crown", false, function(s)
        S.EightBitOn = s
        apply8Bit(s, "Royal Crown", S.EightBitSize, S.EightBitHeight)
    end)
    sl("Size", 0.3, 3, 1.24, function(v)
        S.EightBitSize = v
        if S.EightBitOn then apply8Bit(true, "Royal Crown", v, S.EightBitHeight) end
    end)
    sl("Height", -1, 4, 0.88, function(v)
        S.EightBitHeight = v
        if S.EightBitOn then apply8Bit(true, "Royal Crown", S.EightBitSize, v) end
    end)

    sec("Korblox Pencil", "🦴")
    tog("Enable Korblox", true, function(s)
        S.Korblox = s
        applyKorblox(s, "Pencil", S.KorbloxYOffset, S.KorbloxScale)
    end)
    sl("Korblox Y", -2, 2, 0.80, function(v)
        S.KorbloxYOffset = v
        if S.Korblox then applyKorblox(true, "Pencil", v, S.KorbloxScale) end
    end)
    sl("Korblox Scale", 0.3, 3, 1, function(v)
        S.KorbloxScale = v
        if S.Korblox then applyKorblox(true, "Pencil", S.KorbloxYOffset, v) end
    end)

    sec("Crosshair 8 Mode", "🎯")
    tog("Enable Crosshair", false, function(s)
        S.Crosshair = s
        applyCrosshair(s, S.CrosshairColor, S.CrosshairSize)
    end)
    drp("Style (8 Mode)", {"Plus", "Dot", "Circle", "X", "Square", "Diamond", "TShape", "CrossDot"}, "Plus", function(v)
        S.CrosshairStyle = v
        if S.Crosshair then applyCrosshair(true, S.CrosshairColor, S.CrosshairSize) end
    end)
    drp("Color Mode", {"Solid", "Galaxy"}, "Solid", function(v)
        S.CrosshairColorMode = v
        if S.Crosshair then applyCrosshair(true, S.CrosshairColor, S.CrosshairSize) end
    end)
    cpk("Crosshair Color", S.CrosshairColor, function(c)
        S.CrosshairColor = c
        if S.Crosshair then applyCrosshair(true, c, S.CrosshairSize) end
    end)
    sl("Crosshair Size", 4, 30, 8, function(v)
        S.CrosshairSize = v
        if S.Crosshair then applyCrosshair(true, S.CrosshairColor, v) end
    end)
    sl("Crosshair Thickness", 1, 6, 2, function(v)
        S.CrosshairThickness = v
        if S.Crosshair then applyCrosshair(true, S.CrosshairColor, S.CrosshairSize) end
    end)
    sl("Offset X", -200, 200, 0, function(v)
        S.CrosshairOffsetX = v
        if S.Crosshair then applyCrosshair(true, S.CrosshairColor, S.CrosshairSize) end
    end)
    sl("Offset Y", -200, 200, 0, function(v)
        S.CrosshairOffsetY = v
        if S.Crosshair then applyCrosshair(true, S.CrosshairColor, S.CrosshairSize) end
    end)

    sec("Character Effects", "✨")
    tog("Fire Trail", false, function(s)
        S.Trail = s
        applyTrail(s, S.TrailColor)
    end)
    cpk("Trail Color", S.TrailColor, function(c)
        S.TrailColor = c
        if S.Trail then applyTrail(true, c) end
    end)
    tog("Aura Fire", false, function(s)
        S.Aura = s
        applyAura(s, S.AuraColor)
    end)
    cpk("Aura Color", S.AuraColor, function(c)
        S.AuraColor = c
        if S.Aura then applyAura(true, c) end
    end)
    tog("Kill Effect", false, function(s) S.KillEffect = s end)

    sec("FPS Boost", "🚀")
    tog("No Screen Effects", false, function(s)
        S.NoScreenEffects = s
        applyNoScreenEffects()
    end)
    tog("Low Graphics", false, function(s)
        S.LowGraphics = s
        applyLowGraphics()
    end)
    tog("Clean Sky", false, function(s)
        S.CleanSky = s
        applyCleanSky()
    end)

    sec("Danger Zone", "⚠️")
    btn("UNLOAD COSMIC HUB", function()
        pcall(function()
            if gui then gui:Destroy() end
            if killFeedGui then killFeedGui:Destroy() end
            if loadingGui then loadingGui:Destroy() end
            if crosshairGui then crosshairGui:Destroy() end
            if fpsPingGui then fpsPingGui:Destroy() end
            if mwBtnGui then mwBtnGui:Destroy() end
            if Aimlock_Gui then Aimlock_Gui:Destroy() end
            if AimbotLaserGui then AimbotLaserGui:Destroy() end
            clear8Bit()
            clearKorblox()
            AP_ClearCircle()
            hitboxClearAll()
        end)
    end)
end)

-- TAB 10: HITBOX
makeTab("Hitbox", "📦", 10, function()
    sec("Hitbox Control (TEXT ANGKA)", "📦")
    tog("Enable Hitbox", false, function(s)
        Hitbox.Enabled = s
        if not s then hitboxClearAll() end
    end)
    sl("Hitbox Size (Radius)", 10, 70, 70, function(v)
        Hitbox.Size = v
        hitboxUpdateVisibility()
    end)
    sl("Text Size", 5, 30, 10, function(v)
        Hitbox.TextSize = v
        hitboxUpdateVisibility()
    end)
    drp("Mode", {"Auto", "Killer", "Survivor"}, "Auto", function(v)
        Hitbox.Mode = v
    end)
    cpk("Killer Text Color", Hitbox.ColorKiller, function(c)
        Hitbox.ColorKiller = c
        hitboxUpdateVisibility()
    end)
    cpk("Survivor Text Color", Hitbox.ColorSurvivor, function(c)
        Hitbox.ColorSurvivor = c
        hitboxUpdateVisibility()
    end)
    tog("Wall Bang", true, function(s)
        Hitbox.WallBang = s
    end)
end)

print("✅ [8/15] COSMIC - Tab UI Part 2 Loaded")-- =========================================================
-- SECTION 9/15 : KEYBIND + CAMERA FIX + ANTI-ILANG MENU
-- =========================================================

-- KEYBIND V UNTUK MOONWALK
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.V then
        if Moonwalk.Locked then
            pcall(function()
                StarterGui:SetCore("SendNotification", {
                    Title = "Moonwalk",
                    Text = "LOCKED!",
                    Duration = 1
                })
            end)
            return
        end
        setMoonwalk(not Moonwalk.Enabled)
        if _G.Roooor_mwBtnUpdateUI then pcall(_G.Roooor_mwBtnUpdateUI) end
        pcall(function()
            StarterGui:SetCore("SendNotification", {
                Title = "Moonwalk",
                Text = Moonwalk.Enabled and "ON" or "OFF",
                Duration = 1.5
            })
        end)
    end
end)

-- KEYBIND K = UNLOCK KAMERA
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.K then
        local cam = workspace.CurrentCamera
        local char = LP.Character
        if cam and char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
                pcall(function()
                    cam.CameraType = Enum.CameraType.Custom
                    cam.CameraSubject = hum
                    cam.Focus = CFrame.new(cam.CFrame.Position)
                    GuiService.SelectedObject = nil
                end)
                pcall(function()
                    StarterGui:SetCore("SendNotification", {
                        Title = "Camera Unlock",
                        Text = "Kamera di-reset",
                        Duration = 1.5
                    })
                end)
            end
        end
    end
end)

print("[KEYBIND] V = Moonwalk | K = Unlock Camera")

-- =========================================================
-- FIX CAMERA LOCK SETELAH PARRY/GEN
-- =========================================================
AP_LastCamFix = 0

task.spawn(function()
    while task.wait(0.05) do
        local cam = workspace.CurrentCamera
        local char = LP.Character
        if not cam or not char then continue end

        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then continue end

        -- Skip kalau Aimbot Senter lagi HOLD
        if AimbotSenter.Enabled and AimbotSenter.HoldingSenter then continue end

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

-- Force unlock kamera setelah parry anim
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
                local myChar = LP.Character
                if cam and myChar then
                    local myHum = myChar:FindFirstChildOfClass("Humanoid")
                    if myHum and not (AimbotSenter.Enabled and AimbotSenter.HoldingSenter) then
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

for _, p in pairs(Players:GetPlayers()) do
    if p ~= LP and p.Character and p.Team and p.Team.Name == "Killer" then
        task.spawn(function() hookKillerParryAnim(p.Character) end)
    end
    p.CharacterAdded:Connect(function(c)
        task.wait(1)
        if p.Team and p.Team.Name == "Killer" then
            hookKillerParryAnim(c)
        end
    end)
end

Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function(c)
        task.wait(1)
        if p.Team and p.Team.Name == "Killer" then
            hookKillerParryAnim(c)
        end
    end)
end)

-- =========================================================
-- ANTI-ILANG MENU
-- =========================================================
local function forceAllGuiResetOnSpawnFalse()
    for _, g in ipairs(PG:GetChildren()) do
        if g:IsA("ScreenGui") then
            pcall(function()
                g.ResetOnSpawn = false
                g.Enabled = true
            end)
        end
    end
end

task.spawn(function()
    while task.wait(0.2) do
        pcall(forceAllGuiResetOnSpawnFalse)

        if not gui or not gui.Parent then
            local existing = PG:FindFirstChild("CosmicHub")
            if existing then
                gui = existing
                gui.ResetOnSpawn = false
                gui.Enabled = true
            end
        end

        if not fpsPingGui or not fpsPingGui.Parent then
            local existing = PG:FindFirstChild("CosmicFPSPing")
            if existing then
                fpsPingGui = existing
                fpsPingGui.ResetOnSpawn = false
            else
                pcall(createFPSPingGui)
            end
        end

        if not mwBtnGui or not mwBtnGui.Parent then
            local existing = PG:FindFirstChild("MW_BottomBtn")
            if existing then
                mwBtnGui = existing
                mwBtnGui.ResetOnSpawn = false
            end
        end

        if not killFeedGui or not killFeedGui.Parent then
            local existing = PG:FindFirstChild("CosmicKillFeed")
            if existing then
                killFeedGui = existing
                killFeedGui.ResetOnSpawn = false
            end
        end

        if not AimbotLaserGui or not AimbotLaserGui.Parent then
            local existing = PG:FindFirstChild("AimbotLaserESP")
            if existing then
                AimbotLaserGui = existing
                AimbotLaserGui.ResetOnSpawn = false
            end
        end
    end
end)

-- Respawn — Menu tetap ada
LP.CharacterAdded:Connect(function(char)
    task.wait(1)
    pcall(forceAllGuiResetOnSpawnFalse)
    print("[RESPAWN] Menu restored")
end)

-- Create FPS/Ping GUI
task.spawn(function()
    task.wait(3)
    pcall(createFPSPingGui)
end)

-- Hook killer baru pas spawn
Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function(char)
        task.wait(1)
        if AutoParry.Enabled then
            if p.Team and p.Team.Name == "Killer" then
                AP_HookKiller(char)
            end
        end
    end)
end)

-- Scan killers loop
task.spawn(function()
    while task.wait(1) do
        if AutoParry.Enabled then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LP and p.Character and p.Team and p.Team.Name == "Killer" then
                    AP_HookKiller(p.Character)
                end
            end
        end
    end
end)

-- Scan tombol senter loop
task.spawn(function()
    while task.wait(2) do
        if AimbotSenter.Enabled then
            pcall(HookSenterButtons)
        end
    end
end)

print("✅ [9/15] COSMIC - Keybind + Camera Fix + Anti-Ilang Menu")
print("⌨️ Keybind: V = Moonwalk | K = Unlock Camera")-- =========================================================
-- SECTION 10/15 : LOGIC FITUR BARU + FIX FOV BIND
-- =========================================================

-- AUTO WIGGLE LOOP
task.spawn(function()
    while task.wait(1) do
        if not AutoParry.Wiggle then continue end
        local char = LP.Character
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
        for i = 1, (AutoParry.WiggleSpam or 5) do
            pcall(function() event:FireServer() end)
        end
    end
end)

-- AUTO FLEE LOOP
task.spawn(function()
    while task.wait(0.2) do
        if not AutoFlee.Enabled then continue end
        local root = getRoot()
        if not root then continue end
        local killerRoot, distance = GetNearestKillerForFlee()
        if killerRoot and distance <= AutoFlee.DetectDistance
           and tick() - AutoFlee.LastFlee > AutoFlee.Cooldown then
            local point = nil
            local farthest = 0
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") and string.match(obj.Name, "^GeneratorPoint%d+$") then
                    local d = (obj.Position - killerRoot.Position).Magnitude
                    if d > farthest then
                        farthest = d
                        point = obj
                    end
                end
            end
            if point then
                AutoFlee.LastFlee = tick()
                pcall(function()
                    root.CFrame = point.CFrame + Vector3.new(0, 5, 0)
                end)
            end
        end
    end
end)

-- AUTO ESCAPE LOOP
task.spawn(function()
    while task.wait(3) do
        if not S.AutoEscapeGate then continue end
        local root = getRoot()
        if not root then continue end

        local killerNear = false
        if S.AutoEscapeUseKillerCheck then
            local kRoot, kDist = GetNearestKillerForFlee()
            if kRoot and kDist <= (S.AutoEscapeRange or 50) then
                killerNear = true
            end
        end

        local genDone = false
        if S.AutoEscapeUseGenCheck then
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

-- FAST VAULT HOOK
LP.CharacterAdded:Connect(function(char)
    task.wait(1)
    if FastVault.Enabled then
        pcall(function() hookVault(char) end)
    end
end)

if LP.Character then
    pcall(function() hookVault(LP.Character) end)
end

-- AUTO CARRY LOOP
task.spawn(function()
    while task.wait(0.2) do
        if not S.AutoCarry or KillerBusy then continue end

        local CarryEvent = ReplicatedStorage:FindFirstChild("Remotes", true)
            and ReplicatedStorage.Remotes:FindFirstChild("Carry", true)
            and ReplicatedStorage.Remotes.Carry:FindFirstChild("CarrySurvivorEvent")
        local HookEvent = ReplicatedStorage:FindFirstChild("Remotes", true)
            and ReplicatedStorage.Remotes:FindFirstChild("Carry", true)
            and ReplicatedStorage.Remotes.Carry:FindFirstChild("HookEvent")

        if not CarryEvent or not HookEvent then continue end

        local target = GetDownedSurvivor()
        local root = getRoot()

        if target and root then
            KillerBusy = true
            local tRoot = target:FindFirstChild("HumanoidRootPart")
            if tRoot then
                root.CFrame = tRoot.CFrame * CFrame.new(0, 3, -2)
                task.wait(0.4)
                for i = 1, 4 do
                    pcall(function() CarryEvent:FireServer(target) end)
                    task.wait(0.2)
                end
                task.wait(0.6)
                if S.AutoHook then
                    local hook = GetHookPoint()
                    if hook then
                        root.CFrame = hook.CFrame * CFrame.new(0, 4, -3)
                        task.wait(0.7)
                        for i = 1, 6 do
                            pcall(function() HookEvent:FireServer(hook) end)
                            task.wait(0.15)
                        end
                    end
                end
            end
            task.delay(2, function() KillerBusy = false end)
        end
    end
end)

-- FPS BOOST LOOP
task.spawn(function()
    while task.wait(1) do
        if S.NoScreenEffects then applyNoScreenEffects() end
        if S.LowGraphics then applyLowGraphics() end
        if S.CleanSky then applyCleanSky() end
    end
end)

-- SKY + FIRE AUTO-REAPPLY
task.spawn(function()
    while task.wait(8) do
        if S.SkyId and S.SkyId ~= "Default" then
            local currentSky = nil
            for _, v in pairs(Lighting:GetChildren()) do
                if v:IsA("Sky") then
                    currentSky = v
                    break
                end
            end
            if not currentSky or not currentSky.Name:find("CosmicSky_") then
                pcall(function() applySky(S.SkyId) end)
            end
        end
        if S.FireOn and LP.Character then
            local head = LP.Character:FindFirstChild("Head")
            if head and not head:FindFirstChild("RoooorFire") then
                pcall(applyFire)
            end
        end
    end
end)

-- FIX FOV BIND
task.spawn(function()
    RunService.RenderStepped:Connect(function()
        if S.FOVEnabled then
            local cam = workspace.CurrentCamera
            if cam and math.abs(cam.FieldOfView - S.FOV) > 0.5 then
                pcall(function()
                    cam.FieldOfView = S.FOV
                end)
            end
        end
    end)
end)

-- HITBOX LOOP
task.spawn(function()
    while task.wait(0.3) do
        if not Hitbox.Enabled then
            hitboxClearAll()
            continue
        end

        local myRoot = getRoot()
        if not myRoot then continue end
        local myTeam = LP.Team and LP.Team.Name or ""

        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character then
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
                        if not HitboxTextOriginalSizes[hrp] then
                            HitboxTextOriginalSizes[hrp] = hrp.Size
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

print("✅ [10/15] COSMIC - Logic Fitur Baru Loaded")-- =========================================================
-- SECTION 11/15 : PRINT FINAL
-- =========================================================
task.wait(0.5)

print("╔══════════════════════════════════════════╗")
print("║  COSMIC HUB                              ║")
print("║  SEMUA FITUR LOADED                      ║")
print("╠══════════════════════════════════════════╣")
print("║  ⚙️ SEMUA FITUR DEFAULT OFF              ║")
print("╠══════════════════════════════════════════╣")
print("║  AUTO PARRY V5 (Tab Survivor)            ║")
print("║     -> Hybrid + Predictive + Double Tap  ║")
print("║     -> Filter Killer Lengkap             ║")
print("╠══════════════════════════════════════════╣")
print("║  AIMBOT SENTER (Tab Survivor)            ║")
print("║     -> PENCET tombol = LOCK              ║")
print("║     -> LEPAS tombol = BEBAS              ║")
print("║     -> GAK PENCET = GAK LOCK             ║")
print("╠══════════════════════════════════════════╣")
print("║  AUTO SKILL CHECK                        ║")
print("║     -> Perfect: Fallens Style            ║")
print("║     -> Instant: Paksa sukses             ║")
print("╠══════════════════════════════════════════╣")
print("║  FITUR LAIN:                             ║")
print("║     -> Moonwalk (Tombol MW + V)          ║")
print("║     -> Fast Vault                        ║")
print("║     -> Auto Wiggle                       ║")
print("║     -> Auto Flee Killer                  ║")
print("║     -> Auto Escape Gate                  ║")
print("║     -> Auto Carry + Hook                 ║")
print("║     -> Killer Auto Attack                ║")
print("║     -> Masked Power (5 mode)             ║")
print("║     -> Hitbox (TEXT ANGKA)               ║")
print("║     -> God Mode                          ║")
print("║     -> 8-Bit Royal Crown                 ║")
print("║     -> Korblox Pencil (902942096)        ║")
print("║     -> Headless FULL                     ║")
print("║     -> HD Sky (Jernih)                   ║")
print("║     -> HD Texture/Bloom/Shadow/dll       ║")
print("║     -> Sky 18 PRESET                     ║")
print("║     -> ESP (Survivor/Killer/Gen)         ║")
print("║     -> ESP Pallet / Window / SCP         ║")
print("║     -> Status ESP (Name/Dist/HP)         ║")
print("║     -> Galaxy Name (Animated)            ║")
print("║     -> Crosshair 8 Mode                  ║")
print("║     -> Fire Trail + Aura                 ║")
print("║     -> Kill Effect                       ║")
print("║     -> Fullbright + No Fog               ║")
print("║     -> Contrast + Saturation             ║")
print("║     -> Zoom Out Camera                   ║")
print("║     -> Walk Speed + Speed Hack           ║")
print("║     -> No Clip + No Clip Camera          ║")
print("║     -> FOV 70/90/120                     ║")
print("║     -> Fire 60 EFEK                      ║")
print("║     -> Anti-AFK + Rejoin                 ║")
print("║     -> FPS + Ping Counter                ║")
print("║     -> Kill Feed                         ║")
print("║     -> Stun Notify                       ║")
print("║     -> Instant Interact                  ║")
print("║     -> TP ke Finish Line                 ║")
print("╠══════════════════════════════════════════╣")
print("║  CAMERA FIX (ANTI-LOCK)                  ║")
print("║     -> Auto unlock setelah parry         ║")
print("║     -> Force camera tiap 0.05s           ║")
print("║     -> Skip kalau Aimbot Senter HOLD     ║")
print("╠══════════════════════════════════════════╣")
print("║  ANTI-ILANG MENU                         ║")
print("║     -> ResetOnSpawn = false              ║")
print("║     -> Recovery loop 0.2s                ║")
print("║     -> Menu TETEP ADA pas respawn        ║")
print("║     -> Menu TETEP ADA pas execute ulang  ║")
print("╠══════════════════════════════════════════╣")
print("║  KEYBIND:                                ║")
print("║     -> V = Moonwalk                      ║")
print("║     -> K = Unlock Camera                 ║")
print("╠══════════════════════════════════════════╣")
print("║  Buka menu: Klik tombol C                ║")
print("╚══════════════════════════════════════════╝")

print("✅ [11/15] COSMIC - FINAL LOADED!")
print("🎯 Klik tombol C untuk buka menu")-- =========================================================
-- SECTION 12/15 : AIMBOT TAB (KILLER AIMLOCK)
-- =========================================================

sec = _G.Roooor_sec
lbl = _G.Roooor_lbl
tog = _G.Roooor_tog
sl = _G.Roooor_sl
cpk = _G.Roooor_cpk
btn = _G.Roooor_btn
drp = _G.Roooor_drp
makeTab = _G.Roooor_makeTab
cs = _G.Roooor_cs

-- AIMBOT CORE
Aimlock_AttackButtons = Aimlock_AttackButtons or {}

local function isAttackButton(obj)
    if not obj:IsA("GuiObject") then return false end
    local n = string.lower(obj.Name)
    if n:find("attack") or n:find("slash") or n:find("swing") or n:find("hit") then
        return true
    end
    return false
end

function Aimlock_ScanAttackButtons()
    table.clear(Aimlock_AttackButtons)
    for _, obj in pairs(PG:GetDescendants()) do
        if isAttackButton(obj) and obj.Visible then
            table.insert(Aimlock_AttackButtons, obj)
        end
    end
    print("[AIMBOT] Found " .. #Aimlock_AttackButtons .. " attack button(s)")
end

function Aimlock_HookAttackButtons()
    Aimlock_ScanAttackButtons()
    for _, btnObj in ipairs(Aimlock_AttackButtons) do
        if not btnObj:GetAttribute("AimlockHooked") then
            btnObj:SetAttribute("AimlockHooked", true)
            btnObj.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch
                   or input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Aimlock.Holding = true
                end
            end)
            btnObj.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch
                   or input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Aimlock.Holding = false
                end
            end)
        end
    end
end

task.spawn(function()
    while task.wait(5) do
        if Aimlock.Enabled then
            Aimlock_HookAttackButtons()
        end
    end
end)

function Aimlock_GetClosestSurvivor()
    local myRoot = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end
    local closest = nil
    local shortest = Aimlock.Radius
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local isTarget = false
            if p.Team and p.Team.Name == Aimlock.TargetTeam then
                isTarget = true
            end
            if isTarget then
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                local targetPart = p.Character:FindFirstChild(Aimlock.AimPart)
                local isDowned = false
                if hum then
                    isDowned = hum.Health <= 0
                        or hum.Health < 2
                        or p.Character:GetAttribute("Downed") == true
                        or p.Character:GetAttribute("IsDown") == true
                        or p.Character:GetAttribute("Knocked") == true
                        or hum:GetState() == Enum.HumanoidStateType.Dead
                        or hum:GetState() == Enum.HumanoidStateType.Physics
                end
                if not isDowned and hum and hum.Health > 0 and targetPart then
                    local dist = (targetPart.Position - myRoot.Position).Magnitude
                    if dist < shortest then
                        shortest = dist
                        closest = targetPart
                    end
                end
            end
        end
    end
    return closest
end

Aimlock_CameraConn = nil

function Aimlock_StartLoop()
    if Aimlock_CameraConn then return end
    Aimlock_CameraConn = RunService.RenderStepped:Connect(function()
        if not Aimlock.Enabled then return end
        if not Aimlock.Holding then return end
        local cam = workspace.CurrentCamera
        if not cam then return end
        local target = Aimlock_GetClosestSurvivor()
        if not target then return end
        Aimlock.CurrentTarget = target
        local camPos = cam.CFrame.Position
        local targetPos = target.Position
        cam.CFrame = CFrame.new(camPos, targetPos)
    end)
end

function Aimlock_StopLoop()
    if Aimlock_CameraConn then
        Aimlock_CameraConn:Disconnect()
        Aimlock_CameraConn = nil
    end
    Aimlock.CurrentTarget = nil
    local cam = workspace.CurrentCamera
    local char = LP.Character
    if cam and char then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            pcall(function()
                cam.CameraType = Enum.CameraType.Custom
                cam.CameraSubject = hum
            end)
        end
    end
end

-- FLOATING GUI
Aimlock_Gui = nil
Aimlock_FloatingBtn = nil
Aimlock_FloatingPanel = nil

function Aimlock_CreateFloatingGUI()
    if Aimlock_Gui then Aimlock_Gui:Destroy() end
    Aimlock_Gui = Instance.new("ScreenGui")
    Aimlock_Gui.Name = "AimlockFloatingGUI"
    Aimlock_Gui.ResetOnSpawn = false
    Aimlock_Gui.IgnoreGuiInset = true
    Aimlock_Gui.Parent = PG

    Aimlock_FloatingBtn = Instance.new("TextButton")
    Aimlock_FloatingBtn.Size = UDim2.new(0, 45, 0, 45)
    Aimlock_FloatingBtn.Position = UDim2.new(0, 20, 0, 90)
    Aimlock_FloatingBtn.BackgroundColor3 = Color3.fromRGB(120, 20, 40)
    Aimlock_FloatingBtn.Text = "A"
    Aimlock_FloatingBtn.TextSize = 20
    Aimlock_FloatingBtn.Font = Enum.Font.GothamBlack
    Aimlock_FloatingBtn.TextColor3 = Color3.new(1, 1, 1)
    Aimlock_FloatingBtn.BorderSizePixel = 0
    Aimlock_FloatingBtn.AutoButtonColor = false
    Aimlock_FloatingBtn.Draggable = true
    Aimlock_FloatingBtn.Active = true
    Aimlock_FloatingBtn.Parent = Aimlock_Gui

    local corner1 = Instance.new("UICorner")
    corner1.CornerRadius = UDim.new(1, 0)
    corner1.Parent = Aimlock_FloatingBtn

    local stroke1 = Instance.new("UIStroke")
    stroke1.Thickness = 2
    stroke1.Color = Color3.fromRGB(255, 100, 120)
    stroke1.Parent = Aimlock_FloatingBtn

    Aimlock_FloatingPanel = Instance.new("Frame")
    Aimlock_FloatingPanel.Size = UDim2.new(0, 240, 0, 140)
    Aimlock_FloatingPanel.Position = UDim2.new(0.5, -120, 0.5, -70)
    Aimlock_FloatingPanel.BackgroundColor3 = Color3.fromRGB(15, 8, 20)
    Aimlock_FloatingPanel.BackgroundTransparency = 0.05
    Aimlock_FloatingPanel.BorderSizePixel = 0
    Aimlock_FloatingPanel.Visible = false
    Aimlock_FloatingPanel.Parent = Aimlock_Gui

    local corner2 = Instance.new("UICorner")
    corner2.CornerRadius = UDim.new(0, 14)
    corner2.Parent = Aimlock_FloatingPanel

    local stroke2 = Instance.new("UIStroke")
    stroke2.Thickness = 2
    stroke2.Color = Color3.fromRGB(255, 100, 120)
    stroke2.Parent = Aimlock_FloatingPanel

    local hdr = Instance.new("Frame")
    hdr.Size = UDim2.new(1, 0, 0, 28)
    hdr.BackgroundColor3 = Color3.fromRGB(60, 15, 25)
    hdr.BorderSizePixel = 0
    hdr.Parent = Aimlock_FloatingPanel

    local hdrCorner = Instance.new("UICorner")
    hdrCorner.CornerRadius = UDim.new(0, 14)
    hdrCorner.Parent = hdr

    local hdrPatch = Instance.new("Frame")
    hdrPatch.Size = UDim2.new(1, 0, 0, 14)
    hdrPatch.Position = UDim2.new(0, 0, 1, -14)
    hdrPatch.BackgroundColor3 = Color3.fromRGB(60, 15, 25)
    hdrPatch.BorderSizePixel = 0
    hdrPatch.Parent = hdr

    local ttl = Instance.new("TextLabel")
    ttl.Size = UDim2.new(1, -40, 1, 0)
    ttl.Position = UDim2.new(0, 10, 0, 0)
    ttl.BackgroundTransparency = 1
    ttl.Text = "AIMBOT"
    ttl.TextColor3 = Color3.fromRGB(255, 180, 190)
    ttl.TextSize = 11
    ttl.Font = Enum.Font.GothamBlack
    ttl.TextXAlignment = Enum.TextXAlignment.Left
    ttl.Parent = hdr

    local clsBtn = Instance.new("TextButton")
    clsBtn.Size = UDim2.new(0, 20, 0, 20)
    clsBtn.Position = UDim2.new(1, -26, 0.5, -10)
    clsBtn.BackgroundColor3 = Color3.fromRGB(80, 20, 40)
    clsBtn.Text = "X"
    clsBtn.TextColor3 = Color3.fromRGB(255, 100, 120)
    clsBtn.TextSize = 10
    clsBtn.Font = Enum.Font.GothamBlack
    clsBtn.BorderSizePixel = 0
    clsBtn.Parent = hdr

    local clsCorner = Instance.new("UICorner")
    clsCorner.CornerRadius = UDim.new(0, 5)
    clsCorner.Parent = clsBtn

    local radLbl = Instance.new("TextLabel")
    radLbl.Name = "RadiusLabel"
    radLbl.Size = UDim2.new(1, -20, 0, 14)
    radLbl.Position = UDim2.new(0, 10, 0, 60)
    radLbl.BackgroundTransparency = 1
    radLbl.Text = string.format("Radius: %.0f studs", Aimlock.Radius)
    radLbl.TextColor3 = Color3.fromRGB(220, 200, 200)
    radLbl.TextSize = 9
    radLbl.Font = Enum.Font.GothamMedium
    radLbl.TextXAlignment = Enum.TextXAlignment.Left
    radLbl.Parent = Aimlock_FloatingPanel

    Aimlock_FloatingBtn.MouseButton1Click:Connect(function()
        Aimlock_FloatingPanel.Visible = not Aimlock_FloatingPanel.Visible
    end)

    clsBtn.MouseButton1Click:Connect(function()
        Aimlock_FloatingPanel.Visible = false
    end)
end

function Aimlock_RemoveFloatingGUI()
    if Aimlock_Gui then
        Aimlock_Gui:Destroy()
        Aimlock_Gui = nil
        Aimlock_FloatingBtn = nil
        Aimlock_FloatingPanel = nil
    end
end

-- TAB AIMBOT (TAB 6)
makeTab("Aimbot", "🎯", 6, function()
    sec("Aimbot Control", "🎯")
    tog("Enable Aimbot", false, function(s)
        Aimlock.Enabled = s
        if s then
            Aimlock_HookAttackButtons()
            Aimlock_StartLoop()
        else
            Aimlock.Holding = false
            Aimlock_StopLoop()
        end
    end)
    lbl("Hold ATTACK = kamera lock ke survivor", C.FIRE_BRIGHT)

    sec("Show Floating GUI", "👁️")
    tog("Show Aimbot GUI", false, function(s)
        if s then
            Aimlock_CreateFloatingGUI()
        else
            Aimlock_RemoveFloatingGUI()
        end
    end)

    sec("Radius Setting", "📏")
    sl("Aimbot Radius", 5, 100, 80, function(v)
        Aimlock.Radius = v
        if Aimlock_FloatingPanel then
            local radLbl = Aimlock_FloatingPanel:FindFirstChild("RadiusLabel")
            if radLbl then
                radLbl.Text = string.format("Radius: %.0f studs", v)
            end
        end
    end)

    sec("Target", "🎯")
    drp("Aim Part", {"HumanoidRootPart", "Head", "UpperTorso"}, "HumanoidRootPart", function(v)
        Aimlock.AimPart = v
    end)
    lbl("Target: Survivor (buat Killer)", C.FIRE_BRIGHT)

    sec("Test", "🔧")
    btn("Scan Attack Buttons", function()
        Aimlock_ScanAttackButtons()
    end)
    btn("Manual Toggle Floating GUI", function()
        if Aimlock_Gui then Aimlock_RemoveFloatingGUI()
        else Aimlock_CreateFloatingGUI() end
    end)
end)

print("✅ [12/15] COSMIC - AIMBOT TAB Loaded")-- =========================================================
-- SECTION 13/15 : ANTI-ILANG MENU + AUTO RECOVERY
-- =========================================================

pcall(function()
    if gui then gui.ResetOnSpawn = false end
    if killFeedGui then killFeedGui.ResetOnSpawn = false end
    if mwBtnGui then mwBtnGui.ResetOnSpawn = false end
    if crosshairGui then crosshairGui.ResetOnSpawn = false end
    if fpsPingGui then fpsPingGui.ResetOnSpawn = false end
    if loadingGui then loadingGui.ResetOnSpawn = false end
    if Aimlock_Gui then Aimlock_Gui.ResetOnSpawn = false end
    if AimbotLaserGui then AimbotLaserGui.ResetOnSpawn = false end
end)

local function ForceResetOnSpawnFalse()
    for _, g in ipairs(PG:GetChildren()) do
        if g:IsA("ScreenGui") then
            pcall(function()
                g.ResetOnSpawn = false
                g.Enabled = true
            end)
        end
    end
end

task.spawn(function()
    while task.wait(0.2) do
        pcall(ForceResetOnSpawnFalse)
    end
end)

print("[ANTI-HILANG] Force ResetOnSpawn = false aktif")

local SCRIPT_URL = "https://raw.githubusercontent.com/tiarkenn-dev/Cosmishub/main/main.lua"

function RecreateAllGUI()
    if not gui or not gui.Parent then
        local existing = PG:FindFirstChild("CosmicHub")
        if existing then
            gui = existing
            gui.ResetOnSpawn = false
            gui.Enabled = true
            print("[RECOVERY] CosmicHub recovered")
        else
            warn("[RECOVERY] CosmicHub ilang, re-execute SC...")
            task.spawn(function()
                pcall(function()
                    loadstring(game:HttpGet(SCRIPT_URL))()
                end)
            end)
        end
    end

    if not fpsPingGui or not fpsPingGui.Parent then
        local existing = PG:FindFirstChild("CosmicFPSPing")
        if existing then
            fpsPingGui = existing
            fpsPingGui.ResetOnSpawn = false
        else
            pcall(createFPSPingGui)
        end
    end

    if not mwBtnGui or not mwBtnGui.Parent then
        local existing = PG:FindFirstChild("MW_BottomBtn")
        if existing then
            mwBtnGui = existing
            mwBtnGui.ResetOnSpawn = false
        end
    end

    if not killFeedGui or not killFeedGui.Parent then
        local existing = PG:FindFirstChild("CosmicKillFeed")
        if existing then
            killFeedGui = existing
            killFeedGui.ResetOnSpawn = false
        end
    end

    if crosshairGui and not crosshairGui.Parent then
        crosshairGui = nil
    end

    if Aimlock_Gui and not Aimlock_Gui.Parent then
        Aimlock_Gui = nil
    end

    if AimbotLaserGui and not AimbotLaserGui.Parent then
        AimbotLaserGui = nil
    end
end

task.spawn(function()
    while task.wait(0.5) do
        pcall(RecreateAllGUI)
    end
end)

LP.CharacterAdded:Connect(function(char)
    task.wait(1)
    print("[RESPAWN] Menu restored - fitur manual")
    task.wait(0.3)
    pcall(RecreateAllGUI)
    pcall(ForceResetOnSpawnFalse)
    print("[RESPAWN] Selesai!")
end)

local _lastPlaceId = game.PlaceId
task.spawn(function()
    while task.wait(2) do
        pcall(function()
            if game.PlaceId ~= _lastPlaceId then
                print("[PLACE-CHANGE] Pindah place!")
                print("  Old:", _lastPlaceId, "-> New:", game.PlaceId)
                _lastPlaceId = game.PlaceId
                task.wait(3)
                pcall(RecreateAllGUI)
                pcall(ForceResetOnSpawnFalse)
                print("[PLACE-CHANGE] Menu restored")
            end
        end)
    end
end)

print("")
print("═══════════════════════════════════════════")
print("  SECTION 13 - ANTI-ILANG MENU")
print("═══════════════════════════════════════════")
print("  ✅ ResetOnSpawn = false (semua GUI)")
print("  ✅ Force loop tiap 0.2 detik")
print("  ✅ Recovery loop tiap 0.5 detik")
print("  ✅ Auto re-execute kalo GUI ilang total")
print("  ✅ Menu restored pas respawn")
print("  ✅ Menu restored pas pindah place")
print("═══════════════════════════════════════════")
print("✅ [13/15] ANTI-ILANG MENU LOADED")
print("")
print("🎯 Klik tombol C untuk buka menu")
print("🛡️ Auto Parry: Tab Survivor")
print("🔦 Aimbot Senter: PENCET = LOCK | GAK PENCET = BEBAS")
print("🦴 Korblox: Tab Visual (Mesh 902942096 | Offset 0.80)")
print("👤 Headless: Tab Misc / Visual (FULL)")
print("")-- =========================================================
-- SECTION 14/15 : FINAL FIX (AUTO PARRY + CAMERA + MENU)
-- =========================================================

-- ============================================
-- 14.1 AUTO PARRY - TRIPLE LAYER DETECTION
-- ============================================
AP_v14_Count = 0
AP_v14_LastParry = 0
AP_v14_Config = {
    Debounce = 0.015,
    Radius = 25,
    MinVelocity = 6,
    SpamTap = 4,
}

function AP_v14_PressParry()
    for i = 1, 2 do
        VirtualInputManager:SendMouseButtonEvent(0, 0, 1, true, game, 0)
        task.wait(0.001)
        VirtualInputManager:SendMouseButtonEvent(0, 0, 1, false, game, 0)
        task.wait(0.001)
    end

    local parryBtn = AP_FindParryButton()
    if parryBtn and parryBtn:IsA("GuiObject") then
        local pos = parryBtn.AbsolutePosition
        local size = parryBtn.AbsoluteSize
        local inset = GuiService:GetGuiInset()
        local x = pos.X + size.X / 2 + inset.X
        local y = pos.Y + size.Y / 2 + inset.Y
        for i = 1, AP_v14_Config.SpamTap do
            VirtualInputManager:SendTouchEvent(9900 + i, 0, x, y)
            task.wait(0.001)
            VirtualInputManager:SendTouchEvent(9900 + i, 2, x, y)
            task.wait(0.001)
        end
    end

    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
    task.wait(0.001)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
end

function AP_v14_IsAttacking(killerChar, killerHum)
    local animator = killerHum:FindFirstChildOfClass("Animator")
    if animator then
        for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
            local a = track.Animation
            if a and a.AnimationId then
                local id = a.AnimationId:match("%d+")
                if SkipAnims and SkipAnims[id] then
                    return false
                end
                if KillerAnims["rbxassetid://" .. id] then
                    return true
                end
            end
        end
    end

    local root = killerChar:FindFirstChild("HumanoidRootPart")
    if root then
        if root.AssemblyLinearVelocity.Magnitude > AP_v14_Config.MinVelocity then
            return true
        end
    end

    if killerChar:GetAttribute("Attacking") == true then return true end
    if killerChar:GetAttribute("IsAttacking") == true then return true end

    return false
end

task.spawn(function()
    while task.wait(0.001) do
        if not AutoParry.Enabled then continue end

        local myRoot = getRoot()
        if not myRoot then continue end
        local myHum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
        if not myHum or myHum.Health <= 0 then continue end

        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Team and p.Team.Name == "Killer" then
                local kRoot = p.Character:FindFirstChild("HumanoidRootPart")
                local kHum = p.Character:FindFirstChildOfClass("Humanoid")

                if kRoot and kHum and kHum.Health > 0 then
                    local dist = (kRoot.Position - myRoot.Position).Magnitude
                    if dist <= AP_v14_Config.Radius then
                        if AP_v14_IsAttacking(p.Character, kHum) then
                            local now = tick()
                            if now - AP_v14_LastParry > AP_v14_Config.Debounce then
                                AP_v14_LastParry = now
                                AP_v14_PressParry()
                                AP_v14_Count = AP_v14_Count + 1
                            end
                        end
                    end
                end
            end
        end
    end
end)

print("✅ [14/15] Auto Parry - Triple Layer Loaded")

-- ============================================
-- 14.2 NO CAMERA LOCK - FORCE UNLOCK
-- ============================================
task.spawn(function()
    while task.wait(0.03) do
        local cam = workspace.CurrentCamera
        local char = LP.Character
        if not cam or not char then continue end

        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then continue end

        if AimbotSenter.Enabled and AimbotSenter.HoldingSenter then
            continue
        end

        pcall(function()
            if cam.CameraType ~= Enum.CameraType.Custom then
                cam.CameraType = Enum.CameraType.Custom
            end
            if cam.CameraSubject ~= hum then
                cam.CameraSubject = hum
            end
        end)
    end
end)

local function ForceUnlockV14()
    task.spawn(function()
        task.wait(0.05)
        local cam = workspace.CurrentCamera
        local char = LP.Character
        if cam and char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum and not (AimbotSenter.Enabled and AimbotSenter.HoldingSenter) then
                pcall(function()
                    cam.CameraType = Enum.CameraType.Custom
                    cam.CameraSubject = hum
                    cam.CameraMode = Enum.CameraMode.Classic
                end)
            end
        end
    end)
end

local function HookKillerUnlockV14(char)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    local animator = hum:FindFirstChildOfClass("Animator")
    if not animator then return end

    animator.AnimationPlayed:Connect(function(track)
        local a = track.Animation
        if not a or not a.AnimationId then return end
        local id = a.AnimationId:match("%d+")
        if id == "127096285501517" or id == "123047897844134" or id == "112166042383605" then
            ForceUnlockV14()
        end
    end)
end

for _, p in pairs(Players:GetPlayers()) do
    if p ~= LP and p.Character and p.Team and p.Team.Name == "Killer" then
        task.spawn(function() HookKillerUnlockV14(p.Character) end)
    end
    p.CharacterAdded:Connect(function(c)
        task.wait(1)
        if p.Team and p.Team.Name == "Killer" then
            HookKillerUnlockV14(c)
        end
    end)
end

LP.CharacterAdded:Connect(function(char)
    task.wait(1)
    local cam = workspace.CurrentCamera
    local hum = char:WaitForChild("Humanoid", 5)
    if cam and hum then
        pcall(function()
            cam.CameraType = Enum.CameraType.Custom
            cam.CameraSubject = hum
        end)
    end
end)

print("✅ [14/15] No Camera Lock Loaded")

-- ============================================
-- 14.3 MENU PERMANEN - FORCE RECREATE
-- ============================================
local function ForceGUIV14()
    for _, g in ipairs(PG:GetChildren()) do
        if g:IsA("ScreenGui") then
            pcall(function()
                g.ResetOnSpawn = false
                g.Enabled = true
            end)
        end
    end
end

task.spawn(function()
    while task.wait(0.15) do
        pcall(ForceGUIV14)

        if not gui or not gui.Parent then
            local existing = PG:FindFirstChild("CosmicHub")
            if existing then
                gui = existing
                gui.ResetOnSpawn = false
                gui.Enabled = true
            end
        end

        if not fpsPingGui or not fpsPingGui.Parent then
            local existing = PG:FindFirstChild("CosmicFPSPing")
            if existing then
                fpsPingGui = existing
                fpsPingGui.ResetOnSpawn = false
            else
                pcall(createFPSPingGui)
            end
        end

        if not mwBtnGui or not mwBtnGui.Parent then
            local existing = PG:FindFirstChild("MW_BottomBtn")
            if existing then
                mwBtnGui = existing
                mwBtnGui.ResetOnSpawn = false
            end
        end

        if not killFeedGui or not killFeedGui.Parent then
            local existing = PG:FindFirstChild("CosmicKillFeed")
            if existing then
                killFeedGui = existing
                killFeedGui.ResetOnSpawn = false
            end
        end

        if not AimbotLaserGui or not AimbotLaserGui.Parent then
            local existing = PG:FindFirstChild("AimbotLaserESP")
            if existing then
                AimbotLaserGui = existing
                AimbotLaserGui.ResetOnSpawn = false
            end
        end
    end
end)

LP.CharacterAdded:Connect(function(char)
    task.wait(0.3)
    pcall(ForceGUIV14)
end)

print("✅ [14/15] Menu Permanen Loaded")

print("")
print("═══════════════════════════════════════════")
print("  ✅ [14/15] SECTION 14 LOADED")
print("  🛡️ Auto Parry: TRIPLE LAYER")
print("  📷 No Camera Lock: FORCE UNLOCK")
print("  🖥️  Menu Permanen: FORCE RECREATE")
print("═══════════════════════════════════════════")
print("")-- =========================================================
-- SECTION 15/15 : AIMBOT SENTER FIX + AUTO-ON
-- =========================================================

-- ============================================
-- 15.1 AIMBOT SENTER (PENCET DAGGER = LOCK)
-- ============================================
AimbotSenter.HoldingSenter = false
AimbotSenter.CurrentTarget = nil
AimbotSenter._Hooked = {}

function ScanSenterButtonsV15()
    local buttons = {}
    for _, obj in pairs(PG:GetDescendants()) do
        if obj:IsA("GuiObject") and obj.Visible then
            local n = string.lower(obj.Name)
            if n:find("dagger") or n:find("flashlight") or n:find("senter")
               or n:find("light") or n:find("torch") or n:find("flash")
               or n:find("knife") or n:find("blade") then
                table.insert(buttons, obj)
            end
        end
    end
    return buttons
end

function HookSenterV15()
    local buttons = ScanSenterButtonsV15()
    print("[SENTER] Ketemu " .. #buttons .. " tombol")
    for _, obj in ipairs(buttons) do
        if AimbotSenter._Hooked[obj] then continue end
        AimbotSenter._Hooked[obj] = true
        print("[SENTER] Hook: " .. obj:GetFullName())

        obj.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
               or input.UserInputType == Enum.UserInputType.Touch then
                AimbotSenter.HoldingSenter = true
                print("[SENTER] HOLD = LOCK")
            end
        end)

        obj.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
               or input.UserInputType == Enum.UserInputType.Touch then
                AimbotSenter.HoldingSenter = false
                AimbotSenter.CurrentTarget = nil
                print("[SENTER] RELEASE = BEBAS")
            end
        end)

        obj.MouseLeave:Connect(function()
            AimbotSenter.HoldingSenter = false
            AimbotSenter.CurrentTarget = nil
        end)
    end
end

task.spawn(function()
    while task.wait(0.01) do
        if not AimbotSenter.Enabled then
            if AimbotLaserGui then
                for _, line in pairs(AimbotLaserLines) do
                    if line then line:Remove() end
                end
                AimbotLaserLines = {}
            end
            continue
        end

        if not AimbotSenter.HoldingSenter then
            AimbotSenter.CurrentTarget = nil
            if AimbotLaserGui then
                for _, line in pairs(AimbotLaserLines) do
                    if line then line:Remove() end
                end
                AimbotLaserLines = {}
            end
            continue
        end

        local myRoot = getRoot()
        if not myRoot then continue end

        local closest = nil
        local shortest = math.huge

        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LP and p.Character and p.Team and p.Team.Name == "Killer" then
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                local targetPart = p.Character:FindFirstChild(AimbotSenter.LockPart or "Head")
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
            if AimbotLaserGui then
                for _, line in pairs(AimbotLaserLines) do
                    if line then line:Remove() end
                end
                AimbotLaserLines = {}
            end
            continue
        end

        AimbotSenter.CurrentTarget = closest
        local cam = workspace.CurrentCamera
        if cam then
            local camPos = cam.CFrame.Position
            local targetPos = closest.Position
            local newCFrame = CFrame.new(camPos, targetPos)
            cam.CFrame = cam.CFrame:Lerp(newCFrame, AimbotSenter.Smoothness or 0.5)
        end

        if AimbotSenter.ShowLaser then
            local cam2 = workspace.CurrentCamera
            local screenPoint, onScreen = cam2:WorldToViewportPoint(closest.Position)
            if onScreen then
                if AimbotLaserGui then
                    for _, line in pairs(AimbotLaserLines) do
                        if line then line:Remove() end
                    end
                    AimbotLaserLines = {}
                end
                local centerX = cam2.ViewportSize.X / 2
                local centerY = cam2.ViewportSize.Y / 2
                local line = Drawing.new("Line")
                line.Visible = true
                line.From = Vector2.new(centerX, centerY)
                line.To = Vector2.new(screenPoint.X, screenPoint.Y)
                line.Color = AimbotSenter.LaserColor or Color3.fromRGB(255, 0, 0)
                line.Thickness = 2
                line.Transparency = 0.5
                table.insert(AimbotLaserLines, line)
            end
        end
    end
end)

task.spawn(function()
    while task.wait(2) do
        if AimbotSenter.Enabled then
            pcall(HookSenterV15)
        end
    end
end)

print("✅ [15/15] Aimbot Senter: PENCET = LOCK")

-- ============================================
-- 15.2 AUTO-ON FITUR PAS EXECUTE
-- ============================================
task.spawn(function()
    task.wait(3)

    ESP.Killer = true
    _G.ToggleStates["ESP Killer"] = true

    ESP.Generator = true
    _G.ToggleStates["ESP Generator"] = true

    ESP.Survivor = true
    _G.ToggleStates["ESP Survivor"] = true

    S.ESPGenMode = "Bar"
    _G.DropdownStates["Generator Mode"] = 2

    S.ESPGenBarSize = 64
    _G.SliderStates["Bar Width"] = 64

    S.ESPGenBarHeight = 8
    _G.SliderStates["Bar Height"] = 8

    S.ESPNameSize = 8
    _G.SliderStates["Name Size"] = 8

    S.ESPNameMode = "Galaxy"
    _G.DropdownStates["Name Mode"] = 2

    S.Korblox = true
    _G.ToggleStates["Enable Korblox"] = true
    task.wait(0.3)
    pcall(function() applyKorblox(true, "Pencil", 0.80, 1) end)

    S.Headless = true
    _G.ToggleStates["Headless"] = true
    task.wait(0.3)
    pcall(function() applyHeadless(true) end)

    print("[AUTO-ON] ✅ Selesai!")
    print("[AUTO-ON] - ESP Killer: ON")
    print("[AUTO-ON] - ESP Generator: ON (Bar Mode)")
    print("[AUTO-ON] - ESP Survivor: ON")
    print("[AUTO-ON] - Bar Width: 64 | Bar Height: 8")
    print("[AUTO-ON] - Name Size: 8")
    print("[AUTO-ON] - Name Mode: Galaxy")
    print("[AUTO-ON] - Korblox: ON")
    print("[AUTO-ON] - Headless: ON")
end)

print("✅ [15/15] Auto-ON Fitur Loaded")

print("")
print("═══════════════════════════════════════════")
print("  ✅ [15/15] SECTION 15 LOADED")
print("  🔦 Aimbot Senter: PENCET = LOCK")
print("  ⚡ Auto-ON: ESP + Korblox + Headless")
print("═══════════════════════════════════════════")
print("")
