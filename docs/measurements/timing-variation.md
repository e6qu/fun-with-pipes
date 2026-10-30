# Investigating numerical timing variation

The repaired compiler passes its focused correctness checks. Two measurements
still fail their frozen acceptance rules; neither is permission to drop samples,
increase a limit or repeat the same experiment until it passes.

- Derivative recheck `40912773534`, job `123584890626`, source `694e31b7`:
  the zero-update history case takes 1.022815765 times its reference's time,
  exceeding 1.02. The current-result identical-code control passes. It does not
  control the history program's variation. All emitted candidate/reference C
  files equal their earlier measured versions; this repair did not change them.
  [All four recheck sessions](eager-captures-recheck-artifacts-2026-10-29.json)
  retain the failed overall decision and the three passing sessions.
- Kernel recheck `40916288542`, job `123597280887`, source `bf46f776`:
  byte-identical small-matrix programs differ by 3.27% in computation time and
  3.49% including allocation, above 2%. Individual fwp processes vary roughly
  from 5.4 to 10.4 ms, while C/Rust peers are much steadier. The larger matrix and
  arrays pass their noise controls. [The recheck archive](kernel-recheck-artifacts-2026-10-29.json)
  retains every sample and both failures. This is incomplete N1 evidence.

These facts do not establish the cause. Possible effects of process scheduling
and memory placement need direct observations; instruction listings alone cannot
identify them. Inspect the source and validate all outputs throughout diagnosis.

## Diagnostic experiment, declared before implementation

Use a qualified four-processor Linux EPYC 7763 host with GCC 15.2.0, matching
the failed sessions. Reuse their retained executables and verify each byte hash
against its report. This is a diagnostic of those exact programs; ordinary fwp
builds must still require no previous compiler installation.

Compare two explicit execution policies: the runner's recorded allowed CPU set,
and affinity restricted to CPU 0. Check that CPU 0 is allowed; fail if affinity
cannot be set. Alternate policies each round so a long-running host change does
not affect only one policy. Keep address randomization enabled.

For the small matrix use C, Rust, fwp and its byte-identical copy. For zero-update
history use the candidate, reference and a byte-identical copy of each. Run 16
rounds per policy, four processes per label per round, with the existing balanced
four-label schedule and seed 20261029. Keep five internal kernel samples and the
original eight calculations per sample; keep all 32,768 derivative solves per
process. Check every output/hash and live-storage result. Preserve every process
duration and order, including outliers. Do not treat these diagnostic timings as
new accepted baselines or change any frozen limit.

Separately instrument the small-matrix C harness to record the executing CPU
before/after each call and input/output data offsets modulo 64 KiB. Save input
addresses before transferring their owners; never inspect freed input objects.
Print diagnostics outside the inner kernel timer. Run 32 processes per policy and retain
the instrumented source, build command, binary and all observations. Such logging
may perturb performance, so do not substitute its timings for ordinary results.

This experiment should distinguish CPU migration from variation that persists
within a fixed CPU. Offset correlations may guide a source-level allocator or
layout investigation, but they are not proof by themselves. Choose a measurement
repair only from the resulting evidence, document its limitations and publish it
before rerunning the acceptance experiment. N1 and the selected D2 budget remain
open until their unchanged acceptance requirements are met.

## Running the diagnostic

The `timing-diagnostics` selection in `.github/workflows/numerics.yml` requires
`evidence_run=40916288542` and `baseline_run=40912773534`. It qualifies the host
before downloading or running the failed programs; a rejection remains an
artifact. `scripts/diagnose-timing-variation.py` checks executable identities,
retains every stdout/stderr stream and duration, and restores the original CPU
affinity even after failure. `scripts/test-timing-diagnostic.py` checks observation
placement, changed instrumentation boundaries and rejected corrupt outputs.
Run `40949475361`, job `123713471516`, completed on EPYC 7763 at `535031b3`.
The [archive](timing-diagnostic-artifacts-2026-10-29.json) retains all 1,089 process
records, 1,088 observations, complete logs, instrumented source and artifact
identities. Independent audit checked every raw stream/hash, schedule, output,
live-storage result and CPU/layout observation. The prior run `40949274713`
rejected EPYC 9V45 before downloading or executing; its qualification/log remain.

## What the diagnostic establishes

