# Ownership and efficient native execution

This is the development contract for the memory work in [PLAN.md](../PLAN.md).
It separates existing behavior from proposed changes. Current progress and
validation are in [development-state.md](development-state.md).

## Stable language behavior

Keep tacit, curried, data-last pipes, composition, immutable values, strong
static inference, tracked effects and checked arithmetic. Generic definitions
have explicit signatures and are specialized at compile time. Storage,
ownership and calling conventions are compiler concerns unless a separately
reviewed language design requires a surface change.

Optimization preserves evaluation order, effects, failures and trap messages.
An internally mutable unique buffer still has immutable source semantics:
an alias observes the original value. AD tape operations must not be duplicated
or hoisted merely because their public types are pure.

## Existing implementation

`src/rc.rs` inserts and checks `Dup`/`Drop` after the other IR passes.
Functions and constructors consume owned arguments; primitive, foreign and
remote calls normally borrow. Selected container primitives consume their
container argument. [The shared primitive contract inventory](primitive-ownership.md)
drives argument modes, runtime sharing and owning wrapper selection for arrays,
maps and sets. Comparison-only keys borrow; inserted typed keys/elements retain
owned references, and immutable copies retain aliases. Unknown boundaries
continue to share reachable values.

Native reference counts remain exact beyond the inline byte range using rare
size_t side entries keyed by canonical allocation metadata, without retaining
new value roots. Overflow traps; release/sharing/reuse/collection clear entries.
This does not change shared runtime or cycle fallback lifetimes.

Generated drop functions release typed children and reclaim eligible counted
storage at its last reference, at any age. Runtime-shared graphs remain on
tracing. Returning storage clears old marks; record reuse/update restrictions
retain the young-cell invariant.
Unique records, variants and containers can reuse storage. Escape analysis,
scalar replacement, specialized calls and pipeline fusion eliminate many
allocations before counting is needed.

| Category | Current treatment | Remaining work |
|---|---|---|
| Scalars and nullary variants | Inline words; no counting | Preserve typed arithmetic and improve native ABI where measured |
| Eligible records/variants | Fields/structs or stack; otherwise counted heap objects | Broader layout and escape evidence; remove unnecessary counts |
| Arrays, maps, sets | Counted where supported; unique updates in place | More precise borrowing/results, typed storage and views |
| Strings and bytes | Selected copy/alias primitive results counted; leaf destruction frees storage directly | Complete remaining result families, callback lifetimes and exceptional cleanup |
| Escaping closures | Compiled dynamic calls own heap closures and typed captures; selected synchronous callbacks borrow | Unmodeled retained callbacks, temporary contexts and exceptional cleanup |
| Tasks and channels | Counted handles, retained task captures and typed channel queues | Broader runtime boundaries and explicit cycle lifetimes |
| Networking and external callbacks | Selected C resources own storage; unmodeled value boundaries share | Resource bundle acceptance, retained value ownership and teardown |
| AD tapes/kernel buffers | Numeric arrays outside the collected value heap | Cleanup on failure/cancellation, capacity reuse and scoped lifetimes |

Native executables still need a generational conservative collector for shared
values. WebAssembly uses a bump allocator; native libraries do not trace the
host's unknown roots. `FWP_GC=off` disables tracing, not all allocation and not
the ownership gap. `--memory static` provisions bounded memory, not static
lifetimes. None of these is a general collector-free execution guarantee.


PR122 merges direct typed variant alias transfer and checked nominal context for
match/field elimination. CAF caches own typed results, return separate owners,
and release after task teardown; inlined arguments still evaluate and release
before the callee. Spawn/deadline callbacks retain captures with rollback;
scopes protect result/storage through joining and unwind. Counted task handles
own cached results, and await returns separate owners. Typed channel queues
retain elements and transfer them on receive; close preserves queued values.
Explicit draining breaks the tested counted cycle; automatic unreachable-cycle
reclamation remains unproved. Other resource boundaries stay prepared.

