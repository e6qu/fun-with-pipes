# Session handoff

Updated 2026-10-16. [PR #146](https://github.com/e6qu/fun-with-pipes/pull/146)
merged as `be890914` after all nine production jobs and documentation passed
for `19b14d0b`; its files and prescribed one-line message were verified.
The current delivery is [PR #147](https://github.com/e6qu/fun-with-pipes/pull/147),
head `71c612d0`, in `/Users/zardoz/projects/fun-with-pipes`.
[Production 38814786923](https://github.com/e6qu/fun-with-pipes/actions/runs/38814786923)
is running; its bench and [docs](https://github.com/e6qu/fun-with-pipes/actions/runs/38814787519)
pass. Ignore skipped draft jobs. Do not change its head just to refresh status.

This is later preparation `move-unboxed-fields` in `/private/tmp/fwp-field-moves`,
based on pre-rebase delivery anchor `a2679ecb`. Only changes after that commit
belong here. No PR is open for this work; keep it separate while #147 runs.
After #147 passes, squash merge with one subject of at most 80 characters and an
explicitly empty body, no trailers or attribution. Continue without requesting
permission again. Fix failures; queued CI gates merges, not preparation.

## Roadmap status

[PLAN.md](../PLAN.md) defines completion; no whole area is finished. JIT is
excluded. Preserve tacit data-last pipes, single-argument curried functions,
explicit tuple conversion, infix precedence, effects and checked arithmetic.

| Step | Status | Next concrete work |
|---|---|---|
| 1 | In progress | Accept #147's ownership coverage; reduce proved unnecessary reference-count traffic |
| 2 | In progress | Transfer fields of already unboxed records without a temporary owner |
| 3 | In progress | Verify generated instructions and remaining matrix input costs |
| 4 | In progress | Accept F128 precision; investigate differentiation timing and memory scaling |
| 5 | Pending | Broaden CPU kernels and resolve runtime OpenCL compilation under the no-JIT policy |
| 6 | In progress | Preserve equivalent C/Rust comparisons, repeated samples and memory profiles |
| 7 | In progress | Extend composed and long-running application tests |

## Measured target and implementation

The retained matrix profile has three retains and three nonlast releases per
multiplication. Its generated entry duplicates a selected array field immediately
before releasing that field from an already flattened result record. An untimed
single-multiplication C experiment removes just this pair: retains/nonlast
releases fall 3 to 2, release checks 7 to 6. Five allocations, 101,456 requested
bytes, 101,392 peak charged bytes, zero final storage and the hash remain identical.
`/private/tmp/fwp-field-move-count-check.py` passes under the local guard (2.40 s);
results are in `/private/tmp/fwp-field-move-count-result.json`. This is not a
speed measurement or verification of a changed compiler.

The provisional `bind_local` change recognizes only an immediate selected-field
Dup followed by that flattened parent's Drop. It transfers the selected field,
releases the other fields with their existing typed drops, and leaves original
resource-frame cases unchanged. No wrapper, runtime mode or language syntax is
added. Boxed input-record retains and two input wrapper allocations remain
separate costs.

## Proof tests and actual checks

`field_moves` constructs checked typed IR so inlining cannot erase the projection
being tested. Raw interpretation checks independent and shared children. Native
probes repeat both cases with/without external aliases, check selected counts,
release discarded siblings, and trap after selection to exercise real unwind
cleanup. Tracing uses stress/reuse verification; ARC never enables them. O1/O2
and an injected retain/release pair verify that the counter detects extra work.

The existing compiler fails the new count assertion with exactly one extra retain
(exit 198), as intended. Guarded baseline probe
`/private/tmp/fwp-field-move-baseline-check.py` passes that negative-control check
(1.59 s). It emits `/private/tmp/fwp-field-move-baseline.c`; the test harness
compiles against the existing library. Formatting passes (1.10 s). The changed
compiler has not yet run; do not describe this candidate as verified.

The `fields` workflow suite adds six-host validation with adjacent projection,
record-conversion, borrowed-callback and original resource-frame regressions.
Production Windows coverage includes the changed projection/resource cases too.
Full builds and tests remain on runners; all local workloads use
`python3 scripts/local-guard.py COMMAND...` within the fixed limits.

## Next: validate field transfers while #147 runs

Publish this preparation, dispatch `numerics.yml` with `suite=fields`, and fix
failures without weakening the assertions. Add actual matrix emitted-code and
count evidence with the changed compiler, plus resource/callback cases needed
by review. Retain known boxed/shared cases and any performance regressions.

Monitor #147's exact-head gate and merge only after all nine production jobs
plus docs pass. Transfer this preparation's changes after `a2679ecb` onto that
accepted squash before opening the next substantial PR. Keep one current PR,
and update the main handoff with actual tests, unresolved issues and next action.
