# Session handoff

Updated 2026-10-16. The only open delivery is
[PR #146](https://github.com/e6qu/fun-with-pipes/pull/146), final head `19b14d0b`.
Its [production run 38803349673](https://github.com/e6qu/fun-with-pipes/actions/runs/38803349673)
has passing macOS, Windows, Linux ARM64 and benchmark jobs; Linux AMD64 still runs.
[Documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/38803349640)
passes. Do not merge until all nine production jobs pass for this head.

This is the next delivery branch `owned-numerical-programs` in
`/private/tmp/fwp-numerical-delivery`, based on `19b14d0b`. It combines the changes
after `c10b1ccd` from `checked-linear-algebra` (`4f3f2a1b`) and the snapshot
change `cbe6604a`, plus file-value changes through `4c73dfb2`. The latest Windows loop-unwind repair, its early test and
matrix/wide-worker coverage are preserved. No PR is open for this branch yet.

Standing authorization covers fixes, publication and squash merges after all
nine final-head production jobs and documentation pass. Use exactly one subject
line of at most 80 characters and an explicitly empty body, with no trailers or
attribution. Keep one active PR. Failing tests are tasks; queued CI gates merging,
not independent preparation. Never replay components already combined here.

## Roadmap status

[PLAN.md](../PLAN.md) defines completion; none of its seven areas is finished.
JIT is excluded. Preserve single-argument curried functions, explicit
`curry`/`uncurry`, infix precedence and tacit data-last pipes.

| Step | Status | Next concrete work |
|---|---|---|
| 1 | In progress | Deliver solver, console and filesystem ownership, then extend remaining runtime/deployment contracts |
| 2 | In progress | Measure remaining record, closure and call costs in representative programs |
| 3 | In progress | Reduce confirmed numerical gaps and sharing costs without changing arithmetic order |
| 4 | In progress | Deliver F128 precision; investigate differentiation timing and memory scaling |
| 5 | Pending | Broaden CPU kernels and resolve runtime OpenCL compilation under the no-JIT policy |
| 6 | In progress | Preserve equivalent C/Rust comparisons, repeated samples and memory profiles |
| 7 | In progress | Extend numerical, collection-heavy and long-running applications |

## Combined delivery and focused evidence

| Change | Behavior and acceptance evidence |
|---|---|
| Six linear-algebra solvers | Own scratch and partial outputs on success, singular results and failure; QR bounds square output independently. Four hosts pass at `ec1ff14b` in [38795634707](https://github.com/e6qu/fun-with-pipes/actions/runs/38795634707). |
| F64 array loops | Borrow the data address once only when every loop iteration preserves the same array; retain bounds, slices, scheduling and floating order. The solver run and two four-host paired comparisons ([38800569111](https://github.com/e6qu/fun-with-pipes/actions/runs/38800569111), [38801692547](https://github.com/e6qu/fun-with-pipes/actions/runs/38801692547)) pass. |
| F128 reverse gradients | Existing typed tape preserves seed, weight and adjoint precision/range; other formats keep their accumulation rules. Four hosts pass at `7a463be9` in [38797434546](https://github.com/e6qu/fun-with-pipes/actions/runs/38797434546). |
| Console and environment copies | Own input buffers, partial lists, arguments and `env.get` copies; zero-containing names return `None` before prefix lookup. Four hosts pass at `f81970a1` in [38802310868](https://github.com/e6qu/fun-with-pipes/actions/runs/38802310868). |
| Filesystem paths and probes | Reject zero bytes before OS access, preserving prefix files and both rename operands. Native Windows handles and escaped source paths repair old probes. Six hosts pass at `135fa6f5` in [38806367846](https://github.com/e6qu/fun-with-pipes/actions/runs/38806367846). |
| Caught I/O errors | Count and protect both strings and the record; previously a typed drop retained 64 charged bytes. Repeated compiled/runtime catches and every construction failure pass on six hosts at `aa6ad15` in [38808012610](https://github.com/e6qu/fun-with-pipes/actions/runs/38808012610). |
| Directory/environment snapshots | Own strings, pairs, list nodes, scratch and OS handles through failure; free recursive-directory scratch. Sorted Unicode names, empty directories, independent copies, borrowed paths and missing-release controls pass on six hosts at `cbe6604a` in [38810318287](https://github.com/e6qu/fun-with-pipes/actions/runs/38810318287). |

File metadata, byte reads and ordinary file actions passed all six hosts at
`c4562773` in [38811437488](https://github.com/e6qu/fun-with-pipes/actions/runs/38811437488).
The later directory-error repair and composed application test require their
own acceptance below.

These runs cover their recorded revisions. The integrated final commit still
needs full production CI. Tests use actual tracing/ARC builds, O1/O2, collection
stress and deliberately omitted-release controls; ARC never enables tracing or
poisoned reuse. No skipped host establishes native support.

## Measurements and limits

[Array report](measurements/numerical-array-borrows-2026-10-15.json) retains
C/Rust comparisons plus both same-run cached/per-element comparisons. Each paired
run rotates four binaries through forty timing samples; outputs and allocation
profiles agree. Intel macOS ARC kernel ratios are 0.704/0.707 (about 29–30% less
time). ARM macOS is 0.968/1.021; retain both results and slower tracing cases.
There is no universal speedup claim. Actual timed AMD64 instructions keep the
array address/index in registers without added hot-loop stack traffic or FMA.

The same-run C/Rust comparison remains separate: Intel macOS ARC array time is
0.978x C but 1.742x Rust. Cross-run absolute timings cannot isolate an optimization
when host/reference performance changes. The [benchmark guide](benchmarks.md)
explains timing scope, arithmetic and hardware.

[F128 report](measurements/f128-gradient-precision-2026-10-15.json) contains
32 profiles across four hosts, two optimization levels, workspace reuse on/off
and both memory modes. The full ten-check fixture plus 65 repeated gradients
requests 2,843 allocations/143,082 bytes; ARC finishes with zero charged storage
and collections. This is not per-gradient time, peak live memory or a count of
all host-side allocations.

An Intel macOS compiler SIGABRT in U128 division by zero at preceding `c10b1ccd`
did not recur on its unchanged retry. The cause remains unknown. Keep future
crash reports; do not call this repaired. Log: `/private/tmp/fwp-candidate-intel.log`.

## File-value follow-up and local checks

File metadata now owns its duration and enclosing record. A local repro found
native macOS returning `-1s` for a pre-epoch file where the interpreter reports
`0ns`; the repair matches existing interpreter/Windows behavior and avoids signed
timestamp overflow. Byte reads reuse existing buffer/stream cleanup. Writes keep
the original error across close. Missing count, missing protection and missing
error restoration fail the negative controls (182/189/192).

The directory-error follow-up at `03d39626` exposed a Linux-only mismatch in
[38812282305](https://github.com/e6qu/fun-with-pipes/actions/runs/38812282305):
`input/` with a regular file reports `File exists` in Linux's interpreter but
`Not a directory` on macOS. The first fix incorrectly imposed the macOS result.
Both Linux logs show precisely this difference; other executed cleanup tests pass.
The repair at `4c73dfb2` asks `mkdir` about the original path and preserves the
host's diagnostic. It also checks `input/child`, a final existing file and
unchanged original contents. The superseded failed run was canceled.

The same preparation now includes a composed directory report: walk a nested
tree, read metadata and sum sizes through ordinary pipes, repeated 64 times.
The ARC executable checks final storage and absence of tracing. This is a
reclamation/semantic test, not a speed benchmark. Six-platform
[38812948324](https://github.com/e6qu/fun-with-pipes/actions/runs/38812948324)
passes all six hosts at `4c73dfb2`, including the composed ARC report. All file-value changes
are already included here; do not import `checked-file-values` again.

Local workloads use `python3 scripts/local-guard.py COMMAND...`, serially under
fixed resource limits. Full compiler builds, suites and timing stay on runners.
Existing-compiler probes with edited C validate runtime behavior, not new proof
rules. Corrected file-value raw/tracing and cleanup probes pass (9.16 s),
snapshot runtime/source checks pass (7.23/0.61 s), and caught-error construction
passes (6.53 s). Generated stdlib docs pass (0.64 s). The final integration passes formatting (1.11 s), roadmap audit (2.53 s) and
inventory (0.76 s): 249 explicit contracts, 10 flat scalar signatures, 100 review
declarations and 19 lowered templates. Its source matches `4c73dfb2` except the
preserved parent Windows library/loop-unwind probe repairs. The inventory
baseline is frozen. Preserve the failed Linux logs in `/private/tmp/fwp-directory-*-failure.log`.

## Next optimization identified, not implemented

The retained matrix profile has three retains and three nonlast releases per
multiplication. Its generated `product-data` entry duplicates a selected array
field immediately before releasing that same field from an already flattened
result record. An untimed single-multiplication C experiment removes just this
pair: retains/nonlast releases fall 3 to 2, release checks 7 to 6. Five allocations,
101,456 requested bytes, 101,392 peak charged bytes, zero final live storage and
the result hash remain identical. This is a focused mechanism check, not a timing
claim or a compiler implementation. Guarded script
`/private/tmp/fwp-field-move-count-check.py` passes (2.40 s); results are in
`/private/tmp/fwp-field-move-count-result.json`.

After publishing this delivery, investigate transferring a selected field out of
an unboxed owned record without a retain/release pair. Preserve other fields,
shared children, failure cleanup and resource-frame lifetimes. Compare interpreter,
tracing/ARC, actual generated instructions and before/after counts; retain rejected
proof cases. Boxed input-record retains and two input wrapper allocations remain
separate costs. Do not replace ordinary arguments or add implicit syntax.

## Next: finish the gate and publish the next substantial PR

Monitor #146; fix failures and require all nine production jobs plus docs for
`19b14d0b`. Squash merge with the prescribed subject/empty body, then verify its
message and unchanged tree. Transplant this combined delivery from `19b14d0b`
onto that accepted squash commit; record actual merge/run evidence in history
and this handoff. Open one PR and require its own full final-head gate.

The repaired file-value validation is complete. Keep one current plan and handoff,
and retain unresolved exclusions and performance gaps. Completion of these
components does not remove tracing GC or finish any whole roadmap area.
