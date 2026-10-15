# Session handoff

Updated 2026-10-15. Preparation branch `checked-linear-algebra` lives in
`/private/tmp/fwp-linear-algebra`; its parent anchor is `c10b1ccd` from the
current delivery. [PR #145](https://github.com/e6qu/fun-with-pipes/pull/145)
merged as `e51b8570` after all nine production jobs and documentation passed.
[PR #146](https://github.com/e6qu/fun-with-pipes/pull/146) remains the only open
PR, head `19b14d0b`, in `/Users/zardoz/projects/fun-with-pipes`.
Production [38803349673](https://github.com/e6qu/fun-with-pipes/actions/runs/38803349673)
is running. The Windows probe now initializes its synthetic task's stack-scan
boundary after reproducing missing-root corruption locally; preceding CRLF
output failures are also repaired. Final native Windows acceptance is required.

Standing authorization covers publication, fixes and squash merge after all
nine production jobs and documentation pass for the final commit. Use one line
of at most 80 characters and an explicitly empty body, with no trailers or
attribution. Bundle coherent work into one active delivery PR.

## Roadmap status

| Step | Status | Next concrete work |
|---|---|---|
| 1 | In progress | Validate C boundaries and solver scratch/result ownership |
| 2 | In progress | Remove measured closure, container and call costs |
| 3 | In progress | Diagnose remaining Intel array and matrix wrapper overhead |
| 4 | In progress | Investigate sustained derivative timing differences |
| 5 | Pending | Broaden CPU kernels and resolve runtime OpenCL compilation |
| 6 | In progress | Preserve comparable C/Rust measurements and profiles |
| 7 | In progress | Extend numerical and long-running application coverage |


## Prepared numerical batch

Scope: LU solve, determinant, inverse, Cholesky, QR and conjugate gradient.
Borrow inputs, copy their numbers into the existing scratch buffers and own each
buffer explicitly. One stack record tracks up to five scratch pointers and two
partial result arrays. Release scratch on return and singular exits, and release
scratch plus partial output when a trap unwinds. Results become counted owners
before they escape. Preserve the algorithms, floating-point operation order,
immutable input arrays and existing iteration limits. No new scheduling point.

QR also checks `n*n` output capacity before multiplication/allocation. Zero input
rows previously allowed arbitrarily large column counts through the input-shape
check. Interpreter and native checks preserve negative/input-length error order.

Acceptance requires raw interpreter/native agreement in tracing and ARC modes,
O1/O2, array slices and aliased inputs, empty/singular cases, zero iteration limits,
QR output overflow, forced GC/reuse checks, bounded repeated-call storage and
injected failures at scratch/output construction. Missing scratch release and
missing partial-result release must make the probes fail. New compiler tests run
on Linux/macOS ARM64/AMD64; final production CI must also cover native Windows.

The compiler also borrows F64 array data once before eligible loops. Every
`Again` must pass the exact same array parameter, and the body must read that
parameter directly. Changing arrays, bounds checks, ownership, cleanup and task
scheduling retain their established behavior. No public syntax or type conversion.

## Runner evidence

[Solver run 38795634707](https://github.com/e6qu/fun-with-pipes/actions/runs/38795634707)
passed all four Linux/macOS hosts at `ec1ff14b`, including formatting, Clippy,
solver cleanup and QR limits, invariant/changing-array regressions, existing
numerical/unwind tests, primitive inventory and measurements. The earlier
`42662770` run exposed an ARC-ineligible `read-all` in the QR test fixture;
the fixture now passes dimensions through an explicit function entry.
No ownership check was weakened. Later commits change comments, handoff and
the additional measurement script, not this tested compiler implementation.

[The retained report](measurements/numerical-array-borrows-2026-10-15.json)
contains raw samples, hardware/compiler details, equivalent C/Rust comparisons
and unchanged allocation profiles. Its baseline is the `candidate` section of
PR #146's current numerical report; that updated parent report arrives when
this branch is rebased onto the accepted squash commit.

ARC array/C ratios are 1.01/1.00 on AMD64/ARM64 Linux and 0.98/1.00 on Intel/ARM
macOS. Intel remains 1.74x Rust. In the actual AMD64 timed loops the borrowed
address stays in a register and scalar arithmetic is unrolled fourfold without
reassociation, fused multiply/add or stack traffic inside the arithmetic loop.
Intel ARC absolute time fell 7.5%, but C/Rust reference times rose about 33%.
Linux AMD64 tracing matrix time rose about 11% despite byte-identical matrix
executables. These shared-runner comparisons cannot assign a precise speedup.

[Paired run 38800569111](https://github.com/e6qu/fun-with-pipes/actions/runs/38800569111)
and [repeat 38801692547](https://github.com/e6qu/fun-with-pipes/actions/runs/38801692547)
passed all four hosts. They reuse validated emitted C, verify its hashes and
compare cached reads against per-element selection on the same runner. Only
load expressions change; arithmetic, owners and workload remain identical.
Intel macOS ARC kernel ratios repeat at 0.704/0.707; Linux ARM64 ARC at
0.965/0.967. ARM macOS ARC changes direction (0.968/1.021), and tracing is
slower (1.046/1.009). Generated ARM tracing code removes address selection
without adding loop spills but retains length reloads around root-liveness
fences. Keep both complete reports; no universal speedup claim is supported.
The same JSON retains both paired runs, raw samples and environment details.
Source-rewrite checks passed locally (0.16 s); timing stayed on CI. Repeat
artifact download passed (6.39 s), report recording passed (0.13 s).

## Focused checks and limits

All local work used `python3 scripts/local-guard.py COMMAND...` serially, with
no full build, full gate or benchmark. Existing compiler output plus edited
runtime probes establish runtime behavior; runner tests above validate the
changed compiler. Scratch/partial-result failures, forced collection and
missing-free controls passed at O1/O2 (6.00 s); the QR boundary sanitizer probe
passed without huge allocation (1.85 s). Array borrowing semantic/runtime probes
passed (5.14 s), and metadata/inventory/formatting checks passed. Inventory:
231 explicit contracts, 10 flat scalar signatures, 118 declarations needing
review and 19 lowered templates. The frozen baseline is unchanged.

Artifact downloads passed (8.08/3.73 s). Report recording and complete profile
comparison passed (0.14 s); the first recording attempt used this preparation's
older parent report, corrected to #146's current retained report.
Full final-head production, including both Windows targets, remains required.
The preceding Intel compiler SIGABRT did not recur on its unchanged retry;
its cause is still unknown. Preserve future crash reports.

## Following preparation and next action

F128 precision branch `quad-gradient-precision` is in `/private/tmp/fwp-quad-grad`,
based on `3e5d86ad`. Its [four-host run](https://github.com/e6qu/fun-with-pipes/actions/runs/38797434546)
passed at `7a463be9`: low bits, exponent range, seed accumulation, nested and
checkpointed gradients, cleanup controls and existing differentiation regressions.
It uses the existing typed tape protocol; boxes and reference counts still cost
storage. Its own handoff records profile limits.

Console preparation `checked-console-ownership` is in
`/private/tmp/fwp-console-ownership`, based on `7a463be9`. It owns whole-input
buffers, pending lines, copied arguments and environment lookups. It also
fixes embedded-zero names incorrectly looking up a prefix variable. Its expanded
[run 38802310868](https://github.com/e6qu/fun-with-pipes/actions/runs/38802310868)
at `f81970a1` has passed ARM Linux/macOS; AMD64 jobs are still running. The prior
partial run was superseded and canceled. It has its own handoff and no open PR.

Next: monitor #146 and fix failures. After its
full exact-head gate passes, squash merge it; rebase only solver commits after
`c10b1ccd` onto the accepted squash commit. Bring only precision commits after
`3e5d86ad` into the numerical branch, reconcile documentation/workflows, and
open one substantial numerical PR. Consider the console batch together only
when its own checks pass and the combined scope stays reviewable. Its commits
begin after `7a463be9`. Keep [PLAN.md](../PLAN.md) current; no broad work area
is complete, and JIT remains excluded.
