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
ns.Filger.WelcomeMessage = string.format("|cffb3ff19Filger %s|r - /filger help", ns.Filger.VersionNumber)

-- Character
ns.Filger.MyName = UnitName("player")
ns.Filger.MyClass = select(2, UnitClass("player"))
ns.Filger.MyLevel = UnitLevel("player")
ns.Filger.MyFaction = select(2, UnitFactionGroup("player"))
ns.Filger.MyRace = select(2, UnitRace("player"))
ns.Filger.MyRealm = GetRealmName()