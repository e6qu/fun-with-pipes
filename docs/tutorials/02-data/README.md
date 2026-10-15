# 2. Data: records, tuples and variants

Read [lesson 1](../01-pipes-and-functions/README.md) first: this lesson uses
pipes, `both`, `fork`, `id` and `const`. We will represent points and shapes,
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

## Reading and building records

- `.x | fork mul id id` selects the x coordinate, then multiplies it by itself.
- `make Point { x = .0, y = .1 }` gives each field a function of the incoming
  pair. It turns `(1.0, 2.0)` into a `Point`.
- `make { .name, .age }` copies those fields from an incoming record. Each short
  field stands for `name = .name` or `age = .age`. Nested paths need an output
  name, such as `city = .address.city`.
- `update { x = add 1.0 }` applies a function to the old field value.
- `with { y = 9.0 }` supplies a replacement value directly.

These operations return new logical values; they do not change the original
record. The distance function below calculates `sqrt(x*x + y*y)`, the distance
from the origin. `sqrt` is the square-root function.

## Pattern matching

`match` chooses a result based on a value's shape. A pattern is written before
`->`; the expression after it is the **arm**. Every `_` in a pattern captures
one component and passes it to the arm as an argument, in order.

For `Circle _ _`, those arguments are the centre and radius. The complete program
uses `const` to ignore the centre and return a function that squares the radius
and multiplies by pi. Here `const` returns a function, which receives the second
captured argument. `_` does not automatically discard a value in fwp.

For `Rect _ _`, `curry` lets the arm treat its two captured points as one pair.
The nested selectors `.0 | .x` and `.1 | .x` read their x coordinates. `both`
calculates the two side lengths, `uncurry mul` multiplies that pair, and `abs`
makes the area nonnegative. A match must cover every alternative; omitting the
rectangle arm would be a compile-time error.

A pattern with no captured components, such as `True`, supplies its arm's result
directly. An arm with one `_` receives an argument, so returning a fixed value
requires a constant function. This distinction will matter in lesson 4.

## The program

[`main.fwp`](main.fwp):

```fwp
Point = { x: F64, y: F64 }

Shape =
    | Circle Point F64
    | Rect Point Point

dist : Point -> F64
dist = fork add (.x | fork mul id id) (.y | fork mul id id) | sqrt

from-pair : (F64, F64) -> Point
from-pair = make Point { x = .0, y = .1 }

shift-right : Point -> Point
shift-right = update { x = add 1.0 }

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

The anonymous record `{ x = 3.0, y = 4.0 }` is checked by its fields
(“structural” typing). `Point` is a declared name (“nominal” typing). In this
example the compiler accepts the matching anonymous shape where `Point` is
expected; the named result is printed with `Point`.

---

Previous: [Pipes and functions](../01-pipes-and-functions/README.md) · Next: [Types and traits](../03-types-and-traits/README.md) · [All tutorials](../README.md)
