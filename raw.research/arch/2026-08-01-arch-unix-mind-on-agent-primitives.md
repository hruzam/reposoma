# The Arch / Unix Builder Mind on a Composable Agent-Primitive System — STUDY 2

**Date:** 2026-08-01
**Filed under:** raw.research / arch
**Status:** Behavioral synthesis (low volatility). Part A = verified doctrine; Part B = INFERRED mapping, flagged.
**Provenance:** @epoch web synthesis, Atlas main session. Part A live-verified; Part B is reasoned analysis, not sourced fact.
**Companion:** `raw.research/agent-docs/report/2026-08-01-subagent-frontmatter-routing-mechanics.md` (the two converge — see note at end).

---

## Why this study

Socratic/epistemic question: what would a well-versed Arch Linux / unix-philosophy builder see as OPPORTUNITY in a plain-text, git-versioned, composable AI-agent primitive system (agents as `.md` programs, hooks as event glue with exit codes, skills with `!command` shell substitution, orchestrator routing by frontmatter description)?

---

## PART A — how this audience thinks (verified)

### Unix philosophy (canonical, CONFIDENCE: H)
McIlroy: *"do one thing and do it well · work together · handle text streams (the universal interface)."* ESR's elaboration: Rule of Modularity, Rule of Composition, collapse to KISS; **"mechanism not policy"** — expose primitives, let the user assemble policy; a tool that bakes in opinionated workflow reads as overreach. To this audience these are **literal evaluation criteria, not metaphor.**

### The Arch Way (CONFIDENCE: M — search summaries of ArchWiki, not the article fetched direct)
Five principles: simplicity, correctness, user-centeredness, openness, freedom.
**KEY RECALIBRATION: "simplicity" ≠ "ease of use."** A steeper curve is *valued* if it buys transparency. **Friendliness is a red flag** — "what is it hiding?" DIY/"you build it yourself" — builder identity is bound to *assembly, not consumption*.

### AUR / PKGBUILD trust model (CONFIDENCE: H — direct ArchWiki language)
Maintainers do NOT vet AUR contents; "verifying the PKGBUILD is the most important step" — the user's own responsibility. **Trust is earned per-artifact by reading it, never delegated to a platform/brand.** Strong predictor of how this audience treats any agent/skill registry: they will read the `.md`/`.sh` before running, and resent tooling that obscures that read.

### Mental habits (INFERRED from the above, consistent across sources)
1. Read before run. 2. "What it *does*" over "what it *claims*" — trace mechanism, treat README/frontmatter as hypothesis. 3. Composability test — "can I pipe this, or does it want my whole workflow?" 4. Minimal-surface preference. 5. Docs-as-artifact (ArchWiki culture). 6. Ownership over convenience — hand-roll so you can debug it at 3am.

---

## PART B — mapping onto the agent-primitive system (INFERRED)

### The Unix cognates the audience already owns

| Primitive | Unix cognate |
|---|---|
| agent `.md` (identity + tools + description) | a binary in `$PATH` doing one thing well |
| `description` + `<example>` | the `man` page + bash-completion spec |
| orchestrator routing on description | the shell resolving a command by name |
| hooks (lifecycle + exit codes) | git hooks / systemd units / inotify |
| skill `!command` preprocessing | command substitution `$(...)` / here-docs |
| spawn → report between agents | the pipe: text streams |
| plain-text, git-versioned | "everything is a file"; config as dotfiles |

### Opportunities (concrete)
1. **`.md`-as-program is a genuine Unix win** — self-contained, diffable, greppable. Advertise `grep -l "tool: Bash" agents/*.md` discoverability as a *feature*; this crowd will actually run that grep before trusting.
2. **Hooks with exit codes map onto `set -e` / CI gates** — the strongest bridge. Document with man-page terseness (`EXIT STATUS`), not SaaS onboarding tone.
3. **`!command` is legible IF syntactically honest about being `$(...)`** — don't diverge silently from shell semantics; document any delta prominently (silent divergence from a familiar primitive is worse than not offering it).
4. **Git-versioning = "the AUR model, but for agents"** — this crowd already has the "unvetted, source-inspectable before you run" trust muscle. Borrow the AUR posture over a curated app-store.
5. **Composition over monolith** — make agents invokable headlessly/scriptably *outside* the router too (agent = program, prompt = stdin, response = stdout). This crowd will test for that escape hatch.

### Tensions (concrete friction)
1. **Verbose routing frontmatter violates "no unnecessary additions."** `<example>` blocks exist for the LLM's benefit, offering the human reader little → read as bloat. **Mitigation: separate router-hints from human-docs at the file level** — a terse block a human can `grep -A2 "^description:"`, vs. the LLM-oriented examples elsewhere.
2. **"Magic" `!` preprocessing is the sharpest clash with read-before-run.** `$(cmd)` fires where the reader controls; `!cmd` fires inside a preprocessing pass the user never invokes, triggered by a nondeterministic LLM routing decision — two layers of policy on a shell primitive. **Mitigation: a dry-run/trace mode** (the `bash -x` / `make -n` analog) showing which `!`commands run *before* the body hits the model.
3. **LLM routing itself is "policy," not "mechanism."** **Mitigation: keep the deterministic escape hatch (`--agent`/slash) first-class, and log the routing decision** for after-the-fact audit.
4. **Git-versioned but LLM-interpreted is a real philosophical crack.** Unix composability assumes determinism for a given input; an agent `.md` interpreted by a moving-target model is not deterministic across versions/temperature. Trust model ("verify once, trust the artifact") partially breaks. **Mitigation: pin/record the model version per run (Makefile-toolchain analog); treat "unmodified `.md`" as necessary-but-not-sufficient — git-diff-clean ≠ behavior-identical.**
5. **Schema churn** — this crowd reads frontmatter as a *contract* and resents silent drift. **Mitigation: explicit `schema: N` version field.**

---

## Convergence note (why this matters beyond the study)

Tension #1 here — "the examples exist for the LLM, not the human" — is **independently confirmed by Anthropic's own words** in the companion report: the `<example>` blocks are *"not documentation for a human reader, but training signal."* Two decorrelated currents (a philosophy synthesis and a web verify) landed on the same seam. Two candidates rise toward doctrine:
- **D1 — separate router-hints from human-docs in agent files** (tension #1).
- **D2 — git-diff-clean ≠ behavior-identical; pin the model per run** (tension #4).

Routed to @Oraculum for audit + @Janus for adversarial test (2026-08-01). Codification (if any) is @Houston's, on @majkee's gavel.

---

*Epoch synthesis · Atlas main session · 2026-08-01*
