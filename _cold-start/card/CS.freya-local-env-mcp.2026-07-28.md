CS · 2026-07-28 · freya local env + production read-MCP

commit : 70d3ed1c (majkee-predev)   ← identical SHA to develop, zero divergence
task   : parked, waiting on dev-team answers

context:
  Began at two erroring aliases, ended at T37 + five ledger rows.
  gpl = missing `php`. mig = not the alias — Skaven's b83b09fb (23.7., buried in
  a UI-fixes commit) armed prohibitDestructiveCommands for every env except Pest.
  You gavelled a config opt-out → T37 DONE, staged, verified both directions
  (flag off → still blocked, so prod can't inherit it).

  Caveat: rules/freya-no-destructive-db.mdc names the ALLOW_* bypass by name.
  You consented, so it's clean — but Skaven will likely react. I built it without
  having read rules/ at all (there since 26.7.) → T42.

  ⛔ T40 blocks everything MCP: prod manifest lacks laravel/mcp, local has ^0.8.2.
  Contradicts "mcp deployed almost a year". One curl decides:
      curl -sS -o /dev/null -w '%{http_code}\n' https://www.imago.cz/mcp/freya
  401 = live, T41 proceeds. 404/500 = T41 dies in its current form.

  ⛔ HANDS OFF composer.json + composer.lock — Oraculum force-added them here,
  deliberately staged, awaiting your commit. I advised unstaging earlier out of
  ignorance. Wrong. Ignore it.

  Retracted today: my "phpstan gate is vacuous / level 0". Oraculum restored
  phpstan.neon at 11:41, before every probe I ran — my 20 errors were level 6.
  Live residual: scanFiles pulls _ide_helper.php, whose line 6971 shadows the DB
  facade and manufactures false "undefined method" errors.

ready to send:
  Team Discord post, Czech, routed — @Skaven (phpstan port · scanFiles · baseline
  policy ~10.3k errors · gitignore call · b83b09fb blessing), @Gotak (composer
  audit 4 advisories · flexibee dead weight), unassigned at top (laravel/mcp on
  prod). Sits in the session transcript. NOT posted — yours to send.

resume : claude --agent medusa
  Cold start: ledger.md (walk pointers — it moved twice today) +
  .dev/session/_mail/oraculum-to-medusa.2026-07-28.md.
  Live: T37 T38 T40 T41 T42 T43. T41 = MCP design, parked Phase 4 behind T40.
  READ rules/ — alwaysApply team doctrine, in no seat's cold-start order.
