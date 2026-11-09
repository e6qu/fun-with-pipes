# Ownership comparisons: next measurement work

This is milestone 4 of the [roadmap](../../PLAN.md). It prepares comparisons,
not another compiler optimization. [The first native checks](ownership-peer-checks-2026-11-08/README.md)
cover Swift buffer results and C/Rust parser storage/frames. Returned-buffer
[phase timings and RSS](returned-buffer-time-2026-11-09/README.md) now include both
sessions on both hosts; failed copy controls remain inconclusive. Weak-operation
and service timings remain unmeasured. Freeze each protocol before collection.

## Questions and programs

| Program | What we need to learn | Existing starting point |
|---|---|---|
| Integer buffers | Cost of construction, reads/folds and release; effect of keeping a second owner | [C/Rust/fwp buffers](unique-buffer-peers.md) |
| Returned functions | Cost and storage of capturing one integer and calling the function later | [Four-language phase comparison](callable-phases.md) |
| Weak registrations | Cost of live/expired lookup and safe cancellation without keeping the target alive | [Weak channels](../weak-channels.md) |
| Parser workspace | Peak storage during growth, release and recursive stack costs | [Parser comparison](parser-workspace.md) |

The peers use ordinary Swift, C and Rust representations. Explain their different
work before interpreting a ratio. Allocation counts, live bytes, process RAM and
reference-count operations are separate observations.

## Buffers

Use lengths 0, 16, 4,096 and 262,144, containing integers `0` through `length - 1`.
For length 4, the existing operations return:

- `unique`: length plus first element, then length again: `4 + 0 + 4 = 8`.
- `callback`: a borrowing reader returns length plus first element: `4 + 0 = 4`.
- `scan`: a checked left-to-right sum: `0 + 1 + 2 + 3 = 6`.

Negative lengths mean empty buffers. Check invalid arguments, oversized lengths,
checked accumulation and matching outputs before timing.

Add Swift's native `Array<Int64>` to these programs. Keep two experiments distinct:

1. **Complete operation:** compilers can combine construction and use, or remove
   storage entirely. Barriers preserve repeated calls without forcing an array.
2. **Returned buffer:** compile factory and caller separately without LTO. The
   factory must return a usable buffer. Time construction, useful work and release
   separately; keep the buffer alive until the release boundary.

Use the same external input/result barriers in all four timing peers. The buffer
checker now prepares C/Rust/Swift with one separately compiled C barrier and
retains original and prepared source hashes. Actual wrong-barrier builds must
fail the result oracle. The checker also prepares fwp with that C harness and checks its raw and
optimized interpreter results. [Both native architectures now verify the four-language boundary](four-language-buffers-2026-11-09/README.md).
The returned-buffer phase experiment below now has results. Harness argument checks do not
establish equivalent native out-of-memory behavior.
Do not derive Swift allocation counts from `Array.count` or presumed capacity.
Check unique and aliased arrays separately, including validity of the surviving
owner after the other is released. Swift out-of-memory behavior is not promised
to match C/Rust's diagnostic exit code.

### Returned-buffer preparation

The [returned-buffer checks](returned-buffer-checks-2026-11-09/README.md) now pass
on both native architectures, with the first Swift borrowed-array compile errors
and their repair retained. The suite builds
factory and caller separately without LTO at C/Rust O1/O2 and Swift Onone/O.
fwp uses the current compiler's O2-generated C, compiled by the same GCC as C.
The factory returns integers `0` through `length - 1`; the caller sums them.
For length 4, the sequence is:

| Unique owner | Two owners |
|---|---|
| Construct `[0, 1, 2, 3]` | Construct `[0, 1, 2, 3]`, then create another owner |
| Read sum `6` | Read sum `6` through the first owner |
| Release | Release the first owner |
| Checksum `6` | Read sum `6` through the surviving owner, then release it; checksum `12` |

This differs from the complete-operation `unique` example above, which reads
length/first-element rather than summing all elements. Do not combine their ratios.

| Peer | Unique representation | Shared representation |
|---|---|---|
| C | Pointer/length and `malloc` storage | Counter and elements in one allocation; pointer/length/counter handle |
| Rust | Native `Vec<i64>` | Native `Rc<Vec<i64>>`; vector storage and Rc control allocation are distinct |
| Swift | Native `Array<Int64>` | Another native Array owner, without mutating either value |
| fwp | Actual emitted counted `Array[I64]` returned across the boundary | Another owner of that array |

