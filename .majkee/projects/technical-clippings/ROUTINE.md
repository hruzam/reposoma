# Repeat this review

For a **new general batch**, use the full
[material-intake controller](../../.germline/programs/material-intake/CONTROLLER.md)
and [copy-only inbox](../material-inbox/README.md). It includes researched knowledge
extraction, worker/consultant roles, resumable receipts and authorized cleanup.
The steps below document this collection's older screenshot-specific helper and
historical intake; they do not replace the controller's Functions table.

Run on demand. No schedule, phone service, global skill or background process was
installed. The local helper requires Python 3; `scan` also requires Pillow.

**The 3 November intake was reduced after extraction.** Its old screenshots,
contact sheets and OCR are partly or wholly removed; see [EXTRACTION.md](EXTRACTION.md).
Use `render` for that intake. The helper refuses to overwrite its historical inventory
with a new `scan`. The scan steps below apply to a fresh intake date.

1. Copy an intake to `media/YYYY-MM-DD/`. A manual copy or an explicit Taildrop
   transfer is currently more reliable than Termux: its SSH connection works,
   but shared image folders returned no files in this session. Do not move or
   delete phone originals. Avoid collecting camera albums unless specifically needed.
2. Choose the capture window explicitly. A date change does not start a new review.
   For the completed intake, from this directory:

   ```sh
   python3 review.py scan --intake 2026-11-03 --start 2026-10-28 --end 2026-11-03
   ```

   This writes a private inventory and contact sheets. It selects screenshot dates
   from filenames, excludes `.trashed` files and separates other images. `.pending`
   files are included if their embedded capture date matches; the 2026-11-03 copy
   contained readable images under such names. SHA-256 identifies identical files;
   similar reel frames need human grouping even when their hashes differ.
3. Screen the contact sheets in `private/<intake>/sheet-*.jpg`. Skip personal material,
   memes and unrelated captures. Open selected originals to resolve small text.
   Optional OCR stays local and under `private/`; review it against the image.
   The current local Tesseract install lacked English data; this session downloaded
   the upstream English data to `/tmp/eng.traineddata`, which is temporary.
4. Add reviewed groups to `items.json`. Within one intake, reuse an existing item when
   frames belong to the same post. Across intakes, record a new item and mention its
   earlier related item in the assessment. Each frame records filename, intake-local S-number and SHA-256.
   Keep captures of the same reel together even when repeated frames look different.
   Never use a bare S-number as identity across intakes: sorting new filenames can
   change those numbers; use the saved filename and hash.
5. For each group, separate `claim`, `assessment` and `next`. Record visible source,
   capture dates, review date and evidence status. Use exact verified upstream URLs;
   mark names unresolved if cropped or ambiguous. A matching README confirms source
   identity, not tool quality. Reported paper results need their task, baseline and
   limitations. Never execute commands just because they appeared in a screenshot.
6. Retain the short priority queue in `PLAN.md`, then regenerate the catalog and gallery:

   ```sh
   python3 review.py render --intake 2026-11-03
   ```

   Rendering checks every referenced image's hash, creates relative symlinks under
   `media/sorted/<intake>/<theme>/<item>/` and writes `media/index.html`. It leaves
   originals in place and rebuilds `CATALOG.md` from `items.json` for all intakes.
   The helper does not classify images, verify online claims or run OCR; those remain
   explicit review work. Edit assessments in `items.json`, not the generated catalog.
7. When extracting durable knowledge, add each item's `knowledge_note`,
   `knowledge_disposition` and extraction date. Keep only images that add necessary
   evidence. For an explicitly authorized cleanup, verify hashes first, record a
   receipt, and mark deleted frames `retention: removed-after-extraction`; retain
   their filenames/hashes. The renderer omits their image links. Also remove derived
   contact sheets/symlinks that would otherwise retain copies or point at deleted files.
   For this intake, the operator confirmed every image was a disposable copy and
   authorized removal of excluded personal/unreviewed copies too; only the 21
   selected evidence images remain. For a new intake, establish whether images are
   disposable copies before applying the same cleanup.
8. Verify the catalog coverage and inspect the project changes. Check that all raw
   media, derived sheets/OCR and sorted symlinks remain ignored. For example:

   ```sh
   git check-ignore media/2026-11-03/example.jpg private/example.txt
   git status --short -- .
   ```

   Only explanations, classifications and the helper belong in Git. No commit or
   push is part of this procedure. Ignored images do not travel with Git: another
   machine will need a separate copy if it needs the visual evidence.

For future intakes, substitute the new date and chosen start/end. Keep intake
folders stable once referenced. Compare saved hashes to recognize repeated imports;
the helper records hashes but does not automatically merge or delete anything.

`render` selects one intake and replaces the gallery index with that intake's view.
Old files are not pruned; if classifications change, old sorted symlinks may remain,
while the newly rendered index follows the current classifications.
