# observation — tunnel shim app-server wait-window vs research-grade turns

`class: dev-layer observation (uncanonical, sella-src pattern) · driver: Trajectory (oStar`
`head, ia-sync codex-remote-control-cli-01-wrapper) · date: 2026-09-10 · codex model:`
`gpt-6-astra · state: shared channel ~/ia-sync/.dev/session/tunnel.state.json`

## Timeline (three invocations, one thread)

1. **Cold `ask`, full audit brief** (7 files + 5 checks) →
   `tunnel-codex.py: timed out after 6.025s waiting for app-server output` · **exit 0**.
   Thread state after: no thread born yet (state showed `threadId: null`).
2. **Retry ping** (`send "reply PONG"`) → PONG, thread born, ~20K input tokens. Transport
   itself healthy — the first failure was cold-start + long-turn combined.
3. **Re-sent audit brief** → `timed out after 27.18s waiting for app-server output` ·
   **exit 0**. `tun read` reconcile showed the truth: turn `status: "interrupted"`,
   `completedAt: null`, and the item list mid-flight full of `web_search` results —
   Codex was fetching `termux-app/.../TermuxTerminalExtraKeys.java` and upstream
   `termux.properties` to validate extra-keys syntax against source. Long turn by
   diligence, not by malfunction.

## The two findings

- **F1 — wait-window too short for research turns.** The shim's internal wait for
  app-server output (observed 6s cold / 27s warm) is far under a web-search turn's
  natural length. The no-daemon design means nobody waits for the server to finish.
- **F2 — silent failure.** Both timeouts exited **0** with the error only on stderr.
  The documented exit contract (0·10·11·12·13·20·30·40·50) has no code for this path;
  `&&`-chained drivers continue on a dead turn.

## What held (workaround, reproducible)

Brief the turn with: **"NO web search — LOCAL file reads only; keep the turn short."**
Three consecutive counter-sign rounds then completed clean (verdicts NOK→NOK→OK),
~65K input each, streamed == read-back.

## v1 candidates (for the next tunnel iteration, not hand-patched now)

1. Adaptive or configurable output wait (`--wait <s>` / env), default well above 60s.
2. Nonzero exit on internal timeout (40 turn-error fits) so drivers can branch.
3. Optional: print the reconcile hint (`tun read`) on the timeout path — it is the
   correct next move and the contract already owns it.

## Cross-references

- Sibling lesson: dev-journal 2026-09-04 (Atlas) — harness-side process-kill interrupt;
  same wound, different knife. Background-run does NOT dodge THIS failure (F1 is
  shim-internal).
- Evidence trail in field session: ia-sync
  `.dev/session/codex-remote-control-cli-01-wrapper/STATUS.md` (c2 counter-sign block).
