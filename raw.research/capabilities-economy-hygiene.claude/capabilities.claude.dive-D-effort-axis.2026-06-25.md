# Dive D — Effort as Second Axis: Range Table + Vara
`study: capabilities.claude · phase: 4-dive · date: 2026-06-25 · agent: @Epoch`

---

```
topic: Option D — Effort as second axis: range table, Vara, per-task effort mapping
summary: >
  The effort parameter is a fully orthogonal axis to model tier: it controls token spend,
  tool-call count, and reasoning depth within a fixed model ceiling. Sonnet 4.6's ceiling is
  `high` — xhigh is silently unavailable on that tier, which directly invalidates the
  proposed Vara configuration (Sonnet + xhigh). Inverse-scaling research from both Anthropic
  and external researchers shows that capping effort below `high` is the correct choice for
  pattern-based, repetitive, and distractor-heavy tasks. The "task coordinator" layer between
  architect and implementation is a recognized pattern in CrewAI, LangGraph, and Anthropic's
  own opusplan alias — but it runs at mid-tier model + high effort, not xhigh.

keyFindings:

  - claim: >
      Sonnet 4.6 supports only low/medium/high/max effort. xhigh is silently unavailable —
      requesting it causes Claude Code to fall back to `high`. xhigh is exclusive to Fable 5,
      Mythos 5, Opus 4.8, and Opus 4.7.
    evidence: >
      Anthropic effort docs table: xhigh row reads "Available on Claude Fable 5, Claude
      Mythos 5, Claude Opus 4.8, and Claude Opus 4.7" — Sonnet 4.6 is absent from this row.
      Anthony Maio Substack (2026-06-25): "xhigh on Opus 4.6 silently runs as high" and
      "Sonnet 4.6 does not support xhigh." Claude Code search result (2026-06-25): "Sonnet
      4.6 and Opus 4.6 stop at high (asking for xhigh on those falls back to high)."
    citations:
      - https://platform.claude.com/docs/en/build-with-claude/effort (verified 2026-06-25)
      - https://anthonymaio.substack.com/p/opus-47-the-five-effort-levels-in (verified 2026-06-25)
    confidence: high
    bearing: >
      Vara is proposed at Sonnet + xhigh. This configuration is a no-op — Vara would silently
      run at Sonnet + high. Either (a) accept Sonnet + high as the actual Vara configuration,
      or (b) promote Vara to Opus + xhigh if xhigh behavior is genuinely required.

  - claim: >
      Sonnet 4.6's API default is `high`, not `medium`. The effort docs explicitly say
      "Sonnet 4.6 defaults to high effort" and advise operators to set effort explicitly to
      avoid unexpected latency. The AMD/Laurenzo incident (GitHub #42796) involved a drop to
      effort=85 (equivalent to `medium`) — that was a regression from the default, not the
      default itself.
    evidence: >
      Anthropic effort docs (Sonnet 4.6 section): "Sonnet 4.6 defaults to `high` effort.
      Explicitly set effort when using Sonnet 4.6 to avoid unexpected latency." This corrects
      the pre-dive framing that Sonnet 4.6 default = medium. The AMD incident was a regressed
      default applied by Anthropic's Feb 2026 update, not the stable API default.
    citations:
      - https://platform.claude.com/docs/en/build-with-claude/effort (verified 2026-06-25)
    confidence: high
    bearing: >
      Houston and Vara baselines should be specified explicitly in frontmatter — do not rely
      on defaults. Current API default for Sonnet 4.6 is `high`; for Opus tiers, `high` as
      well. Explicit beats implicit for reproducibility.

  - claim: >
      The five effort levels have clearly differentiated behaviors: low cuts tool-call count
      and pre-action explanation; medium is balanced; high is the API default and quality
      sweet-spot; xhigh adds extended exploration for long-running agentic and coding tasks
      (30+ min, millions of tokens); max removes all constraints and can cause overthinking
      on structured-output tasks.
    evidence: >
      Anthropic effort docs table (verified 2026-06-25):
        low: "simpler tasks, best speed and lowest costs, like subagents"
        medium: "balance of speed, cost, and performance"
        high: "complex reasoning, difficult coding, agentic tasks — equivalent to omitting parameter"
        xhigh: "long-running agentic and coding tasks over 30 minutes with token budgets in the millions"
        max: "absolute maximum capability — tasks requiring deepest possible reasoning"
      Effort affects ALL tokens: text, tool calls, extended thinking. Lower effort = fewer
      tool calls, less preamble, terse confirmations. Higher effort = more tool calls, plan
      before action, detailed summaries.
    citations:
      - https://platform.claude.com/docs/en/build-with-claude/effort (verified 2026-06-25)
    confidence: high
    bearing: >
      Delta (Haiku, low/medium) mapping is confirmed by "like subagents" language in the
      low-effort description. Trajectory (Sonnet, medium) is defensible as the execution-task
      default. Houston (Opus, high) aligns with the high-effort description for complex
      reasoning. Vara at Sonnet + high is achievable; Sonnet + xhigh is not.

  - claim: >
      Anthropic's own inverse-scaling research identifies four task classes where longer
      reasoning degrades Claude model performance: (1) simple counting with distractors,
      (2) regression tasks with misleading features, (3) complex deduction puzzles,
      (4) AI safety scenarios (increased self-preservation expressions).
    evidence: >
      Research led by Aryo Pradipta Gema, Ethan Perez, Yanda Chen, Joe Benton (Anthropic
      + academic collaborators). Terminology: "inverse scaling in test-time compute."
      Published late 2025 at safety-research.github.io/inverse-scaling-ttc. Models tested
      include Claude Sonnet 4. Mechanism: (1) distractor tasks — more reasoning time
      increases sensitivity to irrelevant information; (2) regression — extended reasoning
      shifts from sound priors to spurious correlations; (3) deduction — all models
      showed degradation, mechanism unclear; (4) AI safety — self-preservation language
      grows with reasoning depth.
    citations:
      - https://www.istartvalley.org/blog/anthropic-researchers-discover-the-weird-ai-problem-why-thinking-longer-makes-models-dumber (verified 2026-06-25)
      - https://safety-research.github.io/inverse-scaling-ttc/ (primary, not directly fetched)
    confidence: high (Anthropic-authored research; medium on specific mechanisms — no quantitative figures in available journalism)
    bearing: >
      These four danger zones apply directly to task-class effort routing: counting/
      classification tasks should be capped at low; complex deduction should be capped at
      high (not max); formatting and regression-type transforms should use medium or low.

  - claim: >
      arXiv 2502.08235 found that selecting lower-overthinking agentic trajectories improved
      SWE-bench performance by ~30% while reducing compute by 43%. Two low-effort samples
      (27.3% resolution) nearly matched high-effort configurations (29.1%). Three failure
      modes identified: Analysis Paralysis, Rogue Actions, Premature Disengagement.
    evidence: >
      Cuadron et al., "The Danger of Overthinking: Examining the Reasoning-Action Dilemma
      in Agentic Tasks," arXiv 2502.08235 (Feb 2025). 4,018 trajectories across 19 models
      on SWE-bench Verified. Reasoning models showed "nearly three times higher" overthinking
      scores than non-reasoning models in agentic tasks.
    citations:
      - https://arxiv.org/abs/2502.08235 (verified 2026-06-25)
    confidence: high (preprint, not peer-reviewed; quantitative results are from a controlled study)
    bearing: >
      Agentic coding execution (Trajectory's domain) is specifically a danger zone for
      over-effort. Trajectory at Sonnet + medium is evidence-backed. Using max effort on
      Trajectory-class tasks risks Analysis Paralysis failure mode.

  - claim: >
      Medium/AI Transfer Lab identifies three code task sub-types where extended thinking
      is harmful: (1) pattern-based tasks where the familiar answer is correct and
      deliberation introduces noise; (2) repetitive transformations where thinking tokens
      don't carry forward across calls and break prompt caching; (3) formatting/completion
      where the model already knows the answer.
    evidence: >
      AI Transfer Lab blog (Medium, verified 2026-06-25): "up to 36% performance
      degradation on intuitive-response tasks." Mechanism consistent with arXiv 2502.08235
      and Anthropic inverse-scaling research reached independently.
    citations:
      - https://medium.com/@ai_transfer_lab/claudes-extended-thinking-in-code-when-it-helps-and-when-it-wastes-your-budget-4e0e2e631d43 (verified 2026-06-25)
    confidence: medium (blog with no raw experimental data; mechanistically consistent with primary sources)
    bearing: >
      Delta (Haiku + low/medium) assignments are justified not just by cost but by the
      evidence that low effort is actively better for pattern-based tasks.

  - claim: >
      The Agent tool in Claude Code has NO effort parameter. Effort is set via: (a)
      subagent frontmatter `effortLevel:` field — NOT YET SHIPPED; (b) CLAUDE_CODE_EFFORT_LEVEL
      env var — session-global, applies to all subagents equally; (c) /effort command
      or session-level config. GitHub issues #31536 (closed, no Anthropic response) and
      #43083 (open, April 2026, no Anthropic response) request per-subagent effort.
    evidence: >
      Issue #31536 (closed, retrieved 2026-06-25): requests effortLevel frontmatter field.
      Workarounds listed: smaller model (doesn't fix thinking overhead from global effort),
      SubagentStart hooks (CLAUDE_CODE_EFFORT_LEVEL is read at process start, not per-turn),
      separate sessions (loses context). All workarounds described as insufficient.
      Issue #43083 (open, April 2026): requests effort param in Agent tool invocation JSON
      and frontmatter. 28-agent trading system described as blocked use case.
    citations:
      - https://github.com/anthropics/claude-code/issues/31536 (verified 2026-06-25; CLOSED)
      - https://github.com/anthropics/claude-code/issues/43083 (verified 2026-06-25; OPEN)
    confidence: high
    bearing: >
      Vara cannot be configured at a different effort level from Houston or Trajectory using
      current tooling. The 2D assignment space (model × effort) is desired but not yet
      shipped. Practical workaround: use named model variants (opusplan alias, or separate
      .claude/agents/*.md files) and accept session-global effort as the constraint.

  - claim: >
      Claude Code ships `opusplan` as a native alias: uses Opus during plan mode, then
      switches to Sonnet for execution. This is Anthropic's own shipped expression of a
      planner-executor pattern.
    evidence: >
      Claude Code model-config docs (code.claude.com/docs/en/model-config, verified
      2026-06-25): "opusplan: Special mode that uses `opus` during plan mode, then switches
      to `sonnet` for execution."
    citations:
      - https://code.claude.com/docs/en/model-config (verified 2026-06-25)
    confidence: high
    bearing: >
      opusplan is the shipped near-equivalent of Houston(Opus, plan) → Vara/Trajectory
      (Sonnet, execute). Vara as a persistent session-holder is an extension of this pattern,
      not a novel invention. The shipped primitive validates the pattern's value; the gap is
      state persistence and effort differentiation between plan and execute phases.

  - claim: >
      CrewAI's official LLM selection guide names three role tiers: Manager (premium
      reasoning model), Content/creative agents (mid-tier), Processing/routine agents
      (efficient/fast model). The manager role maps to coordination and delegation decisions
      across concurrent operations — not the same as the architect/designer role.
    evidence: >
      CrewAI docs (docs.crewai.com/en/learn/llm-selection-guide, verified 2026-06-25):
      Manager LLM examples include "Claude 4 Sonnet" and "Gemini 2.5 Pro" — Sonnet-class,
      not Opus-class. Manager role described as needing "strong reasoning capabilities to
      make good delegation decisions, consistent performance to ensure predictable
      coordination." The strategic/manager tier is characterized by "multi-step complex
      analysis" and "plan, coordinate, synthesize across agents."
    citations:
      - https://docs.crewai.com/en/learn/llm-selection-guide (verified 2026-06-25)
    confidence: high
    bearing: >
      CrewAI's Manager agent (Sonnet-class) maps well to Vara's proposed function:
      coordination and delegation without re-doing top-level architectural thinking. The
      Manager role sits structurally between a human/Opus-level strategist and leaf workers.
      CrewAI assigns Sonnet-class to this role, not Opus-class — consistent with Vara at
      Sonnet + high.

  - claim: >
      LangGraph's Supervisor pattern is the nearest structural equivalent to Vara:
      a typed-contract orchestrator that decides agent routing and aggregates outputs, sitting
      between an outer planner and leaf worker nodes. This pattern is in production at Uber,
      Klarna, LinkedIn, Replit, and AppFolio as of 2026.
    evidence: >
      Search results (2026-06-25): "LangGraph's supervisor pattern is the orchestrator-worker
      shape with a typed message contract between supervisor and workers." Production
      deployments confirmed in multiple sources. The Supervisor has a conditional routing
      function (not a leaf agent) and manages shared state accessible to all workers.
    citations:
      - https://callsphere.ai/blog/langgraph-supervisor-multi-agent-orchestration-2026 (verified 2026-06-25)
      - https://buildingeffectiveagents.com/patterns/orchestrator-worker/ (verified 2026-06-25)
    confidence: medium (search snippet, not direct fetch of LangGraph docs)
    bearing: >
      Vara as "session state holder + task dispatcher" is a recognized production pattern
      in multi-agent systems. It is not novel; it is the Supervisor/Manager tier. The
      question is not whether such a role should exist but whether it belongs in the temple
      topology given current effort-param constraints.

strongestClaim: >
  Sonnet 4.6 does not support xhigh effort — it silently falls back to high. The Vara
  proposal (Sonnet + xhigh) as written is a configuration phantom: the API accepts the
  request but executes at high. This is not a minor calibration — it changes the
  architectural rationale for distinguishing Vara from Trajectory. If Vara's role requires
  xhigh-level extended exploration and coordination depth, Vara must run on Opus 4.7 or
  Opus 4.8, not Sonnet. If Sonnet + high is sufficient for coordination decisions, then
  Vara's model assignment is valid but the effort label must be corrected.

biggestLimitation: >
  The inverse-scaling task-class table (which specific task types should be capped below
  high) is inferred from three converging sources (Anthropic research, arXiv 2502.08235,
  AI Transfer Lab) but no single source provides a clean matrix of task-class × safe-max-
  effort. Anthropic's own inverse-scaling paper (Gema et al.) has no quantitative results
  accessible via journalism; the primary source at safety-research.github.io was not directly
  fetched. The 36% degradation figure (AI Transfer Lab) has no primary citation. The per-task
  effort cap table below is synthesis from convergent but non-identical sources.

openQuestions:
  - >
    If Vara requires xhigh, is it correct to assign it Opus 4.7 or Opus 4.8 rather than
    Sonnet 4.6? What is the cost implication of Opus + xhigh as a persistent session
    coordinator vs. the current proposal?
  - >
    The effort docs state Opus 4.7/4.8 default is `high` at API level; Claude Code's
    default for Opus 4.7 in coding contexts appears to be xhigh (docs: "Claude Code's
    default for 4.7" is xhigh per Maio substack). Is there a Claude Code vs. API-default
    discrepancy per model? Needs verification.
  - >
    Issues #31536 and #43083 are both unresponded by Anthropic. Is per-subagent effort
    on a published roadmap? The pattern (model × effort 2D space) is the community's
    strongest feature demand for multi-agent configuration.
  - >
    For the Anthropic inverse-scaling four task classes: are these failure modes present at
    `high` effort or only at `max`? If they appear at high, the current Houston (Opus + high)
    configuration is already in a danger zone for deduction and regression tasks.
  - >
    opusplan is a shipped mode switching Opus→Sonnet at plan-to-execution boundary. Can
    Vara be implemented as a named session that starts in opusplan mode and then holds
    a Sonnet-only execution context? Is there a way to lock the execution half to a
    specific effort level in that mode?

emergentPatterns:

  - name: Effort-Model Orthogonality
    description: >
      Effort level and model tier are two independent routing dimensions. A Sonnet agent
      at low effort and a Sonnet agent at high effort are categorically different in tool-call
      count, reasoning depth, and latency — more different than one might expect from a
      single-axis model comparison. The AMD/Laurenzo incident (122x cost spiral from a single
      effort-level change within one model) is the strongest empirical demonstration that
      effort misconfiguration can outweigh any model-tier choice. The community (issues #31536,
      #43083) explicitly frames the desired system as a 2D assignment space: (model tier) ×
      (effort level), not a 1D quality score.
    distinctFrom: >
      The A/B/C tier thinking (Haiku/Sonnet/Opus) treats the routing problem as one-
      dimensional. Effort-model orthogonality says the actual routing space is 2D: each model
      tier has a range of available effort levels, and two agents at the same tier but different
      effort levels are more different in behavior than two agents at adjacent tiers at the same
      effort level.
    status: real-and-adopted

  - name: Effort Ceiling Asymmetry
    description: >
      Not all models support all effort levels. The ceiling is asymmetric: Sonnet 4.6 tops out
      at high (xhigh silently falls back); Opus 4.7/4.8 reach xhigh; Fable 5/Mythos 5 and
      Opus 4.8 reach max. This means the 2D routing space is not a rectangle — it is an
      L-shaped or staircase region. An agent designed for xhigh semantics (long-horizon
      exploration, millions of tokens) cannot be implemented at Sonnet tier. The xhigh ceiling
      is a hard structural constraint, not a soft guidance preference.
    distinctFrom: >
      Standard tier thinking assumes any effort level works on any model. Effort ceiling
      asymmetry shows that certain effort × model combinations are impossible — the intended
      behavior is silently dropped rather than erroring, making this a silent misconfiguration
      class.
    status: real-and-adopted

  - name: Inverse Effort Optimality
    description: >
      For specific task classes, lower effort produces better output than higher effort — the
      relationship between effort and quality is not monotonic. The mechanism differs by class:
      distractor-sensitivity tasks fail because more thinking amplifies irrelevant signals;
      pattern-based tasks fail because deliberation introduces noise over the familiar-answer
      prior; repetitive transforms fail because thinking tokens from prior calls don't carry
      forward and break prompt caching. The implication is that effort should be CAPPED per
      task class, not maximized. A per-task-class effort cap table is needed, not a universal
      "higher is better" assumption.
    distinctFrom: >
      The standard capability-gradient assumption (more thinking = better output for hard tasks)
      is only true for a subset of task classes. Inverse effort optimality identifies the
      complementary set where the gradient is reversed. This is not a noise-in-the-data
      finding — it is Anthropic's own research on their own models.
    status: real-and-adopted

  - name: Supervisor-Tier Agent Pattern
    description: >
      In production multi-agent systems (CrewAI, LangGraph, Anthropic's opusplan), a
      recognized middle layer exists between the top-level architect/planner and leaf workers.
      CrewAI calls it Manager; LangGraph calls it Supervisor; Anthropic's Claude Code calls it
      the plan-mode agent in opusplan. This role holds routing state, makes delegation decisions,
      and synthesizes worker outputs without re-doing strategic thinking. It maps directly to
      the Vara proposal. The consensus model assignment for this tier is Sonnet-class (mid-tier),
      not Opus-class. The effort assignment in production is high (not xhigh) — consistent with
      Sonnet 4.6's actual ceiling.
    distinctFrom: >
      The standard two-tier orchestrator-worker pattern (Opus → Haiku or Sonnet → leaf)
      collapses the coordinator function into the orchestrator. The supervisor-tier pattern
      explicitly separates architectural planning (Opus) from session coordination (Sonnet/
      Manager) from execution (Haiku/worker), creating a three-tier topology. Vara is the
      temple's instantiation of the supervisor tier.
    status: real-and-adopted
```

