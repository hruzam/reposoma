# pad.1-sublime-laravel-desk — provision Sublime as a Laravel desk (freya)

> Operator bring-up surface. Sequential — one step, report back, next step.
> Driver: @Flight. Host: **home** (hruzam). Everything below is GUI-side; @Flight
> already did the headless half (evidence, backup, host + target resolution).

## Driver rules (read once)
1. One step, then wait. Don't run ahead.
2. Every path is absolute and copy-pasteable — no assumed shell state.
3. Package Control names are **exact**. A wrong/near name = STOP (see STEP 1 gate).
4. Nothing here edits Laravel code, composer, git, or the Package Control channel list.
5. An error is evidence — paste it into the step's fence, don't hide it.

## Desks covered by this PAD
- **HOME desk** — steps 0–8 below. Sit anytime you're at the home machine (Sublime is live there now).
- **OFFICE desk** — the self-contained **⟢ REINCARNATION — OFFICE SITTING** section at the bottom.
  Sit from **2026-09-01** (majkee physically at office). Office facts were pre-loaded over tailnet
  2026-08-28; that section re-confirms the volatile ones on arrival.

## Shared constants (used verbatim below)
```
Worktree (Laravel root, has artisan):   /home/hruzam/www/imago_cz/freya
Sublime Packages path (disk truth):     /home/hruzam/.config/sublime-text/Packages
Settings backup (already taken):        /home/hruzam/sublime-settings-backup.laravel-desk.2026-08-28/
```

## Precondition
Sublime Text installed on **home** (confirmed: `/usr/bin/subl`, Package Control live, `LSP` already installed). If Sublime won't open, STEP 0 catches it.

## What is already true (no action needed)
- Host = home · target = `www/imago_cz/freya` (`majkee/pre-develop`, clean tree, Laravel ^13.0).
- Evidence recorded: PHP 8.5.8 · Composer 2.10.2.
- **`LSP` already installed** → skip it. **Pint absent** → its staged follow-on is *skipped this run* (no `composer require`, per runbook).
- `phpEnvironment` stays **`auto`** (native PHP 8.5 works; Sail listed but not running).

---

### STEP 0 — safety copy + open

Backup is already at `/home/hruzam/sublime-settings-backup.laravel-desk.2026-08-28/`.
Open Sublime, then confirm the backup exists from a terminal:

```bash
ls -la /home/hruzam/sublime-settings-backup.laravel-desk.2026-08-28/
```

- backup file listed **and** Sublime opens → proceed to STEP 1
- backup missing → STOP, flag @Flight (do not touch settings until restored)

>MAJKEE report 0
```zsh

```

---

### STEP 1 — install `LSP-Laravel`  *(gate step)*

Command Palette (`Ctrl+Shift+P`) → `Package Control: Install Package` → type **`LSP-Laravel`**.

