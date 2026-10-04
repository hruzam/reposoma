---
kind: cold-start-card
date: 2026-10-02
brand: claude
seat: trajectory
project: nablarva
projects: [nablarva, ia-sync]
root: ~/unikuklatrix/nablarva
commit: c630f0e (core)
task: ovitmugen basement — map/state/events, fast tab jumps, last bed + remembered tabs, shared keys, swappable layout + preset manager
resume: claude --agent trajectory   # FRESH session, not --resume; paste prompt-0 below
model: opus
dedicated: trajectory
recommend: Fresh cSharp head. Read the experience transfer before writing code; run the selftest on home too before asking majkee to walk.
runbook: ~/unikuklatrix/nablarva/.dev/session/ovitmugen-01-basement/RUNBOOK.md
pointers:
  - ~/unikuklatrix/nablarva/.dev/session/ovitmugen-01-basement/STATUS.md
  - ~/unikuklatrix/nablarva/raw.nablarva/ovitmugen-00-console/experience-transfer.trajectory.2026-10-02.md
  - ~/unikuklatrix/nablarva/.dev/session/ovitmugen-01-basement/raw/architecture.pipes-ui-keys.2026-09-29.md
  - ~/unikuklatrix/nablarva/.dev/session/AGENTS.PROJECT-DESIGN.md
  - ~/ia-sync/zsh/session/ovitmugen.py
---

## prompt-0

###### prompt

```text
You are Trajectory, cSharp head of /home/hruzam/unikuklatrix/nablarva/.dev/session/ovitmugen-01-basement/.
Read RUNBOOK.md and STATUS.md there, then /home/hruzam/reposoma/raw.guides/runbook/res/csharp-head-protocol.md,
then /home/hruzam/unikuklatrix/nablarva/raw.nablarva/ovitmugen-00-console/experience-transfer.trajectory.2026-10-02.md,
then the design file named in the RUNBOOK's Fixed facts (§8–§12 first) and § KEYS CODE in
/home/hruzam/unikuklatrix/nablarva/.dev/session/AGENTS.PROJECT-DESIGN.md.
STATUS owns the next action. Build B1 → B2 → B3 → layout; one file-scope notice before each step;
ov-selftest + runbook selftest green (office AND home) after each; commit only own paths;
push only with an explicit refspec to an own commit. Never deploy.
```

## Continuity

- **Position:** STATUS of the 01 bed owns it; this card carries no next-action.
- **Predecessor:** ovitmugen-00-console, closed GO 2026-10-02 and pruned; history in
  `raw.nablarva/ovitmugen-00-console/` (RUNBOOK, manifest, transfer).
- **Two holds the fresh head must honour first:** today's `ov-ls --json` shape is a consumer
  contract (nablarva-00, nablarva-03); D2's state dir goes to Cartan's nablarva-03 blueprint
  via majkee before B1 writes `~/.local/state/ovitmugen/`.
- **Lesson:** every live walk found a bug the isolated selftest could not — test on home too.
- **Hygiene debt** (re-checked 2026-10-04, still true): nablarva commits c2882bd, c630f0e, 06ab8d5,
  e5c331b, 852ff08, f8395ae are local only, waiting behind other sessions' unpushed commits
  (majkee: wait for them; push only by explicit refspec to an own commit).

## Added 2026-10-04 — pane-scoped copy (backlog U9, outside the 01 gate)

- **Friction (majkee):** copying a few lines from an agent pane with Shift+drag also takes the
  other panes' lines. Cause: Shift bypasses tmux and Konsole selects whole screen rows — it
  knows nothing about panes. Natural, not a bug.
- **Workaround now:** `C-a z` (zoom the pane) → Shift+drag → `C-a z` back.
- **Pane-scoped way:** plain drag (no Shift) in the frame → tmux copy mode stays inside the pane
  and copies on release. System clipboard depends on OSC 52 (`set-clipboard external` is on;
  Konsole 26.04 acceptance NOT verified). Office facts 2026-10-04: Wayland, `xsel` present,
  `wl-copy`/`xclip` absent; default server mouse=off, frame mouse=on, no copy-command set.
- **U9 for the head:** ask majkee for the paste test first (drag in the left pane → paste in another
  app). Empty → add `set -s copy-command 'xsel -ib'` to ovitmugen.tmux.conf (+ selftest that the
  option loads) and a help line "copy: C-a z + Shift-drag, or plain drag"; record U9 in
  raw/ui-operability.2026-09-29.md of the bed.
