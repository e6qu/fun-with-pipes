# Current work

**Next:** run and audit the first `record-fold-checks` jobs on GCC Linux
ARM64/AMD64 and Clang macOS ARM64. Fix every failure, then add the physical-release,
allocation-failure/cancellation and excluded-shape controls required by the
[frozen protocol](measurements/derivative-record-folds.md) before measurements.

Branch `derivative-record-callbacks` starts at verified merge `1f358249` in
`/private/tmp/fwp-returned-callables`. The first compiler candidate is implemented; native validation is pending.
Preserve unrelated edits in the primary checkout. These delivery/status updates
are local changes for the next substantial PR, not an untested change to #239.

## Roadmap status

| Step | Status | Evidence / remaining work |
|---|---|---|
| 1 | Verified | Source/count audit verifies all 96 observations and 48 C hashes; input/pair results escape into lists, addition accumulators stay within the fold |
| 2 | Verified | Direct numeric-record left-fold boundary and count, cleanup, code/stack and timing requirements published before compiler edits |
| 3 | In progress | Direct numeric-record left fold and initial alias/empty/effect tests implemented; full cleanup controls and native validation remain |
| 4 | Pending | Audit focused evidence, final nine production jobs and documentation; squash merge |

## Verified delivery: PR #239

[PR #239](https://github.com/e6qu/fun-with-pipes/pull/239) merged November 1 as
`1f35824928abc2d468a469c03622f095ce2a4742`. All nine
[production jobs](https://github.com/e6qu/fun-with-pipes/actions/runs/41342124001)
and [documentation](https://github.com/e6qu/fun-with-pipes/actions/runs/41342116834)
pass on `9e326ce8db9ba5d0b404c1d9b77641c9e51fd484`.
The merge tree exactly matches tested tree
`bfb2698617f71c9c64a6426de72e944634cefa6c`; its sole parent is verified #238,
`c124d0c8`. The message is one line, under 80 characters, with no body/trailers:
`Remove temporary numeric record pairs from derivative calculations`.
Redundant post-merge CI `41351222101` was cancelled after verifying tree identity
and no failed steps. The post-merge documentation check remains enabled.

| Final job | ID | Audited result |
|---|---|---|
| Linux ARM64 | `124954172954` | 257 targets, 1,026 passing tests, 13 SDK tests; 7,783 evidence files |
| Linux AMD64 | `124954172917` | Same coverage; Linux memory-bound checks execute on both hosts |
| macOS ARM64 regular | `124954172697` | 131 targets, 647 passing tests, 13 SDK tests; 3,970 evidence files |
| macOS AMD64 regular | `124954172829` | Same coverage |
| macOS ARM64 ownership | `124954172930` | Counted corpus, 126 targets, 374 passing tests; 3,359 evidence files |
| macOS AMD64 ownership | `124954172765` | Same coverage |
| Windows ARM64 | `124954172920` | 154 scheduled targets plus 52 direct Rust runs; 845 passing test invocations |
| Windows AMD64 | `124954172877` | Same coverage; both native corpora pass |
| C/Rust benchmarks | `124954172853` | 21 native images, 14 instrumented images, RSS and deliberate leak controls |
| Documentation | `124954151581` | 197 link sets, 106 preparation pairs/tags, plan consistency and control tests |

All six native packages execute outside the checkout. No unexpected diagnostic
was found. Rust invocation totals include repeated Windows controls. Measurement
helpers remain explicitly ignored; Linux `/proc` checks are not macOS coverage.
Windows executes 11 SDK tests and seven process controls, skipping two POSIX
terminal tests and three POSIX process controls. Intentional scheduler panics,
runner failures and injected benchmark leaks have passing enclosing controls.
Complete logs: `/private/tmp/fwp-239-final-*.log`; metadata and merge checks:
`/private/tmp/fwp-239-final-jobs.json`, `fwp-239-merged.json` and
`fwp-239-merge-commit.json`. Detailed delivery audit:
`/private/tmp/fwp-239-delivery-handoff.md`.

## Evidence and unresolved timing goals

[The report](measurements/derivative-forward-costs.md) retains all six cases,
96 count observations and four audited timing sessions. Largest current-only
savings: 51,143 allocation requests and 76,416 effective retains; peak managed
charge falls from 25,952 to 21,888 bytes. Final managed/raw storage is zero.

The user approved retaining these reductions with all ten timing failures open:
eight one-update cases miss 5% improvement; AMD64 zero-update is 2.54% and 2.72%
slower, exceeding 2%. D2 remains open. Original reports and thresholds are unchanged.
GCC diagnostic `41337215456` reproduces all four zero-update images/outputs but
establishes no timing cause or justified repair. Do not rerun unchanged timings
or make speculative allocator changes. Source tags and retained archives are
linked from the report; they preserve evidence through squash merge.

## Next investigation and local checks

In candidate report `derivative-record-zip-counts-2026-11-01.json.gz`, source
`b094fdd8`, run `41324329567`, case `129-199-current-O2`, workspace off:
ARM64 ownership sites 458 (`f167`), 452 (`f127`) and 457 (`f164`) create
25,671, 25,472 and 25,472 flat numeric records. Their generated callback entries
box direct worker results. Resolve callers/escape boundaries before selecting a
change. Map/list construction remains another cost; not every box is removable.

Read-only extraction verifies saved `ownership-base.c` SHA-256
`b820f990003376116f544c3d638688543ad6154519da34c879444e7eb4aa700a`.
Guarded report/source reads and final target audits pass in 0.13–0.14 seconds.
The temporary target reader initially assumed explicit `--test`; it now checks
`--all-targets` against the complete repository schedule. No production repair
was needed. Keep full builds/measurements on GitHub and focused local checks under
`scripts/local-guard.py`; never bypass resource limits. Old redundant downloads
were removed only after retained source/digest and unexpired remote verification;
current evidence, logs and source worktrees remain.
The delivery/next-plan update passes the guarded roadmap check: 197 link sets,
106 preparation pairs/tags and four plan steps, 2.98 seconds. `git diff --check`
also passes. Publish these status changes with the next substantial batch.

The callback-box audit passes under the local guard: 96 observations, 48 source
hashes and both archive digests, 0.24 seconds. Post-merge documentation
`41351222111` passes. Preparation `7b300717` and immutable tag `roadmap/derivative-record-fold-protocol-2026-11-02` precede compiler edits.

Guarded formatting passes (1.88 seconds). Full builds run remotely.
