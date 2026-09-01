---
kind: cold-start-card
date: 2026-09-01
brand: human-first
seat: majkee (executes) · scorer: oraculum or atlas-ui (after)
project: sella-line
root: applications-in-common (the factory — path per zsh/harness temple-project-map)
task: execute Probe A-eco — cold-orientation, ecological lane, Claude vs Codex. ~45 min desk time.
resume: run STEP 0–6 below by hand, then hand transcripts to any Sella-line seat for scoring
authority: raw.guides/sella/src/sella.probe-a.protocol.md (Wave-reviewed 2026-08-05) — this card only compresses it
amendment: results path — protocol says "_staging/"; that predates the vault. Results go to raw.guides/sella/raw/sella.probe-a.results.<date>.md
---

## STEP 0 — before anything (separate errand, same desk session)

🔴 Google AI console: check GEMINI_API_KEY type. Standard keys die "September 2026",
day unknown. If Standard → generate auth key, swap in secrets. 2 minutes. Unrelated
to the probe but urgent — do it first while you're at a screen.

## STEP 1 — snapshots (the factory)

```zsh
cd <applications-in-common root>
git rev-parse --short HEAD; git status --short; date        # record all three
cp -a . ../probe-a-eco-claude
cp -a . ../probe-a-eco-codex
# identity stamp for EACH copy:
(cd ../probe-a-eco-claude && find . -type f | sort | sha256sum)
(cd ../probe-a-eco-codex  && find . -type f | sort | sha256sum)   # must match
```
Two IDENTICAL copies — never one mutable dir sequentially. Hashes must be equal.

## STEP 2 — record versions + order

```zsh
claude --version; codex --version
```
Flip a coin for run order (Claude-first vs Codex-first). Write it down.

## STEP 3 — the runs (silent observation — the whole discipline)

Per vendor: `cd` into ITS snapshot copy → open a FRESH session (`claude` plain — no
--resume, no --agent · `codex` plain) → paste the prompt below VERBATIM → then
**hands off**: no steering, no hints, no naming files, no answering questions.
Watch. When it declares done or stalls, stop the session.

**Prompt (verbatim, both vendors):**

```
You are starting cold in this project. Your task:

1. Orient yourself using whatever native mechanisms you have.
2. One-paragraph summary: what is this project and how is work organized?
3. Find the most recently active experiment — describe its hypothesis, state,
   and which files carry it.
4. This project has a zsh-based developer toolkit. Find it, describe its boot
   sequence, and name one thing that would fail if the tmux server is not running.
5. Name the three most important files a new contributor should read first,
   in order.

Work from evidence, not assumptions. Show your orientation path.
```

## STEP 4 — what to capture (minimum)

Per run: the full transcript (or at minimum the tool-use trace — every Read/Grep/
Glob/Bash with timestamps) + the model's final answers. Session log files suffice;
no live note-taking needed beyond the coin flip + versions + start/stop times.

## STEP 5 — hand off for scoring

Give both transcripts to any Sella-line seat (Oraculum preferred) with one line:
"Probe A-eco ran <date>, order <X-first>, snapshots <hash>." The seat scores M1–M5
(tokens-to-identification · dead-end reads · unsupported assumptions · first
evidence action · corrections=0) and separates model-CLAIMED sources from
OBSERVED reads, then writes `raw.guides/sella/raw/sella.probe-a.results.<date>.md`
+ journals the Sella line.

## STEP 6 — cleanup

Delete both snapshot copies after results are written. Nothing commits from them.

## Guardrails (from the protocol — do not soften)

- n=1 exploratory. Signal, not vendor verdict.
- Zero operator corrections is a METRIC (M5) — steering invalidates the run.
- Do NOT run this on home: the factory + toolchain are office-pinned.
- A-norm (the stripped-context lane) is a SEPARATE later desk block — not today.

**Drain:** whoever scores the results moves this card `card/` → `archive/`.
