# Session handoff

Updated 2026-10-16. [PR #150](https://github.com/e6qu/fun-with-pipes/pull/150)
merged as `729db67f71386750aad0bbe477f546e5276b0223` after all nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/38851567232)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/38851565415)
passed for `7a7b40e1878ea062f64eceded6ae029b4124f976`. Tree equality, parent and
the single-line subject with empty body were verified. Duplicate post-merge
production `38860909658` was requested canceled; confirm its terminal status.
[History](roadmap-history.md) records accepted work and limitations.

Current combined delivery: `/private/tmp/fwp-wasi-delivery`, branch
`wasi-hash-delivery`, based on accepted `729db67f`. Only commits after #150's
exact head were rebased onto its identical squash tree. Source/runtime/library
trees match preparation `562873af`; workflow differences preserve every #150
Windows cancellation and zip/fold test. The earlier preparation is
`/private/tmp/fwp-wasi-arc`, anchored at `e5e05748`; do not replay its parents.

Next: publish this combined WASI/hash delivery, then require all nine production
jobs plus documentation for its exact final head. Fix failures and squash merge
only after full acceptance. Focused checks below do not replace that gate.
Independent following preparation is `/private/tmp/fwp-hash-borrows`, branch
`borrowed-hash-arguments`, anchored at old pre-rebase `28cc4d0e`. It investigates
stack hash tuples and direct integer range arrays; transfer only later commits
after this delivery merges. Its focused runs are `38860420915` (six native hosts),
`38860423500` (WASI) and `38860426497` (costs), at `ed78f26a`, before range changes.
Do not open its delivery PR while this one remains open.

Standing authorization covers fixes, publication and squash merge. Commit messages
are exactly one line, at most 80 characters, with empty body and no attribution
or trailers. JIT is excluded. Local checks use `python3 scripts/local-guard.py`;
full builds, suites and measurements run on GitHub. Never raise resource limits.

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


## Combined changes and acceptance

WASI supplies files and streams to WebAssembly programs. Checked ARC now supports
synchronous WASI main/function/CLI entries through existing ownership checks.
Last-owner frees remove external count entries and physical storage. Counted
owners cannot escape into permanent retention; tracing/stress/reuse-retention
options are rejected. Counts still use an external hash table, so this is not
zero-cost ownership. Browser re-entry, services and host fibers remain excluded.
Native-library flags combined with WASM targets now fail instead of being ignored.

Fresh WASI numeric boxes acquire count entries when first claimed, unlike native
objects whose allocator already supplies slots. Tests restore the old missing-slot
return and require a physical leak failure. Actual WASI covers checked I128/U128,
F128, caught errors, derivatives, repeated collections/text and CLI/function entries.
Independent malloc/free ledgers run after real shutdown, with omitted-free and
omitted-derivative-shutdown controls. They do not force cleanup to pass.

Structural hash streams unchanged typed canonical bytes through FNV-1a, a wrapping
64-bit fingerprint, without a temporary encoded buffer. The interpreter's buffered
encoder remains an independent reference. Hash borrows its input and returns U64.
Native tests cover bit widths, NaNs/F128, Unicode/NUL, packed views, containers and
retained aliases at O1/O2 in tracing/ARC, plus a deliberately restored old buffer.

The optimizer recognizes total hash and integer AND/OR/XOR/NOT; shifts remain
excluded because they can trap. Known partially applied callbacks bind eager
captures once, left-to-right, before input evaluation. Existing specialization
and fusion then eliminate eligible result lists. Effects, distinguishable traps,
resource captures and unknown function bodies keep their original ordering and
representation. Tests compare raw/optimized interpretation and native behavior,
including empty input, capture traps and an effectful fold seed. No syntax,
implicit conversion or forwarding wrapper is added.

## Focused evidence and limits

