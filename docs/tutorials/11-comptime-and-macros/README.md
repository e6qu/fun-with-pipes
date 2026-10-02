# 11. Compile-time code and macros

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

## The program

[`main.fwp`](main.fwp):

```fwp
# 11. Compile-time code and macros

# `comptime` evaluates while compiling; the result is a constant in the
# program (here a table of the first ten squares).
squares = comptime (range 0 10 | map (fork mul id id))

# Even functions can be built at compile time: a dispatch table.
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

# `type[T]` describes a type; here it becomes a list of field names.
Order = { id: I64, item: String, quantity: U32 }

field-names = comptime (type[Order] | .shape | match
    ShapeRecord -> map .name
    _ -> const [])

# A macro rewrites syntax before type checking. `unquote!(0)` is its
# first argument: twice!(f) becomes f | f.
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

Run it with `fwp run docs/tutorials/11-comptime-and-macros/main.fwp`, or compile it with
`fwp build docs/tutorials/11-comptime-and-macros/main.fwp -o comptime-and-macros`. The output is
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
