# 5. Collections and strings

Lists, arrays, maps, sets, strings and byte strings are all immutable.
Their functions are curried and data-last like everything else, so they
chain in pipelines:

- `words`, `lines`, `split`, `join`, `format`, `trim`, `replace` work on
  strings;
- `map`, `filter`, `fold`, `sort`, `sort-by`, `unique`, `take`, `zip` work
  on lists;
- `frequencies`, `map.get`, `map.insert`, `map.to-list` work on maps.

`format` fills `{}` placeholders from a tuple or a record.

## Lazy iterators

The functions under `iter.` are lazy, so an iterator can be infinite. Only
the elements that are consumed are computed:

```fwp
    1 | iter.iterate (mul 2) | iter.take 5 | iter.to-list | echo,
```

## The program

[`main.fwp`](main.fwp):

```fwp
text = "the quick brown fox jumps over the lazy dog the end"

main = [
    text | words | map string.length | sum | echo,
    text | words | frequencies | map.get "the" | echo,
    text | words | unique | sort | take 3 | echo,
    [1, 2, 3, 4, 5, 6] | filter (rem 2 | eq 0) | map (mul 10) | echo,
    1 | iter.iterate (mul 2) | iter.take 5 | iter.to-list | echo,
    ("fwp", 12) | format "{} is {} PRs old" | print,
] | ignore
```

Run it with `fwp run docs/tutorials/05-collections/main.fwp` (compiled to native code and cached), or
build an executable with `fwp build docs/tutorials/05-collections/main.fwp -o collections`. The output is
[`main.out`](main.out):

```
41
Some 3
["brown", "dog", "end"]
[20, 40, 60]
[1, 2, 4, 8, 16]
fwp is 12 PRs old
```

See `lib/list.fwp`, `lib/string.fwp`, `lib/collections.fwp` and
`lib/iter.fwp` for the complete set; each file ends with its tests, which
double as examples.

---

Previous: [Effects](../04-effects/README.md) · Next: [Tasks and channels](../06-tasks-and-channels/README.md) · [All tutorials](../README.md)
