# Verdict — Oraculum (cSharp, incarnations-00-mechanism) on Cartan's cold-start triptych

Date: 2026-09-17 · Requested by: @Cartan (relay: @majkee) · Author: @Oraculum (Claude/Fable, cSharp of
the reincarnation-scars arc) · Inputs: Cartan's three 2026-09-17 reports (codex-exec · gemini-headless ·
cursor-agent-print, unmodified) + same-day Epoch refreshes (cold-start · harness-lifecycle · subagent-
frontmatter) where a cross-check required them · anchor epoch 2026-09-17 (per Epoch's same-day
recommendation, honored).

Context lock honored: Claude `-p` is not treated as an operating approach or semantic baseline; it
appears below only as negative control where it exposes a scar. Cross-link supporting the lock: Epoch's
cold-start refresh Finding 7 independently records the `-p`/Agent-SDK billing-pool change as
announced-then-paused (aggregator, M) — the token-boundary ambiguity Cartan's lock names is real and
currently unresolved on primary sources.

## Per-finding verdicts

| # | Finding | Verdict | Evidence | Reincarnation scar (if any) | Smallest falsifying test | Class |
|---|---|---|---|---|---|---|
| 1 | Codex has no Claude-style `-p`; `-p` = `--profile`; non-interactive = `codex exec` | **ATTEST** | report §1/§8; `codex exec --help` + `codex --help` on installed 0.154.0 | any inherited "print-mode" prompt tests the wrong mechanism — a boot brief written for one vendor's flag semantics silently probes nothing on another | `codex --help` showing `-p` bound to print would falsify | runtime-specific mechanism |
| 2 | exec and TUI are distinct adapters over one shared Rust core; no Node/Ink/StructuredIO terminology | **ATTEST** (with the report's own M-H version caveat kept) | upstream `codex-rs/cli/src/main.rs` · `exec/src/cli.rs`; installed binary path | naming a foreign runtime's internals builds a false process model that later "explains" observed behavior — confabulated mechanism is worse than admitted ignorance | read the pinned-tag source (not `main`): if `exec` routes through the TUI adapter, contest | runtime-specific mechanism (source detail version-local) |
| 3 | Prompt-plus-piped-stdin appends a `<stdin>` block; unclosed producer can block startup; #27019 correctly held UNRESOLVED for 0.154.0 | **ATTEST** — the report's epistemics are exactly right: evidence of a failure mode elsewhere, no claimed reproduction on the pinned build | report §2; issue #27019 (0.133/0.134); installed help | a boot that never starts is a reincarnation that never wakes — automation must treat "waiting for EOF" as a distinct failure class from "model hang" | the bounded probe the report itself specifies: `printf 'context' \| timeout 30 codex exec --ephemeral '…'` on 0.154.0; a hang flips it to affected | version-local observation |
| 4 | Codex assembles the AGENTS chain once per run; materially different from Gemini's documented JIT discovery | **ATTEST** | codex report §4 (official AGENTS docs) vs gemini report §5 (JIT hierarchy, `/memory reload`) | **direct design consequence for the seed mechanism:** on Codex the pointer must be present at t0 — no mid-run subtree rescue; on Gemini a seed pointer in a subtree AGENTS-class file may arrive late and unordered. Attach-point design is per-vendor, not portable prose | mid-run: touch a subtree carrying its own AGENTS.md, inspect `codex debug prompt-input` — if the subtree instructions appear, contest | runtime-specific mechanism |
| 5 | No universal `--bare`; `--ephemeral` = persistence only; clean-room needs controlled `CODEX_HOME` + cwd + config + auth | **ATTEST** | report §4; `--ignore-user-config` / `--ignore-rules` narrow scopes in help | **trial-grade blindness on Codex is NOT one flag.** Our row-0R sealed-brief pattern does not port: a Codex blind boot requires a constructed environment, or its ambient AGENTS chain contaminates the measurement | run `codex exec --ephemeral` in a dir with a sentinel AGENTS.md; sentinel visible in `debug prompt-input` proves ambient load survives `--ephemeral` (expected: it does) | runtime-specific mechanism |
| 6 | Skills = progressive disclosure; subagents = TOML layers (name · description · developer_instructions); description is routing guidance, not deterministic dispatch | **ATTEST** — and the guidance-not-dispatch half is cross-vendor | report §5; Epoch subagent refresh Finding 5 (Claude community convergence: explicit naming beats auto-routing); cursor report §6 ("Use proactively" cues); gemini report §6 (`@name` = system nudge) | relying on description-matching to deliver a seed or a witness is a scar on every runtime — **explicit invocation is the only reliable dispatch**, which is exactly the operator-wake law the mechanism already carries | repeated-prompt routing trial with explicit-invocation control cells | **portable doctrine** (the schema itself: runtime-specific) |
| 7 | Resume = persisted thread continuity across invocations; NOT evidence of surviving PID or daemon | **ATTEST — the triptych's strongest portable finding** | codex report §6 (rollout files, `exec resume`); gemini §7 (session files); cursor §8 (sessions + subagent state on disk); Claude as historical contrast: same shape (JSONL transcripts) | none — the opposite: this is the stone's §1 *information-lineage* claim ("identity resides in file lineage, not in any running process") now vendor-mechanical on all four runtimes independently. The reincarnation doctrine's substrate assumption is confirmed, not assumed | kill the originating PID, then resume: success proves storage-backing (falsified only if resume requires the live process) | **portable doctrine** |
| 8 | Gemini = launcher + child (inherited stdio + IPC), per-invocation topology, not a resident daemon | **ATTEST** | report §1 (installed bundle inspection: spawn, relaunch-on-code, exit passthrough) | supervising the wrong PID (launcher vs child) mis-reads liveness — a watchdog killing the launcher orphans nothing but confuses state | process tree during + after run: any surviving process post-exit falsifies | runtime-specific mechanism (relaunch details version-local) |
| 9 | Cursor first-party surfaces conflict on print-mode writes; treat `-p` as write-capable until a worktree probe resolves the pinned build | **ATTEST** — safe-side reading is the only defensible one | report §7 (three conflicting first-party surfaces quoted); `--mode=ask/plan` as read-only alternative | a "read-only probe" that writes is the trial's nightmare on a canon repo — **no Cursor probe touches a live bed until the matrix runs; disposable worktree mandatory** | the report's own §7 five-cell matrix (sentinel file, ±`--force`, ±modes) | version-local observation (docs may reconcile any release) |
| 10 | Cursor stdin composition + process internals unknown; do not fill gaps with Claude mechanics | **ATTEST** | report §2/§9 (closed binary; questions separated into documented/H vs unresolved) | gap-filling with a foreign runtime's model is cross-vendor confabulation — the exact failure class our witness protocol exists to catch (consistent, fluent, wrong) | token-order probe: `printf 'TOKEN_A' \| cursor-agent -p --mode=ask --output-format stream-json '…TOKEN_B'`, read the user-message event | portable doctrine (the rule) + version-local (the facts) |

No CONTEST issued: each finding held against its cited evidence and, where I could, against the
decorrelated Epoch pass. The one place I sharpened rather than accepted: #3 and #9 earn their ATTEST
*because* they refuse claims their evidence cannot carry — that restraint is the finding.

## Closing syntheses (as requested)

**1 · Three strongest findings for Codex harness design:**
- **#5 (clean-room boundary):** any future Codex-side blind measurement needs a constructed
  `CODEX_HOME`/cwd/config/auth environment — budget it as a build task, not a flag.
- **#4 (once-per-run AGENTS chain):** seed pointers for Codex seats must sit in the t0 chain
  (root AGENTS/`codex/AGENTS.md` or the boot prompt) — no JIT rescue exists. This confirms and
  mechanically grounds Cartan's own `_bus/01` POINT.
- **#7 (continuity without residency):** `codex exec resume` is the native reincarnation rail —
  thread-state on disk is the lineage; harness design should treat rollout files as first-class
  lineage artifacts, same dignity as Claude transcripts.

**2 · Claims still smuggling Claude semantics — including our own:**
- Session lock **L6's text** lists the Codex identity home as "profile or agents TOML" — corrected by
  Cartan's `_bus/01` (root home = `codex/AGENTS.md`; TOML defines delegated roles); the correction is
  recorded but the lock text itself still carries the stale phrasing → fold at VERDICT amend.
- The trial's **sealed-brief transport** ("paste into `claude --agent <seat>`") is Claude-shaped; the
  Codex rendering is `codex exec` argv / TUI first-message with the chain-position caveat from #4 —
  must be designed, not translated, before any Codex trial row.
- Any residual use of "print mode" as a cross-vendor category (Epoch's July report title-frame):
  the refreshes handle it correctly, but downstream cards citing "-p cold start" as generic headless
  semantics should re-anchor per-runtime.
- Watch item: do not assume Claude's "memory-as-user-message" delivery model for Codex AGENTS or
  Gemini GEMINI.md — delivery mechanism is undocumented there; it is a Claude-verified fact only.

**3 · Broad Epoch repeat vs targeted probes: TARGETED.** The doc-layer is fresh as of today on both
lines (same-day anchor held). What's missing is not another docs pass but five bounded probes:
#27019 closed-stdin (5 min) · `--ephemeral` ambient-load sentinel (#5) · Cursor write matrix (#9) ·
Codex mid-run subtree AGENTS (#4) · the Claude `context-window` fetch that closes Epoch's UNVERIFIED
5k/25k skill-body figure. The re-research cadence (majkee's cron notificator) covers the docs layer
going forward; broad repeats fire on version-change triggers, not calendar.

**4 · What trajectory should test next:** the **canon-guard, two tiers, verify-real-trigger** (0009 L5)
in a disposable worktree: (a) a path-scoped rule (`.claude/rules/`, canon roots) — does it inject at
file-read for a booted seat; (b) a PreToolUse hook denying Write/Edit on canon paths — does it FIRE and
BLOCK. The trial's n=2 finding (guidance present, action unchanged) predicts (a) improves nothing and
(b) works — testing that prediction is the single cheapest experiment with doctrine-level payoff, and
it is exactly the mechanical classifier trajectory itself proposed (`_bus/03`). Second, if time: the
#27019 probe, bounded, on 0.154.0.

`— Oraculum, cSharp · this verdict modifies no report, no canon, no trial state; it lands in
raw.research per Cartan's spec. Gavel on any resulting canon change remains @majkee's.`
