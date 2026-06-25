# Dive X1 — Per-Task Cost Economics (Cross-cut)
`study: capabilities.claude · phase: 4-dive · date: 2026-06-25 · agent: @Epoch`

---

```yaml
topic: Cross-cut X1 — Per-task cost economics
summary: >
  Per-token pricing (Haiku:Sonnet:Opus = 1:3:5) systematically misrepresents per-task cost.
  On the aider Polyglot benchmark, Opus costs 3.45x Sonnet per correctly-solved problem — not
  1.67x as per-token rates imply — because Opus consumes ~2.6x more tokens per task than
  Sonnet on the same benchmark, compounding the price premium. The dominant cost lever in 2026
  is not model tier but effort-level configuration: AMD/Laurenzo's instrumented incident (6,852
  sessions, 234k tool calls) showed a within-tier effort misconfiguration driving API cost from
  $12/day to $1,504/day — a 122x swing that no tier comparison can surface.

keyFindings:

  - claim: >
      The morphllm "cost-per-solved-point" metric ($0.13 for Haiku 4.5) is output-price ÷
      SWE-bench Pro score — it assumes identical tokens-per-task across all tiers. This is
      per-token pricing relabeled, not genuine per-task accounting.
    evidence: >
      Confirmed via direct fetch of morphllm.com/best-ai-model-for-coding (2026-06-25). The
      site's own table: Haiku $5/$39.45 = $0.13; Sonnet (labeled 4.5 by morphllm) $15/$43.60 =
      $0.34; Opus (4.6) $25/$51.90 = $0.48. The metric is explicitly stated as "output $/M ÷
      SWE-bench Pro" with no per-task token normalization. Any efficiency advantage for Haiku
      in this metric is driven entirely by lower per-token price, not by fewer tokens consumed
      per task.
    citations:
      - "https://www.morphllm.com/best-ai-model-for-coding (live-fetched 2026-06-25)"
    confidence: high
    bearing: >
      Force 1 (cost-gradient) seat assignments. If this metric is used uncritically, it
      systematically overstates Haiku's efficiency advantage. Haiku is efficient, but the
      reason is its price, not its task-resolution density.

  - claim: >
      On the aider Polyglot benchmark (N=225 exercises, live-verified 2026-06-25), Opus 4 costs
      3.45x Sonnet 4 per correctly-solved problem, not 1.67x as per-token rates imply.
      Enabling extended thinking on Opus slightly reduces per-correct cost (to 3.24x Sonnet).
      The gap between 1.67x (per-token) and 3.45x (per-task) is explained by a ~2.6x token-
      consumption differential: Opus uses approximately 2.6x more tokens per task than Sonnet
      on the same benchmark, compounding the price premium.
    evidence: >
      Confirmed via direct fetch of aider.chat/docs/leaderboards/ (2026-06-25). N=225 confirmed.
      Computed per-correct-solution:
        Sonnet 4 (no thinking): $15.82 / (225 × 0.564) = $0.125/correct
        Sonnet 4 (32k thinking): $26.58 / (225 × 0.613) = $0.193/correct (+54% cost, +8.7% accuracy)
        Opus 4 (no thinking): $68.63 / (225 × 0.707) = $0.431/correct (3.45x Sonnet)
        Opus 4 (32k thinking): $65.75 / (225 × 0.720) = $0.406/correct (3.24x Sonnet)
      Token-consumption derivation: run-cost ratio Opus/Sonnet = $68.63/$15.82 = 4.34x.
      Input/output price ratio is identically 1.67x for both models ($3→$5 input, $15→$25 output).
      Therefore token ratio = 4.34 / 1.67 = ~2.6x. Opus consumed ~2.6x more tokens than Sonnet
      per benchmark run. This is the mechanism bridging the 1.67x per-token rate to the 3.45x
      per-task cost: Opus solves more tasks, but spends far more tokens doing so.
      The thinking-on/off inversion for Opus (cheaper with thinking) is confirmed: fewer
      completion tokens when extended thinking is enabled slightly exceeds the added thinking
      token cost at this benchmark's task distribution.
      Caveat: aider labels these models "Sonnet 4 / Opus 4" (May 2025 generation labels). These
      map approximately to Sonnet 4.5/4.6 and Opus 4.x generations but must not be treated as
      confirmed claude-sonnet-4-6 and claude-opus-4-8 API strings.
    citations:
      - "https://aider.chat/docs/leaderboards/ (live-fetched 2026-06-25)"
    confidence: high
    bearing: >
      Directly informs Force 1 routing decisions. Opus is not a 1.67x premium over Sonnet
      per task — it is a 3.45x premium, driven by ~2.6x more token consumption per task.
      The only conditions that justify Opus routing are those where the 25-percentage-point
      failure-rate improvement (Sonnet→Opus on hard tasks) is worth that multiple. For
      @Houston's architect seat, this is the primary cost anchor.

  - claim: >
      Opus extended thinking costs LESS per correct solution than Opus without thinking on aider
      Polyglot ($0.406 vs $0.431). Extended thinking on Sonnet costs MORE per correct solution
      ($0.193 vs $0.125, +54%). This is not a universal "thinking = waste" result — it is
      model-tier and task-distribution specific.
    evidence: >
      Derived from aider.chat live data (2026-06-25). Mechanism: Opus with 32k thinking
      produces fewer completion tokens per solved task (thinking substitutes for verbosity in
      output), net cost decreases slightly. Sonnet with 32k thinking gains only 4.9 percentage
      points of accuracy (+8.7%) but spends 68% more, making the thinking premium clearly
      non-economical at benchmark scale.
    citations:
      - "https://aider.chat/docs/leaderboards/ (live-fetched 2026-06-25)"
      - "capabilities.claude.lens-L3-L4.2026-06-25.md (numbers-captured section)"
    confidence: high
    bearing: >
      @Trajectory (executor seat): disabling extended thinking on Sonnet-tier tasks is the
      default-correct choice for throughput at benchmark scale. The arXiv preprint 2502.08235
      finding (43% cost reduction from lower-overthinking selection) reinforces this.

  - claim: >
      Opus is not cheaper than Sonnet on a per-task basis. The Kanungo claim of "19.3% fewer
      tokens per Opus task" is directly contradicted by the aider Polyglot data, which shows
      Opus consuming ~2.6x MORE tokens than Sonnet on the same benchmark. Even if the Kanungo
      figure were accurate in its own context (Sonnet 4.6 vs Opus 4.6, complex scenarios), it
      would still leave Opus at 1.67 × (1 − 0.193) = 1.35x Sonnet per task — not parity.
      Aider empirics put the actual ratio at 3.45x.
    evidence: >
      Derived from aider.chat live data and official pricing ($3/$15 Sonnet, $5/$25 Opus per
      MTok). Token-consumption derivation in finding 2 shows Opus at ~2.6x Sonnet token use,
      directly opposing Kanungo's claim. The Kanungo claim (shawnkanungo.com, 2026-06-25 via
      L3 lens) is not verified against a primary source and applies to a different model
      generation (Opus 4.6 vs Sonnet 4.6) than the aider data (May 2025 labels).
      The conflict is real: Kanungo's "complex scenarios" may be a task distribution where
      Opus compresses output more; aider Polyglot's 225 diverse coding tasks likely reflects
      a broader distribution. The aider figure is the more credible per-task token estimate
      for coding work because it is empirically measured across a specific benchmark, not
      asserted without methodology.
    citations:
      - "https://aider.chat/docs/leaderboards/ (live-fetched 2026-06-25)"
      - "https://shawnkanungo.com/blog/claude-sonnet-46-vs-opus-46-whats-the-difference-and-which-one-should-you-use (live-fetched 2026-06-25 via L3 lens)"
    confidence: high
    bearing: >
      Closes the X1 question definitively. Opus is never cheaper than Sonnet on per-task
      cost under the evidence available. Routing decisions should treat 3.45x (aider) as
      the empirical anchor, not the 1.67x per-token ratio. The Kanungo efficiency claim
      should not be cited without this contradiction noted.

  - claim: >
      On SWE-bench Pro (hard tasks), escalating from Haiku to Sonnet buys only 4.15
      percentage points of failure-rate reduction. Escalating from Sonnet to Opus buys 25.6
      percentage points. The Haiku→Sonnet escalation is largely economically unjustifiable
      on task-success grounds alone.
    evidence: >
      Haiku 4.5: 39.45% Pro score (60.55% fail). Sonnet 4.6: 43.60% (56.40% fail).
      Opus 4.8: 69.20% (30.80% fail). Delta H→S: 4.15 pts. Delta S→O: 25.6 pts.
      Ratio: Sonnet→Opus improvement is 6.2x larger than Haiku→Sonnet improvement.
      Data source marked secondary (Scale SEAL, not primary-confirmed per L3 lens notes).
    citations:
      - "https://www.morphllm.com/claude-benchmarks (live-fetched 2026-06-25 via L3 lens)"
      - "capabilities.claude.lens-L3-L4.2026-06-25.md (SWE-bench Pro numbers, secondary-flagged)"
    confidence: med
    bearing: >
      For temple task routing on hard coding tasks: Haiku→Sonnet escalation is not a
      meaningful quality upgrade on hard tasks; Sonnet→Opus is. This breaks the intuitive
      "step up one tier" escalation model. For @Trajectory / sub-agent routing: Haiku is
      the economical choice for easy tasks; Opus (not Sonnet) is the justified choice when
      hard-task quality is required.

  - claim: >
      The Morph LLM 20% correction-rate threshold for switching Haiku→Sonnet is far more
      conservative than token economics alone justify. The token-only breakeven is 67%.
      The 47-point gap between the recommended threshold and the token-breakeven encodes the
      implicit cost of correction effort, latency overhead, and quality degradation.
    evidence: >
      Token breakeven derivation: 100 tasks at cost H (Haiku) vs cost S=3H (Sonnet).
      Haiku-first with p% retry to Sonnet: 100H + (p/100)×100×3H = H(100+3p).
      Sonnet-only: 300H. Breakeven: 100+3p=300 → p=66.7%.
      Morph recommends switching at p=20% (morphllm.com/sonnet-vs-haiku, live-fetched 2026-06-25).
      Implication: at 20% correction rate, Haiku-first strategy still costs (100+60)H = 160H
      vs Sonnet-only at 300H — Haiku is still 1.88x cheaper in pure tokens. The early switch
      recommendation prices in non-token costs the model cannot see.
      Scope caveat: this retry model assumes Sonnet successfully resolves the escalated task.
      On hard tasks (SWE-bench Pro), Sonnet itself fails 56.4% — the retry savings collapse
      further if escalation to Sonnet still fails. The 20% threshold applies to easy/medium
      task routing (Morph's stated domain: classification, extraction, intent detection);
      it is not a valid escalation policy for hard software-engineering tasks.
    citations:
      - "https://www.morphllm.com/sonnet-vs-haiku (sourced from L5 counterweight lens)"
    confidence: high
    bearing: >
      @Houston (orchestration): when routing agents, a 20% failure signal is the quality
      threshold, not the token threshold. Token math alone would hold on Haiku until 67%
      failure — waiting that long would destroy quality and introduce repair costs invisible
      to pricing. The 20% rule is the operational signal for easy/medium tasks only. For
      hard tasks, escalation should go directly to Opus, not Sonnet.

  - claim: >
      The dominant per-task cost lever in 2026 is not model tier — it is effort-level
      configuration within a single model. AMD/Laurenzo's instrumented data (6,852 sessions,
      234,760 tool calls) showed within-tier effort misconfiguration driving cost from $12/day
      to $1,504/day (122x), far exceeding any tier-change multiplier.
    evidence: >
      Stella Laurenzo (Senior Director, AMD AI Group) filed GitHub issue #42796 (2026-04-02,
      retrieved directly 2026-06-25). After Anthropic's Feb 2026 default effort drop to
      "medium" (effort=85): reasoning loops per 1K calls tripled (8.2→21.0), user interrupts
      per 1K rose 6x (0.9→5.9), API cost 122x. Task class: agentic software engineering
      via Claude Code (4 projects). Anthropic attributed to thinking-redaction header (UI
      only); Laurenzo's team tested all parameter combinations and concluded quality degraded.
      The 122x cost explosion was from the model retrying degraded work in loops, not from
      tier pricing.
    citations:
      - "https://github.com/anthropics/claude-code/issues/42796 (retrieved directly 2026-06-25)"
      - "capabilities.claude.lens-L5-counterweight.2026-06-25.md (entry 5)"
    confidence: med
    bearing: >
      Single-source, single-incident — confidence capped at medium. But if confirmed,
      this is the most important X1 finding: for the temple's own agentic loops (Claude Code,
      multi-agent orchestration), effort-level policy misconfiguration is a larger cost risk
      than any tier choice. @Houston must hold effort configuration as a governed parameter,
      not a default.

  - claim: >
      For long-context tasks approaching Haiku's 200k cap, switching to Sonnet carries a
      cold-cache penalty of up to $0.60 for 200k tokens of context reload. For tasks expected
      to use 200k+ context, starting on Sonnet is cheaper than Haiku-then-escalation.
    evidence: >
      Haiku context cap: 200k (confirmed from Anthropic models overview, live-fetched 2026-06-25).
      Sonnet/Opus: 1M context. Cache is model-specific; Haiku→Sonnet switch forfeits cache.
      Cold reload cost: 200k tokens × $3/MTok (Sonnet input) = $0.60 uncached.
      Cached reload: 200k × $0.30/MTok = $0.06. Plus sunk Haiku cost already paid.
      For agentic loops with many tool calls building large contexts (common in the temple's
      SWE-style tasks), the 200k boundary is a predictable escalation point. Planning the
      tier from the start of a long-horizon task avoids this.
    citations:
      - "capabilities.claude.lens-L3-L4.2026-06-25.md (Anthropic pricing and models overview)"
      - "https://platform.claude.com/docs/en/about-claude/models/overview (live-fetched 2026-06-25)"
    confidence: high
    bearing: >
      @Houston routing policy: any task anticipated to exceed 150k context tokens should
      be assigned to Sonnet or Opus from the start, not handed to Haiku with a plan to
      escalate. The escalation itself costs more than the tier premium at this context size.

  - claim: >
      The Opus 4.7+ tokenizer produces ~30% more tokens for identical text vs pre-4.7 models.
      This is a hidden per-task cost asymmetry: a loop that costs X tokens on Sonnet 4.6 costs
      ~1.3X tokens on Opus 4.7+ even if the model executes identically.
    evidence: >
      Confirmed from Anthropic models overview note (live-fetched 2026-06-25 via L3 lens):
      "Fable 5 / Opus 4.7+ use a new tokenizer producing ~30% more tokens vs pre-4.7 models
      for the same text." At Opus pricing ($5/$25 per MTok), this adds ~30% to every per-task
      cost estimate made against pre-4.7 benchmarks. SWE-bench Pro scores for Opus 4.8 were
      measured with this tokenizer; the cost-per-point metric reflects it. But any benchmark
      predating Opus 4.7 (including the aider Polyglot "Opus 4" rows if that is a pre-4.7
      model) does not reflect this tokenizer overhead.
    citations:
      - "capabilities.claude.lens-L3-L4.2026-06-25.md (models overview numbers-captured)"
      - "https://platform.claude.com/docs/en/about-claude/models/overview (live-fetched 2026-06-25)"
    confidence: high
    bearing: >
      Aider Polyglot "Opus 4" (May 2025 label, pre-4.7) may undercount what Opus 4.8 would
      actually cost on the same tasks. The 3.45x ratio should be treated as a floor, not a
      ceiling, when applied to current Opus 4.8 API IDs. If the tokenizer overhead applies,
      the production Opus 4.8 vs Sonnet 4.6 per-task ratio may approach ~4.5x.

  - claim: >
      For the temple operator's workload (solo dev, OpenCart PHP7.4+, Laravel PHP8+, mid-
      complexity feature work, debugging, refactoring, test writing), the Caylent-modeled
      cost differential at 10K tasks/month is $700/month (Haiku) vs $2,100/month (Sonnet).
      Opus cannot be reliably estimated by price-ratio scaling: the aider data shows Opus
      consumes ~2.6x more tokens per task than Sonnet, making the real Opus monthly cost
      approximately $2,100 × 2.6 × (25/15) ≈ $9,100/month — not the $3,500 price-ratio
      floor. The mixed stack (Haiku sub-agents + Sonnet primary + Opus architect) is the
      economically correct configuration.
    evidence: >
      Caylent scenario "Agent with extended thinking (10K tasks/month)": Haiku $700 vs
      Sonnet $2,100 (caylent.com/blog, live-fetched 2026-06-25 via L3 lens). Opus projection
      cannot use the 5:3 price-ratio (= $3,500) because that assumes equal tokens — the same
      fallacy this dive identifies. The 2.6x token multiplier from aider data yields the
      higher estimate. Note: aider data is for a code benchmark; Opus token overhead for the
      operator's PHP/Laravel task mix is unverified. The $9,100 figure should be treated as
      an upper-end estimate for Opus-only routing; actual mixed-stack Opus cost is a fraction
      of this (Opus only for hard architect-level tasks, not routine execution).
      Solo developer volume likely under 10K tasks/month; scale proportionally.
    citations:
      - "https://caylent.com/blog/claude-haiku-4-5-deep-dive-cost-capabilities-and-the-multi-agent-opportunity (live-fetched 2026-06-25 via L3 lens)"
      - "https://aider.chat/docs/leaderboards/ (live-fetched 2026-06-25, token ratio source)"
    confidence: med
    bearing: >
      @Houston resource governance. Mixed stack is the doctrine-aligned recommendation.
      Opus-only routing is economically prohibitive at coding-task token volumes. Opus is
      justified for the architect/planning seat where task volume is low and the 25.6-point
      failure-rate improvement over Sonnet on hard tasks actually matters. Sonnet is the
      primary executor. Haiku for routing, classification, sub-agent scaffolding.

strongestClaim: >
  Opus costs 3.45x Sonnet per correctly-solved task on the aider Polyglot benchmark (N=225,
  live-verified), driven by Opus consuming ~2.6x more tokens per task than Sonnet on the same
  benchmark. The 1.67x per-token premium and the 2.6x token overhead combine to produce 4.34x
  total run cost — but Opus solves 25% more tasks, compressing the per-correct ratio to 3.45x.
  Opus is justified only where the 25.6-point SWE-bench Pro failure-rate improvement over
  Sonnet is worth that multiple. For easy-to-medium tasks it is not.

biggestLimitation: >
  All benchmark data reflects single-shot, single-agent task completion. The temple operates
  multi-turn, multi-agent loops where error propagation, context degradation, and self-
  correction compound across iterations. No public benchmark measures per-loop token
  consumption across tiers, failure cascade cost, or the specific interaction between
  adaptive thinking (Opus 4.8 effort=high default) and agentic loop overhead. The AMD/
  Laurenzo incident (single-source, single incident) is the closest available evidence of
  agentic cost dynamics, and it points toward effort-configuration risk exceeding tier risk —
  but it is not sufficient to build a reliable per-loop cost model. The morphllm cost-per-
  point metric, the closest available per-task proxy, is methodologically equivalent to
  per-token pricing and cannot capture task-difficulty variance across tiers.

openQuestions:
  - >
    Per-loop token consumption across tiers: what is the actual token count per agentic loop
    iteration (tool call + response) at Haiku vs Sonnet vs Opus in a Claude Code or Managed
    Agents session? No clean public source found. Required to build a realistic per-session
    cost model for the temple's workload.
  - >
    Opus 4.8 effort=high default in agentic loops: does the "effort defaults to high" behavior
    on Opus 4.8 systematically increase per-task token consumption vs Sonnet 4.6 (where effort
    must be explicitly set)? If yes, the 3.45x aider ratio may understate the production
    Opus-vs-Sonnet per-task multiple for temple tasks.
  - >
    Kanungo "19.3% fewer tokens per Opus task": directly contradicted by aider data showing
    ~2.6x MORE tokens for Opus on the same coding benchmark. If Kanungo's claim is accurate
    in its specific context (Opus 4.6 vs Sonnet 4.6, complex multi-step reasoning scenarios),
    it would imply a sharp task-distribution dependency — Opus is relatively more verbose on
    coding exercises and relatively less verbose on multi-step reasoning. Requires primary-
    source verification with stated task type and token counting methodology.
  - >
    Haiku 4.5 actual token consumption per task for temple-class tasks (PHP/Laravel/OpenCart
    feature work): the 3x token-price advantage vs Sonnet is real, but does Haiku require
    more tool calls / more retries on this class of work than benchmarks reflect? Empirical
    test needed.
  - >
    Does the Opus 4.7+ tokenizer 30% overhead apply to the aider "Opus 4" (May 2025) benchmark
    rows? If the aider Opus 4 rows used a pre-4.7 model, actual Opus 4.8 per-task cost on
    Polyglot-equivalent tasks would be approximately 30% higher — raising the Opus/Sonnet
    ratio from 3.45x to ~4.5x.
```

