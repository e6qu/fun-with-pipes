# fwp reference

This page is a lookup guide after [lessons 1–5](tutorials/README.md), which teach
functions, data, types, effects and collections. Examples here can be syntax
fragments: an ellipsis (`...`) or a signature without a body is explanatory,
not a complete program. The tutorials contain complete runnable files.

Read `A -> B` as “takes A and returns B”; repeated arrows take arguments one at
a time. `! {IO}` declares an external action. `[T]` supplies a type argument,
while `where Trait[T]` requires operations available for that type. A lowercase
identifier in a type is a type variable, not a value parameter name. Definitions
usually combine functions without naming their input; this is called *tacit*
style. The [glossary](glossary.md) provides a lookup for other compiler terms.

fwp is a tacit, curried, pipe-oriented language with static types, effect
tracking, and two backends: an interpreter and native code through C. This
page is the reference for the language as implemented. For a gentler
introduction, see the [tutorials](tutorials/README.md); the standard
library is listed in [stdlib.md](stdlib.md).

## Lexical structure

A literal writes a value directly, such as `42` or `"hello"`. A suffix selects
its numeric type. Escapes represent characters that are awkward to write literally;
for example `\n` is a newline and `\t` is a tab. Balanced ternary uses base three
with digits −1, 0 and +1, called trits.

- **Comments** run from `#` to the end of the line.
- **Names** are kebab-case (`read-all`, `max-header-bytes`). Dots qualify
  them (`list.flat-map`, `mods.util.helper`). Upper-case names denote types
  and constructors, which may also be qualified (`Json.Null`).
- **Integer literals:** `42`, `-7`, `1_000`, `0x1f`, `0b101`, `0o17`. A suffix fixes the type: `i8`,
  `i16`, `i32`, `i64`, `i128`, `u8`..`u128`, `isize`, `usize`. Without a
  suffix, the literal takes the type it is used at; a literal out of range
  for that type is a compile error.
- **Float literals:** `1.5`, `2e-3`, with suffixes `f16`, `bf16`, `f32`,
  `f64`, `f128`. These use binary16, bfloat16, binary32,
  binary64 and binary128 respectively, with direct rounding from decimal text.
  See the [format contract and validation status](float-formats.md).
- **Duration literals:** `500ns`, `20us`, `250ms`, `2s`, `1.5s`, `5min`,
  `1h`. They are decimal and at most about 292 years. Durations implement
  `Add`, `Sub` and `Zero` (`2s | add 500ms`).
- **Balanced ternary literals:** `0t+-0` (`TInt[3]`, one trit per digit).
- **Strings:** `"..."`, with the escapes `\n \t \r \0 \\ \"` and
  `\u{1F600}`.
- **Layout:** a declaration continues on the following lines as long as they
  are indented more deeply than its first line.

## Declarations

