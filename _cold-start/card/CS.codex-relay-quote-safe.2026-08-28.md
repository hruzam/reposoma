---
kind: cold-start-card
date: 2026-08-28
brand: claude
seat: atlas-ui
project: ia-sync
projects: [ia-sync, reposoma]
root: ~/ia-sync
task: fix codex-relay quote-collision — inner quotes in a relayed prompt break the codex-run shell arg
resume: claude --agent atlas-ui  (relay-spec rule) + a Bash/maintenance seat (wrapper fix)
model: sonnet
dedicated: Kelvin/Cartan for the codex-run wrapper (infra) · atlas-ui for the relay agent-spec rule
recommend: fix the WRAPPER first (heredoc/stdin kills the whole class); the per-spec rule is belt-and-suspenders
pointers:
  - ~/reposoma/pulse.atlas.md   # 2026-08-28 Metaterminal entry, ledger open-item (3)
  - ~/ia-sync/zsh/guides/codex-relay.contract.md
---

# Codex-relay quote-collision — root-cause fix for mirror / vega / astrobley

**The bug (majkee caught, 2026-08-28).** A relay seat (@mirror / @vega / @astrobley) composes a
codex-run invocation that wraps the prompt as a shell arg. When the prompt CONTENT contains an inner
double-quote or apostrophe, the first inner quote terminates the string and the rest becomes broken
shell — the relay then burns its whole turn budget fighting the quoting and returns nothing. Earlier
mis-diagnosed as a @mirror 3-turn-cap problem; the cap only left no room to recover. This is a
recurring failure: `_cold-start` card `CS.termbrana-m0.2026-08-15` already flagged the relay plumbing
as fragile before the next Mirror turn.

## The fix — two layers

1. **Wrapper (root cure, Kelvin/Cartan).** `codex-run` must never pass the prompt as an inline quoted
   arg. Pass via stdin heredoc with a quoted delimiter, or via a temp file whose path is the arg. A
   quoted heredoc delimiter makes the body fully literal — inner quotes, dollar-signs, backticks all
   pass untouched. This kills the class for every relay seat at once.
2. **Relay agent specs (belt-and-suspenders, atlas-ui).** mirror.md / vega.md / astrobley.md gain a
   rule: when relaying, pass the prompt through the quote-safe channel (heredoc/file), never an inline
   double-quoted arg; do not hand-escape.

## Target surfaces

- `~/ia-sync/zsh/ai/codex-run.zsh` (or wherever the wrapper lives) — the heredoc/stdin change.
- `~/ia-sync/zsh/guides/codex-relay.contract.md` — record the quote-safe passing law.
- `~/ia-sync/claude/agents/{mirror,vega,astrobley}.md` — the per-spec rule.

## Builder rule for atlas (the standing lesson)

Any future relay/composite seat I build carries the quote-safe passing rule by default. And any master
prompt I hand a human to paste into Codex is authored quote-clean (no inner `"` or `'`), so it survives
either shell wrap — this card's own `prompt-0` is written that way on purpose.

## prompt-0

###### prompt

```text
Fix the codex-relay quote-collision bug. Root cause: the codex-run wrapper passes the relayed prompt
as an inline quoted shell arg, so any inner quote in the prompt content breaks the string and the
relay seat (mirror/vega/astrobley) fails. Do two things:
1. Change the wrapper to pass the prompt via a quoted-delimiter heredoc on stdin, or via a temp file
   path — never an inline quoted arg. Verify with a prompt that contains both a double-quote and an
   apostrophe.
2. Add a quote-safe passing rule to codex-relay.contract.md and to the mirror/vega/astrobley agent
   specs.
Start by reading ~/ia-sync/zsh/guides/codex-relay.contract.md and locating the codex-run wrapper.
```
