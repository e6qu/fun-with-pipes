# Returned functions compared with C and Rust

This is preparation for B1's callable comparison, not an accepted result. Finish
the State range delivery before opening another PR. Focused Clang checks pass;
the complete three-host evidence collection is next.

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

A common C observer drives the three implementations through their native
interfaces. Compile the C and Rust callable implementations separately from that
observer. The Rust scalar worker uses `core` without an allocator or standard-
library startup; it is a Rust callable library, not a whole Rust application
comparison. All peers report overflow through the same observer function.
This reporting path is outside successful arithmetic; no success path calls it.
Keep these boundaries explicit in later code, storage and timing reports.

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

## Running and reading the checks

The `returned-callables` suite in the numerical evidence workflow builds the
current compiler, then checks GCC on Linux ARM64/AMD64 and Clang on macOS ARM64.
Each host runs O1/O2 peers, ordinary and separately instrumented fwp programs,
raw/optimized interpretation, overflow cases, and failure/retry controls.
`scripts/check-returned-callables.py` records every command and its output before
checking it. A failed collection retains its partial directory; it is not a
passing baseline. No previous fwp executable is required.

In each counted row, phase 0 constructs the callable, phase 1 invokes it, and
phase 2 destroys it. Phase 3 separately checks failure and retry. The direct-call
control runs outside those counters. An application count records entry into a
runtime helper; it is not an instruction count or necessarily a separate indirect
machine call. Effective retains/releases count changes to real owners, excluding
no-op checks on scalar values.

Payload requests and their live-byte peak exclude slot padding, allocator backing
and stack space. The report also records charged payload bytes and count-table
bytes at each phase boundary. Freeing the last closure can restore payload storage
while the allocator retains a count table for reuse. That retained storage stays
visible in the report; it is not described as zero memory. C/Rust keep the capture
inside their 16-byte callable value and have no payload allocator call in these
workers. Their observer and process startup are outside that claim.

Instruction listings and frame reports come from ordinary builds. Worker byte
totals include decoded alignment padding and inlined arithmetic, and exclude the
shared fwp runtime and observer. The full listing and text-section output retain
those other costs. Rust's frame-report pass is an explicit setting: LLVM 22 names
it `prologepilog`; the current CI toolchain uses `prolog-epilog`. A missing or
mismatched report fails; the script does not retry with a different compiler setting.
