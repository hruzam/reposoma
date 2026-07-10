# substrate.larva.context-tags

`source: larva.dev/.shared/registries/context-tags.registry.json · excavated: 2026-07-10`
`(pre-burial salvage) · verdict at dig: HOLD under observation`
`· dig record: pulse.atlas.md [2026-07-10]`
`trigger: a temple surface develops the need for turn-level intent/risk annotation (no`
`consumer exists today — @Recorder's markers ?Q/!D/?P/~N/?G/*F cover session-memory`
`filing; this vocabulary covers a different layer: live-turn routing) · destination:`
`unknown — possibly a canon-style note, possibly nothing`

## Atlas commentary

A 15-tag vocabulary for annotating *turns* (not memory items). Most of it is dead
project-deixis, but four pairs are conceptually sharp:

1. **HERE / THERE** — scope deixis: "this statement is about the current project / about
   the sibling project." The temple's reiterate-fresh discipline (never carry one
   project's memory into another) is the strong form; HERE/THERE is the lightweight
   inline form for when one message must legitimately straddle two scopes. This is the
   tag pair most likely to earn temple life someday — cross-project sessions are where
   context bleeding actually happens.
2. **PLAN / DO** — "planning only, no execution" vs "execution approved." The temple
   enforces this at the seat level (Houston plans, never executes); larva marked it at
   the utterance level. If a mixed-authority surface ever appears, this is the marker.
3. **RISK / SUDO** — announce-before-acting flags for dangerous operations. The temple
   handles this via permission gates in the harness; the *announce* discipline (say RISK
   before doing, not after) is the salvageable habit.
4. **MEM** — "memory blur / refresh": an honest self-flag that the agent suspects its own
   context is degraded. No temple equivalent exists. Cheap and potentially valuable —
   an agent that can say "MEM: I may be carrying stale state" invites verification
   instead of confident drift.

Dead: SIM (compass.simulator — larva runtime), SYNC (freya/larva parity — that pairing is
gone), DEV/PROD (covered by project contracts), ARCH/ORCH/HND/LOG (covered by seats,
run-shapes, mail protocol, pulse discipline).

## The object (verbatim)

```json
{
  "scope": "larva_dev",
  "version": "0.1",
  "tags": [
    { "tag": "HERE", "meaning": "larva_dev/dev (current scope)" },
    { "tag": "THERE", "meaning": "freya/dev (other scope)" },
    { "tag": "ARCH", "meaning": "architecture framing" },
    { "tag": "ORCH", "meaning": "orchestration run" },
    { "tag": "SIM", "meaning": "compass.simulator feedback loop" },
    { "tag": "PLAN", "meaning": "planning only, no execution" },
    { "tag": "DO", "meaning": "execution approved" },
    { "tag": "RISK", "meaning": "high-risk operation, announce" },
    { "tag": "SUDO", "meaning": "sudo involved" },
    { "tag": "HND", "meaning": "handoff required" },
    { "tag": "MEM", "meaning": "memory blur / refresh" },
    { "tag": "LOG", "meaning": "journal update needed" },
    { "tag": "SYNC", "meaning": "sync freya/larva parity note" },
    { "tag": "DEV", "meaning": "development-of-development" },
    { "tag": "PROD", "meaning": "product-level code" }
  ]
}
```
