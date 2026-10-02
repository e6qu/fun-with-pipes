# 4. Effects

A function's type says which effects it may perform. The effects come
after `!`:

```fwp
parse-age : String -> I64 ! {Error[String]}
```

The effects are `IO`, `FileIO`, `Network`, `Async`, `Random`, `State[S]`,
`Error[E]`, `Alloc` and `Unsafe`. A function without `!` is pure. A
definition other than `main` or a test must be a pure value.

## Handlers

Handlers turn effects into ordinary values:

- `fail e` raises `Error[E]`, and `attempt f x` catches it, returning
  `Ok value` or `Err e`;
- `try` turns a `Result` back into a failure;
- `or-fail e` turns `None` into a failure;
- `run-state s f x` runs `f` with a piece of mutable state that starts as
  `s`, and returns the result paired with the final state. Inside, `get`,
  `put` and `modify` read and change the state.

## The program

[`main.fwp`](main.fwp):

```fwp
# 4. Effects

# A function's type says which effects it may perform. `Error[E]` aborts
# to the nearest `attempt`, which turns the failure into a `Result`.
parse-age : String -> I64 ! {Error[String]}
parse-age = parse-int | or-fail "not a number"

check-age : I64 -> I64 ! {Error[String]}
check-age = if (lt 0) (const "negative" | fail) id

age : String -> I64 ! {Error[String]}
age = parse-age | check-age

# `run-state` gives a function a piece of mutable state.
count-long : List[String] -> I64
count-long =
    run-state
        0
        (each (if (string.length | gt 3) (const (add 1) | modify) (const ())))
    | .1

main = [
    "42" | attempt age | echo,
    "-1" | attempt age | echo,
    "abc" | attempt age | echo,
    ["a", "long", "words", "x"] | count-long | echo,
] | ignore
```

Run it with `fwp run docs/tutorials/04-effects/main.fwp`, or compile it with
`fwp build docs/tutorials/04-effects/main.fwp -o effects`. The output is
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
