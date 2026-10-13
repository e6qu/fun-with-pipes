# Session handoff

Updated 2026-10-13. The user authorized all seven steps in [PLAN](../PLAN.md)
as one combined PR. Active branch: `ownership-numerics-next`; [PR #133](https://github.com/e6qu/fun-with-pipes/pull/133).
Publication and squash merge are authorized after all seven exact-head
production jobs and the documentation audit pass. Commit messages have one
line, at most 80 characters, no body, trailers or attribution.

## Accepted baseline

PR #132 is merged at `c67800ec8530e44501c54c69719af26b0585bedc`.
Its ten-task bundle is complete; all seven production gates and docs passed.
[History](roadmap-history.md#ten-task-platform-and-ownership-bundle-pr-132)
records heads and links. Linux/macOS ARM64/AMD64 packages are verified.
Windows remains deferred; universal binaries are not an objective.

## Active bundle

| Step | Status | Evidence still required |
|---|---|---|
| 1 | Implemented | Current documentation audit |
| 2 | Implemented | Complete typed reconstruction ARC/stress controls |
| 3 | Implemented | State callback proof and replacement/unwind controls |
| 4 | Implemented | Producer loop allocation and ordering evidence |
| 5 | Implemented | Wide worker enabled/disabled semantic and boundary controls |
| 6 | Implemented | Four-platform numerical, AD and native instruction reports |
| 7 | Implemented | Current precision and protocol regression gates |

## Current validation

The seven-step bundle is in progress, not accepted. Reconstruction now uses
typed partial owners for CSV, JSON, text and binary decoding. Scoped State proof,
known modify callbacks and count/list producer specialization are implemented.
Native I128/U128 workers keep eligible arithmetic and recursive calls unboxed;
generic boundaries retain typed boxing and release. These changes need runner
acceptance, as do new wide-worker semantic and reclamation tests.

## Evidence in progress

PR #133 remains at 08f4231ef9e5ac8fa3a2ad1852495879d47d23e5 while the
last fixes are measured on temporary branch `ownership-numerics-evidence`.
Publish that work to the same PR with the final documentation update; do not
open another PR.

- Focused run [38401069936](https://github.com/e6qu/fun-with-pipes/actions/runs/38401069936):
  all regressions, iterator allocation/instruction controls and inventory pass
  on all four native platforms. Only the old wide measurement harness failed.
- Corrected wide run [38402851452](https://github.com/e6qu/fun-with-pipes/actions/runs/38402851452)
  passes all four platforms at 45ed2ce (compiler/runtime identical to 08f4231).
  Both wide types reduce 513 requests to 2 and peak charged bytes 4096 to 32,
  with zero retained storage or collections. The workload uses explicit input,
  not unproved command-line IO.
- Numerical run [38401073468](https://github.com/e6qu/fun-with-pipes/actions/runs/38401073468)
  passes Linux ARM64/AMD64 and ARM macOS; Intel macOS is running. This covers
  ARC corpus, packed arrays, C/Rust comparisons, AD ownership/workspaces and
  actual WASI capacity on Linux.
- Production run [38401077491](https://github.com/e6qu/fun-with-pipes/actions/runs/38401077491)
  passes bench and ARM macOS GC shard. ARM macOS regular shard found a new
  packed-array assertion ignoring the unpacked stride; the prepared fix passes
  all four local packing/optimization probe modes. Other jobs are running.
  Documentation run 38401077495 passes. No superseded run counts as a gate.

Prepared fixes also reject malformed binary Trit/TInt values consistently in
Rust and native decoding, including partial graph cleanup. Overflow diagnostics
now stay out of hot recursive arithmetic frames. A bounded generated-C ARM64
probe measured 144 → 32 bytes per wide worker frame with unchanged output;
runner stack-usage reports are required before generalizing this observation.

Linux ARM64 1000-element iteration requests: fold 6005 → 6, State each 7009 → 8,
map/filter/fold 9511 → 6. All preserve raw interpreter output and collect zero
times. The measurements include CLI/printing overhead and retain 64 charged
bytes from unproved command-line boundaries; they are not ARC reclamation claims.
ARM64 disassembly shows checked arithmetic in registers with no allocation or
indirect tail call inside the count/fold loop. Allocation source/hash, hardware,
flags, live-memory and instruction artifacts accompany the run.

AD warm 129/257-leaf workspace calls allocate no native buffers; each returned
gradient array allocates once (1040/2064 requested bytes). Oversized workspaces
release rather than remain cached. Equivalent ARM64 array C/Rust/fwp kernel
medians were 312822/321766/776215 ns; matrix medians 562299/779478/555891 ns.
These are scoped shared-runner measurements, not universal parity claims.

The earlier CSV/JSON/TInt corpus leaks are fixed. Bounded generated-C probes
reclaimed all charged storage after direct destination formatting. Decoder
arrays now fill final packed storage directly, with 257-element one-allocation
and partial cleanup/truncation controls. Guarded lint/type/format/C syntax and
roadmap checks passed. Latest bounded commands: `cargo clippy --all-targets --
-D warnings`, `cargo fmt --all -- --check`, Python AST parsing of
`scripts/measure-wide.py`, and the generated-C packed/protocol probe, all through
`python3 scripts/local-guard.py`, passed. Local target data is 112 MiB; free disk about 104 GiB.

Next: run bundle evidence on the prepared fixes, collect remaining production
failures and address them. Inspect native instructions and stack reports. Update the final plan/history/PR,
publish the prepared measurement fix and final docs together, then require all
seven production jobs plus docs on that final head before squash merge.
Use one explicit subject of at most 80 characters and an empty commit body.
Unsupported cycles, foreign/external protocol contexts, true half/quad float
implementation and Windows remain outside this bundle's scope.
