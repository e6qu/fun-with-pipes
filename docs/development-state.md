# Current work

**Next:** run and audit the final nine production jobs and documentation for
[PR #273](https://github.com/e6qu/fun-with-pipes/pull/273), fixing every failure
before squash merge. Use the PR's exact head, not an earlier preparation source.
All focused comparison/observer checks now pass; milestone 4 still needs final
delivery gates. Do not rerun unchanged timing samples to obtain qualification.

Worktree: `.worktrees/recording-capacity-gate`, branch `ownership-buffer-review`.
The complete batch goes to the normal PR branch `ownership-peer-comparisons`.
Its prior head `b06a2b6fe20f2842f5b9c9a3bb4e00be0278f011` is an ancestor. Resolve
the current PR head and its runs when resuming; do not reuse earlier green gates.
Preserve unrelated root-worktree changes.

## Roadmap status

| Step | Status | Delivered | Remaining |
|---|---|---|---|
| 1 | In progress | #270 documentation refresh and fresh F64 stores | Original AMD timing acceptance |
| 2 | In progress | #271 captured maps and empty-owner transfer | Original noisy timing acceptance |
| 3 | In progress | #272 structured gradients and known callbacks; all delivery gates | Original AMD timing acceptance |
| 4 | In progress | Buffer/closure comparisons; weak phases, storage/reuse and service timings; parser cleanup repair, process accounting and heap/region traces | Final production/docs/audit gates |
| 5 | Pending | Existing language tools and correctness tests | Three applications, compiler phase/scaling costs and sustained load |

Keep original noisy/unmet timing results. Fewer operations or smaller binaries do
not complete runtime acceptance. Do not rerun unchanged samples for qualification.

## Final observer checks

[Run 42686754531](https://github.com/e6qu/fun-with-pipes/actions/runs/42686754531)
passes at `bb0add788321eb30068889b4961667d1f858d3a1`, tag
`roadmap/parser-mapped-boundary-2026-11-09`: AMD64 `129395531588`, ARM64
`129395531599`. [Documentation 42686761614](https://github.com/e6qu/fun-with-pipes/actions/runs/42686761614),
job `129395546461`, also passes. Both native jobs pass eight parser traces,
four actual missing releases, successful mapped resize and two-arena retry.
All 35 complete command records and 36 compact file hashes per host pass audit.

The original mapped observation stopped inside an inlined helper with no usable
parameter. The repair observes the real `__mremap` call and confirms the returned
extent against the final live header, without reading the old mapping after a
move. The control warms unrelated libc thread-cache metadata before measurement;
the reader rejects unattributed internal storage. [Original failures, complete
passing records and scope limits](measurements/parser-allocator-paths-2026-11-09/README.md).

## Verified comparison results

| Work | Source / native run | Result and retained evidence |
|---|---|---|
| Complete callback service | `069e76ed8` / `42675215554` | Both sessions and six corruption controls pass on each host. Full delivery of 4,096 messages takes 18.65–20.23× C and 5.12–6.70× Swift. [Time, RSS, allocation and build scopes](measurements/weak-callback-time-2026-11-09/README.md). |
| Actual C/Rust parser allocations | `62775d559` / `42680540810` | Eight traces and four missing-release controls pass per host. Largest requested peak is 425,984 bytes, 30% above endpoint capacity. [All raw records](measurements/parser-native-allocator-2026-11-09/README.md). |
| Actual fwp heap/region events | `823791751` / `42682917578` | Ten builds, eight O1/O2 traces, eight wrong results and 24 actual release/observer faults pass per host. Largest charged peak is 458,704 bytes above baseline, during tokenization; evaluation allocates nothing. [Tables and complete records](measurements/parser-heap-events-2026-11-09/README.md). |
| Parser process accounting | `6d1608c4f` / `42673573956`, attempt 3 | Both hosts pass six parser tests, snapshots and seven corruption controls. Earlier attempts failed internally before jobs. [Kernel policy, RSS and mapping scopes](measurements/parser-process-accounting-2026-11-09/README.md). |
| Service allocation profiles | `c0ac432fc` / `42664664795`; audit `f3f023820` / `42669442687` | Both native profiles and all 954 command records pass. [Payloads, metadata and actual missing releases](measurements/weak-callback-profiles-2026-11-09/README.md). |

Documentation passes for all five rows. Complete native logs have no outstanding
compiler/debugger warnings. Receipts retain original failures and exact job/artifact
IDs, including the service ARM link repair and parser debugger repairs.

[Weak lookup timings](measurements/weak-operation-time-2026-11-09/README.md) and
[the allocation census](measurements/weak-operation-census-2026-11-09/README.md)
separate a temporary 16-byte successful-lookup result from target/weak metadata.
[Buffer phases](measurements/returned-buffer-time-2026-11-09/README.md) retain both
sessions and all original noisy cases. ARC-operation counts, maximum dynamic
stack and a universal allocator-internal peak remain unmeasured. Failed mapped
remap followed by copy is a reader model, not native evidence.

## Compiler repair and final delivery

The consuming parser worker and owning function entry both released its input.
The entry now follows `rc::consumes_arg`. Source `ee30d13b0`, run `42645911091`,
passes both Linux hosts, six parser tests, primitive inventory and actual extra-drop
controls. Regressions cover caller aliases, parse errors and allocation failure.
[Repair evidence](measurements/parser-entry-cleanup-2026-11-09/README.md).
Remaining platforms require the final exact-head gates.

Source comparisons confirm no production/compiler or service timing-source changes
since `069e76ed8`, and no generated fwp heap-observer source changes since
`823791751`. The stricter heap reader adds a useful missing-allocation diagnostic;
all original fault streams still fail for their intended causes. Earlier
[passing production head `7645384bb`](measurements/ownership-peer-gates-2026-11-09/README.md)
does not verify this later batch.

## Local verification and resources

- Through `python3 scripts/local-guard.py`: eight native-allocator reader tests,
  five fwp heap-reader tests, Python syntax checks and 433 documentation link sets,
  106 immutable preparation pairs and all five roadmap rows pass.
- All retained positive traces reconstruct. All 61 fwp command records and 24 fault
  causes per host are checked. A bounded download stopped before one duplicate
  generated C file; source reconstruction matches its original native hash.
  Complete compact records are retained without raising any limits.
- No local fwp compiler build, full suite or benchmark ran. Native execution stays
  on GitHub. Preserve 64 GiB free disk, 2 GiB target data, 1 GiB workload RSS and
  the guard's 180-second limit. Last observed disk free space: about 126 GiB.
- Keep the numerical dispatcher below 512,000 bytes; it is currently 502,158.
