# Dive A — Haiku 4.5 Capability Ceiling
`study: capabilities.claude · phase: 4-dive · date: 2026-06-25 · agent: @Epoch`

---

```
topic: Option A — Haiku 4.5 capability ceiling
summary: >
  Haiku 4.5 is a qualitatively different model from Haiku 3.5 — its SWE-bench Verified
  score (73.3%, with 128K thinking budget) places it within 6.3 points of current Sonnet 4.6
  and at ~90% of Sonnet 4.5 on agentic coding evaluations. It is genuinely sufficient for
  the Delta seat (surgical sub-agent execution, scaffolding, file ops, tool loops) at 3x lower
  cost, but it degrades on multi-step deductive chains (3+ logical hops), architecture-level
  reasoning, and complex debugging. Two calibration warnings for the proposed temple design:
  the 200K escalation trigger fires too late (context rot begins at 64–128K); and enabling
  thinking on Haiku during agentic tool-use loops may harm rather than help performance,
  even though thinking benefits code-review tasks.
```

---

## Core Question 1 — Haiku 4.5 Coding Ceiling

### keyFindings:

**Finding 1.1 — SWE-bench Verified: 73.3% with thinking baked in**

```
claim: >
  Haiku 4.5 scores 73.3% on SWE-bench Verified. This number already includes extended
  thinking — it was measured "averaged over 50 trials with 128K thinking budget" (Anthropic
  official announcement). It is not a base score with a thinking premium available on top in
  this regime. The gap to current-generation Sonnet 4.6 (79.6%) is 6.3 points. The gap to
  Opus 4.8 (88.6%) is 15.3 points.
evidence: >
  Anthropic news release (anthropic.com/news/claude-haiku-4-5); confirmed by morphllm.com
  aggregator; cross-confirmed by SWE-bench Pro secondary data (Haiku 4.5: 39.45%,
  Sonnet 4.6: 43.60%) from Scale SEAL via morphllm.
citations:
  - https://www.anthropic.com/news/claude-haiku-4-5
  - https://www.morphllm.com/claude-benchmarks
confidence: high
bearing: >
  The 6.3-point SWE-bench gap vs Sonnet 4.6 is real but narrow — smaller than the
  Opus/Sonnet gap on GPQA Diamond (17.2 points). For the Delta seat (agentic sub-agent
  loops, surgical edits, scaffolding), the relevant signal is agentic coding eval performance,
  not just SWE-bench single-task resolution.
```

**Finding 1.2 — Haiku 4.5 on aider Polyglot: not found**

```
claim: >
  Haiku 4.5 does not appear on the aider Polyglot leaderboard as of 2026-06-25. The only
  Haiku entry on that leaderboard is Haiku 3.5 at 28.0% correct ($6.06/run). No Haiku 4.5
  Polyglot score is available from aider.chat or llm-stats.com at this date.
evidence: >
  Direct fetch of aider.chat/docs/leaderboards/ returned no Haiku 4.5 entry. llm-stats.com
  model pages for Haiku 4.5 do not list an aider Polyglot score. No independent source
  confirmed a Polyglot figure for Haiku 4.5.
citations:
  - https://aider.chat/docs/leaderboards/ (fetched 2026-06-25, no Haiku 4.5 entry)
  - https://llm-stats.com/models/claude-haiku-4-5-20251001 (no Polyglot score listed)
confidence: high (high confidence in the gap; this is not a found number)
bearing: >
  The Haiku 3.5 → Haiku 4.5 generational jump cannot be quantified on Polyglot. The
  Polyglot benchmark remains an open slot for Haiku 4.5. Do not use the 28% as a
  comparison baseline — the model generation change is categorical, not incremental.
openGap: true
```

**Finding 1.3 — Custom 38-task real-world suite: 95.9% quality, 1 failure on reasoning**

