local addon, ns = ...

local frame = CreateFrame("Frame", "Filger", UIParent)

-- global
_G[addon] = frame

-- blizzard
local GetAddOnMetadata = C_AddOns and C_AddOns.GetAddOnMetadata or _G.GetAddOnMetadata

local windowed = Display_DisplayModeDropDown and Display_DisplayModeDropDown:windowedmode() or false
local fullscreen = Display_DisplayModeDropDown and Display_DisplayModeDropDown:fullscreenmode() or false
local physicalScreenWidth, physicalScreenHeight = GetPhysicalScreenSize()

-- System
frame.windowed = windowed
frame.fullscreen = fullscreen
frame.screenWidth = physicalScreenWidth
frame.screenHeight = physicalScreenHeight
frame.pixelPerfectScale = math.min(1, math.max(0.3, 768 / physicalScreenHeight))

-- addon
frame.title = GetAddOnMetadata(addon, "Title")
frame.version = GetAddOnMetadata(addon, "Version")
frame.description = GetAddOnMetadata(addon, "Notes")
frame.WelcomeMessage = ("|cffff8000Filger %s|r - /filger help"):format(frame.version)

-- interface
-- https://wowpedia.fandom.com/wiki/WOW_PROJECT_ID
local interface = select(4, GetBuildInfo())
frame.interface = interface
frame.isRetail = (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE)
frame.isClassic = (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC)
frame.isBCC = (WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC)
frame.isWrath = (WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC)
frame.isCata = (WOW_PROJECT_ID == WOW_PROJECT_CATACLYSM_CLASSIC)

-- player
frame.name = UnitName("player")
frame.class = select(2, UnitClass("player"))

if (frame.isClassic) then
	local LibStub = _G.LibStub
	local LibClassicDurations = LibStub("LibClassicDurations", true)
	if (LibClassicDurations) then
		LibClassicDurations:Register(addon)
		frame.LibClassicDurations = LibClassicDurations
	end
end

ns.Filger = frame
