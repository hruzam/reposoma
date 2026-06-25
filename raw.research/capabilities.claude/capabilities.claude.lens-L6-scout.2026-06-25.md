# Lens L6: Pattern Scout (Model Routing + Cascade)
`study: capabilities.claude · phase: 2-blind · date: 2026-06-25 · agent: @Epoch`

---

### [RouteLLM — Learning to Route LLMs with Preference Data]
- **what**: Academic paper introducing learned routers that dynamically direct each query to either a strong (expensive) or weak (cheap) LLM based on query complexity signals derived from preference data
- **kind**: paper
- **url**: https://arxiv.org/abs/2406.18665 (LMSYS blog companion: https://www.lmsys.org/blog/2024-07-01-routellm/)
- **whyDurable**: Peer-reviewed work from LMSYS (the Chatbot Arena team at UC Berkeley/UCSD), trained on the largest public human-preference dataset; four distinct router architectures tested; GitHub implementation at lm-sys/routellm with active maintenance. Represents the canonical academic baseline for per-query routing.
- **mustRead**: Section on the four router types (similarity-weighted Elo, matrix factorization, BERT classifier, causal LLM classifier); benchmark table showing MT-Bench result at 95% GPT-4 quality with only 14% GPT-4 calls; discussion of transfer learning across model pairs.
- **emergentPattern**: **per-query complexity routing** — every individual request is evaluated at inference time; routing is not fixed by role but by inferred difficulty. The router is a learned function, not a human-authored rule.
- **dateVerified**: 2026-06-25; paper submitted 2024-06-26, last revised 2025-02-23 (v4)

---

### [FrugalGPT — How to Use Large Language Models While Reducing Cost and Improving Performance]
- **what**: Academic paper proposing three strategies for LLM cost reduction; the LLM cascade strategy (the "FrugalGPT" instantiation) learns a sequential query-routing chain: try cheapest model first, escalate only on low-confidence answers
- **kind**: paper
- **url**: https://arxiv.org/abs/2305.05176
- **whyDurable**: Stanford group (Chen, Zaharia, Zou); 2023 publication that seeded the cascade/routing subfield; cited broadly in the LLM efficiency literature. The three-strategy taxonomy (prompt adaptation / LLM approximation / LLM cascade) is the de facto framing in subsequent papers.
- **mustRead**: Section 3 on LLM cascade design; the result showing 98% cost reduction while matching GPT-4 quality, or 4% quality improvement at same cost. The cascade is ordered cheapest → most expensive; a "generation scorer" decides whether to accept the current answer or escalate.
- **emergentPattern**: **escalation cascade** — models are tried in ascending cost order; a confidence-gate decides whether to pass the result up the chain. Routing is sequential and conditional, not parallel.
- **dateVerified**: 2026-06-25; paper submitted 2023-05-09

---

### [Anthropic Engineering — How We Built Our Multi-Agent Research System]
- **what**: Anthropic's own engineering blog post describing the internal production multi-agent system; explicitly names which Claude models fill orchestrator vs subagent roles and reports outcome metrics for different model combinations
- **kind**: doc
- **url**: https://www.anthropic.com/engineering/multi-agent-research-system
- **whyDurable**: First-party account from the model vendor; describes a production system, not a toy; includes quantitative ablations over model choices. Represents the authoritative statement of Anthropic's own practice.
- **mustRead**: The orchestrator-worker configuration: Claude Opus 4 as lead orchestrator + Claude Sonnet 4 as subagents yielded 90.2% improvement over single-agent Opus 4 on Anthropic's internal research eval. The finding that "model choice" is one of three explanatory factors alongside token budget and number of tool calls. [Note: secondary coverage reports additional configurations (e.g. Opus 4.5 + Haiku 4.5 pairing) but those figures were not confirmed by direct fetch of this page as of 2026-06-25.]
- **emergentPattern**: **fixed-role model tiers** — orchestrator role is pinned to the highest-tier model; worker/subagent roles are pinned to a lower tier. The assignment is by structural role, not by per-query complexity. Contrasts with RouteLLM's per-query routing.
- **dateVerified**: 2026-06-25; post published 2025 (exact date not surfaced by fetch; referenced as 2024–2025 in community coverage)

---

### [Claude Code Subagents Documentation — Built-in Agent Model Table]
- **what**: Official Claude Code documentation describing the model: frontmatter field for custom subagents and the explicit model assignments for built-in subagents (Explore = Haiku, Plan = inherit, statusline-setup = Sonnet, claude-code-guide = Haiku)
- **kind**: doc
- **url**: https://code.claude.com/docs/en/sub-agents
- **whyDurable**: Canonical, versioned Anthropic product documentation; the built-in agent table constitutes a live, shipped design decision about which model tier fits which task class. The `model: haiku | sonnet | opus | inherit` field is an operator-facing primitive.
- **mustRead**: Built-in subagent table (Tab "Other") showing Explore→Haiku, Plan→inherit, statusline-setup→Sonnet, claude-code-guide→Haiku. The note: "Control costs by routing tasks to faster, cheaper models like Haiku." The `CLAUDE_CODE_SUBAGENT_MODEL` env-var for session-wide override, and the per-agent frontmatter override.
- **emergentPattern**: **structural role-to-tier mapping** — Anthropic's own CLI ships with Haiku assigned to fast read-only exploration, Sonnet assigned to UI/config tasks, and inherit assigned to reasoning-heavy planning. This is a public, shipped expression of Anthropic's internal model-assignment doctrine.
- **dateVerified**: 2026-06-25; live documentation

