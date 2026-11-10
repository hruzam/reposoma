# Extend the .dev/ workflow with Firefox eyes and an addressed relay

**Builder and verifier handoff · 10 November 2026 · candidate design**  
Deliver one developer loop on a local fixture. Majkee marks an order row in Firefox, writes a note, selects a CLI seat and carries on working. A fresh CLI reads the correct note and returns either a fresh resolution of the same logical row or the precise reason it cannot resolve it. The smallest useful standalone result is a readable note plus an independently verified receipt.

## Enter the existing framework

Reference checkout: hruzam/nablarva, core at f525e558aa5a7186f3cbc4abc60f53f72c37023b. Reconcile with the executing host. Record its actual revision and dirty-path boundaries. Follow AGENTS.md → .dev/session/flag.md → .dev/session/pulse.md → PROJECT.yaml, then PROJECT-DESIGN.md §3.1 and toolbox/termbrana/README.md. Use the router to find the owning STATUS.md. The M0 markdown test concerns transcript views. X5 concerns a shared read-only spine. The pipe-qualification bed concerns delivery to an already-running agent. Read their current checkpoints before depending on them. The inspected X5 checkpoint describes a planned slice, and the pipe checkpoint distinguishes offline evidence from native delivery. [Checkout](https://github.com/hruzam/nablarva/tree/f525e558aa5a7186f3cbc4abc60f53f72c37023b)

First return a short inventory: actual paths and versions for existing pin, composer, session address, bus writer, observation reader and fixture. Mark each found, planned or absent. If a mechanism already carries the payload faithfully, wrap its public entry point. Put an isolated candidate in an appropriate session bed under local conventions. Keep the runbook and evidence there, STATUS as its single doing-state, and pulse as the router. The Rust/WASM Zellij probe and the zsh/Python composition work have distinct owners. An adapter can produce a file without extending either runtime. This brief proposes no canon change.

## Give the box three jobs with observable boundaries

| Job | Input → output | Proof |
|---|---|---|
| Eyes | Explicit operator selection → pin, note, scoped observation | Two rows share the same label. The fixture independently identifies the selected row. |
| Relay | A published pin/note reference + intended seat → addressed exchange → recipient return | A new CLI process reads the file and echoes the exchange ID, pin ID, note and seat. Qualify a native wake separately on a locally qualified route. |
| Resolver | Durable pin recipe + available source → fresh observation or typed limitation | After reordering or replacing rows it resolves the same business key. After removal it says missing. |

Keep source and recipient independent. A tab address identifies where evidence came from. A CLI seat identifies who should receive it. A logical pin can outlive both. The browser has no need to know which model reads the note.

### Two producers, deliberately different capabilities

| Adapter | First implementation | What its receipt can claim |
|---|---|---|
| Stock Firefox | In a disposable stock Firefox profile, use an explicit extension action to enter pin mode on a loopback page. On selection collect a scoped key, short text excerpt and current bounds. Show the note and intended seat for submission. The extension background can communicate with a local native messaging host; a short local bridge can publish through the existing writer. Qualify exact browser version, extension ID, host registration, user gesture and reconnection locally. | Live DOM measurement for the identified top-level document, in viewport CSS pixels. A focus change must never silently redirect the request. Loss of access returns unavailable. |
| Built-in simple observer | Read an explicitly supplied local HTML file with the project runtime’s HTML parser. Emit semantic matches for a restricted recipe such as form ID + order key + action. Record source digest. Reuse the exact same file reader to replay a saved observation envelope as historical evidence. | Static markup match, or recorded evidence at capture time. Advertise live DOM, layout, hit testing, pointer and screenshots as unsupported. A lightweight implementation needs no embedded browser engine for this job. |

If only a managed browser is available, use it to exercise the fixture and label the result accordingly. Playwright uses a patched Firefox. To claim the operator’s Firefox works, reproduce the pin in stock Firefox and record the exact build. The architect can revisit an embedded renderer when a specific workflow requires local layout or JavaScript and existing Firefox cannot serve it. [Playwright browser support](https://playwright.dev/docs/browsers#firefox) · [Mozilla tab permissions](https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/manifest.json/permissions#activetab_permission) · [Mozilla native messaging](https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/Native_messaging)

## Minimal wire example

Illustrative JSON carried by an existing exchange or referenced from its Markdown POINT. Map names to the local schema. The observation is immutable for this exchange. Its digest or immutable reference must still select this exact capture after the durable pin is edited.

```json
{
  "schema": 1,
  "exchange_id": "trial-17",
  "to": "fixture-seat-b",
  "pin": {
    "id": "order-price",
    "scope": "fixture/orders",
    "recipe": {"form": "orders", "order_key": "B", "action": "edit-price"},
    "note": "Check why this price changes after refresh."
  },
  "observation": {
    "source": "firefox-live",
    "surface": "tab-4",
    "generation": "owner-2/doc-7",
    "revision": 12,
    "captured_at": "2026-11-10T10:15:00Z",
    "bounds": [48, 180, 96, 24],
    "space": "viewport-css-px",
    "bounds_format": "left,top,width,height"
  }
}
```

A new RETURN cites trial-17, the seat that consumed it, the pin identity, its receipt status and the *new* observation or failure. Receipt and successful resolution are separate fields. Multiple pins can later be sent as an ordered list of immutable pin revisions under one theme. One pin is enough to qualify routing. Put page excerpts in data fields and keep them separate from operator instructions.

### Proposed shell behavior

```sh
eyes capabilities --source firefox
eyes observe --source html-file --file fixture/orders.html --pin order-price
eyes resolve --source firefox --pin order-price
relay publish --to fixture-seat-b --record selection.json
relay read --seat fixture-seat-b --exchange trial-17
```

These names specify behavior for builders. Report the real commands. Use JSON stdout, diagnostics on stderr, defined failure exits and bounded deadlines. Read/resolve leave focus, pointer and scroll alone. Derive coordinates only from a declared source and frame. Return missing, ambiguous, stale, unsupported or unavailable distinctly. If pointing is separately implemented, use the prior navigator contract and fixture event log. A read-only proof requires zero pointer movement and zero clicks by the resolver.

### Publication, restart and delivery

Finish writing evidence before publishing its reference. Use the existing bus writer or a same-filesystem atomic publication with a collision check. Give each writer its own return artifact. Treat a repeated exchange ID with identical payload as a retry; reject conflicting content. Keep addressed files available across client exit. On reconnect use a fresh document binding and the original logical recipe. An already published exchange is sufficient for a recipient to recover its note when Firefox is closed. Report live resolution as unavailable then.

Publish → consume by explicit address → write correlated RETURN is testable with two shell processes. A qualified doorbell may subsequently wake a running native CLI with the file pointer. Preserve the route’s local prerequisites and record consumption independently. If unavailable, label the result **file relay passed / native wake unverified**. A screenshot of an active terminal cannot establish receipt. A static snapshot cannot acknowledge delivery.

## Independent acceptance on the normal entry points

1. Serve a long local orders page with two identically labelled actions in rows A and B. Give the verifier an independent fixture log and a way to reorder, replace, remove or duplicate rows and insert a banner. Preserve original HTML as the static fixture.
2. From stock Firefox select B, attach a distinctive note, address seat B and publish. Close the producer client. Start a receiver with only seat identity, exchange reference and the documented adapter connection. Inspect the actual RETURN and the fixture’s independent selection log.
3. Switch foreground tabs and reorder the orders. Re-resolve. Expect the original business key B at its new position, or an explicit unavailable result if the grant expired. Those outcomes are scored separately. Replace its DOM node with the same key and confirm a new binding. Duplicate the key and expect ambiguous. Remove it and expect missing.
4. Have the static reader inspect the original file after the live DOM changes. Verify the digest and original source match. Request current on-screen coordinates and require unsupported. Close Firefox and replay the note. The receiver can read it without inventing a live result.
5. Retry publication and simulate interruption before the final publish. A reader sees either a complete exchange or no exchange. A duplicate notification produces one logical receipt. With two seats and similar notes, verify recipient and exchange IDs never cross.
6. Return revision, versions, reproducible commands, actual source and destination, fixture cases with pass/fail/blocked, paths to independent evidence, unsupported capabilities and the smallest next change. Score static read, stock Firefox capture, fresh live resolution, file receipt and native wake separately.

**Activation:** Read the design story and this handoff. Inventory the checkout. Build the smallest missing end-to-end link on the two-row fixture. Return one exchange and its independently checked receipt. Before adding another service, show which acceptance case the current tools cannot pass.

[Prior browser/tmux builder](https://chatgpt.com/library?file_id=libfile_7fb80fa3b98c8191895a07e5559ed0fd&account_id=personal) · [Independent navigator verifier](https://chatgpt.com/library?file_id=libfile_320451dc056081918bcd4c8b6ab8bb18&account_id=personal)
