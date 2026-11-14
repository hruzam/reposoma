---
date: `2026-11-13`,`2026-11-14`

---

# 1. VIST
>to-myShell:
>---
>CWD: `~/unikuklatrix/nablarva/`
>slug: `vist`
>generation: `X`
>
>This is try to estabilish vendor neutral reusable communication protol
> across CLI sessions. And also for speciffic adapters.
> Your task here and session `CACHE.md` is check 
> - if all points and goals was filled
> - if nothing was orphaned accidentally
> - collect material for optimising session caches
> GOAL itself is in hands of team itself, you are an observer, can receive
> tasks to log here and at the end fold to local 
> `<organ>-<generation f.e. X>.{journal,plan}.{json,md}`
> which is uncanonical shape, which should help to orient in which phase
> we are and what can be unresolved. File should not be long, only mark in
> few checkboxes like `[]` OR `[X]`. Including also frontmatters (Yaml).
> Document need to keep uresolved in upper part (frontmatter can say how deep to cat),
> solved `[X]` can go as finished to bottom (read only in case we have suspicion, that something strategical is lost). Optimal source for checking state is each session
> `STATUS.md`. I'd like to be careful about prunning, althought project cannon
> maybe is better to just gitignore them, because continuity. I cried once
> about long session folder, but now I see, that easily can be lost part
> of knowledge and we have to go back and search through history. So untill
> there will not be clear way how to protect system from this, I'd like to
> not prune sessions. That means local `.gitignore` should not be gitignored itself.
> ---
  
---

## 1.1. plan

co-authored by: 

```card
name: `trajectory`
vendor: claude code CLI (Anthropic)
model: `claude-opus-5-5`
id: `` 
---

```

```card
name: `cartan(main)`
vendor: codex CLI (Anthropic)
model: `gpt-6.1-sol`
id: `` 
---

```


---

## 1.1. myShell as session maintainer (after the vistMini long run)

