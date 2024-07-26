local _, ns = ...
local Filger = ns.Filger

-- Blizzard
local GetSpellInfo = C_Spell and C_Spell.GetSpellInfo or _G.GetSpellInfo

-- Mine
local interface = Filger.interface
local isClassic = Filger.isClassic
local isBCC = Filger.isBCC
local isWotLK = Filger.isWotLK
local isCata = Filger.isCata

local CLASSIC = 10000
local BURNING_CRUSADE = 20000
local WRATH_LICH_KING = 30000
local CATACLYSM = 40000
local MISTS_PANDARIA = 50000
local WARLODS_DRAENOR = 60000
local LEGION = 70000
local BATTLE_AZEROTH = 80000
local SHADOWLANDS = 90000
local DRAGONFLIGHT = 100000

local import = function(source, dest)
    for spellId, enabled in next, source do
        if enabled then
            if type(spellId) == "string" then
                dest[spellId] = true
            else
                local data = GetSpellInfo(spellId)
                if data then
                    dest[spellId] = true
                else
                    Filger.warn("BLACKLIST", "Spell " .. spellId .. " do not exists.")
                end
            end
        end
    end
end


--------------------------------------------------
-- Black List
--------------------------------------------------
local blacklist = {}

local general = {
    ["Well Fed"] = true,
    ["Drink"] = true,
    ["Food"] = true,
    
    -- DRUID
    ["Mark of the Wild"] = true,
    [1126] = true,                                          -- Mark of the Wild
    [768] = true,                                           -- Cat Form
    [5487] = true,                                          -- Bear Form
    [24858] = true,                                         -- Moonkin Form
    [114282] = (interface >= MISTS_PANDARIA),               -- Treant Form

    -- MAGE
    ["Arcane Intellect"] = true,

    -- PRIEST
    ["Power Word: Fortitude"] = true,
}

import(general, blacklist)

--------------------------------------------------
-- Classic
--------------------------------------------------
do
    local data = {
        -- DRUID
        [1126] = true,                                      -- Mark of the Wild (Rank 1)
        [5232] = isClassic or isBCC or isWotLK,             -- Mark of the Wild (Rank 2)
        [6756] = isClassic or isBCC or isWotLK,             -- Mark of the Wild (Rank 3)
        [5234] = isClassic or isBCC or isWotLK,             -- Mark of the Wild (Rank 4)
        [8907] = isClassic or isBCC or isWotLK,             -- Mark of the Wild (Rank 5)
        [9884] = isClassic or isBCC or isWotLK,             -- Mark of the Wild (Rank 6)
        [9885] = isClassic or isBCC or isWotLK,             -- Mark of the Wild (Rank 7)
        [26990] = isBCC or isWotLK,                         -- Mark of the Wild (Rank 8)
        [48469] = isWotLK,                                  -- Mark of the Wild (Rank 9)

        [467] = (interface < DRAGONFLIGHT),                 -- Thorns (Rank 1)
        [782] = isClassic or isBCC or isWotLK,              -- Thorns (Rank 2)
        [1075] = isClassic or isBCC or isWotLK,             -- Thorns (Rank 3)
        [8914] = isClassic or isBCC or isWotLK,             -- Thorns (Rank 4)
        [9756] = isClassic or isBCC or isWotLK,             -- Thorns (Rank 5)
        [9910] = isClassic or isBCC or isWotLK,             -- Thorns (Rank 6)
        [26992] = isBCC or isWotLK,                         -- Thorns (Rank 7)
        [53307] = isWotLK,                                  -- Thorns (Rank 8)

        -- MAGE
        [1459] = true,                                      -- Arcane Intellect (Rank 1)
        [1460] = isClassic or isBCC or isWotLK,             -- Arcane Intellect (Rank 2)
        [1461] = isClassic or isBCC or isWotLK,             -- Arcane Intellect (Rank 3)
        [10156] = isClassic or isBCC or isWotLK,            -- Arcane Intellect (Rank 4)
        [10157] = isClassic or isBCC or isWotLK,            -- Arcane Intellect (Rank 5)
        [27126] = isBCC or isWotLK,                         -- Arcane Intellect (Rank 6)
        [42995] = isWotLK,                                  -- Arcane Intellect (Rank 7)

        -- PRIEST
        [1243] = isClassic or isBCC or isWotLK,             -- Power Word: Fortitude (Rank 1)
        [1244] = isClassic or isBCC or isWotLK,             -- Power Word: Fortitude (Rank 2)
        [1245] = isClassic or isBCC or isWotLK,             -- Power Word: Fortitude (Rank 3)
        [2791] = isClassic or isBCC or isWotLK,             -- Power Word: Fortitude (Rank 4)
        [10937] = isClassic or isBCC or isWotLK,            -- Power Word: Fortitude (Rank 5)
        [10938] = isClassic or isBCC or isWotLK,            -- Power Word: Fortitude (Rank 6)
        [25389] = isBCC or isWotLK,                         -- Power Word: Fortitude (Rank 7)
        [48161] = isWotLK,                                  -- Power Word: Fortitude (Rank 8)
        
        [21562] = isClassic,                                -- Prayer of Fortitude (Rank 1)
        [21564] = isClassic,                                -- Prayer of Fortitude (Rank 2)
        
        [27681] = isClassic,                                -- Prayer of Spirit

        -- WARLOCK
        [687] = isClassic or isBCC or isWotLK or isCata,    -- Demon Skin (Rank 1)
        [696] = isClassic or isBCC or isWotLK,              -- Demon Skin (Rank 2)

        [6307] = isClassic or isBCC or isWotLK or isCata,   -- Blood Pact (Rank 1)
        [7804] = isClassic or isBCC or isWotLK,             -- Blood Pact (Rank 2)
        [7805] = isClassic or isBCC or isWotLK,             -- Blood Pact (Rank 3)
        [11766] = isClassic or isBCC or isWotLK,            -- Blood Pact (Rank 4)
        [11787] = isClassic or isBCC or isWotLK,            -- Blood Pact (Rank 5)
        [27267] = isBCC or isWotLK,                         -- Blood Pact (Rank 6)
        [47982] = isWotLK,                                  -- Blood Pact (Rank 7)

        -- Scrolls
        [8091] = isClassic,                                 -- Armor (Scroll fo Protection)
        [8112] = isClassic,                                 -- Spirit Magic (Scroll fo Protection)
        [8113] = isClassic,                                 -- Spirit Magic (Scroll fo Protection)

        --------------------------------------------------
        -- Season of Discovery
        --------------------------------------------------
        [349981] = isClassic,                           -- Supercharged Chronoboon
        [410935] = isClassic,                           -- Meditation on the Light
        [417316] = isClassic,                           -- Meditation on the Loa
        [418459] = isClassic,                           -- Meditation on Undeath
        [419307] = isClassic,                           -- Meditation on Elune
        [430947] = isClassic,                           -- Boon of Blackfathom (World Buff)
        [436412] = isClassic,                           -- Discoverer's Delight
    }

    import(data, blacklist)
