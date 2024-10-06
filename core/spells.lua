local _, ns = ...
local Filger = ns.Filger
local interface = Filger.interface

-- Blizzard
local GetSpellInfo = C_Spell and C_Spell.GetSpellInfo or _G.GetSpellInfo

local import = function(source, dest)
    for class, spells in next, source do
        if not dest[class] then
            dest[class] = {}
        end

        for spellId, info in next, spells do
            local data = GetSpellInfo(spellId)
            if data then
                dest[class][spellId] = info
            else
                Filger.warn("SPELLS", "Spell " .. spellId .. " do not exists.")
            end
        end
    end
end

function Filger:CreateSpellPriority(priority)
    if not tonumber(priority) then
        priority = 0
    end
    return { enabled = true, priority = priority }
end

local spells = {}

--------------------------------------------------
-- Classic
--------------------------------------------------
if Filger.isClassic then
    local data = {}
    import(data, spells)
end

--------------------------------------------------
-- The Burning Crusade
--------------------------------------------------
if Filger.isBCC then
    local data = {}
    import(data, spells)
end

--------------------------------------------------
-- Wrath of the Lich King
--------------------------------------------------
if Filger.isWrath then
    local data = {}
    import(data, spells)
end

--------------------------------------------------
-- Cataclysm
--------------------------------------------------
if Filger.isCata then
    local data = {
        ["DEATHKNIGHT"] = {
            -- Blood
            [49222] = Filger:CreateSpellPriority(8),       -- Bone Shield
        },
        ["PALADIN"] = {
            -- Holy
            [82327] = Filger:CreateSpellPriority(5),       -- Holy Radiance
            [86273] = Filger:CreateSpellPriority(5),       -- Illuminated Healing
            
            -- Protection
            [20925] = Filger:CreateSpellPriority(7),       -- Holy Shield
        },
        ["PRIEST"] = {
            -- Discipline
            [81660] = Filger:CreateSpellPriority(8),       -- Evangelism (Rank 1)
            [81661] = Filger:CreateSpellPriority(8),       -- Evangelism (Rank 2)
            [59887] = Filger:CreateSpellPriority(7),       -- Borrowed Time (Rank 1)
            [59888] = Filger:CreateSpellPriority(7),       -- Borrowed Time (Rank 2)
            [59889] = Filger:CreateSpellPriority(7),       -- Borrowed Time (Rank 3)
        }
    }

    import(data, spells)
end

if Filger.isRetail then
    local data = {
        ["DEMONHUNTER"] = {
            -- Vengeance
            [203719] = Filger:CreateSpellPriority(6),       -- Demon Spikes
            [212988] = Filger:CreateSpellPriority(8),       -- Painbringer
            [258920] = Filger:CreateSpellPriority(8),       -- Immolation Aura
            [263648] = Filger:CreateSpellPriority(7),       -- Soul Barrier
            [391234] = Filger:CreateSpellPriority(8),       -- Soulmonger
        },
        ["DEATHKNIGHT"] = {
            -- Blood
            [48743] = Filger:CreateSpellPriority(5),        -- Death Pact
            [195181] = Filger:CreateSpellPriority(8),       -- Bone Shield
            [219809] = Filger:CreateSpellPriority(8),       -- Tombstone
            [194679] = Filger:CreateSpellPriority(8),       -- Rune Tap
        },
        ["DRUID"] = {
            -- All
            [22812] = Filger:CreateSpellPriority(2),       -- Barkskin

            -- Balance
            [48517] = Filger:CreateSpellPriority(5),        -- Elipse (Solar)
            [48518] = Filger:CreateSpellPriority(5),        -- Elipse (Lunar)
            [191034] = Filger:CreateSpellPriority(2),       -- Starfall
            
            -- Feral
            
            -- Guardian
            [192081] = Filger:CreateSpellPriority(6),       -- Ironfur
            
            -- Restoration
            [16870] = Filger:CreateSpellPriority(6),        -- Clearcasting
            [117679] = Filger:CreateSpellPriority(8),       -- Incarnetion
            [102342] = Filger:CreateSpellPriority(3),       -- Ironbark
            [102351] = Filger:CreateSpellPriority(2),       -- Cenarion Ward
        },
        ["HUNTER"] = {
            -- Marksmanship
            [260242] = Filger:CreateSpellPriority(7),       -- Precise Shot
            [342076] = Filger:CreateSpellPriority(7),       -- Streamline
        },
        ["MAGE"] = {
            [384267] = Filger:CreateSpellPriority(3),       -- Siphon Storm
        },
        ["MONK"] = {
            -- Brewmaster
            [120954] = Filger:CreateSpellPriority(1),       -- Fortifying Brew
            [122278] = Filger:CreateSpellPriority(1),       -- Dampen Harm
            [122783] = Filger:CreateSpellPriority(1),       -- Diffuse Magic
            [322507] = Filger:CreateSpellPriority(3),       -- Celestial Brew
            [325092] = Filger:CreateSpellPriority(10),      -- Purified Chi
        },
        ["PALADIN"] = {
            -- Holy
            [216331] = Filger:CreateSpellPriority(1),       -- Avenging Crusader
            [388007] = Filger:CreateSpellPriority(1),       -- Blessing of Summer
            [388010] = Filger:CreateSpellPriority(1),       -- Blessing of Autumn
            [388011] = Filger:CreateSpellPriority(1),       -- Blessing of Winter
            [388013] = Filger:CreateSpellPriority(1),       -- Blessing of Spring
            [414204] = Filger:CreateSpellPriority(1),       -- Rising Sunlight
            [414273] = Filger:CreateSpellPriority(1),       -- Hand of Divinity
        },
        ["PRIEST"] = {
            -- All
            [10060] = Filger:CreateSpellPriority(3),        -- Power Infusion

            -- Discipline
            [33206] = Filger:CreateSpellPriority(10),       -- Pain Suppression
            [198069] = Filger:CreateSpellPriority(3),       -- Power of the Dark Side
            [214621] = Filger:CreateSpellPriority(8),       -- Schism (Debuff)
            [322105] = Filger:CreateSpellPriority(3),       -- Shadow Covenant

            -- Holy
            [47788] = Filger:CreateSpellPriority(10),       -- Guardian Spirit
            [200183] = Filger:CreateSpellPriority(3),       -- Apotheosis
            
            -- Shadow
            [47585] = Filger:CreateSpellPriority(10),       -- Dispersion
            [194249] = Filger:CreateSpellPriority(8),       -- Voidform
        },
        ["WARRIOR"] = {
            -- Protection
            [871] = Filger:CreateSpellPriority(1),          -- Shield Wall
            [12975] = Filger:CreateSpellPriority(1),        -- Last Stand
            [23920] = Filger:CreateSpellPriority(7),        -- Spell Reflect
            [132404] = Filger:CreateSpellPriority(9),       -- Shield Block
            [190456] = Filger:CreateSpellPriority(10),      -- Ignore Pain
        }
    }

    import(data, spells)
end

Filger.spells = spells
Filger.all = {}

for class, data in next, spells do
    for spellID, value in next, data do
        Filger.all[spellID] = data
    end
end
