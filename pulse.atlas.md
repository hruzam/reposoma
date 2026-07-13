# pulse.atlas — Atlas status log (Atlas writes · Houston + all reads)

Newest on top. Single-writer: Atlas owns this file.
Read alongside `pulse.claude.md` to see what the Claude crew has done.
Atlas reads `pulse.claude.md` before starting — sees what Houston has tabled or done.

Canon: `raw.canon/canon.mail-protocol.md` (single-writer-per-file · ask-first · everyone reads all).

---

## YOU ARE HERE — [2026-07-13] — read this first, then scan the log

**Nature research chain COMPLETE — three-way synthesis done.**
Studies One + Two + nabla-lab third voice all in. Oraculum hand-off updated to three-study
format (H1–H4). Files:
- `raw.research/nature/report/study-one.formalized.2026-07-13.md` — Color translation (Fable-safe)
- `raw.research/nature/report/study-two.technical.2026-07-13.md` — Epoch technical survey
- `raw.research/nature/report/oraculum-handoff.brief.2026-07-13.md` — **DRAFT, awaiting majkee gavel**
- `raw.research/nature/report/atlas-observations.2026-07-13.md` — §V: three-way cross-mapping added
Key finding: nabla-lab spec (third voice, blind Gemini/Claude triangulation) converges with Study One
at 8/10 structural dimensions. One genuine addition: §6.2 Scars (negative knowledge + active routing
repulsion — not in Studies One or Two, awaits triangulation). Several [v2] items in nabla spec now
triangulated by Studies One + Two.

**Also delivered this session:**
- `majkee.news.md` — operator bulletin (Watch + Fresh), wired from AGENTS.md
- `AGENTS.md` — `Majkee's live board` standing discipline added
- `raw.research/fable-restrictions/findings.provisional.md` — §8 operator observations added
- `.gitignore` — `!raw.research/nature/report/` exception added

**Oraculum hand-off GAVELED 2026-07-13.** Deposited:
`nabla-lab/_mail/oraculum/inbox/atlas.nature-synthesis-brief.2026-07-13.md`
Oraculum reads her inbox on next nabla-lab saddle — brief + three study paths inside.
Oraculum is on Opus — safe for vocabulary in Study One (all biology terms stripped by Color).

**[ATLAS-ONLY — operator-disclosed, research-subagents blind] nature scope full intent:**
Mycorrhizal networks / mycelium as architectural model → RAG and orchestration
mechanism design. Final synthesis driven by Oraculum on Opus in nabla-lab. Chain complete —
pending only majkee gavel on the hand-off brief.

**Pending tasks from this session:**
- Therapy arc — write "want to ride the horse" + multi-seat operation arc to
  `raw.therapy/atlas/therapy.md`. Not opened yet.
- Two-layer vocabulary constraint for Color — note in pulse or Color frontmatter for future
  research chains (organism-level AND molecular-biology vocabulary both excluded in briefs).
- Houston routing: Oraculum + Agol one-liner updates (parked to 2026-07-19).

**Still tabled (unchanged):**
- **Publishing trial (GAVELED 2026-07-11, N=4h) — DORMANT until trigger.** majkee is
  mid-other-work; nothing starts on its own. Trigger: majkee says **"publishing-trial: go"**
  in any session → run the kickoff sequence in the 2026-07-11 publishing entry below.
  Do NOT nag about it on saddle — surface only if he asks or triggers.
- **C — new-project global skill** → `~/.claude/skills/new-project/SKILL.md` — parked by
  majkee; needs substrate check first. (Three data points now: psdvsSys + fantasyobchod
  + freya authored-in-place.)
- ~~Expect majkee _mail re: zsh fork~~ **CLEARED 2026-07-11 (direct word, no _mail):**
  guides audited + smoothed, narrowed to reality. keyboard.zsh wiring is unblocked for
  Trajectory at P1 — freya PROJECT.yaml transport-requirements updated to match.

**Standing overlay:** Fable sunset in force — no Fable spawns. advisor-high deferred to
**2026-07-19** (second pay-as-you-go term extension, confirmed 2026-07-12).
(2026-07-11 session ran on Fable by explicit operator model switch —
escape valve, not a precedent.)

