# Session handoff

All seven areas of [PLAN.md](../PLAN.md) remain open. Remove tracing; prefer
ownership, borrowing and moves; reserve ARC for necessary sharing. JIT is excluded.
Keep one delivery PR and require exact-source checks before squash merge.

## Current delivery

[PR #198](https://github.com/e6qu/fun-with-pipes/pull/198) is accepted and merged as
`27a3e009b83e28f06130a5d686a3196b9934e53f`; its nine production jobs, docs and binary
inspection passed. [History](roadmap-history.md#local-callback-captures-and-repeated-numerical-work-pr-198)
records the results and remaining numerical performance gaps.

[PR #199](https://github.com/e6qu/fun-with-pipes/pull/199) is the only open delivery.
Published source: `5f3e7e537f730eb748932f2d86a9fad629a83342`, branch
`checked-native-default`, worktree `/private/tmp/fwp-checked-native-default`.
Focused run `39916787104` passed 60 integration tests across fifteen targets,
179 library tests, compiler/lint checks and independent ownership/coverage audits.
Its complete log has no unexpected errors. Inspection passed fifteen GCC binaries
and sixty allocator observations. Production run `39918185432` is still running;
benchmarks and documentation `39916776571` passed, with complete logs audited.
No remaining job has reported a failure at the last check.

**Do not merge that source.** Additional repeated checks found cleanup defects in
five overflow-test fixtures. These are test defects, not a product-runtime leak.
`knownUnresolved` in `/private/tmp/fwp-default-ownership-publication.json` prevents
acceptance until the repair is published and verified.

The grouped repair is prepared in `/private/tmp/fwp-post-default-ownership`, branch
`post-default-ownership`, based on `5f3e7e53`. It belongs in PR #199. The primary
checkout remains detached at #198 and holds the live copy of this handoff.
The older `/private/tmp/fwp-arc-metadata-cleanup` worktree is clean at `3321091d`;
it is retained evidence, not another task or delivery.

**Next:** audit all completed/failed production jobs with
`/private/tmp/fwp-audit-199-final.py`, commit the grouped repair, fast-forward the
delivery branch, mark the PR draft and push with a new immutable revision tag.
Cancel the superseded run only after replacement publication; audit all its final
logs. Run the expanded twenty-target focused suite before marking the PR ready
for nine full production jobs and docs. Inspect actual binaries on all six native
platforms. Squash-merge only after every final-source gate and inspection passes:
one-line subject, at most 80 characters, empty body, no trailers or attribution.
Verify tree, sole parent and message, then continue PLAN.md. No permission question
is pending and no automatic merge is queued.

## Scope and repair

Native commands, builds, modules and compiler APIs select checked ARC by default.
Unproved ownership remains a compile error. Explicit tracing remains available;
this does not complete GC removal. Python disassembly requires an explicit
ownership mode. Collector tests request tracing; ordinary native tests compare
ARC, interpreter and saved output. Independent CI checks continue after failures.

Static-heap pressure now forces a full collection and rechecks freed small slots
before exhaustion, retaining the original 1 MiB tests and broken-repair controls.
ARC excludes unused mark storage, age checks, collector stack discovery and late
poisoning of released objects, arrays, files and sockets. Page metadata falls from
4,648 to 4,128 bytes; counts remain 4,096 bytes. [The report](measurements/arc-metadata.md)
explains this layout result; no timing or process-memory gain is claimed.

The new [record checks](measurements/record-cleanup.md) run updates, copies and
field conversions directly in ARC and tracing. They repeat 32 rounds and check
ARC byte balance, no wide-count entries and no collections. Deliberately missing
releases fail. The old overflow fixtures reset auxiliary counts to one but left
inline marker 255, so freeing did nothing: one round retained 64 bytes and four
entries. All five occurrences now restore the fixture's actual sole owner with
`fwp_rc_fresh`, clearing the artificial metadata. Related variant/retain fixtures
also detect deliberately restored old cleanup. Runtime ownership rules are unchanged.

The same patch fixes stale acceptance notes for C callbacks, manual pointers,
REST/MCP, task storage and integer range sets. It corrects the primitive guide's
outdated claim that ASCII case conversion never reuses unique storage. Verified
history replaces stale links to an active handoff; existing limitations remain.

## Verification and evidence

All local checks use `python3 scripts/local-guard.py COMMAND...`, serially.
Full compiler builds, suites and measurements stay on GitHub. Local C checks use
accepted compiler #197 with the exact current runtime substituted into emitted C;
they do not establish new-compiler or other-platform acceptance.

- `/private/tmp/fwp-check-record-rounds.py`: eighteen inspected ARM64 binaries,
  twenty-four observations at O1/O2 pass (11.28 seconds). Results:
  `/private/tmp/fwp-record-rounds/results.json`.
- `/private/tmp/fwp-check-wide-fixtures.py`: eight C binaries/twelve observations
  pass, including restored old-cleanup controls (5.42 seconds). Results:
  `/private/tmp/fwp-wide-fixtures/results.json`.
- `/private/tmp/fwp-check-record-proof-links.py`: all five current C fixtures and
  inputs match that saved evidence (0.13 seconds); Rust orchestration awaits CI.
- `/private/tmp/fwp-check-record-docs.py`: formatting, whitespace, 108 doc link
  sets, 106 immutable anchors, seven roadmap rows and thirteen native-runner
  coverage/failure controls pass (10.45 seconds).
- Original fixture-leak reproduction: `/private/tmp/fwp-record-fixture-leak.json`.
- Current-source focused acceptance: `/private/tmp/fwp-probe-repair-focused-acceptance.json`.
  GCC inspection: `/private/tmp/fwp-default-ownership-evidence/5f3e7e537f73/ubuntu-latest-39916787104.json`.
  These verify `5f3e7e53`, not the newer prepared test repair.
- Earlier runtime layout/resource checks: twelve ARM64 binaries/sixty observations;
  the actual old runtime reproduces all four late-option defects in six binaries/
  thirty observations. Receipts: `/private/tmp/fwp-arc-metadata-{fixture,negative}/`.
  Array/task corpus samples also pass: `/private/tmp/fwp-late-corpus-samples/`.

The twenty-target focused selection includes all five affected overflow tests.
`tests/support/record_probe.rs` saves C, executables, output and status under
`record-ownership/`. Existing evidence saves three default builds and twelve
allocator probes/sixty observations per host. On macOS, record update/conversion
and variant probes are in the regular artifact; general record copy and retain
probes are in the GC artifact. Both artifacts are needed for complete inspection.

## Resume tools and limits

Archive publication/acceptance receipts when changing sources. Completed publish,
dispatch and ready helpers must not be rerun. Prepare new helpers for the new tag
and all twenty focused targets. `/private/tmp/fwp-discover-199-runs.py` registers
full runs only after readiness; `/private/tmp/fwp-audit-199-final.py` audits them.

Extend `/private/tmp/fwp-inspect-default-builds.py` and `/private/tmp/fwp-merge-199.py`
to require the saved record probes as well as default/allocator images. Windows
still uses stack-bound APIs for contexts/static storage: inspect collector startup
at O0 instead of banning the import globally. The ARM64 import resolver in
`/private/tmp/fwp_pe_startup.py` has passed old-binary controls.
`/private/tmp/fwp-after-merge-199.py` is prepared but UNRUN: after a verified merge
it preserves the primary handoff, moves the detached checkout and cancels only
redundant same-tree main production CI, keeping documentation.

Preserve worktrees and evidence. Keep at least 64 GiB free disk, generated target
data below 2 GiB, sampled workload RSS below 1 GiB and the 180-second guard limit.
Never raise limits or bypass the guard. No new optimization has been selected.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing and limit ARC at remaining boundaries |
| 2 | In progress | Extend borrowing and remove functional overhead |
| 3 | In progress | Meet measured machine-level time and memory budgets |
| 4 | In progress | Improve differentiation speed, memory and precision |
| 5 | In progress | Validate CPU numerical kernels |
| 6 | In progress | Stabilize comparisons and set workload budgets |
| 7 | In progress | Complete the application acceptance suite |
