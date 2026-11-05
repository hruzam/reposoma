# Knowledge extraction and image retention

myShell · 4 November 2026 · operator request: extract useful thematic knowledge,
prioritize cache methods and both decision trees, separate unproven/crap material,
and delete pictures when they add no necessary evidence.

## Result

- [Cache methods](../cache-methods/README.md): eviction/freshness, the backend-load
  threshold, KV state, AKV and cross-model KV transfer.
- [Decision methods](../decision-methods/README.md): learned decision trees/forests
  and Trinity capability routing, together under one scope as the operator confirmed.
- [Technical knowledge](../technical-knowledge/README.md): six compact thematic
  references and separate unproven/rejected-claim piles.
- [Complete disposition](../technical-knowledge/INDEX.md): 40 useful items, 20 parked
  as unproven, and two noise-only items. Rejected claims from otherwise useful
  items appear separately in the crap note.

The notes state reusable mechanisms, examples and limits. They do not simply
reproduce the screenshots' recommendations. The original 62-item provenance catalog
remains, with a destination and retention status for every reviewed frame.

## Cleanup performed

All 306 original copied files matched the first intake's recorded SHA-256 before
cleanup. Then **197 reviewed technical screenshots** and their 197 derived sorted
symlinks were removed. Ten generated contact sheets and 230 raw OCR files were
also removed: keeping contact sheets would have retained copies of the deleted images.

**Twenty-one reviewed screenshots remain as evidence:**

- TC31 / S191: the cache illustration's exact numbers, including its unverified
  dropped-request count. No original post URL was recovered.
- TC03 / S194: the specific decision-tree illustration and its toy accuracy claim.
- TC17, TC19, TC43, TC44, TC48, TC60 and TC61: nineteen frames whose source or
  content remains unresolved/incomplete, preserving evidence for possible later review.

After the operator confirmed that all images were disposable copies, the other
**88 copied files were also removed**: 56 older screenshots, 17 trashed screenshots,
three non-screenshot images and 12 skipped in-window captures. Their contents were
not promoted into the knowledge notes.

**Final count: 285 copied images removed; 21 evidence images remain**, plus their
21 sorted symlinks. All 21 retained images still match their original hashes.
The phone was not accessed or changed. The private
`disposable-copy-cleanup.json` receipt records the additional 88 deletions;
the historical inventory preserves the original 306-file intake count.

Image/OCR directories remain Git-ignored. `items.json` retains source filenames and
hashes and records `removed-after-extraction` or `retained-evidence`; this is a
provenance record, not a claim that the deleted file is still available.
The private cleanup receipt lists exact files. The gallery and catalog were rebuilt
to avoid linking to deleted images.

## Re-entry

Read the extracted notes. Use `review.py render --intake 2026-11-03` to rebuild the
surviving evidence view and catalog. Do not rescan this reduced intake: its original
inventory is historical evidence, and the helper now refuses that operation.
New intakes can still be scanned normally. No commit or push was performed.
