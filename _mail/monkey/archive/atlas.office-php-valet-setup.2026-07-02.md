---
to: @majkee
from: Atlas (zsh-guides-audit session, 2026-07-02)
topic: Office PHP/Valet repair — shell commands to run
date: 2026-07-02
host: office
---

# Office PHP/Valet repair — run these in order

Outcome of the zsh-guides-audit session. All zsh files are already written.
These are the shell-side commands I cannot run. Takes ~2 minutes.

---

## Step 1 — Fix the enable state (urgent, do before next reboot)

`valet use php74` today called `systemctl disable php-fpm` — PHP 8 won't start on next boot.

```bash
sudo systemctl enable php74-fpm php-fpm
```

---

## Step 2 — Reset Valet's stored PHP version

`~/.valet/use_php_version` currently holds `74`. If Valet self-maintains (restart, upgrade),
it reads this and tries to re-route everything through PHP 7.4 — breaking freya.l and all
PHP 8 sites silently, possibly weeks later.

```bash
echo "8" > ~/.valet/use_php_version
```

---

## Step 3 — Link projects (path resolution fix)

Valet's server.php scans `~/www/*` one level deep — it finds `imago_cz`, not `fantasyobchod`
or `freya`. `valet link` creates named symlinks in `~/.valet/Sites/` which Valet checks first.

```bash
cd ~/www/imago_cz/fantasyobchod && valet link fantasyobchod
cd ~/www/imago_cz/freya         && valet link freya
```

**imagosk** — same fantasyobchod directory, different name (domain alias only, no separate codebase):
```bash
cd ~/www/imago_cz/fantasyobchod && valet link imagosk
```

For any other active projects not yet linked — same pattern: `cd <dir> && valet link <sitename>`.

---

## Step 4 — Reload nginx (picks up new imagosk per-site config)

`~/.valet/Nginx/imagosk` was created this session (routes imagosk.l → valet74.sock).

```bash
sudo systemctl reload nginx
```

---

## Step 5 — Verify

```bash
phpst                         # both FPMs running, both sockets present
curl -I http://fantasyobchod.l
curl -I http://freya.l
curl -I http://imagosk.l
valet links                   # confirm Sites/ symlinks are there
```

---

## What was written this session (no further action needed)

| File | Change |
|------|--------|
| `~/.config/zsh/system/php-switch.zsh` | New — php74/php8/phpst + architecture doc |
| `~/.config/zsh/config.zsh` | +1 source line for php-switch.zsh |
| `~/.config/zsh/project-switcher.zsh` | PHP helpers removed (delegated to php-switch.zsh) |
| `~/.valet/Nginx/imagosk` | New — per-site nginx for imagosk.l → valet74.sock |
| `~/.config/zsh/guides/office.md` | Full rewrite — all notes resolved, arch documented |

## New project workflow (PHP 8.x, any future Laravel)

```bash
cd <project-dir>
valet link <sitename>
# done — http://<sitename>.l immediately available
```

No nginx config, no socket wiring, no PHP switching needed. Default Valet routing handles it.

— Atlas, 2026-07-02
