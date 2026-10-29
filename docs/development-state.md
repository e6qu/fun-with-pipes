# Startup and CPU-cost preparation

Published PR #224 remains active at `b4e004d5788f2b2479b085a7dc6a48c435cce477`
in `/private/tmp/fwp-scalar-bounds`. Preserve that final head. Production
`40790143419` is running; its benchmark job and documentation `40790141513` pass
and are audited. Do not count draft-skipped runs as acceptance.

This worktree `/private/tmp/fwp-cpu-phases`, branch `cpu-execution-costs`, is based
on b4 and has no PR. Its branch can be published for focused runner validation
while #224 remains the only active PR. It prepares the next related runtime/cost batch while
#224's gates run. No build, native test or timing has run for this preparation.

**Next:** run and audit the grouped `runtime-startup` checks on native GCC/Clang
runners, repair failures, then implement the planned cost-separation experiment. Continue monitoring #224
and merge it only after all nine final-head production jobs plus docs pass.
Carry this work onto that verified squash merge before opening the next PR.

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
No compiler build or test execution yet. The phase profiler is not implemented.

## Planned measurement

Use unchanged loop/text inputs and checked C/Rust peers. Measure setup, calculation,
output and cleanup separately in explicitly instrumented diagnostic programs;
retain unchanged whole-process timings as a different observation. Check the
instrumentation's output and phase ordering, retain raw samples and code/stack
costs, and do not claim a speedup from an instrumented-versus-ordinary comparison.
Use the largest demonstrated extra cost to select the next optimization. Do not
resurrect the rejected range/character-sum changes or loosen their fixed limits.

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
