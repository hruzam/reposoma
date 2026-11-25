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
verify_cmd: "curl -s https://openrouter.ai/api/v1/models | python3 -c 'import sys,json;d=json.load(sys.stdin);print(d[\"total_count\"])'"
---

## Refresh delta 2026-11-25
_PARTIAL: catalog and prices are from the live API (H) but NOT checked against vendor pricing pages, openrouter.ai/blog since 2026-10-08 not read, free-tier rate limits and Stripe-acquisition status not re-verified. Since last verify 2026-10-08. Source: `GET https://openrouter.ai/api/v1/models` (no key), full JSON 921 KB, HTTP 200, parsed with python3 -I on 2026-11-25 by @Epoch-sibling. The earlier summarizer-garbled read is superseded by this one._
- **Catalog size and shape (H):** `total_count` 474, `data` 474 entries in ONE response, `links.next` null (no pagination needed at default limit). Top-level keys `total_count`, `links`, `data`. Model keys now: `id, canonical_slug, hugging_face_id, name, created, description, context_length, architecture, pricing, top_provider{context_length,max_completion_tokens,is_moderated}, per_request_limits, supported_parameters, default_parameters, reasoning, expiration_date, knowledge_cutoff, supported_voices, links{details}, endpoints[]` (e.g. `/api/v1/chat/completions`, `/completions`, `/messages`, `/responses`). New vs card list: `reasoning`, `default_parameters`, `knowledge_cutoff`, `supported_voices`, `per_request_limits`, `links.details`, `endpoints[]`; `benchmarks` NOT present in the list response. `pricing` values are strings in USD per token; keys seen (count of models): `prompt` 474, `completion` 474, `input_cache_read` 342, `input_cache_write` 117, `input_cache_write_1h` 36, `web_search` 198, `overrides` 88, `image` 35, `audio` 38, `input_audio_cache` 33, `internal_reasoning` 36, `image_output` 10, `audio_output` 2.
- **Ids carry NO `[1m]` suffix (H):** zero of 474 ids contain `[`. The `[1m]` seen on 2026-10-08 was a summarizer artefact. New id shapes: `:batch` variants (96 entries, priced at ~50% of the base; e.g. `anthropic/claude-sonnet-5.5:batch` $1/$5), `:free` (11), `~vendor/*-latest` alias ids (19, e.g. `~anthropic/claude-fable-latest`), `-pro` suffix entries for OpenAI (`gpt-6.2-astra-pro`, `-sol-pro`). `canonical_slug` carries a date (e.g. `anthropic/claude-sonnet-5.5-20260928`).
- **15 newest by `created` (H; $/Mtok in/out; ctx):** upstage/solar-mini-4-5 524K $0.01/$0.04 11-24 · upstage/solar-pro-4-contributor 524K $0.09/$0.36 11-24 · xiaomi/mimo-v2.6-flash-mopd 1.05M $0.50/$1.00 11-23 · thinkingmachines/inkling-2-mini 1.05M $0.075/$0.30 11-21 · radixark/daisyrose-27b 262K $0.15/$1.875 11-21 · mistralai/pixtral-large-2502 128K $2/$6 11-20 (odd: 2502 id but created 2026-11-20, M) · google/gemini-4-neon 1.05M $3/$15 11-18 · google/gemini-4-neon:batch $1.50/$7.50 11-18 · openai/gpt-6.2-astra-pro 1.05M $8/$40 11-17 · …:batch $4/$20 · openai/gpt-6.2-astra 1.05M $8/$40 11-17 · …:batch $4/$20 · openai/gpt-6.2-sol-pro 1.05M $2/$10 11-17 · …:batch $1/$5 · openai/gpt-6.2-sol 1.05M $2/$10 11-17. (Created timestamps tie; the order among same-day entries is arbitrary. `sort=newest` order differs slightly at the top.)
- **Tracked families (H for OpenRouter's listing; ctx / in / out / cache-read / cache-write per Mtok; created):**
  - Anthropic (all ctx 1,000,000, max out 128,000): `claude-fable-5.2` $8/$40, cr $0.20, cw $10, 11-09 · `claude-fable-5.1` $10/$50, cr 0.25, 09-01 · `claude-fable-5` $10/$50, cr 1.00, 06-09 · `claude-opus-5.5` $4/$20, cr 0.20, cw 5, 09-22 · `claude-opus-5` $5/$25, 07-24 · `claude-sonnet-5.5` $2/$10, cr **0.10**, cw 2.50, 09-28 · `claude-sonnet-5` $2/$10, cr 0.20, 06-30 · `claude-haiku-5.5` $0.10/$0.50, cr 0.01, cw 0.125, 10-07. `claude-mythos`: **NOT in the catalog** (no id or name match, H). Aliases `~anthropic/claude-{fable,opus,sonnet,haiku}-latest` resolve to fable-5.2 / opus-5.5 / sonnet-5.5 / haiku-5.5 prices.
  - OpenAI (ctx 1,050,000, max out 128,000): `gpt-6.2-astra` $8/$40 (cr 0.40, cw 10), `gpt-6.2-astra-pro` $8/$40, `gpt-6.2-sol` $2/$10 (cr 0.10, cw 2.50), `gpt-6.2-sol-pro` $2/$10 — all 11-17 · `gpt-6.1-sol` / `-sol-pro` $2/$10, 09-29 · `gpt-6.1-terra` / `-terra-pro` $1/$5, 10-26 · `gpt-6-astra` $10/$50 (09-04), `gpt-6-sol` $2/$10 cr 0.20, `gpt-6-luna` $0.10/$0.50 (09-22). Note: there is NO `gpt-6.1-astra`; 6.1 has sol + terra.
  - Google: `gemini-4-neon` $3/$15 (cr 0.15), `gemini-4-hydrogen` $1.50/$7.50 (11-12), `gemini-4-carbon` $2/$10 (11-10), `gemini-4-argon` $2/$10 (10-13); all ctx 1,048,576, max out 943,718. `gemini-3.8-flash` $0.825/$4.125 (09-02). Batch variants at 50%.
  - Others: x-ai/grok-4.7 $2/$6 ctx 500K (09-21) · moonshotai/kimi-k3.1-pro $0.24/$8.40 (10-23) · moonshotai/kimi-k3 $0.192/$16 (07-16) · deepseek/deepseek-v4.1-flash-1017 $0.15/$0.60 (10-17) · z-ai/glm-5.3-prime $1.68/$5.28 (09-23) · z-ai/glm-5.3-flashx-legal (11-02) · qwen/qwen3.8-max-prime $4/$12 (09-23) · meta/muse-ember $0.10/$0.50 (11-09), muse-wonder $4/$20 (10-12), muse-spark-open $1.25/$4.25 (10-15) · qwen/qwen3.8-max-0902 $2/$6 (09-03).
- **Price check vs stated vendor figures (separate claim; vendor pages NOT fetched, so M at best):** OpenRouter lists exactly the figures supplied by the caller: Fable 5.2 $8/$40; Opus 5.5 $4/$20; Sonnet 5.5 $2/$10; Haiku 5.5 $0.10/$0.50; GPT-6.2 Astra $8/$40; GPT-6.2 Sol $2/$10; gemini-4-neon $3/$15; hydrogen $1.50/$7.50; carbon $2/$10. OpenRouter normally passes vendor list price through, so equality is plausible, not proven. **Sonnet 5.5 cache read: OpenRouter still lists $0.10/Mtok (`input_cache_read` "0.0000001") vs Claude Code changelog v2.1.284 $0.20 — discrepancy persists (H for the OR value; the vendor value is unverified here).** Sibling listings: sonnet-5 $0.20, opus-5.5 $0.20, fable-5.2 $0.20 — the 5.5 Sonnet at $0.10 is the outlier. Gemini 4 `input_cache_write` is $0.083–0.1875/Mtok (cheap storage fee, unusual; M).
- **Free models (H):** 11 ids end in `:free` (inclusionai/ling-3.2-flash, baidu/ernie-5.5-flash-preview, liquid/lfm-3-1.7b, particle-ai/particle-1, recursive/flint-v1.0, nvidia/nemotron-3.5-super-vl, -3.5-lightning, -3-ultra-550b-a55b, -3-nano-omni-30b-a3b-reasoning, google/gemma-4-26b-a4b-it, gemma-4-31b-it). 14 entries are zero-priced: those 11 plus `openrouter/free` (the free router, ctx 200K) and google/lyria-3-pro-preview + lyria-3-clip-preview (no `:free` suffix). Free-tier rate limits (20 RPM, 50/day -> 1,000/day) were NOT re-checked.
- **verify_cmd (harmless read-only GET, run):** printed `0` — the docs page no longer matches; the check is stale. See FRONTMATTER_CHANGE. Not-verified: blog posts after 2026-10-08, Stripe deal status, Batch API/In-Region changes, `sort`/`limit` parameter semantics (a `?sort=newest&limit=3` request returned data, `curl: Failed writing body` was only from piping into head).

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
