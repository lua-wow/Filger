local _, ns = ...
local Filger = ns.Filger
local Instances = ns.Instances

----------------------------------------------------------------
-- Legion Dungeons
----------------------------------------------------------------
Instances[1501] = {}    -- Black Rook Hold
Instances[1677] = {}    -- Cathedral of Eternal Night
Instances[1571] = {}    -- Court of Stars
Instances[1466] = {}    -- Darkheart Thicket
Instances[1477] = {}    -- Halls of Valor
Instances[1492] = {}    -- Maw of Souls
Instances[1458] = {}    -- Neltharion's Lair
Instances[1651] = {}    -- Return to Karazhan
Instances[1753] = {}    -- Seat of the Triumvirate
Instances[1516] = {}    -- The Arcway
Instances[1493] = {}    -- Vault of the Wardens
Instances[1544] = {}    -- Violet Hold

-- Eye of Azshara
Instances[1456] = {
    ["instanceID"] = 1456,
    
    --[[ Warlord Parjesh ]]--
    { spellID = 192131, unit = "player", caster = "all", filter = "DEBUFF" },   -- Throw Spear
    { spellID = 192094, unit = "player", caster = "all", filter = "DEBUFF" },   -- Impaling Spear
    { spellID = 192053, unit = "player", caster = "all", filter = "DEBUFF" },   -- Quicksand
    { spellID = 191900, unit = "target", caster = "all", filter = "BUFF" },     -- Crashing Wave
    
    --[[ Lady Hatecoil ]]--
    { spellID = 193698, unit = "player", caster = "all", filter = "DEBUFF" },   -- Curse of the Witch
    
    --[[ King Deepbeard ]]--
    { spellID = 193018, unit = "player", caster = "all", filter = "DEBUFF" },   -- Gaseous Bubbles
    { spellID = 197550, unit = "target", caster = "all", filter = "BUFF" },     -- Frenzy

    --[[ ["Serpentrix ]]--
    { spellID = 191855, unit = "player", caster = "all", filter = "DEBUFF" },   -- Toxic Wound
    { spellID = 191848, unit = "target", caster = "all", filter = "BUFF" },     -- Rampage
    { spellID = 202680, unit = "target", caster = "all", filter = "BUFF" },     -- Hydra Head

        --[[ Arcane Hydra Spawn ]]--
        { spellID = 192007, unit = "target", caster = "all", filter = "BUFF" }, -- Arcane Charge

    --[[ Wrath of Azshara ]]--
    { spellID = 192706, unit = "player", caster = "all", filter = "DEBUFF" }, -- Arcane Bomb
    { spellID = 192696, unit = "player", caster = "all", filter = "DEBUFF" }, -- Raging Storms
    
    --[[ Trash ]]--
    { spellID = 196515, unit = "player", caster = "all", filter = "DEBUFF" }, -- Magic Binding
    { spellID = 193636, unit = "player", caster = "all", filter = "DEBUFF" }, -- Watery Splash
    { spellID = 193055, unit = "player", caster = "all", filter = "DEBUFF" }, -- Call the Seas
    { spellID = 195094, unit = "player", caster = "all", filter = "DEBUFF" }, -- Coral Slash
    { spellID = 196064, unit = "player", caster = "all", filter = "DEBUFF" }, -- Tearing Bite
    { spellID = 196058, unit = "player", caster = "all", filter = "DEBUFF" }, -- Lethargic Toxin
    { spellID = 196059, unit = "player", caster = "all", filter = "DEBUFF" }, -- Sea-Brine Toxin
    { spellID = 196060, unit = "player", caster = "all", filter = "DEBUFF" }, -- Numbing Toxin
    { spellID = 196111, unit = "player", caster = "all", filter = "DEBUFF" }, -- Jagged Claws
    { spellID = 195105, unit = "player", caster = "all", filter = "DEBUFF" }, -- Crunching Bite
    { spellID = 195060, unit = "target", caster = "all", filter = "DEBUFF" }, -- Rejuvenating Waters
    
    { spellID = 193196, unit = "target", caster = "all", filter = "BUFF" }, -- Storm Conduit
    { spellID = 196296, unit = "target", caster = "all", filter = "BUFF" }, -- Roiling Storm
    { spellID = 196290, unit = "target", caster = "all", filter = "BUFF" }, -- Chaotic Tempest
    { spellID = 196127, unit = "target", caster = "all", filter = "BUFF" }, -- Spray Sand
    { spellID = 195945, unit = "target", caster = "all", filter = "BUFF" }, -- Rising Fury
    { spellID = 115385, unit = "target", caster = "all", filter = "BUFF" }, -- Rush
    { spellID = 176048, unit = "target", caster = "all", filter = "BUFF" }, -- Enrage
    { spellID = 195103, unit = "target", caster = "all", filter = "BUFF" }, -- Spiked Carapace
    { spellID = 193491, unit = "target", caster = "all", filter = "BUFF" }, -- Tempest Attunement
    { spellID = 197868, unit = "target", caster = "all", filter = "BUFF" }, -- Arcane Shielding
    { spellID = 197064, unit = "target", caster = "all", filter = "BUFF" }, -- Enrage
    { spellID = 202314, unit = "target", caster = "all", filter = "BUFF" }, -- Vile Blood
    { spellID = 195801, unit = "target", caster = "all", filter = "BUFF" }, -- Massive Quake
}