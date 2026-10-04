# CLAUDE.md

`Filger` is a World of Warcraft addon: a minimal buff/debuff tracker.
It is minimal both in-game and in source. The same addon directory is copied unchanged into
every client's `Interface` folder and must look and behave the same everywhere.

**Status:** being revived after a long break. Expect code broken by changed/removed Blizzard
APIs and by secret values. Don't assume existing code is correct.

## Philosophy

**No configuration.** No options UI, slash-command configuration (`/filger` is help/dev only),
profiles, per-character or per-client settings, and no SavedVariables added just to make
something configurable. Decisions are made in code and constants (`config.lua`, `data/`).
The declared SavedVariable (`FilgerData`) is currently unused. If a feature genuinely needs new persistent state, explain
why before adding it.

**Minimalism.** No frameworks, abstractions, compatibility layers, helper systems or
dependencies unless they solve a real problem. 30 understandable lines beat a 300-line
generic system.

**Efficiency.** Prefer "detect change → update only what changed" over "event → reapply
everything". Avoid repeated updates, repeated calls to the same API, unnecessary loops,
tables/closures in hot paths, redundant event registrations and reapplying the same style.
Don't micro-optimize ordinary code, but treat repeated work as a design problem.

**Style.** Lua 5.1 / WoW runtime. Small focused functions, locals, minimal shared mutable
state, no new globals, calculation separated from side effects where practical. Use the
prototype style where it is already used. This is a preference: WoW's API and the existing
architecture win when they conflict.

## Changing code

- Preserve existing behavior and visual design unless it is broken or the API makes it impossible.
- Smallest correct change. No unrelated refactors, reformatting or modernization.
- For API compatibility problems: identify the failing API/event/frame behavior → find every
  Filger usage → verify current behavior on each affected client → fix → check other
  usages of the same changed API.

## Compatibility

- One `Filger.toc` serves every client; never add `Filger_*.toc`. Client-specific files are
  tagged per line with `[AllowLoadGameType ...]`.
- Never assume an API exists on every client, or that Retail and Classic behave the same.
- Never guess about secret/restricted values: check the target client's generated Blizzard
  API docs before using a result in logic. If unsure, say so.
- Never invent an API. Mark anything you can't verify as "unverified".
- Supported clients, TOC rules, libraries, runtime client checks, secret values: [docs/compatibility.md](docs/compatibility.md).

## References

- Blizzard `wow-ui-source` (local clone in `../refs`, read-only) is the API authority. Use
  targeted searches, not broad exploration. Map: [docs/reference-repositories.md](docs/reference-repositories.md).

## Git & GitHub

I review and test changes in-game, then group them into commits myself.

- Read freely: git status/diff/log/show/blame, branches, worktrees, submodule status;
  `gh` issues, PRs and repo info.
- Edit files in the working tree and leave changes uncommitted.
- Never mutate the repository or its history unless I explicitly ask: no commit, add, push,
  pull, fetch, merge, rebase, checkout/switch, reset, restore, stash, cherry-pick, tag,
  or submodule pointer changes. A finished task is not permission to commit.
- Don't create, edit or comment on GitHub issues/PRs unless I explicitly ask.
- Issue workflow: read the issue → inspect code → propose a plan → implement → leave uncommitted.

## Verifying

- After Lua changes, run `mise exec -- make check` (luacheck) and report the result.
- Claude can't run the game. Tell me what to verify in-game (`/reload`) and on which clients;
  I'll paste Lua errors back.
