# Lens L1+L2: Domain Primary + First Principles
`study: capabilities.claude · phase: 2-blind · date: 2026-06-25 · agent: @Epoch`

---

## L1 — Domain Primary (Anthropic official docs and model pages)

### [Anthropic Docs: Models Overview]
- **what**: Official Anthropic reference page listing all current and legacy Claude models with specs, pricing, context windows, extended-thinking support, and knowledge cutoffs
- **kind**: doc
- **url**: https://platform.claude.com/docs/en/about-claude/models/overview
- **whyDurable**: First-party, continuously maintained. The canonical source for model IDs, capability availability flags (extended thinking, adaptive thinking), context window sizes, and pricing per tier (Haiku 4.5: $1/$5 MTok; Sonnet 4.6: $3/$15; Opus 4.8: $5/$25; Fable 5: $10/$50). Verified live 2026-06-25.
- **mustRead**: "Latest models comparison" table (Opus 4.8 / Sonnet 4.6 / Haiku 4.5 head-to-head on latency, context, output, thinking availability); "Claude Fable 5 and Claude Mythos 5" section (1M context, adaptive thinking always on, pricing tier)
- **bearson**: all task classes — this is the tier-definition source; short advisory (latency / cost column); tool-use/execution (thinking availability per tier)

---

### [Anthropic Docs: Effort Parameter]
- **what**: Official API reference for the effort parameter: five levels (low / medium / high / xhigh / max), per-model availability, recommended starting points per tier, and interaction with tool calls and extended thinking
- **kind**: doc
- **url**: https://platform.claude.com/docs/en/build-with-claude/effort
- **whyDurable**: First-party API specification, not commentary. Defines which effort levels exist on which model tiers, what each level changes (token spend, tool-call count, reasoning depth), and Anthropic's own per-tier tuning guidance. Verified live 2026-06-25.
- **mustRead**: "Effort levels" table (low / medium / high / xhigh / max descriptions and model availability); per-model guidance sections for Sonnet 4.6, Opus 4.7, Opus 4.8, and Fable 5; "Effort with tool use" section
- **bearson**: tool-use/execution (effort changes tool-call count and verbosity); coding (medium) and coding (hard/debug) (xhigh/max guidance for hard agentic coding); short advisory (low effort guidance for subagents and classification); planning/orchestration (xhigh for long-running agentic work)

---

### [Anthropic Docs: Extended Thinking + Adaptive Thinking]
- **what**: Combined reference for extended thinking (model-internal reasoning before output) and adaptive thinking (model decides when and how much to think); covers supported models, thinking modes, effort-thinking interaction, and task classes that benefit
- **kind**: doc
- **url**: https://platform.claude.com/docs/en/build-with-claude/extended-thinking  ·  https://platform.claude.com/docs/en/build-with-claude/adaptive-thinking
- **whyDurable**: First-party API specification. Defines which models have thinking (Haiku 4.5: manual only; Sonnet 4.6: adaptive + deprecated manual; Opus 4.8: adaptive only; Fable 5: adaptive always-on). Thinking support is a key capability discriminator across tiers. Verified live 2026-06-25.
- **mustRead**: "Supported Models" table in extended-thinking; "Adaptive vs manual vs disabled thinking" comparison table; "Task Classes That Benefit" list in extended-thinking (math, debugging, multi-step reasoning, tool-use chains)
- **bearson**: math/formal reasoning (explicit mention of equations and proofs); coding (hard/debug) (debugging and optimization listed); planning/orchestration (adaptive interleaved thinking between tool calls); tool-use/execution

---

### [Anthropic Product Page: Claude Sonnet]
- **what**: Marketing + positioning page for Claude Sonnet 4.6 as a production model; describes capability focus areas and use cases
- **kind**: doc
- **url**: https://www.anthropic.com/claude/sonnet
- **whyDurable**: First-party Anthropic positioning statement. While marketing-framed, it reflects Anthropic's official intended use-case placement for the Sonnet tier. Verified live 2026-06-25.
- **mustRead**: Four primary use-case categories (advanced coding, long-running agents, browser/computer use, enterprise workflows); pricing statement; "hybrid reasoning model" descriptor
- **bearson**: coding (medium); planning/orchestration; tool-use/execution; synthesis/writing

---

