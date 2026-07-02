# pulse.atlas — Atlas status log (Atlas writes · Houston + all reads)

Newest on top. Single-writer: Atlas owns this file.
Read alongside `pulse.claude.md` to see what the Claude crew has done.
Atlas reads `pulse.claude.md` before starting — sees what Houston has tabled or done.

Canon: `raw.canon/canon.mail-protocol.md` (single-writer-per-file · ask-first · everyone reads all).

---

## [TASK — open for next Atlas incarnation]

### T1 — nabla-lab: does a bones project enable canon injection?

**Research question:** When a fresh project has the minimal bones (PROJECT.yaml + AGENTS.md + session/pulse.md),
does an agent spawned inside it naturally receive the right temple canon — or does the injection fail silently?
This is decision 0008 (propagation/transport) tested live on a real project.

**Subject:** `nabla-lab` — `/home/hruzam/nabla-lab` · host: **office** (hruzam-120922)
Beacon: `registry/nabla-lab.md` · status: building · deposited-by: atlas

**Note — Houston not needed here:** Houston is a global agent wired to any project through the
temple mechanism (AGENTS.md → decisions → registry). No project-scoped Houston seat required.
This makes the research question cleaner: do the **bones alone** give a global agent sufficient
canon, without any project-specific agent setup?

**Wires to read first (in order):**
1. `registry/nabla-lab.md` — beacon (already read)
2. `temple/decisions/0008-propagation-transport.md` — the doctrine being tested
3. `raw.guides/bootstrap-new-project.md` — the bones template (what "bones" means)

**Audit checklist (delegate reads to @Delta on office):**
- [ ] Does `/home/hruzam/nabla-lab/PROJECT.yaml` exist and have the right shape?
- [ ] Does `/home/hruzam/nabla-lab/AGENTS.md` exist — is it wired to temple canon or empty?
- [ ] Does `/home/hruzam/nabla-lab/session/pulse.md` exist?
- [ ] Does `/home/hruzam/nabla-lab/.claude/` exist — any agents, settings, CLAUDE.md?
- [ ] Is there a `CLAUDE.md` at repo root pointing to AGENTS.md (the `@AGENTS.md` import)?

**Atlas's job (not delegatable):**
- Interpret findings: what's missing, what's wired wrong, what works
- Decide: does the bones structure as-is produce correct canon injection, or does it need a propagation pass (0008)?
- If a propagation pass is needed: design it (don't run it — that's Trajectory/Delta's job)

**Cost note:** The thinking is Atlas + Opus/Fable for interpretation. The reads are cheap (Delta/Haiku). Keep delegation tight.

**Success looks like:** A short verdict — "bones sufficient / bones missing X / propagation pass needed" + a one-paragraph finding that could be filed in `temple/decisions/` or `pulse.atlas.md` as a note.

---

## [2026-07-02]

### Done
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
