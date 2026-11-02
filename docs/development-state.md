# Current work

**Next:** audit the last PR #243 gate, squash-merge its unchanged passing head,
then publish the completed matrix batch as the only active PR. Finish the matrix
stack-frame table regeneration before publishing; keep its six failed timing
controls visible. Merge only after nine final-head production jobs and docs pass.

## PR #243: final delivery

PR: https://github.com/e6qu/fun-with-pipes/pull/243
Head: `ea976b7e19c26c5be0ad9e748e284cc97a269379`; do not change it.
Worktree: `/private/tmp/fwp-current-kernel-costs`.

Production `41412228669` has eight passing jobs. Only Intel macOS regular job
`125167651319` is still packaging; its 131 target logs already pass. Docs
`41411731331`, job `125166069914`, passes and its complete log is audited.
The earlier draft run `41411731289` skipped production and is not acceptance.

Every completed job log is audited under `/private/tmp/fwp-243-*.log`.
Native archives contain 257 passing logs per Linux architecture, 131 per macOS
regular job, 126 per ownership job, and 57 logs/135 summaries per Windows native
archive. No unexpected diagnostics. Windows `sched.rs:683/696` panics are
intentional controls; echoed `-W error::ResourceWarning` is not a warning.
Read the final Intel macOS job log once complete, then merge with an explicit
one-line subject, at most 80 characters, and empty body. Verify message and tree.
Cancel only duplicate main CI/docs after proving tree equality.

## Matrix batch

Branch/worktree: `matrix-calculation-costs`, `/private/tmp/fwp-matrix-calculation`.
Its base is the preserved #243 head. Do not open another PR before #243 merges.
Rebase only commits after that base onto the verified squash tree. All measured
sources have remote retention tags; preserve them.

| Step | Status | Evidence / remaining work |
|---|---|---|
| 1 | Verified | Source protocol `5f235bb0`, published before diagnostics |
| 2 | Verified | `41412675762` reproduces original binaries on both GCC architectures |
| 3 | Verified | Paired-loop diagnostic `41416927586`; safety run `41417716203` passes GCC ARM64/AMD64 and Clang ARM64 |
| 4 | Evidence complete; six limits open | Four measured sessions and three host rejections; combined raw audit `41422907313` passes |
| 5 | Pending | Regenerate the frame table, publish one coherent PR after #243, pass full final-head gates, verify squash merge |

The runtime processes two neighboring output columns together, preserving each
cell's multiplication/addition order, byte-copy access, shared input views,
polling and cleanup. A first restricted-input candidate produced identical
binaries and was rejected without timing. The paired loop vectorizes on both GCC
hosts; twelve O1/O2 allocation/arithmetic cases and four native tests pass per
host. Missing normal/unwind releases fail their intended observers. No API change.

## Results and open limits

[Protocol and results](measurements/matrix-calculation-costs.md) and
[complete tables](measurements/matrix-columns-2026-11-02/README.md) retain:

- About 33% less calculation time on ARM64; about 31% less for large AMD64.
  Large AMD64 remains about 14% slower than C and 3.6% faster than Rust.
- Unchanged managed requests, requested bytes, peak charge and effective retains;
  zero final workload storage. Five fwp requests versus three C/Rust requests
  include two input records built by the C driver, not by source `array.generate`.
- Six small-AMD64 copy failures at 2.6–8.3%, against the unchanged 2% limit.
  Do not claim a qualified speed result for that case or rerun unchanged timings.
- The matrix worker (`f0`) gains 48 static frame bytes: 1,408→1,456 ARM64 and
  1,568→1,616 AMD64. Driver `main` stays 384/352 bytes. Code gains 128/320 bytes.
  Frame estimates and managed charge are not whole-process memory measurements.

Retain the qualified improvements under the user's earlier preference to keep
verified gains with unmet timing goals explicit. This does not turn the six noise
failures into passes or complete those goals. Full production acceptance remains
mandatory. Analyze retained small-case samples before declaring a changed timing
protocol; array-construction costs remain the next independent numerical task.

## Sources, runs and reproduction

- Timing protocol `6c7e9cea`: `roadmap/matrix-paired-column-timing-2026-11-02`.
- Native safety source `a4172afdc045d0ecb98054e068e749a84392136b`:
  `roadmap/matrix-paired-column-checks-2026-11-02`.
- Measured source `8b9827521d0546ddd7eaace299492f9bd45b7af5`:
  `roadmap/matrix-paired-column-measurements-2026-11-02`.
- Runs `41418956333` and `41420961312` supply four complete sessions.
  `41419526409` and `41420187469` supplied only rejected hosts. The selection file
  includes every run/job; rejections were EPYC 9V45, Xeon 8370C and EPYC 9V74.
- Combined audit `41422907313`, job `125202508959`, source `9f6c8d00`, passes.
  Artifact `13129819093` and all normalized reports/logs/file manifests are retained
  in `matrix-columns-2026-11-02/`. Full audit log is clean. Add/preserve its source tag.
- The report now exposes both worker and driver frames. Dispatch `matrix-tables`
  to regenerate only README from retained reports; no native rebuild or new timing.
  The documentation workflow checks both historical and new generated tables.

Local guarded checks pass: six patch controls, eight scheduling/limit controls,
thirteen evidence controls, six retention/prerequisite controls, two table-unit
checks; Rust formatting, actionlint and roadmap audit. Historical tables verify
unchanged (7.46s). Latest actionlint: 5.95s; documentation audit: 3.25s. No local
compiler build, full suite or benchmark. Free space was 67 GiB at the last check.
