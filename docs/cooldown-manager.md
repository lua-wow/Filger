# Cooldown Manager and Secret Values (Retail)

Investigation of Blizzard's Cooldown Manager (CDM), its Secret Values handling, ElvUI's use of
it, and what that means for Filger on Retail. Investigation only: no code was changed.

- Shared doc (same report, with diagram and comments):
  <https://claude.ai/code/artifact/441b5368-cdfc-4dcd-a35d-57a5d3c882a3>
- Sources: `../refs/wow-ui-source` (`live`, 12.1.0.69933; `worktrees/forever` 1.60.1),
  `../refs/ElvUI` (`ba7229feda`, 2026-10-04). Paths below are relative to
  `../refs/wow-ui-source/Interface/AddOns/` unless stated otherwise.
- As of 2026-10-04. Anything marked "unverified" needs an in-game check (see the last section).

## Summary

- The CDM works under secrets because all of its comparisons run in **untainted** Blizzard code.
  It does `expirationTime > now` and keys tables by secret `auraInstanceID` via `secretunwrap`
  (`Blizzard_CooldownViewer/CooldownViewerSecure.lua`). `secretunwrap` is removed from the addon
  environment (`Blizzard_EnvironmentCleanup/EnvironmentCleanup.lua:280`). Filger can't copy it.
- Addons can **display** almost everything but **branch on** little. Display setters accept
  secrets; `Cooldown:SetCooldown` doesn't, so use `SetCooldownFromDurationObject`.
- 12.1 added `CustomAuraContainerTemplate` (`Blizzard_AuraContainer`). It is addon-creatable;
  Blizzard secure code filters (`filterString`, `includeSpellIDs`), sorts and times the auras.
  ElvUI builds all its Retail auras on it.
- ElvUI only reskins the CDM viewers. It never moves or replaces them; Edit Mode owns position.
- Filger's model (enumerate auras, filter by spell ID in Lua, sort by expiration) breaks in
  combat. Its never-secret and duration-object paths still work.
- Classic Forever (`camelot`) behaves like Retail: it ships the CDM, `Blizzard_AuraContainer`
  and the same secret flags. The other Classic clients have none of these.

## 1. Blizzard architecture

`Blizzard_CooldownViewer` (TOC `AllowLoadGameType: standard`; Forever: `standard, camelot`).

| Layer | File | Object / mixin | Responsibility |
|---|---|---|---|
| C API (catalog) | `Blizzard_APIDocumentationGenerated/CooldownViewerDocumentation.lua` | `C_CooldownViewer.GetCooldownViewerCategorySet`, `GetCooldownViewerCooldownInfo`, `Get/SetLayoutData`, `IsCooldownViewerAvailable` | Server-defined trackable cooldownIDs per spec/category; opaque saved layout string |
| Data provider | `CooldownViewerSettingsDataProvider.lua` | `CheckBuildDisplayData`, `GetOrderedCooldownIDsForCategory`, `GetCooldownInfoForID` | Merges catalog + user layout into ordered cooldownID lists |
| Persistence | `CooldownViewerSettingsLayoutManager.lua`, `CooldownViewerSettingsDataStoreSerialization.lua` | `C_CooldownViewer.Get/SetLayoutData` | Per-spec layouts and alerts, server-side string (not SavedVariables) |
| Settings UI | `CooldownViewerSettings.lua/.xml`, `SlashCommandRegistration.lua` | `CooldownViewerSettings`, `/cdm` | Editor; fires `EventRegistry` `CooldownViewerSettings.OnDataChanged` |
| Viewer base | `CooldownViewer.lua` | `CooldownViewerMixin` | Frame pool, event fan-out, aura-instance → item map, OnUpdate registry, `GridLayoutFrame` layout |
| Viewers | `CooldownViewer.lua`, `CooldownViewer.xml` | `CooldownViewerCooldownMixin` → Essential/Utility; `CooldownViewerBuffMixin` → BuffIcon/BuffBar | Cooldown viewers add spell events; buff viewers add stride rules and bars |
| Item data | `CooldownViewerItemData.lua` | `CooldownViewerItemDataMixin` | cooldownID → spell/override/linked spell; aura on `player` then `target`; totems; charges; icon; name |
| Item behaviour | `CooldownViewer.lua` | `CooldownViewerItemMixin` → `CooldownViewerCooldownItemMixin`, `CooldownViewerBuffItemMixin` | Picks the display source, feeds `Cooldown`, `StatusBar`, font strings |
| Secure helper | `CooldownViewerSecure.lua` (`[LoadIntoEnvironment secure]`) | `addonTable.CreateSecureAuraInstanceMap` | Secret `auraInstanceID` as map key via `secretunwrap` + `settablesecurity` |
| Alerts | `CooldownViewerAlert.lua`, `CooldownViewerSoundAlertData.lua`, `CooldownViewerVisualAlertTarget.lua` | `CooldownViewerAlert_PlayAlert` | Available, PandemicTime, OnCooldown, ChargeGained, OnAuraApplied/Removed |
| Edit Mode | `Blizzard_EditMode` | `EditModeCooldownViewerSystemMixin` | Position, size, orientation, visibility, padding, bar content |