| Declaration | Meaning |
|---|---|
| `name = expression` | a definition |
| `name : Type where Trait[a]` | a signature (needed for a generic) |
| `rec name = ...` | recursion must be declared (or on the signature: `rec name : Type`) |
| `export name : Type` | exported: executables, libraries |
| `import dir.module` | `dir/module.fwp`; its names are `dir.module.name` |
| `Point = { x: F64, y: F64 }` | a named record, distinct from other named record types |
| `Meters = F64` | an alias (aliases may refer to later ones, but not to themselves) |
| `Handle = builtin` | opaque: its internal fields are hidden and supplied by the runtime |
| `resource File = builtin` | affine: cannot be duplicated (`Dup`) or captured by partial application |
| `repr(C) Vec2 = { x: F64, y: F64 }` | C layout (fields in declaration order) |
| `test "name" = expression` | must evaluate to `True` |
| `macro name = function` | a `Syntax -> Syntax` function |
| `foreign "C" name : Type = "symbol" [variadic N]` | a C function ([C interop](#c-interop)) |

Variants list their constructors and the constructors' fields:

```
Shape =
    | Circle Point F64
    | Square Point F64
```

A trait is a set of required operations. An implementation (`impl`) supplies
those operations for a type. The following is a declaration-shape sketch, with
placeholder types and a missing `area` body. A trait lists required parent traits
(superclasses) after `:`, and may give default methods
(`describe` here); an impl may have a context after `where`:

```
trait Shape[T] : Super[T] =
    area : T -> F64
    describe : T -> String
    describe = area | show
impl Shape[Circle] where Ring[F64] =
    area = ...
```

In types, a lower-case name (`a`, `t`) or an unknown upper-case name
(`T`, `Elem`) is a type variable.
Imported modules are named by their path; two different files may not be
imported under the same name.

## Expressions

| Form | Meaning |
|---|---|
| `f x y` | successive single-argument applications: `(f x) y` |
| `a + b`, `a - b`, `a * b`, `a / b`, `a % b` | arithmetic with fixed precedence; `%` is remainder |
| `a == b`, `a != b`, `a < b`, `a <= b`, `a > b`, `a >= b` | equality and ordering; result is `Bool` |
| `x \| f` | `f x` when `x` is a value; composition when `x` is a function |
| `[a, b]`, `(a, b)`, `()` | list, tuple, unit (tuples are records with fields `.0`, `.1`, ...) |
| `{ x = 1, y = 2 }` | record (structural; unifies with nominal records) |
| `Point { x = 1.0, y = 2.0 }` | a named record, distinct from other named record types |
| `.x`, `.x.y`, `.0` | field selector functions |
| `make { f = g }`, `make T { f = g }` | build a record (or a `T`) from functions of the input; `make { 0 = f, 1 = g }` builds a tuple |
| `make { .name, .age }` | project named fields; shorthand for `make { name = .name, age = .age }`, also in nominal `make` |
| `update { f = g }` | apply `g` to field `f` |
| `with { f = v }` | replace field `f` |
| `match` arms, `match { P -> e, ... }` | pattern matching (below) |
| `comptime e` | evaluate `e` at compile time |
| `quote e`, `unquote!(x)` | syntax as data; `unquote!(0)` etc. make a template function |
| `name!(args)` | macro call, expanded before type checking |
| `type[T]` | a `TypeInfo` value describing `T` |

`loop step state` repeats `step` (which returns `Again s` or `Stop r`) in
constant stack space for the loop itself; its callback can still recurse or
retain growing data. Use it for long-running iteration instead of relying on
recursive-call optimization.
Some native recursive calls are optimized, but arbitrary tail recursion is not
a portable constant-stack guarantee, and the interpreter still uses recursive
evaluation. See [tail calls and recursion](design.md#tail-calls-and-recursion).

The data being transformed comes last: `sub 1` subtracts one, `div 2` halves, `lt 0` tests
`x < 0`, and `concat "!"` appends.

### Arithmetic, comparisons and precedence

From tightest to loosest:

| Precedence | Forms | Grouping |
|---|---|---|
| 1 | Function application: `f x` | Left to right |
| 2 | Unary negation: `-(x + y)` | Negates the following application |
| 3 | `*`, `/`, `%` | Left to right |
| 4 | `+`, `-` | Left to right |
| 5 | `==`, `!=`, `<`, `<=`, `>`, `>=` | No chaining without parentheses |
| 6 | Pipe: `\|` | Left to right |

`2 + 3 * 4` gives `14`; `(2 + 3) * 4` gives `20`.
`20 - 6 - 2` means `(20 - 6) - 2`, giving `12`.
`2 + 3 * 4 | echo` prints `14`. A pipe used as an operand needs parentheses:
`(3 | add 1) * 2`. `f (2 + 3)` passes a sum to `f`, while `f 2 + 3`
adds three to the result of `f 2`.

These operators use the standard `add`, `sub`, `mul`, `div`, `rem` and `neg`
traits, including checked integer arithmetic and existing floating-point rules.
`a - b` subtracts `b` from `a`, whereas the data-last prefix call is `sub b a`.
Operands evaluate left to right, exactly once; rewriting to a prefix call with
swapped expressions can change effects or which failure occurs first.
No reassociation or implicit numeric conversion is introduced.

Use spaces around binary subtraction. Hyphenated names remain names:
`count-long` is an identifier. A minus attached to a numeric literal after
whitespace remains its sign: `add -1` partially applies addition to negative
one. Consequently, `x -1` is application, while `x - 1` is subtraction.
`10-3` is also subtraction because the minus immediately follows its operand.
Use `f (-x)` to pass a negated expression to a function.

Comparisons use `eq`, `ne`, `lt`, `le`, `gt` and `ge` for types supporting those
operations. `2 + 3 == 5 | echo` prints `True`: arithmetic happens before the
comparison, then the result enters the pipe. `=` remains a declaration marker.
Strings and collections use their existing equality/ordering rules; unrelated
types are not coerced into comparable values.

Write `x | both (ge 0) (lt 10) | uncurry and` to test a range using the same input.
`0 <= x < 10` is rejected: it must not silently compare a Boolean with a number.
Parentheses make an intentional Boolean comparison explicit: `(1 < 2) == True`.
All six comparisons share one precedence level. `3 | lt 4` and `3 < 4` both
produce `True`; prefix calls remain useful for composing functions.

Exponentiation remains the explicit `pow` library call; there is no infix power
or user-defined operator syntax. [Scalar math](numerics.md#scalar-math) describes
the trigonometric, logarithmic and related functions.

Every function still takes one argument, including a tuple-taking function.
`curry` and `uncurry` explicitly convert between a pair-taking function and
successive applications; tuple arguments are not unpacked automatically.

### Pipes

The meaning of `|` is decided by the type of its left side: application
for values, left-to-right composition for functions. When the type is not
yet known, the decision is deferred until it is.

Function calls are already prefix. Application binds more tightly than `|`:
`count (string.length | gt 3)` and `count (compose string.length (gt 3))`
name the same function. `compose f g` runs `f` then `g`. Keep parentheses
around nested arguments; indentation continues declarations and delimits
match arms, but does not group function arguments.

### Record projections

`make { .name, .age }` copies just the named fields from its input. Mix
projections with computed fields: `make Person { .name, age = .age | add 1 }`.
The shorthand accepts one named selector. Use `city = .address.city` for a
nested path and `0 = .0` for a tuple field. Duplicate output names are errors.
Record literals, `with` and `update` still require explicit field assignments.

This is a parser expansion, with the same types, ownership and evaluation as
the explicit `make`. Field functions run in canonical record-label order,
not their written order. Use a pipeline or `tap` when effects need sequencing.
The formatter abbreviates single named identity projections in `make`.

### Iteration and explicit state

All these functions are curried and take their collection last:

| Operation | Callback and result |
|---|---|
| `iter.fold step seed` | `step state element` returns the next state; exhaustion returns the final state |
| `iter.each action` | calls `action element` once per element and returns `()` |
| `iter.find predicate` | returns `Some` of the first matching element, or `None` |
| `fold-until step seed` | list fold whose callback returns `Again state` or `Stop state`; exhaustion returns the current state |
| `map-accum step seed` | list map whose callback returns `(mapped value, next state)`; returns `(mapped list, final state)` |

Callbacks run left to right with tracked effects. Empty inputs call no
callback. Iterator consumers traverse directly in constant stack space,
without first building a list. They finish the current callback before
forcing the next tail; `iter.find` leaves that tail unforced on success.
A callback failure stops traversal immediately. Iterator producers still have
pure, lazy tails; the consumers can have effectful callbacks. An infinite
iterator needs a bound such as `iter.take`, or a predicate that eventually
matches for `iter.find`.

`fold-until` skips subsequent callbacks after `Stop`; its list argument has
already been evaluated. `map-accum` preserves output order and includes the
last callback's state in the result. For example:

```fwp
prefix-sums = map-accum (add | flip compose (both id id)) 0
# [1, 2, 3] | prefix-sums  produces ([1, 3, 6], 6)
first-large = iter.find (gt 100)
# 0 | iter.count-from | first-large  produces Some 101
```

Use `run-state` with `get`, `put` and `modify` when a handler is convenient;
use `map-accum` when the state transition and final state belong in the API.
Existing `fold`, `scan`, `loop`, `each`, `count`, `any`, `all`, `filter-map`,
`both`, `fork` and `tap` remain ordinary library tools. `if` remains useful for
choosing a branch that receives the original input; `match` takes a value
apart. Both are functions, and `if` lowers to the existing match IR.

These APIs do not promise zero allocation. Lazy tails can allocate closures;
`map-accum` builds the output in reverse and reverses it once. See the
[standard library](stdlib.md) for explicit `Dup` constraints. Existing fusion
restrictions still protect effect and trap order.

### Constant functions

`const value` is a function that ignores its next argument and returns
`value`. For example, `[1, 2, 3] | map (const 7)` produces `[7, 7, 7]`.
The literal `7` is a value, not a callback; values are not implicitly lifted
to functions. `const (add 1)` returns a function value after ignoring one
argument. It does not apply `add 1` or defer evaluation of its own argument.

### Pattern matching

```
area = match
    Circle _ _ -> const (fork mul id id | mul 3.14159)
    Square _ _ -> const (fork mul id id)
```

A `match` is a function. Patterns are:

- constructors with argument patterns (`Circle _ _`); a bare constructor
  with fields, such as `Circle`, is short for `Circle _ _`;
- integer literals without a suffix and string literals; their type comes
  from the value matched;
- tuples, including `(_, )` for a one-element tuple, and `()`;
- `_` holes.

Records are matched through their fields with selectors, not patterns.
Each hole's value is passed, in order, as an argument to the arm's body.
Arms are checked for exhaustiveness, and the compiler names a missing case.
For two arguments, `curry (match (_, _) -> const)` returns the first argument:
its two holes pass both values to `const`, which ignores the second. The brace
form `match { Some -> id, None -> const 0 }` fits on one line.

## Types

A type describes the values an expression may have. A record holds named fields;
a tuple holds numbered fields; a variant chooses one constructor and its payload.
A structural record is identified by its fields; a nominal record also has its
declared type name. An open row means additional fields/effects may be present.

- **Numbers:** `I8`..`I128`, `U8`..`U128`, `ISize`, `USize`, `F16`, `BF16`,
  `F32`, `F64`, `F128`, `TInt[N]`, `Trit`.
  - Integer arithmetic traps on overflow; `wrapping.*`, `saturating.*`,
    `checked.*` and `overflowing.*` give the other behaviours.
  - `TInt[N]` has at most 40 trits; a wider `TInt` is a compile error.
  - Floats are IEEE. An `F32` literal is rounded once, directly to `F32`;
    an integer literal at a float type is its magnitude, rounded once.
    `neg` flips the sign, so `neg 0.0` is `-0.0`. `float.to-int` is `None`
    unless the truncated value fits the integer type exactly.
    Copies, storage, protocol and ABI bridges preserve float bits. F32/F64
    arithmetic NaN payloads/signs are implementation dependent; the other
    [floating formats](float-formats.md) use canonical arithmetic NaNs.
    Optimizations preserve operation/reduction order and exact finite and
    signed-zero behavior.
- **Basic types:** `Bool`, `String` (UTF-8), `Bytes`, `Duration`,
  `List[T]`, `Array[T]`, `Map[K, V]`, `Set[T]`, `Option[T]`,
  `Result[T, E]`.
- **Functions:** `A -> B ! {IO, Error[E] | e}`. The effect row comes after
  `!`, and `e` is a row variable.
- **Type-level naturals:** `Vector[F64, 3]`, `Matrix[T, M, N]`, `Vec[4, F32]`.
  A size may be a sum or a product of sizes: `vector.append : Vector[t, m]
  -> Vector[t, n] -> Vector[t, n + m]`, `matrix.flatten : Matrix[t, m, n] ->
  Vector[t, m * n]`. Sizes are compared as polynomials, so `2 * n` is
  `n + n`, and a generic signature must hold for every size. A size
  inference cannot work out (two unknown sizes whose sum must be 5) is an
  error that asks for a signature. A size `n + 1` is never zero, so
  `vector.head : Vector[t, n + 1] -> t` (and `last`, `tail`, `init`)
  needs no `Option`: `vector [] | vector.head` is a compile error, and
  `vector.non-empty` checks a run-time size once. Subtraction is the other
  way round: `vector.split : Vector[a, m] -> Vector[t, n + m] ->
  (Vector[t, m], Vector[t, n])` takes the first m elements, and
  a vector of 5 split by one of 7 is a compile error (and so for
  `matrix.split-rows` and `matrix.split-columns`).
- **Abstract sizes:** `_` or `_n` in the result of a signature is a size
  the definition chooses when the program runs: `vector.from-list :
  List[t] -> Vector[t, _]`, `matrix.from-rows : List[List[t]] ->
  Matrix[t, _m, _n]`. For callers it is unknown but rigid, and each call
  gives a size of its own, so `vector.from-list a | vector.add
  (vector.from-list b)` is a compile error. `ys | vector.same-size xs`
  (`Option[Vector[b, m]]`), `matrix.same-shape` and `matrix.as-square`
  compare at run time. A function's abstract size cannot be shared
  beyond one call's result (`map vector.from-list` is an error), and
  may not appear in an argument (use a size variable). Values of
  different sizes share a type when packed: `vector.pack : Vector[t, n]
  -> AnyVector[t]` hides the size, so a `List[AnyVector[F64]]` holds
  vectors of any lengths, and `vector.unpack : AnyVector[t] -> Vector[t,
  _]` gives each a size of its own (`matrix.pack` and `matrix.unpack`
  likewise).
  Performance: an abstract size costs a run-time comparison and an
  `Option` at each such check; a static size avoids that particular runtime check.
- **Higher-kinded parameters:** `Functor[F]`.

### Generics

Only a signature makes a definition generic. Its type variables are the
definition's type parameters, and its `where` clause is their
constraints:

```fwp
swap : (a, b) -> (b, a)
swap = both .1 .0

sum-squares : List[a] -> a where Add[a], Mul[a], Zero[a], Dup[a]
sum-squares = map (fork mul id id) | fold add zero
```

A definition without a signature is not generic:

- A type left open only by a literal is `I64` (integer literal) or `F64`
  (float literal), so `inc = add 1` is `I64 -> I64`.
- Any other open type is an error, which shows the signature to write.
  For `square = fork mul id id`, that is `square : a -> a where Mul[a]`.
- `Dup` constraints and effect rows are inferred, with or without a
  signature.

Generics are resolved at compile time: each use at new types compiles to
its own specialized code, without runtime trait-method lookup. This can increase
code size and does not remove all boxes or indirect calls at other boundaries
([design.md](design.md#generics)).

## Traits

A trait names a set of operations a type supports. `Add` supplies `add`, `Ord`
supplies ordering and `Display` supplies textual output. A derived trait is filled
in by the compiler from a type's fields. `Functor` maps a function over a container;
`Applicative` additionally applies contained functions; `Monad` sequences operations
whose results determine later operations. These are library abstractions, not new
control-flow syntax. A higher-kinded parameter such as `F` in `Functor[F]` stands
for a type constructor (`List`, for example), which still needs an element type.

- **Numeric:** `Add`, `Sub`, `Mul`, `Div`, `Rem`, `Neg`, `Zero`, `One`,
  `FromInt`, `FromFloat`, `Ring`, `Field`, `Floating`, and the primitive
  classes `Integer`, `Signed`, `Float` and `Numeric`.
- **Structural**, derived by the compiler: `Eq`, `Ord`, `Hash`, `Display`,
  `Dup`, `Encode`, `Decode`.
- **Abstractions:** `Functor`, `Applicative`, `Monad`.

The standard library implements the numeric traits for `Complex[T]`,
`Dual[T]` (forward-mode autodiff), `Rev[T]` (reverse-mode autodiff) and
`TensorExpr[N]` (fused elementwise kernels on devices), so code written
against the traits computes values, derivatives or kernels
([numerics.md](numerics.md)).

## Effects

Effects describe actions beyond returning a value. The compiler propagates them
through calls so that a function cannot hide IO, failure or state use. A handler
provides the meaning of a particular effect within a scope, such as catching an
error or supplying state. An effect row is the set of such requirements, possibly
with an unknown remainder.

| Effect | Performed by |
|---|---|
| `IO` | console, environment, clocks, logs, metrics |
| `FileIO` | files and directories |
| `Process` | running other programs |
| `Network` | sockets, DNS |
| `Async` | tasks, channels, sleeping |
| `Random` | random numbers |
| `State[S]` | `get`, `put`, `modify` (handled by `run-state`) |
| `Error[E]` | `fail` (handled by `attempt`, re-raised by `try`) |
| `Alloc`, `Unsafe` | allocation, raw memory and pointers |

The effect rules:

- Top-level values that are not functions must be pure; `main` and tests
  are the exceptions.
- Only the final arrow of a function type may carry effects.
- `comptime` code may use only `IO`, `FileIO`, `Alloc` and `Error`.
- A spawned task may not raise `Error`.

## Compile-time evaluation and macros

Macros are implemented expression transformations. See
[the compiler pipeline](compiler-pipeline.md#macros-and-compile-time-values)
for expansion order, hygiene, limits and how this differs from `comptime`;
[lesson 11](tutorials/11-comptime-and-macros/README.md) is a runnable introduction.

- `comptime e` runs `e` in the interpreter during compilation and embeds
  the result, even closures and maps, as a constant.
- `quote e` is the `Syntax` of `e`. `Syntax` and `SynPat` are ordinary
  data types.
- A macro takes zero or more `Syntax` arguments and returns `Syntax`.
  Resolved names in a quote are qualified at its definition site. Spliced
  argument names keep their caller spelling; manually constructed names do not
  acquire automatic hygiene.

`SFloat` carries decimal text, for example `SFloat "1.25"`, so a macro can
preserve precision until the expanded expression's type is inferred. Its text
is one unsuffixed decimal float token, with a decimal point or lowercase `e`,
without digit separators or surrounding whitespace. Quoting normalizes digit
separators and exponent case; it does not round the value. Suffixed literals
retain their suffix through `SOther`. Use literal text to avoid losing digits
in macros.

## C interop

Foreign-function interoperation (FFI) calls code outside fwp. An ABI specifies
C argument, result and memory layout. A pointer is an address whose validity is
the caller's responsibility; declaring `Unsafe` records that responsibility but
does not verify the address. [Lesson 9](tutorials/09-c-interop/README.md) walks
through allocation, a callback, copying a result and freeing the raw buffer.

```
foreign "C" strlen : String -> USize
repr(C) DivResult = { quot: I32, rem: I32 }
foreign "C" c-div : I32 -> I32 -> DivResult = "div"
foreign "C" qsort : Ptr[I32] -> USize -> USize -> (Ptr[I32] -> Ptr[I32] -> I32 ! {Unsafe}) -> () ! {Unsafe}
foreign "C" snprintf : Ptr[U8] -> USize -> String -> I64 -> I32 ! {Unsafe} = "snprintf" variadic 3
```

A C name other than the fwp one comes after `=`: `c-div 7 2` calls
`div(7, 2)`.

| fwp | C |
|---|---|
| integers | `intN_t`, `uintN_t`; `ISize`/`USize` are `ptrdiff_t`/`size_t` |
| `F32`, `F64`, `Bool` | `float`, `double`, `_Bool` |
| `F16`, `BF16` | `uint16_t` containing the raw format bits |
| `F128` | `struct fwp_binary128 { uint64_t low, high; }` containing raw bits |
| `()` | `void` |
| `String` | `const char *` |
| `Bytes` | `const uint8_t *` (parameters only) |
| `Ptr[T]` | a pointer |
| `Option[Ptr[T]]` | a nullable pointer |
| `repr(C)` record | a struct |
| function | a callback |

The half/bfloat/quad ABI follows the accepted [format contract](float-formats.md). C code receives bits in the declared structs or
integers; it must explicitly convert to a numeric C type if needed. Quad does
not use the host's `long double` ABI. `repr(C)` fields, exported headers and
pointer element widths use the same representation (2/2/16 bytes).

- Foreign functions take their arguments in C order, not data-last, and
  should not reuse a standard name (`div` above would shadow fwp's own).
- Raw memory: `mem.alloc`, `mem.free`, `mem.string`, `ptr.read`,
  `ptr.write`, `ptr.at` and `ptr.read-string`, under `Unsafe`.
- C borrows `String`/`Bytes` arguments and string fields only for the call;
  it must copy data it wants to retain. Returned C strings are copied into
  owned language values before the call boundary finishes.
- A callback may only be used on the calling task while the foreign call that
  received it is running. Native callback frames follow that task across
  suspension and are restored after nested calls, failure and cancellation.
  Checked ARC admits callbacks with copied numeric/Boolean/unit C arguments and
  results; raw pointers and callbacks returning managed C addresses remain
  outside that ownership contract.
- Before evaluation, the interpreter builds and loads a small C bridge using
  the system C compiler. The bridge converts fwp values to C arguments and back.
  Preparation failure prevents the program from starting; foreign calls during
  evaluation never start a compiler. The REPL and interpreter debugger continue
  to reject foreign C calls; use an ahead-of-time native build there.
- `--link` adds C sources, objects or libraries (`-lm`, `-L/dir`,
  `util.c`) for both backends.
- `fwp build --staticlib` or `--cdylib` turns the exported functions into
  a C library with a header. Any language with a C FFI can call it; see
  `tests/c-interop/main.rs` for Rust.
  A returned string or a returned struct containing strings transfers ownership
  to the caller. For an export named `greet`, call `fwp_release_greet(result)`
  exactly once after using the result. Do not call C's `free`, change string
  bytes, or release both an original result and a copy of its pointer bits.
  Release every result before unloading the library. The generated header
  declares the matching release functions; scalar-only results need none.
  Native teardown cancels library tasks and releases cached values and
  runtime regions at unload (or static-archive process exit). The host must finish
  all calls before unloading; see [ownership coverage](ownership.md#ownership-coverage)
  and [current validation](development-state.md).
  Scalar/struct results are copied into C values. A nullable pointer copies the
  raw pointer; the pointee follows its own allocation/lifetime contract.
  C input ownership copies strings and `repr(C)` records into owned
  language values. Export validation rejects `Bytes` parameters,
  because the byte pointer ABI carries no length; foreign calls keep their
  existing convention. See [delivery evidence](roadmap-history.md) for accepted checks.

## The `fwp` command

Exported functions also run as command-line programs, with flags, help,
subcommands, environment variables, shell completion and man pages
([cli.md](cli.md)), as REST endpoints with a JSON contract and an
OpenAPI document ([rest.md](rest.md)), and as MCP tools
([mcp.md](mcp.md)); [interfaces.md](interfaces.md) compares them. A
program also splits into services that call each other over gRPC
([services.md](services.md)). The HTTP, REST and service servers and
clients also speak TLS
([tls.md](tls.md)). The HTTP server and client (and so REST) speak
HTTP/1.1 and HTTP/2, compress bodies with gzip and deflate, and carry
WebSocket sessions ([concurrency.md](concurrency.md#http2)).

```
fwp run [--link X]... [--service M]... file.fwp [args...]
                                              run main (compiled, see below)
fwp build file.fwp [options]                  compile
    -o out           output path
    -O0..-O3         C optimization level
    --fn name        an exported function as an executable (see cli.md)
    --cli            the exported functions exposed as `cli` as the
                     subcommands of one executable (see cli.md)
    --rest           the exported functions exposed as `rest` as the
                     endpoints of one HTTP server, with /openapi.json,
                     forms and content negotiation (see rest.md)
    --mcp            the exported functions exposed as `mcp` as the tools
                     of one MCP server, on stdio or HTTP (see mcp.md)
    --target T       native (default), <arch>-linux (cross-compiled, such
                     as aarch64-linux), wasm32-wasi, wasm32-browser
    --fat            one variant per CPU feature level, chosen at startup
    --static         a statically linked executable, which needs no shared
                     libraries (not even the C library's) at run time
    --pgo            profile-guided: build with instrumentation, run it once
                     with the arguments after `--` (stdin from
                     --pgo-input F, or empty), then build with the profile
                     (needs GCC)
    --gc arc         checked native/WebAssembly executables and native C libraries;
                     unsupported value/runtime boundaries diagnose
    --gc tracing     tracing collection mode (the default)
    --memory static  bounded runtime storage and stacks at startup, with
                     --heap S, --pool S, --stack S, --tasks N,
                     --task-stack S and --threads N
    --wasm-async A   jspi (default) or asyncify: how tasks switch on WebAssembly
    --staticlib      lib<name>.a and lib<name>.h of the exported functions
    --cdylib         lib<name>.so (.dylib on macOS) and lib<name>.h
    --link X         C code or libraries for foreign functions
    --emit-c         write the generated C instead of compiling it
    --service M[=A]  split M into a gRPC service (repeatable); -o is then
                     a directory for the main and server executables
fwp serve [--service M]... file.fwp module [--listen A]
                                              serve a module over gRPC
fwp serve --rest file.fwp [--listen A]        serve the functions exposed as `rest` as REST endpoints
fwp serve --mcp file.fwp [--listen A]         serve the functions exposed as `mcp` as MCP tools
                                              (stdio; HTTP at /mcp with --listen)
    --tls-cert F --tls-key F                  (`fwp serve`, `fwp serve --rest` and the servers that
                                              --rest and --service build) serve over TLS
                                              with this certificate chain and key (PEM; see tls.md)
    --tls-client-ca F                         and require client certificates signed by these CAs
    --cors ORIGINS                            (REST servers) allow these origins from browsers
fwp proto file.fwp [--service M]...           print the messages of the services (.proto)
fwp openapi [--yaml] file.fwp                 print the OpenAPI document of the REST endpoints
fwp openapi --import spec.json [-o out.fwp]   generate a client module of an OpenAPI 3 or Swagger 2.0
                                              document (JSON or YAML)
fwp exec file.fwp fn [args...]                run an exported function
fwp exec --cli file.fwp [command] [args...]   run the file as `--cli` builds it
fwp pipe 'a.fwp:f x | b.fwp:g'                connect functions with typed pipes
fwp test file.fwp                             run test declarations
fwp test --std                                the standard library's tests
fwp check [--parse] file.fwp                  print inferred types (or the syntax tree)
fwp fmt [--check] [paths...]                  format files in place (see below)
fwp lint [paths...]                           warn about likely mistakes (see below)
fwp lsp                                       the language server, on stdin/stdout
fwp cache dir | clean                         print or empty the cache of compiled programs
    --interp         (run, exec, test, serve, pipe) run the interpreter instead
    -O0..-O3         (run, exec, test, serve) the C optimization level
```

A file argument of `-` reads the program from standard input.

### Compiled by default

`fwp run`, `fwp exec`, `fwp test`, `fwp serve` (gRPC services, `--rest`
and `--mcp`) and the stages of `fwp pipe` compile the program to a native
executable through C, as `fwp build` would, and run it in place of `fwp`
(on Unix the executable replaces the `fwp` process, so it has its process
id, signals and exit status). The executable is cached under the hash of
its C source, C compiler identity and options, header-search environment, files
given to `--link` and the version of fwp. Linked C and preprocessed assembly
sources are expanded before lookup, so edited or missing included headers cannot
silently reuse an old executable. Exact-float programs also include their C++
compiler identity; integer-only programs do not require C++. Cache hits avoid
native recompilation. The type checker and dependency checks still run on every
start, so startup is separate from the compiled program's execution time.

| | |
|---|---|
| `--interp`, `FWP_RUN=interp` | run the interpreter instead (`--native` and `FWP_RUN=native` ask for the default) |
| `-O0` .. `-O3`, `-Os` before the file | the C optimization level: `-O2`, and `-O1` for tests |
| `FWP_CACHE_DIR` | the cache: `$XDG_CACHE_HOME/fwp`, else `~/.cache/fwp`, else `fwp-cache` in the temporary directory |
| `FWP_CACHE_MAX` | how many executables it keeps (256; minimum 1, including when set to 0); pruning preserves the current executable |
| `fwp cache dir`, `fwp cache clean` | print its directory, remove its executables |
| `CC` | the C compiler (`cc`) |
| `FWP_LTO` | with GCC, programs over 1 MB of generated C use `-flto=auto` to permit parallel code generation. `FWP_LTO=0` disables it; `FWP_LTO=1` enables it for any size. Compilation-time effects depend on the program and available CPU/memory. This setting participates in the executable cache key. |

Without a C compiler a program is interpreted, with a note on standard
error (none when `FWP_RUN` is set). The WebAssembly build of fwp always
interprets. The interpreter is the reference: the golden tests run every
program through both and compare their output byte for byte.

Exit codes:

| Code | Meaning |
|---|---|
| 0 | success |
| 1 | uncaught error, or the main task was cancelled |
| 2 | usage error, or an executable function's argument or flag cannot be parsed |
| 3 | malformed input to an executable function |
| 101 | trap: overflow, division by zero, deadlock, or stack overflow (`fwp: trap: stack overflow`) |
| 102 | out of memory (`fwp: out of memory: …`); with static memory, the message names the option to raise |

An exported function run as a program exits with 1 when it returns
`Err` or raises an uncaught `Error`, and prints the error as
`name: message` ([cli.md](cli.md)); one that returns an `Outcome` exits with its `status`. When `main` has type `I32`, its value is the exit code. `exit n` exits with `n` modulo 256 (`exit 259` is 3, `exit -1` is 255),
as the operating system reports it, in both backends.

Text from outside the program, that is, standard input (`read-line`,
`read-all`, `read-lines`, and the text records of executables), command-line
arguments (`args`, and the arguments of executables) and environment
variables (`env.get`), is decoded as UTF-8 by both backends in the same
way: each maximal invalid sequence of bytes becomes one U+FFFD (`�`), as
Rust's `String::from_utf8_lossy` does. Strings are therefore always valid
UTF-8. Strings in the binary pipe protocol must be valid UTF-8 and are
rejected otherwise.

`fwp build` takes one input file. Unknown options, unsupported optimization
levels and options missing a required value fail before producing an artifact.
For a shared C library, use `--cdylib`; the compiler does not guess another mode
from a misspelled option.

### Checked reference counting

The `--gc arc` mode checks memory ownership and excludes tracing collection.
Supported entries include native main/CLI/function executables, synchronous WASI
executables, and C libraries whose inputs are copied and whose results contain
scalars or explicitly released strings. The [gRPC extension](services.md#building-without-tracing-collection)
adds checked split clients and services, accepted in
[PR #161](roadmap-history.md#remote-calls-without-tracing-and-record-field-moves-pr-161).
HTTP clients and servers are accepted in PRs #162/#163; their ownership contracts
are described in the [ownership guide](ownership.md#checked-arc-delivery).

`fwp build --gc arc --staticlib stats.fwp -o libstats.a` can export a
`String -> I64` function: it copies the input for the call and returns the count
by value. A `String -> String` export returns an owned string with a matching
`fwp_release_NAME` function. Records may contain scalars and owned strings;
release the complete unchanged record once. Raw pointers remain outside checked
ownership. Serialize host calls, including releases, and release every result
before library unload. [PR #165](roadmap-history.md#owned-c-results-and-failure-cleanup-pr-165)
records passing six-platform and production checks for these library results.
The mode rejects unproved ownership or cycles. Browser-loader and WASI task
extensions pass actual-module JSPI and Asyncify cleanup checks on both Linux
hosts; [the measurements](benchmarks.md#webassembly-task-and-browser-loader-ownership)
record their scope and remaining costs. Generated REST and MCP entries also use
checked ownership; [PR #164](roadmap-history.md#server-entries-exact-json-and-webassembly-task-owners-pr-164)
records their passing functional, memory and production checks.
Channels are eligible when their ownership types cannot form a queue cycle.
`Channel[String]` and `Channel[List[Channel[String]]]` are eligible: the inner
channels hold strings, which cannot point back. For `Channel[Task[String]]`, the
[task-message extension](measurements/task-channels.md) additionally proves the
task's computation and result owners: a known producer can be accepted, but an
unknown producer or captured task-bearing queue is rejected. The linked guide
records validation status. HTTP stream handles remain excluded because their
handlers can own the queue. The [queued-function capture proof](ownership.md#functions-stored-in-channels)
admits proved immutable captures and shared socket handles (`UdpSocket`,
`Listener`, `Conn`), which cannot own a queue. It also admits captured data-only
queues from `channel.make` when their nested owners have known sources.
Served gRPC response channels have an explicit native-producer contract; arbitrary
external channels remain rejected as captures. The linked contract
records validation status. A function's input/output type alone cannot establish that
proof. The compiler follows record,
variant and container fields and rejects a path back to the same channel type;
see the [proof and limits](ownership.md#ownership-boundaries).
It requires normal counted
freeing; tracing stress/verification and reuse poisoning are incompatible.
The [ownership contract](ownership.md#checked-arc-delivery) and
[delivery evidence](roadmap-history.md) record coverage and production acceptance.

### Static memory

`fwp build --memory static` bounds runtime-owned memory using storage reserved,
committed and touched at startup. Linux places the heap, buffers and stacks in
one mapping. The Windows implementation commits stacks
separately and reuses precreated task fibers and worker threads. External DLL
allocations and Windows resources are outside this budget; touched pages can
still be paged out by the OS. The configured parts are:

| Part | Option | Default | What uses it |
|---|---|---|---|
| heap | `--heap S` | 64M | fwp values; still collected, but it never grows: when it is full the collector runs before giving up |
| pool | `--pool S` | 32M | Runtime buffers and decimal overflow scratch; Linux interposes allocation functions, Windows uses a private allocator |
| main stack | `--stack S` | 16M | the main task |
| task stacks | `--tasks N`, `--task-stack S` | 64 of 1M | tasks: at most N run at once, each with a guard page |
| thread stacks | `--threads N` | 8 of 1M | `CpuParallel` workers; Windows also uses these workers for process output capture (two slots per capture) |

Sizes take `K`, `M` and `G`. Running out of a part ends the program with
exit code 102 and names the option to raise:

```
fwp: out of memory: the static heap (1024 KiB) is full; build with a larger --heap
```

`FWP_MEMORY_REPORT=1` prints, at exit, the size of each part and how much
of it was used at most, which is how to size them:

```
fwp: static memory: 124448 KiB mapped at startup
  heap           65536 KiB, 8320 KiB used at most (4231 KiB live at most, 1 collections)
  pool           32768 KiB, 136 KiB used at most
  ...
```

Pipes between fwp programs stay on the Unix socket transport (`UDS_V1`)
rather than the shared-memory ring, which would be new memory. Static
memory is verified on Linux and Windows, with Windows-specific checks in
`tests/windows_static_memory.rs`. WebAssembly and libraries keep the usual
allocator. `tests/static_memory.rs` checks the Linux golden
programs with it, and, with `strace`, that a program with tasks, a
parallel kernel and plenty of allocation makes no memory system call after
startup.

### Targets

| Target | Output | Runtime |
|---|---|---|
| native | an executable for the host | Linux and native macOS on Apple Silicon/Intel ([verified baseline](development-state.md)). TLS programs link OpenSSL 3 and need its headers; on macOS set `FWP_OPENSSL_DIR` ([tls.md](tls.md#openssl)) |
| `wasm32-wasi` | a module for wasmtime or `node:wasi` | needs clang with a WASI sysroot; no sockets or processes, and programs that use them are rejected at compile time; files only in preopened directories; tasks need a JavaScript host with JSPI, or `--wasm-async=asyncify` (see below) |
| `wasm32-browser` | the module plus a JavaScript loader (`run({ stdout, stderr, args, env, stdin })`, resolving to the exit code) | as `wasm32-wasi`, but no files: standard streams, clocks and random numbers; the page must be served over HTTP; tasks run in browsers with JSPI, or in any browser with `--wasm-async=asyncify` (see below) |
| `<arch>-linux` | an executable for another 64-bit little-endian Linux: `x86_64`, `aarch64` (or `arm64`), `riscv64`, `powerpc64le`, `loongarch64`; `-gnu` and Rust's `-unknown-linux-gnu` spellings are accepted | all features, as native. See [Cross-compiling](#cross-compiling) |
| `--fat` (x86-64) | variants for x86-64, x86-64-v2 and x86-64-v3 | the best variant the CPU supports runs; `FWP_VARIANT=name` forces one, `FWP_VARIANT_SHOW=1` reports the choice |
| `--static` | an executable linked with static libraries | runs on any Linux of the same architecture. A program that uses TLS needs OpenSSL's static libraries (`libssl.a`) to build; the C library's name resolution (`getaddrinfo`) still loads the system's NSS modules when it runs |
| `--pgo` (GCC) | an executable optimized with a profile of one training run | `fwp build --pgo main.fwp -- 1000` runs the instrumented program as `main 1000`, discarding its output, then compiles again with the branch and call counts it recorded. The training run should exercise the program as it is used |

The interpreter and every compiled target produce the same output for the
same program, including float formatting and trap messages. The test suite
checks this.

### Cross-compiling

`fwp build --target aarch64-linux main.fwp` builds an executable for
64-bit ARM Linux on any host, as `GOARCH=arm64 go build` or
`cargo build --target aarch64-unknown-linux-gnu` do. The generated C is
the same for every target; only the C compiler differs. fwp uses the
first of:

1. `FWP_CC_<triple>`, with `_` for `-` (`FWP_CC_aarch64_linux_gnu`), a
   compiler and its first arguments (`"clang --target=aarch64-linux-gnu"`);
2. `<triple>-gcc` (Debian and Ubuntu: `gcc-aarch64-linux-gnu`);
3. `clang --target=<triple>`, when the target's libraries are in
   `/usr/<triple>`;
4. for musl on the host's architecture, `musl-gcc` (Debian and Ubuntu:
   `musl-tools`);
5. `zig cc -target <triple>`, which brings the C library of every target
   with it.

`--static` makes an executable that runs on any Linux of that
architecture, and `--fat`, `--staticlib`, `--cdylib` and `--service`
cross-compile too (libraries with `<triple>-ar`). A program that uses TLS
needs the target's OpenSSL (Debian and Ubuntu: `libssl-dev:arm64` from
the target's package architecture). `--pgo` trains the program by running
it, so it builds for the host only.

`--target x86_64-linux-musl` (or `aarch64-linux-musl`) builds with musl
instead of glibc; with `--static` that is one executable without any
library of the system, smaller than glibc's static ones. musl has no
`makecontext`, so the runtime switches tasks itself there, saving the
callee-saved registers on the task's stack (`fwp_ctx_swap` in
`runtime/fwp_rt_task.c`, for x86-64 and AArch64). A program that uses TLS
needs an OpenSSL built for musl.

Cross targets currently name 64-bit little-endian Linux systems. Native
macOS on Apple Silicon and Intel passed the full native CI gate: use
`--target native` with Apple Clang and consult
[development-state.md](development-state.md) for verification. Shared libraries
use `.dylib`; native `--static` linking is rejected. Build a separate binary
for each supported OS/architecture; universal binaries are outside project scope.
The desired platform matrix is Linux, macOS and Windows on ARM64 (`aarch64`)
and AMD64 (`x86_64`); see [current acceptance](../PLAN.md#platform-objective-and-current-evidence).
Native Windows ARM64/AMD64 is accepted. Darwin cross targets are not implemented;
`--pgo` requires GCC.
For TLS set `FWP_OPENSSL_DIR` as described in [tls.md](tls.md#openssl).
To try an ARM executable on an x86 machine,
run it with qemu: `qemu-aarch64 -L /usr/aarch64-linux-gnu ./main`.

#### Tasks on WebAssembly

These fwp WebAssembly builds implement tasks and channels (`Async`) through
JavaScript Promise Integration (JSPI): each task
is a fiber whose stack the JavaScript host suspends and resumes
(`web/fibers.js`, which the browser loader includes). The scheduler is the
native one (or, in fwp.wasm, the interpreter's), with the same order of
tasks; waiting for a timer suspends the program on a JavaScript timer
rather than busy-waiting, and a program whose tasks all wait for each
other traps with `fwp: trap: deadlock: every task is waiting`. Tasks are
preempted there as natively ([preemption](concurrency.md#preemption)):
each switch at the end of a slice is a JSPI suspension.

| Host | Tasks |
|---|---|
| JavaScript host exposing the JSPI interfaces recognized by `web/fibers.js` | yes, with the default JSPI build |
| JavaScript host without those interfaces | requires an Asyncify build and support for its transformed module; a JSPI build cannot start tasks |
| node 24 | yes (JSPI is on by default; node 22 needs `--experimental-wasm-jspi`). With `node:wasi`, also pass `--no-turbo-fast-api-calls` (`tests/wasm/wasi-run.mjs` and `fwp-run.mjs` do): node may otherwise crash when V8 collects garbage inside a WASI call made from optimized code (node 24 stops with ``Check failed: isolate_->IsOnCentralStack()``, node 22 with a segmentation fault), which programs that switch tasks often make likely. node 24's `node:wasi` also rejects addresses beyond 2 GiB (which the stacks of a few thousand tasks reach) unless its 32-bit arguments are made unsigned (`x >>> 0`) in wrappers, as these runners and the browser loader do |
| wasmtime and other WASI runtimes | no: a program that starts a task traps with `fwp: trap: tasks need a WebAssembly host with JavaScript Promise Integration (JSPI), …`; `task.sleep` alone works |

A module that uses tasks exports `fwp_fiber_hooks`, `fwp_fiber_stack`,
`fwp_fiber_entry`, its stack pointer and its function table, into which
the host installs the switching functions; it imports nothing beyond WASI,
so it still instantiates in any WASI runtime. Programs without tasks are
unchanged. A fiber's stack is as large as the engine makes it (in
browsers about as large as a page's, a few thousand nested calls); running
out is the trap `fwp: trap: stack overflow`.

`fwp build --target wasm32-wasi|wasm32-browser --wasm-async=asyncify`
builds a program with tasks for engines without JSPI: binaryen's Asyncify
pass (`wasm-opt --asyncify`) rewrites the module so that its call stack
can be unwound into memory and rewound later, and `web/fibers.js` then
switches fibers by unwinding the one that suspends and rewinding the next
(the module exports `asyncify_*`, which the loader recognizes). It supplies task suspension without JSPI on a compatible JavaScript host,
with the same intended output, preemption and cancellation; not in WASI runtimes without a
JavaScript host. wasm-opt is an optional tool, needed only for this
option and only by programs with tasks: it comes with binaryen (`npm
install -g binaryen`, or a system package); `FWP_WASM_OPT` names the
executable. Asyncify adds code and execution-state save/restore work; its cost
depends on the module and host. Compare the same program and host in JSPI and
Asyncify modes, recording compiler settings, time and memory, before making a
performance claim. The default stays `--wasm-async=jspi`. For the compiler/interpreter module,
`scripts/build-playground.sh --asyncify` applies the same transformation, allowing
tasks in hosts without JSPI when they support the transformed module.

### fwp in the browser

fwp itself, the compiler and the interpreter, builds for WebAssembly:
`cargo build --release --target wasm32-wasip1` makes `fwp.wasm`, a WASI
command module that takes the same arguments as `fwp`. The playground in
`web/` runs it in a page. `scripts/build-playground.sh` builds
`web/fwp.wasm` and `web/examples/`, and any static file server can serve
`web/`:

```
rustup target add wasm32-wasip1
scripts/build-playground.sh
python3 -m http.server -d web 8000
```

| File | Role |
|---|---|
| `web/index.html`, `web/playground.js` | the editor, standard input, examples, and Run (`fwp run`), Check (`fwp check`), Format (`fwp fmt -`), Test (`fwp test`) and Stop |
| `web/fwp-worker.js` | runs `fwp.wasm` in a web worker, so a long program can be stopped |
| `web/wasi.js` | a small WASI preview 1 in JavaScript: arguments, environment, clocks, random numbers, standard streams and an in-memory file system preopened as `.` and `/`. Other calls (sockets, links) return `ENOSYS`. It works in browsers and in node (`runWasi(module, { args, env, stdin, fs, stdout, stderr })`) |

`fwp.wasm` also runs under other WASI runtimes, with files in preopened
directories. A file argument of `-` reads the program from standard input
(`fwp run -`, `fwp check -`, `fwp fmt -`, which prints the formatted text);
this works in every build. `tests/wasm/fwp-run.mjs` runs `fwp.wasm` under
node with node's WASI or with `web/wasi.js`.

The WebAssembly build has no threads, sockets, processes or `dlopen`:

- `run`, `check`, `test`, `exec`, `fmt`, `lint`, `proto` and `lsp` work.
  `build --emit-c` writes C; other builds need a C compiler.
- Tasks and channels run where the engine has JavaScript Promise
  Integration (see [Tasks on WebAssembly](#tasks-on-webassembly)): the
  playground runs tutorial 6 in Chrome. Each task is a fiber, and
  `web/wasi.js` switches them; fwp's own main task is one too. Elsewhere
  a program that uses them is rejected before it starts:
  ``fwp run: the WebAssembly build of fwp does not provide the `Async` effect (used by `task.spawn`) in this host: tasks need a WebAssembly host with JavaScript Promise Integration (JSPI)``.
- A program that uses sockets or DNS (`Network`), other programs
  (`Process`), services or foreign C functions is rejected before it
  starts, with the effect or function named:
  ``fwp run: the WebAssembly build of fwp does not provide the `Network` effect (used by `tcp.listen`)``.
  These are the effects the `wasm32-wasi` target rejects.
- `fwp build` (without `--emit-c`), `--native`, `fwp pipe`,
  `fwp serve` and `--link` exit with status 2 and
  `fwp: … is not available in the WebAssembly build of fwp`.
- The interpreter's stack is 512 MiB (a linker argument in
  `.cargo/config.toml`), but WebAssembly frames also use the engine's
  native stack, which a browser keeps small: a few hundred to a few
  thousand nested function calls. The interpreter does not currently guarantee
  constant-stack tail recursion. Running out of either is the trap
  `fwp: trap: stack overflow` (exit code 101), with the output written
  before it kept. Iteration through `loop` does not accumulate call frames merely
  by adding iterations; its body can still recurse. List length is not itself
  bounded by call depth, but storage remains limited by available memory.

### Environment variables

| Variable | Effect |
|---|---|
| `FWP_SEED` | fixes the seed of `random.*` |
| `FWP_OUT=bin` | makes executable functions write the binary protocol |
| `FWP_PREEMPT=n` | the slice of a task: the safe points (function entries, `loop` iterations) after which it lets other tasks run and notices cancellation (default 10000; `0`: never; see [preemption](concurrency.md#preemption)) |
| `FWP_TRANSPORT` | the transport an executable reading the binary protocol asks its producer for: `shm` (the default), `uds`, or `stdio`, which keeps the stream on the pipe and makes producers not offer any (see [transports](protocol.md#transports)) |
| `FWP_TRANSPORT_WAIT=ms` | a producer of the binary protocol waits that long after its header for the consumer to ask for a transport (`fwp pipe` sets 10000 for its stages) |
| `FWP_TRANSPORT_REPORT=1` | a consumer of the binary protocol says on stderr when its input moves to another transport |
| `FWP_SERVICE_<M>` | the `host:port` of service `M`, or `tls://host:port` for TLS (see [services](services.md), [tls.md](tls.md#services)) |
| `FWP_REST_ADDR` | the `host:port` a REST server listens on without `--listen` (see [rest.md](rest.md)) |
| `FWP_TLS_CERT`, `FWP_TLS_KEY` | the certificate chain and private key (PEM files) of REST and gRPC servers without `--tls-cert` and `--tls-key`: they serve over TLS when both are set (see [tls.md](tls.md)) |
| `FWP_TLS_CLIENT_CA` | the CA certificates (PEM) of the client certificates that REST and gRPC servers require, without `--tls-client-ca` (see [tls.md](tls.md#mutual-tls)) |
| `FWP_SERVICE_<M>_CA`, `_INSECURE`, `_SERVER_NAME`, `_CERT`, `_KEY` | the TLS options of the clients of service `M`: a CA file, no verification, the server name, a client certificate and key (see [tls.md](tls.md#services)) |
| `FWP_REST_CORS` | the origins (separated by commas, or `*`) that may call a REST server from browsers, without `--cors` (see [rest.md](rest.md#cors)) |
| `SSL_CERT_FILE`, `SSL_CERT_DIR` | OpenSSL's: the CA certificates TLS clients trust instead of the system's (see [tls.md](tls.md#client-options)) |
| `FWP_OPENSSL_DIR` | OpenSSL prefix for host native include/link paths and the interpreter's loader; ignored by Linux cross builds (see [tls.md](tls.md#openssl)) |
| `FWP_NO_OPT=1` | disables the IR optimizer (inlining, specialization, fusion) |
| `FWP_ARRAY_FUSION=0` | when compiling: retain separate numeric Array map/fold/length stages for comparison; normal fusion requires pure terminating callbacks with compatible trap behavior |
| `FWP_DIRECT_INTEGER_PRINT=0` | when compiling: retain the temporary string in an immediate integer `show` followed by `print`, for controlled allocation comparisons |
| `FWP_TYPED_HASH=0` | when compiling: use general type-descriptor hashing instead of specialized numeric loops, for controlled comparisons; encoded bytes and hash results are unchanged |
| `FWP_MATRIX_BLOCKING=0` | when compiling: retain the library F64 matrix implementation for comparison; specialization checks runtime shape and preserves ascending inner-index arithmetic |
| `FWP_AD_WORKSPACE=0` | interpreter and native programs: release detached tape capacity instead of retaining the single bounded 512 KiB workspace; tape identity and scope lifetimes are unchanged |
| `FWP_DUMP_IR=1` | prints the program's own functions in optimized IR to stderr when it is compiled (`all`: the standard library's too; `rc`: with their references counted) |
| `FWP_REUSE=0` | when compiling: disable optional reference-counted reuse, so updates copy rather than reuse unique storage. Resource ownership can still require counting. Checked ARC rejects this setting because it requires counted cleanup; the ordinary tracing mode remains available. |
| `FWP_REUSE_VERIFY=1` | native programs: a value judged unique is copied and the original poisoned instead of reused, so that a wrong judgment shows (for testing) |
| `FWP_FREE=0` | when compiling: disables eligible value storage reclamation by counted drops, leaving that storage to the collector; this does not disable tracing |
| `FWP_GC=off` | native programs: disables tracing collection. Eligible counted drops can still reclaim values; shared/unmodeled storage may remain allocated. This is not a general tracing-free execution guarantee ([ownership](ownership.md)) |
| `FWP_GC=full` | native programs: every collection is a major one (no generations) |
| `FWP_GC_VERIFY=1` | native programs: check each minor collection against a full trace, and abort at the first object it missed (for testing the runtime) |
| `FWP_GC_STATS=1` | native programs: print the collector's statistics to stderr at exit (collections, bytes allocated, heap and live sizes, pauses, peak RSS) |
| `FWP_GC_STRESS=n` | native programs: collect at every n-th allocation (`1`: at every one), to find bugs in the runtime |
| `CC` | the C compiler for native builds |
| `FWP_CC_<triple>` | the C compiler (and its first arguments) for `--target <triple>`, such as `FWP_CC_aarch64_linux_gnu` (see [Cross-compiling](#cross-compiling)) |
| `AR` | the archiver for `--staticlib` (cross builds: `<triple>-ar`, else `llvm-ar`) |
| `FWP_WASM_CC` | the C compiler for WebAssembly builds |
| `FWP_WASM_OPT` | binaryen's `wasm-opt`, for `--wasm-async=asyncify` (default: `wasm-opt` on the `PATH`) |
| `FWP_BLESS=1` | regenerates the expected outputs of the test suite |

## Formatting, linting and editors

### `fwp fmt`

`fwp fmt [--check] [paths...]` formats `.fwp` files in place. Directories
are searched recursively (hidden directories and `target` are skipped);
without paths it formats the current directory. With `--check` it changes
nothing, prints the files that are not formatted and exits with status 1
if there are any. A file with a syntax error is reported and left alone.

The layout is canonical, computed from the syntax tree:

- 80 columns and 4-space indentation;
- an expression that fits on its line stays on it, otherwise it moves to
  the next line, and a pipeline that still does not fit gets one stage
  per line with a leading `|`;
- `match` arms go on their own lines, and the `match` keyword stays at the
  end of the line that introduces it (`f = match`, `curry (match`,
  `x | match`);
- brackets and records that do not fit get one item per line with a
  trailing comma, closing at the indentation of the line that opened
  them (`f [` ... `]`);
- an application that does not fit keeps a simple function and arguments
  on the line and breaks its last argument, or puts one argument per line;
- `make`, `with` and `update` arguments are parenthesized;
- literals keep their spelling (`0xff`, `1_000`, `150ms`, escapes).

Comments are kept: comments between declarations stay in place, and a
declaration that contains a comment is left as written (only trailing
whitespace is removed). Runs of blank lines become one, and the file ends
with a single newline. Formatting is idempotent and never changes the
syntax tree; the test suite checks both over every `.fwp` file of the
repository.

### `fwp lint`

`fwp lint [paths...]` prints warnings in the same form as compiler
diagnostics and exits with status 1 if there are any (2 if a file cannot
be read). It does not type-check the files; `fwp check` does. The rules:

| Code | Warns about |
|---|---|
| `unused-binding` | a top-level binding that is not exported, not `main` and not used anywhere in the file (only in files with `main` or exports; names starting with `_` are exempt) |
| `redundant-id` | a `\| id` stage |
| `map-fusion` | `map f \| map g`, which is `map (f \| g)` with one traversal |
| `trivial-match` | a `match` whose only arm is `_ -> f`, which is just `f` |
| `shadows-std` | a top-level definition with the name of a standard library function |
| `missing-binding` | a signature without a binding |
| `filter-count` | `filter p \| length`, which is `count p` without building the list |
| `filter-find` | `filter p \| head`, which is `find p`, stopping at the first match |
| `double-reverse` | `reverse \| reverse`, which does nothing |
| `bool-if` | `if p (const True) (const False)`, which is `p` (and `p \| not` the other way round) |

A comment `# fwp:allow(code, ...)` in the comment lines directly above a
declaration silences those rules inside it:

```fwp
# fwp:allow(unused-binding)
legacy-total : List[{amount: I64}] -> I64
legacy-total = map .amount | sum
```

### `fwp lsp`

`fwp lsp` is a language server that speaks the Language Server Protocol
over stdin and stdout. It supports:

- diagnostics: syntax errors (all of them, thanks to recovery at
  declaration boundaries), type errors and warnings, and lint warnings
  with their codes, refreshed on every change (full document sync;
  imports are read from disk);
- hover: the inferred type of the name under the cursor (a top-level
  name, an imported or standard library name) and, for a generic name,
  its type at that use;
- go to definition: top-level and imported names, types and constructors,
  and standard library names when `lib/` is next to the compiler's
  sources;
- references: every occurrence of a top-level name, type or constructor
  in the document, with or without its declarations;
- rename: a name the document declares, everywhere in the document (to a
  name of the same kind; uses in other files are not renamed);
- document symbols: the top-level declarations;
- formatting: the whole document with `fwp fmt`;
- completion: the file's top-level names and the standard library's, with
  their types.

Any editor with a generic LSP client can use it: run `fwp lsp` for
`*.fwp` files. For Neovim (0.11 or later):

```lua
vim.filetype.add({ extension = { fwp = "fwp" } })
vim.lsp.config("fwp", {
  cmd = { "fwp", "lsp" },
  filetypes = { "fwp" },
  root_markers = { ".git" },
})
vim.lsp.enable("fwp")
```

For Helix, in `languages.toml`:

```toml
[[language]]
name = "fwp"
scope = "source.fwp"
file-types = ["fwp"]
comment-token = "#"
language-servers = ["fwp"]

[language-server.fwp]
command = "fwp"
args = ["lsp"]
```

VS Code has no built-in generic client. Either configure a generic LSP
client extension with the command `fwp`, the argument `lsp` and the file
pattern `**/*.fwp`, or use a minimal extension built on
`vscode-languageclient`. Its `package.json` declares
`"activationEvents": ["onLanguage:fwp"]` and contributes a language
`fwp` with the extension `.fwp`; `extension.js` is:

```js
const { LanguageClient } = require("vscode-languageclient/node");

let client;

exports.activate = () => {
  client = new LanguageClient(
    "fwp",
    "fwp",
    { command: "fwp", args: ["lsp"] },
    { documentSelector: [{ scheme: "file", language: "fwp" }] }
  );
  client.start();
};

exports.deactivate = () => client && client.stop();
```
