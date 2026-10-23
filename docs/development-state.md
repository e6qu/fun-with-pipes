# Session handoff

All seven PLAN.md areas remain open. Remove tracing, prefer ownership and borrowing,
and reserve ARC for necessary sharing. JIT is excluded.

## Current delivery and preparation

**Next:** finish [PR #203](https://github.com/e6qu/fun-with-pipes/pull/203) at
`460e847b34a7b2691b69f89a4dfea84ea25950b7`: production `40002922119`, docs
`40002921896`, then 853 binary inspections on each native host. Audit every
completed job and fix all failures before a single repair push. Merge only after
all nine production jobs, documentation and binary inspections pass.

The delivery worktree is `/private/tmp/fwp-task-delivery`. Its final commit stays
unchanged while derivative preparation proceeds separately in
`/private/tmp/fwp-derivative-cleanup`, branch `derivative-cleanup-preparation`.
The derivative branch starts from that PR head; keep one active PR. Do not treat
unmerged preparation as final platform support.

[PR #202](roadmap-history.md#cached-values-aliases-and-failed-calls-pr-202) is
verified merged at `ff1bfcc8a294a488b9cb043622143233a903d068`, with all jobs,
logs and 3,414 binaries accepted. Its redundant main CI was cancelled and main
docs passed. The recorded merge has one subject, no body or trailers.

## Derivative cleanup preparation

Two groups extend ownership checks to detached numeric buffers, callback scopes,
input/result arrays, nested gradients and expired handles. Repeated managed-byte
balances complement raw-buffer free counts. Missing releases must fail; ARC uses
no tracing or permanently retained poison. Workspace caching is explicitly off.
[The guide](measurements/record-cleanup.md#derivative-buffers-and-callback-scopes)
explains the example, boundaries and measurement limits.

The original fixtures left arrays for tracing. They now release those owners.
A new raw fixture crashed because it omitted ARC's required tape scope. Adding
that scope and separating the injected task's cleanup chain repaired it; the
mutable scope is static to keep its contents defined across `longjmp`. A source
fixture initially put printing inside a pure scope; printing now occurs outside.
Failed diagnostics remain in `/private/tmp/fwp-derivative-raw-probe` and
`fwp-derivative-raw-source`. An unresponsive debugger was stopped; a sanitizer
attempt timed out; bounded stage logging located the missing scope. Neither is
reported as passing validation.

Local checks use the accepted unchanged compiler `5e17fc10e860b1971ffc9cd9cb57fcb795ccad24`.
Native code, runtime and library are unchanged. Local Clang results cannot
establish GCC or Windows support. The expanded focused workflow selects 46 groups;
its expected artifact contains 975 saved images (960 aggregate, 12 allocator and
3 default binaries). All six final native targets remain required.

Local receipts: `fwp-derivative-raw-probe-v3` (34 outcomes, 10.94s),
`fwp-derivative-scope-probe` (34, 12.68s), `fwp-derivative-raw-source-v2`
(30, 13.01s) and `fwp-derivative-scope-source` (24, 25.77s), all under
`/private/tmp/`. Each includes generated C, real ARM64 binary inspection and
expected failures. The earlier successful raw-probe v2 preceded the explicit
static-scope repair; v3 is final. Formatting, fourteen runner controls, docs, the
executed gradient example and the 975-image manifest pass (11.65s guarded).
Formatting and reference-artifact saves after those runs do not change the
emitted C or observed source programs. Focused GCC/Windows CI is still required.

## Adjacent array and borrowed-callback preparation

Derivative source `2fe6bf63c485ee79fc05684f4f52ca7bb596155b` is published at
`roadmap/preparation-derivatives-2fe6bf63c485`; focused runs are Linux AMD64
`40005138351`, Windows AMD64 `40005142138` and Windows ARM64 `40005145689`.
All were running without failed steps at the last check; final results and their
975-image inspections remain unverified. Preserve that source separately.

The cumulative branch `array-cleanup-preparation` in `/private/tmp/fwp-array-cleanup`
adds two groups while keeping #203 unchanged. Fixture lists and optional-result
containers now have explicit releases; every missing owner must be detected.
The borrowed source example now uses explicit `apply 7 (choose 3)` and runs
against the interpreter. Its earlier function-valued pipe was only emitted for
runtime metadata in that test, not checked as an executed example.

Seventy local ARM64 outcomes pass: `fwp-array-borrowed` (28, 12.73s),
`fwp-array-scalar` (22, 11.31s), `fwp-array-reclamation` (6, 4.13s) and
`fwp-array-aliases` (14, 12.12s), under `/private/tmp/`. The scalar calling
conventions were inspected first (`fwp-array-scalar-layout`, 0.25s guarded).
No compiler/runtime changes. The new focused selection has 48 groups and its
expected artifacts contain 1,045 images per host, including 1,030 aggregate
outcomes. Formatting, fourteen runner controls, docs, the executed array alias
example and the 1,045-image manifest pass (11.51s guarded). Windows binary output
setup now reports failure explicitly; native Windows verification is pending.
Full final native acceptance remains required.

The first array source `455d4ea904f2636cb9f557a5c8539f92f1510c02` failed all
three focused compiler checks: Linux `40006880672`, Windows AMD64 `40006884490`,
Windows ARM64 `40006888933`. Full logs show the same missing `record_probe`
module declaration at five call sites in `array_element_ownership.rs`. Native
batches could not start; Linux's 179 library tests and runner controls passed.
The declaration is restored, all saver users were audited, and the new one-character
replacement uses a character pattern. Generated C and local outcomes are unchanged.
Failure evidence: `/private/tmp/fwp-array-failure-audit.json` and its three logs.
The repaired source requires fresh focused CI before any acceptance claim.

## Resume records

`/private/tmp/fwp-task-publication.json` identifies #203 and its runs;
`fwp-audit-task-final.py`, `fwp-inspect-expanded-task-delivery-builds.py` and
`fwp-expanded-merge-task.py` require exact-source acceptance. Publication helpers
for #203 COMPLETED; do not rerun them. Preserve immutable tags and inspection
reports. `/private/tmp/fwp-check-derivatives.py` runs one explicit part and output
path; read existing results before repeating anything.

Use `python3 scripts/local-guard.py COMMAND...` serially. Full suites and builds
stay on GitHub; keep all CPU, RSS, disk and deadline limits. Verified #202 archive
cache copies were pruned after checking remote originals and full hashes, freeing
989.8 MiB. Reports and unexpired GitHub originals remain; receipt:
`/private/tmp/fwp-pruned-call-archives.json`.

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

The largest measured descent case still takes about 10–14 times the C/Rust time.
Fewer allocations alone do not establish parity. Preserve measured controls and
separate callback, indexing, output and buffer costs before selecting changes.
