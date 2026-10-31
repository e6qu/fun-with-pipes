# Callable comparison preparation

**Next:** finish PR #233 in `/private/tmp/fwp-state-range-folds`, then integrate
its verified merge before publishing this branch as the next single PR. The
State worktree's handoff owns current CI status and prepared repairs. PR #232
is already verified and merged as `c71ac217`; do not resume its old retry.

This worktree is `/private/tmp/fwp-returned-callables`, branch
`returned-callable-peers`, protocol anchor `8c77d111`, based on State
source `903b1819`. No PR is open for it. Historical measurement copies are
omitted by sparse checkout; their Git objects remain intact.

## Work prepared

The [protocol](measurements/returned-callables.md) compares returned partial
addition and captured composition with C/Rust inline callable records. It keeps
creator-return lifetimes, repeated calls, checked arithmetic and explicit
construction/invocation/destruction observations. The common C observer and
Rust `core` library boundary are documented; this is not a whole Rust application
comparison. No elapsed-time acceptance is claimed.

Peer fixtures are `tests/fixtures/returned_callable_peer.{h,c,rs}`
and `returned_callable_peer_probe.c`. Both implementations return a function
pointer and inline scalar capture. The observer checks every result, independent
checksums at 0/1/16/4096 calls, both overflow directions and addition-before-
multiplication failure order. It uses separate translation units and no LTO.

Guarded Clang/Rust O1/O2 preflight passes: four binaries, each with eight
checksum/layout rows and twelve failure controls; 1.98s elapsed, 0.26s CPU.
Script `/private/tmp/fwp-check-callable-peers.py`; commands and objects are in
`/private/tmp/fwp-returned-peer-preflight`. These local checks do not establish
GCC support or a complete fwp/C/Rust comparison. No full build or timing run ran.

## Work remaining in this batch

Add the real fwp partial-application/borrowed-invocation boundary, typed-entry
preflight, phase counters, failure/retry and omitted-release controls. Preserve
ordinary startup/cleanup and record code, stack and storage separately. Run the
protocol on the declared production hosts after the implementation is complete;
retain all raw outputs and rejected evidence. Do not invent zero-allocation or
speed results for fwp. The shared-input service comparison repairs from #233
must be integrated before its tests run here.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain GC-free lifetime and cycle checks |
| 2 | Verified | Preserve scoped A1–A6; broader costs belong to B1 |
| 3 | Verified | Preserve the stated F1–F3 call/recursion scope |
| 4 | Verified | Preserve decimal savings and the recorded loop gap |
| 5 | In progress | Meet D2's remaining timing requirement |
| 6 | In progress | Resolve N1 controls before N2 timing acceptance |
| 7 | In progress | Deliver State reductions and finish B1/B2 comparisons |
| 8 | In progress | Complete numerical and integrated V1/V2 acceptance |

[PLAN.md](../PLAN.md) retains the unchanged budgets and failed timing controls.
This preparation does not close them or replace the active delivery order.
