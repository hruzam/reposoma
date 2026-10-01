---
kind: issue-card
date: 2026-10-01
brand: claude
found_by: trajectory (home seat, remote rescue of office)
project: ia-sync
root: ~/ia-sync
where: office (hruzam-120922) memory config — /proc/swaps empty, no swap device, no zram
defect: Office has 0B swap, so under memory pressure the whole host stalls instead of degrading — sshd times out before banner exchange and ICMP over the tailnet is lost, while tailscaled itself still answers.
assoc: [office, memory, swap, zram, oom, ssh-unreachable, firefox, machine-layer, host-stall, high]
severity: high
pointers:
  - ~/ia-sync/AGENTS.md (Machine facts — office row)
  - ~/ia-sync/machines.json
  - ~/unikuklatrix/nablarva/.dev/session/ovitmugen-00-console/ (ovitmugen)
---

## Observed — 2026-10-01 ~08:20, from home over tailscale

- `tailscale ping 100.126.182.111` → pong, but 631 ms (tailscaled alive, slow).
- Plain `ping` → 100% loss; `ssh office` → port 22 connect timeout (×2), then
  "timed out during banner exchange" (TCP accepted, sshd too starved to speak).
- Third attempt with `ConnectTimeout=300` got in. Load average **84.97 / 72.02 / 33.86**,
  15 GiB total, 12 GiB used, 3.3 GiB available, **Swap: 0B**. Uptime 9 days.
- Top RSS after Firefox closed: one `zsh` (PID 3577390) at **~800 MB** (anomalous for a
  shell — suspected runaway/huge history, not investigated), sublime_text ~550 MB,
  plasmashell ~450 MB, several `claude` / `codex` sessions ~300–350 MB each.

**Confirmed:** zero swap; host unreachable for ssh while under pressure; SIGTERM to Firefox
relieved it (load falling 85 → 72 within seconds).
**Suspected:** the trigger is the sum of Firefox + many concurrent agent sessions + the fat
zsh — no single runaway proven.

## Rescue playbook (until the fix lands)

From home:

```bash
ssh -o ConnectTimeout=300 -o BatchMode=yes -o ServerAliveInterval=15 office \
  'pkill -TERM -u "$USER" -x firefox; sleep 20; pgrep -a -x firefox || echo gone; free -h; uptime'
```

Short timeouts fail — sshd needs minutes to reach banner exchange. Use SIGTERM, not -9
(Firefox restores the session cleanly). Then check `ps -eo pid,rss,comm --sort=-rss | head`.

## Fix

zram swap on office — already planned by @majkee (not yet implemented as of this card).
After it lands: verify `swapon --show` / `zramctl` on office, note it in
`~/ia-sync/journal.host-cleanup.md`, and fold this card to `archive/` (majkee's call).
Home's swap state was not checked — worth the same look.
