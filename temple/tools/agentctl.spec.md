# agentctl — the materializer / gate (independent tool spec)

`tier: temple · cross-project canon · the tool the doctrine names but does not specify`
`date: 2026-06-17 · status: spec (tool itself: build when the first real project needs it)`
`supersedes: temple/agent-platform-activation-study.md (2026-06-11) — durable core lifted here`
`governed-by: doctrine §3b (planes/contract) · §7 (trust) · decisions/ L2,L5,L6`

> This is the **independent tool / parallel service** the doctrine references as `bin/agentctl`
> and the file-tree draws as the gate. The doctrine says *why* it exists; this file says *what
> it is*. It is deliberately split out of the doctrine prose: the doctrine is the invariant, the
> tool is weather that ships and versions on its own cadence. Keep it a single script (<300 lines);
> resist frameworkitis.

---

## What it is
One declarative, idempotent command that reads `PROJECT.yaml` + the registry + the meta-repo and
**renders** a repo's per-vendor runtime config from one sovereign source. One code path serves human,
direnv, cron, and CI alike. **Generation over symlinks** — works on any FS/CI, diffs visibly in PRs,
and allows per-project template substitution a symlink cannot.

## The three planes (doctrine §3b — restated for the tool)
- **P1 · agent definitions** — global, parameterized, capability-named, never name a project. (Tier S)
- **P2 · project contract** — `PROJECT.yaml`: the one file an agent may assume exists. (per repo)
- **P3 · binding/activation** — registry + this tool, resolving *which* agents/profile/settings for *this* dir.

## The contract — `PROJECT.yaml v1` (agnostic schema)
```yaml
# PROJECT.yaml v1
name: <project>
stack: { lang: <…>, framework: <…> }       # informational; agents speak in contract terms, not stack terms
commands:                                    # the verbs every agent resolves through the contract
  test:  "<project test cmd>"
  lint:  "<project lint cmd>"
  build: "<project build cmd>"
docs:                                        # entry points, not content
  architecture: docs/ARCHITECTURE.md
  decisions:    docs/decisions/
agents:        [ <capability-name>, … ]      # requested capability SET, names from registry
mcp_profile:   <named tool-set>              # resolved against the profile store
guidelines_channel: stable                   # which meta-repo channel/tag feeds guidelines
```
Rules: agents read `{{commands.*}}` / `{{docs.*}}` instead of guessing or scanning; **anything not in
the contract is not promised**; version the schema (`# PROJECT.yaml v1`) so the platform evolves
without breaking older repos. Capability names, not stack names (`db-inspector`, not `mysql-inspector`).

## Commands
```
agentctl materialize:   renders → .claude/agents/* (from P1 templates, vars {{commands.test}}…)
                                 → .claude/settings.json (enabled servers per mcp_profile · the TRUST layer)
                                 → .mcp.json (the live-slice server only — see untuned string)
                                 → guidelines/* (from guidelines_channel)
                                 → .agent-lock.json (versions + content hashes of all of the above)
agentctl verify:        recompute hashes vs lockfile; exit non-zero on drift → answers F4 (CI + pre-session)
agentctl diff / update: show what a channel bump changes; PR-able (review surface ≈ Dependabot)
```

## Activation entry points (composite — C is the heart)
- **C · materialize (core).** The piece every other entry calls. Everything above is C.
- **A · explicit activator + registry.** A global shell fn `agent <name>` (or `agent .` autodetect):
  resolve record → export profile → `agentctl materialize` → launch. Explicit, auditable, covers cron
  (`agent <name> -p "…"`).
- **B · auto-activate on `cd` (direnv/mise).** A 2-line `.envrc` calling the *same* agentctl; `direnv allow`
  gates trust. Defer until ≥2 active projects. A and B are two thin doors into C — never a second code path.
- **D · supply chain.** Meta-repo tags releases (`agents-vX.Y.Z`); projects pin a channel; upgrades arrive
  as `agentctl update` PRs. This is how F1 is solved *properly* (upgrades explicit, reviewable, rollbackable).
- **E · MCP gateway/broker — DEFERRED.** A gateway fronting all servers to isolate the tool surface per
  agent. `--strict-mcp-config` per-profile already captures ~90%. Revisit only when agent-scoped MCP
  isolation lands upstream **or** project count > ~5.

## Writing P1 agents to stay project-agnostic
- Speak only in contract terms (`{{commands.test}}`, never the literal command).
- Each agent declares **REQUIRES** (contract keys + tools) in frontmatter; `agentctl` warns when a
  project's contract cannot satisfy them.
- **Overlays over forks:** a project may append `agents/<name>.overlay.md`; agentctl concatenates. Overlays
  compose one-directionally; forks rot in parallel.
- Tools: least privilege (`mcp__server__tool` granularity) for reliability; context economy is the
  profile's job, not the binding's.

## The four failure modes it designs against (doctrine §3b)
F1 logic copy-pasted per project → drift, no upgrades · F2 project knowledge baked into agents → break on
the next project · F3 MCP/tool config accumulating globally → every session bloats · F4 silent divergence
between what the registry says and what a repo runs.

## Governance (doctrine §7 · decisions L3/L5)
The trust layer (`deny`-first + a `PreToolUse` backstop) is **materialized per vendor**, kept in git
(Tier G-committed) for provenance, and never assumed portable. **Trust is a materialize target, not canon.**
Two supply chains never own one file (decisions L6): framework primitives flow via the framework's own
installer; sovereign primitives flow via agentctl — and `agentctl verify` guards the seam in CI.

## Acceptance criteria
New project onboarded in <30 min (write `PROJECT.yaml` + a registry record, nothing else) · an agent
upgrade = one PR per project · zero hand-edited files under any consumer surface · CI fails on drift.

## The one untuned string (conditional — do not lock)
The **live-slice** wiring (`.mcp.json`: schema / last-error / logs) — synthetic-FS vs RPC, and its sizing
— is the deferred experiment (doctrine §3.5 · decisions O1). Keep `.mcp.json` a placeholder here; settle it
with a measured one-evening test (detection/cost), not more design.
