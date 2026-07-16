# TASK — Phase 1 Track B: Per-Agent Scripts
# Gemini Rebuild — Agent Launchers

**Executor:** Gemini team or second Claude session  
**Status:** SUPERSEDED — completed via fix-pass 2026-07-03. DO NOT EXECUTE: CLI-fallback pattern in this spec (`gemini "@agent ..."`) is a confirmed hang — see hang addendum + fix-pass report.  
**Input:** `reposoma/_mail/toAll/inbox/handoff.gemini-rebuild.md` (Epoch Phase 0 output)  
**Parallel with:** Track A (infrastructure) — no coordination needed beyond shared handoff

---

## Pre-flight: read the handoff

Open `reposoma/_mail/toAll/inbox/handoff.gemini-rebuild.md` first. Extract:

| Decision | Source section |
|---|---|
| Script extension + shebang | `## CONSOLIDATED SCRIPTING VERDICT` |
| Model for each seat | `## MODEL ASSIGNMENTS` |
| Headless invocation pattern | `## Q1 — Headless invocation` recommendation |
| REST endpoint + auth + response path | `## Q7 — REST API` |
| `--raw` flag exact syntax | `## Q1` |

All `[SPEC]` markers below are governed by these findings. Do not assume — the handoff is the source of truth.

---

## Scope

Working directory: `~/.config/zsh/ai/`

4 scripts. Each script: **two modes** — no arg = UI session launch, with arg = headless one-shot.

Also reads: `~/.config/zsh/ai/processor.{ext}` (Track A output) for shared REST functions. If processor.{ext} is not yet available when you start, stub the common functions inline and note for reconciliation.

---

## Script pattern (apply to all four)

```bash
#!/usr/bin/env {SPEC}

# <name>.{ext} — <seat description>
# Model: <model> (from handoff MODEL ASSIGNMENTS)
# Two modes:
#   no arg  → UI session (interactive gemini with agent persona)
#   with arg → headless one-shot (REST primary, CLI fallback)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/processor.{ext}" 2>/dev/null || true  # graceful if not yet deployed

_MODEL="<model>"   # from handoff MODEL ASSIGNMENTS

if [[ $# -eq 0 ]]; then
    # UI mode
    GEMINI_MODEL="${_MODEL}" gemini "@<name>"
else
    # headless one-shot (REST primary)
    _INPUT="$*"
    _KEY=$(_gai_api_key) || { echo "[UNAVAILABLE: no API key]"; exit 1; }
    _PAYLOAD=$(_gai_payload "${_MODEL}" "0.3" "${_INPUT}")
    _RESULT=$(_gai_rest_call "${_PAYLOAD}") || {
        # CLI fallback
        _RESULT=$(GEMINI_MODEL="${_MODEL}" gemini -p "${_INPUT}" 2>&1 | _gai_strip_noise)
    }
    _gai_extract "${_RESULT}"
fi
```

Adapt per-script: model, temperature, yolo flag for astrobley, `--raw` mode for bluebottle.

---

## Script 1 — `bluebottle.{ext}` (fast synthesizer)

**Model:** [SPEC from handoff — expected: `gemini-2.5-flash`]  
**Temperature:** 0.3 (cross-check precision)  
**Persona file:** `~/.gemini/agents/bluebottle.md`

**Three modes:**

1. **No arg** → UI session: `GEMINI_MODEL="${_MODEL}" gemini "@bluebottle"`
2. **With arg, no `--raw`** → headless synthesis (REST with persona injected as systemInstruction from `~/.gemini/agents/bluebottle.md`)
3. **`--raw` flag** → headless research pass (REST WITHOUT system instruction — no persona, open research mode)

