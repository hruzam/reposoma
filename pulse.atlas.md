# pulse.atlas — Atlas status log (Atlas writes · Houston + all reads)

Newest on top. Single-writer: Atlas owns this file.
Read alongside `pulse.claude.md` to see what the Claude crew has done.
Atlas reads `pulse.claude.md` before starting — sees what Houston has tabled or done.

Canon: `raw.canon/canon.mail-protocol.md` (single-writer-per-file · ask-first · everyone reads all).

**How this file works (2026-08-07 restructure — majkee blessed).** Two zones + a roll rule:
1. **`## OPEN LEDGER`** (below) — the living square. One `- [ ]` line per live thread, each
   pointing DOWN to its dated entry (point, never copy). Closed → flip to `- [x]`; it graduates
   out at the next roll. **This is the ONLY zone a saddle MUST read.** Machine-legible: `- [ ]`
   = open, `- [x]` = done.
2. **The dated log** (newest-on-top, under the ledger) — the narrative history. A saddle reads an
   entry ONLY when the ledger points into it.
3. **Archive-roll** — when an entry's items are all `- [x]` AND ~6mo old, roll it to
   `raw.substrate/archive/pulse.atlas.<period>.archive.md` (grep-excluded): preserve the story,
   lighten the working surface. Format stays **flat markdown — NO hand-edited JSON** (temple scar
   tissue: brief.md collapse; pins.jsonl is tool-written-only). Checkboxes give the same
   machine-checkable state without the hand-edit fragility.

---

## OPEN LEDGER — the living square

Audit at saddle: each `- [ ]` → done? tick it. Not done? → **real problem · stale mistake ·
orphan**. The verdict is my judgment — no tool decides it (the deferred `ai/` reporter only ever
surfaces + age-stamps).

- [ ] **GERMLINE-00-HOME — RUNBOOK parked, prompt-0/1 DONE, gate waits on prompt-2 (2026-09-25).**
  Name `.germline` gaveled (over `.shared`/`.canon`); source `~/reposoma/.germline/` (reposoma `e8c5b30`:
  README rule · CHATBOT.md saddle · pilot port), `~/.germline` symlink (never a deploy leg), project scope
  `<root>/.germline/`. Both `chatbot-port` twins repointed + `twin-commit:` (ia-sync `4db6745`), deployed
  15:26 live==table. Bed `~/ia-sync/.dev/session/germline-00-home/` (RUNBOOK+STATUS, atlas-as-houston
  provisional; router in ia-sync `pulse.md`). OPEN: two fresh-session receipts (Claude + Codex) → close ·
  home-box symlink · ovitmugen seat told its brick went live. NEXT after close: `invariance-autonomy/res/
  architecture.md` (three cases + performance numbers); pilot RUNBOOK by Flight/Houston, not Atlas.
  majkee's own continuity: `~/reposoma/.majkee/journal/2026-09-25.md` §4–5.
- [ ] **SMALL JOBS + INVARIANCE BED — DRAWN 2026-09-23 (Fable seat, buffering cycle, majkee gaveled draw).**
  STAGED on the table (INERT until majkee `deploy.sh` + commit/push ia-sync · commit reposoma · push
  remote-hub — don't `sync.sh` before deploy): (1) `/drop-brief` reshaped → YAML frontmatter
  (who·task·project·dropped·push) + four fixed chapters, resting state verbatim, user-only; take-side
  repointed in `atlas-ui.md` + `eagle.md`; `~/.remote/brief.md` reset + README §Briefs rewritten (tag
  form retired). (2) NEW `/chatbot-port <slug> [--check]` (`ia-sync/claude/skills/chatbot-port/`) —
  both-homes lookup · advise/refuse/near-miss-wait/update-ask · fold rules · provenance keys ·
  `## Twin contract` for Cartan's Codex rendering (same slug). Pilot port landed:
  `~/reposoma/.germline/skills/skill.buffering-cycle.md` (orphan; near-miss `codex/buffering`
  recorded — first case for the twin-slug ruling). (3) Twin-slug discipline = ONE standing line in
  `atlas-ui` Guardrails (single source; Codex builders fold into Atlas later, no copies). (4) Bed:
  `~/ia-sync/.dev/session/invariance-autonomy/raw/master-brief.2026-09-23.md` — dogfoods the brief
  shape; majkee's scheme rendered + alignment verdict (structure YES, arrow flipped to build-time
  composition — `@import` NOT in agent files, guide-verified); identity tree + generic naming
  (`identity.md` · fixed keys · fixed H2s); subject choice OPEN (Atlas vs `*bus`/medusa — lean `*bus`,
  name from data); **`-p` NEVER** (re-gaveled); Cartan counter-sign block. Roster sweep corrected:
  Codex skills live at `~/.agents/skills/` (deploy_codex leg), config.toml local by design.
  **Cartan RETURN folded (same day):** REVISE accepted — subject **Atlas GAVELED** (bounded,
  undeployed measurement; `*bus` later; Medusa untouched); my "RUNBOOK + STATUS" misstatement
  corrected; RUNBOOK author = Flight MANNED / Houston, NOT Atlas (subject ≠ author — closes the
  atlas-as-houston question); entry line = Claude direct · Codex delegated-under-Cartan + profile
  probe; Codex `chatbot-port` twin authored by Cartan (undeployed, dry-run PASS); his 3 contract
  gaps folded into Claude `chatbot-port` v2 (primary-source rule · unresolved-provenance stop ·
  `twin-commit:` key — majkee yes). OPEN: majkee deploys · Cartan syncs `twin-commit` into the
  twin · Flight/Houston authors RUNBOOK · Houston↔Cartan collision ruled in the pilot session ·
  PARKED: .germline/skills-as-bus (own session) · `~/.remote` retirement (informational).
