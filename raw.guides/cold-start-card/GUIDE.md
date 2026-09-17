---
title: Cold-start card — session glue. Vault, schema, lifecycle, prompt grammar (Claude + Codex)
scope: cold-start-card
audience: agent + operator + builder
machine: both
verified: 2026-08-27
verify_cmd: "ls ~/reposoma/_cold-start/ && grep -rl '_cold-start' ~/ia-sync/claude/skills/cold-start-card ~/ia-sync/codex/skills/cold-start-card"
---

# Cold-start card — the session glue (+ the issue category)

> **Status legend for this family (read once):**
> - `[DRAFT]` — NOT in force. A proposal awaiting majkee's gavel; do not follow it as canon yet.
> - `[GAVELED · REVIEW-AFTER-USE]` (alias `[PROVISIONAL]`) — **In force: follow it as canon,
>   it is not a draft.** But it is new and unproven in real use, so it is flagged for re-audit
>   after its **first real use**, and adjustable then by the audit-always rule *without* a
>   fresh gavel ceremony. Not yet bedrock.
> - untagged — settled bedrock (e.g. the 2026-08-27 cold-start canon).
>
> **This restructure (2026-09-17, session `cs-card-sys-update`):** the single-file GUIDE was
> split into this thin signpost plus two subchapters — `res/cold-start-card.md` and
> `res/issue-card.md` — mirroring `raw.guides/runbook/GUIDE.md`'s Manifest shape. The
> CS-card/routine content relocated into `res/cold-start-card.md` is the 2026-08-27 gaveled
> canon, **relocated verbatim, not reworded** (audited word-for-word, @assay 7/7, 2026-09-17)
> — a meaning-preserving move, done, not gavel-gated. The issue-card category is
> **`[GAVELED · REVIEW-AFTER-USE]`** (majkee green-light 2026-09-17): flat `issues/` folder +
> a "fold to routines" lifecycle (three paths: known-recurring → routines/ directly ·
> one-shot → archive/ · recurred-after-all → archive/ → routines/); the old nested
> `issues/{open,parked,archive,reactions}` subtree and the `IR.<slug>.md` reaction-card type
> are DELETED from the design. Its first real use (a real issue card written + a real fold)
> is the trigger to re-audit. Both `issue-card` skills — Claude and Codex — are rebuilt to this
> flat model and cross-witnessed (@assay; the Codex rebuild is bus cycle 01, 2026-09-17). What
> remains for the session gate is operator-side only: the by-hand git and the fresh-session
> behavior proofs — not a design change to this file.

_The one law behind both `cold-start-card` skills (Claude + Codex) and the `_cold-start/`
vault. Gaveled by majkee 2026-08-27 (session `o-rep.atl-fab.ccard`); shape journal:
`res/journal.md`. Companions: `raw.guides/runbook/GUIDE.md` (session launcher) ·
`raw.guides/status/GUIDE.md` (the position) — the card is the TRANSFER pointer beside
them, never a second authority (boundary below). On conflict between this guide and any skill copy of the schema,
THIS GUIDE WINS. Inverse for tooling: once `cs-palette` / `temple-cs-manage` exist, their
script files are the behavior truth — on conflict about what a command DOES, the script
wins and this guide is the bug (trust-disk-over-doc, remote-control scar 2026-08-20)._

## What lives here, and where the detail is

- **CS card** — session glue, live → archive. **RT card** — recurring glue, born a routine
  or graduated from an issue. Full schema + lifecycle: `res/cold-start-card.md`.
- **Issue card** `[PROVISIONAL]` — a caught defect held as a fix manual, in a flat vault
  folder, with a three-path fold into `routines/` or `archive/`. Full schema + the fold
  mechanism: `res/issue-card.md`.
- **Re-entering**, either category: browse the vault (`cs-palette` once built, or
  `ls`/grep), read frontmatter first — it is the source of truth — then follow `resume:` /
  `prompt-0`.

| category | write via | detail lives at |
|---|---|---|
| cold-start (CS) + routine (RT) | `/cold-start-card` | `res/cold-start-card.md` |
| issue (ISS) `[PROVISIONAL]` | `/issue-card` | `res/issue-card.md` |

