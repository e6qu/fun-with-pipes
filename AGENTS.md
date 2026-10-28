# Working on fwp

Keep this file under 100 lines; detailed guidance belongs in the linked docs.

## Start and resume

Read [PLAN.md](PLAN.md), [the handoff](docs/development-state.md) and relevant
[design](docs/design.md) sections before changing code. Keep one current next
action in the handoff, with actual checks, unresolved failures and source IDs.
Remove obsolete directions. [History](docs/roadmap-history.md) and immutable
[preparation anchors](docs/preparation-records.md) are evidence, not a backlog.
Use [CONTRIBUTING.md](CONTRIBUTING.md) for repository conventions and test locations.

## Language and performance goals

- Keep tracing garbage collection (GC) removed. Prefer compile-time ownership, moves,
  borrowing, stack storage and unique reuse; reserve automatic reference
  counting (ARC) for sharing. Follow the [accepted direction](docs/gc-removal-design.md):
  explicit weak links, reject unproved owning cycles, regions for bounded work.
  Never replace a rejected lifetime proof with tracing or permanent retention.
- Preserve simple tacit, curried, data-last pipes, single-argument functions,
  strong ordinary inference, explicit generic signatures and specialization.
  Keep immutable values, tracked effects, checked arithmetic and evaluation/trap
  order. Compare interpreter and native behavior for semantic changes.
- Pursue zero-cost abstractions, little heap use, compact aligned data and good
  register/cache use. Improve close-to-metal numerics and autodiff precision,
  speed and memory scaling. Select optimizations from representative measurements.
- Prefer compiler-internal ownership over new syntax. Avoid needless wrappers,
  fallbacks, magic and implicit conversions. Require explicit parameters and
  settings for toolchains, targets and execution policy; avoid hidden defaults.
  Register spills are normal allocation decisions; protocol alternatives are
  peers, not fallbacks. Backward compatibility is not a requirement.
- JIT compilation is excluded, not deferred. Do not add it to fwp or its runtime.
  A replacement backend and distributed execution are outside scope.
- A completed PR does not complete the roadmap. [Ownership](docs/ownership.md)
  records contracts and evidence; implemented code alone is not verified support.

## Early pre-alpha: no backward compatibility requirement

All APIs, layouts, calling conventions and binary formats may break freely.
Builds must not depend on a previous fwp version or self-hosting. Do not add adapters,
fallbacks or migration paths solely for older code or already compiled binaries.
Rebuild affected programs/libraries with the matching compiler, and update tests,
examples and docs together. Preserve agreed semantics, memory safety and correct
implementation of currently supported external protocols.

## Delivery and acceptance

- Work on a branch. Bundle coherent changes into substantial PRs, one active PR
  at a time. Fix every encountered issue immediately, including unrelated or
  pre-existing issues, regardless of who caused them. Do not hide or defer fixes;
  record the repair and verification. Queued CI gates merging, not independent work.
- Group related roadmap work and docs in one PR. Use necessary focused checks while
  implementing; run the complete final-head matrix after the batch is ready.
- Audit failed steps while jobs run, then every completed target and compiler
  diagnostic, including warnings in passing logs. Fix causes and affected callers.
  Batch known fixes in one push; preserve passing heads as remaining gates run.
- Contract changes must pass the primitive inventory against its frozen baseline;
  new test targets must pass the native shard coverage check before publication.
- Focused checks must use the production compilers and optimization settings.
  Passing Clang tests does not verify GCC, especially for binary inspection.
- Standing authorization covers fixes, publication and squash merge after all
  final-head gates pass. Do not ask for the same permission again. Continue
  through PLAN.md in substantial groups after each verified merge, keeping one
  active PR and the handoff current until the roadmap acceptance criteria hold.
- Require nine production jobs for the exact commit: Linux ARM64/AMD64, regular
  and ownership/corpus macOS ARM64/AMD64, native Windows ARM64/AMD64, and C/Rust benchmarks;
  also require the documentation audit. Preserve coverage as ownership evolves.
  Skipped or emulated checks do not establish native support.
- Memory changes need failure/cancellation, exact owner and physical-free checks,
  reuse controls and the full golden corpus. Preserve verified collector-free coverage.
  Inspect actual binaries for representation and tracing-removal claims.
- Every commit message is exactly one line, at most 80 characters, with no body,
  trailers, AI attribution, `Co-authored-by` or `Authored-by`. Use ordinary author
  metadata. Squash-merge with an explicit subject and empty body; verify the result.
- Package one binary per OS/architecture. Universal binaries are not a goal.
- Keep Python `__init__.py` files empty; do not add or modify `__all__`.
  Import from defining modules. Keep imports at the top of files, never inside
  functions or methods; platform-specific imports belong in the top import block.

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
