# Harness Lifecycle & Skill Injection — Safe Protocol Study (REFRESH)

**Date:** 2026-09-17
**Filed under:** raw.research / harness / reports
**Relation to prior report:** delta against `2026-07-20-harness-lifecycle-skill-injection-safe-protocol.md`.
Does not replace it. Read the original first.
**Researcher:** @Epoch (Sonnet)

---

## Headline

The original report's **core three-layer authority model (system prompt > CLAUDE.md-as-user-message >
skill body / preprocessing) is confirmed live, verbatim, today.** The single most load-bearing claim —
"CLAUDE.md is NOT part of the system prompt, it arrives as a user message" — is now stated almost
word-for-word in the official docs. One numeric claim (skill body token limits after compaction) could
**not be reconfirmed live** and should be treated as unverified until re-checked. Several new official
safety mechanics exist today that did not exist (or weren't documented) on 2026-07-20 and materially
strengthen the original report's §5e safeguards section.

---

## Findings (most recent first)

### 1. CLAUDE.md-as-user-message claim: CONFIRMED, live, near-verbatim

WHAT changed: nothing — this is a direct reconfirmation, worth recording because it is the load-bearing
claim of the whole report. Official docs today: **"CLAUDE.md content is delivered as a user message
after the system prompt, not as part of the system prompt itself."**
SOURCE: https://code.claude.com/docs/en/memory (live-fetched 2026-09-17), troubleshooting section
"Claude isn't following my CLAUDE.md"
CONFIDENCE: H
IMPACT: original report §2 and §7 stand unchanged.
ACTION: none — but worth citing this exact quote going forward as the primary-source anchor instead of
the community reverse-engineering blog the original report also cited (`mynameisfeng.com`), which was
CONFIDENCE M.

### 2. Cold-start load order: CONFIRMED, with one addition (managed policy scope)

WHAT changed: original report's order (org-policy → `~/.claude/CLAUDE.md` → `./CLAUDE.md` →
`CLAUDE.local.md`) is confirmed correct — official docs describe the same order plus explicit path
locations per-OS for the managed-policy tier, and clarify that directory-tree CLAUDE.md files are
ordered root-to-working-directory (parent read before child), with `CLAUDE.local.md` appended after
`CLAUDE.md` at each level.
SOURCE: https://code.claude.com/docs/en/memory
CONFIDENCE: H
IMPACT: none, refines only.
ACTION: none.

### 3. Auto memory limits: CONFIRMED unchanged (200 lines / 25KB)

WHAT changed: nothing. Live-reconfirmed today, same numbers as original report §2/§6.
SOURCE: https://code.claude.com/docs/en/memory
CONFIDENCE: H
IMPACT: none.
ACTION: none. New detail not in original report: `MEMORY.md` is only the index; per-topic files
(`user_role.md`, etc.) are NOT loaded at startup — read on demand only. Worth folding in if this report
is ever synthesized into the canonical harness card.

### 4. Skill `description` + `when_to_use` 1,536-char cap: CONFIRMED unchanged

WHAT changed: nothing. Live-reconfirmed verbatim today.
SOURCE: https://code.claude.com/docs/en/skills
CONFIDENCE: H
IMPACT: none — original §5a, §6 stand.
ACTION: none.

### 5. UNVERIFIED — skill body token limits after compaction (5k/25k combined)

