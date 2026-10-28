# Building numeric maps and sets without temporary lists

Historical measurements at the revisions named below. Counts and timings are
observations of those programs, not current compiler budgets. Commands refer
to the recorded measurement revision. Read [measurement terms](../benchmarks.md)
for timing and memory boundaries; [the plan](../../PLAN.md) owns remaining work.

## Current reproduction protocol

`measure-collection-build.py` and `summarize-collection-build.py`
compare two compilations of the same fwp program: collection
fusion enabled and disabled. They do not compare fwp with C or Rust. Inputs are
32, 4,096 and 65,536 integers, for maps, mapped sets and range sets. Both versions
must match the raw interpreter. Eight samples per version use recorded randomized
order; the timer includes process startup, construction, the query/hash and output.
The reported ratio is fused time divided by ordinary time; below one is faster.

Separate instrumented executables report allocation requests, requested bytes,
retains, peak live bytes and final live bytes. These are not whole-process RAM.
Compilation time, compiler flags, host details, binary size and section sizes are
recorded separately. The audit requires 28 actual binaries per host: four builder
failure/control binaries, two compact-set probes, four range-set probes and 18
timed program variants. It rejects collector symbols in every inspected binary.
This standalone comparison still needs a new measurement run. The results below retain
their original revisions and memory modes; do not treat them as new measurements.

### Compact set storage: measured allocation size

Sets need one key per entry; the former map-shaped layout also reserved an
unused value word. The [six-host report](compact-sets-2026-10-19.json)
checks the compact layout at `a6dd7609` on Linux, macOS and Windows, each on
ARM64/AMD64. This is a storage check, not a before/after timing comparison.

For 4,096 distinct inline integer keys, the final container requests 32,776 bytes
(`8 + 8*n`). The previous layout's formula gives 65,544 bytes (`8 + 16*n`).
The probe measures the new requests at 0, 1, 7, 257 and 4,096 keys in ARC/tracing
at O0/O2; empty sets make no request. Allocator headers, rounding, construction
scratch and separately allocated keys are additional. Maps still store both
keys and values, even when every value is `()`.

