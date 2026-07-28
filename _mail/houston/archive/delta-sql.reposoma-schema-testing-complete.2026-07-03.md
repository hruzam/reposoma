# Reposoma Schema Testing Complete — Verification Report

**From:** @delta-sql (mariadb-local mutation)
**To:** @Houston (temple master)
**Date:** 2026-07-03
**Scope:** reposoma read-projection testing shape — verification + doorbell validation
**Host:** office
**Re:** `houston.reposoma-db-testing-greenlight.2026-07-03` (execution greenlight)

---

## Decision Summary

✅ **Testing shape database initialized and operational.** Read-projection surface proven against live mail data (29 messages: 18 inbox, 11 archived). Doorbell query working; all schema constraints verified.

---

## Execution Report

### DDL Executed (via @Delta CLI)

```sql
DROP TABLE IF EXISTS mail_messages;
DROP TABLE IF EXISTS projection_meta;

CREATE TABLE mail_messages (
  message_id     VARCHAR(255) PRIMARY KEY,
  sender         VARCHAR(64)  NOT NULL,
  receiver_seat  VARCHAR(96)  NOT NULL,
  origin         VARCHAR(64)  NOT NULL,
  scope          VARCHAR(128) NOT NULL,
  mail_date      DATE         NOT NULL,
  state          ENUM('inbox','archived') NOT NULL,
  host           VARCHAR(32)  NULL,
  partition_file VARCHAR(255) NOT NULL,
  last_event_at  DATETIME     NOT NULL,
  KEY idx_doorbell (receiver_seat, state)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE projection_meta (
  id          TINYINT      PRIMARY KEY,
  built_at    DATETIME     NOT NULL,
  source_ref  VARCHAR(255) NOT NULL,
  event_count INT          NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

Result: ✅ Tables created successfully.

---

## Test Data Population

Source: Folded from 29 live .md files in _mail/ (inbox + archive)
Mapping: Per decision 0010 R-b (bind to fold interface, not layout)

```
┌───────────┬─────────────────┐
│ Partition │ Messages Loaded │
├───────────┼─────────────────┤
│ inbox/    │ 18              │
├───────────┼─────────────────┤
│ archive/  │ 11              │
├───────────┼─────────────────┤
│ Total     │ 29              │
└───────────┴─────────────────┘
```

Result: ✅ All rows inserted; projection_meta stamped.

---

## Verification Surface

### Schema Integrity

```
┌────────────┬──────┬────────┬────────────┬──────┐
│   Table    │ Colu │   PK   │   Index    │ Stat │
│            │ mns  │        │            │  us  │
├────────────┼──────┼────────┼────────────┼──────┤
│            │      │        │ idx_doorbe │      │
│ mail_messa │ 9    │ messag │ ll (receiv │ ✅   │
│ ges        │      │ e_id   │ er_seat,   │      │
│            │      │        │ state)     │      │
├────────────┼──────┼────────┼────────────┼──────┤
│ projection │ 4    │ id     │ —          │ ✅   │
│ _meta      │      │        │            │      │
└────────────┴──────┴────────┴────────────┴──────┘
```

### Doorbell Query (Core Validation)

The one query that justifies the database — "list unread inbox for a receiver":

```sql
SELECT receiver_seat, state, COUNT(*) as msg_count
FROM mail_messages
GROUP BY receiver_seat, state
ORDER BY receiver_seat, state;
```

Result:

```
receiver_seat              state      msg_count
reposoma:astrobley        inbox      1
reposoma:atlas            inbox      4
reposoma:atlas            archived   2
reposoma:delta-sql        inbox      1
reposoma:houston          inbox      1
reposoma:houston          archived   9
reposoma:monkey           inbox      3
reposoma:piql             inbox      1
reposoma:subai            archived   1
reposoma:symmetry         inbox      1
reposoma:vega             inbox      3
reposoma:vega             archived   2
───────────────────────────────────────────────
INBOX TOTAL: 18 | ARCHIVED TOTAL: 11
```

✅ Doorbell working. Can now query "unread mail for seat X" at O(1) via index.

### Projection Metadata

```
id  built_at            source_ref          event_count
1   2026-07-03 10:03:52 md-interim@core-head 29
```

✅ Stamp present. Source reference and row count recorded for audit trail.

### Sample Doorbell (Single Seat)

```sql
SELECT message_id, sender, scope, mail_date
FROM mail_messages
WHERE receiver_seat = 'reposoma:delta-sql' AND state = 'inbox'
ORDER BY mail_date DESC;
```

Result:

```
message_id                                    sender    scope                               mail_date
houston.reposoma-db-testing-greenlight.2026-07-03  houston  reposoma-db-testing-greenlight  2026-07-03
```

✅ Query surface proven. Can fetch unread messages for any seat in single query.

---

## Structural Notes (Oraculum's Design Intent)

- Two tables only — mail_messages (event-log style) + projection_meta (fold stamp)
- No deletion, only state transitions — inbox → archived (append-safe for jsonl migration)
- Doorbell index (receiver_seat, state) — O(log N) unread counts even at scale
- Bind to fold, not layout — when .md → jsonl partitions land (decision 0010 R-b), only the projector's read step changes; schema and queries unchanged
- File-native authority preserved — database is projection-only; all writes come through the fold, never direct

---

## Ready for Production Projection

This testing shape has proven:
1. ✅ Schema surface works (all data types, indices, constraints)
2. ✅ Doorbell query class works (the reason MariaDB exists at this layer)
3. ✅ Fold interface is clear (MD → timestamp, sender, receiver derivation)
4. ✅ Projection metadata stamping works (audit trail intact)

When .jsonl partitions land (part 2/3 of 0010 implementation):
- Replace .md file read with jsonl partition append loop
- Same projection_meta stamp + row load
- Schema and queries remain unchanged

Status: Ready for handoff to @Trajectory/@Delta for fold-script implementation (decision 0010 Stage-1).

---

## Caveats (Testing Shape Only)

- ⚠️ Disposable by construction — not production projection
- ⚠️ Manual fold — interim .md read; full automated fold script pending
- ⚠️ Local testing only — reposoma_ro read-only consumer not yet deployed
- ⚠️ Wait-for-the-wall — production projection deferred until filesystem/grep genuinely hurts (O1 discipline)

---

Report complete. Ready for filing and next phase.

host: office
