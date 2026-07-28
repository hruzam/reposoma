CS · 2026-07-28 · freya admin-assistant knowledge layer (T32)

commit : dc93791e (develop) — nothing staged, tree untouched
task   : T32 — give the admin bot a knowledge base + a maintenance ritual

context:
  The bot was never the gap. AdminAssistant + admin widget + Czech prompt
  + 19 tests are all shipped and tracked. Missing: grounded knowledge, and
  someone to keep it fresh. Mirror InternalFaqParser/SearchInternalFaqTool.
  Audit A landed CLEAN — 0 crit/0 high, both Mediums are the PROMPT
  ("poradíš s postupy" with no source). Brick-island: does not apply, closed.

  Then the audit tripped over something bigger: phpstan.neon is GONE and
  gitignored, so `phpstan analyse` silently ran at LEVEL 0 saying "No errors".
  Every Larastan-green claim for weeks was hollow, G-APP included. Measured:
  26 errors with the 3-week-stale ide-helpers, 1 without — 25 were stub rot.
  The 1 real: Assistant.php:103 render() has no return type.

  Two pulls block everything, both on the Skaven call:
   1. phpstan.neon (does it include the baseline?) + composer.json/.lock
      + checkout/shipping.yml
   2. prod admin-assistant-*.log — 14-DAY ROTATION, the clock is the reason
      to hurry. No DB fallback: local schema is empty.

  Ledger: T32 audit done · T33 whisper (spec undefined, parked) · T34 phpstan
  · T35 B0 blocked · T36 laravel.log 1.5G. GOD/T1 stays parked — your call,
  users drowning outranks the study.

resume : cd ~/www/imago_cz/freya && claude --agent medusa
         → reads ledger T32-T36, asks for the Skaven pulls first
