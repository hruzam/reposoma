# Report — R1 · the research center

`voice: R1 · one blind voice in a multi-voice triangulation · date: 2026-06-17 · phase: fresh blind design loop`
`method: form design X → ground X against the live internet → test X against reality → write. Independence is the signal; no prior conclusions carried in.`

---

## 0. One-paragraph answer

For a single developer running several AI-coding CLIs across several personal projects, the durable thing you own is **prose, in version control, in the open cross-vendor format** — and the per-tool wiring is **compiled, gitignored, and thrown away on every change.** Knowledge is data; config is mechanism; you keep the data and regenerate the mechanism. The "live remainder" (schema, last error, running logs) does **not** need a bespoke protocol to be useful to an agent — it needs to be *projected as paths the agent already knows how to read*, because that is the cheapest, most composable, most tool-agnostic interface that exists. And a team of agents is **not** a choice between "named roles" and "a pipeline of filters" — it is roles **wired by** a pipeline: identity is data, composition is mechanism, and the same separation that governs H1 governs H3. The path of least resistance — let each CLI own its own config, reach for an MCP server every time you want live data, and hand-name a roster of agents — is wrong on all three counts, and I'll say exactly where.

---

## 1. The concrete design

### 1.1 Substrate — a canon of atomic plain-text notes in git, in the open format

- **One repository of prose**, plain Markdown, version-controlled. Each file is **one idea / one fact / one convention** (atomic, in the Zettelkasten/evergreen sense), small, and densely cross-linked by relative path. Not one fat instruction file — a *graph* of small ones.
- **The canonical instruction file is `AGENTS.md`**, the open, vendor-neutral standard now governed by the Linux Foundation's Agentic AI Foundation, adopted by 60,000+ repositories and read by Codex, Cursor, Gemini/Antigravity CLI, Copilot, Devin, Amp and more (*Linux Foundation AAIF press release; codersera "AGENTS.md Complete Guide 2026"; OpenAI AAIF post — Dec 2025 / 2026, high confidence*). This is the substrate's *front door* because it is the one artifact every current and near-future CLI agrees to read.
- **Size discipline is load-bearing, not cosmetic.** The root instruction surface stays ~200 lines / under a few hundred tokens, because adherence degrades and "context rot" sets in past a threshold — a 5,000-token instruction file costs 5,000 tokens *every turn, before the model has read a line of your code* (*scrum.org "Token Economics 2026"; multiple CLAUDE.md best-practice guides — 2026, high confidence*). Depth lives in the linked atomic notes and is pulled in **on demand** (progressive disclosure), never front-loaded.
- **What is canon vs. what is glue is decided by a single test: is it prose a human would still want in ten years, or is it an executable instruction to a specific tool?** Prose conventions, decisions, domain facts, the *why* → canon. Hook scripts, `.mcp.json`, `settings.json`, permission lists, per-tool memory filenames → glue.

### 1.2 Delivery mechanism — compile-down from one source, gitignore the output