The [fwp fixture](../../tests/fixtures/returned_buffer_peer.fwp) retains its actual
owned function entries. Its C adapter retains the caller's array before passing
an owner to the consuming scan entry. That entry-boundary cost belongs in the
measurement. Rust and Swift readers borrow their native arrays. The adapter does
not replace fwp's fold with a C loop or add a different allocation representation.
Swift explicitly consumes each array at the separately compiled release call.

Checks cover seven lengths (including negative/empty inputs), one/three repetitions,
malformed arguments, both owner modes and surviving-owner reads. The harness rejects
lengths above 262,144 and repetitions outside 1–64 before allocation; these bounds
are experimental settings, not language limits. Raw/optimized fwp interpretation
checks the same sum. Actual incorrect scan implementations must return the result
diagnostic. Separate C/fwp diagnostic builds check release and require a deliberately
omitted release to fail. C's logical buffer ledger and fwp's managed live-byte
baseline do not measure allocator reservation, physical RAM or Swift/Rust release.

The [checker](../../scripts/check-returned-buffer-peers.py) retains original and
prepared source, separate objects/modules, binaries, commands and hashes. It
collects no timing samples. [Phase callers and native storage/release checks](returned-buffer-phases-2026-11-09/README.md)
now pass on both architectures, with the original link/attribution failures
retained. [Construction/read/release timings and RSS](returned-buffer-time-2026-11-09/README.md)
now retain both sessions on both hosts, including inconclusive copy controls.
The [protocol](returned-buffer-phases.md) and original qualification limits remain fixed.

## Returned functions

Reuse the two existing operations: capture `a`, then compute `a + x` or
`2 * (a + x)`. Factories and callers compile separately. Keep native Swift
escaping functions, C/Rust inline captures and fwp's actual emitted representation.

- Preserve the existing 4,096-function populations, 256 batches and 16 calls
  per function. Attribute scalar closure allocations using the verified native
  allocation profiler; class-capture lifetime tests do not answer this question.
- Record construction, invocation, release and whole-process time separately.
- Count Swift ARC operations only if an observer demonstrates coverage of the
  actual executed paths. Otherwise record them as unmeasured. Allocation stacks
  alone cannot count retains and releases.
- Keep checked-overflow, direct-call, ordinary release and omitted-release controls.

The next scalar allocation profile uses the existing separately compiled Swift
factory and caller at `-O`, with debug information for stack attribution. Keep
4,096 closures, 256 batches and 16 calls each, for both `a + x` and `2 * (a + x)`.
Print only the checksum; keep the caller's existing clocks but never interpret
profile durations as performance. Build an actual omitted-release variant by
removing slot deinitialization while retaining pointer deallocation. This leaks
the closure owners themselves, without adding a class-capture surrogate.

For each kind, collect two ordinary and two omitted-release profiles. Attribute
only stacks containing the factory symbol `returnedMake`; preserve all raw stacks
and whole-process totals. Require observed factory allocations, zero factory
bytes left after ordinary exit, equal ordinary/control allocation counts, and
positive factory bytes left after the deliberate omission. Run the existing
allocator and selected-unwinder controls on each host. Stack-attributed bytes at
the process heap peak are not an independently measured factory peak. Missing
attribution is a failed observation, not a zero-cost result. ARC calls stay
unmeasured. [Both native profiles now pass](swift-scalar-closures-2026-11-09/README.md):
one 24-byte allocation per scalar closure, zero factory-attributed exit bytes
with normal release, and the expected retained contexts after deliberate omission.
The original protocol was frozen before collection; raw records retain the first
ARM setup failure and successful setup retry.

The existing failed timing targets remain in [their original report](callable-phases.md).
A fresh peer comparison does not replace them.

## Weak registrations

A weak registration lets a callback find a target without owning it. For example:
register a listener, call it while its owner exists, remove that owner, then verify
that a later lookup reports expiration instead of using freed storage.

Compare two scopes separately:

- **Reference operations:** create weak metadata, upgrade while live, acquire a
  strong owner for the call, release the last owner, and reject an expired upgrade.
- **Callback service:** add registration, queue handling, cancellation and cleanup.
  Report this service work rather than attributing all elapsed time to weak references.

fwp upgrades run on its serialized scheduler without ticking or suspending. They
are not an OS-thread sharing API. Use Rust `Rc`/`Weak` for that serial contract;
record Swift runtime synchronization as an implementation difference.