### [Anthropic Product Page: Claude Opus]
- **what**: Marketing + positioning page for Claude Opus 4.8; describes the tier's strength in complex coding, agentic orchestration, and adaptive thinking
- **kind**: doc
- **url**: https://www.anthropic.com/claude/opus
- **whyDurable**: First-party Anthropic positioning. Reflects Anthropic's intended tier placement. Includes customer benchmark callouts (Online-Mind2Web: 84%; Legal Agent Benchmark first to break 10% all-pass). Verified live 2026-06-25.
- **mustRead**: "Adaptive Thinking" description; "Coding Strength" language; benchmark highlights section (CursorBench, Online-Mind2Web); "Recommended Use Cases" list
- **bearson**: coding (hard/debug); planning/orchestration; tool-use/execution; math/formal reasoning

---

### [Anthropic News: Introducing Claude Fable 5 and Claude Mythos 5 (API docs)]
- **what**: Official launch documentation for Claude Fable 5 — the most capable widely released Claude model as of 2026-06-25; covers API changes, adaptive thinking behavior, refusal classifiers, and capability positioning
- **kind**: doc
- **url**: https://platform.claude.com/docs/en/about-claude/models/introducing-claude-fable-5-and-claude-mythos-5
- **whyDurable**: First-party API changelog, dated June 9 2026. Defines Fable 5 as a new tier above Opus 4.8, with adaptive thinking always-on and no raw chain-of-thought visibility. This is the canonical source for what the Fable tier is and is not. Verified live 2026-06-25.
- **mustRead**: Feature list (effort, adaptive thinking always-on, 1M context, 128k output); "Adaptive thinking is always on" section; "Refusals" section (new API surface); FrontierCode and Hebbia Finance Benchmark callouts in the corresponding news announcement (https://www.anthropic.com/news/claude-fable-5-mythos-5)
- **bearson**: coding (hard/debug); math/formal reasoning; planning/orchestration; tool-use/execution

---

### [Anthropic: Claude Opus 4.8 System Card (PDF)]
- **what**: Official safety and capability evaluation document for Claude Opus 4.8; contains structured capability assessments across coding, reasoning, agentic tasks, and domain-specific benchmarks
- **kind**: report
- **url**: https://www-cdn.anthropic.com/0f0c97ad20d8005706296bd92aa1c27c6b2f4f61/Claude%20Opus%204.8%20System%20Card.pdf
- **whyDurable**: Anthropic's formal system card, published May 28 2026. Primary source for per-task-class capability evaluations for Opus tier. Covers coding, agentic, reasoning, multimodal, computer-use, and math evaluations, plus safety. The most structured per-task-class evidence in L1.
- **mustRead**: Capability evaluation section (coding, agentic, reasoning, math); benchmark results tables; any cross-model comparisons within the card
- **bearson**: coding (medium); coding (hard/debug); math/formal reasoning; planning/orchestration; tool-use/execution

---

## L2 — First Principles (Scaling and emergence research)

### [Kaplan et al. 2020 — Scaling Laws for Neural Language Models]
- **what**: Foundational OpenAI paper (Dario Amodei is co-author) establishing power-law relationships between model size, dataset size, compute, and cross-entropy loss; the empirical basis for the "bigger model = lower loss" principle underlying tier design
- **kind**: paper
- **url**: https://arxiv.org/abs/2001.08361
- **whyDurable**: Peer-reviewed; over 4,000 citations; published in 2020 as arXiv:2001.08361. The operating manual for foundation model scaling for the entire field. Foundational, not a hot take. Anthropic co-founders were co-authors.
- **mustRead**: Section on model-size vs dataset-size allocation ("larger models are significantly more sample-efficient"); power-law fit equations for loss vs parameters; implications for optimal compute allocation
- **bearson**: All task classes (via the premise that larger tiers have lower loss → higher capability) — but specifically illuminates the quantitative scaling gradient, not qualitative capability jumps. Most directly relevant to: coding (hard/debug), math/formal reasoning

---

### [Hoffmann et al. 2022 — Training Compute-Optimal Large Language Models (Chinchilla)]
- **what**: DeepMind paper showing that prior large models were undertrained; for a fixed compute budget, optimal performance requires equally scaling model size AND training tokens. Redefined the relationship between size and capability.
- **kind**: paper
- **url**: https://arxiv.org/abs/2203.15556
- **whyDurable**: Peer-reviewed; over 2,000 citations; foundational correction to Kaplan 2020. Directly influenced how Anthropic and competitors allocate training compute across model sizes. Durable because it altered the field's actual practice.
- **mustRead**: "Compute-optimal training" derivation; Table showing Chinchilla vs Gopher at equal compute; MMLU benchmark comparison (+7% gain from better allocation)
- **bearson**: planning/orchestration; coding (medium); short advisory — illuminates why a smaller, better-trained model can match a larger undertrained one, bearing on the Haiku-vs-Sonnet question at equal cost

---

### [Wei et al. 2022 — Emergent Abilities of Large Language Models]
- **what**: Google Brain survey paper defining "emergent abilities" as capabilities absent in smaller models but present in larger ones, and cataloguing tasks that show sharp performance transitions at scale thresholds
- **kind**: paper
- **url**: https://arxiv.org/abs/2206.07682
- **whyDurable**: Peer-reviewed (TMLR); over 1,400 citations per Semantic Scholar; this is the standard reference for emergence in LLMs. Directly bears on why Haiku and Sonnet might differ qualitatively — not just quantitatively — on certain task classes.
- **mustRead**: Definition of emergent ability and the "sharp transition" framing; the task catalogue (arithmetic, multi-step reasoning, language understanding, code generation tasks listed as emergent); caveats section (measurement artifacts debate)
- **bearson**: math/formal reasoning (arithmetic listed explicitly); coding (hard/debug) (code generation emergence); planning/orchestration (multi-step reasoning emergence); also relevant as a caution: what counts as "emergence" may be a measurement artifact

---

### [Ganguli et al. 2022 — Predictability and Surprise in Large Generative Models]
- **what**: Anthropic's own paper (Deep Ganguli + 29 co-authors, FAccT 2022) identifying the paradox: aggregate loss metrics scale predictably, but specific capability emergence — and failure — is unpredictable. The Anthropic-authored articulation of the limits of scaling-law thinking.
- **kind**: paper
- **url**: https://arxiv.org/abs/2202.07785  ·  (Anthropic CDN): https://www-cdn.anthropic.com/4ff80d7f8a98bf096cd543ec61ddc50de3ad8b16/Anthropic_PredictabilityAndSurprise.pdf
- **whyDurable**: Anthropic-authored, peer-reviewed and published at FAccT 2022 (ACM DL: https://dl.acm.org/doi/10.1145/3531146.3533229). Primary Anthropic voice on the limits of scaling-law predictability. Directly addresses how the company thinks about the predictable-vs-emergent tension that underlies any tier-selection recommendation.
- **mustRead**: The central paradox framing ("predictable loss, unpredictable capabilities"); discussion of which behavior classes are predictable vs unpredictable at scale; policy implications section (illuminates Anthropic's own epistemic humility about tier-to-task-class mapping)
- **bearson**: All task classes — this paper bears on the epistemological status of any tier-to-task mapping claim. Most directly: math/formal reasoning, coding (hard/debug) — the task classes most likely to show abrupt transitions

---

## Blind spots

**L1 blind spot**: Anthropic's official docs and product pages give almost no per-task-class, per-tier benchmark comparison in a single table. The model overview provides specs (latency, price, context) but not capability deltas. Haiku receives near-zero capability description — the Claude-4 launch post and product pages are silent on it for most task classes. The effort doc gives Anthropic's recommended starting points, but those are latency/cost guidance, not capability-ceiling statements. There is no publicly available matrix mapping task class × tier × effort level → expected quality. System cards contain the closest approximation, but they are PDFs with heterogeneous eval formats, not a structured comparison table. Official docs also say nothing about failure modes, inter-tier quality cliffs on specific prompting styles, or lived practitioner experience at the seat/agent level.

**L2 blind spot**: Scaling law papers (Kaplan 2020, Chinchilla 2022) measure cross-entropy loss on held-out data — a smooth, aggregate metric. They do not measure reliability in agentic or tool-use loops, cannot predict which API surface (effort level, thinking mode) unlocks a capability, and predate the current model naming convention entirely. The emergent abilities framing (Wei 2022) identifies sharp transitions but is contested as a measurement artifact rather than a true qualitative change. Crucially, L2 papers say nothing about: sub-task-class distinctions (coding medium vs hard/debug), the effect of effort levels on capability vs. cost, orchestration reliability across multi-step agent flows, or the practitioner's experience of which tier "feels right" for short advisory vs. deep reasoning tasks. The mapping from "lower loss at larger scale" to "pick Opus over Sonnet for planning" requires a chain of inference that none of these papers directly supply.
