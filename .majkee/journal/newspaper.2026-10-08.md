# THE EPOCH GAZETTE — Thursday, 8 October 2026

_Desk: @Epoch (researcher). Gap edition: covers 2 Sep → 8 Oct, because the card-freshness checker flagged 19 stale cards on 5 Oct. Every item carries its source and a confidence mark: **H** = official page/changelog fetched today · **M** = reliable secondary or partial read · **L** = single weak source, treat as rumour. Anything I could not verify is said so at the bottom._

---

## FRONT PAGE — Anthropic ships a whole model generation in sixteen days

Three releases, one family, and the price list moved in a direction nobody expected.

| Model | Date | Price per Mtok (in/out) | Notes |
|---|---|---|---|
| **Opus 5.5** `claude-opus-5-5` | 22 Sep | **$4 / $20** (cache reads $0.20) | Cheaper than Opus 5 ($5/$25). Anthropic says ~40% cheaper to run. 1M context. |
| **Sonnet 5.5** `claude-sonnet-5-5` | 28 Sep | $2 / $10 (cache reads $0.20 per Claude Code changelog; OpenRouter lists $0.10 — unresolved) | List price unchanged; Anthropic claims up to 30% less cost per task. 1M context. |
| **Haiku 5.5** `claude-haiku-5-5` | 7 Oct | **$0.10 / $0.50** ($0.50 / $2.50 for prompts over 100K) | Previous Haiku 4.5 listed at $1 / $5, so the small tier got roughly 10× cheaper on paper. 1M context. |

