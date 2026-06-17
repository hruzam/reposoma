# Research Report: R2 · Gemini (Grounded Study X vs Y)

`voice: R2 · runtime: Gemini (agy)`
`date: 2026-06-17 · phase: Grounded X vs Y Triangulation`
`doctrine: verify-before-build · honesty-over-show`

This report executes a grounded comparison. It maps my initial zero-shot, memory-based hypothesis ('X') against empirical reality ('Y') queried from mid-2026 ecosystem data, specifically cross-referencing the `source-catalog.jsonl` library and live search data.

---

## 1. The X vs Y Map (Hypothesis vs Reality)

### H1 — Substrate & Configuration Lock-in
**The Question:** Does durable knowledge live as plain-text canon in version control, with per-tool config as disposable glue?
*   **My Hypothesis (X):** Yes. A git-versioned `AGENTS.md` file is the universal substrate. Tool-specific configurations are transient artifacts generated from this master file.
*   **Empirical Reality (Y):** Reality is messier. We see a "soft lock-in" at the *logic/trigger* layer. Cursor uses `.mdc` files requiring YAML frontmatter and glob matching, while Claude Code relies on `CLAUDE.md` and hierarchical `@import` chains (cite: *cc-issue-34235-agentsmd*). While the "meat" is markdown, the "brain" is runtime-specific. The `AGENTS.md` open standard exists (cite: *agents-md*), but the ecosystem currently requires "porters" (like `c2c`) or compiled abstractions (cite: *ruler*) to truly treat runtime config as disposable glue.
*   **Verdict:** **Holds with caveats.** Plain text is the universal *authoring* interface, but true portability requires a compiler layer. You cannot just drop `AGENTS.md` into every tool and expect the triggers to fire correctly without adapters.

### H2 — The Live Remainder (State via RPC vs Filesystem)
**The Question:** Must live runtime state be served over RPC, or can it be expressed as a synthetic filesystem?
*   **My Hypothesis (X):** Synthetic filesystems are superior. Mapped live state (logs, DB schemas) into `.run/` directories allows the agent to read state using standard text-reading tools, collapsing the tool surface.
*   **Empirical Reality (Y):** The industry heavily adopted RPC via the Model Context Protocol (MCP) (cite: *mcp-spec*). MCP handles state dynamically via JSON-RPC. However, file-based persistence (like Anthropic's Agent Skills or local `state.json` files) is still heavily relied upon for crash recovery and human auditability. Hybrid systems use file-based state for the "plan" and MCP/RPC for the "action."
*   **Verdict:** **Divergence.** The path of least resistance (Y) is entirely RPC/MCP. My synthetic filesystem design (X) is a minority pattern but aligns better with First Principle 4 (*A uniform namespace can front heterogeneous backends*). If an agent can read files natively, translating MCP state into a synthetic local filesystem reduces token-cost bloat and removes the need for deep RPC tool-calling architectures.

### H3 — The Team Topology (Pipelines vs Roles)
**The Question:** Is a cooperating group best modeled as named roles or a composable pipeline?
*   **My Hypothesis (X):** Composable UNIX-style pipelines (`mapper | architect | coder`).
*   **Empirical Reality (Y):** The ecosystem bifurcated. "Roles" (CrewAI, AutoGen) use persona-driven emergent collaboration, which is highly autonomous but Token-heavy and unpredictable. "Pipelines" (LangChain) offer deterministic workflows. Current mid-2026 reality is converging on **Stateful Graphs** (e.g., LangGraph), which use deterministic pipelines for the "happy path" and cyclic Role-based loops for "self-correction."
*   **Verdict:** **Refuted as a binary.** The strictly linear UNIX pipeline is too brittle for AI error rates; the pure "Role" system is too expensive and chaotic. The optimal design is a graph: pipeline-by-default, loop-on-failure.

---

## 2. The Final Concrete Design

Based on reconciling X and Y against the first principles:

**Substrate:** A git-versioned, plain-text semantic file system serving as the sovereign source. Because runtime logic (Cursor globs vs Claude imports) currently creates soft lock-in, the system must utilize a **compile-down pattern** (like the *ruler* repo). The developer authors neutral `AGENTS.md` files; a local pre-commit hook or daemon compiles these into the `.cursor/rules` and `.claude/` structures dynamically.
**Delivery Mechanism:** A hybrid live-state model. Static rules are read natively as files. For dynamic state (databases, network requests), a local MCP server acts as the bridge, but rather than the agent invoking complex RPC tools, the MCP server writes materialized views of its state to a local SQLite or text cache (akin to *engraph*), allowing the agent to utilize standard, cheap file-reading primitives.

---

## 3. Open Heresy

**The Heresy: The developer should not be the primary author of the canonical knowledge base.**

This framing holds fixed the assumption that humans must manually author the `AGENTS.md` policy. The reality of "soft lock-in" and context-rot shows human-maintained files degrade quickly. 

The true canon should be a **read-write substrate** where the agent continuously deduces and records the conventions, context, and structural map *as it works*. The developer's job must shift from "authoring `GEMINI.md`" to "auditing the agent's derived `GEMINI.md`". The system should learn the conventions by observing the codebase's evolution and dynamically rewriting its own rule triggers to optimize for whatever local IDE the developer happens to be using today.