---
card: card.gemini-models
brand: Google — Gemini Models & CLI Model Config
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-06-27
half_life: ~6 weeks
half_life_days: 45
recheck:
  - https://ai.google.dev/gemini-api/docs/models
  - https://ai.google.dev/gemini-api/docs/changelog
  - https://geminicli.com/docs/reference/configuration/
  - https://google-gemini.github.io/gemini-cli/docs/get-started/configuration.html
verify_cmd: gemini --version
---

# Gemini Models — selection, stability, CLI model config

## Model line guidance (2026-06-27)

### Gemini 2.5 — recommended for stable CLI coding
- Generally Available endpoints; stable schemas, no mid-task dropouts.
- Use for: local terminal automations, complex codebase reasoning, multi-file code execution.

### Gemini 3.x — GA but agentic-first (approach with care for CLI scripting)
- `gemini-3.5-flash` GA since 2026-05-19; `gemini-3.1-pro-preview` still preview.
- Planning/Thinking Mode and native orchestration → higher risk of timeout errors and
  silent fallbacks in simple CLI agent builds.
- Majkee's working position (2026-06-27): prefer 2.5 line for coding tasks until 3.x
  CLI stability is confirmed by experience.

## Model matrix (verified 2026-06-27)

| Grade | Gemini 3.x | Gemini 2.5 (Recommended for CLI) |
|---|---|---|
| Pro | gemini-3.1-pro-preview | gemini-2.5-pro |
| Flash | gemini-3.5-flash (GA) | gemini-2.5-flash |
| Flash-Lite | gemini-3.1-flash-lite (GA) | gemini-2.5-flash-lite |
| Computer-use | gemini-3.5-flash (Computer Use built-in, GA 2026-06-24) | gemini-2.5-computer-use-preview-10-2025 (specialty preview — likely legacy) |

Note: `gemini-3.1-flash` (without -lite), `gemini-3.0-pro`, `gemini-3.5-flash-lite`
not found on official models page — unverified; may be internal or hallucinated.

## CLI env var (confirmed)

Only one env var is officially documented for model control:

```zsh
export GEMINI_MODEL="gemini-2.5-pro"
gemini
```

`GEMINI_AGENT` — tested, has no effect (2026-06-27). Agent selection via `@name` prompt
prefix instead: `gemini "@<name> <task>"`. `GEMINI_STREAM`, `GEMINI_SYSTEM_INSTRUCTION` —
no documentation found; do not use.

## Model tuning — settings.json path (confirmed)

Temperature, context limits, output tokens, and sampling params are configured per-model
in `~/.gemini/settings.json` via `modelConfigs`, **not** via env vars. Env-var names
(`GEMINI_TEMPERATURE`, `GEMINI_MAX_CONTEXT_TOKENS`, `GEMINI_TOP_P` etc.) do not exist —
they are a hallucination from an AI-generated artifact (2026-06-27 session).

```json
{
  "modelConfigs": {
    "gemini-2.5-flash": {
      "temperature": 0.1
    }
  }
}
```

Exact key names inside `modelConfigs`: verify via recheck URLs (geminicli.com/docs/reference/configuration/).

## Honest gap
- External agent invocation method (CLI flag or env var): UNVERIFIED — see gemini-cli card.
- Computer-use 2.5 preview string may be deprecated; Computer Use is now a capability
  inside `gemini-3.5-flash`. Re-verify before scripting against the 2.5 variant.
- This card was seeded from AI-generated substrate (2026-06-27 mail); model IDs cross-checked
  via @Epoch. Model tuning env vars removed as unverified. Re-run @Epoch if automation
  relies on specific API strings.
