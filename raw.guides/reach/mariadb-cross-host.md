# MariaDB cross-host access (over tailscale)

_Written by @Flight · 2026-08-20 · for @majkee_

How to reach **the other machine's MariaDB** — to inspect or repair it — after the
tailnet hardening (`ia-sync/install-pkgs/harden-host.md`) bound every DB to loopback.

The short version: **do not re-open MariaDB to the network. Tunnel it over the
tailscale SSH you already locked down.** This is the pattern `mariadb-mcp` itself
blesses (its `config.prod.php` profile).

---

## 1. The 10-second mental model

Two facts, both set by `harden-host.md`:

- **The DB is loopback-only.** On each host MariaDB listens on `127.0.0.1:3306` and
  nowhere else — not on the LAN NIC, not on the tailnet. Deliberate: the audit found it
  on `0.0.0.0` and closed it.
- **The transport is SSH over tailscale.** sshd is key-only; ufw allows all of
  `tailscale0`. That trusted channel is how you reach the far host.

An **SSH tunnel** bridges the two: it maps a local port on *your* machine to
`127.0.0.1:3306` on the *far* machine, carried inside the tailscale SSH connection. The
database never leaves loopback on either end.

```
  home                                          office
  ┌────────────────┐    tailscale (key-only    ┌────────────────┐
  │ mysql / MCP    │      ssh, port 22)         │                │
  │   ↓            │  ═══════════════════════▶  │                │
  │ 127.0.0.1:3307 │────ssh -L 3307:...:3306────│ 127.0.0.1:3306 │ MariaDB
  └────────────────┘                            └────────────────┘
```

## Hosts

| | office | home |
|-|--------|------|
| MagicDNS name | `hruzam-120922` | `hruzam` |
| tailnet IP | `100.126.182.111` | `100.110.27.60` |
| user | `hruzam` | `hruzam` |
| MariaDB | `127.0.0.1:3306` | `127.0.0.1:3306` |

(Your phone and tablet are also on this tailnet — one more reason the DB stays off it.)

---

## Shortcut: the `db-reach` helper

If you just want the tunnel up, the zsh helper wraps steps 2 and 5:

```bash
db-reach                       # peer = $TAILSCALE_PEER (office→home / home→office); opens 127.0.0.1:3307
mysql -h 127.0.0.1 -P 3307 -u <admin> -p
db-reach-down                  # close it
```

`db-reach [peer] [local_port]` — defaults: peer = `$TAILSCALE_PEER`, local port `3307`. It refuses
if the port is already listening, and prints the `mysql` line to copy. Body lives in
`~/.config/zsh/system/tailscale.zsh` (authored in ia-sync, deployed outward). The manual steps
below are the same thing spelled out — read them to understand or debug what the helper does.

---

## 2. Open the tunnel (what `db-reach` does under the hood)

Pick a free **local** port for the near side; `3307` by convention (3306 + 1), so it
never clashes with your own local MariaDB on 3306.

**From home, to reach OFFICE's DB:**
```bash
ssh -fN -L 3307:127.0.0.1:3306 hruzam-120922
```

**From office, to reach HOME's DB:**
```bash
ssh -fN -L 3307:127.0.0.1:3306 hruzam
```

Flags: `-f` backgrounds it, `-N` opens no shell (forward only), `-L local:host:port`
is the forward. `127.0.0.1:3306` is resolved **on the far host**, so it hits that
host's loopback MariaDB. If the MagicDNS short name doesn't resolve, use the tailnet IP
(`ssh -fN -L 3307:127.0.0.1:3306 hruzam@100.126.182.111`).

Verify it's up:
```bash
ss -tln | grep 3307        # LISTEN on 127.0.0.1:3307 = tunnel open
```

## 3. Repair with the `mysql` CLI (quick path)

```bash
mysql -h 127.0.0.1 -P 3307 -u <admin-user> -p
```

Two things that bite:
- **Use `-h 127.0.0.1`, not `localhost`.** `localhost` makes the client use the *local*
  Unix socket and bypass the tunnel entirely — you'd silently hit your own DB. `127.0.0.1`
  forces TCP through the forward.
- For actual repair use an **admin-grant user** (root or a maintenance account), not
  `mcp_local` — that user only has grants on the databases the MCP exposes.

## 4. Point mariadb-mcp at the remote DB (agent path)

The `mariadb-mcp` README (§"Production profile") already documents exactly this. Drop a
config that points at the tunnel's near side:

```php
// config.prod.php  (gitignored — never commit credentials)
return [
    'host'   => '127.0.0.1',
    'port'   => 3307,            // the tunnel's local port, not 3306
    'socket' => null,
    'user'     => 'CHANGE_ME',   // admin/maintenance user for repair
    'password' => 'CHANGE_ME',
    'databases' => ['the_db'],
    'profile'     => 'prod',
    'allow_write' => true,
    'write_statements' => ['INSERT','UPDATE','DELETE','CREATE'],  // no destructive DDL on prod
    'guard_where'      => true,   // reject UPDATE/DELETE without WHERE
    'row_cap'       => 100,
    'query_timeout' => 5,
];
```

Register it against the same binary with the prod config path:
```json
{
  "mcpServers": {
    "mariadb-remote": {
      "command": "php",
      "args": ["-d","extension=iconv","/home/hruzam/www/mariadb-mcp/server.php","/home/hruzam/www/mariadb-mcp/config.prod.php"]
    }
  }
}
```

Open the tunnel (step 2) **before** the MCP connects, or it will fail to reach 3307.

## 5. Tear the tunnel down

Because `-f` backgrounds it, the tunnel outlives your terminal. Close it when done:
```bash
pkill -f 'ssh -fN -L 3307:127.0.0.1:3306'
```
(It also dies on reboot or if the tailscale link drops.)

---

## Why not just bind MariaDB to the tailnet?

Tempting — `bind-address = 127.0.0.1,<tailnet-ip>` would let the far host hit
`100.x:3306` directly, no tunnel. We rejected it:

- **It re-opens 3306 to the *whole* tailnet** — every node, including your phone and
  tablet — gated only by the tailnet ACL. The tunnel exposes nothing; it's a per-session,
  key-authenticated forward you bring up only while repairing.
- **It adds a boot-order dependency.** `mariadb.service` only orders `After=network.target`;
  binding a tailnet IP means MariaDB can start before `tailscale0` has that IP and fail to
  bind. You'd need a systemd drop-in to guard it.
- **It undoes the audit finding.** The whole point of `harden-host.md` was to get the DB
  off `0.0.0.0`. Loopback + on-demand tunnel keeps that intact.

The tunnel is tighter, needs no change to the hardened hosts, and rides a channel you
already trust. See `ia-sync/install-pkgs/harden-host.md` for the hardening it depends on.

---

## The "one-folder" deploy style (mariadb-mcp)

`mariadb-mcp` is its **own git repo** (`github.com/hruzam/mariadb-mcp`) — it is *not*
carried by ia-sync's config sync. To use it on a second machine:

1. `git clone` the repo (or `git pull` if already present) under `~/www/`.
2. `composer install`.
3. `cp config.example.php config.local.php` (or `config.prod.php`) and fill credentials.
   **Both `config.local.php` and `config.prod.php` are gitignored** — real credentials
   never leave the machine.
4. One binary, many configs: each project/target is just another `config.*.php` passed as
   `$argv[1]`. The README is the source of truth for setup, the iconv flag, and the tool set.

Do not duplicate the README here — read it at `~/www/mariadb-mcp/README.md`.