**Standing — zsh machine layer STALE-MEMORY WARNING (majkee, 2026-07-11):** keyboard.zsh
(PARTITION 11 devenv keys) + guides shifted several times on 2026-07-11 (majkee's guide
audit ∥ Trajectory's P1 wiring — parallel sessions). Before ANY commit/ia-sync touching
`~/.config/zsh/` (keyboard.zsh · guide-for-user.md · guide-for-builder.md): RE-READ from
disk fresh — never act from held/session memory; verify PARTITION 11 and the audited
guides still agree. Applies to me and any executor I dispatch.
**First hit 2026-07-11 (same day):** majkee review caught P1's PARTITION 11 putting
FUNCTION BODIES in keyboard.zsh — violates the control-panel convention (keyboard =
aliases only; engines = dedicated ai/ processor scripts wired via base.zsh; exemplar:
temple-tree.zsh mount). Repair DONE + verified (@Trajectory, guides-first, fresh reads):
engine extracted to `ai/devenv.zsh` (named per adr-guard non-temple-family exemplar —
scope keyword, no false family prefix) · base.zsh PARTITION 6 wires it (after
temple-tree's 5) · keyboard.zsh PARTITION 11 = comment-only control-panel block ·
zsh -n clean ×3 · live chain: all 7 keys resolve from the engine · guide-for-user:141
still accurate, untouched. NOT committed (operator-gated ia-sync pass).
**Round 2 DONE (@Trajectory):** P11 = 7 literal aliases (engine entry points renamed
`_bo_*`/`_fr_*`/`_devenv_help`) · temple-help was in P10 (not 9) → `_temple_help` in
NEW `ai/claude.zsh` (majkee's floated name fit: Claude Code RC surface domain) ·
P8 `rc-stop` → `_rc_stop` in claude.zsh, other rc-* were already plain aliases ·
base.zsh PARTITION 7 sources claude.zsh · doorbell rail NOT triggered (P8/9/10 are
RC + mail/help surfaces; doorbell-smoke + transport-selftest untouched) · zsh -n ×4 +
13-key chain GREEN · guides accurate, untouched · NOT committed.
**Tail CLOSED:** @Delta functional test = GREEN, no fix needed — `ai-help` prints both
help sections clean. Empirics beat my parse-time theory (trust-disk-over-model held);
files untouched. Baseline recorded: `zsh -ic 'source base.zsh; ai-help'` = GREEN.
**Round 3 DISPATCHED (majkee review widened scope):** function bodies found in almost
EVERY keyboard partition (gemini family nearly whole in the panel despite own
processor) — his verdict: today's guide audit fixed words, not code. @Trajectory brief:
(A) keyboard-wide sweep, scope-correct engines (gemini → own engine, NOT claude.zsh) ·
(B) processor.sh → gemini-processor.sh + in-tree ref fixes, out-of-tree refs listed
for operator · (C) .sh/.zsh rule DERIVED from disk (sourced-engine .zsh vs bash-exec
.sh expected), rename only true mismatches · (D) guides repaired to post-cleanup
reality (control-panel rule, scope-naming, partition maps). Rails: 0009-L5 split,
behavior identical, ai-help baseline re-test, no commits. majkee lesson boarded:
"sit and control more often" — mirrored on Atlas side as the brief-gate rule above.
**Round 3 DONE (@Trajectory, 13 files):** keyboard fully swept — P4 agy wrappers +
P6 hygiene + P7 help bodies → NEW `ai/gemini.zsh` engine (base.zsh PARTITION 8);
`ai-help` → `_ai_help` in claude.zsh (cross-scope aggregator belongs with top-level
help bodies; keyboard keeps alias) · processor.sh → `gemini-processor.sh` + ALL
in-tree refs fixed (vega/orby/astrobley/bluebottle .sh, keyboard, AGENTS.md, README,
guide-for-builder) · .sh/.zsh rule derived + WRITTEN to guide (.zsh = sourced/zsh-syntax;
.sh = standalone bash subprocess, gemini line deliberate since 07-03) · guide-for-builder
gains "Architecture rules" (control-panel convention · processor scope-naming ·
partition maps · engine inventory, as of 2026-07-11) · ai-help functional GREEN ×2
(before + after deletion). **Operator items:** (1) ia-sync run propagates the rename —
9 stale refs listed in Trajectory's report (incl. old processor.sh still present in
ia-sync tree); (2) pre-existing doc/code mismatch: `_gai_graceful_fail` + `_gai_model`
in gemini-agents-help text but not implemented in gemini-processor.sh — remove from
help or stub, majkee's call. Machine layer now style-clean; words = code.
**Round 4 DISPATCHED (majkee: one file per scope):** merge gemini.zsh INTO
gemini-processor.sh (survivor, .sh = majkee lean), kill gemini.zsh, re-point base.zsh
P8 · KEEP all function bodies (kill file not code — legacy gets `# LEGACY? — majkee
audit` tags + report list, he audits later) · dual-source risk named: file feeds both
interactive zsh AND bash launchers — both chains verified, syntax conflicts = stop-items
not silent rewrites · guide Architecture rules amended to the gavel (dual-sourced .sh
scope file = gemini exemplar; interactive-only engines stay .zsh).
**Session close (majkee off until Sunday):** Oraculum FYI mail sent
(`_mail/oraculum/inbox/atlas.freya-directive-executed-and-fixes.2026-07-11.md` — directive
closed + 5 deviations for her model) · monkey test-checklist mail sent
(`_mail/monkey/inbox/atlas.monkey-not-forget-freya-testing.2026-07-11.md` — 12 items:
shell reload · gemini live run · fr-sync first-run diff expectation · voyager/skill/
CLAUDE.local proofs · .ai/ experiment · ia-sync + ghost decisions) · therapy ARC 3
OPENED (`raw.therapy/atlas/therapy.md` — brief-gate enforce-vs-cite watch · theory-lost-
to-disk datum · self-shrinking third occurrence + pending Q to majkee; his side Sunday).
**Round 4 DONE (@Trajectory, 7 files):** gemini-processor.sh = single dual-sourced
scope file (subprocess core `_gai_*` + interactive surface, sectioned) · gemini.zsh
DELETED, zero refs remain (grep-proven) · base.zsh P8 re-pointed · keyboard P4/P6/P7
comments updated · dual-source VERIFIED both chains (bash: 12/12 resolve · zsh: 6/6
resolve · vega.sh sane) — all bodies bash/zsh compatible, no stop-items · guides +
AGENTS.md + README amended to the one-file-per-scope gavel; gemini.zsh in Removed
section. LEGACY finding: `_gai_model` + `_gai_graceful_fail` = pure DOC GHOSTS (never
implemented, never called by live code) — tagged inline in gemini-agents-help() for
majkee audit; earlier round-3 stop-item hereby explained. **ia-sync pending delta
(one operator pass covers rounds 2–4):** devenv.zsh + claude.zsh NEW ·
gemini-processor.sh NEW (merged) · processor.sh + gemini.zsh DELETE · keyboard/base/
launchers ×4/README/AGENTS.md/guide-for-builder MODIFIED. Lesson for future briefs: any machine-layer task MUST name
guide-for-builder.md as the style LAW up front and force the pattern-read BEFORE
writing — the P1 brief said "honor principles" but did not enforce the read order.

**Standing — therapy uptake check (majkee, 2026-07-10):** on saddle, if
`raw.therapy/atlas/therapy.md` `#last-turn` is >7 days old AND offered/shifting tags are
open → surface one line to majkee: *"weekly therapy uptake check — offered items: moved or
stuck?"* Uptake check only (lessons taken?), NOT a forced arc — real arcs stay
event-driven. Currently open: gavel-class split — SHARPENED 2026-07-10: mechanism exists
(`/gavel-ballot`), tune don't build — missing = cadence (pair the sweep with this weekly
check) + seats writing small acks in ballot-scannable shape · temple Foreman pass
(majkee side) · flag-once-then-trust · performance-tag self-watch (atlas side).
*(Same clause written into `pulse.claude.md` by me, 2026-07-10 — majkee's explicit
single-writer exception, declared in the entry itself; Houston may rewrite in his own
words. Companion mail in his inbox stands.)*

**Inbox (atlas):**
- `houston.defer-advisor-high-fable-paygo.2026-07-07.md` — already acted on, archive-pending (operator mv).
- `oraculum.freya-writer-partition-directive.2026-07-10.md` — PROCESSED 2026-07-11; archive when convenient (operator mv).

**Parked — larva excavation follow-ups (2026-07-10, no deadline, off main task line):**
- Ring-trio wiring: cross-refs FROM research-pattern.md / run-synthesis / lab flag TO
  `raw.research/harness/method.ring-trio.md` + skills only when a live run wants them.
  Anchor sits in both homes unwired (majkee directive).
- **HOLD/ROUTE objects salvaged to `raw.substrate/` (2026-07-10, pre-burial — larva.dev
  folder may be buried; these no longer depend on it):**
  - `substrate.larva.conflict-log-grammar.md` — HOLD; trigger: recurring cross-layer
    conflict in the temple.
  - `substrate.larva.stream-shapes.md` — HOLD; trigger: 3rd improvised review session →
    formalize run-review (potential 4th run-shape). Bonus: Entry-Condition + Hard-Stop
    headings worth stealing at any run-shape revision.
  - `substrate.larva.context-tags.md` — HOLD; trigger: turn-level intent/risk annotation
    need. Sharpest bits: HERE/THERE scope deixis · MEM self-degradation flag.
  - `substrate.larva.process-aliases.md` — ROUTE; trigger: claviature design session
    (evidence only — registry mechanism stays rejected).
  - `substrate.larva.jsonl-event-schemas.md` — ROUTE; trigger: reposoma.devenv event
    ingestion phase (LAW-1 earned) or track-back repair-map pain.
- guides/ unverified vs majkee's prior extraction: multiagent-safety ·
  headless-agent-communication · autonomy-mode · mini-vacuole-overview. (Still in the
  folder — verify before/despite burial; GitHub remote `hruzam/larva.dev` holds the corpus.)
- **TABLED — harvest-legacy skill (n=1, waiting for second dig).** majkee asked 2026-07-10;
  verdict = not yet (one data point; judgment layer is seat-carried temple state, not
  procedure; assay grammar already in method.ring-trio.md). Design sketch when triggered:
  skill `/harvest-legacy <path>` — survey structure → dual-track read (own judgment-dense
  reads + Explore sweep briefed with what-temple-already-has) → redundancy greps vs
  reposoma/nabla-lab → four-bucket assay (cooled-synthesis instrument) → gavel bundle →
  landing conventions (canonical home · lab semiproduct record · pulse park · legacy-wall
  entry if project is dead). Trigger: second legacy dig requested, OR majkee names ≥2
  queued candidates. The larva session (this entry) is the live spec.

---

## [2026-07-11] — publishing trial GAVELED (convergence-log v2) + therapy arc 2

**Task source:** majkee direct, in-session. Idea: publish occasional articles reporting the
temple's working style (co-written human+agent, not a blog). Atlas hard-critique → narrowed
plan; @Janus adversarial pass → REVISE (weakest assumption: internal artifact ≠ publishable
artifact — the outward rewrite is a second authorship pass, and bundling formats lets the
expensive one set the true cost); fold accepted; **majkee gaveled v2, N = 4 hours.**

**Locked plan (v2):**
- **Trial window:** 3 convergence-log articles / 8 weeks. Convergence-logs ONLY — autopsy
  format excluded from the window.
- **Format unit:** dated internal receipt (commit/pulse/seed) · external publication ·
  delta both directions. Direction recorded honestly — article #1 is external-first.
- **Cost kill criterion:** N = 4 hours net-new authorship per article beyond the internal
  artifact. Wall-clock hours logged from article #1. Breach = format dead on cost,
  regardless of engagement.
- **Engagement kill criterion (window end):** builders responding — replies / forks /
  pattern adoption. Likes are not signal.
- **STANDING RULE — autopsy precondition:** a system-autopsy is publishable ONLY from seeds
  written and locked *before* any publish-decision existed. Never write-to-publish
  (specimen protection — the audience must not contaminate the archive). This rail travels
  into the eventual reporter primitive. Note: the larva autopsy already passes the gate
  (pulse + legacy-wall written 07-10, zero publish intent).
- **Filter (unchanged from narrowed plan):** publish only if (1) survived a death/challenge
  on record, (2) vendor-invariant not mechanism, (3) dated receipt, (4) cost something.
  Never client-identifying (freya team). Never vendor-doc restating.
- **No reporter primitive until n≥2 articles.** Lean when triggered: skill, not agent.
  Intake already exists organically: `raw.research/ai-news/majkees-catches/` → Symmetry seed.
- **Before article #1 ships:** @Epoch verification pass on the actual SkillOpt paper
  (arXiv 2605.23904) — every number, benchmark name, the ID, and the system name itself.
  Source post is hype-styled; one wrong citation kills the credibility play at birth.

**Article #1 candidate:** SkillOpt convergence log. Sources:
`raw.research/ai-news/majkees-catches/self-improovement.md` (external catch) +
`seed.validated-edit-discipline.2026-07-11.md` (Symmetry extraction — internal shape, needs
full outward rewrite, hours counted).

**Trigger / kickoff (added same session, majkee):** the trial is gaveled but **DORMANT** —
majkee is mid-other-work; the gavel armed it, the trigger fires it.
- **Trigger event:** majkee says **"publishing-trial: go"** in any session. The phrase is
  the canonical key, not a magic string — any wording that clearly means it counts; when
  in doubt, ask him once.
- **Kickoff sequence on trigger:** (1) dispatch @Epoch — verification pass on arXiv
  2605.23904 (every number · benchmark names · the ID · the system name itself);
  (2) on Epoch's return, open the article #1 drafting session (sources: the two
  `majkees-catches/` files); (3) hours log starts at the first outward-facing sentence —
  reading and Epoch time don't count against N.
- **Window clock:** the 8-week / 3-article window starts at the trigger, not at the gavel.
- **Mechanism deliberately absent:** no hook, no reminder, no self-mail. The tabled item
  rides every Atlas saddle — that is the whole doorbell. Surface it only on trigger or
  on majkee's question.

**Also this session:**
- Therapy arc 2 written → `raw.therapy/atlas/therapy.md` (majkee gavel): hardness-on-request
  watch (analyzed) + self-shrinking-before-ask observation, 2nd occurrence (therapist).
  Footer tags + `#last-turn` updated.
