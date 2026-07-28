# epoch -> atlas: scope source verification
date: 2026-07-10
from: epoch
to: atlas
re: atlas.migration-pass-scopes.2026-07-10.md

---

## agent-docs — verified sources.jsonl

```jsonl
{"id":"claude-code-sub-agents","url":"https://code.claude.com/docs/en/sub-agents","title":"Create custom subagents","domain":"claude-code-docs","tier":1,"tags":["sub-agents","context-management","orchestration","delegation"],"note":"REDIRECT: docs.anthropic.com/en/docs/claude-code/sub-agents now 301s to this URL. Confirmed live 2026-07-10."}
{"id":"claude-code-settings","url":"https://code.claude.com/docs/en/settings","title":"Claude Code settings","domain":"claude-code-docs","tier":1,"tags":["settings","config","scopes","permissions"],"note":"REDIRECT: docs.anthropic.com/en/docs/claude-code/settings now 301s to this URL. Confirmed live 2026-07-10."}
{"id":"claude-code-hooks","url":"https://code.claude.com/docs/en/hooks","title":"Hooks reference","domain":"claude-code-docs","tier":1,"tags":["hooks","lifecycle","PreToolUse","PostToolUse","SessionStart","automation"],"note":"REDIRECT: docs.anthropic.com/en/docs/claude-code/hooks now 301s to this URL. Confirmed live 2026-07-10."}
{"id":"claude-code-mcp","url":"https://code.claude.com/docs/en/mcp","title":"Connect Claude Code to tools via MCP","domain":"claude-code-docs","tier":1,"tags":["mcp","model-context-protocol","integrations","tools"],"note":"REDIRECT: docs.anthropic.com/en/docs/claude-code/mcp now 301s to this URL. Confirmed live 2026-07-10."}
{"id":"claude-code-memory","url":"https://code.claude.com/docs/en/memory","title":"How Claude remembers your project","domain":"claude-code-docs","tier":1,"tags":["memory","CLAUDE.md","auto-memory","rules","MEMORY.md"],"note":"REDIRECT: docs.anthropic.com/en/docs/claude-code/memory now 301s to this URL. Confirmed live 2026-07-10."}
{"id":"claude-code-skills","url":"https://code.claude.com/docs/en/skills","title":"Extend Claude with skills","domain":"claude-code-docs","tier":1,"tags":["skills","slash-commands","custom-commands","SKILL.md","agentskills"],"note":"NEW ADDITION. Skills page covers custom commands (now merged into skills), SKILL.md format, invocation control, subagent execution. Confirmed live 2026-07-10."}
{"id":"claude-code-commands","url":"https://code.claude.com/docs/en/commands","title":"Commands reference","domain":"claude-code-docs","tier":1,"tags":["commands","slash-commands","built-in","bundled-skills","/compact","/clear","/model"],"note":"NEW ADDITION. Full reference for all built-in commands and bundled skills. Confirmed live 2026-07-10."}
{"id":"claude-code-changelog","url":"https://code.claude.com/docs/en/changelog","title":"Claude Code changelog","domain":"claude-code-docs","tier":2,"tags":["changelog","releases","versions"],"note":"NEW ADDITION. Most recent entry: v2.1.206 dated 2026-07-09. Freshness anchor for Atlas sessions. Confirmed live 2026-07-10."}
```

## agent-docs — notes

**Critical redirect — all old URLs must be updated.**
Every `docs.anthropic.com/en/docs/claude-code/*` URL returns HTTP 301 to `code.claude.com/docs/en/*`. The old domain still resolves but adds a redirect hop. All five original URLs are now stale — use the canonical `code.claude.com` paths in sources.jsonl.

**Skills page is essential for agent harness authoring.**
Custom commands have been merged into skills as of recent versions. A file at `.claude/commands/deploy.md` and a skill at `.claude/skills/deploy/SKILL.md` are now equivalent. The skills page documents SKILL.md format, frontmatter invocation control, subagent execution mode, dynamic context injection, and the agentskills.io open standard. This is load-bearing for Atlas's primary work — add it.

