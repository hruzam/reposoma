---
report: fable5-primitives
path: /home/hruzam/reposoma/raw.reports/raw.report.fable5-primitives.2026-06-10.md
date: 2026-06-10
scope: global + freya.devstudio
author: Atlas (claude-creator-ui)
status: applied — open threads noted below
---

# Fable 5 primitive update — 2026-06-10

## What was applied

### Global (`~/.claude/`)

| File | Change |
|---|---|
| `~/.claude/agents/agol.md` | **CREATED** — global Fable-tier continuous-reasoning advisor |
| `~/.claude/settings.json` | **UPDATED** — `advisorModel: "fable"`, `effortLevel: "medium" → "xhigh"`, `showThinkingSummaries: true` added |

### freya.devstudio (`.claude/`)

| File | Change |
|---|---|
| `.claude/agents/agol-devstudio-mind.md` | **CREATED** — project-scoped agol with team topology, phase map, grounding sources |
| `.claude/agents/houston-devstudio-architect.md` | **UPDATED** — agent team table added; Agol vs Janus routing rule documented |
| `.claude/settings.json` | **CREATED** — `advisorModel: "fable"`, `showThinkingSummaries: true` |

### RAG / knowledge cards

| File | Change |
|---|---|
| `raw.settings/raw.card.claude-code.md` | **UPDATED** — hooks: 17 → 30 events, 5 handler types, `/dev/tty` breaking change, `CLAUDE_EFFORT` env var; rate caps & fallback strategy section added |

---

## What other projects must apply

For every project with a `.claude/` directory, create or update `.claude/settings.json`:

```json
{
  "advisorModel": "fable",
  "showThinkingSummaries": true
}
```

If the project has its own agent team (houston/janus equivalent), add a project-scoped
`agol-<project>-mind.md` modelled on `agol-devstudio-mind.md`:
- Adjust team topology table
- Adjust grounding sources
- Keep model: fable, tools: [Read, Grep, Glob], color: blue

**Known projects to update:**

| Project | Path | `.claude/settings.json` | Project agol | Notes |
|---|---|---|---|---|
| freya.devstudio | `/home/hruzam/www/imago_cz/freya.devstudio` | ✅ done | ✅ done | — |
| larva.dev | `~/www/ovum/larva.dev` | ⬜ pending | ⬜ pending | Check if `.claude/` exists |
| Chytros | `~/www/chytros` (TBC) | ⬜ pending | ⬜ pending | Check if `.claude/` exists |
| Stridularium | `~/www/stridularium` | ⬜ pending | ⬜ pending | Check if `.claude/` exists |

---

## Agent: agol — design rationale

Named for Henrietta Swan Leavitt's 1908 observation on Algol-type variable stars:
> "Apparently no sharp dividing line can be drawn between true Algol stars and
> those whose variations are continuous."

Technical mapping: an advisor that holds reasoning across phase boundaries without
forcing a verdict shape. Continuous-Algol.

**Model tier:** Fable (highest GA as of 2026-06-10).
**Fallback:** Janus (Opus) when Fable ceiling is hit.
**Role distinction:** Janus = adversarial challenger. Agol = continuous synthesizer.
Not interchangeable — pick by purpose.

---

## Open threads (not done — resume here next session)

| Thread | What to do |
|---|---|
| Pending projects (larva.dev, Chytros, Stridularium) | Verify `.claude/` exists in each; create `settings.json` + project-scoped `agol-<name>-mind.md` per the template above |
| Thinking summaries in pre-compact | Formalize as a hook or session workflow — most valuable location identified; not yet wired |

---

## Fable 5 breaking changes (for agent authors)

| Change | Action required |
|---|---|
| `thinking: {type: "disabled"}` → 400 on Fable 5 | Omit `thinking` param entirely |
| `temperature`, `top_p`, `top_k` → 400 on 4.7+ | Remove from any API calls |
| Thinking display defaults to `omitted` | Add `display: "summarized"` if visibility needed |
| Tokenizer +30% tokens vs pre-4.7 | Recalibrate hardcoded token budgets |
| `/dev/tty` removed from hooks (v2.1.139) | Use `terminalSequence` field (v2.1.141+) |
