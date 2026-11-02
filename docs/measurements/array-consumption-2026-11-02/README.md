# Does preparation change array-reduction timings?

All four native sessions and their complete archives are audited. Preparation
changes startup-sensitive costs, especially construction. It does **not** resolve
the original AMD64 consumption regression. The [protocol](../array-consumption-setup.md)
was frozen before implementation and measurements.

## What runs

The two programs are **current fwp** and **the same fwp source with direct numeric
array callbacks disabled**. Both use the same runtime and reduction. This is not
a C/Rust/Swift comparison and does not establish parity with those languages.

[The original fwp program](../../../tests/fixtures/array_construction_costs.fwp)
builds an array and reduces it:

```fwp
make-input = fn round -> fn count ->
    array.generate count (fn index ->
        (index + round) % 19 - 9 | int.to-float | div 4.0)

reduce64 = array.map (mul 3.0) | array.map (add 1.0) | array.fold add -0.0
```

- `make-input 0 3` produces `array[-2.25, -2.0, -1.75]`.
- `reduce64` multiplies each element by 3, adds 1, then sums in order. For that
  example the terms are −5.75, −5 and −4.25, so the result is −15.
- The measured inputs contain **65,537 or 262,145 F64 elements**. Each sample builds
  and consumes eight arrays, using rounds 0 through 7. The compiler combines the
  two maps with the fold; consumption allocates no intermediate array.

Each executable accepts exactly `0` or `1024` preparation reductions. Preparation
builds one array using the same C-driver loop in both programs, retains a caller
alias before each consuming reduction, checks every result, then releases the
last alias. Its work is outside the workload timers. Zero preparation and prepared
runs use the **same binary**; each program also has a byte-identical independent copy.

## Timing and controls

| Setting | Fixed choice |
|---|---|
| ARM64 | Neoverse N2, GCC 13.3, `-march=armv8-a` |
| AMD64 | EPYC 7763, GCC 15.2, `-march=x86-64` |
| C flags | O2, GNU C11, `-ffp-contract=off`, no LTO, reuse enabled |
| Host/processes | Four available CPUs; processes run serially |
| Sessions | Two per architecture; every CPU rejection retained |
| Schedule | Two warmup rounds, 16 measured rounds, four fresh processes per role/round |
| Inside a process | Five samples; eight construct/consume/release operations per sample |
| Roles | Current/reference × ordinary/identical copy × preparation 0/1,024 |

Construction wall time covers array allocation and filling. Consumption wall time
covers the unchanged reduction and its release of the array. The enclosing work
timer includes both, result hashing and added clock reads; it excludes process
launch, preparation and JSON output between samples. CPU observations wrap each
consumption interval and include the enclosed wall-clock reads. Page faults and
context switches cover each whole sample, not only reduction.

An empty-clock control records observation overhead separately; nothing is
subtracted. Because the new observations change the executable, even the
zero-preparation case is **not an exact replay of the original timing binary**.

For each role, a complete measured round contains 160 arrays: four processes ×
five samples × eight arrays. Ratios compare medians of the 16 complete-round totals.
A prepared/unprepared ratio of 0.97 means 3% less time. Copy spread is the larger
copy total divided by the smaller one, minus 1. Every early sample remains in the
calculation; within-process first-minus-last differences are also retained.

