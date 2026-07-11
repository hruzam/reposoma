---
canon-candidate: validated-edit discipline (+ rejection-telemetry loop)
date: 2026-07-11
thread: symmetry.agentive-collaboration
sources: external — Microsoft SkillOpt (arXiv 2605.23904, MIT, 2026-05) ·
         internal — #intervention-is-telemetry (raw.handoff.coherence-homeostat.2026-06-03)
regime: principle — NOT tooling; ground later
status: SEED · candidate canon · loop implementation DEFERRED
sovereignty: HIGH — discipline defined over own-files only; vendor-invariant;
             SkillOpt the tool is NOT adopted, only the discipline it demonstrates
---

# SEED — validated-edit discipline & the rejection-telemetry loop

## CORE  (#grep)
- #edit-gate — no edit to a canon-grade file is accepted unless it strictly improves
    a held-out check. For scoreable work: a validation score. For doctrine (today):
    the adversarial pass before lock is the human-grade gate. Same shape, different resolution.
- #rejected-edit-buffer — a rejected edit is RECORDED, not discarded. What was tried,
    why it failed, dated. Purpose one: the same bad edit does not return next round.
    Purpose two: see #rejection-is-telemetry. Lives in **decisions** (majkee, 2026-07-11),
    not as its own file.
- #edit-budget — bound how much one revision round may rewrite (SkillOpt: "textual
    learning rate"). A brake wired directly against the named primary risk:
    over-tuning meta-architecture instead of shipping. Big rewrites need multiple
    beats, not one inspired evening.
- #rejection-is-telemetry — the mosaic closure. See below.

## THE MOSAIC  (@majkee's fold)
These are not four independent rules — they compose into ONE loop, same way the
homeostat is one signal at three thresholds:

    work happens → edit proposed → #edit-gate
        → accepted: canon moves, decisions records rationale
        → rejected: buffer records the attempt
    → rejection DENSITY over time = a MAP
        → where edits keep failing = the doctrine is malformed THERE,
          not the editor incompetent (#intervention-is-telemetry, re-expressed)
        → high rejection rate on one file = that file exceeds one concern
          → DECOMPOSE the file, don't retry the edit
    → decomposition changes the substrate → next rollout runs on better ground

The recovery mechanism doubles as the design-quality sensor. Anchor-catch-rate
mapped structural traps in *context*; rejection-rate maps structural traps in
*canon files*. Same theorem, different plane.

## EXTERNAL CONFIRMATION  (why this earned a seed at all)
- SkillOpt treats a plain markdown skill doc as the trainable external state of a
  frozen model: optimizer proposes bounded add/delete/replace edits, gate accepts
  only strict improvement on held-out validation, rejected edits buffered.
- Skills transfer across model scales and between Codex / Claude Code harnesses
  without re-optimization → "nothing to migrate" at the knowledge layer,
  measured by someone else. Sovereignty gradient, vindicated externally.
- What we do NOT take: the optimizer loop itself. It requires a scoreable task
  class with a held-out set. Canon is doctrine — unscoreable today. Running the
  loop without a measurable gate degenerates into loosely-controlled
  self-revision — the exact failure mode the paper is built against.

## BOUNDARY / BRAKE
- #gate-needs-signal — the discipline is only as honest as its check. Where no
  measurable signal exists, the human adversarial pass IS the gate; do not fake
  a score to pretend otherwise (show vs. substance, again).
- #ground-later — loop automation deferred until a task class with real pass/fail
  emerges (most likely from Delta-tier executor work; doctrine will not produce one).
- brake holds: this seed adds a *recording habit* (rejection entries in decisions)
  and a *budget habit* (bounded rewrites). It adds NO new mechanism to build.

## STATUS / OPEN
- candidate canon: #edit-gate + #rejected-edit-buffer + #edit-budget +
  #rejection-is-telemetry as one umbrella. Umbrella NAME unassigned
  ("validated-edit discipline" = working description, not a claim).
- open: whether rejection entries in decisions need their own tag shape
  (`rejected:<file>:<date>`) or free-form suffices — decide at first real rejection,
  not before.
- open: relation to SkillOpt-style loop IF a scoreable class appears — then this
  seed graduates from discipline to mechanism; re-read the paper at that moment,
  not now.
