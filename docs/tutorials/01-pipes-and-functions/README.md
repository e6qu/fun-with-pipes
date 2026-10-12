# 1. Pipes and functions

A program is a set of definitions, and `main` is where it starts. This
tutorial covers the two ideas the rest of the language builds on: the pipe
and the curried, data-last function.

## The pipe

`x | f` applies `f` to `x`. When both sides are functions, `f | g` composes
them into a new function that runs `f`, then `g`. You can always read a
pipeline from left to right, whichever of the two it is:

```fwp
ten = 5 | double
quadruple = double | double
```

## Curried, data-last functions

Every function takes one argument at a time, and the data comes last. So a
partially applied function reads like an instruction: `mul 2` doubles,
`sub 1` subtracts one, and `concat "!"` appends an exclamation mark.

Most definitions never name their argument. They are pipelines of
functions, a style called "tacit":

```fwp
double = mul 2
```

## Combinators

When a value has to go to several functions, combinators route it:

| Combinator | Meaning |
|---|---|
| `fork f g h x` | `f (g x) (h x)` |
| `both f g x` | the pair `(f x, g x)` |
| `flip f a b` | `f b a` |
| `curry` / `uncurry` | convert between two arguments and a pair |
| `tap f x` | runs `f x` for its effect and returns `x` |
| `const value x` | ignores `x` and returns `value` |

`average = fork div length sum` reads as "divide the sum by the length".

## Constant functions

`const` builds a function that ignores its input. `const 7` is a function;
`7` is an integer. For example, `[1, 2, 3] | map (const 7)` produces
`[7, 7, 7]`: `map` calls the function once for each element. Passing `7`
directly to `map` is a type error because `map` needs a function.

The name means "constant function"; it does not declare an immutable variable.

The returned value can itself be a function. `const (add 1)` ignores one
input and returns `add 1`, which still needs its numeric input. This is
useful when an operation needs a function as data: `const (add 1) | modify`
is a callback that ignores its input and increments the current state.
The [effects tutorial](../04-effects/README.md) shows how state is handled.

`const` does not delay evaluation of its argument. In the state callback,
`add 1` is a pure function value; the effect happens when the callback
reaches `modify`. Values are never implicitly converted to constant
functions.

## The program

[`main.fwp`](main.fwp):

```fwp
double = mul 2

ten = 5 | double

quadruple = double | double

decrement = sub 1

average = fork div length sum

main = [
    ten | echo,
    3 | quadruple | echo,
    10 | decrement | echo,
    [3, 5, 10] | average | echo,
    [3, 5, 10] | both length sum | echo,
    "pipes" | upper | concat "!" | print,
] | ignore
```

Run it with `fwp run docs/tutorials/01-pipes-and-functions/main.fwp` (compiled to native code and cached), or
build an executable with `fwp build docs/tutorials/01-pipes-and-functions/main.fwp -o pipes-and-functions`. The output is
[`main.out`](main.out):

```
10
12
9
6
(3, 18)
PIPES!
```

`main` is a list because the elements of a list (or a tuple) are
evaluated, and their effects performed, from left to right; `ignore`
discards the result. `echo` shows any value; `print` writes a string.

---

Next: [Data: records, tuples and variants](../02-data/README.md) · [All tutorials](../README.md)
