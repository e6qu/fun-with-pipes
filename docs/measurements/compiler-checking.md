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
