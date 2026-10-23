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
the live handoff. Published head: `51b34e6bcf1a69646766839a21d9d31468c569ed`.
The PR is draft. Focused run `39894751457` confirms all four original production
failures are fixed and all 179 library tests pass. Its new real-collection control
exposes a static-heap exhaustion bug; the current working repair also fixes the
related reuse of slots inside partly live pages. Neither repair is published yet.
The publication receipt is `/private/tmp/fwp-default-ownership-publication.json`.

**Next:** publish the static-heap repairs together and dispatch `native-commands`
on Linux AMD64 for their immutable tag. Its thirteen targets now include
`native_allocator`, with controls that deliberately remove each repair. Keep the
PR draft until the entire focused job passes, then mark it ready. Require nine
production jobs and docs for the same head, inspect default O0/O1/O2 binaries on
six native platforms, and squash-merge. Use a one-line subject of at most 80
characters and an empty body; verify tree, sole parent and message. Continue
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

## Failures, repairs and evidence

The full first matrix at `8bf72ec9` was audited across all ten jobs. Benchmarks
and docs passed; eight platform jobs shared four failures. Head `51b34e6b` fixes
all four, confirmed by the completed focused run:

- Two collector probes now explicitly request tracing while preserving stress.
- Unsupported C types receive the same specific diagnostic in default, ARC and
  tracing modes, without producing an executable.
- The static-memory golden suite preserves the invalid derivative's runtime trap
  under explicit tracing; its separate ARC compile rejection remains tested.
- Independent SDK, packaging and measurement checks continue after test failures.
  Inventory failures propagate through log capture; an injected exit 37 confirms
  this, and removing the fix reproduces the previously hidden failure.

The added collection control still fails at `51b34e6b`: 60 iterations of the
existing churn fixture exhaust a 1 MiB heap despite reclaimable storage. The
working allocator repair forces a full collection under static-heap pressure and
rechecks small-object free slots afterward. A partly live page can supply such
slots without becoming a completely free page. Neither fix raises the heap limit.

`native_allocator` now generates a real static-memory program and probes both
cases at O0/O1/O2. It checks zeroed storage and surviving roots, then deliberately
removes each fix and disables collection to verify that those controls fail.
Nine binaries produce 54 observations per host. The existing 1 MiB language-level
churn test remains, with exact output and a collection-disabled exhaustion check.

The complete first production audit is archived at
`/private/tmp/fwp-199-production-acceptance-8bf72ec9.json`. The failed focused
audit is `/private/tmp/fwp-default-repair-focused-acceptance.json`; its full log
ends with all 179 library tests passing, successful inventory/negative controls,
and only the new collection test failing. Previous publication and dispatch
helpers have completed; do not rerun them. The old ready helper requires `51b34e6b`
and is obsolete. Prepare new publication/dispatch/audit helpers for the repair.

After the next focused job passes and the PR is ready,
`/private/tmp/fwp-discover-199-runs.py` registers production/docs runs.
`/private/tmp/fwp-audit-199-final.py` then audits all exact-head gates.
`/private/tmp/fwp-inspect-default-builds.py` checks artifact hashes, image
architecture, disassembly, output and absence of tracing for O0/O1/O2.
`/private/tmp/fwp-merge-199.py` requires that acceptance and six binary reports,
then verifies the squash result. None of these final acceptance steps has run
for the current repair.

## Checks and resources

Use `python3 scripts/local-guard.py COMMAND...` for every local check. The
formatter, workflow/docs audits and preservation of existing test controls passed
at `51b34e6b`; rerun them for the current edits before publication.

The guarded `/private/tmp/fwp-check-static-pressure.py` passed 27 native
observations for the churn and partly-live-slot cases. The guarded
`/private/tmp/fwp-check-static-pressure-fixture.py` passed all 54 observations
using the actual new fixture at O0/O1/O2. These use Apple Clang on ARM64, C emitted
by the accepted #197 compiler, and the exact working allocator substituted into
that C. They verify the allocator repair locally, not the new compiler or other
platforms. Receipts in `/private/tmp/fwp-static-pressure{,-fixture}-verified/`
retain source/binary hashes, commands and outcomes. No full build ran locally.

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
