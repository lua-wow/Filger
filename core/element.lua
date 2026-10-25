local _, ns = ...
local Filger = ns.Filger
local CreateButton = ns.button.Create

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

    local function Spawn(key, data)
        -- "PLAYER_AURAS" -> "FilgerPlayerAuras"
        local name = key:lower():gsub("^%l", string.upper):gsub("_(%l)", string.upper)
        local element = Mixin(CreateFrame("Frame", Filger:GetName() .. name, Filger), element_proto)

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
