# Session handoff

## Next action

[PR #174](https://github.com/e6qu/fun-with-pipes/pull/174) remains open on
`numeric-hash-delivery`. The initial head `d8554041` failed both Linux jobs and
is superseded by the combined repair. Each complete log has 777 passed tests and one failed
captured-tuple hash check. The other seven production jobs and documentation
passed. All failures were audited before preparing the combined repair.

Candidate `0bb385ab3fd35e5c1ff85f3af4923bbcf8d7afd8`, preserved by
`roadmap/revision-numeric-output-0bb385ab`, combines numeric hashing, explicit C
aliasing rules and integer printing without a temporary String. Its focused
checks and measurements pass. Binary collectors `39342427055` (hash) and
`39342433339` (output) also pass, inspecting 144 binaries each.

Next: finish production acceptance of the final PR update. Read the current head
and checks with `gh pr view 174 --json headRefOid,statusCheckRollup`; require all
nine production jobs plus documentation for that exact head before squash merge.
Keep the one-line commit subject at most 80 characters with an empty body.
The next ownership task is the queued-function proof linked below.

## Current evidence

All entries below use candidate `0bb385ab`; full builds and benchmarks run on
GitHub. Sharing one six-host compiler build for hashing/output reduces CI work.

| Check | Run | Result |
|---|---|---|
| Six native hosts | `39340918706` | 76 tests per host, 456 total; none ignored |
| Both-Linux WASI | `39340923998` | 24 tests per architecture; none ignored |
| GCC and Clang, both Linux architectures | `39340935160` | 34 tests per host plus 48 diagnostic binaries each |
| Four-host C/Rust comparisons | `39340929383` | All four pass; profiles and saved binaries retained |
| Same-binary repeat | `39341754517` | Four hosts, 24 balanced samples, 1,152 timed executions |
| Hash/output binary collectors | `39342427055` / `39342433339` | Complete logs, 288 binaries, source identities and tracing checks pass |

[Aliasing diagnostics](measurements/numeric-aliasing-2026-10-20.json) reproduce
the old GCC/ARC wrong hash at O1/O2/O3 on both architectures. Explicit runtime
views and the diagnostic no-strict-alias control produce the correct result.
Earlier source `facc68e1` passed the same comparison in `39339268457`. Its saved
O2 assembly shows that GCC removed tuple-field initialization stores with the
former views and keeps them with the repair. Five runtime view types now carry
`__may_alias__`; field widths, offsets and alignment do not change. Global alias
analysis stays enabled. See [the runtime explanation](design.md#runtime).

Direct integer output recognizes resolved `show | print`, including inlined
`echo`, before ownership lowering. It formats in a 24-byte local buffer and
preserves digits, stream routing and evaluation/trap order. Shared strings and
other displays keep their work. This is not the whole machine frame and does not
prove allocation-free libc output. `FWP_DIRECT_INTEGER_PRINT=0` and
`FWP_TYPED_HASH=0` are explicit ordinary-output/general-hash comparison controls.
The Windows arithmetic probe now selects binary stdout; production permanently
covers it and integer output. Multi-target preflight commands continue after
failures. WASI allocation diagnostics recognize the new output operation.

## Measurement interpretation

[The benchmark guide](benchmarks.md#numeric-hash-specialization) explains inputs,
C/Rust differences, timing scope and overhead. Current specialized/general ARC
profiles match: one managed input allocation, zero retains, no remaining charge.
Direct output removes the earlier second request. Counts exclude allocator
metadata and libc storage. Current results must replace earlier performance
claims; the pre-repair JSON reports remain linked as historical measurements.

[Repeated results](measurements/numeric-hashing-repeat-2026-10-20.json) show Linux
ARM64 large-array/set CPU medians 3.2%/1.4% lower, all 24 pairs faster with separated
ranges. Other hosts overlap. Linux AMD64 set median is 0.11% higher, with 12/24
pairs faster: inconclusive. Small fwp programs still use up to 32.1% more CPU than
C and 18.3% more than Rust. AMD64 changed from Xeon 8573C to EPYC 9V74 between
initial/repeat; each within-run comparison uses one host. No universal speedup.

The [failed head's six-program report](measurements/numeric-hash-pre-repair-peers-2026-10-19.md)
is retained. Its pipeline median moved from 16.983 to 26.089 ms against PR #173,
but pipeline C and all three executables were byte-identical. Changed code cannot
explain that timing shift; it does not erase the remaining C/Rust gap.

## Local checks

Every workload uses `python3 scripts/local-guard.py` with unchanged limits.
No full compiler build or benchmark ran locally.

- `cargo fmt --all -- --check`: pass, 1.51 seconds.
- `scripts/check-roadmap.py`: 62 link sets, 106 anchors and seven work areas,
  2.63 seconds with the retained reports and current documentation.
- Hash/output/collection evidence validators: 4/3/6 pass, 0.23/0.15/0.15 seconds.
- `/private/tmp/fwp-check-candidate-scripts.py`: seven changed Python scripts
  parse, 0.23 seconds. Real ARM macOS log audit: all 76 checks, 0.21 seconds.
- `/private/tmp/fwp-audit-candidate-wasi.py`: both complete logs pass, 3.76 seconds.
- `/private/tmp/fwp-retain-candidate-alias.py`: 96 diagnostic binaries and 68
  GCC/Clang tests audited, 9.45 seconds. Its first local audit needed terminal
  color stripping; no runtime result or assertion was weakened.
- `/private/tmp/fwp-retain-candidate-repeats.py`: all binary/source hashes,
  balanced samples and medians verified before retention, 6.76 seconds.
- `/private/tmp/fwp-retain-candidate-report.py hash 12229472801` and
  `output 12229656881`: source, count and profile checks pass, 8.01/3.24 seconds.
  Actual disassembly extraction passes in 9.51 seconds. Reviewed Linux set loops
  have no inner-loop calls or spills; AMD64 saves one register around the function.
  The caller still constructs a stack tuple. ARM macOS print-then-trap reserves
  112 bytes for its main-thread frame; runtime startup remains.

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

[PR #173](roadmap-history.md#direct-integer-range-sets-pr-173) merged as
`eb03eb58fb642500234b9bbe647adbcf59765415` after all gates passed; its one-line
message and identical tested files were verified. All seven areas remain open.
The [queued-function proof](ownership.md#next-proof-functions-stored-in-channels)
must follow captured owners and calls through queues. No eligibility rule has
changed. Persistent subscriptions, unknown retained captures, resource-owning
tail frames and mutual recursion still need proofs. JIT is excluded.
