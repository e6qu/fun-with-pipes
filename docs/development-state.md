# Session handoff

Updated 2026-10-15. Current branch: `document-no-jit`, based on merge `700c2e7f`
(PR #143). The user explicitly excludes JIT from the project: it is never a
planned feature, rather than deferred work. PLAN.md, agent instructions and the
compiler/numerical guides now record this decision. The seven project work
areas and the goal of removing GC while limiting ARC remain active.

## Roadmap status

These rows track the project work areas in [PLAN.md](../PLAN.md). Past delivery
batches are in [history](roadmap-history.md); their completion does not finish
the project's efficiency goals. Planning a feature is not implementing it.

| Step | Status | Remaining scope |
|---|---|---|
| 1 | Pending | Remove tracing GC; use moves/borrows and limit ARC to necessary sharing |
| 2 | Pending | Remove avoidable allocation and calls from functional patterns |
| 3 | Pending | Diagnose and reduce machine-level performance gaps |
| 4 | Pending | Improve derivative timing, memory scaling and precision |
| 5 | Pending | Broaden efficient numerical kernels and validate device claims |
| 6 | Pending | Establish dependable comparisons and regression criteria |
| 7 | Pending | Exercise ownership, inference and tooling in larger programs |

## Latest merged work and validation

[PR #143](https://github.com/e6qu/fun-with-pipes/pull/143) merged as `700c2e7f`
before CI finished; its files match final PR head `020ac73a`. It replaced the
completed checklist with seven project work areas and measurable criteria,
removed obsolete guidance, and fixed PR #142's stale bookstore OpenAPI fixture.

[Production checks on the merge](https://github.com/e6qu/fun-with-pipes/actions/runs/38761771511)
and [documentation checks](https://github.com/e6qu/fun-with-pipes/actions/runs/38761771377)
determine acceptance. Inspect their actual outcomes; a merged PR or a skipped
pre-merge job does not establish passing tests. The prior PR #142 failure and
fixture repair are recorded in [history](roadmap-history.md#documentation-rewrite-pr-142).

PR #143's focused guarded checks passed: all 50 Markdown link sets, 106 immutable
preparation rows/tags, seven matching plan/handoff steps, four OpenAPI fixtures
without regeneration enabled, generated library docs, tutorial source/output
copies, Rust formatting, JavaScript syntax and diff whitespace. The serial
preflight took 5.17 seconds; no resource limits were raised. The OpenAPI check
used the existing compiler; full CI rebuilds the published revision.

## Current delivery

Make the no-JIT decision explicit throughout the plan and compiler guidance.
The existing OpenCL path calls `clBuildProgram` at runtime in `src/numerics.rs`
and `runtime/fwp_rt_kernel.c`; the plan records this as a gap to resolve under
the no-JIT policy, not an exception. This is documentation only; it does not
alter runtime behavior or existing validation requirements.

`python3 scripts/local-guard.py python3 scripts/check-roadmap.py` passed: all
50 Markdown link sets, 106 immutable preparation rows/tags, seven matching
plan/handoff steps and commit rules (2.85 seconds). Final link verification also
covers the added no-JIT/device-compilation notes. No local limits were raised.

## Next action

Next: publish the no-JIT clarification, inspect the merged cleanup's CI results,
and fix every final-commit CI failure before squash merge. After this clarification
is merged with passing checks, start the first milestone in PLAN.md: choose the
representative applications, reproduce known performance gaps on runners and
identify the first ownership boundary to improve. Do not replay old PRs.

Update this handoff with exact checks, unresolved failures and one concrete next
action after meaningful progress. Keep the project plan active until its stated
acceptance criteria are met; do not substitute a completed PR for that evidence.
Use `python3 scripts/local-guard.py COMMAND...` for bounded serial local checks;
full builds, suites, benchmarks and large regeneration stay on GitHub runners.
