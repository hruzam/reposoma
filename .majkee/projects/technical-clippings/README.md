---
title: Technical clippings
scope: technical-clippings
kind: backlog-index
updated: '2026-11-05'
---

# Technical clippings

REDMI15 technical screenshot collection, reviewed by **myShell on 3 November 2026**.
Personal working material; not canon. The intake and thematic review are complete.

**4 November extraction:** start with [cache methods](../cache-methods/README.md),
[decision methods](../decision-methods/README.md), or the broader
[knowledge tree](../technical-knowledge/README.md). The [cleanup receipt](EXTRACTION.md)
records 285 copied images removed and 21 retained as evidence. This includes the
88 excluded/skipped copies, removed after the operator confirmed all were disposable
copies. The table below describes the original intake.

The first review's [assessment and next actions](PLAN.md) is historical; use the
[searchable catalog](CATALOG.md) for individual claims and evidence.
For pictures, open the [local visual gallery](media/index.html) or browse
[themed image folders](media/sorted/2026-11-03/).

## Intake receipt

The operator copied **306 files** into `media/2026-11-03/`. The review window is
**28 October–3 November 2026**, Europe/Prague, using capture dates in filenames.

| Disposition | Files |
|---|---:|
| Relevant in-window frames, grouped into 62 items | 218 |
| In-window personal/unrelated/meme captures skipped | 12 |
| Older screenshots outside the window | 56 |
| Trashed screenshots excluded | 17 |
| Non-screenshot images excluded without opening | 3 |
| Total | 306 |

All 230 in-window candidates were visually screened. English OCR was performed
locally as a reading aid, with selected full-size image inspection. Dim and incomplete
material is explicitly marked unresolved. There were no byte-identical duplicates;
repeated reel frames were grouped by content instead.

| Theme | Items | Frames |
|---|---:|---:|
| AI foundations | 3 | 18 |
| AI research | 7 | 16 |
| AI workflows | 12 | 24 |
| Developer learning | 17 | 44 |
| Defensive security | 8 | 37 |
| Security tools | 6 | 55 |
| Security learning | 1 | 13 |
| Creative tools | 3 | 6 |
| Other technical references | 5 | 5 |

Each item records a captured claim, an assessment, evidence status, suggested next
step, source identity, dates and links to its frames. `source-confirmed` means a
matching primary page was read; it does not mean independently reproduced or tested.
The evidence status varies by item; this was not an audit of every named tool.

## Reuse and storage

- [ROUTINE.md](ROUTINE.md) describes the on-demand workflow and exact helper commands.
- [items.json](items.json) is the editable classification and assessment source.
- [review.py](review.py) builds inventories/contact sheets and regenerates the catalog,
  themed relative symlinks and local gallery. It does not classify or fact-check.
- `media/` holds originals, the gallery and sorted views. `private/` holds the full
  inventory, skipped-file references, contact sheets and raw OCR. Both are Git-ignored.

Surviving copied files remain in their intake folder; thematic folders use symlinks.
Reviewed images marked removed were deleted after extraction on 4 November.
No phone image was changed. No screenshot
or personal photo was uploaded for OCR or tool testing. Public web lookups checked
selected sources. No suggested tool was installed and no security scan was run.
No commit, push or automatic schedule was created.

Surviving image evidence is local-only and does not sync through Git. Explanations
and classifications remain usable without the images; copy surviving media separately
if another machine needs the visual evidence. Deleted files are not recoverable
from this collection; source hashes remain as provenance.

## Access note

Tailscale/SSH key authentication to REDMI15 worked at `100.105.201.3:8022`.
Android nevertheless returned empty image-folder listings after permission changes
and a Termux restart. `termux-setup-storage` created the normal storage shortcuts,
but did not resolve visibility. The cause remains unresolved. Manual copying
unblocked this review; phone-access troubleshooting is not part of the reuse routine.
