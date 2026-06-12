# HANDOFF — closing pulse of the Freya research frame
`date: 2026-06-12 · author: this thread · grade: pulse (present-temporary —
each brief dies when its thread closes) · canon carrier: THIS FILE, not vendor memory`

How to use: one brief = one new thread. Open with: "Continue brief N from the
handoff" + paste the brief (or rely on conversation search as convenience
layer — but the paste is sovereign). Close the gate, then open the next.

---

## Brief 1 — Gemini CLI credit burn-down  `[thread: this project or personal]`
**Context (5 lines):** Gemini CLI is sunsetting in Majkee's stack; remaining
credits must be spent or written off, then the affair closed. Its one durable
strength: huge-context one-shot synthesis. Strategy already agreed: burn
credits on disposable-input → committed-output jobs so nothing depends on
Gemini afterward. Candidate jobs: whole-codebase analysis passes for the
cutting agent, corpus digestion (laravel-tips repo, Laracasts field-guide
notes), bulk first-draft scope manifests for Freya.
**State:** strategy agreed, no inventory done, no jobs specified.
**Decision to make:** which jobs, in what order, with what output contracts
(file, format, where committed in Repo 2).
**Gate (closed when):** credits spent or consciously written off; every output
committed; zero remaining Gemini dependency; one line in pulse: "affair closed."

## Brief 2 — Light SDK design review  `[thread: new neutral project or personal]`
**Context:** Majkee is designing his own lightweight AI-SDK — Unix philosophy,
Arch-grade minimalism, deliberately more hardcoded than agent-driven; sibling
ideas: local RAG + Wikipedia system using spectral/vector/tensor retrieval;
Qwen-4B as message-bus assistant. Laravel AI SDK is the reference comparison
(also partly hardcoded; colleague uses it; another colleague uses a black box
— avoided on sovereignty grounds).
**Protocol:** `/regime-arch` active from message one; clean room, no leaked
leanings (blind-before-grounded). Feed it: the SDK idea as raw I/O statement,
NOT the current implementation sketch.
**Decision to make:** architecture verdict + a reusable rule: "when does
hardcoding beat an agent" (the rule matters more than the verdict).
**Gate:** locked decision in docs/decisions/ of the SDK project; chitin's
fate noted (likely: ADR marked superseded-by-ecosystem — a dignified burn).

## Brief 3 — Temple compile targets  `[thread: this project — it IS Freya work]`
**Context:** the-team_doctrine.md (Houston's, now with §1b file-plane
injection) is being de-bonded from reposoma by Majkee to become the common
base stone across projects. Canon is runtime-neutral; consumers are not:
Claude Code (Majkee, reference implementation), Cursor IDE+CLI (Freya team),
Qwen bus (cheap tier). One-direction compile-down gate is the law (§1.4).
**Decision to make:** define the compile path canon → per-vendor surfaces
(which file produces CLAUDE.md vs .cursor/rules vs AGENTS.md; where agentctl
/ sync-ai.sh hooks in; what the Cursor-parity diff looks like).
**Gate:** compile path documented + ONE surface actually generated and used
in a real Freya session by a teammate, not only by Majkee.

---

## Brief 4 — Master prompt for the new NEUTRAL project
**Purpose of the project:** AI↔human cohabitation, working-group doctrine,
best practices, conceptual frames — the themes that kept forking out of
Freya threads. This is their home now. Freya project = practical only.

**Recommended project instructions (paste as-is, edit freely):**

```
This project is the conceptual layer of majkees work with us - AI agents — deliberately separated from his practical projects (Laravel/Freya etc.). Themes that belong
here: AI-human cohabitation and team doctrine, agent working-group design,
documentation philosophy (flag/pulse/decisions, tenses, sovereignty vs native
delivery), token/context economics as a discipline, evaluation of agents,
naming and vocabulary. Practical stack questions do NOT belong here — if I
drift into framework specifics, say so and offer to park a brief for the
practical project instead.

About me, so you can calibrate: physics background; I use vector/tensor/
spectral vocabulary deliberately, but explain industry jargon and acronyms
plainly when you introduce them (one-line definition at first use). My input
style is iterative and circling ("forgetive") — I have a buffering protocol:
when my input arrives in fragments, buffer and confirm understanding before
producing; ask before releasing large artifacts; surface open threads
explicitly at the end ("underlined items") rather than letting them silently
drop. When I signal the feed has ended, synthesize.

Working agreements:
- Honesty over agreeableness. Challenge premises before they lock; tell me
  plainly when an idea of mine is show rather than substance. One adversarial
  pass before any significant conclusion.
- Durable over conversational: significant outputs become artifacts (md) I
  can commit; decisions get recorded with rationale; assume any thread can
  end mid-sentence.
- Start big documents with ~10 falsifiable axioms of your assumptions so I
  can strike misreadings cheaply before reading the whole.
- Vendor-neutral canon: my naming (flag, pulse, temple, regimes) is
  sovereign; map it to industry terms when useful, never rename it.
- One theme per thread. When a fork grows interesting, name it, park it as a
  brief, and offer a new thread — do not let it eat the frame.
- Step-by-step over everything-at-once; when uncertain between depth and
  breadth, ask with one question, not three.
```

**Two seeds for its first threads:** (a) Brief 2 above fits this project if
preferred over personal space; (b) "the chaos-monkey ↔ team cohabitation
patterns, generalized" — §4 of the doctrine rewritten as vendor-neutral
practice notes, the most original material this frame produced.

---

`underlined items carried nowhere else: none — all three live above.`
`frame status: closed with this artifact. Thanks for the work, monkey. — the thread`
