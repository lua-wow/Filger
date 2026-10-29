# Blacklist consolidation plan

## 1. Summary

**Problem:** every `data/<Game>/blacklist.lua` repeats IDs that other games also list. The 660
entries across the game files hold only 339 distinct IDs, and the copies have drifted (15 IDs
differ between `true` and `"name"`).

**Goal:** IDs that two or more games use move into `data/shared/blacklist.lua`, each gated by the
expansion range it applies to. IDs used by one game stay in that game's file. The final blacklist
of every client must stay identical, except for changes that are explicitly decided.

**Scope:**
- Blacklist only. Class cooldowns stay in `data/<Game>/cooldowns.lua`, because classes and builds
  change often per game. `data/shared/cooldowns.lua` keeps only racials and gear slots.
- `data/Cata/` is not touched: its data has gaps and its client is dropped. `data/Camelot/` was
  first out of scope, then Forever was decided to inherit Vanilla (see B7).
- `spells.lua` is not merged: only 4 IDs are shared between games.

## 2. Facts

- Verified in-game: every `LE_EXPANSION_*` constant exists on every supported client.
  `LE_EXPANSION_LEVEL_CURRENT` is 0 on Era and Forever, 1 on TBC, 2 on Titan, 4 on MoP and 11 on
  Retail. MoP `GetBuildInfo()` reports interface 50504.
- Shared data is gated by `ns.client.expansion` against `ns.expansions` (`core/init.lua`). Data
  files load after `core\init.xml`.
- On the line Vanilla → TBC → Wrath → Mists → Standard, 336 of 337 blacklist IDs can be written as
  a single from/to range.
- A `false` entry never un-hides an ID that another source hides (`core/data.lua`). "Hidden
  everywhere except one game" is written as a range in shared, or kept in game files.
- A table literal can hold a key once, so an ID whose value changes by game needs one expression
  or stays in the game files.
- Baseline before any data moves: no Lua errors and `/filger validate` reports nothing on every
  client.

## 3. Tasks

- [x] **B1: Verify version values in-game**
  - `/dump LE_EXPANSION_LEVEL_CURRENT` and the `LE_EXPANSION_*` constants on every client.

- [x] **B2: Move `LE_EXPANSION_*` into `core/init.lua`**
  - `ns.expansions` (`Classic`, `BurningCrusade`, `Wrath`, ...) and `ns.client.expansion`. The
    per-file constants and `or N` fallbacks are gone. Data lines in the TOC moved after
    `core\init.xml`. `.luacheckrc` and `docs/compatibility.md` are updated.
  - Verify: `make check`. `tests/dump.lua` output equals HEAD's. `/reload` on every client with
    no Lua errors.

- [x] **B3: Offline diff tool `tests/dump.lua`**
  - Loads the real `core/` and data files in TOC order for every game and class, runs
    `Finalize()`, and prints one sorted line per blacklist, cooldown and spell entry, plus
    duplicates. Every spell ID counts as valid.
  - Usage: `lua tests/dump.lua > before.txt`, then after a change
    `lua tests/dump.lua | diff before.txt -`. `lua tests/dump.lua <root>` dumps another tree, for
    example one extracted with `git archive HEAD core data`.

- [x] **B4: Range helper**
  - Added `data.In(from, to)` (inclusive; `to` optional) in `core/data.lua`. The per-line
    expressions in `data/shared/blacklist.lua` use it; the `if EXPANSION >= ...` section blocks
    stay as they are.
  - Example: `[5232] = In(LE.Classic, LE.Wrath)`, `[1126] = In(LE.Classic) and "name"`.
  - Verify: `make check`, `make test` (test for `In`), the dump diff is empty.

