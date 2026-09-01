---
kind: cold-start-card
date: 2026-09-01
brand: claude
seat: atlas-ui
project: reposoma
projects: [reposoma, ia-sync]
root: ~/reposoma
task: verify the Sella vault migration (do NOT re-run it) + carry the Sella line forward
resume: claude --agent oraculum   # then fire prompt-0 below
model: opus                       # scientist-tier verify + strategic carry-forward
dedicated: oraculum               # the Sella-line owner (historical harvest lead)
recommend: verify against the runbook's Done-when, advise majkee on commit grouping, then resume Probe A/D/E per the journal HANDOFF — do not re-execute the cut
pointers:
  - ~/reposoma/raw.guides/sella/GUIDE.md
  - ~/reposoma/raw.guides/sella/res/RUNBOOK.migration.2026-09-01.md
  - ~/reposoma/raw.guides/sella/dev-journal.sella.md
  - ~/reposoma/pulse.atlas.md
---

## prompt-0

###### prompt

```text
You are @Oraculum, resuming as the Sella-line owner. The Sella corpus was promoted from the
ia-sync/_staging/ buffer into a central vault at ~/reposoma/raw.guides/sella/. The mechanical
migration was executed in-session by @Trajectory (working-tree only — nothing committed). You do
NOT re-run it; you verify it and carry the line forward.

Read, in order:
1. ~/reposoma/raw.guides/sella/GUIDE.md — vault authority (header + manifest + precedence + body).
2. ~/reposoma/raw.guides/sella/res/RUNBOOK.migration.2026-09-01.md — what was done + the Done-when checklist.
3. ~/reposoma/raw.guides/sella/dev-journal.sella.md — the line's journal (HANDOFF first, then LOG).
4. git -C ~/reposoma status --short  and  git -C ~/ia-sync status --short — the unstaged change surface.

Your job:
- VERIFY against Done-when: vault present; GUIDE.md = header+body (no dup YAML/H1); journal rule 6
  amended; 13 stubs in _staging/ (12 corpus + the journal); reconciliation-pad gone; source-map.md
  repointed; BOTH anchors (atlas-ui + atlas-auto) inserted; Cartan notification present at
  ~/ia-sync/session/rellays-calude-codex/ATLAS-CARTAN-sella-mount.2026-09-01.md. Do NOT re-execute.
- NOTE: journal.host-cleanup.md was intentionally reverted by Atlas (a STEP-7 over-reach that
  rewrote a historical git-status snapshot) — leave it reverted, do not "re-fix" it.
- If clean: advise majkee on commit grouping — reposoma vault first (agents read reposoma directly),
  then ia-sync stubs/anchors + `bash deploy.sh` (carries the anchors live). The wrapper/cards arc is
  ALREADY committed, so there is no ordering tangle. If gaps: list them for @Delta/majkee; do not
  silently fix mid-verify.
- Then carry the Sella line per the journal HANDOFF (Probe A/D/E open; profiles still G3-HELD).
- Journal your entry to ~/reposoma/raw.guides/sella/dev-journal.sella.md (LOG, newest-on-top,
  stamped `[2026-09-01 · claude/oraculum · opus · <host> · ref: this card]`). Report to majkee.
```

## Body — continuity

**Why this card exists.** majkee asked atlas-ui to wire itself (and atlas-auto) to the Sella
discipline + workshop so a fresh incarnation is not hand-navigated. The fix was a `raw.guides/sella/`
vault + terse anchors in both creator bodies. This card hands the *verification + ownership* of that
landed vault to @Oraculum (the Sella-line harvest lead), separate from the mechanical cut (@Trajectory).

**State at write (all UNSTAGED — majkee's commit gavel pending):**
- reposoma (new): `raw.guides/sella/` = GUIDE.md · dev-journal.sella.md · src/(9) · raw/(3, incl. the
  COPIED unikuklatrix Asymmetry research w/ provenance note) · res/RUNBOOK.
- ia-sync: 13 `_staging/` stubs · `sella.reconciliation-pad.md` deleted (plain rm) · atlas-ui.md +
  atlas-auto.md anchors · `codex/skills/codex-harness/references/source-map.md` repointed.

**No live session bed exists** for this — so this card carries its own next-action (the verify queue
in prompt-0). It is a transfer pointer, not a competing doing-state.

**Lesson to carry:** "point, never copy" + ownership boundaries drove the source dispositions —
Cartan's observation + jacquard.toml stay on Codex turf (pointed), research stays in raw.research
(pointed), only the Sella-own durable docs were homed. Precedence: Sella wins on doctrine; volatile
CLI facts follow the dated live source (its own L8).

**Drain:** the reader who verifies this moves the card `card/` → `archive/` (Cinderella).
