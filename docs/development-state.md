# Current work

**Next:** publish the batched test-helper/lint-coverage repair, then monitor
its nine exact-head production jobs and documentation for ready
[PR #249](https://github.com/e6qu/fun-with-pipes/pull/249). Keep original production
run `41554814165` on `82dc81d845d1ab0d88c359aa9f1ca6f3164b5a9f` active and audit
its remaining target logs too; do not lose additional failures during repair
validation. Squash only after all repaired-head gates pass and logs are audited,
with a one-line subject ≤80 characters and empty body. Verify message/tree.

Both Linux and both regular macOS Clippy steps report only `replace_box` at
`src/cgen/field_transfers.rs:316`, inside a unit test. Repair: update the existing
box contents. The early lint workflow now includes all targets, covering library
test code it previously missed. Production source outside the test module is
byte-identical; do not rerun unchanged timings. All four diagnostic artifacts are
audited and retained in the linked measurement report.

Original benchmark job `125651000542` and docs job `125651006789` pass. Full logs
are audited, including ANSI-normalized diagnostics and expected negative controls.
Both macOS counted-ownership golden-corpus checks pass with clean logs. Other
native suites continue; no further failed step is reported yet. Local checks:
Rust formatting 1.82s, actionlint 6.81s, diagnostic/source-equality audit 0.13s.
The duplicate draft CI run `41554816431` is skipped and does not count.

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
| 3 | Verified | Counts, exact sites and compiler time/RSS pass |
| 4 | Implemented | Four sessions audited; retain failed speed/noise goals in PLAN.md |
| 5 | In progress | Nine final production gates and docs running; audit then squash |

## Verified focused checks

Run `41548218462` passes on `5af0366c`: AMD64 job `125628947741`, ARM64
`125628948163`. Each host passes ten unit and forty native GCC/Clang checks.
Both full job logs and twenty target logs are audited, with no diagnostics.
All 400 saved native probes have verified source/image hashes, native headers
and expected outcomes: 184 ordinary returns, 216 rejected broken controls.

All 96 count observations pass exact source attribution, output/work equality,
managed/raw storage limits and zero final storage. Largest current-only solve:
77,411 → 51,939 → 995 retains across the two changes, unchanged allocations and
peak storage. Runtime evidence is reported below. [Retained evidence](measurements/derivative-owner-transfers.md#complete-focused-verification).

Local audit commands (guarded):

- `/private/tmp/fwp-audit-numeric-input-passing.py arm aarch64 13190063044 13189589188`
  and the AMD64 equivalent (`amd x86_64 13190771070 13189852827`): pass, 2.70s/2.66s.
- `/private/tmp/fwp-audit-numeric-passing-probes.py`: all 400 probes pass.
- `/private/tmp/fwp-retain-passing-numeric.py`: full-log audit and retention pass, 0.26s.

Draft documentation run `41548406106` passes on `5af0366c`; its complete log is
audited. The draft's production jobs are skipped and do not establish support.

## Runtime results and acceptance

Source `d903126f53545098519a36960c5704eb3fcdc8f0`: timing runs `41550970017`
and `41551538083` are complete. Independent audit runs `41553716035` and
`41553965234` pass; both full audit logs have no diagnostics. All timing-job
failures are preserved speed/noise-limit misses. One original AMD64 host was
rejected before timing; only that session was replaced.

[Retained results](measurements/callback-owners-2026-11-03/README.md): largest
solves take 5.2–6.4% less time. Both hosts miss 5% on 3/199 and 3/1999, both forms;
AMD64 33/199 current also misses. AMD64 3/1999 current copy variation is
2.12% / 2.21% against 2%. Keep these goals open under the user's existing
instruction to retain verified reductions. No unchanged reruns or relaxed limits.

All output/work, managed/raw storage, cleanup, instruction/frame and source/image
checks pass. RSS is reported separately, including its AMD64 increase. Each
runner audit verifies 1,334 measurement files and five reference files per
session. Compact summaries/logs are checked locally; all four reports pass the
independent schedule/host/source/sample/acceptance check (0.86s guarded).

## Compiler-cost results

Run `41550965701` passes both hosts on `d903126f`. Independent audits of all 480
commands, native images, reference sources, raw samples and recalculated outcomes
pass (AMD64 2.45s, ARM64 2.30s under the local guard). Complete job logs have no
diagnostics. Maximum increases: 0.53% compilation time, 0.44% peak RSS (limits 5%);
identical-copy differences ≤0.91% (limit 2%). [Retained results](measurements/numeric-input-analysis-2026-11-03/README.md).

Documentation run `41550957926` also passes. Its only error/panic text comes from
required negative controls for duplicate/unknown targets and a synthetic failing
native test; all outcomes match their test assertions.

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
serially. Last free disk: 64.7 GiB; no local target data. Keep 64 GiB free, workload
RSS below 1 GiB and the fixed 180-second deadline; move refused work to runners.

## Next-batch preparation only

`/private/tmp/fwp-next-allocation-direction.md` records an evidence-based allocation
diagnosis to pursue after delivery. Existing counts attribute 154,952 of 156,943
allocations to the shared 24-byte `fwp_data` constructor, split between forward
recording and outside phases. Split list/record/generated callers before choosing
a transformation; existing constructor counts do not establish those identities.
No new benchmark or production change is started for that preparation.
