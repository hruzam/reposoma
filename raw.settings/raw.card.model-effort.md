---
card: card.model-effort
brand: "Anthropic — Claude · OpenAI — Codex (cross-vendor)"
kind: "knowledge-card · RELATIVE (volatile) · render.settings — model + effort per exact route"
verified: 2026-11-25
half_life: ~2 weeks
half_life_days: 14
recheck:
  - https://developers.openai.com/api/docs/models
  - https://learn.chatgpt.com/docs/models
  - https://platform.claude.com/docs/en/models/overview
  - https://code.claude.com/docs/en/model-config
  - https://platform.claude.com/docs/en/build-with-claude/effort
verify_cmd: "`codex debug models` (zero quota) · `claude --version`"
# GAVEL-ONLY — the recalibration researcher refreshes verified/evidence/candidates and PROPOSES pin changes; active_pins changes only on majkee's gavel after a witnessed probe. Renderers read active_pins only.
active_pins:
  claude/houston:
    model: opus
    effort: high
    status: active
    gavel: "majkee 2026-10-10 final fold (~/ia-sync/claude/agents/houston.md); majkee 2026-10-13 GO (witnessed)"
    witness: "~/ia-sync/.dev/session/germline-01-builds-and-deploy/raw/witness.install-test.assay.2026-10-13.md (C2/C3: claude-opus-5-5 · effort high in subagent jsonl; C1/C4: model witnessed, effort not recorded in main jsonl)"
  codex/houston-child:
    model: gpt-6.1-sol
    effort: high
    status: active
    gavel: "majkee 2026-10-10 final fold (~/ia-sync/codex/agents/houston.toml); majkee 2026-10-13 GO (witnessed)"
    witness: "~/ia-sync/.dev/session/germline-01-builds-and-deploy/raw/witness.install-test.assay.2026-10-13.md (row X1: turn_context gpt-6.1-sol · high)"
  codex/houston-main:
    model: gpt-6.1-sol
    effort: high
    status: active
    gavel: "majkee 2026-10-10 final fold (~/ia-sync/codex/profiles/houston.config.toml); majkee 2026-10-13 GO (witnessed)"
    witness: "~/ia-sync/.dev/session/germline-01-builds-and-deploy/raw/witness.install-test.assay.2026-10-13.md (row X2: turn_context gpt-6.1-sol · high, all turns)"
---

# Model + effort per route — cross-vendor render settings

## Refresh delta 2026-11-25

*@Epoch sibling (card-refresh pass), 2026-11-25. Live-fetched the five `recheck:` URLs + the Claude Code changelog (first chunk). Official pages = H. `verify_cmd` NOT run (no shell): `codex debug models` — not run; `claude --version` — not run. `active_pins` untouched (gavel-only); no pin proposal beyond the notes below.*

