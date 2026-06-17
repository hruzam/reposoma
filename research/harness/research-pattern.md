# Research Pattern — Blind Fan-Out Deep Study
`derived-from: the agentic-sovereignty study (2026-06-16) · purpose: a reusable, hypothesis-swappable research harness · tier: research/harness`
`doctrine: blind-before-grounded · gate-the-big · challenge-before-lock · cost-gradient · persist-durably · honesty-over-show (the temple)`

## The one idea
Separate the **fixed method** (how you run a study) from the **swappable parameters** (the hypothesis and its concrete lenses). To replay a study on a *different* hypothesis: keep the method, refill the parameters. The weight of this pattern is the **resource scaffold — the lens taxonomy** — because that is what makes a study *triangulated* instead of an echo chamber, and it ports verbatim across hypotheses.

---

## A. Method (FIXED) — six phases

| # | Phase | What happens | Doctrine rule |
|---|-------|--------------|---------------|
| 1 | **Frame & scope** | State the hypothesis as a question; name the competing **options** (A/B/C…); set **scope/audience**; list **cross-cuts**; pre-declare that the options are *given, not exhaustive*. | — |
| 2 | **Source discovery** (first loop) | One **blind** agent per **lens** maps *trusted sources* — who/what, why-durable, must-read — and explicitly does **NOT answer** the question. Plus a pattern-scout lens. | blind-before-grounded |
| 3 | **Scope gate** | Human blesses scope: resolve split-offs, add a counterweight lens if the map is one-sided, set the deliverable target. | gate-the-big |
| 4 | **Deep dive** (grounded) | One agent per **option** + one per **cross-cut** + the **pattern-scout**, each *grounded in the mapped sources*, returns structured findings (claims+evidence+citations+confidence+bearing+emergentPatterns). | verify-before-build |
| 5 | **Adversarial verify** | One **default-skeptical** refuter per **load-bearing claim**; verdict = holds / holds-with-caveats / refuted + the precise *survives-as*. | challenge-before-lock |
| 6 | **Synthesize** | One **top-model** agent writes the report: even-handed map first, then a clearly **[LEAN]**-flagged recommendation + steelmanned dissent. | honesty-over-show |

Persist every phase to disk as you go (phase 2 → source-map file; phase 6 → report file). Files are the continuity.

---

## B. The resource scaffold (THE WEIGHT) — lens taxonomy

A study fans out across **5–8 lenses**. The lens *types* are fixed; you instantiate each with a concrete `topic` + `seedSources` for your hypothesis. **Always include:** `domain-primary`, ≥1 `first-principles`, ≥1 `exemplar`, `strategy-economics`, ≥1 `counterweight`, `pattern-scout`. `adjacent-discipline` is optional.

| Lens type | Purpose | What it sources | Instantiate ×N |
|-----------|---------|-----------------|----------------|
| **domain-primary** | Ground truth of the field itself | Practitioners + canonical primary docs/specs | 1 |
| **first-principles** | The durable tradition the hypothesis rests on | Foundational texts/voices that outlive products | 1–3 |
| **exemplar** | Dissect a best-in-class real implementation | One concrete "done well" case study | 1 |
| **strategy-economics** | Follow the money / incentives | Lock-in, standards, market/strategy canon | 1 |
| **adjacent-discipline** | Borrow a neighbor's habits | A nearby field whose methods illuminate | 0–1 |
| **counterweight** | **Disagree with the emerging consensus** | Risk, governance, the cost nobody's pricing | ≥1 |
| **pattern-scout** | Find options beyond the given set (the 4th/5th) | The wild — adopted + emerging + speculative | 1 |

**The one rule that makes it trustworthy:** the **counterweight lens must dissent.** In the worked example, governance was the *only* lens that complicated the winning option — and that dissent is exactly what kept the verdict honest. If every lens agrees, you mapped an echo chamber; add a sharper counterweight.

**Selection criteria for sources (every lens):** durability over virality; primary specs/canonical texts over hot takes; date anything version-sensitive; rank quality over quantity (5–10 sources). Output per lens = ranked source map (schema D1) + a 2–3 line note on *which option this lens favors* and *its own blind spot*.

---

## C. Swappable parameters (per hypothesis)

