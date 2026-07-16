# DRAFT — Gemini as PHP coder: the patch protocol (Tier 1)
# For operator gavel — concept, not yet build spec
# Oraculum, 2026-07-03 — grounded in triage + hang addendum (both in this inbox)

## Governing insight
The model didn't degrade; the harness did. The "perfect PHP colleague" era was a thin
REPL. Today's CLI is an agentic runtime that self-feeds (GEMINI.md crawl, spontaneous
file reads, thoughtSignature bloat #20933, auto model switch, #8609 cascade). So the
coder path does not leash the loop — it removes it: **Gemini as a pure function.
No tools, no reads, no sessions. Diff in, diff out.**

The doc-gorging block is architectural, not rule-based: over REST, Gemini cannot read
documentation because there is nothing to read *with*. (Policy-TOML denial remains the
fallback layer for Tier 2 clean-room work only.)

## Roles
- **Claude Code (Trajectory/Delta) = hands and eyes.** Reads the codebase, builds the
  context pack, applies the diff, runs the tests. Disciplined context, bounded payloads.
- **Gemini = brain in a jar.** One stateless `generateContent` call per turn.
  Output contract: **a unified diff and nothing else** (or a single line
  `QUESTION: ...` when blocked). No prose, no explanation, no "approach".

## The ledger (operator-owned memory)
`session/gemini-coder/<task-id>.ledger.json` — the explicit `contents[]` array sent on
every call. Script appends each turn. Properties:
- 100% visible, auditable, trimmable — no hidden context accumulation, ever
- 503 recovery is free: the payload is already a file, re-fire without rebuilding
- one task = one ledger; ledgers are never reused across tasks

## The loop (bounded, falsifiable)
1. Claude builds context pack: target file(s) in full + dependency **stubs**
   (signatures/interfaces, not bodies) + task statement + failing test output if any.
   Cap ~50K tokens.
2. REST call: `systemInstruction` = coder persona + output contract;
   `temperature 0.2`; `--connect-timeout 5 --max-time 120`; one 503 retry.
3. Validate: `git apply --check` on a work branch. Reject non-diff output outright.
4. Apply + run tests. Green → done. Red → append failure output to ledger → next turn.
5. **Hard ceiling: 4 iterations**, then stop and hand to human. No infinite loops by
   construction.

## Hard rules
- The coder path NEVER touches the gemini CLI. REST only.
- Model pinned explicitly — from the fix-pass P4 enumeration (3.5-flash 404'd on this
  key; verified assignment lands in the fix-pass report). Never `auto`.
- Every failure is visible and bounded; worst case is a fast, legible error — never
  a silent 20-minute stall.

## Pilot = the verdict (the "last attempt" made falsifiable)
One real PHP task from the live codebase. Measure:
- first-pass apply rate (`git apply --check` success)
- iterations to green
- wall time per turn
A diff either applies and goes green or it doesn't — the stay-or-switch-to-agy decision
gets a clean answer within one session, not another ambiguous freeze.

## Open for gavel
1. Naming: does this live inside the astrobley seat (headless coding mode) or as its
   own script? (Culture layer = operator's.)
2. Model choice once P4 enumeration lands (2.5-pro depth vs available flash speed).
3. Iteration ceiling (default 4) and payload cap (default ~50K tokens).
4. Tier 2 clean-room (jailed dir + policy deny-wall) — build now or only if a pilot
   task genuinely needs multi-file agentic editing.
