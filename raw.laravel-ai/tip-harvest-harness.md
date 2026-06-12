# Tip-Harvesting Harness — Laravel Daily YouTube Posts (image-heavy)

Goal: the posts tab publishes near-daily micro-tips where the CODE LIVES IN THE
IMAGE (text above is only the hook). Capture them reliably, evaluate cheaply,
and land the survivors in the right slot (guideline / skill / ignore) of the
two-repo setup. Lives in Repo 2.

---

## 0. Constraints that shape the design
- The posts tab is JS-rendered → plain HTTP fetch sees nothing. Need a real
  browser (Playwright MCP) OR a human-in-the-loop capture (screenshots — what
  you did today — works fine and is ToS-safest).
- The payload is an image → a vision-capable model must transcribe code.
  Claude Code reads images natively (`Read` on a .jpg / pasted image).
- Volume is ~5-7 tips/week → this must cost minutes, not hours. Optimize for
  cheap triage, not perfect automation.
- YouTube anti-bot/consent walls are real → automated path must degrade
  gracefully to the manual path.

## 1. Repo 2 layout additions

```
dev-background/
├── research/
│   └── tips/
│       ├── inbox/            # raw captures: 2026-06-11-cache-keys.jpg + .md
│       ├── digests/          # weekly evaluated digest (the harness output)
│       └── seen.json         # dedupe ledger: hash/post-id → date, verdict
├── .claude/
│   ├── skills/
│   │   └── tip-harvest/
│   │       └── SKILL.md      # the evaluation procedure (below)
│   └── commands/
│       └── harvest-tips.md   # /harvest-tips slash command
└── agents/
    └── tip-evaluator.md      # subagent: transcribe → classify → verdict
```

## 2. Two capture lanes

### Lane A — manual (default, zero-fragility)
You (or any teammate) screenshot posts on the phone during normal scrolling —
exactly today's behavior — and drop images into `research/tips/inbox/` (or
just into a Claude Code session). Run `/harvest-tips`. Done.
This lane needs NO YouTube automation and is therefore the recommended primary.

### Lane B — automated weekly sweep (Playwright MCP)
Scheduled (cron → `claude -p "/harvest-tips --sweep"`) or manual. The agent:
1. Opens youtube.com/@LaravelDaily/posts in Playwright (headed first run for
   consent cookies; persist browser profile).
2. Scrolls until posts older than `seen.json`'s newest date appear.
3. For each new post: screenshot the post card (text + image), save to inbox
   with post-id in filename, record id in seen.json.
4. Falls back silently to "0 new captured, run Lane A" on walls/captcha.
Keep Boost MCP OFF in this session (no Laravel app here); Playwright ON.

## 3. The evaluation pipeline (tip-evaluator subagent)

Per image in inbox, produce a fixed-format block — uniform structure is what
makes weekly digests greppable and decisions auditable:

```markdown
### [date] [slug]
SOURCE: post-id/url or "manual screenshot"
TRANSCRIPTION: (code from image, verbatim, fenced)
CLAIM: one sentence — what the tip asserts
VERIFY: ✅ checked against laravel.com docs (cite version) | ⚠ unverified
        | ❌ wrong/outdated      ← REQUIRED: posts have no review process
NOVELTY: duplicate of <ledger-entry> | refinement | new   (check seen.json
         + existing guidelines/skills via grep)
RELEVANCE (imago): direct | adjacent | none — one sentence why
VERDICT: guideline-line | skill:<name> | adr-worthy | archive | discard
COST: tokens-if-guideline: ~N lines  (guard the 300-line budget!)
```

Verification step is non-negotiable: community posts occasionally show
simplified/old-version code; agents must confirm API existence/signature via
Boost search-docs (run this part in a session attached to a Laravel project)
or laravel.com docs before anything reaches a guideline.

## 4. Routing rules (the verdict logic)

- guideline-line: prevents a mistake agents ACTUALLY make, expressible in
  ≤2 lines, applies to most sessions. (Today's haul: cache-key consts, route
  array syntax, fullUrlWithoutQuery, ddRawSql.) Hard gate: total guideline
  budget ≤300 lines — adding may require deleting.
- skill:<name>: situational pattern with code (private files, API responses,
  DB::unprepared migration trick). Append to existing skill if one fits;
  create new only past ~3 related tips.
- adr-worthy: implies an architectural choice (BaseController vs Trait) →
  needs a human decision; draft the ADR stub, tag Majkee.
- archive: correct but not-now (multi-tenancy specifics) → digest only,
  greppable later.
- discard: duplicate, wrong, or irrelevant — but still ledger it so it's
  never re-evaluated.

## 5. Cadence + human gate

- Capture: continuous (Lane A) or weekly (Lane B).
- Evaluate: weekly batch — one `/harvest-tips` run, ~10 min.
- Apply: agent PREPARES diffs (guideline lines, skill appends) as a PR from
  Repo 2 → never auto-commits to guidelines. You merge; sync-ai.sh ships it
  to Freya. The PR diff is your 2-minute review surface.
- Quarterly: prune pass — drop guideline lines whose mistakes stopped
  occurring (the Povilas shrinkage principle); ledger keeps the history.

## 6. /harvest-tips command (sketch)

```markdown
---
description: Evaluate Laravel-tip screenshots from research/tips/inbox
---
1. List unprocessed files in research/tips/inbox (not in seen.json).
2. If --sweep: run Lane B capture first (Playwright). On failure, continue.
3. For each: spawn tip-evaluator subagent → fixed-format block.
4. Concatenate blocks → research/tips/digests/YYYY-Wnn.md
5. Update seen.json. Prepare branch tips/YYYY-Wnn with guideline/skill
   diffs per verdicts. Print digest summary table.
```

## 7. Why this shape (design notes)
- Subagent per image = vision transcription + doc verification happen in a
  disposable context; main session receives only verdict blocks (token
  economy, same principle as Q1).
- Fixed format + ledger = dedupe across months and an audit trail for "why
  is this rule in our guidelines?" — every line traces to a dated digest.
- Manual lane primary = the harness survives YouTube changing markup, adding
  walls, or the channel moving platforms; automation is an optimization,
  not a dependency.
