local _, ns = ...
local Filger = ns.Filger

------------------------------------------------------------
-- Development (write anything here)
------------------------------------------------------------

-- Experiment 4 (docs/secret-values-options.md): spell-ID gate of CustomAuraContainerTemplate
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

Filger:AddCommand("exp4", exp4, "experiment 4: aura container spell-ID gate (/filger exp4 <buffID>,<debuffID>)")

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

Filger:AddCommand("exp5", exp5, "experiment 5: aura counts per filter string on the player")

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

Filger:AddCommand("exp6", exp6, "experiment 6: private aura anchors on the player")
