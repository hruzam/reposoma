# Ptyra — source of truth & sync map

**This folder is the SINGLE SOURCE OF TRUTH for Ptyra.** Everything Ptyra *is*
lives here; every vendor-specific file elsewhere is a **one-way rendering** of it.

## The truth (edit only here)
- `PTYRA.md` — WHO-AM-I. Identity, the boundary role, BUFFER→SMOOTH→RELEASE.
- `PTYRA.knowledge.md` — operating discipline, authority gradient, contracts.
- `skill.stenograph.md` — the recorder regime (event typology, flush, blocks).

These hold the **invariant behavior contract** — the shape shared across every
vendor. When Ptyra's behavior should change, it changes *here first*.

## Why one source (not split per vendor)
Splitting into independently-maintained ChatGPT / Claude versions is the orphan
trap: improve one, the other silently rots; fix a rule in one, the other keeps
the bug. Ptyra is one shared concept, so it gets one truth.

But: a Claude **Project** instruction or a ChatGPT **custom instruction** cannot
hold a pointer that reads another file — it must be self-contained pasteable
text. So `point-never-copy` cannot reach *into* a vendor prompt. We accept the
copies the format forces, and make them safe by rule.

## The rule
1. **Source → rendering, one way.** Never edit a vendor rendering in place; edit
   the source here, then re-flatten the rendering.
2. **Each rendering carries a provenance stamp** at the top: *derived from
   `raw.vendor-neutral-agents/ptyra/` @ <commit/date>, do not edit here.*
3. **Vendor-specific bits live in a marked `VENDOR DELTA` section** of the
   rendering (e.g. Claude.ai's flush-as-persistence, Project-not-Skill fold), so
   re-rendering after a source change is mechanical, not a rewrite.
4. **Pasting into a Project:** copy only the necessary body — drop the provenance
   note and any repo-only framing. The note is for the repo, not the prompt.

## Derived renderings (keep this map current — an unlisted copy is an orphan)
| Target | File | Form | Notes |
|--------|------|------|-------|
| Claude.ai | `raw.claude-ai.agents/ptyra.md` | Project master prompt (two regimes) | flush-as-persistence + Project-not-Skill are its VENDOR DELTA |
| ChatGPT | *(none — the `raw.chatGPT-agents/ptyra` copy was removed 2026-09)* | — | re-render here from source if needed again |

## To update Ptyra
1. Edit the relevant source file in this folder.
2. Re-flatten each listed rendering: shared core (from here) + that target's
   VENDOR DELTA → one self-contained prompt.
3. Bump the provenance stamp in each rendering.
4. Paste the necessary body into the live Project / custom instruction.

Storage/improvement build — not canonized, not ia-sync deployed.
