# Session handoff

## Next action

This is the `specialize-numeric-hashes` preparation in
`/private/tmp/fwp-specialize-numeric-hashes`, based on PR #173's head
`3e4d0a372a79461d5482503b4d1b454ed7b7e347`. PR #173 remains the only active PR;
its acceptance handoff is in the primary checkout. Production `39312560218`
has passed its benchmark job, with eight platform jobs running; documentation
`39312560173` passed. Do not replace that tested head.

Preparation `6ffd2385a8207078cadd046d7dc2e3f3c389675f` is published. The initial
Linux `hash` run `39314998423` passed 69 tests, none ignored, at `c05e592e`.
Its compiler/runtime is unchanged; the latest fixture adds NaN/infinity cases.
At `6ffd2385`, six-host `hash` run `39317215955`, both-Linux `wasi-arc` run
`39317221484` and four-host `hash-costs` run `39317226192` are queued.

Next: audit all three matrix runs. Fix every failure. Run `hash-report` with
those exact test/cost run IDs and source revision, then inspect the saved inner
loops before deciding whether to adopt the change. Its collector checks all
69 tests per host, 96 correctness binaries and 48 measured fwp binaries.
Keep one active PR. After #173 passes and merges, replay accepted preparation
on main, update the plan/evidence and require all final-head production gates.

## Prepared change

The compiler emits direct hashing code for inline integers, F32/F64, their flat
lists/arrays/sets, numeric maps and records composed of those types. Other types
keep descriptor traversal. The original value remains borrowed; there is no
new syntax, owner or encoded buffer. Packed/full-word array storage and slices
have explicit loads; canonical widths, float bits, field/key order and length
encoding remain unchanged. `FWP_TYPED_HASH=0` selects general traversal for
controlled comparisons. Recursive type shapes are not expanded indefinitely.

The motivation is measured code, not an assumed universal speedup. PR #173's
large range-set binaries still call the general visitor once per key. Linux
AMD64 and ARM macOS disassembly is in
`/private/tmp/fwp-range-cost-{ubuntu-latest,macos-15}.asm`, from report artifact
`12215946946` and source `7901a576`. Earlier hash comparisons also retain
small-input C/Rust gaps in [the benchmark guide](benchmarks.md#repeating-the-allocation-and-borrowing-changes-together).
The final-head million-key benchmark passed too: tracing fwp takes 6.1%/6.9%
more whole-process median time than C/Rust on its Linux AMD64 runner. The
[complete report](measurements/range-set-peers-2026-10-19.md) retains all samples
and the other five programs; this is a baseline, not a specialization result.

One added test covers scalar boundaries, packed/full-word arrays, slices,
sharing, mixed map widths and named records. It compares raw interpretation
with generated ARC/stressed-tracing O0/O2 code, with specialization on/off.
A second probe asserts no allocation or reference-count operations inside the
new bodies, and must detect deliberately added allocation/retain calls.
The WASI shutdown corpus now includes the same fixture. The initial Linux run
passed both new native tests; the expanded fixture still needs the full matrix.

The measurement script compares specialized ARC/tracing, generic ARC, buffered
ARC, C and Rust in twelve balanced samples. It keeps the two array cases and
adds 65,536-key sets hashed 64 times, with their three-byte length prefix recorded
correctly. Buffered hashing explicitly disables specialization so that its
control still measures the encoded buffer. Rust imports were moved out of the
measurement program's main function. No new performance result exists yet.

## Local checks and repairs

All workloads use the primary checkout's `python3 scripts/local-guard.py`, with
unchanged limits. No new compiler build or full benchmark ran locally.

- `cargo fmt --all` passed in 1.55/1.42 seconds during preparation.
- Python syntax checks passed in 0.15 seconds; the documentation audit passed
  60 document sets, 106 immutable anchors and seven work areas in 2.87 seconds.
- Latest fixture formatting passed in 0.01 seconds and documentation in 2.54
  seconds. `scripts/test-hash-evidence.py` passed three rejection/audit checks
  in 0.22 seconds; complete binary inspection runs on GitHub.
- The accepted compiler at `/private/tmp/fwp-170-accepted-macos/fwp-macos-arm64/fwp`
  ran the original 18-line fixture in 0.27 seconds. Its first syntax check correctly
  required explicit `Hash[a]` and `make Samples`; both were fixed. Formatting passed.
- Added F32/F64 NaN and infinity cases: all 20 output lines pass raw interpretation
  (`FWP_NO_OPT=1`) in 0.27 seconds. These additions postdate the first queued run.
- `/private/tmp/fwp-check-numeric-hash-generator.py` passed 128 comparisons against
  existing canonical runtime hashing in 2.51 seconds, at O0/O2 with packing on/off.
  It extracts the actual generator function into a small type-model harness and
  uses accepted C scaffolding; it does not establish full compiler integration.
  Cases cover slices, zero/129 lengths, NaN bits, mixed map widths and records;
  recursive shapes and wide arrays remain unexpanded.
- `/private/tmp/fwp-check-hash-peer-source.py` compiled the edited Rust measurement
  sources with warnings as errors and checked a 16-key allocation ledger in 1.58
  seconds. This is a tiny correctness check, not a local benchmark.
- Review caught that arrays can disable packing. Generated loads now select
  the actual storage width, and the new native matrix tests both settings.
- Reference-count instrumentation includes retain, share, drop and last-release;
  allocation instrumentation includes native allocation fast paths and libc calls.
  Their negative controls still need CI execution.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Ownership contracts, tracing removal and limited ARC |
| 2 | In progress | Functional intermediates, copies and eligible tail recursion |
| 3 | In progress | Equivalent-work C/Rust gaps and machine-code costs |
| 4 | In progress | Derivative precision, speed and storage |
| 5 | In progress | CPU kernels and ahead-of-time device execution |
| 6 | In progress | Reproducible comparisons and regression budgets |
| 7 | In progress | Representative larger applications |

All seven areas in [PLAN.md](../PLAN.md) remain open. Do not treat preparation,
a skipped check or a timing median alone as completed support. JIT is excluded.
