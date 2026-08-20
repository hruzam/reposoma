---
title: Tip epistemics — trust ladder + remeasure law for harvested tip sources
scope: tip-epistemics
audience: agent + operator
machine: both
verified: 2026-08-20
---

# Tip epistemics — how harvested tips are trusted, verified, and adopted

_Gaveled by majkee 2026-08-20 (freya Medusa session, ledger T59; follow-up to the
LD deep-backfill run, T58). Instance source: the `laravel-daily-harvest` scope
(`raw.research/laravel-daily-harvest/` — its README owns the harvest RITUAL; this
guide owns the TRUST law). The ladder generalizes to any future tip-channel scope._

## When to reach for this

Before **adopting** any harvested tip into code, harness rules, or skills — and
before **citing** any tip claim as fact in a report, study, or team message.
Type `/guide tip-epistemics`. The one-line law if you read nothing else:
**a tip is a lead, not a fact — docs, PRs, or a local probe make it a fact.**

## The trust ladder

| Tier | What | Precedent (from the LD corpus) |
|---|---|---|
| **T0 — truth** | Official docs via Boost `search-docs` (version-scoped) · framework source / merged PR / release tag · **local measurement on the project stack** | freya T54 probe (11 duplicate-timestamp pairs proven live) outranks the tip that pointed at it |
| **T1 — strong** | Verified links: merged PR, vendor changelog, multi-source incident reports | `#[BindWhen]` = laravel/framework PR #60862 · Boost PR #882 · laravel-lang attack (3 independent sources) |
| **T2 — lead** | **The tip card itself.** Trusted as a pointer — "this API / idiom / risk exists" — never as fact | LD's switch example lacked `break`s per its own commenters; examples are AI-generated (GPT-5.4, Codex) |
| **T3 — signal** | Likes, comments, market commentary — prioritization weight only, never adoption evidence | 456👍 on the `prohibitDestructiveCommands` idiom = traction *signal* for the freya T37 argument, not proof |

Comments cut both ways: a channel's own commenters can **downgrade** a tip
(sloppy example flagged) — read them as part of the signal.

## Hard corollaries

1. **Numbers from a tip channel are untrusted by default.** NativePHP benchmark
   slide (no published source anywhere — rejected as uncitable) · Pesto
   self-benchmarks · Claude-*simulated* seeding numbers · Blaze launch teaser.
   Never cite; remeasure locally before any decision rests on a number.
2. **Repetition adds zero evidence.** The channel provably recycles its own tips
   (deep-backfill final-batch dups). A repost may signal *freshness* — the idiom
   is still current — nothing more.

## Remeasure decision table — required check before adoption

| Tip claim type | Example | Required before adoption |
|---|---|---|
| Docs-stable core idiom | `whereRelation` · `Str::squish` | `search-docs` confirm on our version — on contact, no probe |
| Version-gated feature | `#[BindWhen]` · `prefersJsonResponses()` ≥13.6 | `search-docs` + verify **installed local AND prod** version (freya T56 skew lesson) |
| Behavioral / semantic claim | eager-load `limit()` · `upsert()` no-events · `$touches` | docs check; **local probe if the behavior is load-bearing** |
| Performance numbers | seeding bench · NativePHP · Blaze | never cite — **remeasure on the real stack** or drop the number |
| Third-party package | image-sanitize · promptphp/intercept | supply-chain vet (source read, maturity, downloads) + **operator gavel — dependency change, always gated** |
| Security incident | laravel-lang · Packagist RAT | independent multi-source verify + **local exposure check** (freya T57 precedent) |
| Tooling / ops fact | Boost `--no-discover` · `boost:install` re-run | verify against the tool's PR/changelog; **cite the PR, not the tip** |
| Team-code proposal | enum state machine · callable transitions | never adopt into a client codebase ourselves — proposal material for the owning team |

## Division of law

- **Harvest ritual** (drop, transcribe, dedup, card format, floor pivot) →
  the owning scope's README (e.g. `raw.research/laravel-daily-harvest/README.md`).
- **Trust + adoption law** (this guide) → applies at consumption time, in any
  project session that folds harvested content into rules, skills, or code.
- Per-project verdicts live project-side (e.g. freya
  `.dev/session/research/_inbox/laraveldaily-deep-backfill-freya-value.md`).
