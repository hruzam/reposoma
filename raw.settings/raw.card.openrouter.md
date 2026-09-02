---
card: card.openrouter
brand: Research — OpenRouter model catalog (scope: openrouter)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-09-02
half_life: ~14 days
half_life_days: 14
recheck:
  - ~/reposoma/raw.research/openrouter/draft/sources.jsonl
  - https://openrouter.ai/blog
verify_cmd: "curl -s https://openrouter.ai/docs/models | grep -c 'api/v1/models'"
---

# openrouter — synthesis log

Skill: `/refresh openrouter` · Data: `raw.research/openrouter/draft/sources.jsonl`
Substrate: `raw.research/openrouter/report/`

## 2026-09-02

**Lead:** Big-corporate-story window: **Stripe agreed to acquire OpenRouter (announced 2026-08-19)**, reported ~$7.5B (~$1.5B to founders) — a huge jump from the $1.3B valuation at the May 28 Series B just months earlier. OpenRouter states it will keep operating independently, product/mission/commitments unchanged. Cross-verified via WebSearch against Stripe's own newsroom post plus TechCrunch, Bloomberg, CNBC, Yahoo Finance, PaymentsDive — CONFIDENCE:H. Core API surface, integration paths (direct/SDK/Agent SDK), MCP server (`mcp.openrouter.ai/mcp`), and free-tier limits (20 RPM, 50/day pre-credit, 1,000/day post-$10) are all unchanged since 2026-07-10. Blog cadence since then: model-selection framework, image-model comparisons, spend-analytics dashboard, standardized tool-calling guide, and the Aug 19 Stripe announcement as the clear headline.

**Convergence:** MCP server / mcp.openrouter.ai (openrouter-quickstart, openrouter-blog) — full, unchanged since 2026-07-10

**Quiet:** N/A (snapshot mode)

**Feed flags:** none

**Manual-check:** none

---

## 2026-07-10

**Lead:** First-run snapshot. Platform: 400+ models, three integration paths (direct API, client SDKs, Agent SDK `@openrouter/agent`), MCP server live at `mcp.openrouter.ai/mcp`. Free tier: 20 RPM / 50 req/day pre-credit, 1,000/day after $10+ purchase; `:free` suffix on free model IDs. Recent platform additions: Fusion (budget panel beats GPT-5.5 + Claude Opus 4.8, Jun 12), Subagent (Jun 16), Advisor (Jun 10), Guardrails (May 29), Unified Image API — 30+ models (Jun 23), $113M Series B (May 28). API surface: plugins (`web`, `file-parser`, `response-healing`, `context-compression`), provider routing with fallback arrays, structured outputs, reasoning/cached token breakdown in `usage`.

**Convergence:** MCP server / mcp.openrouter.ai (openrouter-quickstart, openrouter-blog) — full

**Quiet:** N/A (snapshot mode)

**Feed flags:** none

**Manual-check:** none

---

<!-- older runs appended below this line, newest first -->
