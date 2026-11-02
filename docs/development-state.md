# Current work

**Next:** resolve whether to retain the verified benefits with the frozen size and
speed limits still open, then finalize [PR #241](https://github.com/e6qu/fun-with-pipes/pull/241)
and run all nine final production jobs plus documentation before squash merge.
The [complete measurement report](measurements/derivative-record-folds.md#paired-timings-larger-solves-improve-acceptance-remains-open)
contains the concrete results. No performance requirement has been waived.

Worktree `/private/tmp/fwp-returned-callables`, branch `numeric-fold-validation`.
Preserve unrelated primary-checkout edits. Compiler source is `0bca5f91`; subsequent
changes repair fixtures and retain evidence. Do not repeat count measurements for
these fixture-only changes or repeat unchanged noisy timings to seek a pass.

## Roadmap status

| Step | Status | Evidence / remaining work |
|---|---|---|
| 1 | Verified | All 96 source/count observations identify addition accumulators as removable; input/pair results escape into lists |
| 2 | Verified | Preparation `7b300717`, tag `roadmap/derivative-record-fold-protocol-2026-11-02`, freezes requirements before compiler edits |
| 3 | Verified | All 39 focused tests pass on each native host, including repaired cleanup probes and handler-order checks |
| 4 | In progress | Counts/timings independently audited; size/speed/noise limits remain unmet; acceptance decision and final full matrix remain |

## Current results

| Check | Source / run | Result |
|---|---|---|
| Focused native suite | `55d46cd5`, `41372899452` | Each host: all 39 tests pass |
| Documentation | `55d46cd5`, `41372902366` | Pass |
| Updated count measurements | `0bca5f91`, `41371032477` | All observations complete; job failures are those same two probe lookups |
| Independent updated count audit | `41372228352` | All 96 count/memory observations pass; 15 ARM64 code-size limits fail |
| Initial count audit | `a690733e`, `41371028926` | Same savings and size failures, retained separately |
| Paired timings | `55d46cd5`, `41372905207` and `41373123684` | Four measured sessions; 16 missed speed limits and one noise limit |
| Timing archive audits | `41374711502`, `41374854968` | Pass, including validation of all failed outcomes |

All eight target logs and compiler diagnostics were audited on GCC Linux
ARM64/AMD64 and Clang macOS ARM64. Numeric-fold semantics, exact owner counts,
empty/shared inputs, exclusions, injected traps, allocation failure and actual
cancellation pass. Worker boxing/preparation, derivative precision/nesting/scopes
and all 15 effect tests pass. No unexpected compiler warnings were found.
Latest focused jobs: ARM64 `125046966341`, AMD64 `125046966337`, macOS `125046966148`.
Logs: `/private/tmp/fwp-241-roots-{arm,amd,mac}.log`. The updated count audit log
is `/private/tmp/fwp-241-export-audit.log`.

The [measurement report](measurements/derivative-record-folds.md) retains both
compiler sources, archive digests and failed limits. At 129 coordinates/199 updates,
current-vector form, GCC O2/workspace off, the whole solve removes 25,273 allocation
requests, 606,552 requested bytes and 25,472 effective retains on both hosts.
Peak managed charge stays 21,888 bytes; final managed/raw storage is zero.
ARM64 instruction growth reaches 2,976 bytes against a 1,024-byte limit; AMD64
shrinks by 928–1,328 bytes. Static-frame limits pass.

The 33/129-coordinate timings improve 5.8–7.8% across both forms and all sessions.
Three-coordinate solves improve less than the required 5%; one AMD64 3/1,999 case
has 3.224% identical-copy variation and is inconclusive. Zero/one-update cases
pass non-regression. All output/count/cleanup checks pass. Repeated timing binaries
pass their code/frame limits but do not erase single-solve size failures.

Original AMD64 session 1 rejected an EPYC 9V74 before building/timing; its qualified
EPYC 7763 replacement is retained separately. No completed timing was repeated.
Timing jobs: ARM64 `125046983749`/`125046983860`, AMD64 `125047629643`/`125046983741`.
Logs: `/private/tmp/fwp-241-time-{arm1,arm2,amd1,amd2}.log`; independent audits:
`/private/tmp/fwp-241-audit-{original,replacement}.log`.
Source tag: `roadmap/record-fold-timing-2026-11-02`.

## Repairs and their evidence

- First semantic fixture destructured before its next `fn`, producing a returned
  closure outside the selected direct-worker contract. Projection-based callbacks
  now test selection while retaining the destructured semantic comparison.
- Generated C then exposed generic folding beneath `attempt`. Adding `attempt`
  to the existing known-callback pass preserves capture evaluation outside the
  handler. Raw/optimized interpretation and native O0/O1/O2 agree on captures,
  input order, callback errors and outer handling of capture errors.
- That specialization removed two old probes' indirectly reached entry points.
  Merely adding `export` did not fix executable rooting: CLI builds still select
  only `main`. The repair uses `compile_source` with both `main` and `exports`
  rooted, then ordinary C generation. It saves source/C before probe assertions.
  Production code and the measurement compiler remain unchanged. The repaired
  probes pass on all three hosts, including their deliberate missing-release controls.

Earlier focused runs `41359574645`, `41369894377`, `41370956853` and
`41372225789` retain the
selection/probe failures. Their logs are `/private/tmp/fwp-240-focused-*.log`,
`/private/tmp/fwp-241-focused-*.log` and `/private/tmp/fwp-241-attempt-*.log`.
No passing rerun is presented as a repair without its source change.

## Local checks

All commands use `python3 scripts/local-guard.py`, serially. Full builds, suites,
benchmarks and large audits run on GitHub. Local target data is empty; last free
disk reading was about 69 GiB. Stop if the guard refuses work.

- Current probe-root repair: `cargo fmt --all` passes (1.87s).
- Updated audit archive digest verified and report retained (0.13s).
- Roadmap audit initially caught a renamed required heading; restored
  `Roadmap status`, then all 198 link sets/106 preparation pairs/four steps pass
  (3.66s). No audit requirement was relaxed.
- Timing summary ZIP/file digests pass (0.49s/0.26s); all four measured source-hash
  sets agree (0.26s). Large archive audits ran on GitHub.
- Earlier checks: all ten fwp fixtures type-check; raw handled-callback output
  matches its oracle; reference patch controls, count/timing/layout validators,
  evidence-retention tests, workflow lint and roadmap audit pass.
- Retained verified #239 compiler is under `/private/tmp/fwp-240-baseline-macos/`;
  it checked fixture semantics only, not current compiler changes. Artifact
  `13098119213`, compiler SHA-256
  `6ae32e315ded657cb8e7b5d9b518fc337d527204bf2164733c9c4c273c6cb3b3`.

## Delivery boundaries

The user merged #240 before validation as `5fbd6bea`; its tree matches final head
`20deddfd`. Run `41369348762` passed its benchmark job `125036266818`; remaining
jobs and duplicate merge-tree run `41369360785` were cancelled after confirming
known fixture failures and no additional failed jobs. Cancelled jobs establish
no coverage. Documentation `41361067737` passed. #241 is still a draft; skipped
production jobs do not satisfy acceptance.

[PR #239](roadmap-history.md#numeric-record-zipmap-fusion-pr-239) is the verified
baseline (`1f358249`): all nine production jobs `41342124001` and documentation
`41342116834` pass. The user accepted its allocation savings with ten timing
limits and D2 still open. Preserve those limits and the original failed results.
The present batch has no waiver for its ARM64 size limit or new timing limits.