---

### [Anthropic API — Effort Parameter Documentation]
- **what**: Official Anthropic API documentation for the `effort` parameter, a within-model dial that controls token spend (and thus reasoning depth) independently of model tier selection
- **kind**: doc
- **url**: https://platform.claude.com/docs/en/build-with-claude/effort
- **whyDurable**: Canonical API reference; the effort parameter is a shipped, non-beta primitive; the documentation explicitly names "subagents" as the canonical use case for `low` effort, creating a within-tier optimization axis orthogonal to model selection.
- **mustRead**: Effort level table (low / medium / high / xhigh / max); "Typical use case" column, specifically "low: subagents" and "xhigh: long-running agentic and coding tasks." The note that `effort` affects all token spend including tool calls. The recommendation that Sonnet 4.6's explicit default is `medium` (not `high`) for most applications.
- **emergentPattern**: **within-tier effort cascade** — effort levels create a second routing dimension that is independent of model tier. A Sonnet agent at `low` effort is categorically different from Sonnet at `max` effort; the effort axis is as consequential as the model-tier axis for agentic workloads. This is distinct from both per-query routing (RouteLLM) and fixed role tiers.
- **dateVerified**: 2026-06-25; live documentation

---

### [Mixture-of-Agents Enhances Large Language Model Capabilities]
- **what**: Academic paper introducing the Mixture-of-Agents (MoA) architecture: multiple LLMs assigned to proposer and aggregator roles across stacked layers; each layer receives all prior-layer outputs and synthesizes forward
- **kind**: paper
- **url**: https://arxiv.org/abs/2406.04692
- **whyDurable**: Authors include James Zou (Stanford); reported state-of-art on AlpacaEval 2.0 (65.1% vs GPT-4o 57.5%); the proposer/aggregator role distinction is a structurally different pattern from both cascades and fixed hierarchies. Reference implementation confirmed at github.com/togethercomputer/MoA (Apache 2.0; verified 2026-06-25).
- **mustRead**: Section defining proposer vs aggregator roles; the "collaborativeness" finding — weaker models as proposers improve stronger aggregator output even when proposers alone are less capable. The MoA-Lite variant using 2 layers with Qwen1.5-72B as aggregator shows the cost-quality design space.
- **emergentPattern**: **lateral peer-review routing** — rather than a strict top-down hierarchy, all models at a layer see each other's outputs. Model assignment is by role-type (propose vs synthesize), not by tier-rank. The aggregator need not be the strongest model; it is the one with best synthesis capability.
- **dateVerified**: 2026-06-25; paper submitted 2024-06-07

---

### [CrewAI — Strategic LLM Selection Guide]
- **what**: Official CrewAI framework documentation describing role-based model assignment patterns; names specific model tier recommendations for manager agents, content agents, and processing agents
- **kind**: doc
- **url**: https://docs.crewai.com/en/learn/llm-selection-guide
- **whyDurable**: CrewAI is a widely-adopted multi-agent framework (widely cited in tutorials and production case studies); this is the official guidance page, not community opinion. The `llm=` and `function_calling_llm=` per-agent configuration API is shipped code.
- **mustRead**: The role-tier mapping: Manager LLM → premium reasoning model; Content agents → creative/writing model; Processing agents → cost-efficient model. The "80/20 rule" framing: "upgrading 20% of agents that handle 80% of complexity." The concrete examples naming Gemini 2.5 Pro for manager, Claude 3.5 Sonnet for content, GPT-4o-mini for processing.
- **emergentPattern**: **task-class model assignment** — unlike a strict hierarchy, CrewAI's pattern assigns models by task domain (reasoning / creative / extraction) rather than purely by structural role (orchestrator / worker). A "processing" agent might be more important than a "content" agent but still gets a cheaper model because its task type is lower-complexity.
- **dateVerified**: 2026-06-25; live documentation

---

