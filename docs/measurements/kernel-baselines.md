# CPU array and matrix baselines

This is N1's measurement protocol, published before its new measurement runner.
It changes no compiler or runtime optimization. N2 must select a cost and publish
its candidate limits only after these baseline observations are audited. Earlier
[numerical measurements](numerical-kernels.md) retain their original source,
settings and outcomes; they are not measurements of the GC-free compiler.

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
Keep two warmup rounds and 16 measured rounds. Each round runs four processes
per label, sixteen processes total. A fixed Eulerian cycle over all sixteen
ordered label pairs, including self-pairs, supplies that order; rotate the cycle
one position per round. Each label occupies each of the sixteen process positions
four times over the complete run. Retain the order and every duration, including
outliers. The total remains 64 measured processes and 320 samples per label.

For each label and timing scope, sum its twenty samples across the four
processes in a round. Compare the medians of the sixteen round totals; do not
pretend within-process samples are independent sessions. The byte-identical pair must differ by no more than 2%
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
