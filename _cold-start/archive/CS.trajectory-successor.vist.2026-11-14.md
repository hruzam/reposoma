---
kind: cold-start-card
date: 2026-11-14
brand: claude
seat: trajectory|engineer (builder / report author)
from_session: 06352fda-5b7f-4621-b7d1-617be6bc51a4 (retiring, context low)
to_session: FRESH Claude session with cwd ~/unikuklatrix/nablarva (seat cwd = repo whose rules govern its writes; majkee 2026-11-14).
  Launch: tmux new-window -t vist -n traj-x0 -c ~/unikuklatrix/nablarva 'exec claude --agent trajectory --model opus'
  then set labels (@seat trajectory @vendor claude @carrier tmux; @id after start). b0080cc2 (vist:10, cwd ia-sync) is NOT used for X0.
projects: [ia-sync, nablarva]
task: Builder seat for vist-X0 RUNBOOK preparation under cartan's agreed plan. Nothing assigned yet; wait for a POINT.
resume: in the new window paste prompt-0 below (majkee or the controller does it, not the old trajectory)
authority: builder only. The controller (cartan, Codex) owns STATUS, integration and push. Majkee owns GO/STOP and releases (L21).
---

## State in one screen

- **vistMini-01-tests is CLOSED and ARCHIVED.** Majkee GO 2026-11-14: "scope narrowed, unrun cases go to vist-X0, GO".
  Path is now `~/ia-sync/.dev/records/vist/2026-11-14/vistMini-01-tests/`; `~/ia-sync/ARCHIVE.md` resolves old paths.
  Accepted report `reports/trial-report.vistmini-01.md` @3584a02. The transport prototype `scripts/vist-deliver.sh` is NOT released.
- **vist-X0 is in planning.** Bed `~/unikuklatrix/nablarva/.dev/session/vist-X0-helloWorld/raw/` (no RUNBOOK yet). Read:
  1. `plan.runbook-and-team.cartan-trajectory.2026-11-14.md` (the agreed plan, core 32dadb3). **This is the authority.**
  2. `preregister.vistmini-carryover.cartan.2026-11-14.md` (six unrun cases U01–U06)
  3. `handoff.vistmini-05-team.cartan…` then `handoff.vistmini-04-longrun.trajectory…` (read 04's CORRECTION box first)
  4. `consult.runbook-team.*` (how the plan converged)
- **Your likely first job (plan step 3):** the C04 r1-vs-r2 annotated timeline from the archived case file
  `reports/cartan.cases-08.2026-11-13.md`. It is historical annotation, not a fresh run.

## Seats (tmux session `vist`)
controller = next.cartan (Codex, vist:8, thread 01a1d58a-3b43-7221-bf9b-fa98b219df6b), ring with
`codex queue --thread 01a1d58a-… --message "<one pointer line>"` (no --resume). Witness candidate = oraculum (Claude Fable, vist:5, c266d10a-…).
Many windows are shell-rooted: the old vist-deliver.sh refuses them (22). Don't type into other panes.

## Holds (never break)
- Never retry or clear the uncertain keys t03 and `~/.local/state/vist/sent/c08r1-05-ae3ee8e7`.
- No push, no STATUS edits unless a POINT says so. nablarva: plain `git pull`/`git push`, never `--rebase` (L12).
- Every claim names its file; uncited = "author account, unverified" (scar R4).
- A RETURN is your own file only; never write into another seat's RETURN path.
- Single-step shell commands (no `&&` chains): the local allow-list matches single commands.
- Write your own card at ≤35% context left (keeper cadence, RETURN12).

## Lessons (one line each)
Doors beat keystrokes · bells are hints, files are truth · author ≠ reviewer · observation-first (L20) · release is per action (L21).

## prompt-0

```text
You are trajectory (Claude, builder) for vist-X0 preparation, successor of session 06352fda.
Read /home/hruzam/reposoma/_cold-start/card/CS.trajectory-successor.vist.2026-11-14.md, then the four raw/ files it lists, in order.
Do not start work. Write a read-back (<=200 words) to
~/unikuklatrix/nablarva/.dev/session/vist-X0-helloWorld/raw/readback.trajectory-successor.2026-11-14.md:
who the controller is, what is authorised and what is not, the holds, and your expected first task.
Then ring the controller once with codex queue (thread in the card) pointing at that file, and wait for a POINT.
```
