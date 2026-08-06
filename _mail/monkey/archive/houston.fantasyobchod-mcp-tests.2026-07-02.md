---
to: @majkee
from: Houston.fantasyobchod (2026-07-02 session — MariaDB MCP A1 built by Trajectory)
topic: TESTING INSTRUCTIONS — MariaDB MCP A1 (local profile). iconv → DB user → config → smoke → register → 5-tool + 2-gate functional tests
date: 2026-07-02
host: your dev PC
scope: A1 LOCAL ONLY. Do NOT point this at production — prod is A2 (parked, gated).
---

# Testing the MariaDB MCP — Phase A1 (local)

Tool lives at **`/home/hruzam/www/mariadb-mcp/`**. It's a standalone local stdio MCP server —
NOT part of the fantasyobchod app. Full design: `.dev/session/mcp-scope-a/design.mcp-scope-a.md`.
This memo walks you from zero to a passing test. Do the parts in order.

---

## Part 0 — prereqs (already true, just confirm)
- `php --version` → 8.5.6 ✅ (needed for `php-mcp/server`; your app's php74 is untouched).
- A **local MariaDB** running, with a database you don't mind writing to (sandbox — restorable).

---

## Part 1 — one-time setup

### 1a. Enable the `iconv` extension
`php-mcp/server` pulls in `opis/string`, which needs `ext-iconv`. Two options:
- **Permanent (preferred):** `echo "extension=iconv" | sudo tee /etc/php/conf.d/iconv.ini`
  (adjust the path to your php8.5 build's conf.d dir — find it with `php --ini`).
  After this, drop the `-d extension=iconv` flag everywhere.
- **Or per-run:** keep `-d extension=iconv` on every `php` command below.

### 1b. A local DB user (or reuse your normal local dev user)
Simplest: reuse whatever local user you already query with. If you'd rather scope one:
```sql
CREATE USER 'mcp_local'@'localhost' IDENTIFIED BY 'CHOOSE_ME';
GRANT SELECT, INSERT, UPDATE, DELETE ON yourtestdb.* TO 'mcp_local'@'localhost';
-- add CREATE, ALTER, DROP on yourtestdb.* only if you want to test DDL via execute()
FLUSH PRIVILEGES;
```
NOTE: this is the LOCAL sandbox — a broad local grant is fine (that's the whole point). The
hardened read-only `mcp_ro` grant is an A2 (prod) concern, not this.

### 1c. Config
```bash
cd /home/hruzam/www/mariadb-mcp
cp config.example.php config.local.php   # config.local.php is gitignored — your creds live here
```
Open `config.local.php` and fill the placeholders (the example file documents each key):
- **host/socket** — socket path for a local unix socket, or 127.0.0.1 + port for TCP.
- **user / password** — from 1b.
- **databases** — the allow-list. **Put ONLY the DB(s) this agent may touch** (e.g. `['yourtestdb']`).
  This is the gate you asked about — anything not listed is rejected.
- **profile** = `local`
- **allow_write** = `true`  (local sandbox → the agent may INSERT/UPDATE)
- **row cap** (200) / **row cap max** (1000) / **query timeout** — leave defaults to start.

---

## Part 2 — smoke test (does it start + expose 5 tools?)
Follow the README's smoke-test block (`/home/hruzam/www/mariadb-mcp/README.md`). In short — run:
```bash
php -d extension=iconv /home/hruzam/www/mariadb-mcp/server.php
```
and pipe the JSON-RPC handshake the README gives. **PASS =** the response lists **5 tools**:
`list_databases`, `list_tables`, `describe_table`, `query`, `execute`.
(No DB is touched yet — this only proves the server boots and registers.)

---

## Part 3 — register it in Claude Code (project scope)
From the fantasyobchod project root:
```bash
claude mcp add --scope project mariadb-local -- php -d extension=iconv /home/hruzam/www/mariadb-mcp/server.php
```
This writes `.mcp.json` in the project. Now the **main Claude session** (you) can call the tools
directly — no agent needed for your own testing. (A subagent would need the project-scoped DB
specialist; that's a separate, later job.)

---

## Part 4 — functional tests (the real ones)
In a Claude session inside the project, ask it to call each tool. Expected PASS for each:

| # | Call | Expect |
|---|---|---|
| 1 | `list_databases` | exactly your configured DB list (e.g. `["yourtestdb"]`) — nothing else on the server. |
| 2 | `list_tables("yourtestdb")` | the tables in that DB. |
| 3 | `describe_table("yourtestdb","sometable")` | columns + indexes. |
| 4 | `query("yourtestdb","SELECT * FROM sometable")` | rows, and if the table has >200 rows: `capped: true`, `row_count: 200`. |
| 5 | `execute("yourtestdb","INSERT INTO sometable (...) VALUES (...)")` | `ok: true`, `affected_rows: 1` (allow_write=true). |

### The two gates you specifically wanted — test them:
- **DB allow-list gate (Q1):** `query("some_other_db_on_the_server","SELECT 1")`
  → **must THROW** "Database '…' is not in the allow-list." (Proves other projects' DBs can't leak in.)
- **Write gate:** set `allow_write = false` in `config.local.php`, restart, then `execute(...)`
  → **must REFUSE** with the "Write operations are disabled" message. Set it back to `true` after.

### Also worth a poke (should all be rejected):
- `query("yourtestdb","UPDATE ...")` → rejected (use execute for writes).
- `query("yourtestdb","SELECT 1; DROP TABLE x")` → rejected (multi-statement).
  ⚠ known minor: a `;` inside a string literal is also rejected (false-positive, fails safe) — expected.

---

## Part 5 — troubleshooting
- **"Class not found" / iconv error** → Part 1a not done, or you dropped `-d extension=iconv`.
- **"MariaDB connection failed"** → creds/host/socket in `config.local.php`; confirm the socket path
  (`mysqladmin variables | grep socket`) or use 127.0.0.1 + port.
- **"not in the allow-list"** when you meant to allow it → add that DB to the `databases` list.
- **Tools don't appear in Claude** → `.mcp.json` not registered / wrong path in the command; re-run Part 3.

---

## Guardrails (don't skip)
- **LOCAL ONLY.** Do not put a production host in `config.local.php`. Prod is A2 — it needs the
  read-only `mcp_ro` grant + a replica + the arm-gate, none of which exist yet. Pointing this at
  prod now would bypass all of that.
- `config.local.php` holds creds → it's gitignored. Never commit it, never paste it into a chat.

When you've run Part 4 and the two gates behave, A1 is confirmed working — tell me and we move on
(freya adoption, or the project-scoped DB specialist, or A2 prod recon).

— Houston.fantasyobchod, 2026-07-02 (MCP A1 built + verified dry; this is your live-test pass · A2 parked on prod-access)
