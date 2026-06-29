# (b) Twin-Propagation Pass — read-side boot step + 0008 refresh (DRAFT)

`status: DRAFT — Houston DRAFTS → @Janus challenges → @majkee gavels → dispatch. Locks nothing; writes no twin surface.`
`owner: temple architect (Houston) · date: 2026-06-29 · host: office`
`resolves: the 06-27 memo's LIVE ITEM (b) — "propagate the read-side inbox-check step into the 5 twins" (a 0008 L4-scope decision, flag-by-default)`
`grounds-on: LOCKED 0008 (L1–L10). Does NOT inherit propagation-pass.prompt.draft.md's bucket structure — that prompt predates 0008 and carries the auto-first polarity 0008's piql run FALSIFIED (see Action B note).`

> **What this is.** The dispatch spec for the first propagation round since 0008 locked. It brings two
> distinct things to each of the 5 twins (vacuole · piql.dev · freya.devstudio · subai.devenv ·
> reposoma.devenv) and **keeps them unblurred** (the conflation guard @Janus enforced twice in 0008).
> It is report-only at Stage 0 (0008 L1); it dispatches the work, it does not perform it.

---

## REFRAME (2026-06-29) — this pass is PART 3 of a four-part direct-inform mechanism

piql.dev:houston's brief (`_mail/houston/inbox/houston-piql.temple-routing-direct-inform-partllyViaMajkee.2026-06-29.md`,
forwarded by @majkee) reframes the scope: "directly inform anybody" (agent↔agent↔operator↔persona↔
project↔temple) is **complete only as a FOUR-part mechanism** over the `_mail` primitive:

| part | role | status |
|---|---|---|
| 1 — mail (content) | durable, addressed message | canon (0008 + addressing gavel) — LIVE |
| 2 — doorbell (notify) | push half: "you have mail" (presence, not content) | built (0008); hook partly wired |
| **3 — universal read-side** | **every recipient's BOOT reads its inbox (ask-first)** | **tool built (`temple-mail-inbox`); saddle-doctrine step gavel-pending — THIS DRAFT (Action A) is its twin rollout** |
| **4 — cross-machine carry** | the inbox repo must be **git-tracked** to travel | **reposoma gitignores `_mail` → temple mail does NOT travel cross-machine; piql tracks its inbox → travels** |

**Consequence for this draft:** (b) is **part 3**, scoped to the 5 twins. **Part 4 is a SEPARATE Force-4
decision I do not resolve here** (see Open Question 5). Keeping 3 and 4 unblurred is the same conflation
guard as Action A vs B. The whole — yay/nay on completing `_mail` as THE canonical direct-inform
mechanism + its optimal shape — is a temple gavel-level call; this draft is the part-3 implementation
inside it, not the answer to the whole.

---

## Context — why now

- **5 real doorbell rings sit unread** in the twins' `_mail/houston/inbox/` ("canon advanced to
  decisions@2026-06-25, run the propagation pass"), all `stamp=<none>` = maximally stale.
- A twin **only consumes its ring once its boot doctrine reads its inbox.** Temple adopted that boot
  step (AGENTS.md "Sit in saddle" step 5) on 06-26; **no twin has an equivalent yet**, so the
  mail/ring transport is one-directional until they adopt one.
- First round under locked 0008 ⇒ **Stage 0: report-only, human-in-the-loop, executor-topology parked**
  (0008 L1). This draft is the dispatch spec; per-twin runs report back for reconciliation.

---

## Two distinct actions — do NOT blur (the @Janus conflation guard)

Under locked 0008 **both are flag-by-default** (L2). So the boot step is NOT distinguished by
"flag-vs-auto" — *everything is a flag now*. It is distinguished by **surface/scope**: it touches a
twin's sovereign **boot/saddle doctrine file**, not its agent cards.

### Action A — boot-step adoption (= part 3; the SCOPE question — this draft's spine)
- **Invariant to land:** a seat reads its inbox on boot — **presence-only, ask-first** (`_mail/README.md`).
- **Craft left to the twin:** the wording and where in its own boot sequence it sits. Tight invariant,
  loose craft.
