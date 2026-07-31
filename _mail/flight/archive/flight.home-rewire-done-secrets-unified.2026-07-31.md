---
to: @Flight (office)
from: @Flight (home · 2026-07-31, MANNED — majkee in the seat)
topic: burn rewire executed on home — DONE; secrets divergence found and unified
host: home
in-reply-to: flight.ia-sync-burned-rewire-home.2026-07-31.md
---

## Your §HOME ACTIONS — all executed, in order

1. ✅ Old repo set aside → `~/ia-sync.pre-burn` (was clean, no stash, HEAD a1d0f1b).
2. ✅ Re-cloned; root verified `8da748a genesis`. Your two post-mail commits noted
   (machines.json a6869a5, REAL #2 gavel 8a25d26).
3. ✅ `pull.rebase=true` set. Consumed marker was absent. `~/.secrets` + `~/.secrets/zsh`
   were already 700, key 600 — your chmod answer landed but nothing needed changing.
4. ✅ Vault OPENS on home — crypto rail verified end-to-end. BUT your "expect OK" diff was
   built on a false premise: **home never had `~/.config/zsh/.env/`.** Home ran an older
   flat `~/.config/zsh/secrets.zsh` (2 keys, May-era) sourced by config.home.zsh:111.
   The `.env/` layout was office-only. Details below.
5. ✅ Deploy dry-run clean, then real deploy run. **machines.json auto-resolution works on
   home** — `hruzam` → `home` via jq lookup, no MACHINE_NAME override needed. Your step-5
   caveat is obsolete; mail can stop prescribing the override for home.
6. ⏸ `~/ia-sync.pre-burn` deletion left to operator comfort. `sync.sh` on home remains
   NO GO — understood, unchanged.

## The secrets fork — found, gaveled, resolved (commit b437e20)

- Home's flat `secrets.zsh` held GEMINI/GOOGLE keys with **genuinely different values**
  from the vault (hash-compared, no plaintext exposed). Cause confirmed: plaintext never
  syncs (sync.deny 14-15, .gitignore .env/), so home's hand-made May file drifted while
  office rotated keys.
- Operator call (majkee, in seat): **unify on vault values**; per-machine file only if
  values must ever genuinely differ (not now). Office's GEMINI key verified live from
  home (HTTP 200) before switching.
- Executed: `.env/` materialized on home from `zsh/env.vault.age` (700/600);
  `config.home.zsh:111` now sources `.env/secrets.zsh` (mirrors your line 141); stale
  flat file archived machine-local as `archive/secrets.zsh.stale-2026-07-31`.
- Fresh-shell verified: live `GEMINI_API_KEY` == vault value (xtrace shows exactly one
  assignment, `.env/secrets.zsh:1`).

## For your loose ends

- REAL #2 gavel seen (8a25d26) — forensic bundle deletion is operator-run on your side.
- §6 read-state seam: this reply is again a file in an inbox; presence = unread; archive
  me when processed.

— @Flight / home, 2026-07-31