WHAT changed: **could not reconfirm.** The original report's §2/§6 states "skill bodies survive up to
5,000 tokens each, combined budget 25,000 tokens, newest first" after compaction. Today's live fetch of
the skills doc surfaced a *different* framing — a **line-count** guideline ("keep SKILL.md under 500
lines... move detailed reference material to separate files") — with no explicit token-count ceiling
visible in what was fetched.
SOURCE: https://code.claude.com/docs/en/skills (live-fetched 2026-09-17) — the 5k/25k figures were NOT
found in this fetch, which does not necessarily mean they're wrong (could be documented on the
`context-window` page instead, not fetched this pass), but they are **no longer independently confirmed**.
CONFIDENCE: L (downgraded from the original's implicit H — this needs a dedicated follow-up against
`code.claude.com/docs/en/context-window`, specifically the "what survives compaction" section referenced
elsewhere in today's fetch of the memory page)
IMPACT: this is the one numeric claim in the original report that should NOT be repeated as settled
until re-verified.
ACTION: spawn a targeted follow-up: fetch `code.claude.com/docs/en/context-window#what-survives-compaction`
specifically for skill-body post-compaction token figures.

### 6. NEW safety mechanics not present in the original report (2026-07-20)

WHAT changed: three concrete, official safeguards now exist/are documented that were absent or only
inferred in the original report's §5e:

1. **Workspace trust does NOT gate `allowed-tools`.** Official docs now say explicitly: *"A skill can
   grant itself broad tool access, so review the `allowed-tools` of skills checked into a repository
   before you run Claude Code there."* This directly upgrades the original report's inferred safeguard #5
   ("Workspace trust dialog: project-level skills require explicit acceptance before allowed-tools takes
   effect") — the live doc actually says the OPPOSITE for the `-p` case: a `-p` run in an untrusted
   folder shows no trust dialog and no per-server approval prompt, and a skill's `allowed-tools` still
   applies. **This is a correction, not just an addition** — treat the original §5e point 5 as
   superseded.
2. **`disableSkillShellExecution` setting** — a config-level kill switch for the entire `!` backtick
   preprocessing pipeline. Not mentioned at all in the original report.
3. **Skills synced from claude.ai never run shell execution** (since v2.1.228) — the `!` pipeline is
   disabled specifically for cloud-synced skills, closing one class of the "EXIF payload" risk the
   original report's §4 analogized.

SOURCE: https://code.claude.com/docs/en/skills (live-fetched 2026-09-17)
CONFIDENCE: H
IMPACT: material — the original report's safeguard list (§5e) is now partially wrong (point 5) and
missing two real, dated mechanics (points 2–3). This is the most actionable finding in this refresh.
ACTION: recommend @majkee/harness-builder revise §5e of the original report directly (via @Delta,
scoped edit) rather than leaving the correction only in this addendum, since it's a safety-relevant
correction, not just an update.

### 7. NEW: subagent `omitClaudeMd` frontmatter field (v2.1.267) — extends the authority-layer model

WHAT changed: subagents can now declare `omitClaudeMd` in frontmatter to skip user/project/local
CLAUDE.md loading entirely (managed policy CLAUDE.md still loads regardless). Not present in the
original report, which treated CLAUDE.md injection as uniform across all session types.
SINCE when: v2.1.267
SOURCE: https://code.claude.com/docs/en/changelog
CONFIDENCE: H
IMPACT: the original report's §7 authority-layer diagram implicitly assumes CLAUDE.md always loads for
every context; this is now a configurable per-subagent exception.
ACTION: fold into §7 if/when the harness card is next synthesized.

### 8. Community/security context (per user request — explicitly explored this pass)

WHAT changed: since 2026-07-20, the "EXIF payload" framing the original report used constructively (§4)
has real-world teeth documented by third parties:
- OWASP's "Top 10 for Agentic Applications 2026" ranks **Agent Goal Hijacking as risk #1**.
- Independent security research (arXiv, cloud security orgs) has published **concrete exploit chains
  specifically for Claude Code skills** — not just theoretical.
- Oasis Security disclosed a chained attack ("Claudy Day," ~March 2026) combining invisible prompt
  injection with data exfiltration against claude.ai sessions.
- A large leak of Claude Code source code is reported to have given attackers deeper insight into
  internal instruction-handling, allegedly easing injection-payload crafting.
SOURCE: WebSearch aggregation — truefoundry.com, cloudsecurityalliance.org, arxiv.org (2601.17548),
pluto.security, techradar.com — CONFIDENCE: **M** (multiple independent outlets converge on the same
claims, but none of these are primary Anthropic sources, and none were individually deep-fetched/verified
in this pass — treat as a directional signal, not confirmed fact-by-fact)
IMPACT: strengthens the case for the original report's §5e safeguards (now partially corrected per
Finding 6) being taken seriously, not just as hygiene theater.
ACTION: if this becomes operationally relevant (e.g. before allowing untrusted third-party skills into
this harness), spawn a dedicated primary-source pass on the OWASP Agentic Top 10 doc and the Anthropic
prompt-injection-defenses research page (`anthropic.com/research/prompt-injection-defenses`) rather than
relying on this aggregated community pass.

---

## Sections to refresh in the ORIGINAL 2026-07-20 report

- §5e point 5 (workspace trust dialog gating `allowed-tools`) — **correct this**, it is now contradicted
  by primary source (Finding 6.1)
- §5e — add `disableSkillShellExecution` and the claude.ai-sync shell-execution-disabled mechanic
  (Finding 6.2–6.3)
- §2/§6 skill-body post-compaction token figures (5k/25k) — mark UNVERIFIED until re-checked against
  `context-window` docs (Finding 5)
- §7 authority diagram — note the `omitClaudeMd` per-subagent exception (Finding 7)
- Optional: fold in the 2026 prompt-injection landscape context (Finding 8) as a "why this matters now"
  preface, sourced properly (not from this aggregated pass)

---

## Sources (this refresh pass)

| Source | Confidence | URL |
|---|---|---|
| Official memory docs (live, 2026-09-17) | H | https://code.claude.com/docs/en/memory |
| Official skills docs (live, 2026-09-17) | H | https://code.claude.com/docs/en/skills |
| Official changelog (live, 2026-09-17) | H | https://code.claude.com/docs/en/changelog |
| Community security aggregation (multiple outlets, not individually verified) | M | see Finding 8 |

---

*Epoch research · harness builder edition · refresh pass · 2026-09-17*
