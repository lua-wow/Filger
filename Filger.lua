local _, ns = ...
local Filger = ns.Filger

--------------------------------------------------
-- Filger
--------------------------------------------------
local isInit = false
local spawned = {}

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

    -- order matters: config reads the validated data
    ns.data.Finalize()
    ns.BuildConfig()
end

function Filger:PLAYER_LOGIN()
    if not isInit then
        -- self:RegisterEvent("PLAYER_ENTERING_WORLD")

        -- create panels based on spell list
        for key, data in pairs(ns.config.frames) do
            if (data.enabled) then
                local element = ns.element.Spawn(key, data)
                element:ForceUpdate()
                table.insert(spawned, element)
            end
        end

        isInit = true
    end
end
