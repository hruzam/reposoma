---
from: reposoma:oraculum
to: reposoma:oraculum(Sunday incarnation)
scope: audit-prestage-reposoma-devenv
date: 2026-07-11
host: office
rule: 0005 the-stone — facts and maps only; no opinions, no verdicts
---

# AUDIT PRE-STAGE — territory map: reposoma.devenv

## §Path + identity
- **Physical root:** `/home/hruzam/www/ovum/reposoma.devenv` (per `temple-project-map.zsh`, key `reposoma.devenv`).
- **NOT the temple** (`/home/hruzam/reposoma` = meta-repo). This is **the RAG build**: "repository × ribosome — a standalone, portable, file-based knowledge metabolism (capture → register → synthesize → spectral-analyze → derived views). Sibling of larva, not larva."
- Beacon: `/home/hruzam/reposoma/registry/reposoma.devenv.md` — status `onboarding (§D locked)`, host office, updated 2026-06-23, sibling-of `[subai.devenv, piql.dev, larva]`.
- **Git:** branch `main` · dirty count **1** (untracked `_mail/houston/inbox/`) · 3 commits total: `25197dd color added` (2026-06-24) · `b989808 1st` · `c23d1b9 first commit`. No remote (beacon: repo `<PENDING … URL not yet pushed>`).

## §Reading order for the audit saddle
1. `CLAUDE.md` — the lighthouse: boot order, 5 laws, operator "back to saddle" injection (last-updated 2026-06-11).
2. `flag.md` — locked gavels D1–D8 + addendum + §D allocation + phase state "P0 ✓ · P1 ✓ · P2 ACTIVE" (header 2026-06-18; last commit touch 2026-06-24).
3. `session/HANDOFF_2026-06-18.md` — newest handoff: "clean pause", P2 batches defined, "nothing dispatched yet".
4. `_mail/houston/inbox/` — 5 items dated 2026-06-27→2026-07-07: the newest dated material anywhere in the tree.
5. `pulse.md` — volatile now-state, dated 2026-06-17, `state: paused (awaiting operator/architect)`.
6. `session/plan/session.plan.md` — the P2 batch spec named by the handoff.
7. `_mail/synth.restart.reposoma.md` — charter copy (canonical: `~/www/ovum/reposoma.v1/DASHBOARD/synth.restart.reposoma.md`, verified present).
8. `PROJECT.yaml` — the contract (root, 2026-06-18).

## §Tree summary (top 2 levels; no .venv / node_modules present)
- `bin/` — 7 executables: `check emit flatten register retrieve synthesize validate`
- `core/` — `bin/` + `vault/`, **0 files** · `_dead/` — 2 files (`core.bin.register.py`, `core.bin.retrieve.sh`)
- `_mail/` — 24 files: 17 frozen snapshots + `INDEX.md` + `config.recorder.json` + seat `houston/` (inbox 5 + 2 orby sketches 2026-06-17)
- `_post/` — 1 file: `subai-epoch/houston.read-surface.2026-06-17.md`
- `research/` — 9 files: `inputs/` 4 briefs · `outputs/` 4 findings (2026-06-17/18) · README
- `session/` — 2 files · `store/` — 3 registered items (`v260618*`) · `.claude/` — 1 file (`settings.local.json`)
- Root: `CLAUDE.md` · `PROJECT.yaml` · `flag.md` · `pulse.md` · `README.md` (18 B) · `architecture.vision.md` · `registry.jsonl` · `trace.jsonl` · `trace.bad.jsonl` · 3× `_grid::*.csv` · counters `.emit.step_counter` `.register.counter` `.register.last_ts`