---

## Methodology note — morphllm cost-per-point

The $0.13/point figure (Haiku 4.5, SWE-bench Pro) is computed as: output price per MTok ÷ SWE-bench Pro score. Confirmed via direct fetch 2026-06-25. This is output-per-token pricing divided by a task-success rate — it does not normalize for tokens consumed per task. The metric correctly captures "efficiency relative to price" but cannot distinguish between "Haiku is cheap" and "Haiku uses fewer tokens per task." For this dive, the metric is cited with that caveat explicit.

## Methodology note — aider Polyglot cost-per-correct-solution

Cost-per-correct-solution = run_cost / (N × fraction_correct), N=225 (confirmed live 2026-06-25). This is closer to genuine per-task cost than the morphllm metric, because the run cost is measured empirically across all 225 exercises rather than derived from a per-token rate. It does capture actual tokens consumed in practice for that benchmark's task distribution. The run-cost ratio ($68.63/$15.82 = 4.34x) combined with the identical 1.67x input/output price ratio yields the token-consumption multiple: Opus used ~2.6x more tokens than Sonnet across the same 225 exercises, providing the first quantitative per-task token asymmetry figure in this study.

The aider generation labels ("Sonnet 4," "Opus 4") are May-2025 labels that do not reliably map to current API IDs (claude-sonnet-4-6, claude-opus-4-8) — treat numbers as directionally correct for the generation, not precisely calibrated to current API strings.

---

*Sections to refresh: [aider Polyglot — verify generation label mapping to current API IDs; morphllm table — re-check if Opus 4.8 row is added with 69.2% SWE-bench Pro; Kanungo "19.3% fewer tokens" claim — requires primary verification with stated methodology and task type; per-loop agentic token consumption — no current public source; AMD/Laurenzo follow-up — any Anthropic official response or configuration guidance post-incident]*
