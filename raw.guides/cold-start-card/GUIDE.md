---
title: Cold-start card — session glue. Vault, schema, lifecycle, prompt grammar (Claude + Codex)
scope: cold-start-card
audience: agent + operator + builder
machine: both
verified: 2026-08-27
verify_cmd: "ls ~/reposoma/_cold-start/ && grep -rl '_cold-start' ~/ia-sync/claude/skills/cold-start-card ~/ia-sync/codex/skills/cold-start-card"
---

# Cold-start card — the session glue

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
└── README.md    # 3-line pointer back to this guide
```

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

Prefixes are for the human eye and glob ergonomics (`CS.*` / `RT.*`). Machines never
parse filenames — `kind:` in frontmatter is the truth.

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
| `~/reposoma/_cold-start/README.md` | pointer back to this guide |
| `~/reposoma/GEMINI.md` §"from where I can download cold-start cards" | ⚠ STALE — still names `~/reposoma/_mail/monkey/inbox`; Proxima/majkee repoint |
| `cs-palette` (planned, `~/ia-sync/zsh/ai/`) | vault path + shared frontmatter keys + prompt grammar |
| `temple-cs-manage` (planned, `~/ia-sync/zsh/ai/`) | vault path + folder states |

## Manifest

- `res/journal.md` — chapter/journal — developing-shape record: dated, reasoned deltas
  (why each piece of the shape exists). Pending actionable work lives in the vault:
  `~/reposoma/_cold-start/card/CS.cold-start-phase2.2026-08-28.md`.
- `res/STATUS.md` — legacy — tombstone (name canon-reserved by `raw.guides/status/`,
  renamed to journal.md 2026-08-28), pending `git rm`; do not follow.
- `res/HANDOFF.md` — legacy — tombstone (name canon-retired, content → journal.md +
  the Phase-2 card), pending `git rm`; do not follow.