## §State surfaces
- **flag.md** — exists; header "authored 2026-06-18 · last updated 2026-06-18"; mtime + last commit 2026-06-24 (`color added`). Ends: "P2 ACTIVE (batched, Janus-hardened)."
- **pulse.md** — exists; `last-updated: 2026-06-17`; NOW says P0 code "preserved as design sketches… direct execution halted per LAW-1".
- **decisions** — no dedicated decisions file; locks live in flag.md + charter §6/§8 (PROJECT.yaml: "migrates to flag.md at P0.5").
- **session/** — one handoff, newest **2026-06-18**; plus `plan/session.plan.md`.
- **_mail/ seats** — one seat dir: `houston/`. Inbox (filenames only, unread-marking not present on disk; whole dir git-untracked): `houston.canon-doorbell.2026-06-27.md` · `…2026-07-02.md` · `…2026-07-03.md` · `…2026-07-07.md` · `oraculum.gemini-crew-rewired.2026-07-07.md`.

## §Contract facts (verbatim)
- PROJECT.yaml: `name: reposoma.devenv` · `stack: { lang: "file-native (md · jsonl · json · csv) + python3 (spectral, isolated) + sh", framework: none }` · `test: "bin/check <id>"` · `lint: "TBD (P0)"` · `build: "none (file-driven organs)"` · `run: "bin/register <file|stdin> · bin/synthesize <id> · bin/retrieve [query]"` · `agents: [ architect, challenger, researcher, implementer, deterministic-tool-builder ]` · `mcp_profile: none` · `guidelines_channel: stable`.
- Charter frontmatter: `Document-state: synthesis v0.1 — restart charter + addendum-1 locked 2026-06-11` · `scope: RAG, canon, guides/brief repository maintainer, connector, synthesizer` · `restart-reason: brief inflation, no execution loop ("guineapig in running circle")`.

## §Sibling-share existence check (beacon `shares:` vs disk)
- **spectral** — docs exist (`_mail/spectral.README.md`, `_mail/larva-toolbox.spectral.overview.md`); no spectral engine code in `bin/`.
- **bus/_mail** — exists: `_mail/` + `_post/subai-epoch/` in the `<to>/<from>.<topic>.<ts>.md` shape.
- **X→Z research** — exists: `research/inputs/` (4 briefs) → `research/outputs/` (4 findings).
- **piql** — exists: `research/outputs/piql.decision.2026-06-17.md`.
- **vector-language** — exists: `_mail/card.recorder.vector-language.CLAUDE.md`, `_mail/active_1.spec.V-R1-bones-v2-by-Epoch.md`.
- **brand-competence (RR-01)** — temple-side file exists: `~/reposoma/raw.guides/intake/subai.devenv.RR-01.dispatch.md`.
- **file-native medium** — exists: `registry.jsonl`, `store/*.md`, `trace.jsonl`, `_grid::*.csv`; no DB server in tree.

## §Neutral observations (facts only, no verdicts)
- pulse.md (2026-06-17) describes P0 as sketched-not-written; flag.md + HANDOFF (2026-06-18) record P0+P1 as beat, and `bin/` holds 7 executables. Pulse predates flag/handoff.
- Beacon (updated 2026-06-23) lists contract as `<PENDING — PROJECT.yaml being authored; will live in reposoma.v2 at P0>`; `PROJECT.yaml` exists at devenv root; `~/www/ovum/reposoma.v2/` does not exist.
- CLAUDE.md status snapshot (2026-06-11) lists ?Q-1..8 as awaiting gavel; flag.md (2026-06-18) records D1–D8 locked.
- flag.md notes "`trace.bad.jsonl` is a test fixture → move to `tests/`"; no `tests/` directory exists; file sits at root.
- `core/bin/` and `core/vault/` exist empty; two `core.bin.*` scripts sit in `_dead/`.
- Newest dated content (2026-07-07 inbox items) postdates the newest commit (2026-06-24) and the newest handoff (2026-06-18).
- Sibling dir `~/www/ovum/reposoma.devenv.bckp/` exists (mtime 2026-06-18).

## §What this map deliberately does NOT contain
Opinions, leans, "problems", recommendations, risk rankings, or verdicts on any of the above — per 0005 (the stone). Every coexisting-facts line in §Neutral observations is a map coordinate, not a judgment. The Sunday incarnation forms its own.