| Check | Result |
|---|---|
| Complete capture/fusion semantics | [38856280599](https://github.com/e6qu/fun-with-pipes/actions/runs/38856280599), all six native hosts pass at `d1ae668f` |
| Fresh WASI owners and physical frees | [38857203804](https://github.com/e6qu/fun-with-pipes/actions/runs/38857203804), both Linux hosts pass at `96c3b637` |
| Initial C/Rust baseline | [38854304399](https://github.com/e6qu/fun-with-pipes/actions/runs/38854304399), all four hosts pass at `34600beb` |
| Post-fusion C/Rust comparison | [38856285939](https://github.com/e6qu/fun-with-pipes/actions/runs/38856285939), all four hosts pass at `d1ae668f` |
| Paired verified-binary repeat | [38859143208](https://github.com/e6qu/fun-with-pipes/actions/runs/38859143208), all four hosts pass at `fb79b29d` |

The later known-root callback restriction in `562873af` still requires the final
combined full gate. Earlier failed runs and canceled attempts are not acceptance.
The superseded WASI runs `38856283417` and `38856960546` are confirmed canceled.
[The preparation record](https://github.com/e6qu/fun-with-pipes/blob/dcedb71b/docs/development-state.md)
preserves original failures, repairs and earlier focused checks.

[Baseline](measurements/structural-hash-2026-10-16.json),
[post-fusion](measurements/hash-pipelines-2026-10-16.json) and
[paired repeat](measurements/hash-pipeline-cpu-2026-10-16.json) retain sources,
verified hashes, hardware, flags, raw samples and allocation scopes. Small
managed requests fall 12,309 to 4,114, retains 12,288 to 4,096 and peak charged
bytes 295,112 to 656. Large requests fall 7,173 to 5,122 and retains 3,072 to
1,024; peak remains 163,848. Final charged storage is zero on all four hosts.

Small paired ARC CPU ratios are 0.902/0.759/0.807/0.811 on Linux AMD64/ARM64 and
macOS ARM64/AMD64. Linux AMD64 elapsed time instead rises 7.7%, despite lower CPU.
Large results are mostly unchanged; traced Mac CPU medians rise 1.9–2.8% with
broadly overlapping samples. The repeated Intel Mac ARC/C gap is 32.7%, much
wider than the first run. Retain these limits; do not claim universal speedup or
parity. [Benchmarks](benchmarks.md#repeating-both-hash-pipeline-revisions-together)
explains timing scope, C/Rust overhead and the observed slower results.

[Machine-code evidence](measurements/structural-hash-code-2026-10-16.json) retains
six native and two WASI manifests. The Linux ARM64 hash body has a 96-byte stack
frame, register XOR/multiply and recursive traversal without encoder/allocator
calls. This is not a dynamic instruction/spill count. Full artifacts remain in CI.

## Following measured work

Generated code still allocates one tuple per hash and retains its array field;
`range | array.from-list` constructs temporary input list nodes. Prove an explicit
nonescaping hash parameter before stack placement; borrowing alone does not prove
that all primitive arguments cannot escape. Then measure remaining array counts
and direct input construction. These are candidates, not completed optimizations.
Browser/services, retained host callbacks, network/numerical contracts, derivative
workspace scaling and the OpenCL runtime-compilation policy gap remain open.

## Local validation and resources

No full build or suite ran locally. Guarded formatting passed (1.09 s), docs
(2.43 s), inventory (0.99 s: 262 contracts, 81 remaining review symbols), source-
comment documentation generation (0.38 s), and artifact hash checks (0.14 s).
Small edited-C/isolated-module probes are supplemental only. The accepted #148
compiler is `/private/tmp/fwp-148-compiler/fwp-macos-arm64/fwp`, revision `93b1741a`.

A later guarded diagnostic compilation stopped with an OS signal permission
error. No compiler/probe process remains; limits were not raised. Further compiler
validation moved to CI. Do not restart that refused local workload. Small docs,
formatting and report checks may still run under the fixed guard. Documentation passes
after handoff consolidation (2.54 s). Paired report
retention and sample inspection each passed in 0.14 s.
