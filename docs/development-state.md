# Current work

**Next:** dispatch `numeric-input-analysis` and `callback-owners-time` on the
published branch, with passing focused run `41548218462` as `evidence_run`.
Use `native_runner=all` and `comparison_session=both` for runtime measurements.
Audit every outcome; retain noisy or failed measurements without unchanged reruns.
[PLAN.md](../PLAN.md) tracks this grouped batch in
[draft PR #249](https://github.com/e6qu/fun-with-pipes/pull/249).
Final production gates have not started.

## Checkout and sources

- Worktree `/private/tmp/fwp-array-consumption`, branch `numeric-owner-transfers`;
  primary checkout untouched. Base: verified #248 merge `31e4e25b`.
- Focused verified source: `5af0366c0c1ad91feeb08ddbd42a035858b635e4`.
  Subsequent measurement/doc changes leave compiler, runtime, library and tests
  unchanged; both measurement workflows verify these source trees explicitly.
- Numeric protocol `9a4129be`, tag
  `roadmap/numeric-callback-input-protocol-2026-11-03`, published before code.
- Stage 1 measured source `ceecb569c6748a226ec6ddebc417dc16351490e9`, tag
  `roadmap/field-owner-emission-checks-2026-11-03`.
  [Evidence and earlier failed attempts](measurements/derivative-owner-transfers.md)
  retain their original identities and outcomes.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Preserve complete-field transfer regression coverage |
| 2 | Verified | Preserve numeric-input selection, exclusion and cleanup controls |
| 3 | In progress | Counts and exact sites verified; measure compiler time/RSS |
| 4 | Pending | Two qualified runtime sessions per architecture |
| 5 | Pending | Nine final production gates, docs and verified squash |

## Verified focused checks

Run `41548218462` passes on `5af0366c`: AMD64 job `125628947741`, ARM64
`125628948163`. Each host passes ten unit and forty native GCC/Clang checks.
Both full job logs and twenty target logs are audited, with no diagnostics.
All 400 saved native probes have verified source/image hashes, native headers
and expected outcomes: 184 ordinary returns, 216 rejected broken controls.

All 96 count observations pass exact source attribution, output/work equality,
managed/raw storage limits and zero final storage. Largest current-only solve:
77,411 → 51,939 → 995 retains across the two changes, unchanged allocations and
peak storage. No speed claim. [Retained evidence](measurements/derivative-owner-transfers.md#complete-focused-verification).

Local audit commands (guarded):

- `/private/tmp/fwp-audit-numeric-input-passing.py arm aarch64 13190063044 13189589188`
  and the AMD64 equivalent (`amd x86_64 13190771070 13189852827`): pass, 2.70s/2.66s.
- `/private/tmp/fwp-audit-numeric-passing-probes.py`: all 400 probes pass.
- `/private/tmp/fwp-retain-passing-numeric.py`: full-log audit and retention pass, 0.26s.

Draft documentation run `41548406106` passes on `5af0366c`; its complete log is
audited. The draft's production jobs are skipped and do not establish support.

## Measurement acceptance

- Compiler comparison disables numeric inputs only. Five fixed programs, two
  identical copies per variant, two warmups and ten balanced rounds. Copy medians
  must agree within 2%; candidate time and peak RSS must stay within 5% of reference.
  Peak RSS includes warmups; elapsed medians exclude them. Seven synthetic controls
  pass (0.25s), including invalid/missing samples and retained timeout evidence.
- Runtime comparison disables both owner changes, keeping packed storage enabled.
  Two sessions per architecture; fixed 2% copy/regression and 5% large-case limits.
  Host qualification happens before timing. Count reductions alone do not pass it.
- Reference reconstruction, source hashes, actual native images and all samples
  are independently audited. Reference controls, fourteen site-audit controls,
  thirteen runtime budget controls and archive/report controls pass.

## Previous delivery and open goals

[PR #248](roadmap-history.md#packed-temporary-numeric-records-pr-248) is merged as
`31e4e25b9a0494a2ce3d75a189fe1b1b7c177247`. Nine production jobs and docs passed;
the tested and merged trees match. [Gate identities](measurements/derivative-temporary-storage-2026-11-02/final-gates.json).
It saves 51,143 allocations / 4,064 peak managed bytes in the largest solve.
Large cases use 5.1–14.2% less time; AMD64 zero-update history remains 2.024% slower
(limit 2%). This and the other [open performance goals](../PLAN.md#open-performance-goals)
remain open. Do not discard their original samples or infer a safety bug from timing.

## Local resources

No local full build, suite or benchmark. Use `python3 scripts/local-guard.py`
serially. Last free disk: 65 GiB; no local target data. Keep 64 GiB free, workload
RSS below 1 GiB and the fixed 180-second deadline; move refused work to runners.
