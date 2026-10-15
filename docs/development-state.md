# Session handoff

Updated 2026-10-15. Current branch: `project-roadmap-cleanup`, based on merge
`bbdbf8dc` (PR #142). The user requested the remaining project work in PLAN.md
and removal of obsolete information throughout the repository. They clarified
the memory objective: remove tracing GC and limit ARC, preferring compile-time
ownership and borrowing in the spirit of Rust without losing simple pipes.

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

## Current delivery

The cleanup replaces the completed checklist with seven work areas, completion
evidence and a first milestone: measured baselines, confirmed costs and the next
ownership boundary. It updates contributor/agent instructions and the README;
removes obsolete phase/migration language, repeated historical stubs and old
branch/merge instructions; and corrects stale protocol/compiler comments.
Immutable preparation IDs/tags, raw measurements, meaningful compatibility
contracts, licenses and regression controls remain intact.

The new direction is a goal. The implemented runtime still combines tracing and
counting by default, and checked ARC covers a subset. Do not claim GC removal or
count-free abstractions from this documentation change.

## Outstanding validation

PR #142 merged before CI finished. Its merge `bbdbf8dc` and final PR head
`4ea1b687` have identical files. [The merge production run](https://github.com/e6qu/fun-with-pipes/actions/runs/38752839908)
reported a failure in regular ARM macOS: `rest::openapi_golden` compares the
bookstore example's updated description with an old `books.openapi.json` fixture.
The documentation audit passed. Follow the production run for other outcomes;
partial success is not acceptance. This delivery includes the fixture repair.

The OpenAPI fixture has been regenerated; the only fixture change is
“REST, interpreted” to “REST, compiled and cached.” All four OpenAPI comparisons
pass without `FWP_BLESS`. This uses the existing compiler for a focused check;
full CI must rebuild and validate the published revision.

Local validation, all through `python3 scripts/local-guard.py`:

- Standalone `tests/rest.rs` harness compilation: passed, 0.87 seconds.
- `FWP_BLESS=1 ... --exact openapi_golden`: regenerated, 2.85 seconds; reviewed
  the fixture diff before checking without regeneration enabled.
- Serial preflight `/private/tmp/fwp-roadmap-preflight.py`: passed, 5.17 seconds.
  It checks all 50 Markdown link sets, 106 immutable preparation rows/tags and
  seven matching plan/handoff steps; all four OpenAPI fixtures; generated library
  docs; every tutorial's source/output copies; Rust formatting; JavaScript syntax;
  and diff whitespace. No limits were raised.

The repository audit covered tracked guides, examples, generated fixtures,
source/runtime comments, scripts and workflows. References to old implementations
used by deliberate regression controls and version compatibility rules are still
relevant and remain. No compiler/runtime behavior changed in this cleanup.
Full builds, suites and benchmarks stay on GitHub runners.

## Next action

Next: publish this branch as one PR and fix every final-commit CI failure before
squash merge. Keep all
nine production jobs and documentation coverage. If this delivery is already
merged with passing checks, start the first milestone in PLAN.md: select the
representative applications, reproduce the known performance gaps on runners,
and identify the first ownership boundary to improve. Do not replay old PRs.

Update this handoff with exact checks, unresolved failures and one concrete next
action after meaningful progress. Keep the project plan active until its stated
acceptance criteria are met; do not substitute a completed PR for that evidence.
