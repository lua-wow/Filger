local addon, ns = ...

local frame = CreateFrame("Frame", "Filger", UIParent)

-- global
_G[addon] = frame

-- blizzard
local GetAddOnMetadata = C_AddOns and C_AddOns.GetAddOnMetadata or _G.GetAddOnMetadata

local _, physicalScreenHeight = GetPhysicalScreenSize()

-- System
frame.pixelPerfectScale = math.min(1, math.max(0.3, 768 / physicalScreenHeight))

-- addon
frame.title = GetAddOnMetadata(addon, "Title")
frame.version = GetAddOnMetadata(addon, "Version")

-- interface
-- reference: https://warcraft.wiki.gg/wiki/WOW_PROJECT_ID
frame.isStandard = (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE)
frame.isVanilla = (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC)
frame.isTBC = (WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC)
frame.isWrath = (WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC)
frame.isCata = (WOW_PROJECT_ID == WOW_PROJECT_CATACLYSM_CLASSIC)
frame.isMists = (WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC)
frame.isCamelot = (WOW_PROJECT_ID == WOW_PROJECT_CAMELOT)

-- game type families, as in TOC [AllowLoadGameType mainline/classic]
frame.isClassic = (frame.isVanilla or frame.isTBC or frame.isWrath or frame.isCata or frame.isMists)
frame.isMainline = not frame.isClassic

-- player
frame.name = UnitName("player")
frame.class = select(2, UnitClass("player"))

ns.Filger = frame
