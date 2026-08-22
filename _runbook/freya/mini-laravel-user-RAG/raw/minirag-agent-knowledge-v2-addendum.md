# MiniRAG Agent Knowledge Repository — v2 Architecture Addendum

**Status:** implementation addendum  
**Precedence:** **BEAT PREVIOUS ARTIFACT CONTENT IN CASE SOMETHING NEW OR CONFLICTING APPEARS HERE.**  
**Applies to:** `admin-rag-knowledge-repo-coder-brief.md` / DOCX v1  
**Goal:** sharpen the MVP into an agent-native, Git-backed, graph-lite knowledge system without introducing an MCP server, vector database, or Laravel service yet.

---

## 1. Corrected actor model

The previous brief blurred producer and reader roles. Replace that model with:

### Producers — write/update knowledge

All three development agents are **PRODUCERS**:

- Claude Code
- OpenAI Codex
- Cursor agent

Each producer may inspect the application change it worked on, verify user-observable behavior, and create/update the canonical knowledge files.

All producers MUST use the same knowledge schema, relation vocabulary, validator, compiler, and publication rules. Tool-specific differences belong only in thin adapters/skills.

### Reader — consumes published knowledge

The user/admin-side **READER is Claude**.

The reader:

- has read-only access to the published knowledge package;
- does not need access to the Laravel source repository;
- does not need Laravel Boost/MCP;
- does not write knowledge;
- answers end users in Czech;
- preserves exact application UI labels where required;
- reads only enough files to answer the current question.

Do not create equivalent production reader implementations for Codex or Cursor in the MVP.

---

## 2. Claude reader model policy

Do not encode a particular commercial model name as a permanent repository invariant.

Desired operating policy:

1. Prefer a current **Sonnet-class Claude** as the primary reader where the environment provides a large context window and good tool/file behavior.
2. A large context window is a **safety margin**, not a retrieval strategy. The reader MUST still use bounded progressive disclosure instead of loading the entire repository.
3. A **Haiku-class Claude at the highest useful supported effort** may be evaluated as a low-cost/fast reader or routing seat if it performs adequately on the repository's retrieval tests.
4. Model aliases, exact context limits, and supported effort values MUST be verified in the actual Claude Code/user-wrapper runtime before hard-coding them.
5. The repository protocol MUST remain model-independent enough that replacing Sonnet/Haiku does not require rewriting the knowledge corpus.

### Practical implication

The reader skill should declare behavioral requirements such as:

- `reader_class: claude`
- `preferred_tier: sonnet`
- `fallback_tier: haiku`
- `required_language: cs`

It should NOT make correctness depend on statements such as “the model has 1M context.”

---

## 3. Architecture decision: authored graph-lite, not classic RAG

For the MVP, the filesystem is the database.

```text
Git repository
    |
    +-- natural Markdown knowledge files     <- source of truth
    |
    +-- YAML frontmatter                     <- deterministic routing metadata
    |
    +-- generated registry                   <- compiled navigation/index
    |
    +-- producer skill                       <- Claude/Codex/Cursor write/update
    |
    `-- reader skill                         <- Claude reads published records
```

Do not introduce embeddings or a vector store yet.

Do not ask the reader to scan all Markdown files on each question.

The system is best understood as **agent-native hypertext / a sparse operational knowledge graph**.

---

## 4. Gamebook principle — accepted with constraints

The “gamebook” concept is accepted, with one critical constraint:

> A file may tell the reader which other file becomes relevant **and under what condition**.

Bad:

```markdown
See pricing.md for more information.
```

Good:

```yaml
routes:
  - type: requires
    target: pricing.vat
    when: User needs to know whether the entered amount includes VAT.
```

This creates deliberate navigation rather than accidental recursive reading.

### Law

**Never follow every link. Follow an edge only when its condition is relevant to the current user question.**

---

## 5. Canonical knowledge file

Prefer one durable knowledge file per **stable user intent / operation**, not per commit and not per deployment.

Example:

```markdown
---
schema: 1
id: catalog.mass-reprice
title: Hromadné přecenění produktů
kind: procedure
status: published
domain: catalog

intents:
  - mass repricing
  - reprice category
  - change category prices
  - hromadné přecenění
  - přecenit kategorii

terms:
  - price
  - category
  - VAT

audience:
  - admin

since: VERIFY_OR_VERSION
updated_at: 2026-08-22

