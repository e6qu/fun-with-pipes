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
- [HTTP](#http)
- [JSON](#json)
- [REST endpoints and clients](#rest-endpoints-and-clients)
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
event loop; the interpreter runs each task on a thread, one at a time.

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

## HTTP

`lib/http.fwp`

HTTP/1.1 server and client.

A handler is an ordinary function `Request -> Response`, and middleware is
ordinary composition:

    handler = timeout 2s | auth.bearer token | service | json.response

The server runs every connection in its own task. It bounds the number of
connections (accepting waits while all slots are taken), the size of
request heads and bodies and the requests per connection; it applies idle,
header, body, write and per-request timeouts; and on SIGINT/SIGTERM it
stops accepting, lets in-flight requests finish within a grace period,
then cancels the rest.

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
Body =
    | Body.Full Bytes
    | Body.Stream (Channel[Bytes] -> () ! {Async, IO, Network, FileIO})
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
}
http.parse-request-head : Bytes -> Result[(String, String, String, List[(String, String)]), String]
http.parse-response-head : Bytes -> Result[(String, I64, String, List[(String, String)]), String]

# a header that can be written as is: a token as its name, and no control
# characters (CR, LF, NUL, ...) but tabs in its value
http.field-ok : String -> String -> Bool

# the body length request headers declare: 0 without content-length, -1
# when it is not a plain decimal number or the header is repeated
http.content-length : List[(String, String)] -> I64
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
http.body-text : Request -> String
http.form : Request -> List[(String, String)]

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
http.segments : String -> List[String]

# dispatch to the first matching route; 404 or 405 otherwise
http.router : List[Route] -> Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}
http.find-route : List[Route] -> Request -> Option[(Route, List[(String, String)])]
http.route-match : Request -> Route -> Option[(Route, List[(String, String)])]
http.method-ok : (Request, Route) -> Bool

# HEAD requests are routed like GET (the server omits the body)
http.head-as-get : String -> String
http.path-params : (Request, Route) -> Option[(Route, List[(String, String)])]

# bindings of `:name` segments if a pattern matches a path
http.match-path : List[String] -> List[String] -> Option[List[(String, String)]]
http.seg-match : (String, String) -> Option[Option[(String, String)]]

# all present
http.all-some : List[Option[a]] -> Option[List[a]]
http.all-some-step : Option[List[a]] -> Option[a] -> Option[List[a]]
http.dispatch : (List[Route], Request) -> Option[(Route, List[(String, String)])] -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}
http.set-params : List[(String, String)] -> Request -> Request
http.missing : (List[Route], Request) -> Response ! {Error[HttpError]}
http.matches-path : List[String] -> Route -> Bool

Server = {
    listener: Listener,
    config: ServerConfig,
    handler: Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]},
    slots: Channel[()],
}

# `until`: the monotonic time by which the current request's head (and
# then its body) must have arrived
ConnState = {
    server: Server,
    conn: Conn,
    buffer: Bytes,
    served: I64,
    until: Duration,
}

Head =
    | Head.Closed
    | Head.Bad ConnState I64 String
    | Head.Got Bytes ConnState

Pending = {
    st: ConnState,
    method: String,
    target: String,
    version: String,
    headers: List[(String, String)],
    length: I64,
}

BodyEnd =
    | BodyEnd.Closed
    | BodyEnd.Late Pending
    | BodyEnd.Done Pending
Exchange = { st: ConnState, request: Request, keep: Bool }

Out = {
    conn: Conn,
    keep: Bool,
    head-only: Bool,
    response: Response,
    timeout: Duration,
}
http.no-bytes : Bytes
http.crlf : Bytes
http.crlf2 : Bytes
http.last-chunk : Bytes
http.bytes-take : I64 -> Bytes -> Bytes
http.bytes-drop : I64 -> Bytes -> Bytes

# Listen on `addr` and serve until a shutdown signal.
http.serve : ServerConfig -> (Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}) -> () ! {Async, IO, Network, Error[IoError]}