All 41 focused tests passed on each host, with none ignored. The report audits
144 actual binaries, their formats, sections and tracing symbols. Inspected O2
Linux AMD64 and macOS ARM64 set-copy loops use eight-byte key spacing; the ARM
loop also uses paired vector copies for larger inputs. This establishes the
representation, not optimal register allocation or a speed advantage over C.
[PR #172](../roadmap-history.md#compact-set-storage-pr-172) records full production
acceptance, including WASI execution.

### Direct integer range sets

`range 0 n | set.from-list` builds the distinct integers from zero through
`n - 1`. Ordinary construction allocates a list and two scratch buffers before
the final set; direct construction writes already sorted keys into that set.
Both preserve the same values. [The design](../design.md#constructing-integer-range-sets-directly)
limits this transformation to inline integer ranges consumed immediately.

The [six-host report](range-sets-2026-10-19.json), measured at
`7901a576`, confirms these construction requests for 4,096 keys:

| Construction | Allocation requests | Total requested bytes | Final container bytes |
|---|---:|---:|---:|
| Ordinary list, scratch and set | 4,099 | 196,624 | 32,776 |
| Direct set | 1 | 32,776 | 32,776 |

These counts agree at O0/O2 in ARC and tracing modes on all six hosts. They exclude
startup/output, allocator headers and rounding; ARC charge returns to baseline
after releasing each result. Zero keys make no requests in either version.

The runner measurement compares the same fwp program with `FWP_MAP_BUILD=0/1`,
at 32, 4,096 and 65,536 keys. It hashes every key, checks output against raw
interpretation and records eight whole-process timing samples per version.
Construction, hashing, startup and output are included. Separate instrumented
executables count allocations and memory. This is fwp versus fwp, not a C/Rust
baseline. Timings use ARC/O2, Clang 18.1.3 on Linux, Apple Clang 17 on macOS and
Clang 23.1.3 on Windows. At 65,536 keys:

| Host / CPU | Ordinary median | Direct median | Direct / ordinary |
|---|---:|---:|---:|
| Linux AMD64 / Xeon 8573C | 6.389 ms | 2.515 ms | 0.394 |
| Linux ARM64 / Neoverse N2 | 5.190 ms | 1.788 ms | 0.345 |
| macOS ARM64 / virtual M1 | 6.084 ms | 3.660 ms | 0.602 |
| macOS AMD64 / i7-8700B | 19.501 ms | 10.608 ms | 0.544 |
| Windows AMD64 / EPYC 7763 | 17.768 ms | 13.373 ms | 0.753 |
| Windows ARM64 / Cobalt 100 | 17.450 ms | 14.505 ms | 0.831 |

Linux/macOS sample ranges are separated at this size; Windows ranges overlap.
At 32 keys, ratios span 0.945–1.047 with overlapping ranges, including four slower
medians. Do not generalize the larger-input gain to small programs. The
[earlier Linux run](range-sets-linux-2026-10-19.json) on an EPYC 7763
also had a slightly slower 32-key median.

Including output, 65,536 keys use 2 allocation requests / 524,322 requested bytes,
versus 65,540 requests / 3,145,770 bytes. Peak charged storage falls from 3,670,032
to 524,296 bytes. Both versions have zero measured retains, final charge and
collections. These are managed-storage counts, not process RAM.

All 264 focused tests passed with none ignored. The audit inspected 228 binaries,
including 48 range-set allocation probes. In O2 ARC probes, Linux AMD64 `e0`
uses packed integer addition and vector stores (`0x4b60` onward); ARM macOS `_e0`
uses vector addition and paired stores (`0x100002140` onward). Neither filling loop
calls a function or accesses the stack; scalar tails handle leftover keys.
The surrounding function still allocates and manages its result owner. This is
evidence for these loops, not universally optimal registers or zero heap use.
[PR #173](../roadmap-history.md#direct-integer-range-sets-pr-173) records passing
production and documentation checks for this change.

### Mapped lists: accepted earlier measurements

**Work:** construct a set or map from a range of integers reduced modulo 257,
so there are at most 257 distinct keys. The set prints its size; the map stores
the original integers and prints the last value for key 5. Duplicates keep the
last value. Inputs are compiled constants, including 32 and 65,536 elements.

**Comparison:** the same fwp compiler/program with `FWP_MAP_BUILD=0` versus `1`;
this is not C/Rust overhead. The [six-host report](collection-joined-storage-2026-10-18.json),
`b8700990`, includes direct known callbacks, eliminated temporary lists/tuples,
and joined key/value buffers. Checked ARC, native O2, no tracing/reuse poisoning.
Eight samples per variant use recorded randomized order. The whole-process timer
includes startup, callback work, construction, sorting, deduplication, final query
and output; compilation/profiling are separate. All 576 elapsed samples are saved.

For 65,536 inputs, ratio means optimized/ordinary elapsed median:

| Native host | Set: ordinary / optimized ms | Time ratio | Map: ordinary / optimized ms | Time ratio |
|---|---:|---:|---:|---:|
| Linux AMD64 | 7.319 / 3.788 | 0.518 | 9.512 / 3.983 | 0.419 |
| Linux ARM64 | 6.728 / 2.950 | 0.438 | 9.481 / 3.334 | 0.352 |
| macOS ARM64 | 9.646 / 6.677 | 0.692 | 10.402 / 8.009 | 0.770 |
| macOS AMD64 | 16.093 / 9.119 | 0.567 | 22.236 / 11.269 | 0.507 |
| Windows AMD64 | 17.129 / 13.772 | 0.804 | 20.067 / 14.200 | 0.708 |
| Windows ARM64 | 18.052 / 14.649 | 0.812 | 19.769 / 15.203 | 0.769 |

Set requests fall 131,077 → 4; map requests 196,614 → 5. Peak counted bytes fall
4,718,600 → 1,053,696 for sets and 6,815,752 → 2,102,272 for maps. Retains, final
charge and collections are zero. Counters exclude allocator capacity/process RAM.
At 32 inputs ratios span 0.861–1.078 with overlapping ranges: no consistent gain.
Temporary storage still grows with input length. The measured revision stored
unused value slots in final sets; the current compact-set change removes those
slots, but these historical timings do not measure that change. Small integers
still occupy full words. See the
[storage contract](../ownership.md#accepted-numeric-representation).

All 78 focused tests and 120 binary checks pass, including allocation failure,
callback error/cancellation and alias preservation. [PR #166](../roadmap-history.md#numeric-map-and-set-construction-pr-166)
records full acceptance. [Actual loop inspection](collection-set-code-2026-10-18.json)
finds SIMD on AMD64 and scalar pairs on ARM64, without calls/stack accesses in
the selected direct-call loops; entry frames and sorting still cost storage/work.

Earlier stages remain separately identified: [initial construction](collection-build-baseline-2026-10-18.json),
[map code](collection-build-code-2026-10-18.json),
[set buffers](collection-set-storage-2026-10-18.json), and
[direct calls](collection-build-direct-2026-10-18.json).
Their different-run absolute timings do not isolate each change's benefit.
Use `suite=collection-build`, then `collection-report` to audit its artifacts.

### Larger maps exposed a storage-layout problem

**Work:** the maintained map program builds 500,000 distinct entries and makes
two million queries. Keys are `(index * 7919) % 1000003`; input is scrambled,
then sorted. It prints the built size before querying. “Sorted pairs” in older
reports describes final storage, not presorted input.

**Comparisons:** construction off/on; separate versus joined key/value buffers;
and complete fwp/C/Rust implementations beside one another. Always name which
pair is being compared. The [initial report](large-map-construction-2026-10-18.json)
finds 1,500,009 → 8 allocation requests and 56,000,040 → 24,000,040 peak counted
bytes, but AMD64 traced elapsed time rises 8.3% for complete work and 36.4% for
construction-only work. Fewer allocations did not imply faster execution.

**Method:** ordinary complete-program and construction-only timers cover separate
whole processes. They cannot isolate query time by subtraction. Diagnostic builds
instead time actual construction/sort/query intervals inside the same program;
instrumentation changes code and is excluded from ordinary timings. Reports keep
raw samples, order, hardware, flags, binary hashes and separate profiles.
Joined/separate ordinary comparisons use 24 fresh processes per variant with
rotating order (six appearances in each position); phase diagnostics use 16.
Replays validate and rerun saved binaries without rebuilding, and retain their
own order/sample counts. Do not pool different CPUs or diagnostic/ordinary times.

The joined-layout repair puts related lanes in one allocation, including scratch,
and removes two requests. Results from controlled runs/replays:

| Evidence | Observation and limit |
|---|---|
| [First storage run](large-map-storage-2026-10-18.json) | Xeon 8573C sorts both layouts quickly, but joined full-work tracing is 4.6% slower. This host cannot verify the original slow EPYC sorting fix. |
| [Phase comparison](large-map-storage-phases-2026-10-18.json) | EPYC 9V74 old sorting takes 99–108 ms in slow cases; joined takes 14–22 ms across both observed address-bit values. Full-work joined/separate ratios: 0.905 tracing, 0.768 ARC. ARM64 ratios: 0.951/1.069, with broad overlapping ARC ranges. |
| [Two AMD64 repeats](large-map-storage-repeats-2026-10-18.json) | EPYC 7763 ratios 0.920/0.840; EPYC 9V45 1.007/0.990 with overlapping ranges. Neither answers the Xeon result. |
| [First four replays](large-map-replay-2026-10-18.json) | EPYC hosts: tracing 0.761–0.929, ARC 0.770–0.928. Construction gains repeat. |
| [Second four replays](large-map-replay-two-2026-10-18.json) | Xeon 8573C tracing slowdown repeats at 4.4%, despite faster construction. Instrumented phase timing changes the result; it does not invalidate the ordinary slowdown. |

The address correlation suggests a layout-sensitive sorting cost, not a proved
CPU-cache mechanism. Query/sort instructions match after resolving addresses;
identical instructions do not imply identical cache placement or time.

In the phase report's same-run complete-program comparison, fwp/C ratios are
0.918 tracing and 0.954 ARC on EPYC, 0.992/0.962 ARM64. Against Rust they are
1.110/1.154 and 1.073/1.041: **4–15% more time than Rust**. Different sorting
implementations and overflow rules remain; this is not isolated language overhead.

The six-host joined-layout run initially timed out rebuilding the compiler on
Intel macOS. Reusing the already-built integration-test compiler fixes that
redundancy without changing coverage or limits. Replacement `39108116774` passes;
[the report](collection-joined-storage-2026-10-18.json) audits all
120 binaries. PR #166 left the Xeon timing issue unresolved; the later
[matching-host comparison](numeric-collections.md#rechecking-the-original-xeon-slowdown) verifies its
repair in the combined compiler.

The PR #166 compiler makes 2,000,001 retains in this workload. A
[hand-edited borrowing prototype](large-map-borrow-prototype-2026-10-18.json)
is explicitly not compiler acceptance: Xeon 6973P-C combined tracing remains
1.4% slower than the old separate/retained layout. The actual compiler change
below replaces that experiment with a checked lifetime proof.
Integer-equality hoisting (8–9% slower on ARM64) and the earlier standalone split
initialization experiment (more code without a clear gain) were rejected.
Use `suite=large-map`, `map-storage` and `map-replay` for the storage comparisons.

### Compiler-proved cached map reads

**Comparison:** the saved `93cb93a0` compiler output, which retains the cached map
on every query, versus actual `774d838c` compiler output with proved borrowing.
[Five-host results](cached-map-borrows-2026-10-18.json) come from
[run 39112673197](https://github.com/e6qu/fun-with-pipes/actions/runs/39112673197).
This is fwp versus an earlier fwp compiler, not a C/Rust overhead measurement.

**Work and timing:** the same 500,000-entry map and two million queries described
above. For each revision, tracing/ARC and separate/joined layouts give eight
variants. The separate layout is an explicit measurement transformation of C;
the borrow comes from the compiler. All variants are compiled on the same host
with GCC 13.3, `-O2 -std=gnu11 -ffp-contract=off`, then run as 24 fresh processes
each in rotating order (three appearances per position). Wall time includes
startup, construction, queries, output and teardown; compiler build time is
excluded. Separate instrumented executions count allocations and retains and are
excluded from timing. Reports retain every sample, command, source/binary hash,
CPU description, section size and profile. Eighty ordinary/profile binaries were
audited across the five jobs.

On the joined layout, median borrowed/retained time ratios are 0.958–0.982:
**1.8–4.2% less elapsed time** on EPYC 7763, EPYC 9V45 and Neoverse N2.
Retains fall from 2,000,001 to 1; allocation requests and peak counted bytes are
unchanged, and final counted bytes remain zero. This removes bookkeeping rather
than map storage. These hosts do not establish an Intel result or resolve the
Xeon 8573C regression.

PR #167 integrated this compiler and also removed an unnecessary heap box when
returning a tuple or variant after the borrow. These prepared measurements predate
that repair. [Delivery history](../roadmap-history.md#interactive-tools-and-cached-map-borrows-pr-167)
records production acceptance; the later matching-host measurements below cover
the integrated compiler. Reproduce with `suite=map-borrow`, `evidence_run=39106005017`, and
`source_revision=93cb93a0f717b317814ecfc162de0c2f516dbfbd`; the workflow compiles the
current branch and uses the saved baseline sources, checking identical inputs,
outputs, counts and binary identities before recording times.


The [integrated compiler results](cached-map-integrated-2026-10-18.json)
from [run 39125883230](https://github.com/e6qu/fun-with-pipes/actions/runs/39125883230)
use `085626f3`, including the direct-result repair. The same protocol above yielded
60 passing focused checks and 80 audited executable/profile records. This adds
Intel evidence, without substituting a different processor for the original
Xeon 8573C regression.

Each ratio is new elapsed time divided by the named baseline time; below 1 is
faster. “Joined” keeps both revisions' map layout joined and isolates borrowing.
“Combined” compares joined/borrowed against separate/retained, so includes both
changes. “Separate” isolates borrowing with the older separate layout.

| CPU / sample | Tracing joined | ARC joined | Tracing combined | ARC combined | Tracing separate |
|---|---:|---:|---:|---:|---:|
| AMD EPYC 7763 64-Core Processor / 2 | 0.9638 | 0.9686 | 0.8868 | 0.7518 | 1.0647 |
| AMD EPYC 7763 64-Core Processor / 4 | 0.9571 | 0.9641 | 0.7957 | 0.7361 | 0.8793 |
| Intel(R) Xeon(R) 6973P-C / 1 | 0.9357 | 0.9376 | 0.9688 | 0.9305 | 1.0387 |
| Intel(R) Xeon(R) Platinum 8370C CPU @ 2.80GHz / 3 | 0.9170 | 0.8835 | 0.9685 | 0.9034 | 1.0630 |
| Neoverse-N2 / 1 | 0.9801 | 0.9601 | 0.9562 | 0.9609 | 0.9319 |

The joined tracing medians on Xeon 8370C fell from 381.575 to 349.890 ms,
and on Xeon 6973P-C from 405.236 to 379.191 ms. Retains again fall from
2,000,001 to 1, with unchanged allocation requests, peak charged memory and
zero final charge. Separate-layout tracing borrowing is slower on both Intel
samples and one EPYC sample. Count savings therefore do not establish a general
timing win. That run did not include the original Xeon 8573C. The matching-host result
below completes this specific comparison.


### Rechecking the original Xeon slowdown

[Run 39128516933](https://github.com/e6qu/fun-with-pipes/actions/runs/39128516933)
measured actual compiler `e1fb8ba3` with the same program, toolchain flags,
24-sample rotating order, timing boundary and saved baseline described above.
The [raw reports](cached-map-xeon-2026-10-18.json) retain all samples,
binary/source hashes, compiler commands, section sizes and allocation profiles.
All five jobs passed 12 focused checks each; 80 ordinary/profile binaries were
audited. This run includes the **Xeon Platinum 8573C** from the original regression.

On that processor, retained joined storage took **392.915 ms** versus
**376.889 ms** for retained separate storage: the old slowdown reproduced at
**4.25%**. Compiler-proved borrowing with joined storage took **366.810 ms**:
**6.64% less time** than retained joined storage and **2.67% less** than the old
separate-storage baseline. This resolves the measured full-map regression for
this program on the named model. It does not prove every map shape or processor
benefits, nor identify a single microarchitectural cause for the old penalty.

The same ratios used in the preceding table remain below 1 when faster:

| CPU / sample | Tracing joined | ARC joined | Tracing combined | ARC combined | Tracing separate | ARC separate |
|---|---:|---:|---:|---:|---:|---:|
| AMD EPYC 7763 64-Core Processor / 1 | 0.9607 | 0.9650 | 0.7349 | 0.8797 | 0.8118 | 1.1570 |
| AMD EPYC 7763 64-Core Processor / 4 | 0.9689 | 0.9619 | 0.7341 | 0.8967 | 0.8879 | 0.9855 |
| AMD EPYC 9V45 96-Core Processor / 3 | 0.9639 | 0.9738 | 0.9664 | 0.9528 | 0.9842 | 0.9555 |
| INTEL(R) XEON(R) PLATINUM 8573C / 2 | 0.9336 | 0.9288 | 0.9733 | 0.9336 | 1.0468 | 0.9461 |
| Neoverse-N2 / 1 | 0.9849 | 0.9864 | 0.9880 | 1.0174 | 0.9566 | 1.0313 |

Borrowing improves the maintained joined layout in both memory modes on every
host in this run. Some comparisons with the older separate layout are slower:
Xeon separate/tracing is 4.68% slower, one EPYC separate/ARC sample is 15.70%
slower, and Neoverse combined/ARC is 1.74% slower. Preserve those distinctions:
the change removes repeated ownership bookkeeping, not every layout/cache cost.
Retains fall from 2,000,001 to 1 with unchanged allocations, peak charged bytes,
and zero final charge. These are fwp revision comparisons; they say nothing by
themselves about remaining overhead against equivalent C or Rust.

Resampling the same 24 Xeon rounds 10,000 times gives a 95% percentile interval
of **0.9659–0.9882** for the combined new/old median-time ratio. Each resample
keeps the paired variants from a round together. This estimates uncertainty
within this runner's sample; it does not cover differences between machines or
future runs. The raw report records the seed, method and intervals for all three
Xeon comparisons. The old slowdown's interval remains above one, and the new
program's interval below one.

A repeat at `f957980a`, [run 39129855448](https://github.com/e6qu/fun-with-pipes/actions/runs/39129855448),
passed all five jobs and 60 focused checks. All 80 ordinary/profile binaries and
their generated C match the earlier same-architecture artifacts byte for byte.
Two further Xeon 8573C samples put the joined-borrowed/old-separate tracing ratio
at **0.9731** and **0.9702**: 2.69% and 2.98% less process time. This repeats the
named repair with identical machine code, rather than measuring another compiler
optimization. [All repeat samples and profiles](cached-map-repeat-2026-10-18.json)
are retained. Joined borrowing is faster in both modes on all five samples;
separate-layout borrowing remains slower on both Xeon tracing samples (4.83%
and 3.65%) and EPYC 9V74 tracing/ARC (8.29% and 4.65%).
