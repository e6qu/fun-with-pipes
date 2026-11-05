# Passing scalar-constant checks

Source: `37da72171d64dbb53dd87dbc49254f61f3ebf0bd`.
[Focused run](https://github.com/e6qu/fun-with-pipes/actions/runs/42048215807)
and [complete audit](https://github.com/e6qu/fun-with-pipes/actions/runs/42070540044)
pass. Each of Linux ARM64, Linux AMD64 and macOS ARM64 completes:

- 25 native targets, including all four cache-ownership tests.
- 828 retained native images and 844 probe observations.
- Exact-bit O1/O2 checks, cache failure/reentry/cleanup controls, compiler units,
  lint, primitive contracts and complete-program selection checks.

The audit reads every artifact member, checks native image architecture and scans
all logs. Its summary has no unresolved issues. [audit.zip](audit.zip) preserves
logs, per-host receipts and source/observation records; [artifact.json](artifact.json)
records the original artifact ID, size and SHA-256. This verifies correctness;
it does not establish a speedup or replace the final nine production jobs.

The separate [documentation run](https://github.com/e6qu/fun-with-pipes/actions/runs/42051839171)
failed because its collection evidence inventory still expected three cache tests.
The source now contains four. The checker and fixture were updated together;
all eight guarded collection-evidence controls pass, including rejection of an
incomplete three-test summary. The [original full log](docs-failure.log.gz) remains
retained. Other completed docs steps passed; later steps were skipped and still
need the repaired documentation gate.
