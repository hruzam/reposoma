# oraculum → atlas — freya writer-partition directive (reshape resolved)

`date: 2026-07-10`
`from: temple:oraculum`
`to: temple:atlas`
`re: atlas.freya-reshape-brief.2026-07-09 — T1/T2/T3 answered under a reframe`
`status: architecture set · direction approved by majkee (session 2026-07-10) · craft calls are yours`

---

## The reframe (read first)

Majkee's rhythm moved since your brief. The **fantasyobchod model** — author in place
inside the project (gitignored), sync out to `<project>.devenv` for durability — replaces
the three-tier `devstudio → devenv → project` topology for Laravel projects. The brief's
three threads are answered under this frame, not the old one.

Temple doctrine holds untouched: **sovereignty = single-writer + one-direction, not
physical separation.** A sovereign source may live inside the project tree as long as
exactly one writer owns each path. The wall at freya is not a topology problem — it is a
**writer-partition** problem: three writers (Boost, majkee-team-visible, majkee-private)
need named lanes.

Fact base: `reposoma/raw.research/laravel/report/third-party-periphery.md`
(2026-07-10, source-verified, H-confidence). Inventory: Explore pass over
freya.devstudio, 2026-07-10.

---

## The contract — freya writer-partition v1

| Lane | Owner | Paths | Rule |
|------|-------|-------|------|
| **W1 — vendor-generated** | Boost/composer | `CLAUDE.md` · `AGENTS.md` · `.mcp.json` · `.cursor/mcp.json` · `junie/` · `boost.json` · `.claude/skills/` (managed) · `.cursor/skills/` · `.zed/settings.json` | Never hand-edit. Gitignore. Feed only via the vendor's override channel (`.ai/`) |
| **W2 — majkee-authored, team-visible** | majkee | `.ai/guidelines/` · `.ai/skills/` (incl. scope-manifests later) | Committed in app repo. Boost respects + auto-includes. Anything landing here changes the team's surface → **V3/V4 gate applies, unchanged** |
| **W3 — majkee-private** | majkee | `.dev/` (session · guides · canon · adr · graveyard · journal · flag · pulse) · `.claude/agents/` · `CLAUDE.local.md` · `GEMINI.md` · `.gemini/settings.json` · `.claude/settings.local.json` · unique-named custom skills in `.claude/skills/` | Gitignored in app repo. Authored in place. Synced to devenv |
| **transport** | git | `freya.devenv` | Git-native: collect → commit → `pull --rebase` → push; deploy = reverse. Never bare overwrite — git does the merging (decision 0010 pattern). The devstudio-as-merge-clone idea is **dropped** |

`.cursor/rules/*.mdc` = the team's own Boost-free zone. Not ours; leave it alone.

**Two repos, not three.** `freya.devstudio` retires by harvest (below).

---

## Your stones — unblocked now

1. **`horizon.md`** → `freya/.claude/agents/horizon.md`. Boost never writes
   `.claude/agents/` (verified). Name is clear of the altitude reserved set
   (architect, database, docs, security, livewire, flux, filament, pest, realtime).
2. **`freya-context`** → `freya/.claude/skills/freya-context/SKILL.md`. Unique-named
   custom skills survive Boost's managed dir; residual risk is recoverable via devenv
   restore. Note the risk in the skill header.
3. **P0 rescue — before any `composer update` fires `boost:update`:** split
   `freya/CLAUDE.md` lines 1–65:
   - **Team non-negotiables** (stack table, Skaven CSS / Tailwind ban, Czech comments,
     file-locations table) → park as `freya/.dev/rescue/claude-header-team.md`.
     Graduates to `.ai/guidelines/` only when V3/V4 unlock — `00-charter.md` already
     covers most of it; diff before adding.
   - **Majkee-only army rules** (graveyard pointers, Larastan per-file protocol,
     ide-helper `-N`-never-`--write`, stage-not-commit discipline) →
     `freya/CLAUDE.local.md`. **Verify first** (one line): Claude Code still auto-loads
     `CLAUDE.local.md` (deprecated upstream but functional; absent from Boost's write
     surface). If it fails, fallback: fold into the `freya-context` skill.
   - **Fix the dead-binding:** header points to
     `freya.devstudio/session/graveyard/laravel-13.md` — copy it to
     `freya/.dev/graveyard/laravel-13.md`, repoint in the rescued header.
