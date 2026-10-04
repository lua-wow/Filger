# Compatibility

Authoritative for supported clients, TOC loading, libraries, runtime client checks and secret
values. Other docs link here instead of repeating these facts.

## Supported clients

A single `Filger.toc` serves every supported client (`## Interface: 11509, 16001, 20506, 38002, 40402, 50504, 120100`):

| Client          | Interface | Game type  | Family     |
|:----------------|:----------|:-----------|:-----------|
| Retail/Midnight | `120100`  | `standard` | `mainline` |
| Classic Forever | `16001`   | `camelot`  | `mainline` |
| Classic Era     | `11509`   | `vanilla`  | `classic`  |
| Classic TBC     | `20506`   | `tbc`      | `classic`  |
| Classic WotLK   | `38002`   | `wrath`    | `classic`  |
| Classic Cata    | `40402`   | `cata`     | `classic`  |
| Classic MoP     | `50504`   | `mists`    | `classic`  |

- WotLK is Titan 3.80.x (loads the `Wrath` flavor with `WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC`),
  not the retired 3.4.x Wrath Classic. Don't assume 3.4.x behavior.
- Cata `40402` (4.4.2) is **unverified**: no `wow-ui-source` worktree or addon reference in
  `../refs` covers Cata. The `cata` game type token does appear in Blizzard TOCs.

## TOC rules

- Do not add client-specific TOCs (`Filger_*.toc`); a suffixed TOC overrides `Filger.toc` on its client.
- Untagged lines load on every client. Client-specific files are tagged with
  `[AllowLoadGameType ...]`, using the family (`mainline`, `classic`) or game types
  (`standard`, `camelot`, `vanilla`, `tbc`, `wrath`, `cata`, `mists`). Keep one ordered list.
- Data lives in `data/`, loaded before `core\init.xml` through the TOC `[Game]` variable
  (`data\[Game]\spells.lua`, …), which expands to the client's game type folder: `Standard`,
  `Camelot`, `Vanilla`, `TBC`, `Wrath`, `Cata`, `Mists`. Every folder must contain every listed
  file (stubs are fine). `data/shared/` holds data for every client, gated by
  `LE_EXPANSION_LEVEL_CURRENT`. `[Family]` (`Mainline`/`Classic`) is too coarse for spell data.
- Retail is `standard`, not `mainline`: the `mainline` family includes `camelot`.
- Lines allowing `camelot` also exclude every other client by its own token
  (e.g. `[ExcludeLoadGameType tbc, wrath, cata, mists, standard]`), because only Forever is known
  to recognize `camelot`.
- A condition whose tokens the client doesn't recognize is treated as satisfied. A `camelot`-only
  line would therefore also need `[ExcludeLoadGameType standard, classic]`.
- Per-game metadata (`## Title`) uses the same `[AllowLoadGameType ...]` suffix.

## Libraries

`libs/*` are git submodules, loaded through `libs/init.xml`: `LibStub`, `LibDispel`.
`CallbackHandler-1.0` and `LibClassicDurations` are present but commented out (not loaded);
`core/init.lua` only uses `LibClassicDurations` if it happens to be registered.

## Runtime client checks

Flags from `WOW_PROJECT_ID` in `core/init.lua`: `Filger.isStandard`, `Filger.isVanilla`,
`Filger.isTBC`, `Filger.isWrath`, `Filger.isCata`, `Filger.isMists`.

- There is no Classic Forever flag. Forever sets `WOW_PROJECT_ID = WOW_PROJECT_CAMELOT` (18)
  (`Blizzard_ProjectConstants/Camelot/ProjectConstants.lua`), so every flag is false there.

## Secret values (Midnight / Retail)

- Some APIs return "secret" values: no arithmetic, comparison, string operations or table keys
  on them.
- Before using an API result in logic, check the generated API docs
  (`Blizzard_APIDocumentationGenerated`, see [reference-repositories.md](reference-repositories.md))
  for the target client; APIs and secret flags differ per client.
- If unsure whether a function returns secrets or is restricted, say so. Don't guess.
- Aura scanning (`C_UnitAuras`, `UnitAuraInfo` fields) and spell/item cooldowns
  (`C_Spell.GetSpellCooldown`, `GetItemCooldown`) are the most likely to be affected. Audit before fixing.
