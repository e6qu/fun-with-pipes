# Preparation handoff: collection construction

## Next action

Next: run the six-host `collection-build` evidence suite on this preparation,
while finishing active PR #165 from the root workspace. Do not open another PR
until #165 is accepted. Fix every failed check before delivery.
The authoritative delivery handoff is
`/Users/zardoz/projects/fun-with-pipes/docs/development-state.md`.
This worktree prepares numeric collection construction and has no active PR.
Original measured source `cf2fb20c1cf3326187b998789bc31990cfcbcf65` and run
`39096618831` are fully audited: 62 passed, 16 failed, no ignored tests.
Three AMD64 failures come from a test deriving a key from 0/0, whose NaN sign is
implementation dependent. Use explicit parsed NaNs of both signs, preserving exact
output comparisons. Windows ARM64's direct toolchain download was forbidden;
all 13 checks then continued with the wrong compiler and failed on `ssize_t`.
All failure traces were audited. Authenticated pinned-asset download and explicit
toolchain-success conditions repair this, including sibling focused jobs.
Publish one bundled repair after local checks; rerun all six hosts and preserve
these failed logs separately. Audit via `/private/tmp/fwp-audit-collection-build.py`
with a separate repair output prefix. Only after the new run passes, dispatch
`collection-report` using its run and exact source IDs. It audits all four test
targets, verifies raw counters/timings and inspects 120 actual binaries as data on
GitHub, retaining disassembly and section sizes without executing downloaded code.
This avoids large local evidence processing. Its base is repaired PR head `836f39b3`;
rebase onto the accepted #165 tree before opening its delivery PR. Do not carry this
preparation-only handoff into the delivered branch.

## Measured problem

`range 0 n | map f | set.from-list` still builds both range and mapped lists.
The map variant also builds a tuple for each key/value pair. A guarded tiny
allocation probe at n=8 and n=32 observes 23/71 managed allocation requests for
sets and 32/104 for maps. Results match raw interpretation; all runs finish with
zero counted bytes, retains and collections. Reproducer and saved source/C/data:
`/private/tmp/fwp-collection-baseline.py` and `/private/tmp/fwp-collection-baseline/`.
Do not rerun it with a differently sourced shared compiler and keep the old ID.

The maintained `bench/map` builds 500,000 pairs and performs two million lookups.
The passing source-7c2b5638 Linux AMD64 benchmark records 423.266 ms for fwp,
382.480 ms for C and 311.772 ms for Rust (six-run medians). All use sorted pairs;
sorting implementations differ. These whole-process timings include construction
and lookup, not their separate costs. Current report is in the root workspace at
`docs/measurements/complete-programs-2026-10-18.json`. No timing improvement can
be inferred from the tiny allocation counts alone.

## Candidate and acceptance

Keep syntax unchanged. First consider compiler-internal construction that writes
numeric map/set results directly into temporary arrays and sorts them after all
callbacks finish. Remove the range list when bounds and callback behavior permit;
use the existing direct worker convention to avoid temporary key/value tuples.
The first prototype now combines numeric `map` followed by map/set construction.
It keeps the input list, runs callbacks in order into temporary key/value arrays,
and reuses typed sorting/build cleanup. Interpreter handling and ownership contracts
are present. I64 range-list removal is implemented; direct callback result fields
now pass focused semantic checks. Eligible expression workers return both numeric
fields directly; dynamic callbacks retain the same protected construction buffers.
No general platform acceptance or timing improvement is claimed.

The focused `collection_construction` test passes locally (26.90 s guarded): raw
interpretation agrees with enabled/disabled construction fusion at O1/O2 in ARC
and stressed tracing/reuse. The first compile failed because the interpreter tried
to move a field out of a Drop type; borrowing that record field fixes it.
A tiny instrumented rerun passes (6.88 s guarded): set requests fall from 23/71
to 14/38 at 8/32 inputs, map requests from 32/104 to 23/71. All retain counts,
final charged bytes and collections remain zero. Set peak charged bytes are
unchanged; map peaks fall to the same 704/2432 bytes as sets. This removes one
allocation per element plus one fixed allocation, but leaves range nodes and map
callback tuples. A later range prototype removes the range list as well: sets
make 6/6 allocation requests and maps 15/39, with 448/1408 peak charged bytes
and zero final bytes, retains and collections (7.07 s guarded). Driver:
`/private/tmp/fwp-collection-range-prototype.py`; saved data:
`/private/tmp/fwp-collection-range-prototype/`. Expanded semantic checks pass
(14.10 s), including integer edges, signed zero/NaN, aliases, empty/reversed
ranges and effects. Failure/cancellation checks remain required.
The driver `/private/tmp/fwp-collection-prototype.py` records hashes of its
uncommitted implementation; outputs are in `/private/tmp/fwp-collection-prototype/`.
Never relabel these results as a committed source or a C/Rust timing comparison.

