# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [5.2.0] - 2024-10-29

### Added

-   Update shaman enhancement spells and cooldowns
-   Added items spells priority

### Changed

-   Update spell priority
-   Update processing and filtering spells

## [5.1.1] - 2024-10-07

### Changed

-  replace `_G.IsAddOnLoaded` with `C_AddOns.IsAddOnLoaded` (patch 11.0.2)

## [5.1.0] - 2024-08-04

### Changed

-   Update spells for patch 11.0.0
-   Added cataclysm spells
-   Fix cataclysm cooldowns
-   Fix dispelable aura highlight

## [5.0.0] - 2024-07-27

### Changed

-   Complete rework
-   Update `UNIT_AURA` event to use `UnitAuraInfo`
-   Update API to use `C_Spell` namespace.
-   Added new lib `LibDispel`.
-   Fixed aura colors and dispelable/stealable animation.

## [4.3.2] - 2024-07-26

### Changed

-   Update .toc files
-   Update submodules

## [4.3.1] - 2024-01-13

### Changed

-   Adding `LibStub` as git submodule
-   Adding `CallbackHandler-1.0` as git submodule
-   Adding `LibClassicDurations` as git submodule

## [4.3.0] - 2024-01-13

### Changed

-   Changed Tukui dependency from `required` to `optional`
-   Fixed `CreateBackdrop` error, caused by required depencies

## [4.2] - 2024-01-02

### Added

-   `CHANGELOG.mf' initialized.

## [2.5] - 24/10/2019

### Changed

-   Patch 8.2.5

## [2.4] - 06/03/2019

### Added

-   WoLK dungeons and raid tables.
-   Update BoA dungeon and raid tables.
-   Tracer plugins (help to build spell tables by saving buffs/debuffs that affect player)

### Changed

-   Tracer plugin enhanced (added automatic option).

## [2.3] - 04/02/2019

### Changed

-   Fixed icon cooldown countdown double text.
-   Fixed timer text for auras with no expiration time.

## [2.2] - 17/02/2019

### Added

-   command `/filger help`.

### Changed

-   api.lua removed. (useless)

## [2.1] - 10/02/2019

### Added

-   Druid (all specs) spell list.
-   Warrior (Protection) spell list.
-   Shaman (Elemental and Restoration) spell list.
-   Paladin (all specs) spell list.

### Changed

-   Update MONK spell list.
-   Test command duration error (*division by zero*).
-   StatusBar was hiding timer text.
-   Invalid spellID warnning receiving nil variable.

## [2.0] - 09/02/2019

### Added

-   PRIEST spell table for Discipline, Holy and Shadow.
-   MONK spell table for Brewmaster and Mistweaver.
-   Instance/Zone Tables.
-   import only current instance/zone bosses spell list.
-   Cataclysm Raid spell list..
-   Mists of Pandaria Raids and Dungeon spell list.
-   Commands /filger [show][hide][test].

### Changed

-   New implementation
-   Update to support `patch 8.1` - **World of Warcraft - Battle for Azeroth**.

## [1.5] - 04/07/2018

### Changed

-   Fixed some miss spelling.
-   Update `README.md`

### Added

-   Inserted racial skills (Troll and Orc)

## [1.4] - 01/03/2018

### Changed

-   Update SHAMAN spells (Resurgence and Ancestral Vigor)

## [1.3] - 27/02/2018

### Changed

-   Fixed `element.count` error when `data.count` got `nil` as value.
-   Reviewd spell list.

### Added

-   Insert PALADIN spells

## [1.2] - 19/02/2018

### Changed

-   Update spell list.

## [1.1] - 12/02/2018

### Added

-   Sorting active spell by expiration time else spellID.
-   Command `/filger`
-   Feature to record buffs/debuffs on player and target units.
-   Saved variables for recorded buffs/debuffs.

## [1.0] - 11/02/2018

### Added

-   Release.
-   Spell list for PRIEST, MONK, DRUID and Shaman
-   Icons border are colored by spell type.