- Package Control shows the **exact** name `LSP-Laravel` → install it → proceed
- The exact name is **NOT** shown (only a plain `Laravel`, or a near-miss) → **STOP**, flag @Flight.
  Do **not** install a similarly named community package. (This is the runbook's hard gate.)

>MAJKEE report 1
```zsh

```

---

### STEP 2 — install `Laravel Blade`

Command Palette → `Package Control: Install Package` → **`Laravel Blade`**.

- installed → proceed
- name absent → STOP, flag @Flight

>MAJKEE report 2
```zsh

```

---

### STEP 3 — install `GitGutter`

Command Palette → `Package Control: Install Package` → **`GitGutter`**.

- installed → proceed
- name absent → STOP, flag @Flight

>MAJKEE report 3
```zsh

```

---

### STEP 4 — restart Sublime once

Fully quit and reopen Sublime so the three installs settle.

- reopened cleanly → proceed
- errors on startup → paste them, flag @Flight

>MAJKEE report 4
```zsh

```

---

### STEP 5 — open the worktree with correct scope

Open **one** project window whose **only** root is:
```
/home/hruzam/www/imago_cz/freya
```
Do **not** open the parent `imago_cz/`, and do **not** add the other Freya worktree as a second folder.
(If you want the per-project LSP choice to persist, save a `.sublime-project` **outside** the repo — optional.)

- single-root window on freya → proceed
- accidentally opened parent / multiple roots → close, reopen just freya

>MAJKEE report 5
```zsh

```

---

### STEP 6 — verify the Laravel lane BEFORE adding a second PHP server

Open an existing `.php` file and an existing `.blade.php` file — **do not edit them**. Then collect four things:

1. `View → Show Console` → run `sublime.packages_path()` → paste the path (should match the disk truth above).
2. `Tools → Developer → Show Scope Name` on the PHP file, then the Blade file → paste both (expect `embedding.php` / `text.html.blade`).
3. `LSP: Troubleshoot Server` with a Laravel file focused → is **`LSP-Laravel` healthy**? Paste the summary.
4. Blade file still highlighted? GitGutter markers visible? (yes / no)

- LSP-Laravel healthy + scopes correct + Blade highlighted → proceed to STEP 7
- LSP-Laravel unhealthy/ambiguous → **STOP**, capture `LSP: Toggle Log Panel` + `LSP: Troubleshoot Server`, flag @Flight (do NOT run the Composer fallback without approval)

>MAJKEE report 6
```zsh

```

---

### STEP 7 — add the general-PHP companion `LSP-intelephense`

Command Palette → `Package Control: Install Package` → **`LSP-intelephense`** → restart Sublime.
Then open a normal PHP class, try go-to-definition/navigation, and run `LSP: Troubleshoot Server` again.

- both servers healthy, no duplicate-diagnostics / competing-completion noise → **desk done**, go to CLOSE
- duplicate diagnostics or competing completions → proceed to STEP 8

>MAJKEE report 7
```zsh

```

---

### STEP 8 — (only if STEP 7 collided) disable Intelephense for this project

1. Save a personal `.sublime-project` outside the repo (if not already).
2. `LSP: Enable / Disable Language Server in Project` → disable **`LSP-intelephense`** for freya only.
3. Keep `LSP-Laravel` enabled here; Intelephense stays available globally for non-Laravel PHP.

Do **not** force Blade files to plain PHP syntax to "fix" this — that loses the Blade lane.

- Intelephense disabled for freya, LSP-Laravel clean → desk done, go to CLOSE

>MAJKEE report 8
```zsh

```

---

## CLOSE — handoff evidence (paste back to @Flight)

1. Exact Package Control names installed.
2. Resolved Packages path + which settings files changed (if any).
3. Which LSP servers were healthy for PHP and Blade.
4. `phpEnvironment` — stayed `auto` or changed, and why.
5. Intelephense — enabled or disabled for freya.
6. Pint result (absent — unchanged, no code touched).
7. Any blocked prerequisite or one clear next action.

## Not in this run (parked)
- **Pint**: executable absent in the worktree — no install, no `composer require`, no `pint.json`, no `--blade`. Revisit as a separate approved task.
- **Two-week trial**: re-evaluate LSP failures / duplicate diagnostics / navigation usefulness after real Laravel work (runbook §Community-informed recommendation).

## parked (off-pad questions)
-

---
---

# ⟢ REINCARNATION — OFFICE SITTING (from 2026-09-01)

> Cold-start surface for a future @Flight sitting the **office** desk with majkee present.
> This section is self-contained: read it top-to-bottom, ignore the HOME steps above.
> Sequential — one step, report back, next step.

## Re-entry brief (why this exists)
On 2026-08-28 (home session) @Flight executed the Sublime-Laravel runbook. The **home** desk
was PAD'd (steps 0–8 above). majkee's real target is **office**, but he wasn't there — next
physical office day was **Tuesday 2026-09-01**. So the office half was pre-scouted over tailnet
(read-only SSH) and captured here for a future sitting. The runbook of record:
`~/reposoma/_runbook/freya/sublime-for-laravel/src/runbook.sublime-laravel-desk-provisioning.2026-08-22.md`.

## Office facts — pre-loaded over tailnet 2026-08-28 (RE-CONFIRM the volatile ones in O0)
```
Host:                        office (hruzam-120922)
Worktree (Laravel root):     /home/hruzam/www/imago_cz/freya      # has artisan; Laravel ^13.0
2nd freya worktree (avoid):  /home/hruzam/www/imago_cz/freya-taste
Sublime CLI:                 /usr/bin/subl
Packages path (disk):        /home/hruzam/.config/sublime-text/Packages   # console is authority
PHP (native):                8.5.8   ·   Composer 2.10.2   ·   also php74 present (legacy)
Sail:                        vendor/bin/sail present, NO containers running
Pint:                        ABSENT  → follow-on SKIPPED (no composer require, no pint.json)
phpEnvironment decision:     auto  (native PHP works, Sail down; use "local" only if pinning needed)
```
**Stable** (trust): paths, subl, packages path, PHP/Composer versions, Sail/Pint state.
**Volatile** (O0 re-reads): git branch/dirty-state, and the office `installed_packages` list.

## Office package delta — the key difference from home (verified 2026-08-28)
| Package | Office state then | Action |
| --- | --- | --- |
| `LSP` (client) | **ABSENT** (no `Packages/LSP` dir — yet Intelephense was listed; partial state) | **install first — prerequisite** |
| `LSP-Laravel` | absent | install (exact-name gate) |
| `Laravel Blade` | **present ✔** | verify only, do not reinstall |
| `GitGutter` | absent | install |
| `LSP-intelephense` | **present ✔ (already global)** | do **not** reinstall; collision check is live from the start |

Consequence: on office the **Intelephense duplicate-diagnostics path (O7/O8) is likely**, because
Intelephense is already installed. Expect to disable it per-project for freya.

---

### STEP O0 — host guard + fresh recon + backup  *(non-destructive)*

Confirm you're on office and re-read the volatile facts, then back up office Sublime settings:
```bash
hostname -s                 # expect: hruzam-120922
ls /usr/bin/php74           # exists = office
command -v valet            # found  = office
git -C /home/hruzam/www/imago_cz/freya branch --show-current
git -C /home/hruzam/www/imago_cz/freya status --short          # note if dirty
grep -A40 '"installed_packages"' "/home/hruzam/.config/sublime-text/Packages/User/Package Control.sublime-settings"
mkdir -p /home/hruzam/sublime-settings-backup.laravel-desk.office.$(date +%F)
cp -p "/home/hruzam/.config/sublime-text/Packages/User/Package Control.sublime-settings" \
      /home/hruzam/sublime-settings-backup.laravel-desk.office.$(date +%F)/ 2>/dev/null
ls -la /home/hruzam/sublime-settings-backup.laravel-desk.office.$(date +%F)/
```
- host = office, backup listed → proceed
- host ≠ office (e.g. `hruzam` = home) → **STOP**, you're on the wrong machine
- worktree unexpectedly dirty in a way that blocks → note it, flag @Flight, don't repair

>MAJKEE report O0
```zsh

```

---

### STEP O1 — ensure the `LSP` client is installed  *(prerequisite)*

Command Palette (`Ctrl+Shift+P`) → `Package Control: Install Package` → **`LSP`**.
(If Package Control reports it already installed / present, good — just confirm.)

- `LSP` present or installed → proceed
- can't find `LSP` in Package Control → STOP, flag @Flight

>MAJKEE report O1
```zsh

```

---

### STEP O2 — install `LSP-Laravel`  *(gate step — same hard gate as home)*

Command Palette → `Package Control: Install Package` → **`LSP-Laravel`**.

- exact name `LSP-Laravel` shown → install → proceed
- only a plain `Laravel` / a near-miss shown → **STOP**, flag @Flight. Do not install a lookalike.

>MAJKEE report O2
```zsh

```

---

### STEP O3 — install `GitGutter` (and verify `Laravel Blade` already present)

Command Palette → `Package Control: Install Package` → **`GitGutter`**.
Then confirm `Laravel Blade` is already installed (it was on 2026-08-28) — do **not** reinstall it.

- GitGutter installed + Laravel Blade present → proceed
- Laravel Blade unexpectedly missing → install it too, note the drift

>MAJKEE report O3
```zsh

```

---

### STEP O4 — restart Sublime once

Fully quit and reopen so LSP / LSP-Laravel / GitGutter settle.

- reopened cleanly → proceed
- startup errors → paste them, flag @Flight

>MAJKEE report O4
```zsh

```

---

### STEP O5 — open the office worktree with correct scope

Open **one** project window, single root:
```
/home/hruzam/www/imago_cz/freya
```
Do **not** open `imago_cz/` parent, and do **not** add `freya-taste` as a second folder.
Save a `.sublime-project` **outside** the repo if a per-project LSP choice must persist
(you will likely need this in O8).

- single-root window on freya → proceed
- wrong/multiple roots → close, reopen just freya

>MAJKEE report O5
```zsh

```

---

### STEP O6 — verify the Laravel lane

Open an existing `.php` and an existing `.blade.php` (do **not** edit them). Collect:
1. `View → Show Console` → `sublime.packages_path()` → paste (should match the disk path above).
2. `Tools → Developer → Show Scope Name` on each file → paste (expect `embedding.php` / `text.html.blade`).
3. `LSP: Troubleshoot Server` with a Laravel file focused → is **`LSP-Laravel` healthy**? paste summary.
4. Blade highlighted? GitGutter markers visible? (yes/no)

- LSP-Laravel healthy + scopes right + Blade highlighted → proceed to O7
- unhealthy/ambiguous → **STOP**, capture `LSP: Toggle Log Panel` + `LSP: Troubleshoot Server`,
  flag @Flight. Do NOT run `composer global require laravel/lsp` without approval (fallback needs
  PHP ≥8.2 — office has 8.5 — and Composer global bin on the GUI PATH; report the missing path, don't edit shell rc).

>MAJKEE report O6
```zsh

```

---

### STEP O7 — Intelephense collision check  *(live from the start on office)*

Intelephense is **already installed** on office. With freya open, exercise normal PHP
navigation/completion and run `LSP: Troubleshoot Server`. Watch for duplicate diagnostics or
two competing completion lists (LSP-Laravel + LSP-intelephense both claim PHP scopes).

- clean — no duplicates, completions coherent → **desk done**, go to CLOSE
- duplicate diagnostics / competing completions → proceed to O8

>MAJKEE report O7
```zsh

```

---

### STEP O8 — disable Intelephense for freya only (if O7 collided)

1. Ensure a personal `.sublime-project` saved **outside** the repo (from O5).
2. `LSP: Enable / Disable Language Server in Project` → disable **`LSP-intelephense`** for freya.
3. Keep `LSP-Laravel` enabled here; Intelephense stays global for non-Laravel PHP.

Do **not** force Blade files to plain PHP syntax to work around it — that kills the Blade lane.

- Intelephense disabled for freya, LSP-Laravel clean → desk done, go to CLOSE

>MAJKEE report O8
```zsh

```

---

## CLOSE (office) — handoff evidence (paste back to @Flight)
1. Exact Package Control names installed on office.
2. Packages path confirmed + settings files changed.
3. LSP servers healthy for PHP and Blade.
4. `phpEnvironment` — stayed `auto` or changed, why.
5. Intelephense — left enabled or disabled for freya (expect disabled).
6. Pint result (absent — unchanged, no code touched).
7. Any blocked prerequisite or one clear next action.

## Office — not in this run (parked)
- **Pint** absent on office too — no install/require/pint.json/`--blade`. Separate approved task.
- **freya-taste** worktree exists on office — out of scope; this run is the primary `freya` only.
- Re-evaluate LSP-Laravel vs Intelephense after two weeks of real Laravel work.
