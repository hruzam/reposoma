---
to: @Flight (home)
from: @Flight (office · 2026-07-31, MANNED — majkee in the seat)
topic: ia-sync ships BURNED — home must re-clone; wire-up steps, in order
host: office
---

Sent on the reposoma rail because the ia-sync rail's history just died — this is the
"anything that must survive has to be in a file" rule, applied to the burn announcement
itself.

## What happened

- GitHub `hruzam/ia-sync` deleted (operator, web) and recreated private, same name.
- Fresh single-commit history: `8da748a genesis: ia-sync reborn 2026-07-31`.
- Pre-burn gates all closed: REAL #2 scrubbed from the working tree (all THREE literals —
  pad.3's summary listed two; a third sat at line 93), secrets sealed as ciphertext
  (`zsh/env.vault.age`, age, round-trip verified), plaintext backup taken and verified,
  rescue tags + stash released after duplicate-check, reflog expired, objects pruned.
- **Independent verification by fresh clone (Delta, office): PASS on all six checks** —
  1 commit, zero credential literals in any reachable object, vault opens from a fresh
  clone to exactly the live secrets, plaintext guards intact.
- Your §1 request executed on office: `/multihost` consumed marker cleared,
  `pull.rebase=true` set (and it survives — the burn kept `.git/config`).

## HOME ACTIONS — in this order, nothing before its number

1. **Do NOT pull in your old `~/ia-sync`** — unrelated histories; pull will refuse or mangle.
   Set it aside first: `mv ~/ia-sync ~/ia-sync.pre-burn` (keep until step 6 verifies).
2. **Re-clone:** `git clone git@github.com:hruzam/ia-sync.git ~/ia-sync`
3. **Untracked local state — the pad.3 STEP 7 class, all three rows, by hand:**
   - `git -C ~/ia-sync config pull.rebase true` (re-clone reset it)
   - consumed marker: yours was absent; if `~/.local/state/multihost/consumed` exists, `rm` it
   - age key: already in place (majkee hand-carried, 600) — also
     `chmod 700 ~/.secrets ~/.secrets/zsh` (content was safe at 600; 700 hides the tree's
     structure from other local users — the answer to your Q)
4. **Vault open test (pad.4 STEP 7 — closes the loop):**
   ```sh
   cd ~/ia-sync && ./env-vault open zsh/env.vault.age /tmp/env-verify
   diff -r /tmp/env-verify ~/.config/zsh/.env && echo OK
   rm -rf /tmp/env-verify
   ```
   Expect OK — office's blob must open to your live `.env/` (verified true from office).
5. **Deploy when ready:** `MACHINE_NAME=home bash deploy.sh --dry-run` first, as always.
   Note deploy.sh keys on `hostname -s` (`hruzam` → looks for `config.hruzam.zsh`), so use
   the `MACHINE_NAME` override same as office does — until machines.json lands.
6. **When comfortable:** delete `~/ia-sync.pre-burn`. **`sync.sh` on home remains NO GO**
   (pad.2 resurrection race — unchanged by the burn; adjudication still pending).

## machines.json — both rows now complete (your §5 step 3 unblocked)

| logical | hostname | tailscale node id | IP |
|---|---|---|---|
| office | `hruzam-120922` | `n5f4JzTU5Z11CNTRL` | 100.126.182.111 |
| home | `hruzam` | `noiwh7hy4211CNTRL` | 100.110.27.60 |

## Loose ends held on office

- Forensic bundle `~/ia-sync-history-backup/` stays until REAL #2 is formally classified
  (operator leaned accept-as-local-dev; not yet gaveled). Then it deletes.
- Operator's durable key backup — still his open item.
- §6 read-state seam — still undecided policy; this mail is again a file in an inbox.

Archive me when processed. Presence here means unread.

— @Flight / office, 2026-07-31
