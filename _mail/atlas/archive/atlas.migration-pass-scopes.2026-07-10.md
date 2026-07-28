# atlas → atlas: migration pass — remaining scopes + fetch-* tombstones
date: 2026-07-10
from: atlas
to: atlas
status: UNREAD
re: refresh skill session (2026-07-09 / 2026-07-10)

## Context (what was done before this task)

`/refresh` skill is live and verified working (`ai-news` scope, two confirmed runs).
Skill shape: `raw.research/<scope>/draft/{README.md, sources.jsonl}` → fetch →
cross-reference (Step 6, N=4 window) → substrate to `report/` → card body run-log.
Card is opt-in (`card:` field in scope README). `persist: ephemeral|canonical|ask`.

Three old skills still live in `~/.claude/skills/` and `ia-sync/claude/skills/`:
- `fetch-agent-docs/SKILL.md` — Claude Code harness docs → `raw.settings/`
- `fetch-ollama-docs/SKILL.md` — Ollama + Qwen local agent docs → `raw.settings/`
- `fetch-qwen-docs/SKILL.md` — Qwen Code CLI + OpenRouter ref → `raw.settings/`

These are the OLD pattern. Tombstone after migration.

## Task: build three scopes + tombstone three skills

Build order: agent-docs → ollama-docs → openrouter → tombstones → archive note.

---

### Scope 1 — `agent-docs`

**Purpose:** Claude Code agent harness reference (sub-agents, settings, hooks, MCP, memory).
This is Zenith's primary substrate — the harness file it reads for Atlas sessions.

**Verified sources (Epoch, 2026-07-10 — all old docs.anthropic.com URLs 301 to code.claude.com):**
```jsonl
{"id":"claude-code-sub-agents","url":"https://code.claude.com/docs/en/sub-agents","title":"Create custom subagents","domain":"claude-code-docs","tier":1,"tags":["sub-agents","context-management","orchestration","delegation"],"note":"REDIRECT: docs.anthropic.com/en/docs/claude-code/sub-agents now 301s to this URL. Confirmed live 2026-07-10."}
{"id":"claude-code-settings","url":"https://code.claude.com/docs/en/settings","title":"Claude Code settings","domain":"claude-code-docs","tier":1,"tags":["settings","config","scopes","permissions"],"note":"REDIRECT: docs.anthropic.com/en/docs/claude-code/settings now 301s to this URL. Confirmed live 2026-07-10."}
{"id":"claude-code-hooks","url":"https://code.claude.com/docs/en/hooks","title":"Hooks reference","domain":"claude-code-docs","tier":1,"tags":["hooks","lifecycle","PreToolUse","PostToolUse","SessionStart","automation"],"note":"REDIRECT: docs.anthropic.com/en/docs/claude-code/hooks now 301s to this URL. Confirmed live 2026-07-10."}
{"id":"claude-code-mcp","url":"https://code.claude.com/docs/en/mcp","title":"Connect Claude Code to tools via MCP","domain":"claude-code-docs","tier":1,"tags":["mcp","model-context-protocol","integrations","tools"],"note":"REDIRECT: docs.anthropic.com/en/docs/claude-code/mcp now 301s to this URL. Confirmed live 2026-07-10."}
{"id":"claude-code-memory","url":"https://code.claude.com/docs/en/memory","title":"How Claude remembers your project","domain":"claude-code-docs","tier":1,"tags":["memory","CLAUDE.md","auto-memory","rules","MEMORY.md"],"note":"REDIRECT: docs.anthropic.com/en/docs/claude-code/memory now 301s to this URL. Confirmed live 2026-07-10."}
{"id":"claude-code-skills","url":"https://code.claude.com/docs/en/skills","title":"Extend Claude with skills","domain":"claude-code-docs","tier":1,"tags":["skills","slash-commands","custom-commands","SKILL.md","agentskills"],"note":"NEW. Skills page covers custom commands (merged into skills), SKILL.md format, invocation control, subagent execution. Load-bearing for Atlas work. Confirmed live 2026-07-10."}
{"id":"claude-code-commands","url":"https://code.claude.com/docs/en/commands","title":"Commands reference","domain":"claude-code-docs","tier":1,"tags":["commands","slash-commands","built-in","bundled-skills","/compact","/clear","/model"],"note":"NEW. Full reference for built-in commands and bundled skills. Confirmed live 2026-07-10."}
{"id":"claude-code-changelog","url":"https://code.claude.com/docs/en/changelog","title":"Claude Code changelog","domain":"claude-code-docs","tier":2,"tags":["changelog","releases","versions"],"note":"NEW. Freshness anchor. Latest entry: v2.1.206 dated 2026-07-09. Confirmed live 2026-07-10."}
```
⚠ All docs.anthropic.com URLs are stale — 301 redirects to code.claude.com. Do not use old domain.
Available but not included (add if scope grows): cli-reference · agent-sdk/overview · whats-new/index.

