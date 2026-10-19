# Session handoff

## Next action

[PR #174](https://github.com/e6qu/fun-with-pipes/pull/174) remains open on
`numeric-hash-delivery`. Its published head `d8554041` failed both Linux jobs:
**do not merge it**. Each complete Linux log contains 777 passed tests and one
failure: a captured tuple hashes zero fields under GCC. The other seven production
jobs and documentation passed. No other failure appeared in the complete logs.

The local branch combines the aliasing repair with integer-output preparation.
Next: publish this combined candidate on a preparation branch; run the six-host
`hash` suite, both-Linux `wasi-arc`, four-host `hash-costs` and both-Linux
`hash-alias`. The combined hash suite runs 76 tests per host and saves both hash
and output binaries, avoiding duplicate compiler builds. After these pass, run
`hash-report`, `integer-output-report` and `hash-specialization-repeat` with the
exact candidate revision and run IDs. Retain the reports, update the PR once,
then require all nine production jobs and documentation on that final head.

[PR #173](roadmap-history.md#direct-integer-range-sets-pr-173) merged as
`eb03eb58fb642500234b9bbe647adbcf59765415` after all gates passed. Its one-line
message and identical tested files were verified. All seven roadmap areas remain
open; this batch does not finish ownership or tracing removal.

## Changes and verification

Numeric hashing emits direct loops for supported scalar/collection shapes while
preserving canonical bytes and borrowed ownership. `FWP_TYPED_HASH=0` is the
comparison control. [The design](design.md#runtime) explains why generated stack
and static structures need explicit C aliasing rules. Five runtime view types now
use `__may_alias__`; their layout is unchanged and global alias analysis stays on.

Repair source `facc68e1d68f440ba9adf91b028b6db2051673f1` passed both Linux hosts
in run `39339268457`. Each compared 48 actual binaries across GCC/Clang,
O1/O2/O3, ARC/tracing and four view settings. Former ARC views produced the wrong
hash with GCC at all three levels on both architectures. Explicit views, an
object-only diagnostic and disabling alias analysis on the former views all
produced the correct result. Broader hash, static-value, closure, map/set and
field-move tests passed under both compilers. This isolates the defect; final
combined-source checks and performance measurements are still required.

Immediately consumed integer `show | print` (including inlined `echo`) now formats
in a 24-byte local buffer, avoiding its temporary owned String. Recognition occurs
before ownership lowering. Stored/shared strings and other displays retain their
normal work. `FWP_DIRECT_INTEGER_PRINT=0` selects ordinary output for comparison.
A 24-byte formatting buffer is not the whole machine frame or proof of no libc
allocation. The tests check widths, sharing, trap order, framed-output routing and
deliberately inserted allocation controls.

Standalone output source `7876237a77730334316216328e19c08262d5e4ab` passed six-native
run `39334254632` (42 tests), both-Linux WASI `39334258666` (48 tests) and 144-binary
inspection `39338461279`, collector `f90251baef3b8166cdc582096f82a5e5feb330b3`.
This precedes the aliasing repair and is not combined-source acceptance. Its report
is in `/private/tmp/fwp-direct-integer-output/docs/measurements/` until refreshed.
The Windows arithmetic probe now explicitly selects binary stdout; its arithmetic
assertions are unchanged. Production Windows CI permanently covers this probe and
integer output. Multi-target commands finish remaining targets after a failure.
WASI diagnostics recognize the new output primitive. Binary audits permit collector
elimination only in the specific O2 direct-print-then-trap case; ARC still requires
absence of tracing, and allocation-using tracing controls require its presence.

## Measurements to refresh

The existing [hash reports](benchmarks.md#numeric-hash-specialization) describe
source `6ffd2385a8207078cadd046d7dc2e3f3c389675f`, before the alias repair and direct
output. They preserve mixed timing results and remaining C/Rust costs, not current
performance evidence. Initial/report/repeat runs: `39317226192`, `39322404918`,
`39322408959`; six-native/WASI: `39317215955`, `39317221484`.
The new measurement runner explicitly enables direct output. Check its allocation
profile and saved machine code instead of carrying over the old two-request count.

The failed production head's benchmark report is retained at
`/private/tmp/fwp-174-production-bench.md`. All six programs remain recorded.
Its pipeline median changed from 16.983 to 26.089 ms against PR #173, but saved
pipeline C and all three executables were byte-identical. The guarded comparison
passed in 7.26 seconds; changed pipeline code cannot explain that timing shift.
This does not erase the remaining C/Rust gap. Retain the report as pre-repair
measurement evidence when updating the accepted history.

## Local checks

All local workloads use `python3 scripts/local-guard.py` with unchanged limits.
Full builds, test gates and benchmarks run only on GitHub.

- `/private/tmp/fwp-audit-current.py`: both complete Linux failure logs and 96
  alias-diagnostic binaries audited in 5.31 seconds. Only former GCC/ARC views
  fail; new views and no-strict-alias controls pass.
- `/private/tmp/fwp-audit-174-windows.py /private/tmp/fwp-174-windows-amd.log`:
  379 tests pass, six separately scheduled measurements ignored, in 0.15 seconds.
  ARM has the same counts. Two POSIX-only SDK terminal cases skip on Windows;
  these skips do not establish Windows terminal support.
- Both regular macOS logs: 489 tests and 11 SDK cases pass, none ignored.
  Each GC shard: 294 pass, 15 separate measurements ignored.
- Extracted runtime views retain layout and correct bidirectional access at O0/O2/O3
  (1.19 seconds). Extracted integer formatter matches 56 C decimal cases (1.03 seconds).
- Updated report validators: `scripts/test-hash-evidence.py` four tests,
  `scripts/test-integer-output-evidence.py` three and
  `scripts/test-collection-evidence.py` six pass (0.23/0.15/0.15 seconds).
  These test rejection of incomplete evidence, not language correctness.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Ownership contracts, tracing removal and limited ARC |
| 2 | In progress | Functional intermediates, copies and eligible tail recursion |
| 3 | In progress | Equivalent-work C/Rust gaps and machine-code costs |
| 4 | In progress | Derivative precision, speed and storage |
| 5 | In progress | CPU kernels and ahead-of-time device execution |
| 6 | In progress | Reproducible comparisons and regression budgets |
| 7 | In progress | Representative larger applications |

The next ownership design is [functions stored in channels](ownership.md#next-proof-functions-stored-in-channels):
prove both captured owners and where queued functions can be called. Arrow types
alone do not describe captures. No callback eligibility rule has changed.
Persistent subscriptions, unknown retained captures, resource-owning tail frames
and mutual recursion still need proofs. JIT is excluded.
