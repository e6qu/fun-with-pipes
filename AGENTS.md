# Working on fwp

Read [PLAN.md](PLAN.md), [docs/development-state.md](docs/development-state.md)
and the relevant part of [docs/design.md](docs/design.md) before changing code.
The state file is the handoff between sessions; update it after meaningful
progress with actual checks, unresolved failures and the next concrete action.
Do not treat an implemented change or a skipped test as verified support.

## Current direction

The user authorized completing the active roadmap automatically, one focused
PR at a time, with full CI before each squash merge and the commit format
below. Failing tests are tasks to fix; queued CI gates merging, not roadmap
work. Diagnose failures and prepare the next task while CI runs. Keep later
changes separate and open the next PR after the current one merges. This authorization covers roadmap branch publication, PR creation,
fixes and merges; keep later sessions within that scope and do not request
the same permission again. Maintain the plan and handoff throughout. A queued,
skipped or superseded CI run is not a passing gate for the current PR head.

Finish native macOS support, then runtime ownership contracts, numeric
representation and measured compiler/autodiff improvements, in that order.
[docs/ownership.md](docs/ownership.md) records the memory design and its
acceptance criteria. Windows, new deployment interfaces and a new compiler
backend are deferred unless the user changes priorities.

Preserve tacit, curried, data-last pipes, immutable value semantics, tracked
effects, checked arithmetic and observable evaluation/trap order. Infer
ordinary types strongly; keep explicit generic signatures and compile-time
specialization. Prefer compiler-internal ownership over new surface syntax.
Compare interpreter and native behavior for every semantic change.

## Work and validation

- Work on a branch, keep pull requests focused, and update relevant docs.
- Keep local checks serial and low priority. Use focused checks locally;
  run full builds, full test gates, benchmarks and large regeneration on
  GitHub runners. Monitor workloads; stop rather than increase limits.
  Preserve 64 GiB free disk, generated target data below 2 GiB, and sampled
  aggregate RSS below 1 GiB per local workload.
- The user's fun-refactor-specific guard remains
  `python3 /Users/zardoz/.codex/tools/fr-local-guard.py COMMAND...` for local
  fr invocations and checks. It targets a different repository; do not run
  it against fwp or change its limits. Use an equivalent bounded check for
  fwp, and record the command and outcome in the handoff.
- Memory changes need GC stress/verification and reuse verification on CI.
  Performance claims need equivalent workloads and recorded hardware,
  compiler, flags, allocations and live memory as well as elapsed time.
- Every commit message is exactly one line, at most 80 characters, with no
  body, trailers or AI attribution. Use ordinary Git author metadata.
  When authorized to merge, wait for passing CI and squash-merge with an
  explicitly supplied subject and empty body.

Repository conventions and test locations are in [CONTRIBUTING.md](CONTRIBUTING.md).
