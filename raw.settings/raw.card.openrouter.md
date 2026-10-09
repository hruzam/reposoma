---
card: card.openrouter
brand: Research — OpenRouter model catalog (scope: openrouter)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-10-08
half_life: ~14 days
half_life_days: 14
recheck:
  - ~/reposoma/raw.research/openrouter/draft/sources.jsonl
  - https://openrouter.ai/blog
verify_cmd: "curl -s https://openrouter.ai/docs/models | grep -c 'api/v1/models'"
---

## Refresh delta 2026-10-08
_Since last verify 2026-09-02. Source: openrouter.ai/blog, live-fetched 2026-10-08 by @Epoch. Pass 2 pulled GET /api/v1/models?sort=newest&limit=15 through a summarizer: it returned only 10 models, NO pricing, and OMITS Sonnet 5.5 (Sep 28) and Haiku 5.5 (Oct 7) — so the list is incomplete/unreliable (L-M). Per-model pricing for 2 models verified in pass 3 via /api/v1/models/{id}/endpoints (below); the rest still NOT verified._
- **Oct 7:** ElevenLabs models on OpenRouter (9 TTS + 2 STT: Eleven v4, v4 Turbo, Scribe v2). **Oct 5:** shell/bash server-side code-exec tools comparison (shell tool works with any model on Responses + Messages APIs; bash on Messages API). **Oct 2:** Model Router Benchmarks. H
- **Sep 28:** Security Center for API keys. **Sep 22:** Batch API at half price. **Sep 9:** In-Region Routing (US/EU). **Sep 8:** shell tool. H
- **Catalog API shape (docs, H):** `GET /api/v1/models` returns `data[]`, `total_count`, `links.next`; params `output_modalities`, `supported_parameters`, `sort` (`pricing-low-to-high`, `context-high-to-low`, `latency-low-to-high`, `newest`), `offset`/`limit` (default 500, max 1000); model fields incl. `id`, `canonical_slug`, `created`, `context_length`, `architecture`, `pricing` (USD PER TOKEN as string, e.g. "0.0000025" = $2.50/Mtok), `top_provider`, `supported_parameters`, `expiration_date`, `benchmarks`. Single model: `GET /api/v1/model/{author}/{slug}`.
- **Models seen in catalog fetch (created date, M):** openai/gpt-6.1-sol[1m] 09-29 · anthropic/claude-opus-5.5[1m] 09-22 · x-ai/grok-4.7 (listed as SpaceXAI) 09-21 · openai/gpt-6-astra[1m] 09-04 · qwen/qwen3.8-max-0902 09-03 · meta/muse-spark-1.3[1m] 09-02 · google/gemini-3.8-flash[1m] 09-02 · anthropic/claude-fable-5.1[1m] 09-01 · moonshotai/kimi-k3[1m] 07-16 · anthropic/claude-fable-5[1m] 06-09. No DeepSeek/GLM in the returned slice. Note the `[1m]` suffix in ids as returned.
- **Per-model prices, pass 3 (OpenRouter endpoints API, USD per Mtok, H for the listing, M for interpretation):** `anthropic/claude-sonnet-5.5` — ctx 1,000,000, max out 128,000; Anthropic/Bedrock/Azure-global/Vertex-global/Claude-on-AWS: $2.00 in / $10.00 out, cache read $0.10, cache write $2.50; Vertex-us/europe and Azure-us: $2.20 / $11.00 (+10%). `openai/gpt-6.1-sol` — ctx 1,050,000, max out 128,000; OpenAI flex $1/$5 (>=272K tokens: $2/$7.50), OpenAI standard and Azure $2/$10 (>=272K: $4/$15), OpenAI fast $4/$20 (>=272K: $8/$30), Bedrock us-east-1 / Azure us / eu $2.20/$11; cached input $0.05 on flex, $0.10–$0.40 elsewhere. **Source conflict:** Claude Code changelog v2.1.284 says Sonnet 5.5 cache reads are $0.20/Mtok; OpenRouter lists $0.10 on every provider — unresolved (check platform.claude.com pricing). Opus 5.5 and Haiku 5.5 model pages on openrouter.ai return docs only (no price); Haiku 5.5 is served (not 404) but its price was not read.

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
