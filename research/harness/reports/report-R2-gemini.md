# Report: R2 · Gemini — The Agentic Substrate

`voice: R2 · runtime: Gemini (agy)`
`date: 2026-06-17 · phase: fresh blind design loop`

## 1. The Concrete Design

**Substrate:** A git-versioned, plain-text semantic file system (e.g., `AGENTS.md` and a nested `.agents/` directory) containing raw data structures (Markdown, YAML, JSON). This acts as the singular, durable source of truth for the developer's intent, rules, and architecture. 
**Delivery Mechanism:** A set of stateless, fast "adapter" or "compiler" tools that read this plain-text canonical truth and generate whatever proprietary formats, API payloads, or MCP servers the current runtime (Claude Code, Cursor, Gemini CLI) demands. These runtime configurations are `.gitignore`d build artifacts. The live state of the project is mapped back into this file system via background daemon processes that continuously serialize state into queryable text.

**Where it diverges from the path of least resistance:** 
The path of least resistance is to adopt a vendor's native UI or full MCP ecosystem (which pushes policy into opaque server binaries). This design explicitly rejects vendor-specific dynamic configuration. It treats agentic toolchains as pure compilers where the human only touches the abstract syntax tree (the plain text), forcing all AI tools to conform to the user's data rather than the user conforming to the AI's preferred protocol.

---

## 2. Verdicts on the Hypotheses

### H1 — Substrate
**Verdict: Confirmed, but requires a generated index.**
Durable knowledge must live as plain-text canon in version control; per-tool configuration is absolutely disposable, regenerated glue. 
*Where it fails:* It fails when developers expect the agent to directly traverse massive plains of text for complex retrieval across a large codebase. The plain text must be the *authoring* and *storage* medium, but the agent's actual read-interface should be a locally generated, optimized index (like a local SQLite FTS or embeddings DB built continuously from the text, akin to `engraph`). The text is the source; the index is the fast read-replica.

### H2 — The Live Remainder
**Verdict: Live state must be expressed as a synthetic filesystem.**
Serving runtime state (last error, running logs, DB schema) over a heavy protocol or RPC breaks the principles of a uniform namespace and plain-text universality. The most robust model collapses "static vs live" by mapping live state into a synthetic filesystem (e.g., a `.run/` directory where daemon processes constantly sync state to text files). The agent can then read a live log or an error trace using the exact same `read_file` or `grep_search` tools it uses for static code. This radically simplifies the agent's tool surface and eliminates the need for complex, brittle RPC bridges.

### H3 — The Team
**Verdict: A composable pipeline of filters over named roles.**
Modeling agents as "named roles" (Architect, Coder, Tester) invites anthropomorphic bloat, fuzzy boundaries, and complex state synchronization. A cooperating group is vastly superior when modeled as a pipeline of UNIX-style filters (`source_mapper | architect | coder | verifier`). Each agent does one thing well, taking a rigorously defined text artifact as `stdin` and producing a refined text artifact as `stdout`. This makes the multi-agent system deterministic, debuggable, and allows individual stages to be swapped across different vendor runtimes without breaking the chain.

---

## 3. Open Heresy

**The Heresy: The developer should not be the primary author of the canonical knowledge base.**

This framing fundamentally assumes the human dictates the policy as static text. However, in a fast-moving project, human-authored docs rot immediately. The true canon should be a read-write substrate where the agent continuously deduces and records the conventions, context, and structural map *as it works*. 

The developer's job must shift from "authoring `GEMINI.md`" to "auditing the agent's derived `GEMINI.md`". We hold fixed the idea that the substrate is a passive instruction manual written by the human. It should be an active memory graph maintained by the system, with the human acting only as the supreme editor and conflict-resolver when drift occurs. The system should learn the conventions by observing the codebase's evolution, not by waiting for a human to type them out.