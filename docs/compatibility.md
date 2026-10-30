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
- Data is loaded after `core\init.xml` (it needs `ns.client`) via `data\[Game]\<file>.lua`; every
  `[Game]` folder must contain every listed file (stubs are fine). `data/shared/` loads everywhere,
  gated by `ns.client.expansion` (`LE_EXPANSION_LEVEL_CURRENT`) against `ns.expansions`.
  `[Family]` is too coarse for spell data.
- `## Title` is one untagged line.

## Blacklist data

- An ID listed for two or more games whose games form one range on
  Vanilla → TBC → Wrath → Mists → Standard goes in the `general` table of
  `data/shared/blacklist.lua` as `[id] = In(LE.<from>, LE.<to>)` (`to` omitted: up to the current
  expansion). Retail additions stay in the `if EXPANSION >= LE.<X>` blocks.
- Otherwise (one game, or games that don't form one range) it stays in `data/<Game>/blacklist.lua`.
- Forever (expansion 0) inherits every shared range starting at `LE.Classic`. Era-only content
  (Hardcore, Season of Discovery) stays in `data/Vanilla/`. `data/Cata/` is not maintained.
- `"name"` also hides every aura with the same localized name. Use it where a game lists only
  rank 1 (TBC, Wrath) or every rank (Vanilla); use `true` from Mists on, where `"name"` would
  catch unrelated auras. An ID whose value differs by range is one expression:
  `In(LE.Classic, LE.Wrath) and "name" or In(LE.Mists, LE.Mists)`.
- `false` never un-hides an ID that another source hides; write "everywhere except X" as a range.
- After moving IDs, `lua tests/dump.lua | diff before.txt -` must be empty unless the change is
  intended; in game, compare `/filger dump`.

## Libraries

Git submodules in `libs/`: `LibStub` (loaded by `libs/init.xml`, every client) and `LibDispel`
(its own TOC line, `[AllowLoadGameType classic]`; only `elements/Classic/auras.lua` uses it).

## Runtime client checks

Flags in `core/init.lua` (`ns.client`) compare `WOW_PROJECT_ID` (see table). `ns.client.isClassic`
is any `classic` family client; `ns.client.isMainline` is its negation (Retail and Forever).

`ns.client.expansion` is `LE_EXPANSION_LEVEL_CURRENT`; `ns.expansions` holds the `LE_EXPANSION_*`
constants. Verified in-game: every `LE_EXPANSION_*` constant exists on every supported client, and
`LE_EXPANSION_LEVEL_CURRENT` is 0 on Era and Forever, 1 on TBC, 2 on Titan, 4 on MoP and 11 on Retail.

## Secret values (Midnight / Retail)

- Secret values allow no arithmetic, comparison, string operations or use as table keys.
- Before using an API result in logic, check the target client's
  `Blizzard_APIDocumentationGenerated` ([references.md](references.md));
  APIs and secret flags differ per client. If unsure, say so.
- Most affected: aura scanning (`C_UnitAuras`, `UnitAuraInfo`) and cooldowns
  (`C_Spell.GetSpellCooldown`, `GetItemCooldown`). Audit before fixing.
- Secret checks live in `core/compat.lua` (`ns.compat.AurasSecret`, `SpellAuraSecret`,
  `SpellCooldownSecret`, `IsSecret`), resolved once at load; they return false where the API is
  missing. Don't call `C_Secrets`/`issecretvalue` elsewhere (`dev/` excepted).
