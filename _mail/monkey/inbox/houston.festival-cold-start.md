# Festival — cold-start handoff (majkee) · Houston 2026-07-21

**State:** core committed on `hotfix/festival-kasa` (6 files), prod-deploy pending.
**On deploy result → tell Houston** (green/snag); it closes flag/pulse/handoff/journal in one pass.

## Stream A — "detaily" price toggle (small, low-risk)
```
claude --agent flight
```
> Read `.dev/session/festival-prices/extension-detaily.task.md`. Confirm fallback-only vs all-cells with me, then build → local test → hand back for cherry-pick.

## Stream B — Task 3 order STORNO → festival stock (core order model, HIGH care)
```
claude --agent trajectory
```
> Read `.dev/session/festival-storno/task.md`. Recon done. Confirm the verify-items, build strictly gated on `shipping_code='festival'` (eshop restock unchanged), run the eshop-regression test → @Assay → hand back for cherry-pick.

**Topology:** build → local test → REPORT → @Flight tune → escalate @Houston if unfixable.
Each card is self-contained (who/what/files/test/escalation). Run either/both fresh.
