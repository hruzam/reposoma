---
kind: cold-start-card
date: 2026-11-26
brand: claude
seat: trajectory
project: ia-sync
root: ~/ia-sync
commit: d9d43bb (main) — 006 intake committed in 5ba9eb0; BRIEF roles/gates section uncommitted on home at card time
task: Lead A1 group 006-supervisor — build one vendor-invariant `supervisor` seat (persistent, attachable, full-permission open-bash, reads as the system's controller), callable as Claude agent and as Codex agent.
resume: tmux new -s a1-supervisor -c ~/ia-sync 'claude --agent atlas-ui' → paste prompt-0
model: opus
dedicated: atlas-ui (Claude) as head and STATUS pen; Cartan (Codex) as countersignature, qualified opposer and Codex-half author
recommend: Authority before equipment. Full bash is five lines of launcher; what supervisor may decide is the real build. Make Cartan's reply files the gate, not your confidence.
runbook: ~/ia-sync/.dev/session/germline-A1-vi-agents/RUNBOOK.md
pointers:
  - ~/ia-sync/.dev/session/germline-A1-vi-agents/STATUS.md
  - ~/ia-sync/.dev/session/germline-A1-vi-agents/RUNBOOK.md (§ 006-supervisor + five-phase workflow)
  - ~/ia-sync/.dev/session/germline-A1-vi-agents/raw/006-supervisor/BRIEF.md
  - ~/ia-sync/.dev/session/germline-A1-vi-agents/CACHE.md
  - ~/ia-sync/HANDSHAKE.md
host: home
leave: for more readers — atlas-ui drains it after Cartan has also read it
---

This card points to the work and doesn't direct it. The A1 bed owns the position: STATUS for
where things stand, the RUNBOOK 006 entry for scope, and BRIEF.md for the name, constraints,
wiring map, roles, gates and exchange rule. Nothing below competes with them.

## What the session settled (2026-11-23 … 26, Trajectory with Majkee)

- **The bed:** A1 `germline-A1-vi-agents` is the build line for this group. Its purpose is
  vendor-invariant agent production. A0 is intake history, A2 is project preparation, and
  A3 owns the controller vocabulary.
- **The name:** `supervisor`. Two blind Claude reads (Haiku, Sonnet) and a Codex CHALLENGE (Cartan)
  all chose it. `supervisorcli` was rejected because a CLI names a one-shot client, and that is
  the launcher, not the seat. The command entry is `ai-supervisor`, following the `ai-<seat>`
  convention. Evidence table: BRIEF.md.
- **The roles:** atlas-ui leads, and Cartan countersigns, opposes and authors the Codex half on
  his own turf. Majkee does git and deploy.
- **Office and home are 1:1.** Both were at the same HEAD with clean A1 and Oraculum paths when
  checked on 2026-11-24.

## Before first use

- **Commit the roles section.** The 006 RUNBOOK entry and BRIEF were committed in `5ba9eb0`.
  The BRIEF's later "Sitting roles and gates" section is still uncommitted on home. Commit and
  push it before any office-side reader, including Cartan, starts. This card is also invisible
  across machines until reposoma is committed.
- **Epoch's input already exists for P2.** Epoch (Claude, home) wrote
  `EPOCH.role-and-inputs.2026-11-25.md` against this BRIEF (commit `fad1c42`, under
  `raw/007-researcher/`). It covers the researcher's role toward supervisor and version facts
  about attaching and full-permission equipment. All of them are stale until re-fetched. At card
  time an uncommitted move was relocating it to `raw/004-epoch/`. That move belongs to another
  seat, so read it from wherever it lands, and don't move it yourself.

## Session advice (one lesson)

The name is the easy part. Cartan's referent rule holds: the seat is the supervisor, and the
session that keeps it alive is plumbing. Write it that way in both bindings, or readers will
end up with two supervisors.

## Hygiene

- Do not fix the stale relay-room path in `HANDSHAKE.md` from inside this group. Name it to
  Majkee; it's a separate edit.
- Before commit, check `zsh/scheduled/harness-check.zsh` and `.dev/session/helper-utils-00-tmux/`
  on home. They were unrelated dirty paths at card time, so don't sweep them into a 006 commit.

## prompt-0

###### prompt

```text
You are atlas-ui (Claude), Majkee-manned head of A1 group 006-supervisor in
/home/hruzam/ia-sync/.dev/session/germline-A1-vi-agents/. Majkee selects 006 for this
sitting. 002-builder stays intact and unstarted. You take the A1 STATUS pen from Cartan
through this explicit handover, and you record that in STATUS at entry, together with the
stale-005 correction in BRIEF.md.

Read in this order: ~/ia-sync/AGENTS.md → SYNC_DISCIPLINE.md → HANDSHAKE.md. Resolve the
host through machines.json. Mark the A1 bed with rb-mark and unmark it only by that exact id.
Then read the bed's STATUS.md → RUNBOOK.md (five-phase workflow + § 006-supervisor) →
raw/006-supervisor/BRIEF.md → CACHE.md. Inherit only what is relevant and verify any
decisive cached claims.

BRIEF.md holds the name, the six constraints, the wiring map, the roles, the exchange rule
and the three CHALLENGE gates. Follow it, and don't restate it elsewhere. Points that are
easy to miss:
- codex/ and binding.codex.md belong to Cartan. Send him a RETURN brief, and don't edit them.
- Brief files go in raw/006-supervisor/exchange/. The pane poke only rings the bell, and
  his reply file is the receipt.
- No full-permission launcher exists before Majkee accepts the P3 authority contract.
- No control/ctrl/controller root anywhere. A3 owns it.
- You don't commit, push or run deploy.sh. Majkee does those or releases @Delta to do them.

Work phase by phase: P1 → CHALLENGE 1 → P2 (only for open capability questions) → P3 →
CHALLENGE 2 → stop for Majkee → P4 → P5 cross-audit (CHALLENGE 3). Return compact phase
evidence under raw/006-supervisor/. Update STATUS at each sitting boundary, and stop at
every authority or architecture choice. When you have consumed this card and Cartan has
read it, move it from card/ to archive/.
```
