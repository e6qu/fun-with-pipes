# Current work

**Next:** finish the final log audit and squash-merge PR #251, then rebase this
branch's own commits onto that verified merge. Publish the gradient-array repair
with its new array cleanup controls and allocation checks as one batch. Audit
all focused targets before making any performance claim or starting timings.

## Checkout and recovery

- Persistent worktree: `.worktrees/gradient-array-results` under the primary
  repository; branch `gradient-array-results`. The detached primary checkout's
  recovery edits remain untouched.
- `/private/tmp` was cleared between messages. Published implementation
  `aed66f261c25ff74e37d04edd9f2d3717817510d` was restored. Keep working files and
  evidence in the project-local `.worktrees/gradient-work`, and checkpoint changes.
- Contract commit `c191421e`, tag `roadmap/gradient-array-protocol-2026-11-03`,
  predates implementation. The whole-change reference patch is committed at
  `aed66f26`; measurement identities still need freezing before timing.
- No next PR exists yet. Keep one open PR. After #251 merges, rebase only commits
  after `cea8debcd8caf067bf210fd612c559b265157b91`; do not include its old commits
  in the next PR. Every commit/merge message is one line, at most 80 characters,
  with no body, trailers or attribution.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Passing gates | Audit the last full/target logs, merge #251 and verify message/tree |
| 2 | Implemented | Both Linux compilers/lints and array selection/application checks pass; repair two test assumptions |
| 3 | In progress | Run restored array fault controls and all 96 allocation observations; retain complete failures |
| 4 | Pending | Compiler/runtime measurements, independent audits, final platform matrix and delivery |

## PR #251 delivery

All nine production jobs in `41610112980` pass at
`cea8debcd8caf067bf210fd612c559b265157b91`; documentation job `125829540129` in
`41610097425` also passes. The skipped draft run is not a required gate.

| Gate | Job |
|---|---:|
| Benchmarks | 125829594182 |
| Linux ARM64 | 125829594542 |
| Linux AMD64 | 125829594545 |
| macOS ARM64 regular | 125829594788 |
| macOS AMD64 regular | 125829594612 |
| macOS ARM64 ownership | 125829594640 |
| macOS AMD64 ownership | 125829594596 |
| Windows ARM64 | 125829594942 |
| Windows AMD64 | 125829594720 |

Benchmarks/docs, all four macOS jobs and Windows AMD64 have passed complete log
and target audits. Recovering the files and auditing the remaining Linux/Windows
jobs uses `.worktrees/gradient-work/collect-251.py`; results go in `platforms-251`.
Require 257 target logs per Linux host, 131/126 per regular/ownership macOS host
and 57 per Windows host. Inspect unexpected diagnostics rather than hiding them.
Merge subject: `Generate private zip indices without temporary lists`; empty body.
Verify the raw commit message and that its tree equals the tested head.

Completed range evidence remains in the
[storage report](measurements/range-zip-storage-2026-11-03/README.md),
[compiler report](measurements/range-zip-analysis-2026-11-03/README.md) and
[timing report](measurements/range-zip-time-2026-11-03/README.md).
Larger solves take 7.1–10.0% less time; small-case timing limits remain open.
Do not repeat those completed measurements.

## Gradient-array first run and repairs

Run `41618374217` tests `aed66f26`. ARM64 job `125857466013` and AMD64 job
`125857466216` complete with the same two failures under GCC and Clang. Both
builds, all-target Clippy and selection units pass. All 16 integration target logs
per host have been inspected; no other failures were found. The original archives
and full logs are retained in `.worktrees/gradient-work/attempt-{arm,amd}.*`.
The archive digests match GitHub metadata. `audit-attempt.py` records diagnostics.

| Failure | Cause and repair |
|---|---|
| Nested cleanup instrumentation cannot find stage 5 | It targets the removed list builder. Move stages 5 and 12 to the completed array-slot transfer and the protected input-owner transfer. Keep every existing fault/cancellation mode. |
| F128 recording exceeds cumulative charge by 32 bytes | The expected value now builds an extra array from a singleton list. Saved generated C calls `array.from-list` before the workload. Make that expected array an explicit compile-time constant; keep every original recording/memory limit. |

The recording harness now collects failures across all scalar types, stack modes,
optimization levels and workspace modes instead of stopping at the first result.
The new array-map/zip fault branch shares the existing list harness: callback
failure, between-stage failure, cancellation, allocation failure, partial output,
aliases and deliberate missing releases. These repairs still need runner checks.

The complete gradient/update fixture already passes both engines and native
GCC/Clang O1/O2, including input aliases and empty/singleton cases. Packed slices,
map order, F128 precision, typed-result owner controls, checkpoints, workspace,
capacity and library cleanup also pass in the first run, except the two cases above.

## Checks and remaining restoration

Guarded local checks before the temporary-directory reset passed: primitive
inventory (394 declarations, 384 symbols, 40 aliases), generated stdlib comparison,
reference isolation and Clang O1/O2 typed-result cleanup controls. These are
focused checks, not final-platform or performance acceptance. Rust formatting
passes again in the persistent checkout (1.79s).

The reset removed uncommitted measurement preparation. Reconstruct it before
publishing the next grouped check: gradient-array count limits and constructor
attribution, compiler/time comparison manifests, independent seven-source reference
reconstruction and workflow routes. Session records retain the edits and prior
unit results; do not claim those files are restored until they are present.
The array unwind extension and fully typed callback rejection controls have
already been restored. No new allocation or timing observations exist yet.

Local work stays serial under `scripts/local-guard.py`: 64 GiB free disk, targets
below 2 GiB, sampled RSS below 1 GiB and 180 seconds. Last free space about 88 GiB.
Full builds, suites and measurements belong on GitHub runners; never raise limits.
