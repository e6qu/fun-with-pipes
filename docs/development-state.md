# Current work

**Next: finish final-head CI and the complete-log audit for the `resource-field-costs` PR.**
PR #276 is merged and fully verified. This branch delivers verified diagnostics
and retained results;
it does not change production ownership or claim a new speedup. Follow
[the ordered investigation](measurements/resource-field-costs.md), then bundle
any worthwhile proven improvement, controls and measurements in one normal PR.

Worktree `.worktrees/service-cpu-costs`, branch `resource-field-costs`, based on
`b2bbd0389d227ea097ea1239d8d02ec6346f4be7`. Publication of all current work as a
normal PR follows this report commit; require the nine production jobs, docs and complete-log audit
on its exact head before squash merge. Keep the final head unchanged unless a
real failure requires repair.
Published preparation: `9b24e6965dd4c7cfb6e88163a34722e0b99ec901`, retained by
`roadmap/resource-field-census-preparation-2026-11-10`. Focused native census
run `42830283981` passes both jobs: ARM64 `129878222562`, AMD64 `129878222459`.
Both complete logs are clean. [Retained census](measurements/resource-field-census-2026-11-10/README.md)
reconstructs all 17 inputs on both hosts; each C hash and classification agrees.
Executed counts at `b4b11d4a9f545b03a6af4b03f37612fb15650c9c`, retained by
`roadmap/resource-field-holds-preparation-2026-11-10`, also pass both jobs in run
`42833961349`: ARM64 `129891087787`, AMD64 `129891088346`. Complete logs are clean.
[Both reports](measurements/resource-field-holds-2026-11-10/README.md) reconstruct
all 34 executions per host, unchanged totals and real extra-pair controls.

## Verified delivery

[PR #276](https://github.com/e6qu/fun-with-pipes/pull/276) merged as
`b2bbd0389d227ea097ea1239d8d02ec6346f4be7`. Its tree equals tested head
`55060a061801a51a583dccc5777113e5ce49ccce`; message is one 63-character line,
without body or trailers. [Final receipts](measurements/nested-resource-final-gates-2026-11-10/README.md):

- Production `42814261330`: all nine jobs pass.
- Documentation `42814261144`, job `129823185341`: pass.
- Complete-log audit `42828337804`, job `129871448955`: pass; ten reports, no issues.
- Audit artifact `13770546233`: full size/SHA-256/member checksums pass locally.
- Duplicate main checks `42829037660` and `42829037694` cancelled after equal-tree proof.

## Performance results stay qualified

[Nested borrowing](measurements/nested-resource-time-2026-11-10/README.md) uses
16–21% less time in qualified service cases; 31/32 runtime and 63/64 compiler
comparisons qualify. One runtime comparison and one compiler comparison are noisy;
four original ARM64 RSS limits miss 5%. Keep all original acceptance limits open.
Large cases perform 29.7–36.9% fewer cleanup registrations and 4.85–5.34% fewer
actual reference-count updates, with unchanged allocation requests/charged peak.

[Memory diagnosis](measurements/nested-resource-memory-2026-11-10/README.md) uses
original binaries/container/libc and finds lower sampled resident-page peaks.
It does not establish the cause of the original RSS misses or replace their limit.
[All 34 HTTP trials](measurements/nested-resource-http-load-2026-11-10/README.md)
pass: 26,228,542 attempts, no failures, successful shutdowns and flat sampled RSS.
This is capacity evidence, not an HTTP speedup. Do not repeat unchanged timings.

## Prepared census and remaining work

- `resource_field_census.py` reports exact original-frame contexts, concrete types
  and the current resource classification in a separate diagnostic compiler.
- `inspect-nested-resource-analysis.py` now requires `--kind nested-borrows` or
  `--kind plain-fields`; the existing timing workflow supplies its mode explicitly.
  The new mode compares exact emitted C on 17 inputs, including the exported service.
- `resource-field-census.yml` builds both compilers on native runners and retains
  all C, classifications, commands and failures. No ordinary runtime is timed.
- Census finds five plain field slots in the service and twenty in HTTP; these
  are emitted sites, not executed counts or a speedup.
- `measure-resource-field-holds.py` passes GCC O1/O2 on both native hosts using
  saved service C: baseline totals, attributed holds, one actual added hold/release
  and all eight cases. Its raw auditor verifies native binaries and rejects changed
  summaries even with refreshed checksums. No compiler rebuild or timing was needed.
- Plain fields cause only 1.35–1.70% of successful retains in large service cases.
  Child decrements are not all removable work. A standalone field-only optimization
  is not selected; secondary reuse benefits remain unmeasured.
- Next implementation selection needs HTTP executed counts and attribution of
  callable-field holds/whole-frame setup. Arrow types do not reveal captures: a
  later proof must establish actual constructor origin and captured values, reject
  executed/nullary constructors and preserve branch/loop lifetime boundaries.
- Scope is separately represented fields. Keep ordinary owners, opaque closures,
  variants and containers. Do not infer captures from arrow types or classify an
  ordinary cleanup record as an original resource-lifetime record.

## Roadmap status

| Step | Status | Delivered | Remaining |
|---|---|---|---|
| 1 | In progress | #270 docs and fresh F64 stores | Original AMD timing acceptance |
| 2 | In progress | #271 captured maps and empty-owner transfer | Original noisy timing acceptance |
| 3 | In progress | #272 structured gradients and known callbacks | Original AMD timing acceptance |
| 4 | Verified | #273 ownership/peer comparisons and parser cleanup; all gates | Recorded comparison limits apply |
| 5 | Verified | #274 applications, compiler reports/growth, HTTP load; all gates | Recorded observation limits apply |
| 6 | In progress | #275 borrowed types; application speed/memory targets; all gates | Four noisy growth comparisons |
| 7 | In progress | #276 nested lifetime borrowing, gains, diagnosis; all gates | Original noisy/RSS acceptance |
| 8 | In progress | Both native static and service-execution censuses pass | PR delivery, HTTP/callable attribution, selected proof and measurements |

## Local checks and preservation

All checks use `python3 scripts/local-guard.py` serially. The census reader's
four tests and the existing proof reader's two tests pass. Changed-workflow
`actionlint` passes. No local compiler build, full suite or benchmark ran.
The explicit census CLI check passes. After staging new docs, the roadmap check
passes 473 doc link sets, 106 immutable preparation anchors and eight milestone
statuses. Real saved service C matches all five typed counter hooks; no compiler
was run locally. Retained readers reconstruct both static and executed reports.
Counter/auditor CLI checks, changed-workflow actionlint and staged documentation
checks pass. All native focused controls pass; final PR delivery gates remain.

Keep 64 GiB free, generated targets below 2 GiB, workload RSS below 1 GiB and the
180-second guard deadline. Last free space: about 107 GiB. Preserve unrelated root
edits, old worktrees, stash `451bbf713d451f2d62d80fd7676839404875846a` and backup
`540b0682408d751afb6e439d58a3b887bdcba373`.
Source-review notes remain at `/tmp/fwp-resource-cost-review-next.md`; the frozen
ordinary service C is `/tmp/fwp-nested-current-source/nested-time-peers/original.c`.
Do not download full compiler/binary archives locally or raise transfer limits.
