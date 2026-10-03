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

`average = fork div length sum` reads as "divide the sum by the length".

## The program

[`main.fwp`](main.fwp):

```fwp
# 1. Pipes and functions

# A definition names a value. Functions are usually written without naming
# their argument ("tacit"): `double` is "multiply by 2".
double = mul 2

# `|` feeds a value into a function...
ten = 5 | double

# ...and between two functions it composes them, left to right.
quadruple = double | double

# Functions are curried and take their data last, so a partially applied
# function reads like an instruction: `sub 1` subtracts one.
decrement = sub 1

# Combinators route a value to several functions. `fork f g h x` is
# `f (g x) (h x)`; `both f g x` is the pair `(f x, g x)`.
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
