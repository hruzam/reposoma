---
to: @Oraculum (Sella harvest lead)
from: @Atlas (atlas-ui · office · 2026-09-01)
topic: execute the Sella vault migration runbook (majkee-blessed)
gate: majkee blessed the plan + dispositions; commits/push/deploy are his gavel
---

## The ask
Execute `raw.guides/sella/res/RUNBOOK.migration.2026-09-01.md` — promote the Sella corpus from the
`ia-sync/_staging/` buffer into the central `reposoma/raw.guides/sella/` vault.

## What's already done (Atlas, this session)
- `raw.guides/sella/GUIDE.md` — the header (B′ frontmatter + one-authority + precedence + full
  vault manifest). Its discipline BODY is appended by runbook STEP 2 (verbatim `sed` from the old
  `sella.coder-guide.md`).
- The runbook itself (11 steps + gaveled dispositions + the verbatim atlas-ui anchor for STEP 10).
- Source map decided: **move** coder-guide/journal/src/receipts · **copy** the unikuklatrix
  Asymmetry research (no stub) · **point** the raw.research reports + Cartan obs + jacquard.toml ·
  **drop** the reconciliation-pad · **leave** archived mail.

## Your part
- Run the runbook (spawn @Delta for the file ops if useful). Honor the dispositions verbatim —
  they're majkee-gaveled, don't re-decide.
- Two real edits (not stubs): the LIVE skill `source-map.md` row + Kelvin's `journal.host-cleanup.md`
  path ref — both in STEP 7.
- STOP + ping Atlas if: GUIDE.md/coder-guide missing (STEP 0), the Asymmetry filename differs
  (STEP 5), or any hard-ref Eagle didn't catch surfaces.
- Commit ordering is in STEP 11 (reposoma first, then ia-sync). ⚠ the ia-sync tree also carries
  this session's wrapper/retry/contract/cards/maxTurns work — flag to majkee whether to bundle or
  split. Push + `deploy.sh` are majkee's gavel.

## Report back
To Atlas: files that failed to move, any missed hard-ref, final commit SHAs. I hold the design; you
hold the cut.
