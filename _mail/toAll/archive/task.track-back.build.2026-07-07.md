# TASK — track-back: operator work-trace tooling (DRAFT — awaiting @majkee gavel)
# origin: Oraculum session 2026-07-07 (forensic re-entry after 3 untracked days)
# executor after gavel: @Delta (Bash seat) · host: office · machine layer = 0003/0009 territory
# motivation: operator solo-work leaves no record; /tmp sandboxes die on reboot; zsh history
# currently on defaults (no timestamps, no incremental append — verified absent 2026-07-07).

## Part 1 — history black box (5 lines, highest yield)
Add to the machine-layer zsh config (placement = operator's call; suggest the per-machine
`config.zsh` or a new `history.zsh` sourced early):
```zsh
HISTFILE=~/.zsh_history
HISTSIZE=200000
SAVEHIST=200000
setopt EXTENDED_HISTORY INC_APPEND_HISTORY HIST_IGNORE_SPACE
```
- `EXTENDED_HISTORY` → every command timestamped (`: <epoch>:<dur>;cmd`)
- `INC_APPEND_HISTORY` → written immediately, survives crashed/killed shells
- `HIST_IGNORE_SPACE` → leading-space escape hatch for secrets
Acceptance: new shell → `fc -lt '%F %T' -5` shows timestamps.

## Part 2 — persistent sandbox home (structure, not promise)
- `mkdir -p ~/sandboxes`
- Convention line in machine-layer `~/.config/zsh/AGENTS.md`: *"multi-day pilots/sandboxes
  live in `~/sandboxes/<name>/`, never /tmp — /tmp is for single-session scratch only."*
- Do NOT migrate the parked pilot copy (it stays the archived specimen in reposoma mail).

## Part 3 — `~/.config/zsh/ai/track-back.zsh` (the forensic battery, frozen)
Per 0009: lives under `ai/`, direct-invoked (L3), read-only, zero side effects.
Interface: `track-back [days]` (default 3). Output grouped per day, newest first.

Sweeps (all read-only):
1. **mtime sweep:** `find` over roots: `~/.config/zsh`, `~/ia-sync`, `~/reposoma`,
   `~/sandboxes` — exclude `.git/`, `*.zwc`; print `%TY-%Tm-%Td %TH:%TM  path`, sorted.
2. **repo pulse:** for each git root (`~/reposoma`, `~/ia-sync`, any `~/sandboxes/*/.git`):
   `git status --short` + `git log --oneline --since="<days> days ago"`.
3. **history slice:** parse `$HISTFILE` extended-format timestamps, print commands from the
   window grouped by day (degrade gracefully + note if EXTENDED_HISTORY not yet active).
4. **footer:** explicit negative space — "no changes found in <root>" lines, so an empty
   day reads as *verified empty*, not unknown.

Acceptance ride: `track-back 5` must reproduce today's forensic findings — the 07-03 11:32
parking cluster, the 07-04→07-06 gap (explicit), the 07-07 01:11/01:47/10:24 clusters.

## Not in scope
- No cron, no hooks, no auto-journal (Force 4 restraint — reconstruction-on-demand only).
- No writes to any pulse/memo file — the tool reports; seats and the operator record.

## Sign-off
- [ ] gavel: placement of Part 1 block (which file)
- [ ] gavel: `~/sandboxes` convention line
- [ ] build: Parts 1–3 by @Delta
- [ ] acceptance ride run + output eyeballed by operator
