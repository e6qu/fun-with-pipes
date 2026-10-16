# Memory ownership and efficient native execution

A program needs memory for values that outlive a single calculation. An **owner**
is responsible for keeping such storage alive. **Borrowing** uses a value while
an existing owner keeps it alive. An **alias** is another reference to the same
storage. These are compiler/runtime concepts; fwp code still uses immutable values
and ordinary pipes.

This guide states the implemented memory contract. The [primitive tables](primitive-ownership.md)
give per-operation details, [benchmarks](benchmarks.md) distinguish memory savings
from speed, and [delivery history](roadmap-history.md) records accepted tests.

Caught I/O errors must own their kind string, message string and record just like
ordinary returned values. Error construction now protects each completed string
while allocating the next field and transfers the completed record to the handler.
A previous runtime path left all three counts at zero and retained 64 charged bytes
per small caught error when tracing was disabled. Repeated-catch and injected
allocation-failure probes cover this repair, with accepted filesystem ownership
evidence in [PR #147](roadmap-history.md#numerical-precision-and-filesystem-ownership-pr-147).

## Direction

The [project plan](../PLAN.md#memory-direction) targets removal of tracing GC,
with compile-time ownership, moves and borrowing as the normal way to manage
lifetimes. ARC is reserved for necessary shared ownership. Counted allocation
alone is not the desired endpoint: unshared values should avoid count traffic,
and eligible abstractions should compile away. The contracts below describe
what exists today; they do not claim this objective is already achieved.

## Stable language behavior

Optimization must preserve results, external actions, evaluation order, failures
and trap messages. Updating a uniquely owned buffer internally must not change an
older value still visible through an alias. Files must remain open for their
original language lifetime even if the optimizer inlines or removes calls.

Derivative recording has observable ordering requirements despite its pure public
types. The optimizer must not duplicate or move tape operations in ways that alter
the recording. Arithmetic remains checked; floating-point operations retain their
specified order and precision.

## Existing implementation

There are three different claims to keep separate:

| Mode or setting | What it provides | What it does not prove |
|---|---|---|
| Default native tracing mode | Reference counting for proved owners, plus tracing collection for shared graphs | Every object is freed immediately |
| `--gc arc` | Compile-time checks for the supported automatic-reference-counting subset; tracing code is excluded | Every fwp program is supported, or allocations disappear |
| `FWP_GC=off` | Turns collection off in a tracing build, useful as a test control | Values have complete ownership or memory use stays bounded |

`--memory static` provides a bounded memory pool. It does not mean that every
value has a statically known lifetime. WebAssembly and native libraries release
typed counted owners but retain unproved shared graphs: they cannot scan arbitrary
host roots. Checked ARC admits native executables, synchronous WASI executables,
and C libraries with checked copying boundaries, described below.

The compiler first tries to eliminate temporary objects, keep fields as scalars,
and place eligible values on the stack. Values that still need shared storage
use typed reference counts where their lifetime is proved. A count reaching zero
releases typed children and eligible storage. Counts above 254 use an auxiliary
exact count; they do not automatically become permanently shared. Count overflow
traps. Unproved runtime sharing still uses tracing.

| Value family | Current representation or ownership | Important boundary |
|---|---|---|
| Small scalars and empty variants | Inline words or concrete C scalars | Bits resembling addresses remain numbers |
| Records and variants | Separate fields, C structs, stack values or counted heap objects | Whole-value uses and unknown calls can require boxing |
| I128/U128 | Direct wide values in eligible workers; counted 16-byte boxes at generic boundaries | Containers and closures can still box |
| Arrays, maps and sets | Typed elements, counted storage, selected unique updates | Callback and alias contracts must be proved |
| Strings and bytes | Counted leaves for proved copies/aliases | Unmodeled result families remain shared |
| Closures | Owned captured arguments and typed call metadata | Retained unknown callbacks are not checked ARC |
| Tasks and channels | Counted handles/results/queues; ARC admits channels whose payloads contain no functions, tasks or channels | Mutable cycles are not automatically broken by counting |
| Derivative tapes | Scoped owners and a bounded numeric workspace | Raw unscoped tape calls are not checked ARC |
| External/network state | Explicit resource teardown where modeled | Freeing a C buffer does not prove the lifetime of every referenced fwp value |

Fresh numeric result trees also need ownership before their first reference
can be released. Native heap allocations already have an empty count slot;
WASI allocations acquire their external slot when claimed. Native libraries use
the native allocator even though they do not scan host roots.
Generated ownership helpers distinguish those cases. An absent external slot is
not proof that a freshly allocated wide integer is immortal. Physical storage
checks and a control restoring that mistaken early return cover this boundary.

## Ownership boundaries

A boundary is a call where ownership crosses between compiled code and a runtime,
foreign function or remote service. Every contract distinguishes:

- **Borrow:** read a value for this call while its caller remains responsible.
- **Consume:** take an owned reference; the callee releases it or transfers it on.
- **Retain:** acquire an additional reference that can outlive the call.
- **Fresh result:** return newly owned storage.
- **Alias result:** return existing storage with an independently valid owner.
- **Runtime sharing:** place a graph under the tracing lifetime policy because
  complete counted ownership is not proved.

A borrowed callback input cannot simply become an owned output. An escaping view
must retain its backing buffer. Copies of containers retain their selected
pointer-bearing elements; scalar elements need no reference operations.

Failure cleanup is part of each contract. Registered owners are released in
reverse acquisition order before a failure, trap or cancellation invalidates the
stack frame. A catching handler bounds that cleanup; each task has its own chain.
Successful transfer removes the registration without releasing the transferred
owner. Partially constructed records, callback arguments and decoder results
must protect every acquired child until transfer succeeds.

Counting cannot reclaim an unreachable cycle by itself. For example, a channel
can contain a queued value holding that same channel. Closing it must preserve
queued values for later receives. Explicit draining breaks the tested cycle;
losing the last external handle without draining does not. Unproved cycles need
tracing and are rejected by checked ARC.

Checked ARC admits channels carrying data such as numbers, strings, records and
recursive immutable lists or variants. Their payload type must contain no
functions, tasks or channel handles, even inside another container. A function
or task can capture the sending channel and form a cycle without mentioning it
in its result type; the check therefore examines the complete payload type.
This is a conservative eligibility rule, not a ban on ordinary tracing channels.
Closing an admitted channel still preserves queued messages for receiving.
Releasing its last owner destroys the remaining queue and its typed contents;
cancelled blocked operations release their wait registrations and owners first.

## Ownership contract checks

The tests inventory declarations, resolved runtime symbols and
aliases against the recorded baseline. They check argument/result modes,
callbacks, retention, teardown and cycle policy. A count of inventoried functions
is not a count of freed objects or fixed bugs.

The inventory, reference-count pass and C wrappers must agree. Tests also cover
aliases, scalar bits resembling addresses, cleanup on nonlocal exit, resource
lifetimes and cycles. Unknown calls remain explicit sharing boundaries. The
[accepted evidence](roadmap-history.md) records platform runs; a skipped test is
not support for that platform.

## Value decoders

A decoder turns encoded bytes or text into ordinary language values. The current
preparation gives balanced-ternary conversions, URL/form decoding and HTTP-head
parsing explicit owners for their results. Complete and partial results must be
released without relying on a later collection.

The decoder subset passes focused checks on all six native hosts at `30399066`
(`38886033175`). Actual WASI checks cover its available ternary/text helpers at
`72321a55` (`38884843627`). These focused results precede the combined batch's
full production acceptance; the [handoff](development-state.md) records current
validation. [Earlier allocation evidence](measurements/value-decoders-2026-10-16.json)
retains the six-host ternary/text counts and the neighboring Windows failures
that were subsequently repaired.

Compressed bytes and WebSocket frames are also decoding boundaries. Their native
implementation owns copied bytes/text and result wrappers, including malformed
input results. Compression encoders protect native output buffers if language
result allocation traps. Tests count native buffers separately from managed
storage and deliberately omit cleanup to check detection. This covers synchronous
conversion of bytes already in memory; socket, server and retained-callback
lifetimes remain separate work. These helpers are unavailable on WASI.

Ternary list conversions traverse borrowed inputs directly and build owned
lists. Packing writes the result bytes directly. Partial lists have cleanup if
node allocation fails. Counts remain bounded by the available input bytes;
invalid widths and oversized digit lists retain their existing optional results.

URL decoding protects its temporary byte buffer and completed result fields
until the outer optional value owns them. HTTP parsing copies names/values into
owned header pairs and lists, without temporary line-index or value arrays.
It reads headers from last to first while prepending them, preserving source
order and the existing single invalid-header error. Parse rejection and allocation
failure release completed fields and buffers. Input text stays borrowed and
unchanged. Asynchronous connection lifetimes and retained callbacks remain
separate work; owning a decoded message does not prove those boundaries safe.

## Representation and numerics

Use the least costly representation that preserves behavior. A large dynamic
matrix can appropriately use a reusable heap buffer. Putting everything on the
stack is not an objective. Register spills are ordinary compiler decisions,
not an alternative memory mode.

Natural alignment means an address meets the requirement of its element type.
It does not promise cache-line alignment or a SIMD instruction (one instruction
operating on several numbers). Padding every small value to a cache line can
waste memory. Layout, cache behavior and speed need workload-specific evidence.

Floating-point storage and binary transport preserve bits. Arithmetic rounding
is a separate contract: [float formats](float-formats.md) specifies software-format
NaN handling and precision; host F32/F64 arithmetic can have target-dependent
NaN payload choices. Compare NaN classification separately from raw transport
payloads. No optimization may silently reassociate operations or combine a
multiply/add into one differently rounded operation.

### Accepted numeric representation

Direct numeric workers are specialized functions with concrete C parameters,
results and record fields. Their generic entry points convert between those
values and `V` words/boxes without changing bits. The platform's C calling
convention chooses registers or caller-provided return storage. For example,
three F64 fields can use floating-point registers on ARM64 while a 24-byte
return uses caller storage on AMD64. Inspect emitted code for the target before
making a register-placement claim.

Numeric arrays have an eight-byte length header and descriptors outside the
payload. Element sizes are:

| Types | Bytes per element |
|---|---|
| I8/U8 | 1 |
| I16/U16/F16/BF16 | 2 |
| I32/U32/F32 | 4 |
| I64/U64/F64 | 8 |
| F128 | 16 |

Pointer-bearing elements and boxed wide integers keep generic word slots and
typed destruction. F128 arrays use sixteen-byte stride at eight-byte alignment;
an escaping scalar copies its bits into an independent box. `memcpy`-based
loads/stores preserve alignment and C aliasing rules.

A numeric slice can be a view with a tagged length, byte address and retained
backing owner. Nested views retain the original backing directly. Updates copy
a view; only an owning unique array can mutate in place. Slices copy instead if
the payload is no larger than the 24-byte view header or less than one quarter
of the backing length. This avoids retaining a large array for a tiny result.
Pointer/resource-element slices always copy to preserve disposal order.

`FWP_TYPED_ABI=0` and `FWP_PACKED_ARRAYS=0` select older representations for
controlled experiments. They are comparison controls, not recommended settings.
F128 stride remains sixteen bytes even with narrow packing disabled.

Fusion combines collection stages into one loop. Eager stages may interleave
only when they are pure, terminate and cannot change which trap message appears.
An early-stopping `find` needs nontrapping stages. Keep the
[distinct-trap](../tests/run/fusion_traps.fwp) and
[early-stop](../tests/run/fusion_find_trap.fwp) tests when changing those rules.

## Evidence required

For semantic changes, compare native execution against the unoptimized interpreter,
including effects and failures. Memory changes need tracing stress/verification,
reuse verification, aliases, exceptional exits and deliberate omitted-cleanup
controls. A deliberate omission should make the test fail; otherwise a successful
run may not be measuring reclamation at all.

For performance, name the baseline and compare equivalent inputs/results. Record
hardware, compiler versions, flags, timing scope, allocations, peak live storage,
reference operations and collection activity. Separate kernel-only time from
construction/cleanup and whole-process time. Reserved address space and process
resident memory are different from live value bytes. See [benchmarks](benchmarks.md).
Run full gates and measurements on GitHub runners under the repository work rules.

## Merged ownership boundaries

The supported families include typed arrays/maps/sets, selected string/byte
results, synchronous list callbacks, owned closure captures, task results,
scoped state, decoded trees, CLI arguments and scoped derivative recording.
Their exact borrow/consume/result contracts live in
[primitive ownership](primitive-ownership.md), avoiding a second competing list.

The runtime also protects resource/network contexts during normal and exceptional
teardown. This does not admit every network graph into ARC. Container ownership
and freeing temporary transport buffers are narrower claims than proving every
retained external callback or connection context.

## Ownership coverage

Checked ARC admits immutable retained-task graphs whose captures and results have
proved owners. Scheduler, scope and caller each hold their own references;
repeated awaits return separate result owners. Child tasks start fresh state and
derivative scopes, so a parent's scope proof cannot be inherited across spawn.
Captures may point to older tasks, but the admitted subset cannot publish a raw
mutable back-edge through channels, pointers or unknown callbacks.

The compiler checks lowered temporary types as well as source types. Declaring
a user primitive with a familiar runtime symbol does not grant it the standard
library's checked ownership contract.

## Original resource semantics

`File` is **affine**: it may be used at most once unless an operation explicitly
returns it for further use. It has no duplication trait. A file parameter stays
alive until its original function frame exits, even if ignored. Closing it early
could change later IO failures. Internal resource-region markers preserve that
lifetime through inlining and fusion. Partially matched values keep already bound
resources alive until the same original boundary.

File headers count logical owners independently of ordinary collector slots.
The last owner closes the stream; explicit close and teardown are safe to repeat.
Constructor failures protect the raw stream until registration succeeds. Releasing
an unshared header removes its library finalizer before freeing storage.
`FWP_FREE=0` can keep ordinary storage for comparison while resource ownership
still closes streams. Resource lifetime and physical storage lifetime are distinct.

### UDP socket owners

A UDP socket owns an operating-system descriptor: a handle used to send and
receive datagrams. Unlike `File`, a socket can be copied and captured by a
function. Copies refer to the same socket. Explicit `udp.close` closes it for
all copies, and releasing its final owner also closes it. A closure, record or
suspended task that holds the socket must keep it alive until its own original
scope ends. Returning only an address string does not keep the socket alive.

The UDP implementation preserves those original scopes before optimization,
uses a separate 64-bit logical owner count for descriptors, and owns both fields of a
received `(Bytes, String)` pair while constructing it. The socket count is aligned
in the common header. The following TCP/TLS preparation keeps UDP headers the same
size while giving stream handles a separate TLS field when needed. Failure releases completed
fields and receive scratch storage. Closing a Linux descriptor wakes its waiting
tasks and releases its polling records; synchronization after wake does not
recreate a closed descriptor's record. Disabling physical frees still closes the
socket when its logical owners finish. Library teardown closes retained sockets
without taking ownership of host sockets.

All six focused native jobs and both shared-runtime WASI regression jobs pass;
[the UDP report](measurements/udp-ownership-2026-10-16.json) retains the exact
results and an ARM64 binary inspection. Full combined production acceptance is
still required. This does not establish whole-language GC removal. Opaque
function types do not describe their captures, so programs using UDP currently
preserve possible closure-holder frames conservatively. This may prevent some
optimizations; there is no zero-cost or throughput claim. Tracing programs retain
weak finalizers for unproved sharing, while checked ARC must prove ownership and
exclude tracing from its binary. TCP/TLS ownership, arbitrary retained callbacks
and mutable cycles remain separate work.

### TCP and TLS socket preparation

The next preparation extends logical socket owners to TCP connections and
listeners. Copies share a handle; explicit close affects every copy, while the
last owner closes the socket automatically. Function and task captures preserve
the original lifetime. Returned optional connections, bytes and certificate text
keep their partially built values alive and release them on allocation failure.

For example, the following helper returns an address string. `()` is the unit
value, used when there is no input data. `const` makes a function that ignores
that input and returns the address text. Port `0` asks the operating system to
choose an unused port. Each `|` passes the previous result to the next function.

```fwp
address : () -> String ! {Network, Error[IoError]}
address = const "127.0.0.1:0" | tcp.listen | tcp.local-addr
```

The type says that `address` takes unit, returns a `String`, uses the network,
and can report an `IoError`. It creates a listener and returns its address.
The listener belongs to that helper's scope, so returning the string releases
it; the string itself does not keep a port open. In contrast, returning a
function that captures the listener keeps it open while that function lives.
The native tests compare both cases with the interpreter, including rebinding
the same port. For an application that needs a persistent listener, return or
retain the listener itself instead of only its address.

The common socket header stores a descriptor, a kind and a 64-bit owner count.
UDP and programs without TLS keep the previous header size. In a TLS-enabled
program, a stream handle adds a pointer to the TLS session or listener context;
that pointer follows the common header in the same allocation. This costs one
additional pointer for those stream handles, without a separate allocation for
the count. The passing ARM64 macOS TLS executable requests a 24-byte stream
header: the count is at byte offset 8, and the TLS pointer is at byte offset 16.
The plain TCP executable requests 16 bytes. These sizes describe the handle,
not all memory used by the allocator, operating system or OpenSSL. [The TCP/TLS report](measurements/tcp-tls-ownership-2026-10-16.json) records
passing focused checks on all six native targets and actual WASI shared-runtime
regressions. Full combined production acceptance is still required.

ARC executables omit the finalizer-table lookup during socket release because
they never register these sockets in that table. Tracing programs and unloadable
libraries keep the lookup so they cannot later finalize reused storage. This
removes a specific unnecessary operation; it does not remove all count or
allocator metadata costs. This is preparation, not accepted TCP/TLS support
without tracing.

## Checked ARC delivery

`fwp build --gc arc` excludes tracing code and rejects unsupported ownership.
Supported native entries include `main`, exported function executables and CLI
commands and native C libraries with copied inputs and pointer-free results.
Each entry starts without assuming an existing state or derivative scope.
Synchronous WASI main/function/CLI entries also use these checks. Browser,
asynchronous WASI host tasks, remote calls and service entry points remain
outside this mode. Focused checks and final delivery acceptance are distinguished
in [the handoff](development-state.md).

WASI supplies standard streams and file access to a WebAssembly module. Build a
supported program with `fwp build --gc arc --target wasm32-wasi app.fwp -o app.wasm`
using the [WASI toolchain](reference.md#targets). Its counted values use the
existing external count table and typed destruction; this still costs metadata,
lookups and allocations. A count reaching its last owner removes the table entry
and frees the storage. A counted value escaping to permanent shared retention
traps instead of silently leaking. Requests to enable tracing or retained-storage
verification are rejected, just as in native ARC.

Actual WASI O1/O2 checks compare raw interpretation with repeated collections,
closures, text reads, caught failures and scoped/nested derivatives. They observe
physical libc allocations independently of count metadata, after the runtime's
ordinary shutdown hooks. Omitting object frees or derivative-cache shutdown must
fail. Function and CLI modules are also inspected for absent tracing functions.
This checks fwp storage inside the module; the WebAssembly host manages its own
runtime separately. Native-library flags combined with a WebAssembly target are
rejected instead of silently building a native library.

For a static or shared C library, scalar inputs are copied by value and string
inputs are copied into owned language storage during the call. Records can
contain these input types. Results must be scalars or records of scalars: C
receives all their bits before the temporary language value is released.
Returned strings and raw pointers are rejected because the current ABI (the C
calling convention and generated declarations) has no way for the host to
release managed storage. Each exported function is checked independently, even
if another export uses it under a state or derivative handler. Serialize host
calls and finish them before unloading; concurrent host entry is not supported
by this contract. The generated header states these obligations.

This extends the existing copying ABI without introducing a handle or release
wrapper. Ordinary tracing libraries keep their existing behavior. Proving these
boundaries does not make every library eligible for ARC, or eliminate the
necessary copy of a string that the host can later change.

List transposition also has a checked copying contract. It creates new list
nodes, retains the original elements as typed aliases and releases temporary
row cursors and completed-column storage. Scratch space grows with the number
of rows plus columns, without copying every input row into an array. A failure
during a retain or list-node construction releases the
partial column and completed columns. This closes the ownership gap in the
general matrix multiplication path as well as direct `list.transpose` calls.
The original input is unchanged, and ragged rows still stop at the shortest row.

Console input, process arguments and environment lookups have explicit
copied-result ownership.
`read-all` owns its input buffer until conversion to a string completes;
`read-line` protects that string while constructing `Some`. `read-lines` releases
the complete input string after copying its lines. `lines` and `args` protect
partial lists and pending strings during construction. No returned value borrows
standard-input buffers or the process argument array. Invalid UTF-8 replacement,
CRLF handling and end-of-input behavior remain unchanged. Environment lookups
copy the value before the process setting can change; embedded zero bytes in a
name return `None`, matching the interpreter instead of looking up a prefix.
Directory and environment snapshots now own their copied strings, pairs and list
nodes through the existing protected list builder. Scratch buffers, partially
constructed results and operating-system directory/environment handles are released
on success and failure. Recursive directory creation releases its temporary path
buffer. These contracts have passed production acceptance on all six native targets.

File-value runtime changes own metadata records and their duration fields,
protecting the duration if record construction fails. Byte reads reuse the same
buffer/stream cleanup as text reads and return a fresh leaf. Existence checks,
rename/remove, ordinary directory creation and append/byte writes borrow their
arguments. Focused tests check repeated storage release and error preservation;
all six native platforms pass, including the directory-error and composed
application regressions and full production acceptance.

The same contracts cover text shortcuts: `file.read`
returns a counted string, and `file.write-new` borrows its path and contents.
The latter creates or replaces a file; its name does not mean exclusive creation.
Both use the existing protected stream/buffer implementation. Invalid UTF-8 must
release the read buffer before raising `IoError`. Tests cover repeated reads,
embedded NUL in contents, invalid paths, write/close failures and missing owners.
The maintained `todo` and `grep` functions exercise these operations in repeated
application calls with retained results. Their functions and real command lines
passed focused checks on all six native hosts and full production acceptance in
[PR #150](https://github.com/e6qu/fun-with-pipes/pull/150).

Current-directory lookup now returns a counted string and protects its OS path
buffer until conversion finishes. It raises an explicit `IoError` of kind `cwd`
when the directory cannot be read. POSIX no longer substitutes `"."` or imposes a
4 KiB buffer. This contract passed six-host and production acceptance in #148.
Other unreviewed IO primitives remain outside checked ARC.

The six dense F64 linear-algebra primitives borrow their input arrays and return
independently owned results. Scratch pointers and partially constructed output
arrays are tracked in one stack record. Normal completion, singular-result exits
and unwinding release scratch explicitly; outputs transfer to the returned value
only after its container exists. No input retain or hidden managed workspace
owner is needed. QR checks its square output size separately from input shape.
See [numerical storage costs](numerics.md#dense-f64-solvers) and
[accepted solver evidence](roadmap-history.md#numerical-precision-and-filesystem-ownership-pr-147). Native arithmetic and
iteration order are unchanged.

Scoped C calls can borrow strings/bytes and copy supported scalar/record values.
Synchronous callbacks must run on the calling task before C returns; C must copy
borrowed data before keeping it. Foreign strings are copied into owned fwp values.
Raw pointers and callbacks returning managed C addresses are rejected because
an address alone cannot prove its storage lifetime.

State operations must run under a proved handler. A returned closure does not
extend the old handler's lifetime, though it can run under a new one. The checker
tracks callback targets, captures and stored values; unknown targets are rejected.

Derivative calls likewise need a proved scope. A returned token cannot keep a
tape alive, and stale/mixed/cross-task tokens trap. F128 and nested tapes own
typed weights. Nested tapes remain protected while backward callbacks record
into an outer tape. Scope
exit, failure, cancellation and library teardown release those owners. Numeric
workspace reuse is bounded and counted separately from returned gradient arrays.

Decoded JSON/text/binary/CSV trees have typed ownership, including partially
constructed fields and displaced map values. CLI parsing owns defaults, repeated
flags, diagnostics and results. Temporary decoder scratch has its own cleanup;
freeing scratch alone would not prove ownership of the resulting tree.

Acceptance tests check physical reclamation at O1/O2 with stack placement both
on and off, inspect native symbols/instructions for absent tracing, and require
missing-free controls to fail. ARC still needs allocator metadata and can retain
reusable pages. It promises neither zero allocation overhead nor immediate return
of every page to the operating system.

Empty maps and sets use immutable static storage. Their explicit static-result
contract permits checked ARC without allocating an owner or changing a reference
count. Inserting into an empty value allocates an ordinary typed container;
other aliases still see the empty value. The repeated directory-report test
checks empty map/set aliases, insertion, removal back to empty and full cleanup
alongside the maintained application in both memory modes.

Boolean `not`, `and` and `or` borrow their immediate Boolean arguments and
return an immediate Boolean tag; none needs storage or reference counts. Their
explicit contracts admit ordinary Boolean combinations to checked ARC.

`time.monotonic` and `time.unix` return a counted Duration record whose single
field contains nanoseconds. Repeated clock reads and timestamped logs must free
those records without tracing. The clock regression compares monotonic ordering,
positive wall-clock readings and log fields with raw interpretation, checks
final ARC storage, and deliberately removes one count to verify leak detection.
Timestamps differ between executions; the test checks their format and the
remaining fields rather than requiring identical clock readings. These records
still allocate; avoiding that allocation is separate work.

Child-process calls borrow their argument strings and input for the duration of
execution. `process.run` and `process.run-input` return an owned record containing
the exit status and copied standard-output/error strings; `process.call` returns
an immediate status number. A nonzero child exit status is a result, whereas a
failure to start or communicate with the child raises `Error[IoError]` of kind
`spawn`. Arguments containing a zero byte are rejected before any OS call.

The process owner releases argument scratch, pipe endpoints and capture buffers.
It also reaps the child on POSIX and closes Windows process/thread handles. If
execution unwinds before the child finishes, cleanup terminates and waits for
that child. Captured strings stay protected while the result record is being
constructed, so a later allocation failure releases earlier copies. Inputs can
outlive the call; ownership of them is never transferred to the child. POSIX
children receive ordinary SIGPIPE handling, matching interpretation. Parent writes
block that signal only on the calling thread, consume only a newly generated
broken-pipe signal, and restore the previous mask. They preserve the host's signal
handler and any previously pending SIGPIPE, including when a child exits early.

Process regressions compare repeated raw-interpreter and native calls,
including quoted/Unicode arguments, output larger than pipe capacity and a child
that exits without reading its input. Instrumented probes force construction and
OS failures, check resource cleanup and reject deliberately missing counts or
buffer frees. These contracts passed all six focused native hosts and full
production acceptance in [PR #149](roadmap-history.md#owned-processes-and-numeric-mapped-arrays-pr-149). They do not establish ownership for
networking or arbitrary external-resource contexts. Process calls are synchronous;
this cleanup does not establish deadline or cancellation responsiveness while
waiting for a child.


Secret terminal input uses the same owned optional string as ordinary line input.
A registered cleanup restores the original echo setting before a trap leaves the
read frame. The interpreter and native runtime query real Windows console modes
and width; redirected streams continue to behave as ordinary input. Descriptor
validation happens before narrowing to the OS integer type. Terminal tests use a
real pseudo-terminal on POSIX and a private console on Windows, with a deliberately
missing restore action required to fail. Accepted platform evidence is recorded
with [PR #149](roadmap-history.md#owned-processes-and-numeric-mapped-arrays-pr-149).

## Structural hashing without temporary storage

`hash` returns a deterministic U64 fingerprint of a value's typed binary encoding.
Integer widths, floating-point bits, length prefixes and field order all contribute.
It uses FNV-1a, a non-cryptographic hash. The compiler's native implementation
borrows the input and feeds those bytes directly into the hash state, without
serializing the whole value into a temporary heap buffer. Packed array elements
remain borrowed views during the call; hashing does not retain or release them.

The interpreter's existing buffered encoding supplies an independent reference.
Native/WASI checks compare hashes across scalar widths and nested containers,
keep aliases live, count both libc and managed allocations inside hash calls,
and verify that restoring the old buffered implementation fails the zero-allocation
check. [The handoff](development-state.md) records which checks have passed; this
change alone is not a measured timing improvement or a C/Rust parity claim.

## Vector-library results

A `Vec[N, T]` currently holds an array inside a record; each array entry is a lane.
The prepared ownership path gives the result record and array one owner and
retains borrowed boxed integer lanes when they are shared. F128 arrays store their
128-bit payloads directly, so copying a lane does not retain a temporary scalar
box. Converting a correctly sized array to a vector retains that array; a wrong
length returns `None` without taking ownership. Partial arrays and wrappers are
protected until construction finishes, including arithmetic and allocation failure.

A reduction keeps one owned accumulator and releases each replaced boxed result.
A one-lane sum owns its returned reference independently of the input. These
changes preserve wrapping integer operations and existing division checks; they
do not promise stack-only vectors or hardware vector instructions. Native and
actual WASI acceptance remains tracked in the handoff until the required checks
pass. General removal of tracing remains unfinished.

## Process metrics and syntax text

The next ownership batch prepares copied metric snapshots and syntax rendering.
A metric registry stores names and numbers for a process or library instance.
Repeated updates of an existing name reuse that entry; distinct names require
more native storage. Process shutdown and library teardown free it. A snapshot
copies names and kinds into an immutable list of tuples: subsequent updates cannot
mutate an earlier snapshot. Construction now protects partial strings, tuples and list nodes,
without a temporary pointer array. This registry lifetime is separate from the
shorter lifetime of snapshot storage; it is not an allocation-free service claim.

Names use their complete byte length, including embedded NUL, matching interpreter
lookup and string sorting. Observation suffixes are compared and copied directly
without a temporary concatenated name. `syntax.show` borrows its syntax tree and
returns new text; its native formatting buffer is protected if result allocation
traps. Managed allocation fault tests, missing-cleanup controls, tracing stress,
checked ARC and actual WASI checks pass in preparation. Windows and POSIX library
unload tests verify registry release separately. The
[retained report](measurements/owned-values-and-kernels-2026-10-16.json) records
the artifacts and repaired test failures; the handoff tracks full acceptance.

### DNS result ownership under validation

`dns.resolve` borrows its hostname and returns an owned list of copied address
strings. The native implementation releases the operating system's temporary
resolver entries on success and on recoverable allocation failure, and owns each
partially built list. It preserves first-seen order and removes duplicate address
strings without the previous 64-address cutoff. Both engines reject embedded NUL
bytes instead of passing a shortened hostname to the operating system.

The DNS tests compare real numeric and localhost lookups, then use a deterministic
resolver peer to check 81 distinct addresses and every result-allocation failure.
[DNS evidence](measurements/dns-ownership-2026-10-16.json) records six native
hosts passing, including 162 allocation-failure positions and deliberate omitted
cleanup. Both actual WASI jobs pass common-helper regressions; they do not test
DNS. The earlier owned-values/kernel report does not cover DNS. Retained
networking callbacks still need separate ownership work. This does not add WASI networking or prove faster DNS lookups.

TCP/UDP receive scratch and UDP-send resolver entries are also registered on the
runtime cleanup stack so cancellation and result-allocation failure can release
them. Failed native receive allocation traps before the buffer is used. These
repairs pass all six focused native hosts in `38898918147` at `7224b3de` and do
not establish socket-handle ownership; the separate socket rules and acceptance
above cover handles.

### Copied service data

A served request carries headers (name/value strings) and may identify a peer
certificate. `grpc.metadata` returns an independent list of incoming headers;
`grpc.peer-subject` returns copied certificate text when available. The combined
preparation gives these output values ordinary owners and releases partially
copied fields if construction fails. Metadata preserves the input order and
duplicate names while omitting protocol headers; it builds directly into the
result list without a temporary array of pointers.

This does not establish ownership of the service's callbacks, connection,
stream or retained request context. Those remain separate work. The preparation
handoff records focused checks; full service execution without tracing has not
been established by these result-copy changes.

The same preparation gives `http2.request` and `http2.body` owned results.
A request copies its method, path, headers, remote address and optional certificate
name; a body copies every byte, including zero and non-text bytes. The source
stream remains live during copying. Header order and duplicates are preserved,
and an existing `host` header takes precedence over `:authority`. Partial strings,
pairs, lists and result wrappers use the existing typed cleanup on failure.
These changes do not yet own the stream itself or remove tracing from a server.
These copied results pass focused allocation-failure and lifetime checks on all
six native hosts at `e715de1a` (`38935341434`). Full delivery acceptance remains
separate; see the [handoff](development-state.md).

Outgoing gRPC response headers and trailers also copy their input strings.
Normalization now happens in the owned copy: names become lowercase, and carriage
returns/newlines in values become spaces. This removes two temporary buffers
without changing input strings. The protocol layer now checks raw header
allocations and buffer-size growth before using them. Failed header construction
preserves earlier entries and frees its partial new strings; impossible sizes
and allocation failure retain the existing exit status 102. This is a bounded
allocation check, not a claim that protocol allocation failures can be recovered
inside a running service. Native controls pass on all six hosts in the same
focused run. Response-header capture also checks its own allocation: failure
traps before invoking the callback or installing the new context. Existing child
task, cancellation and counter-overflow tests remain active.

The [service-result report](measurements/service-values-2026-10-16.json) records
12 incoming-metadata, 2 certificate-name, 20 request and 2 body allocation-failure
points, each returning charged result storage to its baseline with collection
disabled. Raw protocol buffers are counted separately. Returned values still
allocate and typed cleanup uses stack records; this is cleanup evidence, not a
speed comparison or a measurement of total server memory.

Each partial-result cleanup record occupies 184 bytes, aligned to eight bytes,
on all six measured hosts. It keeps up to eight field values inline on the stack.
The instrumented ARM64 metadata, certificate, request and body functions use
448, 272, 624 and 288-byte stack frames respectively, including saved registers.
These are test-binary observations, not bounds on an ordinary server's total
stack use. The report retains the instructions used to read those sizes.

### Service settings and outgoing headers: under validation

Helpers such as `grpc.with-gzip` and `grpc.with-metadata` run a callback with
temporary settings for its service calls. The settings must stay valid while
the callback runs, and a child task must keep its inherited settings after that
callback returns. See [service scopes](services.md#settings-for-a-group-of-calls)
for the language-level examples.

The [baseline](measurements/service-context-baseline-2026-10-16.json) compares
repeated scopes with plain fwp state updates on Linux AMD64 at `-O2`. Every call
increments the same state. The table shows the extra managed allocation cost
per call, calculated from the difference between 32 and 128 calls, with
collection disabled:

| Scope | Extra allocation requests | Extra requested bytes | Extra bytes still charged after return |
|---|---:|---:|---:|
| Compression setting | 1 | 64 | 64 |
| Deadline setting | 1 | 64 | 64 |
| One outgoing header | 5 | 128 | 144 |
| Response-header capture | 4 | 120 | 112 |

Requested bytes are the sizes passed to the managed allocator. Charged bytes
reflect its accounting, including size rounding and explicit releases. These
counts exclude raw TLS/capture allocations, allocator pages and total process
memory. They compare two fwp programs, not fwp with C or Rust, and do not measure
speed. The report preserves the source revision, inputs and binaries; the old
run did not record the exact CPU model or C compiler version.

The new preparation keeps scope settings on the stack and stores a child's
copy inside its task allocation. This enlarges service tasks; it does not add
that field to programs without service support. Synchronous scopes borrow
existing TLS/capture owners rather than incrementing their counts. Outgoing
headers use one owned block for their pointer table and copied text. Children
share that block only when they inherit it; otherwise it is freed when the
scope ends. Empty or ignored header lists borrow the previous settings.

These changes still need the native checks listed in the [handoff](development-state.md).
Checks cover size overflow, allocation failure, source aliases, nested scopes,
parent failure/cancellation and child cleanup, with deliberate broken controls.
Measurements must include the larger task layout and remaining allocations.
The callback-result changes below still need verification. Connections and
streams need further ownership work. The preparation does not admit an entire
service to checked ARC.

The following callback-result change is also under validation. Service scopes
borrow their callback function while it runs and take ownership of the value it
returns. Response capture constructs an owned tuple containing that result and
copied header pairs. It builds the list backwards to preserve header order
without a temporary pointer array. Cleanup protects the callback result before
copying headers, so allocation failure releases every completed field.

The new `service_scope_ownership` checks compare raw/optimized interpretation
with native execution in tracing and checked ARC modes, including strings shared
with the caller and functions returned inside tuples. They disable collection
to check final charged storage, deliberately remove borrowing/partial cleanup,
and inspect ARC binaries for tracing functions. These checks are prepared, not
yet passing evidence. Checked ARC admission of these synchronous scopes does
not admit remote calls, server entry points or unproved retained request contexts.

The [intermediate stack-copy measurements](measurements/service-context-stack-2026-10-16.json)
show the tradeoff before the packed-header and callback changes: repeated gzip
and deadline scopes add no managed allocation relative to plain state updates
on any of the six native hosts. The Linux AMD64 service task grows from 1,512 to
1,576 bytes because it carries an inherited settings copy. This is a per-task
cost; the removed 64-byte allocation was paid on every scope call. The report
records all task sizes and alignments. Inspected ARM64/AMD64 instructions copy
the settings directly to stack storage. These are memory counts and instrumented
binaries, not a speed comparison. Separate Windows lifetime fixtures failed to
compile in that intermediate run, so it does not establish full Windows acceptance.

The prepared service-context batch also protects temporary message-decoding
bytes when construction of the returned value traps, and protects the same
temporary storage when decoding served request arguments. Tests cover successful and
malformed messages, tagged error results and deliberate omission of cleanup.
This repair remains under CI verification; service streams and remote result
caches still need separate lifetime contracts.

### What remains before remote calls can use ARC

A lazy stream receives an element only when the program asks for it. fwp caches
that element so asking through another reference to the same position does not
receive a second message. The cache can hold both a value and the next stream
position. Owning the copied result alone therefore does not settle the lifetime
of the stream, its connection or the task receiving messages.

The next service-memory work must establish these facts before removing its
current collector requirement:

| Work | Evidence required |
|---|---|
| Measure repeated calls and stream consumption | Count live connection, stream, message and cached-value storage for 1, 32 and 128 elements, including full consumption, early stop and retained earlier positions. Separate reusable connection-pool storage from per-call growth. |
| Own each cached result | Repeated reads return the same value without receiving again. Releasing one iterator preserves other references; releasing the last reference releases its cached value and continuation. Partially constructed results release on failure. |
| Keep connections and requests alive for their users | Sending, receiving and detached tasks remain valid after their creating scope returns. Completion, failure and cancellation release each acquired owner exactly once. |
| Prevent ownership cycles | Identify which component owns each task, stream and connection. A pointer back to an owner must not silently become another owning reference. Any shared cycle needs an explicit policy and a test that drops every external reference. |
| Admit supported remote calls without tracing | Compare interpreter/native values, errors and receive order; run stress and deliberate missing-cleanup controls; inspect actual binaries and repeat calls with collection disabled. |

These are acceptance requirements, not implemented stream ownership. Keep the
ordinary immutable iterator behavior and existing syntax while proving them.
HTTP/2 server operations and GPU resource ownership also remain separate work.