| Global frame | Item template (size) | Category | Managed frame |
|---|---|---|---|
| `EssentialCooldownViewer` | `CooldownViewerEssentialItemTemplate` (50×50) | `Essential` (0) | yes, `layoutIndex` 10 |
| `UtilityCooldownViewer` | `CooldownViewerUtilityItemTemplate` (30×30) | `Utility` (1) | yes, `layoutIndex` 11 |
| `BuffIconCooldownViewer` | `CooldownViewerBuffIconItemTemplate` (40×40) | `TrackedBuff` (2) | yes, `layoutIndex` 9 |
| `BuffBarCooldownViewer` | `CooldownViewerBuffBarItemTemplate` (220×30) | `TrackedBar` (3) | no |

## 2. Data flow

```text
spell/aura state (client)
    ↓  C_CooldownViewer.GetCooldownViewerCategorySet / GetCooldownViewerCooldownInfo  (static, public)
CooldownViewerSettingsDataProviderMixin  (+ user layout from C_CooldownViewer.GetLayoutData)
    ↓  GetOrderedCooldownIDsForCategory(category)
CooldownViewerMixin:RefreshLayout  → pool:Acquire() per ID → itemFrame:SetCooldownID(id)
    ↓  events fan out: SPELL_UPDATE_COOLDOWN, UNIT_AURA(player,target), PLAYER_TARGET_CHANGED, ...
item frame: RefreshData → RefreshAuraInstance, CacheChargeValues, CacheCooldownValues
    ↓  live APIs: C_Spell.GetSpellCooldown/GetSpellCharges, C_UnitAuras.GetUnitAuras, GetTotemInfo
visuals: CooldownFrame_Set, StatusBar:SetValue, FontString:SetText, ActionButtonSpellAlertManager
```

Everything above runs in untainted Blizzard code. Addons only enter through post-hooks.

1. Catalog: `CheckBuildDisplayData` calls `GetCooldownViewerCategorySet(category, true)` and
   `GetCooldownViewerCooldownInfo(id)`, then merges `GetLayoutData`
   (`CooldownViewerSettingsDataStoreSerialization.lua:65`).
2. Viewer: `RefreshLayout` acquires `max(#ids, 2)` pooled frames. Events registered in `OnShow`
   fan out to items; `UNIT_AURA` goes through `OnUnitAura` and the secure
   `auraInstanceIDToItemFramesMap`.
3. Item: `OnCooldownIDSet` caches `cooldownInfo`. `CacheCooldownValues` picks one source in
   priority order: charges, spell cooldown, aura/totem, equipped item, edit-mode dummy.
4. Visuals: `CooldownFrame_Set(cooldown, start, duration, enabled, edge, modRate)`; BuffBar sets
   `StatusBar:SetValue(expirationTime - GetTime())` every frame.

The CVar `cooldownViewerEnabled` and `C_CooldownViewer.IsCooldownViewerAvailable` gate the whole
viewer (`CooldownViewerMixin:ShouldBeShown`).

