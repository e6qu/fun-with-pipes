# Current work

**Next:** run the batched repairs on focused runners while finishing the audit
of production run `40262766433` for [PR #216](https://github.com/e6qu/fun-with-pipes/pull/216),
previous head `0db38df8bd0b3ea6f4dc1165edd985bc82c71ccb`. Keep the PR draft during
focused validation so another full matrix does not start prematurely. After the
remaining old-head results and repair checks are audited, mark ready for complete
final-head production verification. The original run continues unchanged.
At the previous head, both Windows queue/callback steps and both ARM64 macOS shards failed; Linux and
Intel macOS are still running. Both Windows diagnostic bundles confirm exactly
three stale interpreter-success expectations
in `queued_functions`: captured channels, task-bearing queues and a cached
self-owning task result. All other targets in its early diagnostics passed.
Logs: `/private/tmp/fwp-216-final-win-{amd64,arm64}`. The repair requires
raw/optimized rejection in both engines, including weak acquisition and AD scope
controls. ARM64 macOS adds two startup timeouts: REST forms client (60 seconds) and raw
REST ownership entry (30 seconds). The captured compiler took 26.1 CPU seconds to start the forms interpreter
under the local guard. A stack sample identifies repeated lifetime-proof type
walks. The repair skips irrelevant result refinement, preserves child
visits/scope checks, and shares the initial existential type traversal. It adds
a runner-only 10-second analysis budget for both REST inputs; startup deadlines
are unchanged. Focused runner verification is pending. Its second shard also has the same three queue failures.
All other completed ARM64 shard targets passed. The saved ARM64 crash report
is the intentional `cleanup_panic_aborts_before_borrowed_tasks_escape` control,
not a recurrence of the unrelated Intel compiler abort.
Later Windows, Linux and Intel macOS target results still need full audit.
Previous-head documentation `40262732309`, paired analysis budgets `40262766768` and the
production benchmark job passed. Earlier draft skip `40262732305` is not a gate.
All ten affected queue/task fixtures passed the new rejection expectations
with the captured final-head compiler: raw/optimized, interpreter/native emit-C
(40 cases). This verifies expectations, not the unpublished performance repair.
Guarded command: `python3 scripts/local-guard.py python3 /private/tmp/fwp-check-rejection-expectations.py`.
Profile: `/private/tmp/fwp-rest-start.sample`; guarded command:
`python3 scripts/local-guard.py python3 /private/tmp/fwp-probe-rest-start.py`.
No merge until all nine production jobs, analysis budgets and docs pass the repaired
final head.

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
Duplicate main run `40252320511` was cancelled after auditing completed steps;
its identical source tree was already verified.

## This batch

- Share reachable-function and queue/State/autodiff lifetime checks between
  interpreter entry calls and native generation. Check gRPC handlers before
  opening a listener; retain separate native representation/C ABI checks.
- Reject owning cycles before effects. Keep explicit unscoped-derivative rejection
  and runtime-defense controls outside the supported-program corpus. Cover macros,
  compile-time calls, REPL recovery and returned functions.
- Fix a false rejection: two partial applications of `uncurry3` were merging
  their captures and inventing an unscoped call. Separate finite IR creation
  positions; keep actual invocation scopes and rejection of real escapes.
- Compare identical ARC-generated C with reuse enabled/disabled, retaining counts
  in both. Preserve allocation budgets and long-loop/HTTP/REST memory limits.
- Replace stale plans and weak/callback claims. Explain tutorial concepts, numeric
  results, macro checking order, derivative lifetimes and benchmark boundaries.

## Checks and evidence

Focused run `40259739899`, source `bf2793f196da45fee26258b0f7aaf4ca1ad1cdb3`,
passed on GCC/Linux and Intel macOS: formatting/Clippy, 189 library tests, task
cleanup/doctests, all seven nested-autodiff cases, two cycle/macro cases, six reuse
cases, admission controls and tool targets. Six external gRPC cases are ignored
in this focused configuration; it does not replace full production acceptance.
Logs: `/private/tmp/fwp-216-sites-{linux-admission,mac-complete}`.

Paired analysis run `40261359439`, source
`092009f83a1ba217820f2495d459fdb5c3b10c74`, passed both hosts, including all library
tests and the explicit scaling test. [The report](measurements/ownership-analysis.md)
records 16/32/64-worker samples, source hashes, counts, process RSS and limits.
The old merging rule exists only as a test control. Measurement instrumentation
is absent from production builds. Documentation run `40261345487` passed.
Final budget assertions passed both hosts in `40262766768`.

Earlier failures were fully audited and repaired: helper placement for Clippy;
incorrect `FWP_NO_OPT=0` controls (presence disables optimization); the closure
capture merge above; one native-check test caller given the wrong argument; and
missing evidence when the isolated harness failed to build. Source/log evidence
is in `/private/tmp/fwp-216-focused/`, `/private/tmp/fwp-216-repair-*/` and
`/private/tmp/fwp-216-paired-all-failures.log`. Passing later sources supersede
those failed heads; scalar-origin filtering alone did not fix the scope defect.

Guarded formatting, metadata/native schedule audit (254 targets), primitive
inventory and documentation checks passed during implementation. Inventory:
394 declarations, 384 symbols, 40 aliases, 373 contracts, 19 templates, no review
entries. Links: 162 sets, 106 preparation pairs/tags and eight roadmap rows.
Commands use `python3 scripts/local-guard.py` with:

- `python3 /private/tmp/check-fwp-callback-preparation.py`
- `python3 scripts/check-roadmap.py`
- `python3 scripts/check-primitive-inventory.py --baseline tests/fixtures/primitive-inventory-baseline.json --output /private/tmp/fwp-g5-primitive-inventory.json`

Saved-compiler syntax/type checks and a reduced IR model helped diagnose the
scope issue; the runner results above verify the actual repair. No full local
build, suite or benchmark ran. Draft production skips are not passing gates.

## After this batch

The unpublished `/private/tmp/fwp-delete-tracing` checkout, branch
`delete-tracing-collector`, starts from the current #216 head. It contains an
incomplete collector deletion, allocator/accounting migration and updated focused
allocator probes. Its own handoff lists the remaining test/report/caller changes;
do not publish or claim the integrated checkout builds. Rebase it onto verified merged #216 after this repair.

G5 still removes tracing selection/code, collector-only assertions and reporting
fields, then checks actual binaries. Use the deletion map in
[ownership diagnostics](ownership-diagnostics.md). ARC minimization A2–A6 is
separate. The [Intel compiler abort](measurements/compiler-abort.md) remains
unexplained; investigate recurrence from source/input, not disassembly guesses.

Keep old #214/#215 publisher scripts stopped; they contain obsolete docs.
No merge watcher is running. After all exact-head gates pass, squash-merge with
an explicit subject of at most 80 characters and an empty body, then verify it.
Continue the plan after merging; one PR does not complete the roadmap.

## Roadmap status

| Step | Status | Remaining acceptance |
|---|---|---|
| 1 | In progress | G2/G5 final validation, then tracing deletion |
| 2 | In progress | A2–A6 residual-cost baseline, unique buffer and scoped workspace |
| 3 | In progress | F1–F3 function-call and recursion costs |
| 4 | In progress | P1–P3 measured CPU budgets |
| 5 | In progress | D1–D3 derivative correctness and time/storage budgets |
| 6 | In progress | N1–N2 numerical accuracy and kernel budgets |
| 7 | In progress | B1–B2 reproducible comparisons and enforced budgets |
| 8 | In progress | V1–V2 application correctness, cleanup and scaling matrix |
