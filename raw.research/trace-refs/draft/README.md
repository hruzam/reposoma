---
skill: ~/.claude/skills/trace-refs/SKILL.md
default_scope: temple
purpose: >
  Scope configs for /trace-refs — pointer-trace runner. Rules, not edges: this file
  holds sweep roots, hit taxonomy, special handling, and chain shapes. The trace
  itself is computed fresh every run and never stored (claviature ruling: derived
  index, register nothing). No report/ folder, no card — by design.
---

# trace-refs scopes

One section per scope. Split into per-scope files only when this file hurts (Foreman).

## scope: temple

**roots:**
- `/home/hruzam/reposoma`
- `/home/hruzam/.claude`
- `/home/hruzam/.config/zsh`

**classify** (first match wins, order: frozen → historical → design-time → live):
- **frozen:** `agents-backup-*/` · `*.backup-*` — snapshots; never touch.
- **historical:** `raw.reports/` · `pulse.*.md` · `raw.therapy/` · `_mail/*/archive/` ·
  `temple/evidence/` · `temple/legacy-wall.md` — append-only record; never repair.
  The past is allowed to name dead things.
- **design-time:** `raw.settings/raw.card.*` — never hand-edit; flag → refresh cycle
  (re-fetch + re-synthesize per canon.refresh-cycle).
- **live:** everything else — verdict per hit: repair / leave / flag.

**special handling:**
- `~/.claude/projects/*/memory/` — auto-memory; repairable, but minimal surgical
  edits only (remove the breaking line, add a one-line supersession note).
- `~/.config/zsh/` — fresh-read-first standing warning; any repair honors
  guide-for-builder.md as style LAW.
- canon (`raw.canon/` · `temple/decisions/`) — hits here are STOP items → @majkee.

**chains** (vertical hop patterns; verify each hop on disk):
- **refresh-scope:** `~/.claude/skills/refresh/SKILL.md` →
  `raw.research/<scope>/draft/README.md` → `draft/sources.jsonl` →
  `report/raw.<scope>.<date>.md` → `raw.settings/raw.card.<scope>.md` *(if `card:`)*
- **skill:** `~/.claude/skills/<name>/SKILL.md` → any config path it names →
  any output path it names
- **agent-seat:** `~/.claude/agents/<name>.md` → `temple/roster.md` →
  `temple/system-map.md` → pulse / live-board references
- **project:** `registry/<project>.md` (beacon) → `<project>/.dev/PROJECT.yaml` →
  `<project>.devenv/registry.json` → `~/.config/zsh/ai/temple-project-map.zsh`

Skill: `/trace-refs <target> [scope]`