## 3. Each viewer's role

| | Essential / Utility (`CooldownViewerCooldownItemMixin`) | BuffIcon / BuffBar (`CooldownViewerBuffItemMixin`) |
|---|---|---|
| Shows | Spec spells, equipped trinkets, spell-category items | Self-buffs and target debuffs applied by a tracked spell; totems |
| List source | `GetCooldownViewerCategorySet` via the data provider | Same; each cooldownID has `linkedSpellIDs` (auras that count) |
| Creation | `RefreshLayout` → pool → `SetCooldownID` | Same; inactive items keep their slot (`includeAsLayoutChildWhenHidden`) |
| Update | `SPELL_UPDATE_COOLDOWN` → `NeedsCooldownUpdate` → `RefreshData` or `RefreshCooldownOnly` (GCD); usable, range, glow, totem, bag events | `UNIT_AURA` via secure map (removed/updated) or `NeedsAddedAuraUpdate` (added); `PLAYER_TARGET_CHANGED`; BuffBar OnUpdate while active |
| Duration | `cooldownStartTime/Duration/ModRate` → `CooldownFrame_Set` | Icon: `CooldownFrame_Set(exp - dur, dur)` + `SetUseAuraDisplayTime(true)`; Bar: per-frame `SetValue` + `COOLDOWN_DURATION_SEC` text |
| Icon | `GetSpellTexture`: category icon → active aura icon → equip slot → linked spell → `overrideTooltipSpellID` → `C_Spell.GetSpellTexture(baseSpellID)` | Same |
| Filtering | Category + user layout; `isKnown`; `CooldownSetSpellFlags.HideAura`; category 1141 suppressed | `hideWhenInactive`; `sourceUnit == "player"` only; target filter `HARMFUL\|PLAYER` or `HELPFUL\|PLAYER\|INCLUDE_NAME_PLATE_ONLY`; `GetAssociatedAuraSpellPriority` |
| Addon access | Catalog yes; live timings secret (`SecretWhenCooldownsRestricted`) | Catalog yes; live aura fields secret (`SecretWhenUnitAuraRestricted`) |
| Equivalent addon frames | Yes for display (duration objects); no desaturate/flash logic in combat | Icons yes; bars only via `StatusBar:SetTimerDuration` |

The CDM never sorts by remaining time: fixed user order plus hide-when-inactive.

## 4. Secret Value boundaries

Secrets restrict **tainted** (addon) execution. How to read the flags in
`Blizzard_APIDocumentationGenerated/*.lua`:

- `SecretWhen…` on a function or event: returns or payload are secret under that condition
  (combat, encounter, M+, PvP; see `SecretPredicatesDocumentation.lua`). Spells can be flagged
  never or always secret.
- `NeverSecret = true` on a field: always readable.
- `SecretArguments`: `AllowedWhenTainted` lets addons pass secrets in; `AllowedWhenUntainted`
  (default, 3,573 functions) rejects secrets from addons; `NotAllowed` rejects them always.
- Inspection: `issecretvalue`, `canaccessvalue`, `issecrettable`, `scrubsecretvalues`
  (`FrameScriptDocumentation.lua`). `secretunwrap` is nil for addons.

Categories: **1** public, **2** conditional, **3** secret when restricted, **4** Blizzard-only,
**5** display-only for addons, **6** convertible via official API, **7** Blizzard-internal,
not reproducible.

