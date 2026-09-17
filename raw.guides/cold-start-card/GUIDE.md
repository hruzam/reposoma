---
title: Cold-start card — session glue. Vault, schema, lifecycle, prompt grammar (Claude + Codex)
scope: cold-start-card
audience: agent + operator + builder
machine: both
verified: 2026-08-27
verify_cmd: "ls ~/reposoma/_cold-start/ && grep -rl '_cold-start' ~/ia-sync/claude/skills/cold-start-card ~/ia-sync/codex/skills/cold-start-card"
---

# Cold-start card — the session glue (+ the issue category)

> **DRAFT — issue-category extension pending majkee's gavel (2026-09-17, session
> `cs-card-sys-update`, phase 1 @atlas-ui).** Every block tagged `[ISSUE-DRAFT]` below adds
> the `issue-card` category to this family (same vault, new state subtree). The GUIDE is
> reposoma canon — these additions are drafted, NOT self-gaveled. Until majkee gavels, the
> pre-existing cold-start law stands unchanged and the `[ISSUE-DRAFT]` blocks are proposals.
> The open design call carried here (issue subtree vs shared state folders; sort by filename
> date) is @atlas-ui's DRAFT RECOMMENDATION, not a lock — see phase-1 return report.

_The one law behind both `cold-start-card` skills (Claude + Codex) and the `_cold-start/`
vault. Gaveled by majkee 2026-08-27 (session `o-rep.atl-fab.ccard`); shape journal:
`res/journal.md`. Companions: `raw.guides/runbook/GUIDE.md` (session launcher) ·
`raw.guides/status/GUIDE.md` (the position) — the card is the TRANSFER pointer beside
them, never a second authority (boundary below). On conflict between this guide and any skill copy of the schema,
THIS GUIDE WINS. Inverse for tooling: once `cs-palette` / `temple-cs-manage` exist, their
script files are the behavior truth — on conflict about what a command DOES, the script
wins and this guide is the bug (trust-disk-over-doc, remote-control scar 2026-08-20)._

## When do I reach for this, and what do I type

- **Closing or pausing a session** that a later session (any brand, any host) must
  re-enter → write a **CS card** into the vault via your brand's `cold-start-card` skill.
- **Capturing a recurring task's glue** (routine you re-run, never "finished") → write an
  **RT card** into `routines/`.
- **Re-entering** → browse the vault (`cs-palette` once built, or `ls`/grep), read
  frontmatter first — it is the source of truth — then follow `resume:` / `prompt-0`.

## The vault — one global bed, folder = state

```
~/reposoma/_cold-start/
├── card/        # live process glue           CS.<slug>.<YYYY-MM-DD>.md
├── routines/    # recurring glue, never archived   RT.<slug>.md
├── archive/     # read / drained CS cards
├── issues/      # [ISSUE-DRAFT] known-defect category — its own state subtree
│   ├── open/       #   flagged, not yet triaged        ISS.<slug>.<YYYY-MM-DD>.md
│   ├── parked/     #   triaged, deliberately deferred
│   ├── archive/    #   resolved
│   └── reactions/  #   [ISSUE-DRAFT] playbook for recurrent defect patterns   IR.<slug>.md
└── README.md    # 3-line pointer back to this guide
```

**[ISSUE-DRAFT] — one vault, categories inside it.** The vault holds card *categories*,
and each category's folders encode ITS lifecycle. Cold-start's states (`card/` live →
`archive/` drained) and routines (a stateless category, never archived) already coexist at
root. The **issue** category has a different state machine — open → parked → resolved — so it
gets its own subtree (`issues/{open,parked,archive,reactions}`) rather than mixing into the root. This
keeps "folder = state" clean (a top-level shared `archive/` would conflate drained CS cards
with resolved issues) and keeps the addition purely additive — the existing cold-start folders
and every wired surface that embeds `card/` are untouched. Same mechanism throughout: shared
frontmatter contract, filename law, git-pull transport, point-never-copy; only the category
and its state folders differ. Written by the `/issue-card` skill (sibling of `cold-start-card`).