## The vault — one global bed, folder = state, flat categories

```
~/reposoma/_cold-start/
├── card/        # live process glue                        CS.<slug>.<YYYY-MM-DD>.md
├── routines/    # recurring glue, never archived            RT.<slug>.md
│                #   + graduated issues, ISS. name kept       ISS.<slug>.<YYYY-MM-DD>.md
├── issues/      # [PROVISIONAL] caught defects, flat        ISS.<slug>.<YYYY-MM-DD>.md
├── archive/     # drained CS cards + solved one-shot issues (shared, not category-private)
└── README.md    # 3-line pointer back to this guide
```

**One vault, flat categories.** Every category — cold-start, routine, issue — lives at the
SAME level of the vault; none owns a private state subtree underneath it. Folder still
carries state (`card/` → `archive/` for CS; `issues/` → `routines/` or `archive/` for
issues — the fold, `res/issue-card.md`), but that state lives in the top-level folder
choice, never in a nested subfolder or a `status:` field. `archive/` is shared: it holds
both drained CS cards and solved one-shot issues, distinguished by filename prefix
(`CS.*` / `ISS.*`), not by separate folders.

**Vault and issue locations move together:** cold-start's vault location
(`~/reposoma/_cold-start/`) and the issue category's location (`issues/` within it) are
coupled — any future reorganization of one moves the other with it in the same commit;
they are never relocated independently.

- **Git-tracked** in reposoma — `git pull` IS the office↔home transport. An uncommitted
  card does not exist on the other machine.
- **Folder carries the state** (like `_mail/` inbox/archive). No `status:` field —
  a field would drift from the location. Moves = state transitions
  (`temple-cs-manage` once built; plain `mv` until then).
- Routines never archive. Archive holds only consumed CS cards and solved one-shot issues.
- Vault location resolves via the cascade: `~/ia-sync/zsh/ai/temple-project-map.zsh`
  → reposoma root → `_cold-start/`. Only the folder name is baked into consumers;
  the map absorbs any future reposoma move.

## Filename law

| type | name | dated? | why |
|---|---|---|---|
| process card | `CS.<slug>.<YYYY-MM-DD>.md` | yes | a session moment |
| routine card, born | `RT.<slug>.md` | no | recurs — a date would lie |
| routine card, graduated `[PROVISIONAL]` | `ISS.<slug>.<YYYY-MM-DD>.md` (kept, not renamed) | yes | recurs now, but the date is kept as "first seen" |
| issue card `[PROVISIONAL]` | `ISS.<slug>.<YYYY-MM-DD>.md` | yes | a defect found at a moment; the date is the sort radar |

Prefixes are for the human eye and glob ergonomics (`CS.*` / `RT.*` / `ISS.*`). Machines never
parse filenames — `kind:` in frontmatter is the truth.

**[PROVISIONAL]** — Clarification: this law forbids inferring `kind:` from the filename; extracting the `YYYY-MM-DD` date substring from a filename for sort ordering is a distinct operation and does not violate it.

**[PROVISIONAL] Sort key — the durable radar.** Dated categories (cold-start-card,
issue-card) **sort by the filename `YYYY-MM-DD` date, primary.** A date in the name is
repository data that survives clone / checkout / host-move; filesystem mtime is only one
checkout's observational state and resets on any git operation — a different epistemic class.
The richer discriminators live in frontmatter (the manifest); the body is the payload. A
consumer narrows by filename/tags first, inspects metadata second, opens the body only after
candidate reduction. **UNSORTED fallback:** a dated card whose filename lacks the `YYYY-MM-DD`
marker is surfaced in an UNSORTED bucket, never silently mis-ordered (the drift-detector
pattern the claviature engine already uses). **Routines are dateless by design and are
exempt** — a missing date on an RT card is correct, not drift; a graduated `ISS.`-named
routine card is the one deliberate exception, and its date is read as "first seen," not sort
drift.

## Frontmatter — the source of truth (shared cross-brand contract)

