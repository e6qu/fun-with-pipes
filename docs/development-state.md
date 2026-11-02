# Current work

**Next:** implement the bounded application-through-field-binding simplification
from the [prepared scope](measurements/numeric-callback-bindings.md), add semantic
and ownership coverage, and monitor #241's full production run `41385349559`.

Worktree `/private/tmp/fwp-returned-callables`, branch `numeric-callback-lifetimes`,
base `81aed37265661c0c79e47ca7223b40be2d1fe225`. Preserve unrelated primary-checkout
edits. No compiler change in this preparation. Keep one active PR for this batch.

## Roadmap status

| Step | Status | Evidence / remaining work |
|---|---|---|
| 1 | Verified | Saved C and reproduced IR identify an application outside numeric field bindings; local proof and checks documented before code edits |
| 2 | Pending | Extend only `Opt::apply`; preserve stages, binding order and resource guards |
| 3 | Pending | Add tuple/named-record selection, semantic/count/cleanup and rejected-shape controls; native GCC/Clang focused run |
| 4 | In progress | #241 full matrix running; next batch needs its own final exact-head matrix and documentation |

## Baseline delivery and CI

The user merged #241 after the retention choice was presented, directing continued
work. Treat that as retaining the benefits with unmet limits open, not as passing
the original thresholds. Merge `81aed372` and PR head `45af930e` share tree
`a188f53196b53797719ecbc0e89589517ab4959b`; the squash subject meets the one-line,
80-character/no-trailer rule. Documentation `41375291046` passes; log
`/private/tmp/fwp-241-docs-final.log` has only deliberate runner-control failures.

Full run `41385349559` has all nine jobs running, no reported failed step yet:
Linux ARM/AMD `125084848880`/`125084848907`, regular macOS ARM/AMD
`125084848914`/`125084848899`, ownership macOS ARM/AMD
`125084848670`/`125084848861`, Windows ARM/AMD `125084848959`/`125084849027`,
benchmark `125084848998`. Audit every completed target and warning.
Duplicate merge run `41385360274` was cancelled while queued after verifying tree
identity and no failed jobs. Post-merge docs `41385359961` remains enabled.

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
