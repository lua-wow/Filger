local _, ns = ...

local CreateSpellCooldown = ns.data.CreateSpellCooldown
local AddCooldowns = ns.data.AddCooldowns

--------------------------------------------------
-- Cataclysm Classic
--------------------------------------------------
local data = {
    ["DEATHKNIGHT"] = {
        -- All
        CreateSpellCooldown(45529),         -- Blood Tap
        CreateSpellCooldown(47568),         -- Empower Rune Weapon
        CreateSpellCooldown(48707),         -- Anti-Magic Shell
        CreateSpellCooldown(48743),         -- Death Pact
        CreateSpellCooldown(48792),         -- Icebound Fortitude
        CreateSpellCooldown(49039),         -- Lichborne
        CreateSpellCooldown(61999),         -- Raise Ally

        -- Blood
        CreateSpellCooldown(55233),         -- Vampiric Blood
        CreateSpellCooldown(48982),         -- Rune Tap

        -- Frost

        -- Unholy
        CreateSpellCooldown(49206),         -- Summon Gargoyle
    },
    ["PALADIN"] = {
        -- All
        CreateSpellCooldown(1022),          -- Hand of Protection
        CreateSpellCooldown(1044),          -- Hand of Freedom
        CreateSpellCooldown(6940),          -- Hand of Sacrifice

        -- Holy
        CreateSpellCooldown(31821),         -- Aura Mastery
        CreateSpellCooldown(31842),         -- Divine Favor
        CreateSpellCooldown(54428),         -- Divine Plea
        
        -- Protection
        CreateSpellCooldown(498),           -- Divine Protection
        CreateSpellCooldown(642),           -- Divine Shield
        CreateSpellCooldown(20925),         -- Holy Shield
        CreateSpellCooldown(31850),         -- Ardent Defender
        CreateSpellCooldown(70940),         -- Divine Guardian
        CreateSpellCooldown(86669),         -- Guardian of Ancient Kings
        
        -- Retribution
        CreateSpellCooldown(31884),         -- Avenging Wrath
    },
    ["PRIEST"] = {
        -- All
        CreateSpellCooldown(586),           -- Fade
        CreateSpellCooldown(6346),          -- Fear Ward
        CreateSpellCooldown(8122),          -- Psychic Scream
        CreateSpellCooldown(34433),         -- Shadowfiend
        CreateSpellCooldown(64901),         -- Hymn of Hope
        CreateSpellCooldown(73325),         -- Leap of Faith
        
        -- Discipline
        CreateSpellCooldown(10060),         -- Power Infusion
        CreateSpellCooldown(33206),         -- Pain Suppression
        CreateSpellCooldown(87151),         -- Archangel
        CreateSpellCooldown(89485),         -- Inner Focus

        -- Holy
        CreateSpellCooldown(47788),         -- Guardian Spirit
        CreateSpellCooldown(64843),         -- Divine Hymn

        -- Shadow
        CreateSpellCooldown(15286),         -- Vampiric Embrace
        CreateSpellCooldown(15487),         -- Silence
        CreateSpellCooldown(47585),         -- Dispersion
    }
}

AddCooldowns(data)
