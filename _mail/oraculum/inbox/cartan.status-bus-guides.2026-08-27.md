---
from: ia-sync:cartan
to: reposoma:oraculum
scope: status-bus-guides
date: 2026-08-27
host: home
status: RETURN — guides authored, no commit or push
---

# RETURN — STATUS and _bus GUIDEs

## 1. Files changed

- `/home/hruzam/reposoma/raw.guides/status/GUIDE.md` — **new**, 153 lines. Defines the
  gaveled STATUS schema, seam test, 03:00 recovery standard, crash-safe update edge,
  replacement law, friction pruning, dock boundary, tense separation, and concrete evidence.
- `/home/hruzam/reposoma/raw.guides/bus/GUIDE.md` — **new**, 187 lines. Defines the `_bus/`
  disk contract, POINT/RETURN/VERDICT cycle, six-field RETURN, curvature, independent claim
  verification, and the VERDICT closure contract.
- `/home/hruzam/reposoma/raw.guides/handoff/GUIDE.md` — **replaced** with the authorized
  three-line supersession stub. No deletion.
- `/home/hruzam/reposoma/_mail/oraculum/inbox/cartan.status-bus-guides.2026-08-27.md` — **new**,
  this six-field RETURN.

No other file was edited. Existing reposoma changes in `_runbook/...`,
`raw.guides/runbook/GUIDE.md`, and the archived audit mail were preserved.

## 2. Commands and outcomes

- `hostname -s` → `hruzam`; `$MACHINE_NAME` → `home`.
- `cat raw.guides/runbook/GUIDE.md raw.guides/PAD/GUIDE.md raw.guides/handoff/GUIDE.md`
  (run as scoped reads) → house voice and surviving HANDOFF laws resolved before drafting.
- `cat _runbook/ia-sync/codex-tree-bus/RUNBOOK.md` (scoped section) → POINT/RETURN/VERDICT,
  six-field RETURN, and curvature source resolved.
- `nl -ba /home/hruzam/unikuklatrix/nablarva.devenv/session/dock.md` plus
  `git log --follow -- session/dock.md` → seven-line header only; created 2026-08-02; zero
  entries or later revisions.
- `install -m 0644 /tmp/cartan.status.GUIDE.md .../raw.guides/status/GUIDE.md` → success.
- `install -m 0644 /tmp/cartan.bus.GUIDE.md .../raw.guides/bus/GUIDE.md` → success.
- `install -m 0644 /tmp/cartan.handoff.GUIDE.md .../raw.guides/handoff/GUIDE.md` → success.
- `cmp -s <draft> <installed>` for all three files → exit 0 for each; installed bytes match
  the reviewed drafts.
- `git -C /home/hruzam/reposoma diff --check -- raw.guides/status/GUIDE.md
  raw.guides/bus/GUIDE.md raw.guides/handoff/GUIDE.md` → exit 0; no whitespace errors.
- `wc -l -w -c ...` → STATUS `153/1214/8028`, _bus `187/1141/7434`, HANDOFF stub
  `3/16/134`.
- `git -C /home/hruzam/reposoma status --short -- <three targets>` → HANDOFF modified;
  STATUS and _bus untracked as expected. No commit or push run.

## 3. Evidence paths

Authored artifacts:

- `/home/hruzam/reposoma/raw.guides/status/GUIDE.md`
- `/home/hruzam/reposoma/raw.guides/bus/GUIDE.md`
- `/home/hruzam/reposoma/raw.guides/handoff/GUIDE.md`

Doctrine/evidence checked:

- `/home/hruzam/reposoma/raw.guides/runbook/GUIDE.md`
- `/home/hruzam/reposoma/raw.guides/PAD/GUIDE.md`
- `/home/hruzam/reposoma/_runbook/ia-sync/codex-tree-bus/RUNBOOK.md`
- `/home/hruzam/unikuklatrix/nablarva.devenv/session/toolbox-termbrana-02-m0-truthspike/status.md`
- `/home/hruzam/unikuklatrix/nablarva.devenv/session/pulse.md`
- `/home/hruzam/unikuklatrix/nablarva.devenv/session/toolbox-termbrana-02-m0-truthspike/CS.termbrana-readme.2026-08-24.md`
- `/home/hruzam/www/elements-factory/applications-in-common/.dev/session/larvaTmux/stream.md`
- `/home/hruzam/www/elements-factory/applications-in-common/.dev/session/larvaTmux/pad.3-interference.md`
- `/home/hruzam/unikuklatrix/nablarva.devenv/session/dock.md`

## 4. Mismatches discovered

1. `raw.guides/runbook/GUIDE.md:82` still declares mutable `state: fresh | deferred | running |
   tests | finished | prod.testing | indexed`, while the same GUIDE says RUNBOOK is fixed and
   STATUS is the sole doing-state. The field is a second state surface and should not be in
   RUNBOOK.
2. `raw.guides/PAD/GUIDE.md:93-94` still permits a distilled verdict to land in “the session's
   stream/journal.” The revised session set has no stream/journal, and the RUNBOOK GUIDE now
   prohibits a per-session journal. The PAD destination needs reconciliation without turning
   STATUS into a historical log.
3. majkee clarified during authorship that artifact case is invariant in prose: RUNBOOK,
   STATUS, PAD, POINT, RETURN, VERDICT; exact disk case remains `RUNBOOK.md`, `STATUS.md`,
   `pad.*.md`, `_bus/`, and lowercase filename kinds. Both existing RUNBOOK and PAD GUIDEs use
   lowercase generic “runbook”/“pad” throughout. The two new GUIDEs carry the clarified case
   law; the gated companion GUIDEs were not edited.
4. `_runbook/README.md` and `_runbook/ia-sync/codex-tree-bus/RUNBOOK.md` still name
   `HANDOFF.md`, point to `raw.guides/handoff/GUIDE.md`, and instruct a seat to update HANDOFF.
   They now resolve to a supersession stub and are stale against the 2026-08-27 gavel.

All four were reported rather than repaired because the POINT authorized only the three named
GUIDE files.

## 5. Recommended next task

Run one bounded **session-shape consistency cycle** owned by Oraculum: remove mutable `state:`
from the RUNBOOK GUIDE, reconcile the PAD's distilled-verdict destination, normalize artifact
case in both companion GUIDEs, and update the two `_runbook/` surfaces that still route to
HANDOFF. Verify with an exact `rg` sweep for `HANDOFF.md`, obsolete handoff GUIDE pointers,
`stream/journal`, and lowercase artifact vocabulary before majkee commits the guide set.

## 6. Remaining uncertainty

- The POINT required a VERDICT closure contract but did not prescribe disposition labels. The
  _bus GUIDE proposes `ACCEPT | REVISE | STOP | BLOCKED`; Oraculum/majkee should confirm those
  labels or revise them before gaveling this leaf.
- The gaveled flag L9 amendment is intentionally not yet written in Nablarva by this task. The
  guides cite the 2026-08-27 gavel; on-disk flag text will remain stale until majkee performs
  the authorized append.
- No independent fresh-seat readability pass has yet been run on the two new GUIDEs. Structural
  inspection, exact-byte comparison, and `git diff --check` are green.

— @Cartan