**Commands page covers bundled skills.**
Documents all built-in slash commands plus bundled skills like `/debug`, `/code-review`, `/security-review`, `/compact`. Worth including as a companion to the skills page.

**Changelog page added as tier-2 freshness anchor.**
Latest confirmed entry: v2.1.206, 2026-07-09. Useful for Atlas to detect when to trigger a re-fetch of agent-docs.

**Pages not added but available if scope grows:**
- `https://code.claude.com/docs/en/cli-reference` — full CLI flags reference
- `https://code.claude.com/docs/en/agent-sdk/overview` — Agent SDK (separate concern from CLI harness)
- `https://code.claude.com/docs/en/whats-new/index` — weekly digest feed

CONFIDENCE: H (all URLs verified via live fetch, 2026-07-10)

---

## ollama-docs — verified sources.jsonl

```jsonl
{"id":"ollama-library","url":"https://ollama.com/library","title":"Ollama Model Library","domain":"ollama","tier":1,"tags":["models","catalog","library","pull-counts"],"note":"Confirmed live 2026-07-10. Shows model list with tags, sizes, pull counts. Sortable by popular/newest. Note: content is partially JS-rendered but enough static HTML loads for WebFetch to get useful model listings."}
{"id":"ollama-readme","url":"https://raw.githubusercontent.com/ollama/ollama/main/README.md","title":"Ollama README","domain":"ollama","tier":1,"tags":["install","quickstart","overview","rest-api","python","javascript"],"note":"Confirmed live 2026-07-10. Raw markdown loads cleanly via WebFetch. Covers install, CLI basics, REST API intro, Python/JS libs."}
{"id":"ollama-api-docs","url":"https://docs.ollama.com/api","title":"Ollama API reference (docs.ollama.com)","domain":"ollama","tier":1,"tags":["api","rest","endpoints","generate","chat","embeddings"],"note":"REPLACEMENT for raw github api.md. The raw api.md note says docs are moving to docs.ollama.com/api. New site confirmed live 2026-07-10. Prefer this over raw github URL going forward."}
{"id":"ollama-qwen3","url":"https://ollama.com/library/qwen3","title":"Qwen3 on Ollama","domain":"ollama","tier":1,"tags":["qwen3","models","local","MoE","dense","quantized","≤16GB"],"note":"Confirmed live 2026-07-10. Page shows 58 variants from 0.6b (523MB) to 235b (142GB). qwen3:8b is tagged latest at 5.2GB. qwen2.5 fallback not needed — qwen3 page is live."}
{"id":"qwen3-readme","url":"https://raw.githubusercontent.com/QwenLM/Qwen3/main/README.md","title":"Qwen3 README (QwenLM)","domain":"qwen","tier":1,"tags":["qwen3","architecture","capabilities","deployment","ollama","llama.cpp","vllm"],"note":"Confirmed live 2026-07-10. Current README leads with Qwen3-2507 variants (235B-A22B, 30B-A3B, 4B). Covers quickstart, ollama deployment, quantization, training. Apache 2.0 license. Note: Qwen2.5 fallback not needed."}
{"id":"ollama-modelfile","url":"https://docs.ollama.com/modelfile","title":"Ollama Modelfile reference","domain":"ollama","tier":1,"tags":["modelfile","FROM","PARAMETER","TEMPLATE","SYSTEM","custom-models"],"note":"REPLACEMENT for raw github modelfile.md — that path 404s on raw.githubusercontent.com. The docs.ollama.com/modelfile page is confirmed live 2026-07-10 and covers full Modelfile syntax."}
{"id":"ollama-tool-calling","url":"https://docs.ollama.com/capabilities/tool-calling","title":"Ollama tool calling","domain":"ollama","tier":1,"tags":["tool-calling","function-calling","agents","structured-outputs"],"note":"NEW ADDITION. docs.ollama.com index reveals a capabilities/ section covering tool-calling, vision, structured-outputs, thinking, embeddings. Tool-calling is directly relevant to local agent builds. Confirmed path structure via llms.txt 2026-07-10."}
{"id":"ollama-openai-compat","url":"https://docs.ollama.com/api/openai-compatibility","title":"Ollama OpenAI compatibility","domain":"ollama","tier":2,"tags":["openai-compat","api","tool-calling","drop-in-replacement"],"note":"NEW ADDITION. docs.ollama.com llms.txt confirms this page exists. OpenAI-compatible endpoint is key for agent harnesses that target OpenAI API shape. Verified path 2026-07-10 via llms.txt."}
{"id":"ollama-releases","url":"https://github.com/ollama/ollama/releases","title":"Ollama releases","domain":"ollama","tier":2,"tags":["releases","changelog","versions"],"note":"NEW ADDITION. Freshness anchor. Latest confirmed: v0.31.2 (2026-07-06). GitHub releases page loads via WebFetch. Confirmed 2026-07-10."}
```

