# Study: Claude Model Capabilities
`study: capabilities.claude · date: 2026-06-25 · harness: research/harness/research-pattern.md`
`status: PHASE 2 — blind source discovery in progress`

---

## Hypothesis
For temple agent primitives, which Claude model tier (Haiku / Sonnet / Opus / Fable) is the correct seat for each class of work — and **at what effort level** — based on the community's lived experience and real benchmarks, as of 2026-06-25?

## Scope
- **Audience**: temple operators and architects (@majkee, @Houston-family) assigning model + effort to each primitive
- **Constraint**: LIGHT LAW (i5-class CPU / 16GB / cloud-only models); cost and latency matter; quality must be *sufficient*, not absolute-best
- **Baseline** — current temple assignments to validate or challenge:

| Seat | Model | Effort | Task class |
|------|-------|--------|------------|
| @Color | opus | xhigh | Mathematical/formal reasoning |
| @Epoch | sonnet | — | Online research |
| @Agol | fable | — | Synthesis / continuous advisor |
| @Delta | haiku | — | Surgical execution (read→edit→bash) |
| @Janus | opus | — | Adversarial challenger |
| @Atlas | sonnet | — | Primitive creation |
| @Houston | sonnet | — | Planning / orchestration |
| @Trajectory | sonnet | — | Senior implementation |

---

## Options
- **A: Haiku-class** — sub-Sonnet, fast, cheap, limited reasoning depth
- **B: Sonnet-class** — mid-tier workhorse; grounded research, code, orchestration
- **C: Opus-class** — top deliberation, math, synthesis, adversarial
- **D: Emerging / specialized** — Fable, claude-sonnet-4 extended-thinking variants, hybrid routing

## Task Classes (stratification axes)
1. Coding — scaffold / implementation at medium complexity
2. Coding — hard algorithmic / refactor / debugging
3. Planning & orchestration (multi-step, agent-topology)
4. Mathematical / formal reasoning
5. Synthesis / report writing (pulling multiple sources)
6. Tool-use / execution (read → edit → bash loops)
7. Short advisory / one-shot judgment

## Effort Axis
For each task class: **minimum effort level** (low / medium / high / xhigh) at which the model is fit for purpose — including whether extended thinking meaningfully unlocks a tier jump.

---

## Cross-cuts
- `cost/token-economics` — price per task-class pass; when does Opus ROI go negative?
- `latency` — time-to-first-token and completion; where does it break interactive UX?
- `context-sensitivity` — degradation under long context (many tool calls, large files)?
- `effort-ceiling` — does extended thinking reliably unlock capability or hit a wall?

---

## Claims to refute (phase 5)
1. Sonnet-at-high-effort beats Opus-at-low-effort for coding tasks
2. Haiku is sufficient for well-specified tool-use / execution loops
3. Opus adds value over Sonnet only in mathematical proof and adversarial deliberation
4. Fable-class sits between Sonnet and Opus for synthesis tasks at lower cost

---

## Target
`decision` — a validated **{model × effort-level} → task-class** fitness matrix; plus a lean on current temple assignments (keep / promote / demote). Draft for @majkee's gavel — not direct doctrine.

---

## Output files
```
raw.research/capabilities.claude/
  capabilities.claude.hypothesis.md          ← this file (study parameters)
  capabilities.claude.source-map.2026-06-25.md   ← phase 2 output (GATE before phase 4)
  capabilities.claude.report.2026-06-25.md        ← phase 6 synthesis
  capabilities.claude.stratification.md           ← extracted matrix (draft for gavel)
```

## Lenses
| # | Type | Topic | Seed sources |
|---|------|-------|--------------|
| L1 | domain-primary | Anthropic official model docs, capability cards, model comparison tables | anthropic.com/claude, docs.anthropic.com |
| L2 | first-principles | Scaling law research; emergent capability literature | Kaplan et al., Anthropic research blog |
| L3 | exemplar | Public coding/reasoning benchmarks: SWE-bench, HumanEval, MMLU; lmarena leaderboard; aider.chat/leaderboard | aider.chat/leaderboard, lmarena.ai |
| L4 | strategy-economics | Pricing, extended-thinking cost multipliers, community cost breakdowns | anthropic.com/pricing, community threads |
| L5 | counterweight | Where Sonnet/Haiku beat Opus; where Opus disappoints or is overkill; effort-level failures | r/ClaudeAI, HN threads, practitioner X/Twitter skeptics |
| L6 | pattern-scout | Model routing / cascade patterns in agent frameworks and public AGENTS.md files | LangGraph, CrewAI, public repos |