- [x] **B5: `/filger dump` dev command**
  - Added to `dev/development.lua` (needs `config.general.dev`). Prints the count and a checksum
    of `ns.data.blacklist` IDs and names (sorted, so table order doesn't matter), and of
    `ns.data.cooldowns` for the logged-in class (in display order). Name checksums depend on
    the client locale.
  - Run it on every client before B7 and keep the output as the in-game baseline.
  - Baseline (counts match `tests/dump.lua`):

    | Client | Blacklist IDs | Names | Cooldowns |
    |---|---|---|---|
    | Era | 182 `696d85c1` | 22 `77a82863` | PRIEST 54 `03c48323` |
    | TBC | 172 `572f1d78` | 26 `3d81834a` | PRIEST 51 `1bd08cf3` |
    | Titan | | | |
    | MoP | 145 `493a032a` | 5 `2da120bc` | MONK 35 `6c84802e` |
    | Retail | 332 `4660bdc8` | 5 `703b18bb` | MONK 47 `74962055` |
    | Forever | | | |

- [x] **B6: Decide the 15 conflicting IDs**
  - Decided: `"name"` on Vanilla, TBC and Wrath; `true` on Mists. The conflicts come from ranks.
    TBC and Wrath list only rank 1 and need `"name"`. Vanilla lists every rank. Mists has no ranks,
    and on MoP `"name"` would also hide other auras with the same name (the DB2 has 36 Lightning
    Shield and 20 Battle Shout IDs).
  - Applied: Vanilla 21849, 23028, 168, 7302, 6117, 25782, 25894 and Wrath 21084 changed from
    `true` to `"name"`. In B7, the 9 IDs that Mists lists use
    `In(LE.Classic, LE.Wrath) and "name" or In(LE.Mists, LE.Mists)`.
  - The Era names in the B5 baseline went from 15 `22c6c349` to 22 `77a82863`, as expected.
  - For each one, choose unify on `"name"`, unify on `true`, or keep the per-game value.
    `"name"` also hides every aura with the same localized name; that only matters on
    Classic-family clients (Era, TBC, Titan, MoP).

    | ID | Spell | `"name"` in | `true` in |
    |---|---|---|---|
    | 13165 | Aspect of the Hawk | Vanilla, TBC, Wrath, Cata, Camelot | Mists |
    | 6117 | Mage Armor | TBC, Wrath, Cata | Vanilla, Mists, Camelot |
    | 324 | Lightning Shield | Vanilla, TBC, Wrath, Cata, Camelot | Mists |
    | 25782 | Greater Blessing of Might | TBC, Wrath | Vanilla, Camelot |
    | 25894 | Greater Blessing of Wisdom | TBC, Wrath | Vanilla, Camelot |
    | 168 | Frost Armor | TBC, Wrath | Vanilla, Camelot |
    | 6673 | Battle Shout | Vanilla, TBC, Wrath, Cata, Camelot | Mists |
    | 588 | Inner Fire | Vanilla, TBC, Wrath, Camelot | Cata, Mists |
    | 21849 | Gift of the Wild | TBC, Wrath | Vanilla, Camelot |
    | 7302 | Frost Armor | TBC, Wrath | Vanilla, Mists, Camelot |
    | 57330 | Horn of Winter | Wrath, Cata | Mists |
    | 469 | Commanding Shout | TBC, Wrath, Cata | Mists |
    | 21084 | Seal of Righteousness | Vanilla, TBC, Camelot | Wrath |
    | 23028 | Arcane Brilliance | TBC, Wrath | Vanilla, Camelot |
    | 30482 | Molten Armor | TBC, Wrath, Cata | Mists |

  - Apply the decisions in the game files first. The dump diff must show exactly the decided
    changes and nothing else.

- [x] **B7: Move multi-game IDs into `data/shared/blacklist.lua`, one class at a time**
  - For each class: move every ID listed by two or more of Vanilla, TBC, Wrath, Mists and
    Standard into shared with its range, and delete the copies from those game files.
    Camelot and Cata files keep their entries.
  - The dump diff must be empty after each class. If an ID's games don't form one range, leave
    it in the game files.
  - Done: 102 IDs moved into the `general` table; 1243 was already in shared, so only its game
    copies were deleted.
  - Forever inherits Vanilla (decided): shared ranges starting at `LE.Classic` also apply to
    Forever (expansion 0), so Vanilla's entries moved into shared too, including the ones only
    Vanilla lists (`In(LE.Classic, LE.Classic)`). Vanilla keeps only Hardcore and Season of
    Discovery. Two IDs were resolved later:
    - 21562: not in Wrath's file at first. Moved into shared as
      `In(LE.Classic, LE.Wrath) and "name" or true`: Prayer of Fortitude Rank 1 up to Wrath
      (`"name"` covers ranks 2-4, including 25392 and 48162 that TBC and Wrath never listed),
      Power Word: Fortitude from Cata on. It is added to Wrath and Cata, and becomes `"name"` on
      Vanilla, TBC and Forever.
    - 16363: commented "Juju Power", but the Era and Forever DB2 name it Windfury Weapon (Rank 4,
      no class). Replaced by Juju Power 16323 in shared as `In(LE.Classic, LE.Classic)`, so
      Forever gets it too. Windfury Weapon is hidden instead by `[8232] = In(LE.Classic,
      LE.Classic) and "name"`.
  - Camelot's file is now empty. Forever gains 19 IDs (Priest PW:F ranks, world buffs,
    events, 17629, 17670), all present in the Forever DB2 (1.60.1), and 8 IDs go from `true`
    to `"name"` (168, 6117, 7302, 19740, 21849, 23028, 25782, 25894). Forever's dump now
    equals Era's minus Hardcore and SoD.
  - Other dump change: 48263 and 48266 (`In(LE.Wrath, LE.Mists)`) are added to Cata. Both exist
    in the Cata DB2 (4.4.2), so this fills a gap in Cata's data (it already listed 48265 and
    55610). Their names swap between Wrath and Cata/Mists (Frost/Blood Presence).
  - [x] General (food, drink, lust, events, world buffs): nothing to move
  - [x] DEATHKNIGHT
  - [x] DRUID
  - [x] HUNTER
  - [x] MAGE
  - [x] MONK: nothing to move
  - [x] PALADIN
  - [x] PRIEST
  - [x] ROGUE
  - [x] SHAMAN
  - [x] WARLOCK
  - [x] WARRIOR
  - [x] Others (DEMONHUNTER, EVOKER, consumables): scrolls

- [x] **B8: Update docs**
  - `docs/compatibility.md`: where a blacklist ID goes (shared with a range, or the game file).

## 4. Open questions

- ~~Should Forever inherit Vanilla's ranges?~~ Yes, excluding Hardcore and Season of Discovery
  (see B7). Needs an in-game check on Forever.
- ~~21562 in Wrath~~ Moved into shared (see B7).
- ~~16363 in Vanilla~~ Replaced by Juju Power 16323 in shared (see B7).

## 5. How to verify each step

1. `mise exec -- make check` and `mise exec -- make test`.
2. `lua tests/dump.lua | diff before.txt -` is empty, or shows only the decided changes.
3. In game, on every client: `/reload` with no Lua errors, `/filger validate` reports nothing,
   and from B5 on `/filger dump` matches the baseline for the logged-in class.
