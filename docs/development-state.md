# Session handoff

## Next action

Next: publish the combined CPU/foreign-bridge repair, run its Linux AMD64 and
both WebAssembly preflights, audit every complete log, then extend to six native
hosts. Merge #190 only after its exact-head gates pass. The next delivery PR will
combine await fields, State/Jacobian repairs, raw-buffer cleanup, CPU execution
and foreign-call preparation. Keep one active delivery PR; continue all seven
areas of [PLAN.md](../PLAN.md) after each accepted merge.

## Current sources

- Delivery [#190](https://github.com/e6qu/fun-with-pipes/pull/190): head
  `4cdf8afa8647cfdaecbc338429bf8a1c1a158210`, production `39673092514`, docs
  `39673088884`. Benchmark, four macOS jobs and documentation pass; Linux and
  Windows jobs remain running. Auditor `/private/tmp/fwp-audit-190-final.py`;
  merger `/private/tmp/fwp-merge-190.py` requires all ten accepted checks.
- Await measurements: `f2b5d400fedaca3a24208cd3bcdf08f2ebe51c61`, immutable tag
  `roadmap/revision-await-fields-f2b5d400feda`, run `39678830873`.
  Linux ARM64, Windows ARM64 and both WebAssembly jobs pass; four native jobs
  remain running. Auditor `/private/tmp/fwp-audit-task-await-observer.py`.
  Preserve this source for binary/count comparisons; do not open a separate PR.
- Combined branch `native-kernel-contracts`, worktree
  `/private/tmp/fwp-native-kernel-contracts`, includes that await source.
  Published CPU source `4ce0f3aa93349a098d850fe175c6e8ceab4b1867`, tag
  `roadmap/revision-cpu-contracts-4ce0f3aa9334`, run `39678998800`, failed.
  All three complete logs are audited. Repairs below are uncommitted.

## Changes and failures

Immediate `task.await | match` can carry fields directly, avoiding temporary
Some boxes. The matched control restores 34 boxes. State partial captures retain
creation-scope information; Jacobian output counting gets its own tape scope.
The C-interop example frees copied sorting/formatting buffers; omitted-free
controls must fail. Await measurement helpers are
`/private/tmp/fwp-inspect-task-await-native.py`,
`/private/tmp/fwp-inspect-task-await-wasm.py` and
`/private/tmp/fwp-build-task-await-report.py`. Require passing source logs and
204 native/64 await-module inspections before generating the report.

CPU changes remove runtime OpenCL compilation and obsolete GPU APIs, return
kernel values directly and require worker counts 1–256. Ownership observations
stay at the same teardown boundary after removing the OpenCL cleanup function.
The immutable comparison baseline is unchanged.

The first CPU preflight found three native tests and one test on each WASM host
still calling removed private helpers. One native test defined an IO constant.
Repairs use the public CPU API and an explicit IO function. All other completed
test targets pass. The Linux strict corpus executes 81/86 programs, with two
explicit exclusions and three expected compile errors. This is partial evidence.
Size/sanitizer checks skipped after failure; the repaired workflow runs remaining
checks despite earlier test failures and publishes CPU logs before longer checks.

Interpreter C bridges previously compiled at the first foreign call. The repair
makes interpreter construction fallible and prepares bridges before evaluation;
foreign calls share the prepared library. REPL/debugger foreign-call restrictions
remain explicit. A compiler-launcher regression detects compilation after a file
write and checks that missing compilers fail before any program effect.

## Local checks and acceptance limits

Run focused scripts through the primary workspace's
`python3 scripts/local-guard.py python3 SCRIPT`. Full Rust builds, suites and
benchmarks stay on GitHub runners. No new Rust compiler was built locally.

- `fwp-check-cpu-contracts.py`: formatting, generated library docs, workflow lint,
  frozen inventory and docs checks pass. The inventory has 392 declarations and
  no coarse review bucket; that does not prove all program lifetimes safe.
- `fwp-check-kernel-schedule.py`: eleven runner tests pass, with all native
  integration targets assigned exactly once.
- `fwp-probe-cpu-contracts.py`: current C executor in prior compiler metadata,
  macOS ARM64 O1. Invalid counts allocate nothing; omitted cleanup exits 248.
- `fwp-check-cpu-library.py` and `fwp-check-cpu-worker-example.py`: repaired
  examples pass raw interpretation using the current library/prior compiler.
- `fwp-probe-foreign-preparation.py`: native program returns 7; old interpreter
  reproduces compilation after the file write; launcher control exits 88.
  This validates the regression control, not the new Rust implementation.

Scripts and acceptance receipts are under `/private/tmp`. First CPU publication
and audit: `fwp-cpu-contracts-publication.json`, `fwp-audit-cpu-contracts.py`.
After #190 merges, preserve measured tags and base the combined delivery on that
merge. Require nine final-head production jobs plus documentation before squash.
Use one-line commit subjects ≤80 characters with empty bodies and no trailers.
Preserve 64 GiB free disk, target below 2 GiB and sampled workload RSS below 1 GiB;
never raise or bypass guard limits. Fix every encountered issue.

## Roadmap status

| Step | Status | Remaining work |
|---|---|---|
| 1 | In progress | Remove tracing and prove remaining ownership boundaries. |
| 2 | In progress | Eliminate avoidable functional allocations and count traffic. |
| 3 | In progress | Resolve measured machine-code and performance gaps. |
| 4 | In progress | Improve differentiation time, memory and precision. |
| 5 | In progress | Validate CPU numerical kernels and remove runtime compilation. |
| 6 | In progress | Establish equivalent-work comparisons and budgets. |
| 7 | In progress | Validate larger programs and bounded live memory. |
