# substrate.larva.stream-shapes

`source: larva.dev/.shared/streams/stream.creation.md + stream.review.md · excavated:`
`2026-07-10 (pre-burial salvage) · verdict at dig: HOLD under observation (review) /`
`IDEA (creation) · dig record: pulse.atlas.md [2026-07-10]`
`trigger: a live run wants a formalized fast-review topology — the potential 4th run-shape`
`sibling to run-task / run-synthesis / research-pattern · destination:`
`~/.claude/skills/run-review/ or a harness doc, IF the pain recurs (Foreman rule)`

## Atlas commentary

Larva's "streams" are the direct ancestors of the temple's run-shapes — same instinct
(name the topology at kickoff, hold it), pre-dating run-task/run-synthesis by six weeks.
Two things worth carrying:

1. **The six-section anatomy:** Purpose → Entry Condition → Ordered Chain → Expected
   Output → **Hard Stop Condition** → Review/Handoff Rule. The temple's run-shapes carry
   most of this implicitly; the two sections our skills state *less* crisply are **Entry
   Condition** (when you may start — "artifact is stable, not mid-implementation" is a
   genuinely good gate) and **Hard Stop Condition** (enumerated abort triggers, not vibes:
   scope creep detected · criteria too ambiguous to judge · reviewer fails 3× consecutive
   → escalate). If run-shapes ever get revised, steal these two headings.
2. **The review stream is the live candidate.** Two-seat topology: scanner (finds
   inconsistencies against stated criteria) → validator (filters noise, produces
   severity-graded actionable summary). Cheap, bounded, explicitly *not* implementation.
   The temple currently improvises reviews per-session; if a third improvised review
   happens, this is the spec to formalize from. Minor-vs-major close rule (document and
   close / hand off to an implementation run) is the right ending.

Dead inside: every seat name (@Athena, @Zenit as gemini-era reviewers), the `rn`/`arpt`
syntax, `cmd handoff`, T2 digests, the cursor-pipeline process map reference. The creation
stream's spec→draft→review pipeline is fully superseded by temple practice (Houston/Vara →
Trajectory/Delta → gate) — kept below only because its Hard Stop list is the best-written
of the pair.

## Object 1 — stream.review (verbatim)

````markdown
# Stream: Review

`status: draft`
`since: 2026-05-16`
`syntax: arpt review`

---

## 1. Purpose

Quick practical scan and focused consistency review. Use when existing code,
documentation, or configuration needs validation against project standards without
requiring implementation changes.

## 2. Entry Condition

- A bounded scope exists (file, folder, or feature area)
- The artifact to review is stable (not mid-implementation)
- Review criteria are clear (standards doc, naming convention, or explicit checklist)

## 3. Ordered Chain (Tentacle)

1. `@Athena` -> (Task: Scan the bounded scope; identify inconsistencies, violations, or
   gaps against stated criteria)
2. `@Zenit` -> (Task: Validate findings; filter noise; produce actionable summary)

**Required Regimes/Skills for this stream:**
- `rn krpht`
- `rn hnst`
- `rn nc` (when reviewing naming/structure)

## 4. Expected Output

- A review summary document or inline annotations
- Clear list of findings: violations, warnings, recommendations
- Pass/fail or severity-graded assessment per criterion

## 5. Hard Stop Condition

- Findings indicate architectural violations requiring full rewrite (escalate to @Houston)
- Scope creep detected: review touches code outside bounded area
- Ambiguous standards: criteria not clear enough to judge (escalate to Gatekeeper)

## 6. Review or Handoff Rule

`@Zenit` produces the final review artifact. If issues found:
- Minor: document and close stream
- Major: handoff to Creation Stream or Implementation task via `cmd handoff`

Session conclusion recorded via T2 digest per `rn maps`.
````

## Object 2 — stream.creation (verbatim)

````markdown
# Protocol: Creation Stream

`status: draft`
`since: 2026-05-16`
`syntax: arpt creation`

---

## 1. Purpose
This stream orchestrates the end-to-end creation of new bounded agents or specific
technical components. It follows a strict `spec -> draft -> review` pipeline.

Use this stream when:
- Creating a new agent profile (e.g., `trajectory.md`).
- Building a new, well-defined CLI script or configuration registry.
- Fleshing out a new sub-system where the requirements are known but implementation is
  needed.

Related process map:
- `dev/.shared/registries/harness.process-map.cursor-pipeline.json`

## 2. Entry Condition
- A Task Card, brief, or specification document exists in the workspace.
- The task scope is clearly bounded.

## 3. Ordered Chain (Tentacle)

1. **`@CapCom`** -> (Task: Coordination and Specification)
   - *Action:* Reviews the user's intent and the task card. Formulates a concrete
     implementation plan. Breaks down the task into specific files to be created or edited.

2. **`@Trajectory`** -> (Task: Implementation and Drafting)
   - *Action:* Takes the plan from `@CapCom`. Executes surgical changes
     (Read, Write, Edit, Bash).
   - *Constraints:* Must stay strictly inside the scope defined by the spec. No unrelated
     refactoring. Follows local `CLAUDE.md` / `GEMINI.md` rules.

3. **`@Zenit`** -> (Task: Review and Consistency Check)
   - *Action:* Reviews the code/artifacts generated by `@Trajectory`. Checks for
     architectural consistency, naming conventions (`rn nc`), and registry alignment.

**Required Regimes/Skills for this stream:**
- `rn krpht` (Surgical, goal-driven execution by `@Trajectory`)
- `rn nc` (Strict naming conventions enforced by `@Zenit`)
- `rn hnst` (Direct, unhedged review feedback)

## 4. Expected Output
- New or modified files that exactly match the initial specification.
- Passing unit tests or successful dry-run validations (if applicable).
- A unified implementation summary.

## 5. Hard Stop Condition
The stream MUST abort and escalate to the Gatekeeper (`@majkee` or orchestrator) if:
- `@Trajectory` determines the specification contradicts workspace rules.
- The implementation requires modifying files outside the bounded scope of the original
  task.
- `@Zenit` fails the review 3 consecutive times due to persistent architectural violations.

## 6. Review or Handoff Rule
Upon final approval by `@Zenit`, the stream hands off back to the Gatekeeper/User. The
orchestrator must execute a `cmd handoff` to finalize the T2 session digest and log the
`auto:session_end` event via the host wrapper.
````
