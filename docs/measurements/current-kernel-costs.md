# Current kernel costs and typed loop state

## Question

How much time and memory does the current compiler use for the four array/matrix
kernels, compared with equivalent C and Rust? How much does keeping floating-point
loop state in native C `float`/`double` fields contribute?

The [expanded baseline](kernel-baselines.md#expanded-small-matrix-recheck) measured
source `37da7441`, **before** typed loop state (`80edb379`, shipped in #227).
Its AMD64 array ratio of about 3.3 times C is historical. The later
[compiler reports](timing-variation.md#typed-state-results) verify representation
and correctness, not speed. Do not present that old ratio as current overhead.

This experiment measures an existing implementation; it selects no new compiler
optimization. Preserve earlier failed controls and limits. It is not an unchanged
retry of the old baseline or proof that every numerical abstraction is free.

## Six programs and equivalent work

Build two compilers from the same checkout of Rust source:

- **Current fwp:** ordinary compiler, including typed F32/F64 loop fields.
- **Word-state reference:** disable only the selection of native float/double
  fields in `Gen::loop_def`; those fields use the existing generic value-word path.
  Keep all current ownership, cleanup, numeric operations and other optimizations.
- **C and Rust:** unchanged formulas from the existing native benchmark peers.
- **Two controls:** a byte-identical copy of each fwp executable.

Retain the exact source patch and compiler hashes. Neither build needs an earlier
fwp compiler. Check that the reference patch changes only its declared field-type
selection; reject a missing, duplicated or changed match. Verify both compilers'
results and memory behavior before timing.

Use the [same four workloads, inputs and arithmetic order](kernel-baselines.md#work-to-compare):
arrays of 65,537 and 262,145 F64 values, and 65×67×63 and 257×259×255 matrix products.
Each sample has eight calculations; each process reports five samples.
For example, array input `2.0` maps to `2.0 * 3.0 + 1.0 = 7.0` before the ordered
sum. Preserve negative-zero seeds, separate multiplication/addition and exact
integer-derived result oracles. No fast math, contraction or reassociation.

Matrix code is a control for work outside the changed loop-state representation;
it also provides current fwp/C/Rust costs. Preserve the peers' existing alias and
native-entry differences. Input creation uses each implementation's buffer API.

## Settings and schedule, declared before measurement

Use two independent sessions on each original qualified host: four-CPU Linux
Neoverse-N2/GCC 13.3.0 and EPYC 7763/GCC 15.2.0, Rust 1.99.1. Reject a different
host before building or executing and retain the rejection. Replacement dispatches
name only the unqualified host/session. Never retry a completed noisy session.

Compile generated C and the C peer at O2, `-ffp-contract=off`, explicit `armv8-a`
or `x86-64`, no LTO. Rust uses O2 and its matching architecture. Enable fusion,
stack storage and unique reuse explicitly. Keep normal allowed CPU affinity and
address randomization. Record all versions, flags and relevant environment.

Use two warmup rounds and **18 measured rounds**. In each round each program
runs four fresh processes, except the small matrix, which uses 256. Six roles
require a new six-role schedule; the old four-role order cannot include both
reference controls. Each block runs every role once. Use the six cyclic role
rotations of `[0, 1, 5, 2, 4, 3]`, advancing one rotation per block across rounds.
Thus every role occupies every position equally over the measured experiment.
Report actual adjacency counts; do not claim uniform self-pair coverage.
Use six equal-length executable names and retain the exact role/path map.

For each role and timing scope, sum all observations in a round, then compare
medians of the 18 complete round totals. Retain all warmups, outliers, partial
runs, stdout/stderr, process order and command durations. Within-process samples
are not independent sessions. Failure makes that session incomplete.

## Timing and memory boundaries

| Measurement | Included | Excluded |
|---|---|---|
| Array kernel | Consume a filled input, map, sum, release input | Input allocation/filling |
| Matrix kernel | Ordered multiplication and accumulation | Allocation/zeroing, shape checks outside the loop, cleanup |
| Allocation-inclusive | Allocate, fill, calculate, checksum, release | Runtime startup, printing and shutdown |
| Whole process | Startup through shutdown | Compilation; reported as context only |

Separate profile executables record allocation requests/bytes, effective
retains/releases, peak/final managed charge and process RSS. C/Rust payload bytes,
fwp allocator charge and RSS measure different things; report them separately.
Each program must restore its pre-operation live storage and release owners at
shutdown. A deliberately missing release must fail the observer. Save code-section
size, executable identity and static stack reports without using size as a speed
criterion. Retain actual binaries and inspect collector-symbol absence.

## Decision rules

Apply these rules to **both sessions on both architectures**:

1. Exact result bits, ordinary cleanup and missing-release controls must pass for
   current fwp, the reference and peers. A correctness failure requires a repair.
2. Each fwp variant versus its identical copy must differ by at most **2%** in
   both calculation timing scopes for every case. Otherwise that comparison is
   inconclusive; keep all observations and do not retry it unchanged.
3. Typed-state speed acceptance requires at least **5% less array-kernel time**
   in both sizes versus the word-state reference. Every case/scope must stay
   within **2% extra time**. Report each failed threshold, including unchanged
   matrix controls; do not aggregate a slow case away.
4. Current fwp must use no more managed allocations, requested bytes, effective
   retains or peak charge than the reference, with zero final charge in both.
5. Publish current fwp/C and fwp/Rust ratios and extra-time percentages for every
   case/scope, even when controls fail; clearly label unqualified observations.

A qualified new result can establish these current costs and the typed-state
contribution. It cannot rewrite old N1/D2 failures, settle derivative performance
or establish universal C/Rust parity. A missed performance threshold leaves the
already verified implementation in place and its speed goal open; this experiment
introduces no production compiler change to accept or revert.

## Delivery

Group the paired compiler preparation, runner, corrupted-evidence controls,
current results and plain-language plan/docs updates in one PR after #242.
Use focused harness checks locally through the resource guard; all compiler builds,
measurements and full validation run on GitHub. Keep #242's passing head unchanged
while its remaining gates run. Require all final production jobs and documentation
before squash merge of this batch too.
