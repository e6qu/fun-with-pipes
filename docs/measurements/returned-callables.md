# Returned functions compared with C and Rust

The first B1 callable baseline passes focused checks on all three declared hosts.
The runtime change merged in #234 now passes all nine production jobs and docs;
[delivery history](../roadmap-history.md#borrowed-calls-and-swift-comparisons-pr-234)
records that validation. It still exceeds the original ARM64 O1 code-size limit.
The user prioritizes runtime performance and working memory. The
[phase comparison with Swift](callable-phases.md) finds faster invocation but
three AMD64 construction regressions; combined timing acceptance remains open.
Preserve the original rejection.

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

## First baseline

Run `41175225918` at `7d7cf98b` passes GCC ARM64/AMD64 and Clang ARM64. Every
job log was audited: eight Python controls and eight ordinary/profiled programs
per host. The independent checker recomputes all 170 commands per host, source
and binary hashes, results, ownership phases and frame/code records. The
[complete retained archive](returned-callables-baseline-2026-10-31.json.gz)
includes the actual binaries, generated C, command outputs and job/artifact IDs.
Its source is retained by `roadmap/returned-callables-baseline-2026-10-31`.
`python3 scripts/test-returned-callable-evidence.py` rechecks the archive and
rejects altered summaries, binaries, sources and command outcomes without running
an old compiler or executable.

Both operations have these costs at O1 and O2 on all three hosts:

| Cost | fwp | C and Rust callable records |
|---|---|---|
| Returned value | 8-byte pointer | 16-byte inline value |
| Captured payload | One 16-byte heap request | Capture is inside the value |
| Each borrowed call | One retain, one release, two runtime application entries | Direct use of the inline capture and function pointer |
| Destruction | One final release and one physical payload free | No heap payload to release |
| First-use count table | 4,096 bytes, retained for allocator reuse | None |

The fwp pointer plus payload is not the process's total memory cost: arena
backing, stack and other runtime storage remain outside these payload counters.
All normal and recovered operations restore payload storage. Omitting releases
preserves every arithmetic result but leaves 128 payload bytes and fails the
storage observer. C/Rust need no fabricated allocation-failure control.

Ordinary O2 code and reported frames are:

| Host / implementation | Worker bytes | Whole text section | Largest reported C frame |
|---|---:|---:|---:|
| Linux ARM64 / C | 320 | 1,508 | 320 |
| Linux ARM64 / Rust | 320 | 1,540 | 320 |
| Linux ARM64 / fwp | 1,284 | 24,316 | 704 |
| Linux AMD64 / C | 320 | 1,529 | 336 |
| Linux AMD64 / Rust | 288 | 1,545 | 336 |
| Linux AMD64 / fwp | 1,307 | 25,090 | 720 |
| macOS ARM64 / C | 312 | 1,364 | 144 |
| macOS ARM64 / Rust | 312 | 1,404 | 144 |
| macOS ARM64 / fwp | 1,156 | 13,352 | 592 |

The C frame column includes the common observer. Rust's own largest reported
frame is 16 bytes on ARM64 and 8 on AMD64. fwp keeps its ordinary runtime and
additional recovery controls; Rust is a `core` callable library, not a whole
Rust application. These text totals expose that difference rather than isolate
only language overhead. A largest frame is not an aggregate stack bound.

## Next candidate and limits, declared before implementation

For an **exactly saturated borrowed call**, use the existing typed entry directly
when its complete parameter metadata proves there are no owned arguments.
Copy plain captures and supplied values before entering the callback. Keep the
caller-owned closure intact, return the entry's owned result, and preserve
failure/cancellation order. Underapplication, overapplication and owned captures
keep their ownership handling. Add no syntax, metadata field or forwarding entry.

The generator already emits no argument destructor only when the full arrow
spine has no owned parameters. Audit handwritten metadata before using that fact;
several test fixtures omit their argument-destructor field and need explicit,
correct entries. Add controls for scalar bits resembling pointers, owned results,
failure inside the callback, cancellation, partial/extra arguments and aliases.

Against this frozen baseline, at O1/O2 on **all three hosts**:

- Each observed scalar invocation must use zero effective retains/releases and
  one runtime application entry. Construction, destruction, result and metadata
  storage costs must not increase. The omitted-release control must still fail.
- Worker bytes and whole text-section bytes must each stay at or below 105% of
  the baseline. The largest reported C frame and the sum of reported borrowed-
  application helper frames may each grow by at most 64 bytes. Keep dynamic
  frame labels and do not describe these estimates as a total stack limit.
- All existing ownership, resource, failure/cancellation and interpreter/native
  controls must pass, followed by the complete final production matrix.

These are count/code/stack limits, not a speed budget. Retain rejected results.
This candidate cannot close D2/N1 timing acceptance or establish C/Rust parity.

The original whole-text rejection remains below. The [follow-up phase experiment](callable-phases.md) assesses
performance and working memory under the user’s updated priority; the count
savings alone do not prove a speedup.
`scripts/check-returned-callable-budget.py` independently recomputes the retained
commands and results before comparing every limit with the frozen baseline.
It writes all decisions before rejecting a failed budget. Its rejection tests
cover each limit, missing frames and missing phases. No accepted speed result is
inferred from removing count operations.

## Rejected first candidate and linker diagnosis

Run `41177534238`, source `1f929022`, passes 49 ownership tests and 14 Python
checks per host. Every count/storage and frame limit passes at O1/O2. Five
code-level comparisons pass; Linux ARM64 O1 whole text grows from 24,540 to
28,892 bytes, exceeding the unchanged 5% limit. This candidate is rejected.
The [complete archive](returned-callables-rejected-2026-10-31.json.gz) preserves
all three hosts, commands, binaries, logs and decisions. Its immutable source tag
is `roadmap/returned-callables-rejected-2026-10-31`.

Decoded instructions grow by 272 bytes; 4,080 additional text bytes are zeros.
The [linker diagnosis](returned-callable-link-2026-10-31.json.gz), run
`41178567613`, reproduces all four original ARM executables byte for byte while
emitting maps. GCC 13.3 invokes GNU ld 2.42 with `--fix-cortex-a53-843419`.
The candidate O1 map contains a 16-byte `.text.stub` occupying a 4-KiB region.
This matches the [linker's documented erratum handling](https://sourceware.org/legacy-ml/binutils/2015-03/msg00445.html).
The padding is real output cost and remains in the rejected budget; hardware
protection stays enabled. The runtime's lifetime checks passed independently.

The next revision copies the two contiguous plain-value slices with `memcpy`
instead of separate element loops. It skips the supplied-slice copy when empty,
because that slice may be null. A saturated closure with no new arguments joins
the existing lifetime regression. Run `41179056746` at `dacaf253` passes all
49 ownership tests and 16 Python controls per host. The
[second complete archive](returned-callables-copy-rejected-2026-10-31.json.gz)
retains the unchanged sole rejection: ARM O1 text is still 28,892 bytes.
All other limits pass; macOS O2 text shrinks relative to the first candidate,
while AMD O2 text grows by 80 bytes and remains within its limit. The revision
does not qualify under the original whole-text rule. This source simplification
is not a general promise to avoid linker padding, nor a measured speedup.
