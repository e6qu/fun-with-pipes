# Current work

**Next:** publish the measurement-harness repair, dispatch `ownership-analysis`,
record both hosts' paired results and budgets, then run the full final-head
matrix for draft [PR #216](https://github.com/e6qu/fun-with-pipes/pull/216).
The creation-site repair passed Linux focused run `40259739899`; Intel macOS
passed its lifetime/reuse stages and was finishing tool checks. The paired run
`40260929945` failed to compile one test caller on both hosts; see below.
Tracing has **not** been deleted.

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
final run supersedes their failed heads. Duplicate main run `40252320511` was
cancelled to free capacity after checking that no completed step had failed;
its source tree was already fully verified in #215.

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
The documentation audit passed 162 link sets, 106 preparation pairs/tags and
eight roadmap rows (`python3 scripts/local-guard.py python3 scripts/check-roadmap.py`).
Focused run `40254088410` was fully audited on GCC/Linux and Intel macOS.
Both passed 188 library tests, two task-timer tests, the API doctest, all completed
tool/entry targets, admission controls and six reuse tests. Six external gRPC
cases were ignored in this focused configuration; this is not full acceptance.
Both failed Clippy's helper-after-test-module rule and the same nested-autodiff
case. Logs are under `/private/tmp/fwp-216-focused/{linux-complete,macos-complete}`.

Repair run `40256218403`, head `e02ef58e51de3b33e27b37fc954a2017bbd6697f`,
fixed Clippy and passed the existing cleanup/admission/reuse/tool checks on Intel
macOS. GCC/Linux also completed all tool checks and has the same two remaining
raw-autodiff failures. Both hosts were fully audited. The new reduced Jacobian case fails
the same way as the older nested case. Scalar-origin filtering did not fix it.
Logs: `/private/tmp/fwp-216-repair-{mac-complete,linux-complete}`.

The reduced typed IR identifies the cause: partials of `uncurry3 vjp` and
`uncurry3 rev._vjp`, both created outside AD, share one capture identity. This
invents a call to the inner worker outside its real scope. A five-line `uncurry`
example also reproduces with the saved #215 compiler. Distinct creation sites
make the diagnostic model converge, but runner tests must verify the Rust fix.

The current repair indexes partials by finite expression/constant positions as
well as function, supplied argument count and creation scope. Invocation scopes
still control admission. A new State regression distinguishes two partials
created in the same function before a handler and rejects a real unscoped call.
The [G2 analysis measurement](measurements/ownership-analysis.md) uses 16/32/64
workers, raw lowering, seven timed proofs, counts and process peak RSS. Linux
passed the new State control, all seven autodiff tests and six reuse tests in
`40259739899`; its first measurement completed at 11.5/20.0/37.3 ms. These samples
are from the initial fixture, not the local paired comparison. The latter uses
the same valid IR with the old capture-merging rule as a test-only control;
production has no alternate mode. Its isolated suite avoids rerunning unrelated
integration targets just to collect analysis evidence. Record results and budgets before accepting this change. Production
builds contain no measurement counters. Paired run `40260929945` at `cc86e2f0`
failed because one `crate::arc::check` call received the analysis-only fourth
argument. Both hosts reported only this compiler error and a consequent missing
artifact directory; all failed steps were audited. The repair removes that
argument and creates evidence before building, retaining the build log. The
isolated suite runs the inexpensive library tests before the paired measurement.
Failure logs: `/private/tmp/fwp-216-paired-all-failures.log`.

Tutorial corrections now include macro checking order, numeric output reasoning,
`iterate 5` meaning four updates, derivative lifetimes, and delivered weak/graph
support. Guarded syntax/type checks of the generated scaling source passed after
fixing its recursion declaration, names and explicit Async signatures. Those
checks used the saved compiler and do not verify the current proof repair.

Subsequent G5 work removes tracing code, selection, collector-only assertions and
report fields, then checks actual binaries. ARC minimization A2–A6 is separate.

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
