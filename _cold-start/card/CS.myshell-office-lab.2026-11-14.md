---
kind: cold-start-card
date: 2026-11-14
brand: codex
seat: myShell
project: reposoma
projects: [reposoma, nabla-lab]
root: ~/reposoma
commit: 9d36fa1 (core)
task: Resume the office myShell controller and independent Claude and Codex Oraculum hemispheres after the planned electricity/internet pause.
resume: codex -C ~/reposoma/.majkee resume 01a1d980-a3a5-7582-bb81-ad793671744c
model: sol
dedicated: myShell
recommend: Verify office and saved session availability; rebuild missing elastic tmux windows and grouped viewers from the 2026-11-21 journal before resuming each session once.
pointers:
  - ~/reposoma/.majkee/AGENTS.md
  - ~/reposoma/.majkee/journal/2026-11-21.nabla-lab.md
  - ~/reposoma/.majkee/.germline/programs/office-lab/CONTROLLER.md
  - ~/reposoma/.majkee/journal/2026-11-14.md
  - ~/reposoma/.majkee/journal/raw.2026-11-13.md
  - ~/reposoma/.majkee/journal/raw.2026-11-14.tmux.md
  - ~/reposoma/.majkee/.germline/programs/tmux-bed/README.md
  - ~/nabla-lab/AGENTS.md
  - ~/nabla-lab/session/pulse.md
  - ~/nabla-lab/PROJECT.yaml
session_id: 01a1d980-a3a5-7582-bb81-ad793671744c
rollout: ~/.codex/sessions/2026/11/14/rollout-2026-11-14T11-00-48-01a1d980-a3a5-7582-bb81-ad793671744c.jsonl
cli_version: 0.171.0
updated: 2026-11-21
---

## Read first

This is the existing office-lab card, extended on 2026-11-21 at Majkee's request
before a planned electricity/internet pause; keep its original filename/date.
Read `~/reposoma/.majkee/AGENTS.md`, then
`~/reposoma/.majkee/journal/2026-11-21.nabla-lab.md` for the saved identities,
continuity sources, copyable elastic-tmux rebuild, resume commands and prompts.
The original assignment and gates remain in `~/reposoma/.majkee/journal/2026-11-14.md`
§§1–2; preparation procedure is
`~/reposoma/.majkee/.germline/programs/office-lab/CONTROLLER.md`.
Apply project-saddle and current lab instructions before project work.

## Saved team

| Seat | Session/thread ID | Resume cwd |
|---|---|---|
| myShell controller, Codex | `01a1d980-a3a5-7582-bb81-ad793671744c` | `~/reposoma/.majkee` |
| Oraculum hemisphere, Claude | `6ba0843f-1b28-468d-9854-d12d34e78471` | `~/nabla-lab` |
| Oraculum hemisphere, Codex | `01a1db8e-ab93-7f62-809a-3e162c7d7e6a` | `~/nabla-lab` |

Controller ID is observed from the current runtime. Both hemisphere IDs are
Majkee's supplied bindings; matching transcript filenames were not located in
office's usual local session directories. Verify availability/storage at restart;
absence from that filename check does not prove loss. Do not substitute `--last`,
another thread or a new session without resolving the gap.

## Observed state — 2026-11-21

- Host `office`, hostname `hruzam-120922`; reposoma `9d36fa1` on `core`.
- Lab checkout exists at `~/nabla-lab`, HEAD `07c62dc`, branch `core`, with existing
  untracked `session/jev-coordination-01-two-rails/`. Reposoma has unrelated
  journals and cold-start moves in progress. Preserve all other writers' work.
- The controller draft and office tmux setup were completed on 2026-11-14.
  New inventory now shows three live CLI windows (`codex`, `claude`, `codex`),
  with three matching attached grouped viewers. No sessions were stopped or
  restarted during this preservation. Majkee plans to close them for the outage.
- No new research dispatch/door qualification occurred in this preservation turn.
  Do not infer the hemispheres' research state from the old draft; request their
  own bounded read-backs and inspect any newer durable owner-state they identify.
- No live lab RUNBOOK/STATUS was identified in this preservation scope. Any
  subsequently identified project owner-state governs over this transfer pointer.

## Restart and viewers

After reboot, tmux's previous in-memory panes may be gone. The journal contains
an idempotent shell-only rebuild for base group `nabla-lab`, windows `controller`,
`claude`, `codex`, and these viewers. It creates missing components without
launching agent CLIs or killing existing sessions. Proposed elastic sizing is
per-window `window-size latest` plus `aggressive-resize on`; verify real resizing
after attachment. Historical 107×59 dimensions and pane IDs are not locks.

In three separate `tso` SSH terminals on office, after the rebuild:

```sh
tmux attach -t view-lab-controller
tmux attach -t view-lab-claude
tmux attach -t view-lab-codex
```

Scroll: `Ctrl-b [`; leave scroll mode: `q`; detach: `Ctrl-b d`.
Each viewer selects independently while sharing the same three windows. Resume
commands and prompts live in the journal; run each only in a verified shell and
only when the same saved session has no other writer. If this controller is
already resumed elsewhere, do not create another controller process in tmux.

## Repair queue

- Restore/recheck the office frame and missing elastic windows/viewers after
  restart; verify each saved session binding and report missing local custody.
- Read back each hemisphere's own continuity and evidence paths without exposing
  the other answer. Keep myShell as the assigned controller plus keeper, with
  independent acceptance review separate where required.
- Refresh the original planned linguistic/caching research assignment and common
  source corpus. Same position-free brief, separate RETURNs; compare only after
  both are complete. Exact artifact paths and any newer project doing-state win.
- Qualify any still-unproven office communication door under a concrete release;
  preserve file-as-message, bell-as-hint, look-first and no uncertain-send retry.
- Local configuration investigation remains bounded: the earlier office candidate
  was lab `.claude/settings.local.json`, absent at that path on home/monitor when
  checked on 2026-11-14. No settings were copied or changed; refresh before action.

## First tool shot

```sh
hostname
printenv MACHINE_NAME
git -C ~/reposoma status -sb
tmux list-sessions -F '#S group=#{session_group} windows=#{session_windows} current=#{window_name}'
```

## Gates

The operator's restart request authorizes preparing the requested tmux shell
windows/viewers after restart; it does not dispatch research. Earlier operator
preference remains: the operator launches/resumes CLIs, no duplicate writers.
No live research sends before Majkee's GO. Preserve blindness, other work and
trust/approval prompts. No shutdown, kill, commit, push or configuration transport
is authorized by this card update. Uncommitted changes are local to office until
separately committed and transported.
