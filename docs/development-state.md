# Current work

**Next:** validate the compiler-report repair, compiler-growth inputs and HTTP
driver/API on GitHub before dispatching the frozen timing sessions. Finish
allocation/slow-client load evidence in this same substantial milestone 5 batch.

Worktree: `.worktrees/application-milestone`, branch `application-tooling-costs`.
It is rebased onto merged #273, `8887114f6ad3be3cd42d37b976ec208e27e4a5a2`.
There is no open milestone 5 PR yet. Preserve unrelated root-worktree changes.

## Verified delivery

[PR #273](https://github.com/e6qu/fun-with-pipes/pull/273) is merged. All nine
production jobs, documentation and the complete-log audit pass at
`0f3c0b94a1afa5b1e2c9b12435a2905532b0d072`:

- Production `42689448177`, attempt 1; documentation `42689448429`, job `129404997478`.
- Full audit `42704685230`, job `129458290946`, artifact `13712907583`.
- The [retained archive](measurements/ownership-peer-final-gates-2026-11-09/README.md)
  verifies all ten reports, source IDs, logs and artifact digests. No unresolved
  diagnostics. Verified source tag: `roadmap/ownership-peer-delivery-2026-11-09`.
- Squash commit message: `Measure ownership costs and fix consuming entry cleanup`.
  Exactly one line, under 80 characters, no body or trailers. Its tree matches
  the tested head. Do not rerun unchanged comparison timings for qualification.

## Roadmap status

| Step | Status | Delivered | Remaining |
|---|---|---|---|
| 1 | In progress | #270 documentation refresh and fresh F64 stores | Original AMD timing acceptance |
| 2 | In progress | #271 captured maps and empty-owner transfer | Original noisy timing acceptance |
| 3 | In progress | #272 structured gradients and known callbacks; all delivery gates | Original AMD timing acceptance |
| 4 | Verified | #273 ownership/peer comparisons, parser cleanup repair, all delivery gates | No remaining delivery gate; recorded measurement limits still apply |
| 5 | In progress | Application workflows and repairs verified on Linux; phase reporting implemented | Verify phases, measure scaling and sustained HTTP load, final delivery |

The [application/compiler/load plan](measurements/application-tooling.md) fixes
inputs and measurement scopes. No compiler-phase timings or sustained-load
results exist yet. Callback-service measurements still show 18.65–20.23× C time
and 5.12–6.70× Swift time; attribute payload/queue/effect/channel costs before
choosing a shared optimization. A 16-byte weak-lookup result alone does not
explain the complete service gap.

## Application verification and compiler reporting

Both focused application jobs pass at `cafc157a0076bec270324b9c2c116f5fc376f889`:
run `42707776942`, AMD64 `129469070584`, ARM64 `129469070814`. Documentation
`42707378584`, job `129467642425`, passes at preceding `fb8cd156` (the only
subsequent change grants artifact-read permission). The [receipt](measurements/application-workflows-2026-11-09/README.md)
retains complete logs, source identities, object summaries and original failures.
All three SDK applications and eight integer-output tests pass on both hosts;
AMD64 browser checks pass. No unresolved diagnostic. Original O3 diagnostics in
the ARM audit step are explicitly from the earlier source, not new failures.

Compiler reporting is implemented, not yet natively verified. Explicit
`fwp build --profile-compile new-report.json` records nested actual worker phases,
separates bundled parsing/debug ownership verification and external C compilation,
and reports inclusive/exclusive time and counts. It refuses existing report files
and build-output collisions. Tests require identical generated C, native results,
error diagnostics and consistent macro phase accounting. The focused workflow
now runs these contracts and Clippy independently alongside application checks.
The [pipeline guide](compiler-pipeline.md#observe-compiler-phases) explains scopes.

Earlier observer source `5f8dd5a881821a4471d176e8347681a630289079` and growth
source `a51a837f268feccbfaa366749868e83aab6e50e6` remain in branch ancestry.
Their runs `42711448460`, `42711453469` and `42712222725` never acquired a runner;
replace these queued runs with the combined report repair and HTTP harness.
Record the replacement run IDs after dispatch; no native result exists yet.

The compiler-growth runner now prepares all 12 family/size cases, compares
ordinary/observed C and native outputs, and checks early/late type errors with
source locations. Its accounting controls pass locally (three tests, including
six deliberately broken reports). `compiler-scaling-checks` runs release-compiler
correctness on both Linux hosts; `compiler-scaling` runs two timing sessions per
host only after those checks pass. Measurement scopes are fixed in the protocol.

HTTP load driver/reader/workflow are implemented, with explicit CPU placement,
per-attempt records and exact response dictionaries, deadline/error/late counts,
CPU/RSS sampling and a separate soak. Local reader controls pass, including
lossless compressed receipts; the tiny standalone Rust framing test passes at O2
with warnings as errors (0.22s sampled CPU). No local fwp build or load ran.
Native driver success/wrong/partial/timeout controls and a short actual-API check
precede sustained timing; existing physical cleanup/cancellation tests run separately.
Allocation traffic is now implemented in the existing physical heap observer:
count each slot charge once, retain eight cohort snapshots plus shutdown, and
compare charged minus reclaimed bytes with the live heap. A separate item-only
cohort checks 344 correct `/items/42` responses; incomplete POSTs and cancellation
remain explicit separate controls. A disabled counter must fail at its second
checkpoint. These new O2 checks are wired independently into `http-load-checks`.
Native allocation verification and slow-client/backpressure evidence remain.

Review found and fixed report creation altering a missing import: delay creating
the report until compilation finishes, protect root/auxiliary output paths, and
require identical absent-import errors. New native verification is pending.
No compiler scaling or sustained HTTP measurements have run. Full builds and
measurements remain on runners.
No final milestone 5 production matrix has run yet.

## Local verification and resources

Use `python3 scripts/local-guard.py` serially. Python syntax, actionlint, Rust
formatting and 437 documentation link sets pass, including the new delivery
receipt; all 106 immutable anchors and five roadmap rows pass. One historical evidence session passes
all eight controls. The final #273 archive matches its 1,173,657-byte size and
SHA-256, and all ten reports pass verification.

The bounded AMD64 artifact stream hit the 180-second deadline; it was stopped.
The repair workflow reads those previous diagnostics on a runner instead.
No local compiler build, full suite or benchmark ran. Full/native checks remain
on GitHub. Preserve 64 GiB free disk, 2 GiB target data, 1 GiB workload RSS and the
180-second deadline. The numerical dispatcher is 502,964 bytes; keep it below
512,000. Record any guard refusal and move the affected work to runners.
