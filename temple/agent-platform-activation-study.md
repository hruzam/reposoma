# Study: Project-Agnostic Agent Platform with Per-Project Activation
### "Agents as an environment" — registry, contract, activator
For: general agents architect (companion to the Laravel-side studies already delivered)
Date: 2026-06-11 · Status: proposal with options

---

## 1. Problem statement

We want agent builds (definitions, skills, MCP wiring, evaluation harnesses)
that are NOT bonded to a specific project, yet respect each project's needs.
The proven legacy pattern: a global per-project zsh entry command that, on
invocation, activated the appropriate system settings for CLI agents from a
central registry/storage. It worked; this study generalizes it for the
Claude Code / Cursor / multi-CLI era.

The failure modes we design against:
- F1: agent logic copy-pasted per project → drift, no upgrades
- F2: project knowledge baked into agents → agents break on the next project
- F3: MCP/tool config accumulating globally → context bloat (known: globally
  configured MCP servers load into every session; no native hard isolation)
- F4: silent divergence between what the registry says and what a repo runs

## 2. Core principle: three planes, three owners

```
PLANE 1  AGENT DEFINITIONS   project-agnostic, capability-oriented,
         (global layer)      PARAMETERIZED — never name a project
PLANE 2  PROJECT CONTRACT    what a project exposes to any agent:
         (per repo)          stack, commands, docs, conventions, profiles
PLANE 3  BINDING/ACTIVATION  registry + activator resolving WHICH agents,
         (the zsh layer)     WHICH MCP profile, WHICH settings, for THIS dir
```

