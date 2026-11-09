# fwp allocations during weak-reference operations

**Native checks queued; no GCC count result yet.**
Source `54b818abc`, tag `roadmap/weak-operation-census-2026-11-09`,
[run 42651550496](https://github.com/e6qu/fun-with-pipes/actions/runs/42651550496). This diagnostic measures the actual fwp
operations from the [phase comparison](weak-operation-phases.md), separately from
[ordinary timings](weak-operation-time.md) and [native C/Rust/Swift allocation
profiles](weak-operation-storage.md).

A successful `channel.upgrade` returns `Some channel`; an expired one returns
`None`. The `Some` value can require its own heap cell in addition to the channel
and weak metadata. We need to measure that cell before attributing a lookup cost
to reference counting. Source code alone does not establish an optimized caller's
allocation count.

## Observer boundary

[The source adapter](../../scripts/weak_operation_census.py) counts actual calls
to the generated runtime's managed-allocation charging function. It records:

- allocation events and charged slot bytes in each of the six phases;
- the subset charged while constructing the successful `Some` result;
- live slot bytes at each phase end and peak live slot bytes within the phase.

Small values are rounded to runtime size classes. A 17-byte request uses a
32-byte slot; a 33-byte request uses a 48-byte slot. These are **managed storage
charges**, not native allocator requests, object payload sizes, OS pages or ARC
operations. Runtime initialization is excluded by an explicit live-byte baseline.
The separately allocated C caller arrays are outside that managed-heap boundary.

Use populations/lookups `(1,1)`, `(64,16)`, `(4096,1)` and `(4096,64)` at native
GCC O1/O2. Call the current generated owning entries and perform one complete
lifetime per process. Live lookup must preserve all existing owners; expired
lookup must preserve the weak owners. Final release must restore the baseline.
The reader accepts zero result-cell allocations: it must not assume that a future
compiler keeps the present representation.

## Real controls and verification

Before each observation, allocate 17 and 33 bytes through the actual managed
allocator, hold both, then release both. Require two allocation events, 80 charged
bytes, an 80-byte live peak and zero remaining bytes. Independent control paths
add a real extra allocation or omit a real free. Both must fail that calibration
with its specific diagnostic. A crash is not an accepted observer rejection.

[The collector](../../scripts/check-weak-operation-census.py) retains original and
instrumented C, fixtures, native images, commands, source/compiler identities,
eight ordinary observations and eight allocation/free/argument controls per host.
All independent cases run even if another fails. The final audit reconstructs
observations from raw commands and verifies fixture/source and native-image hashes. Reader tests reject malformed
records, inconsistent counts/bytes, lost owners and unfreed final storage.

Run `suite=weak-operation-census` in the numerical workflow. The shared native
builder selects the census caller explicitly; it does not alter the frozen timing
caller or ordinary runtime. Three local reader tests pass. Native execution is
required before reporting counts. Instrumented execution is not a timing result,
and its allocation counts alone do not prove an ordinary binary's machine-level
operation count.

## Focused observer check

[Apple Clang O2 diagnostic receipt](weak-operation-census-local.json), using the
retained generated source from `8848e837c`: for 64 targets and 16 lookups per target,
live lookup charges 1,024 result cells of 16 bytes each. Its peak adds only one
16-byte cell because each result is released before the next lookup. Expired
lookup charges zero allocations. Actual extra-allocation and omitted-free controls
both fail with status 79 as required. The local guard reports 0.19 CPU seconds and
0.85 elapsed seconds; no limit was raised.

This verifies the observer on that retained source with Apple Clang. The rebuilt
current compiler and native GCC O1/O2 counts still need runner verification.
