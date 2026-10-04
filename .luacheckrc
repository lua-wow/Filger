std = 'lua51'

quiet = 1 -- suppress report output for files without warnings

unused_secondaries = false -- e.g. local name, _, itemLevel = GetItemInfo(...)

-- see https://luacheck.readthedocs.io/en/stable/warnings.html#list-of-warnings
-- and https://luacheck.readthedocs.io/en/stable/cli.html#patterns
exclude_files = {
    '.claude/**',
    'docs/**',
    'core/development.lua', -- dev-only helpers
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

-- data files keep the full expansion ladder for authoring entries
files['data/shared/blacklist.lua'] = { ignore = { '211/LE_EXPANSION_.*' } }
files['data/shared/cooldowns.lua'] = { ignore = { '211/LE_EXPANSION_.*' } }

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
    'C_Spell',
    'C_UnitAuras',

    -- constants
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
    'GetItemCooldown',
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
