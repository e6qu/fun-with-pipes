# Session handoff

Updated 2026-10-15. Current branch: `measured-ownership-performance`, based on
`e94cc4a6` (PR #144). The user requested cancellation of remaining old CI runs
and the next large combined PR. They also requested automatic currying to avoid
writing `curry`/`uncurry`; the proposed type-directed adaptation rules are still
being discussed. Continue independent performance work during that discussion.

## Roadmap status

| Step | Status | Current scope |
|---|---|---|
| 1 | Pending | Remove tracing GC; use moves/borrows and limit ARC to necessary sharing |
| 2 | In progress | Inspect avoidable costs in fused array/iterator loops |
| 3 | In progress | Establish comparable numerical measurements and inspect generated loops |
| 4 | In progress | Reproduce the derivative metadata timing regressions |
| 5 | Pending | Broaden numerical kernels; resolve runtime OpenCL compilation under no-JIT policy |
| 6 | In progress | Improve sample ordering and baseline comparability |
| 7 | In progress | Select numerical, collection-heavy and repeated workloads |

## Merge and cancellation record

The user merged [PR #144](https://github.com/e6qu/fun-with-pipes/pull/144) as
`e94cc4a6`; its files match final head `5ec27257`, and the one-line merge message
meets the commit rules. At their explicit request, cancelled remaining runs
`38765035981`, `38765035723`, `38762453518`, `38761771511` and `38752839908`.
Do not restart these old runs or count cancellation as a pass. The instruction
applies to those remaining runs; the new implementation delivery still needs
its own focused checks and full final-commit CI before merge.

PR #143 fixed PR #142's stale bookstore OpenAPI fixture; its four focused
OpenAPI comparisons passed locally without regeneration. PR #144 documents that
JIT is explicitly excluded, not deferred. Earlier delivery evidence remains in
[history](roadmap-history.md). The active project work is in [PLAN.md](../PLAN.md).

## Combined delivery scope

- Establish runner measurements for current numerical arrays/matrices, repeated
  derivative calculations and complete programs, with source/compiler/CPU data.
- Improve comparison fairness: rotate implementation order, retain samples and
  distinguish compile-time-known dimensions and algorithms from runtime work.
- Investigate the per-element checked index/cleanup work in fused array loops
  and tracing-only compiler fences still present in checked ARC executables.
  Prove any removed work unnecessary before changing it; preserve arithmetic
  traps, failure cleanup, alias behavior and task cancellation.
- Reproduce paired derivative-buffer slowdowns before selecting a change there.
- Audit curry/uncurry uses and settle the adaptation rules before changing
  inference. Ordinary partial application must retain its meaning. Ambiguous
  argument shapes must not silently select a different call.

Acceptance requires raw-interpreter/native agreement, allocation/retain/cleanup
counts, generated binary inspection, explicit before/after comparisons on Linux
and macOS ARM64/AMD64, and all nine production jobs plus documentation. Keep
source and result provenance; fewer allocations alone is not a speed claim.

## Progress and checks

Read the current compiler/ownership contracts and emitted one existing numeric
array program with the guarded command:
`target/debug/fwp build --fn reduce64 --emit-c -o /private/tmp/fwp-baseline-array.c tests/fixtures/numeric_array_fusion.fwp`.
It passed in 0.63 seconds. This uses the existing compiler for inspection only;
runner builds establish current source behavior. No local benchmark was run.

The emitted loop already avoids intermediate arrays and per-element retains,
but registers a cleanup around each checked index increment. Array headers
reserve their high bit for views, bounding length by I64's maximum; a successful
read therefore bounds the next index. The ARC runtime also retains compiler
memory fences originally intended to keep conservative GC roots alive. These
are candidate costs to validate, not accepted optimizations yet.

A new explicit `performance` selection in the numerical workflow groups focused
ownership tests and numerical/derivative/program measurements on four native
hosts. Initial results establish the pre-change baseline; this dispatch is not
the full production acceptance gate.

## Next action

Next: validate and publish the baseline measurement preparation as a draft PR,
dispatch its performance suite, then implement and test the proved loop/ARC
improvements while the baseline runs. Keep all changes in this combined PR;
mark it ready only when its final content and evidence are reviewable.

Use `python3 scripts/local-guard.py COMMAND...` for focused serial local checks.
Full builds, suites, benchmarks and large regeneration stay on GitHub runners.
Preserve fixed resource limits and the one-line, <=80-character commit format
without body, trailers or attribution. Update this handoff after meaningful
progress; the project remains active until PLAN.md's criteria are met.
