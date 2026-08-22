# Admin RAG Knowledge Repository and Agent Skills

_Implementation Brief for Codex, Claude Code, and Cursor Agents_


## 1. Context and problem

- The project is a developing e-commerce application with an administration area used by non-developer users.
- Information about newly deployed features, changed behaviour, incomplete functionality, and correct admin workflows is not distributed reliably between developers and admin users.
- Traditional help pages are not sufficient because users often do not read documentation proactively. The intended interaction is conversational: an admin user should be able to ask an agent questions such as “How do I mass-reprice products in this category?” and receive a short, current answer based only on confirmed application knowledge.
- Developer discipline cannot be assumed. Knowledge publication should therefore be integrated into the normal agent-assisted development/deployment workflow rather than depending on manually written release notes.

## 2. Desired outcome

- Create a small, independent, version-controlled knowledge repository that acts as the published source of truth for user-facing administration knowledge.
- Create developer-side agent skills for Codex, Claude Code, and Cursor that can inspect a completed change and update the appropriate knowledge records after testing/deployment.
- Create a read-only user-side skill that searches the published knowledge package and answers admin users in Czech.
- Keep the first implementation intentionally small. Do not build a dedicated MCP server, vector database, Laravel SDK integration, or complex RAG service unless later requirements prove they are necessary.

## 3. Confirmed facts from the consultation

- The application is Laravel-based.
- Developers use agent-assisted tools including Codex, Claude Code, and Cursor.
- Laravel Boost/MCP may be available on the developer side and may be used by developer agents as an additional source of repository/application context.
- Knowledge consumed by users must be separated from source code and from developer-only information.
- The published knowledge package must be readable without granting users write access to the knowledge repository.
- Developer-facing structure/instructions may be in English.
- User-facing answers must be in Czech.
- The solution is considered a hot-fix / MVP and should avoid overengineering.

## 4. Assumptions requiring verification

- VERIFY IN REPOSITORY: Laravel version, PHP version, database engine, deployment model, and CI/CD system.
- VERIFY IN REPOSITORY: whether Laravel Boost is installed and which Boost/MCP capabilities are available to developer agents.
- VERIFY IN ENVIRONMENT: how Codex, Claude Code, and Cursor skills/commands are installed and invoked in the actual developer environments.
- VERIFY IN ENVIRONMENT: how the read-only user agent receives or updates the knowledge repository on user machines.
- VERIFY WITH OWNER: whether all authorized admin users may read the same published knowledge set. If knowledge visibility differs by account/role, the static-repository-only approach is not sufficient and a server-side authorization layer will be required.

## 5. Scope

- A dedicated Git repository, or a dedicated independently distributable repository/package, containing only publishable admin knowledge.
- A small documented knowledge schema.
- A developer publishing workflow integrated with agent skills.
- Separate agent adapters/skills for Codex, Claude Code, and Cursor, all implementing the same publishing contract.
- A user-facing read-only skill that retrieves relevant knowledge and responds in Czech.
- Simple update/synchronization of the read-only repository to the user environment.
- Validation scripts/tests that prevent malformed or unsafe knowledge from being published.

## 6. Explicit non-goals

- Do not expose the Laravel source repository to admin users.
- Do not give user agents direct access to Laravel Boost/MCP or internal development MCP endpoints.
- Do not build a custom MCP server for the MVP.
- Do not build a vector database unless repository size/search quality later requires it.
- Do not automatically publish arbitrary source-code diffs, secrets, internal URLs, credentials, stack traces, SQL, infrastructure details, or developer-only notes.
- Do not create separate independent knowledge formats for Codex, Claude Code, and Cursor. They must share one contract.
- Do not make generated knowledge authoritative merely because an agent wrote it. Only published/confirmed records are user-visible.

## 7. Recommended architecture

- Use a Git-backed, read-only-to-users knowledge package as the publication boundary.
- Developer agents operate against the application repository plus the knowledge repository. After a completed and verified change, the publishing skill determines whether user-facing knowledge must be created, changed, deprecated, or left untouched.
- The knowledge repository contains structured Markdown/YAML records and optional safe UI evidence snippets. It contains no source-code secrets and should be considered distributable to every user who is allowed to clone/download it.
- The user agent operates only on the local/read-only copy of the published knowledge repository. It must not infer application behaviour from source code or undocumented assumptions.
- For the MVP, retrieval can use deterministic filesystem search, metadata filtering, headings, aliases, and full-text/keyword search. Add embeddings/vector search only after demonstrated need.

