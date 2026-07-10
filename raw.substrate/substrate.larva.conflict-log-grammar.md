# substrate.larva.conflict-log-grammar

`source: larva.dev/.shared/syntax/conflicts.md · excavated: 2026-07-10 (pre-burial salvage)`
`verdict at dig: HOLD under observation · dig record: pulse.atlas.md [2026-07-10]`
`trigger: a real cross-layer conflict recurs in the temple (two sanctioned surfaces disagree`
`and neither can be immediately fixed) · destination: one section in canon-style, or a`
`_TEMPLATE in raw.settings/`

## Atlas commentary

The DSL this file governed is dead; the **entry grammar** is the salvage. What larva got
right here, and the temple does not yet have:

- **Logged, not resolved.** A dedicated register for disagreements that are *known but not
  yet worth resolving* — distinct from a decision ledger (locks) and from "Still open"
  items (questions). A conflict entry says: *both sides stand, here is the exact shape of
  the disagreement, here is what would trigger resolution.*
- **The five-section entry shape:** Surface (where they visibly clash) → Deeper (the real
  level-of-abstraction analysis) → Reading (are they competing or complementary?) →
  Decision (usually "no action" + explicit revisit conditions) → Receipts (file:section
  citations). C1 and C2 both conclude the layers are complementary, not competing — the
  grammar forced that discovery instead of a premature winner-pick.
- **C3 is the best specimen:** same-surface verb drift (`larva run` vs `larva-play`),
  severity *medium* because operator confusion is real, and the honest close — "this
  synthesis cannot resolve it from documents alone; needs a runtime check." A conflict log
  that knows the limits of its own evidence.

Dead inside the object: every larva-specific referent (Larvator, GEM, vega-shell, the
layer files themselves). Read it for the *shape*, never the content.

## The object (verbatim)

````markdown
# Syntax layer conflicts

> Append-only ledger of where layers disagree.
> **Logged, not resolved.** Resolution requires @Houston + @majkee sanction.

---

## C1 — vega-shell-v0.1 ↔ kukla-bracketless-v0

```yaml
status:        OPEN
logged:        2026-04-19
domain:        symbol overlap + scope mismatch
severity:      low (layers operate at different levels)
```

### Surface

Both layers use `@` for agents and reference tools. Vega-shell sticks to POSIX flags
(`--executor=@Trajectory`); KUKLA uses `@Builder_Agent` as a free-standing wake token.

### Deeper conflict

The two layers are **not at the same level of abstraction**:

| dimension       | vega-shell-v0.1                 | kukla-bracketless-v0           |
|---------------- |-------------------------------- |------------------------------- |
| target          | terminal CLI                    | inter-agent message protocol   |
| user            | @majkee at zsh prompt           | agents writing to each other   |
| primary verb    | `larva run`                     | `@Agent -> action`             |
| state model     | stateless (one task per call)   | stateful (POOL `~`, branches)  |
| cost            | low (POSIX is cheap)            | high (requires runtime support)|

### Reading

These layers are **complementary**, not competing. Vega-shell is the **outer interface**
(human → larva); KUKLA is a candidate for the **inner protocol** (larva → agents).

A future sanctioned state could plausibly run both:

```
active_outer:  vega-shell-v0.1
active_inner:  kukla-bracketless-v0   (when sanctioned)
```

But `active.md` currently models only one slot. Splitting `active.md` into `outer/inner`
is a structural change deferred until KUKLA sanctioning is on the table.

### Decision

**No action.** Vega-shell stays sole active layer. KUKLA stays research. Revisit when:

- a concrete inter-agent message exchange needs to be authored, AND
- @majkee + @Houston jointly sanction extending `active.md` to two slots.

### Receipts

- `layers/vega-shell-v0.1.md` §2 (CLI form)
- `layers/kukla-bracketless-v0.md` §1 (alphabet)
- `layers/kukla-bracketless-v0.md` §2 (POOL semantics — runtime-level)

---

## C2 — vega-shell-v0.1 ↔ cmd-chat-v0.1

```yaml
status:        OPEN
logged:        2026-05-01
domain:        scope mismatch (no real overlap)
severity:      low (layers operate at different surfaces)
```

### Surface

Both layers describe how `@majkee` issues commands. Vega-shell describes the **terminal**
form (`larva run <playbook> "<task>"`). Cmd-chat describes the **chat** form
(`cmd <verb> --<param>` and `cmd <verb> -->'<context>'`). They share the symbols `->` and
`-->` for step / sub-step but use them at the same level of meaning, not different ones.

### Deeper conflict

The two layers are **not at the same level of abstraction**:

| dimension       | vega-shell-v0.1                 | cmd-chat-v0.1                  |
|---------------- |-------------------------------- |------------------------------- |
| target          | zsh terminal                    | chat window with an AI agent   |
| user            | @majkee at shell prompt         | @majkee in chat                |
| primary verb    | `larva run` / `larva-play`      | `cmd <verb>`                   |
| dispatch        | shell wrapper -> playbook card  | agent reads card in `commands/`|
| state model     | stateless (one task per call)   | stateless (one turn per cmd)   |

### Reading

These layers are **complementary**, not competing. Vega-shell governs what the terminal
parses; cmd-chat governs what the agent parses. They could plausibly coexist as:

```
active_terminal:  vega-shell-v0.1
active_chat:      cmd-chat-v0.1   (when sanctioned)
```

The structural change required is **the same** as C1: split `active.md` into multiple
slots. The decision to defer C1 applies here too.

### Decision

**No action.** Vega-shell stays sole active layer. Cmd-chat stays research, available for
read-only reference by agents that want to understand the convention already in use across
`.shared/commands/*`. Revisit jointly with C1 when a multi-slot `active.md` is on the table.

### Receipts

- `layers/cmd-chat-v0.1.md` §2 (invocation grammar)
- `layers/cmd-chat-v0.1.md` §4 (card declaration)
- `.shared/commands/print.md`, `mks.md`, `session-search.md`, `agent-search.md`,
  `larva-search.md`, `larva-help.md` (the corpus)
- `.shared/commands/commands_common_claude.ai.md` (in-use chat-side examples)

---

## C3 — vega-shell-v0.1 ↔ larva_syntax_training.md (terminal verb drift)

```yaml
status:        OPEN
logged:        2026-05-01
domain:        adopted-form drift between sanctioned layer and training doc
severity:      medium (operator confusion: typing one fails if only the other is wired)
```

### Surface

Two documents disagree on the terminal command name:

| document                                              | adopted form                              |
|------------------------------------------------------ |------------------------------------------ |
| `layers/vega-shell-v0.1.md` (sanctioned per active.md)| `larva run <playbook> "<task>"`           |
| `.setup/library/larva_syntax_training.md`             | `larva-play <workflow> "<task>"`          |

The training doc explicitly **demotes** Vega's form: *"That is a useful design reference,
but it is **not** the adopted v0.1 surface. For current Larva training, use `larva-play
...` as canonical."*

### Deeper conflict

This is **not** a scope/level disagreement (C1, C2). Both documents describe the same
surface — the user-facing terminal verb — and they prescribe **different verbs**.

Possible explanations:

1. **Stale active layer.** The training doc post-dates `vega-shell-v0.1` sanction
   (sanctioned 2026-04-19; training doc per `majke_syntax-training.md` is 2026-04-21).
   `larva-play` may have superseded `larva run` without `_ledger.md` being updated.
2. **Wrapper alias.** `larva-play` may be a wrapper around `larva run` — both work, only
   the canonical name in training material changed.
3. **Training-doc drift.** The training doc may have drifted from the sanction.

This file does not resolve which is true.

### Reading

If `larva-play` is canonical in practice, `active.md` and `vega-shell-v0.1.md` lag the
real state. The remedy is one of:

- **Option A.** Update `vega-shell-v0.1.md` §2 + symbol table to use `larva-play`. Append
  `_ledger.md` entry noting the rename. Keep layer_id stable.
- **Option B.** Bump to `vega-shell-v0.2`, add a new layer file, point `active.md` at it,
  ledger the switch.
- **Option C.** Update `larva_syntax_training.md` to match the sanctioned `larva run`.

Option A is lowest cost if the change is purely a verb rename. Option B is correct if the
adopted form has other deltas. Option C is correct if the training doc drifted unilaterally.

### Decision

**No action.** Logged for joint @majkee + @Houston review. Verifying which document
reflects the actually-wired runtime requires a check that this synthesis cannot perform
from documents alone — needs a glance at `~/www/larva/bootstrap/` or the alias definitions
in shell config.

### Receipts

- `layers/vega-shell-v0.1.md` §2 (recommends `larva run`)
- `layers/vega-shell-v0.1.md` §5 (mentions `larva-run` alias name, distinct from `larva-play`)
- `.setup/library/larva_syntax_training.md` §"Canonical User-Facing Form" (`larva-play`)
- `.setup/library/larva_syntax_training.md` §"Vega Note" (explicit demotion of `larva run`)
- `.setup/scrum/majke_syntax-training.md` (training doc dating to 2026-04-21)

---

## How to add a new conflict

```yaml
## C<N> — <layer-A> ↔ <layer-B>
status:    OPEN | RESOLVED | DEFERRED
logged:    YYYY-MM-DD
domain:    <one-line>
severity:  low | medium | high
```

Then write Surface / Deeper / Reading / Decision / Receipts sections as above.

---

*End of conflicts log.*
````
