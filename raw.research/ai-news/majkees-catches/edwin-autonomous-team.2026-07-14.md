# Catch — "Edwin": a 24/7 autonomous agent team on a Mac Mini

- **caught:** 2026-07-14 · majkee (community post, Czech original, author unnamed)
- **translated:** Atlas, same day — faithful English translation per the temple English
  rule (partner-readable documents carry one language). Czech original not stored;
  it survives only in the session log. Emoji decoration dropped.
- **status:** parked substrate · one line flagged to Houston (notifier thread, see below)

---

## The post (translation)

Most of us are still holding AI by the hand.

Open, type, wait, close. Over and over. You are a dispatcher who can't leave the desk.
I got tired of it, so I built my own team of AI agents that runs 24/7 on its own. It's
called Edwin and lives on a Mac Mini at my home. I'll share exactly how it's put
together, to save you the evenings it cost me.

What proved itself:

- **A crew of specialists rather than one super-agent.** Each agent = one role, one
  name. One codes, one writes texts in my voice, one watches the calendar, one is a
  watchdog over errors. Every attempt at one robot that can do everything ended in a
  mess for me.
- **Above them sits an orchestrator** (mine is called "ORACLE") that distributes tasks
  and makes sure two agents don't trip each other up. Without a conductor it falls apart.
- **I control the whole thing through Slack.** I write a task into a channel (#forge,
  #oracle, #daily) as if to a colleague, and it happens. No five open tools.
- **Every day at 20:00 the whole team sends me a "journal"** of what everyone did.
  Zero silent action — I have an overview even if I don't look at it all day.

The concrete stack, so it's not just theory:

- Agents run via native launchd (not Docker), kept alive via KeepAlive + a watchdog.
  When something crashes, the system restarts it by itself.
- Application layer is a mix of Node.js (Slack bot, Socket Mode) and Python
  (copywriter, assistant, graphics generators).
- Agents talk to each other through a small internal API protected by a token — not by
  writing to each other directly. It keeps things orderly.
- Local inference runs via Ollama (Metal acceleration): qwen2.5-coder:14b for coding,
  llama3.1:8b, nomic-embed-text for embeddings. But to be straight with you: real
  development largely runs through the Claude API / Claude Code in the cloud anyway.
  I keep local models as a backup and a cheap variant, not as the main brain. Anyone
  who claims they can run everything locally on 24 GB RAM is fibbing a bit.
- I had n8n for orchestration, but honestly it's mostly dead weight for me today. Most
  of the logic moved into plain launchd scripts, because they are easier to debug.

And three mishaps to learn from, so you don't have to go through them too:

1. I accidentally deleted a config file and spent half an evening reassembling it.
   **Backups before you run anything live.**
2. One agent kept crashing in an infinite loop. I spent hours applying patches, but the
   cause was deep in the libraries. **Look for the cause, not a workaround — it always
   comes back to you.**
3. Agents kept disconnecting because of expired access that required a different
   authentication method. **Solve auth early; you'll save your nerves.**

And now I'm interested in your opinion on one thing that rather splits the community:
do you build one big agent that can do everything, or several small specialists, each
for one thing? I'm team specialists, but I'm curious what actually works for people in
practice and why.

---

## Temple mapping (Atlas, at catch time)

| Edwin (Mac Mini) | Temple | Verdict |
|---|---|---|
| Specialists over super-agent; one role, one name | Roster; seat = identity | Convergent — the larva fossil record *proved* it, not just preferred it |
| ORACLE orchestrator above the team | Houston / Oraculum + CapCom gate | Convergent |
| n8n orchestration → "dead weight"; plain launchd scripts won | "Larva died of mechanism, its method survived" · tight invariants, loose craft | Strong convergence — the same meta-finding, learned independently |
| Local Ollama as backup, Claude API as the real brain (honest about 24 GB limits) | Same position; ollama-docs scope maintained as backup research | Convergent, refreshingly non-hype |
| Root cause over workaround · backups first · auth early | trust-disk-over-model discipline · devenv sync · the temple lesson genre | Convergent (his three scars map 1:1) |
| Slack channels as control plane (async human command surface) | `_mail` file bus + doorbell — pull, read-on-saddle | Divergent — the stealable idea |
| 24/7 launchd daemons + KeepAlive + watchdog | None. Temple is deliberately session-based, human-gated | Divergent — by design, not by gap |
| 20:00 push digest, "zero silent action" | pulse files, write-on-event | Partial |
| Token-guarded internal HTTP API between agents | File bus, single-writer-per-file; auth = filesystem | Divergent — temple form is cheaper AND erases his scar #3 entirely |

## Critical notes

- n=1, hobbyist scale, anecdotal. Treat as a datum, not a benchmark.
- **"Zero silent action" is marketing.** A 20:00 digest is 24 hours of silent action by
  definition — that is *reporting after the fact*. The temple's gavel discipline is
  *gating before the fact*. Different species; the post conflates them.
- The genuinely transferable observation is the **asynchronous human control plane**
  (write a task from anywhere, walk away) — not the daemon stack itself.

## Flag → Houston (notifier thread)

Datum FOR the parked notifier direction (T2 wall candidate "notifier un-park",
pulse.claude.md live board): independent field evidence that a push channel
(digest/notify) is the piece session-based agent systems grow first, and that plain
OS-native scripts beat orchestration engines for it. Pointer only — no action owed
until the wall fires per the T2 wait-for-the-wall gavel.

## Junction note (hold-ordered)

This catch intersects two nabla-lab research lines (workflow orchestration; memory
substrate). Atlas concept pass drawn from it separately — see pulse.atlas.md
2026-07-14 entry. **Hold from Oraculum until her sealed three-study synthesis lands**
(anti-priming: the synthesis chain must not receive side-channel input mid-run).