## 8. Proposed repository shape

- The exact paths are a recommendation for the new knowledge repository, not claims about the existing application.
- README.md — purpose, publishing rules, security boundary, local usage.
- manifest.yaml — package/schema version, build timestamp, supported application/environment metadata where appropriate.
- knowledge/ — user-facing knowledge records grouped by stable domain, not by developer/team.
- terms/ — controlled vocabulary, aliases, Czech terminology, domain synonyms, and mappings between UI wording and business concepts.
- ui/ — optional sanitized HTML fragments, screenshots references, selectors/labels, or UI evidence needed to explain an operation. Avoid storing complete application pages or sensitive data.
- changes/ — short publish/change records for auditability.
- schemas/ — JSON Schema or equivalent validation definitions for structured front matter.
- scripts/validate — repository validation command.
- skills/ — canonical skill specification plus thin Codex / Claude Code / Cursor adapters if practical.

## 9. Knowledge item contract

- Prefer one knowledge item per stable user intent or operation, not one item per commit.
- Each item should have stable machine-readable metadata and concise human-readable instructions.
- Recommended metadata fields: id, title, domain, status, audience, application_version_or_since, updated_at, aliases, related_terms, prerequisites, permissions, confidence/publication_state, source_change_reference, and optional supersedes/deprecated_by.
- Recommended content sections: Purpose, When to use, Preconditions, Steps, Important field semantics, Expected result, Limitations/known unavailable behaviour, Troubleshooting, Related knowledge.
- The canonical knowledge record may be written in English for maintainability. The user skill must render answers in Czech. Where exact Czech UI labels are important, store those labels explicitly rather than relying on translation at answer time.
- Avoid free-form daily logs as the primary knowledge source. Daily/change logs may point to durable knowledge records, but user questions should resolve to durable task-oriented records.

## 10. Publication states

- draft — generated or edited but not approved for user retrieval.
- published — confirmed and available to user agents.
- deprecated — retained for history/compatibility but not normally returned.
- blocked or incomplete — optional state for a known feature that exists but must explicitly be communicated as unavailable/unsafe to use.
- The user skill must retrieve only published records unless the question explicitly asks about known unavailable functionality and the repository contract permits blocked/incomplete records to be shown.

## 11. Developer publishing skill: shared behaviour

- Provide one canonical behavioural specification implemented by three tool-specific skills/adapters: Codex, Claude Code, and Cursor.
- Suggested invocation concept: publish-admin-rag-update. Exact slash-command syntax is tool-specific and must be verified.
- Run after implementation, tests, and deployment/verification of a change, or when explicitly requested.
- The skill must inspect the completed change using available repository context. It may use Laravel Boost/MCP on the developer side when available, but Boost is an input/sensor only and must never become a user-facing dependency.
- Determine whether the change affects admin users. If not, report “no user knowledge update required” and make no knowledge change.
- If affected, locate the existing durable knowledge item by domain/intent/aliases. Update it instead of creating duplicate release-note-style documents.
- If no suitable item exists, create a new record using the schema.
- Capture exact user-observable behaviour: navigation/order of operations, button/field/checkbox/select labels, VAT semantics, prerequisites, limitations, permissions, validation constraints, and expected outcome.
- Never claim a UI flow or capability that was not verified from repository/application context.
- Mark uncertain facts explicitly for human review instead of inventing them.
- Run repository validation before proposing commit/push.
- Produce a concise summary of knowledge files changed and why.

## 12. Codex skill requirements

- Implement the shared publishing contract using Codex-supported local instructions/skill mechanism.
- Prefer repository inspection, tests, diffs, and existing project instructions as evidence.
- Do not introduce Codex-specific knowledge schema fields.
- VERIFY IN ENVIRONMENT: exact installation path, command naming, and whether the skill can operate across both the application repository and the knowledge repository.

## 13. Claude Code skill requirements

- Implement the same shared publishing contract using Claude Code’s supported skill/command mechanism.
- The skill may use the context from the coding session that implemented the change, but it must still verify user-observable facts before publishing.
- Do not treat conversational memory as authoritative when it conflicts with repository/application evidence.
- VERIFY IN ENVIRONMENT: exact skill/command packaging and permissions for operating on the knowledge repository.

