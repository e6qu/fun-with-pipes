# Current work

**Next:** publish and verify the explicit compiler-root repair for the two older
cleanup probes, then run both paired timing sessions on both native Linux hosts.
Keep the failed ARM64 size limits explicit. Finish the combined batch in
[PR #241](https://github.com/e6qu/fun-with-pipes/pull/241), then run all nine final
production jobs and documentation before squash merge.

Worktree `/private/tmp/fwp-returned-callables`, branch `numeric-fold-validation`.
Preserve unrelated primary-checkout edits. Compiler source is `0bca5f91`; subsequent
changes repair fixtures and retain evidence. Do not repeat count measurements for
these fixture-only changes or repeat unchanged noisy timings to seek a pass.

## Roadmap status

| Step | Status | Evidence / remaining work |
|---|---|---|
| 1 | Verified | All 96 source/count observations identify addition accumulators as removable; input/pair results escape into lists |
| 2 | Verified | Preparation `7b300717`, tag `roadmap/derivative-record-fold-protocol-2026-11-02`, freezes requirements before compiler edits |
| 3 | In progress | New numeric-fold and handler checks pass on three native hosts; verify older cleanup probes with explicit roots |
| 4 | In progress | Both count audits complete; ARM64 size limits fail; paired timing, nine final production jobs and documentation remain |

## Current results

| Check | Source / run | Result |
|---|---|---|
| Focused native suite | `770c4002`, `41372225789` | Each host: 37 pass, two older cleanup probes fail before execution |
| Updated count measurements | `0bca5f91`, `41371032477` | All observations complete; job failures are those same two probe lookups |
| Independent updated count audit | `41372228352` | All 96 count/memory observations pass; 15 ARM64 code-size limits fail |
| Initial count audit | `a690733e`, `41371028926` | Same savings and size failures, retained separately |

All eight target logs and compiler diagnostics were audited on GCC Linux
ARM64/AMD64 and Clang macOS ARM64. Numeric-fold semantics, exact owner counts,
empty/shared inputs, exclusions, injected traps, allocation failure and actual
cancellation pass. Worker boxing/preparation, derivative precision/nesting/scopes
and all 15 effect tests pass. No unexpected compiler warnings were found.
Latest focused jobs: ARM64 `125044938788`, AMD64 `125044939256`, macOS `125044938472`.
Logs: `/private/tmp/fwp-241-export-{arm,amd,mac,audit}.log`.

The [measurement report](measurements/derivative-record-folds.md) retains both
compiler sources, archive digests and failed limits. At 129 coordinates/199 updates,
current-vector form, GCC O2/workspace off, the whole solve removes 25,273 allocation
requests, 606,552 requested bytes and 25,472 effective retains on both hosts.
Peak managed charge stays 21,888 bytes; final managed/raw storage is zero.
ARM64 instruction growth reaches 2,976 bytes against a 1,024-byte limit; AMD64
shrinks by 928–1,328 bytes. Static-frame limits pass. No timing claim yet.

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
  Production code and the measurement compiler remain unchanged.

Earlier focused runs `41359574645`, `41369894377` and `41370956853` retain the
selection/probe failures. Their logs are `/private/tmp/fwp-240-focused-*.log`,
`/private/tmp/fwp-241-focused-*.log` and `/private/tmp/fwp-241-attempt-*.log`.
No passing rerun is presented as a repair without its source change.

## Local checks

All commands use `python3 scripts/local-guard.py`, serially. Full builds, suites,
benchmarks and large audits run on GitHub. Local target data is empty; last free
disk reading was about 69 GiB. Stop if the guard refuses work.

- Current probe-root repair: `cargo fmt --all` passes (1.87s).
- Updated audit archive digest verified and report retained (0.13s).
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
