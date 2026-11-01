# CPU array and matrix baselines

This records the original N1 protocol and its still-incomplete timing acceptance.
ARM sessions pass; AMD measurements retain missing coverage and failed copy
controls. Later compiler work may proceed using independently verified costs;
[PLAN.md](../../PLAN.md#7-numerical-loops) owns that work. Neither later allocations
removed nor a different CPU settles these original timing requirements.

The protocol below predates its measurement runner and selected no optimization.
Earlier [numerical measurements](numerical-kernels.md) use their own recorded
sources and settings. They are not measurements of the current compiler.

## Work to compare

Run four cases, each with eight calculation rounds per sample:

| Case | Work |
|---|---|
| Array 65,537 | Fill an F64 array; map `x * 3 + 1`; reduce left to right from negative zero |
| Array 262,145 | The same operations on the larger array |
| Matrix 65×67 × 67×63 | Multiply F64 matrices in 32-wide blocks |
| Matrix 257×259 × 259×255 | The same ordered multiplication at the larger size |

At round `r=0..7`, array and left-matrix element `i` is `((i+r)%19 - 9)/4`;
right-matrix element `i` is `((i+r)%13 - 6)/8`. Matrix output starts at zero.
Retain the original block/loop order; multiplication and addition stay separate.
No reassociation, contraction or approximate-math option is permitted.

Compare compiled fwp, C, Rust and a byte-identical copy of the fwp executable.
C/Rust dimensions remain hidden from constant propagation, matching generated
fwp's runtime metadata loads. C's fresh output uses `restrict`; Rust's mutable
output slice also conveys exclusivity. Generated fwp may convey different alias
information. Retain these differences, source, build commands and executable
identities; equal formulas do not imply identical machine instructions.

Each fwp case exports the calculation as a function called by a native C harness.
That harness fills inputs through fwp's array-storage API; the C and Rust peers
fill their own native buffers. This measures the compiled kernel and its native
entry/allocation costs, not an entire fwp application or the speed of an fwp
input generator. The retained sources show this boundary. These task-free
programs emit `FWP_TASK_TICKS=0`; their timers contain no scheduler tick checks.
Matrix byte loads/stores use fixed-size copy intrinsics for C aliasing safety,
while the peers use typed floating-point buffers. Do not attribute every observed
difference to ARC or to the language's arithmetic operations.

An independent exact-integer oracle checks every result bit: the chosen inputs
and arithmetic are binary fractions with bounded integer numerators. Array
terms use quarters and matrix products use thirty-seconds. Each expected matrix
cell can be calculated without floating-point rounding for these finite sizes.
Check complete result vectors separately from timed hash consumption. Include
negative controls for changed results, missing cleanup and malformed configuration.

## Hosts and explicit settings

Use two independent sessions on each four-processor host: Linux ARM64 Neoverse-N2
with GCC 13.3.0 and Linux AMD64 EPYC 7763 with GCC 15.2.0. Rust is 1.99.1. Reject
wrong hosts before compilation/timing and retain their reports. A replacement
selects only its missing session; no completed result is silently rerun or removed.

Use GCC O2, architecture `armv8-a` or `x86-64`, `-ffp-contract=off`, no LTO,
ordinary ownership, stack storage and unique reuse enabled. Rust uses O2 and the
matching architecture. Record every compiler identity and option. Inputs, sample
counts, warmups, session, execution timeout, tools and artifact destination are
explicit runner arguments; no previous fwp compiler is needed.

## Timing and noise control

Each process reports five samples, each containing the eight calculation rounds.
Keep two warmup rounds and 16 measured rounds. The original protocol used four
processes per label per round for every case. Its small-matrix comparison proved
underpowered; the [sampling repair](timing-variation.md#small-matrix-sampling-repair-declared-before-implementation)
was published in `3870a1bf` before implementation. Current counts are explicit:

| Case | Processes per label per round | Measured processes per label | Internal samples per label |
|---|---:|---:|---:|
| Small matrix | 256 | 4,096 | 20,480 |
| Either array or large matrix | 4 | 64 | 320 |

A fixed cycle over all sixteen ordered label pairs, including self-pairs,
supplies the order. Rotate it one position per round; for the small matrix repeat
that cycle 64 times within each round. Every label occupies each process position
four times over the sixteen rounds. Within-round predecessor pairs occur 1,023
times each for the small matrix and fifteen times for the other cases. Transitions
between rounds are retained but are not claimed to have the same balance. Retain
every observation, including outliers. Ordinary scheduling remains unchanged.

For each label and timing scope, sum all its samples in a round (1,280 for the
small matrix, twenty otherwise). Compare the medians of the sixteen round totals;
within-process samples are not independent sessions. The byte-identical pair must differ by no more than 2%
for both timing scopes in each case. This is a predeclared measurement-resolution
requirement, not a compiler regression budget. If it fails, keep the result as
inconclusive and repair the measurement method before accepting any candidate.
Do not remove slow samples, increase the limit or retry unchanged for a pass.

Report these boundaries separately:

- Array kernel: consume an already filled input, map/reduce, and release it.
  Input allocation/filling is excluded; ownership cleanup is included.
- Matrix kernel: ordered multiplication/accumulation after output allocation and
  zeroing. Allocation, checks outside the loop and result cleanup are excluded.
- Allocation-inclusive calculation: inputs/results, filling, computation, bit
  checksumming and cleanup. Printing reports, process startup and runtime
  initialization are excluded.
- Whole process: wall time through startup, all five samples, report printing
  and shutdown. Preserve it as context, not as either kernel timer.

Memory profiles run in separate executables. Record allocation requests/requested
bytes, effective retain/release operations, peak/final managed charge, raw storage
where used, and process peak RSS. C/Rust payload bytes, fwp allocator charge and
process RSS have different meanings; report them separately. Every case must
restore its pre-operation live-storage baseline and release owners at shutdown.

## Evidence and next decision

Retain every generated source, build diagnostic, binary/section hash, instruction
size, static stack entry, output, process sample and profile. Inspect executable
sections and absent collector symbols; do not infer speed from instruction count.
Fewer allocations and faster fwp versus earlier fwp do not establish C/Rust parity.

After all four sessions pass correctness and noise checks, publish per-case
fwp/C and fwp/Rust ratios for both timing scopes, their overhead percentages,
allocation/peak counts and code/stack costs. Use those observations to name N2's
specific redundant work. Record baseline variation and explicit per-case
regression/improvement thresholds before changing its implementation. Full
platform validation and failure/cancellation/alias controls remain required for
any compiler/runtime change. N1 alone does not complete N2 or the roadmap.

## Running the baseline

Dispatch `Numerical and ownership evidence` with `suite=kernel-baselines`,
`native_runner=all` and `comparison_session=both`. The job qualifies its host
before building and preserves rejection reports. It compiles the current source;
it does not need a previously installed fwp. To replace an unmatched host, name
only its native runner and session and retain the rejected attempt.

`measure-kernel-baselines.py` is the new repeated-baseline protocol. The older
`measure-numerical-kernels.py` serves its separately documented short comparisons;
its historical experiments and raw data are not rewritten by this baseline.
The new runner uses the existing C/Rust/native harness formulas with explicit
size substitutions, exact-result verification runs, separate memory profiles,
all process observations, ELF sections and GCC frame reports. Its deliberately
leaked owner must fail before process exit can hide the retained storage.

`check-kernel-baselines.py` recomputes the retained timing summaries and checks
result oracles, memory observations, runner identities and raw evidence hashes.
It requires an explicit coverage choice: `initial-arm` checks only the historical
two-session archive; `complete` requires both sessions on both architectures.
The documentation controls reject incomplete coverage, changed results, missing
owners' cleanup, altered timings, copied jobs and mismatched evidence files.

## Initial ARM observations; N1 remains open

The [repaired-source recheck](kernel-recheck-artifacts-2026-10-29.json) includes
two passing ARM sessions at `bf46f776` and an inconclusive AMD session 2. Its small
matrix's byte-identical executables differ by 3.27% in computation and 3.49%
including allocation, exceeding 2%. Every result, process, binary, frame, memory
profile and full log is audited; both failed rules remain. No qualified AMD
session 1 completed. Subsequent [timing diagnostics](timing-variation.md) did not
resolve all acceptance failures;
[all rejected hosts](kernels-recheck-rejections-2026-10-29.json) remain recorded.
Do not retry the unchanged measurement to get a passing result.

For all four kernel cases, the repaired compiler emits exactly the same C as
the initial ARM source. This establishes source applicability for those kernels,
but it does not erase the AMD noise failure or complete the missing session.

Run `40906486080` at `f053da88` has two independently audited Neoverse-N2 sessions:
jobs `123562554782` and `123562554084`. Every result bit, process observation,
median, cleanup profile, emitted source identity, executable section and frame
report was checked. Both complete logs pass. The byte-identical control differs
by at most 0.16%, below the 2% limit. The [archive index](kernel-baselines-artifacts-2026-10-29.json)
links both full reports/logs and 5,782 artifact identities.

These are initial observations, not completed N1 acceptance. Applicability to
PR #227's record-return repair was subsequently checked in the recheck above. Both AMD jobs were rejected before building: session 1 received
Intel Xeon 8573C, session 2 EPYC 9V74, instead of EPYC 7763. Their reports and full
logs remain in the index. This baseline selected no N2 optimization or acceptance limit.

The ranges below cover the two ARM sessions. Each ratio is **fwp time / peer
time**; 1.30 means 30% extra time. Kernel time excludes input allocation/filling;
the allocation-inclusive scope includes them. These are named-workload costs,
not a universal language overhead.

| Case | Kernel vs C | Kernel vs Rust | Including allocation vs C | Including allocation vs Rust |
|---|---:|---:|---:|---:|
| Array 65,537 | 0.973–0.975 | 1.007–1.009 | 1.295–1.296 | 1.697–1.704 |
| Array 262,145 | 1.026–1.028 | 1.011–1.012 | 1.286–1.289 | 1.658–1.663 |
| Matrix 65×67 × 67×63 | 1.046–1.047 | 1.409–1.413 | 1.094–1.096 | 1.469–1.471 |
| Matrix 257×259 × 259×255 | 1.042–1.043 | 1.335–1.341 | 1.000–1.006 | 1.311–1.320 |

Each eight-round array sample allocates eight buffers in all implementations.
The fwp buffer needs eight metadata bytes beyond the peer's payload. Matrix
samples request 40 allocations in fwp versus 24 in C/Rust: the native harness
passes two record-wrapped input matrices per round, in addition to three buffers.
These entry/record costs are included in the broader timer, outside the matrix
kernel timer. Profiles observe no effective retains or nonlast releases, and all
live-storage ledgers return to zero. The reports retain process RSS, allocator
charge, requested bytes, virtual reservation, code and stack costs separately.

## Expanded small-matrix recheck

Run `40951090783` at `37da7441` completes both qualified sessions on each CPU.
The [compressed archive](kernel-expanded-artifacts-2026-10-29.json.gz) retains all
four reports, full logs and 156,716 file identities. Independent audits checked
every process, result bit, cleanup observation, binary section and stack report:
144 ELF images, 96 frame reports and 77,968 commands.

All small-matrix controls now pass: at most 0.098% difference on ARM64 and
1.38% on AMD64. Both large-matrix controls and all computation-only array controls
pass. AMD session 2 fails the small array's allocation-inclusive control at
**1.030786192**, above **1.02**. The complete N1 result remains inconclusive;
these are not four fully accepted sessions. No failed session was retried.

Computation-only fwp/C ratios across the two sessions are:

| Case | ARM64 | AMD64 |
|---|---:|---:|
| Array 65,537 | 0.973–0.980 | 3.306–3.309 |
| Array 262,145 | 1.026–1.027 | 3.279–3.283 |
| Matrix 65×67 × 67×63 | 1.047 | 1.983–2.000 |
| Matrix 257×259 × 259×255 | 1.042–1.044 | 1.674–1.676 |

A ratio of 3.3 means about 230% more time than this C kernel. The native-harness
and representation differences above still apply. The small array's broader
timer does not qualify on AMD64. Compiler diagnostics may investigate the
consistent computation gap; they cannot erase that separate failed control.
