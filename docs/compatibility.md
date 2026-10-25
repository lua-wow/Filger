# Compatibility

Authoritative for clients, TOC loading, libraries, runtime checks and secret values. Other docs
link here instead of repeating these facts.

## Supported clients

One `Filger.toc` serves every client (`## Interface: 11509, 20506, 38002, 50504, 120105, 16001`):

| Client          | Interface | Game type / `[Game]`  | Family     | Flag                  |
|:----------------|:----------|:----------------------|:-----------|:----------------------|
| Retail/Midnight | `120105`  | `standard` `Standard` | `mainline` | `isStandard`          |
| Classic Forever | `16001`   | `camelot` `Camelot`   | `mainline` | `isCamelot`           |
| Classic Era     | `11509`   | `vanilla` `Vanilla`   | `classic`  | `isVanilla`           |
| Classic TBC     | `20506`   | `tbc` `TBC`           | `classic`  | `isTBC`               |
| Classic WotLK   | `38002`   | `wrath` `Wrath`       | `classic`  | `isWrath`             |
| Classic MoP     | `50504`   | `mists` `Mists`       | `classic`  | `isMists`             |

- WotLK is Titan 3.80.x (`WOW_PROJECT_WRATH_CLASSIC`), not the retired 3.4.x Wrath Classic.
- Cata is dropped from the TOC. `data/Cata/` and `ns.client.isCata` remain; Cata behavior is
  **unverified** (no `../refs` source covers it).

## TOC rules

- Never add `Filger_*.toc`: a suffixed TOC overrides `Filger.toc` on its client.
- Untagged lines load everywhere. Client-specific lines use `[AllowLoadGameType ...]` with a
  family or game type token. Keep one ordered list.
- Retail is `standard`, not `mainline`: `mainline` includes `camelot`.
- Unrecognized tokens count as satisfied, and only Forever is known to recognize `camelot`. Lines
  allowing `camelot` must also exclude every other client by its own token
  (e.g. `[ExcludeLoadGameType tbc, wrath, mists, standard]`).
- `core\compat.lua` and `core\util.lua` load first (Blizzard globals only), so `core\data.lua`
  can use them at load.
- Data is loaded before `core\init.xml` via `data\[Game]\<file>.lua`; every `[Game]` folder must
  contain every listed file (stubs are fine). `data/shared/` loads everywhere, gated by
  `LE_EXPANSION_LEVEL_CURRENT`. `[Family]` is too coarse for spell data.
- `## Title` is one untagged line.

## Libraries

Git submodules in `libs/`: `LibStub` (loaded by `libs/init.xml`, every client) and `LibDispel`
(its own TOC line, `[AllowLoadGameType classic]`; only `elements/Classic/auras.lua` uses it).

## Runtime client checks

Flags in `core/init.lua` (`ns.client`) compare `WOW_PROJECT_ID` (see table). `ns.client.isClassic`
is any `classic` family client; `ns.client.isMainline` is its negation (Retail and Forever).

## Secret values (Midnight / Retail)

- Secret values allow no arithmetic, comparison, string operations or use as table keys.
- Before using an API result in logic, check the target client's
  `Blizzard_APIDocumentationGenerated` ([reference-repositories.md](reference-repositories.md));
  APIs and secret flags differ per client. If unsure, say so.
- Most affected: aura scanning (`C_UnitAuras`, `UnitAuraInfo`) and cooldowns
  (`C_Spell.GetSpellCooldown`, `GetItemCooldown`). Audit before fixing.
- Secret checks live in `core/compat.lua` (`ns.compat.AurasSecret`, `SpellAuraSecret`,
  `SpellCooldownSecret`, `IsSecret`), resolved once at load; they return false where the API is
  missing. Don't call `C_Secrets`/`issecretvalue` elsewhere (`dev/` excepted).
