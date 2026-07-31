#!/usr/bin/env bash
# ARCHIVED VERBATIM 2026-07-31 · was ~/ia-sync/zsh/ai/astrobley.sh (deployed ~/.config/zsh/ai/) ·
# fate: DELETED from composer — Astrobley chair vendor-shifted to Codex; the seat name now lives at
# ~/.claude/agents/astrobley.md. Launcher was already PARKED since 2026-07-24. The --patch ledger
# protocol below (multi-turn JSON ledger + persona systemInstruction, gaveled 2026-07-03) is the
# "inner git system" majkee flagged as over-engineering on the dead Gemini line — preserved here as
# the fullest surviving specimen of that protocol. Persona file archived alongside
# (2026-07-31.astrobley-patch.persona.md, kraken mv). Nothing here is needed by the Codex claude gates.

# ⚠ GEMINI LINE PARKED 2026-07-24 — vendor seat re-bound to Codex/GPT (reposoma: temple/decisions/0005 A1).
# Tokens refunded; API line off. Override for archaeology only: GEMINI_LINE_FORCE=1

if [[ -z "$GEMINI_LINE_FORCE" ]]; then
	print -u2 "gemini-line PARKED 2026-07-24 — see reposoma maintenance/codex-line/ (override: GEMINI_LINE_FORCE=1)"
	return 2 2>/dev/null || exit 2
fi

# astrobley.sh — implementer
# Model: gemini-3.5-flash (GA since 2026-05-19; confirmed HTTP 200 on key 2026-07-03)
# Four modes:
#   no arg           → UI session (interactive gemini — needs TTY, do NOT add < /dev/null)
#   --yolo           → UI session with --approval-mode yolo (interactive)
#   --patch <ledger> [msg] → patch-protocol multi-turn (REST only, model pinned gemini-3.5-flash)
#   with arg         → headless one-shot (REST primary, graceful fail on REST failure)
#
# P1 (2026-07-03): NO gemini CLI invocation in any headless path.
# Class C hang confirmed: @agent prompt triggers agentic loop even with -p.
# P4 (2026-07-03): gemini-3.5-flash confirmed GA + HTTP 200 via key enumeration.
#   Triage's 404 claim was based on CLI routing, not REST probe — REST confirms 200.
#
# --patch mode (gaveled 2026-07-03):
#   model=gemini-3.5-flash pinned (ignore GEMINI_MODEL env)
#   persona: ~/.config/zsh/ai/personas/astrobley-patch.md
#   ledger: JSON multi-turn conversation (Gemini contents[] format)
#   ceiling: 4 iterations / ~50K tokens (documented; driver loop is caller's responsibility)
#   ceiling guard: warn on stderr if ledger > 200KB

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/gemini-processor.sh" 2>/dev/null || true

_MODEL="gemini-3.5-flash"

if [[ $# -eq 0 ]]; then
    # UI mode — interactive; stdin needed; no < /dev/null here
    GEMINI_MODEL="${_MODEL}" gemini "@astrobley"

elif [[ "$1" == "--yolo" ]]; then
    shift
    # UI mode with yolo — interactive; positional arg seeds REPL session
    GEMINI_MODEL="${_MODEL}" gemini --approval-mode yolo "@astrobley $*"

elif [[ "$1" == "--patch" ]]; then
    shift
    _LEDGER="${1:-}"
    if [[ -z "${_LEDGER}" ]]; then
        echo "[astrobley --patch] usage: astrobley.sh --patch <ledger.json> [\"message\"]" >&2
        exit 1
    fi
    shift 2>/dev/null || true
    _MESSAGE="${*:-}"

    _PATCH_MODEL="gemini-3.5-flash"  # pinned, gaveled — do not read GEMINI_MODEL env
    _PERSONA_FILE="${HOME}/.config/zsh/ai/personas/astrobley-patch.md"

    # Size guard: warn if ledger > 200KB (~50K-token ceiling)
    # Use -s (non-empty) not -f to avoid counting mktemp-created empty files.
    if [[ -s "${_LEDGER}" ]]; then
        _LEDGER_BYTES=$(wc -c < "${_LEDGER}" 2>/dev/null || echo 0)
        if (( _LEDGER_BYTES > 204800 )); then
            echo "ledger approaching ~50K-token ceiling — trim or split task" >&2
        fi
    fi

    # Ledger state machine (-s = file exists AND non-empty):
    # missing/empty + message → create ledger with first user turn
    # non-empty + message     → append user turn
    # non-empty + no msg      → send as-is (re-fire after 503)
    # missing/empty + no msg  → error
    if [[ ! -s "${_LEDGER}" && -n "${_MESSAGE}" ]]; then
        jq -n --arg msg "${_MESSAGE}" \
            '{"contents":[{"role":"user","parts":[{"text":$msg}]}]}' > "${_LEDGER}"
    elif [[ -s "${_LEDGER}" && -n "${_MESSAGE}" ]]; then
        jq --arg msg "${_MESSAGE}" \
            '.contents += [{"role":"user","parts":[{"text":$msg}]}]' \
            "${_LEDGER}" > "${_LEDGER}.tmp" && mv "${_LEDGER}.tmp" "${_LEDGER}"
    elif [[ ! -s "${_LEDGER}" && -z "${_MESSAGE}" ]]; then
        echo "[UNAVAILABLE: ledger ${_LEDGER} not found and no message given]"
        exit 0
    fi
    # else: ledger non-empty, no message — fall through and re-fire

    # Read persona (plain text; operator-tunable)
    _PERSONA=""
    if [[ -f "${_PERSONA_FILE}" ]]; then
        _PERSONA=$(cat "${_PERSONA_FILE}")
    fi

    # Build multi-turn payload from ledger contents[] + persona as systemInstruction
    _KEY=$(_gai_api_key) || { echo "[UNAVAILABLE: no API key]"; exit 0; }
    _CONTENTS=$(jq '.contents' "${_LEDGER}")
    _PAYLOAD=$(jq -n \
        --arg persona "${_PERSONA}" \
        --argjson contents "${_CONTENTS}" \
        '{"systemInstruction":{"parts":[{"text":$persona}]},"contents":$contents,"generationConfig":{"temperature":0.2}}')

    _RESULT=$(_gai_rest_call "${_PAYLOAD}" "${_PATCH_MODEL}") || {
        # Failure: ledger left un-appended (model turn only) so re-fire is clean
        echo "[UNAVAILABLE: REST call failed for ${_PATCH_MODEL}]"
        exit 0
    }

    # Print response to stdout only, then append model turn to ledger
    _RESPONSE=$(_gai_extract "${_RESULT}")
    printf '%s\n' "${_RESPONSE}"
    jq --arg text "${_RESPONSE}" \
        '.contents += [{"role":"model","parts":[{"text":$text}]}]' \
        "${_LEDGER}" > "${_LEDGER}.tmp" && mv "${_LEDGER}.tmp" "${_LEDGER}"

else
    # Headless one-shot
    _INPUT="$*"
    _KEY=$(_gai_api_key) || { echo "[UNAVAILABLE: no API key]"; exit 0; }
    _PAYLOAD=$(_gai_payload "${_MODEL}" "0.3" "${_INPUT}")
    _RESULT=$(_gai_rest_call "${_PAYLOAD}" "${_MODEL}") || {
        echo "[UNAVAILABLE: REST call failed for ${_MODEL}]"
        exit 0
    }
    _gai_extract "${_RESULT}"
fi
