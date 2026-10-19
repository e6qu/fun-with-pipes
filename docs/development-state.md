# Session handoff

## Next action

Branch: `compact-set-storage`, based on accepted PR #171 merge
`f3f3bd811c6d3935cd84fca2f7e6e877dc13c3d0`. Its files match tested head
`13210b757db74379c4f1d9893fd0049d2e774916`; all nine production jobs
(`39276733207`) and documentation (`39276733233`) passed.
[History](roadmap-history.md#mixed-tail-recursion-pr-171) records that delivery.

[PR #172](https://github.com/e6qu/fun-with-pipes/pull/172) is a draft. Focused run
[39292052172](https://github.com/e6qu/fun-with-pipes/actions/runs/39292052172)
on `dcdf8f82094dc5763e99454ae60bf1231c1d4651` passed formatting, all-target
Clippy and 39 of 41 tests. Documentation `39292057238` passed. Both test failures
were reviewed: the allocation probe selected an unused export from a main-only
build, and the omitted-drop control leaked duplicate set keys before fault
injection began. The probe now explicitly builds `--fn build-set`; the control
omits drops only while an injected fault is armed. These repairs await CI.

Next: publish both repairs with the report/documentation updates and run the
six-host collection matrix. The first Linux run already checked all targets;
repeating only that host would add a cycle before platform coverage. Fix every
reported failure, collect the report, then start the complete production matrix.
Use `suite=collection-report` on GitHub to audit the six-host run and inspect its
saved binaries. Include actual WASI checks. Require all nine production jobs and
documentation for the final head before squash merge. Full compiler builds and
large evidence collection stay on GitHub runners.

The report collector now requires all 41 tests and four compact-set allocation
and binary configurations per host. Map failure counts are 104 normally and 106
with reuse poisoning: smaller sets fit more entries before a growth allocation.
The two cleanup controls still failed as intended. Earlier run `39291722740` was
cancelled before starting; draft production jobs are skipped, not passed.

Duplicate post-merge run `39289648247` was cancelled on the identical accepted
PR #171 tree. It had no failed jobs; cancellation is not acceptance.

## Current batch

Sets store keys without unused unit-value slots. Maps keep key/value pairs,
including maps with unit values. The interpreter uses a distinct set value so
compile-time constants generate the right layout. Native construction, updates,
set operations, typed cleanup, decoders, JSON, comparisons and hashing use the
appropriate stride. Logical values and evaluation order remain unchanged.

For a freshly built set of `n` distinct keys, requested container storage changes
from `8 + 16*n` to `8 + 8*n` bytes. Empty sets use static storage. This excludes
allocator headers, rounding, scratch and separately allocated keys. Insertion can
reserve capacity. There is no elapsed-time or C/Rust parity claim.

Tests compare raw/optimized interpretation and native ARC/tracing at O0/O2 with
an independent output reference from the accepted compiler. Coverage includes
nested/string/wide-number keys, shared updates, JSON, hashing, protocol round
trips, REPL linking, compile-time constants and actual WASI execution. A native
probe observes allocation requests for 0, 1, 7, 257 and 4096 keys; a deliberate
extra-slot control must fail. Existing exhaustive allocation/retain failures and
cancellation checks remain. Focused CI saves generated C, executables,
disassembly, requested bytes and allocator-charged bytes.

## Checks and limits

All local workloads use `python3 scripts/local-guard.py`, serially, with unchanged
limits. The downloaded accepted ARM Mac compiler at
`/private/tmp/fwp-170-accepted-macos/fwp-macos-arm64/fwp` identifies head
`142117d2`; it supplies reference behavior, not validation of new code.

- `cargo fmt --all`: passed in 1.55 seconds.
- Accepted compiler `fmt tests/fixtures/compact_sets.fwp tests/fixtures/static_constants.fwp`:
  passed in 0.01 seconds.
- `env FWP_NO_OPT=1 <accepted-compiler> run --interp tests/fixtures/compact_sets.fwp`:
  passed in 0.34 seconds; twelve output lines saved as the regression reference.
- The documentation audit first caught a missing status table in this rewrite;
  restored the seven-area table and explicit next action. The audit then passed
  in 3.07 seconds (60 document sets, 106 anchors and seven work areas).
- `cargo fmt --all` after the decoder extension passed. Native decoder coverage
  now includes sets, text round trips, every truncated binary prefix and injected
  failures during set insertion.
- `clang -fsyntax-only -std=gnu11 /private/tmp/fwp-runtime-syntax.c`: passed in
  0.37 seconds. A tiny accepted-compiler translation unit supplied scaffolding;
  its four changed runtime sections were replaced verbatim with current sources.
- `clang -std=gnu11 -O0 /private/tmp/fwp-compact-runtime.c -lm -o /private/tmp/fwp-compact-runtime`
  and the corresponding O2 build passed (0.26/0.38 seconds). These focused C
  probes call the current runtime builder directly, not the new compiler's
  generated wrapper. Both executions passed: requests for 0/1/7/257/4096 keys
  were 0/16/64/2064/32776 bytes; charged bytes were 0/16/64/2560/32776.
  ARC charge returned to its starting value after every result was freed.
- `otool -tvV /private/tmp/fwp-compact-runtime-o2`: passed; saved assembly shows
  eight-byte indexed key loads/stores. This is ARM64 runtime evidence only.
- The control restoring an extra word per key exited 211 as required: one key
  requested 24 bytes instead of 16. Its bounded build/run took 0.14/0.37 seconds.
- Final documentation audit passed in 3.06 seconds; `git diff --check` passed.
- CI passed raw/optimized set output, typed map/set aliases and failures, protocol,
  REPL, constants and collection construction checks. The new compact allocation
  probe did not reach execution; decoder positive cases passed before its control
  assertion failed. All native/WASI acceptance remains pending.
- The accepted compiler `build --emit-c --gc arc --fn build-set` retained the
  selected builder (0.27 seconds); this checks the repaired selection only.
- The documentation audit passed in 3.00 seconds after replacing stale current
  claims about the Xeon regression with links to its later accepted repair.
- `python3 scripts/test-collection-evidence.py`: all five report checks passed in
  0.34 seconds. They reject missing/failed tests, cancelled runs, extra set slots,
  incorrect charges and incomplete measurements.

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

All seven areas in [PLAN.md](../PLAN.md) remain open: remove tracing and limit ARC;
remove avoidable functional costs; close measured machine-level gaps; improve
differentiation; strengthen numerical kernels; establish dependable performance
budgets; validate larger applications. Persistent subscriptions, unknown retained
captures, resource-owning tail frames and mutual recursion need further proofs.
JIT is excluded. Use representative applications and equivalent-work measurements
to choose the next cost after this batch, and move accepted evidence to history.
