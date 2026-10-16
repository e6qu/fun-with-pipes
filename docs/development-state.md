# Session handoff

Updated 2026-10-16. [PLAN.md](../PLAN.md) remains the project roadmap.
This is independent preparation in `/private/tmp/fwp-service-values`, branch
`service-value-preparation`, based on `a0447849f2dbce39e9e558001ac1fd75a842f028`.
PR #153 is the only delivery PR; its exact-head acceptance is tracked in the main
workspace `/Users/zardoz/projects/fun-with-pipes`. Do not open a competing PR.

## Current action

The combined implementation adds ARC binary symbol checks to `498f891c`.
Run `38929393764` was canceled while all six jobs were still queued, so the
final focused run can include these checks and the streamlined handoff.
Next: publish this head, dispatch `service-values`, then fix every failure, verify that the interpreter/native comparison actually
runs one test, retain the native artifacts and inspect the resulting binaries.
No complete native acceptance is claimed yet. Full builds and checks stay on
GitHub; local work uses `python3 scripts/local-guard.py` with unchanged limits.

After #153 is accepted, rebase only this branch's delta after `a0447849` onto its
accepted squash, update delivery history and the current plan, and open one
substantial follow-up PR. Require all nine production jobs plus documentation on
the exact final head before squash merge. Commit subjects are one line, at most
80 characters, with no body, trailers or attribution. JIT remains excluded.

## What this batch changes

Incoming gRPC metadata/certificate names and HTTP/2 request/body copies now have
typed owners. Partial-result cleanup uses existing helpers; header lists no
longer need temporary pointer arrays. Outgoing response headers normalize their
owned copies directly, removing two temporary string buffers without changing
the caller's strings. Six primitive contracts describe these operations.

Raw HTTP/2 header allocation now checks failed allocations, preserves earlier
entries and releases partial new strings. Buffer growth checks overflow and
preserves its old allocation on resize failure. These checks retain the protocol
layer's existing exit status 102; they do not establish recovery inside a service.

Acceptance covers duplicate/header order, host precedence, absent fields, binary
bodies, size/reset/deadline decisions, input immutability and surviving aliases.
Probes expect 12 metadata, 2 certificate-name, 20 request and 2 body allocation
failures, with zero final charged result storage while collection is disabled.
Separate populated-result stress/reuse checks must pass. Raw allocation probes
cover six header failures, one resize failure and four impossible sizes.
Deliberately omitting cleanup must fail. Existing source-stream and peer-buffer
lifetime controls remain required. Output storage and stack cleanup records still
have costs; there is no speed or C/Rust parity claim.

## Checks and repairs so far

Earlier metadata-only checks passed on Linux ARM64/AMD64 and ARM macOS. The
superseded runs `38926254969`, `38927180411` and `38927862049` are canceled.
They exposed test setup errors: wrong IR argument-count type, generated functions
not marked as roots, and Windows API selection after CRT headers. Repairs are in
the current head. The focused body-comparison filter now uses its actual module,
`grpc::web`; an earlier zero-test invocation is not verification.

Guarded local checks pass: Rust formatting 1.09s, accepted interpreter example
0.26s (prints `[]`, `None`, `()`, `()`), contract inventory 1.12s (341 contracted
declarations, 13 remaining reviews), generated stdlib documentation recheck 0.01s,
roadmap audit 2.64s and macOS partition checks 0.25s. All 230 integration targets
are assigned; the new service target uses the existing macOS GC job. Full Windows
checks also include service results and peer-buffer cleanup.

Earlier ARM64 metadata-only test binaries are retained under
`/private/tmp/fwp-service-metadata-evidence`. Inspection found no tracing scan or
sweep functions in that ARC executable. Its instrumented metadata/certificate
functions use 448/272-byte stack frames; these are test-binary facts, not a cost
comparison or evidence for the larger current batch. Final evidence must use the
current successful revision. Draft review text is `/private/tmp/fwp-service-pr-body.md`.

## Following ownership work

Service streams/connections and retained request contexts still need explicit
lifetimes; copied results do not prove a whole server can run without tracing.
Remaining primitive reviews cover context scopes, deferred remote results,
HTTP/2 serving/sending/responding, process exit and GPU execution. Preserve
callback, cancellation, library-unload and child-task behavior while removing
those dependencies; do not replace them with permanent retention.

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
