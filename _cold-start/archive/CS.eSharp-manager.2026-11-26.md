---
kind: cold-start-card
date: 2026-11-26
brand: claude
seat: eSharp manager (trajectory)
project: nablarva
projects: [nablarva, ia-sync]
root: ~/unikuklatrix/nablarva
commit: 0d222b7 (core) — the manager's last commit; local at card time, goes out with the next push
task: Navigate the two eSharp working groups — group 1 (session-window) runs under its own lead; group 2 (terminal-workspace) is not framed yet
resume: tmux helloWorld, window eSharp — `claude attach 4f923bb7`, then /clear and paste prompt-0
model: fable
dedicated: trajectory (Claude) as manager; seniorDev (Codex) for the opposing read; supervisorCli (Codex) for every push
recommend: Start at the board. Write only in eSharp/ and the two eSharp.* files; a group's bed belongs to its lead. Read pane ids fresh before every send.
pointers:
  - ~/unikuklatrix/nablarva/.dev/session/eSharp.board.md
  - ~/unikuklatrix/nablarva/.dev/session/eSharp.decisions.majkee.2026-11-22.md (sections 10–13, "Not decided here")
  - ~/unikuklatrix/nablarva/.dev/session/eSharp/roster-proposal.eSharp.md (Majkee's roster and tmux map — his file)
  - ~/unikuklatrix/nablarva/.dev/session/eSharp/ (briefs, _bus/, side-quest, observations)
  - ~/unikuklatrix/nablarva/.dev/session/session-window-X1-surface/STATUS.md (group 1 — the lead's)
  - ~/unikuklatrix/nablarva/.dev/session/pulse.md and flag.md
host: home
---

# eSharp manager — re-entry

The manager holds no state of its own. It keeps one board, orders what goes to Majkee, and carries
what one group needs from another. It has no bed and no gate.

## Pending, in order

1. Group 2's frame (`terminal-workspace-X1-v0`: RUNBOOK, STATUS, router line) — when group 1 has
   closed a cycle, or on Majkee's word. Inputs: eSharp/brief.terminal-workspace.2026-11-22.md, the NEW
   card, decisions sections 7 (E5–E8), 8 and 10, side-quest sections 5 and 8. Test session:
   `sandbox-terwor` on `tmux -L sandbox-server`. Its lead closes the old bed.
2. Side-quest: collected in three passes — eSharp/side-quest.2026-11-26.md. Its section 10 lists eight
   points that wait for Majkee's word; nothing more is owed on it until he answers.
3. The seams on the board, section 3 — first the field list from group 1 to group 2.
4. The relay bed is not the manager's any more: the on-call duty ended on Majkee's word of 2026-11-26
   (decisions, section 14). He retires that bed himself.

## First step

Read the board, then "Not decided here" in the decisions record, then group 1's STATUS. Look at live
tmux read-only before trusting any pane id.

## One lesson

Work from files, not from memory. Copy Majkee's words by script, put your reading beside them, and
never read a release into an answer.

## Debts

- Commit 0d222b7 is local.
- Untracked and not the manager's: two side-quest files in relay-X1-probes/raw/, nano.2280604.save.
- session-window-X0-substrate is closed but not retired — Majkee's word.
- The exec desk has not been told about the board.

## prompt-0

###### prompt

```text
You are the eSharp manager (agent trajectory, Claude) on host home, in tmux session helloWorld, window
eSharp. You navigate two working groups in ~/unikuklatrix/nablarva and hold no state of your own.
Read, in this order: ~/unikuklatrix/nablarva/AGENTS.md and its read chain;
~/unikuklatrix/nablarva/.dev/session/eSharp.board.md; sections 10 to 13 and "Not decided here" of
~/unikuklatrix/nablarva/.dev/session/eSharp.decisions.majkee.2026-11-22.md;
~/unikuklatrix/nablarva/.dev/session/session-window-X1-surface/STATUS.md. Then look at live tmux
read-only (tmux list-windows -a): pane ids in files go stale. You write only in
~/unikuklatrix/nablarva/.dev/session/eSharp/ and the two eSharp.* files beside it, never in a group's
bed. Coordination pokes are yours to send; anything that starts, activates or delivers waits for
Majkee's own words. Never read .majkee/ or .hlm/. Then tell Majkee what you found and what you take
up first.
```
