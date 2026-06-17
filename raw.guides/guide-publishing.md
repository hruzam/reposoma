# Guide publishing — project guides → reposoma mirror

_A core convention. How project-authored guides become readable across machines and projects
without leaving their home repo._

## The model (one-way publish)
- **Source of truth = the project.** A guide is authored and lives in its project's `guides/`
  (e.g. `piql.dev/guides/`). Its internal links to `session/…` resolve there; project agents
  read it locally; the project repo backs it up.
- **reposoma `raw.guides/` = generated, read-only mirror.** A publish step copies each guide
  into reposoma, categorized. The mirror is how the **home machine** (and other projects) get
  the guide — they pull the already-synced reposoma repo, not the project repo.
- **One-way only:** project → reposoma. Never hand-edit the mirror — every synced file carries a
  `<!-- PUBLISHED MIRROR · do not edit here -->` banner. Edit the source, then re-sync.

Why this shape: home needs cross-machine guides without cloning each project; the project keeps a
full backup; no fragile per-file git-ignore selection; and project agents are unaffected (the
source never moves).

## Categories under `raw.guides/`
- `reach/` — pc↔pc / cross-machine, project-agnostic (SSH, Tailscale/mesh, tunnels, wake, bring-up).
- `<project>/` — that project's own operator/app guides (e.g. `piql/`).
- top-level — temple-wide guides (`bootstrap-new-project.md`, `onboarding-kit.md`, this file).

## The tool (machine-local, office-side — where sources live)
- Command: **`sync-guides`** (zsh function).
- Script: `~/.config/zsh/sync/guides.zsh` (sourced from `~/.config/zsh/config.zsh`).
- Registry: `~/.config/zsh/registries/config.sync.json`.
- Behavior: reads the registry, copies each `src` → `dst` with the banner, idempotent (source is
  truth, overwrites the mirror each run), prints one line per item + a `synced N · skipped M`
  summary, exits non-zero if any configured source is missing. Needs `jq`.

## Registry schema
```json
{
  "reposoma_root": "/home/hruzam/reposoma",
  "projects": [
    {
      "name": "piql.dev",
      "guides_dir": "/home/hruzam/www/piql/piql.dev/guides",
      "publish": [
        { "src": "ssh-self-service.md", "dst": "raw.guides/reach/ssh-self-service.md" },
        { "src": "piql.md",             "dst": "raw.guides/piql/piql.md" }
      ]
    }
  ]
}
```
`SRC = guides_dir + "/" + src` · `DST = reposoma_root + "/" + dst`.

## Add a guide to publishing
1. Write/edit the guide in the project's `guides/`.
2. Add a `{ "src", "dst" }` item to that project's `publish` array (pick the right category folder).
3. Run `sync-guides`.
4. Review `git -C ~/reposoma status`, then commit + push reposoma → the home machine pulls it.

## Caveats
- Office-side tool (the project sources live on office). Home only *consumes* the mirror.
- These guides have no YAML frontmatter, so the top banner is safe. A future frontmatter guide
  would need the banner inserted *after* the frontmatter — adjust the tool if that case appears.