routes:
  - type: requires
    target: pricing.vat
    when: User needs to understand whether the price is with or without VAT.

  - type: continue
    target: catalog.mass-reprice.preview
    when: User asks how to verify affected products before applying the change.

  - type: troubleshoot
    target: catalog.mass-reprice.empty-selection
    when: No products appear after category selection.

  - type: evidence
    target: ui.catalog.mass-reprice
    when: User asks where the controls are or needs the exact UI labels.
---

# Hromadné přecenění produktů

## Purpose

Use this operation to change prices for multiple products selected by category.

## Preconditions

- Required permission: ...
- Relevant limitations: ...

## Steps

1. ...
2. ...

## Important field semantics

- ...

## Expected result

...

## Known limitations

...
```

### Content language

- IDs, schema keys, developer instructions, validator output: English.
- Canonical prose may remain English for developer maintainability.
- Exact Czech UI labels should be stored exactly as displayed by the application.
- Reader output to end users: Czech.

---

## 6. Minimal relation vocabulary

Start with only these relation types:

| Relation | Meaning |
|---|---|
| `requires` | prerequisite knowledge required to answer/use the current operation correctly |
| `continue` | a legitimate next stage or deeper branch of the operation |
| `troubleshoot` | diagnostic branch for a known failure/exception state |
| `related` | useful adjacent knowledge but not required by default |
| `evidence` | UI fragment, screenshot reference, field semantics, or other display evidence |
| `supersedes` | lifecycle relation replacing an older knowledge item |

Do not create a large ontology.

### Directionality

Author only the meaningful direction.

If `catalog.mass-reprice` `requires` `pricing.vat`, developers should not manually maintain the reverse edge.

The compiler generates backlinks such as:

```text
pricing.vat
  required_by:
    - catalog.mass-reprice
```

---

## 7. Optional UI evidence files

UI evidence must be separate from the main procedure when it would otherwise bloat the record.

Suggested shape:

```text
ui/
  catalog/
    mass-reprice.md
```

An evidence file may contain:

- exact menu names;
- button labels;
- checkbox names;
- select/combo-box labels;
- order of controls;
- short sanitized HTML fragments when genuinely useful;
- screenshot/file references if the distribution mechanism supports them;
- critical semantics such as “price includes VAT” / “price excludes VAT.”

Do not store complete rendered admin pages.

Do not store personal/customer data, session data, internal debugging information, secrets, or private implementation details.

The reader follows an `evidence` edge only when visual/UI detail is required.

---

## 8. Repository shape v2

Recommended new repository:

```text
README.md
manifest.yaml

knowledge/
  catalog/
  orders/
  pricing/
  users/
  ...

ui/
  catalog/
  pricing/
  ...

terms/
  glossary.yaml
  aliases.yaml

changes/
  YYYY-MM-DD-<short-change>.md

schemas/
  knowledge.schema.json

_registry/
  knowledge.json
  routes.json
  terms.json

skills/
  publish-admin-knowledge/
    SKILL.md
    references/
      schema.md
      publication.md
      security.md
    scripts/
      validate
      build-registry

  admin-knowledge-reader/
    SKILL.md
    references/
      retrieval.md
      answer-contract-cs.md

scripts/
  validate
  build-registry
  test-retrieval
```

`_registry/` is **generated material**.

Knowledge Markdown/frontmatter is the source of truth.

---

## 9. Generated registry

The reader should not discover the corpus by opening every frontmatter block.

Compile the corpus into a small registry.

Example:

```json
{
  "catalog.mass-reprice": {
    "file": "knowledge/catalog/mass-reprice.md",
    "title": "Hromadné přecenění produktů",
    "kind": "procedure",
    "status": "published",
    "domain": "catalog",
    "intents": [
      "mass repricing",
      "reprice category",
      "hromadné přecenění"
    ],
    "terms": ["price", "category", "VAT"],
    "outgoing": [
      {
        "type": "requires",
        "target": "pricing.vat"
      },
      {
        "type": "evidence",
        "target": "ui.catalog.mass-reprice"
      }
    ]
  }
}
```

The compiler MUST:

- reject duplicate IDs;
- reject missing targets;
- reject invalid relation types;
- generate backlinks;
- expose status and applicability;
- produce deterministic output;
- fail on malformed frontmatter;
- preserve stable IDs across wording/title changes.

---

## 10. Reader retrieval algorithm

The Claude reader MUST use progressive disclosure.

### Stage A — route

1. Read the reader skill.
2. Search the generated registry using:
   - user words;
   - aliases;
   - intents;
   - domain terms;
   - Czech/English terminology.
3. Select the smallest plausible set of entry records.

### Stage B — read

4. Open at most the best matching knowledge records.
5. Decide whether the question is already answerable.

### Stage C — conditional graph traversal

6. Follow a route only when its `when` condition is relevant.
7. Prefer `requires` and `troubleshoot` over generic `related`.
8. Load `evidence` only for UI/location/field-label questions.
9. Stop when sufficient confirmed evidence exists.

### Initial retrieval budget

Use these as starting limits, then tune from tests:

```text
entry documents:      max 3
graph depth:          max 2
content documents:    target <= 5
related-only edges:   normally <= 1
```

A model with a huge context window is still expected to obey these limits.

If the reader repeatedly needs to exceed them, treat that as evidence that the knowledge structure is wrong or the retrieval system needs evolution.

---

## 11. Reader answer contract

The reader answers the admin user in **Czech**.

Default answer style:

1. Direct answer first.
2. Short ordered procedure if action is required.
3. Exact UI labels in their real application language.
4. One warning/limitation only when relevant.
5. No developer internals.
6. No speculation.

Example shape:

```text
Ano. Otevřete **Produkty -> Hromadné operace**, vyberte kategorii
a nastavte nový způsob přecenění.

