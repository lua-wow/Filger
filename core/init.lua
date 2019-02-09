local addon, ns = ...
ns.Filger = CreateFrame("Frame", "Filger", UIParent)
ns.Config = {}
ns.SpellList = {}
ns.Instances = {}

-- Addon
ns.Filger.Title = GetAddOnMetadata(addon, 'Title')
ns.Filger.Version = GetAddOnMetadata(addon, 'Version')
ns.Filger.VersionNumber = tonumber(ns.Filger.Version)
ns.Filger.Description = GetAddOnMetadata(addon, 'Notes')
ns.Filger.WelcomeMessage = string.format("|cff00ff96Filger %s|r - /filger help", ns.Filger.Version)

-- Character
ns.Filger.MyName = UnitName("player")
ns.Filger.MyClass = select(2, UnitClass("player"))
ns.Filger.MyLevel = UnitLevel("player")
ns.Filger.MyFaction = select(2, UnitFactionGroup("player"))
ns.Filger.MyRace = select(2, UnitRace("player"))
ns.Filger.MyRealm = GetRealmName()

-- Game
ns.Filger.WoWPatch, ns.Filger.WoWBuild, ns.Filger.WoWPatchReleaseDate, ns.Filger.TocVersion = GetBuildInfo()
ns.Filger.WoWBuild = tonumber(ns.Filger.WoWBuild)

-- System
local Resolution = GetCurrentResolution() > 0 and select(GetCurrentResolution(), GetScreenResolutions()) or nil
local Windowed = Display_DisplayModeDropDown:windowedmode()
local Fullscreen = Display_DisplayModeDropDown:fullscreenmode()
ns.Filger.WindowedMode = Windowed
ns.Filger.FullscreenMode = Fullscreen
ns.Filger.Resolution = Resolution or (Windowed and GetCVar("gxWindowedResolution")) or GetCVar("gxFullscreenResolution")
ns.Filger.ScreenHeight = tonumber(string.match(ns.Filger.Resolution, "%d+x(%d+)"))
ns.Filger.ScreenWidth = tonumber(string.match(ns.Filger.Resolution, "(%d+)x+%d"))
ns.Filger.UIScale = 768 / ns.Filger.ScreenHeight
ns.Filger.Multiplier = 1 / ns.Filger.UIScale