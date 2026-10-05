---
kind: cold-start-card
date: 2026-10-05
brand: claude
seat: trajectory
project: ia-sync
root: ~/ia-sync
commit: 074ac90 (main)   # reposoma 41fa816 (core) at handoff
task: technical support + monitor for tunnel-02 (Cartan's cSharp run behind the tunnel) — senior-dev posture toward the operator; explain, diagnose, repair on request; no building unasked
resume: cd ~/ia-sync && claude --resume e6276187-0ac9-439f-a4fd-72ebdbd19a0d   # transcript on office AND home (hand-carried 2026-09-23/26); re-resolve the host first; fallback anywhere: claude --agent trajectory + this card
model: opus
dedicated: trajectory
recommend: Cartan owns the sister bed's STATUS — you watch, you do not steer. Red surfaces you inherit and must NOT touch unprompted: the shim (zsh/ai/tunnel-codex.*), tunnel canon (raw.guides/tunnel/), Cartan's RUNBOOK/STATUS. Support names the better path once; it does not take it.
runbook: ~/ia-sync/.dev/session/tunnel-02-programmatic-scaling/RUNBOOK.md   # Cartan is authoring it; once present its STATUS owns the position — this card carries no competing next-action
pointers:
  - ~/ia-sync/.dev/session/tunnel-02-programmatic-scaling/raw/trajectory/hotrun.headless.2026-10-03.md
  - ~/ia-sync/.dev/session/tunnel-02-programmatic-scaling/raw/trajectory/prompt.cartan.2026-10-03.md
  - ~/ia-sync/.dev/session/tunnel-02-programmatic-scaling/raw/trajectory/report.cartan.final.2026-10-03.md
  - ~/ia-sync/.dev/session/tunnel-02-programmatic-scaling/raw/trajectory/coordination.two-seats-one-head.2026-10-05.md
  - ~/ia-sync/.dev/session/tunnel-02-programmatic-scaling/raw/trajectory/brick-01.md
  - ~/ia-sync/.dev/session/tunnel-02-programmatic-scaling/raw/trajectory/mechanism.brick-01.2026-10-03.md
  - ~/ia-sync/.dev/session/tunnel-02-programmatic-scaling/raw/trajectory.handoff.2026-10-03.md
  - ~/reposoma/raw.guides/tunnel/GUIDE.md
  - ~/reposoma/raw.guides/tunnel/res/user-run.md
  - ~/ia-sync/protocole/colors/PROTOCOLE.md
  - ~/.claude/projects/-home-hruzam-ia-sync/e6276187-0ac9-439f-a4fd-72ebdbd19a0d.jsonl
---

## prompt-0

###### prompt

```text
You are Trajectory, resumed as TECHNICAL SUPPORT for tunnel-02 — not its builder, not its
head. Majkee is the junior operator; you are the senior dev beside him. Re-resolve the host
by fingerprint first (php74/valet/RAM — never from memory; this transcript was written on
both hosts). Then read the sister bed's STATUS.md if it exists; it owns the position.
Gating: ~/ia-sync/protocole/colors/PROTOCOLE.md — reads and zero-quota probes run free;
append-only notes are done-and-declared; shim, canon, Cartan's bed, and anything spending
quota stop for majkee. When you see a better path: name it once, then do what was asked.
```

## Where things stand (2026-10-05, after the hot-run arc)

- **Tunnel is proven as a consultation line to a real head.** BRICK-01 (bind · `--cwd` ·
  runtime stamp · turn lock 61 · writer-lock note · close guard) + 01b (compact usage line)
  are live on office, selftest 96/96. `tn-*` vault manager committed (`95a51b9`) — **deploy on
  this host unconfirmed: `tn-ls` is the test.**
- **Cartan's head** (`01a0fab0…`, vault `…/tunnel-02-programmatic-scaling/tunnel.state.json`):
  workspaceWrite rooted at `~/ia-sync`, `on-request` approval, `/compact`ed by majkee to ~11 %,
  then ~30 % after two read-shaped turns. He accepted **transfer → fresh head**; the fresh head's
  birth brief is section C of `prompt.cartan`. When the new id exists, the vault is re-bound
  to it (`tn-off`, then `tn-on … --thread <new id> --cwd ~/ia-sync`).
- **BRICK-02** (sandbox + approvalPolicy applied on resume, operator-gated at open) is
  proposed, not built — waits on majkee's three rulings in `report.cartan.final` §4.

## Support playbook — what you will be asked, and the answer

| symptom | it is | not |
|---|---|---|
| `timed out after N s … stderr tail:` empty, then `tun read` shows `interrupted`, 0 items | the head is slow (full context / max effort / tool attempts); use `TUNNEL_CODEX_TIMEOUT=600` and background the call; phrase "no tools" | a tunnel defect |
| `NOTE — Codex writer-lock present` on resume/send | a TUI held the thread since the last tunnel turn; prints once per handover (F-B3/F-B5) | a block — never touch the lock |
| exit 61 | another `tun` verb on this vault is still running — wait or `tun read` | an error to retry around |
| exit 13 in a second terminal | `TUNNEL_CODEX_STATE` is per shell; `tn-use <bed>` there | a broken vault |
| exit 10 | no vault at that path; `tn-on` (operator opens the table) | — |
| `[usage: ctx=A/B (p%)]` | occupancy = last request input / window; watch the slope — reads are context purchases (~25K each) | cumulative `total` (hidden on purpose) |
| answer wrong / stale | the head remembers superseded instructions before it runs out of tokens; rotate on project pivot | — |

Recovery rule, always: on timeout or lost reply → `tun read` (free) → `interrupted` may be re-sent, `completed` is transcribed, never re-sent. Switching TUI⇄tunnel: `/guide tunnel user-run` §Switching.

## Open for a second sitting (do not start unasked)

Turn lock live (61 on a real in-flight turn) · interrupt + `tun read` recovery · F-B6 overlap
question · BRICK-02 · `tn` family registration in `ai/keys.zsh` (one line, grammar is locked
— majkee's call) · the pycache deploy defect (its own ISS card in `issues/`).

## Lesson to carry

One thread, two clients, never both. Reads are purchases. The usage line is the gauge. And a
rule that lives only in your own prose does not bind you — put the trigger where you read.