- **Claude lineup moved to Fable 5.2.** `claude-fable-5-2` $8 / $40, 1M ctx, 128K out, default effort `high`, levels low/medium/high/xhigh/max, retirement "not sooner than 2027-11-09". Fable 5.1 ($10/$50) and Fable 5 are now listed as older models. Mythos 5.2 (`claude-mythos-5-2`, $8/$40) is limited availability (Cyber Verification Program) — not generally usable. [H — platform.claude.com/docs/en/models/overview; .../build-with-claude/effort]
- **Opus 5.5 / Sonnet 5.5 / Haiku 5.5 unchanged vs card:** `claude-opus-5-5` $4/$20 (default effort medium), `claude-sonnet-5-5` $2/$10 (default high on API), `claude-haiku-5-5` from $0.10/$0.50 (default medium; costs more per token above a 100K prompt). All 1M ctx, 128K out. Retirement not sooner than 2027-09-22 / 09-28 / 10-07 respectively. All support low/medium/high/xhigh/max. [H — models/overview; effort page; model-config]
- **Claude Code aliases (model-config version history):** `fable`→Fable 5.2 since v2.1.321; `opus`→Opus 5.5 since v2.1.280; `sonnet`→Sonnet 5.5 since v2.1.284; `haiku`→Haiku 5.5 since v2.1.293 (all on the Anthropic API). `best` = `opus`. Pin by full ID (`claude-opus-5-5`) or `ANTHROPIC_DEFAULT_*_MODEL`. [H — code.claude.com/docs/en/model-config]
- **v2.1.332 (2026-11-25):** `sonnet` alias on Google Cloud's Agent Platform and Microsoft Foundry now = Sonnet 5.5; Foundry `opus` = Opus 5.5; Foundry default model = Sonnet 5.5; Bedrock `sonnet` stays Sonnet 4.5; Bedrock Mantle `sonnet` now = Sonnet 5 (was wrongly Haiku 4.5). [H — code.claude.com/docs/en/changelog]
- **Provider table on model-config lags v2.1.332** (it still shows Agent Platform sonnet=4.5, Foundry opus=4.6/sonnet=4.5). Trust the changelog for those two providers; Claude Platform on AWS still shows sonnet 4.6 / haiku 4.5, Google (Anthropic-managed) sonnet 5.5 / haiku 4.5, Bedrock opus 5.5 / sonnet 4.5 / haiku 4.5 per the page. [H for each page; the two pages disagree on timing — M overall]
- **Claude Code effort defaults differ from API defaults (conflict, unresolved):** model-config says Claude Code default effort is `medium` for Fable 5.2, Opus 5.5, Sonnet 5.5, Haiku 5.5 (`xhigh` Opus 4.7, `high` others). The API pages say API default is `high` for Fable 5.2 and Sonnet 5.5, `medium` for Opus 5.5 / Haiku 5.5. Do not treat the card's API defaults as Claude Code defaults; set effort explicitly in pins. [H each; WebFetch summaries — re-read model-config "Effort levels and defaults" if it matters]
- **Effort settings plumbing:** `effortLevel` setting accepts low/medium/high/xhigh (NOT max); `modelSettings` stores effort (and auto-compact window) per model; resolution order: `CLAUDE_CODE_EFFORT_LEVEL` > in-session pick > `--effort` > settings (`modelSettings`/`effortLevel`) > model default. A requested unsupported level drops to the highest supported one at or below it. [H — model-config]
- **`autoCompactWindow` / `/autocompact`:** accepts >=100K tokens (plain count, `k`/`M` suffix, or bare 100–1000 = thousands) or `auto`; capped at the model's context window; per-model value saved under `modelSettings` since v2.1.288 (before that a single top-level `autoCompactWindow`). Native-1M models auto-compact at about 967K by default. `CLAUDE_CODE_AUTO_COMPACT_WINDOW` env var beats all (k/M suffix needs v2.1.304+). [H — model-config; v2.1.329 fixed a pre-warmed-process bug ignoring project `autoCompactWindow`, changelog]
- **OpenAI moved to GPT-6.2.** API docs list `gpt-6.2-astra` $8/$40, `gpt-6.2-sol` $2/$10, `gpt-6.1-terra` $1/$5, `gpt-6-luna` $0.10/$0.50; all 1.05M ctx, 128K out. Efforts listed: 6.2 Astra/Sol low–max; Terra and Luna none–max. Default effort not stated on that page. [H — developers.openai.com/api/docs/models]
- **Codex page (learn.chatgpt.com/docs/models)** lists gpt-6.2-astra (Codex default ctx 272K), gpt-6.2-sol (500K), gpt-6-astra, gpt-6.1-sol (500K), gpt-6.1-terra (needs Codex CLI >= 0.159.0), gpt-6-luna (max effort, no Ultra). 6.2 Astra/Sol up to 1M via `model_context_window`. Start effort: 6.2 Astra/Sol = whatever the client selects; gpt-6-astra = Light; Luna = High. Ultra = splits work across subagents; not on Luna. `gpt-6.1-sol` is still listed (not retired). [H — learn.chatgpt.com/docs/models]
- **GPT-5.5 retirement (2026-10-14) is now past:** retired from Codex with ChatGPT sign-in (Plus/Pro/Business/Enterprise/Edu -> gpt-6.1-sol; Free/Go -> gpt-6-luna); API-key sessions unaffected. GPT-5.4 retired 2026-08-31; GPT-5.3-Codex-Spark retired 2026-09-14. [H — learn.chatgpt.com/docs/models]
- **Pairing hypotheses, price-only re-check:** Astra 6.2 $8/$40 = Fable 5.2 $8/$40 (price twin holds); Sol 6.2 $2/$10 = Sonnet 5.5 $2/$10 (price twin holds, as the card's AMEND said); Luna $0.10/$0.50 = Haiku 5.5 from $0.10/$0.50 (holds). Capability evidence (AA scores) NOT refreshed — stale for the new 5.2/6.2 generation. [H prices; capability unverified]
- **Candidate rows — informational only, not pins:** `claude` side unchanged by alias (opus/sonnet/haiku/fable float to 5.5/5.5/5.5/5.2); frontier row `fable` now = Fable 5.2. `codex` side: `gpt-6.2-sol` / `gpt-6.2-astra` are now available successors to `gpt-6.1-sol` / `gpt-6-astra`; no witnessed probe, so pins stay `gpt-6.1-sol` (still listed). Codex 6.2 press launch Nov 17 and Codex CLI 0.172.0 (Nov 24) NOT independently re-verified here (official model pages confirm 6.2 slugs only). [M]
- **Out of card scope, not checked:** Google gemini-4-carbon/hydrogen/neon (the card has no Google rows; not in `recheck:`).

**Sources (all fetched 2026-11-25):**
- https://platform.claude.com/docs/en/models/overview (H)
- https://platform.claude.com/docs/en/build-with-claude/effort (H)
- https://code.claude.com/docs/en/model-config (H; read in full, two chunks)
- https://code.claude.com/docs/en/changelog (H; first 100k chars only — v2.1.332 .. v2.1.328)
- https://developers.openai.com/api/docs/models (H)
- https://learn.chatgpt.com/docs/models (H)

**Not re-verified:**
- `codex debug models` catalog / Codex CLI version (0.172.0 lead) — not run; Codex per-model effort sets and defaults for 6.2 and for 6.1 Sol/6 Astra remain from 0.162 evidence (stale); OpenAI API page shows no Ultra for 6.2 while the Codex page documents Ultra — unresolved.
- `claude --version` — not run; installed Claude Code version unknown.
- Artificial Analysis scores (pairing capability evidence).
- modelSettings schema (settings-reference not read); gpt-6-astra / gpt-6.1-sol API prices (not on the API page now); Codex 0.172.0 release; Google models.
- Claude Code changelog entries older than v2.1.328 and the v2.1.321 entry (the date 2026-11-09 for Fable 5.2 inferred from "retirement not sooner than 2027-11-09", L).

## ⚠ VOLATILE — read first
- **OpenAI has NO floating family alias.** Every Codex pin is an exact slug; each release needs a manual update.
- **Claude Code aliases float:** `opus` / `sonnet` / `haiku` / `fable` resolve today to Opus 5.5, Sonnet 5.5,
  Haiku 5.5, Fable 5.2. A Claude pin by alias moves under you on release.
- **No GPT-6 Terra exists** (no `gpt-6-terra`, no `gpt-6.1-terra` in the 0.162 catalog). Terra is a gen-5.6 holdover only.
- **GPT-5.5 retired from Codex 2026-10-14** (ChatGPT-signed-in users; API unaffected; replaced by gpt-6.1-sol / gpt-6-luna).
- **Known drift (nablarva X1 U19):** the Codex roster in `~/ia-sync/codex/agents/` still pins `gpt-5.6-sol` / `gpt-5.6-terra`,
  and base `~/.codex/config.toml` is `gpt-5.6-terra` / `medium`. Not reconciled by this card.

## Scope
Model + effort per exact route — nothing else (sandbox / permissions stay in adapters / bindings). Not a tier engine; no automatic updates.

## Vendor lineup (2026-10-09)

| Vendor | Model | Price in/out per 1M | Position | Efforts (default) |
|---|---|---|---|---|
| OpenAI | `gpt-6-astra` | $10 / $50 | most capable | low · medium · high · xhigh · max · ultra (medium) |
| OpenAI | `gpt-6.1-sol` | $2 / $10 | near-Astra at lower cost | low · medium · high · xhigh · max · ultra (low) |
| OpenAI | `gpt-6-luna` | $0.10 / $0.50 | most efficient | low · medium · high · xhigh · max (medium) |
| OpenAI | `gpt-5.6-terra` | unverified | holdover (gen 5.6) | not re-read this pass |
| Anthropic | `claude-fable-5-2` | $8 / $40 | — | low · medium · high · xhigh · max (high) |
| Anthropic | `claude-opus-5-5` | $4 / $20 | — | low · medium · high · xhigh · max (medium) |
| Anthropic | `claude-sonnet-5-5` | $2 / $10 | — | low · medium · high · xhigh · max (high) |
| Anthropic | `claude-haiku-5-5` | $0.10 / $0.50 | — | low · medium · high · xhigh · max (medium) |

Codex efforts = local `codex debug models`, codex-cli 0.162.0 (cartan RETURN 06) — catalog evidence, not an invocation or entitlement proof.

## Pairing hypotheses (majkee frame, epoch-checked 2026-10-09 — dated, NOT rendering rules)

| Hypothesis | Verdict | Evidence |
|---|---|---|
| astra ≈ fable | CONFIRM | same price; AA 53 / 53 |
| sol ≈ opus | AMEND | price twin is sonnet; capability sol-xhigh 51 ≈ sonnet-xhigh 52 ≈ opus-medium 51; sol max 52 vs opus max 58 |
| terra ≈ sonnet | AMEND-weak | terra AA 42 < sonnet; no gen-6 terra |
| luna ≈ haiku | CONFIRM | same price; AA 38 vs 43 |

One aggregator (Artificial Analysis), max effort, not a coding benchmark. Effort levels are native per model — no common grades across vendors.

## Candidate rows (recommendations — not pins)

| Route | Claude | Codex | Note |
|---|---|---|---|
| head / cSharp session | opus · high | gpt-6.1-sol · high | xhigh only as case-by-case escalation |
| carrier turn | opus · high | gpt-6.1-sol · high | narrow turn ≠ whole session; split from head |
| architect child (consult) | opus · high | gpt-6.1-sol · high | = active pins; codex side awaits runtime witness |
| architect main (audit / sitting) | opus · high | gpt-6.1-sol · high | profile candidate has no pin yet |
| implementer senior | sonnet · high | gpt-6.1-sol · high | |
| implementer surgical | sonnet · medium | gpt-6.1-sol · medium | |
| researcher | sonnet · high | gpt-6.1-sol · high | |
| verifier | sonnet · high | gpt-6.1-sol · high | split from challenger |
| challenger | opus · high | gpt-6.1-sol · high | |
| reader (narrow scan) | haiku · medium | gpt-6-luna · medium | probe quality before pinning |
| melter (large corpus) | sonnet · high | gpt-6.1-sol · medium | not merged with reader |
| frontier (rare) | fable · high | gpt-6-astra · medium | unproven — probe a task first |

## Change rule
1. The recalibration researcher refreshes `verified` / evidence / candidates and proposes pin changes.
2. A witnessed probe runs on the exact route.
3. majkee gavels; only then does `active_pins` change.
4. The renderer regenerates adapters from `active_pins`.

Reminder = `harness-stale` on `half_life_days` (U21: louder channel deferred).

## Sources
- @Epoch 2026-10-09: the `recheck:` URLs above + https://artificialanalysis.ai/leaderboards/models
- cartan RETURN 06: `~/unikuklatrix/nablarva/.dev/session/nablarva-X1-architecture/_bus/06.cartan.return.md`
- cartan RETURN 07: `~/unikuklatrix/nablarva/.dev/session/nablarva-X1-architecture/_bus/07.cartan.return.md`
