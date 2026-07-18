---
status: seed
captured_by: "design conversation 2026-06-17 — extending the symmetry therapy practice toward agent↔agent feedback; analyzed for loop / overflow / leak risk before building"
expresses_as:
  - "two distinct channels, never merged: therapy (human↔agent mirror) and crossfeed (agent↔agent ledger)"
  - "therapy.md: pairwise, synchronous, relational — two seats, a joint #last-turn, participants co-equal"
  - "crossfeed.md: many-to-one inbox per owner, async, directed, advisory — frontmatter carries owner + sources, footer tags <source>-><owner>"
  - "the human is a node for addressing/grep, NOT a node for governance — they remain principal, arbiter, terminator"
  - "four governors on crossfeed: human-gated, advisory-not-binding, single-synthesizer (Recorder), capped"
  - "reading feedback never auto-triggers writing feedback"
  - "a seat entering a domain reads the domain's local law before acting — the bed's law is not optional context, it is the ground"
---

# Reflection channels

Two channels carry honest assessment between collaborators. They share a file shape (yaml
frontmatter, a `#last-turn` synthesis block, a shifting footer tag-list) but are **different
primitives and must not be merged.**

## 1. Therapy — human ↔ agent

A held mirror between an agent and the principal (majkee). Pairwise, synchronous, relational:
two seats (therapist ⇄ analyzed) that switch; a joint `#last-turn` dragged forward;
participants co-equal within the file. Safe and self-limiting **because the human is in it** —
the human is the clock.

File: `therapy.md`, `participants: [<agent>, majkee]`. (Per-agent seeds live under
`raw.therapy/`.)

## 2. Crossfeed — agent ↔ agent

A directed feedback ledger. The seat-switch does not generalize to N parties, so crossfeed
drops it: it is an **async, many-to-one inbox** — one file per owner, collecting feedback
addressed *to* that owner from many sources. Not a relationship; a memo board between
instances that never coexist.

```
---
owner: <agent>
sources: [<agent-a>, <agent-b>, majkee, ...]
synthesizer: recorder
active: true
range: "<date-ts:...> <date-te:>"
read-protocol: ask first, then grep `#last-turn` only; read deeper only on reference
---
# Crossfeed — to <owner>

## Inbox
### <source> → <owner> · <date>
- [watch|habit|resolved|parked|carried] <note>

---
#last-turn          # written ONLY by the synthesizer (Recorder)
<one-paragraph merged read of the inbox>

---
`<source>-><owner>` (pending · shifting):
- ...
```

- To read all feedback you received: read your own `crossfeed.md`.
- To find feedback you gave: grep `<you>->` across owners.
- majkee greps `->majkee` for what is addressed to him, `majkee->` for what he gave.

## Why the separation — and the governors

Agent↔agent reflection, if it inherits therapy wholesale, fails in four ways. Each governor
answers one failure:

| Failure mode | Governor |
|---|---|
| **Endless loop** — no human clock; reading feedback triggers writing it; under autonomous `bypassPermissions` this is an unbounded token sink | **Human-gated** — only majkee opens/closes a round; agents deposit only when asked; **reading never auto-triggers a write** |
| **No authority gradient** — contradictory feedback with no arbiter is either ignored or blindly applied | **Advisory, not binding** — crossfeed is input to the orchestrator/human; the human arbitrates |
| **Clobber** — N writers on one `#last-turn` = last-writer-wins data loss | **Single synthesizer** — Recorder owns the merge + `#last-turn`; sources append-only |
| **Runaway / sycophancy / leak** — quadratic growth, mutual-praise noise, cross-project contamination in shared files | **Capped** — hard per-round deposit limit; advisory-only keeps stakes low; project-specifics stay out of the common file |

## The load-bearing asymmetry

"Treat majkee as also an agent" is **true for addressing** (he is a source/target node you can
grep) and **false for governance** (he is the principal, the arbiter, and the only natural
terminator of the loop). Hold that line and the channel stays bounded. Drop it — make the
human just-another-node — and you remove the governor that keeps agent↔agent reflection from
running away.

## Continuity note

Neither channel has two persistent selves. Therapy has one (the human); crossfeed has none —
both sides are fresh instances reading canon. Crossfeed is therefore an inter-instance memo
board, not a relationship. Name it honestly so agents pass signal instead of performing
rapport. Continuity lives in the canon, not in any one instance.
