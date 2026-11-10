# Find the repeated compiler work before changing inference

**Initial attribution and PR #274 delivery pass on both Linux architectures.** The [first diagnostic receipt](compiler-checking-preparation-2026-11-10/README.md)
separates 1,590 library bindings from user work: library checking takes about
206–227 ms across these inputs, while dependency ordering takes 3–5 ms. These
are single observations, not a speedup or observer-overhead comparison.
PR #274's
[measurements](application-compiler-load-2026-11-10/README.md) show type checking
accounts for 57–69% of fwp time on the largest inputs, but do not separate library
checking, dependency analysis or solving constraints. The new boundaries locate
the fixed cost in library checking. The later body profiles and
[exact counters](compiler-type-copies-2026-11-10/README.md) select
[borrowed type traversals](compiler-type-walks.md) as the current candidate.
Ordinary compiler speed and memory acceptance remain unverified.

[Complete-program observations](compiler-applications-2026-11-10/README.md) also
pass: all four programs check the same library bindings at about 208–234 ms.
This is most of the word-count compiler process, but only part of the HTTP
server's 1.2–1.4 seconds. These observations separate that fixed checking cost
from the HTTP program's additional compilation work.

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
earlier results use only the coarser library/user boundaries. The CPU recordings
below locate calls within these bodies; counters then quantify type copies.
Neither establishes a benefit from an unmeasured trait index or library cache.

## CPU sampling protocol

The `compiler-sampling` workflow compiles the same four original
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

The [CPU-sampling receipt](compiler-cpu-samples-2026-11-10/README.md) retains
all attempts and repairs. `perf report --parent` omits DWARF-reconstructed parents;
direct `perf script` decoding fixes that limitation. AMD64 perf 7.0.14/libdw also
miscalculates the recorded binary's load base. Isolating threads did not fix it.
Fresh Ubuntu 24.04/perf 6.8 recordings and an explicit addr2line deadline now
pass on both architectures. All sample periods remain accounted for; unnamed
frames remain a limitation. Preserve failed attempts and unknown entries; never
interpret missing names as zero cost.

GNU `c++filt --format=rust` decodes names explicitly; raw names remain retained.
Perf's explicit-register warning is retained even with the complete requested
register set. Other warnings, losses, unresolved checking callers or inconsistent
totals fail the probe. SVE-specific frames are outside this diagnostic's coverage.

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

## Preserve the observation contract

The implemented reporter separates superclass checks, dependency ordering and
library/user/mixed groups. Nested exclusive times add up without double-counting;
group binding counts sum to the parent, including macro expansion. Success and
failure controls verify these invariants. Disabled reporting reads no clocks,
but its extra boundaries have unmeasured overhead; do not claim zero cost.

## Maintained inputs and measurement limits

`scripts/inspect-compiler-checking.py`, dispatched with `suite=compiler-checking`,
produces the phase observations above. It compiles these complete maintained sources:

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

These observations do not run GCC or execute programs. Existing application and
HTTP checks cover runtime behavior; this diagnostic attributes compilation work.
It has no warmup/copy-control schedule and establishes no speedup or observer
overhead. Its source is frozen before dispatch.

Reporter overhead remains unmeasured. Measuring it would require ordinary and
observed release compilers, identical-copy controls, balanced paired rounds and
two sessions per host; phase totals alone cannot answer that question. The current
[borrowing comparison](compiler-type-walks.md) instead times ordinary reference
and candidate compilers, with both reporters disabled. It retains whole emit-C
time and peak process RSS, separately from GCC and application execution.

Preserve trait selection/overlap errors, flexible and rigid type constraints,
macros, REPL behavior, evaluation/trap order and native results. Keep the original
milestone 1–3 timing outcomes unchanged.
