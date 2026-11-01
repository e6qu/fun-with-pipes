# Proved integer bounds: no accepted speedup

**Both compiler changes were rejected.** Their arithmetic is correct, but neither
meets the performance rules frozen before the experiment. The compiler keeps its
existing checked additions. New boundary tests and the complete measurements
remain. [Later decimal-count work](decimal-count.md) records a different accepted
implementation; it does not change the rejection of these two candidates.

## What we tested

Two additions introduced by the compiler already have bounds that exclude overflow:

- A fused `range start end` advances only while `position < end`. Since `end`
  fits the integer type, `position + 1 <= end` fits too. Equal or descending
  endpoints do not advance.
- The compiler can count immediately discarded integer text without building a
  String. It already proves every partial character sum fits I64. For example,
  two I64 displays and `"#"` need at most `20 + 20 + 1` characters.

We tested using existing wrapping addition for these operations. Under the proofs,
wrapping never occurs. User callbacks, accumulators and arithmetic producing a
displayed integer stayed checked. This differs from the earlier
[rejected change to ordinary checked arithmetic](checked-bounds-results.md).

Four compilers were built from Rust source: unchanged, range-index change only,
character-sum change only, and both. No older fwp executable was a build dependency.
The baseline is `ec03d9cd81c001bf006a73e7dbfb044155884611`; experiment source is
`08039d8698743116c31cc0b8929e705c3562f833`. Only `src/fuse.rs` and
`src/cgen/scalar_text.rs` differ in compiler/runtime/library sources. Each variant
retains its exact patch, source hashes, compiler image and generated programs.
Nested benchmark reports name the harness checkout; the enclosing manifest names
the compiler sources actually built.

## Work, timing and decision rule

The programs and checked C/Rust peers are unchanged from the
[CPU baseline](cpu-baselines.md):

- `loop` performs 100 million countdown iterations, checked product/remainder/sum,
  and prints `300000003`.
- `text-length` counts decimal characters for two million indices: digits of `i`,
  digits of `3*i`, and one separator. It prints `28518516`. All peers use the same
  grouped digit-counting algorithm; they do not retain formatted text.

Each job runs C, Rust, the four fwp variants and the unchanged fwp image again as a
noise control. Two warmup batches precede 56 measured batches, rotating order so
each variant occupies every position eight times. A loop batch is one fresh
process; a text batch is 32 fresh processes with unchanged inputs. Every process's
status, stdout, stderr and elapsed time is retained and checked. No sample is dropped.

Timers include process startup, calculation, output and cleanup. Builds, evidence
writes and separate memory profiling are excluded. Linux uses four available CPUs,
without pinning or a frequency claim; fwp and C use GCC O2 without LTO, and Rust
uses `rustc --edition=2021 -O`. ARM64 is Neoverse-N2/GCC 13.3.0; AMD64 is EPYC
7763/GCC 15.2.0. Both use Rust 1.99.1. Exact flags/versions remain in the raw records.

The fixed rules require a character-count improvement and no loop/text regression
on both hosts, with a stable identical-code control. They prefer range-only,
then character-sum-only, then both. Character counting needs more than about 4.8%
less time on ARM64 and 9.5% on AMD64. These are empirical limits, not statistical
confidence guarantees. Smaller code alone does not establish a speedup.

## Results

Median batch milliseconds; **text rows contain 32 processes**, while loop rows
contain one. Candidate columns correspond to the isolated changes above.

| Host/program | C | Rust | Unchanged fwp | Range only | Character sum only | Both | Identical control |
|---|---:|---:|---:|---:|---:|---:|---:|
| ARM64 loop | 176.552 | 114.144 | 130.603 | 130.743 | 130.710 | 130.667 | 130.652 |
| ARM64 text | 103.211 | 187.028 | 200.890 | 200.055 | 200.415 | 197.377 | 201.066 |
| AMD64 loop | 126.723 | 106.890 | 149.113 | 149.469 | 149.506 | 149.317 | 149.535 |
| AMD64 text | 113.777 | 215.200 | 242.982 | 242.066 | 242.532 | 241.094 | 243.112 |

Neither host's character-count result meets the improvement rule: the best observed
reduction is 1.75% on ARM64 and 0.78% on AMD64. The unchanged fwp loop remains
14.4% slower than Rust on ARM64 and 39.5% slower on AMD64. Character counting
remains 94.6% slower than C on ARM64 and 113.6% slower on AMD64. These ratios
compare complete programs; they do not isolate a particular language cost.

Both ARM64 controls and AMD64 text are stable. AMD64 loop is **inconclusive**:
its paired 95th-percentile ratio is 1.021566, above the frozen 1.018789 control
limit. That row remains visible and cannot establish a regression pass. No rerun
or weaker limit is needed to reject these candidates: neither stable text row
meets the improvement requirement.

