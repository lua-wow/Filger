local _, ns = ...
local Filger = ns.Filger
local interface = Filger.interface

-- Blizzard
local GetSpellInfo = C_Spell and C_Spell.GetSpellInfo or _G.GetSpellInfo

local import = function(dest, source)
    for class, spells in next, source do
        if not dest[class] then
            dest[class] = {}
        end

        for spellId, info in next, spells do
            local data = GetSpellInfo(spellId)
            if data then
                dest[class][spellId] = info
            else
                Filger:warn("SPELLS", "Spell " .. spellId .. " do not exists.")
            end
        end
    end
end

function Filger:CreateSpellPriority(arg1, arg2)
    local enabled, priority, stackThreshold = true, 0, 0

    if type(arg1) == "boolean" then
        enabled = arg1
    elseif type(arg1) == "number" then
        priority = arg1
    end

    if type(arg2) == "number" then
        stackThreshold = arg2
    end

    return { enabled = enabled, priority = priority, stackThreshold = stackThreshold }
end

local spells = {}

--------------------------------------------------
-- Classic
--------------------------------------------------
if Filger.isClassic then
    local data = {}
    import(spells, data)
end

--------------------------------------------------
-- The Burning Crusade
--------------------------------------------------
if Filger.isBCC then
    local data = {}
    import(spells, data)
end

--------------------------------------------------
-- Wrath of the Lich King
--------------------------------------------------
if Filger.isWrath then
    local data = {}
    import(spells, data)
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

    import(spells, data)
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
            -- Mistweaver

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

            -- Protection
            [642] = Filger:CreateSpellPriority(9),          -- Divine Shield
            [31850] = Filger:CreateSpellPriority(9),        -- Ardent Defender
            [86659] = Filger:CreateSpellPriority(9),        -- Guardian of Ancient Kings
            [31884] = Filger:CreateSpellPriority(8),        -- Avenging Wrath
            [132403] = Filger:CreateSpellPriority(8),       -- Shield of Righteous
            [432502] = Filger:CreateSpellPriority(7),       -- Sacred Weapon
            [432496] = Filger:CreateSpellPriority(7),       -- Holy Bulwark
            [432607] = Filger:CreateSpellPriority(7),       -- Holy Bulwark
            [400745] = Filger:CreateSpellPriority(false),   -- Afterimage
            [433550] = Filger:CreateSpellPriority(false),   -- Afterimage

            [387174] = Filger:CreateSpellPriority(7),       -- Eye of Tyr (target)
        },
        ["PRIEST"] = {
            -- All
            [586] = Filger:CreateSpellPriority(10),         -- Fade
            [10060] = Filger:CreateSpellPriority(7),        -- Power Infusion

            -- Discipline
            [33206] = Filger:CreateSpellPriority(10),       -- Pain Suppression
            [322105] = Filger:CreateSpellPriority(9),       -- Shadow Covenant
            [214621] = Filger:CreateSpellPriority(8),       -- Schism (Debuff)
            [455033] = Filger:CreateSpellPriority(7),       -- Darkness from Light
            [198069] = Filger:CreateSpellPriority(9),       -- Power of the Dark Side

            [428933] = Filger:CreateSpellPriority(10),      -- Premonition of Insight (-cooldown)
            [428930] = Filger:CreateSpellPriority(10),      -- Premonition of Piety (+ healing)
            [428934] = Filger:CreateSpellPriority(10),      -- Premonition of Solace (single heal to shield)

            -- Holy
            [47788] = Filger:CreateSpellPriority(10),       -- Guardian Spirit
            [200183] = Filger:CreateSpellPriority(3),       -- Apotheosis
            
            -- Shadow
            [47585] = Filger:CreateSpellPriority(10),       -- Dispersion
            [15286] = Filger:CreateSpellPriority(3),        -- Vampiric Embrace
            [194249] = Filger:CreateSpellPriority(10),      -- Voidform
            [391109] = Filger:CreateSpellPriority(10),      -- Dark Ascension
            [391401] = Filger:CreateSpellPriority(7),       -- Mind Flay: Insanity
            [391099] = Filger:CreateSpellPriority(8),       -- Dark Evangelism
            [373204] = Filger:CreateSpellPriority(8),       -- Mind Devourer
            [454638] = Filger:CreateSpellPriority(8),       -- Devouring Chorus
        },
        ["SHAMAN"] = {
            -- General
            [108270] = Filger:CreateSpellPriority(10),      -- Stone Bulwark Totem
            [108271] = Filger:CreateSpellPriority(10),      -- Astral Shift
            [192106] = Filger:CreateSpellPriority(false),   -- Lightning Shield
            [381684] = Filger:CreateSpellPriority(false),   -- Brimming with Life

            -- Enhancement
            [344179] = Filger:CreateSpellPriority(9),       -- Maelstrom Weapon
            [454015] = Filger:CreateSpellPriority(9),       -- Tempest
            [333957] = Filger:CreateSpellPriority(8),       -- Feral Spirit
            [466772] = Filger:CreateSpellPriority(7),       -- Doom Winds
            [470532] = Filger:CreateSpellPriority(7),       -- Arc Discharge
            [375986] = Filger:CreateSpellPriority(7),       -- Primordial Wave
            [187878] = Filger:CreateSpellPriority(7),       -- Crash Lightning
            [470058] = Filger:CreateSpellPriority(1),       -- Vulcanic Blaze
            [201900] = Filger:CreateSpellPriority(1),       -- Hot Hand
            [384411] = Filger:CreateSpellPriority(1),       -- Static Accumulation
            [455110] = Filger:CreateSpellPriority(1),       -- Supercharge
            [469344] = Filger:CreateSpellPriority(1),       -- Molten Thunder
            [224127] = Filger:CreateSpellPriority(false),   -- Crackling Surge
        },
        ["WARRIOR"] = {
            -- Protection
            [871] = Filger:CreateSpellPriority(1),          -- Shield Wall
            [12975] = Filger:CreateSpellPriority(1),        -- Last Stand
            [23920] = Filger:CreateSpellPriority(7),        -- Spell Reflect
            [132404] = Filger:CreateSpellPriority(9),       -- Shield Block
            [190456] = Filger:CreateSpellPriority(10),      -- Ignore Pain
        },
        ["ALL"] = {
            -- Items
            [449578] = Filger:CreateSpellPriority(false),   -- Deliberate Incubation (Ovi'nax Mercurial Egg)
            [449581] = Filger:CreateSpellPriority(false),   -- Reckless Incubation (Ovi'nax Mercurial Egg)
            [452226] = Filger:CreateSpellPriority(false),   -- Spiderling (Ara-Kara Sacbrood)
            [457925] = Filger:CreateSpellPriority(false),   -- Venomous Potential (Seal of the Poisoned Pact)
            [462513] = Filger:CreateSpellPriority(8, 1),    -- Severed Strands (Spymaster's Web)
            [449947] = Filger:CreateSpellPriority(20),      -- Realigning Nexus Convergence Divergence (Treacherous Transmitter)

            -- Consumables
            [431932] = Filger:CreateSpellPriority(5),       -- Tempered Potion
        }
    }

    import(spells, data)
end

Filger.spells = spells
Filger.all = {}

for class, data in next, spells do
    Filger.all = Mixin(Filger.all, data or {})
end
