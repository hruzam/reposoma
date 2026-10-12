# 03 — Ovitmugen contracts

Nabla.Tmux handoff · 3 of 5 · consumed by 02 (gate, door) and 04 (registry)

Owner: ovitmugen's designer. This file states what the parser, gate and registry need from it. Confirm or bend.
Existing description: Nablarva `.dev/session/AGENTS_PROJECT_DESIGN.md` (path as dictated; not read for this handoff).

## Role

Ovitmugen is the tool name for the tmux primitives. It is mechanism only: no policy, trust, approval or scope. Those sit above it (02, 04). Functions inside carry plain names.

## Conventions

- **Address = tmux pane id** (`%12`). It is unique for the server's life, never reused, and unaffected by renumbering. `session:window.pane` is for display only.
- **Identity lives on the pane** as user options: `@bus_instance`, `@bus_agent`, `@bus_role`, `@bus_parent`, `@bus_mode`. One `list-panes` call returns liveness and identity together, so there is nothing to drift. Pane options need tmux ≥ 3.0; check `tmux -V`.
- **Unlabeled panes don't exist** for the bus. This also covers the moment between creating a pane and labeling it.
- **Output:** JSON on stdout, diagnostics on stderr, exit codes per 01.

## Functions

| Function | Does | Returns |
|---|---|---|
| `panes_list` | every labeled pane, with liveness and identity | JSON array |
| `pane_resolve <pane>` | exists? alive? who? | JSON, or TARGET_GONE |
| `pane_spawn <window> <cmd>` | new pane without stealing focus | pane id |
| `pane_label <pane> <key=value…>` | write identity options | — |
| `pane_ready <pane> <adapter>` | readiness probe: capture + adapter regex, polled until timeout | ok, or TARGET_NOT_READY |
| `pane_inject <pane> <mode> <line or file> <id>` | the only write into a pane | ok, or a code |
| `pane_capture <pane> [lines]` | recent output | text |
| `pane_kill <pane>` | remove the pane | — |

Core tmux calls:

```sh
# panes_list: one pane per line, fields separated by a TAB
T=$'\t'
tmux list-panes -a -F "#{pane_id}${T}#{pane_dead}${T}#{pane_dead_status}${T}#{session_name}:#{window_index}.#{pane_index}${T}#{@bus_instance}${T}#{@bus_agent}${T}#{@bus_role}${T}#{@bus_parent}${T}#{@bus_mode}"

# pane_resolve: same format; a non-zero exit means the pane is gone
tmux display-message -p -t %12 "<same format>"

# pane_spawn: -d keeps the human's focus; -P -F prints the new pane id
tmux split-window -d -P -F '#{pane_id}' -t <window> '<launch command>'
tmux new-window   -d -P -F '#{pane_id}' -n <name> '<launch command>'

# pane_label
tmux set-option -p -t %12 @bus_instance 'atlas#b2'

# pane_capture
tmux capture-pane -p -J -t %12 -S -50

# pane_kill
tmux kill-pane -t %12
```

## The inject door

```
1  lock     flock $BUS_HOME/lock/<pane>                one delivery per pane at a time
2  resolve  pane_resolve <pane>                        TARGET_GONE / TARGET_DEAD    retryable
3  ready    pane_ready <pane> <adapter>                TARGET_NOT_READY             retryable
4  write    nudge:  tmux send-keys -t <pane> -l "<line>"
                    tmux send-keys -t <pane> Enter
            paste:  tmux load-buffer -b bus-<id> <file>
                    tmux paste-buffer -p -d -b bus-<id> -t <pane>
                    sleep <adapter paste_settle>
                    tmux send-keys -t <pane> Enter
5  unlock; log delivered or delivery_failed
```

- `-l` is mandatory on the text. Without it tmux reads words as key names, so `Enter`, `Escape` or `C-c` inside a message would become keystrokes.
- Enter is always its own `send-keys`.
- `paste-buffer -p` brackets the text only if the TUI turned bracketed paste on; otherwise every newline submits. Paste mode is for adapters with verified support only.
- One buffer per message (`bus-<id>`), deleted by `-d`, so concurrent senders never share a buffer.
- Steps 1–3 may be retried. Step 4 is never retried once started (01, R5).
- Enforcement: a test greps the code. `send-keys` and `paste-buffer` may appear only inside `pane_inject`.

## Lifecycle signal (optional, cheap)

```sh
tmux set-option -w -t <agent-window> remain-on-exit on
tmux set-hook -g pane-died   'run-shell "bus event pane_died #{hook_pane}"'
tmux set-hook -g pane-exited 'run-shell "bus event pane_exited #{hook_pane}"'
```

With `remain-on-exit`, a crashed CLI leaves a dead pane (`pane_dead=1`) that can still be captured for a post-mortem, instead of vanishing. The hooks only append to the log; nothing polls. Verify that `#{hook_pane}` works on the installed tmux.

## Spawn vector

Returned by `bus spawn` and logged as the `spawned` event. The registry (04) builds it; ovitmugen supplies the pane fields.

```json
{"instance":"atlas#b2","agent":"atlas","role":"solver","mode":"oneshot",
 "parent":"oraculum#a1","pane":"%12","address":"nabla:2.1",
 "spawned":"2026-10-10T17:40:12+02:00","ready":true}
```

## CLI adapters: fill by testing, assume nothing

| Property | claude | codex | jev |
|---|---|---|---|
| launch command for a given agent definition | TBD | TBD | TBD |
| ready regex (idle at the prompt) | TBD | TBD | TBD |
| bracketed paste on | TBD | TBD | TBD |
| paste settle delay | TBD | TBD | — |
| custom slash command for the nudge | TBD | TBD | — |
| `$TMUX_PANE` reaches the agent's shell tool | TBD | TBD | TBD |
| input while busy: queued, dropped or interleaved | TBD | TBD | TBD |
| output that means "brand down" (auth, quota) | TBD | TBD | TBD |

"Input while busy" is the likely cause of the old tunnel symptom, where a late message didn't reach the live TUI. Until it is measured, the gate serializes deliveries per target (02).

If a CLI's sandbox strips `$TMUX_PANE` from its shell tool, sender derivation fails for that CLI. Fallback: walk the caller's parent-process chain (`/proc/<pid>/stat`) and match it against `#{pane_pid}` from `panes_list`.

## Confirm with ovitmugen's designer

- `pane_inject` as the single write path, with the sequence above
- pane user options as the identity store
- JSON and `sysexits.h` conventions
- whether the adapter table lives in ovitmugen or in the registry

## Must not forget

- Address by pane id, never by index.
- `-d` on spawn, `-l` on text, Enter sent separately.
- No pane write outside `pane_inject`.
- Unlabeled panes don't exist for the bus.
