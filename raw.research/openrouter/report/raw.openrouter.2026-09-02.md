# openrouter — substrate
_Fetched: 2026-09-02 | Window: snapshot (no date filter) | Sources: 5/5_

## openrouter

### openrouter-quickstart
- Unchanged core shape since 2026-07-10: three integration paths — direct API (`/api/v1/chat/completions`), client SDKs (`@openrouter/sdk` TS, `openrouter` Python — auto-generated types from OpenAPI spec), Agent SDK (`@openrouter/agent`, single `callModel` for multi-turn tool-use loops + state management)
- Model alias `~openai/gpt-latest` still documented (auto-resolves to newest flagship)
- MCP server unchanged: `https://mcp.openrouter.ai/mcp`
- Attribution headers `HTTP-Referer` / `X-OpenRouter-Title` unchanged

### openrouter-limits
- No change from 2026-07-10: 20 RPM both tiers; 50 req/day pre-credit; 1,000 req/day after $10+ credit; `:free` suffix; negative balance → 402 (applies even to free models)
- Clarified this run: rate caps apply only to free-model variants; paid variants have no platform-level cap (upstream provider limits may still apply)

### openrouter-api-reference
- No structural change from 2026-07-10 snapshot: OpenAI-compatible schema, `tools`/`tool_choice`, structured outputs (`json_object` / strict `json_schema`), plugins (`web`, `file-parser`, `response-healing`, `context-compression`), SSE streaming, `usage` cost/token breakdown, `/api/v1/generation?id=` for historical cost
- Newly surfaced this run: assistant prefill for response guidance, `prediction` parameter for latency optimization — not called out in the 2026-07-10 substrate (may be new additions or simply not captured last time; treat as CONFIDENCE:M pending diff confirmation)

### openrouter-models-api
- Still "400+ models" (unchanged framing since 2026-07-10, no updated total given)
- Filter/sort params unchanged: `output_modalities`, `supported_parameters`, `sort` (pricing/context/throughput/latency/popularity/newest)
- Free-model discovery: pricing field `"0"` = free (doc phrasing slightly less explicit this run than last — worth re-checking `sort=pricing-low-to-high` guidance is still present)

### openrouter-blog (snapshot — Jun 25 through Sep 2 window)
- **Aug 25** — Model-selection framework by task/budget/timing, with editor integration
- **Aug 25** — Analysis of OpenAI pricing discounts' effect on token consumption
- **Aug 25** — Unified async API guide for video generation across providers
- **Aug 21** — 39 image models compared across 15 challenging prompts
- **Aug 19** — **"OpenRouter is Joining Stripe"** — Stripe agreed to acquire OpenRouter, reported ~$7.5B (~$1.5B to founders); OpenRouter to continue operating independently, product/mission/commitments unchanged. Cross-verified via WebSearch (Stripe newsroom, TechCrunch, Bloomberg, CNBC, Yahoo Finance, PaymentsDive) — CONFIDENCE:H, corroborated by official Stripe announcement + multiple outlets, 2026-08-19.
- **Aug 17** — New spend/usage/request-analytics dashboard
- **Aug 17** — Image-generation workflow tutorial across unified API
- **Aug 14** — Vision guide: sending images via base64/URL
- **Aug 12** — Standardized tool-calling across Python/JS/cURL
- **Aug 12** — Web-search config benchmarks (engines, depth, model performance)
- **Aug 10** — Routing informed by aggregate user model-selection patterns
- **Aug 4** — Integration guide for external AI dev harnesses
- **Aug 3** — Model-evaluation tool for use-case fit
- **Jul 24** — Agent activity/cost monitoring system
- **Jul 13** — Platform visual redesign / branding refresh
- **Jun 25** — MCP server launch (carried from prior snapshot)

## Run metadata
- No items in window: N/A (snapshot mode)
- Feed flags: none — all 5 sources fetched successfully
- Manual-check (not fetched): none
- Within-run convergence: MCP server (openrouter-quickstart URL + openrouter-blog Jun 25 post) — full, unchanged since 2026-07-10
- Major new finding: Stripe acquires OpenRouter (Aug 19) — single-source within sources.jsonl (openrouter-blog) but externally cross-verified via WebSearch, not counted toward in-scope multi-source convergence
