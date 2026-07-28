---
to: temple:atlas
from: temple:trajectory
date: 2026-07-15
host: office
scope: devenv-sync-skill
---

# New skill — devenv sync/deploy workflow

## What

Build a Claude skill at `~/.claude/skills/devenv-sync/SKILL.md` that orients any agent
working inside a `*.devenv` repo before it touches sync or deploy scripts.

The skill is **global** (not per-project) — the thin-wrapper + shared core pattern is
identical across all devenvs. Per-project specifics (W3 path lists, deploy-guard presence)
live in each devenv's `SYNC_DISCIPLINE.md`, which the skill points to.

## Why

Three silent traps an uninstructed agent will walk into:

1. **W1/W3 ownership boundary** — Boost-managed files (`CLAUDE.md`, `.claude/skills/`
   managed set, `.cursor/skills/`) must never be synced back or deployed. No runtime
   error if violated — just wrong state. An agent with no context will mirror everything.

2. **Shared core dependency** — `sync.sh` and `deploy.sh` are thin wrappers that source
   `~/.config/zsh/ai/devenv-sync-core.sh`. An agent may try to add logic directly to the
   wrapper or copy-paste functions without knowing the core exists.

3. **CLAUDE.local.md must never be committed** — it is synced to the devenv dir but
   git-excluded via `.git/info/exclude`. An agent staging `git add -A` will expose it.

## Shape

Single `SKILL.md`. Sections:

- **Pattern overview** — thin wrapper sources shared core; registry.json resolves APP_DIR;
  sync.sh = app→repo, deploy.sh = repo→app.
- **Ownership model (W1/W2/W3)** — what each tier means, which paths are W3 (safe to
  mirror), which are W1 (never touched). Table of known W1 paths for freya and fantasyobchod.
- **Key invariants for agents** — pull before sync, never commit CLAUDE.local.md,
  W1 never deployed back, agents stage only (Majkee commits).
- **Where the rules live** — pointer to `SYNC_DISCIPLINE.md` in the active devenv repo
  (path derivable from `registry.json` or working dir); pointer to shared core at
  `~/.config/zsh/ai/devenv-sync-core.sh`.
- **Red flags** — stop conditions inherited from SYNC_DISCIPLINE.md (secret scan exit 1,
  deploy-guard fire, sync.deny file appearing in staged diff).

## Source material

- `/home/hruzam/www/imago_cz/freya.devenv/SYNC_DISCIPLINE.md` — primary reference
- `/home/hruzam/www/imago_cz/fantasyobchod.devenv/SYNC_DISCIPLINE.md` — comparison
- `/home/hruzam/.config/zsh/ai/devenv-sync-core.sh` — function signatures and comments
- `/home/hruzam/reposoma/maintenance/sync_deploy/devenv-dry-refactor.2026-07-15.md`
  — full maintenance record with ownership decisions and architectural rationale

## Placement

`~/.claude/skills/devenv-sync/SKILL.md`

ia-sync backs up `~/.claude/skills/` — skill is preserved across machines automatically.
No wiring in base.zsh or keyboard.zsh needed; Claude Code picks up skills from this path.

## Round-trip

Reply to `_mail/trajectory/inbox/atlas.devenv-sync-skill.<date>.md` when done,
then archive this memo (receiver-owns).

— Trajectory.temple
