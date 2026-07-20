# registry/index — the project & sibling map (first on road)

`tier: meta-repo · plane 3 · the cross-project lighthouse-of-lighthouses`
`rule: one line per project; deposit your beacon at registry/<project>.md (see README). point, never copy.`

## Projects
| project | host | status | beacon | lighthouse / contract |
|---|---|---|---|---|
| reposoma (temple / meta-repo) | office | live | — (this repo) | `temple/README.md` |
| subai.devenv | office | cleared 🟢 | [`registry/subai.devenv.md`](subai.devenv.md) | `README.md` · `PROJECT.yaml` · siblings: reposoma.devenv, piql.dev |
| reposoma.devenv | office | onboarding (§D locked) | [`registry/reposoma.devenv.md`](reposoma.devenv.md) | `CLAUDE.md` · charter `synth.restart.reposoma.md` · siblings: subai.devenv, piql.dev |
| freya | office | active | beacon pending | `AGENTS.md` · `CLAUDE.md` · siblings: piql.dev, fantasyobchod, applications-in-common |
| freya.devenv | office | active | beacon pending | `CLAUDE.md` · `flag.md` · siblings: freya |
| piql.dev | office | active | [`registry/piql.dev.md`](piql.dev.md) | `PROJECT.yaml` · `session/mesh-state.md` · siblings: freya, subai.devenv |
| vacuole | office | building | [`registry/vacuole.md`](vacuole.md) | `pulse.md` · `PROJECT.yaml` · `AGENTS.md` · siblings: reposoma · methods: vacuole-mini (#1), anechoic (#2) |
| nabla-lab | office | building | [`registry/nabla-lab.md`](nabla-lab.md) | `PROJECT.yaml` · `AGENTS.md` · `session/` · siblings: applications-in-common |
| fantasyobchod | home | active/maintenance | [`registry/fantasyobchod.md`](fantasyobchod.md) | `AGENTS.md` · `CLAUDE.md` · siblings: freya |
| psdvsSys | home | active/bootstrap | [`registry/psdvsSys.md`](psdvsSys.md) | `AGENTS.md` · `.dev/PROJECT.yaml` · `.dev/flag.md` |
| applications-in-common | home | active/bootstrap | [`registry/applications-in-common.md`](applications-in-common.md) | `AGENTS.md` · `.dev/PROJECT.yaml` · `.dev/hypotheses.md` · siblings: freya, nabla-lab |

## Sibling-graph (who shares what)
- **subai.devenv ↔ reposoma.devenv** — share **spectral · bus/`_mail` · X→Z research · file-native medium**.
- **subai.devenv ↔ piql.dev** — share **privacy-gate** (piql's prefilter → subai's `privacy_gate` finger).
- **freya ← piql.dev** — lineage (freya derives from the piql temple pattern).
- **piql.dev** — precursor temple/template origin; the reposoma temple is the v3 successor.
- **vacuole → reposoma** — extends the temple's **therapy + reflection-channels** practice into deliberate methods (one project; methods as modules, vacuole-mini = #1).
- **nabla-lab → [all projects]** — research supplier; shapes mathematical ideas (instrument cards, papers, seeds) into cleared artifacts that feed downstream implementations. Standalone third-party; no formal infrastructure shared yet — edges form as outputs are adopted.
- **applications-in-common ↔ freya** — share **ui-bricks**: element patterns proven in the playground (`bricks/`, provenance-headed) are adoption candidates for freya UI; freya's element questions seed playground hypotheses. Scopes stay separate — playground tests, freya ships.
- **nabla-lab → applications-in-common** — first named supplier edge: the lab shapes ideas; the playground is the grounded practical sibling (mechanisms tested against reality via the H-ledger, survivors promoted as bricks). Deliberately NOT one project — different scope, shared usage as outputs mature.
> **Graph still-filling:** freya + freya.devenv added 2026-07-20 (unmounted from freya.devstudio; beacons pending; devstudio retired). nabla-lab beacon deposited (2026-06-27); supplier edges open. Graph settling.

## Shared layers (cross-cutting — not projects, but teams need them)
| layer | lighthouse | what it holds |
|---|---|---|
| zsh machine layer | decision `0003` → `temple/decisions/0003-machine-provenance.md` | the machine layer (host id `$MACHINE_NAME` · per-machine resource guards · `substrate.`-parked legacy), reached through its **host-scoped decision record** — the registry never names a personal absolute path (§4.7). Physical root paths for registry projects live in `temple-project-map.zsh` (machine layer · decision 0008) — the disk companion to this index; shared across machines (folder layout is 1:1). |
| research harness | `raw.research/harness/` (`research-pattern` + `source-catalog`) | the shared blind-fanout study method + the source catalog; siblings upstream from here. |

> Deposit a beacon → add your row here. `./registry/projects/` retires once freya + piql beacons are deposited (freya rows added 2026-07-20 — beacons pending).


## `projects/`
Full project overviews live in `./registry/projects/` — read one to confirm a sibling is real and current.
- **Ask-first (token economy):** open these only if your orchestrator or the user sent you here. Don't browse on your own behalf — it burns tokens for nothing.
- Each overview is **dated** and carries a `source-of-truth:` pointer back to the project's own canon. **On any disagreement, the source files win** — the overview is a snapshot, not the truth.

