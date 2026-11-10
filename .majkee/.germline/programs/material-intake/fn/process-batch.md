---
program: material-intake
function: process-batch
revision: 2026-11-05
stamp: 96b1e7ac
title: process-batch
scope: material-intake
kind: procedure
updated: '2026-11-05'
---

# process-batch

Inputs, output homes, model limits, consultant binding and cleanup authority come
from the controller. This function grants no capability beyond that task. Carry out
the sequence by hand with available file, image, browsing and native-agent tools.

## 1. Resolve the batch and checkpoint

Read the governing AGENTS chain, checked controller/function binding and original
operator request. Resolve paths, ownership, date/timezone, priorities, window and
disposable-copy authority. Use the whole named batch when no window was supplied.
Honor narrower live effect limits before creating any file: review-only means a
read-only report; retain-all/no-deletion omits cleanup while authorized notes can proceed.
Do not traverse symlink targets outside the batch or recursively expand into sibling
folders. Report non-image files without executing or deleting them.

Create/verify the working home's `media/` and `private/` ignore rules **before**
generating derivatives. A batch supplied elsewhere needs its own verified ignore
coverage; never make an external original disappear just to fit the preferred layout.

If the batch already has a receipt/inventory, re-enter it instead of reinitializing.
Check completed claims against current notes and files. Record changed/new files as
a delta; do not overwrite the original inventory or silently reuse a changed filename.
Resume the first incomplete or contradicted stage. After completed cleanup, missing
files are expected only where a recorded deletion explains them.

## 2. Inventory and visual triage

Inventory all direct inputs with stable batch/file IDs, relative paths, sizes,
SHA-256 and decode status. Keep full names and metadata private. Use hash equality
for exact duplicates; visually similar frames still need content grouping.
Use filename/EXIF dates as attributed metadata, not assumed facts; mtime fallback
must be labeled. A generic photo need not contain `Screenshot_` or a parsable date.

Inspect contact sheets locally, then open originals when text or meaning is unclear.
OCR is an optional local aid and must be checked against the image. A tool/helper
that only selects dated screenshots is insufficient for a general-photo batch.
The old `projects/technical-clippings/review.py` may assist compatible screenshot
intakes, but its schema, filtering and reduced-intake guard must be respected.
Do not execute its old dated examples against a new mixed batch blindly.

Give every input an explicit disposition: technical group, duplicate-of, personal,
meme/unrelated, outside requested window, or unreadable/unresolved. Do not research
personal material. Keep ambiguous content unresolved rather than inventing its text.
Checkpoint inventory and grouped IDs before research.

## 3. Research and assess through the bounded worker

Resolve one permitted worker binding from the controller. Send only the assigned
group IDs, relevant image paths/excerpts, research question, priorities, output
contract and authority. Brief it read-only: it is not alone in the workspace and
must not edit, delete or revert anyone's work. No delegation or installation.
Do not send the entire conversation when the compact task suffices.

Ask it to return, per group:

- captured claim, readable source identity and uncertainty;
- checked primary URLs, check date, directly supported facts and limits;
- assessment: what is reusable, what remains unproven, and which exact claim is
  misleading or low-value; separate the paper/tool from the hype around it;
- proposed knowledge text, theme/slug, priority and a bounded possible next use;
- image IDs that still provide necessary evidence, with reasons;
- unresolved questions and an explicit list of anything it could not inspect.

Prioritized subjects get deeper checks. Other subjects can receive concise notes
or a parked pointer; do not start an exhaustive research program. If an exact
primary source cannot be established, mark it unproven and retain necessary visual
evidence. Do not guess source URLs or convert search snippets into verified facts.

myShell checks consequential claims against the cited artifact/page. A worker's
report is a lead until its evidence is checked. If a concrete unresolved question
justifies Sol/medium, record why and limit the follow-up to that question. A missing
model/tool/source holds that part only; finish independent work and label the gap.

## 4. Consult only when useful

When an uncertainty materially affects the extraction or cleanup design, select
at most one consultant using the controller's slot. On a Terra-level head, use
Astrobley for programmatic questions rather than letting a weak implementation
assumption pass unchecked. Use Oraculum for a conceptual/scientific interpretation
that genuinely needs counsel. No ceremonial call is required for an uncomplicated batch.

Give the consultant the bounded question, checked evidence, competing readings,
allowed scope (read-only advice) and expected return. Preserve its role contract:
Astrobley returns an `implementation_return`, including `changed: none` for advice;
Oraculum remains a bounded analysis-only child with its own entry checks. A member
may suggest a further question but cannot dispatch another agent.

Record the advice and myShell's integration decision. Advice is neither independent
source verification nor authority to lock canon. The consultant does not acquire
the receipt, final-note or deletion pen. Do not create a replacement merely because
an earlier consultation finished; reuse only when actually available and batch-bound.

