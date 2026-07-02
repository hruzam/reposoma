# raw.settings — reference primitives and knowledge cards

Volatile, RAG-refreshable facts about the tools this temple builds with.
The recalibration researcher refreshes these; agent authors read them.

## What lives here

| Pattern | What it is |
|---------|-----------|
| `raw.card.*.md` | RELATIVE knowledge cards — volatile facts, decay by `half_life_days` |
| `raw.claude-agents.harness.*.md` | Full Claude Code agents harness (dated snapshot) |
| `researcher.recalibration.standing-prompt.md` | Standing prompt for the recalibration researcher |
| `card.template.md` | Template — **copy this when creating a new card** |
| `agents-staging/` | Agent drafts before promotion to `~/.claude/agents/` |

## Creating a new card — required frontmatter

Copy `card.template.md`, rename to `raw.card.<name>.md`, fill the frontmatter:

```yaml
card: card.<name>
brand: <Vendor> — <Product>
kind: knowledge-card · RELATIVE (volatile, RAG-refreshable)
verified: <YYYY-MM-DD>
half_life: ~<N>-<M> weeks        # human prose
half_life_days: <int>             # machine field — tooling reads THIS, not the prose above
recheck:
  - <canonical-source-url>
verify_cmd: <optional local check, e.g. `claude --version`>
```

Two freshness fields on purpose: `half_life:` is human-readable; `half_life_days:` is the integer
the freshness checker (`ainp-stale`) reads. Keep both; researcher updates both on every refresh.

## Freshness rule

Card is stale when `(today − verified) >= half_life_days`. Stale = low-confidence.
Do not emit from a stale card without a re-check via its `recheck:` sources.

Refresh loop: recalibration researcher runs → emits "Cards to refresh: [...]"
→ update `verified:` date + changed fields in the relevant card.
