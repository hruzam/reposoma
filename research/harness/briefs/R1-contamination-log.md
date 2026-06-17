# R1 — contamination log (operator / Houston only — NOT for the R1 voice)

This file exists so the R1 *kick brief* can carry the task ONLY. A blind voice must never
be told to read a file that contains the verdict it is supposed to derive blind. Per the
prior session's recommended fix (b): the contamination notice belongs here, not inline in
`kick-brief-R1-research-center.md`.

**Do not paste any prior verdict into this file or the brief.** Reference it as
"[prior verdict withheld — operator holds it]" if it must be mentioned at all.

---

## Entry — 2026-06-17 · strike #3 · @Houston (Claude Code)

**Outcome: R1 NOT written. CONTAMINATED before forming hypothesis X. I stopped at STEP 0.**

### What leaked, and how
1. **In-file verdict (primary).** `kick-brief-R1-research-center.md` still contains the
   prior contamination notice *inline above* the original brief, and that notice quotes the
   prior verdict verbatim and maps it to **H1** and **H2**. A default full-file read (no line
   offset) hands the verdict over the instant R1 opens its one mandatory file. This is the
   structural trap the prior session's §4 already described — unrepaired, so it fired again.
2. **Goal-file verdict (secondary, over-determining).** `~/.claude/houston.goal` also quotes
   the verdict phrase in its STEP 0 contamination example. Reading the goal is mandatory to
   *perform* the audit — so the anchor arrives before the brief is even opened. A clean
   Claude-voice R1 is therefore impossible against the current files regardless of read
   discipline.
3. **Memory node (fixed).** The `research-harness` auto-memory node WAS detached — that part
   worked; loaded memory at session start carried only the unrelated "Fable pins" node.
   The fix to the memory channel is good; the file-channel and goal-channel leaks are not.

### The load-bearing finding (now confirmed three times)
The warning and the verdict keep living in the same artifacts a blind voice must read.
Fences ("read only below the line", "read only this brief") cannot protect a voice from a
verdict sitting *inside* the fenced file or inside the launch goal. Co-locating the
contaminant with the cure defeats both. Repeating "STOP + append a note" without applying
the fix produces an infinite abort loop. **Strike #3 is not a new diagnosis — it is proof
the prior diagnosis was right and the fix is overdue.**

### Required before ANY future Claude-voice blind R1 (all three, or it fires again)
- **(a) Redact the quote.** Remove every verbatim prior verdict from the brief AND from
  `houston.goal`. Replace with "[prior verdict withheld — operator holds it]". A warning can
  warn without restating what it warns about.
- **(b) Split the file.** `kick-brief-R1-research-center.md` carries the original brief ONLY
  (current lines 88–125). The notice moves here. The brief does not link this log inline.
- **(c) Launch discipline.** R1 reads the brief from its first task line, never the file top;
  better, make that structurally impossible by (a)+(b) rather than relying on read habits.

### Recommendation to operator
Do not re-launch R1 until (a)+(b) are done. Houston can execute the redaction+split (or spec
it to @AtlasAuto) on your go — it is a structural/harness change, so it waits for your gate.
Memory re-attachment in MEMORY.md (the goal's closing step) should also wait until a clean
R1 has actually been produced, or the leak returns through the memory channel too.
