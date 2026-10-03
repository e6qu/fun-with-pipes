# 2. Data: records, tuples and variants

Data comes in three shapes: records with named fields, tuples (records
whose fields are `.0`, `.1`, ...) and variant types, whose values are made
with constructors.

```fwp
Point = { x: F64, y: F64 }

Shape =
    | Circle Point F64
    | Rect Point Point
```

## Reading and building records

- `.x` is a function that selects a field, so it fits into pipelines:
  `.x | fork mul id id` squares the `x` coordinate.
- `make T { f = g, ... }` builds a record of type `T` from functions of
  the input.
- `update { f = g }` applies `g` to field `f`.
- `with { f = v }` replaces the value of a field.

## Pattern matching

`match` is a function that takes a value apart. Each `_` hole in a pattern
captures one part, and the captured parts are passed, in order, as
arguments to the function on the right of the arrow:

```fwp
area : Shape -> F64
area = match
    Circle _ _ -> const (fork mul id id | mul 3.14159)
```

`Circle _ _` has two holes, the centre and the radius. The arm's function
receives both; `const` discards the centre and keeps the function of the
radius.

Matches must be exhaustive. If a case is missing, the compiler names it.

## The program

[`main.fwp`](main.fwp):

```fwp
# 2. Data: records, tuples and variants

# A nominal record type, and a variant (sum) type.
Point = { x: F64, y: F64 }

Shape =
    | Circle Point F64
    | Rect Point Point

# `.field` selects a field; `.0`, `.1` select tuple components.
dist : Point -> F64
dist = fork add (.x | fork mul id id) (.y | fork mul id id) | sqrt

# `make` builds a record from functions of the input;
# `update` applies functions to fields; `with` replaces them.
from-pair : (F64, F64) -> Point
from-pair = make Point { x = .0, y = .1 }

shift-right : Point -> Point
shift-right = update { x = add 1.0 }

# `match` takes the value apart. The holes `_` of a pattern are passed,
# in order, to the function on the right of the arrow.
area : Shape -> F64
area = match
    Circle _ _ -> const (fork mul id id | mul 3.14159)
    Rect _ _ -> curry (both
            (fork sub (.0 | .x) (.1 | .x))
            (fork sub (.0 | .y) (.1 | .y))
        | uncurry mul
        | abs)

origin : Point
origin = { x = 0.0, y = 0.0 }

main = [
    { x = 3.0, y = 4.0 } | dist | echo,
    (1.0, 2.0) | from-pair | shift-right | echo,
    { x = 0.0, y = 0.0 } | with { y = 9.0 } | echo,
    [Circle origin 1.0, Rect origin { x = 2.0, y = 3.0 }] | map area | echo,
] | ignore
```

Run it with `fwp run docs/tutorials/02-data/main.fwp` (compiled to native code and cached), or
build an executable with `fwp build docs/tutorials/02-data/main.fwp -o data`. The output is
[`main.out`](main.out):

```
5.0
Point {x = 2.0, y = 2.0}
{x = 0.0, y = 9.0}
[3.14159, 6.0]
```

A record literal like `{ x = 3.0, y = 4.0 }` is structural, and it fits
wherever a nominal record with the same fields is expected.

---

Previous: [Pipes and functions](../01-pipes-and-functions/README.md) · Next: [Types and traits](../03-types-and-traits/README.md) · [All tutorials](../README.md)
