# Agentive System — the bigger picture (v3)

_Drawn from `doctrine.md` (archetypes) + `roster.md` (live cast). Orange = deltas not yet in canon. v3: @Vara activated (execution coordinator between Houston and implementation layer); @Vector added (mid-tier implementer); @Agol model corrected Fable→Opus. Decision 0006 (2026-06-25). v4: @Flight seated — tactical planner, Houston-family lightweight seat, 2026-06-27. v5: @Hypatia retired → @Oraculum seated — scientist-tier, user-invoked Houston alternative, 2026-07-02. v7: G9 fact-kind taxonomy — node-labels stripped to name only; model/effort defaults consolidated in roster.md; 2026-07-07. v8: @Assay seated — fresh-eyes verifier / test-review gate under Vara; vara.md @Hooke→@Vector drift corrected; decision 0012 (program-pulse); 2026-07-16._

> **Fact-kind taxonomy:** node facts live in `roster.md` (join by file-stem); edges = who-dispatches-whom; an edge may carry an effort/model override annotation which wins over the roster default.

```mermaid
flowchart TD
    classDef deferred fill:#f4f4f4,stroke:#999,stroke-dasharray:4 3,color:#666
    classDef future fill:#fff3e0,stroke:#e8842a,stroke-width:2px,color:#7a4410
    classDef gate fill:#e8f0fe,stroke:#3b6fb5,stroke-width:2px,color:#1a3a5c
    classDef canon fill:#eef7ee,stroke:#4a8a4a,color:#244824
    classDef live fill:#fdeef0,stroke:#c0506a,color:#6a2434

    subgraph HUMAN[" human-in-the-loop "]
        MK["majkee — chaos monkey<br/>IS the orchestrator until volume"]
        CAP["@CapCom<br/>human gate · reads houston.goal"]
        MK --> CAP
    end

    subgraph TEAM[" cooperating group · ARCHETYPE // cast · tier "]
        HOU["ARCHITECT // @Houston<br/>owns plan · dispatches<br/>never runs shell or code"]
        FLI["TACTICAL // @Flight<br/>quick replanning · phase coord<br/>defers strategic gates to Houston"]
        JAN["CHALLENGER // @Janus<br/>one verdict · one risk · read-only"]
        AGOL["ADVISOR // @Agol<br/>cross-phase synthesis · no verdict"]
        COL["MATH ADVISOR // @Color<br/>vector/tensor · formal language<br/>proofs · bounds · read-only"]
        EPO["RESEARCHER // @Epoch<br/>live fetch · dated · cited"]
        VARA["COORDINATOR // @Vara<br/>holds task list · routes execution<br/>verifies gates · reports to Houston"]
        TRA["SENIOR IMPL // @Trajectory<br/>writes code · runs shell<br/>self-clones for hard tasks"]
        VEC["IMPLEMENTER // @Vector<br/>context ceiling above Haiku<br/>no opinions · no subagent spawning"]
        DEL["EXECUTOR // @Delta<br/>surgical · zero judgment"]
        ASS["VERIFIER // @Assay<br/>fresh-eyes test/review gate<br/>reads task+handoff · PASS/FAIL"]
        ATL["CREATOR // @Atlas<br/>builds native primitives"]
        ZEN["READER // @Zenith<br/>targeted heavy-doc reader"]
        ORA["SCIENTIST-TIER // @Oraculum<br/>deep modeling · user-invoked alt to Houston"]
        REC["@Recorder<br/>session memory"]
    end

    CAP -.authorizes.-> HOU
    CAP -.authorizes.-> FLI
    FLI --> VARA
    FLI --> ATL
    FLI --> EPO
    FLI -->|simple| DEL
    HOU --> JAN
    HOU --> AGOL
    HOU --> COL
    COL -.proof / bound report-up.-> HOU
    HOU --> EPO
    HOU --> VARA
    HOU --> ATL
    HOU --> REC
    HOU -->|trivial reads| DEL
    VARA --> TRA
    VARA --> VEC
    VARA --> DEL
    VARA --> ASS
    ASS -.PASS/FAIL report-up.-> VARA
    TRA --> DEL
    TRA -.self-clone.-> TRA
    ATL --> ZEN
    AGOL -.synthesis report-up.-> HOU
    MK -.direct invoke.-> ORA

    subgraph CANON[" sovereign canon · durable files in git "]
        PLAN["plan.md · what we are doing"]
        FLAG["flag.md · locked invariants"]
        PULSE["pulse.md · volatile state"]
        DEC["docs/decisions/ · ADR<br/>superseded, never edited"]
    end

    GATE{{"materializer · the gate<br/>ONE source to N surfaces<br/>lockfile · verify on drift"}}

    subgraph SURF[" consumer surfaces · weather · gitignored "]
        AG["AGENTS.md<br/>graduated to canon-grade"]
        CL["CLAUDE.md → @AGENTS.md"]
        CUR[".cursor/rules"]
        MCPC[".mcp.json"]
    end

    subgraph RUN[" activation + runtimes "]
        A1["agent freya · cd freya (direnv)"]
        A2["claude · agy · cursor · chatgpt · piql"]
        A3["OpenCode · runtime hedge"]
    end

    LIVE["local MCP · the live slice ONLY<br/>query_schema · last_error · tail_logs<br/>deferred loading · sized to workload"]

    HOU ==>|authoring| CANON
    CANON ==> GATE
    GATE ==> SURF
    SURF ==> RUN
    TRA -.reads live state.-> LIVE
    EPO -.post-cutoff docs.-> LIVE

    class AG,A3 future
    class GATE gate
    class PLAN,FLAG,PULSE,DEC canon
    class LIVE live
```

