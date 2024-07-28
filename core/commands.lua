local _, ns = ...
local Filger = ns.Filger

------------------------------------------------------------
-- Slash Commands
------------------------------------------------------------
local commands = {}

SLASH_FILGER1 = "/filger"
SlashCmdList["FILGER"] = function(cmd)
    local msg = cmd:gsub("^ +", "")
    local command, arg = string.split(" ", msg, 2)
    arg = arg and arg:gsub(" ", "")
    
    if commands[command] then
        commands[command].func(arg)
    end
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

Filger:AddCommand("help", help)