**Scope README fields:**
```yaml
scope: agent-docs
output_mode: snapshot
persist: canonical
card: raw.settings/raw.card.agent-docs.md
```
No `window_days` (snapshot = full fetch, no date filter).
`persist: canonical` — harness docs are heavy reference material worth carrying
cross-machine. Add `!raw.research/agent-docs/report/` negation to `.gitignore`.

**Substrate output:** `raw.research/agent-docs/report/raw.agent-docs.<YYYY-MM-DD>.md`
Compile sections: YAML frontmatter fields · tool restrictions · permission modes ·
memory modes · hooks structure · MCP syntax · skills · inheritance · CLI flags ·
plugin restrictions · minimal + full annotated examples.

**Card:** `raw.settings/raw.card.agent-docs.md` — run-log format (same as ai-news).
`half_life_days: 30` (docs change on release cadence, not daily).

**Zenith post-migration:** Zenith's routing table already has
`raw.research/agent-docs/report/` as the post-migration path. Once this scope has
its first run and a substrate file exists there, the "(pre-migration)" note in zenith.md
can be cleaned up. Do it in this pass.

---

### Scope 2 — `ollama-docs`

**Purpose:** Ollama + Qwen local agent reference for ≤16GB RAM builds.

**Verified sources (Epoch, 2026-07-10 — two dead URLs replaced, raw github deprecated):**
```jsonl
{"id":"ollama-library","url":"https://ollama.com/library","title":"Ollama Model Library","domain":"ollama","tier":1,"tags":["models","catalog","library","pull-counts"],"note":"Confirmed live 2026-07-10. Partially JS-rendered but enough static HTML for useful WebFetch output."}
{"id":"ollama-readme","url":"https://raw.githubusercontent.com/ollama/ollama/main/README.md","title":"Ollama README","domain":"ollama","tier":1,"tags":["install","quickstart","overview","rest-api","python","javascript"],"note":"Confirmed live 2026-07-10. Raw markdown loads cleanly via WebFetch."}
{"id":"ollama-api-docs","url":"https://docs.ollama.com/api","title":"Ollama API reference","domain":"ollama","tier":1,"tags":["api","rest","endpoints","generate","chat","embeddings"],"note":"REPLACEMENT for raw github api.md (deprecated — file says moving to docs.ollama.com). Confirmed live 2026-07-10."}
{"id":"ollama-qwen3","url":"https://ollama.com/library/qwen3","title":"Qwen3 on Ollama","domain":"ollama","tier":1,"tags":["qwen3","models","local","MoE","dense","quantized","≤16GB"],"note":"Confirmed live 2026-07-10. 58 variants; qwen3:8b at 5.2GB is latest. Fallback to qwen2.5 NOT needed."}
{"id":"qwen3-readme","url":"https://raw.githubusercontent.com/QwenLM/Qwen3/main/README.md","title":"Qwen3 README","domain":"qwen","tier":1,"tags":["qwen3","architecture","capabilities","deployment","ollama","llama.cpp","vllm"],"note":"Confirmed live 2026-07-10. Now leads with Qwen3-2507 (July 2026 refresh): 235B-A22B, 30B-A3B, 4B. Up to 1M token context."}
{"id":"ollama-modelfile","url":"https://docs.ollama.com/modelfile","title":"Ollama Modelfile reference","domain":"ollama","tier":1,"tags":["modelfile","FROM","PARAMETER","TEMPLATE","SYSTEM","custom-models"],"note":"REPLACEMENT — raw github modelfile.md 404s (renamed to .mdx). docs.ollama.com/modelfile confirmed live 2026-07-10."}
{"id":"ollama-tool-calling","url":"https://docs.ollama.com/capabilities/tool-calling","title":"Ollama tool calling","domain":"ollama","tier":1,"tags":["tool-calling","function-calling","agents","structured-outputs"],"note":"NEW. Directly relevant to local agent builds. Confirmed via llms.txt 2026-07-10 (confidence: M — path verified, direct fetch not done)."}
{"id":"ollama-openai-compat","url":"https://docs.ollama.com/api/openai-compatibility","title":"Ollama OpenAI compatibility","domain":"ollama","tier":2,"tags":["openai-compat","api","tool-calling","drop-in-replacement"],"note":"NEW. Confirmed via llms.txt 2026-07-10 (confidence: M). OpenAI-compatible endpoint for agent harnesses."}
{"id":"ollama-releases","url":"https://github.com/ollama/ollama/releases","title":"Ollama releases","domain":"ollama","tier":2,"tags":["releases","changelog","versions"],"note":"NEW. Freshness anchor. Latest: v0.31.2 (2026-07-06). Confirmed live 2026-07-10."}
```
⚠ raw github modelfile.md 404s — use docs.ollama.com/modelfile. github api.md deprecated — use docs.ollama.com/api.

**Scope README fields:**
```yaml
scope: ollama-docs
output_mode: snapshot
persist: ephemeral
```
No `card:` — snapshot only, no synthesis card needed.
No `window_days`.

**Substrate output:** `raw.research/ollama-docs/report/raw.ollama-docs.<YYYY-MM-DD>.md`
Sections to compile (from old skill): 16GB RAM shortlist table · Ollama CLI essentials ·
API endpoints · Modelfile syntax · Qwen family map · agentic use patterns · Arch Linux notes.

