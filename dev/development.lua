local _, ns = ...
local Filger = ns.Filger

if not ns.config.general.dev then return end

------------------------------------------------------------
-- Development (write anything here)
------------------------------------------------------------

-- Experiment 4: spell-ID gate of CustomAuraContainerTemplate
-- usage: /filger exp4 <buffID>,<debuffID> (out of combat, then enter combat and compare)
local exp4 = function(arg)
    local buff, debuff = (arg or ""):match("^(%d+),(%d+)$")
    if not buff then
        print(Filger.title, "usage: /filger exp4 <buffID>,<debuffID>")
        return
    elseif not C_XMLUtil or not C_XMLUtil.GetTemplateInfo("CustomAuraContainerTemplate") then
        print(Filger.title, "exp4: no CustomAuraContainerTemplate on this client")
        return
    elseif InCombatLockdown() then
        print(Filger.title, "exp4: leave combat first")
        return
    elseif _G.FilgerExp4_T1 then
        print(Filger.title, "exp4: already created, /reload to change IDs")
        return
    end
    buff, debuff = tonumber(buff), tonumber(debuff)

    -- CustomAuraButtonTemplate has no regions; without an icon the button draws nothing
    local function initializeFrame(button)
        button:SetSize(32, 32)
        local icon = button:CreateTexture(nil, "ARTWORK")
        icon:SetAllPoints()
        button:SetIcon(icon)
        local count = button:CreateFontString(nil, "OVERLAY", "NumberFontNormal")
        count:SetPoint("BOTTOMRIGHT")
        button:SetApplicationCount(count)
    end

    local function Make(name, unit, filter, candidateFilters, y)
        local c = CreateFrame("AuraContainer", "FilgerExp4_" .. name, UIParent, "CustomAuraContainerTemplate")
        c:SetPoint("LEFT", UIParent, "CENTER", 0, y)
        c:SetUnit(unit)
        c:AddAuraGroup(name, filter, {
            candidateFilters = candidateFilters,
            initializeFrame = initializeFrame,
            layout = { elementWidth = 32, elementHeight = 32, elementSpacing = 2, lineSpacing = 2 }
        })

        local label = UIParent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        label:SetPoint("RIGHT", UIParent, "CENTER", -10, y)
        label:SetText(name .. " " .. unit .. " " .. filter)
    end

    -- expected in combat (Retail): T1 buff, T2 empty, T3 debuff still shown, T4 no error
    Make("T1", "player", "HELPFUL|PLAYER", { includeSpellIDs = { [buff] = true } }, 120)
    Make("T2", "player", "HARMFUL", { includeSpellIDs = { [debuff] = true } }, 80)
    Make("T3", "player", "HARMFUL", { excludeSpellIDs = { [debuff] = true } }, 40)
    Make("T4", "focus", "HARMFUL", nil, 0)
    print(Filger.title, "exp4: created T1-T4, buff", buff, "debuff", debuff)
end

ns.AddCommand("exp4", exp4, "experiment 4: aura container spell-ID gate (/filger exp4 <buffID>,<debuffID>)")

-- Experiment 5: which filter strings each client accepts and fills
-- usage: /filger exp5 (out of combat; GetAuraSlots errors on secret auras)
local filters = {
    -- complementary pairs must add up to HELPFUL, so they can be checked solo
    "HELPFUL", "HARMFUL", "HELPFUL|PLAYER", "HELPFUL|!PLAYER", "HELPFUL|CANCELABLE", "HELPFUL|!CANCELABLE",
    "HELPFUL|NOT_CANCELABLE", "HELPFUL|BIG_DEFENSIVE", "HELPFUL|IMPORTANT", "HARMFUL|RAID_PLAYER_DISPELLABLE",
    "HARMFUL|DISPELLABLE"
}

local exp5 = function()
    if C_Secrets and C_Secrets.ShouldAurasBeSecret() then
        print(Filger.title, "exp5: auras are secret right now, leave combat first")
        return
    end

    for _, filter in ipairs(filters) do
        -- unknown tokens may error; the first return is a continuation token, not a slot
        local ok, n = pcall(function() return select("#", C_UnitAuras.GetAuraSlots("player", filter)) - 1 end)
        -- "||" so chat doesn't read "|R" / "|N" as escape codes
        print(Filger.title, (filter:gsub("|", "||")), ok and n or ("error: " .. tostring(n)))
    end