**[ISSUE-DRAFT] Vault and issue locations move together:** cold-start's vault location (`~/reposoma/_cold-start/`) and issue's vault location (the `issues/` subtree within it) are coupled — any future reorganization of one moves the other with it in the same commit; they are never relocated independently.

- **Git-tracked** in reposoma — `git pull` IS the office↔home transport. An uncommitted
  card does not exist on the other machine.
- **Folder carries the state** (like `_mail/` inbox/archive). No `status:` field —
  a field would drift from the location. Moves = state transitions
  (`temple-cs-manage` once built; plain `mv` until then).
- Routines never archive. Archive holds only consumed CS cards.
- Vault location resolves via the cascade: `~/ia-sync/zsh/ai/temple-project-map.zsh`
  → reposoma root → `_cold-start/`. Only the folder name is baked into consumers;
  the map absorbs any future reposoma move.

## Filename law

| type | name | dated? | why |
|---|---|---|---|
| process card | `CS.<slug>.<YYYY-MM-DD>.md` | yes | a session moment |
| routine card | `RT.<slug>.md` | no | recurs — a date would lie |
| issue card `[ISSUE-DRAFT]` | `ISS.<slug>.<YYYY-MM-DD>.md` | yes | a defect found at a moment; the date is the sort radar |
| issue reaction `[ISSUE-DRAFT]` | `IR.<slug>.md` | no | a defect pattern class — recurs |

Prefixes are for the human eye and glob ergonomics (`CS.*` / `RT.*` / `ISS.*`). Machines never
parse filenames — `kind:` in frontmatter is the truth.

**[ISSUE-DRAFT]** — Clarification: this law forbids inferring `kind:` from the filename; extracting the `YYYY-MM-DD` date substring from a filename for sort ordering is a distinct operation and does not violate it.

**[ISSUE-DRAFT] Sort key — the durable radar.** Dated categories (cold-start-card,
issue-card) **sort by the filename `YYYY-MM-DD` date, primary.** A date in the name is
repository data that survives clone / checkout / host-move; filesystem mtime is only one
checkout's observational state and resets on any git operation — a different epistemic class.
The richer discriminators live in frontmatter (the manifest); the body is the payload. A
consumer narrows by filename/tags first, inspects metadata second, opens the body only after
candidate reduction. **UNSORTED fallback:** a dated card whose filename lacks the `YYYY-MM-DD`
marker is surfaced in an UNSORTED bucket, never silently mis-ordered (the drift-detector
pattern the claviature engine already uses). **Routines are dateless by design and are
exempt** — a missing date on an RT card is correct, not drift.

## Frontmatter — the source of truth (shared cross-brand contract)

Flat keys, brand-neutral. Every path is **whole and `~`-anchored** (`~/path/to/target`) —
never bare-relative, never `/home/<user>` literal. `~` = `/home/hruzam` on both hosts.

```yaml
---
kind: cold-start-card            # cold-start-card | routine
date: 2026-08-27
brand: claude                    # claude | codex
seat: atlas-ui                   # card author (seat/agent name)
project: freya                   # origin project — registry key (temple-project-map)
projects: [freya, reposoma]      # optional — cross-project runs name the whole span
root: ~/www/elements-factory/freya   # project root, whole path
commit: abc1234 (core)           # short hash (branch)
task: <one line>
resume: <command + flags>        # e.g. claude --agent atlas-ui → /cold-start-card
model: sonnet                    # thinking level the task deserves:
                                 #   claude: fable | opus | sonnet | haiku
                                 #   codex:  sol | terra | ...
dedicated: <seat/agent the author recommends for the next incarnation>
recommend: <author's one-line steer>
runbook: ~/<project>/<session-root>/<program>-<NN>-<phase>/RUNBOOK.md   # optional —
                                 # point to the LIVE session RUNBOOK; the _runbook/
                                 # bench copy is a draft/template after promotion
pointers:                        # where depth lives — point, never copy
  - ~/reposoma/pulse.atlas.md
---
```

- Skip keys that are genuinely empty; never invent values.
- `model` + `dedicated` + `recommend` = the author's routing assessment — the human reads
  these in the palette (brick D2) before launching anything.
