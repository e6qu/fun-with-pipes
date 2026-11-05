# Private pair-buffer verification

The neighboring-record helper consumes its private input. Equal-width numeric
results overwrite only records already read; other widths allocate separately.
This changes internal storage, not language values or callback order.

## Focused native results

[Run 41991479079](https://github.com/e6qu/fun-with-pipes/actions/runs/41991479079)
passes at `6e02c048019642b6f6eb52c9ae6fef5fa8f2f3f7`. Production GCC runs on
Linux ARM64/AMD64; Apple Clang runs on macOS ARM64. Each covers:

- All-target lint, compiler unit tests, primitive inventory and formatting.
- 25 relevant native targets, including both pair orientations, equal/narrow
  output layouts, empty inputs, aliases, numeric bits and eager callback order.
- Failure/cancellation, physical frees, explicit no-reuse, deliberately broken
  ownership/cleanup and extra-allocation observers.

The [complete evidence audit](https://github.com/e6qu/fun-with-pipes/actions/runs/41997987727)
passes at auditor `ed5e89867ae3b8c1ca36a3a1e7cd695228810e86`. It checks all
25 target summaries, 822 native images and 838 probe records per host, including
artifact source/digest and image architecture. No native failures or unexpected
log diagnostics remain. [Retained audit](https://github.com/e6qu/fun-with-pipes/actions/runs/41997987727/artifacts/13402427637):
SHA-256 `0e0e461219651ce8be07e1f36e33239a355a769c3c3c9286fbc11fdf26432697`.
Original images and generated C remain in the source run's three host artifacts.
These focused passes do not replace the final nine production jobs and docs.

## Measurement preparation repair

[Small control run 42000589145](https://github.com/e6qu/fun-with-pipes/actions/runs/42000589145)
at `f339616c639e4c55703f619cc46ca08f93f11ee8` ran all eight scripts. Seven passed:
reference isolation, repeated counts, phase budgets, compiler-cost controls,
runtime budgets, evidence download controls and production audit controls.
The remaining script ran 18 tests and reported five historical-source errors.

Cause: its new workflow used a shallow checkout without the saved commits/tags.
The repair fetches full history, tags and historical PR heads, matching the docs
workflow. It preserves all historical tests and runs every script even if one
fails. [Repair run 42002432263](https://github.com/e6qu/fun-with-pipes/actions/runs/42002432263)
passes all eight scripts (76 tests) at `b808155995b711a687c85a4161c3733f51cd71c1`; the failed log and
[artifact](https://github.com/e6qu/fun-with-pipes/actions/runs/42000589145/artifacts/13402753211)
remain available. No fwp compiler/native source changed for this repair.

## Next acceptance

Follow [the frozen contract](packed-pair-storage.md): compare exact complete-solve
counts and phase/overall live memory first, then compiler costs and qualified
runtime sessions. No new observations or speed claim yet. Existing timing misses
remain open in [PLAN.md](../../PLAN.md). Keep large evidence on runners while the
local disk is below its 64 GiB reserve; retain full archives before final delivery.