| Data | API / source | Cat. | Notes |
|---|---|---|---|
| cooldownID list, cooldown info | `C_CooldownViewer.GetCooldownViewerCategorySet`, `GetCooldownViewerCooldownInfo` | 1 | Static catalog |
| CDM layout string | `C_CooldownViewer.Get/SetLayoutData` | 1 / 2 | Internal serialization; writing it is risky |
| `isActive`, `isEnabled`, `isOnGCD` | `C_Spell.GetSpellCooldown` (`SpellSharedDocumentation.lua`) | 1 | `NeverSecret` |
| `startTime`, `duration`, `modRate` | `C_Spell.GetSpellCooldown` | 3 → 5/6 | Display via `GetSpellCooldownDuration` → `SetCooldownFromDurationObject` |
| `maxCharges`, charge `isActive` | `C_Spell.GetSpellCharges` | 1 | `NeverSecret` |
| `currentCharges`, recharge times | `GetSpellCharges`, `GetSpellChargeDuration` | 3 → 5/6 | Count via `SetText`; recharge via duration object |
| Cast count | `C_Spell.GetSpellCastCount` | 3 → 5 | Text only |
| Spell name, icon, usable, range | `C_Spell.GetSpellName/GetSpellTexture/IsSpellUsable/IsSpellInRange` | 1 | No secret flags |
| Secrecy prediction | `C_Secrets.ShouldSpellCooldownBeSecret/ShouldSpellAuraBeSecret/ShouldAurasBeSecret/ShouldCooldownsBeSecret` | 1 | Plain booleans |
| `SPELL_UPDATE_COOLDOWN` payload | `SpellBookDocumentation.lua:862` | 1 | `spellID`, `baseSpellID`, `category`... not secret |
| `UNIT_SPELLCAST_SUCCEEDED` `spellID` | `UnitDocumentation.lua` | 2 | Secret for non-player/pet units or flagged spells |
| `UNIT_AURA` payload | `UnitAuraDocumentation.lua` | 3 | `SecretWhenAurasRestricted` |
| `auraInstanceID` | AuraData, events | 3 / 7 | Blizzard keys by it only via `secretunwrap` |
| AuraData fields | `GetAuraDataBySlot/ByIndex/ByAuraInstanceID`, `GetUnitAuras` | 3 | `SecretWhenUnitAuraRestricted`; `GetUnitAuras` has `ConditionalSecretContents` |
| AuraData for one spell | `C_UnitAuras.GetUnitAuraBySpellID`, `GetPlayerAuraBySpellID` | 2 | `RequiresNonSecretAura`: full data for never-secret spells, nothing otherwise |
| Aura remaining time | `C_UnitAuras.GetAuraDuration(unit, auraInstanceID)` | 6 | Duration object; rejects a secret `auraInstanceID` (`AllowedWhenUntainted`) |
| Totem start/duration | `GetTotemInfo`, `GetTotemDuration` | 3 → 6 | `SecretWhenTotemSlotSecret` |
| Item cooldowns | `C_Container.GetItemCooldown`, `C_Item.GetItemCooldown` | 1 (unverified) | No secret flag in docs |
| Duration object getters | `GetRemainingDuration`, `HasExpired`, `IsActive`, `Evaluate*` (`LuaDurationObjectAPIDocumentation.lua`) | 5 / 6 | Only `Copy`/`HasSecretValues` are `ReturnsNeverSecret`; others likely secret (unverified). `Evaluate*(curve)` feeds `SetAlpha`/`SetDesaturation`/`SetVertexColor` |
| Cooldown widget readback | `Cooldown:GetCooldownTimes/Duration` | 3 | `SecretReturnsForAspect = Cooldown` |
| Setters accepting secrets from addons | `FontString:SetText/SetFormattedText`, `StatusBar:SetMinMaxValues/SetValue`, `Texture:SetTexture/SetDesaturated/SetVertexColor`, `SetAlpha`, `SetAlphaFromBoolean`, `Cooldown:SetSwipeColor/SetDrawSwipe` | 5 | `AllowedWhenTainted` |
| Setters rejecting secrets from addons | `Cooldown:SetCooldown`, `SetCooldownDuration`, `SetCooldownFromExpirationTime` | 4 | Use `SetCooldownFromDurationObject` |
| Secure filter/sort over secret auras | `CustomAuraContainerTemplate` | 6 | See sections 5 and 9 |
| Pandemic, available/charge alerts, desaturate-on-cooldown branching | `CooldownViewerItemMixin` | 7 | Secret comparisons in Blizzard code |
| Hooks on CDM item frames | `hooksecurefunc(viewer, "OnAcquireItemFrame", ...)` | 2 | Work; item fields read from hooks are secret |

