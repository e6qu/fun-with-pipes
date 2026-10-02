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
- [Tasks and channels](#tasks-and-channels)
- [Networking](#networking)
- [HTTP](#http)
- [JSON](#json)
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
list.partition-step : (Bool, a) -> (List[a], List[a]) -> (List[a], List[a])
enumerate : List[a] -> List[(I64, a)] where Dup[a]
each : (a -> () ! e) -> List[a] -> () ! e
filter-map : (a -> Option[b] ! e) -> List[a] -> List[b] ! e
maximum : List[a] -> Option[a] where Ord[a]
minimum : List[a] -> Option[a] where Ord[a]
singleton : a -> List[a]
sum : List[a] -> a where Add[a], Zero[a]
product : List[a] -> a where Mul[a], One[a]
list.test-ints : List[I64] -> List[I64]
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
option.test-opt : Option[I64] -> Option[I64]
result.test-res : Result[I64, String] -> Result[I64, String]
result.test-res-s : Result[String, String] -> Result[String, String]
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
string.test-i64 : Option[I64] -> Option[I64]
string.test-u8 : Option[U8] -> Option[U8]
string.test-of : List[Option[F64]] -> List[Option[F64]]

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
map.test-oi : Option[I64] -> Option[I64]

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

# one step over (predicate, iterator): stop at the next accepted element
rec iter.filter-step : (a -> Bool, Iterator[a]) -> Step[(a -> Bool, Iterator[a]), Iterator[a]] where Dup[a]

# `iter.take n` is the first n elements (none when n <= 0). The element
# after the n-th is never forced.
iter.take : I64 -> Iterator[a] -> Iterator[a] where Dup[a]

# n >= 1
rec iter.take-some : I64 -> Iterator[a] -> Iterator[a] where Dup[a]

# `iter.iterate f x` is x, f x, f (f x), ...
iter.iterate : (a -> a) -> a -> Iterator[a] where Dup[a]
```

## Console, environment and time

`lib/io.fwp`

Console, environment and time.

```fwp
write : String -> () ! {IO}
eprint : String -> () ! {IO}
read-line : () -> Option[String] ! {IO}
read-all : () -> String ! {IO}
read-lines : () -> List[String] ! {IO}
env.get : String -> Option[String] ! {IO}
time.monotonic : () -> Duration ! {IO}
time.unix : () -> Duration ! {IO}
duration.nanos : Duration -> I64
duration.millis : Duration -> I64
duration.from-millis : I64 -> Duration
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
ConnState = { server: Server, conn: Conn, buffer: Bytes, served: I64, until: Duration }

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
Out = { conn: Conn, keep: Bool, head-only: Bool, response: Response, timeout: Duration }
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
ClientRequest = { method: String, url: String, headers: List[(String, String)], body: Bytes }
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

# both present
form.both-some : (Option[a], Option[b]) -> Option[(a, b)]

# decoded name/value pairs of `a=1&b=x+y`; malformed pairs are skipped
form.parse : String -> List[(String, String)]
form.pair : String -> Option[(String, String)]
form.pair-of : String -> Option[(String, String)] -> Option[(String, String)]
form.encode : List[(String, String)] -> String
```

## Logs and metrics

`lib/log.fwp`

Structured logs (logfmt lines on stderr) and process metrics.

```fwp
# `log.event level message fields`
log.event : String -> String -> List[(String, String)] -> () ! {IO}
log.line-of : I64 -> (String, String, List[(String, String)]) -> String
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
metrics.line : (String, String, F64) -> String
metrics.sample : (String, String, F64) -> String
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
qr.raw : Matrix[F64, m, n] -> (Array[F64], Array[F64])

# `b | cg iterations tolerance a`: conjugate gradient for symmetric
# positive-definite a
cg : I64 -> F64 -> Matrix[F64, n, n] -> Vector[F64, n] -> Vector[F64, n]
cg.raw : (I64, F64, Matrix[F64, n, n]) -> Array[F64] -> Array[F64]
Complex[T] = { re: T, im: T }
complex : t -> t -> Complex[t]
complex.conj : Complex[t] -> Complex[t] where Neg[t]
complex.abs : Complex[a] -> a where Ring[a], Floating[a], Dup[a]
matrix.test-im : Matrix[I64, Dyn, Dyn] -> Matrix[I64, Dyn, Dyn]
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
tensor.same-length : Option[I64] -> Option[I64] -> Option[I64]

# Evaluate an expression; a trap when it is made only of fills, whose
# length is unknown.
realize : TensorExpr[n] -> Vector[F64, n]
tensor.realized-length : TensorExpr[n] -> I64
rec graph.size : TensorExpr[n] -> I64

# Constant folding: combine constants and nested scalings.
rec graph.constant-fold : TensorExpr[n] -> TensorExpr[n]
tensor.test-te : TensorExpr[2] -> TensorExpr[2]
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
tint.test-t2 : Option[TInt[2]] -> Option[TInt[2]]
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
simd.test-v4 : Vec[4, F64] -> Vec[4, F64]
simd.test-ov4 : Option[Vec[4, F64]] -> Option[Vec[4, F64]]
simd.test-i4 : Vec[4, I32] -> Vec[4, I32]
simd.test-iv8 : Vec[8, I64] -> Vec[8, I64]
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
