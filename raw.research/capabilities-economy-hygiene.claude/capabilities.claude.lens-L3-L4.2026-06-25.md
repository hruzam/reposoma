# Lens L3+L4: Exemplar Benchmarks + Strategy Economics
`study: capabilities.claude · phase: 2-blind · date: 2026-06-25 · agent: @Epoch`

---

### [Aider.chat LLM Leaderboard — Polyglot Coding Benchmark]
- **what**: Industry-maintained coding benchmark measuring real-world code-editing ability on a polyglot set of real repositories; tracks cost-per-solve alongside accuracy, including thinking-on vs thinking-off rows for each model that supports extended thinking
- **kind**: benchmark
- **url**: https://aider.chat/docs/leaderboards/
- **whyDurable**: Maintained by an active open-source project with reproducible methodology; tracked continuously; widely cited as proxy for practical code-editing quality
- **mustRead**: The main "Polyglot" leaderboard table (percent-correct, cost-per-run, edit format per model); the extended-thinking rows that appear twice per model (thinking on vs off) — these show the cost-accuracy tradeoff of enabling thinking and are primary L4 evidence
- **bearson**: coding (medium), coding (hard/debug), tool-use/execution, math/formal reasoning; L4 cross-cut on cost-of-thinking premium
- **dateVerified**: 2026-06-25
- **numbers captured** (live-fetched 2026-06-25):
  - Claude Haiku 3.5 (Oct 2024): 28.0% correct, $6.06/run
  - Claude Sonnet 4 (May 2025, no thinking): 56.4% correct, $15.82/run
  - Claude Sonnet 4 (May 2025, 32k thinking tokens): 61.3% correct, $26.58/run (+4.9 pts, +68% cost)
  - Claude Opus 4 (May 2025, no thinking): 70.7% correct, $68.63/run
  - Claude Opus 4 (May 2025, 32k thinking tokens): 72.0% correct, $65.75/run (+1.3 pts, -4% cost — thinking slightly cheaper due to fewer completion tokens)
  - Note: "Sonnet 4" and "Opus 4" here are aider's May-2025 generation labels; cross-check against Anthropic's API model IDs before treating these as the 4.5/4.6/4.8 generation strings.

---

### [SWE-bench Leaderboard (Official) — Verified + Pro]
- **what**: The canonical software-engineering-agent benchmark; Verified variant uses 500 human-reviewed solvable GitHub issues; Pro variant uses 1,865 harder issues — the two are not interchangeable
- **kind**: benchmark
- **url**: https://www.swebench.com/
- **whyDurable**: Maintained by the original SWE-bench research team; closest thing to a standard for real-world SE agent evaluation
- **mustRead**: "SWE-bench Verified" tab filtered to Claude models; always label which variant (Verified vs Pro) when recording a score — a model's Pro score can be 30+ points lower than its Verified score
- **bearson**: coding (hard/debug), tool-use/execution, planning/orchestration
- **dateVerified**: 2026-06-25
- **numbers captured** (via llm-stats.com mirror, fetched 2026-06-25; primary swebench.com renders dynamically):
  - SWE-bench Verified scores:
    - Claude Fable 5: 95.0% (suspended as of 2026-06-12 per export-control directive)
    - Claude Mythos Preview: 93.9%
    - Claude Opus 4.8: 88.6%
    - Claude Opus 4.7: 87.6%
    - Claude Opus 4.5 / 4.6: ~80.8–80.9%
    - Claude Sonnet 4.6: 79.6%
    - Claude Haiku 4.5: 73.3%
  - SWE-bench Pro scores (Scale SEAL / morphllm secondary — not primary-source-confirmed):
    - Claude Opus 4.8: 69.2%
    - Claude Sonnet 4.6: 43.60%
    - Claude Haiku 4.5: 39.45%

---

