# A tour of fwp

This tutorial is built from the programs in
[`examples/tutorial`](../examples/tutorial); each section's program runs as
shown, and its output follows. To run one:

```
fwp run examples/tutorial/01-pipes.fwp               # interpreter
fwp build examples/tutorial/01-pipes.fwp -o pipes    # native executable
```

## 1. Pipes and functions

A program is a set of definitions. Values flow left to right through `|`.
When the left side is a value, `|` applies the function on the right to it;
when both sides are functions, it composes them into a new function.

Functions are curried and take their data last. So a partially applied
function reads like an instruction: `sub 1` subtracts one, and
`x | sub 1` is `x - 1`. Most definitions don't name their arguments at all:
they are pipelines of functions ("tacit" style). Combinators such as `fork`,
`both`, `flip`, `curry` and `tap` route values to several functions.

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

Output:

```
10
12
9
6
(3, 18)
PIPES!
```

`main` is a list here because the elements of a list (or a tuple) are
evaluated, and their effects performed, from left to right. `ignore`
discards the result.

## 2. Data

Records have named fields; tuples are records whose fields are `.0`, `.1`,
and so on. A variant type lists its constructors.

- `.x` selects a field.
- `make T { f = g, ... }` builds a record from functions of the input.
- `update { f = g }` applies a function to a field.
- `with { f = v }` replaces a field.

`match` takes a value apart. Each `_` hole in a pattern hands its part, in
order, to the function on the right of the arrow. A pattern with no holes
gives a value directly. Matches must be exhaustive: the compiler names a
missing case.

```fwp
# 2. Data: records, tuples and variants

# A nominal record type, and a variant (sum) type.
Point = { x: F64, y: F64 }

Shape =
    | Circle Point F64
    | Rect Point Point

# `.field` selects a field; `.0`, `.1` select tuple components.
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
    Rect _ _ -> curry (both (fork sub (.0 | .x) (.1 | .x)) (fork sub (.0 | .y) (.1 | .y)) | uncurry mul | abs)

origin : Point
origin = { x = 0.0, y = 0.0 }

main = [
    { x = 3.0, y = 4.0 } | dist | echo,
    (1.0, 2.0) | from-pair | shift-right | echo,
    { x = 0.0, y = 0.0 } | with { y = 9.0 } | echo,
    [Circle origin 1.0, Rect origin { x = 2.0, y = 3.0 }] | map area | echo,
] | ignore
```

Output:

```
5.0
Point {x = 2.0, y = 2.0}
{x = 0.0, y = 9.0}
[3.14159, 6.0]
```

## 3. Types and traits

Types are inferred; signatures document and constrain. Lower-case names in
types are type variables, and `where` lists the traits they need. A trait
declares functions (optionally with defaults), and `impl` provides them for
a type. The compiler derives the structural traits `Eq`, `Ord`, `Hash`,
`Display`, `Dup`, `Encode` and `Decode`. Numeric literals take the type
they are used at, and a literal that does not fit its type is a compile
error.

```fwp
# 3. Types and traits

# Signatures are optional; types are inferred. Lower-case type names are
# type variables.
pair-up : a -> (a, a) where Dup[a]
pair-up = both id id

# A trait is a set of functions that types implement.
trait Describe[T] =
    describe : T -> String

Temperature = { celsius: F64 }

impl Describe[Temperature] =
    describe = .celsius | format "{} °C"

impl Describe[Bool] =
    describe = match
        True -> "yes"
        False -> "no"

# Generic code works for every type with an implementation.
shout : a -> String where Describe[a]
shout = describe | upper

# Numeric literals adapt to the type they are used at.
half : F32 -> F32
half = div 2

main = [
    7 | pair-up | echo,
    21.5 | make Temperature { celsius = id } | describe | print,
    True | shout | print,
    3 | half | echo,
] | ignore
```

Output:

```
(7, 7)
21.5 °C
YES
1.5
```

