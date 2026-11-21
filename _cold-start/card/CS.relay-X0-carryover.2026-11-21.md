---
kind: cold-start-card
date: 2026-11-21
brand: claude
seat: trajectory
project: nablarva
root: ~/unikuklatrix/nablarva
commit: 02e1b6f (core)
task: Take up the relay line on a clean table from the bed relay-X0-carryover — goals as small files, VIST X0 property carried by pointer.
resume: cd ~/unikuklatrix/nablarva && claude --agent trajectory   # then activate the cold-start-card skill on this card
model: fable
dedicated: trajectory
recommend: Read STATUS first and do only what it names. STATUS says which coordination (pokes, reply bells, the controller's push) is already permitted; nothing else that sends, starts or copies runs without Majkee's release for that goal.
pointers:
  - ~/unikuklatrix/nablarva/.dev/session/relay-X0-carryover/STATUS.md
  - ~/unikuklatrix/nablarva/AGENTS.md
  - ~/unikuklatrix/nablarva/.dev/session/flag.md
  - ~/unikuklatrix/nablarva/.dev/session/relay-X.ledger.md
  - ~/unikuklatrix/nablarva/.dev/session/relay-X0-carryover/raw/decision.majkee.open-bed.2026-11-21.md
  - ~/unikuklatrix/nablarva/.dev/session/relay-X0-carryover/raw/export.vist-x0.engineer.2026-11-21.md
  - ~/unikuklatrix/nablarva/.dev/session/relay-X0-carryover/goals/README.md
  - ~/unikuklatrix/nablarva/.dev/session/relay-X0-carryover/raw/roster.2026-11-21.md
  - ~/reposoma/raw.guides/bus/res/file-poke.md
source_host: home / hruzam
---

# Clean-table entry — relay-X0-carryover

Transfer pointer only. **The bed's STATUS owns the position** (one-authority rule). This bed has **no RUNBOOK** on purpose:
Majkee is trying goals as small independent files (`goals/`). STATUS is the single entry point and names every other file.

## What a fresh seat must know before it acts

- **The pen is not inherited.** The pen holder was the Claude session `d1ca16e9…` (engineer, home). A new session takes the pen
  only on Majkee's word, written into a decision file in the bed's `raw/`. Until then it reads and proposes.
- **The origin bed is not this bed.** `vist-X0-helloWorld` keeps its own open gate, its frozen review packet and its own pen
  (Codex thread `01a1d582…`, on office). It is read-only from here. Majkee is still studying it.
- **The party is host- and session-bound.** The roster describes home's tmux group `helloWorld` on 2026-11-21. Pane ids and thread
  ids are stale after any rebuild, restart or host move. Re-read them against live tmux before any poke.
- **Evidence at risk:** the C04 inputs sit in `/tmp` on home (tmpfs). A reboot loses them. Goal G9 part (a) is Majkee's decision.

## First tool shot

```sh
hostname -s; git -C ~/unikuklatrix/nablarva status --short; git -C ~/unikuklatrix/nablarva log --oneline -5
cat ~/unikuklatrix/nablarva/.dev/session/relay-X0-carryover/STATUS.md
cat ~/unikuklatrix/nablarva/.dev/session/relay-X0-carryover/goals/README.md
```

## One lesson from the session that wrote this card

I wrote the export alone and four of my statements were overclaims that only the other vendor's check found (cycle 01 verdict).
Keep the author and the checker in different seats, and give the checker the files, not your conclusion.

## prompt-0

###### prompt

```text
You are Trajectory entering the nablarva relay line on a clean table. Read ~/unikuklatrix/nablarva/AGENTS.md and its read
chain, then ~/unikuklatrix/nablarva/.dev/session/relay-X0-carryover/STATUS.md, which names every other file of the bed.
Resolve the host and the worktree first. You do not hold the pen until Majkee says so and it is recorded in the bed.
Do only what STATUS.next names. Goals live in goals/ and each names the release it needs. STATUS names the coordination that
is already permitted; beyond that, run nothing that sends, starts or copies without that release. The origin bed vist-X0-helloWorld is read-only. Never read .majkee/ or .hlm/.
```
