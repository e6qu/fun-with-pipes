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

Focused CI 38399147351 on 250b4c0 passed wide-worker enabled/disabled O1/O2
semantics and reclamation, State scope rejection unit tests, decoder injected
cleanup/truncation, legacy float wire bits and iterator forcing-order controls
on Linux ARM64. It found a leaked TInt display buffer and a State measurement
whose producer lived outside its consumer callback. Both are corrected. The
measurement now puts the complete producer chain inside the State handler.

Numerical CI 38399152455 also found leaked diagnostic formatting scratch in
the newly admitted CSV corpus. Native allocation backtraces identified the
TInt and diagnostic buffers; both now write directly into their destination.
Guarded generated-C probes, using the runner's emitted programs with the exact
edited runtime text, reclaim all storage for both failing CSV and JSON cases
(0.66/1.98 CPU seconds, 1.67/4.30 elapsed). This is focused validation, not a
replacement for current-head production gates.

Packed JSON/binary arrays now decode directly into their final payload, with
partial typed ownership, instead of allocating an intermediate word vector.
A 257-element binary allocation control and array construction/truncation tests
cover this. JSON base64 scratch has unconditional unwind cleanup and checked
size arithmetic. These latest changes still require CI execution.

The guarded documentation audit passes: 45 link sets, 106 immutable preparation
pairs/tags, seven live plan steps and commit subjects. It now validates this
handoff instead of requiring a retired preparation-branch table. Guarded
all-target Clippy, test type checking, formatting and edited-runtime C syntax
checks passed. Full builds, suites and evidence stay on GitHub.

PR #133 production CI 38399229957 on 250b4c0 has a passing benchmark job;
other jobs are running and known corpus/doc failures are fixed in the working
tree. No previous, skipped or superseded run is the final merge gate.

Next: publish the batched fixes; finish the four-platform focused and numerical
reports, fix any remaining failures, and inspect native instruction artifacts.
Update the PR and handoff with actual results, require all seven production jobs
plus docs on the final head, then squash merge with the prescribed one-line
subject and empty body. Unsupported cycles and foreign/external protocol
contexts remain explicit ARC exclusions.
