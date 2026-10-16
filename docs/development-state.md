# Session handoff

Independent following preparation: `/private/tmp/fwp-hash-borrows`, branch
`borrowed-hash-arguments`, anchored at `28cc4d0e`. Transfer only later commits.
The active delivery and combined predecessor below must merge first.

Next: validate an explicit nonescape contract for hash, using existing stack
placement to remove per-hash heap tuples. Require raw/native agreement, retained
aliases, GC stress, actual WASI physical frees, a disabled-stack negative control
and repeated C/Rust costs before claiming improvement. The implementation is
unverified; no new PR is open for this preparation.

Updated 2026-10-16. The only open delivery is [PR #150](https://github.com/e6qu/fun-with-pipes/pull/150),
head `7a7b40e1878ea062f64eceded6ae029b4124f976`. Eight of nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/38851567232)
pass; Linux AMD64 is running. [Documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/38851565415)
passes at the same head. Root worktree branch: `owned-list-text-delivery`.
[PR #149](https://github.com/e6qu/fun-with-pipes/pull/149) is accepted as `58ed740c`.
Its duplicate post-merge production run `38851195546` is canceled.

Combined preparation lives in `/private/tmp/fwp-wasi-delivery`, branch
`wasi-hash-delivery`, based on #150's exact head. It transfers only
`e5e05748..dcedb71b` from `/private/tmp/fwp-wasi-arc` / `checked-wasi-ownership`.
Source/runtime/library trees match `562873af`; workflow differences preserve
all #150 Windows cancellation and zip/fold coverage. Do not replay old parents.
This preparation has no PR yet.

Next: when #150's nine exact-head production jobs and docs pass, squash merge,
verify tree equality, parent and message, and cancel redundant post-merge CI.
Rebase only combined commits after `7a7b40e1` onto that verified merge. Update
PLAN/history/this handoff, publish one combined delivery PR and require its own
nine production jobs plus docs. Fix failures; focused success is not acceptance.

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
formatting and report checks may still run under the fixed guard. Paired report
retention and sample inspection each passed in 0.14 s.
