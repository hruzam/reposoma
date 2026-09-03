# dev-journal.tunnel — field-usage lessons ladder

> Uncanonical dev-layer file (same freedom as `src/`), NOT `/guide`-served. Append-only
> ladder: newest entry on top, each stamped `[YYYY-MM-DD · driver]`. Holds lessons from
> actually DRIVING the tunnel — the friction the GUIDE/chapter can't predict. When a lesson
> hardens into a rule, graduate it into `GUIDE.md` or `res/user-run.md` and point back here.
> Sibling to sella's `dev-journal.sella.md`. Registered in `GUIDE.md` Manifest.

---

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
