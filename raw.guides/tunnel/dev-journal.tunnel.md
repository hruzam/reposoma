# dev-journal.tunnel — field-usage lessons ladder

> Uncanonical dev-layer file (same freedom as `src/`), NOT `/guide`-served. Append-only
> ladder: newest entry on top, each stamped `[YYYY-MM-DD · driver]`. Holds lessons from
> actually DRIVING the tunnel — the friction the GUIDE/chapter can't predict. When a lesson
> hardens into a rule, graduate it into `GUIDE.md` or `res/user-run.md` and point back here.
> Sibling to sella's `dev-journal.sella.md`. Registered in `GUIDE.md` Manifest.

---

## [2026-09-18 · Trajectory] — the parametrization ceiling, and why `-c` is the keystone

Drove the question "can we loosen the leash — model, effort, identity?" to the bottom.
The shim sends **3 of 16** `thread/start` params and **2 of 17** `turn/start` params; the
rest is unused surface, tight by omission rather than design.

**The blocker and the key, both found:** Codex's native preset registry (`[profiles.*]` +
`--profile`) is **structurally unreachable** here — the binary's own error string omits
`app-server` from the commands `--profile` applies to, and `-c profile="x"` is rejected as
a retired config key. But plain `-c key=value` **does** work on app-server (handshake
verified). Since the shim spawns one app-server per verb with no daemon, **spawn-level
config is effectively per-turn config** — so `-c model_reasoning_effort="high"` on one
`send` needs no `turn/start` param work at all, and per-vault settings need no global
`config.toml` edit. One small primitive covers most of the leash.

**Session hygiene, measured:** `close` orphans the thread rather than ending it (state file
is the sole holder of the threadId — lose it and recovery means date-hunting
`~/.codex/sessions/`). The state file path IS the thread address. And the `[usage: …]` tail
prints both `last` and `total`: reading `total` (177K/258K ≈ 69 %) instead of
`last.input_tokens` (51K ≈ 20 %) rotates a thread ~3× too early and throws away the memory
it exists to hold.

Full trace, probe tables, and the bundler-not-compiler design note:
`src/observation.parametrization-and-session-hygiene.2026-09-18.md`.

## [2026-09-17 · Trajectory] — the sandbox setting is kernel-enforced, not shim-trusted

Operator pushback on the sandbox check (`res/user-run.md` §"Sandbox check before write-side
dispatch"): a `sandbox.type` string in local state is only meaningful if something in the
Codex vendor machinery actually enforces it. Traced it end to end — it does.

`strings` on the real vendor binary (not the npm JS launcher) surfaces OpenAI's actual
enforcement code: `sandboxing/src/landlock.rs`, `LandlockRestrict`, `seccomp-then-exec`,
`CODEX_SANDBOX_NETWORK_DISABLED` (Linux: **Landlock LSM** for filesystem + **seccomp** for
syscalls/network; macOS: `Seatbelt`/`sandbox-exec`). Live-verified via the exposed
`codex sandbox` CLI (same enforcement path the app-server delegates to for a thread's
turns): a read-only permission set turned a write attempt into a literal kernel `EROFS`
("Read-only file system") and a network attempt into a DNS resolution failure — both
kernel-level refusals, not application-level "no"s.

**Takeaway:** `tun status`'s `sandbox.type` selects a real OS-level jail (Landlock ruleset +
seccomp filter on Linux) that the kernel enforces around every tool-exec the model attempts —
immune to the model "deciding" otherwise. Hardens #4 and #9 below (which recorded the
*behavior* from the outside) with the *mechanism* underneath. Full trace + live-test
transcript: `src/observation.sandbox-enforcement-mechanism.2026-09-17.md`.

## [2026-09-10 · Trajectory] — the shim's OWN wait-window dies on research-grade turns (+ exits 0)

Distinct from the 09-04 process-kill lesson below: with the harness cap out of the picture,
`tunnel-codex.py` itself gave up — `timed out after 6.0s` (cold start) and `27.2s` "waiting
for app-server output" — leaving the turn `status: "interrupted"`, `completedAt: null`.
Trigger: a counter-sign brief that sent Codex into WEB SEARCH (it fetched Termux upstream
sources to validate extra-keys syntax — admirable diligence, fatal to the transport). Two
turns lost; `tun read` reconciled the interrupted state exactly per contract.

**Contract defect, second finding: the shim EXITED 0 on both failures.** The man-page
contract (10/11/12/13/20/30/40/50) has no code for its own output-wait timeout — a driver
script chaining on `&&` sails past a dead turn.

**Workaround that held (3 clean verdict rounds):** brief with "NO web search, LOCAL file
reads only, keep the turn short" — the model complies and the turn fits the window.

