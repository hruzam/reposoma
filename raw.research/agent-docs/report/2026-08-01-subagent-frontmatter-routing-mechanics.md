# Subagent Frontmatter & Cold-Start Routing Mechanics — Source Backup

**Date:** 2026-08-01
**Filed under:** raw.research / agent-docs / report
**Status:** SOURCE-MATERIAL BACKUP for the `/refresh agent-docs` card pass (run by @majkee same day).
**Purpose:** durable backstop for the card refresh — the raw findings, kept even if the card is later re-synthesized or drifts. Point-never-copy: the card is the surface; this is the evidence.
**Provenance:** three-current research fan-out (Atlas main session) — @eagle internal corpus sweep + @epoch ×1 web verify. Web claims live-verified 2026-08-01.

---

## The question

Why does the `color`-style agent frontmatter — third-person `description` + multiple `<example>` blocks (Context / user / assistant / commentary) — exist, and what is that richness *doing* at cold start?

## The confirmed answer

**The rich frontmatter is a few-shot routing manual for the *parent* model's delegate/don't-delegate decision.** Not documentation for a human, not instructions to the agent itself.

Anthropic's own stated rationale (direct quote from the source template file):

> "The multi-example, third-person approach serves runtime delegation and routing. By illustrating various contexts where an agent activates — both explicit requests and inferred needs — the system can intelligently route tasks to appropriate agents during conversation flow."

- SOURCE: `anthropics/claude-code` repo →
  `plugins/plugin-dev/skills/agent-development/examples/agent-creation-prompt.md`
  (live-fetched 2026-08-01) — CONFIDENCE: H (primary Anthropic source)
- The template specifies: `Use this agent when [trigger]. Examples:` + multiple `<example>` blocks,
  assistant turn always **third person** ("I'll use the X agent to…").

## The twist — the interactive builder is retired

The interactive `/agents` creation wizard that popularized this template **was removed in v2.1.198 (2026-07-02)**. `/agents` now just prints "ask Claude or hand-edit `.claude/agents/`." File format/locations unchanged; only the wizard UI is gone.

- SOURCE: `code.claude.com/docs/en/sub-agents` + `github.com/anthropics/claude-code/releases/tag/v2.1.198` + issue #72945 — CONFIDENCE: H

**Consequence:** `color.md` / `zed-editor-expert.md` carry the rich pattern as the *fingerprint of the retired template* (plus muscle-memory imitation), not from any currently-live UI builder. This corrects the working assumption that a live "UI Claude builder" still emits it.

## The divergence — two official sources disagree

- **Plugin-dev template** (above): rich, example-driven, third-person.
- **Mainline product docs** (`code.claude.com/docs/en/sub-agents`, live 2026-08-01): the OPPOSITE — single-sentence trigger descriptions, NO `<example>` blocks. Stated best practice: *"Write detailed descriptions: Claude uses the description to decide when to delegate"*; *"'Reviews code for security issues before commits' routes better than 'security expert.'"*
- Anthropic blog "How and when to use subagents in Claude Code" (2026-04-07): same light guidance, no mention of example blocks.

There is a **real, unreconciled split** between Anthropic's own two guidance surfaces. CONFIDENCE: H on the divergence itself.

## The loading mechanism — OPEN (inferred, not documented)

- **Skill** descriptions ARE an explicit line-item in Anthropic's context-window simulator (~450 tok, always resident, system-prompt tier).
- **Subagent** descriptions are **conspicuously absent** as a discrete context cost anywhere in that simulator — including its subagent-spawn walkthrough.
- Most plausible carrier: the `Agent` tool's `subagent_type` **parameter schema** (enum + per-option descriptions), analogous to how MCP tool names ride the tool-definition surface — NOT a separate injected prose block like skill metadata.
- CONFIDENCE: **M — inferred from absence, not stated by Anthropic.**
- ⚠ This is the load-bearing open question. **`raw.card.harness-injection` / the harness-lifecycle report's ~100-token "agent description rides system prompt" framing conflates the SKILL mechanic with the SUBAGENT mechanic.** For subagents the mechanism is unverified.

## Corpus corroboration (@eagle)

- Cold-start ORDER + three-layer authority model: fully nailed, cross-corroborated by the harness-lifecycle report + `raw.card.claude-code.md` (matching numbers: ~5,300 tok startup budget).
- "Why rich description": only PARTIALLY covered pre-refresh — the mechanical reason was recorded, the routing-accuracy claim was inference. Now sourced (Anthropic quote above).
- `<example>` block convention: was ZERO in corpus before this pass. Now filled.

## Reliability footnote (low trust)

Third-party writeups claim auto-selection is unreliable — Claude often handles matching work in the main session anyway; explicit `@mention` / naming is the dependable path. CONFIDENCE: L — not traced to a primary Anthropic acknowledgment; treat as anecdotal.

## Sections to refresh later

- How the `Agent`-tool `subagent_type` schema is actually serialized into the parent request (the token mechanism for the OPEN question above) — one targeted follow-up would close M→H.
- Whether Anthropic ever reconciles the plugin-dev template vs. mainline-docs divergence.

---

*Epoch + Eagle fan-out · Atlas main session · 2026-08-01*