1. Vyberte kategorii.
2. Zkontrolujte náhled produktů.
3. Nastavte cenu ...
4. Potvrďte ...

Pozor: hodnota v poli **...** je cena bez DPH.
```

If published knowledge is insufficient:

```text
Tento postup nemám v potvrzené dokumentaci. Nechci si ho domýšlet.
```

The reader may provide the source knowledge ID in a compact diagnostic/footer mode, but ordinary users should not need to understand repository internals.

---

## 12. Producer contract — Claude, Codex, Cursor

The same producer contract applies to all three.

### Trigger

Run after a completed, tested, user-facing change is deployed/confirmed, or when explicitly asked to repair knowledge.

### Producer procedure

1. Inspect the actual implemented change.
2. Use project-native evidence available to that developer agent.
3. Determine whether user-visible behavior changed.
4. Search existing knowledge IDs/intents before creating a new record.
5. Update the durable existing record when possible.
6. Create a new record only for a genuinely new stable user intent.
7. Add/update typed routes when another knowledge unit is conditionally required.
8. Add UI evidence only when it materially improves user guidance.
9. Update lifecycle/version applicability.
10. Run `validate`.
11. Run `build-registry`.
12. Run focused retrieval tests relevant to the changed knowledge.
13. Produce a concise knowledge diff/handoff.
14. Follow the repository's human approval/push policy.

### Producer evidence hierarchy

Use, in order:

1. implemented application code and tests;
2. live/project-aware tools available to the development agent, such as Laravel Boost where configured;
3. actual UI behavior / verified labels;
4. existing published knowledge.

Never treat generic model knowledge as evidence of application behavior.

---

## 13. Portable producer skill

Do not maintain three independent full prompts.

Maintain one canonical skill:

```text
skills/publish-admin-knowledge/
```

Then add the smallest necessary runtime adapters for:

- Claude Code;
- Codex;
- Cursor.

The common skill owns:

- schema;
- publication protocol;
- security rules;
- validator/compiler invocation;
- output contract.

Tool adapters own only:

- how to discover/invoke the skill;
- tool permission syntax;
- repository/worktree access syntax;
- any runtime-specific command wrapper.

If a runtime cannot consume the same skill directory format, copy as little behavior as possible and clearly point back to the canonical contract.

---

## 14. Claude-specific bonding opportunity

Available project research describes Claude Code skills as on-demand `SKILL.md` packages with progressive disclosure and optional bundled `scripts/`, while hooks provide deterministic lifecycle enforcement.

For this MVP:

- use the **skill** for semantic producer/reader behavior;
- use **scripts** for deterministic validation and registry compilation;
- optionally use a **hook** later to remind or enforce validation after a publishing skill run;
- do not make a global hook silently publish user knowledge.

A mechanical hook may enforce “validate before completion.”

It should NOT decide the truth of user-facing documentation.

Truth still requires producer reasoning over verified application evidence.

---

## 15. Publication states

Retain:

- `draft`
- `published`
- `deprecated`
- optional `blocked` / `incomplete`

Reader behavior:

- ordinary answers use `published`;
- `draft` is invisible;
- `deprecated` is excluded unless historical compatibility is explicitly relevant;
- `blocked`/`incomplete` may be surfaced only to explain that a known requested feature is unavailable or unsafe.

---

## 16. Retrieval tests are first-class

Add a lightweight test corpus.

Example:

```yaml
- question: "Jak přecením všechny produkty v kategorii?"
  must_retrieve:
    - catalog.mass-reprice
  may_retrieve:
    - pricing.vat
  must_not_retrieve:
    - catalog.product-import

