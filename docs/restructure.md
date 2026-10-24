# Restructure

Analysis of the current file layout and the migration plan toward a clearer one. Constraints: keep
`FilgerData` compatible, keep the single `Filger.toc` load order (no build step), stay lightweight.
Client and TOC rules: [compatibility.md](compatibility.md).

## Current structure

Load order (`Filger.toc`):

| # | File | What it does |
|---|------|--------------|
| 1 | `libs/init.xml` | LibStub, LibDispel (LibDispel only used by Classic auras) |
| 2 | `core/data.lua` | `ns.data`: row constructors (`CreateSpellPriority`, `CreateSpellCooldown`, `CreateSlotCooldown`), source collectors (`AddSpells/AddBlacklist/AddCooldowns`), `Finalize()` that validates and writes `Filger.blacklist/spells/cooldowns/all` |
| 3 | `data/[Game]/*.lua`, `data/shared/*.lua` | Pure data, pushed into `ns.data` |
| 4 | `core/init.xml` → `init.lua` | Global frame `Filger` (= `ns.Filger`), client flags, player class, pixel scale |
| | `colors.lua` | `Filger:CreateColor`, `Filger.colors` (dispel colors, Classic only) |
| | `medias.lua` | Font/texture paths |
| | `utils.lua` | print/warn/error, `FormatTime`, `GetSpellInfo`/`GetSpellCooldown` shims |
| | `api.lua` | Tukui-style `MergeAPI` (patches widget metatables with `SetOutside/SetInside/CreateBackdrop`); skipped if Tukui/Tainted is loaded |
| | `commands.lua` | `/filger` dispatcher, `auras` command |
| | `development.lua` | `exp4..exp10` experiments (ships to users; not in `exclude.lst`) |
| 5 | `config.lua` | Calls `ns.data.Finalize()`, then builds `Filger.config` = `general` + `layout` + the `PLAYER_COOLDOWNS` frame |
| 6 | `core/[Family]/auras.lua` | Mainline: `container_proto` + 7 frame defs. Classic: `aura_proto` + 7 frame defs. Both `Mixin` their frames into `Filger.config.frames` |
| 7 | `Filger.lua` | Button widget (`button_proto`, `StyleButton`, `CreateButton`, Mainline time formatter/curve), cooldown element (`cooldown_proto`), `element_proto:SetPosition`, `Filger:Spawn`, bootstrap (`ADDON_LOADED`, `PLAYER_LOGIN`) |

Mixed responsibilities:
- The `Filger` frame is at once the global, event dispatcher, config holder, data store
  (`blacklist/spells/cooldowns/all`), utility library, cross-file channel (`timeTextOptions`) and the
  list of spawned elements (`table.insert(self, element)`).
- Config lives in three places: `config.lua`, both `core/[Family]/auras.lua`, and `data/`.
- Element implementations live in two places: cooldowns in `Filger.lua`, auras in `core/[Family]/`.

`ns` (`local _, ns = ...`) is a private table WoW passes only to Filger's own files; it is not global.
Everything stored on `Filger` is global (`_G.Filger`), readable by any addon or `/run`.

## Problems, ranked by maintenance cost

1. **`Filger.lua` is a grab bag.** Button widget, a complete feature (cooldowns), generic layout
   (`SetPosition`), type dispatch (`Spawn`) and bootstrap in one file. Cooldowns is a peer of auras but
   lives in the "main" file.
2. **Frame definitions duplicated per family.** `core/Mainline/auras.lua` and `core/Classic/auras.lua`
   define the same 7 frames with identical anchor/limit/size/spacing/growth; only the filter part
   differs. Moving one frame means editing 2 files; the cooldown frame is in a 3rd.
3. **Hidden load-order side effects.** `config.lua` runs data validation (`Finalize`); config must load
   after `core/init.xml` (needs `warn`, `GetSpellInfo`) and before `auras.lua` (mutates
   `config.frames`), which must load before `Filger.lua` (reads `ns.aura_proto`/`ns.container_proto`).
   None of this is visible in the TOC.
4. **Duplicated render pipeline with dead bookkeeping.** `aura_proto:UpdateAuras` (Classic) and
   `cooldown_proto:UpdateCooldowns` share the same sort → update → hide → position block, and both
   `Update` methods share button acquisition and cooldown/icon setup. `visibleChanged` and (in
   cooldowns) `changed` are always `true`, so `createdButtons/anchoredButtons/visibleButtons` do nothing.
