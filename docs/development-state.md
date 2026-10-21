# Session handoff

## Next action

Next: merge PR #185 after its final production gate passes, then publish this
service-response batch on accepted main. All eight jobs of focused run `39591489617` passed at
`0b1d6c115893eb9dc37536b2b3345ccbdcc74155`; every complete log was audited.
Use `/private/tmp/fwp-audit-grpc-sender-matrix.py` and
`/private/tmp/fwp-inspect-grpc-captures.py`. Inspections are saved under
`/private/tmp/fwp-grpc-sender-evidence`; all six native hosts are complete:
84 binaries, 24 cleanup samples and 12 deliberate leak controls. The
[report](measurements/queued-grpc-responses-2026-10-21.json) preserves costs and
peak variation, with no timing claim. The report generator is
`/private/tmp/fwp-report-grpc-captures.py`.

Preparation branch `prove-grpc-sender-captures` is in
`/private/tmp/fwp-grpc-sender-captures`, based on PR #185 head
`73850bd3b6ac460a7e077cea8cd1128f9913aea0`. PR #185 is still the only open delivery:
nine of its ten gates pass; Linux AMD64 is running. Its production run is
`39584128319`, documentation `39584128240`. Use `/private/tmp/fwp-merge-185.py`
only after exact-head acceptance. Preserve that head while CI runs. After merge,
preserve focused source with an immutable tag and transplant this preparation
onto accepted main before opening the next PR.

Standing authorization covers publishing, fixes and squash merge after all nine
production jobs plus documentation pass. Supply a one-line subject under
80 characters and an empty body; verify message, parent and tree afterward.
Failing tests are work to fix. Keep one active PR, and do not restart healthy CI
for handoff-only updates.

## Changes and ownership boundary

A queued callback can retain a served gRPC response channel under checked ARC.
The service emitter supplies an explicit `EntryChannels::GrpcResponses` contract
for that method's final response argument. The transport owns protocol data,
not language callbacks; typed cleanup releases its stream and connection.
Arbitrary external channels, other entry modes and unrelated channel arguments
remain unknown. Payload/cycle/scope checks still apply. No runtime layout or
syntax change. A full-analysis unit test checks both acceptance and rejection
boundaries. [The guide](measurements/queued-grpc-responses.md) explains the program.

The nine-case fixture makes 72 calls, including repeated sends, unreceived and
closed queues, rejected sends, errors, nested queues, blocked sends and remote
cancellation. Acknowledgement orders cancellation after the server retains the
callback. Tests compare raw interpretation with native ARC/tracing at O0/O2.
Each measured sample must release every response channel, stream, connection and
child task. The still-live listener's actual socket-wait objects are identified
separately; no other managed charge may remain. Both ARC omission controls must
exit 201. These are cleanup results, not speed or C/Rust parity claims.

Two earlier probes failed because of test settings/boundaries, now repaired:
ARC cannot enable reuse verification's deliberate retention; the listener's lazy
wait storage cannot be counted as a leaked request. Current focused checks pass
on six native platforms. Generated C, actual ELF/Mach-O/PE binaries, disassembly,
symbols and counters are retained. Two WebAssembly jobs preserve ownership
regressions; they do not establish WebAssembly gRPC server support.

## Incidental fixes and final-head coverage

REST startup now enforces a deadline and kills/reaps a silent child. The full
REST target passes on all six native hosts. Three immutable tracing executables
replace seven compilations; each test still starts a fresh server. This removes
four duplicate builds without claiming a measured elapsed-time improvement.

Workflow changes add all four response tests to production Windows
(the existing filter ran only stream-alias tests), and make the focused test-plus-
formatter step use Bash so a successful formatter cannot hide a failed test.
Linux/macOS production gates already run the full gRPC target. Production source
and tests have not changed after the focused matrix; final-head CI remains required.

## Local checks and resources

Use `python3 scripts/local-guard.py COMMAND...` serially. No local full builds,
native C compilation, full suites or benchmarks. Preserve 64 GiB free disk,
target below 2 GiB, sampled workload RSS below 1 GiB and the 180-second deadline.
Disk pressure stopped two source checks; both later passed through the unchanged
guard. No limits changed. Free space fluctuates around the floor.

The accepted PR #184 macOS compiler formatted both fixtures and matched their
72-call raw interpreter output. The guarded documentation audit passed: 77 link
sets, 106 immutable preparation pairs/tags and seven roadmap steps. All native
compilation and execution occurred on GitHub. Main-checkout handoff records the
recoverable-cache cleanup receipts; no unique evidence or branch was removed.

After this delivery, investigate measured task-record storage and remaining count
traffic before choosing an optimization. `/private/tmp/fwp-next-task-storage-notes.md`
records the current evidence and required context-switch checks. No implementation
choice or speed claim has been made. Persistent subscriptions, unknown retained
owners and cycle policy remain part of the broader memory work.

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