### [Anthropic API Pricing — Official Docs]
- **what**: Official first-party pricing table for all Claude model tiers, including input/output token rates, prompt caching multipliers, batch discount, fast-mode pricing, and tool-use token overhead
- **kind**: doc
- **url**: https://platform.claude.com/docs/en/about-claude/pricing
- **whyDurable**: Primary source; maintained by Anthropic; the ground truth for any cost calculation
- **mustRead**: "Model pricing" table (all tiers, base + cache + output); "Fast mode pricing" table (Opus 4.6/4.7 at $30/$150 vs Opus 4.8 at $10/$50); "Batch processing" table (50% discount across all tiers); "Tool use pricing" (overhead token counts differ per model)
- **bearson**: all task classes — cross-cutting cost baseline; tool-use/execution (tool overhead tokens); planning/orchestration (Managed Agents session runtime at $0.08/session-hour)
- **dateVerified**: 2026-06-25
- **numbers captured** (live-fetched 2026-06-25, official pricing page):
  - Claude Fable 5: $10 input / $50 output per MTok
  - Claude Opus 4.8: $5 / $25 per MTok; Fast mode: $10 / $50 per MTok
  - Claude Opus 4.7 / 4.6: $5 / $25 per MTok; Fast mode: $30 / $150 per MTok
  - Claude Sonnet 4.6 / 4.5: $3 / $15 per MTok
  - Claude Haiku 4.5: $1 / $5 per MTok
  - Batch API: 50% discount on all models (e.g., Opus 4.8 batch = $2.50 / $12.50)
  - Prompt cache reads: 0.1x base input price (90% discount)
  - Prompt cache writes (1h): 2x base input price
  - Cost ratio Haiku:Sonnet:Opus input = 1:3:5 (at $1/$3/$5 per MTok)
  - Cost ratio Haiku:Sonnet:Opus output = 1:3:5 (at $5/$15/$25 per MTok)
  - Managed Agents session runtime: $0.08 per session-hour (additional to token costs)

---

### [Anthropic Models Overview — Official Docs]
- **what**: Authoritative model catalog with official API IDs, context windows, capability flags (extended thinking, adaptive thinking, fast mode), and Anthropic's own recommended use-case positioning per tier
- **kind**: doc
- **url**: https://platform.claude.com/docs/en/about-claude/models/overview
- **whyDurable**: Primary source; maintained by Anthropic; canonical reference for model IDs, feature flags, and capability envelope
- **mustRead**: "Latest models comparison" table (Opus 4.8 / Sonnet 4.6 / Haiku 4.5 side-by-side); the note on Opus 4.8 defaulting effort=high; Fable 5 / Mythos 5 entry; legacy model table; tokenizer warning for 4.7+ models
- **bearson**: all task classes — establishes feature-capability envelope per tier (which models have extended thinking vs adaptive thinking vs neither, context window limits)
- **dateVerified**: 2026-06-25
- **numbers captured** (live-fetched 2026-06-25):
  - Opus 4.8: 1M ctx, 128k output, extended thinking: No, adaptive thinking: Yes, effort param defaults to "high"
  - Sonnet 4.6: 1M ctx, 128k output, extended thinking: Yes, adaptive thinking: Yes
  - Haiku 4.5: 200k ctx, 64k output, extended thinking: Yes, adaptive thinking: No
  - Fable 5: 1M ctx, 128k output, adaptive thinking: Yes (always on), extended thinking: No
  - Fable 5 / Opus 4.7+ use a new tokenizer producing ~30% more tokens vs pre-4.7 models for the same text

---

