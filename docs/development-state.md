# Session handoff

## Next action

Next: audit all nine production jobs plus documentation for
[PR #187](https://github.com/e6qu/fun-with-pipes/pull/187) on
`measure-native-task-contexts`. If still a draft, publish this final handoff and
mark it ready to start production CI once. Fix every failure, then squash merge.
Use a one-line subject under 80 characters and an empty body; verify message,
parent and tree. Standing authorization covers publication, repairs and merging.

PR #186 passed all ten gates and was squash-merged as
`d516a0919a3f24a7c28817a32782908df77dd95d`, with the same tree as tested head
`fa2d5098573220833bda06e30af9f534181edc0d`. Receipt
`/private/tmp/fwp-186-final-acceptance.json` verifies its message, parent and tree;
[history](roadmap-history.md#queued-service-responses-and-bounded-server-startup-pr-186)
records the accepted change. Do not repeat that merge. Both post-merge run
queries returned none; no duplicate run needed cancellation.

The branch is now in `/Users/zardoz/projects/fun-with-pipes`. The clean temporary
worktree was removed after rebasing onto the verified PR #186 merge; its source
tree did not change. Runtime, compiler, tests, scripts and workflows still match
the focused source below. Only documentation/evidence changed afterward.
`/private/tmp/fwp-task-context-publication.json` records the rebase, workspace,
PR and final publication head. Always check the PR's current head before accepting
CI; passing runs from the focused source or the initial draft are insufficient.

## Task storage and evidence

glibc Linux child tasks save CPU state in an aligned region of their existing
stack allocation. The root task uses static storage. This shrinks heap task
records without replacing glibc's switching, signal-mask or floating-point
behavior. Call frames have less usable stack space; saved state still occupies
memory. Completed task pointers and root state clear before their storage can
be reused. Programs that never use tasks do not initialize or clear root state.

Both jobs in focused run `39606188022` passed at
`dec32109b52b8783c7234cd5c72e242583742a4c`. Remote tag
`roadmap/revision-task-contexts-dec32109b52b` preserves that source. Both complete
logs were audited: no failed steps, test failures or panic diagnostics.
All 80 actual ELF binaries, generated C, symbols and disassembly were inspected.
The [guide](measurements/task-contexts.md) introduces the program and storage
terms; the [report](measurements/task-contexts-2026-10-21.json) retains 144 matched
process samples, actual binary/static sizes and the separate service comparison.

Checks cover register-only roots through collection, rounding/signal restoration,
stack bounds/alignment, task-free execution, cancellation, library unload,
static budgets and complete request cleanup. Twelve context controls deliberately
break root scanning, teardown or task-free cleanup; library and service tests
also retain their own broken-cleanup controls. `strace` was installed, so the
static-memory mapping check executed. Timed binaries exclude candidate-only
correctness assertions. The earlier biased timing run is excluded in the report.

For 32 tasks, peak managed charge falls from 54,592 to 25,024 bytes on AMD64 and
206,656 to 29,248 on ARM64. Allocation requests/retains remain 227/159. Median
process-memory changes are smaller; timings are mixed, with overlapping ranges.
Some code/file sizes grow. No general speed, zero-ARC or GC-removal claim.
The 72-call service retains 481 count operations and ends with only its identified
544-byte live listener storage. It does not prove orderly listener shutdown.

Full production acceptance remains required: Linux/macOS/Windows on both
architectures, both Mac GC-stress jobs, C/Rust benchmarks and documentation.
The new context test target executes on glibc Linux; its zero tests on other
platforms do not establish native support. Existing platform gates remain intact.

## Local checks and continuation files

All checks used `python3 scripts/local-guard.py COMMAND...`, serially. Rustfmt
passed for both changed Rust tests; Python syntax passed for the measurement
script and artifact/report helpers. The documentation audit passed 78 link sets,
106 immutable preparation pairs/tags and seven roadmap areas after staging the
final report links. No native compilation or
benchmark execution ran locally. Preserve the fixed 64 GiB disk, 2 GiB target,
1 GiB workload RSS and 180-second limits.

Under `/private/tmp`: `fwp-task-context-final-audit.json`,
`fwp-task-context-final-probe.json`, `fwp-task-context-source-tag.json` and
`fwp-task-context-final-evidence/HOST/inspection.json` preserve the current audit.
The source tag contains the earlier preparation revisions; superseded runs are
not a backlog. `fwp-inspect-task-context-final.py` and
`fwp-report-task-context-matched.py` already completed; do not overwrite their
accepted reports. Documentation now links accepted ownership work to its actual
delivery evidence instead of obsolete handoff instructions.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing; prove retained ownership and cleanup. |
| 2 | In progress | Eliminate avoidable functional allocations and count traffic. |
| 3 | In progress | Resolve measured machine-code and performance gaps. |
| 4 | In progress | Improve differentiation time, memory and precision. |
| 5 | In progress | Validate numerical kernels and ahead-of-time GPU policy. |
| 6 | In progress | Establish equivalent-work comparisons and budgets. |
| 7 | In progress | Validate larger programs and bounded live memory. |
