---
produced: 2026-06-19
by: trajectory (senior)
status: BLOCKED — primary docs unreachable; operator gavel required before live deployment
---

# agy seat materialization — format findings and STOP report

## What was attempted

Decision 0005 directed materialization of three vendor-neutral seat definitions (Orby,
Astrobley, Vega) into the agy (Antigravity CLI) runtime as supervised on-demand seats.
This report documents what was found, what could not be confirmed, and what the operator
must decide before anything is written to `~/.gemini/`.

---

## Critical finding: agy does not have the concept Decision 0005 assumes

**The old Gemini CLI** had `~/.gemini/agents/<name>.md` — static, file-backed, named agent
definitions with YAML frontmatter. Decision 0005 was designed for that pattern.

**agy retired that pattern at launch (June 2026).** From two independent Epoch research runs
on 2026-06-19, both converging at CONFIDENCE M (primary docs unreachable, reliable community
sources agree):

> "Antigravity CLI supports dynamic subagents and needs no upfront markdown configuration
> files. This is why we removed the `agents/` folder."
> — Giovanni Galloro, Google Cloud Community / Medium, June 2026

The `agents/<name>.md` input paradigm does not exist in agy. The `/agents` slash command
in the TUI lists *runtime-dynamic* subagents the main agent spawns itself — not file-backed
seat definitions.

---

## What agy's authorable format IS

The closest agy analog is **Skills** — `.agents/skills/<folder>/SKILL.md` at project level,
or `~/.gemini/skills/<folder>/SKILL.md` globally (path also unconfirmed; see conflicts below).

Confirmed SKILL.md frontmatter fields (CONFIDENCE M — community sources, not primary docs):
```yaml
---
name: <identifier>
description: <text agy uses to auto-activate the skill>
---
```

**NOT present in Skills frontmatter:**
- `model:` — model tier is NOT file-enforceable per-seat; set session-level via `/model`
- `tools:` / `permissions:` — tool scoping is NOT file-enforceable per-seat; set via
  `/permissions` in the agy TUI at spawn

**A Skill is not a seat.** A Skill auto-activates when its description matches context.
A seat is something you deliberately spawn, named, on-demand. These are different invocation
models. Mapping the three seats to SKILL.md is lossy in a category-level way, not just in
field coverage.

---

## The three layers Decision 0005 needs — where agy puts them

| What the spec needs | agy mechanism | File-authorable? |
|---|---|---|
| Named seat identity + body/system-prompt | SKILL.md body | Yes (M confidence) |
| Model tier per seat | Session `/model` at spawn | No per-seat file field |
| Tool scope per seat | Session `/permissions` at spawn | No per-seat file field |
| MCP per seat | `~/.gemini/config/mcp_config.json` (global) or `.agents/mcp_config.json` (project) | Yes, but shared |

---

## Model tier mapping (what is known)

| Tier | agy label | Confirmed? | Source |
|---|---|---|---|
| Mid | Gemini 3.5 Flash (Medium) | YES — observed in agy log 2026-06-19 | `/home/hruzam/.gemini/antigravity-cli/log/cli-20260619_125419.log` line 49 |
| Top | "Ultra" (card.gty) / "Pro or Next" (gemini-cli card, app.md) | UNCONFIRMED — label conflict | card.gty.md vs raw.card.gemini-cli.md |

Top-tier model string must be verified by the operator via `agy /model` list at runtime
before any seat definition hard-codes a model name.

---

## MCP status (Orby)

Orby requires: **no MCP at all.** Native Google Search grounding handles web research.
No search MCP (context7, Brave, Serper). No filesystem MCP (Orby returns inline output,
not files). Existing `~/.gemini/config/mcp_config.json` is empty — leave it untouched.

This is the correct design per card.gty ("prefer native grounding over heavy external search
MCP servers") and per Orby's own staged definition.

---

## What is NOT in `~/.gemini/` and will not be touched

Nothing was written to `~/.gemini/` or any live agy config path. The three drafts
live only at:

```
/home/hruzam/reposoma/raw.settings/agents-staging/agy/
  orby.SKILL.md       — staged, format UNVERIFIED, model/tools NOT file-enforceable
  astrobley.SKILL.md  — staged, format UNVERIFIED, model/tools NOT file-enforceable
  vega.SKILL.md       — staged, format UNVERIFIED, model/tools NOT file-enforceable
  FORMAT-FINDINGS.md  — this file
```

---

## Why primary docs were unreachable

Two Epoch runs on 2026-06-19 attempted WebFetch against:
- `antigravity.google/docs`
- `antigravity.google/docs/skills`
- `antigravity.google/docs/plugins`
- `antigravity.google/docs/subagents`
- `antigravity.google/docs/gcli-migration`

All returned empty HTML shells. Assessment: auth-gated or geo-gated. These pages must be
read from a network where the domain resolves with content. The plugin/subagent config schema
(`antigravity.google/docs/plugins`, `/docs/subagents`) is the specific unknown that could
resolve the "is there a file-level mechanism for model+tools per custom agent?" question.

---

## Smoke-load result

Not run. Bash execution was denied in this session (file-write tools only). The smoke-load
step (task point 5) is unexecutable without Bash.

---

## Operator decisions required before live deployment

1. **Gavel the invocation model question:** Is SKILL auto-trigger acceptable for these seats,
   or do they need an on-demand invocation mechanism? If the latter, confirm whether agy's
   plugin system provides it (requires accessing `antigravity.google/docs/plugins` from a
   live network).

2. **Confirm the top-tier model string:** Run `agy` in TUI, open `/model`, record the exact
   string for the top-tier model. Needed for Vega (top-tier) and Astrobley elevation.

3. **Confirm the global Skills path:** Is it `~/.gemini/skills/` or
   `~/.gemini/antigravity-cli/skills/`? Test by placing a SKILL.md at each and checking
   `/skills` in the agy TUI. The path conflict was unresolved across community sources.

4. **If plugin config exists with model+tools fields:** Rework the three drafts in that
   format. The SKILL.md drafts here are a best-available translation — not the target if
   a richer config exists.

5. **API key restriction:** Confirm the active `GEMINI_API_KEY` has "Restrict to Gemini API
   only" applied in Google AI Studio (Finding 3 in epoch-2026-06-19-gemini-build.md —
   unrestricted keys began failing 2026-06-19).

---

## What the operator can do immediately (supervised TTY, no gavel needed)

Use Orby, Astrobley, and Vega NOW in supervised agy sessions by:
1. Opening agy in a terminal (TTY, authenticated via keyring — confirmed working).
2. Pasting the body of the relevant SKILL.md into the chat as a system-role injection.
3. Setting the model via `/model` (Flash for Orby/Astrobley-default; top-tier for Vega
   and Astrobley-elevated).
4. Setting permissions via `/permissions` to match the seat's tool scope.

This is "supervised on-demand" per Decision 0005 — the file mechanism is just unconfirmed.
