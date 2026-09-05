---
kind: cold-start-card
date: 2026-09-05
brand: claude
seat: Trajectory
project: nablarva
root: ~/ia-sync
commit: fbd9f5e (main)
task: runbook-tool-00 gate — fresh-shell verify on home + majkee gavel
resume: "on home: check `alias rb-open` in a fresh terminal first; if absent, run `cd ~/ia-sync && git pull && bash deploy.sh`, then open new terminal → `rb-open`"
model: sonnet
dedicated: "@Trajectory or @Flight — verify + gate-close, no new code needed"
recommend: "Start on home. Verify deploy first (alias check). Walk D1+D2 manually. Gate closes on majkee gavel alone — the ovitmugen seed clause is explicitly deferred."
pointers:
  - ~/unikuklatrix/nablarva/.dev/session/runbook-tool-00/STATUS.md
  - ~/unikuklatrix/nablarva/.dev/session/runbook-tool-00/RUNBOOK.md
  - ~/ia-sync/zsh/nablarva/runbook.py
  - ~/ia-sync/zsh/nablarva/runbook.zsh
  - ~/ia-sync/zsh/nablarva/keyboard.zsh
  - ~/ia-sync/zsh/nablarva/base.zsh
---

## What this tool is and why it was built

**runbook tool** — a Python TUI (terminal UI) that browses `.dev/session/` beds.
The problem it solves: navigating multi-bed sessions meant `grep + cat` across multiple
files. The tool gives a two-panel live view: D1 (left) = all beds under the scanned root
with gate-states; D2 (right) = selected bed's sections, auto-reloading.

Named in the nablarva project scope because nablarva owns `.dev/session/`. Lives in
`~/ia-sync/zsh/nablarva/` (the surgical table); deployed to `~/.config/zsh/nablarva/`
via `deploy.sh`. Invoked as `rb-open` alias (or `rb-open <path>` for an explicit root).

**Why ia-sync / nablarva scope and not a standalone tool**: ia-sync is the saddle
that deploys to both machines. Putting the tool here means one `deploy.sh` spreads it
everywhere. The nablarva scope already had the keyboard/signpost pattern; `rb-open` is
a natural organ of that scope, not a foreign script.

## Gate state — runbook-tool-00

Position owner: `~/unikuklatrix/nablarva/.dev/session/runbook-tool-00/STATUS.md`

Steps done:
- [x] RUNBOOK.md written + Oraculum pre-build audit (9 adjustments folded)
- [x] runbook.py — Python TUI, stdlib only, all Oraculum adjustments implemented
- [x] runbook.zsh — engine (_rb_open, _rb_pick, _rb_help)
- [x] nablarva/keyboard.zsh P5 — rb-open / rb-pick / rb-help aliases
- [x] nablarva/base.zsh P3 — sources runbook.zsh
- [x] config.home.zsh — PROJECT_NAB_PATH export + nablarva/base.zsh source line added
- [x] deploy.sh run on office — all 5 nablarva/ files confirmed in ~/.config/zsh/nablarva/
- [x] committed and in remote (ancestor of fbd9f5e)
- [ ] **fresh-shell verify on home** ← first action
- [ ] **gate close — majkee gavel**

## Step 1: verify deploy on home (do this first)

Home deploy state at write-time: **unknown** — the user was told to run
`cd ~/ia-sync && git pull && bash deploy.sh` but the machine was closing. Do not assume.

Check:
```
# in a NEW terminal on home:
alias rb-open
```

If not found → deploy:
```
cd ~/ia-sync && git pull && bash deploy.sh
# then open a new terminal
```

If found → proceed directly to Step 2.

## Step 2: fresh-shell verify (success criteria — concrete)

```
rb-open
# or explicitly:
rb-open ~/unikuklatrix/nablarva/.dev/session
```

**What passing looks like:**

D1 (left panel):
- ~10 beds listed, one row each
- `runbook-tool-00` shows `[→]` (STATUS present)
- `toolbox-termbrana-02-m0-truthspike~` shows `[→]~` (STATUS present, lowercase drift)
- All others show `[?]` (no RUNBOOK.md — that is correct, not a bug)

