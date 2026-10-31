# Callable comparison preparation

**Next:** finish PR #233 in `/private/tmp/fwp-state-range-folds`, then integrate
its verified merge before publishing this branch as the next single PR. The
State worktree's handoff owns current CI status and prepared repairs. PR #232
is already verified and merged as `c71ac217`; do not resume its old retry.

This worktree is `/private/tmp/fwp-returned-callables`, branch
`returned-callable-peers`, protocol anchor `8c77d111`, based on State
source `903b1819`. No PR is open for it. Tracked measurement files are restored
for the docs audit; 322 MB was checked against the 64-GiB free-space floor first.
The baseline and candidate budgets are published through `4f2defb2`; its commit message is
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
Run `41175225918` at `7d7cf98bc62944d6c040293f4d17543c3bb51470` passes all three
hosts, with complete logs audited and every retained command independently
recomputed (170 per host, eight programs each). Jobs: Linux ARM `124461279399`,
Linux AMD `124461279547`, macOS ARM `124461279553`. Artifacts:
`13032995375`, `13032730842`, `13032589018`, respectively. Full downloads/audits
are `/private/tmp/fwp-callables-*-7d7c*`; log auditor is
`/private/tmp/fwp-audit-callable-jobs.py`. No unexpected diagnostic remains.

The complete 8.1-MB compressed baseline is retained in
`docs/measurements/returned-callables-baseline-2026-10-31.json.gz`; the immutable
tag `roadmap/returned-callables-baseline-2026-10-31` preserves its source for fresh
clones. Three archive tests pass (3.24s), recomputing all hosts and rejecting
13 damaged records. The protocol records the full cost/code/frame table and
declares the next candidate's limits **before its implementation**. There is no
speed claim or full production acceptance of this preparation.

## Work remaining in this batch

The unpublished candidate now enters the existing owned function directly for
initial, exactly saturated borrowed calls whose complete argument metadata has
no owned parameters. Returned callables during overapplication remain consumed.
Handwritten String/wide-value callback metadata is corrected; the copied-list
key callback now consumes and protects its String argument like generated entries.
No new metadata field, forwarding entry or language syntax was added.

The new `borrowed_callbacks` regression covers pointer-shaped scalar bits, aliases,
owned results, under/overapplication, typed failures, inside-callback failure and
cancellation, followed by reuse. Its intentionally missing returned-owner guard
must leave arithmetic intact but fail storage validation (229). Guarded Clang
O1/O2 C preflight passes; all four binaries were checked again in 0.13s after
tool output was lost. The temporary scripts use the retained generated C with
the exact current runtime function and real allocation-ledger instrumentation;
they do not replace production Rust-test or GCC verification.

`/private/tmp/fwp-check-returned-candidate.py` passes ordinary/profiled O1/O2
outputs, cleanup, retries and failure controls (2.16s). Invocation has zero
retains/releases and one helper entry. `/private/tmp/fwp-check-plain-functional.py`
passes all known cost rows at 32/128 and O1/O2 (1.72s): both State cases now have
one helper entry, with unchanged allocations. Maintained expectations are updated.
The budget checker has three passing tests (0.37s), including 18 damaged limits
across the three frozen hosts. Current full Rust/native tests still need runners.

The metadata/caller audit is complete. Generated metadata checks every parameter
in the complete arrow spine; remaining entry-only grpc fixtures are deliberately
unused call records, and the State-slot callback takes only unit. Existing
non-null no-op destructors conservatively keep their old path. Eleven affected
test targets are included in the focused runner batch, with `--no-fail-fast`.
Archive verification passes again (3.08s), workflow lint passes (5.61s), and the
roadmap audit passes (3.02s). Rust formatting uses the project's 2021 edition
(0.14s); an initial check mistakenly selected 2024 and only reported style diffs.

Next for this branch: publish the coherent candidate, then dispatch
`returned-callables` with its affected ownership targets and fixed budget
comparison. The active #233 head is untouched.

Use the declared 105% worker/text limits, +64-byte frame limits and zero effective
invocation counts on all three O1/O2 hosts. Keep constructor/destructor storage
unchanged and the missing-release rejection intact. Before opening the next PR,
integrate verified #233 and run the complete final gates. Its shared-input service
repairs must be integrated before full production tests run here.

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