- **Codex extras:** Codex cards MAY append additional evidence keys BELOW the shared
  block (session_id, rollout, worktree state, authority/gates…). Shared keys always come
  first; tooling parses only the shared contract.

### [ISSUE-DRAFT] Issue-card frontmatter — the category delta

An issue card carries the same flat, `~`-anchored contract, `kind: issue-card`, with three
category-specific keys and a required association list:

```yaml
---
kind: issue-card
date: 2026-09-16                 # also the filename date — the sort radar
brand: claude
found_by: trajectory             # issue-domain author key (the finder)
project: ia-sync                 # which repo/component owns the defect (filter key)
root: ~/ia-sync
where: ~/ia-sync/zsh/system/tailscale.zsh (_ts_mount)   # the broken surface, whole path
defect: <ONE sentence describing the defect>            # the one-sentence description
assoc: [tailscale, sshfs, mount, race, daemon-guard, home, D-state]   # >=7 discriminators
severity: med                    # optional
pointers:
  - ~/<deeper trail — journal entry, related commit, sibling card>
---
```

- **`defect:` is the one-sentence description** — a reader filters on it without opening the
  body. **`assoc:` is the >=7 association tags** — the "know, not said" discriminators
  (class · tech · subsystem · host · symptom · area · severity) an agent greps to narrow
  candidates without a body read. Put the strongest one or two into the slug (radar); the
  rest live in `assoc:` (manifest). Both encodings serve the same purpose on different
  surfaces — filename for zero-read matching, frontmatter for cheap metadata scan.
- **No `status:` field** — the `issues/{open,parked,archive}` folder carries the state; a
  triage or a fix is a `mv` between them.

### [ISSUE-DRAFT] Issue-reaction frontmatter — the dateless delta

A reaction card captures a known **pattern** of defect and its **playbook** response. Unlike
issue cards (which describe a single dated defect instance), reaction cards are dateless,
permanent, and recur. It carries the same flat, `~`-anchored contract, `kind: issue-reaction`,
with pattern-and-playbook keys replacing the instance keys:

```yaml
---
kind: issue-reaction
brand: claude
found_by: <seat/agent>                 # reaction-domain author key
project: <origin registry key>         # which repo/component owns the pattern
root: ~/<whole path to project root>
pattern: <ONE sentence describing the defect pattern>  # the pattern class
playbook: <how to respond when you hit this pattern>   # the response playbook
assoc: [<tag>, <tag>, <tag>, <tag>, <tag>, <tag>, <tag>]   # >=7 discriminators
pointers:
  - ~/<where related instance cards or deeper trail live>
---
```

- **`pattern:` is the one-sentence description** — a reader identifies the pattern without
  opening the body. **`playbook:` is the response** — when an instance of this pattern
  appears, this is how to react.
- **`assoc:` is >=7 association tags** — the "know, not said" discriminators (class · tech ·
  subsystem · host · symptom · area · severity), same as issue cards. An agent greps these to
  surface candidate reactions without a body read. No `date:` field, no archive — reaction
  cards are dateless and permanent, like routines. Filename is `IR.<slug>.md` (dateless).

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

## Body — the continuity layer

Free prose after the frontmatter. The card alone may be tiny, but **card + its pointers
must be sufficient**. Add whichever apply: pending tasks (order matters) · state
pointers (dev-journals, pulse entries, staged files) · first-step instruction · session
advice (one lesson) · cleanup/hygiene debts. Point, never copy.

## One authority — boundary with the session beds (STATUS/RUNBOOK canon)

The 2026-08-27 canon's motivating failure was a bed where `status.md`, `pulse.md`, and a
**CS card** each claimed the next action — *"two files are allowed, two authorities are
not"* (`raw.guides/runbook/GUIDE.md`). The law for cards:

- **A cold-start card is a transfer/closure POINTER, never a second doing-state.**
- If a live session bed exists (a `STATUS.md` for an open gate): the card names the bed
  in `pointers:`, and `resume:`/`prompt-0` re-enter it — **the card carries NO competing
  next-action order; STATUS owns the position.**
- A card may carry its own next-action/repair-queue only when NO live bed exists —
  session closed clean, or glue for work that has no runbook.