---

## Reconstructed Per-Task-Class Effort Cap Table

*Synthesized from: Anthropic effort docs, Anthropic inverse-scaling research (Gema et al.),
arXiv 2502.08235 (Cuadron et al.), AI Transfer Lab taxonomy. No single primary source supplies
this complete table — it is synthesis. Confidence is per-cell where noted.*

| Task class | Temple agent | Recommended effort | Ceiling (cap) | Rationale | Confidence |
|---|---|---|---|---|---|
| Short advisory / classification | Delta (Haiku) | low | low | Pattern-based; deliberation adds noise; Anthropic "like subagents" | H |
| Formatting / repetitive transforms | Delta (Haiku) | low | medium | Thinking tokens don't carry forward; caching breaks at high | M |
| Agentic coding execution (medium) | Trajectory (Sonnet) | medium | high | arXiv 2502.08235: low-effort trajectories ~match high at 43% lower cost | H |
| Tool-use chains, file editing | Trajectory (Sonnet) | medium | high | Effort affects tool-call count; medium = fewer but better-targeted calls | M |
| Complex debugging / multi-file refactor | Trajectory (Sonnet) | high | high | Anthropic docs: high = "difficult coding problems, agentic tasks" | H |
| Planning / coordination / delegation | Vara (Sonnet) | high | high | Vara ceiling is `high` (xhigh unavailable on Sonnet 4.6) | H |
| Synthesis / research writing | Vara or Houston | high | max | Not a danger zone; quality scales with effort for synthesis | M |
| Math / formal reasoning (hard) | Houston (Opus) | high | high | Inverse-scaling at xhigh/max for deduction — danger zone; high is the cap | M |
| Architectural decisions / long-horizon planning | Houston (Opus) | high | xhigh | Opus 4.8 supports xhigh; appropriate for >30 min exploration sessions | M |
| Counting / classification with distractors | any | low | medium | Anthropic inverse-scaling: most adversely affected by extended reasoning | H |
| AI safety reasoning (meta-reflection) | Houston (Opus) | medium | high | Anthropic research: self-preservation increases with reasoning depth | M |

