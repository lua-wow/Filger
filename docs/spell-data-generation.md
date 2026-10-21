# Spell data

Plan only. No code was changed. As of 2026-10-21.

- Split out of [secret-values-options.md](secret-values-options.md) (its former options C and D). Client
  facts are in [compatibility.md](compatibility.md).
- Unless stated otherwise, paths are relative to `../refs/wow-ui-source/Interface/AddOns/`, and
  `APIDoc/` means `Blizzard_APIDocumentationGenerated/`.
- Evidence tags: **VERIFIED** means read in Blizzard source or API docs (path given). **UNVERIFIED** means
  an assumption that needs an in-game check.

## When

A later iteration, on its own branch, after Filger works on every game version
([secret-values-options.md](secret-values-options.md)). Until then `data/` stays unchanged.

## Decisions

- Nothing in `data/` is dropped or trimmed. Old content stays playable (Classic raids of any expansion,
  legacy raids on Retail), so the boss and blacklist data still matter.
- Classic boss-debuff data: keep the existing data.
- `data/Cata/` and `Filger.isCata`: keep both.

## Goal

Maintain the spell tables in `data/` (boss debuffs, class lists, blacklist) with less hand work. Any tool
is maintainer-only: nothing runs for players and nothing becomes configurable.

## Where it helps

- **Retail and Forever:** class lists only. Spell-ID filtering of debuffs on the player or a friendly unit
  is blocked by design (identity gate, see secret-values-options.md), so a boss-debuff list can't take
  effect there in restricted content. Boss mechanics come from `isBossAura`, `RAID_PLAYER_DISPELLABLE` and
  `CROWD_CONTROL` instead. Whether legacy raids on Retail run under addon restrictions is **UNVERIFIED**.
- **Classic:** boss debuffs and class lists, for raids of any expansion.

## Sources

### D1. In-game Encounter Journal dump

1. A dev-only `/filger` command walks the journal out of combat: instance → encounter → section.
2. For each section, `C_EncounterJournal.GetSectionInfo(sectionID)` returns `spellID`, `title`,
   `headerType`, … (`APIDoc/EncounterJournalDocumentation.lua:382-397`, **VERIFIED**). Keep sections with a
   `spellID`, plus instance, boss and title.
3. Get the output out of the game: print for copy/paste, or write to `FilgerData` (declared, unused) and
   read it from `WTF/` after logout. Using `FilgerData` this way is dev-only and temporary, not player
   configuration.
4. A maintainer script turns the output into `data/<Game>/bosses.lua`, or merges it into the existing file.

Facts:

- `GetSectionInfo` is in the API docs of every worktree: live, `classic`, `classic_titan`,
  `classic_anniversary`, `classic_era`. Each also ships `Blizzard_EncounterJournal`. **VERIFIED** by grep.
- Whether the Classic journals contain their own raids and abilities is **UNVERIFIED**.
- Whether the section `spellID` is the debuff ID or the ID of the cast that applies it is **UNVERIFIED**.
  They often differ, so the output needs review by hand.
- The journal has no class spells. D1 can't produce class lists.
- No third-party license involved; the data comes from the client.

### D2. Build-time DB2 export

- wago.tools CSV for `JournalEncounterSection`, `SpellEffect`, `SpellMisc`, processed in the maintainer's
  environment, never at runtime.
- `SpellEffect` can link a cast to the aura it applies, which addresses D1's cast-vs-debuff problem
  (**UNVERIFIED**).
- The data belongs to Blizzard. Bulk use and attribution under wago.tools' terms are **UNVERIFIED**; check
  before relying on it.

### D3. Community data

- BigWigs, LittleWigs, DBM boss modules.
- Their licenses vary and are **UNVERIFIED** here. Read each LICENSE before taking anything.
- Take IDs only, never code, and credit the source.

### C. Learn or log mode

- **What:** while not restricted, record the spellIds of the auras seen. Promote the useful ones into the
  whitelist or blacklist.
- **Avoids secrets:** reads happen only while `C_Secrets.ShouldAurasBeSecret()` is false.
- **The catch:** on Retail, encounter and M+ debuffs mostly exist only **while restricted**, so they can't
  be learned, and ID lists on player debuffs are ignored anyway (identity gate). There it only helps class
  buffs, which a curated list covers already.
- **Persistence:** it needs `FilgerData`. Kept as a dev-only command whose output the maintainer copies
  into `data/`, it doesn't add configuration. As a player-facing feature it breaks the no-configuration
  rule.
- **Works on:** all clients. Classic never restricts, so learning works there in combat too.
- **Evidence:** VERIFIED reasoning from the predicates; whether boss auras show up out of combat is
  UNVERIFIED.

## Comparison

| Source | Boss data | Class lists | Runs | License | Effort |
|---|---|---|---|---|---|
| D1. EJ dump | Yes (needs review) | No | In game, out of combat | None | M |
| D2. DB2 export | Yes | Possible (**UNVERIFIED**) | Offline | wago.tools terms **UNVERIFIED** | M |
| D3. Community | Yes, curated | No | Offline | Per project, **UNVERIFIED** | S–M |
| C. Learn mode | Classic only; Retail can't see them | Yes, from what the maintainer plays | In game | None | S–M |

Maintenance for D1–D3: one run per patch. Risk: low (offline or dev-only).

## Recommendation

D1 first (no license question); D2 if class lists outgrow hand maintenance. C only as a dev aid on
Classic.

## Open questions

1. If D1 or C is built: print for copy/paste, or temporary `FilgerData`?
