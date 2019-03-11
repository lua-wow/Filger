local _, ns = ...
local Filger = ns.Filger
local Config = ns.Config
local SpellList = ns.SpellList
local Instances = ns.Instances

----------------------------------------------------------------
-- Filger Tracer
----------------------------------------------------------------
if (not Config["Plugins"].Tracer) then return end

local bor, band = bit.bor, bit.band
local tinsert = table.insert

local instanceType, instanceName, instanceID
local SpellTable = {}

local COMBATLOG_FILTER_PETS = bor(COMBATLOG_OBJECT_TYPE_GUARDIAN, COMBATLOG_OBJECT_TYPE_PET, COMBATLOG_OBJECT_REACTION_FRIENDLY)
local STRING_DATA = "{ spellID = %d, unit = '%s', caster = '%s', filter = '%s' }, -- %s"
local STRING_HEX = "0x%08x"
local ZoneTypes = {
    ["none"] = false,                           -- when outside an instance
    ["pvp"] = false,                            -- when in a battleground
    ["arena"] = false,                          -- when in an arena
    ["party"] = true,                           -- when in a 5-man instance
    ["raid"] = true,                            -- when in a raid instance
    ["scenario"] = false,                       -- when in a scenario
	-- nil when in an unknown kind of instance
}

function Filger:TracerEnable()
    if (not self.tracer) then
        Filger.Print("Tracer Enabled!")
        self.tracer = true
        self:LoadVariables()
        self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    else
        Filger.Print("Tracer Disabled!")
        self.tracer = false
        self:SaveVarables()
        self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    end
end

function Filger:LoadVariables()
    -- get instance/continent information
    inInstance, instanceType = IsInInstance()
    instanceName, _, _, _, _, _, _, instanceID = GetInstanceInfo()

    Filger.Print(inInstance, instanceType, instanceName, instanceID)

    -- initialize filger saved variables
    if (not FilgerData) then
        FilgerData = {}
    end

    if (not FilgerData[instanceType]) then
        FilgerData[instanceType] = {}
    end

    if (not FilgerData[instanceType][instanceName]) then
        FilgerData[instanceType][instanceName] = {}
    end

    -- initialize spell table
    if (not SpellTable) then
        SpellTable = {}
    end

    if (not SpellTable[instanceType]) then
        SpellTable[instanceType] = {}
    end

    if (not SpellTable[instanceType][instanceName]) then
        SpellTable[instanceType][instanceName] = {}
    end
end

function Filger:SaveVarables()
    -- run through all zone types saved
    for zoneType in pairs(SpellTable) do
        -- run trhough all zones saved
        for zoneID in pairs(SpellTable[zoneType]) do
            -- san all data recorded
            for _, data in pairs(SpellTable[zoneType][zoneID]) do
                -- build string
                local string = STRING_DATA:format(data.spellID, data.unit, data.caster, data.filter, data.spellName)

                -- initialize saved variable if needed
                if (not FilgerData[instanceType][instanceName][data.casterName]) then
                    FilgerData[instanceType][instanceName][data.casterName] = {}
                end

                -- check if spell has already been added to saved variables
                local enabled = true
                for index, value in ipairs(FilgerData[instanceType][instanceName][data.casterName]) do
                    if (string == value) then
                        enabled = false
                    end
                end

                if (enabled) then
                    tinsert(FilgerData[instanceType][instanceName][data.casterName], string)
                end
            end
        end
    end
end

function Filger:ResetZones()
    for zoneType, zoneTable in pairs(ZoneTypes) do
        if (FilgerData[zoneType]) then
            FilgerData[zoneType] = {}
        end
    end
    Filger.Print("SavedVariables Reseted!")
end

function Filger:COMBAT_LOG_EVENT_UNFILTERED()
    local timestamp, eventType, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags,
    destGUID, destName, destFlags, destRaidFlags = CombatLogGetCurrentEventInfo()

    if (not sourceName) then
        sourceName = "Unknown"
    end

    if (eventType == "SPELL_AURA_APPLIED") then
        -- spell aura standard
        local spellID, spellName, spellSchool, auraType, amount = select(12, CombatLogGetCurrentEventInfo())

        local unit = (band(destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0) and "player" or "target"
        
        local caster = nil

        -- check if caster is a player
        if (band(sourceFlags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0) or
            (band(sourceFlags, COMBATLOG_FILTER_PETS) > 0) then 
            return
        else
            caster = "all"
        end
        
        local enabled = true

        -- check if spell has already been added to spell table.
        for _, data in ipairs(SpellTable[instanceType][instanceName]) do
            if (data.spellID == spellID) then
                enabled = false
            end
        end

        -- check if spell has already been added to instances table.
        for _, data in ipairs(Instances[instanceID]) do
            if (data.spellID == spellID) then
                enabled = false
            end
        end
        
        -- insert into spell table.
        if (enabled) then
            -- show unsaved auras
            Filger.Debug(STRING_DATA:format(spellID, unit, caster .. " (" .. sourceName .. " | " .. sourceGUID .. " | " .. STRING_HEX:format(sourceFlags) .. ")", auraType, spellName))

            -- insert into spell table
            tinsert(SpellTable[instanceType][instanceName], { spellID = spellID, spellName = spellName, unit = unit, caster = caster, casterName = sourceName, filter = auraType })
        end
    end
end