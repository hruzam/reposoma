# TASK — Gemini Rebuild: Fix Pass (post-triage)
# Supersedes the CLI-fallback patterns in phase1-infra + phase1-scripts

**Executor:** @Trajectory (+@Delta for surgical edits)
**Status:** OPEN — unblocks the parked Phase 1/2 chain
**Inputs (read in this order):**
1. `_mail/toAll/inbox/triage.gemini-hang.2026-07-03.md` — empirical verdict
2. `_mail/toAll/inbox/handoff.gemini-rebuild.addendum-hang.2026-07-03.md` — Q8–Q13 + spec patches
3. `_mail/toAll/inbox/handoff.gemini-rebuild.md` — original spec (still governs everything not patched here)

**Root cause recap (locked by triage 2026-07-03):**
`@agent` inside a `-p` prompt triggers a subagent agentic loop (default `timeout_mins=10`,
`max_turns=30`) — this is the 20-minute silence (Class C, primary). Positional-arg calls
without `-p` boot an interactive REPL inside command substitution (Class B, secondary,
live in legacy `gemini-agents.zsh:124`). stdin blocking (Class A) is CLEARED on v0.49.0.
Keys resolve in bare bash; curl is unbounded (Class D, latent).

---

## Patch list (ordered — P1 is the load-bearing one)

### P1 — Cut the CLI fallback from all headless paths. Entirely.
Files: `reposoma/ai_scripts/bluebottle.sh`, `vega.sh`, `orby.sh`, `astrobley.sh`
(verify actual staging location first; deploy target is `~/.config/zsh/ai/`).

Headless mode (any-arg) becomes: **REST primary → on failure, graceful fail** —
`[UNAVAILABLE: <reason>]` + `exit 0`. **No `gemini` CLI invocation in any headless path.**
Rationale: `@agent` prompt = agentic loop (Class C, empirically confirmed); CLI and REST
share the same backend, so CLI cannot rescue a 503 — it only converts a fast failure into
a 10–20 minute hang. Persona injection stays via REST `systemInstruction` (handoff Q7).

UI mode (no-arg) is untouched: interactive `gemini "@<name>"` with a TTY is legitimate.
Do NOT add `< /dev/null` to UI mode — it needs stdin.

### P2 — curl discipline in `processor.sh` `_gai_rest_call()`
`--connect-timeout 5 --max-time 120`, single bounded retry on HTTP 503 (sleep 4, one
re-attempt), then graceful fail. Use addendum Q13 numbers if they differ. No retry loops.

### P3 — Defensive wrapper on every remaining non-interactive `gemini` call
Anywhere a scripted/non-TTY `gemini` call survives (e.g. the `epoch()` function in
keyboard.zsh — phase1-infra PARTITION 5 spec has `gemini "@epoch $@"`, which is
Class B/C by construction — patch it): pattern is
`timeout 180 gemini ... -p "..." < /dev/null` with graceful fail on exit 124.
`< /dev/null` is regression insurance (issue #6715), not the primary fix.

### P4 — Model enumeration + astrobley model fix
`timeout 30 curl` `GET https://generativelanguage.googleapis.com/v1beta/models`
(x-goog-api-key auth). Record the list in your report. Resolve the discrepancy:
triage saw `gemini-3.5-flash` → 404; original handoff Q6 claims it GA. Pin astrobley
to a model the key actually serves (test `gemini-2.5-pro` and best available flash).
Note the verified assignment in the report — it also feeds the coder-concept draft.
Never `auto`, never `gemini-3.1-pro-preview`.

### P5 — Deploy + verify
Stage → `~/.config/zsh/ai/` per phase1-infra layout, `chmod +x`, update `base.zsh`
(phase1-infra Step 3). Then run the phase1 + phase2/3 sign-off tests — every test
command wrapped in `timeout`. Verify Track A's "DONE" claim while deploying: if
processor.sh/keyboard.zsh never actually landed in `~/.config/zsh/ai/`, the sign-off
was stale — deploy and note it.

### P6 — Runbook notes (document, don't fix — not firing on this box)
Add to the ai/README.md troubleshooting stub: ripgrep startup stall (#20433 →
`"useRipgrep": false` if seen) and GNOME keyring block (#21622 →
`GEMINI_FORCE_FILE_STORAGE=true` if seen).

---

## Gated / out of scope
- **Old-file kills** (`gemini-agents.zsh`, `gemini-base.zsh`, `bluebottle.zsh`): only
  after the stress pass is green, per standing rule. List them as ready-to-kill in report.
- **AGENTS.md line 24 `@Trajectory / @Delta` ImportProcessor noise:** canon file —
  operator gavel required. Flag only.
- **Phase 2 finalize** (gemini-cross-check.md path, epoch.md runbook, raw cards):
  proceed per task.gemini-rebuild.phase2-finalize.md once tests pass.

## Report
Append results + Track B sign-off to `task.gemini-rebuild.phase2-finalize.md` gate
section; write fix-pass summary to `_mail/toAll/inbox/report.gemini-fix-pass.2026-07-03.md`.
