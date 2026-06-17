---
beacon: <project>
path: <absolute path on disk>
repo: <git remote>
host: <office|home>             # provenance — decision 0003
status: <onboarding | building | cleared | active | …>
contract: <path>/PROJECT.yaml    # the machine surface (if onboarded)
lighthouse: <path to the tracked "Read first" file>
sibling-of: [ <project>, … ]
shares: [ <shared-anchor>, … ]   # named shared topics: spectral · bus/_mail · X→Z · …
deposited-by: <architect / atlas>
updated: <YYYY-MM-DD>
---

# <project> — beacon

<one-line purpose>

## Read first (the anchors — POINTERS, never copies)
- contract     → <path>/PROJECT.yaml
- architecture → <path>
- decisions    → <path>   (flag / decisions / blueprint §)
- conventions  → <path>   (CLAUDE.md / AGENTS.md)
- lighthouse   → <path>   (the tracked "Read first" file)

## Shared anchors (for siblings — fast jump to the shared artifact)
- <topic> → <path in THIS project>   (sibling: <project> at <path>)
