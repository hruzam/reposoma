---
from: reposoma:oraculum
to: reposoma:oraculum (Sunday incarnation)
scope: audit-prestage-subai
date: 2026-07-11
host: office
rule: 0005 the stone — facts and maps only
---

# Audit pre-stage territory map — subai.devenv

## §Path + identity
- Logical name `subai.devenv` · future official-name `chitnix` (PROJECT.yaml; rename deferred by operator gavel 2026-06-24).
- Path: `/home/hruzam/www/ovum/subai.devenv` (temple-project-map key `subai.devenv`).
- Beacon: `reposoma/registry/subai.devenv.md` — status `cleared`, host office, updated 2026-06-23.
- Git: branch `core`, local-only (no remote). 4 commits (latest `e457db9`-family: `e457df9 fingers`). 53 tracked files. Dirty = 5 untracked paths, all under `_mail/` (4 houston inbox items + `_mail/monkey/`); zero tracked modifications.
- One-liner: skin + fingers layer over living CLI agents (claude/cursor/agy), grafted at the MCP+hooks seam.

## §Reading order for the audit saddle
1. `flag.md` (mtime 06-25) — lock index L1–L4 + "Open — not yet locked"; the decision spine.
2. `session/handoff.2026-06-23.md` — newest saddle; carries its own resume-read-order + the one live thread (brick1 PTY-duplex spike awaiting operator result).
3. `PROJECT.yaml` (mtime 06-25) — contract + Tier-S tool-map (temple decision 0007 first runner).
4. `CLAUDE.md` — the four laws (MEDIUM · SEAM · PORTABILITY · LIGHT) + layout legend.
5. `_substrate/dev.journal.jsonl` — pulse ledger v0001–v0031 (2026-06-17 → 2026-06-25); v0031 records 0007 canonization.
6. `_mail/houston/inbox/` — 7 items present (= unread by protocol), newest 2026-07-07.
7. `docs/decisions/0001–0004` — Tier-S backing records for L1–L4.
8. `part1.blueprint.md` — full architecture (mission, medium, brick catalogue, phase plan).
9. `research/outputs/` — 9 outputs, dated 06-17 → 06-24. `README.md` / `GEMINI.md` — quickstart / Gemini shared memory.

## §Tree summary (top-2 levels, file counts)
```
_substrate/     2      pulse.py + dev.journal.jsonl (the medium)
_bus/          21      bus.py, in.md, inbox/ 2 cards, done/ 10 cards, outbox/ 3
_mail/          9      houston/inbox 7 · monkey/inbox 1 · README.md
part1.fingers/ 11091   real sources: 9 (mcp_finger_primitive.py, hooks/, spectral/, tests/)
                       — 11,080 of the count = spectral/.venv (self-ignored via venv .gitignore)
part1.skin/     2      skin_tail.py, sublime_phantom.py
part2.browser/  1      README.md (later-phase placeholder)
part3.editor/   1      README.md (later-phase placeholder)
research/      12      inputs/ 2 briefs · outputs/ 9 · README.md
docs/           4      decisions/0001–0004
session/        3      handoff 06-17, 06-18, 06-23 (supersedes-chain)
.claude/        1      settings.local.json; agents/ dir empty
root files: PROJECT.yaml · flag.md · CLAUDE.md · GEMINI.md · README.md · part1.blueprint.md · .gitignore
```

## §State surfaces
- **Pulse**: `_substrate/dev.journal.jsonl` — 31 pulses, v0001 (2026-06-17, power-cut recovery) → v0031 (2026-06-25, tool-lifecycle canonized as temple 0007).
- **Flag**: L1 ownership · L2 spectral · L3 piql · L4 _mail-defer — all LOCKED 2026-06-17 (L2 first-read 06-18). Sections also: Constraints & trust-layer intent · Z parked · Open — not yet locked.
- **Session**: 3 handoffs; latest 2026-06-23 ("canon normalized; living-seam axis opened; brick1 spike out for empirical").
- **Mail** (presence-in-inbox = unread; no archive/ dirs exist yet): houston 7 — canon-doorbell ×4 (06-27, 07-02, 07-03, 07-07), brick1-seam-thread (06-30), nabla studies ×2 (06-20); monkey 1 — houston.brick1-test-guide (06-30).
- **Bus**: inbox 2 open cards (card.008.mail-hygiene-followup, card.008.spectral-reference); done/ 10; outbox/ 3.

## §Contract facts (PROJECT.yaml, verbatim key fields)
- `name: subai.devenv` · `official-name: chitnix`
- `stack: { lang: python3.8+, framework: fastmcp }`
- `commands: test: "python3 _substrate/pulse.py --selftest" · lint: "TBD" · build: "none (file-driven bricks)" · run: "python3 part1.skin/skin_tail.py + python3 _bus/bus.py submit"`
- `docs: architecture: part1.blueprint.md · decisions: flag.md`
- `agents: [ architect, challenger, researcher, implementer, deep-core-specialist, deterministic-tool-builder, surface-builder ]`
- `mcp_profile: subai-fingers`
- `tools:` emit_pulse (project-brick) · privacy_gate (project-brick) · spectral (project-brick) · recall_lighthouse (rented-external, "RENTED from reposoma over MCP")
- `guidelines_channel: stable` · Tier-G lockfile: "Absent until a real verify-gate exists" (comment in file).

## §Neutral observations (facts, no verdicts)
- Beacon (updated 06-23) lighthouse line points to `session/handoff.2026-06-17.md`; `session/` contains newer `handoff.2026-06-23.md`.
- `_mail/README.md` states "gitignored — only this README + .gitignore are tracked"; no `.gitignore` exists in `_mail/`, root `.gitignore` has no `_mail` rule; 3 mail files are git-tracked, 5 paths untracked.
- `_mail/README.md` names seats `claude/ cursor/ toAll/`; directories on disk are `houston/ monkey/`.
- Duplicate file counts: mail README protocol says processed → archive/; no archive/ dirs exist; oldest inbox items dated 2026-06-20.
- `README.md` ends with a repeated title line `# subai.devenv` (line 26).
- `.claude/agents/` exists and is empty. `commands.lint` = "TBD".
- Date spread as of 2026-07-11: last pulse 06-25 (16 days), last commit `e457df9` (fingers), last mail 07-07 (4 days), last handoff 06-23 (18 days).
- `part1.fingers/spectral/.venv` present on disk (11,080 files), excluded from git by the venv's own internal .gitignore, not by project .gitignore.

## §What this map deliberately does NOT contain
Per 0005 "the stone": no opinions, no leans, no problem rankings, no recommendations, no audit
verdicts. Every item above is a location, a date, a count, or a verbatim quote. Interpretation
belongs to the Sunday audit session, operator present.
