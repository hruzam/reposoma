# registry/index — the project & sibling map (first on road)

`tier: meta-repo · plane 3 · the cross-project lighthouse-of-lighthouses`
`rule: one line per project; deposit your beacon at registry/<project>.md (see README). point, never copy.`

## Projects
| project | host | status | beacon | lighthouse / contract |
|---|---|---|---|---|
| reposoma (temple / meta-repo) | office | live | — (this repo) | `temple/README.md` |
| subai.devenv | office | cleared 🟢 | [`registry/subai.devenv.md`](subai.devenv.md) | `README.md` · `PROJECT.yaml` · siblings: reposoma.devenv, piql.dev |
| reposoma.devenv | office | onboarding (§D locked) | [`registry/reposoma.devenv.md`](reposoma.devenv.md) | `CLAUDE.md` · charter `synth.restart.reposoma.md` · siblings: subai.devenv, piql.dev |
| freya.devstudio | office | active | [`registry/freya.devstudio.md`](freya.devstudio.md) | `CLAUDE.md` · `pulse.md` · `PROJECT.yaml` · siblings: piql.dev |
| piql.dev | office | active | [`registry/piql.dev.md`](piql.dev.md) | `PROJECT.yaml` · `session/mesh-state.md` · siblings: freya.devstudio, subai.devenv |
| vacuole | office | building | [`registry/vacuole.md`](vacuole.md) | `pulse.md` · `PROJECT.yaml` · `AGENTS.md` · siblings: reposoma · methods: vacuole-mini (#1), anechoic (#2) |
| nabla-lab | office | building | [`registry/nabla-lab.md`](nabla-lab.md) | `PROJECT.yaml` · `AGENTS.md` · `session/` |
| fantasyobchod | home | active/maintenance | [`registry/fantasyobchod.md`](fantasyobchod.md) | `AGENTS.md` · `CLAUDE.md` · siblings: freya.devstudio |

## Sibling-graph (who shares what)
- **subai.devenv ↔ reposoma.devenv** — share **spectral · bus/`_mail` · X→Z research · file-native medium**.
- **subai.devenv ↔ piql.dev** — share **privacy-gate** (piql's prefilter → subai's `privacy_gate` finger).
- **freya.devstudio ← piql.dev** — lineage (freya derives from the piql temple pattern).
- **piql.dev** — precursor temple/template origin; the reposoma temple is the v3 successor.
- **vacuole → reposoma** — extends the temple's **therapy + reflection-channels** practice into deliberate methods (one project; methods as modules, vacuole-mini = #1).
- **nabla-lab → [all projects]** — research supplier; shapes mathematical ideas (instrument cards, papers, seeds) into cleared artifacts that feed downstream implementations. Standalone third-party; no formal infrastructure shared yet — edges form as outputs are adopted.
> **Graph still-filling:** freya.devstudio beacon deposited (2026-06-23); edge freya.devstudio ↔ piql.dev confirmed. nabla-lab beacon deposited (2026-06-27); supplier edges open. Graph settling.

## Shared layers (cross-cutting — not projects, but teams need them)
| layer | lighthouse | what it holds |
|---|---|---|
| zsh machine layer | decision `0003` → `temple/decisions/0003-machine-provenance.md` | the machine layer (host id `$MACHINE_NAME` · per-machine resource guards · `substrate.`-parked legacy), reached through its **host-scoped decision record** — the registry never names a personal absolute path (§4.7). |
| research harness | `research/harness/` (`research-pattern` + `source-catalog`) | the shared blind-fanout study method + the source catalog; siblings upstream from here. |

> Deposit a beacon → add your row here. `./registry/projects/` retires once freya + piql are reshaped into beacons.


## `projects/`
Full project overviews live in `./registry/projects/` — read one to confirm a sibling is real and current.
- **Ask-first (token economy):** open these only if your orchestrator or the user sent you here. Don't browse on your own behalf — it burns tokens for nothing.
- Each overview is **dated** and carries a `source-of-truth:` pointer back to the project's own canon. **On any disagreement, the source files win** — the overview is a snapshot, not the truth.
That keeps your guard, fixes the rough phrasing, and adds the freshness contract (dated + source-of-truth + "source files win") — which is exactly the "be sure it's really your sibling" check.