- question: "Je cena při hromadném přecenění s DPH?"
  must_retrieve:
    - catalog.mass-reprice
    - pricing.vat

- question: "Po výběru kategorie nevidím žádné produkty."
  must_retrieve:
    - catalog.mass-reprice.empty-selection
```

Tests should cover:

- Czech synonyms;
- English developer terminology;
- ambiguous terms;
- route following;
- no unnecessary second hop;
- no draft/deprecated retrieval;
- UI evidence only when requested;
- unknown-question safe failure.

This test set is more important for MVP quality than adding embeddings.

---

## 17. Anti-bloat laws

The system must remain intentionally small.

1. No recursive “read all related files.”
2. No giant frontmatter keyword dumps.
3. No file per commit.
4. No file per UI control.
5. No manually maintained reverse links.
6. No embedding database in v0.
7. No GraphRAG/Neo4j in v0.
8. No Laravel persistence layer in v0.
9. No MCP server in v0.
10. No full-repository load merely because the reader model can technically fit it.

Frontmatter contains deterministic facts.

Markdown contains meaning.

The generated registry contains navigation.

The model performs semantic judgment.

---

## 18. Laravel-friendly evolution path

The source protocol should survive future infrastructure changes.

### v0

```text
Git -> local repository -> Claude reader
```

### Possible v1

```text
Git -> compiler -> SQLite / FTS -> Claude reader
```

### Possible v2

```text
Git -> compiler -> Laravel authenticated knowledge API -> agent/MCP
```

### Possible v3 if proven necessary

```text
Git -> compiler -> lexical + vector + graph retrieval
```

Do not skip directly to later stages.

Laravel should consume the compiled knowledge protocol later; Laravel should not become the canonical authoring format.

---

## 19. Security boundary

The knowledge repository must be safe to possess in full by every user who receives its read-only clone/package.

If that statement becomes false because different users/accounts require different visibility:

**STOP.**

The local static repository is no longer the authorization boundary.

Move retrieval behind a Laravel-authenticated server-side read model before publishing role-sensitive information.

---

## 20. Updated implementation sequence

1. Create repository skeleton.
2. Define schema v1.
3. Define the six relation types.
4. Implement validator.
5. Implement deterministic registry/backlink compiler.
6. Author 5-10 real knowledge records manually.
7. Add retrieval test cases in Czech.
8. Implement Claude reader skill.
9. Validate reader behavior with bounded traversal.
10. Implement canonical producer skill.
11. Bind producer skill to Claude Code.
12. Bind producer skill to Codex.
13. Bind producer skill to Cursor.
14. Exercise one real deploy -> producer update -> publish -> reader answer cycle.
15. Measure retrieval failures before considering embeddings/MCP/Laravel service.

---

## 21. Acceptance criteria added by this addendum

The MVP is not accepted unless:

- Claude, Codex, and Cursor can all produce the same schema without format divergence.
- Claude is the only required runtime reader.
- a knowledge question can be routed through `_registry` without scanning all Markdown files;
- typed conditional edges are validated;
- backlinks are compiler-generated;
- the reader obeys a bounded traversal budget;
- Czech questions can retrieve English-maintained knowledge through aliases/intents;
- exact Czech UI labels survive answer generation;
- UI evidence is loaded only when needed;
- an unknown question does not cause speculative instructions;
- retrieval tests fail when an expected knowledge route breaks;
- replacing the Claude model does not require changing canonical knowledge files;
- no vector DB, MCP server, or Laravel service is required for the initial demonstration.

---

## 22. VERIFY before hard-coding runtime details

The executor must verify in the actual environments:

- current Claude Code model aliases;
- current context window available to the selected Sonnet tier;
- available effort levels for the selected Sonnet/Haiku tier;
- whether the selected Claude wrapper can enforce a reader-only tool allowlist;
- exact Codex skill discovery mechanism;
- exact Cursor reusable skill/rule mechanism;
- whether all three producers can access both the application repository and the knowledge repository safely;
- publication approval/push policy.

Do not infer these from old harness files.

---

## 23. Decision

The MVP is now:

> **A Git-native, human-authored sparse knowledge graph over normal Markdown, compiled into a tiny deterministic registry. Claude/Codex/Cursor are producers. Claude is the read-only Czech user assistant. Retrieval is progressive, conditional, auditable, and bounded.**

This architecture deliberately postpones “real RAG infrastructure.”

That postponement is a feature, not technical debt: the corpus protocol is designed so a future Laravel/API/MCP/vector implementation can compile from the same source without rewriting the knowledge.
