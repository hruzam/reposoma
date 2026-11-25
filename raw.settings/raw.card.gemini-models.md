---
card: card.gemini-models
brand: Google — Gemini Models & CLI Model Config
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-11-25
half_life: ~6 weeks — line is PARKED, consider longer (see refresh delta)
half_life_days: 45
recheck:
  - https://aistudio.google.com/docs/models
  - https://aistudio.google.com/docs/changelog
  - https://aistudio.google.com/docs/pricing
  - https://aistudio.google.com/docs/deprecations
  - https://geminicli.com/docs/reference/configuration/
  - https://geminicli.com/docs/cli/model/
verify_cmd: gemini --version
---

# Gemini Models — selection, stability, CLI model config

## Refresh delta 2026-11-25
All sources read this pass (aistudio.google.com/docs/{models,changelog,pricing,deprecations} + per-model pages gemini-4-{neon,hydrogen,carbon,argon}; geminicli.com/docs/reference/configuration/ full; geminicli.com/docs/cli/model/; google-gemini.github.io config page). Fetches were summarized by a small model, so quotes are fragments (line-wrapped); the ai.google.dev URLs 301 to aistudio.google.com/docs/*. Labels: H = first-party page read this run; M = summarized/fragment; L = inference.

### Facts (first-party)
- **Gemini 4 line.** `gemini-4-carbon`, `gemini-4-neon`, `gemini-4-hydrogen`, `gemini-4-argon`: context 1,048,576 (unified in+out); max output 65,536 default sync, up to 1,048,576 with long decode. Modalities text/image/audio/video/PDF. SOURCE: aistudio.google.com/docs/models + per-model pages, 2026-11-25. H.
- **Status labels.** Neon page: "Stable: `gemini-4-neon`". Hydrogen page: "Stable: `gemini-4-hydrogen`" (its Tool retrieval row is "Supported (Preview)"). Carbon and Argon pages show no separate status label; the main models page shows no badge for any Gemini 4 card. H.
- **Thinking levels.** Neon and Hydrogen: "Supported (low, medium, high, xhigh)". Carbon and Argon: "Supported (low, medium, high)" (no xhigh). Defaults: changelog Nov 18 (Neon) fragment "`low`, `medium`, default `high`, and `xhigh`"; changelog Nov 12 (Hydrogen) fragment "introduces a fourth `xhigh` thinking level alongside `low`, `medium`, and default `high`". So Neon and Hydrogen default = `high`. Carbon/Argon default NOT stated on any page read. The per-model pages do not state a default. H (levels), M (defaults, changelog fragments).
- **Hydrogen and Antigravity.** Changelog Nov 12 fragment: "is now the default model for the Antigravity agent in Gemini Managed Agents". Note the scope: Gemini Managed Agents (API), NOT proven for Antigravity CLI/IDE defaults. M.
- **GA dates (changelog):** Argon Oct 13; Carbon Nov 10; Hydrogen Nov 12; Neon Nov 18. M-H.
- **Free tier / prices (standard, per 1M in/out):** Carbon $2/$10 through Nov 30, **$4/$20 from Dec 1 2026** (cache $0.10 -> $0.20), NOT free tier (per-model page: "Gemini 4 Carbon is not available on the Free tier"). Argon same price path, NOT free tier. Neon $3/$15, NOT free tier. Hydrogen $1.50/$7.50, free tier ("Free of charge" input/output/caching; grounding not available on free). `gemini-3.8-flash` $0.75/$3.75 through Dec 31 2026, $1.50/$7.50 from Jan 1 2027, free tier. `gemini-3.5-flash-lite` $0.30/$2.50, free. 2.5 Pro $1.25/$10 (<=200k), 2.5 Flash $0.30/$2.50, 2.5 Flash-Lite $0.10/$0.40, all listed free tier. Pricing page tail (chars 100000-118372) contains no Gemini 4/3.8/2.5 rates (only tools table: Computer use = regular token pricing per Gemini 3.8 Flash; Gemma 4 free). SOURCE: aistudio.google.com/docs/pricing. H.
- **Tool retrieval (Preview, changelog Nov 19).** Fragments: "Mark tools with `defer_loading: true` and add a `{"type": "tool_search"}` tool to let Gemini retrieve" (tools on demand); `execution: "client"` lets you run your own retrieval logic instead. Hydrogen's model page marks Tool retrieval "Supported (Preview)". Neon/Carbon/Argon support not confirmed. Full schema NOT read. M.
- **Gemini 3.x status (models page):** `gemini-3.8-flash`, `gemini-3.6-flash`, `gemini-3.5-flash-lite`, `gemini-3.1-flash-lite` = Stable; `gemini-3-flash-preview` = Preview; `gemini-3.1-pro-preview` only in endpoint table (unlabeled). Shut down: `gemini-3.1-flash-lite-preview`, `gemini-3-pro-preview`, `gemini-2.0-flash`, `gemini-2.0-flash-lite`. H.
- **Deprecated 3.x:** `gemini-3.7-flash` -> `gemini-3.8-flash`; `gemini-3.5-flash` -> `gemini-3.6-flash` (deprecations page). `gemini-3.1-flash-lite` deprecated, shutdown May 7 2027 -> `gemini-3.5-flash-lite`. H.
- **2.5 deprecation (changelog entry dated Nov 2 2026, "Gemini 2.5 deprecations").** Fragments: "Effective December 1, 2026, all API requests to `gemini-2.5-pro` will automatically route to" `gemini-3.8-flash`; same sentence for `gemini-2.5-flash` -> `gemini-3.5-flash-lite`; both say update the model string before Dec 1 and review the migration guide. Breaking changes (joined fragments, line breaks lost): "Breaking API changes include function calling and `thought_signature` validation, `thinking_level` replacing `thinking_budget`, and removed sampling parameters and prefilled model turns." The deprecations page does not itemize them ("Review the breaking API changes in the Gemini 3.8 Flash migration guide before December 1, 2026"). Both models are not selectable in AI Studio; API limited to previously-active users; billed at the replacement's rates. `gemini-2.5-flash-lite` is NOT deprecated ("remains available through the API until further notice"); page recommends Gemini 4 Hydrogen or 3.5 Flash-Lite for new work. `gemini-2.5-computer-use-preview-10-2025` shut down Jul 28 2026 (-> `gemini-3.8-flash`). H (entry exists/dates/targets), M (exact breaking-change wording: fragment-joined).
- **Gemini CLI model support (geminicli.com).** `/model` dialog Auto options: "Auto (Gemini 3)" = `gemini-3-pro-preview` + `gemini-3-flash-preview`; "Auto (Gemini 2.5)" = `gemini-2.5-pro` + `gemini-2.5-flash`; Manual = any available model; page "recommend[s] selecting one of the above Auto options" and names no default. Config page lists model ids: `gemini-3-pro-preview`, `gemini-3-flash-preview`, `gemini-3.1-pro-preview`, `gemini-3.1-pro-preview-customtools`, `gemini-3.1-flash-lite-preview`, `gemini-3.1-flash-lite`, `gemini-3.5-flash-lite`, `gemini-3.5-flash`, `gemini-3.8-flash`, `gemini-2.5-pro`, `gemini-2.5-flash`, `gemini-2.5-flash-lite`, `gemma-4-31b-it`, `gemma-4-26b-a4b-it`. `gemini-3.6-flash` and `gemini-3.7-flash` NOT in that list; NO Gemini 4 id: "Gemini CLI has not been optimized for Gemini 4 Argon" (directs users to Antigravity). The docs also state Gemini CLI was replaced by Antigravity CLI on June 18th 2026 for unpaid tier and Google One users. H for list (docs lag the API: several listed ids are shut down or deprecated, e.g. `gemini-3-pro-preview`, `gemini-3.1-flash-lite-preview`, `gemini-3.5-flash`), M for the Antigravity-replacement sentence.
- **`modelConfigs` keys (geminicli.com configuration reference).** `aliases`, `customAliases`, `customOverrides`, `overrides`, `modelDefinitions`, `modelIdResolutions`, `classifierIdResolutions`, `modelChains`. Presets live under `aliases`/`customAliases`; each preset has `modelConfig` -> `model` + `generateContentConfig` (`temperature`, `topP`, `topK`, `thinkingConfig`) and may `extends` another alias (e.g. `chat-base-3`). `customOverrides`/`overrides` default `[]`; entry schema not given. The card's old example (`modelConfigs: { "gemini-2.5-flash": { temperature } }`) does NOT match this shape. Top-level `model.name` (plus `model.maxSessionTurns`, `model.chatCompression.contextPercentageThreshold`) per the older github.io page; `--model <id>` flag per configuration reference. H (keys), M (example is illustrative per the fetcher).

### Gemini 4 matrix (card style)

| Model | ID | Ctx / max out | Price in/out per 1M | Free tier | Thinking | GA |
|---|---|---|---|---|---|---|
| Argon | gemini-4-argon | 1,048,576 / 65,536 (1,048,576 long decode) | $2/$10 to Nov 30; $4/$20 from Dec 1 | no | low/med/high | Oct 13 |
| Carbon | gemini-4-carbon | same | $2/$10 to Nov 30; $4/$20 from Dec 1 | no | low/med/high | Nov 10 |
| Hydrogen | gemini-4-hydrogen | same | $1.50/$7.50 | yes | low/med/high/xhigh (default high) | Nov 12 |
| Neon | gemini-4-neon | same | $3/$15 | no | low/med/high/xhigh (default high) | Nov 18 |

CLI status of all four: not supported/optimized in Gemini CLI (docs say so for Argon, no Gemini 4 id listed). H.

### Position change (decision delegated to @Epoch by @majkee, 2026-11-25)
- **Superseded:** the "prefer 2.5 / stable default for CLI coding" stance (Majkee, 2026-06-27) is overtaken by the Nov 2 deprecation notice, not by evidence of 3.x CLI stability. It is retained as history in the guidance section, marked superseded; re-decide if desired.
- **INFERENCE (L-M, not tested):** for CLI coding, the nearest stable successors are `gemini-3.8-flash` (stable, free tier, listed in the CLI config page, and the API's own auto-route target for 2.5-pro) and `gemini-3.5-flash-lite` (stable, free, listed; target of 2.5-flash). `gemini-2.5-flash-lite` is the only 2.5 id with no announced end date, but is limited to prior users. Do not pin scripts to `gemini-2.5-pro`/`gemini-2.5-flash` past Nov 30: from Dec 1 they hit other models under a different API contract (function calling / `thought_signature` validation, `thinking_level` replacing `thinking_budget`, removed sampling params and prefilled turns). If CLI agentic behaviour on 3.8-flash matters, re-run stability triage; no triage data exists for any 3.6+/4 id. Gemini 4 (Hydrogen has free tier) is the API's recommended target for new work, but Gemini CLI is not optimized for it (docs name Argon) and unpaid/Google One users were moved to Antigravity CLI.

### Still unverified
- Carbon/Argon default thinking level (not stated).
- Whether Hydrogen is the default for Antigravity CLI/IDE (only Gemini Managed Agents stated).
- `tool_search`/`defer_loading` schema and which Gemini 4 models support it beyond Hydrogen.
- Exact verbatim Dec 1 text (fragments joined from line-wrapped quotes).
- `gemini-3.1-pro-preview` status; CLI behaviour of any 3.6+/4 id; whether the CLI auto-migrates removed ids.

## Refresh delta 2026-09-02
- **Model line moved past 3.5**: `gemini-3.7-flash` and `gemini-3.6-flash` now on
  ai.google.dev/gemini-api/docs/models; `gemini-3.5-flash` reframed "legacy Flash";
  `gemini-3.1-pro-preview` still preview (unchanged). SOURCE: ai.google.dev, 2026-09-02. CONFIDENCE: H.
- **CLI agentic stability of 3.6-/3.7-flash: UNCONFIRMED** — no triage data exists; do not assume
  they inherit the 3.5-flash ⚠/✓ split without re-testing. CONFIDENCE: L (gap, not a claim).
- **[SUPERSEDED 2026-11-25 — see Refresh delta 2026-11-25]** ~~Gemini 2.5 line unchanged (`2.5-pro`/`2.5-flash`/`2.5-flash-lite` GA, still the stable-CLI
  recommendation). Majkee's 2026-06-27 "prefer 2.5" position not re-litigated — no counter-evidence.~~ `2.5-pro`/`2.5-flash` deprecated 2026-11-02, auto-route 2026-12-01. CONFIDENCE (original): H as of 2026-09-02.
- **Correction:** `gemini-3.5-flash-lite` IS now confirmed on the models page (card previously
  flagged it unverified). `gemini-3.1-flash` (no -lite) and `gemini-3.0-pro` still not found —
  still unverified. CONFIDENCE: H.
- `gemini-2.5-computer-use-preview-10-2025` still listed (preview), coexists with Computer Use
  now built into the 3.x Flash line. Card's prior "likely legacy" guess not confirmed. CONFIDENCE: M.
- New non-coding model IDs seen but out of this card's scope: `gemini-3.1-flash-image`,
  `gemini-3-pro-image`, `gemini-3.5-transcribe` (GA 2026-08-26). Noted, not tracked further here.

## Model line guidance (2026-06-27 baseline; stance superseded 2026-11-25)

### Gemini 2.5 — DEPRECATED (pro/flash); was "recommended for stable CLI coding"
- FACT (H, aistudio.google.com/docs/changelog + /docs/deprecations, 2026-11-25): `gemini-2.5-pro` -> `gemini-3.8-flash` and `gemini-2.5-flash` -> `gemini-3.5-flash-lite` auto-route on 2026-12-01 (entry dated 2026-11-02). `gemini-2.5-flash-lite` NOT deprecated ("remains available through the API until further notice"). All 2.5 ids limited to previously-active users.
- FACT (M, changelog fragments joined): "Breaking API changes include function calling and `thought_signature` validation, `thinking_level` replacing `thinking_budget`, and removed sampling parameters and prefilled model turns."
- HISTORY (2026-06-27/09-02): "Generally Available endpoints; stable schemas, no mid-task dropouts. Use for: local terminal automations, complex codebase reasoning, multi-file code execution." No longer a safe default for pro/flash.

### Gemini 3.x — Stable Flash line, agentic-first (approach with care for CLI scripting)
- Stable per models page 2026-11-25 (H): `gemini-3.8-flash`, `gemini-3.6-flash`, `gemini-3.5-flash-lite`, `gemini-3.1-flash-lite` (deprecated, shutdown 2027-05-07). Deprecated: `gemini-3.7-flash` -> 3.8-flash, `gemini-3.5-flash` -> 3.6-flash. `gemini-3.1-pro-preview` unlabeled on models page.
- Planning/Thinking Mode and native orchestration → higher risk of timeout/silent-fallback in
  simple CLI agent builds (confirmed for 3.5-flash only; newer IDs unverified).
- INFERENCE (L-M, untested): for CLI coding the nearest stable replacements are `gemini-3.8-flash` (for 2.5-pro) and `gemini-3.5-flash-lite` (for 2.5-flash); both are listed on the Gemini CLI config page. Re-run CLI stability triage before scripting against them.

### Gemini 4 — new line (Argon, Carbon, Hydrogen, Neon)
- Neon and Hydrogen "Stable" on their model pages; Carbon/Argon unlabeled. Not supported/optimized in Gemini CLI ("Gemini CLI has not been optimized for Gemini 4 Argon"; Antigravity is the pointed surface). See Refresh delta 2026-11-25 for ids, prices, free tier.

### Majkee's working position — SUPERSEDED by deprecation notice 2026-11-02; re-decide if desired
- Original (2026-06-27): prefer 2.5 line for coding until 3.x CLI stability is
  confirmed by experience. Was the standing default; overtaken by deprecation, not by evidence of 3.x stability.

## Model matrix (2026-07-03 baseline; model-ID column refreshed 2026-11-25)

| Grade | Gemini 4 | Gemini 3.x | Gemini 2.5 (pro/flash DEPRECATED, route 2026-12-01) | CLI stable? |
|---|---|---|---|---|
| Pro | gemini-4-neon ($3/$15, paid), gemini-4-carbon / gemini-4-argon ($2/$10 to Nov 30, $4/$20 from Dec 1; paid) | gemini-3.1-pro-preview | gemini-2.5-pro (deprecated → gemini-3.8-flash, 2026-12-01) | 4: not optimized in CLI / 2.5: superseded / 3.x: ⚠ (agentic-first) |
| Flash | gemini-4-hydrogen ($1.50/$7.50, free tier) | gemini-3.8-flash, gemini-3.6-flash (3.7-flash and 3.5-flash deprecated) | gemini-2.5-flash (deprecated → gemini-3.5-flash-lite, 2026-12-01) | 3.5-flash REST: ✓ / 3.6-/3.8-flash CLI: UNCONFIRMED |
| Flash-Lite | — | gemini-3.5-flash-lite, gemini-3.1-flash-lite (deprecated, shutdown 2027-05-07) | gemini-2.5-flash-lite (NOT deprecated; prior users only) | 3.x: unknown |
(Grade placement of Gemini 4 ids is INFERENCE by price/thinking tier — Google does not label them Pro/Flash. L.)
| Computer-use | Computer Use GA 2026-10-30 (changelog; M) | built into 3.x Flash line (GA 2026-06-24) | gemini-2.5-computer-use-preview-10-2025 (shut down 2026-07-28 → gemini-3.8-flash) | see Flash row |

CLI stability note (2026-07-03 baseline, NOT re-run since): gemini-3.5-flash returned HTTP 200
via REST (confirmed at the time). ⚠ applied to CLI agentic mode. The earlier "2.5 remains
recommended for CLI automation" is SUPERSEDED (2.5-pro/2.5-flash auto-route 2026-12-01); re-run
stability triage before relying on 3.6-/3.8-flash or any Gemini 4 id in scripts.

## CLI env var (confirmed, low-churn — not re-verified this pass)

Only one env var is officially documented for model control:

```zsh
export GEMINI_MODEL="gemini-3.8-flash"   # example id; gemini-2.5-pro auto-routes to this on 2026-12-01
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
    "customAliases": {
      "my-flash": {
        "extends": "chat-base-3",
        "modelConfig": {
          "model": "gemini-3.8-flash",
          "generateContentConfig": { "temperature": 0.1 }
        }
      }
    }
  }
}
```

Keys verified 2026-11-25 (geminicli.com/docs/reference/configuration/, H; example is illustrative, adapted from the page's own `customAliases` example — the previous per-model-id shape did NOT match the docs): `modelConfigs.{aliases, customAliases, customOverrides, overrides, modelDefinitions, modelIdResolutions, classifierIdResolutions, modelChains}`; alias entries use `modelConfig.model` + `generateContentConfig.{temperature, topP, topK, thinkingConfig}` and optional `extends`. `overrides`/`customOverrides` entry schema not documented there.

## Honest gap
- External agent invocation method (CLI flag or env var): UNVERIFIED — see gemini-cli card.
- Computer-use 2.5 preview string `gemini-2.5-computer-use-preview-10-2025` shut down 2026-07-28 (-> gemini-3.8-flash) per deprecations page (H, 2026-11-25); the 2026-09-02 "still listed, not deprecated" note was wrong/stale.
- CLI agentic stability of gemini-3.6-flash/3.8-flash and all Gemini 4 ids: open gap, no triage data — re-run @Epoch
  before scripting against any. Gemini CLI docs lag the API (still list shut-down/deprecated ids) and say it is not optimized for Gemini 4; unpaid/Google One users were moved to Antigravity CLI (2026-06-18, M).
- Gemini 4 Carbon/Argon default thinking level; tool_search/defer_loading schema: unverified (2026-11-25).
- Seeded from AI-generated substrate (2026-06-27 mail); model IDs cross-checked via @Epoch, most
  recently 2026-11-25 against aistudio.google.com/docs/{models,changelog,pricing,deprecations} directly
  (ai.google.dev URLs now 301 there).
</content>
