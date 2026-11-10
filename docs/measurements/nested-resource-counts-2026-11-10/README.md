# Fewer nested lifetime holds: native counts

**The count target passes on Linux ARM64 and AMD64. Heap use is unchanged;
ordinary speed and process-memory acceptance remain open.**

Reference compiler: `65719f7fc2277a5b97c5a790df941fea6c5eb4d7`.
Candidate: `c49af8a6e873380cd328d2679c1df2a6a795b489`, tag
`roadmap/nested-resource-frozen-reference-2026-11-10`.
[Run 42790112990](https://github.com/e6qu/fun-with-pipes/actions/runs/42790112990)
passes both jobs and all report-reconstruction controls.
[Contract](../nested-resource-owners.md).

## Work measured

Both fwp compilers build the same queued-message service. Each pending message owns
16 integers and a weak reference to its receiving channel. Cases use 64 or 4,096
messages and four paths:

- Deliver all messages and verify the received count and checksum.
- Skip one in four pending messages before delivery.
- Expire the receiver before dispatch; every weak lookup must fail.
- Handle an error after delivering the middle message; release the remaining work.

These builds count operations; they are **not timing builds**. The comparison is
new fwp against the frozen fwp reference, not C/Rust/Swift. GCC O1 and O2, no LTO,
explicit `armv8-a` / `x86-64`, dynamic memory. Complete native cases agree at both
optimization levels and on both hosts. Toolchains: GCC 13.3.0 and Rust 1.99.1;
complete versions and host identities are retained in the report ZIPs.

## Results for 4,096 messages

A cleanup registration records what must be released if a call fails or unwinds.
An actual retain increases an object's reference count; calling a generic retain
helper does not necessarily increase a count.

| Path | Cleanup registrations: reference → candidate | Reduction | Actual retains: reference → candidate | Allocation requests, unchanged |
|---|---:|---:|---:|---:|
| Deliver all | 876,631 → 606,259 | 30.84% | 307,232 → 290,826 | 77,846 |
| Skip one in four | 836,695 → 566,323 | 32.31% | 293,920 → 278,538 | 72,726 |
| Expired receiver | 733,243 → 462,883 | 36.87% | 253,976 → 241,670 | 57,354 |
| Handled error | 454,909 → 319,657 | 29.73% | 159,843 → 151,627 | 47,138 |

All eight cases exceed the frozen 20% cleanup-registration reduction target.
Actual retains/decrements fall by 4.85–5.34% in the large cases. For full delivery,
generic retain-helper calls fall by 94,230, but actual increments fall by 16,406:
most of the removed calls would not increment a count. Instrumented calls are not
counts of ordinary machine instructions; GCC may remove some work without counters.

Allocation requests, requested bytes and peak charged storage are identical.
Each large case peaks at **1,016,280 charged bytes**, including 320 bytes already
live before the service call. Each call returns to that same 320-byte baseline.
The separate physical-free ledger verifies complete program cleanup. Charged
bytes include allocator slot padding; they are not RSS or maximum stack use.

Generated C selects 43 borrowed parameter holds in the service and 1,310 in the
maintained HTTP application. These are static sites, not invocation counts or
proof of an HTTP speedup.

## Verification and retained evidence

Each host passes:

- Seven proof controls, seven original-frame controls and eight native targets
  containing 34 integration tests, including weak expiration, aliases, cancellation,
  storage reuse and handled errors.
- 32 native service executions: two compilers × O1/O2 × eight cases.
- Eight real fault controls: an extra cleanup push/pop pair must add exactly one
  to both counters; omitting the result release must fail with live storage.
- Six altered-report controls, including changed counts, selection, binary identity
  and reference revision, even when file hashes are recomputed.

| Host | Passing job | Full native artifact |
|---|---|---|
| ARM64 | `129741105253` | `13753338003` |
| AMD64 | `129741105281` | `13753028801` |

[Complete ARM log](arm-job.log.gz), [complete AMD log](amd-job.log.gz),
[run receipt](run.json), [artifact sizes/hashes](artifacts.json),
[summary](summary.json) and [retained-file hashes](files.json) preserve the results.
Both complete logs contain no compiler warning or failed test.

The [ARM reports](arm-reports.zip) and [AMD reports](amd-reports.zip) retain small
raw records, commands, original manifests, toolchains and rejection controls.
Selected members passed CRC checks; report/command hashes and all raw count
differences were independently reconstructed locally. Full generated C and native
binaries remain in the GitHub artifacts; the runner audited their complete
manifests. The full native ZIPs were not downloaded or hash-verified locally.

After extracting the two report ZIPs into separate directories, reproduce the
small-record reconstruction from the repository root:

```sh
python3 scripts/local-guard.py python3 scripts/summarize-nested-resource-counts.py \
  --arm /tmp/nested-arm --amd /tmp/nested-amd \
  --source c49af8a6e873380cd328d2679c1df2a6a795b489 \
  --output /tmp/nested-summary.json
```

The added [premature-closure control](../nested-resource-lifetime-2026-11-10/README.md)
also passes on both hosts. Next: ordinary runtime, peer and compiler-cost
measurements, HTTP functional/load checks and final platform gates. No timing
result is inferred from these counters.
