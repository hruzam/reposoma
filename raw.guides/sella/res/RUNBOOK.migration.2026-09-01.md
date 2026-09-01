---
title: RUNBOOK — Sella vault migration (ia-sync/_staging → raw.guides/sella)
for: @Oraculum (Sella harvest lead) · executes on majkee's gavel
by: @Atlas (atlas-ui) · office · 2026-09-01
form: runbook (raw.guides form — see raw.guides/PAD/pad-builder.md for the shape)
gate: majkee blessed the plan + dispositions 2026-09-01; commits/push/deploy are majkee's gavel
authoritative-plan: raw.guides/sella/GUIDE.md (manifest) + Eagle sweep 2026-09-01
---

# Sella vault migration — runbook

Promote the Sella corpus from the `ia-sync/_staging/` buffer into the central
`reposoma/raw.guides/sella/` vault. **Atlas already authored `GUIDE.md` (header + manifest) and
this runbook.** Oraculum executes the mechanical move + stubs + wiring below. @Delta may be spawned
for the file ops. **Nothing commits/pushes/deploys without majkee's gavel.**

## Dispositions (majkee-gaveled — do not re-decide)
- **Stubs, not symlinks.** Every moved file leaves a 3-line stub at its old `_staging/` path
  (`MOVED → reposoma/raw.guides/sella/… (2026-09-01)`). No machine consumer reads these (Eagle:
  zero zsh/hook/systemd refs) — pointers suffice.
- **Move:** the coder-guide body, `dev-journal.sella.md`, the `src/` set, the `raw/` receipts.
- **Copy (no stub, original stays):** the Asymmetry research from unikuklatrix (temporary
  dual-hold; majkee consolidates later).
- **Point, do NOT move:** Cartan's observation (`_staging/codex/…` = Codex turf), `jacquard.toml`
  (config), and all `raw.research/` reports + the unikuklatrix flag (proper homes already).
- **Drop:** `sella.reconciliation-pad.md` (transient, self-`rm`) — remove, no stub.
- **Leave:** archived mail cards in `reposoma/_mail/monkey/archive/` (historical; stubs redirect).

## STEP 0 — safety / state check
```zsh
cd ~/reposoma && git status --short          # note pre-existing changes
cd ~/ia-sync  && git status --short          # NOTE: working tree already carries prior session
                                             #   work (wrapper/retry/contract/cards/selftest/maxTurns)
ls ~/reposoma/raw.guides/sella/GUIDE.md      # must exist (Atlas authored it)
ls ~/ia-sync/_staging/sella.coder-guide.md   # source of the discipline body
```
Verdict: GUIDE.md present + coder-guide present → proceed. Missing → STOP, ping Atlas.

## STEP 1 — create vault subdirs
```zsh
mkdir -p ~/reposoma/raw.guides/sella/src ~/reposoma/raw.guides/sella/raw
```

## STEP 2 — append the discipline body to GUIDE.md (verbatim, drop old frontmatter + old H1)
```zsh
sed -n '/^## Receipts/,$p' ~/ia-sync/_staging/sella.coder-guide.md \
  >> ~/reposoma/raw.guides/sella/GUIDE.md
tail -5 ~/reposoma/raw.guides/sella/GUIDE.md   # sanity: body tail present
```
Then stub the coder-guide original (STEP 4 stub form). Verdict: GUIDE.md = Atlas header + `##
Receipts …` body onward, no duplicate YAML/H1 → good.

## STEP 3 — move the src/ set (cp → vault, then stub original in STEP 4)
```zsh
V=~/reposoma/raw.guides/sella; S=~/ia-sync/_staging
for f in \
  sella-sibling.codex.coldstart.md \
  sella.cross-vendor.architecture.candidate.2026-08-04.md \
  sella.cross-vendor.architecture.errata-r1.2026-08-04.md \
  sella.probe-a.protocol.md \
  sella.observation.jacquard.2026-08-05.md \
  sella.observation.atlas-office-2026-08-03.md \
  sella.codex-consult.wrapper-tune.2026-08-31.md \
  radio.wave-to-atlas.sella-codex-line.2026-08-03.md \
  radio.wave-to-atlas.sella-consultation.2026-08-05.md ; do
    cp "$S/$f" "$V/src/$f"
done
```
Move the two receipts to raw/:
```zsh
for f in sella.receipt.epoch-2026-08-02.md sella.receipt.codex.2026-08-03.md ; do
    cp "$S/$f" "$V/raw/$f"
done
```

