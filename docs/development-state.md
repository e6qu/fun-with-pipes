# Session handoff

## Current preparation

Branch `native-kernel-contracts`, worktree `/private/tmp/fwp-native-kernel-contracts`,
starts at `f2b5d400`, including the Windows observer repair. No PR or CI
acceptance exists for this group.
PR #190 and the await/scope group precede it; their immutable sources and receipts
are recorded in the primary workspace handoff. Keep one delivery PR at a time.

Remove the runtime OpenCL compiler to enforce the no-JIT policy; keep CPU kernels,
remove obsolete GPU APIs and validate CPU worker counts explicitly (1–256).
Preserve CPU arithmetic order, cleanup, allocation controls and immutable evidence.
Migrate instrumentation off the removed OpenCL cleanup function without removing
ownership observations. Update examples and generated library docs together.

## Next checks

Next: publish this preparation for Linux AMD64 and both WASM hosts using the
`kernels` suite. Then audit every complete log, repair failures and extend to the
six native hosts. No second delivery PR while #190 is open. All seven project
areas remain open. The await group runs `39678830873` at `f2b5d400`; its previous
full run `39675022652` is still being audited after the Windows header failures.

Guarded local checks pass:

- `/private/tmp/fwp-check-cpu-contracts.py`: formatting, generated library docs,
  workflow lint, declaration inventory and documentation audit. The inventory has
  392 declarations; removing two GPU primitives leaves no coarse review bucket.
  That is not a proof that all programs have safe tracing-free lifetimes.
- `/private/tmp/fwp-probe-cpu-contracts.py`: current C executor in prior generated
  runtime metadata, macOS ARM64 O1. Invalid counts allocate nothing. Normal
  cleanup passes; omitted input/output cleanup each exits 248 as required.
- `/private/tmp/fwp-check-kernel-schedule.py`: eleven runner tests pass; all
  remaining integration targets still have exactly one native shard assignment.

Run those scripts through the primary `scripts/local-guard.py`. No full local
compiler build was performed. New library type checking, interpreter/native
agreement and platform acceptance remain CI work. The historical kernel baseline
is unchanged and its section delimiters remain explicit in the comparison test.

## Delivery rules

Use the primary workspace's local guard; full builds and suites stay on runners.
Require nine exact-head production jobs and documentation before squash merge.
Commit messages are one line, at most 80 characters, with no body or trailers.
Continue [PLAN.md](../PLAN.md) after acceptance; no JIT or compatibility layer.

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