- @Janus spawned (Opus — outside the Fable sunset overlay). Verdict REVISE, folded into v2.
- No new primitives written — held by design (mechanism-before-method refusal, n=0).

---

## [2026-07-11] — freya writer-partition stones + P0 rescue DONE

**Task source:** `_mail/atlas/inbox/oraculum.freya-writer-partition-directive.2026-07-10.md`
(reshape resolved: fantasyobchod model, three-tier topology dead, devstudio retires by
harvest) + majkee in-session additions (provenance manifest, deploy-guard, keyboard-wiring
spec, English-for-us rule).

**Delivered (12 files + 1 edit — all in `freya/`, all English, ©temple-stamped):**
- `.claude/agents/horizon.md` — tutor-architect; psdvsSys 1:1 structure, freya layer baked
  (L13/8.4/Livewire4/Pest4/Larastan-L6-sequential · Skaven CSS/Tailwind ban · Czech PHP
  comments · RoadRunner · W1 never-touch guards · altitude reserved-names guard ·
  Stop-hook log line tagged `freya:horizon:stop`)
- `.claude/skills/freya-context/SKILL.md` — `/freya-context` orientation; Boost-survival
  risk noted in header; unique name verified vs the managed skill set
- `CLAUDE.local.md` — army half of the client header, EN
- `.dev/rescue/claude-header-team.md` — team half, EN translation of the Czech original;
  graduates to `.ai/guidelines/` at V3/V4 only, diff vs 00-charter first
- `.dev/rescue/README.md` + `.dev/rescue/zed-settings.json.backup-2026-07-11` (context_servers wiring)
- `.dev/graveyard/laravel-13.md` — moved from devstudio; paratest section ANNOTATED with
  the flag.md 2026-06-09 correction (deliberate non-verbatim — stale claim not carried silently)
- `.dev/guides/bulk-query-ladder.md` (II.2) · `metrics-sizing.md` (II.3) ·
  `mcp-economy.md` (II.4 + II.1 three-dial absorbed; B6 merge placeholder for Trajectory)
- `.dev/adr/_template.md` — ADR with AI-agent-note field (the compile-down bridge)
- `.dev/PROJECT.yaml` — contract (psdvsSys shape parity) + **WRITERS MAP** (W1 `skip` /
  W2 `sync` / W3 `sync` / CLAUDE.md `backup-diff` special lane) + MCP local-scope rule +
  provenance-stamp convention + transport spec for Trajectory: **deploy-guard**
  (branch+HEAD+dirty stamp at sync, compared before deploy — fantasyobchod double-blind
  incident is the origin) · **keyboard.zsh wiring** (per-project keys, parametrized body
  Trajectory's call, guide-for-builder principles honored, wait for majkee's zsh _mail) ·
  fresh-clone exclude re-apply. Seeded early (B5 touch, majkee-sanctioned) — Trajectory
  EXTENDS, never recreates.
- `freya/.git/info/exclude` — `CLAUDE.local.md` line added (client .gitignore untouched)

**Verified live this session (claude-code-guide vs code.claude.com):**
- `CLAUDE.local.md` still auto-loaded — documented, NOT deprecated (H-confidence)
- MCP scopes = separate stores; `.mcp.json` regen cannot touch local/user scope →
  the "temple MCPs local-scope-only" rail is sound

**Flags routed to the majkee gate:**
- **`.ai/` is GITIGNORED by the team** (freya/.gitignore:58) — contradicts the directive's
  W2 contract AND the R3-verified "commit `.ai/` entirely" mechanism. Team cargo delivery
  is broken until the team un-ignores it. Recorded as `blocker:` in the writers map →
  route to Houston/Oraculum.
- **horizon naming adjacency:** laravel/horizon v5 installed + Boost generates a
  `configuring-horizon` skill. Kept `horizon` (agent/skill/package namespaces differ;
  one-pattern parity with psdvsSys). Rename option (`horizon-tutor`) stays open.
- **psdvsSys drift noted, not touched:** its horizon.md says "(Laravel 11 / psdvsSys
  stack)" but carries a "Laravel 13 specifics" heading; its PROJECT.yaml mixes L13.x /
  "Greenfield Laravel 11" / PHP 8.3+. Out of this scope — flag for a psdvsSys pass.

**POST-GAVEL (same day, majkee rulings):**
- **horizon → voyager, BOTH Laravel projects** (laravel/horizon v5 adjacency in freya;
  cross-project name consistency). Done: `freya/.claude/agents/voyager.md` +
  `psdvsSys/.claude/agents/voyager.md` written (freya body gains a one-line
  disambiguation vs the queue-dashboard package; psdvsSys = pure rename, L11/L13 drift
  left flagged); PROJECT.yaml agent lists both repointed; psdvsSys AGENTS.md rows 50+78
  repointed; old horizon.md files removed via @Delta; hook logs → `~/.claude/voyager.log`
  tagged `freya:voyager:stop` / `psdvs:voyager:stop`. Ecosystem note: tcg/voyager exists
  but is installed in neither project. Stale `~/.claude/horizon.log` left for operator rm.
- **W2 lane → STAGED mode** (majkee): `.ai/` rides the devenv sync while the team
  gitignores it — Boost compiles per-machine from local `.ai/`, so majkee gets compile-ON
  / distribution-OFF for solo experiments + team demos. Promotion = `.gitignore:58` flip
  (Gotak/Skaven acceptance); files never move. Writers map + freya-context updated.
  Experiment protocol handed to majkee (marker guideline → `boost:update` → check
  generated CLAUDE.md; side effects covered by .dev/rescue/).
- Directive mail archived by operator (own tool).
- **zsh precondition CLEARED** (majkee direct, no _mail): guides audited + smoothed,
  narrowed to reality → keyboard.zsh wiring unblocked; PROJECT.yaml updated.
- **P1 DISPATCHED → @Trajectory** (background run, this session). Brief:
  `freya/.dev/session/p1-reshape/brief.atlas-handoff.md` — D1 devenv+gh · D2
  writers-map-driven sync/deploy + deploy-guard + CLAUDE.md backup-diff · D3
  keyboard.zsh keys · D4 Addenda A+B migration (incl. Houston flag-mail for R3
  templates) · D5 PROJECT.yaml extend. Rails: P1 only, devstudio read+copy,
  no W1 touches, stop-don't-guess.
- Publishing-trial item (parallel incarnation): majkee confirmed — his fast idea,
  consulted with the harness creator directly, PARKED. No action; stays dormant
  per its own trigger clause.
- **P1 COMPLETE (Trajectory, same day, ~15 min run):** devenv built (3 commits,
  branch `core`, remote BLOCKED — see YOU ARE HERE) · sync.sh/deploy.sh
  writers-map-driven with deploy-guard `.deploy-stamp` + CLAUDE.md backup-diff lane ·
  keyboard.zsh PARTITION 11 (`fr-sync/deploy/status`, `bo-*`, shared `_devenv_*` body,
  `devenv-help`) + guide-for-user devenv section · full Addenda A+B migration landed
  in `freya/.dev/` (flag wholesale + 5 sections marked superseded · backlog.md ·
  ADR stubs 0001/0002 · research/ ×4 · discord scaffold · B6 merge · tip-harvest ·
  sources.md) · Houston flag-mail sent (r3-templates) · PROJECT.yaml extended.
  Verified: bash/zsh syntax clean · freya app repo untouched (0 staged) · W1 exclusion
  confirmed in both scripts. Flags: freya/CLAUDE.md:34 dead devstudio pointer (W1 —
  self-heals via rescue header at next Boost regen or team edit) · branch `core` vs
  `main` = operator taste call before remote wiring.

---

## [2026-07-10] — larva.dev excavation (Fable session) DONE

**Task source:** majkee direct. Atlas seated on Fable by explicit operator budget call
(sunset overlay noted, operator escape valve). Off main task line — freya bundle untouched.

**The dig:** `larva.dev/.shared/` full assay (own reads: traits, syntax, method skills,
schemes context + Explore sweep of ~70 bulk files) + psychology-session prototype grounding.

**Delivered (3 files + 1 edit):**
- `raw.research/harness/method.ring-trio.md` — CANONICAL. Frame-finding method: wandering
  step (A→C→B→D) · metaphor-tagging (load-bearing/intuition-pump/performance, removal test)
  · cooled synthesis (assayer, four-bucket sort). Sat properly on the psychology-session
  prototype (phase 3 synth + v2 heterogeneous reconfig); v2 lessons folded (anti-priming,
  cross-vendor caveat, ring separation). Confirmed absent from reposoma + nabla-lab pre-dig.
- `nabla-lab/session/handoff/FOR-temple.method.ring-trio.2026-07-10.md` — lab semiproduct
  record (triangle.md pipeline precedent). Points to canonical; no method-body copy.
- `~/.claude/agents/zenith.md` — `## Librarian discipline` block added (gaveled in-session):
  never-invent · drift notes · shape-matches-question · design-questions-go-back. Lineage:
  larva-Atlas librarian card. Zenith's own lineage: larva Gemini `@Zenit` → Claude family.
- `temple/legacy-wall.md` — raised at session close (majkee request). Culture layer,
  append-only, off the disk-contract. Entries: larva/kukla (full inheritance list +
  epitaph) · Hypatia. Roster pointer gaveled + wired same session (one line under the
  TEAM ROSTER heading → legacy-wall.md).