Fixed-CPU execution does not repair the matrix control. The fwp/identical ratio
is 1.0389 with normal scheduling and 0.9633 when pinned (reciprocal 1.0381).
Every one of 2,560 recorded matrix calls has input/output offsets `(8, 8, 8)`
modulo 64 KiB. Only two unbound calls change CPU; none pinned do. Pinned fwp
processes still range from 5.38 to 10.25 ms for their five calculation samples.
These observations reject CPU affinity and these low address bits as sufficient
explanations. They do not identify a runtime defect or prove other placement or
host-load effects absent. The matrix source preserves shape bounds, live inputs,
a fresh output and alias-safe byte copies; no unsafe access was identified.

Zero-update history remains near the limit: candidate/reference 1.0204 unbound
and 1.0200 pinned. The candidate/copy differs by about 2.95% in the smaller pinned
sample, so this diagnostic cannot accept or reject the production timing rule.
Retained profiles have equal allocations/retains, and the inspected zero-update
entry and loop body have the same C operations (the string cleanup identifier
changes, its implementation does not). No added source-level work has been found;
this is not proof of equal machine cost. The original 1.0228 failure stays open.

## Small-matrix sampling repair, declared before implementation

The original comparison has only 64 fresh processes per label. In the diagnostic,
the standard deviation divided by the mean is 24.2% unbound and 25.4% pinned for
fwp and its copy, pooled within each policy. The five samples within a process
share its placement and execution conditions; they are not five independent
placements. The present sample size cannot reliably resolve the 2% control.

For **both architectures**, increase the small matrix from four to **256 fresh
processes per label per round**. Keep 16 measured rounds and two warmup rounds:
4,096 measured processes per label. Repeat the existing 16-entry balanced cycle
64 times within each round; keep the same seed and rotations. This retains
position and within-round predecessor balance. Keep ordinary scheduling, five
samples per process, eight calculations per sample, both timing boundaries,
the median of complete round totals, all observations and the **1.02** limit.
Keep the other three cases at four processes per label per round.

As a planning estimate only, independent sample means at the observed variation
would have about 1.4% two-sided 99% difference uncertainty at 4,096 processes,
versus about 11% at 64. The actual statistic uses round medians and host conditions
may be correlated; this estimate does not replace the unchanged control or
promise a pass. Run two independent qualified sessions per architecture after
implementing this declared count. A further failure stays inconclusive: do not
increase counts again after seeing those outcomes or discard old results.
This repair changes measurement precision, not the programs or D2's limits.

## Expanded result and next source investigation

The declared four-session run `40951090783` at `37da7441` is fully audited.
Small-matrix controls pass in all four sessions. AMD session 2 instead fails
the 65,537-element array's allocation-inclusive control at 1.030786192. Its
computation-only control is 1.002754; all other cases pass. The complete
[expanded archive](kernel-expanded-artifacts-2026-10-29.json.gz) remains
not accepted. Neither another unchanged run nor a further count increase is
authorized by this experiment.

The computation-only AMD array gap is consistent at about 3.3 times C, with
passing controls in both sizes and sessions. Source inspection shows an F64
accumulator carried through a generic 64-bit loop-state array. That observation
is a hypothesis about extra register transfers, not a demonstrated cause.

Before selecting an optimization, compile the retained C and fwp timing sources
for all four cases on native ARM64/AMD64 with the matching GCC version and
explicit original architecture/O2 settings. Add only GCC's vectorization report and optimized-tree dump options.
Require the rebuilt executable's hash to match its recorded ordinary binary
and verify every output hash/live-storage result. Preserve the source, commands,
compiler reports, binaries and outputs. This is compiler inspection, not another
timing acceptance run; do not select or discard elapsed-time observations.
It can explain generated code choices while the separate allocation-inclusive
noise failure and D2's zero-update requirement remain unresolved.

Run this inspection with `suite=kernel-codegen`, `native_runner=all`,
`comparison_session=2`, and `evidence_run=40951090783` in `numerics.yml`.
`scripts/report-kernel-codegen.py` retains partial output after a failure and
never labels its printed kernel durations as new acceptance measurements.

This inspection does not require the benchmark CPU model: it measures no time
and accepts a compiler report only if its executable matches the original byte
for byte. Record the actual host and require the original GCC version, native
architecture and explicit target flags. The initial AMD inspection rejected Xeon
8573C before building; retain that rejection. Timing baselines still require
their originally declared CPUs.

