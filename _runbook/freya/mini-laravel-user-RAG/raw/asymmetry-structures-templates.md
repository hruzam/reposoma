Yes. I researched this specifically as a **small, Git-native knowledge system for coding agents**, rather than starting from “which RAG framework should we install?”

The result is encouraging: your “gamebook” idea is **not a dead end**. In fact, several current approaches are converging on the same underlying principle: **give the model a small navigable structure first, then progressively disclose only the relevant content**. The important adjustment is that I would not make arbitrary Markdown hyperlinks themselves the retrieval system.

## What the research suggests

There are roughly four families relevant to us.

**Classic vector RAG** chunks everything, embeds it, and retrieves top-K similar chunks. For our admin knowledge package, I think this is premature. We have a small, deliberately authored corpus with strong domain structure. Throwing away that structure and rediscovering it statistically is backwards.

**GraphRAG / LightRAG** explicitly model relationships. Microsoft GraphRAG distinguishes local traversal around entities from global reasoning over graph communities; LightRAG similarly combines graph relationships with retrieval and supports incremental updates. These validate the idea that relationships between pieces of knowledge matter, but they're substantially heavier than what we currently need. ([Microsoft][1])

**Tree/hierarchical retrieval** is particularly interesting. RAPTOR builds a hierarchy so retrieval can operate at different abstraction levels rather than blindly searching flat chunks. There's also active community experimentation with vectorless “table-of-contents/tree navigation” systems. ([arXiv][2])

And most importantly, **Codex and Claude skills themselves already use essentially the mechanism we want**: a tiny discovery surface followed by progressive disclosure into referenced files. Official Codex guidance says to keep the main skill lean, put detailed knowledge under `references/`, and explicitly tell the agent when to read each reference. It specifically warns against deeply nested references and unnecessary duplication. ([GitHub][3]) Claude Code independently recommends the same architecture: concise skill body, supporting reference files loaded only when required, because loaded skill content remains a token cost. ([Claude][4])

That is strong evidence for building **MiniRAG v0 as authored navigation rather than embeddings**.

---

# I would modify our architecture

I would call it something closer to a **Knowledge Graph Lite** than RAG internally.

Not Neo4j. Not GraphRAG.

Just:

```text
Question
   ↓
SKILL.md
   ↓
registry / map
   ↓
1–3 candidate knowledge files
   ↓
explicit relations
   ↓
optional second-hop file
   ↓
answer
```

The filesystem remains the database.

Git remains versioning/distribution.

Markdown remains the human-authorable payload.

YAML frontmatter becomes the **routing metadata**.

And a tiny generated registry becomes the map.

This also fits your existing agent architecture unusually well. Phonon already has a strict “read applicable project material, activate relevant skills, use Boost as oracle” discipline.  Keystone similarly separates architecture evidence from implementation.  So the RAG publisher can become another bounded post-change responsibility rather than contaminating those seats.

---

## The gamebook idea: yes, but use typed edges

I would **not** write:

```markdown
For more information see pricing.md.
```

That's weak for agents because it doesn't explain *why* to follow the link.

Instead:

```yaml
---
id: product.mass-repricing
kind: procedure

intents:
  - mass reprice products
  - change prices for category
  - zdražit kategorii
  - přecenit produkty

requires:
  - auth.catalog-price-edit

related:
  - id: pricing.vat
    when: "User needs to know whether entered price includes VAT."

  - id: product.selection
    when: "User asks how products/categories are selected."

continue:
  - id: product.mass-repricing.preview
    when: "User asks what happens before changes are committed."
---
```

Now you've got your gamebook:

> If the user's question requires understanding VAT → open `pricing.vat`.

But the **edge has semantics**.

That is the important part.

I'd probably standardize only about five edge types initially:

`requires`, `related`, `continue`, `troubleshoot`, `supersedes`.

Not 25 relationship types.

---

# More importantly: separate routing from content

A knowledge file should have a very small machine-readable header and then excellent natural Markdown.

Something like:

```yaml
---
id: catalog.mass-reprice
title: Hromadné přecenění produktů
kind: procedure
status: published

intents:
  - mass repricing
  - repricing category
  - změnit ceny kategorie
  - hromadné přecenění

terms:
  - price
  - category
  - VAT

roles:
  - catalog-manager

routes:
  related:
    - pricing.vat
  troubleshoot:
    - catalog.mass-reprice.no-products
---
```

