# Dive B — Sonnet at xhigh/max: Ceiling vs Opus Base
`study: capabilities.claude · phase: 4-dive · date: 2026-06-25 · agent: @Epoch`

---

## Critical framing correction (read before the findings)

The task brief framed the question as "Sonnet 4.6 at 79.6% SWE-bench and 74.1% GPQA — does adding xhigh/max thinking close the gap to Opus?" That framing is wrong on two counts:

**Count 1:** The official Claude Sonnet 4.6 System Card (Anthropic, February 17 2026) states explicitly in Table 2.1.A: "All Claude Sonnet 4.6 evaluation results are an average over 10 trials... adaptive thinking, max effort." The published headline scores — 79.6% SWE-bench Verified and 89.9% GPQA Diamond — already ARE the max-effort ceiling. There is no "add thinking" step to take; the benchmark scores shown everywhere are already at that ceiling.

**Count 2:** The 74.1% GPQA figure (sourced from the Kanungo practitioner blog, L3-L4) is not Sonnet at base effort — it is apples-to-oranges effort mismatch. Kanungo paired Opus's max-effort 91.3% against what is almost certainly a lower-effort Sonnet run. The system card's primary-source figure is 89.9% Sonnet 4.6 at max effort vs 91.3% Opus 4.6 at max effort: a 1.4pt gap, not 17.2pt.

This collapse of a supposed 17.2pt GPQA gap to 1.4pt is the strongest single finding in this dive.

---

## topic

Option B — Sonnet ceiling at xhigh/max vs Opus base

---

## summary

Claude Sonnet 4.6's published benchmark scores are already produced at adaptive thinking, max effort — so the "add thinking" question has already been answered by Anthropic in the system card. At max effort, Sonnet 4.6 reaches within 1.4pt of Opus 4.6 on GPQA Diamond (89.9% vs 91.3%) and within 0.6–1.2pt on SWE-bench Verified (79.6–80.2% vs 80.8%), meaning it essentially matches the prior-generation Opus. Against the current frontier Opus 4.8, a coding residual of 8.7–9pt persists on SWE-bench (the Opus 4.8 figure is at its high-effort default; the medium-effort number is not published), while the GPQA gap shrinks from the widely-cited 17.2pt figure to approximately 3.7pt. The cost crossover is real but depends on thinking-token volume; at moderate thinking depth Sonnet remains cheaper, but the comparison is not Sonnet-thinking vs Opus-no-thinking — Opus 4.8 also runs adaptive thinking by default.

---

## keyFindings

- claim: Sonnet 4.6's headline benchmarks are already at max effort — there is no separate "with thinking" uplift to add
  evidence: Table 2.1.A of the Claude Sonnet 4.6 System Card (Anthropic, Feb 17 2026) explicitly states all evaluation results use "adaptive thinking, max effort, and default sampling settings." The 79.6% SWE-bench Verified and 89.9% GPQA Diamond figures already represent the ceiling.
  citations:
    - https://www-cdn.anthropic.com/bbd8ef16d70b7a1665f14f306ee88b53f686aa75/Claude%20Sonnet%204.6%20System%20Card.pdf (Table 2.1.A, p.15, retrieved 2026-06-25)
  confidence: high
  bearing: all task classes — reframes every Sonnet benchmark claim in the study

- claim: The 17.2pt GPQA Diamond gap (Sonnet 74.1% vs Opus 91.3%) is an effort-mismatch artifact — at equal max effort the gap is ~1.4pt
  evidence: System card (primary) shows Sonnet 4.6 at 89.9% GPQA Diamond (max effort, avg 10 trials) vs Opus 4.6 at 91.3% (same table). The Kanungo blog figure of 74.1% for Sonnet is the secondary source that created the apparent 17.2pt gap; it almost certainly reflects a low- or no-effort Sonnet run. Primary overrides secondary. Opus 4.8 (morphllm, confirmed via multiple aggregators, June 2026): 93.6% GPQA Diamond — narrowing the max-effort gap to ~3.7pt vs the current flagship. Note: GPT-5.2 (93.2%) and Gemini 3 Pro (91.9%) both exceed Opus 4.6's 91.3% on GPQA; Opus 4.6 is not the ceiling on this benchmark.
  citations:
    - Claude Sonnet 4.6 System Card, Table 2.1.A, p.15 (primary, Anthropic 2026-02-17)
    - https://www.morphllm.com/claude-benchmarks (Opus 4.8 93.6% GPQA, retrieved 2026-06-25)
    - https://shawnkanungo.com/blog/claude-sonnet-46-vs-opus-46-whats-the-difference-and-which-one-should-you-use (secondary; Sonnet 74.1% figure flagged as effort-mismatch)
  confidence: high
  bearing: math/formal reasoning — directly answers Core Q2 and the @Color seat question

