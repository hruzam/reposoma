#!/usr/bin/env bash
# spawn-rc.sh — launch a headless Claude Code remote-control session under a PTY.
#
# WHY THIS EXISTS
#   `claude --remote-control` is an INTERACTIVE session. A Bash/tool context with
#   no controlling terminal (agent-driven, cron, ssh -T, mobile relay) makes claude
#   silently fall back to --print mode, which then dies with:
#       "Input must be provided either through stdin or as a prompt argument"
#   `script -qec` allocates a pseudo-TTY, so the interactive session boots and
#   registers with Remote Control — attachable from a phone / another client.
#
# PROVENANCE
#   applications-in-common session, majkee mobile-driven, 2026-08-14.
#   First working run: ~/unikuklatrix/nablarva, agent=flight model=opus.
#
# USAGE
#   spawn-rc.sh <dir> [agent] [model]
#     dir     target project directory (required)
#     agent   Claude agent name        (default: flight)
#     model   model alias or full name (default: opus)
#
# EXAMPLES
#   spawn-rc.sh ~/unikuklatrix/nablarva
#   spawn-rc.sh ~/unikuklatrix/nablarva flight opus
#   spawn-rc.sh ~/www/some-project vara sonnet
set -euo pipefail

DIR="${1:?usage: spawn-rc.sh <dir> [agent] [model]}"
AGENT="${2:-flight}"
MODEL="${3:-opus}"

# Expand ~ if passed literally, then verify.
DIR="${DIR/#\~/$HOME}"
[ -d "$DIR" ] || { echo "FAIL: no such directory: $DIR" >&2; exit 1; }
command -v script >/dev/null || { echo "FAIL: 'script' (util-linux) not found" >&2; exit 1; }
command -v claude >/dev/null || { echo "FAIL: 'claude' CLI not on PATH" >&2; exit 1; }

LOG="/tmp/claude-rc.$(basename "$DIR").log"
MATCH="claude --agent $AGENT .* --remote-control"

cd "$DIR"
setsid script -qec "claude --agent $AGENT --model $MODEL --remote-control" "$LOG" >/dev/null 2>&1 &
sleep 5

if pgrep -f "$MATCH" >/dev/null; then
  RC_PID="$(pgrep -f "$MATCH" | head -1)"
  echo "OK: remote-control session up"
  echo "    dir=$DIR  agent=$AGENT  model=$MODEL  pid=$RC_PID"
  echo "    log=$LOG   (empty is normal — interactive TUI, not plain text)"
  echo "    attach from your remote-control client now."
  echo "    stop:  pkill -f '$MATCH'"
else
  echo "FAIL: session did not start — inspect $LOG" >&2
  exit 1
fi
