#!/usr/bin/env bash
# ARCHIVED VERBATIM 2026-07-31 · was ~/ia-sync/zsh/ai/vega.sh (deployed ~/.config/zsh/ai/) ·
# fate: DELETED from composer — Vega chair vendor-shifted to Codex (0005 A1); the seat name now
# lives at ~/.claude/agents/vega.md. Launcher was already PARKED since 2026-07-24. Nothing here
# is needed by the Codex claude gates (pure Gemini REST path). — vignette: the calibration star's
# first vendor body.

# ⚠ GEMINI LINE PARKED 2026-07-24 — vendor seat re-bound to Codex/GPT (reposoma: temple/decisions/0005 A1).
# Tokens refunded; API line off. Override for archaeology only: GEMINI_LINE_FORCE=1

if [[ -z "$GEMINI_LINE_FORCE" ]]; then
	print -u2 "gemini-line PARKED 2026-07-24 — see reposoma maintenance/codex-line/ (override: GEMINI_LINE_FORCE=1)"
	return 2 2>/dev/null || exit 2
fi

# vega.sh — thinking advisor
# Model: gemini-2.5-pro (from handoff MODEL ASSIGNMENTS)
# Two modes:
#   no arg  → UI session (interactive gemini — needs TTY, do NOT add < /dev/null)
#   with arg → headless one-shot (REST primary, graceful fail on REST failure)
#
# P1 (2026-07-03): NO gemini CLI invocation in any headless path.
# Class C hang confirmed: @agent prompt triggers agentic loop even with -p.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/gemini-processor.sh" 2>/dev/null || true

_MODEL="gemini-2.5-pro"

if [[ $# -eq 0 ]]; then
    # UI mode — interactive; stdin needed; no < /dev/null here
    GEMINI_MODEL="${_MODEL}" gemini "@vega"
else
    # Headless one-shot
    _INPUT="$*"
    _KEY=$(_gai_api_key) || { echo "[UNAVAILABLE: no API key]"; exit 0; }
    _PAYLOAD=$(_gai_payload "${_MODEL}" "0.7" "${_INPUT}")
    _RESULT=$(_gai_rest_call "${_PAYLOAD}" "${_MODEL}") || {
        echo "[UNAVAILABLE: REST call failed for ${_MODEL}]"
        exit 0
    }
    _gai_extract "${_RESULT}"
fi
