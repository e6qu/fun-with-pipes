# Session handoff

Updated 2026-10-15. [PR #145](https://github.com/e6qu/fun-with-pipes/pull/145)
is awaiting its final production gate at `1ee7d581`:
[run 38779284746](https://github.com/e6qu/fun-with-pipes/actions/runs/38779284746).
Documentation, benchmarks and Windows AMD64 have passed; the other production
jobs are running. The earlier run failed a tutorial README/source consistency
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
controls must fail. This addition awaits changed-compiler runner validation.

Measurements: emit actual tracing and checked ARC builds of the same array and
matrix programs. Matrix type dimensions now match the measured 65x67 and 67x63
buffers. Compare with equivalent C/Rust arithmetic using forty timing samples per
implementation, balanced process order, separate allocation profiles and binary
inspection. Do not substitute an ARC preprocessor define for compiler eligibility.
The extended `numerics.yml` library suite includes these measurements and uploads
`library-*` artifacts. No new timing result is claimed before that run completes.

## Focused local checks

All checks used `python3 scripts/local-guard.py COMMAND...`; full compiler builds,
suites and benchmarks remain on runners. Existing compiler output plus edited
runtime probes check runtime behavior, not the changed compiler's proof rules.

- Library boundary probe: repeated unloads, zero live bytes/collections, omitted
  release failure and first-allocation accounting passed (2.11 s).
- Channel runtime probe: recursive data, cancellation and queue reclamation passed;
  omitted queue release retained 2,112 bytes and failed as expected (3.61 s).
- Transpose runtime probe: forced GC, retain/node trap cleanup, omitted-retain and
  omitted-scratch-free controls passed (2.71 s).
- Updated transpose interpreter fixture passed (0.75 s), including shared strings,
  functions, wide integers, ragged/empty lists and failure after transposition.
- Transpose test harness metadata-only type check and measurement script parsing
  passed (0.14 s); formatting passed (1.09 s).
- Primitive inventory passed (0.85 s): 225 explicit contracts, 10 flat scalar
  signatures, 124 declarations needing runtime review and 19 lowered templates.

## Next action

Next: publish the extended library/transpose/measurement batch and dispatch its
four-host library suite. Inspect #145's final production gate and squash merge
once all required jobs pass; then rebase this batch onto main and open its PR.
Record runner failures and fixes here. Keep the fixed local resource limits;
queued CI gates merging, not independent roadmap work.
