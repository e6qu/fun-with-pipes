# Session handoff

Updated 2026-10-16. This file is the current action list; [PLAN.md](../PLAN.md)
defines the remaining project work. None of its seven whole areas is complete.

## Accepted and active deliveries

[PR #150](https://github.com/e6qu/fun-with-pipes/pull/150) merged as
`729db67f71386750aad0bbe477f546e5276b0223` after all nine production jobs
`38851567232` and docs `38851565415` passed for `7a7b40e1`. Tree, parent and
one-line/empty-body message were verified. Duplicate `38860909658` is canceled.

The only open delivery is [PR #151](https://github.com/e6qu/fun-with-pipes/pull/151),
branch `wasi-hash-delivery` in `/private/tmp/fwp-wasi-delivery`, final head
`796f5a4c3cd920eb49f709f9a0a5551dc98481fc`. Docs `38861611496` passes; production
`38861611494` is running. Require all nine jobs and docs for that exact head.
Earlier `38861119765` was canceled after repairing the allocation test counter.
That PR owns synchronous WASI ARC, streaming hash and callback/fusion changes.

The following preparation is `/private/tmp/fwp-hash-borrows`, branch
`borrowed-hash-arguments`, anchored at old pre-rebase `28cc4d0e`. After #151
merges, transfer only later commits onto its verified squash commit. Never replay
that old parent chain or open a second delivery PR while #151 is open.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Complete deployment and primitive ownership; remove tracing |
| 2 | In progress | Deliver borrowed hash fields and direct range arrays |
| 3 | In progress | Measure remaining C/Rust gaps and inspect generated code |
| 4 | In progress | Reduce derivative recording costs and validate scaling |
| 5 | Pending | Broaden kernels and resolve runtime OpenCL compilation |
| 6 | In progress | Retain comparable, repeated measurements and storage costs |
| 7 | In progress | Extend maintained programs across deployment boundaries |

## Current batch and acceptance

This worktree, `/private/tmp/fwp-owned-vectors`, branch `owned-vector-preparation`,
is a following preparation anchored at `aab2a928`. Transfer only its later commits
after the preceding borrowed-hash delivery is accepted. It is not another open PR.
The preceding preparation and its evidence remain in `/private/tmp/fwp-hash-borrows`.

Next: establish complete ownership for the nine vector-library primitives.
An accepted-compiler probe of `simd.splat | simd.sum` interprets correctly but is
rejected by checked ARC because the primitives lack reviewed ownership contracts.
The current runtime allocates uncounted vector/array wrappers, aliases source
arrays, and can abandon boxed accumulator values. Simply adding contracts is not
sufficient: partial construction, returned aliases and wide-number storage need
real ownership and failure cleanup.

The change must preserve lane order, wrapping integer operations, checked division,
float bits and immutable input aliases. Compare raw interpretation and native
O1/O2 under tracing stress and checked ARC across inline and boxed formats. Test
empty/singleton vectors, array views, invalid lengths, partial construction,
allocation failures and traps. Require negative controls that detect missing
cleanup and actual WASI physical frees, plus the full production matrix when
this batch becomes the only delivery PR. This is ownership work; no vector
instruction, heap elimination or speedup claim is planned without measurements.

## Checks and immediate work

The accepted #148 interpreter checks the lane fixture, including all fifteen
numeric formats, empty/singleton results, invalid lengths, array views and
retained aliases. The extended fixture also checks I128 wrapping, F128 precision,
signed zero and repeated boxed results; its syntax check passes (0.26 s).
Formatting passes (1.11 s). The inventory audit passes (1.11 s) with 271 contracted
declarations and 72 remaining distinct review symbols; its frozen baseline is
unchanged. These local results do not validate the changed compiler/runtime.

The prepared runtime now owns vector/array wrappers, shared boxed lanes and
reduction accumulators. Native tests compare raw/optimized interpretation with
O1/O2 tracing stress and checked ARC, and check final charged storage. A C probe
injects failure during both wrappers, partial lane arithmetic and accumulation;
a missing-array-free control must fail. The WASI ownership suite includes the
same lane program and its independent physical-allocation ledger/control.

Next: run the focused `vectors` suite on all six native hosts and `wasi-arc` on
both Linux hosts. Fix failures before calling this supported. Complete docs and
retained evidence before transferring only this worktree's delta after the
preceding delivery merges. No second delivery PR is authorized concurrently.

The earlier borrowed-hash batch now passes six native checks `38864599295`, two
WASI checks `38864602220` and four cost jobs `38864604854`. Its separate handoff
tracks paired timing `38866837452` and publication after #151. Those results do
not validate this vector change.

Standing authorization covers fixes, publication and passing-CI squash merge.
Every commit is one line, at most 80 characters, with no body or trailers. Use
`python3 scripts/local-guard.py` for bounded serial local checks; do not increase
limits or restart the refused optimizer compilation. Full builds, suites,
benchmarks and large regeneration run on CI. JIT is excluded. The full seven-area
roadmap remains in PLAN.md, with tracing removal as the primary objective.
