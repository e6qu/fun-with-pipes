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

The user authorized all six items in PLAN.md as one combined PR, including
Windows ARM64/AMD64 and actual F16/BF16/F128 implementation. PR #134 merged the implemented subset at `5c0287c`. Keep all remaining work
together on `roadmap-after-134` in one follow-up PR; do not split it into
separate PRs or reopen the merged PR. Earlier deliveries are historical evidence.

Authorization covers implementation, documentation, branch publication, PR
creation, fixes and squash merge after passing final-head CI. Failing tests
are tasks to fix. Queued CI gates merging, not independent implementation.
Do not request the same permission again or reinterpret earlier deferrals as
current scope: Windows and the float migration are now authorized. A new
compiler backend, JIT and distributed execution remain outside this bundle.

Retain all seven existing Linux/macOS production gates and add required native
Windows ARM64/AMD64 tests, ownership/GC stress and standalone packaging before
acceptance. Skipped or emulated tests do not establish native Windows support.
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
  When authorized to merge, require all seven exact-head jobs (Linux ARM64/AMD64,
  bench, regular ARM/Intel macOS and GC stress ARM/Intel) and squash-merge with an
  explicitly supplied subject and empty body.
  Require the documentation audit and the added native Windows gates too.
  The existing seven jobs alone do not establish Windows support.

Repository conventions and test locations are in [CONTRIBUTING.md](CONTRIBUTING.md).
