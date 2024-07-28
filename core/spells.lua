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
if Filger.isBCC or interface >= 20000 then
    local data = {}
    import(data, spells)
end

--------------------------------------------------
-- Wrath of the Lich King
--------------------------------------------------
if Filger.isWotLK and interface >= 30000 then
    local data = {}
    import(data, spells)
end

--------------------------------------------------
-- Cataclysm
--------------------------------------------------
if Filger.isCata and interface >= 40000 then
    local data = {}
    import(data, spells)
end

--------------------------------------------------
-- Mists of Pandaria
--------------------------------------------------
if interface >= 50000 then
    local data = {}
    import(data, spells)
end

--------------------------------------------------
-- Warlords of Draenor
--------------------------------------------------
if interface >= 60000 then
    local data = {}
    import(data, spells)
end

--------------------------------------------------
-- Legion
--------------------------------------------------
if interface >= 70000 then
    local data = {}
    import(data, spells)
end

--------------------------------------------------
-- Battle for Azeroth
--------------------------------------------------
if interface >= 80000 then
    local data = {}
    import(data, spells)
end

--------------------------------------------------
-- Shadowlands
--------------------------------------------------
if interface >= 90000 then
    local data = {}
    import(data, spells)
end

--------------------------------------------------
-- Dragonflight
--------------------------------------------------
if interface >= 100000 then
    local data = {}
    import(data, spells)
end

if Filger.isRetail then
    local data = {
        ["DRUID"] = {
            [22812] = Filger:CreateSpellPriority(2),       -- Barkskin

            -- Balance
            [48517] = Filger:CreateSpellPriority(5),       -- Elipse (Solar)
            [48518] = Filger:CreateSpellPriority(5),       -- Elipse (Lunar)
            [191034] = Filger:CreateSpellPriority(2),      -- Starfall
        },
        ["MONK"] = {
            -- Brewmaster
            [120954] = Filger:CreateSpellPriority(1),      -- Fortifying Brew
            [122278] = Filger:CreateSpellPriority(1),      -- Dampen Harm
            [122783] = Filger:CreateSpellPriority(1),      -- Diffuse Magic
            [322507] = Filger:CreateSpellPriority(3),      -- Celestial Brew
            [325092] = Filger:CreateSpellPriority(10),     -- Purified Chi
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
            -- Talent
            [10060] = Filger:CreateSpellPriority(3),       -- Power Infusion

            -- Discipline
            [198069] = Filger:CreateSpellPriority(3),      -- Power of the Dark Side
            [322105] = Filger:CreateSpellPriority(3),      -- Shadow Covenant

            -- Holy
            [200183] = Filger:CreateSpellPriority(3),      -- Apotheosis
            
            -- Shadow
            [47585] = Filger:CreateSpellPriority(1),       -- Dispersion
            [194249] = Filger:CreateSpellPriority(8),      -- Voidform
        }
    }
    import(data, spells)
end

Filger.spells = spells