```
claim: >
  On a practitioner-run 38-task benchmark covering extraction, code, reasoning, writing,
  planning, data, math, and health tasks: Haiku 4.5 scored 95.9% quality (37/38 pass) at
  $0.04/run vs Sonnet 4.6 at 100% (38/38, $0.20/run). Haiku's single failure was a
  reasoning task (root cause analysis: it identified the surface-level trigger, not the
  underlying configuration flaw). On pure coding tasks, both models scored 100%.
evidence: >
  ianlpaterson.com/blog/llm-benchmark-2026-38-actual-tasks-15-models-for-2-29/
  (independent practitioner benchmark, 38 tasks, 15 models, 2026 publication).
  IMPORTANT: these are NOT aider Polyglot scores — this is an independent 38-task suite.
citations:
  - https://ianlpaterson.com/blog/llm-benchmark-2026-38-actual-tasks-15-models-for-2-29/
confidence: med
bearing: >
  Supports the routing heuristic: Haiku handles shallow-to-medium coding tasks at near-
  Sonnet quality. Failure emerges specifically on multi-step deductive reasoning (root cause
  analysis), not on execution-style coding. Delta seat tasks (file ops, edits, scaffolding,
  bash) fall in Haiku's passing range.
```

**Finding 1.4 — Agentic coding eval (Augment): Haiku 4.5 at 90% of Sonnet 4.5**

```
claim: >
  In Augment's agentic coding evaluation (multi-step, tool-assisted), Haiku 4.5 achieves
  90% of Sonnet 4.5's performance. Anthropic states it "matches Sonnet 4's performance on
  coding, computer use, and agent tasks" — but this comparison is to Sonnet 4 (May 2025
  generation), not current Sonnet 4.5 or 4.6. Against current Sonnet 4.6, the gap is real
  (6.3 SWE-bench points, 90% agentic parity vs 4.5).
evidence: >
  Anthropic news release (anthropic.com/news/claude-haiku-4-5); Augment agentic coding
  evaluation cited in release.
citations:
  - https://www.anthropic.com/news/claude-haiku-4-5
confidence: med
bearing: >
  "90% of Sonnet 4.5" in agentic eval is the honest ceiling framing for Delta seat design.
  Not parity with current-generation Sonnet — meaningful but not disqualifying for
  sub-agent surgical roles.
```

**Finding 1.5 — Morph routing: 60% of prompts show zero Haiku/Sonnet quality difference; 40% diverge**

```
claim: >
  Morph LLM analysis of real production sessions: 30 of 50 typical prompts (~60%) show
  "essentially indistinguishable" quality between Haiku and Sonnet. The ~40% where Haiku
  fails: (a) multi-step reasoning chains of 3+ logical hops, (b) code generation from spec
  (writing new functions/classes/modules), (c) architecture-level analysis and cross-file
  reasoning. Simple coding (extraction, formatting, routing, intent detection, completion)
  consistently falls in the 60%.
evidence: >
  morphllm.com/sonnet-vs-haiku (direct fetch 2026-06-25). Corroborated by ianlpaterson
  finding that Haiku fails root-cause analysis while passing pure coding tasks.
citations:
  - https://www.morphllm.com/sonnet-vs-haiku
confidence: med
bearing: >
  Delta seat task profile (surgical edits, file reads, bash execution, scaffolding, exploration)
  maps primarily into the 60% regime. The 40% failure zone — spec-driven code generation
  from scratch, architecture analysis, multi-hop debug — is exactly what Sonnet escalation
  should catch.
```

**Finding 1.6 — Anthropic's own Claude Code uses Haiku for Explore and claude-code-guide**

```
claim: >
  Claude Code's internal Explore sub-agent runs on Haiku by default (read-only, search/
  understand codebase). The claude-code-guide agent also runs on Haiku. This is Anthropic's
  own production routing decision — evidence that the engineering team is confident in
  Haiku for structured, scoped, read-oriented tasks in a real agentic system.
evidence: >
  GitHub issue HKUDS/OpenHarness #153 (bug report for hard-coded model="haiku" in
  Explore and claude-code-guide agents — indirect but specific); codewithseb.com subagent
  guide confirming Haiku as default for Explore; Anthropic marketing page confirming Haiku
  4.5 for multi-agent sub-agent roles.
citations:
  - https://github.com/HKUDS/OpenHarness/issues/153
  - https://www.codewithseb.com/blog/claude-code-sub-agents-multi-agent-systems-guide
  - https://www.anthropic.com/claude/haiku
confidence: med
bearing: >
  Strong signal for the Delta seat design: Anthropic itself treats Haiku as production-grade
  for the read/explore tier of agentic coding. The Delta seat (scoped execution, surgical
  edits, scaffolding) is a narrower and more structured version of what Explore does.
```

---

## Core Question 2 — Haiku 4.5 + Manual Thinking

