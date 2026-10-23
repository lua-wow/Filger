# Future plan

## Potion cooldown

Show one icon for the shared potion cooldown, without listing potion item IDs.

### Why not item IDs

- Every potion in the bags goes on cooldown when one is used, so one icon per potion would duplicate
  the same timer.
- Potion IDs change every patch and expansion, so a list in `data/` would need constant upkeep.

### Today

- `ProcessCooldownData` already has a `data.itemId` branch (`GetItemInfo`, `C_Container.GetItemCooldown`),
  and tooltips handle `itemId` (`Filger.lua`, `button_proto` `OnEnter`).
- The branch is unreachable: `core/data.lua` has no item constructor, and `buildCooldowns` drops any
  row that has no `slotId` or known `spellId`.
- Events are enough. On Retail and MoP, `SPELL_UPDATE_COOLDOWN` reported every item cooldown change
  (Experiment 10, [secret-values-options.md](secret-values-options.md)). Item rows are always re-checked
  because they have no `spellId`.

### Idea

One "potion" row, with no ID. The row resolves to whichever potion is in the bags:

- Find it by item class, not by ID: `C_Item.GetItemInfoInstant(itemID)` returns `classID, subClassID`.
  A potion is `Enum.ItemClass.Consumable` (0) with `Enum.ItemConsumableSubclass.Potion` (1).
  `ItemConsumableSubclass` and `GetItemInfoInstant` exist in the generated docs of every worktree
  (live, forever, classic, classic_titan, classic_anniversary, classic_era).
- Scan the bags (`C_Container.GetContainerNumSlots`, `C_Container.GetContainerItemID`) only when they
  change (`BAG_UPDATE_DELAYED`), never on cooldown events. Cache the item ID found.
- Keep the last ID found after the last potion is drunk, so the running cooldown still shows.
- Read the cooldown with the existing `itemId` branch, which works the same for any potion that shares it.

### Phases

1. **Experiments** (in game, `/filger exp10 <potionID>`, which now prints `enabled`):
   - MoP: drink in combat, then leave combat. Does `enabled` read 0 in combat while `start` follows
     `GetTime()`, and does the cooldown start when combat ends?
   - Era and TBC: the same.
   - Retail: does a healing potion share its cooldown with a combat potion? Healthstones? (**UNVERIFIED**)
   - Era: are potions classID 0 / subClassID 1, or Generic (0)? (**UNVERIFIED**, check with
     `/run print(C_Item.GetItemInfoInstant(<id>))`)
2. **Data:** `data.CreatePotionCooldown(enabled)` in `core/data.lua`, one row in
   `data/shared/cooldowns.lua` `gear`, and accept it in `buildCooldowns`.
3. **Resolve:** a bag scan that sets the row's `itemId`, run at login and on `BAG_UPDATE_DELAYED`,
   registered only by the cooldown element.
4. **Classic in combat:** if phase 1 confirms the pending cooldown, keep the icon hidden while
   `enabled` is 0 (`FilterCooldown` already requires `data.enabled`).

### Open questions

- If the bags hold potions from different cooldown groups, which one wins? Unknown until phase 1.
