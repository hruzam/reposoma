# capabilities-economy-hygiene

**Token economics of the orchestrator→subagent (octopus) pattern — measured, not guessed.**

`date: 2026-07-16 · author: @Atlas (rn arch) · source: eagle POC dispatch during octopus design session`

---

## 1. The model

When a head (main session / orchestrator) spawns a subagent (tentacle), the token
account splits into two books:

```
total billed (one dispatch) ≈ B + E + P + S

  B = boot tax : base system prompt + AGENTS.md/CLAUDE.md injection + agent def + task prompt
                 → PAID EVERY SPAWN. Fixed. Non-recoverable.
  E = the isolated work : the subagent's reads, tool calls, reasoning
  P = the spawn prompt the head writes
  S = the summary returned to the head

head context growth ≈ P + S  only.
  E is quarantined in the subagent window and DISCARDED on return.
  That isolation is the entire value proposition.
```

## 2. Measured run — eagle POC (2026-07-16)

| Metric | Value |
|---|---|
| Subagent tokens (B + E) | **20,829** |
| Tool uses | 3 (2× Read, 1× Bash) |
| Content consumed | ~320 lines (roster.md, system-map.md, dir listing) |
| Duration | 37.0 s |
| Report returned (S) | ~700 tokens (est.) |
| Spawn prompt (P) | ~300 tokens (est.) |
| Head context growth (P + S) | **~1,000 tokens** |
| Compression S/E | **≈ 0.034** |

Estimated split of the 20,829: boot tax `B` ≈ 8–12k (base prompt + harness + agent
def), real work `E` ≈ 9–13k. On a light 3-file orientation task, **roughly half the
spend was fixed tax.**

### 2b. Measured runs — the accumulating benchmark table

ONE table, temple-wide. Rows accumulate across sessions; a RUNBOOK cites a row, never
re-argues it. Re-grading a task class is a dated one-line append. Schema:
`date · session · agent · model · task class · n · first-pass-correct · avg tokens/spawn · notable failure mode`.
(Extended 2026-09-03 per Oraculum's economy-extension mail; two rows harvested from the
retired `raw.research/octopus-pilot/` before its erase.)

| date | session | agent | model | task class | n | first-pass | avg tok | failure mode / note |
|---|---|---|---|---|---|---|---|---|
| 2026-07-16 | eagle POC | @Eagle | sonnet | 3-file orientation, read-only | 1 | n/a | 20.8k | S/E ≈ 0.034; ~half spend = boot tax |
| 2026-07-16 | octopus-pilot T1 | @Delta | haiku | zsh launcher install from exact brief (3 files) | 1 | 1/1 | 21.7k | none; Assay-gated |
| 2026-07-16 | octopus-pilot T1 | @Assay | sonnet | fresh-eyes gate on T1 | 1 | PASS | 18.7k | none |
| 2026-09-02 | FC.sync-oraculum.sella-termbrana | @Delta | haiku | surgical edits / fence scribing from exact brief | 27 | 26/27 | 20.7k | the one miss = nested-fence artifact in the HEAD's brief, not Delta's |
| 2026-09-02 | FC.sync-oraculum.sella-termbrana | @Vector | sonnet | multi-file edits needing local judgement | 5 | 5/5 | 56k | 1 honest scope-limit flag instead of overreach |
| 2026-09-02 | FC.sync-oraculum.sella-termbrana | @Assay | sonnet | gate | 1 | PASS | 58k | 4 WARNs, all actionable |

Pattern (termbrana, head = Fable over SSH): ≈33 spawns for one gate; every fence, fold, verdict
and cleanup went through an executor; the head never used Edit. Head cost not measured —
session-specific note: 9 photos ingested as an evidence route when CLI echo failed (a
condition of that session, NOT a general "images are the largest cost" finding — file reads
dominate in the general case, `raw.research/session-hygiene/`).

## 3. Conclusions

1. **Boot tax floor ≈ ~10k tokens per Sonnet-tier spawn.** Empirical, from a
   deliberately light task. Every tentacle pays this before doing any work.
2. **Crossover: do not spawn under ~15–20k of real work** unless the head is
   busy/long-lived. Below that, tax > savings — read it inline. (Matches the temple's
   existing Vector threshold: *"file > ~40K tokens."*)
3. **The octopus is a hygiene + parallelism play, NOT a token-savings play.** Total
   burn goes UP (every tentacle re-pays `B`); what you buy is a flat head context and
   wall-clock parallelism. In the POC: head grew ~1k instead of ~7k, and the map was
   produced *while* the head wrote analysis. Correct model: **trade more total tokens
   for a head that survives a long session + a brain you rent by the minute.**
4. **Compression is the lever.** A good tentacle returns S/E < 0.1. Eagle hit 0.034 —
   pattern working. A tentacle that returns S/E > 0.3 (dumps raw prose) is leaking the
   isolation benefit; tighten its report contract.
5. **Model tiering by role, not by default:**
   - Head: **Sonnet** (Flight). Never Opus on smalltalk/dispatch.
   - Tentacle-leaf: **Haiku** (Delta) for small surgical; **Sonnet-bigger-context**
     (Vector/Hooke) when input exceeds Haiku's ceiling.
   - Brain: **Opus** (Houston/Janus/Oraculum) — rented per moment, released immediately.

## 4. Note — Vector is not dead

Correction to an earlier read: **Vector = Delta with a bigger context window
(Sonnet-tier).** Its power is holding inputs that exceed Haiku's ceiling without
invoking senior judgment. Live role, not dead primitive.

Naming drift flagged: Vara's definition routes medium-implementation to **@Hooke**; the
system roster names the same tier **@Vector**. One tier, two names — needs
reconciliation (operator gavel).

## 5. Design implication (load-bearing)

The head must **externalize-and-forget mid-session.** Every closed tentacle →
checkpoint to a file → evict from head context. Otherwise the ~1k-per-tentacle head
growth compounds across a long program and the head collapses *regardless* of
isolation. This is the discipline the octopus depends on — not an optimization, a
precondition.
