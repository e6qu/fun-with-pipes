# Counting decimal characters without building a string

For example, `-17 | show | string.length` returns `3`: a minus sign and two
digits. Native fwp can compute that count without allocating a String. This
[verified experiment](../roadmap-history.md#decimal-counting-and-current-derivative-baselines-pr-225) changes the counting algorithm,
not the language's result, arithmetic checks or memory ownership.

**Current status:** the exact decimal-threshold tree meets the frozen timing
limits in both selected sessions on each architecture. Text counting takes
33.8–34.8% less time on ARM64 and 38.6–39.6% less on AMD64 than previous fwp.
It still takes 25.0–26.2% longer than the C peer. Focused correctness, memory and
artifact checks pass. PR #225 also passed all nine production jobs and docs;
[the verified delivery](../roadmap-history.md#decimal-counting-and-current-derivative-baselines-pr-225)
records its exact source and matching squash tree.

| Comparison | Outcome | Details |
|---|---|---|
| Bit width plus a table | Rejected: AMD64 did not qualify | [Results](#results-reject-the-table-candidate) |
| Threshold tree, short batches | Inconclusive controls on both hosts | [Short measurements](#short-threshold-tree-results-and-measurement-repair) |
| Threshold tree, longer batches | ARM64 qualified; AMD64 controls failed | [Longer measurements](#complete-longer-batch-outcome) |
| Threshold tree, position-rotated processes | AMD64 qualified; ARM64 controls failed; preceding workloads were unbalanced | [Order diagnosis](#interleaved-outcome-positions-alone-do-not-balance-preceding-work) |
| Threshold tree, balanced preceding work and positions | All four sessions qualify; original limits unchanged | [Results](#balanced-results-accepted-measurement) |

An **identical-code control** runs the same old binary under two labels. Their
timings should agree within the frozen noise limits. If they do not, a lower
candidate median does not establish a speedup. No earlier samples are discarded
or combined across different schedules.

The C/Rust peers use grouped division to count digits. Their comparisons include
that algorithm difference plus process startup, calculation, output and exit;
they do not isolate compiler overhead. Memory observations are separate from
timed execution. The sections below retain the exact inputs, flags, controls,
source IDs, size/stack costs and all outcomes.

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
`e` or `e+1`.

Decimal width is monotone, so those are the only possible counts
throughout that interval. Comparing with exactly `10^e` determines which applies:
`1 + e - (x < 10^e)`. The largest table index is 19; all twenty powers fit U64.

The table uses 160 readonly bytes and no heap allocation. It is a deliberate
code/data tradeoff, not an allocation or ARC optimization. Keep the actual table
bytes, section/address, alignment, instruction-section size, whole binary size
and stack reports in the measurement evidence.

## Candidate: exact decimal comparisons

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
binary/decimal boundaries and full-width extrema.

For the table candidate, removing the exact correction must fail. For the tree,
removing the one-versus-two-digit comparison must fail at every optimization level. This is a correctness oracle,
not a timing comparison with formatted text.

Both qualified GCC hosts passed the table candidate’s seven integer-output
groups at O0/O1/O2/O3, including all intentionally broken helper controls.
The tree also passed both GCC hosts at `9c89a3761cba2c3bccb02dff93b3fec6754f4583`,
including all seven integer-output groups. Later timing protocols require an
exact source-identity check before reusing those results. The final complete
production matrix passed in #225.

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
the original grouped-division baseline and the unchanged tree.

These are fresh
same-job baseline observations for the longer protocol; old short durations are
not directly pooled with them. Every selected session must pass both noise and
regression limits, and text must meet the fixed improvement limit. Do not reset
the table or rerun an inconclusive selected session until it happens to pass.

Only the harness/protocol/docs change after the verified short source. Do not
repeat the unchanged integer-output suite during these measurements; its native
proof applies by source identity. This protocol also required the full final-head
production matrix after the grouped batch. Noisy controls leave the performance
decision open; investigate measurement conditions rather than resetting limits.

### Why whole batches still need a closer comparison

Both longer ARM64 sessions in run `40804467873` meet the original limits:
text candidate/baseline ratios are 0.639021 and 0.647309; loop ratios are
1.000192 and 1.000090. Their text controls are 1.015877 and 1.016180, below
1.025422. Their logs and complete artifacts are independently audited.

The first qualified longer AMD64 session, job `123220596772` in `40804655433`,
passes correctness and artifact checks but is inconclusive. Loop's control passes
at 1.015622; text's control fails at 1.094294 against 1.052444. The text median
ratio is 0.634587, not an accepted speedup. In round 24, the original helper takes
1.171 seconds and the identical binary measured later takes 0.944 seconds.

Their process medians are 9.316 and 6.979 milliseconds. Multiple consecutive
processes shift together; a single extreme observation does not explain the gap.
This identifies a weakness in comparing separated batches, without establishing
a scheduler, CPU-frequency or virtualization cause. Keep the second already-
started AMD64 session as evidence; it cannot erase this first decision.

### Complete longer-batch outcome

All four longer jobs passed functional/evidence checks; neither AMD64 session
meets the timing acceptance rule. Job `123225063471`, attempt 4 of run
`40805067812`, is the second independent AMD64 observation. It has loop/text
control p95 ratios 1.029109/1.119031, both above their limits. No selected session
was replaced with a faster or quieter observation.

Values below are median batch milliseconds: eight complete loop processes or
128 complete text processes. C/Rust retain grouped division; their ratios still
include that algorithm difference and complete process costs.

| Host/session/program | C | Rust | Original helper | Tree | Identical original |
|---|---:|---:|---:|---:|---:|
| ARM64 1 loop | 1412.749 | 913.514 | 1046.388 | 1046.589 | 1046.570 |
| ARM64 1 text | 410.873 | 745.099 | 812.661 | 519.307 | 814.804 |
| ARM64 2 loop | 1412.539 | 913.613 | 1046.340 | 1046.434 | 1046.166 |
| ARM64 2 text | 418.898 | 757.416 | 826.836 | 535.219 | 828.746 |
| AMD64 1 loop | 1023.259 | 857.524 | 1026.845 | 1028.689 | 1027.683 |
| AMD64 1 text | 457.179 | 881.029 | 974.074 | 618.135 | 975.070 |
| AMD64 2 loop | 1019.300 | 856.692 | 1023.946 | 1025.324 | 1025.799 |
| AMD64 2 text | 453.506 | 861.294 | 965.039 | 602.712 | 962.342 |

Raw sessions [ARM64 1](decimal-long-2026-10-29-arm-1.json),
[ARM64 2](decimal-long-2026-10-29-arm-2.json),
[AMD64 1](decimal-long-2026-10-29-amd-1.json),
[AMD64 2](decimal-long-2026-10-29-amd-2.json) and the
[archive](decimal-long-artifacts-2026-10-29.json) retain every observation,
seven actual host rejections, exact job metadata and artifact identities.
Instruction/data sections, whole images and stack frames match the corresponding
short-session images; every reported memory counter and leak control was checked.
GitHub copies unchanged sibling status into a retry with a new job ID. Identical
runner/timestamps identify those copies; they are not independent executions.

### Process-by-process comparison, specified before measurement

The new `decimal-count-interleaved` suite runs one process from each of the five
implementations before moving to the next repetition. It rotates the first
implementation every repetition and sample. A sample contains ten loop processes
or 160 text processes **per implementation**, so each occupies every position
an equal number of times within that sample. Nearby executions now contribute
to the baseline/candidate/control totals instead of separate runs of 128
consecutive copies. It still measures complete processes, not an internal timer.

Keep 60 samples, two warmups, the same host/toolchain/input requirements and all
original numerical limits. Record every process's execution sequence and reject
missing, duplicate or reordered positions. Save complete rounds outside timing;
on an exception, timeout or interrupt, save the partial round before rethrowing.

No slow samples are removed. JSON formatting is compact. Collect the first two
qualified jobs per architecture by run/job ID, regardless of results, and require
all four to pass. Do not combine short, whole-batch and interleaved observations
into one statistic. The compiler/runtime/tests remain the already verified source.

This changes the measurement schedule to address time variation between
implementations. It is not evidence that the candidate works until the new
sessions complete and pass. The [repeat reader](../../scripts/check-decimal-repeat.py)
reconstructs every decision and session selection with explicit protocol/source
arguments; deliberately reordered observations and missing/duplicate jobs must fail.

### Interleaved outcome: positions alone do not balance preceding work

All four jobs at `e8a8cb8fefceaa8e955823f3c1d6edb737bf789e` passed functional
and artifact checks. Both AMD64 sessions qualify, but both ARM64 text controls
fail. The overall decision remains **not accepted**; passing results from
different protocols are not combined.

| Host/session/program | Original helper ms | Tree ms | Identical original ms | Control p95 | Candidate / original |
|---|---:|---:|---:|---:|---:|
| ARM64 1 loop | 1305.820 | 1306.083 | 1305.810 | 1.001310 | 1.000201 |
| ARM64 1 text | 1009.166 | 652.485 | 1034.557 | 1.071585 | 0.646559 |
| ARM64 2 loop | 1308.526 | 1308.626 | 1308.526 | 1.001876 | 1.000076 |
| ARM64 2 text | 1023.018 | 666.443 | 1051.069 | 1.069806 | 0.651448 |
| AMD64 1 loop | 1284.035 | 1282.164 | 1282.077 | 1.010957 | 0.998543 |
| AMD64 1 text | 1219.598 | 731.385 | 1211.512 | 1.030315 | 0.599693 |
| AMD64 2 loop | 1280.194 | 1282.154 | 1280.026 | 1.010456 | 1.001531 |
| AMD64 2 text | 1213.410 | 725.702 | 1218.618 | 1.045014 | 0.598069 |

These are ten-process loop or 160-process text batches. Complete C/Rust peer
medians, outputs, memory profiles and code/stack costs remain in raw sessions
[ARM64 1](decimal-interleaved-2026-10-29-arm-1.json),
[ARM64 2](decimal-interleaved-2026-10-29-arm-2.json),
[AMD64 1](decimal-interleaved-2026-10-29-amd-1.json),
[AMD64 2](decimal-interleaved-2026-10-29-amd-2.json), and the
[archive](decimal-interleaved-artifacts-2026-10-29.json).

The recorded execution order exposes a schedule defect. In each ARM64 text
session, the original helper follows Rust 7,680 times, C 1,908 times and its
identical control 12 times. The identical control instead follows the candidate
7,680 times, the original helper 1,908 times and Rust 12 times. Rotating positions
did **not** give the two identical binaries comparable preceding workloads.
This proves an imbalance in the harness; it does not prove a particular hardware
mechanism for the observed timing difference.

### Balance before/after pairs, specified before measurement

The new `decimal-count-balanced` protocol constructs a 25-execution cycle in
which each possible preceding/current implementation pair appears once, including
same-implementation pairs. Each implementation appears five times per cycle.
Repeat it twice for loop samples and 32 times for text: still ten and 160 complete
processes per implementation/sample. Rotate the cycle's start over 75 measured
samples, covering all 25 positions three times. Every implementation then occupies
every execution slot equally across samples. Keep two warmup samples.

At a sample boundary the rotated cycle can change one before/after transition;
that process is retained, not dropped. Tests verify every cycle pair, all counts,
slot balance and this one-transition bound. Every execution sequence remains
checked against the declared schedule. The original numerical limits, hosts,
compilers, inputs, process timing and first-two-job selection rule do not change.
Require both complete independent sessions on both architectures to pass.

This repairs the observed scheduling imbalance. It is not a speedup claim before
measurement and does not erase the earlier failed control decisions. Native
correctness is reused only after checking exact compiler/runtime/test identity.

## Balanced results: accepted measurement

Source `0c84afe98baec2b771fd416aced35eb4d6c11a24` retains the same runtime and
native tests as the two-host correctness checkpoint `9c89a3761cba2c3bccb02dff93b3fec6754f4583`.
The first two qualified jobs per architecture all pass the fixed improvement,
regression and identical-code noise limits. Selection was fixed before inspecting
results. These measurements support adopting the tree for this workload; they do
not validate every input distribution or close every CPU gap.

Each ratio is candidate elapsed time divided by the named comparison; below one
means less time. The control p95 column measures variation between executions of
the identical old binary. Each value is recomputed from all 75 measured rounds,
with no sample deletion. Timings include process launch, calculation, output and
exit, but exclude compilation and memory instrumentation.

| Session | Text / old fwp | Text / C | Text / Rust | Text control p95 | Loop / old fwp | Loop control p95 |
|---|---:|---:|---:|---:|---:|---:|
| arm-1 | 0.652311 | 1.250426 | 0.691798 | 1.012587 | 0.999647 | 1.001808 |
| arm-2 | 0.661920 | 1.258689 | 0.702906 | 1.009410 | 1.000032 | 1.001843 |
| amd-1 | 0.603616 | 1.261598 | 0.668206 | 1.040526 | 1.000191 | 1.012304 |
| amd-2 | 0.613679 | 1.253633 | 0.676502 | 1.029667 | 0.999646 | 1.015789 |

The loop is unchanged and remains slower than Rust: about 14.5% on ARM64 and
19.5–19.7% on these AMD64 sessions. Earlier baseline ratios remain recorded at
their original source and schedule; this is not an accepted loop optimization.
C/Rust keep grouped division, so the text comparison includes an algorithm
difference rather than isolating language overhead.

The text instruction section grows by 496 bytes on ARM64 (11,164 to 11,660) and
560 on AMD64 (11,986 to 12,546). Readonly sections, whole binary file sizes and
all reported stack frames are unchanged. No lookup table or heap storage is
added. Both loop and text-length retain zero managed requests and count updates.

All seven benchmark programs, 21 peer images and 14 storage/control images per
session were audited. The other five programs retain identical instruction bytes;
`strings` and `text-length` retain the same fwp calculation. Ordinary peer timings,
including remaining slow cases, stay in each archive's benchmark report.

Run [40810741109](https://github.com/e6qu/fun-with-pipes/actions/runs/40810741109)
contains ARM64 jobs `123240190193`/`123240190249` and AMD64 `123240190307`.
Run [40811270742](https://github.com/e6qu/fun-with-pipes/actions/runs/40811270742)
contains the second selected AMD64 job `123241898078` (workflow session 1).
AMD64 jobs `123240190231` and `123241898015` rejected nonmatching hardware before
building or timing. Their red workflow status does not hide a measured failure:
the four selected jobs completed successfully and every log was audited.

Raw reports: [ARM64 1](decimal-balanced-2026-10-29-arm-1.json),
[ARM64 2](decimal-balanced-2026-10-29-arm-2.json),
[AMD64 1](decimal-balanced-2026-10-29-amd-1.json),
[AMD64 2](decimal-balanced-2026-10-29-amd-2.json).
The [archive](decimal-balanced-artifacts-2026-10-29.json) retains full job metadata,
all artifact hashes, peer/memory reports and both host rejections. Documentation
CI recomputes every decision and requires the explicit `accepted` result; it also
preserves the previous protocols' `not-accepted` results. A deliberately false
acceptance claim for the longer-batch archive was rejected by the local check.
