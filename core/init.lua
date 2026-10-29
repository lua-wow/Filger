local addon, ns = ...

local frame = CreateFrame("Frame", "Filger", UIParent)

-- blizzard
local GetAddOnMetadata = C_AddOns and C_AddOns.GetAddOnMetadata or _G.GetAddOnMetadata

local _, physicalScreenHeight = GetPhysicalScreenSize()

-- System
ns.pixelPerfectScale = math.min(1, math.max(0.3, 768 / physicalScreenHeight))

-- addon
frame.title = GetAddOnMetadata(addon, "Title")
frame.version = GetAddOnMetadata(addon, "Version")

-- interface
-- reference: https://warcraft.wiki.gg/wiki/WOW_PROJECT_ID
local client = {}
client.isStandard = (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE)
client.isVanilla = (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC)
client.isTBC = (WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC)
client.isWrath = (WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC)
client.isCata = (WOW_PROJECT_ID == WOW_PROJECT_CATACLYSM_CLASSIC)
client.isMists = (WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC)
client.isCamelot = (WOW_PROJECT_ID == WOW_PROJECT_CAMELOT)

-- game type families, as in TOC [AllowLoadGameType mainline/classic]
client.isClassic = (client.isVanilla or client.isTBC or client.isWrath or client.isCata or client.isMists)
client.isMainline = not client.isClassic

client.interface = select(4, GetBuildInfo())

-- expansion levels for gating shared data
-- reference: https://warcraft.wiki.gg/wiki/LE_EXPANSION
local expansions = {
    Classic = LE_EXPANSION_CLASSIC,
    BurningCrusade = LE_EXPANSION_BURNING_CRUSADE,
    Wrath = LE_EXPANSION_WRATH_OF_THE_LICH_KING,
    Cataclysm = LE_EXPANSION_CATACLYSM,
    Mists = LE_EXPANSION_MISTS_OF_PANDARIA,
    Warlords = LE_EXPANSION_WARLORDS_OF_DRAENOR,
    Legion = LE_EXPANSION_LEGION,
    BattleForAzeroth = LE_EXPANSION_BATTLE_FOR_AZEROTH,
    Shadowlands = LE_EXPANSION_SHADOWLANDS,
    Dragonflight = LE_EXPANSION_DRAGONFLIGHT,
    WarWithin = LE_EXPANSION_WAR_WITHIN,
    Midnight = LE_EXPANSION_MIDNIGHT,
}

client.expansion = LE_EXPANSION_LEVEL_CURRENT

ns.client = client
ns.expansions = expansions

-- player
ns.player = {
    class = select(2, UnitClass("player"))
}

-- tracker type protos, by config `type`; each has Enable(data)
ns.elements = {}

ns.Filger = frame
