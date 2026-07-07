# temple/evidence/

This directory holds verbatim drained evidence for decision records; each file is pointed to
from an append-only redirect section in `temple/decisions/<NNNN>-*.md`.

Files here are verbatim copies — never edited after placement.

This directory is deliberately OUTSIDE `temple/decisions/` so adr-guard's domain (one directory,
one contract) stays crisp and historical mail paths present inside evidence files do not trip
adr-guard check 2 (evidence-rot cite).
