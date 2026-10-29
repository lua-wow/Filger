local _, ns = ...

local CreateSpellCooldown = ns.data.CreateSpellCooldown
local AddCooldowns = ns.data.AddCooldowns

--------------------------------------------------
-- The Burning Crusade Classic
--------------------------------------------------
local data = {
    ["DRUID"] = {
        -- General
        CreateSpellCooldown(20484), -- Rebirth (Rank 1)
        CreateSpellCooldown(740),   -- Tranquility (Rank 1)
        CreateSpellCooldown(22812), -- Barkskin
        CreateSpellCooldown(29166), -- Innervate
        CreateSpellCooldown(1850),  -- Dash (Rank 1)
        CreateSpellCooldown(5229),  -- Enrage
        CreateSpellCooldown(5209),  -- Challenging Roar
        CreateSpellCooldown(22842), -- Frenzied Regeneration (Rank 1)

        -- Talents
        CreateSpellCooldown(17116), -- Nature's Swiftness
        CreateSpellCooldown(16979), -- Feral Charge
        CreateSpellCooldown(33831), -- Force of Nature

        CreateSpellCooldown(5211),  -- Bash (Rank 1)
        CreateSpellCooldown(6798),  -- Bash (Rank 2)
        CreateSpellCooldown(8983),  -- Bash (Rank 3)
        CreateSpellCooldown(16914), -- Hurricane (Rank 1)
        CreateSpellCooldown(17401), -- Hurricane (Rank 2)
        CreateSpellCooldown(17402), -- Hurricane (Rank 3)
        CreateSpellCooldown(27012), -- Hurricane (Rank 4)
        CreateSpellCooldown(16689), -- Nature's Grasp (Rank 1)
        CreateSpellCooldown(16810), -- Nature's Grasp (Rank 2)
        CreateSpellCooldown(16811), -- Nature's Grasp (Rank 3)
        CreateSpellCooldown(16812), -- Nature's Grasp (Rank 4)
        CreateSpellCooldown(16813), -- Nature's Grasp (Rank 5)
        CreateSpellCooldown(17329), -- Nature's Grasp (Rank 6)
        CreateSpellCooldown(27009), -- Nature's Grasp (Rank 7)
    },
    ["HUNTER"] = {
        -- General
        CreateSpellCooldown(3045),  -- Rapid Fire
        CreateSpellCooldown(5384),  -- Feign Death
        CreateSpellCooldown(1499),  -- Freezing Trap (Rank 1)
        CreateSpellCooldown(19801), -- Tranquilizing Shot
        CreateSpellCooldown(34477), -- Misdirection

        -- Talents
        CreateSpellCooldown(19574), -- Bestial Wrath
        CreateSpellCooldown(19577), -- Intimidation
        CreateSpellCooldown(19263), -- Deterrence
        CreateSpellCooldown(23989), -- Readiness
        CreateSpellCooldown(34490), -- Silencing Shot
        CreateSpellCooldown(19386), -- Wyvern Sting (Rank 1)

        CreateSpellCooldown(1510),  -- Volley (Rank 1)
        CreateSpellCooldown(14294), -- Volley (Rank 2)
        CreateSpellCooldown(14295), -- Volley (Rank 3)
        CreateSpellCooldown(27022), -- Volley (Rank 4)
    },
    ["MAGE"] = {
        -- General
        CreateSpellCooldown(2139),  -- Counterspell
        CreateSpellCooldown(45438), -- Ice Block
        CreateSpellCooldown(66),    -- Invisibility

        -- Arcane
        CreateSpellCooldown(12051), -- Evocation
        CreateSpellCooldown(12042), -- Arcane Power
        CreateSpellCooldown(12043), -- Presence of Mind

        -- Fire
        CreateSpellCooldown(11129), -- Combustion

        -- Frost
        CreateSpellCooldown(12472), -- Icy Veins
        CreateSpellCooldown(11958), -- Cold Snap
        CreateSpellCooldown(31687), -- Summon Water Elemental

        CreateSpellCooldown(43987), -- Ritual of Refreshment
    },
    ["PALADIN"] = {
        -- General
        CreateSpellCooldown(498),   -- Divine Protection
        CreateSpellCooldown(642),   -- Divine Shield
        CreateSpellCooldown(633),   -- Lay on Hands
        CreateSpellCooldown(1022),  -- Blessing of Protection
        CreateSpellCooldown(1044),  -- Blessing of Freedom
        CreateSpellCooldown(6940),  -- Blessing of Sacrifice
        CreateSpellCooldown(853),   -- Hammer of Justice (Rank 1)
        CreateSpellCooldown(31884), -- Avenging Wrath

        -- Talents
        CreateSpellCooldown(20216), -- Divine Favor
        CreateSpellCooldown(31842), -- Divine Illumination
        CreateSpellCooldown(20066), -- Repentance

        CreateSpellCooldown(19752), -- Divine Intervention
        CreateSpellCooldown(2812),  -- Holy Wrath (Rank 1)
        CreateSpellCooldown(10318), -- Holy Wrath (Rank 2)
        CreateSpellCooldown(27139), -- Holy Wrath (Rank 3)
    },
    ["PRIEST"] = {
        -- Discipline
        CreateSpellCooldown(10060), -- Power Infusion
        CreateSpellCooldown(14751), -- Inner Focus

        -- Holy
        CreateSpellCooldown(724),   -- Lightwell (Rank 1)
        CreateSpellCooldown(27870), -- Lightwell (Rank 2)
        CreateSpellCooldown(27871), -- Lightwell (Rank 3)

        -- Shadow
        CreateSpellCooldown(15487), -- Silence

        CreateSpellCooldown(586),   -- Fade (Rank 1)
        CreateSpellCooldown(9578),  -- Fade (Rank 2)
        CreateSpellCooldown(9579),  -- Fade (Rank 3)
        CreateSpellCooldown(9592),  -- Fade (Rank 4)
        CreateSpellCooldown(10941), -- Fade (Rank 5)
        CreateSpellCooldown(10942), -- Fade (Rank 6)

        CreateSpellCooldown(8122),  -- Psychic Scream (Rank 1)
        CreateSpellCooldown(8124),  -- Psychic Scream (Rank 2)
        CreateSpellCooldown(10888), -- Psychic Scream (Rank 3)
        CreateSpellCooldown(10890), -- Psychic Scream (Rank 4)

        CreateSpellCooldown(6346),  -- Fear Ward (Rank 1)

        -- Night Elf
        CreateSpellCooldown(2651),  -- Elune's Grace

        -- Human
        CreateSpellCooldown(13896), -- Feedback (Rank 1)
        CreateSpellCooldown(19271), -- Feedback (Rank 2)
        CreateSpellCooldown(19273), -- Feedback (Rank 3)
        CreateSpellCooldown(19274), -- Feedback (Rank 4)
        CreateSpellCooldown(19275), -- Feedback (Rank 5)
        CreateSpellCooldown(25441), -- Feedback (Rank 6)

        -- Dwarf / Humman
        CreateSpellCooldown(13908), -- Desperate Prayer (Rank 1)
        CreateSpellCooldown(19236), -- Desperate Prayer (Rank 2)
        CreateSpellCooldown(19238), -- Desperate Prayer (Rank 3)
        CreateSpellCooldown(19240), -- Desperate Prayer (Rank 4)
        CreateSpellCooldown(19241), -- Desperate Prayer (Rank 5)
        CreateSpellCooldown(19242), -- Desperate Prayer (Rank 6)
        CreateSpellCooldown(19243), -- Desperate Prayer (Rank 7)
        CreateSpellCooldown(25437), -- Desperate Prayer (Rank 8)

        -- Undead
        CreateSpellCooldown(2944),  -- Devouring Plague(Rank 1)
        CreateSpellCooldown(19276), -- Devouring Plague(Rank 2)
        CreateSpellCooldown(19277), -- Devouring Plague(Rank 3)
        CreateSpellCooldown(19278), -- Devouring Plague(Rank 4)
        CreateSpellCooldown(19279), -- Devouring Plague(Rank 5)
        CreateSpellCooldown(19280), -- Devouring Plague(Rank 6)

        -- Talents
        CreateSpellCooldown(33206), -- Pain Suppression
        CreateSpellCooldown(34433), -- Shadowfiend

        CreateSpellCooldown(28880), -- Gift of the Naaru
    },
    ["ROGUE"] = {
        -- General
        CreateSpellCooldown(1766),  -- Kick (Rank 1)
        CreateSpellCooldown(2094),  -- Blind
        CreateSpellCooldown(5277),  -- Evasion (Rank 1)
        CreateSpellCooldown(1856),  -- Vanish (Rank 1)
        CreateSpellCooldown(2983),  -- Sprint (Rank 1)
        CreateSpellCooldown(31224), -- Cloak of Shadows

        -- Talents
        CreateSpellCooldown(13750), -- Adrenaline Rush
        CreateSpellCooldown(13877), -- Blade Flurry
        CreateSpellCooldown(14177), -- Cold Blood
        CreateSpellCooldown(14185), -- Preparation
        CreateSpellCooldown(14183), -- Premeditation
        CreateSpellCooldown(36554), -- Shadowstep
    },
    ["SHAMAN"] = {
        -- General
        CreateSpellCooldown(8177),  -- Grounding Totem
        CreateSpellCooldown(20608), -- Reincarnation
        CreateSpellCooldown(2825),  -- Bloodlust
        CreateSpellCooldown(32182), -- Heroism
        CreateSpellCooldown(2062),  -- Earth Elemental Totem
        CreateSpellCooldown(2894),  -- Fire Elemental Totem

        -- Talents
        CreateSpellCooldown(16166), -- Elemental Mastery
        CreateSpellCooldown(16188), -- Nature's Swiftness
        CreateSpellCooldown(30823), -- Shamanistic Rage
        CreateSpellCooldown(16190), -- Mana Tide Totem
    },
    ["WARLOCK"] = {
        -- General
        CreateSpellCooldown(1122),  -- Inferno
        CreateSpellCooldown(6789),  -- Death Coil (Rank 1)
        CreateSpellCooldown(5484),  -- Howl of Terror (Rank 1)
        CreateSpellCooldown(29858), -- Soulshatter

        -- Talents
        CreateSpellCooldown(18288), -- Amplify Curse
        CreateSpellCooldown(18708), -- Fel Domination

        CreateSpellCooldown(603),   -- Curse of Doom (Rank 1)
        CreateSpellCooldown(30910), -- Curse of Doom (Rank 2)
        CreateSpellCooldown(18540), -- Ritual of Doom
        CreateSpellCooldown(29893), -- Ritual of Souls
        CreateSpellCooldown(6353),  -- Soul Fire (Rank 1)
        CreateSpellCooldown(17924), -- Soul Fire (Rank 2)
        CreateSpellCooldown(27211), -- Soul Fire (Rank 3)
        CreateSpellCooldown(30545), -- Soul Fire (Rank 4)
        CreateSpellCooldown(17735), -- Suffering (Rank 1)
        CreateSpellCooldown(17750), -- Suffering (Rank 2)
        CreateSpellCooldown(17751), -- Suffering (Rank 3)
        CreateSpellCooldown(17752), -- Suffering (Rank 4)
        CreateSpellCooldown(27271), -- Suffering (Rank 5)
        CreateSpellCooldown(33701), -- Suffering (Rank 6)
    },
    ["WARRIOR"] = {
        -- General
        CreateSpellCooldown(871),   -- Shield Wall
        CreateSpellCooldown(1719),  -- Recklessness
        CreateSpellCooldown(20230), -- Retaliation
        CreateSpellCooldown(18499), -- Berserker Rage
        CreateSpellCooldown(3411),  -- Intervene
        CreateSpellCooldown(5246),  -- Intimidating Shout
        CreateSpellCooldown(1161),  -- Challenging Shout
        CreateSpellCooldown(676),   -- Disarm
        CreateSpellCooldown(2687),  -- Bloodrage
        CreateSpellCooldown(6552),  -- Pummel (Rank 1)
        CreateSpellCooldown(20252), -- Intercept (Rank 1)

        -- Talents
        CreateSpellCooldown(12292), -- Death Wish
        CreateSpellCooldown(12328), -- Sweeping Strikes
        CreateSpellCooldown(12809), -- Concussion Blow
        CreateSpellCooldown(12975), -- Last Stand

        CreateSpellCooldown(694),   -- Mocking Blow (Rank 1)
        CreateSpellCooldown(7400),  -- Mocking Blow (Rank 2)
        CreateSpellCooldown(7402),  -- Mocking Blow (Rank 3)
        CreateSpellCooldown(20559), -- Mocking Blow (Rank 4)
        CreateSpellCooldown(20560), -- Mocking Blow (Rank 5)
        CreateSpellCooldown(25266), -- Mocking Blow (Rank 6)
        CreateSpellCooldown(26090), -- Thunderstomp (Rank 1)
        CreateSpellCooldown(26187), -- Thunderstomp (Rank 2)
        CreateSpellCooldown(26188), -- Thunderstomp (Rank 3)
        CreateSpellCooldown(27063), -- Thunderstomp (Rank 4)
    }
}

AddCooldowns(data)
