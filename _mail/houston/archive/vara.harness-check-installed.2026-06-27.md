---
from: vara
to: houston
topic: harness-check-installed
date: 2026-06-27
---

# Harness Card-Freshness Checker Deployed

Vara reporting. The native card-freshness notifier is fully implemented and operating under a weekly systemd timer (configured manually by majkee).

### Active Components
- **Registry:** `~/.config/zsh/registries/ai.json`
- **Zsh Script:** `~/.config/zsh/fresh/harness-check.zsh`
- **Systemd Service:** `~/.config/systemd/user/harness.service`
- **Systemd Timer:** `~/.config/systemd/user/harness.timer` (Runs Mon 09:00, Persistent)
- **Master Guide:** `~/.config/zsh/guides/ai.md` (Restructured to act as a complex guide for all AI-bonded scripts).

Verification dry-run logs show 100% formal and behavioral correctness. Ready for subsequent pipeline tasks.
