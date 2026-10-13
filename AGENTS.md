# Working on fwp

Read [PLAN.md](PLAN.md), [docs/development-state.md](docs/development-state.md)
and the relevant part of [docs/design.md](docs/design.md) before changing code.
[docs/roadmap-queue.md](docs/roadmap-queue.md) preserves immutable preparation
anchors; [docs/roadmap-history.md](docs/roadmap-history.md) preserves old evidence.
Keep the live handoff current instead of appending competing old next actions.
The state file is the handoff between sessions; update it after meaningful
progress with actual checks, unresolved failures and the next concrete action.
Do not treat an implemented change or a skipped test as verified support.

## Current direction

The user authorized the active ten-task roadmap as one combined PR, with full
CI before squash merge and the commit format below. This bundle includes the
pending documentation cleanup; do not split its ten tasks into separate PRs. Failing tests are tasks to fix; queued CI gates merging, not roadmap
work. Diagnose failures and prepare the next task while CI runs. Keep later
changes separate and open the next PR after the current one merges. This
authorization covers roadmap branch publication, PR creation,
fixes and merges; keep later sessions within that scope and do not request
the same permission again. Maintain the plan and handoff throughout. A queued,
skipped or superseded CI run is not a passing gate for the current PR head.

The approved six-phase roadmap and iteration/projection follow-ups are merged.
This completes their delivery scope, not general GC-free execution or every
performance goal. PLAN.md records the remaining engineering gaps and recommended
order; the live handoff records current work. Do not reopen archived preparations
or implemented deliveries. The desired platform matrix is Linux, macOS and
Windows, each on ARM64 (aarch64) and AMD64 (x86_64). Windows is deferred on both
architectures; prioritize Linux/macOS, ownership and compiler performance.
Do not treat the original roadmap's completion as universal platform acceptance.
[docs/ownership.md](docs/ownership.md) records the memory design and its
acceptance criteria. Windows, new deployment interfaces and a new compiler backend
remain deferred.
Package one binary per supported OS/architecture; universal binaries are not
an objective and must not be listed as remaining roadmap work.

Preserve tacit, curried, data-last pipes, immutable value semantics, tracked
effects, checked arithmetic and observable evaluation/trap order. Infer
ordinary types strongly; keep explicit generic signatures and compile-time
specialization. Prefer compiler-internal ownership over new surface syntax.
Compare interpreter and native behavior for every semantic change.
Avoid needless wrappers and fallbacks, magic, and unnecessary implicit behavior
or defaults.
Register spills are ordinary allocation decisions, not fallbacks. Alternatives
defined by a protocol are peers, not fallbacks of one another. Make necessary
representation choices and limits explicit and justify them.

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
  it against fwp or change its limits. Use
  `python3 scripts/local-guard.py COMMAND...` for equivalent bounded fwp checks, and record the command and outcome in the handoff.
- Memory changes need GC stress/verification and reuse verification on CI.
  Performance claims need equivalent workloads and recorded hardware,
  compiler, flags, allocations and live memory as well as elapsed time.
- Every commit message is exactly one line, at most 80 characters, with no
  body, trailers or AI attribution. Use ordinary Git author metadata.
  When authorized to merge, require all six exact-head jobs (Linux, bench,
  regular ARM/Intel macOS and GC stress ARM/Intel) and squash-merge with an
  explicitly supplied subject and empty body.
  Extend required gates for the expanded platform matrix as support lands;
  the existing six jobs do not establish Windows or native Linux ARM64 acceptance.

Repository conventions and test locations are in [CONTRIBUTING.md](CONTRIBUTING.md).
