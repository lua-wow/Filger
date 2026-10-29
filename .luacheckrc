std = 'lua51'

quiet = 1 -- suppress report output for files without warnings

unused_secondaries = false -- e.g. local name, _, itemLevel = GetItemInfo(...)

-- see https://luacheck.readthedocs.io/en/stable/warnings.html#list-of-warnings
-- and https://luacheck.readthedocs.io/en/stable/cli.html#patterns
exclude_files = {
    '.claude/**',
    'docs/**',
    'dev/development.lua', -- dev-only helpers
    'libs/**', -- submodules
}

ignore = {
    '212', -- unused argument (callback signatures)
    '213', -- unused loop variable
    '431', -- shadowing an upvalue
    '432/self', -- shadowing upvalue argument self (nested methods)
    '611', -- line contains only whitespace
    '612', -- line contains trailing whitespace
    '614', -- trailing whitespace in comment
    '631', -- line is too long
}

-- globals Filger is allowed to set or mutate
globals = {
    -- slash commands
    'SLASH_FILGER1',
    'SlashCmdList',
}

read_globals = {
    string = {fields = {'split'}},
    table = {fields = {'wipe'}},

    -- namespaces
    'C_AddOns',
    'C_Container',
    'C_Item',
    'C_Spell',
    'C_SpellBook',
    'C_UnitAuras',

    -- constants
    'LE_EXPANSION_BATTLE_FOR_AZEROTH',
    'LE_EXPANSION_BURNING_CRUSADE',
    'LE_EXPANSION_CATACLYSM',
    'LE_EXPANSION_CLASSIC',
    'LE_EXPANSION_DRAGONFLIGHT',
    'LE_EXPANSION_LEGION',
    'LE_EXPANSION_LEVEL_CURRENT',
    'LE_EXPANSION_MIDNIGHT',
    'LE_EXPANSION_MISTS_OF_PANDARIA',
    'LE_EXPANSION_SHADOWLANDS',
    'LE_EXPANSION_WAR_WITHIN',
    'LE_EXPANSION_WARLORDS_OF_DRAENOR',
    'LE_EXPANSION_WRATH_OF_THE_LICH_KING',
    'WOW_PROJECT_BURNING_CRUSADE_CLASSIC',
    'WOW_PROJECT_CAMELOT',
    'WOW_PROJECT_CATACLYSM_CLASSIC',
    'WOW_PROJECT_CLASSIC',
    'WOW_PROJECT_ID',
    'WOW_PROJECT_MAINLINE',
    'WOW_PROJECT_MISTS_CLASSIC',
    'WOW_PROJECT_WRATH_CLASSIC',

    -- API and FrameXML
    'AuraUtil',
    'CreateColor',
    'CreateFrame',
    'Display_DisplayModeDropDown',
    'EnumerateFrames',
    'GameTooltip',
    'GetBuildInfo',
    'GetCVar',
    'GetPhysicalScreenSize',
    'GetTime',
    'LibStub',
    'Mixin',
    'UIParent',
    'UnitCanAssist',
    'UnitCanAttack',
    'UnitClass',
    'UnitGUID',
    'UnitName',
}
