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
Superseded pre-publication and duplicate post-merge runs were cancelled.

Standing authorization covers fixes, publication and squash merge after all nine
production jobs and documentation pass for the final commit, then the next PR.
Use a one-line subject of at most 80 characters and an explicitly empty body,
without trailers or attribution. Keep one active delivery PR; this preparation
branch may run focused CI before #146 merges. Full local builds remain excluded.

## Prepared batch: owned linear-algebra workspaces

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
- Formatting passed (1.01 s). Focused changed-compiler CI remains pending.

The parent batch's Intel macOS compiler abort did not reproduce on an unchanged
retry. Its cause is unknown; preserve available compiler crash reports on future
failures. The parent numerical report records current C/Rust gaps, including
Intel array overhead and remaining matrix wrapper allocations. Do not mistake
these solver ownership changes for numerical speed or accuracy improvements.

## Next action

Publish this preparation branch and run the focused `solvers` workflow. Fix any
failures while monitoring #146. When #146's exact-head gates pass, squash merge
it, then rebase only commits after `c10b1ccd` onto the accepted squash commit.
Reconcile this handoff with the parent delivery evidence and open the solver PR.
Require its full production/docs gates before merging. Continue the remaining
project work in [PLAN.md](../PLAN.md); no broad roadmap area is complete.
