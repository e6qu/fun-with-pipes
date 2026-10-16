# Session handoff

Updated 2026-10-16. [PLAN.md](../PLAN.md) remains the project roadmap.
This is independent preparation in `/private/tmp/fwp-service-values`, branch
`service-value-preparation`, based on `a0447849f2dbce39e9e558001ac1fd75a842f028`.
The active delivery remains PR #153; its work is in the main workspace and
`/private/tmp/fwp-tcp-owners`. Do not publish a second delivery PR.

Next: finish the combined copied-service-result checks and retain their evidence. Establish complete/partial result cleanup without a temporary pointer
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

Published `bdb587c7` implements `grpc.metadata` and `grpc.peer-subject`:
existing typed field/list owners protect partial results; metadata no longer
allocates a pointer scratch vector. Compiler calls now pass result descriptors,
and both contracts are OwnedTree. The existing served-peer probe receives its
option descriptor and releases the returned copy. A new focused probe checks duplicate header order, filtering, copied aliases,
12 metadata and 2 subject allocation failures, omitted field cleanup, and
empty public results in tracing/ARC. Linux ARM64/AMD64 and ARM macOS pass in `38926254969` at `bdb587c7`;
Intel macOS and both Windows jobs remain queued/running. No complete support
claim is accepted yet. Full Windows and macOS schedules
must include the new target. Published `e2c4668f` also copies HTTP/2 request and body results into typed
owners. It preserves host precedence, duplicate/header order, all byte values,
empty results and size/reset/deadline decisions. The new allocation probe expects
20 request and 2 body allocation failures with no retained result storage;
existing peer-buffer and source-stream lifetime controls are updated to use
generated result descriptors. Its focused run `38927180411` failed compiling the new test helper: argument
count used usize where the IR requires u32. The helper now converts its fixed
small argument count; the superseded run is canceled. A following test
repair updates the interpreter/native body comparison to pass the new descriptor
and adds explicit populated-result GC stress/reuse runs. Run `38927862049` at `47bc253b` found that the test helper had not marked its
primitive functions as generated roots, so result descriptors were absent. The
helper now names both functions explicitly. The older metadata-only Windows ARM
job also found a fixture header-order issue: it now selects the Windows 10 API
before including CRT headers. These are test repairs, not waived checks. The combined checks add request-field
agreement with the interpreter and correct the body-test module filter
(`grpc::web`, not the source filename). No zero-test run counts as verification.

During this review, raw HTTP/2 header allocation was found to dereference failed
allocations, and buffer growth could overflow. The combined repair preserves
existing entries/buffers, frees partial new headers and rejects impossible sizes
with the existing protocol allocation exit status 102. A standalone probe injects
all three header allocation failures into empty and populated tables, a buffer
resize failure and four size overflows; omitted temporary cleanup must fail.
Outgoing response metadata now normalizes its owned copy in place, removing two
temporary string buffers. Input strings remain unchanged. This does not establish
recoverable allocation failure for the protocol layer or owned service streams.
Run the final combined
preparation before claiming acceptance.
Service stream/context ownership remains outside these result contracts.

Local checks: guarded Rust formatting passes (1.19s); the accepted interpreter
prints `[]`, `None`, `()`, `()` for the empty-context fixture (0.26s); the contract
inventory passes (1.12s), reporting 341 contracted declarations and 13 remaining
review symbols for this implementation. Counts are not support proof.
The standalone stdlib generator was regenerated and rechecked; latest formatting
passes in 1.30s, documentation audit in 2.66s and macOS partition checks in 0.25s.
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
