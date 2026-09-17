# Founding intake — jar-kuba (a neutral tailoring "brick")

> Founding record. Fills the `project-intake.md` A–G shape. Produces the project card
> at `raw.settings/raw.card.jar-kuba.md` after the first real work session
> (`/project-regular-self-report jar-kuba`, Phase 2 — reads this file automatically).
> Filed 2026-09-15. Bed cut same day (flat, Laravel, local-only).

---

## A · Identity

- **Slug:** `jar-kuba` (lowercase-hyphen; normalized 2026-09-15, operator blessed)
- **Scope-group:** `kuklana` (new)  ·  **Path:** `~/www/kuklana/jar-kuba`
- **Working brand:** Chalk & Thread (demo only — the core is brand-neutral)
- **Purpose:** A **neutral tailoring brick** — a customer's photo ("make me this") +
  tailor measurements + a chosen cut becomes a workshop-ready **cut**, drawing on a
  reusable **bank of cuts**. Operated end-to-end by non-programmers via an inner agent-net.
- **Architecture stance:** *neutral core + venue as a seam.* Venue #1 = a plain tailor
  shop (real pilot: a friend's workshop); Freya's fantasy/LARP-costume workshop plugs in
  later as config, not a fork. **Pilot now, product-shaped bed.**

## B · Nature of work (domains)

- Thin **web** (storefront) + a heavy **app** (the engine — the weight) in ONE repo,
  split internally (socket #1).
- **Cut-bank:** reusable base blocks; one customer's cut becomes another's start.
- **Deterministic cut engine:** measurements + chosen base block → adjusted cut.
- **Vendor-neutral vision + preview** seam (Gemini / Anthropic / OpenAI).
- **Inner agent-net:** self-describing harness so non-programmers drive it via agents.
- Adjacent: pattern-drafting math, e-commerce ops.

## C · The contract  → PROJECT.yaml (written)

- `harness.shape: flat` · `authoring: project` · branch `core` · host `office`
- **Stack:** Laravel · PHP 8 (front-end + DB decided at Phase 1).
- **Runtime:** local browser dev only for now (no remote hosting).
- **Docs entry point:** `AGENTS.md`
- **Hard constraints (LOCKED — flag L1–L8):** deterministic sizing · vendor-neutral
  vision · commercial-clean licensing · non-programmer operability · honesty rule ·
  neutral core / venue as config · app+web one repo (socket #1).

## The sockets (the main design surface)

1. **Site ↔ app** — thin storefront over the neutral engine (extractable later).
2. **Vision** — `describe_garment(photo)` → garment spec (vendor-swappable).
3. **Preview / render** — "dress yourself" (SVG sketch default; photoreal via MCP later).
4. **Voice → intent** — spoken wish → parsed change → updated preview.
5. **Cut-bank** — base blocks ↔ per-customer adjustment; save & reuse.
6. **Venue** — per-venue config over the neutral core.
7. **Workshop output** — adjusted cut → cutting docket / export.

## D · Teams & the one head

- Bootstrap with **four seats only** (architect = head / challenger / researcher /
  implementer). No domain seats pre-granted; grow by earned load.
- `atlas-auto` builds the inner agent-net **after** the manifest specifies it.

## E · Volume & cadence

- Solo developer (majkee); holds Anthropic + OpenAI subscriptions.
- Also an **agentive-development testbed** (dev / user / customer, all agent-facing).
- Sessions under `.dev/session/`; cross-host later via `git pull` on `core`.

## F · Live state (Model-C sizing)

- Bed cut 2026-09-15 (flat). Concept demo live (Chalk & Thread artifact).
- Venue #1 = plain tailor shop (real pilot). Freya's fantasy/LARP venue queued.
- Near-term goal: **something working to show** — a graphical cut-design-over-photo
  tool + cut-bank.

## G · Out of scope (v1)

- Real fit / draping simulation (2D preview only; photoreal via MCP→Gemini optional).
- Photo-derived **authoritative** measurements (assistive draft only).
- Payments / logistics until the core loop is proven.
- Any self-hosted VTON model (licensing).
- Full multi-tenant SaaS — only the venue *seam* now, not the account machinery.
