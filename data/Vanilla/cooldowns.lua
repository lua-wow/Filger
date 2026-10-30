local _, ns = ...

local CreateSpellCooldown = ns.data.CreateSpellCooldown
local AddCooldowns = ns.data.AddCooldowns

--------------------------------------------------
-- Classic Era
--------------------------------------------------
local data = {
    ["DRUID"] = {
        -- General
        CreateSpellCooldown(20484),  -- Rebirth (Rank 1)
        CreateSpellCooldown(20739),  -- Rebirth (Rank 2)
        CreateSpellCooldown(20742),  -- Rebirth (Rank 3)
        CreateSpellCooldown(20747),  -- Rebirth (Rank 4)
        CreateSpellCooldown(20748),  -- Rebirth (Rank 5)

        CreateSpellCooldown(740),    -- Tranquility (Rank 1)
        CreateSpellCooldown(8918),   -- Tranquility (Rank 2)
        CreateSpellCooldown(9862),   -- Tranquility (Rank 3)
        CreateSpellCooldown(9863),   -- Tranquility (Rank 4)

        CreateSpellCooldown(22812),  -- Barkskin

        CreateSpellCooldown(1850),   -- Dash (Rank 1)
        CreateSpellCooldown(9821),   -- Dash (Rank 2)

        CreateSpellCooldown(5229),   -- Enrage
        CreateSpellCooldown(5209),   -- Challenging Roar

        CreateSpellCooldown(22842),  -- Frenzied Regeneration (Rank 1)
        CreateSpellCooldown(22895),  -- Frenzied Regeneration (Rank 2)
        CreateSpellCooldown(22896),  -- Frenzied Regeneration (Rank 3)

        -- Talents
        CreateSpellCooldown(16979),  -- Feral Charge
        CreateSpellCooldown(17116),  -- Nature's Swiftness
        CreateSpellCooldown(29166),  -- Innervate

        CreateSpellCooldown(417141), -- Berserk
        CreateSpellCooldown(439748), -- Starfall
        CreateSpellCooldown(408024), -- Survival Instincts
    },
    ["HUNTER"] = {
        -- General
        CreateSpellCooldown(1499),   -- Freezing Trap
        CreateSpellCooldown(3045),   -- Rapid Fire
        CreateSpellCooldown(5384),   -- Feign Death
        -- CreateSpellCooldown(19801),         -- Tranquilizing Shot

        -- Talents
        CreateSpellCooldown(19263),  -- Deterrence
        CreateSpellCooldown(19386),  -- Wyvern Sting
        CreateSpellCooldown(19574),  -- Bestial Wrath
        CreateSpellCooldown(19577),  -- Intimidation

        CreateSpellCooldown(409379), -- Kill Command
    },
    ["MAGE"] = {
        -- General
        CreateSpellCooldown(2139),   -- Counterspell

        -- Arcane
        CreateSpellCooldown(12042),  -- Arcane Power
        CreateSpellCooldown(12043),  -- Presence of Mind
        CreateSpellCooldown(12051),  -- Evocation

        -- Fire
        CreateSpellCooldown(11129),  -- Combustion

        -- Frost
        CreateSpellCooldown(11958),  -- Ice Block
        CreateSpellCooldown(12472),  -- Icy Veins

        CreateSpellCooldown(425124), -- Arcane Surge
        CreateSpellCooldown(440802), -- Frozen Orb
        CreateSpellCooldown(425121), -- Icy Veins
    },
    ["PALADIN"] = {
        -- General
        CreateSpellCooldown(498),    -- Divine Protection
        CreateSpellCooldown(642),    -- Divine Shield
        CreateSpellCooldown(633),    -- Lay on Hands

        CreateSpellCooldown(853),    -- Hammer of Justice (Rank 1)
        CreateSpellCooldown(5588),   -- Hammer of Justice (Rank 2)
        CreateSpellCooldown(5589),   -- Hammer of Justice (Rank 3)
        CreateSpellCooldown(10308),  -- Hammer of Justice (Rank 4)

        CreateSpellCooldown(1022),   -- Blessing of Protection (Rank 1)
        CreateSpellCooldown(5599),   -- Blessing of Protection (Rank 2)
        CreateSpellCooldown(10278),  -- Blessing of Protection (Rank 3)

        CreateSpellCooldown(1044),   -- Blessing of Freedom

        -- Holy
        CreateSpellCooldown(20216),  -- Divine Favor

        -- Retribution
        CreateSpellCooldown(20066),  -- Repentance

        CreateSpellCooldown(409324), -- Ancestral Guidance
        CreateSpellCooldown(407804), -- Divine Sacrifice
    },
    ["PRIEST"] = {
        -- Discipline
        CreateSpellCooldown(10060),  -- Power Infusion
        CreateSpellCooldown(14751),  -- Inner Focus

        -- Holy
        CreateSpellCooldown(724),    -- Lightwell (Rank 1)
        CreateSpellCooldown(27870),  -- Lightwell (Rank 2)
        CreateSpellCooldown(27871),  -- Lightwell (Rank 3)

        -- Shadow
        CreateSpellCooldown(15487),  -- Silence

        CreateSpellCooldown(586),    -- Fade (Rank 1)
        CreateSpellCooldown(9578),   -- Fade (Rank 2)
        CreateSpellCooldown(9579),   -- Fade (Rank 3)
        CreateSpellCooldown(9592),   -- Fade (Rank 4)
        CreateSpellCooldown(10941),  -- Fade (Rank 5)
        CreateSpellCooldown(10942),  -- Fade (Rank 6)

        CreateSpellCooldown(8122),   -- Psychic Scream (Rank 1)
        CreateSpellCooldown(8124),   -- Psychic Scream (Rank 2)
        CreateSpellCooldown(10888),  -- Psychic Scream (Rank 3)
        CreateSpellCooldown(10890),  -- Psychic Scream (Rank 4)

        -- Night Elf
        CreateSpellCooldown(2651),   -- Elune's Grace (Rank 1)
        CreateSpellCooldown(19289),  -- Elune's Grace (Rank 2)
        CreateSpellCooldown(19291),  -- Elune's Grace (Rank 3)
        CreateSpellCooldown(19292),  -- Elune's Grace (Rank 4)
        CreateSpellCooldown(19293),  -- Elune's Grace (Rank 5)

        -- Human
        CreateSpellCooldown(13896),  -- Feedback (Rank 1)
        CreateSpellCooldown(19271),  -- Feedback (Rank 2)
        CreateSpellCooldown(19273),  -- Feedback (Rank 3)
        CreateSpellCooldown(19274),  -- Feedback (Rank 4)
        CreateSpellCooldown(19275),  -- Feedback (Rank 5)

        -- Dwarf
        CreateSpellCooldown(6346),   -- Fear Ward (Rank 1)

        -- Dwarf / Humman
        CreateSpellCooldown(13908),  -- Desperate Prayer (Rank 1)
        CreateSpellCooldown(19236),  -- Desperate Prayer (Rank 2)
        CreateSpellCooldown(19238),  -- Desperate Prayer (Rank 3)
        CreateSpellCooldown(19240),  -- Desperate Prayer (Rank 4)
        CreateSpellCooldown(19241),  -- Desperate Prayer (Rank 5)
        CreateSpellCooldown(19242),  -- Desperate Prayer (Rank 6)
        CreateSpellCooldown(19243),  -- Desperate Prayer (Rank 7)

        -- Undead
        CreateSpellCooldown(2944),   -- Devouring Plague(Rank 1)
        CreateSpellCooldown(19276),  -- Devouring Plague(Rank 2)
        CreateSpellCooldown(19277),  -- Devouring Plague(Rank 3)
        CreateSpellCooldown(19278),  -- Devouring Plague(Rank 4)
        CreateSpellCooldown(19279),  -- Devouring Plague(Rank 5)
        CreateSpellCooldown(19280),  -- Devouring Plague(Rank 6)

        CreateSpellCooldown(425294), -- Dispersion
        CreateSpellCooldown(402789), -- Eye of the Void
        CreateSpellCooldown(402799), -- Homunculi
        CreateSpellCooldown(402004), -- Pain Suppression
        CreateSpellCooldown(425207), -- Power Word: Barrier
    },
    ["ROGUE"] = {
        -- General
        CreateSpellCooldown(2094),   -- Blind
        CreateSpellCooldown(5277),   -- Evasion

        CreateSpellCooldown(1856),   -- Vanish (Rank 1)
        CreateSpellCooldown(1857),   -- Vanish (Rank 2)

        CreateSpellCooldown(2983),   -- Sprint (Rank 1)
        CreateSpellCooldown(8696),   -- Sprint (Rank 2)
        CreateSpellCooldown(11305),  -- Sprint (Rank 3)

        -- Talents
        CreateSpellCooldown(13750),  -- Adrenaline Rush
        CreateSpellCooldown(13877),  -- Blade Flurry
        CreateSpellCooldown(14177),  -- Cold Blood
        CreateSpellCooldown(14183),  -- Premeditation
        CreateSpellCooldown(14185),  -- Preparation
    },
    ["SHAMAN"] = {
        -- General
        -- CreateSpellCooldown(8177),          -- Grounding Totem
        CreateSpellCooldown(20608),  -- Reincarnation

        -- Restoration
        CreateSpellCooldown(16188),  -- Nature's Swiftness
        CreateSpellCooldown(16190),  -- Mana Tide Totem (Rank 1)
        CreateSpellCooldown(17354),  -- Mana Tide Totem (Rank 2)
        CreateSpellCooldown(17359),  -- Mana Tide Totem (Rank 3)

        -- Elemental
        CreateSpellCooldown(16166),  -- Elemental Mastery

        -- Enhancement
        CreateSpellCooldown(17364),  -- Stormstrike
    },
    ["WARLOCK"] = {
        -- General
        CreateSpellCooldown(1122),   -- Inferno

        CreateSpellCooldown(6789),   -- Death Coil (Rank 1)
        CreateSpellCooldown(17925),  -- Death Coil (Rank 2)
        CreateSpellCooldown(17926),  -- Death Coil (Rank 3)

        CreateSpellCooldown(5484),   -- Howl of Terror (Rank 1)
        CreateSpellCooldown(17928),  -- Howl of Terror (Rank 2)

        -- Affliction
        CreateSpellCooldown(18288),  -- Amplify Curse

        -- Demonologist
        CreateSpellCooldown(18708),  -- Fel Domination

        CreateSpellCooldown(412789), -- Demonic Howl
        CreateSpellCooldown(426195), -- Vengeance
    },
    ["WARRIOR"] = {
        -- General
        CreateSpellCooldown(1719),   -- Recklessness

        CreateSpellCooldown(6552),   -- Pummel (Rank 1)
        CreateSpellCooldown(6554),   -- Pummel (Rank 2)

        -- Talents
        CreateSpellCooldown(12292),  -- Sweeping Strikes
        CreateSpellCooldown(12328),  -- Death Wish

        -- Arms
        CreateSpellCooldown(6178),   -- Charge
        CreateSpellCooldown(7400),   -- Mocking Blow
        CreateSpellCooldown(20230),  -- Retaliation

        -- Fury
        CreateSpellCooldown(1161),   -- Challenging Shout
        CreateSpellCooldown(5246),   -- Intimidating Shout
        CreateSpellCooldown(18499),  -- Berserker Rage
        CreateSpellCooldown(20252),  -- Intercept

        -- Protection
        CreateSpellCooldown(676),    -- Disarm
        CreateSpellCooldown(871),    -- Shield Wall
        CreateSpellCooldown(1671),   -- Shield Bash
        CreateSpellCooldown(2687),   -- Bloodrage
        CreateSpellCooldown(12809),  -- Concussion Blow
        CreateSpellCooldown(12975),  -- Last Stand

        -- Season of Discovery
        CreateSpellCooldown(402913), -- Enraged Regeneration
        CreateSpellCooldown(426490), -- Rallying Cry
    }
}

AddCooldowns(data)
