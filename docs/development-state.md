# Session handoff

## Current delivery

Main is `f74c9d2998d595b4a3c15ee4a225a49963c1a6ea`, the verified squash merge of
[PR #194](https://github.com/e6qu/fun-with-pipes/pull/194). All nine production
jobs and documentation passed at `489d8414e68678e30829df525982ce8790a4aadc`;
complete logs, merge files, parent and single-line message were checked.
[History](roadmap-history.md)
records the result. Redundant same-tree push CI `39753088259` was cancelled;
the documentation run was preserved. Receipt: `/private/tmp/fwp-194-final-acceptance.json`.

[PR #195](https://github.com/e6qu/fun-with-pipes/pull/195) is open at `a284eb0a338cae4efdd9534fd2d67c60a4f04e82`.
Production run `39753716407` and documentation run `39753716342`
are its final-head gates. Benchmarks and documentation pass; both Linux, all
four Mac and both Windows jobs are running with no failed step in the latest audit. The combined delivery is branch `native-command-ownership`, worktree
`/private/tmp/fwp-native-command-delivery`. Its four prepared commits replay onto
#194's merge with identical files before documentation updates. Preparation
source: `3a56acd7bf9003df61293bd71abd01bc1c0d4c60`;
six-host run: [39752987389](https://github.com/e6qu/fun-with-pipes/actions/runs/39752987389).
Both Linux hosts, both Windows hosts and Intel Mac pass all 23 integration
tests; AMD64 Linux also passes 176 unit tests. ARM Mac remains queued. Seventy
actual binaries across the five passing hosts were inspected, including generated
C, native instructions, cleanup controls and tracing-code exclusion in ARC.
Full final-head production and documentation gates are also required before merge. The batch contains:

- Explicit `--gc arc`/`--gc tracing` for native run, exec, test, serve and pipe.
  Every test entry is checked. Missing C compilers report an error; interpretation
  must be selected explicitly. Tracing remains the default pending migration.
- Native test recovery after root traps, exits and cancellation. Owners, pending
  children, state scratch storage and failure messages release before later tests
  run. Child traps/exits remain process-fatal in both engines. See the
  test examples in the prepared reference.
- Concurrent executable publication under a short file lock, Windows cache
  timestamp access, server-process cleanup and bounded cross-platform test
  monitoring with preserved diagnostics.
- [Derivative measurements](measurements/ad-application.md) separating managed
  storage, raw tape buffers and process memory. All 104 measured Linux images
  and cleanup controls were inspected. This is measurement, not a new runtime
  optimization or a C/Rust parity claim.

Next: audit every completed job in the six-host run, inspect its generated C and
executed binaries, and audit PR #195’s final-head gates. Fix all encountered failures
together. Require all nine final-head production jobs and documentation before
squash merge, with an explicit subject of at most 80 characters and empty body.
Verify the merge files, parent and message, then continue the plan. Publication
and merge are already authorized.

## Checks and unresolved validation

At `03e1e6942419565b67b83249ca787a9740e1680a`, run `39749922003` passes both
Linux and both Mac jobs: 23 integration tests per host and 176 Linux AMD64 unit
tests. Both Windows jobs failed a synthetic monitor command whose nested quoting
misread path backslashes; this then skipped evidence-directory creation. The
repair covers a real quoted/spaced path, creates evidence before checks and lets
independent compiler checks continue. All six logs were audited. Windows native
tests did not execute in that run; the current rerun must establish their result.

Earlier run `39741271730` exposed an unnecessary Rust borrow, a malformed state
fixture, Windows cache replacement of an executing image and surviving server
children after test completion. All are repaired in this batch; earlier failures
remain in archived receipts instead of being counted as passing coverage.

The derivative experiment at `be8d87f0e56cb6bb496716d102b0b89bff6d9000` passes
both Linux jobs in run `39739049666`. Its three-coordinate loop keeps 1,792 raw
bytes between updates at both 199 and 1,999 updates, then frees them at shutdown.
Timings include a 5.3% slower ARM loop. Complete samples and binary hashes are in
the prepared report data. Repeated identical
checkpoints are losslessly encoded; reconstructing the original inspection hash
passes. Do not rerun these accepted measurements with a different source.

Focused local checks, serially through `python3 scripts/local-guard.py python3 SCRIPT`:

- `/private/tmp/fwp-check-test-recovery-fixtures.py`, 0.98s: eight root examples
  and two child failures in the saved interpreter; formatting passes.
- `/private/tmp/fwp-check-native-test-runtime.py`, 1.34s: O0/O2 ARC/tracing
  runtime trap/exit/cancellation and owner/state cleanup pass.
- `/private/tmp/fwp-ready-native-recovery.py`, 5.93s: Rust formatting, workflow
  syntax, docs, diff checks and lossless measurement reconstruction pass.
- Prepared `scripts/test-native-test-runner.py`, 7.67s: all 13 controls pass,
  including stuck-child termination, noisy hangs and continued target execution.

These focused checks do not replace native runner or final production acceptance.
The disk guard refused publication below 64 GiB; 411 MiB of downloaded archives
from completed deliveries were removed, preserving tracked reports, hashes,
receipts and all current evidence. Publication then passed within the guard.
Cleanup receipt: `/private/tmp/fwp-completed-archive-cleanup-20261022.json`.

## Independent numerical comparison

Branch `compare-derivative-descent`, worktree `/private/tmp/fwp-ad-comparison`,
is based on PR #195's head. It adds four-way Rosenbrock descent comparisons:
fwp reverse AD, fwp explicit derivatives, and C/Rust explicit derivatives.
The latter two reuse flat buffers; fwp uses lists. Results must distinguish
extra AD work and representation costs instead of calling the whole gap compiler
overhead. Six cases include zero/one update, 1,999 updates and 129 coordinates.

The independent Python derivative agrees with small C/Rust/fwp fixtures through
guarded `/private/tmp/fwp-check-descent-peers.py` (4.51s). Workflow syntax,
formatting and docs pass through `/private/tmp/fwp-ready-descent-peers.py` (6.87s).
These are correctness checks, not local benchmarks or GCC validation. Next
independent action: audit `descent-peers` run `39755925964` at
`018581d6c0711b6a0eba81ed9fdb3e7c41973576` on both Linux hosts, fix all failures
and inspect actual binaries/samples. Auditor: `/private/tmp/fwp-audit-descent-peers.py`. Keep one active PR;
this batch follows #195. Preparation receipt:
`/private/tmp/fwp-ad-comparison-preparation.json`.

The same preparation now extends checked C callbacks to copied string inputs.
It keeps scalar/raw-pointer results and rejects returned managed addresses.
Fixtures cover retained copies after C mutates stack buffers, multiple inputs,
nested calls, errors, suspension and cancellation; the saved interpreter oracle
passes, including partial conversion failures (guarded
`/private/tmp/fwp-check-callback-inputs.py`, 1.36s). Struct-valued
callback parameters remain unsupported; multiple string parameters exercise the
existing ABI. Native evidence and a deliberately omitted input-owner control
remain required. Four C interop tests now fail on a missing/broken compiler;
the focused workflow checks those failures explicitly. The primitive inventory, formatting, workflow and docs pass
(`/private/tmp/fwp-ready-callback-inputs.py`, 7.44s). These changes are not yet
published and do not alter #195's final head or the numerical run's source. The two Linux numerical jobs now pass at
`018581d6c071`; actual binary/report inspection is still required.

## Resume files

PR source/run receipt: `/private/tmp/fwp-native-command-delivery-publication.json`.
Final-gate auditor: `/private/tmp/fwp-audit-195-final.py`.
Ready merge helpers (not yet run): `/private/tmp/fwp-merge-195.py` and
`/private/tmp/fwp-after-merge-195.py`. They require exact-head acceptance.
Native image inspection: `/private/tmp/fwp-inspect-native-commands.py --host HOST`;
five accepted host receipts are under `/private/tmp/fwp-native-command-evidence/3a56acd7bf90/`.

| Purpose | Local path |
|---|---|
| Current focused source/run and audit | `/private/tmp/fwp-native-commands-publication.json`, `/private/tmp/fwp-audit-native-commands.py` |
| Focused acceptance and all failed-run receipts | `/private/tmp/fwp-native-commands-acceptance*.json` |
| Replay and exact-file check | `/private/tmp/fwp-native-command-delivery-integration.json` |
| Accepted derivative check | `/private/tmp/fwp-ad-memory-acceptance.json` |
| Inspected derivative images | `/private/tmp/fwp-ad-memory-evidence/be8d87f0e56c/inspection.json` |

The primary checkout is detached at #194 with this handoff as its only edit.
Use it for guarded checks; full builds, suites and benchmarks run on GitHub.
Preserve 64 GiB free disk, target data below 2 GiB, sampled RSS below 1 GiB and
the 180-second deadline. Never raise limits. The preparation worktree
`/private/tmp/fwp-ad-memory` is clean and remains the focused run's source.

## Roadmap status

| Step | Status | Area |
|---|---|---|
| 1 | In progress | Remove tracing; limit ARC. |
| 2 | In progress | Remove avoidable functional costs. |
| 3 | In progress | Meet measured machine-level budgets. |
| 4 | In progress | Improve autodiff time, memory and precision. |
| 5 | In progress | Validate CPU numerical kernels. |
| 6 | In progress | Establish comparable measurements and budgets. |
| 7 | In progress | Complete the finite application suite. |

All seven [plan](../PLAN.md) areas remain open. Default native execution still
uses tracing. Retained foreign callbacks, host owners and cyclic data remain
ownership work; performance and application acceptance also remain incomplete.
Continue substantial related batches, guided by the
[application suite](application-acceptance.md). JIT is excluded.
