# Current work

**Next:** audit the focused `record-zip-checks` run `41324329567` on both native
Linux hosts, repair failures together, then run the prepared paired timing suite for
[PR #239](https://github.com/e6qu/fun-with-pipes/pull/239).
The [protocol](measurements/derivative-forward-costs.md) was published first at `02d4aa26`.
[PLAN.md](../PLAN.md) defines this batch's four steps. The compiler candidate
selected from the audited results eliminates temporary zipped
flat numeric records, including adjacent `Rev[F64]` pairs.

Worktree `/private/tmp/fwp-returned-callables`, branch `derivative-forward-costs`.
Base `c124d0c8f13373b0ee11c58d685d850b1b9a5a08`. Preserve the primary checkout's
unrelated edits. One active PR at a time; publication and squash merge after all
final-head gates pass remain authorized. Every commit has one line, at most 80
characters, with no body, trailers or attribution.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Preparation `02d4aa26`; documentation run `41318586442` passes |
| 2 | Verified | Native known-work, omission, wrong-phase and unfinished-sequence controls pass |
| 3 | Verified | Both hosts pass; all 96 observations and complete logs audited at `afc0f78f`, run `41319946864` |
| 4 | In progress | Requirements published at `73cec3e5` before compiler edits; candidate and controls implemented, native verification pending |

## Current implementation boundaries

- `src/fuse.rs` extends existing zip/map selection to flat numeric records.
  Tests cover values, captures, both input aliases, unequal lengths, returned
  records, trapping arithmetic, partial results and cancellation. Nested records,
  managed fields and boxed wide numbers remain excluded. The count gate requires
  savings of two requests, 48 requested bytes and three effective retains per pair.
  These are acceptance limits, not yet verified candidate results.
- `record-zip-time` reuses the paired derivative runner with a same-source
  reference that disables only flat-record zip/map selection. Two sessions per
  qualified host retain the frozen 5% speed and 2% identical-copy limits. Its
  reference builder and budget controls pass locally; timing has not run yet.
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
all nine native production jobs and documentation. For this batch, numerical run
`41319946864` passes on `afc0f78f` (jobs `124887807761` and `124887808036`).
Both complete logs have no compiler/test diagnostics. The archive auditor verifies
all file hashes, saved observations, source sites, native headers, compilation flags
and known-work failures. All detailed counts match across architectures. The
[report](measurements/derivative-forward-costs-2026-11-01.json.gz) and
[explanation/requirements](measurements/derivative-forward-costs.md#verified-baseline-and-selected-change)
retain the result. Full production gates follow the complete batch.

Candidate `b094fdd8` is published. Focused native run `41324329567` and its
documentation run `41324313889` were queued at the last check. Production draft
skips are not passing gates. Preserve the focused run while preparing timing;
the compiler source has not changed since that dispatch.

Documentation run `41322983262` passes on preparation commit `73cec3e5`; the superseded
queued docs run `41319949124` was cancelled. The library's misleading “about one
evaluation” claim is corrected and its reference regenerated.

Artifacts: `/private/tmp/fwp-239-aarch64.zip` (ID `13089053399`) and
`/private/tmp/fwp-239-x86_64.zip` (ID `13089073406`). Complete compressed job logs
are in `/private/tmp/fwp-239-logs/`. Both artifact API digests were verified.

Focused local commands, each through `python3 scripts/local-guard.py`:

- `python3 scripts/test-derivative-ownership-profile.py`: 9 pass, including
  swapped phase labels, archive corruption and failed candidate count budgets.
- `/private/tmp/fwp-239-record-probe-check.py`: the new record-alias/count probe
  runs with the verified baseline compiler and Clang O1; all 28 cases release
  storage. Omitting result cleanup exits 238 as required. This verifies the
  observer, not the new compiler selection, which must run on GitHub.
- `python3 scripts/test-record-zip-reference.py`: 3 pass; only the selected
  eligibility block changes, and altered/missing/duplicate blocks are rejected.
- `python3 scripts/test-descent-budgets.py`: 10 pass, including record count,
  timing/noise, storage, code-size and stack limits.
- `python3 scripts/test-descent-groups.py`: 12 pass; historical failed sessions
  remain failed when the archive checker gains the new comparison protocol.
- `actionlint -shellcheck= -pyflakes= .github/workflows/numerics.yml
  .github/workflows/roadmap.yml`: workflow syntax and expressions pass.
- The updated forward-cost archive auditor rechecks both original archives with
  `--comparison baseline`; all 96 observations pass. The committed baseline
  artifact is unchanged.
- `python3 scripts/test-descent-phases.py --cc clang`: 4 pass. GCC runs on CI.
- `python3 scripts/check-roadmap.py`: 197 link sets, 106 preparation pairs and
  four plan steps pass. No full local compiler build or suite was run.
- `env FWP_BLESS=1 /private/tmp/fwp-237-stdlib-doc`: the existing standalone
  documentation generator passes and updates `docs/stdlib.md` from library comments.
- `/private/tmp/fwp-239-observer-control.py` and
  `/private/tmp/fwp-239-local-negative-controls.py`: Clang O1 native known-work and
  all four deliberately broken controls pass, using the verified #238 compiler
  package (SHA-256 `59fad77f00615340906d15bf87b7b96cc8d849b3e524eea96502929d8c3c9049`).
- `/private/tmp/fwp-239-small-gradient-control.py`: one three-coordinate update
  agrees across raw interpretation and ordinary/totals/detailed native images,
  workspace off/on, with zero final storage. No local compiler rebuild or sweep.
- `scripts/summarize-derivative-forward-costs.py` with both downloaded archives,
  full source ID and run `41319946864`: all 96 observations and controls pass;
  guarded audit takes about four seconds. No saved binary is executed by the audit.

Old run `38888712709` shows a stale aggregate “in progress” status, but all its
October 16 jobs are terminal. GitHub refuses cancellation because the run is
completed. It has no active runner and was not restarted.

Use the unchanged local guard serially. Full builds, suites, benchmarks and large
regeneration use GitHub. Disk remains near the 64 GiB floor; retain the guard's
limits. Do not rebuild the compiler locally or duplicate large downloaded archives.

D2/N1/N2 timing limits, original Xeon closure regressions and individual Swift ARC
counts remain open. Measured reductions do not establish universal zero-cost
sharing, arbitrary stack storage or parity with C/Rust.