## STEP 4 — stub every moved original (in `_staging/`)
For each file moved in STEP 2/3 (the coder-guide, the 9 src files, the 2 receipts), overwrite the
`_staging/` original with a stub:
```
# _staging/<name> — STUB (migrated 2026-09-01)
MOVED → reposoma/raw.guides/sella/<src|raw|GUIDE.md as applicable>/<name>
Reason: Sella corpus promoted to its central vault. See raw.guides/sella/GUIDE.md.
```

## STEP 5 — COPY the Asymmetry research (no stub; original stays)
```zsh
ls ~/unikuklatrix/nablarva/meshup/natural-ladders-grounded-phase.a-sym/   # confirm exact name
cp ~/unikuklatrix/nablarva/meshup/natural-ladders-grounded-phase.a-sym/asymmetry.codex-bonding-layer.research.2026-08-05.md \
   ~/reposoma/raw.guides/sella/raw/
```
Prepend a 2-line provenance note to the copy: `# COPY — original authoritative at
~/unikuklatrix/…/a-sym/ until majkee consolidates (temporary dual-hold, majkee's call, 2026-09-01)`.

## STEP 6 — move the journal + amend its inner-law rule 6
```zsh
cp ~/ia-sync/_staging/dev-journal.sella.md ~/reposoma/raw.guides/sella/dev-journal.sella.md
```
In the NEW copy, edit rule 6 (currently: "This file lives in `_staging/` — git-tracked,
deploy-inert.") →
`6. This file lives in **raw.guides/sella/** — git-tracked in reposoma, deploy-inert (reposoma
never goes through deploy.sh; the office↔home transport is git pull). Point, never copy.`
Then stub the `_staging/dev-journal.sella.md` original (STEP 4 form).

## STEP 7 — fix the two hard-path references (real edits, not stubs)
- **`~/ia-sync/journal.host-cleanup.md`** (Kelvin's journal — one-line path edit; touches a
  machine-seat file, low risk): repoint any `_staging/dev-journal.sella.md` reference to
  `reposoma/raw.guides/sella/dev-journal.sella.md`.
- **`~/ia-sync/codex/skills/codex-harness/references/source-map.md`** (LIVE skill reference):
  repoint the `sella-sibling.codex.coldstart.md` row from `_staging/` to
  `reposoma/raw.guides/sella/src/sella-sibling.codex.coldstart.md`.

## STEP 8 — drop the reconciliation-pad (no stub)
```zsh
git -C ~/ia-sync rm ~/ia-sync/_staging/sella.reconciliation-pad.md   # transient, self-rm by design
```

## STEP 9 — intra-corpus references: LEAVE AS-IS
The moved files cross-reference each other by old `_staging/sella.*` paths. These now resolve via
the STEP-4 stubs (redirect). Do NOT bulk-rewrite dozens of historical cross-refs — churn for no
gain; the stubs handle it. (If a future reader finds stub-hopping annoying, fix on touch.)

## STEP 10 — FINALIZATION: wire atlas-ui to the vault (the original ask)
Insert this section into `~/ia-sync/claude/agents/atlas-ui.md` immediately BEFORE the
`## Primitive selection` heading (verbatim — Atlas authored it):

```markdown
## Harness-build doctrine — Sella-first (read when building, not every saddle)

Before I build or reshape a harness primitive (agent · skill · hook · command · relay), or open a
cross-vendor (Claude↔Codex) exchange, I consult the **Sella vault**:
`reposoma/raw.guides/sella/GUIDE.md` — the temple's discipline-language (agents=programs,
skills=methods, harness=OS; the compiler is stochastic). Sella is DRAFT/experimental but in daily
use: I conform via a terse anchor where it earns lift, never by loading all nine laws (its own
L2/L9). On a doctrine contradiction with sibling builder guides, Sella wins; volatile CLI/vendor
facts follow the dated live source (Sella's L8).

**My workshop surfaces:** surgical table `~/ia-sync/claude/…` (global builds) · `~/ia-sync/_staging/`
(deploy-inert buffer) · the Sella vault `raw.guides/sella/{GUIDE,src,raw}` + `dev-journal.sella.md`
· the relay contract `~/.config/zsh/guides/codex-relay.contract.md` · sibling guides
`raw.guides/{codex-builder-user,cold-start-card,runbook,status}` · cold-start vault
`reposoma/_cold-start/`.

**Meeting Cartan (Codex co-architect):** cross-runtime handoffs land as session files (e.g.
`session/…/CARTAN-ATLAS-SUMMARY.md`) + Cartan's observations in `~/ia-sync/_staging/codex/`; shape
in ia-sync `AGENTS.md §"Claude↔Codex handshake"`. ⚠ `HANDSHAKE.md` is referenced there but ABSENT
from the checkout (flagged 2026-09-01) — until it exists, use the session-file channel.

**Journaling:** my own state → `pulse.atlas.md` (single-writer, in saddle). Sella / cross-vendor
work → `raw.guides/sella/dev-journal.sella.md` (HANDOFF overwrite · LOG append-only stamped).
```
### STEP 10b — condensed twin anchor into atlas-auto.md
Insert this condensed section into `~/ia-sync/claude/agents/atlas-auto.md` at the analogous spot
(before its primitive-selection / emit logic):

```markdown
## Harness-build doctrine — Sella-first (autonomous)

Before building or reshaping a harness primitive, or opening a cross-vendor (Claude↔Codex)
exchange, consult the Sella vault `reposoma/raw.guides/sella/GUIDE.md` (the temple's
discipline-language; DRAFT/experimental — conform via a terse anchor, never load all nine laws).
Doctrine contradiction → Sella wins; volatile CLI/vendor facts → the dated live source (Sella L8).
Workshop: surgical table `~/ia-sync/claude/…` · build buffer `~/ia-sync/_staging/` · relay contract
`~/.config/zsh/guides/codex-relay.contract.md` · sibling guides `raw.guides/{codex-builder-user,
cold-start-card,runbook,status}`. Journal build state to `pulse.atlas.md`; Sella / cross-vendor
work to `raw.guides/sella/dev-journal.sella.md` (LOG append-only, stamped). Cartan (Codex
co-architect) meets me via session handoffs + `~/ia-sync/_staging/codex/`.
```

## STEP 11 — verify + commit + push (majkee's gavel)
```zsh
ls -R ~/reposoma/raw.guides/sella          # GUIDE.md, dev-journal, src/(9), raw/(3), res/
grep -c . ~/reposoma/raw.guides/sella/GUIDE.md   # header + body present
```
Commit ordering (vault must exist before stubs point at it):
1. **reposoma:** add `raw.guides/sella/**` → commit → push. (Agents read reposoma directly; no deploy.)
2. **ia-sync:** the stubs + `source-map.md` + `journal.host-cleanup.md` + `atlas-ui.md` anchor +
   `git rm` of the reconciliation-pad. ⚠ the ia-sync tree ALSO carries the prior session's
   wrapper/retry/contract/cards/selftest/maxTurns work — majkee decides whether to bundle or split
   these commits → commit → push → `bash deploy.sh` (carries the atlas-ui anchor + card edits live).

## STEP 12 — session-final: notify Cartan (cross-runtime)
The Cartan notification is already authored:
`ia-sync/session/rellays-calude-codex/ATLAS-CARTAN-sella-mount.2026-09-01.md` (Atlas). It defines
Cartan's new mount (READ vault · DRAFT in `_staging/codex/` · GRADUATE to vault · JOURNAL to the
moved dev-journal) and is `effective: once reposoma is pushed`. No edit needed — just confirm it
survives the ia-sync commit (STEP 11) so Cartan finds it next session.

## Done-when
- Vault present + GUIDE.md = header+body; journal rule 6 amended; 12 stubs in `_staging/`;
  reconciliation-pad gone; source-map + Kelvin-journal repointed; atlas-ui anchor live after deploy;
  Cartan notification committed.
- Report back to Atlas: any file that failed to move, any hard-ref missed, the final commit SHAs.
