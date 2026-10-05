---
kind: cold-start-card
date: 2026-10-05
brand: claude
seat: trajectory
project: nablarva
projects: [nablarva, ia-sync]
root: ~/unikuklatrix/nablarva
commit:                         # left for majkee — this seat did not inspect nablarva's git (foreign-project law)
task: technical support + monitor for the temporary protocol majkee will try in nablarva-X0-restarted — WHICH protocol, majkee says at wake; senior-dev posture, explain/diagnose/repair on request, no building unasked
resume: cd ~/unikuklatrix/nablarva && claude --resume e6276187-0ac9-439f-a4fd-72ebdbd19a0d   # same incarnation as the tunnel-02 card; fallback: claude --agent trajectory + this card
model: opus
dedicated: trajectory
recommend: read nablarva's AGENTS.md → .dev/session/flag.md → pulse.md BEFORE anything else (its read order, not ia-sync's). At entry the saddle asks "Am I the master app-scheme maintainer?" — the honest answer for a support seat is no. The X0 bed has NO RUNBOOK/STATUS yet: do not invent a position; ask majkee what is being tried and where its STATUS will live.
pointers:
  - ~/unikuklatrix/nablarva/AGENTS.md
  - ~/unikuklatrix/nablarva/.dev/session/nablarva-X0-restarted/README.md
  - ~/unikuklatrix/nablarva/.dev/session/nablarva-X0-restarted/_bus/
  - ~/unikuklatrix/nablarva/.dev/session/nablarva-X0-restarted/raw/brief.cartan.houston-mediation.2026-10-05.md
  - ~/unikuklatrix/nablarva/.dev/session/ovitmugen-01-basement/RUNBOOK.md
  - ~/unikuklatrix/nablarva/.dev/session/nablarva-02-pipe-qualification/STATUS.md
  - ~/reposoma/_cold-start/card/CS.tunnel-02-support.2026-10-05.md
  - ~/reposoma/raw.guides/tunnel/GUIDE.md
---

## prompt-0

###### prompt

```text
You are Trajectory, resumed as TECHNICAL SUPPORT inside a FOREIGN project. Re-resolve the host
by fingerprint. Then follow nablarva's own read order (AGENTS.md → flag.md → pulse.md) before
touching anything; its saddle, locks and session surfaces are not ia-sync's. Majkee will tell
you which temporary protocol is being tried in nablarva-X0-restarted; until he does, you have
no task — ask. Gating as in ~/ia-sync/protocole/colors/PROTOCOLE.md.
```

## What this bed is (as found 2026-10-05 — state, not position)

`nablarva-X0-restarted` = majkee's restart line ("calm and make order in chaos of intentions",
README 2026-10-01). Contents: README · `_bus/` cycles 01–04 (oraculum POINTs, cartan RETURNs)
· `raw/` (archive-candidates audit, a Cartan↔Houston mediation brief). **No RUNBOOK.md, no
STATUS.md** — so nothing here owns a gate yet, and this card carries no next-action.

## What the tunnel can and cannot do for a nablarva protocol

- **Can:** reach a stored Codex thread as a consultation line (bind by id, resume, turn,
  `tun read`), with bed-internal writes if the head's workspace root covers the bed. Two
  Claude seats may share one head by sharing one vault (coordination note, pointer above).
- **Cannot:** deliver into an **already-running interactive** Codex session. That is exactly
  `nablarva-02-pipe-qualification`'s question, pre-committed default **STOP**. Never assume it.
- **Ovitmugen** (`01-basement` current) hosts shells and tabs; it never send-keys. It can hold
  a BUS shell beside a TUI; it is not a transport.
- Evidence goes in the bed's `raw/`; exchange goes in `_bus/` as point/return/verdict only.

## Boundary

Reads anywhere in nablarva are free; writes outside the X0 bed need majkee. Do not expand an
investigation into other nablarva beds beyond what the protocol under test names.
