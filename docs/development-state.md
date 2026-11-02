# Current work

**Next:** verify the five repaired caller-ownership probes on native GCC/Clang,
then prepare the final full matrix for [PR #242](https://github.com/e6qu/fun-with-pipes/pull/242).
Also audit #241 production `41385349559` as its remaining jobs finish.
The [prepared scope](measurements/numeric-callback-bindings.md) remains unchanged.

Worktree `/private/tmp/fwp-returned-callables`, branch `numeric-callback-lifetimes`,
base `81aed37265661c0c79e47ca7223b40be2d1fe225`. Preserve unrelated primary-checkout
edits. Preparation `e0280ee2` and its pushed protocol tag precede compiler changes.
Keep one active PR for this batch.

## Roadmap status

| Step | Status | Evidence / remaining work |
|---|---|---|
| 1 | Verified | Saved C and reproduced IR identify an application outside numeric field bindings; local proof and checks documented before code edits |
| 2 | Implemented | `Opt::apply` accepts proved local flat-record reads; global purity and constructor-stage pass unchanged |
| 3 | In progress | Boundary and escaping-stage unit controls, tuple/named-record allocation/unwind probes and first-stage trap fixture added; new native checks pass on GCC/Clang; five older harnesses need explicit export roots |
| 4 | In progress | #241 full matrix running; next batch needs its own final exact-head matrix and documentation |

## Baseline delivery and CI

The user merged #241 after the retention choice was presented, directing continued
work. Treat that as retaining the benefits with unmet limits open, not as passing
the original thresholds. Merge `81aed372` and PR head `45af930e` share tree
`a188f53196b53797719ecbc0e89589517ab4959b`; the squash subject meets the one-line,
80-character/no-trailer rule. Documentation `41375291046` passes; log
`/private/tmp/fwp-241-docs-final.log` has only deliberate runner-control failures.

Full run `41385349559`: benchmark passes; eight jobs still run, no reported failed step yet:
Linux ARM/AMD `125084848880`/`125084848907`, regular macOS ARM/AMD
`125084848914`/`125084848899`, ownership macOS ARM/AMD
`125084848670`/`125084848861`, Windows ARM/AMD `125084848959`/`125084849027`,
benchmark `125084848998`. Audit every completed target and warning.
Duplicate merge run `41385360274` was cancelled while queued after verifying tree
identity and no failed jobs. Post-merge docs `41385359961` passes.

#241's focused suite `41372899452` passes all 39 tests on each of Linux ARM64/AMD64
and macOS ARM64. [The report](measurements/derivative-record-folds.md) retains both
count audits and all four timing sessions, including 16 missed speed limits,
one noisy AMD64 case and 15 ARM64 single-solve size failures. No count/timing
rerun is needed for this next investigation. #239 remains the last fully verified
platform baseline until the running matrix completes.

## Source investigation

Saved C `/private/tmp/fwp-241-failed-values.c` contains `destructured-step` with
arity two but a boxed result: its worker calls a known partial function through
numeric field bindings, then applies the returned value. The retained verified
#239 compiler reproduces:
`Apply(Let(Field, Let(Field, Apply(Func, captures))), argument)`.

Reproduction used `FWP_DUMP_IR=1`, `FWP_STACK=0`, explicit dynamic memory/emit-C;
input `/private/tmp/fwp-242-destructuring.fwp`, IR
`/private/tmp/fwp-242-baseline-ir.log`, C `/private/tmp/fwp-242-baseline.c`.
Guarded command completed in 0.25s. This is compiler IR/source inspection, not a
machine-code inference. Do not globally flatten constructors: that could retain
an escaping record longer. Preserve the field bindings at their original point.

## Local verification

All focused commands use `python3 scripts/local-guard.py`, serially; full builds,
suites and measurements run on GitHub. No local compiler build or native suite.
Keep 64 GiB free disk, target data under 2 GiB, RSS under 1 GiB and the 180s guard.
Retained baseline compiler: `/private/tmp/fwp-240-baseline-macos/fwp-macos-arm64/fwp`.
Its identity and earlier validation are recorded in #241's history and reports.

Candidate verification so far:

- Rust formatting passes (1.93s), workflow lint passes (4.94s), roadmap audit
  passes (3.15s; 199 link sets, 106 preparation pairs, four steps).
- Named-record fixtures type-check (0.35s). The first spelling incorrectly used
  the nominal constructor in a binding pattern; corrected to field patterns
  under their declared `Point` parameter type before publication.
- `record_binding_stages.fwp` passes raw/optimized retained interpretation
  (0.36s): outputs `argument`, `12`, `(13, 14, (0, 10))`, then overflow exit 101
  without executing the later argument. Removed an invalid first-arrow effect
  annotation during fixture construction; the language permits effects only on
  the final arrow, so first-stage failure is tested with checked overflow.
- Fixture formatting passes (0.01s). Candidate native behavior is not yet claimed.
- Production benchmark log `/private/tmp/fwp-241-production-bench-final.log`
  audited without unexpected diagnostics; release/allocation controls pass.

The focused workflow now runs optimizer unit tests and adds existing
`closure_ownership` and `compiler_call_liveness` targets to the previous eight.
No new integration-test target or primitive contract was introduced.

Focused run `41386463046` at `8677dd0a` finished on GCC ARM64
`125088289043`, GCC AMD64 `125088289194` and Clang macOS ARM64
`125088288963`. Each passes all nine optimizer unit tests and 48 integration
tests, including every new semantic/count/unwind check. Five older
`compiler_call_liveness` probes fail before execution: main-only compilation
removes entries that their C harnesses call directly after `attempt` specialization.
All three logs audited; no other failure or compiler warning was found.

Repair: export the harness-called `guard`, `hold` and `pair` functions and compile
with explicit main+export roots. Preserve ordinary main-only executable versus
interpreter comparisons and all ownership/cancellation assertions. Retain input
and generated C before entry lookup, with a named missing-entry diagnostic.
Guarded Rust formatting passes (2.13s); native repair verification is pending.
Candidate documentation `41386462403` passes.
