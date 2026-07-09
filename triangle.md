---
what: who is available TODAY for blind triangulation, by capability
updated: 2026-07-09
side-orchestrator: majkee          # provides blind legs from standard UIs when CLI legs are down
blind-protocol: nabla-lab flag lock 6   # one researcher sees all forks; legs blind until cross-measure
optimal-scheme:                    # the CURRENT best trio/quad — evidence-based, see notes below
  depth-research: epoch            # brand: anthropic
  heterogeneity-leg: gemini-cli    # brand: google — cross-brand REQUIRED for full blindness
  math-verify: color               # brand: anthropic
  fallback-heterogeneity: majkee-ui-gemini   # side-orchestrator path
seats:
  - seat: epoch
    brand: anthropic
    surface: CLI global
    for: [prior-art, policy-verification, date-calibrated research]
    status: available
    verified: 2026-07-09
  - seat: gemini-cli
    brand: google
    surface: |
      g-vega       (gemini-2.5-pro   · advisor/synthesis · interactive + headless)
      g-orby       (gemini-2.5-flash · researcher        · interactive + headless)
      g-bluebottle (gemini-2.5-flash · synthesizer       · headless REST only — most orchestration-stable)
      g-astro      (gemini-3.5-flash · implementer       · interactive + headless + --patch)
    for: [heterogeneity-leg, second-opinion research, cross-model synthesis]
    orchestration-note: bluebottle REST is the safest path for Anthropic-agent dispatch (no TTY, no hang risk)
    status: available · orchestration-unverified   # hand-runs GREEN ×2 (majkee, Vega + Astrobley); orchestrated dispatch not yet exercised
    verified: 2026-07-09
  - seat: cursor-agent
    brand: cursor
    surface: CLI (`! agent`)
    for: [code-review leg, implementation second-opinion]
    status: expected
    verified:
  - seat: majkee-ui
    brand: any (human-mediated)
    surface: standard web UIs
    for: [blind triangulation when CLI legs down, taste checks]
    status: available-when-present
    verified:
---

# experience notes (append-only, dated — the evidence behind optimal-scheme)

- 2026-07-02 · atlas-research-2 · gemini-cli: Degraded leg — bluebottle persona lock + 503s on
  direct CLI attempts. REST API path (GOOGLE_API_KEY) was the reliable route; CLI fallback noisy.
  Astrobley built and confirmed GREEN 2026-07-03; wiring repair map produced 2026-07-07 (6 breaks).
- 2026-07 · hand-run · g-vega + g-astro: Repair confirmed effective. Two occasions run directly by
  majkee (no Anthropic-agent orchestration), both GREEN. Vega (advisor depth) + Astrobley (patch
  protocol) exercised. CLI surface clean post-repair. Orchestration path (Anthropic agent →
  gemini-cli) not yet exercised — first orchestrated run will upgrade to fully-verified or surface residual issues.
