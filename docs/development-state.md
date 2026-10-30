# Current work

**Next:** run focused production GCC checks for the implemented one-byte replacement search in
[the third string candidate](measurements/direct-string-results.md#third-candidate-use-byte-search-for-one-byte-patterns).
Both earlier candidates are rejected by their timing requirements; retain their
complete results. PR #228's final source stays `f3eb5072`: its Intel Mac retry has
passed the test/SDK stages and is building the package. Audit the complete log and
uploads before merge, then integrate main without rewriting measured ancestry.
Open no second active PR.

## Active delivery: application checks, PR #228

[PR #228](https://github.com/e6qu/fun-with-pipes/pull/228) contains directory
allocation-failure coverage, current word-frequency baselines and their evidence
checks. It does not change the compiler/runtime from #227.

All production test results at `f3eb5072` are fully audited: Linux 993 tests/257
summaries each, regular Mac 626/132, ownership Mac 364/127, Windows 811/202 and
benchmarks 2/2. Documentation `41018509711` and both G2 hosts `41018512169`
pass; G2 has 226 tests/three summaries per host.

Regular Intel Mac passed all tests, build and packaging, then two artifact
uploads failed with DNS ENOTFOUND after verifying 3,357 evidence files. Its saved
diagnostic is the intentional cleanup-abort test, not a compiler-abort recurrence.
Production `41018509811` reruns only that job as `123979346074`, on the same
source. Require its full log audit and successful upload before merge.

The [directory report](measurements/directory-failures.md) owns the four allocation
boundaries, aliases/retries, missing-close/builder controls and separate terminal
OOM checks. All six native hosts pass ten focused tests each; all 84 saved probes
and complete logs are retained. The initial harness failure and explicit-entry
repair remain documented. The [word-frequency baseline](measurements/wordfreq-current.md)
owns four audited sessions, 37,080 observations and budgets published before any
candidate. Large-input fwp/C is 2.49 on ARM64 and 3.03–3.04 on AMD64; no parity
claim follows from an improvement over earlier fwp.

## Preparation: reduce replacement/repetition allocations

Worktree `/private/tmp/fwp-direct-string-results`, branch `direct-string-results`.
Frozen measurement branch `unique-string-measurements` stays at `d7c60989`.
The [string report](measurements/direct-string-results.md) owns both protocols,
fixed acceptance limits, source reasoning, measurements and retained evidence.

**First candidate is rejected.** Protocol `e0fb1a09` precedes runtime/tests
`089465bb`; paired measurements use `8da8f4cf`. Direct construction removes
1,640/26,216 raw allocations for the small/large word-frequency inputs, but managed
counts stay unchanged. All four sessions miss the required 5% large-input gain;
both AMD results also exceed 1% regression. AMD session 1's small-input copy
control is 1.071605080 > 1.05. Preserve all results; do not retry unchanged code,
reset limits or describe an allocation reduction as a measured speedup.

Runs `41024798466` and `41033950200` contain all 74,040 observations. Complete
logs and seven evidence tests per session are audited. Three earlier mismatched
CPU assignments were rejected before building; their logs/qualification records
are retained too. The [archive](measurements/direct-strings-first-artifacts-2026-10-30.json)
reconstructs every text and native-image byte. The frozen branch
`direct-string-measurements` remains at `8da8f4cf`.

First-candidate correctness passes all six native hosts in `41021988225`:
18 integration tests/seven summaries each, plus 224 library tests and 20 runner
controls on GCC AMD64. All 954 saved executions and 162 native headers/hashes
are audited in the [native archive](measurements/direct-strings-native-2026-10-30.json).
Both WASI hosts pass 32 tests/four summaries in `41023744074`. Complete logs are
audited. These results do not verify the second candidate's changed code.

**Second candidate is rejected by timing.** Published protocol `ebd8f46d`
precedes runtime/test source `d7c60989`. Non-growing replacement reuses a string
only after the existing query proves one owner; overlap-safe copies move forward
through unread input. Shared/static/growing inputs receive a separate result.
Checks cover borrowed aliases, literals, allocation counts and an intentionally
removed uniqueness check. The added ownership query has a cost; retain counts
are not claimed to fall. WASI does not select native unique reuse.

| Run | Purpose | Status |
|---|---|---|
| `41034212790` | Six native hosts, aliases/failure/reuse | All pass; complete logs and 972 probes/180 native headers audited |
| `41034222459` | Both WASI hosts and physical reclamation | Both pass 32 tests/four summaries each with full log audits |
| `41035137961`, `41036473750` | Four paired measurements | All rejected: large-input ratios 0.969173008/0.966967292 ARM, 0.982461514/0.979854379 AMD |

All four sessions confirm exactly 12,513/199,721 managed requests and
431,876/6,909,092 requested bytes, zero raw requests, unchanged retains/peak and
zero final charge. Every other timing/representation control passes. These facts
do not satisfy the required 5% gain. The [complete archive](measurements/string-reuse-artifacts-2026-10-30.json)
retains 74,040 observations, every source/native-image byte, all profiles and logs.
Two unmeasured CPU rejections (9V74, 9V45) remain archived. No timings were retried.

Published protocol `7f58e4d9` precedes the third implementation, which selects
standard C `memchr` only for one-byte patterns inside
`fwp_p_replace`, preserving the existing substring algorithm otherwise. The frozen
inputs imply 75,360/1,205,856 byte comparisons in first searches alone; this is
source-level work, not a measured CPU-time attribution. Keep all existing budgets,
cache the unsigned pattern byte, and extend high-bit/source-alias controls. Run
focused GCC checks before four new measurements; repeat the other platforms in the
complete final matrix after the batch, not after each intermediate edit.

Guarded local checks pass: seven allocation/evidence tests with Clang O2 probes,
144 exact size/control exits at Clang O0/O1/O2, Rust formatting, Python syntax,
workflow lint, roadmap and whitespace checks. The new count gate rejects all four
budget violations in the first candidate's actual measured report. Retained
archive checks pass 28 evidence tests. No local full build or benchmark ran.

## Previous delivery and remaining gaps

The user merged [#227](https://github.com/e6qu/fun-with-pipes/pull/227) as
`0e114aa5`, matching tested tree `830e41b3` from `8e291876`. All nine production
jobs, documentation and both G2 hosts passed and were audited. The
[delivery record](roadmap-history.md#eager-captures-and-typed-numerical-loops-pr-227)
owns the identities and checks.

D2's zero-update ratio remains **1.022815765 > 1.02** in `40912773534`; N1's
small-array inclusive copy control remains **1.030786192 > 1.02** in `40951090783`.
The [timing report](measurements/timing-variation.md) preserves every observation.
Their causes are unresolved; a user merge does not waive performance requirements.
The original Intel compiler abort also remains unexplained. Preserve its
[report](measurements/compiler-abort.md) and diagnose any recurrence from source.

The primary checkout is detached at #209 with a recovery handoff and untracked
compiler-abort report; preserve both. Full builds/suites/measurements belong on
GitHub. Local checks stay serial and guarded. Require nine exact-head production
jobs, documentation and G2 before merge, with complete log audits. Squash with
one subject of at most 80 characters, an empty body and no attribution/trailers.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain GC-free lifetime and cycle checks |
| 2 | Verified | Maintain A1–A6; sharing still uses ARC |
| 3 | Verified | Maintain F1–F3's stated call and recursion scope |
| 4 | Verified | Preserve delivered decimal cost reduction and recorded loop gap |
| 5 | In progress | Resolve D2's zero-update timing requirement |
| 6 | In progress | Resolve N1's inclusive array control; investigate computation cost |
| 7 | In progress | Broader B1/B2 comparisons |
| 8 | In progress | Deliver directory coverage and qualified word-frequency changes; finish remaining V1/V2 rows |
