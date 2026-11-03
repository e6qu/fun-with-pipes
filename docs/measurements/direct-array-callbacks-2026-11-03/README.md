# Direct scalar array callbacks: verification

The [contract](../direct-array-callbacks.md) compares direct calls with the same
compiler using generic callback application. Timing has not started.

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
The incomplete numeric-value/selection test still needs a passing run. No new
performance or memory improvement is claimed yet.
