# Dive C — Opus: Where It Earns Its Cost
`study: capabilities.claude · phase: 4-dive · date: 2026-06-25 · agent: @Epoch`

---

```
topic: Option C — Opus: where it earns its cost
summary: >
  Claude Opus 4.8 earns its 1.67× cost premium over Sonnet 4.6 in three demonstrably
  non-overlapping zones: (1) legal and multi-step chain reasoning where Opus 4.8 is the
  first model to clear 10% on the Legal Agent Benchmark all-pass standard — a benchmark
  structurally identical to Houston's challenge-before-lock gate; (2) risk-weighted
  adversarial and architectural review where error cost drives tier choice, and Opus's
  effort=high default provides self-interrogation behavior without configuration risk;
  (3) hard agentic coding where the SWE-bench Pro gap (Opus 25.6pt ahead) is far larger
  than the Verified gap (9pt) and scales with task difficulty. Opus is overkill for
  routine execution and structured data tasks (Finance Agent: Sonnet leads), and the
  GPQA Diamond gap collapses from 17pt to ~4pt when Sonnet uses adaptive thinking — the
  deployment-relevant configuration for @Color and @Janus.

keyFindings:

  - claim: >
      The multi-agent 90.2% improvement (BrowseComp eval) proves that architectural
      decomposition — not Opus-specific orchestration quality — is the dominant driver.
      The three factors explaining 95% of performance variance are: token usage (80%
      alone), number of tool calls, and model choice. Model choice is the SMALLEST of
      the three.
    evidence: >
      Anthropic Engineering blog (live-fetched 2026-06-25): "a multi-agent system with
      Claude Opus 4 as the lead agent and Claude Sonnet 4 subagents outperformed
      single-agent Claude Opus 4 by 90.2%." Benchmark: BrowseComp (measures ability of
      browsing agents to locate hard-to-find information). The blog does not compare
      Opus-orchestrator vs Sonnet-orchestrator — it compares multi-agent vs single-agent.
      No ablation of orchestrator model tier published.
    citations:
      - "https://www.anthropic.com/engineering/multi-agent-research-system (live-fetched 2026-06-25)"
    confidence: high
    bearing: >
      Houston (architect/orchestrator seat). Validates that Houston should orchestrate
      subagents, not run tasks solo. Does NOT provide direct evidence that Houston must be
      Opus rather than Sonnet for the orchestrator role itself. The architectural pattern
      (decomposition + delegation) is proven; the tier requirement for the orchestrator
      seat is inferred from risk-weighting and formal reasoning arguments, not from this
      benchmark alone.

  - claim: >
      GPQA Diamond gap is config-dependent and closes dramatically with thinking enabled.
      Thinking-OFF Sonnet 4.6: 74.1% vs Opus 4.6: 91.3% = 17.2pt gap (Kanungo source).
      Thinking-ON Sonnet 4.6: 89.9% vs Opus 4.8: 93.6% = 3.7pt gap (llm-stats.com
      same-model comparison). The artificialanalysis.ai URL `claude-sonnet-4-6-non-
      reasoning-low-effort` confirms that 74.1% is a no-thinking, low-effort Sonnet
      configuration. For @Color and @Janus — which would never run thinking-off — the
      deployment-relevant gap is approximately 4pt, not 17pt. GPQA is also nearing
      saturation at this tier (Opus at ~94%), limiting further discriminating power.
    evidence: >
      Kanungo (practitioner blog, live-fetched 2026-06-25): 74.1% Sonnet 4.6 vs 91.3%
      Opus 4.6 — confirms these are the same model generation (both Feb 2026) but does
      not specify thinking configuration. llm-stats.com comparison page (live-fetched
      2026-06-25): Sonnet 4.6 GPQA 89.9% vs Opus 4.8 93.6% — same-source, same-axis
      comparison of thinking-enabled models. Morphllm aggregator (live-fetched 2026-06-25):
      Opus 4.8 93.6%. artificialanalysis.ai URL structure confirmed via search (2026-06-25):
      URL `...claude-sonnet-4-6-non-reasoning-low-effort` confirms 74.1% = thinking-off config;
      actual data on that page returned as unavailable at fetch time.
    citations:
      - "https://shawnkanungo.com/blog/claude-sonnet-46-vs-opus-46-whats-the-difference-and-which-one-should-you-use (live-fetched 2026-06-25)"
      - "https://llm-stats.com/models/compare/claude-sonnet-4-6-vs-claude-opus-4-8 (live-fetched 2026-06-25)"
      - "https://www.morphllm.com/claude-benchmarks (live-fetched 2026-06-25)"
      - "https://artificialanalysis.ai/models/comparisons/claude-opus-4-8-vs-claude-sonnet-4-6-non-reasoning-low-effort (URL structure noted; page returned no data 2026-06-25)"
    confidence: med (config interpretation inferred from URL + two-source triangulation; primary-source eval config not directly confirmed)
    bearing: >
      @Color (math/formal language advisor): Sonnet-xhigh-with-adaptive-thinking closes
      most of the formal reasoning gap. Opus remains justified at @Color only for the
      hardest graduate-level formal problems where the residual 4pt gap is operationally
      meaningful — which it may be for proof verification and formal language semantics.
      @Janus (adversarial challenger): same reasoning. The risk-weighted argument (entry
      below) is now the stronger justification for Opus at Janus than the raw GPQA gap.

  - claim: >
      Legal Agent Benchmark (LAB): Opus 4.8 scored 10.4%, the first model to break 10%
      on the all-pass standard. Prior model (Opus 4.7) scored 7.1%. The all-pass standard
      means every element of a multi-step legal workflow must be correct for the task to
      count. The absolute score is low because the benchmark is near-impossible; the
      significance is cross-step coherence — the model must sustain correct reasoning
      through every gate in a chain. Opus 4.8 also scored 91.1% on BigLaw Bench with
      43% perfect scores.
    evidence: >
      Anthropic news page for Opus 4.8 (live-fetched 2026-06-25): "first model to break
      10% overall on the all-pass standard." Harvey AI blog (live-fetched 2026-06-25):
      Opus 4.8 at 10.4% LAB; self-review behavior confirmed in production ("interrogates
      its own outputs and edits them"); BigLaw Bench 91.1% with 43% perfect scores.
      Harvey is a production legal AI platform that integrated Opus 4.8 specifically for
      complex multi-step legal workflows.
    citations:
      - "https://www.anthropic.com/news/claude-opus-4-8 (live-fetched 2026-06-25)"
      - "https://www.harvey.ai/blog/opus-4-8-now-live-in-harvey (live-fetched 2026-06-25)"
    confidence: high
    bearing: >
      Houston (challenge-before-lock gate design) and @Janus (adversarial challenge
      execution). The LAB all-pass structure is directly analogous to a temple gate:
      every challenge in the chain must succeed for the lock to proceed. This is the
      cleanest single-benchmark justification for Opus at the gate-holding seats.
      No Sonnet score on LAB found — cannot state the gap, but Opus 4.7→4.8 jump
      (7.1%→10.4%) suggests the task class is specifically sensitive to tier.

  - claim: >
      Online-Mind2Web (Opus 4.8 at 84%): tests 300 diverse tasks across 136 real
      websites (shopping, finance, travel, government) evaluating browser agents in live
      dynamic conditions. A search-only baseline scores 22%, making 84% genuinely high.
      No Sonnet 4.6 score found — comparison gap not established.
    evidence: >
      Anthropic news page (live-fetched 2026-06-25): "84% on Online-Mind2Web, a meaningful
      jump over both Opus 4.7 and GPT-5.5." Browser-use.com (live-fetched 2026-06-25):
      benchmark description (300 tasks, 136 websites, WebJudge automated evaluation,
      22% baseline).
    citations:
      - "https://www.anthropic.com/news/claude-opus-4-8 (live-fetched 2026-06-25)"
      - "https://browser-use.com/posts/online-mind2web-benchmark (live-fetched 2026-06-25)"
    confidence: med (score confirmed; Sonnet comparison absent — gap not established)
    bearing: >
      Relevant to any agent doing browser/computer-use tasks. Temple topology currently
      doesn't include a dedicated browser agent; if one is added, Opus is the evidenced
      choice for orchestrating multi-step web tasks pending any Sonnet comparison.

  - claim: >
      Terminal-Bench 2.1 (Opus 4.8 at 74.6%): tests AI agents operating a computer via
      terminal — shell scripting, system administration, CLI workflows, server setup, data
      science, security tasks. Opus 4.7 scored 66.1% on TB 2.1 (8.5pt intra-Opus gain).
      Sonnet 4.6 does not appear on the TB 2.1 leaderboard fetched. An approximate cross-
      version comparison (llm-stats.com: Sonnet 4.6 at 59.1% on a "Terminal-Bench 2.0" row
      vs Opus 4.8 at 74.6% on TB 2.1) shows a ~15.5pt figure, but this pairs different
      benchmark versions and must not be used as a clean gap number.
    evidence: >
      llm-boss.com leaderboard (live-fetched 2026-06-25): Opus 4.8 74.6%, Opus 4.7 66.1%
      on Terminal-Bench 2.1. llm-stats.com comparison (live-fetched 2026-06-25): Sonnet 4.6
      59.1% labeled as "Terminal-Bench 2.0" — version ambiguity confirmed; do not use as gap.
    citations:
      - "https://llm-boss.com/benchmarks/terminal-bench (live-fetched 2026-06-25)"
      - "https://llm-stats.com/models/compare/claude-sonnet-4-6-vs-claude-opus-4-8 (live-fetched 2026-06-25)"
    confidence: med (Opus TB 2.1 score confirmed; Sonnet gap unestablished on same version)
    bearing: >
      Terminal/agentic execution tasks. The Opus 4.8 score is high and shows meaningful
      improvement from 4.7. Whether Sonnet is materially behind on this specific benchmark
      version is an open question — no conclusion about Vara-seat tier from this data alone.

  - claim: >
      SWE-bench gap scales with task difficulty. Verified variant (500 human-reviewed
      solvable issues): Opus 4.8 88.6% vs Sonnet 4.6 79.6% = 9pt. Pro variant (1865
      harder issues): Opus 4.8 69.2% vs Sonnet 4.6 43.6% = 25.6pt. The L5 "9-point
      gap doesn't justify 5×" framing applies only to the Verified variant. On harder,
      real-world coding problems the gap more than doubles.
    evidence: >
      Morphllm aggregator (live-fetched 2026-06-25): Opus 4.8 SWE-bench Verified 88.6%,
      SWE-bench Pro 69.2%. Sonnet 4.6 SWE-bench Verified 79.6%, SWE-bench Pro 43.6%.
    citations:
      - "https://www.morphllm.com/claude-benchmarks (live-fetched 2026-06-25)"
    confidence: high
    bearing: >
      For routine coding tasks (Verified class): Sonnet is near-parity; cost difference
      not justified. For hard coding problems (Pro class — open-ended, ambiguous, multi-
      file rewrites): Opus gap doubles. Trajectory handles execution; Opus is justified
      at Trajectory only for SWE-bench-Pro-class tasks. Haiku and Sonnet cover the rest.
      Delta at Haiku is correct for the majority of coding volume.

  - claim: >
      Opus 4.8 exhibits a self-interrogation behavior confirmed in production: the model
      "often interrogates its own outputs and edits them" before returning answers (Harvey
      AI, production legal context). This correlates with the effort=high default — Opus 4.8
      defaults to effort=high, unlike Sonnet 4.6 (effort=medium default). Higher effort
      means more frequent and deeper thinking and more tool calls before response. This
      behavioral profile — deliberate self-review before completion — is the operational
      mechanism for Opus at challenge-before-lock and adversarial review seats.
    evidence: >
      Harvey AI blog (live-fetched 2026-06-25): self-review behavior in production legal
      context. Anthropic models overview (L3 lens, verified 2026-06-25): Opus 4.8 defaults
      effort to "high." Anthropic effort parameter docs (L1/L6 lenses): effort=high means
      more frequent and deeper thinking, more tool calls.
    citations:
      - "https://www.harvey.ai/blog/opus-4-8-now-live-in-harvey (live-fetched 2026-06-25)"
      - "https://platform.claude.com/docs/en/about-claude/models/overview (from L3 lens, verified 2026-06-25)"
    confidence: high (self-review behavior in production); med (mechanism — default effort=high is the proximate cause, not a unique Opus capability)
    bearing: >
      @Janus (challenge-before-lock) is the primary beneficiary. The default-high-effort
      behavior means @Janus running on Opus naturally invests more in adversarial analysis
      without explicit effort configuration, reducing the risk of the effort-level
      misconfiguration failure mode (cf. AMD Laurenzo incident — entry below).

  - claim: >
      Sonnet 4.6 reversed the advantage on Finance Agent / agentic financial analysis:
      Sonnet 4.6 63.3% vs Opus 4.8 53.9% on Finance Agent tasks (llm-stats.com). Note:
      the benchmark variant names differ (Finance Agent for Sonnet vs Finance Agent v2
      for Opus), so this may not be a clean head-to-head. The reversal signal is
      corroborated by the training cutoff asymmetry: Sonnet 4.6 knowledge cutoff Jan 2026
      vs Opus 4.6 Aug 2025 — more recent knowledge can dominate in practical agentic
      tasks dependent on current APIs and frameworks.
    evidence: >
      llm-stats.com comparison page (live-fetched 2026-06-25): Finance Agent Sonnet 4.6
      63.3% vs Finance Agent v2 Opus 4.8 53.9%. L5 lens (Serenitiesai.com): 59% Claude
      Code user preference for Sonnet over prior Opus generation (Opus 4.5 generation,
      not Opus 4.8 — cross-generation comparison).
    citations:
      - "https://llm-stats.com/models/compare/claude-sonnet-4-6-vs-claude-opus-4-8 (live-fetched 2026-06-25)"
    confidence: low (benchmark variant names differ; may not be directly comparable)
    bearing: >
      Counterweight evidence: Opus is NOT uniformly better. Certain agentic/financial
      task classes show Sonnet parity or reversal. For Delta (fast execution, structured
      data) and Haiku-class tasks, tier escalation to Opus is unjustified.

  - claim: >
      Speed and latency: Sonnet 4.6 generates ~40–60 tokens/second with 500–800ms TTFT;
      Opus 4.6 generates ~20–30 tokens/second with 1–2s TTFT. Opus 4.8 includes Fast
      Mode at $10/$50 per MTok (2× base price) to increase throughput. Without Fast Mode,
      Opus is approximately 2× slower in token generation than Sonnet, compounding across
      multi-step agentic calls. For an interactive orchestrator making sequential decisions
      over long sessions, this latency accumulates materially.
    evidence: >
      Search results (live-fetched 2026-06-25): Sonnet 4.6 TTFT 500–800ms; Opus 4.6 TTFT
      1–2s; Opus 4.6 20–30 tok/sec. Anthropic pricing docs (L3 lens): Opus 4.8 Fast Mode
      at $10/$50. NOTE: Opus 4.8-specific throughput not directly live-verified — figures
      are from Opus 4.6-era sources.
    citations:
      - "Search results 2026-06-25 — cross-source aggregation; specific throughput numbers for Opus 4.8 not confirmed"
      - "https://platform.claude.com/docs/en/about-claude/pricing (L3 lens, verified 2026-06-25)"
    confidence: med (Opus 4.6 latency well-established; Opus 4.8 throughput not live-verified)
    bearing: >
      For Houston as interactive orchestrator: 2× latency at base Opus pricing is real
      operational cost. Fast Mode ($10/$50) doubles per-token price, equaling Fable 5
      standard pricing. For long-horizon planning sessions where latency compounds,
      this is a genuine limitation not visible in benchmark scores.

  - claim: >
      The dominant quality lever in 2026 is effort level and task decomposition, not
      model tier alone. The AMD/Laurenzo incident (instrumented, 6,852 Claude Code
      sessions) showed a default effort-level change — from implied-high to effort=medium
      within a single model tier — caused: 70% reduction in pre-edit research depth, 6×
      increase in user interrupts, and 122× API cost increase due to remediation loops.
      Effort misconfiguration within a tier can outweigh a tier downgrade in quality impact.
    evidence: >
      L5 lens (GitHub issue #42796, Stella Laurenzo/AMD, verified via agentupdate.ai
      2026-06-25): instrumented metrics on 4 AMD projects, 234,760 tool calls, 17,871
      thinking blocks.
    citations:
      - "https://github.com/anthropics/claude-code/issues/42796"
      - "https://www.agentupdate.ai/news/claude-code-performance-degradation-thinking-depth/"
    confidence: high (named practitioner, instrumented data, confirmed production regression)
    bearing: >
      For Houston specifically: running Opus at default effort=high is as important as
      selecting Opus tier. Vara (Sonnet at xhigh) is correctly specified in the proposed
      topology — effort level is its primary differentiator, not tier. The 2D assignment
      space (tier × effort) must be correct for both axes.

strongestClaim: >
  The Legal Agent Benchmark all-pass result is the cleanest justification for Opus at
  the gate-holding seats. Opus 4.8 scored 10.4% — first to break 10% — on a benchmark
  that requires every element of a multi-step chain to succeed. This is structurally
  identical to Houston's challenge-before-lock gate and @Janus's adversarial challenge
  function: a single wrong step invalidates the chain. The 7.1%→10.4% jump from Opus 4.7
  to Opus 4.8 shows the task class is specifically sensitive to tier. Harvey AI (production
  legal platform) confirms Opus 4.8's "self-interrogation before returning answers" behavior
  operationally, and the effort=high default means this behavior activates without manual
  configuration — reducing the risk of the misconfiguration failure mode that destroyed
  quality in the AMD Laurenzo incident. This is the one finding that is version-clean
  (Opus 4.8), source-clean (Anthropic + production case), and structurally mapped to the
  temple's specific architecture.

biggestLimitation: >
  Two independent uncertainties remain. First: the orchestrator-tier case (Core Q1) is
  under-evidenced. The 90.2% finding proves that multi-agent decomposition wins over
  single-agent. It does NOT prove Opus orchestrator outperforms Sonnet orchestrator at the
  same architectural role — no ablation of orchestrator tier is public. The decision to
  pin Houston to Opus is justified by risk-weighting and LAB evidence, but the direct
  head-to-head orchestrator comparison is absent. Second: the GPQA Diamond gap that
  originally motivated @Color and @Janus as Opus seats collapses from 17.2pt to ~3.7pt
  when Sonnet runs with adaptive thinking enabled — the configuration those seats would
  actually use. At 3.7pt near benchmark saturation (Opus ~94%), formal reasoning is a
  weaker justification for Opus than risk-weighting and LAB coherence evidence. Both
  uncertainties should be noted if the temple topology is revisited.

openQuestions:
  - "Does Opus outperform Sonnet as an orchestrator head-to-head (not multi vs single-agent) on any published benchmark? No data found 2026-06-25."
  - "GPQA Diamond config resolution: does 74.1% Sonnet vs 91.3% Opus (Kanungo) represent thinking-off Sonnet vs thinking-on Opus? Primary-source eval config not confirmed. The ~4pt same-source thinking-on gap (llm-stats.com) should be verified against Anthropic's official Sonnet 4.6 system card."
  - "What is Sonnet 4.6's Terminal-Bench 2.1 score? Only Opus 4.7 and Opus 4.8 appear on the leaderboard fetched — Sonnet's absence suggests it may not have been submitted."
  - "What is Sonnet 4.6's Legal Agent Benchmark score? Without it, the LAB finding describes Opus capability but not the gap."
  - "Does Opus 4.8 hallucinate less than Sonnet 4.6 on factual recall? BullshitBench v2 data shows Sonnet 4.6 at 3.0% vs Opus 4.5 at 8.0% (reversal). Hallucination comparison is benchmark-dependent; no authoritative cross-model comparison found."
  - "Opus 4.8 specific throughput (tokens/second) for this model version? Not live-verified; only Opus 4.6-era latency data retrieved."
  - "Should @Janus run on Opus or inherit from Houston? If @Janus is a subagent with the gate-challenge function, Sonnet-class @Janus may generate weaker challenges that Sonnet-class Houston already considered. Topology should specify tier for @Janus explicitly."

emergentPatterns:
  - name: risk-weighted tier selection
    description: >
      The deciding factor for Opus vs Sonnet is not task computational complexity but
      the downstream cost of a wrong answer. Security auditors, architect reviewers,
      legal analysts, and adversarial challengers get Opus in community practice (VoltAgent
      corpus: 154+ agents) not because their prompts are longer, but because errors in those
      roles are expensive and non-recoverable. @Janus (challenge-before-lock) and Houston
      (gate design) fit this profile. Vara (task runner) and Delta (fast execution) do not
      — wrong answers at Vara/Delta are caught by downstream gates, reducing the error cost
      that would drive Opus selection.
    status: real-and-adopted

  - name: effort-tier orthogonality
    description: >
      Model tier and effort level are two independent routing dimensions. Opus at effort=low
      is worse than Sonnet at effort=xhigh for many task classes. The AMD Laurenzo incident
      confirmed this empirically: a within-tier effort change caused larger quality regression
      than a tier downgrade would. The proposed temple topology (Houston=Opus default=high,
      Vara=Sonnet xhigh) correctly treats these as orthogonal — Vara's xhigh effort partially
      compensates for its lower tier. The community has formally requested per-agent effort
      frontmatter (GitHub issue #31536) because they recognize these as separate axes.
    status: real-and-adopted

  - name: multi-agent decomposition premium
    description: >
      The 90.2% improvement from single-agent to multi-agent (Opus lead + Sonnet subs) on
      BrowseComp shows that architectural decomposition is worth more than model tier
      escalation. The three variance factors (token budget 80%, tool calls, model choice)
      imply: give any orchestrator more tokens and more subagent calls, and you recover most
      of the gap between tiers. The Opus-orchestrator choice matters at the margin, not as
      the primary lever.
    status: real-and-adopted

  - name: task-class inversion zones
    description: >
      Certain agentic task classes show Sonnet outperforming Opus or reaching parity:
      agentic financial analysis (Sonnet 63.3% vs Opus 53.9% on Finance Agent — caveat:
      different benchmark variants), networking policy evaluation (Rootly SRE bench: both
      97.1%), browser agent (Sonnet/Opus parity at ~72.5–72.7% on computer use). These
      reversals correlate with Sonnet 4.6's more recent training cutoff (Jan 2026 vs Opus
      4.6 Aug 2025) — more recent knowledge dominates in practical tasks dependent on
      current tool APIs and protocols.
    status: emerging

  - name: adaptive thinking closes formal reasoning gap
    description: >
      Sonnet 4.6 with adaptive thinking enabled on GPQA Diamond scores ~89.9% vs Opus 4.8
      at 93.6% — approximately 4pt gap. Sonnet 4.6 without thinking scores 74.1% — 17pt
      gap. The "17pt irreducible gap" commonly cited is a thinking-off artifact. For
      @Color and @Janus running at effort=xhigh with adaptive thinking, the deployment-
      relevant gap is ~4pt near saturation, not 17pt. Formal reasoning remains a strong
      justification for Opus only for the absolute hardest graduate-level tasks where 4pt
      is operationally meaningful — and risk-weighting becomes the primary justification
      rather than raw benchmark delta.
    status: real-and-adopted
```

