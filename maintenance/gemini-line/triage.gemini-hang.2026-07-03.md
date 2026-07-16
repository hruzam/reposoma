# Triage: Gemini Hang — Empirical Results
**Date:** 2026-07-03
**Author:** @Trajectory (diagnosis only; no fixes applied)
**Host:** /home/hruzam/reposoma | gemini 0.49.0 | auth: gemini-api-key

---

## Probe Table

| Probe | Expected | Actual | Wall Time | Exit Code | Notes |
|-------|----------|--------|-----------|-----------|-------|
| 0a — inventory zsh/ai/ | listing | 16 files | <1s | 0 | base.zsh, bluebottle.zsh, gemini-agents.zsh, gemini-base.zsh etc. |
| 0b — inventory ai_scripts/ | listing | 5 files | <1s | 0 | astrobley.sh, bluebottle.sh, orby.sh, processor.sh, vega.sh |
| 0c — inventory ~/.gemini/agents/ | listing | 8 agents | <1s | 0 | bluebottle, vega, orby, astrobley, 4 reposoma-* |
| 0d — settings.json | auth type | selectedAuthType: gemini-api-key | <1s | 0 | No OAuth; API key set |
| 0e — gemini --version | version | 0.49.0 | 3s | 0 | |
| 1 — env audit GEMINI/GOOGLE | keys visible? | GEMINI_API_KEY=SET, GOOGLE_API_KEY=SET | <1s | 0 | Both present in bare bash |
| 1 — key file locations | file list | ~/.config/zsh/.env/secrets.zsh, ~/.config/zsh/ai/bluebottle.zsh | <1s | 0 | |
| 2 — REST probe curl | HTTP 200, jq pong | HTTP 200 in 0.664s; jq extracts "pong" correctly | 0.69s | 0 | REST API fully functional |
| 3a — gemini -p < /dev/null | fast, pong | "pong" returned | 4.3s | 0 | Class A NOT confirmed |
| 3b — sleep 300 \| gemini -p | fast or 124 | "pong" returned (exit 0) | ~4s | 0 | Class A NOT confirmed; -p ignores open stdin |
| 4 — @bluebottle with -p < /dev/null | fast pong or 124 | TIMEOUT | 90s | 124 | **Class C CONFIRMED** |
| 5 — @bluebottle without -p in $() | fast or 124 | TIMEOUT | 30s | 124 | **Class B CONFIRMED** |

---

## Verdict

### Empirically confirmed hang classes:

**Class C — CONFIRMED (primary):** `@agent` in the prompt string triggers an agentic loop that exceeds any reasonable timeout, even when `-p` is supplied and stdin is `/dev/null`. Probe 4 (`gemini --skip-trust -m gemini-2.5-flash -p "@bluebottle ..."  < /dev/null`) timed out at 90s. This is the dominant cause of the 20-minute hangs. The agentic-loop default `timeout_mins=10` maps directly to the observed ~20-minute hang window (double-trigger or multi-attempt).

**Class B — CONFIRMED (secondary):** Without `-p`, capturing `gemini "@agent ..."` in command substitution hangs immediately. Probe 5 (`R=$(gemini "@bluebottle ..." < /dev/null)`) timed out at 30s. The `bluebottle()` function in `gemini-agents.zsh` (line 124) is the primary live instance of this pattern — it calls `gemini "@bluebottle $content"` without `-p`.

**Class A — NOT confirmed:** gemini 0.49.0 with `-p` flag ignores open stdin. Probes 3a and 3b both returned "pong" with exit 0. This version does not block on stdin when `-p` is given.

**Class D — NOT the primary cause, but latent curl risk present:** API keys are visible in bare bash (exported via `~/.config/zsh/.env/secrets.zsh`). No OAuth wait occurs. However, `processor.sh` `_gai_rest_call()` and `bluebottle.zsh` PATH 1 both invoke `curl` without `--max-time` or `--connect-timeout` — a network stall would hang indefinitely. This is a latent risk, not the current failure mode.

### Ranking (most to least likely cause of observed 20-min hangs):
1. **Class C** — @agent in prompt triggers agentic loop; confirmed at 90s timeout
2. **Class B** — no -p flag in captured invocations (gemini-agents.zsh `bluebottle()`, old invocation patterns)
3. **Class D (curl)** — latent; not the current failure but will manifest under network stall

---

## ai_scripts Note

`/home/hruzam/reposoma/ai_scripts/` is an untracked directory (confirmed in git status at session start) containing a nascent Gemini agent script layer. Five files:

- **processor.sh** — shared helper library: `_gai_api_key()`, `_gai_payload()`, `_gai_rest_call()`, `_gai_strip_noise()`, `_gai_extract()`. The REST call uses `GOOGLE_API_KEY` and targets `gemini-2.5-flash` URL hardcoded (model parameter in `_gai_payload` is assembled into the JSON body but the URL in `_gai_rest_call` is hardcoded to `gemini-2.5-flash` regardless). Curl has **no `--max-time` or `--connect-timeout`**. This is the Class D latent hang vector.
- **bluebottle.sh** — three-mode script: UI (no -p), REST headless (good), CLI fallback with `gemini -p "@bluebottle ..."` (correct use of -p, but triggers Class C). REST-primary path is sound if GOOGLE_API_KEY is in env.
- **orby.sh / vega.sh** — two-mode: UI or headless (REST primary, CLI fallback with `-p`). CLI fallback for orby/vega will trigger Class C.
- **astrobley.sh** — same pattern; additionally references model string `"gemini-3.5-flash"` which **does not exist** (correct string is `gemini-2.5-flash`). REST call to this model will return 404 and fall through to CLI fallback, triggering Class C.

These scripts are the rebuilt layer (reposoma Gemini rebuild task). They are at an early/stub state — correct REST-primary architecture, but `processor.sh` needs `--max-time` added to curl, and the CLI fallback paths all carry Class C risk for any @agent invocation.

---

## Additional Findings (not asked, surfaced once)

**ImportProcessor errors on every probe:** All CLI probes (including plain `-p` with no agent) print:
```
[ERROR] [ImportProcessor] Failed to import Trajectory: ENOENT: no such file or directory, access '/home/hruzam/reposoma/Trajectory'
[ERROR] [ImportProcessor] Failed to import Delta.: ENOENT: no such file or directory, access '/home/hruzam/reposoma/Delta.'
```
Root cause: gemini CLI loads `GEMINI.md` from cwd (`/home/hruzam/reposoma/`). `GEMINI.md` starts with `@AGENTS.md` (an import directive). `AGENTS.md` line 24 contains the text `@Trajectory / @Delta.` (naming agents as prose), which the gemini ImportProcessor parses as file import directives relative to cwd. The files don't exist. Errors are non-fatal but produce noise on every invocation. Planning authority should decide whether to escape these in AGENTS.md or ignore.

**`gemini-agents.zsh` `bluebottle()` function (line 124):** Calls gemini without `-p`. This is the live invocation path for the `bluebottle` shell alias and the gemini-cross-check agent. When called from a script or command substitution, this is Class B confirmed.
