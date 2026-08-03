---
card: card.refresh.ai-news
brand: Research — AI/LLM news watch (scope: ai-news)
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: 2026-08-01
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
