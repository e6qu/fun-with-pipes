# Session handoff

Updated 2026-10-15. [PR #145](https://github.com/e6qu/fun-with-pipes/pull/145)
is awaiting its final production gate at `1ee7d581`:
[run 38779284746](https://github.com/e6qu/fun-with-pipes/actions/runs/38779284746).
Documentation, benchmarks, both Windows jobs and both ARM macOS jobs have passed;
the remaining Linux/macOS jobs are running. The earlier run failed a tutorial README/source consistency
check. The repaired tutorial includes both `sum-pair` and `sum-curried` examples,
and the fast documentation job now checks tutorial copies before the long suites.
The superseded production run was cancelled. Do not merge on its partial results.

Standing authorization covers fixes, publication and squash merge after all nine
production jobs and documentation pass for the final commit, then the next PR.
Supply a single-line subject of at most 80 characters and an explicitly empty
body, without trailers or attribution. Keep one active delivery PR.

The next batch is on `checked-library-ownership`, rebased onto `1ee7d581`.
After #145 merges, rebase only this batch onto its squash commit, without
replaying #145, and open its PR. Do not discard the next branch's changes.

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

## PR #145: scope and evidence

The PR adds fixed-precedence arithmetic, removes unnecessary cleanup around
proved bounded internal array-index increments, omits conservative GC root fences
in checked ARC, and improves benchmark comparability and sample ordering.

[Four-host performance run 38771808755](https://github.com/e6qu/fun-with-pipes/actions/runs/38771808755)
passed at code revision `f42d6226` on Linux/macOS ARM64/AMD64. It covered raw
interpreter/native arithmetic, array fusion, ARC reclamation, derivative workspace,
borrowed callback and pipe tests, plus numerical, derivative and program measurements.
The final production gate additionally validates the tutorial consistency repair.

Fused reductions report zero allocations, retains and cleanup registrations for
0/1/7/129/257 elements at O1/O2 on all four hosts. The old baseline registered
129/257 cleanups at those larger sizes. ARC assembly has no scan/mark/sweep symbols;
the ARM macOS reduction uses scalar registers and no per-element cleanup call.
This demonstrates removed work, not an isolated timing speedup.

[Recorded measurements](measurements/ownership-performance-2026-10-15.json) and
[benchmark explanations](benchmarks.md) retain algorithms, hardware, compilers,
profiles and samples. Array time remains roughly 1.4–2.5 times C. Paired derivative
metadata was slightly slower than separate allocations on both Macs and slightly
faster on Linux; fewer allocations do not establish a universal speedup.
Historical and current timing methods differ. Controlled before/after comparisons
remain work. Local downloaded artifacts are in `/private/tmp/fwp-pr145-performance`
and `/private/tmp/fwp-baseline-macos-arm`.

## Next batch: checked boundaries and comparable memory modes

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

These changes are pending runner validation and before/after timing against
`49d35018` with the same forty-sample method. The extended suite now also runs
matrix semantic/allocation/failure tests, wide-worker preemption and loop unwind
checks. Do not attribute a speedup before these results exist.

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

Next: publish the numerical candidate and dispatch the extended four-host library
suite; retain its results alongside the passing `49d35018` baseline.
Inspect #145's final production gate and squash merge
once all required jobs pass; then rebase this batch onto main and open its PR.
Record runner failures and fixes here. Keep the fixed local resource limits;
queued CI gates merging, not independent roadmap work.