- **The canon is the single source of truth; per-tool files are generated and disposable.** Concretely this is the **Ruler** pattern (or equivalent compile-down): one `.ruler/`-style source directory → emit `CLAUDE.md`, `.cursor/rules`, `GEMINI.md`/Antigravity's `AGENTS.md` layout, Copilot instructions, etc., and have the generator **auto-manage `.gitignore`** so generated config never enters version control (*github.com/intellectronica/ruler; Addo Zhang "Ruler" writeup — 2026, high confidence*). This is not a thought experiment; it ships and it manages MCP config and .gitignore for you today.
- **Bridge the one holdout.** Claude Code still reads `CLAUDE.md` natively and does **not** read `AGENTS.md` (issue #6235, 5,200+ reactions, no Anthropic timeline as of mid-2026). The fix is mechanical: emit `CLAUDE.md` from the same source, or `@AGENTS.md` import / symlink — a *generated bridge*, not a fork of your knowledge (*gist yurukusa "@AGENTS.md import/symlink"; bestagent.dev "CLAUDE.md vs AGENTS.md 2026" — 2026, high confidence*).
- **The delivery contract:** edit prose once → run the compiler → every tool gets its dialect → none of it is committed. The day a tool changes its config format (and it will: GEMINI.md → AGENTS.md, `.gemini/skills/` → `.agents/skills/` was forced on every Gemini CLI user this very week), you change *one adapter*, not your knowledge.

### 1.3 Stance on runtime / live state — project it as files; reach for a protocol only when you must mutate or subscribe

- **Default: live state is read through paths, not RPC.** The current DB schema, the last error, the tail of a log, the git status, the test result — all of these can be *generated on access* behind a path the agent reads with the same `cat`/`read`/`grep` it uses for everything else. This is exactly what **FUSE virtual filesystems already do**: "files reflect real-time system or application state; contents are generated on access with no caching or persistence" (*influentcoder.com FUSE writeup; kernel.org FUSE docs — 2023-2026, high confidence*). `/proc` has done this for system state since the 1990s; Plan 9 generalized it to *everything*. The model needs zero new tool definitions to read a path.
- **Why this beats reaching for MCP by reflex:** the token economics are not close. CLI/file access runs **4–32× cheaper** than the equivalent MCP path; the trivial "what language is this repo?" task costs **1,365 tokens via CLI vs 44,026 via MCP**, because an MCP server dumps its entire tool schema into context before you ask anything (*firecrawl "MCP vs CLI 2026"; scalekit MCP-vs-CLI benchmark; myclaw "MCP token trap" — 2026, high confidence*). And reliability favored CLI (100% vs ~72%) in the same benchmarks.
- **Where the protocol is genuinely irreducible — and only there:** writes/mutations against a live system, transactional actions, capability-gated reach-in to a remote service, and *push* (the agent must be *notified* of a change rather than poll a path). A file projection is a pull/read interface; when you need to *act* or *subscribe*, a protocol earns its keep. Note even then the asymmetry is small: "every MCP server wraps a REST API, a database, or a filesystem underneath" (*getknit "2026 Guide to the MCP Ecosystem" — 2026, high confidence*) — the protocol is a *transport*, never the ontology. So: **read live state as files; write/subscribe over a thin, scoped protocol.**

### 1.4 Team topology — roles are data, composition is a pipeline

- Each agent is a **named role expressed as a plain-text card** (system prompt + scoped tool list + model tier) — *data*, living in the same canon, compiled to each tool's agent format. Identity is sovereign and portable.
- They are **wired together as a pipeline of filters**: orchestration captures one agent's structured output, transforms it, and pipes it to the next. This is literally how subagents compose today — "agents are invoked as subprocesses rather than literal stdin/stdout filters, but the pipeline pattern is the same" (*tembo.io "Claude Code Subagents 2026"; developersdigest "Agent Teams 2026" — 2026, high confidence*).
- So the design holds **both at once**: a *catalog of named roles* (so a human can reason about responsibility and a tool can route to one) **wired by a swappable pipeline** (so stages are composable and replaceable). The role is the *policy*; the pipeline is the *mechanism* (ESR's Rule of Separation, applied to the team).

---

## 2. Verdicts on H1 / H2 / H3

### H1 — substrate: **CONFIRMED, with a sharpened boundary.** (high confidence)

Durable knowledge as plain-text canon in version control, per-tool config as disposable regenerated glue — this is right, and reality has hardened it into a near-consensus this year: the open format is AAIF-governed, the compile-down tooling ships, and the Gemini CLI death gave us the cleanest natural experiment we'll ever get — **`GEMINI.md` survived the shutdown; the runtime did not** (*digitalapplied / windowsnews Gemini→Antigravity migration — Jun 18 2026, high confidence*). The file outlived the tool that read it. That *is* H1, proven by Google's own hand.

**Where it fails — and the failure is precise:** the H1 dichotomy implicitly treats *all* non-prose as "disposable glue we don't care about." But some glue is **executable and dangerous.** Hooks, `.mcp.json`, and `settings.json` are not inert config — they are code that runs, in some cases *before the trust dialog*. CVE-2025-59536 (RCE via malicious hooks/MCP config in project settings) and CVE-2026-21852 (API-key exfiltration via crafted project files) are the proof, and GitGuardian found **24,008 secrets sitting in MCP config files on public GitHub** (*Check Point Research CVE writeup; GitGuardian State of Secrets Sprawl 2026 — 2026, high confidence*). So H1's "config is disposable" is true for *correctness* but false for *safety*: disposable glue is still an **execution and exfiltration surface**. The boundary I draw is sharper than H1's: it is not prose-vs-config, it is **inert-knowledge (own it) vs executable-mechanism (generate it, gitignore it, scan it, and treat every generated hook as untrusted by default).**

### H2 — the live remainder: **TRANSCENDED — collapse it into the file substrate; do not reflexively serve it over a protocol.** (med-high confidence)

The brief asks: must runtime state be served over RPC, or can it be expressed *as files* — one substrate? My verdict is the second, and strongly. A static file on disk cannot *be* the live schema — true. But "a path the agent reads" is **not the same as "a static file."** FUSE, procfs, and Plan 9 settle this: a path can be a *live view computed on read*. The "static vs live" distinction the brief poses is an artifact of conflating *file* with *static byte blob*; once a path can be a generator, the distinction dissolves. The agent reads `/live/schema` or `tail`s `/live/last-error` with the identical primitive it uses for canon, at file-tier token cost, with no schema dump and no new tool surface.

The protocol survives **only as a narrow remainder**: mutation, transactions, capability-gated remote reach-in, and push/subscribe. That is a real but small slice. So H2 does not "break" — it *inverts*: the live remainder is mostly **filesystem-shaped**, and the part that genuinely needs a protocol is the part that *writes or subscribes*, not the part that *reads*. The reflex to model every live source as an MCP server is the expensive mistake the token benchmarks indict.

### H3 — the team: **TRANSCENDED — the dichotomy is false; it's roles-as-data wired by a pipeline-as-mechanism.** (med confidence)

Named roles buy you *human legibility and routing* (you can ask "who owns this?" and a tool can dispatch to one card). A pipeline of filters buys you *composability and swappability* (any stage can be replaced without touching the others; you can re-order, fan out, fan in). The framing that you must pick one is the error. Reality already runs both: subagents *are* roles (isolated context, scoped tools, custom prompt) and they *compose* like a pipeline (subprocess out → transform → pipe in). The cost of pretending it's only roles is a rigid org chart you can't recompose; the cost of pretending it's only filters is anonymous stages no human can reason about or assign accountability to. **Keep the role as portable data, keep the wiring as a swappable pipeline** — and you get legibility *and* composability, the same policy/mechanism split that powers H1 and H2. (Confidence is only "med" because the cross-vendor agent-card and pipeline-orchestration formats are still fragmenting — hooks notably do *not* converge across vendors — so the *portability* half of this is more aspiration than shipped standard today.)

---

## 3. Where this diverges from the path of least resistance — and why

The path of least resistance is a set of defaults each tool nudges you toward. I diverge from each on purpose.

1. **Least resistance: let each CLI own its own config in its own format.** → **I refuse.** That makes your knowledge a function of N vendors' product decisions; the moment one renames a file or dies (Gemini CLI, this week), you migrate by hand. Divergence: **one prose source, N generated dialects, zero committed glue.** Why: the file must outlive the tool, and only a single owned source guarantees that.

2. **Least resistance: when you want live data, install an MCP server.** → **I refuse by default.** MCP-by-reflex is a 4–32× token tax and a reliability and *security* downgrade (24k secrets in MCP configs; RCE via MCP config). Divergence: **project live state as readable paths (FUSE/procfs-style); use a protocol only to write or subscribe.** Why: reading is the common case, files are the cheapest universal read interface, and the protocol's cost is justified only where its power (mutation, push) is actually used.

3. **Least resistance: commit your config so your setup is reproducible and shareable.** → **I refuse.** Committing hooks/`.mcp.json`/`settings.json` is exactly the supply-chain and secrets-sprawl surface the 2026 CVEs and GitGuardian report light up. Divergence: **generated config is gitignored by construction; reproducibility comes from re-compiling the canon, not from shipping the glue.** Why: the canon is the reproducible thing; the glue is a build artifact and should be treated like one — including secret-scanned and never trusted on clone.

4. **Least resistance: hand-author a fixed roster of named agents.** → **I diverge.** A hardcoded roster is a frozen pipeline. Divergence: **roles are data (portable cards) and the wiring is a swappable pipeline,** so the team recomposes without rewriting identities. Why: the team's *structure* is mechanism and should be as disposable as any other glue; only the role *definitions* are knowledge worth keeping.

The through-line: **the path of least resistance keeps the mechanism and rents the knowledge from a vendor. I keep the knowledge and rent the mechanism, regenerating it on demand.**

---

## 4. Open heresy — what this framing holds fixed that I would question

The brief — and all three hypotheses — quietly assume **the developer's local machine and the git repo are the seat of ownership, and that knowledge is something you *write down* and *deliver to* an agent.** I question two things none of the principles reach for.

**Heresy 1 — the substrate should be content-addressed, not path-addressed.** Every hypothesis assumes files-at-paths. But paths are *names a human chose*, and names drift, collide, and fork across N projects and N machines. Git's own deepest idea (Torvalds) is that **identical content is one object** — address knowledge by the hash of what it *says*, not where it *sits*. A content-addressed canon means the same convention shared across five personal projects is **literally one object**, not five copies that diverge; "delivery" to a new tool or project is a *reference*, not a *copy*; and provenance is free. The path layer becomes a disposable view *over* a content-addressed store — making the human-facing namespace itself regenerable glue. This dissolves the cross-project duplication problem the brief doesn't even name. (Plausible and partly precedented — git, IPFS-style stores — but I cannot point to a shipping AI-CLI that addresses its canon this way as of 2026-06-17; *low-med confidence, reasoned from the data-over-code axiom*.)

**Heresy 2 — stop *delivering* knowledge to the agent; make the agent *derive and write back* canon, and treat the repo as the long-term memory of a colleague, not a config you feed a tool.** Every hypothesis is one-directional: human authors canon → agent consumes it. But the most valuable durable artifact a solo dev can own is the **agent's own learned conventions, decisions, and corrections, compiled back into atomic notes** — knowledge *flows out* of the work, not just into it. The canon becomes a *closed loop*: the agent reads it, acts, and the diffs/decisions/corrections are distilled back into new atomic notes (lint the vault, dedupe, cross-link — the "compiled vault" discipline). Under this frame, "ownership and delivery of AI-agent knowledge" is the wrong noun: it's **cultivation of a shared, append-only, content-addressed memory that both the human and the agents read *and* write,** version-controlled so every belief has provenance and can be reverted. The first principle none of the five reaches for is **provenance as a first-class property of knowledge** — *who/what/when established this, and can I revert it* — which version control already gives prose for free and which no MCP-served or vendor-memory store gives you at all. That, not the static-vs-live question, is the axis on which sovereignty is actually won or lost.

---

## 5. Sources (inline citations consolidated)

- **AGENTS.md / AAIF governance & adoption** — Linux Foundation AAIF press release; OpenAI AAIF post; codersera "AGENTS.md Complete Guide 2026" (Dec 2025 / 2026, high).
- **Claude Code reads CLAUDE.md not AGENTS.md; bridge via @import/symlink; issue #6235** — gist yurukusa; bestagent.dev "CLAUDE.md vs AGENTS.md 2026" (2026, high).
- **Compile-down delivery (Ruler), one source → N tool files, auto-gitignore, manages MCP config** — github.com/intellectronica/ruler; Addo Zhang "Ruler" writeup (2026, high).
- **Substrate size / context-rot / per-turn token cost** — scrum.org "Token Economics 2026"; CLAUDE.md best-practice guides (2026, high).
- **MCP vs CLI/file token cost (4–32×; 1,365 vs 44,026; reliability)** — firecrawl "MCP vs CLI 2026"; scalekit benchmark; myclaw "MCP token trap" (2026, high).
- **Every MCP server wraps a REST API / DB / filesystem; stateful sessions** — getknit "2026 Guide to the MCP Ecosystem"; AWS Bedrock AgentCore stateful-MCP post (2026, high).
- **Live state as files / generated-on-read** — influentcoder.com FUSE writeup; kernel.org FUSE docs (2023-2026, high). Plan 9 namespaces / procfs as prior art (canonical, high).
- **Config-is-code security: CVE-2025-59536 (RCE), CVE-2026-21852 (key exfil); 24,008 secrets in MCP configs** — Check Point Research; GitGuardian State of Secrets Sprawl 2026 (2026, high).
- **Gemini CLI shutdown → Antigravity; GEMINI.md→AGENTS.md, .gemini/skills→.agents/skills; file survived, runtime died** — digitalapplied / windowsnews migration guides (Jun 18 2026, high).
- **Team: subagents as subprocess pipeline + named roles** — tembo.io "Claude Code Subagents 2026"; developersdigest "Agent Teams 2026" (2026, high).
- **First principles** — Torvalds (data structures / content-addressing), Pike ("data dominates"), McIlroy/ESR (text as universal interface; policy/mechanism), Plan 9 namespaces, Zettelkasten/evergreen atomicity (canonical, high).

---

*R1 · the research center · 2026-06-17 · one blind voice. No middle hedged; positions taken.*
