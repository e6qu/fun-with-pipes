# Session handoff

## Next action

Next: publish and run the `task-contexts` focused probe on native Linux ARM64
and AMD64. Fix all failures before choosing this representation. This is isolated
preparation on `measure-native-task-contexts` in `/private/tmp/fwp-task-contexts`,
based on PR #186 head `fa2d5098573220833bda06e30af9f534181edc0d`.
Do not open another PR while #186 remains active.

PR #186's exact-head production run is `39597478599`, docs `39597478465`.
The main workspace holds that branch and its current handoff. Use
`/private/tmp/fwp-audit-186-final.py` and `fwp-merge-186.py`; merge only after
all nine production gates plus documentation pass. Standing authorization covers
publication and squash merge with a one-line subject under 80 characters and
an empty body. PR #185 is already accepted and merged; its history is recorded.

## Candidate and measurement boundary

The accepted service samples use a 5,296-byte task record on Linux ARM64 and
1,584 bytes on Linux AMD64. glibc's saved CPU context occupies much of that record.
The prototype puts child contexts at an aligned address in the existing task
stack, above all usable call frames. The task record holds a pointer. It keeps
glibc's context switching, signal-mask and floating-point behavior.

The root uses its host's stack, so its context lives in runtime static storage.
The collector scans that storage with program data. Initialization and both
executable/library teardown clear the image; completed child records clear their
context pointers before their stacks can be reused. A static stack budget too
small for a context fails before allocating/publishing a task.

This shifts storage; it does not eliminate the saved CPU state. Report task-record
bytes, context bytes on each stack and root static bytes separately, along with
managed allocations and final cleanup. No whole-process memory or speed claim.
The existing stack reservation and pool remain outside managed-allocation counts.

## Prepared checks

`tests/task_context_storage.rs` reconstructs the preceding heap layout in otherwise
identical generated C as an experimental control. Production code has no layout
switch or compatibility branch. Both versions must match the interpreter's 528
result for 32 tasks, under ARC/tracing at O0/O2, with zero final managed charge.
The test records generated C, ELF architecture, actual disassembly, symbols,
section sizes, counters and layouts. It checks stack bounds/alignment, clears
retained completed-task pointers and checks root-state teardown. An omitted root
clear must exit 193. ARC binaries must exclude collector routines and retain the
existing libc context implementation.

A separate C probe excludes ordinary stack copies while checking values held
in root/child saved register images. O0/O2 collection must preserve those values;
deliberately hiding a root or child image must exit 191/192. It also checks
floating-point rounding and signal-mask restoration. These checks are prepared,
not yet verified. Failures in probe isolation are not evidence of runtime support.

The focused workflow includes task/scope/cancellation regressions and all four
queued service-response cleanup cases. Its two Linux jobs are independent. Full
production acceptance across all nine jobs, including static-memory and library-unload
coverage, is still required before any later merge. The new test target is in the
explicit macOS shard inventory, but its libc-only tests execute on Linux.

## Local work

Keep checks serial through `python3 scripts/local-guard.py COMMAND...`, preserving
64 GiB free disk, target below 2 GiB, sampled RSS below 1 GiB and the 180-second
limit. No local builds, native C compilation or full test gates. Rustfmt passed.
The accepted PR #184 macOS compiler interpreted the small source fixture as 528
and emitted C to inspect teardown order; that does not test the changed runtime.
All candidate native execution belongs on GitHub runners.

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