---

## Version discipline notes

All Opus benchmark references in this document:
- GPQA Diamond: Opus 4.6 vs Sonnet 4.6 thinking-off = 17.2pt gap (Kanungo). Opus 4.8 vs Sonnet 4.6 thinking-on = ~3.7pt gap (llm-stats.com). The "91.3%" figure is Opus **4.6**, not Opus **4.8** (93.6%).
- SWE-bench Verified 9pt gap: Opus **4.8** (88.6%) vs Sonnet **4.6** (79.6%).
- SWE-bench Pro 25.6pt gap: Opus **4.8** (69.2%) vs Sonnet **4.6** (43.6%).
- Legal Agent Benchmark 10.4%: Opus **4.8**. Prior version (4.7): 7.1%.
- Online-Mind2Web 84%: Opus **4.8**.
- Terminal-Bench 2.1 74.6%: Opus **4.8**; Sonnet **4.6** score not found on this variant.
- 90.2% multi-agent improvement: "Claude Opus 4" (May 2025 generation) + "Claude Sonnet 4" subagents vs single-agent "Claude Opus 4" on BrowseComp.

L5 counterweight sources ("Sonnet preferred 59% over Opus", "9-point SWE-bench gap doesn't justify 5×") were comparing against **Opus 4.5 or 4.6** — prior generations where the SWE-bench Verified gap was 1.2pt, not 9pt. The L5 dissent is structurally valid but anchored to pre-4.8 models. Opus 4.8 widened the SWE-bench Verified gap from 1.2pt to 9pt and the SWE-bench Pro gap to 25.6pt. The "Opus is overkill" consensus from L5 requires re-anchoring to the 4.8 generation.

