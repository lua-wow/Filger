local _, ns = ...

local CreateSpellCooldown = ns.data.CreateSpellCooldown
local AddCooldowns = ns.data.AddCooldowns

--------------------------------------------------
-- Classic Forever
--------------------------------------------------
local data = {
    ["DRUID"] = {
        CreateSpellCooldown(417141),  -- Berserk
        CreateSpellCooldown(17116),   -- Nature's Swiftness
        CreateSpellCooldown(439748),  -- Starfall
        CreateSpellCooldown(408024),  -- Survival Instincts
    },
    ["HUNTER"] = {
        CreateSpellCooldown(19574),   -- Bestial Wrath
        CreateSpellCooldown(19263),   -- Deterrence
        CreateSpellCooldown(19577),   -- Intimidation
        CreateSpellCooldown(409379),  -- Kill Command
        CreateSpellCooldown(23989),   -- Readiness
    },
    ["MAGE"] = {
        CreateSpellCooldown(12042),   -- Arcane Power
        CreateSpellCooldown(425124),  -- Arcane Surge
        CreateSpellCooldown(11113),   -- Blast Wave
        CreateSpellCooldown(12472),   -- Cold Snap
        CreateSpellCooldown(11129),   -- Combustion
        CreateSpellCooldown(440802),  -- Frozen Orb
        CreateSpellCooldown(11958),   -- Ice Block
        CreateSpellCooldown(425121),  -- Icy Veins
        CreateSpellCooldown(12043),   -- Presence of Mind
    },
    ["PALADIN"] = {
        CreateSpellCooldown(409324),  -- Ancestral Guidance
        CreateSpellCooldown(407788),  -- Avenging Wrath
        CreateSpellCooldown(20216),   -- Divine Favor
        CreateSpellCooldown(407804),  -- Divine Sacrifice
        CreateSpellCooldown(20066),   -- Repentance
        CreateSpellCooldown(1310994), -- Swift Judgement
        CreateSpellCooldown(1311015), -- Templar's Bulwark
        CreateSpellCooldown(1310897), -- Voice of Truth
    },
    ["PRIEST"] = {
        CreateSpellCooldown(425294),  -- Dispersion
        CreateSpellCooldown(402789),  -- Eye of the Void
        CreateSpellCooldown(402799),  -- Homunculi
        CreateSpellCooldown(14751),   -- Inner Focus
        CreateSpellCooldown(402004),  -- Pain Suppression
        CreateSpellCooldown(10060),   -- Power Infusion
        CreateSpellCooldown(425207),  -- Power Word: Barrier
        CreateSpellCooldown(15487),   -- Silence
    },
    ["ROGUE"] = {
        CreateSpellCooldown(13750),   -- Adrenaline Rush
        CreateSpellCooldown(13877),   -- Blade Flurry
        CreateSpellCooldown(14177),   -- Cold Blood
        CreateSpellCooldown(14183),   -- Premeditation
        CreateSpellCooldown(14185),   -- Preparation
    },
    ["SHAMAN"] = {
        CreateSpellCooldown(16166),   -- Elemental Mastery
        CreateSpellCooldown(16190),   -- Mana Tide Totem
        CreateSpellCooldown(16188),   -- Nature's Swiftness
        CreateSpellCooldown(425336),  -- Rage of the Farseer
    },
    ["WARLOCK"] = {
        CreateSpellCooldown(18288),   -- Amplify Curse
        CreateSpellCooldown(412789),  -- Demonic Howl
        CreateSpellCooldown(18708),   -- Fel Domination
        CreateSpellCooldown(426195),  -- Vengeance
    },
    ["WARRIOR"] = {
        CreateSpellCooldown(12809),   -- Concussion Blow
        CreateSpellCooldown(12328),   -- Death Wish
        CreateSpellCooldown(402913),  -- Enraged Regeneration
        CreateSpellCooldown(12975),   -- Last Stand
        CreateSpellCooldown(403228),  -- Meathook
        CreateSpellCooldown(426490),  -- Rallying Cry
    }
}

AddCooldowns(data)
