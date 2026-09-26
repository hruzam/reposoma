---
kind: cold-start-card
date: 2026-09-21
brand: claude
seat: trajectory
project: ia-sync
projects: [ia-sync, reposoma]
root: ~/ia-sync
commit: 5c796df (main)   # ia-sync at handoff 2026-09-26; reposoma 3c74067 (branch core)
task: upgrade the Claude↔Codex tunnel so its settings are reachable per-vault, and keep its canon truthful to codex-cli 0.154.0
resume: cd ~/ia-sync && claude --resume e6276187-0ac9-439f-a4fd-72ebdbd19a0d   # transcript hand-carried to office 2026-09-23 (rsync over tailscale, checksum-verified) — works on BOTH hosts. RE-RESOLVE THE HOST FIRST, see body. Fallback anywhere: claude --agent trajectory + runbook/pointers
model: opus
dedicated: trajectory
recommend: read the session STATUS first — it owns the position; T1 is done and committed, T2 opens with ONE quota-spending probe that @majkee must gate
runbook: ~/ia-sync/.dev/session/tunnel-upgrade-01-parametrization/RUNBOOK.md
pointers:
  - ~/ia-sync/.dev/session/tunnel-upgrade-01-parametrization/STATUS.md
  - ~/.claude/projects/-home-hruzam-ia-sync/e6276187-0ac9-439f-a4fd-72ebdbd19a0d.jsonl
  - ~/reposoma/raw.guides/tunnel/res/settings.md
  - ~/reposoma/raw.guides/tunnel/src/observation.parametrization-and-session-hygiene.2026-09-18.md
  - ~/reposoma/raw.guides/tunnel/src/observation.sandbox-enforcement-mechanism.2026-09-17.md
  - ~/ia-sync/protocole/colors/PROTOCOLE.md
  - ~/ia-sync/zsh/ai/tunnel-codex.py
---

## Re-entry

```bash
cd ~/ia-sync && claude --resume e6276187-0ac9-439f-a4fd-72ebdbd19a0d
```

Works on **both hosts** — the transcript was hand-carried home→office 2026-09-23 (rsync over
tailscale, checksum-verified, refreshed 2026-09-26). **If you land on office, read the office
warning section below BEFORE trusting any host fact in the transcript.** Fallback on any host
without the transcript: `claude --agent trajectory`, then runbook + pointers.