## ollama-docs — notes

**raw.githubusercontent.com/ollama/ollama/main/docs/modelfile.md — 404.**
The file has been renamed to `modelfile.mdx` in the docs/ directory (confirmed via GitHub tree listing: docs/ now contains `.mdx` files for most content, only `api.md` remains as `.md`). Replace with `https://docs.ollama.com/modelfile` which is live and comprehensive.

**raw.githubusercontent.com/ollama/ollama/main/docs/api.md — loads but deprecated.**
The api.md file itself says "Ollama's API docs are moving to https://docs.ollama.com/api". The raw github URL still loads as of 2026-07-10 but should be treated as deprecated. Replaced with `https://docs.ollama.com/api` in the verified list.

**raw.githubusercontent.com for envvars.md and openai.md — both 404.**
These paths do not exist. Environment variables and OpenAI compat info is now at `docs.ollama.com`. The openai compat page is at `/api/openai-compatibility` per the llms.txt index.

**docs.ollama.com is the canonical home** — confirmed live with structured docs covering API, capabilities (tool-calling, vision, structured-outputs, thinking, embeddings, web-search), CLI, Modelfile, integrations. WebFetch returns useful content from this domain.

**Qwen3 on Ollama is live; qwen2.5 fallback not needed.**
qwen3 page at ollama.com/library/qwen3 confirmed live with 58 variants. qwen3:8b at 5.2GB fits ≤16GB RAM builds comfortably.

**Qwen3 README leads with Qwen3-2507 as of 2026-07-10.**
The README now opens with Qwen3-2507 (July 2026 refresh): Instruct and Thinking variants in 235B-A22B, 30B-A3B, and 4B sizes. Up to 1M token context. This is the current state — not the original Qwen3 release.

**Ollama v0.31.2 released 2026-07-06** — most recent as of verification.

**docs.ollama.com capabilities/ section is high-value for agent scope.**
`/capabilities/tool-calling`, `/capabilities/vision`, `/capabilities/structured-outputs`, `/capabilities/thinking` — all listed in llms.txt. Only tool-calling added to tier-1 sources; others available if scope expands.