## Remaining ownership coverage

Container contracts and comparison-key borrowing are merged. Selected leaves,
fresh text trees, compiled captures, concrete temporaries and stack children are
also merged; synchronous map/filter borrow callback inputs and own their fresh
spines/results. Map callback failure, trap and cancellation now release owned
results, partial spines and scratch through registered cleanup. sort/unique borrow their input, retain typed selected aliases
and release scratch after constructing their owned copied result. sort-by
borrows its callback/input, evaluates keys once in input order, owns typed
keys/copied results and releases scratch; stable ties remain unchanged.
repeat retains typed borrowed aliases in owned fresh nodes; range owns its
fresh nodes. Scalars remain uncounted; boxed128-bit payloads still share.
Finish remaining primitive/runtime families, including argument/result ownership,
retention, aliases and exceptional cleanup. The exact prepared queue and current
verification are in [the handoff](development-state.md). Keep the IR pass and
code generator on the same contracts.

Contracts must distinguish borrowing for the call, consuming a reference,
retaining a reference beyond the call, returning a fresh owned value, and
returning an alias of an argument. A borrowed callback input cannot silently
become an owned result. A slice must retain its backing buffer if it escapes.

Extend measured borrowing and deterministic cleanup to the remaining container,
callback and runtime boundaries in focused changes.
Do not indiscriminately count every short-lived list: the delivery history
records a case where doing so slowed execution by 35%.

Each change needs aliasing, escape and callback tests; branch and tail-call
ownership checks; GC/reuse verification; and allocation/count evidence.
Failure, handler unwind, cancellation and FFI lifetime paths are part of the
contract. Define how runtime cycles are broken before removing tracing.

Immutable source values alone do not account for runtime cycles: a channel can
queue a value containing that same channel. Closing must preserve queued values
for later receives. A prepared regression verifies that explicit draining and
typed destruction break this counted cycle, including GC-off execution. Losing
the last external handle without draining leaves an internal counted owner;
this does not establish automatic cycle reclamation. Tracing-free eligibility
therefore needs proved scoped/drained lifetimes or another explicit cycle policy;
unproved shared cycles retain the tracing fallback.

## Phase 2 exit gates

Finish the prepared ownership deliveries and the following finite coverage
review before phase 3. The primitive inventory, IR checker and generated
wrappers must agree on each contract. Record conservative shared boundaries
explicitly, including their retention and teardown; they remain tracing
requirements until phase 6 proves eligibility for execution without collection.

| Review | Required evidence |
|---|---|
| Primitive families | Argument/result/alias/callback contracts, coverage checks and scalar address-shaped-bit controls |
| Retained values and contexts | Original owners survive escapes; normal, error, trap and cancellation cleanup; callback evaluation order preserved |
| Resources and metadata roots | Borrowed descriptors/subjects stay live; deterministic discard, weak-finalizer removal and library teardown; affine File rules preserved |
| Reconstructed values and external boundaries | Typed ownership where established; explicit shared fallback for decode/parse/FFI cases, including partial failure and retained results |
| Cycles | Close preserves queued values; explicit drain/scoped lifetime controls; automatic unreachable-cycle reclamation or an explicit tracing requirement |

The PR124 candidate inventory verifies374 declarations resolving to364 runtime
symbols after40 aliases:153 explicit contracts,19 ordinary IR combinators,
11 flat scalar signatures and191 review declarations representing181 symbols.
This includes typed State ownership and internal ad.scope. These counts classify
source boundaries rather than heap objects or bugs. Full production acceptance
is recorded in [the handoff](development-state.md).
Unknown `Body::Prim`, C and remote boundaries share pointer-bearing arguments
when no proven borrowing contract applies; scalar words remain uncounted.
Reconstructed decode/parse values and retained network contexts can therefore
still require tracing even when their temporary C buffers reclaim deterministically.
Classify these conservative requirements explicitly before phase 3; phase 6 must
prove eligibility separately. External AD/FFI state has its own lifetime contract.

