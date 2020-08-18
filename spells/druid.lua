local _, ns = ...
local Filger = ns.Filger
local Config = ns.Config
local SpellList = ns.SpellList

----------------------------------------------------------------
-- Druid
----------------------------------------------------------------
SpellList["DRUID"] = {
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

        -- All Spec
        { spellID = 22812 , caster = "player", filter = "BUFF" },   -- Barkskin
        { spellID = 252216, caster = "player", filter = "BUFF" },   -- Tiger Dash
        
        -- Balance
        { spellID = 29166 , caster = "player", filter = "BUFF" },   -- Innervate
        { spellID = 194223, caster = "player", filter = "BUFF" },   -- Celestial Alignment
        { spellID = 202425, caster = "player", filter = "BUFF" },   -- Warrior of Elune
        
            -- Procs
            { spellID = 164545, caster = "player", filter = "BUFF" },   -- Solar Empowerment
            { spellID = 164547, caster = "player", filter = "BUFF" },   -- Lunar Empowerment
            { spellID = 102560, caster = "player", filter = "BUFF" },   -- Incarnation: Chosen of Elune
            { spellID = 279709, caster = "player", filter = "BUFF" },   -- Starlord

        -- Feral
        { spellID = 1850  , caster = "player", filter = "BUFF" },   -- Dash
        { spellID = 5215  , caster = "player", filter = "BUFF" },   -- Prowl
        { spellID = 5217  , caster = "player", filter = "BUFF" },   -- Tiger's Fury
        { spellID = 52610 , caster = "player", filter = "BUFF" },   -- Savage Roar
        { spellID = 61336 , caster = "player", filter = "BUFF" },   -- Survival Instincts
        { spellID = 106951, caster = "player", filter = "BUFF" },   -- Berserk
            
        -- Procs
            { spellID = 69369 , caster = "player", filter = "BUFF" },   -- Predatory Swiftness    
            { spellID = 102543, caster = "player", filter = "BUFF" },   -- Incarnation: King of the Jungle
            { spellID = 135700, caster = "player", filter = "BUFF" },   -- Clearcasting
            { spellID = 145152, caster = "player", filter = "BUFF" },   -- Bloodtalons

        -- Guardian
        { spellID = 22842 , caster = "player", filter = "BUFF" },   -- Frenzied Regeneration
        { spellID = 158792, caster = "player", filter = "BUFF" },   -- Pulverize
        { spellID = 192081, caster = "player", filter = "BUFF" },   -- Ironfur
        { spellID = 213680, caster = "player", filter = "BUFF" },   -- Guardian of Elune
            
            -- Procs
            { spellID = 93622 , caster = "player", filter = "BUFF" },   -- Gore
            { spellID = 203975, caster = "player", filter = "BUFF" },   -- Earthwarden
            { spellID = 213708, caster = "player", filter = "BUFF" },   -- Galatic Guardian
            { spellID = 102558, caster = "player", filter = "BUFF" },   -- Incarnation: Son of Ursoc

        -- Restoration
        { spellID = 774   , caster = "player", filter = "BUFF" },   -- Rejuvenation
        { spellID = 8936  , caster = "player", filter = "BUFF" },   -- Regrowth
        { spellID = 33763 , caster = "player", filter = "BUFF" },   -- Lifebloom
        { spellID = 48438 , caster = "player", filter = "BUFF" },   -- Wild Growth
        { spellID = 102351, caster = "player", filter = "BUFF" },   -- Cenarion Ward
        { spellID = 102342, caster = "player", filter = "BUFF" },   -- Ironbark
        { spellID = 124974, caster = "player", filter = "BUFF" },   -- Nature's Vigil
        { spellID = 155777, caster = "player", filter = "BUFF" },   -- Rejuvenation (Germination)
        { spellID = 197721, caster = "player", filter = "BUFF" },   -- Flourish
        { spellID = 207386, caster = "player", filter = "BUFF" },   -- Spring Blossoms

            -- Procs
            { spellID = 16870 , caster = "player", filter = "BUFF" },   -- Clearcasting
            { spellID = 33891 , caster = "player", filter = "BUFF" },   -- Incarnation: Tree of Life
            { spellID = 114108, caster = "player", filter = "BUFF" },   -- Soul of the Forest
            { spellID = 117679, caster = "player", filter = "BUFF" },   -- Incarnation
            
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

        { spellID = 20484 , caster = "player", filter = "CD" },     -- Rebirth
        { spellID = 22812 , caster = "player", filter = "CD" },     -- Barkskin

        -- Balance
        { spellID = 29166 , caster = "player", filter = "CD" },     -- Innervate

        -- Feral
        { spellID = 106951, caster = "player", filter = "CD" },     -- Berserk
        { spellID = 102543, caster = "player", filter = "CD" },     -- Incarnation: King of the Jungle

        -- Guardian
        { spellID = 61336 , caster = "player", filter = "CD" },     -- Survival Instincts

        -- Restoration
        { spellID = 740   , caster = "player", filter = "CD" },     -- Tranquility
        { spellID = 102342, caster = "player", filter = "CD" },     -- Ironbark

    }, -- [2]
    ]]--
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
        -- Balance
        { spellID = 29166 , caster = "player", filter = "BUFF" },   -- Innervate

        -- Restoration
        { spellID = 774   , caster = "player", filter = "BUFF" },   -- Rejuvenation
        { spellID = 8936  , caster = "player", filter = "BUFF" },   -- Regrowth
        { spellID = 33763 , caster = "player", filter = "BUFF" },   -- Lifebloom
        { spellID = 48438 , caster = "player", filter = "BUFF" },   -- Wild Growth
        { spellID = 102351, caster = "player", filter = "BUFF" },   -- Cenarion Ward
        { spellID = 102342, caster = "player", filter = "BUFF" },   -- Ironbark
        { spellID = 155777, caster = "player", filter = "BUFF" },   -- Rejuvenation (Germination)
        { spellID = 207386, caster = "player", filter = "BUFF" },   -- Spring Blossoms

        ----------------------------------------------------------------
        -- Debuffs
        ----------------------------------------------------------------
        { spellID = 339   , caster = "player", filter = "DEBUFF" }, -- Entangling Roots
        { spellID = 2637  , caster = "player", filter = "DEBUFF" }, -- Hibernate
        { spellID = 5211  , caster = "player", filter = "DEBUFF" }, -- Mighty Bash
        { spellID = 61391 , caster = "player", filter = "DEBUFF" }, -- Typhoon
        { spellID = 102359, caster = "player", filter = "DEBUFF" }, -- Mass Entanglement
        { spellID = 127797, caster = "player", filter = "DEBUFF" }, -- Ursol's Vortex (Not showing)

        -- Balance
        { spellID = 81261 , caster = "player", filter = "DEBUFF" }, -- Solar Beam
        { spellID = 164812, caster = "player", filter = "DEBUFF" }, -- Moonfire
        { spellID = 164815, caster = "player", filter = "DEBUFF" }, -- Sunfire
        { spellID = 202347, caster = "player", filter = "DEBUFF" }, -- Stellar Flare

        -- Feral
        { spellID = 1079  , caster = "player", filter = "DEBUFF" }, -- Rip
        { spellID = 50259 , caster = "player", filter = "DEBUFF" }, -- Dazed
        { spellID = 58180 , caster = "player", filter = "DEBUFF" }, -- Infected Wounds
        { spellID = 106830, caster = "player", filter = "DEBUFF" }, -- Thrash (Feral)
        { spellID = 155722, caster = "player", filter = "DEBUFF" }, -- Rake
        { spellID = 203123, caster = "player", filter = "DEBUFF" }, -- Maim
        { spellID = 274838, caster = "player", filter = "DEBUFF" }, -- Feral Frenzy

        -- Guardian
        { spellID = 99    , caster = "player", filter = "DEBUFF" }, -- Incapacitating Roar
        { spellID = 6795  , caster = "player", filter = "DEBUFF" }, -- Growl
        { spellID = 45334 , caster = "player", filter = "DEBUFF" }, -- Immobilized (Talent)
        { spellID = 192090, caster = "player", filter = "DEBUFF" }, -- Thrash (Guardian)
    }, -- [3]
}
