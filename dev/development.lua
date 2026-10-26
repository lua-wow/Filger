local _, ns = ...
local Filger = ns.Filger

if not ns.config.general.dev then return end

------------------------------------------------------------
-- Development (write anything here)
------------------------------------------------------------

-- prints start/duration/enabled when readable, so an active cooldown is visible
local function secrecy(...)
    local ok, start, duration, enabled = pcall(...)
    if not ok then return "error: " .. tostring(start) end
    if start == nil then return "nil" end
    if issecretvalue and (issecretvalue(start) or issecretvalue(duration)) then
        return "|cffff0000secret|r " .. tostring(issecretvalue(start)) .. "/" .. tostring(issecretvalue(duration))
    end
    return format("%.1f/%.1f/%s", start, duration, tostring(enabled))
end

-- Experiment 10: which event reports each item/slot cooldown change
-- usage: /filger exp10 [itemID] toggles logging; use a trinket and a potion, compare with Filger's icons
-- prints a line when an event sees slot 13/14/item values that differ from what that same event saw last
local exp10Frame
local exp10Events = { "SPELL_UPDATE_COOLDOWN", "BAG_UPDATE_COOLDOWN", "ACTIONBAR_UPDATE_COOLDOWN" }

local exp10 = function(arg)
    if exp10Frame then
        exp10Frame:UnregisterAllEvents()
        exp10Frame = nil
        print(Filger.title, "exp10: stopped")
        return
    end
    local itemID = tonumber(arg)
    local last = {}

    exp10Frame = CreateFrame("Frame")
    for _, event in ipairs(exp10Events) do
        exp10Frame:RegisterEvent(event)
    end
    exp10Frame:SetScript("OnEvent", function(_, event, ...)
        local slot13 = secrecy(GetInventoryItemCooldown, "player", 13)
        local slot14 = secrecy(GetInventoryItemCooldown, "player", 14)
        local item = itemID and secrecy(C_Container.GetItemCooldown, itemID) or "-"
        local snapshot = slot13 .. " " .. slot14 .. " " .. item
        if last[event] == snapshot then return end
        last[event] = snapshot
        -- SPELL_UPDATE_COOLDOWN payload: spellID, baseSpellID, category, startRecoveryCategory, itemID (Retail only)
        local spellID, _, _, _, payloadItemID = ...
        local payload = event == "SPELL_UPDATE_COOLDOWN"
            and ("spellID " .. tostring(spellID) .. " itemID " .. tostring(payloadItemID)) or ""
        print(Filger.title, "exp10:", format("%.1f", GetTime()), event, payload,
            "slot13", slot13, "slot14", slot14, "item", item)
    end)
    print(Filger.title, "exp10: logging slot 13/14/item cooldown changes per event, run again to stop")
end

ns.AddCommand("exp10", exp10, "experiment 10: item cooldown refresh events (/filger exp10 [itemID])")

-- T20: listed aura IDs that never show up (a cast ID listed instead of the aura ID)
-- usage: /filger unseen starts logging; play the spec, then /filger unseen again lists them
-- Retail records nothing while auras are secret (combat, instances): test outside combat there
local unseenFrame, listed, seen
local unseenUnits = { player = true, target = true, focus = true }

local function markAura(data)
    if data and listed[data.spellId] then
        seen[data.spellId] = true
    end
end

local function scanUnit(unit)
    for _, filter in ipairs({ "HELPFUL", "HARMFUL" }) do
        local slots = { C_UnitAuras.GetAuraSlots(unit, filter) }
        for i = 2, #slots do -- #1 return is continuationToken
            markAura(C_UnitAuras.GetAuraDataBySlot(unit, slots[i]))
        end
    end
end

local unseen = function()
    if unseenFrame then
        unseenFrame:UnregisterAllEvents()
        unseenFrame = nil

        local ids = {}
        for spellId in next, listed do
            if not seen[spellId] then table.insert(ids, spellId) end
        end
        table.sort(ids)
        for _, spellId in ipairs(ids) do
            local info = ns.compat.GetSpellInfo(spellId)
            print(Filger.title, "unseen:", spellId, info and info.name or "?")
        end
        print(Filger.title, "unseen: stopped,", #ids, "listed IDs never seen")
        return
    end

    listed = Mixin({}, ns.data.spells[ns.player.class] or {}, ns.data.spells.ALL or {})
    seen = {}

    unseenFrame = CreateFrame("Frame")
    unseenFrame:RegisterEvent("UNIT_AURA")
    unseenFrame:SetScript("OnEvent", function(_, _, unit, updateInfo)
        -- updateInfo and aura slots are secret while restricted
        if not unseenUnits[unit] or ns.compat.AurasSecret() then return end
        if not updateInfo or updateInfo.isFullUpdate then
            scanUnit(unit)
        elseif updateInfo.addedAuras then
            for _, data in next, updateInfo.addedAuras do
                markAura(data)
            end
        end
    end)
    if not ns.compat.AurasSecret() then scanUnit("player") end
    print(Filger.title, "unseen: logging listed aura IDs, run again to report")
end

ns.AddCommand("unseen", unseen, "dev: logs listed aura IDs; run again to list the ones never seen")
