# @Epoch Research Report — Claude Code `-p` Cold Start Mechanics (REFRESH)

Date: 2026-09-17
Triggered by: User request — re-verify staleness of `2026-07-21-claude-p-cold-start-mechanics.md`
Scope: Default radar (Claude Code CLI internals)
Researcher: @Epoch (Sonnet)
Relation to prior report: this does NOT replace `2026-07-21-claude-p-cold-start-mechanics.md`. It is a
delta — read the original first, then apply the corrections below. Point-never-copy.

---

## Headline

**Current live version: 2.1.274 (as of 2026-09-17).** The original report's version-anchor table tops
out at **v2.1.212**. That is a **~62-patch, ~2-month gap** — the largest single risk in the original
report is simply staleness-by-volume, not any specific wrong claim. Most core architectural claims
(the `-p`/interactive fork, TTY detection, no-daemon process model, 10MB stdin cap, SIGTERM behavior)
**held up unchanged** under live verification today. Two of the three tracked open bugs **flipped to
closed**.

---

## Findings (most recent first)

### 1. Both remaining "open bugs" from the original report are now closed

WHAT changed: Issue #12507 (shell-detection subprocesses inherit/consume parent stdin, causing premature
EOF on HPC/strict-TTY systems) is now **CLOSED**. Issue #36156 (Windows hooks always see
`process.stdin.isTTY === true`, breaking PreToolUse/PostToolUse data delivery) is now **CLOSED**.
SINCE when: unknown exact version — GitHub's issue page did not surface the closing comment or fix
version in this fetch; only status + original repro are visible.
SOURCE: https://github.com/anthropics/claude-code/issues/12507 · https://github.com/anthropics/claude-code/issues/36156
CONFIDENCE: M (status = H, but fix-version/mechanism unconfirmed — needs a targeted diff of the
changelog entries between v2.1.212 and v2.1.274, or a comment-thread read, to pin the exact release)
IMPACT: the original report's "Open bugs to watch" table is stale on 2 of 3 rows. HPC/strict-TTY users
and Windows hook authors no longer need the workarounds listed in the original §3/§6.
ACTION: if this matters operationally (e.g. a project runs Claude Code on HPC or ships Windows hooks),
spawn a targeted follow-up to find the exact fix version — do not assume "closed" means "fixed as
originally requested" without reading the resolution comment.

Issue #36001 (stream-json headless mode crashes without a TTY — "Raw mode is not supported") remains
**closed as not planned**, unchanged from the original report. CONFIDENCE: H.

### 2. `--bare` is still NOT the default for `-p` — original claim holds, live-reconfirmed

WHAT changed: nothing — reconfirmed verbatim. The official headless docs today still read: **"`--bare`
is the recommended mode for scripted and SDK calls, and will become the default for `-p` in a future
release."** Not yet flipped as of v2.1.274.
SOURCE: https://code.claude.com/docs/en/headless (live-fetched 2026-09-17)
CONFIDENCE: H
IMPACT: none — original report's framing in §2 is still accurate today.
ACTION: none; keep monitoring, this is the one line in the original report most likely to go stale
without a changelog announcement.

### 3. New SIGTERM/exit detail not in the original report: gateway drain timeout (v2.1.274)

WHAT changed: v2.1.274 adds `CLAUDE_GATEWAY_DRAIN_TIMEOUT_MS` — on SIGTERM, the Claude apps gateway now
lets in-flight requests finish for up to 25 seconds before exiting, instead of cutting every open stream
immediately. This sits alongside (not instead of) the SIGTERM behavior the original report documented in
§4 (aborts in-progress turn, kills Bash child tree, runs SessionEnd hooks, exit 143).
SINCE when: v2.1.274 (2026-09-17 changelog entry)
SOURCE: https://code.claude.com/docs/en/changelog (live-fetched 2026-09-17)
CONFIDENCE: H
IMPACT: extends, does not contradict, the original report's SIGTERM section.
ACTION: append this as an addendum to original §4/§5 rather than editing history.

Also reconfirmed live and unchanged: 10MB stdin cap, 5-second grace period for background Bash at exit,
10-minute cap on background-subagent wait with `CLAUDE_CODE_PRINT_BG_WAIT_CEILING_MS` override — all
verbatim-consistent with the original report's §5 and version-anchor table (v2.1.128, v2.1.163, v2.1.182).
CONFIDENCE: H.

### 4. New: background-Bash idle-stop behavior changed (v2.1.269) — not in original report

WHAT changed: background commands were being stopped after 30 idle minutes on machines under mild memory
pressure; now they're stopped only when memory is critically low, and the debug log states why.
SINCE when: v2.1.269
SOURCE: https://code.claude.com/docs/en/changelog
CONFIDENCE: H
IMPACT: minor — refines the "5-second grace period" / "10-minute cap" picture in original §5 with a
memory-pressure dimension that didn't exist in the July version.
ACTION: fold into the version-anchor table if this report's finding is ever merged into a canonical card.