PR123 accepts borrowed arguments for all nine raw-memory declarations.
mem.alloc/mem.string allocate raw C buffers released explicitly by mem.free;
mem.string copies its input without changing managed input ownership.
ptr.read-string makes an independent counted managed String. Native copy,
last-owner release, omitted-sharing and omitted-fresh-owner controls pass along
with raw interpreter agreement. Pointer arithmetic wraps at the native pointer
width, with matching interpreter/native boundary checks and UBSan controls on
Linux and both macOS architectures. Ordinary arithmetic remains checked.
This acceptance does not establish F16/128-bit, WebAssembly pointer widths or
automatic raw-buffer lifetime coverage. Unsafe raw reads/writes still require
valid addresses supplied by the program.

Acceptance includes full exact-head Linux and ARM/Intel macOS gates, GC stress
and reuse verification, with allocation/live-memory evidence for reclamation.
Shared fallback is documented coverage, not deterministic reclamation or a
collector-free guarantee. Phase 6 must reject unsupported claims about escapes,
cycles and external lifetimes rather than inferring support from successful exit.

## Representation and numerics

Prefer elimination, registers and scalar replacement, then stack allocation,
ownership transfer, scoped regions and reference counting for sharing. A
heap-owned reusable buffer is appropriate for large or dynamic tensors;
forcing them onto a stack is not the goal.

Current generic array slots are 64-bit `V` words. Plan specialized contiguous
numeric buffers with natural element widths, checked strides and bounds,
aligned payloads where useful, and views with explicit backing lifetimes.
Measure array-of-struct versus struct-of-arrays layouts for each workload.
Do not pad every small object to a cache line.

