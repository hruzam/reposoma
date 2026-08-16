#!/usr/bin/env bash
# ⚠ RETIRED 2026-08-15 — folded into ~/ia-sync/zsh/ai/rc.sh (deployed ~/.config/zsh/ai/rc.sh)
#   + the /rc-launch skill. Use those; this file is kept only as provenance for the finding
#   recorded in remote-control-spawn.md. Do not extend it.
#
# spawn-rc-term.sh — hold a Claude remote-control session in a tmux pty,
# reachable three ways from anywhere:
#   • Remote Control  — claude.ai session URL (any host, no terminal)
#   • ssh + attach    — home→office over tailscale (a living terminal, cross-host)
#   • konsole viewport — on the office desktop (optional, needs display)
#
# WHY A MUX, NOT `script`:
#   tmux allocates a REAL pty, so `claude --remote-control` gets a genuine
#   interactive TTY and pairs — it does NOT fall back to --print. Unlike
#   `script -qec`, tmux keeps a reattach handle, needs no display for the
#   ssh/RC paths, and survives your disconnect. The mux is the LIFE of the
#   session; ssh / Remote Control / konsole are all just viewports onto it.
#
# NAMING: the tool is tmux; public-facing naming stays larvaTnux (rule 20).
#         session slug is neutral: rc-<basename>.
#
# PROVENANCE: applications-in-common session, majkee mobile+home/tailscale, 2026-08-14.
#
# USAGE:  spawn-rc-term.sh <dir> [agent] [model]
#           agent default: flight    model default: opus
set -euo pipefail

DIR="${1:?usage: spawn-rc-term.sh <dir> [agent] [model]}"
AGENT="${2:-flight}"
MODEL="${3:-opus}"

DIR="${DIR/#\~/$HOME}"
[ -d "$DIR" ] || { echo "FAIL: no such dir: $DIR" >&2; exit 1; }
command -v tmux   >/dev/null || { echo "FAIL: tmux not found" >&2; exit 1; }
command -v claude >/dev/null || { echo "FAIL: claude not on PATH" >&2; exit 1; }

SLUG="rc-$(basename "$DIR")"

if tmux has-session -t "$SLUG" 2>/dev/null; then
  echo "note: session '$SLUG' already alive — reusing. (kill: tmux kill-session -t $SLUG)"
else
  tmux new-session -d -s "$SLUG" -c "$DIR" \
    "claude --agent $AGENT --model $MODEL --remote-control"
fi

# rendering polish (the pane IS the app, so drop tmux's own chrome; pass truecolor)
tmux set-option -ga terminal-overrides ",*:Tc"   2>/dev/null || true  # truecolor through
tmux set-option -g  default-terminal "tmux-256color" 2>/dev/null || true
tmux set-option -ga terminal-features "*:RGB"     2>/dev/null || true  # truecolor as feature
tmux set-option -g  allow-passthrough on          2>/dev/null || true  # graphics/logo passthrough
tmux set-option -t "$SLUG" status off             2>/dev/null || true  # no status bar
# NOTE: glyphs (spinner/pointers/logo) need the CLIENT in UTF-8 — attach with `tmux -u`
#       (ssh often drops the locale over the hop). The printed attach lines include it.

# office identity for the ssh line (tailscale name if resolvable, else hostname)
# best-effort: `|| true` so pipefail+set-e can't abort the report block.
HOST=""
if command -v jq >/dev/null 2>&1 && command -v tailscale >/dev/null 2>&1; then
  HOST="$(tailscale status --json 2>/dev/null | jq -r '.Self.DNSName // empty' | sed 's/\.$//' || true)"
fi
HOST="${HOST:-$(hostname)}"

# RC url is best-effort only: claude's full-screen TUI uses the alternate screen
# buffer, so capture-pane usually can't see the startup URL line. Your real reach
# is ssh+attach below; the URL is visible on the session's first screen once you
# attach, or via `claude` remote-control listing. `|| true` guards set -e/pipefail.
sleep 3
URL="$(tmux capture-pane -p -t "$SLUG" 2>/dev/null \
        | grep -oE 'https://claude\.ai/code/session_[A-Za-z0-9]+' | head -1 || true)"

echo "OK: '$SLUG' held in tmux — real pty, agent=$AGENT model=$MODEL"
echo
echo "  reach it (your path first):"
echo "   • home→office    : ssh ${HOST} -t 'tmux -u -2 attach -t $SLUG'"
echo "   • office desktop : WAYLAND_DISPLAY=wayland-0 XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR konsole -e tmux -u -2 attach -t $SLUG"
echo "   • Remote Control : ${URL:-<visible on first screen once you attach>}"
echo
echo "  detach from an attached view: Ctrl-b d      stop for good: tmux kill-session -t $SLUG"
