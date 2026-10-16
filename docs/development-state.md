# Session handoff

Updated 2026-10-16. [PR #150](https://github.com/e6qu/fun-with-pipes/pull/150)
merged as `729db67f71386750aad0bbe477f546e5276b0223` after all nine production
jobs `38851567232` and docs `38851565415` passed for `7a7b40e1`. Tree, parent and
one-line/empty-body message were verified. Duplicate `38860909658` is canceled.

The only open delivery is [PR #151](https://github.com/e6qu/fun-with-pipes/pull/151),
branch `wasi-hash-delivery` in `/private/tmp/fwp-wasi-delivery`. Current head is
`796f5a4c3cd920eb49f709f9a0a5551dc98481fc`; full production `38861611494` and docs
`38861611496` passes; production is running. Earlier `38861119765` was canceled after the allocation
counter repair. Require all nine jobs and docs for the exact final head before
squash merge. That PR owns WASI ARC, streaming hash and callback/fusion changes.
Its handoff, benchmarks and reports retain full evidence and remaining overhead.

This independent following preparation is `/private/tmp/fwp-hash-borrows`, branch
`borrowed-hash-arguments`, anchored at old pre-rebase `28cc4d0e`. Transfer only
later commits after #151 merges; never replay that old parent chain. Do not open
another delivery PR while #151 is open. Its first implementation is `ed78f26a`;
subsequent work adds direct range arrays and repairs the allocation counter.

Next: validate the latest field-borrowing change with native unit/semantic checks,
actual WASI and four-host costs. Earlier direct-range WASI `38861845639` passes
both hosts at `a2f4ccd9`; its costs are `38861849157`. Native fixture repair
`38862399186` runs at `61fde4cc`. Those earlier checks do not cover field borrowing. Fix failures, retain machine-code/allocation evidence
and repeat verified before/after binaries on the same hosts. Meanwhile monitor
#151, fix its failures and squash merge after exact-head acceptance. Then rebase
only this preparation's delta onto the verified merge and publish one substantial
PR. No whole roadmap area is complete.

Standing authorization covers fixes, publication and passing-CI squash merge.
Every commit is exactly one line, at most 80 characters, with empty body and no
trailers or attribution. JIT is excluded. Keep local checks serial through
`python3 scripts/local-guard.py`; full builds, suites and measurements run on CI.
Never raise limits or restart the refused local optimizer compilation.

## Roadmap status

[PLAN.md](../PLAN.md) defines completion. None of its seven whole areas is done.

| Step | Status | Next concrete work |
|---|---|---|
| 1 | In progress | Deliver synchronous WASI ownership; host re-entry remains unproved |
| 2 | In progress | Diagnose remaining allocations in measured hash pipelines |
| 3 | In progress | Retain actual code and address measured C/Rust gaps |
| 4 | In progress | Preserve nested derivative cleanup; broader tape costs remain |
| 5 | Pending | Broaden kernels and resolve runtime OpenCL compilation |
| 6 | In progress | Keep equivalent comparisons and physical storage evidence |
| 7 | In progress | Extend maintained programs across deployment boundaries |


## Changes and acceptance

The latest unverified change borrows the fields of a temporary record
passed directly to a proved nonescaping primitive. Existing sequence ownership
keeps field owners alive until the call returns, including when later fields
consume aliases or trap. The independent verifier rejects fields without owners
or owners consumed by later fields. The backend uses stack storage without child
count traffic. Structural tuple types are handled; nominal records retain their
existing ownership. New unit tests and retained/mutated/error fixtures need CI.
The disabled-stack path retains ordinary ownership. Require zero hot-loop retains,
retained aliases, last-use cleanup, trap cleanup and actual WASI physical frees.

Hash reads its input only during the call. An explicit nonescape proof in the
ownership inventory lets existing stack placement remove temporary heap tuples.
Borrowing alone remains insufficient: other primitives can return or retain
borrowed inputs. The proof propagates through ordinary functions; returning an
alias still escapes. Tests preserve retained fields, canonical bytes, effects,
traps, GC stress and actual WASI physical frees. Field reference counts remain
until separately proved unnecessary; this is not a zero-ARC claim.

An immediate inline-integer `range | array.from-list` now constructs packed array
storage directly. Bounds keep their evaluation order; equal/descending ranges
stay empty. Wide intermediate arithmetic checks the existing size limit before
machine-size conversion. I128/U128 boxes keep the existing path. This uses the
existing array-fusion comparison switch, with no new syntax or runtime fallback.
Tests cover every inline integer width, extremes, aliases, bound effects/traps,
allocation failure, constant allocation counts and actual 32-bit WASI. Removing
the WASI length guard deliberately truncates 4,294,967,296 to zero; the control
must expose that wrong result while the checked code traps before allocation.

## Results and unresolved failures

The initial stack-only native run `38860420915` passes its semantic/alias/hash
checks on Linux ARM64 but fails the disabled-stack allocation control: both
variants appeared below budget. Inspection found the test counted `fwp_gc_alloc`
but missed the `fwp_alloc_init` fast path used by records/list nodes. Both entries
are now counted without counting the slow path twice, matching the existing
benchmark instrumentation. This fix also ships in #151 as `796f5a4c`; reports
already counted correctly and need no correction. The repaired tests still need
runner validation; do not interpret the earlier failed control as acceptance.

Initial stack-only native/WASI `38860420915` / `38860423500` were canceled.
Intermediate costs `38860426497` completed ARM64 Linux/macOS; remaining queued
jobs were canceled in favor of the combined revision. The two complete reports
and verified ARM64 code are retained in
[partial stack evidence](measurements/hash-stack-intermediate-2026-10-16.json).
Small/large requests fall to 18/4,098 while retains remain 4,096/1,024. This does
not establish four-host acceptance or a universal timing improvement.

Combined native `38861843203` at `a2f4ccd9` passes hash semantics, the repaired
negative control, range allocation budgets and failure cleanup on ARM macOS.
Its range bound-order fixture failed because named constant functions lacked
explicit generic/concrete signatures. The fixture now has concrete unit-input
signatures; accepted-interpreter checks confirm bound order and the first trap
(0.25 s each). Rerun native semantics; no assertion was weakened. WASI and cost
runs need not restart for this test-source correction. No preparation change
has full production acceptance yet.

Guarded local formatting passes (1.07 s), docs (2.70 s). The tiny range fixture
passes using the accepted #148 interpreter (0.24 s), confirming example syntax
and expected boundary values only. No changed compiler was built locally.
The earlier diagnostic compile guard stopped with an OS signal error; no process
remained and limits were not raised. Compiler validation stays on CI.

## Following work

Measure whether tuple fields still need per-hash retains, then target remaining
C/Rust gaps with generated code and equivalent inputs. Browser/services, retained
host callbacks, numerical/network contracts, derivative scaling and OpenCL's
runtime compilation remain open. The baseline and paired reports in
[benchmarks](benchmarks.md) retain slower samples; fewer allocations alone is not
proof of improved speed. Broader representative programs remain required.

Library SIMD comments now state the actual C-loop implementation and possible C
compiler vectorization, replacing an unsupported vector-extension guarantee.
Generated docs were refreshed through `tests/stdlib_doc.rs` using the standalone
generator (guarded 1.07 s). Borrowed-field fixtures pass the accepted interpreter
(0.25 s); formatting/docs pass (1.06 / 2.57 s). No changed compiler was built locally.
