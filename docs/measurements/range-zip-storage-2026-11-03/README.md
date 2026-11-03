# Private range storage: verification

**Status:** first native attempt failed; both identified causes are repaired but
not yet verified on runners. The [frozen contract](../range-zip-storage.md) and
exact allocation predictions are unchanged. No performance claim is established.

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
  interpreter. Rust formatting passes. New compiler code still needs native
  GCC/Clang runner checks and exact allocation comparisons.
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
