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
| Arrays, maps, sets | Typed counted storage, numeric views and unique updates | Broader borrowing and performance evidence |
| Strings and bytes | Selected copy/alias primitive results counted; leaf destruction frees storage directly | Complete remaining result families, callback lifetimes and exceptional cleanup |
| Escaping closures | Compiled dynamic calls own heap closures and typed captures; selected synchronous callbacks borrow | Unmodeled retained callbacks, temporary contexts and exceptional cleanup |
| Tasks and channels | Counted handles, retained task captures and typed channel queues | Broader runtime boundaries and explicit cycle lifetimes |
| Networking and external callbacks | Accepted resource ownership and teardown; unmodeled value boundaries share | Prove eligibility before allowing tracing-free use |
| AD tapes/kernel buffers | Scoped numeric owners outside the collected value heap | Bounded capacity reuse and measured numerical optimization |

Native executables still need a generational conservative collector for shared
values. WebAssembly uses a bump allocator; native libraries do not trace the
host's unknown roots. `FWP_GC=off` disables tracing, not all allocation and not
the ownership gap. `--memory static` provisions bounded memory, not static
lifetimes. None of these is a general collector-free execution guarantee.


## Remaining ownership coverage

Phase2 has a finite accepted inventory of owned and shared boundaries; see
[ownership coverage](#ownership-coverage). Remaining work is measured optimization
and the eligibility/cycle policy for optional tracing-free execution. Keep the
IR pass and code generator on the same contracts; accepting an explicit shared
boundary does not make its values deterministically reclaimed.

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
for later receives. Accepted regression controls verify explicit draining and typed destruction
break the counted cycle. GC-off logical-count controls do not establish physical
reclamation by the WebAssembly bump allocator. Losing
the last external handle without draining leaves an internal counted owner;
this does not establish automatic cycle reclamation. Tracing-free eligibility
therefore needs proved scoped/drained lifetimes or another explicit cycle policy;
unproved shared cycles retain the tracing fallback.

## Phase 2 exit gates

The actual merged-source finite coverage review passes after PR125 acceptance.
The accepted representation changes preserve these contracts. The primitive inventory, IR checker and generated
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

The accepted PR124 inventory verifies375 declarations resolving to365
runtime symbols after40 aliases:168 explicit contracts,19 ordinary IR combinators,
11 flat scalar signatures and177 review declarations representing167 symbols.
This includes typed State, internal ad.scope/ad.scope2 and14 fresh codec leaves.
These counts classify boundaries rather than heap objects or bugs. Full production
acceptance is recorded in [the handoff](development-state.md).
Unknown `Body::Prim`, C and remote boundaries share pointer-bearing arguments
when no proven borrowing contract applies; scalar words remain uncounted.
Reconstructed decode/parse values and retained network contexts can therefore
still require tracing even when their temporary C buffers reclaim deterministically.
These conservative requirements are explicitly classified in accepted phase2.
Phase6 must prove tracing-free eligibility separately. External AD/FFI state has its own lifetime contract.

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

Accepted phase3 stores eligible scalar numeric arrays at natural1/2/4/8-byte
widths with checked bounds and owner-retaining views. Generic pointer-bearing
slots remain64-bit `V` words.
Measure array-of-struct versus struct-of-arrays layouts for each workload.
Do not pad every small object to a cache line.

Register allocation may place values in registers or spill them to the stack;
these are normal lowering decisions. Protocol-defined alternatives are peers.
Reserve “compatibility fallback” for an actual conservative ownership path.
Avoid redundant wrappers or alternate implementations and undocumented implicit
choices. Give internal resource budgets explicit names, reasons and measured
limits; compiler optimizations should preserve the same source semantics.

Historical binary/layout baselines and allocator measurements are preserved in
[history](roadmap-history.md#archived-representation-measurement-detail). Current
accepted representations are specified below. Allocation and ABI evidence does
not by itself establish speed, cache behavior or tracing-free execution.

C ABI struct returns can use registers or caller storage. Check emitted arm64
and x86-64 assembly for spills, floating-point register use, boxing and calls;
the number of fields alone is not a machine-speed guarantee. The C backend
remains the first implementation target.

Keep deterministic operation/reduction order by default and contraction off.
Storage, protocol and ABI bridges preserve complete float bits. Arithmetic
results that are NaNs retain the compiler's existing payload/sign choices;
those choices can vary across optimization levels. Compare arithmetic NaN
classification separately from exact finite and signed-zero results, retaining
raw payloads in evidence. This boundary follows the existing C/Rust backends
and [LLVM's NaN contract](https://releases.llvm.org/18.1.7/docs/LangRef.html#behavior-of-floating-point-nan-values);
it introduces no new arithmetic canonicalization. Bit copies and sign-only
operations still require exact payload controls.
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

This sequence is complete in accepted phase3. Source array/value types, pipe
syntax and wire behavior remain unchanged. Representation is selected after
monomorphization from concrete element/field types; generic and foreign
boundaries retain explicit conversion contracts. Phases4–5 measure numerical
performance using these representations.

Direct numeric workers use concrete C scalar parameters/results and aggregate
fields; boxing, closures, callbacks and foreign conversion keep bit-preserving
V bridges. Natural fields distinguish layouts by their concrete types. The
C ABI chooses register or caller-storage return: three F64 fields form an ARM
floating-point aggregate, while the24-byte Intel result uses caller storage.
FWP_TYPED_ABI=0 preserves the previous V-worker boundary for comparisons.

Numeric arrays retain an8-byte length header with descriptors outside the
payload. I8/U8 use1 byte, I16/U16 use2, I32/U32/F32 use4, I64/U64/F64 use8.
Typed loads/stores use memcpy and preserve signed extension and float bits.
Pointer-free numeric storage uses leaf allocations; pointer-bearing and boxed
wide values keep word storage and typed teardown. The established count/trap
bound remains even for narrow payloads. FWP_PACKED_ARRAYS=0 keeps word payloads
and copied slices for controlled comparisons.

Numeric views have a tagged length, retained backing owner and byte address.
Nested views retain the original backing directly. Immutable updates copy views;
only an owning array may mutate in place. Slices with payload at most the24-byte
view header or less than one quarter of backing length copy instead, avoiding
unbounded retention for small results. Pointer/resource slices always copy to
preserve disposal order. Natural alignment follows backing alignment and element
stride; this is not a guarantee of cache-line or SIMD-register alignment.

F16/BF16 currently retain their existing F32 representation and4-byte wire/storage
format; F128 retains its existing F64 representation and8-byte format. They are
not native half/128-bit floating formats. I128/U128 stay boxed in word slots.
A new wide/half format requires a separate semantic and wire-format decision.
The handoff records prepared versus accepted source and its actual runner gates.

## Evidence required

Use equivalent workloads against C and Rust, with allocation-inclusive and
kernel-only timings separated. Record hardware, compiler/version, flags,
input sizes, output checks, allocated bytes, peak live bytes, count operations
and collection pauses. Keep noisy timing thresholds out of shared-runner CI;
assert semantic results and stable allocation properties instead.

Run full workloads on GitHub runners. Passing Linux tests alone does not
validate Darwin root discovery, task ABIs or Apple Silicon numeric behavior.

## Merged ownership boundaries

Main through PR #124 includes the following contracts. Detailed primitive modes
are in [primitive-ownership.md](primitive-ownership.md), and original validation
and measurements are in [history](roadmap-history.md).

- Compiler reuse tokens clear dead fields before retaining empty young cells,
  transfer to compatible constructors, release unused cells and unlink cleanup
  before tail calls. Failure/trap/cancellation releases registered tokens.
  Compiler call liveness and consumed constructor-field protection are merged;
  worker argument preparation is merged. Unmodeled callbacks retain compatibility roots.
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
  result checkpoints. Unmodeled callbacks retain shared fallback.
- Arrays own typed elements across lookup, copies, generation, mapping and
  immutable updates; folds transfer accumulators. Typed destruction releases
  children without treating scalar bits as pointers. Unmodeled payloads retain shared fallback.
- Maps and sets own typed keys/elements across construction, copies, lookup
  and immutable updates. Synchronous callbacks borrow inputs and adopt results;
  typed destruction releases children and storage. Unmodeled payloads retain shared fallback.
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
  preserves trap order. Unmodeled runtime boundaries retain compatibility roots.
- Loop consumes its state and transfers callback inputs; it retains selected
  typed Step payloads before destroying wrappers. Specialized/flattened workers
  reclaim typed boxed inputs and ABI wrappers. Registered cleanup protects current
  state during first/later cancellation ticks and Step owners during payload
  preparation; flattened Again records remain unboxed. Later reconstruction
  and retained-callback boundaries retain shared fallback.
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

## Ownership coverage

Phase2 is accepted against the actual merged source recorded in the handoff.
All375 declarations are inventoried:168 contracts,19 IR combinators,11 flat
signatures and177 explicit fallback declarations/167 symbols. Their argument,
result, callback, retention, teardown and cycle policies are checked against the
compiler and runtime. This establishes the documented compatibility model.

Reconstructed/decoded graphs and cached/retained contexts require tracing unless
a typed contract proves their complete graph and teardown. Channel close preserves
queued values; draining breaks the tested counted cycle. Unreachable shared cycles
still require tracing. Natural numeric storage/views and later optimized kernels
must preserve these lifetimes. Optional tracing-free execution remains phase6.

## Original resource semantics

File values stay affine: no duplication trait or resource capture is added.
A File parameter remains alive until its original function frame exits, even
when ignored; early close would change later IO failures. Internal ResourceRegion
anchors record these lifetimes before optimization and preserve them through
inlining and fusion, as accepted in PR124.
Returned/error aliases retain their owners. Partially failed patterns retain
already bound locals until frame exit, matching the interpreter.

Native File headers count logical owners independently of GC slots.
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

## Checked ARC delivery

The phase6 preparation checks `--gc arc` against monomorphic value shapes and
primitive contracts, with the cycle policy described in [design](design.md#checked-native-arc-execution).
Escaping closures, arrays/views and scoped File owners have native O1/O2
reclamation controls with stack allocation both enabled and disabled. The ledger
runs after typed CAF/closure cleanup and requires no newly charged live value
storage or collections; a missing-free control must fail it. Binary symbol and
disassembly evidence verifies tracing routines are absent; forcing a collector
entry must trap. Native static-memory and complete-bundle controls remain
subject to the current preparation/production gates in the handoff.

The collector allocator remains responsible for metadata and reusable storage.
ARC does not promise zero allocator overhead, zero reserved address space, or
immediate return of every freed page to the operating system. Unsupported cyclic
runtime types and owner boundaries fail eligibility instead of acquiring an
implicit lifetime or tracing path. Existing unchecked `FWP_GC=off` diagnostics
remain available in tracing-mode builds; they do not establish ARC eligibility.

ARC eligibility also rejects boxed I128/U128 until their representation has counted
owners. User native declarations cannot acquire a checked signature merely by
naming a standard primitive. Eligibility checks the locals introduced by ownership
lowering as well as source-derived types. Fusion registers synthesized variant
fields, and inlining retains types for constructed and compile-time aggregates.
The golden corpus checks semantics and charged storage on normal return and
requires previously eligible programs to stay eligible. It uses the raw
interpreter except for the original deep non-tail recursion case, which retains
its optimized-interpreter/golden oracle and adds a bounded raw-interpreter copy.
Rejections and expected front-end errors are listed separately from executions.
The handoff records the current preparation and production gates.
