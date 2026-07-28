# Temple Audit Report — Contradictions, Reachability, and Consolidation Proposals

This is the comprehensive report based on a systematic analysis of `AGENTS.md`, `temple/`, `registry/`, and `raw.guides/`.

---

### **(1) Cross-File Contradictions**

There are active architectural and configuration contradictions between the locked decision records (ADRs), the live-cast configuration files (`roster.md`), and the system mapping documents. 

#### **Contradiction A: `@CapCom` Model & Effort Assignment**
* **Side A (Locked Decision 0006):** Defines `@CapCom` as a low-effort Haiku seat.
  * **Citation:** `temple/decisions/0006-model-effort-assignment.md` (Lines 63–64):
    > `| @CapCom | haiku | low | Human gate — reads houston.goal, assesses risk, awaits confirmation, then spawns Houston |`
* **Side B (Live Roster & System Map):** Casts `@CapCom` as a Sonnet model, with the system map specifying `high` effort.
  * **Citation:** `temple/roster.md` (Lines 67–68):
    > `| @CapCom | `capcom` | Sonnet | Mission controller — human gate before Houston gets full autonomy |`
  * **Citation:** `temple/system-map.md` (Line 12):
    > `CAP["@CapCom · Sonnet<br/>human gate · reads houston.goal"]`
  * **Citation:** `temple/system-map.md` (Line 74):
    > `└─ @CapCom (Sonnet · high)             ← human gate; reads houston.goal, assesses risk, awaits "ano"`

#### **Contradiction B: `@Agol` Model Assignment**
* **Side A (Locked Decision 0006 & System Map Dispatch):** Configures `@Agol` on Opus due to Fable being pulled.
  * **Citation:** `temple/decisions/0006-model-effort-assignment.md` (Lines 55–56):
    > `| @Agol | opus | high | Synthesis / continuous advisor (was Fable; Fable 5 pulled 2026-06-25) |`
  * **Citation:** `temple/system-map.md` (Line 80):
    > `├─ @Agol  (Opus · high)      ← synthesis advisor; spawned when cross-phase reasoning needed`
* **Side B (Live Roster, System Map Diagram, and System Map Preamble):** Shows `@Agol` running on Fable.
  * **Citation:** `temple/roster.md` (Lines 59–60):
    > `| @Agol | `agol` | Fable | Continuous-reasoning advisor — cross-phase synthesis, non-adversarial, no verdict forced |`
  * **Citation:** `temple/system-map.md` (Line 21):
    > `AGOL["ADVISOR // @Agol · Fable · effort:high<br/>cross-phase synthesis · no verdict"]`
  * **Citation:** `temple/system-map.md` (Line 5):
    > `v5: @Agol model update: Fable returned 2026-07-02; stale Opus note cleared from definition.`
  *(Note: This creates an internal contradiction within `temple/system-map.md` between its preamble, its Mermaid diagram, and its dispatch hierarchy list.)*

#### **Contradiction C: `@Janus` Effort Level**
* **Side A (Locked Decision 0006 & System Map):** Dictates `@Janus` must run on `xhigh` effort to exceed the architect's reasoning envelope.
  * **Citation:** `temple/decisions/0006-model-effort-assignment.md` (Lines 53–54):
    > `| @Janus | opus | xhigh | Adversarial challenger — must exceed Houston's reasoning envelope |`
  * **Citation:** `temple/system-map.md` (Line 22):
    > `JAN["CHALLENGER // @Janus · Opus · effort:xhigh<br/>one verdict · one risk · read-only"]`
  * **Citation:** `temple/system-map.md` (Line 78):
    > `├─ @Janus (Opus · xhigh)     ← challenge-before-lock; adversarial; spawned for any big decision`
* **Side B (Live Roster):** Restricts `@Janus` to `high` effort.
  * **Citation:** `temple/roster.md` (Lines 65–66):
    > `| @Janus | `janus` | Opus · effort:high | Challenger — second voice before a decision locks: one position, one primary risk, one alternative. Read-only. ...`

#### **Contradiction D (Meta-Contradiction): Retroactive Editing of Decision 0006**
* **The Rule:** Decisions are append-only and immutable.
  * **Citation:** `temple/decisions/index.md` (Line 7):
    > `rule: ADRs are append-only — superseded, never edited (doctrine §1b).`
* **The Reality:** Decision 0006 was locked on **2026-06-25** and contains `@Oraculum` in its model matrix (`temple/decisions/0006-model-effort-assignment.md`, Line 57), while retiring `@Hypatia`. Yet, `@Hypatia` was actively retired and `@Oraculum` seated only on **2026-07-02**, proving that Decision 0006 was edited in-place retroactively rather than appended.
  * **Citation:** `temple/system-map.md` (Lines 5–6):
    > `v5: @Hypatia retired → @Oraculum seated (Fable · effort:high) — scientist-tier, user-invoked Houston alternative, 2026-07-02.`

---

### **(2) Unreachable Files (The Dark Nodes)**

Starting *only* from `AGENTS.md` and following the chain of markdown hyperlinks, a reader can never reach the following files inside `temple/`, `registry/`, and `raw.guides/`. 

#### **Unreachable in `temple/`:**
1. **`temple/decisions/0001-sovereign-build.md`**
   * *Why:* The main index table in `temple/decisions/index.md` does not contain a full-record hyperlink to this file.
2. **`temple/decisions/0002-force-4-gate-not-direction.md`**
   * *Why:* Mentioned as text, but lacks a full-record hyperlink in `temple/decisions/index.md` (unlike decisions 0003–0010).
