# 5. Collections and strings

Prerequisites: [lessons 1–4](../README.md), particularly `map`, tuples and
`Option`. A **collection** holds several values. A list keeps them in order;
a map associates keys with values; a set keeps distinct values. Arrays provide
indexed storage. Strings hold text, while byte strings hold raw bytes.

All are immutable values: operations return results without changing the
meaning of an earlier value. “Map” has two meanings here: `map f` transforms
list elements, while `Map[K, V]` is a key/value collection. Names such as
`map.get` operate on the latter.

## Following the text transformations

The sample splits a sentence into words. Its lines then:

- map each word to its length and add those lengths;
- count equal words with `frequencies`, then look up `"the"`; `Some 3` means
  the key exists with count three, while a missing key would produce `None`;
- keep distinct words with `unique`, sort them alphabetically, and take three;
- keep even integers (`rem 2` is the remainder after division by two), then
  multiply them by ten.

`format` replaces `{}` placeholders with values from a tuple or record. Other
useful text operations are `lines` (split at line endings), `split`/`join`,
`trim` (remove surrounding whitespace) and `replace`.

## Values produced on demand

An **iterator** supplies successive values when asked. The `iter.` functions
are **lazy**: they can describe a sequence without constructing its whole list.
`iter.iterate (mul 2)` starts from its input and repeatedly doubles it;
`iter.take 5` limits consumption; `iter.to-list` collects the five results.
The program therefore produces `[1, 2, 4, 8, 16]` without constructing an infinite
list. Some producers prepare a successor when stepped; this is not a guarantee
that every producer performs no lookahead.

### Follow one list through a pipe

```text
[1, 2, 3, 4, 5, 6]
  | filter (rem 2 | eq 0)  → [2, 4, 6]
  | map (mul 10)          → [20, 40, 60]
```

`filter` chooses elements; `map` changes each chosen element. Neither changes
the original list. For the iterator example, changing `iter.take 5` to
`iter.take 3` would collect `[1, 2, 4]`.

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
    ("apples", 12) | format "{}: {}" | print,
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
apples: 12
```

See `lib/list.fwp`, `lib/string.fwp`, `lib/collections.fwp` and
`lib/iter.fwp` for the complete set; each file ends with its tests, which
double as examples.

---

Previous: [Effects](../04-effects/README.md) · Next: [Tasks and channels](../06-tasks-and-channels/README.md) · [All tutorials](../README.md)
