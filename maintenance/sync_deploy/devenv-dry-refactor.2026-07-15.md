---
host: office
date: 2026-Jul-15
reason: malfunction + decision
scope: sync_deploy
files:
  - /home/hruzam/www/imago_cz/freya.devenv/registry.json
  - /home/hruzam/www/imago_cz/freya.devenv/sync.sh
  - /home/hruzam/www/imago_cz/freya.devenv/deploy.sh
  - /home/hruzam/www/imago_cz/freya.devenv/SYNC_DISCIPLINE.md
  - /home/hruzam/www/imago_cz/fantasyobchod.devenv/sync.sh
  - /home/hruzam/www/imago_cz/fantasyobchod.devenv/deploy.sh
  - /home/hruzam/www/imago_cz/fantasyobchod.devenv/SYNC_DISCIPLINE.md
  - /home/hruzam/.config/zsh/ai/devenv-sync-core.sh
  - /home/hruzam/.config/zsh/ai/README.md
journal: /home/hruzam/.config/zsh/journal.maintenance-office.jsonl
---

# devenv sync/deploy — DRY refactor + broken registry fix

## Malfunction

`freya.devenv/sync.sh` exited immediately with Python `JSONDecodeError` — `registry.json`
had a trailing comma after the first host entry and a missing closing `}` on the root object.

```json
// broken
{
  "home": { "app_dir": "..." }
},          ← comma outside root object
  "office": { "app_dir": "..." }
            ← missing closing }
```

## Additional problems found during investigation

- `freya.devenv/sync.sh` had diverged significantly from `fantasyobchod.devenv/sync.sh`:
  CLAUDE.md handled via backup-diff lane (not synced to repo), AGENTS.md skipped,
  `cursor/` not synced, `skills/` only partial (`freya-context/`).
- `cursor/skills/` (14 Boost-managed skills) was being fully mirrored — W1 paths in repo.
- `deploy.sh` pair had no shared logic; APP_DIR resolution and footer copy-pasted verbatim.

## Fixes applied

### 1. registry.json — corrected JSON
Valid `{ "home": {...}, "office": {...} }` structure.

### 2. Shared function library created
`/home/hruzam/.config/zsh/ai/devenv-sync-core.sh` — 8 shared functions:
- `_devenv_resolve_app_dir` — Python JSON registry lookup
- `_devenv_sync_deny_init` — loads sync.deny → EXCLUDE_ARGS array
- `_devenv_sync_deny_cleanup` — defence rm pass
- `_devenv_secret_scan` — grep secret patterns across dirs
- `_devenv_print_footer` — sync next-steps footer
- `_devenv_deploy_guard` — stamp-based branch/HEAD mismatch check
- `_devenv_git_exclude_guard` — ensures entry in .git/info/exclude
- `_devenv_print_deploy_footer` — deploy complete footer

Lives in ia-sync backup scope — available after `bash ~/ia-sync/deploy.sh` on fresh machine.

### 3. Both sync.sh files — thin wrappers
Each sources core with presence guard:
```bash
CORE="${DEVENV_SYNC_CORE:-$HOME/.config/zsh/ai/devenv-sync-core.sh}"
[ -r "$CORE" ] || { echo "FATAL: ...run ia-sync deploy first" >&2; exit 1; }
source "$CORE"
```

**freya** mirrors W3/majkee-owned paths only:
`CLAUDE.local.md` (primary), `CLAUDE.md` (visibility, never deploy back), `AGENTS.md`,
`settings.local.json`, `agents/`, `skills/freya-context/`, `cursor/mcp.json`,
`cursor/rules/`, `gemini/`, `dev/`.

**fantasyobchod** keeps flat allowlist: `AGENTS.md`, `CLAUDE.md`, `settings.local.json`,
`rules/`, `skills/`, `agents/`, `cursor/`, `dev/`.

### 4. Both deploy.sh files — thin wrappers
Same pattern. freya deploy.sh gained `cursor/` W3 paths and `CLAUDE.local.md` deploy
(both were missing from the original). deploy-guard moved into shared core.

### 5. Boost-managed cursor/skills/ removed from freya devenv repo
`git rm -r cursor/skills/` — 45 files staged for removal.

### 6. SYNC_DISCIPLINE.md updated in both devenvs
- Removed backup-diff CLAUDE.md special lane section (retired).
- Added shared core notice + W3 mirror table.
- Added deferred engine decision.

## Architectural decisions locked

**ia-sync stays self-contained.** ia-sync/sync.sh and deploy.sh are not consumers of
devenv-sync-core.sh — ia-sync backs it up. Making ia-sync depend on it would be
chicken-and-egg on a fresh machine.

**Registry-driven sync engine: deferred.** At 2 projects (~1/year growth), a
centralized engine has negative ROI. Revisit when projects ≥ 4–5 and drift causes
a real bug. Decision recorded in both SYNC_DISCIPLINE.md files.
(Verdict: advisor-advanced / Opus, 2026-07-15)