v1 candidates: adaptive/longer app-server wait or `--wait <s>` flag · nonzero exit (40?)
on internal timeout. Evidence: `src/observation.app-server-wait.2026-09-10.md`. Field
context: ia-sync `codex-remote-control-cli-01-wrapper`, Cartan counter-sign rounds.

## [2026-09-04 · Atlas] — first real work-dispatch: readOnly verify → gated execute

Context: drove the tunnel to hand Cartan a write-side cleanup task (Codex-desktop-app `.codex/`
fan-out). Home box, thread `01a06953…`, model `gpt-5.6-sol`. Eight field lessons banked.

**1. Process-kill = turn-INTERRUPT, not a survivable detach.** My first `ask` exceeded the
Bash-tool 120s foreground cap → the harness killed the process → the turn landed in the thread
as `status: "interrupted"`, `completedAt: null`, **no `final_answer`**. So the naive model
"stored thread continues server-side regardless" is FALSE for an in-flight turn: killing the
local driver interrupts the server turn. A long turn must keep its driver alive to completion.

**2. Background is THE pattern for long turns.** Re-driving with `run_in_background: true`
(harness) let the turn finish naturally → exit 0, full deliverable on the output file. Rule of
thumb: any turn expected > ~90s (multi-repo audit, script generation, deep reasoning) → background
it, or raise the foreground timeout well past the model's thinking budget. The default 120s is the trap.

**3. `read` re-fetches the thread INCLUDING interrupted turns — free forensics.** After the kill,
`tun read` returned the interrupted turn's `commentary` items verbatim (which skill Cartan loaded,
partial findings) at zero turn-cost. Good for post-mortem and for recovering a result whose driver
died AFTER the turn actually completed. `read` never spends a ChatGPT turn.

**4. `status.sandbox` is a first-class gate — check it BEFORE dispatching write-side work.**
`tun status` showed `sandbox: {type: "readOnly", networkAccess: false}`. That reshaped the whole
task: the tunnel Codex could READ/verify the repos but could not delete/edit/commit/push. Two
responses exist — (a) reopen with a writable sandbox, or (b) use readOnly Codex as verifier +
plan-author and hand execution to a write-capable seat. **(b) is usually the better design**: it
keeps execution gated AND buys a decorrelated cross-vendor verification for free. I took (b).

**5. Cross-vendor verify earns its turn — it caught two real errors** I was confident about:
fantasyobchod's `.codex/` was NOT ignored (merely untracked), and its `delta-sql.toml` was a
LEGIT seat to hold, not dirt. A readOnly Codex inspecting live repos is a strong blind check;
run it even when sure.

**6. Continuity is real — a continuation turn needs no re-brief.** After the interrupt I sent only
"your previous turn was interrupted; now emit the deliverable" — Cartan still held the full brief +
its own partial findings from the killed turn. The stored thread's memory is the whole point;
don't re-paste context you already spent tokens on.

**7. Prefer `send` over `ask` for LONG deliverables.** `ask` = send + reconcile (streamed vs
read-back), which can exit 50 on a long/streamed script output and add ceremony. For a big emitted
artifact, `send` (result on stdout) + optional `read` is simpler. Reserve `ask` for short,
verification-critical answers where the reconcile guarantee matters.

**8. Each of my Bash calls is a FRESH shell — set state inline every time.** The operator's
`export TUNNEL_CODEX_STATE=…` lived in THEIR shell; my non-interactive Bash doesn't inherit it and
doesn't persist between calls. I ran `export TUNNEL_CODEX_STATE=~/ia-sync/session/tunnel-home.state.json;
zsh ~/.config/zsh/ai/tunnel-codex.zsh <verb>` on every invocation (calling the script directly
rather than the `tun` palette alias, which may not resolve non-interactively). `--state <path>`
is the alternative; either way, never assume the env carries over.

**9. Sandbox is a thread-birth property with three values — and `/tmp` is not an escape.**
`tun open --sandbox {read-only|workspace-write|danger-full-access}`; default read-only (Law 2.4).
The policy governs the codex process + all its children, so a script inherits it regardless of
location — there is no `/tmp` side-door (a common misconception). Widening requires `tun close`
→ new `open` (thread memory lost); and v0 bakes `approvalPolicy: "never"`, so a writable sandbox
executes with no prompt — the only gate is the operator's `open`. Multi-repo fan-out (like this
4-repo cleanup) would force `danger-full-access` — a poor fit; keep those gated via
verify→execute. Folded into `res/user-run.md` §"Sandbox escalation".

Bonus: the Codex side honored the shared rule surface — Cartan flagged the AGENTS.md + project
instructions exceeding the 120-line home-box threshold. The CLAUDE.md-style rules reach the Codex line.

**Graduation candidates → GUIDE/chapter:** #1+#2 (client-timeout ≠ turn-death; background long turns)
and #4 (check `status.sandbox` before write-side dispatch) are hardened enough to fold into
`res/user-run.md` next pass.
