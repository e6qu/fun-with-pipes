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

## Piped branches

`count-long` passes each string through `string.length`, then `gt 3`, then
`match`. The `True` arm updates the state with `modify (add 1)`; the `False`
arm returns `()`. Neither pattern captures an argument, so neither arm
needs a constant function. Only the selected arm performs its effect.

`check-age` uses `tap` to keep the original age after the piped check.
A negative age raises the error before the pipeline can continue.

When an operation does need a callback that ignores its argument,
`const` makes that explicit. For example, `const (add 1) | modify` ignores
the callback input, supplies the function `add 1` to `modify`, and updates
the state. Simply writing `add 1 | modify` would compose the two functions
and send a number to `modify`, which expects a state-transforming function.

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