Owners: Plane 1 = agents architect (you/Majkee's meta-repo). Plane 2 = each
project's dev architect (Laravel architect for Freya). Plane 3 = shared
infra, versioned in the meta-repo, changed by ADR.

The contract is the load-bearing idea: an agent never "knows Freya" — it
knows "read `PROJECT.yaml`, then the docs it points to." Same agent binary
runs on a Laravel monolith today and a Python ETL repo next year.

## 3. The Project Contract (PROJECT.yaml) — minimal spec

Lives in each repo root; the only file agents may assume exists.

```yaml
# PROJECT.yaml v1
name: freya
stack: { lang: php-8.3, framework: laravel-11, admin: filament-4 }
commands:                    # the verbs every agent needs, project-resolved
  test: "php artisan test --parallel"
  lint: "vendor/bin/pint --test"
  arch-check: "vendor/bin/deptrac analyse"
  build: "npm run build"
docs:                        # entry points, not content
  architecture: docs/ARCHITECTURE.md
  decisions: docs/adr/
  scopes: .claude/skills/scope-manifests/_index.md
agents:                      # requested capability SET (names from registry)
  - boundary-reviewer
  - simplifier
  - db-inspector
mcp_profile: laravel         # name resolved against profile store
guidelines_channel: stable   # which meta-repo branch/tag feeds .ai/guidelines
```

Rules: agents read `commands.*` instead of guessing (`npm test`? `composer
test`?); agents read `docs.*` pointers instead of scanning; anything not in
the contract is not promised. Version the schema (`# PROJECT.yaml v1`) so
the platform can evolve without breaking older repos.

## 4. Approaches (options menu)

### A. Explicit shell activator + registry  — the legacy pattern, modernized
One global zsh function; registry = directory of per-project records in the
meta-repo (`registry/<name>.yaml` ≈ PROJECT.yaml mirror + machine-local bits).

```zsh
agent() {            # usage: agent freya   |   agent .   (autodetect)
  local rec=$(registry-resolve "$1")             # find record
  export CLAUDE_MCP_PROFILE=$(yq .mcp_profile $rec)
  agentctl materialize "$rec" "$(yq .path $rec)"  # see option C
  cd "$(yq .path $rec)" && claudep $CLAUDE_MCP_PROFILE
}
```

+ Explicit, auditable, zero magic; identical UX to the proven legacy system.
− Manual step; humans forget; doesn't help headless/CI invocations directly
  (though `agent freya -p "..."` covers cron).

### B. Auto-activation on cd — direnv (or mise) as the trigger
`.envrc` per repo: `export CLAUDE_PROFILE=laravel; agentctl materialize --quiet`.
direnv runs it on entering the directory; `direnv allow` gates trust.

+ Closest to "it just works"; per-directory env is direnv's exact job;
  composes with A (A = remote/by-name, B = local/by-cd).
− Hidden side effects on cd (team must know); direnv becomes a dependency;
  keep `.envrc` to 2 lines that call the same agentctl as A (one code path).

### C. Materializer/compiler — "agentctl" (recommended core)
The piece both A and B call. Declarative, idempotent: reads PROJECT.yaml +
registry + meta-repo, then RENDERS the repo's runtime config:

```
agentctl materialize:
  .claude/agents/*        ← copy/render requested agents from plane 1
                            (template vars: {{commands.test}}, {{docs.scopes}})
  .claude/settings.json   ← enabledMcpjsonServers per mcp_profile
  .mcp.json               ← from profile store (or leave to Boost where present)
  .ai/guidelines/*        ← from guidelines_channel (then boost:install hook)
  .agent-lock.json        ← versions + content hashes of everything materialized
agentctl verify:          # CI + pre-session: recompute hashes vs lockfile
  exit non-zero on drift  → answers failure mode F4
agentctl diff/update:     # show what a channel bump would change; PR-able
```

+ Single code path for human, direnv, cron, CI; lockfile gives reproducibility
  and drift detection; templates solve "agnostic agent, project values."
+ Generation > symlinks: works on any FS/CI, diffs visibly in PRs, allows
  per-project template substitution (symlinks can't parameterize).
− You own a small tool (keep it a single bash/PHP/python script, <300 lines;
  resist frameworkitis).

### D. Distribution as versioned packages — registry channels
Treat plane-1 agents/skills like dependencies: meta-repo tags releases
(`agents-v1.4.0`); projects pin (`guidelines_channel: stable` → latest tag,
or exact pin for risk-averse repos). Updates arrive as `agentctl update` PRs
— review surface identical to Dependabot. Format-align skills with the
skills.sh layout so Cursor teammates consume the same artifacts.

+ Upgrades become explicit, reviewable, rollbackable (F1 solved properly).
− Requires release discipline in the meta-repo (cheap: tag + changelog).

### E. MCP gateway/broker — future option, not now
A single gateway MCP that fronts all servers and filters the visible tool
set per agent/profile. Solves the "global servers always load" isolation gap
at the protocol level (community gateways exist; agent identity is not
natively passed to MCP servers, so gateways use config/heuristics).
+ True tool-surface isolation; one registration everywhere.
− Extra moving part, immature ecosystem, and the per-profile launcher
  (--strict-mcp-config) already captures ~90% of the benefit. Revisit when
  agent-scoped MCP isolation lands upstream or project count > ~5.

## 5. Recommended composite

C is the heart; A and B are two thin entry points into it; D is C's supply
chain; E is deferred.

```
meta-repo (plane 1 + 3)                 each project (plane 2)
├── agents/ skills/ guidelines/        ├── PROJECT.yaml          (committed)
├── mcp-profiles/{laravel,research,…}  ├── .envrc → agentctl     (committed)
├── registry/{freya,…}.yaml            ├── .agent-lock.json      (committed)
├── bin/agentctl                       └── .claude/ .ai/         (GENERATED,
└── releases: agents-vX.Y.Z                                git-ignored or
                                                           committed-by-policy*)
```
*Committing generated config is valid if the team prefers repo-self-
sufficiency over freshness; then `agentctl verify` in CI is mandatory.

Flow: `cd freya` (B) or `agent freya` (A) → agentctl resolves contract →
verifies lockfile → launches `claudep <profile>`. Cron: `agent freya -p
"/nightly-review"`. New project onboarding = write PROJECT.yaml + registry
record; nothing else.

## 6. Writing plane-1 agents to be truly project-agnostic

- Speak only in contract terms: run `{{commands.test}}`, read
  `{{docs.architecture}}` — never `php artisan test`, never `docs/ARCH.md`.
- Capability names, not stack names: `db-inspector`, not `mysql-inspector`;
  the stack difference lives in the MCP profile + contract.
- Each agent declares REQUIRES (contract keys + tools) in its frontmatter
  comment; agentctl warns when a project's contract can't satisfy them.
- Tools frontmatter: least privilege always (mcp__server__tool granularity)
  — for reliability; context economy is handled by profiles, not bindings.
- One escape hatch: `agents/<name>.overlay.md` in a project may append
  project-specific instructions; agentctl concatenates. Overlays > forks.

## 7. Governance & rollout

1. ADR-A1: adopt three-plane model + PROJECT.yaml v1 schema (agents architect
   proposes, Laravel architect co-signs the Freya contract).
2. Week 1: write agentctl (materialize/verify only), port existing
   sync-ai.sh logic into it; Freya gets PROJECT.yaml; legacy zsh command
   becomes `agent <name>` calling agentctl.
3. Week 2: lockfile + CI verify in Freya; mcp-profiles moved under registry.
4. Week 3: first tagged release; channels live; tip-harvest digests start
   flowing into releases instead of direct pushes.
5. Defer: direnv (B) until ≥2 active projects; gateway (E) until isolation
   pain is measured, not assumed.

Success criteria: new project onboarded in <30 min; agent upgrade = one PR
per project; zero hand-edited files under .claude/ in any project; CI fails
on drift.