Before timing, both programs/sizes/settings must pass exact-bit results, ownership
profiles, omitted-preparation-release and failed-clock controls. The independent
full audit reconstructs generated C and checks every source, command, binary
identity, raw output and summary. [The earlier harness repair](../array-consumption-setup.md#harness-repair-before-timing)
retains both failed runs; neither reached timing.

## Results and limits

The table shows **less time with preparation**, for both byte-identical copies
of current fwp. Ranges retain their separate outcomes; they are not confidence
intervals. The copy columns show the worst spread across both programs and all
four recorded timing metrics in that session/case.

| Host / session | Elements | Construction | Consumption | Enclosing work | Worst copy spread: 0 / 1,024 preparation |
|---|---:|---:|---:|---:|---:|
| ARM64 1 | 65,537 | 3.41–3.56% | 0.92–1.00% | 2.94–3.06% | 0.53% / 1.51% |
| ARM64 2 | 65,537 | 3.37–3.39% | 0.69–0.76% | 2.74–2.80% | 0.74% / 1.51% |
| ARM64 1 | 262,145 | 3.03–3.05% | 0.28–0.48% | 2.50–2.52% | 0.20% / 0.13% |
| ARM64 2 | 262,145 | 2.68–2.82% | 0.26–0.38% | 2.19–2.33% | 0.67% / 0.43% |
| AMD64 1 | 65,537 | 14.05–21.98% | 2.15–2.30% | 12.99–17.46% | 10.02% / 0.18% |
| AMD64 2 | 65,537 | 20.25–23.85% | 1.86–2.31% | 15.80–18.91% | 4.84% / 0.13% |
| AMD64 1 | 262,145 | 6.05–8.40% | 0.57–0.78% | 4.73–6.31% | 2.65% / 0.08% |
| AMD64 2 | 262,145 | 9.10–9.67% | 0.49–0.57% | 6.78–7.35% | 0.60% / 0.08% |

For example, AMD64 session 1's large-array current program has median consumption
samples of **251.99, 248.07, 247.19, 246.06, 245.80 µs/array** without preparation,
and **246.12, 245.72, 246.72, 246.12, 245.87** with preparation. The difference is
mostly early, but it is smaller than in the original experiment. The reference
also has an early penalty in this diagnostic.

Preparation changes more than CPU activity: it allocates and touches an array,
then returns it to the allocator before timing. Median minor page faults per
complete round fall from **520 to 0** for the small input and **2,056 to 0** for
the large input, in every session/role. Minor faults do not require disk I/O.
Median major faults and voluntary context switches are zero; involuntary switches
range from 0 to 7.5 per round. These observations show that preparation moves
page-fault work outside the timer; they do not quantify how much time that saves
or establish a CPU-frequency/cache cause.

Empty wall-clock pairs average 27–33 ns; the enclosing process-CPU pairs average
378–661 ns. The CPU interval includes the inner wall-clock pair. Both overheads
remain included where applicable; CPU and wall values are not interchangeable.

**Decision:** retain the diagnostic, with every original failed limit open. No
compiler/runtime repair is justified by this experiment. The new observations
and preparation call site also change compilation context even when preparation
is zero. The next bounded investigation must compare the retained original driver,
an observation-only driver with no preparation call site, and this driver at zero
preparation, before assigning the original difference to startup or emitted code.
Freeze that comparison before running it; do not rerun these completed sessions
or add hidden warming to production benchmarks.

The [original regression and copy failures](../scalar-array-captures-2026-11-02/README.md)
remain the acceptance record. Prepared results do not replace them. The
[complete 64-role table](all-roles.csv) includes current/reference, both copies,
both settings and both sessions, including absolute times and memory observations.

## Storage and retained evidence

Preparation allocates one `8 × elements + 8` byte array when enabled, performs
1,024 retains and 1,024 non-final releases, then leaves zero live charged storage.
The counter records 1,024 reduction release checks; final caller destruction uses
a different function. Each measured sample allocates eight arrays, with zero
retains/non-final releases and one final release check per array. Only one array
is live at a time. Allocation counts come from separate instrumented runs.

The report also records allocator chunk high-water storage and reserved virtual
address space. Neither is process RAM. GNU `time -v` measures peak process RSS
once per role/setting, including preparation; it is not a median or an allocation
count. Instruction bytes are the executable's `.text` sections. Main-frame stack
bytes are compiler estimates, not maximum whole-program stack use.

[Index and exact source/artifact identities](index.json) link every completed
session and rejected host. Compressed reports retain all observations; `*-raw.zip`
files retain command outputs and round records; file manifests bind omitted C,
executable and original-input files to their audited complete archives. Full job
logs and original eight failed timing limits remain available through the index.

### Memory and generated-program costs

The table spans both sessions, both programs/copies and both preparation settings.
It reports the diagnostic executables, which include the added observations and
preparation code; these are not new production code-size claims.

| Host / elements | Peak RSS, MiB | Instruction bytes | Main-frame bytes | Chunk high water |
|---|---:|---:|---:|---:|
| ARM64 / 65,537 | 2.24–2.31 | 62,332–62,444 | 736–768, static | 589,824 B |
| ARM64 / 262,145 | 3.74–3.81 | 62,444–62,460 | 736–768, static | 2,162,688 B |
| AMD64 / 65,537 | 2.59–2.84 | 68,418–68,546 | 752–768, dynamic/bounded | 589,824 B |
| AMD64 / 262,145 | 4.09–4.34 | 68,418–68,546 | 752–768, dynamic/bounded | 2,162,688 B |

Peak live charged array storage is 524,304 / 2,097,168 bytes for the two sizes;
final live charge is zero. Reserved virtual space is 68,761,485,312 bytes in every
profile; this is address-space reservation, not resident memory. Preparation does
not increase the measured workload's allocation or ownership budgets. RSS may
still change: for AMD64 small arrays its observed range is 2.59–2.78 MiB without
preparation and 2.71–2.84 MiB with it.

### Source, sessions and replay

Source `87d4f6b099b755a52cd091b6c07cb57bb456af77`, tag
`roadmap/array-consumption-control-repair-2026-11-02`:

| Session | Run / job | Artifact | Independent full audit |
|---|---|---|---|
| ARM64 1 | `41472025679` / `125367826083` | `13154414998` | Pass, 1.93s |
| ARM64 2 | `41472025679` / `125367826052` | `13155741912` | Pass, 1.88s |
| AMD64 1 | `41472493298` / `125369442114` | `13157230350` | Pass, 1.76s |
| AMD64 2 | `41475998964` / `125381620085` | `13156803999` | Pass, 1.89s |

Seven rejected CPU assignments stopped before compilation; all reports/logs are
retained. No completed timing was retried. Recompute every retained raw sample,
profile and table with:

```sh
python3 scripts/local-guard.py python3 scripts/check-array-consumption-records.py \
  --directory docs/measurements/array-consumption-2026-11-02 --mode check
```

The compact replay checks saved outputs and table consistency. The separately
recorded full-archive audit also verifies generated C, executable identities and
the original input archive; compact replay does not replace that audit.