Track **value destruction** and **backing-allocation release** separately. Rust's
[`Weak`](https://doc.rust-lang.org/std/rc/struct.Weak.html) lets the value be
destroyed after the last strong owner, but keeps its backing allocation until
the weak references are gone. fwp keeps separate weak metadata and clears its
target before destroying the channel's queued values; the channel storage can
then be freed while weak values remain. Include a checkpoint after the last
strong owner and another after the last weak value. Do not add a Rust `Box` just
to disguise this difference. Measure the representations the languages actually use.

The current fwp runtime also constructs an owned `Some` result for a successful
upgrade. Count and measure that result's storage separately from weak metadata
and the retained target. Its presence in source is a candidate cost to investigate,
not proof that every optimized caller performs a heap allocation.

The new C/Rust/Swift correctness fixtures exercise cancellation before entry,
cancellation inside an active callback, nested acquisition, expiration and 64
subsequent target creations. They are not timing peers yet, do not force address
reuse, and do not measure native allocation or ARC counts. C failure controls
omit active release, expiration or metadata release and must fail. [Both native Linux architectures pass](weak-peer-checks-2026-11-09/README.md).

The [callback-error follow-up](weak-callback-errors-2026-11-09/README.md) now passes
on both architectures: release the outside owner inside a
callback, propagate an error, then require target destruction and failed later
lookup. C returns an error with explicit cleanup; Rust propagates `Result` with
`?`; Swift throws through `withExtendedLifetime`. The C variant omitting cleanup
on that actual error path must fail. This tests ordinary callback errors, not
Rust panics or Swift fatal traps. It does not establish
queued-service cleanup or new timing results.

The next correctness batch adds a two-message queue. Each message owns its
payload and holds a weak target link. It checks two paths:

| Path | Required result |
|---|---|
| Cancel the first message; release the target before draining the second | Cancellation destroys the first payload. The target expires while the second message remains queued. Draining destroys the second payload without calling an expired target. |
| First callback releases the outside target owner, then returns an error | The acquired target survives the callback. Returning the error releases it and both message payloads, including the unprocessed message. |

C explicitly releases entries; Rust drops consumed entries and the remaining
iterator on `Result` propagation; Swift consumes entries and clears the remaining
queue with `defer`. C fault builds omit acquired-owner, weak-link, payload or
remaining-queue cleanup. Each must return the lifetime-check diagnostic. The
checker continues through independent build groups and retains every failure.
The [queued-callback report](weak-queued-cleanup-2026-11-09/README.md) retains the
original optimized Swift failures and isolates a sufficient cancellation-lifetime
repair with the original assertions. Final checks with that minimal repair are
queued. Payload representations differ (C/Swift heap objects, Rust inline values),
so destructor counts are correctness checks, not an allocation or callback-service
performance comparison.

Every peer must preserve an acquired owner throughout an active callback. Cover
expiration, address reuse, reentry, queued cleanup, callback failure and cancellation
before entry, during the callback and after completion. Closing an fwp channel is
not weak expiration: queued values remain available while a strong owner exists.

## Parser workspace

Keep the existing prefix-expression benchmark grammar and inputs: balanced trees
of 31, 511 and 8,191 nodes, plus a 127-node left-nested tree. This is not fwp's own
language parser. Keep malformed, trailing-token and overflow controls.

- Measure C/Rust live requested storage throughout token/node growth and release,
  rather than reporting only final vector capacities. Explain what allocator
  internals the observer cannot see, including temporary storage inside `realloc`.
- Retain Rust compiler frame reports and verify their reporting build against the
  ordinary executable. A single frame size is not a whole recursive-stack bound.
- Separate payload, capacity, native allocation, virtual reservation and RSS.
  fwp owns token strings; C/Rust borrow input slices. Their tree representations
  also differ. Neither time nor memory ratios isolate reference-count overhead.

The [first checks](ownership-peer-checks-2026-11-08/README.md#parser-storage)
now verify successful allocation transitions and ordinary Rust frames on both
native architectures. Actual allocator-internal peaks, reservations and RSS remain
separate work; this observer does not measure them.
The [next process-memory protocol](parser-process-memory.md) specifies stopped
phase checkpoints, ordinary RSS runs and real mapping/touch/unmap controls.
It explicitly leaves allocator-internal peaks and committed memory unresolved;
RSS or writable mapping size must not be substituted for either.

## Before collecting timings

Freeze exact source tags, native ARM64/AMD64 hosts, toolchain versions and flags,
inputs, repetitions, phase boundaries and observer controls. Keep two sessions
per architecture and every failed observation; never rerun an unchanged case to
obtain a passing control.

Use ordinary binaries for timing and separate diagnostics for storage/counts.
Retain commands, raw samples, sources, actual images, compile time/RSS, code and
frame reports. Test missing/doubled events and omitted release before trusting an
observer. Select sufficiently long phases through a retained control-only pilot,
before seeing peer ratios. Any later compiler optimization needs its own measured
baseline and frozen correctness, memory, time and compiler-cost limits.
