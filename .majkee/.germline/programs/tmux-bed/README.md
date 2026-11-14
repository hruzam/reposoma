---
program: tmux-bed
revision: 2026-11-14
author: trajectory (claude), at majkee's explicit request; seed for myShell to redesign
scope: personal .majkee trial; uncanonical; no deploy. Commands only, no daemon.
---

# tmux-bed — switch off, clean, rebuild agent beds

Vendor-neutral. One tmux session holds the team (`vist` below); viewers are **grouped** sessions.
Never attach two terminals to the same session: they mirror. Replace `vist` and the seat table for another team.

## 0. Rules learned in vistMini (why the commands look like this)

1. **The agent must be the pane's root process**: `'exec <agent cmd>'`, never an agent started from a shell prompt.
   A shell-rooted agent is refused by the delivery prototype (22), and if the agent exits, text sent to the pane lands in a shell.
2. **Label every window when you create it** (`@seat @vendor @id @carrier`). The resolver reads labels, not names. A rebuild without labels broke delivery.
3. **One agent per window, one pane per agent window.** tmux 3.7c has no per-pane activity (`#{pane_last_activity}` is empty),
   and windows resolve to their *active* pane. A second pane with live output makes the agent look busy forever
   and can make the resolver target the wrong pane. Status goes in the **tmux status line** (§5) or in a separate ops window.
4. **Before killing anything:** no agent mid-turn, no uncertain send, card committed and pushed for any seat that continues.

## 1. Inventory (read-only; run first, save the output)

```bash
tmux list-sessions -F '#S windows=#{session_windows} attached=#{session_attached}'
tmux list-windows -t vist -F '#I #W seat=#{@seat} vendor=#{@vendor} id=#{@id} pane=#{pane_id} cmd=#{pane_current_command} cwd=#{pane_current_path}'
tmux list-clients -F '#{client_tty} #{client_session} ro=#{client_readonly}'
for p in $(tmux list-panes -s -t vist -F '#{pane_id}'); do echo "$p root=$(ps -o comm= -p $(tmux display -p -t $p '#{pane_pid}'))"; done
```
Save it: `… > ~/reposoma/.majkee/journal/bed-inventory.$(date +%F-%H%M).txt`

## 2. Switch off gracefully (per agent window)

Only after rule 4. Each agent ends its own session by its own command; never kill a mid-turn agent.
- Claude: type `/exit` in its pane (majkee, by hand). Its session stays resumable: `claude --resume <id>`.
- Codex: `/quit` (or Ctrl-C twice when idle). Resumable: `codex resume <thread>`.
Then close the empty window: `tmux kill-window -t vist:<n>`.

## 3. Clean (keeps nothing running)

```bash
# viewers first (they hold no work)
for s in $(tmux list-sessions -F '#S' | grep '^view-\|^vist-'); do tmux kill-session -t "$s"; done
# then the team session, only when every agent window is already closed or confirmed idle
tmux kill-session -t vist
```
Never `tmux kill-server`: other unrelated sessions (helper-utils, traj-home…) live on the same server.

## 4. Build a fresh bed (one block per seat, fill from the roster)

```bash
tmux new-session -d -s vist -n ops -c ~/ia-sync            # window 0: plain shell for the operator
# seat: Claude example
tmux new-window -t vist:1 -n traj -c ~/ia-sync 'exec claude --agent trajectory --model opus'
tmux set -w -t vist:1 @seat 'trajectory'; tmux set -w -t vist:1 @vendor claude; tmux set -w -t vist:1 @carrier tmux
# seat: Codex example (resume a known thread, or start fresh and fill @id after the first turn)
tmux new-window -t vist:2 -n cartan -c ~/ia-sync 'exec codex resume <thread-uuid>'
tmux set -w -t vist:2 @seat 'cartan'; tmux set -w -t vist:2 @vendor codex; tmux set -w -t vist:2 @carrier codex-queue; tmux set -w -t vist:2 @id <thread-uuid>
```
Claude `@id`: read it from the agent's status line or `claude agents --json` after start, then `tmux set -w -t vist:<n> @id <id>`.
Trust/security dialogs at startup are answered by majkee by hand, never by keys from a script.

## 5. Observation without a second pane

```bash
tmux set -t vist status 2
tmux set -t vist 'status-format[1]' '#[align=left] #{@seat}: #{@state} | #{@attempt} | #(tail -1 ~/.local/state/vist/deliver.log | cut -c1-90)'
tmux set -t vist status-interval 5
```
This prints the current window's seat, observed state, last attempt and the last log line under the normal status bar.
It does not touch pane activity, so busy/idle detection stays correct. For a full log view use a separate window:
`tmux new-window -t vist:9 -n log 'exec tail -F ~/.local/state/vist/deliver.log'` (no agent there, so nothing to break).

## 6. Viewers (majkee's terminals)

```bash
tmux new-session -d -t vist -s view-<name>     # grouped: own current window, same windows
tmux attach -t view-<name>                      # writable (scrolling works: Ctrl-b [ , q to leave)
tmux attach -r -t view-<name>                   # read-only: no typing, but also NO scrolling (looks frozen)
```

## 7. First prompts

Each seat starts from its cold-start card, never from chat: paste `read <card path>, write your read-back, wait for a POINT`.
Cards live in `~/reposoma/_cold-start/card/CS.*.md`. myShell's own task text stays where majkee writes it (`journal/raw.<date>.md`).

## Open for myShell to design
- turn §4 into a roster-driven script (roster = data; the script reads it), if repeated rebuilds justify it
- a check function that runs §1 and flags rule 1–3 violations, for the witness sweep