# Serve on a listener (for example one bound to port 0).
http.serve-on : Listener -> (ServerConfig, Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}) -> () ! {Async, IO, Network}
http.accept-main : (Listener, (ServerConfig, Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]})) -> () ! {Async, IO, Network, FileIO}
http.make-server : (Listener, (ServerConfig, Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]})) -> Channel[()] -> Server
http.accept-step : Server -> Step[Server, ()] ! {Async, IO, Network, FileIO}

# take a connection slot (waits while all are in use), then accept
http.accept-one : Server -> Step[Server, ()] ! {Async, IO, Network, FileIO}
http.accepted : Server -> Result[Option[Conn], IoError] -> Step[Server, ()] ! {Async, IO, Network, FileIO}
http.release : Server -> Server ! {Async}
http.conn-main : (Server, Conn) -> () ! {Async, IO, Network, FileIO}
http.serve-conn : (Server, Conn) -> () ! {Async, IO, Network, FileIO, Error[IoError]}
http.conn-step : ConnState -> Step[ConnState, ()] ! {Async, IO, Network, FileIO, Error[IoError]}

# a monotonic deadline a duration from now (capped at about a century)
http.later : Duration -> Duration ! {IO}

# the time left until a deadline (negative once it passed)
http.left : Duration -> Duration ! {IO}
http.with-until : Duration -> ConnState -> ConnState
http.head-deadline : ConnState -> ConnState ! {IO}
http.head-step : ConnState -> Step[ConnState, Head] ! {Async, IO, Network, Error[IoError]}
http.head-found : ConnState -> Option[I64] -> Step[ConnState, Head] ! {Async, IO, Network, Error[IoError]}
http.head-more : ConnState -> Step[ConnState, Head] ! {Async, IO, Network, Error[IoError]}

# before the first byte of a request: the idle timeout; after it, what is
# left of the header timeout (a client trickling bytes cannot hold the
# connection forever)
http.head-wait : ConnState -> Duration ! {IO}
http.head-read : ConnState -> Option[Bytes] -> Step[ConnState, Head] ! {IO}

# the header timeout counts from the first byte of the request
http.first-byte : ConnState -> ConnState ! {IO}
http.with-buffer : Bytes -> ConnState -> ConnState
http.on-head : Head -> Step[ConnState, ()] ! {Async, IO, Network, FileIO, Error[IoError]}

# answer with an error and close the connection
http.error-stop : I64 -> (ConnState, String) -> Step[ConnState, ()] ! {Async, Network, Error[IoError]}
http.on-request : Bytes -> ConnState -> Step[ConnState, ()] ! {Async, IO, Network, FileIO, Error[IoError]}
http.on-parsed : ConnState -> Result[(String, String, String, List[(String, String)]), String] -> Step[ConnState, ()] ! {Async, IO, Network, FileIO, Error[IoError]}
http.check-body : Pending -> Step[ConnState, ()] ! {Async, IO, Network, FileIO, Error[IoError]}
http.pending-error : I64 -> String -> Pending -> Step[ConnState, ()] ! {Async, Network, Error[IoError]}
http.read-body : Pending -> Step[ConnState, ()] ! {Async, IO, Network, FileIO, Error[IoError]}

# the whole body must arrive within the body timeout
http.body-deadline : Pending -> Pending ! {IO}
http.body-step : Pending -> Step[Pending, BodyEnd] ! {Async, IO, Network, Error[IoError]}
http.body-read : Pending -> Option[Bytes] -> Step[Pending, BodyEnd]
http.pending-st : ConnState -> Pending -> Pending
http.pending-append : Bytes -> Pending -> Pending
http.on-body : BodyEnd -> Step[ConnState, ()] ! {Async, IO, Network, FileIO, Error[IoError]}
http.respond-to : Pending -> Step[ConnState, ()] ! {Async, IO, Network, FileIO, Error[IoError]}
http.request-of : Pending -> Request ! {Network}
http.path-of : String -> String
http.keep-alive : Pending -> Bool ! {Async}
http.exchange : Exchange -> Step[ConnState, ()] ! {Async, IO, Network, FileIO, Error[IoError]}

