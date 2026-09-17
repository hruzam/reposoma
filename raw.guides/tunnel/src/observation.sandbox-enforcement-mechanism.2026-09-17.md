# observation — the sandbox setting is kernel-enforced, not shim-trusted

`class: dev-layer observation (uncanonical, sella-src pattern) · driver: Trajectory (ia-sync`
`seat) · date: 2026-09-17 · codex-cli: 0.154.0 (npm @openai/codex, linux-x64 musl vendor` 
`binary) · host: home`

## The question that triggered this

Operator pushback on `res/user-run.md` §"Sandbox check before write-side dispatch": a
`sandbox: {type, networkAccess}` field sitting in our local state JSON is only meaningful
if something in the Codex vendor machinery actually enforces it — otherwise it is a label
we trust the model to honor, which is exactly the kind of soft gate Law 2.4 exists to avoid.

## What was traced

1. **Our layer only forwards the value.** `tunnel-codex.py:325-326` sends
   `{"sandbox": sandbox, "approvalPolicy": "never"}` as `thread_start` params over the
   app-server JSON-RPC protocol. Nothing on our side interprets or enforces it — by
   design, the tunnel shim is a thin client.
2. **The vendor binary contains a real OS-level sandboxing module.** `strings` on the
   actual vendor executable (not the npm JS launcher —
   `~/.npm-global/lib/node_modules/@openai/codex/node_modules/@openai/codex-linux-x64/vendor/x86_64-unknown-linux-musl/bin/codex`)
   surfaces: `sandboxing/src/landlock.rs`, `LandlockRestrict`, `landlock_ruleset`,
   `landlock_path_fds`, `seccomp-then-exec`, `Error calling seccomp`, `RestrictSelf`,
   `use_legacy_landlock`, `CODEX_SANDBOX_NETWORK_DISABLED`, plus a macOS path
   (`Seatbelt`/`sandbox-exec`) and a Windows path. This is OpenAI's actual enforcement
   code compiled into the binary — Linux uses **Landlock LSM** (filesystem access
   control) + **seccomp** (syscall filtering, notably network), not an
   application-level "please don't write" check.
3. **Live proof, via the exposed `codex sandbox` CLI entry point** (same enforcement
   code path the app-server delegates to for a thread's turns; run in the session
   scratchpad, nothing repo-touching):
   - Read-only permissions (`-c 'sandbox_permissions=["disk-full-read-access"]'`),
     attempted write → `sh: .../file: Read-only file system` — kernel **EROFS**, not an
     app refusal. `ls` confirmed no file was created.
   - Same profile, attempted network (`curl https://example.com`) →
     `curl: (6) Could not resolve host: example.com` — DNS/socket syscalls blocked at
     the kernel level (the compiled-in `CODEX_SANDBOX_NETWORK_DISABLED` wiring through
     seccomp), not an application-level denial.

## The finding

`sandbox.type` in `tun status` is not a courtesy flag the model is trusted to respect —
it selects a real **Landlock ruleset + seccomp filter jail** (Linux) that the kernel
enforces around every tool-exec the model attempts, immune to the model "deciding"
otherwise. This is why `res/user-run.md`'s "`/tmp` is not a door" claim holds as a
mechanism fact: Landlock path permissions don't care where the write target is, only
whether the ruleset grants it.

## Cross-references

- Confirms and hardens dev-journal 2026-09-04 (Atlas) entries #4 and #9 — those recorded
  the *behavior* (readOnly blocks write/delete, no `/tmp` escape) from the outside;
  this entry adds *why* it holds (kernel LSM + seccomp, not shim trust).
- `res/user-run.md` §"Sandbox check before write-side dispatch" and §"Sandbox
  escalation — when to widen" describe usage; this file is the mechanism evidence
  underneath both, in the same spirit as `observation.app-server-wait.2026-09-10.md`.
