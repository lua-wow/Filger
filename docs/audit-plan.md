# Filger improvement plan

## 1. Summary

**State (5.4.0):** the restructure into `core/`, `elements/` and `data/` is done.
luacheck is clean. The TOC Interface versions match all six clients in `../refs` (Retail 12.1.5,
Forever 1.60.1, MoP 5.5.4, Titan 3.80.2, TBC 2.5.6, Era 1.15.9). Most behaviour is still
unverified in-game.

**Goals, in order:**
1. Fix the real bugs found in the aura and tooltip code.
2. Make spell data verifiable in-game (`/filger validate`) instead of relying on memory.
3. Close the Retail secret-value gaps in cooldowns.
4. Refresh the spell data.
5. Cleanup, performance, tests and release automation, without adding configuration or frameworks.

Effort: **S** < 1h, **M** a few hours, **L** a day or more. Risk = the chance of breaking current behaviour.

---

## 2. Tasks

### Phase 1: Quick wins

- [x] **T1: A reused aura button keeps a stale timer and hides permanent auras** — done in c67c811
  - When a button last showed a timed aura, its `OnUpdate` stays set. If the button is then reused
    for a permanent aura (`expirationTime = 0`), the timer sees it as expired and calls `Hide()`.
    The old `Time` text also stays. As a result, permanent buffs vanish on Classic clients.
  - S / low. Files: `elements/Classic/auras.lua`
  - Steps:
    1. In `aura_proto:Update`, when `duration` is 0: `SetScript("OnUpdate", nil)` and `Time:SetText("")`.
  - Verify: `make check`. On Classic, with a timed buff and a permanent one (a form or aura), let
    the timed one expire; the permanent icon must stay.
  - Deps: none.

- [x] **T2: Updated auras are filtered against stale data and never removed** — done in 266f5a9
  - The `updatedAuraInstanceIDs` branch calls `FilterAura` on the old cached table and never clears
    an aura that stops passing the filter (for example, stacks dropping below `stackThreshold`).
  - S / low. Files: `elements/Classic/auras.lua`
  - Steps:
    1. Filter the refreshed data. When it fails, clear the aura from `actives` and set `changed`.
  - Verify: `make check`. On Classic, use an aura with a `stackThreshold` and watch it appear and
    disappear as its stacks cross the threshold.
  - Deps: none.

- [x] **T3: Full update can index a nil aura** — done in 5352def
  - `GetAuraDataBySlot` can return nil, and the full-update loop then indexes
    `data.auraInstanceID`.
  - S / low. Files: `elements/Classic/auras.lua`
  - Steps:
    1. Skip the slot when the data is nil.
  - Verify: `make check`. Watch for no new Lua errors.
  - Deps: none.

- [x] **T4: The tooltip guard uses `and` where it means `or`** — done in a8a0ddc
  - The check is `IsForbidden() and not IsVisible()`, so a forbidden GameTooltip still gets used.
  - S / low. Files: `core/button.lua`
  - Steps:
    1. Change `and` to `or`.
  - Verify: `make check`. Hover icons on every client and confirm the tooltips still show.
  - Deps: none.

- [x] **T5: Building frames mutates the shared class spell table** — done in df51d9a
  - `Mixin(spells[class] or {}, spells["ALL"] or {})` writes the `ALL` entries into the class table
    itself.
  - S / low. Files: `elements/Mainline/auras.lua`, `elements/Classic/auras.lua`
  - Steps:
    1. Mix into a new table: `Mixin({}, spells[class] or {}, spells["ALL"] or {})`.
  - Verify: `make check`. `PLAYER_AURAS` shows the same spells as before.
  - Deps: none.

- [x] **T6: Remove dead code** — done in b0ab67b
  - Covers the `itemId` cooldown path (no data creates item rows), `util.print`, `util.error`,
    `ns.player.name`, and the unused `button.name` and `button.duration`.
  - S / low. Files: `elements/cooldowns.lua`, `core/button.lua`, `core/util.lua`, `core/init.lua`
  - Steps:
    1. Remove the `itemId` path and the `SetItemByID` tooltip branch.
    2. Remove the unused util functions and fields.
  - Verify: `make check`. Cooldowns and tooltips work on Retail and on one Classic client.
  - Deps: none. D1 decides whether the compat fallbacks also go.

