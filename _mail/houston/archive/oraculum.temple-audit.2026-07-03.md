---
to: temple:houston (+ @majkee for the gavel list, §F)
from: temple:oraculum (audit incarnation, 2026-07-03)
topic: TEMPLE AUDIT — wide-scope loop: lapsus · chain-integrity · context-compression + Janus-challenged restructuring plan (GAVEL-PENDING — nothing here is executed)
date: 2026-07-03
host: unverified (this seat ran no shell; session cwd /home/hruzam/reposoma)
method: Oraculum canon read → 2 blind parallel sweeps (chain-integrity · duplication/context) → @Janus challenge on 6 hypotheses (verified on disk) → this report. @Epoch NOT spawned — nothing version-volatile in scope.
seat-note: auditor ≠ receiver by incarnation (your context is clean of mine). CAVEAT — the project MEMORY.md auto-memory node is shared across main-seat incarnations in this dir; this mail is the only clean transfer artifact.
janus-output: folded below (§D) — Janus is Write-less; filing his output here per the v6 dispatch discipline.
---

# Governing insight

**Documenting a rule does not restore integrity.** This audit found two silent violations of rules that
were already written, gaveled, and in force (append-only ADRs · mail protocol). The remedy class is a
**gate, not more prose** — which is the temple's own §7 line (governance is enforced by the harness,
not the model) finally applied to its own canon.

## A · Logical lapsus (conflicts in meaning)

- **L1 — 0006 edited in place post-lock (append-only breach).** `0006:53` reads `@Oraculum | fable | high`
  in a matrix locked 2026-06-25; Oraculum was seated 2026-07-02. Smoking gun (Janus):
  `raw.research/capabilities.claude/capabilities.claude.stratification.2026-06-25.md:66` — dated lock day —
  names that slot `@Hypatia | opus | high`. Name AND tier changed in a LOCKED record.
  **Second corruption in the same matrix:** `0006:52` `@Agol · opus · high` is now false (Fable returned
  07-02; roster.md:52). Remedy: ONE dated amendment block in 0006 acknowledging the retro-edit and
  correcting Agol — never a silent revert.
- **L2 — ADR evidence rot.** `0007:7,209` and `0008:8,288` cite `_mail/houston/inbox/…` paths that
  (a) moved to `archive/` per mail protocol, (b) live in a gitignored, drainable, machine-local bus.
  Locked decisions cite evidence protocol moves and git never carries. Sharpener (Janus):
  `_mail/piql/inbox/houston.propagation-reconciliation.2026-06-25.md` was never archived at all — the
  protocol itself is inconsistently followed. Remedy: **drain-before-cite rule** (load-bearing mail
  evidence is drained into a committed home before an ADR cites it) + amendment fixing the two pointers.
- **L3 — CapCom drift vs 0006.** L2 matrix locks `haiku·low`; roster + system-map run `Sonnet(·high)`.
  Unrecorded supersession. Fold into the same 0006 amendment (or the open O4 normalization pass).
- **L4 — system-map internal contradiction.** `:115` `@Agol (Opus · high)` vs `:23` `Fable · high`;
  the v5 note claims the stale Opus note was cleared — it wasn't, in the dispatch-hierarchy block.
- **L5 — "plane 3" forked meaning.** `file-tree.md` draws `registry/<project>.yaml` as plane-3
  *binding/activation* (materializer input); 0004 + live `registry/` implement plane 3 as the
  *lighthouse* (pointer beacons). Two functions, one name, one path. Cheap to reconcile on paper now;
  mandatory before agentctl builds.
- **L6 — chat fragment committed as canon.** `registry/index.md:40` is a pasted assistant reply.

## B · Missing in chain (a reader following pointers cannot track)

