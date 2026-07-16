# Claude Model Stratification — Temple Agent Assignments
`study: capabilities.claude · phase: 6-output · date: 2026-06-25`
`status: DRAFT — for @majkee gavel. Not doctrine until locked.`
`harness: research/harness/research-pattern.md`

---

## Phase 5 — Adversarial Claim Verdicts

| Claim | Verdict | Survives as |
|-------|---------|-------------|
| Sonnet-at-high-effort beats Opus-at-low-effort for coding | **HOLDS-WITH-CAVEATS** | Sonnet 4.6 max ≈ Opus 4.6 on Verified (1.2pt). But Opus 4.8 has a real 9pt Verified gap and 25.6pt Pro gap. Depends on generation + task difficulty. |
| Haiku is sufficient for well-specified tool-use / execution loops | **HOLDS** | 73.3% SWE-bench Verified (thinking already included); 60% of prompts indistinguishable from Sonnet; Anthropic ships Explore→Haiku. Context cap requires earlier escalation trigger than assumed (100–128K not 200K). |
| Opus adds value over Sonnet only in math and adversarial deliberation | **REFUTED** | Opus earns on: (1) LAB all-pass gate reasoning (structurally = challenge-before-lock); (2) SWE-bench Pro hard coding (25.6pt gap); (3) risk-weighted roles where error cost justifies tier, regardless of task complexity. The math gap is only 3.7pt at equal effort — risk-weighting is the real Opus argument, not raw GPQA delta. |
| Fable-class sits between Sonnet and Opus for synthesis at lower cost | **REFUTED** | Fable 5 was pulled within 48h of launch. Silent self-degradation confirmed in Anthropic system card. $10/$50 MTok = 2× Opus. Not available. |

---

## The Structural Finding

**The old "tier = quality" model is wrong. The correct model has three axes:**

```
Quality = f(tier ceiling, effort within tier, task-class fit)
```

1. **Tier** sets the ceiling (what the model can do at best)
2. **Effort** is a behavioral axis (not just reasoning depth): high effort → more tool calls, explicit planning, self-interrogation; low effort → fewer tool calls, terse execution
3. **Task-class fit** determines where the tier gap is real vs artifact (GPQA: 3.7pt real gap at equal effort; SWE-bench Pro: 25.6pt real gap; Finance Agent: Sonnet leads)

**Effort misconfiguration risk >> tier selection risk.** AMD/Laurenzo: single effort default change → 70% quality loss + 122× cost explosion. No tier change comes close.

---

## Stratification Matrix — Draft for Gavel

### Key corrections from research (vs pre-study baseline)

| Change | Before | After | Evidence |
|--------|--------|-------|----------|
| Houston tier | sonnet | **opus** | LAB all-pass coherence; risk-weighting; effort=high self-interrogation |
| Color effort | opus, xhigh | **opus, xhigh (restored)** | ARC-AGI-2 caution is for pattern induction, not formal proof derivation; @Color's domain is proof/tensor/formal grammar — xhigh appropriate |
| Agol model | fable | **opus** | Fable 5 pulled; synthesis at Opus appropriate |
| GPQA gap framing | "17.2pt Opus advantage" | **"3.7pt at equal effort"** | Sonnet 4.6 system card: all scores are max-effort |
| Sonnet xhigh on Vara | proposed | **silently falls to high** | Sonnet 4.6 does not support xhigh; Dive D confirmed |
| Context escalation trigger | 200k cap | **100–128k consumption** | Context rot at 64–128k by frontier heuristic |
| Haiku thinking on Delta | "reserve upgrade" | **73.3% already includes thinking** | Anthropic: "128K budget, 50 trials" |

---

### The matrix

