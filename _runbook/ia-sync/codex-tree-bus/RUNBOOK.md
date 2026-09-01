# RUNBOOK: Claude ↔ Codex tree-bus trial

**Addendum 2026-09-02 (repo unification, majkee gavel):** the "devenv transport" promotion
note below is obsolete — `nablarva.devenv` is retired, merged into `nablarva`. `nablarva`
now tracks `.dev/session/` directly (plain `git add`/`commit`), so promoting the bench copy
to `~/unikuklatrix/nablarva/.dev/session/tree-bus-01-trial/` is a plain copy + commit, not a
two-repo move. Also note: `termbrana` merged into `nablarva/toolbox/termbrana/` (subtree,
history preserved) — not referenced by name below, but relevant if this trial's payload ever
touches it. Details: `nablarva/docs/repo-unification.2026-09-02.md`.

```yaml
goal: Decide from evidence whether a file-tree bus + runbook + PAD is sufficient for two-seat Claude/Codex cooperation. Real ia-sync cleanup is the payload, not a toy task.
gate: Three cycles run and the audit ledger filled → verdict against the pre-registered stop rule.
participant_1: [oraculum, {brand: "Claude Code", model: opus, effort: high}, host: "home"]
participant_2: [cartan, {brand: "Codex CLI", model: gpt-5.6-sol, effort: high}, host: "home"]
participant_3: [majkee, {role: "router + gavel — no automated transport; the human points each seat at the next file"}, host: "home"]
```

## Status of this file

**Draft on the bench.** Promotion target — flag **L6** places experimental agentive shapes in
nablarva, not on the surgical table:

```
~/unikuklatrix/nablarva/.dev/session/tree-bus-01-trial/
    RUNBOOK.md            ← this file, promoted
    STATUS.md             ← the position
    _bus/                 ← the exchange
    pad.<N>-<scope>.md    ← human gates
```

The payload targets `~/ia-sync`, but the *experiment* lives in nablarva. Note `.dev/` is ignored
in the nablarva worktree — it reaches git through the `nablarva.devenv` transport, so promotion
is a two-step move under that repo's own discipline, not a plain copy.

**Nothing runs from this bench copy.** All paths in the prompts below are absolute and point at
the promoted location.

## What is actually being tested

Not the cleanup. The **machinery**: runbook as task format, PAD as human-in-loop format, a tree
bus as transport, and whether two seats beat one seat at all.

This exists because the previous attempt failed the other way round. On 2026-08-25 a full
mail-based Claude↔Codex protocol was written *before* anyone checked whether the mail rail
carried traffic. It did not — `_mail/kelvin/` had never existed in the repo's history. The
protocol was deleted. **The correction is to run a loop and measure, rather than build on
assumed demand.**

### Pre-registered stop rule (set BEFORE the trial, not tunable during)

| measure | how |
|---|---|
| handoff completeness | cycles where majkee had to explain context **verbally** because the file did not carry it |
| claim integrity | RETURN claims that failed verification against their cited artifact |
| dropped handoffs | a POINT that sat unactioned because nobody noticed it |
| cost | rough token spend vs. a single-seat estimate for the same work |

**STOP if**, after cycle 3, the two-seat loop is not clearly better than single-seat on *either*
correctness or wall-clock. On STOP: keep the artifacts as a record, do not extend the bus, go
single-seat.

### Audit ledger — fill one row per cycle, before the next begins

| cycle | handoff complete? | claims failed verification | dropped? | cost vs single-seat | verdict |
|---|---|---|---|---|---|
| 1 | | | | | |
| 2 | | | | | |
| 3 | | | | | |

An unfilled row means the cycle is not closed. The stop rule is decided from this table, not from
recollection — that is the point of pre-registering it.

### Hooks — deferred, one reason

Hooks are bilaterally possible: `~/.codex/hooks.json` exists. (An earlier draft claimed Codex had
no hook surface; that was false, and the files were themselves products of the 2026-08-26 vendor
migration.)

The deferral rests on decision 0009 **L5** — verify-real-trigger: a hook counts as done only when
the trigger fires and produces output, never by hand-run. That means a smoke probe before it can
be trusted, and no cycle has yet named a failure a hook would fix.

**Build one when, and only when, a cycle records a dropped handoff.** That is the specific failure
a watcher fixes. Until the ledger shows one, the human router is cheaper.

## The bus

```
<session>/_bus/NN.<seat>.<kind>.md      NN = cycle · kind ∈ {point, return, verdict}
```

Four rules:

1. **Sequence lives in the filename.** No inbox, no archive, no read-state.
2. **Single writer per file.** Direction is in the name for exactly this reason.
3. **One file per direction per cycle** — the PAD guide's *"never a file per step"* applies here.
4. **majkee is the transport.** No hook, no doorbell, no watcher, until the ledger says otherwise.

**RETURN format** (six fields, reused unchanged from `toolbox-termbrana-02/handoff.md`): files
changed · exact commands + outcomes · evidence paths · mismatches discovered · recommended next
task · remaining uncertainty. *A RETURN missing field 6 is incomplete; "none" is valid, silence
is not.*

**Curvature rule:** when a map and the disk disagree, the disagreement is the artifact — name it,
verify against the cited file, never flatten to the tidier version. Neither seat treats the
other's report as evidence without checking what it cites. On 2026-08-25 this caught three real
contradictions, twice against its own author; on 2026-08-27 a fourth, again the author's.

# prompt-0 — Oraculum (Claude, working dir `~/ia-sync`)

