# Session handoff

## Next action

Branch: `compact-set-storage`, based on accepted PR #171 merge
`f3f3bd811c6d3935cd84fca2f7e6e877dc13c3d0`. Its files match tested head
`13210b757db74379c4f1d9893fd0049d2e774916`; all nine production jobs
(`39276733207`) and documentation (`39276733233`) passed.
[History](roadmap-history.md#mixed-tail-recursion-pr-171) records that delivery.

[PR #172](https://github.com/e6qu/fun-with-pipes/pull/172) is a draft. The initial
focused `collection-build` run `39291722740` queued without starting; the next
revision adds the native decoder set/truncation checks found during review.
Next: replace the queued run with the completed revision, fix every failure, then
run the complete native matrix, WASI checks and documentation gate. Merge only
after all nine production jobs and documentation pass for the final head.
No new compiler build has run locally; added tests are not acceptance evidence.
Full builds and measurements belong on GitHub runners.

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
- New Rust/C compilation, ownership probes and native/WASI execution are pending CI.

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
