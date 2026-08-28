---
title: Cold-start card — developing-shape journal (chronological; why each decision was made)
chapter-of: cold-start-card
---

# journal — how this shape grew

Newest on top. One dated entry per shape change: what changed, WHY (the reason is the
payload — brand-agnostic, so any future Claude/Codex/Gemini incarnation understands the
decision, not just the delta).

**This is a chronological journal — deliberately NOT a `STATUS.md`.** That name is
reserved canon (`raw.guides/status/GUIDE.md`): a present-tense bounded recovery snapshot
that dies with its session gate. This file is the opposite tense: durable history.
Pending actionable work lives in the vault:
`~/reposoma/_cold-start/card/CS.cold-start-phase2.2026-08-28.md`.

---

## 2026-08-28 (third pass) — Phase-2 SHIPPED: cs-palette + temple-cs-manage built, blessed all-pass

Trajectory built the zsh pair on the surgical table per the first-citizen card:
`cs-palette.{zsh,py}` (D1/D2/D3 explorer, archive toggle, Enter-prints-resume) ·
`temple-cs-manage.zsh` + `cs-manage-palette.py` (three-state mover, mv-only) ·
shared `cs_vault.py` parser · house wiring (keyboard P9 / claude.zsh help / keys.zsh
`cs` family). Root via `temple-project-root reposoma` — only `_cold-start` baked (the
no-registry verdict held in code). Legacy 22-card corpus served as the degradation test
(D2 renders `— no frontmatter (legacy) —`). Build bug caught: zsh `local f`
re-declaration inside a multi-loop function leaks values to stdout — fixed by matching
the reference implementation. **Blessing card 14 checks: ALL PASS (majkee, 2026-08-28)**
→ gate open, deploy released. First-citizen card drained to `archive/` — the system's
first complete lifecycle (write → brief a build → reveal its own prompt-0 in D3 → drain)
ran on itself. Wired-surfaces rows in GUIDE.md updated from planned → built.



The other session's gaveled guides arrived (`raw.guides/status/GUIDE.md` ·
`runbook/GUIDE.md` · `bus/GUIDE.md`, triangulated Fable · Janus · @Cartan, majkee gavel
2026-08-27). Consequences for this stream:

1. **`res/STATUS.md` renamed → `res/journal.md`** (this file). The canon reserves
   `STATUS.md` for the per-gate recovery snapshot and its Replacement law states it is
   "not a chronological journal" — which is exactly what this file is. Both prior names
   (`HANDOFF.md`, `STATUS.md`) are now tombstones pending `git rm`; content fully
   harvested here.
2. **One-authority boundary added to GUIDE.md.** The canon's motivating failure was a
   Termbrana bed where `status.md`, `pulse.md`, and a **CS card** each claimed the next
   action — "two files are allowed, two authorities are not." Law absorbed: a cold-start
   card is a transfer/closure POINTER. When a live session bed exists, the card points
   to its `STATUS.md` and carries NO competing next-action order; `resume:`/`prompt-0`
   re-enter the bed, STATUS owns the position. A card may carry its own next-action only
   when no live bed exists (session closed clean, or glue for work with no runbook).
3. **`runbook:` key semantics sharpened:** point to the LIVE session RUNBOOK
   (`<project>/<session-root>/<program>-<NN>-<phase>/RUNBOOK.md`); the `_runbook/` bench
   copy is a draft/template after promotion, not a state store.
4. **Prompt-grammar provenance upgraded:** the grammar's canonical source is now
   `raw.guides/runbook/GUIDE.md` (GEMINI.md §4 was the interim source and is now doubly
   stale — it still carries a RUNBOOK `state:` field the canon removed; Proxima's file,
   flagged, not edited by this stream).

## 2026-08-28 — HANDOFF renamed (first attempt: STATUS); Phase-2 spec dogfooded into the vault

majkee's doubt confirmed a semantic wobble: in the world this guide built, "handoff" IS
the cold-start card — a journal file named HANDOFF.md muddied the vocabulary (the canon
independently retired the HANDOFF filename before first use). The Phase-2 build spec it
carried was session glue, not journal — moved into the vault's FIRST CITIZEN card,
`CS.cold-start-phase2.2026-08-28.md`, which doubles as the Claude-side write smoke test
and the D3-reveal test fixture (it carries a `prompt-0`). Clean roles: guide = law ·
journal = why · card = what's next. (The intermediate name STATUS.md lasted one turn —
superseded by the canon the same day; see entry above.)

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
   (Independently confirmed by the 2026-08-27 canon: RUNBOOK dropped its `state:` field
   for the same reason — "a mutable field in a read-once file is a second state surface.")
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
   ```` ```text ```` fence). Reason: cards and RUNBOOK.md files cross-feed; one grammar
   lets prompt blocks lift verbatim and lets one revealer script serve both.
   (Provenance upgraded 2026-08-28: canonical source = `raw.guides/runbook/GUIDE.md`.)
10. **No registry machine.** majkee asked whether a central link/registry should absorb
    future placement changes; verdict: runtime indirection = the Rube Goldberg smell his
    pre-incarnations warned about. Instead: (a) GUIDE.md `## Wired surfaces` manifest —
    design-time checklist, grep-verifiable; (b) reuse `temple-project-map.zsh` so only
    the folder NAME is hardcoded anywhere, the reposoma location rides existing
    infrastructure.
11. **Guide-law conformance:** the law lives at `raw.guides/cold-start-card/GUIDE.md`
    (B′ single surface, fixed filename, manifest section); this `res/` chapter mirrors
    the runbook-bench `res/` convention.

**Explorer, not editor (palette doctrine):** the palette compresses READING speed —
"human speed of writing and reading is unequal to yours" (majkee). No embedded editor
subservice; keybinds hand off to `$EDITOR`. Rejected: nano-in-palette (Rube Goldberg
valve).

---

## Known stale surfaces (not this stream's writers)

- `~/reposoma/GEMINI.md` §"from where I can download cold-start cards" → still names
  the monkey inbox; §4 still shows a RUNBOOK `state:` field the canon removed.
  Proxima/majkee repoint/refresh.
- `~/reposoma/_runbook/README.md` → its guide pointer now resolves (runbook canon
  landed); cross-pointing cold-start-card ↔ runbook guides (one line each) still open —
  runbook guide's side is not this stream's write.
- Tombstones pending `git rm`: `res/HANDOFF.md` · `res/STATUS.md`.
- Codex smoke test (write + read one card) — majkee runs it; record findings HERE.
