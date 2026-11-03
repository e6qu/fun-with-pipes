# Private range storage: verification

**Status:** corrected native checks pass on both Linux architectures at
`3be9479c4150d7aae5695d7f7aa4ce3f84d0f738`. Both completed target archives, all 96 allocation observations
and both full job logs are audited.
The [frozen contract](../range-zip-storage.md) and exact predictions are unchanged.
Runtime measurements are complete with small-case speed goals open. Final
platform acceptance remains pending. The measured source
is frozen as `roadmap/range-zip-measurement-2026-11-03` at that commit.

## Corrected native verification

[Run 41601233570](https://github.com/e6qu/fun-with-pipes/actions/runs/41601233570)
passes: ARM64 `125800213798`, AMD64 `125800214058`. Documentation
`41601188883` / `125800044359` also passes; its full log contains only the
intentional runner-failure controls.

Each host passes 17 selection unit tests and 37 integration test executions.
Both target archives have clean diagnostics and 204 native images with the
expected architecture headers. All 32 scalar/range cleanup outcomes per host
match: ordinary cleanup exits 0; deliberately omitted frees exit 90.

- [ARM64 native records and image hashes](verified/aarch64-controls.json.gz).
- [AMD64 native records and image hashes](verified/x86_64-controls.json.gz).
- [Documentation full log](verified/docs-job.log.gz).

### Verified storage reduction

All 96 observations agree across architectures, O1/O2 and workspace settings.
Savings match `(d+1)*u` requests and `(32*d+8)*u` requested bytes for `d`
coordinates and `u` updates. Ordinary results and derivative work match the
reference. Retains stay unchanged; final managed/raw storage is zero. Each host
has 118 clean C compilation logs.

Largest current-only solve, 129 coordinates / 199 updates:

| Managed cost | Scalar-buffer baseline | Range consumer |
|---|---:|---:|
| Allocation requests | 131,073 | 105,203 |
| Requested bytes over the solve | 4,559,078 | 3,736,014 |
| Retains | 995 | 995 |
| Peak charged bytes | 17,824 | 14,976 |
| Final charged bytes | 0 | 0 |

The history form saves the same requests and bytes; its retained history keeps
peak charged storage at 838,432 bytes. These counters measure fwp-managed
storage, not whole-process memory or elapsed speed.

- Reconstructed counts: [ARM64](verified/aarch64-counts.json.gz),
  [AMD64](verified/x86_64-counts.json.gz).
- Full job logs: [ARM64](verified/aarch64-job.log.gz),
  [AMD64](verified/x86_64-job.log.gz).
- Original archive identities: [ARM64](verified/aarch64-count-artifact.json),
  [AMD64](verified/x86_64-count-artifact.json).

### Native code and frame costs

For the same 129/199 current-only program at GCC O2, compared with the saved
scalar-buffer baseline `da510f18`:

| Cost, bytes | ARM64 before → after | AMD64 before → after |
|---|---:|---:|
| Executable file | 144,640 → 144,560 | 94,016 → 93,936 |
| Text section | 44,988 → 44,732 | 48,242 → 47,762 |
| Largest compiler-reported frame | 2,160 → 2,160 | 2,160 → 2,160 |

[All 48 native case records](footprints.json) preserve their largest reported
frame. This is the C compiler's per-function frame report, not a measurement of
the complete call stack or dynamic stack allocations. Code-size savings do not
establish faster execution. The runtime experiment uses its separately isolated,
same-source reference.

## Completed measurements

[Compiler comparison](../range-zip-analysis-2026-11-03/README.md) `41603242667`
passes on both hosts; all 480 commands and raw measurements are audited.
[All four runtime sessions](../range-zip-time-2026-11-03/README.md) and independent
audits are complete: larger solves take 7.1–10.0% less time, with small-case
speed goals still open. Both comparisons use `3be9479c`, with passing
correctness run `41601233570` as a prerequisite.
The reference disables only range-to-zip selection in the same source. The
[frozen inputs, timing scope and limits](../range-zip-storage.md) are unchanged.
Both original AMD64 hosts were rejected before measuring and replaced with
qualified hosts. Every completed outcome is retained, with no rerun for a pass.

## Remaining allocation sites

The largest current-only solve still has four groups of per-coordinate objects.
Each group makes 25,671 requests for 616,104 bytes on both architectures:

- The records pairing input values with derivative node positions.
- The list containing those records, passed to the objective function.
- The gradient result list, constructed from the backward pass's numeric array.
- The updated coordinate list returned by the step.

[Exact constructor sites](residual-sites.json) link these counts to saved generated
C. This identifies candidates for the next investigation; it does not establish
that each object can safely be removed. Before selecting another change, prove
which results are private and preserve output shape, aliases, effect order and
the derivative scope's cleanup. The current measured source remains unchanged.

## First native attempt

Source `aeae4afdf15e55ec95b7613cc4126194b318602f`, retained as
`roadmap/range-zip-attempt-2026-11-03`.
[Run 41596501915](https://github.com/e6qu/fun-with-pipes/actions/runs/41596501915):
ARM64 job `125785012603`, AMD64 `125785012332`.

Each host passes all-target Clippy, 16 selection unit tests and 35 integration
executions. Two executions of the new cleanup fixture fail, one under GCC and
one under Clang. Both allocation assertions also fail: the derivative benchmark
saves none of the predicted allocations. Every completed target and full log was
audited before publishing the repair.

| Failure | Cause | Repair |
|---|---|---|
| Cleanup fixture exits with an injected record failure | The injected fault remains armed after recovery and fires during the next case's input setup | Disarm each injected allocation fault when it fires; clear it before the next case |
| Derivative allocation savings are zero | The pass selects named ranges; the typed program contains an immediate range argument to zip | Select that argument too, evaluating its bounds at their original argument position |

For example, `zip-with combine (range lo hi) values` now uses the two evaluated
bounds directly. Callback construction stays before them, and `values` stays
after them. Both input slots have a typed-IR regression; a native/interpreter
case checks the printed order `callback`, `lo`, `hi`, `input` and result
`[(8, 10), (9, 20)]`.

The [saved input](attempt-1/diagnostic-input.fwp) and
[typed IR](attempt-1/diagnostic-ir.txt.gz) establish the missed inline form.
This diagnostic used the matching merged compiler, not disassembly inference.
The original counts are unchanged from the scalar-buffer baseline in all 96
observations: outputs, work, allocations and final storage match. Each host has
80 failed savings assertions and 118 clean C compilation logs.

## Local checks and their limits

- Replayed the exact failed C fixture with one-shot faults under Apple Clang 17,
  production O1/O2: both ordinary cases exit 0; omitted-record, omitted-scratch
  and omitted-partial-list cleanup controls each exit 90. All eight executions
  have empty stderr. This checks the fixture repair, not the new compiler pass.
- The inline-order program prints the expected result under the existing
  interpreter. Rust formatting passes. The corrected GCC/Clang checks have since passed on both
  runner architectures. See the completed verification below.
- No local compiler build, full suite or benchmark was run.

## Retained evidence

[ARM64 native records](attempt-1/aarch64-native.zip) and
[AMD64 native records](attempt-1/x86_64-native.zip) contain all target/unit logs,
probe outputs and hashes of the original C/images. Their embedded artifact
metadata identifies the original downloadable archives and source commit.
[ARM64 counts](attempt-1/aarch64-counts.zip) and
[AMD64 counts](attempt-1/x86_64-counts.zip) retain the independent audits, exact
misses and original archive identities. Both original archive digests and nested
report digests were verified. Full job logs are retained beside these archives.
