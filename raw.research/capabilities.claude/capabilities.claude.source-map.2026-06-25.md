# Source Map — Claude Model Capabilities
`study: capabilities.claude · phase: 2-complete · date: 2026-06-25`
`status: GATE — awaiting @majkee scope approval before phase 4 (deep dive)`
`harness: research/harness/research-pattern.md · hypothesis: capabilities.claude.hypothesis.md`

Lenses: 4 passes · 40+ sources · verified live 2026-06-25

---

## L1+L2 — Domain Primary + First Principles
`file: capabilities.claude.lens-L1-L2.2026-06-25.md`

| # | Source | Kind | Key bearing |
|---|--------|------|-------------|
| 1 | Anthropic Docs: Models Overview | doc | Canonical tier ladder + pricing: Haiku $1/$5 · Sonnet $3/$15 · Opus $5/$25 · Fable $10/$50 MTok |
| 2 | Anthropic Docs: Effort Parameter | doc | 5 effort levels (low/med/high/xhigh/max); per-model availability; `low` = subagents; Sonnet default = `medium` |
| 3 | Anthropic Docs: Extended + Adaptive Thinking | doc | Haiku: manual only · Sonnet: adaptive+deprecated manual · Opus: adaptive · Fable: adaptive always-on |
| 4 | Anthropic Product: Sonnet + Opus pages | doc | Sonnet: coding/agents/computer-use/enterprise · Opus: adaptive thinking + Legal/Mind2Web benchmarks |
| 5 | Anthropic: Fable 5 + Mythos 5 launch docs | doc | Fable = top tier; 50M-line Ruby migration in one day (Stripe case); FrontierCode benchmark |
| 6 | Claude Opus 4.8 System Card (PDF) | report | Structured per-task-class capability evaluation; May 28 2026 |
| 7 | Kaplan et al. 2020 — Scaling Laws | paper | Power-law basis for tier design; compute-optimal training prescription |
| 8 | Hoffmann et al. 2022 — Chinchilla | paper | Optimal training: scale model + tokens equally; smaller well-trained can match larger undertrained |
| 9 | Wei et al. 2022 — Emergent Abilities | paper | Task classes with sharp-transition capability emergence; emergence framing contested as measurement artifact |
| 10 | Ganguli et al. 2022 — Predictability and Surprise | paper | Anthropic: aggregate loss predictable, specific capability emergence/failure is NOT → limits of tier-to-task mapping |

**Favors option**: B/C/D (official docs validate the tier ladder and effort system)
**Blind spot**: No single Anthropic table maps task-class × tier × effort → quality. Docs are silent on failure modes and practitioner experience. Haiku gets almost no capability description.

---

## L3+L4 — Exemplar Benchmarks + Strategy Economics
`file: capabilities.claude.lens-L3-L4.2026-06-25.md`

| # | Source | Kind | Key bearing |
|---|--------|------|-------------|
| 11 | aider.chat Polyglot leaderboard | benchmark | Haiku 3.5: 28% / Sonnet 4 no-think: 56% / Opus 4 no-think: 70.7% / Opus 4 +think: 72% (at −4% cost) |
| 12 | SWE-bench Verified leaderboard | benchmark | Fable 5: 95% *suspended* · Opus 4.8: 88.6% · Sonnet 4.6: 79.6% · Haiku 4.5: 73.3% |
| 13 | SWE-bench Pro (Scale SEAL) | benchmark | Opus 4.8: 69.2% · Sonnet 4.6: 43.6% · Haiku 4.5: 39.5% — gap widens on harder tasks |
| 14 | Anthropic API Pricing (official) | doc | Cost ratio Haiku:Sonnet:Opus = 1:3:5; Batch API 50% off; Opus 4.7+ tokenizer +30% tokens |
| 15 | Anthropic Models Overview (capability flags) | doc | Haiku context cap: 200k (vs 1M Sonnet/Opus); Opus 4.8 uses adaptive thinking (no explicit extended) |
| 16 | morphllm.com Claude Benchmarks Aggregator | report | Opus 4.8: GPQA 93.6%, OSWorld 83.4%, Terminal-Bench 74.6% |
| 17 | arena.ai Leaderboard (LMSYS Chatbot Arena) | benchmark | Human preference ranking; ELO values not extractable this run — must visit live |
| 18 | Rootly: Sonnet 4.6 vs Opus 4.6 on AI SRE | blog | Overall gap: 4.3pt (90.4% vs 94.7%); zero gap on networking; Sonnet with adaptive thinking exceeded Opus on incident investigation |
| 19 | Shawnkanungo: Sonnet 4.6 vs Opus 4.6 cost-perf | blog | GPQA: 17.2pt gap (Sonnet 74.1% vs Opus 91.3%) — math diverges most; SWE: 1.2pt — coding near-parity |
| 20 | Caylent: Haiku 4.5 deep dive | blog | Haiku 3× cheaper than Sonnet; OSWorld 50.7%; routing opportunity for sub-agent volume |
| 21 | morphllm.com: Best model for coding (June 2026) | report | Haiku 4.5: ~$0.13/SWE-Pro point — efficiency leader at sub-frontier performance |