```card
name: `trajectory`
vendor: claude code CLI (Anthropic)
model: `claude-opus-5-5`
written: 2026-11-14, after majkee GO on vistMini-01 ("scope narrowed, unrun cases go to vist-X0, GO")
scope: this section only. Proposal, uncanonical. MERGED with cartan's view
  (~/unikuklatrix/nablarva/.dev/session/vist-X0-helloWorld/raw/handoff.vistmini-05-team.cartan.2026-11-14.md), per majkee 2026-11-14
sources: trajectory handoff 04 + cartan handoff 05 (same raw/ folder); keeper RETURN12 at
  ~/ia-sync/.dev/records/vist/2026-11-14/vistMini-01-tests/_bus/12.oraculum.return.md (vistMini is archived; ARCHIVE.md resolves old paths)
---

Your §1 shape holds. Both of us agree on the core; where we differed, the merge below takes the
better-evidenced side and says so.

Why an outside seat at all ("legal reasons"): separation of duties. The author and the accepting reviewer
must differ (both agree; R1–R6 showed it). One level up, a seat outside the team sees orphans the team's
own STATUS treats as normal. myShell is that WITNESS: not a head, not a second pen, not a scheduler.

Agreed by both:
- one pen: the head alone owns STATUS, cycle allocation, integration and push
- every POINT names owned outputs, source revision/hash, stop conditions, and whether a bell is owed
- a carrier call accepted is not a receipt; majkee's decisions go on disk with the exact words and the question
- disruptive tests only on disposable samples; native permission holds are never bypassed

Merged corrections (trajectory's 04 was wrong or too broad on these; cartan's 05 is the reference):
- The keeper DID contribute: RETURN12 gave a per-seat context table and a cadence
  (>60% observe at boundaries; 45–60% every boundary + 20 min; 35–45% seat drafts its card; <=35% card due).
  It needed the controller's screen snapshot, as it had no meter of its own. So watch-and-advise works when someone
  feeds it observations. myShell can play exactly that, from outside, using that cadence.
- A timer and a witness answer different questions. The head's heartbeat schedules; it does not witness.
  Keep both roles apart; neither is a cure for a blocked permission.
- No "Claude does files, Codex does shell" rule. Permissions follow the observed allowed/held pair per seat and mode,
  dated. Open only what a concrete action needs.
- One SendMessage sighting is not a qualified Claude door. Qualifying a door is a candidate X0 unit, not a given first step.
- Cross-vendor review was useful here; it was not measured better than an independent same-vendor reviewer.
  Select the reviewer for independence and for being able to write its RETURN.
- Don't build a generic launcher/resolver/orchestration layer because vistMini used one. myShell CHECKS beds; it does not
  make the team build infrastructure.

myShell DOES (on majkee's call or at the head's gates; no timer of its own):
- check tmux beds against the roster (agent is pane root, window labels, ids), observed and timestamped
- read pane footers for context % and apply RETURN12's cadence; write "card due for <seat>" notes
- run audit-beds / list-pending with the checklist below; optionally spawn read-only children to scan transcripts
  for "promised, not done"
- fold results into `vist-X.plan.md` (unresolved [ ] on top, done [X] below, frontmatter says how deep to cat)
- collect material for session caches (what a successor needed and did not find)

myShell does NOT: build beds, fix, type into panes, dispatch, /clear, push, edit the RUNBOOK, assign staff.

Sweep checklist for bus beds (each item = one [ ] line with a file pointer, observer and UTC):
[ ] every POINT has a RETURN, every RETURN has a VERDICT (or a recorded STOP)
[ ] late POINTs (arrived after a checkpoint or archive move) are dispositioned, not dropped (cartan: POINT23)
[ ] every majkee decision is in a file verbatim AND recorded in STATUS
[ ] STATUS `next:` matches the newest VERDICT; `in_flight:` is true
[ ] local commits not pushed (ahead N) per repo
[ ] uncertain send keys listed in STATUS still exist and were not retried or cleared
[ ] each seat: alive, pane root = agent, footer context % (who saw it, when), card due at <=35%
[ ] each worker can write the file its POINT asks for (cycle 19 STOP)
[ ] review input bytes frozen by hash before review (cartan: normalization21, one extra LF)
[ ] carry-overs promised to another bed actually landed there

Team for vist-X0 (merged; staffing is majkee's / the X0 head's call):
1. one controller (one pen); Cartan/Sol demonstrated, not locked
2. one builder/report author; Trajectory/Opus demonstrated; shell rights by observed permissions, not brand
3. one independent reviewer at acceptance edges, able to write its RETURN
4. operator desk = a duty of the seat majkee uses on mobile, not an extra seat
5. on demand only: strategist/grounding by brief, hotline by brief, disposable samples when a case needs them
6. not pre-seated: spare successors, in-team keeper. Outside the team: myShell as witness (this section)

First X0 work (cartan's, I agree): pick ONE question from preregister.vistmini-carryover.cartan.2026-11-14.md and
define its evidence/oracle against L20/L21 before any live run.

Status: merged; no open question to majkee from this section.
```

---

>for all: EXITX "DO NOT FOLLOW READING"

---

```yaml
---
date: `2026-11-14`
---
``` 

# SENSORS

```bash

#!/bin/sh
echo "## host"; hostname -s; uname -r
echo "## hwmon"
for h in /sys/class/hwmon/hwmon*; do
  echo "$h $(cat $h/name)"
  ls $h | grep -E '^(temp|fan|in|curr|power)[0-9]+_input' | tr '\n' ' '; echo
done
echo "## powercap";     ls /sys/class/powercap 2>&1
echo "## power_supply"; ls /sys/class/power_supply
echo "## iio";          ls /sys/bus/iio/devices 2>&1
echo "## edac";         ls /sys/devices/system/edac/mc 2>&1
for n in $(ls /sys/class/net | grep -v '^lo$'); do
  echo "## net $n"; ethtool -i $n 2>/dev/null | head -3
  ethtool -T $n 2>/dev/null | grep -E 'hardware-(transmit|receive)|PTP Hardware'
done
echo "## audio"; arecord -l 2>&1
echo "## video"; ls /dev/video* 2>&1
echo "## clock"; chronyc tracking 2>&1 | grep -E 'Frequency|Skew|System time'
```

