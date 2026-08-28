---
kind: cold-start-card
date: 2026-08-28
brand: codex
seat: Cartan
project: reposoma
root: ~/reposoma
commit: 4937df6 (core)
task: Smoke-test the rebuilt central cold-start-card vault with a real Codex write and read.
resume: codex --model gpt-5.6-terra --cd ~/reposoma
model: terra
dedicated: Cartan
recommend: Read the card, verify its pointers and prompt block, then drain me after reading.
pointers:
  - ~/reposoma/raw.guides/cold-start-card/GUIDE.md
  - ~/ia-sync/codex/skills/cold-start-card/SKILL.md
session_id: "01a030ca-568c-76b0-b498-916e72359b43"
rollout: ~/.codex/sessions/2026/08/24/rollout-2026-08-24T00-42-41-01a030ca-568c-76b0-b498-916e72359b43.jsonl
cli_version: codex-cli 0.150.1
effort: high
worktree_tracked: clean at capture
worktree_ignored: clean at capture
authority: user-directed smoke write; no live session bed
may_write: this one smoke card
gated: journal entry requires majkee approval; staging and commit forbidden
---

## prompt-0

###### prompt

```text
Read this card and its pointers. Confirm the shared frontmatter and Codex evidence remain
parseable, then drain me after reading by moving
~/reposoma/_cold-start/card/CS.codex-smoke.2026-08-28.md to
~/reposoma/_cold-start/archive/CS.codex-smoke.2026-08-28.md.
Do not stage or commit without explicit authority.
```

## Observed state

- observed — The bonded capture resolved office host, reposoma branch `core`, commit
  `4937df6`, and a clean tracked and ignored worktree before this card was written.
- reported — This is the first Codex session exercising the rebuilt central vault.
- inferred — Successful parsing and pointer checks demonstrate that the shared contract
  can carry Codex-specific evidence without nesting or altering the shared keys.

## Repair queue

- Drain me after reading; no other action is carried by this card.

## First tool shot

```sh
sed -n '1,120p' ~/reposoma/_cold-start/card/CS.codex-smoke.2026-08-28.md
```

## Done when

- The YAML parses, every pointer resolves, the prompt fence is intact, and the filename
  matches `CS.<slug>.<YYYY-MM-DD>.md`.
