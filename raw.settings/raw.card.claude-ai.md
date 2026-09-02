---
card: card.claude-ai
brand: Anthropic — claude.ai (chat + Projects)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-09-02
half_life: ~weeks
half_life_days: 21
recheck:
  - https://support.claude.com/en/articles/12138966-release-notes
  - https://www.anthropic.com/news
  - https://releasebot.io/updates/anthropic/claude
surface_type: chat (NO filesystem; standing instructions + retrieved knowledge)
---

# claude.ai — chat & Projects (the architect / authoring surface)

## Refresh delta 2026-09-02
- **Claude Opus 5 launched Jul 24, 2026** — replaces Opus 4.8 in the tier stack; ~half the price
  of Fable 5 ($5/$25 per M tokens in/out, same as 4.8); 1M context; became Enterprise seat-based
  default. Source: anthropic.com/news/claude-opus-5, tech-ish.com 2026-07-24. CONFIDENCE: H.
- **Claude Fable 5.1 and Mythos 5.1 launched Sep 1, 2026** — replace Fable 5 / Mythos 5; same
  underlying model, different safeguard levels (Mythos 5.1 = trusted-access only, life-sciences/
  cybersecurity work). Cost reduction + fewer false-positive refusals vs Fable 5. Knowledge cutoff
  June 2026. Source: anthropic.com/news, system card PDF (www-cdn.anthropic.com, 2026-09-01),
  techcrunch.com 2026-09-01. CONFIDENCE: H.
- **Fable 5.1 app access is plan-gated**: Max and Team Premium get it inside their weekly
  allowance (~50%); Pro and Team Standard must pay via usage credits on top of the subscription —
  same split as Fable 5 had. Source: support.claude.com/en/articles/15424964, notebookcheck.net
  2026-09 coverage. CONFIDENCE: M (aggregator-sourced, not the primary support article read directly).
- **Memory system overhaul, two steps**: Jul 10 — moved from daily-summary memory to individual,
  categorized entries Claude reads/updates during conversations; Aug 25 — memory now spans chat
  AND Cowork-in-the-cloud, with editable topics and a new "sensitive topics" exclusion setting in
  Settings. Source: support.claude.com release notes (fetched 2026-09-02). CONFIDENCE: H.
- **Text watermarking disclosed Aug 14, 2026** — Anthropic published how output watermarking works
  and its impact on generations; relevant to any downstream artifact-authenticity assumption.
  Source: anthropic.com/news. CONFIDENCE: H.
- **Sonnet 5 remains the Free/Pro/Team default** (launched Jun 30, unchanged since last verify);
  Enterprise seat-based plans now default to **Opus 5**, not Sonnet 5 — this is new since 2026-07-16.
  Source: edtechinnovationhub.com 2026-09 coverage of the Sonnet-5-default rollout, cross-read
  against the Opus 5 launch note. CONFIDENCE: M (tier-default split inferred from two secondary
  sources, not a single primary statement).
- Previously logged Jun–Jul items (Claude Code Artifacts, Cowork web/mobile expansion, M365 write
  tools, Gov Desktop, HIPAA self-serve, Claude for Teachers, Slack tag, MCP org auth, Trusted
  Devices) found **no contradicting update** in this window — treated as still current, not
  re-verified line-by-line. CONFIDENCE: L (carried forward, not re-fetched individually).
- No evidence found of new Projects-specific feature changes (custom instructions / project
  knowledge mechanics unchanged) between 2026-07-16 and 2026-09-02. CONFIDENCE: M (absence-of-news
  inference from release notes + news page, not an explicit "no change" statement).

## What it is (and isn't)
- A reasoning + authoring surface. NO disk write, NO agent/skill/hook files. It PRODUCES
  artifacts (config, prompts, plans) as text for transcription.
- Best-fit LARVA roles: architect (@Houston), agent-builder (authoring brain), recalibration researcher.

## The two configuration levers
1. **Project** — a workspace with:
   - **Custom instructions** (standing prompt baked into every chat in the project)
     ← this is where a researcher's / builder's "system prompt" lives.
   - **Project knowledge** (files/text, retrieved via search during chats) ← feed the RELATIVE cards here.
2. **Style** — customizes writing/tone separately from instructions.

## Toggles that matter
- Web search / Deep research (live grounding — powers "recalibrate vs training data").
- Code Execution & File Creation (produces downloadable artifacts).
- Memory / search-past-chats — now categorized-entry based (Jul 10) and cross-product with Cowork
  (Aug 25), with a per-topic sensitive-exclusion setting.
- **Claude Design** (Jun 2026, sidebar) — design system import (GitHub repo, design files, raw upload),
  direct canvas editing, Claude Code sync. Available at `claude.ai/design`. Admin-toggled on Team/Enterprise.

## Model tier (2026-09-02)
Claude Mythos 5.1 (trusted-access only) > **Fable 5.1** > Opus 5 > Sonnet 5 (Free/Pro/Team default)
> Sonnet 4.6 (legacy) > Haiku 4.5. Enterprise seat-based plans default to **Opus 5**, not Sonnet 5.
Fable 5.1 is plan-gated: Max/Team Premium get it within weekly allowance; Pro/Team Standard pay
per-use via usage credits.

## The date fact (load-bearing for researchers)
- The interface INJECTS the current date; the model does NOT know it from weights. "Today is <date>"
  in a prompt works because the harness supplies it. Keep that line in researcher prompts.

## Limits
- NO autonomous scheduling. Standing instructions shape behavior WHEN invoked; the chat does not
  wake itself on a date. (Recurring radar → CLI/automation layer.)
- Project-knowledge edits do not disrupt a running thread; freshness for an in-flight thread isn't
  guaranteed → for a running thread, paste new context rather than rely on re-index.

## Recommendation for LARVA
Host the **agent-builder** and the **recalibration researcher** here as Projects with standing
instructions. Feed the RELATIVE cards as project knowledge so they reason against current reality.
Claude Design is available but not yet load-bearing in LARVA workflow — assess when stable.
Claude Code Artifacts are usable on Pro/Max for publishing session outputs as live pages.
</content>