end

--------------------------------------------------
-- The Burning Crusade
--------------------------------------------------
do
    local isBCC = Filger.isBCC
    local exists = (interface >= 20000)

    local data = {
        -- PRIEST
        [25431] = isBCC,                    -- Inner Fire (Rank 7)
        [32999] = isBCC,                    -- Prayer of Spirit (Rank 2)
    }

    import(data, blacklist)
end

--------------------------------------------------
-- Wrath of the Lich King
--------------------------------------------------
do
    local isWotLK = Filger.isWotLK
    local exists = (interface >= 30000)
    
    local data  = {
        -- PRIEST
        [48040] = isWotLK,                  -- Inner Fire (Rank 8)
        [48168] = isWotLK,                  -- Inner Fire (Rank 9)
        [48074] = isWotLK,                  -- Prayer of Spirit (Rank 3)
    }

    import(data, blacklist)
end

--------------------------------------------------
-- Cataclysm
--------------------------------------------------
if Filger.isCata and interface >= 40000 then
    local data = {}
    import(data, blacklist)
end

--------------------------------------------------
-- Mists of Pandaria
--------------------------------------------------
if interface >= 50000 then
    local data = {
        [297871] = true,                -- Anglers' Water Striders
    }
    import(data, blacklist)
end

--------------------------------------------------
-- Warlords of Draenor
--------------------------------------------------
if interface >= 60000 then
    local data = {
        [186403] = true,                -- Sign of Battle
    }
    import(data, blacklist)
end

--------------------------------------------------
-- Legion
--------------------------------------------------
if interface >= 70000 then
    local data = {
        [227723] = true,                -- Mana Diving Stone
    }
    import(data, blacklist)
end

--------------------------------------------------
-- Battle for Azeroth
--------------------------------------------------
if interface >= 80000 then
    local data = {}
    import(data, blacklist)
end

--------------------------------------------------
-- Shadowlands
--------------------------------------------------
if interface >= 90000 then
    local data = {}
    import(data, blacklist)
end

--------------------------------------------------
-- Dragonflight
--------------------------------------------------
if interface >= 100000 then
    local data = {
        -- PRIEST
        [21562] = true,                 -- Power Word: Fortitude
        [280398] = true,                -- Sins of the Many

        -- Forbiden Reach
        [405261] = true,                -- Dragonscale's Favor
        [405263] = true,                -- Iskaara's Favor
        [405264] = true,                -- Maruukai's Favor
        [405265] = true,                -- Valdrakken's Favor

        -- Zaralek Cavern
        [411060] = true,                -- New Niffen No-Sniffin' Tonic

        -- Rifts
        [415603] = true,                -- Encapsulated Destiny

        -- Dreamsourge
        [419239] = true,                -- Dreaming Winds
        [418656] = true,                -- Dreamsurge Magpies
        [426647] = true,                -- Best Friends with Pip
        [426672] = true,                -- Best Friends with Urctos
        [426676] = true,                -- Best Friends with Aerwynn
        [419079] = true,                -- Dreamsurge Defenders
        [419081] = true,                -- Dreamsurge Defenders

        [430666] = true,                -- Sign of Awakened Storms
        [430668] = true,                -- Sign of Awakened Embers
        [430669] = true,                -- Sign of Awakened Dreams

        -- Items
        [401518] = true,                -- Bronze Resonance (Ominous Chromatic Essence)

        -- Tier Set
        [426262] = true,                -- Larodar's Fiery Reverie (Priest Discipline / Holy)
        [426341] = true,                -- Tindral's Fowl Fantasia (Priest Shadow)
        [426288] = true,                -- Smolderon's Delusions of Gradeour

        -- Extras
        [182422] = true,                -- Training Gear
    }

    import(data, blacklist)
end

--------------------------------------------------
-- Retail
--------------------------------------------------
if Filger.isRetail or interface >= 110000 then
    local data = {
        -- MONK
        [383733] = true,                -- Training of Niuzao
        [450572] = true,                -- Flow of Chi
        [450574] = true,                -- Flow of Chi

        -- PRIEST
        [21562] = true,                 -- Power Word: Fortitude
    }

    import(data, blacklist)
end

-- for spellId, v in next, blacklist do
--     local data = C_Spell.GetSpellInfo(spellId)
--     print("blacklist", spellId, data.name)
-- end

Filger.blacklist = blacklist