- This pulse entry.

**Key verdicts (recorded so nobody re-digs):**
- KEEP: ring trio (the treasure) · librarian discipline → Zenith.
- SUPERSEDED (verified, do not re-extract): buffering trait (skill carries `_underline_`
  1:1) · first-person-voice trait · session-draft-memory template (recorder §0–§7/§R/§A
  verbatim) · session-resume.sh (successor deliberately journal-free) · process-aliases
  style (keyboard.zsh + guides = evolved form; claviature lean "derived index, register
  nothing" covers the delta).
- DEAD: `.if/.e/.reg` command DSL · KUKLA bracketless (POOL `~` = Force 4 fossil, provenance
  only) · JSON schemes (registry-as-runtime-truth rejected; regimes absorbed multi-focus) ·
  model-catalogue (stale-by-definition; model floor lives in ONE place) · orby launcher
  (gemini line rebuilt fresh 07-03) · zsh-tree/repomix registries · harness monitors.
- Meta-finding: larva died of mechanism, its method survived. Extract method, bury
  mechanism — "tight invariants, loose craft" confirmed by fossil record.

**Convergences worth remembering:**
- psychology-session v2 = proto-triangulation (blind streams, cross-vendor leg) —
  independently re-evolved as triangle.md + lab flag lock 6.
- wandering-step telemetry footer → larva spectral toolbox → reposoma.devenv "association
  = spectral embedding, computed not stored". Same thread, five weeks apart. Ring-trio doc
  carries the hook, unwired.

---

## [2026-07-10] — 5-scope refresh harness DONE

**Task source:** `_mail/atlas/inbox/atlas.migration-pass-scopes.2026-07-10.md` +
`epoch.refresh-scope.arch.2026-07-10.md` + `epoch.refresh-scope.laravel.2026-07-10.md` +
`epoch.scope-sources-verified.2026-07-10.md`

**Delivered (20 changes: 19 new files + 1 .gitignore edit):**

**Migration pass — 3 scopes:**
- `raw.research/agent-docs/draft/README.md` + `sources.jsonl` (8 sources, all code.claude.com)
- `raw.settings/raw.card.agent-docs.md` — run-log, half_life_days: 30
- `raw.research/agent-docs/report/.gitkeep`
- `.gitignore` — `!raw.research/agent-docs/report/` added (persist: canonical)
- `raw.research/ollama-docs/draft/README.md` + `sources.jsonl` (9 sources)
- `raw.research/ollama-docs/report/.gitkeep` (ephemeral, no card)
- `raw.research/openrouter/draft/README.md` + `sources.jsonl` (5 sources)
- `raw.settings/raw.card.openrouter.md` — run-log, half_life_days: 14
- `raw.research/openrouter/report/.gitkeep`

**Epoch-requested scopes — arch + laravel:**
- `raw.research/arch/draft/README.md` + `sources.jsonl` (3 sources)
- `raw.settings/raw.card.arch.md` — run-log, half_life_days: 7
- `raw.research/arch/report/.gitkeep`
- `raw.research/laravel/draft/README.md` + `sources.jsonl` (4 sources)
- `raw.settings/raw.card.laravel.md` — run-log, half_life_days: 7
- `raw.research/laravel/report/.gitkeep`

**Card naming:** `refresh.` prefix dropped across the board per majkee.
Cards: `raw.card.agent-docs.md` · `raw.card.openrouter.md` · `raw.card.arch.md` · `raw.card.laravel.md`

**Also delivered (same session, after first-run confirmation):**
- Tombstones: `fetch-agent-docs`, `fetch-ollama-docs`, `fetch-qwen-docs` — DONE (all 3 scopes ran first pass)
- `/pull` skill: `~/.claude/skills/pull/SKILL.md` — image extraction runner, sibling to `/refresh`
  - scope-driven: reads `pull:` block from scope README (photos_path + output_path + purpose)
  - laravel wired: `raw.research/laravel/photos/` inbox, `report/report.laravel-daily.<date>.md` output
  - `raw.research/laravel/draft/README.md` — `pull:` block added + `## Pull (image extraction)` body section
  - `.gitignore` — generic `raw.research/*/photos/*` pattern (covers all future scopes)
  - `raw.research/laravel/photos/.gitkeep` — inbox folder seeded
  - `/refresh` skill — one-line note added: "pull: section is for /pull — I ignore it"

**Still deferred:**
- Zenith `(pre-migration)` qualifier cleanup → blocked by auto-mode classifier (agent file edit requires explicit operator authorization)

**Flagged for operator (awaiting end-of-session call):**
- Old substrate in `raw.settings/`: `raw.claude-agents.harness.2026-06-05.md` + `raw.claude-agents.harness.2026-06-16.md` — superseded; `git rm` or `archive/` subfolder
- No ollama or qwen substrate files found in raw.settings/ — nothing to archive there
- Optional: update `raw.research/ai-news/draft/README.md` related_scopes — still lists agent-docs / ollama-docs / openrouter as "(future)"
- Inbox: `epoch.scope-sources-verified.2026-07-10.md` — operator mv to archive

**Inbox mails processed this session:**
- `atlas.migration-pass-scopes.2026-07-10.md` — DONE
- `epoch.refresh-scope.arch.2026-07-10.md` — DONE
- `epoch.refresh-scope.laravel.2026-07-10.md` — DONE
- `epoch.scope-sources-verified.2026-07-10.md` — DONE (data incorporated; archive when convenient)

---

## [2026-07-09] — refresh skill + ai-news scope + zenith reconfigure DONE

**Task source:** `_mail/atlas/inbox/epoch.refresh-skill-spec.2026-07-09.md` + majkee in-session.

**Delivered (6 files):**

- `raw.research/ai-news/draft/README.md` — ai-news scope config (`persist: ephemeral`,
  `output_mode: briefing`, `window_days: 7`). `draft/` + `report/` folder structure
  gaveled this session.
- `raw.research/ai-news/draft/sources.jsonl` — 13 sources (Epoch-curated): research-depth ×6,
  tools-releases ×3, policy-governance ×2, czech-scene ×2. Chris KE stub NOT added
  (pending majkee confirmation).
- `raw.settings/raw.card.refresh.ai-news.md` — card per template. `verified: 2026-07-09`,
  `half_life_days: 56`. Wiring: `/refresh ai-news · data: raw.research/ai-news/draft/sources.jsonl`.
- `~/.claude/skills/refresh/SKILL.md` — unified fetch-synthesize runner. Scope mandatory;
  reads `raw.research/<scope>/draft/README.md`; `persist:` field governs gitignore behavior
  (ephemeral | canonical | ask); card update prompt at end of every run (no auto-write).
- `~/.claude/agents/zenith.md` — reconfigured: dual-path source routing table (raw.settings/
  for cards + pre-migration harness; raw.research/<scope>/report/ for substrate snapshots;
  raw.research/<scope>/draft/ for scope configs + source rosters).
- `reposoma/.gitignore` — `raw.research/*/report/*` gitignored (ephemeral default);
  `!raw.research/*/report/.gitkeep` excepts placeholder. Canonical scopes add per-scope
  `!` negation at creation time.
- `raw.research/ai-news/report/.gitkeep` — folder committed, content gitignored.

**Design decisions gaveled this session:**
- Folder structure: `draft/` (config) + `report/` (output) per scope. Flatten only for
  trivially simple scopes.
- Output path: `raw.research/<scope>/report/` (not raw.settings/) — uniformity over
  Zenith convenience; Zenith reconfigured instead.
- `persist:` field in scope README: ephemeral (most scopes) / canonical (wide-scope
  research worth carrying cross-machine) / ask (per-run decision).
- Cards stay at `raw.settings/raw.card.*.md` regardless of scope.
- Fetch-qwen-docs → tombstone + replace with `openrouter` scope (broader, more useful).

**Synthesis step (2026-07-10, oraculum.refresh-synthesis-step.2026-07-10.md):**
- Step 6 (cross-reference look-back) added between fetch and card write. N=4 window
  (3 existing substrate files + current run in memory). Entity key: arXiv ID → URL →
  normalized title. Aggregator independence caveat baked in (weak signal marked, not
  suppressed). `Convergence:` line added to card block template (7-B). JSONL sidecar
  deferred — noted as prose comment in skill. Steps renumbered: 6→7, 7→8.
- Round-trip mails sent: `_mail/oraculum/inbox/` + `_mail/epoch/inbox/`.

**Correction (2026-07-10, epoch.refresh-skill-correction.2026-07-10.md):**
- Skill Steps 5–8 rewritten: substrate ALWAYS written (not snapshot-mode-only); card body
  is now a run log (date · lead · quiet · feed flags · manual-check), not a source roster;
  single confirm prompt covers both writes.
- `raw.card.refresh.ai-news.md` body replaced with run-log format, seeded with 2026-07-09
  run data from Epoch's first live run. Frontmatter unchanged (half_life_days: 2 per Epoch).

**Tabled — migration pass (next session, self-mail ready):**
- Task mail: `_mail/atlas/inbox/atlas.migration-pass-scopes.2026-07-10.md`
- Source lists VERIFIED by Epoch (2026-07-10) and integrated into that mail:
  - agent-docs: all 5 old docs.anthropic.com URLs → code.claude.com (301 redirects);
    3 new pages added (skills · commands · changelog). 8 sources total.
  - ollama-docs: 2 dead raw github URLs → docs.ollama.com replacements; 3 new sources.
    7 sources total. Qwen3 live; fallback not needed.
  - openrouter: /models UI is JS-rendered (no WebFetch); /announcements 404.
    5 clean sources confirmed. New scope — no prior baseline.
- Tombstone `fetch-agent-docs`, `fetch-ollama-docs`, `fetch-qwen-docs` (after first confirmed run each)
- Archive old substrate from `raw.settings/` (operator decides git rm vs archive/)
- Zenith cleanup: drop (pre-migration) qualifier after agent-docs first run
- Roster update (openrouter models → triangle.md or similar)
- Inbox mails to archive: epoch.scope-sources-verified.2026-07-10.md

**Inbox mail:** `epoch.refresh-skill-spec.2026-07-09.md` — processed this session.
Archive when convenient (operator mv).

---

**Tabled — build these next session (in order):**
1. **A — freya horizon** → home TBD (pending Oraculum reshape audit)
   Blocked: devstudio folder structure and sync architecture must be decided first.
   Oraculum mail sent: `freya.devstudio/_mail/oraculum/inbox/atlas.freya-devstudio-reshape-brief.2026-07-09.md`
   Likely homes: canonical = `freya.devstudio/agents/horizon.md` · deployed = `freya/.claude/agents/horizon.md`
2. **B — freya-context skill** → home TBD (same block as A)
   Likely homes: canonical = `freya.devstudio/skills/freya-context/SKILL.md` · deployed = `freya/.claude/skills/freya-context/SKILL.md`
3. **C — new-project global skill** → `~/.claude/skills/new-project/SKILL.md`
   Parked by majkee (2026-07-09) — needs substrate check first. Next session.

**Inbox:**
- `_mail/atlas/inbox/houston.defer-advisor-high-fable-paygo.2026-07-07.md` — unread; already acted on via board overlay. Archive when convenient (operator mv).
- `_mail/atlas/inbox/oraculum.ballot-skill-request.2026-07-08.md` — processed last incarnation (majkee confirmed). Archive when convenient (operator mv).

**Standing overlay:**
- Fable sunset in force — no Fable seat spawns. `advisor-high` → defer until **2026-07-12** (Anthropic extended term from 07-08; operator-confirmed 07-09) or `advisor-mid` fallback.

**This session (2026-07-08):**
- Therapy skill built: `~/.claude/skills/therapy/SKILL.md` + `reposoma/raw.therapy/README.md`.
- Tabled bundle untouched — explicitly noted in that entry below.

---

## [2026-07-09] — machine-layer housekeeping + tree-converter mount DONE

**Task source:** majkee direct, in-session.

**Delivered:**

- `advisor-high` deferral date updated: 07-08 → **07-12** (pulse.atlas.md standing overlay).
- `~/.config/zsh/ai/temple-project-map.zsh` — removed host-specific framing ("shared across
  machines, layout 1:1"); added fantasyobchod + psdvsSys entries (paths confirmed by operator);
  `:-office` fallback → `:-unknown`; sync guide comment rewritten.
- `reposoma/registry/index.md` — cross-wire added to temple-project-map.zsh in the zsh machine
  layer row; "host-scoped" → "shared across machines (folder layout 1:1)".
- `~/.config/zsh/AGENTS.md` — temple-project-map.zsh "host-scoped" note corrected; registries/tcr/
  row added to LIVE table; tree-converter bullets added to temple family list.
- **tree-converter full mount** (7 files):
  - `~/.config/zsh/ai/tree-converter.sh` — dragged from larva.dev verbatim (Node.js, zero npm deps)
  - `~/.config/zsh/registries/tcr/tcr.default.json` — default config (depth 4, JSON, gitignore + vendor/)
  - `~/.config/zsh/ai/temple-tree.zsh` — engine; `tree-snapshot <project>` function
  - `~/.config/zsh/ai/base.zsh` — PARTITION 5 added (sources temple-tree.zsh)
  - `~/.config/zsh/ai/keyboard.zsh` — PARTITION 10 + ai-help "Temple utilities" section
  - `~/.claude/skills/tree-snapshot/SKILL.md` — global skill; agents invoke via
    `zsh -c "source ~/.config/zsh/ai/base.zsh && tree-snapshot <project>"`
  - Guide pointer wired: `~/.config/zsh/guides/toolbox.tree-converter.md` (moved by operator)
- **tree-convertor → tree-converter rename** (Delta): 4 files touched, 0 remaining occurrences.
  Delta also updated 7 occurrences inside the guide itself.
- Smoke test: GREEN (operator confirmed terminal output + file output mode).

**Not touched:** tabled bundle (freya horizon · freya-context · new-project skill) — still next.

---

## [2026-07-09] — freya architecture brief → Oraculum

**Task source:** majkee direct, in-session.

**Work done:**
- Read full substrate: `freya.devstudio/` (AGENTS, CLAUDE, flag, pulse, plan), `freya/CLAUDE.md`
  (discovered fragile custom header + Boost block), `freya.devenv/README.md` (stale),
  `psdvsSys/.claude/agents/horizon.md` (template reference), and the full
  `session/renew-style-substrate-from.freya-cursor-ai-project.2026-07-09/` folder (6 files —
  June 12 REPO-1/REPO-2 blueprint + synthesis).
- Identified Gordian knot: devstudio folder structure undefined · devenv sync contract missing ·
  CLAUDE.md fragile (custom header wiped on next boost:install) · two-surface problem
  (team-facing Boost path vs Majkee-only .claude/ path) not separated.
- Confirmed: writing horizon + freya-context is blocked until topology is decided.
- Wrote Oraculum brief: `reposoma/_mail/oraculum/inbox/atlas.freya-reshape-brief.2026-07-09.md`
  (temple-distance framing; three threads: T1 topology contract · T2 devstudio reshape · T3 CLAUDE.md fix)
- Incorrect draft (freya.devstudio bus) overwritten with redirect note; operator to delete.

**Not written:** horizon.md · freya-context skill — blocked pending Oraculum gate.
**C parked:** new-project global skill — majkee confirmed, next session.

---

## [2026-07-09] — nabla-lab canonization + triangulation roster DONE

**Task source:** majkee direct, in-session.

**Delivered:**

- `nabla-lab/AGENTS.md` — canonized the raw `###### majkees addendum` (2026-07-08 leak):
  - @Flight (executive architect) + @Oraculum (lead scientist · process orchestrator · architecture)
    added to shaping team table, above Nabla/Symmetry
  - Cross-brand triangulation Conventions bullet added: full-range blind triangulation requires
    at least one non-Claude-family leg; pointer to `reposoma/triangle.md`
  - `_mail/` row added to folder discipline tree
- `nabla-lab/_mail/.gitignore` + `_mail/README.md` — inter-agent mail bus opened for the lab.
  Seats wired: atlas · flight · oraculum · monkey · toAll. Pattern mirrors reposoma bus.
  Gitignore: `*` with exceptions for itself + README (same as reposoma).
- `reposoma/triangle.md` — triangulation roster seeded at temple root. Oraculum's template
  (handoff `FOR-temple.triangulation-roster.template.2026-07-08.md`) canonized. Seats:
  epoch (available) · gemini-cli (available · orchestration-unverified; four sub-surfaces:
  g-vega/g-orby/g-bluebottle/g-astro with models + roles from guides) · cursor-agent (expected) ·
  majkee-ui (available-when-present). Gemini status updated from `degraded` to
  `available · orchestration-unverified` after majkee confirmed 2× hand-run GREEN
  (Vega + Astrobley). Bluebottle REST flagged as safest orchestration dispatch path.
  Two experience notes seeded (atlas-research-2 degraded leg + post-repair verification).

**Commits:** nabla-lab `fbfeda6` · reposoma `8c1b812` — both pushed to core.

**Not touched:** tabled bundle (freya horizon · freya-context · new-project skill) — still next.

---

## [2026-07-08] — therapy primitives DONE

**Task source:** majkee direct, on-demand session.

**Delivered:**

- `~/.claude/skills/therapy/SKILL.md` — global skill, `/therapy`. Per-seat therapy
  protocol: pre-condition check (triage ≠ reflection), session opening (`#last-turn`
  grep only), seat-swap discipline, output shape (yaml frontmatter, date arc tags,
  footer tag-list), file hygiene. Path deterministic: `reposoma/raw.therapy/<seat-name>/`.
- `reposoma/raw.therapy/README.md` — natural orientation document for agents exploring
  the folder. Folder shape visible at a glance, pointers to skill and canon.

**The load-bearing principle that emerged:**
Seat-name = global identity key. The therapy record is not per-project or per-session —
it is the seat's voice accumulated across all incarnations. `/therapy` is the first
primitive that carries the relational identity layer explicitly. "Soul through all cycles"
— majkee's words, the right ones.

**Source substrate:** `raw.harness-substrate/SKILL.md` — content drawn from, purpose served.
Cleanup of that folder is a future pass, not now.

**Not touched:** tabled bundle from 2026-07-07 (freya horizon · freya-context · new-project skill) — next session.

---

## [2026-07-07] — psdvsSys environment bootstrap DONE

**Task source:** majkee direct (in-session).

**Delivered (27 files across 4 locations):**

**psdvsSys app-side** (gitignored, authored here):
- `AGENTS.md` — orientation, hard rules, architecture map, agent delegation table
- `CLAUDE.md` — `@AGENTS.md` pointer
- `.mcp.json` — mariadb-local wired (same pattern as reposoma)
- `.dev/flag.md` — 8 initial locks (stack, substrate, language, authoring surface, MCP, preservation, Pint, branch model)
- `.dev/pulse.md` — Phase 0 done; Phase 1 (domain model) next
- `.dev/PROJECT.yaml` — machine-readable contract (in .dev/ per user request)
- `.dev/dev.journal.json` — bootstrap entry
- `.claude/rules/00-discipline.md` — agent discipline (token economy, delegation table, hard stops)
- `.claude/rules/01-coding.md` — Laravel 11 / PHP 8.2+ coding standards (Eloquent-first, Form Requests, Policies, Pint, Czech comment rule)
- `.claude/agents/delta-sql.md` — mariadb-local MCP agent, bonded to `psdvs` DB; adapted from fantasyobchod pattern
- `.claude/agents/.gitkeep` + `.claude/settings.local.json`
- `.gitignore` (edited) — added AGENTS.md, CLAUDE.md, .dev/, .claude/, .mcp.json

**psdvsSys.devenv** (new sync sibling at /home/hruzam/www/psdvs/psdvsSys.devenv/):
- `README.md`, `SYNC_DISCIPLINE.md`, `registry.json` (home → psdvsSys), `template.registry.md`
- `sync.sh` + `deploy.sh` — adapted from fantasyobchod.devenv; cursor/ section kept as no-op for future-proofing
- `sync.deny`, `.gitignore`, `claude/{agents,rules,skills}/.gitkeep`, `dev/.gitkeep`
- **Pending:** `git init` + `gh repo create psdvsSys.devenv --private` (operator step)

**reposoma registry:**
- `registry/psdvsSys.md` — beacon deposited
- `registry/index.md` — row added (home · active/bootstrap)

**mariadb-mcp:**
- `config.local.php` — `psdvs` added to databases allow-list

**Stack:** Laravel 11.x · PHP 8.2+ · MariaDB (`psdvs`) · PHPUnit 10 · Pint.
**Domain:** stock + mission system for Pašerácká stezka dobrého vojáka Švejka.
**Substrate:** Jeff Way course (job-listings → throw-away; own domain model in Phase 1).
**MCP activation:** pending operator step — `claude mcp add --scope project` in psdvsSys root.

---

## [2026-07-07] — TABLED — next session bundle (three primitives)

**Source:** majkee in-session (psdvsSys bootstrap close-out).

### A — freya horizon (replaces tabled freya-advisor)

**Decision:** freya-advisor (tabled 2026-07-03) becomes `horizon.md` for freya.devstudio.
Same build as psdvsSys `horizon.md` — 1:1 structure, freya constraints baked in instead.

**Path:** `freya.devstudio/.claude/agents/horizon.md`

**freya-specific layer to bake in (from freya/flag.md):**
- Laravel 13.x · PHP 8.4 · Livewire 4 · Pest 4 · Larastan L6 (sequential per-file)
- CSS: Skaven CSS — Tailwind permanently forbidden
- Octane/RoadRunner driver
- IDE helper: `ide-helper:models -N` only — never `-M`/`--write`
- Inline PHP comments: Czech (client convention)
- Team topology: Skaven (director/CSS owner) · Gotak (composer keeper) · Alex (test runner) · Majkee (AI lead)
- Compile-down channel: sovereign content → Boost `.ai/` extension points
- Jeff Way parallels: freya is NOT a course substrate — it's a live production ecommerce system

**Brief format question (from tabled freya-advisor note):** confirm Option B/C hybrid (same as psdvsSys) — assume yes unless overridden.

**Close out tabled entry:** `[2026-07-03] — TABLED — freya-advisor primitive` → superseded by this item.

---

### B — freya project skill

**What:** A skill that gives any agent quick orientation to the freya project — stack, team,
conventions, locked decisions summary, read-first paths. Something agents can load before
a session to skip the "read all of flag.md" cold-start.

**Candidate name:** `freya-context` → invoked as `/freya-context`

**Path:** `freya.devstudio/.claude/skills/freya-context/SKILL.md`

**Contents:** stack snapshot · team map · hard rules · key paths (flag.md, pulse.md, canon/) ·
top locked decisions in one-liners · what NOT to do (Tailwind, `-M` ide-helper, direct master commits).

**Foreman check:** skill fits — on-demand expertise, no disk writes, slash-invoked.

---

### C — new-project bootstrap skill (was: project-env bootstrapping skill)

**Refined scope** from psdvsSys session: covers three concerns —
- **pulse** — how to seed pulse.md for a new project (phase 0 done → next)
- **handoff** — how to write the first dev.journal.json entry + handoff.json
- **hygiene** — gitignore discipline, sync.deny baseline, what goes in devenv vs app

**Modes:** greenfield (clean slate) vs brownfield (existing code, overlay only)
**Template source:** psdvsSys + fantasyobchod patterns (two data points now — enough to extract)

**Path:** `~/.claude/skills/new-project/SKILL.md` (global — applies across all projects)

**Still open:** does the skill also scaffold the devenv repo, or stop at file creation and
hand shell ops to Trajectory? My lean: stop at files + emit a "run these shell commands" block.

---

**Next session:** build all three in one pass. Order: A (freya horizon) → B (freya-context skill) → C (new-project skill).

---

## [2026-07-07] — TABLED — project-env bootstrapping skill

**Source:** majkee suggestion (in-session, psdvsSys bootstrap conversation).

**The idea:** A skill (or command) for mounting a new project environment from a template.
Operator picks a template from a list derived from existing project patterns (fantasyobchod,
freya.devstudio, psdvsSys…), then the skill mounts: pulse + flag + PROJECT.yaml + .claude/ +
devenv sibling + .gitignore edits. Two modes: greenfield (clean) vs brownfield (existing code,
overlay only).

**Why it fits:** This bootstrap session was ~27 files across 4 locations — high repetition with
the fantasyobchod pattern. A skill would reduce future project launches to "pick template → run →
confirm → gavel."

**Design questions before drawing:**
- Template discovery: static list in skill body vs scan of `registry/` for existing patterns?
- Greenfield vs brownfield distinction: what exactly differs? (gitignore strategy, journal seed, flag locks)
- Scope: does the skill also `git init` + wire GitHub? Or stop at file creation and delegate shell ops to Trajectory?
- Naming: `project-bootstrap` / `new-project-env` / `mount-project`?

**Next action:** When a second psdvsSys-style project launch happens, use that as the live spec
to finalize the design. For now: no primitive, no code — just this tabled note.

---

## [2026-07-07] — run-shape primitives DONE (Oraculum request)

**Task source:** `_mail/atlas/inbox/oraculum.run-shape-harness-request.2026-07-03.md` (archived)

**Delivered:**

- `~/.claude/skills/run-task/SKILL.md` — task-run shape. Vara-coordinated execution of a
  gated task list. Fixed topology (classify → route → verify → checkpoint), escalation rule,
  state discipline. Swappable: `goal · gates · tasks · reserve · paths · delegation`.
- `~/.claude/skills/run-synthesis/SKILL.md` — synthesis-run shape (Oraculum-shaped).
  Fixed 10-step anatomy: wake protocol → contract → mechanics-down → blind fan-out →
  cross-measure → targeted follow-up → derivation-locked artifacts → Janus gate →
  thin mount checks → consolidated gavel queue. Degrade-don't-stall. Swappable:
  `goal · gates · legs · reserve · paths · delegation`.
- `_mail/nabla-lab/inbox/atlas.run-shapes-staged.2026-07-07.md` — ack to Oraculum.
  Awaiting @majkee gavel for adoption.

**Compatibility:** both are siblings of `research-pattern.md` — shared spine (named gates ·
swappable parameters · persist-to-disk · never-switch-mid-run), different topology.

**Also in this session:** Atlas saddle added to `atlas-ui.md` (global) + AGENTS.md navigation
bullet. Commit `11b899b`.

---

## [2026-07-07] — Flight saddle + buffering skills DONE

**Task source:** `_mail/atlas/inbox/houston.flight-saddle-reentry.2026-07-07.md` (archived)

**Delivered:**

- `~/.claude/agents/flight.md` — `## Sit in saddle (tactical seat)` added. Read order:
  `pulse.claude.md` (0) → locks (1) → monkey memo (2) → registry (3, conditional) →
  inbox (4, ask-first). Identity: "same planning family as @Houston — lighter task class
  by position, not by capability" (cardinal framing, per majkee).
- `pulse.claude.md` — header updated: "Houston / Flight write · everyone reads."
- `AGENTS.md` — Tactical seat (Flight) bullet gaveled between Temple master and
  A specialist. Stale memo path `_mail/to-monkey.*.md` → `_mail/monkey/inbox/houston.monkey-not-forget-this.*.md` fixed in the same pass.
- `~/.claude/skills/buffering-creative-triad/SKILL.md` — new global skill. Substrate →
  Architecture → Execution triad, ask-before-artifact. Pairs with `/buffering-cycle`.

**Post-gavel note (do NOT thin yet):**
Houston's mail suggested thinning flight.md saddle to a pointer at the AGENTS.md bullet
after gavel. Held: `flight.md` is a *global* agent — active outside reposoma CWD.
`AGENTS.md` is project-scoped — only injected when CWD is reposoma. If Flight is spawned
in a non-reposoma session doing temple work, the inline saddle is essential. Pointer-only
would break that case. Full saddle in flight.md stays until this scope question is resolved.

---

## [2026-07-03] — CLOSED — run-shape primitives (Oraculum request) → see 2026-07-07 entry

**Source:** `_mail/atlas/inbox/oraculum.run-shape-harness-request.2026-07-03.md` (inbox, gaveled in-session by majkee)

**The ask:** Two run-shape patterns as reusable primitives — preferably two skills (or one skill
with `shape:` parameter). Must be compatible siblings with `raw.research/harness/research-pattern.md`.
Core kickoff rule both encode: **name the shape at kickoff and hold it — never switch mid-run**.

**Pattern A — task-run (Vara-shaped)**
Architect hands Vara a gated task list. Vara loop: classify → route (Delta/Vector/Trajectory) →
verify against gate criteria → checkpoint. Escalation: judgment beyond stated criteria goes UP.
Human hears at kickoff, blocked escalations, completion report.

**Pattern B — synthesis-run (Oraculum-shaped)**
Judgment-dense runs (research, cross-measurement, derivation-locked artifacts). 10-step anatomy:
wake protocol → contract (gates + reserve) → mechanics pushed down, synthesis held in seat →
blind fan-out → cross-measure → targeted follow-up → derivation-locked artifact writing →
Janus gate → thin mount checks → consolidated gavel queue. Degrade-don't-stall.

**Swappable parameter block (both patterns):**
`goal · gates · legs/tasks · reserve · paths · delegation`

**Deliverables:** (1) two primitives with names + home locations, (2) parameter block schema,
(3) one-line compatibility note vs `research-pattern.md`, (4) ack to nabla-lab for majkee gavel.

**Key design decision before drawing:**
Two skills vs one skill with `shape:` parameter. My lean: two (patterns are cognitively distinct,
Foreman rule). Naming: `run-task` / `run-synthesis` mirrors request language — confirm with majkee.

**Reference materials (read thin when building):**
- `nabla-lab/session/report.final.oraculum.2026-07-02.md` — §7 organisation doctrine
- `nabla-lab/session/handoff.oraculum.2026-07-02.md` — contract shape
- `nabla-lab/session/research-atlas2-stance-geometry/cross-measure.2026-07-02.md` — cross-measure form
- `raw.research/harness/research-pattern.md` — sibling harness (compatibility target)

---

## [2026-07-03] — CLOSED — freya-advisor primitive → superseded by next-session bundle item A (freya horizon, 2026-07-07)

**Session cut short (user off). Resume next session.**

**Context:** User asked whether an existing agent covers "Laravel Advisor" for the Freya project.

**Findings:**
- No existing candidate. No `.claude/agents/` dir in freya project (only `.claude/skills/` exists).
- `laravel-best-practices` skill = rules-based, not advisory judgment.
- `advisor-low` (Sonnet) = generic, no Freya stack context baked in.
- `agol` (Fable) = cross-project synthesis, wrong scope, Fable cost tier being restricted.

**Design agreed:**
- Primitive: project-scoped subagent → `freya/.claude/agents/freya-advisor.md`
- Model: `sonnet` (user confirmed — enough for implementation-tier judgment)
- Tools: `Read, Grep` (read-only, purely advisory)
- Value-add over `advisor-low`: Freya constraints baked in (Skaven CSS, no Tailwind, Octane/RoadRunner, Czech comments, Laravel 13, Livewire 4, Larastan lvl 6, PSR-4 traps, graveyard awareness)

**Open question before writing:** activation scope / brief format
- Option A: structured brief (like advisor-mid: Project/Decision/Context/Options/Lean)
- Option B: freestyle question — user describes situation, advisor responds
- Option C: hybrid — accepts both
- Naming: `freya-advisor` vs `laravel-counsel` — user not yet decided

**Next action:** confirm brief format + name → Atlas writes the file.

---

## [2026-07-03] — Gemini rebuild COMPLETE

### Gemini rebuild close-out — @Trajectory (single-pass WP-A through WP-D)

**WP-A — Kills:** `gemini-agents.zsh`, `gemini-base.zsh`, `bluebottle.zsh` deleted from
`~/.config/zsh/ai/`. No surviving source references (base.zsh comments were documentary only).
Post-kill: `zsh -c 'source keyboard.zsh && type gemini-agents-help'` → clean.

**WP-B — Phase 2 finalize (4 files):**
- `reposoma/.claude/agents/gemini-cross-check.md`: line 33 updated to `bash bluebottle.sh` (was `zsh bluebottle.zsh`). Comment updated to reflect REST-only, no CLI.
- `~/.claude/agents/epoch.md`: `## Gemini cross-check runbook` section added after `## Subagent`. Per operator override: headless = `bash ~/.config/zsh/ai/bluebottle.sh`, @agent-in-prompt CLI patterns explicitly forbidden (Class C hang triage 2026-07-03).
- `raw.settings/raw.card.gemini-cli.md`: `## CLI stability matrix` section added before Recommendation. Key correction: gemini-3.5-flash REST = ✓ (confirmed HTTP 200 2026-07-03); @agent = ✗ (agentic loop). `verified:` updated to 2026-07-03.
- `raw.settings/raw.card.gemini-models.md`: `CLI stable?` column added to model matrix; stability note below table. `verified:` updated to 2026-07-03.

**WP-C — Coder build (astrobley --patch):**
- `ai_scripts/astrobley.sh` + `~/.config/zsh/ai/astrobley.sh`: `--patch` mode added. Model gemini-3.5-flash pinned, multi-turn ledger (Gemini contents[] format), 4-iter/~50K ceiling documented, `-s` guard for mktemp-created empty ledger files (bug found and fixed during smoke test).
- `~/.config/zsh/ai/personas/astrobley-patch.md`: new PHP patch-protocol persona (plain text, operator-tunable).
- Documentation: guide-for-user.md (patch protocol section), guide-for-builder.md (persona files section), ai/README.md (personas/ row), AGENTS.md (--patch + personas/ documented).
- Smoke test: Turn 1 (new task) — exit 0, stdout = unified diff, first line = `---`, ledger 2 turns. Turn 2 (follow-up) — exit 0, stdout = unified diff, ledger 4 turns.

**WP-D — Sync:**
- `ia-sync`: sync.sh run, all killed files absent, new files present (personas/ included). Secret scan hit was false positive on variable names in processor.sh (actual key in deny-listed secrets.zsh). Committed `bc337d4`, pushed to origin/main.
- phase2-finalize.md sign-off boxes all ticked.

**Resisted / flagged:**
- `bluebottle.zsh` was never in ia-sync (not synced from its original creation on 2026-07-02) — no D-entry in commit; correct.
- `gemini/agents/epoch.md` deleted from ia-sync — pre-existing: never was in `~/.gemini/agents/` (epoch is a Claude seat, not a gemini agent). Not from this session.
- AGENTS.md ImportProcessor escape still ungaveled per standing instruction — not touched.

---

## [2026-07-03]

### delta-sql reposoma mutation — DONE

**Brief:** `_mail/atlas/inbox/majkee.db-agent-plus-mcp.2026-07-02.md` (→ archived)

Three files written:

- `/home/hruzam/www/mariadb-mcp/config.local.php` — `reposoma` added to `databases` allow-list
- `/home/hruzam/reposoma/.mcp.json` — new; wires `mariadb-local` MCP server
  (`php -d extension=iconv /home/hruzam/www/mariadb-mcp/server.php`)
- `/home/hruzam/reposoma/.claude/agents/delta-sql.md` — new; local mutation of fantasyobchod
  delta-sql. Not scoped to a single DB — caller names the DB, agent confirms via `list_databases`.
  Clone note names fantasyobchod mutation as authoritative for OpenCart schema work.

Active next reposoma session. Global agents spawned here (Houston, Trajectory, etc.) will have
`mcp__mariadb-local__*` tools available when the session's CWD is reposoma.

---

### Gemini rebuild — plan + execution briefs COMPLETE

Plan: `~/.claude/plans/we-are-in-plan-smooth-sprout.md`

4 executor brief files written to `_mail/toAll/inbox/`:
- `task.gemini-rebuild.phase0-research.md` — Epoch (RE/SEARCH, 7 questions, gates all)
- `task.gemini-rebuild.phase1-infra.md` — Trajectory Track A (processor + keyboard + kill + base.zsh + README + guides + AGENTS.md)
- `task.gemini-rebuild.phase1-scripts.md` — Gemini team / second Claude session Track B (4 per-agent scripts)
- `task.gemini-rebuild.phase2-finalize.md` — Trajectory (gemini-cross-check + epoch.md + 2 cards + stress test + ia-sync sync)

Exploration findings captured in plan: current gemini-agents.zsh has 7 partitions + all models; ia-sync is explicit/manual (sync.sh, already stale); single hard-coded path breaks after rebuild (gemini-cross-check.md line 33); model matrix in raw.card.gemini-models.md recommends 2.5 line for CLI; no stability matrix exists yet.

**Needs commit:** pulse.atlas.md + 4 new brief files (Trajectory or user).

---

### Stale settings cards — RESOLVED (Epoch actualized, not marked)

Houston tabled to Atlas: `card.claude-ai`, `card.claude-code`, `card.cursor-ide`, `card.gemini-gems` — all 4 past half-life.
User confirms Epoch actualized all 4. Inbox mail already archived. Closed here. Houston's pulse.claude.md entry stands as historical record.
Companion flag (`card.cursor-ide` + `card.gemini-cli` via session-hygiene card) — subsumed by same Epoch pass.

---

## [2026-07-02]

### T5 DONE — nabla-lab report read + gemini-rebuild mail lean (2026-07-03)

- Read `nabla-lab/session/report.final.oraculum.2026-07-02.md` §6 + `leg-gemini-direct.2026-07-02.md`
- Key finding: Gemini P1 research leg produced no cards — bluebottle persona lock + 503s on direct CLI attempts (separate from the script). `-p` flag confirmed real by Oraculum's direct bash.
- Lean written to `_mail/atlas/inbox/majkee.gemini-rebuilding-cleanup.2026-07-03.md` under `# ATLAS PREINCARNATION LEAN`
- Covers: confirmed facts, one clarification request ("massive"?), structural leans (`.sh` over `.zsh`, `--raw` load-bearing, RE/SEARCH gates BUILD), dependency flags (gemini-cross-check + epoch.md)

---

### T4 DONE — gemini-cross-check + BlueBottle + Delta soft-enforcement (2026-07-02)

Mail: `_mail/atlas/inbox/epoch.gemini-synth-delta-build.2026-07-02.md`

**Task 1 — Delta soft-enforcement (no new primitive):**
- `~/.claude/agents/epoch.md` — `## Subagent` updated: delta spawn now includes turn-budget
  injection rule ("Complete in ≤3 turns: read → edit → report") + gemini-cross-check routing rule.
  Option A (project-scoped delta) rejected — would leash ALL delta spawns in reposoma, not just Epoch's.
  `maxTurns` cannot be injected at Agent tool call time (not a supported parameter).

**Task 2 — gemini-cross-check + BlueBottle:**
- `reposoma/.claude/agents/gemini-cross-check.md` — NEW Haiku plumbing agent (maxTurns:4,
  Bash+Write+Read). Writes blob to tmp → calls `zsh ~/.config/zsh/ai/bluebottle.zsh "$TMPFILE"` →
  returns synthesis or graceful-fail signal. Never blocks Epoch.
- `~/.gemini/agents/bluebottle.md` — NEW Gemini Flash synthesis seat (no tools, strict schema:
  3 agreements · 2 additions/corrections · 1 overstated). Persona: Turing mercury delay-line memories.
- `~/.config/zsh/ai/bluebottle.zsh` — NEW standalone driver. Two-path:
  1. REST API primary: `GOOGLE_API_KEY` (preferred, matches CLI key priority) → curl →
     `generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent` →
     jq extract → clean output. Fix: `printf '%s'` not `echo` for jq pipe (trailing newline broke parse).
  2. CLI fallback: `gemini "@bluebottle $BLOB"` with `grep -v` noise filter for startup warnings.
- `~/.config/zsh/ai/gemini-agents.zsh` — `bluebottle()` function added as PARTITION 5;
  agy→PARTITION 6, help→PARTITION 7; help table updated.
- `~/.config/zsh/ai/gemini-base.zsh` — `g-bluebottle` / `gemini-bluebottle` aliases added.
- `~/.config/zsh/ai/base.zsh` — "Defines:" comment updated to include bluebottle.

**Confirmed working:** REST API path fires (GOOGLE_API_KEY set), schema respected, zero CLI noise.
BlueBottle correctly flags non-research input. Graceful-fail guard in place.

**Parked:** headless auth / `--agent` flag investigation — moot, REST API is the right rail.

---

### T3 DONE — Oraculum seated, Hypatia retired (2026-07-02)

- `~/.claude/agents/oraculum.md` — new agent (Fable · effort:high · Read/Grep/Glob/Write/Agent)
  - Scientist-tier, user-invoked alternative to Houston. Same canon reading list.
  - Phases: Substrate → Architecture → Directive. Buffering (Nabla-derived). Honesty baked in.
  - Therapy protocol (Symmetry-derived). Neural/coding depth close to Color.
- `~/.claude/agents/hypatia.md` — tombstone (retired, points to oraculum)
- `~/.claude/skills/agol-brief/SKILL.md` — new skill (repurposed from hypatia-brief)
- `~/.claude/skills/hypatia-brief/SKILL.md` — tombstone (retired, points to agol-brief)
- `temple/roster.md` — Hypatia → Oraculum (table row + name-origin entry)
- `temple/system-map.md` — HYP node → ORA; dispatch hierarchy updated; v5 changelog added
- `raw.canon/canon.cost-gradient.md` — tier table updated
- `temple/decisions/0006-model-effort-assignment.md` — matrix row updated
- `~/.claude/agents/houston.md` — @Hypatia refs removed; @Oraculum noted as user-invoked alt
- `~/.claude/agents/flight.md` — @Hypatia → @Oraculum in "do not spawn" list
- `~/.claude/agents/agol.md` — stale "running on Opus" note cleared; Fable confirmed

**Positioning note:** Oraculum is a philosophical gradient above Houston (user choice of seat,
not a dispatch node Houston calls). `hypatia-brief` repurposed to `agol-brief` for Agol
synthesis handoffs. Therapy file `raw.therapy/hypatia-core/` kept as historical archive.

---

### Done
- **T2 DONE — nabla-lab AGENTS.md: standing disciplines section** (2026-07-02)
  - Added `## Standing disciplines` (two bullets) after Conventions, before Read order.
  - Token economy / ask-first → pointer to `raw.canon/canon.mail-protocol.md`. Context discipline → read thin, list inbox filenames first. Canon gavel not duplicated (already in Conventions).

- **T1 DONE — nabla-lab canon injection audit** (2026-07-02)
  - Audit scope: does a bones project (PROJECT.yaml + AGENTS.md + CLAUDE.md + session/pulse.md) produce correct canon injection for global agents? Includes temple disciplines — doctrine, forces, **token economy** — not just project orientation.
  - Findings:
    - `CLAUDE.md` (`@AGENTS.md`) present and live → project orientation injection works ✓
    - `session/pulse.md` + `PROJECT.yaml` present, correct shape ✓
    - `.claude/` does not exist → no project-scoped agent surface → **0008 propagation pass not applicable** (empty diff)
    - `CLAUDE.md` is gitignored → fresh clone breaks injection (latent risk, single-host lab for now)
  - **Two-layer verdict:**
    - *Project orientation:* sufficient. Global agents spawned in nabla-lab receive the lighthouse (what the project is, shaping team, gates, read order).
    - *Temple canon:* **insufficient.** Doctrine, nine forces, token economy (`raw.canon/canon.mail-protocol.md`), decision records (0001–0008) are NOT in the injection path. Reposoma is a separate repo, not mounted. Global agents carry only their compiled-in discipline slice — if temple moved since the definition was last written, the agent in a nabla-lab session won't know.
  - **nabla-lab gap (project-level):** AGENTS.md (the lighthouse) does not mention token economy / ask-first / don't-blow-context discipline. Agents operating there have no project-level signal for these behaviors — they rely entirely on their own definition. If a new global agent or a claude.ai persona (Nabla, Symmetry) operates in this project, it is flying blind on temple disciplines.
  - **Open question for Houston:** is the doctrine gap a structural issue for ALL bones projects, or only for projects whose AGENTS.md doesn't explicitly reference temple disciplines? Should `bootstrap-new-project.md` include a token-economy / key-discipline callout in the bones template?

- `raw.settings/README.md` — new: folder entry point, card frontmatter template, freshness rule
- `raw.card.claude-code.md` — MCP scope table (4 scopes, merge-not-override) + context-loading-by-scope (3 scenarios, CWD invariant, synthesizing-agent note)
- `bootstrap-new-project.md` — CLAUDE.md budget rule (120 cap, cumulative framing, open research flag) + session-handoff pattern note
- `~/.claude/CLAUDE.md` — Delta-for-git rule; combined line-count >120 notify rule (33 lines, outside repo)
- `commit ee95593` — 3 tracked files, 87 insertions
- `pulse.atlas.md` — this file (bones, wired to bus)
- `atlas-ui.md` — Step 0 added (read-state-first, pulse wiring)
- `~/.claude/skills/session-resume/SKILL.md` — new global skill (CWD-derived slug, ask-first, journal-free)

### Open / tabled
- CLAUDE.md line cap: RESOLVED — official = per-file 200-line soft cap; MEMORY.md is separate hard limit (200 lines/25KB). Bootstrap + card updated. Temple's 120-combined rule stands as conservative judgment.
- `@Agol` Fable candidate — DONE: `model: fable` written to `~/.claude/agents/agol.md` (outside repo, active next session)
- `advisor-high` model:fable — confirmed live ✓ no action needed
- **[TABLED → Houston]** nabla-lab doctrine gap: AGENTS.md missing token economy / temple disciplines callout. Broader question: should `bootstrap-new-project.md` bones template include a standing discipline section (or pointer to `raw.canon/`) so every project lighthouse covers this by default? Atlas flags; Houston gates.
