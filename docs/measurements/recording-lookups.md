# Reuse a validated tape lookup within a numeric worker

Freeze this contract before compiler/runtime edits. Parent: verified PR #261,
merge `2e6e09f539bcdab965d062f0184b585b340b29d8`.

## Source account

The [saved source](recording-work-review-2026-11-05/forward-source.c.gz) is the
129/199 ARM64 session-1 candidate from measurement source `76690b38`. Its
uncompressed SHA-256 is
`92975c98a05f3dc596d4e044b49983adc7d5cee6792df01f44f94568a5569954`.
It was extracted alone from the already-audited archive; no measurement reran.

For each adjacent input pair `(x, y)`, the objective computes
`100 * (y - x*x)^2 + (1 - x)^2`. The generated pair worker directly records six
operations: `x*x`, subtraction from `y`, `1-x`, the residual square, multiplication
by 100, and `(1-x)^2`. Its scalar addition worker records the seventh operation.
The later fold records one addition per pair. All pair callbacks finish before
the fold starts. For N inputs, that is `8*(N-1)` nodes per nonempty update:
1,024 for N=129, matching the saved 1,630,208 nodes across 1,592 updates.

Every active scalar recording currently validates the tape slot, generation and
representation, checks parent indices and capacity, then writes two parent indices
and two F64 weights. The source account establishes repeated work, not its runtime
cost. [Phase observations](recording-work-review-2026-11-05/README.md) motivate the
investigation; they do not time an individual check.

## Selected boundary

- Prove a closed, acyclic numeric worker and its callees using a memoized,
  bounded analysis: at most 4,096 expression visits per request and 32 nested
  numeric type nodes per type check. Reject exhaustion.
- Permit scalar numeric constants/locals, numeric records, projections, straight
  `let` bindings, exact scalar recording, and explicitly listed F32/F64 arithmetic
  and conversions. Reject arbitrary calls, function values, tracing, branches,
  resources, wide/typed weights, foreign calls, tape creation/retirement and recovery.
- Require at least two direct scalar-recording sites. Use one stack-local pair
  `(validated tape ID, tape pointer)`, initialized explicitly to `(-1, NULL)` at
  each worker entry. It owns no memory and never escapes the worker.
- Exclude programs with task/service entry ticks: even a numerically pure callee
  can suspend at its entry and allow another task to reallocate the tape registry.
- For the same already-validated ID, reuse the pointer. A different ID must undergo
  the ordinary lookup and representation checks before replacing the saved pair.
  Negative/inactive parents do not populate it. Initial ID -1 cannot equal the
  nonnegative ID extracted from an active parent, including invalid ID zero.
- Keep mixed-tape checks, parent validation, full-tape/capacity checks, append order,
  weights, arithmetic bits and cleanup unchanged. Do not reserve ahead, combine
  derivative nodes or reorder floating-point operations. A trap leaves the proved
  worker; no internal recovery can resume with stale state.
- Use one scalar-recording runtime implementation with an explicit optional
  internal lookup-state argument. Ordinary calls supply NULL; proved calls supply
  their local state. Update every internal C caller and probe. No public API,
  syntax, environment option, allocation policy or compatibility wrapper is added.

## Verification and acceptance

Compiler controls must reject recursive/unknown/effectful/traced/typed/tick-enabled
workers and test the visit bound. Native O1/O2 probes must compare cached and
ordinary recording bits, gradients, validation/trap order, capacity growth,
inactive inputs, invalid ID zero, mixed/expired tapes, alternating valid tape IDs,
unwind cleanup and fresh worker entries after retirement/reuse. Deliberately
broken lookup/parent/order observers must fail. Preserve nested differentiation,
task/cancellation, ownership, registry-growth and full golden-corpus coverage.

One internal compiler selection constant creates same-source enabled/disabled
references; all other code, including the shared runtime implementation, is
identical. Both keep PR #261's scalar constants. Verify the unique reversible edit.
Reconcile allocation, node and phase-work counts with the saved parent candidate.
Instrumented lookup counts must show the selected reduction without reducing
recorded nodes or parent/capacity validations. No wall-clock claim follows from
that count alone.

Keep the [parent protocol's](scalar-constant-lowering.md#fixed-comparison-and-acceptance)
six input/update/repetition combinations, both result forms, explicit workspace
policies, GCC O1/O2 census, seven compiler inputs with 48 compilations each, and
two qualified EPYC 7763/Neoverse-N2 timing sessions per architecture. Use GCC O2,
no fast math/contraction/LTO, two warmups and 98 balanced seven-process rounds.
Require 5% faster long solves, at most 2% small-case slowdown/copy variation,
at most 5% compiler time/RSS growth, unchanged allocation/node counts, no larger
managed/raw peak, zero final storage and at most 128 additional reported frame
bytes. Keep dynamic stack qualifications, process RSS and C/Rust comparisons.

Retain every miss and rejected host attempt. Replace only hosts rejected before
builds/timing; never repeat unchanged timing for a pass. The standing policy may
retain verified reductions with timing goals open, but never semantic, memory or
compiler-cost failures. Deliver one coherent PR after all nine final-head jobs,
docs and complete artifact/log audits pass.
