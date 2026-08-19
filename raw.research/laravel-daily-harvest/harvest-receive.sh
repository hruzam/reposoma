#!/usr/bin/env bash
# harvest-receive.sh — Taildrop → harvest/<ISO-week>/ auto-sorter
# Receives files from Tailscale Taildrop inbox, moves image files
# into the current ISO-week folder under the harvest directory.
#
# Usage:
#   harvest-receive.sh              — one-shot: drain inbox now
#   harvest-receive.sh --watch      — loop: drain every 10s (for systemd/tmux)
#
# Prereq: sudo tailscale set --operator=$USER  (one-time)

set -euo pipefail

HARVEST_ROOT="/home/hruzam/reposoma/raw.research/laravel-daily-harvest/harvest"
INBOX="/tmp/harvest-taildrop-inbox"

mkdir -p "$INBOX"

drain_inbox() {
  # Pull any waiting files from Taildrop
  tailscale file get --wait=false --conflict=rename "$INBOX" 2>/dev/null || true

  local week
  week="$(date +%G-W%V)"   # ISO-8601 week (e.g. 2026-W34)
  local dest="$HARVEST_ROOT/$week"

  # Find image files (screenshot formats Android uses)
  shopt -s nullglob
  local files=("$INBOX"/*.{png,jpg,jpeg,webp,PNG,JPG,JPEG,WEBP})
  shopt -u nullglob

  if [[ ${#files[@]} -eq 0 ]]; then
    return 0
  fi

  mkdir -p "$dest"

  local count=0
  for f in "${files[@]}"; do
    local base
    base="$(basename "$f")"
    # Prefix with timestamp to avoid collisions and preserve order
    local ts
    ts="$(date +%H%M%S)"
    local target="$dest/${ts}_${base}"

    # Avoid overwrite
    if [[ -e "$target" ]]; then
      target="$dest/${ts}_${RANDOM}_${base}"
    fi

    mv "$f" "$target"
    ((count++))
    echo "$(date '+%H:%M:%S') ✓ $base → $week/ ($count)"
  done

  echo "$(date '+%H:%M:%S') — $count file(s) sorted into $dest"
}

if [[ "${1:-}" == "--watch" ]]; then
  echo "harvest-receive: watching Taildrop inbox (Ctrl-C to stop)"
  echo "  harvest root: $HARVEST_ROOT"
  echo "  current week: $(date +%G-W%V)"
  while true; do
    drain_inbox
    sleep 10
  done
else
  drain_inbox
fi