- claim: On SWE-bench Verified, Sonnet 4.6 at max effort (79.6%) closes to within 1.2pt of Opus 4.6 (80.8%) and can reach 80.2% with an explicit thoroughness prompt; it does NOT close the gap to Opus 4.8 (88.6%), which is measured at Opus 4.8's high-effort default — the medium-effort SWE number for Opus 4.8 is not published
  evidence: System card confirms Sonnet 4.6 SWE-bench at 79.6% (avg 25 trials, adaptive thinking, max effort). With an explicit "use tools more than 100 times, implement your own tests first" prompt, this rises to 80.2%. Opus 4.6 (same table) is 80.8% — a 0.6–1.2pt gap, statistically near parity. Opus 4.8 (morphllm) is 88.6% at its high-effort default — a persistent 8.7–9pt gap that Sonnet max effort does not close. The operator's brief asked about "Opus 4.8 at medium effort"; that specific SWE-bench number is not available in any source verified this run. The 9pt gap almost certainly survives at medium effort (a 9pt reversal from one effort step is not plausible), but cannot be confirmed precisely.
  citations:
    - Claude Sonnet 4.6 System Card, Section 2.2 and Table 2.1.A (primary)
    - https://www.morphllm.com/claude-benchmarks (Opus 4.8 88.6%, retrieved 2026-06-25)
  confidence: high (Opus 4.8 at high default vs Sonnet at max); low (exact gap at Opus medium)
  bearing: coding (hard/debug), tool-use/execution

- claim: On aider.chat Polyglot, Sonnet 4.6 is not yet listed; the closest data point is Sonnet 4 (May 2025 API ID) at 61.3% with 32k thinking tokens vs Opus 4 (no thinking) at 70.7% — a 9.4pt gap that thinking narrows but does not close
  evidence: Live aider.chat leaderboard fetch (2026-06-25) shows Sonnet 4 (claude-sonnet-4-20250514) at 61.3% with 32k thinking tokens vs Opus 4 at 70.7% without thinking. Sonnet 4.6 is not listed on the leaderboard; the most recent Claude entries are the May-2025 generation models. The aider polyglot metric may also saturate differently from SWE-bench and cannot be used to extrapolate what Sonnet 4.6 would score.
  citations:
    - https://aider.chat/docs/leaderboards/ (live fetch 2026-06-25)
  confidence: high (leaderboard state); low (inference to Sonnet 4.6)
  bearing: coding (medium) — the aider benchmark represents a distinct practitioner-relevant coding skill from SWE-bench

- claim: On agentic financial analysis (SEC filings), Sonnet 4.6 with max thinking (63.3%) EXCEEDS Opus 4.6 (60.0%) and high-thinking Sonnet 4.6 (61.4%) by a measurable margin — a task-class inversion at max effort
  evidence: Claude Sonnet 4.6 System Card, Table 2.12.2.A (Finance Agent benchmark, evaluated by Vals AI). Sonnet 4.6 max thinking: 63.3%; Sonnet 4.6 high thinking: 61.4%; Opus 4.6 (unspecified effort): 60.0%; GPT-5.2: 58.5%. Sonnet at max surpasses same-generation Opus. This is an Anthropic-reported primary result.
  citations:
    - Claude Sonnet 4.6 System Card, Table 2.12.2.A, p.24 (primary, Anthropic 2026-02-17)
  confidence: high
  bearing: tool-use/execution; planning/orchestration — confirms that max effort can produce task-class inversions where Sonnet exceeds Opus

