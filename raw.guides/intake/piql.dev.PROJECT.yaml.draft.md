# piql.dev — PROJECT.yaml DRAFT (for the operator's gavel)

`tier: raw.guides/intake · Phase-4 deliverable · DRAFT — not yet the live contract`
`authored-by: Houston (temple architect) · from raw.guides/intake/piql.dev.intake.md (filled @Epoch 06-18)`
`schema: PROJECT.yaml v1 (temple/tools/agentctl.spec.md §The contract)`
`date: 2026-06-19 · rule: draft → operator gavels → lands at /home/hruzam/www/piql/piql.dev/PROJECT.yaml`

> No existing PROJECT.yaml to template from (reposoma.devenv's is still PENDING). Authored from
> the v1 schema + the filled intake. Constraints deliberately **excluded** — schema v1 has no
> constraints field; piql's hard constraints live in its `flag.md` + per-vendor trust layer
> (intake §C). Anything not in the contract is **not promised**.

## Proposed contract

```yaml
# PROJECT.yaml v1
name: piql.dev
stack:
  lang: zsh
  framework: none          # file-driven bricks (zsh + curl + jq); Ollama REST API is the inference backend
commands:
  test:   "bus/prefilter/tests/run-tests.zsh && bus/pip/tests/run-tests.zsh"
  run:    "piql \"…\""      # after sourcing piql.env.zsh — see guides/piql.md
  health: "bus/piql-doctor.zsh"   # 9-check bus health
  # lint, build: not defined — file-driven bricks, no build/lint step. Omitted, not faked.
docs:
  architecture: flag.md            # hardware/security/phase decisions; no standalone ARCHITECTURE.md
  decisions:    flag.md            # tracked locks
  conventions:  guides/piql.md     # operator guide — entry point to guides/
agents: [ architect, researcher, implementer, gate-specialist, surface ]
mcp_profile: none                  # O1 deferred — live-slice unsized; piql's runtime truth IS files
guidelines_channel: stable
```

## Authoring notes + the open gavels

**`agents:` — how I derived it** (intake §B "I grant none you don't earn"):
- `architect` · `researcher` · `implementer` — **firm** (houston / epoch / trajectory; intake §B evidence).
- `gate-specialist` — the **deep-core specialist** for the privacy gate. Earned: fail-closed
  discipline is non-negotiable (intake §B). Capability name, not "privacy-gate" (stack-ish).
- `surface` — the **human-facing seat** (`piql` + `piql-doctor`; the operator guides). Earned (intake §B).

**⚖ Open for your gavel:**
1. **`challenger` — omitted, by recommendation.** piql has no standing challenger; the intake
   flagged the question: *does the temple @Janus pass cover the challenge function for piql's
   ongoing sessions, or does piql earn a standing challenger?* My rec: **temple @Janus covers it**
   — don't add a standing seat until volume earns it (doctrine "smallest team"). Your call.
2. **`orchestrator` — omitted.** piql is human-gated (Gate A/B/C); orchestration = brick pipeline
   + human gate. Not earned (subai precedent + doctrine "defer until volume"). Confirm.
3. **`gate-specialist` + `surface` named now vs deferred.** I included both (earned per intake).
   If you'd rather keep agents[] to the firm three and let the domain seats pull in on load, say so.

**Not in the contract (correct, per intake §C):** the hard constraints — Ollama bind
`127.0.0.1:11434` only, GGUF-only/no-pickle, gate fail-closed, no `0.0.0.0` — live in piql's
`flag.md`, not here.

## After the gavel (mechanical follow-ups)
- Place the gaveled YAML at `/home/hruzam/www/piql/piql.dev/PROJECT.yaml`.
- Beacon rename `registry/piql.md` → `registry/piql.dev.md` + fix the `registry/index.md` row
  (intake §✱ flagged the filename mismatch). Needs a `mv` → small @Delta/@Trajectory micro-task.
- Flip the beacon's `contract:` line from `absent → CLAUDE.md` to point at the new `PROJECT.yaml`.
