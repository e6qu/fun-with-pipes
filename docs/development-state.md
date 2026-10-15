# Session handoff

Updated 2026-10-15. [PR #145](https://github.com/e6qu/fun-with-pipes/pull/145)
merged as `e51b8570` after all nine production jobs and documentation passed
for `1ee7d581`. Its single-line squash message has no body or trailers.
Completed evidence is in [delivery history](roadmap-history.md).

The current batch is [PR #146](https://github.com/e6qu/fun-with-pipes/pull/146),
branch `checked-library-ownership`: copied C library boundaries,
data-only channels, transpose ownership, allocator accounting and measured
numerical improvements. This batch is rebased onto the accepted squash commit;
its full production and documentation checks are starting. The following solver work stays in its separate worktree.

Standing authorization covers fixes, publication and squash merge after all nine
production jobs and documentation pass for the final commit, then the next PR.
Supply a single-line subject of at most 80 characters and an explicitly empty
body, without trailers or attribution. Keep one active delivery PR.

## Roadmap status

| Step | Status | Next concrete work |
|---|---|---|
| 1 | In progress | Finish checked C library, data-only channel and transpose ownership validation |
| 2 | In progress | Measure remaining closure, container and call costs in representative programs |
| 3 | In progress | Investigate current array and matrix C/Rust gaps; preserve floating-point order |
| 4 | In progress | Investigate sustained derivative timing differences, especially macOS |
| 5 | Pending | Broaden kernels and resolve runtime OpenCL compilation under the no-JIT policy |
| 6 | In progress | Compare tracing and checked ARC with the same numerical measurement method |
| 7 | In progress | Extend numerical, collection-heavy and repeated application coverage |

[PLAN.md](../PLAN.md) defines project completion. No work area above is finished.
JIT is excluded. Functions take one argument and can return functions; keep
explicit `curry`/`uncurry`, without implicit tuple conversion. Infix arithmetic
complements curried calls and pipes.

## Current batch: checked boundaries and comparable memory modes

C libraries: admit copied scalar/string/record inputs and scalar or scalar-record
results, checking every export independently. Reject returned strings, raw pointers
and unproved callbacks because the existing ABI has no host release contract.
Host entry is serialized and must finish before unload. Preserve the existing ABI.
Tests cover repeated calls, traps, O1/O2, workspace reuse on/off, static linking,
repeated dynamic unload, zero retained bytes and absent tracing symbols. A control
that omits result release must fail. Existing library/FFI tests remain required.

Channels: admit payloads made of data, including immutable recursive values.
Reject functions, tasks or channel handles anywhere inside a payload, since those
can publish a reference back to the queue. Tests cover close/drain, rejected sends,
timeouts, abandoned queues, failure and blocked-task cancellation. A missing queue
release control must fail. No new queue runtime mechanism was necessary.

The first-allocation probe exposed an allocator accounting defect: a small
allocation charged zero before size-class initialization, then credited its real
size when freed. Initialization now charges the actual slot size. Small/large
first-allocation controls cover all three allocation paths.

[Library run 38777828868](https://github.com/e6qu/fun-with-pipes/actions/runs/38777828868)
passed all four Linux/macOS hosts at `6c1440af`.
[Extended library/channel run 38779015192](https://github.com/e6qu/fun-with-pipes/actions/runs/38779015192)
also passed all four hosts at `0c045fc3`, including formatting, Clippy and selected
regressions. Those commits were rebased onto the tutorial repair; they predate
the transpose and measurement additions below. Windows validation remains required.

Transpose: the matrix ARC build exposed an unchecked `list.transpose` boundary.
Its new contract borrows input rows, retains typed element aliases and owns the
new list nodes. Scratch space grows with rows plus columns. Trap cleanup releases
both partial and completed columns. An initial implementation rewrote immutable
list links and failed forced minor-collection verification; construction now uses
fresh immutable links, preserving the collector's old/young object rules.
Ragged inputs still stop at their shortest row. Tests compare raw interpreter,
tracing native and checked ARC output, and inject failure at each retain and list
node, including final outer-list construction. Missing-retain and missing-free
controls must fail. The four-host run below validates this with the changed compiler.

Measurements: emit actual tracing and checked ARC builds of the same array and
matrix programs. Matrix type dimensions now match the measured 65x67 and 67x63
buffers. Compare with equivalent C/Rust arithmetic using forty timing samples per
implementation, balanced process order, separate allocation profiles and binary
inspection. Do not substitute an ARC preprocessor define for compiler eligibility.
The extended `numerics.yml` library suite passed all four Linux/macOS hosts at
`49d35018` in [run 38782635990](https://github.com/e6qu/fun-with-pipes/actions/runs/38782635990),
including transpose, inventory, formatting, Clippy and ARC/tracing measurements.
[The retained report](measurements/numerical-memory-modes-2026-10-15.json) contains
all samples and environment details. Downloaded artifacts are under
`/private/tmp/fwp-library-evidence`; guarded downloads passed in 4.90/4.81/6.50 s.

ARC array kernel time is about 1.00–1.04x C on both Linux hosts and ARM macOS;
Intel macOS is 1.39x C and 2.43x Rust. Both modes have zero retains and zero final
live storage for arrays. Linux ARM64 ARC assembly keeps length outside the loop;
tracing reloads it. Matrix mode differences are small; Intel macOS remains about
3.5x C. The report and benchmark guide state that allocation-inclusive time also
includes the C harness's input construction; it is not whole-program startup.

### Additional candidate: remove confirmed numerical runtime obstacles

The Intel macOS timed matrix loop is scalar. Vector instructions first spotted
in the binary belonged to a different helper; inspect the actual timed function.
Clang's loop diagnostics identify the platform `memcpy` expansion as an opaque
store that prevents vectorization. Fixed-size compiler copy intrinsics preserve
aliasing/alignment rules and expose vector multiply/add in an Intel-targeted
local compile. Shape validation still bounds every copy, and arithmetic order
and separate multiply/add are preserved. No wrapper or unsafe typed cast is added.

The same kernel also spends task-slice checks in programs without tasks. The
compiler now emits its existing task/service-use decision for runtime primitives,
so their scheduler ticks disappear when no task can run. Task/service programs
retain them; Asyncify's stack checks remain unchanged. A forced-scheduler control
fails, while the taskless matrix matches the raw interpreter under GC stress.
The wide-worker cancellation regression explicitly checks ticks remain enabled.

The candidate at `c10b1ccd` passed all four Linux/macOS hosts in
[run 38786031433](https://github.com/e6qu/fun-with-pipes/actions/runs/38786031433).
Intel macOS initially aborted the compiler during the existing `wide_workers`
U128 division-by-zero case (`build --gc tracing --emit-c`, workers disabled),
signal 6 with empty stdout/stderr. The abort occurred before C compilation;
the exact-commit rerun passed. Its cause remains unknown. Preserve this failure
as unresolved evidence, not a fixed defect. First-attempt log:
`/private/tmp/fwp-candidate-intel.log`. CI now preserves available macOS compiler
crash reports on failure to diagnose any recurrence.

The retained numerical report includes both revisions with the same forty-sample
method. ARC matrix time fell about 75% on Intel macOS and 43% on ARM macOS;
C time changed -6.5%/+2.2%. Actual timed kernels contain vector multiply/add.
Linux ARM64 changed less than 1%; Linux AMD64 used different EPYC processors,
so its absolute before/after timing cannot isolate an optimization. Current ARC
matrix/C ratios are 0.94/1.00 on Intel/ARM macOS, 1.15/0.96 on AMD64/ARM64 Linux.
All allocation, retain/release, final-storage profiles and result hashes match.
Intel macOS array time remains about 40% above C and 150% above Rust.
Artifacts are in `/private/tmp/fwp-library-candidate`; guarded final downloads
passed (9.46 s), and recording/profile comparison passed (0.14 s). The first
comparison incorrectly included timing fields; corrected comparison excludes
only elapsed times and checks all remaining allocation/profile fields.
Windows validation and final production gates remain required.

Following this delivery, the next ownership batch is the six existing
linear-algebra solvers. Inspection found GC-owned scratch in `la_get` and each
solver, and unchecked `n*n` QR output storage: a zero-row input can pass the
input-shape check with an enormous column count, then overflow the output-size
calculation. Preparation is isolated in `/private/tmp/fwp-linear-algebra`, branch
`checked-linear-algebra`, based on `c10b1ccd`. It already checks the QR output
limit in interpreter/native code and has matching-language regression cases;
changed-compiler validation is pending. A guarded standalone C boundary probe
passed at O1/O2 with sanitizers, catches an omitted guard before allocation, and
preserves input-error order (2.01 s). No enormous allocation was attempted.
Formatting passed (1.12 s). Scratch/result cleanup is now drafted in that
worktree but unvalidated. Finish singular/invalid
inputs and bounded repeated-call checks before admitting the six primitives to
ARC. Keep this following batch separate; no PR is open for it.

## Focused local checks

All checks used `python3 scripts/local-guard.py COMMAND...`; full compiler builds,
suites and benchmarks remain on runners. Existing compiler output plus edited
runtime probes check runtime behavior, not the changed compiler's proof rules.

- Library boundary probe: repeated unloads, zero live bytes/collections, omitted
  release failure and first-allocation accounting passed (2.11 s).
- Channel runtime probe: recursive data, cancellation and queue reclamation passed;
  omitted queue release retained 2,112 bytes and failed as expected (3.61 s).
- Transpose runtime probe: forced GC, retain/node trap cleanup, omitted-retain and
  omitted-scratch-free controls passed at O1 (2.71 s) and O2 (3.48 s).
- Updated transpose interpreter fixture passed (0.75 s), including shared strings,
  functions, wide integers, ragged/empty lists and failure after transposition.
- Transpose test harness metadata-only type check and measurement script parsing
  passed (0.14 s); formatting passed (1.09 s).
- Taskless matrix plus fixed-size-copy runtime probe passed under GC stress,
  including forced scheduler failure (3.06 s). Intel-targeted instruction checks
  passed (2.36 s); they establish generated instructions, not native timing.
- Primitive inventory passed (0.85 s): 225 explicit contracts, 10 flat scalar
  signatures, 124 declarations needing runtime review and 19 lowered templates.

## Next action

Next: retain the unexplained Intel compiler abort and collect diagnostic reports
if it recurs; its exact-commit rerun and the other candidate hosts passed. The next PR must also run matrix,
wide-worker and loop-unwind checks on both native Windows architectures.
Monitor #146 and fix any failures; require all nine production jobs plus
documentation for its final head before squash merge. Continue solver ownership in the separate
worktree while the current PR runs.
Record runner failures and fixes here. Keep the fixed local resource limits;
queued CI gates merging, not independent roadmap work.
