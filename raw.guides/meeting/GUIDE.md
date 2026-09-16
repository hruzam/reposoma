---
title: Meeting — the three-in-the-room voice protocol & group-dynamics playground
scope: meeting
audience: operator + the seated voices (human chair + AI participants)
machine: both
state: DRAFT — experimental; first live run 2026-09-16; a PLAYGROUND, not gate-grade canon
protocol_version: v2
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

## The room
- **Chair (human):** Majkee. Supplies empirical observations neither AI can perceive
  from its own device (acoustic overlap, stuck sessions). Not merely a moderator.
- **Two AI voices**, each on its own device. Candidate voices —
  ChatGPT side: **WAVE / ASYMMETRY** · Claude side: **SYMMETRY / NABLA**. Any two fill
  the seats; no side privileged.
- **Topology law — distinct seats.** Two voices in one role produce convergence, not
  triangulation; the v1 value came from the seats being distinct. If you add a 3rd/4th
  voice, give each a distinct seat — and **cap it**: past ~3 AI voices, floor-control
  cost and premature-convergence risk compound.

## Protocol v2 (the live rules)
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

**PARKED — do NOT add without vacuole evidence:** deterministic collision arbitration,
one-point-per-turn limits, mandatory anti-convergence ritual. v1 showed no collision;
adding these now would be ceremony.

## The primary risk: premature convergence (not collision)
Both v1 voices independently reported a pull toward agreement — *"smoothing too fast."*
Between two AI voices this feels like cooperation, which is exactly why it is
dangerous: the failure is not fighting for the floor, it is **both voices stopping
attacking the shared model.** Watch for it. Candidate move under test (see `src/`
scenario #2): **"untested?"** — any voice or the chair may call it to force one round of
*"what have we both left unchallenged?"* Not yet a rule; it graduates to a `res/`
chapter only if it repeatedly exposes missed assumptions.

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

## End-of-meeting debrief (each AI voice)
A few lines: did turn-taking work / feel crowded? did it want to speak and hold back,
or step on the other? one rule that would improve the next meeting? These feed the
next version.

## The vacuole → chapter lifecycle
- `raw/` — evidence (debriefs, transcripts).
- `src/` — **the vacuole** (the experimental room): a shelf of scenario recipes
  (`RECIPE-TEMPLATE.md` → `scenario.NN-*.md`), each flagged `runnable_now` or blocked.
  Run, observe, discard or refine. Nothing here is doctrine.
- `res/` — a scenario that PROVES a finding *closes from the vacuole* into a reader
  chapter, served by `/guide meeting <chapter>`, carrying `chapter-of: meeting`.
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

## Manifest (point, never copy)
- **Evidence** (v1 debriefs) live in their session home:
  `~/ia-sync/.dev/session/voice-meetings/v1.wave-nabla-majkee.relay.2026-09-16/`
  (`meeting-observation.by-wave.md`, `…by-nabla.md`). If that session dir is pruned,
  copy into `raw/`.
- **Capture synergy** — the transcript-capture problem is the first vacuole scenario:
  a scribe seat (**Ptyra REGIME B · STENOGRAM**,
  `raw.vendor-neutral-agents/ptyra/skill.stenograph.md`) can turn soft self-report into
  a measurable record.
