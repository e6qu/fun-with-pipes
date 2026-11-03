# Scalar map buffer verification

The new storage pass keeps a private mapped list in a numeric buffer until its
sole `zip-with` consumer. All mapping still finishes before zipping begins.
[Selection and measurement contract](../temporary-list-storage.md).

## First native attempt

Source `6f4cd46b2623cdbddd7419d18f44a66898891272`,
[run 41576241072](https://github.com/e6qu/fun-with-pipes/actions/runs/41576241072).
Both jobs fail because a new unit test names an out-of-scope helper. Their
production compiler builds, integration tests and allocation checks pass.
This attempt does **not** establish passing unit tests or a mergeable pipeline.

| Check | ARM64 | AMD64 |
|---|---:|---:|
| Job | 125720292199 | 125720292215 |
| GCC integration tests | 23 pass | 23 pass |
| Clang integration tests | 10 pass | 10 pass |
| Allocation observations | 48 pass | 48 pass |
| C compilation diagnostic files | 118 clean | 118 clean |
| Constructor / existing observer controls | 12 / 10 pass | 12 / 10 pass |

The integration targets cover both buffer input slots, all 12 supported scalar
kinds, eager effects/traps, excluded shared/escaping results, allocation failures,
cancellation and partial outputs. Sixteen scalar-unwind executions per host cover
GCC/Clang O1/O2 with ordinary cleanup and deliberately omitted buffer, scratch or
partial-result frees. Ordinary cleanup exits 0; each missing-free control exits 90.
The artifacts contain 160 native test images per host; their architecture headers
and hashes were inspected. Complete target logs have no compiler diagnostics.

### Measured storage

Both architectures, optimization levels and workspace settings agree. Across all
96 observations, the pass removes exactly `(d+1)*u` allocations and `(32*d+8)*u`
requested bytes for `d` coordinates and `u` updates. Retains do not change;
managed peak does not increase; final managed/raw storage is zero. Ordinary
output and derivative work match the starting implementation.

For 129 coordinates and 199 updates, current-only, GCC O2, workspace 0:

| Managed cost | Before | After |
|---|---:|---:|
| Allocation requests | 156,943 | 131,073 |
| Requested bytes, cumulative | 5,382,142 | 4,559,078 |
| Retains | 995 | 995 |
| Peak charged bytes | 17,824 | 17,824 |
| Final charged bytes | 0 | 0 |

These are allocation measurements, not elapsed-speed results or whole-process
RSS. The history form saves the same requests/bytes but retains its history;
its peak is 838,432 bytes. Timing and compiler-cost acceptance remain unmeasured.

### Repairs required

- The unit test must call `reachable_functions(&program, &[0])`. Its old
  `live_functions` name prevents library-test compilation and all-target lint.
- The unit workflow used `tee` without pipeline failure propagation. Both unit
  commands failed even though the step appeared green. Use explicit Bash,
  preserve both results, and return failure if either command fails.
- Three older numeric-owner workflow steps had the same reporting defect;
  repair them too. Their previously audited passing test logs remain evidence.

Every failed step and completed target was audited before publishing this batch.
The full native logs contain no other diagnostics beyond the same unresolved
helper error and its build-failure warning. The documentation job
`125720204926` passes; its deliberate failing-runner controls are expected.

### Retained evidence

- [ARM64 control logs, outputs and file/image hashes](attempt-1/aarch64-controls.json.gz),
  [AMD64 controls](attempt-1/x86_64-controls.json.gz).
- [ARM64 independently reconstructed counts](attempt-1/aarch64-counts.json.gz),
  [AMD64 counts](attempt-1/x86_64-counts.json.gz).
- [ARM64 full job log](attempt-1/aarch64-job.log.gz),
  [AMD64 full job log](attempt-1/x86_64-job.log.gz),
  [documentation log](attempt-1/docs-job.log.gz).
- [ARM64 count artifact identity](attempt-1/aarch64-count-artifact.json),
  [AMD64 identity](attempt-1/x86_64-count-artifact.json).

The count audit reconstructs instrumented C and constructor tables, verifies
archived hashes/images and recomputes all observations. Downloaded archive hashes,
all compilation diagnostics, exact count differences and cross-host equality were
also checked locally under the resource guard. Full C/images remain in the linked
run artifacts and saved local archives; compact logs and hashes are retained here.
