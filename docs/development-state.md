# Current work

**Next:** publish the completed timing/audit wiring and run `numeric-input-checks`
on both hosts. After all focused jobs pass, dispatch `numeric-input-analysis` and
`callback-owners-time` with that run as `evidence_run` (timings: `comparison_session=both`). Continue with independent site attribution,
compiler-cost measurements and combined timings in this same substantial batch.
[PLAN.md](../PLAN.md) is the task list; no delivery PR is open.

## Checkout and sources

- Worktree `/private/tmp/fwp-array-consumption`, branch `numeric-owner-transfers`;
  primary checkout untouched. Base: verified #248 merge `31e4e25b`.
- Published selection candidate `ea5deea50bd4447b3864f09f25db780bd8d37518`; prior
  `1075628e` is retained by `roadmap/numeric-input-guard-checks-2026-11-03`. Initial source
  `043fcc1c` is retained by `roadmap/numeric-callback-input-checks-2026-11-03`.
- Numeric protocol `9a4129be`, tag
  `roadmap/numeric-callback-input-protocol-2026-11-03`, published before code.
- Stage 1 measured source `ceecb569c6748a226ec6ddebc417dc16351490e9`, tag
  `roadmap/field-owner-emission-checks-2026-11-03`; rebased source-equivalent
  checkpoint `3c838fad`, independent auditor `85a01d01`.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Preserve complete-field transfer regression coverage |
| 2 | In progress | Repaired source/IR/native selection passes; complete focused checks on both hosts |
| 3 | In progress | Exact input sites audited; compiler experiment runner and controls ready |
| 4 | Pending | Workflow and audits prepared; two qualified runtime sessions per architecture |
| 5 | Pending | One substantial PR, nine final production gates, docs and verified squash |

## Current checks and repairs