5. **Family code in shared files.** `Filger.lua` builds the Mainline formatter/curve on every client and
   publishes `Filger.timeTextOptions` for `core/Mainline/auras.lua`. `Filger.colors`, `Filger.all` and
   LibDispel load everywhere but are Classic only.
6. **Prototype tables shared across instances.** `cooldown_proto.casted`/`.spells` are proto tables;
   `Mixin` copies references, so every cooldown element would share one `casted`. Latent (one frame today).
7. **Magic-string dispatch.** `Spawn` picks the element type by `filter == "COOLDOWN"`, then
   `data.groups`, else aura.
8. **Unused surface.** `SetOutside/SetInside` (never called), `general.well_fed`, `caster`,
   `hidePlayer` (set, never read), the stale field doc in `config.lua`, commented blocks,
   `development.lua` shipped to players.
9. **`core/` is not the core.** It holds bootstrap, assets, utils, dev tools, data plumbing and family
   elements; the actual core (`Filger.lua`) sits outside it.

## Options

All options keep the Tukui/Tainted integration and add ElvUI (see [Skin integration](#skin-integration)).

### A. Reshuffle only
```
Filger/
├── Filger.toc
├── Filger.lua               bootstrap only
├── config.lua               unchanged
├── core/
│   ├── init.xml             + button.lua, element.lua
│   ├── init.lua, colors.lua, medias.lua, utils.lua, api.lua
│   ├── button.lua           NEW  button_proto, StyleButton, CreateButton
│   ├── element.lua          NEW  element_proto:SetPosition, Spawn
│   ├── cooldowns.lua        NEW  cooldown_proto
│   ├── commands.lua, development.lua, data.lua
│   ├── Mainline/auras.lua   unchanged
│   └── Classic/auras.lua    unchanged
├── data/  libs/  medias/
```
- Cost: ~4 cut/paste commits. Fixes #1, part of #9.
- Leaves duplication, config sprawl and hidden ordering.

### B. Split "what to show" from "how to show it"
```
Filger/
├── Filger.toc               # comments state the load order
├── Filger.lua               bootstrap only
├── config.lua               general + anchor/size/limit/growth for all 8 frames
├── config/
│   ├── Mainline/frames.lua  groups per frame
│   └── Classic/frames.lua   filter/spells/FilterAura/SortAuras per frame
├── core/
│   ├── init.lua, colors.lua, medias.lua, utils.lua, api.lua
│   ├── button.lua           NEW  button widget, AcquireButton
│   ├── element.lua          NEW  SetPosition, Render (shared), Spawn on def.type
│   ├── commands.lua, development.lua, data.lua
├── elements/
│   ├── cooldowns.lua        cooldown_proto
│   ├── Mainline/auras.lua   container_proto
│   └── Classic/auras.lua    aura_proto
├── data/  libs/  medias/
```
- Cost: ~8–10 commits, touches every Lua file except data. Fixes #1–#7, #9.
- Risk: Classic aura and cooldown render path (shared `Render`), load order of new files.

### C. Real modules
```
Filger/
├── Filger.lua               bootstrap: Finalize → BuildConfig → spawn from ns.elements
├── config.lua               ns.BuildConfig(), called at PLAYER_LOGIN
├── core/
│   ├── init.lua             global frame (title/version only), ns.client flags
│   ├── util.lua             ns.util: print/warn, FormatTime, spell shims, skin adapter (replaces MergeAPI)
│   ├── media.lua            ns.media: fonts, textures, CreateColor
│   ├── button.lua           ns.button
│   ├── element.lua          ns.element: SetPosition, Render, Spawn via ns.elements[def.type]
│   ├── commands.lua, data.lua
├── elements/
│   ├── cooldowns.lua        ns.elements.cooldowns
│   ├── Mainline/auras.lua   ns.elements.auras = container proto + filter spec
│   └── Classic/auras.lua    ns.elements.auras = aura proto + filter spec + dispel colors
├── dev/development.lua      own TOC line, easy to leave out of releases
├── data/  libs/             LibDispel on its own TOC line, classic only
```
- Cost: rewrite of every core file, ~15 commits. Fixes everything including #8.
- Risk: external code reading `_G.Filger.*`, LibDispel TOC tagging, Filger's own backdrop when no UI is
  loaded (no longer a metatable method).

### Skin integration

When Tukui, Tainted or ElvUI is loaded, Filger buttons use that UI's backdrop.

Today:
- **Tukui/Tainted:** `core/api.lua` returns early, so `button:CreateBackdrop()` resolves to Tukui's
  (`Tukui/Core/Toolkit.lua`, `Toolkit.API.CreateBackdrop`). The field matches (`self.Backdrop`), but Tukui
  draws borders with textures and colors them with `Backdrop:SetBorderColor`. Classic dispel coloring
  calls `SetBackdropBorderColor`, so it most likely has no visible effect under Tukui (**unverified**).
  Tainted is not in `../refs` (**unverified**, assumed Tukui-like).
- **ElvUI (accidental):** ElvUI patches `CreateBackdrop` onto widget metatables at load
  (`ElvUI/Game/Shared/General/Toolkit.lua`). `MergeAPI` only fills missing methods, so if ElvUI loads
  first Filger uses ElvUI's. Load order is not guaranteed (ElvUI is not in `OptionalDeps`), and ElvUI
  stores the backdrop as `frame.backdrop`, so Filger's `button.Backdrop` checks miss it.

Target (~20 lines in `core/api.lua`, or `core/util.lua` in C):
- `## OptionalDeps: Tainted, Tukui, ElvUI` so those UIs load first.
- `api.lua` early return also covers ElvUI.
- `StyleButton` calls `button:CreateBackdrop()`, then `button.Backdrop = button.Backdrop or button.backdrop`.
- Border color helper: `Backdrop.SetBorderColor` when present (Tukui), else `SetBackdropBorderColor`.
- Only the backdrop defers; fonts and timer text stay Filger's.

## Decision: B, trimmed

Context: mostly maintenance (the potion cooldown in [future-plan.md](future-plan.md) is the one planned
feature), Classic fully supported, skin integration kept and extended to ElvUI. C is too much for a
maintenance project; A leaves the duplication that makes Classic expensive. Trimmed B:
- **No `config/[Family]` folder.** Each family's filter spec stays next to the code that reads it
  (`groups` only means something to `container_proto`, `FilterAura` only to `aura_proto`). Only the
  repeated layout moves to `config.lua`.
- **`Finalize()` stays at the top of `config.lua`.** The TOC gets `#` comments stating the order instead.
- `api.lua`/`MergeAPI` stay, plus the skin adapter.

Target tree (sketch, not final):
```
Filger/
├── Filger.toc               one TOC, # comments state the load order
├── Filger.lua               bootstrap: ADDON_LOADED, PLAYER_LOGIN → Spawn each frame
├── config.lua               Finalize(), general style, all 8 frames' anchor/size/limit/growth
├── core/
│   ├── init.xml             loads the files below, in this order
│   ├── init.lua             global frame, client flags, player class
│   ├── colors.lua           CreateColor (+ dispel colors)
│   ├── medias.lua           font/texture paths
│   ├── utils.lua            print/warn, FormatTime, GetSpellInfo/GetSpellCooldown shims
│   ├── api.lua              MergeAPI (skipped under Tukui/Tainted/ElvUI) + skin adapter
│   ├── button.lua           button_proto, StyleButton, CreateButton, time formatter
│   ├── element.lua          element_proto (SetPosition, AcquireButton, Render), Spawn
│   ├── commands.lua         /filger
│   ├── development.lua      exp* experiments
│   └── data.lua             row constructors, source collectors, Finalize
├── elements/
│   ├── cooldowns.lua        cooldown_proto (potion cooldown goes here)
│   ├── Mainline/auras.lua   container_proto + Retail/Forever filter spec per frame
│   └── Classic/auras.lua    aura_proto + Classic filter spec per frame
├── data/                    unchanged
├── libs/                    unchanged
└── medias/                  unchanged
```

TOC load block (sketch):
```
libs\init.xml
# data plumbing, then data files push rows into ns.data
core\data.lua
data\[Game]\blacklist.lua
data\[Game]\cooldowns.lua
data\[Game]\spells.lua
data\shared\blacklist.lua
data\shared\cooldowns.lua
# Filger frame, utils, button/element prototypes
core\init.xml
# validates data, defines frame layout (needs core + data)
config.lua
# element types; aura files add their filter spec to config.frames
elements\cooldowns.lua
elements\[Family]\auras.lua
# spawns frames at PLAYER_LOGIN
Filger.lua
```

Where to look:

| I want to… | File |
|---|---|
| move/resize a frame | `config.lua` |
| change what a frame shows on Retail / Classic | `elements/Mainline/auras.lua` / `elements/Classic/auras.lua` |
| change cooldown behavior | `elements/cooldowns.lua` |
| change button look, timer text, tooltip | `core/button.lua` |
| change icon placement/growth | `core/element.lua` (`SetPosition`) |
| add a spell | `data/<Game>/` |

## Migration

Each step is one commit that leaves the addon working.

Progress:
- [x] 0. Drop `LibClassicDurations`
- [x] 1. Skin integration
- [x] 2. Document load order
- [x] 3. Extract `core/button.lua`
- [x] 4. Extract `core/element.lua`
- [x] 5. Extract `elements/cooldowns.lua`
- [x] 6. Move the family auras
- [x] 7. Per-instance state
- [x] 8. Explicit element type
- [x] 9. Share the render path
- [x] 10. Layout once
- [ ] 11. Remove unused code

0. **Done: removed `LibClassicDurations` and `CallbackHandler-1.0`.** The library was added because Era
   reported `duration = 0` for auras from other casters. Era now reports real durations (another
   player's Arcane Intellect on a target: `duration = 1800`). Neither library was loaded, so no behavior change.
1. **Done: skin integration** ([above](#skin-integration)). ElvUI added to `OptionalDeps` and the
   `api.lua` early return; `StyleButton` maps `button.backdrop` to `button.Backdrop`; Classic dispel
   borders go through `Filger:SetBorderColor` (Tukui `SetBorderColor`, else `SetBackdropBorderColor`).
2. **Document load order** with `#` comments in `Filger.toc`.
3. **Done: extracted `core/button.lua`**: `button_proto`, formatter/curve, `timeTextOptions`, `StyleButton`,
   `CreateButton`, unchanged. Add to `core/init.xml` after `api.lua`.
4. **Done: extracted `core/element.lua`**: `element_proto:SetPosition` and `Filger:Spawn`, unchanged.
   `Filger.lua` exposes `cooldown_proto` as `ns.cooldown_proto` like the aura protos, so `Spawn` can reach it.
5. **Done: extracted `elements/cooldowns.lua`**: moved `cooldown_proto` and its `ns.cooldown_proto` export.
   `Filger.lua` is now bootstrap only.
6. **Done: moved the family auras** to `elements/[Family]/auras.lua` and updated the TOC line.
7. **Done: per-instance state**: Spawn creates `casted`/`spells`/`active` per element instead of on the proto.
8. **Done: explicit element type**: frame defs get `type = "cooldowns" | "container" | "auras"`; `Spawn`
   dispatches on it.
9. **Done: shared the render path**: `element_proto:AcquireButton(index)` and `element_proto:Render(unit, sorted, compare)`
   (sort, update 1..n, hide the rest, `SetPosition(1, n)`), used by `aura_proto` and `cooldown_proto`.
   Dropped the dead bookkeeping. Same behavior: `SetPosition(1, n)` already ran on every update.
10. **Done: layout once**: `config.lua` defines all 8 frames' anchor/limit/size/spacing/growth with small
    `left`/`right` default tables; family files add `type`, `groups` or `filter/spells/FilterAura/SortAuras`,
    and per-family overrides (`BOSS_DEBUFFS.enabled = false` on Classic, `desaturated`).
11. **Remove unused code**: `SetOutside`/`SetInside`, `caster`, `hidePlayer`, `well_fed`, the stale field
    doc in `config.lua`, commented blocks in `Spawn`.

Later, optional:
- Stop shipping `development.lua`. Excluding a file `init.xml` still references may log a missing-file
  error (**unverified**), so it needs its own TOC line.
- Move the Classic-only `Filger.colors` into `elements/Classic/auras.lua`.

## Verification

Every step:
- `mise exec -- make check`.
- `/reload` on Retail, Forever, Era and MoP (TBC/WotLK at least after steps 6, 9 and 10): frames in the
  same positions, player/target/focus auras shown, cooldowns after a cast, trinket slot cooldowns,
  tooltips, no Lua errors.

After steps 1 and 3, once each with no UI addon, Tukui (or Tainted) and ElvUI: buttons use that UI's
backdrop, Classic debuff borders take the dispel color, no Lua errors.

Steps 9–10 are the risky ones (Classic aura and cooldown paths); compare against a screenshot taken before.
