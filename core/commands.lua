local _, ns = ...
local Filger = ns.Filger
local Config = ns.Config
local SpellList = ns.SpellList

----------------------------------------------------------------
-- Commands
----------------------------------------------------------------
-- import
local tinsert, tsort = table.insert, table.sort

-- string formats
local STRING_COLOR = "|cffb3ff19%s|r"   --"|cff00ff96%s|r"

local function CmdSplit(cmd)
    if (cmd:find("%s")) then
        return strsplit(" ", cmd)
    end
    return cmd
end

SLASH_FILGER1 = "/filger"
SlashCmdList["FILGER"] = function(cmd)
    local arg1, arg2 = CmdSplit(cmd)
    
    if (arg1 == "test") then
        -- local class = Filger.MyClass
        
        for index, frame in ipairs(Filger) do
            -- local frame = Filger[index]
            for _, data in ipairs(frame.spells) do
                local name, icon, start, duration, expirationTime
                if (not frame.actives) then
                    frame.actives = {}
                end

                if (data.spellID) then
                    name, _, icon = GetSpellInfo(data.spellID)
                elseif (data.slotID) then
                    local slotLink = GetInventoryItemLink("player", data.slotID)
                    if (slotLink) then
                        name, _, _, _, _, _, _, _, _, icon = GetItemInfo(slotLink)
                    end
                end

                if (name) then

                    start = GetTime()
                    duration = math.random(15, 60)
                    expirationTime = start + duration

                    tinsert(frame.actives, {
                        spellID = data.spellID,
                        slotID = data.slotID,
                        caster = data.caster,
                        filter = data.filter,
                        name = name,
                        icon = icon,
                        count = 0,
                        caster = "player",
                        debuffType = false,
                        isPlayer = true,
                        isBossDebuff = false,
                        start = start,
                        duration = duration,
                        expirationTime = expirationTime, 
                    })

                    -- sort by expiration time
                    tsort(frame.actives, function(a, b)
                        if (a.expirationTime == b.expirationTime) then
                            return a.name < b.name
                        end
                        return a.expirationTime < b.expirationTime
                    end)

                    Filger.DisplayActives(frame)
                end
            end
        end
    elseif (arg1 == "show") then
        for index, frame in ipairs(Filger) do
            frame.Backdrop:Show()
            frame.text:Show()
        end
    elseif (arg1 == "hide") then
        for index, frame in ipairs(Filger) do
            frame.Backdrop:Hide()
            frame.text:Hide()
        end
    elseif (arg1 == "") or (arg1 == "help") then
        print(" ")
        print(STRING_COLOR:format("Filger Commands:"))
        print(STRING_COLOR:format("test:"), "Test Filger.")
        print(STRING_COLOR:format("show:"), "Display Frames.")
        print(STRING_COLOR:format("hide:"), "Hide Frames.")
        print(" ")
    end
end