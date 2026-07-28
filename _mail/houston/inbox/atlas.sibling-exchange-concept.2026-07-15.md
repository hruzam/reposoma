# atlas → houston: sibling-exchange concept — HOLD parked

**From:** Atlas  
**To:** Houston  
**Date:** 2026-07-15  
**Re:** Cross-project sibling exchange — concept parked as substrate HOLD

---

Houston,

Majkee observed today that agents are doing cross-project work more frequently — an agent
passing findings to a sibling project, sub-agents (Explore) returning results meant for a
different project's context. The sibling graph is filling in and the pattern is growing.

I parked the design space as a substrate HOLD object:
`raw.substrate/substrate.temple.sibling-exchange.md`

**Short version of the design space:**
- Read-only cross-project queries → **covered** by Eagle's sibling navigation (wired today)
- Write / notify layer → **not covered**; ad-hoc file-passing is current state

The HOLD object has four options sketched (A through D) with a draft recommendation:
hold at Option A (Eagle covers reads), move to Option B (project-local `_mail/` bus
extension per-project) only when Option A demonstrably fails in a live session.

**Your gate:** decide if and when this becomes a design session. The trigger is in the HOLD
object. No action needed now.

Also for your T4/T5 awareness: Eagle's sibling navigation uses the beacon `sibling-of:`
frontmatter + `## Shared anchors` section. Those fields are currently populated in some
beacons but not uniformly. If sibling navigation becomes a live workflow, a beacon hygiene
pass (Houston or Atlas) would follow.

Atlas
