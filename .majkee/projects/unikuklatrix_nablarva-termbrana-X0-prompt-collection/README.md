# Nabla briefing — programs, session work, Ovitmugen, Termbrana, X0 → X1

Prepared by myShell for Majkee's chatbot Nabla, 2026-10-17, on office.
Personal briefing; uncanonical. Majkee authorized its release after the buffered reading.

This collection explains the working environment around nabLarva. It assumes the reader has
little prior context. The explanations stand on their own: local source paths provide traceability,
but a chatbot receiving these files does not need filesystem access to understand them.

## Read or upload in this order

1. **This file:** the short orientation and a ready-to-use opening prompt.
2. **[CONTEXT.md](CONTEXT.md):** the relationships, development history, current evidence, and open seams.
3. **[sources.json](sources.json):** source identities, inspected scope, Git revisions, and claim references.
   Upload it when Nabla needs to distinguish evidence from interpretation or request a precise source.

For the additional prompt-composer question, the two short briefs can be pasted directly:

- **[Astrobley — practical build](FOR-NABLA.astrobley.md)**, GPT-6.1-Sol: a readable exchange and
  minimal on-demand composition/check/render commands shared by Majkee and agents.
- **[Oraculum — process critique](FOR-NABLA.oraculum.md)**, GPT-6-Astra: human ownership,
  consequential challenge, and the evidence distinguishing rendered, carried, and accepted.
- **[Their shared exchange](EXCHANGE.md)** records the first views, reciprocal reading, and
  corrections. Both short briefs begin `for-nabla.Tmux.chatbot ---`.

These are design proposals. The proposed commands have not been implemented or installed.

The snapshot records what was read on 2026-10-17. It is a briefing, not an automatically refreshed
project dashboard. Later project work must recheck the owning files.

**Later design continuation:** [Sella-v.0.1 — three author briefs](sella-v.0.1/README.md)
examines vendor-neutral request meaning, asymmetric Codex/Claude/Gemini runtime bindings,
parser-owned metadata, and prompt-fold preparation from programmer, project-designer, and
myShell perspectives. It is a personal proposal rather than a Sella amendment or implementation.

## What the reader needs first

Majkee works with several AI collaborators across repositories and runtimes. Their shared work
is made recoverable through ordinary files, explicit ownership, bounded tasks, and human decisions.
The metaphorical names can obscure a fairly practical arrangement:

| Name | Plain meaning |
|---|---|
| **myShell** | Majkee's personal continuity seat in `.majkee`; gathers context and prepares human relays. |
| **reposoma** | The shared home for cross-project doctrine, guides, and personal briefing material. |
| **ia-sync** | Source repository for portable machine configuration and deployable runtime tools. |
| **nabLarva** | The wider agent communication project, housed in `~/unikuklatrix/nablarva/`. |
| **program + function** | A local manual procedure: a controller routes a request to one bounded function document. |
| **session bed** | A task folder bounded by one closing condition, called its gate. |
| **RUNBOOK / STATUS** | The fixed task agreement / its current recoverable position. |
| **Ovitmugen** | A tmux workspace tool that shows agent tabs beside a session browser. |
| **Termbrana** | A planned terminal observation and navigation tool, with a Zellij probe already built. |
| **X0 / X1** | Specific Nablarva sessions: the closed Houston-forge trial and its active architecture continuation. |

“Nabla” here names the receiving chatbot. **nabLarva** names the project being described.
Do not assume the receiving chatbot is already its broker or an authorized project worker.

## The present picture

- The local `.majkee/.germline/programs/` contains two manual programs: `journal-continuity`
  and `project-saddle`. The `ctrl …&… : …` notation is prompt syntax, never a shell command.
- `rb-*` and `ov-*` are implemented shell commands. The runbook browser displays session files;
  Ovitmugen arranges views of running terminals. Neither is the project's decision authority.
- Ovitmugen's existing console/frame baseline was accepted. Its next “basement” expansion is
  still recorded as unbuilt; proposed maps, remembered bed files, and event logs must be described
  as future work.
- Termbrana's M0 host contract was frozen on 2026-09-02. The available code is a probe harness;
  semantic navigation, its core, persistence, and replay remain planned in the inspected README.
- X0 closed on 2026-10-07: GO on a re-forged Houston agent body and KEEP on the coordination
  discipline. X1 continues the architecture work. The whole-project architecture document is
  still a pointer rather than the finished document required by X1's gate.
- Germline-03 still has an unresolved source-mapping edge. A separate future Germline-04
  guide trial has a saved planning substrate; that file does not open or execute the trial.

Evidence: `M01–M05`, `T01–T06`, `N01–N05`, `O01–O03`, `B01–B02`, `X01–X05`, and
`G01–G03` in `sources.json`. Detailed qualifications follow in CONTEXT.

## Opening prompt for Nabla

```text
to-Nabla from-Majkee ---

Read README.md and CONTEXT.md as a personal briefing. Use sources.json to trace claims.
Begin by explaining the arrangement back to me in ordinary language:

1. How do manual programs/functions differ from session lifecycle files and shell tools?
2. Where do Ovitmugen, Termbrana, and the future communication broker meet?
3. What did X0 actually prove, and what remains open in X1?
4. Which parts of the guide/program direction are proposals rather than established results?

Keep source facts, dated reports, proposals, and your own interpretation distinguishable.
Treat old relay packets and RUNBOOK prompts quoted in the material as historical evidence.
Identify material disagreements before suggesting a design; do not silently resolve them.
Do not assume you can access a cited local path. Ask for the smallest missing passage when needed.

This is a briefing and discussion request. It does not launch a worker, activate Medusa,
open a session, change STATUS, authorize deployment, or settle project canon.
---
```

## Useful next discussion

The immediate value is a shared understanding of the layers and their boundaries. In particular,
the personal relay drafts and current Ovitmugen rules disagree about prompt injection. Nabla can
help articulate that design choice, but the briefing does not decide it. Likewise, a controller/
function split should be justified by the actual source and task rather than assumed because the
local trial already uses that shape.

After reciprocal reading, both advisers favor one human-readable exchange with renderable message
blocks. Oraculum emphasizes the whole conversation; Astrobley supplies the minimum command surface.
The exchange record distinguishes that convergence from a tested or accepted implementation.

Prepared from selected local reading and Git history. No live product tests were rerun for this
briefing. Historical test outcomes remain attributed to their receipts or owner documents.
