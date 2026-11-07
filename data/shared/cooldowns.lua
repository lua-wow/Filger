local _, ns = ...

local CreateSpellCooldown = ns.data.CreateSpellCooldown
local CreateSlotCooldown = ns.data.CreateSlotCooldown
local CreatePotionCooldown = ns.data.CreatePotionCooldown
local AddCooldowns = ns.data.AddCooldowns

local expansion = ns.client.expansion
local LE = ns.expansions

local racials = {
    -- Horde
    CreateSpellCooldown(7744),                                                 -- Will of the Forsaken (Undead)
    CreateSpellCooldown(20549),                                                -- War Stomp (Tauren)
    CreateSpellCooldown(20572),                                                -- Blood Fury (Orc)
    CreateSpellCooldown(26297, not ns.client.isCamelot),                       -- Berserking (Troll)
    CreateSpellCooldown(20554, ns.client.isCamelot),                           -- Berserking (Troll, Forever has only this ID)
    CreateSpellCooldown(28730, expansion >= LE.BurningCrusade),                -- Arcane Torrent (Blood Elf)
    CreateSpellCooldown(255654, expansion >= LE.Legion),                       -- Bull Rush (Highmountain Tauren)

    -- Alliance
    CreateSpellCooldown(20594),                                                -- Stoneform (Dwarf)
    CreateSpellCooldown(265221, expansion >= LE.BattleForAzeroth),             -- Fireblood Fury (Dark Iron Dwarf)
}

local gear = {
    CreateSlotCooldown(2),  -- Neck
    CreateSlotCooldown(6),  -- Waist
    CreateSlotCooldown(13), -- Trinket 1
    CreateSlotCooldown(14), -- Trinket 2
    CreatePotionCooldown(true), -- Potions (shared cooldown)
}

-- racials and gear slots go after the player class cooldowns
AddCooldowns({ ["ALL"] = racials })
AddCooldowns({ ["ALL"] = gear })
