CS · 2026-07-28 · freya local env + production read-MCP

commit : 70d3ed1c (majkee-predev)   ← same SHA as develop, zero divergence
task   : parked awaiting Skaven. Two broken shell aliases turned into T37 + five ledger rows.

context:
  Started at `gpl` / `mig` erroring. `gpl` was a missing `php`. `mig` was not the
  alias at all — Skaven's b83b09fb (23.7., buried in a UI-fixes commit) armed
  prohibitDestructiveCommands for EVERY env except Pest, killing the local rebuild.
  You gavelled a config-backed opt-out → T37, DONE, staged on majkee-predev,
  verified both directions (flag on → fresh runs; flag off → still blocked, prod safe).

  Sting in the tail: rules/freya-no-destructive-db.mdc names the ALLOW_* bypass
  *by name* as the thing not to do without explicit consent. You gave consent, so
  it's compliant — but expect Skaven to react. I built it without having read
  rules/ at all (on disk since 26.7.) → that's T42.

  ⛔ BLOCKER T40 before any MCP work: prod manifest LACKS laravel/mcp, while local
  has ^0.8.2. That contradicts your "mcp deployed almost a year". Both can't be
  true. One curl settles it — 401 means live, 404/500 means the plan is dead:
      curl -sS -o /dev/null -w '%{http_code}\n' https://www.imago.cz/mcp/freya

  ⛔ HANDS OFF composer.json + composer.lock — Oraculum force-added them on this
  branch, deliberately staged, awaiting YOUR commit. I offered to unstage them
  earlier in ignorance. That advice was wrong; ignore it.

  Also retracted today: my "phpstan gate is vacuous / level 0" claim. Oraculum had
  already restored phpstan.neon at 11:41, before every probe I ran — so my 20
  errors were level 6 with larastan, not level 0. T34 largely resolved by her;
  the live residual is scanFiles pulling _ide_helper.php, which shadows the DB
  facade (_ide_helper.php:6971) and manufactures false "undefined method" errors.

waiting on:
  Skaven — phpstan.neon is 1.x syntax on a 2.2.2/larastan-3.10 stack · scanFiles ·
  baseline includes · does phpstan.neon stay gitignored · blessing on the T37 opt-out.
  Message drafted in the session transcript, NOT sent — it's yours to post to Discord.

  Open gavel from Oraculum: baseline policy (full-tree level 6 = ~10.3k errors).

resume : claude --agent medusa   → cold start reads ledger.md (walk pointers, it
         moved twice today) + .dev/session/_mail/oraculum-to-medusa.2026-07-28.md.
         Live rows: T37 T38 T40 T41 T42 T43. T41 = the MCP design, parked at Phase 4.
         ADD rules/ TO YOUR READ — it is alwaysApply team doctrine and no seat reads it.
