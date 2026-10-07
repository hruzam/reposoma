---
chapter-of: germline-forge
title: checks — the three commands as run, who/when, the failure each one catches
verified: 2026-10-07 · commands run in zsh from the package root during the Houston forge (three freezes); each failure mode below was observed, not imagined
---

# checks — three questions a derived render must answer

`run from the package root (the directory holding README.md) in zsh. Paths below are the Houston forge's; a new forge substitutes its slug and vendors.`

## 1 · `verify_cmd` — are these the bytes that were reviewed?

```zsh
git hash-object -- germline/agents/<slug>/identity.md project/<project>.md binding/claude.md binding/codex.md render/claude/<slug>.md render/codex/<slug>.md \
  | diff -u <(printf '%s\n' <blob-identity> <blob-addendum> <blob-binding-claude> <blob-binding-codex> <blob-render-claude> <blob-render-codex>) -
```

Exit 0 = unchanged since the README's manifest. The README is **excluded** from its own hash
(no self-hash cycle). `git hash-object` identifies uncommitted bytes without storing them — a
blob is a review pin, not proof that git holds the file.

**Catches:** any edit anywhere. **Misses:** a render whose sections no longer match their
sources *when the manifest was pinned after the drift* — which is why check 2 exists.

## 2 · Body equality — do the render's sections equal their sources?

```zsh
body(){ awk 'BEGIN{n=0} /^---$/ && n<2 {n++; next} n==2 {print}' "$1"; }     # bytes after the 2nd ---
sect(){ sed -n "/^<!-- $2 -->$/,/^<!-- \/$2 -->$/p" "$1" | sed '1d;$d'; }   # between the marker pair
diff <(sect render/claude/<slug>.md identity) <(body germline/agents/<slug>/identity.md)
diff <(sect render/claude/<slug>.md addendum) <(body project/<project>.md)
diff <(sect render/claude/<slug>.md binding)  <(body binding/claude.md)
diff <(sect render/codex/<slug>.md  identity) <(body germline/agents/<slug>/identity.md)
diff <(sect render/codex/<slug>.md  addendum) <(body project/<project>.md)
diff <(sect render/codex/<slug>.md  binding)  <(body binding/codex.md)
for m in identity /identity addendum /addendum binding /binding; do grep -c "^<!-- $m -->$" render/*/<slug>.md; done   # every count = 1
```

Each line must exit 0; a later pass does not erase an earlier failure. The body boundary is
"bytes after the closing delimiter of the leading YAML frontmatter" — counted explicitly; a
`sed '1,/^---$/d'` one-liner deleted the whole body on this host (cartan, RETURN 15 §5).

**Catches:** a render composed from older source bytes (day one of the forge: `verify_cmd`
green, two sections differed); a forgotten binding source; a hand edit inside a render.
**Misses:** a frontmatter-only source change (bodies identical) — check 3.

## 3 · Stamp currency — does each stamp element pin the current source?

```zsh
for r in claude codex; do
  R=render/$r/<slug>.md; s=$(awk 'BEGIN{n=0} /^---$/ && n<2 {n++; next} n==2 {print; exit}' "$R")   # first body line = stamp
  for f in germline/agents/<slug>/identity.md project/<project>.md binding/$r.md; do
    b=$(git hash-object "$f"); case "$s" in *"$b"*) ;; *) echo "STALE STAMP: $R does not pin current $f ($b)";; esac
  done
done
```

Silent = current. The stamp form is
`derived from <identity canonical> @ <blob>; <addendum canonical> @ <blob>; <binding canonical> @ <blob> — do not edit here`.
An `UNASSIGNED-…` element or a workbench path in a stamp fails review.

**Catches:** metadata-only edits (`renders:`, `state:`, `verified:`) after a partner recomposed —
seen twice. **Misses:** nothing the other two catch; together the three are complete for bytes.
None of them proves behaviour (chapter `witness`) or canon (promotion).

## 4 · Who runs what, when

| who | when | runs |
|---|---|---|
| each source/render writer | before returning any change | 1 · 2 · 3 |
| the carrier / head | before dispatching any POINT that touches the package | 1 · 2 · 3 |
| the gate reviewer | first step of "body matches the lock", then a **composition read** | 1 · 2 · 3 + read |
| the witness | static part of every round | 1 · 2 · 3 + frontmatter parses + stamp pins the three blobs |

## 5 · Composition by pipeline (the only way the checks stay green)

```zsh
# sources final → compose (identity → addendum → binding), never type a render
{ awk 'BEGIN{n=0} {print} /^---$/ {n++; if(n==2) exit}' "$R"          # keep the render's frontmatter
  printf 'derived from %s @ %s; %s @ %s; %s @ %s — do not edit here\n' "$ID_CANON" "$(git hash-object $ID)" "$AD_CANON" "$(git hash-object $AD)" "$BC_CANON" "$(git hash-object $BC)"
  printf '<!-- render: <vendor> · state: … -->\n\n'
  echo '<!-- identity -->'; body $ID; echo '<!-- /identity -->'; echo
  echo '<!-- addendum -->'; body $AD; echo '<!-- /addendum -->'; echo
  echo '<!-- binding -->';  body $BC; echo '<!-- /binding -->'; } > "$R.new" && mv "$R.new" "$R"
```

Rule from the forge: **batch frontmatter edits with body edits and declare "final"** in the RETURN
that hands sources over — a vendor partner recomposes once, not after every metadata touch.
