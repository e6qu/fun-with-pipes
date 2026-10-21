# Session handoff

## Next action

Next: finish the gRPC response-channel capture proof, add native service tests
for delivery, failure and cancellation, then run focused checks on GitHub.
This is unverified preparation in `/private/tmp/fwp-grpc-sender-captures`, branch
`prove-grpc-sender-captures`, based on PR #185 head
`73850bd3b6ac460a7e077cea8cd1128f9913aea0`. No second PR exists.

PR #185 remains active in `/Users/zardoz/projects/fun-with-pipes`. Its production
run is `39584128319`, docs `39584128240`; full acceptance is not complete.
Use `/private/tmp/fwp-audit-185-final.py` and `fwp-merge-185.py` there. Preserve
that final head while its gates run. After it merges, transplant this preparation
onto accepted main before opening the next PR. All commit messages remain one
line, at most 80 characters, with no body or trailers.

## Producer contract under development

`g_run_method` alone calls `g_sink_value`, with a codec whose captured function
is zero. This response channel owns a stream and connection. gRPC connections
have no `g_web` handler; server descriptors contain static metadata. Stream task
identities and waiter lists are borrowed, not owning callback references.
`g_sink_drop` releases the stream and connection; typed cleanup already exists.
These facts suggest a safe producer contract, not general native-channel safety.

The prototype adds explicit `arc::EntryChannels::{Unknown, GrpcResponses}`.
Only `cgen::Mode::Service` supplies the response contract. `arc_scope` records
`Origin::GrpcSender(method)` for the last channel argument of a matching served
method with channel output. Its type still needs the data-only capture proof.
Other arguments and external channels stay unknown. The queue-source walk now
handles both ordinary queues and native response senders. No runtime changes.

A new full-analysis unit control checks that identical signatures/service metadata
are insufficient without the explicit entry contract, that another channel input
stays unknown, and that a missing method contract is rejected. Existing 24 unit
calls now pass the unknown policy explicitly. Prototype commit
`867cc9a1889d948fa0002c82736c2aa79d305c35` passed Linux run `39586619398`, including
compiler units, Clippy and existing socket/queue regressions. The complete log
has no errors or panic diagnostics; receipt `/private/tmp/fwp-grpc-sender-probe.json`.

## Required native evidence

The new `tests/grpc/queued.fwp` fixture queues callbacks capturing a response
channel, including tuple/record and nested-queue paths. Its client makes 64 calls:
repeated sends, undrained/closed queues, rejected sends, caught errors and
blocked-task cancellation. The accepted PR #184 compiler, verified by SHA-256,
formatted both fixtures and matched their explicit raw interpreter output locally.
This checks source semantics, not the new ARC proof.

`tests/support/queued_grpc_responses.rs` uses the existing gRPC server/client
helpers. It compares raw interpretation with native ARC/tracing at O0/O2, measures
live response channels and final stream/connection/task and managed-storage
cleanup, and deliberately omits a queued release. These native checks have not
run yet. Generated C, binaries, disassembly, symbols and logs are retained by the
focused workflow. No speed or C/Rust parity claim is involved.
WASI has no native gRPC server claim; keep its existing ownership regression gates.

`tests/support/grpc_server_measurement.rs` and `tests/fixtures/server-memory/probe.c`
provide existing post-request cleanup instrumentation. Reuse it where suitable;
keep timing/allocation claims separate from correctness. The `channel-proof`
workflow already covers six native hosts and two WASI hosts; add an explicit
filtered gRPC integration step if the new test goes in `tests/grpc.rs`.
Do not replace unknown producers with type-based acceptance or tracing.

## Local work

Run checks through `python3 scripts/local-guard.py`, serially and at low priority.
No local full build, native C compilation, full test gate or benchmark. Preserve
64 GiB free disk, target below 2 GiB, sampled RSS below 1 GiB and the 180-second
limit. Disk pressure stopped one source check before execution. After recoverable
cache cleanup it ran through the guard successfully. Latest free space: 64.40 GiB,
still fluctuating. The main handoff records cleanup receipts. APFS copy-on-write
clones preserve every path and independent contents of identical evidence files;
receipt `/private/tmp/fwp-identical-evidence-clone-cleanup.json`. No compiler/test
work bypassed the guard and no limits changed.

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
