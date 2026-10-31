# Callable comparison preparation

**Next:** finish PR #233 in `/private/tmp/fwp-state-range-folds`, then integrate
its verified merge before publishing this branch as the next single PR. The
State worktree's handoff owns current CI status and prepared repairs. PR #232
is already verified and merged as `c71ac217`; do not resume its old retry.

This worktree is `/private/tmp/fwp-returned-callables`, branch
`returned-callable-peers`, protocol anchor `8c77d111`, based on State
source `903b1819`. No PR is open for it. Tracked measurement files are restored
for the docs audit; 322 MB was checked against the 64-GiB free-space floor first.
The peer preparation is published through `df8f9ce8`; its commit message is
verified as one line with no body or trailers.

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

The `returned_callable_peer.fwp` fixture passes raw and
optimized checksum controls at all four sizes and emits typed callback C in
0.48s with the verified `a7f62461` packaged compiler. It retains callable metadata
without constructing the identity record in an observed phase. Generated C is
`/private/tmp/fwp-returned-peer-preflight/fwp.c`; the two workers have native arity
two. Their function descriptor drops through `fwp_closure_drop`; do not assume
a generated `fwp_dropN` number identifies function values.

The native probe should keep the generated program's ordinary `main` and runtime
thread initialization. Replace only its `fwp_exec` invocation with the external
observer. Export the existing borrowed-application and closure-drop helpers in
that generated measurement source instead of adding a forwarding invocation
layer. Construct real partial applications with the typed function-table IDs;
check arity and owned entries before observation. The source names and metadata
must be validated, not inferred from a fixed generated function number.

The maintained boundary generator is `scripts/returned-callable-source.py`, with
C fixtures for construction, failure recovery and separate phase counters.
The shared observer checks direct and indirect results separately. Clang O1/O2
ordinary and instrumented binaries pass eight rows, four failure/retry cases,
ten overflow cases, and an omitted-release control that preserves every result
but fails storage validation (1.80s, 0.43s CPU). C/Rust peers pass their updated
shared observer at both levels (1.93s). Scripts/data remain under
`/private/tmp/fwp-check-returned-phases.py` and the preflight folder.

Local observations: each fwp closure requests 16 payload bytes; each borrowed
call executes one retain, one release and two runtime application entries.
Normal destruction restores payload storage. The allocator's first count table
adds 4,096 bytes that remain available for reuse; this is reported separately,
not called zero memory. These are preliminary Clang observations, not GCC or
complete comparison results. `returned-callable-results.py` validates complete
phase records; its five rejection tests pass (0.13s). The runner collector
`check-returned-callables.py` retains commands, outputs, actual binaries and
separate frame/code records. Its explicit `--rust-frame-pass` handles the local
LLVM 22 `prologepilog` setting versus CI LLVM 23 `prolog-epilog`; mismatches fail.
Six local Rust frame records pass (0.49s); the existing three buffer-record tests
still pass (0.13s). All callers now supply that setting explicitly; historical
buffer records keep their original pass and acceptance rules.

The `returned-callables` numerical workflow runs all three declared hosts at
O1/O2. Workflow lint passes (5.77s), fwp/Rust formatting passes (0.01s/0.25s),
and collector imports/CLI pass (0.13s). No full local evidence collection ran.
The roadmap audit passes (2.60s): 190 link sets, 106 immutable preparation pairs,
eight steps and commit subjects. `git diff --check` passes.
The first runner collection is pending; do not claim GCC verification or code/
frame totals before reviewing it. There is no speed claim.

## Work remaining in this batch

Publish this preparation and run the focused `returned-callables` workflow while
#233 finishes. Audit all three reports and repair any failure together. Before
opening the next PR, integrate verified #233, retain the accepted reports and
complete the independent evidence checker. Do not invent zero-allocation or
speed results. The shared-input service repairs must be integrated before full
production tests run here.

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