- Seam test on every body line: would it still be true after the gate closes? → it
  belongs in flag/pulse/guide, not the card. Does it die with the gate? → it belongs in
  the bed's STATUS, not the card. The card holds what OUTLIVES the session but serves
  re-entry: pointers, resume, routing assessment, lessons.

## Lifecycle

1. **Write** — author fills the contract from the live session, shows majkee (interactive
   seats confirm before writing; see each skill).
2. **Read** — next incarnation reads frontmatter → pointers → body → fires `resume:` /
   `prompt-0`.
3. **Drain** — the reader who consumed a CS card moves it `card/` → `archive/`
   (Cinderella). A card meant for more readers carries `leave: for more readers` and
   stays until all have drained it. RT cards never move.
4. **[ISSUE-DRAFT] Triage** — an issue card lives in `issues/open/` until triaged, then
   `mv`s to `issues/parked/` (deferred, operator call) or straight to a fix; a resolved
   issue `mv`s to `issues/archive/`. Folder is the state; there is no `status:` field.

## Brand note — Codex (read this as contract, not culture)

- Destination: `~/reposoma/_cold-start/card/` (expand `~` to the user home; both hosts
  resolve to `/home/hruzam`). Routines: `~/reposoma/_cold-start/routines/`.
- Write the shared frontmatter block first, exactly as specified above. Append
  Codex-specific evidence keys after it. Do not nest the shared keys.
- Keep claims distinguishable as observed / reported / inferred in the body.
- Do not stage or commit the card implicitly; report the created path. Committing
  reposoma is the operator's or an authorized seat's action — but note the card is
  invisible cross-machine until committed.
- A rollout JSONL is a track file: point to it, never copy transcript content.

## Wired surfaces — migration manifest (the anti-Rube-Goldberg discipline)

Every file that embeds the vault path or this schema. **Whoever wires a new consumer
adds a line here.** On any future migration this list is the checklist;
`grep -r "_cold-start"` is the independent verifier.

| surface | what it embeds |
|---|---|
| `~/ia-sync/claude/skills/cold-start-card/SKILL.md` | destination + schema copy |
| `~/ia-sync/codex/skills/cold-start-card/SKILL.md` | destination + schema copy |
| `~/ia-sync/claude/skills/issue-card/SKILL.md` `[ISSUE-DRAFT]` | issue subtree + issue schema copy |
| `~/ia-sync/codex/skills/issue-card/SKILL.md` `[ISSUE-DRAFT]` | (phase 2 — Codex-native, @Cartan over the tunnel) |
| `~/reposoma/_cold-start/issues/README.md` `[ISSUE-DRAFT]` | pointer back to this guide |
| `~/reposoma/_cold-start/README.md` | pointer back to this guide |
| `~/reposoma/GEMINI.md` §"Cold-start cards" | verified 2026-09-17 — repointed to `_cold-start/card/CS.<scope>.<date>.md`; no `_mail/monkey/inbox` reference remains |
| `cs-palette.zsh` / `cs-palette.py` (`~/ia-sync/zsh/ai/`) | vault path (via `temple-project-root reposoma`) + shared frontmatter keys + prompt grammar |
| `temple-cs-manage.zsh` / `cs-manage-palette.py` (`~/ia-sync/zsh/ai/`) | vault path (via `temple-project-root reposoma`) + folder states |
| `cs_vault.py` (`~/ia-sync/zsh/ai/`) | shared read-only frontmatter/prompt-block parser used by both above |

## Manifest

- `res/journal.md` — chapter/journal — developing-shape record: dated, reasoned deltas
  (why each piece of the shape exists). Pending actionable work lives in the vault:
  `~/reposoma/_cold-start/card/CS.cold-start-phase2.2026-08-28.md`.
- `res/STATUS.md` — legacy — tombstone (name canon-reserved by `raw.guides/status/`,
  renamed to journal.md 2026-08-28), pending `git rm`; do not follow.
- `res/HANDOFF.md` — legacy — tombstone (name canon-retired, content → journal.md +
  the Phase-2 card), pending `git rm`; do not follow.