## 4. Effects

A function's type lists the effects it may perform after `!`: `IO`,
`FileIO`, `Network`, `Async`, `Random`, `State[S]`, `Error[E]`, `Unsafe`
and others. Pure functions have no effects, and definitions other than
`main` and tests are pure values. Handlers remove effects:

- `attempt` turns `Error[E]` into a `Result`;
- `try` re-raises a `Result`;
- `run-state` runs a function with a piece of state.

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
count-long = run-state 0 (each (if (string.length | gt 3) (const (add 1) | modify) (const ()))) | .1

main = [
    "42" | attempt age | echo,
    "-1" | attempt age | echo,
    "abc" | attempt age | echo,
    ["a", "long", "words", "x"] | count-long | echo,
] | ignore
```

Output:

```
Ok 42
Err "negative"
Err "not a number"
2
```

## 5. Collections

Lists, arrays, maps, sets, strings and byte strings are immutable. The
`iter` functions are lazy, so iterators can be infinite.

```fwp
# 5. Lists, maps, strings and lazy iterators

text = "the quick brown fox jumps over the lazy dog the end"

main = [
    text | words | map string.length | sum | echo,
    text | words | frequencies | map.get "the" | echo,
    text | words | unique | sort | take 3 | echo,
    [1, 2, 3, 4, 5, 6] | filter (rem 2 | eq 0) | map (mul 10) | echo,
    # an infinite iterator: only the first five are computed
    1 | iter.iterate (mul 2) | iter.take 5 | iter.to-list | echo,
    ("fwp", 12) | format "{} is {} PRs old" | print,
] | ignore
```

Output:

```
41
Some 3
["brown", "dog", "end"]
[20, 40, 60]
[1, 2, 4, 8, 16]
fwp is 12 PRs old
```

## 6. Tasks

Concurrency is structured. A task belongs to the task that started it,
which waits for its children before it finishes. Channels are bounded,
deadlines cancel tasks, and `loop` runs long-running loops in constant
stack space. See [concurrency.md](concurrency.md) for networking and the
HTTP server.

```fwp
# 6. Tasks and channels

# Each element is handled by its own task; results come back in order.
squares = task.map (fork mul id id)

# A producer task sends into a bounded channel; the consumer reads until
# the channel is closed.
produce : Channel[I64] -> () -> () ! {Async, IO, Network, FileIO}
produce = flip (const (both (flip send-all [1, 2, 3]) channel.close | ignore))

send-all : Channel[I64] -> List[I64] -> () ! {Async}
send-all = channel.send | flip compose ignore | each

total : Channel[I64] -> I64 ! {Async}
total = both id (const 0) | loop add-next

add-next : (Channel[I64], I64) -> Step[(Channel[I64], I64), I64] ! {Async}
add-next = fork next-step id (.0 | channel.recv)

next-step : (Channel[I64], I64) -> Option[I64] -> Step[(Channel[I64], I64), I64]
next-step = curry (match
    (_, None) -> .1 | Stop
    (_, Some _) -> curry (both (.0 | .0) (fork add (.0 | .1) .1) | Again))

the-channel : Channel[I64] -> Channel[I64]
the-channel = id

main = [
    [1, 2, 3, 4] | squares | echo,
    2 | channel.make | the-channel | tap (produce | task.spawn) | total | echo,
    # a deadline cancels a task that takes too long
    task.within 50ms (const 1s | task.sleep) | echo,
] | ignore
```

Output:

```
[Some 1, Some 4, Some 9, Some 16]
6
None
```

## Where next

- [reference.md](reference.md): the language and the `fwp` command.
- [concurrency.md](concurrency.md): tasks, networking, HTTP, JSON.
- [protocol.md](protocol.md): functions as executables connected by typed
  pipes.
- `examples/server/api.fwp`: a JSON API server.
- `lib/*.fwp`: the standard library, with its tests.
