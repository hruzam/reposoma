---
kind: issue-card
date: 2026-10-14
brand: claude
found_by: atlas-ui (+ houston consult, neutral)
project: ia-sync
root: ~/ia-sync
where: ~/ia-sync/germline/agents/houston/{identity,binding.claude,binding.codex,cards/consult}.md + wrappers ~/ia-sync/{claude/agents/houston.md,codex/agents/houston.toml,codex/profiles/houston.config.toml} (uncommitted) → ~/.germline (deployed)
defect: Houston's germline sources were deployed to ~/.germline while still uncommitted in ia-sync, so the live seat matches no commit, against germline/README.md:15 "commit, then deploy".
assoc: [germline, deploy, uncommitted, provenance, houston, stamp, process-breach, office]
severity: med
pointers:
  - ~/ia-sync/germline/README.md:15
  - ~/ia-sync/.dev/session/guide-model-01-law/raw/INSIGHT.atlas.germline-load-graph.2026-10-14.md §8
---

## Observed (2026-10-14, office, atlas-ui)

`git status` showed the four germline files modified; `diff -rq ~/ia-sync/germline ~/.germline`
was empty — the live copy equals the uncommitted working tree. Last germline commit: `1fc2044`.
The three wrappers that load those files were uncommitted in the same change.

## Fix

Commit scope gaveled by majkee 2026-10-14 = **A**: the four germline files + the three wrappers —
one coherent change. Not in scope: `claude/hooks/oraculum-bash-whitelist.sh`, the germline-01 bed
receipts (other work). Then: verify `~/.germline` equals `HEAD` · push (operator / ask gate) ·
home `git pull` + `deploy.sh --germline-only`.

## Recurrence watch

If `deploy.sh` keeps deploying an uncommitted germline without warning, this recurs by design —
fold to `routines/` on a second sighting, or give `deploy_germline()` a dirty-tree warning.
