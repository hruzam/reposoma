# Git staging

## Stage everything except selected session beds

```bash
git add -A -- . \
  ':(exclude).dev/session/germline-03-foundation-audit/**' \
  ':(exclude).dev/session/germline-02-guide-model-law/**'

git status
git diff --cached --stat
```

`-A` includes additions, modifications, and deletions. Keep the pathspecs quoted so
the shell does not expand `*`; replace or add exclusions as needed.