## Compiler reports and typed-state experiment

The [retained reports](kernel-codegen-artifacts-2026-10-29.json) cover all eight
C/fwp programs on both architectures. ARM job `123732636881` and AMD job
`123734517885` reproduce every original executable hash and output. Their full
logs are audited. The initial AMD host rejection is retained separately.

Both compilers keep the fwp array accumulator as an integer between iterations:
GCC's optimized intermediate representation reads its bits as a `double`, adds
the next value, then stores the result as integer bits. The C peer keeps a
`double` accumulator throughout. Neither array loop vectorizes under the declared
settings. Therefore missing vectorization is not an explanation of this gap.
The reports establish a representation difference, not its measured cost.

Next, test a compiler representation change: store statically known F32/F64 loop
fields as C `float`/`double` members, with ordinary value words for other fields.
Use the existing bit-preserving conversions at generic boundaries. Keep the same
field evaluation order, current/next state separation, owner transfers and
cancellation cleanup. Do not reassociate operations or add fused arithmetic.
Check scalar, flat and nested states, signed zero, subnormals, infinities and NaN
payloads; retain the existing alias, preparation-failure and cancellation probes.
Require raw/optimized interpreter agreement where the language exposes bits,
and native O1/O2 checks with production GCC and Clang.

This first experiment establishes correctness and whether GCC keeps a floating
accumulator across iterations. It is not a timing acceptance run. The separate
allocation-inclusive measurement failure must be resolved and N2's timing/code/
stack budgets published before accepting a speed claim. D2's failed zero-update
requirement also remains open. A source change alone closes neither goal.

### Typed-state results

Source `80edb379` passes focused run `40959086200`: GCC Linux ARM64/AMD64 and
Clang macOS ARM64 each pass 253 tests in 14 summaries, plus all-target lint.
Complete logs and [the retained evidence](typed-loop-state-artifacts-2026-10-29.json)
are audited. These checks cover raw/optimized interpretation, native O1/O2,
flat/nested/mixed owners, preparation faults, cancellation and a deliberately
narrowed F64 state that must fail the bit checks. Each host retains all twelve
new program/bit/precision-loss probe binaries and their results.

Both GCC reports now carry a `double` accumulator between iterations. The input
array still needs its byte-load interpretation, but the accumulator no longer
converts to integer bits and back on each iteration. The conversion to the
ordinary return word occurs once after the loop. Both 65,537- and 262,145-element
programs match the exact oracle and finish with zero live storage. This verifies
the intended representation change on those compilers; it is not measured timing
or full-platform acceptance. Keep the two unresolved timing requirements above.

## Resource-counter diagnostic, declared before implementation

The remaining array failure is allocation-inclusive; its computation-only copy
control passes. Existing reports contain elapsed time but no per-process page
fault or scheduling counts. The derivative history control also needs a copy of
each variant, since a current-result copy does not control a history program.

On a qualified four-processor EPYC 7763 host with the matching recorded toolchain,
run the exact retained small-array binaries from expanded session 2
(`40951090783`) and zero-update history binaries from repaired session 1
(`40912773534`). Verify their hashes first. Ordinary builds still require no
previous fwp compiler; this experiment reuses recorded programs only for diagnosis.

Use 16 rounds, four fresh processes per label per round, seed 20261029 and the
existing balanced four-label schedule. For the array, labels are C, Rust, fwp and
its identical copy. For history they are candidate, reference and one identical
copy of each. Keep ordinary allowed CPU affinity. Do not rebuild, change inputs,
change internal sample counts or instrument the program. Retain every observation.

Around each serial child invocation, record the change in Linux child-resource
usage: user/system CPU seconds, minor/major page faults and voluntary/involuntary
context switches. Also keep process elapsed time, exact outputs and every array
sample's kernel/allocation-inclusive times and live-storage result. Record CPU
model, compiler versions, allowed CPUs, source and executable hashes. Check that
all resource deltas are nonnegative. Retain all failed qualifications and partial
results; reject a wrong host before executing the retained programs.

Compare elapsed variation with CPU work, faults and scheduling observations.
These counters cover the whole child process, including startup; they cannot
locate a delay inside one kernel or prove a cause from correlation. They may
justify a later targeted measurement repair, which must be declared before use.
This diagnostic makes no acceptance decision, adds no acceptance samples and
changes none of the failed results or limits. Do not rerun an unchanged failed
acceptance session until it happens to pass.

