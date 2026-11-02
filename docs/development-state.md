# Current work

**Next:** monitor the batched CI-repair commit for
[PR #242](https://github.com/e6qu/fun-with-pipes/pull/242). Require all nine
production jobs and documentation on that exact commit before squash merge.
All failures in run `41391756089` at `dbc71914` are diagnosed below; focused
repairs pass. Linux and Windows AMD64 still run and need their final audits.
#241 run `41385349559` is fully audited.

Worktree `/private/tmp/fwp-returned-callables`, branch `numeric-callback-lifetimes`,
base `81aed37265661c0c79e47ca7223b40be2d1fe225`. Preserve unrelated primary-checkout
edits. Preparation `e0280ee2` and pushed tag
`roadmap/numeric-callback-bindings-protocol-2026-11-02` precede compiler changes.
Keep one active PR. [Scope, proof and examples](measurements/numeric-callback-bindings.md).

## Roadmap status

| Step | Status | Evidence / remaining work |
|---|---|---|
| 1 | Verified | Saved source/IR identifies the blocked call; requirements frozen before implementation |
| 2 | Implemented | Local flat-record field reads expose direct calls; inline callbacks install caller cleanup before execution |
| 3 | Verified | Nine optimizer and 72 integration tests pass on GCC ARM64/AMD64 and Clang ARM64, including cleanup and harness repairs |
| 4 | In progress | Full production audit and final documentation have failures below; merge remains gated |

## Current failures and local repairs

- **Intel macOS process control:** job `125104480914` returned empty bytes in
  the incomplete-character test at its 0.5s deadline. That test assumed the child
  had already started and written. Output-dependent tests now wait for an explicit
  readiness file before starting the same capture deadline; a separate check
  expires before output and requires empty bytes. The deliberately slow-starting
  incomplete-character case passes. Production `process_wait.py` is unchanged.
  All eleven local controls pass (3.02s). Full Intel CI must verify the repair.
- **Failure diagnostics:** macOS/Windows now upload failed process-check logs
  immediately. Inventory uploads run only if their generation step ran, avoiding
  the missing-file warning after a skipped preflight; missing expected artifacts
  fail explicitly. Workflow validation passes.
- **Documentation:** job `125104461214` fails three record-fold reference tests.
  The exact source patch still expects the old unevaluated call expression.
  Updated patch and altered-cleanup rejection pass all three reference tests and
  nine dependent array-list evidence tests. Historical audits now read the exact
  preparation constants from the measured revision, without executing saved
  Python. Old/current and mismatched-revision controls pass (two tests, 0.25s).
  Historical reports remain unchanged.
- Earlier docs `41389582000` failed a stale collection-test count (three versus
  four after the new overflow regression). Fixed in `dbc71914`; the corrected
  count and missing-test rejection pass locally and in the current docs run.
- Five repaired caller probes now use explicit `.exe` paths. The current full
  matrix verifies those path-only changes after the focused compiler checks.

Current production jobs: Linux ARM/AMD `125104481030`/`125104481395`, regular
macOS ARM/AMD `125104481085`/`125104480914`, ownership macOS ARM/AMD
`125104480995`/`125104480808`, Windows ARM/AMD `125104481014`/`125104481048`,
benchmark `125104480950`. Benchmark, both macOS ARM64 jobs, Intel ownership and
Windows ARM64 pass; complete logs are audited. All 257 macOS shard logs per
architecture are clean, including Intel regular tests (only its earlier process
control failed). Both Windows resource/callback groups have 57 clean logs each.
Windows ARM64's remaining groups and packaging pass; its scheduler panics are
intentional controls. Linux and Windows AMD64 still run.
Logs under `/private/tmp`: `fwp-242-bench-final.log`, `fwp-242-mac-{arm,amd}-*.log`,
`fwp-242-mac-{arm,amd}-*-tests`, `fwp-242-windows-{arm,amd}-tests`,
`fwp-242-windows-arm-final.log`. Audit every completed target and warning.

## Verified focused checks

| Run / source | Results on GCC ARM64, GCC AMD64 and Clang ARM64 |
|---|---|
| `41386463046` / `8677dd0a` | Nine optimizer and 48 integration tests pass; five old caller probes fail on removed entries |
| `41388066920` / `98bb58fd` | Nine optimizer and 61 integration tests pass; three runtime probes still lack generic callback metadata |
| `41389582456` / `60971efd` | All nine optimizer and 72 integration tests pass across 16 targets, including all harness and cleanup repairs |

All three sets of completed logs were audited; no other failure or compiler
warning. Final focused jobs: Clang `125097795577`, GCC ARM `125097795774`,
GCC AMD `125097795775`; logs `/private/tmp/fwp-242-cleanup-*.log`.
Docs `41388066359` passes. Narrower `41387498848`/`41387496768` were cancelled
while queued when the broader repair replaced them; no passing gate was discarded.

## Previous delivery audit

The user merged #241 retaining measured benefits with unmet limits open. Merge
`81aed372` and PR head `45af930e` share tree `a188f53196b53797719ecbc0e89589517ab4959b`.
Its subject meets the commit rule. Docs `41375291046`/`41385359961` pass;
duplicate production `41385360274` was cancelled while queued after tree equality.
[Timing/count evidence](measurements/derivative-record-folds.md) keeps all missed
limits. Do not repeat unchanged sessions. #239 remains the verified platform baseline.

Full run `41385349559`: benchmark passes. All eight platform jobs fail only
seven known targets: caller/runtime/map/filter/zip/reuse
harness roots and collection-callback cleanup. These are repaired in #242.
Audited 255 macOS target logs and 257 Linux target logs per architecture,
plus every complete job log. Windows resource groups (55 targets each) and both
TLS/executable groups (98 targets each) show the same failures, with no warnings.
Both Windows jobs' later checks and packaging pass. TLS certificate-rejection and
scheduler panic messages are intentional controls. All jobs are complete.

Final audited jobs: Linux AMD `125084848907`, Windows AMD `125084849027`.
Other IDs: Linux ARM `125084848880`, regular macOS ARM/AMD
`125084848914`/`125084848899`, ownership macOS ARM/AMD
`125084848670`/`125084848861`, Windows ARM `125084848959`, benchmark `125084848998`.
Logs under `/private/tmp`: `fwp-241-full-{arm,amd}-logs`,
`fwp-241-linux-{arm,amd}-tests`, `fwp-241-linux-{arm,amd}-final.log`, `fwp-241-mac-*.log`,
`fwp-241-windows-{arm,amd}-logs`, `fwp-241-windows-tls-{arm,amd}`,
`fwp-241-windows-reuse-{arm,amd}`, `fwp-241-windows-{arm,amd}-final.log`.

## Reproductions and local checks

All focused commands use `python3 scripts/local-guard.py`. No local compiler build
or full suite ran. Preserve 64 GiB free, target data below 2 GiB, RSS below 1 GiB
and the 180s deadline. Full builds, suites and benchmarks stay on GitHub.

- Original IR reproduction: `FWP_DUMP_IR=1`, `FWP_STACK=0`, dynamic memory/emit-C;
  `/private/tmp/fwp-242-destructuring.fwp`, `fwp-242-baseline-ir.log`,
  `fwp-242-baseline.c` (all under `/private/tmp`); 0.25s.
- Small emitted-C controls isolate the cleanup-order bug; moving cleanup before
  inline work changes remaining storage from 16–352 bytes to zero. These establish
  cause; the focused CI above verifies the actual compiler repair. Controls and
  scripts: `/private/tmp/fwp-242-leak/`, `/private/tmp/fwp-242-*-control.py`.
- Retained #241 compiler: artifact `compiler-crashes-corpus-macos-15`, SHA-256
  `9ef9986e260c9594ea5706100a70b56b2017d6acaf52445d0b778f3e159a12c5`.
  Artifact contains the compiler only; no compiler crash was reported.
- Guarded checks pass: roadmap (2.77s), Rust formatting (1.87s), collection evidence
  (eight tests, 0.13s), process waits (ten tests, 1.87s), record-fold reference
  (three tests, 0.13s), array-list evidence (nine tests, 48.66s), workflow lint (0.26s).

Final repair checks: process waits (eleven tests, 3.02s), workflow lint (0.49s)
and roadmap audit (2.93s) pass. Compiler/runtime source is unchanged from `60971efd`.