## 5. What addons can actually access

Under restrictions an addon can **display** almost everything, but only **branch on**
never-secret fields, never-secret spells and the static catalog.

| Capability | Display (restricted) | Use in Lua logic (restricted) | How |
|---|---|---|---|
| Spell cooldowns | Yes | On/off and GCD only | `isActive/isOnGCD` + `GetSpellCooldownDuration` → `SetCooldownFromDurationObject` (already in `Filger.lua:636-647`) |
| Charges | Yes | `maxCharges`, `isActive` | `currentCharges` → `SetText` |
| Listed never-secret auras | Yes | Yes | `GetUnitAuraBySpellID` (Filger `ScanSpellAuras`) |
| Any aura | Yes, via `CustomAuraContainerTemplate` | No | Frames get `DenyTaintedAccessWhenAurasAreSecret` (`Blizzard_AuraContainer/Blizzard_AuraContainerShared.lua:108`) |
| Remaining duration | Yes | No | Duration objects; `C_DurationUtil.CreateDurationTextBinding`, `StatusBar:SetTimerDuration` |
| Expiration comparisons (red < 5 s, fade) | Yes, via curves | No | `EvaluateRemainingDuration(curve)`; binding `SetTextColorCurve` |
| Sort by remaining time | Only inside the container (`AuraContainerSortMethod.Expiration/ExpirationOnly`) | No | No sorted equivalent for cooldowns |
| Custom priority sort | Approximate: one aura group per tier, ordered by `layout.layoutIndex` | No | Untested |
| Filter by spell ID | Yes, with limits (section 6) | Only never-secret spells | `candidateFilters.includeSpellIDs/excludeSpellIDs` |
| Aura applied/removed | Yes | Only never-secret spells | `UNIT_AURA` payload is secret; re-query listed spells |
| Tooltips | Yes | No | `CustomAuraButton` provides its own |
| Custom cooldown display | Yes | Show/hide only | Addon `Cooldown` + duration object |
| Read CDM live state | No | No | Item fields are secret |

Only Blizzard can: key tables by secret `auraInstanceID`; compare times in Lua (pandemic,
alerts, desaturation, totem precedence); call `Cooldown:SetCooldown` with secret inputs; match
an aura's `spellId` against a list without the container.

## 6. Filtering by spell ID in combat

Filger can't loop over auras and compare `spellId` (it is secret). Two ways still work:

1. **Query each listed spell** with `C_UnitAuras.GetUnitAuraBySpellID(unit, spellID)` (current
   `ScanSpellAuras`). Works only for spells Blizzard flags never-secret (`RequiresNonSecretAura`);
   returns nothing otherwise. When it works, data is fully readable: priority, sort, timer all
   keep working.
2. **Give the list to `CustomAuraContainerTemplate`** via
   `candidateFilters.includeSpellIDs = { [id] = true, ... }`. Blizzard's secure code compares the
   secret `spellId`, so it works on secret auras, but only where
   `AuraContainerUtil.CanApplyIdentityCandidateFilters` allows it
   (`Blizzard_AuraContainer/Blizzard_AuraContainerUtil.lua:11`):

| Filger frame | Filter by spell ID in combat? |
|---|---|
| Player buffs (class list) | Yes |
| Debuffs on a hostile target or focus (your DoTs) | Yes |
| Buffs on a friendly target | Yes |
| Debuffs on the player (Stagger frame) | Only if the spell is never secret |
| Buffs on a hostile target | No |
| Debuffs on a friendly target | No |

