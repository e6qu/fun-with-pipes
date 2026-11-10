# Find the repeated compiler work before changing inference

**Initial attribution passes on both Linux architectures.** PR #274 still needs
its final delivery gates. The [first diagnostic receipt](compiler-checking-preparation-2026-11-10/README.md)
separates 1,590 library bindings from user work: library checking takes about
206–227 ms across these inputs, while dependency ordering takes 3–5 ms. These
are single observations, not a speedup or observer-overhead comparison.
PR #274's
[measurements](application-compiler-load-2026-11-10/README.md) show type checking
accounts for 57–69% of fwp time on the largest inputs, but do not separate library
checking, dependency analysis or solving constraints. The new boundaries locate
the fixed cost in library checking; its internal work still needs attribution.
No optimization is selected.

[Complete-program observations](compiler-applications-2026-11-10/README.md) also
pass: all four programs check the same library bindings at about 208–234 ms.
This is most of the word-count compiler process, but only part of the HTTP
server's 1.2–1.4 seconds. Attribute internal checking work and retain the other
compiler stages before choosing a change.

The [finer observation now passes](compiler-checking-parts-2026-11-10/README.md)
on both Linux architectures. Bodies account for roughly three quarters of
library-group time; validation is next. AMD64 used EPYC 9V45, so its smaller
absolute times cannot be compared as a speedup against the earlier EPYC 7763.
Each group is divided into five existing operations:

- **Bodies:** infer each expression's type and check that it agrees with the
  definition's declared signature. For example, `inc : I64 -> I64` requires
  `inc = add 1` to accept and return `I64`.
- **Deferred operations:** decide unresolved pipes and record-field operations
  after more types are known.
- **Constraints:** check required operations against signatures or inferred
  types; for example, determine which implementation supplies an addition.
- **Validation:** check sizes, integer literals, effects and resource captures.
- **Generalization:** finish inferred signatures for definitions without an
  annotation and check that `main` is a value that can execute.

Report group setup/cleanup separately. These spans observe existing code; they
do not change trait selection or omit checks. The application report must account
for every nanosecond of each group using its direct children and its remainder.
Their eight report contracts and four application comparisons pass on each host;
earlier results use only the coarser library/user boundaries. Next, profile
expression checking and validation in those same applications to identify the
costly operations before changing the algorithm. Do not use a trait index or
library cache merely because it looks plausible in the source.

## Next: CPU samples inside checking

The prepared `compiler-sampling` workflow compiles the same four original
applications on native Linux ARM64 and AMD64. It uses a release compiler with
full debug information so the profiler can reconstruct inlined function calls.
The compiler algorithm and optimization settings are unchanged. Each application
gets one ordinary build and one sampled build; their generated C must be identical.

- `perf record` samples user-space CPU activity at 997 Hz, including compiler
  threads and child processes. It observes only the command's process tree.
  A 32 KiB stack snapshot and 256 KiB event buffer are explicit settings.
  Each architecture explicitly requests its general-purpose registers for
  unwinding. The ARM64 software-clock event does not request the SVE vector-length
  register that perf 6.8 may select using a hardware-counter capability probe.
- Both builds use one allowed logical CPU, a 120-second deadline and GNU time
  for process CPU/RSS. The CPU is not reserved exclusively. No C compilation or
  application execution is included; the compiler phase reporter is disabled.
- Reports retain every symbol, including unknown addresses and callers outside
  type checking. A second view groups samples by `check_binding` or `check_effects`
  in their call stacks. Both views must retain the same sample and event totals.
- Keep raw recordings, the exact compiler binary, commands, emitted C, resource
  reports, CPU/toolchain identities and failures. Attempt all four applications.
  Unsupported profiling or unresolved checking stacks fail the probe.

For example, if most samples below `check_binding` are in type substitution,
inspect and count those substitutions next. That would justify investigating
repeated substitution; it would not establish that a trait index would help.
Sample percentages describe the observed user CPU activity, not elapsed time,
ARC overhead or an ordinary-build speedup. They do not distinguish individual
library definitions from user definitions. Kernel work and waiting are excluded.