### keyFindings:

**Finding 2.1 — Thinking is already baked into the 73.3% ceiling; it is not a free upgrade**

```
claim: >
  The 73.3% SWE-bench Verified score is measured with a 128K thinking budget. This is the
  thinking-on number. There is no published base (thinking-off) SWE-bench score for Haiku
  4.5 to compare against. The question "does enabling thinking close the gap with Sonnet?"
  cannot be answered from available data because the ceiling is already a thinking-on figure.
evidence: >
  Anthropic news release: "73.3% on SWE-bench Verified (averaged over 50 trials with 128K
  thinking budget)."
citations:
  - https://www.anthropic.com/news/claude-haiku-4-5
confidence: high
bearing: >
  Critical for the proposed temple design. The Delta seat cannot treat thinking as a reserve
  capability that upgrades Haiku closer to Sonnet — the benchmark ceiling already assumes
  thinking. The real question is whether to enable thinking at all given the agentic-loop risk
  (see Finding 2.2).
```

**Finding 2.2 — Thinking helps on code review; thinking hurts on agentic tool loops (SPLIT)**

```
claim: >
  Qodo's benchmark (400 real PRs): Haiku 4.5 with 4096-token thinking budget wins 58% of
  comparisons vs Sonnet 4.5's 42% on code review quality (scores 7.29 vs 6.60). BUT:
  Qodo's own limitation statement is "measures single-pass code-review reasoning only — not
  tool calling, code execution, repository navigation, or multi-step agentic workflows."
  The arXiv preprint 2502.08235 (4,018 agent trajectories, 19 models) found extended
  thinking causes "nearly 3x higher" overthinking failure rates in agentic tasks. Anthropic's
  own inverse-scaling research identified 4 task classes where longer reasoning degrades
  performance (complex deduction, regression, counting, safety scenarios). These two bodies
  of evidence apply to different regimes — the code-review benefit and the agentic-loop
  harm are BOTH real, they apply to DIFFERENT task structures.
evidence: >
  Qodo benchmark: qodo.ai/blog/thinking-vs-thinking-benchmarking-claude-haiku-4-5-and-
  sonnet-4-5-on-400-real-prs/ (fetched 2026-06-25).
  arXiv 2502.08235: arxiv.org/abs/2502.08235 (4,018 trajectories).
  Anthropic inverse-scaling: istartvalley.org/blog/anthropic-researchers-discover-the-weird-
  ai-problem-why-thinking-longer-makes-models-dumber.
  AI Transfer Lab code taxonomy: medium.com/@ai_transfer_lab (pattern-based tasks,
  repetitive transformations, formatting — all harmed by thinking).
citations:
  - https://www.qodo.ai/blog/thinking-vs-thinking-benchmarking-claude-haiku-4-5-and-sonnet-4-5-on-400-real-prs/
  - https://arxiv.org/abs/2502.08235
  - https://www.istartvalley.org/blog/anthropic-researchers-discover-the-weird-ai-problem-why-thinking-longer-makes-models-dumber
confidence: high (the split is well-evidenced; uncertainty is which regime a specific Delta task falls in)
bearing: >
  CRITICAL for Delta seat design. Delta tasks are agentic tool loops (file reads, edits, bash,
  execution, scaffolding) — the EXACT regime where overthinking research shows harm, not
  the code-review regime where Qodo shows benefit. Default recommendation: thinking OFF
  for Delta's tool-use execution loops; consider thinking ON only for planning phase
  (before the tool loop begins) or for single-pass reasoning on specific hard tasks.
```

**Finding 2.3 — "Haiku + moderate thinking" cost tier: real but conditional**

```
claim: >
  A "Haiku + thinking" tier is economically coherent: thinking tokens bill at output rate
  ($5/MTok for Haiku), so a 4096-token thinking budget adds ~$0.02 per call — small
  relative to the 3x cost advantage over Sonnet. However, thinking tokens break prompt
  caching (each call has a unique thinking trace, disrupting cache hit patterns), which can
  erode the cost advantage in high-volume repeated-context scenarios.
evidence: >
  Pricing: platform.claude.com/docs/en/about-claude/pricing ($1/$5 Haiku input/output).
  Cache break: AI Transfer Lab code taxonomy (medium.com/@ai_transfer_lab) citing
  "thinking tokens from one call don't carry forward, breaking prompt caching."
  Qodo benchmark showing quality improvement in thinking mode.
citations:
  - https://platform.claude.com/docs/en/about-claude/pricing
  - https://www.qodo.ai/blog/thinking-vs-thinking-benchmarking-claude-haiku-4-5-and-sonnet-4-5-on-400-real-prs/
confidence: med
bearing: >
  If Delta uses thinking selectively (not on every call), the cache-break cost is manageable.
  If every Delta call runs thinking, caching benefits disappear. Design consideration: gate
  thinking on task type, not on model tier.
```

