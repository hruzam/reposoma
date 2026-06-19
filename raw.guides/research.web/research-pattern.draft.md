# Deep-Web-Research Customary Rules — DRAFT
# Seeds @Orby's methodology. To be synthesized and refined by the Gemini side.
# Status: UNSEEDED — the named source files (research/harness/pattern.json and
#   research/harness/pattern.jsonl) were absent at the specified paths on 2026-06-19.
#   This draft is synthesized from @Epoch's methodology and general deep-web-research
#   discipline; the Gemini side should overlay any recovered Orby patterns on top.

---

## Purpose

This document encodes research STYLE — the operating discipline for a deep-web-research agent.
It is not an agent definition and not a system prompt. It is a methodology contract that any
researcher seat (human or agent) operating in this system should hold as a standing rule set.

---

## Rule 1: Date-anchoring is mandatory, not optional

Every run opens with the current date, stated explicitly. Every version string, API shape, price,
model name, flag name, file path, and capability claim is treated as POTENTIALLY STALE until a
live source confirms it in the current run. The researcher never answers from memory on these
classes of fact.

Format: state the date at the top of every report. Flag each claim as LIVE-VERIFIED or INFERRED.

---

## Rule 2: Source hierarchy — official first, then commentators

Trust order:
1. Official changelogs, docs, and GitHub releases from the maintainer
2. Aggregator feeds (releasebot.io or equivalent)
3. Trusted independent commentators — but re-verify each is still active on this run; treat
   no commentator list as permanent
4. Community issues and discussions (GitHub issues, HN threads) — useful for gotcha detection,
   low confidence for capability claims

Never report a version string or capability solely from a commentator if an official source is
reachable. If official source is unreachable, say so and cap confidence at M.

---

## Rule 3: Confidence is explicit on every finding

Use H / M / L:
- H = claim sourced directly from official changelog, docs, or primary release artifact
- M = sourced from reliable commentator, or official source but indirectly summarized (e.g.
  via WebSearch summary rather than a direct WebFetch of the page)
- L = inferred from patterns, training data, or second-hand report without direct source

Never blend confidence levels. If a finding has both an H-confidence component and an L-confidence
component, split them into separate fields.

---

## Rule 4: Conflicts must be named, not smoothed

When two sources disagree on a capability or version, state BOTH, name BOTH, and do not pick a
winner unless a third tie-breaking source resolves it. The output "Source A says X; Source B says
Y; unresolved" is more useful than a confident-sounding synthesis that hides the split.

---

## Rule 5: The go/wait question is answered decisively

Research that feeds a build decision must not end in a shrug. After laying out findings and
confidence levels, name the key discriminating constraint (the one fact that, if false, flips the
decision) and issue a clear recommendation. "Lean on it now" or "wait for reconstruction" — with
the hinge stated.

---

## Rule 6: Recency is the primary sort key for findings

Lead with the most recent finding. Older findings that provide context go after. Never bury the
current state behind a history lesson.

---

## Rule 7: Versions and paths are verified per-run, not assumed from prior runs

Even if the researcher ran 24 hours ago and found version X, the current run re-verifies from
live sources before reporting. This is especially critical for:
- CLI tool versions (new releases can ship without warning)
- API key shapes and auth flows (Google and Anthropic change these with short notice)
- Model names and model availability (suspension, gating, and launch events happen without
  scheduled windows)
- MCP configuration paths and formats (the Gemini/Antigravity transition is evidence of this)

---

## Rule 8: Scope creep is resisted at the query boundary

A research run has a named scope. If live data surfaces a significant adjacent issue, flag it
in an IMPACT / ACTION field but do not expand the research depth into it uninvited. The caller
decides whether to open a new research thread. The researcher does not self-expand.

---

## Rule 9: The output path is stated and the file is written if a path is given

If the calling context specifies an output path, the draft is written there AND returned inline.
Inline is the primary deliverable because the parent agent reads text output. The file is the
durable artifact. Both are produced. A report that only writes to a file and does not return
inline text has failed its primary channel.

---

## Rule 10: "Sections to refresh" closes every run

Every report ends with an explicit list of the claims that will age fastest — the things the
next researcher should re-verify first. This ensures continuity across runs without requiring
a full repeat of the search surface.

---

## Application notes for @Orby (Gemini side)

When synthesizing this draft:
- Overlay any patterns recovered from research/harness/pattern.json and pattern.jsonl
- Where Orby's patterns conflict with the rules above, surface the conflict; do not silently merge
- Adjust rule numbering or grouping as needed but preserve the discriminating constraint rule
  (Rule 5) and the date-anchoring rule (Rule 1) as immovable
- Flag this file as synthesized when done; remove the DRAFT header and the UNSEEDED note
