# Session handoff

All seven areas of [PLAN.md](../PLAN.md) remain open. Remove tracing and prefer
ownership, borrowing and moves; use ARC only where sharing needs it. JIT is excluded.
Continue substantial grouped PRs, with one active delivery and exact-head acceptance.

## Accepted baseline

[PR #198](https://github.com/e6qu/fun-with-pipes/pull/198) is squash-merged as
`27a3e009b83e28f06130a5d686a3196b9934e53f`. All nine production jobs
(`39845348815`) and docs (`39845348589`) passed exact head
`30c6d65c10b3cc33cfeb72f523e4d47624508896`. Final inspection covered 480 native
binaries and 816 execution observations. The merge tree, sole parent and exact
one-line message were verified; no body or trailers. [History](roadmap-history.md#local-callback-captures-and-repeated-numerical-work-pr-198)
records the result. Redundant main production run `39871314012` was cancelled;
main documentation was preserved.

Receipts: `/private/tmp/fwp-198-final-acceptance.json`,
`/private/tmp/fwp-198-merge.json`, `/private/tmp/fwp-198-merge-runs.json`.
The clean `/private/tmp/fwp-direct-entry-delivery` worktree preserves the tested
head. Do not rerun its completed merge, publication or inspection helpers.

**Next:** audit all nine production jobs and docs for the current head of
[PR #199](https://github.com/e6qu/fun-with-pipes/pull/199). Inspect default O0/O1/O2
binaries on all six native platforms, fix every failure together, then squash-merge
with one line (at most 80 characters), an empty body and no trailers. Verify the
merge tree, sole parent and message, then continue PLAN.md. No permission question
is pending. A failed or skipped job is not support.

## Current ownership migration

Branch `checked-native-default` lives in `/private/tmp/fwp-checked-native-default`,
based on #198's verified merge. Use this worktree for code; the primary checkout
is detached at #198 with the live handoff. The current head/run IDs belong in
`/private/tmp/fwp-default-ownership-publication.json`; check that receipt and the
PR before publishing or dispatching again. The initial publisher
`/private/tmp/fwp-publish-native-default.py` completed. Final repair publication
uses `/private/tmp/fwp-publish-native-default-repair.py`; do not repeat it once
its publication receipt records completion.

The PR includes:

- Checked ARC for ordinary native builds, commands and generated modules.
  Ownership rejection stays an error; no automatic switch to tracing is added.
  Explicit `--gc tracing` still exists, so this does not complete GC removal.
- Consistent build option errors: repeated or unknown `--gc` values are rejected,
  including options after the source file. Previously `build` accepted repeats.
- Default run/build/test/pipe checks, cache identity against explicit ARC, and
  O0/O1/O2 binaries with symbol/output evidence for independent inspection.
- Explicit tracing selection in existing collector, disabled-freeing and
  poisoned-storage probes. Dynamic comparisons select both ARC and tracing.
  The expired inter-task derivative keeps its tracing runtime-trap test and
  separate ARC compile rejection. No test assertion or collector gate is removed.
- Current README, reference, design and ownership guidance for the new behavior.

The Python disassembly comparison now requires `ownership="arc"` or `"tracing"`,
records it and passes it explicitly to C generation. Invalid modes fail before
creating output. Its example and tests cover both modes at O0/O1/O2/O3.

## Focused run and complete repairs

Run `39883631101` checked source `93b6b8ed`. Compilation/lint of every test target
passed. All six execution targets passed: `aot`, `std_tests`, `arc_execution`,
`cli_ownership`, `golden_run`, `arc_corpus` (26 tests). Of 179 library unit tests,
178 passed and only `grpc::web::tests::body_bounds_and_error_order_agree_with_native`
failed: its deliberate GC-stress run inherited the new ARC default. The entire
log and remaining steps were audited. The failure is preserved in
`/private/tmp/fwp-default-ownership-preparation-acceptance.json` and
`/private/tmp/fwp-default-preparation-120186598150.log`.

The repair explicitly selects tracing for that unit's generated probe and restores
its prior compiler options. The wider audit also repairs `compiler_options.rs`
for the specific invalid-mode diagnostic and explicitly selects tracing in
`tests/support/http2_values.rs`, shared by collector/omitted-owner probes.
Assertions and collector stress settings remain intact. The focused workflow now
also includes compiler-option and HTTP/2 root checks for future dispatches.

Three unused allocation scripts tied to pre-ARC compilers were removed; the
benchmark guide links their frozen historical sources. The current iteration
measurement selects tracing explicitly. This is not complete GC removal, and
remaining PLAN areas stay open. Do not repeat the six unchanged passing targets
merely to create another focused run; full final-head CI checks the combined repair.

## Checks and resources

The initial grouped check (`/private/tmp/fwp-check-native-default.py` through the
guard) passed formatting, workflows, 106 documentation link sets/immutable anchors,
seven plan steps and preservation of test functions/collector settings (8.76s).
The combined repair passed the same check in 6.23s. No full compiler build or
suite ran locally; complete validation belongs on runners.

Two focused SDK tests passed through the guard in 1.58s: invalid mode rejection
and inspection of eight native ARM64 objects (O0/O1/O2/O3, ARC and tracing).
They used the already accepted #197 compiler at
`/private/tmp/fwp-check-compiler-0367e819/fwp`, with Apple Clang and LLVM objdump;
this checks the new Python API, not the new compiler's final acceptance.
Command: `python3 -W error::ResourceWarning -m unittest`
`test_tools.Tools.test_disassembly_rejects_invalid_ownership_before_creating_output`
`test_tools.Tools.test_disassembly_compares_c_and_instruction_encodings_at_four_levels -v`,
with explicit `PYTHONPATH`, `FWP_TEST_BIN`, `FWP_OBJDUMP` and `CC` inside the guard.

`/private/tmp/fwp-inspect-default-builds.py` accepts explicit run/source/host/job
and artifact arguments. It checks archive hashes, actual image architecture,
disassembly, output and absence of tracing in O0/O1/O2 default builds. Require a
passing final job; do not substitute the failed preparation run for acceptance.

Keep local checks serial and guarded: at least 64 GiB free disk, generated target
storage below 2 GiB, sampled aggregate RSS below 1 GiB and a 180-second deadline.
Do not increase limits. Preserve modified worktrees and receipts. The initial
explicit-control edit inventory is `/private/tmp/fwp-checked-default-explicit-controls.json`.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing and limit ARC at remaining boundaries |
| 2 | In progress | Extend borrowing and remove functional overhead |
| 3 | In progress | Meet measured machine-level time and memory budgets |
| 4 | In progress | Improve differentiation speed, memory and precision |
| 5 | In progress | Validate CPU numerical kernels |
| 6 | In progress | Stabilize comparisons and set workload budgets |
| 7 | In progress | Complete the application acceptance suite |
