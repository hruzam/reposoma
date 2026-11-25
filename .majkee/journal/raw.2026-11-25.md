---
date: `2026-11-25`
---


> cartan, pls after extract delete this file


trajectory: `4f923bb7-ee15-447b-8954-408e16955530`

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

tmux new-session -d -s seswin -n lead -c ~/unikuklatrix/nablarva
tmux new-window  -d -t seswin: -n audit -c ~/unikuklatrix/nablarva
tmux new-window  -d -t helloWorld: -n supervisorCli -c ~/unikuklatrix/nablarva

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