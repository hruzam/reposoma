# 04 — Registry

Nabla.Tmux handoff · 4 of 5 · used by 02 (resolve, scope) · built on 03 (`panes_list`, `pane_label`)

## Two sources of truth, nothing hand-maintained

| Question | Answered by |
|---|---|
| Who can exist | agent definitions on disk, e.g. `.claude/agents/*.md` for Claude Code; a per-CLI adapter for the others |
| Who exists now | tmux, via `panes_list` (labeled panes only) |
| What happened | the log (01, R7) |

A registry query joins the first two at the moment of asking. There is no registry file, no snapshot and no polling.

Definitions normalize to `name` (unique across all CLIs), `cli`, `model`, `role`, `capabilities` and a launch spec. Valid names come only from this set, like a combo box: `bus spawn atlas` either resolves to a defined agent or fails with TARGET_UNKNOWN.

## Instances

| Command | Does |
|---|---|
| `bus spawn <agent> [--task <file>] [--mode <m>] [--window <w>]` | check the definition and spawn rights → mint `atlas#<short>` → `pane_spawn` → `pane_label` → `pane_ready` → log `spawned` → return the vector (03). With `--task`, the task then goes out as a normal message. |
| `bus adopt <agent>` | label the current pane, for sessions started by hand such as the main Claude Code session. `bus adopt human` labels the human's own shell. |
| `bus kill <instance> [--force]` | clean-shutdown check (no open task to it, nothing undelivered from it) → `pane_kill` → log `killed`. `--force` fails its open messages with TARGET_GONE. |

- **Modes.** `oneshot` (default): after its result is delivered to the parent, a short grace period, then kill (frame 1: after reply → session end → kill pane). `persistent` (prevailing): lives until `bus kill`.
- **Instance ids are never reused.** A respawned Atlas is a new instance, so the log stays unambiguous.
- **Spawn and kill rights:** the parent and the human; other roles by config.

## Scoped query: `bus who`

The caller comes from `$TMUX_PANE`. The answer lists only instances in the caller's range, so the visibility rule is the authorization rule: what you can't see, you can't address. `resolve`, used by the parser, applies the same rule and returns TARGET_OUT_OF_SCOPE.

```json
{"caller":"oraculum#a1","at":"2026-10-10T17:41:03+02:00","visible":[
 {"instance":"atlas#b2","agent":"atlas","role":"solver","capabilities":["code","review"],
  "relation":"child","status":"alive","open":1},
 {"instance":"vega#c7","agent":"vega","role":"leader","capabilities":["plan"],
  "relation":"link","status":"dead","open":0}]}
```

Status values: `alive`, `dead` (pane kept, program exited), `not_ready`. Gone panes are absent; their history is in the log.

Cold start: an agent arriving mid-discussion runs `bus who` (who is alive in my range) and `bus inbox` (open messages to me, with ids and budgets). That is two pulls and no history replay.

## OPEN: range rule

Proposal: hierarchy plus links.

- hierarchy: self, own parent, own children
- links: explicit cross-group pairs, e.g. leader ↔ leader (frame 2: A in window 1 ↔ B in window 2)
- human: everything

Frame 2 needs leader-to-leader channels, which pure hierarchy forbids; a pure allow-list means listing every pair by hand. Siblings stay invisible to each other unless linked, which keeps parallel solvers from chatting sideways.

```toml
# scope.toml: agent names; applies to all their instances
links = [ ["oraculum", "vega"] ]
```

## OPEN: several live instances per name

Recommended: allowed (`atlas#b2` and `atlas#d9` side by side), because forks and parallel solvers need it. The alternative is one live instance per name: simpler addressing and no TARGET_AMBIGUOUS, but no parallel copies of a definition.

## Brand exposure

Del Giudice et al., *Prompted Identity Degrades Cooperation in Multi-Agent LLM Systems* (arXiv:2609.35928): when agents could see each other's model family, cooperating groups split into label-aligned factions, even when the labels were shuffled or arbitrary. Labeled groups needed about 30% more rounds and 55% more tokens, and their success rate fell from 96% to 81%. Hiding the labels removed the effect.

Their setting was symmetric cooperative games; ours is directed delegation, so the risk here is lower. The mitigation is nearly free anyway:

- The peer view (`bus who` for agents) shows role and capabilities, not brand or model.
- Brand and model stay internal (adapters, tiers, brand health) and visible to the human.
- A brand-specific ability, such as a Claude-only hook, is exposed as a capability, not as the brand name.

Decide: if leaders need the brand to plan, show it to role `leader` only.

## Brand health

```sh
bus brand down codex "subscription lapsed"   # parser returns BRAND_UNAVAILABLE at once
bus brand up codex
```

The state is kept in `$BUS_HOME/brands`. Automatic detection (matching auth or quota strings in captured output, per the 03 adapter table) comes later. Without the flag, an unavailable brand shows up as NO_ACK → TIMED_OUT rather than immediately.

## Fallback without pane options

On tmux older than 3.0: a `registry.json` keyed by pane id, reconciled against `panes_list` on every query, with entries for gone panes dropped. The output contract stays the same.

## Must not forget

- Definitions say who can exist; tmux says who does. Never keep a third list.
- Scope applies to `who` and `resolve` alike.
- Instance ids are never reused.
- Peers see capabilities, not brands.