### Resource-counter results

Protocol `c32c8302`, runner `77c88449`, run `40961695545`, job `123755839057`:
all 512 process records, outputs, resource deltas, schedules and eight native
binary identities are independently audited. The [archive](timing-resources-artifacts-2026-10-29.json)
includes complete logs and the EPYC 9V45/9V74 hosts rejected before execution.
These numbers compare medians of the sixteen complete round totals:

| Diagnostic comparison | Elapsed-time ratio | CPU-time ratio |
|---|---:|---:|
| Array fwp / identical copy, whole child process | 1.00316 | 0.99956 |
| History candidate / reference | 1.02185 | 1.02273 |
| History candidate / candidate copy | 1.00270 | 1.00207 |
| History reference / reference copy | 0.98070 | 0.97937 |

Array kernel/inclusive copy ratios are 1.00099/0.99525. This stable diagnostic
control does not replace the earlier failed acceptance session. History's
reference and its byte-identical copy differ by about 2.1% in CPU time. Page-fault
counts are nearly equal; no major faults occur. Waiting to run therefore does
not explain all observed variation. Nor does this prove that the candidate adds
source-level work: the identical reference programs also differ. The cause is
still unresolved; do not attribute it to instruction layout, heap placement or
host load without an experiment that distinguishes those effects.

[Curtsinger and Berger's performance-evaluation study](https://people.cs.umass.edu/~emery/pubs/stabilizer-asplos13.pdf)
explains how code, stack and heap layout can bias timing comparisons. That is a
reason to avoid treating repeated elapsed times as independent proof of compiler
cost, not a diagnosis of these programs. No runtime randomizer or JIT is proposed.

The typed-state implementation passed the complete correctness matrix in #227.
That matrix does not turn these diagnostic timings into performance acceptance.
Both failed requirements remain open; any next measurement method needs its own
stated purpose and predeclared protocol before execution.

## Executable-name diagnostic, declared before implementation

The production derivative comparison has one identical-code control, for the
current-result program. It does not control either history variant. The resource
diagnostic supplies those missing copies, but gives all four roles filenames of
different lengths. Kernel timing also names fwp and its copy differently. These
are uncontrolled invocation differences, not evidence of unsafe language code or
an established explanation of the failed measurements.

Use the same retained small-array and zero-update history programs as the
resource diagnostic: kernel source `37da7441`, derivative source `694e31b7`,
qualified Linux EPYC 7763 with four allowed processors and the recorded GCC/Rust
versions. Verify every binary and source identity before execution. Do not rebuild,
change runtime code, disable address randomization or inspect disassembly.

Compare two explicit naming policies. `named` uses the resource diagnostic's
role-based basenames. `equal` uses four eight-character basenames, `slot0exe`
through `slot3exe`, inside each group's directory. Create the equal names as hard
links to the named files and verify device/inode equality: both policies execute
the same file, not independently compiled or copied programs. All paths are
absolute. Each invocation passes its executable path as argument zero; C/Rust
array peers retain their explicit `array` argument. Keep the same environment,
working directory, allowed CPU set and all remaining arguments for both policies.
This changes the executable name and argument-zero text together; it cannot
separate their individual effects or identify a stack/cache mechanism.

For each group, run sixteen rounds with four processes per role per policy,
seed 20261029 and the existing balanced four-label schedule. Alternate which
policy runs first each round. Retain all **1,024 process observations**, including
failures and outliers; no timing is an acceptance sample. Record elapsed time,
child CPU time, faults, context switches, exact commands and stdout/stderr hashes.
Check every result, all five array samples and zero final live storage. Preserve
all original binary bytes, the source/report identities, environment identity,
file-link identities and complete job logs. Reject a different host before
running any program. A host rejected before execution may be replaced; a measured
result must not be rerun because its ratios are inconvenient.

For each policy report candidate/reference and both history copy controls,
plus array kernel, allocation-inclusive and whole-child copy controls. Compare
median complete round totals, with individual observations retained. The prior
2% failures remain failures; this diagnostic neither changes those limits nor
closes D2/N1. A difference between policies is evidence about this invocation
change on this host, not proof of a general compiler cost or a future passing
baseline. If normalizing names does not explain the discrepancy, say so. Any
later acceptance repair needs its own published protocol and must control every
candidate/reference program it measures.
