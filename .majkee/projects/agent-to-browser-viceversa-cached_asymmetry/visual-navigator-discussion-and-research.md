# Visual navigator | Discussion record and independent research brief

**From Asymmetry to majkee’s CLI collaborators · 9 November 2026**

Majkee wants to point at something in a working interface, give it a name or a spoken note, and let a living CLI session return to the same thing after the view changes. A second session should be able to use what the first session learned. The research question is how little shared machinery that actually takes.

## How the idea developed

1. **The moving cursor raised a build-or-reuse question.** Majkee saw an agent operate a browser while a collaborator was being added. Browser tools can issue real input. A visible cursor alone cannot identify how that particular action was performed. If an existing desktop tool or CLI driver already handles the job, what extra work does our framework earn? Majkee’s concrete use case is to pin a page region, attach a note or relevant snippet, and hand it to a chosen running CLI without becoming the copy-and-paste intermediary.
2. **The optics bench suggested a way to read a scene.** Majkee recalled scanning intensity line by line, fitting a curve, and using derivatives or extrema to locate a feature. The transferable idea is to choose a measurable quantity for a specific question. An edge can locate a panel boundary. It cannot tell two identically shaped Save buttons apart. Exact geometry can stay local. The CLI can consume a named target, its measured bounds, and a crop when appearance matters. The exact optics apparatus and fit order were left open.
3. **Majkee corrected my starting assumption.** I initially treated discovering a control from an image as the first problem. Majkee meant something simpler. An operator can supply a map that already says where Save is. A CLI can ask a Bash-callable adapter to move the pointer there. Reading, moving and clicking are distinct operations. Recognition becomes relevant when the map is incomplete or stale. This makes a manually authored map an important experimental baseline.
4. **Scrolling turned the static map into a measurement problem.** For ordinary document content and an unchanged layout, scrolling down by 300 CSS pixels shifts its viewport position up by 300. A fixed header can stay put, and a new banner can move the target with zero scroll. A JavaScript reader can measure current bounds and hit-test the intended point. AJAX activity can help explain a change. The actual DOM and layout reveal its effect. Exploration discovers an unfamiliar target. Navigation uses a known target’s recipe and verifies where it is now.
5. **Triangulation extended the idea beyond the browser.** Declared HTML, live structure and geometry, and rendered pixels answer different questions. A button can exist at the expected coordinates while a dialog intercepts the pointer. These observations share a rendering pipeline, so count their different failure modes rather than treating them as independent votes. On Linux, a desktop window, an emulator tab and a tmux pane have separate owners. tmux provides pane identity and cell coordinates. Showing that pane at a desktop pixel additionally requires identifying the visible client and tab, content origin, cell size and scaling.
6. **The cache gave the “animal” continuity.** A pin preserves the operator’s meaning and the recipe for finding it. A live binding identifies this particular DOM node or tmux pane. A timestamped observation records where it was measured. These have different lifetimes. Browser layout may change while a logical pin survives. A recycled pane number after server restart can refer to a different process. Local software can notice changes faster than a CLI needs to reason about them. The decisive freshness check happens when the action is about to execute.

## What the discussion established

| Standing | What a researcher can take forward |
|---|---|
| Documented capabilities | Browser geometry and hit testing, Playwright locators, tmux pane targeting and AT-SPI object inspection exist. Coverage varies by surface. |
| Agreed first trial | Pin a browser target, move it, and have a fresh CLI reach it. Independently observe which element received the pointer. Repeat identity reuse on a disposable tmux server. |
| Proposed defaults | A local owner, Python controller, JavaScript reader, managed browser and a durable pin store are practical starting choices. A CLI may argue for a smaller design and demonstrate equivalence. |
| Open claims | Cache savings, stability across real application changes, useful visual sampling rates, and attachment to majkee’s everyday Firefox session require measurements. The two companion handoffs specify intended behavior. They do not report a completed implementation. |

## Questions worth an independent pass

| Question | An observation that would change the design |
|---|---|
| How much needs building? | An existing annotation tool plus a file pointer lets a second native CLI recover the selected target and note without human transfer. Compare against this baseline before adding middleware. |
| What belongs in a pin? | A scoped application key survives ordinary reflow but silently follows a different record after list recycling. Try two rows with identical labels and change their order. Establish which domain identity the user intended. |
| When does visual evidence pay? | Compare locator-only, manually mapped and screenshot-assisted navigation on the same overlay, layout change and unlabelled control. Record both correct completions and wrong-target actions. |
| What should invalidate the cache? | Suppress a change notification. Check whether a final live measurement catches the stale geometry and how much the added check costs. Compare an event-triggered capture with a timed one on the same task. |
| Can the receiving session use the evidence? | Pin a defect in a server-rendered PHP page and send the note, nearby markup and crop to a fresh CLI. See whether it can identify the right template. Report any human hint it still needs. |

## A bounded research loop for one CLI

1. Choose one question. Write a provisional answer, its cheapest alternative and one result that would make you change your mind.
2. Inspect the relevant checkout and one primary source, or run one discriminating local fixture. Record the path and revision, source link, or exact reproduction command. A design-only pass may use a concrete counterexample and leave an empirical claim open.
3. Write a short finding. Label each material claim **observed**, **documented**, **inferred**, or **unresolved**. Include one implication for the builder or verifier. Stop when you can make a decision or name the specific missing measurement.
4. For blind triangulation, have each CLI save its finding before reading the other answer. Then compare assumptions, evidence and decisions. If disagreement remains, propose the cheapest test that would distinguish the two accounts. Consensus is optional.

**Return artifact.** Use the checkout’s bus convention or write a single Markdown note containing the exchange ID, question, provisional answer, alternative, evidence, result, decision and next test. Share the file pointer. Keep the return focused on reproducible claims and concise rationale.

**Activation prompt**

> Read visual-navigator-discussion-and-research.md. Pick the question whose answer would most change the next build decision. Examine one plausible alternative and one counterexample. Save an independent research note with evidence, remaining uncertainty and the cheapest decisive test. Return its path and exchange ID.

## Reading pointers

- [Builder handoff](visual-navigator-builder.md) and [independent verifier](visual-navigator-verifier.md). Keep the three Markdown files together when handing them to a local CLI.
- [Playwright CLI for coding agents](https://playwright.dev/docs/getting-started-cli), [Agentation annotations](https://github.com/benjitaylor/agentation), and [OmniParser screenshot parsing](https://github.com/microsoft/OmniParser) for reuse comparisons.
- [Viewport measurements](https://developer.mozilla.org/en-US/docs/Web/API/Element/getBoundingClientRect), [browser hit testing](https://developer.mozilla.org/en-US/docs/Web/API/Document/elementFromPoint), [tmux manual](https://man.openbsd.org/tmux.1), and [AT-SPI object hierarchy](https://gnome.pages.gitlab.gnome.org/at-spi2-core/libatspi/class.Accessible.html) for adapter research.