end

ns.AddCommand("exp5", exp5, "experiment 5: aura counts per filter string on the player")

-- Experiment 6: private aura anchors from addon code
-- usage: /filger exp6 (anywhere; the private aura icon draws inside the grey boxes)
local exp6 = function()
    if not C_UnitAuras.AddPrivateAuraAnchor then
        print(Filger.title, "exp6: no AddPrivateAuraAnchor on this client")
        return
    elseif _G.FilgerExp6 then
        print(Filger.title, "exp6: already created")
        return
    end

    local frame = CreateFrame("Frame", "FilgerExp6", UIParent)
    frame:SetSize(3 * 44, 44)
    frame:SetPoint("CENTER", UIParent, "CENTER", 0, 200)

    -- one anchor per private aura slot on the player
    for i = 1, 3 do
        local slot = CreateFrame("Frame", nil, frame)
        slot:SetSize(40, 40)
        slot:SetPoint("LEFT", frame, "LEFT", (i - 1) * 44, 0)
        local bg = slot:CreateTexture(nil, "BACKGROUND")
        bg:SetAllPoints()
        bg:SetColorTexture(0.3, 0.3, 0.3, 0.5)

        local ok, anchorID = pcall(C_UnitAuras.AddPrivateAuraAnchor, {
            unitToken = "player",
            auraIndex = i,
            parent = slot,
            showCooldownFrame = true,
            showCountdownNumbers = true,
            iconInfo = {
                iconAnchor = { point = "CENTER", relativeTo = slot, relativePoint = "CENTER", offsetX = 0, offsetY = 0 },
                iconWidth = 40,
                iconHeight = 40
            }
        })
        print(Filger.title, "exp6: slot", i, "aurasSecret", C_Secrets and C_Secrets.ShouldAurasBeSecret(),
            ok and "anchorID" or "error", tostring(anchorID))
    end
end

ns.AddCommand("exp6", exp6, "experiment 6: private aura anchors on the player")

-- Experiment 7: cooldown edges (item/slot cooldowns, secret cast spellID)
-- usage: /filger exp7 [itemID] toggles logging; enter combat and cast spells / use the item
-- on each player cast: is the spellID secret, are slot 13/14 and item cooldowns secret
local exp7Frame
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

local exp7 = function(arg)
    if not issecretvalue then
        print(Filger.title, "exp7: no issecretvalue on this client")
        return
    elseif exp7Frame then
        exp7Frame:UnregisterAllEvents()
        exp7Frame = nil
        print(Filger.title, "exp7: stopped")
        return
    end
    local itemID = tonumber(arg)

    exp7Frame = CreateFrame("Frame")
    exp7Frame:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player")
    exp7Frame:SetScript("OnEvent", function(_, _, _, _, spellID)
        -- a secret spellID can't be printed or looked up; the cast order tells which spell it was
        local id = issecretvalue(spellID) and "|cffff0000secret|r" or tostring(spellID)
        print(Filger.title, "exp7:", format("%.1f", GetTime()), "combat", tostring(InCombatLockdown()),
            "spellID", id,
            "slot13", secrecy(GetInventoryItemCooldown, "player", 13),
            "slot14", secrecy(GetInventoryItemCooldown, "player", 14),
            "item", itemID and secrecy(C_Container.GetItemCooldown, itemID) or "-")
    end)
    print(Filger.title, "exp7: logging player casts (start/duration or secret), run again to stop")
end

ns.AddCommand("exp7", exp7, "experiment 7: cooldown edges, logs player casts (/filger exp7 [itemID])")

-- Experiment 8: which aura tooltip methods each client has
-- usage: /filger exp8 (anywhere)
local exp8 = function()
    for _, method in ipairs({ "SetUnitAura", "SetUnitBuff", "SetUnitDebuff", "SetUnitBuffByAuraInstanceID",
        "SetUnitDebuffByAuraInstanceID" }) do
        print(Filger.title, "exp8:", method, GameTooltip[method] ~= nil)
    end
end

ns.AddCommand("exp8", exp8, "experiment 8: aura tooltip methods on GameTooltip")

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