### [morphllm.com — Claude Benchmarks Aggregator]
- **what**: Third-party aggregator compiling Claude model benchmark scores, API IDs, and pricing into a single cross-benchmark table; covers SWE-bench Verified, SWE-bench Pro, GPQA Diamond, Terminal-Bench 2.1, OSWorld
- **kind**: report
- **url**: https://www.morphllm.com/claude-benchmarks
- **whyDurable**: Snapshot aggregator; durability is "captures a dated cross-benchmark summary sourced from official Anthropic releases and public leaderboards as of June 2026." Not a primary source; treat as a pointer to verify against primaries.
- **mustRead**: The combined table of all Claude models with SWE-bench Verified %, SWE-bench Pro %, and pricing side-by-side; the GPQA Diamond / OSWorld / Terminal-Bench rows for Opus 4.8
- **bearson**: coding (medium), coding (hard/debug), math/formal reasoning, tool-use/execution
- **dateVerified**: 2026-06-25
- **numbers captured** (live-fetched 2026-06-25):
  - Opus 4.8: SWE-bench Verified 88.6%, SWE-bench Pro 69.2%, GPQA Diamond 93.6%, Terminal-Bench 2.1 74.6%, OSWorld 83.4%
  - Opus 4.7: SWE-bench Verified 87.6%, SWE-bench Pro 64.3%
  - Sonnet 4.6: SWE-bench Verified 79.6%, SWE-bench Pro (via Scale SEAL) 43.60%
  - Haiku 4.5: SWE-bench Verified 73.3%, SWE-bench Pro (via Scale SEAL) 39.45%

---

### [arena.ai Leaderboard (formerly lmarena.ai / LMSYS Chatbot Arena)]
- **what**: Human-preference ELO ranking across model tiers based on blind pairwise comparisons by real users; the primary source for human-preference signal as opposed to task-accuracy signal
- **kind**: benchmark
- **url**: https://arena.ai/leaderboard
- **whyDurable**: Longest-running human-preference benchmark; consistent blind-pairwise-Elo methodology; covers coding, reasoning, and writing sub-category leaderboards
- **mustRead**: Overall leaderboard ELO rankings; the Coding and Agent sub-category leaderboards; whether Claude tiers are separated across categories (Opus vs Sonnet vs Haiku may rank differently by domain)
- **bearson**: synthesis/writing, short advisory, coding (medium) — captures human preference which diverges from task-accuracy benchmarks
- **dateVerified**: 2026-06-25
- **numbers captured**: Page rendered dynamically; specific ELO values were not extractable in this run. Visit the live site and filter by category. Values must not be reconstructed from memory.

---

### [Rootly — Claude Sonnet 4.6 Benchmark Results and Lessons for AI SRE]
- **what**: Independent engineering blog reporting a domain-specific benchmark (SRE-skills-bench) comparing Sonnet 4.6 vs Opus 4.6 vs Sonnet 4.5 on production-relevant tasks including AWS policy evaluation and agentic incident investigation
- **kind**: blog
- **url**: https://rootly.com/blog/claude-sonnet-4-6-benchmark-results-and-lessons-for-ai-sre
- **whyDurable**: Snapshot; durability is "dated empirical comparison on a specific domain benchmark as of publication date, not a maintained leaderboard." Evidence of where tier gaps emerge in specialized, policy-sensitive tasks.
- **mustRead**: The per-domain score breakdown (AWS S3 security, IAM policies, networking); the finding about agentic incident investigation where Sonnet 4.6 sometimes exceeded Opus 4.6 via adaptive thinking
- **bearson**: tool-use/execution, planning/orchestration, coding (hard/debug)
- **dateVerified**: 2026-06-25
- **numbers captured** (live-fetched 2026-06-25):
  - Sonnet 4.6 overall: 90.4% on SRE-skills-bench; Opus 4.6: 94.7%; Sonnet 4.5: 85.9%
  - Largest gap: AWS S3 security: Sonnet 75.7% vs Opus 91.9% (16.2-pt delta)
  - AWS IAM policies: Sonnet 85.2% vs Opus 92.2% (7-pt delta)
  - AWS networking: Sonnet 97.1% = Opus 97.1% (no gap)
  - Agentic incident investigation: Sonnet 4.6 "performed similarly to Opus 4.6 on root cause accuracy, and in a few cases even beat it"