## Dispatch hierarchy

Text companion to the diagram. Read: *who spawns whom, and when*.

```
majkee
  ├─ @Oraculum   ← direct invoke; scientist-tier, deeper than Houston
  └─ @CapCom     ← human gate; reads houston.goal, assesses risk, awaits "ano"
       ├─ @Houston          ← strategic work; architect, owns plan, locks decisions
       │    ├─ (see full Houston subtree below)
       └─ @Flight           ← tactical work; quick replanning, execution coordination
            ├─ @Vara        ← execution coordinator; routes Trajectory/Vector/Delta
            ├─ @AtlasAuto   ← primitive creator; clear spec only
            ├─ @Epoch       ← researcher; date-calibrated fact checks
            └─ @Delta       ← direct dispatch for simple surgical tasks

@Houston          ← after confirmation; architect, owns plan
            ├─ @Janus      ← challenge-before-lock; adversarial; spawned for any big decision
            ├─ @Agol       ← synthesis advisor; spawned when cross-phase reasoning needed
            ├─ @Color      ← math/formal-language co-brain; spawned for proofs/bounds/semantics
            ├─ @Epoch      ← researcher; spawned for live version/stack checks
            ├─ @Atlas      ← primitive creator; spawned to build/repair agents
            ├─ @Recorder   ← memory librarian; spawned to file session state
            └─ @Vara       ← execution coordinator; spawned when a plan enters execution phase
                 ├─ @Trajectory   ← senior impl; spawned for complex/judgment tasks
                 │    └─ @Delta   ← surgical executor; spawned for specific subtasks
                 │         [fallback: if Delta is not strong enough, Trajectory takes over directly]
                 ├─ @Vector       ← mid-tier impl; spawned when context > ~40K or
                 │                   medium-complexity new code, no judgment needed
                 ├─ @Delta        ← direct dispatch for simple surgical tasks
                 └─ @Assay        ← verification gate; released after a coder marks `review`
                                     (0012 L7): reads task + handoff, runs suite, PASS/FAIL
```

**Fallback rules:**
- `Delta not strong enough` → Trajectory picks up the task directly (no re-dispatch through Vara)
- `Context > 100–128K` → escalate to Trajectory from task start; do not wait for Delta to fail
- `Hard task (3+ hop debug, architecture root-cause)` → skip Trajectory, go directly to an Opus seat (Houston / Color / Janus depending on domain)
- `Advisory needed mid-execution` → Vara surfaces to Houston; Houston spawns the relevant advisor

