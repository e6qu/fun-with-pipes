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

The next candidate targets the two boxed-input conversions, using the existing
last-owner test. A unique heap record transfers its typed fields and frees only
its outer cell; shared or stack records keep their existing ownership operations.
Acceptance requires mixed scalar/pointer fields, shared parents/children, wide
numeric boxes, retain failure, cleanup on later failure and unchanged numerical
results. The intended matrix count is zero retains/nonlast releases, with the
same five allocations per multiplication. No timing gain is assumed.
`boxed_field_moves` checks actual tracing/ARC builds, shared parents, aliased
children, an I64 with pointer-like bits, an owned I128 box, repeated drops and
traps, and a negative control forcing the old conversion. The existing compiler
fails its unique-input retain assertion with four retains (exit 214), as expected
(guarded baseline check 1.36 s). An edited-C mechanism probe passes this test and
the shared overflow regression (10.40 s); it does not verify changed compiler
emission. The overflow regression now forces a shared parent because a unique
parent no longer retains children and cannot trigger that artificial overflow.

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
compiles against the existing library. Formatting passes (1.10 s). The changed compiler passes its new field-move regression on Linux AMD64/ARM64
and Windows AMD64/ARM64 in [38815917275](https://github.com/e6qu/fun-with-pipes/actions/runs/38815917275)
at `c8f65e5`. The broader Windows suite exposed two old probe portability issues: 
text-mode newline translation and an unescaped path. Repairs set binary probe
output, escape the path, intercept Windows wide-character file opens and check
closed native handles. Both repaired probes pass locally against the existing
compiler under the guard (10.97 s). Both Windows and both Linux jobs pass
[38817093105](https://github.com/e6qu/fun-with-pipes/actions/runs/38817093105)
at `1901fd44`; macOS jobs were still queued before the boxed-transfer extension.
Failed logs are `/private/tmp/fwp-field-116700424100.log` and
`/private/tmp/fwp-field-116700424254.log`.

The `fields` workflow suite adds six-host validation with adjacent projection,
record-conversion, borrowed-callback and original resource-frame regressions.
Production Windows coverage includes the changed projection/resource cases too.
Full builds and tests remain on runners; all local workloads use
`python3 scripts/local-guard.py COMMAND...` within the fixed limits.

## Working-directory ownership and explicit errors

The current extension removes `env.cwd`'s POSIX fixed 4 KiB buffer and silent
`"."` substitution. Both engines now raise `Error[IoError]` with kind `cwd` if the
OS cannot read the directory; the copied string has a checked fresh-leaf contract.
Native buffers are protected during string allocation and freed on all exits.
This also replaces the old Windows trap with the same typed error interface.
The library signature and generated reference describe the deliberate change.

`working_directory` compares actual Unicode directories in both engines, checks
removed-directory errors on POSIX, and probes repeated native ownership,
6000-character OS results, read failure, partial string-construction failure,
forced collections and omitted-count/release controls. Native Windows uses its
wide path API, including a second-read failure. Changed-compiler checks remain
pending; do not claim all-target support from the local runtime experiment.

The local POSIX edited-C mechanism probe passes (3.38 s). Its first attempt used
an obsolete generated call spelling; a later attempt included scheduler setup in
the memory baseline. The corrected probe calls the exported cwd entry directly
and includes #147's counted error constructor. It is runtime evidence, not
changed-compiler or native Windows acceptance.

Local formatting passes (1.10 s); generated docs regenerate and verify through
`stdlib_doc` (1.03 s). The inventory initially rejected the deliberate added
error effect; its exact expected signature is now recorded without changing the
frozen baseline. It passes (0.98 s): 250 contracts, 10 scalar signatures, 99 review
declarations, 19 templates and 89 remaining review symbols.

## Next: validate preparation and merge #147

Boxed-field compiler tests at `a3d8f16e` pass Linux and Windows on both
architectures in [38817873592](https://github.com/e6qu/fun-with-pipes/actions/runs/38817873592);
macOS remains pending. Numerical run
[38817877068](https://github.com/e6qu/fun-with-pipes/actions/runs/38817877068)
collects profiles and instructions for both move changes. Superseded preparation
runs `38817093105` and `38816168594` were canceled; their completed jobs remain
component evidence, not final acceptance.

Publish and run the working-directory extension with the ownership suite, fix
all failures, and inspect the final numerical counts and C/Rust measurements.
The expected matrix profile is zero retains/nonlast releases across eight
products, with forty allocations and zero final charged storage/collections.
Keep boxed API wrapper allocations visible in the report.

Monitor #147's exact-head gate and merge only after all nine production jobs
plus docs pass. Transfer this preparation's changes after `a2679ecb` onto that
accepted squash before opening the next substantial PR. Keep one current PR,
and update the main handoff with actual tests, unresolved issues and next action.
