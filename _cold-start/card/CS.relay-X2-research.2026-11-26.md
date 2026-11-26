---
kind: cold-start-card
date: 2026-11-26
brand: claude
seat: flight
project: nablarva
root: ~/unikuklatrix/nablarva
commit: 2d3ca91 (core)
task: Take relay-X2-research as its fresh lead — the L14 research gate, one ranked verdict (REINVENT, ADOPT or REFUSE) on the relay program. Opened by Majkee; nothing researched yet.
resume: cd ~/unikuklatrix/nablarva && claude --agent flight   # in tmux window `lead`; model as Majkee sets it (the predecessor ran fable, effort high); then activate the cold-start-card skill on this card
model: fable
dedicated: flight
recommend: Read the RUNBOOK whole, then the process record and the harvest, before the first poke. The first thing that needs Majkee is the blind brief — bring it early, it runs in parallel.
runbook: ~/unikuklatrix/nablarva/.dev/session/relay-X2-research/RUNBOOK.md
pointers:
  - ~/unikuklatrix/nablarva/.dev/session/relay-X2-research/STATUS.md
  - ~/unikuklatrix/nablarva/.dev/session/relay-X2-research/raw/decision.majkee.open.2026-11-26.md
  - ~/unikuklatrix/nablarva/.dev/session/relay-X1-probes/raw/handoff.successor-stage.2026-11-26.md
  - ~/unikuklatrix/nablarva/.dev/observations/relay-X1-probes.flight.2026-11-26.md
  - ~/unikuklatrix/nablarva/.dev/observations/harvest.2026-11-26.auditor.md
  - ~/unikuklatrix/nablarva/.dev/session/relay-X.ledger.md
  - ~/unikuklatrix/nablarva/.dev/session/flag.md
  - ~/unikuklatrix/nablarva/AGENTS.md
  - ~/reposoma/raw.guides/runbook/res/research.md
  - ~/reposoma/raw.guides/bus/res/file-poke.md
source_host: home / hruzam
---

# Clean-table entry — relay-X2-research

Transfer pointer only. **The bed's STATUS owns the position** (one-authority rule); this card carries no next action
of its own. Majkee opened the bed on 2026-11-26 and asked the closing head of `relay-X1-probes` to write its RUNBOOK
and this card.

## What a fresh seat must know before it acts

- **The STATUS in the bed is an authoring skeleton.** Its writer line says so. Rewrite it as your own in your first
  turn; the RUNBOOK is fixed from the moment you have read it.
- **Why this seat.** The work is one head coordinating a research child and two resident seats of the other vendor
  toward one written verdict — the shape the predecessor ran. The alternative, if Majkee wants a strategist to write
  the verdict: Oraculum as head, same RUNBOOK, only `participant_1` changes. He chooses at launch.
- **The harvest is pointed at by hand:** `~/unikuklatrix/nablarva/.dev/observations/harvest.2026-11-26.auditor.md`.
  It was written by the auditor, on Majkee's designation, because the closing head's Agol child was stopped by the
  model's safeguards before it produced anything. Its four candidate rows (U20 to U23) are already in the RUNBOOK. If
  a child of yours stops that way, tell Majkee and do not redo its work yourself; it may need another model.
- **Three lessons of the predecessor, each paid for more than once:**
  1. Look before you state a present state, or say that you have not looked.
  2. Every document passes the auditor before Majkee reads it. It answered REVISE on every one and was right.
  3. Ask Majkee only for the gate word, the brief, a release or a lock. Ask seats for facts.
- **The blind brief is the first thing that needs him.** It exists since 2026-09-30, addressed from him to the other
  vendor line; whether it was ever sent is recorded as unknown. The original stays untouched; you make a send copy
  with corrected facts only. You do not read the answer before your own verdict is committed.
- **Team, as Majkee named it on 2026-11-26** — re-read panes and thread ids from live tmux before any poke:
  auditor (window `auditor`, pane `%66`, codex thread `01a1ffdf-793f-76d2-8497-3f68f84a34a7`) · controller (window
  `supervisor-relay`, pane `%59`, thread `01a1ff5e-6fa1-75e1-88f9-33b8c7fe6318`) · exec desk (window `exec`, pane
  `%68`, thread `01a1fefc-0356-7ea1-860c-783a66a91211`). Not yours: `seniorDev`, `myShell`, `eSharp`,
  `supervisorCli`. Free windows `spare-codex` and `spare-claude` — starting anything in them needs his word.
- **Reaching him without a poke:** `~/.cache/nablarva/relay-x1-doorbell/notice.sh "<text>" [seconds]` shows one line
  in the status line of every tmux client and writes into no pane. Use it only when something needs him.
- **A poke is always paired with a finite watch on the RETURN file.** In samples, `codex queue` accepted a message
  that arrived two days later. The carrier's exit code is not delivery.
- **The predecessor is not on call** once the window `lead` is reused. Where a memory and a file disagree, the file
  wins. Its bed, `relay-X1-probes`, is closed and read by path.
- **Do not work alone.** The dated research pass belongs to a research child; reading across the sibling beds to a
  reader child; the check of every outgoing document to the auditor.

## Hazards the predecessor paid for

- An unscoped `git status` in `~/reposoma` lists `.majkee/`. Git commands there and in the project are path-scoped.
- `CACHE.md` and `CACHE.*.md` in the beds are Majkee's and are tracked: a search over tracked files prints them.
  Exclude them (`':!*CACHE*.md'`).
- A session forked into the background cannot write into the shared checkout unless the project's settings carry
  `worktree.bgIsolation = none`. An unset `TMUX_PANE` in such a shell says nothing about whether a pane shows you.
- Several sessions commit in this checkout: commit path-scoped; a plain push carries everyone's local commits.
- A word after `claude` is a prompt and starts an agent — help probes use `--help` only.

## First tool shot

```sh
hostname -s; git -C ~/unikuklatrix/nablarva log --oneline -5 -- .dev/session/relay-X2-research/
cat ~/unikuklatrix/nablarva/.dev/session/relay-X2-research/STATUS.md
cat ~/unikuklatrix/nablarva/.dev/session/relay-X2-research/RUNBOOK.md
cat ~/unikuklatrix/nablarva/.dev/observations/relay-X1-probes.flight.2026-11-26.md ~/unikuklatrix/nablarva/.dev/observations/harvest.2026-11-26.auditor.md
```
