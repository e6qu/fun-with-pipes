# Current work

**Next:** finish [PR #230](https://github.com/e6qu/fun-with-pipes/pull/230).
Keep head `e2fad32c2b2fd05658a8229fe90708d5756f329b` fixed while production
`41075128588` runs. Audit every completed log and failed step, fix any failure,
then squash-merge with one subject of at most 80 characters and an empty body.
Verify the merge tree/message before continuing. One active PR only.

## Active delivery

Worktree `/private/tmp/fwp-file-boundary-portability`, branch
`file-boundary-portability`. The [file-boundary report](measurements/file-boundary-portability.md)
records native Windows errors, borrowed handles and flush visibility, seven C
recovery-probe repairs, focused checks and all 22 saved executions per host.
Five kernel/map/pipe-test clocks now reject failed reads before using timestamps.
The plan and benchmark guide remove obsolete directions and name remaining gaps.
Compiler, runtime, library and build inputs are unchanged from verified #229.
PR description: `/private/tmp/fwp-file-portability-pr.md`.

Final-head checks:

| Gate | Status and audited coverage |
|---|---|
| GCC/docs `41071247882`, job `124115723586` | Passed; complete log and all 40 clock controls audited |
| Benchmarks `124129161888` | Passed; 2 tests/2 summaries audited |
| macOS ARM regular `124129161379` | Passed; 627/132, 12 SDK/terminal tests and 40 clock controls audited |
| macOS ARM ownership `124129161812` | Passed; 364/127 audited |
| macOS Intel regular `124129161824` | Running, no reported failures |
| macOS Intel ownership `124129162126` | Running, no reported failures |
| Linux AMD `124129161927`, ARM `124129162084` | Running; repaired preflight and required compiler checks pass |
| Windows AMD `124129161796`, ARM `124129161880` | Running, no reported failures |

Full logs are `/private/tmp/fwp-230-*-e2fa.log`; docs uses
`/private/tmp/fwp-229-docs-230-e2fa.log`. Check the live run before acting on this table.
Skipped earlier draft checks provide no acceptance evidence.

## Complete audit of the preceding failed head

Production `41068200453` at `570b777a` is fully audited. Both Linux clock steps
passed an unset `$CC` and failed before GCC launched. They then skipped library
docs, inventory, formatting and Clippy, including WASM Clippy. Each completed
993 tests/256 summaries and all 12 SDK/terminal tests. The only other diagnostic
is the missing artifact from the skipped inventory. Those missing gates are not
passes; the explicit compiler repair is now running them on e2.

All other old jobs pass: benchmarks 2/2; regular macOS 627/132 plus 12 SDK tests
per host; ownership macOS 364/127 per host; Windows 817/205 per host, including
all three new file targets. Windows passes 10 SDK tests and explicitly skips the
two POSIX terminal tests. No additional failed target or compiler warning remains.
Original logs are `/private/tmp/fwp-230-*-570b.log`. The strict failed-Linux
helper is `/private/tmp/fwp-audit-linux-230-preflight.py`; it retains the known
failure, skipped coverage and warning. Other jobs use
`/private/tmp/fwp-audit-production-log.py`. Both run through the local guard.

## Next batch already in preparation

Branch `ownership-peer-baselines`, worktree `/private/tmp/fwp-ownership-peer-baselines`,
is published through `4e83447a` (following `93be9909`). No second PR is open.
The [unique-buffer comparison](measurements/unique-buffer-peers.md) defines
C/Rust equivalents of the existing fwp fixture and the concrete remaining work.
Do not treat this as a measured speedup or completed B1 comparison.

Guarded checks pass: `check-unique-buffer-peers.py --cc clang --rustc rustc`
(420 O1/O2 result/error cases), and `check-unique-buffer-native.py` (42 raw/optimized
interpreter comparisons and 84 native O1/O2 executions). The latter checks lengths
−2^63, −1, 0, 1, 16, 4,096 and 262,144, each with one/three native calls. Its
first attempt counted markers in all exported functions; the fix checks only the
selected entry. Retain `/private/tmp/fwp-buffer-native-checks-{1,2,3}`. The latest three-entry
check exits 0 in 8.87 seconds, 3.95 CPU seconds. The peers exit 0 in 5.46 seconds,
0.93 CPU seconds. The new full-read scan retains ordinary counted storage; it
does not expand the existing unique proof. All entries are selected at compilation.

The compiler package is `/private/tmp/fwp-230-compiler-arm-570b/fwp-macos-arm64/fwp`,
artifact `12986056870`. Its manifest/hash and native architecture were verified;
compiler/runtime/library/build inputs match the preparation branch exactly.
No local compiler build ran. The comparison report records the full SHA-256.

Uncommitted follow-up adds `unique-buffer-baselines.py` and its two passing
schedule controls. Six labels give each language an identical-copy control;
36 measured rounds rotate positions and within-round predecessors. The report
fixes sizes, call counts and sample counts before execution. No baseline session
has run. Next implement separate phase/storage observations and the evidence
verifier, validate with native GCC, then collect the four declared sessions.
Keep D2/N1's existing failed experiments unchanged.

## Evidence and recovery

[#229](roadmap-history.md#string-costs-and-application-cleanup-pr-229) is the last
verified delivery: squash `bae1a858126794845552c98108237002fb114f37` has the tested
`8d908e0e` tree. Its history record owns all nine production, docs and G2 audits.
Local checks stay serial under `python3 scripts/local-guard.py`; full builds,
suites and benchmarks run on GitHub. Preparation docs passed the 186-document,
106-anchor, eight-step audit. Resource limits are unchanged.

Four old expanded `/private/tmp/fwp-descent-output-{1,2}-{amd,arm}` downloads
were archived under the guard. Each `.tar.gz` has an `.archive-audit.json` with
all 1,446 file hashes/sizes; every file was verified before removing its expanded
copy. All 5,784 files remain recoverable. Free disk is about 66 GiB; preserve 64.

The primary checkout remains detached at #209 with a dirty recovery handoff and
untracked compiler-abort report. Preserve both. Automatic approval review rejected
replacing that handoff; backup `/private/tmp/fwp-primary-recovery-before-file-checks.md`.
Do not retry or work around that refusal. The former #229 worktree
`/private/tmp/fwp-direct-string-results` also retains its local handoff.

D2 remains **1.022815765 > 1.02** in `40912773534`; N1 remains
**1.030786192 > 1.02** in `40951090783`. No unchanged rerun, further sample increase
or relaxed limit. CPU affinity and equal executable names were insufficient.
The [original Intel compiler abort](measurements/compiler-abort.md) is unexplained;
preserve its evidence and inspect the source/input if it recurs.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain GC-free lifetime and cycle guarantees |
| 2 | Verified | Maintain A1–A6; sharing still uses ARC |
| 3 | Verified | Maintain the stated F1–F3 call and recursion scope |
| 4 | Verified | Preserve decimal savings and the unoptimized loop gap |
| 5 | In progress | Resolve D2's zero-update requirement |
| 6 | In progress | Resolve N1's array control before N2 timing acceptance |
| 7 | In progress | Complete the named B1/B2 comparison gaps |
| 8 | In progress | Deliver file-boundary coverage and finish V1/V2 |
