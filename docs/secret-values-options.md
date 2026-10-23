# Secret values: options for Retail and Classic

Analysis only. No code was changed. As of 2026-10-19.

- Sources: `../refs/wow-ui-source` live **12.1.5.70448** (2026-10-16), the `forever` (1.60.1),
  `classic` (5.5.4), `classic_titan` (3.80.2), `classic_anniversary` (2.5.6) and `classic_era` (1.15.9)
  worktrees, `../refs/ElvUI`, and warcraft.wiki.gg
  [Secret values](https://warcraft.wiki.gg/wiki/Secret_values) (last edited 2026-09-23, change log up to
  12.1.5).
- Unless stated otherwise, paths are relative to `../refs/wow-ui-source/Interface/AddOns/`, and
  `APIDoc/` means `Blizzard_APIDocumentationGenerated/`.
- This builds on [cooldown-manager.md](cooldown-manager.md) (CDM, AuraContainer, ElvUI) and doesn't repeat
  it. That doc was written against 12.1.0. Client facts are in [compatibility.md](compatibility.md).
- Evidence tags: **VERIFIED** means read in Blizzard source or API docs (path given). **UNVERIFIED** means
  an assumption that needs an in-game check (see [Experiments](#experiments)).

## Summary

1. On Retail and Classic Forever, phase 2 can't work in combat or in encounters. Phase 2 lists every aura
   and then decides in Lua by spellId, name, caster, dispel type, stacks or expiration. All of those fields
   are secret, and secrets can't be compared, used as table keys, counted with `#` or used in arithmetic.
2. Four things still work. Server-side filter strings (`HARMFUL|PLAYER`, `!` negation, and the new
   `BIG_DEFENSIVE`, `EXTERNAL_DEFENSIVE`, `CROWD_CONTROL`, `IMPORTANT`, `RAID_PLAYER_DISPELLABLE`,
   `DISPELLABLE`). Blizzard's secure `CustomAuraContainerTemplate` (filters, spell-ID include/exclude where
   allowed, expiration sort). Never-secret spells queried one at a time. Duration objects and curves, for
   display only.
3. Retail blocks spell-ID filtering of **debuffs on the player or a friendly unit** by design. An include
   list then shows nothing, and an exclude list is ignored. A better boss-debuff table can't help on Retail;
   it only helps Classic.
4. Decision: **two aura implementations, loaded per client family** with `[Family]` in the TOC. On
   Mainline (Retail and Forever), use AuraContainer only (no `UNIT_AURA` path): filter strings and flags,
   plus curated `includeSpellIDs`/`excludeSpellIDs` where ID filtering is allowed. On Classic, keep
   today's implementation unchanged. Buttons, layout, `data/` and cooldowns stay shared.
5. These features don't survive on Retail: stack thresholds, numeric priority sort, the blacklist on
   debuff frames, filtering by name, the `sourceUnit == nil` checks, LibDispel's flash, and Filger's own
   timer text.
6. Classic: same branch and same TOC. Only its aura file differs, and that file is today's code. Don't
   freeze a branch.

## Progress

Details in [Migration](#migration-each-phase-ships-on-its-own) and [Experiments](#experiments).

- [ ] **Phase 0: fixes that work today**
  - [x] Experiment 1: restriction state on every client (Forever and Titan not tested)
  - [x] Experiment 2: `GetAuraDuration` and `#` on secret instance IDs (Retail, in combat): **fails**,
        tainted code can't call any `RequiresUnitAuraAccess` API while auras are secret
  - [x] Experiment 3: never-secret coverage of `data/`, Stagger (spells 1/100, blacklist 17/313,
        cooldowns 0/28, Stagger contextually secret)
  - [x] Read `cdInfo.isEnabled` (`Filger.lua:648`)
  - [x] Refresh only the event's `spellID` in `SPELL_UPDATE_COOLDOWN` (nil → all; override/base IDs;
        items and slots still refreshed). Shown rows are also re-checked on every event: logged on
        Retail and MoP (2026-10-21), the event fires when a cooldown starts, never when it ends.
        `spellID` was never secret in combat, and `baseSpellID` was always nil.
  - [ ] ~~Secret auras: `GetAuraDuration` + `SetCooldownFromDurationObject`, no `duration > 0` compare~~
        Blocked by Experiment 2: no instance ID is reachable from tainted code in combat
  - [x] Secret cooldown timer text: a `C_DurationUtil` duration text binding on `button.Time`, with a
        seconds formatter (`2m`, `45s`, `4.3`) and a step color curve (red under 5 s). Verified on Retail
        in combat (2026-10-21). Blizzard countdown numbers stay hidden. Created on Mainline only: Classic
        bindings have no `SetTextColorCurve` (`APIDoc/DurationTextBindingObjectAPIDocumentation.lua`,
        crashed on MoP 2026-10-21).
- [x] **Phase 1: family split, no behavior change**
  - [x] Move `aura_proto` and aura frame definitions to `core/Classic/auras.lua` (`ns.aura_proto`,
        frames added to `Filger.config.frames`); add `core\[Family]\auras.lua` to the TOC. Shared layout
        numbers live in `Filger.config.layout`
  - [x] `core/Mainline/auras.lua` starts as a copy
  - [x] Experiment 9: `[Family]` resolves on every client (Forever and Titan not tested)
- [x] **Phase 2: Mainline container for PLAYER_AURAS and PLAYER_BUFFS**
  - [x] Experiment 4: container spell-ID gate (Retail, in combat): passes, `includeSpellIDs` refused
        and `excludeSpellIDs` ignored on player debuffs, as the gate table says
  - [x] Experiment 5: filter strings (Retail): `!` negation, `BIG_DEFENSIVE` and `IMPORTANT` work;
        `NOT_CANCELABLE` silently ignored. Classic not needed: its aura file keeps Lua filtering
  - [x] PLAYER_AURAS: `HELPFUL|PLAYER` + `includeSpellIDs` (strict allowlist: only listed, enabled
        numeric spell IDs are shown)
  - [x] PLAYER_BUFFS: `HELPFUL|!PLAYER` + `excludeSpellIDs`
  - [x] Frames are named from their `config.frames` key (`FilgerPlayerAuras`, ...)
- [ ] **Phase 3: remaining Mainline frames**
  - [x] Experiment 6: private aura anchors: **pass**, addon code can add them in combat while auras
        are secret
  - [x] TARGET_DEBUFFS, TARGET_AURAS, FOCUS_DEBUFFS: groups with `hostile` are enabled by
        `UnitCanAttack` on target/focus change. TARGET_DEBUFFS `HARMFUL|PLAYER` (hostile) /
        `HARMFUL|!PLAYER` (friendly); TARGET_AURAS `HELPFUL` + blacklist (friendly) /
        `HELPFUL|IMPORTANT` + `HELPFUL|DISPELLABLE` (hostile); FOCUS_DEBUFFS `HARMFUL` + `isBossAura`
  - [x] BOSS_DEBUFFS: enabled on Mainline. `HARMFUL` + `isBossAura` (limit 1), plus 2 private-aura
        anchors (`privateAuras`) after the container slot
  - [x] PLAYER_DEBUFFS: `HARMFUL|RAID_PLAYER_DISPELLABLE`, `HARMFUL|CROWD_CONTROL`, `HARMFUL` +
        `isBossAura` groups (Stagger dropped, Experiment 3)
  - [ ] Delete the copied event path from `core/Mainline/`
- [ ] **Other experiments**
  - [ ] Experiment 7: cooldown edges (items, slots, secret cast `spellID`)
  - [ ] Experiment 8: tooltip methods on each Classic client
- [ ] **Later iteration:** spell data ([spell-data-generation.md](spell-data-generation.md))

## Facts

### Where Filger reads aura and cooldown data and decides on it

| Location | APIs | Data read → decision | Client path |
|---|---|---|---|
| `Filger.lua:32-54` `OnEnter` | `GameTooltip:SetUnitAura`, `SetUnit{Buff,Debuff}ByAuraInstanceID`, `SetSpellByID` | `auraIndex` / `auraInstanceID` → tooltip | Index on Vanilla, instance ID elsewhere |
| `Filger.lua:72-92` `OnUpdate` | `GetTime` | `expirationTime - GetTime()`, `<= 5` → red text, hide on expiry | All |
| `Filger.lua:184-208` `UpdateColor` | `UnitCanAssist`, `UnitCanAttack` | `isHarmful/isHelpful`, `Filger.colors[dispelName]` (table key), `isPlayerAura` → desaturate, `isDispelable/isStealable` → flash | All |
| `Filger.lua:218-272` `Update` | `Cooldown:SetCooldown`, `SetTexture`, `SetText` | `name` check, `duration > 0`, `expirationTime - duration`, `applications > 1` | All |
| `Filger.lua:281-295` `SortAuras` | — | Compares `priority`, `expirationTime`, `auraInstanceID` | All |
| `Filger.lua:308-310` `FilterAura` | — | `applications >= stackThreshold` | All |
| `Filger.lua:312-324` `GetAuraIndex` | `C_UnitAuras.GetAuraDataByIndex` | `auraInstanceID ==` → tooltip index | Vanilla |
| `Filger.lua:337-370` `ProcessData` | `UnitIsUnit`, `UnitIsOwnerOrControllerOfUnit`, LibDispel | `sourceUnit` (or `isFromPlayerOrPlayerPet` when restricted), `spellId`/`dispelName` → LibDispel, `self.spells[spellId]`, `blacklist[spellId]`, `blacklist[name]` | All |
| `Filger.lua:374-391` `ScanSpellAuras` | `C_Secrets.ShouldSpellAuraBeSecret`, `C_UnitAuras.GetUnitAuraBySpellID` | `isHarmful ==`, `isFromPlayerOrPlayerPet` | Retail/Forever while restricted |
| `Filger.lua:393-498` `UpdateAuras` | `C_Secrets.ShouldAurasBeSecret`, `GetAuraSlots`, `GetAuraDataBySlot`, `GetAuraDataByAuraInstanceID`, `IsAuraFilteredOutByInstanceID`, `UNIT_AURA` | `updateInfo` fields, `self.all[auraInstanceID]` keys | All (restricted branch on Retail/Forever) |
| `Filger.lua:601-613` `FilterCooldown` | — | `enabled`, `isKnown`, `casted`, `duration > 1.5`, `start > 0` | All |
| `Filger.lua:620-625` `SortCooldowns` | — | Compares `expirationTime` | All |
| `Filger.lua:627-683` `ProcessCooldownData` | `C_Secrets.ShouldSpellCooldownBeSecret`, `Filger.GetSpellCooldown`, `C_Spell.GetSpellCooldownDuration`, `GetInventoryItemCooldown`, `C_Container.GetItemCooldown`, `C_SpellBook.IsSpellKnown` | `isActive and not isOnGCD` → duration object; `start/duration` otherwise; reads `cdInfo.enabled`, but the field is `isEnabled` (bug, see `core/utils.lua:61-72`) | Secret branch on Retail/Forever |
| `Filger.lua:749-752` `UNIT_SPELLCAST_SUCCEEDED` | `issecretvalue` | `casted[spellId]` key, skipped when secret | All |
| `config.lua:92-94` PLAYER_BUFFS | — | `not isPlayerAura` | All |
| `config.lua:108-128` TARGET_DEBUFFS | `UnitCanAttack` | `isPlayerAura`; sort on `priority`, `expirationTime`, `isPlayerAura` | All |
| `config.lua:155-157` FOCUS_DEBUFFS | — | `isBossAura`, `sourceUnit == nil`, `isFromPlayerOrPlayerPet` | All |
| `config.lua:170-172` BOSS_DEBUFFS (disabled) | — | `isBossAura`, `sourceUnit == nil` | All |
| `core/data.lua:58-111` | `Filger.GetSpellInfo` | Validates the data tables at load, out of combat; safe | All |

### Secret-value rules (Retail 12.1.5)

**Conditions**

- `SecretWhenUnitAuraRestricted`: secret "when combat, encounter, challenge mode, or PvP match addon
  restrictions are in effect. Individual spells may be flagged as never or always secret, which takes
  priority". `SecretWhenCooldownsRestricted` has the same wording. `SecretWhenAurasRestricted` (used by
  `UNIT_AURA`) has no per-spell override. **VERIFIED** `APIDoc/SecretPredicatesDocumentation.lua`.
