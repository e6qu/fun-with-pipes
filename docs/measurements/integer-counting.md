# Count integer characters with less arithmetic

`show | string.length` counts an integer's displayed characters without building
a string. For example, `-123456` has seven characters, including its minus sign.
The runtime now counts digits in groups of 16, 8, 4, 2 and 1. Dividing `123456`
by 10,000 removes four digits and leaves `12`; one further comparison gives six
digits.

Signed values use unsigned magnitude and add the sign, so I64's minimum
does not require an overflowing signed negation. There is no lookup table or
new heap storage. Ordinary inline hints let the C compiler combine this work
with its caller; they do not force inlining.

The measured program uses roughly half its former CPU time on the two hosts
below. Matched C/Rust implementations remain faster. This is a specific program
comparison, not universal language overhead or completion of the performance
roadmap. [PR #182's delivery record](../roadmap-history.md#grouped-integer-counting-and-u32-overflow-pr-182)
records passing full native acceptance. The subsequent [checked-product change](checked-products.md)
has separate measurements and acceptance status.

## Program and results

`bench/text-length` sums the characters in `i`, `3*i` and one separator for
`0 <= i < 2000000`, then prints `28518516`. All three implementations check the
relevant multiplication and additions. Timed values are nonnegative and at most
5,999,997; correctness tests cover negative and wider values too, but this timing
does not establish their performance. The `strings` peers still format strings
and therefore perform different work.

Source `a8859db10f34df4450eb608c4666785ebc5ae816`, preserved by
`roadmap/revision-integer-matched-a8859db1`, passes
[run 39528239204](https://github.com/e6qu/fun-with-pipes/actions/runs/39528239204).
Each native Linux job passes all five integer tests, inspects twelve binaries and
runs the comparison below. Every complete log is audited clean. GCC 13.3.0 builds
C/fwp at O2; Rust 1.99.1 uses `-O`. fwp uses tracing mode without link-time
optimization. The hosts are Xeon Platinum 8573C and Neoverse-N2, with four allowed
CPU IDs per runner. These are two runner sessions, not eight independent machines.

The table gives the range of four per-CPU **elapsed-time medians**, in milliseconds.
C and Rust use the same grouped algorithm as fwp and ordinary inline hints.

| Host | Matched C | Matched Rust | fwp | Extra fwp time versus C | Extra versus Rust |
|---|---:|---:|---:|---:|---:|
| AMD64, Xeon 8573C | 3.924–3.938 | 5.121–5.135 | 6.054–6.255 | +54.0–59.4% | +17.9–21.9% |
| ARM64, Neoverse-N2 | 3.304–3.331 | 5.862–5.934 | 7.517–7.595 | +127.5–128.5% | +27.9–28.2% |

Extra time is `(fwp / peer - 1) * 100%`, computed separately on each CPU. Child
CPU medians also remain higher: **+56.7–62.5% / +18.2–22.9%** versus C/Rust on
Xeon, and **+142.2–142.9% / +29.5–30.1%** on N2. These gaps must not be replaced
with comparisons against the slower old algorithms.

Against an unchanged fwp rebuild on the same CPUs, the new version uses
**47.5–49.0% less child CPU time on Xeon** and **48.6–48.9% less on N2**. Removing
only its inline hints makes it slower: the hints save about 49–50.5% on Xeon and
40.5–40.8% on N2 relative to that control. The unhinted version itself is slightly
slower than old fwp on this Xeon; grouped counting alone is not a uniform win.
[Every sample and ratio](integer-counting-matched-2026-10-21.json) is retained.

## What the timer includes

Eight executables run on each allowed CPU separately:

| Executable | Purpose |
|---|---|
| Saved C / Rust | Earlier one-digit-at-a-time comparisons; algorithm changes contribute to these ratios. |
| Saved fwp | Repeat the exact earlier binary. |
| Rebuilt fwp | Compile unchanged saved generated C, to expose rebuild differences. |
| Candidate fwp | Replace only its integer-counting helpers. |
| Matched C / Rust | Handwritten grouped counting with ordinary inline hints. |
| Grouped fwp without hints | Remove only the candidate's two inline hints. |

`scripts/measure-integer-counting.py` verifies the successful source run, inputs,
saved benchmark samples and executable architectures. All fwp rebuilds use GCC
`-O2 -std=gnu11 -ffp-contract=off`, without LTO. Matched C uses GCC `-O2`;
matched Rust uses `rustc -O`. Commands, tools, source/binary hashes and complete
disassembly accompany the results. The unchanged rebuild's instruction-section
hash matches the saved fwp binary on both hosts.

The workflow explicitly selects each allowed CPU in turn. The Python parent and
its children share that CPU restriction; no extra launcher runs inside the timer.
The original CPU set is restored afterward. Address randomization is recorded and
left unchanged. After two warmups per executable, 48 rounds rotate and reverse
order, balancing each executable's position. Every output must match.

Each sample records elapsed time and child user plus system CPU time, including
startup, computation, output and shutdown. Elapsed time includes Python's process
launch; child CPU excludes the parent's work and descheduling. Compilation,
downloads, inspection and instrumentation are outside timing. No sample is
discarded. Pinning does not control clock frequency, virtualization, caches or
process address layout, and does not explain historical timing variation.

## Instructions, storage and remaining work

The inspected fwp hot loops contain no calls or stack loads/stores on either host;
all per-iteration values remain in registers. Without the hints, each iteration
called the counting helper twice. The selected AMD64 function saves four registers
and reserves eight bytes once on entry: a 40-byte frame excluding the return
address, versus no normal-path frame in old fwp. ARM64 still has no normal-path
frame; its overflow path saves 16 bytes. These are fixed costs, not per-item heap
storage or growing recursion.

| Host | Old fwp text-section bytes | New text-section bytes | Old whole file | New whole file |
|---|---:|---:|---:|---:|
| AMD64 | 25,218 | 25,586 (+368) | 61,800 | 61,776 |
| ARM64 | 22,908 | 23,356 (+448) | 83,432 | 83,432 |

Text-section bytes are the ELF `.text` section, including compiler padding. Whole-file sizes also reflect
symbols, metadata and alignment; their changes do not measure instruction cost.
The matched C/Rust instruction sections are 585/242,195 bytes on AMD64 and
600/218,876 on ARM64. These include each program's linked/runtime choices, not
just the counting loop.

Separate instrumented fwp rebuilds report zero managed allocations, requested
bytes, retains, collections and peak/final charged storage after constant
initialization. A deliberate 16-byte allocation is detected. The counters exclude
raw buffers, allocator metadata, stacks and libc; they do not mean zero process
memory or removal of tracing. The instrumented executables are never timed.
Earlier [process-memory measurements](integer-text.md) remain historical evidence;
this experiment does not claim a new RSS improvement.

The C loop uses its numeric bounds to eliminate impossible cases and replace
some digit counting with comparisons and constants. fwp still computes the sign
and tests large-number cases for `3*i`, despite the bounded source input. That is
an observed instruction difference; its share of the timing gap is not isolated.
The subsequent [checked-product experiment](checked-products.md) preserves more
numeric-range information through generated C without weakening checked arithmetic
or trap order. Its results and lower-optimization costs are recorded separately;
the numbers on this page describe the earlier grouped-counting change.

## Correctness and earlier experiments

At the measured revision, `tests/integer_output.rs` compared unoptimized
interpretation and native execution at O0/O2 in ARC and tracing modes.
Inputs include signed/unsigned extremes and
values immediately before, at and after every representable power of ten, with
both signs for signed cases. Binary I64 payloads are independently checked against
Rust decimal-format lengths.

Other cases preserve Unicode lengths, shared
strings, effects, trap order and output-protocol separation. Allocation controls
must detect deliberately inserted storage requests. The artifact audit verifies
all 24 native executables across both hosts, their C, disassembly and controls.
The current tests retain those inputs and allocation controls in one counted
runtime: six binaries per host.

That migration passed integrated validation in
[#217](../roadmap-history.md#tracing-gc-removal-pr-217). These checks do not remeasure
the historical timing samples.

A shared-loop candidate (`995d3ecf`, run `39525618134`) was not selected: CPU
medians were 1–4% higher on EPYC 9V74 and 2–3% higher on N2 than unchanged fwp.
Its [complete samples](integer-counting-loop-2026-10-21.json) remain available.
Unhinted grouping (`58520171`, run `39526333980`) saved 16–19% on EPYC 9V74 and
13–14% on N2 in those sessions; its [samples](integer-counting-groups-2026-10-21.json)
are also retained, alongside the later, slower Xeon result.

Both preparations'
focused test runs exposed the new test's binary-versus-text assertion mistake
and consequent missing artifacts. All failed targets were audited; the repaired
protocol assertion and complete binary inspection pass in the selected run above.

Reproduce historical artifact checks with `scripts/summarize-integer-counting.py`
from the recorded revision, supplying
the full run/source, artifact directory, output path and explicit comparison mode:
`legacy` for the first two experiments, `matched` for the selected eight-way run.
