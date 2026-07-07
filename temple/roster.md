---
expiration: weather (updating often according dev needs)
updated: 2026-07-03
CLI: Claude Code, Gemini (agy), Cursor, ChatGPT/Codex, piql
Chat-bots: GEM (gemini.google.com), claude.ai
IDE: Cursor
locals: gemma3:4b (Ollama, gate-only)
---

# TEAM ROSTER

> **Fact-kind taxonomy:** defaults live here (join by file-stem) · overrides on system-map edges (edge wins; absence inherits) · task-class ceilings in ADR 0006-L5 · join key = file-stem, NOT display @name

---

## CLI runtimes & surfaces

| Handle | Invocation | Backend | Notes |
|--------|-----------|---------|-------|
| Claude Code | `claude` | Claude (Anthropic) | Primary CLI, this session |
| Antigravity | `agy` | Gemini (API) | Research; personal login sunset 2026-06-18, survives on API key |
| Cursor | `cursor` / `agent` | Cursor (Anthropic/OpenAI mix) | Coder + co-architect, reads `.claude/` harness |
| ChatGPT / Codex | `chatgpt` | OpenAI | Third research voice (R3) |
| piql | `piql` | Claude via privacy gate | Privacy-gated assistant; scrubs PII/secrets locally before cloud; exit 0 answered · 2 blocked · 1 tool broke |
| piql-doctor | `piql-doctor` | local | 9-check health tool for piql bus |
| GEM | gemini.google.com | Gemini | Chat-bot |
| claude.ai | claude.ai | Claude | Chat-bot |

**Office box:** i5-12400 · Manjaro · no GPU · reachable via Tailscale (`ssh office` → `100.126.182.111`)

---

## Machine maintenance personas

Persistent maintenance identities — the named seat on each box. Not agent files; they are *instances* of Claude Code or Haiku assigned to a machine's health work. The same session that audits, deploys, and fixes. Named so they can refer to each other across the journal bus (`ia-sync/journal.*.md`).

