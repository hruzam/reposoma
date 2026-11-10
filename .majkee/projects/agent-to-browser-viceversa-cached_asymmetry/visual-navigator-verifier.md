# Visual navigator cache | Independent CLI verification

**Question to settle:** Can a fresh client use a previously named place correctly after the interface moves? Verify through the shipped CLI. Use an independently instrumented local page and an isolated tmux server. Record the actual target under the pointer or the actual pane read. The mapper's success message alone is insufficient.

Read `visual-navigator-builder.md` for the proposed commands. Substitute the implementation's real equivalents. Keep the mapper blind to the verifier's expected rectangles, event log and marker assertions.

## Browser runbook

1. Start the fixture and owner with a clean temporary pin store. Record software versions, viewport, tab/document generation and fixture URL. Use the top-level viewport in CSS pixels. Place the pointer away from both Save buttons before each trial.
2. In client A, explore the two buttons. Pin the checkout form's Save control by its application key. Record its bounds and runtime binding. Exit the client, keep the browser open.
3. Using the fixture driver, scroll the page so the old point no longer belongs to the target. Record the actual scroll offset and the target's independently measured rectangle. Launch client B as a new OS process with only the same store, owner connection and project. Give it the pin name. Run resolve, then point.
4. Verify that resolve left the viewport and pointer untouched. Point may bring the target back into view. Compare the **final** pointer location with geometry measured after that scroll. The fixture must observe a pointer event on the intended element or its descendant and zero clicks. Log cold and warm discovery counts.
5. Run the cases below from known fixture checkpoints. Use a fixture action counter or driver trace to establish zero pointer actions on failure. Keep verifier-induced events separate. Save a screenshot when geometry, hit testing and observed behavior disagree.

| Case | Manipulation | Acceptance |
|---|---|---|
| Manual calibration | Load the supplied map at its declared viewport, then change viewport or layout | The old prediction becomes stale. Current measurement and hit test identify the target or produce an explicit failure. |
| Pure scroll | Move ordinary content by a known measured delta | In the unchanged layout its predicted displacement has equal magnitude and opposite sign. Compare with browser measurement within 1 CSS px. |
| Reflow | Insert a banner above the target without scrolling | Warm navigation reaches the new location. Log old and new bounds. |
| Missed event | Suppress one mapper notification, then move the target | Final validation still detects the new geometry or returns a typed failure before movement. |
| Occlusion | Cover the full target with a pointer-receiving overlay | Blocked, with zero pointer input from the navigator. Removing the overlay restores navigability. |
| Ambiguous pin | Duplicate the key in the same locator scope | Ambiguous, with zero pointer input. With the duplicate removed, a similarly labelled button outside the scope must leave the original pin unambiguous. |
| Node replacement | Replace the target with a different DOM node carrying the same unique application key | Logical pin resolves, runtime binding changes, old instance retires. |
| Missing target | Remove the keyed node while leaving the other Save button | Missing, with zero pointer input. |
| Fresh owner | Restart owner, reopen fixture, reuse durable store | New generation and binding, same named pin. Reject old live handles. |

Log CSS pixels as CSS pixels. A tolerance for geometric prediction cannot excuse delivery to the wrong element. The primary browser trial passes only if the warm client reaches the intended target without re-pinning or performing full discovery. Count an unexpected abstention on an ordinary, observable target as a failure.

## tmux runbook

1. Start the disposable named server and create two panes with distinguishable markers. Record the server nonce and IDs directly with `tmux list-panes`, independently of the mapper.
2. Client A binds `build-output` to one pane and exits. Swap the panes within the window. Confirm the target actually moved using the tmux layout.
3. Client B resolves the named pin. Compare server, window, pane ID and cell coordinates to the direct tmux read. Read the pane by name and check the marker. No user re-identification should be needed.
4. Kill that pane while leaving the other pane running. Repeat the read. Expect stale or missing. Restart the fixture server on the same socket name, establish a new nonce, and attempt the old binding again. A recycled pane ID must not restore the old association.
5. Shut down the fixture's server and preserve text evidence. If the environment lacks tmux or a browser dependency, record the exact command and error against that adapter.

## Is the cache worth keeping?

Run a cold/full-discovery baseline and a warm/pin-reuse trial from the same page state. Both pay for fresh target checks, and both must deliver to the right recipient. Record full discoveries, scoped locator resolutions, geometry reads, screenshot count, bytes sent to the CLI, wall time and correct completions. Keep setup time separate. Repeat any timing comparison and record the number of trials. One successful action establishes feasibility. A timing claim requires comparable measured runs.

## Return record

Publish a Markdown result with run/exchange ID, checkout revision, environment, exact reproduction commands, per-case pass/fail/blocked status and evidence paths. Include at least one before/after example with target ID, geometry and actual recipient. Describe any wrong-target or silent-rebind case first. If both adapters pass and warm discovery work falls, the milestone is ready for integration into an existing CLI handoff. If only timing stays flat, report that result independently.
