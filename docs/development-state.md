# Current work

**Next:** monitor all nine final-head production jobs plus documentation and G2
for PR #221. Monitor on a timer,
audit every failed/completed target, and batch any needed repairs before pushing.
Squash-merge only after all gates pass; then begin F1–F3 together in the next PR.

[PR #221](https://github.com/e6qu/fun-with-pipes/pull/221) uses
`/private/tmp/fwp-parser-workspace`, branch `scoped-parser-workspace`, based on
verified #220 squash `56d5aac63a9963ae6b16574f10d6dc3087a08d8a`.
A6 is implemented and measured; complete platform acceptance is pending.
[The lifetime contract](parser-workspace.md) and
[the measured comparison](measurements/parser-workspace.md) define its limits.

## Source and completed checks

- Compiler/runtime source is `ca56023eb362259cf2099c9c9d477b20b3cf6793`.
  Later changes add measurement diagnostics and docs; the source diff is empty.
  Do not repeat passing focused compiler tests for report-only changes.
- Native Linux ARM64/AMD64 run `40650396700` passed: 211 units, six allocator
  tests, six parser tests, two record tests, Clippy and actual WASI O1/O2 checks.
  All logs and 26 native/WASI probes per host were independently audited for
  outputs, statuses, physical cleanup, deliberate mutations and binary targets.
- Measurements at `35250b3a5ecdaa8f3e02ddb7af9664c84068f186` passed twice per
  architecture: AMD64 `40656341807`, ARM64 `40657569359`. All logs and artifacts
  passed independent audit: samples, budgets, allocation/cleanup, actual binary
  headers and text sizes, compiler scale and GCC stack observations.
- [The retained data](measurements/parser-workspace-2026-10-28.json) includes
  every current sample and prior measurement attempt. Three earlier identical-
  binary controls failed at 10.08%, 10.44% and 10.47%; their candidate timings are
  absent. Longer samples did not eliminate failures. Added CPU/scheduling data
  does not establish their cause. Preserve the unchanged 10% limit and reject
  future unstable controls; never discard failed samples or reset budgets.
- Eleven measurement evidence controls, actionlint and the documentation audit
  passed locally under the guard; docs CI `40656331725` passed. The consolidated
  final report audit passes 169 link sets, 106 preparation pairs and eight steps.
- No full local build, suite or benchmark ran. Earlier guarded Clang O1/O2
  checks cover allocation boundaries, oversized nodes, growth, nested owners,
  every allocation failure and missing cleanup. GCC results come from CI.

## Result and limits

One invocation owns aligned 256-to-4,096-byte blocks. Admitted recursive nodes
contain only integers and internal links; the links have no counts. Allocation
helpers receive context explicitly; readers need none. Recursive public calls
start new owners. Escaping/cached trees, unknown/captured uses, managed node
fields and self-tail roots keep ordinary ownership. Strings/tokens retain theirs.
Completed helper clones obey actual code-growth limits. Cancellation is observed
after a tree exists; omitted cleanup must fail the physical-storage check.

The four fixed trees parse in 18–28% less time than previous fwp, but take
5.7–9.4× C and 5.2–8.6× Rust time. The peers borrow tokens; fwp owns them.
Allocations decrease while total allocated slot bytes rise 4–14%; peak live
slots match previous fwp. Report these tradeoffs, individual stack frames and
compiler RSS, not only removed counts. This is one workspace, not general regions.

## Repairs and artifacts

This PR also fixes guard tests that depended on host disk capacity and Linux
WASI jobs that mixed Clang 21 with LLVM 18 libraries. Production guard limits
remain unchanged; the shared WASI setup pins and preflights matching tools.
Measurement repairs recognize the previous unboxed worker/public bridge and
require actual exported roots in compiler-scale output. Invalid earlier compiler
rows are retained and labeled in the report.

Current artifacts: `/private/tmp/fwp-221-ca560-checks` and
`/private/tmp/fwp-221-35250-measurements`. Earlier artifacts and audits remain in
`/private/tmp/fwp-221-{a55,ec36,ca560,a51}-measurements`; do not remove evidence
needed to reproduce the published record. No detached merger runs.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain collector-free ownership and cycle checks |
| 2 | In progress | A6 final platform acceptance |
| 3 | Pending | Functional calls and recursion fixtures/optimizations |
| 4 | Pending | Close named CPU performance gaps |
| 5 | Pending | Derivative storage, timing and precision |
| 6 | Pending | CPU numerical kernels |
| 7 | In progress | Extend fixed comparison budgets and audit controls |
| 8 | Pending | Larger-program correctness, cleanup and scale matrix |

## Recovery

GC removal is verified in #217; A1–A5 through #220. A6 needs final platform gates;
steps 3–8 remain open. [History](roadmap-history.md) owns completed delivery IDs;
[PLAN.md](../PLAN.md) owns tasks. The original intermittent Intel compiler abort
remains unexplained; preserve evidence and investigate source/input on recurrence.

The primary checkout is detached at #209 with a recovery pointer and an untracked
compiler-abort report; preserve both. Disk is about 76 GiB free. Keep the fixed
64 GiB/2 GiB/1 GiB/180-second limits and use `local-guard.py` for local checks.

Publication and squash merge are authorized after all final-head gates pass:
one line <=80 characters, empty body, no trailers/attribution. Verify the merged
tree and message, then continue the next substantial PR.
