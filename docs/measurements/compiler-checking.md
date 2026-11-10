# Find the repeated compiler work before changing inference

**Preparation only.** PR #274 still needs its final delivery gates. Its
[measurements](application-compiler-load-2026-11-10/README.md) show type checking
accounts for 57–69% of fwp time on the largest inputs, but do not separate library
checking, dependency analysis or solving constraints. No optimization is selected.

## Questions and boundaries

| Question | Evidence to collect |
|---|---|
| How much is repeated library work? | Separate type-checking groups belonging to the reserved `std` module from user/import groups; explicitly identify any mixed group. |
| How much is ordering and trait validation? | Separate dependency ordering and superclass checks from checking each group. |
| Which checks consume the remaining time? | Profile the dominant part, then count actual work there in a separate diagnostic execution; source inspection alone is not attribution. |
| Does the same cost affect real programs? | Word counting, Rosenbrock minimization and the API endpoint, alongside the existing three growing input families. |

A group contains definitions that depend on one another and must be checked
together. Group classification describes where definitions came from. It does
not prove that library checking is independent of user trait implementations,
macros, inferred effects or the rest of the environment.

## First observation change

Extend the existing opt-in report with nested spans for superclass validation,
dependency ordering and library/user/mixed groups. Count each group's bindings.
Keep the complete `type-check` parent span and its total binding count. Nested
exclusive times must add up without double-counting; group binding counts must
sum to the parent count, including checks performed while expanding macros.

Preserve generated C, output, diagnostics/source locations and compile-time
execution. Check success and failure reports. Disabled reporting still performs
no clock reads; do not claim zero overhead without measuring the ordinary build.
Do not add a cache, skip library validation or depend on an older fwp build.

## Measurements after the observation controls pass

- Use native Linux ARM64 and AMD64, explicit GCC O2 targets and the release fwp
  build. Preserve the existing 120-second child deadline.
- Retain fresh-process emit-C time separately from GCC time and program execution.
  Record process peak RSS, input/IR/C sizes and all nested phase counts.
- Keep one warmup per treatment and eight balanced ordinary/identical-copy and
  observed/identical-copy rounds, two sessions per host. Retain the frozen 2%
  copy-control limit. Do not rerun unchanged noise to qualify it.
- Include the three complete applications. Check their independent results and
  compile/runtime effects; a service's compilation is distinct from sustained
  server latency. No runtime throughput claim follows from compiler timings.
- Report the extra observer cost against ordinary compilation. A heavily observed
  phase is diagnostic evidence; it does not establish an ordinary speedup.

Select an implementation only after these results identify material work.
Freeze its elapsed-time, working-memory and correctness acceptance before editing
that algorithm. Preserve trait selection/overlap errors, flexible and rigid type
constraints, macros, REPL behavior, evaluation/trap order and native results.
Keep the original milestone 1–3 timing outcomes unchanged.
