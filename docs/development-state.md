# Session handoff

Updated 2026-10-16. [PLAN.md](../PLAN.md) defines seven unfinished work areas.
[PR #153](https://github.com/e6qu/fun-with-pipes/pull/153) is the only delivery PR.
It combines decoded-value cleanup, smaller numerical temporaries, socket ownership
and copied service-result ownership. Do not open a separate service PR or apply
these preparation changes again.

## Current action

PR #153 is temporarily draft while its decoder test repair gets focused native
verification. The failed production run `38946985320` at `a0af12d9` was canceled;
it must not be accepted. ARM Mac GC found that the replacement instrumentation
marker `b->d = data` also matched the generic text buffer. The earlier repair
therefore matched twice and failed its uniqueness assertion before native tests.

The new repair matches the HTTP/2 assignment and its capacity update together,
keeps the one-match assertion, and counts only successful first allocations.
Explicit marker/replacement pairs remove the old marker-dependent insertion
rule. The deliberately omitted buffer/partial-field cleanup controls remain.
Runtime behavior is unchanged. Four source hooks are unique and exclude the
text buffer; native verification must still pass.

Next: publish the repair and run the `byte-decoders` suite on all six native
hosts. Once that focused run passes, make the PR ready and require all nine
production jobs plus documentation on its exact new head. A skipped draft CI
run is not acceptance. Do not reuse the old head or acceptance IDs.

After all final-head gates pass, squash-merge with subject
`Reduce temporary memory and clean up network resources` and an empty body.
The whole message must be one line, at most 80 characters, with no trailers or
attribution. Verify merged files, parent and message; cancel duplicate postmerge
CI. Update `/private/tmp/fwp-merge-153.py` to the repaired head and supply the new
production/documentation IDs; it verifies all nine jobs and docs before merging.
Standing publication, fixes and merge authorization persists. Failing tests are
work to fix. JIT is excluded.

The Mac runner builds each selected target once and runs two executables at a
time. Artifact checks reject missing/duplicate targets and every target gets a
log. GC stress starts its two longest measured cases first, retaining all cases
and four workers. Scheduling changes preserve the 90-minute limit; they do not
yet establish a measured total-CI speedup.

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

Guarded formatting passes (latest 1.28s); macOS partition and new concurrent-runner checks pass (0.96s).
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

Independent preparation is in `/private/tmp/fwp-context-owners`, branch
`service-context-preparation`, based on `ac3060d1`. Current combined source
`4656043f` has six-host native run `38951742782`. It adds message-decoding
trap cleanup and the same two-executable Linux scheduling used on Mac. Queued
`38949852186` was superseded. Focused actual WASI ARC run `38949856424` tests
explicit exit at `6b642a82`. Broader WASI/browser run `38947985548` passes on both
Linux architectures at callback/runtime source `24caa70b`; it predates exit tests. Earlier context checks exposed harness
and Windows inventory path bugs; repairs are included in the new source. Do not open a second PR. Rebase only its
delta after `ac3060d1` onto the accepted #153 squash.

That preparation moves scope settings to the stack, copies inherited settings
inside child tasks, borrows synchronous TLS/capture owners and packs outgoing
headers into one owned allocation. It also borrows typed callbacks and owns
returned values/captured header copies. New tests cover aliases, returned
functions, every partial-result allocation, child lifetimes, failure/cancellation,
ARC binaries and deliberately broken cleanup. The five proposed new contracts
need CI inventory and runtime validation. The exit contract is also prepared: no returned owner exists when a process
terminates. Three new targets have permanent Windows/Mac coverage, giving that
preparation 233 targets; #153 remains 230.

Retained baseline `9b137078` passed Linux. Intermediate stack-copy `ad77934c`
passed ordinary allocation/output tests on all six hosts, and all four complete
Unix jobs. Separate Windows lifetime fixtures failed to compile; the new source
repairs their API-target header order and environment APIs. Do not count those
old Windows jobs as full acceptance. Gzip/deadline remove a 64-byte per-call
managed request; Linux AMD64 service tasks grow from 1,512 to 1,576 bytes in
that intermediate version. Actual ARM64/AMD64 instructions and all six native
binary formats are retained in the preparation's measurement report. The current
revision adds another owner pointer and needs new layout/memory measurements.
Neither counts nor instruction inspection establishes a speedup or C/Rust parity.
The preparation handoff records all current checks. Preserve the existing
effect rule: partial application is pure; only the final arrow may have effects.

After #153 acceptance, continue service streams, connections and retained request
contexts. Finish the prepared context/callback/exit checks and retain final allocation,
layout and binary evidence. The stack/packed-header changes need verified child
lifetimes after scope return, failure and cancellation.
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
