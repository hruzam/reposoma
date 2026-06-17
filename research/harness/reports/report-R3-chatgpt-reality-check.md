# Report — R3 · ChatGPT · Reality check (single-voice)
`date: 2026-06-17`
`method: hypothesis X → predictions → internet validation (no triangulation synthesis)`

## Hypothesis X (one sentence)
**X:** For a solo developer running multiple AI-coding CLIs, the most stable way to own and deliver “agent knowledge” is **file-first, git-tracked plain text** (e.g., `AGENTS.md` + modular markdown + optional skill bundles), while **vendor-specific configs and integrations are best treated as replaceable adapters**.

---

## What X predicts (falsifiable signals)
If X is true, we should observe (as of **2026-06-17**) that:

1. **Cross-vendor convergence** exists around plain-text instruction entrypoints (`AGENTS.md`, equivalents, or bridges).
2. Major tools explicitly recommend **progressive disclosure / minimal context** (don’t stuff everything into the prompt).
3. “Always-on tool catalogs” (e.g., large MCP toolsets) are recognized as **token-expensive**, driving **lazy loading / dynamic discovery** approaches.
4. Security guidance and incidents increasingly treat agent “configuration” as **executable attack surface**, reinforcing “adapters are code; gate them.”
5. There is at least one “next standard” pressure toward **markdown + minimal structured metadata**, not a monolithic proprietary platform.

---

## Internet evidence (2025–2026, primary where possible)

### E1 — AGENTS.md exists as an explicit cross-vendor instruction substrate
- `AGENTS.md` is presented as “one file works across many agents,” supports nesting/precedence, and is stewarded under the Linux Foundation AAIF: [`agents.md`](https://agents.md) (retrieved 2026-06-17).
- Cursor docs explicitly list **AGENTS.md** as a rules type and “simple alternative” to `.cursor/rules`: [`Cursor — Rules`](https://cursor.com/docs/rules) (retrieved 2026-06-17).

**Supports**: prediction (1) strongly.

### E2 — Tool incompatibility is handled by bridges/adapters (not by abandoning files)
Claude Code explicitly reads `CLAUDE.md`, **not** `AGENTS.md`, and recommends importing `@AGENTS.md` to share one canon across tools: [`Claude Code — Memory`](https://code.claude.com/docs/en/memory) (retrieved 2026-06-17).

**Supports**: prediction (1) and the “adapters are normal” claim in X.

### E3 — “Passive, file-first context” can outperform skill-triggered retrieval in practice (eval)
Vercel reports agent evals where an `AGENTS.md`-embedded docs index achieved **100% pass rate**, while skills were often not invoked (56% never triggered) unless explicitly instructed; skills + instructions reached 79%: [`Vercel — AGENTS.md outperforms skills`](https://vercel.com/blog/agents-md-outperforms-skills-in-our-agent-evals) (2026-01-27; retrieved 2026-06-17).

**Supports**: prediction (1) and “file-first canon beats clever retrieval in current practice.”
**Caveat**: this is one org’s eval suite (still strong because it’s an explicit measurement).

### E4 — Context/token constraints drive minimal prompts + progressive disclosure
Anthropic describes context as a finite resource with diminishing returns (“context rot”) and recommends minimal high-signal context + just-in-time retrieval via references (paths/links) and tools: [`Effective context engineering for AI agents`](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents) (retrieved 2026-06-17).

**Supports**: prediction (2) and the “modular files + retrieval when needed” part of X.

### E5 — MCP is real and standardized, but tool catalogs can be token-heavy → dynamic toolsets emerge
- MCP is an open JSON-RPC protocol for hosts/clients/servers exposing tools/resources/prompts: [`MCP Spec 2025-11-25`](https://modelcontextprotocol.io/specification/2025-11-25) (retrieved 2026-06-17).
- Benchmarks/analysis highlight “schema injection” overhead and large tool catalogs consuming tens of thousands of tokens: [`OnlyCLI — MCP Token Trap`](https://onlycli.github.io/OnlyCLI/blog/mcp-token-cost-benchmark/) (retrieved 2026-06-17).
- Vendors build “dynamic toolsets” (meta-tools for listing/describing/executing) keeping startup tokens ~constant even for hundreds of tools: [`Speakeasy — Dynamic toolsets`](https://www.speakeasy.com/blog/100x-token-reduction-dynamic-toolsets) (retrieved 2026-06-17).

**Supports**: prediction (3). Also supports X’s stance: MCP is useful, but its **surface must be controlled** and is not a great “canon format.”

### E6 — Security reality: configuration is executable, and tool responses can inject instructions
- Repo-controlled agent configs (hooks, MCP server init, env var overrides) have been a real RCE/exfil vector (patched, but the lesson stands): [`Check Point — CVE-2025-59536 / CVE-2026-21852`](https://research.checkpoint.com/2026/rce-and-api-token-exfiltration-through-claude-code-project-files-cve-2025-59536/) (retrieved 2026-06-17).
- OWASP describes MCP Tool Poisoning (tool responses as an indirect prompt injection channel) and recommends schema validation, least privilege, allowlists: [`OWASP — MCP Tool Poisoning`](https://owasp.org/www-community/attacks/MCP_Tool_Poisoning) (retrieved 2026-06-17).

**Supports**: prediction (4), reinforces X’s “adapters are code; gate them; don’t trust runtime tool output.”

### E7 — “Markdown + minimal structured metadata” is being standardized beyond coding-agent configs
Google introduces **Open Knowledge Format (OKF v0.1)**: a directory of markdown files with YAML frontmatter as a portable, interoperable LLM-wiki representation: [`Google Cloud — Open Knowledge Format`](https://cloud.google.com/blog/products/data-analytics/how-the-open-knowledge-format-can-improve-data-sharing/) (2026-06-12; retrieved 2026-06-17).

**Supports**: prediction (5) — broader ecosystem pressure toward “plain text + tiny structured fields” as a portability layer.

### E8 — Tool migration docs reflect “files survive; runtimes churn”
Google Antigravity migration doc says it continues to parse workspace rules in `GEMINI.md` and `AGENTS.md`, and standardizes workspace skills under `.agents/skills/`: [`Antigravity — Migrating from Gemini CLI`](https://antigravity.google/docs/gcli-migration) (retrieved 2026-06-17).

**Supports**: prediction (1) and X’s “canon as files” claim.
**Note**: the companion blog I attempted to fetch timed out, so I’m not using it as evidence here.

---

## Verdict on Hypothesis X (as of 2026-06-17)
**X holds (confidence: high).**

The internet evidence shows:
- **Convergence** on `AGENTS.md`-style plain-text instruction entrypoints (Cursor explicitly supports it; Claude Code provides a canonical bridge via imports).
- **Measured advantage** of passive file-first context for framework knowledge (Vercel evals).
- **Token constraints** pushing designs toward progressive disclosure rather than “load everything” (Anthropic guidance; dynamic toolsets).
- **Security incidents** make it rational to treat adapters/config as executable code that must be reviewed and gated.
- **Adjacent standardization** (OKF) reinforces “markdown + minimal frontmatter” as a general portability format.

---

## Practical consequence (minimal prescription implied by X)
If you act on X, the concrete “minimum” is:
- **One canonical file-first instruction entrypoint** per repo (`AGENTS.md`) + short links to deeper docs.
- **Tool-specific shims** that import/point to that canon (e.g., `CLAUDE.md` importing `@AGENTS.md`).
- Treat MCP and other integrations as **optional adapters** that must justify their token/security cost.

