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

A decoder turns encoded bytes or text into ordinary language values.
Balanced-ternary conversions, URL/form decoding and HTTP-head parsing have
explicit owners for their results. Complete and partial results must be
released without relying on a later collection.

The decoder subset passes focused checks on all six native hosts at `30399066`
(`38886033175`). Actual WASI checks cover its available ternary/text helpers at
`72321a55` (`38884843627`). These focused results precede the combined batch accepted in
[PR #153](roadmap-history.md#owned-decoded-values-and-network-resources-pr-153). [Earlier allocation evidence](measurements/value-decoders-2026-10-16.json)
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
in the common header. TCP/TLS stream handles keep UDP headers the same
size while giving stream handles a separate TLS field when needed. Failure releases completed
fields and receive scratch storage. Closing a Linux descriptor wakes its waiting
tasks and releases its polling records; synchronization after wake does not
recreate a closed descriptor's record. Disabling physical frees still closes the
socket when its logical owners finish. Library teardown closes retained sockets
without taking ownership of host sockets.

All six focused native jobs and both shared-runtime WASI regression jobs pass;
[the UDP report](measurements/udp-ownership-2026-10-16.json) retains the exact
results and an ARM64 binary inspection. [PR #153](roadmap-history.md#owned-decoded-values-and-network-resources-pr-153)
supplies the passing full production acceptance. This does not establish whole-language GC removal. Opaque
function types do not describe their captures, so programs using UDP currently
preserve possible closure-holder frames conservatively. This may prevent some
optimizations; there is no zero-cost or throughput claim. Tracing programs retain
weak finalizers for unproved sharing, while checked ARC must prove ownership and
exclude tracing from its binary. Whole-service ownership, arbitrary retained
callbacks and mutable cycles remain separate work.

### TCP and TLS socket owners

TCP connections and listeners have logical socket owners. Copies share a handle; explicit close affects every copy, while the
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
regressions. [PR #153](roadmap-history.md#owned-decoded-values-and-network-resources-pr-153)
records full production acceptance on the final combined revision.

ARC executables omit the finalizer-table lookup during socket release because
they never register these sockets in that table. Tracing programs and unloadable
libraries keep the lookup so they cannot later finalize reused storage. This
removes a specific unnecessary operation; it does not remove all count or
allocator metadata costs. These socket owners support checked ARC; remote
service graphs still require separate ownership work.

## Releasing long chains

An owner must release a value's children when its last reference disappears.
For a long sequence, recursively calling one cleanup function per node can
exhaust the machine stack even when there is enough heap memory. Ordinary lists
already use a cleanup loop. The compiler now also follows a final owned field
through records and variants with one nonempty constructor, such as `Option`,
when that path returns to the starting type. `Option` represents either no value
or one present value; a tuple can hold both a payload and the next node.

At every wrapper, a remaining alias stops destruction of its children. Releasing
the final alias later resumes ordinary typed cleanup. The compiler emits these
steps directly, without a heap work list. This covers the measured record →
optional value → next record and record → optional value → tuple → next record
paths. It does not make every branching recursive graph use constant stack space.
Existing direct list-tail handling and `FWP_FREE=0` count-only behavior remain.

[The six-platform comparison](benchmarks.md#stack-use-when-releasing-wrapped-chains)
checks up to 16,384 links, retained aliases at each wrapper and complete physical
reclamation without tracing. Real source programs match the interpreter and
also pass GC/reuse stress. Full delivery acceptance remains in the handoff.
Reference-count operations and the chain's allocations still exist. Native remote
stream caches use a separate runtime cleanup loop, described below; their
connection and callback graph still depends on tracing.

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
The native ownership path gives the result record and array one owner and
retains borrowed boxed integer lanes when they are shared. F128 arrays store their
128-bit payloads directly, so copying a lane does not retain a temporary scalar
box. Converting a correctly sized array to a vector retains that array; a wrong
length returns `None` without taking ownership. Partial arrays and wrappers are
protected until construction finishes, including arithmetic and allocation failure.

A reduction keeps one owned accumulator and releases each replaced boxed result.
A one-lane sum owns its returned reference independently of the input. These
changes preserve wrapping integer operations and existing division checks; they
do not promise stack-only vectors or hardware vector instructions. General
removal of tracing remains unfinished; checked ARC deployment limits still apply.

## Process metrics and syntax text

Metric snapshots and rendered syntax text have explicit value owners.
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
checked ARC and actual WASI checks pass. Windows and POSIX library
unload tests verify registry release separately. The
[retained report](measurements/owned-values-and-kernels-2026-10-16.json) records
the artifacts and repaired test failures.
[PR #153](roadmap-history.md#owned-decoded-values-and-network-resources-pr-153)
records full production acceptance.

### DNS result ownership

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
`grpc.peer-subject` returns copied certificate text when available. These output
values have ordinary owners, with cleanup for partially
copied fields if construction fails. Metadata preserves the input order and
duplicate names while omitting protocol headers; it builds directly into the
result list without a temporary array of pointers.

This does not establish ownership of the service's callbacks, connection,
stream or retained request context. Those remain separate work; these accepted
result-copy changes do not establish full service execution without tracing.

`http2.request` and `http2.body` also return owned results.
A request copies its method, path, headers, remote address and optional certificate
name; a body copies every byte, including zero and non-text bytes. The source
stream remains live during copying. Header order and duplicates are preserved,
and an existing `host` header takes precedence over `:authority`. Partial strings,
pairs, lists and result wrappers use the existing typed cleanup on failure.
These changes do not yet own the stream itself or remove tracing from a server.
These copied results pass focused allocation-failure and lifetime checks on all
six native hosts at `e715de1a` (`38935341434`), followed by full acceptance in
[PR #153](roadmap-history.md#owned-decoded-values-and-network-resources-pr-153).

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

### Service settings, outgoing headers and callback results

Helpers such as `grpc.with-gzip` and `grpc.with-metadata` run a callback with
temporary settings for its service calls. A callback is the function supplied
to the helper. The settings must stay valid while it runs, and a child task
must keep its inherited settings after the callback returns. See
[service scopes](services.md#settings-for-a-group-of-calls) for examples.

The [earlier baseline](measurements/service-context-baseline-2026-10-16.json)
and [owned-scope and forwarding measurements](measurements/service-context-forwarded-2026-10-16.json)
compare each service scope with plain fwp state updates at 1, 32 and 128 calls.
Every call increments the same state. These are extra costs per call, calculated
from the difference between 32 and 128 calls with collection disabled. Each
cell shows **earlier → owned scopes**:

| Scope | Allocation requests | Requested bytes | Bytes still charged after return |
|---|---:|---:|---:|
| Compression setting | 1 → 0 | 64 → 0 | 64 → 0 |
| Deadline setting | 1 → 0 | 64 → 0 | 64 → 0 |
| One outgoing header | 5 → 1 | 128 → 40 | 144 → 0 |
| Response-header capture | 4 → 1 | 120 → 24 | 112 → 0 |

The earlier numbers are Linux AMD64 only. The new numbers match on Linux,
macOS and Windows, each on ARM64 and AMD64, at source `8684127d`, with all six
focused jobs passing in `38958562126`. Empty and ignored header lists add no
per-call allocation. Requested bytes are allocator inputs; charged bytes include
size rounding and explicit releases. Fixed scheduler startup remains in the raw
rows and is excluded from the per-call difference. Raw TLS/capture allocations,
allocator pages and total process memory are outside these counts. This compares
fwp with earlier fwp, not with C or Rust, and does not measure speed.

Settings now live on the stack during a callback. A child copies them into its
existing task record. This costs space per task: the Linux AMD64 service task
grows from 1,512 bytes in the baseline to 1,584 bytes. Programs without service
support omit the settings fields. The report records all six layouts, compiler
versions, CPU details and actual ELF, Mach-O or PE binaries. The older baseline
did not record its exact CPU model or C compiler version.

Synchronous scopes borrow existing TLS/capture owners. Only independently live
children retain shared owners. Outgoing headers use one owned block for pointers
and copied text; empty or ignored lists borrow the previous settings. Overflow
is checked before allocation. Scope return, error and cancellation release
completed owners. Deliberately omitted inheritance, copying, release and child
retention must fail the tests.

The five helpers borrow their callback function and own its returned value.
Response capture builds an owned tuple with that value and copied header pairs.
It builds the list backwards to preserve order without a temporary pointer
array. Allocation failure releases every completed field. Tests compare raw and
optimized interpretation with native tracing/ARC execution, retain caller aliases
and returned functions, check typed failures, and inspect ARC binaries for
tracing functions. Capture controls cover 13/14 allocation-failure positions.
Temporary decoding bytes also release on client result and served-request traps.
These checks pass on all six native hosts at the source above. Final production
acceptance remains separate; see the [handoff](development-state.md).

A service's TLS settings, used for encrypted connections, are read from
environment variables once per runtime instance. The cache must survive tasks
and resource finalizers that still use those settings. Library teardown releases
it after both have finished. The current delivery stores each entry and its name
in one allocation instead of two, with enough room to look up complete variable
names. It removes the old 300-byte truncation. A construction guard frees an
unpublished entry if allocating the TLS settings fails, allowing a later retry.
Tests inject failure at both allocations and check long names, repeated reads
and teardown order. This reduces allocation count; allocator rounding and the
name's temporary suffix space prevent a general claim about bytes saved.

Actual Linux ARM64 instructions copy the 72-byte settings through four 16-byte
registers and one eight-byte register onto the stack. That wrapper reserves
144 stack bytes; its separate error handler reserves 464. These are instrumented
O2 observations, not a whole-program stack bound. The wrapper still calls the
callback helper, so fewer allocations do not prove that all call overhead is gone.

The earlier [owned-scope report](measurements/service-context-owned-2026-10-16.json)
still had two allocations for response capture. A forwarding function unpacked
its callback's tuple and allocated an identical tuple. The compiler now preserves
that returned owner when every return path forwards a dynamic callback result.
Aliases, failure cleanup and a deliberately reintroduced extra allocation are
checked on all six hosts. Actual O2 instructions return that owner directly in
`x0` on ARM64 and `rax` on AMD64. The forwarding function's stack use falls from
192 to 144 bytes on ARM64 and from 184 to 120 bytes on AMD64, excluding AMD64's
incoming return address. These are instrumented binary observations, not timing
measurements or whole-program stack bounds.

List `each` now avoids its discarded result list. The [current six-host report](measurements/service-context-iteration-2026-10-16.json)
at `20f0f5f0` verifies ordered calls, shared inputs, captured values and failures,
along with all the service allocation limits above. It saves one allocation and
32 requested bytes per element. The compiler makes known calls direct inside
state and service helpers without rebuilding captured lists on each iteration.
[Repeated timings and binary observations](benchmarks.md#list-iteration-compared-with-its-previous-definition)
record the improvement and the remaining state bookkeeping. Full production
acceptance is tracked separately in the handoff.

The [intermediate stack-copy report](measurements/service-context-stack-2026-10-16.json)
preserves the earlier representation tradeoff. It predates packed headers and
owned callback results, and its Windows fixtures failed before later repairs.
Whole remote calls, service entry points and retained request contexts still
need ownership work; these scope changes do not remove tracing from a server.

### What remains before remote calls can use ARC

A remote call asks another process to run a function. A streaming response lets
the caller request values one at a time. fwp saves each received value so two
references to the same iterator position observe the same result, rather than
receiving two different messages. Keeping an earlier iterator keeps its saved
history alive.

The native cache now has typed owners: cleanup knows which fields are values
that need releasing. Reading a uniquely owned position transfers its saved
result; reading a shared position acquires another result reference. Cleanup
walks the position and its wrappers in a loop, stopping when another owner
remains. The receive source moves to the next unread position. Its error
description lives in that same allocation, so a completed calling scope cannot
leave a dangling description.

One task receives a position while other readers wait for its saved result.
Completion, failure and cancellation release that guard and wake waiters.
Cancelling a waiting reader leaves the receiving task running. Cancelling the
active client call still resets its request. The guard borrows task identities
from the scheduler and adds no allocation per element.

[Complete-client measurements](benchmarks.md#moving-captured-values-instead-of-retaining-them-again)
show constant remaining managed storage across 64, 1,024 and 16,384 consumed
integers in all six native environments. Retained history deliberately increases
peak memory until released. Five allocations per integer and extra reference
counts remain; this is not a zero-cost result. The measured region excludes raw
network buffers and whole-process memory.

Repeating calls exposed a separate lifetime: the request object itself.
[The repeated-call baseline](benchmarks.md#memory-left-behind-by-repeated-remote-calls)
leaves 240 managed bytes per additional call on every native platform, plus
unread message queues for partial readers. One connection is reused throughout.
This separates finished-request growth from the cost of keeping a connection
pool available.

PR #157 gives each client request references from its active
connection list, response source and detached sender. Dropping the source
releases unread messages without cancelling the remote operation. Later data
for that abandoned reader is discarded while maintaining network flow control.
The list keeps the unfinished request alive until completion, reset or connection
failure. Final release removes the collector finalizer, frees metadata and
releases request storage. All six focused native jobs verify complete request
and message release across 1/16/256 batches, with constant final managed storage.
[The comparison](benchmarks.md#memory-left-behind-by-repeated-remote-calls) records
the remaining allocations and reduced reference-count traffic. Infinitely many unfinished operations can still require
unbounded storage. [The handoff](development-state.md) records native validation
and full delivery acceptance; implemented cleanup alone does not establish them.

The connection change separates an open socket from the information
kept about it. Each connection has two background tasks: one reads incoming
bytes and one writes outgoing bytes. These are its I/O tasks. A response reader
can still need the final error or completion information after both tasks finish,
so closing the socket does not by itself free the connection record. Its last
storage owner removes the collector's cleanup registration and frees that record
and its metadata. The pool, a cache of reusable connections, owns each connection
while it is available for another call. Calls and detached senders also keep
their own references.
The request record does not gain an owning back-pointer to the connection.

Client I/O task records have only the scheduler, which runs ready tasks, as owner.
Their storage releases after their stack and scheduler links are removed, without
task reference-count updates. Language task handles can have independent aliases and retain their
shared policy. Server and HTTP/2 task graphs still need separate ownership work.
Library teardown first shuts down connections used by live I/O tasks, then waits
for those tasks to finish. This includes connections removed from the reuse pool:
canceling a task alone is insufficient while it defers cancellation to protect
transport state. A regression test must detect omitted shutdown within a fixed
deadline, instead of hanging the test job.
All six focused native jobs verify complete connection/request/message release
and constant final managed storage across the measured call counts. The
[comparison](benchmarks.md#freeing-closed-connections-and-finished-tasks) explains
the added connection count operations and remaining allocations. PR #158 passed
full production acceptance; [history](roadmap-history.md) records its merge.

The remaining relationships need separate checks:

| Storage | Who currently keeps it alive | Work still needed |
|---|---|---|
| Client request | The active connection list, receive source and detached sender hold references. | Accepted in PR #157; preserve completion, failure, cancellation and repeated-call checks. |
| Connection | The pool, readers/writers and callers hold separate storage owners; the socket has its own reader/writer use count. | Accepted in PR #158; closing a socket alone does not finish every borrow. Preserve the lifecycle checks. |
| Pending sender values | Each input cursor has a concrete iterator destructor and an independent owner. | Accepted in PR #159; preserve cleanup, aliases, failure/cancellation and stress/reuse checks. |
| Server callbacks and response channels | Serving tasks and retained language values can outlive the creating call scope. | Prove each retained handler and channel context, including failure during construction and cycles after external references disappear. |
| Task identities and wait lists | The scheduler owns parked tasks; request state borrows their identities. | Preserve this direction when adding owners; do not turn back-pointers into owning cycles. |

A detached sender sends iterator elements as requests described by compiler
metadata. Its unused function-encoder field and branch were removed in PR #157: the sole production caller always supplies that request
description. Native fixtures record its size and test request encoding across
errors and cancellation.

The current server candidate frees its job and task records and keeps temporary
argument slots on the serving stack. The job contains the service context; its
existing context-user count owns the whole allocation. Detached senders keep it
alive after the serving task finishes. Completion clears borrowed task pointers
before releasing the job. Unscoped internal tasks have one scheduler owner and
release without task reference-count traffic; scoped tasks keep the existing
shared policy. [Six-host storage measurements](benchmarks.md#freeing-finished-server-tasks-and-keeping-argument-slots-on-the-stack)
show fewer allocations with unchanged count increments.

Concrete generated destructors now release decoded arguments, complete returned
iterators, ordinary results and errors. Stack cleanup records protect partial
decoding, method failures, encoding failures and cancellation. A method receives
its complete argument array through its owning entry, without constructing a
temporary function object. The ordinary entry remains the explicit no-reuse mode.
[Linux measurements](benchmarks.md#freeing-method-arguments-and-results-linux-measurement)
record the memory reduction and mixed count/stack costs.

A native output channel borrows each sent value only until its callback returns.
A callback that keeps a value must acquire its own typed owner. Its payload lives
after the unchanged 96-byte channel header in one allocation. Last-channel cleanup
releases request/connection references and then that allocation; construction
protects partially acquired references. Queue and callback cleanup use alternative
fields in the header, without another lookup on the send path.

The combined values/channel candidate passes Linux cleanup, alias, partial
construction, cancellation, stress/reuse and ordinary/no-reuse service comparisons.
All four workloads still grow by 240 managed bytes per call. Six-host and full
production acceptance are pending. Server requests/connections, escaped graphs
and HTTP ownership remain open; these changes do not establish remote checked ARC.

### Server request and connection ownership in preparation

A request record stores one remote call's headers, queued messages and status.
A connection record holds the socket and information shared by calls using it.
The next preparation gives these records explicit owners; production acceptance
is pending, as recorded in [the handoff](development-state.md).

While parsing incoming bytes, a temporary list owns each new request. This matters
when the same input contains both a new call and its cancellation: cancellation
can remove the request from the connection before a serving task starts. The
parser list keeps it alive, then moves its owner into the serving job. A parse
failure releases every request still in the temporary list.

Connection startup moves its owner to the reader task. The writer and each
serving job acquire separate owners because they can finish at different times.
An input iterator or output channel retained by language code also keeps its
request and connection alive. Closing the socket finishes transport activity;
the record remains available until those retained users release it. Job cleanup
clears borrowed task pointers before releasing the request and connection, so
those pointers do not keep finished tasks alive or form an owning cycle.

Native Windows testing exposed a shutdown issue: a locally shut-down socket did
not wake its parked reader through OS polling. The preparation explicitly wakes
socket waiters on shutdown and close. On polling platforms, each wait record lives
on the waiting task's stack and is removed on return or cancellation. This adds
no heap allocation or task-header field. Timeout, cancellation and two simultaneous
readers are tested separately from connection ownership.

The earlier Linux preparation finalized every request and connection, leaving
544 managed bytes after 1, 16 or 256 calls in all four measured workloads. It made
the same allocation requests as the values/channel candidate, with additional
reference-count operations for independently live owners. That result predates
the shutdown repair: cross-platform measurements and binary review must be rerun.
It does not establish complete ownership for escaped callback cycles, HTTP
handlers or remote checked ARC.

Accepted input ownership keeps two iterator nodes: the next node to read and
the node whose element is currently being encoded. This preserves the existing
order, which evaluates the next step before encoding the current element.
The current element remains borrowed from its still-owned node. The compiler
supplies the iterator's concrete destruction function in static request metadata;
there is no extra input heap object. Synchronous calls keep this cursor on their
stack; background senders embed it in their existing record.
When the node has one owner, the implementation moves its continuation into the
call and clears the old field. A shared node keeps its continuation and lends it
to the call instead. All six native hosts verify bounded remaining storage and
reduced count traffic compared with the first ownership probe; count operations
remain higher than the original version that retained storage for tracing.

A sender owns its cursor and record exclusively. The scheduler exclusively owns
its task record and releases it after stack and task-list removal. The caller's
input is borrowed at entry, so the cursor acquires a separate reference and
retained original iterators remain usable. Input references release on completion,
continuation/encoding failure and cancellation. All six focused native jobs
verify these contracts. [The comparison](benchmarks.md#input-owners-and-moves-bounded-memory-with-measured-count-costs)
records memory/count costs; [history](roadmap-history.md) records full production
acceptance in PR #159.

Request failure also differs from dropping an unused response reader. Native
input production/encoding failure and failed response-channel delivery must
reset the remote request before releasing the reader, as the interpreter does.
Ordinary response-iterator abandonment still lets the remote operation finish.
Scoped failure cleanup and deliberate missing-reset tests enforce that distinction.

Keep the cache, shared-reader and decoder failure controls while extending these
owners. Test partial construction and every last-owner case; retain deliberately
broken variants to prove that missing cleanup is detected. Before admitting
remote calls to checked ARC, compare interpreter/native values, errors and
receive order, inspect actual binaries and measure repeated calls with collection
disabled. Server/HTTP
streams and retained handlers still need tracing. HTTP/2 server operations and GPU resource ownership remain separate work.

### Moving values held by a closure

A closure is a function that keeps values for a later call. For example, `add 1`
keeps the integer `1` until it receives the number to add it to. Captured strings,
arrays or stream positions can require separate storage and owners.

The runtime transfers captured owners when consuming a closure with
exactly one owner. It copies their value words into the destination, then clears
the original closure's capture count so its cleanup cannot release them twice.
For a partial call, the destination is the new closure; for a complete call, it
is the callee's argument storage. Shared closures still acquire typed references
so that existing aliases remain valid. Scalar values are never treated as heap
references merely because their bits resemble an address.

The destination is ready before this transfer. No allocation, task suspension or
recoverable trap occurs between moving the owners and assigning responsibility
for cleanup. The callee owns its arguments on both return and failure, while
runtime cleanup still frees the consumed closure. This needs no new language
syntax or closure fields. It removes capture retains on this path, but dynamic
calls still perform dispatch, ownership checks and argument copying.

Focused controls cover unique/shared closures, partial/complete application,
normal returns, errors and traps. They require exact reclamation without
collection and deliberately restore unnecessary duplication or steal shared
captures to ensure those bugs are detected. All six native jobs pass at `afd7d460`, including native Windows stack-allocation
failure injection. [The comparison](benchmarks.md#moving-captured-values-instead-of-retaining-them-again)
records the saved retains and remaining costs.
[PR #156](roadmap-history.md#released-stream-caches-and-moved-closure-captures-pr-156)
records full production acceptance.
