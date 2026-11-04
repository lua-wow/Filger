local _, ns = ...
local Filger = ns.Filger
local CreateButton = ns.button.Create
local GetSpellInfo = ns.compat.GetSpellInfo

-- Blizzard
local CreateFrame = _G.CreateFrame

--------------------------------------------------
-- FILGER
--------------------------------------------------

do
    local element_proto = {}

    function element_proto:SetPosition(from, to)
        local element = self
        local sizex = element.size + element.spacing
        local sizey = element.size + element.spacing
        local anchor = element.initialAnchor or "BOTTOMLEFT"
        local growthx = (element["growth-x"] == "LEFT" and -1) or 1
        local growthy = (element["growth-y"] == "DOWN" and -1) or 1
        local cols = math.floor(element:GetWidth() / sizex + 0.5)
    
        for i = from, to do
            local button = element[i]
            if (not button) then break end

            if anchor == "CENTER" then
                -- Centralized positioning logic
                local index = i - from
                local col, row
                if index % 2 == 0 then
                    col = math.floor(index / 2)
                else
                    col = -math.floor(index / 2) - 1
                end
                row = math.floor(index / cols)
                
                button:ClearAllPoints()
                button:SetPoint(anchor, element, anchor, col * sizex, row * sizey)
            else
                local col = (i - 1) % cols
                local row = math.floor((i - 1) / cols)
        
                button:ClearAllPoints()
                button:SetPoint(anchor, element, anchor, col * sizex * growthx, row * sizey * growthy)
            end
        end
    end

    function element_proto:AcquireButton(index)
        local button = self[index]
        if not button then
            button = CreateButton(self, index)
            table.insert(self, button)
        end
        return button
    end

    function element_proto:Render(unit, sorted, compare)
        -- /filger test owns the buttons; element state keeps updating
        if self.testing then return end

        table.sort(sorted, compare)

        local numVisible = math.min(self.limit, #sorted)

        for i = 1, numVisible do
            self:Update(unit, sorted[i], i)
        end

        for i = numVisible + 1, #self do
            self[i]:Hide()
        end

        self:SetPosition(1, numVisible)
    end

    --------------------------------------------------
    -- TEST MODE (/filger test)
    --------------------------------------------------
    local auraPool, cooldownPool

    local function AddToPool(pool, spellId)
        local info = GetSpellInfo(spellId)
        if info and info.iconID then
            table.insert(pool.spellIds, spellId)
            table.insert(pool.icons, info.iconID)
        end
    end

    -- auras: every class's listed spells; cooldowns: the spells the cooldown frame tracks
    local function GetPool(isCooldowns)
        if not auraPool then
            auraPool = { spellIds = {}, icons = {} }
            for _, list in next, ns.data.spells do
                for spellId in next, list do
                    if type(spellId) == "number" then AddToPool(auraPool, spellId) end
                end
            end

            cooldownPool = { spellIds = {}, icons = {}, isCooldowns = true }
            for _, row in ipairs(ns.data.cooldowns) do
                if row.spellId then AddToPool(cooldownPool, row.spellId) end
            end
        end
        if isCooldowns and #cooldownPool.spellIds > 0 then
            return cooldownPool
        end
        return auraPool
    end

    -- every test aura is timed; sorted by expiration like the real frames
    local function Roll(pool, entry)
        local i = math.random(#pool.spellIds)
        local duration = pool.isCooldowns and math.random(10, 180) or math.random(5, 120)

        entry.spellId = pool.spellIds[i]
        entry.icon = pool.icons[i]
        entry.count = (not pool.isCooldowns and math.random(4) == 1) and math.random(2, 9) or ""
        entry.duration = duration
        entry.expirationTime = GetTime() + duration
        return entry
    end

    local function ByExpiration(a, b)
        return a.expirationTime < b.expirationTime
    end

    -- the button's OnUpdate hides it once its timer ends; give its entry a new spell and re-sort
    local function TestOnUpdate(button, elapsed)
        button:OnUpdate(elapsed)
        if not button:IsShown() then
            local element = button:GetParent()
            Roll(element.testPool, button.testEntry)
            element:RenderTest()
        end
    end

    function element_proto:RenderTest()
        local entries = self.testEntries
        table.sort(entries, ByExpiration)

        for i, entry in ipairs(entries) do
            local button = self[i]
            button.testEntry = entry
            button.spellId = entry.spellId
            button.expirationTime = entry.expirationTime
            button.Icon:SetTexture(entry.icon)
            button.Count:SetText(entry.count)
            button.Cooldown:SetCooldown(entry.expirationTime - entry.duration, entry.duration)
            button:SetScript("OnUpdate", TestOnUpdate)
            button:Show()
        end
    end

    function element_proto:SetTest(enabled)
        if enabled then
            local pool = GetPool(self.type == "Cooldowns")
            if #pool.spellIds == 0 then return end

            self.testing = true
            self.testPool = pool
            self.testEntries = {}
            if self.container then self.container:Hide() end

            for i = 1, self.limit do
                local button = self:AcquireButton(i)
                -- leftovers from real data
                button:SetSecret(false)
                button.auraInstanceID = nil
                button.itemId = nil
                button.slotId = nil
                button.Icon:SetDesaturated(false)
                button.Icon:Show()
                button.Cooldown:Show()
                button.Animation:Stop()
                if button.Backdrop then
                    ns.SetBorderColor(button.Backdrop, ns.config.general.backdrop.color)
                end

                self.testEntries[i] = Roll(pool, {})
            end

            self:RenderTest()
            self:SetPosition(1, self.limit)
        elseif self.testing then
            self.testing = nil
            self.testEntries = nil
            for i = 1, #self do
                self[i]:SetScript("OnUpdate", nil)
                self[i]:Hide()
            end
            if self.container then self.container:Show() end
            self:ForceUpdate()
        end
    end

    local function Spawn(key, data)
        -- "PLAYER_AURAS" -> "FilgerPlayerAuras"
        local name = key:lower():gsub("^%l", string.upper):gsub("_(%l)", string.upper)
        local element = Mixin(CreateFrame("Frame", Filger:GetName() .. name, Filger), element_proto)

        -- configuration
        element.type = data.type
        element.unit = data.unit or "player"
        element.filter = data.filter or "HELPFUL"

        element.limit = data.limit or 32
        element.size = data.size or 32
        element.spacing = data.spacing or 5
        element.initialAnchor = data.initialAnchor or "BOTTOMLEFT"
        element["growth-x"] = data["growth-x"] or "LEFT"
        element["growth-y"] = data["growth-y"] or "DOWN"

        element:SetPoint(unpack(data.anchor))
        element:SetWidth((element.limit * element.size) + (element.limit - 1) * element.spacing)
        element:SetHeight(element.size)

        element.spells = data.spells or {}

        -- "Auras" or "Cooldowns": the type's proto creates its state and registers its events
        Mixin(element, ns.elements[data.type])
        element:Enable(data)

        element:SetScript("OnEvent", function(self, event, ...)
            -- call event handler
            self[event](self, ...)
        end)
    
        return element
    end

    ns.element = {
        Spawn = Spawn
    }
end
