# Session handoff

All seven areas of [PLAN.md](../PLAN.md) remain open. Remove tracing and prefer
ownership, borrowing and moves; use ARC only where sharing needs it. JIT is excluded.
Continue substantial grouped PRs, with one active delivery and exact-head acceptance.

## Accepted baseline

[PR #198](https://github.com/e6qu/fun-with-pipes/pull/198) is squash-merged as
`27a3e009b83e28f06130a5d686a3196b9934e53f`. Nine production jobs (`39845348815`)
and docs (`39845348589`) passed source `30c6d65c10b3cc33cfeb72f523e4d47624508896`.
Inspection covered 480 native binaries and 816 execution observations. The merge
has the tested tree, one parent and the required one-line message with no trailers.
[History](roadmap-history.md#local-callback-captures-and-repeated-numerical-work-pr-198)
records the delivery. Redundant main production run `39871314012` was cancelled;
main documentation was preserved. The clean `/private/tmp/fwp-direct-entry-delivery`
worktree and `/private/tmp/fwp-198-{final-acceptance,merge,merge-runs}.json` preserve
its evidence. Do not rerun its completed helpers.

## Active PR and next action

[PR #199](https://github.com/e6qu/fun-with-pipes/pull/199) uses branch
`checked-native-default` in `/private/tmp/fwp-checked-native-default`, based on
#198's merge. Edit code there. The primary checkout is detached at #198 and holds
the live handoff. Published head: `8bf72ec96335bf6fb83018dff6f3ee59ee761af3`;
production run `39885288684`, docs `39885284210`. **This head fails CI.**
The publication receipt is `/private/tmp/fwp-default-ownership-publication.json`.

**Next:** publish the grouped repair and run `native-commands` on Linux AMD64
for that exact source. Its twelve targets now include every repaired case and
the new static-memory collection control. Keep the PR draft during this focused
check, then mark it ready. Require all nine production jobs and docs for that
same head, inspect its default O0/O1/O2 binaries on six native platforms, and
squash-merge. Supply a one-line subject of at most 80 characters
and an empty body; verify the resulting tree, sole parent and message. Continue
PLAN.md afterward. No permission question is pending.

The PR makes checked ARC the default for native commands, builds and generated
modules. Unproved ownership remains an error, with no automatic switch to tracing.
`--gc tracing` still exists; this does not finish GC removal or eliminate ARC.
Existing collector, disabled-freeing and poisoned-storage controls select tracing
explicitly. The intentionally expired derivative keeps its tracing runtime trap
and separate ARC compile rejection. Ordinary golden programs exercise the default.

Default command tests cover cache identity with explicit ARC, test rejection
before execution, and O0/O1/O2 binaries with saved C, output, status and symbols.
Repeated/unknown `build --gc` settings fail consistently. The Python disassembly
comparison requires `ownership="arc"` or `"tracing"`, records it, and tests both
at O0–O3. Docs explain the new default and link frozen sources for three removed,
obsolete allocation scripts.

## Production failures and working repair

Every production job and its full log has been audited. Four distinct tests
failed: three shared failures across macOS, Windows and Linux, plus the Linux
static-memory golden case for the intentionally invalid derivative. Benchmarks
and documentation passed. No further failure was found in the completed matrix.

- `ad_tape_scopes` and `serializer_leaf_ownership` still used the new default
  while requesting collector stress. Their builds now select tracing explicitly;
  stress settings and assertions are unchanged.
- `ffi::unsupported_types_are_reported` exposed an invalid C type reported as
  an ARC limitation. The compiler now gives the specific foreign-function error.
  The test checks default, ARC and tracing builds and absence of an executable.
- `static_memory::golden_programs_with_static_memory` now selects tracing for
  that same invalid derivative's runtime trap. The bounded-heap test keeps its
  default-ownership case and adds actual tracing of uncounted temporary data:
  collections must occur, and disabling them must exhaust the identical heap.
- Independent SDK, packaging and measurement checks now continue after test
  failures, preserving red job status and their own prerequisites. Previously
  a failed target hid later checks until another full run. Both Unix ownership
  inventory steps now preserve failure status through `tee`. A controlled failure
  returns exit 37 and keeps its log; removing the fix reproduces the hidden failure.
- Host-boundary docs distinguish explicit tracing's retention from default ARC's
  rejection. The plan calls for tested replacements for collector diagnostics
  before deleting tracing, while keeping invalid lifetimes rejected. Seven older
  measurement reports now link their completed deliveries instead of leaving
  obsolete next actions or acceptance-pending claims; original data is preserved.

Audit: `/private/tmp/fwp-199-final-acceptance.json`; refresh with
`/private/tmp/fwp-audit-199-final.py`. It preserves every completed job's log and
all unexpected diagnostics. `/private/tmp/fwp-publish-default-production-repair.py`
requires the complete ten-job audit, archives this failed receipt and publishes
one repair with the PR temporarily draft. Inspect its publication receipt before
rerunning anything. Earlier publication helpers already completed. Dispatch the
`native-commands` suite on the repair's immutable tag with `native_runner=ubuntu-latest`.
After the focused job passes and the PR is ready, `/private/tmp/fwp-discover-199-runs.py`
registers its production/docs runs before using the acceptance auditor again.

`/private/tmp/fwp-inspect-default-builds.py` checks artifact hashes, real image
architecture, disassembly, output and absence of tracing for O0/O1/O2.
`/private/tmp/fwp-merge-199.py` is prepared but not run; it requires exact-head
acceptance and all six binary reports, then verifies the squash result.

## Checks and resources

Use `python3 scripts/local-guard.py COMMAND...` for every local check. The latest
`python3 /private/tmp/fwp-check-native-default.py` passed formatting, workflow
lint, documentation links, 106 immutable anchors, seven plan steps and preservation
of test functions/collector settings in 6.10 seconds after the static-memory repair; the expanded focused workflow
and final prose still need the publication check. The publication helper also
checks staged documentation before committing. The inventory-failure control passed in
0.64 seconds via `python3 /private/tmp/fwp-check-inventory-failure.py` inside the
guard. No full build or suite ran locally.

Focused preparation `39883631101` at `93b6b8ed` compiled/linted all test targets;
six execution targets passed (26 tests). One of 179 library tests failed because
an HTTP/2 stress probe inherited ARC. Its mode selection, a shared HTTP/2 helper
and an invalid-option assertion were repaired in `8bf72ec9`; the failed receipt is
`/private/tmp/fwp-default-ownership-preparation-acceptance.json`. Do not count
that failed preparation as acceptance or repeat unchanged targets for a green badge.

Two SDK tests passed in 1.58 seconds through the guard using the accepted #197
compiler at `/private/tmp/fwp-check-compiler-0367e819/fwp`, Apple Clang and LLVM
objdump: invalid ownership rejection and eight actual ARM64 objects across both
modes and O0–O3. Command: `python3 -W error::ResourceWarning -m unittest`
`test_tools.Tools.test_disassembly_rejects_invalid_ownership_before_creating_output`
`test_tools.Tools.test_disassembly_compares_c_and_instruction_encodings_at_four_levels -v`,
with explicit `PYTHONPATH`, `FWP_TEST_BIN`, `FWP_OBJDUMP` and `CC`.
This validates the Python API, not the new compiler's final acceptance.

Keep checks serial and guarded: at least 64 GiB free disk, generated target data
below 2 GiB, sampled workload RSS below 1 GiB and the 180-second deadline.
Last observed free space: 66 GiB. Never raise limits; preserve worktrees and receipts.

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
