local _, ns = ...
local Filger = ns.Filger

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
            button = Filger:CreateButton(self, index)
            table.insert(self, button)
        end
        return button
    end

    function element_proto:Render(unit, sorted, compare)
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

    function Filger:Spawn(key, data)
        -- "PLAYER_AURAS" -> "FilgerPlayerAuras"
        local name = key:lower():gsub("^%l", string.upper):gsub("_(%l)", string.upper)
        local element = Mixin(CreateFrame("Frame", self:GetName() .. name, self), element_proto)

        -- configuration
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
    
        if (data.type == "cooldowns") then
            element = Mixin(element, ns.cooldown_proto)
            
            -- overrider element functions with configurations
            element.SortCooldowns = data.SortCooldowns or element.SortCooldowns
            element.FilterCooldown = data.FilterCooldown or element.FilterCooldown

            element.casted = {}
            element.active = {}

            element:RegisterEvent("SPELL_UPDATE_COOLDOWN")
            element:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", self.unit)
        elseif (data.type == "container") then
            -- Mainline only: Blizzard's secure aura container filters and displays the auras
            element = Mixin(element, ns.container_proto)
            element:CreateContainer(data)
        elseif (data.type == "auras") then
            element = Mixin(element, ns.aura_proto)

            -- overrider element functions with configurations
            element.SortAuras = data.SortAuras or element.SortAuras
            element.FilterAura = data.FilterAura or element.FilterAura

            element:RegisterEvent("UNIT_AURA")

            if (element.unit == "target") then
                element:RegisterEvent("PLAYER_TARGET_CHANGED")
            end

            if (element.unit == "focus") then
                element:RegisterEvent("PLAYER_FOCUS_CHANGED")
            end
        end

        element.spells = data.spells or {}
    
        element:SetScript("OnEvent", function(self, event, ...)
            -- call event handler
            self[event](self, ...)
        end)
    
        return element
    end
end
