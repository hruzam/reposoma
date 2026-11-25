# THE EPOCH GAZETTE — Wednesday, 25 November 2026 · Practical LLM edition

_Desk: @Epoch (researcher). Commissioned by majkee: "practical LLM messages — what can be useful". Covers roughly 9–25 Nov and fills the holes the 23 Nov gap edition listed (OpenAI/Codex, OpenRouter, Laravel, Arch, newsletters, open models). Marks: **H** = official page/changelog fetched today · **M** = reliable secondary, or a partial/summarised read · **L** = single weak source, rumour-grade. Note on method: pages were read through a summarising fetcher, so figures are "as relayed", not eyeballed. What I could not verify is listed at the bottom._

---

## FRONT PAGE — three dates to act on, and a Google price table

1. **30 Nov — Gemini 4 Carbon's introductory price ends** ($2 / $10 per Mtok through 30 Nov, **H**, AI Studio changelog). Secondary sources say it becomes $4 / $20 on 1 Dec (**M**).
2. **1 Dec — Gemini 2.5 Pro and 2.5 Flash calls start routing to newer models**: `gemini-2.5-pro` → `gemini-3.8-flash`, `gemini-2.5-flash` → `gemini-3.5-flash-lite`, at the *new* models' rates, with **breaking changes** to function calling, thinking config and sampling parameters (**H**). Anything of yours still pinned to a 2.5 id needs a look before that day. `gemini-omni-1.1-flash` routes on **3 Dec**.
3. **30 Nov — Claude Code managed plugin marketplaces auto-update by default** (opt out with `"autoUpdate": false`, v2.1.331, **H**). Only matters where `extraKnownMarketplaces` is set in managed settings.

---

## ANTHROPIC / CLAUDE CODE — v2.1.331 and v2.1.332

Newest upstream: **v2.1.332, 25 Nov** (**H**; changelog page read from the top only, ~100K of 1.44M chars — v2.1.327 and older not re-read).

- **v2.1.332 (25 Nov):** *Skills from MCP servers* (beta), shown as `server:skill`; new hook event **`PreSkillShellCommand`**; OTel `assistant_response` event (`OTEL_LOG_ASSISTANT_RESPONSES=1`). On Agent Platform and Foundry the `sonnet` alias now means **Sonnet 5.5** (Foundry `opus` = Opus 5.5, Foundry default = Sonnet 5.5; Sonnet 4 / Opus 4 / Opus 4.1 on Foundry are treated as retired). `--model default` now falls back to an older model instead of erroring. `computer-use` is a reserved skill name on macOS. `disableAutoMode: "disable"` stops auto mode starting on some Bedrock Mantle / Agent Platform / Foundry setups.
- **v2.1.331 (23 Nov):** Code Mode in terminal sessions on Bedrock, Agent Platform, Foundry and Claude Platform on AWS; an API-connectivity section in `claude doctor`; `optionalDependencies` in plugin manifests; `PermissionDenied` hooks with `retry: true` now retry only if the user asked for that call.
- **Why it matters to us:** `PreSkillShellCommand` and MCP-served skills touch the skills/hook primitives Atlas builds on; the alias changes matter only on those cloud providers.
- **Models:** nothing new from Anthropic since Fable 5.2 / Mythos 5.2 (9 Nov). Anthropic's news page shows the IPO closing (20 Nov) and an untitled 25 Nov entry — no model, price or API item in the window (**H**).

---

## GOOGLE — the Gemini 4 family is out, and the API calendar changed (**H**, AI Studio changelog)

| Date | Model id | Price per Mtok in / out | Notes |
|---|---|---|---|
| 10 Nov | `gemini-4-carbon` | $2 / $10 (introductory, to 30 Nov) | GA |
| 12 Nov | `gemini-4-hydrogen` | $1.50 / $7.50 | free + paid tiers; adds `xhigh` thinking; **default for the Antigravity agent** |
| 18 Nov | `gemini-4-neon` | $3 / $15 | 1M context; thinking low / medium / **high (default)** / xhigh; paid only |
| 19 Nov | `genie-4` | $1.50 in / $9 text out / $17.50 video out | real-time world generation, Interactions API (`v1beta`) |