---

## Temple topology assessment

Proposed: Houston (Opus) → Vara (Sonnet xhigh) → Trajectory (Sonnet) → Delta (Haiku)

**Validated:**
- Houston = Opus: justified primarily by (a) risk-weighting — error at the planning/gate layer is most expensive and non-recoverable; (b) LAB all-pass coherence — sustaining correct reasoning through every gate in a chain, structurally identical to Houston's challenge-before-lock function; (c) effort=high default — self-interrogation behavior activates without configuration, reducing failure-mode risk. The 90.2% multi-agent finding validates the *architectural pattern* (decompose + delegate), not the tier specifically.
- Vara = Sonnet xhigh: correct. Effort axis is the primary differentiator. Sonnet at xhigh handles complex task execution without Opus cost. Terminal-Bench gap is unestablished on the same benchmark version — no conclusion from that data.
- Trajectory = Sonnet: correct. SWE-bench Verified parity (9pt gap) is not worth 1.67× cost for routine execution tasks where failures are caught by downstream gates.
- Delta = Haiku: correct. Haiku handles ~60% of prompts identically to Sonnet at 3× lower cost (Morphllm routing data, L5 lens).

**One open architecture question:**
@Janus (adversarial challenger) — the topology does not specify @Janus's tier. If @Janus is a subagent spawned by Houston and runs at the default subagent tier (Sonnet or inherit), it may produce challenges that are weaker than what Houston (Opus) already considered — defeating the challenge-before-lock purpose. The LAB evidence suggests Opus's chain-coherence advantage is specifically relevant to the adversarial chain-of-challenges function. Recommendation: @Janus should specify `model: opus` or `model: inherit` (inheriting Houston's Opus tier), not default to Sonnet.

---

## Source list (all fetched 2026-06-25)

- Anthropic Engineering multi-agent blog: https://www.anthropic.com/engineering/multi-agent-research-system
- Anthropic Opus 4.8 news: https://www.anthropic.com/news/claude-opus-4-8
- Harvey AI Opus 4.8: https://www.harvey.ai/blog/opus-4-8-now-live-in-harvey
- Morphllm Claude benchmarks: https://www.morphllm.com/claude-benchmarks
- Kanungo Sonnet 4.6 vs Opus 4.6: https://shawnkanungo.com/blog/claude-sonnet-46-vs-opus-46-whats-the-difference-and-which-one-should-you-use
- llm-stats.com Sonnet 4.6 vs Opus 4.8: https://llm-stats.com/models/compare/claude-sonnet-4-6-vs-claude-opus-4-8
- llm-boss.com Terminal-Bench: https://llm-boss.com/benchmarks/terminal-bench
- Browser-use Online-Mind2Web: https://browser-use.com/posts/online-mind2web-benchmark
- AMD Laurenzo GitHub issue: https://github.com/anthropics/claude-code/issues/42796

**Sections to refresh:** GPQA Diamond Sonnet 4.6 eval config (confirm 74.1% = thinking-off via primary source); Sonnet 4.6 LAB score (gap currently unestablished); Sonnet 4.6 Terminal-Bench 2.1 submission; Opus 4.8 throughput (tokens/second) direct measurement; @Janus tier specification in temple topology.