# the handler in its own task, with the request timeout
http.run-handler : Exchange -> Response ! {Async}
http.outcome : Option[Result[Response, HttpError]] -> Response
http.next-served : ConnState -> ConnState
http.write-out : Out -> () ! {Async, Network, Error[IoError]}

# A response that cannot be written as is (a header with CR or LF would
# let a handler's input split the response) is replaced by a 500.
http.checked : Out -> Out
http.response-ok : Response -> Bool

# write with the write timeout
http.put : Out -> Bytes -> () ! {Async, Network, Error[IoError]}
http.send-body : Out -> Body -> () ! {Async, Network, Error[IoError]}
http.stream-body : (Out, Channel[Bytes] -> () ! {Async, IO, Network, FileIO}) -> () ! {Async, Network, Error[IoError]}
http.stream-start : (Out, Channel[Bytes] -> () ! {Async, IO, Network, FileIO}) -> Channel[Bytes] -> () ! {Async, Network, Error[IoError]}
http.stream-run : ((Out, Channel[Bytes] -> () ! {Async, IO, Network, FileIO}), Channel[Bytes]) -> Task[()] -> () ! {Async, Network, Error[IoError]}

# the client is done (or gone): stop the producer
http.stream-finish : (((Out, Channel[Bytes] -> () ! {Async, IO, Network, FileIO}), Channel[Bytes]), Task[()]) -> Result[(), IoError] -> () ! {Async, Error[IoError]}

# run a producer, then close its channel
http.closing : (Channel[Bytes] -> () ! {Async, IO, Network, FileIO}) -> Channel[Bytes] -> () ! {Async, IO, Network, FileIO}
http.chunk-step : (Out, Channel[Bytes]) -> Step[(Out, Channel[Bytes]), ()] ! {Async, Network, Error[IoError]}
http.chunk-got : (Out, Channel[Bytes]) -> Option[Bytes] -> Step[(Out, Channel[Bytes]), ()] ! {Async, Network, Error[IoError]}

# chunk sizes: lower-case hexadecimal (negative numbers with a sign)
http.to-hex : I64 -> String = "int.to-hex"
http.parse-hex : String -> Option[I64] = "int.parse-hex"
http.chunk-frame : Bytes -> Bytes
http.head-bytes : Out -> Bytes
http.head-parts : List[Out -> String]
http.framing : Body -> String

ClientRequest = {
    method: String,
    url: String,
    headers: List[(String, String)],
    body: Bytes,
}
ClientResponse = { status: I64, headers: List[(String, String)], body: Bytes }
http.get : String -> ClientResponse ! {Async, Network, Error[IoError]}
http.post : String -> Bytes -> ClientResponse ! {Async, Network, Error[IoError]}

# send a request (one connection per request) and read the whole response
http.send : ClientRequest -> ClientResponse ! {Async, Network, Error[IoError]}

# refuse a method or header that would not make one well-formed request
# (URLs with spaces or control characters do not parse)
http.check-request : ClientRequest -> ClientRequest ! {Error[IoError]}
http.require-url : Option[Url] -> Url ! {Error[IoError]}
http.send-to : ClientRequest -> Url -> ClientResponse ! {Async, Network, Error[IoError]}
http.host-port : Url -> String

# IPv6 literals in brackets
http.host-name : Url -> String

