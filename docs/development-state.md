# Current work

**Next:** verify the captured-scalar array-map extension on production runners,
measure sensor/pixel workloads against an isolated same-source reference, and
bundle the implementation, cleanup controls and docs in one normal PR.
[The contract](measurements/captured-array-maps.md) fixes selection and acceptance.
No performance claim is made for this extension yet.

## Workspace

Branch `captured-array-map-reuse`, worktree `.worktrees/recording-capacity-gate`.
Base `f87796b52081889b96859dbd72bf4af9a6726207` is merged PR #270. The root
worktree has unrelated changes; preserve it. No new PR is open yet.

## Roadmap status

| Step | Status | Evidence and remaining work |
|---|---|---|
| 1 | In progress | #270 delivered docs/tutorial refresh and fresh F64 stores. Both ARM64 sessions improve 26–31%; original AMD64 timing acceptance stays open. |
| 2 | In progress | Extend consuming maps to plain scalar captures; sensor calibration and pixel adjustment. Implementation, native cleanup proof and measurements are pending. |
| 3 | Pending | Structured differentiation across three objective families, preserving general reverse AD, nesting and precision. |
| 4 | Pending | Current Swift/C/Rust ownership comparisons, with phase timing and explicit memory boundaries. |
| 5 | Pending | Three end-to-end application/tooling paths and compiler phase/scaling costs; demonstrated usability repairs. |

## PR #270 delivery and audit repair

Tested source `e8226a4229f0726c4aafac65a0e52d751be3e3b5` and merged source
`f87796b52081889b96859dbd72bf4af9a6726207` share tree
`dc4282cdc34cbe7d9c13cecec0d55f3a037088c8`. The merge message is one line,
under 80 characters, with no trailers. The user merged the candidate; retain its
ARM64 improvement and keep the unmet AMD64 targets explicit.

All nine jobs pass in production `42445576778`. Docs `42445576736`, job
`128623674414`, passes all 384 Markdown link sets, 106 preparation identities,
five roadmap rows, tutorial copies and retained historical reports.
The preceding formatting/generator failures were repaired; cancelled earlier
logs contain no additional failed native targets.

Complete audit `42466048122`, job `128685699134`, verifies every target but flags
two checkout transport diagnostics in the otherwise passing Intel macOS job.
The first fetch timed out; checkout's existing retry fetched the exact same
commit and checkout/tests succeeded. Artifact `13611562384`, SHA-256
`46958156ee43342f160dfb7caf6d2b964039205689036f7c92a8a118adc5261e`, retains all
logs and both findings. Local copy: `/tmp/fwp-270-complete-audit.zip`.

The audit repair recognizes only this proved same-command, exact-source retry
inside a successful checkout step; it retains both diagnostics separately.
Wrong-source retries, failed jobs/steps, extra diagnostics and out-of-step errors
are rejected. All ten guarded audit controls pass. Replay the full retained run
on a runner using the corrected auditor before claiming the complete audit passes.

## Current implementation and checks

Extend `cgen/owned_numeric.rs` selection and argument rewriting, preserve capture
evaluation order, and pass scalar captures into the existing consuming worker.
Only the final array parameter is consumed. Keep the input/output cleanup and
runtime uniqueness/view checks. No public API or tracing collector changes.

Next verification must cover IR liveness/arity, raw interpreter/native parity,
physical frees, aliases/slices, capture effects, callback failure/cancellation,
packing and narrow numeric limits. Use existing native targets and one final
production matrix after the whole batch is ready. Full builds and measurements
stay on GitHub; focused local checks use `scripts/local-guard.py`.

The original #270 [timing/memory report](measurements/fresh-array-costs-2026-11-08/README.md)
and [C/Rust comparison](measurements/loop-array-peers-2026-11-08/README.md) retain
all misses. CPU pinning did not resolve the AMD64 copy variation. Do not repeat
unchanged timings or silently mark milestone 1 complete.
