# Session handoff

Updated 2026-10-16. [PLAN.md](../PLAN.md) defines seven unfinished work areas.
[PR #153](https://github.com/e6qu/fun-with-pipes/pull/153) is the only delivery PR.
It combines decoded-value cleanup, smaller numerical temporaries, socket ownership
and copied service-result ownership. Do not open a separate service PR or apply
these preparation changes again.

## Current action

The combined preparation has been fast-forwarded into `owned-values-delivery`
in `/Users/zardoz/projects/fun-with-pipes`.
Next: publish that branch to PR #153, then require all nine production jobs
and documentation on the exact new PR head. Update this local handoff with their
run IDs. The tested service source is `e715de1a`. Following changes retain evidence,
update documentation and start the two longest measured GC stress cases first.
This queue order keeps every case and all four workers; it has no language or
runtime change and does not claim a measured total-CI speedup.

The old published head `78e9a372` must not be merged. Its Windows TLS comparison
failed because native reset messages bypassed the interpreter's common wording.
Repair `abe3be17` passes both Windows focused jobs `38931783848`; it preserves
exact certificate errors and adds five actual native/interpreter error-code
comparisons. That repair is included in the combined preparation. Inspect any
unfinished jobs in old production `38925341899` for additional failures before
starting the final full run. Old documentation `38925341680` passed. Its Intel GC stress log is retained at
`/private/tmp/fwp153-intel-gc-progress/gc-stress.log`: collection construction
took 1,744s and HTTP took 175s. The test schedule now starts both first so shorter
programs can run alongside them. Existing integration-shard assignments stay fixed.
[Scheduling evidence](measurements/gc-stress-scheduling-2026-10-16.json) retains
all observed example timings and the baseline log hash.

After all final-head gates pass, squash-merge with subject
`Reduce temporary memory and clean up network resources` and an empty body.
The whole message must be one line, at most 80 characters, with no trailers or
attribution. Verify merged files, parent and message; cancel duplicate postmerge
CI. `/private/tmp/fwp-merge-153.py` still names the failed old head/runs: update
those before using it. Standing publication, fixes and merge authorization
persists; failing tests are work to fix. JIT is excluded.

## Passing focused checks

Service run `38935341434` passes all six native hosts at `e715de1a29a55fb08fe0ca1b339e5d38e493d4b8`.
Both actual WASI jobs in `38934584083` pass at `c37b6afa`; later native follow-ups
do not change WASI code. The [service report](measurements/service-values-2026-10-16.json)
retains source/binary hashes, native formats, symbols, ARM64 instructions and
allocation counts. `/private/tmp/fwp-retain-service-values.py` generated it from
passing jobs and retained artifacts under `/private/tmp/fwp-service-final-evidence`.

Incoming service headers/certificate names and HTTP/2 request/body copies now
own their returned storage. Every partial-result allocation is tested: 12 header,
2 certificate-name, 20 request and 2 body failure points return charged storage
to baseline with collection disabled. Aliases, source mutation, garbage-collection
stress, memory reuse, header order/duplicates and all body bytes are covered.
Thirteen body-limit/error-order cases and three request-header cases compare
actual interpreter and native output. Deliberately omitting cleanup must fail.

Outgoing response headers normalize their owned copies directly, removing two
temporary string buffers. Raw header and buffer allocation checks preserve prior
storage and reject size overflow; their existing failure exit status remains
102. Response-capture allocation now traps before calling the callback or
installing the context. Its existing escaped-child, cancellation and overflow
checks pass on all six hosts. Generated standard-library documentation passes too.

Earlier setup failures are repaired. The last Windows fixture failure was CRT
newline translation; explicit binary stdout preserves the exact-byte comparison.
Superseded service runs are canceled. Copied results do not establish ownership
of the service's streams, connections or retained contexts, and do not establish
that an entire server can execute without tracing.

Existing reports retain decoded-value, numerical-worker, DNS, UDP and TCP/TLS
checks under `docs/measurements`. Numerical temporary storage falls from 69,648
to 4,104 bytes for the recorded 8,193-number, one-worker case; the result still
uses 65,552 bytes. These are memory measurements against earlier fwp, not speed
or C/Rust parity. Actual ARC socket binaries exclude tracing functions. The
socket counter fits the previous plain header; TLS adds one session pointer.

Windows now uploads failed TLS, differentiation and output-comparison step logs
before later checks finish. All nine production jobs and platform coverage remain.
All 230 integration targets remain assigned to macOS jobs; Windows includes
service-result, certificate-buffer and response-capture checks.

## Local checks and limits

Keep local checks serial through `python3 scripts/local-guard.py`, with unchanged
CPU, memory, disk and deadline limits. Full compilation/testing stays on GitHub.
Earlier local compiler and standalone C builds were refused by automatic review;
do not retry or bypass that restriction.

Guarded formatting passes (latest 1.28s); macOS partition checks pass (0.13s).
The final independent roadmap audit passes (3.06s: 50 link sets, 106 immutable preparation
pairs and seven work areas). `git diff --check` passes. Earlier accepted-interpreter
examples and the primitive inventory pass (341 contracts, 13 remaining reviews).
Guarded artifact retention and binary inspection passed in 16.91s.
The local generated-doc recheck printed a passing test but its monitor failed
with a process-signal permission error; that invocation was not accepted. The
same documentation test subsequently passed on all six service CI hosts.
Final documentation edits pass the bounded audit.

## Accepted delivery and following work

PR #152 is accepted at `1fa0fec690b7747a9ffcf2d72903d16544889258`: all nine
production jobs and documentation passed, merged files/message were verified,
and duplicate CI was canceled. [Delivery history](roadmap-history.md) retains it.

After #153 acceptance, continue service streams, connections and retained request
contexts. First measure repeated context scopes and child tasks that outlive
their creating callback. Prefer stack storage for scopes that do not escape;
children must retain valid data after scope return, failure and cancellation.
Do not replace unproved lifetimes with permanent retention. Remaining primitive
reviews also cover deferred remote results, HTTP/2 serving/sending/responding,
process exit and GPU execution. Continue the seven work areas below; completing
this delivery does not finish the language's memory or performance goals.

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
