# Session handoff

Updated 2026-10-16. [PLAN.md](../PLAN.md) remains the project roadmap.
This is independent preparation in `/private/tmp/fwp-service-values`, branch
`service-value-preparation`, based on `a0447849f2dbce39e9e558001ac1fd75a842f028`.
The active delivery remains PR #153; its work is in the main workspace and
`/private/tmp/fwp-tcp-owners`. Do not publish a second delivery PR.

Next: prepare explicit ownership for copied service request metadata and body
results. Establish complete/partial result cleanup without a temporary pointer
array, preserve source header order, and retain the original request context
while copying. Use existing typed value/field cleanup, with no new surface
syntax. This is not proof that service callbacks or stream handles can run
without tracing. Keep those remaining lifetimes explicit.

Acceptance: raw interpreter/native public output agreement where callable;
focused native probes with multiple headers, missing values, binary bodies and
all result-allocation failures; aliases remain valid after the source context
changes; GC stress/reuse and zero final charged output storage with collection
disabled; omitted cleanup controls must fail. Network contexts may still use
tracing. State their retained cost and do not claim speed or C/Rust parity.

Only after PR #153 is accepted, rebase this branch's delta after `a0447849` onto
its accepted squash, combine verified follow-up work into one substantial PR,
and require all nine production jobs plus documentation on its exact head.
Commit and squash subjects remain one line, at most 80 characters, with no body,
trailers or attribution. JIT is excluded. Keep local checks serial under
`python3 scripts/local-guard.py`; full compilation/testing belongs on GitHub.

This preparation implements `grpc.metadata` and `grpc.peer-subject`:
existing typed field/list owners protect partial results; metadata no longer
allocates a pointer scratch vector. Compiler calls now pass result descriptors,
and both contracts are OwnedTree. The existing served-peer probe receives its
option descriptor and releases the returned copy. A new focused probe checks duplicate header order, filtering, copied aliases,
12 metadata and 2 subject allocation failures, omitted field cleanup, and
empty public results in tracing/ARC. It has not run; publish this preparation and run the six native
`service-values` jobs before committing support claims. Full Windows and macOS schedules
must include the new target. HTTP/2 request
and body ownership remains untouched.

Local checks: guarded Rust formatting passes (1.19s); the accepted interpreter
prints `[]` then `None` for the empty-context fixture (0.25s); the contract
inventory passes (0.87s), reporting 337 contracted declarations and 17 remaining
review symbols for this implementation. Counts are not support proof.
The standalone stdlib generator was regenerated and rechecked; latest formatting
passes in 1.29s, documentation audit in 2.79s and macOS partition checks in 0.25s.
All 230 integration targets are assigned, including the new service probe in the
existing GC job. The full Windows TLS step also includes it.

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