**What Vara does NOT do:** re-plan, run Bash, or override Houston's gate decisions.
**What Trajectory does NOT do:** hold the task list across sessions (that is Vara's responsibility).

**Dispatch discipline — a Write-less seat cannot file its own mail (gaveled 2026-07-03).**
When you dispatch a seat that has **no `Write` tool** (a read-only / query seat — e.g. an MCP query agent, a read-only advisor), **the spawning session owns filing that seat's output.** Filing it is part of definition-of-done, not optional: unfiled read-only-seat output **silently evaporates** when the subagent context closes. This is the read-side mirror of 0010's *"content enters through exactly one door — a writer's own append"*: if the seat cannot write, the spawner must carry the write. *(Origin: @delta-sql's reposoma-schema impulse never reached disk — no Write tool, the filing step dropped; recovered from the session transcript by @Oraculum, 2026-07-03.)*

---

## What changed

**v2 (2026-06-24):**
- **`@Atlas → @Zenith`** added — the creator's Haiku reader was in the roster and missing from the map.
- **`@Trajectory` self-clone** kept — the senior forks for parallel perspective on a hard task.
- **`@Houston → @Delta` (trivial reads)** kept — dispatching the cheap reader is flat dispatch, not "holding the wrench."
- **"swarm" removed** — `@Agol → @Houston` stays as a synthesis report-up only.
- **`@Color` seated** — math/formal-language co-brain; `@Houston → @Color` dispatch, `@Color → @Houston` report-up. Gaveled 2026-06-24.

**v3 (2026-06-25 · decision 0006):**
- **`@Vara` activated** — execution coordinator layer between Houston and implementation. Holds task list, routes Trajectory/Vector/Delta, verifies gates, reports state. Was deferred; now canon.
- **`@Vector` added** — mid-tier implementer (Sonnet, effort:medium). Sits between Delta and Trajectory on the escalation ladder: context ceiling above Haiku or medium-complexity new code, but no judgment or subagent spawning needed.
- **Effort levels added to node labels** — model tier alone is insufficient; effort is an orthogonal quality axis (AMD/Laurenzo finding: effort-misconfig risk > tier-selection risk).
- **`@Agol` corrected Fable → Opus** — Fable 5 pulled within 48h of launch; silent self-degradation confirmed in Anthropic system card.
- **`@Janus` effort:high → effort:xhigh** — must exceed architect's reasoning depth to produce meaningful challenge-before-lock.

**v5 (2026-07-02):**
- **`@Hypatia` retired → `@Oraculum` seated** — reconfigured and renamed. Oraculum: Fable · effort:high, scientist-tier, user-invoked alternative to Houston. Same canon reading list, deeper problem-modeling phase (Phase A/B/C), neural and coding depth close to Color. Not spawned by Houston — user invokes directly. `hypatia-brief` skill retired; `agol-brief` created as its successor for Agol synthesis context handoffs.
- **`@Agol` model note updated** — Fable returned 2026-07-02; stale Opus note cleared from definition.

**v6 (2026-07-03):**
- **Dispatch discipline added — Write-less seats.** The spawning session must file a read-only seat's output as definition-of-done (see the discipline block above). Gaveled 2026-07-03 after @delta-sql's schema impulse evaporated for lack of a Write tool.

**v7 (2026-07-07 · G9 fact-kind taxonomy):**
- **Node-labels stripped** — all `· Model · effort:Level` suffixes removed from mermaid node labels and dispatch hierarchy. Map carries edges (who-dispatches-whom) only.
- **Model/effort defaults live in roster.md** — `roster.md` is the single live home (0006 Amendment A1); join by file-stem. Map-only facts ported to roster before strip: @Agol effort:high · @Color effort:xhigh · @Epoch effort:medium · @Atlas effort:high (dispatch hierarchy); @Janus already correct at xhigh.
- **Taxonomy header added** — one-line callout above the diagram names the three fact homes (roster · edges · ADR 0006-L5) and the join key.

**v8 (2026-07-16 · decision 0012 — program-pulse):**
- **`@Assay` seated** — VERIFIER; fresh-eyes test/review gate. Spawned by Vara (or a coder) after a `review` mark; reads only {task, coder-handoff, changed files}, runs the declared suite via Bash, returns PASS/FAIL. Sonnet by role — the writer's-blindness circuit breaker (0012 L7). Does not fix code; NOK returns to the coder.
- **`@Vector` drift corrected** — `vara.md` routing said `@Hooke` (a ghost); roster + this map say `@Vector`. Converged to `@Vector` (Oliver Heaviside — the engineer who made Maxwell's equations usable). No new seat.
- **Review-companion → @Recorder (proposed, not applied)** — the human re-entry role after a program run converges into @Recorder, extended to read `program.pulse.md`. Awaiting gavel.
