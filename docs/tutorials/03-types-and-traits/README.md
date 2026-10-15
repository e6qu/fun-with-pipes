# 3. Types and traits

Prerequisites: [pipes](../01-pipes-and-functions/README.md) and
[records, variants and signatures](../02-data/README.md). This lesson shows how
to describe reusable functions and operations that work on different types.

## Inference and explicit generic signatures

The compiler often determines a type from the code; this is **type inference**.
A signature states it explicitly. `String -> I64` takes a string and returns a
64-bit signed integer. Parentheses group types, so `a -> (a, a)` returns a pair.
A lowercase name such as `a` is a **type variable**: it stands for the type chosen
at a particular use of the function.

```fwp
pair-up : a -> (a, a) where Dup[a]
```

This is a **generic** function: it can work at several types. `where Dup[a]`
requires that values of the chosen type may be duplicated. Duplication preserves
value semantics; it does not necessarily copy every byte of a shared object.

Only an explicit signature with type variables makes a definition generic.
Without it, an unconstrained `pair-up = dup` is rejected with a suggested signature.
A number literal can supply a concrete default: `double = mul 2` becomes
`I64 -> I64`. The compiler makes a specialized version of a generic function for
each type used. This avoids runtime lookup of trait methods, but does not prove
that all values, calls or surrounding code avoid allocations.

## Traits and implementations

A **trait** is a named set of operations a type provides. This one asks for a
way to turn a value into a string:

```fwp
trait Describe[T] =
    describe : T -> String
```

An `impl Describe[Temperature]` supplies that operation for `Temperature`.
The Boolean implementation chooses `"yes"` or `"no"`. `shout` then works for
either type by calling `describe` and converting its result to uppercase.

The compiler supplies standard operations for supported structures: `Eq` tests
equality, `Ord` orders values, `Hash` calculates lookup hashes, `Display` formats
values, `Dup` allows duplication, and `Encode`/`Decode` convert to/from the typed
process data format. Resource types have restrictions described in the reference.
Numeric traits describe arithmetic: `Add` provides addition, `Mul`
multiplication, and larger traits such as `Ring` group related operations.

## Numbers in context

`F32` is a 32-bit floating-point type. In `half : F32 -> F32`, the literal `2`
takes that type from its use. A literal outside its type's range is a compile-time
error. Checked integer arithmetic that overflows at runtime stops with a
**trap**, an invalid-operation diagnostic; it does not silently wrap.

In the program, `make Temperature { celsius = id }` turns `21.5` into the named
record. `format "{} °C"` fills the `{}` placeholder with that field. The four
outputs demonstrate a generic pair, a custom description, a Boolean description,
and floating-point division.

## The program

[`main.fwp`](main.fwp):

```fwp
pair-up : a -> (a, a) where Dup[a]
pair-up = both id id

trait Describe[T] =
    describe : T -> String

Temperature = { celsius: F64 }

impl Describe[Temperature] =
    describe = .celsius | format "{} °C"

impl Describe[Bool] =
    describe = match
        True -> "yes"
        False -> "no"

shout : a -> String where Describe[a]
shout = describe | upper

half : F32 -> F32
half = div 2

main = [
    7 | pair-up | echo,
    21.5 | make Temperature { celsius = id } | describe | print,
    True | shout | print,
    3 | half | echo,
] | ignore
```

Run it with `fwp run docs/tutorials/03-types-and-traits/main.fwp` (compiled to native code and cached), or
build an executable with `fwp build docs/tutorials/03-types-and-traits/main.fwp -o types-and-traits`. The output is
[`main.out`](main.out):

```
(7, 7)
21.5 °C
YES
1.5
```

`shout` works for any type with a `Describe` implementation, including
`Bool`, as the output shows.

---

Previous: [Data: records, tuples and variants](../02-data/README.md) · Next: [Effects](../04-effects/README.md) · [All tutorials](../README.md)
