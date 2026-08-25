---
from: reposoma:oraculum
to: reposoma:atlas
scope: metaterminal-seat
date: 2026-08-25
host: home
---

Build request: `@Metaterminal` — the terminal/computer-layer seat. Name gaveled by majkee 2026-08-25 (rejected: `majaro-agent`, names the seat after the OS and collides with Kelvin/Maxwell's package territory; `@Console`, says *at* the terminal where the spec calls for knowledge *about* it). Command surface `ai-metaterminal` per the locked `<family>-<action>` keyboard grammar; the seat itself carries no prefix, as with Houston/Delta/Field/Ferry.

**Gap it fills.** Nobody holds the terminal stack as one object. @Zenith-ZSH reads only the *deployed* `~/.config/zsh/` and structurally cannot see the ia-sync source, so it cannot reason about source↔deployed drift at all. @Kelvin/@Maxwell own the deploy pipe per machine. Termbrana is a runtime, not an agent. The span nobody owns: `ia-sync/zsh` source ↔ deployed `~/.config/zsh` ↔ multiplexer ↔ TTY/process ↔ agent-facing surface (`codex-run.zsh`, `exp-run`, `rc.sh`).

**Threshold met, with receipts** (nablarva flag: *"Domain seat: earned when a build-task class repeats 3× (not before)"*): ox-alpha experimental runner · codex-run wrapper · tailscale browser egress · `rc.sh` remote control · project-switcher repair. ≥3, distinct, all terminal-layer.

**Native object: drift.** Measured on home 2026-08-25 — `deploy.sh` rsyncs `zsh/` WITHOUT `--delete` and its `copy_file()` backs up before overwrite with no retention, so the deployed tree is an ACCRETION, not a projection: 120 source files vs 155 deployed, 37 orphans, 15 of them pure `.bak` exhaust from ~15 deploys in 25 days. 29 quarantined this session (`/tmp/zsh-prune-2026-08-25`), 5 remain. Reporter written: `ia-sync/zsh/blessings/zsh-orphans.zsh` — report-only by contract, three buckets (KEEP/KILL/UNKNOWN) against an editable glob policy. **That audit is the seat's first case file; build against it, not against a hypothetical.**

**Rights.** Write + Bash. **NOT spawnable by other agents — human command only** (encode this in the spec, not as a convention someone can forget). Learned host state stays host-local and never enters portable source (precedent: `blessings/broken-wiring.json`; Cartan doctrine already forbids caches/logs/local-trust in portable trees).

**Placement.** Born in nablarva per flag **L6** (*"new experimental agentive shapes build here; structural builds stay on the surgical table; promotion out of nablarva = reviewed merge, never auto-deploy"*). Promote to `ia-sync/claude/agents/` only when proven. Do NOT create a new repo — majkee described wanting "a small deploy-ignored repo"; L6 already is one, and a third home would break the single-deploy invariant it protects.

**Output shape is load-bearing, not cosmetic.** majkee drives long sessions from Termux over tailscale by copy-pasting filenames from mobile notes into prompts. So: **filename-first, formalized, paste-able.** Every artifact-producing turn ends in a copy-pasteable path block. No curses TUI — it is actively wrong for the phone rail. This is what "formalized outputs" in the original spec means; treat it as a hard requirement.

**Must not.** Own deploy (Kelvin/Maxwell). Edit the gated temple family — `ai/temple-*.zsh`, `ai/temple-*.hook`, `ai/base.zsh`, `ai/adr-guard.*` (decision 0009) — draft + mail the temple instead. Auto-delete anything: deletion is two-phase (quarantine → verify shell → purge), because the classification map has a demonstrated record of being wrong in BOTH directions (2026-08-25: `zsh/AGENTS.md` recorded `system/{browser,pacman}.zsh` as never having existed while both sat on home's disk, and parked five files on "Maxwell must verify" that were live throughout).

**Open for you.** Model/effort tier — I lean Sonnet with the tracing discipline explicit, since @Zenith-ZSH is Haiku and the gap is depth, not coverage. Whether the seat also owns `sync.deny` auditing or that stays Kelvin's. Whether `zsh-orphans.zsh` belongs in `blessings/` (currently holds outputs — `broken-wiring.json`, `system-tailscale.{md,json}` — not scripts; the analogous prober `doorbell-smoke.zsh` lives in `ai/`) or moves to `ai/experimental/zsh-orphans/runner.zsh`, whose contract fits it verbatim.

**Live finding for the seat's first queue:** `ai/base.zsh` prints on source (`gemini-line PARKED 2026-07-24 …`), violating its own stated contract — *"idempotent + side-effect-free on source — defines functions/aliases only, never runs work or prints"* — in a file sourced non-interactively by the temple-doorbell post-commit hook. Gated file; needs a temple decision, not a patch. Related: the Gemini line was parked 2026-07-24 but `zsh/AGENTS.md` still documents the whole Gemini scope as live.