Actual binary/layout baselines are preserved in [history](roadmap-history.md#archived-representation-measurement-detail).
These are fixture-specific results at prepared source heads; each final delivery
still needs exact-head CI. They establish representations and allocation
requests, not production speed, cache behavior or collector-free execution.

| Preparation / platform | Verified representation or allocation difference |
|---|---|
| 44 / ARM+Intel | V8, array header8 and element slot8; three-field variant32/align8 |
| 65 / ARM | Six-I64 worker value48/align8 versus boxed56; return through caller storage |
| 79 / ARM | Typed frame holder removes one16-byte parent box; File/path allocation remains |
| 80 / ARM | Inline File header16/align8 versus24; one request16+n+1 versus two requesting24+n+1 |
| 83 / ARM | Variant holder16/align8; zero parent boxes versus one16-byte box |
| 111 / ARM+Intel | Packed TLS header64/align8; one request101/8311 for the tested inputs |
| 112 / ARM+Intel | Connection header272/align8 versus520; short address request278 |

A bounded ARM capacity check measures TLS requested101/8311 as112/8704 malloc
usable bytes, and connection request278 as320 GC-slot bytes versus640 for an
allocation of the old520-byte header size in the same allocator. It does not
execute the old constructor. Metadata, pool reservation, Intel capacity and
cache/timing effects are excluded or unmeasured; exact evidence is in
[history](roadmap-history.md#actual-local-grpc-allocator-capacity).

C ABI struct returns can use registers or caller storage. Check emitted arm64
and x86-64 assembly for spills, floating-point register use, boxing and calls;
the number of fields alone is not a machine-speed guarantee. The C backend
remains the first implementation target.

Keep deterministic operation/reduction order by default and contraction off.
If relaxed floating-point arithmetic is later exposed, it needs an explicit
contract and separate tests. Prioritize fused elementwise and gradient kernels,
blocked matrix multiplication, reusable tape/scratch buffers and exceptional
cleanup before adding accelerator backends. OpenCL discovery is not evidence
that kernels executed on a real device.

Preserve the existing fusion guards in [src/fuse.rs](../src/fuse.rs): eager
list stages interleave only when they are pure, terminating and have at most
one observable trap message; early-stop `find` requires nontrapping stages.
Keep the [distinct-trap](../tests/run/fusion_traps.fwp) and
[early-stop](../tests/run/fusion_find_trap.fwp) oracles when extending numeric
fusion. AD tape operations retain their evaluation order even with pure public
types; new fused gradient kernels need raw interpreter/native order checks.

### Phase 3 delivery sequence

Keep source array/value types, pipe syntax and wire behavior unchanged. Make
representation choices after monomorphization, using the concrete element and
field types; generic/foreign boundaries keep explicit conversion contracts.

| Delivery | Implementation and acceptance |
|---|---|
| Natural-width scalar arrays | Checked sizes/strides, suitable payload alignment and typed load/store; preserve aliases, bounds, arithmetic/trap order and pointer-free scanning |
| Scalar/aggregate ABI | Prefer natural C scalar fields and direct workers where measured; verify arm64/x86-64 integer and floating-point register use, spills, boxing and FFI conversion |
| Views and reusable backing | Retain backing owners across escapes; unique updates preserve immutable aliases; cover zero-length/subrange/overflow cases and exceptional release |
| Measured representation gate | Equivalent C/Rust work, allocation-inclusive and kernel-only results, requested/actual bytes and peak live memory; hardware/compiler/flags/assembly recorded |

The current worker ABI passes fields as V words and keys fwp_r layouts by field
count. Natural scalar fields therefore need layouts keyed by concrete field
types, typed worker parameters/results and bit-preserving bridges to generic V
entries. Verify floating-point register use in the emitted machine code; an
unboxed record alone does not establish a natural floating-point calling
convention. Keep closure, callback and foreign conversion contracts explicit.

Natural-width storage must cover every producer and consumer, including owned
array primitives, typed destruction, display/equality, JSON and binary decode,
constant construction and callback/dynamic boundaries. The current fwp_arr
header has a64-bit length followed by V slots; it has no spare32-bit field to
reuse without a new layout contract. Preserve length/bounds/overflow behavior.
Specialized hot loops should select concrete loads/stores at compile time;
unknown or mixed runtime boundaries need an explicit representation fallback or
conversion. Measure any representation-tag/header or side-metadata overhead
alongside payload savings, including empty and small arrays; narrow storage does
not automatically reduce total allocated bytes. A narrower array.get alone does
not establish representation support.

Handle boxed128-bit and F16 paths explicitly: retain current numeric behavior
until their representation/conversion contracts pass. Keep default reduction
order and floating-point contraction unchanged. Phase 4 owns numerical loop,
matrix and autodiff buffer/tape improvements after this representation gate.

## Evidence required

Use equivalent workloads against C and Rust, with allocation-inclusive and
kernel-only timings separated. Record hardware, compiler/version, flags,
input sizes, output checks, allocated bytes, peak live bytes, count operations
and collection pauses. Keep noisy timing thresholds out of shared-runner CI;
assert semantic results and stable allocation properties instead.

Run full workloads on GitHub runners. Passing Linux tests alone does not
validate Darwin root discovery, task ABIs or Apple Silicon numeric behavior.

## Merged ownership boundaries

Main through PR #123 includes the following contracts. Detailed primitive modes
are in [primitive-ownership.md](primitive-ownership.md), and original validation
and measurements are in [history](roadmap-history.md).

- Compiler reuse tokens clear dead fields before retaining empty young cells,
  transfer to compatible constructors, release unused cells and unlink cleanup
  before tail calls. Failure/trap/cancellation releases registered tokens.
  Compiler call liveness and consumed constructor-field protection are merged;
  worker argument preparation is merged. Wider callback paths stay prepared.
- Registered runtime owners and scoped files release exactly once before failure,
  trap or cancellation invalidates their frames. Cleanup stops at the caught
  handler boundary, and task switching preserves separate cleanup chains.
  Compiler live caller/pending-argument and incoming-parameter cleanup is
  merged in PR106; runtime application and partial capture preparation in PR107.
  Constructor fields and remaining caller references are registered before allocation
  in PR113. Worker result fields and remaining caller references stay registered
  until record/variant boxing succeeds in PR114. Worker argument preparation
  protects original boxes and completed field duplicates until transfer in PR115;
  flattened loop argument preparation protects original boxes and completed field
  duplicates until transfer in PR116. Multi-field retains release completed extras
  on count overflow in PR117, with caller owners registered before duplication.
  Nested constructor temporaries inherit known monomorphic context for typed
  child cleanup in PR118. Boxed variant conversion protects the original box
  and remaining caller owners through typed retention in PR119. Record updates
  retain typed kept fields, release replaced owners and protect replacement,
  partial retains and unfinished copies in PR120; general copies preserve the
  borrowed original. Boxed record conversion protects original boxes, remaining
  caller owners and completed typed field retains in PR121, including matched
  result checkpoints. Wider callback registration remains prepared.
- Arrays own typed elements across lookup, copies, generation, mapping and
  immutable updates; folds transfer accumulators. Typed destruction releases
  children without treating scalar bits as pointers. General unwind remains prepared.
- Maps and sets own typed keys/elements across construction, copies, lookup
  and immutable updates. Synchronous callbacks borrow inputs and adopt results;
  typed destruction releases children and storage. General unwind remains prepared.
- Task result/deadline boundaries own fresh typed result wrappers and retain
  aliases without treating scalar words as pointers. Spawn/deadline thunks retain
  captures through entry, completion or cancellation, with preparation rollback.
  Counted task handles own cached results; each await returns a separate owner.
  Typed channels own queued elements and transfer them on receive. Closing
  preserves queued values; unproved unreachable cycles still require tracing.
- Eligible old counted storage is reclaimed at last release. Verification
  clears freed child words so stale conservative roots cannot retain reused cells;
  newly allocated cells become young. Shared graphs still require tracing.
- Native counts stay exact above 254 with rare side entries. Ordered copied
  lists retain typed aliases; sort-by owns once-per-input keys and its stable
  copied result, releasing scratch after construction.
- Selected String/Bytes copy and alias results are owned; leaf destruction frees
  their storage without scanning payload bytes as child pointers. Fresh nested
  text results retain owned spines and elements.
- Compiled dynamic calls own heap closures and typed captures. Bounded capture
  cleanup protects partial application and converted arguments through traps.
  Unknown runtime/FFI callbacks keep the sharing fallback.
- Concrete call temporaries and eligible stack aggregate/closure children keep
  typed ownership. Count operations address children rather than stack wrappers.
- Zip/unzip/chunks borrow inputs and build typed counted nested spines retaining
  selected aliases. Scratch releases after construction; chunk validation
  preserves trap order. General unwind protection remains prepared work.
- Loop consumes its state and transfers callback inputs; it retains selected
  typed Step payloads before destroying wrappers. Specialized/flattened workers
  reclaim typed boxed inputs and ABI wrappers. Registered cleanup protects current
  state during first/later cancellation ticks and Step owners during payload
  preparation; flattened Again records remain unboxed. Later reconstruction
  and retained-callback extensions remain prepared.
- Scan/iterate borrow callbacks and own each stored state, retaining initial
  aliases and adopting subsequent callback results.
- Synchronous callbacks borrow typed inputs and return owned results. Map/filter
  own fresh spines; fold/right-fold transfer accumulators; zip-with owns callback
  results; fold preparation protects the current accumulator and completed
  borrowed duplicates, and right-fold scratch releases on unwind. Registered
  map, selection and zip cleanup releases owned results,
  partial spines and scratch on failure, trap or cancellation. Both zip scratch
  buffers release, including a failure while preparing the second buffer.
  Prefix/copy operations preserve owned aliases. Optional list results
  retain selected values, and synchronous find borrows predicate inputs.

These contracts do not establish complete runtime retention, exceptional
lifetimes, shared graph ownership or general execution without tracing.

## Prepared ownership work

[The immutable queue](roadmap-queue.md) records the ordered published work.
Prepared code and focused checks are not merged support. Every preparation must
rebase and pass six exact-head production jobs plus the documentation audit.
Current failures and commands are
in [the handoff](development-state.md), rather than a second priority list here.

| Area | Prepared contract | Acceptance still required |
|---|---|---|
| Loop and resource aggregates | Remaining reconstruction/context protections and original resource holders | Bundle CI; partial retains, traps and nested holders |
| Libraries and devices | Input/result/unload ownership, resource teardown and OpenCL loader lifetimes | Bundle CI; host aliases and actual device evidence |
| Networking and retained contexts | TLS/HTTP2/gRPC owners, cancellation, caches and context restoration | Bundle CI; metadata roots, callback lifetimes and protocol behavior |
| Files and original frames | Logical ownership, borrowed IO, original scope anchors and deterministic close | Bundle CI; all escaping/error/shared boundaries |
| File storage | Inline path, finalizer removal, last-owner storage release and constructor rollback | Bundle CI; shared/stale handles and actual WASI behavior |
| Autodiff ownership | Scoped numeric buffers, validated/retired tokens and counted gradient arrays | Callback return/error/cancellation, nested scopes, GC/reuse and raw/native controls; equivalent steady-state allocation counts/bytes must not increase |
| Applicative and flat-map callbacks | Borrowed inputs, owned results/chunks, retained copied aliases and counted spines; separate scratch/unwind owners | Raw/native aliases and order, callback trap/cancellation, partial spine and size controls; focused and full bundle gates |
| State backing storage | Clear inactive scanned words on pop, handler restoration and task exit; preserve suspended active states | Actual collector scans, live aliases, nested failures, gRPC recovery and real task exit/cancellation; typed State ownership remains separate |
| WASM resources | Logical aggregate/task counts and disposal metadata | Actual-WASI full gates; physical bump storage remains allocated |
| Frame representation | Typed record fields and variant structs, per-path pattern initialization | Bundle CI; nested holders and partial-retain traps |

## Original resource semantics

File values stay affine: no duplication trait or resource capture is added.
A File parameter remains alive until its original function frame exits, even
when ignored; early close would change later IO failures. Prepared internal ResourceRegion
anchors record these lifetimes before optimization and preserve them through
inlining and fusion; their implementation still requires accepted bundle delivery.
Returned/error aliases retain their owners. Partially failed patterns retain
already bound locals until frame exit, matching the interpreter.

Prepared native File headers count logical owners independently of GC slots.
The last owner closes the stream; explicit close and teardown are idempotent.
Inline-path storage uses one aligned leaf allocation. Unshared last-owner
storage release first removes library finalizers, and constructor failures retain
raw-stream/header ownership through registration and path-copy failures. Shared
headers retain the compatibility allocator lifetime. FWP_FREE=0 keeps ordinary
child storage while resource ownership still closes streams.

Eligible original record bindings retain fields without a forced parent box;
variant bindings retain tag/payload structs through tag-aware helpers. Boxed
bindings retain the parent once. FWP_FRAME_FIELDS=0 is the comparison control.
Incoming owners remain protected through partial-retain failures. Whole-pattern
bindings initialize their own path's payload/fields, avoiding C temporaries from
another branch. Missing nominal scrutinee context can be recovered from a typed
whole-value binder; other ambiguous patterns remain an audit item.

Focused descriptor, allocation and omission controls support these preparations.
Full tracing-free acceptance still requires complete escape/runtime ownership,
physical reclamation where supported and an explicit cycle lifetime policy.