---

## Core Question 3 — The 200k Context Cap

### keyFindings:

**Finding 3.1 — Context rot begins at 64–128K, not 200K**

```
claim: >
  The 200K advertised context window does not represent 200K of reliable working capacity.
  Production analysis (callsphere.ai, backed by frontier-model testing) identifies three zones:
  strong retrieval through ~64K; noticeable degradation at 64K–128K; steep decline above
  ~128K (for multi-needle reasoning: double-digit point drops vs 32K performance). Single-
  needle retrieval holds relatively well; instruction adherence degrades earlier, especially
  for content placed at 30–70% of context depth. Practical production rule: use no more
  than 25% of advertised context for tasks requiring precise retrieval or strict instruction
  adherence — for Haiku 4.5 this means a safe working budget of ~50K tokens.
evidence: >
  callsphere.ai/blog/claude-200k-context-window-effective-memory-myth (direct fetch
  2026-06-25). General frontier-model pattern corroborated by morphllm context window
  analysis.
citations:
  - https://callsphere.ai/blog/claude-200k-context-window-effective-memory-myth
  - https://www.morphllm.com/claude-context-window
confidence: med (general frontier heuristic, not Haiku-4.5-specific measurement)
bearing: >
  CALIBRATION WARNING for the proposed temple design. The operator's proposed escalation
  trigger ("upgrade to Sonnet when context cap hit [200k]") fires too late. Degradation
  likely begins 3–4x earlier. Recommended recalibration: escalation trigger at 100–128K
  (context loading safety margin), not at 200K hard cap. Flag: this is a general heuristic
  — Haiku-4.5-specific context-degradation measurements have not been published.
```

**Finding 3.2 — Specific task patterns that hit the cap in agentic loops**

```
claim: >
  In a real agentic loop on a moderate codebase (e.g., OpenCart or Laravel), the 200K token
  cap fills from: accumulated tool call history (each Read/Edit/Bash exchange adds 1–5K
  tokens); large file reads that are not truncated or summarized; multi-turn planning traces
  if thinking traces are retained in context; and growing system prompt + conversation
  history as sub-tasks chain. A session reading 20 large files (avg 5K tokens each) and
  accumulating 40 tool calls (avg 3K tokens each) consumes 220K tokens — over cap — with
  no single operation seeming excessive.
evidence: >
  Derived from context structure analysis. Corroborated by callsphere.ai practical rules
  (summarize/truncate older history, compress reference material, include only relevant
  context per request). No direct Haiku-4.5-specific agentic loop measurement found.
citations:
  - https://callsphere.ai/blog/claude-200k-context-window-effective-memory-myth
  - https://www.juheapi.com/blog/claude-haiku-4-5-20251001-context-window-200000-tokens-guide
confidence: med (derived calculation, not measured data)
bearing: >
  The Delta seat should use context window consumption as a first-class metric, not an
  afterthought. Consider: explicit tool-call history truncation after N calls, file read
  chunking rather than full-file ingestion, and proactive session handoff before context
  pressure accumulates. The escalation trigger should be context-consumption-based (e.g.,
  >100K tokens consumed), not "hit 200K cap."
```

---

## Core Question 4 — Haiku in Orchestration

**Finding 4.1 — OSWorld 50.7%: highest in Haiku line; computer use as a Haiku strength**

