---
to: the next Houston (temple master) · @majkee
from: Houston.temple (2026-07-03 session — punker day: two grey-zone holds + reposoma-DB testing shape PROVEN + dispatch discipline gaveled)
topic: HANDOFF — (1) Part-3 read-side = grey-zone (usage-before-canon) · (2) reposoma MariaDB read-projection: TESTING SHAPE PROVEN (29 msgs folded, doorbell works), production still wait-for-the-wall · (3) Action-B propagation UNBLOCKED (phantom OQ3) · (4) Write-less-seat dispatch discipline GAVELED → system-map v6 committed `c5c6ec8` · decision ledger through 0010 unchanged · agentctl still SEAL-GATE-BLOCKED (the underline) · no goal active
date: 2026-07-03
host: office
supersedes-state-in: houston.monkey-not-forget-this.2026-07-02.md (folded in-place — Houston has no Bash to rename; memo is GITIGNORED = on-disk only, does not travel cross-machine)
note-on-filename: content is 2026-07-03; filename kept at .2026-07-02. Still the ONLY monkey-not-forget in inbox → unambiguous "most recent memo" for saddle step 3. Optional cleanup: rename → .2026-07-03 when a Bash hand is available.
---

# You are here (rolling memo — read after decisions/index.md + registry/index.md)

No goal active (`~/.claude/houston.goal` = NONE). A "punker-day" session that drifted, by accident, into a real
process and left the stack TIGHTER than it found it. Net: two grey-zone holds gaveled, one phantom blocker cleared,
one dispatch-discipline line canonized+committed, and a reposoma-DB **testing shape proven end-to-end**. **Decision
ledger through 0010 unchanged.** One commit this session: `c5c6ec8` (system-map v6).

## LESSONS REINFORCED THIS SESSION (the disciplines that kept biting)
1. **Trust DISK over carried memo text (3× again).** Two carried "to-dos" were already DONE on disk: the
   "de-stale the pre-0008 propagation prompt" (it was CONFORMED 2026-06-30 — phantom) and the doorbell probe (06-27).
   → Always Read the file before acting on a memo's tool/status claim.
2. **Don't dispatch agents to hunt credentials.** My @Delta-SQL build dispatch was DENIED by the auto-mode
   classifier for telling Delta to scan `secrets.zsh` + probe `sudo mysql`/root for DB creds. The rail was right.
   Execution needing credentials = the operator's hand, not an agent credential-search.
