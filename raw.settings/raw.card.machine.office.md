---
card: machine.office
kind: machine-profile · RELATIVE (quarterly, refreshable manually or via guide update)
host: hruzam-120922
machine_name: office
verified: 2026-11-25
half_life_days: 90
guide: ~/.config/zsh/guides/office.md  # MISSING on office 2026-11-25 — locate or drop
---

# office machine — profile card

Machine-specific facts for `hruzam-120922` (office). For project paths → `temple-project-map.zsh`.
For logical project map → `registry/index.md`.

## Refresh delta 2026-11-25

Verified read-only over `ssh office`. Evidence / confidence per claim.

**Confirmed unchanged**
- Host `hruzam-120922` — `hostname` returned it (H). Manjaro Linux, kernel 7.1.13-2-MANJARO x86_64 (H; card had no kernel/OS, new fact).
- CPU i5-12400, 12 threads — lscpu (H). RAM 15 GiB — `free -h` (H).
- Tailscale IPv4 `100.126.182.111` — `tailscale ip -4` (H). Not in card body; confirmed for the record.
- Services nginx · php74-fpm · php-fpm · mariadb (12.3.3) · tailscaled · docker — all `active` AND `enabled` (H). Docker is running, not merely "available". dnsmasq also running (valet DNS).
- Sockets `~/.valet/valet.sock` + `valet74.sock` both present (H). `fantasyobchod` nginx override -> valet74.sock (H).
- CLI: `/usr/bin/php74` = PHP 7.4.33, `/usr/bin/php` = PHP 8.5.10, `/usr/bin/composer` 2.10.3 (H). `php74`/`php8`/`phpst` are zsh aliases (interactive shell only; absent in non-interactive ssh) (H).
- Valet v2.3.10; `paths` = `~/.valet/Sites` then `~/www` (H). `valet links` shows fantasyobchod, freya (H).
- Authoritative map `~/.config/zsh/ai/temple-project-map.zsh` exists (H).

**Drift**
- Disk: root 197G, 86G used = 46% (card ~42%); home 259G, 54G used = 22% (card ~14%) (H). Home grew ~8 pts.
- PHP 8.x is now 8.5.10 (card said only "8.x") (H).
- `psdvs.l` is NOT a valet site: `valet links` lists only fantasyobchod + freya; `~/www/psdvs` has only `ham`/`ham.devenv`, a `psdvs_laravel` dir exists (M — valet parks `~/www` subdirs so `psdvs_laravel.l`-style serving unverified).
- Extra nginx override `~/.valet/Nginx/imagosk` (imagosk.l + *.imagosk.l -> valet74.sock) not in card's PHP 7.4 sites list (H).
- `valet links` reports PHP column 8.5 for fantasyobchod despite the 7.4 override (override is nginx-level, so not a contradiction) (M).
- `~/.config/zsh/guides/office.md` (frontmatter `guide:`) does NOT exist on office; `guides/` holds index.md, keyboard.md, guide-for-builder.md etc. (H on office; not checked on home).
- `$MACHINE_NAME` empty in non-interactive ssh (M — probably set only in interactive shell).

**Adjacent facts checked (not in card)**
- `harness.timer` enabled, next run Mon 2026-11-30 09:06, last 2026-11-23 (H). claude 2.1.330, codex-cli 0.171.0, tmux 3.7c, node v26.8.1, zsh 5.9.2, git 2.55.0, jq 1.8.2 (H; claude/codex/tmux only via interactive zsh). gemini/agy not checked (PARTIAL).
- `~/ia-sync`, `~/reposoma`, `~/unikuklatrix` exist; `~/nablarva` does NOT exist on office (H). `~/www/imago_cz` holds fantasyobchod, freya, frafu.sync, etc.

**Not checked:** gemini/agy versions, claude-rc-*/piql-mcp user units, MCP servers, `valet use` boot-state claim, `.l` DNS resolution.
## 2026-07-15

**Hardware:**
- CPU: 12th Gen Intel Core i5-12400 (6 cores / 12 threads)
- RAM: 15 GiB
- Disk root: 197 GiB NVMe (~42% used) · home: 259 GiB NVMe (~14% used)

**PHP setup — dual FPM, simultaneous:**
- `php74-fpm` → `~/.valet/valet74.sock` — fantasyobchod.l (OpenCart, PHP 7.4)
- `php-fpm` (8.x) → `~/.valet/valet.sock` — freya.l, psdvs.l, all new Laravel
- CLI: `/usr/bin/php74` (AUR) · `/usr/bin/php` (PHP 8.x) · `/usr/bin/composer`
- Switch commands: `php74` · `php8` · `phpst` (status)
- ⚠ Never `valet use phpX` — breaks boot state on Arch (disables the other FPM silently)

**Valet domain:** `.l` — paths scan: `~/.valet/Sites/` (priority) + `~/www/` (fallback)

**Active services:** nginx · php74-fpm · php-fpm · mariadb · tailscaled · docker (available)

**PHP 7.4 sites** (need explicit nginx override in `~/.valet/Nginx/`):
- `fantasyobchod.l` → `valet74.sock`

**PHP 8.x sites** (default Valet routing, no override):
- `freya.l` · `psdvs.l` · any new Laravel project

**Project valet links** (run `valet links` to verify current state):
```bash
cd ~/www/imago_cz/fantasyobchod && valet link fantasyobchod
cd ~/www/imago_cz/freya         && valet link freya
```

**Authoritative project paths:** `~/.config/zsh/ai/temple-project-map.zsh`

<!-- older runs appended below this line, newest first -->
