---
schema: codex-cold-start/v1
kind: token-economy-index
state: ready
mailbox_git_state: untracked-visible
created_at: 2026-08-21T23:13:41+02:00
created_by: "@Cartan"
audience: next-codex-session
host: { hostname: hruzam, logical: home, timezone: Europe/Prague }
project:
  root: /home/hruzam/www/imago_cz/freya
  branch: majkee/pre-develop
  head: 621281b9972893d1fae5bff811a210b816c8c074
  upstream: tail/majkee/pre-develop
  tracked: clean
codex:
  cli: codex-cli 0.147.0
  session_id: 01a02108-239d-7c10-9ec0-b291de0f338c
  rollout: /home/hruzam/.codex/sessions/2026/08/20/rollout-2026-08-20T23-16-16-01a02108-239d-7c10-9ec0-b291de0f338c.jsonl
  model: gpt-5.6-sol
  effort: high
transport:
  root: /home/hruzam/www/imago_cz/freya.devenv
  branch: core
  head: b97d93e1d9f0835fc5b2713aa9e6b59784490a0f
  tracked: clean
resume:
  first_command: >-
    bash /home/hruzam/ia-sync/codex/skills/cold-start-card/scripts/capture-context.sh
    --cwd /home/hruzam/www/imago_cz/freya
  detailed_repair_card: /home/hruzam/reposoma/_mail/monkey/inbox/cartan.freya-codex-agent-repair.2026-08-21.md
read_policy:
  first: this card only
  conditional: read the detailed repair card only when executing agent repair
  avoid: do not load the rollout transcript unless a disputed claim requires it
authority:
  may_finish:
    - Claude-native cold-start skill adaptation in ia-sync portable source
    - bounded Freya W3 repairs named in the detailed card
    - validation and dry-run comparisons
  gated:
    - live skill deployment
    - real Freya sync or deploy
    - commit, push, or remote mutation
    - application code or W1 files
pointers:
  - /home/hruzam/ia-sync/codex/skills/cold-start-card/
  - /home/hruzam/ia-sync/claude/skills/cold-start-card/SKILL.md
  - /home/hruzam/reposoma/_mail/README.md
  - /home/hruzam/www/imago_cz/freya/.codex/agents/
  - /home/hruzam/www/imago_cz/freya/.dev/PROJECT.yaml
---

# Long-session close — read cheaply

Run the `first_command`, compare its fresh facts with the frontmatter, then choose only one lane.

## State map

| Lane | State | Next action |
|---|---|---|
| Four Freya Codex roles | authored, transported, byte-identical | Fresh-session discovery and small W3 repairs are described in the detailed repair card. |
| Codex `cold-start-card` skill | portable source created and validated; untracked in `ia-sync` | Majkee said he will deploy. Do not deploy or commit on inference. |
| Skill-script bond | complete | Every Codex user of the skill runs `scripts/capture-context.sh`; Bash locates the structured Python collector. |
| Claude equivalent | discussed, not implemented | Adapt the existing Claude skill rather than creating a rival. Use `${CLAUDE_SKILL_DIR}` for its bundled script; preserve Claude-native invocation/dynamic-context semantics. |
| `/tmp` discipline | agreed | Treat it as disposable staging: create → validate → promote. Never use it as canon, cross-session memory, or the only copy. |
| Temple mailbox | contract drift discovered | README says messages are ignored, but existing messages are tracked and both Cartan cards appear untracked. Do not stage or repair without Majkee's gavel. |

## Choose one lane

### A — finish Claude teaching

Read `/home/hruzam/ia-sync/claude/skills/cold-start-card/SKILL.md`, then update that same portable skill with:

1. the shared staging invariant;
2. a bundled Bash capture entry point resolved through `${CLAUDE_SKILL_DIR}`;
3. structured, secret-averse first-shot context;
4. explicit validation and promotion gates;
5. no always-on hook unless Majkee separately asks for deterministic lifecycle automation.

Current official orientation: `https://code.claude.com/docs/en/slash-commands` and `https://code.claude.com/docs/en/hooks-guide`.

### B — repair Freya agents

Read `cartan.freya-codex-agent-repair.2026-08-21.md` and follow its queue. Do not repeat its evidence here.

## Close

Report which lane was completed, what remains gated, and exact validation output. Archive this index only when its remaining lanes are completed or explicitly deferred; archive the detailed repair card independently when its own `Done when` conditions hold.
