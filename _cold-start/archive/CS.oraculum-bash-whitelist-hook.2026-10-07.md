---
kind: cold-start-card
date: 2026-10-07
brand: claude
seat: oraculum
project: ia-sync
projects: [ia-sync, nablarva]
root: ~/ia-sync
commit: 549bd62 (main)
task: build an AGENT-SCOPED Bash whitelist for the oraculum seat — a PreToolUse hook in the agent's frontmatter `hooks:` that denies any Bash command outside a short bookkeeping list and tells the agent to spawn instead (token economy enforced by mechanism, not prose); oraculum first, pattern reusable for any head with Bash
resume: cd ~/ia-sync && claude --agent atlas-ui → paste prompt-0
model: opus
dedicated: atlas-ui (primitive creator; living session with majkee — a separate sitting, not part of nablarva X1)
recommend: golden rule is already answered — `hooks:` frontmatter exists in houston.md + flight.md on the table; build only the whitelist script + one frontmatter block; test on a COPY in a scratch project before touching the surgical table; deploy via deploy.sh is majkee's reviewed step
pointers:
  - ~/ia-sync/claude/agents/oraculum.md
  - ~/ia-sync/claude/agents/houston.md
  - ~/ia-sync/claude/agents/flight.md
  - ~/ia-sync/SYNC_DISCIPLINE.md
  - ~/reposoma/raw.therapy/gavels/gavels.md
  - ~/unikuklatrix/nablarva/.dev/observations/README.md
---

# Oraculum's Bash whitelist — agent-scoped PreToolUse hook (Atlas build)

Origin: nablarva X0/X1 carrier regime (2026-10-01→07). The carrier seat needs Bash for bookkeeping (git · ls · hashes · the tunnel helper) and should push coding and larger shell work to spawns (@delta · @vector · @trajectory). Today that is a prose rule in the agent body — G-27: a rule that cannot stop the hand. This card makes it a mechanism.

## Verified facts (claude 2.1.292, docs 2026-10-07 — permissions · sub-agents · hooks-guide · cli-reference)

- Settings rules `Bash(<prefix>:*)` exist, merge across scopes, **deny > ask > allow — a blanket `deny: ["Bash"]` cannot be carved by allow rules**; so settings alone give no per-agent whitelist.
- Agent frontmatter `tools:` / `disallowedTools:` take **bare tool names only**, no `Bash(...)` patterns.
- Agent frontmatter **`hooks:`** is supported and fires **only while that agent runs** (agent-scoped). **In-house precedent, read first:** `houston.md:25–34` already runs `PreToolUse · matcher: "Bash"` → `~/.claude/hooks/guard-destructive.sh` — same shape, same script home (`claude/hooks/` on the table → `~/.claude/hooks/` live); the whitelist script is its sibling, and the two hooks compose (both run; any deny holds). `PreToolUse` receives `tool_input.command`; deny = exit 2 + stderr, or exit 0 + `{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"deny","permissionDecisionReason":"…"}}`. Optional `if: "Bash(…)"` filter on the hook entry.
- **The agent sees the denial reason** → it can route to a spawn. That line IS the economy.
- Per-launch alternative for living sessions only: `claude --agent oraculum --allowedTools "Bash(git log:*)" …` (everything else asks the human; useless unattended).

## Build (Atlas, with majkee present)

1. **Script** `claude/hooks/bash-whitelist.sh` (or beside existing hook scripts — follow the table's layout): read stdin JSON, extract `tool_input.command`, match against a whitelist of prefixes — proposed: `git log|status|diff|show|hash-object|ls-files|ls-tree|add|commit|rev-parse|mv|rm` · `ls` · `cat|sed -n|head|tail|wc|grep` (read-only inspection) · `cmp` · `printf|echo >>` to `.md` only · `zsh ~/.config/zsh/ai/tunnel-codex.zsh` · `python3 -` for YAML parse-checks · `jq`. Everything else → exit 2 with stderr: `out of whitelist (<first token>) — spawn @delta / @vector / @trajectory for this; carrier Bash is bookkeeping only`. Compound commands: deny if ANY segment (split on `&&`, `;`, `|`) fails the list — no laundering through pipes.
2. **Frontmatter block** in `oraculum.md`: `hooks: PreToolUse: [{matcher: Bash, hooks: [{type: command, command: <script path>}]}]` — copy the exact shape from `houston.md:25+` (the in-house precedent), do not invent grammar.
3. **Test on a copy** in a scratch project `.claude/agents/oraculum.md`: three probes — allowed command runs · forbidden `python3 script.py` denied with the reason visible · compound `git status && rm -rf x` denied. Record client version + date (G-47 extension: a claim carries the moment it was seen).
4. **Write the pattern once** as a reusable note (where Atlas keeps primitive patterns), so flight/houston-family heads can adopt it by pointer.
5. Deploy = `deploy.sh` reviewed by majkee (SYNC_DISCIPLINE); never the live `~/.claude/` directly.

## Not in this card

Settings-wide deny rules (they shape the room, not the seat) · changing which tools oraculum has · the nablarva X1 work (its own bed; this hook will simply apply to the next oraculum there once deployed).

## prompt-0

###### prompt

```text
Read ~/reposoma/_cold-start/card/CS.oraculum-bash-whitelist-hook.2026-10-07.md. Build the agent-scoped Bash whitelist hook for ~/ia-sync/claude/agents/oraculum.md per §Build: script first, frontmatter block copied from houston.md's hooks: shape, three probes on a copy in a scratch project, record client version and date. Confirm the whitelist list with majkee before writing the script. Do not deploy; majkee runs deploy.sh after review.
```
