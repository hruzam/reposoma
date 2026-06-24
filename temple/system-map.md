# Agentive System — the bigger picture (v2, cleaned)

_Drawn from `doctrine.md` (archetypes) + `roster.md` (live cast). Orange = deltas not yet in canon. v2 fixes: added `@Atlas → @Zenith` reader; kept `@Trajectory` self-clone and `@Houston → @Delta` (trivial reads) as doctrine-true; removed the "swarm" scope-leak, keeping `@Agol → @Houston` as a report-up._

```mermaid
flowchart TD
    classDef deferred fill:#f4f4f4,stroke:#999,stroke-dasharray:4 3,color:#666
    classDef future fill:#fff3e0,stroke:#e8842a,stroke-width:2px,color:#7a4410
    classDef gate fill:#e8f0fe,stroke:#3b6fb5,stroke-width:2px,color:#1a3a5c
    classDef canon fill:#eef7ee,stroke:#4a8a4a,color:#244824
    classDef live fill:#fdeef0,stroke:#c0506a,color:#6a2434

    subgraph HUMAN[" human-in-the-loop "]
        MK["majkee — chaos monkey<br/>IS the orchestrator until volume"]
        CAP["@CapCom · Sonnet<br/>human gate · reads houston.goal"]
        MK --> CAP
    end

    subgraph TEAM[" cooperating group · ARCHETYPE // cast · tier "]
        HOU["ARCHITECT // @Houston · Opus<br/>owns plan · dispatches<br/>never runs shell or code"]
        JAN["CHALLENGER // @Janus · Opus<br/>one verdict · one risk · read-only"]
        AGOL["ADVISOR // @Agol · Opus<br/>cross-phase synthesis · no verdict"]
        COL["MATH ADVISOR // @Color · Opus<br/>vector/tensor · formal language<br/>proofs · bounds · read-only"]
        EPO["RESEARCHER // @Epoch · Sonnet<br/>live fetch · dated · cited"]
        TRA["SENIOR IMPL // @Trajectory · Sonnet<br/>writes code · runs shell<br/>self-clones for hard tasks"]
        DEL["EXECUTOR // @Delta · Haiku<br/>surgical · zero judgment"]
        ATL["CREATOR // @Atlas · Sonnet<br/>builds native primitives"]
        ZEN["READER // @Zenith · Haiku<br/>targeted heavy-doc reader"]
        HYP["OVERSIGHT // @Hypatia · Opus<br/>cross-project · ranked verdict"]
        REC["@Recorder · Haiku<br/>session memory"]
        VARA["ORCHESTRATOR // @Vara<br/>DEFERRED until volume"]
    end

    CAP -.authorizes.-> HOU
    HOU --> JAN
    HOU --> AGOL
    HOU --> COL
    COL -.proof / bound report-up.-> HOU
    HOU --> EPO
    HOU --> TRA
    HOU --> ATL
    HOU --> REC
    HOU -->|trivial reads| DEL
    TRA --> DEL
    TRA -.self-clone.-> TRA
    ATL --> ZEN
    AGOL -.synthesis report-up.-> HOU
    HYP -.spans projects.-> HOU

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

    class VARA deferred
    class AG,A3 future
    class GATE gate
    class PLAN,FLAG,PULSE,DEC canon
    class LIVE live
```

## What changed from v1

- **`@Atlas → @Zenith`** added — the creator's Haiku reader was in the roster and missing from the map. My omission, fixed.
- **`@Trajectory` self-clone** kept — the senior forks for parallel perspective on a hard task. Not an artifact; a real pattern.
- **`@Houston → @Delta` (trivial reads)** kept — dispatching the cheap reader is flat dispatch, not "holding the wrench." The wrench is shell/app-code, not delegation.
- **"swarm" removed** — that word reached into the parked composition study; the seed says do not merge. `@Agol → @Houston` stays as a synthesis report-up (the advisor returns findings; the architect persists them).
- **`@Color` seated** — math/formal-language co-brain advisor for the Houston family; read-only like @Agol/@Janus, delegates live SOTA to @Epoch. `@Houston → @Color` dispatch, `@Color → @Houston` proof/bound report-up. Gaveled 2026-06-24.