- Restrictions depend on combat/encounter/M+/PvP state, not on the unit type. The cast payload is the
  exception: `SecretWhenUnitSpellCastRestricted` is secret "if the unit … is not the player or their pet".
  **VERIFIED** (same file).
- The wiki says dungeons and raids are restricted maps even out of combat (`SecretOnRestrictedMaps`). None
  of the aura or cooldown APIs Filger calls carry that predicate. **VERIFIED** (grep of
  `UnitAuraDocumentation.lua`, `SpellDocumentation.lua`).

**What a secret allows** (wiki, **VERIFIED**)

- Not allowed in tainted code: arithmetic, comparison, use as a table key, indexing, `#`, calling. Any of
  these raises an immediate Lua error.
- Allowed: storing a secret in a variable or table, passing it to functions, concatenating it, and testing
  it as a boolean when it isn't a boolean (the type isn't secret).

**Aura APIs** (`APIDoc/UnitAuraDocumentation.lua`, **VERIFIED**)

| API | Flag | Meaning for Filger |
|---|---|---|
| `GetAuraDataBySlot`, `GetAuraDataByIndex`, `GetAuraDataByAuraInstanceID`, `GetBuffDataByIndex`, `GetDebuffDataByIndex` | `SecretWhenUnitAuraRestricted` | Every field is secret while restricted (except never-secret spells) |
| `GetUnitAuras` | `ConditionalSecretContents` | Same; one can be sorted server-side (`sortRule`) |
| `GetUnitAuraBySpellID`, `GetPlayerAuraBySpellID`, `GetAuraDataBySpellName` | `RequiresNonSecretAura` | Full readable data for never-secret spells; **nothing** (no error) otherwise |
| `GetAuraSlots`, `GetUnitAuraInstanceIDs`, `IsAuraFilteredOutByInstanceID`, `GetAuraDuration` | No `SecretWhen…`; `SecretArguments = "AllowedWhenUntainted"` | The calls themselves aren't secret, but they take an instance ID, which is secret (next row) |
| `auraInstanceID` | Secret: "Aura instance IDs are secret" (`Blizzard_CooldownViewer/CooldownViewerSecure.lua:4`); `UNIT_AURA_BLOCKED` `auraInstanceID SecretValue = true` | It can't be a table key, which breaks `self.all[auraInstanceID]` |
| `GetAuraApplicationDisplayCount`, `GetAuraDispelTypeColor(curve)`, `GetAuraBaseDuration`, `GetAuraCasterGUID` | `SecretWhenUnitAuraRestricted` | Usable for display only (`SetText`, `SetVertexColor`) |
| `UNIT_AURA` | `SecretWhenAurasRestricted` | `updateInfo` is secret, so incremental updates are impossible; Filger already falls back (`Filger.lua:396-398`) |
| `AuraIsBigDefensive(spellID)`, `AuraIsPrivate(spellID)` | `AllowedWhenTainted` | Accept a secret spellID; whether they return a secret is **UNVERIFIED** |