# the host header: with the port when it is not the scheme's default
http.host-header : Url -> String
http.default-port : String -> I64
http.request-bytes : (ClientRequest, Url) -> Bytes
http.request-parts : List[(ClientRequest, Url) -> String]
http.target-of : Url -> String
http.read-all : Conn -> Bytes ! {Async, Network, Error[IoError]}
http.read-all-step : (Conn, Bytes) -> Step[(Conn, Bytes), Bytes] ! {Async, Network, Error[IoError]}
http.read-all-got : (Conn, Bytes) -> Bytes -> Step[(Conn, Bytes), Bytes]
http.parse-client : Bytes -> ClientResponse ! {Error[IoError]}
http.client-split : Bytes -> Option[I64] -> ClientResponse ! {Error[IoError]}
http.client-head : Bytes -> Result[(String, I64, String, List[(String, String)]), String] -> ClientResponse ! {Error[IoError]}
http.client-body : (Bytes, (String, I64, String, List[(String, String)])) -> Bytes ! {Error[IoError]}
http.take-length : Option[I64] -> Bytes -> Bytes
http.dechunk : Bytes -> Bytes ! {Error[IoError]}
http.dechunk-step : (Bytes, Bytes) -> Step[(Bytes, Bytes), Bytes] ! {Error[IoError]}
http.dechunk-line : (Bytes, Bytes) -> Option[I64] -> Step[(Bytes, Bytes), Bytes] ! {Error[IoError]}
http.chunk-size : String -> Option[I64]
http.dechunk-size : ((Bytes, Bytes), I64) -> Option[I64] -> Step[(Bytes, Bytes), Bytes] ! {Error[IoError]}
http.chunk-rest : (((Bytes, Bytes), I64), I64) -> Bytes
http.chunk-acc : (((Bytes, Bytes), I64), I64) -> Bytes
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
# may be absent), or nothing (a `()` parameter).
RestSource =
    | RestSource.Path String
    | RestSource.Query String Bool
    | RestSource.Queries String
    | RestSource.Fields List[(String, I64)]
    | RestSource.Body Bool
    | RestSource.Unit

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

# Options of a REST server's command line.
RestOptions = { listen: Option[String], openapi: Bool, help: Bool }

# A route of `http.router` that calls a function with the arguments of a
# request and responds with its result as JSON.
rest.endpoint : RestRoute -> (a -> b ! {Async, IO, Network, FileIO, Error[e]}) -> Route where Decode[a], Encode[b], Encode[e]

# `rest.endpoint` for a function returning `Option`: `None` is a 404.
rest.endpoint-option : RestRoute -> (a -> Option[b] ! {Async, IO, Network, FileIO, Error[e]}) -> Route where Decode[a], Encode[b], Encode[e]

# `rest.endpoint` for a function returning `Result`: `Err` is an error
# response, like a raised `Error`.
rest.endpoint-result : RestRoute -> (a -> Result[b, x] ! {Async, IO, Network, FileIO, Error[e]}) -> Route where Decode[a], Encode[b], Encode[x], Encode[e]
rest.endpoint-with : (RestRoute -> b -> Result[Response, HttpError]) -> RestRoute -> (a -> b ! {Async, IO, Network, FileIO, Error[e]}) -> Route where Decode[a], Encode[e]

# `/items/{id}` as a router pattern (`/items/:id`)
rest.pattern : String -> List[String]
rest.handler : (RestRoute -> b -> Result[Response, HttpError], RestRoute, a -> b ! {Async, IO, Network, FileIO, Error[e]}) -> Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]} where Decode[a], Encode[e]
rest.call : (RestRoute -> b -> Result[Response, HttpError], RestRoute, a -> b ! {Async, IO, Network, FileIO, Error[e]}) -> a -> Result[Response, HttpError] ! {Async, IO, Network, FileIO} where Encode[e]
rest.finish : (RestRoute -> b -> Result[Response, HttpError], RestRoute, a -> b ! {Async, IO, Network, FileIO, Error[e]}) -> Result[b, e] -> Result[Response, HttpError] where Encode[e]

# The arguments of a call, decoded from a request: one argument, or a
# tuple of several. A decoding error is a 400 naming the parameter.
rest.decode : List[RestSource] -> Request -> a ! {Error[HttpError]} where Decode[a]
rest.read-args : List[String] -> String -> a ! {Error[HttpError]} where Decode[a]
rest.decoded : List[String] -> Result[a, String] -> a ! {Error[HttpError]}