- [x] **T7: Small hygiene fixes** — done in d4aa68b
  - `/filger help` lists commands in random order. `data/shared/cooldowns.lua` lacks the
    `or -1` fallback that `blacklist.lua` has. `dev/development.lua` links to the missing
    `docs/secret-values-options.md`.
  - S / none. Files: `core/commands.lua`, `data/shared/cooldowns.lua`, `dev/development.lua`
  - Steps:
    1. Print the help entries in sorted order.
    2. Add the `or -1` fallback.
    3. Drop the dead doc reference.
  - Verify: `make check`, then run `/filger help`.
  - Deps: none.

- [x] **T8: README fixes** — done in 73991e6
  - The ElvUI deferral isn't mentioned. The repo owner differs between the TOC (`wow-lua`) and the
    README (`lua-wow`). Only `/filger help` is documented.
  - S / none. Files: `README.md`, maybe `Filger.toc`
  - Steps:
    1. Fix the dependencies list and the URLs.
    2. Document `auras` (and `validate` once T10 lands).
  - Verify: read it through.
  - Deps: D4.

### Phase 2: Medium

- [x] **T9: `Finalize` collects invalid entries instead of printing them** — done in 2d25f88
  - Every invalid ID currently prints a warning at every login. Cooldowns are validated only for
    the player's class.
  - M / low. Files: `core/data.lua`
  - Steps:
    1. Store problems in `data.invalid = { { kind, class, id } }` instead of calling `warn`.
    2. Validate cooldown rows for every class, while still building the active list only for the
       player.
    3. Print at most one summary line, and only when `ns.config.general.dev` is set.
  - Verify: `make check` and the T15 tests. After `/reload`, no per-ID spam in chat.
  - Deps: none.

- [x] **T10: `/filger validate` command**
  - Lists every configured ID that doesn't resolve on this client, so data is checked in-game
    rather than from memory.
  - M / low. Files: `core/commands.lua`
  - Steps:
    1. Add a `validate` command that prints `data.invalid`, grouped by kind and class.
    2. ~~Also list the player's own cooldown rows where `C_SpellBook.IsSpellKnown` is false~~
       Dropped: it depends on talents and race, not on whether the ID exists.
  - Verify: `/filger validate` on every client. Temporarily add a fake ID, confirm it is reported,
    then remove it.
  - Deps: T9.
  - Note: `C_Spell.DoesSpellExist` is in all six clients' API docs and can serve as a second check.

- [x] **T11: Blacklist names only work on English clients**
  - `"Well Fed"`, `"Food"`, `"Drink"`, `"Mark of the Wild"`, `"Arcane Intellect"` and
    `"Power Word: Fortitude"` don't match on other locales, and Mainline drops name keys entirely.
  - M / low. Files: `data/shared/blacklist.lua`, `data/Standard/blacklist.lua`, `core/data.lua`
  - Steps (D6: keep name matching):
    1. Replace each English name key with one representative spell ID flagged as a name entry.
       Done: the value is `"name"` instead of `true`.
    2. At `Finalize`, resolve it with `GetSpellInfo(id).name` and store the localized name in
       `data.blacklist`. An ID that doesn't resolve goes into `data.invalid`. Done: the ID itself
       is also blacklisted, and string keys are no longer accepted.
    3. Mainline is unchanged: its aura containers filter by spell ID only. The `"Well Fed"` and
       `"Hearty Well Fed"` keys in `data/Standard/blacklist.lua` never matched, so they were removed.
  - Verify: `/filger validate`. On a non-English client, or by checking `GetSpellInfo(id).name`,
    the buffs are hidden on Classic clients.
  - Deps: T9, D6, U8.

- [x] **T12: Retail cooldown secret-value gaps**
  - Outcome: U1 and U2 both came back no, so steps 1 and 2 need no change. The secret path already
    shows active, off-GCD rows without `casted`. As a fallback for an untested secret `spellID`
    (instances/M+), a row shown through the secret path is now recorded in `casted`.
  - A cast made while restricted may not be recorded in `casted`, so a cooldown still running
    vanishes after combat. Slot cooldowns may return secret values, so the arithmetic in
    `ProcessCooldownData` may raise errors.
  - M / med. Files: `elements/cooldowns.lua`
  - Steps:
    1. Apply the fix the U1 result calls for: either drop the `casted` gate for rows that are
       active and off GCD, or record casts by another means.
    2. If U2 confirms slot cooldowns are secret, guard them with `IsSecret` and use a duration
       object or skip them.
  - Verify: Retail, in combat, cast a tracked CD, leave combat mid-cooldown, and confirm the icon
    stays. Use a trinket in combat and confirm there's no Lua error.
  - Deps: U1, U2.

