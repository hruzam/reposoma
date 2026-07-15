---
beacon: freya.devstudio
path: /home/hruzam/www/imago_cz/freya.devstudio
repo: git@github.com:hruzam/freya.devstudio.git
host: office        # inferred — same host as all siblings; decision 0003
status: active
contract: PROJECT.yaml
lighthouse: CLAUDE.md
sibling-of: [piql.dev, applications-in-common]
shares: [bus/_mail, devstudio-pattern, ui-bricks]
deposited-by: atlas
updated: 2026-07-14
---

# freya.devstudio — beacon

Orchestration studio for freya (imago.cz Laravel ecommerce). Houses the agent team,
research phases, and session memory. Does not write application code — that is freya's own repo.

## Read first (the anchors — POINTERS, never copies)
- contract     → PROJECT.yaml
- architecture → CLAUDE.md + flag.md  (no ARCHITECTURE.md yet; B-T12 open)
- decisions    → flag.md  (locked decisions + burned ships)
- conventions  → CLAUDE.md · canon/
- lighthouse   → CLAUDE.md  (always-tracked entry-point; pulse.md travels via git but on a reversible exception — see flag.md)

## Shared anchors (for siblings — fast jump to the shared artifact)
- bus/_mail         → session/_mail/  (sibling: piql.dev at session/bus/)
- devstudio-pattern → session/plan/session.plan.md  (lineage: piql.dev temple pattern)
- ui-bricks         → sibling `registry/applications-in-common.md` → `bricks/README.md`
  (UI element patterns proven in the playground, provenance-headed — adoption
  candidates for freya; freya's element questions can seed playground hypotheses)
