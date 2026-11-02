# Separate observation overhead from preparation-driver changes

This protocol follows the [preparation diagnostic](array-consumption-2026-11-02/README.md).
Freeze it before implementing or measuring the next comparison. Original timing
failures remain open; this diagnostic selects no compiler/runtime change.

## Question and limits

Preparation moves minor faults outside the workload timer. It also narrows some
construction-copy differences, while changing current-fwp consumption time only
slightly. The new zero-preparation program does not reproduce the original early
consumption pattern exactly. Its added clocks and preparation-capable driver both
change the generated C translation unit and the work before each sample.

Separate those changes with three explicit versions of each current/reference
program. The comparison can identify an effect of observations or of the complete
preparation-capable driver. It cannot by itself attribute an effect to a particular
instruction, CPU frequency, cache behavior or one additional call site.

## Programs and inputs

Reuse both verified input archives for each matching architecture/session:

1. **Original:** exact saved PR #245 timing C, with the original wall timers and
   no preparation. Do not rebuild fwp or reconstruct a historical compiler.
2. **Observed:** the original C plus only the per-consumption process-CPU clocks
   and per-sample page-fault/context-switch reads from PR #246. Keep `main(void)`,
   the original output envelope, and no preparation call, argument parsing or
   preparation-output code. Preserve all numerical and ownership operations.
3. **Preparation-capable, zero:** exact saved PR #246 timing C, always invoked
   with the explicit argument `0`. Its preparation branch is present but performs
   no array construction/reductions. Do not relabel this an observation-only case.

Each version has a byte-identical independent copy: two source programs × three
versions × two copies = 12 roles. Current fwp and the reference differ only in
PR #245's original callback-selection rule. They share the same reduction/runtime.
There are no C/Rust/Swift peers in this experiment.

Use the same two inputs: 65,537 and 262,145 elements; five samples per process,
eight arrays per sample, rounds 0 through 7. Every element and result bit must
match the retained oracle. Construction, consumption and enclosing-work wall
timers keep their original boundaries. Only the latter two versions report CPU,
fault and context-switch observations; absence in the original is not a zero.

## Hosts and schedule

- Two sessions per native architecture, four available CPUs. Require Neoverse N2
  with GCC 13.3.0-6ubuntu2~24.04.1, or EPYC 7763 with GCC 15.2.0-16ubuntu1.
  Reject any mismatch before compiling and retain every rejection.
- Keep O2, GNU C11, `-ffp-contract=off`, baseline `armv8-a` / `x86-64`, no LTO,
  ordinary ownership and reuse enabled. Record exact commands and source hashes.
- Two warmup rounds, then **24 measured rounds**, four fresh processes per role
  in each round. Balance all 12 roles over each 12 rounds, with every role at
  every process position twice across the 24 measured rounds. Retain the schedule;
  do not claim complete predecessor-pair balance without proving it.
- Each process has a 180-second deadline. No sample is dropped, no count is chosen
  after measurement, and no completed noisy session is rerun for a pass.

For each timing scope, sum all five samples from all four processes per role in a
round. Compare medians of the 24 complete-round totals. Report copy spreads and
version ratios separately; the original 2% copy limits are unchanged. A noisy
version comparison is inconclusive, not evidence for or against a compiler bug.

## Controls before timing

- Verify source and artifact identities for both original datasets, including the
  successful safety checks and complete raw audits. Require current compiler,
  runtime, library and test trees to match the measured source.
- Reconstruct only the observation-only C and prove its numerical/runtime prefix
  and timed construction/reduction/release operations are unchanged. Verify the
  two retained versions byte for byte, then compile all versions at the declared
  production settings. Check every build diagnostic and binary-copy identity.
- Run exact results and allocation/ownership profiles for every version, program
  and size. Preserve one allocation per constructed array, zero effective retains
  in measured work, bounded peak storage and zero final live storage.
- Missing measured-array release must fail for every version; failed CPU clocks
  must fail for both observed versions. Check unchanged wall-clock failure handling.
  Zero preparation must report no preparation allocations or owner operations.
- Complete every native control before collecting timings. Retain partial failures
  and audit all completed targets/commands before publishing a repair.

## Report and next decision

Retain every raw output and sample, version/copy order, CPU/compiler/flags, source
and binary hashes, wall/CPU times, faults/switches, separate allocation profiles,
RSS, instruction bytes and compiler stack estimates. Keep startup/printing outside
workload timers explicit; retain whole-process command time as context.

Report original → observed and observed → preparation-capable-zero ratios for
both source programs, with every copy control and sample position. Independently
rebuild all summaries from raw data. Preserve the earlier preparation and original
acceptance results separately.

Only then decide whether observations explain part of the changed pattern or the
complete preparation driver needs narrower source-level isolation. Do not claim
that an unchanged C function guarantees unchanged machine code, infer a safety
bug from elapsed time, add hidden warming, or change runtime ownership without
an independently demonstrated need. Any production optimization needs its own
predeclared semantic, memory and performance requirements.