## 5. Extract knowledge and dispositions

Write concise Markdown under explicit subject slugs in the approved output root.
Read selected destinations first and preserve unrelated work. Extend a clearly
matching note rather than creating a competing copy. No project search/attachment.

Require the controller's leading YAML frontmatter on authored Markdown: `title`,
`scope`, `kind` and `updated`. Preserve existing metadata, body and ownership.
Only actual source verification advances `verified`; extraction or copying alone
does not. Ensure any catalog/receipt generator preserves this frontmatter on rerun.

Extract the mechanism, when it applies, a useful example or comparison, limits and
primary sources. Distinguish reported experimental results from reproduced results
and myShell's own derivations. Group related frames into a single knowledge item.
Do not merely preserve a screenshot's marketing text as a recommendation.

Assign each group one primary pile: **useful**, **unproven**, or **crap/rejected/noise**.
“Unproven” can describe real products with unevaluated fit; it does not mean false.
A rejected claim from a useful item can also be documented separately in the crap
note, with its reason. Label editorial relevance judgments as such.

Write the technical item index with group ID, pile, exact note path, provenance
reference, evidence status, priority and proposed next use. Keep all private/excluded
content out. Record picture-retention decisions separately from epistemic status.
Backlog inclusion is not a new task; no automatic installation or experiment follows.
Checkpoint extracted notes and checked source links before preparing deletion.

## 6. Clean disposable copies

myShell performs this stage. For every image decide retain/remove and record why.
Retain an image when it supplies source evidence, an unresolved visual question or
an essential example that the extracted note and primary source do not replace.
“Unproven” does not require keeping every redundant frame. Prefer one sufficient
copy when hashes or near-duplicate frames repeat the evidence.

Before deleting anything:

1. Verify deletion authority for this exact batch. A designated copy-only inbox
   invocation already grants it, including personal/meme/out-of-window copies.
2. Check that every input has a disposition and each technical group has its note
   or explicit unresolved record. Never delete the only evidence of an unresolved
   claim unless its deliberate discard and reason are recorded.
3. Save the exact path/hash deletion plan and retained-file reasons privately.
   Use separate explicit allowlists: source copies must remain inside the named
   batch; generated derivatives must remain inside the recorded batch-specific
   private/preview/sorted roots. Record each allowed derivative root and its relation
   to this batch; never infer authority over a shared cache or sibling batch.
   Verify current hashes match the plan. Changed/unlisted files are not deletion
   candidates. Never follow a symlink to delete its target; derived link cleanup
   removes the link itself only.
4. Verify retained images and knowledge files exist. Then remove only planned
   copies and generated derivatives within the declared working scope.

Remove contact sheets, extracted crops, cached previews, stale sorted symlinks and
raw OCR that would unnecessarily preserve discarded/private material. Preserve
the historical inventory and enough provenance to explain each deletion. Record
actual results per file; a prepared plan is not a completion receipt. If interrupted,
reconcile file presence and completed entries before retrying; do not infer success
from absence alone or repeat deletion by a broad filename glob.

For a planned file that is already absent without a completed deletion entry,
record **planned-missing/unverified** with the plan reference and current observation.
Do not claim a verified deletion or recreate the file to retry. Carry this as a
held accounting outcome until reliable existing execution evidence resolves it;
without that evidence, return the uncertainty in the receipt. Continue independent
work. The accounting check counts such a file once under held, not removed.

Refresh indexes/galleries to show removed frames as removed, retaining provenance
without broken image links. Do not rescan a reduced folder over its original inventory.

## 7. Verify and return

Verify file accounting: input count equals retained plus removed plus explicitly
untouched/held. Confirm every technical group has exactly one primary disposition
and an existing destination or unresolved record; compare representative extractions
with source evidence. Check all local links, retained hashes and actual cleanup results.
Confirm no broken derived links or unwanted preview copies remain, and verify raw
media/private outputs are ignored and not already tracked. If an input was tracked,
report it rather than silently changing the index or rewriting Git history.

Finish `receipt.md` with batch/request, checked program/function stamps, original
count, group counts, priority entry points, stage completion/holds, source-check
limits, worker/consultant bindings and remaining next pointer if any. No personal
filenames or transcript dump. Keep the exact deletion log private.

The receipt and thematic indexes follow the same Markdown metadata minimum;
validate their YAML mapping as part of the final checks.

Return the knowledge entry links and retained/removed/held counts. State what was
actually verified and what remains uncertain. No commit, push, deployment or schedule.

Done when notes and evidence are usable, every input is accounted for, authorized
cleanup has its verified receipt, and remaining holds are explicit. Depositing a
new batch or changing the date never resumes this batch automatically.