# The JSON text of the arguments: one, or an array of several.
rest.arguments : List[RestSource] -> Request -> String ! {Error[HttpError]}
rest.join-args : List[String] -> String
rest.argument : Request -> RestSource -> String ! {Error[HttpError]}
rest.quote : String -> String
rest.path-arg : Request -> String -> String ! {Error[HttpError]}

# every value of a query parameter
rest.query-values : String -> Request -> List[String]
rest.value-of : String -> (String, String) -> Option[String]
rest.query-arg : Request -> String -> Bool -> String ! {Error[HttpError]}
rest.query-one : (Request, String, Bool) -> Option[String] -> String ! {Error[HttpError]}
rest.queries-arg : Request -> String -> String
rest.fields-arg : Request -> List[(String, I64)] -> String
rest.field-arg : Request -> (String, I64) -> Option[String]

# `"name":value`
rest.member : String -> Option[String] -> Option[String]
rest.field-value : I64 -> List[String] -> Option[String]

# a switch: absent is false, `?name` is true
rest.switch : Option[String] -> String
rest.body-arg : Request -> Bool -> String ! {Error[HttpError]}
rest.body-of : Bool -> String -> String ! {Error[HttpError]}
rest.checked : String -> Result[Json, String] -> String ! {Error[HttpError]}

# How a source is named in decoding errors.
rest.label : RestSource -> String

# `$[1].price: ...` with the label of argument 1 instead of `$[1]` (of
# the only argument instead of `$`)
rest.relabel : List[String] -> String -> String
rest.relabel-one : (List[String], String) -> String
rest.relabel-many : (List[String], String) -> String
rest.relabel-at : List[String] -> Option[(String, String)] -> String
rest.label-at : List[String] -> String -> String

# 200 (or the route's status) with the JSON of a value; 204 has no body
rest.success : RestRoute -> b -> Response where Encode[b]
rest.success-option : RestRoute -> Option[b] -> Result[Response, HttpError] where Encode[b]
rest.success-result : RestRoute -> Result[b, x] -> Result[Response, HttpError] where Encode[b], Encode[x]
rest.no-content : Response
rest.json-text : I64 -> String -> Response

# `{"error": ...}`
rest.error-body : String -> String

# An error value as a response: `{"error": <the error as JSON>}`.
rest.failure : RestRoute -> e -> Response where Encode[e]

# the status of an error: by variant name (`errors`), else its `status`
# field, else the route's `error-status`
rest.error-status : RestRoute -> Json -> I64
rest.variant-name : Json -> Option[String]
rest.named-status : List[(String, I64)] -> Option[String] -> Option[I64]
rest.status-field : Json -> Option[I64]
rest.http-error : HttpError -> Response

# Serve endpoints, and the OpenAPI document at `/openapi.json`, with JSON
# error responses (`{"error": "not found"}` for unknown paths). The
# command line is `[--listen host:port] [--openapi] [--help]`; the address
# defaults to `FWP_REST_ADDR`, else `127.0.0.1:8080`.
rest.main : String -> List[Route] -> () ! {Async, IO, Network}
rest.default-options : RestOptions
rest.usage : String
rest.start : (String, List[Route]) -> Result[(RestOptions, List[String]), String] -> () ! {Async, IO, Network}
rest.run-with : ((String, List[Route]), (RestOptions, List[String])) -> () ! {Async, IO, Network}
rest.help : String
rest.listen : ((String, List[Route]), (RestOptions, List[String])) -> () ! {Async, IO, Network}
rest.address : Option[String] -> String ! {IO}
rest.serve-at : (String, List[Route]) -> String -> () ! {Async, IO, Network, Error[IoError]}
rest.serve-on : Listener -> (String, List[Route]) -> () ! {Async, IO, Network}
rest.config : ServerConfig
rest.stopped : Result[(), IoError] -> () ! {IO}

