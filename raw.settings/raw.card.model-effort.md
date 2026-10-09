---
card: card.model-effort
brand: "Anthropic — Claude · OpenAI — Codex (cross-vendor)"
kind: "knowledge-card · RELATIVE (volatile) · render.settings — model + effort per exact route"
verified: 2026-10-09
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
    gavel: "nablarva .claude/agents/houston.md"
  codex/houston-child:
    model: gpt-6.1-sol
    effort: high
    status: pending-effective-runtime-witness
    gavel: "majkee 2026-10-09 (nablarva e4ebf15)"
---

# Model + effort per route — cross-vendor render settings

## ⚠ VOLATILE — read first
- **OpenAI has NO floating family alias.** Every Codex pin is an exact slug; each release needs a manual update.
- **Claude Code aliases float:** `opus` / `sonnet` / `haiku` / `fable` resolve today to Opus 5.5, Sonnet 5.5,
  Haiku 5.5, Fable 5.1 (older versions on Bedrock / Foundry). A Claude pin by alias moves under you on release.
- **No GPT-6 Terra exists** (no `gpt-6-terra`, no `gpt-6.1-terra` in the 0.162 catalog). Terra is a gen-5.6 holdover only.
- **GPT-5.5 retires from Codex 2026-10-14** (ChatGPT-signed-in users; API unaffected).
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
| Anthropic | `claude-fable-5-1` | $10 / $50 | — | low · medium · high · xhigh · max (high) |
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
