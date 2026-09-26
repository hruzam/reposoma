# .majkee — the operator's personal harness (SHM)

Majkee's own corner of the temple, tracked like `.claude/` is Claude's harness.
Not canon, not a project — the human's working scratch, synced cross-machine via git.

## Contents
- `journal/<YYYY-MM-DD>.md` — the day scratchpad / day square: what I did · where I wrote
  what · what's still pending. Loose by design (no rigid schema). Maintained by whichever seat
  is asked, per `AGENTS.md` beside this file (verbs `fold` · `pending` · `audit`). Ptyra is
  released from journal duty (2026-09-25); the retired hand `@ptyra-ac-journal` is gone.
- `AGENTS.md` — the seat instruction for this folder (read it before writing here).

## Day-square rules — trial from 2026-09-25 (uncanonical; earns its place or stops)

The day file is majkee's **cross-bed re-entry square**: what he does next, across every bed
touched today, at his reading speed. It fills one gap only — STATUS holds one gate, `pulse.md`
routes, nothing held "all of today for the operator". It never becomes a second authority.

Shape (heads write their own chapter; majkee writes his):
```
---
session : `<session-name>` (<runtime · seat · carriage>)      ← one scope block per writer
---
# N. <topic> — <one line> (bed: `<absolute bed path>`, head: <seat>)
- [x] done thing · <evidence: commit / receipt / STATUS edge>
- [ ] next thing · <where the exact line lives — usually "STATUS has it">
**Continue here:** <one sentence — the first action on re-entry>
```

Three rules:
1. **Point, never restate.** A `[ ]` names the step and the file; the command itself lives in the
   bed's STATUS. If a journal line and STATUS ever disagree, STATUS wins and the journal line is
   the bug (the Termbrana-02 failure: three files, three re-entry orders).
2. **Own chapter, own voice.** A head writes only under its own `---` scope block and never edits
   another head's chapter — that is how the second team stays visible instead of overwritten.
3. **Tick from evidence.** `[x]` needs a commit, a receipt, or a STATUS edge behind it. An
   intention in a checkbox is a lie with a border.

Earns its place if, over ~2 weeks: re-entry is faster (minutes to first correct action) and at
least one cross-team overlap was caught before it bit (2026-09-25: a whole-table deploy would have
shipped another seat's brick unannounced — the note caught it). Then: one short chapter in
`raw.guides/runbook/` beside PAD — not a tool. If not: it stops; nothing else depends on it.
The `audit` verb (journal `[ ]` vs each bed's STATUS `next:`/`checkpoint:` — debts, false ticks,
competing next; never ticks) is performed by hand by any seat, per `AGENTS.md`.

## Note
Tracked means every entry syncs to the other machine and lives in git history.
Keep secrets / tokens OUT of journal entries — env vars only, never inline (temple rule).