# The handler of a server: the endpoints and `/openapi.json`, with errors
# (unknown routes, bad arguments) as JSON.
rest.handler-of : (String, List[Route]) -> Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}
rest.openapi-route : String -> Route
rest.respond : Result[Response, HttpError] -> Response

# A call of a REST API, as the client functions that
# `fwp openapi --import` generates make them: the method, the URL and the
# JSON body.
RestRequest = { method: String, url: String, body: Option[String] }

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
rest.url : RestTarget -> String
rest.trim-slash : String -> String

# `/items/{id}` with the path parameters, percent-encoded
rest.fill : List[String] -> String -> String
rest.fill-step : (List[String], List[String]) -> String -> (List[String], List[String])

# the text of each parameter of a call
rest.texts : List[a -> String] -> a -> List[String]
rest.query-string : List[(String, String)] -> String

# The text of a path parameter: a string as it is, other values as JSON.
rest.param-text : a -> String where Encode[a]
rest.unquote : String -> String

# The query parameters of a record: its fields, each element of a list
# field, and nothing for a `None` field.
rest.query-pairs : a -> List[(String, String)] where Encode[a]
rest.query-pair : (String, Json) -> List[(String, String)]
rest.scalar-text : Json -> String

# Call a REST API and decode the JSON of a successful response; any other
# response is a `RestError` with its status and body.
rest.fetch : RestRequest -> b ! {Async, Network, Error[RestError]} where Decode[b]

# `rest.fetch`, with `None` for a 404.
rest.fetch-option : RestRequest -> Option[b] ! {Async, Network, Error[RestError]} where Decode[b]
rest.exchange : RestRequest -> ClientResponse ! {Async, Network, Error[RestError]}
rest.sent : Result[ClientResponse, IoError] -> ClientResponse ! {Error[RestError]}
rest.decode-response : ClientResponse -> b ! {Error[RestError]} where Decode[b]

# an empty body is `{}` (a `()` result)
rest.body-json : Bytes -> String
rest.decoded-body : I64 -> Result[b, String] -> b ! {Error[RestError]}
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
```

## Tensor expressions

`lib/tensor.fwp`

Lazy tensor expressions. Building an expression does no work; `realize`
evaluates the whole graph in one pass over the elements (the operations
are fused: no intermediate arrays are allocated). Graph passes rewrite
expressions before they are realized.

```fwp
TensorExpr[N] =
    | TLeaf Vector[F64, N]
    | TFill F64
    | TAdd TensorExpr[N] TensorExpr[N]
    | TMul TensorExpr[N] TensorExpr[N]
    | TScale F64 TensorExpr[N]
    | TMap (F64 -> F64) TensorExpr[N]
tensor.lazy : Vector[F64, n] -> TensorExpr[n]
tensor.fill : F64 -> TensorExpr[n]

# data-last builders: `x | tensor.add y`
tensor.add : TensorExpr[n] -> TensorExpr[n] -> TensorExpr[n]
tensor.mul : TensorExpr[n] -> TensorExpr[n] -> TensorExpr[n]
tensor.scale : F64 -> TensorExpr[n] -> TensorExpr[n]
tensor.map : (F64 -> F64) -> TensorExpr[n] -> TensorExpr[n]

# element i of an expression
rec tensor.at : TensorExpr[n] -> I64 -> F64

# The number of elements, or None for an expression made only of fills
# (a fill takes the length of what it is combined with). Combining two
# operands of different lengths is a trap.
rec tensor.length : TensorExpr[n] -> Option[I64]

# Evaluate an expression; a trap when it is made only of fills, whose
# length is unknown.
realize : TensorExpr[n] -> Vector[F64, n]
rec graph.size : TensorExpr[n] -> I64

# Constant folding: combine constants and nested scalings.
rec graph.constant-fold : TensorExpr[n] -> TensorExpr[n]
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
