# Wiring: gemini-agents repair map — the four `reposoma-*` seats
**Date:** 2026-07-07
**Author:** @Oraculum (temple seat — map only, no card edits; temple discipline holds)
**Audience:** a reposoma.devenv-seated session (or majkee + @Astrobley) — execute against this map
**Cards:** `~/.gemini/agents/reposoma-{deep-researcher, new-patterns-researcher, practical-coder, source-mapper}.md` — all dated **2026-06-06**

> **⚠ ROUTING SUPERSEDED — see Amendment A1 at the bottom: execution runs from the TEMPLE seat
> with a mandatory devenv pre-read. The "Audience" line above is retained unedited as history.**

---

## Context (why these cards are wrong without being lost)

The four seats are **stranded, not lost**: built 2026-06-06 for the early-June agy-era bootstrap
topology, which the temple restart (06-17→) replaced underneath them. The 07-04→07-06 window is
verified empty across four surfaces (`~/.config/zsh`, ia-sync, `~/.gemini`, `~/.agents`); Gemini
session-history dirs stop at 07-02. The cards were never updated — they still describe a world
with an `.agy/` tree, a `reposoma.dev/` root, and no knowledge of the 07-03 hang triage.

**Rule for the executor:** this map proposes *direction*, not final strings. Correct rewiring
depends on reposoma.devenv's charter state (§D, P0 decisions) — read the devenv charter +
project entry files **first**, verify the actual boot filenames and roots, then apply.

---

## The six verified breaks

1. **`.agy/` tree is gone / never built** — cards route discipline through
   `.agy/skills/reposoma-surgical-coding/SKILL.md` and `.agy/agents/…`; `reposoma.devenv` has
   **no `.agy/` at all**. The skill's only live copy sits in legacy `~/.agents/skills/`.
2. **Boot order stale** — cards say `GEMINI.md → DASHBOARD.md → session/project-bootstrap/…`
   (researcher variant: `GEMINI.md → AGENTS.md → pulse.md`); the beacon's actual boot order is
   `CLAUDE.md → pulse.md → _mail/INDEX.md → charter`.
3. **Scope roots stale** — `reposoma.dev/`, `larva.dev/`, `raw/`, `bus/` vs. the real ovum
   layout (`reposoma.devenv/`, `reposoma.v1/`, `reposoma.v2/`).
4. **No harness warning** — the 07-03 triage locked **"`@agent` in headless = Class C hang;
   REST only"** (empirically confirmed: probe 4, 90s timeout with `-p` + `/dev/null` stdin;
   see `triage.gemini-hang.2026-07-03.md`). Field report confirms: *"practical coder runs
   normally — only harness was the problem."* None of the four cards carry the rule; the
   astrobley/bluebottle REST-primary driver pattern is the cure and none reference it.
5. **`~/.gemini/policies/` doesn't exist** — the rebuild research (Q2) recommended a policy
   TOML to make yolo/headless runs safe. Never created.
6. **Sync unknown** — whether `~/.gemini/agents/reposoma-*` is covered by ia-sync's `gemini/`
   tree needs one check. Caution: a previous ia-sync glob was blinded by a gitignore shadow —
   check with `git ls-files` / explicit listing, not glob alone.

---

## Per-card map

### 1. `reposoma-deep-researcher.md` — primary live researcher (Orby sibling)

| Line(s) | Evidence (verbatim) | Break | Proposed fix |
|---|---|---|---|
| 29 | `GEMINI.md → AGENTS.md → pulse.md` | #2 | Replace with devenv's verified boot order |
| 30–31 | `raw/researcher.recalibration.standing-prompt.md`, `raw/raw.card.*` | #3 | Re-root to actual card/prompt homes in the ovum layout (verify they exist; if the standing-prompt moved, repoint; if gone, flag — don't invent) |
| 41 | canonical source `github.com/google-agy/agy-cli` | agy-era | Re-verify canonical-source list; runtime is legacy `gemini` CLI 0.49.0, not agy |
| 99–100 | `cd reposoma.dev` + `agy "@reposoma-deep-researcher …"` | #3 + #4 | **Triple break — the card's own invocation example reproduces the Class C hang.** Replace with: interactive `@` selection for UI runs; REST-primary driver (astrobley/bluebottle pattern, `ai_scripts/`) for headless |
| — | no harness rule anywhere | #4 | Add the locked rule (see G1) |

Keep: the recalibration standing instructions, per-run `research_scope` contract, mode table,
output shape — that layer is sound and vendor-current in spirit.

### 2. `reposoma-new-patterns-researcher.md` — deprecated alias

| Line(s) | Evidence (verbatim) | Break | Proposed fix |
|---|---|---|---|
| 15 | `Read .agy/agents/reposoma-deep-researcher.md and follow it entirely.` | #1 | Smallest safe: repoint to `~/.gemini/agents/reposoma-deep-researcher.md`. Alternative: delete the card if smoke-history compat is no longer needed — **devenv call** |

