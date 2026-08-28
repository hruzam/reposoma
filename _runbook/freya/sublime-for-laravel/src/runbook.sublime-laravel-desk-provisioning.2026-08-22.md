---
title: "Runbook — Laravel Sublime desk provisioning"
date: 2026-08-22
status: ready_for_controlled_run
owner: desktop-scoped configuration agent
consultant: "@Phonon for Laravel-specific questions only"
scope: user-level Sublime configuration plus read-only Laravel verification
---

# Runbook — Laravel Sublime desk provisioning

## Decision

Use a **desktop-scoped configuration agent**, not @Phonon, as the writer.

@Phonon is the right Laravel consultant: it can decide whether a discovered
project convention, Sail setup, or Pint policy is compatible with Freya. But
its source contract is intentionally application-worktree scoped. This task
writes user-level editor state, may require a GUI interaction, and must not
turn into a Laravel feature, dependency, or repository change.

The target desk is defensible: Laravel now ships an official Sublime extension
backed by its first-party Laravel LSP. It is still very new (announced in late
July 2026), so treat the first two weeks as an observed trial rather than as a
fully mature PhpStorm replacement.

## Exact package names

Install through **Package Control** using these exact names:

| Order | Package Control name | Role | Decision |
| --- | --- | --- | --- |
| 1 | `LSP` | Sublime LSP client; prerequisite | Required |
| 2 | `LSP-Laravel` | Official Laravel Sublime extension / Laravel LSP wiring | Required |
| 3 | `Laravel Blade` | Blade syntax definition | Required |
| 4 | `GitGutter` | Git diff markers and hunk inspection | Required |
| 5 | `LSP-intelephense` | General PHP intelligence | Controlled companion trial |

Important correction to the originating brief: the official Package Control
entry is **`LSP-Laravel`**, not `Laravel`. Do not install a similarly named
community package by accident.

### The Pint correction

`Pint on save` is a **policy hook**, not a verified Package Control baseline.
Do **not** add an extra Package Control channel merely to install the
community package named `Laravel Pint`. Its public repository is tiny and its
latest release is from 2022.

Instead:

1. Verify the project-local executable first: `./vendor/bin/pint --version`.
2. Start with an explicit, one-file Pint action after review.
3. Enable automatic save-time formatting only after the project has proven that
   it causes no unwanted formatting churn.

This preserves Phonon's rule not to add dependencies or modify project
formatting policy without approval. It also avoids a formatter changing a file
while a coding agent still has it open.

Do not opt into Pint Blade formatting during this run. Laravel documents that
Blade formatting is opt-in, can involve Prettier and Node.js, and can modify
templates substantially.

## Dispatch capsule

Give the following to the desktop-scoped agent:

> You are the desk steward for one Laravel worktree. Configure only the
> user's Sublime Text package/settings area after showing the exact planned
> changes and receiving approval. Do not alter application code, Composer
> dependencies, `pint.json`, global shell configuration, Git history, remotes,
> or package channels. Read the target worktree's `AGENTS.md` and relevant
> local instructions for environment facts only. Use @Phonon as a consultant
> if Laravel/Sail/Pint conventions are unclear. Validate with existing files,
> report evidence, and leave all repository content untouched.

## Boundaries and gates

### Allowed writes after explicit operator approval

- Sublime user settings and Package Control state.
- A personal `.sublime-project` file stored **outside** the repository, if
  needed to save a per-worktree LSP choice.
- A dated backup of only the Sublime settings files that will be changed.

### Never change in this run

- Laravel application files, tests, `composer.json`, `composer.lock`,
  `pint.json`, or database state.
- Git branches, commits, stashes, remotes, or deployment configuration.
- The Package Control channel list.
- Global Composer packages, unless the operator explicitly approves the
  documented fallback after automatic Laravel-LSP provisioning has failed.

### Stop and report instead of proceeding when

- The target Laravel root cannot be identified (normally the directory holding
  `artisan`).
