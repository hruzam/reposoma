# Agentic Sovereignty & Delivery — Source Map (First Loop)
_Compiled: 2026-06-16 · phase: source discovery only (NOT the content study) · method: 6-lens blind fan-out, source-mapping before web-searching for answers_

## Study question (for the deep pass, not answered here)
How should a developer **own and deliver** AI-agent knowledge/configuration across multiple AI tools (Claude Code, Cursor, Gemini/Antigravity, Codex…)? Three models under test:
- **A — Sovereign markdown:** all know-how as plain-text markdown + git; vendor primitives (skills/subagents/hooks/MCP) treated as disposable "renewable glue." "Nothing to migrate." (the friend's thesis)
- **B — Native primitives:** lean into each brand's native primitives for convenience.
- **C — MCP-served:** serve knowledge live through one MCP server any brand connects to (the "Laravel Boost" pattern: static guideline files + MCP server + per-tool installer).
- Cross-cutting: vendor lock-in · convergence onto shared primitive shapes + MCP as neutral protocol · token cost · maintenance burden of many parallel styles.

---

## Weight 1 — AI-agent tooling practitioners & primary docs
- **MCP official spec** (rev 2025-11-25) — https://modelcontextprotocol.io/specification/2025-11-25 · repo https://github.com/modelcontextprotocol — *the* substrate of model C; now under the Agentic AI Foundation.
- **Anthropic Engineering** — https://www.anthropic.com/engineering — must-read: "Code execution with MCP" (token-cost case for C) + "Effective context engineering for AI agents" (minimal-high-signal frame → A).
- **Simon Willison** — https://simonwillison.net/ — must-read: "Claude Skills are awesome, maybe a bigger deal than MCP" (B vs C) + "Code execution with MCP" (he's largely abandoned MCP for CLI tools → A).
- **AGENTS.md** — https://agents.md · repo https://github.com/openai/agents.md — open plain-markdown agent-instruction convention; 20k+ projects; under AAIF.
- **Primary vendor docs** — Claude Code https://code.claude.com/docs/ · Cursor https://cursor.com/docs/rules (Cursor CLI reads AGENTS.md + CLAUDE.md alongside .cursor/rules — convergence evidence).
- **Laravel Boost** — https://laravel.com/docs/13.x/boost · repo https://github.com/laravel/boost — the model-C reference implementation.
- **Latent Space** (swyx) — https://www.latent.space/ — practitioner interviews; maintenance-burden angle.
- **Field notes:** Mitchell Hashimoto https://mitchellh.com/writing · Harper Reed https://harper.blog/ · Geoffrey Huntley https://ghuntley.com/
- _Lens verdict:_ lives closest to **A**, strong sympathy for **C** as neutral interop; **B has no durable advocate** (treated as convenience, not architecture). _Blind spot:_ senior-individual-dev bias; under-weights enterprise governance/RBAC/audit.

## Weight 2 — UNIX / systems-design philosophy
- **Torvalds — "good programmers worry about data structures"** (Git list, 2006) — https://lwn.net/Articles/193245/ — the primary thesis of A: your markdown corpus is the data structure; vendor configs are mere "code."
- **Torvalds — Git as content-addressable store** (Google Tech Talk 2007) — https://gist.github.com/dukeofgaming/2150263 — content-addressing = identical content is one object regardless of tool = the technical embodiment of "nothing to migrate."
- **ESR — The Art of UNIX Programming**, ch.1 + ch.5 "Textuality" — http://www.catb.org/esr/writings/taoup/html/index.html — Rule of Separation (policy vs mechanism = sovereign content vs swappable primitive) + "text outlives the tools that made it."
- **Doug McIlroy — "text streams = a universal interface"** — https://en.wikipedia.org/wiki/Unix_philosophy — origin text for plain-text as the neutral interchange layer.
- **Richard Gabriel — "Worse Is Better"** — https://www.jwz.org/doc/worse-is-better.html — why the portable-minimal artifact wins propagation over rich integrated primitives (and where minimalism's limits are).
- **Rob Pike — "Notes on Programming in C," Rule 5 "Data dominates"** — https://www.lysator.liu.se/c/pikestyle.html — independent restatement of data-over-code (it's a tradition, not one quip).
- **Pike et al. — "The Use of Name Spaces in Plan 9"** — http://doc.cat-v.org/plan_9/4th_edition/papers/names — uniform interface over heterogeneous backends = intellectual ancestor of MCP-as-universal-interface (C).
- **ESR — The Cathedral and the Bazaar** — http://www.catb.org/~esr/writings/cathedral-bazaar/ — ownership/forkability over vendor-controlled artifacts.
- _Lens verdict:_ structurally pre-disposed to **A**. _Blind spot:_ optimizes for file-at-rest/batch; under-serves live/stateful/interactive needs (the C gap) and waves away token-bloat + N-maintenance as "just glue."

## Weight 3 — Atomic notes / Zettelkasten / PKM / evergreen notes
- **Andy Matuschak — Evergreen notes** — https://notes.andymatuschak.org/Evergreen_notes — "notes should be atomic" + "densely linked" + "prefer associative ontologies to hierarchical" = your "associative bonds," "one fact = one .md."
- **Luhmann — "Communicating with Slip Boxes" (1981)** — https://luhmann.surge.sh/communicating-with-slip-boxes.html — root document; the "self-extracting developing" quality = Luhmann's "combinatorial possibilities never planned."
- **Sönke Ahrens — How to Take Smart Notes** — https://zettelkasten.de/posts/concepts-sohnke-ahrens-explained/ — atomicity + "understandable when you've forgotten the context."
- **zettelkasten.de** (Tietze & Fast) — https://zettelkasten.de/introduction/ — decade-plus serious reference + Luhmann translations.
- **Maggie Appleton — Digital Garden history/ethos** — https://maggieappleton.com/garden-history — Independent Ownership, Continuous Growth patterns.
- **Org-roam** — https://www.orgroam.com/manual.html — file-per-note + disposable derived backlinks DB = the closest existing system to A ("sovereign files + renewable glue").
- **Knuth — Literate Programming (1984)** *(adjacency)* — https://en.wikipedia.org/wiki/Literate_programming — config as authored prose, not opaque settings.
- _Lens verdict:_ strongly underwrites the **epistemics** of A. _Blind spot:_ it's all about *human* cognition over decades — says nothing about machine consumption, token cost, or whether an agent traverses associative links the way a human gardener does (atomicity without live link-following may lose the point).

## Weight 4 — Framework-tooling craft (Laravel as case study)
- **Laravel Boost — official docs** — https://laravel.com/docs/13.x/boost — confirmed architecture: static guideline files + MCP server (`boost:mcp`, **9 tools**: App Info, Browser Logs, DB Connections, DB Query, DB Schema, Get Absolute URL, Last Error, Read Log Entries, Search Docs[17k-entry hosted API]) + per-tool installer (`boost:install` auto-detects Cursor/Claude Code/Codex/Gemini CLI/Copilot/Junie). **Generated configs are meant to be `.gitignore`'d because regenerated = literally "renewable glue" by a generator.**
- **"Laravel AI SDK, Boost, or MCP: Which Tool Do You Need?"** — https://laravel.com/blog/laravel-ai-sdk-boost-or-mcp-which-tool-do-you-need — a vendor's own A/B/C decision framing + Otwell on context-bloat/token cost ("50–70 tools" warning) + the "we ship every Tuesday, LLMs don't know" freshness gap.
- **Taylor Otwell / team** — Laracon US 2025 keynote https://www.youtube.com/watch?v=CJv5Y7im3Ws — origin + rationale ("assist you, don't do your work").
- **Laravel News explainer** — https://laravel-news.com/laravel-boost-your-ai-coding-starter-kit
- **Laracasts — "Leveraging AI for Laravel Development"** — https://laracasts.com/series/leveraging-ai-for-laravel-development — Boost in real use (+ worktrees/parallel agents).
- **Laravel Daily — Povilas Korop, "7-Step AI Workflow"** — https://laraveldaily.com/post/my-7-step-ai-workflow-for-new-laravel-projects-boost-guidelines-prompts — how a practitioner structures regenerable guideline files.
- **`laravel/boost` repo — `src/Install/Agents/*`** — https://github.com/laravel/boost — one class per AI tool = the disposable-glue generator, made concrete.
- _Generalizable:_ the pattern (static version-aware guidelines as durable asset + per-tool native config as gitignored regenerated glue + project-aware MCP server for live introspection + `SupportsGuidelines/SupportsMcp/SupportsSkills` contract). _Laravel-specific/non-portable:_ the **content moat** (17k-entry hosted docs API, version-pinned guidelines, artisan/composer rails) — needs strong conventions + single release cadence + central package ecosystem. _Blind spot:_ a "benevolent dictator with deep pockets" success; here the glue AND the knowledge base are vendor-controlled, not developer-owned — under-prices A's sovereignty concern.

## Weight 5 — Standards convergence / protocol-vs-platform / lock-in economics
- **Shapiro & Varian — Information Rules (1998)** — https://yunus.hacettepe.edu.tr/~tonta/yayinlar/hal-varian-information-rules-chapter-1.pdf — canonical lock-in/switching-cost/standards-war economics; frames B as a lock-in play.
- **Joel Spolsky — "Strategy Letter V / Commoditize Your Complement" (2002)** — https://www.joelonsoftware.com/2002/06/12/strategy-letter-v/ · synthesis https://gwern.net/complement — *why* for-profit brands fund open standards (→ explains the MCP/AGENTS.md donation).
- **Davie/Peterson — "How the Hourglass Won" (2024)** — https://systemsapproach.org/2024/08/19/how-the-hourglass-won/ + EvoArch https://arxiv.org/pdf/1607.07183 — narrow-waist thesis; MCP/AGENTS.md as candidate "waist." Caution: EvoArch shows the winning waist need not be the best.
- **David Clark — spanning layer / RFC 1958** — index via https://en.wikipedia.org/wiki/Hourglass_model — theory backbone for "bet on the thin neutral protocol over thick brand platforms." (Path-dependence canon: Paul David's QWERTY 1985, Brian Arthur 1989.)
- **PRIMARY — Anthropic donates MCP / forms AAIF (Dec 9 2025)** — https://www.anthropic.com/news/donating-the-model-context-protocol-and-establishing-of-the-agentic-ai-foundation
- **PRIMARY — Linux Foundation AAIF formation + OpenAI co-founds (Dec 9 2025)** — https://www.linuxfoundation.org/press/linux-foundation-announces-the-formation-of-the-agentic-ai-foundation · https://openai.com/index/agentic-ai-foundation/ — MCP + AGENTS.md + goose donated together; two rival vendors confirming. **Single best source for the convergence claim.**
- **PRIMARY — OpenAI AGENTS.md spec/launch (Aug 2025)** — https://agents.md — 60k+ projects; Codex/Cursor/Gemini CLI/Copilot/Jules/VS Code/Devin/Factory.
- **PRIMARY — Cursor Skills/Rules docs** — https://cursor.com/docs/context/skills — "Agent Skills is an open standard… works across any agent that supports the standard"; loads `.claude/skills/` + `.codex/skills/`. Cleanest proof of Cursor converging on Claude-Code-style primitives.
- **PRIMARY+reporting — Antigravity CLI / Gemini-CLI migration** — https://antigravity.google/docs/gcli-migration — AGENTS.md + MCP + skills/subagents confirmed; migration deadline reported **June 18 2026**. ⚠ "modeled on Cursor-CLI" = analyst inference, NOT first-party.
- _Verdict on convergence:_ **partially-to-strongly supported and trending stronger, at the protocol/spec layer.** CONFIRMED: MCP + AGENTS.md jointly governed under one neutral body co-founded by rivals; all major tools implement the shared shapes. RUMOR: finer "brand X clones brand Y's CLI" stories; spec convergence ≠ runtime/behavioral convergence (a thin shared waist can sit under deeply divergent platforms).

## Weight 6 — Scientific-computing / literate & reproducible knowledge *(interpretive narrowing — see flag)*
- **Knuth — Literate Programming (1984)** — https://www-cs-faculty.stanford.edu/~knuth/lp.html — "the plain-text source is the sovereign artifact; build output is disposable." The charter of A.
- **Claerbout / Buckheit & Donoho — Reproducible Research (1992/1995)** — https://sepwww.stanford.edu/sep/jon/reproducible.html — "the article is merely advertising; the actual scholarship is the complete software + instructions."
- **Iverson — Notation as a Tool of Thought (1979 Turing lecture)** — https://www.eecg.utoronto.ca/~jzhu/csc326/readings/iverson.pdf — "the language IS the representation" (APL/J/K → NumPy/JAX/Julia).
- **Pérez & Granger — Literate Computing / Jupyter (2015)** — https://blog.jupyter.org/project-jupyter-computational-narratives-as-the-engine-of-collaborative-data-science-2b5fb94c3c58
- **Schulte & Davison — Org-mode / Org-babel** — https://orgmode.org/worg/org-contrib/babel/ — *literally* model A: one plain-text file, primitives generated, git-tracked. Peer-reviewed (JSS 2012).
- **Allaire — Quarto / R Markdown / Pandoc** — https://quarto.org/about.html — single plain-text source → every rendered format disposable.
- **Harris et al. — Array Programming with NumPy (Nature 2020)** — https://www.nature.com/articles/s41586-020-2649-2 — array protocol / interoperability as anti-lock-in.
- **Willison — owning your embeddings / local RAG** — https://simonwillison.net/tags/embeddings/ — corpus/embedding sovereignty; "if the only way to get embeddings is a vendor API and they shut it down, the investment collapses." (+ Max Woolf: embeddings portably via Parquet + Polars.)
- _Direct A-reinforcers:_ Org-mode (#5) + Quarto (#6) are the literal pattern; Knuth + Claerbout/Donoho the charter; Willison extends sovereignty to RAG/embeddings (model C's corner). _Weakest canonical evidence:_ the RAG/corpus-ownership wing (young field — Willison is a practitioner voice, not a peer-reviewed anchor); needs more discovery if the deep pass leans on C.
- ⚠ **FLAG (agent's recommendation):** spectral/tensor/swarm/optics reads as *lens-justifying metaphor* (representation should be sovereign + durable), BUT carries a whiff of a real numerical-methods/engine content domain that has nothing to do with knowledge-config ownership. **If those terms name an actual engine you're building, split it into a separate study.** A tighter equally-valid lens = "reproducible-research provenance" (#1,2,5,6 only).

---

## Weight 7 — Governance / security / standardization *(added 2026-06-16 — the counterweight to A; single-player-scoped sip)*
- **Claude Code — Permissions + Managed settings (PRIMARY)** — https://code.claude.com/docs/en/permissions — "permission rules are enforced by Claude Code, **NOT the model**" (CLAUDE.md shapes intent, never grants access — kills the naive "just put governance in markdown" story); managed-only keys (`allowManagedMcpServersOnly`, `allowManagedPermissionRulesOnly`, `disableBypassPermissionsMode`); sandboxing as OS-level backstop.
- **MCP Security Best Practices (PRIMARY)** — https://modelcontextprotocol.io/docs/tutorials/security/security_best_practices — "Local MCP Server Compromise" (a local server = arbitrary-code-exec binary with client privileges; can exfiltrate `~/.ssh/id_rsa`) = direct cost of model C + any server you didn't write; "Scope Minimization" = the RBAC/least-privilege argument.
- **Check Point Research — RCE & API-key exfil via Claude Code project files (Feb 2026)** — https://research.checkpoint.com/2026/rce-and-api-token-exfiltration-through-claude-code-project-files-cve-2025-59536/ — CVE-2025-59536 (MCP consent bypass) + CVE-2026-21852 (key exfil via malicious `ANTHROPIC_BASE_URL`); "config files once passive data now control active execution paths" — hooks/`.mcp.json` execute *before the trust dialog renders*. Treat a cloned repo's config as executable code.
- **OWASP GenAI — Top 10 for LLM Apps (2025) + Agentic Apps (Dec 2025)** — https://genai.owasp.org/llm-top-10/ — LLM01 Prompt Injection, LLM03 Supply Chain; Agentic adds Tool Misuse, Identity & Privilege Abuse. Vocabulary for vetting any shared skill/MCP/plugin.
- **GitGuardian — State of Secrets Sprawl 2026 (Mar 2026)** — https://blog.gitguardian.com/the-state-of-secrets-sprawl-2026/ — **24,008 secrets found in MCP config files** on public GitHub; AI-assisted commits leak ~2× baseline. Quantified case for runtime secret injection, never secrets-in-config.
- **NIST AI RMF + GenAI Profile (AI 600-1)** — https://nvlpubs.nist.gov/nistpubs/ai/NIST.AI.600-1.pdf — GOVERN/MAP/MEASURE/MANAGE; "Value Chain & Component Integration" = the formal name for third-party skill/MCP/plugin supply-chain risk. Structure to cherry-pick, not adopt wholesale.
- **Cloud Security Alliance — Agentic Security Initiative** — https://labs.cloudsecurityalliance.org/agentic/agentic-nist-ai-rmf-profile-v1/ — "delegation-chain accountability" / runtime governance = the audit/provenance crux (who authorized each action).
- **CoSAI (OASIS) — MCP Security** — https://github.com/cosai-oasis/ws4-secure-design-agentic-systems/blob/main/model-context-protocol-security.md — multi-vendor standards-body MCP threat model; trust boundaries + tool-poisoning ("assume tool outputs untrusted").
- **General Analysis — Claude Code Settings/Permissions/Bash security (practitioner)** — https://generalanalysis.com/guides/claude-code-settings-permissions-bash-tool-security — concrete safe-default deny/allow `settings.json`.
- _Verdict:_ governance **complicates naive A** — plain-text configs (`settings.json` hooks, `.mcp.json`, `.env`) are an active execution + secret-leak surface, and "many parallel files" multiplies audit surface + secret-hiding spots — BUT A's **git history is a unique provenance/audit ledger** (signed, diffable, revertable) that B and C lack, *provided secrets are never committed*. B penalized on policy portability + vendor-locked audit trails. C *favors* centralized auditability + single-point RBAC but *concentrates* risk (one RCE-capable binary + token sink). Net: auditability favors "few centrally-governed sources + deny-first enforcement-in-harness + git provenance," not "many files," not "one unsandboxed live server."
- _Solo operator's "sip":_ (1) never commit secrets — runtime inject + gitleaks/detect-secrets pre-commit; (2) deny-first posture — deny `Read(.env)`/`Read(~/.ssh/**)`, deny network Bash, pin/allowlist MCP servers (enforced in harness, not CLAUDE.md); (3) vet-before-trust any skill/MCP/hook/plugin you didn't write; (4) sandbox the Bash tool; (5) git history = your audit trail.

---

## Cross-lens synthesis (early, not the verdict)
- **4 of 6 lenses (UNIX, Zettelkasten, scientific-computing, and the practitioner mainstream) structurally endorse model A.** Model C is consistently the **neutral interop layer**, not a rival to A. **Model B (commit hard to one brand's native primitives) has no durable advocate** in any lens — universally treated as convenience, not architecture.
- **The convergence claim is CONFIRMED at the spec layer** (AAIF / MCP + AGENTS.md, Dec 2025) → the cost of a future migration is dropping, and sovereign cross-vendor markdown (AGENTS.md) is now the governed consensus substrate.
- **The shared blind spot of the first 6 (governance) is now Weight 7 — the one real counterweight to A:** plain-text agent config is an *active execution + secret-leak surface* (real CVEs; 24k secrets in MCP configs on GitHub; AI-commits leak ~2×), so naive A is NOT "safe because it's just text." BUT git history is A's unique provenance/audit ledger. Net: A stays viable *if disciplined* (git-provenance + deny-first enforcement-in-harness + no-secrets-in-config + sandbox + vet-shared-primitives).
- **A↔C are not opponents:** A owns the static/at-rest knowledge; C owns the live/interactive/runtime slice (Boost proves they compose). The real fork is *static vs live*, not *markdown vs MCP*.

## Decisions (resolved 2026-06-16)
1. **Math lens:** REAL engine → split off to `multi-agent-composition-and-swarms.seed.2026-06-16.md`. Not in this study.
2. **Governance:** added as Weight 7, single-player-scoped with a real "sip" (not enterprise).
3. **Deep-pass target:** a~b — study ALL of A/B/C (full map, "measure the mountain") AND land a clearly-flagged lean; plus a concrete next-greenfield design sketch. Scope: solo operator.

## Deep (content) pass — plan (pending user go)
- **Phase 1 — deep dive** (parallel): one agent per model (A/B/C) + per cross-cut (lock-in/convergence · token cost · governance · many-styles maintenance), each grounded in the mapped sources, producing claims + citations + confidence.
- **Phase 2 — adversarial verify:** skeptics try to refute each model's load-bearing claim (A "nothing to migrate"; C "centralized auditability"; the convergence claim's spec-vs-runtime gap).
- **Phase 3 — synthesize:** one cited report — full A/B/C map + flagged lean + "what this means for your next greenfield" design sketch.