Direct numeric map workers now make 7/7 requests at 8/32 inputs; sets stay
at 6/6, with zero retains, final bytes and collections (6.88 s guarded).
Captured strings, dynamic callbacks and string-input aliases pass (15.26 s).
Caught callback failures at several positions also pass, with zero-byte ARC
shutdown (10.96 s). The six-builder probe passes 54 allocation failures and 48 callback exits per
configuration at O1/O2, in ARC and stressed tracing/reuse. Deliberately missing
cleanup fails with the expected live-allocation diagnostic. Its first attempt
matched unused platform stubs; instrumentation now selects native definitions
and accounts for both object and array release paths. Serial formatting, focused
Clippy and all three collection tests pass together (44.53 s guarded).
Direct-worker data and implementation hashes are in
`/private/tmp/fwp-collection-worker-prototype/`; driver is
`/private/tmp/fwp-collection-worker-prototype.py`. Original and intermediate
measurements remain separate. Full platform and timing evidence is still required. The new `collection-build`
suite covers six native hosts and saves actual binaries. Runner-only
`scripts/measure-collection-build.py` compares enabled/disabled fusion with the
same compiler and program at 32/4096/65536 inputs, recording eight timings in
randomized order, allocation counts, compiler commands, code size and assembly.
It does not compare C/Rust; the production benchmark remains that comparison.
Windows production and the regular macOS schedule include the new target.
The first docs preflight caught the missing seven-step table in this preparation
handoff; the table is restored before publication. Report-tool syntax and workflow checks
also pass (7.34 s guarded). The corrected docs/workflow/fixture
preflight passes (6.89 s), including all eight native-runner checks. One invocation
used the root directory by mistake and found no prototype script; rerunning in
this worktree resolved that command error.

Additional checks pass for side effects in both range bounds and callback
captures, including empty ranges (15.57 s guarded). Caught failures with
dynamically produced input lists and runtime-read captured strings also pass
(12.76 s), including the neighboring mapped-array path. These strengthen tests
after the measured source; compiler and runtime code are unchanged.

Preserve callback and capture evaluation order, empty/reversed ranges, checked
arithmetic, first-key/last-value duplicate behavior and floating-key ordering.
Check aliases, traps at multiple callback positions, captured values, cancellation
and each allocation failure. Include signed/unsigned widths, floating signed zero
and NaN, dynamic callbacks and ordinary list sources in the coverage decision.
Do not silently reinterpret wide numeric fields or claim unsupported patterns.

Compare raw interpretation, ordinary native execution, checked ARC and disabled
optimization controls. Measure small input slopes, larger representative inputs,
code size and stack use; compare repeated native C/Rust timings with explicit
work differences. Inspect actual saved binaries on six native hosts. Keep full
builds, gates and large measurements on CI; local checks use the root guard.

## Collection repair verification

Repair `488d182203605870ab34d5f431c62f5d58a2a7b1` is published on `collection-build-storage`.
New six-host run `39098119495` is queued/running. Audit using
`/private/tmp/fwp-audit-collection-repair.py`; results and logs use the separate
`fwp166-collection-repair-*` prefix. Keep original run `39096618831` unchanged.


All three focused collection tests, formatting and Clippy pass after the NaN
fixture repair (34.11 s guarded). The test covers parsed F32/F64 NaNs of both
signs and duplicate keys while retaining exact interpreter/native comparisons.
Workflow lint, documentation, eight native-runner checks and fixture formatting
pass (7.58 s guarded). Commands: root `scripts/local-guard.py python3
/private/tmp/fwp-collection-preflight.py` and `... /private/tmp/fwp-collection-doc-preflight.py`,
both from the preparation worktree. The authenticated Windows download still
requires native CI verification. Every known failing collection target was audited
before publication; original failed logs remain separate.

The collection report now requires all four named targets and their individual
expected test counts. Its first parser split on Cargo stderr headers, but GitHub
can print the next header before the previous stdout summary; the audit now checks
those ordered streams independently. A matcher escaping mistake was also fixed.
The repaired audit accepts both complete original ARM hosts and rejects all four
failed hosts plus four incomplete/wrong-target controls (0.15 s guarded).
`scripts/test-collection-evidence.py` passes three regressions (0.15 s guarded),
covering interleaving, Windows ANSI paths, missing/duplicate targets, failures,
ignored tests and incomplete summaries. These are report-tool changes only;
measured compiler source and the six-host repair run remain unchanged.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Finish host/result owners, partial cleanup and tracing removal |
| 2 | In progress | Remove functional intermediates, input copies and unnecessary counts |
| 3 | In progress | C/Rust gaps, register/cache use and code costs |
| 4 | In progress | Differentiation precision, speed and memory scaling |
| 5 | In progress | CPU kernels and GPU resource ownership |
| 6 | In progress | Dependable repeated performance comparisons |
| 7 | In progress | Larger representative applications |


All seven project work areas remain in progress; see root PLAN.md. The current
preparation addresses avoidable functional intermediates and map construction
costs. It does not finish tracing removal or establish C/Rust parity.
