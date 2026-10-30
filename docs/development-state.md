# Current work

**Next:** finish the [B1 buffer comparison](measurements/unique-buffer-peers.md)
on branch `ownership-peer-baselines`, worktree
`/private/tmp/fwp-ownership-peer-baselines`. Implement the ordinary-binary runner,
static stack reports and complete evidence verifier, verify Linux memory checkpoints,
then collect the four predeclared sessions. No timings have run. Keep one active PR;
mark it ready only after the grouped implementation and evidence are complete.

## Last verified delivery

[PR #230](https://github.com/e6qu/fun-with-pipes/pull/230) is merged. Squash
`3639f4fad3da318346340f92a89d8ba127f04e73` has the tested `e2fad32c` tree
`d3645c3ba7c3277d64d61b4d5aee1926e3d6c9db`. Its 55-character subject is
one line with no body/trailers. All nine production jobs `41075128588` and docs
`41071247882` pass; every completed log and warning is audited. The
[delivery record](roadmap-history.md#file-cleanup-portability-and-measurement-clocks-pr-230)
owns job IDs, counts and the repaired Linux preflight failure. Duplicate post-merge
runs `41094194847` and `41094194934` were cancelled after tree/message verification.

The preparation branch records the verified merge ancestry only after proving
that its ancestor `e2fad32c` and the squash have identical trees. The old #230
worktree retains its local handoff; do not publish a status-only change there.

## B1 implementation and verified controls

Published focused source: `44e7724d2114f4f4799348cf98684f55b6a4b635`.
Run `41090130137` passes native GCC ARM64 (`124181555909`) and AMD64
(`124181555372`). Both full logs are clean. Artifacts `12992943369` (ARM)
and `12993378149` (AMD) each retain 107 files and 60 native executables. Audits
check 136 native, 90 phase and 108 storage command records, including 18 expected
leak failures. Local archives/logs/audits:
`/private/tmp/fwp-buffer-peer-{arm,amd}-44e7.{zip,log,audit.json}`.

The three entries are restricted unique reads, a known borrowing callback and a
full-array scan. The scan retains ordinary counted storage. Preserve the frozen
A5 fixture; the harness appends the scan to a copy. Each peer selects its entry
at compilation. All arithmetic and per-call checksums remain checked.

Focused checks pass on Clang/Rust locally and both GCC runners:

| Check | Result |
|---|---|
| Peer results/arguments | 420 O1/O2 executions |
| fwp harness | 42 raw/optimized interpreter comparisons, 84 native executions |
| Phase observers | 72 executions, 216 records, 144 damaged-result rejections |
| Allocation observers | 72 executions, including 18 omitted releases detected |
| Measurement clocks | Six helpers, 48 success/failure/omitted-guard executions |

Local native/phase/storage results are `/private/tmp/fwp-buffer-native-checks-3`,
`/private/tmp/fwp-buffer-phase-checks-1` and `/private/tmp/fwp-buffer-storage-checks-1`.
The native harness initially counted proof markers across all exports; it now
checks the selected entry. Retain earlier `fwp-buffer-native-checks-{1,2}` too.
The local compiler package is `/private/tmp/fwp-230-compiler-arm-570b/fwp-macos-arm64/fwp`,
artifact `12986056870`. Its manifest/hash/native architecture were verified;
compiler/runtime/library/build inputs match the preparation source. No local
compiler build ran. The comparison report records the full compiler hash.

## Follow-up in this batch

Peer checks now require `--output` and retain all 432 command records, twelve
executables and both input-source hashes. `/private/tmp/fwp-buffer-peer-records-1`
passes the 420 checks and record audit (5.01s elapsed/1.12s CPU).

The fixed schedule has three entries, four sizes, two warmup rounds, 36 measured
rounds and twelve processes per language/copy per round. Five controls verify
ordering, checked results, complete-round statistics and rejection of 20 damaged
or missing observation sets. D2/N1 limits and sample counts are unchanged.

Linux process-memory checkpoints are implemented but not yet executed on Linux.
The local `--mode parser` check passes 24 parsing controls and compiles 18 programs
in 3.50s/1.27s CPU. Output: `/private/tmp/fwp-buffer-process-memory-checks-1`.
Separate HugeTLB fields were then added and compiled cleanly with Clang O2.
The numerical workflow now includes actual Linux execution of these checkpoints;
the already completed `44e7724d` run predates this addition. The report states
snapshot/observer limitations. Ordinary memory and stack evidence remain required.

The next branch interleaves the existing explicit native test queues and puts
`wasm_arc` first in its existing regular shard. Every target and two-worker
concurrency are preserved. Previous Linux durations were 1,108–1,429 seconds for
that target, creating a long tail. Actual new cycle time is unmeasured. An initial
edit assumed the wrong shard and stopped at its assertion; the corrected change
preserves the regular assignment. All 21 runner controls pass (8.13s/0.31s CPU),
including unequal queues and failure propagation. Workflow lint and the
186-document/106-anchor/eight-step roadmap audit pass.

Local checks run serially through `python3 scripts/local-guard.py`; full builds,
suites and baselines run on GitHub. No resource limit has been raised.

## Evidence and recovery

Keep at least 64 GiB free disk. Four old expanded
`/private/tmp/fwp-descent-output-{1,2}-{amd,arm}` downloads were archived under
the guard; each `.tar.gz` has an `.archive-audit.json`. All 5,784 original files
were verified before removing expanded copies and remain recoverable.

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

GC removal, A1–A6 and F1–F3 are verified at their stated scopes. The remaining
work is D2/N1 timing acceptance, B1/B2 comparisons and the V1/V2 application
matrix. Completed PRs do not close those outstanding criteria in [PLAN.md](../PLAN.md).


## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Preserve GC-free lifetime and cycle guarantees |
| 2 | Verified | Preserve A1–A6; broader ARC costs remain in B1 |
| 3 | Verified | Preserve the stated F1–F3 call/recursion scope |
| 4 | Verified | Preserve decimal savings and the unoptimized loop gap |
| 5 | In progress | Resolve D2's remaining timing requirement |
| 6 | In progress | Resolve N1's control before N2 timing acceptance |
| 7 | In progress | Finish buffer comparisons, then the other B1/B2 gaps |
| 8 | In progress | Finish numerical and integrated V1/V2 acceptance |
