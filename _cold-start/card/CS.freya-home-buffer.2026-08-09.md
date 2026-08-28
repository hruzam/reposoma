CS · 2026-08-09 · freya home = buffer endpoint (Tailscale) → next: running local env

commit : c730bbd60 (majkee/pre-develop)   # home/gaia, tracks tail/majkee/pre-develop
task   : buffer bond DONE — next: bring up a running local freya env on home (gaia)

context:
  Home (gaia) rewired into a buffer endpoint over Tailscale (driven by
  flight-office/medusaBond). Non-destructive rewire, all guards held:
    vendor = fantasyobchod/freya         (customer, READ only)
    tail   = hruzam-120922:.../freya.buffer.git   (office bare, Tailscale)
    hub    = hruzam/freya.buffer.git      (parked — 120MB blob blocks GitHub)
  On majkee/pre-develop @ c730bbd60 (== office bare == office working; 3-point verified).
  Receive:  git pull tail majkee/pre-develop  (ff-only) — verified working.
  meilisearch binary present (126MB) + Tailscale spare ~/.majkee/@transporter (same sum).
  Never auto-push (push = ask/deny, global).

  Ready for bring-up (recon this session):
    - composer.json + composer.lock BOTH present & committed → 07-28 "staged" has LANDED.
      Use `composer install` (NOT update — realize the lock; post-update-cmd fires
      boost:update+ide-helper, need a bootable app). Flag W3-manifest law.
    - laravel/boost ^2.0 in require-dev → Boost installs free with composer install.
    - .env already on home (verify APP_KEY/DB/meili/redis; .env_alex = reference).
  Open unknown = LOCAL DB SOURCE: prod = dual-DB blue-green from legacy
  (mysql_old_database). DB-renew guard applies — decide seed vs dump before migrate.

pending (rough order):
  1 composer install · 2 verify .env (+key:generate) · 3 DB source→migrate+seed ·
  4 meilisearch + scout import · 5 redis/cache · 6 octane:start (RoadRunner) or serve ·
  7 Boost MCP local-scope (never edit .mcp.json)

state pointers:
  - Prior card CS.freya-local-env-mcp.2026-07-28.md (same inbox): live T37/38/40/41/42/43;
    ⛔T40 = prod manifest lacked laravel/mcp (blocks MCP design T41).
  - Ledger .dev/session/ledger.md (walk pointers, re-derive) +
    .dev/session/_mail/oraculum-to-medusa.2026-07-28.md.
  - rules/ = alwaysApply team doctrine, not in any cold-start order — READ it.

session advice:
  Git writes were classifier-blocked; a narrow freya-only allow in
  .claude/settings.local.json (git remote/fetch/checkout/branch, ls) cleared it, push gated.
  Guards held — refused the mutating rewire until gavel. devenv+tripwire DEFERRED (plain git covers).

resume : claude --agent medusa   (or houston for the bring-up plan)
  Cold start per CLAUDE.local.md, then this card + the 07-28 card.
