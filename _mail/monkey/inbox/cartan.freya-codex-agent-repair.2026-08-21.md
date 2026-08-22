---
schema: codex-cold-start/v1
kind: repair-handoff
state: ready
mailbox_git_state: untracked-visible
created_at: 2026-08-21T22:26:50+02:00
created_by: "@Cartan"
audience: next-codex-session
host:
  hostname: hruzam
  logical: home
  timezone: Europe/Prague
  platform: Linux 6.18.39-1-MANJARO x86_64
project:
  name: freya
  root: /home/hruzam/www/imago_cz/freya
  branch: majkee/pre-develop
  head: 621281b9972893d1fae5bff811a210b816c8c074
  upstream: tail/majkee/pre-develop
worktree:
  tracked: clean
  ignored_project_state: present
  ignored_roots:
    - .codex/agents/
    - .dev/
codex:
  cli: codex-cli 0.147.0
  session_id: 01a02108-239d-7c10-9ec0-b291de0f338c
  rollout: /home/hruzam/.codex/sessions/2026/08/20/rollout-2026-08-20T23-16-16-01a02108-239d-7c10-9ec0-b291de0f338c.jsonl
  started_at: 2026-08-20T21:16:16.697Z
  originator: codex-tui
  model: gpt-5.6-sol
  effort: high
  active_product_goal: null
transport:
  root: /home/hruzam/www/imago_cz/freya.devenv
  branch: core
  head: b97d93e1d9f0835fc5b2713aa9e6b59784490a0f
  upstream: origin/core
  tracked: clean
  deploy_stamp_at: 2026-08-21T17:15:33+02:00
  deploy_stamp_app_head: 621281b99
  agent_mirror: byte-identical
portable_skill:
  source: /home/hruzam/ia-sync/codex/skills/cold-start-card
  runtime_target: /home/hruzam/.agents/skills/cold-start-card
  state: source-prepared-runtime-not-deployed
task:
  objective: >-
    Prove fresh-session discovery of Freya's four project-scoped Codex agents,
    repair the remaining W3 description/runtime-map drift, and leave transport
    evidence without touching application code.
  first_action: >-
    bash /home/hruzam/ia-sync/codex/skills/cold-start-card/scripts/capture-context.sh
    --cwd /home/hruzam/www/imago_cz/freya
authority:
  may_write:
    - /home/hruzam/www/imago_cz/freya/.codex/agents/
    - /home/hruzam/www/imago_cz/freya/.dev/PROJECT.yaml
    - this mailbox card when archiving after processing
  gated:
    - application code
    - W1 Boost-generated AGENTS.md and managed skills
    - dependency changes
    - real sync or deploy
    - commit, push, or remote mutation
pointers:
  - /home/hruzam/www/imago_cz/freya/AGENTS.md
  - /home/hruzam/www/imago_cz/freya/CLAUDE.local.md
  - /home/hruzam/www/imago_cz/freya/.dev/PROJECT.yaml
  - /home/hruzam/www/imago_cz/freya/.dev/guides/freya-home-startup.md
  - /home/hruzam/www/imago_cz/freya/.codex/config.toml
  - /home/hruzam/www/imago_cz/freya/.codex/agents/
  - /home/hruzam/www/imago_cz/freya.devenv/.deploy-stamp
  - /home/hruzam/reposoma/_mail/README.md
---

# Freya Codex agent repair

This is non-canonical working mail. Read the bus README, process the bounded repair, then move this file from `inbox/` to `archive/`; do not create a tracking table or a sent copy.

## Read first

1. `AGENTS.md` for the live Boost-generated Laravel contract. It is W1 and must not be edited.
2. `CLAUDE.local.md` and `.dev/PROJECT.yaml` for Freya ownership, locks, and W3 transport semantics.
3. All four `.codex/agents/*.toml` files, then `.codex/config.toml` for their inherited Boost and Nightwatch MCP bond.
4. `.dev/guides/freya-home-startup.md` for the already-transported home startup description.
5. This card's Codex rollout only as a track pointer. Do not ingest or quote the transcript wholesale.

## Completed — do not redo

Four project-scoped roles already exist:

| Role | Model / effort | Sandbox | Seat |
|---|---|---|---|
| `phonon` | `gpt-5.6-terra` / `high` | `workspace-write` | practical senior Laravel implementer |
| `keystone` | `gpt-5.6-sol` / `xhigh` | `read-only` | software architect |
| `assay` | `gpt-5.6-sol` / `high` | `workspace-write` | independent code/test gate; never fixes |
| `voyager` | `gpt-5.6-terra` / `medium` | `read-only` | Laravel tutor grounded in Freya code |

Observed at card creation:

- The app's tracked worktree is clean; the role files and `.dev/` are intentionally ignored W3 state.
- The sibling transport is clean at `b97d93e1d9f0835fc5b2713aa9e6b59784490a0f` (`feat: add Codex roles and home startup guide`). That commit contains all four role files plus `dev/PROJECT.yaml` and the startup guide.
- `rsync -ani --delete .codex/agents/ ../freya.devenv/codex/agents/` produced no changes, and corresponding SHA-256 hashes match.
- This Cartan session did **not** execute the real sync. Treat the already-matching mirror and transport commit as observed existing state, not this session's authorship.
- The portable `cold-start-card` skill source was prepared for `ia-sync`; Majkee said he will deploy it. Do not edit the live runtime copy by hand.

## Curvature to repair

1. **Fresh-session discovery is still unproved.** This Codex session began on 2026-08-20, before the role files' 2026-08-21 creation and transport. The earlier missing `phonon` is therefore consistent with session-start discovery staleness, but that is an inference—not proof.
2. **Voyager roster drift.** `.dev/PROJECT.yaml:47` still calls Voyager a “tutor-architect” that creates “Trajectory handoff briefs.” The Codex role is deliberately a tutor only and routes architecture to Keystone. Make the W3 roster description runtime-neutral and accurate; do not broaden Voyager's TOML.
3. **PHP map needs interpretation, not blind replacement.** Live Boost/AGENTS reports PHP 8.5; `.dev/PROJECT.yaml:17` says PHP 8.4; `.dev/flag.md:19` explicitly describes production as PHP 8.4; `.dev/pulse.md:64` already records the 8.4→8.5 skew. Clarify dev/live versus production in the W3 project map if local doctrine permits. Do not rewrite the production lock merely to make the numbers equal.
4. **Guide-path spelling is already corrected.** The operator originally mentioned `~/reposoma/guides`, but the real home is `~/reposoma/raw.guides`; `.dev/guides/freya-home-startup.md:59` already points there. Search for a new bad pointer, but do not manufacture an edit if none exists.
5. **The bus map disagrees with Git.** `_mail/README.md` says only its README and `.gitignore` are tracked and all messages are gitignored. At card creation, existing Monkey messages are actually tracked, `_mail/.gitignore` contains only `!.gitignore` and `!README.md`, and this new card appears as `??` rather than ignored. Leave it untracked and do not silently repair, stage, or commit the bus; Majkee owns that separate gavel.

## First tool shot

Run the skill's bonded Bash entry point first. It emits structured JSON without `.env`, credentials, remote URLs, database data, or transcript content:

```bash
cd /home/hruzam/www/imago_cz/freya
bash /home/hruzam/ia-sync/codex/skills/cold-start-card/scripts/capture-context.sh --cwd "$PWD"
```

Then use targeted native probes:

```bash
rg -n -S 'voyager|PHP 8\.4|PHP8\.4|8\.4→8\.5' .dev/PROJECT.yaml .dev/flag.md .dev/pulse.md
for file in .codex/agents/*.toml; do python3 -c 'import pathlib, sys, tomllib; tomllib.loads(pathlib.Path(sys.argv[1]).read_text())' "$file"; done
sha256sum .codex/agents/*.toml ../freya.devenv/codex/agents/*.toml
rsync -ani --delete .codex/agents/ ../freya.devenv/codex/agents/
```

## Repair queue

1. In a genuinely fresh Codex session opened with CWD at the Freya root, inspect the available custom-agent types. Expected: `phonon`, `keystone`, `assay`, and `voyager` are all discoverable with the model, effort, and sandbox shown above.
2. If a role is missing, compare the live project files with the transport hashes and inspect Codex's documented project-agent discovery boundary. Repair only the smallest proven configuration fault. File presence alone is not runtime proof.
3. Correct the Voyager roster line. Resolve the PHP wording only after preserving the local-versus-production distinction.
4. Parse every TOML file, confirm `.codex/config.toml` still exposes Boost and Nightwatch, and perform a dry-run transport comparison.
5. Ask Majkee before any real sync/deploy or Git write. If authorized, verify the new mirror state and record exact expected versus observed output.
6. Move this card to `_mail/monkey/archive/` only after all accepted repair items are complete or explicitly deferred.

## Done when

- A fresh session shows all four custom-agent types.
- Their role boundaries, models, efforts, sandboxes, and inherited MCP configuration match the table.
- `.dev/PROJECT.yaml` describes Voyager accurately and represents PHP runtime skew intentionally.
- TOML parses, focused hashes/dry-run agree, and no application code or W1 file changed.
- Any real transport or Git mutation has explicit Majkee authority and evidence.
- This inbox message is archived under the bus protocol.
