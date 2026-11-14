### Epoch report

@Epoch research report

Date: 2026-09-16
Triggered by: direct question — do Codex/Claude Code/Cursor agents get cheap help from date-in-filename when wandering/searching non-vendor-primitive files, and do they actually surface frontmatter cheaply via grep/glob/bash/py?
Scope: default radar (Claude Code, Codex CLI, Cursor) — capability/tooling question, not a project-contract lookup. No {{paths.research}} was resolved for this ad-hoc question, so this report is inline only.

Scope note per your correction: excluding vendor-native primitives (Claude SKILL.md/commands, Cursor .mdc rules) — those get frontmatter auto-indexed by the harness itself at startup/prompt-time, no agent action needed, no date-help required. The interesting case is arbitrary project files (reposoma's own CS.*.2026-XX-XX.md, _mail/*/inbox/*.md pattern) where nothing vendor-side indexes them.

Findings

WHAT changed / established: None of the three tools ship a dedicated "read frontmatter only" primitive for arbitrary files. All three fall back to generic tools (grep-equivalent, glob-equivalent, raw shell) — assembly is left to the agent.
SINCE: current, verified live today
SOURCE: Claude Code tools reference (https://code.claude.com/docs/en/tools-reference); openai/codex #4443 (https://github.com/openai/codex/issues/4443); Cursor search docs (https://cursor.com/docs/agent/tools/search)
CONFIDENCE: H (Claude Code + Cursor, official docs) / M (Codex — GitHub issue, not a formal doc, but from the vendor repo itself)
IMPACT: Frontmatter-cheap scanning is a capability, not a behavior — it only happens if the agent is instructed (project AGENTS.md/CLAUDE.md) to filter by filename/frontmatter before reading bodies.
ACTION: none — informational, confirms the mechanism reposoma already leans on is DIY, not vendor-guaranteed.

---

WHAT changed: Claude Code's Glob tool sorts results by filesystem mtime, not filename — capped at 100 files, doesn't respect .gitignore by default. Grep is ripgrep-based, respects .gitignore, supports head_limit/offset/output_mode: content — so an agent can cheaply pull just frontmatter lines (e.g. pattern: "^(date|title|tags):", output_mode: content) across a whole glob scope in one call. Read supports offset/limit, so limit: 15 is a legitimate cheap frontmatter peek too. No tool does this automatically — the agent has to choose to do it.
SINCE: current doc state, verified live today
SOURCE: https://code.claude.com/docs/en/tools-reference
CONFIDENCE: H — official docs
IMPACT: mtime-sort is fragile as a recency signal — git checkout/clone/sync resets mtime to the operation time, not the logical authored date (standard git behavior, not vendor-specific — git never stores mtime in the object model). A file dated 2026-07-28 in its name keeps that signal after any clone/checkout/sync; mtime does not. This is a direct, concrete reason date-in-filename outperforms relying on Glob's sort for "what's recent."
ACTION: none for reposoma — the existing CS.*.YYYY-MM-DD.md / *.inbox/*.YYYY-MM-DD.md convention is already the correct hedge against this exact failure mode.

---

WHAT changed: Codex CLI exposes essentially one real tool — shell (plus apply_patch invoked through it). There is no dedicated Glob or Grep tool at all; the agent is told inside its own system prompt to prefer rg / rg --files over POSIX grep/find when it drops into shell. A community request to add first-class grep/glob tools (to avoid bundling ripgrep + PATH management) is open, unresolved.
SINCE: current (issue open, unresolved as of today)
SOURCE: openai/codex #4443 (https://github.com/openai/codex/issues/4443); prompt_with_apply_patch_instructions.md (https://github.com/openai/codex/blob/main/codex-rs/core/prompt_with_apply_patch_instructions.md)
CONFIDENCE: M — GitHub issue/discussion, not a settled changelog entry; behavior could change without a formal announcement
IMPACT: For Codex, filename-date filtering and frontmatter peeking are 100% agent-improvised shell one-liners (rg --files -g 'CS.*.md', rg -m1 '^date:' -g '*.md', head -n 10). There's even less native scaffolding than Claude Code — so a stronger filename convention (dates that are trivially greppable without any YAML parsing) matters more for Codex, not less, since it has no glob-cap/sort/head_limit niceties at all.
ACTION: none — confirms date-in-name is at least as valuable, arguably more, when Cartan/astrobley (the Codex-line seats) wander this repo.

---

WHAT changed: Cursor's agent combines two search tools for arbitrary files: semantic "Codebase Search" (embeddings) and "Instant Grep" (a custom regex engine, faster than ripgrep on large repos, zero-config). Both are agent-invoked per-query; neither auto-surfaces frontmatter or treats filename dates specially.
SINCE: blog post + docs, current
SOURCE: Cursor: fast regex search (https://cursor.com/blog/fast-regex-search); Cursor search docs (https://cursor.com/docs/agent/tools/search)
CONFIDENCE: H — official vendor blog + docs
IMPACT: Same shape as Claude Code: the agent can grep frontmatter or glob by date pattern cheaply, but it's a choice the agent makes per-task, not a standing index. Semantic search actually works against date/filename patterns worse than exact grep does — reinforces that exact-string tools (grep/glob), not embeddings, are the leverage point for date conventions.
ACTION: none.

---

WHAT changed: Independent commentary (not vendor-authored) confirms the general industry direction: Claude Code, Cursor, and Devin lean on grep/find/direct reads over vector RAG for code-adjacent search — "fast, exact, deterministic," mirroring how human developers navigate.
SINCE: 2026 (undated post, but current)
SOURCE: MindStudio — "Why Cursor, Claude Code, and Devin Use grep, Not Vectors" (https://www.mindstudio.ai/blog/is-rag-dead-what-ai-agents-use-instead)
CONFIDENCE: M — third-party blog, not primary vendor source, but consistent with the primary docs above
IMPACT: Corroborates: a filename-level signal (date) is exactly the kind of cheap, exact, greppable metadata these agents are architecturally biased toward exploiting — more so than semantic/RAG approaches would be.
ACTION: none.

---

WHAT changed: A practitioner research note argues explicitly for YYYY-MM-DD-slug.md naming as "near-universal across agent content systems," and for frontmatter-first manifest scanning at ~50–100 tokens/doc vs 500–2000 tokens/doc for full bodies — recommending a two-tier pattern (filename/frontmatter manifest scan → narrow to 3–8 candidates → full read) for corpora in the sub-1000-file range, citing LlamaIndex benchmarks that filesystem-tool approaches beat vector RAG below ~100 docs while vector search wins above ~1000.
SINCE: 2026-06-14
SOURCE: Zylos Research — Agent Artifact Organization and Content Management Patterns (https://zylos.ai/research/2026-06-14-agent-artifact-organization-content-management-patterns/)
CONFIDENCE: L–M — small/unattributed research blog, no named author, specific token figures and the LlamaIndex citation are not independently re-verified against a primary LlamaIndex benchmark in this run; treat the numbers as directional, not authoritative
IMPACT: This is the closest thing to an explicit "yes, date-in-filename + frontmatter-first is a deliberate practitioner pattern for agent efficiency" claim I found — but it's commentary, not a vendor spec. No Anthropic/OpenAI/Cursor document tells you to do this; it's emergent convention, same category as reposoma's own AGENTS.md practice.
ACTION: Treat as corroborating, not authoritative. If this matters for a canon decision, it's a candidate for a mirror/vega cross-check or an @advisor brief rather than resting on a single unattributed blog — I'm flagging, not escalating, since it's directional and low-stakes for now.

Bottom line (synthesis, my read)

- Does date-in-filename help wandering/searching? Yes, concretely — for all three tools the cheapest possible signal is a filename match (Glob/rg --files/Cursor's Instant Grep), zero file-reads. A date embedded in the name is strictly more durable than relying on Glob's mtime-sort (Claude Code) — mtime resets on clone/checkout, filename dates don't. This is standard git semantics (H confidence, not vendor-specific), not something requiring further verification.
- Do the scripts/tools show frontmatter cheaply? Not natively, for non-vendor-primitive files. All three rely on the agent choosing to assemble a cheap peek itself: Claude Code has the best native scaffolding for this (Grep with output_mode: content + head_limit, or Read with limit); Cursor has an equivalent via Instant Grep; Codex has the least — everything is a hand-written shell one-liner since it only has shell.
- Do agents "in fact do it"? Only when prompted to — this is behavior, not architecture. None of the three vendors auto-index arbitrary-file frontmatter (only Claude Code auto-indexes Skill frontmatter, which is out of scope per your correction). Reposoma's own AGENTS.md seat-routing (dated mail, dated cold-start cards) is effectively the human-authored substitute for an index these tools don't provide — its value is entirely contingent on the harness telling the agent to filter by filename/date before reading bodies, which reposoma's routing tables already do implicitly (e.g. "most recent _mail/monkey/inbox/houston.monkey-not-forget-this.*.md").
- Python: none of the three vendors invoke a Python frontmatter parser by default for this use case; it would only appear if an agent deliberately writes/runs a script via its shell tool — heavier than head/grep, typically reserved for structured validation, not filtering.




### CHATGPT report

Yes. I re-checked the report against the current vendor material, and I would keep its central idea, but tighten several claims.

The strongest part is not really “dates are good filenames.” It is the more general retrieval architecture:

> **cheap deterministic routing key → cheap metadata inspection → expensive body read**

For your kind of repository, `YYYY-MM-DD` in the path/name is a very good first-stage routing key because it survives clone, checkout, copying, and machine changes. Frontmatter is then a good second-stage manifest. Neither requires semantic interpretation before the candidate set has already been reduced.

A few observations and corrections matter.

| Vendor                      | My current observation                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| --------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Anthropic / Claude Code** | The report's conclusion survives, but the implementation detail has changed significantly on Linux. Current Claude Code documentation says `Glob` and `Grep` are **absent from the default toolset on macOS/Linux/WSL**; Claude searches via Bash using embedded `bfs`/`ugrep`. Dedicated Glob/Grep can still be enabled. If Glob is present, it is mtime-sorted and capped at 100 results. `Read` supports partial reads via offset/limit. ([Claude][1])                                                              |
| **OpenAI / Codex CLI**      | The phrase “essentially one real tool — shell” is now too broad. Codex has evolved around additional harness tools such as `apply_patch`, and tool availability varies by configuration/version. But **for repository discovery/search**, the important fact remains: current Codex instructions explicitly tell the agent to use `rg` and `rg --files`. So filename-date/frontmatter discovery is still fundamentally filesystem/shell search rather than a metadata-aware arbitrary-document facility. ([GitHub][2]) |
| **Cursor / Anysphere**      | Cursor is the interesting exception to “nothing indexes arbitrary files.” Cursor really does build a semantic codebase index, and also gives the agent exact-search tools including grep/Instant Grep. Therefore I would change the claim to: Cursor does **not specially index arbitrary YAML frontmatter as a manifest**, rather than saying arbitrary files are not indexed at all. Cursor explicitly describes semantic indexing plus exact grep-style search. ([Cursor][3])                                       |
| **Google / Gemini CLI**     | This is missing from the Epoch report and strengthens the general conclusion. Gemini CLI now has first-class `glob`, `grep_search`, `read_file`, `read_many_files`, and shell tools. Its `read_file` supports line-range/limit-style partial reads. So it can implement the exact same filename → metadata → body pattern cheaply. ([GitHub][4])                                                                                                                                                                       |

Small naming correction: **Cursor is made by Anysphere, not SpaceX.** Cursor's own current pages identify Anysphere. ([Cursor][5])

There is also an important Google wrinkle that I think is relevant to your design. Gemini CLI has a genuine vendor-native hierarchical context mechanism: `GEMINI.md` is discovered and loaded automatically, including just-in-time context when tools enter directories. It also has Skills whose YAML metadata is progressively disclosed. Those are analogous to Claude/Cursor vendor primitives and should remain outside the arbitrary-artifact comparison, exactly as your report did with `SKILL.md`/`.mdc`. ([GitHub][6])

### My observations on the mechanism

The **mtime argument is particularly solid**. I would actually make that more prominent. mtime is *observational state of this checkout*. A date encoded in a filename is *repository data*. Those are different epistemic classes. When an agent is supposed to reconstruct temporal ordering after cloning, moving hosts, rebuilding a workspace, or passing a repo through Git, the filename survives as evidence whereas mtime is merely a local hint.

But I would not elevate the date itself into the primary design principle. The valuable thing is **low-entropy sortable metadata in the namespace**. For example:

`CS.reincarnation.cartan.2026-09-17.md`

is stronger than:

`2026-09-17.md`

because an agent can eliminate candidates simultaneously by artifact class, subject/seat, and time *without opening anything*. The date is one dimension of the routing key.

Frontmatter then becomes very useful for information that should not be forced into the filename: `status`, `responds_to`, `supersedes`, `gate`, `participants`, `thread`, perhaps `valid_until`. That gives you a clean distinction:

`PATH/FILENAME` = **radar**
`FRONTMATTER` = **manifest**
`BODY` = **payload**

That separation is, to me, the interesting result hiding inside the research.

I would also soften the report's statement that agents will do this “only when prompted.” That's directionally correct but a little binary. Agents **often spontaneously use cheap exact search** because their harness/system instructions bias them toward it—Codex explicitly tells the model to prefer `rg`, and Cursor says its agent automatically combines exact and semantic search. What is *not* guaranteed is your desired *ordering*: filename filter first, metadata second, bodies last. That ordering should indeed be part of the repository discipline if you care about predictable cost and behavior. ([GitHub][7])

And Cursor gives a useful counterexample to the “vectors versus grep” framing. Cursor currently invests in **both** semantic indexing and very fast regex indexing; its own research says semantic search improved agent performance, while its newer Instant Grep work targets cases where exact regex search is the right primitive. So I wouldn't canonize “vectors lose.” The more durable observation is:

> **semantic retrieval and deterministic routing solve different problems.**

Filename dates are especially powerful for a query such as “latest Cartan inbox item,” because that query has structure and ordering already encoded in it. An embedding search is unnecessary ambiguity there. Semantic search becomes useful for “which old discussion contains the reasoning about transcript injection?” ([Cursor][3])

### What I would canonize

I would preserve the research, but change its bottom line approximately to this:

> For arbitrary repository artifacts, encode cheap, durable, deterministic routing metadata in paths/filenames; put richer discriminators in small frontmatter; instruct agents to narrow by namespace first, inspect metadata second, and read full bodies only after candidate reduction. Treat filesystem mtime as non-authoritative. Vendor-native context/rule/skill mechanisms are a separate layer. Semantic retrieval complements this scheme rather than replacing it.

That principle now survives **Anthropic, OpenAI, Google, and Cursor** despite fairly different harness designs. That cross-vendor invariance is much more interesting to me than whether one particular vendor exposes a `Glob` function this month.

For NabLarva/reposoma specifically, this means your dated mail/cold-start artifacts are not merely a human naming convenience. They form a tiny **vendor-independent retrieval protocol**. The only part I would resist canonizing yet is a numeric claim such as “50–100 tokens/doc” or a threshold like “vectors win above 1,000 files.” The report itself correctly marks those as weak evidence; nothing I found makes those particular numbers strong enough to become architecture assumptions. ([Claude][1])

[1]: https://code.claude.com/docs/en/tools-reference "Tools reference - Claude Code Docs"
[2]: https://github.com/openai/codex/blob/main/codex-rs/core/prompt_with_apply_patch_instructions.md?utm_source=chatgpt.com "codex/codex-rs/core/prompt_with_apply_patch_instructions.md at main · openai/codex · GitHub"
[3]: https://cursor.com/blog/secure-codebase-indexing?utm_source=chatgpt.com "Securely indexing large codebases · Cursor"
[4]: https://github.com/google-gemini/gemini-cli/blob/main/docs/reference/tools.md?utm_source=chatgpt.com "gemini-cli/docs/reference/tools.md at main · google-gemini/gemini-cli · GitHub"
[5]: https://cursor.com/blog/fast-regex-search?utm_source=chatgpt.com "Fast regex search: indexing text for agent tools · Cursor"
[6]: https://github.com/google-gemini/gemini-cli/blob/main/docs/cli/gemini-md.md?utm_source=chatgpt.com "gemini-cli/docs/cli/gemini-md.md at main · google-gemini/gemini-cli · GitHub"
[7]: https://github.com/openai/codex/blob/main/codex-rs/protocol/src/prompts/base_instructions/default.md?utm_source=chatgpt.com "codex/codex-rs/protocol/src/prompts/base_instructions/default.md at main · openai/codex · GitHub"
