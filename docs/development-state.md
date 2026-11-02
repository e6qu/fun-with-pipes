# Current work

**Next:** monitor [PR #242](https://github.com/e6qu/fun-with-pipes/pull/242)
after publishing this final evidence-count, probe-path and documentation repair
and marking it ready. Require its exact-head nine production jobs and documentation. Fix every failure before
squash merge. Finish auditing #241 production `41385349559` alongside this work.
The [prepared scope](measurements/numeric-callback-bindings.md) includes these repairs.

Worktree `/private/tmp/fwp-returned-callables`, branch `numeric-callback-lifetimes`,
base `81aed37265661c0c79e47ca7223b40be2d1fe225`. Preserve unrelated primary-checkout
edits. Preparation `e0280ee2` and its pushed protocol tag precede compiler changes.
Keep one active PR for this batch.

## Roadmap status

| Step | Status | Evidence / remaining work |
|---|---|---|
| 1 | Verified | Saved C and reproduced IR identify an application outside numeric field bindings; local proof and checks documented before code edits |
| 2 | Implemented | `Opt::apply` accepts proved local flat-record reads; global purity and constructor-stage pass unchanged |
| 3 | Verified | All nine optimizer and 72 integration tests pass on GCC ARM64/AMD64 and Clang ARM64, including cleanup-order and harness repairs |
| 4 | In progress | #241 full matrix running; next batch needs its own final exact-head matrix and documentation |

## Baseline delivery and CI

The user merged #241 retaining measured benefits with unmet limits open. Merge
`81aed372` and PR head `45af930e` share tree `a188f53196b53797719ecbc0e89589517ab4959b`.
Its subject meets the commit rule. Docs `41375291046`/`41385359961` pass; audited
logs contain only deliberate runner-control failures. Duplicate production
`41385360274` was cancelled while queued after checking tree identity.

Full run `41385349559`: benchmark passes; all four macOS jobs fail. Audited
255 target logs per architecture: missing entries in caller/runtime/map/filter/zip/reuse
probes, and a 128-byte collection-callback leak. No compiler warnings or other failure.
Each Windows architecture's 55 resource/callback logs shows the same map/filter/zip
roots and collection leak. ARM64's later TLS/executable group fails only the known
caller/runtime probes; its TLS certificate-rejection diagnostic is an expected
control. Linux and Windows jobs still run; audit their remaining steps too.

Jobs: Linux ARM/AMD `125084848880`/`125084848907`, regular macOS ARM/AMD
`125084848914`/`125084848899`, ownership macOS ARM/AMD
`125084848670`/`125084848861`, Windows ARM/AMD `125084848959`/`125084849027`,
benchmark `125084848998`. Logs: `/private/tmp/fwp-241-full-{arm,amd}-logs`,
`/private/tmp/fwp-241-windows-{arm,amd}-logs`, `/private/tmp/fwp-241-mac-*.log`,
`/private/tmp/fwp-241-windows-tls-arm`.

[Measured results](measurements/derivative-record-folds.md) retain all original
count/timing evidence and missed limits; do not rerun unchanged timing sessions.
#239 remains the last fully verified platform baseline.

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

## Verification and repairs

Use `python3 scripts/local-guard.py` for serial focused commands. Full compiler
builds/suites stay on GitHub. No local compiler build was run. Keep 64 GiB free,
target data under 2 GiB, RSS under 1 GiB and the 180s guard.

- Initial run `41386463046`, source `8677dd0a`: all nine optimizer tests and 48
  integration tests pass on GCC ARM/AMD and Clang ARM; five old caller probes
  fail before execution because their entries were removed. Logs fully audited.
- Repair run `41388066920`, source `98bb58fd`: 14 targets on GCC ARM/AMD and
  Clang ARM. Each passes 61 integration tests and all nine optimizer tests.
  Three runtime probes fail because direct export roots omit generic closure
  metadata. Source `60971efd` adds an actual function-value use and checks its
  owned metadata. All three completed logs audited; no other failure/warning.
  Docs `41388066359` passes with only deliberate runner-control diagnostics.
- Focused run `41389582456`, source `60971efd`: Clang ARM `125097795577`,
  GCC ARM `125097795774`, GCC AMD `125097795775` all pass. Each checks nine
  optimizer tests and 72 integration tests across 16 targets, including metadata,
  cleanup-order and reuse repairs. All completed logs audited; no failures,
  ignored tests or compiler warnings. Logs: `/private/tmp/fwp-242-cleanup-*.log`.
- Narrower `41387498848` and docs `41387496768` were cancelled while queued;
  the broader repair replaces them. No passing gate was discarded.
- Reuse probe now roots its direct calls too. A child test process isolates its
  explicit `FWP_STACK=0`/`FWP_VRET=0` settings without global environment mutation.
- Full CI's collection leak is reproduced from #241's retained compiler and
  emitted C. `owned_hof` emitted inline loops before `bind_call` installed live
  caller cleanup. Install it before inline map/set, array and state work;
  ordinary call expressions bind under the same cleanup at their execution point.
- Add captured-array failure cases and an I64 state-overflow cleanup probe.
  Keep exact trap/output, stack on/off, O1/O2 and zero final live storage checks.
  Save C/executables/results before assertions. Focused suite expands to 16 targets.

Local controls: `/private/tmp/fwp-242-leak/`, scripts
`/private/tmp/fwp-242-leak-probe.py`, `fwp-242-cleanup-control.py`,
`fwp-242-state-probe.py`, `fwp-242-state-control.py` (all under `/private/tmp`).
Guarded Clang O1 reproductions: fused map/range, set/range and set/list leak
32/32/160 bytes; moving cleanup before execution gives zero. State overflow
leaks 16/32 bytes with stack/heap closures after restoring State depth; the
same correction gives zero. Two mapped-array failures leave 320/352 bytes with
stack/heap closures; moving cleanup before work gives zero (2.14s control).
These source controls establish cause, not candidate compiler validation.
Commands finish in 0.71–4.41s. Array-error and callback-export fixtures type-check;
raw state overflow gives exit 101 and the expected arithmetic message.

Retained compiler: artifact `compiler-crashes-corpus-macos-15` from #241's run,
path `/private/tmp/fwp-241-full-arm-logs/compiler-crashes-corpus-macos-15/work/fun-with-pipes/fun-with-pipes/target/debug/fwp`,
SHA-256 `9ef9986e260c9594ea5706100a70b56b2017d6acaf52445d0b778f3e159a12c5`.
The artifact contains the compiler only; no compiler crash is reported.
Guarded Rust formatting (2.05s), workflow lint (5.46s) and fixture formatting
(0.01s) pass. Roadmap audit passes (3.54s; 199 link sets, 106 preparation pairs, four steps).

Documentation run `41389582000` found a stale collection evidence count (three
tests versus four after the state regression). The report and synthetic log now
expect four, with an omitted-test rejection control; all eight local report tests
pass. Historical measurement JSON keeps its original counts. No other completed
documentation step failed; later steps did not run after this failure. Final docs
CI must pass the whole workflow. Five repaired caller probes also use explicit
`.exe` paths for Windows; final full CI verifies these path-only changes.

Final guarded checks: roadmap audit passes (2.77s), Rust formatting passes
(1.87s), collection evidence controls pass (eight tests, 0.13s).
