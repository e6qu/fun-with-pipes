# Current work

**Next:** publish and verify the service archive-audit repair, then implement the
[frozen service timing protocol](measurements/weak-callback-time.md). Keep this
batch in [PR #273](https://github.com/e6qu/fun-with-pipes/pull/273). Milestone 4 is
incomplete; do not merge an interim green head.

Worktree: `.worktrees/recording-capacity-gate`. Preparation branch:
`ownership-buffer-review`; latest implementation source `19ee8ee9b`, tag
`roadmap/weak-service-audit-repair-2026-11-09`. PR branch:
`ownership-peer-comparisons`, still `b06a2b6fe20f2842f5b9c9a3bb4e00be0278f011`.
Integrate the complete preparation batch into this PR before final production
verification. Preserve unrelated root-worktree changes and inactive handoffs.

## Roadmap status

| Step | Status | Delivered | Remaining |
|---|---|---|---|
| 1 | In progress | #270 documentation refresh and fresh F64 stores | Original AMD timing acceptance |
| 2 | In progress | #271 captured maps and empty-owner transfer | Original noisy timing acceptance |
| 3 | In progress | #272 structured gradients and known callbacks; all delivery gates | Original AMD timing acceptance |
| 4 | In progress | Buffer/closure comparisons; weak phases, storage, reuse, census and timing; service correctness, fwp cleanup and native allocations; parser entry repair and memory controls | Service timing; parser internal peaks and applying accounting observations |
| 5 | Pending | Existing language tools and correctness tests | Three applications, compiler phase/scaling costs and sustained load |

Retain original noisy/unmet timing results. Fewer operations or smaller images do
not complete runtime acceptance. Do not rerun unchanged samples to qualify them.

## Current verified results and failures

- **Service native profiles:** source `c0ac432fc`, run `42664664795`, AMD64
  `129325013027`, ARM64 `129325013096`: 16 diagnostic builds and 80 profiles per
  host pass. Docs `42664675441` / `129325039434` passes. Ordinary C/Rust/Swift
  service storage is released; actual omitted payload/weak releases retain exactly
  the expected bytes. [Results and limits](measurements/weak-callback-profiles-2026-11-09/README.md).
- **Service archive audit:** run `42666652513` / `129332006025` reconstructs both
  complete archives, then fails because its diagnostic rule rejects heaptrack's
  normal stderr statistics. The prepared repair parses the exact three-counter
  block, checks allocation totals against raw stacks and rejects unexpected text.
  Four reader tests and all 164 real status blocks pass locally. Re-run only this
  audit, not the successful profiles. The repaired runner also preserves compact
  raw journals/stacks. Original failure reports/logs are retained.
- **Allocator calibration:** source `3c214f136`, run `42666642464`, AMD64
  `129331964348`, ARM64 `129331964527`: four real resize controls pass with empty
  debugger stderr. Source-path/timestamp issues are repaired, not suppressed.
  [Original warnings, failed repair and final evidence](measurements/parser-allocator-calibration-2026-11-09/README.md).
- **Mapping accounting:** same source, run `42666647306`, AMD64 `129331981618`,
  ARM64 `129331981260`: O1/O2 ordinary/no-reservation mappings and eight actual
  omitted-touch/unmap controls pass per host. Both retain mode-0 host policy.
  Accountable extents and resident pages are distinct; system-wide commit counters
  are not a process guarantee. [All raw snapshots and controls](measurements/parser-mapping-accounting-2026-11-09/README.md).
- **Docs for `3c214f136`:** run `42666658591` / `129332015531` passes. Complete
  allocator/accounting logs contain no warnings/errors. Native service logs have
  the optional g++ manual-page notice and normal libtool install-time relinking.

## Compiler repair and earlier evidence

The parser's consuming region worker and owning function entry both released its
input. The entry now shares `rc::consumes_arg` with direct calls. Source
`ee30d13b0`, run `42645911091`, passes both Linux hosts, all six parser tests,
primitive inventory and memory/corruption controls. Native/WASI regressions cover
aliases, parse errors, allocation failure and actual extra-drop faults; remaining
platforms still require final gates. [Repair](measurements/parser-entry-cleanup-2026-11-09/README.md).

The fwp service physical ledger passes at `cf6a0a12e`, run `42658708144`: eight
raw/optimized dynamic/static O1/O2 builds release all allocations; actual omitted
weak release fails with status 205. [Evidence](measurements/weak-callback-service-2026-11-09/README.md).

[Weak timings](measurements/weak-operation-time-2026-11-09/README.md) show substantial
C/Rust lookup gaps and mixed Swift results. The [census](measurements/weak-operation-census-2026-11-09/README.md)
finds a temporary 16-byte `Some` allocation per successful fwp lookup and none for
expired lookup; this does not explain all measured gaps.
[Buffer timing](measurements/returned-buffer-time-2026-11-09/README.md) retains both
sessions and every original noise failure. ARC operation counts and maximum dynamic
stack use remain unmeasured. [Scope](measurements/ownership-peers.md).

## Prepared work and delivery checks

- Service timing protocol separates service calls from process time. The prepared
  fwp/C entry adapter derives result offsets from emitted descriptors, rejects
  non-I64 fields, and includes ordinary tuple/result allocation and cleanup.
  Reader tests pass; actual generated/native adapter verification remains pending.
- Parser: connect verified allocator events to actual C/Rust/fwp allocations,
  cover mapped/retry paths, avoid double-counting resize overlap, and apply mapping
  accounting to actual checkpoints. Calibration alone is not a parser peak.
- The handoff rewrite briefly removed the status column required by its checker;
  the column is restored. The audit now passes 426 doc link sets, 106 immutable
  preparation pairs and all five roadmap steps.
- Local focused checks use `python3 scripts/local-guard.py` unchanged. Disk free
  space is about 142 GiB. Full builds, profiles and suites stay on GitHub.
- Complete parser-control artifacts are under 128 KiB compressed each; all raw
  snapshots, manifests and native headers reconstruct locally. Service journals
  exceed the 2 MiB member limit and are processed on runners. Do not raise limits.
- Final integration requires nine exact-head production jobs, docs and full-log
  audit. [Earlier passing head `7645384bb`](measurements/ownership-peer-gates-2026-11-09/README.md)
  does not verify later changes. The numerical dispatcher must stay below 512,000 bytes.