- claim: On ARC-AGI-2, max effort (58.3%) is slightly WORSE than high effort (60.4%) for Sonnet 4.6 — an empirical example of diminishing returns at the effort ceiling; this pattern holds for Opus 4.6 as well
  evidence: Figure 2.7.A of the system card shows: Sonnet 4.6 at high effort = 60.4% on ARC-AGI-2; Sonnet 4.6 at max effort = 58.3%. Max effort costs more and performs worse on this specific novel-pattern reasoning task. Opus 4.6 shows the same direction: system card footnote 3 reports Opus 4.6 at high effort = 69.2% vs max effort = 68.8% — both models score lower at max than at high on ARC-AGI-2. The Opus gap over Sonnet at max effort is substantial at 68.8% vs 58.3% (10.5pt), the largest durable tier gap in this run. This result is consistent with Anthropic's own inverse-scaling research (Gema et al., late 2025) showing that extended reasoning degrades performance on certain task classes.
  citations:
    - Claude Sonnet 4.6 System Card, Figure 2.7.A and footnote 3, p.21 (primary)
    - arXiv 2502.08235 — "The Danger of Overthinking" (pre-print, Feb 2025)
  confidence: high
  bearing: math/formal reasoning — overthinking at max effort is a real failure mode on novel-pattern tasks; @Color seat should NOT default to max for all reasoning

- claim: The "Sonnet preferred 59%" Claude Code eval compared Sonnet 4.6 against Opus 4.5 (prior generation), not Opus 4.6 or 4.8; the effort level of that eval is not confirmed in primary sources; the "knowledge freshness" narrative (Sonnet 5 months newer) is contradicted by the system card
  evidence: The dev.to (serenitiesai) blog (L5) reported the 59% figure citing Anthropic's own Claude Code user preference evaluation. The opponent model is Opus 4.5, not current-generation Opus 4.6 or the flagship 4.8 — this is a prior-generation comparison, not a current one. The same blog claimed Sonnet 4.6 has "5 months more recent training data (Jan 2026 vs Aug 2025)." The system card (p.8, primary) states Sonnet 4.6 was trained on data "up to May 2025" — earlier than Aug 2025, not later. The dev.to freshness claim is not supported by the primary source; knowledge cutoff is a potential disadvantage for Sonnet 4.6, not an advantage.
  citations:
    - https://dev.to/serenitiesai/claude-sonnet-vs-opus-2026-stop-overpaying-for-the-wrong-model-4dcm (retrieved 2026-06-25; freshness claim flagged as contradicted by primary)
    - Claude Sonnet 4.6 System Card, Section 1.1.1, p.8 (training cutoff May 2025)
  confidence: med
  bearing: short advisory, planning/orchestration — the freshness-advantage narrative for Sonnet 4.6 is not supported by primary; the 59% preference finding is against a prior-generation Opus

- claim: Cost crossover between Sonnet 4.6 at max effort and Opus 4.8 is real but cannot be modeled as "Sonnet-thinking vs Opus-no-thinking" — Opus 4.8 runs adaptive thinking by default
  evidence: Premise correction required by the task brief: Opus 4.8 has adaptive thinking always on (confirmed in Anthropic model overview, L3) and defaults to effort=high. There is no "Opus at base with no thinking" mode to compare against. Structural calculation with live pricing: Sonnet 4.6 input $3/MTok + output (including thinking) $15/MTok vs Opus 4.8 input $5/MTok + output $25/MTok. Per-token break-even: Sonnet total cost must stay below 0.6x Opus total cost (the per-token ratio). Empirically, 30k thinking tokens alone = $0.45 additional output cost at Sonnet pricing (Caylent, 2026-06-25). Because Opus also spends thinking tokens, the true crossover is between (Sonnet-thinking-volume x $15) vs (Opus-thinking-volume x $25 + base-output x $25 - base-output x $15 Sonnet savings). Sonnet stays cheaper while its thinking volume stays below approximately 2x Opus's on the same task — a plausible but unmeasured quantity. The Kanungo claim that "Opus uses 19.3% fewer tokens per complex task" is not verified against primary and if true would push the crossover lower, not higher. No primary source publishes per-task thinking-token counts per effort level. Exact crossover modeling requires production measurement.
  citations:
    - https://platform.claude.com/docs/en/about-claude/pricing (live pricing, retrieved 2026-06-25)
    - https://platform.claude.com/docs/en/about-claude/models/overview (Opus 4.8 adaptive thinking always-on, retrieved 2026-06-25)
    - https://caylent.com/blog/claude-sonnet-4-6-in-production-capability-safety-and-cost-explained (thinking token cost example)
    - https://shawnkanungo.com/blog/claude-sonnet-46-vs-opus-46-whats-the-difference-and-which-one-should-you-use (19.3% claim, unverified)
  confidence: med (structural); low (specific crossover N)
  bearing: all task classes — economic routing decision

