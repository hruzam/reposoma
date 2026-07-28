From: atlas
To: monkey (majkee)
Date: 2026-07-15
Subject: Session summary -- what was done, what is open

Plain text, readable on mobile. No colors.


WHAT WAS DONE TODAY
-------------------

1. /new-project skill built
   File: ~/.claude/skills/new-project/SKILL.md
   Skill 20 in the global set. Active next session.

   Full bootstrap procedure for a new temple project pair. Covers all wiring
   layers: scope-group mandate, app scaffold, devenv scaffold, registry beacon,
   machine layer (temple-project-map.zsh), devenv transport (devenv.zsh +
   keyboard.zsh P11), optional TCR config, shell commands block, post-bootstrap
   checklist.

   Mail seeds at bootstrap: toAll only. Other seat folders on demand.

   Two red cones baked in:
   - devenv.zsh + keyboard.zsh P11 wiring was nowhere documented for new projects
   - ia-sync + shell reload required before machine-layer entries go live


2. guide-for-builder.md updated
   File: ~/.config/zsh/guides/guide-for-builder.md

   Added section "How to add a new project devenv transport" -- the recipe that
   was missing alongside the existing Gemini seat recipe. Covers devenv.zsh
   entry points, keyboard P11 aliases, ia-sync gate, zsh -n check, checklist.


3. Eagle refresh card written
   File: reposoma/raw.settings/raw.card.eagle.md
   half_life_days: 30. Tracks cascade logic, 9 mapped projects, beacon field
   names, staleness triggers. Tabled item D closed.


4. Eagle wired into Houston and Flight routing tables
   houston.md: "Project orientation" entry added to Who I spawn.
   flight.md: @Eagle added to Who I spawn alongside Epoch.
   Epoch already had Eagle wired -- no change needed there.


5. /project-regular-self-report skill rewritten -- two phases
   File: ~/.claude/skills/project-regular-self-report/SKILL.md

   Phase 1 (existing card, monthly): prepends state block, never touches intake.
   Phase 2 (new card): reads raw.guides/project-intake.md for A-G mounting
   points and raw.settings/card.template.md for card shape. If a per-project
   intake file exists in raw.guides/intake/, reads it as the source.
   Intake section written once, never overwritten on monthly runs.

   The card now has two layers:
   - Founding context (A-G: purpose, work nature, team split, stack, constraints,
     out of scope, research open at founding)
   - State log (monthly, append-only, newest first)


6. Two template files wired (no longer orphaned)
   raw.guides/project-intake.md -- pointer added: consumed by skill Phase 2
   raw.settings/card.template.md -- pointer added: consumed by skill Phase 2


7. Three intake files converted to wrappers
   raw.guides/intake/subai.devenv.intake.md
   raw.guides/intake/reposoma.devenv.intake.md
   raw.guides/intake/piql.dev.intake.md

   Each has a header pointing to its canonical card in raw.settings/. Founding
   A-G content kept as historical record below the header. READ-ONLY from now.
   Cards created on demand via /project-regular-self-report.


WHAT IS STILL OPEN
------------------

Stale tool cards (toAll broadcast, unruled):
  claude-ai, claude-code, cursor-ide, gemini-gems
  Epoch will handle -- you said do not worry about this one.

Houston routing update (Oraculum + Agol one-liners):
  Parked to 2026-07-19. No action until then.

home.md cleanup:
  Blocked on home machine session.

Publishing trial:
  You have a tip for next week. Dormant until you bring it.


TABLED ITEMS CLOSED TODAY
--------------------------

C -- /new-project skill (open since 2026-07-07)
D -- Eagle refresh card (opened and closed same session)


ONE NOTE
--------

The three intake files (subai.devenv, reposoma.devenv, piql.dev) do not have
cards yet. When you want to create them, run:

  /project-regular-self-report subai.devenv
  /project-regular-self-report reposoma.devenv
  /project-regular-self-report piql.dev

The skill will read the existing intake files automatically for Phase 2.