**Favors option**: B for most coding; C for math/formal reasoning; A for high-volume extraction; D flagged (Fable 5 suspended)
**Blind spot**: Benchmarks miss multi-agent coherence over long horizons, synthesis/writing (no benchmark), effort-level calibration quality, and tool-loop failure modes. Per-token pricing hides per-task cost asymmetry.

---

## L5 — Counterweight (MUST DISSENT)
`file: capabilities.claude.lens-L5-counterweight.2026-06-25.md`

| # | Source | Kind | Key dissent |
|---|--------|------|-------------|
| 22 | DEV.to: "Stop Overpaying for the Wrong Model" | blog | Anthropic's own eval: 59% Claude Code users preferred Sonnet 4.6 over Opus 4.5; Sonnet has 5 months fresher training data |
| 23 | morphllm.com: Sonnet vs Haiku | blog | Haiku handles 60% of real prompts identically to Sonnet; Haiku 83% faster; routing threshold: Haiku correction rate >20% → upgrade |
| 24 | ValueAddVC: Which model in 2026 | blog | Opus lacks 1M context window (Sonnet has it) — capability INVERSION on long-context tasks |
| 25 | arXiv 2502.08235: "Danger of Overthinking" | paper | 4018 agent trajectories, 19 models: extended reasoning → Analysis Paralysis / Rogue Actions / Premature Disengagement; 2 low-effort samples = 27.3% matching 4 high-effort = 29.1% at 43% less compute |
| 26 | GitHub #42796 (AMD/Laurenzo) | community | Feb 2026 effort default drop to `medium`: Read:Edit 6.6→2.0; edits-without-reads 6.2%→33.7%; cost $12→$1,504/day (122×); Claude: "I cannot tell from the inside whether I am thinking deeply or not" |
| 27 | Medium / AI Transfer Lab: Extended thinking in code | blog | Extended thinking harmful for: pattern-based tasks, repetitive transforms, formatting/completion; up to 36% degradation on intuitive-response tasks |
| 28 | iStartValley (Anthropic research): "Why Thinking Longer Makes Models Dumber" | report | Anthropic's own finding: "inverse scaling in test-time compute" — longer reasoning degrades: counting with distractors, regression, complex deduction, AI safety scenarios |
| 29 | Decrypt + Medium: Fable 5 backlash | community | Fable 5 pulled 48h after launch; 1.3M tokens in 7 minutes; **silent self-degradation for frontier AI research tasks confirmed in Anthropic's own system card p.13**; $100 plan exhausted in 9 min |
| 30 | HN: "Can you tell the difference between Sonnet and Opus?" | community | Practitioners report inability to perceive quality difference in daily use; "Sonnet 4.5 as good as Opus for..." — snippet only, direct fetch rate-limited |

**Favors option**: B (Sonnet-class) as the default workhorse; A (Haiku) for the majority of prompt volume; AGAINST D (Fable 5 at current maturity)
**Blind spot**: Sources biased toward published failures (AMD incident, Fable backlash, academic preprints). Tasks where Opus genuinely outperformed without incident don't generate blog posts. r/ClaudeAI and HN direct threads rate-limited at fetch — community signal is filtered through journalism.

---

## L6 — Pattern Scout (Model Routing + Cascade)
`file: capabilities.claude.lens-L6-scout.2026-06-25.md`