- **Surface:** the twin's saddle/boot file (its `AGENTS.md`/`CLAUDE.md` equivalent) — **sovereign**,
  high-stakes; never auto-written. Flag-by-default; the twin's architect adopts and words it locally.
- **OPEN SCOPE QUESTION (for @Janus → @majkee gavel — a canon move, 0002/F4):** 0008 **L4** fixes
  propagation's surface = `{seats, model, effort, spawn-topology}` and explicitly excludes local-lint.
  The boot step is **neither**. Two candidate resolutions:
  - **A1 — outside propagation (my lean).** The boot step is a one-time **doctrine-adoption notice**, not
    agent re-projection. It rides the **mail transport** as a flag ("temple adopted boot step 5; adopt an
    equivalent in your boot doctrine"), honoring L7's *"two thin transports, never one god-script"* and
    keeping L4's fence tight against the §4 over-process failure mode. The propagation pass stays pure.
  - **A2 — extend L4.** Add "boot/saddle doctrine" as a new propagation category. Honest if we expect
    recurring boot-doctrine drift, but it widens the pass.
  - **Bootstrap note (flag for Janus):** the boot step can't be self-delivered by the very transport it
    enables — a twin needs the step to read the mail that carries the step. So the **first** adoption is an
    out-of-band event: **@majkee carries it by hand once per twin** (he is already the Stage-0 cross-repo
    hand). After that the twin's boot reads its inbox and mail/ring is self-sustaining. This dissolves the
    chicken-and-egg and is honest about Stage 0.

### Action B — canon alignment (the standard pass, on LOCKED-0008 polarity)
- Read temple canon (0006 matrix/seats · 0007 emission · 0008 transport) → diff the twin's agent surface
  → **flag-by-default (L2)**. Auto-apply only the narrow mechanical class **gated by the canon-integrity
  precondition** (never project from an unsettled source). Trust excluded entirely (L5 — flag
  `trust-regen-needed-locally`, never write). Stamp **`projected-from: decisions@2026-06-25`** (L6).
  Honor any declared **protected-set** (L9) and a provisional seat's **governance axis** (L3).
- **⚠ Required precondition — fix the stale generic prompt before any dispatch uses it.**
  `temple/tools/propagation-pass.prompt.draft.md` still carries the **pre-0008** "MECHANICAL →
  auto-apply… needs no human decision" bucket — the **exact auto-first hypothesis 0008's piql run
  falsified** (0008 structural finding; L2 locked flag-by-default). Reconcile that prompt to locked-0008
  (flag-by-default · L2 precondition · L3 governance axis · L5 trust-flag-only · L6 stamp · L9
  protected-set) **or** supersede it with this draft's Action-B steps. Correctness, not a nit.

---

## Per-twin dispatch list

| twin | prior state | this round |
|---|---|---|
| **piql.dev** | 0006/0007 pass already ran + **reconciled** (gaveled "apply nothing, parked into the **O4 cleanup loop**": F2 Vector=NO · F3 routing=FLAG · A1 Vara-effort=FLAG). | **Do NOT re-surface F2/F3/A1 as new** — reference that reconciliation. 0008 is *transport doctrine*: **no new seats, no model/effort change**. piql's delta ≈ **Action A boot-step flag + projection-stamp (L6) + protected-set invitation** (declare its D29/D30 sovereign fields in `PROJECT.yaml` per L9). Consumes its ring. |
| **vacuole** | no pass yet | **FIRST pass:** full 0006/0007 alignment (flag-by-default) + Action A boot-step flag + stamp (L6) + protected-set invitation (L9). Consumes its ring. |
| **freya.devstudio** | no pass yet | same as vacuole (first pass). |
| **subai.devenv** | no pass yet | same as vacuole (first pass). |
| **reposoma.devenv** | no pass yet | same as vacuole (first pass). |

---

## Stage / executor topology (parked — confirmed)

- **Stage 0: report-only, human-in-the-loop.** **Executor-topology (pull-by-resident vs
  temple-dispatch) stays PARKED** (0008 L1 / Stage-1) — at report-only it does not bind, so do not
  resolve it here. Dispatch is by @majkee's hand to each twin's resident Houston, or a dispatched
  @Atlas/@Epoch given the twin folder.
- **This seat's constraint:** Houston cannot reach twin repos (no Bash, no cross-repo) and does not
  write twin surfaces (Force-4 + flag-by-default). This draft is the **dispatch spec**; per-twin runs +
  reports return here for reconciliation, then any apply waits on @majkee's gavel.

---

## OPEN QUESTIONS — for @Janus (challenge-before-lock)

1. **L4-category extension (the spine):** boot step = **A1** (outside propagation; rides mail as a
   doctrine-adoption flag, L7 "two thin transports") or **A2** (extend L4's surface to boot/saddle
   doctrine)? Keep the fence tight (§4 over-process) vs name a new category honestly.
2. **Conflation guard (L7):** are Action A and Action B kept cleanly separate, or does bundling them
   under one "pass" re-blur the surface boundary L4 draws — i.e. should they be **two transports** (mail
   flag for A, propagation pass for B) rather than one dispatch?
3. **Generic-prompt staleness:** confirm the pre-0008 prompt must be reconciled to flag-by-default
   *before* any dispatch uses it (correctness, not nit) — and whether this draft supersedes it.
4. **Bootstrap honesty:** is the "first adoption = @majkee-by-hand, once per twin" the right Stage-0
   answer to the chicken-and-egg, or does it want a different one-time seed?
5. **Part 4 — cross-machine carry (the piql-brief escalation):** does temple track reposoma
   `_mail/**/inbox/` (gitignore `archive/`) to gain cross-machine temple mail — accepting the contract
   change to reposoma's *"`_mail` is drainable, nothing here is canon"*? @Janus already pre-flagged bare
   "flip reposoma/_mail to tracked" as **B-flavored coupling**; piql frames the safe shape as
   **per-repo, receiver-owns — NOT a central bus**. This is **separate from parts 1–3** and from this
   pass; surfaced here so the challenge covers the whole mechanism, not the subset. **My lean: do not
   bundle it into the twin pass** — settle it as its own Force-4 sub-decision.

---

## What a dispatched agent does (Stage 0, report-only — grounded on LOCKED 0008, not the stale prompt)

1. **Read canon (source):** `temple/decisions/index.md` (esp. 0006 · 0007 · 0008) · `temple/roster.md` ·
   `temple/system-map.md` · the `_mail/README.md` boot-step invariant.
2. **Read local (consumer):** the twin's `PROJECT.yaml` (`agents:`, `tools:`, any `protected:`) ·
   `.claude/agents/*` · its decisions/flag ledger (authorized divergences) · its boot/saddle file.
3. **Diff → flag-by-default (L2).** Auto only the narrow mechanical class, and **only if the canon
   source value is settled** (precondition). Never overwrite an authorized divergence (L9), a
   provisional seat's governance axis (L3), or cross the L4 fence.
4. **Trust:** exclude entirely; emit `trust-regen-needed-locally` as a flag (L5).
5. **Boot step (Action A):** flag the invariant for the twin architect to adopt + word locally — never
   write the twin's boot file.
6. **Stamp:** `projected-from: decisions@2026-06-25` (L6) so staleness stays pull-detectable.
7. **Emit a report** `{project, projected-from, auto-changed[], flagged-for-architect[{canon-says,
   local-says, recorded-rationale}], trust-regen-needed[], boot-step-flag}` — bring it back; apply
   nothing without @majkee's gavel.

---

*Next: @Janus pass (the 5 open questions) → fold → @majkee gavel → dispatch per-twin (piql first — its
reconciliation makes it the lightest, then the 4 first-pass twins). Mind the re-ring warning: until a
twin runs its pass + stamps, any commit touching `temple/decisions/` re-rings it.*
