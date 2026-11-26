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

## Attach a fresh terminal to a window

A **client** is the terminal attached to tmux. The **session** holds the
selected window. Two clients attached directly to `helloWorld` follow that
same selection, so a switch to `seniorDev` in either terminal moves both.

### Keep this terminal on its own window

From a shell outside tmux, run:

```sh
tmux new-session -t helloWorld \; select-window -t :supervisorCli
```

`new-session -t helloWorld` opens and attaches a new session in the
`helloWorld` group. The two sessions share the same windows, panes, and
running programs. Each session keeps its own selected window. `\;` passes
the command separator to tmux, and `:supervisorCli` selects that window in
the newly attached session.

To give the view a name you can reconnect to, add `-s` when you create it:

```sh
tmux new-session -t helloWorld -s view-supervisor-cli \; select-window -t :supervisorCli
```

Later, use `tmux attach-session -t view-supervisor-cli`. The longer
`new-session -d` → `select-window` → `attach-session` sequence is useful if
you want to select the window *before* the terminal attaches. The short
form attaches and selects in the same tmux command sequence.

### Start on a window and share future switches

```sh
tmux attach-session -t 'helloWorld:supervisorCli'
```

This opens `supervisorCli` in `helloWorld` itself. Use it when terminals
attached to `helloWorld` should follow the same window switches.

If you see `$36 | 2 seniorDev @58 | %60`, read it as session ID `$36`,
window index `2` and name `seniorDev`, window ID `@58`, and pane ID `%60`.
The window name tells you where you landed. This command shows the mapping
on the live server:

```sh
tmux list-windows -t helloWorld -F '#{session_id} | #{window_index} #{window_name} #{window_id} | #{pane_id}'
```

## Windows

A tmux window can exist without appearing in a terminal column. `select-window` chooses a window in a tmux session; it prints nothing and does not attach a regular shell to tmux.

### Create and enter a shell window

```sh
tmux new-window -d -t helloWorld: -n sample-codex -c /path/to/scratch 'exec zsh -l'
# -d keeps the current window selected; -t targets the session; -n names the window; -c sets its start directory.
# This starts only a login shell.

tmux select-window -t helloWorld:sample-codex
# Select it for a client already attached to helloWorld. No output is normal.
```

### Find window and active pane IDs

```sh
tmux list-windows -t helloWorld -F '#{window_index} #{window_name} #{window_id} #{pane_id}'
```

Each row shows a window and its active pane. In a row such as
`2 sample-codex @7 %42`, use `-t '@7'` to target the window or `-t '%42'` to
target the pane. To see every pane in a split window, use the pane listings below.

### Rename the window

```sh
tmux rename-window -t 'helloWorld:sample-codex' 'scratch-codex'
```

Renaming keeps the window's `@` ID and each pane's `%` ID. A target that uses
the window name changes from
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

### List panes

Use the window's current name to list its panes. Add `-s` and target the
session to list every pane across its windows.

```sh
tmux list-panes -t 'helloWorld:sample-codex' -F '#{pane_index} #{pane_id}'
tmux list-panes -s -t helloWorld -F '#{window_index} #{window_name} #{window_id} #{pane_index} #{pane_id}'
```

### Split or select a pane

Use the window's current name when splitting. Replace `%42` with the pane ID
shown by `list-panes` when selecting or closing a pane.

```sh
tmux split-window -h -t 'helloWorld:sample-codex'
# Split the active pane side by side. Use -v to stack the panes.

tmux select-pane -t '%42'
# Select the pane by ID.
```

### Exit a CLI and keep its pane and window

Start the CLI from the shell already in the pane. Type `codex` or `claude`
without `exec`. The shell waits for the CLI, then gives you a prompt again
when you quit it. You can start the next CLI in that same pane.

If the pane started with the CLI as its command, or you ran `exec codex`
from its shell, the CLI is the pane's main process. When it exits, tmux
normally removes the pane. Removing the last pane closes the window.

**For a CLI already running as the main process**, go to that pane and
press your tmux prefix (usually `Ctrl-b`), then `:`. Enter this at the tmux
prompt **before quitting the CLI**:

```text
set-option -p remain-on-exit on
```

Quit the CLI normally. The exited pane stays visible. In that same pane,
open the tmux prompt again and enter:

```text
respawn-pane -c /home/hruzam/unikuklatrix/nablarva 'exec zsh -l'
```

Use the directory where you want the new shell to start. This brings back
a shell in the existing pane and preserves its `%` ID and window's `@` ID.
Run future CLIs from that prompt. If the last pane has already disappeared,
use the shell-window creation example above to recreate the window.

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
