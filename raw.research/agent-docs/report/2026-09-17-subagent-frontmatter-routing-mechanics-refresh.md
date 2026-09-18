# Subagent Frontmatter & Cold-Start Routing Mechanics — REFRESH

**Date:** 2026-09-17
**Filed under:** raw.research / agent-docs / report
**Relation to prior report:** delta against `2026-08-01-subagent-frontmatter-routing-mechanics.md`.
Does not replace it. Read the original first — this closes (partially) its single OPEN question and
reconfirms its central divergence finding still stands, sharper than before.
**Researcher:** @Epoch (Sonnet)

---

## Headline

The original report's **load-bearing OPEN question — "does a subagent description have a real, discrete
token cost, or does it ride some other mechanism entirely?" — moves from OPEN/inferred (M) to
PARTIALLY RESOLVED (H for "yes it costs real tokens," still open for "exactly how it's serialized").**
Anthropic now documents an explicit **15,000-token combined budget** for subagent descriptions (excluding
built-ins), with a startup warning when exceeded — this did not exist as documented fact in the original
report. The **plugin-dev vs. mainline-docs divergence is reconfirmed live, unchanged, and now has a
sharper edge**: mainline docs explicitly cite the token-budget as the reason to keep descriptions short,
while the plugin-dev template still teaches the verbose multi-`<example>` pattern, unreconciled.

---

## Findings (most recent first)

### 1. RESOLVED (partially): subagent descriptions DO have a discrete, documented token budget

WHAT changed: the original report's OPEN question flagged that skill descriptions are an explicit
line-item in Anthropic's context simulator (~450 tok) while subagent descriptions were "conspicuously
absent" as a discrete cost anywhere documented — forcing an inferred M-confidence guess that they ride
the `Agent` tool's `subagent_type` parameter schema instead of a separate injected block.

Today's live fetch of the mainline sub-agents doc states directly: **"Those descriptions take up
context, so keep them short. When the combined descriptions of your subagents, except the built-in ones,
exceed 15,000 tokens, Claude Code shows a warning at startup with the total token count."** There is a
dedicated errors-page section titled "Agent descriptions are over the 15000 token limit."

