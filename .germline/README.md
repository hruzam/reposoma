# .germline — the canonical, vendor-blind source

**Rule (gaveled 2026-09-25, majkee):** what lives here is the *source*; every vendor file derived
from it is a one-way, stamped rendering (`derived from <path> @ <revision> — do not edit here`).
Edit the source, re-render; never edit a rendering. Precedent: `raw.vendor-neutral-agents/ptyra/README.md`.

- `agents/<slug>/identity.md` — an agent's identity, rendered into Claude `.md` / Codex `.toml` wrappers (ia-sync table → deploy).
- `skills/skill.<slug>.md` — vendor-neutral methods; the chatbot skills (ChatGPT · Claude.ai) read these files as-is.

Scope: `<scope-root>/.germline/` — global root is this repo (`~/.germline` is a host symlink here, never a deploy
target); a project's own `<project>/.germline/` holds project-scoped identities and addenda, same layout.

No index here by design (discovery bus = parked, own session). Design + open decisions:
`~/ia-sync/.dev/session/invariance-autonomy/raw/master-brief.2026-09-23.md`.
