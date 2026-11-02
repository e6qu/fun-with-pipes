# Current work

**Next:** publish the batched numeric-input repairs and run `numeric-input-checks`,
then audit all logs and count results. Continue with independent site attribution,
compiler-cost measurements and combined timings in this same substantial batch.
[PLAN.md](../PLAN.md) is the task list; no delivery PR is open.

## Checkout and sources

- Worktree `/private/tmp/fwp-array-consumption`, branch `numeric-owner-transfers`;
  primary checkout untouched. Base: verified #248 merge `31e4e25b`.
- Published candidate `043fcc1cfc1205cb3141f2da5b10b6824f6c7c28`, immutable tag
  `roadmap/numeric-callback-input-checks-2026-11-03`.
- Numeric protocol `9a4129be`, tag
  `roadmap/numeric-callback-input-protocol-2026-11-03`, published before code.
- Stage 1 measured source `ceecb569c6748a226ec6ddebc417dc16351490e9`, tag
  `roadmap/field-owner-emission-checks-2026-11-03`; rebased source-equivalent
  checkpoint `3c838fad`, independent auditor `85a01d01`.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | Verified | Preserve complete-field transfer regression coverage |
| 2 | In progress | Two invalid test assumptions; rerun focused correctness checks |
| 3 | In progress | Independent input-site attribution and compiler time/RSS experiment |
| 4 | Pending | Two qualified runtime sessions per architecture |
| 5 | Pending | One substantial PR, nine final production gates, docs and verified squash |

## Current checks and repairs

[Run 41542603016](https://github.com/e6qu/fun-with-pipes/actions/runs/41542603016)
uses `043fcc1c`: ARM64 job `125610247675`, AMD64 `125610248078`. Both finished
with failures. Build/lint pass; each host has 46 passing checks and three failures.
All 20 target logs and both complete job logs are audited. No other warnings or
failures. [Failure details and retained evidence](measurements/derivative-owner-transfers.md#initial-numeric-input-checks).

Repairs in this checkout:

- Replace the invalid cached-function unit fixture with a named-entry exclusion.
- Keep the native nested-input callee above the ordinary inlining limit with a
  polynomial; assert its changed signature without relying on its internal name.
  Save native evidence before selection assertions.
- Move numeric rewriting out of packed lowering, without another program clone,
  so the old packed-storage comparison still disables only its own transformation.
- Exclude explicit execution entries and constant function references. Check
  numeric argument leaf types before rewriting all callers.
- Split unit steps; publish diagnostic logs before counts finish.
- Add same-source numeric comparison preparation and rejection controls. It disables
  only numeric rewriting/new packed-input eligibility, preserving stage 1.

Both initial count archives independently pass all 96 observations, manifests,
binary headers, output, storage, work and frame checks (1.94s AMD / 1.93s ARM).
Largest solve: 51,939 → 995 retains, same allocations/peak/raw storage, final zero.
These counts do not establish full correctness or elapsed-time acceptance.
Archives: `/private/tmp/fwp-numeric-input-{counts,checks}-initial-{arm,amd}.zip`.
Artifacts: ARM counts `13188011073`, checks `13187363969`; AMD counts `13187274104`,
checks `13187423422`. Full logs `/private/tmp/fwp-numeric-input-initial-{arm,amd}.log`.
Auditor `/private/tmp/fwp-audit-numeric-input-initial.py`; source evidence retained
under `docs/measurements/numeric-input-checks-2026-11-03/`.

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

Remaining: final exclusion/cleanup review; independently attribute both removed
mapper input sites; build/verify the same-source comparison; measure compiler
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

Latest repair checks: Rust formatting passes (1.94s), fixture formatting passes
(0.01s); baseline C emission confirms a surviving nested callee (0.26s). These
baseline-compiler checks do not validate the new lowering. Both reference-control suites pass (three each, 0.14s / 0.13s); workflow lint
passes (6.24s). The handoff uses the audit’s permitted status labels.

No local full build, suite or benchmark. Use `python3 scripts/local-guard.py`
serially. Last free disk: 65 GiB, no local target data. Keep 64 GiB free, workload
RSS below 1 GiB and the fixed 180-second deadline; move refused work to runners.
