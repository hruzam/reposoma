---
kind: cold-start-card
date: 2026-09-10
brand: claude
seat: Trajectory
project: ia-sync
root: ~/ia-sync
commit: 0c31011 (main) — working tree carries uncommitted session-browser work; majkee runs git
task: session-browser arc A–D done + gaveled; examples chapter HELD; home evidence owed
resume: "tmux new-session -A -s rb-arc 'cd ~/ia-sync && claude --resume 98690912-7d0a-485c-a45e-ccffa064173a'"
model: fable
dedicated: "@Trajectory — this is a live-session wake, not a fresh incarnation"
recommend: "Run resume ON OFFICE (session lives there; from home go tso → ssh first). STATUS owns the position — read it before typing anything."
runbook: ~/ia-sync/.dev/session/runbook-tool-00/RUNBOOK.md
pointers:
  - ~/ia-sync/.dev/session/runbook-tool-00/STATUS.md
  - ~/reposoma/raw.guides/session-browser/GUIDE.md
  - ~/ia-sync/zsh/session/
---

## What this card is

Wake-glue for the paused session-browser session (majkee switching home off,
2026-09-10). A **live bed exists** — `runbook-tool-00/STATUS.md` owns the position;
this card carries no competing next-action, only the door back in.

## Where things stand (pointers, not copies)

Arc A–D complete and gaveled; C acceptance test passed same day. `res/examples.md`
is HELD by majkee's word — waiting for possible further requirements, then written
once. Open on majkee's side: git ops (ia-sync + reposoma + nablarva), home
pull/deploy + `rb-selftest` there (the owed home evidence), then bed closure on his
call. Full detail: the STATUS checklist.

## First step after wake

Say what you tested or what requirement arrived — the session resumes from HOLD,
nothing is mid-flight (`in_flight: none` truth holds).

## The dogfood loop (deliberate)

This card is itself a test object: it should appear in `rb-open` → ≋ vault →
ia-sync umbrella with a `→ runbook-tool-00` landing arrow, its `resume:` line
rendered at the top of the card view, and **R** should copy that tmux command
straight to the clipboard. If any of that fails, that IS the session's first bug
report.

## Drain rule

Single reader (majkee/next incarnation). Once the wake happened, this card is
consumed — drain it `card/ → archive/`: the TUI's `A A` on this very card is the
canonical move.