The seven-program suite also ran for every compiler. Its six-sample observations
were collected sequentially by variant, not as the 56-batch candidate comparison.
They are context, not accepted speedup/regression measurements. Ratios below are
candidate fwp time divided by unchanged fwp time; above 1 means more time.

| Host/program | Unchanged ms | Range ratio | Character-sum ratio | Both ratio |
|---|---:|---:|---:|---:|
| ARM64 fib | 6.908 | 1.004 | 1.005 | 0.997 |
| ARM64 loop | 130.373 | 1.001 | 1.001 | 1.003 |
| ARM64 map | 464.456 | 1.011 | 0.996 | 1.001 |
| ARM64 pipeline | 15.825 | 1.002 | 1.003 | 0.995 |
| ARM64 range-set | 11.784 | 1.004 | 1.021 | 1.058 |
| ARM64 strings | 6.237 | 1.004 | 1.006 | 0.994 |
| ARM64 text-length | 6.069 | 1.004 | 1.005 | 0.966 |
| AMD64 fib | 15.272 | 0.941 | 0.931 | 0.896 |
| AMD64 loop | 148.921 | 1.005 | 0.999 | 1.002 |
| AMD64 map | 355.646 | 0.980 | 0.990 | 0.992 |
| AMD64 pipeline | 13.388 | 1.030 | 1.049 | 0.973 |
| AMD64 range-set | 16.161 | 1.026 | 1.047 | 1.025 |
| AMD64 strings | 7.837 | 1.011 | 1.003 | 1.001 |
| AMD64 text-length | 7.470 | 1.016 | 0.975 | 0.964 |

## Code, stack and memory

Every loop variant has identical executable-code bytes on its architecture:
10,316 bytes on ARM64 and 11,058 on AMD64. Text code differs: all ARM64 images
have 11,116 bytes; AMD64 shrinks from 11,954 to 11,906 for each candidate.
The 48-byte reduction does not justify an execution-speed claim. Whole image
sizes remain unchanged: loop/text are 74,840/74,960 bytes on ARM64 and
36,784/36,904 on AMD64. Code-section hashes are retained in the artifact records.

Separate instrumented builds report unchanged stack frames for every variant.
`main` uses 160 bytes on ARM64 and 128 on AMD64; the language-entry worker uses
320/288 bytes for ARM64 loop/text and 288/256 for AMD64. These are compiler frame
reports for instrumented builds, not high-water measurements of the timed images.

Both programs retain zero managed allocation requests, bytes, effective retains,
peak charge and final charge in every ordinary profile. Each intentional leak
adds one 16-byte allocation and leaves nonzero final charge, so the observer can
detect missing cleanup. Whole-process fwp RSS spans 1,272–1,656 KiB on ARM64 and
2,068–2,200 KiB on AMD64. RSS includes runtime, stack and allocator costs outside
managed counts. All three samples and C/Rust RSS observations remain in the archive.

## Verification and retained evidence

All four compilers pass the six `integer_output` test groups on each host:
runtime endpoints near both limits of all twelve integer types; empty/descending
ranges; raw and optimized interpretation; native O0/O1/O2/O3; and callback, fold
and pre-display overflow. Existing width, Unicode, sharing, effect-order, output
and allocation controls also pass. These focused tests do not replace final
production acceptance of the retained tests and documentation.

[ARM64 run](https://github.com/e6qu/fun-with-pipes/actions/runs/40786050786) and
[AMD64 retry](https://github.com/e6qu/fun-with-pipes/actions/runs/40786537977)
retain all compiler images, C files, actual timed binaries, peer controls and logs.
The first run's AMD64 job received Xeon 6973P-C, rejected it before candidate
execution and retained its empty timing record. It is not a passing measurement.
Both qualified jobs pass. Independent review checks full source patches/hashes,
all 168 peer images, 112 separately instrumented images, memory/stack records,
every timing observation and the complete test logs. No compiler diagnostic or
failed test target remains in those jobs.

- [ARM64 observations](scalar-bounds-2026-10-29-arm.json)
- [AMD64 observations](scalar-bounds-2026-10-29-amd.json)
- [Unqualified host record](scalar-bounds-2026-10-29-unqualified.json)
- [Original peer, memory and code-section records](scalar-bounds-artifacts-2026-10-29.json)

[scripts/scalar-bounds.py](../../scripts/scalar-bounds.py) recomputes decisions,
checks compiler-source identities and links the archived reports by hash. CI also
runs deliberately incomplete, corrupted, noisy and wrong-host controls. This
checks retained records; it does not rebuild or re-execute the archived binaries.
The closed runner is preserved at its
[original source](https://github.com/e6qu/fun-with-pipes/blob/08039d8698743116c31cc0b8929e705c3562f833/scripts/scalar-bounds.py);
its workflow option is removed rather than left as a command that targets reverted
compiler code. The next P2 experiment must separate runtime setup, calculation,
output and cleanup before choosing another source change.