- [x] **T13: Cooldown update performance**
  - `SPELL_UPDATE_COOLDOWN` fires on every GCD. Each event allocates a table per row and repeats
    the same spell-info lookups.
  - M / low. Files: `elements/cooldowns.lua`
  - Steps:
    1. Cache name and icon per row once (they're static per spell).
    2. Reuse a per-row data table instead of allocating a new one.
  - Verify: `make check`. Behaviour is unchanged. Optionally compare memory with `/dump collectgarbage("count")`
    before and after a few minutes of combat.
  - Deps: none, but T12 edits the same function, so don't run them in parallel. Land T12 first
    unless U1 or U2 is still open.

- [x] **T14: Missing refresh events for cooldowns**
  - Rows go stale until the next cooldown event after a gear swap, a talent change or a trinket use.
  - S–M / low. Files: `elements/cooldowns.lua`
  - Steps:
    1. Register `PLAYER_EQUIPMENT_CHANGED` and force an update.
    2. Register `SPELLS_CHANGED` and re-check `isKnown`.
    3. Add whichever item-cooldown event U3 identifies.
  - Verify: swap a trinket, change a talent, use a trinket. The icons update immediately.
  - Deps: U3, T13.

- [x] **T15: Minimal test harness for pure logic**
  - No tests exist yet.
  - M / none. Files: new `tests/run.lua`, `Makefile`, `.github/workflows/lint.yml`, `exclude.lst`
  - Steps:
    1. Write a plain Lua 5.1 runner with stubbed `ns`, `GetSpellInfo` and `Mixin`, covering
       `util.FormatTime`, the `data.Create*` constructors and `Finalize` (dedupe, ordering,
       class+ALL, `invalid`).
    2. Add a `make test` target.
    3. Run it in CI and exclude `tests/` from packaging.
  - Verify: `mise exec -- make test` and `make check` both pass, and CI is green.
  - Deps: none, but it is most useful together with T9.

- [x] **T16: Replace `MergeAPI` with a direct backdrop call** — done in a2cbd94
  - `MergeAPI` writes `CreateBackdrop` into every widget metatable. Filger only needs it on its
    own buttons, and other addons may read the method as a sign that Tukui is loaded.
  - S–M / med. Files: `core/api.lua`, `core/button.lua`, `Filger.lua`
  - Steps:
    1. Make `ns.CreateBackdrop(frame)` call the Tukui/ElvUI method when one exists, or Filger's own.
    2. Have `StyleButton` call it.
    3. Delete `MergeAPI`.
  - Verify: test standalone, with ElvUI and with Tukui/Tainted. Borders and backdrops look
    identical to before, and Mainline container buttons are styled.
  - Deps: none.

- [ ] **T17: Release publishing to CurseForge and Wago** — deferred (D5)
  - The TOC has no `X-Curse-Project-ID` or `X-Wago-ID`.
  - S–M / low. Files: `Filger.toc`, `.github/workflows/release.yml`
  - Steps:
    1. Add the IDs and secrets as chosen in D5.
    2. Use the CHANGELOG section as the release notes.
  - Verify: push a test tag on a fork, or check the dry-run output.
  - Deps: D5, U7.

### Phase 3: Larger work

- [x] **T18: Refresh the Retail spell data for 12.x** — done in 6d6552c
  - M–L / low (data only). Files: `data/Standard/spells.lua`, `data/Standard/cooldowns.lua`,
    `data/Standard/blacklist.lua`
  - Steps: work one class per commit:
    1. Run `/filger validate`.
    2. Use `/filger auras player buffs` on each spec to get the IDs actually applied.
    3. Fix or remove entries.
  - Verify: `/filger validate` is clean for that class.
  - Deps: T10, U9.

- [x] **T19: Refresh the Classic spell data**
  - L / low. Files: `data/{Vanilla,TBC,Wrath,Mists,Camelot}/*.lua`
  - Steps: one client per commit, validate only (no per-class `/filger auras` runs):
    1. Run `/filger validate`.
    2. Fix or remove the reported entries.
  - Progress: Vanilla and TBC clean, no changes needed. Wrath skipped: no client to test on.
    Mists: shared Fortitude `1243` doesn't exist, limited to before MoP.
    Camelot pending: no client access yet.
  - Verify: `/filger validate` is clean on that client.
  - Deps: T10, U9. Per D1, `data/Cata` stays too.

- [x] **T20 (optional): Dev logger for listed aura IDs never seen** — done in 094f502
  - Catches cases where the cast ID was listed instead of the aura ID.
  - M / none. Files: `dev/development.lua`
  - Steps:
    1. While toggled on, record every listed `spellId` seen in `UNIT_AURA`.
    2. `/filger unseen` prints the listed IDs that never appeared.
  - Verify: play a spec for a while and review the output.
  - Deps: T9. Only works on Retail outside combat, while auras aren't secret.

### Added after the decisions

- [x] **T21: Remove the unused `FilgerData` SavedVariable** (D2)
  - S / none. Files: `Filger.toc`, `CLAUDE.md`
  - Steps:
    1. Delete the `## SavedVariables` line.
    2. Update the `CLAUDE.md` sentence that mentions `FilgerData`.
  - Verify: `/reload` on one client and check that `/dump FilgerData` prints nil.
  - Deps: none.

- [x] **T22: Prune dev experiment commands** (D3) — done in f9d6024
  - `dev/` keeps shipping, but experiments whose answers are recorded here are dead weight.
  - S / none. Files: `dev/development.lua`
  - Steps:
    1. Remove each `exp*` command whose question is answered in §3 or elsewhere in this file.
    2. Keep `exp7` and `exp10` until U1, U2, U3 and U6 are answered.
  - Verify: `make check`, then `/filger help` with `dev = true`.
  - Deps: the U items each experiment serves.

---

## 3. Blocked: needs a decision or in-game verification

**Decisions (yours):**
- **D1 Cata.** Drop `data/Cata/`, `ns.client.isCata` and the legacy fallbacks in `compat.GetSpellInfo` and
  `GetSpellCooldown`? The `C_Spell` versions exist on all six supported clients, so the fallbacks
  only serve Cata. **Answer:** keep `ns.client.isCata`, `data/Cata` and the fallbacks. The blacklist is
  incremental across expansions (Mists builds on the Cata entries), so the Cata data stays.
- **D2 `FilgerData`.** Remove the unused SavedVariable from the TOC? It creates a global for nothing.
  **Answer:** remove it (T21).
- **D3 `dev/`.** Keep shipping it (gated by `config.general.dev`) or exclude it in `exclude.lst`?
  Also, delete exp4–exp10 once their results are recorded? **Answer:** keep shipping it, so the TOC
  doesn't change whenever `dev/` is needed. Remove the commands that are no longer needed (T22).
- **D4 Repo URL.** Is the owner `wow-lua` or `lua-wow`? **Answer:** `lua-wow` (matches the git remote).
- **D5 Publishing.** CurseForge, Wago, or GitHub releases only? This needs the project IDs and API
  tokens. **Answer:** not publishing to CurseForge or Wago for now. T17 is deferred.
- **D6 Blacklist names.** Replace them with spell ID lists, or resolve the localized name from
  one representative ID at `Finalize`? **Answer:** keep name matching. Names exist so buffs with
  many IDs (Well Fed gains more every patch) are hidden without listing every ID. Resolve the
  localized name from one representative ID (T11).

**UNVERIFIED (check before starting the dependent task):**
- **U1** (blocks T12): is the `spellID` in `UNIT_SPELLCAST_SUCCEEDED` secret for player
  casts in combat on Retail? Check with `/filger exp7` (set `dev = true`), enter combat, cast.
  **Answer:** no. Every cast logged a readable `spellID` while `InCombatLockdown()` was true (open
  world; instanced/M+ content not tested).
- **U2** (blocks T12): does `GetInventoryItemCooldown` return secret values in combat on
  Retail? It isn't in the generated API docs. Check with `/filger exp7`, using a trinket in combat.
  **Answer:** no. Slot 14 read `161793.5/120.0/1` in combat right after the trinket use.
- **U3** (blocks T14): which event refreshes trinket and item cooldowns
  (`SPELL_UPDATE_COOLDOWN`, `BAG_UPDATE_COOLDOWN` or `ACTIONBAR_UPDATE_COOLDOWN`)? Check with
  `/filger exp10`.
  **Answer:** all three, in the same frame, at both the start and the end of the slot 14 cooldown.
  `SPELL_UPDATE_COOLDOWN` carried the trinket's spell (1221146) with `itemID` nil, so the already
  registered `SPELL_UPDATE_COOLDOWN` covers slot cooldowns. Bag items (potions) not tested.
- **U4:** does `C_Secrets.ShouldAurasBeSecret()` stay false in combat on Classic clients?
  The API exists there. Check with `/run print(C_Secrets.ShouldAurasBeSecret())` in combat on each
  Classic client.
  **Answer:** yes, it prints `false` on Classic Era, TBC and MoP. WotLK (Titan) not tested.
- **U5 UNVERIFIED (deferred):** does the Mainline aura and cooldown path work at runtime on Forever? All the
  required APIs are in the forever docs. Check with `/reload` on Forever and look at every frame.
  Forever client not available yet.
- **U6 PARTIAL:** does `SPELL_UPDATE_COOLDOWN` fire when a cooldown ends? The code comment says
  no. Check by logging with `/filger exp10`, or a quick event print, as a cooldown expires.
  **Answer (trinket only):** the 120 s cooldown was due to end at 162268.8. All three events
  fired at 162269.4 and showed it cleared, but `SPELL_UPDATE_COOLDOWN` carried spell 431462
  (also seen before the trinket use), not the trinket's spell. An event arrived about 0.6 s after
  the end, but it may have been triggered by something else. Spell cooldown ends not tested.
- **U7:** which inputs do `lua-wow/packager@v1` and the `forever` flavor token in
  `p3lim/toc-interface-updater@v4` accept? Check each action's README, or run the workflow manually.
  **Answer:** done.
- **U8 UNVERIFIED:** the representative spell IDs for the D6 name entries. Pick IDs in-game
  (`/filger auras player buffs` while the buff is up) on each client.
  **Candidates (T11, from memory):** Well Fed 19705, Drink 430, Food 433, Mark of the Wild 1126,
  Arcane Intellect 1459, Power Word: Fortitude 1243 (not 21562, which is Prayer of Fortitude on
  Classic). On each client, confirm with `/filger validate` and
  `/dump C_Spell.GetSpellInfo(<id>).name`. On Retail, 1243, 430 and 433 may not resolve; if so,
  gate them to Classic.
- **U9:** every spell ID in `data/`. None are trusted from memory; `/filger validate`
  (T10) and in-game observation are the source of truth.
  **Answer:** done.

---

## 4. Deferred or rejected

| Idea | Status | Reason |
|------|--------|--------|
| Options UI, slash config, profiles, per-character settings | Rejected | Contradicts the no-configuration philosophy. |
| UI string localization | Rejected | The UI shows no user-facing strings, only icons and numbers. |
| busted or another test framework | Rejected | A plain Lua runner (T15) is enough. |
| Showing Stagger in Retail `PLAYER_DEBUFFS` | Rejected | Stagger is contextually secret, and the container can't filter it by ID. |
| Sorting secret cooldowns by remaining time | Rejected | Secret values can't be compared. |
| One `OnUpdate` ticker per element instead of per button | Deferred | Fine at the current scale (≤ ~60 buttons). |
| Sharing the expansion constant ladder in `core/` | Deferred | Cosmetic. Two copies are still readable. |
| Moving the inline Classic Stagger IDs into `data/` | Deferred | They only matter on Mists and aren't class-list data. |
| Linting `dev/` | Deferred | It is experimental code. Revisit after D3. |
| Re-adding Cata support | Deferred | Not in the TOC, and there are no refs for it. Its data and fallbacks stay (D1). |
| Publishing to CurseForge and Wago (T17) | Deferred | GitHub releases only for now (D5). |

---

## 5. How to work through this

- One task per session, in the order below, unless its deps or blockers say otherwise.
- Order:
  1. ~~Decide D1, D2, D3, D5, D6.~~ Done. T21 done.
  2. One in-game session for U1, U2, U3, U6 on Retail (`exp7`, `exp10`), plus U4 on each Classic
     client and U5 on Forever. Then T22.
  3. T9 → T15 → T10. T15 tests `Finalize` after T9 changes it; T10 unblocks all data work.
  4. T16 on its own, so a visual regression is easy to trace.
  5. T12 → T13 → T14. If U1 or U2 is still open, do T13 before T12 (no logic overlap).
  6. T11, once D6 and U8 are resolved.
  7. T18 → T19.
  8. T20 last (optional). T17 is deferred (D5).
- You create the branch (`t<N>-short-name`). Claude edits the working tree only and never commits.
- Before starting a task, its D and U items must be resolved. Record the answer next to the item
  in §3.
- Each task ends with `mise exec -- make check` (plus `make test` once T15 exists) and the listed
  in-game checks, with `/reload` on the named clients.
- When done: tick the checkbox and append the commit, for example `— done in abc1234`.
- New findings go into §2 as new task IDs, or into §4 with a reason. Don't renumber existing IDs.

