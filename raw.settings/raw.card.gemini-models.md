---
card: card.gemini-models
brand: Google — Gemini Models & CLI Model Config
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-09-02
half_life: ~6 weeks — line is PARKED, consider longer (see refresh delta)
half_life_days: 45
recheck:
  - https://ai.google.dev/gemini-api/docs/models
  - https://ai.google.dev/gemini-api/docs/changelog
  - https://geminicli.com/docs/reference/configuration/
  - https://google-gemini.github.io/gemini-cli/docs/get-started/configuration.html
verify_cmd: gemini --version
---

# Gemini Models — selection, stability, CLI model config

## Refresh delta 2026-09-02
- **Model line moved past 3.5**: `gemini-3.7-flash` and `gemini-3.6-flash` now on
  ai.google.dev/gemini-api/docs/models; `gemini-3.5-flash` reframed "legacy Flash";
  `gemini-3.1-pro-preview` still preview (unchanged). SOURCE: ai.google.dev, 2026-09-02. CONFIDENCE: H.
- **CLI agentic stability of 3.6-/3.7-flash: UNCONFIRMED** — no triage data exists; do not assume
  they inherit the 3.5-flash ⚠/✓ split without re-testing. CONFIDENCE: L (gap, not a claim).
- **Gemini 2.5 line unchanged** (`2.5-pro`/`2.5-flash`/`2.5-flash-lite` GA, still the stable-CLI
  recommendation). Majkee's 2026-06-27 "prefer 2.5" position not re-litigated — no counter-evidence. CONFIDENCE: H.
- **Correction:** `gemini-3.5-flash-lite` IS now confirmed on the models page (card previously
  flagged it unverified). `gemini-3.1-flash` (no -lite) and `gemini-3.0-pro` still not found —
  still unverified. CONFIDENCE: H.
- `gemini-2.5-computer-use-preview-10-2025` still listed (preview), coexists with Computer Use
  now built into the 3.x Flash line. Card's prior "likely legacy" guess not confirmed. CONFIDENCE: M.
- New non-coding model IDs seen but out of this card's scope: `gemini-3.1-flash-image`,
  `gemini-3-pro-image`, `gemini-3.5-transcribe` (GA 2026-08-26). Noted, not tracked further here.

## Model line guidance (2026-06-27 baseline, not re-litigated 2026-09-02)

### Gemini 2.5 — recommended for stable CLI coding
- Generally Available endpoints; stable schemas, no mid-task dropouts.
- Use for: local terminal automations, complex codebase reasoning, multi-file code execution.

### Gemini 3.x — GA but agentic-first (approach with care for CLI scripting)
- `gemini-3.5-flash` GA since 2026-05-19, now "legacy" Flash; `3.6-flash`/`3.7-flash` have since
  shipped (ship dates unverified); `gemini-3.1-pro-preview` still preview.
- Planning/Thinking Mode and native orchestration → higher risk of timeout/silent-fallback in
  simple CLI agent builds (confirmed for 3.5-flash only; newer IDs unverified).
- Majkee's working position (2026-06-27): prefer 2.5 line for coding until 3.x CLI stability is
  confirmed by experience. Still standing default.

## Model matrix (2026-07-03 baseline; model-ID column refreshed 2026-09-02)

| Grade | Gemini 3.x | Gemini 2.5 (Recommended for CLI) | CLI stable? |
|---|---|---|---|
| Pro | gemini-3.1-pro-preview | gemini-2.5-pro | 2.5: ✓ / 3.x: ⚠ (agentic-first) |
| Flash | gemini-3.7-flash, gemini-3.6-flash, gemini-3.5-flash (legacy) | gemini-2.5-flash | 2.5: ✓ / 3.5-flash REST: ✓ / 3.6-/3.7-flash CLI: UNCONFIRMED |
| Flash-Lite | gemini-3.1-flash-lite (GA), gemini-3.5-flash-lite | gemini-2.5-flash-lite | 2.5: ✓ / 3.x: unknown |
| Computer-use | built into 3.x Flash line (GA 2026-06-24) | gemini-2.5-computer-use-preview-10-2025 (still listed, preview) | see Flash row |

CLI stability note (2026-07-03 baseline, NOT re-run 2026-09-02): gemini-3.5-flash returns HTTP 200
via REST (confirmed at the time). ⚠ applied to CLI agentic mode. 2.5 line remains recommended for
CLI automation; re-run stability triage before relying on 3.6-/3.7-flash in scripts.

## CLI env var (confirmed, low-churn — not re-verified this pass)

Only one env var is officially documented for model control:

```zsh
export GEMINI_MODEL="gemini-2.5-pro"
gemini
```

`GEMINI_AGENT` — tested, no effect. Agent selection via `@name` prompt prefix instead:
`gemini "@<name> <task>"`. `GEMINI_STREAM`, `GEMINI_SYSTEM_INSTRUCTION` — undocumented; don't use.

## Model tuning — settings.json path (confirmed, not re-verified this pass)

Temperature, context limits, output tokens, sampling params configured per-model in
`~/.gemini/settings.json` via `modelConfigs`, **not** env vars. Env-var names
(`GEMINI_TEMPERATURE`, `GEMINI_MAX_CONTEXT_TOKENS`, `GEMINI_TOP_P`) do not exist — hallucinated
from an AI-generated artifact (2026-06-27).

```json
{
  "modelConfigs": {
    "gemini-2.5-flash": { "temperature": 0.1 }
  }
}
```

Exact key names inside `modelConfigs`: verify via recheck URLs (geminicli.com/docs/reference/configuration/).

## Honest gap
- External agent invocation method (CLI flag or env var): UNVERIFIED — see gemini-cli card.
- Computer-use 2.5 preview string still listed as of 2026-09-02, not deprecated as previously
  guessed; both preview and 3.x-native Computer Use paths coexist.
- CLI agentic stability of gemini-3.6-flash/3.7-flash: open gap, no triage data — re-run @Epoch
  before scripting against either.
- Seeded from AI-generated substrate (2026-06-27 mail); model IDs cross-checked via @Epoch, most
  recently 2026-09-02 against ai.google.dev/gemini-api/docs/models directly.
</content>