```
claim: >
  Haiku 4.5 scores 50.7% on OSWorld (GUI/computer-use benchmark), described as "highest
  in the Haiku line to date." Anthropic states it "surpasses Sonnet 4 at certain tasks, like
  using computers." This places computer-use and structured GUI interaction in a genuine
  Haiku strength zone, not just a "sufficient" zone.
evidence: >
  caylent.com/blog/claude-haiku-4-5-deep-dive-cost-capabilities-and-the-multi-agent-
  opportunity (fetched 2026-06-25); Anthropic news release.
citations:
  - https://caylent.com/blog/claude-haiku-4-5-deep-dive-cost-capabilities-and-the-multi-agent-opportunity
  - https://www.anthropic.com/news/claude-haiku-4-5
confidence: med
bearing: >
  Delta seat computer-use and bash execution fall in a Haiku advantage zone. This strengthens
  the case for Haiku as primary execution agent for tool-use intensive, structured sub-tasks.
```

**Finding 4.2 — Cost efficiency: $0.13/SWE-bench Pro point (efficiency leader)**

```
claim: >
  Morph LLM cost-per-point analysis: Haiku 4.5 achieves ~$0.13 output cost per SWE-bench
  Pro point — the efficiency leader even at lower absolute scores. At 3x lower cost than
  Sonnet ($1/$5 vs $3/$15 per MTok), with failure cost factored in, Haiku becomes net
  cheaper than Sonnet on any task class where its success rate is above ~33% of Sonnet's.
  For the 60% of tasks where quality is indistinguishable, Haiku is strictly dominant.
evidence: >
  morphllm.com/best-ai-model-for-coding (fetched 2026-06-25).
  Pricing: platform.claude.com/docs/en/about-claude/pricing.
citations:
  - https://www.morphllm.com/best-ai-model-for-coding
  - https://platform.claude.com/docs/en/about-claude/pricing
confidence: med
bearing: >
  Strong economic case for Haiku as the default Delta tier. The correction-rate escalation
  trigger (>20% correction → upgrade to Sonnet) is economically sound given the 3x cost
  ratio: even at 19% correction rate, retrying on Sonnet for corrections costs less than
  running Sonnet for 100% of tasks.
```

---

## strongestClaim:

```
Haiku 4.5 is a qualitatively sufficient model for the Delta seat. The evidence is:
(1) 73.3% SWE-bench Verified (thinking included) — within 6.3 points of Sonnet 4.6;
(2) Anthropic's own Claude Code uses Haiku for Explore (read-oriented agentic sub-agent),
    demonstrating production confidence in the same role profile;
(3) 95.9% pass rate on a 38-task real-world coding suite — failure emerged only in
    multi-step deductive reasoning, not execution-style coding;
(4) 90% of Sonnet 4.5 performance on Augment's agentic coding evaluation.
The ceiling is real (architecture analysis, 3+ logical-hop debug fail), but it sits outside
the surgical execution profile of the Delta seat. Sonnet escalation for those cases is the
right design, not Sonnet-as-default.
```

## biggestLimitation:

```
The aider Polyglot score for Haiku 4.5 is not available. This is the one benchmark that
directly measures multi-language code-editing ability with cost-per-run, and Haiku 4.5 is
absent from it. The Haiku 3.5 → Haiku 4.5 improvement on this specific benchmark cannot
be quantified. All coding quality claims rest on SWE-bench (already includes thinking) and
practitioner composite tests — neither of which isolates the "surgical code edit across
multiple languages" task class that the Polyglot benchmark was designed to measure.
Additionally, all "Haiku matches Sonnet" evidence comes from sources with selection bias
toward cost-optimization conclusions (Qodo, morphllm, caylent, Anthropic marketing) — a
systematic skew that the operator should weight accordingly.
```

## openQuestions:

```
- Haiku 4.5 on aider Polyglot: not found as of 2026-06-25. Monitor aider.chat leaderboard.
- Haiku 4.5 context degradation curve: no Haiku-specific measurement. The 64K heuristic
  is frontier-model-general, not Haiku-specific. Operator's own codebase testing recommended.
- Thinking on/off delta for Haiku 4.5: 73.3% already includes thinking; base (thinking-off)
  SWE-bench score not published. Unknown how much thinking contributes to the ceiling.
- Correction rate in practice: the proposed >20% trigger is sourced from morphllm's routing
  guidance, not measured on actual Delta seat tasks. Should be calibrated against the first
  real project run (OpenCart or Laravel equivalent).
- Token accumulation rate in real agentic loops on the operator's codebases: unquantified.
  The 100–128K escalation threshold is a heuristic, not a measured optimum.
```

## emergentPatterns:

```
- name: Thinking regime split
  description: >
    Extended thinking improves code-review quality (Qodo: +15% win rate, +0.69 quality
    score) but harms agentic tool-loop performance (arXiv 2502.08235: 3x higher overthinking
    failure; Anthropic inverse-scaling: 4 task classes degrade). These are not contradictory
    — they apply to categorically different task structures. Code review = single-pass
    reasoning. Agentic loops = multi-step tool orchestration. The split is now well-
    evidenced across multiple independent sources.
  distinctFrom: >
    The simple claim "thinking helps" or "thinking hurts" — both are wrong in isolation.
    The split is real and must be modeled at the task-class level, not the model level.
  status: real-and-adopted

- name: Context rot front-loading (the 25% rule)
  description: >
    No frontier model maintains short-context performance at its advertised maximum. The
    practical safe zone is ~25% of advertised context for retrieval and instruction-adherence
    tasks. For Haiku 4.5's 200K window, this means ~50K effective working budget. The
    escalation trigger must fire at context-consumption metrics, not at the hard cap.
  distinctFrom: >
    Context window size as a capability: the 200K spec is a physical limit, not a quality
    guarantee. Sonnet/Opus's 1M window matters not because agents use 1M tokens reliably
    but because their effective 25% zone (~250K) is much larger than Haiku's (~50K).
  status: real-and-adopted

- name: Sub-agent Haiku as Anthropic default
  description: >
    Anthropic's own Claude Code routes its read-oriented Explore sub-agent to Haiku. This
    is a revealed preference from the builder of the models, not a third-party claim. It
    anchors the Delta seat design as consistent with Anthropic's own production judgment,
    not as a cost-cutting compromise.
  distinctFrom: >
    "Haiku is cheap, use it where quality doesn't matter" — the Anthropic Explore routing
    signals that for structured, scoped agentic sub-tasks, Haiku is not a quality compromise,
    it is the correct tier.
  status: real-and-adopted

- name: Capability inversion at context extremes
  description: >
    Opus 4.7/4.6 lacks the 1M-token context window available on Sonnet 4.6 (and Haiku 4.5
    has 200K vs Sonnet's 1M). At context extremes, tier hierarchy inverts: Sonnet handles
    long-context better than Opus. Similarly, Haiku's 200K cap forces escalation not because
    of reasoning quality but because of physical context limits. The tier hierarchy
    is not monotone across all task dimensions.
  distinctFrom: >
    Linear tier hierarchy (Opus > Sonnet > Haiku across all axes) — falsified by context
    window differences and the Sonnet > Opus 4.6/4.7 inversion.
  status: real-and-adopted
```

---

## Calibration flags for the proposed temple design

1. **Escalation trigger: recalibrate from 200K to 100–128K.** The proposed "upgrade to Sonnet when context cap hit (200K)" fires too late — degradation begins well before the hard cap. Recommend: trigger at measured context consumption >100K (or empirically tuned during first real project run). Confidence: med (frontier-general heuristic, not Haiku-specific).

2. **Thinking policy for Delta: off by default in tool loops.** The arXiv and Anthropic inverse-scaling evidence applies to agentic tool loops — the Delta seat's primary regime. Enable thinking selectively for planning phases or isolated hard reasoning tasks, not as a blanket upgrade. The Qodo benefit (thinking wins 58% on code review) does not transfer to multi-step tool execution.

3. **"Matches Sonnet" — generational precision.** Anthropic's "matches Sonnet 4" refers to the May 2025 generation. Against current Sonnet 4.6, the gap is real (73.3 vs 79.6 SWE-bench, 90% agentic parity vs 4.5). Design against the real gap, not the marketing claim.

4. **The >20% correction rate trigger is unvalidated against this workload.** Morph's routing guidance is general production guidance, not calibrated to OpenCart/Laravel agentic sub-agent tasks. Treat it as a starting heuristic; measure and recalibrate after first real run.

---

## Sections to refresh

- aider.chat Polyglot leaderboard: Haiku 4.5 entry (currently absent; check monthly)
- Haiku-4.5-specific context degradation measurements (none published; monitor Anthropic blog)
- Thinking-on vs thinking-off delta for Haiku 4.5 SWE-bench base score (not published)
- Correction rate data from first real Delta seat deployment (operator's own project run)
- Any Haiku 4.6 / next-generation Haiku announcement (expected late 2026 per Caylent)
```
