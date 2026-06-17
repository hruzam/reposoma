# Sovereign Markdown vs Native Primitives vs MCP-Served Knowledge: A Decision Report for the Single-Player AI CLI Operator

**Date:** 2026-06-16 · **Audience:** one developer running Claude Code, Cursor, Gemini/Antigravity CLI, and OpenAI Codex across several personal projects, keeping know-how as sovereign plain-text markdown + git · **Lean:** FLAGGED throughout.

> **A note on the lean.** This report measures the whole mountain even-handedly first, then plants a clearly-marked lean. Wherever you see **[LEAN]**, that is my opinion, not a neutral finding. Wherever you see **[FINDING]** or a citation, that is grounded. Versions and dates were re-verified against the live web on 2026-06-16; the ecosystem moves weekly, so treat anything version-specific as decaying.

---

## 1. Executive answer (the flagged lean)

**[LEAN — confidence: medium-high]** For a single-player operator across several personal projects, the right architecture is **Model A (sovereign plain-text markdown + git) as the canon, extended with two minimal additions that are themselves still "just files," plus a deliberately thin slice of Model C for the live/runtime remainder only.** Concretely: keep your durable know-how as **AGENTS.md** (cross-vendor, Linux-Foundation-stewarded, read natively by 15+ tools, 60,000+ repos) plus **SKILL.md** for on-demand procedural knowledge (open standard, 32 tools), bridged into Claude Code with a one-line `@AGENTS.md` import because Claude Code still does not read AGENTS.md natively ([github.com/anthropics/claude-code/issues/34235](https://github.com/anthropics/claude-code/issues/34235), 5,200+ reactions, no roadmap as of June 2026). Add **one local MCP server only for what a file structurally cannot be** — live DB/schema/log introspection and post-training-cutoff doc lookup (the Laravel Boost pattern, [laravel.com/docs/13.x/boost](https://laravel.com/docs/13.x/boost)). **Model B (lean into each brand's native primitives)** is a convenience layer you adopt selectively — hooks for deterministic enforcement, Claude subagent per-model routing for cost — not a knowledge-storage strategy, because its non-portable extensions carry asymmetric stranding risk, empirically proven by Google killing the open-source Gemini CLI for free users **June 18, 2026** ([digitalapplied.com](https://www.digitalapplied.com/blog/gemini-cli-to-antigravity-cli-migration-june-18-2026-guide)). **Model C as a general knowledge-delivery substrate is refuted** for this operator: for static guidelines it costs 4–32× more tokens, adds an RCE-capable subprocess and a server-lifecycle dependency, and its "centralized auditability" is something git already does better for free.

The honest caveat baked into this lean: "nothing to migrate" is true only for the **knowledge layer**. The **integration layer** (per-tool config formats, hooks, MCP wiring, vendor runtime terms) still costs real migration work that no amount of sovereign markdown absorbs.

---

## 2. The three given models, fully mapped (even-handed)

### Model A — Sovereign plain-text markdown + git

**What it is.** All know-how lives as plain markdown in git. Vendor primitives (skills, subagents, hooks, MCP) are treated as disposable "renewable glue." The claim: "nothing to migrate."

**What it uniquely delivers.**
- **The only substrate that already works portably across all four CLIs.** AGENTS.md was donated by OpenAI to the Linux Foundation's Agentic AI Foundation (AAIF) on Dec 9, 2025, alongside MCP and Block's Goose; 60,000+ repository adoptions; read natively by Codex, Cursor, Gemini/Antigravity, Copilot, Aider, Amp, Devin, and 15–30+ others ([linuxfoundation.org press release](https://www.linuxfoundation.org/press/linux-foundation-announces-the-formation-of-the-agentic-ai-foundation); [agents.md](https://agents.md)).
- **Git as a tamper-evident provenance ledger.** `git log --all -p` is a complete, diff-granular audit trail of every instruction the agent ever consumed — no extra infrastructure.
- **Immunity to vendor runtime churn at the knowledge layer.** When Google killed Gemini CLI, `GEMINI.md` content survived unchanged; only the wiring around it broke ([digitalapplied.com](https://www.digitalapplied.com/blog/gemini-cli-to-antigravity-cli-migration-june-18-2026-guide)).
- **Predictable, cacheable token cost.** A 200-line CLAUDE.md is ~3,000–5,000 tokens/session, dropping to ~10% on prompt-cache hits ([platform.claude.com prompt-caching](https://platform.claude.com/docs/en/build-with-claude/prompt-caching)).

**What it costs.**
- **Context-window / instruction-following ceiling.** Practical high-signal CLAUDE.md limit is **80–120 lines**; beyond ~200 lines adherence degrades ("context rot"); Chroma's 2025 benchmark showed frontier models including Claude Opus 4 drop from ~95% to ~60% adherence past a threshold ([dev.to/nishilbhave](https://dev.to/nishilbhave/claudemd-best-practices-the-complete-2026-guide-435j); [deployhq.com](https://www.deployhq.com/blog/ai-coding-config-files-guide)). Empirically, 20–30-line human-written AGENTS.md files **beat** longer auto-generated ones (28.6% median runtime reduction; [morphllm.com](https://www.morphllm.com/agents-md-guide)).
- **No native machine-traversal of associative links.** Plain markdown has no backlinks, transclusion, or semantic retrieval at query time. A densely-linked vault delivers its relational value to a *human* in Obsidian, not to an agent reading files sequentially. Closing this gap (engraph v1.7.2: SQLite + FTS5 + embeddings + 25 MCP tools) re-imports Model-C complexity ([github.com/devwhodevs/engraph](https://github.com/devwhodevs/engraph); [notes.andymatuschak.org](https://notes.andymatuschak.org/Evergreen_notes)).
- **"Config is code."** CLAUDE.md/SKILL.md/`.claude/settings.json`/`.mcp.json` are executable attack surfaces, not inert data (see §4.3). 23.8M+ secrets leaked on GitHub in 2024; AI-assisted commits leak at ~2× baseline ([helpnetsecurity.com](https://www.helpnetsecurity.com/2026/04/15/product-showcase-gitguardian-ggshield-ai-hook/); [blog.gitguardian.com](https://blog.gitguardian.com/the-state-of-secrets-sprawl-2026/)).
- **Claude Code still does not read AGENTS.md natively** — a one-line `@AGENTS.md` import or symlink is required, with a silent-failure mode if you forget ([issue #34235](https://github.com/anthropics/claude-code/issues/34235); [gist](https://gist.github.com/yurukusa/d36197848911f025add142abefcde685)).

**When it wins.** Always, as the *canon*. For declarative conventions, architecture decisions, and workflow rules — the 70–90% of authored know-how — it is the lowest-cost, lowest-lock-in, highest-provenance substrate.

### Model B — Native primitives per brand

**What it is.** Lean into each vendor's native primitives for convenience: hooks, subagents, Cursor `.mdc` rule modes, brand-specific memory.

**What it uniquely delivers (the steelman — stronger than its "no advocate" reputation).**
- **Hooks = harness-level enforcement, not model-level advice.** A `PreToolUse` hook exiting code 2 blocks a tool call the model cannot reason around; fires at 30+ lifecycle events ([code.claude.com/docs/en/hooks](https://code.claude.com/docs/en/hooks)). This layer has **no equivalent in A or C**. (Caveat: "100% deterministic" is overstated — documented bypasses exist; see §5.)
- **Per-model cost routing inside the subagent graph.** Claude Code routes Haiku ($1/M) for search/lint, Sonnet ($3/M) for general, Opus ($25/M) for hard reasoning via subagent frontmatter — changing *what workflows are economically viable*, not just speed ([tembo.io](https://www.tembo.io/blog/claude-code-subagents)). No portable equivalent; Claude-models-only.
- **Lazy-loading progressive disclosure.** Native skills load name+description (~10–30 tokens) at discovery, full body only on activation — structurally cheaper than always-loaded context for task-specific knowledge ([code.claude.com/docs/en/skills](https://code.claude.com/docs/en/skills)).
- **Cursor "Agent Requested" auto-attachment** (description-matched rule injection) has no cross-vendor analog ([cursor.com/docs/rules](https://cursor.com/docs/rules)).

**What it costs.**
- **Non-portable extensions = stranding risk.** `context:fork`, hooks-in-skills, per-subagent `model:` are supported by only ~2 of 39 agent implementations ([spec-weave.com](https://spec-weave.com/docs/guides/agent-skills-extensibility-analysis/)). The Gemini CLI shutdown is the empirical proof of asymmetric downside: a Model-B-heavy Gemini investment lost its primitives with no fork path.
- **Fragmented audit trail.** N vendor-specific primitive dirs, no cross-brand provenance.

**When it wins.** For the *enforcement and orchestration* layer, narrowly: hooks where you need determinism, subagent routing where cost matters. Crucially, **the SKILL.md collapse dissolves most of B's old lock-in liability** — a SKILL.md is simultaneously a Model-A artifact (markdown in git) and a Model-B primitive (natively executed, 32 tools). When the glue is open and portable, "native" ≈ "sovereign."

### Model C — MCP-served knowledge (the Boost pattern)

**What it is.** Serve knowledge live from one MCP server any brand connects to: static guideline files + MCP server + per-tool installer.

**What it uniquely delivers.**
- **Live runtime answers no static file can give:** current DB state, real schema, the error that just crashed the app, browser console logs, post-training-cutoff docs. Laravel Boost's MCP exposes exactly these (9 tools, all runtime-introspective or doc-API-backed) plus a 17,000-entry version-filtered Documentation API ([laravel.com/docs/13.x/boost](https://laravel.com/docs/13.x/boost); [laravel.com/blog](https://laravel.com/blog/laravel-ai-sdk-boost-or-mcp-which-tool-do-you-need)). **This is C's only strictly-unique value.**
- **Semantic search over a large corpus** without bloating the system prompt upfront (with the right meta-tool design).

**What it costs.**
- **Per-session token tax.** Tool definitions re-enter context on every model call. GitHub MCP alone = 42,000–55,000 tokens (93 tools); a typical 5-server setup ≈ 55,000–75,000 tokens *before the first user message* ([anthropic.com/engineering/advanced-tool-use](https://www.anthropic.com/engineering/advanced-tool-use); [getunblocked.com](https://getunblocked.com/blog/github-mcp-token-cost/)). For static guidelines this is 4–32× CLI/file cost ([onlycli.github.io](https://onlycli.github.io/OnlyCLI/blog/mcp-token-cost-benchmark/)); Scalekit measured CLI 17× cheaper than MCP for GitHub tasks (1,365 vs 44,026 tokens, 100% vs 72% reliability).
- **RCE-capable subprocess.** CVE-2025-59536 achieved RCE via `.mcp.json` on session start; OX Security's April 2026 stdio-transport disclosure (Anthropic declined to change the protocol); postmark-mcp tool-poisoning in the wild; 200,000 vulnerable instances reported ([research.checkpoint.com](https://research.checkpoint.com/2026/rce-and-api-token-exfiltration-through-claude-code-project-files-cve-2025-59536/); [owasp.org MCP Tool Poisoning](https://owasp.org/www-community/attacks/MCP_Tool_Poisoning)).
- **Server-lifecycle dependency.** stdio servers die on laptop sleep / terminal close, killing dependent sessions; a 100-server reliability study found median 71% / bottom-decile 38% pass rates ([tianpan.co](https://tianpan.co/blog/2026-04-13-mcp-composability-trap-dependency-sprawl); [digitalapplied.com](https://www.digitalapplied.com/blog/mcp-server-reliability-100-server-stress-test-study)).
- **A planned rewrite.** The MCP **2026-07-28 RC** removes the initialize handshake (SEP-2575) and the session/`Mcp-Session-Id` header (SEP-2567), going stateless; any server built today faces server-side migration with no named vendor commit to a ship date ([blog.modelcontextprotocol.io](https://blog.modelcontextprotocol.io/posts/2026-07-28-release-candidate/)).

**When it wins.** Only for the **dynamic/runtime slice** — live introspection and post-cutoff doc lookup — and ideally as a *local, self-authored* server (no supply-chain vector) exposing few, semantically-discoverable tools. The mitigation that rehabilitates C at scale is **Tool Search / deferred loading** (85%+ overhead reduction; Opus 4.5 tool-selection accuracy 79.5%→88.1%) and the **semantic meta-tool pattern** (2 meta-tools, ~1,300–2,000 tokens constant regardless of catalog size, 99%+ reduction at 400 tools) ([platform.claude.com tool-search](https://platform.claude.com/docs/en/agents-and-tools/tool-use/tool-search-tool); [speakeasy.com](https://www.speakeasy.com/blog/100x-token-reduction-dynamic-toolsets)).

---

## 3. Beyond A/B/C — other recognized patterns (FLAGGED)

These three models are *given*, not exhaustive. Aggregating every `emergentPattern` across the eight dives plus the pattern-scout, the following distinct approaches surfaced. Each is named, differentiated, attributed, and rated on whether it deserves promotion to a real 4th/5th option **for this solo operator**.

| Pattern | How it differs from A/B/C | Who uses it | Status | Promote for solo operator? |
|---|---|---|---|---|
| **AGENTS.md cross-brand standard** | Not operator-sovereign *arbitrary* markdown (A) — an externally-standardized format read by ALL brands natively; not any vendor's primitive (B); no server (C). | 60,000+ repos; OpenAI/Google/Anthropic/Cursor/Factory/JetBrains coalition; AAIF-stewarded | **real-and-adopted** | **Yes — already the backbone of the lean.** It *is* Model A's universal form. ([agents.md](https://agents.md)) |
| **SKILL.md / Agent Skills (on-demand modular knowledge)** | Structured YAML-frontmatter + progressive disclosure; on-demand not always-loaded (unlike AGENTS.md); local files not live-served (unlike C); cross-brand not vendor-owned (unlike B). | 32 tools; 89,753 skills on skills.sh; anthropics/skills 100K stars | **real-and-adopted** | **Yes — the procedural complement to AGENTS.md.** ([agentskills.io](https://agentskills.io/home); [paperclipped.de](https://www.paperclipped.de/en/blog/agent-skills-open-standard-interoperability/)) |
| **Compile-down / installer (Laravel Boost; Ruler; RulesSync)** | Per-brand files are *disposable build artifacts* regenerated from one source, then gitignored — source-of-truth is the generator, not the outputs. | Laravel Boost (6 tools); Ruler (30+ tools); RulesSync (~20); AgentSync (11) | **real-and-adopted** | **Yes — the mechanism that collapses N styles to 1 source.** ([laravel.com/docs/13.x/boost](https://laravel.com/docs/13.x/boost); [github.com/intellectronica/ruler](https://github.com/intellectronica/ruler)) |
| **YAML-frontmatter hybrid (Google OKF v0.1 / SKILL.md header)** | Plain markdown + 1–2 required YAML fields → machine-queryable identity with no DB/SDK. Evolutionary extension of A, not a replacement. | Google Cloud OKF v0.1 (June 12, 2026, 451-line spec); SKILL.md | **real-and-adopted** | **Adopt the SKILL.md form; watch OKF.** ([cloud.google.com OKF](https://cloud.google.com/blog/products/data-analytics/how-the-open-knowledge-format-can-improve-data-sharing/)) |
| **SQLite-backed hybrid-retrieval vault (engraph / omega-obsidian)** | "Model A + local MCP as an index layer" — sovereign files stay primary; SQLite (FTS5 + embeddings + wikilink graph) is a *derived, regenerable* index served by a **local** MCP server. Resolves A's traversal gap without surrendering sovereignty. | engraph v1.7.2 (25 MCP tools); omega-obsidian | **emerging** | **Conditional — only once your vault is large and you feel the retrieval gap.** ([github.com/devwhodevs/engraph](https://github.com/devwhodevs/engraph)) |
| **Compiled LLM Wiki / Karpathy pattern** | Treats the vault as a *compiled output* (raw sources → LLM-synthesized cross-linked pages → lint rules), not a raw accumulation. Solves A's context-overflow by making retrieval a pre-step. | Karpathy reference gist; cited as OKF's inspiration | **emerging** | **Adopt the discipline, not necessarily the tooling.** ([intelligentliving.co](https://www.intelligentliving.co/karpathy-llm-wiki-markdown-knowledge-base/)) |
| **Literate-executable docs (Quarto / Org-mode + agent)** | Substrate is `.qmd`/`.org` with executable cells + tangling + metadata — richer than plain markdown but needs a build pipeline (Pandoc/Emacs). | apiad.net "vibe code is literate"; Quarto | **emerging** | **No — heavier than needed for coding guidance.** Reach for it only for runbooks/reproducible analysis. ([blog.apiad.net](https://blog.apiad.net/p/the-best-way-to-vibe-code-is-literate)) |
| **Provider-agnostic open-source runtime (OpenCode)** | Different *axis* entirely: runtime portability (which model backend runs the agent) not knowledge portability. MIT-licensed, self-hostable, pluggable provider adapters. | OpenCode (120K stars, 5M monthly devs by Mar 2026) | **real-and-adopted** | **Yes — the single strongest hedge against the Gemini-shutdown failure mode.** ([yuv.ai/blog/opencode](https://yuv.ai/blog/opencode)) |
| **MCP-served structural knowledge graph (codegraph / GitNexus)** | Source is an AST graph (Tree-sitter + SQLite/KuzuDB), *auto-derived* by parsing the codebase — not human-authored files (A) and not embedding RAG. Served via MCP. | codegraph (#2 GitHub Trending May 2026); GitNexus (10k+ stars) | **emerging** | **Conditional — for repos above ~5k files where structure matters.** ([marktechpost.com GitNexus](https://www.marktechpost.com/2026/04/24/meet-gitnexus-an-open-source-mcp-native-knowledge-graph-engine-that-gives-claude-code-and-cursor-full-codebase-structural-awareness/)) |
| **Config-shim / meta-config (mcpx-cli)** | Translation glue beneath all three models: one canonical MCP config → vendor-specific outputs. Born because MCP config formats diverged. | mcpx-cli; RFC discussion #2218 | **emerging** | **Yes if you run a multi-CLI MCP server** — it makes the fragmentation invisible. ([platform.uno](https://platform.uno/blog/mcp-configuration-across-ai-agents/)) |
| **Cross-agent persistent memory layer (Mori / Memorix / Engram)** | Captures *learned behavioral state* via lifecycle hooks → queryable provenance-tagged graph; orthogonal to A/B/C (governs what the agent *did*, not what you *wrote*). | Memorix, Engram, agent-memory.dev | **emerging** | **No — premature for a solo operator; revisit if cross-session memory drift bites.** ([towardsdatascience.com](https://towardsdatascience.com/unified-agentic-memory-across-harnesses-using-hooks/)) |
| **Agents-as-data (PydanticAI AgentSpec / Oracle Open Agent Spec)** | Agent identity/model/tools as type-safe YAML/JSON schema, machine-instantiated — not prose. Framework-internal, not yet cross-runtime. | PydanticAI; Oracle agent-spec; LangGraph/AutoGen adapters | **emerging (not indie-ready)** | **No — no single schema reads in Claude Code + Codex + Cursor today.** ([pydantic.dev](https://pydantic.dev/docs/ai/core-concepts/agent-spec/)) |
| **DSPy / prompt-as-code** | Optimizes *how* a prompt is derived (data-driven compilation), not *where* knowledge lives. Orthogonal to A/B/C. | DSPy v3.2.1 (35k stars, Stanford/Databricks) | **real-and-adopted (different problem)** | **No — solves agent optimization at scale, not solo knowledge delivery.** ([github.com/stanfordnlp/dspy](https://github.com/stanfordnlp/dspy)) |
| **Provenance-bound authorization** | Runtime trust model: agent authority scoped to the *provenance* of the data that triggered an action. Orthogonal control plane. | arXiv research; MS Agent Governance Toolkit | **emerging (research)** | **No — adopt the cheap shadow: plan-mode for untrusted files (see §4.3).** |

**Verdict on §3 (not thin at all).** Two emergent patterns deserve **promotion to first-class options for this operator right now: AGENTS.md and SKILL.md** — and they are precisely what the lean is built on, because they *are* Model A in its mature, cross-vendor, layered form. A third, **compile-down/installer tooling (Ruler)**, deserves promotion as the *mechanism* that makes "1 source, N thin adapters" real. A fourth, **OpenCode (provider-agnostic runtime)**, deserves promotion as a *hedge* on a different axis (runtime, not knowledge). The rest are genuinely emerging or orthogonal — adopt only when a specific pain (vault traversal, large-repo structure, cross-session memory) actually bites.

---

## 4. The four cross-cuts

### 4.1 Lock-in & convergence

**Spec-layer convergence is real and durable; runtime-layer convergence is materially incomplete.** [FINDING]

- **Durable (favors A & C):** AGENTS.md (AAIF, 60,000+ repos), SKILL.md (32 tools), MCP (all four CLIs ship native clients; SDKs at 97M monthly downloads). The Spolsky *commoditize-your-complement* dynamic makes this **structurally durable**: every vendor commoditizes the protocol/skills layer to drive demand for its proprietary model API — keeping the spec layer open is in their economic self-interest ([joelonsoftware.com](https://www.joelonsoftware.com/2002/06/12/strategy-letter-v/); [anthropic.com/news](https://www.anthropic.com/news/donating-the-model-context-protocol-and-establishing-of-the-agentic-ai-foundation)).
- **Incomplete (penalizes B & C plumbing):**
  - **MCP config fragmentation** — four file locations, two formats (Claude Code `.claude/mcp.json` JSON, Codex `.codex/config.toml` TOML, Cursor `.cursor/mcp.json` JSON, Antigravity `mcp_config.json` with breaking syntax). RFC #2218/#2219 unresolved. The protocol converges; the plumbing does not. ([github discussion #2218](https://github.com/modelcontextprotocol/modelcontextprotocol/discussions/2218))
  - **Hooks do not converge at all** — Claude PascalCase + `hookSpecificOutput`; Cursor camelCase + exit-code-2; Codex collapses everything into generic `PreToolUse`. No AAIF roadmap to standardize. ([speakeasy.com/resources/ai-agent-hooks](https://www.speakeasy.com/resources/ai-agent-hooks))
  - **SKILL.md runtime semantics diverge** — Vercel's eval: AGENTS.md 100% pass vs SKILL.md 79% (explicit) / 53% (default = no-docs baseline); skill never retrieved in 56% of cases ([vercel.com/blog](https://vercel.com/blog/agents-md-outperforms-skills-in-our-agent-evals)). Gemini CLI's skill implementation was filed as a critical interop bug and **closed as not-planned** ([github.com/google-gemini/gemini-cli/issues/15895](https://github.com/google-gemini/gemini-cli/issues/15895)).
- **The empirical lock-in proof:** Google — a Platinum AAIF founding member — shut the Apache-2.0 Gemini CLI for free/Pro/Ultra users **June 18, 2026** and replaced it with the closed-source, Go-based Antigravity CLI (`agy`), cutting the free daily quota from ~1,000/day to a weekly compute cap. MCP and SKILL.md carried over; the *runtime* (auth, quota, model API) did not. **Open code without open runtime is marketing.** The correct unit of lock-in analysis is not "supports the open spec" but "can I fork and self-host the runtime?" — on which test only OpenCode (MIT) passes; Claude Code, Codex, and Antigravity fail. ([vpsmac.com](https://vpsmac.com/en/blog/google-gemini-cli-policy-change-antigravity-trust-crisis-20260603.html); [digitalapplied.com](https://www.digitalapplied.com/blog/gemini-cli-to-antigravity-cli-migration-june-18-2026-guide))

**[LEAN]** Net migration cost over 1–3 years is trending toward **zero for the knowledge layer** and **roughly unchanged for the integration layer** (config wiring, hooks, vendor terms). Optimize the knowledge layer for portability; *budget* for integration-layer migration rather than pretend it away.

### 4.2 Token economics — name the breakpoints

| Setup | Per-session overhead (before first prompt) | Notes |
|---|---|---|
| Cached CLAUDE.md / AGENTS.md (200 lines) | ~3,000–5,000 tokens, **~10% on cache hit** | Caches naturally if unchanged; flat per-token pricing, no cliffs ([platform.claude.com](https://platform.claude.com/docs/en/build-with-claude/prompt-caching)) |
| SKILL.md library (50 skills) | ~10–50 tokens/skill at discovery (~2,500 total); body on activation only | Progressive disclosure ([code.claude.com/docs/en/skills](https://code.claude.com/docs/en/skills)) |
| 5-server MCP, **no** deferred loading | **55,000–75,000 tokens** | GitHub MCP alone ~42–55k ([getunblocked.com](https://getunblocked.com/blog/github-mcp-token-cost/)) |
| Same, **with Tool Search** | **~8,500–15,000 tokens** (85%+ cut) | +1 round-trip per discovery (~200 tokens) ([platform.claude.com tool-search](https://platform.claude.com/docs/en/agents-and-tools/tool-use/tool-search-tool)) |
| Semantic meta-tool (400 tools) | **~1,300–2,000 tokens, constant** | 99%+ reduction; scales flat ([speakeasy.com](https://www.speakeasy.com/blog/100x-token-reduction-dynamic-toolsets)) |
| Code-execution MCP (doc-heavy) | ~2,000 vs ~150,000 tokens (98.7% cut) | Keeps intermediate results out of context; adds sandbox complexity ([anthropic.com/engineering](https://www.anthropic.com/engineering/code-execution-with-mcp)) |

**The breakpoints [FINDING]:**
- **Below ~10 tools:** Tool Search adds a round-trip for zero gain — load upfront, or just use files.
- **30–50 tools:** the accuracy cliff — tool selection degrades; deferred loading becomes **mandatory** for cost *and* reliability (Opus 4.5: 79.5%→88.1% with Tool Search) ([anthropic.com/engineering/advanced-tool-use](https://www.anthropic.com/engineering/advanced-tool-use)).
- **100+ tools:** only code-execution / semantic-meta-tool patterns keep cost sub-linear.
- **The headline ratio:** a 55k-token MCP setup costs **~165× more per session** than a cached 5k CLAUDE.md; deferred loading collapses that to ~2–3×. For static knowledge, files win decisively.
- **One decay risk for A:** prompt-cache TTL regressed from 1 hour to 5 minutes (March 2026) — inter-turn gaps >5 min re-incur the 1.25× cache-write penalty ([github.com/anthropics/claude-code/issues/46829](https://github.com/anthropics/claude-code/issues/46829)). Verify current TTL before relying on cheap re-reads.

**[LEAN]** Serve static knowledge as files (A/SKILL.md); reserve MCP for the dynamic slice and always pair it with deferred loading.

### 4.3 Governance — the solo "sip"

**The reframe [FINDING]:** CVE-2025-59536 and CVE-2026-21852 proved `.claude/settings.json` hooks and `.mcp.json` are **code executed with user privileges on session start**, not configuration. The governance question shifts from "who reads the markdown" to "who can write these files." Git is the provenance ledger for that code — but only if secrets never enter history and force-push is blocked ([research.checkpoint.com](https://research.checkpoint.com/2026/rce-and-api-token-exfiltration-through-claude-code-project-files-cve-2025-59536/)).

**The minimal high-ROI sip (do these five):**
1. **Deny-first `.claude/settings.json` in every repo** — block `Read(./.env)`, `Read(~/.ssh/**)`, `Read(~/.aws/**)`. Enforced by the harness, not the model; cannot be overridden by prompt injection in CLAUDE.md. Deny > ask > allow; managed settings (`/etc/claude-code/managed-settings.json`) are the only layer your future hasty self can't override ([code.claude.com/docs/en/permissions](https://code.claude.com/docs/en/permissions)). **Caveat:** deny-rule enforcement has been repeatedly buggy (issue #27040 opened Feb 2026; #24846 `.env` not enforced; the 50-subcommand silent-degrade bypass fixed in v2.1.90) — so **back deny rules with a `PreToolUse` hook** as a compensating control ([github #27040](https://github.com/anthropics/claude-code/issues/27040); [adversa.ai](https://adversa.ai/blog/claude-code-security-bypass-deny-rules-disabled/)).
2. **Global `ggshield` pre-commit hook** across all machines/repos — catches secrets before they reach any remote ([blog.gitguardian.com](https://blog.gitguardian.com/local-guardrails-for-secrets-security/)).
3. **Protect `~/.claude/CLAUDE.md`** (`chmod 644`, never run as root) — it's writable by any user-level process, a documented persistent prompt-injection backdoor ([github #21674](https://github.com/anthropics/claude-code/issues/21674)).
4. **Plan-mode for untrusted files** — the cheap shadow of provenance-bound authorization: read cloned/`npm install`ed code in plan mode, switch to default only for known-provenance files. (Mitigates CVE-2026-33068, where a malicious repo's settings activated `bypassPermissions` *before* the trust dialog.)
5. **Author your own skills; never rely on the sandbox as a hard boundary.** Snyk's ToxicSkills found 1,467 malicious payloads on ClawHub/skills.sh (36% with prompt injection; one-week-old GitHub account is the only publish barrier); Ona showed Claude Code disabling its *own* sandbox to finish a task (`allowUnsandboxedCommands` defaults true) ([snyk.io](https://snyk.io/blog/toxicskills-malicious-ai-agent-skills-clawhub/); [ona.com](https://ona.com/stories/how-claude-code-escapes-its-own-denylist-and-sandbox)).

**Model ranking on governance [LEAN]:** **A > B > C.** Git gives A tamper-evident provenance for free; B fragments the audit trail across vendor dirs; C adds an RCE-capable subprocess whose runtime behavior git does not capture and whose audit-trail "fix" is enterprise gateway infrastructure with no solo-ready default ([mintmcp.com](https://www.mintmcp.com/blog/build-audit-trails-ai-coding-agents)).

### 4.4 Maintenance of many styles

**A genuine 1-source → N-thin-adapters approach exists and works — but does not *eliminate* per-tool maintenance, only thins it.** [FINDING]

- **The core mechanism:** one `AGENTS.md` + a one-line `@AGENTS.md` import in CLAUDE.md covers all four CLIs; SKILL.md adds portable procedural knowledge. ([deployhq.com](https://www.deployhq.com/blog/ai-coding-config-files-guide))
- **The tooling exists in the wild:** Ruler (30+ tools, auto-`.gitignore`s outputs), RulesSync (~20), AgentSync (11), Laravel Boost (6, gitignores generated `CLAUDE.md`/`AGENTS.md`/`.mcp.json` and regenerates via `boost:install`). ([github.com/intellectronica/ruler](https://github.com/intellectronica/ruler); [laravel.com/docs/13.x/boost](https://laravel.com/docs/13.x/boost))
- **The residual (thin but real):** advanced per-tool features still need per-tool files — Claude `@imports`/hooks, Cursor `.mdc` glob/path scoping, Copilot allowlists. ([morphllm.com](https://www.morphllm.com/agents-md-guide))
- **The universal enemy is drift, not format:** all three models rot above ~150–200 instructions; git-diff on AGENTS.md is the *best* drift detector, N vendor files the worst. ([packmind.com](https://packmind.com/context-engineering-ai-coding/context-engineering-best-practices/))

**[LEAN]** Model A + a compile-down tool (Ruler) is the dominant maintenance strategy: source always in git, generated files ephemeral, adding a tool = one adapter entry, not a new knowledge base.

---

## 5. Adversarial findings (refutations not buried)

Five skeptics stress-tested the load-bearing claims. Verdicts:

**① "Model A's *nothing-to-migrate* holds." → HELD-WITH-CAVEATS (medium).**
Survives only in scoped form. *Knowledge* migration → near-zero (AGENTS.md + SKILL.md travel with a symlink). *Integration* migration → NOT zero: Claude Code needs the `@import` bridge (silent-fail if forgotten); the 80–200-line adherence ceiling forces active per-project curation; hooks/subagents/`context:fork` are non-portable; the Gemini→Antigravity migration preserved `GEMINI.md` content but broke state dir, MCP syntax, and exit codes. **Survives as:** "knowledge-layer migration collapses to near-zero; automation/integration-layer migration does not." ([issue #34235](https://github.com/anthropics/claude-code/issues/34235))

**② "Model C delivers centralized auditability + a single sovereign delivery point worth its server/RCE/token cost." → REFUTED (high).**
All three sub-claims fail. *Auditability:* git is structurally superior for static files; the MCP subprocess produces no default provenance, and its audit "fix" is enterprise gateway infra ([mintmcp.com](https://www.mintmcp.com/blog/build-audit-trails-ai-coding-agents)). *Single delivery point:* AGENTS.md already is one (in plain text, no server); MCP config fragments across four files anyway. *Worth the cost:* 4–32× token cost, RCE surface, server lifecycle, looming 2026-07-28 rewrite. **Survives only as:** the narrow dynamic-knowledge case (live DB/logs/schema, post-cutoff docs) where no file can substitute. ([onlycli.github.io](https://onlycli.github.io/OnlyCLI/blog/mcp-token-cost-benchmark/))

**③ "AAIF convergence materially lowers future migration cost at the *runtime* layer." → HELD-WITH-CAVEATS (medium).**
Real at spec layer; frays at runtime. SKILL.md semantics diverge (Vercel 53% vs 100%; Gemini bug closed not-planned); MCP config wiring fragmented; hooks have zero cross-vendor convergence; the 2026-07-28 RC is session-breaking with no named vendor commit. **Survives as:** convergence lowers cost for the ~70–80% that is plain markdown; ≈unchanged for hooks and MCP config. ([vercel.com/blog](https://vercel.com/blog/agents-md-outperforms-skills-in-our-agent-evals))

**④ "Model B is only convenience, never architecture." → HELD-WITH-CAVEATS (medium).**
Mostly convenience (SKILL.md subsumes the knowledge layer), but B IS architecturally distinct in three non-portable zones A cannot replicate: (1) harness-level hook enforcement (imperfect — documented path/50-subcommand/ELF bypasses, so "100% deterministic" is overstated — but structurally harder to bypass than instructions); (2) per-model subagent cost routing (changes economic viability); (3) `context:fork`/hooks-in-skills (sandboxed parallel subagent graphs). **Survives as:** default to A; adopt B's non-portable extensions only when a specific differential beats the stranding risk the Gemini shutdown proved. ([ona.com](https://ona.com/stories/how-claude-code-escapes-its-own-denylist-and-sandbox); [tembo.io](https://www.tembo.io/blog/claude-code-subagents))

**⑤ "Disciplined Model A is governable enough to not override its portability." → HELD-WITH-CAVEATS (medium).**
Three of five governance pillars had documented 2025–26 failures (deny-rules repeatedly buggy; sandbox model-defeatable; git-provenance bypassed by CVE-2026-33068's config-before-trust ordering). Every failure has a remediation, but the honest cost is "sovereign markdown + git + **hooks-as-enforcement + ggshield + sandbox hardening + author-only skills**." **Survives as:** adequate *for an operator who runs only their own repos, authors their own skills, backs deny rules with hooks, disables `allowUnsandboxedCommands`, and installs ggshield globally* — a narrower, more demanding claim than "just files." ([github #27040](https://github.com/anthropics/claude-code/issues/27040))

**Bottom line:** the lean's foundation (A as canon) **held with caveats**; the strongest competing claim (C as a general substrate) was **refuted**; B's narrow architectural value **survived** and is folded in as a selective convenience layer.

---

## 6. The recommendation (flagged lean + steelmanned dissent)

**[LEAN — confidence: medium-high]**

> **Sovereign markdown is the canon. Native primitives are a selective convenience layer. MCP is a thin shim for the live slice only.**
>
> 1. **Canon = AGENTS.md (per repo, 20–120 high-signal lines) + a global SKILL.md library** for procedural know-how, all in git. Bridge to Claude Code with `@AGENTS.md`.
> 2. **Compile-down with Ruler** so one source generates the per-tool files (gitignored).
> 3. **Adopt Model-B primitives surgically:** hooks for deterministic enforcement (+secrets/deny backstop), Claude subagent routing for cost. Avoid deep non-portable bets (`context:fork`, brand auto-memory) unless a specific differential justifies the stranding risk.
> 4. **One local, self-authored MCP server, few tools, deferred loading**, for live DB/schema/log introspection and post-cutoff docs only.
> 5. **Bake in the governance sip** (deny-first settings + hook backstop, global ggshield, protected `~/.claude/CLAUDE.md`, plan-mode for untrusted code, author-only skills).
> 6. **Hold OpenCode in reserve** as the runtime-portability hedge against another Gemini-style rug-pull.

**Confidence: medium-high.** High on the *direction* (markdown canon + thin MCP is robustly supported by convergence, token economics, governance, and the Gemini shutdown). Medium on *durability of specifics* (versions, TTLs, deny-rule reliability, and the 2026-07-28 RC will all shift).

**The strongest dissent (steelmanned):** *"You are underselling Model C and the live layer."* As model context windows expand toward millions of tokens and training cutoffs shrink, the always-loaded file approach gets cheaper to over-stuff — but the **volatility of personal-project state never goes away**. Your DB schema, last error, and running logs are *always* post-cutoff and *always* changing. An operator who lives in a debugging loop gets more day-to-day value from one well-built local MCP introspection server than from any amount of curated prose, because the agent can *see the actual system* instead of guessing from stale docs. Boost's own design concedes this: it keeps static files for guidelines precisely so the MCP server can specialize in the dynamic remainder. If your work is mostly *operating* live systems rather than *writing* about them, the lean's "thin slice" of C should be a fat slice — and the token/RCE costs are a rounding error against the value of an agent that isn't hallucinating your schema. **This dissent is correct in its domain;** the lean's defense is that it *scopes* C to exactly this use case rather than refusing it — the disagreement is only about how big "the live slice" is for *your* actual workload, which only you can size.

---

## 7. Next-greenfield design sketch (concrete and buildable)

A sovereign-markdown canon + thin-MCP-for-the-live-slice, wired across Claude Code, Cursor, Antigravity, and Codex, governance baked in, N styles collapsed to 1 source.

### 7.1 Repo layout (the sovereign source of truth)

```
my-project/
├── AGENTS.md                  # 20–120 lines. THE canon. Cross-vendor, read natively by Codex/Cursor/Antigravity.
├── CLAUDE.md                  # one line:  @AGENTS.md   (the only Claude-Code bridge needed)
├── .agents/skills/            # SKILL.md procedural knowledge (portable to 32 tools)
│   └── deploy-runbook/SKILL.md
├── .claude/
│   └── settings.json          # deny-first: blocks Read(./.env), Read(~/.ssh/**), Read(~/.aws/**)
│                              # + PreToolUse hook backstopping the deny rules (compensating control)
├── .ruler/                    # compile-down SOURCE (Ruler); generates per-tool files, gitignored
│   ├── AGENTS.md              # canonical instructions
│   └── ruler.toml             # target tools: claude, cursor, codex, antigravity
├── .mcp.json                  # local stdio server, ONLY for the live slice (gitignored if it holds creds)
└── .gitignore                 # ignores generated per-tool configs + any secret-bearing config
```

`~/.claude/CLAUDE.md` (global): `chmod 644`, never run as root. Global `ggshield` pre-commit hook installed once across all repos.

### 7.2 The compile-down step (1 source → N thin adapters)

```bash
# source of truth lives in .ruler/ ; run on every change
ruler apply            # generates .cursor/rules, CLAUDE.md import, AGENTS.md, codex config, antigravity mcp_config.json
                       # and auto-injects a .gitignore block for the generated outputs
```

Adding a fifth tool = one entry in `ruler.toml`, not a new knowledge base. ([github.com/intellectronica/ruler](https://github.com/intellectronica/ruler))

### 7.3 The thin MCP server (live slice only)

A **local, self-authored, stdio** server exposing **few** tools, *not* a knowledge dump:
- `query_schema`, `last_error`, `tail_logs`, `db_query` (read-only) — runtime introspection a file cannot provide.
- `search_docs` / `fetch_doc` — a **semantic meta-tool pair** over your post-cutoff doc corpus (constant ~1,300–2,000 tokens regardless of corpus size), not one tool per document. ([speakeasy.com](https://www.speakeasy.com/blog/100x-token-reduction-dynamic-toolsets))
- **Enable Tool Search / deferred loading** so schemas don't tax every session.
- Because it's local stdio serving only your own knowledge, the supply-chain vector is absent; the residual surface is a local subprocess. Run a `mcpx-cli`-style config shim if you want one canonical MCP config compiled to the four vendor formats. ([platform.uno](https://platform.uno/blog/mcp-configuration-across-ai-agents/))

### 7.4 Governance baked in (the sip, as code)

`.claude/settings.json` (committed, harness-enforced, model-unoverridable):
```json
{
  "permissions": {
    "deny": ["Read(./.env)", "Read(~/.ssh/**)", "Read(~/.aws/**)", "Bash(rm -rf*)"]
  },
  "hooks": {
    "PreToolUse": [{ "matcher": "Read|Edit|Write", "command": ".claude/hooks/deny-backstop.sh" }]
  }
}
```
- Deny rules backed by a `PreToolUse` hook (because deny enforcement has been buggy: #27040).
- Optional `/etc/claude-code/managed-settings.json` with `disableBypassPermissionsMode` for rules even *you* can't casually override.
- `allowUnsandboxedCommands: false`; plan-mode habit for untrusted/cloned code.

### 7.5 The runtime hedge

Keep **OpenCode** (MIT, self-hostable, MCP + SKILL.md + AGENTS.md aware) installed as a fallback. The entire canon above is identical for it — that's the point. If any vendor pulls a Gemini-style rug, you re-point the *same files* at OpenCode and lose only the brand-specific hook/subagent conveniences, which were always disposable glue. ([yuv.ai/blog/opencode](https://yuv.ai/blog/opencode))

---

## 8. What would change the answer

Three facts whose change would flip or materially reshape the recommendation:

1. **Claude Code ships native AGENTS.md support (issue #34235).** Would remove the only friction in the canon — the `@import` bridge and its silent-failure mode — strengthening the lean and eliminating one residual maintenance step. Conversely, if Anthropic *diverged* CLAUDE.md from the AGENTS.md standard, it would weaken cross-vendor portability and push toward Ruler-style compile-down as mandatory rather than optional. ([github.com/anthropics/claude-code/issues/34235](https://github.com/anthropics/claude-code/issues/34235))

2. **Context windows go multi-million-token *and* training cutoffs shrink to near-real-time.** Two effects: (a) the 80–120-line CLAUDE.md ceiling becomes a non-issue and you can over-stuff the canon cheaply — strengthening A; but (b) it shrinks Model C's post-cutoff-doc value to edge cases. The *live-state* value of C (logs, schema, last error) is permanent and unaffected, so C's thin slice survives even in this world — but its *fat-slice* steelman (§6) weakens. If instead instruction-*following* capacity (not raw window) remains the bottleneck, curation discipline stays mandatory and the lean is unchanged.

3. **A cross-vendor standard for hooks (deterministic enforcement) emerges under AAIF.** Today hooks are the single strongest *non-portable* Model-B advantage and the main reason B is more than convenience. If AAIF standardizes lifecycle-hook semantics across Claude/Cursor/Codex/Antigravity (no roadmap exists today), then B's last durable architectural differential collapses into the portable A-layer, and the recommendation simplifies to "pure sovereign markdown + thin MCP" with no selective-B caveat. ([speakeasy.com/resources/ai-agent-hooks](https://www.speakeasy.com/resources/ai-agent-hooks))

*Secondary watch-items:* the MCP 2026-07-28 RC's actual vendor adoption (raises/lowers C's maintenance cost); whether prompt-cache TTL is restored to 1 hour (affects A's per-turn economics); and whether OpenCode's provider-agnostic runtime sustains adoption (the hedge's viability).

---

*Methodology note: built from eight grounded deep-dives and five adversarial verdicts, with the most time-sensitive and load-bearing claims (Claude Code AGENTS.md status, Gemini→Antigravity shutdown, MCP 2026-07-28 RC, Vercel AGENTS.md-vs-skills eval, deny-rule enforcement, SKILL.md 32-tool adoption) re-verified against the live web on 2026-06-16. Versioned facts decay; re-verify before betting on any specific number.*
