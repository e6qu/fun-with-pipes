# Session handoff

Updated 2026-10-16. [PR #147](https://github.com/e6qu/fun-with-pipes/pull/147)
merged as `c9127d2d` after all nine production jobs and documentation passed for
`71c612d0`. Its files and prescribed single-line message were verified; duplicate
post-merge production run `38825167262` was canceled. The history records links.

The current delivery is [PR #148](https://github.com/e6qu/fun-with-pipes/pull/148),
branch `record-moves-and-utilities`, in
`/Users/zardoz/projects/fun-with-pipes`, based on accepted `c9127d2d`. It contains
only the changes after old preparation anchor `a2679ecb`, transferred from
`move-unboxed-fields` at `81d113aa`. Runtime/compiler files match that preparation;
#147's separate parent fixes remain. Measurement revisions are retained under
remote `roadmap/revision-record-moves-*` tags. No old preparation is a new task.

PR #148's exact final head is `93b1741abcf5ab2a61460746c0077564e0328c0e`.
[Production 38825629531](https://github.com/e6qu/fun-with-pipes/actions/runs/38825629531)
is queued/running; [docs 38825487182](https://github.com/e6qu/fun-with-pipes/actions/runs/38825487182)
passes. A GitHub ready-event race started `38825485034` for the preceding
`fd7d852d` head; it was canceled and replaced after verifying the current PR head.
Ignore that run and skipped draft jobs. Keep the final head unchanged for CI;
these local progress notes belong in the following delivery.

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

Next: monitor this combined delivery’s full final-head production/docs gate.
Ignore skipped draft jobs. Fix failures, merge when all gates pass, then deliver the separate
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

## Local process implementation and next checks

This handoff is in the later process preparation worktree, whose base remains
`81d113aa`; the active PR #148 is in the root worktree. No process PR is open.
The initial POSIX/Windows runtime and contract changes are uncommitted.

Baseline `/private/tmp/fwp-process-baseline.py` passes under the guard (1.21 s):
#147's downloaded compiler rejects checked ARC; eight captured child calls with
tracing collection disabled leave 896 charged bytes. A first attempt to switch
the raw C directly to ARC was correctly rejected by unproved runtime sharing.
The revised `/private/tmp/fwp-process-mechanism.py` uses current POSIX cleanup and
borrowed argument emission in that baseline C; eight calls now end with zero
unreclaimed bytes (guarded 1.22 s). This is an edited-C mechanism check, not new
compiler or Windows acceptance. Generated C/logs are in matching `/private/tmp`
paths. Formatting passes (0.86 s).

The process owner tracks argument scratch, six pipe descriptors, child PID,
spawn actions and both output buffers. It closes descriptors and reaps a live
child on unwinding, checks spawn/read/wait errors, and counts/protects both copied
strings before making the result record. Windows uses its existing handle/reader
cleanup with the same protected result construction. Interpreter and native code
reject NUL arguments before OS calls. Child descriptors 0..2 are preserved when
pipes occupy initially closed standard streams.

The portable child fixture now exercises quoted/Unicode arguments, 64 KiB on
each output stream, 200 KiB input and early child exit. Repeated-call tests compare
raw interpretation with native tracing/ARC at O1/O2, with stress/reuse verification
and zero final charged ARC storage. A second regression forces copy/record/buffer
failures and POSIX poll/read/wait errors, retries interrupted waits, checks closed
descriptors and reaped children, and checks Windows handles. Missing-count and
missing-buffer-free controls must fail. The former Windows-only child fixture is
shared by existing Windows tests; their semantics are preserved.

Guarded supplemental probes: raw fixture passes (1.47 s), edited-C repeated-call
tracing/ARC check passes (3.27 s), and edited-C failure/negative-control check
passes (6.30 s). They use the accepted #147 compiler with the current POSIX
runtime inserted into its emitted C; actual new-compiler acceptance remains on
CI. The negative count check accepts either an uncounted outer record or extra
child counts when a generated worker reconstructs the shared outer record.

Formatting passes (1.11 s), standalone library-doc regeneration/check passes
(0.62 s), and primitive inventory passes (0.50 s): 256 contracts, eight scalar
signatures, 95 review declarations, 19 templates and 85 review symbols.

The docs/roadmap audit passes (2.40 s). CI retains emitted repeated-call and
failure-probe C for inspection.

Next: publish this preparation for the six-host `processes` suite. Fix actual compiler/platform
failures, then transfer only changes after `81d113aa` once #148 is accepted. Full
production acceptance must use that later PR's final head.
