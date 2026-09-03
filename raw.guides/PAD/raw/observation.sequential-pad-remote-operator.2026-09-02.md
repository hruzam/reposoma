---
kind: observation
date: 2026-09-02
session: FC.sync-oraculum.sella-termbrana (head Fable, operator over SSH from the other host)
author: oraculum (proposed as guide text) · relocated here 2026-09-03 by atlas-ui, session roster-reform-01-triad
status: ONE data point — raw substrate, not PAD law. Promote into PAD/GUIDE.md only after a second run reproduces it.
---

# Sequential PAD mode with a remote operator

Observed once. When the operator sits a PAD over SSH from another host:

1. the head verifies host by **mechanism fingerprints**, never by `host:` headers;
2. visual / perf steps are stamped **"SSH-mediated"** in their fences;
3. when a CLI echo path fails, the executor's own render surface + a **photo** is a legitimate
   evidence route — transcribe into the fence, cite the photo path;
4. the head holds an **out-of-band off-switch** (e.g. `zellij --session <s> action pipe …` from a
   separate shell) before any step that can lock the operator out;
5. a GLOSS is offered (PAD GUIDE driver rule) — explanations never enter the PAD.

Why it is here and not in the guide: the runbook token-economy chapter (`raw.guides/runbook/res/
token-economy.md`) took the delegation and spend material from the same proposal; this pattern
has no second session behind it and the PAD guide's law is not amended on one observation.
