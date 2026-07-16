---
card: machine.office
kind: machine-profile · RELATIVE (quarterly, refreshable manually or via guide update)
host: hruzam-120922
machine_name: office
verified: 2026-07-15
half_life_days: 90
guide: ~/.config/zsh/guides/office.md
---

# office machine — profile card

Machine-specific facts for `hruzam-120922` (office). For project paths → `temple-project-map.zsh`.
For logical project map → `registry/index.md`.

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
