# opsort.vim

This plugin provides one thing: an operator that sorts the lines it is applied to.

# Summary

By default, `gs` is mapped to sort.

When applied linewise (e.g. Visual-line mode, motions, and text objects), it sorts the lines lexicographically.
For example:

- `gsip` sorts the current line (like `dip`).
- `10gss` and `10gsgs` both sort 10 lines (like `10dd`).

With Visual-block mode, the selected lines are sorted according to the selected columns.
For example, if the region bounded by `|` is selected,

```
Apple  |10|
Orange | 3|
Banana |40|
```

pressing `gs` will change that to

```
Orange  3
Apple  10
Banana 40
```
