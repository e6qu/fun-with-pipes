# Current work

**Next:** freeze the returned-callable timing protocol, including Swift and a
same-source fwp reference with only the borrowed-call optimization disabled.
Measure construction, repeated invocation and release before deciding delivery.
The user prioritizes execution time and working memory over executable size.
There is no pending user question about the size budget.

Worktree: `/private/tmp/fwp-returned-callables`; branch `returned-callable-peers`;
[draft PR #234](https://github.com/e6qu/fun-with-pipes/pull/234). The primary checkout
has unrelated preserved work; do not reset it. PR #233 is verified, squash-merged
and integrated. Its [delivery record](roadmap-history.md#state-range-elimination-pr-233)
owns all ten audited gates, tree identity and cancellation of duplicate jobs.

## Swift comparison completed

Measured source: `80a0504a97f7c96291e77be6e8f843d5cb8c7391`.
Run `41214191081` passes all four native jobs:

| Architecture / session | Job |
|---|---:|
| AMD64 / 1 | 124575187490 |
| AMD64 / 2 | 124575187736 |
| ARM64 / 1 | 124575187763 |
| ARM64 / 2 | 124575187723 |

Each runs seven C/Rust/Swift/fwp programs, copy controls, separate peak-RAM samples,
33 Swift arithmetic cases, scalar closure overflow checks and reference-capture
release controls. All complete logs and compiler diagnostics are reviewed.
The package manager notes an absent manual page; there is no compiler warning.

Runner audit `41215212017`, job `124578208152`, rechecks all four artifacts and
prints their timing/RAM observations without executing saved binaries. The
[report](measurements/swift-peers.md) and [summary JSON](measurements/swift-peers-2026-10-31.json)
retain actual CPUs, medians, all copy failures, RAM samples and artifact digests.
Full raw observations, sources and binaries remain in the named GitHub artifacts,
currently expiring 2027-01-29; the summary is not a replacement for those files.

Five ARM64 cases pass both Neoverse-N2 sessions' controls. Map and pipeline fail.
The AMD64 sessions use different CPUs (EPYC 9V45 and Xeon 8573C), so they do not
establish repeatability; three rows per session also fail their copy controls.
Preserve all ten inconclusive rows out of 28. Do not retry unchanged observations.
Swift allocation/ARC-operation counts, callable phase timing, parser, weak-link
and numerical peers remain explicit missing coverage. No C/Rust/Swift parity claim.

The new result reader only adds reporting to the audited observations. The
latest prior docs gate, `41214509533` / `124576105817`, passes 344 Python cases
across 53 suites; only intentional reporter/selector failures appear in its log.
The final summary-preservation test and docs update still need the new head's gate.

## Borrowed-call candidate

For an initial, exactly saturated borrowed call, null argument-drop metadata proves
all parameters are plain values. The runtime copies them into the existing typed
entry, preserves the caller's closure and returns its owned result. Extra returned
callables still get consumed; partial calls and owned captures keep their handling.
Handwritten String/wide callback metadata and copied-list input cleanup are repaired.

Baseline `7d7cf98b`, first candidate `1f929022`, revised candidate `dacaf253`, and
their immutable tags/complete archives are owned by the
[callable report](measurements/returned-callables.md). Revised run `41179056746`
passes 49 Rust tests, 16 Python controls and 170 measurement commands on each
GCC ARM64/AMD64 and Clang ARM64 host. The integrated compiler/runtime still match
that candidate. Calls remove a retain/release pair and one helper entry. Captured
payload and count-table storage remain; elapsed-time benefit is unmeasured.

Both candidates fail the original ARM O1 text budget: 24,540 → 28,892 bytes
(+17.7%, limit 5%). The first candidate's byte-identical linker reproduction proves
a Cortex-A53 erratum stub reserves 4 KiB. All other count/storage, code and frame
limits pass. Keep the original failures and hardware protection; evaluate the
tradeoff through measured performance and working memory. Scalar-fold approval
keeps its timing goal open and is recorded separately.

## Verification and repairs

- `41212931691` stopped before timing: the Swift container lacked GCC's C++
  frontend. Install `g++`, select `CXX=g++`, and retain build logs. Rustup explicitly
  recognizes the root-container home layout; no HOME variable is changed.
- `41213323565` builds all four compilers and passes Swift arithmetic controls,
  then Git rejects mounted-checkout ownership. Trust only `$GITHUB_WORKSPACE`
  inside the throwaway container and verify source identity before building.
  Neither failed run contains timing samples. All four logs from each are reviewed.
- Local Swift 6.2.1 ARM64 closure checks pass (2.92s): eight checksum/representation
  rows, normal release and omitted-release exit 78. Three record tests pass
  (0.13s); workflow lint and roadmap audit passed before the checkout repair.
- The local guard subsequently refused a workflow recheck: free disk is below
  64 GiB. Do not bypass it or download large artifacts locally. Remaining checks
  and artifact audits run on GitHub. Small report files transcribe the runner audit;
  no local timing or binary re-execution occurred. No unidentified files were deleted.

Raw logs: `/private/tmp/fwp-swift-*.log`. The result audit is
`/private/tmp/fwp-swift-report-a8d5.log`. All new files are in the same PR.
After the callable performance assessment, require all nine final-head production
jobs and docs before squash merge. Keep the commit to one line, at most 80 characters,
with an explicit empty body and no trailers or attribution. The PR remains a draft.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Maintain GC-free lifetime and cycle checks |
| 2 | Verified | Preserve scoped A1–A6; broader costs belong to B1 |
| 3 | Verified | Preserve the stated F1–F3 call/recursion scope |
| 4 | Verified | Preserve decimal savings and the recorded loop gap |
| 5 | In progress | Meet D2's remaining timing requirement |
| 6 | In progress | Resolve N1 controls before N2 timing acceptance |
| 7 | In progress | Complete callable phase costs and remaining B1/B2 peers |
| 8 | In progress | Complete numerical and integrated V1/V2 acceptance |

[PLAN.md](../PLAN.md) retains the unchanged numerical budgets and failed controls.
