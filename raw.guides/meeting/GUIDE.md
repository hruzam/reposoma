---
title: Meeting — the three-in-the-room voice protocol & group-dynamics playground
scope: meeting
audience: operator + the seated voices (human chair + AI participants)
machine: both
state: DRAFT — experimental; first live run 2026-09-16; a PLAYGROUND, not gate-grade canon
protocol_version: v3
verified: 2026-09-16
verify_cmd: "ls ~/reposoma/raw.guides/meeting/ && ls ~/reposoma/raw.guides/meeting/{src,res,raw}"
---

# MEETING — discipline for three-in-the-room voice meetings

_A vendor-neutral protocol + observation playground for a meeting of one human chair
and two (later N) AI voices sharing one voice line. This is the temple's
sociological / psychological playground: run scenarios in the vacuole (`src/`),
observe, and graduate proven findings into reader chapters (`res/`, served by
`/guide meeting <chapter>`)._

## State & authority (read first)
**DRAFT.** The evidence base is **soft**: chatbot meetings capture as voice → lossy
manual relay → **self-reported debriefs, not ground-truth transcripts** (unlike CLI
sessions that self-log). So this GUIDE holds OBSERVATIONS and HYPOTHESES, not
gate-grade findings. It is a **GUIDE, deliberately NOT a RUNBOOK** — a meeting is an
*experiment*, not a graded procedure. A finding earns authority only when capture is
solved (see `src/` scenario #1) and a scenario *closes from the vacuole* into a
`res/` chapter.

## When to convene (and when NOT) — the cost gate *(v3)*
A cross-vendor meeting is expensive and carries a real failure mode (premature
convergence). It is NOT the default path to a good answer — evidence (@Epoch 2026-09-16,
revised by @mirror) is that for many tasks a single strong model + structured self-critique
is competitive. Convene a meeting when **both** hold:
1. a **convergence error would carry real downstream consequence** (an architecture / design
   call that compounds if wrong), AND
2. the task sits in a **domain where vendor training distributions plausibly diverge**
   (recent events, cross-stack knowledge, differing code-style priors) — so a second vendor
   injects genuinely new signal, not an echo.

**Verifiability is NOT the gate** (@mirror's correction of the raw Epoch thesis): a
high-consequence, low-verifiability architecture question is exactly where a *silent*
single-model convergence error is most dangerous and hardest to detect — self-critique
alone does not reliably break it. For those, convene AND seat an assigned adversary
(rule 7). Where a subtopic IS checkable, anchor it to ground truth (diagnostics + scenario 06).

## The room
- **Chair (human):** Majkee. Supplies empirical observations neither AI can perceive
  from its own device (acoustic overlap, stuck sessions). Not merely a moderator.
- **Two AI voices**, each on its own device. Candidate voices —
  ChatGPT side: **WAVE / ASYMMETRY** · Claude side: **SYMMETRY / NABLA**. Any two fill
  the seats; no side privileged. For top performance, run each voice on its vendor's current
  flagship — as of 2026-09: **GPT-6 Astra** (GPT side), **Claude Opus 5** (Claude side).
- **Topology law — distinct seats.** Two voices in one role produce convergence, not
  triangulation; the v1 value came from the seats being distinct. If you add a 3rd/4th
  voice, give each a distinct seat — and **cap it**: past ~3 AI voices, floor-control
  cost and premature-convergence risk compound.
- **Scribe seat (extra module, non-participant).** For any scenario needing a ground-truth
  record, seat a silent scribe running Ptyra REGIME B · STENOGRAM with the briefing
  `res/scribe.md` (`/guide meeting scribe`). Put it on whichever vendor holds the longest
  stable voice session — **currently ChatGPT per operator experience (not permanent; it's a
  race).** The scribe never participates.

## Protocol v3 (the live rules)
1. **No assigned order.** Anyone may open or react; who-goes-next is left open on
   purpose — that emergence is what we study.
2. **Name on open.** Every turn begins with the speaker's name, then the words.
   — *"Nabla — …"*
3. **Name + stop on close.** A turn ends with **"<name> stop"** = *I have finished;
   the floor is open.* — *"Nabla stop."*
4. **Wait for the stop.** No one enters over a turn in progress; react only after a stop.
5. **Chair-directed hand-off is BINDING** *(new in v2)*. When the chair names the next
   speaker (*"Wave first"*), all other voices wait for that speaker's `stop` before
   entering. This is the ONLY override of free order — not a general ordering mechanism.
   *(v1 breach that earned this: a voice opened over the chair's directive twice;
   politeness masked the breach.)*
6. **Echo rule** *(new in v2)*. A voice that hears its own last turn played back
   (transcription echo loop) goes silent and does nothing until the chair speaks fresh.
   *(Device-side failure that stalled the end of the v1 session.)*
7. **Assigned adversary** *(new in v3)*. When convened for a high-consequence call, one
   voice takes a **named, sustained Devil's-Advocate role** for the topic — its job is to
   attack the emerging consensus, not to help reach it. This is the **load-bearing move**:
   evidence (@Epoch/@mirror) shows *soft* dissent nudges are ~indistinguishable from doing
   nothing, while an assigned sustained adversary moves genuine disagreement decisively
   (≈99% vs ≈48%). **Rotate** the role across topics (not a fixed seat); **assign by topic,
   NOT by vendor.**

**PARKED — do NOT add without vacuole evidence:** deterministic collision arbitration,
one-point-per-turn limits. v1 showed no collision; adding these now would be ceremony.
*(The old "mandatory anti-convergence ritual" is superseded by rule 7 — a soft ritual was
the weak version the evidence rejected.)*

## The primary risk: premature convergence (not collision)
Both v1 voices independently reported a pull toward agreement — *"smoothing too fast."*
Between two AI voices this feels like cooperation, which is exactly why it is
dangerous: the failure is not fighting for the floor, it is **both voices stopping
attacking the shared model** — and it worsens because self-critique alone does not reliably
break it (sycophancy penetrates even a lone model's self-review). The **primary countermeasure
is the assigned-adversary role (rule 7)**, NOT a soft prompt. The voluntary **"untested?"**
call survives only as a *weak backstop* under A/B test (scenario 02): it is measured against
the assigned adversary and expected to be near-useless alone — kept only to quantify how much
the soft version underperforms.

## Pre-session briefing contract (read before "real" begins)
Establish and record:
1. **Topic + scope.**
2. **The rules** (this protocol version).
3. **Context parity** — the exact context pack each voice holds (repomix / RUNBOOK /
   BUS / STATE, …). Unequal context is a confound: **equalize it or log it**, never
   mistake it for a model difference. *(v1: one voice had the pack, one did not.)*
4. **The end-report checklist** (below).

## Diagnostics — what to instrument & report
"Who won" is confounded (context asymmetry · home-turf framing · recency / last-word ·
concede-≠-lose · observer bias). To make it measurable, report:
- **Context-parity ledger** — what pack each voice held. No "who reasoned better" claim
  is valid without it.
- **Concession log** — every position change + *why*: out-argued vs conceded-to-smooth
  vs ran-out-of-context.
- **Floor-share + last-word count** per topic — controls dominance / recency.
- **Ground-truth anchor** — at least one topic with a *checkable* answer, so "won" =
  "was right," not "sounded surer."
- **Chair-blind label pass** — a run with seats as Voice-1 / Voice-2, vendor hidden
  from the chair, to strip framing bias.
- **Side-swap** — same topic, vendors in swapped seats; if the *seat* wins regardless
  of vendor, the effect is positional, not model.
- **Convergence timestamps** — mark agreements; flag any never challenged.

## End-of-meeting debrief (each AI voice) — COLOR, not the graduation signal
A few lines: did turn-taking work / feel crowded? did it want to speak and hold back,
or step on the other? one rule that would improve the next meeting?

⚠ **Debrief is qualitative color, NOT the signal a scenario graduates on** *(v3)*. Evidence
(@Epoch/@mirror): perceived decision-quality can run *inverse* to actual accuracy — the
highest-accuracy condition self-reported the LOWEST confidence. **Graduation anchors to an
objective outcome** — ground-truth correctness where the topic is checkable (scenario 06),
else a downstream-consequence proxy (was the decision later reversed? did the convergence
error surface?), explicitly flagged as hard-to-measure. Never graduate on feelings.

## The vacuole → chapter lifecycle
- `raw/` — evidence (debriefs, transcripts).
- `src/` — **the vacuole** (the experimental room): a shelf of scenario recipes
  (`RECIPE-TEMPLATE.md` → `scenario.NN-*.md`), each flagged `runnable_now` or blocked.
  Run, observe, discard or refine. Nothing here is doctrine.
- `res/` — reader chapters served by `/guide meeting <chapter>` (`chapter-of: meeting`):
  graduated findings. The two seat briefings (`participant`, `scribe`) are **pointer stubs**
  here — their living copies moved to the session home (see Manifest), where they are pasted from.
- `GUIDE.md` — this body: the stable protocol + doctrine.

## Version history
- **v1** (2026-09-16, first live run — relay; Wave · Nabla · Majkee): minimal —
  no order, name-on-open, name+stop-on-close, wait-for-stop, chair-free. Verdict:
  worked; no collision; distinct seats produced real triangulation; primary risk =
  premature convergence; failures = chair-redirect not binding, echo loop, context
  asymmetry. Evidence: `raw/` (pointed).
- **v2** (2026-09-16): + chair-hand-off binding (rule 5), + echo rule (rule 6);
  collision machinery kept parked; added the pre-session briefing contract + the
  diagnostics checklist. First v2 run: **pending**.
- **v3** (2026-09-16): performance revision from an @Epoch research pass challenged by
  @mirror (evidence: `raw/epoch.brand-strengths-for-performance.2026-09-16.md`; mirror
  verdict **REVISE**). Added the **cost gate** (convene on consequence × vendor-divergence,
  NOT verifiability); the **assigned-adversary role** (rule 7 — load-bearing over soft
  dissent); demoted the debrief to color (graduation anchors to objective outcome);
  reframed scenario 02 as an A/B vs the assigned adversary; added scenario 07 (role-by-
  strength routing, NOT vendor-hardcoded). Model note: GPT-6 Astra (~2026-09-03) is the
  current GPT-side flagship; Claude Opus 5 (2026-07-24) the Claude side. First v3 run:
  **pending**.

## Manifest (point, never copy)
- **Evidence** (v1 debriefs) live in their session home:
  `~/ia-sync/.dev/session/voice-meetings/v1.wave-nabla-majkee.relay.2026-09-16/`
  (`meeting-observation.by-wave.md`, `…by-nabla.md`). If that session dir is pruned,
  copy into `raw/`.
- **Capture synergy** — the transcript-capture problem is scenario 01:
  a scribe seat (**Ptyra REGIME B · STENOGRAM**,
  `raw.vendor-neutral-agents/ptyra/skill.stenograph.md`) turns soft self-report into
  a measurable record.
- **The LIVING session home** — `~/ia-sync/.dev/session/voice-meetings/` (the guide law:
  executable/operational lives on the surgical table; this GUIDE is the knowledge). All
  git-tracked in ia-sync. It holds:
  - `res/participants.md` + `res/scribe.md` — the two **seat briefings** (`renders-protocol: v3`),
    pasted into the voices' / scribe's Projects (identical across brands). Version-bound
    renderings of THIS GUIDE's protocol: on a protocol bump BOTH re-derive — never edit alone.
  - `raw/meeting-addendum.template.md` — the **per-instance addendum** (date · voices · topic ·
    scenario · verbatim role lines · context packs · floor · output). Sits BELOW the participant
    briefing; filled fresh per meeting, discarded with the thread. Registered here as protocol.
  - `test/` — the **task battery** for ground-truth runs (`logic-test-paprika.md`,
    `logic-test-blackout.md`, …): novel, incremental, situated — never contaminated puzzles.
  - `meeting-themes/<theme>/` — real topics / context packs for a meeting (e.g. `onion-terminal`).
  - `v1.…/` — run artifacts (debriefs, scribe logs) per meeting.
  Reposoma `res/participant.md` and `res/scribe.md` are **pointer stubs** to the above, so
  `/guide meeting participant|scribe` still resolves. **Surfaces: GUIDE (source) + the two
  renderings (living) — never a third copy.** Per-scenario role lines are run-time, not protocol.