Flat keys, brand-neutral. Every path is **whole and `~`-anchored** (`~/path/to/target`) —
never bare-relative, never `/home/<user>` literal. `~` = `/home/hruzam` on both hosts. Skip
keys that are genuinely empty; never invent values.

Each category's field-by-field schema is a subchapter, not repeated here: cold-start + routine
→ `res/cold-start-card.md`; issue → `res/issue-card.md`.

- **Codex extras:** Codex cards of any category MAY append additional evidence keys BELOW
  the shared block (session_id, rollout, worktree state, authority/gates…). Shared keys
  always come first; tooling parses only the shared contract.

## Master prompt — the prompt grammar (shared with runbooks)

If the card carries a ready-to-fire prompt for the next session, use EXACTLY the
runbook grammar so blocks lift verbatim between cards and `RUNBOOK.md` files, and the
palette (brick D3) can reveal them without opening the card:

```markdown
## prompt-0

###### prompt

​```text
<the master prompt / command cascade for the next session>
​```
```

`prompt-0` = master; `prompt-<N>` = follow-ups in order. Optional — most cards need
only `resume:`.

## Wired surfaces — migration manifest (the anti-Rube-Goldberg discipline)

Every file that embeds the vault path or this schema. **Whoever wires a new consumer
adds a line here.** On any future migration this list is the checklist;
`grep -r "_cold-start"` is the independent verifier.

| surface | what it embeds |
|---|---|
| `~/ia-sync/claude/skills/cold-start-card/SKILL.md` | destination + schema pointer to `res/cold-start-card.md` |
| `~/ia-sync/codex/skills/cold-start-card/SKILL.md` | destination + schema copy |
| `~/ia-sync/claude/skills/issue-card/SKILL.md` `[PROVISIONAL]` | flat-issues destination + schema pointer to `res/issue-card.md` |
| `~/ia-sync/codex/skills/issue-card/SKILL.md` `[PROVISIONAL]` | Codex-native flat-issues destination; rebuilt to the flat model by @Cartan + witnessed (@assay, bus cycle 01, 2026-09-17) |
| `~/reposoma/_cold-start/issues/README.md` `[PROVISIONAL]` | pointer back to this guide |
| `~/reposoma/_cold-start/README.md` | pointer back to this guide |
| `~/reposoma/GEMINI.md` §"Cold-start cards" | verified 2026-09-17 — repointed to `_cold-start/card/CS.<scope>.<date>.md`; no `_mail/monkey/inbox` reference remains |
| `cs-palette.zsh` / `cs-palette.py` (`~/ia-sync/zsh/ai/`) | vault path (via `temple-project-root reposoma`) + shared frontmatter keys + prompt grammar |
| `temple-cs-manage.zsh` / `cs-manage-palette.py` (`~/ia-sync/zsh/ai/`) | vault path (via `temple-project-root reposoma`) + folder states (not yet updated for the flat-model fold) |
| `cs_vault.py` (`~/ia-sync/zsh/ai/`) | shared read-only frontmatter/prompt-block parser used by both above |

## Manifest

- `res/cold-start-card.md` · chapter — CS-card + routine detail: field-by-field schema, the
  drain lifecycle, the two routine origins (`intended` / graduated `issue`), the one-authority
  boundary with STATUS/RUNBOOK, the Codex brand note. Gaveled content, relocated verbatim.
- `res/issue-card.md` · chapter · `[PROVISIONAL]` — issue-card detail: the flat vault shape,
  ISS frontmatter incl. `origin:`, the three-path fold to `routines:`/`archive:`, parked-as-
  assoc-tag, the fix-manual body framing.
- `res/journal.md` — chapter/journal — developing-shape record: dated, reasoned deltas
  (why each piece of the shape exists). Pending actionable work lives in the vault:
  `~/reposoma/_cold-start/card/CS.cold-start-phase2.2026-08-28.md`.
- `res/STATUS.md` — legacy — tombstone (name canon-reserved by `raw.guides/status/`,
  renamed to journal.md 2026-08-28), pending `git rm`; do not follow.
- `res/HANDOFF.md` — legacy — tombstone (name canon-retired, content → journal.md +
  the Phase-2 card), pending `git rm`; do not follow.
