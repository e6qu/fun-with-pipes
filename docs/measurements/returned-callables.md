# Returned functions compared with C and Rust

This is preparation for B1's callable comparison, not a result. Finish the State
range delivery before publishing this as another PR. No measurements have run.

Partial application supplies one argument and keeps a function waiting for the
next. For example, `add 7` produces a function that maps `3` to `10`. The captured
`7` must remain available after the creating call returns. It does not, by itself,
require heap storage: a representation can keep that scalar directly in a
returned value. This comparison must expose that choice rather than force every
language to allocate as fwp does today.

## Equal work and observable lifetime

Compare two operations from the maintained
[call fixture](../../tests/fixtures/functional_costs.fwp):

| Operation | Captured value | Input `x` | Result |
|---|---|---|---|
| Partial addition | `7` | `x` | `7 + x` |
| Captured composition | `7` | `x` | `2 * (7 + x)` |

Keep checked signed 64-bit arithmetic in all implementations. A factory returns
the callable; a different caller then invokes it 1, 16 or 4,096 times with inputs
`0` through `n - 1`, checks every result, and destroys it. The addition checksum
is `7n + n(n - 1)/2`; composition doubles it. A direct-call control does the same
arithmetic and number of calls, without constructing an escaping function.
These cases fit I64; separate overflow cases must fail at the matching addition
or multiplication before subsequent calls run.

The fwp boundary uses its real partial-application constructor, callback metadata
and borrowing invocation interface. Do not call a saturated native entry with
too few arguments. The caller owns the callable across repeated calls and
releases it once. Reuse the existing typed-entry preflight; reject a missing
callback entry. The identity export needed to retain metadata is not constructed
inside the observation.

C and Rust return an owned value containing a function pointer and an inline I64
capture. Invocation borrows that value; destruction has no payload to free.
Do not add malloc or `Box` solely to imitate fwp's current representation. This
is a comparison with explicit callable records, not every C callback API or a
Rust trait-object benchmark. Report the actual size/alignment of each returned
value and fwp's separately allocated capture storage.

Prevent the caller from assuming a particular callback identity through a real
separate compilation boundary, with link-time optimization disabled. Retain the
ordinary binaries and compiler reports to check which dispatch survives. Keep a
separate direct-call control; do not label required indirect dispatch a fallback.
No runtime code generation or dependency on an older fwp compiler is involved.

## First verification batch

Before timing, establish these facts on production GCC ARM64/AMD64 and Clang
ARM64, with generated code at O1 and O2:

- Raw and optimized interpretation agree with the independent integer formulas.
  Native fwp, C and Rust check every result, including repeated calls after the
  factory has returned. Empty work constructs and destroys a callable without
  invoking it; positive cases use the three counts above.
- Record construction, invocation and destruction separately: managed/payload
  requests and bytes, effective retains/releases, runtime applications and peak
  live requested bytes. Report count-slot storage separately from payload.
  Observation code is excluded from ordinary code-size or later timing results.
- Every completed callable restores its initial live-storage baseline before
  runtime teardown. Inject a recoverable failure after creation and midway
  through repeated calls, then perform a successful retry in the same scope.
  An intentionally omitted fwp release must fail the storage observer while
  preserving the arithmetic results. C/Rust inline scalar records have no
  allocation failure point; do not invent one or imply they test fwp's allocator.
- Retain actual sources, complete commands, compiler/target versions, binaries,
  output/status records and code/frame reports. Report worker and whole-text
  bytes separately, and state that a largest frame is not a total stack bound.

There is no predeclared zero-allocation expectation for the fwp boundary: the
first report establishes its actual remaining cost. That report accepts no
compiler optimization and makes no elapsed-time claim. A later timing protocol
must explicitly cover construction, invocation, destruction and whole-program
time, control every compared executable, and qualify two sessions on each named
Linux CPU before setting a candidate budget. Existing failed timing controls in
other workloads remain failed; this experiment cannot replace them.