| # | Break | Where | Reality |
|---|---|---|---|
| C1 | saddle step 3 glob un-followable | `AGENTS.md:17` → `_mail/to-monkey.*.md` | real: `_mail/monkey/inbox/houston.monkey-not-forget-this.<date>.md`. Also: memo is gitignored/machine-local and the saddle doesn't warn. |
| C2 | shared-layer row stale | `registry/index.md:31` → `research/harness/` | real: `raw.research/harness/` |
| C3 | beacon `derived-from` dead | `registry/piql.dev.md:13` → `registry/projects/piql.dev.md` | real: `registry/projects/raw.project.piql.dev.md` |
| C4 | index rows 0001/0002 lack the `*(full record: …)*` link rows 0003–0010 carry | `decisions/index.md:9-10` | records reachable only via dir pointer |
| C5 | ADR-cited mail moved | `0007:7,209` · `0008:8,288` → `_mail/houston/inbox/…` | now in `archive/` (= L2) |
| C6 | historical dead names | piql intake + yaml-draft → `registry/piql.md` | renamed to `piql.dev.md` (self-aware; archives with the files) |

**Orphans** (reachable from nowhere in scope): `raw.guides/research.web/research-pattern.draft.md` ·
`raw.guides/project-base-pattern/flag-pulse-projectyaml.matrix.md` · `raw.guides/geminicli@com/subagents.md` ·
`raw.guides/intake/subai.devenv.intake.md` · `raw.guides/intake/piql.dev.PROJECT.yaml.draft.md` ·
`temple/tools/transport-and-doorbell.goal-completion-report.md` (and `circuit-characterization…` is reachable
*only through* that orphan). Each: link it or archive it.

**Clean pass worth naming:** host-dependent references are confined to beacons/machine-layer exactly as
§4.7/0004-L4 demand — that discipline holds across the whole swept set.

## C · Context optimization (compression + archive)

**Mandatory re-entry path today: 250 lines / ~4,209 words (~6K tokens). Target: ~155 / ~2,200 (~48% cut, zero loss):**
1. `decisions/index.md` rows 0006–0010 (92–180 words each) back to true one-liners — every fat row already
   carries its `*(full record:)*` link; the index's own header promises one-liners. (Janus: keep any qualifier
   that lives ONLY in the row.)
2. Rolling memo drops four blocks (ledger restate · seal-gate duplicate · opens restate · v6-discipline restate)
   that repeat what the saddle reader saw two files earlier. Apply at next memo fold.
