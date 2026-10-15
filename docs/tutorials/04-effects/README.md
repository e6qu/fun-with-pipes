# 4. Effects and explicit state

Prerequisites: [lessons 1–3](../README.md), especially constant functions,
pattern matching and type signatures. An **effect** is an action a function may
perform in addition to returning a value, such as printing or raising a
recoverable error. Its type lists effects after `!`:

```fwp
parse-age : String -> I64 ! {Error[String]}
```

`parse-age` takes text, returns an integer, and may fail with a string message.
A function without declared effects is called **pure**. Pure code can still
allocate ordinary values or hit checked-arithmetic traps. Definitions outside
`main` and tests must construct pure values, although those values may be
functions that perform effects when called.

Common effects include `IO` (console/environment access), `FileIO` (files),
`Network` (connections), `Async` (tasks), `Random`, `State[S]` (a handled state of
type `S`), `Error[E]` (a recoverable error of type `E`), `Alloc` and `Unsafe`.
The last two describe explicit allocation/resource operations and unsafe access;
they are not a count of every heap object the implementation creates.

## Handling a recoverable error

A **handler** determines how an effect is dealt with. `attempt age` runs `age`
and returns a normal value: `Ok result` on success or `Err message` on failure.
These are alternatives of `Result`. `fail message` raises the error; `try`
turns an `Err` back into a raised error.

`parse-int` returns `Some number` or `None`, the alternatives of `Option`.
`or-fail "not a number"` unwraps `Some`, or raises that message for `None`.
`check-age` rejects negative numbers. `lt 0` asks “is the input less than zero?”;
`tap` runs the check but keeps the original age if it succeeds.

## A stateful count, step by step

`run-state 0 f` runs `f` with an integer state starting at zero. It returns
`(f's result, final state)`. Within `f`, `get` reads that state, `put` replaces
it, and `modify` takes a function that calculates its next value. The state is
local to the handler; this does not make all values mutable.

The `count-long` program below does the following:

1. `each` calls its function once for each word, in order.
2. `string.length | gt 3` asks whether that word has more than three characters.
3. `match` selects `True` or `False`. `modify (add 1)` increments the handled
   counter; `()` is the unit value, meaning “no useful result.” Only the chosen
   branch runs. These patterns capture no arguments, so no `const` is needed.
4. `run-state` returns `((), count)`. `.1` selects the second field, because
   tuple positions start at zero. Two words in the sample qualify.

When a callback must ignore its incoming word and supply a function as data,
`const (add 1) | modify` does that explicitly. `add 1 | modify` would instead
try to send a number to `modify`, which needs a function. This is why constant
functions are not implicit.

## The program

[`main.fwp`](main.fwp):

```fwp
parse-age : String -> I64 ! {Error[String]}
parse-age = parse-int | or-fail "not a number"

check-age : I64 -> I64 ! {Error[String]}
check-age = tap (lt 0 | match
    True -> fail "negative"
    False -> ())

age : String -> I64 ! {Error[String]}
age = parse-age | check-age

count-long : List[String] -> I64
count-long =
    run-state 0 (each
        (string.length | gt 3 | match
            True -> modify (add 1)
            False -> ()))
    | .1

main = [
    "42" | attempt age | echo,
    "-1" | attempt age | echo,
    "abc" | attempt age | echo,
    ["a", "long", "words", "x"] | count-long | echo,
] | ignore
```

Run it with `fwp run docs/tutorials/04-effects/main.fwp` (compiled to native code and cached), or
build an executable with `fwp build docs/tutorials/04-effects/main.fwp -o effects`. The output is
[`main.out`](main.out):

```
Ok 42
Err "negative"
Err "not a number"
2
```

Effects compose: `age` fails with the first error from either step, and
the caller decides where to handle it.

---

Previous: [Types and traits](../03-types-and-traits/README.md) · Next: [Collections and strings](../05-collections/README.md) · [All tutorials](../README.md)