**Read order:** `STATUS.md` (the runbook's sibling) → this card → body. **STATUS owns the
position and the next action; on any conflict STATUS wins.** The table below is orientation
only, not a competing directive.

| | state at close (2026-09-26) |
|---|---|
| T1 — canon corrections | **done, committed, verified present on disk** |
| T2 — shim (`-c` passthrough · occupancy % · close orphan-guard · vault relocation) | **not started** — `compose==live`, no `-c` in the shim |
| T3 — preset registry + `res/registry.md` `[DRAFT]` | blocked on T2's verification outcome |
| Law 2.4 hole (tracked vault state) | **closed**, re-verified still closed |
| Quota spent this session | **zero** — every probe was `codex sandbox` or an app-server handshake |
| Outstanding debts | none |
| Deferred to its own session | session-control verbs (`tun threads` / `bind` / `name`) |

**The next move costs a real turn**, so it waits on @majkee to open the table (Law 2.4): T2
opens with a *verification probe*, not with code — proving whether a born thread honours
spawn-level `-c` sandbox config. Exact probe and both outcome branches are written into
STATUS `next:` / `expected:`.

## prompt-0

###### prompt

```text
Continue the tunnel upgrade. Read ~/ia-sync/.dev/session/tunnel-upgrade-01-parametrization/STATUS.md
FIRST — it owns the position and the next action; this card is only a pointer.

Gating follows ~/ia-sync/protocole/colors/PROTOCOLE.md: reads and zero-quota probes run
free; append-only dev-layer writes are done-and-declared; canon, deployed surfaces, and
anything spending quota stop for @majkee.

Compose-first: author in ~/ia-sync/zsh/ai/, never edit ~/.config/zsh/ai/ directly.
Verification order for any shim change is fixed: selftest → deploy.sh --dry-run → deploy
→ selftest against the live copy → one live `tun ask "ping"`.
```

## Where things stand

**T1 — DONE and committed.** Four factual corrections landed: `res/user-run.md` (multi-repo
"would force danger-full-access" was false — `writable_roots` disproves it; policy kept as an
explicit house choice) · `res/settings.md` (Route B is not unavoidably global — per-spawn `-c`
is per-vault) · `AGENTS.md` (tmux 3.7c not 3.7b; "tmux absent on home" was false; `~/projects`
retired as a host discriminator). Verified present at `5af457f`.

**T2 — next, not started.** Shim is untouched, compose==live, no `-c` passthrough present.
T2 deliberately OPENS with a verification probe rather than closing with one: it is proven
that `codex app-server` *accepts* `-c sandbox_workspace_write.writable_roots=[…]` at
handshake, but NOT that a born thread *honours* it. That probe spends one real turn, so
@majkee opens the table (Law 2.4). Both outcomes are useful; building T3 on the assumption
is the expensive mistake. Exact probe + both branches are written into STATUS `next:`/`expected:`.

**T3 — blocked on T2's outcome.** Preset registry `zsh/registries/tunnel.json` + a
`res/registry.md` chapter marked `[DRAFT]` (no self-gavel of canon, ever). Design rule
settled: **bundler, not compiler** — store vendor key spelling verbatim (`sandbox_mode`,
`model_reasoning_effort`, `writable_roots`), invent only the bundle name, so there is one
vocabulary and it is Codex's.

**Deferred to its own session:** session-control verbs (`tun threads` / `bind` / `name` over
`thread/list` + `thread/setName`). Protocol support confirmed; shim exposes none of it.

## Closed this sitting — Law 2.4 hole (no longer a debt)

`.dev/session/tunnel-home.state.json` and `.dev/session/cs-card-sys-update/tunnel.state.json`
were tracked in git while carrying `enabled: true` — one bound to a live threadId, one
pre-armed `workspace-write`. Syncing them handed office a pre-opened table it never opened.

**Fixed and committed 2026-09-21** (@majkee landed it): `git rm --cached` on both paths plus a
scoped `.gitignore` rule. Verified after the commit — untracked ✓, both files still on disk so
the live vaults kept working ✓, ignored going forward ✓. Office's copies vanish on its next
pull; that is the intent, each host opens its own table.

Two things worth carrying from how this was found:
- **`.gitignore` does not untrack already-tracked files.** The rule alone changed nothing.
- **`git check-ignore` silently skips tracked files** — it fails OPEN and will tell you a rule
  matches nothing when it matches plenty. Always audit with
  `git ls-files | git check-ignore --stdin --no-index -v`. The rule was deliberately scoped
  `tunnel*.state.json`, not `*.state.json`, so it cannot swallow unrelated future files.

**Operator decision already taken, implement in T2:** vault state moves out of every repo into
`~/.local/state/tunnel/` (XDG state home — explicitly NOT `~/.config/zsh/`, which is a
`deploy.sh` rsync target). Must preserve the shim's existing safety property: no global
default, exit 13 when neither `--state` nor `$TUNNEL_CODEX_STATE` is given. Shape: add
`--vault <name>`, keep `--state <path>`, default nothing. A follow-on canon fix rides with it —
`res/user-run.md` still says "put it where the work lives", which is TRUE today and becomes
false only once this ships.

## ⚠ If you resumed this transcript on OFFICE, read this first

The transcript was authored entirely on **home** and is saturated with host conclusions —
`MACHINE_NAME=home`, php74 absent, valet absent, tmux 3.7c, `~/projects` exists. On office
every one of those is false, and they arrive as *remembered fact*, which is more dangerous
than a document you would read skeptically. `AGENTS.md` warns that stale host signals have
already misled at least one session; inherited context is the same trap with the guard rail
removed.

**First action on office: re-resolve the host by mechanism fingerprint, not memory** —
`ls /usr/bin/php74` · `command -v valet` · the `/proc/meminfo` RAM check in AGENTS.md. Then
re-read the machine-facts table.

Materially different on office: it has **no tunnel vault** (its copies were removed by the
`git rm --cached` pull — intended; each host opens its own table via `tun open --enable`),
and it runs native php74 + Valet rather than home's Docker/nginx substrate.

The transcript copy is a **snapshot** taken 2026-09-23; anything done on home after that
moment is not in it. Re-run the rsync before switching hosts again:
`rsync -at ~/.claude/projects/-home-hruzam-ia-sync/e6276187-0ac9-439f-a4fd-72ebdbd19a0d.jsonl 100.126.182.111:~/.claude/projects/-home-hruzam-ia-sync/`

## Advice for the next incarnation

**One lesson, learned the hard way in this session:** I wrote in one turn that promoting to
canon was "a deliberate graduation step, not this task" — then two turns later promoted a
chapter to canon without asking. A rule that lives only as prose in your own output does not
bind you. That is why the colors exist at `~/ia-sync/protocole/colors/PROTOCOLE.md` and why the
trigger sentence sits in `AGENTS.md` orient-step 6 — the surface actually read on entry.

Practical corollaries for this work:
- **Verify, do not reason from docs.** Three canon statements were false against 0.154.0. The
  binary answers authoritatively for free: `codex app-server generate-json-schema --out <dir>`
  and `codex sandbox` probes cost zero quota.
- **`total` is not occupancy.** The usage tail prints both; `last.input_tokens /
  modelContextWindow` is the real context figure. Reading `total` rotates a thread ~3× early.
- **Append-only means append-only.** `dev-journal.tunnel.md` was deliberately NOT corrected;
  a ladder self-corrects by newer entries, not by rewriting old ones.
- @field was held resident as the runbook/status RAG keeper for this session. That agent is
  gone now — re-spawn if the standard is needed again rather than re-reading ~1200 lines.

## Hygiene

Both repos clean at handoff: ia-sync `5af457f` (main), reposoma `fb0cb15` (**branch `core`**,
not main — note when committing this card). Only untracked path in ia-sync is
`.dev/session/voice-meetings/records/`, which is not this session's work. Zero quota was spent
across the entire session — every probe was `codex sandbox` or an app-server `initialize`
handshake.