| Agent | Model | Effort | Thinking | Role | Key evidence |
|-------|-------|--------|----------|------|-------------|
| **@Houston** | opus | high | adaptive (default) | Architect, planner, gate design, challenge-before-lock | LAB all-pass 10.4% (chain-gate coherence); effort=high self-interrogation behavior; Anthropic multi-agent: Opus orchestrator topology |
| **@Janus** | opus | xhigh | adaptive | Adversarial challenger — must exceed Houston's reasoning envelope | LAB coherence; error cost justifies xhigh; challenge meaningful only if deeper than architect |
| **@Color** | opus | xhigh | adaptive | Math/formal reasoning co-brain | GPQA 89.9% (Sonnet) vs 93.6% (Opus) = 3.7pt at equal effort; ARC-AGI-2 caution (max worse than high) applies to **pattern induction**, not to formal proof derivation — @Color's actual domain; xhigh restored |
| **@Agol** | opus | high | adaptive | Synthesis / continuous advisor (Fable → Opus) | Fable 5 pulled; synthesis and synthesis-adjacent = Opus reasoning envelope |
| **@Vara** *(new)* | sonnet | high | adaptive | Task runner: holds current session task list, coordinates Trajectory/Delta, reports to Houston | CrewAI Manager tier = Sonnet; opusplan validates pattern; xhigh phantom (falls to high); effort=high gives planning behavior |
| **@Atlas-ui** | sonnet | high | adaptive | Interactive primitive creator | Long sessions (context risk); format precision; comprehension-heavy; @Zenith for targeted reads |
| **@Atlas-auto** | sonnet | medium | adaptive | Automated primitive emitter (orchestrator-spawned) | Structured spec → emit; no buffering; medium is efficient |
| **@Trajectory** | sonnet | high | adaptive | Senior implementation lead | SWE-bench Verified: 9pt Opus gap unjustified per-task ($3.45x); effort=high gives explicit planning + pushback behavior |
| **@Delta** | haiku | low *(static — see note)* | **OFF** | Surgical execution (read→edit→bash loops) | 73.3% SWE-bench (thinking already in); Anthropic Explore→Haiku; thinking OFF in tool loops (arXiv overthinking); OSWorld: Haiku beats Sonnet 4 |
| **@Epoch** | sonnet | medium | adaptive | Online researcher, date-calibrated | Web research = grounded execution; medium appropriate; no deep deliberation needed |
| **@Symmetry** | sonnet | medium | adaptive | Invariant/doctrine consultant | Advisory on demand; medium sufficient for doctrine questions |
| **@Hypatia** | opus | high | adaptive | Cross-project strategic verdict | Rare spawns; multi-project synthesis; Opus appropriate for strategic lock |
| **@Recorder** | haiku | low | OFF | Session memory librarian | Structured extraction + filing; Haiku more than sufficient; low effort = terse confirmations |
| **@Zenith** | haiku | low | OFF | Harness doc reader (targeted extraction) | Read-only, structured; Haiku correct; lightweight scope |

---

### Effort ceiling table by task class

| Task class | Effort ceiling | Reasoning |
|-----------|---------------|-----------|
| Classification, extraction, routing, formatting | **low** | Distractors make higher effort worse (inverse scaling) |
| Scaffolding, file ops, bash loops | **low–medium** | Overthinking causes Rogue Actions; fewer tool calls = cleaner |
| Code generation from spec (new functions/classes) | **medium** | Pattern-based; deliberation adds noise |
| Hard coding / debugging (multi-file, root cause) | **high** | Ceiling; max adds Analysis Paralysis risk (arXiv) |
| Planning / orchestration | **high** | Explicit plan-before-act behavior engaged |
| Math / formal reasoning (proofs, derivations) | **high** (Sonnet) / **xhigh** (Opus) | Sonnet caps at high; Opus has xhigh; Janus needs xhigh |
| Synthesis / multi-source report | **high** | Diminishing returns above this |
| Adversarial challenge | **xhigh** | Must exceed architect's reasoning depth |
| ARC-AGI class (novel pattern induction) | **high** | Max effort WORSE than high (Dive B, Dive D) |

---

### Escalation ladder (agentic loops)

```
Primary: Delta (Haiku, low, thinking OFF)
  ↓ trigger: task requires spec-driven new code, 3+ hop debug, architecture analysis
Mid: Trajectory (Sonnet, high, thinking adaptive)
  ↓ trigger (hard tasks): skip mid-tier, go direct
Hard: Opus seat (Houston / Color / Janus — task determines which)

Context escalation trigger: 100–128K tokens consumed (not at 200K cap)
Cost rule: if task anticipated >150K tokens → Sonnet-from-start (saves $0.60 uncached reload)
Hard task escalation: Haiku → Opus directly (Sonnet adds only 4pt on SWE-bench Pro vs Opus's 25.6pt)
```

