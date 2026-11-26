---
date: `2026-11-25`
---


> cartan, pls after extract delete this file


trajectory: `4f923bb7-ee15-447b-8954-408e16955530`

to `atlas-ui` : `/home/hruzam/reposoma/_cold-start/card/CS.a1-006-supervisor.2026-11-26.md`

---

tmux new-session -t helloWorld \; select-window -t :exec


`tmux attach-session -t helloWorld \; select-window -t :eSharp`
tmux select-window -t helloWorld:eSharp
`tmux attach-session -t helloWorld \; select-window -t :seniorDev`
`tmux attach-session -t helloWorld \; select-window -t :sample-codex`
`tmux attach-session -t helloWorld \; select-window -t :sample-codex`
`tmux attach-session -t helloWorld \; select-window -t :sample-codex`
`tmux attach-session -t helloWorld \; select-window -t :sample-codex`
`tmux attach-session -t helloWorld \; select-window -t :sample-codex`

---


```bash
tmux list-windows -t sandbox -F '#{session_id} | #{window_index} #{window_name} #{window_id} | #{pane_id}'
$46 | 0 codex-sample @82 | %84
$46 | 1 claude-sample @86 | %88
$46 | 2 session @87 | %89
$46 | 3 terminal @88 | %90
```

The original test session is now `germline` on the default tmux server (`-L default`).
It keeps its existing windows and pane IDs.

```bash
tmux -L default list-windows -t '=germline' -F '#{session_id} | #{window_index} #{window_name} #{window_id} | #{pane_id}'
```

```text
$46 | 0 codex-sample @82 | %84
$46 | 1 claude-sample @86 | %88
$46 | 2 atlas-ui @87 | %89
$46 | 3 cartan @88 | %90
```


tmux new-session -t germline \; select-window -t :atlas-ui
tmux new-session -t germline \; select-window -t :cartan

---

```bash
tmux list-windows -t helloWorld -F '#{session_id} | #{window_index} #{window_name} #{window_id} | #{pane_id}'
$36 | 0 eSharp @75 | %77
$36 | 1 supervisor-relay @57 | %59
$36 | 2 seniorDev @58 | %60
$36 | 3 myShell @59 | %61
$36 | 4 auditor @64 | %66
$36 | 5 exec @66 | %68
$36 | 6 lead @68 | %70
$36 | 7 spare-codex @100 | %102
$36 | 8 supervisorCli @73 | %75
$36 | 9 spare-claude @76 | %78
```

---

HELP WINDOW SESSION

tmux new-session -t seswin \; select-window -t :lead
tmux new-session -t seswin \; select-window -t :audit


---

###### TRAJECTORY `eSharp`

```prompt-me

Side-quest
- My first collection and seniorDev's opposing read are in eSharp/side-quest.2026-11-26.md.
- myShell is not asked yet: her input row holds the text "yes, copy it to office via controller", so I typed nothing. The request is ready in eSharp/request.myShell.side-quest.2026-11-26.md
```

Everything is recorded in eSharp.decisions.majkee.2026-11-22.md


---

tmux -L sandbox-server new-session -d -s sandbox-terwor -n terminal -c ~/unikuklatrix/nablarva

tmux -L sandbox-server kill-window -t '=sandbox:terminal'



###### TRAJECTORY `eSharp` END

---




New location: .dev/session/germline-A1-vi-agents/raw/007-researcher/EPOCH.role-and-inputs.2026-11-25.md. Delta created the
    007-researcher folder, which didn't exist.
  - Old file: The file under 006-supervisor is gone. That folder still holds only its original files: BRIEF.md,
    HANDOFF.cartan.relay-controller.2026-11-24.md and HANDOFF.exec.md. I hadn't seen the other two.
  - Header: The title now says the file is written against the supervisor brief. One line after the frontmatter says that "BRIEF"
    means ../006-supervisor/BRIEF.md.                                                       
  - Commit: The commit staged only that file and added no trailers. The push was a plain push, as main wasn't behind upstream.

---
the usual tmux server — every seat lives here
  session helloWorld     shared seats, and the relay party as it is today
    engineer             me (pane %58)
    exec · myShell       the decision desk · the second eye
    supervisorCli        NEW — one pane, Codex
    lead · auditor · supervisor-relay · seniorDev · sample-codex-2    relay party, untouched
  session seswin         NEW — group 1
    lead                 one pane, Claude (flight)      nick lead.seswin
    audit                one pane, Codex (Oraculum)     nick audit.seswin
  session terwor         LATER — group 2: lead (Codex), audit (Claude)
server tmux -L session-window       group 1's sandbox — tests only; do not create it now
server tmux -L terminal-workspace   group 2's sandbox — later

To create the new parts:
tmux new-window  -d -t helloWorld: -n supervisorCli -c ~/unikuklatrix/nablarva
tmux new-session -d -s terwor -n lead -c ~/unikuklatrix/nablarva
tmux new-window  -d -t terwor: -n audit -c ~/unikuklatrix/nablarva
tmux list-windows -t helloWorld -F '#{session_id} | #{window_index} #{window_name} #{window_id} | #{pane_id}'



Then open your views the way you open helloWorld-37…43 today, and start the three CLIs as you started today's seats: the auditor with codex --profile oraculum, the supervisor with plain codex, the lead like today's lead.

Four rules
1. One seat is one window with one pane; no split in a seat's window.
2. No dot in a window name. tmux reads a dot in a target as the pane separator: a read-only query for helloWorld:lead.zzz answered with the relay lead's pane %70. The nicks keep their dot (lead.seswin); the windows are lead and audit inside seswin.
3. Never a seat on a -L server. The sandbox server is made by the group's prepared script, after your yes on the release.
4. Names stay once a seat has started.

Why a session per group, not everything in helloWorld
- It is your own pattern: vist, traj-home and helloWorld are each one party.
- A tmux status row belongs to a session, so a group can later carry its own row without a change to helloWorld.
- Your "shared terminal as a session property" then has a session to belong to.
- Pointer lines are not affected: a pane id is valid in every session of one server.

This replaces my wording in sheet 2, B3 ("all seats in helloWorld"). I do not touch the sheet while you are writing in it, so read B3 as this tree.

Your points 1–6 are recorded verbatim in eSharp.decisions.majkee.2026-11-22.md, section 10, with the tree.
- 1: I take stridulariium as stridularium. The open bed architecture-X1-bookkeeping has a gate line that retires "stridularium" as a cultural name, which may collide. I have not spawned houston; I will when a line needs the name codified.
- 2: Noted — the relay bed stays open and you retire it yourself.
- 4, 5: You tell the relay group. I read "5. in 4." as the same for the exec desk, so I send it nothing until you say.
- 6: Group 1's RUNBOOK now asks the packet to keep spare places and to name where the shared-terminal controls (connect, attach, release, settings) would sit. .dev/_backlog/skin-remote-controll/ and the instarmux line of docs/ARCHITECTURE.md are added as inputs.