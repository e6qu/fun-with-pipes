# Session handoff

## Next action

Branch `direct-integer-range-sets` contains the next delivery on accepted main.
[PR #172](roadmap-history.md#compact-set-storage-pr-172) passed all nine production
jobs and documentation, then merged as `c3f7f75591a0a073f443fed45855a1b084963729`.
Its one-line squash message and identical tested tree were verified. Redundant
post-merge production run `39311332528` was cancelled; its PR gates remain intact.

Next: publish this batch and audit every final-head production job and the
new C/Rust benchmark. Fix every failure before merging. Require all nine jobs
and documentation for the exact final commit; use a one-line squash subject
and an empty body. Focused evidence below does not replace those gates.

## Current batch

`range lo hi | set.from-list` writes inline integer keys directly into one owned
set buffer. Empty/descending ranges use static storage. Bounds keep their order;
byte limits are checked before narrowing to the target's size type, including
32-bit WASI. Boxed integers and shared input lists keep their existing paths.
There is no new syntax or public API.

Three native tests cover values, integer widths, bound effects/traps, sharing,
allocation counts and failure cleanup in ARC/tracing at O0/O2. Deliberately
missing size guards or releases must fail; ordinary construction must fail a
one-allocation budget. WASI adds real execution and oversized-container checks.
`bench/range-set` adds a million-key C/Rust/fwp comparison with matching canonical
hashing. Its full timings and the latest ISize/USize/shared-list fixture additions
still need final-head production validation.

## Evidence and limits

- All six hosts passed [collection run 39303492049](https://github.com/e6qu/fun-with-pipes/actions/runs/39303492049)
  at `7901a576019a01c490efe248c15730fac0602701`, preserved by
  `roadmap/revision-range-sets-7901a576`. All-target Clippy, 44 tests per host
  and nine paired cost cases passed. No focused test was ignored.
- [Report run 39311772543](https://github.com/e6qu/fun-with-pipes/actions/runs/39311772543)
  audited all 264 tests and inspected 228 actual binaries. Its collector is
  `b0b2b6ae8dcfaabbb6430ac5a70ae6f89540fd8f`, preserved by
  `roadmap/revision-range-report-b0b2b6ae`. The
  [complete report](measurements/range-sets-2026-10-19.json) retains samples,
  hardware, compilers, commands, counts and binary hashes/sections/symbols.
- Linux WASI run `39300774252` passed 24 tests on each architecture, none ignored,
  including actual 32-bit storage-limit rejection. The earlier Linux-only run
  `39300769086` also passed; its [report](measurements/range-sets-linux-2026-10-19.json)
  is a separate measurement on an EPYC 7763.
- The current compiler/runtime matches the measured revision exactly:
  `git diff 7901a576 -- src runtime` is empty. Later changes add benchmark sources,
  explicit tracing selection in the general benchmark runner, fixture cases,
  documentation and reports. They still require final-head testing.

For 4,096 keys, construction falls from 4,099 requests / 196,624 requested bytes
to one request / 32,776 bytes. Empty sets make no request. Counters exclude
allocator overhead; releasing results restores ARC charge to baseline.
At 65,536 keys, direct/ordinary whole-process median ratios span 0.345–0.831.
Windows ranges overlap; 32-key medians are slightly slower on four hosts.
[The benchmark guide](benchmarks.md#direct-integer-range-sets) explains timing
scope, differences from C/Rust, memory and inspected SIMD loops. No universal
speedup, zero-heap or optimal-register claim follows.

## Local checks

All workloads used the primary checkout's `python3 scripts/local-guard.py`,
serially with unchanged limits. No full compiler build or benchmark ran locally.

- Rust/fwp formatting, Python syntax and `git diff --check` pass.
- `python3 scripts/test-collection-evidence.py`: six tests pass.
- `python3 scripts/test-native-test-runner.py Coverage.test_repository_targets_are_assigned_exactly_once`:
  passes; the new test target belongs to exactly one macOS shard.
- `python3 scripts/check-roadmap.py`: 60 document sets, 106 immutable anchors
  and seven work areas passed in 3.37 seconds after adding the final report.
- The accepted compiler at `/private/tmp/fwp-170-accepted-macos/fwp-macos-arm64/fwp`
  ran the sixteen-line boundary/shared-input fixture. Guarded runtime probes
  checked O0/O2 counts and failing negative controls; CI now confirms integration.
- `/private/tmp/fwp-check-range-peers.py` passed in 3.05 seconds: C/Rust/raw-fwp
  outputs agree at 0/1/257 keys, with C/Rust warnings treated as errors.
- `/private/tmp/fwp-read-range-six-hosts.py` downloaded only the report and two
  disassemblies in 6.36 seconds. Full inspection ran on GitHub.
- The guard once refused below 64 GiB free disk. Removed only old downloaded
  copies in `/private/tmp/fwp-server-entry-evidence/39078070919` after verifying
  all 24 originals remain on GitHub. Reports/worktrees remain intact; free disk
  returned to 65 GiB and the unchanged guard passed afterward.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Ownership contracts, tracing removal and limited ARC |
| 2 | In progress | Functional intermediates, copies and eligible tail recursion |
| 3 | In progress | Equivalent-work C/Rust gaps and machine-code costs |
| 4 | In progress | Derivative precision, speed and storage |
| 5 | In progress | CPU kernels and ahead-of-time device execution |
| 6 | In progress | Reproducible comparisons and regression budgets |
| 7 | In progress | Representative larger applications |

All seven areas in [PLAN.md](../PLAN.md) remain open. Persistent subscriptions,
unknown retained captures, resource-owning tail frames and mutual recursion need
further proofs. JIT is excluded. Keep one live next action; preserve accepted
measurements in history instead of carrying obsolete instructions forward.
