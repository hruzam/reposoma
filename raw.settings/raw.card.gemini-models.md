---
card: card.gemini-models
brand: Google — Gemini Models & CLI Model Config
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-09-02
half_life: ~6 weeks — line is PARKED, consider longer (see refresh delta)
half_life_days: 45
recheck:
  - https://aistudio.google.com/docs/models
  - https://aistudio.google.com/docs/changelog
  - https://aistudio.google.com/docs/pricing
  - https://aistudio.google.com/docs/deprecations
  - https://geminicli.com/docs/reference/configuration/
  - https://google-gemini.github.io/gemini-cli/docs/get-started/configuration.html
verify_cmd: gemini --version
---

# Gemini Models — selection, stability, CLI model config

## Refresh delta 2026-11-25
PARTIAL: models page, changelog, deprecations page read once; pricing page read 0-100000 of 118372 chars; CLI configuration recheck URLs (geminicli.com, google-gemini.github.io) NOT checked. All three ai.google.dev URLs now 301 to aistudio.google.com/docs/{models,changelog,pricing,deprecations}.

- **Model line moved to Gemini 4.** `gemini-4-carbon`, `gemini-4-neon`, `gemini-4-hydrogen`, `gemini-4-argon` all listed, each 1M context, 64K max output (models page; a "64K / 1M" output cell is ambiguous), modalities text/image/audio/video/PDF. Page gives no GA/Stable label for Gemini 4. SOURCE: aistudio.google.com/docs/models, 2026-11-25. CONFIDENCE: H (ids, ctx); thinking levels and tiers NOT on that page.
- **GA dates (changelog):** Argon Oct 13; Carbon Nov 10; Hydrogen Nov 12; Neon Nov 18. Argon is GA per changelog (the "restricted at first" lead is not borne out; if it was restricted, that is not stated in what I read). SOURCE: aistudio.google.com/docs/changelog. CONFIDENCE: M-H (summarized read).
- **Pricing (standard tier, per 1M in/out):** Carbon and Argon $2/$10 through Nov 30, **$4/$20 from Dec 1 2026** (cache $0.10 -> $0.20), not on free tier. Neon $3/$15, not on free tier. Hydrogen $1.50/$7.50, free tier available. 3.8 Flash $0.75/$3.75 through Dec 31 2026, $1.50/$7.50 from Jan 1 2027, free tier. 3.5 Flash-Lite $0.30/$2.50, free tier. 2.5 Pro $1.25/$10 (<=200k), 2.5 Flash $0.30/$2.50, 2.5 Flash-Lite $0.10/$0.40, all listed free tier. The Dec 1 price rise is first-party, no longer press-only. SOURCE: aistudio.google.com/docs/pricing (first 100k chars), 2026-11-25. CONFIDENCE: H.
- **Thinking levels:** changelog says Neon has four thinking levels (low/medium/high/xhigh per lead); Hydrogen "added an xhigh thinking level". Neon default=high and Hydrogen being Antigravity's default agent model: NOT verified. SOURCE: changelog. CONFIDENCE: M (levels list), L (default claims).
- **Gemini 3.x text status (models page):** `gemini-3.8-flash`, `gemini-3.6-flash`, `gemini-3.5-flash-lite`, `gemini-3.1-flash-lite` = Stable; `gemini-3-flash-preview` = Preview; `gemini-3.1-pro-preview` appears only in the endpoint table (unlabeled). Shut down: `gemini-3.1-flash-lite-preview`, `gemini-3-pro-preview`, `gemini-2.0-flash`, `gemini-2.0-flash-lite`. CONFIDENCE: H.
- **Deprecated 3.x:** `gemini-3.7-flash` -> auto-routes to `gemini-3.8-flash`; `gemini-3.5-flash` -> `gemini-3.6-flash` (deprecations page; changelog Oct 8 only says "newer Flash models"). Both removed from AI Studio. `gemini-3.1-flash-lite` itself deprecated, shutdown May 7 2027 -> `gemini-3.5-flash-lite`. CONFIDENCE: H.
- **2.5 line: no longer a safe stable default.** `gemini-2.5-pro` (-> `gemini-3.8-flash`) and `gemini-2.5-flash` (-> `gemini-3.5-flash-lite`) are deprecated, not selectable in AI Studio, API limited to previously-active users, and **auto-route on 2026-12-01**, billed at the replacement's rates. `gemini-2.5-flash-lite` NOT deprecated ("remains available through the API until further notice"), also limited to prior users; page recommends Gemini 4 Hydrogen or 3.5 Flash-Lite for new work. `gemini-2.5-computer-use-preview-10-2025` shutdown Jul 28 2026 (-> `gemini-3.8-flash`). Changelog entry dated Nov 2 2026. CONFIDENCE: H.
- **Dec 1 "breaking changes" question — SETTLED: the changelog entry DOES say it.** Changelog Nov 2 entry (applies to both models), summarized by the fetcher: "Breaking API changes include function calling and `thought_signature` validation", plus `thinking_level` replacing `thinking_budget`, removed sampling parameters, and no prefilled model turns. Deprecations page (verbatim fragments): "Review the breaking API changes in the Gemini 3.8 Flash migration guide before December 1, 2026" (2.5 Pro) and "...in the Gemini 3.5 Flash-Lite migration guide..." (2.5 Flash); that page does not itemize them. Only the first quoted fragment is verbatim; the list after it is a paraphrase by the fetch summarizer - exact wording of the sampling/prefill items not confirmed. Practical effect: scripts pinned to 2.5-pro/2.5-flash will silently hit different models with a different API contract on Dec 1. CONFIDENCE: M-H.
- **Other (out of card scope, noted):** `genie-4` GA Nov 19 ($1.50 in / $9 text out); tool retrieval preview Nov 19 (`defer_loading`/`tool_search` details NOT read); `gemini-decision-1` + Decisions API Nov 11; `gemini-omni-1.2-flash` GA Nov 5, `gemini-omni-1.1-flash` routes Dec 3; `gemini-embedding-2-preview` -> `gemini-embedding-2` Nov 6; `gemini-3.5-transcribe` voice editing Nov 17; Computer Use GA Oct 30 (Interactions + GenerateContent); `gemini-api` CLI beta Oct 27; Nano Banana 2.1 GA Oct 6, `gemini-3.1-flash-image` deprecated. CONFIDENCE: M.
- **CLI stability:** still no triage data for any 3.6+/4 id in Gemini CLI; Majkee's "prefer 2.5" position is now OVERTAKEN by deprecation, not by evidence of 3.x stability. CLI settings keys (`modelConfigs`) not re-verified. CONFIDENCE: L (gap).

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
| Flash | gemini-3.8-flash, gemini-3.6-flash (3.7-flash and 3.5-flash deprecated) | gemini-2.5-flash | 2.5: ✓ / 3.5-flash REST: ✓ / 3.6-/3.7-flash CLI: UNCONFIRMED |
| Flash-Lite | gemini-3.5-flash-lite, gemini-3.1-flash-lite (deprecated, shutdown 2027-05-07) | gemini-2.5-flash-lite | 2.5: ✓ / 3.x: unknown |
| Computer-use | built into 3.x Flash line (GA 2026-06-24) | gemini-2.5-computer-use-preview-10-2025 (shut down 2026-07-28 → gemini-3.8-flash) | see Flash row |

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