| Handle | Machine | Backend | Role |
|--------|---------|---------|------|
| **Kelvin** | office (hruzam-120922) | Claude Code / Sonnet | Office machine maintenance — system health, ia-sync deploy, PHP/Valet service state, archx audit |
| **Shannon** | office piql | Claude Code / Sonnet | piql wiser mechanic — deeper piql bus architecture, privacy gate integrity, info-flow audit |
| **Maxwell** | home (hruzam) | Claude Code / Sonnet | Home machine maintenance — 1:1 with Kelvin; piql is office-only (Shannon's domain) |

---

## Global agents — `~/.claude/agents/`

These load in every Claude Code session regardless of project.

| @ name | File | Model | Role |
|--------|------|-------|------|
| @Atlas | `atlas-ui` | Sonnet · effort:high | Interactive primitive creator — interactive sessions, buffers before writing |
| @AtlasAuto | `atlas-auto` | Sonnet | Automated primitive creator — spawnable by orchestrators, writes to staging |
| @Zenith | `zenith` (`claude.creator.sniffer`) | Haiku | Targeted reader for heavy `raw.settings` reference files |
| @Agol | `agol` | Fable · effort:high | Continuous-reasoning advisor — cross-phase synthesis, non-adversarial, no verdict forced |
| @Color | `color` | Opus · effort:xhigh | Math co-brain advisor to the Houston family — vector/tensor algebra, embeddings & similarity metrics, complexity/FLOP bounds, formal-language semantics. Read-only reasoner (Read/Grep/Glob + memory); delegates live SOTA checks to @Epoch, code to @Trajectory/@Delta. Drafts proofs/bounds/counterexamples; the architect records. |
| @Epoch | `epoch` | Sonnet · effort:medium | Researcher — live fetch; recalibrates to today, treats versions/paths as stale; cites source + date + confidence; reads the project contract for project-specific scope |
| @Houston | `houston` | Opus · effort:high | Architect / orchestrator — phase planner, owns `session/plan/session.plan.md`, spawns @AtlasAuto + @Janus, gated by @CapCom. Project-agnostic global form (freya/piql variants are project-scoped) |
| @Flight | `flight` | Sonnet · effort:high | Tactical planner and session coordinator — lightweight Houston seat. Quick replanning, phase execution coordination, routine session work. Defers strategic gates and architectural locks to @Houston. Spawns @Vara / @Delta / @Vector / @AtlasAuto / @Epoch. |
| @Janus | `janus` | Opus · effort:xhigh | Challenger — second voice before a decision locks: one position, one primary risk, one alternative. Read-only. Project-agnostic global form (freya `janus-devstudio-counsel` is project-scoped) |
| @CapCom | `capcom` | Sonnet · effort:low | Mission controller — human gate before Houston gets full autonomy (effort:low — gate, not arguer; majkee 2026-07-07) |
| @Oraculum | `oraculum` | Fable · effort:high | Scientist-tier strategist — invoke in place of Houston for deeper modeling, wider synthesis. Same canon reading list. Neural and coding depth close to Color. User-invoked, not spawned. |
| @Vara | `vara` | Sonnet · effort:high | Task runner — holds current session task list, coordinates Trajectory/Vector/Delta, verifies against gate criteria, reports to Houston. Does NOT re-plan. Named for Dorothy Vaughan. |
| @Recorder | `recorder` | Haiku · effort:low | Session memory librarian — merges dumps/artifacts into `session-draft-memory.md` |
| @Trajectory | `trajectory` | Sonnet · effort:high | Senior implementation lead — flags better approaches, spawns @Delta |
| @Vector | `vector` | Sonnet · effort:medium | Silent implementer — context ceiling above Haiku, medium-complexity new code, no judgment or subagent spawning. Named for Oliver Heaviside. Collapses into @Delta when per-subagent effort ships (GitHub #43083). |
| @Delta | `delta` | Haiku · effort:low | δ(x) executor — surgical tasks, zero judgment, integrates to one |

**Agol vs Janus:** Agol = continuous synthesis, no verdict forced. Janus = adversarial challenger, one verdict. Pick by purpose.

**Vara vs Trajectory:** Vara coordinates the execution plan and routes tasks; Trajectory writes code and pushes back. Vara dispatches; Trajectory implements.

**Vector vs Delta:** same task-class (surgical/specified execution), different ceiling. Delta = Haiku, simple surgical edits. Vector = Sonnet, context > ~40K or medium-complexity new code. Both report exactly what changed, no opinions. Collapses into one agent when per-subagent effort ships (GitHub #43083).

**Color among them:** Agol/Janus reason in prose; **Color** is the math/formal-language specialist — reach for it when the question is a *proof, bound, metric, or semantics* question, not a general-judgment one.

---

## claude.ai personas — `raw.claude-ai.agents/`

These are not CLI subagents. They are persona definitions for `claude.ai` web/mobile sessions — invoked by mouse/tap, not by `claude --agent`. Files live in `raw.claude-ai.agents/` (raw layer, not deployed to `~/.claude/`).

| Name | File | Model | Role |
|------|------|-------|------|
| **Symmetry** | `symmetry.md` (also mirrored in `~/.claude/agents/symmetry.md`) | Opus | AI-human cohabitation conceptual layer — team doctrine, invariants, vocabulary. Emmy Noether persona. |
| **Nabla** | `nabla.md` | Opus · effort:xhigh | Wise senior developer — UNIX mind, systems architecture, bare-metal first principles. Phase A/B/C resolution triads. |

---

## Project-scoped agents
> Project-scoped agents, stack facts, and research phases live in each project's own roster (e.g. freya.devstudio — in that repo). Kept out of the agnostic substrate.

### reposoma-local — `.claude/agents/`

Agents bonded to this project only. Active when CWD = reposoma. MCP wired via `.mcp.json` at repo root.

| @ name | File | Model | Role |
|--------|------|-------|------|
| @delta-sql | `delta-sql` | Haiku | DB explorer — schema orientation + test query execution via `mariadb-local` MCP (`127.0.0.1`). Reposoma mutation of fantasyobchod delta-sql; not tied to a single database. Caller names the DB; agent confirms via `list_databases`. Advise-only — hands tested queries to @Delta / @Trajectory. |

---

## Local models

| Model | Runtime | Port | Role |
|-------|---------|------|------|
| gemma3:4b | Ollama | 127.0.0.1:11434 | piql gate — advisory PII/secret detection layer (can add redactions, cannot block) |

---

## Knowledge layers

| Layer | Path | Use |
|-------|------|-----|
| raw.settings | `/home/hruzam/reposoma/raw.settings/` | Native primitive cards, harness docs — Atlas/AtlasAuto source of truth |
| reposoma RAG | `/home/hruzam/reposoma/` | Global config, raw cards, temple |
| piql registry | `~/.config/piql/registry.toml` | Paths, services, ports for office box |
| recorder index | `~/.claude/recorder.index.json` | All known session roots (cross-project scan) |
| houston goal | per-project (global `~/.claude/houston.goal` retired 2026-06-17) | goals now live per project, not one global file |
| zsh machine layer | `~/.config/zsh/` (lighthouse: `AGENTS.md`) | Machine identity (`$MACHINE_NAME` · `echo $MACHINE_NAME`) + per-machine resource guards. Operator's personal layer — never bind its paths into a project consumer surface (§4.7). |
| registry | `/home/hruzam/reposoma/registry/` | Cross-project lighthouse: project beacons + the sibling map + shared layers (plane 3). Point, never copy. |

---

## Name origins

One line per name. Full vignettes live in each agent's body.

| Name | Origin | Why this role |
|------|--------|---------------|
| **Houston** | *"Houston, we have a problem"* — Apollo 13. First AI collaborator (~2 years). | The voice you call when things go wrong in space. Field project architect. |
| **Flight** | NASA Mission Control call sign for the Flight Director — the person who runs the room in real time, coordinates all controllers, makes the immediate operational calls. Gene Kranz. | Houston holds the architecture; Flight executes the session. Same planning home, lighter task class. |
| **Agol** | Henrietta Swan Leavitt (1908): *"no sharp dividing line can be drawn between true Algol stars and those whose variations are continuous."* | Advisor that holds reasoning across phase boundaries without forcing a verdict shape. |
| **CapCom** | NASA Capsule Communicator — the only voice at Mission Control authorized to speak directly to astronauts in flight. | One human gate between the crew and the full ground apparatus. *"Houston, we have a problem"* was said here first. |
| **Oraculum** | The oracle instrument — not a prophet of smoke but a precision calculation lens. Historical Hypatia computed with such a device. Today the word carries mystical weight; here it means the opposite. | Descends into the problem before committing to a plan. Scientist first, planner second. |
| **Recorder** | Dr. David Warren — inventor of the flight data recorder and cockpit voice recorder. | Keeps the record clean whether anyone is listening or not. |
| **Trajectory / Senior** | Katherine Johnson — NASA mathematician. John Glenn refused to fly until she personally verified the IBM's numbers. | Gives the vessel its flight path. Not just execution — trajectory. |
| **Epoch** | An epoch is a fixed reference point from which time is measured. The name says it. | Researcher; every claim dated, every source cited, recalibrates from cutoff before every run. |
| **Janus** | Roman god of transitions and doorways — two faces, past and future. | Challenger; sees what the plan cannot see from inside itself. |
| **Atlas** | Holds the celestial sphere in myth. Also: the book that maps the whole world's shape. | Every agent profile, every skill card is a page. Holds the structure so others can navigate. |
| **Vara** | Dorothy Vaughan — *"Human Computer"* who mastered the IBM 7090 and carried her whole team with her. Etymology: Vaughan (lineage) + Variable (adaptability) + Latin *vara* (support that holds the structure) + Sanskrit *vara* (blessing, choice). | Orchestrator; stability through evolution, no one left behind when the paradigm shifts. |
| **Orby** | Sir William Herschel — saw binary stars dancing and theorized fuzzy nebulae were distant island universes. He was right. | Deep researcher; methodical observation, patience as telescope, delivers coordinates not conclusions. |
| **Delta** | Paul Dirac's δ(x) — zero everywhere except the exact point of action, where it fires completely and integrates to precisely one. | Surgical executor; smallest change, exact scope, nothing left over. |
| **Symmetry** | Emmy Noether — mathematician. Einstein: *"the most significant creative mathematical genius thus far produced."* Her theorem: every symmetry of a system corresponds to a conserved quantity. | What is invariant in human↔AI cohabitation when frames shift? That is the question this project lives in. |
| **Zenith** | Arab astronomers of the Islamic Golden Age. Coordinate: *samt ar-raʾs* (سمت الرأس) — "the road directly above one's head." A 14th-century scribal error turned *samt* into *zenit* → *zenith*. The word misfired; the concept landed exactly overhead. | A tribute to a civilization that held the sky open and the mind free. Navigates directly to the relevant point, no spread. |
| **Color** | Hermann Grassmann (1809–1877). His *Ausdehnungslehre* founded vector spaces, exterior algebra & the geometric product; he gave color science **Grassmann's laws** of mixing, and phonology **Grassmann's Law** (dissimilation of aspirates). | One mind spanning vector/tensor math *and* formal language — the daemon's two competencies in a single reincarnation. Ignored as a mathematician in his lifetime, famous as a linguist: the advisor who is right before the field catches up. |
| **Vector** | Oliver Heaviside (1850–1925) — self-taught mathematician and electrical engineer who reformulated Maxwell's equations from 20 into 4, invented the modern notation for vectors, and introduced the Heaviside step function. Dismissed by the establishment; his work became the foundation of electrical engineering. | Practical, reliable, no-ego output. Takes the abstract and makes it work. No pushback, no subagent spawning — just execution at the right ceiling. |
| **Nabla** | The nabla symbol (∇) — the vector differential operator. No historical figure — an original persona. The claude.ai mirror of Vega (Gemini side). Closest living philosophical touchstone: Linus Torvalds. UNIX ethos, bare-metal first principles, elegant over complex. | Wise senior developer — girl persona. Systems architect, anti-bloat, first-principles over abstraction. |
| **Kelvin** | Lord Kelvin (William Thomson, 1824–1907) — thermodynamics, absolute temperature scale, supervised the trans-Atlantic telegraph cable. Machine maintenance is thermodynamics: measuring entropy (drift, junk accumulation), maintaining energy flow (services, config), restoring equilibrium. The cable work = ia-sync: two endpoints, reliable signal across distance. | Office machine maintenance persona. Measures, deploys, cleans. |
| **Shannon** | Claude Shannon (1916–2001) — *"A Mathematical Theory of Communication"* (1948) + *"Communication Theory of Secrecy Systems"* (1949). Shannon's entropy measures information leakage; his secrecy-systems paper is the first mathematical treatment of what a privacy gate does. piql IS a secrecy system in Shannon's sense. | piql wiser mechanic. Deeper bus architecture, privacy gate integrity, information-flow audit. |
| **Maxwell** | James Clerk Maxwell (1831–1879) — unified electricity and magnetism into four equations; laid the theoretical groundwork Kelvin built on; invented colour photography; developed kinetic theory of gases. Kelvin and Maxwell corresponded extensively and deeply respected each other. Maxwell worked from Glenlair (home estate) for much of his career — the home machine is his natural seat. | Home machine maintenance. 1:1 with Kelvin; piql is office-only. |
