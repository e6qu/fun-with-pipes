# Current work

**Next:** publish the census receipt repair, then rerun only its artifact audit
against saved run `42134160356` (source `6a0ae280`). The original audit checked all
lookup probes but printed obsolete totals. Once corrected, launch the frozen
runtime sessions. Retain the one inconclusive compiler-time case under the
standing timing policy; do not claim that case passed or repeat it for a pass.

Branch: `recording-work-review`, based on verified merge `2e6e09f5`.
Worktree: `.worktrees/scalar-constant-lowering`. Active draft:
[PR #262](https://github.com/e6qu/fun-with-pipes/pull/262).
The [contract](measurements/recording-lookups.md) was committed at `bfddc31e`
before implementation. It preserves parent/capacity checks and excludes any
worker that can change tape lifetime or suspend through task/service entry ticks.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Generated source reconciles eight nodes per pair/update with the saved profiles. |
| 2 | Verified | Closed numeric worker proof and focused native controls pass; registry changes, recovery and suspension excluded. |
| 3 | Verified | Same-source comparison and limits frozen at `bfddc31e`. |
| 4 | In progress | Focused safety and complete artifact audit pass; memory/compiler measurements, timing and final platform gates remain. |

## Current verification

Compiler/runtime implementation: `99bf3adccc3380f761876e34830cb938a94dcadd`.
Published repair: `6a0ae280c4616f791df507b44cbd31935a16cd67`. It changes tests and
docs, not production behavior. The working handoff update also changes only docs.

Focused run `42129223759` passes all three native hosts. Every complete job log
and all 25 native-target summaries per host were reviewed without unexpected
diagnostics. The small preflight archives also pass: formatting, lint, builds,
302 compiler unit tests per host (four existing ignored), primitive inventory,
reference controls and real-program selection.

| Host | Job | Preflight artifact |
|---|---|---|
| Linux ARM64 / GCC | `127601314667` | `13464610977` |
| Linux AMD64 / GCC | `127601314675` | `13464306516` |
| macOS ARM64 / Clang | `127601314800` | `13464720698` |

The [complete artifact audit](measurements/recording-lookup-checks-2026-11-06/README.md)
passes in `42134128147`, job `127617842786`: 848 native images and 864 probe
observations per host, all generated-source digests and target logs, no unresolved
issues. Artifact `13464463640` and its digest were verified before retention.
Large artifact processing ran on GitHub runners. Small log/preflight audits used `scripts/local-guard.py` and took
0.13–0.14 seconds each. Scratch evidence: `../gradient-work/recording-repaired-*`.

Docs run `42129158075`, job `127601123357`, passes at the repair commit. Its full
log was reviewed: the three intentional runner-failure controls match their
verified source; there are no unexpected diagnostics.

The earlier focused run `42125357727` exposed two test issues on both Linux hosts:
a manual loop counter rejected by Clippy, and an unscoped recording fixture
correctly rejected by lifetime admission. The repair uses the same explicit ID
range and a real `ad.scope`, with a separate rejection test outside that scope.
It also confines the C probe's recovery hooks to their active `setjmp` frames.
The repaired native tests now pass on all three hosts. The obsolete queued macOS
job was cancelled; no result from it is claimed.

[Measurement controls](measurements/recording-lookup-controls-2026-11-06/README.md)
pass eleven suites (97 tests) in `42123056112`, job `127580112855`, source
`895f766c`. Producer/reference code and the tested controls remain unchanged. The later census
receipt repair is verified separately against the saved native artifacts. The complete log, metadata,
digests and audit are retained; no diagnostics remain. This includes historical
archive checks unavailable in the sparse local checkout.

## Measurement results and remaining work

Source: `6a0ae280c4616f791df507b44cbd31935a16cd67`. No runtime timing session has
run yet; no measured speed improvement is claimed.

- Census `42134160356` passes both architectures. Audit `42135465228` passes
  every saved probe, including lookup counts, unchanged allocation/validation/node
  counts, fresh-run attribution, parent reconciliation, raw storage and stack.
  Its receipt incorrectly hardcodes the older 99-command/24-image/48-execution
  totals. The actual assertions verify 171 commands and 48 images; the repair
  derives totals from checked records (96 executions) and includes lookup counts
  in each case. Publish and rerun only the report; do not rerun measurements.
- [Compiler costs](measurements/recording-lookup-analysis-2026-11-06/README.md):
  run `42134169729`, audit `42135475969`. All 672 commands succeed and all observed
  time/RSS ratios are below 1.05. Thirteen of fourteen timing cases qualify.
  AMD64 large callback worker fails the identical-copy limit (2.854% versus 2%);
  keep it inconclusive. The complete audit verifies that this is the sole failure.
  Saved samples show later timings rising across all four copies; source/output
  and scheduling review establishes no root cause. No timing was repeated.
- After the corrected census report, run `recording-lookup-time` with
  `comparison_session=both`, `native_runner=all`, `evidence_run=42129223759`.
  Qualify hosts before builds and preserve every miss. The final nine-job matrix
  and final-head docs/audits still gate merging.

All four complete measurement job logs were separately audited (0.13 seconds
under the guard). The compiler evidence and diagnostic are retained locally in
the new report directory; the original census audit is under `../gradient-work/`.

GitHub [reported an Actions/Git/API incident](https://www.githubstatus.com/incidents/pfbmpxxfq1cy)
on November 5 at 23:36 UTC. The repair was published after transient push errors;
its jobs started around 23:48 UTC and subsequently passed. Keep accepted runs
through queue delays rather than launching duplicates.

## Previous delivery and measurement inputs

[PR #261](https://github.com/e6qu/fun-with-pipes/pull/261) merged as
`2e6e09f539bcdab965d062f0184b585b340b29d8`.
[Its receipt](measurements/scalar-constant-delivery-2026-11-05/README.md) retains
all nine final jobs, docs, complete audits and the identical tested/merged tree.
Its 27 missed speed targets remain open; the current comparison cannot settle them.

The [saved source/phase review](measurements/recording-work-review-2026-11-05/README.md)
is the completed input to this group. It reconciles the recording sites and
identifies its four source reports. Forward recording accounts for about 72% of
observed derivative-phase time in 129/199; that does not isolate lookup cost.
Keep arithmetic order, eager callback stages and all failure controls unchanged.

About 81 GiB remains free. Keep the fixed resource guard; full builds, suites and
large evidence work run on GitHub.
