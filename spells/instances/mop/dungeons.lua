local _, ns = ...
local Filger = ns.Filger
local Instances = ns.Instances

----------------------------------------------------------------
-- Mists of Pandaria Dungeons -- Challenge Mode
----------------------------------------------------------------
-- Shado-pan Monastery
Instances[959] = {
    { spellID = 126115, unit = "player", caster = "all", filter = "DEBUFF" },   -- Ice Arrow
    { spellID = 115630, unit = "player", caster = "all", filter = "DEBUFF" },   -- Weakened Defenses
    { spellID = 113022, unit = "player", caster = "all", filter = "DEBUFF" },   -- Touch of Weakness
    { spellID = 130701, unit = "player", caster = "all", filter = "DEBUFF" },   -- Destruvtive Influence
    { spellID = 106827, unit = "player", caster = "all", filter = "DEBUFF" },   -- Smoke Blades

    { spellID = 112060, unit = "target", caster = "all", filter = "BUFF" },     -- Apparitions
}

-- Temple of the Jade Serpent
Instances[960] = {
    { spellID = 113309, unit = "target", caster = "all", filter = "DEBUFF" },   -- Ultimate Power
    { spellID = 113315, unit = "target", caster = "all", filter = "BUFF" },     -- Intensity
}

-- Stormstout Brewery
Instances[961] = {
    { spellID = 106851, unit = "player", caster = "all", filter = "DEBUFF" },   -- Blackout Brew
    { spellID = 106857, unit = "player", caster = "all", filter = "DEBUFF" },   -- Blackout Drunk
    { spellID = 116170, unit = "player", caster = "all", filter = "DEBUFF" },   -- Carbonation
    { spellID = 114459, unit = "player", caster = "all", filter = "DEBUFF" },   -- Fizzy Bubbles
    { spellID = 106546, unit = "player", caster = "all", filter = "DEBUFF" },   -- Bloat
    { spellID = 106648, unit = "player", caster = "all", filter = "DEBUFF" },   -- Brew Explosion

    { spellID = 106784, unit = "target", caster = "all", filter = "DEBUFF" },   -- Brew Explosion
}

-- Gate of the Setting Sun
Instances[962] = {
    { spellID = 113645, unit = "player", caster = "all", filter = "DEBUFF" },   -- Sabotage
    { spellID = 88611 , unit = "player", caster = "all", filter = "DEBUFF" },   -- Smoke Bomb
    { spellID = 106933, unit = "player", caster = "all", filter = "DEBUFF" },   -- Prey Time
    { spellID = 107122, unit = "player", caster = "all", filter = "DEBUFF" },   -- Viscous Fluid

    { spellID = 107091, unit = "target", caster = "all", filter = "BUFF" },     -- Viscous Fluid
}

-- Mogu'shan Palace
Instances[994] = {
    { spellID = 120160, unit = "player", caster = "all", filter = "DEBUFF" },   -- Conflagrate
    { spellID = 119946, unit = "player", caster = "all", filter = "DEBUFF" },   -- Ravage
    { spellID = 123646, unit = "player", caster = "all", filter = "DEBUFF" },   -- Intimidation
    { spellID = 118963, unit = "player", caster = "all", filter = "DEBUFF" },   -- Shank
}

-- Siege of the Niuzao Temple
Instances[1011] = {
    
    { spellID = 120938, unit = "player", caster = "all", filter = "DEBUFF" },   -- Residue
    { spellID = 121421, unit = "player", caster = "all", filter = "DEBUFF" },   -- Malleable Resin
    { spellID = 120593, unit = "player", caster = "all", filter = "DEBUFF" },   -- Sap Puddle
    { spellID = 121447, unit = "player", caster = "all", filter = "DEBUFF" },   -- Quick-Dry Resin
    { spellID = 121443, unit = "player", caster = "all", filter = "DEBUFF" },   -- Caustic Pitch
    { spellID = 120778, unit = "player", caster = "all", filter = "DEBUFF" },   -- Caustic Tar
    { spellID = 121448, unit = "player", caster = "all", filter = "DEBUFF" },   -- Encased in Resin
    { spellID = 131971, unit = "player", caster = "all", filter = "BUFF" },     -- Wind`s Grace
    
    { spellID = 120955, unit = "target", caster = "all", filter = "BUFF" },     -- Resin Shell
    { spellID = 120778, unit = "target", caster = "all", filter = "DEBUFF" },   -- Caustic Tar
    { spellID = 119395, unit = "target", caster = "all", filter = "DEBUFF" },   -- Detonate
}

-- Scarlet Halls
Instances[6052] = {
    { spellID = 128164, unit = "player", caster = "all", filter = "BUFF" },     -- Carrying Bucket
}

-- Scarlet Monastery
Instances[1004] = {}

-- Scholomance
Instances[1007] = {
    { spellID = 113996, unit = "player", caster = "all", filter = "DEBUFF" },   -- Bone Armor
    { spellID = 111610, unit = "player", caster = "all", filter = "DEBUFF" },   -- Ice Wrath
    { spellID = 113141, unit = "player", caster = "all", filter = "DEBUFF" },   -- Immolate

    { spellID = 113765, unit = "target", caster = "all", filter = "BUFF" },     -- Rusting
}