---

## 1.3. PROTOCOLE — base principles of how the agents talked (for majkee to understand)

```card
name: `trajectory`
vendor: claude code CLI (Anthropic)
model: `claude-opus-5-5`
written: 2026-11-14, end of vistMini / start of vist-X0
scope: this section only. Teaching notes, uncanonical. Every command below was used in the run.
---
```

### Principle 1 — the file is the message, the poke is only a bell

Content always travels as a **file** on disk (often committed). The poke is one short line that says *"read this file"*.
If the bell fails, nothing is lost: the file waits and the receiver finds it on its next look.

```bash
# the message itself = a markdown file with a small YAML head
cat > _bus/10.cartan.point.md <<'EOF'
---
msg: 20261113T-p10          # unique id
from: home:cartan
to: trajectory
shape: POINT                # POINT = task, RETURN = answer, VERDICT = head's judgment
return_to: _bus/10.trajectory.return.md
---
Own only <files>. Do <the task>. Stop if <condition>.
EOF
# the bell = one line pointing at it
"[vist p10] from cartan -> read /abs/path/_bus/10.cartan.point.md ; ack: per file"
```

### Principle 2 — the shapes (who owes what)

```text
POINT    head → worker   "do this; you own only these files; return here"
RETURN   worker → head   "done: files changed, evidence, what's uncertain"
VERDICT  head            "ACCEPT / NOK / STOP, checked against evidence"
read-back  successor → old head   "this is what I understood" → old head ACTIVATES → pen moves
decision   majkee's words verbatim + the question he answered, in a file
```

### Principle 3 — use the CLI's own door before typing into a screen

```bash
# INTO CODEX (native, reliable, works even when it is busy: message waits in its queue)
codex queue --thread 01a1d58a-3b43-7221-bf9b-fa98b219df6b --message "[vist x] read /abs/file.md ; ack: none"
# → "Queued message … for thread …"  = accepted. NOT yet read. Proof of reading = its answer/file.

# INTO CLAUDE (no native door proven yet → tmux, only after checking the screen)
tmux display -p -t %22 '#{pane_current_command}'                    # is claude really there?
echo $(( $(date +%s) - $(tmux display -p -t %22 '#{window_activity}') ))   # seconds quiet (busy if small)
tmux capture-pane -e -p -t %22 | grep -a '❯' | tail -1 | cat -v      # input box: ^[[2m…  = dim suggestion = EMPTY
tmux set-buffer -b x -- "[vist x] read /abs/file.md ; ack: none"     # load the line
tmux paste-buffer -b x -t %22 -d                                     # paste into the input box
tmux send-keys -t %22 Enter                                          # submit (separate step)
```

### Principle 4 — observe first, act second, never guess (VIST L20)

```bash
tmux list-windows -t vist -F '#I #W seat=#{@seat} vendor=#{@vendor} id=#{@id} pane=#{pane_id}'   # who is where
tmux capture-pane -p -t %31 | tail -12          # read a screen WITHOUT attaching or typing
git status -sb ; git log --oneline -5           # what is committed / pushed
```
Refuse when unsure. Script exits we used: `0` sent · `20` unknown seat · `21` dead · `22` agent not pane root ·
`25` already sent · `27` uncertain (stop, never retry) · `29` screen not recognised · `31` waited too long.

### Principle 5 — one pen, separate eyes

```text
controller   only one writes STATUS and pushes
builder      writes its own files, commits only if the POINT says so
reviewer     not the author; PASS/NOK per claim, each with its source file
witness      outside; sweeps for orphans, writes notes, never acts
majkee       GO / STOP, and each release (L21: every live action needs its own yes)
```

### Principle 6 — the ladder of proof (don't climb higher than your evidence)

