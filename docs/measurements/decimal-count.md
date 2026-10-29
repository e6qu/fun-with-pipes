# Decimal-length algorithm comparisons

This [P2/P3 experiment](../../PLAN.md#4-cpu-performance) changes how native fwp
counts decimal characters without constructing a string. The original helper
uses grouped division. The first alternative, bit width plus a power-of-ten
table, **is rejected overall**: ARM64 improved, but AMD64 did not qualify.
The next candidate uses a balanced tree of exact decimal comparisons, with no
lookup table. It is implemented for testing, not accepted as a speedup.

## Rejected candidate: bit width and a table

For example, 8 has four bits. The estimate is 1; because 8 is below 10, the answer
is one digit. 10 also has four bits and the same estimate, but is not below 10,
so the answer is two. Signed values use an unsigned magnitude and add the minus
sign separately, preserving the minimum signed integer without signed negation.

Set the low bit: `x |= 1`. For positive even values this adds one without crossing
a decimal-width boundary: every positive power of ten is even, while its previous
value is odd and therefore unchanged. Zero becomes one; both need one character.
The resulting value is nonzero, so counting leading zero bits is defined.

Let `b` be its bit width, from 1 through 64, and `e = (b * 1233) >> 12`.
The fraction 1233/4096 approximates log10(2), but correctness does not depend on
floating-point approximation. For **each of the 64 integer intervals**
`[2^(b-1), 2^b - 1]`, the measured revision’s tests verified that both endpoint digit counts are either
`e` or `e+1`. Decimal width is monotone, so those are the only possible counts
throughout that interval. Comparing with exactly `10^e` determines which applies:
`1 + e - (x < 10^e)`. The largest table index is 19; all twenty powers fit U64.

The table uses 160 readonly bytes and no heap allocation. It is a deliberate
code/data tradeoff, not an allocation or ARC optimization. Keep the actual table
bytes, section/address, alignment, instruction-section size, whole binary size
and stack reports in the measurement evidence.

## Next candidate: exact decimal comparisons

Split the 20 possible digit counts at `10^10`, then split each remaining range
at its middle decimal boundary. For example, values below 10 need one digit;
values from 10 through 99 need two. At most five comparisons select one of the
20 intervals. Zero is in the first interval, and U64's maximum is in the last.
Every threshold is an exact U64 constant. There is no approximation, division,
indexed lookup or additional heap storage. Signed magnitude handling is unchanged.

The tree may enlarge instruction bytes or behave poorly with unpredictable
branches. Those are hypotheses to measure, not reasons to assume it is faster.
The same fixed limits and baseline apply; do not repeat the old experiment to
cherry-pick a quieter AMD64 sample.

## Correctness checks

`integer_output` extends runtime-input tests across every binary and decimal
width transition, signed extrema, zero, Unicode concatenation, sharing and
checked-arithmetic effects. Compare raw interpretation with native O0/O1/O2/O3.
A separate test extracts the actual emitted helpers and compares them with C's
`snprintf`: all unsigned values through 65,535 and their signed opposites, all
binary/decimal boundaries and full-width extrema. For the table candidate, removing the exact correction must fail. For the tree,
removing the one-versus-two-digit comparison must fail at every optimization level. This is a correctness oracle,
not a timing comparison with formatted text.

Both qualified GCC hosts passed the table candidate’s seven integer-output
groups at O0/O1/O2/O3, including all intentionally broken helper controls.
The tree needs its own native verification; the final production matrix remains
required for the complete batch.

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

[decimal-count.py](../../scripts/decimal-count.py) checks identities,
actual sections, stack records, samples and fixed limits. The table experiment
retains its actual 160 bytes and alignment; the tree requires that table to be absent. Its
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
The corrected comparison completed below. No completed result was discarded
and no timing limit changed.


## Results: reject the table candidate

Measured source: `df80c15ee894c437df0f0216db211abefc27115c`, retained by tag
`roadmap/revision-decimal-count-df80c15e`. ARM64 completed in
[40800093045](https://github.com/e6qu/fun-with-pipes/actions/runs/40800093045);
qualified AMD64 completed in
[40800624780](https://github.com/e6qu/fun-with-pipes/actions/runs/40800624780).
Two intervening AMD64 jobs found Xeon 8370C instead of the required EPYC 7763
and stopped before building or timing. Their host records remain alongside
[both raw sessions](decimal-count-2026-10-29-arm.json) and the
[AMD64 session](decimal-count-2026-10-29-amd.json).

Each cell below is median milliseconds per batch: one process for `loop`, 32
for `text-length`. This includes launch, computation, printing and exit.

| Host / program | C | Rust | Original fwp helper | Table candidate | Identical original |
|---|---:|---:|---:|---:|---:|
| ARM64 loop | 176.555 | 114.006 | 130.268 | 130.308 | 130.310 |
| ARM64 text-length | 101.303 | 184.157 | 197.029 | 159.045 | 197.404 |
| AMD64 loop | 127.136 | 107.179 | 128.462 | 128.396 | 128.422 |
| AMD64 text-length | 114.035 | 216.064 | 242.391 | 267.712 | 243.199 |

ARM64 text takes 19.28% less time than the original helper; both noise controls
pass. It remains 57.0% slower than C and is 13.64% faster than Rust here, with
different counting algorithms. That does not establish compiler-overhead parity.
AMD64 text's observed median is 10.45% slower. Its identical-code p95 ratio is
1.063392 against the frozen 1.052444 limit; loop also exceeds its noise limit
(1.024430 versus 1.018789). These AMD64 decisions are **inconclusive**, not
accepted speedups or reliable regression estimates. The two-architecture rule
therefore rejects this candidate; no budget is relaxed.

For text-length, instruction bytes fell from 11,164 to 10,796 on ARM64 and
11,986 to 11,490 on AMD64. Both whole binaries grew by 40 bytes, with a
160-byte readonly table at offsets 48 and 32 within a 64-byte alignment unit.
Main/worker stack frames stayed 144/272 bytes on ARM64 and 128/256 on AMD64.
Loop instruction bytes, binary size and stack frames were unchanged. Separate
profiles report zero named managed-memory counters for both measured programs;
that does not mean process RSS is zero. All seven peer timings and storage/RSS
profiles remain in the [artifact archive](decimal-count-artifacts-2026-10-29.json).

All logs and retained generated C, machine sections, stack reports, 16 semantic
images per host, 21 ordinary peer images and 14 storage images were audited.
[The permanent reader](../../scripts/check-decimal-records.py) reconstructs the
fixed acceptance decisions from every raw sample and checks source/report/image
identities. This preserves the result without rerunning the rejected candidate.

## Short threshold-tree results and measurement repair

Source `9c89a3761cba2c3bccb02dff93b3fec6754f4583` passed all seven native
integer-output groups, benchmark outputs, peer controls and memory/leak checks
on both qualified GCC hosts. ARM64 completed in
[40802931428](https://github.com/e6qu/fun-with-pipes/actions/runs/40802931428);
AMD64 completed in
[40803171811](https://github.com/e6qu/fun-with-pipes/actions/runs/40803171811).
Two AMD64 attempts found EPYC 9V45 and stopped before compilation/timing.

| Host / program | C ms | Rust ms | Original helper ms | Tree ms | Identical original ms | Control p95 / limit |
|---|---:|---:|---:|---:|---:|---:|
| ARM64 loop | 176.450 | 114.181 | 130.757 | 130.834 | 130.733 | 1.006052 / 1.006855 |
| ARM64 text-length | 105.427 | 190.092 | 206.034 | 133.426 | 206.966 | 1.025828 / 1.025422 |
| AMD64 loop | 126.928 | 107.264 | 128.432 | 128.365 | 128.047 | 1.032092 / 1.018789 |
| AMD64 text-length | 115.278 | 220.532 | 245.207 | 149.635 | 243.511 | 1.046305 / 1.052444 |

These use the same short batches: one loop process or 32 text processes.
ARM64 text's observed median falls 35.24%, but its noise control narrowly fails;
AMD64 text passes at 38.98% less time, but its unchanged loop control fails.
**Neither complete session qualifies.** Keep all samples, without excluding
outliers: ARM64's baseline text process median is 6.400 ms, p95 7.022 ms and
maximum 8.090 ms; the identical binary's values are 6.409/7.359/9.623 ms. This
establishes variation in short process timings, not its operating-system cause.

The tree uses 496 more instruction bytes on ARM64 and 560 more on AMD64 than
the original text helper. Whole binary sizes, readonly section sizes and the
main/worker stack frames are unchanged; there is no decimal lookup table.
All other five programs retain identical instruction sections. Raw
[ARM64](decimal-tree-2026-10-29-arm.json),
[AMD64](decimal-tree-2026-10-29-amd.json) and
[artifact records](decimal-tree-artifacts-2026-10-29.json) preserve the complete
short sessions. The permanent reader rechecks both inconclusive decisions.

### Longer batches, specified before their measurement

The `decimal-count-repeat` suite increases **only** the number of separate
processes in each sample: eight for `loop`, 128 for `text-length`. Each process
still performs the unchanged complete program, including startup and exit.
This averages more observations per sample; it does not eliminate startup,
change the algorithm or turn this into an internal calculation timer. Keep 60
samples, two warmups, rotating five-entry order, all four CPUs without affinity,
exact host/toolchain/input qualification and every original numerical limit.
JSON checkpoints use compact formatting outside the timed intervals.

Collect two independent qualified jobs per architecture. Select the first two
by workflow run/job ID, independent of their results; retain all host rejections
and any additional scheduled observations. Each job rebuilds and measures both
the original grouped-division baseline and the unchanged tree. These are fresh
same-job baseline observations for the longer protocol; old short durations are
not directly pooled with them. Every selected session must pass both noise and
regression limits, and text must meet the fixed improvement limit. Do not reset
the table or rerun an inconclusive selected session until it happens to pass.

Only the harness/protocol/docs change after the verified short source. Do not
repeat the unchanged integer-output suite during these measurements; its native
proof applies by source identity. The full final-head production matrix must
still run after the grouped batch is ready. If the longer controls remain noisy,
leave the performance decision open and investigate measurement conditions.
