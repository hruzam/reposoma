---
kind: cold-start-card
date: 2026-09-03
brand: claude
seat: trajectory
project: ia-sync
projects: [ia-sync, freya]
root: ~/ia-sync
seat_host: office (hruzam-120922)          # WHERE this seat runs
target_hosts: [office, home (hruzam)]      # WHERE work lands — home reached over ssh/tailscale (100.110.27.60)
commit: cb3cace (main)   # ia-sync; reposoma at 91df142 (core) — both need commit+push for the card+ticket to travel
task: Sublime-for-Laravel desk provisioning per runbook — home LSP-Laravel VERIFIED healthy; office packages installed but NOT eyeball-verified
resume: claude --agent trajectory   # from the OFFICE seat
model: sonnet
dedicated: trajectory (office seat drives both hosts over ssh; home GUI eyeball needs a human at the home screen)
recommend: office checks run locally from the office seat. Home GUI checks (Show Scope Name / Troubleshoot) need a human at the physical home Sublime window — a remote seat cannot drive the GUI. Do NOT relaunch home Sublime until the sshfs mount is fixed (other session owns it) — session-restore would re-hang on a file under ~/mnt.
runbook: ~/reposoma/_runbook/freya/sublime-for-laravel/src/runbook.sublime-laravel-desk-provisioning.2026-08-22.md
pointers:
  - ~/reposoma/_runbook/freya/sublime-for-laravel/stt/STATE.md   # HOME: editor-pin auto-dump of LSP: Troubleshoot Server output — Read it directly
  - ~/ia-sync/install-pkgs/maintenance/home-zombies/issue.md      # HOME: zombie root-cause ticket (benign, parked)
  - ~/ia-sync/journal.host-cleanup.md                             # both hosts: ts-mount session + this session's notes
---

## WHERE — host topology (read first)

- **This seat runs on office** (`hruzam-120922`). It reaches **home** (`hruzam`,
  `100.110.27.60`) over passwordless tailnet SSH — no new access needed, already works.
- **Office actions** = run locally. **Home actions** = `ssh hruzam@100.110.27.60 '<cmd>'`.
- **What a remote seat CANNOT do on home**: drive the Sublime GUI. `Show Scope Name`,
  clicking the Command Palette, reading a popup — those need a **human at the home screen**.
  Package installs ARE remoteable (edit settings file + operator restarts Sublime).
- Sublime config path (both hosts): `~/.config/sublime-text/Packages/User/`.

## State of the desk (both hosts)

| Package | office | home |
| --- | --- | --- |
| LSP | ✅ (added this session) | ✅ |
| LSP-Laravel | ✅ (added, NOT verified) | ✅ **verified healthy** — PHP `embedding.php` + Blade `text.html.blade`, `lsp_active: true`, server exit 0 |
| Laravel Blade | ✅ (pre-existing) | ✅ (added + verified: scope now `text.html.blade`) |
| GitGutter | ❌ | ❌ |
| LSP-intelephense | ⚠️ present, was orphaned pre-LSP — recheck now | ❌ |

Install mechanism used (no GUI automation from a remote seat): add the exact Package
Control name to `Packages/User/Package Control.sublime-settings`, then restart Sublime —
Package Control fetches on next start. Dated backups at
`Packages/User/.backup-<date>/` on each host. Verified byte-present in `Installed Packages/`.

## Open queue — WHAT / WHY, each tagged with WHERE (no live STATUS bed — this card owns it)

1. **[HOST: office] Verify office desk** — WHAT: open a PHP + a `.blade.php` file in a freya
   worktree, run `Show Scope Name` (expect `embedding.php` / `text.html.blade`) and
   `LSP: Troubleshoot Server` on LSP-Laravel. WHY: office got `LSP`+`LSP-Laravel` installed
   this session but was never eyeballed the way home was — installed ≠ healthy. Office GUI is
   local to the seat's machine, so the seat's operator can do it directly.
2. **[HOST: office] Recheck LSP-intelephense** — WHAT: `LSP: Troubleshoot Server` on it.
   WHY: it was orphaned (no `LSP` core) until this session added `LSP`; it may now work.
   Decide keep-enabled vs per-project disable if it clashes with LSP-Laravel (runbook §4).
3. **[HOST: both] Install GitGutter** — WHAT: add `GitGutter` to Package Control settings +
   restart Sublime, each host. WHY: next in runbook order after Blade; still missing both
   hosts. (Home leg blocked until its Sublime is safe to relaunch — see holds.)
4. **[HOST: office] install-pkgs markdown/keymap** — WHAT: the `markdown-core-patch` +
   `sublime-keymap` STALE tasks. WHY: operator explicitly flagged this as "the part with md
   which needs operator". Untouched this session — needs the operator's own go.
5. **[HOST: n/a — fact, not an action] Worktree ambiguity** — two freya roots with `artisan`:
   `~/www/imago_cz/freya` (used for home verify) and `~/www/imago_cz/freya-taste`. WHY it's a
   non-issue: packages are user-level (installed once, editor-wide); only the Sublime
   window/project scope is per-worktree. No global decision needed.

## Cross-session holds (do not trip)

- **[HOST: home] sshfs mount `~/mnt/hruzam-120922` is dead (D-state, unkillable by signal)**
  — this is what froze home Sublime. A SECOND live trajectory session owns the fix
  (`fusermount -u -z ~/mnt/hruzam-120922` + kill the stale sshfs daemon). Do NOT touch the
  mount, and do NOT relaunch home Sublime, until they clear it — session-restore would
  re-hang on a file under the mount.
- **[HOST: home] zombies (26× `[zsh] <defunct>`)** — root-caused to powerlevel10k/gitstatus
  v1.5.5 forking an unreaped `[zsh]` helper per shell (job-control `setopt monitor` glitch).
  BENIGN, parked, no action unless a harm signal (unbounded daemon/zsh growth or RAM
  pressure). Full writeup in the ticket pointer. Do NOT restart `systemd --user` to clear.
- **[HOST: home] not yet checked on office** — office runs the same manjaro/p10k stack, so it
  very likely has the same zombie pattern; office was never audited for it.

## Lesson

`LSP: Troubleshoot Server` output is auto-pinned to `stt/STATE.md` (editor_pin plugin) — a
remote seat can Read it directly instead of asking the operator to paste. But `Show Scope
Name` is NOT captured there; that one must be pasted. And an already-open tab keeps its old
syntax after a new syntax package lands — reassign via `View → Syntax` (or reopen) before
trusting a scope check.

## Handoff note

Card + zombie ticket live cross-machine only after commit+push: `~/ia-sync` (cb3cace, ticket
edits uncommitted) and `~/reposoma` (91df142, this card new+uncommitted). Neither committed
from this seat — operator's commit-sweep decision.
