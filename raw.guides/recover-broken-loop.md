# Back in the saddle — recovering a broken agent loop

`tier: raw.guides · operational runbook (the HOW; the temple is the WHY)`
`audience: the operator, and any fresh agent handed this file`
`date: 2026-06-17 · use when: an agentic/autonomous loop has stalled, looped, or drifted`

> The doctrine tells you how to build the team. This tells you what to do when the team's
> machinery jams and you need to put a hand — yours or a fresh agent's — back on the grip.

## When to reach for this (symptoms)
- An agent loops on the same error/abort without progressing (N tries, same wall).
- A blind/research loop lost its blindness (a verdict leaked into a voice that should be clean).
- Two writers clobber one file (e.g. two generators, one surface) → silent drift.
- A gate was left open, or a decision is being re-litigated that `flag.md` already locked.
- Context refreshed mid-task and the agent is improvising instead of reading state.

## Step 0 — STOP and stabilize
Halt the broken loop before it writes more. A jammed loop that keeps acting makes recovery
harder. Re-assert the human gate (CapCom / you). Nothing autonomous resumes until Step 4.

## Step 1 — read state, in order (the disk is the truth, not the chat)
`plan → flag → pulse → decisions/`. The durable record outlives the session that broke.
- **plan** — what we were doing · **flag** — what is locked (do NOT reopen) ·
- **pulse** — volatile state at the break · **decisions/** — the why, superseded-not-edited.

## Step 2 — locate the break
Which phase/gate stalled? What was the last *locked* decision? What is still *open*?
Name the broken gate out loud. If it isn't in the durable files, that itself is the bug —
the loop wasn't persisting (doctrine Force 2).

## Step 3 — classify the loop (do not skip — it sets the fix)
- **Procedural** — wrong read, wrong scope, a missed offset. Cheapest. Re-brief and re-run.
- **Structural** — the break is built into the artifacts (contaminant co-located with its cure;
  two tools own one file). Re-running CANNOT fix it. The structure must change first.
- **Contextual** — lost blindness / a leaked memory node / stale context. Restart from a clean
  environment, re-fence what may be read.

> Worked example (2026-06-17): a blind R1 study aborted **three times** on one *structural*
> flaw — the prior verdict lived inside the very file R1 was required to read. Each restart
> re-hit it. The lesson is Step 5's one rule.

## Step 4 — put an agent back in the saddle
1. Re-establish the gate (human/CapCom authorizes the restart).
2. Re-dispatch the **architect** (Houston) with a clean, *fenced* brief — say exactly what it
   MAY read and MUST NOT read. Skip the open-ended "read everything" sweep that caused the leak.
3. If the loop was **structural**, FIX the structure first (redact / split / pick one writer),
   then re-run. If **contextual**, run from a clean dir/runtime.
4. Hand mechanical moves to the executor (Delta); send a delicate fix-decision through the
   challenger (Janus) before it locks.

## Step 5 — record, and the one rule
Append a dated note; supersede-not-edit; update `flag`/`pulse`. Then:

> **Never re-run a broken loop without fixing what broke it.**
> N aborts on the same flaw is the anti-pattern, not diligence. One abort = caught it; three
> aborts on the same cause = the structure is the bug, and a fourth restart is theater.

## Who to call
- **Houston** — re-plan, re-fence, own the restart. · **Janus** — challenge the fix before it locks.
- **Delta** — mechanical moves/rollbacks. · **CapCom / you** — the gate; nothing autonomous without it.