### [VoltAgent — Awesome Claude Code Subagents (Public Repo)]
- **what**: Community repository of 154+ Claude Code subagent definitions with explicit `model:` frontmatter fields across Haiku / Sonnet / Opus assignments; covers security, DevOps, documentation, fintech, and other role domains
- **kind**: repo
- **url**: https://github.com/VoltAgent/awesome-claude-code-subagents
- **whyDurable**: 154+ agents is a large sample; the model assignments represent aggregate community practice, not a single author's opinion. The repo is indexed by Claude Code documentation as a reference collection. The three-tier pattern (Opus for deep reasoning, Sonnet for everyday coding, Haiku for quick tasks) is expressed consistently across the corpus.
- **mustRead**: The model-assignment pattern across agent types: security-auditor → Opus; architect-reviewer → Opus; python-pro → Sonnet; backend-developer → Sonnet; documentation-engineer → Haiku; build-engineer → Haiku. The note that `model: inherit` is available as a passthrough.
- **emergentPattern**: **domain-risk model tier** — the deciding factor is not just task speed/complexity, but the consequence-sensitivity of the domain. Security and architecture agents get Opus not because the prompts are more complex, but because errors in those domains carry higher risk. This is a risk-weighted, not purely complexity-weighted, assignment.
- **dateVerified**: 2026-06-25

---

### [GitHub Issue — anthropics/claude-code #31536: Per-subagent effortLevel in agent frontmatter]
- **what**: Community feature request on the Claude Code repository for a per-subagent `effortLevel:` frontmatter field, with detailed description of the failure mode when effort is set globally (all subagents inherit the same effort regardless of role complexity)
- **kind**: community
- **url**: https://github.com/anthropics/claude-code/issues/31536
- **whyDurable**: Opened on the official Anthropic/claude-code repo; the problem description reveals a structural gap in current tooling that the community has articulated clearly. The gap itself is a signal about how practitioners want to architect multi-agent effort routing.
- **mustRead**: The two-category decomposition the author uses: "deep reasoning agents" (need high effort) vs "mechanical agents" (medium/low effort sufficient). The observation that current workarounds (downgrading model tier, hooks) are insufficient because `CLAUDE_CODE_EFFORT_LEVEL` is a session-global, not per-agent. This reveals that the community sees effort level and model tier as two separate routing dimensions.
- **emergentPattern**: **effort-model orthogonality** — practitioners are explicitly asking for per-agent effort as a separate axis from per-agent model. The desired system is a 2D assignment space: (model tier) × (effort level), not a 1D model-quality score.
- **dateVerified**: 2026-06-25

---

### [GitHub Issue — anthropics/claude-code #38698: Per-agent model provider routing]
- **what**: Community feature request for routing individual subagents to different model providers (e.g., orchestrator on Anthropic/Opus, subagents on local Ollama/llama3.3:70b), with proposed frontmatter syntax
- **kind**: community
- **url**: https://github.com/anthropics/claude-code/issues/38698
- **whyDurable**: Official repo issue thread; the proposed YAML syntax (model: + provider: + base_url:) represents a community-articulated routing primitive that extends beyond tier selection to provider selection. The use cases (cost, latency, offline) generalize across deployments.
- **mustRead**: The proposed agent frontmatter pattern showing `model: llama3.3:70b` + `provider: ollama`. The three use cases: cost-optimization, latency reduction, and offline capability. This extends the routing space beyond Anthropic tiers to cross-provider model selection.
- **emergentPattern**: **cross-provider capability routing** — the community is evolving beyond Haiku/Sonnet/Opus tier selection to routing across model families and deployment modes. The orchestrator/subagent split maps onto cloud/local deployment, not just capability tiers.
- **dateVerified**: 2026-06-25

---

## Pattern-scout note

Three routing patterns emerged that are categorically different from a simple A/B/C (Haiku/Sonnet/Opus) tier comparison:

**1. Per-query routing vs. fixed role assignment.** RouteLLM and FrugalGPT treat routing as a per-inference decision made by a learned classifier or confidence scorer. The community in Claude Code agent teams treats routing as a per-role declaration made at agent definition time. These are architecturally incompatible assumptions: one assumes routing is a dynamic function; the other assumes it is a static configuration. A temple system with fixed seat definitions (Researcher, Challenger, Architect) operates on the fixed-role model, not the per-query model.

**2. Effort level as an independent axis.** The `effort` parameter (documented at platform.claude.com) creates a second routing dimension orthogonal to model tier. The community (issue #31536) is explicitly asking for per-agent effort routing to be decoupled from per-agent model routing, treating these as two separate axes — one for model quality ceiling, one for compute expenditure within that ceiling.

**3. Risk-weighted vs. complexity-weighted assignment.** CrewAI's guide and the VoltAgent corpus reveal a third axis beyond speed/complexity: consequence-sensitivity. Security auditor and architect agents get Opus not because the token sequence is longer, but because errors carry higher organizational cost. This is a risk-weighted assignment signal, not captured by any benchmark that measures correctness on well-defined tasks.

## Blind spot

This lens is likely to miss **intra-turn dynamic routing** — patterns where a single agent switches models or effort levels mid-conversation (e.g., starts a task with Haiku for fast tool calls, then escalates to Opus only when the tool results reveal unexpected complexity). The sources found operate at the task-assignment boundary (which agent gets which model), not at the within-task adaptation boundary (how an agent re-routes itself as new information arrives). That behavior would appear in agentic loop telemetry or in per-turn API logs, not in AGENTS.md files or framework configuration docs.
