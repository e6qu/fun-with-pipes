# Gradient-call verification

**Focused checks and measurement audits pass; timing goals stay open and final production gates remain.** [PR #259](https://github.com/e6qu/fun-with-pipes/pull/259)
groups scoped input borrowing, numeric fold fields, direct backward seeds and
consumed coordinate scratch. The [contract](../gradient-call-storage.md) fixes
selection rules, failure controls and measurement requirements.

## Compiler repair

Source `73261bf2d26a3c12078bc5951cba60752d38df8c`,
[run 41956890550](https://github.com/e6qu/fun-with-pipes/actions/runs/41956890550):
macOS lint and build both failed with Rust E0509. The constant proof moved a
record's shared contents out of `Value`, which has a destructor. Borrow those
contents while the value remains alive; correct the same pattern in its unit test.

The [full-log audit](compile-repair/audit.json) finds exactly that error twice,
no compiler warnings and no executed native targets. The digest-checked diagnostic
archive, full log and job metadata are retained beside it. The Linux jobs and
docs had no assigned runner when this known-failing batch was cancelled.
This audit records the compiler failure; subsequent runs below verify its repair.

## Grouped repair

Source `68f71c14226ac03818c842da0b8017ad98754c7b`,
[run 41957591695](https://github.com/e6qu/fun-with-pipes/actions/runs/41957591695):
all three compilers build, but the focused gate fails. All 75 native target logs
were audited: each host passes 22 targets and fails the same three. Unit tests
could not compile; they did not run.

| Failure | Cause and repair |
|---|---|
| Gradient input still retained | `length` borrowed its list but lacked the separate no-escape contract. Native length only traverses links; the interpreter returns a count. Record that contract and check its propagation through worker and scope. Continuing-owner, escape and dynamic-call exclusions remain required. |
| Two lint errors | Iterate paired scope/worker parameter slots instead of indexing ranges; require distinct entries with equal arity. |
| Unit compilation | Update the missed `backward_owned` test caller to explicit list seeds. |
| Packed-window ownership test | The internal fold now returns fields: expect three allocations, and inject final allocation failure before the remaining export-result box. Keep alias, cancellation and deliberately added allocation controls. |
| Scoped-input fixture | An Async callback cannot enter a pure AD scope. Yield outside the callback, then inject failure/cancellation after tape creation with the scope active. |
| Owned-tape token fixtures | `ad.tape-owned` takes a list of weights, not an integer count. Use `[0.0f128]` and `[]`; retain invalid-root and empty-tape expectations. |

The [macOS](grouped-repair/mac-audit.json),
[Linux ARM64](grouped-repair/arm-audit.json) and
[Linux AMD64](grouped-repair/amd-audit.json) audits retain full target results and
diagnostic context. Beside each are digest-checked artifact receipts, complete
job logs, and archives of every target log and probe status. Documentation
[run 41957597604](https://github.com/e6qu/fun-with-pipes/actions/runs/41957597604)
passes; its full log contains only the expected runner negative controls.

The following run verifies these repairs. Compiler diagnostics now upload before
the native queue completes.

## Native repairs pass; fixture formatting remains

Source `cd479a9aae17f91e49fb79b106c930211636304c`,
[run 41960705621](https://github.com/e6qu/fun-with-pipes/actions/runs/41960705621):
all three hosts pass lint, build, 292 compiler units, all four transformation
selections and 124 native tests across 25 targets. Four unit tests are explicitly
runner-only measurement generators/budgets; no selected native test is ignored.

The only failed step formats `gradient_call_storage.fwp`: its short `let … in …`
fits on one line. Apply the exact formatter output, verified identical across
hosts. The workflow now checks formatted copies before native tests and publishes
the result early; it does not modify the checked-in fixtures.

[Audit summary](format-repair/summary.json): complete job/target logs, 814 probe
statuses per host and 798 native image headers/digests per host were checked.
Compressed audits retain every original file hash; source selections, all
logs/statuses and formatter output are beside them. Full generated sources and
images remain in the digest-identified GitHub artifacts. Documentation
[run 41960692624](https://github.com/e6qu/fun-with-pipes/actions/runs/41960692624)
passes; the complete log contains only expected negative-test diagnostics.

That grouped run failed only formatting; the next section records the repaired
run. No allocation or timing measurements had started at this point.

## Passing focused matrix

Source `8c0e4b0ef06aa9f528eeaedbfbab9461a82dd0d7`,
[run 41962981349](https://github.com/e6qu/fun-with-pipes/actions/runs/41962981349):
all three hosts pass every step, including fixture formatting. Each passes 292
compiler units and 124 native tests in 25 targets. All four reductions are selected
in the complete programs, and deliberately missing selections are rejected.

[Audit summary](focused/summary.json) records 798 checked native images and 814
probe statuses per host. Complete job/target logs, source selections, formatter
output and compressed inventories are retained beside it. No unexpected compiler
warnings or errors were found. The four ignored units are the same explicit
runner-only measurement tests described above. Documentation
[run 41962933179](https://github.com/e6qu/fun-with-pipes/actions/runs/41962933179)
also passes; its full log contains only expected negative controls.

This source is frozen as `roadmap/gradient-call-storage-measurements-2026-11-05`.
[Allocation census 41964853201](https://github.com/e6qu/fun-with-pipes/actions/runs/41964853201)
uses it with this passing correctness run as its explicit prerequisite.
The [allocation audit](../gradient-call-census-2026-11-05/README.md) passes locally and in CI
after correcting phase-byte attribution. [Compiler costs](../gradient-call-analysis-2026-11-05/README.md)
pass; the [runtime audit](../gradient-call-time-2026-11-05/README.md) preserves
17 missed timing limits. Final production gates remain.


## First production run: lint and formatting repairs

Source `4160061cd0d421a55ab4e467c6ec5fb6fd88cbf6`,
[run 41971248924](https://github.com/e6qu/fun-with-pipes/actions/runs/41971248924).
All nine jobs are complete. The [full audit](production-repair/summary.json)
accounts for every failure; the run remains failed.

| Jobs | Target results | Failure and repair |
|---|---|---|
| Linux ARM64/AMD64 | Each: 255 targets pass; formatter and browser formatter targets fail | Initialize the unit-test `Program` directly to satisfy Clippy. Format `lib/autodiff.fwp` to fix all three failing formatting checks. |
| Regular macOS ARM64/AMD64 | Each: 130 targets pass; formatter target fails | Same unit-test lint and library-format repairs. SDK, packaging and evidence checks pass. |
| macOS ownership ARM64/AMD64 | All 126 targets per host pass | Library-format preflight only. |
| Windows ARM64/AMD64 | All 155 native probe targets per host pass; golden programs and packaging pass | Library-format preflight only. |
| C/Rust benchmarks | Execution never started | Library formatting stops the preflight; the later absent-artifact error follows. |

Focused lint previously omitted unit tests. It now uses production's
`--all-targets --keep-going`. Focused formatting now checks the library, examples,
tutorials and benchmarks alongside the new fixtures. The library repair removes
two blank lines and joins one short expression; its exact reference-patch marker
is updated. Compiler code outside the unit-test module is unchanged.

Complete job/target logs, per-host audits, summaries and digest-checked artifact
receipts are retained in `production-repair/`. The
[early audit](production-repair/early-audit.json) records the initially available
lint and benchmark results; the full audit above completes it. Documentation
[run 41971245959](https://github.com/e6qu/fun-with-pipes/actions/runs/41971245959)
passes with only the [expected negative controls](production-repair/docs-audit.json).

The library was formatted with PR #258's verified native compiler. Its parser and
formatter sources match; the [receipt](production-repair/formatter-use.json)
identifies the package and binary. Repository formatting, three reference-patch
controls, Rust formatting and workflow syntax pass locally. Runtime measurements
remain tied to their original sources; no native measurement was repeated.

The repaired commit must pass all nine production jobs plus docs before merge.

## Second production run: reference-patch context repair

Source `946069cd138a9be23f457c73316a3ecf5b972047`. Documentation
[run 41983677600](https://github.com/e6qu/fun-with-pipes/actions/runs/41983677600)
failed five gradient-array reference controls: the preceding library formatting
removed a blank line used as patch context. The repair changes context only;
all added/removed payload lines stay identical and patch matching remains strict.
Historical results keep their recorded sources and patches.

All 13 collection-reference and allocation-budget scripts pass locally (2.18s).
The workflow now executes every script before reporting group failure. Its exact
shell block passes an all-success control and failure injected at each of the
13 positions: all checks execute, and any failure makes the group fail.
Workflow syntax and whitespace checks also pass (8.43s).

In production [run 41983677606](https://github.com/e6qu/fun-with-pipes/actions/runs/41983677606),
C/Rust benchmarks passed. The eight native jobs were deliberately stopped after
the docs failure to publish this repair without finishing a superseded run.
Their completed target summaries pass; partial logs establish no final support.
Three packaging assertions and missing-archive errors occurred after cancellation
interrupted evidence generation. The [audit](reference-repair/summary.json)
retains every full job log, available target log, artifact identity and local
reference-check result. All nine jobs plus docs still must pass on the final head.
