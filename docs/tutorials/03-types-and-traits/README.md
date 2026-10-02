# 3. Types and traits

Types are inferred, so signatures are optional. You write them to
document a definition or to constrain it. Lower-case names in a type are
type variables, and `where` lists the traits they must implement:

```fwp
pair-up : a -> (a, a) where Dup[a]
```

## Traits

A trait is a set of functions that a type can implement. A method may have
a default definition. `impl` provides the methods for one type:

```fwp
trait Describe[T] =
    describe : T -> String
```

The compiler derives the structural traits for every type: `Eq`, `Ord`,
`Hash`, `Display`, `Dup`, `Encode` and `Decode`. So data can be compared,
sorted, shown and serialized without any declarations. The numeric traits
(`Add`, `Mul`, `Ring`, `Field`, `Floating`, ...) let you write code once
for every number type.

## Numeric literals

A literal takes the type it is used at: in `half`, the `2` is an `F32`.
A literal that does not fit its type is a compile-time error, and integer
arithmetic that overflows stops the program with a trap.

## The program

[`main.fwp`](main.fwp):

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

Run it with `fwp run docs/tutorials/03-types-and-traits/main.fwp`, or compile it with
`fwp build docs/tutorials/03-types-and-traits/main.fwp -o types-and-traits`. The output is
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
