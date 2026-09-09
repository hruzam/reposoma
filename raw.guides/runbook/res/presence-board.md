---
title: Presence board — advisory cross-session attachment records
chapter-of: runbook
---

# Presence board

> **GAVELED 2026-09-09 — majkee.**

Use the presence board when an active session wants to declare its attachment to a workspace so
people and clients can notice possible overlap. Attach by creating one complete record; detach by
removing it under the ownership rule below. The board is a shared display surface, not doing-state.

## Advisory boundary

Presence may inform a person or seat that coordination could help. It never commands or authorizes
work, wake, delivery, permission, scope, resource lock, schedule, takeover, prune, or workspace access.

Readers do not treat presence, absence, age, or damage as a behavioral gate. They may display a
record and its uncertainty, then leave any action to the applicable session and human authority.

## Home and attachment identity

The proposed home is `~/reposoma/_active/`, with one file per attachment. Here `~` belongs to the
host carrying the shared reposoma checkout.

Each attaching incarnation allocates 16 bytes from its operating system's cryptographic random
source and encodes them as 32 lowercase hexadecimal characters: the `attachment_id`. The filename is:

```text
presence.<attachment_id>.md
```

The filename grammar is `^presence\.[0-9a-f]{32}\.md$`. Its hexadecimal component must equal the
record's `attachment_id` byte-for-byte.

Create the target with an exclusive, create-without-replacement operation. If it exists, do not read,
replace, amend, or delete it as collision handling; allocate a fresh ID and try a new filename. This
is collision-resistant allocation with explicit conflict handling, not mathematical uniqueness.

The ID identifies only this attachment and grants no rights over a workspace, bed, seat, or record.
No registry or lock service participates. The ID and `attached_at` stay stable; v1 has no refresh.

## Record grammar

A record is UTF-8 without BOM, LF-only, ending in one LF. It has one frontmatter document and no
Markdown body. Exact `---` lines enclose one flat `key: "value"` scalar per line in the order below.
Blank lines, comments, nesting, lists, multiline values, aliases, tags, duplicate keys, and unknown
keys are invalid. Every value uses ASCII double quotes and contains no ASCII control character,
double quote, or backslash; escapes are not interpreted. This is a small grammar, not general YAML.

Required keys, in order:

- `schema` — exactly `presence-board/v1`.
- `attachment_id` — exactly 32 lowercase hexadecimal characters.
- `seat` — the declaring seat; 1–64 ASCII letters, digits, `.`, `_`, or `-`, starting alphanumeric.
- `host` — the declaring host label under the same 1–64 character grammar.
- `workspace` — a whole quoted pointer beginning `~/`, scoped to `host`.
- `bed` — a whole quoted pointer beginning `~/`, scoped to `host`; it may be outside `workspace`.
- `attached_at` — a calendar-valid `YYYY-MM-DDTHH:MM:SSZ` or
  `YYYY-MM-DDTHH:MM:SS±HH:MM`. Fractions and missing zones are invalid; offsets range through
  `14:00`, with `14` permitting only `00` minutes.

One optional final key is allowed:

- `note` — one line for display only. A reader never parses it as policy, state, instruction, scope,
  or authority.

Missing, reordered, duplicate, or extra keys, bad quoting, filename/ID mismatch, or conflict markers
make a record malformed. Competing contents for one filename make it conflicted. Readers report the
state, filename, and reason; they do not guess, choose, hide the row, or infer a live participant.

## Valid record

Filename: `presence.4f8c2d7a9b1e6c03d5a7f9218b4e0c6d.md`

```yaml
---
schema: "presence-board/v1"
attachment_id: "4f8c2d7a9b1e6c03d5a7f9218b4e0c6d"
seat: "astrobley"
host: "office"
workspace: "~/ia-sync"
bed: "~/ia-sync/.dev/session/runbook-upgrade"
attached_at: "2026-09-06T14:05:09+02:00"
note: "Drafting the presence-board contract"
---
```

The filename and ID map exactly. The timestamp is a declaration, not a heartbeat or liveness claim.

## Ownership and lifecycle

The incarnation that exclusively created a record is its single writer and attachment owner. Reusable
seat, host, workspace, and bed labels do not let another incarnation edit or delete it.

After complete creation, a v1 record is immutable. Its owner detaches by removing exactly the file
named by its owned ID; reattachment gets a new ID, filename, and time. Only explicit human authority
may remove an orphan. Readers never auto-delete, refresh, repair, or infer takeover.

Detaching ends only the board declaration; it neither closes the bed nor proves gate, receipt,
evidence, promotion, or transfer completion. The RUNBOOK GUIDE **On gate closure** still governs.
The cSharp protocol still requires committed receipts, EVERY raw keeper in the promotion manifest,
and experience transfer. `res/fanout-turns.md` **Cold recovery and late artifacts** still applies.

Route any owed overlap handoff through its BUS or transfer authority before the responsible session
closes. Board detachment neither satisfies that handoff nor suppresses a late artifact.

## Reading and display

Resolve `workspace` and `bed` only in the declaring `host` frame. Remote `~/` remains a quoted remote
pointer, not the reader's home, a verified local path, remote-access permission, or relocation.

Use `attached_at`, never mtime. Age thresholds and dim rendering are client policy. Old proves
neither death nor activity; invalid, ambiguous, or future/skewed renders unknown. Transport may lag,
so the board is not a real-time census.

Absence, staleness, damage, conflict, or a TUI unknown row is not closure evidence. Plain-file attach
and detach are the contract; commands, clients, universal validators, daemons, and heartbeats are out.
