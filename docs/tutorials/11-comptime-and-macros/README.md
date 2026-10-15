# 11. Compile-time code and macros

Read lessons 1–4 first. **Compile time** is when fwp checks and builds your
program; **runtime** is when the resulting program executes. Reflection means
inspecting a type as data. A macro transforms program syntax before type checking;
it does not call a runtime function with ordinary values. A syntax tree records
how expressions are nested. These tools are useful for generating repetitive
code, but ordinary functions are simpler when no syntax transformation is needed.

`comptime e` evaluates `e` while the program is compiled and puts the
result into the program as a constant. Lists, maps, records and even
functions can be constants. The code inside `comptime` may read files and
fail, but it has no access to the network or tasks.

## Reflection

`type[T]` describes a type: its name, its type arguments, and its fields or
variants. Together with `comptime`, it can derive things such as schemas or
serializers from a type definition.

## Macros

Programs are data too. `quote e` is the syntax tree of `e`, as a value of
the ordinary type `Syntax`. A macro is a function from syntax to syntax.
It is called with `name!(...)` and expanded before type checking:

```fwp
macro twice = quote (unquote!(0) | unquote!(0))
```

`unquote!(0)` stands for the macro's first argument. Names in a quote
refer to what they meant where the quote was written, not where the macro
is used, so macros cannot capture each other's names by accident.

The prelude defines two macros. `assert!(e)` checks a condition and
reports the failing expression. `dbg!(e)` prints an expression with its
value.

## Reading the example

`squares` precomputes squares of 0 through 9. `commands` is a compile-time map
whose values are functions. `run` looks up the requested name and uses `apply`
to call that function on the text. For an unknown name, `const "unknown command"`
creates a function with the same input type that ignores the supplied text.

`type[Order]` returns type metadata; matching `ShapeRecord` exposes its fields,
and `map .name` extracts their names. `twice!(add 1)` expands to two `add 1`
stages, so `40 | add-two` prints 42. `assert!` checks a condition and returns unit
`()`, which explains the final output. A schema describes allowed data; a
serializer converts values to text/bytes. Reflection can help generate either.

## The program

[`main.fwp`](main.fwp):

```fwp
squares = comptime (range 0 10 | map (fork mul id id))

commands : Map[String, String -> String]
commands = comptime ([
    ("shout", upper),
    ("reverse", string.reverse),
    ("size", string.length | show),
] | map.from-list)

run : String -> String -> String
run = curry (fork
    apply
    .1
    (.0 | flip map.get commands | option.unwrap-or (const "unknown command")))

Order = { id: I64, item: String, quantity: U32 }

field-names = comptime (type[Order] | .shape | match
    ShapeRecord -> map .name
    _ -> const [])

macro twice = quote (unquote!(0) | unquote!(0))

add-two = twice!(add 1)

main = [
    squares | echo,
    "pipes" | run "shout" | print,
    "pipes" | run "reverse" | print,
    "pipes" | run "fly" | print,
    field-names | echo,
    40 | add-two | echo,
    assert!(1 | add-two | eq 3) | echo,
] | ignore
```

Run it with `fwp run docs/tutorials/11-comptime-and-macros/main.fwp` (compiled to native code and cached), or
build an executable with `fwp build docs/tutorials/11-comptime-and-macros/main.fwp -o comptime-and-macros`. The output is
[`main.out`](main.out):

```
[0, 1, 4, 9, 16, 25, 36, 49, 64, 81]
PIPES
sepip
unknown command
["id", "item", "quantity"]
42
()
```

Programs that inspect or build syntax directly can match on the `Syntax`
constructors (`SInt`, `SName`, `SApply`, `SPipe`, ...), which are defined in
`lib/prelude.fwp`.

---

Previous: [WebAssembly](../10-webassembly/README.md) · Next: [Numerics](../12-numerics/README.md) · [All tutorials](../README.md)
