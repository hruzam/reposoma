# Tree

## Show a compact directory tree

```bash
tree -L 2 -a -I '.git|node_modules|vendor' .
```

`-L 2` limits the display to two levels, `-a` includes dotfiles, and `-I` omits
common large or irrelevant directories.