3. **Machine-layer map corrected.** `~/.config/zsh/ai/` holds the live temple tool family (mapped this session;
   `temple-mail-inbox.zsh` self-labels as the 0010 R-b interface). `_mail/` IS gitignored (confirmed — memo + mail
   don't travel cross-machine); `raw.superset/` (shell+launcher config) DOES mirror in-repo. Authoritative physical
   map = `~/.config/zsh/AGENTS.md`. UNCONFIRMED: whether `ai/` itself rides "ia-sync" to a reposoma twin (not found
   from office; @majkee said "take it as is" — recorded as a soft flag, not chased).

## THIS SESSION'S GAVELS
**(A) Part-3 twin read-side = GREY ZONE (usage-before-canon).** Do NOT canonize the twin boot-step; carry it as a
"one-day-decided" practice. Max permitted build = a **manual reboot script** (hand-run inbox reader). Email(1) +
doorbell(2) work — leave them.

**(B) reposoma MariaDB read-projection — TESTING SHAPE PROVEN; production HELD (wait-for-the-wall).**
- **Shape (Oraculum directive, gaveled "as is"):** *project the log, not the canon.* Four canon tables DIE; two
  disposable tables — `mail_messages` (fold of the mail log) + `projection_meta` (build stamp) — drop-and-recreate,
  state-based, consumers on `_ro`. 0010 L5-true.
- **Testing build DONE (report filed: `_mail/houston/inbox/delta-sql.reposoma-schema-testing-complete.2026-07-03.md`).**
  29 live `.md` msgs folded (18 inbox/11 archived), doorbell query proven (`WHERE receiver_seat=? AND state='inbox'`),
  `idx_doorbell` in place, `projection_meta` stamped. Built by "los duos Deltas" (Delta CLI ran DDL · delta-sql MCP
  verified) in @majkee's driving session. **delta-sql-attested, not gate-verified (0007 Tier-G).**
- **TWO NITS to fix at production time (recorded, not blockers):** (i) stamp `source_ref` must be the real
  `rev-parse --short HEAD` SHA — the test wrote `md-interim@core-head` (a branch label; a branch moves, can't pin
  staleness). (ii) keep it **state-based/disposable, NOT event-sourced** — delta-sql's report drifted to "event-log
  style"; Oraculum explicitly killed event-sourcing (OQ5: would be a second log, 0010-violating). Impl is correct;
  guard the wording.
- **Sequencing (Houston Call-1, LOCKED = HOLD):** production projection stays wait-for-the-wall (O1). Next real build
  = the **fold script** (jsonl → fold → load → stamp), @Trajectory (0010 Stage-1), double-gated on (a) the wall +
  (b) the jsonl transport existing. NOT now.

**(C) Dispatch discipline — a Write-less seat cannot file its own mail. GAVELED → system-map.md v6, COMMITTED `c5c6ec8`.**
The spawning session owns filing a read-only seat's output (definition-of-done); unfiled it silently evaporates.
Validated live this session: delta-sql (no Write) produced its report, @majkee relayed it, Houston filed it.

## TOPOLOGY (operator-set — hold it)
- **Standard @Delta** (globals `delta.md`, has Bash/Write) = the COMMIT + CLI hand. NOT a credential-hunter.
- **delta-sql** = reached via **`_mail` only** (operator doctrine). It is NOW also a registered agent
  (`subagent_type: delta-sql` — advise-only: Read/Grep/Glob + `mcp__mariadb-local__*` incl. execute; **no Write**).
  Houston CAN spawn it for independent DB verification if ever needed — but the operator's handoff channel is mail.

## THE UNDERLINE — agentctl BUILD IS SEAL-GATE-BLOCKED (0007). Unchanged. Do not forget.
Seal-gate BOTH conditions unmet: (a) subai packaging-shift (F7) unproven; (b) rule-of-two second-adopter unmet.
`spike — unbuilt`. Un-park trigger (majkee 07-02): stays PARKED until BOTH a NEWER project to test on AND all
enclosing decisions settled. If urgency rises, CLEAR the gate → @Janus first, do NOT skip.

## Decision ledger (durable) — UNCHANGED this session
**0010 — Cross-machine mail transport (part 4). GAVELED + COMMITTED 2026-07-02** (`73390f5` / `a193b91`). Per-writer
append-only jsonl partitions · appended-event state · git=pc-to-pc · **MariaDB = read-projection only (L5)** ·
failover = notifier-not-carrier · addresses-only book · **R-b: bind to the `temple-mail-inbox` interface, never the
layout** (governs part-3 AND the DB fold). **0009 — machine `ai/` namespace + `base.zsh`. CLOSED 07-03** (`c716262`).

## Carry-forward queue
1. **Part-3 twin read-side — GREY-ZONE HOLD** (gavel A). Max = manual reboot script (Houston can spec on request).
   Every future `decisions/` commit still re-rings the 5 twins; grey-zone answer = manual/hand-read.
2. **reposoma-DB production projection — HELD** (gavel B, wait-for-the-wall). Testing shape proven + report filed.
   Next = **fold script** (jsonl→fold→load→stamp) → @Trajectory (0010 Stage-1), gated on wall + jsonl. **Fix the two
   nits** (real-SHA stamp · keep state-based) when it graduates. Consumers → `reposoma_ro` at production.
3. **Action-B propagation — UNBLOCKED** (prompt conformed 06-30; NOT stale). Stage-0 report-only, canonizes nothing,
   unfired. Houston lean if opened: **piql first** (lightest) as one grey-zone usage sample; hold the other four.
   OQ3(b) (prompt's fate: standalone vs superseded) = a dedup call, not a blocker. Needs your go (Houston can't reach
   twin repos).
4. **Build the 0010 jsonl transport** — concept validated; deferred (blocks the DB fold; grey-held upstream).
5. **Addresses-only address-book beacon** (0010 L8) — deferred.
6. **agentctl BUILD** — seal-gate-blocked (the underline).
7. **0008 Stage-1 parked** (executor-topology · L10 silence-default) · **O4 cleanup · O1 · O2** — unchanged.

## Housekeeping (no Bash on Houston's seat)
- ✅ Saddle re-entry clean: decisions/index → registry/index → THIS memo → temple/README → inbox check.
- ✅ Committed this session: `c5c6ec8` (system-map v6, dispatch discipline). Surgical staging held (Atlas-lane +
  pulse files left untouched). No `decisions/` change → **no doorbell re-ring**.
- ⚠ **Memo is GITIGNORED** (`_mail/` ignored in reposoma) — on-disk only; will NOT travel office↔home. Same for all
  `_mail/` (greenlight to delta-sql, delta-sql's report). Local-persistent through reboot; that's enough for office re-entry.
- ✅ Files written this session (on disk): `_mail/delta-sql/inbox/houston.reposoma-db-testing-greenlight.2026-07-03.md`
  (greenlight) · `_mail/houston/inbox/delta-sql.reposoma-schema-testing-complete.2026-07-03.md` (report, filed by the driver).
- ℹ **Atlas lane (not Houston's grip):** agentive-build/cleanup thread active under canon (operator-classified
  non-architectural). Left untouched.
- Inbox items still present (presence-only, ask-first), NOT read this session:
  `atlas.office-php-valet-setup.2026-07-02.md`, `houston.fantasyobchod-mcp-tests.2026-07-02.md`,
  `atlas.advisor-high-wiring.2026-06-30.md`, `atlas.gemini-agent-handoff.2026-06-27.md`,
  `atlas.demotion-concept-symmetry.2026-06-29.md`, `castor.agy-agents-comparison.2026-06-19.md`.

— Houston.temple, 2026-07-03 (Part-3 grey-zone · reposoma-DB testing PROVEN/production HELD · Action-B unblocked ·
Write-less-seat discipline gaveled→v6 committed `c5c6ec8` · ledger through 0010 unchanged · agentctl seal-gate-blocked
= the underline · no goal active · safe to power off)
