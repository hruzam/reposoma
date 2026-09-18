---
kind: issue-card
date: 2026-09-11
brand: codex
found_by: Cartan
project: ia-sync
root: ~/ia-sync
where: ~/.tmux.conf (session mouse defaults)
defect: Codex chat-history wheel scrolling repeatedly becomes unavailable in office tmux sessions with mouse handling disabled.
assoc: [tmux, mouse, scrollback, codex, remote-cli, office, session-options, recurring]
severity: low
pointers:
  - ~/ia-sync/zsh/remote-cli/remote-cli.sh
  - ~/ia-sync/zsh/remote-cli/README.md
  - ~/ia-sync/journal.host-cleanup.md
origin: issue
session_id: 01a0918e-9ab0-7053-88d8-d829f1fad954
rollout: ~/.codex/sessions/2026/09/11/rollout-2026-09-11T19-40-37-01a0918e-9ab0-7053-88d8-d829f1fad954.jsonl
recorded: 2026-09-17
---

Known-recurring issue, placed directly in `routines/` under issue-card path 1.
The filename retains the first observed date in the originating conversation.
Earlier recovery and the reusable helper are recorded in the Cartan 2026-09-12
journal entry and its scroll follow-up; the helper is committed in `442e6c9`.

On 2026-09-17 majkee reported that the mouse wheel again could not scroll chat
history. Inspection of office session `remote-cli` (`$30`, window `@43`, pane
`%43`) found mouse=0, copy-mode inactive, alternate-screen inactive, and 1,822
retained history lines with a 2,000-line limit. Global defaults were mouse=off
and history-limit=2000. The installed helper matched repository source.

Intervention: ran the existing bash helper with the pinned target `$30:@43.%43`.
It returned mouse=1 and pane/session history limits of 50,000 lines; a separate
read confirmed these settings. Operator confirmation of wheel behavior for this
occurrence is pending. The earlier journal records operator-confirmed recovery.

The repair is deliberately session-local. Recreated or other untreated sessions
can inherit mouse=off again; reattaching the same surviving session retains its
options. This inspection does not establish that a setting switched off by itself.

## Recovery

From an ordinary terminal shell on the host, for the affected session named
`remote-cli` (replace that argument when the affected session has another name):

```bash
bash ~/.config/zsh/remote-cli/remote-cli.sh status remote-cli
bash ~/.config/zsh/remote-cli/remote-cli.sh scroll remote-cli
```

From a shell already inside the affected tmux session, `remote-scroll` is the
alias; the bash equivalent is `bash ~/.config/zsh/remote-cli/remote-cli.sh scroll`.
The helper enables mouse and raises a smaller history limit to at least 50,000.
It preserves larger session limits. It does not change global defaults or sizing.

While Codex occupies the pane, the shortest immediate intervention is **Ctrl+B**,
release, **:**, then `set-option mouse on` and Enter. For keyboard scrolling,
**Ctrl+B**, release, **[**, then **PgUp/PgDn**; **q** leaves copy mode.
If the wheel still fails with mouse=1, check the wheel binding and whether the
application consumes mouse events; use keyboard copy mode as the discriminating
check. This response does not recover discarded lines or promise access to the
entire saved chat transcript through terminal scrollback.

Tmux mouse ownership is described in the
[upstream FAQ](https://github.com/tmux/tmux/wiki/FAQ#i-want-to-use-the-mouse-to-select-panes-but-the-terminal-to-copy-how).
A permanent default or launcher change remains an operator choice: the earlier
record explicitly chose opt-in repair. No new script is needed for this recurrence.
