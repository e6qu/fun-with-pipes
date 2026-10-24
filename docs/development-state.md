# Session handoff

All seven [plan](../PLAN.md) areas remain open. Remove tracing; prefer ownership
and borrowing, with ARC for necessary sharing. JIT is excluded.

## Current action

**Next:** finish exact-head review of [PR #207](https://github.com/e6qu/fun-with-pipes/pull/207),
while diagnosing the next group's two API-memory failures. Keep one active PR.
Squash-merge only after nine production jobs, docs and independent binary review
pass; use one subject at most 80 characters and an empty body, then verify it.

## Active delivery

PR #207 source `bd0dc0100a516099590c340c012f74b7b666ebd2`; production run
`40064764447`, docs run `40064764348`. Benchmark, docs and both macOS ARM64 jobs
pass with complete logs audited. Six other native jobs are running; no failure
has been observed. Checkout `/private/tmp/fwp-file-http-delivery` is clean.
Audit with `fwp-audit-file-http-delivery-final.py` under `/private/tmp`.

The delivery adds repeated task-file edits/errors, independent handle controls,
HTTP startup/shutdown checks, clearer measurements and accurate code-size labels.
Focused files run `40058977728` verified 240 binaries, 480 executions and 23,040
checkpoints. Focused HTTP run `40062164443` passed all twelve jobs. Their receipts
and reports remain under `/private/tmp`; do not rerun completed generators.

Final review uses `fwp-review-file-http-delivery-host.py`: download, ownership,
arrays, floats, Linux-only controls, files, then prune. Both macOS archives are
needed because file targets span the two shards. All macOS ARM64 reviews pass: 1,341 core outcomes, 40 file binaries, 80 file
executions, twenty memory series, two stack objects and 24 paired layouts.
Worker frames are 720/704 bytes at O1/O2, main 144 bytes. Verified archive caches
`12550470718` (GC) and `12549746456` (regular) were pruned (330.5 MiB); all reports
remain in `fwp-file-http-delivery-evidence/bd0dc0100a51` and matching layout path
under `/private/tmp`. Do not repeat this host. Other #207 host reviews and merge
helpers remain unrun; inspect receipts before resuming. Expected final evidence includes 8,166 core
outcomes, 240 file binaries, 480 file executions, twelve stack objects and 144
layouts. Keep unique failed archives; prune only verified duplicate caches.

PR #206 is verified and merged at `8cd5153b3ed7084ec46601cfd5b2551825f64057`.
All ten gates and its binary/layout reviews passed. Its helpers are COMPLETE;
never rerun publication, merge or inspections. Duplicate main CI `40064396312`
was cancelled after checking the tested tree. Primary remains detached at this
merge, with only this operational handoff dirty.

## Independent API memory work

Checkout `/private/tmp/fwp-http-application-memory`, branch `http-application-memory`,
is preparing the Linux stack-page repair on `b2d34d058d49fc663fb642492e21186e50c0c06f`.
No second PR is open. Publish the repair and run the six-host API checks plus
32 fresh Windows ARM64 O2 processes, retaining every failed attempt.
Eight clients exercise mixed requests, streams, partial-body disconnects and
shutdown with seven pending handlers. Idle managed charge, accepted sockets,
metric storage and RSS are separate observations. Missing-free/close controls
must fail. The fixed budget is warm RSS plus 8 MiB; the idle deadline is 20s.

Initial source `ef66ca9973ffe55a9d246db4d6ae8373bd7749ad`, run `40066024251`,
failed because the new driver parsed floating metric text (`80.0`) as an integer.
All six complete logs show only that cause and propagated worker panics. The
original audit is complete (`fwp-audit-http-application-memory.py`).

Repair `027be46eaa8aed59a049c1fc0d112bfc4a1869e8`, run `40066708867`, fixes
parsing and verifies actual shutdown cancellation. Linux ARM64, macOS ARM64 and
Windows AMD64 and Intel macOS pass all seven checks. Audit with
`fwp-audit-http-memory-repair.py`. Two failures remain:

- Linux AMD64 O1: RSS grows from 39,184 to 47,396 KiB, exceeding 8 MiB by 20 KiB.
  Managed charge stays 3,120 bytes; all 72 sockets close; final managed charge is
  zero. O2 passes. Investigate physical mappings, not a larger budget.
- Windows ARM64 O2: idle cleanup times out after checkpoint 40, before 48. This
  precedes partial-body disconnects. O1 and its negative controls pass. Determine
  which task/socket remains parked; do not extend the deadline.

Failure archives are in `/private/tmp/fwp-http-memory-failures-027be46e`; preserve
them. Mapping review confirms 34–36 MiB of anonymous huge pages in shallow
AMD64 task stacks; ARM64 uses ordinary pages. The repair requests ordinary pages
on Linux stack allocation, preserves reuse and checks previously ignored guard
setup failures. Actual-runtime-block tests cover physical mappings and failure
cleanup at O1/O2. Native verification is pending; do not claim a repaired budget.

Latest diagnostics at `b2d34d05`:

- Run `40067908998` (`http-mappings`) reads `/proc/PID/smaps` during three fresh
  executions of each saved O1/O2 binary on both Linux architectures. Program
  source remains `027be46e`; workflow source is separate. Budget failures remain
  failures even when data collection succeeds. Both jobs and mapping review are
  complete; reports/archives are in `fwp-http-mapping-evidence/b2d34d058d49`.
  Do not rerun their downloader/reviewer. These twelve fresh processes stayed
  within the budget but identify the huge-page cost; the original failure stands.
- Run `40067911096` (`http-idle-checks`) repeats O2 three times on Windows ARM64,
  retaining every attempt. Test-only wait records expose tasks and socket waits
  without changing scheduling or the 20s limit. All three attempts pass, with
  complete logs audited. The original Windows timeout remains unresolved.
  The next diagnostic compiles once, then runs 32 fresh processes to investigate
  it without repeated C compilation.

Publication receipts/helpers use `fwp-http-{application-memory,memory-repair,
memory-diagnostics}-*`. All three publication helpers are COMPLETE; do not rerun.
The static saved-binary inspector is `scripts/inspect-http-application.py`.
`fwp-review-http-memory-host.py` reviews passing `027be46e` hosts; no such reviews
have run yet. Earlier-source evidence never substitutes for final delivery gates.

## Local checks and resource limits

Use the fixed local guard serially; full compilation and suites stay on GitHub.
The verified #206 compiler emitted API C (18.66s); Clang O1 exceeded 1 GiB sampled
RSS and was stopped. Do not retry by raising/bypassing limits. Compiler receipt:
`/private/tmp/fwp-verified-206-compiler/receipt.json`.

An 80-response raw-interpreter probe passes (0.50s); the changed startup helper's
three real-child checks pass (4.90s). Formatting, sixteen native-runner controls,
source-insertion anchors and workflow syntax pass. Latest diagnostic publication
checks pass (10.06s); the repair's formatting and observer insertion pass (2.71s). No native API was compiled locally after the refusal.

A verified saved macOS ARM64 executable from the failed `ef66` driver run passed
a bounded local diagnostic: 3,440 replies, disconnects and forced shutdown;
constant 2,576-byte idle charge, 72 sockets closed, zero final charge, 532 metric
bytes freed at exit (4.52s total, 3.10s shutdown). This is not repaired-source
acceptance. Receipts use `/private/tmp/fwp-http-native-{idle,full}-diagnostic`;
its unique archive is in `fwp-http-memory-failed-macos-ef66`. Disk is about 65 GiB
free; keep the 64 GiB reserve and prune only proven duplicates if needed.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing and limit counting at remaining boundaries |
| 2 | In progress | Extend borrowing and remove functional overhead |
| 3 | In progress | Meet measured machine-level time and memory budgets |
| 4 | In progress | Improve differentiation speed, memory and precision |
| 5 | In progress | Validate CPU numerical kernels |
| 6 | In progress | Stabilize comparisons and set workload budgets |
| 7 | In progress | Complete the application acceptance suite |

Complete the maintained service scenario, then continue replacing collector-based
checks and choose optimizations from equivalent-work numerical comparisons.
Allocation savings alone do not establish speed parity with C/Rust.