Where it isn't allowed, the ID filter is **skipped and every aura passes**. Blizzard blocks this
on purpose (source comment: addons shouldn't single out encounter debuffs on players). There,
only the filter string (`HARMFUL|PLAYER`, `RAID`) and boolean candidate filters (`isBossAura`,
`isFromPlayerOrPlayerPet`, `isStealable`, `isRoleAura`, `maxDuration`, ...) apply; no blacklist.

Cooldowns are unaffected: the spell IDs are Filger's own list and each is queried directly. Only
sorting by remaining time is lost.

Untested in-game.

## 7. How ElvUI interacts with the Blizzard system

**CDM skin only** (`../refs/ElvUI/ElvUI/Game/Shared/Skins/CooldownManager.lua`). No move,
reparent, hide or replace.

| Technique | Code | Effect |
|---|---|---|
| Load hook | `S:AddCallbackForAddon('Blizzard_CooldownViewer', ..., 'cooldownManager')` | Runs when Blizzard's addon loads |
| Item post-hook | `hooksecurefunc(element, 'OnAcquireItemFrame', data.AcquireItemFrame)` + `itemFramePool:EnumerateActive()` | Skins every pooled item |
| Restyle | `data:SkinIcon`, `data:SkinBar` | Icon crop, atlas/texture swaps guarded by `E:NotSecretValue` |
| Fonts | `data:CountText`, `data:UpdateTextBar` | `Applications`, `ChargeCount.Current`, `Bar.Name`, `Bar.Duration` |
| Cooldown text | `E:RegisterCooldown(frame.Cooldown, 'cdmanager')` | ElvUI cooldown-text module |
| Settings panel | `S:CooldownManager_HandleSettings` | Skins `CooldownViewerSettings` and dialogs |
| Options | `ElvUI_Options/Game/Shared/General.lua:346` | Fonts/positions; only when `E.Modern` |

**Own auras on Blizzard containers** (`ElvUI/Game/Shared/Modules/Auras/Containers.lua`, "Patch
12.1 introduces Aura Containers"):

- `CreateFrame('AuraContainer', name, parent, 'CustomAuraContainerTemplate, DisableUntrustedLayoutScriptsTemplate')` (`E:Auras_Create`, line 1180).
- `SetUnit`, `AddAuraGroup(key, filterString, { candidateFilters, sortMethod, sortDirection, maxFrameCount, layout, initializeFrame })`, `SetAuraGroupSortMethod`, `SetAuraGroupMaxFrameCount`, `SetFlowLayout*`.
- Buttons: `SetIcon`, `SetDurationCooldown`, `SetDurationBar`, `SetApplicationCount`, `AddDispelTypeTexture`.
- Single-spell slots: `includeSpellIDs = { [id] = true }` (`E:Auras_FilterSlot`, line 608).

**Duration/curve techniques**: `Auras.lua:388-397` (`GetAuraDuration` →
`SetCooldownFromDurationObject`, bar visibility via `EvaluateRemainingDuration(curve)`);
`ActionBars.lua:1762-1786` (secret desaturation via
`GetActionCooldownDuration(action):EvaluateRemainingDuration(curve)` → `SetDesaturation`);
`TotemTracker.lua:28`; curves from `C_CurveUtil.CreateCurve` (`General/API.lua:589`).

## 8. Positioning/configuring the viewers from addon code

Viewers are unprotected named frames (no `protected="true"`). Edit Mode owns position and
settings: every layout apply calls `EditModeSystemMixin:UpdateSystem` → `ApplySystemAnchor`
(`Blizzard_EditMode/Shared/EditModeSystemTemplates.lua:350, 385`). No public API changes a single
Edit Mode setting.

| Action | Mechanism | From an addon? | Caveat |
|---|---|---|---|
| Move | `ClearAllPoints` / `SetPoint` | Until Edit Mode reapplies | Bottom managed frames in default position are laid out by `UIParentBottomManagedFrameContainer`; durable moves need `hooksecurefunc(viewer, "ApplySystemAnchor", ...)` |
| Reparent | `SetParent` | Technically | `BreakFromFrameManager` calls `SetParent(UIParent)`; combat unverified |
| Resize | Edit Mode `IconSize`, `IconPadding`, `IconLimit`, `BarWidthScale` | Edit Mode UI only | Direct `SetScale` is overwritten |
| Hide | CVar `cooldownViewerEnabled`; Edit Mode `VisibleSetting`; `Hide`/`SetAlpha(0)` | CVar likely (unverified); `Hide` undone by `UpdateShownState`; alpha until `UpdateSystemSettingOpacity` | `IsCooldownViewerAvailable()` also gates |
| Contents (spells, order, alerts) | `/cdm`, `C_CooldownViewer.SetLayoutData` | Settings UI only | Internal format; don't write it |
| Display options | `Enum.EditModeCooldownViewerSetting.*` | Edit Mode UI only | `C_EditModeManager.SaveLayouts` from addons risks taint (unverified) |
| Read layout | `CooldownViewerSettings:GetDataProvider():GetOrderedCooldownIDsForCategory(cat)` | Yes | Plain numbers |
| Hook creation | `hooksecurefunc(viewer, "OnAcquireItemFrame"/"RefreshLayout", fn)` | Yes | Restyle only |
| Replace methods | `viewer.Method = fn` | Don't | Taints the viewer; its secret math starts erroring |
| Events | `CooldownViewerSettings.OnDataChanged/.OnShow/.OnHide`, `COOLDOWN_VIEWER_DATA_LOADED`, `COOLDOWN_VIEWER_SPELL_OVERRIDE_UPDATED`, `EDIT_MODE_LAYOUTS_UPDATED` | Yes | Resync anchors |

Safe direction: anchor Filger frames **to** the viewers; never move the viewers.

## 9. Comparison with Filger

Filger is list-driven and sorted (scan, filter by spell-ID tables in Lua, sort by priority and
expiration). The CDM is slot-driven and unsorted (fixed order, slots show/hide, comparisons in
secure code).

**Incompatible with secrets (in combat):**

1. Enumerate then filter in Lua: `self.spells[data.spellId]`, `blacklist[...]`,
   `self.all[data.auraInstanceID]` (`Filger.lua:349-362`).
2. "Show everything except" frames (`spells = all` + `FilterAura` on `isBossAura`,
   `sourceUnit`, `isPlayerAura`): only never-secret listed spells can show.
3. Sorting by remaining time (`Filger.lua:280`, `619`); secret cooldowns all tie (start/duration
   default to 0, lines 664-676).
4. `OnUpdate` red text and hide-on-expire (lines 74-87).
5. Incremental `UNIT_AURA` bookkeeping (lines 421-457); already falls back to full rescan
   (lines 395-397).
6. `Cooldown:SetCooldown` with secret inputs; avoided for spells (line 564), not for auras
   (line 244).

**Keeps working:** never-secret spells via `ScanSpellAuras`; cooldown show/hide + duration
objects; `casted` gating via `UNIT_SPELLCAST_SUCCEEDED` for player spells (guarded at line 749);
item/slot cooldowns (unverified); everything out of combat; frames, layout, backdrop, LibDispel
for non-secret auras; all Classic clients except Forever.

**Smaller findings:**

- `Filger.lua:647` reads `cdInfo.enabled`, but `Filger.GetSpellCooldown` (`core/utils.lua:61`)
  returns `isEnabled` on every client, so `enabled ~= 0` is always true.
- `GetUnitAuraBySpellID` returns only the first instance; copies from different casters collapse.
- `UpdateCooldowns` rebuilds every cooldown on each `SPELL_UPDATE_COOLDOWN`, although the event
  carries `spellID`.

## 10. Potential Retail architecture

Recommendation: don't use the CDM viewers as backend; build on the addon-facing primitives.

| Option | For | Against |
|---|---|---|
| A. CDM as backend (skin/anchor/hide) | No tracking code | Tracking set lives in `/cdm`, not `data/`; player/target only, player-cast only, no focus; no readable state; fights Edit Mode |
| B. Reproduce CDM logic | Full control | Impossible in combat |
| **C. Addon-facing primitives** | Keeps data model, look, units; secure filter/sort | Loses priority sort, blacklist on two-sided frames, own timer logic, sorted cooldowns in combat |

Shape of option C (not a plan):

- **Auras**: one `AuraContainer` (`CustomAuraContainerTemplate`) per Filger frame; `SetUnit`;
  flow layout from `size`/`spacing`/growth. Listed frames use `includeSpellIDs` and
  `AuraContainerSortMethod.Expiration`; priority tiers as groups with `layout.layoutIndex`
  (untested). Frames without ID filtering use filter strings and boolean candidate filters.
  Buttons styled in `initializeFrame`; `SetIcon`, `SetDurationCooldown`,
  `SetApplicationCount`, `SetDurationText` (colour curve), `AddDispelTypeTexture`.
- **Cooldowns**: fixed slots in list order; refresh only the `spellID` from
  `SPELL_UPDATE_COOLDOWN`; visibility from `isActive and not isOnGCD`; duration objects;
  sort only when no shown spell is secret.
- **Never-secret fast path**: keep `ScanSpellAuras` for flagged spells and out of combat.
- **Client gate**: `C_Secrets.HasSecretRestrictions()` (exists on every client) plus template
  presence; applies to `standard` and `camelot`.
- **Placement**: optional anchors next to `EssentialCooldownViewer` / `BuffIconCooldownViewer`.

## 11. Potential Classic architecture

Keep the current model on Classic. Tracking layers differ; look, layout, `data/` and `config.lua`
can be shared.

| Client | Secret flags | `Blizzard_CooldownViewer` | `Blizzard_AuraContainer` | Filger path |
|---|---|---|---|---|
| Retail 12.1 (`standard`) | yes | yes | yes | Secret-aware |
| Classic Forever 1.60.1 (`camelot`) | yes | yes | yes | Secret-aware |
| MoP Classic 5.5.4 | none | no | no | Current model |
| Titan WotLK 3.80.2 | none | no | no | Current model |
| TBC Anniversary 2.5.6 | none | no | no | Current model |
| Classic Era 1.15.9 | none | no | no | Current model |
| Cata 4.4.2 | unverified | unverified | unverified | Assume current model |

A TOC split would use `[AllowLoadGameType standard, camelot]` with the `camelot` exclusion rule
from [compatibility.md](compatibility.md).

## 12. Open questions / in-game verification

- [ ] In combat, are duration object getters (`GetRemainingDuration`, `HasExpired`, `IsActive`) secret?
- [ ] Is `auraInstanceID` from `GetUnitAuraBySpellID` (never-secret spell) or `UNIT_AURA.addedAuras` secret in combat?
- [ ] Can Filger create `CustomAuraContainerTemplate` without taint errors? Does `SetUnit("focus")` work? Can it be anchored to Filger frames (`Blizzard_CustomAuraContainer.lua:316`)?
- [ ] On a player-HARMFUL container, is the ID filter skipped (all debuffs shown)? Is Stagger (124273-124275) never-secret?
- [ ] Do multiple aura groups with `layout.layoutIndex` give stable priority tiers? Does an aura in two groups show twice?
- [ ] How many spells in `data/Standard/spells.lua` return `ShouldSpellAuraBeSecret == false` in combat?
- [ ] Are `GetInventoryItemCooldown` / `C_Container.GetItemCooldown` secret in combat?
- [ ] Which player spells arrive with secret `spellID` in `UNIT_SPELLCAST_SUCCEEDED`?
- [ ] Do moved viewers snap back on Edit Mode exit, spec change, `/reload`? Can addons set `cooldownViewerEnabled`, in combat?
- [ ] Does Forever match Retail for `ShouldAurasBeSecret`, `GetSpellCooldownDuration`, `CustomAuraContainerTemplate`?
- [ ] Cata 4.4.2: confirm no secret flags.
- [ ] Should `Filger.lua:647` read `cdInfo.isEnabled`?

```lua
-- replace 12345 with a spell currently on cooldown (the API returns nothing otherwise)
/run local d = C_Spell.GetSpellCooldownDuration(12345); if d then print(issecretvalue(d:GetRemainingDuration()), d:HasSecretValues()) end
/run print(C_Secrets.HasSecretRestrictions(), C_Secrets.ShouldAurasBeSecret(), C_Secrets.ShouldCooldownsBeSecret())
/run print(C_Secrets.ShouldSpellAuraBeSecret(124275), pcall(CreateFrame, "AuraContainer", nil, UIParent, "CustomAuraContainerTemplate"))
```
