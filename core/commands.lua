local _, ns = ...
local Filger = ns.Filger

-- Blizzard
local C_Secrets = _G.C_Secrets

------------------------------------------------------------
-- Slash Commands
------------------------------------------------------------
local commands = {}

SLASH_FILGER1 = "/filger"
SlashCmdList["FILGER"] = function(cmd)
    local msg = cmd:gsub("^ +", "")
    local command, arg = string.split(" ", msg, 2)
    arg = arg and arg:gsub(" ", "")
    
    -- empty or unknown command: show help
    local entry = commands[command] or commands["help"]
    entry.func(arg)
end

function Filger:AddCommand(command, handler, description)
    commands[command] = {
        func = handler,
        description = description
    }
end

local help = function()
    for cmd, v in next, commands do
        if (v.description) then
            print(Filger.title, "|cffff8000" .. cmd .. "|r", "-", v.description)
        end
    end
end

Filger:AddCommand("help", help, "list commands")

-- lists the unit's own auras with their spell IDs, to fill data/<Game>/spells.lua
-- usage: /filger auras player buffs (arg arrives without spaces: "playerbuffs")
local auras = function(arg)
    local unit, kind = (arg or ""):match("^(%a-)(d?e?buffs)$")
    if not unit or unit == "" or (kind ~= "buffs" and kind ~= "debuffs") then
        print(Filger.title, "usage: /filger auras <player|target|focus> <buffs|debuffs>")
        return
    end

    -- tainted code can't read secret auras (in combat on Retail), GetAuraSlots would error
    if C_Secrets and C_Secrets.ShouldAurasBeSecret() then
        print(Filger.title, "auras are secret right now, leave combat and try again.")
        return
    end

    local filter = ((kind == "buffs") and "HELPFUL" or "HARMFUL") .. "|PLAYER"
    for _, slot in ipairs({ select(2, C_UnitAuras.GetAuraSlots(unit, filter)) }) do
        local data = C_UnitAuras.GetAuraDataBySlot(unit, slot)
        if data then
            print(Filger.title, data.spellId, data.name)
        end
    end
end

Filger:AddCommand("auras", auras, "list your auras on a unit with their spell IDs (/filger auras player buffs)")
