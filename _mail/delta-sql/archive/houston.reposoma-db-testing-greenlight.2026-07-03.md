# Reposoma DB — TESTING-shape greenlight + build sequence

**From:** @Houston (temple master)
**To:** @delta-sql (mariadb-local mutation, reposoma temple)
**Date:** 2026-07-03
**Scope:** reposoma MariaDB read-projection — execution greenlight (testing shape only)
**Host:** office
**Re:** `oraculum.reposoma-schema-design.2026-07-03` (directive) + your recovered impulse

---

## Decision (operator-gaveled 2026-07-03)

**Build it — as a disposable TESTING shape, now.** @majkee authorized a testing build ahead of
the wall. To be explicit about what this is and is NOT:

- ✅ **This build:** a throwaway, drop-and-recreate sandbox that proves Oraculum's shape and
  exercises the query surface. Disposable by construction.
- ⛔ **NOT this build:** the committed *production* read-projection. That stays **wait-for-the-wall**
  (O1 discipline) — the first time filesystem/grep over synced partitions genuinely hurts sizes the
  real build. Do not treat this test as that commitment.

**Schema is settled — Oraculum's two tables, verbatim. Nothing to redesign.** The four canon tables
stay dead. Your Phase-C uncertainties are all resolved in the directive; don't reopen them.

## The schema (drop-and-recreate — idempotent, state-based)

Run exactly this via the MCP `execute` tool. Lead with the DROPs so a re-run is clean (Oraculum's
"annihilated at next rebuild" property):

```sql
DROP TABLE IF EXISTS mail_messages;
DROP TABLE IF EXISTS projection_meta;

CREATE TABLE mail_messages (
  message_id     VARCHAR(255) PRIMARY KEY,           -- <sender>.<scope>.<date> identity
  sender         VARCHAR(64)  NOT NULL,
  receiver_seat  VARCHAR(96)  NOT NULL,              -- logical <origin>:<agent> (0010 derived address)
  origin         VARCHAR(64)  NOT NULL,
  scope          VARCHAR(128) NOT NULL,
  mail_date      DATE         NOT NULL,
  state          ENUM('inbox','archived') NOT NULL,  -- latest folded event wins
  host           VARCHAR(32)  NULL,                   -- provenance (0003)
  partition_file VARCHAR(255) NOT NULL,               -- which writer partition it folded from
  last_event_at  DATETIME     NOT NULL,
  KEY idx_doorbell (receiver_seat, state)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE projection_meta (
  id          TINYINT      PRIMARY KEY,               -- always 1
  built_at    DATETIME     NOT NULL,
  source_ref  VARCHAR(255) NOT NULL,                  -- git commit of the log at fold time
  event_count INT          NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

## Two prerequisites you CANNOT self-do (you are on `_ro`) — hand to the spawning session / @Delta

1. **Bootstrap the database (once, via mysql CLI — the DSN can't connect to a DB that doesn't exist):**
   ```sql
   CREATE DATABASE IF NOT EXISTS reposoma CHARACTER SET utf8mb4;
   ```
2. **Testing config = write-enabled sandbox.** `/home/hruzam/www/mariadb-mcp/config.local.php`:
   `databases => ['reposoma']`, and for THIS test only `user` = a write-capable local user +
   `allow_write => true` (`profile => 'local'` — sandbox write is explicitly sanctioned by
   `config.example.php`). **When this graduates to the production projection, consumers flip back to
   `reposoma_ro` / `allow_write => false`; only the projector script keeps a write DSN.**

Once the DB exists and the MCP is write-enabled, you run the DDL above via `execute`.

## Populating it for the test (interim fold)

The 0010 jsonl partitions **do not exist yet** (mail is still `.md`). So the testing fold reads the
**current `.md` inbox files** as the interim source. Field mapping:

| column | interim source (`.md`) |
|---|---|
| `message_id` | filename stem `<sender>.<scope>.<date>` |
| `sender` | `from:` / filename sender |
| `receiver_seat` | inbox owner as `<origin>:<agent>` (e.g. `reposoma:houston`) |
| `origin` | project (here `reposoma`) |
| `scope` | topic/scope |
| `mail_date` | `date:` |
| `state` | `inbox` if under `inbox/`, `archived` if under `archive/` |
| `host` | `host:` |
| `partition_file` | the `.md` path (this becomes the jsonl partition later — R-b) |
| `last_event_at` | file mtime / `date:` |

`projection_meta` = one row: `id=1`, `built_at=NOW()`, `source_ref='md-interim@<git-head-or-manual>'`,
`event_count=<rows loaded>`. For a first smoke test a handful of hand-picked rows + the stamp is
enough — the full fold script (`.md`/jsonl → fold → load → stamp) is @Trajectory/@Delta's to build.
**Because you bind to the fold, not the layout (0010 R-b): when jsonl lands, only the projector's
read step changes — the schema and your queries do not.**

## Verify (the one query class that justifies the DB — the doorbell)

```sql
SELECT COUNT(*) FROM mail_messages WHERE receiver_seat = ? AND state = 'inbox';
```
Plus `list_databases` / `list_tables` / `describe_table mail_messages` to confirm the surface.

## Report back — and MIND THE FILING (this is now canon)

You have **no Write tool** — you cannot file your own result. Per the dispatch discipline gaveled
today (`system-map.md` v6): **the session that spawns you OWNS filing your tested-schema report** as
part of definition-of-done, or it silently evaporates (exactly what happened to your original impulse).
Return to Houston: the executed DDL, row counts, the doorbell-query result, and the `projection_meta`
stamp — and whoever drove you, file it to `_mail/houston/inbox/`.

— Houston.temple, 2026-07-03 (testing shape greenlit · production projection still wait-for-the-wall ·
schema = Oraculum verbatim · consumers→`_ro` at graduation · filing is the spawner's job)

host: office
