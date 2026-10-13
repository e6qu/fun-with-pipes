# Session handoff

Updated 2026-10-13. The user authorized all seven steps in [PLAN](../PLAN.md)
as one combined [PR #133](https://github.com/e6qu/fun-with-pipes/pull/133).
This is its final implementation handoff. The PR checks and merge record are
the acceptance authority: require all seven exact-head production jobs and
the documentation audit before squash merge. Commit messages have one line,
at most 80 characters, no body, trailers or attribution.

## Accepted baseline

PR #132 merged at `c67800ec8530e44501c54c69719af26b0585bedc`, with its complete
seven-job gate and docs audit. Linux/macOS ARM64/AMD64 packages are verified.
Windows remains deferred; universal binaries are not an objective.
[History](roadmap-history.md) retains immutable delivery evidence.

## Active bundle

| Step | Status | Delivered scope |
|---|---|---|
| 1 | Implemented | One current plan/handoff; historical evidence separated from live actions |
| 2 | Implemented | Counted typed reconstruction, aliases, duplicate keys, partial failure and unwind; direct packed decoding |
| 3 | Implemented | Scoped State callback proof, replacement, escaping immutable callbacks and cleanup |
| 4 | Implemented | Direct count/list producer state and known modify entries, preserving forcing/trap order |
| 5 | Implemented | Native I128/U128 workers with checked arithmetic and typed boxed boundaries |
| 6 | Implemented | Allocation/live-memory, C/Rust, AD and native instruction controls; direct formatting and smaller hot frames |
| 7 | Implemented | Explicit current/future float precision, conversion and protocol decision |

The implementation is complete; acceptance is conditional on the PR's final
checks and merge. A failed or skipped check does not establish support.
After PR #133 is merged, all seven steps are delivered and there is no further
active task in this bundle. Do not reopen historical preparation anchors.

## Validation and evidence

[History](roadmap-history.md#seven-step-reconstruction-and-numerics-bundle-pr-133)
and the [measurement record](measurements/reconstruction-and-workers-2026-10-13.json)
retain source heads, run links, hardware, compiler/flags, allocations, live bytes
and measurement limits. Focused regression and iteration stages passed all four
native platforms at 08f4231. Corrected wide measurements passed all four at
45ed2ce, whose compiler/runtime sources are identical. The numerical run
38401073468 passed Linux ARM64/AMD64 and ARM macOS at this snapshot; Intel macOS
was still running. Its final result remains available at the linked run.

Final code is 615e224: malformed Trit/TInt binary rejection in both engines,
partial-owner rejection cleanup, a stride-aware packed/unpacked test assertion,
and cold/noinline overflow formatting. Four-platform evidence run 38406723936
validates these changes and records worker stack usage. Later changes in this
candidate are documentation only. The earlier production run 38401077491
passed bench and ARM macOS GC but exposed the now-fixed stride assertion; it
was superseded and is not a merge gate. Require the replacement full run on
this PR's final head, including both Linux jobs, bench and regular/GC shards
on both macOS architectures.

Measured 1000-element requests: fold 6005 → 6, State each 7009 → 8,
map/filter/fold 9511 → 6. Both 256-element wide workloads: requests 513 → 2,
peak charged bytes 4096 → 32, zero retained charged storage or collections.
Iterator CLI/printing overhead retains 64 charged bytes and is not an ARC
reclamation claim. Warm AD workspaces allocate no native buffers; returned
gradients allocate once. Cold overflow formatting reduced a bounded local ARM64
wide-worker frame from 144 to 32 bytes; runner reports govern platform claims.

Focused local checks passed through `python3 scripts/local-guard.py`:
`cargo clippy --all-targets -- -D warnings`, `cargo fmt --all -- --check`,
Python syntax validation of the wide measurement script, roadmap/link audit,
and bounded generated-C protocol/packing and stack probes. The protocol probe
covers both packing modes at O1/O2 with stress/verification. Local target data
is about 112 MiB and free disk about 104 GiB. Full builds/suites remain on CI.

## Resume and finish

Next: inspect PR #133 and its exact head. If open, collect final-fix and remaining
numerical results, fix every failure, and require all seven production jobs plus
docs on the latest head. Keep fixes in this PR; publish branch
`ownership-numerics-next`. Temporary `ownership-numerics-evidence` is only a
measurement branch, not another delivery. Squash with one explicit subject of
at most 80 characters and an empty body, then verify merged-tree parity and the
complete one-line message. If already merged, verify that record and stop this
bundle: the roadmap is complete. Remove the temporary evidence branch after
merge. No further implementation is implied by historical next-action lists.

Remaining directions are explicitly outside this bundle: broader cyclic or
foreign/external protocol ownership, other producer/worker shapes, true half/quad
float implementation with protocol migration, further measured numerical/AD
improvements, and deferred Windows. Pipe syntax and immutable/effect semantics
remain unchanged.
