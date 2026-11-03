# Current work

**Next:** publish the audited unit/workflow repairs and completed scalar-buffer
measurement tooling, then run `scalar-map-zip-checks` on the new head. Require
both native jobs to pass before dispatching compiler/runtime comparisons.
Keep the batch in draft PR #250; timing and final production gates remain open.

## Checkout and sources

- Worktree `/private/tmp/fwp-array-consumption`, branch `temporary-list-storage`.
  The primary checkout is untouched.
- Base: verified PR #249 squash `46af240b8c540746b942b687b416cd52f6a91f9e`.
  Tested source `6ca3c41106d78f8251d3d59e3750470a3c270f68`, tag
  `roadmap/callback-owner-final-2026-11-03`; identical tree
  `ce8dab3adb4fca4643cd600286233ebf11d884bc`.
- Verified census source `c8e8a17ad7a68ef3235be4e5de59167589c55d4b`, run
  `41573569217`; production sources equal the verified #249 tree.
- Selected storage implementation: `6f4cd46b2623cdbddd7419d18f44a66898891272`.
  [First native attempt and complete audit](measurements/temporary-list-storage-2026-11-03/README.md).
- Protocol anchors: `roadmap/temporary-list-protocol-2026-11-03` and
  `roadmap/scalar-map-zip-protocol-2026-11-03`.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Preserve attributed constructor census |
| 2 | Verified | Selected storage contract and tested same-source reference |
| 3 | In progress | Repair unit compilation and workflow failure reporting; rerun grouped checks |
| 4 | Pending | Compiler/runtime measurements, final platform gates and verified squash |

## What the first native run establishes

Run `41576241072`, ARM64 job `125720292199`, AMD64 `125720292215`:

- Production compiler builds; 23 GCC and 10 Clang integration tests pass per host.
- All 96 allocation observations match exact predictions, output and derivative
  work. Each host has 118 clean C compilation logs and passing observer controls.
- Largest current-only solve: 156,943 → 131,073 allocation requests;
  5,382,142 → 4,559,078 requested bytes. Retains stay 995; peak managed bytes stay
  17,824; final storage is zero. History saves the same requests/bytes.
- Both jobs fail all-target lint because the new unit test calls an out-of-scope
  helper. Both unit-test invocations fail too, hidden by `tee` exit handling.
  No passing unit-test claim is supported by this attempt.
- Full logs and every completed target are audited. No additional compiler
  diagnostic remains unexplained. Docs job `125720204926` passes; its deliberate
  failing-runner controls are expected. Raw evidence and failures are retained.

Prepared repairs use `reachable_functions(&program, &[0])` and explicit Bash
pipeline failure checks. Both unit groups still run and retain their logs.
Three older numeric-owner pipeline steps receive the same reporting repair.
No production compiler behavior changes in this repair batch.

## Performance comparison ready to run

[The fixed execution](measurements/temporary-list-storage.md#execution-of-the-frozen-comparison)
uses the same-source reference with only `scalar_map_zip::lower` disabled.
Both builds retain packed-record storage and numeric callback improvements.

- `scalar-map-zip-analysis`: both native hosts, five programs, 240 balanced
  compiler commands per host; 2% identical-copy, 5% elapsed/RSS limits.
- `scalar-map-zip-time`: explicit native host and session selection; two sessions
  per architecture, all six inputs, 98 samples. Qualified Neoverse N2/EPYC 7763
  hosts only. Supply the passing correctness run as `evidence_run`.
- `scalar-map-zip-report`: independently audit retained outputs, samples,
  source/reference identities, native images and storage. Preserve every failure.
- Runtime budgets require exact allocation savings and unchanged retains, no
  managed peak growth, zero final storage, unchanged raw work, 2% copy/regression
  limits and 5% improvement for 199+ updates. Code size is reported; frames may
  grow by at most 128 bytes. Prior PLAN.md timing failures remain open.

The workflows require two passing correctness jobs with matching compiler,
runtime, library and test sources. Do not dispatch timing before that check can
pass. After measurements and repairs, require nine exact-head production jobs
plus docs, audit every log, then squash with one line ≤80 characters and no body
or trailers. Verify the squash message and tested-tree equality.

## Local verification and retained files

All local checks used `scripts/local-guard.py`; no local build or benchmark:

- Reference isolation: scalar (3), numeric (4); observer/exact savings (15).
- Measurement controls: compiler (7, 0.62s), runtime budgets (14, 0.14s),
  grouped evidence (12, 6.01s), retained downloads/hosts (3, 0.13s),
  independent archives/reference patches (13, 50.58s).
- Rust formatting (1.91s), workflow lint (5.59s), roadmap (3.03s), primitive
  inventory (394 declarations, 384 symbols, no unreviewed symbols; 1.23s).
- Native archive/log audit (0.13s); 320 image headers, 32 scalar unwind statuses
  and all integration results (0.73s); all 96 exact count differences and clean
  compilation logs (0.50s). An audit helper first assumed plain numeric statuses;
  the harness stores `Some(code)`. The corrected audit passes.

Raw archives: `/private/tmp/fwp-250-scalar-first-{arm,amd}.zip` (controls),
`/private/tmp/fwp-250-scalar-counts-{arm,amd}.zip` (counts). Full job logs use
`fwp-250-scalar-first-{arm,amd,docs}.log`. Auditors are
`/private/tmp/fwp-{audit-scalar-controls,retain-scalar-controls,audit-scalar-counts}.py`.
The earlier census archives and audit remain under `/private/tmp/fwp-census-*`.

Preserve 64 GiB free disk, target data below 2 GiB, workload RSS below 1 GiB and
the 180-second guard deadline. Move refused work to runners; never raise limits.