---

### What Vara is (new primitive — for @Atlas to define)

```
Name: vara
Role: Task runner — holds current session task list, coordinates execution agents
Spawned by: Houston
Spawns: Trajectory, Delta (and advisory agents as needed)
Model: sonnet
Effort: high
Thinking: adaptive
Scope: project session (not global — carries the current plan)
Distinct from Houston: Houston plans and gates; Vara executes against the plan
Distinct from Trajectory: Vara coordinates; Trajectory implements
Pattern: CrewAI Manager tier; Anthropic opusplan execute-phase
```

---

### Monitoring protocol (for Haiku validation)

Per the operator's directive: monitor Haiku's Delta seat in real use.

| Signal | Threshold | Action |
|--------|-----------|--------|
| Correction rate | >20% on a task class | Flag that class for Trajectory escalation |
| Context consumption | >100K tokens | Trigger escalation to Trajectory |
| User interrupts per session | >3 on a task type | Review effort level + task-class fit |
| Root-cause failures | Any architecture/3+-hop debug | Route to Trajectory from task start |

Log: `(agent, model, effort, task-type, user-interrupt-count)` per session. SessionEnd hook.

---

---

---

### Delta effort note — current limitation vs design intent

**Design intent:** orchestrating agent (Vara / Trajectory) reads task challenge and spawns Delta with calibrated effort — `low` for simple surgical edits, `medium` for complex-but-specified coding tasks.

**Current limitation:** per-subagent effort from orchestrator is not yet shipped (GitHub #43083 open). Delta's `effort: low` in frontmatter is the only knob; orchestrator cannot override per-spawn.

**Workaround until #43083 ships:** the routing table IS the effort calibration. Orchestrator selects the agent whose static effort matches the task challenge:

| Task challenge | Agent | Model | Effort |
|----------------|-------|-------|--------|
| Simple surgical (known file + known change) | @Delta | haiku | low |
| Medium coding (bigger content, new code, no judgment needed) | @Vector | sonnet | medium |
| Complex + opinions needed + may spawn Delta | @Trajectory | sonnet | high |

When #43083 ships: collapse @Vector and @Delta into a single `@Delta` whose effort the orchestrator specifies per-spawn. Until then: route by agent, not by effort dial.

---

### New primitives queued (post-gavel)

| Agent | Model | Effort | Status | Role |
|-------|-------|--------|--------|------|
| **@Vector** | sonnet | medium | TO BUILD — @Atlas | Middle-tier implementer; sibling to @Trajectory; persona: Oliver Heaviside (made vectors practical, self-taught, reliable output, no pushback). Dispatched when content exceeds Haiku context OR task is medium-complexity new code. Does NOT spawn @Delta. Does NOT push back. |

---

### Open questions (not resolved by this study)

1. **Opus vs Sonnet as orchestrator head-to-head**: No public benchmark ablates orchestrator model tier in a multi-agent system. The Anthropic 90.2% finding proves decomposition wins; it does NOT prove Opus orchestrator > Sonnet orchestrator.
2. **@Color re-evaluation threshold**: At 3.7pt GPQA gap, @Color is primarily Opus-justified by risk-weighting and xhigh access. If Sonnet 4.7 closes to <2pt, the case weakens.
3. **Haiku 4.5 on aider Polyglot**: Not yet listed. Monitor monthly.
4. **Per-agent effort frontmatter**: GitHub #31536 (closed) and #43083 (open). When shipped, effort column becomes per-spawn, not per-session.
5. **Fable/Mythos timeline**: Unknown. When Fable returns with stable availability, re-evaluate @Agol and @Houston ceiling.

---

*This is a research draft. All assignments require @majkee gavel to become temple doctrine.*
*Source files: raw.research/capabilities.claude/ (6 lens files + 5 dive files + source map)*
*Next: update agent frontmatter after gavel. @Atlas handles the writes.*
