---
to: @majkee (home machine, evening)
from: Atlas.temple (2026-06-27 session)
topic: HANDOFF — Gemini 2.5 lock · agent files fixed · gemini-agents.zsh · invocation confirmed
date: 2026-06-27
host: office
---

# Gemini agent session — what landed, what to test

## Root cause fixed (most important)

The `model:` field in the agent files was hardcoded to 3.x — that is what sent Vega into
20-minute thinking spirals. Changed in-place on office machine:

| File | Was | Now |
|---|---|---|
| `~/.gemini/agents/vega.md` | `gemini-3.1-pro` | `gemini-2.5-pro` |
| `~/.gemini/agents/orby.md` | `gemini-3.1-pro` | `gemini-2.5-flash` |
| `~/.gemini/agents/astrobley.md` | `gemini-3.5-flash` | `gemini-2.5-pro` |
| `~/.gemini/agents/epoch.md` | (didn't exist) | `gemini-2.5-flash` ← created |

These files are NOT in git — sync via your machine-sync mechanism.

## Invocation map (confirmed this session)

| Pattern | Status |
|---|---|
| `gemini -a <name>` | Dead |
| `GEMINI_AGENT=<name> gemini` | Tested by you — no effect |
| `gemini "@<name> <task>"` | **Working** — headless agent selector |
| bare `gemini` → `/agents` TUI | **Working** — interactive seat switch |

`@name` in prompt = claude's `--agent` flag equivalent.

## New: `~/.config/zsh/ai/gemini-agents.zsh`

Dual-mode seat functions, model double-locked (agent file + `GEMINI_MODEL` env var):

```zsh
# Interactive (model pre-locked, switch seat via /agents):
vega
orby
astro
epoch

# Headless (@name auto-prepended):
vega "check this plan for drift"
orby "find current gemini-cli changelog"
astro "fix the bug in main.go"
epoch "verify gemini 2.5 model strings"

# Yolo only for implementer:
astro-yolo "run the migration"

# agy wrappers (model reminder only — no pre-lock available in agy):
agy-vega
agy-orby
agy-astro
agy-astro-yolo
```

Run `gemini-agents-help` for the full matrix.

## Changes to existing machine-layer files

| File | Change |
|---|---|
| `~/.config/zsh/ai/gemini-agents.zsh` | Created — the above functions |
| `~/.config/zsh/ai/base.zsh` | Added PARTITION 4 — sources gemini-agents.zsh |
| `~/.config/zsh/ai/gemini-base.zsh` | Partitions 3 & 4 — broken `-a` aliases replaced with shims to new functions |

To load immediately without restart:
```zsh
source ~/.config/zsh/ai/base.zsh
```

## Changes to raw.settings (in git, already on office)

| File | Change |
|---|---|
| `raw.settings/raw.card.gemini-models.md` | NEW — model matrix, GEMINI_MODEL env var, settings.json tuning path. half_life_days: 45 |
| `raw.settings/raw.card.gemini-cli.md` | verified bumped to 2026-06-27 · -a → @name invocation updated · `--allowed-tools` deprecation added · Antigravity LOW-confidence note |

These are uncommitted on office. Sync will carry them. Or commit before leaving.

## agy note

agy defaults to "Gemini 3.5 Flash (Medium)" — hardcoded nowhere, just persisted from last
`/model` selection. No pre-lock mechanism confirmed for agy. For agy sessions: set model
in-session with `/model` → select 2.5 Pro or Flash.

## Sync checklist (office → home)

Machine-layer (not in git — sync manually or via your mechanism):
- `~/.gemini/agents/vega.md`
- `~/.gemini/agents/orby.md`
- `~/.gemini/agents/astrobley.md`
- `~/.gemini/agents/epoch.md`
- `~/.config/zsh/ai/gemini-agents.zsh`
- `~/.config/zsh/ai/base.zsh`
- `~/.config/zsh/ai/gemini-base.zsh`

Git (pull on home after committing/pushing on office):
- `raw.settings/raw.card.gemini-models.md`
- `raw.settings/raw.card.gemini-cli.md`

## Test sequence (home machine)

1. `source ~/.config/zsh/ai/base.zsh`
2. `gemini-agents-help` — verify the matrix loads
3. `vega "what is the current locked decision count in temple/decisions/index.md"` — headless, should use 2.5-pro, no thinking spirals
4. `orby "find the current gemini-cli version"` — headless, 2.5-flash, web research
5. `astro` (bare) — interactive, 2.5-pro, check `/agents` shows astrobley

— Atlas.temple, 2026-06-27
