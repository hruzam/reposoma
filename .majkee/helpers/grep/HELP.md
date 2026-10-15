# Grep

## Search Markdown text recursively

```bash
grep -RIn --exclude-dir=.git --include='*.md' 'search text' .
```

`-R` searches recursively, `-I` skips binary files, and `-n` prints line numbers.
