# canon/ — common

Repository of principles — the inverse of cards. Cards age quickly (perception layer,
refreshed by the researcher). Canon entries age slowly or never, and are refined upon
violation, not on a schedule.

This is the **common** canon — project-neutral invariants. A project's own `canon/` may
extend it with bonded expressions, but must not contradict a promoted common entry.

**Lineage:** commonized from `freya.devstudio/canon/` (2026-06-17), itself adapted from
`ovum/reposoma.dev/canon/`. The bonded freya copy stays where it is; this is the invariant
substrate beneath it.

## Maturity gate

Entries are promoted on NEED (a concrete event forces promotion) and refined upon VIOLATION
(a counter-event forces refinement). Do not promote because an entry is well argued —
promote only when a real event requires it.

## Status values

- `seed` — captured, not yet tested; may be removed
- `trial(n/3)` — actively validated; n of 3 validation events recorded
- `proposed` — enough validation has passed; awaiting a concrete promotion trigger
- `promoted` — promoted by a real need-event; part of the working canon

## Card vs. canon

| | Card | Canon |
|---|---|---|
| Freshness law | Ages quickly; refresh on schedule | Ages slowly/never; refine upon violation |
| Promotion trigger | Re-verify command | Need-event / violation-event |
| Deletion trigger | half_life exceeded | Missing `expresses_as` (no operational expression) |

An entry without `expresses_as` is bloat and must be removed.

## Entries

- `canon.reposoma-is-substrate` — reposoma is a temporary raw RAG substrate, distilled into the app's invariant
- `canon.cost-gradient` — route work by model cost
- `canon.one-direction` — forge → product, never the reverse; human holds the commit gate
- `canon.pulse-heartbeat` — one now-file all agents read first
- `canon.sovereignty-as-design-force` — portable Markdown owned by the project; vendor configs are adapters
- `canon.language-split` — English for everything persisted
- `canon.reflection-channels` — the two feedback channels (therapy, crossfeed) and their governors
- `canon.mail-protocol` — file-native bus: per-author pulse logs + `_mail` inbox/archive/toAll; single-writer-per-file *(promoted 2026-06-19)*
- `canon.context-economy` — conserve the gate-shape, not the quantity; saddle-entry + demand-spend + scoped delegation + ask-first *(promoted 2026-06-19)*