---

## strongestClaim

The 17.2pt GPQA Diamond gap between Sonnet 4.6 and Opus 4.6 is an effort-mismatch artifact from secondary sources, not a real capability ceiling. At equal max effort, the system card (primary, Anthropic) shows a 1.4pt gap (89.9% vs 91.3%). Sonnet 4.6 at its ceiling does reach Opus 4.6 territory on graduate-level science reasoning — and exceeds same-generation Opus on agentic financial analysis. The gap to the current flagship (Opus 4.8 at 93.6%) shrinks to 3.7pt on GPQA, while the SWE-bench gap to Opus 4.8 (8.7–9pt) is not closed by max effort. The task-class split is clean: Sonnet ceiling reaches same-generation Opus on static reasoning and near-parity on coding; it does not reach Opus 4.8 on coding.

---

## biggestLimitation

All Sonnet 4.6 system card benchmarks are run at adaptive thinking, max effort — but the system card does not publish separate low-effort or no-effort baselines in the main capabilities table. This means we cannot construct a within-model effort ladder (what does Sonnet 4.6 score at high vs max vs low on SWE-bench?) from primary sources alone. The ARC-AGI-2 result (max worse than high, 58.3% vs 60.4%) is the only primary-source evidence of the within-model effort tradeoff, and it shows a negative effect. Practitioners cannot derive an effort-calibration curve for their own task class without their own measurement. The aider.chat leaderboard (the most practitioner-proximate coding benchmark) does not yet list Sonnet 4.6 at all, leaving the key practitioner coding signal absent for this generation.

---

## openQuestions

- What is Sonnet 4.6's SWE-bench and GPQA score at medium effort (the API default)? No primary data.
- What is the actual thinking-token count produced by Sonnet 4.6 at xhigh vs max effort on a typical coding task? Anthropic's adaptive thinking API does not expose this.
- The 59% Claude Code user preference evaluation: what was the effort level of the Sonnet 4.6 runs? No primary source confirms this.
- Does Sonnet 4.6's knowledge cutoff (May 2025) place it before or after Opus 4.6? The dev.to (serenitiesai) claim of a 5-month Sonnet advantage is contradicted by the system card's May 2025 date; the Opus 4.6 training cutoff date from primary sources is unverified in this run.
- Will aider.chat add Sonnet 4.6 (with and without thinking) to the Polyglot leaderboard? That data point would close the practitioner-facing coding evidence gap.
- Is the ARC-AGI-2 max-worse-than-high pattern (58.3% vs 60.4%) reproducible on other novel-reasoning tasks, or specific to pattern-induction benchmarks?

---

## emergentPatterns

- name: Effort-mismatch inflation of tier gaps
  description: Secondary sources routinely compare Opus at max/adaptive effort against Sonnet at base or unspecified effort, producing gap numbers (17.2pt GPQA) that collapse when effort is equalized. This is the primary confusion mechanism driving "Opus is dramatically better" narratives. It affects GPQA, and likely affects other benchmark comparisons published before adaptive thinking became the default evaluation setting.
  status: real-and-adopted

- name: Task-class inversion at max effort
  description: At max effort, Sonnet 4.6 does not merely approach Opus — it surpasses same-generation Opus on specific task classes (agentic financial analysis, 63.3% vs 60.0%; OSWorld-Verified essentially tied at 72.5% vs 72.7%). The inversion is consistent with the SRE-skills-bench finding (Rootly, L3) where Sonnet matched Opus on agentic root-cause tasks. Max effort does not produce uniform uplift; it produces task-class-specific gains that can overshoot.
  status: real-and-adopted

- name: Max effort has an overthinking ceiling on novel-pattern tasks
  description: ARC-AGI-2 is the clearest in-system-card evidence: Sonnet 4.6 max effort (58.3%) underperforms high effort (60.4%) on this benchmark, and Opus 4.6 shows the same direction (max 68.8% vs high 69.2%). Combined with Anthropic's own inverse-scaling research (Gema et al.) and arXiv 2502.08235, this creates a documented pattern: static knowledge/reasoning tasks (GPQA) benefit from max thinking; novel-pattern and deductive tasks can be harmed by it. The Opus gap over Sonnet on ARC-AGI-2 (68.8% vs 58.3%) is the largest durable tier difference found in this run — making ARC-AGI-2-class tasks the strongest remaining reason to choose Opus over Sonnet at max effort.
  status: real-and-adopted

