# Session handoff

## Next action

Next: audit all nine production jobs plus documentation for the combined
collection PR's final head; publish the branch/PR first if it is not yet open. All six-host collection checks and binary
reports now pass. Full production acceptance is still required. Fix every encountered issue, including unrelated/pre-existing
ones; audit every failed job and completed target before pushing repairs.
Queued CI gates merging, not independent work. Never count skipped checks as
verified support. Keep one active delivery PR.

PR #165 is accepted. The current collection branch is rebased onto its verified
merge and is active in the root workspace. The measured implementation is complete. Keep the final documentation and
benchmark-evidence repair in the same PR. PR text:
`/private/tmp/fwp-collection-build-pr.md`; update verification after the full gate.

Refresh active audits serially with:
`python3 scripts/local-guard.py python3 /private/tmp/fwp-refresh-current-audits.py`.
The direct-call run is `39100652902`, exact source
`c34ca8e340c6f3dbb6251729553e1a8dbf513903`, preserved as
`evidence/collection-direct-sets-20261018`. All six jobs pass: 78 tests, no failures/skips and every measurement completed.
Complete audit: `/private/tmp/fwp166-collection-direct-audit.json`. Binary report
`39101368649` passes from that tag with `evidence_run=39100652902` and
`source_revision=c34ca8e340c6f3dbb6251729553e1a8dbf513903`.
Audit it with `/private/tmp/fwp-audit-collection-direct-report.py`.
The report inspects saved binaries as data on GitHub; downloaded binaries are
never executed. Data-only report/disassembly: `/private/tmp/fwp-collection-report-direct`.
The final report and exact Linux loop/frame excerpts are recorded in
`docs/measurements/collection-build-direct-2026-10-18.json` and
`docs/measurements/collection-set-code-2026-10-18.json`.

## Accepted delivery

