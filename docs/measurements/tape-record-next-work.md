# Choose the next autodiff optimization

The [completed layout comparison](tape-record-time-2026-11-07/README.md) reduces
raw growth requests but misses every 5% speed target. It leaves managed traffic
unchanged and saves only 16 bytes of peak raw bookkeeping. In the largest case,
fwp still takes 10–13.5 times the handwritten C derivative's time. Another
allocation reduction alone would not explain or resolve that gap.

## What the saved phases establish

For 129 coordinates and 199 updates, current-result form, these percentages
are each phase's median divided by the sum of the six phase medians. Each
session contains 12 instrumented samples. They cover derivative work, not the
whole process or the coordinate-update loop outside differentiation.

| Session | Forward evaluation + recording | Reverse traversal | Other derivative phases |
|---|---:|---:|---:|
| ARM64 1 | 60.69% | 33.02% | 6.29% |
| ARM64 2 | 60.70% | 33.05% | 6.25% |
| AMD64 1, EPYC 7763 | 59.05% | 34.22% | 6.73% |
| AMD64 2, EPYC 9V74 | 48.77% | 45.47% | 5.76% |

Instrumentation changes generated code and timing: instrumented/ordinary
process-time ratios range from 0.982 to 1.024. These observations locate work;
they do not prove that a particular branch, cache miss or ARC operation causes
the remaining cost.

## Next bounded investigation, after current delivery

1. **Compare automatic and handwritten derivatives within current fwp.** Use
   `tests/fixtures/descent_explicit.fwp` and `descent_packed.fwp` alongside the
   automatic derivative, with one common input/update/output driver. Inspect
   generated C first: document lists versus packed arrays, bounds checks,
   arithmetic order, batching and output work. Verify the same numerical oracle.
   This distinguishes differentiation overhead from shared fwp runtime costs;
   it still does not isolate one mechanism such as ARC.
2. **Freeze that diagnostic before timing.** Use the same six coordinate/update
   cases and native ARM64/approved-AMD policy. Record source hashes, actual CPUs,
   compiler flags, identical-copy controls, repetitions and timing scope. Keep
   all outcomes; do not use new measurements to erase the existing 32 misses.
   Reuse existing production evidence only while native sources remain identical.
3. **Choose one implementation change from the result and source.** Inspect
   `lib/autodiff.fwp::rev._op2`, `src/cgen/recording.rs`, and the append/backward
   paths in `runtime/fwp_rt_kernel.c`. If automatic differentiation dominates,
   investigate what node provenance and arithmetic can be proved at compile time.
   If handwritten fwp remains similarly expensive, investigate its shared loop,
   representation and lifetime costs first. Write the exact proof boundary,
   failure/trap-order obligations, representative inputs and acceptance criteria
   before changing production code.

Any implementation must preserve invalid/stale/mixed-node rejection,
floating-point contribution order, typed/nested derivatives, cancellation,
trap order and exact cleanup.