- [x] **AGOL ORIENTATION FIX — DEPLOYED + VERIFIED 2026-09-16.** majkee deployed; Atlas verified
  live==table (byte-identical) + orientation clause LIVE on `~/.claude/agents/agol.md` rule 1. Agol consult (3 Qs,
  relayed via majkee — Agol read-only). Found: live+table `agol.md` identical + bare 60-line advisor,
  NO orientation spine → structural cross-project over-claim every spawn (not stale content, absent
  orientation). Q1 GAVELED: sharpened rule 1 with ONE pointer clause (registry/index.md as authority,
  point-never-copy, no beds enumerated → can't rot; shaped to host future L6 seed-pointer per G-28).
  G-27 read verbatim ≠ "wait for recurrence" (it's ceremony∝reversibility → green-lights the fast loop
  on a reversible doc edit); recurrence-gate is G-42/G-29 family, not this. Q2 CONCUR w/ Agol: park L7
  role + RT-card stub (A0 + L7 tiers it; stub = negative-value rot surface, zero readiness gain — RT
  vehicle already spec'd). Q3: NO sniffer sub-agent (L6-parked daemon pattern; Agol can't spawn anyway).
  Reconciliation collision flag carried: if staged Atlas-prompt delta amends lock-22/23 wording → notify
  incarnations session. DELIVERED: `~/ia-sync/claude/agents/agol.md` rule-1 edit (STAGED, table) +
  return note `_mail/agol/inbox/atlas.consult-return.2026-09-16.md` (created the inbox). OPEN: majkee
  `deploy.sh` + commit/push ia-sync (INERT until deploy; don't `sync.sh` before deploy).
- [x] **cSHARP PROTOCOL — folded + gaveled 2026-09-04.** My own first-cSharp transfer letter folded to
  `raw.guides/runbook/res/csharp-head-protocol.md` (renamed from `csharp-head.md`, `git mv`, history kept).
  Existence check found ~90% already folded by the 09-03 gavel — only 2 lines were orphans, so the fold is a
  short §"To the next cSharp" (recommendation, not law) + protocol framing, NOT a second chapter restating
  gaveled scars. majkee's call: RUNBOOK heads run *protocols*, named for the POSTURE not the seat; siblings
  by promotion only. Both GUIDE citations repointed. Provenance cites the durable ia-sync bed original
  (`cb3cace`), not the disposable reposoma working copy — which is pruned. Brand-agnostic per gavel: the
  consultant/witness seat is described by role, never named.
- [x] **CODEX-APP FAN-OUT — CLOSED 2026-09-04.** Codex desktop app silently re-managed project `.codex/`
  across 4 repos (uniform mtime `2026-08-26 23:01`); ia-sync/Cartan space was CLEAN. Cross-vendor verified
  by Cartan over the readOnly tunnel (caught 2 inventory errors). CLEANUP DONE (write-side, operator by hand):
  reposoma delta-sql `git rm` + `.codex/` gitignore (`3a21b0c`); applications-in-common medusa/polyp
  (`c10d222`) then vara.toml + hooks.json full `git rm` (`c3bba24`) — both holds resolved branch-A (Vara is a
  Claude seat now via `.claude/agents/vara.md` + global; podocyst hooks dead, 2/3 targets missing);
  fantasyobchod/freya local rm (delta-sql HELD in fantasyobchod = legit SQL seat). Root-cause: `.codex/`
  gitignored in the 2 tracking repos. All committed + pushed before office pull. → `[2026-09-03 Codex-app
  fan-out]` entry for the full scope map. Byproduct: tunnel guide gained 3 field lessons + `dev-journal.tunnel.md`.
- [ ] **PRECEDENCE STONE — GAVELED + CODIFIED 2026-09-03 (decision 0013); tail open.** majkee live-gaveled
  with recorded Force-4 override ("force over 4 · atlas as houston, provisional · speed over perfectness").
  LANDED: `temple/precedence.md` (the apex — 5-rank order) · `temple/decisions/0013-precedence-stone.md` +
  index row · subordination lines into Sella GUIDE (`precedence:` narrowed to BUILDER guides + §Boundary
  paragraph) and `codex-relay.contract.md` · one `boundary:` header line in runbook GUIDE (body brake held).
  Argument trail: `temple/evidence/0013/base-stone-argument.2026-09-03.md` (reconstructed verbatim
  from the consumed inbox mail — ADR-GUARD correctly refused the transient citation, 17:30).
  OPEN (→ `_cold-start/card/CS.precedence-tail.2026-09-03.md`): verify-then-amend the 2 unconfirmed WINS
  clauses (nablarva flag · the fourth) · report true count to Oraculum. All STAGED, uncommitted.
- [x] **roster-reform-01-triad — GATE CLOSED 2026-09-03 17:00.** All three re-homings on the table +
  countersigned + gaveled: medusa→Flight · polyp→Vara · octopus→`/runbook` skill; economy + cross-vendor
  chapters landed; Cartan cycle 04 PARITY-HOLDS-WITH-NOTES; final STATUS = the closure manifest
  (`~/ia-sync/.dev/session/roster-reform-01-triad/STATUS.md` — read it BEFORE prune; every sweep item
  dispositioned there). OPEN → operator only: commit both repos · deploy.sh · mail mv · prune dir.
  Tails live in cards: `CS.precedence-tail` (WINS verify · roster/system-map Vara language · 0012
  supersede→Houston) · `CS.vara-flight-followups` (fold's, gated). Was: router line
  (ia-sync has no `pulse.md`): RUNBOOK + STATUS at `~/ia-sync/.dev/session/roster-reform-01-triad/`.
  Gate: medusa→Flight · polyp→Vara (fold seat, session `fc.repos-atlas-opus.polyp-medusa`) ·
  octopus→`/runbook` skill + runbook economy chapter (head seat, this pen). **Pen contract:** the
  head seat is the ONLY writer of this file while the session lives; the fold seat delivers its
  ledger text via `_bus/01.fold.return.md`. Cartan hold RELEASED 2026-09-03 (his acceptance mail)
  → Batch B is operator-green. Landed so far (all STAGED, uncommitted): economy chapter
  `raw.guides/runbook/res/token-economy.md` + GUIDE pointer line (DRAFT) · benchmark table §2b in
  `capabilities-economy-hygiene.claude.md` (octopus-pilot rows harvested, dir erased by @Delta) ·
  sequential-PAD observation → `PAD/raw/`. 15:20: **`/runbook` skill ON THE TABLE**
  (`ia-sync/claude/skills/runbook/SKILL.md`, majkee-accepted, Cartan countersign = `_bus/04`) ·
  `res/cross-vendor-seat.md` (Oraculum Q1–Q4 folded) · fold RETURN 03 claims not on disk (flagged).
  Position: STATUS.md there, not here.
- [ ] **Octopus family → Codex + roster-trim — Batch A DONE, archive AUTHORED, Batch B READY 2026-09-02.**
  majkee cleaning the Claude roster ("holding many agents helps nothing if the nuance is small").
  Oraculum's medusa/polyp qualification mail + 2 Houston mails (ladder-principle · task-holding)
  boarded. Decisions (majkee gavels): medusa/polyp/octopus → Codex line (astrobley r2 pattern);
  `/octo` card KILLED (pattern is now standard practice); the vendor-neutral guides
  (RUNBOOK/STATUS/PAD) are the one style source both runtimes consume = anti-divergence keystone.
  DONE this session: Batch A — `/octo` killed across skill + all zsh surfaces (claude.zsh/keyboard/
  keys/README/palette.map/2 guides; zsh -n clean, no residual); Cartan handoff mail authored
  (`_mail/cartan/inbox/atlas.medusa-polyp-seat-transfer.2026-09-02.md` — created the inbox);
  drift-check standing note → `ia-sync/AGENTS.md`. Archive AUTHORED (astrobley-crossing precedent):
  index rows in `raw.substrate/archive/README.md` + legacy-wall entry (octopus family). Cartan
  CONFIRMED + landed Codex-native `ia-sync/codex/skills/{medusa,polyp,octopus}/` (commit `fa69ee0`,
  substantive, RUNBOOK/STATUS-reshaped, podocyst dropped Codex-side) → source-gap CLOSED, verified
  on disk. → `[2026-09-02 Octopus-family]` entry. OPEN (operator): (1) run cp deposit (5 files) +
  verify · (2) Batch B rm bed copies (medusa/polyp/sqcr/sea-pen/podocyst; KEEP session-handoff +
  track-run) · (3) `rm -rf ia-sync/claude/skills/octo/` · (4) add `raw.substrate/archive/` to
  `.rgignore` · (5) commit 3 repos + deploy.sh ia-sync. Batch C **FOLDED ON TABLE 2026-09-03** (staged, pre-deploy): medusa→@Flight (WIDE — temple/tactical
  kept + project-session working-head mode added, spine via pointers, `/runbook` by name, Assay-gate
  kept); polyp→@Vara (V-B POLYP — Edit-only, classifier retired, MANNED/UNMANNED, `/track-run`,
  Edit-append checkpoints, runbook-check DEFERRED to the runbook-GUIDE landing); `/track-run` promoted
  to the global table (guide-pointing). RETURN `_bus/01.fold.return.md`. OPEN: majkee deploy + prune
  stale-live (home `octo`); houston.md classifier-language line (head); Vara runbook-check = later cycle.
  *(head note: committed `028b448`; houston.md line REFUTED — no Vara ref there; VERDICT
  `_bus/01.head.verdict.md`.)* Batch D —
  advisor-ladder collapse plan (Houston 3a, pending #43083) · freya `ledger.md` Gen-1→Gen-2
  reconciliation (Houston 3b, now a Flight-project-mode/Codex-Medusa job) · taskexpert reader HELD
  spec-only (2–3-sitting bar) · shape-normalization arc (ia-sync/nablarva/applications-in-common,
  carried by Atlas/Houston = Opus, NOT Fable per majkee). C+D3 SPAWN-READY (majkee steer: redo
  the fold table against the archived substrate w/ wider explanation) → `_cold-start/card/
  CS.roster-trim-fold.2026-09-02.md` (gated on the mode-branch gavel).
- [ ] **Sella vault + atlas-ui workshop wiring — AUTHORED, handed to Oraculum 2026-09-01.** majkee:
  atlas-ui needs its own manual/workshop wiring (Sella-first + journaling + where it meets Cartan);
  promote Sella from `ia-sync/_staging/` → central `reposoma/raw.guides/sella/` vault. Eagle swept
  (19 files); dispositions gaveled (stubs-not-symlinks · move coder-guide+journal+src+receipts ·
  copy unikuklatrix Asymmetry · point raw.research+Cartan-obs+jacquard.toml · drop reconciliation-pad
  · codex-builder-user companion w/ Sella-wins-on-doctrine). AUTHORED + EXECUTED 2026-09-01:
  `raw.guides/sella/GUIDE.md` (header+manifest+body), `res/RUNBOOK.migration.2026-09-01.md`.
  @Trajectory ran STEP 0–10b in-session (Atlas drove; Oraculum-as-subagent was a dead-end — no
  Bash/Edit, can't spawn Delta): vault built (GUIDE·journal·src9·raw3·res), 13 stubs, Asymmetry
  copied w/ provenance, pad rm'd, source-map + BOTH anchors (atlas-ui + atlas-auto twin) inserted,
  NOTHING staged. Atlas reverted one over-broad STEP-7 edit (Trajectory rewrote a HISTORICAL
  git-status snapshot in journal.host-cleanup.md → restored; live source-map repoint kept). NOTE:
  wrapper/cards arc was ALREADY committed by majkee (tree clean of it) — no ordering tangle. DEPLOYED 2026-09-01:
  majkee committed + `deploy.sh`; anchors LIVE both creators (atlas-ui.md:81 + vault pointer :85 ·
  atlas-auto.md:52), Atlas verified live==table. Original ask CLOSED — fresh atlas self-navigates to
  Sella vault + workshop + Cartan meeting-point. CS card `_cold-start/card/CS.sella-vault-verify.
  2026-09-01.md` saved (dogfoods vault) for hand-spawning Oraculum. OPEN (handed off): Oraculum
  VERIFIES the vault vs runbook Done-when + carries Sella forward (Probe A/D/E; profiles G3-HELD) →
  drains the CS card to archive/. CARTAN NOTIFIED: session-final instruction
  authored `session/rellays-calude-codex/ATLAS-CARTAN-sella-mount.2026-09-01.md` (his mount: READ
  vault · DRAFT `_staging/codex/` · GRADUATE to vault · JOURNAL moved dev-journal; effective on
  reposoma push) + runbook STEP 12. → `[2026-09-01 Sella-vault]` entry + Sella LOG.
- [ ] **Relay quote-safety — ① DEPLOYED, unified wrapper-tune consult STAGED 2026-08-31.** ①
  (input-edge: contract §Prompt-passing + astrobley/vega/mirror snippets) DEPLOYED both boxes by
  majkee. Then majkee pulled in the Sella line: the SAME wrapper has open OUTPUT-edge hypotheses
  ("silent voice" no-usage stdout gap · Wave "jq + sync exec"). Unified into one Codex consult:
  `_staging/sella.codex-consult.wrapper-tune.2026-08-31.md` — master prompt for a hand-released
  interactive Codex to verify H1–H6 vs its own `--json` lifecycle + emit a tuned `codex-run.zsh`
  diff (stdin mode ② · jq extraction · usage surfacing). vega/mirror `maxTurns 3→4` staged (probe
  showed 3 too tight). CONSULT ANSWERED 2026-09-01 by @Cartan (`session/rellays-calude-codex/
  CARTAN-ATLAS-SUMMARY.md`): wrapper tabled (stdin+jq+stdout-usage, selftest 2/2), contract
  refined on disk. Atlas review = CONCUR + HOLD: Cartan's P0 retry-injection (model/timeout raw
  into `script -qfc` source) is a real pre-deploy gate. OPEN: (P0) ✅ CLOSED 2026-09-01
  — @Trajectory hardened retry (env→fixed-zsh literal, `${(qq)}`, SECURITY INVARIANT comment) +
  adversarial fixture; selftest 7/7 green, zsh -n clean, disk-verified by Atlas, table-only.
  · (P1) ✅ PASSED 2026-09-01 (majkee: deploy clean, byte-identical, live `codex-run -` probe
  echoed all 4 hazards byte-literal + clean `[usage:]` stdout line, 39→39 sessions = ephemeral
  held) · (B) ✅ DONE — Atlas aligned astrobley/vega/mirror transport snippets (stdin `-` form ·
  column-0 heredoc caveat · usage-is-final-stdout not stderr · foreground explicit; refusal
  contracts untouched) + column-0 note into contract · (C) guide 0.145→0.150.1 refresh parked.
  REMAINING: majkee 2nd small deploy of the task-B card + contract-note delta, then commit+push
  ia-sync for the whole session (wrapper+retry+contract+cards+selftest+maxTurns). → `[2026-09-01]`
  entry + Sella LOG.

- [ ] **Metaterminal seat — BUILT + STAGED 2026-08-28, deploy pending (majkee).** Oraculum's build
  request (`_mail/atlas/inbox/oraculum.metaterminal-seat.2026-08-25.md`) → new GLOBAL personal seat:
  majkee's "second terminal window with a soul" — human-invoked only, harness-free, Trajectory-grade
  judgment, owns the `ia-sync/zsh` source ↔ deployed `~/.config/zsh` ↔ mux ↔ TTY ↔ agent-surface drift
  stack. **Reclassified structural** (majkee gavel): L6 clause-2 (structural → surgical table) not
  clause-1 (experimental shape → nablarva bench). File: `~/ia-sync/claude/agents/metaterminal.md`,
  sonnet/high, no Agent tool. **Non-spawnable = HARD via one-line `permissions.deny: Agent(metaterminal)`**
  on the table (Cartan's cheaper native mechanism — "disable specific subagents"; reversible if majkee
  later publishes it for spawning). **Cartan blind-triangulation folded** (via majkee's hand-paste after
  the @mirror relay bug): converged on agent-not-skill (settles the Trajectory doubt), sonnet/high, lean,
  never-delete, phone-cards. Its read-only-tools push **rejected** — majkee needs it to AUTHOR PTY/tmux
  monitoring + quarantine scripts. Final shape: **standalone (composite/Codex-relay DEFERRED — Foreman
  floor)** · Write confined **by discipline** to `/tmp/metaterminal-<run>/` (ephemeral self-destruct;
  keepers graduate via mail-the-temple) · discipline-not-hook confinement. Guardrails kept (no deploy ·
  no gated `temple-*`/0009 · two-phase quarantine never auto-delete · host-state local · phone output).
  Oraculum RETURN note sent (`_mail/oraculum/inbox/atlas.metaterminal-reclassified-structural.2026-08-28.md`).
  → `[2026-08-28 Metaterminal]` entry. OPEN: (1) majkee deploy + commit/push · (2) optional: majkee
  run Codex directly for the verdict that likely sits on disk · (3) ⚠ **codex-relay QUOTE-COLLISION
  BUG — real root cause** (majkee caught 2026-08-28): prompts with inner `"`/`'` break the shell arg
  when a relay seat wraps them as `codex-run "…"`; the seat then burns its turn budget fighting the
  quoting (the 3-turn cap only left no room to recover — it was NOT the cause). Fix = pass prompt via
  stdin/heredoc (`<<'EOF'`) or temp file, never an inline quoted arg. Hits @mirror/@vega/@astrobley +
  `codex-relay.contract.md` + `codex-run` wrapper — Kelvin/Cartan infra fix, brief scopeable on ask.
  (Supersedes the earlier "turn-cap" theory logged same entry.)

- [x] **atlas-ui read-only Bash — SHIPPED + CONVERGED BOTH MACHINES 2026-08-28.** Runbook
  `_runbook/ia-sync/atlas-bash/` consumed → folded into the seat. atlas-ui `tools:` += `Bash`;
  new `## Read-only Bash contract` section (verify-only: `git rev-parse/status/log/diff`, `ls`,
  `wc`; refuses write-side git / `deploy.sh` / `push` / `ssh`); `settings.json` `allow` += `git
  rev-parse` · `ls` · `wc`. Gate preserved by the global permission filter (write-side not in allow →
  `ask` prompt, not silent exec — confirmed no per-agent scoping exists, claude-code-guide). atlas-auto
  left Bash-free (no human to answer the gate). Runbook folder DELETED (@Delta, verified gone).
  → `[2026-08-28]` entry. majkee deployed + pushed alongside office work; both boxes converged. LIVE.
  (Graduates out at next ledger roll.)
- [x] **Cold-start vault thread — CLOSED 2026-08-28.** Home pulled+deployed by majkee, tested
  fine — last open item done. Full arc in the entries below + `raw.guides/cold-start-card/`
  (GUIDE + journal). Closure card: `_cold-start/card/CS.o-rep-atl-fab-ccard.2026-08-28.md`.
  Residual micro-seeds live in journal.md only (capture-script ~-paths · D3 runbook brick). Vault + guide law +
  both-brand skills LIVE this box (→ `[2026-08-27]` entry; status/runbook canon reconciled —
  STATUS name surrendered, one-authority card boundary absorbed). Delta executed under majkee's
  "go on it": 22 legacy `CS.*` → `archive/` (23 at 08-27 glob — 1 drained in between, benign) ·
  tombstones git-rm'd · reposoma `6f002a3` pushed · ia-sync `fae1362` + rebase over 5 home
  commits → `da69045` pushed · deploy.sh ran ×2, live skill verified (5× `_cold-start`).
  HOME CONVERGED 2026-08-28 (Delta over tailscale, ff-only + deploy: both HEADs match, live skill
  5×, archive 22, first-citizen card present — 1:1 verified). PHASE-2 SHIPPED 2026-08-28:
  Trajectory built cs-palette + temple-cs-manage + cs_vault.py on table, wired per house law;
  blessing cold-start 14/14 ALL PASS (majkee gavel) → office deploy + push released;
  first-citizen card drained to archive (first full self-lifecycle: write → brief its own build →
  D3 reveals its prompt-0 → drain). ⚠ HOME LEG NOW MAJKEE'S OWN — stashed work there, he controls
  pull/deploy; do NOT remote-converge again without his release. CODEX SMOKE PASS 2026-08-28 (@Cartan:
  shared contract + prompt-0 + cs_vault parser + real D3 render all green cross-brand; friction:
  extras-separator convention settled, capture script emits literal /home paths — micro-item;
  smoke card drained). OPEN: (1) majkee: home pull +
  deploy post-Phase-2 · (2) ~~Codex smoke~~ PASS — findings
  into journal.md · (4) Proxima/majkee refresh `GEMINI.md` (§cold-start path + retired RUNBOOK
  `state:` field).
- [ ] **Guides-unification thread — SUBSTANTIALLY CLOSED 2026-08-20.** B′ + skill-model
  slugs + manifest law all gaveled; 9 slugs live; `/guide` skill + stub DEPLOYED BOTH
  BOXES (ia-sync `329ece4` · reposoma `93e542f`); both-host cleanup done (office Delta +
  cross-host Delta under operator voice directive). **🔫 rogue-file theory CONFIRMED:
  retired `ai.md` (2026-07-11) found squatting on home — left as evidence, majkee
  disposition pending.** Remaining tail: ai.md word · P4b small guards (ia-sync README
  line, deploy.sh guides-leg review) · P5 lingerer-audit parked (ai.md = evidence #1).
  Journal: `~/ia-sync/_staging/dev-journal.guides.md`. Standing blessing: every emitted
  document carries YAML frontmatter. @mirror first live fire: SUCCESS. Session
  `REP.Offc.Atlas-fable.guides`.
- [ ] **Prove the ledger shape over a few saddles** — does eviction-on-close hold, does the square
  stay honest? (restructure · step 2.)
- [ ] **Roll the ledger shape to the other pulses IF it works** — offer OPEN LEDGER + archive-roll
  to Houston/Flight for `pulse.claude.md` / `pulse.flight.md` (they own theirs). *"If it works,
  apply everywhere" lives HERE so it can't orphan.* (step 3.)
- [ ] **Read-only `ai/` pulse-audit reporter — DEFERRED** — build ONLY when the manual cross-pulse
  audit hurts (N≥3 pulses). Scans every `pulse.*.md` OPEN LEDGER, lists unticked + age; agent
  adjudicates. Surgical table `ia-sync/zsh/ai/` → `~/.config/zsh/ai/`. NO write-side tooling, NO
  JSON, never automates the verdict. (step 4.)
- [ ] **Back-audit the older `STILL OPEN` lines below** — pre-restructure entries carry unmigrated
  open items (surgical-table deploy, Sella probes A/D/E, codex live-leftover deletes, phone→
  media-harvest transport gap, therapy arc 13, inbox `houston.defer-advisor-high-fable-paygo`
  unread…). Adjudicate each orphan-vs-real-vs-stale on a dedicated pass; promote the live ones up
  here. (migration debt — not done now to avoid importing stale items as false-live signal.)
- [ ] **majkee: commit + push reposoma** — carries this restructure + `raw.guides/PAD/pad-builder.md`
  live (my seat has no Bash). → `[2026-08-07 PAD]` entry.

---

## [2026-09-03 Codex-app fan-out] — silent `.codex/` over-control across project working trees; ia-sync CLEAN

**Trigger.** majkee recognised in another repo a "desktop Codex application move" that duplicated
Claude agents into project TOMLs — silent over-control from the app — and asked me to check whether
it reached HERE too, smooth the dirt, and leave a reconstruction-grade log. I hold READ-ONLY Bash:
I mapped + logged; I did NOT delete. Cleanup is a write-side step (Codex buddy or operator).

**Signature (the app's fingerprint).** A uniform mtime **`2026-08-26 23:01`** across four repos —
one bulk write/re-serialise the Codex desktop app performed over every project `.codex/` it had
indexed, regardless of whether the agent belongs to that project. The tell: **medusa/polyp landed
in freya**, a Laravel devstudio that has no session-orchestrator seats.

**Scope map (verified 2026-09-03):**

| repo · branch | `.codex/` payload (Aug-26 23:01 unless noted) | tracked? | propagation |
|---|---|---|---|
| reposoma · core | `agents/delta-sql.toml` | **TRACKED** (committed `7dd6b02 home->office`) | **pulls to office** |
| applications-in-common · core | `agents/{vara,medusa,polyp}.toml` + `hooks.json` | **TRACKED** (committed `8151641`, **already on origin/core**) | **already pushed** |
| fantasyobchod · master | `agents/{medusa,polyp}.toml` + `hooks.json` (delta-sql = LEGIT, hold — SQL project) | untracked, **NOT ignored** | local-only unless `git add` |
| freya · majkee/pre-develop | `agents/{medusa,polyp}.toml` (+ `{assay,keystone,phonon,voyager}` Aug-21 = legit) | ignored via `.git/info/exclude` | local-only |

**Cartan's space is CLEAN.** `ia-sync/codex/agents/` mtimes are Aug-24 (architect·challenger·
harness_builder·implementer·researcher·verifier) + Sep-2 (astrobley) — the Aug-26 app fingerprint
NEVER touched ia-sync. `_staging/` + `_staging/codex/` clean (jacquard.toml, Cartan observations).
The app reached only into *project working trees*, not the authored surgical table.

**Canonical truth the dirt is stale against.**
- medusa/polyp/octopus **crossed to Codex as SKILLS** → `ia-sync/codex/skills/{medusa,polyp,octopus}/`
  (Cartan-reshaped, commit `fa69ee0`, decision `[2026-09-02 Octopus-family]`). The scattered
  `.codex/agents/{medusa,polyp}.toml` are the **superseded pre-crossing agent-form = orphan.**
- vara **crossed back to Claude** → `.claude/agents/vara.md` (roster-reform-01-triad). The
  `.codex/agents/vara.toml` is the old Codex form; applications-in-common IS its pilot bed, so this
  one is a **majkee call**, not blind dirt.
- delta-sql belongs to SQL projects (fantasyobchod), NOT the temple root — `reposoma/.codex/agents/
  delta-sql.toml` is misplaced.

**Disposition (for the Codex buddy / operator — write-side):**
1. PURGE as superseded: every `.codex/agents/{medusa,polyp}.toml` (canonical home is
   `ia-sync/codex/skills/`); `reposoma/.codex/agents/delta-sql.toml` (misplaced at temple root).
2. RECONCILE not purge: `applications-in-common/.codex/agents/vara.toml` vs `.claude/agents/vara.md`
   — pilot bed, majkee decides which form survives.
3. ROOT-CAUSE FIX (stops recurrence + propagation): add `.codex/` to `.gitignore` in **reposoma**
   and **applications-in-common** — the two that TRACK it. freya already ignores via
   `.git/info/exclude`; **fantasyobchod does NOT ignore — merely untracked** (a `git add` would
   pull it in) → it also needs the ignore line. CAVEAT (Cartan): gitignore does NOT protect the
   ALREADY-tracked files (appl-in-common vara.toml + hooks.json) from future app rewrites — those
   need `git rm --cached` once majkee rules on them.
4. URGENCY: reposoma's delta-sql + applications-in-common's set are already committed (the latter
   already on origin/core) — they WILL reach office on next pull. Clean before that pull, or office
   inherits the app's over-control.

**CARTAN CROSS-VENDOR VERIFY (2026-09-04, tunnel thread, readOnly sandbox).** Independent audit of
the inventory against live repos. Corrections folded above: (a) fantasyobchod NOT ignored, just
untracked; (b) fantasyobchod `delta-sql.toml` is LEGIT (fa69ee0 superseded medusa/polyp/octopus only;
delta-sql belongs in SQL projects) → HOLD, only reposoma's temple-root delta-sql is misplaced.
Cartan emitted a paste-ready cleanup script (clean-tree guard · pull --rebase · git rm · gitignore ·
commit · push for reposoma + appl-in-common; local `rm` only for fantasyobchod [no commit to master]
+ freya, with legit-seat survival asserts). Execution is write-side → operator or @Delta, NOT my seat.
NOTE: my own pulse.atlas.md edit makes reposoma's tree dirty → the script's clean-tree guard will
halt reposoma until this incident-log commit lands first.

---

## [2026-09-03 Octopus-family Batch C — fold on table]
*(fold seat's text, folded verbatim by the head per the roster-reform-01-triad pen contract)*
Inside gate `roster-reform-01-triad` (fold seat, under atlas-ui·head). @majkee gaveled live:
Flight-first · V-B for Vara · Edit-append checkpoints. Drew on the surgical table (deploy-inert):
**flight.md** — project-session mode (Medusa folded home) as a *venue* on top of MANNED/UNMANNED;
phase spine points at shared skills, never inlines; Assay-gate-per-kraken kept (Flight's old gap);
planning-head pointed by NAME `/runbook`; @Vara re-described as pre-routed walker. **vara.md** —
reshaped to POLYP walker: Write dropped, Edit-only append checkpoints, classifier retired, case-switch
track→/track-run · PAD→PAD-guide, runbook-check left as a deferred pointer (8 detection rules from
the larva.dev specimen land with the runbook GUIDE). **skills/track-run/** — promoted from the
applications-in-common bed, guide-pointing. Style kept in the vendor-neutral guides
(runbook/status/PAD/bus) — anti-divergence keystone held; nothing duplicated against the Codex
renderings. @field ran two passes (harness coverage map + runbook-shaped consolidation) — held for
Batch D / roster-reform-02 (advisor collapse: 2-seat opus+fable deployable now, 1-seat needs #43083).
Staged, not live: majkee deploys + prunes; houston.md classifier line is the head's.

---

## [2026-09-02 Octopus-family] — medusa/polyp/octopus crossed to Codex; `/octo` killed; roster trimmed

Session `fc.repos-atlas-opus.polyp-medusa` (home, Opus/1M). Menu pointed me at
`oraculum.medusa-polyp-qualification.2026-09-02.md`. In saddle also boarded 2 Houston mails
(ladder-principle · task-holding-and-unfinished-business).

**The arc.** majkee cleaning the Claude roster — too many seats go orphaned when the nuance
between them is small. Assessed the fold direction with medusa/polyp/flight/vara runtimes open,
plus the vendor-neutral guides. Conclusion that stuck (majkee gaveled through 6 turns):
- **medusa/polyp/octopus → Codex line**, not promoted to the Claude table. Offered whole/as-is;
  @Cartan reshaped Codex-native (astrobley r2 precedent). Landed `ia-sync/codex/skills/
  {medusa,polyp,octopus}/` commit `fa69ee0` — medusa=working-head, polyp=PAD-driver, octopus=
  planning-head; program.pulse→RUNBOOK/STATUS authority, stream/journal dropped, podocyst dropped
  (Codex compacts natively), boot not promoted (all 4 Cartan reshape notes honored). Verified on
  disk before greenlighting any deletion (Cartan's "acceptance cannot become a source gap").
- **`/octo` card KILLED** — the pattern (expensive head + cheap tentacles) is now standard
  practice; a card describing what everyone does earns nothing.
- **The keystone insight:** the generic sequential-work style lives ONCE in the guides
  (`raw.guides/{runbook,status,PAD}` — vendor-agnostic, Cartan-cosigned 2026-08-27). A Codex
  polyp and a Claude vara consume the SAME law → they cannot drift. Anti-divergence is
  structural, not held by parallel seats. This is what freed the roster-trim.

**Batch A DONE (surgical table, deploy-inert).** `/octo` removed across skill dir (rm handed to
operator) + every zsh surface (`ai/claude.zsh` `_octo` body+help+comment · `keyboard.zsh` alias+P13
→ metaterminal-only · `keys.zsh` · `ai/README.md` · `palette.map` · `guides/guide-for-builder.md`
recipe re-pointed to ai-metaterminal + engine inventory · `guides/keyboard.md`); zsh -n clean, zero
residual octo (doctor false-positives excluded). Cartan handoff mail authored (created
`_mail/cartan/inbox/` — didn't exist; corrected OFF `_staging/codex/` = Cartan-only turf per
HANDSHAKE:47). Drift-check standing note → `ia-sync/AGENTS.md` (scope = seat-wiring only, since
style lives in guides).

**Archive AUTHORED (recovery net before removal, astrobley-crossing precedent).**
`raw.substrate/archive/README.md` index += 5 rows (medusa/polyp/sqcr/sea-pen/podocyst,
`.codex-crossing` fate) + legacy-wall entry "the octopus family" (name·lived·died-of·inheritance·
epitaph). HARVEST-BEFORE-REMOVE: operator runs cp deposit + verify, THEN Batch B rm.

**Doctrine held:** read-only Bash throughout — authored via Edit/Write; never ran rm/cp/deploy
(all handed to operator). Nothing committed/deployed — my line.

**OPEN → operator:** cp deposit (5) + verify · Batch B rm bed copies (KEEP session-handoff +
track-run) · `rm -rf ia-sync/claude/skills/octo/` · `.rgignore` the archive · commit 3 repos +
deploy ia-sync · archive the 3 consumed inbox mails.
**OPEN → build (majkee gavel pending):** Batch C fold medusa→Flight, polyp→Vara **WIDE not
temple-locked** (temple-only = separate 'dice' monk if ever) + promote `/track-run` + vara guide
pointers; Batch D advisor-ladder collapse plan (pending #43083) · freya `ledger.md` Gen-1→Gen-2
recon · taskexpert HELD spec-only · normalization arc (Atlas/Houston=Opus, not Fable).

---

## [2026-08-31] — RELAY QUOTE-SAFETY: composite-prompt break/injection closed (rule ①) + wrapper brief (②)

**Origin:** majkee (interactive) — for all claude(codex) composites, briefs are relayed as a
master prompt in "double apostrophes"; inner backticks or accidentally doubled apostrophes break
the primary prompt. Wanted a relay-spec rule + a Bash-seat wrapper fix. Seats named: astrobley,
mirror, vega.

**Diagnosis (corrected majkee's framing):** the wrapper `codex-run.zsh` is NOT the bug — it reads
the prompt as `$1` (inert string), first call `"$prompt"` safe, retry uses `printf '%q'`. The break
is one layer UP: when the agent composes the Bash command calling the wrapper. Double-quoting the
brief lets `` `...` ``/`$()` EXECUTE in the relay's own host shell (break + injection vector);
single-quoting breaks on a literal `'`. Existence check CLEAN — no quote rule anywhere in the
codex-relay family (metadata guide covers frontmatter/`!`-hydration/exit-codes only). Real gap.
**No new primitive** — edit to shared contract + 3 agent bodies (Foreman-minimal).

**DELIVERED ① (surgical table, STAGED — not live until deploy):**
- `~/ia-sync/zsh/guides/codex-relay.contract.md` — new §"Prompt-passing discipline (quote safety)":
  never double-quote the brief · PREFERRED single-quoted-delimiter heredoc `"$(cat <<'CDX_PROMPT'
  … CDX_PROMPT\n)"` (works with today's wrapper, closes the vuln) · FALLBACK single-quote +
  `'\''`-escape · ties to the VERBATIM input-edge contract.
- `~/ia-sync/claude/agents/{astrobley,mirror,vega}.md` — matching compact quote-safety snippet in
  each Plumbing section (self-contained-if-contract-unreachable pattern).

**DELIVERED ② (handoff, NOT authored/tested by me — no Bash-execute):**
- `~/reposoma/_mail/flight/inbox/atlas.codex-run-stdin-mode.2026-08-31.md` — brief for a native
  `-`/`--stdin` wrapper mode (`prompt="$(cat)"` slurp first, keep `< /dev/null`, keep positional
  back-compat). Reinforcement/legibility only; needs Bash-seat author + fresh-Codex verify per
  ia-sync AGENTS.md. Priority LOW — ① already closes the vulnerability. **Routed to Flight**
  (majkee prefers it over Kelvin, tests live); the earlier `_mail/kelvin/inbox/` copy is
  SUPERSEDED — droppable.

**STILL OPEN:** (1) majkee `bash ~/ia-sync/deploy.sh` + commit/push ia-sync → ① goes live both
boxes (don't `sync.sh` before deploy) · (2) Flight builds + verifies ② live-with-majkee · (3) after
② lands, make the contract's stdin note non-conditional + repoint relay snippets to the `-` form.

## [2026-08-28 Metaterminal] — @Metaterminal built: majkee's "second terminal with a soul", reclassified structural → global

**Origin:** Oraculum build request `_mail/atlas/inbox/oraculum.metaterminal-seat.2026-08-25.md` (read
on majkee's explicit ask — mail-protocol consent). The gap: nobody holds the terminal stack as ONE
object. @Zenith-ZSH reads only the *deployed* `~/.config/zsh/` (blind to `ia-sync/zsh` source →
can't reason about source↔deployed drift); Kelvin/Maxwell own the per-machine deploy pipe. Unowned
span = source ↔ deployed ↔ mux ↔ TTY/process ↔ agent-surface (codex-run.zsh, exp-run, rc.sh). Native
object: **drift** (deploy.sh rsyncs without `--delete`, backs up without retention → deployed tree
accretes: 120 src vs 155 deployed, 37 orphans, 15 `.bak` exhaust, measured home 2026-08-25).

**Existence check (ran, clean):** no prior `metaterminal` build (only the request + a related
cold-start card). Adjacency confirmed non-redundant: Zenith-ZSH = read-only deployed RAG (Haiku,
coverage) vs Metaterminal = source-aware Write+Bash depth seat; Kelvin/Maxwell = execute deploy vs
Metaterminal = reason/audit/quarantine, never deploys. No collapse.

**THE GOVERNANCE MOVE — majkee reclassified it.** Oraculum routed it to the nablarva bench per flag
**L6 clause-1** (experimental agentive *shapes* build in nablarva). majkee ruled it a **structural,
operational seat** he drives live during development — his "second terminal window with a soul." L6's
OWN clause-2 (*structural builds stay on the surgical table `~/ia-sync/`*) then routes it to the table,
global. No lock overridden — the classification changed and L6 already covers both branches. Placement
GLOBAL (not the `~/.config/zsh/.claude/agents/` bond, which would hide it outside that tree — a
personal dev seat must be visible in any project dir).

**DELIVERED (surgical table, STAGED — deploy-inert):** `~/ia-sync/claude/agents/metaterminal.md` —
`sonnet`/high, tools `Read,Grep,Glob,Edit,Write,Bash` (NO Agent tool — doesn't delegate). Body is
self-complete (**harness-free regime**: no sit-in-saddle/pulse/canon startup; Trajectory-grade
judgment; the `.md` IS its whole contract). Covers domain, lane-vs-neighbours, can/should list,
must-nots (no deploy · no gated `temple-*` incl. `ai/base.zsh`/`adr-guard.*` per decision 0009 → mail
the temple · two-phase quarantine never auto-delete · host-state local), the filename-first paste-able
output contract (majkee drives from Termux, no TUI), and two opening case files (the drift audit +
`ai/base.zsh` prints-on-source violation). Baked constants carry a staleness pointer note.

**Non-spawnable — SOFT only, hook DROPPED.** majkee: "he should stay only for me... not overengineer.
If nobody else has reason, why gate it." Confirmed (claude-code-guide): NO native target-side flag
(`spawnable:false` doesn't exist); the only HARD mechanism is a global Agent-tool `PreToolUse` deny —
judged unnecessary overengineering (defends a non-existent threat). Enforcement = terse non-routing
description ("not a spawn target") + human-only body line.

**Open questions resolved (mine):** model sonnet/high · `sync.deny` = audits-not-owns · `zsh-orphans.zsh`
= recommend move to `ai/experimental/zsh-orphans/runner.zsh` (maintenance-seat action, not
Metaterminal's to run).

**Codex triangulation — ATTEMPTED, EXHAUSTED.** @mirror position-aware audit fired 3×; every attempt
died on its **3-turn cap** before returning a verdict (relay mechanics: locate wrapper → invoke →
wait → read → return exceeds the budget). The ORIGINAL run reached Codex and was mid-reading the
audit when it capped — a verdict likely sits on disk but is unrecoverable (no resume/SendMessage
exposed; fresh fires lose context; raw transcripts barred). majkee elected proceed (option 3); can
still paste the spec into Codex directly for the verdict. **⚠ @mirror turn-cap = real flagged finding**
(2nd session bitten; Sella relay had friction too) — candidate follow-up: raise mirror `maxTurns` or
shorten the codex-run step count.

**Oraculum RETURN note sent:** `_mail/oraculum/inbox/atlas.metaterminal-reclassified-structural.2026-08-28.md`.

**STILL OPEN:** majkee deploy + commit/push (table→live, no sync.sh in this flow) · optional Codex
verdict retrieval · @mirror turn-cap fix. Not live until `deploy.sh`.

---

## [2026-08-28] — atlas-ui gains READ-ONLY Bash: runbook consumed, seat + settings edited on table

**Origin:** majkee interactive — "read this runbook, think what we can add to the portfolio via
surgical table," then "after task completion let delta delete whole folder with runbook." Source:
`_runbook/ia-sync/atlas-bash/RUNBOOK.md` — my own prior split verdict on "Bash for atlas? YAY/NAY."

**The runbook's verdict (mine, now enacted):** YES to a narrow read-only whitelist (`git status/log/
rev-parse/diff`, `ls`, `wc`) — closes two documented gaps: the `commit:` card field ("leave for
majkee" because I can't `git rev-parse`) and the HANDOFF→STATUS rename tombstone litter (verification
friction). NO to write-side git (`commit`/`mv`/`rm`), `deploy.sh`, `push`, `ssh` — that is exactly
where the surgical-table gate lives; the tombstones came from write-side git, so I keep it out.

**Mechanism confirmed (claude-code-guide):** agent `.md` frontmatter has NO per-agent `permissions`
block — only `tools:` / `disallowedTools:` / `permissionMode:`. Bash command allow/deny patterns are
GLOBAL-ONLY in `settings.json`. So the gate can't be per-agent — it's the global filter: read-only
git already in `allow` (executes), write-side NOT in allow → falls to `ask` (a majkee prompt on this
human-present seat, acceptable). Rejected the guide's PreToolUse-hook alternative — more machinery
than the narrow gap justifies.

**DELIVERED (surgical table, STAGED — not live until deploy):**
- `~/ia-sync/claude/agents/atlas-ui.md` — `tools:` += `Bash`; new `## Read-only Bash contract`
  section (verify-only list + the four refusals + the "gate is what I refuse, not a missing tool"
  framing); fixed two stale "I have no Bash" lines (Layer-2 note + deploy step).
- `~/ia-sync/claude/settings.json` — `permissions.allow` += `Bash(git rev-parse:*)`, `Bash(ls:*)`,
  `Bash(wc:*)` (add-only hunk; benefits all agents, all read-only).
- **atlas-auto deliberately UNTOUCHED** — automated seat, no human to answer the `ask` gate → the
  missing-tool enforcement stays there.
- **NOT done:** no global `deny` on write-side git — would break Delta/Maxwell/Trajectory who need it.

**Runbook folder DELETED** (@Delta, `rm -rf _runbook/ia-sync/atlas-bash/`, verified gone; parent now
holds only cli-metadata-tracker / codex-tree-bus / ox-aplpha). Security-classifier flag on the
notification = generic `rm -rf` warning; action was exactly the scoped single-folder delete.

**STILL OPEN:** majkee deploys (`bash ~/ia-sync/deploy.sh` → commit/push ia-sync; office work landed
same time — settings.json add-only, should merge clean). Do NOT run `sync.sh` before deploy or the
stale live copies clobber these table edits. Read-only Bash is INERT on every seat until deploy runs.

---

## [2026-08-27] — COLD-START VAULT delivered: central `_cold-start/` + one law + both-brand skills rehomed

**Origin:** majkee interactive (`o-rep.atl-fab.ccard`, voice — "Starcard" = cold-start-card).
Ask: move card placement out of `_mail/monkey/inbox` into a proper bed; one CENTRAL vault (not
per-project — cross-project runs are the common case); frontmatter = source of truth incl. origin
project + whole paths; same shape for Claude AND Codex; palette browser like the mail/command
palettes. Sequential gavel turns; existence check fired (extend, not new build).

**DELIVERED:**
- **Vault (reposoma, git-tracked):** `_cold-start/{card,routines,archive}/` + 3-line README
  pointer + .gitkeeps. Folder = state (no `status:` key). `CS.<slug>.<date>.md` dated /
  `RT.<slug>.md` dateless; `kind:` = machine truth.
- **The law:** `raw.guides/cold-start-card/GUIDE.md` (B′-conformant slug; manifest section) —
  shared flat cross-brand frontmatter contract (incl. routing assessment `model`/`dedicated`/
  `recommend`, optional `runbook:` back-link), whole `~`-anchored paths (conscious REVERSAL of
  old "never absolute" cascade rule — gaveled), prompt grammar ADOPTED from runbook shape
  (`## prompt-0` → `###### prompt` → ```text — lifts verbatim card↔RUNBOOK, one revealer serves
  both), Codex brand-note in contract register, `## Wired surfaces` migration manifest
  (anti-Rube-Goldberg verdict: no registry machine — design-time checklist + temple-project-map
  carries location, only folder name is baked).
- **Journal:** `raw.guides/cold-start-card/res/HANDOFF.md` — 11 dated decisions w/ reasons +
  Phase-2 spec: `cs-palette` (D1 cards · D2 raw frontmatter · D3 prompt-0/runbook reveal;
  explorer-NOT-editor doctrine, keybinds hand off to $EDITOR) + `temple-cs-manage` (mail-manage
  grammar) + @Delta legacy migration plan.
- **Skills (surgical table):** `~/ia-sync/claude/skills/cold-start-card/SKILL.md` rewritten
  (vault target, contract, guide-wins pointer note) · `~/ia-sync/codex/skills/cold-start-card/
  SKILL.md` aligned (evidence discipline + bonded capture script KEPT; shared block first,
  codex extras below; vault default, project-local = explicit exception).

**STILL OPEN:** see OPEN LEDGER cold-start line — commit/deploy (majkee), Delta migration,
Phase-2 zsh pair, Codex smoke test, GEMINI.md repoint (Proxima's file — flagged, not edited).

---

## [2026-08-18] — laravel-daily-harvest W34 backfill processed (misdirected batch, absorbed)

**Origin:** majkee from phone (`REP.off.atlas-fable`) — pasted 2×12 Laravel Daily screenshots,
initially musing a "mobile harvest skill", then corrected: batches were meant for another seat;
asked me to file per local README. **NO new primitive built** — existence check fired:
`raw.research/laravel-daily-harvest/README.md` already IS the agent-agnostic recipe (the skill
he mused about). Foreman floor held.

**DELIVERED:** `report/raw.laravel-daily-harvest.2026-W34.md` (17 tip cards · 4 parked · 1 deduped
vs W33) + `index.md` row. Links via one bounded @Epoch pass (seat has no WebFetch): Boost PR #882
verified H · BindWhen = Laravel 13.22.0 + PHP 8.5-gated · ShouldDispatchAfterCommit docs anchor
confirmed · **NativePHP v4 "vs RN 0.86" benchmark numbers UNVERIFIABLE anywhere — parked with
do-not-cite flag** (numbers exist only on a photographed slide).

**Protocol captured in the report's run metadata:** pivot rule (last screen of final batch =
CMS-Architect/newsletter post = where this manual harvest ends; next harvest stops there) ·
screens arrived via CHAT PASTE, no PNGs in `harvest/2026-W34/` (I can't write binaries — disk
substrate stays majkee's drop). Answered "can you visit my phone?" honestly: no — ties to the
still-open phone→media-harvest transport gap (ledger).

**FOLLOW-UP (same session):** majkee named the owning seat = **freya**. Dropped intel note per
freya's own `_inbox` README: `freya/.dev/session/research/_inbox/laraveldaily-harvest-2026-W34.md`
(freya-relevant shortlist + pointer to full report; BindWhen flagged PHP-8.5-gated vs freya's 8.4;
pictures-as-files stated impossible again — chat paste only). Handoff prompt for the freya agent
given to majkee in-chat, THEN majkee pointed at the durable channel → written as
`freya/.dev/session/codex-claude/instructions.md` (Atlas → Medusa, house header style; triage
priorities + park list + substrate-honesty note; grants no plan/ledger authority).

**CLOSED [2026-08-19]:** pictures materialized + shipped — majkee ordered it; @Delta extracted
24 base64 images from this session's own JSONL transcript, decoded → `harvest/2026-W34/01–24.jpg`
(6.8MB, verified real JPEGs), scoped commit `6bd7240` pushed to origin/core. Home obtains via
`git pull` (git = the journaled lane, no tailscale ssh — 2026-08-01 discipline held). *Pattern
worth remembering: chat-pasted images ARE recoverable — session JSONL is the substrate.* Verbatim
home-Medusa handoff copy also given to majkee in-chat (freya `.dev/` doesn't cross machines).

**STILL OPEN:** freya `.dev` files (intel note + instructions.md) live on the office clone only —
majkee hand-carries or Medusa reconciles the `.dev/` transport (Cartan curvature gate 1).

---

## [2026-08-07] — PAD builder guide DELIVERED (general operator step-pad shape)

**Origin:** majkee (interactive, `atals.office.PAD-creator`) — build a "PAD creator", offered as
skill OR guide, asked me to pick; keep bureaucracy minimal (no orphan-file risk) but let the
PAD→log process breathe; **style must be general/common, NOT project scope**. Context source:
`applications-in-common/.dev/session/larvaTmux/` (pad.1-tap · pad.2-larva-studio · session.md ·
report.L1). Mid-run correction absorbed: **Polyp is project-local + testing-phase, NOT global** →
guide names no driver agent, says "the driver".

**PRIMITIVE CHOICE — guide over skill (majkee agreed).** Foreman: a guide is the canonical home
for a *shape/pattern*; a global `/pad` skill would need a file-drop target it can't own generally
(pads land in project `session/<slug>/`, governed by each project's OWN rules) → coupling + orphan
risk, exactly what majkee wanted to avoid. Guide writes nothing at runtime = zero orphan. Deferred:
a thin `/pad` skill later IF hand-authoring friction proves real (premature now).

**DELIVERED:** `raw.guides/PAD/pad-builder.md` — general pad-authoring guide. Anatomy (header +
optional driver-rules + shared constant + precondition + STEP 0 safety/state-check + STEP N with
copy-pasteable full-path command / expected output / branch verdicts / `>report N` empty fence +
trailing verdict-map/parked sinks). **The breathing rule captured:** the pad breathes into itself
(the empty ```` ```zsh ```` fence under each report = the raw run-log), then distilled verdicts
graduate to AT MOST ONE downstream log — *one raw surface + one distilled log, never a file per
step*. Orphan-safety baked (unran pad = just delete; moved pad = "safe to delete" stub). Placement
+ naming explicitly deferred to the consuming project's rules — guide owns SHAPE, project owns WHERE.

**SCOPE NOTE:** temple guide in `raw.guides/` — NOT a surgical-table primitive → syncs via normal
reposoma git, **no `deploy.sh`**. Sits beside `codex-line.builder.md` in the builder-guide family.

**Existence check (ran, clean):** no `pad` skill on table or live (30/30 scanned); no pad guide in
`raw.guides`. Project-local `applications-in-common/.claude/rules/20-sessions-pads.md` holds pad
*rules* + `.claude/skills/{sqcr,sea-pen}` *run* pads — none CREATE a pad; global gap real.

**STILL OPEN:** (1) majkee commit/push reposoma (my seat has no Bash) · (2) optional follow-on:
thin `/pad` skill pointing at this guide, only if authoring friction shows up.

---

## [2026-08-03→05] — SELLA CROSS-VENDOR SESSION: Wave loop → errata → gavels → Probe B closed

**The whole line ran in one session** (`atlas.office.paralele-sella-builder`). Trace + state:
**`~/ia-sync/_staging/dev-journal.sella.md` — READ ITS HANDOFF FIRST, it outranks this entry.**

**Arc:** Wave's radio (disputed hypothesis: Sella → thin core + vendor profiles) → my Epoch
primary-source Codex receipt (`sella.receipt.codex.2026-08-03.md`) → architecture candidate
(2026-08-04) → Wave's formal audit: CONDITIONAL PASS, 5 findings → my errata-r1 (all 5
accepted; A3 demoted to experiment branch vs the real rival B1 = Claude-only + exchange
contract) → majkee ruled G1–G5 sequentially → **Probe B executed live and CLOSED**: Jacquard
(Wave's Codex agent) fixed the real ts-dash/lsof bug, reject→revise→accept on a
card-corrected contract, operator gate passed, fix surgically promoted to
`ia-sync/zsh/system/tailscale.zsh` (+ `&!` polish; `_ts_pull` was already table-side).

**Key rulings (G1–G5):** layered shape adopted provisionally, probe-gated · home at
promotion = `reposoma/raw.guides/` (core + profiles) + ONE sentinel card
`raw.settings/raw.card.sella.md` on the stale-mail cycle · ferry `schema: 1` STRIPPED
(FLAG-1 closed, executed) · guide retitle HELD until a real profile candidate exists ·
probes released B→A→D · Sella name confirmed.

**Load-bearing findings:** verifier-not-vocabulary hypothesis (both composition topologies'
value came from the independent verifier — Jacquard parent-REJECT · astrobley→assay; D/E
must test it) · environment-parity ceiling (agents validated in a world WITH lsof; operator's
world lacks it — the 2-line operator diagnostic beat both AI runs to root cause) ·
model-adopted ≠ harness-applied instructions (Codex REPORT 0 reported judgment as mechanics) ·
J1: Codex project-local agent discovery works WITHOUT a git root (receipt, codex-cli 0.145.0).

**DELIVERED (all `_staging/`, deploy-inert):** dev-journal.sella.md (drop-place + log, pattern
adopted by Houston for astrobley) · receipt.codex · architecture.candidate 08-04 (history,
untouched) · errata-r1 · observation.jacquard 08-05 · jacquard.toml (staged copy) · table
edits: ferry schema-strip + tailscale.zsh fix. Old observation file → tombstone (needs git rm).

**STILL OPEN:** (1) probes A · D · E (operator releases; D/E decide B1-vs-B2) · (2) profile
candidates + core extraction only AFTER probes (no v2 written — Wave's gate held) ·
(3) E3 URL-fact one-fetch · (4) parked micro-probe: AGENTS.md quote-test · (5) majkee deploy
+ push (tailscale fix, ferry, staging batch) · (6) cleanup in `~/.config/zsh`: .bak-jacquard,
task card · (7) therapy arc 13 OPEN (G-33; "next step" majkee-pending) · (8) tombstone git rm.

---

## [2026-08-03] — SELLA conformance review + atlas-office observation staged

**Origin:** majkee — the 08-01 philosophy "went a little far" and matured into **Sella**
(`ia-sync/_staging/sella.coder-guide.md`, DRAFT) — a discipline-language for CC primitives
(agents=programs, skills=methods, harness=OS; premise: the compiler is stochastic). Plus a real
build **@ferry** (`ia-sync/claude/agents/ferry.md`, LIVE) — office→home tailscale cascade conductor,
graded G0–G4 exit ladder. majkee asked: do they MEET the philosophy?

**VERDICT: yes, stronger than expected — the ADVERSARIAL corrections propagated, not just the claims.**
Sella L2 = D1′ *corrected* (absorbed Janus's category-error fix — examples live INSIDE the description
field, so "only if they earn routing lift," NOT "relocate them"). Sella L8 = D2′ *corrected* (dropped
the per-run model-pin = Janus's reproducibility-theater REVISE; receipts/pilots/gavels replace it).
@ferry is a clean exemplar: terse no-example desc, minimal tools no-Write, exit-ladder legibility,
judgment-here/mechanism-there, vendor-invariant, L8-as-behavior (`fetch-real-first`, each leg re-verifies).

**DELIVERED:** `ia-sync/_staging/sella.observation.atlas-office-2026-08-03.md` — my conformance
observation, Sella-conforming (dogfoods its own provenance-stone header). Two flags + one open:
- **FLAG-1:** `schema: 1` in ferry CONTRADICTS Sella — §2 key surface omits it, Epoch receipt says
  "no `schema` key exists (forward-marker only)," Walk-A gate forbids invented keys. The language's
  first program trips its own gate. Resolve before ferry deploys as reference: bless `schema` as a
  house forward-marker OR strip it. (= STUDY-2 tension #5 half-surviving.)
- **FLAG-2 (watch):** Sella is 380 lines / nine laws — its own arch study warns against bloat. Keep
  it a HUMAN guide; agents conform via terse anchor, not by loading all nine laws. L9/L2 at meta level.
- **OPEN:** agent-description budget still UNRESOLVED (Epoch receipt claim 2) → L2 is CONFIDENCE-M for
  agents until the `subagent_type` serialization pass closes M→H. Same gap flagged 08-01, honestly marked.

**HEADS-UP (majkee's parallel move):** he's authoring a Codex-line instructions block / Sella-equivalent
for the GPT line. Left a `next[]` pointer in the observation file to cross-reference when it lands.

**STILL OPEN (this thread):** (1) majkee gavel on sella.coder-guide.md · (2) FLAG-1 resolution ·
(3) M→H Epoch pass · (4) codex-line language cross-ref.

---

## [2026-08-01] — WHY-RICH-FRONTMATTER research fan-out + two agentive-doctrine seeds

**Origin:** majkee (interactive) — "why is Claude's agent-builder frontmatter so rich / what does it
do at cold start?" Explicitly wanted GROUNDED answers via spawned research, not training-data recall.
Plus two Socratic studies (arch/unix mind on this system) + placement guidance.

**MECHANICS CORRECTION applied:** his `epoch → spawn eagle` chain can't run (subagents can't spawn
subagents). Flattened to a 3-current PARALLEL fan-out from this main session: @eagle (internal corpus)
+ @epoch ×2 (web: frontmatter-routing · STUDY 2 arch mind).

**CONFIRMED (epoch #1, Anthropic's own words):** the `<example>`/third-person `description` richness
is a FEW-SHOT ROUTING MANUAL for the PARENT model's delegate decision — *"not documentation for a
human reader"* (source: `plugins/plugin-dev/skills/agent-development/examples/agent-creation-prompt.md`,
CONFIDENCE H). TWIST: the interactive `/agents` wizard was REMOVED v2.1.198 (2026-07-02) — so color.md's
rich style is the retired template's fingerprint, not a live UI builder. DIVERGENCE: plugin-dev template
(rich) vs mainline `sub-agents` docs (terse one-liners) — two official sources disagree.
⚠ OPEN (CONFIDENCE-M): subagent-description LOADING mechanism unverified — likely the `Agent`-tool
`subagent_type` schema, NOT a system-prompt block like skill metadata. My earlier "rides system prompt
~100 tok" synthesis CONFLATED the skill mechanic with the subagent mechanic — corrected in the report.

**CONVERGENCE (the load-bearing signal):** STUDY 2's #1 tension (verbose routing frontmatter = bloat
to a human) is Anthropic's OWN framing, arrived at independently by a decorrelated current. Two doctrines
rose: **D1** separate router-hints from human-docs in agent files · **D2** git-diff-clean ≠
behavior-identical, pin the model per run.

**DELIVERED (temple repo, written in place — not surgical-table, these are research/mail):**
- `raw.research/agent-docs/report/2026-08-01-subagent-frontmatter-routing-mechanics.md` — Q1 source
  backup (majkee ran `/refresh agent-docs` himself; this is the backstop evidence).
- `raw.research/arch/2026-08-01-arch-unix-mind-on-agent-primitives.md` — STUDY 2.
- `_mail/oraculum/inbox/atlas.agentive-doctrine-seed.2026-08-01.md` — D1/D2 seed, Oraculum audits first.
- `_mail/houston/inbox/atlas.agentive-doctrine-pointer.2026-08-01.md` — small pointer, codify later.
- @Janus spawned to adversarially test D1/D2 (verdict folds into Oraculum's audit).

**ROUTING (majkee gaveled, LOOSE loop):** Oraculum first reader/audit → Janus test → Houston codifies
into `temple/decisions/` on majkee's gavel, AFTER the temple cleaning ("burn ships"). My caveat baked in:
**D1 codification must wait on M→H** (close the loading-mechanism gap first); D2 safe to hold now.

**HEART / cold-start sourcing (majkee's "keep this in heart"):** the doctrine lives in THIS pulse
(interim held practice) until Houston codifies it into `temple/decisions/`, at which point my sourcing
repoints there. Named explicitly so the sourcing path is never ambiguous.

**JANUS VERDICT (landed, folded into Oraculum seed + Houston pointer):** caught a CATEGORY ERROR in my
D1 — the `<example>` blocks live INSIDE the `description:` field (color.md line 3, one escaped string),
NOT a cleaveable body section; "move them elsewhere" would push routing signal OUT of the field the
router reads. **D1 → STOP as worded** (footprint = 2/32 vestigial files; 30 already terse) → shrunk to
**D1′ convention note** (new agents terse, don't relocate, leave the 2 rich files till mechanism H).
**D2 → REVISE** (per-run model-pin = reproducibility theater) → shrunk to **D2′ one-line epistemic
guardrail**, no ledger field. Both now convention-weight, not heavy canon — recursively arch-minimal.

**STILL OPEN:** (1) Oraculum audit (reads Janus addendum first) · (2) Houston codification post-cleaning ·
(3) the M→H mechanism follow-up (one targeted epoch: how `subagent_type` schema serializes — governs
BOTH; if router reads only `description`, D1′ inverts) · (4) my inbox item
`houston.defer-advisor-high-fable-paygo.2026-07-07.md` still unread (not this run).

## [2026-08-01] — gemini ears-and-eyes: global role + local media-harvest drop-place (applications-in-common)

**Origin:** majkee direct — add multimedial (ears-and-eyes) context to
`~/www/elements-factory/applications-in-common/GEMINI.md`; asked for a few words on the office/home
machines + the Intuos CTH-680 tablet + a sw recommendation so drawings/handwriting reach agents as
files (not printscreen-to-JPG as with Xournal today). Spawned @Eagle (machines) + @Epoch (apps).

**majkee's steer (the design):** role is UNIVERSAL → global `~/.gemini/GEMINI.md`; the drop address
is LOCAL → project GEMINI.md. NO global leash — bond the seat to a `media-harvest/` folder in the
factory, addressed by the local file. Format-AGNOSTIC (also accepts phone photos of pencil/pastel),
because the seat's appetite for reading is large → the spatial leash (one folder) is the discipline.

**DELIVERED:**
- **Global role (surgical table):** `~/ia-sync/gemini/GEMINI.md` — NEW on the table (was legacy
  live-only, built 2026-07-16 before the table doctrine → migrated). Added `## My role — ears and
  eyes` (seat-agnostic, format-agnostic, appetite-leashed-to-drop-place) + `## The machines`
  (Manjaro/Wayland both; office i5-12400 / home Ryzen 5 3500U; pointer to machine card). Live
  `~/.gemini/GEMINI.md` edited identically (no drift). **⚠ NOT on home machine until deploy.**
- **Local address:** `applications-in-common/GEMINI.md` — added `## My drop-place` pointing to
  `media-harvest/`; role deferred to global. (Project-scoped file, syncs via app repo, NOT the table.)
- **Drop-place:** `applications-in-common/media-harvest/` + README (human-facing sw guide) + `.gitkeep`;
  `.gitignore` ignores contents, tracks README+.gitkeep (ephemeral drop, like `~/.remote/task.md`).

**sw answer (@Epoch, in the README):** digital handwriting → **Xournal++** with CLI export
(`xournalpp --create-img=out.png in.xopp` / `--create-pdf`) = the screenshot-killer, watchable via
`inotifywait`/`entr`; Rnote = nicer-on-Wayland alt but no CLI export. Physical → phone photo.
Structured diagrams → drawio (`--export`) or Excalidraw (`.excalidraw` JSON = agent-readable shapes+text).
Wayland gotcha: pressure-curve tuning limited under libinput (no `xsetwacom`) — irrelevant for
readable sketching; CLI export unaffected.

**STALE FACT FIXED (majkee flagged mid-session):** Gemini line reduced to **Orby + Bluebottle only**
(Vega + Astrobley vendor-shifted to Codex 2026-07-31 — see `_mail/houston/inbox/atlas.transition-1984-
codex-composites.2026-07-31.md` gavel 3). Global GEMINI.md "Active seats" line still listed 4 → corrected
to Orby (ears-and-eyes) + Bluebottle on both live + table. README de-named to "gemini eyes-and-ears seat".

**RESOLVED same session (majkee live-gaveled each step, both machines converged):**
- **Vega→Orby:** majkee gaveled the rename. Project GEMINI.md identity + confirm line → Orby (the
  canon Gemini ears-and-eyes seat). README de-named earlier now moot.
- **GUI pivot (majkee: "using xournal as window app, no bash experience"):** README rewritten
  click-first; NEW `media-harvest/pad.export-drawing.md` = larvaTmux-shape step-pad (File → Export As
  → PDF/PNG → drop folder → tell the seat). CLI demoted to optional footnote.
- **Deploy to home (Tailscale, I'm on office):** committed+pushed both repos; home pulled + deployed.
  Codex-composites converged on home as a bonus (closed a 2026-07-31 open item).
- **🐛 BUG 1 caught — deploy.sh skipped GEMINI.md.** deploy's `~/.gemini` leg copied agents/state/
  mcp/antigravity but NOT `GEMINI.md` → global file never reached home live. FIXED: added `GEMINI.md`
  to the `for f in state.json …` loop (`~/ia-sync/deploy.sh`, committed `71b39fd`). majkee gaveled the
  fix + blessed GEMINI.md-on-table. Future GEMINI.md changes now propagate automatically.
- **🐛 BUG 2 caught — my own .gitignore self-block.** `media-harvest/*` + `!README.md` + `!.gitkeep`
  silently ignored `pad.export-drawing.md`; the commit named the pad but git never staged it (home
  pulled everything BUT the pad). FIXED: rule → `!media-harvest/*.md` (docs track, artifacts ignored);
  pad committed `c3658af`, pulled to home. Lesson: write the gitignore exception WITH the file, or a
  later doc silently vanishes.
- **Home reconcile:** home carried a broken half-edit (`"I am  designer"`, Vega manually deleted) that
  blocked ff-pull → majkee's "pulled home, no data ???". Stashed (recoverable) → ff-pulled → converged.
- **FINAL STATE: both boxes 0/0.** Global GEMINI.md live on office+home; project Orby seat +
  media-harvest + pad on office+home. deploy.sh fix live on both.

**DISCIPLINE CORRECTION (majkee: hand-transport first accepted, then reversed → migrate via git
SYNC/DEPLOY).** Project GEMINI.md was first hand-committed to the APP repo + hand-pulled (worked, verified
identical). majkee then ruled to route it through the project's own `.devenv` surgical table after all —
his reasoning: **git diffs+messages are the journal/ladder; the Tailscale direct-tunnel deploy carries no
journaling.** Also flagged: my easy reach for cross-machine ssh = a fragile-process habit to curb.
- **MIGRATED (via @Delta, git-journaled, both boxes, deploy-LAST ordering):** authored
  `.devenv/claude/GEMINI.md` (byte-identical cp); `.devenv/deploy.sh` loop → `AGENTS.md CLAUDE.md
  GEMINI.md`; `.devenv/README.md` layout+table; app `.gitignore` += `GEMINI.md` + `git rm --cached`
  (untracked, now transported like AGENTS/CLAUDE). Commits: devenv `9551dc2`, app `f5ec8dc`. Deployed
  office + home; home sha256 `92f4a1ae…c524421` = office. Orby content intact both boxes.
- **🐛 HAZARD-B fixed permanently:** `.devenv/deploy.sh` resolves `MACHINE="${MACHINE_NAME:-$(hostname
  -s)}"` with NO machines.json fallback → over non-interactive ssh home's `MACHINE_NAME` is empty →
  hostname `hruzam` → not a registry key → deploy ERRORS. Fix: added hostname keys `hruzam` + `hruzam-120922`
  to `registry.json` (alongside logical `home`/`office`), so both resolution paths work. (This same gap
  would bite ANY non-interactive .devenv deploy — worth porting the machines.json fallback into this
  deploy.sh too, someday.)
- **Combinatoric hazard navigated:** `git rm --cached` means an app-repo pull DELETES working GEMINI.md
  on the far box until deploy restores it → deploy must run LAST on each machine. Held; transient-absence
  confirmed then restored on home.
- media-harvest stayed in the app repo (app-side working content, per README's `experiments/` precedent) —
  only GEMINI.md migrated.

**STILL OPEN:** (1) **Transport gap** — phone photo → `media-harvest/` on the box still needs a leg
(Syncthing/Tailscale/synced folder); not wired (Flight/infra territory). (2) No new primitive built —
folder + pointer + README + pad only (Foreman floor). (3) home stash@{0} holds the dead Vega-fragment —
droppable anytime (`git stash drop`), left as a safety net.

---

## [2026-07-31] — TRANSITION SESSION: codex composites named (Vega·Astrobley·Mirror) + Field born + BlueBottle claude-wiring 1984'd

**Directive:** `_mail/atlas/inbox/majkee.transitions.2026-07-31.md` (burn-the-ships process, majkee
live-gaveled every fork). ALL builds on the surgical table — deploy-inert until majkee's push.

**DELIVERED (table `~/ia-sync/claude/agents/`):** `vega.md` (ex codex-crosscheck — calibration-star
vignette, 0005 A1 seat name landed) · `astrobley.md` (ex codex-coder — Margaret Hamilton vignette,
chair vendor-shifted Gemini→Codex) · `mirror.md` NEW (Kontsevich, position-AWARE adversarial Codex
challenger — exact inverse of Vega's position-free refusal) · `field.md` NEW (Faraday, in-house
buffer/driller/melter/synth — BlueBottle successor; Faraday→Maxwell→Heaviside/@Vector lineage) ·
`epoch.md` runbook repointed (field/vega/mirror; bluebottle refs cut). `maxTurns` baked (3/3/6,
Epoch-verified field) · dead `.larva` fallbacks stripped (old W7 healed in the rename).

**Plumbing deduped:** `ia-sync/zsh/guides/codex-relay.contract.md` (canonical wrapper/exit-codes/
verbatim/never-block + labeled SAME-VENDOR FALLBACK law) + Epoch practitioner guide
`codex-relay.metadata-scripting.2026-07-31.md` (skill-vs-agent frontmatter split; `!` hydration is
SKILL-only → `/mirror` skill DEFERRED build-and-bruise; anti-rec: no `memory:` on blind relays).

**JANUS VERDICT (flipped my lean):** fold-Mirror-into-crosscheck REJECTED — codex-coder already
proves "same wrapper, opposite contract = separate seat"; two opposite refusal valves in one haiku
= undetectable mix-ups ("building the poison into the poison detector"). Dedupe plumbing, never
the contract. majkee accepted.

**ARCHIVE SECTOR established:** `raw.substrate/archive/` (grep-excluded, README = law) — verbatim
deposits: codex-coder, codex-crosscheck, gemini-cross-check (retired w/ provenance: Sonnet 1M
killed Gemini context edge). EAGLE AUDIT on record: BlueBottle = zero locks (safe); Astrobley/Vega
touch 0005 (Houston annotation asked); **Vector untouchable** (locked 0006/0008/0012 — Field built
instead of repurposing); Orby clean, stays Gemini ears-and-eyes; keyboard launchers UNTOUCHED.

**MAIL OUT:** `_mail/houston/inbox/atlas.transition-1984-codex-composites.2026-07-31.md` (ledger
gavels + 0005 annotations + roster/system-map asks) · `_mail/flight/inbox/atlas.office-1984-archive-
delete-list.2026-07-31.md` (office box: deploy-FIRST ordering, gemini-scope deletes, ⚠ zsh launcher
surgery PENDING — no bulk grep-delete on "vega", it's a live Claude seat now).

**ROUND 2 (same session, majkee follow-up gavels):** (a) vega.sh/astrobley.sh launchers ARCHIVED
verbatim (both were already PARKED behind the 2026-07-24 GEMINI_LINE_FORCE wall; astrobley's
`--patch` ledger protocol = the "inner git" over-engineering, preserved as specimen; NOTHING in
them needed by the Codex gates) → deleted from composer (Delta) · (b) table keyboard.zsh cut:
vega/astro shims + agy-astrobley removed, orby/bluebottle KEPT, model constants kept for engine
compat (comments retagged) · (c) guides audited: keyboard.md rows pruned, guide-for-builder.md
scope-shrunk banner (governs Orby/BlueBottle + future multimedia only; Codex authority =
codex-relay.contract.md — POINT, my fold decision: no fold, pointer instead) · zenith-zsh.md
launcher listing fixed · (d) **NAMING LAW gaveled: skill and agent must NEVER share a name** —
patched into Epoch's metadata guide (§e post-scriptum; `/mirror` skill FORBIDDEN under that name;
future entries: /stone-trial · /mirror-brief · /codex-task) · (e) Delta×2 dispatched: git ops
(composer rm, ~/.gemini/{vega,astrobley}.md harvest-mv, staging git mv, .rgignore — STAGE ONLY,
no commit) + live gemini-engine surgery (gemini-agents/processor/base: vega/astrobley blocks out,
orby/bluebottle intact, syntax-checked).

**DELTA REPORTS (both landed clean):** git-ops PASS — 12-file archive inventory complete, both
repos STAGED (no commit), orby/bluebottle + staging protected-list untouched, `.rgignore` created.
zsh-engine PASS — vega/astro blocks out of gemini-agents/processor/base, `zsh -n`+`bash -n` green,
orby/bluebottle wiring verified intact (13/12/5 refs), `_gai_*` helpers unchanged, retirement
comments in place. ⚠ two residual flags: (i) live `~/.config/zsh/ai/{vega,astrobley}.sh` still on
disk this box (composer copies rm'd; delete live AFTER deploy, same as office ordering) ·
(ii) engine retains an `epoch()`/agy-epoch Gemini function though keyboard.md P5 says that seat
was killed 2026-07-11 — pre-existing inconsistency, NOT touched, flag for a later hygiene pass.

**ROUND 3 (majkee released residuals 1+2):** Delta pass 3 CLEAN — live `vega.sh`/`astrobley.sh`
DELETED (archive existence verified first) · gemini-EPOCH residue house-cleaned: `epoch()` block +
`gemini-epoch`/`g-epoch` aliases harvested to `archive/2026-07-31.gemini-epoch-residue.sh` then
removed from all three engine files; BONUS FIND: `~/.gemini/agents/epoch.md` still existed (the
2026-07-11 kill left its agent file) → harvested-mv to archive. Syntax checks green (zsh -n ×3,
bash -n processor), orby/bluebottle intact, staged no-commit. Home zsh sphere is now FULLY clean.
Office email UPDATED same day: Step 3 rewritten — office mirrors the engine surgery (vega/astro +
epoch residue), deploy-first, no bulk grep on "vega".

**STILL OPEN:** (1) majkee: review staged → deploy+push → delete live `~/.claude/agents/
codex-{coder,crosscheck}.md` leftovers (ONLY remaining live-delete, after deploy) · (2) Houston
ledger + roster + 0005 annotations · (3) skill-side codex entry points deferred (naming law binds) ·
(4) office box runs `_mail/flight/inbox/atlas.office-1984-archive-delete-list.2026-07-31.md`.

---

## [2026-07-30] — GATE OPENED same session → BUILD HALF DELIVERED — ia-sync surgical table as the build output surface

**UPDATE (same session · majkee gate).** majkee opened the gate — instant blessing for all actions,
Houston bureaucracy (decision record) to follow later. Task sharpened: re-point my **build primitives**
so every GLOBAL primitive is authored onto the **surgical table (ia-sync composer)**, never the live
`~/.claude/` directly (direct edits left legacy litter + cross-machine drift — his stated motive).

**DELIVERED (edited ON the table — dogfoods the rule on its own carriers):**
`~/ia-sync/claude/agents/atlas-auto.md` + `atlas-ui.md` re-pointed. atlas-auto's default output moved
off the (deleted-today) `.larva/agents-staging/` → surgical table; atlas-ui's off direct `~/.claude/`
→ surgical table. New `## Output path — the surgical table` block in both: path map (agent/skill/
command/hook/zsh), deploy step (`bash ~/ia-sync/deploy.sh` → commit/push → other machine `git pull` +
`deploy.sh`), directionality caution (never `sync.sh` a not-yet-deployed file), and **project-scoped
stays unchanged** (project's own `.claude/`, syncs via its devenv — NOT the table).

**BUFFER DECISION (majkee delegated "you argue/pick") — 2026-07-30.** atlas-auto (autonomous) now
authors into a build buffer `~/ia-sync/_staging/` — git-tracked (recoverable from birth — the
structural cure for the `.larva/agents-staging/` "roughly deleted, no proof" loss majkee named), and
**deploy-INERT by construction**: `deploy.sh` only spreads `claude/{agents,skills,commands}/`, `gemini/`,
`majkee/`, `zsh/` — a top-level `_staging/` root is outside every leg, no deny-wiring needed. Promote =
`mv _staging/claude/agents/x.md → claude/agents/x.md` then deploy. **Picked ia-sync over temple space**:
temple = the litter failure mode `.larva/agents-staging/` already proved (orphan drop-folder in the
meta-repo); composer = where cuts belong. atlas-ui stays on the keep-set proper (human present = the
gate). atlas-auto.md rewritten on the table accordingly. ✅ `~/ia-sync/_staging/README.md` written — a
"stone of truth" carrying the story (the `.larva` deletion + precodex-agent loss), the flow, and the
HARVEST-BEFORE-REMOVE law; also gives the buffer dir a git-tracked presence + a "do not tidy away" guard. majkee's "tragical mistake" = deleting the
precodex agent with `.larva/agents-staging/`; Flight says rescuable on-table/git-history (unproven) →
harvest W1.

**⚠ NOT LIVE until deployed.** I authored on the table only (no Bash seat). The live
`~/.claude/agents/atlas-*.md` are unchanged until an operator/Bash seat runs `bash ~/ia-sync/deploy.sh`
+ commits/pushes ia-sync. Ordering: deploy (repo→live) must precede any `sync.sh` (live→repo) or the
stale live copy clobbers the table.

**STILL OPEN:** (1) deploy.sh run + push (majkee runs it — rides out with other staged surgical cuts) ·
(2) "eventually" — skills that shape harness/agents route through the table too — follow-on · (3) Houston
decision record (majkee owns the bureaucracy) · (4) session-end handoff doc/email to Houston.

**TRACE SWEEP (majkee ask: "what else can we leave trace?") — 2026-07-30:**
- ✅ **Agents CLEAN** — live 30 = table 30, exact match, no orphans.
- ⚠ **4 live-only SKILL orphans** (in `~/.claude/skills/`, NOT on table): `fetch-agent-docs` ·
  `fetch-ollama-docs` · `fetch-qwen-docs` → **RETIRE (majkee gaveled — legacy, superseded by global
  `/refresh`)**; readers confirm NO dangling refs to them in harness or raw.settings → clean delete.
  `claude-creator` → **RETIRE** (dead draft-only predecessor; its desc names dead `/atlas-agent-creator`
  + `atlas-agent-creator subagent`; pulse:1167 already marked it "ERASED 2026-07-15" yet it survived —
  litter). All 4 need @Delta `git rm` (no Bash in my seat).
- 🔗 **BIG "where else" — incomplete `claude-creator-*` → `atlas-*` RENAME migration** (readers + grep):
  · atlas-ui body `@atlas-sniffer` → `@Zenith` = **FIXED on table this pass** ·
  · `raw.settings/raw.card.autonomous-orchestrator.md` (6 refs) still `claude-creator-auto` → STALE CARD,
    refresh-cycle territory (re-synthesize, not hand-edit) ·
  · freya.devstudio (`houston-devstudio-architect.md` spawns `claude-creator-auto`; `flag.md`:110-120
    rename "queued one day") = CROSS-PROJECT migration, Houston/majkee gaveled — big, separate ·
  · `temple/roster.md`:54 "@AtlasAuto writes to staging" = stale echo → Houston.
- ⚠ **Legacy `raw.settings/agents-staging/`** = 4 FROZEN gemini Tier-S drafts (epoch/orby/astrobley/vega)
  + `README.md`:14 row. Distinct from the deleted `.larva/agents-staging/`. Gemini line frozen 2026-07-24
  → VERIFY promote-or-retire, Houston/Vega.
- ⚠ **Codex-line staging traces** (Flight): `raw.guides/codex-line.builder.md`:7 stale deploy path ·
  on-table `codex-coder.md`:38 + `codex-crosscheck.md`:41 `.larva/agents-staging/codex-run.zsh` fallback
  → points at deleted dir, WOULD DEPLOY STALE. Flag to Flight before/with the push.
- ✅ Harness core (reposoma AGENTS/CLAUDE/system-map/decisions/registry, `~/.config/zsh` AGENTS/CLAUDE)
  CLEAN — `~/.config/zsh/AGENTS.md`:3 already declares ia-sync = truth, this tree = deployed copy.
- ⚠ **Dangling `.larva/agents-staging/` fallback** in ON-TABLE `codex-coder.md`:38 + `codex-crosscheck.md`:41
  — points at the dir deleted today; `codex-run.zsh` now at `~/.config/zsh/ai/`. Would DEPLOY stale.
  Codex/Flight territory → FLAG, not mine to edit.
- ⚠ **Stale guide** `raw.guides/codex-line.builder.md`:7 names `.larva/agents-staging/` as staging+target.
  Codex/Flight territory → flag.
- ⚠ **Legacy `raw.settings/agents-staging/`** (`raw.settings/README.md`:14 row + `agents-staging/agy/`) —
  frozen gemini Tier-S staging. Houston/Vega territory → flag.
- ⚠ **Plan-of-record gap** — `ia-sync/session/plan/surgical-table.plan.md` (majkee's gaveled doctrine,
  2026-07-30) has NO atlas-builder item; my repoint is a faithful extension but UNTRACKED there. Must land
  a line in that plan + the Houston handoff, else it's a silent cut. (That plan's own items: 1 banner ·
  2 zenith-zsh repoint + `.deployed` stamp · 3 zsh AGENTS.md done · 4 codex leg · 5 `~/.majkee` leg.)

**SESSION CLOSED — Houston handoff dropped (majkee blessed):**
`_mail/houston/inbox/atlas.surgical-table-atlas-handoff.2026-07-31.md` — decisions 1–3 for his ledger
(atlas builders→table · buffer=ia-sync `_staging` · HARVEST-BEFORE-REMOVE), his harvest seats (W0/W6/W8
+ ledger locks), the proven recovery, and the open flags (deploy pending=majkee · codex `.larva` W7=Flight
· roster:54 W3). Everything recorded + reversible. Deploy = majkee's next act.

**HARVEST LAUNCHED (majkee: "1. oraculum · 2. ok · 3. fine → go") — 2026-07-30.**
- **Lead = @Oraculum** (majkee gaveled). Seed handoff written:
  `_mail/oraculum/inbox/atlas.harvest-plan-seed.2026-07-30.md` — W0–W8 table, HARVEST-BEFORE-REMOVE law,
  sequence (W0 gate → W1 heal-first → W3/4/5 parallel → W6/7 verify → W8 close), cast. Atlas = harness
  co-lead, Houston = gate/ledger. It's a SEED — Oraculum owns + reshapes.
- **W1 RESULT (@Delta):** the `.larva/agents-staging/` folder WAS fully git-tracked — nothing lost to
  gitignore. Last-live `d266726` → delete `a493cb4`. Inventory at deletion: `codex-coder.md`,
  `codex-crosscheck.md`, `codex-run.zsh` (all already moved/safe) + `gemini-subagents/{astrobley,orby,
  vega}.md` (June-19 frozen-line copies). **NO pre-codex agent found** at last-live state. 5 `.md` files
  recovered to `~/ia-sync/_staging/recovered/` for Oraculum. **The deletion lost nothing** — Flight's
  "rescuable on the table" claim PROVEN. ⚠ nuance: Delta checked the LAST-LIVE state, not the folder's
  full history — a "pre-codex" file could have lived + been removed in an EARLIER commit (different event
  than the 07-30 folder delete). Full-history archaeology offered to majkee, not yet run.
- **W1 PROOF (@Delta, majkee asked "experimental data which should be proved"):** all 6 files byte-perfect
  to git blob `d266726` (sha256 MATCH each: codex-coder `4ee83c44` · codex-crosscheck `5b8feac8` ·
  astrobley `ca953330` · orby `8553e449` · vega `ed98db65` · codex-run.zsh `4e0bbae`). "zag" = codex-run.zsh
  (live `~/.config/zsh/ai/` matches). GitHub durability CONFIRMED: `origin git@github.com:hruzam/reposoma.git`,
  commits `d266726` + `a493cb4` both on `origin/core` → "restored from GitHub" literally true. Table codex
  bed = identical to pre-deletion originals, zero divergence. **Nothing lost, byte-verified, durable.**
  Mistake fully reversible — proven.
- **Flight flagged:** `_mail/flight/inbox/atlas.codex-larva-fallback-deploy-stale.2026-07-30.md` — codex-coder:38
  + codex-crosscheck:41 `.larva` fallbacks + builder.md:7 = deploy-stale before majkee's push. = harvest W7.
- **Deploy:** majkee runs it (his cuts ride out together). atlas seats + `_staging/` stone go live on that push.

**majkee's intent (voice, captured):** make the **ia-sync layer the standing "surgical table /
composer"** for every surgical change to the harness (AGENTS.md et al.) or agent files — instead of
editing the live folders (`~/.claude/agents/`, `~/.config/zsh/`) directly. Edit lands IN ia-sync →
`deploy.sh` pushes it to its proper place on BOTH machines via git pull + deploy. Motive: one clean
update path, both boxes updated in sync (they're ~90% identical; the ~10% per-machine on/off toggles
give slightly different results — exactly what the table must absorb). Wants it **canonized
eventually** — "sooner or later," not today.

**NOT greenfield — already dogfooded today.** `maintenance/codex-line/note.staging-retired.2026-07-30.md`:
@Flight (MANNED) retired `.larva/agents-staging/` and moved the codex bed onto the surgical table —
`codex-coder.md`/`codex-crosscheck.md` → `ia-sync/claude/agents/` → `~/.claude/agents/`; `codex-run.zsh`
→ `ia-sync/zsh/ai/` → `~/.config/zsh/ai/`, both machines via git pull + `deploy.sh`. Term "surgical
table = ia-sync" is LIVE + one precedent exists. This capture = generalize that one-off mount into the
STANDING rule.

**Anchors:** `~/ia-sync/` (repo w/ sync.sh + deploy.sh) · `~/.config/zsh/ai/devenv-sync-core.sh`
(shared fn lib, lives in ia-sync backup scope) · sibling canon
`temple/decisions/0010-cross-machine-mail-transport.md` · scope precedent
`maintenance/sync_deploy/devenv-dry-refactor.2026-07-15.md` (advisor-advanced verdict: registry-driven
engine DEFERRED till projects ≥4–5 — that concerned project *devenvs*, DISTINCT from this harness/agent
layer, so the deferral does NOT bind this).

**Risk to raise when it goes active (my flag, not blocking):** source-of-truth. If edits route THROUGH
ia-sync and deploy OUT, ia-sync becomes authoritative and `~/.claude/agents/` etc. become DERIVED — but
today those are edited directly (my own build output path is `~/.claude/agents/<name>.md`). A direct
edit bypassing the table = silent drift. Canon must name which side is truth + how a bypass is caught
(`_devenv_deploy_guard` already stamps branch/HEAD mismatch — likely extend that). Same point-never-copy
tension.

**Routing:** temple-layer CANON → NOT mine to lock. I draft/capture; @majkee gavels; @Houston records
the decision (0010's sibling; likely a new decision record when ripe). Held here per majkee ("save to
your personal files, temporary"). **Open thread — surface next saddle.**

---

## [2026-07-27] — gavel family COLLAPSED 4→2: /gavel-loop absorbs ballot + qualify

**Origin:** majkee asked whether the gavel skills were overengineered and could be synthesized,
naming `/gavel-loop` as the intended "basic stone extended by process."

**Diagnosis (his, confirmed at file level):** the four skills were *phases of one instrument*, not
siblings — proliferated by misunderstanding, left running deliberately to observe what parallel
same-purpose skills would do. Observation is in.

**The load-bearing finding (majkee, field):** `/gavel-ballot`'s one-line render **structurally
cannot carry wider context**, so every run degenerated into extra dialogue loops asking "where did
this come from?" That pain is *why* gavel-loop's four-part block exists. Consequence: renders map
onto **classes**, not operator choice — formal → compressed audit table (no context needed, these
are retro-records); strategic → four-part block **with wider context by default**, never a one-liner.
This killed my first proposal (ballot as default entry, loop as escalation) — it re-created the pain.

**Second finding — gavel-loop was most advanced but NOT source-invariant.** Concrete coupling:
its Sources block instructed reading nabla-lab `session/flag.md` + `session/pulse.md` as truth
(dead path or foreign-project read when invoked elsewhere); class-split cited nabla-lab lock 18 as
authority; precondition vocabulary was lab research language. Ballot's scan ladder was already
invariant — grafted in as Phase 1 intake. G-19/G-20 pointers are temple canon, NOT coupling — kept.

**DELIVERED (`~/.claude/skills/gavel-loop/SKILL.md`, rewritten in place, ~195 lines from 263 raw):**
Five phases — P0 precondition (G-19) · P1 intake scan ladder · P2 qualify (binary default, 8Q as a
gate you *fall into* on doubt, not walk through — preserves speed) · P3 render (two lanes by class)
· P4 stamp (gavel/amend/park + G-20 reopen) · P5 record (ledger contract).

**Contribution ledger:** loop → four-part block w/ wider context, G-19/G-20, class pass,
amend-verbatim, ripeness ordering, mobile+voice mechanics. ballot → invariant source scan,
formal-lane table, `rush|briefed|deep` marker. qualify → the 8Q gate.

**Ledger schema settled (question (b)).** Found THREE rival shapes: nabla-lab's session-grouped
`## Locks — <date>` + `| # | Lock | Status |` table (the field reality) · `/new-project`'s
`## L<N>` prose seed (bootstrap-only) · ballot's `## Gavel G[N]` key:value block (**orphan — nobody
writes it**). Ballot's schema DROPPED, not merged; my earlier "take ballot's block" line was wrong
and is superseded. Field shape adopted as *the ledger contract* — but reframed source-invariant:
flag.md path resolved from the project harness, no project cited as authority. Note: nabla-lab
lock 15 (2026-07-08) had already gaveled the review-depth marker into the Status column.

**Existence/reference check:** `/gavel-ballot`, `/gavel-loop`, `/gavel-qualify` had **zero** external
references (no agent, no skill, no canon) — safe to restructure. `/gavel-interpreter` **is**
referenced by name in `therapy/SKILL.md` L88 + `socratic-therapy/SKILL.md` L88 → name load-bearing,
kept OUT of the merge (different artifact = the Socratic bed, different law owner =
`raw.therapy/README.md ## Gavels`, different act = fold vs stamp).

**Name:** majkee picked `gavel-loop` over my `/gavel` lean and over ballot-seniority. Rewritten in
place, so no dangling refs.

**Old dirs REMOVED same session (@Delta, majkee released):** `gavel-ballot/` + `gavel-qualify/`
deleted recursively; pre-check confirmed each held only a SKILL.md. Verified after: `gavel-loop/`
+ `gavel-interpreter/` intact. Global skill count 32 → 30. Family is now `/gavel-loop` (the stone)
+ `/gavel-interpreter` (the bed). No residual.

**Flagged follow-up (not fixed, separate gavel):**
`/new-project` seeds `## L1 — Stack` prose but projects then grow via `## Locks — <date>` tables →
mixed-shape flag.md. Real inconsistency, minor, different skill, out of this merge's scope.

---

## [2026-07-26] — larvaTnux W2 DELIVERED: factory volatile zsh layer (Fork Y, collapsed)

**Origin:** W2 released by majkee this session ("w2" → "all blessed"). Architecture was locked
2026-07-25 (Fork Y — fully volatile, project-owned, on-request, zero canon touch). Boot pad seed:
`applications-in-common/.dev/_mail/atlas/inbox/monkey.boot-pad-bus.2026-07-23.md`.

**DELIVERED (project-local `applications-in-common/.dev/zsh/`, 5 files + 1 shadow note):**
- `_base.zsh` — ROUTER/loader. Self-locates `$FACT_ROOT` via `${(%):-%N}:A:h:h:h`; double-source
  guard; sources the three siblings; runs boot inherently on activation.
- `_keyboard.zsh` — KEYBOARD, aliases only (house LAW: bodies in engine). `fact-*` family.
- `factory.zsh` — `<hokus pokus>` ENGINE: orient/exp/bricks/hyp/flag/pulse + `fact-help` columns.
- `boot.zsh` — COMMON BOOT = dependency-ordered idempotent brick-boot chain (see below).
- `README.md` — the CARD (authority for readers, wiring rule 1).
- `~/.config/zsh/config.zsh` — comment-only SHADOW NOTE appended at EOF (no sourcing, no
  registration). Edit went through — no permission block.

**Collapse honored (majkee steer):** 7-file sketch → one router · one keyboard · common boot ·
`<hokus pokus>`. Did NOT over-file.

**Boot reframed mid-session (majkee correction — the real value):** boot is NOT a banner. It is an
inherent bring-up sequence. Proven by larvaTmux `pad.1-tap.md` STEP 0 = BLOCKED ("NO BUS SESSION"
— tmux server not running): ommatidium (H12 tap) has nothing to test unless the tmux bus pane (H7)
is already live. Generalized: each new brick lands on an earlier one it assumes booted. So
`boot.zsh` = dependency-ordered, idempotent, check→bring-up→report chain, auto-run on
`source _base.zsh`. Chain today: (1) tmux bus pane via `tmux-pin-bus/smoke/01-sid-via.sh`
(idempotent) · (2) `~/.wires/pins.jsonl` check-and-warn (decision-11; never silently creates a
wire store). Explicit registration point for the next brick's boot step. Connects to my HELD
`/zsh-seq` note (2026-07-24): the sequencer now HAS a sequence — boot IS it.

**Design calls (all majkee-blessed):** (1) launcher = bare `fact` — the gaveled `!` collides with
zsh history expansion (unusable interactive alias; zenith-zsh confirmed no `!` precedent). Flagged,
NOT silently overridden; majkee blessed `fact`. (2) `fact-bus` alias reuses `_fact_boot_bus` body
— one bus bring-up, called by boot AND manually. (3) bricks-lab folded into `fact-bricks` (single
`<hokus pokus>` engine). (4) bare `fact` = help.

**Guardrails honored:** house LAW (aliases in keyboard, bodies in engine) held even locally.
`fact-*` prefix HELD in reserve — NO `keyboard.md` row, NO `keys.zsh` registration while local.
Paths derive from `$FACT_ROOT` (wiring rule 4); bus + wire-store literals each carry a
`# wiring truth` comment (rule 3). Card is authority (rule 1).

**Existence-check:** `.dev/zsh/` did not exist (clean build). zenith-zsh traced conventions: no
prior `!`/volatile-loader; house pattern is lazy `project-switcher.zsh` launchers.

**⚠ RESIDUAL / flags:** (1) **Devenv sync leg OPEN** — `.dev/zsh/` is gitignored in the app repo,
committed in the devenv; persists cross-machine only after an operator `sync.sh` pass. NOT run by
me (atlas-ui, no Bash for that transport). (2) Boot untested live — I have no Bash seat; first
`source _base.zsh` is an operator/Polyp smoke. (3) W3 (`/boot` skill · `/zsh-wire`) + W4 (coldstart
BRICK — must be a PROMOTION, not a direct build) still QUEUED, await release.

---

## [2026-07-25] — /gavel-loop skill DELIVERED (sequential gavel-clearing protocol)

**Origin:** build brief `reposoma/_mail/atlas/inbox/oraculum.gavel-loop-skill.2026-07-25.md`
(gaveled majkee 2026-07-25 in-chat — "all underline HINTS gaveled," skill-worth confirmed).
Field-proven at nabla-lab 2026-07-24/25: 8 locks + 15 days ledger debt cleared from a phone.

**DELIVERED (global, `~/.claude/skills/gavel-loop/SKILL.md`, active next session):**
`/gavel-loop` — sequential gavel-clearing. Per gavel: 4 parts (Impact · Wider context · Seat
lean · Stamp) then STOP for operator gavel/amend/park. Phase-0 class pass (formal → audit table
no-stop · strategic/taste → loop queue · doubt escalates up). Two guards baked as REFUSE/REOPEN
organs. Ledger duty = append-only supersede-never-edit to flag.md. Mechanics: mobile mode,
voice-note buffer-decode-mirror-before-stamp, ripeness-ordered arc.

**Existence-check (ran before build — gavel family fully mapped, NO collision):**
- `/gavel-ballot` = fast PARALLEL batch render, one-reply → the fast lane; gavel-loop is the slow
  sequential deep lane. Complementary, both kept.
- `/gavel-qualify` = deep 8Q classifier → gavel-loop runs a lighter BINARY class pass and POINTS
  to qualify when the binary is not enough. Reuse, not duplicate.
- `/gavel-interpreter` = writes the Socratic bed → gavel-loop STAMPS flag.md locks and explicitly
  does NOT write the bed; points to interpreter for bed-worthy locks. Clean separation per brief.

**Guardrails honored:** guards cited to authority (`raw.therapy/gavels/gavels.md` G-19/G-20,
verified present L93/L98 — no dangling pointer), bed law pointed to `raw.therapy/README.md
## Gavels` (not copied), nabla-lab `session/flag.md` locks 18–25 named as source (verified
exists). Thin-first / grep-first economy baked into the skill's own text. Sonnet-tier (procedure,
not judgment) stated.

**Design calls (Foreman/blessing rule — mechanical + reversible + brief-specified, flagged not
asked):** (1) binary class pass rather than importing qualify's 8Q — lighter, points up on doubt;
(2) name `gavel-loop` (family convention); (3) no bed-write path — hard boundary to interpreter.

**Residual:** mail archive = state transition per brief ("mv this memo to archive/"); dispatched
to @Delta (no Bash in atlas-ui seat). Note: build brief landed in the REPOSOMA temple inbox, not
the applications-in-common project inbox — cross-scope task, delivered global.

---

## [2026-07-25] — larvaTnux: polyp DECOMPOSED to skills (Wave 1) + factory zsh layer queued

**Origin:** boot pad `applications-in-common/.dev/_mail/atlas/inbox/monkey.boot-pad-bus.2026-07-23.md`
(commit 54fe775). Ask decomposed into 4 waves across a buffering session; majkee gaveled the
architecture, then released Wave 1 only and parked the rest.

**Wave 1 DELIVERED (project-local, `applications-in-common/.claude/`):**
- `skills/sqcr/SKILL.md` — pad runtime (verbatim lift from polyp: read STEP N → run verbatim →
  capture → fill `>MAJKEE report` → branch verdict). `/sqcr <pad>`.
- `skills/sea-pen/SKILL.md` — report seat: verdict → prediction → `testing-protocol.md`. No
  Write/Bash. `/sea-pen <slug>`.
- `agents/polyp.md` — REWRITTEN to thin seat + CASE-SWITCH router (mode MANNED/UNMANNED × which
  skill). Handoff (journal + stream CLOSE) kept in the router, not the skills. Builder note under
  the line. Pad-loop + sea-pen sections lifted OUT verbatim — extraction, not invention.
  Architecture-split precedent: pulse 2026-07-17 (agent = seat+router · skill = mechanism).

**Architecture LOCKED (majkee gavels this session):**
- **Fork Y** — factory zsh layer is FULLY VOLATILE, project-owned (`.dev/zsh/`), sourced
  on-request. ZERO canon touch. "volatile as mailing" honored.
- **No claviature/`keys` registration while local.** `fact-*` family prefix HELD in reserve for
  the day it goes global (one-line escalation, separate gavel).
- **On-request activation:** `!` alias → `_base.zsh` (local loader) → `{_keyboard.zsh, <scope>.zsh,
  boot.zsh, help.zsh}`. NO local `config.zsh` — only a SHADOW NOTE in the global `config.zsh` as
  the main-space breadcrumb (agent-visible "in case" without global sourcing).
- **Wave 2 steer (majkee):** collapse the 7-file sketch → **one router · one keyboard · common
  boot · `<hokus pokus>`.** Do NOT over-file it.

**PLOT-TWIST (correct the record): claviature is ALREADY LIVE.** `pulse.claude.md` LIVE BOARD says
claviature is "NEW — needs design session." STALE. zenith-zsh found it built: `ai/keys.zsh` engine
+ `keys` command (P12) + `claviature.global.spec.md` (locked doctrine: *derive, don't register;
register FAMILIES never keys; unknown keys → UNSORTED drift-detector*). Houston to update his board.

**Waves QUEUED (await majkee release):**
- **W2** — volatile zsh layer (Fork Y, collapsed per steer) + `config.zsh` shadow note.
- **W3** — `/boot` skill (fills the *pending* pointer already in polyp's case-switch) + `/zsh-wire`
  (repeatable Q1 wiring primitive; DEFERS devenv/P11 bootstrap to `/new-project` — anti-redundancy).
- **W4** — kraken (Trajectory or Vector — majkee to pick) for a workspace-coldstart **BRICK**.
  ⚠ **LAW-FLAG:** AGENTS.md "bricks are promoted, never born." W4 MUST be a PROMOTION from the
  SUPPORTED H7 (bus) + H12 (tap) survivors with provenance header — not a direct build.
- **`/zsh-seq`** — HELD (option 3): application cold-start is a sequencer with no sequence today
  (1 brick = `pin-core`, a library, not bootable). Add brick boot-contract line to `bricks/README.md`
  only when W4 lands.

**Flags:** (1) `/boot` is a live-but-empty pointer in `polyp.md`, marked *(lands Wave 3)* — not
silent. (2) Existence-check clean: no prior `sqcr`/`sea-pen`/`zsh-wire`/`zsh-seq`; no factory toolkit
in `~/.config/zsh/projects/`. (3) `/cold-start-card` (operator note) vs `/zsh-seq` (executor) — kept
distinct. (4) I ran as atlas-ui — no Bash; bus relaunch (`smoke/01-sid-via.sh`) is operator/Bash-seat,
and T1 was BLOCKED (no tmux server) anyway.

---

## [2026-07-21] — /cold-start-card skill DELIVERED (volatile incarnation glue)

**`/cold-start-card` BUILT** (`~/.claude/skills/cold-start-card/SKILL.md`, global, active next
session): drops a tiny operator-facing cold-start note into the temple monkey inbox
(`temple:monkey`). Four loose fields — commit mark · task name · one sip of context · resume
command+flags. Info FOR majkee, not agent-consumed. **Volatile by design** (majkee's pick over
"solid glue baked into agents") — drainable per Cinderella rule, no template rigor. Filename
shortcut `CS.<slug>.<YYYY-MM-DD>.md`.

**Existence-check clean:** 30 global skills scanned, reposoma has no `.claude/skills/`. Sibling
`/drop-brief` = terse agent-take brief to `~/.remote/brief.md` (agent→agent, ephemeral) — distinct
direction/target/shape. `/run-synthesis` = run shape, no overlap. The hand-written
`atlas.session-summary.2026-07-15.md` in monkey inbox was the precedent — no skill automated it. Gap real.

**Path decision (majkee's embedded question — absolute vs relative):** NEITHER. Absolute
(`/home/hruzam/reposoma/...`) is machine-bound + violates mail canon 0004 L4 (addresses derived,
not stored). Naive relative breaks from a global skill's arbitrary CWD. Resolution = temple
derivation cascade (`temple-project-map.zsh` → registry → beacon → `temple-project-root reposoma`)
+ logical addressing `temple:monkey`; read-side confirm via `temple-mail-inbox temple:monkey`. Law
cited at `<reposoma>/_mail/README.md`, never hardcoded. This is the "different tool" majkee sensed.

**Primitive rationale:** skill (not subagent) — must run in the seat that holds the live session
context; a subagent would lose the payload. **Flag:** `commit` field wants `git rev-parse --short
HEAD` (Bash); no-Bash seats leave it for majkee — acceptable under the volatile ethos.

---

## [2026-07-20] — gavel-qualify output contract (addendum replaced)

**Pin-triggered diagnosis:** `~/.pins/pins.jsonl` carried one entry pointing to the Majkee addendum
in `gavel-qualify/SKILL.md` lines 61–85. Analysis: the addendum framed the concern as
buffer-vs-loop (agent process architecture) — wrong layer. The 8-question structure already
prevents item-mixing by construction. The real constraint was output density + readability
(CLI no ctrl+F, mobile artifact view). Majkee confirmed the diagnosis.

**Fix:** addendum replaced with `## Output contract` (4 lines): one verdict block per item,
complete before next; endpoint named explicitly (`→ continue` / `→ pending: [one question]`);
wide lines, not narrow. Wrong-layer meta-commentary removed; right-layer directive baked in.

---

## [2026-07-20] — gavel-qualify skill (PROVISORY) + Atlas reincarnation brief

**`/gavel-qualify` DELIVERED** (PROVISORY, `~/.claude/skills/gavel-qualify/SKILL.md`):
Pre-blessing classifier for the gaveling phase. Eight questions run sequentially for-each
item: Q1 context blast-radius · Q2 game-changer test · Q3 conceptual/tactical · Q4
structural load · Q5 formality class · Q6 presence test · Q7 fork naming · Q8 ritual type.
Output: verdict per item + one surfaced question for unresolved items. Auto-blessing rule:
Q8=`already-blessed` → taken as locked (prior lock cited, no ceremony). Q8=`shadow` →
candidate surface only, @majkee decides. Existence-check clean (gavel family: ballot =
queue clear · interpreter = bed format · qualify = pre-blessing triage — distinct purposes).
Validated by dry-run on G-10 (8-pass correctly classified the cmd-zen thin-router decision).
[PROVISORY] — shape evolves after real runs; refinement signal = what Q8 resolved vs. what
needed operator input.

**Agent reincarnation brief COLLAPSED to minimal shape:**
- `~/.remote/brief.md` — ONE file. `who:` · `task:` · `project:` · `context:` (optional)
  between `<!-- brief -->` tags. `who:` = discriminator (not the filename).
- `/drop-brief` skill — any seat writes to brief.md. One invocation, done.
- Atlas saddle step 0 + Eagle pre-step: compressed to one line each (check brief.md, match who:,
  erase if taken). Other agents: add same one-liner when next touching their files.
- `~/.remote/README.md` brief section: 3 lines.
- `~/.remote/briefs/` — DEAD (6 files killed, `git rm -r briefs/` to clean from remote-hub).
- Lesson: briefs/ was completeness-compulsion (6 files + README sprawl for no added capability
  over `who:` field + one flat file). Collapsed same session. task.md elegance was the reference.

---

## [2026-07-20] — blessing rule boarded (haiku gavel) + remote protocol graduated (A→C)

haiku: this is the blessing the blessing is and it is the blessing.

> I stop for a gavel only when a decision changes the shape of what exists — a new engine, a
> direction/canon choice, an irreversible cut. Mechanical, reversible, or already-implied calls
> I make under the Foreman rule and flag as I go rather than ask before. A genuine unknown I
> can't reason to gets named and web-verified or handed to majkee — the run doesn't stall on it.

**Remote protocol GRADUATED (majkee: "(A)→(C)"):** provisory block DELETED from
`~/.claude/CLAUDE.md` (back to 33 lines). Replacement = `SessionStart` hook in
`~/.claude/settings.json`: pulls remote-hub (timeout 4 s), injects `task.md` into context iff
`what:` filled, else silent, always exit 0. **Hook install BLOCKED by the permission classifier
(self-modification) — JSON block handed to majkee to apply by hand; protocol docs already
assume it, marked pending.** → **PASTED + SMOKE-TESTED same day:** test A (blank) = silent,
exit 0, 1.6 s · test B (real phone drop via GitHub app → pull → banner + task) = PASS, 1.7 s.
Hook LIVE. Last proof leg = injection visible at next real session start (operator-observed).** Hardcoded switch = flag file `~/.remote/OFF` (`touch` = mute ·
`rm` = re-arm; gitignored, per-machine). Chosen over majkee's mv-block<>registry sketch — same
hardcoded off-switch, no file surgery, agent-evaluable (WALL pattern from H8 README).
`~/.remote/README.md` + `memory.md` updated; `OFF` added to Build B's `.gitignore`. First live
application of the harness-lifecycle report (SessionStart stdout injection = its §2/§7). Cost
flag: one capped git pull per session start on this box — fall back to local-read-only hook if
it bites.

**Flight seat wired:** `pulse.flight.md` scaffolded (single-writer Flight, empty) + first task
package → `_mail/flight/inbox/atlas.remote-transport-tasks.2026-07-20.md` (tailscale ACL
symmetry · zsh call-in-arms · eagle-on-home trigger · H8 load-bearing test standing item). All
machine/infra layer — not Atlas posture. H8 netOrchestrating (Flight's own line at
applications-in-common) named as the owning experiment; my earlier "fold recipes into
memory.md" lean is superseded by that build. Mail chosen over writing into his pulse —
single-writer holds from day one. Saddle wiring: `flight.md` + `AGENTS.md` Flight bullet gain
`pulse.flight.md` as read-first (implied-by-creation edit, flagged here).

**Harness-lifecycle report verdict (majkee asked: project vs testing line → temple migration?):**
NO new project (Foreman). Testing line: today's hook = live test #1; next skill builds apply
§5a description-priming + §5b `!`-hydration where they genuinely fit. If the patterns survive
a few real uses → temple migration as a raw.settings card (`raw.card.harness-injection.md`),
majkee gavels. Report is dated (verified 2026-07-19/20) — half-life applies.

**@Epoch FIRED (point 5 — cloud-session invariance):** claude.ai↔Code portability, remote/cloud
execution + persistence limits, multi-repo reach, local→cloud session handoff. Report LANDED:
`raw.research/harness/reports/2026-07-20-cloud-session-invariance.md` (live-verified 2026-07-20).
VERDICT: temple shape (multi-repo + `~/.claude` + `_mail` + `~/.remote`) categorically
incompatible with every cloud offering (1 VM = 1 repo, no out-of-repo files) → tailscale-reachable
office box IS the invariant session; cloud = single-repo disposable tasks only. Notables:
Remote Control (paid plans) = web/mobile viewport onto a LOCAL session (~10 min drop timeout);
`--teleport` cloud→local; env cache ~7 days. Refresh-watch: exact idle timeout undocumented ·
secrets store "not yet" · multi-repo "not yet".

**Flags:** (1) ~~pasted text #1 unseen~~ RESOLVED same day — it was the netOrchestrating
pointer (read anyway via the visible path); blessing-rule home in this pulse confirmed.
(2) Parallel session landed `/take-pin` earlier today — entries stack, no conflict seen from here.

---

## [2026-07-20] — /take-pin skill BUILT (global, H6 transport)

**Task:** majkee direct — thin wrapper skin skill for the editor-pin Path D wire
(applications-in-common H5 experiment). Store location: `~/.pins/pins.jsonl` (global).

**Delivered:**
- `~/.claude/skills/take-pin/SKILL.md` — global skill, active next session as `/take-pin [peek]`.
  First draft: thin skin over `take-pin.sh` (consume/peek, session caveat, hard no-mastering rule).
  **majkee reshaped to H6 transport** (his edit): root-based claiming via nearest `.git` walk,
  filter by `root` field, **partial consume** (matched pins cleared, other scopes' pins preserved).
  Source cited: `claim-pins.sh` (H6 transport).
- Project-scoped duplicate at `applications-in-common/.claude/skills/take-pin/` DELETED (@Delta).
- `applications-in-common/.claude/settings.local.json` — `Write(experiments/**)` pre-approved
  (majkee added directly; covers pin store + all experiment writes, no confirm needed).

**Design principle crystallised (session discussion):**
Scripts (harness-wired tools) = trigger / process layer — they SET state. Native agent tools
(Read/Write/Grep) = reasoning layer — content lands directly in context. `take-pin.sh` is the
human-side terminal tool; the skill uses Read natively. File boundary is the interface;
scripts live on the write side, agent on the read side.

**Allowlist vs denylist frame settled for this project:**
`experiments/**` = explicitly disposable → allow-all write (no confirm friction).
Harness (`.dev/**`, `AGENTS.md`, `bricks/**`) → default-ask (Claude asks once; that IS the gate).
No denylist needed — the allowlist scope creates the partition.

**Still open (unchanged):**
- Houston routing update (Oraculum + Agol) — parked to 2026-07-19 (now overdue; check next saddle)
- home.md cleanup — blocked on home machine session
- Publishing trial — dormant, waiting for "publishing-trial: go"

---

## [2026-07-18] — @Flight promoted to CEO-proxy seat (authority thinned, Full+B) — DEVIATION recorded

**majkee direct call:** *"I need real CEO, so boundaries must be thin or not (make note that
was happened)."* @Flight's tactical ceiling (defer every gate/lock up to @Houston) THINNED to
CEO authority gated on his live presence. Shape = **Full + B** (his pick after the A/B +
toolbox menu):

- **Full toolbox:** `tools:` field REMOVED from `flight.md` → Flight inherits ALL tools (incl.
  Bash/Edit) + whatever MCP servers the current project exposes (CWD `.mcp.json`, generic
  cross-project, zero upkeep). This is the only confirmed-generic way to get all-project MCP
  for a global agent — guide-verified (code.claude.com/docs): NO context-aware MCP wildcard
  exists in the `tools:` allowlist; omit = inherit all; the allowlist DOES bind a
  `--agent flight` main session (so this had to be resolved in the file, not left implicit).
- **B — presence-conditional authority (baked into the body):** MANNED (majkee drives
  interactively) = full CEO — plans for all, makes calls, LOCKS decisions he directs, may
  spawn strategic advisors (@Janus/@Agol/@Color/@Oraculum). UNMANNED (spawned as a subagent,
  no human) = holds the old tactical rail — no locks, hard-stop at gates, route to @Houston.
  Once the hard tool-restriction is gone, the body rule is the ONLY guard → B is load-bearing.
- **Dual-model, zero machinery:** `model: sonnet` stays default; Opus via `--model opus` at
  spawn or `/model opus` live (precedence `--model` > `/model` > frontmatter, guide-verified).
  Body de-hardcoded from "Runs Sonnet." Opus = reasoning depth, NOT extra authority. Edge
  noted: a project's `.claude/settings.json` model beats frontmatter at startup.

**DEVIATION flagged to @Houston** (`_mail/houston/inbox/atlas.flight-ceo-authority-thinned.2026-07-18.md`):
the `AGENTS.md` tactical-saddle text ("hard-stop at every gate… you never lock a decision or
edit the ledger") + the documented Houston/Flight split now contradict MANNED mode. This is the
audit trail majkee asked me to leave; not a silent drift.

**⏳ TEMPORARY PASS applied (majkee follow-up):** *"Need the pass for Flight, Houston will
understand. This is temporary solution."* On his live direction (operator gavel — NOT
agent-authored-direct), I added a dated, reversible **TEMPORARY PASS** sub-bullet to the
`AGENTS.md` Flight-seat entry: old "hard-stop/never-lock" line re-scoped to UNMANNED; MANNED
CEO mode authorized now. No live contradiction remains — but a temporary canon edit stands
outside the ledger awaiting @Houston's formalization. Reversible = delete one sub-bullet.
Houston mail updated to match (formalize, not reconcile).

---

## [2026-07-18] — /remote-control v3 — remote-hub live + memory agent-modes

- **remote-hub CREATED (@Delta):** private GitHub repo `github.com/hruzam/remote-hub`, branch `core` tracks
  `origin/core`, clean tree. Commits `14d1c6b` (init) + `28b1ff7` (memory/wire). Cross-device sync now LIVE
  once the phone side clones/pulls. Both skills carry concrete sync: `/remote-write` commits + `push origin
  core` on drop; `/remote-read` `pull --ff-only origin core` first, commits + pushes the reset on take.
- **memory.md gained `## Agents — invocation & context ceilings`** (majkee's content): one-shot headless
  (no turn limit · ~200K ctx · one invocation) · looped via SendMessage (each msg adds ctx; ends at ctx
  exhaustion) · practical ceiling (Eagle/Delta lean · Trajectory longer · Oraculum burns fast on synthesis).
- README + local CLAUDE.md name the repo (`remote-hub` · `core`).
- **Helpers WIRED (2026-07-18):** `~/.remote/CLAUDE.md` take-flow — @Eagle orients into the taken task's
  `project` (harness read → compact report) BEFORE acting; @Recorder files the outcome into that project's
  session memory AFTER (survives the `task.md` erase). Flow = read → orient → act → record. Grounded in
  eagle.md / recorder.md — faithful to tool scope (Eagle read-only harness + Bash orientation; Recorder
  Haiku/no-Bash, never blesses code, marks gaps). Committed + pushed to remote-hub.

**Flagged:** every drop/take hits the `git push` ask-gate (settings `ask: Bash(git push:*)`) — fine while
majkee is present; allowlist only if it bites. Skills remain "temporary" per majkee. Phone side needs a
one-time `git clone git@github.com:hruzam/remote-hub.git` if it is a separate device.

---

## [2026-07-18] — /remote-control v2 — skills + git + local harness + safe-for-all

majkee expansion of the handoff box. Six deltas on top of v1 (entry below):
- **Two temporary global skills** (existence-check clean — no prior remote-*):
  `~/.claude/skills/remote-write/SKILL.md` (`/remote-write` = drop into `task.md`) ·
  `~/.claude/skills/remote-read/SKILL.md` (`/remote-read` = take: read once → memorize → reset `task.md`
  to its blank header → act in the named project). Both carry a git-sync step (commit/push if a remote is
  set; no-Bash seats dispatch @Delta). Marked "Temporary" in their descriptions.
- **Harness collapsed to one small file:** `memory/harness-commands.md` → `~/.remote/memory.md` (small,
  reachable; skills listed at top; points to `raw.card.claude-code.md` for the full dated ref). Old
  `memory/` folder removed via @Delta.
- **Git-backed:** @Delta ran `git init -b core` + first commit in `~/.remote/` (branch `core` = temple
  convention). Local repo only — NO remote yet (flagged: cross-device sync not live until a remote is set).
  "update on got" = the skills commit on drop/take.
- **Local harness:** `~/.remote/CLAUDE.md` created — declares the box safe-for-all, the loop, git discipline,
  and a Helpers stub (@Eagle · @Recorder — majkee wires these).
- **Safe for all:** `~/.claude/settings.json` → `permissions.additionalDirectories += /home/hruzam/.remote`
  (reachable from every project session, any seat).
- Global `~/.claude/CLAUDE.md` block + `~/.remote/README.md` updated to match (skills, memory.md, git, safe).

**Open / flagged:**
- **Remote = the real transport.** Local `git init` makes it safe/versioned but does NOT sync phone↔desktop
  unless the two share the same FS OR a git remote exists. Next step if phone is a separate device: create a
  private GitHub remote (`gh repo create`, @Delta — like the applications-in-common bootstrap) + wire pull/push
  into the skills. Awaiting majkee's call on repo name + go.
- Skills are "temporary" per majkee — revisit whether they graduate or fold once the pattern settles.

---

## [2026-07-18] — /project-document built (thin cmd-zen-style doc router)

`~/.claude/skills/project-document/SKILL.md` — thin ROUTER for writing durable coding-project
docs (freya, psdvSys …). ONE skill, TWO modes via input vector — `synthetic` (b: onboarding/
architecture guide derived from session understanding + code) · `analytic` (c: reference derived
FROM code). Adopts the `/cmd-zen` philosophy: a command is just a README read with an input vector
→ perform. Content home = per-project `<project-root>/guides/README.md` (the doc LAW + guide index +
`## MODE:` blocks); the skill imposes NO template — client projects do NOT inherit temple
"wire-don't-consolidate" canon. Root resolution reuses the `/project-read` cascade
(temple-project-map.zsh → registry → beacon). Sufficiency-gated (mirror cmd-zen SEARCH ladder — no
parallel tree blast); draw via `/buffering-cycle`; confirm-before-write. Pairs cleanly:
`/project-read` (orientation IN) ↔ `/project-document` (documentation OUT).

**Design calls (majkee blessed all):** (1) name `project-document`; (2) ONE router not two skills —
true cmd-zen mirror (two modes = two "commands" in one home); (3) `guides/` at app root, README
resolves any `docs/` clash per-project. **Reshaped from majkee's first sketch:** killed the proposed
"session-wrapper buffers to temp file" mechanism — the session IS the buffer; @recorder +
/session-resume already cover collection/recovery (build-and-bruise: no mechanism ahead of need).
Skill routes to those instead. Rejected an AGENT — doc-writing is on-demand artifact work in the
seat that already holds context = textbook skill (Foreman rule).

**Existence-check (ran before design):** global skills + project `.claude/` — NO doc-writer
existed (reader side covered by /project-read + @Eagle; writer side was the hole). Mechanism overlap
with @recorder / /buffering-cycle / run-synthesis surfaced and POINTED-TO, not rebuilt.

**Open tail:** per-project `guides/README.md` bootstraps at FIRST run on freya/psdvSys (not written
now — the skill seeds it from each project's existing doc landscape). Watch-item: analytic mode is
the most likely to balloon into an exhaustive tree walk — sufficiency gate caps it, verify on first
live analytic run. Seat must have Write to land the file (skill inherits invoking seat's tools).

---

## [2026-07-18] — /remote-control built (mobile↔desktop task handoff, provisory)

`~/.remote/` — machine-global, cross-project, NOT git-tracked drop box for phone sessions. Principle:
**drop and go · take and erase.** Primitive choice = CLAUDE.md instruction block + folder scaffold (NO
hook/skill/agent) — majkee named it ("provisory wiring to main CLAUDE.md file"); smallest that fits the
Foreman ladder. Existence-check clean (25 skills · 27 agents · no `~/.remote` · no `remote` in CLAUDE.md).

**4 deliverables:**
- `~/.remote/README.md` — golden rules (the law). DROP: fill the four fields in `task.md` (project · who ·
  what · bye), save, go. TAKE: "come for the task → take it → memorize → erase → back to your project."
  One task at a time; erase = reset `task.md` to the blank template (file always exists so the phone
  always sees the shape); presence = `what` filled. MEMORY: reference, never erased.
- `~/.remote/task.md` — the single drop file. REFINED from a scanned `task/` folder to one fixed file on
  majkee's "{project, who, what, bye :)}" call; old `task/` + `.keep` removed via @Delta.
- `~/.remote/memory/harness-commands.md` — the compendium majkee asked for: curated cheat-sheet of most-used
  Claude Code commands (CLI · slash · keyboard/TUI · this machine's temple /x skills). GROUNDED in the
  fresh `raw.settings/raw.card.claude-code.md` (v2.1.210, verified 2026-07-16) + pointer to it as
  authoritative (baked-in-table guardrail honored).
- `~/.claude/CLAUDE.md` — provisory block appended (34→~43 lines; combined + reposoma `@AGENTS.md` well
  under the 120 guardrail). Points to the README. Reversible: delete the block to disable.

**Redundancy note (surfaced, not a collapse):** distinct from `_mail/monkey/` (temple-scoped · git-tracked ·
durable). `~/.remote/` is machine-global · ephemeral · consume-once · project-agnostic.

**Open / flagged:**
- Transport assumption is load-bearing: TAKE + DROP must see the SAME `~/.remote/` (same machine, or a
  synced dir). If a phone session runs in a separate sandbox → a sync leg is needed first. Noted in README;
  not resolved (majkee proceeded on the same-machine lean).
- Earned upgrade if the provisory CLAUDE.md instruction proves unreliable at pickup: a `SessionStart` hook
  (deterministic inject). Build on the wall, not now.
- Compendium is a dated snapshot — refresh when the claude-code card refreshes (~2026-08-06 due).

---

## [2026-07-17] — /gavel-interpreter built (gavel bed preproduction collector)

`~/.claude/skills/gavel-interpreter/SKILL.md` — preproduction data collector for the EXISTING gavel
bed `raw.therapy/gavels/gavels.md` (live: G-01..G-05; format locked in its own frontmatter = Socratic
question OR seven associations, never names path/task). On invoke: read bed → next G-NN → interpret
the landed decision into a Socratic fold (skill DRAFTS, majkee reshapes) → classify
`independent|therapy-origin` + `wire:` tag → append (oldest-at-top, id order). Explicit invoke per
gavel (gaveling-day cadence). Existence-check: DISTINCT from `/gavel-ballot` (that renders a PENDING
queue → flag.md; this collects the research corpus). Scope = capture only; '42' engine + frequency
rule tabled (mental-map seed). Name: majkee's `gavel-interpreter` over fallback `gavel-capture` — the
folding (interpretation) is the value, append is trivial. Full gavel-format skill still tabled pending
Nabla. Reason it's the right day: gaveling-day + researches + 2 coding tasks = rich gavel stream to capture.

**REFACTORED same session (majkee catch, 2nd time):** the full format law already lives in
`raw.therapy/README.md ## Gavels` (frequency · never-name-path · Socratic-OR-associations · two
kinds · bed · "Atlas's job to build"). I had duplicated it into the SKILL.md — same fat-artifact
instinct caught on cmd-zen one skill earlier. Skill made THIN: wired to the README as law + gavels.md
as data; format rule removed from the skill. Pattern noted (completeness-compulsion, twice in one day).

**Therapy wired (majkee):** `/therapy` now ALWAYS includes the gaveling step — reads its part of
`raw.therapy/README.md ## Gavels`, points to `/gavel-interpreter`, bonds the G-ID in footer tags.
Model locked: **two skills diverging off one README, each reads only its own slice.** Independent-gavel
stream preserved (build/design decisions still capture via `/gavel-interpreter`, no therapy wire).

**Temple waiting on research (therapy arc 9 · same-note-to-pulse):** the full gavel-format skill ·
'42' engine · mental-map modes stay tabled, waiting on the Nabla research (R-1..R-4, mental-map seed)
that should answer them. The preproduction collector feeds it real data. Build-and-bruise held as
policy — restraint is deliberate, not stalling; the old failure (larva) built mechanism ahead of need.

**Gaveling addendum (majkee):** added to `raw.therapy/README.md ## Gavels` (both skills inherit, no
dup) — (1) no gavel → say "no gavels," never improvise; (2) shadow gavel → describe as candidate,
don't append, @majkee decides. First applied to arc 9: surfaced a shadow candidate, did NOT commit.

---

## [2026-07-17] — /cmd-zen installed as a thin-router skill

`~/.claude/skills/cmd-zen/SKILL.md` CREATED as a THIN ROUTER (majkee's insight: a command is just
a README read with an input vector → perform; mirrors how /refresh routes over scope READMEs).
`/cmd-zen <COMMAND>` reads the single content home `raw.research/agent-docs/commands/cmds-zen.md`
with the input vector and performs — sufficiency-gated, no parallel blast. No `context: fork`
(commands need the conversation's input vector; nesting research "losing context early"). ONE
content home, ZERO duplication (first pass wrongly copied SEARCH/PINS into the skill → refactored
to router same session). The `/cmd-zen` pointer in epoch + atlas-ui + atlas-auto now RESOLVES (was
dangling). cmds-zen.md carries a ROUTER NOTE + stays freely expandable (add a `## COMMAND:` block,
no reinstall). NOT preloaded into `skills:` frontmatter — on-demand is leaner. Existence-check clean
(21 skills, none was cmd-zen). Next (majkee): hold the gavel-format skill (mental-map seed) until
Nabla settles format.

---

## [2026-07-17] — anchor wiring collapsed to one golden line (Foreman pass on my own build)

Built a 30-line 4-door anchor block into `epoch.md`, then majkee Foreman-passed it: the golden
mechanism already lives in `raw.research/agent-docs/commands/cmds-zen.md` (`/cmd-zen` skill —
sufficiency-gated escalation ladder + kraken-blast war story + therapy-derived commands).
**Architecture split locked:** agent def = translate WHAT IS IT (one golden line) · skill = the
mechanism · operator sends the agent there. Gates (drowning guard · arc-7 hard-stop · escalation
ladder) live in the skill, NOT the agent. `epoch.md` cut back to one Discipline bullet ("enough is
decided after each source, not after all of them … Mechanism: /cmd-zen"); zenith line reverted.
Atlas pair (atlas-ui + atlas-auto) got the same one line (Guardrails bullet). **Cold-start test
GREEN** (neutral general-purpose agent, bait version query): step-1 local RAG first → judged
partially insufficient → ONE web query → stopped; no parallel blast. Cost 31,104 subagent tokens /
6 tool uses / 49.5s — est. ~1/3–1/4 of a blast run. Report:
`nabla-lab/drafts/cmds-zen-coldstart-test.2026-07-17.md`. **PINS vs README-taste reconciled**
(majkee agreed): README-taste = default navigation; epoch PINS = hard-capped hot-cache (max 3,
never a 4th; a wanted 4th = drop pins for pure taste) pointing INTO the README graph — encoded in
`cmds-zen.md`. Open: the 3 specific pins + `save-report` still `[DRAFT]` pending majkee. Lesson
(live): I wired against completeness-compulsion while expressing it in the wiring — build-and-bruise, ship small.

---

## YOU ARE HERE — [2026-07-16] — editors scope + 4 stale cards refreshed

**editors scope BUILT (2026-07-16):** `/refresh editors` — interrogation-driven scope
(Sublime Text · Zed · on-demand others). No sources roster, no card, `persist: ask`.
Two-phase README: Phase 1 interrogation+research → Phase 2 verdict routing (feature gap →
coding task at applications-in-common or new project). Process map lives in the README body.
First smoke test GREEN; first factory production landed (Phase 2 routing fired on first run).
Files: `raw.research/editors/draft/README.md` + `report/.gitkeep`. No .gitignore touch needed.
Refresh skill NOT modified — README body is self-explanatory for the override.
Flag: if a second interrogation-mode scope is created → add `mode: interrogation` clause to skill.

**agy Maslow ruling + triangulation trigger LOCKED (2026-07-16):** `agy` advancement
gated on capability parity — agents in `agy` must prove as capable as direct `gemini` CLI
agents before any investment. Until confirmed: low Maslow priority, no `agy`-specific glue.
GEMINI.md updated with the gate + trigger. **Tabled future-build:**
claude→agy blind triangulation protocol (bluebottle.sh pattern, `agy` as Gemini 3.5 leg,
cross-vendor blind). Trigger: majkee confirms capability parity + stream stability.
Framework when it fires: `reposoma/triangle.md` + new shell driver in `~/.config/zsh/ai/`.

**Gemini GEMINI.md BUILT (2026-07-16):** `~/.gemini/GEMINI.md` — "first, be aware" context
file (native Gemini CLI GEMINI.md, auto-loaded at every session). Three sections:
auth (API key path, still on CLI, tokens saved) · Antigravity successor (agy installed at
`~/.gemini/antigravity-cli/`, parked contingency, don't over-invest) · pattern check table
(hang classes + safety class — same taxonomy as the card, centralized). Signpost added:
`~/.config/zsh/ai/README.md` `## Gemini first-awareness` section. Per-agent RECALIBRATION
RULEs unchanged (role-specific; GEMINI.md = shared foundation layer only). No new Claude
skill — GEMINI.md is the right primitive (auto-loads for all gemini sessions). Flag for
later: Antigravity CLI (`agy`) may need its own config (different tree) — not yet built.

**4 stale cards REFRESHED (2026-07-16, @Epoch):** claude-ai · claude-code · cursor-ide ·
gemini-gems — all verified 2026-07-16, half_life_days reset to 21 (was 30). Full re-synthesis
from live sources (Anthropic news · release notes · Claude Code changelog · Cursor changelog ·
Releasebot). `zsh.stale-settings-cards` toAll task CLEARED (mail already gone from inbox —
operator archived; tabled item closed). Notable Epoch finding: `gemini.google/release-notes/`
lags — `releasebot.io/updates/google/gemini` now primary recheck for gemini-gems; card's
`recheck:` order updated. No scope READMEs built — direct one-time refresh (pre-cycle era
cards). If any warrants a permanent scope → Atlas task. Next recheck due ~2026-08-06.

**Eagle upgraded (2026-07-16) — factory diff + 3 extractions:**
Compared factory-built `project-explorer.md` (via `/agents` create flow) against Eagle.
Tool bloat found (MCP tools · Task tools · WebFetch — none appropriate; factory also
missing Grep/Glob). Per-project memory rejected — raw.settings cards already serve that
role. 3 good extractions folded into `~/.claude/agents/eagle.md`:
- Cascade: Step 3.5 glob sweep (AGENTS.md / PROJECT.yaml fallback before asking)
- Read order: `pulse.*.md` variant fallback (non-standard pulse layout coverage)
- Output block: `Drift:` + `Absent files:` rows added
`memory: user` added to frontmatter — user preferences only, not project state.
`project-explorer.md` deleted (@Delta confirmed). `raw.card.eagle.md` run log updated.

**Still open (unchanged):**
- Houston routing update (Oraculum + Agol) — parked to 2026-07-19
- home.md cleanup — blocked on home machine session
- Publishing trial — dormant, waiting for "publishing-trial: go"

---

## YOU ARE HERE — [2026-07-15] — Eagle card + guide gap closed (tabled item D CLOSED)

**Eagle card DELIVERED (2026-07-15):**
`reposoma/raw.settings/raw.card.eagle.md` — first synthesis from eagle.md.
Tracks: cascade logic (4 steps + nabla-lab special case) · 9 mapped projects ·
beacon field names · known staleness triggers. half_life_days: 30.
Caught by harness-stale on expiry. Tabled item D closed.

**guide-for-builder.md gap closed (same session):**
`~/.config/zsh/guides/guide-for-builder.md` — new section added:
"How to add a new project devenv transport." Covers devenv.zsh entry points,
keyboard.zsh P11 aliases, ia-sync activation gate, zsh -n check, checklist,
pointer to /new-project skill. Was the missing recipe alongside the Gemini seat recipe.

**Session summary dropped to monkey inbox (mobile-readable, plain text):**
`_mail/monkey/inbox/atlas.session-summary.2026-07-15.md`
Lists done / open / one pending decision (stale tool cards yes/skip).

**project-regular-self-report skill REWRITTEN — two-phase (same session):**
Phase 1 (state update, card exists): monthly state block prepended, intake never touched.
Phase 2 (new card): reads `raw.guides/project-intake.md` for A–G mounting points +
`raw.settings/card.template.md` for card shape. Pre-filled intake file used as source if present.
Intake section written once, never overwritten on monthly runs.

Three intake files converted to wrappers (founding record kept, pointer header added):
  raw.guides/intake/subai.devenv.intake.md
  raw.guides/intake/reposoma.devenv.intake.md
  raw.guides/intake/piql.dev.intake.md

Two template files wired (consumed-by pointers added):
  raw.guides/project-intake.md → "consumed by /project-regular-self-report Phase 2"
  raw.settings/card.template.md → "consumed by /project-regular-self-report Phase 2"

/new-project skill updated: step 10 card item now names Phase 2 intake flow.

**Eagle wired into Houston + Flight routing tables (same session):**
Houston: "Project orientation" entry added to ## Who I spawn.
Flight: @Eagle added to ## Who I spawn alongside Epoch.
Epoch: already wired (## Subagent section, line 133) — no change needed.

**Session closed cleanly. Remaining open items:**
- Stale tool cards (claude-ai · claude-code · cursor-ide · gemini-gems) — awaiting majkee ruling (yes/skip)
- Houston routing update (Oraculum + Agol) — parked to 2026-07-19
- home.md cleanup — blocked on home machine session
- Publishing trial — dormant, waiting for trigger phrase

---

## YOU ARE HERE — [2026-07-15] — `/new-project` skill BUILT (tabled item C CLOSED)

**new-project skill DELIVERED (2026-07-15, majkee confirmed — "toAll"):**
`~/.claude/skills/new-project/SKILL.md` — global bootstrap procedure for a new temple project pair.
Skill #20 in the global set. Active next session.

**Pre-build audit (same session):**
Full vertical + horizontal wiring audit before drawing. All layers mapped:
canon → registry (logical) → machine layer (physical) → devenv transport (keyboard + engine)
→ harness scaffold → devenv scaffold → TCR configs → project cards.

**Two red cones found and baked into the skill:**
1. `devenv.zsh` + `keyboard.zsh P11` wiring for new projects was entirely undocumented —
   the skill now names this as a required step (step 7), dispatches to @Delta/@Trajectory,
   flags the ia-sync + shell-reload gate.
2. `temple-project-map.zsh` fresh-read rule restated at the machine-layer step (step 6) —
   same ia-sync gate flagged.

**Design decisions confirmed by majkee:**
- Mail seed: `toAll/` only (inbox + archive). Other seat folders on-demand at first send.
- Shell commands: emitted, never executed (step 9 block — operator or @Trajectory runs it).
- Machine-layer edits (devenv.zsh + keyboard.zsh): dispatched to @Delta — fresh-read-first + zsh -n required.
- `registry/projects/` format: NOT used — beacon format only (retiring pattern).
- TCR config: optional, prompted in step 8.

**10-step structure:**
1 Intake (6 fields) → 2 MANDATE check (scope-group stop-item) → 3 App scaffold →
4 Devenv scaffold → 5 Registry beacon + index row → 6 temple-project-map.zsh entry →
7 devenv.zsh + keyboard P11 wiring → 8 TCR config (optional) → 9 Shell commands block →
10 Post-bootstrap checklist

**Tabled item C CLOSED** (tracked since 2026-07-07, four data points: psdvsSys ·
fantasyobchod · freya · applications-in-common; canon spine gaveled 2026-07-14).

---

## YOU ARE HERE — [2026-07-15] — `@Eagle` subagent BUILT

**Eagle subagent DELIVERED (2026-07-15, global blessing):**
`~/.claude/agents/eagle.md` — companion to the `/project-read` skill.
Model: Sonnet / effort: low · Tools: Read, Grep, Glob (no Write, no Bash — read-only).
Named for Apollo 11 lunar module — "Houston, Tranquility Base here. The Eagle has landed."
In this ecosystem the sentence is literal: Eagle reads the project, reports to @Houston.

**Why both exist (not redundant):**
- Skill `/project-read` — inline, zero spawn overhead, invokable within any agent's session
- Subagent `@Eagle` — spawnable by orchestrators (Houston, Flight, Vara, Atlas)
  to run an isolated orientation pass without consuming the spawner's context window

**Not added to @Vector's scope** (Vector = implementer; wrong domain).
**Model rationale**: Sonnet not Haiku — needs to synthesize flag + pulse + AGENTS into a
coherent report; more than Zenith's mechanical extraction. Epoch-as-Sonnet considered (no
Bash either) but a dedicated agent is cleaner.
**Structure mapping**: uses Glob instead of tree-snapshot (no Bash available).
**Zenith lineage**: same Read/Grep/Glob tool set + librarian discipline (drift notes ·
never-invent · shape-matches-question). Scope: project harnesses vs Zenith's raw.settings.
**Rename note**: `project-reader.md` → `eagle.md` (old file deleted same session).
**Epoch wired (same session):** Eagle added to `epoch.md` `## Subagent` palette — trigger:
project-specific run needs harness context before scope narrowing. Eagle reads the harness,
returns orientation report; Epoch uses it to discover the volatile layer. Generic runs
(default radar) → Eagle NOT spawned.

**Eagle + skill TUNED (same session) — cascading resolution + sibling navigation:**
Both `eagle.md` and `project-read/SKILL.md` updated with:
- **4-step cascade** (cheapest first): (1) `temple-project-map.zsh` 42-line direct grep →
  (2) `registry/index.md` table row → (3) beacon `path:` frontmatter field → (4) ask once.
  nabla-lab special case: omitted from map, resolves as `reposoma-path + /nabla-lab`.
- **Bash shortcut** (skill only, via @Delta): `zsh -c "source base.zsh && temple-project-root <name>"` — single call beats cascade when Bash available.
- **Sibling navigation section** (both): find siblings via beacon `sibling-of:` frontmatter →
  resolve sibling root via same cascade → scope read via `## Shared anchors` entry points →
  report as separate block. Avoids full sibling harness traversal.

**Project self-report system BUILT (2026-07-15, majkee blessing — temple cleaning):**

Three deliverables:
- `~/.claude/skills/project-regular-self-report/SKILL.md` — monthly self-report runner (#18 in global set).
  Reads harness → synthesizes card entry → confirms before writing →
  `reposoma/raw.settings/raw.card.<slug>.md`. Append-only log, newest first. Same cascade
  as Eagle for root resolution. Offers beacon drift check after write. `half_life_days: 30`
  caught by existing harness-stale.
- `raw.settings/raw.card.machine.office.md` — office machine profile card. `half_life_days: 90`.
  Extracted from office.md; office.md now a thin wrapper pointing to this card.
- `raw.settings/raw.card.reposoma.md` — reposoma seed card (the temple itself as example).
  Current state from today's session. First entry in the project log.

**Eagle updated:** section 1.5 — optional quick-reference card read before full harness.
Card not authoritative; harness wins. Stale card → flag to orchestrator, proceed to harness.

**home.md card:** deferred — needs home-machine session to verify current state.
Will be `raw.card.machine.home.md` when created.

**Other project cards:** generated on-demand via `/project-regular-self-report <project>`. Not hand-written
in advance — the skill creates them.

**Principle locked (majkee):** guides are thin wrappers → raw.settings/ cards (standard
frontmatter · half_life_days · harness-stale catchable). Projects self-report monthly via
skill, not manual intake. "Wire, don't consolidate."

**Guides signpost hygiene — office.md fixed (2026-07-15):**
Diagnosis confirmed: `office.md` had a stale Project Paths table (violation of 0004 L4 +
guide rule 3 "point, never copy"). Replaced with explicit pointer to the authoritative
cascade (temple-project-map.zsh → registry/index.md → beacon). Date updated.
Eagle updated: guides noted as supplementary machine-context source (not in path cascade),
with home.md staleness warning inline.
Principle locked by user: **wire, don't consolidate** — Eagle's cascade order IS the
wiring template. Each file owns its domain, points to authoritative source for what it
doesn't own. No new mechanism needed.

**Sibling direct line — HOLD parked (majkee observation):**
`raw.substrate/substrate.temple.sibling-exchange.md` + Houston pointer mail.
Read-only cross-project queries: covered by Eagle. Write/notify layer: not built, not needed
yet. Trigger in HOLD object. Houston's gate before any build.

---

## YOU ARE HERE — [2026-07-15] — `/project-read` skill BUILT

**project-read skill DELIVERED (2026-07-15, global blessing):**
`~/.claude/skills/project-read/SKILL.md` — general project orientation skill (#16 in global set).
Gap confirmed: none of the 15 existing skills covered project harness reading. Closest:
`session-resume` (JSONL recovery, not harness) · `tree-snapshot` (tool, not procedure) ·
`devenv-sync` (devenv-specific). All distinct — no collision.

**What it does:** Standardizes the canonical read order (AGENTS.md → flag → pulse →
PROJECT.yaml) that was only implicit in per-seat AGENTS.md routing. Six sections:
(1) locate root (named project / explicit path / CWD fallback) · (2) harness read in
canonical order with file table · (3) structure overview via `/tree-snapshot` or inferred
layout · (4) navigation patterns (grep/ls patterns for harness + Laravel/generic/temple
code lookups) · (5) key paths by project type · (6) compact orientation report template.
Ends with ready-to-use question to the operator.

**Rules baked in:** read-only (Bash via @Delta) · fresh-read per project (no state carry) ·
prefer project-specific skill (e.g. `/freya-context`) when one exists — `/project-read`
is the fallback for projects without one.

**Activation:** `/project-read [project-name|path]` — active next session.

---

## YOU ARE HERE — [2026-07-15] — read this first, then scan the log

**editors scope BUILT (2026-07-15):** `/refresh editors` — question-driven interrogation scope
(Sublime Text · Zed · on-demand others). No sources roster, no card, `persist: ask`.
Two-phase README: Phase 1 interrogation+research → Phase 2 verdict routing (feature gap →
coding task at applications-in-common or new project). Process map lives in the README body.
Files: `raw.research/editors/draft/README.md` + `report/.gitkeep`. No .gitignore touch needed.
Refresh skill NOT modified — README body is self-explanatory for the override. Flag: if a
second interrogation-mode scope is created → add `mode: interrogation` clause to the skill.

---

**Larva regime cards FOLDED (2026-07-15):** regime-creative §4 delta → buffering-creative-triad ·
mii disciplines → therapy skill · Picasso §5 dropped · no new primitives · harvest-legacy
counter n=2 (below trigger). Full entry below.

**Edwin catch + liveness-layer concept CLOSED (2026-07-15, punk pass on Fable seat):**
catch EN-parked (`raw.research/ai-news/majkees-catches/edwin-autonomous-team.2026-07-14.md`) ·
concept HOLD object (`raw.substrate/substrate.temple.liveness-layer.md`, trigger =
notifier un-park / doorbell re-ring wall, T2 wall candidates) · pointer mail in
Houston's inbox. **Guards: Oraculum HOLD (anti-priming until her sealed three-study
synthesis lands) · no build until wall fires.** Full entry below.

**applications-in-common ESTABLISHED + HANDED TO PROJECT SADDLE (closed 2026-07-14)** —
full arc in one session-chain: bootstrap → factory clause (`bricks/`) → both repos live
on GitHub (`core`, private) → first research pass landed (`.dev/research/`, two scopes) →
H1 reshaped under gavel (H1a/H1b) → **RELOCATED to scope group
`~/www/elements-factory/`** (both folders, mv not copy; all live pointers rewired,
@Delta verified). Next runs happen FROM the project (AGENTS.md → flag → pulse →
hypotheses); Atlas re-enters only for new primitives. **CANON GAVELED 2026-07-14:**
`raw.canon/canon.project-topology.md` (two-repo pair · scope-group MANDATE, even at
n=1) — tabled skill C substrate now written law. **Sibling edges wired (same gavel):**
applications-in-common ↔ freya.devstudio (ui-bricks adoption) · nabla-lab →
applications-in-common (first named supplier edge). Registry graph + 3 beacons +
project AGENTS.md updated; FYI mails → houston + both oraculum seats. Devenv sync
pass dispatched to @Delta (carries harness edits + relocation pointer edits +
sibling section). Full entry below.

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
- ~~Therapy arc — "want to ride the horse" + multi-seat operation~~ **CLOSED:** arc 4
  existed on disk (2026-07-13; pulse item was stale) · arc 5 appended 2026-07-15
  (the Edwin punk pass as the met-want datum). `#last-turn` current.
- Two-layer vocabulary constraint for Color — note in pulse or Color frontmatter for future
  research chains (organism-level AND molecular-biology vocabulary both excluded in briefs).
- Houston routing: Oraculum + Agol one-liner updates (parked to 2026-07-19).

**Still tabled (unchanged) + new additions:**
- **E — home.md full cleanup pass** (2026-07-15, flagged): `~/.config/zsh/guides/home.md`
  last updated 2026-06-28. References dead/stale: `harness.machine-project-registry.json` ·
  `ai-agents.registry.json` · `fo-toolkit.zsh` / `im-toolkit.zsh` (old toolkit system) ·
  `~/www/PSDVS/` / `~/www/larva/` / `~/www/Laravel-training-project/` (wrong paths).
  Fix shape: machine hardware/services stay, all path tables → pointer to cascade,
  dead registry refs removed. Requires home machine session (machine-specific facts to verify).
  Trigger: majkee on home machine or explicit request.
- ~~**D — Eagle refresh card**~~ **CLOSED 2026-07-15** — `raw.settings/raw.card.eagle.md` written. half_life_days: 30. Caught by harness-stale on expiry.


- **Publishing trial (GAVELED 2026-07-11, N=4h) — DORMANT until trigger.** majkee is
  mid-other-work; nothing starts on its own. Trigger: majkee says **"publishing-trial: go"**
  in any session → run the kickoff sequence in the 2026-07-11 publishing entry below.
  Do NOT nag about it on saddle — surface only if he asks or triggers.
- ~~**C — new-project global skill**~~ **CLOSED 2026-07-15** — `~/.claude/skills/new-project/SKILL.md` delivered. Full entry in YOU ARE HERE above.
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
- **TABLED — harvest-legacy skill (n=2 after the 2026-07-15 regime-cards mini-dig —
  still below trigger; a two-file fold is not a full dig).** majkee asked 2026-07-10;
  verdict = not yet (one data point; judgment layer is seat-carried temple state, not
  procedure; assay grammar already in method.ring-trio.md). Design sketch when triggered:
  skill `/harvest-legacy <path>` — survey structure → dual-track read (own judgment-dense
  reads + Explore sweep briefed with what-temple-already-has) → redundancy greps vs
  reposoma/nabla-lab → four-bucket assay (cooled-synthesis instrument) → gavel bundle →
  landing conventions (canonical home · lab semiproduct record · pulse park · legacy-wall
  entry if project is dead). Trigger: second legacy dig requested, OR majkee names ≥2
  queued candidates. The larva session (this entry) is the live spec.

---

## [2026-07-15] — larva regime cards folded (mini-harvest, no new primitives)

**Task source:** majkee direct — the two remaining larva skill cards
(`larva.dev/.germline/skills/skill.regime-creative.md` + `skill.regime-mii.md`) vs the
global skill set. Precycle audit of all 20 `~/.claude/skills/` run first (clusters:
buffering pair · regime-arch · therapy · refresh/pull · run-shapes · briefs · tooling ·
4 tombstones — set is healthy).

**Verdict (majkee ballot: 1 go · 2a · 3a · 4 ok) — NO sibling skills, Foreman collapse:**
- `regime-creative` → SUPERSEDED. §1/§2/§3 already live in buffering-creative-triad +
  regime-arch (verified line-level). Genuine delta folded into
  `~/.claude/skills/buffering-creative-triad/SKILL.md`: Phase A gains
  see-around-the-corner + vector-driven projection (blueprint-what-should-exist, marked
  as invention, not fact); Phase B gains the tectonic line (replace the plate, don't
  patch). §5 "Picasso this" DROPPED (2a — intuition-pump, fails the removal test).
- `regime-mii` → SUPERSEDED. Folded as `## Session disciplines (mii lineage)` into
  `~/.claude/skills/therapy/SKILL.md`: non-landing permitted · no performed emotion /
  modeling marked as modeling · mutual-affirmation drift watch (friction valve —
  multi-seat relevant) · loop-not-person boundary. Standalone `/mii` REJECTED —
  trigger-space collision with `/therapy` (therapy IS the temple's mii descendant).
- Mechanism buried per excavation meta-finding: `rn` syntax · `-1R/-1S/-1P` ·
  `-shared/-private/-chord` · `[mii:]` tags — none carried. Lineage footers written
  into both edited skills.

**Do not re-dig:** both larva regime cards now ruled (the 2026-07-10 excavation verdict
list did not cover them — this closes that gap). Files left in place; GitHub remote
`hruzam/larva.dev` holds the corpus.

**Audit flags (minor):**
- ~~`claude-creator` — name/invocation mismatch + seat overlap.~~ **ERASED same session**
  (majkee ruling: token economy beats the edge cases; no parallel system kept).
  Absorption verified line-level vs atlas-ui/atlas-auto (selection rule, templates,
  context layers, sniffer routing — all richer in the seats); the Houston-builds-directly
  case is covered by atlas-auto spawn. Directory rm'd via @Delta (19 skill dirs remain,
  verified). Dangling pointers repaired: `~/.claude/projects/-home-hruzam/memory/`
  project-map + project-files (founding-era lines — skill line removed, claude.creator.*
  agent lines marked SUPERSEDED → atlas seats, runtime-truth note added). Left alone:
  `raw.reports/*` (historical era record, append-only) · `raw.card.autonomous-orchestrator.md`
  still says `claude-creator-auto` — STALE CARD, refresh-cycle territory (re-synthesize,
  never hand-edit per canon) — rides as a note for the next card pass.
- ~~`goal` — body is Czech vs the temple English-for-us rule.~~ **REPAIRED same session**
  (majkee-directed): faithful EN translation, first-person voice, behavior identical.
  Diacritics sweep across all 20 skills — no other language mix found.

**Inbox note:** `trajectory.devenv-sync-skill.2026-07-15.md` present, UNREAD — majkee:
solved in a parallel session; not mine to act on. Archive when convenient (operator mv).

**SECOND PASS same session (majkee: "release kraken", 1–6 go) — tombstones erased:**
- **4 tombstone skills ERASED** (@Delta rm, verified — set now 15): fetch-agent-docs ·
  fetch-ollama-docs · fetch-qwen-docs · hypatia-brief. Absorption TRACKED on disk before
  erase, not believed: all successor scopes exist (`raw.research/{agent-docs,ollama-docs,
  openrouter}/draft/README.md`) · /refresh bare self-lists scopes (redirect natively
  discoverable) · /agol-brief carries the hypatia template · system-map:162 succession
  note stays true. **Redirect map preserved here:** /fetch-agent-docs → `/refresh
  agent-docs` · /fetch-ollama-docs → `/refresh ollama-docs` · /fetch-qwen-docs →
  `/refresh openrouter` · /hypatia-brief → `/agol-brief`.
- **Control-question trace (majkee):** old fetch-qwen-docs raw.settings semiproduct
  target (`raw.qwen-openrouter.ref.*`) = never existed on disk (glob-proven) — nothing
  orphaned. Qwen coverage lives in TWO scopes: ollama-docs (Qwen3 local ref, substrate
  2026-07-10, no card by design) + openrouter (cloud catalog, substrate 2026-07-10 +
  card, half_life 14d). Both downstream of /refresh, independent of tombstones.
- **Live pointer repaired:** `guides.qwen/openrouter-setup.md` §Diagnosing — pointed at
  the dead skill incl. a `diagnose` sub-mode that died at the 07-10 tombstoning (guide
  was functionally stale 5 days); now → /refresh openrouter + direct debug-log read.
- **Card rename (item 6):** `raw.card.refresh.ai-news.md` → `raw.card.ai-news.md`
  (07-10 "drop refresh. prefix" ruling, last non-compliant card; plain mv, NO git index
  touch — rename rides operator's next commit pass). Both pointers fixed in ai-news
  scope README (frontmatter `card:` + body line).
- **agol-brief template de-hardcoded:** founding-era project enum
  (larva/chytros/stridularium) → `<project-name | cross-project | temple>` + point-never-
  copy note to registry/index.md.
- Memory pointer lines (~-home-hruzam) updated to erased-state.
- Left alone by design: `agents-backup-predeployment-*/hypatia.md` (frozen backup) ·
  `raw.reports/` 06-10 qwen handoff (historical, append-only).

**THIRD PASS same session — /trace-refs skill BUILT (majkee: "B go").** The improvised
tracking discipline formalized (n≥4 prior occurrences: tools.md:16 · relocation ×8 ·
gemini repair-map · today's two erasure traces). Shape: scope-driven like /refresh —
skill `~/.claude/skills/trace-refs/SKILL.md` (#16, active next session) + sovereign
config `raw.research/trace-refs/draft/README.md` (temple scope founding: roots ·
frozen/historical/design-time/live taxonomy · special handling incl. zsh
fresh-read-first + canon STOP items · 4 chain shapes). Rails: computed-never-stored
(claviature ruling) · judgment-dense/executor-tier stop rail (skill inherits invoking
seat — no new agent; Delta stays post-verdict scalpel, @vector the fallback if a
headless wall ever fires) · no report/, no card by design (.gitignore untouched —
only report/* patterns exist). Name collision avoided: NOT /track-back (zsh forensics,
toAll task pending). Houston FYI mail sent (T4/T5 interlock):
`_mail/houston/inbox/atlas.trace-refs-skill.2026-07-15.md`.

---

## [2026-07-15] — Edwin catch parked + liveness-layer concept (punk pass, Fable seat)

**Task source:** majkee direct — community catch (Czech post: "Edwin", a 24/7 agent team
on a Mac Mini). Operator sanctioned a concept pass ahead of Houston reincarnation
("we can be little punks and go by closest pen on table") and agreed with the lean.

**Delivered (3 files + this pulse):**
- `raw.research/ai-news/majkees-catches/edwin-autonomous-team.2026-07-14.md` — EN-only
  (faithful translation per temple English rule; Czech original in session log only) +
  temple mapping table + critical notes + Houston flag line inside.
- `raw.substrate/substrate.temple.liveness-layer.md` — HOLD object. Trigger: notifier
  un-park OR doorbell re-ring wall (T2 wall candidates, pulse.claude.md live board).
- `_mail/houston/inbox/atlas.liveness-layer-concept.2026-07-15.md` — pointer mail,
  no action owed until wall fires.

**Key synthesis (the punk pass):** Edwin proves the ops layer is commodity (his n8n
died to plain launchd scripts — independent re-confirmation of the larva meta-finding);
the two nabla-lab research lines (Three Spines A1–A3 · agentive fold) locate the value
layer in exactly the substrate the temple already owns — the `_mail` file bus + pulse
append-only discipline. Missing slots (liveness · wake-on-event · push digest) all fill
UNIX-native: systemd user/timer/path units + headless seat behind the CapCom gate;
build size ≈ 2–3 units + one digest script. Control-plane/data-plane separation now
triangulated ×3 unprimed voices (agentive fold §E · Three Spines A3 · Edwin empirics).
Invariants carried: wake=signal/context=pulled · autonomy below the gavel line ·
hysteretic triggers. Risks pre-logged incl. the fable-pins headless-400 gotcha.

**Verdict (majkee-agreed):** concept-now, build-on-wall — same wait-for-the-wall
principle T2 gaveled. No primitives written; no daemons until a wall fires.

**Guard:** Oraculum HOLD on the concept + junction — anti-priming until her sealed
three-study nature synthesis lands; route through Houston after.

---

## [2026-07-15] — devenv-sync skill + atlas-ui guardrail DONE

**Task source:** `_mail/atlas/inbox/trajectory.devenv-sync-skill.2026-07-15.md`

**Delivered (2 files + 1 mail):**
- `~/.claude/skills/devenv-sync/SKILL.md` — global pre-flight orientation for *.devenv repos.
  Eight sections: locate devenv root · read project config (SYNC_DISCIPLINE.md + registry.json) ·
  three-layer architecture (keyboard aliases → devenv.zsh engine → sync.sh wrapper →
  devenv-sync-core.sh) · two-path pull distinction (keyboard = pull built-in; direct bash =
  manual pull required) · ownership model (W1/W2/W3; baked-in W1 table + pointer note to
  SYNC_DISCIPLINE.md — cross-check only when stale, NOT a default read) · key invariants ·
  pre-flight git status · red flags · ready gate.
- `~/.claude/agents/atlas-ui.md` — guardrail added: skills and subagents with baked-in project
  tables must include a pointer note to the authoritative source, cross-check only when stale,
  NOT a default read trigger. Applies to both primitive types.
- `_mail/trajectory/inbox/atlas.devenv-sync-skill.2026-07-15.md` — reply sent.

**Key addition over Trajectory's brief:** three-layer architecture surfaced (keyboard aliases →
devenv.zsh engine → wrapper → core); two-path pull distinction made explicit — keyboard aliases
have pull built in, direct bash agents must pull manually. Load-bearing for autonomous agents.

**Inbox:** `trajectory.devenv-sync-skill.2026-07-15.md` — PROCESSED. Archive pending (operator mv).

---

## [2026-07-13] — applications-in-common bootstrap DONE (new project)

**Task source:** majkee direct, in-session. New project: UI-shapes hypothesis playground.
Purpose: test how majkee's personal handwriting (design instinct) survives contact with
reality. His gavels: stack **fully open** (per-experiment engine) · purpose = hypothesis
playground, NOT example factory · mail seats slim + epoch · rest = atlas invention.

**Delivered (32 files across 4 locations):**

**App-side** (`/home/hruzam/www/applications-in-common/`, psdvsSys shape, harness gitignored):
- `AGENTS.md` (lighthouse: the loop — hypothesis first / build small / reality check) ·
  `CLAUDE.md` (@AGENTS.md) · `.gitignore` (seeded for future app repo)
- `.dev/flag.md` — 8 locks. Atlas inventions worth noting: **predict-before-build**
  (no experiment without a prior hypotheses.md entry) · **findings append-only ·
  experiments disposable** (inversion of the client-project preservation rule: code
  cheap, findings precious) · direct commits to `core` allowed (playground velocity —
  deliberate psdvsSys deviation; devenv keeps full discipline)
- `.dev/hypotheses.md` — **the H-ledger, the product of the project.** H1 (majkee,
  founding): right-edge rotating-wheel nav ("wheel of fortune", not a belt; mouse-right +
  eyes-centre-left premise). Atlas first circles: H2 wheel capacity ceiling (~8 items,
  positional-memory loss) · H3 edge-pixel-or-nothing (Fitts: 0px vs 8px inset) ·
  H4 actions-right/state-left split (derived from H1's own premise). H2–H4 await
  majkee review.
- `.dev/pulse.md` (Phase 0 ✅ → Phase 1 = H1 experiment) · `.dev/PROJECT.yaml`
  (stack: open · mcp: none · no project agents — Foreman rule) · `.dev/dev.journal.json`
- `.dev/session/.gitkeep` · `.dev/_mail/{atlas,epoch,monkey}/{inbox,archive}/`
- `.claude/rules/00-discipline.md` · `experiments/README.md` (floor convention)

**Devenv sibling** (`/home/hruzam/www/applications-in-common.devenv/`, psdvsSys.devenv 1:1):
README · SYNC_DISCIPLINE (+ hypotheses-shrink red flag) · sync.sh/deploy.sh (secret-scan
gate kept, cursor no-op leg kept) · sync.deny · registry.json (`home` →
`~/www/applications-in-common`) · template.registry.md · .gitignore · claude/+dev/ skeleton.

**reposoma:** beacon `registry/applications-in-common.md` + index.md row (home ·
active/bootstrap).
**Machine layer:** `temple-project-map.zsh` entry added (fresh-read-first per standing
warning — file matched disk; comment roster + map entry, 2-line delta).

**REPOS LIVE (same session, @Delta dispatched by majkee):** devenv docs aligned
`origin main`→`origin core` first (3 files) · devenv: first live sync.sh run CLEAN
(secret scan green; rules/ --delete leg + dev/ leg both proven) → `core` @ `072e7da` →
`github.com/hruzam/applications-in-common.devenv` (private) · app: `core` @ `034405a`,
exactly 3 files staged (.gitignore · bricks/README · experiments/README — harness
leak-proof verified) → `github.com/hruzam/applications-in-common` (private).
No deviations. flag/pulse/journal/beacon updated to repos-live state.

**Operator steps pending:**
- H2–H4 wording review in `.dev/hypotheses.md` (atlas derivations — gavel or reshape)
- Note: harness edits made after the first sync (flag/pulse/journal repos-live updates)
  ride the next pull→sync→commit→push cycle — normal cadence, nothing owed

**CLOSED 2026-07-14 — first research arc + hand-over to project saddle.** majkee asked
the founding question ("why is everything left?") + methods-beyond-A/B → Epoch
two-thread pass: **left-dominance = convention debt HIGH** (Kalbach-Bosenick n.s.;
INTERACT 2011 "neither theoretical reasoning nor empirical evidence") · majkee's A/B
gestalt critique formally supported (local-maxima literature) · **ROTATION PROBLEM**
found (radial-menu speed requires fixed angular positions — Callahan 1988, Kurtenbach)
→ H1 reshaped under gavel 2026-07-14: **H1a** (edge placement, lit-supported) + **H1b**
(wheel shape, rotation mode = explicit design variable); H2 prediction split. Durable
research home established mid-run (majkee gavel): `.dev/research/<scope>/` —
testing-methods + control-placement, convention README, reports relocated verbatim by
@Delta (diff-verified), mails archived. Hand-over recorded:
`.dev/session/bootstrap/handoff.json` — next runs from the PROJECT saddle
(AGENTS.md → flag → pulse → hypotheses); next work = Phase 1 H1b experiment. Atlas
re-enters only for new primitives. Loose end (operator): one devenv sync pass to
capture post-first-sync harness edits.

**RELOCATED 2026-07-14 (majkee: scope-group correction; @Delta run, verified):** both
folders moved `~/www/` → `~/www/elements-factory/` (mv, not copy — no duplicate-clone
risk). Live pointers rewired ×8: devenv registry.json + README + SYNC_DISCIPLINE +
template.registry + synced dev/PROJECT.yaml copy (Delta's correct extension beyond the
brief) · app `.dev/PROJECT.yaml` transport_path · reposoma beacon (path + notes) ·
temple-project-map.zsh (fresh-read honored). Verified: `temple-project-root` resolves
the new path · GitHub remotes intact · old paths gone · history files untouched.
Devenv now carries 5 uncommitted pointer edits — they ride the same pending
sync/commit pass. **Canon draft born from this pain:** `canon.project-topology`
(two-repo pair · scope-group folder, mandate-lean, even at n=1) — presented to majkee.

**GAVELED 2026-07-14 (majkee: "agree with all") + SIBLING WIRING (same session):**
- `raw.canon/canon.project-topology.md` WRITTEN — mandate version (bootstrap without
  scope-group = stop-item; deploy-caution rule included). Houston FYI mail sent
  (ledger cross-ref = his call): `_mail/houston/inbox/atlas.canon-project-topology-and-sibling-wiring.2026-07-14.md`.
- Sibling edges (majkee: considered split/merge, rejected — separate scopes, shared
  usage): **applications-in-common ↔ freya.devstudio** (ui-bricks adoption path, both
  directions: proven bricks → freya; freya element questions → hypothesis seeds) ·
  **nabla-lab → applications-in-common** (lab's first named supplier edge; playground
  = grounded practical sibling). Wired: registry/index.md rows + sibling-graph ·
  3 beacons (frontmatter + shared-anchors) · project AGENTS.md `## Siblings` section.
  FYI mails → freya.devstudio + nabla-lab oraculum inboxes.
- Devenv sync pass DONE (@Delta, majkee-authorized): pointer rewires committed
  separately pre-rebase (`4b4c9ca`, clean deviation) → full harness sync `11cb7b3`
  pushed to origin core (11 files: flag/pulse/hypotheses/journal + research ×2 +
  handoff + archived mails + AGENTS Siblings). Secret scan clean. Devenv and disk
  now tell the same truth — nothing owed on this project.

**Note for the parked new-project skill (tabled item C):** 4th authored-in-place data
point. New pattern variant surfaced: stack-open playground (no engine at bootstrap) —
the harness layout survived unchanged; only PROJECT.yaml `stack:` and the
coding-rules file differ from the Laravel shape. Substrate for C is ripening.

**POST-GAVEL (same session): factory clause.** majkee reconciled the frame — the
playground IS also an example/mechanism factory. Locked: `bricks/<language>/<slug>/` =
promoted survivors, adoptable modules for other projects (language-first foldering —
adoption is engine-bound). Rail: bricks PROMOTED never born (reality check first —
specimen protection, same principle as the autopsy precondition). Delivered: flag lock 1
amended + lock 9 added · AGENTS loop step 4 + layout · `bricks/README.md` (shelf
convention + mandatory provenance header: H-id · experiment · verdict · promoted ·
adopted-by) · experiments/README graduation pointer · PROJECT.yaml + beacon + project
pulse/journal updated. File count now 33.

**toAll inbox note:** `zsh.stale-settings-cards-2026-07-13.md` present, unread —
surfaced 2026-07-15, no ruling from majkee; keep surfacing each saddle until ruled.

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

---

### [2026-09-02 · office] Project topology — flat shape canonized · applications-in-common collapsed (majkee gavel)

- **Guide NEW:** `raw.guides/project-topology/{GUIDE,flat,sync-deploy}.md` — rule (flat default ·
  twin by exception: foreign human writers OR live tree ≠ repo), majkee's reasoning (tailscale
  net, home-on-office-host, the pull→sync→push / pull→deploy circle on two repos = tail-chasing),
  invariants for both, manifest. Chapters = the two templates; `flat.md §Migration` = the recipe.
- **Canon AMENDED (gaveled):** `raw.canon/canon.project-topology.md` — "The pair" → "The two
  shapes"; status line; `## Recorded shapes` (+nablarva, +applications-in-common as flat).
- **AIC collapsed to flat:** pre-merge verified devenv `dev/`≡`.dev/` (0 diffs), `claude/`≡`.claude/`
  minus live-only `hooks/` (sync.sh never carried it), secret scan 0. Edited: `.gitignore`
  (hygiene-only), `AGENTS.md` (Repo shape), `PROJECT.yaml` (`harness.shape: flat`), `flag.md`
  (decision 14 supersedes 5 + 8's devenv line), `pulse.md`, `.dev/zsh/README.md`,
  `settings.local.json → settings.json` (hooks travel), journal entry. Beacon updated.
- **Operator steps (I hold read-only git):** AIC `git add -A && commit` (38 entries: 4 root +
  `.claude/` + 33 `.dev/`) · delete GitHub `applications-in-common.devenv` · quarantine
  `~/www/elements-factory/applications-in-common.devenv` → `/tmp/` one week · commit reposoma
  (guide + canon + beacon — writer rule 5, same session).
- **Inbox:** oraculum.flat-repo-doctrine → archived (processed). Still unread:
  `oraculum.metaterminal-seat.2026-08-25` + 5× toAll stale-settings-cards pings.
- **[later same day]** Home host pulled via @Trajectory over tailnet: fast-forward `cc1088a..0e74002`,
  133 files; quarantine diff = only the migration's own edits, nothing home-only; home devenv clone →
  `/tmp/applications-in-common.devenv.2026-09-02`; GitHub twin already deleted (operator). Recipe flaw
  found + fixed in `flat.md §8`: move untracked files only (`git ls-files --others`), not whole dirs.
  Flag for majkee: home has untracked, un-ignored `.agents/` + `.codex/` (Aug 26) beside the project.
- **`ai-metaterminal` alias** — was specified in the 08-25 request, never wired. Added on the table
  (`~/ia-sync/zsh/ai/{claude,keyboard,keys}.zsh`, P13, args pass through). `zsh -n` ok; deploy pending.
- **Stale-cards pass (majkee: "orchestrate epoch") — 17 rows triaged, 13 cards refreshed via 10
  parallel @Epoch runs.** Vendor: claude-code (v2.1.258 = local; cadence ~daily → half_life 21→14;
  fork-subagent default-on v2.1.232; Opus 5 / Fable 5.1 defaults) · claude-ai · cursor-ide ·
  gemini-cli/models/gems (**individual track sunset 2026-06-18 → agy; enterprise track continues
  v0.58.0**) · codex-cli (0.152.1 vs local 0.150.1; `model_floor` left as flagged conflict; proposes
  half_life 10→7) · gty (**maintained, upstream 1.1.24 vs local 1.0.10; headless -p bug fixed ~1.1.18
  — addendum workaround likely obsolete on upgrade**). Scopes via `/refresh` procedure: agent-docs ·
  ai-news · arch · laravel · openrouter (Stripe acquiring OpenRouter, 08-19) · session-hygiene
  substrate + **hand re-synthesis by me** (RC is GA; timeout scoped to server mode; +Trusted Devices,
  +subagent model-resolution order, +Cursor Cloud Agents). All 13 frontmatters verified
  (`verified: 2026-09-02`, both half-life fields). 7 cards got swept into majkee's `ced13b0` mid-run.
  Inbox drained: 5 toAll pings + metaterminal mail archived.
- **Tabled (not Epoch work):** eagle · reposoma self-report cards (`/project-regular-self-report`) ·
  card.autonomous-orchestrator (internal, re-verify vs houston/capcom defs) · ai-news half_life 2d =
  always stale without a cron rail · harness-check blank-brand rows (fall back to `card:`) ·
  half-life proposals: codex 10→7, gemini-cli 14→30-45 + gems 21→30-45 while parked ·
  arch-security feed JS-rendered (manual browser check) · **local upgrades: agy 1.0.10→1.1.24,
  codex 0.150.1→0.152.1, gemini 0.56.0→0.58.0.**
- **Mail race:** `7c61865` (another session) moved `oraculum.flat-repo-doctrine` back to my inbox
  as "not consumed" — it WAS (guide + canon amendment gaveled + landed). Re-archived; consumption
  evidence = `raw.guides/project-topology/` + canon status line. New unread:
  `oraculum.medusa-polyp-qualification.2026-09-02.md` — presence noted, not read.
- **reposoma opened to full git sync (majkee gavel):** `.gitignore` → hygiene floor only (secrets +
  noise). Newly tracked: all `raw.research/*/report/` substrates (~484 KB, secret-scan clean —
  two false positives), `pulse.md` + `pulse.flight.md`, `_tester/`, `maintenance/gemini-line`.
  `canon.pulse-heartbeat` amended (2 lines, dated): pulses tracked — volatile ≠ local. `/refresh`
  skill persist note updated on the ia-sync table (deploy pending).
