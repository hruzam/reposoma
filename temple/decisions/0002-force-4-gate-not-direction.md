# 0002 — Force 4 is the gate, not the direction

`status: LOCKED 2026-06-17 (gaveled by majkee)`
`shape: ADR — context · decision · consequences · what-an-agent-does-differently`
`extends: Force 4 of doctrine.md · challenged by @Janus before lock (Force 6)`
`relates: 0001-sovereign-build (Force 3 boundary) · the triangulation that surfaced it`

## Context
The blind triangulation (R1/R2/R3) surfaced one genuine proposed amendment to canon: the
**authorship arrow** (Force 4 — "intelligence flows authoring → compile-down → consumers; never
backward"). R2 wanted the arrow reversed (the agent derives and self-writes canon; the human
becomes auditor). R3 defended human authorship. R1 reframed it as *provenance*: a closed loop
(agent writes back to canon) is fine *iff* version-controlled, revertable, human-approved. Per
Force 6, the amendment went to @Janus before any lock.

## Decision
**Force 4 stands. The invariant is the GATE — pre-merge human cognition — not the direction, and
not provenance.** The only backward path is: **the agent DRAFTS a diff against the authoring tier;
the human's approval IS the authoring act.** Agent-authored-direct canon is forbidden. Any
closed-loop *automation* stays CONDITIONAL, pending a detection-rate experiment.

## Why (Janus's weakest-assumption catch)
The proposed amendment rests on git's *revertable provenance* being what Force 4 protects. It is
not. Force 4 guards against drift that is **silent**, not drift that is **permanent**. Git makes a
bad write *revertable* but does nothing to make it *detectable* — and reverting requires you
already noticed. The whole danger of agent-derived canon is the **plausibly-wrong write you never
flag**. The load-bearing property is pre-merge human cognition; "revertable + version-controlled"
smuggles in a feeling of safety while leaving the real gate optional.

For a SOLO operator this **inverts the cost gradient (Force 1)**: cheap to let the agent write,
expensive to verify. Under load you rationally skip the audit — and the skipped audit is invisible
by construction. That rots Tier S, the one tier the whole sovereignty argument depends on. R3
(clean, empirical) pointed this way; R1 (the contested leg) produced the amendment — so weight R3
over R1 here.

## Consequences
- The "agent drafts → human authors-by-approving (a PR against Tier S)" pattern is permitted and is
  the *only* backward path. Mechanically it is already in-stack.
- Before any closed-loop automation: run the **detection-rate experiment** — seed the agent's
  write-back with a known plausible error, measure whether the solo operator catches it under
  realistic load. **Measure catch-rate, not authoring-time-saved.** A loop that saves an hour and
  lets one poisoned premise through has lost the trade.

## What an agent must do differently
- Never write canon directly. **Propose canon as a reviewable diff**; the human merges.
- If you ever test the closed loop, instrument it for *detection rate*, never for time saved.