The ephemeral runner gives only the profiler executable `CAP_PERFMON`; fwp runs
as the ordinary runner user. No system-wide recording or global kernel-policy
change is requested. The [recording](https://raw.githubusercontent.com/torvalds/linux/master/tools/perf/Documentation/perf-record.txt)
and [reporting](https://raw.githubusercontent.com/torvalds/linux/master/tools/perf/Documentation/perf-report.txt)
references define the sampling and call-stack fields. These runs are diagnostic
preparation; their results and profiler limitations must be reviewed before
selecting an optimization.

The first probe, source `f26b3723a0ac5049bfaa40180593be1618e8695c`
(`roadmap/compiler-cpu-samples-2026-11-10`, run `42750772791`), failed before
producing samples. AMD64's Ubuntu 26.04 packages moved perf into `linux-perf`;
the workflow now selects the OS/package explicitly. ARM64 completed all four
ordinary builds, but each software-clock recording reported unsupported sampling.
The revised probe explicitly selects general-purpose registers: perf's ARM64
[register selection](https://raw.githubusercontent.com/torvalds/linux/v6.8/tools/perf/arch/arm64/util/perf_regs.c)
can add SVE's vector-length register after testing a hardware event, whereas
the [kernel](https://raw.githubusercontent.com/torvalds/linux/v7.0/kernel/events/core.c)
rejects extended registers for software-clock events. This is the candidate
cause to verify on the repaired probe, not a compiler failure or a timing result.

The second attempt, `f8cf810f53fb5b0fd40ea74cb7000e8a851ed468`
(`roadmap/compiler-cpu-registers-2026-11-10`, run `42751630458`), verified package
selection but found a command-line error: perf's optional register argument
requires `--user-regs=LIST`; a separated list became the command to execute.
The correction first records six tiny capability probes before building fwp.
It preserves verbose event attributes for flat, DWARF and register-selected
software clocks and a hardware-cycle control. No probe substitutes automatically
for the configured event. The configured recording must work before compilation.

Perf warns about explicit register lists even when all general-purpose registers
are present. Retain that exact warning, require the complete architecture-specific
list, and require resolved body-checking caller stacks. Any other warning/error
still fails. SVE-specific frames are outside this diagnostic's unwind coverage;
do not treat its stacks as complete coverage of arbitrary native binaries.

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

A [trait](../reference.md#declarations) specifies operations a type supports.
For example, `Field[T]` requires `Ring[T]` and `Div[T]`, where `T` is the type.
Superclass validation checks that an implementation supplies those prerequisites.
Dependency ordering checks required definitions before their callers; mutually
dependent definitions form one group.

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

The next diagnostic command is `scripts/inspect-compiler-checking.py`, dispatched
with `suite=compiler-checking`. It compiles these complete maintained sources:

| Program | Source | Work represented |
|---|---|---|
| Word frequencies | `examples/wordfreq.fwp` | Read text, count words and sort results |
| Numerical tutorial | `docs/tutorials/20-autodiff-and-devices/main.fwp` | Derivatives, tensor calculations and Rosenbrock descent |
| Queued service | `tests/fixtures/weak_callback_service.fwp` | All eight delivery/cancellation/expiration/error cases in its original `main` |
| HTTP API | `examples/server/api.fwp` | The maintained server, including its original connection limit |

Each gets one ordinary and one observed release-compiler invocation with
`--target native --emit-c -O2`, a 120-second deadline and GNU time process-memory
accounting. Original source paths preserve imports; retained copies record exact
inputs. Emitted C must match byte-for-byte. Every invocation and failure is
retained, and all programs are attempted before reporting failure.

This first pass does not run GCC or execute programs. Existing application and
HTTP checks cover runtime behavior; this diagnostic attributes compilation work.
It has no warmup/copy-control schedule and establishes no speedup or observer
overhead. Its source is frozen before dispatch. The paired experiment below is
required for an eventual performance comparison, not for this initial attribution.

- Use native Linux ARM64 and AMD64, explicit GCC O2 targets and the release fwp
  build. Preserve the existing 120-second child deadline.
- Retain fresh-process emit-C time separately from GCC time and program execution.
  Record process peak RSS, input/IR/C sizes and all nested phase counts.
- Keep one warmup per treatment and eight balanced ordinary/identical-copy and
  observed/identical-copy rounds, two sessions per host. Retain the frozen 2%
  copy-control limit. Do not rerun unchanged noise to qualify it.
- Include all four complete applications. Check their independent results and
  compile/runtime effects; a service's compilation is distinct from sustained
  server latency. No runtime throughput claim follows from compiler timings.
- Report the extra observer cost against ordinary compilation. A heavily observed
  phase is diagnostic evidence; it does not establish an ordinary speedup.

Select an implementation only after these results identify material work.
Freeze its elapsed-time, working-memory and correctness acceptance before editing
that algorithm. Preserve trait selection/overlap errors, flexible and rigid type
constraints, macros, REPL behavior, evaluation/trap order and native results.
Keep the original milestone 1–3 timing outcomes unchanged.
