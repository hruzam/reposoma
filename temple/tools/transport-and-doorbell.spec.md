# Handoff spec — the temple mail-transport + canon-doorbell (Stage 1 of decision 0008)

`status: GATE ANSWERED (@majkee 2026-06-25) — ownership → Claude family (@Trajectory, senior); resolution → NO existing path-map, the host-scoped project map is a NEW build-first prerequisite (P0). Build in progress. Force 4: I draft, he gavels.`
`author: Houston (temple architect) · date: 2026-06-25 · host: office`
`implements: 0008 Stage 1 — L7 (two thin transports) · L6 (projection-version stamp / pull-detectable staleness)`
`builds-on (extend, don't duplicate — §4.4): the recalibration-trigger script pattern (Vega's sector, gaveled 2026-06-19, NOT YET BUILT) — see _mail/vega/inbox/houston.recalibration-script.2026-06-19.md`
`addressing: the gaveled _mail/README.md convention (2026-06-25) — logical <origin>:<agent>, derived not stored`

> **What this is.** Three small native-zsh artifacts that make 0008's transport real: (P0) a **host-scoped
> project map** the others resolve through; (A) a **mail primitive** that stages a message into a logical
> address; (B) a **canon-doorbell** that rings a project when temple canon has advanced past what that project
> last projected. (B) is built on (A); both are the **skeleton of the recalibration script** (which is itself
> not yet built — it will later reuse P0 as a sibling). Keep all *thin*: they move messages and signal
> staleness; they do **not** diff canon (that is the propagation pass, already written).

---

## Shared guardrails (inherited verbatim from the recalibration handoff — not re-derived)

1. **Plain zsh on the machine layer, not a vendor hook** (Force 3 — keep the integration layer out of vendor files).
2. **Respect decision 0003 (machine-provenance):** carry `host:` (`echo $MACHINE_NAME`); the scripts + the map
   live in the operator's machine layer (reached via 0003's record); **never bind a personal `~/` path into a
   project consumer surface or into canon (§4.7).** Office box is the host.
3. **New dated file per delivery/run** → never edit a shared file (no overwrite hazard; per-author-bus discipline).
4. **Verify it actually fires.** A silently-dead notifier is THE failure mode for this class. Test one run
   end-to-end before declaring done.

---

## P0) The host-scoped project map (NEW prerequisite — build first)

The mail primitive's one external dependency, and confirmed not to exist yet.

- **What:** a map `project-name → repo-root on this host`, for the projects in `registry/index.md`
  (reposoma, subai.devenv, reposoma.devenv, freya.devstudio, piql.dev, vacuole).
- **Where:** the **0003 machine layer** (e.g. under the operator's `~/.config/` zsh layer) — **never** in the
  temple repo or any beacon (0004 L4: no `~/`/absolute paths in canon). The map is the *only* place physical
  paths live.
- **How:** discover the checkouts on the office box (filesystem), record them in the map, carry `host:`.
- **Reuse contract:** the recalibration script, when built, reads THIS map — one map, not two.

## A) The mail primitive (build second — the doorbell depends on it)

Resolve a **logical** `<origin>:<agent>` address to a physical inbox and stage a message there.

- **Interface (capability terms, not stack terms):**
  `temple-mail  <origin>:<agent>  <scope>  [<body-file | ->]`
  → writes `<resolved-repo-root>/_mail/<agent>/inbox/<sender>.<scope>.<YYYY-MM-DD>.md`.
- **Resolution:** `origin` (project name) → repo-root via **P0**; never invent paths.
- **Honor the addressing convention exactly** (`_mail/README.md`): filename shape above; **receiver owns the
  message**; **no sent-copy** (the filesystem is the state machine); a reply returns to the *sender's* inbox.
- **Sender** = derived from caller context (or passed explicitly). Carry `host:` in the message frontmatter.

## B) The canon-doorbell (build third — the recalibration skeleton, re-parameterized)

The recalibration script with **exactly two deltas**, nothing more:
- **staleness-predicate delta:** *canon-version-lag* instead of card half-life — a project is stale when its
  `projected-from: decisions@<date>` lags temple's current canon version.
- **destination delta:** the **stale project's own inbox** (via A) instead of `_mail/toAll/`.

Hold it thin:
- **It SIGNALS staleness; it does NOT diff.** The message is a pointer: *"temple canon advanced to
  `decisions@<date>`; you are at `<older|none>`; run the propagation pass
  (`temple/tools/propagation-pass.prompt.draft.md`)."* The doorbell never enumerates what changed — that is
  the pass's job. **Doorbell ≠ brain** (L7's "hook ≠ brain", one level up).
- **No stamp present = maximally stale = ring.** This also bootstraps a never-projected project at zero cost.
- **Current canon version** = a single *derivation* from `decisions/index.md` (latest LOCKED date / highest
  locked number) — not a hand-maintained field (keeps it drift-free, §1b "encode the rule not the snapshot").
- **The stamp's concrete home** (a `projected-from:` line in a known per-project file) is fixed at build time;
  because absence = stale, the exact location is non-blocking and bootstrap is safe.
- **Trigger (L7 — hook rings the doorbell, script holds the logic):** a thin git **post-commit hook on temple
  `decisions/`** that merely *invokes* the notifier; plus a **manual** entrypoint; **cron optional**. The hook
  carries no logic.
- **Delivers via A:** `temple:houston → <project>:houston`, new dated file per ring.

---

## Build order & done

0. **P0** (map) → confirm it resolves each registry project to its office checkout; no `~/` in canon.
1. **A** (primitive) → unit-test: stage a message to a known address, confirm it lands in the right inbox with
   the right filename, no sent-copy left behind.
2. **B** (doorbell) → end-to-end test (guardrail 4): set a project's stamp to lag, fire the trigger, confirm a
   single dated notification lands in that project's inbox and NOT in up-to-date projects.
3. Log "done" to the author's pulse bus; report changed files to Houston; Houston wires the read-side (project
   saddle-boot reads its inbox) and updates 0008's Stage-1 rollout note.

---

## The gate — ANSWERED (@majkee 2026-06-25)

1. **Ownership → Claude family (@Trajectory).** Build now with the rebuilt Claude coders (also the test of the
   post-0006 implementer seats). mail+doorbell are *new* work — no prior gavel re-cut. Recalibration stays
   Vega's by precedent and will **reuse P0** (one map, one skeleton — the coherence rule, §4.4).
2. **Resolution → no existing map.** The host-scoped project map is a new build-first prerequisite (P0);
   the implementer discovers the office checkouts and records them in the 0003 machine layer.

*Next: @Trajectory builds P0 → A → B, verify-it-fires, reports changed files → Houston wires the read-side +
updates 0008 Stage-1 rollout. Recalibration script (Vega) folds onto P0 later.*
