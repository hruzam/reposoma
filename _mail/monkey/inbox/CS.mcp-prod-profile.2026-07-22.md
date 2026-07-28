CS · 2026-07-22 · mariadb-prod MCP write profile

commit : a82046cde (hotfix/festival-kasa)   # fo repo, session-start snapshot;
                                            # mariadb-mcp changes UNCOMMITTED in its own repo
task   : prod write profile for own mariadb-mcp — code DONE, connectivity UNKNOWN
context: execute() gated: INSERT/UPDATE/DELETE/CREATE only, WHERE-guard on, 5s
         DB-side timeout. config.prod.php = placeholders, you fill creds by hand.
         Single blocker: does prod (old.imago.cz) have SSH? Adminer proves nothing.
resume : fo → open .dev/session/mcp-prod-profile/pad.1-prod-access.md — run the
         5 steps, fill >MAJKEE reports; verdict decides tunnel/whitelist/park.
         Next incarnation: handoff.json in the same dir.