### 5. Community-reported tmux compatibility bug on v2.1.272 (fresh, not in original report)

WHAT changed: a third-party project (`cmux`) reports Claude Code 2.1.272's named-teammate spawn failing
inside a tmux-compat shim (`__tmux-compat lacks display-message -p`), with pane rendering garbled and the
statusline missing.
SINCE when: reported against v2.1.272 (~2026-09)
SOURCE: https://github.com/manaflow-ai/cmux/issues/12682
CONFIDENCE: L (single third-party issue tracker, not an official Anthropic repo issue, not yet triaged
by Anthropic)
IMPACT: tangential to the original report's tmux section (§7), which covered `send-keys`/`pipe-pane`/PTY
mechanics generically. This is a narrower, tool-specific tmux-wrapper compatibility bug, not evidence
against the original report's core PTY/isTTY analysis.
ACTION: low priority — watch only if the project in question actually uses a tmux-compat shim layer.

### 6. Agent SDK is confirmed as the still-current recommended programmatic path

WHAT changed: nothing structurally, but now more explicitly documented. The official headless docs page
now opens by framing `-p` itself as part of "the Agent SDK... available as a CLI for scripts and CI/CD,
or as Python and TypeScript packages." This reinforces (does not overturn) the original report's §7
recommendation to use the Agent SDK rather than `spawn('claude', ['-p'])` from Node.js.
SOURCE: https://code.claude.com/docs/en/headless (live-fetched 2026-09-17)
CONFIDENCE: H
IMPACT: none — original recommendation holds.
ACTION: none.

### 7. Adjacent, not directly checked: `-p` / Agent SDK billing pool change (announced then paused)

WHAT changed: Anthropic announced (per community aggregation) that starting 2026-06-15, `claude -p` and
Agent SDK usage would bill from a separate "Agent SDK credit" pool — but the change did not go live and
was paused as of that date.
SOURCE: releasebot.io Claude Code update aggregation (2026-09) — CONFIDENCE: M (aggregator, not the
primary Anthropic pricing page — not independently re-verified against `code.claude.com/docs/en/costs`
in this pass)
IMPACT: not covered in the original report at all (out of scope for that report's question), but
relevant if any downstream project budgets `-p` usage against subscription quota.
ACTION: if cost-sensitive automation depends on this, spawn a dedicated pass against
`code.claude.com/docs/en/costs` before relying on either the "announced" or "paused" state.

---

## Sections to refresh in the ORIGINAL 2026-07-21 report

- Version-anchor table: extend past v2.1.212 through v2.1.274 (at minimum add v2.1.269, v2.1.274 rows
  above; a full diff of every intervening changelog entry was NOT performed this pass — out of scope
  for "re-verify staleness," in scope for a dedicated "close the gap" pass if needed)
- §3 "Open bugs to watch": update #12507 and #36156 to CLOSED status; find and record fix versions
  (currently unconfirmed — see Finding 1 ACTION)
- §5 process model diagram: append the v2.1.274 gateway-drain-timeout note as an addendum
- Confirm whether `--bare` flag flip-to-default has a tracking issue/RFC anywhere (not found in this pass)

## Note on the Cartan cross-check question

@majkee flagged that @Cartan (Codex-line resident) is separately going to recheck this report, and asked
whether Cartan should be anchored to the **same epoch** (today, 2026-09-17) as this refresh. **Recommend
yes** — anchor both to 2026-09-17. Reasoning: the two most load-bearing facts in this refresh (current
version = 2.1.274; two bugs flipped closed) are both timestamp-sensitive in a way that would silently
diverge if Cartan verified against a different day's changelog head. A same-day anchor makes the two
findings directly comparable and any disagreement attributable to source interpretation rather than
clock drift. If Cartan's pass lands on a later date, note the date delta explicitly rather than treating
the two reports as simultaneous.

---

## Sources (this refresh pass)

| Source | Confidence | URL |
|---|---|---|
| Official changelog (live, 2026-09-17) | H | https://code.claude.com/docs/en/changelog |
| Official headless docs (live, 2026-09-17) | H | https://code.claude.com/docs/en/headless |
| Issue #12507 — now closed | M (status H, fix-version unconfirmed) | https://github.com/anthropics/claude-code/issues/12507 |
| Issue #36001 — still closed/not planned | H | https://github.com/anthropics/claude-code/issues/36001 |
| Issue #36156 — now closed | M (status H, fix-version unconfirmed) | https://github.com/anthropics/claude-code/issues/36156 |
| cmux issue #12682 — tmux-compat bug on 2.1.272 | L | https://github.com/manaflow-ai/cmux/issues/12682 |
| releasebot.io aggregator — billing pool note | M | https://releasebot.io/updates/anthropic/claude-code |

*Epoch research · cold-start refresh pass · 2026-09-17*
