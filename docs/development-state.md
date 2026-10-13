# Session handoff

Updated 2026-10-13. The approved six-phase roadmap and accepted follow-ups are
merged through PR #131. The current task is a roadmap audit and documentation
cleanup. Broader efficiency gaps remain; [PLAN](../PLAN.md) separates them from
completed deliveries and recommends a next scope. Read [design](design.md) and
[ownership](ownership.md) for semantics and support boundaries.

Desired platforms: Linux, macOS and Windows on ARM64 (aarch64) and AMD64 (x86_64),
one binary per OS/architecture. Windows is desired but deferred on both
architectures; prioritize Linux/macOS, ownership and compiler performance.
Universal binaries are not an objective. Native macOS ARM64/AMD64 support is
accepted; Linux ARM64 has cross-build/QEMU coverage but full native acceptance
remains to establish. The existing six CI jobs do not prove all six targets.

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

The current audit confirmed remote main at the squash above and no open PRs.
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

The delivery adds ordinary library functions and parser expansion, without new
runtime primitives or fusion eligibility rules. No allocation-free or universal
speedup claim is established. A guarded native fold probe returned 4950 for
100 elements and showed a fixed-frame loop with record allocations and callback
dispatch. It used an older available compiler with the new definitions; it is
not current-head performance evidence. Temporary C, Mach-O and disassembly:
/private/tmp/fwp-iterator-code. Rebaseline with the current compiler on CI before
accepting an optimization. The latest combined implementation is verified by
the exact-head CI above, not by that exploratory probe.

Checked ARC covers proved immutable graphs and scoped File owners. Unproved
cycles, reconstructed/runtime/foreign boundaries, boxed I128/U128 and raw
reverse-mode lifetimes remain outside its coverage. Rejection never selects
tracing. [Ownership](ownership.md) records the exact contracts, half/wide float
representation limits and the distinction between C ABI structure and registers.

## Remaining ownership deliveries

None in the completed six-phase delivery queue. Broader ownership and performance
gaps are listed in PLAN.md; do not reopen archived preparations. Windows, new
deployment interfaces and a new backend remain deferred.

## Active bundle and workspace

The user authorized all ten tasks in PLAN.md as one PR, including docs cleanup.
Branch: `roadmap-status-audit`, base `8ae361a43f76`. Windows stays deferred.
Task 1 is prepared locally. Tasks 2–4 now have CI/native artifact and measurement
implementations awaiting runner execution; tasks 5–10 remain to implement.
No task is accepted for this bundle yet. Earlier PR #131 gates above validate
only its source, not these changes.

Initial findings: Linux ARM64 currently uses cross-build/QEMU tests, not a native
CI job. Wide integer boxes use leaf allocation without counted ownership. ARC
rejects all AD primitives, so scoped eligibility requires an actual lifetime
proof. Preserve these restrictions until replacement contracts are verified.

The preceding documentation-only audit passed guarded check-roadmap.py
(44 link sets, 106 immutable pairs/tags, zero legacy live rows) and diff --check.
The new Python script syntax, documentation and whitespace check also passed
under local-guard (0.36s sampled CPU / 2.89s elapsed). Full builds, tests,
benchmarks and evidence regeneration stay on GitHub runners.

## Next action

Add native Linux ARM64 CI and independently runnable artifacts for all four
current OS/architecture combinations, prepare baseline combinator evidence,
then implement tasks 5–10. Publish one PR and require all final-head existing
and newly added gates before the one-line, trailer-free squash merge.
