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

-- create frame for handling events
local Tracer = CreateFrame("Frame", "FilgerTracer")

function Tracer:Enable()
    if (not self.enabled) then
        self.enabled = true
        self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    end
end

function Tracer:Disable()
    if (self.enabled) then
        self.enabled = false
        self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    end
end

function Tracer:Load()
    -- initialie saved variables for a new instance
    if (not FilgerData[instanceType]) then
        FilgerData[instanceType] = {}
    end

    if (not FilgerData[instanceType][instanceName]) then
        FilgerData[instanceType][instanceName] = {}
        FilgerData[instanceType][instanceName].instanceID = instanceID
    end

    -- initialize spell table for a new instance
    if (not SpellTable) then
        SpellTable = {}
    end

    if (not SpellTable[instanceType]) then
        SpellTable[instanceType] = {}
    end

    if (not SpellTable[instanceType][instanceName]) then
        SpellTable[instanceType][instanceName] = {}
        SpellTable[instanceType][instanceName].instanceID = instanceID
    end
end

function Tracer:Save()
    for zoneType in pairs(SpellTable) do
        for zoneName in pairs(SpellTable[zoneType]) do
            local zoneID = SpellTable[zoneType][zoneName].instanceID

            for _, data in ipairs(SpellTable[zoneType][zoneName]) do    

                -- build string
                local string = STRING_DATA:format(data.spellID, data.unit, data.caster, data.filter, data.spellName)
                
                Filger.Print(string, zoneType, zoneName, data.casterName)

                if (not FilgerData[zoneType]) then
                    FilgerData[zoneType] = {}
                end
            
                if (not FilgerData[zoneType][zoneName]) then
                    FilgerData[zoneType][zoneName] = {}
                    FilgerData[zoneType][zoneName].instanceID = instanceID
                end
                
                -- initialize saved variable if needed
                if (not FilgerData[zoneType][zoneName][data.casterName]) then
                    FilgerData[zoneType][zoneName][data.casterName] = {}
                end

                -- check if spell has already been added to saved variables
                local enabled = true
                for index, value in ipairs(FilgerData[zoneType][zoneName][data.casterName]) do
                    if (string == value) then 
                        enabled = false
                    end
                end

                if (enabled) then
                    tinsert(FilgerData[zoneType][zoneName][data.casterName], string)
                end
            end
        end
    end
end

function Tracer:Reset()
    for zoneType in pairs(FilgerData) do
        for zoneName in pairs(FilgerData[zoneType]) do
            local id = FilgerData[zoneType][zoneName].instanceID
            FilgerData[zoneType][zoneName] = {}
            FilgerData[zoneType][zoneName].instanceID = id
        end
    end
end

-- register events to initialize frame
Tracer:RegisterEvent("ADDON_LOADED")
Tracer:RegisterEvent("PLAYER_LOGOUT")
Tracer:SetScript("OnEvent", function(self, event, ...)
    -- call one of the event handlers
    self[event](self, ...)
end)

function Tracer:ADDON_LOADED(addon)
    if (addon ~= "Filger") then return end

    -- initialize saved varaibles
    if (not FilgerData) then
        FilgerData = {}
    end

    -- listen to combatlog event if tracer is set to automatic
    local enabled = Config["Plugins"].Tracer
    if (enabled == "auto") then
        self:RegisterEvent("PLAYER_ENTERING_WORLD")
    end

    -- we do not have to be called for any further addons
	self:UnregisterEvent("ADDON_LOADED")
end

function Tracer:PLAYER_ENTERING_WORLD()
    -- update instance variables
    inInstance, instanceType = IsInInstance()
    instanceName, _, _, _, _, _, _, instanceID = GetInstanceInfo()

    -- check if player is inside a raid or dungeon
    if (inInstance and (instanceType == "raid") or (instanceType == "party")) then

        -- check if instance have already been saved
        if (Instances[instanceID] and Instances[instanceID].saved) then return end

        -- load tables
        self:Load()

        -- enable combat log listning
        self:Enable()
    else
        -- enable combat log listning
        self:Disable()
    end
end

function Tracer:COMBAT_LOG_EVENT_UNFILTERED()
    local timestamp, eventType, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags,
    destGUID, destName, destFlags, destRaidFlags = CombatLogGetCurrentEventInfo()

    -- check if source name exists
    if (not sourceName) then sourceName = "Unknown" end

    -- only auras are important
    if (eventType == "SPELL_AURA_APPLIED") then
        -- spell aura standard
        local spellID, spellName, spellSchool, auraType, amount = select(12, CombatLogGetCurrentEventInfo())

        -- check if affected unit is a Player or a NPC/Creature
        local unit = (band(destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0) and "player" or "target"

        -- check if source is a player or belongs to player
        if (band(sourceFlags, COMBATLOG_OBJECT_TYPE_PLAYER) > 0) or (band(sourceFlags, COMBATLOG_FILTER_PETS) > 0) then
            return
        else
            caster = "all"
        end

        -- variable that say if spell is to be saved
        local enabled = true

        -- check if spell has already been added to spell table.
        for _, data in ipairs(SpellTable[instanceType][instanceName]) do
            if (data.spellID == spellID) then return end
        end

        -- check if spell has already been saved on filger tables.
        if (Instances[instanceID]) then
            for _, data in ipairs(Instances[instanceID]) do
                if (data.spellID == spellID) then return end
            end
        end

        -- insert into spell table.
        if (enabled) then
            -- insert into spell table
            tinsert(SpellTable[instanceType][instanceName], { spellID = spellID, spellName = spellName, unit = unit, caster = caster, casterName = sourceName, filter = auraType })
        end
    end
end

function Tracer:PLAYER_LOGOUT()
    -- copy spell table into saved variables
    self:Save()
end

----------------------------------------------------------------
-- Commands
----------------------------------------------------------------
local state = false
Filger.AddOnCommands["tracer"] = function(arg2)
    if (not state) then
        Tracer:Enable()
    else
        Tracer:Disable()
    end
end

Filger.AddOnCommands["reset"] = function(arg2)
    if (arg2 == "all") then
        FilgerData = {}
    else
        Tracer:Reset()
    end
end
