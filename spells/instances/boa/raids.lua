local _, ns = ...
local Filger = ns.Filger
local Instances = ns.Instances

----------------------------------------------------------------
-- Battle for Azeroth Raids
----------------------------------------------------------------
-- Uldir
Instances[1861] = {
    --[[ Taloc ]]--
    { spellID = 270290, unit = "player", caster = "all", filter = "DEBUFF" },   -- Blood Storm

    --[[ The Projection of G'huun ]]--
    { spellID = 265360, unit = "player", caster = "all", filter = "DEBUFF" },   -- Roiling Deceit
}

-- Battle of Dazar'alor
Instances[2070] = {
    --[[Champion of the Light ]]--

        --[[ Frida Ironbellows ]]--
        { spellID = 283573, unit = "player", caster = "all", filter = "DEBUFF" },   -- Sacred Blade
        { spellID = 283617, unit = "player", caster = "all", filter = "DEBUFF" },   -- Wave of Light
        { spellID = 284459, unit = "target", caster = "all", filter = "BUFF" },     -- Zealotry
        { spellID = 282113, unit = "target", caster = "all", filter = "BUFF" },     -- Avenging Wrath
        { spellID = 283933, unit = "target", caster = "all", filter = "BUFF" },     -- Judgment: Righteousness
        { spellID = 284469, unit = "target", caster = "all", filter = "BUFF" },     -- Seal of Retribution
        { spellID = 284436, unit = "target", caster = "all", filter = "BUFF" },     -- Seal of Reckoning

        --[[ Anointed Disciple ]]--
        { spellID = 283619, unit = "target", caster = "all", filter = "BUFF" },     -- Wave of Light
        { spellID = 284468, unit = "target", caster = "all", filter = "BUFF" },     -- Aura of Retribution

        --[[ Darkforged Crusader ]]--
        { spellID = 283651, unit = "player", caster = "all", filter = "DEBUFF" },   -- Blinding Faith
        { spellID = 283619, unit = "target", caster = "all", filter = "BUFF" },     -- Wave of Light
        { spellID = 284468, unit = "target", caster = "all", filter = "BUFF" },     -- Aura of Retribution

    --[[ Grong ]]--
    { spellID = 285875, unit = "player", caster = "all", filter = "DEBUFF" },   -- Rending Bite
    { spellID = 282010, unit = "player", caster = "all", filter = "DEBUFF" },   -- Shattered
    { spellID = 285671, unit = "player", caster = "all", filter = "DEBUFF" },   -- Crushed
    { spellID = 281936, unit = "target", caster = "all", filter = "BUFF" },     -- Tantrum
    { spellID = 286763, unit = "target", caster = "all", filter = "BUFF" },     -- Crushing Slam

    --[[ Jadefire Masters ]]--

        --[[ Manceroy Flamefist ]]--
        { spellID = 282037, unit = "player", caster = "all", filter = "DEBUFF" },   -- Rising Flames
        { spellID = 286379, unit = "player", caster = "all", filter = "DEBUFF" },   -- Pyroblast
        { spellID = 286988, unit = "player", caster = "all", filter = "DEBUFF" },   -- Searing Embers
        { spellID = 282040, unit = "target", caster = "all", filter = "BUFF" },     -- Blazing Phoenix
        { spellID = 286425, unit = "target", caster = "all", filter = "BUFF" },     -- Fire Shield
        { spellID = 284669, unit = "target", caster = "all", filter = "BUFF" },     -- Flash of Phoenixes

        --[[ Mestrah, the Illuminated ]]--
        { spellID = 286436, unit = "target", caster = "all", filter = "BUFF" },     -- Whirling Jade Storm", -- [1]
        { spellID = 284656, unit = "target", caster = "all", filter = "BUFF" },     -- Ring of Hostility", -- [2]

        --[[ Living Bomb ]]--
        { spellID = 286369, unit = "target", caster = "all", filter = "DEBUFF" },   -- Chi-Ji's Song
        { spellID = 286503, unit = "player", caster = "all", filter = "DEBUFF" },   -- Beam

    --[[ Opulence ]]--
    --[[ Conclave of the Chosen ]]--
    --[[ King Rastakhan ]]--
    --[[ High Tinker Mekkatorque ]]--
    --[[ Stormwall Blockade ]]--
    --[[ Lady Jaina Proudmoore ]]--

    --[[ Trash ]]--
    { spellID = 284089, unit = "target", caster = "all", filter = "DEBUFF" },   -- Successful Defense
    { spellID = 259873, unit = "target", caster = "all", filter = "DEBUFF" },   -- Rip
    { spellID = 281959, unit = "target", caster = "all", filter = "DEBUFF" },   -- Combined Power
    { spellID = 286932, unit = "target", caster = "all", filter = "DEBUFF" },   -- Battle Damage
    { spellID = 287456, unit = "player", caster = "all", filter = "DEBUFF" },   -- Frost Nova
    { spellID = 287460, unit = "player", caster = "all", filter = "DEBUFF" },   -- Heart of Frost
    { spellID = 287437, unit = "player", caster = "all", filter = "DEBUFF" },   -- Frozen Beam
    { spellID = 289645, unit = "player", caster = "all", filter = "DEBUFF" },   -- Polymorph
    { spellID = 284089, unit = "target", caster = "all", filter = "DEBUFF" },   -- Successful Defense
    { spellID = 284089, unit = "target", caster = "all", filter = "DEBUFF" },   -- Successful Defense
    { spellID = 256401, unit = "player", caster = "all", filter = "DEBUFF" },   -- Vile Webbing

    { spellID = 289623, unit = "target", caster = "all", filter = "BUFF" },     -- Guardian Spirit
    { spellID = 283583, unit = "target", caster = "all", filter = "BUFF" },     -- Consecration
    { spellID = 289596, unit = "target", caster = "all", filter = "BUFF" },     -- For the King!
}