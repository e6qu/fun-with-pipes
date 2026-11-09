# Current work

**Next:** batch the specialization-guard and explicit HTTP connection-policy repairs,
then rerun the affected focused gates before starting timing sessions. Complete
slow-client/backpressure coverage in the same milestone 5 PR.

Worktree: `.worktrees/application-milestone`, branch `application-tooling-costs`.
Published source: `e560937cbdb2b5e8072c7a2fe46fe2e4dd69e969`.
Local specialization and load-policy repairs are not yet pushed.
No milestone 5 PR is open; assemble the application/compiler/load batch first.
Preserve unrelated root-worktree changes.

## Roadmap status

| Step | Status | Delivered | Remaining |
|---|---|---|---|
| 1 | In progress | #270 documentation refresh and fresh F64 stores | Original AMD timing acceptance |
| 2 | In progress | #271 captured maps and empty-owner transfer | Original noisy timing acceptance |
| 3 | In progress | #272 structured gradients and known callbacks; all delivery gates | Original AMD timing acceptance |
| 4 | Verified | #273 ownership/peer comparisons, parser cleanup repair, all delivery gates | Recorded measurement limits still apply |
| 5 | In progress | Application/phase contracts and allocation diagnostics verified on Linux | Growth/load repairs, timing sessions, slow clients, final delivery |

[PR #273](https://github.com/e6qu/fun-with-pipes/pull/273) is merged as
`8887114f6ad3be3cd42d37b976ec208e27e4a5a2`. Its [receipt](measurements/ownership-peer-final-gates-2026-11-09/README.md)
retains all nine production jobs, docs and complete-log audit at tested source
`0f3c0b94a1afa5b1e2c9b12435a2905532b0d072`. Verified source tag:
`roadmap/ownership-peer-delivery-2026-11-09`. Do not repeat unchanged timing
experiments to obtain qualification. Original milestone 1–3 limits stay open.

## Current native checks

All jobs below have finished. Nothing was cancelled: the previously queued
runs acquired runners before replacement was attempted. Every failed step and
completed target was audited; the remaining repairs are listed next.

| Source / run | Result |
|---|---|
| `5f8dd5a88`, application `42711448460`, docs `42711453469` | Both Linux hosts and docs pass; four compiler-option tests, Clippy, applications, integer boundaries and code inspection |
| `a51a837f2`, growth `42712222725` | Both hosts: eleven sizes pass; `generic-512` fails |
| `e560937cb`, application `42715261073` | Both hosts pass, including five compiler-option tests and the missing-import report regression; AMD64 browser passes |
| `e560937cb`, growth `42715266501` | Same `generic-512` failure on both hosts; all other sizes pass |
| `e560937cb`, HTTP `42715271649` | Driver success/wrong/partial/timeout controls, allocation traffic, cleanup and broken-counter controls pass on both hosts; actual API load rejects connection closure |
| `e560937cb`, docs `42715276966` | Pass |

[The compact receipt](measurements/compiler-http-preparation-2026-11-09/README.md)
retains current outcomes, original failures and allocation observations.

Original [application repairs and results](measurements/application-workflows-2026-11-09/README.md)
remain retained. Compiler reports now preserve exact C/results/errors, including
missing imports: creating a report before compilation could change source lookup,
so file creation now follows compilation. Root and auxiliary outputs are protected.
[Reporting scopes](compiler-pipeline.md#observe-compiler-phases).

## Repairs being prepared

- **Generic breadth:** the old global 500-instance cap falsely labels 512 unrelated
  uses of `keep : a -> a` as polymorphic recursion. Count dependent instantiations
  along queued expansion ancestry instead; keep the same 500 bound. Preserve
  ancestry through lifted functions/matches and nested compile-time work. New
  native tests cover 512 results and bounded direct/mutual type expansion.
- **Connection policy:** both HTTP checks record exactly 2,000 attempts and two
  closures: the example's 1,000-request limit is intentional. The measurement
  now explicitly supplies 10,000,000 and retains original/configured sources.
  Do not silently reconnect, change the maintained example or raise limits on failure.
- **Failure evidence:** retain full command diagnostics and tracebacks instead of
  a blank assertion message in measurement summaries.

The [protocol](measurements/application-tooling.md) fixes all families, timing
orders, deadlines, request windows and accounting boundaries. No paired compiler
scaling or sustained-load timing session has run. The original one-second API
checks are correctness failures, not throughput results to publish.

## Remaining implementation and delivery

1. Finish native verification of the repairs. Start two compiler timing sessions
   per Linux host only after growth checks pass; retain noisy controls unchanged.
2. Complete slow-reader/writer, backpressure, disconnect and shutdown evidence.
   Allocation diagnostics already cover 344 correct item responses, incomplete
   POSTs, cancellation, exact heap/socket/task cleanup and a disabled counter.
3. Run the complete HTTP protocol: two sessions per host, 1/8/32/64 connections,
   two 30-second runs each, and one 300-second soak per host. Keep ordinary timing
   separate from instrumented allocation events and physical cleanup.
4. Retain/audit all reports and update docs; open one normal substantial PR, then
   run the nine final production jobs, documentation and complete-log audit.
   Squash-merge only after exact-head gates pass, with one line ≤80 characters,
   empty body and no trailers/attribution; verify the merged tree and message.

## Local checks and limits

Use `python3 scripts/local-guard.py` serially. Rust formatting, actionlint, Python
syntax, three compiler-accounting controls, two HTTP-reader controls and 437 doc
link sets pass (106 immutable anchors, five roadmap rows). The standalone Rust
HTTP framing test passes at O2 with warnings as errors: 0.22s sampled CPU. No
local fwp build, full suite or load measurement ran. Last disk reading: 120 GiB free.

One earlier bounded artifact stream stopped at 180 seconds; its large read moved
to a runner. Keep 64 GiB free, generated targets below 2 GiB, workload RSS below
1 GiB and the 180-second guard deadline. Dispatcher size is 502,964 bytes; keep
it below 512,000. Large builds, suites and measurements stay on GitHub.
