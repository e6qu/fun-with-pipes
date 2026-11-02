# Array construction: driver versus fwp source

## Question

The [current array comparison](current-kernel-costs.md#results-november-2-2026)
finds 24–31% more ARM64 allocation-through-cleanup time than C, although the
map/reduce timer takes 2–7% less. Its input is built by a C driver calling fwp's
runtime. It does not measure a program that calls `array.generate`.

Compare those two construction paths before choosing a compiler change. The
existing reduction timer includes the input's final release; subtracting it from
the inclusive timer does not isolate the allocator. Construction, filling,
checksum and timer overhead remain mixed.

## Diagnostic results: November 2, 2026

[Both native jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/41427397530)
pass at `d3ddc94d`: GCC 13.3 ARM64 and GCC 15.2 AMD64, O1 and O2. Each build
checks 144 count/round/path combinations. Ordinary and profiled results agree,
small interpreter cases pass, and omitted-release controls exit 219 as intended.
[The retained index](array-construction-2026-11-02/index.json) includes complete
logs, exact C, optimized GCC source, binaries, stack estimates and file hashes.
Both full logs and every recorded file identity were audited.

| Path | Workload allocations | Requested bytes | Effective retains | Final live charge |
|---|---:|---:|---:|---:|
| C driver builds an array, then compiled reduction consumes it | 1 | `8 + 8 * count` | 0 | 0 |
| Compiled `make-input`, then the same reduction consumes it | 1 | `8 + 8 * count` | 0 | 0 |
| Source `make-input round count` piped directly into `reduce64` | 0 | 0 | 0 | 0 |

This holds for all six counts, including zero, on both compilers/optimization
levels. The eight extra requested bytes are the materialized fwp array header.
These workload counters exclude runtime initialization and do not measure total
process RSS. The composed source is already fused: generated `w2` computes the
result in a loop without constructing an array. It does less memory work than
the materialized benchmark; the older inclusive ratio is not its performance.

The materialized source still has a stack closure and generic callback dispatch.
GCC's optimized source for `w0` retains `fwp_apply_borrowed_span` in its generation
loop. `Gen::array_callback` currently specializes uncaptured callbacks or captures
that need reference counting; all-scalar captures do not satisfy that predicate.
This is a concrete candidate for investigation, not a measured speedup. Preserve
checked integer operations, capture evaluation, callback effects and cleanup.
Measure the source/driver boundary before changing that selection rule.

The preceding run `41426573182` stopped on both hosts at source formatting;
no native result was produced. Redundant parentheses were removed with the
verified #243 formatter. Its failed logs remain in the retained directory.

## First step: source and storage diagnostic

Publish this protocol before implementing the runner. Do not change production
compiler/runtime code or infer a speed improvement from compiler reports.

Use one current compiler and one source module with three exported functions:

- `make-input : I64 -> I64 -> Array[F64]` takes a round and element count. It uses
  `array.generate` to calculate `(((index + round) % 19) - 9) / 4.0`, converting
  the integer numerator to F64 before division.
- `reduce64` is the existing two-map/fold calculation: multiply each value by 3,
  add 1, then sum in index order from negative zero. It consumes its input.
- `work` calls `make-input` followed by `reduce64` in fwp source. This checks the
  fully composed path as well as a materialized array passed through a C driver.

For example, round 0 and count 3 construct `[-2.25, -2.0, -1.75]`. The mapped
values are `[-5.75, -5.0, -4.25]`; the fold returns `-15.0`.

Run native GCC ARM64/AMD64 with explicit O1 and O2, `-ffp-contract=off`, baseline
`armv8-a`/`x86-64`, and no LTO. Build the source compiler at production Rust O1
with assertions and overflow checks. Record exact source, compiler, CPU, flags
and emitted C. No timing qualification or cross-host speed claim is made here.

| Probe | Work and observation |
|---|---|
| C-driver construction | Existing runtime allocation/store calls; then the same compiled `reduce64` |
| Source construction | Compiled `make-input`; compare every stored bit with an independent C formula, then call the same `reduce64` |
| Composed source | Compiled `work`; compare its exact F64 result with the independent scalar map/fold |
| Sizes/rounds | Counts 0, 1, 19, 33, 65,537 and 262,145; rounds 0 through 7 |
| Interpreter agreement | Small cases check source construction and complete calculation before native profiling |
| Storage | Separate instrumented builds record requests, requested bytes, effective retains and final live charge; result bits and final storage must agree |
| Observer control | Omit one result-array release and require the live-storage check to fail before process exit |
| Compiler evidence | Retain ordinary and instrumented emitted C, binaries, GCC optimization reports and stack-usage qualifiers; inspect source before attributing costs |

Input construction may keep checked integer operations or cleanup guards that the
C driver does not need for its bounded loop. Record these differences explicitly.
A source-composed program may eliminate materialized storage; report that as a
different execution boundary, not an equivalent isolated allocation sample.

## Following measurement

Only after the diagnostic passes, freeze a separate timing protocol that names
all peers and phases. Keep materialized construction separate from whole-source
composition. Split allocation/filling from reduction/release using explicit
boundaries, report timer/control costs, and retain inclusive work as a check.
C/Rust peers must perform the same formulas, materialization and arithmetic order.
Compare allocations, bytes, live memory, RSS, code and per-function stack costs.

Declare hosts, rounds and copy-control limits before sampling. Retain every
failure; no unchanged retries for a passing number. A demonstrated source cost
may select one bounded compiler optimization with its own safety and measurement
criteria. This document does not preselect removing checks, cleanup or ARC.
