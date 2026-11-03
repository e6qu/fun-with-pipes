# Direct scalar array callbacks: verification

The [contract](../direct-array-callbacks.md) compares direct calls with the same
compiler using generic callback application. Focused native verification passes;
[compiler costs](../direct-array-analysis-2026-11-03/README.md) also pass; runtime
[measurements and all four raw audits](../direct-array-time-2026-11-03/README.md)
are complete, retaining every missed speed/noise limit.

## Verified native behavior

Run [41646433358](https://github.com/e6qu/fun-with-pipes/actions/runs/41646433358)
at `5e921fb8517d59cfa0ef452c2c2264ffa00be325` passes on GCC Linux ARM64/AMD64 and
Clang macOS ARM64. [The retained index](verified/index.json) links every full job
log, target log, generated source, observation and native image identity.

Each host passes:

- 40 tests across all eight affected targets.
- 24 export-selection checks: seven selected and five excluded functions, each
  with ordinary and packed array storage. Independent review of the retained C
  confirms direct calls and no generic application in selected bodies.
- Eight native semantic cases: values/traps × two storage modes × O1/O2. Raw and
  optimized interpreters agree with native execution. Complete output, errors and
  exit status also match across all three hosts.
- Ten cleanup observations: normal and disabled reuse succeed at O1/O2; omitted
  buffer, scratch and partial-result release fail with the expected exit 90.
  Successful runs cover nine modes, four alias combinations and sixteen rounds.
  The callback counters require one direct invocation per visited element and
  zero generic applications during the selected map.

All 762 saved native images have matching architecture headers and recorded
hashes: 256 on each Linux host and 250 on macOS. Both GCC construction reports
pass. These checks establish correctness and cleanup for the tested cases;
the separate [runtime report](../direct-array-time-2026-11-03/README.md) verifies
unchanged whole-solve allocation/ARC profiles and reports speed limits separately.

## First focused run

Run [41638033527](https://github.com/e6qu/fun-with-pipes/actions/runs/41638033527)
failed on Linux ARM64/AMD64 and macOS ARM64 at `8537e7a9`. All three complete job
logs and metadata are retained here; [the audit](first-audit.json) records hashes
and failed steps. No native test target ran.

- **Compiler error:** the generated C initializer's closing brace was not escaped
  in Rust's format string. Escape the brace; this changes no ownership policy.
- **Evidence error:** an early compiler failure left no artifact directory. Record
  source/host/compiler identity before checks and retain formatting, lint and build
  logs. Run native checks independently when the compiler builds, even if lint
  fails; each failure still fails the job.

## First native verification

Run [41640932807](https://github.com/e6qu/fun-with-pipes/actions/runs/41640932807)
at `36bfee09` builds successfully on all three hosts. Each passes 39 tests and
fails the new export-selection inspection; all 24 target logs and all saved native
images are audited. [The retained index](native-attempt/index.json) links full job
logs, target logs, cleanup C/output, archive identities and image hashes.

The test compiled only `main`, then searched generated C for every exported
function. Main-only optimization can legitimately inline or remove those entries.
Inspect selection using an explicit `--fn small` build, which retains exported
roots. Keep the ordinary main build for interpreter/native output comparisons.
Save generated C before assertions and print compiler diagnostics as text.
This repair changes the test, not the compiler implementation.

All ten direct-map cleanup observations per host pass: ordinary and disabled-reuse
runs exit 0 at O1/O2; omitted buffer, scratch and partial-output cleanup each exit
90 at the detected leak. The successful controls exercise nine modes and four
alias combinations over sixteen rounds.
The corrected numeric-value/selection test passes in the verified run above.
The runtime report distinguishes verified speed gains from unchanged storage
counts and unresolved performance limits.

## Runtime evidence and documentation repairs

The initial runtime audit found an omitted reference upload; the draft docs
check found a stale collection-test count. [Causes, complete logs and repairs](evidence-repair/README.md)
retain both failures. All exact-reference recoveries and original-sample audits
now pass; no measured session was repeated.