- Whether a tainted caller can pass a **secret** instance ID into the `AllowedWhenUntainted` functions is
  **UNVERIFIED**. The flag suggests it can't. But ElvUI calls `GetAuraDuration(button.unit,
  button.auraInstanceID)` (`../refs/ElvUI/ElvUI/Game/Shared/Modules/Auras/Auras.lua:388`), probably with IDs
  handed over by the container. This is Experiment 2.

**Secrecy predictions** (`APIDoc/SecretPredicateAPIDocumentation.lua`,
`APIDoc/SecretWrapperConstantsDocumentation.lua`, **VERIFIED**)

- They return plain booleans: `C_Secrets.HasSecretRestrictions`, `ShouldAurasBeSecret`,
  `ShouldCooldownsBeSecret`, `ShouldSpellAuraBeSecret(spellID)`, `ShouldSpellCooldownBeSecret(spellID)`,
  `ShouldUnitAuraIndexBeSecret`, `ShouldTotemSlotBeSecret`.
- `GetSpellAuraSecrecy`, `GetSpellCooldownSecrecy` and `GetSpellCastSecrecy` return `Enum.SecrecyLevel`
  (`NeverSecret`, `AlwaysSecret`, `ContextuallySecret`). This is the only "whitelist" there is, and it is
  per spell, set by Blizzard, and not published as a list. Which spells are `NeverSecret` is **UNVERIFIED**
  (Experiment 3). The source mentions Exhaustion and Sated as examples
  (`Blizzard_AuraContainer/Blizzard_AuraContainerUtil.lua:61-63`).

**Cooldowns** (**VERIFIED**)

- `C_Spell.GetSpellCooldown` is `SecretWhenCooldownsRestricted`. In `SpellCooldownInfo`, `isEnabled`,
  `isActive` and `isOnGCD` are `NeverSecret`; `startTime`, `duration` and `modRate` aren't
  (`APIDoc/SpellSharedDocumentation.lua:19-31`).
- `C_Spell.GetSpellCooldownDuration` returns a duration object. See cooldown-manager.md §4 for charges and
  cast counts.
- `UNIT_SPELLCAST_SUCCEEDED` `spellID` is secret for non-player/pet units and for flagged spells
  (`APIDoc/UnitDocumentation.lua:4699-4709`).
- Item and slot cooldowns have no secret flag in the docs. Behavior in game is **UNVERIFIED**.

**What can still be done with a secret** (display only)

- Duration objects: only `Copy` and `HasSecretValues` are `ReturnsNeverSecret`. `GetRemainingDuration`,
  `HasExpired`, `IsActive` and `Evaluate*(curve)` all follow the underlying data, so they are secret when it
  is (`APIDoc/LuaDurationObjectAPIDocumentation.lua`, **VERIFIED**).
- Sinks for duration objects: `Cooldown:SetCooldownFromDurationObject`, `StatusBar:SetTimerDuration`,
  `C_DurationUtil.CreateDurationTextBinding`.
- `C_CurveUtil.CreateCurve` and `CreateColorCurve` map a secret onto alpha, color or desaturation
  (`APIDoc/CurveUtilDocumentation.lua`, `DurationUtilDocumentation.lua`, **VERIFIED**).
- Setters that accept secrets from addons: `SetText`, `SetTexture`, `SetVertexColor`, `SetAlpha`,
  `SetDesaturated`, `StatusBar:SetValue` (cooldown-manager.md §4, **VERIFIED** there).
- `Cooldown:SetCooldown` **rejects** secrets, so `Filger.lua:245` errors on a secret aura. The cooldown
  path (`Filger.lua:564-566`) already avoids it.

**Server-side filters** (**VERIFIED**)

- Filter strings, from `Blizzard_FrameXMLUtil/AuraUtil.lua:270-288`: `HELPFUL`, `HARMFUL`, `PLAYER`,
  `RAID`, `CANCELABLE`, `INCLUDE_NAME_PLATE_ONLY`, `MAW`, `EXTERNAL_DEFENSIVE`, `CROWD_CONTROL`,
  `RAID_IN_COMBAT`, `RAID_PLAYER_DISPELLABLE`, `BIG_DEFENSIVE`, `IMPORTANT`, `DISPELLABLE`.
  - A leading `!` negates a component (`!PLAYER`). `NOT_CANCELABLE` was removed; use `!CANCELABLE`. The
    `config.lua:21` comment is outdated on Retail.
  - The server applies them, so they work on secret auras.
- Server sort: `Enum.UnitAuraSortRule` `Default`, `BigDefensive`, `Expiration`, `ExpirationOnly`, `Name`,
  `NameOnly` (`APIDoc/UnitAuraSharedDocumentation.lua`).
- `CustomAuraContainerTemplate` candidate filters, checked in secure code
  (`Blizzard_AuraContainer/Blizzard_AuraContainerUtil.lua:89-170`):
  - Spell and dispel lists: `includeSpellIDs`, `excludeSpellIDs`, `includeDispelTypes`,
    `excludeDispelTypes`.
  - Source and type flags: `canApplyAura`, `isBossAura`, `isBossOrRoleAura`, `isFromPlayerOrPlayerPet`,
    `isRoleAura`, `isPriorityAura`, `isStealable`.
  - Other: `maxDuration`, `nameplateShowAll`, `nameplateShowPersonal`, `processedAuraType`.
- Spell-ID filters are gated by `CanApplyIdentityCandidateFilters`
  (`Blizzard_AuraContainerUtil.lua:52-87`):

| Aura | ID filter allowed? | If not allowed |
|---|---|---|
| Spell is `NeverSecret` | Always | — |
| Helpful, on player / group member / their pet | Yes | — |
| Harmful, on a unit the player can assist (player, friendly target) | **No** | `includeSpellIDs` → aura **rejected**; `excludeSpellIDs` → ignored, aura **passes** (`:106-111`) |
| Helpful, on a unit the player can't assist (hostile target) | **No** | Same |
| Harmful on hostile; helpful on friendly | Yes | — |

  The source says this restriction is deliberate: "it shouldn't be possible to filter out debuffs on
  player targets … if encounter-specific debuffs are applied to the player". cooldown-manager.md §6 says
  every aura passes when the gate refuses. That is only true for exclude lists.

**Other exposed systems**

- Aura containers: `Blizzard_AuraContainer` frames are `DenyTaintedAccessWhenAurasAreSecret`
  (`Blizzard_AuraContainerShared.lua:108`). The buttons offer `AddDispelTypeTexture`
  (`Blizzard_CustomAuraButton.lua:112`) and `SetDurationText` (`:178`). **VERIFIED**. Whether Filger can
  create, anchor and style them without taint is **UNVERIFIED** (ElvUI does).
- Cooldown Manager: addons can read the static catalog; the live state is secret. See cooldown-manager.md
  §4–§8.
- Private auras (many boss mechanics) are never returned by `C_UnitAuras`. Blizzard shows them through
  `C_UnitAuras.AddPrivateAuraAnchor(args)`. Addon code can call it in combat while auras are secret:
  **VERIFIED** (Experiment 6).

### Classic clients

| Client | Secret flags on aura APIs | Modern aura/duration API present | CDM loads | AuraContainer | Filter strings |
|---|---|---|---|---|---|
| Retail 12.1.5 (`standard`) | Yes (15 functions) | Yes | Yes | Yes | Full list incl. `IMPORTANT`, `DISPELLABLE`, `!` |
| Forever 1.60.1 (`camelot`) | Yes (15) | Yes | Yes (`standard, camelot`) | Yes | Same as Retail (**UNVERIFIED** line by line) |
| MoP 5.5.4 | 0 | Yes | No (`standard` only) | No | Up to `BIG_DEFENSIVE` in `AuraUtil.lua`, but in game (Experiment 5): no `!` negation, `BIG_DEFENSIVE` ignored; keeps `NOT_CANCELABLE`; no `IMPORTANT`/`DISPELLABLE` |
| Titan WotLK 3.80.2 | 0 | Yes | No | No | Same as MoP (**VERIFIED** for MoP and Era; Titan/TBC assumed identical, **UNVERIFIED**) |
| TBC 2.5.6 | 0 | Yes | No | No | See above |
| Era 1.15.9 | 0 | Yes | No | No | Same as MoP |
| Cata | No worktree | **UNVERIFIED** | — | — | — |

- **VERIFIED** by grep in each worktree: the `classic*` API docs list the same functions as Retail.
  - Auras: `C_UnitAuras.GetAuraSlots`, `GetAuraDataBySlot`, `GetUnitAuraInstanceIDs`, `GetAuraDuration`,
    `GetUnitAuraBySpellID`.
  - Secrets and display: `C_Secrets.*`, `SetCooldownFromDurationObject`, `GetSpellCooldownDuration`,
    `CreateColorCurve`.
  - What differs is that the secret flags are missing and the Blizzard addons that load.
- Whether the Classic servers fill the new flags (`BIG_DEFENSIVE`, `EXTERNAL_DEFENSIVE`, …) is
  **UNVERIFIED**.
- What Filger must branch on:
  - Secret mode: `C_Secrets.HasSecretRestrictions()`, which exists everywhere and is documented to be false
    when the build has no restrictions.
  - Whether `CustomAuraContainerTemplate` exists.
  - The Vanilla tooltip by index (`Filger.lua:37-39`, `365-367`).
  - The filter-string vocabulary (`!CANCELABLE` vs `NOT_CANCELABLE`, the Retail-only `IMPORTANT` and
    `DISPELLABLE`).
  - Whether `GameTooltip:SetUnit{Buff,Debuff}ByAuraInstanceID` exists. It's a widget method that isn't in
    the API docs; already guarded at `Filger.lua:40`; **UNVERIFIED** per client.

## Options

Each option is a different design, not a variant of another one. Every option keeps cooldowns list-driven
(spell IDs are Filger's own and are queried directly), plus `isActive`/`isOnGCD` and duration objects.

### A. Secret-safe filters: only what the server can decide

- **What:** each aura frame becomes an AuraContainer built from filter strings and boolean candidate
  filters. Nothing reads aura fields in Lua. Proposed mapping (Filger frame → server filter):
  - PLAYER_DEBUFFS → `HARMFUL` (all debuffs; Stagger only if never-secret)
  - PLAYER_AURAS → `HELPFUL|PLAYER` + `includeSpellIDs` (allowed)
  - PLAYER_BUFFS → `HELPFUL|!PLAYER` + `excludeSpellIDs` (blacklist allowed)
  - TARGET_DEBUFFS hostile → `HARMFUL|PLAYER`; friendly → `HARMFUL|!PLAYER` (no ID filters)
  - TARGET_AURAS → `HELPFUL`; on hostile units, `isStealable` or `IMPORTANT`
  - FOCUS_DEBUFFS / BOSS_DEBUFFS → `HARMFUL` + `isBossAura = true`
- **Avoids secrets:** the server and Blizzard secure code do every comparison.
- **Works on:** Retail and Forever. Classic doesn't need it (no container there).
- **Screen:** cleaner than plain phase 2 on player buffs and own DoTs. More cluttered on player debuffs and
  hostile-target buffs.
- **Lost:** stack thresholds, priority, the blacklist on debuff frames, name filters, `sourceUnit == nil`,
  the LibDispel flash, Filger's own timer text.
- **Maintenance:** low. The filter strings live in `config.lua`.
- **Effort:** M. **Risk:** medium. The container is new in 12.1, and its API and the identity gate can
  change.
- **Verify out of combat:** the container builds and the filter strings return the expected auras on a
  dummy (Experiments 4, 5). The identity gate only bites in combat (Experiment 4).
- **Evidence:** filters and the gate are VERIFIED. That Filger can use the container is UNVERIFIED.

### B. Curated lists plus coarse filters (all inside the container)

- **What:** A, plus a small exact list where ID filtering is allowed. Both live in container groups. On
  Mainline, B doesn't mix the container with a `UNIT_AURA` path: in combat that path sees only secrets,
  and out of combat the container already works.
  - Each class's defensives and procs on the player: `includeSpellIDs`, sorted by `Expiration`.
  - The player's own debuffs on a hostile target.
  - Priority tiers become separate aura groups ordered by `layout.layoutIndex` (UNVERIFIED that the order
    holds).
- **Avoids secrets:** the list is handed to the container; Filger never compares it.
- **Works on:** both. On Classic the same `data/` list feeds today's Lua filter, priorities and stack
  thresholds included.
- **Screen:** close to phase 1 on the player and target frames. Phase-2 style on the debuff frames.
- **Lost:** as in A, but the curated frames keep exactness.
- **Maintenance:** a handful of spells per class, and no boss-debuff list on Retail.
- **Effort:** M. **Risk:** the same as A.
- **Verify:** Experiments 3 and 4.
- **Evidence:** VERIFIED design; usability is UNVERIFIED.

### C, D. Spell data

Moved to [spell-data-generation.md](spell-data-generation.md) (learn mode, generated data). A later
iteration, after Filger works on every game version. Until then `data/` stays unchanged.

### E. Lean on Blizzard's frames

- **What:** skin the CDM viewers and anchor Filger next to them. Show boss mechanics through private-aura
  anchors. Blizzard's buff frames are the fallback for everything else.
- **Avoids secrets:** Blizzard does all the logic.
- **Works on:** Retail and Forever.
- **Cost:** the tracked set lives in `/cdm` (per character, outside `data/`), which goes against "decisions
  in code". Edit Mode owns position. There's no focus support, and the CDM shows only auras the player
  cast.
- **Effort:** S (skin). **Risk:** high coupling to Blizzard internals.
- **Evidence:** cooldown-manager.md §7–§10 (VERIFIED). Private-aura anchors from addons work (Experiment 6).

### F. Architecture: split vs one path

- **F1 (chosen): split the aura implementation per client family** with the TOC `[Family]` token. The
  families match the secret boundary exactly:

  | `[Family]` folder | Clients | Secrets | Container | Aura implementation |
  |---|---|---|---|---|
  | `Mainline` | Retail (`standard`), Forever (`camelot`) | yes | yes | AuraContainer only |
  | `Classic` | Era, TBC, Titan, MoP (and Cata) | no | no | Today's `UNIT_AURA` + `GetAuraSlots` + Lua filters |

  - `[Game]` would need identical copies in `Standard/` and `Camelot/`, and again in every Classic folder.
    `[Family]` is too coarse for spell data (compatibility.md), but it is the right grain for the
    implementation. Blizzard uses the same pattern (`Blizzard_AuraContainer.toc`:
    `[Family]\Blizzard_AuraButtonTooltip.xml`, folders `Classic/` and `Mainline/`, **VERIFIED**).
  - For:
    - No runtime client branches.
    - The Classic file is today's code, so there's no regression risk there.
    - The Mainline file can drop `ScanSpellAuras`, `self.restricted` and the `issecretvalue` guards in the
      aura path.
  - Against:
    - The look must be kept identical across two files.
    - A client that changes family behavior later (Classic gaining secrets) means moving a file instead of
      flipping a check.
- **F2 (rejected): one file**, with `Spawn` choosing the source via
  `C_Secrets.HasSecretRestrictions() and CustomAuraContainerTemplate`. Once Mainline is container-only,
  the two paths share no aura logic, so the branch would only select between two unrelated
  implementations inside one file.
- **What's split and what's shared:**

  | Per family (`core\[Family]\...`) | Shared (untagged) |
  |---|---|
  | Aura element: container groups vs today's `aura_proto` | `Filger:CreateButton` / button styling |
  | Aura frame definitions: filter strings and groups vs `FilterAura`/`SortAuras` closures | Layout (`SetPosition`), `Spawn` skeleton |
  | Aura tooltips | `data/`, colors, fonts, commands, `config.lua` general settings |
  | | Cooldowns: the secret branch is per spell via `ShouldSpellCooldownBeSecret`, non-secret on Classic |

- TOC sketch (file names illustrative):

  ```text
  core\init.xml
  config.lua
  core\[Family]\auras.lua
  Filger.lua
  ```

  Every family folder must contain every listed file, as with `[Game]`.
- Guard: the Mainline file should warn once at load if `CustomAuraContainerTemplate` is missing, instead
  of silently showing nothing.

### G. Drop what can't survive

- **What:** in secret mode, hide the frames that depend on "show everything except" logic
  (PLAYER_DEBUFFS, TARGET_AURAS, FOCUS_DEBUFFS), or let them fall back to raw filter strings. Keep player
  auras, own DoTs and cooldowns.
- **Works on:** Retail and Forever. Classic is unchanged.
- **Screen:** cleaner but less informative. Debuffs on the player must come from Blizzard's frames.
- **Effort:** S. **Risk:** low.
- **Evidence:** VERIFIED.

## Comparison

| Option | Clients | Screen | Lost vs phase 1 / phase 2 | Maintenance | Effort | Risk | Evidence |
|---|---|---|---|---|---|---|---|
| A. Secret-safe filters | Retail, Forever | Mixed: clean on own buffs/DoTs, cluttered on debuffs | Stacks, priority, debuff blacklist, name filters, dispel flash, own timer | Low | M | Medium (new container) | Rules VERIFIED; use UNVERIFIED |
| B. Curated lists + coarse filters | All (Classic via current logic) | Near phase 1 on player/target; phase 2 on debuffs | As A, minus exactness on curated frames | Low–medium (short lists) | M | Medium | As A |
| E. Blizzard frames | Retail, Forever | Blizzard's look | Units, data in code, position | Lowest code, user-side `/cdm` | S | High coupling | Mostly VERIFIED |
| F1. Family split (chosen) | All | — | — | Two aura files, one `data/` | Part of A/B | Low; `[Family]` on Forever unverified | TOC pattern VERIFIED in Blizzard source |
| F2. One path + feature check (rejected) | All | — | — | One file, two unrelated paths | Part of A/B | Low | VERIFIED APIs |
| G. Drop features | Retail, Forever | Cleaner, less info | Debuff frames | Lowest | S | Low | VERIFIED |

## Recommendation

**Decided: F1 family split.**

- **Mainline (Retail, Forever):** AuraContainer only. Option A's filter strings and flags, plus B's
  curated `includeSpellIDs`/`excludeSpellIDs` on the frames where ID filtering is allowed: PLAYER_AURAS
  (class list), PLAYER_BUFFS (blacklist), own DoTs on a hostile target. No `UNIT_AURA` path.
- **Classic:** today's implementation, unchanged.
- **Shared:** buttons, layout, `data/`, cooldowns.
- E isn't recommended: it moves the decisions out of code. Spell data (C, D) is a later iteration
  ([spell-data-generation.md](spell-data-generation.md)).

### Migration (each phase ships on its own)

1. **Phase 0: fixes that work today.**
   - Read `cdInfo.isEnabled` (`Filger.lua:648`).
   - On secret auras, use `C_UnitAuras.GetAuraDuration` + `SetCooldownFromDurationObject` instead of
     `SetCooldown` (`Filger.lua:244-245`), provided Experiment 2 passes.
   - Refresh only the event's `spellID` in `SPELL_UPDATE_COOLDOWN`.
2. **Phase 1: the split, with no behavior change.**
   - Move `aura_proto` and the aura frame definitions into `core/Classic/` and add `core\[Family]\...` to
     the TOC.
   - Start `core/Mainline/` as a copy, so Retail behaves as it does today.
   - Check in game that `[Family]` resolves on every client, Forever included.
3. **Phase 2: Mainline container for PLAYER_AURAS and PLAYER_BUFFS.** PLAYER_AURAS uses
   `HELPFUL|PLAYER` + `includeSpellIDs`; PLAYER_BUFFS uses `HELPFUL|!PLAYER` + `excludeSpellIDs`. Both
   frames are allowed to filter by ID.
4. **Phase 3: the remaining Mainline frames.**
   - TARGET_DEBUFFS (`HARMFUL|PLAYER` on hostile units), TARGET_AURAS, FOCUS_DEBUFFS.
   - BOSS_DEBUFFS (`isBossAura`; plus private-aura anchors, Experiment 6).
   - PLAYER_DEBUFFS shows only important debuffs, one group each: `HARMFUL|RAID_PLAYER_DISPELLABLE`,
     `HARMFUL|CROWD_CONTROL`, `isBossAura`. ~~Stagger by ID~~: not possible, Stagger is contextually
     secret (Experiment 3).
   - Then delete the copied event path from `core/Mainline/`.

### Impossible in secret mode on Retail and Forever (drop or replace)

| Feature | Status | Replacement |
|---|---|---|
| `stackThreshold` (`Filger.lua:309`) | Impossible | None |
| Numeric `priority` sort (`Filger.lua:282`, `config.lua:115`) | Impossible | Approximate with aura groups (UNVERIFIED) |
| Blacklist/whitelist by ID on debuffs on the player or a friendly target, and on buffs on a hostile target | Blocked by design | Never-secret spells only |
| Blacklist by name (`"Well Fed"`, `"Food"`, …) | Impossible | Exclude by spell ID where allowed |
| `sourceUnit == nil` (`config.lua:156`, `171`) | Impossible | `isBossAura` |
| LibDispel type/dispelable lookups, dispel flash (`Filger.lua:347-348`, `200-206`) | Impossible | `RAID_PLAYER_DISPELLABLE`/`DISPELLABLE` group + `AddDispelTypeTexture` / `GetAuraDispelTypeColor` (UNVERIFIED) |
| Dispel-colored border via `Filger.colors[dispelName]` (`Filger.lua:187`) | Impossible as a table key | `GetAuraDispelTypeColor(curve)` → `SetBackdropBorderColor` (UNVERIFIED that the backdrop accepts secrets) |
| Own timer text and red under 5 s (`Filger.lua:72-92`) | Impossible | Duration text binding + color curve (works for cooldowns, verified on Retail) |
| Sorting auras by expiration in Lua | Impossible | Container `Expiration` sort |
| Sorting cooldowns by remaining time while secret (`Filger.lua:620`) | Impossible | Fixed list order |
| Incremental `UNIT_AURA` bookkeeping keyed by `auraInstanceID` | Impossible | Container handles updates |

### Classic

Same branch, same TOC, its own aura file (`core/Classic/`), which is today's code. Classic has no
secret flags, so today's logic keeps working there, including the boss-debuff and blacklist data.
Filter-string differences (`NOT_CANCELABLE`) stay inside each family's frame definitions. The Vanilla
tooltip-by-index branch stays inside the Classic file.

## Experiments

Run each one on Retail, and on the Classic clients where noted. Unless stated otherwise, run them **in
combat** (target dummy, then a dungeon boss).

1. **Restriction state.**
   `/run print(C_Secrets.HasSecretRestrictions(), C_Secrets.ShouldAurasBeSecret(), C_Secrets.ShouldCooldownsBeSecret())`
   on every client: out of combat, in combat in the open world, in a dungeon out of combat, and in a boss
   fight. Pass: Classic prints `false false false` everywhere.
   - **Result (2026-10-21):**
     - Retail: `true false false` out of combat (open world and dungeon); `true true true` in combat
       (dummy and boss). Restrictions follow combat state; a dungeon alone doesn't restrict these APIs.
       `HasSecretRestrictions()` is always `true`, so it tells which client this is, not whether data
       is secret right now.
     - Era, TBC, MoP: `false false false` (open world, in and out of combat). Dungeon steps skipped,
       since `HasSecretRestrictions()` is false on these clients.
     - Forever, Titan: not tested (no client).
2. **Instance IDs from tainted code.**
   `/run local t=C_UnitAuras.GetUnitAuraInstanceIDs("player","HELPFUL"); local id=t[1]; print(issecretvalue(id), pcall(function() return #t end), pcall(C_UnitAuras.GetAuraDuration,"player",id))`.
   Settles whether `GetAuraDuration` and the `#` count work on secret IDs.
   - **Result (2026-10-21, Retail, in a dungeon):**
     - Out of combat: `false true true LuaDurationObject: …`. IDs aren't secret, and `GetAuraDuration`
       works. The middle `pcall` printed only `true` because a call that isn't last in an argument list
       keeps only its first return value. That's a flaw in the snippet, not a finding.
     - In combat: the first call already errors with `GetUnitAuraInstanceIDs(): Auras cannot be accessed
       when secret while tainted by '*** ForceTaint_Strong ***'`. `RequiresUnitAuraAccess` is a
       `Precondition` with `FailureMode = "Error"` (`APIDoc/SecretPredicatesDocumentation.lua:48`). It
       is set on 18 `C_UnitAuras` functions, including `GetAuraSlots`, `GetAuraDataBySlot`,
       `GetAuraDataByAuraInstanceID`, `GetUnitAuraInstanceIDs`, `GetUnitAuras`, `GetAuraDuration`,
       `IsAuraFilteredOutByInstanceID`, `GetAuraDispelTypeColor` and `GetAuraApplicationDisplayCount`.
       So the problem isn't that instance IDs are secret: tainted code can't reach any instance ID at
       all.
     - Consequence: in combat on Retail, the only aura data an addon can read itself comes from the
       `RequiresNonSecretAura` lookups (`GetPlayerAuraBySpellID`, `GetUnitAuraBySpellID`, …) for
       never-secret spells. Everything else needs the AuraContainer.
     - Caveat: `/run` is tainted with `ForceTaint_Strong`. Addon code is tainted too, so the result
       should be the same for Filger, but that is **UNVERIFIED** from an addon file.
3. **Never-secret coverage** (out of combat is fine). A dev command loops over `Filger.spells`,
   `Filger.blacklist` and `Filger.cooldowns` and counts `C_Secrets.GetSpellAuraSecrecy(id) == Enum.SecrecyLevel.NeverSecret`.
   Also check Stagger: `/run for _,id in ipairs({124273,124274,124275}) do print(id, C_Secrets.GetSpellAuraSecrecy(id)) end`.
   - **Result (2026-10-21, Retail, `/run` loops; cooldowns checked with `GetSpellCooldownSecrecy`):**
     - `Filger.spells` (all classes): 1/100 never-secret (344179). In combat, `ScanSpellAuras`
       finds almost nothing.
     - `Filger.blacklist` (numeric keys): 17/313 never-secret: 80354 404464 404468 462854 390435
       381753 1126 206151 2823 3408 6673 1459 57723 57724 369459 264689 21562. Only these can be
       ID-filtered on debuffs on the player.
     - `Filger.cooldowns`: 0/28. Every cooldown is contextually secret, so the duration-object
       path is required in combat.
     - Stagger 124273/124274/124275: `2` (`ContextuallySecret`). Stagger is a harmful aura on the
       player, so the identity gate blocks it. A Stagger group by ID is impossible on Retail.
4. **Container test addon** (about 30 lines, `CreateFrame("AuraContainer", nil, UIParent, "CustomAuraContainerTemplate")`):
   - one group `HELPFUL|PLAYER` with `includeSpellIDs`
   - one group `HARMFUL` on `player` with `includeSpellIDs` (expected empty in combat) and with
     `excludeSpellIDs` (expected unfiltered)
   - `SetUnit("focus")`
   - Pass: no taint errors, and the filters behave as the gate table says.
   - **Result (2026-10-22, Retail, Brewmaster, target dummy):** `/filger exp4 101643,124275`
     (`core/development.lua`), Transcendence as the buff, Light Stagger as the debuff.
     - Out of combat: T1 shows Transcendence. T2/T3 not checked (Stagger falls off after combat).
     - In combat: T1 Transcendence; T2 (`HARMFUL` + include Stagger) **empty**; T3 (`HARMFUL` +
       exclude Stagger) **shows Light Stagger**; T4 (focus `HARMFUL`) shows Keg Smash and Mystic Touch.
       No errors reported. Matches the gate table: ID filters on debuffs on the player are refused.
     - `CustomAuraButtonTemplate` has no regions. Without an `initializeFrame` that calls `SetIcon`,
       buttons draw nothing (first run showed an empty T1).
5. **Filter strings.** `/run print(#{C_UnitAuras.GetAuraSlots("player","HELPFUL|!PLAYER")}-1)`, then the
   same for `HELPFUL|BIG_DEFENSIVE`, `HARMFUL|RAID_PLAYER_DISPELLABLE` and `HELPFUL|!CANCELABLE`. Run it
   with a known defensive up, on Retail and each Classic client. Out of combat is fine.
   - Now `/filger exp5` (`core/development.lua`). Unknown tokens don't error, they're ignored: a count
     equal to the `HELPFUL`/`HARMFUL` baseline means the token is unknown or matches everything.
   - **Result (2026-10-22, Retail, solo, out of combat):** Celestial Brew, Fortifying Brew, Tiger's
     Lust and a trinket buff up; no debuffs.
     - `HELPFUL` 17; `PLAYER` 17 + `!PLAYER` 0 = 17; `CANCELABLE` 17 + `!CANCELABLE` 0 = 17. Negation
       works.
     - `NOT_CANCELABLE` 17 (= baseline): removed on Retail and silently ignored, no error.
     - `BIG_DEFENSIVE` 1, `IMPORTANT` 1: applied by the server (below baseline). Which buff each
       matched wasn't recorded.
     - `RAID_PLAYER_DISPELLABLE`, `DISPELLABLE` 0: inconclusive, `HARMFUL` was 0.
     - Not tested: a buff from another caster, a dispellable debuff.
   - **Result (2026-10-22, MoP, solo, out of combat):** no debuffs.
     - `HELPFUL` 7; `PLAYER` 6 works.
     - `!` negation is **not supported**: `!PLAYER` 7 and `!CANCELABLE` 7 equal the baseline, so the
       negated token is ignored. Confirmed with a Paladin's Hand of Freedom on the player: `HELPFUL` 4,
       `PLAYER` 2, `!PLAYER` 4 (should be 2).
     - `CANCELABLE` 7 + `NOT_CANCELABLE` 0 = 7: `NOT_CANCELABLE` works on MoP.
     - `BIG_DEFENSIVE` 7 and `IMPORTANT` 7 (= baseline): ignored. This contradicts the client table,
       which lists `BIG_DEFENSIVE` for MoP from `AuraUtil.lua`; the token is known to the UI code but
       the server doesn't apply it.
     - Dispel filters 0: inconclusive.
     - Classic auras use only `HELPFUL`, `HARMFUL` and `PLAYER|HELPFUL` (`core/Classic/auras.lua`),
       so nothing breaks today. Classic filters must not use `!` or the new flags.
     - Era and TBC skipped: the container filter strings are Mainline only, and Classic keeps its
       Lua filtering.
6. **Private aura anchors.** In a test addon, call `C_UnitAuras.AddPrivateAuraAnchor{ unitToken="player",
   auraIndex=1, parent=frame, showCooldownFrame=true, iconInfo={ iconAnchor={point="CENTER",
   relativeTo=frame, relativePoint="CENTER", offsetX=0, offsetY=0}, iconWidth=40, iconHeight=40 } }`. It
   needs a dungeon boss that applies a private aura. Pass: no error, and the icon shows.
   - Now `/filger exp6` (`core/development.lua`): anchors for `auraIndex` 1–3 on the player.
   - **Result (2026-10-22, Retail, Aberrus, Echo of Neltharion, solo):** run in combat:
     `aurasSecret true`, anchor IDs 3133–3135, no error. Two different private debuffs (Volcanic Heart
     among them) drew in the anchor slots. Blizzard's raid frames didn't show them (solo, so likely no
     raid frames; not investigated).
7. **Cooldown edges.** In combat, print `issecretvalue` for `GetInventoryItemCooldown("player",13)` and
   `C_Container.GetItemCooldown(<potion>)`. Log which of the player's own spells arrive with a secret
   `spellID` in `UNIT_SPELLCAST_SUCCEEDED`.
8. **Tooltips.** `/run print(GameTooltip.SetUnitBuffByAuraInstanceID ~= nil, GameTooltip.SetUnitAura ~= nil)`
   on each Classic client.
9. **`[Family]` loading.** Add a one-line `print` to each `core/<Family>/` stub. `/reload` on every
   client: Retail and Forever must print Mainline, the rest Classic, and exactly one line must print per
   client. Out of combat is fine.
   - **Result (2026-10-21):** Retail prints `Mainline`; Era, TBC and MoP print `Classic`, one line
     each. Forever and Titan not tested (no client).

## Open questions for you

1. ~~PLAYER_DEBUFFS on Retail~~ Decided: important debuffs only (dispellable, crowd control, boss,
   Stagger); not every DoT. See Phase 3.
2. ~~Spell data (`FilgerData` dump, Classic boss data, `data/Cata/`)~~ Moved to
   [spell-data-generation.md](spell-data-generation.md).
