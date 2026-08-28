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
