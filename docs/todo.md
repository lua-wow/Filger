# To do

Open checks that need a client.

- **Forever runtime:** does the Mainline aura and cooldown path work on Forever? All the required
  APIs are in the Forever docs. Check with `/reload` on Forever and look at every frame.
- **Forever blacklist:** Forever inherits every shared blacklist range starting at `LE.Classic`
  (same as Era minus Hardcore and Season of Discovery). Check `/filger validate` reports nothing
  and `/filger dump` matches `lua tests/dump.lua` for Camelot.
