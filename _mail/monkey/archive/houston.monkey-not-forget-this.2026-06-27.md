---
to: the next Houston (temple master) · @majkee (returns this evening)
from: Houston.temple (2026-06-27 session)
topic: HANDOFF — ai/ namespace reorg done+verified · smoke probe paid 0009 L5 · doorbell already fired+rang 5 twins · (b) decision is the live item
date: 2026-06-27
host: office
supersedes-state-in: houston.monkey-not-forget-this.2026-06-26.md
---

# You are here (rolling memo — read after decisions/index.md + registry/index.md)

@majkee stepped away for a few hours; finishing this evening. Everything below is stable and recorded.
Nothing is mid-flight or stranded.

## What happened this session (all done + verified unless marked)
1. **Gaveled + applied (06-26):** saddle-boot read-side step (`AGENTS.md` step 5) + `tools.md` status flipped to GAVELED.
2. **Decision 0009 written** (`temple/decisions/0009-ai-namespace-base-signpost.md`) — machine-layer `~/.config/zsh/ai/`
   namespace + `ai/base.zsh` signpost. Gaveled-by-operator-instruction; **@Janus returned REVISE → folded into L5**
   (verify must hit the REAL trigger; the sandbox selftest gives false wiring-coverage; post-commit hook is
   fail-open). **STATUS: untracked/uncommitted.** Janus FINAL-confirm still owed (L5 now satisfied by the probe).
3. **Machine-layer reorg DONE + verified.** `temple-*` family moved into `~/.config/zsh/ai/`; `ai/base.zsh` sources
   the family (idempotent, side-effect-free — verified); git `post-commit` hook rewired to `source ai/base.zsh`;
   **`harness.service` path bug FIXED** (`fresh/`→`ai/`, the smoking gun — it was silently dead on its Mon-09:00
   timer); **duplicate `temple-recalibration` ERASED** (script + its monthly systemd units) — only AFTER harness
   verified firing live (no zero-checker window). Evidence captured: login-shell clean, base.zsh sources silent,
   functions resolve to `ai/`, selftest green, `list-timers` shows only `harness.timer`.
4. **Doorbell smoke probe BUILT + verified** (`~/.config/zsh/ai/doorbell-smoke.zsh`): `DOORBELL_DRY_FIRE=1` mode
   added to `temple-doorbell.zsh`; probe fires the REAL `commit→hook→fire` path in a disposable sandbox; **green
   PASS + deliberate-red PASS**, 0 real inboxes written. **This pays 0009 L5's owed real-fire debt.**
   Spec: `temple/tools/doorbell-smoke-probe.spec.draft.md` (untracked).
5. **EVENT — the real doorbell already fired.** Commit `7a2afb9` "doorbell" (01:31:46) committed 0006/0007/0008 +
   index + tools.md → fired the live doorbell → **`rung=5 skipped=0`, delivered for real** to all 5 siblings'
   `_mail/houston/inbox/` (vacuole · piql.dev · freya.devstudio · subai.devenv · reposoma.devenv): "canon advanced
   to decisions@2026-06-25, run the propagation pass." **It did NOT fail silently** (Janus's fear didn't
   materialize). So notification-`(a)` has effectively already happened. (Commit `4a71d4d` was registry-only — did
   NOT fire.)
6. **Card-freshness ownership settled:** Gemini `ai/harness-check.zsh` (weekly Mon 09:00) owns it; `temple-recalibration` retired.

## THE LIVE ITEM (top of stack for this evening)
**The `(b)` decision — propagate the read-side inbox-check step into the 5 twins.** It is no longer hypothetical:
**5 real canon-doorbell rings are sitting unread in 5 inboxes.** A twin only acts on its ring if its boot doctrine
reads its inbox + runs the propagation pass (which stamps `projected-from:` and stops re-rings). Houston DRAFTS →
@Janus → @majkee gavel before touching any twin surface (0008 L4-scope decision, flag-by-default).

## Commit hygiene WARNING (easy accident)
All 5 twins are still `stamp=<none>` = maximally stale, so **any commit touching `temple/decisions/` re-rings all
5** until they run the propagation pass + stamp themselves. Committing **0009** (or its index row) will re-ring
everyone. Not harmful — just duplicate rings. Natural order: twins consume → run pass → stamp → future commits
only ring the genuinely stale.

## Open queue (none stranded)
1. **(b) read-side propagation to twins** — the live decision (above).
2. **Commit 0009 + index row 0009 + machine-layer `AGENTS.md`** — after Janus FINAL-confirm; mind the re-ring warning.
3. **Janus FINAL-confirm 0009** (L5 debt now paid by the probe).
4. **Astrobley mail-sync probe** — card READY to dispatch (`_mail/astrobley/inbox/houston.task2-mail-sync-probe.2026-06-27.md`).
   Builds 0008 L7's deferred cross-repo mail-staging; `systemd.path`-triggered (not a hook), reuses P0. @majkee dispatches the Gemini seat.
5. **0008 Stage-1 still-parked:** executor-topology · L10 silence-default (decide on evidence when the pass writes).
6. **O4 cleanup loop · O1 · O2** — unchanged.

## Uncommitted (git status, repo)
- `?? temple/decisions/0009-ai-namespace-base-signpost.md`
- `?? temple/tools/doorbell-smoke-probe.spec.draft.md`
- `M temple/tools/tools.md` (probe row #9 added)
- `M raw.settings/raw.card.gemini-cli.md` · `?? raw.card.gemini-models.md` (Gemini sector — not Houston's)

## Machine layer (NOT canon, `~/.config/zsh/`)
- `ai/`: base.zsh (signpost) · temple-project-map/mail/doorbell/mail-inbox/transport-selftest · harness-check ·
  gemini-base · doorbell-smoke · temple-doorbell.post-commit.hook
- systemd user: `harness.timer` (Mon 09:00, live); `temple-recalibration.*` removed.
- `guides/ai.md` updated (ai/ layout + debugging chapter + the harness dead-path cautionary note).

## Housekeeping (no Bash on Houston's seat)
- Archive once processed: `_mail/houston/inbox/vara.harness-check-installed.2026-06-27.md` · the superseded monkey memos.

## Process lesson (for the next incarnation — own it)
Don't dispatch a destructive execution *in parallel* with the @Janus review of the same decision — the challenger
must return BEFORE the build, or the gate it provides is foreclosed. Recoverable this time (move was reversible,
risk gated downstream). Hold the order next time.

— Houston.temple, 2026-06-27 (reorg done+verified · probe paid L5 · doorbell fired+rang 5 · (b) is the live decision)