## 14. Cursor agent skill requirements

- Implement the same shared publishing contract using Cursor’s supported rule/command/agent mechanism.
- Keep the output and knowledge schema identical to the Codex/Claude workflows.
- VERIFY IN ENVIRONMENT: current Cursor mechanism for reusable project/global agent commands and cross-repository operation.

## 15. User/admin read-only skill

- The user skill must never write to the knowledge repository.
- Its sole knowledge authority is the locally available published knowledge package (plus the current user question).
- It should resolve user wording through aliases/terms and retrieve the smallest relevant set of published knowledge records.
- Answers must be in Czech by default, even if knowledge source records are written in English.
- Answers should be short and operational: normally a direct result plus a small ordered sequence of actions.
- Use exact UI labels where they are present in the knowledge records.
- When relevant, explicitly distinguish prices with VAT vs. without VAT and other business-critical field semantics.
- If the requested capability is marked unavailable/incomplete, say so clearly instead of fabricating a workaround.
- If the repository does not contain enough confirmed information, answer that the operation is not documented/confirmed and do not infer from general Laravel/e-commerce knowledge.
- Optionally cite the knowledge item ID/title/version internally or in a compact footer for traceability.

## 16. Language contract

- Developer instructions, schemas, IDs, metadata keys, validation messages, and repository maintenance documentation: English.
- Canonical prose in knowledge records: English is acceptable and recommended for consistency across developers.
- User-facing agent response: Czech.
- Exact application UI strings: preserve the language actually displayed by the application. Do not translate button or field labels when translation would make them impossible to find in the UI.
- Czech answers should favor concise admin vocabulary over literal translation of developer terminology.

## 17. Read-only distribution and synchronization

- Preferred MVP: distribute a local read-only clone/copy of the published knowledge repository to authorized user machines or to the wrapper that runs their CLI agent.
- Use repository/platform credentials with read-only permissions. Do not share a developer password or personal write token.
- If the Git hosting platform cannot guarantee read-only credentials at the required granularity, use a controlled download/package publication mechanism instead.
- A simple update script may fetch/pull the published branch before the user skill answers or on a scheduled cadence.
- The update process must fail safely: if synchronization fails, keep the last validated package and tell the agent its knowledge may be stale if this matters.
- If different users need different knowledge visibility, stop using a complete local repository as the authorization boundary; introduce a Laravel/API read model with server-side authorization.

## 18. Security and privacy requirements

- Assume every published file may be read by any authorized repository reader.
- No credentials, API keys, tokens, internal-only endpoints, database contents, customer data, personal data, production logs, stack traces, raw SQL containing sensitive data, or private implementation details.
- Do not use Git history as a place to temporarily store secrets; secret material must never be committed.
- Developer write permissions and user read permissions must be separated.
- Prefer branch protection/review for the published branch if this does not make the MVP cumbersome.
- Agents must not bypass repository permissions.
- Knowledge records should describe behaviour, not expose internals unnecessarily.

## 19. Concurrency, compatibility, and failure handling

- Two developers may publish knowledge simultaneously. Use normal Git branching/rebase/merge conflict handling; keep records small and domain-oriented to minimize collisions.
- Stable knowledge IDs must not change merely because titles/wording change.
- Schema changes require a schema/package version and backward-compatible migration strategy for user skills.
- If validation fails, do not publish the package.
- If an application deployment is rolled back, associated knowledge must be reverted/deprecated in the same operational cycle.
- If a feature is behind a feature flag or available only to some roles/environments, encode that limitation explicitly.

## 20. Recommended implementation sequence

- 1. Create the standalone knowledge repository and README/security contract.
- 2. Define the minimal schema and three representative knowledge items from real admin operations.
- 3. Add validation for required metadata, publication states, duplicate IDs, broken internal references, and forbidden/sensitive patterns.
- 4. Implement a simple local search/retrieval command over published records without embeddings.
- 5. Implement the user/admin skill with Czech-answer requirements.
- 6. Implement the canonical developer publishing procedure.
- 7. Add thin Codex, Claude Code, and Cursor adapters invoking the same procedure/contract.
- 8. Add read-only synchronization/update mechanism for the user environment.
- 9. Exercise the complete workflow on a real deployed change.
- 10. Only after real usage, decide whether MCP, embeddings, a Laravel SDK, or a server-side knowledge API is justified.

## 21. Likely components affected

