local _, ns = ...
local Filger = ns.Filger
local Config = ns.Config
local SpellList = ns.SpellList

----------------------------------------------------------------
-- Commands
----------------------------------------------------------------
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
        local class = Filger.MyClass
        
        for index, data in ipairs(SpellList[class]) do
            local frame = Filger[index]
            for _, value in ipairs(frame.spells) do
                local name, icon, start, duration, expirationTime
                if (not frame.actives) then
                    frame.actives = {}
                end

                if (value.spellID) then
                    name, _, icon = GetSpellInfo(value.spellID)
                elseif (value.slotID) then
                    local slotLink = GetInventoryItemLink("player", value.slotID)
                    if (slotLink) then
                        name, _, _, _, _, _, _, _, _, icon = GetItemInfo(slotLink)
                    end
                end

                if (name) then

                    start = GetTime()
                    duration = math.random(15, 180) * index / #data
                    expirationTime = start + duration

                    tinsert(frame.actives, {
                        data = value,
                        name = name,
                        icon = icon,
                        count = 0,
                        caster = "player",
                        debuffType = false,
                        isPlayer = false,
                        isBossDebuff = false,
                        start = start,
                        duration = duration,
                        expirationTime = expirationTime, 
                    })

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
    elseif (arg1 == "help") then
        print("Filger Commands:")
        print("[test]: start test mode.")
    end
end