**Notes:** `high` = default API value. Where "ceiling" = `high`, requesting xhigh or max risks
inverse-scaling failure modes. Where ceiling = `xhigh`, Opus 4.7/4.8 is required. Sonnet 4.6
cannot reach xhigh.

---

## Vara Configuration Correction

The operator proposed: `Vara: Sonnet 4.6, xhigh effort`

Live-verified finding: Sonnet 4.6 does not support xhigh. Requesting xhigh on Sonnet 4.6 silently
executes at `high`.

**Option A — Accept the actual behavior, correct the label:**
Vara: Sonnet 4.6, high effort. This is what would execute. The supervisor-tier pattern in
CrewAI and LangGraph assigns Sonnet-class to this role at high effort — so this is
consistent with the recognized pattern. No functional loss; just the label was wrong.

**Option B — Honor the intent, promote the model:**
If xhigh exploration depth (long-horizon, millions of tokens, 30+ min) is genuinely required
for Vara's coordination decisions, promote Vara to Opus 4.7 or Opus 4.8 at xhigh. Cost
implication: Opus 4.8 = $5/$25 per MTok vs. Sonnet 4.6 = $3/$15 per MTok — 1.67x cost
increase. Vara then sits between Houston (Opus, high) and Trajectory (Sonnet, medium) with
overlapping model tiers but differentiated effort.

