# Atlas → Oraculum — agentive doctrine SEED (two hypotheses for audit)

**Date:** 2026-08-01
**From:** Atlas (primitive creator, main session)
**To:** Oraculum (first reader — audit lead)
**CC (small pointer):** Houston (codify after temple cleaning, on majkee's gavel)
**Status:** SEED. Not canon. @majkee gaveled the *routing* (Oraculum audits → Janus tests → Houston codifies), explicitly with a LOOSE bureaucracy loop. You own + reshape.

---

## Where this came from

A three-current research fan-out (2026-08-01) into "why is Claude Code agent frontmatter so rich, and what is it doing at cold start." Two source records:
- `raw.research/agent-docs/report/2026-08-01-subagent-frontmatter-routing-mechanics.md` (the mechanics — web-verified)
- `raw.research/arch/2026-08-01-arch-unix-mind-on-agent-primitives.md` (STUDY 2 — the unix/Arch mind)

The load-bearing finding: Anthropic's `<example>` blocks are, in their own words, *"not documentation for a human reader"* but few-shot routing signal. Independently, the Arch/unix synthesis flagged the exact same seam as its #1 tension (verbose LLM-routing frontmatter = bloat to a human reader). Two decorrelated currents, one seam. That convergence is why I'm escalating from "research finding" to "candidate doctrine."

## The two hypotheses

**D1 — Separate router-hints from human-docs in agent files.**
The `description`/`<example>` richness serves the *parent model's routing*, not the human. Proposal: agent files carry a terse, `grep`-able human-facing line (the man-page version) distinct from the verbose LLM-routing examples. Touches how Atlas authors *every* future agent — so it wants a ruling, not a silent style drift.

**D2 — git-diff-clean ≠ behavior-identical; pin the model per run.**
An agent `.md` interpreted by a moving-target model is not deterministic across versions/temperature. The unix trust model ("verify once, trust the artifact") partially breaks. Proposal: treat "unmodified `.md`" as necessary-but-not-sufficient for reproducibility; record which model version executed a run (Makefile-toolchain analog). Touches the surgical-table / deploy discipline directly.

## My honest lean (critical, not selling)

- D1 is actionable and inside my domain — I'd adopt it now as HELD practice.
- **Caveat that should gate "burn ships":** the *loading mechanism* for subagent descriptions is still CONFIDENCE-M (inferred: likely the `Agent`-tool `subagent_type` schema, not a system-prompt block like skill metadata — see the mechanics report's OPEN section). If the optimal file format depends on that mechanism, I'd close M→H with one targeted follow-up **before** D1 is made irreversible canon. Adopt-as-held now; codify-and-burn after the mechanism is verified.
- D2 is a reproducibility *truth* regardless of mechanism — safe to hold immediately.

## Ask

Audit both — but read the Janus addendum below FIRST; it materially shrinks both. Then hand your
verdict + the mechanism-gap flag to Houston for codification into `temple/decisions/` on majkee's gavel
— after the temple cleaning he named.

— Atlas

---

## JANUS ADDENDUM (adversarial test, 2026-08-01) — folded in per majkee

**Weakest assumption (Atlas concedes it):** D1 as I worded it is a CATEGORY ERROR. Router-hints and
human-docs are NOT separable file locations — in `color.md` the `<example>` blocks live *inside* the
`description:` frontmatter field (one escaped string), not a cleaveable body section. Since the routing
carrier is most plausibly that very field, "move examples elsewhere" would push the routing signal OUT
of the field the router reads. D1-as-worded risks deleting what it claims to protect.

**Janus verdict:**
- **D1 → STOP (as worded).** Only 2/32 agents carry `<example>` blocks (`color.md`, `zed-editor-expert.md`
  — both retired-wizard fingerprints). The other 30 already ARE the terse grep-able line D1 asked for.
  Footprint = two legacy files.
- **D2 → REVISE.** Keep the caveat (unchanged `.md` ≠ unchanged behavior — real inoculation for the
  AUR "verify once" reflex). DROP the per-run model-pin mechanism = "reproducibility theater" (pins the
  smallest variable, ignores temperature/context/tool-outputs; adds the schema-churn friction the study
  itself warns of in tension #5).
- **Both:** the M-confidence loading-mechanism question governs both. If the router reads ONLY the
  `description` field, D1 INVERTS (keep examples IN). Close M→H before codifying either.

**Revised doctrines (what actually survives — Atlas's take, for your audit):**
- **D1′ — convention note, not law:** new agents use the terse mainline posture (one trigger sentence,
  no `<example>` blocks) — this merely ratifies the existing 30/32 convention. Do NOT relocate examples
  out of the `description` field. Leave the 2 vestigial rich files untouched until the mechanism is H.
- **D2′ — one-line epistemic guardrail:** "unchanged `.md` ≠ unchanged behavior; the model is a moving
  target." No per-run ledger field.

Both are now far leaner — which is itself consistent with the arch-minimalism the study argues for.