```
hypothesis   : the question / claim under study (one sentence)
scope        : the audience & their constraints (who the answer is for)
options      : [ the competing approaches under test, e.g. A / B / C ]
lenses       : [ { type: <lens-type>, topic: "...", seedSources: [url|name, ...] } ]   # 5–8
crossCuts    : [ themes that cut across ALL options, e.g. cost · lock-in · risk · ops ]
claims       : [ load-bearing claims to refute — each option's strongest + the 1–2 the whole recommendation rests on ]
target       : map | decision | design   (or a~b blend, with the lean flagged)
```

Reusable **cross-cut types:** `economics/cost`, `portability/lock-in`, `risk/governance`, `operations/maintenance`, + one domain-specific slot.

---

## D. Schemas (FIXED)

**D1 — source-map entry** (phase 2): `{ name, what, whyDurable, url, mustRead[1-2], status? }` + per-lens closing note `{ favorsOption, blindSpot }`.

**D2 — dive** (phase 4): `{ topic, summary, keyFindings:[{claim, evidence, citations[], confidence(high|med|low), bearing}], strongestClaim, biggestLimitation, openQuestions[], emergentPatterns?:[{name, description, distinctFrom, citations[], status(real-and-adopted|emerging|speculative)}] }`

**D3 — verdict** (phase 5): `{ claim, verdict(holds|holds-with-caveats|refuted), confidence, reasoning, counterEvidence:[{point, citation}], survivesAs }`

---

## E. Report template (FIXED) — eight sections

1. Executive answer (the **[LEAN]**, with confidence)
2. The given options, fully mapped (even-handed: what each delivers / costs / when it wins)
3. **Beyond the options — emergent patterns (FLAGGED)** (aggregate every `emergentPattern`; rate each for promotion)
4. The cross-cuts (one per theme; name the breakpoints/numbers)
5. Adversarial findings (what held / caveated / refuted; refutations not buried)
6. Recommendation (flagged lean + confidence + **steelmanned dissent**)
7. Design sketch (concrete, buildable)
8. What would change the answer (the 2–3 facts whose change flips it)

---

## F. Cost gradient & fan-out size

- **Hands** (discovery, deep dive, verify) → **mid tier (Sonnet)**: grounded web research + refutation is its wheelhouse.
- **Synthesis keystone** → **top tier (Opus)**: the one place weighing all inputs + planting a lean pays for the top model.
- Typical fan-out: ~6–8 discovery + ~8 dive + ~5 verify + 1 synth ≈ 14 agents/study.

---

## G. How to instantiate (replay on a new hypothesis)

1. Fill **C** (hypothesis, scope, options, cross-cuts).
2. Instantiate **B** — pick 5–8 lenses by *type*, give each a `topic` + `seedSources`. Force at least one dissenting `counterweight`.
3. Run **phase 2** (blind source discovery) → save `…/<study>.source-map.<date>.md`. **Gate.**
4. Derive **claims** from the source map (each option's strongest + the load-bearing cross-cut claims).
5. Run **phases 4–6** (dive → verify → synth) → save `…/<study>.report.<date>.md`.

The pattern is in `research-pattern.json` (whole-object) and `research-pattern.jsonl` (one record per line). Swap parameters; the method, lens-types, schemas, and report template stay.

---

## H. Worked example (the proof)
**agentic-sovereignty (2026-06-16)** — hypothesis: how a solo operator should own/deliver AI-agent knowledge across brands (options A=sovereign-markdown / B=native-primitives / C=MCP-served).
- Lenses (7): `research/agentic-sovereignty.source-map.2026-06-16.md`
- Report (8 sections): `research/agentic-sovereignty.report.2026-06-16.md`
- The counterweight (governance) dissented → verdict held *with caveats*, C *refuted* as general substrate. That's the pattern working.

## I. Reading economically (the .jsonl)
`research-pattern.jsonl` = one self-contained JSON record per line, each tagged `kind` + `id`. Read only what you need:
- `grep '"kind":"lens-type"'` → just the resource scaffold
- `grep '"kind":"phase"'` → just the method
- `grep '"kind":"schema"'` / `'"synthesis-section"'` / `'"parameter"'` → those slices
`research-pattern.json` is the same content as one object for whole-file ingestion; the `.md` is the human playbook.
