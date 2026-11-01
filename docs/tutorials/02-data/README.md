# 2. Data: records, tuples and variants

Read [lesson 1](../01-pipes-and-functions/README.md) first: this lesson uses
pipes, named functions, local values and `const`. We will represent points and shapes,
transform them, and calculate distances and areas.

## Named fields, positions and alternatives

A **record** groups named fields: `{ x = 3.0, y = 4.0 }`. A **tuple** groups
values by position: `(3.0, 4.0)`. Positions start at zero, so `.0` selects `3.0`
and `.1` selects `4.0`. A field selector such as `.x` is a function and can be
used directly in a pipe.

A type describes which values are allowed. `F64` is a 64-bit floating-point
number. `Point = { x: F64, y: F64 }` declares a named record type. A **variant
type** offers named alternatives:

```fwp
Point = { x: F64, y: F64 }

Shape =
    | Circle Point F64
    | Rect Point Point
```

A `Circle` stores a centre and radius; a `Rect` stores two opposite corners.
`Circle` and `Rect` are **constructors**, functions that build those alternatives.
The leading `|` in a type declaration separates alternatives; it is not an
expression pipe.

A signature such as `dist : Point -> F64` says that `dist` takes a `Point` and
returns an `F64`. The colon introduces the type, and `->` means “to.” Lesson 3
covers type signatures in detail.

## Read fields or unpack a value

**Destructuring** gives names to parts of one value. `fn (x, y) -> ...` takes one
pair; `fn { x, y } -> ...` takes a record containing those fields. A field may
have a different local name: `{ x = horizontal }`. Omitted record fields are
ignored. These patterns must always match the input type; use `match` for
alternatives such as `Some` and `None`.

`dist = fn { x, y } -> sqrt (x * x + y * y)` reads both coordinates and computes
the distance from the origin. `sqrt` is square root; `(3.0, 4.0)` coordinates
produce `sqrt 25.0`, or `5.0`. The typed input is a `Point`, not a pair.

`Point { x, y }` in an expression means `Point { x = x, y = y }`. This **field
shorthand** uses existing values; it does not select fields from an implicit input.
`make Point { x = .0, y = .1 }` instead builds a point by running the two field
functions on one input.

`make { .name, .age }` selects existing input fields.
Use `update { x = add 1.0 }` to transform one field, or `with { y = 9.0 }` to
replace it. These return new logical values; they do not mutate the original.

## Match alternatives

`match` is a function that chooses the first matching arm. In
`Circle centre radius -> radius * radius * 3.14159`, names bind the stored centre
and radius. The expression uses the radius; the unused centre is discarded.
The rectangle arm unpacks its two points, subtracts their coordinates, multiplies
the side lengths and uses `abs` to make the area nonnegative.

A match must cover every alternative. Omitting `Rect` is an error. Existing
tacit patterns remain available: `Some _ -> add 1` forwards the stored value to
`add 1`. A match `_` hole forwards a value. In **fn/let** and record-field
patterns, `_` discards it; `{ x, y = _ }` keeps only the name `x`.

Thus `Some value -> value + 1` and `Some _ -> add 1` mean the same thing.
A bare constructor with fields, such as `Some`, is shorthand for its holes.
`None -> 0` has no payload and returns `0` directly. Avoid mixing names and holes
unless forwarding makes the arm clearer.

## Trace a record transformation

| Step | Value |
|---|---|
| Start with a pair | `(1.0, 2.0)` |
| `from-pair` names `x` and `y`, then constructs `Point { x, y }` | `Point {x = 1.0, y = 2.0}` |
| `shift-right` applies `add 1.0` to `.x` | `Point {x = 2.0, y = 2.0}` |

Only `.x` changes in the result. Keeping the original point would still give
its original coordinates. For alternatives, `Circle origin 1.0 | area` selects
the circle arm and calculates `1 × 1 × 3.14159 = 3.14159`.

## The program

[`main.fwp`](main.fwp):

```fwp
Point = { x: F64, y: F64 }

Shape =
    | Circle Point F64
    | Rect Point Point

dist : Point -> F64
dist = fn { x, y } -> sqrt (x * x + y * y)

from-pair : (F64, F64) -> Point
from-pair = fn (x, y) -> Point { x, y }

shift-right : Point -> Point
shift-right = update { x = add 1.0 }

area : Shape -> F64
area = match
    Circle centre radius -> radius * radius * 3.14159
    Rect { x = x0, y = y0 } { x = x1, y = y1 } -> abs ((x1 - x0) * (y1 - y0))

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

The anonymous record `{ x = 3.0, y = 4.0 }` is checked by its fields
(“structural” typing). `Point` is a declared name (“nominal” typing). In this
example the compiler accepts the matching anonymous shape where `Point` is
expected; the named result is printed with `Point`.

---

Previous: [Pipes and functions](../01-pipes-and-functions/README.md) · Next: [Types and traits](../03-types-and-traits/README.md) · [All tutorials](../README.md)
