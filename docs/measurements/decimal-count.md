# Decimal length from bit length

This is the next [P2/P3 candidate](../../PLAN.md#4-cpu-performance), selected after
[the execution-phase diagnostic](cpu-phases.md). It is implemented for testing;
no speedup or acceptance is claimed yet. The current helper repeatedly divides
an unsigned magnitude by powers of ten. The candidate estimates its decimal width
from its bit width, then makes one exact power-of-ten comparison.

For example, 8 has four bits. The estimate is 1; because 8 is below 10, the answer
is one digit. 10 also has four bits and the same estimate, but is not below 10,
so the answer is two. Signed values use an unsigned magnitude and add the minus
sign separately, preserving the minimum signed integer without signed negation.

## Exact integer proof

Set the low bit: `x |= 1`. For positive even values this adds one without crossing
a decimal-width boundary: every positive power of ten is even, while its previous
value is odd and therefore unchanged. Zero becomes one; both need one character.
The resulting value is nonzero, so counting leading zero bits is defined.

Let `b` be its bit width, from 1 through 64, and `e = (b * 1233) >> 12`.
The fraction 1233/4096 approximates log10(2), but correctness does not depend on
floating-point approximation. For **each of the 64 integer intervals**
`[2^(b-1), 2^b - 1]`, the tests verify that both endpoint digit counts are either
`e` or `e+1`. Decimal width is monotone, so those are the only possible counts
throughout that interval. Comparing with exactly `10^e` determines which applies:
`1 + e - (x < 10^e)`. The largest table index is 19; all twenty powers fit U64.

The table uses 160 readonly bytes and no heap allocation. It is a deliberate
code/data tradeoff, not an allocation or ARC optimization. Keep the actual table
bytes, section/address, alignment, instruction-section size, whole binary size
and stack reports in the measurement evidence.

## Correctness checks

`integer_output` extends runtime-input tests across every binary and decimal
width transition, signed extrema, zero, Unicode concatenation, sharing and
checked-arithmetic effects. Compare raw interpretation with native O0/O1/O2/O3.
A separate test extracts the actual emitted helpers and compares them with C's
`snprintf`: all unsigned values through 65,535 and their signed opposites, all
binary/decimal boundaries and full-width extrema. Removing the exact threshold
correction must fail at every optimization level. This is a correctness oracle,
not a timing comparison with formatted text.

Local finite proofs and eight small Clang helper/control cases pass. Those checks
do not verify actual fwp emission, GCC or native Windows; runner validation and
the final production matrix remain required.

## Paired measurement

The `decimal-count` evidence workflow first qualifies a host against the unchanged
[frozen CPU table](cpu-baselines.md), before building or timing programs. Use the
same loop/text-length inputs and GCC/Rust versions, O2, `-ffp-contract=off`, no
link-time optimization and four available CPUs, without affinity pinning.

Build fwp from Rust and emit each of the seven benchmark programs. The candidate
is that actual generated C. Construct its paired control by changing **only** the
decimal helper back to source `c92fed4208a16627f0f420f58ce1f7729bf0f061`; require
that this exactly restores the runtime source. Both images include the same
startup error handling. No previous fwp executable or binary compatibility is
required. Compile both with the production GCC flags plus `-fstack-usage`, and
require the candidate's machine-text bytes to equal the ordinary benchmark image.

For loop and text-length, rotate five entries: C, Rust, old helper, candidate and
an identical-old-helper control. Use two warmups and 60 measured rounds, so each
entry occupies each position twelve times. A loop batch has one process; a text
batch has 32. Each process has a 120-second timeout. Retain every duration, status,
output, source/hash and position. Timings include process launch, computation,
printing and exit; exclude compilation, evidence writes and memory profiles.

Use the frozen median regression/improvement limits and the existing identical-
code p95 envelope. No threshold resets. Both named workloads must remain within
their regression limits, and text-length must pass its improvement limit on both
architectures. Preserve noisy and slower results, even if they reject the change.

C/Rust retain their grouped-division algorithm. Their ratios therefore compare
complete implementations with an algorithm difference; they are not isolated
language overhead. The `strings` benchmark still builds strings in C/Rust;
its optimized fwp calculation must have the same machine-text bytes as
`text-length`. The other four fwp programs must have identical machine text
between old/new helpers. Check both variants' outputs and retain all seven current
peer timings, managed-storage/RSS observations and leak controls separately.

[decimal-count.py](../../scripts/decimal-count.py) checks identities, table bytes,
actual sections, stack records, samples and fixed limits. Its
[controls](../../scripts/test-decimal-count.py) reject missing, reordered, failed,
changed and noisy observations. Full final-head CI follows once this candidate
has a measured accept/reject decision and the related startup fixes are complete.


## Initial validation and reader repair

At `f910ffb866e5800d9f6fb46cc71741f9f730ba8e`, both native GCC jobs in
[run 40799193551](https://github.com/e6qu/fun-with-pipes/actions/runs/40799193551)
passed all seven integer-output groups, the seven-program benchmark, peer controls
and memory/leak audits. Both then stopped **before paired timing** because the
reader named the string-formatting benchmark `text` instead of its actual name,
`strings`. This was a reader error, not a numerical failure or a timing rejection.

The repair uses `strings` everywhere and checks the declared cases against the
actual benchmark directories and matching fwp bodies. Both complete logs and
all sixteen retained semantic/control images per host were reviewed. The
[initial records](decimal-count-initial-2026-10-29.json) retain the partial reports,
passed helper outcomes, seven-peer/memory context and complete artifact hashes.
The corrected ordinary comparison still needs to run. No completed result was
discarded and no timing limit changed.
