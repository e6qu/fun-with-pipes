# Current work

**Next:** verify the phase/source observer, then run the frozen six-case measurement
on both native Linux hosts in [PR #239](https://github.com/e6qu/fun-with-pipes/pull/239).
The [protocol](measurements/derivative-forward-costs.md) was published first at `02d4aa26`.
[PLAN.md](../PLAN.md) defines this batch's four steps. No new compiler/runtime
optimization is selected until the measured costs justify a specific candidate.

Worktree `/private/tmp/fwp-returned-callables`, branch `derivative-forward-costs`.
Base `c124d0c8f13373b0ee11c58d685d850b1b9a5a08`. Preserve the primary checkout's
unrelated edits. One active PR at a time; publication and squash merge after all
final-head gates pass remain authorized. Every commit has one line, at most 80
characters, with no body, trailers or attribution.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Preparation `02d4aa26`; documentation run `41318586442` passes |
| 2 | In progress | Phase/source counters implemented; verify native known-work and omission controls |
| 3 | Pending | Native six-case measurements and artifact audit |
| 4 | Pending | Explain results, select a justified candidate, verify and deliver the batch |

## Current implementation boundaries

- Reuse `measure-iteration.py` for managed requests/bytes, effective retains and
  live charge; `ownership-profile.py` for source-site ownership operations; and
  `descent-phases.py` for the six derivative boundaries.
- The older `measure-ad-allocation-sites.py` profiles allocator return addresses
  for four small examples. Preserve its evidence. The new report uses source
  sites and phases for the six existing whole-solve inputs; it must explain the
  difference between a runtime allocator site and the original language caller.
- Keep ordinary, totals-only and phase/site-instrumented programs separate. No
  timing claim follows from instrumentation or count reductions. No runtime
  default, public language syntax or compatibility adapter is needed.

## Verified baseline

PR #238 is squash-merged as `c124d0c8`. Production `41308228518` and documentation
`41308192400` pass on `c5e29fe9`; all logs are audited. Merge and tested source have
tree `04b9d0704938621f56c7d122ca83fdfed15317df`. The merge message is exactly
`Move derivative weights directly into tape ownership`, with no body or trailers.
[History](roadmap-history.md#direct-derivative-recording-pr-238) and
[measurements](measurements/derivative-recording-moves.md#focused-results) retain
the accepted/rejected results and limits. Duplicate post-merge production run
`41317561459` was cancelled with no failed steps; short post-merge documentation
run `41317561418` also passes.

Completed production logs: `/private/tmp/fwp-238-final-logs/`. The final read-only
audit `/private/tmp/fwp-238-merge-audit.py` passed after distinguishing successful
`0 failed` summaries and Homebrew's already-installed notice from real errors.
The earlier monitor is fixed to #238's head; do not use it for this new branch.

## Checks and constraints

The last batch passed focused GCC/Clang O1/O2 checks, artifact/source hash audits,
all nine native production jobs and documentation. The new Python observer tests
pass through the local guard (source hooks, exact sums, missing/duplicate rows,
invalid phase/site IDs). Native controls and measurements are not verified yet.
Run `derivative-forward-costs` in the numerical evidence workflow after publication;
full production gates follow the complete batch.

Focused local commands, each through `python3 scripts/local-guard.py`:

- `python3 scripts/test-derivative-ownership-profile.py`: 7 pass, including
  known-work rejection of valid but swapped phase labels.
- `python3 scripts/test-descent-phases.py --cc clang`: 4 pass. GCC runs on CI.
- `python3 scripts/check-roadmap.py`: 197 link sets, 106 preparation pairs and
  four plan steps pass. No full local compiler build or suite was run.

Use the unchanged local guard serially. Full builds, suites, benchmarks and large
regeneration use GitHub. Disk remains near the 64 GiB floor; retain the guard's
limits. Do not rebuild the compiler locally or duplicate large downloaded archives.

D2/N1/N2 timing limits, original Xeon closure regressions and individual Swift ARC
counts remain open. Measured reductions do not establish universal zero-cost
sharing, arbitrary stack storage or parity with C/Rust.
