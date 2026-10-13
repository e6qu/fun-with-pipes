# Session handoff

Updated 2026-10-13. The approved six-phase roadmap and accepted follow-ups are
merged through PR #131. The current task is all ten tasks in the single PR #132 bundle.
[PLAN](../PLAN.md) defines its acceptance criteria and deferred work. Read [design](design.md) and
[ownership](ownership.md) for semantics and support boundaries.

Desired platforms: Linux, macOS and Windows on ARM64 (aarch64) and AMD64 (x86_64),
one binary per OS/architecture. Windows is desired but deferred on both
architectures; prioritize Linux/macOS, ownership and compiler performance.
Universal binaries are not an objective. Native macOS ARM64/AMD64 support is
accepted; Linux ARM64 has cross-build/QEMU coverage but full native acceptance
remains to establish. The expanded seven-job matrix covers Linux/macOS; Windows remains untested.

## Accepted source and gates

[PR #131](https://github.com/e6qu/fun-with-pipes/pull/131):

- Squash: `8ae361a43f7634bf818ec8415d8c1ea95fdb74ed`.
- Tested head: `a920caf9c3e84f039ac4e6850c607cb34dcf2585`.
- Identical complete tree: `baeb50b1826a6593d838ff0ea7aa7bdc823d0ffb`.
- Sole parent: `db10b9fd9849446475a68caaf832f17bfe76ba9e` (PR #130).
- Complete commit message: `Add direct iterator consumers and record projection shorthand`.

All six jobs in [CI 38322220083](https://github.com/e6qu/fun-with-pipes/actions/runs/38322220083)
and [roadmap_docs 38322220076](https://github.com/e6qu/fun-with-pipes/actions/runs/38322220076)
passed before merge. Completed macOS logs verify all 171 ordinary integration
targets once per architecture (86 regular / 85 GC), plus separate GC stress.
The three new raw-interpreter, effect-rejection and 20,000-element traversal
checks ran and passed on both architectures. Linux and benchmark gates passed.

The guarded merge verifier checked exact heads, every job, completion before
merge, tree identity, parent and the entire one-line message. Temporary proofs:
/private/tmp/fwp-iteration-final-gates.json, fwp-iteration-execution-proof.json
and fwp-iteration-merge-proof.json. Never rerun the completed merge helper.
Earlier deliveries and recovery provenance are indexed in [history](roadmap-history.md).

Before PR #132, the audit confirmed remote main at the squash above.
[Main roadmap_docs 38327360003](https://github.com/e6qu/fun-with-pipes/actions/runs/38327360003)
is completed/success. Duplicate main CI 38327360005 was cancelled after verified
tested-tree parity; cancellation supplies no passing gate.

## Delivered behavior and limits

- Prefix calls and infix pipes, explicit `const`, unit, `if` and `match` remain.
  Colon application and implicit/indented argument grouping remain set aside.
- `iter.fold`, `iter.each` and `iter.find` consume directly using existing
  loops. Callbacks finish before a tail is forced; success/failure stops at
  the documented element. Pure tail types and tracked callback effects remain.
- List `fold-until` returns the state in `Stop`, or the current state on
  exhaustion. Lists are still eagerly evaluated before traversal.
- `map-accum` takes state then element in its callback, returning
  `(mapped value, next state)` and ultimately `(mapped list, final state)`.
- `make { .field }`, including nominal builders, expands to an ordinary
  selector field. Nested/numeric paths need explicit names; invalid output
  spellings are rejected. Other record forms remain explicit. Canonical
  label evaluation order and ownership are unchanged.

## Performance and ownership limits

PR #131 added ordinary library functions and parser expansion, without new
runtime primitives or fusion eligibility rules. No allocation-free or universal
speedup claim is established. A guarded native fold probe returned 4950 for
100 elements and showed a fixed-frame loop with record allocations and callback
dispatch. It used an older available compiler with the new definitions; it is
not current-head performance evidence. Temporary C, Mach-O and disassembly:
/private/tmp/fwp-iterator-code. Rebaseline with the current compiler on CI before
accepting an optimization. The latest combined implementation is verified by
the exact-head CI above, not by that exploratory probe.

At the accepted PR #131 baseline, checked ARC covers proved immutable graphs and scoped File owners. Unproved
cycles, reconstructed/runtime/foreign boundaries, boxed I128/U128 and raw
reverse-mode lifetimes remain outside its coverage. Rejection never selects
tracing. [Ownership](ownership.md) records the exact contracts, half/wide float
representation limits and the distinction between C ABI structure and registers.

## Remaining ownership deliveries

The completed six-phase queue remains closed. The active bundle below extends
CSV, wide-integer and scoped-AD ownership; do not reopen archived preparations. Windows, new
deployment interfaces and a new backend remain deferred.

## Active bundle and workspace

The user authorized all ten tasks in PLAN.md as one PR, including docs cleanup.
Draft PR #132: https://github.com/e6qu/fun-with-pipes/pull/132.
Branch: `roadmap-status-audit`, base `8ae361a43f76`. Windows stays deferred.

| Task | Current state |
|---|---|
| 1 Docs | Cleanup prepared; final behavior/measurement docs still need verified results |
| 2 Linux ARM64 | Native job added; baseline CI 38365626793 is running |
| 3 Binaries | Four native artifact packages and outside-checkout smoke checks added; execution pending |
| 4 Measurements | Current compiler, separate timing/profile binaries and disassembly script added; baseline pending |
| 5 Callback dispatch | Known iterator callbacks carried into fused steps; draft awaiting compiler checks |
| 6 Loop allocation | Direct consumers use flat generated loop state; measured reduction not yet established |
| 7 Fusion | Existing iterator fuser generalized to fold/each/find; semantic verification pending |
| 8 Reconstructed trees | CSV parser builds counted nested strings/lists with registered partial cleanup; tests pending |
| 9 Wide integers | Typed I128/U128 owners, numeric contracts and range/negation lifetime fixes drafted; tests pending |
| 10 Scoped AD | Finite closure-flow scope proof and escape/reclamation controls drafted; verification pending |

No task is accepted for this bundle yet. Baseline head
`c9a86c6ccb8adafb312ab1bab80aa2f9801eee8e` contains tasks 1–4 infrastructure;
its passing jobs cannot validate subsequent compiler changes. Use the Numerical
and ownership evidence workflow with `suite=bundle` for focused runner checks.
Intermediate preflight commits may skip automatic full CI to avoid repeated
full matrices; the final head must run and pass every production job plus docs.

Local validation is serial through `python3 scripts/local-guard.py`:
Python syntax/docs/whitespace passed (0.36s sampled CPU / 2.89s elapsed).
Rustfmt on edited modules passed (0.04s / 0.25s). The standalone primitive
inventory passed (0.26s / 0.97s): 375 declarations, 365 symbols, 204 contracts,
141 review declarations/131 symbols, 11 flat signatures, 19 IR combinators.
An initial invocation omitted the required baseline argument; corrected before
publication. The immutable original inventory is unchanged. Full builds/tests
and evidence generation remain on runners.

## Current runner findings

Baseline CI 38365626793 has passing benchmark and both macOS ARM jobs, including
native artifact smoke checks and baseline iterator measurements. Intel macOS and
Linux gates remain pending. Baseline artifacts retain hardware, current compiler,
generated C and actual instructions; their head predates the implementation.

Focused preflight 38369225440 at `ba69a3e21edfc3218fc48586b72adfdb02520820`
compiles on all four runners. macOS ARM passes CSV normal/partial-trap cleanup,
wide numeric reclamation, scoped gradients, iterator effects/forcing controls
and the eligible ARC golden corpus. The prior 2,064-byte overflowing-arithmetic
leak is fixed. The sole macOS ARM failure was an ill-typed returned-callback
rejection fixture, corrected for the next run; it did not test scope rejection.
Preflight 38370736725 at `6feb659` passes on Linux AMD64 and macOS ARM,
including scope return/escape/trap/cancellation controls and traced/ARC cold/warm
workspace profiles. Linux ARM finds Clang/libgcc missing __muloti4 for signed
I128 overflow multiplication. The next revision computes signed overflow via
unsigned magnitudes and adds dynamic sign/extreme-value controls. Intel macOS
is still running. No bundle acceptance is claimed.

The ARM report shows 4,003 allocation requests for both fold and map/filter/fold
at 1,000 elements (baseline 6,005/9,511). Generated loop workers flatten state
into locals and call the known fold callback directly; producer tail dispatch
and Yield/closure allocation remain. Stateful each still had 7,009 requests:
known run-state callbacks now specialize before fusion to expose that consumer.
The next measurement run compares enabled/disabled fusion at the same head and
requires fewer allocation requests and bytes. Process times include startup.

Additional controls now cover ARC scope normal/trap/cancellation cleanup and
cold/warm C workspace counts with tracing compiled out. These await validation.
Guarded Python AST, rustfmt and whitespace checks passed (0.05s CPU / 0.26s).

The complete native Linux ARM baseline finishes with one failure: the HTTP/2
borrowed-owner omission control kept a stale pointer in a callee-saved register
under GCC, so omitting the real owner fence did not fail. The next revision
extends the existing isolated-construction/register-clearing fixture to AArch64;
positive GC/reuse checks remain unchanged. Focused Linux checks cover both Clang
and GCC. Intel regular baseline tests and package smoke checks passed, but its
package upload failed with GitHub DNS ENOTFOUND; that failed job is not a gate.

## Next action

Publish the combined callback-specialization, corrected rejection fixture and
stronger same-head allocation/ARC workspace controls, then run focused runner
validation and fix all failures. Retain baseline/final evidence, update support
docs with measured limits, then run the complete final matrix. Require all seven
production jobs (both Linux architectures, bench, four macOS jobs) plus docs on
the final head before merging PR #132 with the required one-line message.
