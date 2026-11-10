# Visual navigator cache | CLI builder handoff

**Outcome.** Pin a control from one CLI, change its location, and have a fresh CLI process point to the same logical control without asking majkee to identify it again. Demonstrate the same identity rule with a tmux pane. The agent calls ordinary shell commands. The proof must also run from a shell without a vendor account.

## Start in the existing checkout

Read the checkout's AGENTS.md. Search tracked paths and local drafts for ommat*, termbrana and incremental-observer. Reuse any existing navigator, observer, fixtures, bus and identity conventions. Report the paths actually found. The command names below are proposed public behavior, not claims about existing commands.

The related [incremental-observer handoff](https://chatgpt.com/library?file_id=libfile_d52103ac2b908191bb7697208cdf813d&account_id=personal) already specifies synthetic replay (P0), a controlled browser (P1) and multiple readers (P2). This delivery adds durable pins, fresh-process navigation and a tmux adapter. Exercise the cache against its synthetic fixtures if present, then use the browser fixture and two short-lived clients for the end-to-end proof. Keep that project's resource limits when integrating there. This packet can also run against a small local fixture independently.

**Default implementation.** Python CLI and a small, long-lived local owner for the browser, a JavaScript page reader, and the tmux CLI on Linux. A single local Unix socket is sufficient for clients to reach the owner. Use an existing implementation language and transport when appropriate. Use Playwright-managed Firefox for the first browser run or document the managed browser available in the checkout. A single owner must keep the same tab alive when a CLI process exits. Daily Firefox profile attachment and platform-wide mouse control are separate integrations.

## 1. Give each kind of memory a lifetime

| Record | Store | Validity |
|---|---|---|
| Named pin | Persist project, surface scope, logical name, locator recipe or manual landmark, and optional user note | Survives client and owner restarts. Re-resolve uniquely on the intended page. |
| Live binding | Owner and surface generation, runtime instance ID, pin association | Retire on document replacement, target destruction or owner restart. A stable application key may resolve the same logical browser control to a new DOM instance. |
| Observation | Generation, revision, capture time, bounds, coordinate units, and source | Invalidate when relevant geometry or state changes. Label a calculated position as predicted until measured. |
| Route or image | Optional guarded steps to reach the pin, or a crop with its revision | Recheck a route's preconditions. Keep visual evidence scoped to the fixture and capture it on a mismatch or explicit request. |

For a new prototype, use one small SQLite database for pins and keep bindings in owner memory. Write pin updates transactionally with a unique project/name key. Start a new owner generation at each launch. Identify each tab and document separately. Publish generation and revision together. Serialize pointer actions in the owner. A cache hit reuses knowledge of *what to look for*. It gives no guarantee about today's coordinates.

## 2. Expose a shell contract

Ship actual equivalents of the following examples. Use structured JSON on stdout, diagnostics on stderr and nonzero exit status on failure.

| Operation | Example invocation | Expected behavior |
|---|---|---|
| Explore | `nav explore --surface checkout` | List scoped candidate objects, labels, instance IDs and measured bounds. Support one human-authored map as an initial input. |
| Pin | `nav pin checkout.save --surface checkout --key save-order` | Store a unique fixture key scoped to this page and form. A selection by pointer can feed the same operation. |
| Resolve | `nav resolve checkout.save` | Report identity, generation, revision, bounds, units and observation source. Leave the pointer and scroll position unchanged. An offscreen element can still resolve. |
| Point | `nav point checkout.save` | Resolve, scroll into view if necessary, remeasure, hit-test a usable point, move the browser pointer, then report the observed recipient. |
| Bind a pane | `nav pin build-output --server RUN_SOCKET --pane %7` | Associate a human name with a live fixture server generation and pane ID. |
| Read a pane | `nav resolve build-output` and `nav read build-output` | Return the pane's current window and cell bounds, then its text when requested. |
| Inspect | `nav status --json` | Return the owner generation, map revision, discoveries, resolutions, measurements, pointer moves and clicks. |

Report missing, ambiguous, blocked and stale cases explicitly. Do not pick the nearest of two matching controls. Point and click are separate operations. Pointing must emit zero clicks. For this proof the observable pointer is the browser page pointer.

Example success payload:

```json
{"pin":"checkout.save","surface":"checkout","generation":"owner-A/doc-1","revision":8,"binding":"node-7","space":"viewport-css-px","point":[180,220],"outcome":"pointed","recipientKey":"save-order"}
```

## 3. First working browser slice

1. Serve a loopback fixture with a long form, a keyed Save button, and a second button named Save elsewhere. Include a fixed header and controls to insert a banner, cover the target, duplicate its identity, and replace its DOM node. Have the fixture record actual pointer and click events for the independent verifier.
2. Let a builder supply one known manual landmark with a name, coordinates, units, viewport and expected target. Compare its predicted point with browser geometry and hit testing. For an unknown surface, discovery enumerates candidates. For a known pin, use its scoped locator directly.
3. For ordinary scroll in one unchanged frame, calculate `newViewportY = oldViewportY - actualScrollDelta`. Use the measured scroll delta. Fixed and sticky elements, nested containers and reflow need their own measurement. Use `getBoundingClientRect()` for the target's current rectangle in viewport CSS pixels. Use the same units for browser pointer input.
4. Treat scroll, resize, and relevant DOM mutations as reasons to refresh affected state. A dropped event must not turn an old rectangle into a current observation. At execution time validate surface, target identity, enabled state and a point inside the visible region. Use `elementFromPoint()` and accept the intended element or its descendant. Report a fully covered target as blocked. React to a target changing again during the move by reporting the observed mismatch.
5. Keep the fixture's declared intent, live DOM measurement, and visual evidence distinguishable. A screenshot can show an overlap while a button remains present in the DOM. Timestamp evidence. Keep the independent fixture event log outside the mapper's read path.
6. Start a new CLI client without inherited in-process state and resolve the stored pin against the still-running owner. Separately restart the owner, reopen the fixture and prove that the recipe survives while the live binding is recreated.

## 4. tmux slice

Create a disposable server with a unique per-run socket name. Bind `build-output` explicitly to one live pane. Capture server generation, session/window/pane IDs and pane bounds in **terminal cells**. Place a distinctive fixture marker in that pane. Resize or swap panes. Another CLI process must read the marker from the same pane ID at its new location.

```sh
tmux -L "$run_socket" list-panes -a -F '#{session_id} #{window_id} #{pane_id} #{pane_left} #{pane_top} #{pane_width} #{pane_height}'
tmux -L "$run_socket" capture-pane -p -t "$fixture_pane"
```

A tmux server incarnation can be tagged by a random nonce set by the fixture owner at startup. A socket path alone is insufficient. On server restart or pane death, expire its binding. Require an explicit new pane association even if a number is recycled. Tear down only the server created for the run.

A tmux window, terminal emulator tab and desktop window have different owners. Reading an offscreen pane needs only tmux. To report a desktop point would also require identifying the attached client, visible tab, content origin, cell metrics and scaling. Return unsupported for that projection until measured. A future native adapter can supply AT-SPI roles and window-relative bounds. Local geometry can refresh on events while the agent receives only relevant changes. Continuous screenshots are unnecessary for this milestone.

## 5. Delivery to majkee

Return checkout revision, touched paths, actual setup/start/stop commands, versions, fixture command, result JSON and the independent evidence directory. Report cold versus warm discoveries, measurements, pointer recipients and failures. Record any unsupported cases. An observed inability to run one adapter is a partial result. Use the existing bus convention where present: the record carries the exchange ID, the terminal receives its path, and the consumer acknowledges the same ID.

The companion file `visual-navigator-verifier.md` specifies acceptance. Source boundaries and reference APIs:

- [Playwright locators](https://playwright.dev/python/docs/locators) and [actionability](https://playwright.dev/docs/actionability).
- [Viewport geometry](https://developer.mozilla.org/en-US/docs/Web/API/Element/getBoundingClientRect) and [pointer hit testing](https://developer.mozilla.org/en-US/docs/Web/API/Document/elementFromPoint).
- [tmux manual](https://man.openbsd.org/tmux.1) and [AT-SPI accessible objects](https://gnome.pages.gitlab.gnome.org/at-spi2-core/libatspi/class.Accessible.html).
