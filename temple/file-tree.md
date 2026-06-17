# File Organization — the sovereign build, drawn as a tree

_Synthesized from the report §7 + activation study (planes) + doctrine (file plane) + the friend's note as **impulse, not frame**. The question the report never answers in picture form: where does every file live, and how sovereign is it?_

---

## The impulse under test (not obeyed)

> _friend's note:_ "nothing to migrate… all know-how in plain Markdown + code + git… **my team of agents is also application data (JSON prompts + .md), not agents in the CLI.**"

That last clause is the strong claim — it pushes the sovereign boundary past *knowledge* into *the agents themselves*. The tree below **takes the impulse** (agents live as data) and **tests its limit** (the runtime that spawns them does not). Verdict at the bottom.

---

## Two repos, two planes

```
reposoma/                      META-REPO · plane 1 + 3 · the global sovereign source
├── temple/
│   └── doctrine.md            [S] archetypes + the nine forces — cross-project canon
├── agents/                    [S] plane 1 — agents AS DATA  ← the friend's hypothesis
│   ├── _archetypes.md         [S] the doctrine §2 table, machine-readable
│   ├── architect.tmpl.md      [S] parameterized — NEVER names a project
│   ├── challenger.tmpl.md     [S]
│   ├── researcher.tmpl.md     [S]
│   ├── senior.tmpl.md         [S]  (REQUIRES: commands.test, commands.lint)
│   ├── executor.tmpl.md       [S]
│   ├── creator.tmpl.md        [S]
│   └── reader.tmpl.md         [S]  (Zenith — Haiku reader, attaches to creator)
├── skills/                    [S] SKILL.md library — portable, 32 tools
│   └── <skill>/SKILL.md       [S]
├── guidelines/                [S] authored guideline prose (the canon text)
│   └── <channel>/…            [S]  stable | edge
├── mcp-profiles/              [S] {laravel, research, …} — named tool-sets
├── registry/
│   └── <project>.yaml         [S] plane 3 — binding: which agents / profile / path
├── bin/agentctl               [S] the compile-down GATE — materialize · verify · diff
└── releases/                  [S] versioned channels — agents-vX.Y.Z (supply chain)


<project>/                     PROJECT-REPO · plane 2
│
│  ── TIER 1 · SOVEREIGN-AUTHORED — committed, hand-written, source of truth ──
├── PROJECT.yaml               [S] the contract — the ONLY file an agent may assume exists
├── docs/
│   ├── ARCHITECTURE.md        [S] community-owned name (POSIX-grade)
│   └── decisions/NNNN-*.md    [S] ADR — superseded never edited (burn-the-ships ledger)
├── session/
│   ├── plan.md                [S] present-tense — what we are doing
│   ├── flag.md                [S] present-permanent — invariants + lock index
│   ├── pulse.md               [S] present-temporary — volatile session state
│   └── research/              [S] dated, cited snapshots
├── .envrc                     [S] one line → agentctl (direnv trigger)
│
│  ── TIER 2 · GENERATED-BUT-COMMITTED — kept in git for self-sufficiency + provenance ──
├── AGENTS.md                  [GC] graduated canon-grade surface — generated, committed
├── .claude/settings.json      [GC] deny-first + PreToolUse hook — the TRUST layer, per-vendor
├── .agent-lock.json           [GC] content hashes — agentctl verify fails CI on drift
│
│  ── TIER 3 · GENERATED-&-GITIGNORED — pure renewable glue ──
├── CLAUDE.md                  [GW] one line: @AGENTS.md (the only Claude bridge)
├── .claude/agents/*           [GW] MATERIALIZED from meta-repo plane-1 templates
├── .claude/skills/*           [GW] materialized skill-set for this profile
├── .cursor/rules              [GW] materialized
├── .mcp.json                  [GW] local live-slice server only
└── .gitignore                 [S]  authored once — ignores all of TIER 3
```

---

## The legend is the point — sovereignty is a gradient, not a binary

| Tag | Tier | Migration truth |
|-----|------|-----------------|
| **[S]** | Sovereign-authored | Hand-written canon. Migration = point a new tool here. **"Nothing to migrate" is true _only here_.** |
| **[GC]** | Generated-but-committed | An *output*, but kept in git — for repo self-sufficiency and for **provenance on the trust layer**. Verified, never authored. |
| **[GW]** | Generated-&-gitignored | Pure glue. `agentctl materialize` regenerates from one source. Disposable by design. |

The doctrine's file plane sorted names into **two** buckets (community / vendor). This is the Noether correction we found last session, drawn: there are **three** states, and the **graduation rule governs leftward movement**. AGENTS.md just moved toward [S] because its *format* went AAIF-neutral. `settings.json` sits in [GC] — generated, yet committed — because **trust must live in git history** even though no human types it.

---

## Verdict on the hypothesis

- **Holds:** agent *definitions* live as [S] data in `meta-repo/agents/`, materialized down to [GW] `.claude/agents/*`. The activation study already proves this runs. "Agents as application data" is the correct organizing impulse.
- **The boundary:** agent *spawning / routing / trust* is **harness, not data** — it lands in Tier 2/3, per-vendor, and cannot be made portable. So the hypothesis ports the *definition*, never the *runtime*.

That is the **knowledge-vs-integration line** one more time, now visible as the seam between Tier 1 and Tiers 2–3. The friend's note is right about the left column and silent about the right — which is exactly why it was the right impulse and the wrong frame.
