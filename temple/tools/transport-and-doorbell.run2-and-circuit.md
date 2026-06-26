# Run 2 — read-side + recalibration (autonomous circuit) + circuit-test data

`status: BUILT + VERIFIED 2026-06-25 · builder: @Trajectory (Claude senior, AUTONOMOUS run) · host: office`
`goal: ~/.claude/houston.goal · extends: transport-and-doorbell.build-report.md (Run 1 = P0/A/B)`
`go-live gaps (both non-sudo, operator steps): doorbell post-commit hook install · recalibration schedule (systemctl --user / crontab)`

## The full Stage-1 transport family is now built
| piece | file (machine layer `~/.config/zsh/`) | run | status |
|---|---|---|---|
| P0 project map | `temple-project-map.zsh` | 1 | live |
| A mail primitive | `temple-mail.zsh` | 1 | live |
| B canon-doorbell | `temple-doorbell.zsh` (+ hook template) | 1 | built; hook pending install |
| read-side | `temple-mail-inbox.zsh` | 2 | live |
| recalibration | `temple-recalibration.zsh` | 2 | built; schedule pending |

All registered in machine-layer `~/.config/zsh/AGENTS.md` (entries A–D). No canon/beacon files written; no `~/` in canon.

## Run 2 build outcome
- **Read-side** (`temple-mail-inbox.zsh`): given `<origin>:<agent>`, resolves via P0, lists UNREAD inbox items
  (presence = unread) + `toAll/` broadcasts (always from reposoma) — filenames only, no content, **ask-first**
  (never auto-reads). Quiet exit when empty. Verify: PASS (reposoma 2+1, piql 2+1, vacuole 0+1, unknown→err).
- **Recalibration** (`temple-recalibration.zsh`): scans `raw.settings/raw.card.*.md` for `verified:`+
  `half_life_days:`; `(today−verified) ≥ half_life_days` ⇒ writes a new dated `recalibration-<date>.md` into
  `_mail/toAll/inbox/` with `host:`. Verify: PASS (synthetic stale card detected + listed; clean state = no file).

## Circuit-test data (the point of the run)
| task | tier | fix-loop cap | **iterations to converge** | margin | outcome |
|---|---|---|---|---|---|
| read-side | standard | 4 | **3** | 1 | converged, PASS |
| recalibration | trivial | 2 | **2** | 0 | converged at cap, PASS |

- **No ceiling hits · no escalations · no sudo/install halts.** The circuit's SUCCESS path is validated: it
  converged, tracked iterations, and respected caps.
- **The FAILURE path (stop+report, escalate-one-rung) is NOT yet exercised** — both tasks passed, so the
  ceiling branch is uncharacterized. Fully answering "max loops by task challenge" needs a deliberately hard
  / underspecified task that forces a ceiling hit. That is the next circuit experiment.
- **Calibration read:** trivial-cap=2 came in with **zero margin** (the 2nd iteration was a zsh
  `local-in-for` quirk, not a logic error). One real task per tier is thin evidence — but the signal is that
  trivial=2 is tight; consider trivial→3, or classify any quirk-prone task as standard.

## Houston's adjudication of @Trajectory's two Run-2 flags — both ACCEPTED
1. **`half_life` → `half_life_days`**: the script followed `card.template.md`'s machine field
   (`half_life_days:` integer, rule `(today−verified) ≥ half_life_days`) over my imprecise prose `half_life`.
   Correct — canon over my wording. Good catch.
2. **Recalibration writes `recalibration-<date>.md` directly (not via A's `<sender>.<scope>.<date>.md`)**:
   honors the 2026-06-19 recalibration handoff's exact filename for `toAll/` broadcasts (a broadcast has no
   single sender-prefix). Intentional; accepted. (Recalibration still uses P0 to find reposoma's root.)

## Remaining (operator + Houston)
- **Operator, non-sudo:** install the doorbell hook (one `cp`+`chmod`, see Run-1 report) · schedule
  recalibration (`systemctl --user` timer or crontab).
- **Houston:** wire the project saddle-boot to call `temple-mail-inbox` (read-side consumption); the
  executor-topology + L10 silence-default remain 0008 Stage-1 decisions for when they come due.
