---
kind: cold-start-card
date: 2026-09-06
brand: codex
seat: astrobley
project: ia-sync
projects: [ia-sync, reposoma]
root: ~/ia-sync
commit: 0f52f56 (main)
task: Recover the independent Astrobley-posture window after its cycle 24 RETURN while cartan-csharp retains verification and state authority.
resume: codex resume 01a076b1-1778-7f03-9706-d351cd094dea
model: gpt-5.6-sol
dedicated: astrobley
recommend: Resume this exact thread, reassert the operator-designated Astrobley posture, and read the live STATUS before any write.
runbook: ~/ia-sync/.dev/session/runbook-upgrade/RUNBOOK.md
pointers:
  - ~/ia-sync/.dev/session/runbook-upgrade/STATUS.md
  - ~/ia-sync/.dev/session/runbook-upgrade/_bus/24.cartan-csharp.point.md
  - ~/ia-sync/.dev/session/runbook-upgrade/_bus/24.astrobley.return.md
  - ~/ia-sync/.dev/session/codex-identity-resolution/raw/draft.codex-session-identity-resolution.2026-09-06.md
session_id: 01a076b1-1778-7f03-9706-d351cd094dea
rollout: ~/.codex/sessions/2026/09/06/rollout-2026-09-06T14-28-32-01a076b1-1778-7f03-9706-d351cd094dea.jsonl
cli_version: codex-cli 0.153.4
effort: high
worktree: Dirty with an empty index; concurrent Cartan, Trajectory, launcher, journal, pulse, and machine-config work is protected.
authority: This window is operator-appointed Astrobley. It may author only an Astrobley RETURN explicitly named by a new POINT. Cartan owns VERDICT and STATUS.
---

# Astrobley recovery — runbook upgrade

## Read first

1. Read `~/ia-sync/.dev/session/runbook-upgrade/STATUS.md` completely. It is the sole live doing-state and may have advanced after this card was written.
2. Read `~/ia-sync/.dev/session/runbook-upgrade/_bus/24.cartan-csharp.point.md` and `~/ia-sync/.dev/session/runbook-upgrade/_bus/24.astrobley.return.md` as one exchange.
3. Consult `~/ia-sync/.dev/session/runbook-upgrade/RUNBOOK.md` only for the protocol and ownership rules needed by the live STATUS.
4. Read the identity-resolution raw draft only if the session posture or recovery mechanism itself is under review.

## Observed handoff state

- The operator designated this separate Codex window as the Astrobley posture. It was not launched from an `astrobley` CLI profile, and it must not replace itself with a spawned Astrobley subagent.
- POINT 24 has SHA-256 `4573ed8c5551320528ecf4d0b7ec1d155bbdd2fc8b2ea356706581e6c5115a88`.
- This window directly authored only `24.astrobley.return.md`; its SHA-256 is `304dcf8fdb8bad34daa891ceb730c2ca3ff0c61a56a4c6b266b47e4a2fa55e26`.
- RETURN 24 declares a 119-line, 5,864-byte candidate with SHA-256 `7627dc2e602e5dbcf9f039234f433b0d7d5fbb1f7f429f3acda2a769388cf41c`.
- The separate original Cartan cSharp thread observed the RETURN during shutdown preparation but deliberately did not verify it. Its live STATUS at 2026-09-06 15:28 CEST says cycle 24 awaits that original head after restart.
- This Astrobley window wrote no VERDICT or STATUS and made no canon, client, deployment, or Git change.
- The identity-resolution raw draft exists at its pointer with SHA-256 `4b6c092721d863cf569be3c3eb698841ad78a2f350390db56eda476658122a96`. It is protected draft material, not deployed identity configuration.

## First safe probe

Run this read-only probe after re-entry, then follow the live STATUS rather than this snapshot:

```bash
cd ~/ia-sync
sha256sum \
  .dev/session/runbook-upgrade/_bus/24.cartan-csharp.point.md \
  .dev/session/runbook-upgrade/_bus/24.astrobley.return.md
sed -n '1,180p' .dev/session/runbook-upgrade/STATUS.md
git status --short --branch
```

Expected hashes are the POINT and RETURN hashes recorded above. A mismatch is evidence of a changed frame; inspect it and do not reconstruct or overwrite either artifact.

## Authority and recovery gates

- Cartan cSharp alone independently verifies RETURN 24 and writes any VERDICT 24 or STATUS transition.
- Majkee alone relays between the separate windows and holds the canon gavel.
- Resume this exact session ID. Do not use `--last`, which could select Cartan or another same-repository session.
- If exact resume fails, start a fresh Codex session rooted at `~/ia-sync`, explicitly appoint it as the recovery Astrobley posture, and make this card its first read.
- Do not commit, stage, stash, reset, deploy, or clean the dirty tree as part of recovery.

Once the exact thread or a deliberately appointed recovery thread has read the live STATUS and verified the two hashes, archive this card under `~/reposoma/_cold-start/archive/`. The card grants no work beyond the currently live relay.
