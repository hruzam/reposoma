# tmux: windows, options, and attachment

A tmux window can exist without appearing in a terminal column. `select-window` chooses a window in a tmux session; it prints nothing and does not attach a regular shell to tmux.

## Create and enter a shell window

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

## Rename the window

```sh
tmux rename-window -t 'helloWorld:sample-codex' 'scratch-codex'
```

Renaming keeps each pane's `%` ID. A pane with ID `%42` is still addressable
with `-t '%42'`. A target that uses the window name changes from
`helloWorld:sample-codex.0` to `helloWorld:scratch-codex.0`.

## Close the whole window

This closes every pane in the window. Run the command that matches its current name.

**Before renaming**

```sh
tmux kill-window -t 'helloWorld:sample-codex'
```

**After renaming**

```sh
tmux kill-window -t 'helloWorld:scratch-codex'
```
