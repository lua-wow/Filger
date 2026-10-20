# Reference repositories

Local clones in `../refs`, outside this repo. **Read-only**: never edit, and no git write operations.
Use them when investigating WoW API, UI, template, event or compatibility behavior.

- Search, don't browse: targeted `Grep`/`Glob` scoped to one repo, addon and flavor dir.
  No recursive listings or whole-repo reads.
- Pick the worktree that matches the client in question before searching.

## Authority

**`wow-ui-source`** (Blizzard's own UI source) is the only reference and is authoritative for
how Blizzard UI and APIs actually work. Never invent an API; if it can't be verified, mark it
"unverified". Wiki (after Blizzard source): `https://warcraft.wiki.gg/wiki/API:[NAME]`
(e.g. `C_Spell.GetSpellInfo`) and `https://warcraft.wiki.gg/wiki/Event:[NAME]` (e.g. `PLAYER_LOGIN`).

## `wow-ui-source` (Blizzard UI; authoritative)

| Path (`../refs/wow-ui-source/...`) | Branch                | Version (`version.txt`) | Client                       |
|------------------------------------|-----------------------|-------------------------|------------------------------|
| `.`                                | `live`                | 12.1.0                  | Retail/Midnight              |
| `worktrees/forever`                | `forever`             | 1.60.1                  | Classic Forever              |
| `worktrees/classic`                | `classic`             | 5.5.4                   | MoP Classic                  |
| `worktrees/classic_titan`          | `classic_titan`       | 3.80.2                  | WotLK (Titan)                |
| `worktrees/classic_anniversary`    | `classic_anniversary` | 2.5.6                   | TBC Anniversary              |
| `worktrees/classic_era`            | `classic_era`         | 1.15.9                  | Classic Era                  |

No worktree covers Cata (`40402`); Cata API behavior is unverified.

- Code lives in `Interface/AddOns/Blizzard_<Name>/<Flavor>/`. Flavor dirs: `Shared`,
  `Mainline`, `Classic`, `Vanilla`, `TBC`, `Wrath`, `Cata`, `Mists` (`Camelot` in forever).
  Every classic-family worktree contains all flavor dirs: don't infer the client from the dir.
  Instead read the per-flavor TOC (`*_Classic.toc`, `*_Mainline.toc`): each file line is tagged
  `[AllowLoadGameType vanilla|tbc|wrath|cata|mists]`.
- `classic_titan` is Filger's WotLK target (see [compatibility.md](compatibility.md)).
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