- The working tree is unexplainedly dirty and the proposed action would create
  a file inside it.
- Package Control does not display the exact names listed above.
- The Laravel LSP server fails and the cause is ambiguous.
- Pint is missing, or would require a dependency/configuration change.

## Preconditions

1. Ask the operator which Laravel worktree is the target and whether it uses
   local PHP or Sail.
2. Read that worktree's `AGENTS.md`, `CLAUDE.local.md`, `.dev/PROJECT.yaml`,
   and applicable rules only to learn project facts. This is a **read-only**
   reconnaissance step.
3. Record, but do not repair, the following:

   ```bash
   pwd
   git status --short
   git branch --show-current
   php --version
   composer --version
   ./vendor/bin/pint --version
   ```

   If the Pint executable is absent, record that result rather than running
   `composer require`.
4. In Sublime, open **View → Show Console** and evaluate
   `sublime.packages_path()`. On Manjaro this will normally lead to a path
   under `~/.config/sublime-text/Packages`, but the console result is the
   authority.
5. Back up only existing user settings that may change, particularly:

   - `Packages/User/Package Control.sublime-settings`
   - `Packages/User/LSP.sublime-settings`
   - `Packages/User/LSP-Laravel.sublime-settings`
   - `Packages/User/LSP-intelephense.sublime-settings`

## Installation sequence

### 1. Establish the minimal official lane

In Sublime's Command Palette, run `Package Control: Install Package` and
install, in this order:

1. `LSP`
2. `LSP-Laravel`
3. `Laravel Blade`
4. `GitGutter`

Restart Sublime once those installs finish.

The official Laravel extension has `server_path: "auto"` by default. Let that
path provision or locate the server first. Do not pre-emptively install a
second Laravel LSP server by hand.

### 2. Open the worktree with correct session scope

Open one Sublime project window whose only project root is the Laravel
worktree containing `artisan`. Do not open a parent directory that contains
several worktrees, and do not add neighbouring worktrees as extra folders.

Save a personal project file outside the repository if a per-project LSP
decision must persist.

| Desk boundary | Rule |
| --- | --- |
| Sublime window / project | Exactly one Laravel worktree |
| Laravel LSP root | Directory containing `artisan` |
| Agent writer | Exactly one checkout |
| GitGutter | Diff observation, never an invitation to revert another writer's hunk |
| Pint | One reviewed file at a time until policy is proven |

### 3. Verify Laravel LSP before adding a second PHP server

Focus an existing PHP file and an existing `.blade.php` file. Do not make a
source edit merely to test the editor.

Check all of the following:

- `Tools → Developer → Show Scope Name` reports a PHP/Blade scope compatible
  with the official extension (its selectors are `embedding.php` and
  `text.html.blade`).
- `LSP: Troubleshoot Server` reports a healthy `LSP-Laravel` server for an
  open Laravel file.
- Existing Laravel-aware locations offer useful navigation/completion, for
  example route, config, view, translation, or Eloquent usage already present
  in the project.
- Blade files retain Blade syntax highlighting.
- `GitGutter` displays the existing repository state without any hunk-revert
  action.

If the server needs its PHP environment clarified, set only the documented
initialization option, and only after the operator confirms the project mode:

```json
{
    "initialization_options": {
        "phpEnvironment": "sail"
    }
}
```

Use `"local"` instead for a local-PHP project. Leave the default `"auto"`
unchanged if it works. The default is preferable to a global override when
several projects use different environments.

If automatic server setup fails, capture `LSP: Toggle Log Panel` and
`LSP: Troubleshoot Server` output. Only with explicit approval may the agent
use Laravel's Composer fallback:

```bash
composer global require laravel/lsp
```

That fallback requires PHP 8.2 or newer and Composer's global bin directory
on the graphical Sublime process's `PATH`. Do not edit shell startup files in
this task; report the missing path to the parent/operator.

### 4. Add the general-PHP companion deliberately

