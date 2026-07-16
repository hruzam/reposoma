# Report — Gemini T2 Live-Fire Battery
Date: 2026-07-03 | Executor: @Trajectory (relayed via Oraculum — executor's write was
blocked by its operating rules; content verbatim from its report)

| Test | Wall | Exit | Verdict |
|------|------|------|---------|
| T2.1 bluebottle synthesis (real blob: triage report) | 11s | 0 | SUBSTANTIVE — Agreements/Additions/Overstated all accurate to source |
| T2.2 bluebottle --raw (429 vs 503 question) | 18s | 0 | SUBSTANTIVE content; **defect: `--raw` header suppression failed** — `## @BlueBottle cross-check` still emitted |
| T2.3 orby researcher (model strings) | 9.5s | 0 | THIN/STALE — seat functions; list reflects ~mid-2024 training data (1.5-flash marked Preview, 2.x absent). Expected: REST seat has no web access |
| T2.4 vega thinking (REST-vs-CLI principle) | 25s | 0 | SUBSTANTIVE — best of battery; principle: "prefer stateless interactions over managing state across process boundaries"; risk: per-call latency floor + network as new SPOF |
| T2.5 astrobley one-shot (PHP 8.2 IBAN) | 7s | 0 | SUBSTANTIVE — correct ISO 7064 MOD-97-10, function only, zero instruction bleed |
| T2.6 retirement preflight (read-only) | — | — | **staging retirement SAFE** — ia-sync holds all new files incl. personas/; all three condemned files absent |

## Detail notes (from executor)

- T2.1: correct analysis of Class C/B/D hang classes, accurate Overstated correction on Class D.
- T2.2: content mode shifted correctly to direct prose (Retry-After discipline, exponential
  backoff with jitter); only the script-side header echo fires regardless of `--raw`.
- T2.3: not a bug — model answers from weights. Operator guidance: date-sensitive/current
  facts route through @Epoch; orby is for synthesis and general research passes.
- T2.4/T2.5: no preamble noise anywhere; output contracts held.

## Actions arising

1. FIX (dispatched to @Delta 2026-07-03): gate the `## @BlueBottle cross-check` header
   echo in bluebottle.sh to non-raw branch only; re-test; ia-sync.
2. DOC (same pass): guide-for-user.md note — Gemini REST seats have no live web; current
   facts → @Epoch.
3. OPERATOR: staging retirement is go — `rm -rf /home/hruzam/reposoma/ai_scripts/`.
4. PARKED (@Atlas, low): gemini-cross-check.md agent definition needs an explicit
   "final message = payload, no narration" contract (first integration run stalled on
   an intention statement; tightened caller brief fixed it — belongs in the definition).
