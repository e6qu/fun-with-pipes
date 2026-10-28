# Preserve two proved integer bounds

**Implemented experiment, not yet executed or accepted.** This is the next P2/P3 experiment after
[the frozen CPU baselines](cpu-baselines.md). It adds no language syntax or API.

Two compiler-generated additions already have a proof that overflow is impossible:

- A fused `range start end` advances only when `position < end`. Because `end`
  fits the same integer type, `position + 1 <= end` also fits. Equal or descending
  endpoints do not advance. The compiler can use its existing wrapping addition;
  the proof means wrapping never occurs.
- When replacing temporary integer displays with character counts, the compiler
  already proves every partial sum is between zero and `I64::MAX`. For example,
  the count for two I64 displays and `"#"` is at most `20 + 20 + 1`. These sums
  can use the same existing operation. An `add` used to produce the displayed
  integer remains checked, as do user callbacks and fold accumulators.

The source changes are restricted to `src/fuse.rs` and `src/cgen/scalar_text.rs`.
The array-index path already uses this rule. This differs from the
[earlier rejected experiment](checked-bounds-results.md), which changed the
successful return expression of ordinary checked additions and subtractions.

## Correctness before timing

The added `integer_output` controls use runtime tuple inputs near both limits of
all twelve integer types. They check two-element, empty and descending ranges
against independent expected lengths, in raw and optimized interpretation and
native O0/O1/O2/O3 builds. Callback overflow, fold overflow and overflow before
`show` must still trap. Existing Unicode, sharing, effect-order, allocation and
scalar-arithmetic tests remain required. Use production GCC and Clang; formatting
alone does not verify the change. Preserve the primitive inventory and both G2
analysis budgets, then require all final-head production and documentation gates.

## Runner experiment

Build four actual compiler variants from Rust source: unchanged baseline,
range-index change only, character-sum change only, and both changes. Record the
base/candidate revisions and exact source patches; reject changes to any other
compiler/runtime/library file. No build depends on an older fwp executable.
Retain each generated C file and actual native image. The unchanged compiler
source is the frozen baseline revision, `ec03d9cd81c001bf006a73e7dbfb044155884611`.

Time `loop` and `text-length` against their existing checked C/Rust peers, plus
the four fwp variants and a second execution of the identical baseline image.
These seven variants run in rotating order: two warmup batches and 56 measured
batches, so every variant occupies every position eight times. Keep one fresh
process per loop batch and 32 per character-counting batch, with unchanged inputs
and every output checked. Timers include startup, calculation, output and cleanup;
compilation and evidence writes remain outside. No sample is discarded.

Use the frozen per-host limits, matching CPU model, toolchains, inputs and flags.
A different host needs its own baseline before candidate timing. Compare candidates
only with the baseline in the same job. An unstable identical-code control makes
that session inconclusive; it cannot justify weaker limits. Repeat on both named
architectures. The 56 samples exceed the original 32; they do not reset a limit.

Inspect actual timed code sizes and record stack-report scope. Profile memory
separately, preserving zero managed requests/retains for these programs and the
intentional-leak controls. Keep the seven-peer correctness and arithmetic audits;
report any other observed regressions. Neither fewer checks nor smaller code alone
is evidence of faster execution.

Prefer the smallest qualifying change: range indices alone, then character sums
alone, then their combination. A selection must satisfy the frozen improvement
rule for character counting and regression limits for both programs on both
architectures. If none qualifies, retain all observations and do not adopt the
compiler change as a performance improvement. All slower or inconclusive variants
remain in the report. This is an empirical decision rule, not a statistical
confidence guarantee or a claim of C/Rust parity.

Run the `scalar-bounds` suite in the Numerical and ownership evidence workflow.
[scripts/scalar-bounds.py](../../scripts/scalar-bounds.py) qualifies the host first,
then builds each variant from Rust source and runs `integer_output` before timing.
It preserves each exact source patch, compiler image, generated C, timed image,
seven-peer correctness/overflow audit, separate memory profiles and stack reports.
Nested benchmark records identify the harness checkout; the enclosing variant
manifest identifies the baseline plus patch actually compiled. No old compiler
executable is a build dependency. Candidate source files are restored on failure.

The repeated comparison retains 56 seven-way batches per program. All seven
original benchmark programs also run for each compiler variant; those six-sample
rows provide context and are not substituted for the frozen two-program limits.
Unknown hosts fail qualification before any candidate timing and retain their
host/toolchain record. No time limit or noise threshold is loosened for a rerun.
The focused evidence controls reject missing/reordered samples, failed output,
changed binaries, unmatched hosts/toolchains, noise and a loop regression hidden
behind a character-counting improvement. Full production gates follow selection.
