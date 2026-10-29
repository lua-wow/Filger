local _, ns = ...

local CreateSpellCooldown = ns.data.CreateSpellCooldown
local AddCooldowns = ns.data.AddCooldowns

--------------------------------------------------
-- Cataclysm Classic
--------------------------------------------------
local data = {
    ["DEATHKNIGHT"] = {
        -- All
        CreateSpellCooldown(45529), -- Blood Tap
        CreateSpellCooldown(47568), -- Empower Rune Weapon
        CreateSpellCooldown(48707), -- Anti-Magic Shell
        CreateSpellCooldown(48743), -- Death Pact
        CreateSpellCooldown(48792), -- Icebound Fortitude
        CreateSpellCooldown(49039), -- Lichborne
        CreateSpellCooldown(61999), -- Raise Ally

        -- Blood
        CreateSpellCooldown(55233), -- Vampiric Blood
        CreateSpellCooldown(48982), -- Rune Tap
        CreateSpellCooldown(49028), -- Dancing Rune Weapon

        -- Frost
        CreateSpellCooldown(49203), -- Hungering Cold

        -- Unholy
        CreateSpellCooldown(49206), -- Summon Gargoyle
        CreateSpellCooldown(49016), -- Unholy Frenzy
        CreateSpellCooldown(51052), -- Anti-Magic Zone
    },
    ["DRUID"] = {
        CreateSpellCooldown(17116), -- Nature's Swiftness
        CreateSpellCooldown(33831), -- Force of Nature
        CreateSpellCooldown(48505), -- Starfall
        CreateSpellCooldown(50334), -- Berserk
        CreateSpellCooldown(61336), -- Survival Instincts
    },
    ["HUNTER"] = {
        CreateSpellCooldown(19386), -- Wyvern Sting
        CreateSpellCooldown(19574), -- Bestial Wrath
        CreateSpellCooldown(19577), -- Intimidation
        CreateSpellCooldown(23989), -- Readiness
        CreateSpellCooldown(34490), -- Silencing Shot

        -- Pet
        CreateSpellCooldown(23145), -- Dive
        CreateSpellCooldown(53401), -- Rabid
        CreateSpellCooldown(53426), -- Lick Your Wounds
        CreateSpellCooldown(53434), -- Call of the Wild
        CreateSpellCooldown(53477), -- Taunt
        CreateSpellCooldown(53478), -- Last Stand
        CreateSpellCooldown(53480), -- Roar of Sacrifice
        CreateSpellCooldown(53490), -- Bullheaded
        CreateSpellCooldown(53517), -- Roar of Recovery
        CreateSpellCooldown(55709), -- Heart of the Phoenix
        CreateSpellCooldown(61684), -- Dash
    },
    ["MAGE"] = {
        CreateSpellCooldown(11129), -- Combustion
        CreateSpellCooldown(11958), -- Cold Snap
        CreateSpellCooldown(12042), -- Arcane Power
        CreateSpellCooldown(12043), -- Presence of Mind
        CreateSpellCooldown(12472), -- Icy Veins
        CreateSpellCooldown(31687), -- Summon Water Elemental
        CreateSpellCooldown(44572), -- Deep Freeze
    },
    ["PALADIN"] = {
        -- All
        CreateSpellCooldown(1022),  -- Hand of Protection
        CreateSpellCooldown(1044),  -- Hand of Freedom
        CreateSpellCooldown(6940),  -- Hand of Sacrifice

        -- Holy
        CreateSpellCooldown(31821), -- Aura Mastery
        CreateSpellCooldown(31842), -- Divine Favor
        CreateSpellCooldown(54428), -- Divine Plea

        -- Protection
        CreateSpellCooldown(498),   -- Divine Protection
        CreateSpellCooldown(642),   -- Divine Shield
        CreateSpellCooldown(20925), -- Holy Shield
        CreateSpellCooldown(31850), -- Ardent Defender
        CreateSpellCooldown(70940), -- Divine Guardian
        CreateSpellCooldown(86669), -- Guardian of Ancient Kings
        CreateSpellCooldown(64205), -- Divine Sacrifice

        -- Retribution
        CreateSpellCooldown(31884), -- Avenging Wrath
        CreateSpellCooldown(20066), -- Repentance
    },
    ["PRIEST"] = {
        -- All
        CreateSpellCooldown(586),   -- Fade
        CreateSpellCooldown(6346),  -- Fear Ward
        CreateSpellCooldown(8122),  -- Psychic Scream
        CreateSpellCooldown(34433), -- Shadowfiend
        CreateSpellCooldown(64901), -- Hymn of Hope
        CreateSpellCooldown(73325), -- Leap of Faith
        CreateSpellCooldown(19236), -- Desperate Prayer

        -- Discipline
        CreateSpellCooldown(10060), -- Power Infusion
        CreateSpellCooldown(33206), -- Pain Suppression
        CreateSpellCooldown(87151), -- Archangel
        CreateSpellCooldown(89485), -- Inner Focus

        -- Holy
        CreateSpellCooldown(47788), -- Guardian Spirit
        CreateSpellCooldown(64843), -- Divine Hymn
        CreateSpellCooldown(724),   -- Lightwell

        -- Shadow
        CreateSpellCooldown(15286), -- Vampiric Embrace
        CreateSpellCooldown(15487), -- Silence
        CreateSpellCooldown(47585), -- Dispersion
        CreateSpellCooldown(64044), -- Psychic Horror
    },
    ["ROGUE"] = {
        CreateSpellCooldown(13750), -- Adrenaline Rush
        CreateSpellCooldown(13877), -- Blade Flurry
        CreateSpellCooldown(14177), -- Cold Blood
        CreateSpellCooldown(14183), -- Premeditation
        CreateSpellCooldown(14185), -- Preparation
        CreateSpellCooldown(36554), -- Shadowstep
        CreateSpellCooldown(51690), -- Killing Spree
        CreateSpellCooldown(51713), -- Shadow Dance
    },
    ["SHAMAN"] = {
        CreateSpellCooldown(16166), -- Elemental Mastery
        CreateSpellCooldown(16188), -- Nature's Swiftness
        CreateSpellCooldown(16190), -- Mana Tide Totem
        CreateSpellCooldown(30823), -- Shamanistic Rage
        CreateSpellCooldown(51490), -- Thunderstorm
        CreateSpellCooldown(51533), -- Feral Spirit
        CreateSpellCooldown(55198), -- Tidal Force
    },
    ["WARLOCK"] = {
        CreateSpellCooldown(18708), -- Fel Domination
        CreateSpellCooldown(47193), -- Demonic Empowerment
    },
    ["WARRIOR"] = {
        CreateSpellCooldown(12292), -- Death Wish
        CreateSpellCooldown(12328), -- Sweeping Strikes
        CreateSpellCooldown(12809), -- Concussion Blow
        CreateSpellCooldown(12975), -- Last Stand
        CreateSpellCooldown(46924), -- Bladestorm
        CreateSpellCooldown(46968), -- Shockwave
    }
}

AddCooldowns(data)