Install `LSP-intelephense` through Package Control and restart Sublime.

Then test a normal PHP class/navigation action and inspect `LSP: Troubleshoot
Server`. Both LSP-Laravel and LSP-intelephense select PHP scopes, so duplicate
diagnostics or competing completion lists are possible.

If the two servers do not feel clean together:

1. Keep `LSP-Laravel` enabled for the Laravel project.
2. Save a personal Sublime project file outside the repository.
3. Use `LSP: Enable / Disable Language Server in Project` to disable
   `LSP-intelephense` for that one project.
4. Keep Intelephense available globally for non-Laravel PHP work.

Do not attempt to solve this by forcing Blade files to the plain PHP syntax;
that loses the Blade syntax lane and has historically been a weak
Intelephense workaround.

## Pint: safe staged follow-on

After the desk itself is healthy, make a separate opt-in decision:

1. Confirm `./vendor/bin/pint --version` from the Laravel root.
2. Run a read-only check on a known disposable or already-changed PHP file:

   ```bash
   ./vendor/bin/pint --test path/to/file.php
   ```

3. If the result matches project policy, run Pint manually on one reviewed PHP
   file. Inspect the diff.
4. Only then decide whether a user-level shortcut or save-time hook is worth
   enabling.

Never use `--blade` during this initial desk run. Never create/alter
`pint.json` or install Node/Prettier without a separate approved task.

## Community-informed recommendation

Keep the setup deliberately small. The official Laravel LSP now gives Sublime
the framework-aware lane it formerly lacked, while LSP-intelephense remains a
maintained and widely used general-PHP companion. The honest qualification is
that Laravel LSP and the official Sublime extension are new enough that their
interaction with a specific legacy/complex project must be observed.

Therefore:

- Keep **LSP-Laravel** as the primary Laravel lane.
- Treat **LSP-intelephense** as a trial/fallback, not an automatic second
  source of truth.
- Do not add legacy Laravel completion/snippet/highlighter packages on day
  one; they are more likely to duplicate LSP behaviour than to provide a
  missing capability.
- Do not use a third-party `Laravel Pint` package merely to obtain on-save
  formatting. The project-local official Pint executable is the authority.
- Re-evaluate after two weeks of actual Laravel work: number of LSP failures,
  duplicate diagnostic incidents, navigation usefulness, and formatting churn.

## Evidence required in the handoff

Return only:

1. The exact Package Control names installed.
2. The resolved Sublime Packages path and settings files changed (if any).
3. Which LSP servers were healthy for PHP and Blade.
4. Whether `phpEnvironment` stayed `auto` or changed, and why.
5. Whether Intelephense remained enabled for this project.
6. The Pint availability/check result, without changing code.
7. Any blocked prerequisite or one clear next action.

## Research basis — checked 2026-08-22

- [Laravel IDE support and Laravel LSP](https://laravel.com/docs/13.x/installation)
- [Official Laravel Sublime extension](https://github.com/laravel/sublime-extension)
- [LSP-Laravel on Package Control](https://packagecontrol.io/packages/LSP-Laravel)
- [LSP-intelephense on Package Control](https://packagecontrol.io/packages/LSP-intelephense)
- [Laravel Blade on Package Control](https://packagecontrol.io/packages/Laravel%20Blade)
- [GitGutter on Package Control](https://packagecontrol.io/packages/GitGutter)
- [Laravel Pint documentation](https://laravel.com/docs/13.x/pint)
- [Sublime LSP commands and troubleshooting](https://lsp.sublimetext.io/commands/)
- [Laravel LSP announcement and current ecosystem context](https://laravel-news.com/laravel-lsp-a-first-party-language-server-announced-at-laracon-us-2026)

## Source alignment

This runbook deliberately preserves the source boundaries in `phonon.toml`:
project instructions are read before work; Laravel-specific uncertainty is
escalated rather than guessed; no dependency or deployment change is folded
into editor setup; and the final handoff contains concise evidence rather than
theatre.