---

### [Shawn Kanungo — Claude Sonnet 4.6 vs Opus 4.6 Cost-Performance Analysis]
- **what**: Practitioner blog post analyzing cost-performance tradeoffs of Sonnet 4.6 vs Opus 4.6 with real-world routing strategies; includes GPQA Diamond comparison and token-efficiency claims
- **kind**: blog
- **url**: https://shawnkanungo.com/blog/claude-sonnet-46-vs-opus-46-whats-the-difference-and-which-one-should-you-use
- **whyDurable**: Snapshot; durability is "practitioner analysis anchored to Sonnet 4.6 / Opus 4.6 release period." The cost-ratio and benchmark numbers are verifiable against primaries; routing recommendations are the author's synthesis.
- **mustRead**: The GPQA Diamond comparison table; the cost-multiple section; the token-efficiency claim (Opus uses 19.3% fewer tokens for comparable outputs in reported scenarios, not yet verified against primary)
- **bearson**: math/formal reasoning, planning/orchestration, short advisory; L4 cross-cut on cost-per-task vs cost-per-token
- **dateVerified**: 2026-06-25
- **numbers captured** (live-fetched 2026-06-25):
  - GPQA Diamond: Sonnet 4.6 74.1% vs Opus 4.6 91.3% (17.2-pt gap — largest cross-benchmark divergence found in this run)
  - SWE-bench Verified: Sonnet 4.6 79.6% vs Opus 4.6 80.8% (1.2-pt gap — near-parity)
  - Computer use/GUI automation: Sonnet 72.5% vs Opus 72.7% (essentially equivalent)
  - Reported cost advantage: 60–80% cost reduction when routing routine tasks to Sonnet (author's claim)
  - Input cost ratio: Opus 1.67x Sonnet ($5 vs $3 per MTok); output cost ratio: same (1.67x)
  - Claim (not yet verified against primary): Opus uses 19.3% fewer tokens per task in complex scenarios

---

### [Caylent — Claude Haiku 4.5 Deep Dive: Cost, Capabilities, Multi-Agent Opportunity]
- **what**: Engineering blog post with structured cost modeling comparing Haiku 4.5 vs Sonnet in multi-agent and high-volume scenarios; includes three concrete cost scenarios and a task-routing framework
- **kind**: blog
- **url**: https://caylent.com/blog/claude-haiku-4-5-deep-dive-cost-capabilities-and-the-multi-agent-opportunity
- **whyDurable**: Snapshot; durability is "structured cost modeling at Haiku 4.5 release with verifiable per-token inputs — the scenario math is reproducible against the official pricing page." Routing recommendations are the author's synthesis.
- **mustRead**: The three cost scenarios (free-tier chatbot / agent with extended thinking / batch with caching); the Haiku vs Sonnet 3x cost advantage claim; OSWorld score for Haiku 4.5; context window constraint section
- **bearson**: tool-use/execution, planning/orchestration (sub-agent routing); L4 cost-per-task analysis at volume
- **dateVerified**: 2026-06-25
- **numbers captured** (live-fetched 2026-06-25):
  - Haiku 4.5: SWE-bench Verified 73.3%; OSWorld 50.7% (highest in the Haiku line to date)
  - 3x cost advantage over Sonnet 4.5 across modeled scenarios ($1/$5 vs $3/$15 per MTok)
  - Free-tier chatbot (100K sessions/month): Haiku $2,250 vs Sonnet $6,750
  - Agent with extended thinking (10K tasks/month): Haiku $700 vs Sonnet $2,100
  - Batch with caching (100 requests): Haiku $1.56 vs Sonnet $4.67

---

### [morphllm.com — Best AI Model for Coding (June 2026): Cost-Per-Solved-Point]
- **what**: Cross-model cost-efficiency analysis computing cost-per-solved-point on SWE-bench Pro, enabling comparison by economic efficiency rather than raw score; includes routing recommendations per task complexity
- **kind**: report
- **url**: https://www.morphllm.com/best-ai-model-for-coding
- **whyDurable**: Snapshot aggregator; durability is "dated cost-per-task analysis at June 2026 using public pricing and Scale SEAL SWE-bench Pro data." Not a maintained primary leaderboard.
- **mustRead**: The cost-per-point table comparing Claude tiers; the Haiku 4.5 efficiency finding; task-class routing guidance for sub-agent vs primary-agent work
- **bearson**: coding (medium), coding (hard/debug); L4 cost-per-task — the metric that per-token pricing tables cannot surface
- **dateVerified**: 2026-06-25
- **numbers captured** (live-fetched 2026-06-25):
  - Haiku 4.5: ~$0.13 output per SWE-bench Pro point (efficiency leader despite lower absolute score)
  - Morphllm's framing (not Epoch's verdict): Haiku achieves ~67% of GPT-5.4 task resolution at one-third the output cost
  - Source recommendation surfaced: route "quick edits, lint fixes, and explore-style subagents" to Haiku