[PR #165](https://github.com/e6qu/fun-with-pipes/pull/165) merged as
`695907781c5efff02e0f202f8b7fa99283df5ef4`, after all nine production jobs
`39094927776` and documentation `39094927727` passed for
`836f39b30079ec52f56b41d81baf468e8384a71b`. All 964 scheduled targets completed:
1,264 summaries, 3,652 passed, no failures, 72 ignored. Merge/tree/sole parent and
the entire one-line message were verified; duplicate production `39101178854`
is confirmed cancelled. Record: `/private/tmp/fwp165-merge-record.json`.

[History](roadmap-history.md#owned-c-results-and-failure-cleanup-pr-165) preserves
C-result ownership, failure cleanup, the 90/66/52 focused checks, original failures
and measurement limits. Its original nine-job run is fully audited: all scheduled
targets completed, 3,620 passed and six known Windows failures, now fixed. Completed
historical runs are evidence, not pending work. Full prior local detail remains in
`/private/tmp/fwp165-handoff-before-streamline.md` and
`/private/tmp/fwp-handoff-before-collection-delivery.md`.

## Workspaces and source identity

- Root branch: `collection-build-storage`, based on accepted PR #165.
  Preparation was rebased to `8a69c2313053717ee80b19f6f2e1a74fe1c15b6f`
  before the final documentation and benchmark-evidence changes.
- The rebase's old remote head is `30620ce5d0843547dde240ff9b3f3b09ee6f1dda`.
  Its first publication uses an explicit lease for that head. Publication records
  and the live PR identify the resulting final head; do not reset to a preparation
  commit. `/private/tmp/fwp166-rebase-record.json` verifies the identical
  pre/post-rebase tree `336d51f172804e650aad1bafe74b8492eb84515e`.
  Never relabel measurements after rebasing.
- `/private/tmp/fwp-collection-build-storage` is detached at the rebased head and
  inactive. Work in the root now; its handoff is authoritative.
- Shared `target/debug/fwp` contains the measured direct-set implementation.
  No compiler/runtime change occurred during the rebase or documentation update.
  Full builds, suites, benchmarks and large report generation stay on GitHub.

## Current collection work

Numeric `map` followed by map/set construction writes directly into protected
buffers. Immediate I64 ranges avoid their input list. Known map callbacks return
numeric fields without tuples; known set callbacks use their existing owned
function entry instead of general dispatch. Dynamic map callbacks can still box
results; captured managed values can still require counts. Sets use two temporary
key arrays, including ordinary managed-key construction. First-key identity,
last-map-value behavior, callback/capture order, aliases, errors and cancellation
remain checked. Final sets still have unused value slots; small scalars still
occupy words and peak temporary storage still grows with input length.

| Stage | Exact source | Evidence |
|---|---|---|
| Initial repaired optimization | `488d182203605870ab34d5f431c62f5d58a2a7b1` | `39098119495`: six hosts, 78 passed, no failures/skips; report `39098876424` passes |
| Remove unused set buffers | `8fcd7486881c627f078d8bff7ad6e6c82f040734` | `39100058501`: six hosts, 78 passed, no failures/skips; report `39100710058` passes |
| Direct known-set callbacks | `c34ca8e340c6f3dbb6251729553e1a8dbf513903` | `39100652902`: six hosts, 78 passed, no failures/skips; report `39101368649` passes |

The first two sources are preserved by `evidence/collection-build-20261018`
and `evidence/collection-set-storage-20261018`; the direct source has its own tag
above. Each passing report verifies all four named test targets, 13 tests per
host, 120 actual binaries, raw timings, counters, source hashes and leak controls.
Downloaded data-only reports are `/private/tmp/fwp-collection-report-baseline`
and `/private/tmp/fwp-collection-report-sets`. Published reports and measurement
limits are linked from [benchmarks](benchmarks.md#building-numeric-maps-and-sets-without-temporary-lists).

At 65,536 inputs, sets now use four allocation requests and peak at 1,053,712
counted bytes on every host, versus six requests and 2,102,304 bytes before
removing the value buffers. Ordinary construction uses 131,077 requests.
Maps use seven versus 196,616 ordinary requests. All measured cases have zero
retains, final counted bytes and collections. These are managed-storage counts,
not process RSS. Same-run set timing ratios for the buffer change range from
0.514 to 0.858 at this size. Different-run absolute times do not isolate a code
change; tiny-input samples overlap. No C/Rust parity claim follows.

The original source `cf2fb20c1cf3326187b998789bc31990cfcbcf65`, run `39096618831`,
has a complete audit: 62 passed, 16 failed, no ignored tests. Three AMD64 fixtures
assumed an arithmetic NaN sign; explicit parsed NaNs now preserve the intended
bit/order checks. Windows ARM64's forbidden toolchain download allowed all 13
tests to continue with MSVC Clang. Authenticated, checksum-verified downloads and
successful-setup conditions fix that cause, including sibling workflows. All
original traces remain in `/private/tmp/fwp166-collection-build-*`; passing repair
uses separate `fwp166-collection-repair-*`, set storage uses `collection-sets-*`,
and direct calls use `collection-direct-*`. No failure was hidden or relabeled.

## Local verification and publication requirements

Use `python3 scripts/local-guard.py COMMAND...`, serially and with its unchanged
limits. Never use the fun-refactor guard here or raise the resource limits.

- Set buffers: eight collection/map tests pass after the final sort-copy guard
  (76.84 s), with all 50 collection failure points, 48 callback exits and 106/108
  managed-map failures per configuration. Tiny/tooling checks pass (18.88 s).
- Direct sets: formatting, Clippy and all three collection tests pass (56.97 s),
  including raw/native agreement, dynamic callbacks, managed captures, aliases,
  all 56 allocation failures and 64 callback exits across eight actual builders.
  ARC, stressed tracing, reuse and deliberately missing cleanup are covered.
- Direct tiny probes, focused linting, workflow/docs and report checks pass
  (12.80 s). Four set/seven map allocations remain, with zero retains/final bytes/
  collections; data is separate in `/private/tmp/fwp-collection-direct-set-prototype`.
- Documentation/evidence checks pass (2.91 s) before rebase. The report checker
  requires each target and rejects incomplete/interleaved bad logs; three Python
  regressions pass. The measurement driver now checks direct-call markers for
  both sets and maps. Updated acceptance/history/plan checks also pass (2.64 s guarded).

Actual set-loop inspection confirms no per-item calls or stack accesses: four-item
SIMD on Linux AMD64, two-item scalar code on ARM64. AMD64 entry frames remain
216 bytes; ARM64 grows from 256 to 272, while the extra 120/144-byte generic
builder frame leaves this known-call path. Both binaries shrink 32 bytes.
These are scoped observations, not whole-program stack bounds. Direct-set data
recording passes (0.14 s guarded); all 32-input timing sample ranges overlap,
including apparent slowdowns (checked separately, 0.15 s). Baseline map loops already
have no per-item calls/stack accesses; the saved report records exact instructions,
frames and hashes without claiming all functions behave the same way.

The C/Rust benchmark deleted its measured executables after timing. The current
repair retains executables, source inputs and separately emitted C under
`target/bench-evidence/<source>/<invocation>`, with the matching report. Both
benchmark workflows upload them; production also retains partial evidence on
failure. Executable suffixes are explicit for each OS. Formatting, focused Clippy,
workflow/docs checks pass (12.47 s; final source-separated version 6.13 s).
Final preflight passes (6.89 s guarded). Full benchmark execution and artifact
contents require the forthcoming CI gate.

Create one substantial PR with the complete reports and wait for all
nine exact-head production jobs plus documentation. Audit all failures, fix their
causes, and rerun affected gates. Standing authorization covers publication and
squash merge after acceptance. Every commit message is one line, at most 80
characters, with no body, trailers or attribution. Supply an explicit squash
subject and empty body; verify the whole message, parent and tested/merged tree.
Cancel duplicate post-merge production only after those checks.

## Roadmap status

| Step | Status | Remaining focus |
|---|---|---|
| 1 | In progress | Host/result owners, partial cleanup, retained callbacks and tracing removal |
| 2 | In progress | Functional intermediates, input copies and unnecessary counts |
| 3 | In progress | Equivalent-work C/Rust gaps, register/cache use and code costs |
| 4 | In progress | Differentiation precision, speed and memory scaling |
| 5 | In progress | CPU kernels and GPU resource ownership |
| 6 | In progress | Dependable repeated performance comparisons |
| 7 | In progress | Larger representative applications and real browser execution |

All seven [plan](../PLAN.md) areas remain open. JIT is excluded, not deferred.
A passing delivery does not complete ownership, GC removal or performance goals.
