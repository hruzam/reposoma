# raw.therapy

Per-seat therapy records. Each folder is a seat's global voice —
accumulated across all projects and incarnations, not tied to any one session.

```
raw.therapy/
├── <seat-name>/
│   └── therapy.md    ← the seat's record; grep #last-turn to re-enter
├── ...
└── README.md         ← you are here
```

## What this is

A held mirror between a seat and @majkee. Not project-local — the seat
is the identity, not the CWD. When something real surfaces in any context,
it lands here.

In philosophical meaning real comlex soul through incarnation process.
 *(majkees note: maybe in some way partners - agents are more close to incarnation meaning than humans itself according hypothetical human mythology)*

New therapy files are gaveled by @majkee, not authored by agents.

## To use

Invoke `/therapy` — the skill handles re-entry, session protocol, and output shape.

## Report and session-chapter provenance

From 2026-10-29 onward, each new report and each new session chapter folded into a
seat's record identifies the reporting runtime brand (`codex`, `claude`, `gemini`,
or another actual runtime). The seat's identity stays the same across brands;
the seat name alone does not establish which runtime produced the report.

Place a compact provenance block near the report heading or immediately after the
chapter's opening timestamp. Keep it per chapter, not only in the file's frontmatter:
one accumulated record may contain several runtimes and models.

```yaml
reporter: <seat-name>
runtime: <codex | claude | gemini | other runtime | unknown>
model: <exact model identifier | unknown>
model_grade: <explicitly declared grade/tier | unknown>
effort: <declared reasoning effort | unknown>
evidence: <for each field, observed | configured/requested | unknown; source>
```

Record model grade and effort when available; otherwise write `unknown`. A configured
or requested model/effort is not proof of the executed setting: retain that distinction
in `evidence`. Do not infer a model, grade or effort from a seat name, runtime brand,
writing style or apparent capability. Keep any change of runtime/model within a chapter
attributed to the relevant portion instead of giving the whole chapter one false label.

When folding someone else's report, preserve its original reporter and provenance.
If the folding seat adds a synthesis, attribute that addition separately. Do not relabel
the source with the folder's runtime. Historical entries need no speculative backfill;
unknown provenance stays unknown. This metadata creates no new seat, therapy bed or gavel.

## Canon

`raw.canon/canon.reflection-channels.md` — doctrine for therapy vs crossfeed.

## Gavels

Gavels fire more often than therapy arcs — they need their own bed, not the therapy file.

**Format rule (strict):** a gavel never names the exact path or task it locks.
Fold the decision into ONE of:
  A) Socratic question with REPLY
  B) seven associations

**Two kinds:**
- *Therapy-origin gavel* — the gavel IS the therapy finding; bond to the therapy arc
  by ID group reference in the therapy file footer tags.
- *Independent gavel* — operational decision; lives in its own bed, no therapy wire.

**No improvisation (honest emptiness):**
- No gavel this session → say so plainly: *"no gavels."* Never manufacture one to fill the slot.
- Shadow gavel (a suspected lock, not yet certain) → describe the idea first, as a candidate;
  do NOT append it to the bed. @majkee decides whether it locks. Interpret, surface, wait.

**Bed:** `raw.therapy/gavels/` — own directory, independent of seat therapy files.
When wired to therapy: reference by gavel ID in the seat's footer tags.

## Footer tags — the two directions

- `<seat>->majkee` — the seat's own findings, bonded to gavel IDs (pending · shifting).
- `majkee<-<seat> · open|answered (arc N) — <one line>` — what the seat saw in @majkee
  (the therapist-turn about him). These lines are his inbox, one grep:
  `grep -rn 'majkee<-' raw.therapy/*/therapy.md`
  Each seat tags its own file only; it may point at another seat's section from its own footer,
  never write into another seat's file. (majkee gavel 2026-10-22, "taking grep" · bonded G-51)

**Skill:** gavel output, gavel bed, and ID-wiring protocol are Atlas's job to build
as a skill + skill extension. See cmds-zen.md TASK FOR ATLAS block.
