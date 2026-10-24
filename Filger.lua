local _, ns = ...
local Filger = ns.Filger

--------------------------------------------------
-- Filger
--------------------------------------------------
local isInit = false

Filger:RegisterEvent("ADDON_LOADED")
Filger:RegisterEvent("PLAYER_LOGIN")
Filger:SetScript("OnEvent", function(self, event, ...)
    if self[event] then
        -- call event handler
        self[event](self, ...)
    end
end)

function Filger:ADDON_LOADED(addon)
    if (addon ~= "Filger") then return end
    self.unit = "player"
    self.guid = UnitGUID(self.unit)

    -- Filger standalone
    if self.MergeAPI then
        self:MergeAPI()
    end
end

function Filger:PLAYER_LOGIN()
    if not isInit then
        -- self:RegisterEvent("PLAYER_ENTERING_WORLD")

        -- create panels based on spell list
        for key, data in pairs(self.config.frames) do
            if (data.enabled) then
                local element = self:Spawn(key, data)
                element:ForceUpdate()
                table.insert(self, element)
            end
        end

        isInit = true
    end
end
