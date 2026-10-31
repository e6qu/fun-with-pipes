# Current work

**Next:** dispatch `state-range-checks` for GCC Linux ARM64/AMD64 and Clang
macOS ARM64, audit all results, and fix any compiler or test failure as a batch.
The [predeclared contract](measurements/state-range-folds.md) also needs the
code/stack comparison, existing G2 budgets and complete final-head production
validation before delivery. Compiler changes are drafted but have not been built.
Publishing this preparation branch does not open a second PR. Open the next
delivery PR only after #232 passes and merges.

Preparation worktree `/private/tmp/fwp-state-range-folds`, branch
`state-range-folds`, based on `05d96484`. Its sparse checkout excludes large
immutable evidence archives to preserve the local disk floor. The active
delivery worktree has the full documentation.

## Active delivery

[PR #232](https://github.com/e6qu/fun-with-pipes/pull/232) remains the only open
PR. Its worktree is `/private/tmp/fwp-ownership-peer-baselines`; preserve head
`05d96484a77241c9782a420e76ea69094b965e11` while final gates run. Production run
`41153845461`, docs run `41153845377`: documentation, benchmarks and both ARM macOS jobs pass and their complete
logs are audited; six platform jobs remain running. The active
worktree's handoff owns every job ID, prior failure audit and recovery details.
Squash-merge only after all nine production jobs and docs pass, with one subject
of at most 80 characters and an explicitly empty body. Verify the merged tree.

## Source investigation

The retained macOS compiler at `d92939b8` has the same compiler/runtime as the
preparation base. Guarded IR/C emission for `each-count` passes (0.25s), retained
as `/private/tmp/fwp-state-range-before.{c,ir,stdout}`. Its known callback consumes
the input through a fold after a trivial unit binding; the range remains outside
the State handler. The unchanged interpreter passes the new semantic/cancellation fixture. A Clang
O2 preflight of its before-teardown observer passes; omitting State scratch release
exits 239 as required (1.94s total). Compiler/Rust-test formatting passes. These
checks do not validate the drafted compiler. No full local build or suite ran.
Five rejected-shape fixtures type-check with the unchanged compiler; both new
arithmetic-trap fixtures match their expected output and exit 101 (1.08s).
Workflow lint passes after using the matrix runner for the job-level compiler
selection; the runner context is unavailable there. A compiler unit regression
now covers functions created after an analysis snapshot: treat them as unproved
instead of indexing beyond the snapshot. Full compiler execution remains pending.
The protocol defines the
eligible shapes and limits before any compiler change.

Preserve the dirty detached primary checkout and original CI archives. Full
builds, broad tests and measurements belong on GitHub. No local guard limit may
be raised or bypassed. Timing acceptance for prior changes remains open.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Preserve GC-free lifetime and cycle guarantees |
| 2 | Verified | Preserve scoped A1–A6; broader ARC costs remain in B1 |
| 3 | Verified | Preserve the stated F1–F3 call/recursion scope |
| 4 | Verified | Preserve decimal savings and the unoptimized loop gap |
| 5 | In progress | Resolve D2's remaining timing requirement |
| 6 | In progress | Resolve N1's control before N2 timing acceptance |
| 7 | In progress | Deliver generated-array elimination; finish B1/B2 |
| 8 | In progress | Finish numerical and integrated V1/V2 acceptance |
