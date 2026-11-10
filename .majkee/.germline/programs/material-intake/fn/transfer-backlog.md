---
program: material-intake
function: transfer-backlog
revision: 2026-11-05
stamp: 1f4a8c62
title: transfer-backlog
scope: material-intake
kind: procedure
updated: '2026-11-05'
---

# transfer-backlog

Place one explicitly selected knowledge slug from myShell's backlog under a named
project's `.dev/_back-log/`, preserving the slug. Default operation is **copy**:
source knowledge remains available. Adding this function does not select a target
project or perform a transfer.

## Inputs and authority

Required: source slug/path below `.majkee/projects/`, explicitly named target
project/root, current actor/date/timezone, and authority to place the material in
that target. Example prompt (never a shell command):

```text
ctrl material-intake&transfer-backlog :
source: projects/decision-methods;
project: nablarva;
mode: copy
```

The result is `<resolved-project-root>/.dev/_back-log/decision-methods/`.
This invocation authorizes only the selected transfer and its provenance records;
it does not authorize project implementation, canon changes, commits or push.
Honor narrower live instructions, including a read-only preview. A source-removing
move is outside this function; do not infer it from “transfer.”

## 1. Resolve the source and target

Read the governing AGENTS chain, checked controller/function binding and selected
source README. Resolve the exact source; require a single directory slug, no path
traversal or symlink escape. Do not search other projects for a matching subject.

Enter the explicitly named project through the declared read-only
`project-saddle&saddle-project` procedure and its current maintained routing. Read
the target's mandatory instructions and intervening AGENTS through the destination
parents. An unsupported alias, missing route or conflicting target instruction
holds target writes; report the exact gap without guessing, extending the shortlist
or creating a new project harness. Reading grants no ownership of its live session.

Confirm that the project permits `.dev/_back-log/` and accepts personal backlog
material there. Its schema, ownership and promotion gates prevail. Resolve actual
target paths; a writable-root restriction still needs the runtime's normal escalation
before an actual write outside the allowed sandbox. The controller grants no bypass.

## 2. Prepare the same-slug package

Destination is exactly `<project-root>/.dev/_back-log/<source-basename>/`.
Inventory the selected Markdown tree and explicitly required supporting files.
Preserve relative subdirectories and filenames. Do not automatically carry `media/`,
`private/`, raw OCR, caches, `.git/` or runtime instructions. No executable is run
merely because it belongs to the source bundle. Copy evidence images only when
separately requested and target ignore coverage is verified first.

Check local links before copying. Internal links within the selected tree should
remain relative. A link to another source slug is a dependency, not permission to
copy that slug too. If that companion already exists at the destination, verify
it before relinking. Otherwise retain an explicit link to the original source file
and record the external dependency in the destination README. Preserve fragments;
do not leave a relative link accidentally pointing into an unrelated target folder.
Report that host-local absolute source links need adaptation on another machine.

If the destination slug already exists, compare it rather than overwriting it.
An already matching import is a no-op; do not append duplicate transfer records or
advance dates merely for a repeated invocation. A differing tree needs an explicitly
authorized merge/replace decision; preserve both sides while reporting the collision.
For comparison, distinguish known transfer metadata/link rewrites from changed
knowledge content. Never discard a real source edit as metadata noise.

## 3. Require Markdown frontmatter

Use valid YAML frontmatter at the beginning of authored/transferred Markdown:

```yaml
---
title: Decision methods
scope: decision-methods
kind: knowledge-note
updated: YYYY-MM-DD
---
```

This is the local backlog minimum, inspired by typed metadata in `raw.settings`
and `raw.guides`; it does not copy their unrelated card/canon schemas. `kind` should
describe the file: e.g. `backlog-index`, `knowledge-note`, `procedure` or `receipt`.
Use the target's stronger schema when required. Preserve all existing frontmatter
and its meaning; add missing keys rather than replacing the mapping. Preserve the
body except for deliberate link repair. Do not invent creation dates, authors,
verification claims, expiration periods or project status.

`updated` is the date of an actual file edit. A `verified` date means factual/source
verification was actually performed; copying, metadata normalization or transfer
does not refresh it. Keep dated research and uncertainty labels intact. Existing
typed controllers/functions retain their program, revision and stamp fields.
Malformed or conflicting metadata is a finding to resolve, not a reason to strip it.

In the destination **README.md**, append a compact dated import record, merging
with existing metadata. The following is a template, not an executed-transfer claim:

```yaml
backlog_imports:
  - date: YYYY-MM-DD
    from: /absolute/source/path/decision-methods
    mode: copy
```

If source writing is authorized, also append a reciprocal `backlog_exports` entry
to the source README with `date`, `to` and `mode`. Preserve earlier records and
avoid duplicate entries for the same unchanged placement. Without source write
authority, destination provenance suffices; report the missing reciprocal pointer.

## 4. Copy, verify and record

For a new destination, prepare the selected package in a unique temporary location
inside the permitted target area. Verify copied file hashes against the prepared
package, valid frontmatter, expected link repairs and final path containment before
placing it under the final same-slug directory. Do not replace an existing tree
during placement. Keep an interrupted staging directory identifiable until reconciled;
never treat a partial destination as a completed import.

Check all Markdown links in the final tree, supported local dependencies, metadata
and the dated README record. Verify that differences from the source are limited
to intended metadata and link adjustments. Check target Git status/ignore behavior;
do not stage, commit, push or change history. A copied backlog remains backlog;
it does not start an implementation task or become target canon.

Return source and destination paths, slug, copied/held counts, import date, metadata
and dependency repairs, and any target gate. A read-only invocation returns the
prospective placement and findings without writing provenance or staging files.

Done when the same-slug package is verified at the authorized target with its
README provenance, or the precise unresolved route/collision/permission is reported.
