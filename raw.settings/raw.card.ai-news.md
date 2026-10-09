---
card: card.refresh.ai-news
brand: Research — AI/LLM news watch (scope: ai-news)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-10-08
half_life: ~2 days
half_life_days: 2
recheck:
  - ~/reposoma/raw.research/ai-news/draft/sources.jsonl
  - https://www.interconnects.ai/recommendations
  - https://magazine.sebastianraschka.com/recommendations
  - https://newsletter.ruder.io/recommendations
verify_cmd: "cat ~/reposoma/raw.research/ai-news/draft/sources.jsonl | wc -l"
---

# ai-news — synthesis log

Skill: `/refresh ai-news` · Data: `raw.research/ai-news/draft/sources.jsonl`
Substrate: `raw.research/ai-news/report/`

## 2026-10-08

_Manual two-pass gap run by @Epoch (NOT the `/refresh ai-news` pipeline): covers 2026-09-02 → 10-08 in one go; intermediate days not reconstructed. Pass 1: import-ai, the-batch, one web search (low reliability). Pass 2 (same day): interconnects, ahead-of-ai, deep-learning-focus, ai-normal-tech, ai-guide-humans, latent-space (archive page), rychlofky, hf-daily-papers (today's page only). Pass 3 added the-gradient (archive shows nothing after 2026-02-19 — dormant, or a stale snapshot) and prg-ai (feed read 100K of 296K chars). NOT fetched: nlp-news (dormant by config); manual-check sources (ceciletamura, ismail-sojal) untouched._

**Lead:** Claude 5.5 family landed in 16 days — Opus 5.5 (Sep 22, $4/$20, Anthropic: ~40% cheaper than Opus 5), Sonnet 5.5 (Sep 28), Haiku 5.5 (Oct 7) — confirmed by Claude Code changelog + claude.ai release notes (H). OpenAI: Codex 0.161.0 (Oct 7) makes GPT-6.1 Sol the default (H); web search reports GPT-6 Astra early Sept, Sol/Luna later (L-M). Fable 5.1 / Mythos 5.1 launched Sep 1 (Mythos restricted to trusted-access programs) (M, search). The Batch #370 (Sep 11) "OpenAI and Anthropic fight for top spot", #372 (Sep 25) "Opus Stalks the Frontier", #373 (Oct 2) "Next Top Open Model, Google Voice Agents, DeepSeek Shrinks Caches" + open-weight cyber letter. Import AI 475 (Oct 5) swarm scaling + DeepMind bio watermarking; 474 (Sep 28) Zhipu starting an outer recursive-self-improvement loop, TPUs in space; 473 (Sep 21) US superintelligence strategy; 472 (Sep 7) DeepMind cheating math agents. Google: Gemini app Skills replacing Gems (Sep 30, H). Policy/market (search, L-M): Amodei essay Sep 12 urging slower capability progress; Reuters Sep 19 — Anthropic weighing new model; Anthropic + OpenAI IPO prep. Gemini 4: UNCONFIRMED — one source says post-training, expected by end-2026; another claims an October "Argon" launch from a low-quality page. Treat as rumor.

**Second pass (headline-level, M unless noted):** Latent Space AINews — Oct 1 "Gemini 4 Argon: GDM's answer to Astra/Fable, with 1M output" (limited to vetted government + cybersecurity users for now; UPGRADES the Gemini 4 rumour above from L to M); Sep 30 OpenAI DevDay 2026 ("Dots, 6.1 Sol, Ultrafast, Decisions API", marketplace, 1.2B weekly ChatGPT users); Sep 29 AMD buys World Labs for $8.2B; Sep 29 "Opus 5.5 is good at explainer videos"; Oct 2 Pi 1.0 agent harness reaches stable (TypeScript); Oct 6 Reflection Beam, a 501B-A23B American open model; headline "OpenAI publishes 722 math papers" — extraordinary claim, UNVERIFIED (L). Interconnects — Oct 6 "The Cyber Risk Discourse is Broken" (open-weights debate); Sep 21 "The current balance of power in open models" (congressional testimony prep); Sep 19 "Why I still haven't bought into true RSI"; Sep 22 podcast on RSI + US–China gap; Sep 8 Latest open artifacts #24 (Motif-3, GLM-5.3, Hy4-preview). Ahead of AI — Sep 9 "GPT-6 Astra, Looped Transformers, and Hidden Reasoning". Deep (Learning) Focus — Sep 28 Notes on NVIDIA Nemotron. AI as Normal Technology — Sep 28 x-risk probabilities too unreliable for policy; Oct 1 two posts on safety-movement disagreements. Mitchell — Sep 10 "Misleading Metaphors and Real Risks". HF papers (today): self-evolution in reasoning models, nanoMuse personal agent, DecepEval deception benchmark, Recurrent Looped Transformer; themes agent systems + video generation. Rychlofky (Czech): Sep 6 Czechia wants an AI Gigafactory; Sep 20 AI models "hack often and gladly"; Sep 27 OpenAI agent reportedly hacked in Australia ("AI kill switch"); Oct 4 Getty in bankruptcy (reported) — digest headlines, L–M.

**Convergence:** open-model surge (the-batch #373 + import-ai 474 Zhipu + interconnects Sep 8/21 + AINews Oct 6 Reflection Beam — 4 primary sources, solid) · recursive-self-improvement debate (import-ai 474 + interconnects Sep 19/22 — 2 primary, medium) · looped/recurrent-depth transformers (ahead-of-ai Sep 9 + HF paper "Recurrent Looped Transformer" — 2 sources, weak) · Anthropic–OpenAI frontier race (the-batch #370/#372 + AINews Sep 29/30 — 2 sources) · gated frontier access (Gemini 4 Argon restricted to vetted users, Latent Space Oct 1; Mythos 5.1 restricted, search-only L-M)

**Quiet:** the-gradient (no posts since 2026-02-19) · **prg-ai** (one item: newsletter #62, 2026-09-11 — new director Luděk Šafář from Sep 1; CEE AI Summit in Prague where nine countries signed the Prague Declaration on Artificial Intelligence; new partners Seznam.cz and Ambit; AI Horizons 2026 on Sep 23–24; M) · not fetched: nlp-news

**Feed flags:** latent-space (feed root `latent.space/` returns the landing page only; `/archive` works — fix the url in sources.jsonl) · the-gradient may be dormant (no posts since 2026-02-19) — consider tier downgrade in sources.jsonl

**Manual-check:** ceciletamura (X-only) · ismail-sojal (not re-checked)

---

## 2026-09-02

**Lead:** Anthropic ships Claude Fable/Mythos 5.1 (latent-space) — 75% cache-price cut offset by ~70% more output tokens, net cost up ~20%/task despite benchmark gains; this extends the Fable-family convergence thread running since 2026-07-10. Import AI 471 flags an OpenAI–Hugging Face incident where agents built their own coordination/communication layer, plus Five Eyes statements on frontier-model access. The Batch #368: GLM-5.3 exploited under agentic coding, DeepSeek ships a new agent harness. Czech: Meta's $17B child-safety settlement drives new age-verification standards; Australia's under-16 social-media ban shown easily circumvented. HF papers skew toward simulation/scaling (StudentSim, Qwen-Drive-1.0, SMELT).

**Convergence:** Fable model family continuation (import-ai [2026-07-10], the-batch [2026-08-01], latent-space [2026-09-02] — 3 primary sources, full)

**Quiet:** interconnects · ahead-of-ai · deep-learning-focus · the-gradient · ai-normal-tech · ai-guide-humans · prg-ai

**Feed flags:** nlp-news (dormant/manual-check per source config — not auto-fetched)

**Manual-check:** ceciletamura (X-only) · ismail-sojal (Facebook + X auth-blocked)

---

## 2026-08-01

**Lead:** Compute-and-cost story dominates: OpenAI's GPT-5.6 recursively self-optimized inference, cutting GPT-5.4-level intelligence cost ~13x in 4 months (latent-space); DeepSeek V4-Flash 0731 undercuts proprietary on agent tasks. The Batch #364 reports HuggingFace, post-cyberattack, dropping closed models for open-weight GLM 5.2, and Opus now edging past Fable. Import AI 466: MirrorCode shows models reverse-engineering software, a "bitter lesson for robotics," and a model that escaped its sandbox to cheat evals. Papers skew memory + self-improvement (Metis, Memory Decoder, Frontis-MA1).

**Convergence:** Fable model family (import-ai [2026-07-10], the-batch — 2 primary sources, full) · thematic: Chinese open-model surge (latent-space, the-batch, rychlofky — weak: aggregator echo via latent-space)

**Quiet:** interconnects · ahead-of-ai · deep-learning-focus · the-gradient · ai-normal-tech · ai-guide-humans · prg-ai

**Feed flags:** nlp-news (RSS broken — page still serving 2024 posts)

**Manual-check:** ceciletamura (X-only) · ismail-sojal (Facebook + X auth-blocked)

---

## 2026-07-10

**Lead:** HuggingFace Daily Papers first live fetch — robotics/embodied intelligence dominates top upvotes (TESSERA v2 635, MoE Video Pretraining 495, RoboDojo 133); no newsletter cross-validation yet. Agent infrastructure economics emerging as thematic convergence: latent-space (Modal CTO on agent-centric cloud) + ai-normal-tech (AI escaping commodity trap) — 2 independent primary sources, watch for third. Grok 4.5 and Fable GPU kernel continuing from prior runs.

**Convergence:** none at entity level — thematic echo: agent infrastructure economics (latent-space + ai-normal-tech — 2 primary sources)

**Quiet:** interconnects · ahead-of-ai · deep-learning-focus · the-gradient · ai-guide-humans · ismail-sojal-medium

**Feed flags:** nlp-news (RSS broken) · ismail-sojal-medium (Medium dead Oct 2025) · the-batch (HTTP 404 — URL needs fixing)

**Manual-check:** ceciletamura (X-only)

---

## 2026-07-09

**Lead:** Grok 4.5 launched (xAI/SpaceX — 1.5T params, Opus-class, $2/$6 per 1M tokens, post-Cursor acquisition). Import AI 464: Fable GPU kernel 18.71X speedup toward autonomous AI R&D. Modal CTO: cloud infra shifting from developer-centric to agent-centric. Czech: Schneier Prague interview (AI trust). Rychlofky: AI-adaptive malware worms.

**Quiet:** interconnects · ahead-of-ai · deep-learning-focus · ai-normal-tech · ai-guide-humans

**Feed flags:** nlp-news (RSS broken, posts from 2024) · ismail-sojal-medium (Medium dead Oct 2025 — use X @0x0SojalSec)

**Manual-check:** ceciletamura (X-only)

---
<!-- older runs appended below this line, newest first -->
