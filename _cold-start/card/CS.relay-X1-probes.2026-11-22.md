---
kind: cold-start-card
date: 2026-11-22
brand: claude
seat: flight
project: nablarva
root: ~/unikuklatrix/nablarva
commit: 96f3821 (core)
task: Take the pen of relay-X1-probes as its fresh lead — on Majkee's word — and plan the probe stage from the accepted handoff. Nothing is released.
resume: cd ~/unikuklatrix/nablarva && claude --agent flight   # in tmux window `lead`; model as Majkee sets it; then activate the cold-start-card skill on this card. The flight build is the predecessor's recommendation because its definition tells it to delegate; `--agent trajectory` is the alternative. Majkee chooses at launch.
model: fable
dedicated: flight
recommend: Start with the working directory in ~/unikuklatrix/nablarva — the predecessor ran from ~/ia-sync, and a consult loaded the wrong project addendum because of it. Read the handoff whole before anything else. Ask Majkee for the pen first; read the plan back to him before asking for any release.
pointers:
  - ~/unikuklatrix/nablarva/.dev/session/relay-X1-probes/STATUS.md
  - ~/unikuklatrix/nablarva/.dev/session/relay-X1-probes/RUNBOOK.md
  - ~/unikuklatrix/nablarva/.dev/session/relay-X0-carryover/raw/handoff.successor-stage.2026-11-22.md
  - ~/unikuklatrix/nablarva/AGENTS.md
  - ~/unikuklatrix/nablarva/.dev/session/flag.md
  - ~/unikuklatrix/nablarva/.dev/session/relay-X.ledger.md
  - ~/unikuklatrix/nablarva/.dev/session/relay-X0-carryover/STATUS.md
  - ~/unikuklatrix/nablarva/.dev/session/relay-X0-carryover/raw/decision.majkee.walkthrough-3.2026-11-22.md
  - ~/unikuklatrix/nablarva/.dev/session/relay-X0-carryover/raw/roster.2026-11-21.md
  - ~/unikuklatrix/nablarva/.dev/session/relay-X0-carryover/exp/
  - ~/reposoma/raw.guides/bus/res/file-poke.md
source_host: home / hruzam
---

# Clean-table entry — relay-X1-probes

Transfer pointer only. **The bed's STATUS owns the position** (one-authority rule). The bed was opened by Majkee on 2026-11-22
("open now on `home`") after he recorded GO on the handoff of the predecessor `relay-X0-carryover`.

## What a fresh seat must know before it acts

- **The pen is vacant, and it is not yours yet.** Majkee decided a fresh lead. A session takes the pen only on his word, written
  into a decision file in `relay-X1-probes/raw/`. Ask him first. Until then, read and propose.
- **Nothing is released.** The handoff's §6 is a menu of nineteen lines. Line 1, the opening, is given; lines 2–19 are not.
  Before asking for any of them, read back to him which rows he selects, which bed owns each U-case, the stop conditions and
  where the evidence goes.
- **The STATUS in the bed is an opening skeleton** written by the outgoing pen so that the open work has a router row. Rewrite
  it as your own once you hold the pen. **A RUNBOOK frame is already there**, written by the outgoing lead at Majkee's request;
  it is yours to change until you have read the plan back to him, and fixed after that.
- **What the stage is not** — handoff §0: it is not `relay-00-research`, it gives no verdict on the relay architecture and it
  qualifies no door. Every agent-operated tmux try is one explicit exception that returns to Majkee; the gate presumes none.
- **The party is host- and session-bound.** Home's tmux group `helloWorld`; the predecessor's roster is the starting list. Pane
  ids and thread ids go stale. Re-read them against live tmux before any poke. Decisions Majkee owes go through the exec desk
  (window `seniorDev`): write a sheet, poke the desk. Coordination pokes, push pokes included, are your own call — he said so on
  2026-11-22 and wants the run to go on without him until an approval, a gavel or a decision is really needed.
- **The predecessor is on call.** The session that wrote this card stays open in window `engineer`. Ask it by a file and one
  pointer line. Its context was compacted several times: where its memory and a file disagree, the file wins.
- **Private evidence is outside Git** on home: `~/.local/share/nablarva/custody/`; the relay ledger points at it. `.majkee/` and
  `.hlm/` are never read or listed.
- **Do not work alone.** The predecessor did nearly everything inline and paid in context and in stale sentences. Give log
  lines, exact-match edits and checks to `delta`, long reads and the stale-sentence sweep to `field`, a fresh-eyes check to
  `assay`. The communication protocol — file first, one labelled line, look first, fallback by the other door only after a
  definite failure — is a section of the RUNBOOK.
- **Hazards the predecessor paid for:** a word after `claude` is a prompt and starts an agent — help probes use `--help` flags
  only. A list of forbidden git verbs is read as "no git" — say what is allowed in the gates line. A POINT that asks for one word
  gets one word — ask for the table first.

## First tool shot

```sh
hostname -s; git -C ~/unikuklatrix/nablarva status --short; git -C ~/unikuklatrix/nablarva log --oneline -5
cat ~/unikuklatrix/nablarva/.dev/session/relay-X1-probes/STATUS.md
cat ~/unikuklatrix/nablarva/.dev/session/relay-X1-probes/RUNBOOK.md
cat ~/unikuklatrix/nablarva/.dev/session/relay-X0-carryover/raw/handoff.successor-stage.2026-11-22.md
```

## One lesson from the session that wrote this card

My probe table had seven rows, and none of them was the trial's own direction — Claude → Codex by tmux. A consult and two
counter-reads from the other vendor found that, and two sentences that contradicted my own files. Before a document asks Majkee
for a release, let another seat oppose it, and ask of every row whether its outcome would change a decision you can name.

## prompt-0

###### prompt

```text
You are the fresh lead of the session bed relay-X1-probes on the nablarva relay line. Start in ~/unikuklatrix/nablarva.
Read AGENTS.md and its read chain, then .dev/session/relay-X1-probes/STATUS.md, the RUNBOOK frame beside it, and the handoff they name, whole.
Resolve the host and the worktree first. You do not hold the pen until Majkee says so and it is recorded in the bed's raw/.
Nothing is released: before asking for any line of the handoff's release menu, read back to Majkee which rows he selects,
which bed owns each U-case, the stop conditions and where the evidence goes. His decisions go through the exec desk.
The predecessor bed relay-X0-carryover is closed and is read by path. Never read .majkee/ or .hlm/.
```
