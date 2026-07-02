# pulse.atlas — Atlas status log (Atlas writes · Houston + all reads)

Newest on top. Single-writer: Atlas owns this file.
Read alongside `pulse.claude.md` to see what the Claude crew has done.
Atlas reads `pulse.claude.md` before starting — sees what Houston has tabled or done.

Canon: `raw.canon/canon.mail-protocol.md` (single-writer-per-file · ask-first · everyone reads all).

---

## [2026-07-02]

### T3 DONE — Oraculum seated, Hypatia retired (2026-07-02)

- `~/.claude/agents/oraculum.md` — new agent (Fable · effort:high · Read/Grep/Glob/Write/Agent)
  - Scientist-tier, user-invoked alternative to Houston. Same canon reading list.
  - Phases: Substrate → Architecture → Directive. Buffering (Nabla-derived). Honesty baked in.
  - Therapy protocol (Symmetry-derived). Neural/coding depth close to Color.
- `~/.claude/agents/hypatia.md` — tombstone (retired, points to oraculum)
- `~/.claude/skills/agol-brief/SKILL.md` — new skill (repurposed from hypatia-brief)
- `~/.claude/skills/hypatia-brief/SKILL.md` — tombstone (retired, points to agol-brief)
- `temple/roster.md` — Hypatia → Oraculum (table row + name-origin entry)
- `temple/system-map.md` — HYP node → ORA; dispatch hierarchy updated; v5 changelog added
- `raw.canon/canon.cost-gradient.md` — tier table updated
- `temple/decisions/0006-model-effort-assignment.md` — matrix row updated
- `~/.claude/agents/houston.md` — @Hypatia refs removed; @Oraculum noted as user-invoked alt
- `~/.claude/agents/flight.md` — @Hypatia → @Oraculum in "do not spawn" list
- `~/.claude/agents/agol.md` — stale "running on Opus" note cleared; Fable confirmed

**Positioning note:** Oraculum is a philosophical gradient above Houston (user choice of seat,
not a dispatch node Houston calls). `hypatia-brief` repurposed to `agol-brief` for Agol
synthesis handoffs. Therapy file `raw.therapy/hypatia-core/` kept as historical archive.

---

### Done
- **T2 DONE — nabla-lab AGENTS.md: standing disciplines section** (2026-07-02)
  - Added `## Standing disciplines` (two bullets) after Conventions, before Read order.
  - Token economy / ask-first → pointer to `raw.canon/canon.mail-protocol.md`. Context discipline → read thin, list inbox filenames first. Canon gavel not duplicated (already in Conventions).

- **T1 DONE — nabla-lab canon injection audit** (2026-07-02)
  - Audit scope: does a bones project (PROJECT.yaml + AGENTS.md + CLAUDE.md + session/pulse.md) produce correct canon injection for global agents? Includes temple disciplines — doctrine, forces, **token economy** — not just project orientation.
  - Findings:
    - `CLAUDE.md` (`@AGENTS.md`) present and live → project orientation injection works ✓
    - `session/pulse.md` + `PROJECT.yaml` present, correct shape ✓
    - `.claude/` does not exist → no project-scoped agent surface → **0008 propagation pass not applicable** (empty diff)
    - `CLAUDE.md` is gitignored → fresh clone breaks injection (latent risk, single-host lab for now)
  - **Two-layer verdict:**
    - *Project orientation:* sufficient. Global agents spawned in nabla-lab receive the lighthouse (what the project is, shaping team, gates, read order).
    - *Temple canon:* **insufficient.** Doctrine, nine forces, token economy (`raw.canon/canon.mail-protocol.md`), decision records (0001–0008) are NOT in the injection path. Reposoma is a separate repo, not mounted. Global agents carry only their compiled-in discipline slice — if temple moved since the definition was last written, the agent in a nabla-lab session won't know.
  - **nabla-lab gap (project-level):** AGENTS.md (the lighthouse) does not mention token economy / ask-first / don't-blow-context discipline. Agents operating there have no project-level signal for these behaviors — they rely entirely on their own definition. If a new global agent or a claude.ai persona (Nabla, Symmetry) operates in this project, it is flying blind on temple disciplines.
  - **Open question for Houston:** is the doctrine gap a structural issue for ALL bones projects, or only for projects whose AGENTS.md doesn't explicitly reference temple disciplines? Should `bootstrap-new-project.md` include a token-economy / key-discipline callout in the bones template?

- `raw.settings/README.md` — new: folder entry point, card frontmatter template, freshness rule
- `raw.card.claude-code.md` — MCP scope table (4 scopes, merge-not-override) + context-loading-by-scope (3 scenarios, CWD invariant, synthesizing-agent note)
- `bootstrap-new-project.md` — CLAUDE.md budget rule (120 cap, cumulative framing, open research flag) + session-handoff pattern note
- `~/.claude/CLAUDE.md` — Delta-for-git rule; combined line-count >120 notify rule (33 lines, outside repo)
- `commit ee95593` — 3 tracked files, 87 insertions
- `pulse.atlas.md` — this file (bones, wired to bus)
- `atlas-ui.md` — Step 0 added (read-state-first, pulse wiring)
- `~/.claude/skills/session-resume/SKILL.md` — new global skill (CWD-derived slug, ask-first, journal-free)

### Open / tabled
- CLAUDE.md line cap: RESOLVED — official = per-file 200-line soft cap; MEMORY.md is separate hard limit (200 lines/25KB). Bootstrap + card updated. Temple's 120-combined rule stands as conservative judgment.
- `@Agol` Fable candidate — DONE: `model: fable` written to `~/.claude/agents/agol.md` (outside repo, active next session)
- `advisor-high` model:fable — confirmed live ✓ no action needed
- **[TABLED → Houston]** nabla-lab doctrine gap: AGENTS.md missing token economy / temple disciplines callout. Broader question: should `bootstrap-new-project.md` bones template include a standing discipline section (or pointer to `raw.canon/`) so every project lighthouse covers this by default? Atlas flags; Houston gates.
