---
kind: issue-card
date: 2026-10-08
brand: claude
found_by: atlas-ui
project: ia-sync
root: ~/ia-sync
where: ~/.claude/hooks/guard-destructive.sh (live only — not on the table)
defect: guard-destructive.sh reads $TOOL_INPUT, which Claude Code never sets (hook input is JSON on stdin), so it allows every command including rm -rf /
assoc: [hook, PreToolUse, guard, dead-guard, stdin-contract, houston, live-only, table-drift, silent-pass]
severity: med
pointers:
  - ~/ia-sync/claude/agents/houston.md        # frontmatter hooks: PreToolUse → this script
  - ~/ia-sync/claude/hooks/oraculum-bash-whitelist.sh   # correct stdin/jq reading, sibling
  - ~/ia-sync/claude/hooks/README.md          # the agent-scoped hook pattern
  - ~/reposoma/_cold-start/card/CS.oraculum-bash-whitelist-hook.2026-10-07.md
---

Found 2026-10-08 (atlas-ui, client 2.1.293) while using houston.md's `hooks:` block as the precedent
for the oraculum Bash whitelist.

**Verified:** `jq -nc '{tool_input:{command:"rm -rf / && artisan migrate:fresh"}}' | env -u TOOL_INPUT
bash ~/.claude/hooks/guard-destructive.sh` → exit 0 (allow). It only blocks when `TOOL_INPUT` is set by
hand. The PreToolUse contract delivers `.tool_input.command` on stdin; the env var never exists.

**Three stacked defects (one card — same surface):**
1. Dead input read (above) — the guard has passed everything since it was written (2026-06-08).
2. Moot wiring — houston.md lists no `Bash` tool, so its PreToolUse[Bash] hook can never fire anyway.
3. Live-only — the script exists in `~/.claude/hooks/` on office, not on the table; `deploy.sh` had no
   hooks leg until 2026-10-08 (now added, no `--delete`). Home very likely lacks the file entirely.

**FIX — applied on the table 2026-10-08 (atlas-ui, majkee's call), deploy pending:**
`~/ia-sync/claude/hooks/guard-destructive.sh` now reads `INPUT=$(jq -r '.tool_input.command // empty')`
from stdin, fails closed (exit 2) on unreadable input or missing jq, keeps exit 2 + stderr. Patterns
unchanged. Offline probe 12/12 (stdin JSON, `TOOL_INPUT` unset). The `deploy.sh` hooks leg (rsync `-a`)
overwrites the live copy on office and creates it on home.

**Now-live consequence:** the original `rm -rf /` regex also blocks `rm -rf /any/absolute/path` — it was
always written that way but never enforced. Harmless today (houston has no Bash); revisit the pattern
before wiring this guard onto a seat that holds Bash.

**Still open (operator):** whether houston.md keeps a Bash hook at all, or the guard moves to a seat
that holds Bash (flight: all tools, Stop hook only). Fold to `archive/` after deploy + both hosts show
`jq -nc '{tool_input:{command:"rm -rf /"}}' | bash ~/.claude/hooks/guard-destructive.sh; echo $?` → 2.
