# Temple tools — the Tier-S registry (0007 L1 escape-valve · architect-seat-emitted, L7)

`status: GAVELED 2026-06-26 (@majkee, Force 4) — emitted per 0007 L7 (definition-of-done, architect-seat duty) at the 2026-06-25 transport build.`
`tier: Tier-S intent only. NAME · JOB · GRADUATION-STATE — hand-authored. NO ~/ paths (§4.7 · 0004 L4): physical resolution lives in the 0003 machine-layer registry, never here.`
`why a tools.md and not PROJECT.yaml tools:* — the temple is the meta-repo, not a project; 0007 L1's escape-valve applies.`
`Tier-G facts (path-exists · interface-responds · deps-resolve · working-state): EMPTY — no agentctl verify-gate exists yet, so L4 forbids hand-stamping them. The transport-selftest harness (#8) is the proto-gate for #3–#8; its green/red matrix is the de-facto verification until agentctl emits a real lockfile.`

## Registry
| # | tool (logical name) | job | graduation-state (L5 ladder) | intent / spec home | physical |
|---|---|---|---|---|---|
| 1 | `agentctl` | the materializer / compile-down + drift-verify gate | **spike** — spec only, unbuilt | `agentctl.spec.md` | — |
| 2 | `propagation-pass` (prompt) | re-project temple canon onto a project surface, report-only (0008 L1) | **brick** — drafted, ran once on piql | `propagation-pass.prompt.draft.md` | — (prompt) |
| 3 | `temple-project-map` (P0) | resolve `project-name → repo-root` on host | **shared-tool** — built + verified | `transport-and-doorbell.spec.md` | machine layer (0003) |
| 4 | `temple-mail` (A) | stage a message to a logical `<origin>:<agent>` address (0008 L7) | **shared-tool** — built + verified | `transport-and-doorbell.spec.md` | machine layer (0003) |
| 5 | `temple-doorbell` (B) | ring stale projects when canon advances (0008 L6/L7) | **shared-tool** — built + verified · **hook installed 2026-06-25** (live) | `transport-and-doorbell.spec.md` | machine layer (0003) + repo `.git/hooks/post-commit` |
| 6 | `temple-mail-inbox` (read-side) | list unread inbox + `toAll/` (presence=unread, ask-first) | **shared-tool** — built + verified | `transport-and-doorbell.run2-and-circuit.md` | machine layer (0003) |
| 7 | `temple-recalibration` | drop a dated reminder when `raw.settings` cards pass `half_life_days` | **shared-tool** — built + verified · **schedule pending** (systemd --user timer) | recalibration handoff (`_mail/vega/inbox/houston.recalibration-script.2026-06-19.md`) | machine layer (0003) |
| 8 | `temple-transport-selftest` | end-to-end verify-it-fires for #3–#7 (the proto-gate) | **shared-tool** — built + verified | `transport-and-doorbell.run2-and-circuit.md` | machine layer (0003) |
| 9 | `doorbell-smoke` | real-trigger smoke probe for the canon-doorbell (closes 0009 L5); exercises the live `commit → hook → base.zsh → temple-doorbell-run` path in a sandboxed temp git repo with `DOORBELL_DRY_FIRE=1`; includes mandatory deliberate-red (planted dead path) | **shared-tool** — built + verified 2026-06-27 (green PASS + deliberate-red PASS) | `doorbell-smoke-probe.spec.draft.md` | machine layer (0003) |
| 10 | `adr-guard` | pre-commit canon-integrity gate for `temple/decisions/` ADRs; two fail conditions: (1) locked-ADR in-place edit — blocks removed/changed lines in any `status:LOCKED` decision record (doctrine §1b); (2) evidence-rot cite — blocks new `_mail/*/inbox/` references (gitignored + drainable paths); wired as pre-commit hook + on-demand alias via `base.zsh`; `--deliberate-red` sandbox smoke proof (two probes, both PASS 2026-07-07); bypass: `git commit --no-verify` | **shared-tool** — built + verified 2026-07-07 (deliberate-red PASS × 2) | fixtures: `~/.config/zsh/ai/adr-guard.fixtures/` (natural red captures) | machine layer (0003) |

## Emission discipline (0007 L7 — the answer to "what else must be emitted")
- **At each graduation rung**, the agent making the transition emits/updates that tool's row here (name · job · graduation-state). The duty came **with the architect seat** — it survives reincarnation.
- The **physical** side (literal paths) is emitted to the **machine-layer `AGENTS.md` (0003)** — never here. Two supply chains, never one file (0001).
- When `agentctl` exists, its verify-gate emits the **Tier-G lockfile** (path/responds/deps/working-state) and the **Stage-1 backstop** flags any on-disk tool with no row here. Until then: Tier-S only, Tier-G empty.
