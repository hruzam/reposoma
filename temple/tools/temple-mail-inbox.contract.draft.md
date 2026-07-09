# `temple-mail-inbox` — interface contract (DRAFT · @Delta-verified, gavel-ready)

`status: DRAFT → @Delta-VERIFIED 2026-07-09 against the on-disk script (machine layer, 0003/0009). The behavior below is the script's ACTUAL contract, not a reconstruction. Awaiting @majkee gavel → then canonical + re-point tools.md:16 here.`
`owner: temple architect (Houston) drafts → @Delta verified vs the ai/ namespace script → @majkee gavels. date: 2026-07-09 · host: office`
`why this file exists: tools.md:16 (tool #6, temple-mail-inbox) points its spec home at "transport-and-doorbell.run2-and-circuit.md" — CUT in the 07-08 ④a-tail trio cut, gone from disk (a live dangling pointer). @Janus (2026-07-09) flagged that binding twins to an interface with NO citable contract silently defeats R-b. This is the restored, focused spec home. On gavel: re-point tools.md:16 here.`
`tool state: shared-tool — built + verified (tools.md:16). Machine layer (0003), ai/ namespace (0009); consumers reach it via base.zsh. Requires temple-project-map.zsh (auto-sources if absent). This doc is the CONTRACT, not the implementation.`

> **The stable surface.** This signature + these semantics are the contract callers bind to (0010 R-b).
> The underlying storage — per-message `.md` files today, jsonl partitions after the 0010 transport lands —
> is an internal implementation detail. A storage swap is a **single-tool internal change** and does NOT
> change this contract. **Callers MUST bind here, never to the layout.**

## Signature
```
temple-mail-inbox <origin>:<seat>
```
- **One positional argument** `<origin>:<seat>` (the script's internal field name is `agent`; AGENTS.md
  step 5 says `seat` — the same field; this doc uses `<seat>`).
- **Parsing:** `origin` = text before the first colon (`${address%%:*}`); `seat` = text after the last colon
  (`${address##*:}`). Must contain a colon; both parts non-empty.
- **Derived, not path-based (0004 L4 / 0003):** `origin` → repo-root via `temple-project-root` /
  `TEMPLE_PROJECT_MAP`; `seat` → the `_mail/<seat>/inbox/` convention. **No `~/`/absolute path is ever
  passed or embedded.**

## Returns (stdout) — happy path, items present, **exit 0**
Exact format:
```
INBOX <origin>:<seat> — N unread item(s) [+ M toAll broadcast(s)]:
  <filename>
  [toAll] <filename>
```
- Header line with counts, then agent-inbox filenames (2-space indent), then `toAll/` filenames prefixed
  `[toAll]`.
- **BY FILENAME ONLY** (`basename`) — never message content. Filename shape: `<sender>.<scope>.<YYYY-MM-DD>.md`.
- **`toAll/` broadcasts ALWAYS resolve from the reposoma root** regardless of which origin is queried — so
  any project boot surfaces global recalibration reminders.

## Semantics
- **Presence in `inbox/` = unread** — the filesystem is the state machine (no read-state table).
- **Ask-first:** the tool NEVER auto-reads content; listing filenames is the whole job. The caller decides
  whether to open any item.
- **Empty → silent, exit 0** ("boot never errors on a silent inbox").
- **Read-only / non-mutating:** does NOT `mv` to `archive/`, mark-read, create dirs, or write.

## Exit behavior (verified — two distinct non-zero codes)
| case | stdout / stderr | exit |
|---|---|---|
| empty inbox | (silent) | **0** |
| items present | formatted list on stdout | **0** |
| missing argument | stderr `Usage: temple-mail-inbox <origin>:<agent>` | **1** |
| malformed address (no colon / empty part) | stderr `temple-mail-inbox: address must be <origin>:<agent>, got '<value>'` | **1** |
| unknown origin project | stderr `temple-project-map: unknown project '<name>' on host <machine>` | **1** |
| origin maps but repo dir missing on host | stderr `temple-project-map: project '<name>' maps to '<path>' but directory not found on this host` | **2** |

`1` = usage / address / unknown-project · `2` = mapped-but-directory-missing.

## What it does NOT do (the R-b fence)
- No content read/print. No state mutation. No layout exposure to callers.
- **Layout IS hardcoded internally** (`${root}/_mail/${seat}/inbox`, `*.md` filter, `basename`) — that is
  expected/fine INSIDE the tool. Callers pass only `<origin>:<seat>` and receive the formatted list; they
  never see the layout. **R-b is satisfied by construction** (@Delta-confirmed: layout fully encapsulated).

## Gavel step (the only thing owed)
@Delta verification 2026-07-09 = **done** (contract above is disk-truth). @majkee gavels → this becomes the
canonical `temple-mail-inbox` contract → **re-point `tools.md:16` here**, closing the dangling pointer.