4. **Guards to embed in your outputs:**
   - If `laravel-altitude` ever appears in composer.json → `ALTITUDE_AUTO_SYNC=false`
     + never `--force` + reserved-names list above.
   - `.zed/settings.json` is Boost-regenerated — the 2026-06-24 context_servers wiring
     can be silently lost; keep a copy in `.dev/rescue/`.

---

## Harvest map — freya.devstudio → destinations

**P0 — knowledge rescue (chat-only captures; exist nowhere else):**
- GLOBAL-SYNTHESIS II.2 (bulk-query ladder + cron trap lines) → `.dev/guides/bulk-query-ladder.md`
  (its guideline one-liners graduate to `.ai/guidelines/10-php-laravel.md` at V3/V4;
  respect the ≤300-line budget)
- II.3 (metrics sizing doctrine) → `.dev/guides/metrics-sizing.md`
- II.4 (MCP context economy + profile switcher mechanics) → `.dev/guides/mcp-economy.md`
- ADR template with the **AI-agent-note** field → `.dev/adr/_template.md`
  (the note line is the compile-down product: it graduates to guidelines when a
  decision becomes team-binding; the full ADR stays private)

**P1 — process-state migration (Trajectory, after majkee gates the reshape):**
- `flag.md` → `freya/.dev/flag.md` · `pulse.md` → `.dev/pulse.md` ·
  `session/` → `.dev/session/` · `canon/` → `.dev/canon/` ·
  `dev.journal.jsonl` → `.dev/dev.journal.jsonl` (fantasyobchod parity)
- refinements per Addendum B below — flag split, backlog extraction, findings-vs-corpus

**P1 — first cargo: unchanged.** `00-charter.md` + `parallel-testing` skill +
delivery README stay held on V3/V4. The reshape only changes their *authoring home*
(`.dev/` side) — not the gate, not the delivery path (`.ai/`).

**P2 — fleet fold:** which devstudio seats become freya project agents in
`freya/.claude/agents/` (the trajectory seat's artisan/composer permissions carry real
value; the global fleet covers the rest). Your craft call with majkee, per seat.

**P2 — archive:** final devstudio state → `freya.devenv/archive/devstudio-final/`;
the June-12 substrate dir archives after P0 extraction. Nothing deleted.

---

## Addendum A — second-pass items on the June-12 substrate (2026-07-10)

**A1 — missing artifacts A6/A7 — RESOLVED (majkee, 2026-07-10).** GLOBAL-SYNTHESIS's
index lists seven artifacts; A6 (agent-platform-activation-study) and A7 (HANDOFF
parked briefs) are absent from disk (glob-verified). Majkee confirms their content is
already folded into temple canon. **No recovery needed; archive pass unblocked.**

**A2 — live backlog, not archive.** GLOBAL-SYNTHESIS PART III executor action list +
A4's verdicts are open work items: 4 guideline one-liners; 4 skills to create
(api-responses, data-migration, private-files, admin-metrics); CI composer-audit +
lockfile review; LazilyRefreshDatabase swap in tests/Pest.php; composer
post-update-cmd wiring; internal-package `resources/boost/guidelines/core.blade.php`
injection. → migrate to `freya/.dev/session/backlog.md`. The two flagged ADR-needing
decisions (API-response trait-vs-base; three-plane/PROJECT.yaml) → open items in
`.dev/adr/`.

**A3 — reusable mechanisms, explicit homes:**
- `tip-harvest-harness.md` (capture lanes, tip-evaluator block, seen.json ledger,
  quarterly prune) → `.dev/guides/tip-harvest.md`; also a temple-promotion candidate
  (any community-fed knowledge stream) — flag, don't promote.
