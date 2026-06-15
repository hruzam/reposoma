# npm prefix fix — Claude Code auto-update

**Date:** 2026-06-15  
**Status:** Applied, pending verification on next Claude Code launch

## Symptom

Bottom-right UI message on Claude Code startup:
> `Auto-update failed: no write permission to npm prefix · Run /doctor`

## Root cause

npm was deriving its global prefix from the system node binary location (`/usr/bin/node` → prefix `/usr`), which is root-owned. Claude Code's auto-updater could not write there.

`~/.npm-global` was already set up with packages installed (claude, gemini-cli, repomix, etc.), but `~/.npmrc` was never created — so npm didn't know to use it as the prefix.

## Changes applied

| File | Change |
|------|--------|
| `~/.npmrc` | Created with `prefix=~/.npm-global` |
| `~/.zshrc:434` | Uncommented `export PATH=~/.npm-global/bin:$PATH` |

## Verification steps

1. Source the shell: `source ~/.zshrc`
2. Confirm prefix: `npm config get prefix` → should return `/home/hruzam/.npm-global`
3. Launch Claude Code — auto-update error should be gone on next update check
4. Or run `/doctor` inside Claude Code to confirm no issues

## Notes

- Node is system-installed via pacman (`nodejs 26.2.0-1`) — untouched
- This is the canonical approach from npm docs for Linux systems without nvm/volta
- All existing global packages remain in `~/.npm-global` — nothing was reinstalled
