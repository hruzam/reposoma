# raw.superset — parked substrate

## What .superset was

Superset was a terminal multiplexer / AI-agent hub — an Electron AppImage that wraps agent CLIs
(claude, gemini, codex, copilot, cursor-agent, opencode, amp, droid, mastracode) in a unified
terminal UI with lifecycle event notifications. It achieved this by: (a) prepending
`~/.superset/bin/` shim wrappers to PATH via injected zsh ZDOTDIR wrappers, and (b) registering
hooks in each agent's settings file to POST agent lifecycle events (SessionStart, Stop,
PermissionRequest, AfterTool, etc.) to a local host-service daemon at 127.0.0.1:51741 or a v2
endpoint at `$SUPERSET_HOST_AGENT_HOOK_URL`. The approach is being retired because a native
team/user UI is being built that fulfills the same intent without external hook injection.

## Provenance

- host: hruzam-120922 (see `echo $MACHINE_NAME` for the per-machine canonical var — decision 0003)
- date parked: 2026-06-19
- source: ~/.superset/ on hruzam-120922
- reason: redundant-with-UI; salvage candidate for later inspection / Picasso repurpose

## What is NOT here (by design)

The following were excluded from this substrate to avoid parking secrets or volatile runtime state:
- `~/.superset/auth-token.enc` — encrypted auth token (SECRET)
- `~/.superset/terminal-host.token` — host token (SECRET)
- `~/.superset/local.db` — runtime SQLite DB (~233KB)
- `~/.superset/tanstack-db.sqlite` — tanstack DB (~1.6MB)
- `~/.superset/host/` — per-host SQLite DBs with WAL files
- `~/.superset/daemon.log` — ephemeral process log
- `~/.superset/terminal-host.pid`, `terminal-host.sock` — PID/socket files
- `~/.superset/window-state.json`, `app-state.json` — UI state (app-state contains only theme/hotkeys, no secrets)
- `~/.superset/project-icons/` — empty at time of salvage

## Contents of this substrate

```
hooks/
  notify.sh              — v3 universal agent notify script (Claude/Codex/Droid/Mastra)
  gemini-hook.sh         — v3 Gemini CLI hook (stdin JSON → stdout JSON required)
  copilot-hook.sh        — v2 GitHub Copilot CLI hook
  cursor-hook.sh         — v3 Cursor agent hook
  opencode/plugin/
    superset-notify.js   — v8 OpenCode JS plugin (session-scoped, deduplicating)

zsh/
  zshrc                  — original name: .zshrc  (ZDOTDIR wrapper)
  zshenv                 — original name: .zshenv
  zlogin                 — original name: .zlogin (includes OSC 133/777 prompt markers)
  zprofile               — original name: .zprofile

bin/
  claude, gemini, codex, amp, droid, mastracode, opencode, cursor-agent, copilot
                         — shim wrappers: find real binary, export SUPERSET_AGENT_ID, exec

hook-registrations/
  claude-settings.json   — verbatim hooks block from ~/.claude/settings.json (env-guarded)
  gemini-settings.json   — verbatim hooks block from ~/.gemini/settings.json (unconditional)
```

## Hook registration notes

The Claude hooks (`~/.claude/settings.json`) use an env guard:
  `[ -n "$SUPERSET_HOME_DIR" ] && ... || true`
They reference `$SUPERSET_HOME_DIR` (not `~/.superset` directly), so they are no-ops when that
variable is unset. They are LOW severity for disruption outside Superset context.

The Gemini hooks (`~/.gemini/settings.json`) use absolute paths with NO env guard:
  `/home/hruzam/.superset/hooks/gemini-hook.sh`
They fire unconditionally. If the daemon is dead (stale context or Superset not running), each
hook call exhausts two curl timeouts (2s + 1s) on EVERY SessionStart/BeforeAgent/AfterAgent/AfterTool.
This is the PRIMARY source of startup and per-tool-use stalls.

## De-conflict actions taken (2026-06-19)

### Claude — DONE

The entire `hooks` key (lines 1-76 of the original) was removed from `~/.claude/settings.json`.
All other keys (effortLevel, advisorModel, fallbackModel, showThinkingSummaries, theme,
skipWorkflowUsageWarning, permissions) are untouched.

Backup: `~/.claude/settings.json.superset.bak`

Reversal (Claude):
  cp ~/.claude/settings.json.superset.bak ~/.claude/settings.json

### Gemini — NOT DONE (blocked; operator action required)

`~/.gemini/settings.json` was NOT modified. The sandbox denied write access to `~/.gemini/`.
The Gemini hooks remain active. This is the higher-severity disturbance — they fire
unconditionally on every BeforeAgent/AfterAgent/AfterTool/SessionStart event with no env
guard, causing multi-second stalls per tool-use when the Superset daemon is not running.

Verbatim backup of the original is in `hook-registrations/gemini-settings.json`.

Operator action to finish Gemini de-conflict — make this edit to ~/.gemini/settings.json,
removing lines 9-60 (the entire "hooks" key), leaving selectedAuthType and security intact:

BEFORE (lines 9-60 to remove):
  "hooks": {
    "SessionStart": [...], "SessionEnd": [...],
    "BeforeAgent": [...], "AfterAgent": [...], "AfterTool": [...]
  }

AFTER (file should end):
  {
    "selectedAuthType": "gemini-api-key",
    "security": {
      "auth": {
        "selectedType": "gemini-api-key",
        "apiKey": "${GEMINI_API_KEY}"
      }
    }
  }

No reversal needed for Gemini (unchanged). If you want to restore hooks later, the verbatim
original is in hook-registrations/gemini-settings.json in this substrate.

## Re-injection risk

The Superset `.zlogin` wrapper states: "Wrappers are rewritten on every app launch."
This means if the Superset AppImage is launched again, it will re-inject hooks into
both settings.json files. The de-conflict fix is durable only while Superset is not relaunched.
Long-term: either uninstall Superset or ensure ZDOTDIR does not point at ~/.superset/zsh.
