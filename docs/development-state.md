# Current work

**Next:** run the frozen paired-column timing experiment after the passing native
checks, while monitoring PR #243. Keep head `ea976b7e19c26c5be0ad9e748e284cc97a269379`
unchanged. Squash-merge only after all gates pass, with an explicit one-line subject
at most 80 characters and empty body; verify the merge message and tree.

PR: https://github.com/e6qu/fun-with-pipes/pull/243
Docs run `41411731331`, job `125166069914`, passes and its complete log is audited:
`/private/tmp/fwp-243-docs.log`. Only deliberate test-runner rejection/panic controls
appear. Production run `41412228669` has passing benchmarks and both ARM macOS
jobs; six platform jobs remain running without failed steps. Complete passing logs
are audited (`/private/tmp/fwp-243-bench.log`, `fwp-243-mac-arm-regular.log` and
`fwp-243-mac-arm-ownership.log`); the echoed ResourceWarning option is not a warning.
Draft run `41411731289` is skipped and establishes no platform support.
The published worktree is `/private/tmp/fwp-current-kernel-costs`.

This independent preparation is branch `matrix-calculation-costs`, worktree
`/private/tmp/fwp-matrix-calculation`, based on that #243 head. Do not open another
PR. Preserve measured source tags before rebasing onto #243's verified squash tree.
The previous full handoff remains at `ea976b7e:docs/development-state.md`.

## Roadmap status

| Step | Status | Evidence / remaining work |
|---|---|---|
| 1 | Verified | Protocol `5f235bb0`, tag `roadmap/matrix-calculation-protocol-2026-11-02`, published before runner edits |
| 2 | Verified | Run `41412675762` reproduces all original binaries on both architectures; complete compiler reports and logs retained |
| 3 | Verified | Paired-column diagnostic vectorizes on both GCC hosts; expanded native safety checks pass on GCC ARM64/AMD64 and Clang ARM64 |
| 4 | In progress | Timing protocol `6c7e9cea` frozen; shared runner uses explicit reference kinds and checks source equality before timing |
| 5 | Pending | Deliver coherent changes after #243; exact-head full matrix/docs and verified squash merge |

## Established facts

- #242 merged as `10b9bbff`, all nine production jobs and docs pass; tested tree
  and one-line 58-character message verified. Duplicate merge-tree CI/docs were
  cancelled after tree equality. No unresolved #242 failures remain.
- #243 measures source `b9da15a1` / `9f6d0f7c` (same compiler/runtime trees).
  Independent audit `41407524129` passes. Four ARM speed and nine AMD copy limits
  remain unmet; full data and logs are committed, not retried or hidden.
- The large-matrix calculation gap passes copy controls in both sessions: about
  65% more time than C on AMD64 and 6% more on ARM64. Effective retains are zero.
- Matrix records are outside that timer; task-free scheduler polling is already
  eliminated. Byte-copy alias safety, shared views, shape guards, arithmetic order
  and unwind cleanup are required. See the [protocol](measurements/matrix-calculation-costs.md).
- Scratch source audit: `/private/tmp/fwp-matrix-source-audit.md`. No local build,
  benchmark or timing has been run. Use the local guard for focused checks only.

## Diagnostic changes

The existing `kernel-codegen` dispatch now selects current session-2 archives,
checks their recorded SHA-256 values, and uses each executable's explicit role
path. It adds only GCC diagnostic options and requires identical binary bytes.
Compiler commands use the shared child-deadline runner. Historical dispatch
instructions identify their recorded revisions; no old-format fallback is added.

Run `41412675762` at `f4fd8be4` reproduces all eight original binaries and outputs
on each native architecture. Complete artifacts/logs are retained under
`docs/measurements/matrix-codegen-2026-11-02/`. AMD C vectorizes the matrix inner
loop but fwp does not; ARM fwp reports a required alias check while C rejects
vectorization on cost. These are compiler decisions, not a proven timing cause.
Run `41414518831` at `dce1f2b6` checks the declared restricted-input candidate.
Both native jobs pass, but every candidate binary and vectorization decision is
unchanged. Complete evidence is retained under
`docs/measurements/matrix-input-restrict-2026-11-02/`; no timing retry is justified.
Five archive/patch controls pass (0.14s), actionlint passes (6.34s).

The protocol now declares two adjacent columns per inner-loop iteration, followed
by a scalar odd-column remainder. Keep byte-copy access, the original pointers,
per-cell arithmetic order, polling and cleanup. Exposing this fixed pair might
let GCC combine independent work; compiler diagnostics must establish that first.
Protocol `9ca36c3c` and tag `roadmap/matrix-paired-column-protocol-2026-11-02`
precede implementation. The diagnostic runner now requires `matrix_variant`
(`original`, `restricted`, or `paired-columns`) and substitutes exactly the
declared loop only in fwp matrix programs. Six C/array controls remain unchanged.
Six archive/patch tests pass (0.13s); actionlint passes (5.55s); the protocol's
roadmap audit passes (3.02s).

Run `41416927586` at `15e8d0e6` passes both native jobs, with complete logs and
archives retained under `docs/measurements/matrix-paired-columns-2026-11-02/`.
Both GCC versions vectorize the paired loop with 16-byte vectors; outputs agree
and all six controls reproduce original binaries. This establishes no speedup.
The runtime now uses exactly that loop. Expanded `blocked_matrix` checks cover
partially overlapping views, NaN classification, finite/subnormal/infinite values,
order-sensitive sums and return to each case's starting live storage. Omitting
the final result release must fail that observer. Native filenames now explicitly
use `.exe`, and O2 probe binaries are retained. The source fixture also compares
raw interpretation and native arithmetic order/NaN classification.

Run `41417716203` at `a4172afd` passes all three focused native jobs and their full
logs are audited. Each host passes four tests and twelve cases in each of four
O1/O2 profiles. Full artifacts are retained under `matrix-checks-2026-11-02/`.
No unresolved focused failure remains. Tests also enforce the output-only
allocation count and detect deliberately missing normal/unwind releases.

Timing protocol `6c7e9cea`, tag `roadmap/matrix-paired-column-timing-2026-11-02`,
precedes runner changes. Matrix reference construction reverses only the declared
loop in the same compiler output. Only the two affected matrix sizes are timed;
array binaries already reproduce unchanged. The workflow requires the verified
three-host run and matching production/probe source identities. Both old and new
measurement protocols have explicit speed targets and independently audited raw
data; historical word-state evidence keeps its original rules.

Local checks: six runtime/patch controls (0.13s), eight schedule/limit controls
(0.13s), thirteen damaged-evidence controls (5.37s), Rust formatting (0.13s),
actionlint (5.43s), documentation links/identities (3.01s). No local build or timing.
Dispatch `matrix-columns`, both sessions/all hosts, with prerequisite run
`41417716203` and its full source `a4172afd`; preserve every rejected host and
failed timing/control result. Full production acceptance remains separate.
