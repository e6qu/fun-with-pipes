# Session handoff

Updated 2026-10-13. The user authorized all seven steps in [PLAN](../PLAN.md)
as one combined [PR #133](https://github.com/e6qu/fun-with-pipes/pull/133).
This is its current implementation and validation handoff. The PR checks and merge record are
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
45ed2ce, whose compiler/runtime sources are identical. Numerical run
38401073468 passed all four platforms. Evidence run 38406723936 also passed
all four at 615e224: malformed Trit/TInt binary rejection, partial-owner
cleanup, packed/unpacked assertions and cold overflow formatting.

Production run 38407820810 on c1f8283 (documentation after 615e224) passed
bench, regular ARM/Intel macOS and ARM macOS GC, but Linux ARM exposed an
invalid free in the WASI `cli_csv` golden. Enum error choices used managed
bump-heap storage as scratch. The current fix writes choices into a registered
scratch buffer and appends help choices directly, removing the temporary
managed allocation. The same allocator audit found a temporary I128 box in
Trit/TInt JSON decoding. It now parses the exact scalar directly, preserving
the signed-128 input boundary. Interpreter range checks also avoid overflowing
`abs` on I128 minimum. The expanded `json_typed` golden covers fractional,
negative/exponent, ternary range and signed-128 boundary inputs in both engines.
The early bundle checks now require actual WASI golden
programs on both Linux architectures; production requires them too. This
supersedes that production run. All seven jobs and docs must pass again on the
new PR head. The short 59cd3f7 runs were superseded by the complete allocator
fix before acceptance. The earlier stride-assertion failure in 38401077491 was already
fixed; cancelled or superseded runs are not merge gates.

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
covers both packing modes at O1/O2 with stress/verification. A bounded generated-C enum probe
(`python3 scripts/local-guard.py python3 /private/tmp/fwp-wasi-choice-probe.py`)
passed O1/O2 for native and host bump allocators; the pre-fix interior bump
allocation aborts at both optimization levels as a negative control. The
matching guarded `/private/tmp/fwp-json-trits-probe.py` passes O1/O2 native and
bump boundary checks, verifies zero managed temporaries and reproduces the
pre-fix invalid free. Actual WASI execution
remains a runner check. Local target data
is about 112 MiB and free disk about 104 GiB. Full builds/suites remain on CI.

## Resume and finish

Next: inspect PR #133 and its exact head. If open, collect the WASI-fix preflight and replacement full
production results, fix every failure, and require all seven production jobs plus
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
