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
maps and sets. Comparison-only keys borrow; inserted keys remain shared.

Generated drop functions free counted objects at their last reference.
Unique records, variants and containers can reuse storage. Escape analysis,
scalar replacement, specialized calls and pipeline fusion eliminate many
allocations before counting is needed.

| Category | Current treatment | Remaining work |
|---|---|---|
| Scalars and nullary variants | Inline words; no counting | Preserve typed arithmetic and improve native ABI where measured |
| Eligible records/variants | Fields/structs or stack; otherwise counted heap objects | Broader layout and escape evidence; remove unnecessary counts |
| Arrays, maps, sets | Counted where supported; unique updates in place | More precise borrowing/results, typed storage and views |
| Strings, bytes, escaping closures | Runtime-shared, outside current counting coverage | Owned results, typed destruction and captured-value lifetimes |
| Tasks, channels, networking, callbacks | Runtime structures and shared value boundaries | Explicit retained ownership, teardown and cancellation paths |
| AD tapes/kernel buffers | Numeric arrays outside the collected value heap | Cleanup on failure/cancellation, capacity reuse and scoped lifetimes |

Native executables still need a generational conservative collector for shared
values. WebAssembly uses a bump allocator; native libraries do not trace the
host's unknown roots. `FWP_GC=off` disables tracing, not all allocation and not
the ownership gap. `--memory static` provisions bounded memory, not static
lifetimes. None of these is a general collector-free execution guarantee.

## Next ownership change

The first change consolidates the array/map/set contracts and removes sharing
for comparison-only keys. Finish inventorying the remaining primitive families,
including their argument/result ownership, retention, callbacks and aliases.
Then extend deterministic element/leaf/capture destruction. Keep the IR pass
and code generator on the same contracts.

Contracts must distinguish borrowing for the call, consuming a reference,
retaining a reference beyond the call, returning a fresh owned value, and
returning an alias of an argument. A borrowed callback input cannot silently
become an owned result. A slice must retain its backing buffer if it escapes.

Start with read-only container primitives that currently force sharing.
Eliminate redundant counts/transitions there, measure the result, then extend
coverage to strings/bytes, closures and runtime structures in focused changes.
Do not indiscriminately count every short-lived list: the delivery history
records a case where doing so slowed execution by 35%.

Each change needs aliasing, escape and callback tests; branch and tail-call
ownership checks; GC/reuse verification; and allocation/count evidence.
Failure, handler unwind, cancellation and FFI lifetime paths are part of the
contract. Define how runtime cycles are broken before removing tracing.

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

## Evidence required

Use equivalent workloads against C and Rust, with allocation-inclusive and
kernel-only timings separated. Record hardware, compiler/version, flags,
input sizes, output checks, allocated bytes, peak live bytes, count operations
and collection pauses. Keep noisy timing thresholds out of shared-runner CI;
assert semantic results and stable allocation properties instead.

Run full workloads on GitHub runners. Passing Linux tests alone does not
validate Darwin root discovery, task ABIs or Apple Silicon numeric behavior.
