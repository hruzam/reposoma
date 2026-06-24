> ## ⚠️ CONTAMINATION NOTICE — R1 blind run ABORTED (2026-06-17)
>
> Filed by **@Houston (Claude Code)** *before* producing any R1 report, on the
> operator's standing instruction: "if it is too late and you can be influenced,
> put all warnings in the R1 kick file and I will restart the session."
>
> **A fresh session is required for a clean blind R1.** This run is not blind and
> must not be written up. Reasons below; restart guardrails at the end.
>
> ### 1. Accidental read (this session's fault)
> During a routine state-establishing sweep at session start — *before* the R1 task
> was assigned — I read:
> - `research/harness/reports/report-R2-gemini-grounded.md`, **lines 1–40**.
>   This included R2's full **X-vs-Y map for H1, H2, H3 with verdicts** and the start
>   of its **"Final Concrete Design"** (substrate + delivery mechanism).
>
> That is direct exposure to a peer brand's grounded conclusions on the exact three
> hypotheses this brief asks R1 to stress independently. Any hypothesis X I now form
> would be an anchored echo of Gemini, not an independent voice. Triangulation value
> = 0 if I proceed. (I did **not** read `report-R2-gemini.md` (ungrounded), nor any
> R3 material, nor the R2 report past line 40.)
>
> ### 2. Structural leak (affects EVERY Claude-launched R1, not just this session)
> Claude Code auto-loads `~/.claude/projects/-home-hruzam-reposoma/memory/MEMORY.md`,
> which links `research-harness.md`. That memory note states the **prior study's
> verdict verbatim**: *"sovereign-markdown as canon + a thin MCP slice for live/runtime
> only."* It loads into context at session start, before this brief is ever opened.
> The brief says "design as if you had never read [the prior conclusions]" — but the
> auto-memory hands them over anyway. This leak is **R1-specific**: R2 (Gemini/agy)
> and R3 (ChatGPT/Codex) run on other runtimes and do not load Claude's memory, so
> they stay blind. R1 does not. **This is the more important finding** — fix it before
> any future Claude-voice blind run, or R1 is structurally pre-anchored every time.
>
> ### 3. Guardrails for the clean restart
> 1. **Launch R1 with this brief as the literal first instruction** — not via a
>    "read the project canon, then wait" preamble. The state-sweep is what opened the
>    reports dir; skip it for research voices.
> 2. **Hard read-fence:** R1 may read ONLY → this brief · `research/harness/source-catalog.{jsonl,json}`
>    · `research/harness/research-pattern.{md,json}`. R1 may read NOTHING under
>    `research/harness/reports/**` and NOTHING matching `research/*.report.*` or
>    `research/*.source-map.*`.
> 3. **Neutralize the memory leak for the R1 run:** either run R1 from a runtime/dir
>    that does not load this repo's `MEMORY.md`, or temporarily detach the
>    `research-harness.md` memory node so the prior verdict is not pre-loaded. The
>    accidental-read fence (guardrail 2) is useless while the verdict still arrives via
>    auto-memory.
> 4. **No apology needed** — the harness worked: the blindness check caught the
>    contamination before it reached a report. That is the system doing its job.
>
> ### 4. The clean restart was contaminated too — by guardrail 2 itself (2026-06-17, @Houston)
> The fresh-session restart (this run) is ALSO not blind, via a path the prior abort
> created. STEP 0 of the goal passed cleanly: the `research-harness` auto-memory node
> was detached (guardrail 3 applied), so my loaded context was blind at session start.
> But the prior verdict is quoted **verbatim inside this very notice** — section 2
> above: *"sovereign-markdown as canon + a thin MCP slice for live/runtime only."* The
> goal told R1 to "read ONLY the section below the original-brief line"; I issued a
> default full-file read (no line offset) and was handed the notice with the brief. So
> the moment R1 read its one mandatory file, it received the prior verdict on **H1**
> (markdown canon) and **H2** (MCP/protocol for the live remainder). That is an X-vs-Y
> anchor → CONTAMINATED → I STOP, no R1 report. Two failure modes stacked: a procedural
> one (I should have read from the original-brief line, not the file top) and a
> structural one (below).
>
> **The load-bearing finding (structural, like #2): the warning and the verdict live in
> the same file R1 is required to read.** Guardrail 2's fence ("R1 may read ONLY this
> brief") cannot protect a voice from a verdict sitting *inside* the fenced file.
> "Read only below the line" is not self-enforcing — it relies on the voice using a
> line-offset read and never glancing up. Co-locating the contaminant with the cure
> defeats both. The prior abort, in warning about the leak, embedded the leak into the
> mandatory-read file — so the restart was pre-anchored before it began.
>
> **Fixes (recommend a + b together):**
> (a) **Redact the quote.** Replace section 2's verbatim verdict with a pointer —
>     e.g. "[prior verdict withheld — operator holds it]." A notice can warn without
>     restating the conclusion it warns about.
> (b) **Split the file.** Let `kick-brief-R1-research-center.md` carry the brief ONLY
>     (the below-the-line content). Move this entire notice to a sibling
>     `R1-contamination-log.md` that the brief does NOT link inline. R1 reads only the
>     brief; the log is for the operator / Houston.
> (c) If a notice must ride with a brief, it goes in a linked sibling — never inline
>     above the task, and never quoting a verdict.
> The brief file a blind voice is told to read must contain nothing that voice cannot
> safely see. Right now it contains the one thing it must not.
>
> ---
> *Everything below this line is the original, unmodified brief. — @Houston*

# Research Brief — R1 · the research center

`voice: R1 · for the CLIs that ran the sovereignty loop · method: you know the pattern`
`date: 2026-06-17 · phase: fresh blind design loop · DO NOT carry prior conclusions in`

You ran the prior sovereignty loop — you know the pattern: blind source-discovery → triangulate → ground → challenge → lock. Run this one the same way, but **from a fresh table**. The earlier study's conclusions are *out of scope on purpose*; design as if you had never read them. Independence from the prior result is the point.

---

## The question (design this)

For a single developer operating several AI-coding CLIs across several personal projects: design, from systems / UNIX first principles, how they should **own and deliver** AI-agent knowledge and configuration. Land somewhere concrete — a substrate, a delivery mechanism, a stance on runtime/live state. Then say where your design **diverges** from the path of least resistance, and why.

## First principles (your starting axioms — not a solution)

1. Data structures over code; **data dominates.** (Torvalds, Pike)
2. **Separate policy from mechanism.** (ESR)
3. **Plain text is the universal interface; text outlives the tools that made it.** (McIlroy, ESR)
4. **A uniform namespace can front heterogeneous backends.** (Plan 9)
5. **Do one thing well; compose through a universal interface.** (pipes)

## Three hypotheses to stress (confirm, break, or transcend each)

- **H1 — substrate.** Durable knowledge lives as plain-text canon in version control; per-tool configuration is disposable, regenerated glue. Is this right? Where does it fail?
- **H2 — the live remainder.** Runtime state (current DB schema, the last error, running logs) is the one thing a static file cannot be. Must it therefore be served over a protocol / RPC? Or can it be expressed *as files* — a synthetic filesystem / namespace the agent reads like any other path — collapsing "static vs live" into one substrate? Argue it either way.
- **H3 — the team.** Is a cooperating group of agents best modeled as a set of named roles, or as a composable pipeline of filters (stdin → stdout, each stage swappable)? What does each framing buy and cost?

## Method (blind — this is load-bearing)

- You are one of several independent voices answering this same question blind. Do **not** guess, match, or anticipate what the others say. Independence is the signal.
- There is no pre-baked right answer. Convergence between voices marks high confidence; divergence marks the real decisions. Do not hedge toward a safe middle.
- Ground where you can (cite source + date + confidence); reason from the principles where you can't.
- Deliver: your design stated concretely · your verdict on H1 / H2 / H3 · the section below.

## Open heresy (bring your own — we are genuinely curious)

What does this framing hold fixed that you would question? Name a substrate, a topology, a delivery model, or a first principle that none of the above reaches for — something surprising and defensible. We want the creative divergence, not the agreement. **Tell us what we are not seeing.**
