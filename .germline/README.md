# .germline — the canonical, vendor-blind source

**Rule (gaveled 2026-09-25, majkee):** what lives here is the *source*; every vendor file derived
from it is a one-way, stamped rendering (`derived from <path> @ <revision> — do not edit here`).
Edit the source, re-render; never edit a rendering. Precedent: `raw.vendor-neutral-agents/ptyra/README.md`.

- `agents/<slug>/identity.md` — an agent's identity, rendered into Claude `.md` / Codex `.toml` wrappers (ia-sync table → deploy).
  **Runtime-load variant (Houston, final fold 2026-10-10):** the wrappers carry only a loader; at entry the agent
  reads `identity.md` → `binding.<vendor>.md` → the nearest project addendum → `cards/<card>.md` and quotes each
  file's `stamp:`. **Stamp rule:** every loaded germline file carries `stamp: <8-hex random token>`, unique per
  file, **regenerated on every edit** (`openssl rand -hex 4`) — a matching token proves the current file was read.
- `skills/skill.<slug>.md` — vendor-neutral methods; the chatbot skills (ChatGPT · Claude.ai) read these files as-is.

Scope: `<scope-root>/.germline/` — global root is this repo (`~/.germline` is a host symlink here, never a deploy
target); a project's own `<project>/.germline/` holds project-scoped identities and addenda, same layout.

No index here by design (discovery bus = parked, own session). Design + open decisions:
`~/ia-sync/.dev/session/invariance-autonomy/raw/master-brief.2026-09-23.md`.