Short run `41547177941`, ARM64 job `125625516487`, passes on `ea5deea5`:
ten unit controls plus the native case. The local-callee fixture now reaches the
intended numeric rewriting. All four saved GCC O1/O2 stack-off/on images return
normally and release all 1,344 allocated bytes. Complete job log, source signature,
archive digests and native headers are audited (0.13s), no diagnostics.
[Retained selection proof](measurements/derivative-owner-transfers.md#local-callee-selection-verified).


[Run 41545062127](https://github.com/e6qu/fun-with-pipes/actions/runs/41545062127)
on `1075628e` has completed: ARM64 job `125618544720`, AMD64 `125618545152`.
All nine unit controls and 38 native tests pass per host. Only the new native
fixture fails, under both GCC and Clang: its nested callee stays boxed. Both full
job logs and all 20 target logs are audited; no other diagnostics.
[Failure history and evidence](measurements/derivative-owner-transfers.md#follow-up-selection-failure).

The old top-level fixture kept a function-value boundary and was excluded. A
local callee fixes the fixture; the source-to-IR unit control and short native
probe now prove selection. The complete focused matrix still needs this fixture.

Both repaired-run count archives independently pass all 96 observations and exact
map → forwarding worker → numeric callee attribution (2.67s ARM / 2.68s AMD).
Largest solve: 51,939 → 995 retains, unchanged allocations/peak/raw storage, final
zero. These results do not settle the failed source fixture or elapsed time.
Archives `/private/tmp/fwp-numeric-input-{counts,checks}-repair-{arm,amd}.zip`;
full logs `/private/tmp/fwp-numeric-input-repair-{arm,amd}.log`.
Artifacts: ARM counts `13189336539`, checks `13188243498`; AMD counts `13187853020`,
checks `13189181407`. Auditor `/private/tmp/fwp-audit-numeric-input-repair.py`.
All evidence is retained under `docs/measurements/numeric-input-checks-2026-11-03/`.

The earlier repair separated numeric rewriting from packed lowering without
another program clone, excluded explicit execution/constant-function entries,
checked numeric leaf types, fixed the invalid cached-function fixture and saved
native probes before assertions. These controls now pass.

Measurement preparation in this checkout:

- Exact-site auditor: 14 controls pass (13.43s); both native archives audited.
- Reference preparation requires explicit `--scope numeric-inputs` (compiler
  experiment) or `--scope callback-owners` (combined runtime). Four controls pass.
- `numeric-input-analysis` builds both compilers at production O1 settings after
  matching-source safety jobs pass. Five cases, two copies each, two warmups,
  ten balanced rounds; fixed 2% copy and 5% time/RSS limits. Six synthetic controls
  include complete schedules and retained partial timeout evidence (0.26s).
- Combined runtime count/time policy is added to the existing driver; 13 budget
  controls pass (0.14s). Runtime workflow, literal-only reference reconstruction and retained-report
  auditing are wired. Twelve archive controls pass (50.79s), twelve grouped-report
  controls pass (5.90s) and three download/rejected-host controls pass (0.14s).
  Latest workflow lint passes (5.86s). Dispatch waits for passing focused jobs.

## Implementation and remaining proof

[Numeric protocol](measurements/numeric-callback-input-protocol.md) selects internal
one-argument functions with two-level records and two-to-eight numeric leaves.
All direct calls must supply pure record/field reads; whole-value uses, escaping
function values, entry points and recursion exclude selection. Iterative graph
analysis and 32/128/512-function tests bound compiler work. Lexical aggregate
aliases disappear; every caller, parameter type and numeric leaf read changes
before ownership insertion. The typed IR check follows.

Packed-map emission borrows numeric bits from still-owned input lists. A mixed
pair has at most one boxed parameter to prepare, avoiding stranded partial
preparation. Existing failure, cancellation, allocation-failure and deliberately
missing physical-release controls now cover numeric inputs too.

Remaining: finish focused exclusion/cleanup verification;
build/verify the same-source comparison; measure compiler
elapsed time/RSS under the frozen 5% limits; then paired complete-solve timings
(two sessions per host, 2% copy/regression and 5% large-case limits). Preserve all
samples and failures; do not repeat unchanged noisy timings for a pass.

## Verified stage 1 and previous delivery

[Stage 1 evidence](measurements/derivative-owner-transfers.md#first-stage-results):
run `41538264130`, AMD64 job `125595570185`, ARM64 `125595570447` pass. Every job
and target log, all 96 counts and all 40 saved native probes are audited. Largest
retains 77,411 → 51,939; unchanged storage/work and zero final storage. No speed claim.
The original index used the wrong expression tree; the repaired lazy index uses
the exact emitted body. Failed attempts remain in the linked evidence.

[PR #248](roadmap-history.md#packed-temporary-numeric-records-pr-248) is merged as
`31e4e25b9a0494a2ce3d75a189fe1b1b7c177247`. Nine jobs `41524286630` and docs
`41524286169` pass on `32aae4f79b66f5e88e9aded39d6df794439b7430`, all logs audited.
Merge tree `8213af3a5722c84c8730bad5071f24e5f6579ed3` equals the tested head.
Raw message: `Keep mapped numeric records in one temporary buffer` (51 characters,
no body/trailers). Identical-tree duplicate main runs `41539187897` / `41539188093`
are cancelled. [Gate identities](measurements/derivative-temporary-storage-2026-11-02/final-gates.json).

#248 saves 51,143 allocations / 4,064 peak managed bytes in the largest solve.
Large cases use 5.1–14.2% less time; AMD64 zero-update history remains 2.024% slower
(limit 2%). Keep this and D2 open. Original samples remain in the linked report.

## Local checks and resources

Latest repair checks: Rust formatting passes (1.92s), fixture formatting passes
(0.01s); baseline C emission confirms a surviving nested callee (0.26s). These
baseline-compiler checks do not validate the new lowering. Both reference-control suites pass (three each, 0.14s / 0.13s); workflow lint
passes (6.13s). The handoff uses the audit’s permitted status labels.

No local full build, suite or benchmark. Use `python3 scripts/local-guard.py`
serially. Last free disk: 66 GiB, no local target data. Keep 64 GiB free, workload
RSS below 1 GiB and the fixed 180-second deadline; move refused work to runners.