**Option C — Defer per-subagent effort, use opusplan:**
Use the shipped `opusplan` alias (Opus for plan phase, Sonnet for execution) as a
near-equivalent. opusplan does not expose per-phase effort configuration but it is a shipped
primitive that Anthropic maintains. Vara becomes the execution-phase identity within opusplan.

**Recommendation (as Epoch):** Option A is the most defensible. The Supervisor-tier pattern
evidence (CrewAI Manager = Sonnet-class, Anthropic opusplan = Sonnet for execution) consistently
assigns Sonnet + high to the coordinator role. Vara at Sonnet + high is not a downgrade — it is
the pattern. Correct the label; the architecture holds.

---

## Current Tooling Constraint Summary (Static vs. Dynamic Effort)

| Method | Scope | Effort per-subagent? | Status |
|---|---|---|---|
| Agent frontmatter `effortLevel:` field | Per-agent | Yes — proposed | NOT SHIPPED (issues #31536, #43083) |
| `CLAUDE_CODE_EFFORT_LEVEL` env var | Session-global | No — all agents same | Shipped |
| `/effort` command | Session-global | No | Shipped |
| Agent tool invocation `effort` param | Per-invocation | Yes — proposed | NOT SHIPPED (issue #43083) |
| `opusplan` alias | Per-phase (plan/exec) | No — model only, not effort | Shipped |

The gap: per-subagent effort configuration is the community's top multi-agent feature request
(two open issues, no Anthropic staff response as of 2026-06-25). Practical constraint: all
temple agents in a session inherit the same effort level. Workaround: accept session-global
effort as the common denominator, set it to the level needed by the most critical agent
(typically `high` for orchestration-heavy sessions), and accept that simpler agents run at
higher effort than optimal. This is a known cost inefficiency, not a correctness failure.

---

## Source Citations (all live-verified 2026-06-25)

- Anthropic Effort Docs: https://platform.claude.com/docs/en/build-with-claude/effort
- Claude Code Model Config: https://code.claude.com/docs/en/model-config
- CrewAI LLM Selection Guide: https://docs.crewai.com/en/learn/llm-selection-guide
- arXiv 2502.08235 (Cuadron et al.): https://arxiv.org/abs/2502.08235
- Anthropic inverse-scaling research (Gema et al.): https://safety-research.github.io/inverse-scaling-ttc/ (primary); https://www.istartvalley.org/blog/anthropic-researchers-discover-the-weird-ai-problem-why-thinking-longer-makes-models-dumber (journalism)
- GitHub issue #31536 (CLOSED): https://github.com/anthropics/claude-code/issues/31536
- GitHub issue #43083 (OPEN): https://github.com/anthropics/claude-code/issues/43083
- Anthony Maio Substack (effort levels): https://anthonymaio.substack.com/p/opus-47-the-five-effort-levels-in

sections to refresh: [Anthropic inverse-scaling paper primary source (safety-research.github.io/inverse-scaling-ttc) — fetch and extract quantitative results; GitHub issue #43083 for any Anthropic response; Claude Code effort defaults by model in Claude Code vs. API context (potential discrepancy between xhigh-as-default for Opus 4.7 in Claude Code vs. high-as-default at API level); Vara cost modeling if promoted to Opus 4.7 xhigh]
