# Consumed numeric storage: first verification

[Run 41871437618](https://github.com/e6qu/fun-with-pipes/actions/runs/41871437618)
tests `05f30383f3c95fda30abae7dbad0b63ebdbbad76`. Both Linux jobs fail the
new fixture's formatting check after all compiler and integration tests pass.
These are failed jobs, not completed acceptance. The [Clang job](mac-not-started.json)
was cancelled before any runner or step; GitHub reports hosted-runner capacity
constraints. It establishes no macOS coverage.

| Host | Job | Full artifact inventory |
|---|---|---|
| GCC ARM64 | 126719294035 | [Audit](arm/audit.json) |
| GCC AMD64 | 126719294718 | [Audit](amd/audit.json) |

Each host passes 282 unit tests (four existing ignored) and 103 integration tests
across eighteen targets. Every target log was checked; none contains a warning
or failure. All 660 saved executable images have the expected native architecture.

The ten new probes cover two optimization levels:

- Ordinary execution agrees with both interpreters.
- Exclusive arrays and list prefixes reuse storage; shared roots, shared tails
  and array views preserve aliases. Allocation counts check which path ran.
- Traps, cancellation and allocation failures free partial results and inputs.
- Disabled reuse still produces correct values and releases every owner.
- Deliberately corrupted prefixes fail with status 241; deliberately omitted
  suffix cleanup fails with status 90. Normal probes return zero.

The saved C also confirms that all five exported test functions call their
consuming entries. Merely retaining unused helper definitions would not pass.

The formatter removes redundant parentheses around list elements and wraps two
long pipes. The repair matches both runners' `formatted-fixture.fwp` byte for
byte. Compiler/runtime code is unchanged by this repair. The next verification
also checks the measurement fixture's retained-input exclusion before timing.

Each host directory retains the full job log, job/artifact identity, complete
artifact hash inventory, and `controls.zip` containing target logs, the ten new
probes, source-selection evidence and formatter output. `retained-files.json`
records the retained file hashes. The larger original archives remain identified
by `artifact.json`; no failed result is removed or relabeled.

This checks values and ownership, not speed. The [contract](../owned-numeric-updates.md)
still requires a whole-solve allocation census, compiler-cost measurements,
runtime comparisons, Clang coverage and the final production matrix.
