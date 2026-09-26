---
kind: cold-start-card
date: 2026-09-26
brand: claude
seat: trajectory
project: ham
projects: [ham, ham.devenv, reposoma, ia-sync]
root: ~/www/psdvs/ham
commit: 47b5591 (local-dev) · ham.devenv 778c814 (core) · reposoma fb0cb15 (core)
task: HAM (Jan Kubaty's humanitarian-aid system) bedded as a temple project — fork clone, ham.devenv twin, local D1 + synthetic seed, Rosetta guide; session localbed-01-fullsim open (full-site seed → majkee's 25-page walkthrough)
resume: cd ~/reposoma && claude --resume 0e75bace-4ba4-423d-b67e-a89c780081cc   # SESSION ID 0e75bace-4ba4-423d-b67e-a89c780081cc · transcript lives under the reposoma project slug on HOME (see body §Resume). Fallback on any host: cd ~/www/psdvs/ham && claude --agent flight → read STATUS
model: sonnet
dedicated: flight
recommend: STATUS owns the position — it says the bed was transferred to office at L5 but nothing has come back (ham.devenv 0/0 since 2026-09-20). Resolve WHICH HOST first, then follow OFFICE-BRIEF.md; do not re-seed on home while a dev server runs.
runbook: ~/www/psdvs/ham/.dev/session/localbed-01-fullsim/RUNBOOK.md
pointers:
  - ~/www/psdvs/ham/.dev/session/localbed-01-fullsim/STATUS.md
  - ~/www/psdvs/ham/.dev/session/localbed-01-fullsim/OFFICE-BRIEF.md
  - ~/.claude/projects/-home-hruzam-reposoma/0e75bace-4ba4-423d-b67e-a89c780081cc.jsonl
  - ~/www/psdvs/ham/.dev/flag.md
  - ~/www/psdvs/ham/.dev/pulse.md
  - ~/www/psdvs/ham/.dev/guides/rosetta.laravel-to-ham.md
  - ~/www/psdvs/ham/.dev/guides/codex-seat.brief.md
  - ~/www/psdvs/ham.devenv/SYNC_DISCIPLINE.md
  - ~/reposoma/registry/ham.md
---

# ham — bed made, session in transit

## Resume this exact session
- **Session ID:** `0e75bace-4ba4-423d-b67e-a89c780081cc` (Trajectory seat, Fable 5.1, host home,
  2026-09-19 → 09-26). Full context of the bootstrap, the gentle-commit protocol, the Codex brief.
- **On home:** `cd ~/reposoma && claude --resume 0e75bace-4ba4-423d-b67e-a89c780081cc`
  — the transcript is keyed to the cwd it was opened in (`~/reposoma`), not to `~/www/psdvs/ham`.
- **On office:** the transcript is not there. Hand-carry it first (same pattern as CS.tunnel-upgrade
  2026-09-21: rsync over tailscale, checksum-verified) to
  `~/.claude/projects/-home-hruzam-reposoma/0e75bace-4ba4-423d-b67e-a89c780081cc.jsonl`,
  then the same command. Without the carry: fresh `claude --agent flight` in `~/www/psdvs/ham`
  + this card's pointers is sufficient — nothing lives only in the transcript.

## Pending, in order
1. Resolve the host: STATUS says "TRANSFERRING TO OFFICE", pickup line L5. Office has pushed
   nothing to `ham.devenv` since. Either office continues (OFFICE-BRIEF §setup, then
   `db-local.sh reset`, then L5), or home resumes — then rewrite STATUS `host:` first.
2. L5 → L8 as the RUNBOOK lays them out (probe · Assay verify · author `pad.1-walkthrough.md` ·
   majkee sits it). Gate closes on majkee's marks only.
3. After the gate: Codex seat is deliberately unbuilt — built only from a Codex window
   (`codex-seat.brief.md`). Not before.

## State pointers
- Position: STATUS (sole authority). Seeds: `ham/.dev/seed/01…06-*.local.sql` — written,
  validated, NOT yet loaded (`db-local.sh reset` blocked by a live dev server on home).
- Test codes and `ACCESS_CODE` live in STATUS `test_codes:` and `ham/.dev.vars` (git-excluded).
- Registry: `registry/ham.md` deposited, `psdvsSys` erased (gavel 2026-09-19); project map
  deployed on home, verified. Office project map: not yet — deploy `ia-sync` there.
- Fork = mirror of `couleen/…` at 47b5591; no upstream remote by decision (flag M-01).

## First step
Open STATUS, read `host:` and `transfer:`. Decide the host with majkee. Nothing else until then.

## One lesson
Every repo here has a second writer somewhere — Jan on the code, `/model` on the live
settings.json, office on the bed. Fetch and diff before every push or deploy; the near-miss
this session (deploy.sh would have reverted a same-day live edit) was caught only by a
read-only preflight.

## Hygiene debts
- `ham.devenv/dev/session/localbed-01-fullsim/res/PAD-00.host-deploy.2026-09-20.md` is
  untracked and exists only on the devenv side — decide: commit, move into the app bed, or drop.
- STATUS `gate:` text was edited (home → office host). Runbook law says a changed gate opens a
  numbered sibling; gavel whether this counts.
- `ham.devenv/sync.deny` misses plain `*.sql` (only `*.dump.sql`) — one line to add.
- On office, `~/www/psdvs/` is still the old PSDVS repo at top level — repeat the `v0/` move
  before cloning `ham` beside it.
- Parked designs (not debts): sync/deploy simplification (graph first), wrapper-agent harness idea.
