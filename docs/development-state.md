# Current work

**Next:** finish shared lifetime admission and ARC memory comparisons, overhaul
current guides/tutorials, then validate this combined G5 batch. No new compiler
build or CI run has tested these edits yet. Tracing has **not** been deleted.

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
New Rust code and tests still need compiler integration checks. Do not call the batch verified from formatting.
Run focused entry/lifetime tests on runners, then the full nine-job production
matrix and documentation audit for the final commit. Audit every failure before
publishing a repair. No full local build, suite or benchmark is authorized.

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
