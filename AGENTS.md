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

Steps 1–10 are accepted through PR #140 (`09f1a029`). The final follow-up,
[PR #141](https://github.com/e6qu/fun-with-pipes/pull/141), pairs native AD
metadata allocations. Implementation and four-host native evidence are complete;
follow [the handoff](docs/development-state.md) for final validation and merge.
Once PR #141 merges with its required gates, all eleven planned steps are complete.
There is no additional queued implementation task; historical preparation
entries are evidence, not work to replay.

Standing authorization covers publication, fixes and squash merge after all
final-head gates pass. Failing tests are tasks to fix; queued CI gates merging,
not independent work. Do not request the same permission again. Historical
preparation entries are not new work. A new backend, JIT and distributed
execution remain outside scope.

Retain all nine production gates: Linux ARM64/AMD64, regular and GC-stress
ARM/Intel macOS, C/Rust benchmarks and native Windows ARM64/AMD64, plus the
documentation audit. Skipped or emulated tests do not establish native support.
Package one binary per OS/architecture; universal binaries are not an objective.
[docs/ownership.md](docs/ownership.md) records memory contracts and evidence.

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
  When authorized to merge, require all nine exact-head production jobs and
  documentation. Squash-merge with an explicitly supplied subject and empty body.

Repository conventions and test locations are in [CONTRIBUTING.md](CONTRIBUTING.md).
