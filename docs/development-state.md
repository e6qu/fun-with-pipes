# Current work

**Next:** publish the audited repair batch for draft [PR #216](https://github.com/e6qu/fun-with-pipes/pull/216),
then rerun focused compiler/admission checks before the full final-head matrix.
The old focused head is `0f33476f2baa98a88392cafa7d1152c05cd25c46`, run
`40254088410`. Tracing has **not** been deleted.

Worktree: `/private/tmp/fwp-ownership-fault-matrix`.
Branch: `remove-tracing-runtime`, based on merged #215.
The primary checkout is detached at #209; preserve its operational handoff and
untracked compiler-abort report. [PLAN.md](../PLAN.md) owns the remaining work.

## Verified starting point

PR #215 merged as `4e7b74be8e11634fac9309e67cb4efccfb34d360`.
Its tree equals tested head `bd77d65f58d8c5117ea678cb86cf15fbcf9231f7`:
`dad73fe097358b3f5842b5d44dcfc13b84fb6bac`.
All nine production jobs in run `40221722197` and documentation `40221722121`
passed. G3/G4 are delivered. [History](roadmap-history.md) records the changes.
Earlier repair logs are retained under `/private/tmp/fwp-215-ci/`; the successful
final run supersedes their failed heads.

## This batch

- Share function reachability and queue/State/autodiff lifetime checks between
  interpreter entry calls and native generation. Check gRPC handlers before
  opening a listener. Keep native representation and C ABI checks separate.
- Reject owning cycles before effects. Move the invalid inter-task derivative
  out of the supported-program corpus; retain explicit rejection and runtime
  defense controls. Preserve macros, compile-time calls and returned functions.
- Compare identical ARC-generated C with reuse enabled/disabled, retaining counts
  in both variants. Keep record/tree/array/map allocation budgets. Run ordinary
  long-loop and HTTP/REST memory checks in ARC with their existing RSS bounds.
- Replace stale G3/G4 directions and explain ownership, weak links, test controls
  and measurements with examples. Audit tutorials and links with the code.

## Checks and unresolved work

Guarded formatting, Cargo metadata/native schedule audit (254 targets), and
primitive inventory passed: 394 declarations, 384 symbols, 40 aliases, 373
contracts, 19 templates, no review entries. Commands:
`python3 scripts/local-guard.py python3 /private/tmp/check-fwp-callback-preparation.py`
and `python3 scripts/local-guard.py python3 scripts/check-primitive-inventory.py --baseline tests/fixtures/primitive-inventory-baseline.json --output /private/tmp/fwp-g5-primitive-inventory.json`.
The documentation audit passed 161 link sets, 106 preparation pairs/tags and
eight roadmap rows (`python3 scripts/local-guard.py python3 scripts/check-roadmap.py`).
Focused run `40254088410` was fully audited on GCC/Linux and Intel macOS.
Both passed 188 library tests, two task-timer tests, the API doctest, all completed
tool/entry targets, admission controls and six reuse tests. Six external gRPC
cases were ignored in this focused configuration; this is not full acceptance.
Both failed Clippy's helper-after-test-module rule and the same nested-autodiff
case. Logs are under `/private/tmp/fwp-216-focused/{linux-complete,macos-complete}`.

Repairs awaiting runner verification:

- Move the reachability helper before the IR test module.
- Filter impossible function origins from scalar expressions, using the existing
  type rules already applied to function results. The old compiler reproduces
  the rejection for direct raw `rev.jacobian with-unused`, while an enclosing
  loop or optimization makes it pass. The new reduced regression checks raw and
  optimized interpretation/native code; the proof model gains no new contexts.
- Unset `FWP_NO_OPT` for optimized controls: even the value `0` disables passes.
- Keep the collection-off loop check on the ordinary ARC executable, so it does
  not accidentally run the deliberately count-free control without collection.
- Check macro/compile-time rejection and REPL recovery before output; retain C,
  binaries and allocation reports for the reuse comparisons.

Guarded fixture syntax/type checks passed with the saved #215 compiler
(`/private/tmp/fwp-g5-check-fixtures.py`). The saved-compiler reduction driver
`/private/tmp/fwp-g5-reduce-ad.py` confirms the pre-existing raw native rejection;
neither verifies the current compiler repair. Current docs and tutorial changes
passed the full link audit again. No full local build/suite/benchmark ran.

G2's N/2N/4N analysis baseline remains unmeasured. This batch reuses the existing
proof, without increasing precision. Subsequent G5 work removes tracing code,
selection, collector-only assertions and report fields, then checks actual
binaries. ARC minimization A2–A6 remains a separate milestone.

The [Intel compiler abort](measurements/compiler-abort.md) remains unexplained;
passing reruns do not establish its cause. Investigate any recurrence from the
source/input, without restarting disassembly-led allocator experiments.

## Delivery

Keep the old #214/#215 publisher scripts stopped; they contain obsolete docs.
No new publisher or merge watcher is running. Standing authorization covers
publication and squash merge after all exact-head gates pass. Supply one subject
of at most 80 characters and an empty body, then verify the merge result.
Continue the plan after merging; a PR is not the whole roadmap.

## Roadmap status

| Step | Status | Remaining acceptance |
|---|---|---|
| 1 | In progress | G2 analysis baseline; G5 shared admission, test migration and tracing deletion |
| 2 | In progress | A2–A6 residual-cost baseline, unique buffer and scoped workspace |
| 3 | In progress | F1–F3 function-call and recursion costs |
| 4 | In progress | P1–P3 measured CPU budgets |
| 5 | In progress | D1–D3 derivative correctness and time/storage budgets |
| 6 | In progress | N1–N2 numerical accuracy and kernel budgets |
| 7 | In progress | B1–B2 reproducible comparisons and enforced budgets |
| 8 | In progress | V1–V2 application correctness, cleanup and scaling matrix |
