# substrate.temple.liveness-layer — UNIX-native 24/7 layer (concept, HOLD)

- **status:** HOLD — concept ready, build deliberately withheld
- **trigger:** notifier un-park OR doorbell re-ring accumulation reaches wall
  (both are T2 wall candidates on the pulse.claude.md live board — same
  wait-for-the-wall gavel governs this object)
- **born:** 2026-07-15 · Atlas, Fable seat — operator-sanctioned concept pass
  ("punk pass") ahead of Houston reincarnation; majkee agreed with the lean
  (concept-now, build-on-wall). This is NOT a build directive.
- **sources:** Edwin catch
  (`raw.research/ai-news/majkees-catches/edwin-autonomous-team.2026-07-14.md`)
  × nabla-lab research lines: Three Spines axioms A1–A3
  (`nabla-lab/drafts/three-spines-orchestration.md`) · agentive fold sections B/E/I
  (`raw.research/nature/report/agentive-fold.from-raw.2026-07-13.md`)

---

## ⚠ Routing guard — Oraculum HOLD

This object intersects the sealed nature-research synthesis chain. **Do not route to
or surface for @Oraculum until her three-study synthesis lands** (anti-priming: the
chain's value is unprimed triangulation; a side-channel datum mid-run contaminates
it). After her synthesis lands, the convergence datum below (§ invariant 3) becomes
a legitimate post-hoc confirmation input — route it then, through Houston.

---

## Core observation

Edwin (field datum, n=1 hobbyist, honest) proved empirically that **the ops layer of
an agent system is a commodity** — his n8n orchestration died as dead weight; plain
OS-native launchd scripts won. This independently re-confirms the temple meta-finding
("larva died of mechanism, its method survived").

Both nabla-lab research lines locate the *value* layer in the substrate instead:
Three Spines requires a measurable, uniform, append-only text medium (axioms A1–A3 —
"truth lives in files, resonance in streams"); the agentive fold maps an entire
memory architecture onto a coordinator-free file-backed mesh.

**The temple already owns that substrate.** The `_mail` bus + pulse files + append-only
discipline is the medium both researches presuppose. Edwin had to build a token-guarded
HTTP API between agents (opaque, unmeasurable, and the source of his auth scar);
temple agents talk through files — filesystem permissions ARE the auth, and a file bus
is measurable, which is what the field mathematics needs. His architecture cannot grow
the nabla brain; ours already has the spine for it.

Conclusion: a temple 24/7 layer needs **no third-party engine** — no Slack, no n8n,
no message broker. The OS + the existing bus cover every slot.

## Slot decomposition (Edwin → temple → UNIX-native fill)

| Slot | Edwin | Temple today | Fill when wall fires |
|---|---|---|---|
| Inter-agent transport | token HTTP API | `_mail` file bus | **done — superior form** (measurable, greppable, auth = filesystem) |
| Orchestrator | ORACLE | Houston/Oraculum + CapCom + `houston.goal` | done |
| Brains | Claude API + Ollama backup | same position | done |
| Liveness | launchd + KeepAlive + watchdog | none (by design) | systemd **user units**: `Restart=on-failure` = KeepAlive · `WatchdogSec` = watchdog · timer units = cron. Zero new deps |
| Wake-on-event | Slack message → bot | doorbell (pull at saddle only) | systemd **path units** watching `_mail/*/inbox/` → new mail file wakes a headless seat (`claude -p`) **through the CapCom gate** |
| Push digest / remote control | Slack channels · 20:00 digest | missing | timer unit → small script compiles pulse deltas since last stamp → one file. Last push hop to operator (self-hosted ntfy / mail / synced folder) = the ONLY third-party decision, quarantined to one dumb pipe |

Build size when triggered: **2–3 systemd user units + one digest script.** The file bus
already did the hard part.

## Design invariants (carry into any build)

1. **Wake is a signal; context is pulled.** Daemons wake seats; the woken seat runs its
   saddle ritual and *pulls* state. Never push context at a seat (agentive fold B,
   sink-generated pull; also token economy). Edwin's clock-driven push digest violates
   this — ours must not.
2. **Autonomy below the gavel line.** Daemons may execute and report; nothing locks
   canon unattended (0002 / Force 4 holds under automation). Edwin reports after the
   fact; the temple gates before it. CapCom is the already-shaped gate — reuse, don't
   reinvent.
3. **Control plane ≠ data plane** — triangulated ×3 unprimed voices: agentive fold §E
   (derived) · Three Spines A3 (axiomatized) · Edwin (stumbled into it empirically:
   small signal API + channels, bulk work elsewhere). Meets the lab's convergence
   standard. Signal events ride the bus; bulk context never does.
4. **Hysteretic triggers** (agentive fold §I): watchdog restarts and digest/alert mode
   transitions fire on *trajectory* (state fell AND stayed fallen), never on
   instantaneous level — prevents flap-storms, Edwin's scar #2 class.

## Known risks (pre-logged for the build session)

- **Headless model-pin gotcha (already observed):** agents pinned `model: fable`
  400 at headless startup; fallbackModel does not fix it
  (`~/.claude/projects/-home-hruzam-reposoma/memory/` — fable-pins-headless-gotcha).
  Any path-unit wake must spawn seats whose pins are headless-safe, or strip pins.
- **Unattended token burn:** headless wakes need a per-run budget ceiling + a
  no-retry-loop rule (watchdog restarts the *daemon*, never re-fires the *seat* on
  failure without a hysteresis window).
- **Single-writer discipline under automation:** a woken seat writes only its own
  pulse/mail files — the invariant that keeps the bus debuggable must survive the
  humans-asleep case.

## The brake (why HOLD, restated)

No standing task stream currently justifies daemons (mechanism-before-method, n=0).
Edwin's own n8n corpse is the field warning about building orchestration ahead of
need. The concept sits ready; the wall names the day.
