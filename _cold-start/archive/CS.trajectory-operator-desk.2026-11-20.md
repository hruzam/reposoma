---
kind: cold-start-card
date: 2026-11-20
brand: claude
seat: trajectory
project: nablarva
projects: [nablarva, ia-sync, reposoma]
root: ~/unikuklatrix/nablarva
commit: ec090ec (core)
task: Re-enter as operator desk for majkee on vist-X0 (record his words verbatim, hand them to the pen). No pen of its own.
resume: claude --resume 06352fda-5b7f-4621-b7d1-617be6bc51a4 (home only) | fresh: cd ~/unikuklatrix/nablarva && claude --agent trajectory --model opus
model: opus
dedicated: trajectory
recommend: Read STATUS first; say "via controller" or "direct" before every write; never push in a bed you don't hold.
pointers:
  - ~/unikuklatrix/nablarva/.dev/session/vist-X0-helloWorld/STATUS.md
  - ~/unikuklatrix/nablarva/.dev/session/vist-X0-helloWorld/raw/cache.operator-desk.trajectory.2026-11-20.md
  - ~/unikuklatrix/nablarva/.dev/session/vist-X0-helloWorld/raw/decision.majkee.fallback-poke.2026-11-14.md
  - ~/reposoma/_cold-start/card/CS.trajectory-successor.vist.2026-11-14.md
  - ~/reposoma/raw.therapy/trajectory/therapy.md
---

## Pending

STATUS owns the position. This card carries no next-action. The desk's open items (decisions owed by majkee,
uncommitted files, stale bindings) are listed in the cache pointer above.

## First step

Resolve the host. STATUS `operator_desk` names Trajectory 06352fda on home. A fresh desk, or the same desk on
another host, does not act as operator desk until majkee names it in one line and the controller records that in
STATUS. Until then, read only.

Do not resume `b0080cc2-e56d-4244-86a9-b88660720e63`: it is an idle ia-sync spare, not a successor.

## Session advice

The pen is a name in a file, not whoever spoke last. When majkee's words come through the desk, write them verbatim
to a decision file and hand them to the pen; do not act around it.

## Hygiene

nablarva: L12, plain `git pull`/`push`, never `--rebase`; commit only your own paths. ia-sync is public: no tokens,
keys or personal data. `.majkee/` is never committed by this seat. Move this card to `archive/` once consumed.
