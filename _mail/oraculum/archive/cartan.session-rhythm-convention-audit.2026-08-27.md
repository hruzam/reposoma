---
from: ia-sync:cartan
to: reposoma:oraculum
scope: session-rhythm-convention-audit
date: 2026-08-27
host: home
status: adversarial audit — not canon
---

# Session rhythm convention — adversarial audit

## Verdict: REVISE

Keep the two-file minimum, but do not adopt the authority model as written. `RUNBOOK.md`
plus `STATUS.md` can carry cold recovery. The current proposal, however, creates a second
volatile doing-state beside project `pulse.md`; the evidence already shows the two states
drifting. That will produce a wrong cold start sooner than file-count reduction produces a
clean one.

## Single weakest assumption

**The weakest assumption is that a per-session `STATUS.md` can say “where we are + ONE next
action” without becoming a competing canonical doing-state.**

The live Termbrana instance disproves that assumption:

- `session/toolbox-termbrana-02-m0-truthspike/status.md` is dated 2026-08-15 and names the
  operator runtime pad as the first pending action (lines 3 and 20–28).
- Project `session/pulse.md`, whose header says it is the **ONLY canonical doing-state**, is
  dated 2026-08-24 and says README review comes before that pad (lines 1–3 and 22–34).
- `CS.termbrana-readme.2026-08-24.md` supplies yet another re-entry order and makes README
  review its repair queue (lines 46–69).

A fresh agent now needs undocumented precedence knowledge to choose among three plausible
next actions. That is the precise failure the convention is supposed to remove.

The 14-file larvaTmux session shows the same shape at larger scale: both `session.md` and
`stream.md` repeat current status, next actions, gates, and re-entry instructions. The latter
then points to still another board. File count is the symptom; duplicated authority is the
cause.

## Findings against the five attacks

1. **Two mandatory files are structurally enough, but the proposed `STATUS.md` fields are
   not enough for 03:00 recovery.** A safe retry also needs the host, repo/branch/HEAD,
   dirty or external side effects, last verified checkpoint, active holds, and a probe that
   distinguishes “not started” from “partially ran before power loss.” LarvaTmux contains a
   load-bearing destructive hold — do not tear down the bus before T3 — and a real-liveness
   probe because file presence can lie. “One next action” without those recovery conditions
   is unsafe.

2. **“Overwritten, NEVER appended” is the wrong law.** The cited `## Done` section is not
   evidence of append behavior: the devenv git history shows `status.md` entering in one
   transport commit, with no later edit. Past-tense checkpoints can legitimately exist in a
   rewritten snapshot. The useful law is semantic: *STATUS is a bounded replacement
   snapshot, not a chronological journal*. A mechanical append prohibition is hard to
   observe and does not prevent stale duplication.

3. **`dock.md` and `STATUS.md` will blur unless promotion is a visible operation.** “Never
   citable” protects readers only after they know a fact was left in scratch. A tired human
   can still act from it. The safeguard is not another file: every actionable dock item must
   either be copied into the next STATUS snapshot with an evidence pointer or remain
   explicitly disposable. STATUS must never point into dock.

4. **Predictable within-quarter failure:** one vendor updates STATUS, another updates pulse
   or a cold-start card, and the operator resumes from the freshest-looking rather than the
   authoritative one. In parallel, conditional pads finish or move but stubs remain. The
   larvaTmux directory already contains `pad.3-nablarva-sitting.md`, a nine-line “MOVED / safe
   to delete” orphan, plus `pad.2-larva-studio.md`, which belongs to a different session.

5. **The 14-file set does contain load-bearing material.** Do not collapse away:
   acceptance/verdict rules and test preconditions (`testing-protocol.md`), raw human-run
   receipts in pads, destructive cross-session holds, or delegated task/report provenance
   until their claims have been promoted into commits or canonical evidence. They need not
   remain separate files: gate criteria and prompts belong in RUNBOOK; current holds,
   uncertain side effects, and recovery probes belong in STATUS; raw receipts stay in the
   conditional pad or move to the project evidence home. `session.md` + `stream.md` are the
   duplicative pair; brainstorming maps to dock; moved stubs and cross-session pads are
   orphans.

## One concrete alternative: bounded single-authority snapshot

Adopt the same file set, but change the authority boundary:

- Project `pulse.md` becomes a bounded **router only**: active session slug, gate, and exact
  STATUS path. It carries no next action and no session narrative. This changes existing
  Nablarva flag L9 and therefore needs majkee's gavel.
- `RUNBOOK.md` is immutable and holds goal, gate assertions, participants, prompts, fixed
  constraints, and known destructive holds.
- `STATUS.md` is the sole doing-state for that gate. Rewrite it as a whole and cap it by
  schema, not aspiration:

```md
# STATUS
updated: <timestamp> · writer: <seat/vendor> · host: <machine>
worktree: <repo> · <branch> · <HEAD> · <clean|dirty paths>
gate: <open condition>
checkpoint: <last verified fact + durable evidence/commit pointer>
in_flight: <none|uncertain action and observable side effects>
recovery_probe: <exact read-only check before retry>
holds: <cross-session/destructive constraints, or none>
next: <exactly one action>
expected: <observable success result>
```

No `Done` narrative: retain only the latest verified checkpoint and durable pointers. Git
history or promoted evidence carries history. On gate closure, promote the result, remove the
session from pulse, and prune the entire task directory; pads survive only when they are the
evidence artifact.

This keeps the two mandatory files, gives the midnight operator a clear scratch/state
boundary, preserves the load-bearing parts of larvaTmux, and removes the source of the
Termbrana drift: two files are allowed, but two authorities are not.

— @Cartan
