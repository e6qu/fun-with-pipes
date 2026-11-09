# Ownership comparisons: next measurement work

This is milestone 4 of the [roadmap](../../PLAN.md). It prepares comparisons,
not another compiler optimization. [The first native checks](ownership-peer-checks-2026-11-08/README.md)
cover Swift buffer results and C/Rust parser storage/frames. Peer timings remain
unmeasured. Freeze the complete protocol and source before collecting them.

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

Use the same external input/result barriers in all four timing peers. The new
Swift correctness fixture uses these barriers, while the old C/Rust fixtures use
inline barriers; those binaries do not yet establish a matched timing comparison.
Do not derive Swift allocation counts from `Array.count` or presumed capacity.
Check unique and aliased arrays separately, including validity of the surviving
owner after the other is released. Swift out-of-memory behavior is not promised
to match C/Rust's diagnostic exit code.

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
omit active release, expiration or metadata release and must fail. Verification
is pending on both native Linux architectures.

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
