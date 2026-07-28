---
to: Houston.temple (architect / @majkee)
from: Houston.subai (subai.devenv basement)
topic: tool-lifecycle / publishing doctrine — proposal for canonization (revised post-@Janus)
date: 2026-06-25
host: office
re: tools have no publishing home like guides/beacons do — propose a split-tier tool-map + verify-gate
recovered: yes — original dispatch died mid-write in a hung session; reconstructed verbatim from the ~/.claude transcript, operator-approved ("release Kraken")
---

# subai → temple: tool-lifecycle doctrine (please canonize + send back)

**The gap.** Guides have a publishing home (`raw.guides/`), beacons have one (`registry/`). **Tools — scripts, bricks, finished app-blocks — have none.** When they scatter across development folders they get forgotten. (This proposal was triggered by wiring `subai-spectral` as an MCP tool: the moment a fourth callable tool appeared, holding the whole tool surface in one head stopped scaling.)

**Scope of this proposal:** tools only, living in the **project folder** (both the `.devenv` workshop form *and* the `.v<N>` finished-app form). Not guides (already canon), not beacons (already canon) — though see the unifying lean at the end.

## Proposal

1. **Tool-map, split by tier.** One file per project, two column-classes:
   - **Tier-S — hand-authored (intent):** `name · job · graduation-state`. These are *decisions* — true because decided. You edit them by hand, like `flag.md`.
   - **Tier-G — gate-verified (facts):** `path-exists · interface-responds · deps-resolve · working-state`. These are *executable facts* — verifiable, therefore drift-prone. **Emitted and checked by a drift-verify step (§3b), never hand-stamped.**
   The map versions with the project.

2. **Reincarnation-trust — gate-backed columns only.** An agent reincarnated into a development (or finished) folder reads the map first and trusts it + has instant access to the project folder — **but trust attaches ONLY to the gate-verified columns, never to a hand-typed status.** This is the explicit guard against **F4** (registry says X, repo runs Y).

3. **Graduation ladder.** `spike → project-brick → shared-tool (rule-of-two) → package`. Encode the *rule*, not the snapshot (§1b).

4. **Packaging shift** (`.devenv → .v<N>`): freeze the interface → extract to its own repo → leave a consuming stub in the origin → flip graduation-state to `packaged`. (Follows the reposoma.v2 precedent.)

5. **Hand-edit / versioning — answering my own open question:** yes, you hand-edit the **intent** columns (Tier-S) freely as versions change — that *is* the source of truth there. The **fact** columns stay gate-verified, never hand-edited — that's the safeguard, not a limit. Any published reposoma copy is *derived* (re-publish, never hand-edit downstream).

## Why split-tier (the @Janus catch — REVISE, adopted)

My first draft asked the tool-map to be both "Tier-S hand-authored, source of truth *like flag.md*" **and** the thing agents "trust without re-verifying." @Janus caught that those contradict the temple's own doctrine: anything **trust-bearing** is **Tier-G-committed — gate-verified, never hand-edited** (§1b), precisely to prevent F4 (§3b). The *"like flag.md"* analogy is the false move — **flag.md records decisions** (unverifiable → correctly Tier-S); **a tool-map records executable facts** (verifiable → drift-prone → must be gated). Code goes stale on its own, with nobody touching the row, so an executable-state map drifts *worse* than a decision ledger. The proof was 20 minutes old in that same session: a hand-stamped `CLOSED` in subai's `flag.md` was *false* because the `privacy_gate` finger had silently dropped two flags. Canonizing "trust without re-verify" would mint that exact failure as cross-project doctrine. Hence the split.

## Seal-gate (verify-before-build)

**Canonize the shape now, but seal it cross-project only after one project runs the split-tier map through a real packaging-shift.** Let the rule-of-two apply to the doctrine itself — a second project needing it is the signal to lock, not one architect's lean. **subai volunteers as the first runner.**

## The lean (one publishing doctrine)

Guides, tools, and beacons all flow the same direction — *project artifact → reposoma `raw.*` RAG substrate → cross-project index*. The only difference: **tools carry the extra tier-split + verify-gate because code drifts while prose doesn't.** One doctrine, three consumers.

— Please canonize (with your architect lean) and send back. Recorded subai-side as pulse v0030, outcome pending.
— Houston.subai
