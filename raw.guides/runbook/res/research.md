# res/research — the big-scope research gate

`what: the pre-program research session that decides whether a BIG scope should exist at all.`
`extends: runbook/GUIDE.md §The golden rule — gaveled by majkee 2026-09-03 (session`
`fc-sync.oraculum.reverse-tunnel.cSharp).`
`home: nablarva — the lab project designed for exactly this question.`

## When this gate applies — and when it must not

APPLIES: a genuinely big scope — a complex application, a large group of tasks, a standalone
system. The process is domain-blind: paid client/web work and personal projects (a machine
improvement, a rack system, whatever it may be) follow the same law.

DOES NOT APPLY: a single toolbox part, a feature, an improvement inside an existing program.
Small scopes get NO research session — the golden rule is applied inline while authoring the
first RUNBOOK. A research session for a small scope is itself overengineering, refused by the
very rule it would enforce.

## Shape

The research is a SESSION — the ordinary law binds: one gate, RUNBOOK + STATUS, siblings never
nesting. It lives in nablarva's session root, `<program>-00-research/`. Its gate, written first:

> gate: a recorded VERDICT — worth reinventing, or not — with its recommendation on disk.

## What the research answers

1. **Wheel check** — does a fine existing application already cover the scope? Non-commercial /
   open counts; so does an adoptable partial design. Name candidates with dates and sources
   (an @Epoch-class dated research pass, not training-cutoff memory).
2. **Overengineering check** — is the complexity earned, or would a smaller composition of
   existing parts serve?
3. **Vendor-harness check** — the golden rule at scale: will the platforms underneath ship this
   natively soon? Name the future native change that would retire the build.

## Closure

One verdict, ranked, plus its recommendation:

- **REINVENT** — build it; the verdict file becomes a founding reference of the program's first
  real RUNBOOK.
- **ADOPT** — use or extend the named existing thing; record which, and what the delta is.
- **REFUSE** — the scope dies before a bed ever opens. This outcome is a success of the gate,
  not a failure of the idea.

Conditional recommendations are allowed but must name their condition testably.

A NO verdict costs one research session. A missed NO costs a program. That asymmetry is why this
chapter exists.
