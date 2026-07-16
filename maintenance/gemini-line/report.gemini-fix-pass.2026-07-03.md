# Report — Gemini Fix Pass
**Date:** 2026-07-03
**Executor:** @Trajectory
**Task:** task.gemini-rebuild.fix-pass.2026-07-03.md — P1–P6

---

## What changed

### P1 — CLI fallback cut from all headless paths (load-bearing)
Removed all `gemini` CLI invocations from headless code paths in:
- `ai_scripts/bluebottle.sh` (both `--raw` and synthesis modes)
- `ai_scripts/orby.sh`
- `ai_scripts/vega.sh`
- `ai_scripts/astrobley.sh`

Pattern: every `|| { CLI fallback }` block replaced with `|| { echo "[UNAVAILABLE: REST call failed for ${_MODEL}]"; exit 0; }`.
UI mode (no-arg) untouched — interactive `gemini "@<name>"` with TTY kept as-is. No `< /dev/null` added to UI paths.

### P2 — curl discipline in processor.sh `_gai_rest_call()`
- Added `--connect-timeout 10 --max-time 120` to all curl calls (Q13 numbers).
- HTTP status code captured separately from body (curl -o tmpfile -w "%{http_code}").
- Single bounded retry on HTTP 503 or 429 (sleep 4, one re-attempt). No loop.
- Model parameter added: `_gai_rest_call payload model` — URL now built from model param. Previously hardcoded to gemini-2.5-flash regardless of caller _MODEL.
- `_gai_extract()` fixed: now accepts argument via $1 (was silently reading stdin, causing null output).
- All per-agent scripts updated to pass "${_MODEL}" as second arg to _gai_rest_call.

### P3 — epoch() defensive wrapper in keyboard.zsh
`epoch()` headless path wrapped: `timeout 180 gemini -p "@epoch $*" < /dev/null`. Exit 124 reported to stderr. UI mode (no-arg) unchanged — no `< /dev/null`.

### P4 — Model enumeration + astrobley model resolution
**Full model list via GET /v1beta/models (key not printed):**

Key serves: gemini-2.0-flash, gemini-2.0-flash-lite, gemini-2.5-flash, gemini-2.5-flash-lite,
gemini-2.5-pro, gemini-3.1-flash-lite, gemini-3.1-pro-preview, gemini-3.5-flash (GA),
gemini-3-flash-preview, gemini-3-pro-preview, plus embedding/TTS/image/robotics variants.

**Direct REST probes (HTTP status):**
- gemini-2.5-flash: 200
- gemini-2.5-pro: 200
- gemini-3.5-flash: 200

**Discrepancy resolved:** Triage claimed gemini-3.5-flash returns 404. Empirical REST probe: HTTP 200.
Triage's 404 claim was an assertion about CLI routing, not an empirical REST probe. REST confirms 200.
astrobley.sh model string `gemini-3.5-flash` is correct and kept as-is.

### P5 — Deploy + verify
**Track A stale sign-off confirmed:** processor.sh, bluebottle.sh, orby.sh, vega.sh, astrobley.sh
were NOT in ~/.config/zsh/ai/ prior to this fix-pass. Only base.zsh and keyboard.zsh were deployed.
All five scripts now copied to ~/.config/zsh/ai/ and chmod +x applied.

**Test results (all with timeout wrappers, all exit 0):**
- timeout 60 bash ~/.config/zsh/ai/orby.sh → exit 0
- timeout 60 bash ~/.config/zsh/ai/astrobley.sh → exit 0
- timeout 60 bash ~/.config/zsh/ai/bluebottle.sh → exit 0, ## @BlueBottle cross-check header present
- timeout 60 bash ~/.config/zsh/ai/bluebottle.sh --raw → exit 0, header present
- timeout 60 bash ~/.config/zsh/ai/bluebottle.sh <file> → exit 0, header present
- timeout 120 bash ~/.config/zsh/ai/vega.sh → exit 0
- timeout 15 zsh keyboard.zsh source + gemini-agents-help type → exit 0
- epoch function: sourced, timeout 180 + < /dev/null confirmed in headless path

### P6 — Runbook notes in README.md
Added ## Troubleshooting section to ~/.config/zsh/ai/README.md:
- Ripgrep startup stall: "useRipgrep": false or symlink fix (#20433)
- GNOME keyring block: GEMINI_FORCE_FILE_STORAGE=true (#21622)

---

## Files touched

- /home/hruzam/reposoma/ai_scripts/processor.sh — P2 rewrite
- /home/hruzam/reposoma/ai_scripts/bluebottle.sh — P1
- /home/hruzam/reposoma/ai_scripts/orby.sh — P1
- /home/hruzam/reposoma/ai_scripts/vega.sh — P1
- /home/hruzam/reposoma/ai_scripts/astrobley.sh — P1 + P4 comment
- ~/.config/zsh/ai/processor.sh — deployed (was absent)
- ~/.config/zsh/ai/bluebottle.sh — deployed (was absent)
- ~/.config/zsh/ai/orby.sh — deployed (was absent)
- ~/.config/zsh/ai/vega.sh — deployed (was absent)
- ~/.config/zsh/ai/astrobley.sh — deployed (was absent)
- ~/.config/zsh/ai/keyboard.zsh — P3 (epoch headless wrapper)
- ~/.config/zsh/ai/README.md — P6 (troubleshooting section)
- _mail/toAll/inbox/task.gemini-rebuild.phase2-finalize.md — Track B sign-off appended

---

## Ready-to-kill (gated on operator gavel after green stress pass)

- ~/.config/zsh/ai/gemini-agents.zsh
- ~/.config/zsh/ai/gemini-base.zsh
- ~/.config/zsh/ai/bluebottle.zsh

Not deleted. Standing rule: kills only after stress pass green + operator gavel.

---

## Flagged (not acted on)

- AGENTS.md line 24 @Trajectory / @Delta ImportProcessor noise: canon file, operator gavel required.
- _gai_extract "${_RESULT}" was a pre-existing null-output bug (jq never saw the JSON). Fixed as part of P2 since it was in the same code path being rewritten.
- vega.sh's _MODEL="gemini-2.5-pro" was silently ignored (URL hardcoded to flash). Fixed as side-effect of P2 model-param addition.

---

## Remaining manual checks

- Phase 2 (steps 2.1–2.4 in phase2-finalize.md) is now unblocked (both tracks signed off).
- ia-sync commit for ~/.config/zsh/ai/ changes (phase2-finalize Phase 3 ia-sync step).
- Stress pass + old-file kills: gated on operator gavel.
