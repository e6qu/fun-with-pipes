# Current work

**Next:** monitor and audit PR #244's final-head production gates; docs and
bench pass. The independent array diagnostic now passes both GCC hosts. Freeze
its source-versus-driver phase timing protocol before selecting a compiler change.
Preserve #244's head unless a real CI repair is required; one active PR only.

## Active delivery

PR: https://github.com/e6qu/fun-with-pipes/pull/244
Head: `555c4981695f4819586ef0a57114a36c2c9476ef`.
Production: `41425537461`: benchmark job `125211125775` passes, eight native jobs
remain. Docs `41425537447` / `125211125800` passes. Both complete logs audited:
only deliberate documentation test-runner failure controls appear. No CI failure.
PR worktree: `/private/tmp/fwp-matrix-calculation`.
Independent preparation: `array-construction-costs`, `/private/tmp/fwp-array-construction`.
The [construction protocol](measurements/array-construction-costs.md) is frozen
before its runner; no production change or new timing is selected.

## PR #243: verified delivery

Merged `ea9938debef5cc75d53edb8ca427b49f2513bea3` after production `41412228669`
and docs `41411731331` passed on `ea976b7e19c26c5be0ad9e748e284cc97a269379`.
All nine full logs and native target archives are audited. The squash tree equals
the tested tree; the message is one line, 62 characters, without body/trailers.
Duplicate same-tree main runs `41425026087` and `41425026016` were cancelled.
[History](roadmap-history.md#current-numerical-costs-pr-243) records the delivery.

## Matrix batch

Branch/worktree: `matrix-calculation-costs`, `/private/tmp/fwp-matrix-calculation`.
Rebased onto the verified #243 squash tree. All measured sources and the failed
report-generation source have remote retention tags; preserve them.

## Roadmap status

| Step | Status | Evidence / remaining work |
|---|---|---|
| 1 | Verified | Source protocol `5f235bb0`, published before diagnostics |
| 2 | Verified | `41412675762` reproduces original binaries on both GCC architectures |
| 3 | Verified | Paired-loop diagnostic `41416927586`; safety run `41417716203` passes GCC ARM64/AMD64 and Clang ARM64 |
| 4 | Verified | All four sessions and three host rejections retained; raw audit `41422907313` passes; six timing controls remain open |
| 5 | In progress | PR #244 published; production/docs running; audit and verify squash merge |

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
  1,568→1,616 AMD64. Driver `main` stays 384 static bytes on ARM64 and a 352-byte bounded
  dynamic estimate on AMD64. Code gains 128/320 bytes.
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
  in `matrix-columns-2026-11-02/`. Full audit log is clean; source tag retained.
- Table run `41424485974` at `3ae24c0d` failed: the renderer incorrectly required
  every GCC estimate to be `static`; AMD64 driver `main` is `dynamic,bounded`.
  The repair reports the actual qualifier and checks both variants agree, retaining
  the real 48-byte worker increase. Repair run `41425270814`, job `125210262696`,
  at `fce7b3cc` passes; artifact `13132131070` supplies the regenerated README.
  Full log audited clean; no native rebuild or new timing. Docs check both sets.

Local guarded checks pass: six patch controls, eight scheduling/limit controls,
thirteen evidence controls, six retention/prerequisite controls, two table-unit
checks; Rust formatting, actionlint and roadmap audit. Historical tables verify
unchanged (7.46s). Handoff heading/status drift was repaired; documentation audit
passes (2.88s). Latest actionlint: 5.95s. No local
compiler build, full suite or benchmark. Free space was 67 GiB at the last check.

Array diagnostic preparation `afbd14dd` is retained as
`roadmap/array-construction-protocol-2026-11-02`. The runner compares 144 native
case/round/path combinations at each O1/O2 setting, ordinary and profiled, plus
small interpreter cases and deliberately missing-release controls. Six observer
unit checks pass locally (0.13s), actionlint passes (6.43s). Full compiler builds
and native diagnostics run only on GitHub. Free space: 66 GiB.

Array run `41426573182` at `f97e8520` failed on both hosts before probes:
`fwp fmt --check` rejected redundant grouping. Both full logs audited; all six
observer tests passed. The fixture is now formatted with #243's verified macOS
package (artifact `13127374308`, archive hash/source checked); small interpreter
preflights also pass. These release-package preflights are not native GCC evidence.
The runner now preserves canonical source even when formatting fails. Rerun the
focused diagnostic after this repair; no production code changed.

[Small-matrix sample analysis](measurements/matrix-sample-positions.md) retains all
four sessions and locates the copy mismatch mainly in early process samples.
It establishes no cause and changes no acceptance rule. Its guarded reduction
took 2.67s; no executable or timing was rerun.

Repaired array diagnostic `41427397530` at `d3ddc94d6eb8c5c58af74159051670241dd23e5b`
passes on AMD64 job `125217227607` / artifact `13132143987` and ARM64 job
`125217227733` / artifact `13132374453`. Complete logs audited clean; all retained
file hashes and all four ordinary/profiled outputs per host independently checked
under the guard (2.32s). Evidence: `measurements/array-construction-2026-11-02/`.
Both materialized paths allocate once; composed source already allocates zero.
Source generation retains generic callback dispatch for all-scalar captures.
Do not claim elapsed-time improvement or remove checks based only on this result.
