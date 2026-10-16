# Session handoff

Updated 2026-10-16. This branch is independent preparation for the next service
context batch. The only delivery PR remains #153 at `ac3060d1`; its authoritative
handoff is in `/Users/zardoz/projects/fun-with-pipes/docs/development-state.md`.
Do not open another PR or repeat that delivery. Its native macOS runner checks
are `38938194232`, documentation `38938199569`; after passing, mark it ready and
require all nine full production jobs. Draft skips are not acceptance. Merge
only the tested head with an explicit one-line subject, empty body and no trailers.

## Preparation and acceptance

Workspace: `/private/tmp/fwp-context-owners`, branch `service-context-preparation`,
based on #153 preparation `ac3060d1`. No runtime ownership change is implemented
here yet. The first step measures repeated plain, gzip, deadline, outgoing-header
and response-capture scopes at 1, 32 and 128 calls. Every call increments state;
raw/optimized interpretation and native output must agree on the final count.
Instrumentation reports managed allocation requests, requested bytes and final
charged bytes with collection disabled. Raw TLS/capture buffers, allocator pages
and total process memory remain outside those counters. This is an fwp baseline,
not a speed or C/Rust comparison.

Baseline `49e9e604` was published with focused Linux run `38939097999`.
The preparation now also checks detached children after scope return, typed
failure, trap and cancellation. They must retain header copies, compression and
the earliest deadline, and restore their own nested scopes. A deliberately
omitted inheritance path must fail. This fixture is prepared, not yet verified
natively; the next publication supersedes the queued baseline with both checks.
Next: finish the replacement `context-storage` run and retain its exact revision.
Fix failures and retain baseline artifacts before changing scope storage.
Then prefer stack contexts for scopes that do not escape and explicit ownership
for child tasks that keep the context after callback return. Preserve nested
restoration, typed errors, traps, cancellation, metadata/certificate lifetimes
and child-task cleanup. The broader connection/stream ownership remains open.
After #153 is accepted, rebase only this branch's delta after `ac3060d1` onto its
accepted squash; keep one active delivery PR.

Local checks use `python3 scripts/local-guard.py` with unchanged limits. The
accepted compiler interpreted all five 32-call examples, both raw and optimized,
and printed `32` in every case (1.80s); this does not validate the new native
instrumentation. A named helper
needed an explicit `I64 -> () ! {Network, State[I64]}` signature because generic
signatures remain explicit. Formatting passes (1.08s); partition/concurrent-runner checks pass (1.03s),
and the documentation audit passes (2.75s). The service guide now introduces
request contexts, callback functions, `const`, deadlines and response metadata
before using their examples. Native work belongs on CI.
The new test target is assigned to the existing macOS GC job, giving this
preparation 231 integration targets; #153 still has 230.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Ownership of services and external contexts; remove tracing |
| 2 | In progress | Remove remaining functional allocation and counting costs |
| 3 | In progress | Diagnose and reduce equivalent-work C/Rust gaps |
| 4 | In progress | Differentiation precision, speed and memory scaling |
| 5 | In progress | CPU kernels and the runtime OpenCL compilation gap |
| 6 | In progress | Repeatable performance comparisons |
| 7 | In progress | Larger representative applications |
