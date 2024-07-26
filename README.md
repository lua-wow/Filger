# Filger

Filger is a minimalistic aura tracker addon for [World of Warcraft](https://worldofwarcraft.com/en-us/).

It allows you to keep track of any buffs/debuffs of all units (`player`, `target`, `focus`, etc.)

It also track player's spells cooldown and item cooldowns.

<p align="center">
    <img src="docs/screenshot.png" alt="Filger" title="Filger example" width="800" />
</p>

## Dependencies

-   Required: `None`
-   Optional:
    -   [Tainted](https://github.com/lua-wow/Tainted)
    -   [Tukui](https://github.com/tukui-org/Tukui)

## Installation

1.  Download the latest version of [**Filger**](https://github.com/lua-wow/Filger/releases)
2.  Backup your **Interface** and **WTF** folders.
3.  Delete **Cache** and **WTF** folders for a clean install.
4.  Copy/Paste **Filger** folder into WoW interface folder (`World of Warcraft/_retail_/Interface/AddOns`)
5.  Now you are ready to start World of Warcraft.

## Configuration

The addon configuration can be done by editing the [config.lua](./core/config.lua) file.

```lua
local config = {
    frames = {
        ["PLAYER_COOLDOWNS"] = {
            enabled = true,
            unit = "player",
            filter = "COOLDOWN",
            caster = "player",
            anchor = { "CENTER", UIParent, "BOTTOM", 0, 259 },
            limit = 8,
            size = 38,
            max_size = 40,
            spacing = 3,
            initialAnchor = "CENTER",
            ["growth-x"] = "CENTER",
            ["growth-y"] = "CENTER",
            spells = {
                { spellId = 586, enabled = true },      -- Fade (Rank 1)
            }
        }
    }
}
```

> **obs.:** The addon do not have a in-game configuration.

## License:

Please, see [LICENSE](./LICENSE) file.
