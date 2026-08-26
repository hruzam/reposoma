---
schema: codex-cold-start/v1
kind: task-handoff
state: ready
created_at: 2026-08-24T05:10:03+02:00
created_by: Cartan
audience: next-codex-session
host:
  hostname: hruzam-120922
  logical: office
project:
  root: /home/hruzam/unikuklatrix/termbrana
  branch: core
  head: e319ed459b268971555f257a7efc388f65490024
  upstream: origin/core
worktree:
  tracked: dirty
  ignored_project_state: clean
codex:
  cli: codex-cli 0.149.1
  session_id: 01a031a7-a4a0-77c0-abcb-835a755b4854
  rollout: /home/hruzam/.codex/sessions/2026/08/24/rollout-2026-08-24T04-44-25-01a031a7-a4a0-77c0-abcb-835a755b4854.jsonl
  model: gpt-5.6-sol
  effort: high
task:
  objective: Review and close the evidence-backed Termbrana README without changing the M0 gate.
  first_action: git -C /home/hruzam/unikuklatrix/termbrana diff -- README.md
authority:
  may_write:
    - /home/hruzam/unikuklatrix/termbrana/README.md
    - /home/hruzam/unikuklatrix/nablarva/.dev/session/pulse.md
  gated:
    - commit or push
    - M0 host-contract freeze
    - flag or topology changes
    - Codex deployment
pointers:
  - /home/hruzam/unikuklatrix/termbrana/README.md
  - /home/hruzam/unikuklatrix/nablarva/.dev/session/flag.md
  - /home/hruzam/unikuklatrix/nablarva/.dev/session/pulse.md
  - /home/hruzam/unikuklatrix/nablarva/.dev/session/toolbox-termbrana-02-m0-truthspike/status.md
  - /home/hruzam/unikuklatrix/nablarva/.dev/session/toolbox-termbrana-02-m0-truthspike/pad.1-m0-runtime-confirm.md
  - /home/hruzam/ia-sync/codex/AGENTS.md
---

## Read first

1. Nablarva `AGENTS.md`, then `.dev/session/flag.md` L9 and L11 for central governance.
2. Nablarva `.dev/session/pulse.md` top entry for the live task position.
3. This task directory's `status.md`, then the Termbrana `README.md` diff.

## Observed state

- `termbrana/core` is at `e319ed4`; only `README.md` is modified (153 insertions,
  3 deletions). The README describes the repository as an M0 probe, not a finished MVP.
- The pinned probe build completed successfully in this session. M0 remains open because the
  operator pad, evidence fold, and fresh-eyes acceptance pass remain.
- Termbrana remains a toolbox governed centrally by Nablarva flag L11. It has no local
  `AGENTS.md`, agent roster, pulse, devenv twin, or beacon.
- The portable Codex role palette is authored under `~/ia-sync/codex/`; it is not copied into
  Termbrana. That source work is a separate dirty ia-sync worktree until @majkee commits it.

## Repair queue

1. Review the README claims against `research/evidence/` and the current M0 `status.md`.
2. Make only corrections needed for truth, navigation, or reader clarity.
3. Run `git diff --check`, link existence checks, and the pinned Cargo build if code/build
   instructions changed.
4. Ask @majkee before committing or pushing. The operator pad is a separate next action.

## First tool shot

```bash
git -C /home/hruzam/unikuklatrix/termbrana status --short
git -C /home/hruzam/unikuklatrix/termbrana diff --check
git -C /home/hruzam/unikuklatrix/termbrana diff -- README.md
```

## Gates

- @majkee owns commit/push and any change to flag L11, topology, or M0 freeze.
- Do not create a Termbrana-local agent or continuity surface.

## Done when

- README claims match evidence and the still-open M0 gate.
- All local links resolve and `git diff --check` passes.
- The accepted disposition is reflected in Nablarva's single pulse; no competing pulse exists.