Then:

```markdown
# Hromadné přecenění

Použijte tuto funkci, pokud potřebujete změnit ceny
více produktů v jedné kategorii.

## Postup

1. Otevřete **Produkty → Hromadné operace**.
2. Vyberte kategorii.
3. ...
```

The agent doesn't need an embedding to understand that.

And critically, **the natural Markdown remains useful even if every retrieval technology changes in three years.**

That's a very valuable property.

---

# Add one generated registry

This is where I would improve our previous brief.

Don't force the agent to scan 300 frontmatters to discover where to begin.

Generate:

```text
_registry/
    knowledge.json
    terms.json
    routes.json
```

from the Markdown frontmatter.

For example:

```json
{
  "catalog.mass-reprice": {
    "file": "knowledge/catalog/mass-reprice.md",
    "kind": "procedure",
    "status": "published",
    "terms": ["price", "category", "VAT"],
    "edges": [
      "pricing.vat",
      "catalog.mass-reprice.no-products"
    ]
  }
}
```

**Humans never edit this.**

A validator/compiler generates it.

That gives us:

```text
Markdown = source of truth
frontmatter = structured routing
registry = compiled index
Git = storage/versioning
skill = query planner
LLM = semantic router + answerer
```

That's an extremely small stack.

No Laravel required yet.

---

## Token bloat: this is where your idea can actually win

The failure mode would be:

> Read this document. Then read all related documents. Then recursively read everything they reference.

That's graph explosion.

Your gamebook becomes Wikipedia at 3 a.m.

Instead impose a **retrieval budget**.

For example:

```text
1. Search registry.
2. Select maximum 3 entry documents.
3. Read them.
4. Follow a relation ONLY when its `when` condition
   is necessary for the current question.
5. Maximum traversal depth: 2.
6. Maximum knowledge documents in answer context: 5.
7. Stop when evidence is sufficient.
```

That resembles the motivation behind Microsoft's dynamic GraphRAG traversal: prune irrelevant branches early instead of feeding everything downstream. ([Microsoft][5])

And it's almost exactly the progressive-disclosure principle Codex recommends for skills. ([GitHub][3])

So your gamebook concept is good **provided traversal is conditional and bounded**.

---

# There is another useful lesson in your PAD design

Your PAD guide says something architecturally important:

> one step → result → next step

and explicitly branches outcomes rather than dumping the entire procedure. 

I would borrow that philosophy but **not the PAD format itself**.

A user knowledge procedure could contain:

```yaml
next:
  - target: repricing.preview
    when: "User wants to verify affected products first."

  - target: repricing.execute
    when: "User already understands the preview and asks how to apply it."

troubleshoot:
  - target: repricing.empty-selection
    when: "No products appear after category selection."
```

That makes the corpus a **human-authored sparse graph of operational knowledge**.

The LLM does not invent the graph.

Developers do.

That's a major trust advantage.

---

# One thing I would *not* do

I would not put all semantics into frontmatter.

This:

```yaml
keywords:
  - products
  - prices
  - category
  - VAT
  - repricing
  - catalog
  - admin
  - bulk
  - edit
  ...
```

quickly becomes garbage metadata.

Let the model understand natural language.

Frontmatter should contain things computers benefit from being deterministic about:

**identity, type, lifecycle, permissions/audience, aliases, relationships, version applicability.**

The Markdown contains meaning.

---

# And don't make the graph manually bidirectional

Suppose:

```yaml
pricing.vat:
  related:
    - catalog.mass-reprice
```

I don't want developers also maintaining:

```yaml
catalog.mass-reprice:
  related:
    - pricing.vat
```

unless direction has meaning.

The compiler can generate backlinks.

So the source might say:

```yaml
requires:
  - pricing.vat
```

and `_registry/routes.json` automatically knows:

```text
pricing.vat
  required_by:
    catalog.mass-reprice
```

That removes an entire class of documentation drift.

---

# Laravel later becomes pleasantly boring

This design also gives us a clean Laravel evolution path.

Today:

```text
Git repo
  ↓
local files
  ↓
agent skill
```

Later:

```text
Git repo
  ↓
knowledge compiler
  ↓
Laravel knowledge service
  ↓
authorization
  ↓
search / API / MCP
```

