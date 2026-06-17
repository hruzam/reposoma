# Agentive System — the bigger picture

_Drawn from `the-team_doctrine-v2.md` (archetypes) + `team-roster.md` (live cast), as the future build. Orange = the deltas we derived this session, not yet in canon._

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
        AGOL["ADVISOR // @Agol · Fable<br/>cross-phase synthesis · no verdict"]
        EPO["RESEARCHER // @Epoch · Sonnet<br/>live fetch · dated · cited"]
        TRA["SENIOR IMPL // @Trajectory · Sonnet<br/>writes code · runs shell"]
        DEL["EXECUTOR // @Delta · Haiku<br/>surgical · zero judgment"]
        ATL["CREATOR // @Atlas · Sonnet<br/>builds native primitives"]
        HYP["OVERSIGHT // @Hypatia · Opus<br/>cross-project · ranked verdict"]
        REC["@Recorder · Haiku<br/>session memory"]
        VARA["ORCHESTRATOR // @Vara<br/>DEFERRED until volume"]
    end

    CAP -.authorizes.-> HOU
    HOU --> JAN
    HOU --> AGOL
    HOU --> EPO
    HOU --> TRA
    HOU --> ATL
    HOU --> REC
    TRA --> DEL
    HYP -.spans projects.-> HOU

    subgraph CANON[" sovereign canon · durable files in git "]
        PLAN["plan.md · what we are doing"]
        FLAG["flag.md · locked invariants"]
        PULSE["pulse.md · volatile state"]
        DEC["docs/decisions/ · ADR<br/>superseded, never edited"]
    end

    GATE{{"agentctl materialize<br/>ONE source to N surfaces<br/>lockfile · verify on drift"}}

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

    LIVE["local MCP · the live slice ONLY<br/>query_schema · last_error · tail_logs<br/>deferred loading"]

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

## How to read it

- **Top band — the human gate.** majkee is the orchestrator until volume forces @Vara into existence (deferred, dashed).
- **Middle band — the team.** Each seat is `ARCHETYPE // live-cast · tier`. The doctrine owns the left of the `//`; the roster owns the right. Solid arrows = dispatch; dotted = authorize / span. The architect never holds the wrench.
- **Lower bands — the one-direction flow (force 4).** Authoring → **canon** (plan/flag/pulse/decisions) → **the gate** (`agentctl`) → **surfaces** (weather, gitignored) → **runtimes + commands**. Intelligence flows down only.
- **The live slice (pink), off to the side.** Not in the canon flow — the implementer and researcher read it directly for runtime truth. This is the Model-C remainder, still unsized.

## The four future deltas marked here

1. **AGENTS.md graduated** (orange) — moved from vendor-weather to canon-grade; needs the graduation rule added to the file plane.
2. **agentctl gate** — your materializer as the single compile-down, superset of the report's Ruler.
3. **OpenCode hedge** (orange) — runtime fallback against a Gemini-style rug-pull.
4. **Deferred-loading on the live MCP** — the fix for F3 (global servers bloat every session).