3. **`temple/tools/tools.md`**
   * *Why:* Although `0007-tool-lifecycle-publishing.md` refers to the *concept* of a dedicated Tier-S `tools.md` escape valve, it does not link to the file itself. No other files point here.
4. **`temple/tools/circuit-characterization.2026-06-25.md`**
   * *Why:* Stale research/measurement log; completely unreferenced.
5. **`temple/tools/transport-and-doorbell.spec.md`**
   * *Why:* Referenced only from `tools.md` and `transport-and-doorbell.build-report.md` (both of which are unreachable).
6. **`temple/tools/transport-and-doorbell.run2-and-circuit.md`**
   * *Why:* Only pointed to by the unreachable `tools.md`.
7. **`temple/tools/transport-and-doorbell.build-report.md`**
   * *Why:* Linked only from the unreachable `run2-and-circuit.md` and `goal-completion-report.md`.
8. **`temple/tools/transport-and-doorbell.goal-completion-report.md`**
   * *Why:* Historical log; completely unreferenced in any reachable file.

#### **Unreachable in `registry/`:**
9. **`registry/projects/raw.project.freya.devstudio.md`**
   * *Why:* The index `registry/index.md` points to `./registry/projects/` as a directory but does not hyperlink individual files. No beacons point to this overview card.
10. **`registry/projects/raw.project.piql.dev.md`**
    * *Why:* Unlinked. The beacon `registry/piql.dev.md` (Line 13) carries a **broken pointer** `derived-from: registry/projects/piql.dev.md`, which misses the `raw.project.` prefix.
11. **`registry/projects/reposoma.devenv.md`**
    * *Why:* Overshadowed by the active beacon `registry/reposoma.devenv.md` and left unreferenced.
12. **`registry/projects/subai.project-overview.for-leaders.2026-06-24.md`**
    * *Why:* General overview snapshot; unreferenced.

#### **Unreachable in `raw.guides/`:**
13. **`raw.guides/audit-loop.card.draft.md`**
    * *Why:* Fresh draft by `Oraculum` on 2026-07-03; not yet integrated or linked.
14. **`raw.guides/geminicli@com/subagents.md`**
    * *Why:* Isolated and unreferenced.
15. **`raw.guides/project-base-pattern/flag-pulse-projectyaml.matrix.md`**
    * *Why:* Informal operator cheat-sheet; unreferenced.
16. **`raw.guides/research.web/research-pattern.draft.md`**
    * *Why:* Linked only from a generated research output in `raw.research/outputs/` (which lies outside the reachable tree).
17. **`raw.guides/intake/piql.dev.intake.md`**
    * *Why:* Only referenced by the unreachable `piql.dev.PROJECT.yaml.draft.md`.
18. **`raw.guides/intake/piql.dev.PROJECT.yaml.draft.md`**
    * *Why:* Stale draft; unreferenced.
19. **`raw.guides/intake/subai.devenv.intake.md`**
    * *Why:* Only referenced by an out-of-scope research report (`raw.research/harness/reports/RR-01...`).
20. **`raw.guides/piql/phase08-gates-BC-manual.md`**
    * *Why:* This guide is omitted from the publication mapping inside `raw.guides/guide-publishing.md` (Lines 41–44), making its mirrored file unreachable from any guide index.

---

### **(3) Archive & Merge Proposals (Streamlining the Path)**

To shorten the mandatory reading path and enforce the "Tight invariants, loose craft" doctrine, several files and directories should be archived or merged:

1. **Merge `temple/system-map.md` into `temple/roster.md`**
   * *Why:* Both files deal with the same volatile data: active agents, their model configurations, effort levels, and dispatch roles. Maintaining both is a primary source of configuration drift (evidenced by the `@CapCom` and `@Agol` model mismatches). Combining them into `roster.md` keeps the Mermaid diagram and the dispatch tables adjacent, eliminating double-maintenance and shortening the "Door A" reading list by one file.
2. **Merge `temple/file-tree.md` into `temple/doctrine.md` (§1b)**
   * *Why:* `file-tree.md` is simply a static, visual representation of the three-tier sovereignty gradient `[S] / [GC] / [GW]` defined in `doctrine.md` §1b. Moving this tree visualization directly into `doctrine.md` §1b preserves context, keeps theory with layout, and cuts another standalone file out of the critical learning path.
3. **Archive the entire `registry/projects/` directory**
   * *Why:* This directory has been superseded by the active plane-3 project beacons (e.g., `registry/piql.dev.md`, `registry/freya.devstudio.md`). As documented in both `registry/index.md` (Line 33) and `0004-cross-project-registry.md` (Line 60), this directory is slated for retirement once beacons are deposited. Archiving this folder gets rid of 4 stale, unlinked overview snapshots.
4. **Merge `temple/tools/agentctl.spec.md` into `raw.guides/bootstrap-new-project.md`**
   * *Why:* `agentctl` is an unbuilt, seal-gate-blocked tool. Having a standalone spec file adds mandatory reading overhead for a non-existent utility. Its theoretical framework (the contract, the three planes) is already in `doctrine.md` §3b. Placing its concrete schema spec inside the bootstrapping guide consolidates implementation-intent in one actionable location.
5. **Consolidate or Archive the historical logs in `temple/tools/`**
   * *Why:* Files such as `circuit-characterization.2026-06-25.md`, `transport-and-doorbell.build-report.md`, and `transport-and-doorbell.goal-completion-report.md` are one-off logs of specific autonomous trial runs from June 2026. They are unlinked, clog up the tool spec namespace, and should be archived or merged into a single `temple/tools/archive/transport-history.md` historical ledger.