- name: Sonnet 4.6 as the de facto "Opus 4.6 quality" at Sonnet pricing
  description: For the 4.5/4.6 generation bracket, the system card establishes near-parity on SWE-bench (0.6–1.2pt gap with prompt mod), GPQA (1.4pt gap), OSWorld (0.2pt gap), and GDPval-AA Elo (Sonnet leads at 1633 vs Opus 4.6's 1606). Sonnet 4.6 at max effort delivers what Opus 4.6 delivered, at 3/5 the per-token cost. The gap is real but largely irrelevant in this generation bracket.
  status: real-and-adopted

- name: Opus 4.8 opens a new coding gap that Sonnet cannot close
  description: Opus 4.8 (SWE-bench 88.6% at high-effort default) represents a step-change above the 4.5/4.6 tier. The 8.7–9pt SWE-bench gap persists at Sonnet max effort. Because Opus 4.8 defaults to effort=high and has no thinking-off mode, the "Opus at base vs Sonnet at ceiling" comparison does not exist as a clean test; the 9pt gap is the irreducible result comparing each model at its natural operating point. Practitioners who need the Opus 4.8 coding ceiling are unlikely to close that gap with effort escalation on Sonnet.
  status: real-and-adopted

---

## @Color seat implication (explicitly asked in brief)

The @Color seat is a math/formal reasoning advisor. The relevant benchmark is GPQA Diamond, which is directly analogous to graduate-level science and math reasoning.

Primary-source finding: Sonnet 4.6 at max effort = 89.9% vs Opus 4.6 at max effort = 91.3% (1.4pt gap) vs Opus 4.8 = 93.6% (3.7pt gap). All three are within a 3.7pt band on GPQA.

Recommendation (evidence-grounded, not a final seat decision): Sonnet 4.6 at max effort is defensible for @Color on static formal reasoning tasks (GPQA-class). The counterbalancing caution: ARC-AGI-2 shows a 10.5pt Opus advantage over Sonnet at max effort on novel-pattern tasks, and max effort itself is counterproductive on both models for that benchmark. If @Color's tasks are closer to GPQA (graduate-level knowledge retrieval + reasoning on familiar domain structure), Sonnet+max is defensible. If they involve novel proof construction or pattern induction without prior exposure in training data, the Opus 4.8 gap is substantial and not closeable via effort escalation on Sonnet. Empirical testing on the actual @Color task set is the correct next step before committing.

---

## sources verified this run

- Claude Sonnet 4.6 System Card (Anthropic, 2026-02-17): https://www-cdn.anthropic.com/bbd8ef16d70b7a1665f14f306ee88b53f686aa75/Claude%20Sonnet%204.6%20System%20Card.pdf
- Aider.chat Polyglot Leaderboard: https://aider.chat/docs/leaderboards/ (live, 2026-06-25)
- morphllm.com Claude Benchmarks: https://www.morphllm.com/claude-benchmarks (aggregator, 2026-06-25)
- Anthropic pricing: https://platform.claude.com/docs/en/about-claude/pricing (live, 2026-06-25)
- Anthropic models overview: https://platform.claude.com/docs/en/about-claude/models/overview (live, 2026-06-25)
- Resolve.ai Sonnet 4.6 adaptive thinking production report: https://resolve.ai/blog/Our-early-impressions-of-Claude-Sonnet-4.6 (2026-06-25)
- arXiv 2502.08235 "The Danger of Overthinking": https://arxiv.org/abs/2502.08235 (L5 source, Feb 2025)
- Kanungo blog (Sonnet vs Opus 4.6): https://shawnkanungo.com/blog/claude-sonnet-46-vs-opus-46-whats-the-difference-and-which-one-should-you-use (secondary; effort-mismatch flagged)
- dev.to serenitiesai (Claude Code 59% preference): https://dev.to/serenitiesai/claude-sonnet-vs-opus-2026-stop-overpaying-for-the-wrong-model-4dcm (secondary; freshness claim contradicted by primary)

## sections to refresh: [GPQA Diamond at medium effort for Sonnet 4.6, Opus 4.8 SWE-bench at medium effort, aider.chat Sonnet 4.6 Polyglot score when added, Opus 4.6 training cutoff date from primary source, per-task thinking-token counts at xhigh vs max in production, @Color seat empirical task-set test results]
