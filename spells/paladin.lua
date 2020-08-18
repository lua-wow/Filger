local _, ns = ...
local Filger = ns.Filger
local Config = ns.Config
local SpellList = ns.SpellList

----------------------------------------------------------------
-- Paladin
----------------------------------------------------------------
SpellList["PALADIN"] = {
    {
        name = "PLAYER_AURAS",
        anchor = Config["Panels"].PlayerAuras,
        direction = "LEFT",
        mode = "ICON",
        num = 7,
        size = Config["General"].IconSize,
        spacing = Config["General"].IconSpacing,
        unit = "player",
        filter = "HELPFUL",

        -- All Specs
        { spellID = 498   , caster = "player", filter = "BUFF" },   -- Divine Protection
        { spellID = 642   , caster = "player", filter = "BUFF" },   -- Divine Shield
        { spellID = 221885, caster = "player", filter = "BUFF" },   -- Divine Steed

            -- Debuffs
            { spellID = 25771 , caster = "player", filter = "DEBUFF" }, -- Forbearance

        -- Holy
        { spellID = 31821 , caster = "player", filter = "BUFF" },   -- Aura Mastery
        { spellID = 31884 , caster = "player", filter = "BUFF" },   -- Avenging Wrath
        { spellID = 105809, caster = "player", filter = "BUFF" },   -- Holy Avenger
        { spellID = 214202, caster = "player", filter = "BUFF" },   -- Rule of Law
        { spellID = 216331, caster = "player", filter = "BUFF" },   -- Avenging Crusader
        { spellID = 294027, caster = "player", filter = "BUFF" },   -- Avenging Wrath (Holy Shock Critical)
            
            -- Procs
            { spellID = 54149 , caster = "player", filter = "BUFF" },   -- Infusion of Light
            { spellID = 216411, caster = "player", filter = "BUFF" },   -- Divine Purpose

        -- Protection
        { spellID = 31850 , caster = "player", filter = "BUFF" },   -- Ardent Defender
        { spellID = 86659 , caster = "player", filter = "BUFF" },   -- Guardian of Ancient Kings
        { spellID = 152262, caster = "player", filter = "BUFF" },   -- Seraphim
        { spellID = 204150, caster = "player", filter = "BUFF" },   -- Aegis of Light
        { spellID = 204335, caster = "player", filter = "BUFF" },   -- Aegis of Light

            -- Procs
            { spellID = 197561, caster = "player", filter = "BUFF" },   -- Avenger's Valor

        -- Retribution
        { spellID = 84963 , caster = "player", filter = "BUFF" },   -- Inquisition
        { spellID = 184662, caster = "player", filter = "BUFF" },   -- Shield of Vengeance
        { spellID = 205191, caster = "player", filter = "BUFF" },   -- Eye for an Eye
        { spellID = 231895, caster = "player", filter = "BUFF" },   -- Crusader
        { spellID = 271581, caster = "player", filter = "BUFF" },   -- Divine Judgment

            -- Procs
            { spellID = 114250, caster = "player", filter = "BUFF" },   -- Selfless Healer
            { spellID = 223819, caster = "player", filter = "BUFF" },   -- Divine Purpose
            { spellID = 267611, caster = "player", filter = "BUFF" },   -- Righteous Verdict
            { spellID = 269571, caster = "player", filter = "BUFF" },   -- Zeal
            { spellID = 281178, caster = "player", filter = "BUFF" },   -- Blade of Wrath
    }, -- [1]
    --[[
    {
        name = "PLAYER_COOLDOWNS",
        anchor = Config["Panels"].PlayerCooldowns,
        direction = "DOWN",
        mode = "BAR",
        num = 3,
        size = Config["General"].BarHeight,
        width = Config["General"].BarWidth,
        spacing = Config["General"].BarSpacing,
        unit = "player",
        filter = "COOLDOWN",
        
        -- All Specs
        { spellID = 498   , caster = "player", filter = "CD" },     -- Divine Protection
        { spellID = 633   , caster = "player", filter = "CD" },     -- Lay on Hands
        { spellID = 642   , caster = "player", filter = "CD" },     -- Divine Shield

        -- Holy
        { spellID = 31821 , caster = "player", filter = "CD" },     -- Aura Mastery
        { spellID = 114158, caster = "player", filter = "CD" },     -- Light's Hammer
        { spellID = 216331, caster = "player", filter = "CD" },     -- Avenging Crusader
        
        -- Protection
        { spellID = 31850 , caster = "player", filter = "CD" },   -- Ardent Defender
        { spellID = 86659 , caster = "player", filter = "CD" },   -- Guardian of Ancient Kings
        { spellID = 204150, caster = "player", filter = "CD" },   -- Aegis of Light
    }, -- [2]
    --]]
    {
        name = "TARGET_AURAS",
        anchor = Config["Panels"].TargetAuras,
        direction = "RIGHT",
        mode = "ICON",
        num = 7,
        size = Config["General"].IconSize,
        spacing = Config["General"].IconSpacing,
        unit = "target",
        filter = "HELPFUL",

        ----------------------------------------------------------------
        -- Buffs
        ----------------------------------------------------------------
        { spellID = 1022  , caster = "player", filter = "BUFF" },   -- Blessing of Protection
        { spellID = 1044  , caster = "player", filter = "BUFF" },   -- Blessing of Freedom
        { spellID = 6940  , caster = "player", filter = "BUFF" },   -- Blessing of Sacrifice
        { spellID = 204018, caster = "player", filter = "BUFF" },   -- Blessing of Spellwarding

        -- Holy
        { spellID = 53563 , caster = "player", filter = "BUFF" },   -- Beacon of Light
        { spellID = 200025, caster = "player", filter = "BUFF" },   -- Beacon of Virtue
        { spellID = 210372, caster = "player", filter = "BUFF" },   -- Beacon of Faith

        ----------------------------------------------------------------
        -- Debuffs
        ----------------------------------------------------------------
        { spellID = 853   , caster = "player", filter = "DEBUFF" },   -- Hammer of Justice
        { spellID = 62124 , caster = "player", filter = "DEBUFF" },   -- Hand of Reckoning
        
        -- Holy
        { spellID = 196941, caster = "player", filter = "DEBUFF" },   -- Judgment of Light
        { spellID = 214222, caster = "player", filter = "DEBUFF" },   -- Judgment

        -- Protection
        { spellID = 105421, caster = "player", filter = "DEBUFF" },   -- Bliding Light
        { spellID = 204242, caster = "player", filter = "DEBUFF" },   -- Consecration
        { spellID = 204301, caster = "player", filter = "DEBUFF" },   -- Blessed Hammer

        -- Retribution
        { spellID = 183218, caster = "player", filter = "DEBUFF" },   -- Hand of Hindrance
        { spellID = 197277, caster = "player", filter = "DEBUFF" },   -- Judgment
        { spellID = 255937, caster = "player", filter = "DEBUFF" },   -- Wake of Ashes
        { spellID = 267799, caster = "player", filter = "DEBUFF" },   -- Execution Sentence
    }, -- [3]
}
