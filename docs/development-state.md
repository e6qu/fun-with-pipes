# Session handoff

Updated 2026-10-15. This preparation branch is `checked-linear-algebra`, in
`/private/tmp/fwp-linear-algebra`, based on `c10b1ccd` from the preceding batch.
[PR #145](https://github.com/e6qu/fun-with-pipes/pull/145) merged as `e51b8570`
after all nine production jobs and documentation passed for `1ee7d581`.
[PR #146](https://github.com/e6qu/fun-with-pipes/pull/146) is the only active
delivery PR. Its main checkout is `/Users/zardoz/projects/fun-with-pipes`, branch
`checked-library-ownership`, final head `bccead2d`. Required production run:
[38790425937](https://github.com/e6qu/fun-with-pipes/actions/runs/38790425937);
[documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/38790426370).
Superseded pre-publication and duplicate post-merge runs were cancelled. Most
production jobs are running; benchmark and documentation jobs remain queued.

Standing authorization covers fixes, publication and squash merge after all nine
production jobs and documentation pass for the final commit, then the next PR.
Use a one-line subject of at most 80 characters and an explicitly empty body,
without trailers or attribution. Keep one active delivery PR; this preparation
branch may run focused CI before #146 merges. Full local builds remain excluded.

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

## Prepared batch: numeric ownership and borrowed array data

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

## Evidence and unresolved work

All local checks used `python3 scripts/local-guard.py COMMAND...` from the main
checkout. They test existing compiler output with the edited runtime inserted,
not the changed compiler's ARC eligibility rules.

- `/private/tmp/fwp-linalg-runtime-check.py` passed (6.00 s): O1/O2, 256 calls per
  solver, forced collection on/off, every allocation/constructor failure,
  unchanged input counts/data and restored storage budgets. Omitting scratch
  release exits 222; omitting pending-output release exits 224.
- `/private/tmp/fwp-qr-size-check.py` passed after runtime updates (1.85 s):
  O1/O2 with address/undefined sanitizers, byte/square overflow and preserved
  dimension/input error order. The omitted-size-check control exits before any
  enormous allocation is attempted.
- `/private/tmp/fwp-linalg-harness-check.py` passed (0.63 s): metadata-only test
  harness compilation and expanded raw interpreter fixture. An initial test
  incorrectly put a shape trap under `attempt`, which catches explicit `fail`;
  removed that invalid expectation. QR tests cover trap output separately.
- Primitive inventory passed (1.02 s): 231 explicit contracts, 10 flat scalar
  signatures, 118 declarations needing review and 19 lowered templates. The
  original baseline file remains immutable.
- Formatting passed (1.01 s). The initial solver-only run
  [38791568892](https://github.com/e6qu/fun-with-pipes/actions/runs/38791568892)
  at `9fede19f` was cancelled while queued after the batch expanded.
  [Expanded run 38793378425](https://github.com/e6qu/fun-with-pipes/actions/runs/38793378425)
  at `42662770` failed both Linux hosts: the QR boundary fixture used `read-all`,
  which is correctly rejected by checked ARC. Formatting, Clippy, solver cleanup,
  invariant/changing-array tests and existing numerical/unwind controls passed
  on Linux AMD64. The fixture now passes dimensions through a function executable
  instead, preserving runtime size checks and ARC coverage. Interpreter function
  entry returns 9 for three columns and the expected exit-101 negative-dimension
  trap (guarded 0.75/0.73 s). A new expanded run is required; do not count the
  failed run as acceptance or weaken ARC's input-boundary checks.

Intel macOS assembly of the accepted numerical candidate shows repeated
slice/data selection inside the F64 reduction. A bounded C experiment hoisted
that pointer and removed the branches, allowing ordinary scalar unrolling;
`/private/tmp/fwp-array-pointer-check.py` passed (1.87 s), compiling Intel-targeted
assembly without local timing. The compiler now drafts the same transformation
only for flat F64 array parameters that every `Again` passes unchanged and that
are directly read by `array.get`. Bounds tests, owners and cleanup remain in
place. Changing-array loops keep dynamic loads; no new runtime wrapper or type
conversion is introduced. Full compiler validation and runner timing are pending.

The new fixture covers original inputs, slices, empty arrays, arrays replaced on
each loop step, negative/out-of-range indices and task execution. Raw interpreter
output passed (0.62 s for the final fixture).
`/private/tmp/fwp-array-borrow-check.py` passed (0.89 s): isolated invariant-proof
and test-harness metadata compilation, plus old-compiler confirmation of the
loop shape. `/private/tmp/fwp-array-borrow-runtime-check.py` also passed (5.14 s):
edit existing emitted C to borrow invariant data, then compare raw interpreter
output with native tracing/ARC at O1/O2, including collection/reuse stress,
changing arrays and bounds cases. These are not changed-compiler integration
results. Keep runner validation pending until its actual results arrive.

The parent batch's Intel macOS compiler abort did not reproduce on an unchanged
retry. Its cause is unknown; preserve available compiler crash reports on future
failures. The parent numerical report records current C/Rust gaps, including
Intel array overhead and remaining matrix wrapper allocations. Do not mistake
these solver ownership changes for numerical speed or accuracy improvements.

## Next action

Next: monitor expanded run 38793378425 and fix any
failures while monitoring #146. When #146's exact-head gates pass, squash merge
it, then rebase only commits after `c10b1ccd` onto the accepted squash commit.
Reconcile this handoff with the parent delivery evidence and open the solver PR.
Require its full production/docs gates before merging. Continue the remaining
project work in [PLAN.md](../PLAN.md); no broad roadmap area is complete.
