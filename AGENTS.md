# Working on fwp

Keep this file under 100 lines; detailed guidance belongs in the linked docs.

## Start and resume

Read [PLAN.md](PLAN.md), [the handoff](docs/development-state.md) and relevant
[design](docs/design.md) sections before changing code. Keep one current next
action in the handoff, with actual checks, unresolved failures and source IDs.
Remove obsolete directions. [History](docs/roadmap-history.md) and immutable
[preparation anchors](docs/roadmap-queue.md) are evidence, not a backlog.
Use [CONTRIBUTING.md](CONTRIBUTING.md) for repository conventions and test locations.

## Language and performance goals

- Remove tracing garbage collection (GC). Prefer compile-time ownership, moves,
  borrowing, stack storage and unique reuse; reserve automatic reference
  counting (ARC) for necessary sharing. Never substitute tracing or permanent
  retention for a rejected lifetime proof.
- Preserve simple tacit, curried, data-last pipes, single-argument functions,
  strong ordinary inference, explicit generic signatures and specialization.
  Keep immutable values, tracked effects, checked arithmetic and evaluation/trap
  order. Compare interpreter and native behavior for semantic changes.
- Pursue zero-cost abstractions, little heap use, compact aligned data and good
  register/cache use. Improve close-to-metal numerics and autodiff precision,
  speed and memory scaling. Select optimizations from representative measurements.
- Prefer compiler-internal ownership over new syntax. Avoid needless wrappers,
  fallbacks, magic, implicit conversions and defaults. Register spills are normal
  allocation decisions; protocol alternatives are peers, not fallbacks.
- JIT compilation is excluded, not deferred. Do not add it to fwp or its runtime.
  A replacement backend and distributed execution are outside scope.
- A completed PR does not complete the roadmap. [Ownership](docs/ownership.md)
  records contracts and evidence; implemented code alone is not verified support.

## Early pre-alpha: no backward compatibility requirement

Source APIs, internal layouts, calling conventions, binary formats and the ABI
may change. Do not preserve old representations or add adapters, wrappers,
fallbacks or migration paths solely for older code or already compiled binaries.
Rebuild affected programs/libraries with the matching compiler, and update tests,
examples and docs together. Preserve agreed semantics, memory safety and correct
implementation of currently supported external protocols.

## Delivery and acceptance

- Work on a branch. Bundle coherent changes into substantial PRs, one active PR
  at a time. Fix discovered bugs, including unrelated ones; failing tests are work
  to fix. Queued CI gates merging, not independent progress.
- Before pushing a CI repair, audit every failed job and completed test target,
  fix underlying causes and check affected callers. Batch all known fixes into
  one push; preserve passing final heads while their remaining gates run.
- Standing authorization covers fixes, publication and squash merge after all
  final-head gates pass. Do not ask for the same permission again.
- Require nine production jobs for the exact commit: Linux ARM64/AMD64, regular
  and GC-stress macOS ARM64/AMD64, native Windows ARM64/AMD64, and C/Rust benchmarks;
  also require the documentation audit. Preserve coverage as ownership evolves.
  Skipped or emulated checks do not establish native support.
- Memory changes need failure/cancellation, GC stress/verification and reuse
  checks. Replace collector-specific checks only with tested ownership guarantees.
  Inspect actual binaries for representation and tracing-removal claims.
- Every commit message is exactly one line, at most 80 characters, with no body,
  trailers, AI attribution, `Co-authored-by` or `Authored-by`. Use ordinary author
  metadata. Squash-merge with an explicit subject and empty body; verify the result.
- Package one binary per OS/architecture. Universal binaries are not a goal.

## Protect local interactivity

Use `python3 scripts/local-guard.py COMMAND...` for focused fwp checks, serially
and at low priority; record commands/results in the handoff. Full builds, full
suites, benchmarks and large regeneration run on GitHub runners. Preserve 64 GiB
free disk, generated target data below 2 GiB, sampled workload RSS below 1 GiB
and the guard's 180-second deadline. Stop on limits; never raise or bypass them.
The separate `fr-local-guard.py` belongs to fun-refactor; do not use it for fwp.

## Explain and measure clearly

Introduce concepts and notation before examples; explain what each computes and
why its output follows. Use plain explanations, not jargon or acronym lists.
Distinguish implemented behavior, tested support and design goals. Remove stale
or irrelevant docs; update generated library docs through comments/generators.
Benchmarks must identify both implementations, inputs, equivalent work, timing
scope, ratios/extra cost and known differences. Record hardware, compiler, flags,
allocations, live memory and elapsed time. Faster fwp versus older fwp is not proof
of parity with C/Rust. Report code-size and stack costs alongside count savings.