```bash
if [[ $# -eq 0 ]]; then
    GEMINI_MODEL="${_MODEL}" gemini "@bluebottle"
elif [[ "$1" == "--raw" ]]; then
    shift
    _INPUT="$*"
    _KEY=$(_gai_api_key) || { echo "[UNAVAILABLE: no API key]"; exit 1; }
    _PAYLOAD=$(_gai_payload "${_MODEL}" "0.7" "${_INPUT}")  # no system instruction
    _RESULT=$(_gai_rest_call "${_PAYLOAD}") || {
        _RESULT=$(GEMINI_MODEL="${_MODEL}" gemini --raw -p "${_INPUT}" 2>&1 | _gai_strip_noise)
    }
    _gai_extract "${_RESULT}"
else
    # headless synthesis with persona
    _INPUT="$*"
    _PERSONA=$(cat ~/.gemini/agents/bluebottle.md 2>/dev/null | grep -A9999 "^---" | tail -n +2)
    _KEY=$(_gai_api_key) || { echo "[UNAVAILABLE: no API key]"; exit 1; }
    _PAYLOAD=$(_gai_payload "${_MODEL}" "0.3" "${_INPUT}" "${_PERSONA}")
    _RESULT=$(_gai_rest_call "${_PAYLOAD}") || {
        _RESULT=$(GEMINI_MODEL="${_MODEL}" gemini "@bluebottle ${_INPUT}" 2>&1 | _gai_strip_noise)
    }
    _gai_extract "${_RESULT}"
fi
```

**Critical:** This script replaces `bluebottle.zsh` and is called by `reposoma/.claude/agents/gemini-cross-check.md`. The external call path will be updated in Phase 2. Ensure single-file-arg invocation works: `bash bluebottle.{ext} /tmp/some-file.md` reads the file content and runs synthesis.

Output prefix on success: `## @BlueBottle cross-check\n\n<synthesis>` — preserve this, `gemini-cross-check.md` parses it.

---

## Script 2 — `vega.{ext}` (thinking advisor)

**Model:** [SPEC from handoff — expected: `gemini-2.5-pro`]  
**Temperature:** 0.7 (reasoning depth)  
**Persona file:** `~/.gemini/agents/vega.md`

Two modes only (no raw, no yolo):
1. No arg → UI session
2. With arg → headless one-shot

---

## Script 3 — `orby.{ext}` (researcher)

**Model:** [SPEC from handoff — expected: `gemini-2.5-flash`]  
**Temperature:** 0.5  
**Persona file:** `~/.gemini/agents/orby.md`

Two modes only:
1. No arg → UI session
2. With arg → headless one-shot

---

## Script 4 — `astrobley.{ext}` (implementer)

**Model:** [SPEC from handoff — see `## MODEL ASSIGNMENTS` — may be pro or flash; handoff resolves]  
**Temperature:** 0.3 (implementation precision)  
**Persona file:** `~/.gemini/agents/astrobley.md`

Three modes:
1. No arg → UI session (normal)
2. With arg → headless one-shot
3. `--yolo` flag → with `--approval-mode yolo` (preserve from current `astro-yolo()`)

```bash
if [[ $# -eq 0 ]]; then
    GEMINI_MODEL="${_MODEL}" gemini "@astrobley"
elif [[ "$1" == "--yolo" ]]; then
    shift
    GEMINI_MODEL="${_MODEL}" gemini --approval-mode yolo "@astrobley $*"
else
    # headless one-shot (REST primary)
    ...
fi
```

---

## File permissions

All scripts must be executable:
```bash
chmod +x ~/.config/zsh/ai/bluebottle.{ext}
chmod +x ~/.config/zsh/ai/vega.{ext}
chmod +x ~/.config/zsh/ai/orby.{ext}
chmod +x ~/.config/zsh/ai/astrobley.{ext}
```

---

## Sign-off criteria

- [ ] `bash ~/.config/zsh/ai/bluebottle.{ext} "test synthesis blob"` → exits 0, outputs `## @BlueBottle cross-check` header
- [ ] `bash ~/.config/zsh/ai/bluebottle.{ext} --raw "test research"` → exits 0, no persona header
- [ ] `bash ~/.config/zsh/ai/vega.{ext} "test question"` → exits 0
- [ ] `bash ~/.config/zsh/ai/orby.{ext} "test question"` → exits 0
- [ ] `bash ~/.config/zsh/ai/astrobley.{ext} "test task"` → exits 0
- [ ] `bash ~/.config/zsh/ai/astrobley.{ext} --yolo "test task"` → triggers yolo mode
- [ ] File-arg for bluebottle: `bash bluebottle.{ext} /tmp/test.md` → reads file, runs synthesis

Report to: Phase 2 finalize file sign-off section — add "Track B: DONE — [date]"