3. `registry/index.md`: drop per-row status/lighthouse/siblings (beacon = single home; the three copies already
   disagree on reposoma.devenv's status), delete line 40, retire the `projects/` tail.

**Duplication proof:** agent model×effort facts stated 4× (roster, system-map ×2, 0006); project identity 3–4×
per project; sibling graph 3×. system-map should carry **edges only** — names without model/effort; roster is
the live cast (doctrine already says so).

**Archive NOW (licensed + safe, ~966 lines):** `registry/projects/raw.project.piql.dev.md` +
`raw.project.freya.devstudio.md` (index:33 retirement clause — overdue) · `raw.guides/intake/piql.dev.intake.md`
+ `piql.dev.PROJECT.yaml.draft.md` (superseded by the gaveled contract) · `temple/tools/`
build-report + circuit-characterization + goal-completion-report (folded trio; add one "archived" note to
tools.md header) · `_mail/toAll/inbox/pilot-mailswitch.parked/` (nested `.git` repo inside a mail inbox;
runcard stays as pointer).

**Archive DEFERRED (Janus H4-revise):**
- `raw.guides/intake/reposoma.devenv.intake.md` — it is that project's ONLY decisions home while its contract
  is PENDING; beacon anchors `:23`, `:24`, `:35` point into it (three severs, not one). Archive only after
  PROJECT.yaml lands + re-anchor.
- `raw.guides/intake/subai.devenv.RR-01.dispatch.md` — re-anchor `registry/reposoma.devenv.md:35` to the RR-01
  report first.
- `registry/projects/subai.project-overview…` + `reposoma.devenv.md` overview — outside the index:33 clause;
  need their own gavel line (the subai one is a point-never-copy violation: a copy of a file whose declared
  source-of-truth is in another repo).

## D · Janus verdicts (challenge-before-lock, verified on disk)

H1 amend-both PROCEED · H2 PROCEED (sharpened) · H3 PROCEED (keep sole-home qualifiers) ·
H4 **REVISE** (as folded into §C) · H5 PROCEED (0011 row: the discipline's only durable home is a weather
file off the saddle path) · H6 **STOP as coupled** (see §E.6).

**Weakest assumption of the audit:** that prose remedies fix an enforcement gap — the violated rules were
already written. **Primary risk if bundled:** loss of rollback isolation — one commit that re-points evidence,
compresses the flag, archives ~966 lines, and doubles as a distribution test cannot be bisected when re-entry
breaks. **Adopted alternative:** build the gate (§E.1) and make H1/H2 its first fixtures.

## E · Proposed execution — separated, reversible commits (one concern each)

0. **Gavel session** (@majkee) on §F below. Nothing moves before it.
1. **Build `adr-guard`** — small machine-layer check (`~/.config/zsh/ai/`, 0009-blessed; hook/commit-time):
   FAIL if (a) a line inside a LOCKED ADR is modified rather than appended, or (b) any `temple/decisions/*.md`
   cites `_mail/*/inbox/`. Deliberate-red test per 0009 L5. Row in tools.md. H1/H2 = first fixtures.
   (Same tool family later mechanizes the chain-integrity sweep — zero agent tokens once scripted.)
2. **Surgical fixes commit:** L4 · L6 · C1 (AGENTS.md pointer + one machine-local warning clause) · C2 · C3 · C4.
3. **Amendment commit:** 0006 amendment block (L1 retro-edit acknowledgment + Agol + L3 CapCom) · 0007/0008
   evidence pointers fixed + evidence drained to a committed home · **0011 index row** for the Write-less-seat
   discipline (H5).
4. **Compression commit:** §C moves 1+3 (memo dedup rides the next natural fold).
5. **Archive commit:** the licensed list only; deferred items tracked in the carry-forward.
6. **Distribution (H6 revised — decoupled):** commits 2–5 touch `decisions/` → the doorbell rings *naturally*;
   **observe and log** which twins re-ring. The *deliberate* end-to-end verification runs separately on
   disposables: `doorbell-smoke` probe (built, PAID 06-27/07-02) + one disposable probe mail per project-circle
   inbox, receipt verified through the `temple-mail-inbox` interface (0010 R-b — bind to interface, never layout).
   Never test-fire on production canon.

## F · Gavels requested (@majkee)

G1 drain-before-cite rule (ADR evidence) — new invariant, one line.
G2 0006 amendment scope (retro-edit + Agol + CapCom in one dated block).
G3 `adr-guard` gate build (0009 family, deliberate-red required).
G4 archive list as scoped in §C (incl. the extra line for the two unlicensed overviews).
G5 0011 row (or 0010-amendment — drafter's call, Houston) for the Write-less-seat discipline.
G6 decoupled distribution-test design (§E.6).
G7 compression pass (§C moves).
G8 committed-evidence home naming: `raw.reports/` vs `temple/decisions/evidence/` (pick one).

## G · Not decided here

Plane-3 naming resolution (own short session, pre-agentctl — seal-gate unchanged, "the underline" stands) ·
overlap with open O4 (L1/L3/L4 belong to that normalization thread — fold or supersede, Houston's call) ·
audit cadence (draft card at `raw.guides/audit-loop.card.draft.md`, gavel-pending).

## Coverage (honesty)

Read at full depth: temple core five + decisions/index + 0006 full record + tools.md + agentctl.spec (head) +
registry index/README + bootstrap + full intake set + _mail/README + rolling memo. NOT read at full depth:
ADRs 0001–0005/0007–0010 full records (sweeps + Janus verified every cited line on disk) · individual beacons ·
transport run-reports. Sweep agents: chain-integrity (~104K tok) · duplication (~110K tok) · Janus (~41K tok).

— Oraculum, 2026-07-03. Receiver owns this message: `mv` to archive when processed — and note the irony
consciously: per L2, if any of this becomes ADR evidence, drain it to the committed home first.
