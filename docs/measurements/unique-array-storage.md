# Unique arrays without reference counts

A reference count records how many owners share a value. A local array that
cannot acquire another owner does not need one: its function can free the array
directly after its last use. This is roadmap A5, following the
[A3 callback measurements](arc-residual-costs.md).

**Status:** verified for the restricted case below in PR #219. Focused native Linux
AMD64/ARM64 and actual WASI checks passed in `40496623447` at
`0f500ab347bc6025c09235f0e243467d9dc2a8ac`, including 36 native/static/escape
probes and 18 WASI probes per host. Complete logs, outputs and intended fault
statuses were audited. All nine production jobs, documentation and both compiler-analysis hosts
passed on final `aab8fe71`. Squash `413a10eb` has the identical tested tree.
[Delivery history](../roadmap-history.md#unique-local-arrays-without-counts-pr-219)
records the final gates; A5 is complete for this restricted shape.

Paired measurements come from `40492232784` at `b9d637b6`; compiler/runtime
source is unchanged since that run. Two test-harness repairs followed: the failure
fixture now exercises a proved borrow instead of a temporary transfer, and the
escaping probe uses an explicit function entry so its exports survive optimization.
Both repairs are covered by the passing focused run. Immutable evidence tags
preserve the measurement sources across the rebase onto #218.

## Selected programs

The first case builds an integer array whose length is known only at runtime,
reads it and returns an integer:

```fwp
read : Array[I64] -> I64
read = both array.length (array.get 0 | option.unwrap-or 0) | uncurry add

local : I64 -> I64
local = flip array.generate id | both read array.length | uncurry add
```

`array.generate` calls a function for each index. `flip array.generate id`
therefore turns length `n` into `[0, …, n - 1]` stored as an array. `both` applies
two functions to the same input, and `uncurry add` adds their two results.
`read` adds the length and first element, using zero when the array is empty.
Thus `16 | local` returns `32`, and `0 | local` returns `0`.

The compiler currently selects only local `Array[I64]` values constructed by
`array.generate` with a known callback that captures no values, outside specialized
loops. Every normal path must destroy the array exactly once. Calls may borrow it
only when both their ownership convention and escape analysis establish that they
cannot keep it. Returns, new aliases, escaping captures and unknown calls retain
counted storage. No public annotation or runtime conversion to shared storage is
introduced. The compile-time proof is in `src/rc/unique.rs`; generation and unwind
cleanup are in `src/cgen.rs`.

A callback can yield or fail while generating elements. The unfinished array has
an explicit cleanup before the callback runs. Once construction finishes, ordinary
call-liveness cleanup frees the completed array if a later call fails or cancels.
Arrays of managed elements, other element types and general regions are outside
this initial selection.

## Storage and costs to measure

On native 64-bit targets, a 64 KiB heap chunk has a 40-byte descriptor with an
optional 8-byte pointer to count slots. A unique chunk has no allocated count
slots. Counted small chunks allocate one byte per usable slot; a counted large
allocation needs one byte. Larger counts still use the existing exact wide-count
table. Count metadata can remain cached with a reusable chunk until shutdown.
Unused tail padding must not index past a small chunk's count array.

The previous descriptor included 4,096 count bytes even when no owner needed
them. Separating them reduces descriptor size but adds a pointer lookup and
separate allocation for counted storage. Descriptor reservations, accessible OS
pages, malloc requests and resident memory are different quantities; the smaller
structure alone does not establish a speedup or an RSS saving.

WebAssembly uses a separate count table. Selected unique arrays must bypass that
table and release their calloc storage directly. Actual WASI execution and its
independent libc-allocation ledger are required; native allocator tests do not
establish this behavior.

## Comparison protocol

The `unique-arrays` focused workflow builds the current compiler at the production
Rust settings. It runs ownership and allocator controls, then measures all 13
programs from `scripts/measure-arc-costs.py` on native Linux AMD64 and ARM64 using
GCC O2 without LTO. There are three repetitions per input. Outputs must agree with
raw interpretation. This measures generated-program operations, **not execution
time or overhead relative to C/Rust**.

The baseline is the frozen A3 candidate
`arc-residual-candidate-2026-10-27.json`. For `buffer-unique` and `buffer-callback`
at lengths 0, 16 and 4,096, the declared saving is one array count initialization,
one last-owner release, one last-owner query and one counted-array free call.
Their payload allocation/request/live-byte totals must stay unchanged. All other
measured ownership totals must match the baseline. `buffer-callback` has a known
callback that the optimizer exposes; the separate exported unknown-call control
must remain counted.

A separate instrumented binary observes count-metadata allocation requests,
requested and released count bytes, peak bytes, and cached bytes at the end.
Its count-byte balance must agree with the sum of actual chunk metadata lengths;
its managed-value totals must agree with the original observer. These count-byte
measurements exclude malloc headers, fragmentation, raw buffers, stacks and RSS.
Ordinary uninstrumented binaries retain machine type, hashes, code sections and
compiler frame-size estimates. Those frame estimates are not whole-program peak
stack use. Compiler-analysis cost is a separate acceptance check.

## Measured results

The [audited measurements](unique-array-storage-2026-10-27.json) retain all rows,
source hashes, GCC versions, hardware, metadata and frame estimates. For both local
buffer cases at every tested size, exactly the four declared array operations
disappear. All other ownership totals and managed-value allocation/live-byte totals
match A3, including the deliberately shared buffer.

| Host / program | Executable bytes, A3 → A5 | `.text` bytes, A3 → A5 | Entry frame bytes, A3 → A5 |
|---|---:|---:|---:|
| AMD64 / unique | 109,392 → 109,400 | 60,786 → 59,730 | 128 → 80 |
| ARM64 / unique | 147,656 → 147,664 | 57,836 → 57,020 | 144 → 80 |
| AMD64 / known callback | 109,272 → 109,280 | 61,202 → 59,570 | 128 → 32 |
| ARM64 / known callback | 147,536 → 147,576 | 58,300 → 56,892 | 144 → 32 |
| AMD64 / shared | 109,520 → 109,608 | 62,258 → 62,434 | unchanged main frame: 976 |
| ARM64 / shared | 147,760 → 147,848 | 59,212 → 59,756 | unchanged main frame: 960 |

The selected entries use less code and smaller frames, but complete executables
are slightly larger. The shared control's code grows. No runtime speed or peak
stack improvement follows from these observations alone.

Both local-buffer programs make two count-metadata allocations totaling 8,192
bytes at every size, retained in the chunk cache at the observation point. These
belong to other counted storage in the command, not the unique array: the direct
array probe requires its own chunk to have no count slots. The shared control
makes 3/4/4 metadata allocations and requests 10,240/10,695/10,241 bytes for
lengths 0/16/4,096. These are candidate-only observations; the earlier report did
not measure separate metadata requests. They must not be presented as a measured
process-memory reduction against A3.

## Compiler cost

[The complete-command samples](unique-array-analysis-2026-10-27.json) come from
run `40494835629`, source `7cf8baf8`, with the production Rust O1 build and checked
arithmetic/debug assertions. One warmup precedes five samples in alternating size
order. The command parses, checks, optimizes and emits C; it does not invoke a C
compiler or run the generated program. Linux `time -v` records child peak RSS.

| Source calls | Actual unique sites in work / all emitted functions | AMD64 median seconds / maximum KiB | ARM64 median seconds / maximum KiB |
|---|---:|---:|---:|
| 16 | 16 / 16 | 0.422 / 44,528 | 0.371 / 44,080 |
| 32 | 26 / 27 | 0.446 / 45,500 | 0.388 / 44,968 |
| 64 | 26 / 27 | 0.467 / 50,004 | 0.407 / 49,588 |

Larger sources reuse emitted helpers after the inlining limit, so source-call
count is not the number of independent proof candidates. The current proof visits
up to N expression nodes for each of M candidates: O(MN) worst-case work. These
samples establish practical costs for the named inputs, not linear complexity,
proof-only memory use, or an incremental time saving against A3. The existing G2
analysis budgets remain a separate gate.

## Cleanup and rejection controls

The native probes call real exported entries at O1/O2. They check lengths 0, 16
and 4,096, failure during construction, failure while a completed array remains
live, and cancellation during a yielding callback. The array must allocate once,
free once and receive no count operation; independent live-byte accounting must
return to its baseline. Injecting an extra count operation or skipping the actual
free must fail the relevant observer.

Returned aliases must survive releasing their container. The escaping-callback
case returns a record containing a function, then invokes the function twice
after freeing the record. This forces a real escaping owner; a curried function
alone can be flattened into a local call. An exported function accepting an
unknown callback is also invoked through a runtime function value. None may
allocate unique storage. Removing a required owner or injecting unique storage
must make these controls fail.

Weak references currently target channels, not arbitrary arrays. Attempts to
pass an array to `channel.downgrade` or `channel.upgrade` must fail type checking;
they must not create count storage or silently promote the array.
