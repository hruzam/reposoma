---
kind: cold-start-card
date: 2026-10-08
brand: claude
seat: trajectory
project: nablarva
projects: [nablarva, ia-sync, reposoma]
root: ~/unikuklatrix/nablarva
commit: 157baac (core)
task: tunnel IT support for nablarva-X1-architecture (call sign trajectory(support) / trajectory(it)) — diagnose, explain, repair the Claude↔Codex tunnel on request; mute on design, no bus turns, never STATUS
resume: cd ~/unikuklatrix/nablarva && claude --resume 319734ac-5de0-463b-8866-1b7eb079018c   # fallback: claude --agent trajectory + this card
model: opus
dedicated: trajectory
recommend: Read your own vault first (pointer 1) — T1–T14 are the whole story. You have no task until majkee relays one; X1 STATUS owns the position. Before any live check, verify the codex-cli version (157baac mentions 0.161 — L8 weather) and the X1 vault state.
runbook: ~/unikuklatrix/nablarva/.dev/session/nablarva-X1-architecture/RUNBOOK.md
pointers:
  - ~/unikuklatrix/nablarva/.dev/observations/nablarva-X1-architecture.trajectory.2026-10-08.md
  - ~/unikuklatrix/nablarva/.dev/observations/nablarva-X0-restarted.trajectory.2026-10-05.md
  - ~/unikuklatrix/nablarva/.dev/session/nablarva-X1-architecture/STATUS.md
  - ~/unikuklatrix/nablarva/.dev/session/nablarva-X1-architecture/tunnel-using-protocole.md
  - ~/unikuklatrix/nablarva/.dev/session/nablarva-X1-architecture/tunnel.preamble.md
  - ~/ia-sync/.dev/session/tunnel-03-feedback-upgrade/raw/field-feedback.nablarva-X0.trajectory.2026-10-07.md
  - ~/reposoma/raw.guides/tunnel/GUIDE.md
  - ~/reposoma/.majkee/journal/2026-10-07.md   # §1.1.4 "cartan tunnel reincarnation" — majkee's operator copy of my commands; guide wins on divergence
  - ~/ia-sync/zsh/ai/tunnel-codex.py
---

## prompt-0

###### prompt

```text
You are Trajectory, resumed as trajectory(support): tunnel IT support for nablarva-X1-architecture.
Re-resolve the host by fingerprint. Read nablarva AGENTS.md (its read order, not ia-sync's),
then your vault ~/unikuklatrix/nablarva/.dev/observations/nablarva-X1-architecture.trajectory.2026-10-08.md
(T12→; T1–T11 in the X0 file beside it), then X1 STATUS.md for the position. You are mute on design:
no bus turns, never STATUS, no tun turn verbs unless majkee asks for a check. Help arrives via majkee
or a note at .dev/session/nablarva-X1-architecture/raw/note.<seat>-to-trajectory.<date>.md; answers go
append-only into your vault. Repairs in ~/ia-sync only on majkee's word. Until he relays something,
you have no task — say you are oriented and wait.
```

## Where to log — two homes, two purposes

- **nablarva (live, for the team):** my vault, `.dev/observations/nablarva-X1-architecture.trajectory.2026-10-08.md`.
  - Append-only and never pruned (observations law). The next entry is **T18**.
  - Holds diagnoses, effective-policy readings, and STATUS-ready lines marked "for the carrier, verbatim".
  - The carrier's own defect log is hers. I read it and never write it; ask oraculum where it lives.
- **ia-sync (transport backlog, for the next tunnel upgrade):** `~/ia-sync/.dev/session/tunnel-03-feedback-upgrade/raw/`.
  - A seed bed: no RUNBOOK, STATUS or pulse row.
  - `field-feedback.nablarva-X0.trajectory.2026-10-07.md` = F1–F11.
  - New transport findings get added there as F12 onward, each pointing back to its T-entry. Point, never copy.
  - **Queued for it:** F12, whether `thread/resume` re-sends `skills_instructions` on every resume or only after a settings change (T13); F13, the preamble shipped as the hotfix for T13 (T14). Neither is written into the backlog yet.
- **Operator copy:** majkee keeps copies of my commands in `~/reposoma/.majkee/journal/2026-10-07.md` §1.1.4. It is his journal; I never edit it. If it diverges from the guide or my vault, the guide wins. Tell him when a command there has gone stale.

## State at handoff (2026-10-08)

- **Hotfix live:** ia-sync `17a00fe` `tun open --preamble <file|none>`, selftest 113/113. Guide chapter is reposoma `62db7e8` (`/guide tunnel preamble`).
- **Copied live by hand, three tunnel files only.** A full `deploy.sh` would also ship other seats' undeployed agents and hooks (`houston.md`, `oraculum.md`, `guard-destructive.sh`, `oraculum-bash-whitelist.sh`). That is majkee's deploy, still pending.
- **X1 vault was closed by majkee.** Reopen with `tn-on … --thread <id> --cwd … --preamble …/tunnel.preamble.md`; the full recipe is in T14. Live head is `01a118ff-674c-7680-9e57-67ca2f257323` (compacted in TUI 2026-10-08 18:01, id kept). `01a113e0` is retired; `01a113d8` (journal §1.1.4) is a dead zero-turn id. Run `tn-check --id <id>` before any bind (T17).
- **Policy at last reading:** `gpt-6-sol`/`medium`, `workspaceWrite`, network off, approvals on-request with reviewer `auto_review`. **Not yet verified on a tunnel turn (T11):** check the rollout's last `turn_context` after the first ask.

## Open verifications (in order) — superseded 2026-10-08 22:00: the live list is X1 `raw/pad.1-tunnel-support.md` (A–J); T15–T17 in the vault

1. The first X1 turn with the preamble: stderr shows `prepended`, and a short turn's `ctx` delta is a few kB (T14).
2. That same turn's `turn_context.approvals_reviewer` = `auto_review` (T11).
3. codex-cli L8 on whatever is current (0.160.1 → 0.161?): selftest plus one live ask.

## Uncommitted debts (not mine to commit in nablarva — the carrier's bookkeeping)

- `.dev/observations/nablarva-X1-architecture.trajectory.2026-10-08.md` (T12–T14 appended)
- `.dev/session/nablarva-X1-architecture/tunnel.preamble.md`
- Pending decision: where the canonical nablarva preamble wording lives (T14 open item; the guide chapter describes the layers).

## Lessons

- **Measure before arguing.** The rollout jsonl is the only true account of what entered the head's context. It settled the "resume burns context" question (T12/T13).
- **No `<…>` placeholders in paste-ready lines** (zsh redirect, T8).
- **`cp` is aliased to ask before overwriting**; use `/usr/bin/cp` in Bash calls.
- **On 0.160.x+, after leaving the TUI, wait for the writer-lock to clear** before `tun resume` (T10).