D2 (right panel):
- Fixed strip at top: `next: @majkee: fresh-shell verify — new terminal, rb-open, confirm D1+D2+sections`
- Section R2 · STATUS renders the full STATUS.md content
- Section R5 · _bus/ lists `oraculum.audit.2026-09-04.md`
- Section R1 · RUNBOOK renders (toggle off/on with F key)
- Sections R3 · bed files and R4 · raw/ show `—` (empty — correct for this bed)

Auto-reload check:
- Touch STATUS.md (`touch ~/unikuklatrix/nablarva/.dev/session/runbook-tool-00/STATUS.md`)
- D2 should update within ~1 second without flickering

Keybind spot-checks:
- Tab — switches focus D1 ↔ D2
- 1–5 — jumps D2 to section start
- j/k — moves item cursor (D2 file entries)
- e — opens file in $EDITOR (curses escape, TUI restores after)
- p — prints path to terminal scroll-back (TUI stays)
- q / Esc — quits cleanly

## Step 3: gate close

After verify passes → report to @majkee → majkee gavel → gate closes.

**Ovitmugen seed clause (from RUNBOOK.md gate):** explicitly MOOT for this close.
The RUNBOOK gate says "ovitmugen seed updated" — but ovitmugen doesn't exist yet;
its seed path has no location. That clause is deferred to the ovitmugen build session.
Gate v0.1 closes on TUI verify + majkee gavel alone.

## What opens after gate closes

**ovitmugen** — the terminal layout seeder. Was explicitly sequenced AFTER runbook
tool so it can seed a real `rb-open` command rather than a placeholder.
Session bed: `~/unikuklatrix/nablarva/.dev/session/ovitmugen-00-console/`
Brief: `~/unikuklatrix/nablarva/.dev/session/ovitmugen-00-console/raw/brief.ovitmugen-sentinel.2026-09-04.md`
The seed that needs updating: `~/ia-sync/zsh/nablarva/ovitmugen/seeds/monitor.kdl`
(path does not exist yet — ovitmugen build creates it).

## Office machine housekeeping (any live office session, manual)

```
bash ~/ia-sync/install-pkgs/run.sh mark tmux
bash ~/ia-sync/install-pkgs/run.sh mark zellij
```

Both are now present on office (tracked in AGENTS.md) but not formally marked in
`~/.local/state/ia-sync/installed.json` on office. Low urgency — no functional blocker.

## Architecture notes for orientation

**Files (source → live):**
```
~/ia-sync/zsh/nablarva/runbook.py    → ~/.config/zsh/nablarva/runbook.py
~/ia-sync/zsh/nablarva/runbook.zsh   → ~/.config/zsh/nablarva/runbook.zsh
~/ia-sync/zsh/nablarva/keyboard.zsh  → ~/.config/zsh/nablarva/keyboard.zsh
~/ia-sync/zsh/nablarva/base.zsh      → ~/.config/zsh/nablarva/base.zsh
~/ia-sync/zsh/config.home.zsh        → ~/.config/zsh/config.zsh (on home)
```

**Root resolution order** (_rb_open in runbook.zsh):
1. Explicit argument to rb-open
2. `$RB_ROOT` env var
3. `$PROJECT_NAB_PATH/.dev/session`
4. Walk-up from `$PWD` (last resort)

**Self-contained:** runbook.py uses stdlib only. No `import cs_vault`, no PyYAML.
Four curses helpers (clipped / safe_add / wrap_text / build_d2) are inlined, not imported.

**Session lesson (carry forward):**
When wiring a new zsh scope, both `config.home.zsh` AND `config.office.zsh` need:
(a) the `PROJECT_*_PATH` export and (b) the `source nablarva/base.zsh` line.
Office already had both; home was missing both. The scope deploys; the config wires it
into the shell. One without the other = silent "command not found" on exactly one machine.