- **New, practical:** *tool retrieval* (preview) — `defer_loading` and `tool_search` — for Gemini 3.6+ incl. all Gemini 4 models. This is the same idea as Claude Code's deferred MCP tools; worth watching for large tool sets.
- Smaller: Office/OpenDocument input and page/sheet/time slicing (18 Nov); `gemini-embedding-2-preview` → `gemini-embedding-2` automatic (6 Nov); Omni 1.2 Flash GA with 30% lower price (5 Nov).
- Press (**M**): Neon launched 18 Nov with cached input $0.15/Mtok, available in the Gemini API, AI Studio and Antigravity; sources disagree on which Antigravity plans get it. Latent Space (24 Nov headline, **M**): "Gemini 4 Neon … Google DeepMind's full return as a frontier lab".
- **Not checked:** the Antigravity CLI changelog and the Gemini CLI changelog (the latter's page showed v0.64.0 / 13 Oct as newest on 23 Nov — likely a thin page, not proof of silence). Our gemini-cli / gty / gemini-models cards are untouched.

---

## OPENAI / CODEX

- **Codex 0.172.0 (24 Nov, H):** thread links open saved conversations and nested agents; Tab completes slash-command arguments; stdio MCP servers with cached tool lists now start **on first tool call** by default; per-app-tool approval reviewers in `config.toml`; app-server clients can pick Amazon Bedrock Runtime; **`codex exec resume` now restores saved sandbox permissions, working directory and workspace roots** unless overridden — check any scripted resume that relied on re-specifying them. (0.171.0, 20 Nov: GPT-6.2 Sol default, `codex exec --remote`.)
- **GPT-6.2 Astra and Sol (17 Nov), M:** several outlets agree — Astra **$8 / $40** per Mtok (cached $0.40), down 20% from GPT-6 Astra; Sol **$2 / $10** (unchanged vs 6.1 Sol); over 272K input tokens input pricing doubles and output ×1.5; Batch at 50%; "Ultrafast" available. openai.com/news lists "GPT-6.2" but gave no prices in my read; **re-fetch the pricing page before routing money on these numbers**. Latent Space (18 Nov): mixed reviews for Astra, Sol expected to be the workhorse (**M**).
- OpenAI posts 18–24 Nov by title only: "Inside the Codex sandbox" (engineering, 18 Nov — not read), a security item with Cisco ("Shirudo", 23 Nov), science posts. Not read; no claims.

---

## OPENROUTER — the catalog is not readable by this seat (**L**)

The model-list page showed a mixed list (Upstage Solar Pro 4, Xiaomi MiMo-V2.6-Flash, Thinking Machines Inkling 2 Mini, RadixArk DaisyRose 27B, Perplexity embedding models, Baseten Groundhog/Bison, Gemini 4 Neon at 1M) but **no prices or dates and no proof of ordering**; the JSON API read returned entries with oddly prefixed ids and no prices. I am not quoting any OpenRouter figure. A seat with Bash should `curl -s https://openrouter.ai/api/v1/models | jq` for the pricing fields before the openrouter card is touched.

---

## NEWSLETTERS & THE OPEN-MODEL CORNER (headline level, **M**)

- **Import AI 482 (23 Nov):** Huawei kernel benchmarks; airborne drone detection; a national lab's AI-for-science benchmark. 481 (16 Nov): AI sub-contractors, a wet lab for AI, subterfuge during development.
- **The Batch #380 (20 Nov):** Fable 5.2 and Anthropic's IPO; World Labs releases *Atlas* to developers; "Jensen Huang's departure from Nvidia". #379 (13 Nov): GPT-6 Cyber vs Linux; LLMs editing model weights; agentic document retrieval.
- **Latent Space AINews:** 24 Nov Gemini 4 Neon; 23 Nov "Jensen Huang **returning**", OpenAI pretraining curve, Microsoft joining; 18 Nov GPT-6.2 Astra; 17 Nov Perplexity at ~$1B run rate. **Conflict:** The Batch says Huang *departed*, Latent Space says *returning*; Interconnects (14 Nov, "Open-source AI without Jensen — a decapitation, time to rebuild") leans departure. Unresolved, **L** — do not repeat either as fact.
- **Extraordinary headline, unverified (L):** Latent Space, 20 Nov: "two independent proofs of the Riemann Hypothesis". Not read; treat as unconfirmed.
- **Interconnects:** 14 Nov and 4 Nov posts are about open models (teaser pages only, the latter paywalled); 20 Oct "Latest open artifacts #25" (DeepSeek V4.1 Flash 1017, US models). No open-model release of practical weight verified in this window.

---

## ARCH & LARAVEL — the stack under the tools

- **Laravel 13.44 (24 Nov, M — Laravel News feed):** form-request `model()` helpers, long-running-transaction alerts, `lockForNoKeyUpdate()` for PostgreSQL, **PHP 8.6 support**. Also: `JsonSchema::rules()` builds validation rules from a JSON schema "so MCP and AI SDK tools can validate input" (23 Nov); a video on making failed AI requests safe (22 Nov). The feed returned only 5 items.
- **Arch news (M, feed read today):** newest items shown date to 21 Oct — **PHP RCE fixed in php ≥ 8.5.12 / php-legacy ≥ 8.3.36**; `ca-certificates-mozilla ≥ 3.131.1-1` removes compromised eMudhra intermediates; 22 Sep `mkinitcpio 42` changes PCR measurements — **TPM2-LUKS unlock needs re-enrolment**. Either nothing newer was posted or the feed snapshot is old; I cannot tell. (This box runs Manjaro — package timing differs; the PHP and CA items still matter for anything served from it.)

---

## THE BOOKS — what changed on our side

- The stale-card job (office timer) now has fixes for the doubled slash, pipes and quotes in `verify_cmd` — **in source, deploy pending on all three hosts**; the first ISO-week mail has not been produced yet. Detail: `pulse.epoch.md`.
- `raw.guides/scheduler/` replaces `harness-check`; chapter owner decided: @Epoch.
- Cards refreshed 23 Nov: claude-code (partial), cursor-ide, codex-cli. This edition also writes a gap entry into `ai-news` and adds primary changelog sources to its source list.
- Still stale after today: arch, laravel, gemini-cli, openrouter, model-effort, claude-ai, gemini-gems, gty, session-hygiene, agent-docs, eagle, reposoma, gemini-models, machine.office (14 of 20 dated cards, once the ai-news entry is filed).

---

## CORRECTIONS & LIMITS OF THIS EDITION

- Claude Code changelog read only to v2.1.327 on the first 100K characters; v2.1.294–320 are **still not itemised** (open since 23 Nov).
- The fetcher summarises pages; tables above are its extraction. Prices from the Google changelog are labelled H because they come from Google's own page, but I did not see the page itself.
- OpenAI prices rest on press and "model pages"; OpenAI's own pricing page was **not** read. OpenRouter: nothing usable (see above). No `--version` was run anywhere.
- Not covered: Cursor (checked 23 Nov, nothing new fetched today), Antigravity/Gemini CLI changelogs, Mistral/DeepSeek/Qwen/Kimi releases, `rychlofky`, `prg.ai`, HF daily papers, Ahead of AI, Deep (Learning) Focus.
- Nothing here was executed; this is reading, not testing.

_Filed by @Epoch · 2026-11-25 · next edition on request._
