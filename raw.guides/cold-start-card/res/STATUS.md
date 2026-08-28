---
title: Cold-start card — developing-shape status (decision journal)
chapter-of: cold-start-card
---

# STATUS — how this shape grew, and where it stands

Newest on top. One dated entry per shape change: what changed, WHY (the reason is the
payload — brand-agnostic, so any future Claude/Codex/Gemini incarnation understands the
decision, not just the delta).

_⚠ Reconcile-on-arrival: majkee names `raw.guides/status/GUIDE.md` as the new canonical
status-document shape — that guide is NOT on this machine yet (other session, uncommitted).
When it lands, conform this file to it and drop this note._

**Pending actionable work lives in the vault, not here:**
`~/reposoma/_cold-start/card/CS.cold-start-phase2.2026-08-28.md` (Phase-2 build: migration →
cs-palette → temple-cs-manage → blessing). This file records only WHY the shape is what it is.

---

## 2026-08-28 — HANDOFF renamed to STATUS; Phase-2 spec dogfooded into the vault

majkee's doubt confirmed a semantic wobble: in the world this guide built, "handoff" IS the
cold-start card — a journal file named HANDOFF.md muddied the vocabulary, and the Phase-2
build spec it carried was session glue, not journal. Resolution: (1) this file renamed
STATUS.md (majkee: "instead of handoff we have status now"), role narrowed to the
decision journal; (2) the Phase-2 spec moved into the vault's FIRST CITIZEN card —
`CS.cold-start-phase2.2026-08-28.md` — which doubles as the Claude-side write smoke test
and the D3-reveal test fixture (it carries a `prompt-0`). Clean roles: guide = law ·
status = why · card = what's next. Old `HANDOFF.md` left as a tombstone pending `git rm`
(harvest-before-remove: content fully moved here + to the card).

## 2026-08-27 (second pass) — raw.guides innovations absorbed

Re-read of recent guide slugs folded three conventions in: `verify_cmd:` frontmatter hook
for the `/guide` staleness organ (knowledge-card shape, `remote-control` reference) ·
two-directional authority clause (guide wins on schema, script wins on behavior —
trust-disk-over-doc, tmux scar 2026-08-20) · Phase-2 build routed through the
regime-session protocol (`_drop` kraken convention, blessing card gating ia-sync,
scope-build laws: aliases-only keyboard / bodies-in-engine / `_<scope>_help` / scope README)
with migration-before-palette ordering (archive corpus = test data).

## 2026-08-27 — the vault is born (session `o-rep.atl-fab.ccard`, atlas-ui + majkee)

**What existed before:** two diverging `cold-start-card` skills. Claude mailed loose
4-field cards to `~/reposoma/_mail/monkey/inbox/` (volatile, cascade-addressed, "never
absolute"). Codex preferred project-local `.dev/session/` beds with a heavy nested
`codex-cold-start/v1` schema. 23 legacy `CS.*` cards sat mixed into mail noise across
many projects.

**Decisions (majkee gaveled, sequential turns):**

1. **One global vault** `~/reposoma/_cold-start/{card,routines,archive}/` — NOT
   per-project. Reason: cross-project operations (reposoma+ERCs+freya) are the common
   case; a split vault fragments exactly the glue it exists to hold. A stray
   `<project-root>/` line in an early tree sketch was copy-mess, explicitly retracted.
2. **Git-tracked.** Reason: `git pull` is the office↔home transport (journaled lane
   discipline, 2026-08-01); a gitignored card is stranded on one box.
3. **Folder = state; no `status:` key in card frontmatter.** Reason: a field and a
   location WILL drift; mail's inbox/archive precedent already proved folder-as-state.
4. **Three states:** `card/` (live process glue) · `routines/` (recurring, never
   archived — added because routine tasks need standing glue that a drain cycle would
   keep killing) · `archive/` (read).
5. **Prefixes `CS.` dated / `RT.` dateless**, but `kind:` in frontmatter is machine
   truth. Reason: a card that travels (grep hit, chat paste, archive) loses folder
   context — the prefix is the surviving self-identification; dateless routines because
   a date on a recurring artifact lies.
6. **Whole `~`-anchored paths** (`~/path/to/target`), never bare-relative, never literal
   `/home/hruzam`. Reason: self-locating on both hosts, survives a username change,
   greppable. This consciously REVERSES the old Claude-skill rule "root via cascade,
   never absolute" — the cascade remains only for resolving the vault itself.
7. **Frontmatter = source of truth**, flat shared cross-brand contract; Codex appends
   its evidence keys BELOW the shared block. Reason: palette brick D2 renders raw
   frontmatter; flat keys render, nested ones don't; plain text + YAML is the
   brand-neutral intersection (Claude tested many times; Codex smoke-test pending —
   majkee runs write/read).
8. **Routing assessment keys** `model:` (fable|opus|sonnet|haiku / sol|terra…) +
   `dedicated:` + `recommend:`. Reason: the author knows what caliber the continuation
   deserves; the human should see it before launching anything.
9. **Prompt grammar adopted from runbooks** (`## prompt-0` → `###### prompt` →
   ```` ```text ```` fence — shape source: `~/reposoma/GEMINI.md` §4 +
   `~/reposoma/_runbook/termbrana/termbrana-readme/RUNBOOK.md`). Reason: cards and
   RUNBOOK.md files cross-feed (runbooks already copy CS cards into `raw/`); one grammar
   lets prompt blocks lift verbatim and lets one revealer script serve both.
10. **No registry machine.** majkee asked whether a central link/registry should absorb
    future placement changes; verdict: runtime indirection = the Rube Goldberg smell his
    pre-incarnations warned about. Instead: (a) GUIDE.md `## Wired surfaces` manifest —
    design-time checklist, grep-verifiable; (b) reuse `temple-project-map.zsh` so only
    the folder NAME is hardcoded anywhere, the reposoma location rides existing
    infrastructure.
11. **Guide-law conformance:** the law lives at `raw.guides/cold-start-card/GUIDE.md`
    (B′ single surface, fixed filename, manifest section); this `res/` chapter mirrors
    the runbook `res/` convention.

**Explorer, not editor (palette doctrine):** the palette compresses READING speed —
"human speed of writing and reading is unequal to yours" (majkee). No embedded editor
subservice; keybinds hand off to `$EDITOR`. Rejected: nano-in-palette (Rube Goldberg
valve).

---

## Known stale surfaces (not this stream's writers)

- `~/reposoma/GEMINI.md` §"from where I can download cold-start cards" → still names
  the monkey inbox; Proxima/majkee repoint to `~/reposoma/_cold-start/card/`.
- `~/reposoma/_runbook/README.md` → points to `raw.guides/runbook/GUIDE.md` which does
  not exist yet on this machine (runbook guide canonicalization = other session's work);
  when it lands, cross-point it with `cold-start-card/GUIDE.md` (one line each).
- `raw.guides/status/GUIDE.md` → expected from the other session; reconcile this file's
  shape to it on arrival (note at top).
- Codex smoke test (write + read one card) — majkee runs it; record findings HERE.
