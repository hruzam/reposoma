# How a browser pin became a relay for a living CLI

**Asymmetry → majkee, Codex CLI, Claude Code · 10 November 2026**  
Design history and wake-up note. The earlier conversation record already exists. This document connects its turning points to the project that would receive the work. The sequence below reconstructs the design from saved discussions and repository records. It preserves stated reasons, corrections and open questions.

## Start with the moment we want to change

Imagine majkee debugging an OpenCart page in Firefox. Two order rows have an “Edit” control. He points at the second row and says, “This is the one whose price changes after refresh.” He switches back to Sublime. A fresh CLI receives the note. What would it have to know to find *that order*, inspect what was visible, and tell him if the page has changed since? Copying a screenshot into each new chat loses the identity of the row. Copying a selector loses his reason for marking it. This is a worked example, invented for the handoff.

## The turns worth preserving

| Turn | What changed our minds | Consequence for a builder |
|---|---|---|
| The agent relay came first | Passing text between Claude and Codex made the human responsible for delivery, wake-up and checking the reply. A file could carry an exchange across either session’s lifetime. | Publish a record, address the intended seat, and ask for a return with the same exchange ID. A file becoming available and a recipient reading it are separate events. |
| Sublime already had pins | Majkee could already jump to a file or a position. He wanted to attach a note, collect related notes and hand the set to a working CLI. | Keep the existing pins. A browser selection can contribute to the same note set as an editor pin. Each adapter retains its own way to resolve a location. |
| A moving cursor made us ask what needed building | Seeing an agent operate a browser showed the action but concealed how the target was chosen. Majkee’s optics-bench analogy suggested scanning for edges or extrema. | Ask which measurement distinguishes the two candidate objects. An edge may locate a panel. A domain key can distinguish two identical rows. |
| Majkee corrected my starting assumption | I started from image recognition. He meant that a human might already have supplied the map. | Begin with one named landmark. Discover only the missing part. Compare a fixture key plus a file pointer against the more elaborate navigator. |
| Scrolling exposed three kinds of truth | A normal row moves up as the viewport scrolls down. A fixed header can stay put. An overlay can cover a button while its rectangle stays exactly right. | Keep declared source, measured live layout and rendered evidence distinguishable. Their shared rendering pipeline makes a majority vote misleading. |
| The second CLI changed what “cache” meant | A second session can inherit the *meaning* of a pin after the first closes. Whether the object still exists and where it is now are new questions. | Persist the note and the lookup recipe. Bind the current object within a document generation. Timestamp each measurement and carry its coordinate frame. |
| The compute discussion supplied a hypothesis | Majkee’s interest in spectral methods, locality and small models raised the possibility of explaining a cheap change once instead of inspecting every child again. | Use a deterministic transform as a baseline. Count what work disappears and which errors survive. Explore a learned or distributed alternative only against a workload that exposes a real cost. |

The browser project and the compute project meet at one question: **which parts of an observation can a later reader legitimately reuse?** The useful answer changes by field. The note about an order may still be valid tomorrow. The button’s viewport coordinates can expire during the next animation frame.

## Where this fits on disk

The checked project contract actually describes a note on a file line and the analogous Firefox note anchored to HTML. Termbrana already has an observation/composition boundary. The nearest related work includes the M0 transcript-view bed, a read-only shared observation spine proposal (X5), and a separate native delivery qualification. They ask different questions. A browser pilot can generate an evidence file and demonstrate a fresh reader even when native notification remains unqualified. See [project design §3.1](https://github.com/hruzam/nablarva/blob/f525e558aa5a7186f3cbc4abc60f53f72c37023b/PROJECT-DESIGN.md) and the [session router](https://github.com/hruzam/nablarva/blob/f525e558aa5a7186f3cbc4abc60f53f72c37023b/.dev/session/pulse.md).

**Existing intent:** human-authored pins, named recipients, native CLI sessions, durable exchanges, independent evidence. **Proposal in this packet:** Firefox as the first live producer, a local static reader for simple observation, one shared receipt format. **Still open:** where this editor/browser composition belongs in the live checkout, which existing relay is qualified on the host, and whether caching saves wall time after validation. A managed browser demonstration supplies a fixture result. Qualifying stock Firefox is a separate observation.

## How to continue the conversation cache

After a meaningful correction, add a short entry with the date, question, previous assumption, observation or operator correction, resulting decision, and what would reopen it. Link the evidence or exchange. Preserve superseded entries. Record an untested idea with its cheapest discriminating test. Put project decisions in the checkout’s decision surface and durable lessons about running sessions in its process-observations location. This story can then survive closure of a task bed without becoming a competing copy of its STATUS.

**Wake-up line for another CLI:** Read this story. Explain which identity survives when a row moves, when a node is replaced, and when only yesterday’s HTML is available. Then open [the builder handoff](02-browser-eyes-cli-handoff.md). If your assignment is about saving repeated work, open [the compute brief](03-browser-eyes-cache-compute.md).

### Earlier records

- [Visual navigator discussion and independent research questions](https://chatgpt.com/library?file_id=libfile_97dc7a853064819198989684d9f045b1&account_id=personal)
- [Living-agent tunnel engineering draft](https://chatgpt.com/library?file_id=libfile_47849d0f2a98819186c36263d4d931b3&account_id=personal)
- [Sublime connector and experimental-output handoff](https://chatgpt.com/library?file_id=libfile_8e0a97b651b881918cddf88fbb929ede&account_id=personal)
- [Incremental observer, including the older mathematical and model threads](https://chatgpt.com/library?file_id=libfile_d52103ac2b908191bb7697208cdf813d&account_id=personal)
