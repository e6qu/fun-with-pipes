# Standard library

Generated from `lib/*.fwp` by `tests/stdlib_doc.rs`; do not edit.
Run `FWP_BLESS=1 cargo test --test stdlib_doc` after changing the library.
Every module is available without an import.

- [Prelude](#prelude)
- [Lists](#lists)
- [Option and Result](#option-and-result)
- [Strings](#strings)
- [Arrays, maps, sets and bytes](#arrays-maps-sets-and-bytes)
- [Iterators](#iterators)
- [Console, environment and time](#console-environment-and-time)
- [Files, directories and paths](#files-directories-and-paths)
- [Processes](#processes)
- [Command-line programs and terminals](#command-line-programs-and-terminals)
- [CSV](#csv)
- [Tasks and channels](#tasks-and-channels)
- [Networking](#networking)
- [TLS](#tls)
- [HTTP](#http)
- [WebSocket](#websocket)
- [JSON](#json)
- [REST endpoints and clients](#rest-endpoints-and-clients)
- [gRPC](#grpc)
- [Protobuf](#protobuf)
- [URLs](#urls)
- [Logs and metrics](#logs-and-metrics)
- [Vectors, matrices and complex numbers](#vectors-matrices-and-complex-numbers)
- [Automatic differentiation](#automatic-differentiation)
- [Tensor expressions](#tensor-expressions)
- [Balanced ternary](#balanced-ternary)
- [SIMD](#simd)
- [C interop](#c-interop)

## Prelude

`lib/prelude.fwp`

fwp standard prelude.

Argument order convention: the "subject" of an operation comes last, so
that `x | sub 1` means x - 1, `x | div 2` means x / 2 and `x | lt 5`
means x < 5.

```fwp
I8 = builtin
I16 = builtin
I32 = builtin
I64 = builtin
I128 = builtin
U8 = builtin
U16 = builtin
U32 = builtin
U64 = builtin
U128 = builtin
ISize = builtin
USize = builtin
F16 = builtin
BF16 = builtin
F32 = builtin
F64 = builtin
F128 = builtin
String = builtin
Bytes = builtin
Trit = builtin
TInt[N] = builtin
Array[T] = builtin
Map[K, V] = builtin
Set[T] = builtin
Duration = { nanos: I64 }

Bool =
    | False
    | True

Ordering =
    | Less
    | Equal
    | Greater

Option[T] =
    | None
    | Some T

Result[T, E] =
    | Ok T
    | Err E

List[T] =
    | Nil
    | Cons T List[T]

Syntax =
    | SName String
    | SCtor String
    | SInt I64
    | SFloat F64
    | SStr String
    | SSelect List[String]
    | SApply Syntax List[Syntax]
    | SPipe Syntax Syntax
    | SUnit
    | STuple List[Syntax]
    | SList List[Syntax]
    | SRecord List[(String, Syntax)]
    | SMatch List[(SynPat, Syntax)]
    | SComptime Syntax
    # any other construct, as source text
    | SOther String
    # a macro invocation `name!(args)`
    | SMacro String List[Syntax]
    # a record form with fields: kind is "with", "update", "make",
    # "make T", or "record T" for `T { ... }`
    | SFields String List[(String, Syntax)]

SynPat =
    | PHole
    | PInt I64
    | PStr String
    | PCtor String List[SynPat]
    | PBare String
    | PTuple List[SynPat]
    | PUnit
syntax.show : Syntax -> String
TypeInfo = { name: String, args: List[String], shape: TypeShape }

TypeShape =
    | ShapePrim
    | ShapeFunction
    | ShapeTuple List[String]
    | ShapeRecord List[FieldInfo]
    | ShapeVariants List[VariantInfo]
FieldInfo = { name: String, ty: String }
VariantInfo = { name: String, fields: List[String] }
id : a -> a
const : a -> b -> a
flip : (a -> b -> c ! e) -> b -> a -> c ! e
compose : (a -> b ! e) -> (b -> c ! e) -> a -> c ! e
apply : a -> (a -> b ! e) -> b ! e
fork : (b -> c -> d ! e) -> (a -> b ! e) -> (a -> c ! e) -> a -> d ! e where Dup[a]
both : (a -> b ! e) -> (a -> c ! e) -> a -> (b, c) ! e where Dup[a]
dup : a -> (a, a) where Dup[a]
on : (b -> b -> c ! e) -> (a -> b ! e) -> a -> a -> c ! e
uncurry : (a -> b -> c ! e) -> (a, b) -> c ! e
curry : ((a, b) -> c ! e) -> a -> b -> c ! e
swap : (a, b) -> (b, a)
first : (a -> c ! e) -> (a, b) -> (c, b) ! e
second : (b -> c ! e) -> (a, b) -> (a, c) ! e
if : (a -> Bool ! e) -> (a -> b ! e) -> (a -> b ! e) -> a -> b ! e where Dup[a]
then2 : (a -> b -> c ! e) -> (c -> d ! e) -> a -> b -> d ! e
curry3 : ((a, b, c) -> d ! e) -> a -> b -> c -> d ! e
uncurry3 : (a -> b -> c -> d ! e) -> (a, b, c) -> d ! e
tap : (a -> b ! e) -> a -> a ! e where Dup[a]

# One step of `loop`: go again from a new state, or stop with a result.
Step[S, R] =
    | Again S
    | Stop R

# Iterate a step function from an initial state until it stops; runs in
# constant stack space (servers and other long-running loops).
loop : (s -> Step[s, r] ! e) -> s -> r ! e

trait Add[T] =
    add : T -> T -> T

trait Sub[T] =
    sub : T -> T -> T

trait Mul[T] =
    mul : T -> T -> T

trait Div[T] =
    div : T -> T -> T

trait Rem[T] =
    rem : T -> T -> T

trait Neg[T] =
    neg : T -> T

trait Zero[T] =
    zero : T

trait One[T] =
    one : T

trait FromInt[T] =
    from-int : I64 -> T

trait FromFloat[T] =
    from-float : F64 -> T
trait Ring[T] : Add[T], Sub[T], Mul[T], Zero[T], One[T] = {}
trait Field[T] : Ring[T], Div[T] = {}

# Primitive implementations; the impls themselves are generated for every
# numeric primitive type.
prim.add : a -> a -> a
prim.sub : a -> a -> a
prim.mul : a -> a -> a
prim.div : a -> a -> a
prim.rem : a -> a -> a
prim.neg : a -> a
prim.zero : a
prim.one : a
prim.from-int : I64 -> a
prim.from-float : F64 -> a

# Stop the program with `fwp: trap: <message>` (exit code 101), as a failed
# run-time check does; for library invariants, not for recoverable errors.
prim.trap : String -> a

# Explicit overflow behaviour (default arithmetic is checked and traps).
wrapping.add : a -> a -> a where Integer[a]
wrapping.sub : a -> a -> a where Integer[a]
wrapping.mul : a -> a -> a where Integer[a]
saturating.add : a -> a -> a where Integer[a]
saturating.sub : a -> a -> a where Integer[a]
saturating.mul : a -> a -> a where Integer[a]
overflowing.add : a -> a -> (a, Bool) where Integer[a]
overflowing.sub : a -> a -> (a, Bool) where Integer[a]
overflowing.mul : a -> a -> (a, Bool) where Integer[a]
checked.add : a -> a -> Option[a] where Integer[a]
checked.sub : a -> a -> Option[a] where Integer[a]
checked.mul : a -> a -> Option[a] where Integer[a]
checked.div : a -> a -> Option[a] where Integer[a]

# Bit operations.
bit.and : a -> a -> a where Integer[a]
bit.or : a -> a -> a where Integer[a]
bit.xor : a -> a -> a where Integer[a]
bit.not : a -> a where Integer[a]
bit.shl : U32 -> a -> a where Integer[a]
bit.shr : U32 -> a -> a where Integer[a]

# Explicit conversions (there are no implicit ones).
int.convert : a -> Option[b] where Integer[a], Integer[b]
int.to-float : a -> b where Integer[a], Float[b]
float.to-int : a -> Option[b] where Float[a], Integer[b]
float.convert : a -> b where Float[a], Float[b]

# Floating point. The elementary functions are methods of `Floating`, so
# generic numeric code also works for dual and complex numbers.
trait Floating[T] =
    sqrt : T -> T
    exp : T -> T
    ln : T -> T
    sin : T -> T
    cos : T -> T
    tan : T -> T
prim.sqrt : a -> a where Float[a] = "sqrt"
prim.exp : a -> a where Float[a] = "exp"
prim.ln : a -> a where Float[a] = "ln"
prim.sin : a -> a where Float[a] = "sin"
prim.cos : a -> a where Float[a] = "cos"
prim.tan : a -> a where Float[a] = "tan"
pow : a -> a -> a where Float[a]
floor : a -> a where Float[a]
ceil : a -> a where Float[a]
round : a -> a where Float[a]
abs : a -> a where Signed[a]
eq : a -> a -> Bool where Eq[a]
ne : a -> a -> Bool where Eq[a]
lt : a -> a -> Bool where Ord[a]
le : a -> a -> Bool where Ord[a]
gt : a -> a -> Bool where Ord[a]
ge : a -> a -> Bool where Ord[a]
compare : a -> a -> Ordering where Ord[a]
min : a -> a -> a where Ord[a]
max : a -> a -> a where Ord[a]
hash : a -> U64 where Hash[a]
not : Bool -> Bool
and : Bool -> Bool -> Bool
or : Bool -> Bool -> Bool

trait Functor[F] =
    fmap : (a -> b ! e) -> F[a] -> F[b] ! e

trait Applicative[F] : Functor[F] =
    pure : a -> F[a]
    ap : F[a -> b] -> F[a] -> F[b]

trait Monad[M] : Applicative[M] =
    bind : (a -> M[b] ! e) -> M[a] -> M[b] ! e
list.flat-map : (a -> List[b] ! e) -> List[a] -> List[b] ! e
list.ap : List[a -> b] -> List[a] -> List[b]
fail : x -> a ! {Error[x]}
attempt : (a -> b ! {Error[x] | e}) -> a -> Result[b, x] ! e
try : Result[a, x] -> a ! {Error[x]}
or-fail : x -> Option[a] -> a ! {Error[x]}
get : () -> s ! {State[s]}
put : s -> () ! {State[s]}
modify : (s -> s) -> () ! {State[s]}
run-state : s -> (a -> b ! {State[s] | e}) -> a -> (b, s) ! e
random.u64 : () -> U64 ! {Random}
random.f64 : () -> F64 ! {Random}
resource File = builtin
IoError = { kind: String, message: String }
file.open : String -> File ! {FileIO, Error[IoError]}
file.create : String -> File ! {FileIO, Error[IoError]}
file.close : File -> () ! {FileIO}
file.read-all : File -> (String, File) ! {FileIO, Error[IoError]}
file.write : String -> File -> File ! {FileIO, Error[IoError]}
file.with : String -> (File -> (a, File) ! {FileIO, Error[IoError] | e}) -> a ! {FileIO, Error[IoError] | e}
file.read : String -> String ! {FileIO, Error[IoError]}
file.write-new : String -> String -> () ! {FileIO, Error[IoError]}
print : String -> () ! {IO}
show : a -> String where Display[a]
args : () -> List[String] ! {IO}
exit : I32 -> a ! {IO}

# Print any displayable value on its own line: `x | echo`.
echo : a -> () ! {IO} where Display[a]

# Discard a value. Effects in a list or tuple happen left to right, so
# `[print "a", print "b"] | ignore` sequences them.
ignore : a -> ()
```

## Lists

`lib/list.fwp`

Lists. Functions take the list last so they compose with `|`.

```fwp
map : (a -> b ! e) -> List[a] -> List[b] ! e
filter : (a -> Bool ! e) -> List[a] -> List[a] ! e
fold : (b -> a -> b ! e) -> b -> List[a] -> b ! e
fold-right : (a -> b -> b ! e) -> b -> List[a] -> b ! e
sort : List[a] -> List[a] where Ord[a]
sort-by : (a -> k ! e) -> List[a] -> List[a] ! e where Ord[k]
length : List[a] -> I64
reverse : List[a] -> List[a]

# `xs | append ys` is xs followed by ys.
append : List[a] -> List[a] -> List[a]
flatten : List[List[a]] -> List[a]
take : I64 -> List[a] -> List[a]
drop : I64 -> List[a] -> List[a]
take-while : (a -> Bool ! e) -> List[a] -> List[a] ! e
drop-while : (a -> Bool ! e) -> List[a] -> List[a] ! e

# `xs | zip ys` pairs each x with the y at the same position.
zip : List[b] -> List[a] -> List[(a, b)]

# `xs | zip-with f ys` is `f y x` for each pair, the subject's element last
# as everywhere else: `xs | zip-with sub ys` is x - y, like `x | sub y`.
zip-with : (b -> a -> c ! e) -> List[b] -> List[a] -> List[c] ! e
unzip : List[(a, b)] -> (List[a], List[b])

# `range 0 5` is [0, 1, 2, 3, 4].
range : a -> a -> List[a] where Integer[a]
repeat : I64 -> a -> List[a]
nth : I64 -> List[a] -> Option[a]
find : (a -> Bool ! e) -> List[a] -> Option[a] ! e
index-of : a -> List[a] -> Option[I64] where Eq[a]
unique : List[a] -> List[a] where Ord[a]
scan : (b -> a -> b ! e) -> b -> List[a] -> List[b] ! e
chunks : I64 -> List[a] -> List[List[a]]
iterate : I64 -> (a -> a ! e) -> a -> List[a] ! e
head : List[a] -> Option[a]
tail : List[a] -> Option[List[a]]
last : List[a] -> Option[a]
is-empty : List[a] -> Bool
any : (a -> Bool ! e) -> List[a] -> Bool ! e
all : (a -> Bool ! e) -> List[a] -> Bool ! e
count : (a -> Bool ! e) -> List[a] -> I64 ! e
contains : a -> List[a] -> Bool where Eq[a]

# (accepted, rejected), each in the original order; the predicate runs
# once per element
partition : (a -> Bool ! e) -> List[a] -> (List[a], List[a]) ! e where Dup[a]
enumerate : List[a] -> List[(I64, a)] where Dup[a]
each : (a -> () ! e) -> List[a] -> () ! e
filter-map : (a -> Option[b] ! e) -> List[a] -> List[b] ! e
maximum : List[a] -> Option[a] where Ord[a]
minimum : List[a] -> Option[a] where Ord[a]
singleton : a -> List[a]
sum : List[a] -> a where Add[a], Zero[a]
product : List[a] -> a where Mul[a], One[a]
```

## Option and Result

`lib/option.fwp`

Option and Result. Multi-argument pattern functions use `curry` with a
tuple match: the holes of the matched tuple are passed to the arm body in
order.

```fwp
option.map : (a -> b ! e) -> Option[a] -> Option[b] ! e
option.and-then : (a -> Option[b] ! e) -> Option[a] -> Option[b] ! e
option.ap : Option[a -> b] -> Option[a] -> Option[b]
option.unwrap-or : a -> Option[a] -> a
option.or-else : Option[a] -> Option[a] -> Option[a]
option.is-some : Option[a] -> Bool
option.is-none : Option[a] -> Bool
option.to-list : Option[a] -> List[a]
option.filter : (a -> Bool ! e) -> Option[a] -> Option[a] ! e where Dup[a]
result.map : (a -> b ! e) -> Result[a, x] -> Result[b, x] ! e
result.map-err : (x -> y ! e) -> Result[a, x] -> Result[a, y] ! e
result.and-then : (a -> Result[b, x] ! e) -> Result[a, x] -> Result[b, x] ! e
result.unwrap-or : a -> Result[a, x] -> a
result.is-ok : Result[a, x] -> Bool
result.to-option : Result[a, x] -> Option[a]
result.from-option : x -> Option[a] -> Result[a, x]
```

## Strings

`lib/string.fwp`

Strings are immutable UTF-8. Lengths and positions count Unicode scalar
values; case conversion is ASCII-only.

```fwp
trim : String -> String
trim-start : String -> String
trim-end : String -> String
lower : String -> String
upper : String -> String

# `s | concat t` is s followed by t.
concat : String -> String -> String
string.length : String -> I64
string.byte-length : String -> I64
string.chars : String -> List[String]

# `"a,b" | split ","` is ["a", "b"].
split : String -> String -> List[String]

# `["a", "b"] | join ", "` is "a, b".
join : String -> List[String] -> String
lines : String -> List[String]
words : String -> List[String]
string.contains : String -> String -> Bool
starts-with : String -> String -> Bool
ends-with : String -> String -> Bool

# `s | replace "a" "b"` replaces every "a" by "b".
replace : String -> String -> String -> String
string.repeat : I64 -> String -> String
string.reverse : String -> String
string.slice : I64 -> I64 -> String -> String
string.find : String -> String -> Option[I64]

# `s | pad-left n fill` puts copies of the first character of `fill` before
# `s` until it is n characters (Unicode scalar values) long; pad-right puts
# them after. A string already n or more characters long is returned
# unchanged (never truncated), as it is for an empty `fill` or n <= 0.
pad-left : I64 -> String -> String -> String
pad-right : I64 -> String -> String -> String
string.codepoints : String -> List[U32]
string.from-codepoints : List[U32] -> Option[String]
string.to-bytes : String -> Bytes
string.from-bytes : Bytes -> Option[String]
parse-int : String -> Option[a] where Integer[a]

# decimal and exponent notation, plus `nan`, `inf`, `-inf` and `infinity`
# in any case (so `show` output such as "NaN" parses back)
parse-float : String -> Option[a] where Float[a]

# Fill `{}` placeholders with the fields of a tuple or record (or with the
# value itself), displayed as by `show` but with strings unquoted:
# `("x", 2) | format "{} = {}"` is "x = 2". `{{` and `}}` are literal braces.
# The number of placeholders must equal the number of values (the fields,
# or 1 for any other value); a mismatch is a trap.
format : String -> a -> String where Display[a]
string.is-empty : String -> Bool

# the parts before and after the first occurrence of a separator
string.split-once : String -> String -> Option[(String, String)]
```

## Arrays, maps, sets and bytes

`lib/collections.fwp`

Arrays (immutable, indexed), ordered maps and sets, and byte strings.
Updates return new collections. Keys use the structural order (`Ord`).

```fwp
array.from-list : List[a] -> Array[a]
array.to-list : Array[a] -> List[a]
array.length : Array[a] -> I64
array.get : I64 -> Array[a] -> Option[a]
array.set : I64 -> a -> Array[a] -> Option[Array[a]]
array.push : a -> Array[a] -> Array[a]
array.make : I64 -> a -> Array[a]
array.generate : I64 -> (I64 -> a ! e) -> Array[a] ! e
array.map : (a -> b ! e) -> Array[a] -> Array[b] ! e
array.fold : (b -> a -> b ! e) -> b -> Array[a] -> b ! e
array.slice : I64 -> I64 -> Array[a] -> Array[a]
array.append : Array[a] -> Array[a] -> Array[a]
array.sort : Array[a] -> Array[a] where Ord[a]
map.empty : Map[k, v]
map.insert : k -> v -> Map[k, v] -> Map[k, v] where Ord[k]
map.get : k -> Map[k, v] -> Option[v] where Ord[k]
map.remove : k -> Map[k, v] -> Map[k, v] where Ord[k]
map.contains : k -> Map[k, v] -> Bool where Ord[k]
map.size : Map[k, v] -> I64
map.keys : Map[k, v] -> List[k]
map.values : Map[k, v] -> List[v]
map.to-list : Map[k, v] -> List[(k, v)]
map.from-list : List[(k, v)] -> Map[k, v] where Ord[k]

# `m | map.update k f d` applies f to the value at k (or to d if absent).
map.update : k -> (v -> v ! e) -> v -> Map[k, v] -> Map[k, v] ! e where Ord[k]
map.map-values : (v -> w ! e) -> Map[k, v] -> Map[k, w] ! e
set.empty : Set[a]
set.insert : a -> Set[a] -> Set[a] where Ord[a]
set.remove : a -> Set[a] -> Set[a] where Ord[a]
set.contains : a -> Set[a] -> Bool where Ord[a]
set.size : Set[a] -> I64
set.to-list : Set[a] -> List[a]
set.from-list : List[a] -> Set[a] where Ord[a]
set.union : Set[a] -> Set[a] -> Set[a] where Ord[a]
set.intersect : Set[a] -> Set[a] -> Set[a] where Ord[a]
set.diff : Set[a] -> Set[a] -> Set[a] where Ord[a]
bytes.from-list : List[U8] -> Bytes
bytes.to-list : Bytes -> List[U8]
bytes.length : Bytes -> I64
bytes.get : I64 -> Bytes -> Option[U8]
bytes.slice : I64 -> I64 -> Bytes -> Bytes
bytes.append : Bytes -> Bytes -> Bytes

# Count occurrences: `["a", "b", "a"] | frequencies`.
frequencies : List[a] -> Map[a, I64] where Ord[a]

# The elements by key, in their original order:
# `[1, 2, 3, 4] | group-by (rem 2)` is `map {0: [2, 4], 1: [1, 3]}`.
group-by : (a -> k ! e) -> List[a] -> Map[k, List[a]] ! e where Ord[k]

# offset of the first occurrence of a byte sequence
bytes.find : Bytes -> Bytes -> Option[I64]
```

## Iterators

`lib/iter.fwp`

Lazy, pull-based iterators, written in fwp. The tail of a non-empty
iterator is a function that produces the rest on demand, so iterators
can be infinite.

```fwp
Iterator[T] =
    | Done
    | Yield T (() -> Iterator[T])

# `iter.later f x` is a thunk that computes `f x` when forced. (Note that
# `x | f | const` would compute `f x` immediately.)
iter.later : (a -> b ! e) -> a -> () -> b ! e

# `iter.count-from 0` is 0, 1, 2, ...
iter.count-from : a -> Iterator[a] where Add[a], One[a], Dup[a]
iter.from-list : List[a] -> Iterator[a]
iter.to-list : Iterator[a] -> List[a]

# The arms below receive their holes as one tuple via `curry3` and pick
# them apart with selectors: (f, x, rest).
iter.map : (a -> b) -> Iterator[a] -> Iterator[b] where Dup[a]

# Rejected elements are skipped in a `loop`, so long runs of them run in
# constant stack space.
iter.filter : (a -> Bool) -> Iterator[a] -> Iterator[a] where Dup[a]

# `iter.take n` is the first n elements (none when n <= 0). The element
# after the n-th is never forced.
iter.take : I64 -> Iterator[a] -> Iterator[a] where Dup[a]

# `iter.iterate f x` is x, f x, f (f x), ...
iter.iterate : (a -> a) -> a -> Iterator[a] where Dup[a]
```

## Console, environment and time

`lib/io.fwp`

Console, environment and time.

```fwp
write : String -> () ! {IO}
eprint : String -> () ! {IO}

# Write text on stderr without a newline (prompts, progress).
ewrite : String -> () ! {IO}
read-line : () -> Option[String] ! {IO}
read-all : () -> String ! {IO}
read-lines : () -> List[String] ! {IO}
env.get : String -> Option[String] ! {IO}

# All environment variables, sorted by name.
env.vars : () -> List[(String, String)] ! {IO}

# The current working directory.
env.cwd : () -> String ! {IO}
time.monotonic : () -> Duration ! {IO}
time.unix : () -> Duration ! {IO}

# Apply `f` to each line of standard input as it is read, in constant
# memory: `() | each-line (upper | print)`.
each-line : (String -> () ! {IO | e}) -> () -> () ! {IO | e}

# `s | fold-lines f` folds `f` over the lines of standard input as they
# are read, from the state `s`: `0 | fold-lines (curry (.0 | add 1))`
# counts them.
fold-lines : (s -> String -> s ! {IO | e}) -> s -> s ! {IO | e} where Dup[s]

# The user's home directory (`HOME`).
env.home : () -> Option[String] ! {IO}
duration.nanos : Duration -> I64
duration.millis : Duration -> I64
duration.from-millis : I64 -> Duration
```

## Files, directories and paths

`lib/fs.fwp`

Files, directories and paths. Paths are strings with `/` separators;
the `path.*` functions only compute with them and touch no file.
Failures are `IoError`s whose message names the path, as in
`missing.txt: No such file or directory`.

```fwp
FileInfo = { size: I64, modified: Duration, is-dir: Bool }

# Whether a file or directory exists.
file.exists : String -> Bool ! {FileIO}
file.is-dir : String -> Bool ! {FileIO}

# Size, modification time (since the Unix epoch) and kind of a file.
file.info : String -> FileInfo ! {FileIO, Error[IoError]}
file.remove : String -> () ! {FileIO, Error[IoError]}

# `"old.txt" | file.rename "new.txt"` moves a file.
file.rename : String -> String -> () ! {FileIO, Error[IoError]}

# `text | file.append "log.txt"` adds to the end of a file (creating it).
file.append : String -> String -> () ! {FileIO, Error[IoError]}
file.read-bytes : String -> Bytes ! {FileIO, Error[IoError]}
file.write-bytes : String -> Bytes -> () ! {FileIO, Error[IoError]}

# The names in a directory (without `.` and `..`), sorted.
dir.list : String -> List[String] ! {FileIO, Error[IoError]}
dir.create : String -> () ! {FileIO, Error[IoError]}

# Create a directory and its missing parents (`mkdir -p`).
dir.create-all : String -> () ! {FileIO, Error[IoError]}

# Remove an empty directory.
dir.remove : String -> () ! {FileIO, Error[IoError]}

# The lines of a file.
file.read-lines : String -> List[String] ! {FileIO, Error[IoError]}

# `lines | file.write-lines "out.txt"` writes each line and a newline.
file.write-lines : String -> List[String] -> () ! {FileIO, Error[IoError]}

# `"a.txt" | file.copy "b.txt"` copies a file.
file.copy : String -> String -> () ! {FileIO, Error[IoError]}

# Every file below a directory (not the directories), as paths that start
# with it, in name order.
rec dir.walk : String -> List[String] ! {FileIO, Error[IoError]}

# `dir | path.join name` is `dir/name`, or `name` when it is absolute.
path.join : String -> String -> String

# Whether a path starts at the root.
path.is-absolute : String -> Bool

# A path without its trailing slashes (except a lone `/`).
path.strip-slashes : String -> String

# The last component: `"src/main.fwp" | path.basename` is `"main.fwp"`.
path.basename : String -> String

# All but the last component: `"src/main.fwp"` gives `"src"`, `"main.fwp"`
# gives `"."` and `"/etc"` gives `"/"`.
path.dirname : String -> String

# The extension of the last component without the dot (`"txt"` for
# `"notes.txt"`), or `""`. A leading dot (`.profile`) is not one.
path.extension : String -> String

# The last component without its extension.
path.stem : String -> String

# Remove `.` components, empty components and `x/..` pairs:
# `"a/./b/../c/"` is `"a/c"`, `"/../x"` is `"/x"` and `""` is `"."`.
path.normalize : String -> String
```

## Processes

`lib/process.fwp`

Running other programs. A command is a list: the program, found on the
`PATH` like a shell does, and its arguments, passed as they are (there is
no shell, so no quoting, globbing or redirection). Starting a program
that does not exist is an `IoError` (`kind = "spawn"`).

```fwp
# What a finished program wrote, and its exit status (128 plus the signal
# number when a signal ended it).
ProcessOutput = { status: I32, stdout: String, stderr: String }

# `["git", "status", "--short"] | process.run` runs a program with empty
# input and collects its output.
process.run : List[String] -> ProcessOutput ! {Process, Error[IoError]}

# `cmd | process.run-input text` gives the program `text` as its standard
# input.
process.run-input : String -> List[String] -> ProcessOutput ! {Process, Error[IoError]}

# Run a program on the program's own standard input, output and error;
# its exit status.
process.call : List[String] -> I32 ! {Process, Error[IoError]}

# The standard output of a program that must succeed; otherwise an
# `IoError` with its standard error (`kind = "status"`).
process.output : List[String] -> String ! {Process, Error[IoError]}
```

## Command-line programs and terminals

`lib/cli.fwp`

Command-line programs. Exported functions become programs with flags,
help and subcommands without any code (see docs/cli.md); these
functions are for programs with a hand-written `main`, and for output to
terminals.

```fwp
# Parse command-line arguments as executables do: each field of the
# options record is a flag (`--name value`, `--name=value`; a `Bool` field
# is a switch, `--name` or `--no-name`; an `Option` field is optional; a
# `List` field repeatable; a field comment `# -x ...` adds the short flag
# `-x`); other arguments are positional, and `--` ends the flags. Fields
# whose flags are absent keep the value they have in the first argument:
# `args () | cli.parse defaults` is `Ok (options, positional)` or
# `Err message`.
cli.parse : o -> List[String] -> Result[(o, List[String]), String]

# The help lines of the flags of an options record, with the defaults of
# the given value.
cli.help : o -> String

# Report a usage error: `message | cli.usage-error usage` prints the
# message and the usage on stderr and exits with status 2.
cli.usage-error : String -> String -> a ! {IO}

# The result of an exported function that chooses its exit status:
# `output` is written as a result of its type would be (a list one
# element per line, `None` nothing, `Err` as an error...), then the
# program exits with `status` (modulo 256).
Outcome[T] = { output: T, status: I32 }

# `lines | outcome.of (if is-empty (const 1) (const 0))`: the status
# computed from the output.
outcome.of : (a -> I32 ! e) -> a -> Outcome[a] ! e where Dup[a]

# `outcome.exit 3 output`: the output with a fixed status.
outcome.exit : I32 -> a -> Outcome[a]

# Status 1 when the output satisfies the predicate (`grep` finding
# nothing): `outcome.fail-if is-empty`.
outcome.fail-if : (a -> Bool ! e) -> a -> Outcome[a] ! e where Dup[a]

# Whether a standard stream (0 stdin, 1 stdout, 2 stderr) is a terminal.
term.is-tty : I32 -> Bool ! {IO}

# The width of the terminal in columns: `COLUMNS` when it is set to a
# number, else the width of the terminal of stdout, stderr or stdin, else
# 80.
term.width : () -> I64 ! {IO}

# Read a line from standard input without showing it, when it is a
# terminal (a newline is written on stderr after it); `None` at the end
# of the input. WebAssembly targets cannot turn the echo off.
term.read-secret : () -> Option[String] ! {IO}

# Whether to colour standard output: it is a terminal and `NO_COLOR` is
# not set (see no-color.org).
term.color : () -> Bool ! {IO}

# `"error" | term.paint ansi.red` is red when `term.color` holds, and
# plain text otherwise.
term.paint : (String -> String ! {IO | e}) -> String -> String ! {IO | e}

# Text in an ANSI style: `ansi.style "1;31"` is bold red.
ansi.style : String -> String -> String
ansi.bold : String -> String
ansi.dim : String -> String
ansi.underline : String -> String
ansi.red : String -> String
ansi.green : String -> String
ansi.yellow : String -> String
ansi.blue : String -> String
ansi.magenta : String -> String
ansi.cyan : String -> String

# `"Name: " | prompt.line` asks on stderr and reads a line from standard
# input; `None` at the end of the input.
prompt.line : String -> Option[String] ! {IO}

# `"Delete it?" | prompt.confirm` asks `Delete it? [y/N] ` and is `True`
# for an answer that starts with `y` or `Y` (not at the end of the input).
prompt.confirm : String -> Bool ! {IO}

# `"Password: " | prompt.password` asks on stderr and reads a line
# without showing it (see `term.read-secret`).
prompt.password : String -> Option[String] ! {IO}

# `"12 of 40 files" | progress.show` writes a status line on stderr that
# the next one replaces, when stderr is a terminal; nothing otherwise, so
# that logs and pipes stay clean. The line is cut to the terminal's width.
progress.show : String -> () ! {IO}

# Clear the status line of `progress.show` (when stderr is a terminal).
progress.clear : () -> () ! {IO}

# The text `progress.show` writes for a terminal `width` columns wide:
# a carriage return, the line cut to `width - 1` characters and an
# erase-to-end-of-line.
progress.line : I64 -> String -> String

# `(done, total) | progress.bar 20` is `[#####               ]  25%`.
progress.bar : I64 -> (I64, I64) -> String

# Rows of cells as lines of aligned columns, two spaces apart. Widths
# count characters.
table.lines : List[List[String]] -> List[String]

# `table.lines` as one string, each line ending in a newline.
table.format : List[List[String]] -> String

# The width of each column: its longest cell, in characters.
table.widths : List[List[String]] -> List[I64]
```

## CSV

`lib/csv.fwp`

CSV (RFC 4180): records of fields separated by commas (or another
one-byte separator) and lines ending in `\n` or `\r\n`. A field in
double quotes may contain separators, newlines and quotes written `""`.
Reading is lenient: text after a closing quote is part of the field, a
quote that is never closed runs to the end, and empty lines are skipped.

```fwp
# `"a,b\n1,2\n" | csv.parse` is `[["a", "b"], ["1", "2"]]`.
csv.parse : String -> List[List[String]]

# `text | csv.parse-with ";"` reads fields separated by the first byte of
# the separator (`"\t"` for tab-separated values).
csv.parse-with : String -> String -> List[List[String]]

# Records of a record type from rows whose first row is the header: each
# field comes from the column of its name (a header `First Name` or
# `first_name` is the field `first-name`), parsed as a command-line
# argument (strings as they are, numbers, `true`, constructor names of
# enumerations in any case). An `Option` field is `None` when its cell is
# empty or its column missing. A missing column or a cell that does not
# parse is an `Err` with the row number (the header is row 1).
csv.decode : List[List[String]] -> Result[List[t], String] where Decode[t]

# `file.read "people.csv" | csv.parse-records` with a type annotation:
# `csv.parse` then `csv.decode`.
csv.parse-records : String -> Result[List[t], String] where Decode[t]

# Rows as CSV text: every line ends with `\n`, and a field is quoted when
# it contains a comma, a quote or a line break.
csv.encode : List[List[String]] -> String

# `rows | csv.encode-with "\t"`.
csv.encode-with : String -> List[List[String]] -> String

# One field, quoted when it needs to be: `"a,b" | csv.field ","` is
# `"\"a,b\""`.
csv.field : String -> String -> String

# One record without its newline: `["a", "b c"] | csv.format-row ";"`.
csv.format-row : String -> List[String] -> String
```

## Tasks and channels

`lib/task.fwp`

Structured concurrency: tasks, channels, cancellation and deadlines.

Tasks form a tree: a task finishes only after its children finished, and
cancelling a task cancels its subtree. Cancellation is observed when a
task suspends (sleeping, waiting on a channel, another task or a socket)
and unwinds it; `attempt` does not catch it. A deadline cancels its task
when it passes. In the native runtime tasks are green threads on an
event loop; the interpreter runs each task on a thread, one at a time. On
WebAssembly they are fibers, which need JavaScript Promise Integration.

```fwp
Task[a] = builtin
Channel[a] = builtin

# start a task; it may perform IO but must handle its own errors
task.spawn : (() -> a ! {Async, IO, Network, FileIO}) -> Task[a] ! {Async}

# wait for a task: `None` if it was cancelled
task.await : Task[a] -> Option[a] ! {Async}
task.cancel : Task[a] -> () ! {Async}

# run a task with a deadline and wait for it
task.within : Duration -> (() -> a ! {Async, IO, Network, FileIO}) -> Option[a] ! {Async}
task.sleep : Duration -> () ! {Async}
task.yield : () -> () ! {Async}

# set (or tighten) the current task's deadline, passing a value through
task.deadline : Duration -> a -> a ! {Async}
task.cancelled : () -> Bool ! {Async}

# run a function and wait for every task it started; when it fails, those
# tasks are cancelled
task.scope : (() -> a ! {Async | e}) -> a ! {Async | e}

# bounded FIFO channels: `send` waits while the channel is full, which
# propagates backpressure; `recv` gives `None` once closed and drained
channel.make : I64 -> Channel[a] ! {Async}
channel.send : Channel[a] -> a -> Bool ! {Async}
channel.recv : Channel[a] -> Option[a] ! {Async}
channel.recv-for : Duration -> Channel[a] -> Option[a] ! {Async}
channel.close : Channel[a] -> () ! {Async}

# every value received from a channel until it is closed and drained
channel.drain : Channel[a] -> List[a] ! {Async}

# run tasks for every element and collect their results in order
task.map : (a -> b ! {Async, IO, Network, FileIO}) -> List[a] -> List[Option[b]] ! {Async}
spawn-with : (a -> b ! {Async, IO, Network, FileIO}) -> a -> Task[b] ! {Async}
```

## Networking

`lib/net.fwp`

Networking: TCP, UDP and DNS. Socket operations suspend only the calling
task. Addresses are "host:port" strings.

```fwp
Listener = builtin
Conn = builtin
UdpSocket = builtin
tcp.listen : String -> Listener ! {Network, Error[IoError]}
tcp.local-addr : Listener -> String ! {Network}
tcp.accept : Listener -> Conn ! {Async, Network, Error[IoError]}
tcp.accept-for : Duration -> Listener -> Option[Conn] ! {Async, Network, Error[IoError]}

# stop listening
tcp.stop : Listener -> () ! {Network}
tcp.connect : String -> Conn ! {Async, Network, Error[IoError]}

# read up to n bytes; empty at end of stream
tcp.read : I64 -> Conn -> Bytes ! {Async, Network, Error[IoError]}
tcp.read-for : Duration -> I64 -> Conn -> Option[Bytes] ! {Async, Network, Error[IoError]}
tcp.write : Bytes -> Conn -> () ! {Async, Network, Error[IoError]}

# write, failing with a "timeout" error if that takes longer than the
# duration (part of the data may have been sent)
tcp.write-for : Duration -> Bytes -> Conn -> () ! {Async, Network, Error[IoError]}
tcp.close : Conn -> () ! {Network}
tcp.peer-addr : Conn -> String ! {Network}
udp.bind : String -> UdpSocket ! {Network, Error[IoError]}
udp.local-addr : UdpSocket -> String ! {Network}
udp.send-to : String -> Bytes -> UdpSocket -> () ! {Async, Network, Error[IoError]}
udp.recv-from : I64 -> UdpSocket -> (Bytes, String) ! {Async, Network, Error[IoError]}
udp.close : UdpSocket -> () ! {Network}

# addresses of a host name
dns.resolve : String -> List[String] ! {Network, Error[IoError]}

# SIGINT/SIGTERM arrived (or `signal.request-shutdown` was called); the
# first call installs the signal handlers
signal.shutdown-requested : () -> Bool ! {Async}
signal.request-shutdown : () -> () ! {Async}
```

## TLS

`lib/tls.fwp`

TLS: encrypted, authenticated connections, with the system's OpenSSL 3
(see docs/tls.md). A TLS connection is a `Conn` like a TCP connection:
`tcp.read`, `tcp.write`, `tcp.close` and the rest work on it, encrypting
and decrypting, so code written for TCP connections (the HTTP server and
client among it) works over TLS unchanged; the `tls.*` names below are
the same functions. A connection's handshake happens when it is opened
(`tls.connect`), or on its first read or write (`tls.accept`), in the
task that uses it: a slow handshake holds up no other task. Failures are
`IoError`s of kind "tls" (`certificate verify failed: hostname
mismatch`, ...).

```fwp
# How a client connects. The server's certificate is verified unless
# `insecure`: against the system's CA certificates (`SSL_CERT_FILE` and
# `SSL_CERT_DIR` override them) or those in `ca-file` (PEM), and it must be
# for `server-name`, by default the host of the address (sent with SNI
# unless it is an IP address). `alpn`: the protocols to offer
# (`tls.alpn` tells the one chosen). `cert-file` and `key-file`: a client
# certificate chain and its private key (PEM), for servers that require
# one (mutual TLS); the key may be in the certificate's file.
TlsOptions = {
    ca-file: Option[String],
    insecure: Bool,
    server-name: Option[String],
    alpn: List[String],
    cert-file: Option[String],
    key-file: Option[String],
}

# A server's certificate chain and private key (PEM files), the protocols
# it accepts (ALPN), in its order of preference, and the CA certificates
# (PEM) of the client certificates it requires (mutual TLS; `None`: it
# does not ask clients for certificates).
TlsServer = {
    cert-file: String,
    key-file: String,
    alpn: List[String],
    client-ca: Option[String],
}

# finish the handshake now (for an accepted connection: its handshake
# otherwise happens on its first read or write); nothing for a plain
# connection
tls.handshake : Conn -> () ! {Async, Network, Error[IoError]}

# the protocol chosen with ALPN ("" for none)
tls.alpn : Conn -> String ! {Network}

# a TLS connection (not a plain TCP one)
tls.secure : Conn -> Bool ! {Network}

# the subject of the certificate the peer presented
# (`CN=alice,O=Example`, as RFC 2253 writes names), after the handshake:
# the client's for a server that requires client certificates, the
# server's for a client; `None` for a plain connection
tls.peer-subject : Conn -> Option[String] ! {Network}

# OpenSSL can be used (the interpreter loads it when a program first uses
# TLS; native programs that use TLS are linked with it)
tls.available : () -> Bool ! {Network}

# The same functions as `tcp.*`.
tls.accept : Listener -> Conn ! {Async, Network, Error[IoError]} = "tcp.accept"
tls.accept-for : Duration -> Listener -> Option[Conn] ! {Async, Network, Error[IoError]} = "tcp.accept-for"
tls.local-addr : Listener -> String ! {Network} = "tcp.local-addr"
tls.stop : Listener -> () ! {Network} = "tcp.stop"
tls.read : I64 -> Conn -> Bytes ! {Async, Network, Error[IoError]} = "tcp.read"
tls.read-for : Duration -> I64 -> Conn -> Option[Bytes] ! {Async, Network, Error[IoError]} = "tcp.read-for"
tls.write : Bytes -> Conn -> () ! {Async, Network, Error[IoError]} = "tcp.write"
tls.write-for : Duration -> Bytes -> Conn -> () ! {Async, Network, Error[IoError]} = "tcp.write-for"
tls.close : Conn -> () ! {Network} = "tcp.close"
tls.peer-addr : Conn -> String ! {Network} = "tcp.peer-addr"

# verify with the system's CA certificates; no protocols
tls.options : TlsOptions

# trust the CA certificates of a PEM file
tls.with-ca : String -> TlsOptions -> TlsOptions

# present a client certificate chain and its private key (PEM files):
# `tls.options | tls.with-cert "client.pem" "client.key"`
tls.with-cert : String -> String -> TlsOptions -> TlsOptions

# a server with a certificate chain and key (PEM files), without protocols
tls.server : String -> String -> TlsServer

# require client certificates signed by the CA certificates of a PEM file
# (mutual TLS): a client without one fails its handshake
tls.with-client-ca : String -> TlsServer -> TlsServer

# connect to "host:port" and finish the handshake
tls.connect : String -> Conn ! {Async, Network, Error[IoError]}
tls.connect-with : TlsOptions -> String -> Conn ! {Async, Network, Error[IoError]}

# listen on "host:port"; connections accepted from it are TLS connections
tls.listen : TlsServer -> String -> Listener ! {Network, Error[IoError]}
```

## HTTP

`lib/http.fwp`

HTTP/1.1 and HTTP/2 server and client.

A handler is an ordinary function `Request -> Response`, and middleware is
ordinary composition:

    handler = timeout 2s | auth.bearer token | service | json.response

The server runs every connection in its own task. It bounds the number of
connections (accepting waits while all slots are taken), the size of
request heads and bodies and the requests per connection; it applies idle,
header, body, write and per-request timeouts; and on SIGINT/SIGTERM it
stops accepting, lets in-flight requests finish within a grace period,
then cancels the rest.

With `tls` in its config the server speaks HTTPS, and the client speaks
HTTPS to `https://` URLs (lib/tls.fwp): the same code runs over TLS
connections, which are `Conn`s too.

The server also speaks HTTP/2: over TLS when the client chooses "h2"
with ALPN, and on cleartext connections that start with HTTP/2's
connection preface (h2c with prior knowledge). Every stream runs in its
own task, with the same handler, limits and timeouts. The client uses
HTTP/2 when a TLS server chooses it, pooling one connection per origin.
Responses can be compressed (`compress` in the config, or the
`http.compress` middleware), request bodies with a content encoding
are decompressed, and the client decompresses responses.

```fwp
Request = {
    method: String,
    path: String,
    query: String,
    version: String,
    headers: List[(String, String)],
    body: Bytes,
    params: List[(String, String)],
    remote: String,
}

# a response body: complete, or streamed with chunked transfer encoding. A
# streaming body is produced by a function that the server runs in its own
# task, sending chunks into a bounded channel (which gives backpressure);
# `channel.send` returns False once the client has gone away.
#
# `Body.Upgrade f` (with status 101) switches the connection to another
# protocol: after the response head, the server runs `f` with the
# connection and the bytes it already read past the request, then closes
# the connection (WebSocket is built on it: lib/websocket.fwp).
Body =
    | Body.Full Bytes
    | Body.Stream (Channel[Bytes] -> () ! {Async, IO, Network, FileIO})
    | Body.Upgrade (Conn -> Bytes -> () ! {Async, IO, Network, FileIO})
Response = { status: I64, headers: List[(String, String)], body: Body }
HttpError = { status: I64, message: String }

ServerConfig = {
    addr: String,
    max-connections: I64,
    max-header-bytes: I64,
    max-body-bytes: I64,
    max-requests-per-connection: I64,
    idle-timeout: Duration,
    header-timeout: Duration,
    body-timeout: Duration,
    write-timeout: Duration,
    request-timeout: Duration,
    shutdown-grace: Duration,
    tls: Option[TlsServer],
    # serve HTTP/2 too (h2 with ALPN over TLS, h2c with prior knowledge)
    http2: Bool,
    # compress responses of at least this many bytes with gzip (or
    # deflate) for clients that accept it (`Accept-Encoding`)
    compress: Option[I64],
    # the response to an error the server answers itself (a malformed
    # request, a body too large, a request timeout): its status and
    # message; `http.text` by default (REST servers answer JSON)
    error-response: I64 -> String -> Response,
}
http.config : String -> ServerConfig

# a response with a status, a content type and a body
http.respond : I64 -> String -> Bytes -> Response
http.text : I64 -> String -> Response
http.json : I64 -> Json -> Response
json.response : Json -> Response
http.stream : I64 -> String -> (Channel[Bytes] -> () ! {Async, IO, Network, FileIO}) -> Response

# add a header
http.with-header : String -> String -> Response -> Response

# abort the handler with an error response
http.fail : I64 -> String -> a ! {Error[HttpError]}
http.reason : I64 -> String

# a request header (names are case-insensitive)
http.header : String -> Request -> Option[String]
http.query-param : String -> Request -> Option[String]

# a path parameter bound by the router (`/users/:id`)
http.param : String -> Request -> Option[String]

# the subject of the client's certificate (`CN=alice,O=Example`), when the
# server requires client certificates (mutual TLS: `client-ca` in its
# `TlsServer`), which it has then verified
http.peer-subject : Request -> Option[String]
http.body-text : Request -> String
http.form : Request -> List[(String, String)]

# the cookies of a request (`Cookie: a=1; b=2`), as name and value pairs
# (a value in double quotes without them)
http.cookies : Request -> List[(String, String)]

# a cookie of a request
http.cookie : String -> Request -> Option[String]

# the body as JSON; 400 if it is not
http.json-body : Request -> Json ! {Error[HttpError]}

# give the rest of the request this long (the handler is cancelled and the
# client gets 503 when it passes)
timeout : Duration -> a -> a ! {Async}

# require `Authorization: Bearer <token>`
auth.bearer : String -> Request -> Request ! {Error[HttpError]}

# count requests by method in the `http_requests_total` metric
http.count : Request -> Request ! {IO}

Route = {
    method: String,
    pattern: List[String],
    handler: Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]},
}

# `http.route "GET" "/users/:id" handler`; method "*" matches any method
http.route : String -> String -> (Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}) -> Route

# dispatch to the first matching route; 404 or 405 otherwise
http.router : List[Route] -> Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}

# Listen on `addr` and serve until a shutdown signal; HTTPS with `tls`
# (`http.config addr | with { tls = Some (tls.server "cert.pem" "key.pem") }`).
http.serve : ServerConfig -> (Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}) -> () ! {Async, IO, Network, Error[IoError]}

# listen on a config's address, with TLS if it has `tls`
http.listen : ServerConfig -> Listener ! {Network, Error[IoError]}

# Serve on a listener (for example one bound to port 0; a listener from
# `tls.listen` serves HTTPS).
http.serve-on : Listener -> (ServerConfig, Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}) -> () ! {Async, IO, Network}

# gzip (RFC 1952) and the zlib format of HTTP's `deflate` content coding
# (RFC 1950), written from scratch; `-max` decompression gives up past
# that many bytes (a guard against decompression bombs)
gzip.compress : Bytes -> Bytes = "zlib.gzip"
gzip.decompress-max : I64 -> Bytes -> Result[Bytes, String] = "zlib.gunzip"
deflate.compress : Bytes -> Bytes = "zlib.deflate"

# the zlib format, or raw DEFLATE (which some servers send)
deflate.decompress-max : I64 -> Bytes -> Result[Bytes, String] = "zlib.inflate"

# decompress up to 64 MiB
gzip.decompress : Bytes -> Result[Bytes, String]
deflate.decompress : Bytes -> Result[Bytes, String]

# compress a handler's responses whose bodies have at least `min` bytes,
# with gzip or deflate, for clients that accept it (`Accept-Encoding`);
# streamed bodies, responses with a content encoding of their own and
# already compressed types (images, video, audio, archives) are left as
# they are
http.compress : I64 -> (Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}) -> Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}

ClientRequest = {
    method: String,
    url: String,
    headers: List[(String, String)],
    body: Bytes,
}
ClientResponse = { status: I64, headers: List[(String, String)], body: Bytes }
http.get : String -> ClientResponse ! {Async, Network, Error[IoError]}
http.post : String -> Bytes -> ClientResponse ! {Async, Network, Error[IoError]}

# How the client speaks HTTP: `Auto` uses HTTP/2 when a TLS server
# chooses it with ALPN (and HTTP/1.1 otherwise), `Http1` always HTTP/1.1,
# and `Http2` always HTTP/2 (on cleartext connections with prior
# knowledge: h2c).
HttpVersion =
    | HttpVersion.Auto
    | HttpVersion.Http1
    | HttpVersion.Http2

# The client's options: TLS for `https://` URLs, the HTTP version, and
# compression (the client sends `accept-encoding: gzip, deflate`, unless
# the request has an `accept-encoding` of its own, and decompresses
# responses with a `content-encoding` of gzip or deflate).
ClientOptions = { tls: TlsOptions, version: HttpVersion, compression: Bool }

# verify certificates with the system's CA certificates, HTTP/2 when the
# server chooses it, compression
http.client : ClientOptions

# send a request and read the whole response. `https://` URLs are fetched
# over TLS, verifying the server's certificate with the system's CA
# certificates; HTTP/2 connections (which TLS servers may choose) are kept
# and reused for later requests to the same origin, HTTP/1.1 ones are not
http.send : ClientRequest -> ClientResponse ! {Async, Network, Error[IoError]}

# send a request, with these TLS options for `https://` URLs (for example
# `tls.options | tls.with-ca "ca.pem"`)
http.send-with : TlsOptions -> ClientRequest -> ClientResponse ! {Async, Network, Error[IoError]}

# send a request with these options
# (`http.client | with { version = HttpVersion.Http2 }`)
http.send-using : ClientOptions -> ClientRequest -> ClientResponse ! {Async, Network, Error[IoError]}
```

## WebSocket

`lib/websocket.fwp`

WebSocket (RFC 6455): servers upgrade HTTP/1.1 requests
(`http.websocket`), and clients connect to `ws://` and `wss://` URLs
(`ws.connect`).

A session is a pair of channels. Messages from the peer arrive on
`incoming`, which ends with a `WsMessage.Close` (the peer's code and
reason, or the code of the failure that ended the session) and is then
closed; messages sent on `outgoing` go to the peer. Closing `outgoing`
(`ws.close`), or sending a `WsMessage.Close`, starts the closing
handshake, which the peer has `close-timeout` to finish. Pings are
answered with pongs, fragmented messages are reassembled, a client masks
its frames, and a message larger than `max-message-bytes` ends the
session with the code 1009 (1002 for frames that break the protocol,
1007 for text that is not UTF-8).

```fwp
WsMessage =
    | WsMessage.Text String
    | WsMessage.Binary Bytes
    | WsMessage.Ping Bytes
    | WsMessage.Pong Bytes
    | WsMessage.Close I64 String

# `done` finishes when the session is over and its connection closed
WebSocket = {
    incoming: Channel[WsMessage],
    outgoing: Channel[WsMessage],
    done: Task[()],
}

# the largest message, the time the peer has to answer a close, and the
# capacity of each channel
WsConfig = { max-message-bytes: I64, close-timeout: Duration, queue: I64 }
ws.config : WsConfig

# send a message; `False` once the session is closing
ws.send : WsMessage -> WebSocket -> Bool ! {Async}
ws.send-text : String -> WebSocket -> Bool ! {Async}

# the next message; `None` once the session is over
ws.recv : WebSocket -> Option[WsMessage] ! {Async}

# close the session (code 1000)
ws.close : WebSocket -> () ! {Async}

# close the session with a code and a reason
ws.close-with : I64 -> String -> WebSocket -> () ! {Async}

# wait until the session is over
ws.wait : WebSocket -> () ! {Async}

# a handler that upgrades a request to a WebSocket session and runs `f`
# with it (in the connection's task); when `f` returns, the session is
# closed. Requests that are not upgrades get 400 (426 for another
# WebSocket version).
http.websocket : (WebSocket -> () ! {Async, IO, Network, FileIO}) -> Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}
http.websocket-with : WsConfig -> (WebSocket -> () ! {Async, IO, Network, FileIO}) -> Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}

# connect to a `ws://` or `wss://` URL
ws.connect : String -> WebSocket ! {Async, Network, Error[IoError]}

# connect with a config, and TLS options for `wss://` URLs
ws.connect-with : WsConfig -> TlsOptions -> String -> WebSocket ! {Async, Network, Error[IoError]}
```

## JSON

`lib/json.fwp`

JSON values. `null` is the explicit variant `Json.Null`, not a language
null.

```fwp
Json =
    | Json.Null
    | Json.Bool Bool
    | Json.Num F64
    | Json.Str String
    | Json.Arr List[Json]
    | Json.Obj List[(String, Json)]

# parse JSON text; errors name the byte offset
json.parse : String -> Result[Json, String]

# compact JSON text; integral numbers below 1e15 have no fraction
json.encode : Json -> String

# The JSON text of any value whose type can be encoded: records are
# objects, lists arrays, `Option` fields are left out when `None`, enums
# are strings and other variants `{"type": "Circle", "value": ...}`.
# Integers are written exactly; `I128` and `U128` as strings, `Bytes` in
# base64 and `Duration` as `"1500ms"`. See docs/rest.md for the mapping.
json.write : a -> String where Encode[a]

# A value of the expected type from JSON text. Errors give the JSON path
# of the offending value: `$.items[2].price: expected a number, got "x"`.
# Integers, floats and `Bool` may also be strings (`"42"`).
json.read : String -> Result[a, String] where Decode[a]

# `json.write` as a `Json` value (numbers become `F64`)
json.encode-value : a -> Json where Encode[a]

# a typed value from a `Json` value (see `json.read`)
json.decode : Json -> Result[a, String] where Decode[a]

# the value of the first pair with the given key
json.lookup : String -> List[(String, a)] -> Option[a]

# field of an object
json.get : String -> Json -> Option[Json]

# element of an array
json.at : I64 -> Json -> Option[Json]
json.as-string : Json -> Option[String]
json.as-number : Json -> Option[F64]
json.as-bool : Json -> Option[Bool]
json.as-array : Json -> Option[List[Json]]
json.as-object : Json -> Option[List[(String, Json)]]
json.int : I64 -> Json
json.object : List[(String, Json)] -> Json
json.strings : List[String] -> Json
```

## REST endpoints and clients

`lib/rest.fwp`

REST endpoints from functions. `fwp build --rest` and `fwp serve --rest`
serve every exported function of a file as an HTTP endpoint with a JSON
contract and an OpenAPI document (see docs/rest.md); the program they
generate is made of these functions, which hand-written servers can use
too:

    rest.main openapi-text [rest.endpoint route function, ...]

A request's path parameters, query parameters and body become the
function's arguments, decoded with `json.read` (a decoding error is a
400 naming the parameter: `query.limit: expected an integer, got "x"`).
The result is written with `json.write`; a `None` result is a 404, and
an `Err` result or an `Error` the function raises is an error response
`{"error": ...}` whose status comes from the route.

```fwp
# Where an argument of an endpoint comes from: a path parameter, a query
# parameter (required or not), every value of a repeated query parameter,
# the fields of an options record from the query (with the kind of each:
# 0 a value, 1 optional, 2 repeated, 3 a switch), the body (`True` if it
# may be absent), nothing (a `()` parameter), a request header (required
# or not), every line of a repeated header, a cookie (required or not),
# the whole `Request`, the principal that authentication found
# (`rest.secured`), the fields of an options record from the query,
# headers and cookies, or a body of the media types it accepts ("json",
# "form", "multipart"), with `True` if it may be absent and the fields of
# its record as a form.
RestSource =
    | RestSource.Path String
    | RestSource.Query String Bool
    | RestSource.Queries String
    | RestSource.Fields List[(String, I64)]
    | RestSource.Body Bool
    | RestSource.Unit
    | RestSource.Header String Bool
    | RestSource.Headers String
    | RestSource.Cookie String Bool
    | RestSource.Request
    | RestSource.Principal
    | RestSource.Options List[RestField]
    | RestSource.Content Bool List[String] List[RestFormField]

# A field of an options record: its JSON name, its kind (0 a value, 1
# optional, 2 repeated, 3 a switch) and where it is read.
RestField = { name: String, kind: I64, place: RestPlace }

# A field of a body read from a form (`application/x-www-form-urlencoded`
# or `multipart/form-data`): its JSON name, its kind (0 a value, 1
# optional, 2 repeated, 3 a switch) and what its parts are (0 text, 1
# `Bytes`, 2 an `Upload`).
RestFormField = { name: String, kind: I64, part: I64 }

# A file sent in a form (`multipart/form-data`): its file name, its media
# type and its content. A field of this type in the body of an endpoint
# that accepts forms (`# accepts: multipart`) takes a file part; in JSON
# it is an object whose `bytes` are base64.
Upload = { filename: String, content-type: String, bytes: Bytes }

# A part of a `multipart/form-data` body: the name of its field, its file
# name (for a file), its media type (`text/plain` by default) and its
# content.
RestPart = {
    name: String,
    filename: Option[String],
    content-type: String,
    bytes: Bytes,
}

# Where a field of an options record is read: the query parameter of its
# name, a request header, or a cookie.
RestPlace =
    | RestPlace.Query
    | RestPlace.Header String
    | RestPlace.Cookie String

# A security scheme: `Authorization: Bearer <token>`, an API key in a
# place ("header", "query" or "cookie") under a name, or the subject of
# the client's certificate (mutual TLS, `http.peer-subject`).
RestAuth =
    | RestAuth.Bearer
    | RestAuth.ApiKey String String
    | RestAuth.ClientCert

# Cross-origin requests (CORS): the origins allowed (`*` for any; none
# allows no cross-origin request), the methods and request headers they
# may use, the response headers they may read, and how long (in seconds)
# browsers may keep the answer to a preflight request.
RestCors = {
    origins: List[String],
    methods: List[String],
    headers: List[String],
    expose: List[String],
    max-age: I64,
}

# A REST server: the OpenAPI document (served at `/openapi.json`), an HTML
# page that presents it (served at `/docs` unless empty), the routes, and
# what cross-origin requests it allows.
RestApi = { openapi: String, docs: String, routes: List[Route], cors: RestCors }

# A response of the endpoint's choosing: its status, headers to add, and
# the body (no body for `()`). An endpoint whose function returns a
# `RestReply[T]` sets them per call (`rest.reply 201 item | rest.with-header
# "location" "/items/7"`); its `# status:` line lists the statuses it may
# answer with.
RestReply[T] = { status: I64, headers: List[(String, String)], body: T }

# An endpoint: its method and path (`/items/{id}`), the sources of the
# function's arguments in order, the status of a success, and the status
# of an error: by variant name, else the error's own `status` field, else
# `error-status`.
RestRoute = {
    method: String,
    path: String,
    sources: List[RestSource],
    status: I64,
    error-status: I64,
    errors: List[(String, I64)],
}

# A route of `http.router` that calls a function with the arguments of a
# request and responds with its result as JSON.
rest.endpoint : RestRoute -> (a -> b ! {Async, IO, Network, FileIO, Error[e]}) -> Route where Decode[a], Encode[b], Encode[e]

# `rest.endpoint` for a function returning `Option`: `None` is a 404.
rest.endpoint-option : RestRoute -> (a -> Option[b] ! {Async, IO, Network, FileIO, Error[e]}) -> Route where Decode[a], Encode[b], Encode[e]

# `rest.endpoint` for a function returning `Result`: `Err` is an error
# response, like a raised `Error`.
rest.endpoint-result : RestRoute -> (a -> Result[b, x] ! {Async, IO, Network, FileIO, Error[e]}) -> Route where Decode[a], Encode[b], Encode[x], Encode[e]

# `rest.endpoint` for a function returning `RestReply`: its status and
# headers, and its body as JSON.
rest.endpoint-reply : RestRoute -> (a -> RestReply[b] ! {Async, IO, Network, FileIO, Error[e]}) -> Route where Decode[a], Encode[b], Encode[e]

# `rest.endpoint-reply` for a `RestReply[()]`: no body.
rest.endpoint-reply-empty : RestRoute -> (a -> RestReply[()] ! {Async, IO, Network, FileIO, Error[e]}) -> Route where Decode[a], Encode[e]

# The media type of a request's body, in lower case and without its
# parameters (`multipart/form-data`); "" without a `Content-Type`.
rest.media-type : Request -> String

# The parts of a `multipart/form-data` body with a boundary
# (`rest.header-param "boundary"` of its `Content-Type`); `None` when
# there is no part.
rest.multipart-parts : String -> Bytes -> Option[List[RestPart]]

# A parameter of a header value: `rest.header-param "boundary"
# "multipart/form-data; boundary=\"x\""` is `Some "x"`.
rest.header-param : String -> String -> Option[String]

# The file of a part.
rest.upload-of : RestPart -> Upload

# 200 (or the route's status) with the JSON of a value; 204 has no body
rest.success : RestRoute -> b -> Response where Encode[b]

# headers added to a response
rest.add-headers : List[(String, String)] -> Response -> Response

# `rest.reply 201 item`: a reply with a status, the value as its body and
# no headers
rest.reply : I64 -> b -> RestReply[b]

# add a header to a reply: `rest.with-header "location" "/items/7"`
rest.with-header : String -> String -> RestReply[b] -> RestReply[b]

# a response with a status and a JSON text
rest.json-text : I64 -> String -> Response

# An error value as a response: `{"error": <the error as JSON>}`.
rest.failure : RestRoute -> e -> Response where Encode[e]

# `rest.endpoint` for an endpoint that writes its result in several media
# types (`# produces:`): each format is a media type and how a value is
# written in it (`("text/plain; charset=utf-8", show)`); the one the
# request's `Accept` header prefers is used (the first one without it),
# and a request that accepts none of them gets a 406. Errors stay JSON.
rest.endpoint-as : List[(String, b -> String)] -> RestRoute -> (a -> b ! {Async, IO, Network, FileIO, Error[e]}) -> Route where Decode[a], Encode[e]

# `rest.endpoint-as` for a function returning `Option`: `None` is a 404.
rest.endpoint-option-as : List[(String, b -> String)] -> RestRoute -> (a -> Option[b] ! {Async, IO, Network, FileIO, Error[e]}) -> Route where Decode[a], Encode[e]

# `rest.endpoint-as` for a function returning `Result`: `Err` is an error
# response.
rest.endpoint-result-as : List[(String, b -> String)] -> RestRoute -> (a -> Result[b, x] ! {Async, IO, Network, FileIO, Error[e]}) -> Route where Decode[a], Encode[x], Encode[e]

# `rest.endpoint-as` for a function returning `RestReply`.
rest.endpoint-reply-as : List[(String, b -> String)] -> RestRoute -> (a -> RestReply[b] ! {Async, IO, Network, FileIO, Error[e]}) -> Route where Decode[a], Encode[e]

# A route that answers 406 to requests whose `Accept` header accepts none
# of the media types, before calling its handler.
rest.negotiated : List[String] -> Route -> Route

# The media type of those offered (in the order of the server's
# preference) that an `Accept` header prefers: the one of the highest
# quality, the first one without the header, and none when it accepts
# none of them (`q=0` refuses one).
rest.choose : List[String] -> Option[String] -> Option[String]

# The media ranges of an `Accept` header and their qualities:
# `"text/*;q=0.5, application/json"` is
# `[("text/*", 0.5), ("application/json", 1.0)]`.
rest.accept-ranges : String -> List[(String, F64)]

# a response with a status, a media type and a text
rest.media-text : I64 -> String -> String -> Response

# Records as CSV (`text/csv`): a header of the columns (JSON names of the
# fields), then a row per record, with each value as in a query string and
# an absent one empty.
rest.csv : List[String] -> List[r] -> String where Encode[r]

# Require credentials for a route: the first credential of the schemes
# that the request carries is passed to `verify`, whose `Ok` value is the
# principal of the call (the parameter `RestSource.Principal`). A request
# without credentials, or whose credential `verify` refuses, gets 401
# `{"error": ...}` (with `WWW-Authenticate: Bearer` for bearer tokens).
rest.secured : (String -> Result[p, String] ! {Async, IO, Network, FileIO, Error[HttpError]}) -> List[RestAuth] -> Route -> Route where Encode[p]

# the first credential of the schemes that a request carries
rest.credential : List[RestAuth] -> Request -> Option[String]

# the token of `Authorization: Bearer <token>`
rest.bearer-token : Request -> Option[String]

# Give a route's calls a time limit: a call still running then is
# cancelled, and the client gets 503 `{"error": "request timed out"}`.
rest.within : Duration -> Route -> Route

# Answer cross-origin requests: a preflight request (`OPTIONS` with
# `Access-Control-Request-Method`) from an allowed origin gets 204 with
# the methods, headers and lifetime of the policy; other requests from an
# allowed origin get `Access-Control-Allow-Origin` (and
# `Access-Control-Allow-Credentials` unless any origin is allowed) on
# their response. Requests from other origins are served as they are, and
# browsers keep their responses from the page that made them.
rest.cors : RestCors -> (Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}) -> Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}

# the origin of a request, if the policy allows it
rest.allowed-origin : RestCors -> Option[String] -> Option[String]

# no cross-origin requests
rest.no-cors : RestCors

# Serve endpoints, and the OpenAPI document at `/openapi.json`, with JSON
# error responses (`{"error": "not found"}` for unknown paths): `rest.serve`
# with no `/docs` page and no cross-origin requests.
rest.main : String -> List[Route] -> () ! {Async, IO, Network}

# Serve a REST API: its routes, `/openapi.json`, `/docs`, and CORS, with
# JSON error responses (`{"error": "not found"}` for unknown paths, and
# for the server's own errors, such as timeouts). The command line is
# `[--listen host:port] [--tls-cert file --tls-key file [--tls-client-ca
# file]] [--cors origins]
# [--openapi] [--help]`; the address defaults to `FWP_REST_ADDR`, else
# `127.0.0.1:8080`, the certificate and key (PEM files, for HTTPS) to
# `FWP_TLS_CERT` and `FWP_TLS_KEY`, and the allowed origins (separated by
# commas; they replace the API's) to `FWP_REST_CORS`.
rest.serve : RestApi -> () ! {Async, IO, Network}

# an error the server answers itself, as JSON
rest.error-response : I64 -> String -> Response

# The handler of an API: its routes, `/openapi.json` and `/docs`, with
# errors as JSON and its CORS policy.
rest.api-handler : RestApi -> Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}

# The handler of a server: the endpoints and `/openapi.json`, with errors
# (unknown routes, bad arguments) as JSON.
rest.handler-of : (String, List[Route]) -> Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}

# a response, or the JSON of an `HttpError`
rest.respond : Result[Response, HttpError] -> Response

# A call of a REST API, as the client functions that
# `fwp openapi --import` generates make them: the method, the URL, headers
# (besides `Accept: application/json`, and `Content-Type:
# application/json` unless they have one) and the body.
RestRequest = {
    method: String,
    url: String,
    headers: List[(String, String)],
    body: Option[String],
}

# The URL of a call: the base URL of the server, the path template
# (`/items/{id}`), the text of the path parameters in order, and the query
# parameters.
RestTarget = {
    base: String,
    path: String,
    params: List[String],
    query: List[(String, String)],
}

# A call that failed: the status of the response (0 if there was none)
# and its body, or what went wrong.
RestError = { status: I64, message: String }

# the URL of a call
rest.url : RestTarget -> String

# the text of each parameter of a call
rest.texts : List[a -> String] -> a -> List[String]

# the pairs (headers, query parameters) that functions of a call's
# arguments give, together
rest.pairs : List[a -> List[(String, String)]] -> a -> List[(String, String)]

# `Authorization: Bearer <token>`
rest.bearer : String -> List[(String, String)]

# one `Cookie` header of cookies (none without cookies)
rest.cookie-header : List[(String, String)] -> List[(String, String)]

# a form body (`application/x-www-form-urlencoded`) of a record's fields
rest.form-body : a -> String where Encode[a]

# The text of a path parameter: a string as it is, other values as JSON.
rest.param-text : a -> String where Encode[a]

# The query parameters of a record: its fields, each element of a list
# field, and nothing for a `None` field.
rest.query-pairs : a -> List[(String, String)] where Encode[a]

# Call a REST API and decode the JSON of a successful response; any other
# response is a `RestError` with its status and body.
rest.fetch : RestRequest -> b ! {Async, Network, Error[RestError]} where Decode[b]

# `rest.fetch`, with `None` for a 404.
rest.fetch-option : RestRequest -> Option[b] ! {Async, Network, Error[RestError]} where Decode[b]

# The HTTP request of a call: its headers with `Accept:
# application/json` and `Content-Type: application/json` unless it has
# them.
rest.request : RestRequest -> ClientRequest

# The HTTP request of a call whose body is a record sent as
# `multipart/form-data` (`rest.multipart-body`).
rest.multipart-request : a -> RestRequest -> ClientRequest where Encode[a]

# Send a request; a failed connection is a `RestError` of status 0.
rest.send : ClientRequest -> ClientResponse ! {Async, Network, Error[RestError]}

# The decoded JSON of a successful response; any other response is a
# `RestError` with its status and body.
rest.json-body : ClientResponse -> b ! {Error[RestError]} where Decode[b]

# The text of a successful response (`text/plain`, `text/csv`, ...).
rest.text-body : ClientResponse -> String ! {Error[RestError]}

# The bytes of a successful response.
rest.bytes-body : ClientResponse -> Bytes ! {Error[RestError]}

# A reader of responses with `None` for a 404.
rest.or-none : (ClientResponse -> b ! {Error[RestError]}) -> ClientResponse -> Option[b] ! {Error[RestError]}

# The boundary between the parts of the `multipart/form-data` bodies that
# clients send.
rest.boundary : String

# A record as a `multipart/form-data` body (with `rest.boundary`): a text
# part per field, a file part per `Upload`, a part per element of a list,
# and none for `None`.
rest.multipart-body : a -> Bytes where Encode[a]
```

## gRPC

`lib/grpc.fwp`

gRPC: calling and serving gRPC services (docs/grpc.md).

Exported functions become gRPC services with `fwp build --grpc` (or
`--service` for a module of a larger program), with no code: their
messages come from their types. This module is for what remains: the
metadata and deadlines of calls, statuses (`GrpcError`), and the calls
and handlers that code generated from a `.proto` file (`fwp proto
--import`) is made of. Calls and servers run on the task scheduler: a
call waits only in its own task, and a server runs calls concurrently.

```fwp
# a failed call: a status code (`grpc.not-found`, ...) and a message. A
# served function that fails with `Error[GrpcError]` answers with that
# status; calls fail with it.
GrpcError = { code: I64, message: String }

# one side of a call: the client's, or the server's
GrpcStream = builtin

# a method served by `grpc.serve`: its path (`/package.Service/Method`),
# the function that handles a call, and the descriptors of the `.proto`
# files it comes from (for server reflection; routes that `fwp proto
# --import` generates carry them)
GrpcRoute = {
    handler: GrpcStream -> () ! {Async, IO, Network, FileIO, Error[GrpcError]},
    path: String,
    reflection: List[GrpcFile],
}

# A `.proto` file for server reflection: its name
# (`google/protobuf/timestamp.proto`), its serialized `FileDescriptorProto`,
# the full names of the messages, enums and services it defines, and the
# files it imports, directly or not.
GrpcFile = {
    name: String,
    descriptor: Bytes,
    symbols: List[String],
    imports: List[String],
}

# the status codes
grpc.ok : I64
grpc.cancelled : I64
grpc.unknown : I64
grpc.invalid-argument : I64
grpc.deadline-exceeded : I64
grpc.not-found : I64
grpc.already-exists : I64
grpc.permission-denied : I64
grpc.resource-exhausted : I64
grpc.failed-precondition : I64
grpc.aborted : I64
grpc.out-of-range : I64
grpc.unimplemented : I64
grpc.internal : I64
grpc.unavailable : I64
grpc.data-loss : I64
grpc.unauthenticated : I64

# the name of a status code: `grpc.code-name 5` is "NOT_FOUND"
grpc.code-name : I64 -> String

# fail with a status: `grpc.fail grpc.not-found "no such book"`
grpc.fail : I64 -> String -> a ! {Error[GrpcError]}

# the metadata (request headers, with lower-case names) of the call the
# current task serves; empty outside a call
grpc.metadata : () -> List[(String, String)] ! {Network}

# one metadata value of the call being served
grpc.header : String -> Option[String] ! {Network}

# add a header to the response of the call the current task serves: sent
# with its first message (so set it before sending any)
grpc.set-header : String -> String -> () ! {Network}

# add a trailer to the response of the call the current task serves: sent
# with its status
grpc.set-trailer : String -> String -> () ! {Network}

# run a function whose calls compress their messages with gzip
# (`grpc-encoding: gzip`; servers then compress their responses too).
# Compressed messages are always accepted.
grpc.with-gzip : (() -> a ! {Network | e}) -> a ! {Network | e}

# run a function, and collect the response metadata (headers and
# trailers, with lower-case names) of the calls it makes that end
grpc.with-response-metadata : (() -> a ! {Network | e}) -> (a, List[(String, String)]) ! {Network | e}

# the response metadata (headers and trailers) a call has received so far
grpc.response-metadata : GrpcStream -> List[(String, String)] ! {Network}

# the subject of the client's certificate (`CN=alice,O=Example`) of the
# call the current task serves, when the server requires client
# certificates (mutual TLS); `None` otherwise
grpc.peer-subject : () -> Option[String] ! {Network}

# run a function whose calls connect over TLS with these options: a CA
# file, no verification, a server name, a client certificate (ALPN is h2).
# Connections are kept per address and options.
grpc.with-tls : TlsOptions -> (() -> a ! {Network | e}) -> a ! {Network | e}

# run a function whose calls send this metadata as well
grpc.with-metadata : List[(String, String)] -> (() -> a ! {Network | e}) -> a ! {Network | e}

# run a function whose calls must finish within a duration, or fail with
# `grpc.deadline-exceeded`. (A task's deadline, `task.deadline` or
# `task.within`, also applies to its calls, and cancels the task.)
grpc.with-deadline : Duration -> (() -> a ! {Network | e}) -> a ! {Network | e}

# `grpc.unary encode decode path address request`: a unary call
grpc.unary : (a -> Bytes) -> (Bytes -> b ! {Error[GrpcError]}) -> String -> String -> a -> b ! {Network, Error[GrpcError]}

# a server-streaming call: each response goes to the channel
grpc.server-streaming : (a -> Bytes) -> (Bytes -> b ! {Error[GrpcError]}) -> String -> String -> a -> Channel[b] -> () ! {Async, Network, Error[GrpcError]}

# a client-streaming call: the requests are the iterator's elements
grpc.client-streaming : (a -> Bytes) -> (Bytes -> b ! {Error[GrpcError]}) -> String -> String -> Iterator[a] -> b ! {Network, Error[GrpcError]}

# a bidirectional call: a task of its own sends the requests while each
# response goes to the channel (the requests may be infinite: the call
# ends when the server ends it)
grpc.bidi-streaming : (a -> Bytes) -> (Bytes -> b ! {Error[GrpcError]}) -> String -> String -> Iterator[a] -> Channel[b] -> () ! {Async, Network, Error[GrpcError]}

# Lower level: start a call (`grpc.open address path`), send messages,
# end the requests, and receive messages (`None` at the end). A failed call
# fails with its status.
grpc.open : String -> String -> GrpcStream ! {Network, Error[GrpcError]}
grpc.send : Bytes -> GrpcStream -> () ! {Network, Error[GrpcError]}
grpc.close-send : GrpcStream -> () ! {Network}
grpc.recv : GrpcStream -> Option[Bytes] ! {Network, Error[GrpcError]}
grpc.cancel : GrpcStream -> () ! {Network}

# serve routes on an address ("127.0.0.1:50051"; port 0 picks a free
# port, reported on standard error), with health checking
# (`grpc.health.v1.Health`) and server reflection (`grpc.reflection.v1`
# and `v1alpha`: the services of the routes, and the `.proto` files of
# routes that carry their descriptors), until the task is cancelled
grpc.serve : String -> List[GrpcRoute] -> () ! {Async, IO, Network, FileIO, Error[IoError]}

# serve routes like `grpc.serve`, over TLS (offering h2 with ALPN) with a
# certificate chain and private key (`tls.server "cert.pem" "key.pem"`,
# and `tls.with-client-ca "ca.pem"` to require client certificates);
# clients call `tls://host:port`
grpc.serve-tls : TlsServer -> String -> List[GrpcRoute] -> () ! {Async, IO, Network, FileIO, Error[IoError]}

# a route from a path and a handler
grpc.route : String -> (GrpcStream -> () ! {Async, IO, Network, FileIO, Error[GrpcError]}) -> GrpcRoute

# Bytes from their base64 text (empty if it is not base64), as generated
# modules write descriptors.
grpc.base64-bytes : String -> Bytes

# a route with the descriptors of the `.proto` file it comes from and of
# the files that file imports, which `grpc.serve` serves by reflection
grpc.with-files : List[GrpcFile] -> GrpcRoute -> GrpcRoute

# handlers of methods from a request decoder, a response encoder and a
# function; a request that cannot be decoded fails with
# `grpc.invalid-argument`
grpc.unary-handler : (Bytes -> a ! {Error[GrpcError]}) -> (b -> Bytes) -> (a -> b ! {Async, IO, Network, FileIO, Error[GrpcError]}) -> GrpcStream -> () ! {Async, IO, Network, FileIO, Error[GrpcError]}
grpc.server-streaming-handler : (Bytes -> a ! {Error[GrpcError]}) -> (b -> Bytes) -> (a -> Channel[b] -> () ! {Async, IO, Network, FileIO, Error[GrpcError]}) -> GrpcStream -> () ! {Async, IO, Network, FileIO, Error[GrpcError]}
grpc.client-streaming-handler : (Bytes -> a ! {Error[GrpcError]}) -> (b -> Bytes) -> (Iterator[a] -> b ! {Async, IO, Network, FileIO, Error[GrpcError]}) -> GrpcStream -> () ! {Async, IO, Network, FileIO, Error[GrpcError]} where Dup[a]
grpc.bidi-streaming-handler : (Bytes -> a ! {Error[GrpcError]}) -> (b -> Bytes) -> (Iterator[a] -> Channel[b] -> () ! {Async, IO, Network, FileIO, Error[GrpcError]}) -> GrpcStream -> () ! {Async, IO, Network, FileIO, Error[GrpcError]} where Dup[a]

# The routes with server reflection (`grpc.reflection.v1` and `v1alpha`)
# added, unless they serve it themselves: it lists the services of the
# routes and health checking, and answers with the files that routes
# carry (`grpc.with-files`).
grpc.reflected : List[GrpcRoute] -> List[GrpcRoute]
```

## Protobuf

`lib/protobuf.fwp`

The protobuf wire format, for code generated from `.proto` files with
`fwp proto --import` (docs/grpc.md). A message is written from a list of
field writers (`pb.encode`) and read into a record with `make` and field
readers (`pb.get`); a `PbCodec` describes one protobuf type.

(Functions exported over gRPC with `fwp build --grpc` or `--service`
need none of this: their messages are derived from their types.)

```fwp
# a field as it is on the wire: its number, its wire type (0 varint,
# 1 64-bit, 2 length-delimited, 5 32-bit), and its bits or bytes
PbField = { bits: U64, data: Bytes, num: I64, wire: I64 }

# how values of one protobuf type are written and read
PbCodec[T] = {
    default: T,
    from-wire: (U64, Bytes) -> T ! {Error[GrpcError]},
    is-default: T -> Bool,
    to-wire: T -> (U64, Bytes),
    wire: I64,
}

# the fields of a message; `None` when it is malformed
pb.parse : Bytes -> Option[List[PbField]]

# a message of fields
pb.write : List[PbField] -> Bytes

# an integer as another integer type, truncating or sign-extending as a
# cast does (int32 values travel as 64-bit varints)
pb.cast : a -> b where Integer[a], Integer[b]

# zigzag encoding of sint32 and sint64
pb.zigzag : I64 -> U64
pb.unzigzag : U64 -> I64
pb.f32-bits : F32 -> U64
pb.f32-from-bits : U64 -> F32
pb.f64-bits : F64 -> U64
pb.f64-from-bits : U64 -> F64

# packed repeated numbers of a wire type; `None` when malformed
pb.unpack : I64 -> Bytes -> Option[List[U64]]
pb.pack : I64 -> List[U64] -> Bytes
pb.int32 : PbCodec[I32]
pb.int64 : PbCodec[I64]
pb.uint32 : PbCodec[U32]
pb.uint64 : PbCodec[U64]
pb.sint32 : PbCodec[I32]
pb.sint64 : PbCodec[I64]
pb.fixed32 : PbCodec[U32]
pb.fixed64 : PbCodec[U64]
pb.sfixed32 : PbCodec[I32]
pb.sfixed64 : PbCodec[I64]
pb.float : PbCodec[F32]
pb.double : PbCodec[F64]
pb.bool : PbCodec[Bool]
pb.string : PbCodec[String]
pb.bytes : PbCodec[Bytes]

# an enum from its conversions to and from numbers, and its default (the
# value numbered 0); unknown numbers read as the default
pb.enum : (I64 -> a ! {Error[GrpcError]}) -> (a -> I64) -> a -> PbCodec[a] where Eq[a], Dup[a]

# a message type from its encoder, decoder and default value
pb.message : (a -> Bytes) -> (Bytes -> a ! {Error[GrpcError]}) -> a -> PbCodec[a] where Dup[a]

# `google.protobuf.Empty` (and any message without fields) as `()`
pb.empty : PbCodec[()]

# the entries of a map field: messages of a key (1) and a value (2)
pb.entry : PbCodec[k] -> PbCodec[v] -> PbCodec[(k, v)] where Dup[k], Dup[v]

# a singular field, written unless it holds the default value
pb.field : I64 -> PbCodec[a] -> a -> List[PbField] where Dup[a]

# a field written even when it holds the default value (a member of a
# `oneof`)
pb.always : I64 -> PbCodec[a] -> a -> List[PbField] where Dup[a]

# an `optional` field, written when present
pb.optional : I64 -> PbCodec[a] -> Option[a] -> List[PbField] where Dup[a]

# a `repeated` field; numbers are packed
pb.repeated : I64 -> PbCodec[a] -> List[a] -> List[PbField] where Dup[a]

# a `map<K, V>` field
pb.map : I64 -> PbCodec[k] -> PbCodec[v] -> Map[k, v] -> List[PbField] where Dup[k], Dup[v]

# a field holding a value of a `oneof`, when it is set
pb.oneof : (a -> List[PbField]) -> Option[a] -> List[PbField]

# a message from the writers of its fields
pb.encode : List[a -> List[PbField]] -> a -> Bytes

# the fields of a message
pb.decode : Bytes -> List[PbField] ! {Error[GrpcError]}

# a singular field: its default when absent
pb.get : I64 -> PbCodec[a] -> List[PbField] -> a ! {Error[GrpcError]} where Dup[a]

# an `optional` field (or a member of a `oneof`)
pb.get-optional : I64 -> PbCodec[a] -> List[PbField] -> Option[a] ! {Error[GrpcError]} where Dup[a]

# a `repeated` field, packed or not
pb.get-repeated : I64 -> PbCodec[a] -> List[PbField] -> List[a] ! {Error[GrpcError]} where Dup[a]

# a `map<K, V>` field
pb.get-map : I64 -> PbCodec[k] -> PbCodec[v] -> List[PbField] -> Map[k, v] ! {Error[GrpcError]} where Ord[k], Dup[k], Dup[v]

# the member of a `oneof` that is set, from readers of each member
pb.first-of : List[x -> Option[a] ! e] -> x -> Option[a] ! e
```

## URLs

`lib/url.fwp`

URLs, percent-encoding, query strings and form bodies.

```fwp
Url = { scheme: String, host: String, port: I64, path: String, query: String }

# (scheme, host, port, path, query) of an absolute URL
url.split : String -> Option[(String, String, I64, String, String)]

# percent-encode all but unreserved characters
url.encode : String -> String

# percent-decode; `None` for malformed escapes or invalid UTF-8
url.decode : String -> Option[String]

# like url.decode, with `+` as a space (query strings and form bodies)
form.decode : String -> Option[String]
url.parse : String -> Option[Url]

# decoded name/value pairs of `a=1&b=x+y`; malformed pairs are skipped
form.parse : String -> List[(String, String)]
form.encode : List[(String, String)] -> String
```

## Logs and metrics

`lib/log.fwp`

Structured logs (logfmt lines on stderr) and process metrics.

```fwp
# `log.event level message fields`
log.event : String -> String -> List[(String, String)] -> () ! {IO}
log.fields : (I64, (String, String, List[(String, String)])) -> String

# a logfmt value: quoted, with backslashes, quotes and line breaks escaped
log.quote : String -> String
log.info : String -> () ! {IO}
log.warn : String -> () ! {IO}
log.error : String -> () ! {IO}

# counters only grow; gauges are set; observations add `_count` and `_sum`
metrics.add : String -> F64 -> () ! {IO}
metrics.set : String -> F64 -> () ! {IO}
metrics.observe : String -> F64 -> () ! {IO}

# (name, kind, value), in name order
metrics.snapshot : () -> List[(String, String, F64)] ! {IO}
metrics.inc : String -> () ! {IO}

# Prometheus text exposition format
metrics.render : () -> String ! {IO}
```

## Vectors, matrices and complex numbers

`lib/numeric.fwp`

Numerical computing: statically sized vectors and matrices, complex
numbers and dense linear algebra.

`vector [1.0, 2.0]` has type Vector[F64, 2] and `matrix [[1, 2], [3, 4]]`
has type Matrix[I64, 2, 2]: dimensions come from the literal and take
part in type checking, so `a | matmul b` with mismatched inner
dimensions is a compile error. `Dyn` marks dimensions known only at run
time.

```fwp
Dyn = builtin
Vector[T, N] = { data: Array[T] }
Matrix[T, M, N] = { rows: I64, cols: I64, data: Array[T] }

# The size parameter is taken from the literal argument.
vector : List[t] -> Vector[t, n]
vector.wrap : Array[t] -> Vector[t, n]
vector.dyn : Vector[t, n] -> Vector[t, Dyn]
vector.from-list : List[t] -> Vector[t, Dyn]
vector.to-list : Vector[t, n] -> List[t]
vector.length : Vector[t, n] -> I64
vector.get : I64 -> Vector[t, n] -> Option[t]

# Lift an array function to vectors of the same size.
vector.via : (Array[a] -> Array[b]) -> Vector[a, n] -> Vector[b, n]
vector.map : (a -> b) -> Vector[a, n] -> Vector[b, n]

# `xs | vector.zip-with f ys` combines elements at the same position as
# `f y x` (the subject last, like zip-with): `a | vector.sub b` is a - b
vector.zip-with : (b -> a -> c) -> Vector[b, n] -> Vector[a, n] -> Vector[c, n]
vector.add : Vector[t, n] -> Vector[t, n] -> Vector[t, n] where Add[t]
vector.sub : Vector[t, n] -> Vector[t, n] -> Vector[t, n] where Sub[t]
vector.scale : t -> Vector[t, n] -> Vector[t, n] where Mul[t]

# dot product of two lists
matrix.dot-list : List[t] -> List[t] -> t where Ring[t]
dot : Vector[t, n] -> Vector[t, n] -> t where Ring[t]
norm : Vector[a, n] -> a where Ring[a], Floating[a], Dup[a]
matrix : List[List[t]] -> Matrix[t, m, n]
matrix.dyn : Matrix[t, m, n] -> Matrix[t, Dyn, Dyn]
matrix.square : I64 -> Array[t] -> Matrix[t, n, n]
matrix.rows-of : Matrix[t, m, n] -> List[List[t]]
matrix.from-rows : List[List[t]] -> Matrix[t, Dyn, Dyn]

# `m | matrix.get i j` is the element in row i, column j; None when either
# index is out of range (like `nth` and `array.get`)
matrix.get : I64 -> I64 -> Matrix[t, m, n] -> Option[t]
matrix.in-bounds : (I64, I64, Matrix[t, m, n]) -> Bool
transpose : Matrix[t, m, n] -> Matrix[t, n, m]

# each row of the subject times every column in `cols`
matrix.row-products : List[List[t]] -> List[t] -> List[t] where Ring[t]

# `a | matmul b` is the matrix product a·b
matmul : Matrix[t, k, n] -> Matrix[t, m, k] -> Matrix[t, m, n] where Ring[t]

# `m | matrix.apply v` is the product m·v
matrix.apply : Vector[t, n] -> Matrix[t, m, n] -> Vector[t, m] where Ring[t]
bool.to-num : Bool -> t where Zero[t], One[t]
identity : I64 -> Matrix[t, Dyn, Dyn] where Zero[t], One[t]
linalg.lu-solve : I64 -> Array[F64] -> Array[F64] -> Option[Array[F64]]
linalg.det : I64 -> Array[F64] -> F64
linalg.inverse : I64 -> Array[F64] -> Option[Array[F64]]
linalg.cholesky : I64 -> Array[F64] -> Option[Array[F64]]
linalg.qr : I64 -> I64 -> Array[F64] -> (Array[F64], Array[F64])
linalg.cg : I64 -> F64 -> I64 -> Array[F64] -> Array[F64] -> Array[F64]
list.transpose : List[List[a]] -> List[List[a]]

# `b | solve a` solves a·x = b (None when a is singular)
solve : Matrix[F64, n, n] -> Vector[F64, n] -> Option[Vector[F64, n]]
determinant : Matrix[F64, n, n] -> F64
inverse : Matrix[F64, n, n] -> Option[Matrix[F64, n, n]]

# lower-triangular L with a = L·Lᵀ (None if a is not positive definite)
cholesky : Matrix[F64, n, n] -> Option[Matrix[F64, n, n]]

# a = Q·R with orthonormal columns in Q (m×n) and upper-triangular R (n×n)
qr : Matrix[F64, m, n] -> (Matrix[F64, m, n], Matrix[F64, n, n])

# `b | cg iterations tolerance a`: conjugate gradient for symmetric
# positive-definite a
cg : I64 -> F64 -> Matrix[F64, n, n] -> Vector[F64, n] -> Vector[F64, n]
Complex[T] = { re: T, im: T }
complex : t -> t -> Complex[t]
complex.conj : Complex[t] -> Complex[t] where Neg[t]
complex.abs : Complex[a] -> a where Ring[a], Floating[a], Dup[a]
```

## Automatic differentiation

`lib/autodiff.fwp`

Forward-mode automatic differentiation with dual numbers.

Write numeric code once, generically (for example with `where Field[a],
Floating[a]`); evaluating it at `Dual` computes derivatives. Nesting
duals (Dual[Dual[F64]]) gives second derivatives.

```fwp
Dual[T] = { re: T, eps: T }
dual : t -> t -> Dual[t]

# a constant (zero derivative) and a variable (unit derivative)
dual.const : t -> Dual[t] where Zero[t]
dual.var : t -> Dual[t] where One[t]

# Treat a value as a constant: its derivative is dropped.
stop-gradient : Dual[t] -> Dual[t] where Zero[t]

# chain rule: f(a + a'e) = f(a) + f'(a)·a'e
dual.chain : (t -> t) -> (t -> t) -> Dual[t] -> Dual[t] where Mul[t], Dup[t]

# d/dx f at x
derivative : (Dual[t] -> Dual[t]) -> t -> t where One[t]

# seed input i of a point: x_i gets derivative 1, the others 0
dual.seed-one : I64 -> (I64, t) -> Dual[t] where Zero[t], One[t]
dual.seed : I64 -> List[t] -> List[Dual[t]] where Zero[t], One[t], Dup[t]

# all partial derivatives of a scalar function at a point
gradient : (List[Dual[t]] -> Dual[t]) -> List[t] -> List[t] where Zero[t], One[t], Dup[t]

# rows are outputs, columns are inputs
jacobian : (List[Dual[t]] -> List[Dual[t]]) -> List[t] -> List[List[t]] where Zero[t], One[t], Dup[t]

# second derivatives of a scalar function (nested duals)
hessian : (List[Dual[Dual[t]]] -> Dual[Dual[t]]) -> List[t] -> List[List[t]] where Zero[t], One[t], Dup[t]
Rev[T] = { value: T, vertex: I64 }

# a constant: no gradient flows through it
rev.const : t -> Rev[t]

# The value of a scalar function and its gradient at a point, in one
# forward and one backward pass.
value-and-grad : (List[Rev[t]] -> Rev[t]) -> List[t] -> (t, List[t]) where Float[t], One[t], Dup[t]

# All partial derivatives of a scalar function at a point (reverse mode;
# the same numbers as `gradient`, for any number of inputs at the cost of
# about one evaluation).
grad : (List[Rev[t]] -> Rev[t]) -> List[t] -> List[t] where Float[t], One[t], Dup[t]

# `grad` of a function of a vector
grad-vector : (Vector[Rev[t], n] -> Rev[t]) -> Vector[t, n] -> Vector[t, n] where Float[t], One[t], Dup[t]

# Vector-Jacobian product: `xs | vjp f v` is vᵀ·J where J is the Jacobian
# of f at xs (one backward pass, whatever the number of outputs).
vjp : (List[Rev[t]] -> List[Rev[t]]) -> List[t] -> List[t] -> List[t] where Float[t], Dup[t]

# The Jacobian in reverse mode, one backward pass per output (rows are
# outputs, columns are inputs, as for `jacobian`).
rev.jacobian : (List[Rev[t]] -> List[Rev[t]]) -> List[t] -> List[List[t]] where Float[t], Zero[t], One[t], Dup[t]
```

## Tensor expressions

`lib/tensor.fwp`

Lazy tensor expressions. Building an expression does no work; `realize`
evaluates the whole graph in one pass over the elements (the operations
are fused: no intermediate arrays are allocated). Graph passes rewrite
expressions before they are realized.

Expressions implement the numeric traits (`Ring`, `Field`, `Floating`),
so generic numeric code builds fused elementwise kernels. They run on a
`Device`: `Cpu`, `CpuParallel n` (n threads) or `Gpu` (OpenCL, when a
device with double precision is present). Elementwise results are the
same on every CPU device and in both backends, bit for bit; reductions
(`tensor.sum`) add blocks of 4096 elements from the left and then the
block sums from the left, whatever the number of threads, so they are
reproducible too. See docs/numerics.md.

```fwp
TensorExpr[N] =
    | TLeaf Vector[F64, N]
    | TFill F64
    | TAdd TensorExpr[N] TensorExpr[N]
    | TMul TensorExpr[N] TensorExpr[N]
    | TScale F64 TensorExpr[N]
    | TMap (F64 -> F64) TensorExpr[N]
    # minuend and subtrahend
    | TSub TensorExpr[N] TensorExpr[N]
    # dividend and divisor
    | TDiv TensorExpr[N] TensorExpr[N]
    | TUnary UnaryOp TensorExpr[N]

# The elementwise functions a kernel computes itself (`tensor.map` takes
# any function, but runs it on the CPU before the kernel).
UnaryOp =
    | OpNeg
    | OpSqrt
    | OpExp
    | OpLn
    | OpSin
    | OpCos
    | OpTan
    | OpAbs
tensor.lazy : Vector[F64, n] -> TensorExpr[n]
tensor.fill : F64 -> TensorExpr[n]

# data-last builders: `x | tensor.add y`
tensor.add : TensorExpr[n] -> TensorExpr[n] -> TensorExpr[n]
tensor.mul : TensorExpr[n] -> TensorExpr[n] -> TensorExpr[n]
tensor.scale : F64 -> TensorExpr[n] -> TensorExpr[n]
tensor.map : (F64 -> F64) -> TensorExpr[n] -> TensorExpr[n]

# `x | tensor.sub y` is x - y
tensor.sub : TensorExpr[n] -> TensorExpr[n] -> TensorExpr[n]

# `x | tensor.div y` is x / y
tensor.div : TensorExpr[n] -> TensorExpr[n] -> TensorExpr[n]
tensor.unary : UnaryOp -> TensorExpr[n] -> TensorExpr[n]
tensor.abs : TensorExpr[n] -> TensorExpr[n]

# one element of a unary operation
tensor.apply-unary : UnaryOp -> F64 -> F64

# element i of an expression
rec tensor.at : TensorExpr[n] -> I64 -> F64

# The number of elements, or None for an expression made only of fills
# (a fill takes the length of what it is combined with). Combining two
# operands of different lengths is a trap.
rec tensor.length : TensorExpr[n] -> Option[I64]

# Evaluate an expression (on the CPU, one thread); a trap when it is made
# only of fills, whose length is unknown.
realize : TensorExpr[n] -> Vector[F64, n]
rec graph.size : TensorExpr[n] -> I64

# Constant folding: combine constants and nested scalings.
rec graph.constant-fold : TensorExpr[n] -> TensorExpr[n]

# Where kernels run. `CpuParallel n` splits the elements into n contiguous
# ranges, one per thread (in WebAssembly, one thread). `Gpu` is the first
# OpenCL device with double precision (a GPU if there is one); it needs
# libOpenCL at run time (`FWP_OPENCL_LIB` names another library).
Device =
    | Cpu
    | CpuParallel I64
    | Gpu

# Whether a device can run kernels here (`Gpu`: an OpenCL device with
# double precision was found).
device.available : Device -> Bool
device.name : Device -> String

# A fused elementwise kernel: postfix code over `length` elements, with
# the constants and the input arrays in the order the code uses them.
Kernel = {
    code: Array[I64],
    consts: Array[F64],
    inputs: List[Array[F64]],
    length: I64,
}

# The kernel of an expression over n elements.
tensor.kernel-of : I64 -> TensorExpr[n] -> Kernel

# The kernel of an expression (a trap when it is made only of fills).
tensor.kernel : TensorExpr[n] -> Kernel

# Run a kernel on a device: an error when the device cannot run it.
kernel.run : Device -> Kernel -> Result[Array[F64], String]

# The sum of a kernel's elements, in blocks of 4096 from the left (on the
# GPU, the elements are computed there and summed on the CPU).
kernel.sum : Device -> Kernel -> Result[F64, String]

# Evaluate an expression on a device; an error when the device is not
# available.
tensor.try-realize-on : Device -> TensorExpr[n] -> Result[Vector[F64, n], String]

# Evaluate an expression on a device (a trap with the reason when the
# device is not available).
realize-on : Device -> TensorExpr[n] -> Vector[F64, n]

# The sum of the elements of an expression, in a fixed order (see above).
tensor.sum-on : Device -> TensorExpr[n] -> F64
tensor.sum : TensorExpr[n] -> F64

# The OpenCL C source of an expression's kernel: `fwp_kernel(out, k, n,
# x0, x1, ...)` computes element i of n from the inputs xj and the
# constants k, in the order of the CPU kernel (FP_CONTRACT OFF: no fused
# multiply-add).
tensor.opencl : TensorExpr[n] -> String
tensor.opencl-of : Kernel -> String

# The gradient of the sum of an expression's elements with respect to
# each of its leaves (`tensor.lazy` vectors, in order from the left), by
# reverse mode over the expression: the adjoint of each leaf is itself a
# fused expression, run on the device. `tensor.map` cannot be
# differentiated (a trap; `Floating` and the elementwise builders can);
# the derivative of `tensor.abs` at 0 is NaN.
tensor.grad-on : Device -> TensorExpr[n] -> List[Vector[F64, n]]
tensor.grad : TensorExpr[n] -> List[Vector[F64, n]]
```

## Balanced ternary

`lib/ternary.fwp`

Balanced ternary: trits (-1, 0, +1), fixed-width balanced ternary
integers TInt[N] (literals like 0t+-0, checked arithmetic), and dense
packing of trits, five per byte.

```fwp
trit.from-sign : I64 -> Trit
trit.to-int : Trit -> I64
tint.to-int : TInt[n] -> I64
tint.of-int : I64 -> Option[TInt[n]]

# most significant trit first
tint.trits : TInt[n] -> List[Trit]
tint.from-trits : List[Trit] -> Option[TInt[n]]
trits.pack : List[Trit] -> Bytes

# `bs | trits.unpack n`: the first n trits, but never more than the bytes
# hold (5 per byte); positions past the end are not read as trits
trits.unpack : I64 -> Bytes -> List[Trit]
trit.pos : Trit
trit.zero : Trit
trit.neg : Trit
trit.negate : Trit -> Trit

# N trits stored densely
PackedTrits[N] = { count: I64, bytes: Bytes }
packed.from-tint : TInt[n] -> PackedTrits[n]
packed.to-tint : PackedTrits[n] -> Option[TInt[n]]
packed.trits : PackedTrits[n] -> List[Trit]
```

## SIMD

`lib/simd.fwp`

Portable SIMD: Vec[N, T] holds N lanes. Lane-wise operations lower to
GCC/Clang vector extensions in native code (and from there to SSE, AVX,
NEON or WASM SIMD). Integer lanes wrap on overflow, as in hardware.

```fwp
Vec[N, T] = { lanes: Array[T] }
simd.splat : t -> Vec[n, t] where Numeric[t]
simd.from-array : Array[t] -> Option[Vec[n, t]] where Numeric[t]
simd.add : Vec[n, t] -> Vec[n, t] -> Vec[n, t] where Numeric[t]
simd.sub : Vec[n, t] -> Vec[n, t] -> Vec[n, t] where Numeric[t]
simd.mul : Vec[n, t] -> Vec[n, t] -> Vec[n, t] where Numeric[t]
simd.div : Vec[n, t] -> Vec[n, t] -> Vec[n, t] where Numeric[t]
simd.min : Vec[n, t] -> Vec[n, t] -> Vec[n, t] where Numeric[t]
simd.max : Vec[n, t] -> Vec[n, t] -> Vec[n, t] where Numeric[t]
simd.sum : Vec[n, t] -> t where Numeric[t]
simd.to-array : Vec[n, t] -> Array[t]
simd.dot : Vec[n, t] -> Vec[n, t] -> t where Numeric[t]

# `c | simd.mul-add a b` is a·b + c (rounded after each step)
simd.mul-add : Vec[n, t] -> Vec[n, t] -> Vec[n, t] -> Vec[n, t] where Numeric[t]
```

## C interop

`lib/ffi.fwp`

C interop: raw pointers and memory for `foreign "C"` functions.

    foreign "C" strlen : String -> U64
    repr(C) DivResult = { quot: I32, rem: I32 }
    foreign "C" div : I32 -> I32 -> DivResult

Pointers are only dereferenced under the `Unsafe` effect. `Option[Ptr[T]]`
is a nullable pointer (`None` is NULL); fwp itself has no null.

```fwp
Ptr[T] = builtin

# zero-initialized memory
mem.alloc : I64 -> Ptr[a] ! {Unsafe}
mem.free : Ptr[a] -> () ! {Unsafe}

# a NUL-terminated copy of a string, to be freed with mem.free
mem.string : String -> Ptr[U8] ! {Unsafe}
ptr.cast : Ptr[a] -> Ptr[b]

# the address of the n-th element
ptr.at : I64 -> Ptr[a] -> Ptr[a] where Numeric[a]
ptr.read : Ptr[a] -> a ! {Unsafe} where Numeric[a]
ptr.write : a -> Ptr[a] -> () ! {Unsafe} where Numeric[a]

# the NUL-terminated string at a pointer
ptr.read-string : Ptr[a] -> String ! {Unsafe}
ptr.address : Ptr[a] -> U64
```