The Markdown contract survives.

If eventually 5,000 records make filesystem routing inadequate, we can compile exactly the same source into:

```text
SQLite / MySQL
FTS
embeddings
LightRAG
GraphRAG
MCP resources
```

without rewriting the knowledge.

That's why I prefer **source format first, retrieval engine second**.

---

## One refinement from the community research

I would now **not create three independent developer skills** as our earlier brief proposed.

Codex's official skill format and Claude Code's current skills are both based around `SKILL.md` + progressively loaded resources. Claude explicitly describes its skills as following the Agent Skills open standard. ([GitHub][3])

So first attempt should be:

```text
skills/
  publish-admin-knowledge/
    SKILL.md
    references/
      schema.md
      publishing.md
    scripts/
      validate
      build-registry
```

One canonical skill.

Then add **tiny adapters only where Cursor/Claude/Codex genuinely differ**.

That is much better than maintaining three prompts that slowly diverge.

---

## My recommended MiniRAG v0

I'd lock these principles:

1. **Git + Markdown is the canonical database.**
2. Every knowledge unit has a stable ID.
3. YAML frontmatter contains deterministic routing metadata.
4. Relations are **typed and conditional**, not generic links.
5. A compiler generates registry, backlinks and validation.
6. Retrieval starts from registry/terms rather than scanning the whole corpus.
7. Traversal is bounded — probably depth 2 / max ~5 content files initially.
8. Markdown is natural, task-oriented documentation rather than artificial “chunks.”
9. User skill answers in Czech; canonical structural metadata remains English.
10. No embeddings, vector DB, GraphRAG, MCP or Laravel service until measurements demonstrate the need.
11. One portable publishing skill first; tool-specific adapters only where necessary.
12. Retrieval should expose the IDs/files used, so answers remain auditable.

I'd also add **retrieval tests** to the repo:

```text
question:
  "Jak přecením všechny produkty v kategorii?"

must_retrieve:
  - catalog.mass-reprice

may_retrieve:
  - pricing.vat

must_not_retrieve:
  - catalog.product-import
```

That is perhaps more valuable for us than sophisticated RAG infrastructure: **we can test whether our little knowledge graph routes correctly.**

### Decision so far

Your gamebook intuition survives the research, with one change: **don't build a web of prose links; build a sparse, typed, conditional graph over normal Markdown, with a generated registry and strict traversal budget.**

That gives us something closer to *agent-native hypertext* than conventional RAG—and for this small, carefully curated admin corpus, I think that's the right starting architecture.

### Important unknowns

The main thing I would test before locking the schema is **how Codex and Claude actually behave on 50–200 of these files**: whether registry-first routing is reliable enough without embeddings, how many hops they naturally follow, and whether aliases or compact document summaries are needed in the registry.

### Recommended next action

Before asking a coder to build anything, I suggest we do **one more design pass specifically on the MiniRAG file protocol**: define the frontmatter schema, 5–6 relation semantics, registry format, retrieval algorithm, and three realistic Freya admin examples. Then we can revise the coder artifact around that much stronger architecture rather than implementing the earlier generic RAG brief.

I can also research the **agent-side retrieval behavior specifically—Codex vs Claude Code vs Cursor, including how each discovers linked/reference files and the practical context/token implications**—before we freeze that protocol.

[1]: https://microsoft.github.io/graphrag/?utm_source=chatgpt.com "Welcome - GraphRAG"
[2]: https://arxiv.org/abs/2401.18059?utm_source=chatgpt.com "RAPTOR: Recursive Abstractive Processing for Tree-Organized Retrieval"
[3]: https://github.com/openai/codex/blob/main/codex-rs/skills/src/assets/samples/skill-creator/SKILL.md?utm_source=chatgpt.com "codex/codex-rs/skills/src/assets/samples/skill-creator/SKILL.md at main · openai/codex · GitHub"
[4]: https://code.claude.com/docs/en/slash-commands?utm_source=chatgpt.com "Extend Claude with skills - Claude Code Docs"
[5]: https://www.microsoft.com/en-us/research/blog/graphrag-improving-global-search-via-dynamic-community-selection/?utm_source=chatgpt.com "GraphRAG: Improving global search via dynamic community selection - Microsoft Research"
