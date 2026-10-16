# Session handoff

Updated 2026-10-16. [PLAN.md](../PLAN.md) defines seven unfinished work areas.
[PR #153](https://github.com/e6qu/fun-with-pipes/pull/153) is the only delivery PR.
It is being expanded with copied service-data ownership so the required full CI
restart also validates that coherent batch. Do not open a separate service PR.

## Current workspaces and next action

The published PR remains at `78e9a372abe0daad90318b9ae14751cf6587c31f` on
`owned-values-delivery` in `/Users/zardoz/projects/fun-with-pipes`.
The combined preparation is `/private/tmp/fwp-service-values`, branch
`service-value-preparation`; it merges the socket repair from
`/private/tmp/fwp-tcp-owners`, branch `tcp-owner-preparation` (`4e13d309`).
Do not apply either batch again or rebase the service work as a separate delivery.

Linux preparation `38933103425` passed at `c10bdb77`.
Next: finish the combined preparation's `service-values` matrix on all six native
hosts (`38934662876`) and both `wasi-arc` regressions (`38934584083`), at
`c37b6afa`. A subsequent review found an unchecked response-capture allocation;
the pending follow-up traps before invoking the callback or installing a context.
Its existing lifetime test now injects that failure. Run a Linux preparation
check for that repair, then include it in final production acceptance; Windows
now runs this existing capture test too. Fix failures, retain artifacts and inspect binaries.
`/private/tmp/fwp-retain-service-values.py RUN_ID` requires all six service jobs,
actual interpreter/native comparison execution and expected allocation probes
before writing the final report. Its current script has not run successfully.

After focused acceptance, fast-forward the delivery branch to this combined
work, rewrite the PR description to cover it, and require all nine production
jobs plus documentation on the exact new head. Do not merge the failed old head.
Squash subject: `Reduce temporary memory and clean up network resources`;
empty body, no trailers or attribution, at most 80 characters. Verify the merge
tree/parent/message and cancel duplicate postmerge CI. Update
`/private/tmp/fwp-merge-153.py` to the final head and run IDs before using it.
Standing publication/fix/merge authorization persists. JIT is excluded.

## Delivery failures and completed evidence

Old production `38925341899` failed only the TLS stream comparison on both
Windows hosts so far. Native messages bypassed the interpreter's common socket
wording. Both Windows focused jobs `38931783848` pass repair `abe3be17`, including
five native/interpreter error-code comparisons, real TLS stream snapshots,
mutual TLS with ARC and the missing-error-capture control. The repair keeps exact
client certificate errors and does not weaken the test. Other old production
jobs are still running; inspect their results for additional failures. Benchmarks
and both ARM macOS jobs passed; documentation `38925341680` passed.

Windows now saves and uploads failed TLS, differentiation and output-comparison
step logs before later checks finish, preserving each command's failing status.
The job count and test coverage stay unchanged.

Existing reports retain decoded values/numerical workers, DNS, UDP and TCP/TLS
evidence under `docs/measurements`. The TCP/TLS report includes the passing
Windows diagnostic follow-up. Numerical temporary storage falls from 69,648 to
4,104 bytes for the recorded 8,193-number, one-worker case; its result still uses
65,552 bytes. These are memory measurements against earlier fwp, not speed or
C/Rust parity. Actual ARC socket binaries exclude tracing functions; the socket
counter fits the previous plain header, with one session pointer added for TLS.

PR #152 remains accepted at `1fa0fec690b7747a9ffcf2d72903d16544889258`: all nine
production jobs and documentation passed, merged files/message were verified,
and duplicate CI was canceled. [Delivery history](roadmap-history.md) retains it.

## Copied service data: implementation and pending checks

Incoming gRPC metadata/certificate names and HTTP/2 request/body copies have typed
owners. Partial-result cleanup uses existing helpers; header lists no longer need
temporary pointer arrays. Outgoing response headers normalize owned copies
directly, removing two temporary string buffers while preserving input strings.
Six additional primitive contracts describe these operations.

Raw protocol header allocation checks failure, preserves earlier entries and
releases partial new strings. Buffer growth checks overflow and preserves its
old allocation on resize failure. These failures use existing protocol exit
status 102; they do not establish recovery inside a running service.

Acceptance covers duplicate/header order, host precedence, absent fields, binary
bodies, size/reset/deadline decisions, input immutability and surviving aliases.
Probes expect 12 metadata, 2 certificate-name, 20 request and 2 body allocation
failures, with zero final charged result storage while collection is disabled.
Populated-result stress/reuse checks, raw header/buffer allocation controls and
existing stream/peer lifetime checks must pass. Missing cleanup must fail.
Returned values and stack cleanup records still have costs; there is no timing claim.

Linux run `38932169877` passed gRPC ownership, raw protocol allocation checks,
interpreter/native request/body agreement and the stream lifetime control. Its
HTTP/2 allocation probe found an incomplete manually constructed test type table;
both fixtures now include the recursive list shape and its destructor. Earlier
test setup repairs fixed IR argument count, generated-function roots, Windows
API header order and borrowed interpreter fields. No skipped or zero-test run is
verification. Superseded preparation runs are canceled; the current action above
is the only pending test sequence.

## Local checks and limits

Local work remains serial under `python3 scripts/local-guard.py` with unchanged
CPU/memory/disk/deadline limits. Earlier local compiler and standalone C builds
were refused by automatic review; do not retry or bypass that restriction.
Full compilation/testing belongs on GitHub.

Guarded formatting, accepted-interpreter examples, primitive inventory (341
contracts, 13 remaining reviews), generated stdlib documentation, roadmap audit
and macOS partition checks pass. Latest service formatting: 1.29s; example: 0.26s
(`[]`, `None`, `()`, `()`); inventory: 1.12s; stdlib recheck: 0.01s; audit: 2.64s;
partition checks: 0.25s. Combined-merge formatting passed in 1.35s and
partition checks passed in 0.13s; response-capture repair formatting passed in 1.06s; `git diff --check` passed. The subsequent
`python3 scripts/local-guard.py /private/tmp/fwp-service-stdlib-doc` printed a
passing test, but its guard failed with a process-signal permission error. That
invocation is not accepted as a passing guarded check, and the chained roadmap
audit did not run. No workload remained. The service CI suite now also runs
`stdlib_doc`; the final PR documentation job will recheck the combined handoff.
Do not bypass the guard or change its limits.
All 230 integration targets remain assigned; the new service target uses the
existing macOS GC job. Windows includes service-result and peer-buffer probes.

Earlier metadata-only binaries in `/private/tmp/fwp-service-metadata-evidence`
have no tracing scan/sweep functions in the inspected ARM64 ARC executable.
Its instrumented metadata/certificate functions use 448/272-byte stack frames;
these are test-binary facts, not evidence for the final combined batch or total
stack cost. Final artifacts and report must identify their actual tested revision.
Draft service review text: `/private/tmp/fwp-service-pr-body.md`.

## Following work

After #153 acceptance, continue ownership of service streams, connections and
retained request contexts. Copied results do not prove a server can run without
tracing. Remaining reviews cover context scopes, deferred remote results,
HTTP/2 serving/sending/responding, process exit and GPU execution. Preserve
callback, cancellation, library-unload and child-task behavior; do not replace
unproved lifetimes with permanent retention. Continue measured optimization,
differentiation and representative applications under the seven work areas.

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
