CS · 2026-07-28 · secrets vault for ~/.config/zsh/.env/

commit : d266726 (core)
task   : password-gate the zsh secrets folder — sudo-style session lock
context: Plan is WRITTEN and unapproved — /home/hruzam/.claude/plans/starry-roaming-sprout.md
         Nothing executed, nothing on disk changed.
         Decided: gpg symmetric + gpg-agent cache (NOT gocryptfs — umount races /rc,
         autolock could silently no-op). Zero new packages, gpg + pinentry-curses already there.
         Your X: locked at boot, first terminal prompts, autolock on sleep/hibernate,
         unlock over tailscale SSH from home, /rc + agents reach it once unlocked.
         Live hole still open: .env/ is 755, secrets.zsh + secrets.json are 644 =
         world-readable right now. Phase 1 is just chmod — worth doing even if the rest waits.
         Parked: /home has no LUKS (plain ext4) · 4 of 6 keys have zero consumers ·
         secrets.json is dead AND invalid JSON, settle its purpose before adding lines ·
         prod-DB-via-MCP needs its own gavel + challenger pass.
resume : claude --agent flight → read the plan file → ExitPlanMode
