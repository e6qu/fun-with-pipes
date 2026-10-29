# Startup and CPU-cost preparation

Published PR #224 remains active at `b4e004d5788f2b2479b085a7dc6a48c435cce477`
in `/private/tmp/fwp-scalar-bounds`. Preserve that final head. Production
`40790143419` is running (only Linux AMD64 remains); Linux ARM64, all macOS jobs, both Windows jobs, benchmark and documentation `40790141513` pass
and are audited. Do not count draft-skipped runs as acceptance.

This worktree `/private/tmp/fwp-cpu-phases`, branch `cpu-execution-costs`, is based
on b4 and has no PR. Its branch can be published for focused runner validation
while #224 remains the only active PR. It prepares the next related runtime/cost batch while
#224's gates run. Focused startup checks and both qualified phase measurements passed and were audited.

**Next:** publish and measure the implemented decimal-length alternative selected by the
[phase results](measurements/cpu-phases.md): bit-length estimate plus one exact
power-of-ten comparison, with complete integer-boundary controls and unchanged
same-job CPU limits. Bundle it with the verified startup repair. Continue
monitoring #224; only merge after all nine production jobs plus docs pass. Move
this work onto that verified squash tree before opening the next grouped PR.

## Source findings and current repair

Startup review found ignored POSIX attribute/stack configuration results and a
silent switch to the process stack on thread-creation failure. Signal-stack and
handler installation could also fail without stopping startup. Static numerical
worker attributes had the same unchecked results. These are source error-handling
findings, not a diagnosis of the historical Intel compiler abort.

Prepared changes:
- Main-thread attribute initialization and stack configuration must succeed;
  created attributes are destroyed, thread-creation failure traps explicitly,
  and failed join/destroy operations abort instead of returning an unverified result.
- Stack-overflow handler registration must succeed, matching the Windows rule.
- Static worker setup stops on attribute failure, destroys valid attributes and
  joins previously started workers before the existing numerical-worker trap.
- `stack` adds dynamic/static O0/O2 fault controls for attribute setup, stack
  configuration, thread creation, alternate signal stack, mask and both handlers.
  Before-thread failures verify attribute cleanup and no language output.
- `cpu_kernel_ownership` adds static partial-worker startup controls at O0/O2,
  checking joins, attributes and temporary storage. An omitted stack-error check
  must fail the control without using an invalid pthread object. Test output is
  static storage so worker writes survive setjmp recovery correctly.

Guarded Rustfmt passes using the repository's **edition 2021** and
`skip_children=true`. An initial edition-2024 invocation caused unrelated formatting;
all of that churn was restored before applying the correct settings. Final guarded Actionlint and the 172-link-set documentation audit also pass.
Startup checkpoint `3db10b5a9f1e22d1bc1d93c6faea055f484f90ad` passed focused
run `40792244152` on native Linux/macOS ARM64/AMD64. All four logs are audited:
each has two passing targets and 11 tests, with no compiler diagnostics. Each
artifact has seven native images, 32 main startup outcomes and three partial-worker
or deliberately omitted-check outcomes, independently verified without local
execution. This is focused evidence, not the final production matrix.

Diagnostic source `c92fed4208a16627f0f420f58ce1f7729bf0f061` completed ARM64
job `123191020317` in `40795538429` and AMD64 job `123191404460` in `40795656380`.
The first run rejected AMD64 EPYC 9V45 before timing; its host record is retained.
All job logs and artifacts pass independent audits. Every raw sample, original
peer/memory report and artifact identity is saved in `docs/measurements/cpu-phases-*.json`.
The permanent verifier reconstructs both results; six reader/instrumentation
control groups pass. Actionlint and 173 documentation link sets passed before
publication. Both small Rust diagnostic peers compiled locally without execution.

Calculation dominates the diagnostic intervals, but fwp loop instrumentation
changes elapsed time by +19.84% ARM64/+12.24% AMD64. AMD64 loop's identical-code
p95 control exceeds the frozen limit; retain it as inconclusive. Both text controls
pass, AMD64 narrowly. No speedup is accepted from this experiment. The report
states exact inputs, intervals, code/stack/storage costs and all limitations.

## Current preparation

The decimal-count candidate is implemented in `runtime/fwp_rt_ops.c`, with a
160-byte readonly table. `integer_output` adds every binary-width boundary and
O0/O1/O2/O3 emitted-helper checks against snprintf, including an omitted threshold
correction that must fail. All 64 interval proofs and eight small Clang helper/
control cases pass locally; this does not verify GCC or actual fwp emission.
Five Python proof/measurement/input-inventory control groups and guarded Rustfmt/Actionlint pass.
The [candidate protocol](measurements/decimal-count.md) and `decimal-count`
workflow group native correctness, seven-peer context, memory checks and the
fixed-budget comparison. Initial source `f910ffb866e5800d9f6fb46cc71741f9f730ba8e`, run `40799193551`,
passed both GCC jobs' seven integer-output groups, benchmark and all peer/memory
controls. Both readers then rejected the same incorrect `text` benchmark name;
actual name is `strings`. No paired timing ran. All logs and sixteen semantic
images per host were audited, with the partial attempts retained. The reader and
all related docs now use the actual name; a new inventory/body control prevents
recurrence. Re-run the focused comparison after publishing this repair. Preserve the current helper
as the same-job control and the frozen CPU table. Do not resurrect the
rejected range/character-sum changes or loosen limits. Verify any new candidate
at production optimization settings, then run the complete final matrix once the
grouped implementation and evidence are ready.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain collector-free ownership and cycle checks |
| 2 | Verified | Maintain named A1–A6 guarantees |
| 3 | Verified | Maintain scoped F1–F3 call and recursion guarantees |
| 4 | In progress | Separate execution costs and repair startup failure handling |
| 5 | Pending | Derivative storage, timing and precision |
| 6 | Pending | CPU numerical kernels |
| 7 | In progress | Extend fixed baselines and integrity controls beyond CPU cases |
| 8 | Pending | Larger-program correctness, cleanup and scale |

## Recovery

#224's retained scalar experiment rejects both candidates; its compiler/runtime/
library/benchmark sources equal #223's verified tree. Read its own handoff and
[report](measurements/proved-scalar-bounds.md) for all exact source and job IDs.
Current final logs are `/private/tmp/fwp-224-final-{bench,docs}.log`;
`/private/tmp/fwp-audit-production-log.py` checks production summaries/diagnostics.

The primary checkout is detached at #209 with a recovery pointer and untracked
compiler-abort evidence; preserve both, along with earlier measurement artifacts.
Keep one published PR active. No local full builds/suites/benchmarks; use the guard
for serial focused checks with 64 GiB free disk, 2 GiB target, 1 GiB RSS and 180s.
Publication and compliant squash merge remain authorized after final gates pass.