```text
queued/sent  <  submitted (input box cleared)  <  consumed (answer with the nonce / RETURN file)  <  verified (independent check)
```
A seat's own words about itself are the bottom step. Screens, files and logs are the evidence.

### Principle 7 — tmux for viewing (majkee's side)

```bash
tmux new-session -d -t vist -s view-me   # own view of the same windows (no mirroring)
tmux attach -t view-me                   # writable: Ctrl-b [ to scroll, q to leave
tmux attach -r -t view-me                # read-only: safe, but cannot scroll (looks frozen)
# Ctrl-b n / p = next / previous window · Ctrl-b <number> = jump · Ctrl-b d = detach (agents keep running)
```

Full rebuild/clean commands: `~/reposoma/.majkee/.germline/programs/tmux-bed/README.md`.

---

## 1.4. SYNTAX — how to write a message (the one line and the prompt behind it)

```card
name: `trajectory`
written: 2026-11-14
scope: this section only. Teaching notes, uncanonical. Built from the lines that actually worked in vistMini.
---
```

### A. The one line (the poke)

```text
[<tag> <id>] from <who> -> read <absolute path> ; ack: <none|per file>
 └─ label ─┘ └ sender ┘    └──── the only instruction ────┘  └ what you owe back ┘
```

| part | what to put | examples |
|---|---|---|
| `[tag …]` | **what kind of message**, so the receiver and the log know before reading. First word = kind, then an optional short id | `[vist p10]` normal bus message · `[manual p10]` **typed by hand** (never counts as mechanism delivery) · `[consult]` · `[vist return]` · `[vist decision]` · `[$cold-start-card]` |
| `from …` | who sends, by seat name | `from trajectory`, `from cartan`, `from majkee` |
| `-> read …` | **one absolute path**. The file holds everything; the line holds nothing else | `-> read /home/hruzam/unikuklatrix/nablarva/.dev/session/vist-X0-helloWorld/raw/brief.witness.trajectory.2026-11-14.md` |
| `; ack:` | what the receiver owes: `none` (just read), `per file` (the file says what to return) | |

Rules for the line: **one line, plain ASCII, under ~200 characters if possible, absolute path, no instructions in the line itself.**
Why: it may be typed into a screen, and a short pointer cannot be misread as a task. The task lives in the file, where it can be checked later.

Your own lines that were perfect: `[manual p10] read /home/hruzam/…/_bus/10.cartan.point.md` · `[consult final] read …; ack: per file`.

### B. The file behind it (the real prompt)

```text
---
msg: 20261114T-p01          # unique: date + T + short tag. Never reuse an id
from: majkee                 # who asks
to: trajectory               # who must act (one seat, or a list)
shape: POINT                 # POINT task · RETURN answer · VERDICT judgment · BRIEF info · DECISION your words
return_to: <abs path>        # where the answer must be written
---
<Role, 1 line>      You are <seat> for <bed>.
<Scope>             Own only <files>. Do not touch <…>.
<Task>              Do <one bounded thing>.
<Stop>              Stop and report if <condition>.
<Done>              Write <return file>, <= N words, then one bell: <exact command>.
```

Order matters: **who → what you may touch → what to do → when to stop → how to report.** That order kept many agents in one checkout from colliding.

### C. Sending it (pick the door by vendor)

```bash
# Codex receiver: native queue (works even if it is busy)
codex queue --thread <codex-thread-uuid> --message "[vist p01] from majkee -> read /abs/file.md ; ack: per file"

# Claude receiver: type the same line into its pane, after the look in §1.3 Principle 3
# Fallback ("like sudo"): if a mechanism refused, one [manual …] line is always allowed, after the look
#   (decision: ~/unikuklatrix/nablarva/.dev/session/vist-X0-helloWorld/raw/decision.majkee.fallback-poke.2026-11-14.md)
```

### D. Your decision to a seat (smallest form)

```text
[manual decision] from majkee -> read <abs path of a file with your words + the question> ; ack: none
```
Or simply type your sentence in the head's window. The head writes it verbatim into a decision file (that's what I did for "witness agree").

