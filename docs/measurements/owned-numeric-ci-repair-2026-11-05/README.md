# Repair the identity-array ownership test

**Local Clang O1/O2 checks pass. The expanded runner checks and final production
matrix are still required.** No compiler, runtime or library code changed.

## Failure and cause

[Production run 41931018786](https://github.com/e6qu/fun-with-pipes/actions/runs/41931018786)
at `f71b53080008923ea40af8deb6c5cd6b60ca041c` failed the regular macOS ARM64
`float_formats` target. The [full job log](mac-arm-job.log.gz) and all
[131 target logs](targets.zip) contain one failing test:
`scalar_array_identity_moves_owners_and_preserves_aliases`.

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
This checks the repaired C probe. It does not compile the changed Rust harness,
verify GCC, or replace the final platform gates. Existing timing results remain
unchanged because their compiler/runtime/library sources are unchanged.

The [saved crash report](crash.ips) names
`sched::lifetime_tests::cleanup_panic_aborts_before_borrowed_tasks_escape`.
That intentional abort control passed in the unit log; it is not a recurrence of
the [unexplained historical compiler abort](../compiler-abort.md).