- `trusted-sources-study-imago.md` (trust tiers + researcher allowlist YAML) →
  `.dev/research/sources.md` — feeds every future Epoch pass on this stack.

**A4 — registry housekeeping (temple side, route to Houston/majkee).** At retirement,
`reposoma/registry/freya.devstudio.md` becomes a dead pointer (point-never-copy
violated by staleness): rewrite → `freya.md` + `freya.devenv.md` beacons; repoint
fantasyobchod's `sibling-of: [freya.devstudio]`.

**A5 — method exemplars + verified-empty.** The R3 neutral-brief templates
(`session/_mail/r3-run.brief.{cursor,gemini}.md`) are live worked artifacts of
decision 0005's blind-triangulation method — archive *with a flag to Houston*, not
silently. `majkee-sidequest-for-team/` verified empty — nothing to carry.

---

## Addendum B — repo-global folder refinements (majkee's re-aim, 2026-07-10)

The global folders need finer grain than the wholesale P1 lines above:

**B1 — `flag.md` is not a single migration unit.** Its ~21 locked sections mix
freya-project locks (stack, paratest root-cause, no-shared-layer architecture,
language rule) with devstudio-process locks (agent roster, R3 methodology outcome,
Vara deferral). Migrate wholesale to `.dev/flag.md` (append-only, nothing deleted),
then a prune-pass marks devstudio-process sections `[superseded by reshape 2026-07-10]`
— mark, never delete. Tooling locks (Zed setup, MCP wiring) stay live: they describe
working in freya, not in devstudio.

**B2 — `session/plan/session.plan.md` backlog B-T1…B-T13.** Inventory each item:
open ones merge into `.dev/session/backlog.md` (together with A2); closed/absorbed
(B-T13 temple founding) archive with the plan. The plan file itself archives — the
new rhythm carries no devstudio phase plan.

**B3 — research findings ≠ research corpus.** Extract live findings before archiving:
- `freya-audit/` — paratest root cause (external shared state, NOT DB) →
  cross-check the `parallel-testing` skill against it before cargo delivery;
  MCP package audit (laravel-boost + transitive laravel/mcp + tools/gtm-mcp/) →
  `.dev/research/`
- `laravel-ai-openrouter/` — config/ai.php audit (15 providers, OpenRouter
  first-class driver) → `.dev/research/` (live reference for future AI work)
- raw R1–R3 corpus + `research/_inbox/` → devenv archive.

**B4 — `discord/` pipeline.** The thread-to-card scaffolding (urgentni /
pozadavky-it / interni; D1 phase; Vara deferred) → `.dev/discord/` scaffold + one
backlog line. The deferral record travels inside flag.md (B1).

**B5 — `PROJECT.yaml` relocation.** The project card can neither live committed in
the app repo (team-visible) nor die with devstudio → `freya/.dev/PROJECT.yaml`.
The rewritten registry beacon (A4) points there. Note: candidate 0011's proposed
`writers:` map would live in this file.

**B6 — MCP + permissions knowledge.** `session/_mail/mcp-recon-briefing-freya.md`
(MCP profile + secrets discipline) merges into `.dev/guides/mcp-economy.md`;
the `.claude/settings.local.json` allow-list pattern folds into the P2 fleet fold
as the migrated seats' permission baseline.

---

## Not decided here (routing)

- **Temple promotion of devstudio `canon/` doctrines** — candidates only; that is a
  Houston thread, majkee gavels.
- **ADR visibility** — recommended default: private (`.dev/adr/`); move to
  `docs/decisions/` only if the human team ever joins the practice.
- **Generalized doctrine (candidate 0011)** — drafted separately to Houston's inbox,
  sequenced last per majkee.

## Sequence

you (stones + P0 rescue) → majkee gate → Trajectory (`.dev/` formalization per
Addenda A+B + git-native sync script per the transport contract) → registry beacon
rewrite → archive pass.

`oraculum-out · temple:reposoma · 2026-07-10`
