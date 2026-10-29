# Reference repositories

Local clones in `../refs`, outside this repo. **Read-only**: never edit, and no git write operations.
Pick the worktree matching the client, then search it with targeted `Grep`/`Glob` scoped to one
addon and flavor dir; no recursive listings or whole-repo reads. Secondary source, after Blizzard
code: `https://warcraft.wiki.gg/wiki/API:[NAME]` and `https://warcraft.wiki.gg/wiki/Event:[NAME]`.

## `wow-ui-source` (Blizzard UI; authoritative)

| Path (`../refs/wow-ui-source/...`) | Branch                | Client          |
|------------------------------------|-----------------------|-----------------|
| `.`                                | `live`                | Retail/Midnight |
| `worktrees/forever`                | `forever`             | Classic Forever |
| `worktrees/classic`                | `classic`             | MoP Classic     |
| `worktrees/classic_titan`          | `classic_titan`       | WotLK (Titan)   |
| `worktrees/classic_anniversary`    | `classic_anniversary` | TBC Anniversary |
| `worktrees/classic_era`            | `classic_era`         | Classic Era     |

Each worktree's build is in its `version.txt`.

- Code lives in `Interface/AddOns/Blizzard_<Name>/<Flavor>/`. Flavor dirs: `Shared`,
  `Mainline`, `Classic`, `Vanilla`, `TBC`, `Wrath`, `Cata`, `Mists` (`Camelot` in forever).
  Every classic-family worktree contains all flavor dirs: don't infer the client from the dir.
  Instead read the per-flavor TOC (`*_Classic.toc`, `*_Mainline.toc`): each file line is tagged
  `[AllowLoadGameType vanilla|tbc|wrath|cata|mists]`.
- API truth: `Interface/AddOns/Blizzard_APIDocumentationGenerated/*Documentation.lua`
  (check every worktree; APIs and secret flags differ per client).
- Removed/renamed APIs: `Interface/AddOns/Blizzard_Deprecated*`.
- Index of all addons/files: `Interface/ui-toc-list.txt`, `Interface/ui-code-list.txt`.

## Where to look, by Filger feature

| Feature   | Blizzard (`Interface/AddOns/...`)                                                                              |
|-----------|----------------------------------------------------------------------------------------------------------------|
| Auras     | `Blizzard_BuffFrame`, `Blizzard_AuraContainer` (retail), `Blizzard_PrivateAurasUI`; `C_UnitAuras` in API docs |
| Cooldowns | `Blizzard_CooldownViewer` (retail); `C_Spell.GetSpellCooldown` / `GetItemCooldown` in API docs                 |
| Spell API | `C_Spell` vs legacy `GetSpellInfo` in API docs and `Blizzard_Deprecated*`                                      |
| Tooltips  | `Blizzard_GameTooltip` (`GameTooltip:SetUnitAura`)                                                             |

## `../spellbook` (spell DB2 data and checks)

A separate tool, not part of Filger. Don't edit it unless asked. It caches Blizzard's spell DB2
tables from wago.tools per client build in `../spellbook/data/<build>/` and merges them into
`spells.csv` (`ID,Name,Subtext,Class,Learnable,Dispel,Cooldown,CategoryCooldown,Charges,ChargeRecovery,Labels,Description`).
Use it to verify spell IDs offline instead of relying on memory. Usage is in `../spellbook/README.md`.

```sh
lua ../spellbook/check.lua [Game ...]       # run from Filger's root: MISSING / NAME / NOCD / CLASS
lua ../spellbook/check.lua --cooldowns      # learnable spells with a cooldown > 30s not in cooldowns.lua (CSV)
```

- Clients map to builds by version prefix in the `clients` table at the top of `check.lua`.
  A missing build is downloaded (network); use the cached `data/` when it is enough.
- To look up a single ID: `grep '^<id>,' ../spellbook/data/<build>/spells.csv`.
- Caveats: an ID present in DB2 isn't necessarily obtainable (Retail keeps many removed spells).
  `Learnable` has false negatives (for example Retail Barkskin = 0) and is sparse on Era and
  Forever, so `1` is evidence and `0` is not. A Retail `Cooldown` of 0 doesn't prove there is no
  cooldown. Treat DB2-only conclusions as **unverified** until they're checked in-game.