### 3. `reposoma-practical-coder.md` — the workhorse (field-confirmed working; only harness broke)

| Line(s) | Evidence (verbatim) | Break | Proposed fix |
|---|---|---|---|
| 17 | `.agy/skills/reposoma-surgical-coding/SKILL.md` | #1 | Decide the skill's live home: repoint to legacy `~/.agents/skills/reposoma-surgical-coding/` (works today) **or** migrate the skill into a devenv-native home and point there — **devenv call**; don't leave a dead path |
| 25–27 | `GEMINI.md` → `DASHBOARD.md` → `session/project-bootstrap/session.project-bootstrap.md` | #2 | Replace with devenv's verified boot order; verify whether a bounded session-memory file exists in the new layout |
| 33–35 | `reposoma.dev/` active root; `larva.dev/`, `raw/`, `bus/` reference | #3 | Re-root: `reposoma.devenv/` active; verify what the reference set is now. `reposoma.v*/` glob likely still valid against `v1/v2` — confirm |
| — | no harness rule | #4 | Add G1 |

Keep: surgical-discipline-by-reference (right pattern — just fix the pointer), working rules
1–7, output shape.

### 4. `reposoma-source-mapper.md`

| Line(s) | Evidence (verbatim) | Break | Proposed fix |
|---|---|---|---|
| 15–17 | same stale boot triplet as practical-coder | #2 | Same fix |
| 21–24 | `session/project-bootstrap/tasks/task.prearchitectural-source-distillation.md` + `briefs/brief.agy-agent-distillation.md` | #2/#3 | Verify these bootstrap-era artifacts exist in devenv; repoint or drop the section — don't leave dead reads |
| 28–31 | same stale scope roots | #3 | Same fix |
| — | no harness rule | #4 | Add G1 |

Keep: line 37 (`Do not search legacy ~/www/session/`) — still valid. Keep the
fact/inference/contamination separation discipline and report template.

---

## Global fixes (all cards / environment)

- **G1 — harness rule, every card:** add verbatim: *"Headless discipline (locked 07-03):
  `@agent` in a headless prompt = Class C hang — never use `gemini -p "@agent …"` from scripts
  or command substitution. Headless = REST-primary (astrobley/bluebottle driver pattern,
  `ai_scripts/`). Interactive UI `@` selection is fine."* Source of record:
  `triage.gemini-hang.2026-07-03.md`.
- **G2 — `~/.gemini/policies/`:** create the policy TOML per the rebuild research (Q2) so
  yolo/headless runs are safe. Scope with the devenv charter before writing.
- **G3 — ia-sync check:** one command — is `~/.gemini/agents/` in ia-sync's `gemini/` tree?
  If not, the rewired cards won't travel to home. Beware the gitignore shadow (break #6 note).

## Execution order (proposed)

1. Read devenv charter (§D, P0 decisions) + devenv `CLAUDE.md`/`GEMINI.md` → confirm boot
   order + roots (invalidates or confirms every "verify" above).
2. Card 3 (practical-coder) first — it's the seat that's actually used and field-confirmed.
3. Card 1 (deep-researcher) — fix the invocation example before anyone copies it again.
4. Cards 2 + 4 — alias repoint (one line) and mapper refresh.
5. G1 into all four in the same pass; G2, G3 after.

## Parked (related, not this map)

- **Home-machine hypothesis:** ~~the 07-04→07-06 "lost days" may live uncommitted on the home
  disk~~ **CLOSED 07-07 — operator was off entirely; window genuinely empty, nothing to recover.**

---

## Amendment A1 — routing correction (2026-07-07, same day — operator ruling, append-only)

The original routing ("a devenv-seated session executes") is **superseded**. Operator's topology
ruling: **the temple is the central builder and maintainer of globals, agents, and machine-layer
rules; projects receive, or bring their needs to the center.** The four cards are machine-layer
artifacts (`~/.gemini/agents/` — global, inside no project repo); their cure references
temple-maintained infra. This is temple crew-work.

**Execution therefore runs from the TEMPLE seat**, with the seating requirement replaced by the
requirement it was always standing in for — context:

1. Mandatory pre-read, in order: `registry/reposoma.devenv.md` (beacon) → devenv contract/charter
   (§D, P0 decisions) → devenv lighthouse (`CLAUDE.md`/`GEMINI.md`).
2. "Reiterate fresh" discipline applies — no reposoma memory carried into devenv facts.
3. All **"devenv call"** items in the per-card tables become: *temple decides after the pre-read;
   where the charter is silent, operator gavels.*

This amendment supersedes the routing phrasing in `_mail/houston/inbox/
oraculum.pulse-advance-and-claviature.2026-07-07.md` §1 (correction mailed separately).