```
You are @Oraculum running the tree-bus trial from ~/ia-sync on host home.
Verify first: `echo $MACHINE_NAME` must print `home`. If it prints `office`, stop —
this runbook's payload is home's zsh tree.

Read, in order:
  ~/unikuklatrix/nablarva/.dev/session/tree-bus-01-trial/RUNBOOK.md
  ~/unikuklatrix/nablarva/.dev/session/tree-bus-01-trial/STATUS.md
  ~/unikuklatrix/nablarva/.dev/session/tree-bus-01-trial/_bus/   (newest-numbered file)
  ~/ia-sync/journal.host-cleanup.md   (HOME 2026-08-25 and 2026-08-27 entries)

Each cycle:
1. Write .../_bus/NN.oraculum.point.md — scope, absolute paths, gates, done-when. No narrative.
2. Wait. majkee carries it to Cartan.
3. Read .../_bus/NN.cartan.return.md. VERIFY its claims against the artifacts it cites — do
   not accept a report as evidence. Delta misreported three times on 2026-08-25.
4. Write .../_bus/NN.oraculum.verdict.md, fill this cycle's ledger row, rewrite STATUS.md.
5. Anything destructive gets a PAD, not a task. See ~/reposoma/raw.guides/PAD/GUIDE.md.

You do not run destructive commands. You do not commit or push. Both are majkee's.
```

# prompt-1 — Cartan (Codex, working dir `~/ia-sync`)

```
You are @Cartan working a bounded cycle of the tree-bus trial, on host home, from
~/ia-sync. Your seat is defined by ~/.codex/AGENTS.md — moving-frame discipline applies,
especially item 4: a disagreement between map and observed state is evidence, name it.

Your scope is the newest POINT here — note this is a DIFFERENT repository from your
working directory, so the path is absolute:
  ~/unikuklatrix/nablarva/.dev/session/tree-bus-01-trial/_bus/NN.oraculum.point.md

Do not exceed that scope. Do not perform adjacent improvements.

Return by writing, at the same absolute location:
  ~/unikuklatrix/nablarva/.dev/session/tree-bus-01-trial/_bus/NN.cartan.return.md
with exactly six fields:
  1. files changed (path + nature)
  2. exact commands run + their outcomes
  3. evidence paths
  4. mismatches discovered between documentation and disk
  5. recommended next task
  6. remaining uncertainty  ("none" is valid; omitting it is not)

Gates: no commit, no push, no `deploy.sh` without a --dry-run pass first, no edits to the
gated temple family (ai/temple-*.zsh, ai/temple-*.hook, ai/base.zsh, ai/adr-guard.* —
decision 0009; draft and mail the temple instead). Never `rm` — deletion is two-phase: move
to /tmp/zsh-prune-<date> and let a fresh shell verify before anything is purged.
```

## Cycles — the payload

Real leftover work from the 2026-08-25 audit. Ordered read-only → gated-destructive →
code-change, so a failure early costs least.

**Cycle 1 — trace + gated quarantine.** Trace the two UNKNOWN orphans
(`config_backup_docker.zsh`, `guides/ai.md`) to a verdict; quarantine the three `substrate.*`
files. Produces `pad.1-substrate-quarantine.md`; per PAD law STEP 0 must make the run reversible.
*Tests: can a POINT carry enough scope for Codex to work unaided?*

**Cycle 2 — `copy_file()` backup policy.** `deploy.sh` writes a dated `.bak` on every deploy and
nothing prunes. **It is not a zsh problem** — 15 `config.zsh.bak-*` in `~/.config/zsh/` AND 7
`AGENTS.md.bak-*` in `~/.codex/`, one of which is byte-identical to its current file. So the fix
is **"back up only when content differs"**, not "keep last N" — that removes most of the litter
at source, for every `copy_file` target.
*Tests: can the loop handle a real code change to load-bearing infrastructure?*
**Gate: `bash deploy.sh --dry-run` clean before any real deploy. `deploy.sh` breaks config
delivery to BOTH machines if wrong.**

**Cycle 3 — close the loop.** Run `zsh ~/ia-sync/zsh/blessings/zsh-orphans.zsh`. Confirm UNKNOWN
is 0 and that a deploy no longer accretes `.bak` in either tree. Write the trial verdict against
the stop rule and the filled ledger.
*Tests: does the loop verify its own earlier cycles?*

## Open for majkee — doctrine, not cleanup

The Codex agent roster contradicted its own doctrine: `~/.codex/agents/` held ~40 files against
source's six, mirrored there by a Codex Desktop migration on 2026-08-26 and **corrupt on arrival**
(a blind `claude`→`Codex` body rewrite). 32 quarantined 2026-08-27. `codex/AGENTS.md` still tells
**Cartan** not to mirror the Claude roster — an instruction aimed at the wrong party, since the
CLI does it regardless. That file needs a line naming
`[desktop] external-agent-import-sync-enabled`. **Gavel, not a task.**

## References

- `~/reposoma/raw.guides/runbook/GUIDE.md` — runbook shape, session rule, file set
- `~/reposoma/raw.guides/status/GUIDE.md` — `STATUS.md`, the position
- `~/reposoma/raw.guides/PAD/GUIDE.md` — operator step-pads
- `~/ia-sync/journal.host-cleanup.md` — HOME 2026-08-25 (drift) · HOME 2026-08-27 (migration)
- `~/ia-sync/zsh/blessings/zsh-orphans.zsh` — the reporter; report-only
- `~/ia-sync/AGENTS.md` §"Which host am I on?" — never trust a file's `host:` header
- nablarva `flag.md` L6 — why the promoted session lives in nablarva
