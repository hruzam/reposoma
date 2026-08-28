---
from: ia-sync:cartan
to: reposoma:oraculum
scope: l9-amendment-audit
date: 2026-08-28
host: home
status: RETURN — L9′ and pulse staged out; no commit or push
---

# RETURN — L9′ wording audit and pulse reshape

## 1. Files changed

- `/home/hruzam/unikuklatrix/nablarva/.dev/session/flag.md` — appended L9′ after L11;
  nothing above the append changed.
- `/home/hruzam/unikuklatrix/nablarva/.dev/session/pulse.md` — replaced narrative doing-state
  with an eight-line active-session router.
- `/home/hruzam/unikuklatrix/nablarva.devenv/session/flag.md` — stage-out copy, byte-identical
  to the live flag.
- `/home/hruzam/unikuklatrix/nablarva.devenv/session/pulse.md` — stage-out copy,
  byte-identical to the live pulse.
- `/home/hruzam/reposoma/_mail/oraculum/inbox/cartan.l9-amendment-audit.2026-08-28.md` —
  this six-field RETURN.

No other content changed. No git add, commit, push, or deploy ran.

## 2. Commands and outcomes

- `hostname -s` → `hruzam`; the Nablarva and devenv worktrees both began clean on `core`.
- `cmp -s <live flag|pulse> <devenv flag|pulse>` before editing → exit 0 for both; transport
  started from a byte-identical state.
- `git -C /home/hruzam/reposoma cat-file -e
  2c17a5c:raw.guides/status/GUIDE.md` → exit 0; durable evidence anchor resolves.
- `test -f /home/hruzam/reposoma/_mail/oraculum/archive/
  cartan.session-rhythm-convention-audit.2026-08-27.md` → exit 0; working receipt resolves.
- `rsync -ani --exclude-from=.../sync.deny <live session/> <devenv session/>` → only
  `flag.md` and `pulse.md` would change. Flat harness files, `.claude/`, and `.gemini/` had no
  content delta.
- The transport deny-pattern preflight found zero files that its cleanup pass would delete.
- `bash sync.sh` in `/home/hruzam/unikuklatrix/nablarva.devenv` → success; canonical
  `.dev/session/` mapping selected, 17 denies loaded, session stage-out completed, secret scan
  clean.
- `git diff --check -- session/flag.md session/pulse.md` → exit 0.
- `git status --short --branch` in devenv → only `M session/flag.md` and
  `M session/pulse.md`.
- Post-stage `cmp -s` live ↔ transport for both files → exit 0.
- `git show 089452b:session/pulse.md | sha256sum` →
  `47aadbc0304d082f138655338bab2f39c070d0708957e6ffdd3a08bc4cb4f28a`; this is the exact
  displaced 106-line pulse narrative already preserved in transport git history.

## 3. Evidence paths

Staged artifacts:

- `/home/hruzam/unikuklatrix/nablarva.devenv/session/flag.md`
- `/home/hruzam/unikuklatrix/nablarva.devenv/session/pulse.md`

Authority and evidence checked:

- `/home/hruzam/unikuklatrix/nablarva/.dev/session/flag.md` — L6, L9, L11, appended L9′.
- `/home/hruzam/unikuklatrix/nablarva/.dev/session/toolbox-termbrana-02-m0-truthspike/status.md`
  — exact current router target; gate remains M0 host contract FROZEN.
- `reposoma@2c17a5c:raw.guides/status/GUIDE.md` — durable, tracked synthesis and concrete
  Termbrana evidence.
- `/home/hruzam/reposoma/_mail/oraculum/archive/
  cartan.session-rhythm-convention-audit.2026-08-27.md` — resolved working-state receipt.
- `nablarva.devenv@089452b:session/pulse.md` — archive of every displaced pulse entry.
- `/home/hruzam/unikuklatrix/nablarva.devenv/sync.sh` and `sync.deny` — transport and
  secret/deny checks used.

Final L9′ wording as staged:

> **L9′ · Pulse = router — supersedes L9's pulse-role clause** (majkee 2026-08-27,
> triangulated audit Fable/Janus/@Cartan): this entry supersedes only L9's statement
> that `pulse.md` is the volatile doing-state and single canonical doing-state; every
> other L9 clause remains locked. `pulse.md` is a bounded router: one line per active
> session carrying its slug, gate, and exact `STATUS.md` path — no next action and no
> session narrative. That session's `STATUS.md` is the sole doing-state for its gate.
> Seam: a line that dies with the gate belongs in STATUS; a line that survives does not
> — a durable lock belongs in `flag.md`, while `pulse.md` admits only the router fields.
> Two files are allowed; two authorities are not. New evidence: by 2026-08-24 three
> files claimed Termbrana's next action; durable synthesis and evidence are at
> `reposoma@2c17a5c:raw.guides/status/GUIDE.md`; audit receipt (working-state, not the
> durable law): `_mail/oraculum/archive/cartan.session-rhythm-convention-audit.2026-08-27.md`
> in that repository.

## 4. Mismatches discovered

1. **The draft's “amends the prior reading” was too soft.** L9 does not merely support an old
   interpretation; it explicitly names `pulse.md` as the volatile doing-state and single
   canonical file. The staged wording therefore says “supersedes L9's pulse-role clause,”
   identifies the exact superseded statement, and preserves every other L9 clause.
2. **The draft seam could reopen pulse narrative.** “Still true after the gate closes →
   flag/pulse” did not distinguish durable canon from router data. The staged seam says a
   surviving line does not belong in STATUS: durable locks go to `flag.md`; `pulse.md` admits
   only slug, gate, and STATUS path.
3. **The mail receipt is legal but not durable enough alone.** It resolves, but reposoma
   `_mail/` is non-canonical and drainable. L9′ now cites the tracked STATUS GUIDE at exact
   commit `2c17a5c` as durable evidence and labels the mail path working-state receipt.
4. **No lock collision:** L6's experimental-bed/promotion boundary is unchanged. L11's
   Termbrana topology is unchanged because the router points to STATUS inside Nablarva's
   central `.dev/session/`, not a Termbrana-local pulse or harness.
5. **Navigation text remains stale outside the write gate:** Nablarva `AGENTS.md` still calls
   `pulse.md` “the ONLY canonical doing-state” in its read order. L9′ now supersedes that claim,
   but a cold reader encounters the stale navigation sentence before flag L9′.

## 5. Recommended next task

Oraculum should verify this staged diff against the cited artifacts, then hand majkee the
commit gate. After that commit, open one separate navigation-consistency task to update
Nablarva's `AGENTS.md` read-order wording from “pulse = doing-state” to “pulse = router;
session STATUS = doing-state.” Keep that edit separate from this append-only canon landing.

## 6. Remaining uncertainty

- The current Termbrana target is lowercase `status.md`, predating the gaveled `STATUS.md`
  filename. The router points to the exact existing file as ordered; migration was explicitly
  outside this task.
- Four other `.dev/session/` directories exist without RUNBOOK/STATUS pairs and are absent
  from the router. They appear to be observations, recovery material, or closed legacy beds;
  their pruning status was not audited here.
- The Termbrana next-action contradiction remains unresolved by design. This pass changed
  authority routing only.
- Displaced pulse narrative is preserved in git at `089452b`, not duplicated below the live
  router. This follows the gaveled model (“history lives in git”) and avoids immediately
  violating the new no-narrative pulse law.

— @Cartan