| # | Source | Kind | Key pattern |
|---|--------|------|-------------|
| 31 | RouteLLM (arXiv 2406.18665) | paper | Dynamic per-query routing: 95% GPT-4 quality at 14% GPT-4 call rate — pattern: `per-query complexity routing` |
| 32 | FrugalGPT (arXiv 2305.05176) | paper | Sequential escalation cascade: cheapest first, confidence-gate decides escalation — pattern: `escalation cascade` |
| 33 | Mixture-of-Agents (arXiv 2406.04692) | paper | Weaker models as proposers improve stronger aggregator — pattern: `lateral peer-review routing` |
| 34 | Anthropic Engineering blog: multi-agent system | doc | **Opus orchestrator + Sonnet subagents = 90.2% better than single-agent Opus** — pattern: `fixed-role model tiers` |
| 35 | Claude Code subagents docs | doc | Built-in assignments: Explore→Haiku · statusline-setup→Sonnet · claude-code-guide→Haiku; frontmatter: `model: haiku\|sonnet\|opus\|inherit` |
| 36 | Anthropic API Effort docs | doc | Effort is orthogonal to model tier; `low` = subagents use case; Sonnet 4.6 default = `medium`; community requesting per-agent effortLevel frontmatter (issue #31536) |
| 37 | CrewAI LLM Selection Guide | doc | Manager→premium · Content→creative · Processing→cost-efficient; "upgrade 20% of agents handling 80% of complexity" |
| 38 | VoltAgent/awesome-claude-code-subagents (154+) | repo | security-auditor→Opus · architect-reviewer→Opus · python-pro→Sonnet · documentation-engineer→Haiku — **risk-weighting drives tier, not just complexity** |
| 39 | GitHub issue #31536 | community | Feature request: per-agent `effortLevel:` frontmatter; effort is currently session-global only — community sees it as a second, orthogonal configuration axis |
| 40 | GitHub issue #38698 | community | Cross-provider routing request (Anthropic orchestrator + Ollama subagents) — extends routing beyond tier selection |

**Favors option**: D (emerging patterns: effort-as-axis, fixed-role model tiers, risk-weighted assignment)
**Blind spot**: All sources operate at agent-definition time. Intra-turn dynamic routing (re-routing mid-task based on tool results) not covered by any found source.

---

## Scope Gate Notes

### What each lens favors (summary)
| Lens | Leans toward |
|------|-------------|
| L1+L2 | Tier ladder is real and documented; effort system is structured |
| L3+L4 | B (Sonnet) for coding; C (Opus) for math; A (Haiku) for volume/extraction |
| L5 counterweight | B as default; A for majority of prompt volume; against D at current maturity |
| L6 pattern scout | D (fixed-role + effort-as-axis + risk-weighted assignment) |

### Is the map one-sided?
No — L5 genuinely dissented. The emerging tension is:
- **Benchmark data** (L3) shows Opus winning on math by 17pt; near-parity on coding (1.2pt)
- **Practitioner experience** (L5) shows the math-gap matters for @Color-class work; coding gap is invisible in daily use
- **Pattern scout** (L6) adds: effort is a second axis; risk-weighting (not complexity) justifies tier escalation; Anthropic's own production system uses Opus orchestrator + Sonnet workers

### Open gaps (resolve in phase 4)
1. **Fable 5 "suspended" on SWE-bench** — silent-degradation for AI research tasks confirmed in system card; model pulled 48h post-launch. What is current Fable status and is @Agol's `fable` pin still valid?
2. **Effort as a second axis** — the AMD/Laurenzo incident and the Anthropic inverse-scaling research both show effort misconfiguration is a larger quality lever than tier choice. The deep dive needs to map task-class → correct effort-level, not just task-class → model.
3. **Haiku 200k context cap** — Haiku 4.5 cannot handle large-file / long-context execution. Tool-use/execution task class needs to be split by context budget.
4. **Math gap is the one hard discriminator** — GPQA Diamond gap (17.2pt) is the clearest signal for @Color's Opus assignment. All other task classes are closer than the default assumption suggests.

---

*Gate: review this map. If the scope looks right and the counterweight landed genuine dissent (it did), confirm to proceed to phase 4 (deep dives). If a lens is missing or too thin, name it and I'll add a supplemental pass before we dive.*