---

## Coverage gap noted during this run

**HumanEval / MMLU / LiveCodeBench per-model breakdowns:** These benchmarks were listed as primary targets for L3. Search was performed; no retrievable Claude-tier comparison table for HumanEval or LiveCodeBench was found in sources accessible this run. The SWE-bench family and aider Polyglot dominated the retrievable coding-benchmark landscape. A researcher pulling Phase 3 should attempt direct fetch of livecode.bench or the HumanEval GitHub result tables for Claude-specific entries.

---

## L3 blind spot

Public coding and reasoning benchmarks (SWE-bench, Polyglot, GPQA) systematically miss:
1. **Multi-turn and multi-agent coherence** — benchmarks test single-task completion; temple agents are long-horizon loops where error propagation, context degradation, and self-correction matter more than single-shot accuracy.
2. **Synthesis and short-advisory tasks** — no clean public benchmark covers writing quality, judgment on ambiguous planning questions, or the brevity/precision tradeoff of short advisory. Human-preference (arena.ai) partially covers this but is noisy and not decomposed by task class.
3. **Effort-level calibration** — benchmarks run at fixed thinking budgets do not capture whether a model correctly *chooses* when to think deeply vs return quickly. Opus 4.8's effort=high default is an Anthropic design choice that no benchmark evaluates.
4. **Tool orchestration failure modes** — SWE-bench measures task success, not intermediate tool-call efficiency or error-recovery quality under partial failure, which matters for agentic seats.

## L4 blind spot

Per-token pricing analysis misses:
1. **Tokens-per-task asymmetry** — a higher-tier model that solves a problem in fewer tool calls and fewer completion tokens may be cheaper per task even at a higher per-token rate. The "Opus uses 19.3% fewer tokens" claim (Kanungo, unverified against primary) and the aider.chat finding that Opus 4 with thinking costs *less* than without thinking (due to fewer completion tokens) both point to this. Cost-per-solved-task (as morphllm attempts) is more meaningful than cost-per-token for planning and orchestration seats.
2. **Failure cost** — if a cheaper model fails and the agent retries (or a human must intervene), the total cost includes the failed run. Pricing analysis that ignores failure rate and retry overhead undercounts the true cost of routing hard tasks to Haiku or Sonnet.
3. **Context window constraint as a cost lever** — Haiku 4.5 is capped at 200k tokens vs 1M for Sonnet/Opus. Long-context tasks that exceed Haiku's window require chunking overhead or forced tier escalation; neither cost is visible in per-token pricing.
4. **Fast mode and effort level as separate cost axes** — Opus 4.8 fast mode at $10/$50 costs the same as Fable 5 standard; Opus 4.7 fast mode at $30/$150 is 6x Sonnet. Pricing analysis that treats each model as a single price-point misses the effort/speed-mode dimension that determines actual per-task cost in production.
