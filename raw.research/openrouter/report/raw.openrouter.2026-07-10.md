# openrouter — substrate
_Fetched: 2026-07-10 | Window: snapshot (no date filter) | Sources: 5/5_

## openrouter

### openrouter-quickstart
- Three integration paths: direct API (`/api/v1/chat/completions`), client SDKs (TypeScript `@openrouter/sdk`, Python `openrouter`), Agent SDK (`@openrouter/agent`) for multi-turn tool-use loops with Zod schemas
- OpenAI SDK drop-in: point base URL at OpenRouter
- MCP server: `https://mcp.openrouter.ai/mcp` — coding agents access live catalog/pricing/credits without local install
- Model alias: `~openai/gpt-latest` auto-resolves to newest flagship
- Auth: bearer token; optional `HTTP-Referer` + `X-OpenRouter-Title` for attribution/leaderboard

### openrouter-limits
- Free tier: 20 RPM, 50 req/day pre-credit, 1,000 req/day after $10+ credit purchase
- Free model suffix: `:free`
- Negative balance → 402 Payment Required
- Credit check: `GET /api/v1/key` — returns balance, usage (all-time/daily/weekly/monthly), BYOK status, free-tier flag
- Multiple API keys do not help — limits governed globally (Cloudflare DDoS protection layer)

### openrouter-api-reference
- OpenAI-compatible schema; OpenAPI spec available in YAML/JSON
- Request: `messages` or `prompt` required; `model`, `response_format`, `stream`, `max_tokens`, `temperature`, `top_p`, `top_k`
- Tool calling: `tools` + `tool_choice` arrays
- Plugins: `web`, `file-parser`, `response-healing`, `context-compression`
- Provider routing: `provider` preferences object + `models` fallback array
- Structured outputs: `{ type: 'json_object' }` (basic) or `{ type: 'json_schema', json_schema: {...} }` (strict)
- Response `usage` object: prompt/completion/total tokens + cached/audio/reasoning token breakdowns + cost in credits + BYOK status
- `native_finish_reason` alongside normalized finish reasons (`stop`, `tool_calls`, `length`, `content_filter`, `error`)
- Historical cost: `GET /api/v1/generation?id=<response-id>`
- Optional headers: `HTTP-Referer`, `X-OpenRouter-Title`, `X-OpenRouter-Categories`

### openrouter-models-api
- 400+ models across providers
- Endpoint: `GET /api/v1/models`
- Filter params:
  - `output_modalities`: text (default) / image / audio / embeddings / all
  - `supported_parameters`: e.g. `tools` for function calling
  - `sort`: pricing-low-to-high, pricing-high-to-low, context-high-to-low, throughput-high-to-low, latency-low-to-high, most-popular, top-weekly, newest
- Model fields: `id`, `context_length`, `pricing` (prompt/completion/request/caching/web-search), `supported_parameters`, `architecture` (modalities/tokenizer/instruction-format), `benchmarks` (Design Arena)
- Free models: `pricing` fields = `"0"`; use `sort=pricing-low-to-high` to surface them
- Single model: `GET /api/v1/model/{author}/{slug}` — auto-resolves `:free`, `:thinking` suffixes and aliases

### openrouter-blog (full snapshot)
- **Jul 7** — Image input detail vs. reasoning effort: reducing detail level hurts accuracy; reasoning effort is the reliable cost lever (1,730 visual reasoning task study)
- **Jun 30** — DeepSeek V4 Flash: strong agentic workload adoption over 6 months on OpenRouter
- **Jun 27** — Open-weight models June 2026: four leading models from new Chinese + US labs, guidance on when to use each
- **Jun 25** — MCP Server launch: `mcp.openrouter.ai/mcp` — live catalog, benchmarks, docs, test inference in editor
- **Jun 23** — Unified Image API: 30+ image models, 8 providers, single endpoint, capability discovery
- **Jun 22** — AI Governance: three routing postures for LLM stack compliance auditing
- **Jun 22** — Data Residency: enforce via API routing constraints, not local infra
- **Jun 19** — vs Portkey: credit-based multi-provider routing vs. key-governance comparison
- **Jun 19** — vs LiteLLM: managed gateway vs. self-hosted proxy comparison
- **Jun 18** — OpenClaw integration: 300+ models, unified billing, automatic failover
- **Jun 16** — Subagent: model delegates subtasks to a sub-model call within agentic pipeline
- **Jun 12** — Fusion beats frontier: budget model panel outscores GPT-5.5 + Claude Opus 4.8 on 100 research tasks
- **Jun 10** — Advisor: model escalates to smarter model on demand
- **Jun 1** — May Release Spotlight: speech/transcription, Fusion, private models, enterprise controls; 20 new models incl. Gemini 3.5 Flash, Claude Opus 4.8
- **May 29** — Guardrails: agent/data/cost protection layer
- **May 28** — $113M Series B: CapitalG lead, NVentures, Databricks Ventures
- **May 7** — Consistent web search/fetch across all models
- **May 1** — Speech/transcription Audio APIs

## Run metadata
- No items in window: N/A (snapshot mode)
- Feed flags: none — all 5 sources fetched successfully
- Manual-check (not fetched): none
- Within-run convergence: MCP server (openrouter-quickstart URL + openrouter-blog Jun 25 post) — full
