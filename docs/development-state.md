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
channel, including tuple/record and nested-queue paths. Its client makes 72 calls:
repeated sends, undrained/closed queues, rejected sends, caught errors and
blocked-task cancellation and cancellation by the remote caller after the server
acknowledges holding the callback. The accepted PR #184 compiler, verified by SHA-256,
formatted both fixtures and matched their explicit raw interpreter output locally.
This checks source semantics, not the new ARC proof.

`tests/support/queued_grpc_responses.rs` uses the existing gRPC server/client
helpers. It compares raw interpretation with native ARC/tracing at O0/O2, measures
live response channels and final stream/connection/task and managed-storage
cleanup, and deliberately omits a queued release. First integration run
`39588799090` at `ebd4d61eb351964018c1950c6bbf3ab04a93272d` failed because the test
enabled reuse verification in ARC mode. That mode intentionally retains released
storage and ARC rejects it. Ordinary tracing now keeps reuse verification;
measured runs explicitly disable it so they can check physical cleanup.
Every other step passed. Complete audit: `/private/tmp/fwp-grpc-sender-integration.json`.
The repair and expanded cancellation test still need native verification.
They are published as `00047164b42108dd7e66bffc6b48baf83b310fbf`. Probe
`39589899500` released all 72 response channels, all streams and the connection,
but retained 544 managed bytes relative to readiness. Source inspection identifies
the still-live listener's lazily allocated Linux descriptor table (512 bytes) and
wait record (32 bytes). The prepared measurement now identifies the exact live
listener objects and rejects any charge beyond them, without a guessed allowance
or test-only disposal. It also verifies there are no connection wait records.
That correction still needs native validation. Complete log and C are in
`/private/tmp/fwp-grpc-retention-evidence`; audit `fwp-grpc-sender-repaired.json`.
New native checks inspect ELF/Mach-O/PE headers
as well as C, symbols and disassembly; emulated output cannot count as native.
The next prepared revision reports ARC/tracing and O0/O2 as four independent
tests, with separate scratch and artifact directories. A failure in one must
not prevent the others from running.
Generated C, binaries, disassembly, symbols and logs are retained by the
focused workflow. No speed or C/Rust parity claim is involved.
WASI has no native gRPC server claim; keep its existing ownership regression gates.

`tests/support/grpc_server_measurement.rs` and `tests/fixtures/server-memory/probe.c`
provide existing post-request cleanup instrumentation. Reuse it where suitable;
keep timing/allocation claims separate from correctness. The `channel-proof`
workflow covers six native hosts and two WASI hosts; its explicit filtered gRPC
step now runs this integration and checks fixture formatting on native hosts.
Do not replace unknown producers with type-based acceptance or tracing.

## Service test-harness repair

Inspection of slow REST tests found startup could block indefinitely on a silent
or partial first line, before its server handle existed for cleanup. The prepared
repair reads asynchronously, enforces an explicit deadline, and kills/reaps failed
startup. Its regression uses a silent interpreted child and a 100 ms deadline.

Three immutable tracing server executables (API, authentication and forms) are
now shared within one test process, eliminating four duplicate compilations.
Each existing test still starts a fresh server, keeps its requests and explicit
stress setting, and reports failures independently. ARC and distinct source
builds remain separate. The full focused matrix includes the entire REST target.
This preparation has not run yet; fewer compilations is not a measured wall-time
improvement. Earlier target durations are in
`/private/tmp/fwp-184-test-duration-review.json` and include competing tests.

## Local work

Run checks through `python3 scripts/local-guard.py`, serially and at low priority.
No local full build, native C compilation, full test gate or benchmark. Preserve
64 GiB free disk, target below 2 GiB, sampled RSS below 1 GiB and the 180-second
limit. Disk pressure stopped two source checks before execution. After recoverable
cache cleanup and other disk activity subsiding, both ran through the unchanged
guard successfully. Latest free space: 66.55 GiB,
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