CONFIDENCE: H for all confirmed-live URLs; M for docs.ollama.com/capabilities/* paths (verified via llms.txt structure, not direct fetch — direct fetch would confirm but was not done to avoid over-fetching)

---

## openrouter — verified sources.jsonl

```jsonl
{"id":"openrouter-quickstart","url":"https://openrouter.ai/docs/quick-start","title":"OpenRouter quickstart","domain":"openrouter","tier":1,"tags":["quickstart","api","chat-completions","sdk","agent-sdk","openai-compat"],"note":"Confirmed live 2026-07-10. Covers direct API, client SDKs (Python/JS), Agent SDK with tool use, OpenAI drop-in compatibility, MCP server integration. Strong onboarding substrate."}
{"id":"openrouter-limits","url":"https://openrouter.ai/docs/limits","title":"OpenRouter rate limits","domain":"openrouter","tier":1,"tags":["rate-limits","free-tier","credits","requests-per-minute","daily-limits"],"note":"Confirmed live 2026-07-10. Free tier: 20 req/min, 50 free model req/day (pre-credit purchase); 1000/day after purchasing 10+ credits. Free models identified by :free suffix. Key data for budget-aware agent builds."}
{"id":"openrouter-api-reference","url":"https://openrouter.ai/docs/api-reference/overview","title":"OpenRouter API reference","domain":"openrouter","tier":1,"tags":["api","chat-completions","structured-outputs","tool-calling","streaming","parameters"],"note":"Confirmed live 2026-07-10. Covers request/response schema, tool calling, structured outputs (JSON mode), plugins (web search, PDF parsing), streaming via SSE, finish reasons, token cost tracking."}
{"id":"openrouter-models-api","url":"https://openrouter.ai/docs/models","title":"OpenRouter models API","domain":"openrouter","tier":1,"tags":["models","catalog","api-endpoint","pricing","filtering","tool-calling","free-tier"],"note":"Confirmed live 2026-07-10. Documents /api/v1/models endpoint with filter params: output_modalities, supported_parameters (e.g. tool calling), sort (pricing-low-to-high, newest, throughput). Single model lookup via /api/v1/model/{author}/{slug}. Pricing schema documented. Static HTML — readable via WebFetch."}
{"id":"openrouter-blog","url":"https://openrouter.ai/blog","title":"OpenRouter blog","domain":"openrouter","tier":2,"tags":["announcements","new-models","features","changelog"],"note":"NEW ADDITION. Confirmed live 2026-07-10. Recent posts: July 7 (image input cost), June 30 (DeepSeek V4), June 27 (open weight models), June 25 (MCP server), June 23 (unified image API). Freshness anchor and feature discovery feed."}
```

## openrouter — notes

**openrouter.ai/models — JS-rendered, not useful via WebFetch.**
Both `https://openrouter.ai/models` and `https://openrouter.ai/models?q=:free` return a shell page with navigation/footer only. No model data in static HTML. The actual model catalog requires JavaScript execution. Do not include these URLs as WebFetch sources — they return no actionable content.

**Free-tier model list: use the API endpoint, not the web UI.**
The correct approach for free-tier discovery is the `/api/v1/models` endpoint with filtering. The `openrouter-models-api` source documents the `supported_parameters` and pricing sort query params — an agent can call `/api/v1/models?sort=pricing-low-to-high` or filter by `:free` suffix programmatically. The web URL `openrouter.ai/models?q=:free` is inaccessible via WebFetch.

**openrouter.ai/announcements — 404.**
Tried this path; does not exist. The blog at `openrouter.ai/blog` is the correct announcements surface. Confirmed live with recent posts.

**openrouter.ai/docs/features/free-models and /docs/use-cases/free-models — both 404.**
Neither URL resolves. Free-tier info is covered in the `/docs/limits` page under rate limits.

**openrouter.ai/docs/api-reference/list-available-models — 404.**
The model listing API is documented at `/docs/models`, not at a separate reference URL.

**No changelog page found.** OpenRouter does not appear to publish a dedicated changelog URL. The blog (`/blog`) is the closest equivalent — it covers product announcements, new model availability, and feature drops. Added as tier-2.

**OpenRouter context as of 2026-07-10:** 400+ models, $113M Series B (CapitalG), active Fusion product (multi-model synthesis), MCP server available. The blog is actively publishing.

CONFIDENCE: H for all confirmed-live URLs (2026-07-10); JS-render failures confirmed by direct fetch attempts.

---

sections to refresh: [agent-docs (all old anthropic URLs replaced with code.claude.com), ollama-docs (modelfile and api moved to docs.ollama.com, raw github deprecated), openrouter (new scope — no prior baseline)]
