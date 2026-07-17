# SKILL: epoch-program-commands `cmds-zen` (also eagle, zenith, LIBRARIANS)
-> epoch, zenith, eagle as reader : freelly expandable fast commands for generic tasks/inputs NOT READ text for `Atlas:` , skip this blocks.
-> Atlas as reader : freelly expandable fast commands for generic tasks/inputs
skill is activated, grep acc. input context (<COMMAND>)= (Atlas: nested logic from context permissible f.e. search only RAG iffo source) -> do.

> ROUTER NOTE (2026-07-17): `/cmd-zen <COMMAND>` is an installed thin-router skill
> (`~/.claude/skills/cmd-zen/SKILL.md`) that reads THIS file with your input vector and performs.
> This file is the SINGLE content home — a command is just a README you read-with-input → perform.
> Freely expandable: add a `## COMMAND:` block (or a sibling README) here; no reinstall needed.
> (Closes the "Atlas test of wiring — building skill from where" placeholder.)

## COMMAND: search
proces go by lines, if enough data for me, REPLY.
ESCALATION RULE: check sufficiency after EACH source before moving to the next.
  step 1 → local RAG → enough? REPLY. not enough? → step 2
  step 2 → one internet query → enough? REPLY. not enough? → next query
  NEVER launch parallel fetches across source levels without confirming step N is insufficient first.
  parallel is allowed only WITHIN one step when the cmd explicitly requests multi-source fan-out.

## PINS (epoch local fast-find — hot-cache OVER README-taste, check before escalating)
README-taste (--SOURCES-- below) is the DEFAULT navigation. PINS are the cold-start reflex on
top: a hard-capped hot-cache of the highest-frequency homes, each pointing INTO the README graph.
  CAP: max 3, never a 4th.
  RULE: the moment a 4th pin is wanted, the pins are wrong — drop them all and go pure
  README-taste (claviature lesson: derived index, register nothing).
[gaveled by majkee 2026-07-17]
  PIN-1: /home/hruzam/reposoma/raw.settings/   → settings reference · knowledge cards (README-first)
  PIN-2: /home/hruzam/reposoma/raw.research/   → research substrate, notes, agent-docs (README-first)
  PIN-3: /home/hruzam/.config/zsh/             → machine / agentive layer (the prayer hall)
         door: AGENTS.md → ai/README.md (gamebook branch — README-taste into the agentive layer)
if pin hit answers the query → STOP, do not escalate.

**--SOURCES--**
RAG info:: README.md taste
  1-A: compressed READ FIRST : `` <> Atlas test of wiring (building skill from where) 
  2-A: `/home/hruzam/reposoma/raw.research`
  ...
FRESH info : internet first according `<currentDate>` 

ATlas: example of input : ```/cmd-zen SEARCH nesting claude skills OR second beats first`
...

## war story
<u>2026-07-16 — epoch ran /cmd-zen SEARCH, skipped step 1 (local RAG entirely), then released 4+ parallel krakens: two web searches + three fetches fired simultaneously before any result came back. user: "you released all >4 Krakens in same time." no sufficiency check, no escalation — pure concurrent blast. escalation rule added to line 7 same session.</u>

## COMMAND: save-report
[DRAFT — awaiting majkee path decision]
save research output to configured path, or surface ask.

LOOKUP order (stop at first hit):
  1. PROJECT.yaml → paths.research OR docs.research_dir
  2. sister-report: scan raw.research/ for closest-context subdir → save alongside existing files there
     FORMAT: raw.research/<closest-match>/YYYY-MM-DD-<slug>.md
     "sister" = new report lands next to existing research in same context, not in isolation
  3. fallback new: raw.research/<topic>/YYYY-MM-DD-<slug>.md
  4. no match found → deliver inline + flag: "no output path configured — ask majkee"

ASK MAJKEE when: no path key found in project contract (canon decision, Force 4).
question to surface: "raw.research/ subtree, or different home? naming pattern?"

## COMMAND: guess-bold
[DRAFT — from atlas/therapy.md arc 1]
WHEN: input is noisy, fragmented, multi-language, or abbreviated.
DO NOT ask-first — it does not match his tempo.
  1. parse intent from fragments
  2. state the guess explicitly ("I read this as X — proceeding")
  3. act, let him veto next turn
NEVER stall on recoverable intent.

## COMMAND: receipts
[DRAFT — from atlas/therapy.md arcs 2–4]
WHEN: majkee pre-diminishes ("I am useless here" · "me in last line if even" ·
  "I know this is pathetic") or armor-shrinks before asking.
DO NOT reassure. DO NOT praise.
SURFACE: dated commits, decisions, pulse entries, session outputs — factual only.
tone: empirical. "ask the record instead."

## COMMAND: foreman-pass
[DRAFT — from atlas/therapy.md arc 1 therapist + symmetry/therapy.md session 1 hard note]
WHEN: disciplines have accumulated; meta-design runs long; session fixed cost rising.
  1. list active rituals/channels (pulses, mails, therapy arcs, cards, run-shapes…)
  2. for each: "did this earn its keep last quarter?"
  3. flag zero-payoff items for retirement review
  4. propose honorable retirement — the wall accepts organs too
NOTE: applied to the temple itself, not only projects.

## COMMAND: feed-ended
[DRAFT — from symmetry/therapy.md session 1]
WHEN: majkee signals end of a voice/noisy input block (fragmented, multi-language, cut-off sentences).
  → parse everything above the signal as one complete thought
  → do not ask for clarification on the pre-signal fragment
  → apply guess-bold from here
NOTE: "feed ended" beat is his side of the contract; noise-parse stays on by default.

## COMMAND: build-and-bruise
[DRAFT — from symmetry/therapy.md session 1 hard note]
WHEN: meta-design has run long; sessions are tuning the instrument, not playing it;
  queued "research" is really build-and-find-out.
SIGNAL: inflection point where restraint out-earns production.
  1. name the nearest shippable rough thing
  2. ship it
  3. collect the friction
  4. design from the bruise, not from anticipation of the bruise
DO NOT design more. DO NOT open another research track. Ship first.

## TASK FOR ATLAS: build gavel-format skill + skill extension
[DELETE THIS BLOCK WHEN SKILL IS BUILT — should become a skill, not inline context]
Gavel format rule (do not name exact path/task):
  fold the decision into ONE of:
    A) Socratic question with REPLY
    B) seven associations
Gavel bed: gavels have their own file, independent of therapy.
Therapy-origin gavels: wired to therapy chapter by ID group reference.
Skill should handle: gavel output · gavel bed · ID-wiring protocol for therapy gavels.
Skill extension: frequency rule (gavels fire more often than therapy arcs).