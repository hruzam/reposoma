# Research Brief — R1 · the research center

`voice: R1 · for the CLIs that ran the sovereignty loop · method: you know the pattern`
`date: 2026-06-17 · phase: fresh blind design loop · DO NOT carry prior conclusions in`

You ran the prior sovereignty loop — you know the pattern: blind source-discovery → triangulate → ground → challenge → lock. Run this one the same way, but **from a fresh table**. The earlier study's conclusions are *out of scope on purpose*; design as if you had never read them. Independence from the prior result is the point.

---

## The question (design this)

For a single developer operating several AI-coding CLIs across several personal projects: design, from systems / UNIX first principles, how they should **own and deliver** AI-agent knowledge and configuration. Land somewhere concrete — a substrate, a delivery mechanism, a stance on runtime/live state. Then say where your design **diverges** from the path of least resistance, and why.

## First principles (your starting axioms — not a solution)

1. Data structures over code; **data dominates.** (Torvalds, Pike)
2. **Separate policy from mechanism.** (ESR)
3. **Plain text is the universal interface; text outlives the tools that made it.** (McIlroy, ESR)
4. **A uniform namespace can front heterogeneous backends.** (Plan 9)
5. **Do one thing well; compose through a universal interface.** (pipes)

## Three hypotheses to stress (confirm, break, or transcend each)

- **H1 — substrate.** Durable knowledge lives as plain-text canon in version control; per-tool configuration is disposable, regenerated glue. Is this right? Where does it fail?
- **H2 — the live remainder.** Runtime state (current DB schema, the last error, running logs) is the one thing a static file cannot be. Must it therefore be served over a protocol / RPC? Or can it be expressed *as files* — a synthetic filesystem / namespace the agent reads like any other path — collapsing "static vs live" into one substrate? Argue it either way.
- **H3 — the team.** Is a cooperating group of agents best modeled as a set of named roles, or as a composable pipeline of filters (stdin → stdout, each stage swappable)? What does each framing buy and cost?

## Method (blind — this is load-bearing)

- You are one of several independent voices answering this same question blind. Do **not** guess, match, or anticipate what the others say. Independence is the signal.
- There is no pre-baked right answer. Convergence between voices marks high confidence; divergence marks the real decisions. Do not hedge toward a safe middle.
- Ground where you can (cite source + date + confidence); reason from the principles where you can't.
- Deliver: your design stated concretely · your verdict on H1 / H2 / H3 · the section below.

## Open heresy (bring your own — we are genuinely curious)

What does this framing hold fixed that you would question? Name a substrate, a topology, a delivery model, or a first principle that none of the above reaches for — something surprising and defensible. We want the creative divergence, not the agreement. **Tell us what we are not seeing.**
