# Repair the identity-array ownership test

**Expanded GCC ARM64/AMD64 and Clang ARM64 checks pass and are fully audited.
The final production matrix is still required.** No compiler, runtime or library
code changed.

## Failure and cause

[Production run 41931018786](https://github.com/e6qu/fun-with-pipes/actions/runs/41931018786)
at `f71b53080008923ea40af8deb6c5cd6b60ca041c` failed the regular macOS ARM64
`float_formats` target. The [full job log](mac-arm-job.log.gz) and all
[131 target logs](targets.zip) contain one failing test:
`scalar_array_identity_moves_owners_and_preserves_aliases`.

Windows AMD64 reports the same eight exit-82 probes. Its [100 target logs](windows-amd-failed-targets.zip)
and [source/checksum audit](windows-amd-failed-audit.json) contain no other failure.
Its [completed job](windows-amd-job.json) reports 154 passing target commands and
only `float_formats` failing; the [full log](windows-amd-job.log.gz) is retained.
Windows ARM64 ([logs](windows-arm-failed-targets.zip), [audit](windows-arm-failed-audit.json))
and regular macOS Intel ([logs](mac-intel-failed-targets.zip), [audit](mac-intel-failed-audit.json))
report the same probes, with no separate failure in their published target logs.

The probe expected an array map to allocate whenever the earlier identity rewrite
was disabled. Native ownership lowering now consumes that last-used input and can
reuse its storage. Exit 82 means the old allocation assertion rejected this valid
reuse; it is not a crash or an observed value/cleanup failure.

For an identity map, such as mapping an F64-to-F64 conversion over `[1.0, 2.0]`,
the test now distinguishes these exact contracts:

| Generated operation | Storage requirement |
|---|---|
| Identity rewrite removes the map | Transfer the input unchanged; no allocation or retain, including views and aliases. |
| Map remains; ordinary exclusive array; reuse enabled | Reuse the input; no allocation or retain. |
| Map remains; shared array or view, or reuse disabled | Allocate one independent array; preserve every caller alias. |

Expected reuse comes from the test's explicit alias/view/reuse setup, independently
of the runtime uniqueness function. The Rust harness also checks that generated C
contains the consuming map exactly when the earlier identity rewrite is disabled.
The focused `owned-numeric-checks` workflow now includes `float_formats` in lint
and execution, so this interaction is checked before another full platform run.

## Verification and limits

Using the exact emitted C from the failed job, Apple Clang 17 at both O1 and O2:

- Reproduces the original exit 82.
- Passes all eight combinations of identity rewrite, packed arrays and reuse.
- Checks empty/nonempty arrays, exact floating-point bits, slices, caller aliases,
  subsequent mutation, live/peak storage, traps, cancellation and physical frees.
- Still rejects a deliberately missing release with exit 90.
- Still reports injected allocation failure with exit 102 and its exact diagnostic.

The [local controls](local-controls.zip) retain eighteen ARM64 Mach-O images,
sources, commands and all fifty outcomes. [File hashes](retained-files.json) and
[original artifact metadata](ownership-artifact.json) identify the evidence.
Guarded local checks took 3.83s (O1) and 3.76s (O2); retention took 0.50s.
These local checks cover the repaired C probe; the runner checks below also
compile the changed Rust harness. Existing timing results remain unchanged
because their compiler/runtime/library sources are unchanged.

The [saved crash report](crash.ips) names
`sched::lifetime_tests::cleanup_panic_aborts_before_borrowed_tasks_escape`.
That intentional abort control passed in the unit log; it is not a recurrence of
the [unexplained historical compiler abort](../compiler-abort.md).

## Expanded runner checks

[Run 41937012404](https://github.com/e6qu/fun-with-pipes/actions/runs/41937012404)
uses `bc1bf40ea0c8ad7733b9042e2b552ae261970dce`, immutable tag
`roadmap/owned-numeric-regression-2026-11-05`. Each host passes:

- 285 unit tests, with four existing ignored tests; 110 integrations in 19 targets.
- All 722 native-image architecture checks and 733 recorded outcomes, including
  62 float-format probes at O1/O2. Negative controls retain their expected failures.
- Twelve complete-program selections, seven consuming exports and one borrowed
  exclusion; source-fixture formatting and complete job/target-log audits.

| Host | Job | Retained evidence |
|---|---|---|
| GCC ARM64 | 126947919715 | [Audit](runners/arm/verified.json), [controls](runners/arm/controls.zip), [full log](runners/arm/job.log.gz) |
| GCC AMD64 | 126947919729 | [Audit](runners/amd/verified.json), [controls](runners/amd/controls.zip), [full log](runners/amd/job.log.gz) |
| Clang ARM64 | 126947919477 | [Audit](runners/mac/verified.json), [controls](runners/mac/controls.zip), [full log](runners/mac/job.log.gz) |

Documentation run `41936992630` / job `126947841108` also passes its
[full-log audit](runners/docs-job.json). The subsequent nine production jobs and
docs also passed; [delivery receipts](../owned-numeric-checks-2026-11-05/platforms/final-gates.json)
verify the tested tree and squash merge. The historical failures above remain visible.