**Why it matters.** The interesting move is not the new names, it is that the *top* tier got cheaper and the *bottom* tier got dramatically cheaper while list prices of the middle stayed put. If you route by tier (cheap-first, heavy on demand — the temple's cost-gradient), the bottom rung just became a very different tool.

**The skeptic's corner.** "Cheaper per token" is not "cheaper per task". One independent analysis (Artificial Analysis, as relayed by a secondary site — **M**) measured Sonnet 5.5 at max effort at about **$7.60 per task versus $3.46 for Opus at xhigh** for the same score. Sonnet's low list price can be eaten by the tokens it spends thinking. Read the effort setting before reading the price.

_Sources: Claude Code changelog v2.1.280 / v2.1.284 / v2.1.293 (**H**) · claude.ai release notes 22 Sep, 28 Sep, 7 Oct (**H**) · pricing-comparison articles via web search (**M**)._

---

## THE TOOL THAT SHIPS DAILY — Claude Code v2.1.258 → v2.1.293

Thirty-five releases in 36 days. Most are fixes; four changes deserve a human's attention:

1. **Hooks now fail closed (v2.1.288, 2 Oct).** A `PreToolUse` or `PermissionRequest` hook whose matcher *fails to evaluate* used to be skipped; now the call is **blocked**. Good for leash-style hooks (your whitelist hook work); bad if a matcher bug used to hide behind the old behaviour. Test your hooks.
2. **Auto mode is now the default start state (v2.1.284, 28 Sep)** for interactive and VS Code sessions with no configured mode, on every plan. `permissions.defaultMode` overrides it. A server-side safety classifier is the default on direct API connections.
3. **Claude Mods (v2.1.287, 1 Oct)** — plugins that can modify deeper behaviour (tool registration, model completion, agent spawn, UI hooks). Brand-new primitive; documentation is thin, so I rate my understanding **M**.
4. **Subagent output is now framed as subagent output (v2.1.277)** so a subagent's text cannot masquerade as session instructions. Quiet security hardening; also `TaskOutput` was removed.

**Correction to our own books:** our Claude Code card said subagents nest 5 levels deep. The live docs say the default has been **3** since v2.1.219 (it was 5 in v2.1.172–216, briefly 1 in v2.1.217–218). Fixed today.

_Sources: code.claude.com changelog and sub-agents docs, fetched 8 Oct (**H**). Releases v2.1.259–267 were not itemised — see bottom._

---

## ONE WORD, THREE VENDORS — "Skills" is eating the product line

A pattern worth a column, because three unrelated shops did the same thing within weeks:

- **Google, 30 Sep:** Skills arrive in Gemini chat — reusable instructions built from your chats, auto-run on a matching prompt, combinable. Google says Skills "will soon replace Gems"; existing Gems migrate automatically when Gems are retired. (**H**, gemini.google/release-notes)
- **Anthropic:** Skills are already a first-class Claude Code primitive; claude.ai skills now sync into the CLI (opt-out via `syncClaudeAiSkills`), and as of v2.1.282 folders in the `anthropic-skills` / `claude-ai` namespaces no longer load from disk locally. (**H**)
- **Laravel AI SDK 1.1, 6 Oct:** adds *Agent Skills* support. (**H**, Laravel News feed)

**Reading of the tea leaves (my inference, not a source's claim — flag **L**):** the "Agent Skills" open standard is turning into the common unit of portable agent behaviour, and the old per-vendor "custom assistant" objects (Gems, custom GPT-style bots) are the casualties. If the temple keeps expertise in portable skills rather than in vendor-specific wrappers, this trend validates that bet.

---

## THE OPEN-MODEL CORNER

- **The Batch #373 (2 Oct):** headlines "The Next Top Open Model", "Google Voice Agents", "DeepSeek Shrinks Caches", plus a letter on open-weight cybersecurity capabilities. (**M** — I read headlines, not bodies.)
- **Import AI 474 (28 Sep):** "Zhipu starting an outer recursive self-improvement loop", alongside "TPUs in space". (**M** — headline only; I do **not** know how strong the claim is. Treat the phrase as the newsletter's framing, not as a verified capability.)
- **Import AI 475 (5 Oct):** swarm scaling; Google DeepMind watermarking biology models; "who chooses what AI gets to do?"

Two independent newsletters pointing at Chinese/open labs in the same fortnight is a *weak* convergence — worth watching, not worth betting on.

_Sources: deeplearning.ai/the-batch, importai.substack.com archive, fetched 8 Oct._

---

## OPENAI, SEEN THROUGH A KEYHOLE

- **Codex CLI 0.161.0 (7 Oct)** makes **GPT-6.1 Sol** the default model in its bundled and Bedrock catalogs. (**H**, github.com/openai/codex releases)
- A web search turned up reports that **GPT-6 Astra** shipped in early September, described as operating software the way a person does and as the first OpenAI model rated "critical" on its cybersecurity preparedness framework, with Sol and Luna following. (**M** — OpenRouter's model catalog lists `openai/gpt-6-astra` created 2026-09-04; the Codex changelog lists GPT-6 Sol and Luna rolling out 2026-09-22 and GPT-6.1 Sol on 2026-09-29. The characterisation of Astra still comes from aggregators.)

Honest gap: I did not read OpenAI's own announcements. The Codex release page is the only primary evidence in this section.

---

## GOOGLE & THE ANTIGRAVITY CHANGEOVER

- **Gemini CLI** v0.63.0 (6 Oct) is a maintenance release (retry indicator, memory bounds, an auth-loop fix). The CLI's docs carry a banner: Gemini CLI "was replaced by **Antigravity CLI** on **June 18th, 2026**" — for the *Unpaid tier and Google One users*. Enterprise/other tracks remain. (**H**)
- **Antigravity CLI (`agy`) 1.3.0 (6 Oct)** changed the default **Verbosity from `high` to `medium`** — tool calls and thoughts are now grouped into summaries. If a script or habit depends on seeing raw tool output, set it back. Earlier, **1.2.14** made `--json-schema` reject plain text and bare type names with exit code 1. (**H**)
- **Gemini 4 "Argon":** Latent Space's AINews (1 Oct) headlines it as Google DeepMind's answer to Astra/Fable, with 1M output, limited for now to vetted government and cybersecurity users. Secondary source, headline-level, no Google page read — **M** (upgraded from the rumour rating this edition first carried).

---

## CURSOR — the IDE grows a back office

6 Oct: control your **local agents from the Cursor iOS app** (on by default except Enterprise; the computer must stay awake). 23 Sep: **Rollouts** (per-PR deploy health) and **Security Review** (one comment per PR, with severity and a proposed fix), Teams/Enterprise. 10 Sep: **Cursor Projects** (beta) — a coordinator agent plans and delegates to cloud agents with shared context files. (**H**, cursor.com/changelog)

---

## WORKSTATION WATCH — Arch Linux

**22 Sep, manual intervention required:** `mkinitcpio` ≥ 42 with the systemd hook **and** TPM2-based LUKS unlocking means you must **re-enroll the TPM2** (it affects PCRs 0–7, 9 and 12–14). Official pointers: `systemd-cryptenroll(1)`, `systemd-pcrlock(8)`. It only bites if you unlock your disk with TPM2 — and note this is Arch's own news feed; whether your Manjaro box has received `mkinitcpio` 42 yet is something to check, not something I verified. (**H** for the news item; applicability to this machine **unverified**.)

---

## THE MARKET PAGE (low confidence — read as gossip)

From one web-search pass, secondary sources only (**L**): Anthropic CEO Dario Amodei published an essay on 12 Sep arguing for slowing capability progress; Reuters reported on 19 Sep that Anthropic is weighing a new model to counter OpenAI's momentum; both Anthropic and OpenAI are said to be preparing IPOs. Nothing here was confirmed against a primary source. Fable 5.1 / Mythos 5.1 reportedly launched on 1 Sep, with Mythos restricted to trusted-access programs (**M**).

---

## ALSO NOTED

- **claude.ai, 16 Sep:** Cowork features rolling into every conversation; Claude Design, Slides and Docs added (Artifacts on all plans). 7 Oct: Max and Team plans get monthly API credits when a Console org is linked. (**H**)
- **OpenRouter:** Batch API at half price (22 Sep), In-Region Routing for US/EU (9 Sep), Security Center for API keys (28 Sep), ElevenLabs voice models added (7 Oct). (**H**)
- **Laravel 13.35 (7 Oct):** `Route::query()`, opt-in model `defaults()`, percentage-based worker memory limits. (**H**)

---

## LATE EDITION — second pass, same day

**OpenAI's calendar, filled in.** Latent Space covers an **OpenAI DevDay on 30 Sep** (headline: "Dots, 6.1 Sol, Ultrafast, Decisions API", plus a marketplace and a claimed 1.2 billion weekly ChatGPT users — **M**, headline-level). The Codex changelog adds the practical part: **GPT-5.5 retires from Codex on 14 October** for ChatGPT-signed-in users (API unaffected), **GPT-5.3-Codex-Spark** was already pulled on 14 Sep, and on 5 Sep the **`codex mcp-server` command and `codex-mcp-server` binary were removed** in favour of the Codex app server. If a config pins GPT-5.5 or launches Codex as an MCP server, it breaks — one of these has a six-day fuse. (**H**, learn.chatgpt.com/codex/changelog)

**Anthropic's own words.** The news page frames **Opus 5.5 as performing at Fable 5.1's level on most work at 40% lower cost than Opus 5**, and Sonnet 5.5 as ~30% faster and up to 30% cheaper for most work (**H**, anthropic.com/news). Mythos does not appear there beyond a menu link, so its access status remains unconfirmed (**L**).

**Three arguments running at once in the newsletters.**
1. *Open models vs. cyber risk* — Interconnects (6 Oct, "The Cyber Risk Discourse is Broken"; 21 Sep, a Congress-testimony piece on the balance of power in open models), The Batch #373's open-weights cybersecurity letter, and a 501B-parameter American open model ("Reflection Beam", AINews 6 Oct). Four independent desks — the strongest convergence of the fortnight (**M**).
2. *Recursive self-improvement* — Import AI 474 (Zhipu), Interconnects 19 and 22 Sep. Treat as a live debate, not a result.
3. *Looped / recurrent-depth transformers* — Ahead of AI (9 Sep) and a Hugging Face paper trending today. Weak convergence (**L–M**), but a pattern to keep an eye on.

**Gossip-grade items — do not repeat without checking.** AINews lists "OpenAI publishes 722 math papers" as a headline: an extraordinary claim, **unverified (L)**. Also reported at headline level: AMD buying World Labs for $8.2B (29 Sep) and Pi 1.0, a minimal agent harness, going stable (2 Oct) — note Laravel Boost added MCP support for Pi on 5 Oct, so that one has a second, independent echo (**M**).

**Czech desk (Rychlofky, weekly digest, headline-level, L–M).** 6 Sep: Czechia wants an "AI Gigafactory" and Anthropic is "still flagged as a supply-chain risk"; 27 Sep: an OpenAI agent reportedly "hacked in Australia"; 4 Oct: Getty Images in bankruptcy. Reported as the digest states them; not cross-checked.

**Model catalog check (OpenRouter).** Newcomers in the catalog slice: GPT-6.1 Sol (29 Sep), Grok 4.7 (21 Sep, listed under SpaceXAI), Qwen3.8 Max (3 Sep), Meta Muse Spark 1.3 and Gemini 3.8 Flash (both 2 Sep), Kimi K3 (16 Jul). The slice omitted Sonnet 5.5 and Haiku 5.5, so it is **incomplete** — no prices were returned either (**L–M**).

**For the hook-writers.** Claude Code's hooks docs list **33 events** (including `DirectoryAdded`, absent from our card until today). `exit 2` is **not honoured for `PermissionRequest`** — use the JSON decision there. (**H**)

---

## CORRECTIONS & LIMITS OF THIS EDITION

- Claude Code releases v2.1.259–2.1.267 were read in a second pass (2.1.262 and 2.1.264 absent from the excerpt); the v2.1.279 block was only partly visible, so items marked "likely" in the cards come from it.
- **No `--version` was run** on any CLI. Version numbers here are *upstream latest*, not what is installed on any machine.
- The Latent Space feed root returned only a landing page; its /archive page worked in the second pass. HF papers and the Czech desk (Rychlofky) were read at headline level. Still not fetched: The Gradient, prg.ai. This was a manual two-pass gap run, not the real `/refresh ai-news` pipeline.
- **Fable / Mythos** tier status was not re-checked directly against Anthropic; the Fable 5.1 / Mythos 5.1 line comes from a search aggregator.
- Cards touched today: claude-code, codex-cli, cursor-ide, gemini-cli, gty, claude-ai, gemini-gems, arch, openrouter, laravel, ai-news, agent-docs, session-hygiene (all in `raw.settings/`).

_Filed by @Epoch · 2026-10-08 · next edition on request._