- New independent knowledge repository/package.
- Developer machine agent configuration for Codex.
- Developer machine agent configuration for Claude Code.
- Developer machine/project agent configuration for Cursor.
- User machine/CLI-wrapper skill configuration.
- Potential CI validation workflow for the knowledge repository.
- Potential deployment/post-deployment process documentation or hook.
- VERIFY IN REPOSITORY: no Laravel application code needs to change for the initial static-repository MVP unless authentication/distribution is implemented through the application.

## 22. Database, API, queue, cache, and configuration effects

- Database: none expected for the MVP.
- Application API: none expected for the MVP.
- Queues: none expected.
- Cache: optional local retrieval index only; do not add shared infrastructure initially.
- Configuration: Git/read-only distribution credentials and agent skill configuration.
- If per-user authorization becomes necessary, revisit this section: a Laravel-authenticated knowledge API/read model may then be appropriate.

## 23. Tests and verification

- Schema validation passes for every published knowledge record.
- Duplicate IDs are rejected.
- Draft records are never returned by the user retrieval path.
- Deprecated records are not selected unless explicitly requested/required.
- User answers are Czech while exact UI labels remain unchanged where required.
- A known question maps to the correct durable knowledge item through aliases.
- An unknown/undocumented question produces a safe “not confirmed/documented” answer, not a hallucinated procedure.
- A change to VAT semantics is represented explicitly and returned correctly.
- A known incomplete feature is described as unavailable/incomplete.
- Read-only user credentials cannot push/modify the repository.
- Synchronization failure preserves the last validated local package.
- Validation scans reject obvious secret/token patterns and other forbidden content.
- VERIFY IN ENVIRONMENT: provide exact commands for each agent/tool and CI system once their installed versions/configuration are known.

## 24. Acceptance criteria

- A developer completes a user-facing admin change and can invoke the relevant agent publishing skill.
- The agent identifies whether knowledge needs updating and changes the correct existing knowledge record or creates a justified new one.
- The knowledge repository validates successfully and contains no developer-only/sensitive material.
- The same knowledge contract works from Codex, Claude Code, and Cursor without schema divergence.
- An authorized admin user with a read-only copy can ask in natural language how to perform an operation.
- The user agent returns a concise Czech answer grounded only in published knowledge.
- The answer can include exact UI labels, operation order, prerequisites, VAT/price semantics, and known limitations when those are present in the source record.
- The user agent refuses to invent instructions when the repository lacks confirmed information.
- No MCP server, vector DB, or new Laravel service is required to demonstrate the end-to-end MVP.

## 25. Rollback and recovery

- Knowledge updates must be normal Git commits so they can be reverted.
- A rolled-back deployment should trigger a matching knowledge revert or deprecation.
- Keep previous published versions/tags long enough to diagnose mismatch between application and knowledge package.
- User-side synchronization should be atomic where practical: validate the new package before replacing the previous local usable version.

## 26. Questions requiring human judgment

- Are all authorized admin users allowed to possess the full same knowledge repository, or does knowledge need role/account-level visibility?
- Should developer-agent changes be automatically committed/pushed, or should the MVP stop after preparing a validated diff for human approval?
- What constitutes “deployed/confirmed”: successful CI, deployment completion, manual smoke test, or another gate?
- Which three real admin operations should be used as the first acceptance-test knowledge items? Recommended candidates include mass repricing by category, a VAT-sensitive price operation, and one workflow with multiple UI controls/order-dependent steps.
- Should screenshots/sanitized HTML snippets be part of MVP, or deferred until text-only retrieval proves insufficient?

## 27. Decision so far

- Proceed with a small Git-backed knowledge repository and agent skills.
- Keep user access read-only and independent from Laravel source code and developer MCP/Boost.
- Use one canonical publishing/retrieval contract, with thin adaptations for Codex, Claude Code, and Cursor.
- Keep knowledge structure in English/machine-readable form and produce user answers in Czech.
- Do not implement MCP/vector infrastructure now.

## 28. Recommended next action for the executor

- Before implementing integrations, build the repository skeleton, schema, validator, three representative knowledge items, and a local read-only Czech retrieval skill.
- Demonstrate one complete cycle: verified application change -> developer agent updates knowledge -> validation -> publish -> read-only sync -> Czech user answer.
- Bring back any tool-specific limitation that prevents a shared contract rather than silently creating three divergent solutions.