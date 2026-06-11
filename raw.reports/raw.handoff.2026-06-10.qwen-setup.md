---
kind: session-handoff
date: 2026-06-10
topic: Qwen Code CLI + OpenRouter — diagnosis, skill, guide
status: complete, pushed to core
---

## What was done this session

### 1. Diagnosed qwen CLI failures from debug logs

Read all sessions in `~/.qwen/debug/`. Three failure patterns identified:

| Session | Failure | Root cause |
|---|---|---|
| `cddd325e` | Model never loaded | `"openrouter"` used as modelProviders key — invalid, silently skipped |
| `0ec325e0`, `b2d5f083`, `6fb57ce8` | 15-min hang → 404 | Free tier 429 rate limit + exponential backoff; terminal looked frozen |

**Conclusion:** `~/.qwen/settings.json` is now correctly structured (`"openai"` authType, key in env block). The hang is purely OpenRouter free-tier quota exhaustion, not misconfiguration.

### 2. Wrote skill: `fetch-qwen-docs`

Path: `~/.claude/skills/fetch-qwen-docs/SKILL.md`  
Activation: `/fetch-qwen-docs` or `/fetch-qwen-docs diagnose`  
Tools: `WebFetch`, `Read`, `Write`

- **Mode A (default):** Fetches qwen-code GitHub README + OpenRouter docs (limits, model IDs, authType table), saves dated snapshot to `/home/hruzam/reposoma/raw.settings/raw.qwen-openrouter.ref.<date>.md`
- **Mode B (diagnose):** Reads latest `~/.qwen/debug/` log, matches known failure patterns, returns one-line root cause + fix

### 3. Wrote operational guide

Path: `~/reposoma/guides.qwen/openrouter-setup.md`  
Content: correct `settings.json` structure with field rules, all known failure modes with log signatures and fixes, key wiring table across CLI family (qwen / claude / OPENAI_API_KEY), model alternatives when free quota exhausted, quick health check one-liners, list of harmless log noise to ignore.

### 4. Deleted `guides.qwen/install.md`

That file was an AI-generated dump (captured from a qwen session's context) containing the broken `"openrouter"` authType pattern. Removed to prevent future confusion.

### 5. Committed and pushed

Branch: `core` | Repo: `hruzam/reposoma` | Commit: `d53d409`  
Message: `guides.qwen: remove stale install.md, add openrouter-setup.md`

---

## State of `~/.qwen/settings.json` at session end

```json
{
  "$version": 4,
  "env": {
    "QWEN_CUSTOM_API_KEY_OPENAI_HTTPS_OPENROUTER_AI_API_V1_D2BFDF91BF27": "sk-or-v1-..."
  },
  "modelProviders": {
    "openai": [
      {
        "id": "qwen/qwen3-coder:free",
        "name": "qwen/qwen3-coder:free",
        "baseUrl": "https://openrouter.ai/api/v1",
        "envKey": "QWEN_CUSTOM_API_KEY_OPENAI_HTTPS_OPENROUTER_AI_API_V1_D2BFDF91BF27"
      }
    ]
  },
  "security": { "auth": { "selectedType": "openai" } },
  "model": { "name": "qwen/qwen3-coder:free" }
}
```

---

## What is NOT done / open

- No raw snapshot yet in `raw.settings/raw.qwen-openrouter.ref.*.md` — `/fetch-qwen-docs` has not been run yet; run it to populate the RAG reference
- Free tier quota problem is not solved — consider adding OpenRouter credit or switching to a less-congested `:free` model variant when quota is exhausted
- `secrets.zsh` does NOT export `OPENROUTER_API_KEY` — only `PIQL_API_KEY` and `OPENAI_API_KEY`; add `export OPENROUTER_API_KEY="$PIQL_API_KEY"` if any tool specifically requires that var name

---

## Key paths touched this session

| Path | Status |
|---|---|
| `~/.claude/skills/fetch-qwen-docs/SKILL.md` | created |
| `~/reposoma/guides.qwen/openrouter-setup.md` | created, pushed |
| `~/reposoma/guides.qwen/install.md` | deleted, pushed |
| `~/.qwen/settings.json` | read-only (not modified) |
| `~/.config/zsh/.env/secrets.zsh` | read-only (not modified) |
