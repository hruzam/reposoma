# Spec (DRAFT) — real-trigger smoke probe for the canon-doorbell (closes 0009 L5)

`status: DRAFT — Houston-authored, pending @majkee go. Force 4: I draft, he gavels. host: office`
`why: 0009 L5 names a real-trigger verifier as OWED — the sandbox selftest (#8) gates LOGIC, never WIRING, so`
`it would not have caught harness.service's dead path, and cannot prove the relocated post-commit doorbell fires.`
`implementer: Claude-family (@Trajectory — it modifies temple-doorbell.zsh internals + adds a probe; NOT Astrobley).`

## The gap this closes
The doorbell fires only on a real `git commit` touching `temple/decisions/`, and that path is **fail-open**:
backgrounded, stderr-redirected, git ignores hook exit codes. A real test commit ALSO rings every stale twin
(the pending 0008 (a)/(b) decision). So we cannot verify the real fire today without either (a) shipping
canon-change noise to every project, or (b) falling back to the hand-Read that L5 forbids.

## GOAL
1. **Dry-fire mode in `temple-doorbell.zsh`.** Add an env/flag (e.g. `DOORBELL_DRY_FIRE=1`) that makes
   `temple-doorbell-run` resolve staleness and compute *who it would ring* + *what message*, but **write nothing
   to any real inbox** — emit the would-deliver list to stdout / a disposable log instead. Default off
   (production behaviour unchanged).
2. **Smoke probe** `~/.config/zsh/ai/doorbell-smoke.zsh` that exercises the REAL trigger path end-to-end in a
   disposable sandbox: make a throwaway commit touching a temp file under a *sandbox* `temple/decisions/` (or a
   temp git repo), with `DOORBELL_DRY_FIRE=1`, and assert that the hook fired, sourced `ai/base.zsh`, invoked
   `temple-doorbell-run`, and produced the expected would-ring artifact. **No real twin is rung; no real commit
   to the live `temple/decisions/` is made.** Clean up the sandbox (zero residue).
3. **Deliberate-red self-test (0009 L5 + the standing H1 calibration item).** The probe must be run once with a
   PLANTED dead path (e.g. point the hook's source at a non-existent file) and CONFIRM the probe goes RED. A
   gate that has only ever seen green is unverified. Record both the green and the deliberate-red results.
4. **Register** in `tools.md` (row) + note in `~/.config/zsh/guides/ai.md` (debugging chapter).

## Guardrails
- Native zsh; no third-party install; no sudo (genuine install needed → STOP + report).
- **Never** commit to the live `temple/decisions/`; never write to a real project inbox. Sandbox/dry-fire only.
- Report verbatim: the green fire, the deliberate-red, and the residue check.

## Gate it unblocks
Once this probe is green AND a deliberate-red has been driven through it, the relocated doorbell is verified
firing → 0009 L5's "owed real-fire" is paid → @Janus final-confirm → then (and only then, plus the (a)/(b)
call) may `temple/decisions/` be committed.

— Houston (temple architect), 2026-06-27 · host: office
