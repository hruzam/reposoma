# Decision Record — Machine-layer `ai/` namespace + `base.zsh` signpost for AI-bonded scripts

`status: GAVELED-BY-OPERATOR-INSTRUCTION 2026-06-27 (@majkee — "immediate fast structural decision (canon)"). @Janus reviewed → REVISE folded into L5 (pre-lock revision window; not yet committed). Append-only ONCE committed (doctrine §1b). index.md row 0009 + machine-layer AGENTS.md to follow.`
`date: 2026-06-27 · host: office · plane: machine layer (0003) — extends 0003, does not bind ~/ paths into any project surface (§4.7 · 0004 L4)`
`shape: light ADR — context · locked · verify-rule (Janus-revised) · consequences`

---

## Context

AI-bonded machine-layer zsh scripts had accreted **flat** in `~/.config/zsh/` (the temple transport family
`temple-*`, alongside the card-freshness checker and others). The Gemini sector had already begun a `ai/`
subfolder — `ai/base.zsh` (a signpost that sources `ai/gemini-base.zsh` + aliases the checker) and
`ai/harness-check.zsh`. A **move-without-rewire** then left `harness.service` pointing at the now-dead
`fresh/harness-check.zsh` path: the weekly timer failed silently. That bug is the motivating evidence — not a
person's fault (who moved the file is unrecorded), but a **verify-gap**: the move was checked against the
*script* (a hand-run dry-run), never against the *trigger* (the systemd unit). Operator directed consolidation
of the `temple-*` family into the same `ai/` namespace and standardization of the signpost pattern.

---

## Locked (the shape)

**L1 — `ai/` is the home.** AI-bonded machine-layer scripts live under `~/.config/zsh/ai/`. The `temple-*`
transport family (project-map, mail, doorbell, mail-inbox, transport-selftest) relocates there.

**L2 — `ai/base.zsh` is the signpost.** Most AI-bonded scripts are sourced *from* `base.zsh`; consumers source
the signpost, not individual scripts. **`base.zsh` MUST be idempotent and side-effect-free on source** — it is
sourced non-interactively (e.g. by the git hook), so sourcing it must define functions/aliases only, never run
work or print.

**L3 — Exception: cron/timer/directly-invoked scripts may wire directly.** A script invoked by a systemd unit,
cron, or direct call MAY source its own dependencies (it does not pass through interactive shell init) — but it
still **lives under `ai/`**, and its trigger unit MUST reference the `ai/` path.

**L4 — New AI-bonded scripts adopt this style by default.** This is the standing convention.

**L5 — Verify-it-fires exercises the REAL trigger — and that requires an instrument 0009 OWES (Janus-revised).**
Definition-of-done for any AI-bonded script with a trigger is the **real trigger** (systemd unit / git hook /
cron) firing and producing its artifact — never the script run by hand. **This rule is not yet satisfiable by
existing machinery:** the transport-selftest (#8) is **sandboxed / green-by-construction** — it gates script
*logic*, not *wiring*, and would not have caught the `harness.service` dead path. Therefore 0009 owes a
**real-trigger smoke probe, distinct from the sandbox selftest**, that fires each live trigger at its real path
and asserts the expected artifact appears. Because firing a real trigger produces real residue (the doorbell
rings every stale project), the probe REQUIRES a **dry-fire mode** (log-only, or a disposable target), and the
probe itself must be driven once with a **deliberate red** (a planted dead path) before it is trusted — a gate
that has only ever seen green is itself unverified.
**Fail-open caveat (why this is load-bearing, not optional):** the post-commit doorbell runs
`( source base.zsh; temple-doorbell-run ) &` — backgrounded, stderr-redirected, and **git ignores post-commit
exit codes**. A broken doorbell surfaces *nowhere* but its own log. So its real-fire verification cannot be
inferred from green components.

---

## Consequences

- One namespace, one signpost: the next incarnation reads `ai/base.zsh` to find the AI-bonded surface, and the
  machine-layer `AGENTS.md` lighthouse lists what's where (the "what"; this record is the "why/rule").
- The duplicate card-freshness notifier (`temple-recalibration.*`, monthly) is erased in favour of the Gemini
  `harness-check` (weekly) — done **only after** harness was verified firing live (no zero-checker window).
- **This relocation's own doorbell real-fire is OWED before reliance.** Components verified green (base.zsh
  sources clean, functions resolve from the hook's exact source line, selftest green) — but the integrated
  `commit → hook → fire` was NOT exercised (a real `temple/decisions/` commit also rings every stale twin, the
  pending 0008 (a)/(b) call). **Therefore: nothing under `temple/decisions/` is committed until (1) the smoke
  probe proves the relocated doorbell fires and (2) the (a)/(b) decision is taken.**
- `0003` (machine provenance) governs; this extends it. No `~/` paths bound into project surfaces (§4.7).
- Consolidation ("contract small scripts into a larger one") is a **separate second pass** after the
  move+rewire+erase is green — behaviour-changing work is not bundled with relocation.

*Next: build the L5 smoke probe (spec: `temple/tools/doorbell-smoke-probe.spec.draft.md`) → fire the relocated
doorbell in dry-fire mode + a deliberate red → then @Janus final-confirm · index.md row 0009 · machine-layer
AGENTS.md committed to the `ai/` layout.*

*Status note (appended 2026-07-07, wave-3a drift flag): the "Next: build the L5 smoke probe" line
above is historical — the probe was already built and the L5 real-fire was PAID (green + deliberate-red)
on 2026-07-02; run evidence lives in the 0010 record. This note closes that residual; no doctrine change.*
