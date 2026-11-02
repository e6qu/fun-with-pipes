# Investigate early array-consumption samples

This diagnostic was frozen before implementation. It is not a new acceptance
rule or a runtime fix.
PR #245's original AMD64 copy and consumption failures remain open.

## Evidence and question

[All original samples are retained](array-sample-positions.md). In the large-array AMD64 runs, the candidate's
first consumption sample is about 269–276 µs per array; later samples approach
246–249 µs. The generic reference is close to 246–248 µs throughout. The earlier
C-driver baseline shows a similar early-sample pattern. Generated consumption C
is unchanged between candidate and reference.

Does equal, untimed computation before the measured workload reduce this early
penalty? This can establish an effect of preparation. It cannot by itself name
CPU frequency, caches, page placement or code layout as the cause.

## Fixed diagnostic

- Input: all four audited PR #245 archives at `f8a558da`, using their generated C
  and exact compiler settings. Verify artifact digests, source identities, the
  reference patch and focused safety evidence before generating the diagnostic.
  Require current compiler/runtime/library/test trees to match that verified source.
- Do not rebuild fwp: compile the retained C with GCC 13.3 on Neoverse N2 or GCC
  15.2 on EPYC 7763, four CPUs, O2, baseline architecture, contraction off, no LTO.
  Stop before compiling on an undeclared host; retain every rejection.
- Each candidate/reference executable accepts an explicit preparation count:
  exactly 0 or 1,024. Each also has a byte-identical independent copy. These eight
  role/setting combinations use the same two source programs and four binaries.
- Preparation (outside all workload timers): build one array with the same direct
  C-driver loop in both programs, then call the unchanged reduction 1,024 times.
  Keep a caller alias before each consuming call, check every result and release
  the final alias. A memory barrier before each call prevents assuming unchanged
  input across calls. Record the preparation checksum, allocations, live storage
  and elapsed/CPU times. Prove preparation leaves no owner or cleanup frame.
- Reset measurement counters after preparation. Timed work remains five samples
  of eight construct/consume/release rounds on both 65,537 and 262,145 elements.
  No sample is removed, and no count is selected after observing a result.
- Retain existing wall timers. Add per-consumption process-CPU time and per-sample
  page-fault/context-switch observations. Measure empty clock-pair overhead in a
  separate control; do not subtract it from results or call this an ordinary
  performance acceptance measurement.
- Two sessions per architecture; two warmup rounds, then 16 measured rounds with
  four fresh processes per role/round. Balance all eight roles over each eight
  rounds. Retain execution order and every raw output.

## Checks before timing

Check all result bits, preparation outputs, allocations and final zero live
storage for both preparation settings and both sources. Preserve the original
materialized-array allocation budgets during measured work. Omitted preparation
release and failed-clock controls must fail. Verify that the source generator
changes only preparation and observation code, leaving timed numerical work and
its ownership operations intact. Audit every emitted build diagnostic.

## Report and decision

Report every sample position, paired first-minus-last differences within each
process, complete-round totals, CPU versus wall time, faults/switches and all copy
ratios. Show ordinary and prepared settings side by side for both architectures
and sessions. Preserve the original results separately.

A reduced early penalty supports investigating process preparation; it does not
prove a compiler optimization or settle the original 2% limits. An unchanged
penalty rejects preparation as a sufficient explanation. Do not alter runtime
ownership or add special-case workarounds without a demonstrated source-level need.

## Running and auditing

The immutable tag `roadmap/array-consumption-protocol-2026-11-02` freezes the
choices above before implementation. The `array-consumption` suite in
[the evidence workflow](../../.github/workflows/numerics.yml) uses the matching
original archive for each architecture/session. It qualifies the C toolchain
without installing Rust or rebuilding fwp.

- [Generator and output checks](../../scripts/array_consumption_setup.py): keep
  timed construction/reduction code intact and require preparation to release its
  owner. The caller retains an array alias before each consuming reduction.
- [Runner](../../scripts/diagnose-array-consumption.py): validate both sizes and
  settings, then collect every scheduled process. Save partial failures too.
- [Independent audit](../../scripts/check-array-consumption.py): reconstruct each
  generated C file from the original archive; verify build flags, binary copies,
  result bits, allocation budgets, negative controls and every raw sample.
- [Harness tests](../../scripts/test-array-consumption-setup.py): reject changed
  source boundaries, retained storage, incorrect results and incomplete rounds.

The process-CPU interval encloses the existing wall-clock pair. Its overhead is
therefore different from the original timer. The separate empty-clock control
records both intervals; neither is subtracted. These observations are diagnostic,
not replacements for the original uninstrumented acceptance measurements.

## Harness repair before timing

[Run 41467873605](https://github.com/e6qu/fun-with-pipes/actions/runs/41467873605)
stopped both ARM64 sessions before any warmup or timed process. The preparation
profile correctly reported one allocation, 1,024 retains, 1,024 non-final
releases and zero remaining storage. Its 1,024 `releaseChecks` disagreed with the
harness's expected 1,025.

The expectation was wrong: this existing counter instruments
`fwp_rc_release_last`, called by each reduction. The caller's final
`fwp_rc_free_arr` uses `fwp_rc_last` and then frees storage; it does not increment
that counter. The repair expects 1,024 checks and still requires zero live storage
and the omitted-final-release failure control. No runtime code, work count or
acceptance limit changed. The regression rejects an extra reported check.

Both full logs and all 28 completed commands were audited. The two queued AMD64
jobs were cancelled before starting; no completed timing was discarded or retried.
[Saved logs, profiles and artifact identities](array-consumption-failures-2026-11-02/index.json)
retain the original failure. Guarded replay of both profiles and the five harness
tests pass (0.14s each); native reruns must still verify every remaining control.

[All four completed sessions](array-consumption-2026-11-02/README.md) retain the
findings, memory costs, raw outputs and still-open original limits.