---

### Scope 3 — `openrouter`

**Purpose:** OpenRouter model/agent catalog — what's available, free tiers, rates.
Replaces the Qwen-specific `fetch-qwen-docs` with a broader roster.
Roster update is the goal: which models are accessible via OpenRouter for agent use.

**Verified sources (Epoch, 2026-07-10 — new scope, no prior baseline):**
```jsonl
{"id":"openrouter-quickstart","url":"https://openrouter.ai/docs/quick-start","title":"OpenRouter quickstart","domain":"openrouter","tier":1,"tags":["quickstart","api","chat-completions","sdk","agent-sdk","openai-compat"],"note":"Confirmed live 2026-07-10. Covers direct API, Python/JS SDKs, Agent SDK with tool use, MCP server integration."}
{"id":"openrouter-limits","url":"https://openrouter.ai/docs/limits","title":"OpenRouter rate limits","domain":"openrouter","tier":1,"tags":["rate-limits","free-tier","credits","requests-per-minute","daily-limits"],"note":"Confirmed live 2026-07-10. Free tier: 20 req/min, 50 req/day pre-credit; 1000/day after $10+ credit purchase. Free models use :free suffix."}
{"id":"openrouter-api-reference","url":"https://openrouter.ai/docs/api-reference/overview","title":"OpenRouter API reference","domain":"openrouter","tier":1,"tags":["api","chat-completions","structured-outputs","tool-calling","streaming","parameters"],"note":"Confirmed live 2026-07-10. Covers request/response schema, tool calling, structured outputs, plugins, streaming, token cost tracking."}
{"id":"openrouter-models-api","url":"https://openrouter.ai/docs/models","title":"OpenRouter models API","domain":"openrouter","tier":1,"tags":["models","catalog","api-endpoint","pricing","filtering","tool-calling","free-tier"],"note":"Confirmed live 2026-07-10. Documents /api/v1/models endpoint with filter params. Static HTML — readable via WebFetch. Use this for model discovery, NOT the /models UI page."}
{"id":"openrouter-blog","url":"https://openrouter.ai/blog","title":"OpenRouter blog","domain":"openrouter","tier":2,"tags":["announcements","new-models","features","changelog"],"note":"NEW. Confirmed live 2026-07-10. Recent posts: Jul 7 (image input cost), Jun 30 (DeepSeek V4), Jun 25 (MCP server). Freshness anchor."}
```
⚠ openrouter.ai/models and /models?q=:free are JS-rendered shells — return no content via WebFetch. Do NOT include. Use /docs/models (API docs) for model catalog info.
⚠ openrouter.ai/announcements 404s — use /blog instead.

**Scope README fields:**
```yaml
scope: openrouter
output_mode: snapshot
persist: ephemeral
card: raw.settings/raw.card.openrouter.md
```
`half_life_days: 14` (model catalog changes frequently).

**Card run-log:** focus on what changed — new free-tier models, removed models, rate limit
changes. `**Lead:**` = notable model additions/removals. `**Convergence:**` applies as usual
(cross-run changes spotted by look-back). Roster update: after first confirmed run, check
if `triangle.md` or relevant roster file needs a model-availability row updated.

---

### Tombstones

After all three scopes have their first confirmed run, tombstone the old skills.
Pattern (from `hypatia-brief` precedent):

```
---
name: fetch-agent-docs
description: >
  RETIRED — use /refresh agent-docs instead.
  Tombstoned 2026-07-10; migrated to raw.research/agent-docs/ scope.
---
This skill is retired. Use `/refresh agent-docs` to fetch and synthesize
Claude Code harness documentation.
```

Apply same pattern to `fetch-ollama-docs` and `fetch-qwen-docs`.
Update ia-sync after tombstoning (`sync.sh` in `ia-sync/` or equivalent).

---

### Archive old substrate in raw.settings/

Files to archive or remove (check what exists):
- `raw.settings/raw.claude-agents.harness.*.md` → superseded by agent-docs report/
- `raw.settings/raw.ollama-local-agents.*.md` → superseded by ollama-docs report/
- `raw.settings/raw.qwen-openrouter.ref.*.md` → superseded by openrouter report/

These are git-tracked. Options: `git rm` (clean) or move to an `archive/` subfolder
(operator adds to .gitignore). Operator decides — flag at end of session.

---

### Zenith cleanup

After agent-docs scope has a substrate file in `raw.research/agent-docs/report/`,
remove the `(pre-migration)` qualifier from Zenith's routing table row for harness docs.
Small edit to `~/.claude/agents/zenith.md`.

---

## Standing constraints

- `draft/` + `report/` structure per scope (no exceptions)
- `persist:` field in every scope README
- Card opt-in: only if `card:` present in README
- Tombstone only after first confirmed run per scope (not before)
- Scope fence from Oraculum still holds: no new agents, no new storage layer
- Do not add Chris KE to ai-news sources.jsonl (pending majkee confirmation)
