---
kind: issue-card
date: 2026-10-14
brand: claude
found_by: atlas-ui (+ houston consult, neutral)
project: ia-sync
root: ~/ia-sync
where: ~/reposoma/.germline/{agents/houston/,tunnel/tunnel.preamble.md,README.md:14} · ~/ia-sync/journal.host-cleanup.md:22-30 · ~/reposoma/raw.guides/germline-forge/GUIDE.md
defect: The germline-01 migration left loose ends — majkee's neutral tunnel preamble source sits in reposoma's project layer instead of ia-sync/germline, stale pre-migration Houston copies remain there, and the journal and germline-forge still describe the symlink era.
assoc: [germline, migration-tail, stale-doc, misplaced-source, reposoma, journal, germline-forge, tunnel-preamble, office]
severity: low
pointers:
  - ~/ia-sync/.dev/session/guide-model-01-law/raw/INSIGHT.atlas.germline-load-graph.2026-10-14.md §8
  - ~/ia-sync/.dev/session/germline-01-builds-and-deploy/raw/report.codex-side.cartan.2026-10-13.md:9
---

## Observed (2026-10-14, office, atlas-ui)

- `~/.germline` is a REAL dir, byte-identical to `~/ia-sync/germline` — office migration is done;
  the journal still says "STILL the symlink … OPEN".
- `~/reposoma/.germline/` is reposoma's legitimate project layer (AGENTS.md §~/.germline) but holds
  pre-migration Houston copies (identity 0be9958a vs live 6abf41fe · binding.claude 80c9168c vs
  9a3f17c0 · consult fbc11800 vs 46dcd163) and a README:14 that still says symlink.
- `tunnel/tunnel.preamble.md` (written 2026-10-13 22:06, untracked in reposoma) is majkee's
  **neutral source** — belongs in `~/ia-sync/germline/tunnel/`, deployed by `deploy.sh`. Nothing
  live reads the reposoma copy: tunnel threads store their own `--preamble` path (tunnel-03 points
  at the nablarva bed copy).
- germline-forge GUIDE (DRAFT, verified 2026-10-07) describes the pre-10-10 symlink + render model.

## Fix — scope: our own loose ends only (majkee 2026-10-14)

1. Copy preamble → `~/ia-sync/germline/tunnel/tunnel.preamble.md` (byte-equal).
2. Journal: office migration done (verified), home pending.
3. germline-forge: staleness banner (superseded by germline-01 + the 2026-10-10 runtime-load fold).
4. List for removal: `~/reposoma/.germline/agents/houston/**`, README:14 line.
5. Operator: `deploy.sh --germline-only` → verify `~/.germline/tunnel/` → delete the reposoma
   copies → commit reposoma. Optional: new tunnel opens point at `~/.germline/tunnel/…`.

Home host unchecked.
