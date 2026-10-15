# Session handoff

Updated 2026-10-16. [PR #147](https://github.com/e6qu/fun-with-pipes/pull/147)
merged as `c9127d2d` after all nine production jobs and documentation passed for
`71c612d0`. Its files and prescribed single-line message were verified; duplicate
post-merge production run `38825167262` was canceled. The history records links.

The current delivery is branch `record-moves-and-utilities` in
`/Users/zardoz/projects/fun-with-pipes`, based on accepted `c9127d2d`. It contains
only the changes after old preparation anchor `a2679ecb`, transferred from
`move-unboxed-fields` at `81d113aa`. Runtime/compiler files match that preparation;
#147's separate parent fixes remain. Measurement revisions are retained under
remote `roadmap/revision-record-moves-*` tags. No old preparation is a new task.

Standing authorization: fix failures, require all nine production jobs and docs
for the exact final head, then squash merge with an explicit one-line subject of
at most 80 characters and an empty body. No trailers or attribution. Continue to
the next substantial PR without requesting permission. JIT is excluded.

## Roadmap status

[PLAN.md](../PLAN.md) defines completion; none of the seven whole areas is done.

| Step | Status | Next concrete work |
|---|---|---|
| 1 | In progress | Accept current ownership coverage; then own child-process boundaries |
| 2 | In progress | Accept field moves; measure remaining record wrappers and functional intermediates |
| 3 | In progress | Diagnose remaining C/Rust matrix gaps; rejected helper stays out of runtime |
| 4 | In progress | Measure derivative timing/memory scaling after accepted F128 precision fixes |
| 5 | Pending | Broaden CPU kernels; resolve runtime OpenCL compilation under the no-JIT policy |
| 6 | In progress | Preserve comparable repeated measurements and establish regression criteria |
| 7 | In progress | Accept maintained directory/logging tests and extend process-heavy programs |

Next: publish this combined delivery and run its full final-head production/docs
gate. Fix any failures, merge when all gates pass, then deliver the separate
process preparation described below.

## Current batch and evidence

Record moves avoid temporary child owners when a flattened parent is immediately
dropped or a boxed parent is unique. Shared parents retain their necessary child
references. Tests cover sibling cleanup, aliases, scalar pointer-like bits,
I128 boxes, retain overflow, later traps and original resource lifetimes.
Working-directory lookup owns copied results and scratch; unavailable directories
raise `Error[IoError]` kind `cwd` in both engines. Static empty maps/sets and
Boolean combinations have explicit contracts. Clock records are counted, and
structured logs now emit one newline per message. Windows probes preserve actual
binary symbol, native handle and cleanup checks.

- The complete focused batch, including clocks, the 192-report maintained
  application and neighboring ownership regressions, passes all six native hosts
  in [38823885563](https://github.com/e6qu/fun-with-pipes/actions/runs/38823885563)
  at `93156ee0`. Both memory modes run at O1/O2 with stress/reuse and negative
  cleanup controls where applicable. Earlier missing static/Boolean contracts
  and Windows fixture failures are repaired; no component failure remains open.
- Numerical solver/run evidence passes all four Linux/macOS hosts in
  [38817877068](https://github.com/e6qu/fun-with-pipes/actions/runs/38817877068)
  at `a3d8f16e`. Paired record-move evidence passes in
  [38821156704](https://github.com/e6qu/fun-with-pipes/actions/runs/38821156704).
  Eight products now have zero retains/nonfinal releases and sixteen release
  checks, versus 24/24/56. Forty allocations and 101,392 peak charged bytes remain;
  final charged storage and collections are zero. C/Rust use twenty-four
  allocations. Timings vary by host; the slower AMD64 matrix result is retained.
- Matrix output-parameter experiments pass correctness/profile checks in
  [38822697830](https://github.com/e6qu/fun-with-pipes/actions/runs/38822697830)
  and [38823092869](https://github.com/e6qu/fun-with-pipes/actions/runs/38823092869),
  but timing is mixed with repeated tracing slowdowns. The helper was not adopted.
  Both runs and actual AMD64 kernel instructions are retained in the measurement
  reports linked from [benchmarks](benchmarks.md). Smaller code is not a speed claim.

Focused local checks use `python3 scripts/local-guard.py COMMAND...`. After
transfer, formatting passes (1.13 s), primitive inventory passes (0.88 s), and
the docs/roadmap audit passes (2.56 s). Standalone stdlib regeneration/check
passed before transfer (0.48 s); generated library files are unchanged.
Inventory: 254 contracts, eight scalar signatures, 97 review declarations,
19 templates, 87 review symbols. Local edited-C probes are supplemental; they
are not changed-compiler acceptance. Full builds, suites and timings stay on CI.

## Following process preparation

`/private/tmp/fwp-process-utilities`, branch `owned-process-utilities`, is based
on `81d113aa`; only changes after that anchor belong to the later batch. Its
runtime/contracts and handoff are currently uncommitted and must be preserved.
Do not include them in this PR. Once this delivery is accepted, transfer its
finished changes onto the new main and require another full final-head gate.

Eight baseline captured child calls leave 896 charged bytes when collection is
explicitly disabled; checked ARC correctly rejects the primitive. The local
process rewrite tracks argument scratch, pipe endpoints, child lifetime, spawn
actions and captured buffers, with counted results on both POSIX and Windows.
It also rejects NUL arguments consistently and preserves child stdio when pipe
handles occupy initially closed descriptors. Next there: add repeated-call,
partial-construction and OS-failure regressions; validate before publication.
Its local handoff records implementation state and the guarded baseline command.
