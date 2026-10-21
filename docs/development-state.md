# Session handoff

## Next action

Next: run a Linux AMD64 CI probe for the data-queue capture proof, fix all
failures, then run the full native and WebAssembly focused matrix. This is
preparation for the next substantial PR; do not open another PR before #184
passes its final gates and is merged. No new ownership support is verified yet.

Branch `prove-data-queue-captures` is in `/private/tmp/fwp-data-queue-captures`,
based on PR #184 review commit `0509937311ffd94171da9e2213c387d23e81739a`.
PR #184 remains active in `/Users/zardoz/projects/fun-with-pipes`; its final CI
is `39570320517`, with documentation `39570319685`. Its exact-head audit and
conditional merge helpers are `/private/tmp/fwp-audit-184-final.py` and
`/private/tmp/fwp-merge-184.py`. Keep the two checkouts and evidence separate.
After the squash merge, transplant this preparation onto the accepted main
commit, retaining its changes and the updated delivery history.

## Implementation being checked

The finite ownership analysis now tracks known queue creators and unknown queue
sources alongside function origins. A queued callback may capture a data-only
queue created by `channel.make`, including through records, lists or other
proved data queues. It checks values ever sent into nested queues; a known
creator must not hide an unknown owner in its contents. Existing type checks
still reject recursive queue ownership and function-bearing captured channels.
Tasks, HTTP streams, gRPC cells and single-use files remain excluded captures.
No runtime representation, weak-reference API or source syntax changes.

Unit controls cover known/unknown producer joins, nested contents, empty
containers, unrelated aggregate fields and callback-bearing queues. The new
`queued_data_channels.fwp` fixture covers delivery, repeated reads, aliases,
records/lists, nested and undrained queues, failure, blocked sends and
cancellation. Native tests instrument live queue objects with a 64-object bound
and require complete teardown; removing queue release must fail with exit 198.
The same fixture joins asynchronous WASI/browser-loader tests in JSPI and
Asyncify modes at O1/O2. These checks are added, not yet passed.

## Checks and limits

The accepted PR #183 macOS ARM64 compiler formatted the new fixture and its raw
interpreter printed `data queues released` for all 64 rounds. The first draft's
cancellation callback did not match task.spawn's permitted effect row; its
stored Wait function now declares that existing API contract explicitly. The
ordinary Event function keeps only Async. This source check does not validate
the new ARC proof. Rust formatting is applied; no local build or native C
compilation was run. Use `python3 scripts/local-guard.py` for all local checks.

The prior full-CI timing review and next ownership notes are in
`/private/tmp/fwp-183-test-duration-review.json` and
`/private/tmp/fwp-184-next-ownership-notes.md`. They identify repeated REST server
builds as a cycle-time investigation, without claiming a measured improvement.
Disk remains close to the 64 GiB floor. Preserve current inspected binaries;
cleanup receipts are recorded in the main checkout's handoff. Never raise limits.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing; prove retained ownership and cleanup. |
| 2 | In progress | Eliminate avoidable functional allocations and count traffic. |
| 3 | In progress | Resolve measured machine-code and performance gaps. |
| 4 | In progress | Improve differentiation time, memory and precision. |
| 5 | In progress | Validate numerical kernels and ahead-of-time GPU policy. |
| 6 | In progress | Establish equivalent-work comparisons and budgets. |
| 7 | In progress | Validate larger programs and bounded live memory. |
