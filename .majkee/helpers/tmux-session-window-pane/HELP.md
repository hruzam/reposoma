# tmux sessions, windows, and panes

A session contains windows, and each window contains one or more panes.

## Sessions

```sh
tmux new-session -d -s helloWorld -n shell -c /path/to/scratch
# Create the helloWorld session with a first window named shell. -d keeps the session detached.

tmux list-sessions
# List sessions and show which ones have an attached client.

tmux attach-session -t helloWorld
# From a regular terminal, attach to the session.

tmux switch-client -t helloWorld
# From inside tmux, switch the current client to this session.

tmux detach-client
# From inside tmux, detach the current client and leave the session running.
```

## Windows

A tmux window can exist without appearing in a terminal column. `select-window` chooses a window in a tmux session; it prints nothing and does not attach a regular shell to tmux.

### Create and enter a shell window

```sh
tmux new-window -d -t helloWorld: -n sample-codex -c /path/to/scratch 'exec zsh -l'
# -d keeps the current window selected; -t targets the session; -n names the window; -c sets its start directory.
# This starts only a login shell.

tmux list-windows -t helloWorld -F '#{window_index} #{window_name}'
# Show window indices and names.

tmux select-window -t helloWorld:sample-codex
# Select it for a client already attached to helloWorld. No output is normal.

tmux attach-session -t helloWorld \; select-window -t :sample-codex
# From another terminal, attach that terminal to the session and select the window.
```

### Rename the window

```sh
tmux rename-window -t 'helloWorld:sample-codex' 'scratch-codex'
```

Renaming keeps each pane's `%` ID. A pane with ID `%42` is still addressable
with `-t '%42'`. A target that uses the window name changes from
`helloWorld:sample-codex.0` to `helloWorld:scratch-codex.0`.

### Close the whole window

This closes every pane in the window. Run the command that matches its current name.

**Before renaming**

```sh
tmux kill-window -t 'helloWorld:sample-codex'
```

**After renaming**

```sh
tmux kill-window -t 'helloWorld:scratch-codex'
```

## Panes

Use the current window name when splitting or listing panes. Replace `%42` with
the pane ID shown by `list-panes`.

```sh
tmux split-window -h -t 'helloWorld:sample-codex'
# Split the active pane side by side. Use -v to stack the panes.

tmux list-panes -t 'helloWorld:sample-codex' -F '#{pane_index} #{pane_id}'
# Show each pane's index and % ID.

tmux select-pane -t '%42'
# Select the pane by ID.
```

### Close a pane

Closing the last pane also closes its window.

```sh
tmux kill-pane -t '%42'
```

## Set or clear options

```sh
tmux set-option -w -t helloWorld:sample-codex monitor-silence 600
# Set a window option: mark this window after 600 seconds without output.

tmux set-option -u -w -t helloWorld:sample-codex monitor-silence
# Clear that window's value and inherit the global setting again.

tmux set-option -t helloWorld status off
# Set a session option: hide the status line in this session.

tmux set-option -u -t helloWorld status
# Clear the session's value and inherit the global setting again.
```

Common flags: `-t` names the target session or window; `-w` selects a window option; `-u` clears an option; `-g` sets or clears the global default. Session options use `-t session` without `-w`. Check a value with `show-options`, adding `-w` for window options.