SOURCE: https://code.claude.com/docs/en/sub-agents (live-fetched 2026-09-17) · errors reference page
(https://code.claude.com/docs/en/errors) — section confirmed to exist, full remediation text not
captured this pass (page fetch was truncated at that section)
CONFIDENCE: H (that a real, budgeted token cost exists and is officially documented) — still M for the
narrower sub-question the original report actually asked (the exact serialization mechanism: literal
system-prompt text block vs. tool-schema enum-with-descriptions). Anthropic's public docs still do not
say *how* the 15,000-token budget is delivered to the model, only that it exists and is measured.
IMPACT: the original report's framing "For subagents the mechanism is unverified" should be softened —
the EXISTENCE and BUDGET of the cost is now verified; only the DELIVERY MECHANISM remains unverified.
This also means the original harness-lifecycle report's "~100-token skill metadata is system-prompt tier"
framing, which the original subagent report flagged as a possible SKILL/SUBAGENT conflation risk, is
now less risky to reconcile — both skill descriptions AND subagent descriptions are confirmed to consume
a real, discrete, budgeted slice of context, even though the exact tier/placement differs.
ACTION: one more targeted fetch — `code.claude.com/docs/en/context-window` — to check whether it lists
subagent descriptions as a discrete line-item the way it does skill descriptions (~450 tok figure cited
in the original harness report). Not done this pass; would fully close M→H on the narrow question.

### 2. Divergence between plugin-dev template and mainline docs: RECONFIRMED, unchanged, sharper

WHAT changed: re-fetched both sources live today.
- `plugins/plugin-dev/skills/agent-development/examples/agent-creation-prompt.md` on `main` **still
  contains** the third-person, multi-`<example>` Context/user/assistant/commentary format, apparently
  byte-for-byte unchanged from the original report's 2026-08-01 finding.
- Mainline `code.claude.com/docs/en/sub-agents` **still** recommends short, single-sentence descriptions
  — and now has a stronger, more explicit rationale than it did in August: the 15,000-token warning
  (Finding 1) gives a concrete, quantified reason to prefer brevity, rather than just a stylistic
  preference.
SOURCE: https://raw.githubusercontent.com/anthropics/claude-code/main/plugins/plugin-dev/skills/agent-development/examples/agent-creation-prompt.md
· https://code.claude.com/docs/en/sub-agents (both live-fetched 2026-09-17)
CONFIDENCE: H on both the divergence's continued existence and its sharpened framing.
IMPACT: this is now a *more*, not less, actionable inconsistency than in August. The plugin-dev template
is the one Anthropic ships as the reference example for building agents, yet it teaches a pattern that
the same organization's product docs now explicitly discourage on quantified token-budget grounds. Any
agent in this harness following the plugin-dev pattern (`color.md`, `zed-editor-expert.md` per the
original report) is, per Anthropic's own current guidance, working against its own token budget.
ACTION: this is a real decision point, not just a research note — flag to @Houston/@majkee whether
`color.md`/`zed-editor-expert.md` and any other verbose-example-style agent definitions in this repo
should be trimmed toward the mainline single-sentence pattern. If the decision is delicate (touches
existing agent definitions), route through @Janus before locking, per doctrine. Not decided in this
research pass.

### 3. /agents wizard retirement (v2.1.198): CONFIRMED stable, unchanged

WHAT changed: nothing — reconfirmed verbatim today. `/agents` still just prints a reminder; file
format/locations unchanged.
SOURCE: https://code.claude.com/docs/en/sub-agents (live-fetched 2026-09-17)
CONFIDENCE: H
IMPACT: none — original report's finding stands.
ACTION: none.

### 4. NEW: `omitClaudeMd` subagent frontmatter field (v2.1.267) — not in original report at all

WHAT changed: subagents/plugin subagents can now declare `omitClaudeMd` in frontmatter (or via `--agents`
JSON) to skip loading user/project/local CLAUDE.md files; managed policy CLAUDE.md still loads regardless.
SINCE when: v2.1.267
SOURCE: https://code.claude.com/docs/en/changelog
CONFIDENCE: H
IMPACT: this is a genuinely new frontmatter mechanic the original report (2026-08-01) could not have
known about — it postdates that report. Extends the frontmatter surface beyond `description`,
`<example>` blocks, `tools`, `model`.
ACTION: fold into whatever card eventually documents the full subagent frontmatter schema.

### 5. Community reliability claim: reconfirmed by convergent (still non-primary) sources, confidence nudged L→M

WHAT changed: the original report flagged (CONFIDENCE L) a third-party claim that auto-selection routing
is unreliable and explicit `@mention` is the dependable path, "not traced to a primary Anthropic
acknowledgment." Per your request, explored community experience directly this pass: multiple
independent 2026 blogs/guides (Tembo, HackerNoon, dev.to, Nimbalyst, Totalum) converge on the same
pattern — vague or overlapping descriptions cause inconsistent delegation, a tight set of subagents with
sharp descriptions routes more reliably than a large fuzzy set, and explicit naming ("Use the
code-reviewer agent to...") bypasses description-matching entirely and is recommended for
critical/production workflows.
SOURCE: WebSearch aggregation, 2026 — Tembo.io, HackerNoon, dev.to, Nimbalyst, Totalum (multiple
independent outlets, none primary-Anthropic, none individually deep-verified this pass)
CONFIDENCE: M (upgraded from L — convergence across several independent practitioner sources, but still
zero primary Anthropic acknowledgment that auto-routing is unreliable; Anthropic's own docs frame
description-quality as the tunable knob, not as evidence the mechanism itself is flaky)
IMPACT: strengthens, doesn't overturn, the original report's cautious framing.
ACTION: none required — this remains a "hold as anecdotal, don't cite as Anthropic-acknowledged" item,
same as the original report's stance, just with more community weight behind it now.

---

## Sections to refresh in the ORIGINAL 2026-08-01 report

- "The loading mechanism — OPEN" section: update to reflect Finding 1 — existence/budget now confirmed
  H, exact serialization mechanism still open M, narrowed follow-up identified (context-window doc)
- "Reliability footnote (low trust)": bump confidence L→M per Finding 5, keep the caution
- Add: `omitClaudeMd` as a new-since-report frontmatter field (Finding 4)
- Flag Finding 2's sharpened divergence as a live decision item for @Houston, not just a research note

---

## Sources (this refresh pass)

| Source | Confidence | URL |
|---|---|---|
| Official sub-agents docs (live, 2026-09-17) | H | https://code.claude.com/docs/en/sub-agents |
| Official changelog (live, 2026-09-17) | H | https://code.claude.com/docs/en/changelog |
| Official errors reference (live, partial fetch) | M | https://code.claude.com/docs/en/errors |
| Plugin-dev template on `main` (live, 2026-09-17) | H | https://raw.githubusercontent.com/anthropics/claude-code/main/plugins/plugin-dev/skills/agent-development/examples/agent-creation-prompt.md |
| Community routing-reliability convergence (multiple outlets) | M | Tembo.io, HackerNoon, dev.to, Nimbalyst, Totalum (2026) |

---

*Epoch research · agent-docs refresh pass · 2026-09-17*
